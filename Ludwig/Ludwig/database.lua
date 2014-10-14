--[[
	database.lua
		The database portion Of Ludwig
		
	Available Functions
		Ludwig_GetItems(name, quality, type, subType, equipLocation, minLevel, maxLevel) 
			returns a list Of itemIDs with the given qualities
			
		Ludwig_GetItemsNamedExactly(searchString)
			returns either a list Of an itemID named exactly <searchString>, or returns a list Of ids Of the best matches
				
		Ludwig_GetItemName(itemID, inColor)
			returns the name Of a given itemID, optionally in color
			
		Ludwig_GetHyperLink(itemID)
			returns the hyperlink for a given itemID
			
		Ludwig_GetLink(itemID)
			returns the item:<itemID> format for a given itemID
			
		item:25:0:0:0:0:0:0:0
		
	TODO:
		Any speed improvements
--]]

--[[ constants ]]--
local MAXID = 50000;
local MAXIMUM_LEVEL = 70;

--[[ globals ]]
local db --the database itself
local lw_s --this is a hack to allow for 3 variables when sorting.  Its used to give the name filter

--[[
	Sorting Functions
--]]

--returns the difference between two strings, where one is known to be within the other.
local function GetDist(str1, str2)
	--a few optimizations for when we already know distance
	if str1 == str2 then
		return 0;
	end
	if not str1 and str2 then
		if str2 then
			return string.len(str2);
		end
		return 0;
	end	
	if not str2 then
		return string.len(str1);
	end
	
	return abs(string.len(str1) - string.len(str2));
end

--sorts a list by rarity, either closeness to the searchString if there's been a search, then level, then name
local function LudwigSort(id1, id2)
	local item1 = db[id1];
	local item2 = db[id2];
	
	if item1.quality ~= item2.quality then
		return (item1.quality > item2.quality);
	end	
	if lw_s then
		local dist1 = GetDist(lw_s, item1.name );
		local dist2 = GetDist(lw_s, item2.name );
		
		if dist1 ~= dist2 then
			return dist1 < dist2;
		end
	end	
	if item1.level ~= item2.level then
		return item1.level > item2.level;
	end
	
	return item1.name < item2.name;
end

local function isBetterMatch(id1, id2)
	return GetDist(lw_s, db[id1].name) < GetDist(lw_s, db[id2].name);
end

--[[ 
	Access Functions 
--]]

--this builds up a cached database of item information.
local function GetAllItems(playerName)
	if not db or playerName ~= oldPlayerName then 
		db = {}
	end
	oldPlayerName = playerName;
	
	if not playerName then
		for _, player in pairs(BagnonDB.GetPlayerList()) do
			for bagID = -2, 10 do
				for itemSlot = 1, (BagnonDB.GetBagData(player, bagID) or 0) do
					local link, count = BagnonDB.GetItemData(player, bagID, itemSlot)
					if link then
						local _,_,id = string.find(link, "item:(%d+)")
						id = tonumber(id)

						if not db[id] then
							db[id] = true
						end
					end
				end
			end
		end
	else
		for bagID = -2, 10 do
			for itemSlot = 1, (BagnonDB.GetBagData(playerName, bagID) or 0) do
				local link, count = BagnonDB.GetItemData(playerName, bagID, itemSlot)
				if link then
					local _,_,id = string.find(link, "item:(%d+)")
					id = tonumber(id)

					if not db[id] then
						db[id] = true
					end
				end
			end
		end
	end
end

local oldPlayer
local function GetAllItems(player)
	if not db or (BagnonDB and player ~= oldPlayer) then
		db = {}
	end
	oldPlayer = player
	
	if player and BagnonDB then
		for bag = -2, 10 do
			for slot = 1, (BagnonDB.GetBagData(player, bag) or 0) do
				local link, count = BagnonDB.GetItemData(player, bag, slot)
				if link then
					local _,_,id = string.find(link, "item:(%d+)")
					id = tonumber(id)		
					if not db[id] then
						local name, link, quality, _, minLevel, type, subType, _, loc, texture = GetItemInfo(id)
							
						if name and quality >= (Ludwig_MinQuality or 0) then
							db[id] = { 
								["name"] = name, 
								["quality"] = quality,
								["level"] = minLevel,
								["iType"] = type,
								["subType"] = subType,
								["loc"] = loc,
								["icon"] = texture,
							}
						end
					end
				end
			end
		end
	else
		for id = 1, MAXID do
			if not db[id] then
				local name, link, quality, _, minLevel, type, subType, _, loc, texture = GetItemInfo(id)
				if name and quality >= (Ludwig_MinQuality or 0) then
					db[id] = { 
						["name"] = name, 
						["quality"] = quality,
						["level"] = minLevel,
						["iType"] = type,
						["subType"] = subType,
						["loc"] = loc,
						["icon"] = texture,
					}
				end
			end
		end
	end
end

--returns a list Of item IDs matching the qualities given
function Ludwig_GetItems(name, quality, itemType, subType, equipLoc, minLevel, maxLevel, player)
	if not db or player ~= oldPlayer then
		GetAllItems(player)
	end
	
	if name and name ~="" then
		name = string.lower(name)
		--this is a hack to obtain better performance, we're not filtering searches by closeness for short strings
		if string.len(name) > 2 then
			lw_s = name
		else
			lw_s = nil
		end
	else
		lw_s = nil
		name = nil
	end
	
	local list = {}
	for id, item in pairs(db) do
		local addItem = true
		if quality and item.quality ~= quality then
			addItem = nil
		elseif minLevel and item.level < minLevel then 
			addItem = nil
		elseif maxLevel and item.level > maxLevel then 
			addItem = nil
		elseif itemType and item.iType ~= itemType then 
			addItem = nil
		elseif subType and item.subType ~= subType then 
			addItem = nil
		elseif equipLoc and item.loc ~= equipLoc then 
			addItem = nil
		elseif name then
			local itemName = string.lower(item.name)
			if not(name == itemName or string.find(itemName, name)) then 
				addItem = nil
			end
		end	
		if addItem then
			table.insert(list, id)
		end
	end	
	--this sorting function is the last real performance hit to ludwig
	table.sort(list, LudwigSort)
	
	return list;
end

--Returns either a list containing an itemID for an item named exactly the searchTerm, or it returns a list Of best matches.  Used for linkerator
function Ludwig_GetItemsNamedLike(searchTerm)
	if searchTerm == "" then return; end

	if not db or player then 
		GetAllItems()
	end
	
	searchTerm = string.lower(searchTerm);
	
	local newList = {};
	for i in pairs(db) do
		local name = string.lower(db[i].name);
		if string.find(name, searchTerm)then
			if name == searchTerm then
				return { i };
			else
				table.insert(newList, i);
			end
		end
	end
	
	lw_s = searchTerm;
	
	if newList[1] then
		table.sort(newList, isBetterMatch);
	end
	return newList;
end

--[[ 
	Per Item Access 
		These functions all take an itemID (just a number), and return something about it
--]]

--returns the name of a given item
function Ludwig_GetName(id, inColor)
	if db[id] then
		if inColor then
			local _,_,_,hex = GetItemQualityColor(db[id].quality);
			return hex .. db[id].name .. "|r";
		end
		return db[id].name;
	end
end

--returns a full hyperlink for the item
--format for a link is |cff<color>|Hitem:<id>:0:0:0|h[<name>]|h|r
function Ludwig_GetHyperLink(id)
	if db[id] then
		local _,_,_,hex = GetItemQualityColor(db[id].quality);
		return hex .. "|H".. "item:" .. id .. ":0:0:0:0:0:0:0" .. "|h[" .. db[id].name .. "]|h|r";
	end
end

--returns the full id Of an item, ie "item:w:x:y:z"
function Ludwig_GetLink(id)
	return "item:" .. id .. ":0:0:0:0:0:0:0";
end

function Ludwig_GetTexture(id)
	if db[id] then
		return db[id].icon;
	end
end

--[[
	Config Functions
--]]

--refresh the database
function Ludwig_Reload()
	GetAllItems();
end

--set the maximum amount Of ids to look through.  Yes, this sets a constant's value
function Ludwig_SetMaxID(maxID)
	MAXID = maxID;
end

--set the minimum quality of items to look at
function Ludwig_SetMinQuality(quality)
	Ludwig_MinQuality = tonumber(quality);
end