--
-- MI2_ConvDropRate.lua
--
-- author: NakorNH
-- This DropRate database converter was written and submitted by NakorNH
--
-- This converter will convert all Mobs found in the DropRate database
-- and convert them into entries for the MobInfo2 database. Item data
-- can only be converted if the item can be found in either the
-- ItemSync or KC_Items or LootLink databases (thus either of these
-- AddOns must be installed as well).
--
-- Using LootLink is recommended for the conversion when you are not
-- already using any of the 3 supported item database AddOns. AddOns sites
-- like "http://ui.worldofwar.net" host huge LootLink item databases
-- that ensure a high conversion success rate. After successful
-- conversion LootLink can be uninstalled.
--
-- DropRate is an AddOn invented and coded by canidae. All credits for
-- the idea of collecting Mob loot (and also other loot) in a database
-- and present it in the game tooltip therefore go to canidae. The 
-- original DropRate still exists and can for instance be found here:
-- http://ui.worldofwar.net/ui.php?id=579
--


local MI_CONVERTER = "DR Converter: "
local MI_MOBSFOUND = " Mobs found in DropRate data,"
local MI_NEWMOBSFOUND = " new Mobs added to database,"
local MI_EXISTINGMOBS = " existing Mobs expanded,"
local MI_PARTIALMOBS = " Mobs partially converted,"
local MI_SKIPPEDITEMS = " unknown items skipped,"
local MI_ADDEDITEMS = " items added to database,"


-- add a new item to given mobData
local function MI2_DrAddItem( mobData, name, id, amount )
	local quality = dritems[name]
	if quality == 0 then
		mobData.r1 = (mobData.r1 or 0) + 1
	elseif quality == 1 then
		mobData.r2 = (mobData.r2 or 0) + 1
	elseif quality == 2 then
		mobData.r3 = (mobData.r3 or 0) + 1
	elseif quality == 3 then
		mobData.r4 = (mobData.r4 or 0) + 1
	elseif quality == 4 then
		mobData.r5 = (mobData.r5 or 0) + 1
	elseif quality == -1 then
		quality = 1
	end

	-- process item value
	local value = MI2_FindItemValue( id )
	mobData.itemValue = (mobData.itemValue or 0) + value

	-- add item to MobInfo items table
	if MobInfoConfig.SaveItems == 1 and (quality + 1) >= MobInfoConfig.ItemsQuality then
		if not mobData.itemList then mobData.itemList = {} end
		mobData.itemList[id] = (mobData.itemList[id] or 0) + amount
		if not MI2_ItemNameTable[id] then
			MI2_ItemNameTable[id] = name.."/"..(quality + 1)
		end
	end
end

-----------------------------------------------------------------------------
-- MI2_StartDropRateConversion()
--
-- Scans the DropRate database. Then converts the data and adds it to MobInfo2 database
-----------------------------------------------------------------------------
function MI2_StartDropRateConversion()
	local totalMobs = 0
	local newMobsFound = 0
	local mobsExtended = 0
	local partialMobs = 0
	local itemsSkipped = 0
	local itemsFound = 0

	chattext( MI_CONVERTER.."DropRate conversion started ..." )
	
	if not drdb then
		chattext( "DropRate database not found" )
		return
	end
	
	for mobName, value in pairs(drdb) do
		local notCompleteMob = 0
		local newMobData = {}
		local drMobLevel
		for index , value2 in pairs(value) do
			if index == "level" then
				drMobLevel = value2
				totalMobs = totalMobs + 1
			end
		end	
		
		if drMobLevel then
			for index, value2 in pairs(value) do
				local drItemID = -1
				if index == "level" then
					drMobLevel = value2
				elseif index == "looted" then
					newMobData.loots = value2
					drdb[mobName][index] = nil
				elseif index == "skinned" then
					newMobData.skinCount = value2
					notItem = 1
					drdb[mobName][index] = nil
				elseif index == "money" then
					newMobData.copper = value2
					drdb[mobName][index] = nil
				else
					drItemID = (MI2_drFindItemID(index) or 0)
				end

				-- process all item data entries where an item ID code could be found
				if drItemID > 0 then
					MI2_DrAddItem( newMobData, index, drItemID, value2 )
					drdb[mobName][index] = nil
					itemsFound = itemsFound + 1
				elseif drItemID == 0 then
					notCompleteMob = 1
					itemsSkipped = itemsSkipped + 1
				end
			end -- for

			-- add converted DropRate Mob data to existing MobInfo data
			-- (creates new MobInfo database entry if Mob does not exist)
			local origMobData = MI2_FetchMobData( mobName..":"..drMobLevel )
			if origMobData.loots then
				mobsExtended = mobsExtended + 1
			else
				newMobsFound = newMobsFound + 1
			end	
			MI2_AddTwoMobs(newMobData, origMobData)

			-- adjust type: promote mobs above L-60 to Elite
			if drMobLevel > 60 and newMobData.mobType < 2 then
				newMobData.mobType = 2
			end

			MI2_StoreAllMobData( newMobData, mobName, drMobLevel, MI2_PlayerName )

			-- check if entire DropRate Mob entry has been converted
			local remainingEntries = 0
			for index in pairs(drdb[mobName]) do
				if index ~= "level" then
					remainingEntries = remainingEntries + 1
				end
			end
			if remainingEntries == 0 then
				drdb[mobName] = nil
			end
		end
		if notCompleteMob > 0 then
			partialMobs = partialMobs + 1
		end
		
	end

	MI2_BuildXRefItemTable()

	chattext(MI_CONVERTER..totalMobs..MI_MOBSFOUND)
	chattext(MI_CONVERTER..mobsExtended..MI_EXISTINGMOBS)
	chattext(MI_CONVERTER..newMobsFound..MI_NEWMOBSFOUND)
	chattext(MI_CONVERTER..partialMobs..MI_PARTIALMOBS)
	chattext(MI_CONVERTER..itemsFound..MI_ADDEDITEMS)
	chattext(MI_CONVERTER..itemsSkipped..MI_SKIPPEDITEMS) 
end 

-----------------------------------------------------------------------------
-- MI2_drFindItemID()
--
-- Find the itemID for each item in the database
-----------------------------------------------------------------------------
function MI2_drFindItemID(index)
	-- Find item code from ItemSync
	if ISyncDB_Names then
		for ISItemID, ISItemName in pairs(ISyncDB_Names) do
			if ISItemName == index then
				return ISItemID
			end
		end
	end

	-- Find item code from KC_Items (potentially dangerous : might cause disconnect
	-- when calling "GetItemInfo()" with item ID not known on server)
	if KC_ItemsDB then
		for itemCode, itemInfo in pairs(KC_ItemsDB) do
			local itemName, itemLink = GetItemInfo(itemCode)
			if itemName then
				if itemName == index then
					return itemCode, itemLink
				end
			end
		end
	end
	
	-- Find item code from LootLink
	if ItemLinks then
		if ItemLinks[index] then
			local lootLinkData = ItemLinks[index].i
			local a,b,itemCode,CDRenchantCode,CDRbonusCode,CDRmiscCode = string.find(lootLinkData, "(%d*):(%d*):(%d*):(%d*)")
			return tonumber(itemCode)
		end
	end
	
	return nil
end -- of MI2_drFindItemID

