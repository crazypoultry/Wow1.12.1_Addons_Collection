CompareStats_Version = "1.1";
CSUpdate = false;

-- On load function to hook the tooltip and add a loaded message. Hooks to GFWTooltip.lua for Tooltip handling.
function CompareStats_OnLoad()
	DEFAULT_CHAT_FRAME:AddMessage(COMPARESTATS_LOAD_MESSAGE .. CompareStats_Version);
	
	GFWTooltip_AddCallback("CompareStats", CompareStats_HookTooltip);
	
end;

function CompareStats_OnUpdate()

	-- Check if the item that is moused over is the same as the last item.  This is basicly to defeat the on_update clearing the tooltip
	if(link ~= CSLastLink) then
		CSUpdate = false;
		BonusScanner.CheckForBonusPlease = 1;
	end
	
	if(lastAltState ~= IsAltKeyDown()) then
		lastAltState = IsAltKeyDown();
		if(lastAltState) then
			CSAltDown = true;
			CSUpdate = false;
			BonusScanner.CheckForBonusPlease = 1;
		else
			CSAltDown = false;
			CSUpdate = false;
		end
	end
end;

-- Main function
function CompareStats_HookTooltip(frame, name, link, source)
	
	-- The itemref tooltip passes the item's hyperlink, but everything else passes the item's link; so here we convert everything else to a hyperlink
	if(source ~= "ITEMREF") then
		link = CSHyperlinkFromLink(link);
	end
	
	-- If we've already done everything then just show the tooltip data
	if(CSUpdate == true) then
		CompareStats_Display(frame);
	end
	
	-- Checks to make sure that the link is valid and that we haven't already done our calculations.  Also we don't want to do anything
	-- if we are moused over equipped items.  This has the side effect of disabling the tooltip in the main bank window as well, but not bank bags.
	if(link ~= nil and CSUpdate == false and source ~= "INVENTORY") then
		
		CSLastLink = link;
		-- Get needed info for the item
		local itemName,_,_,_,itemType,_,_,itemEquipLoc = GetItemInfo(link);
		
		-- Reset our variables
		local bonuses = false;
		local oldbonuses = false;
		local otherbonuses = false;
		local Oldlink = 0;
		local slotID = nil;
		local olditemId = nil;
		local otherslotID = nil;
		local otherOldlink = 0;
		local otherolditemId = nil;
		CSCompare = "";
		
		-- We only care about armor and weapon items
		if(itemType == CS_ARMOR or itemType == CS_WEAPON) then
			
			-- Take the moused over item's equipment location and use it to determine the character sheet slot ID.
			slotID = CompareStats_GetSlotID(CompareStats_itemLocations[itemEquipLoc]);
			-- Using the slotID get the item link of the currently equiped item.
			Oldlink, olditemId = CompareStats_GetOldItem(slotID);
			-- Get the name of the old item and equipment location (Yes, we know this already but it's important for later that we know specificly
			-- how this item maps to it's location
			if(olditemId) then
				olditemname,_,_,_,_,_,_,oldItemLoc = GetItemInfo(olditemId);
			end
			
			if(CSAltDown and oldItemLoc ~= "INVTYPE_2HWEAPON") then
				-- If the item is a One-Hand weapon then change the location to the off hand slot
				if(itemEquipLoc == "INVTYPE_WEAPON") then
					itemEquipLoc = "INVTYPE_WEAPONOFFHAND";
					-- Get the slot ID of the alternate item
					slotID = CompareStats_GetSlotID(CompareStats_itemLocations[itemEquipLoc]);
					-- Using the slotID get the item link of the currently equiped item.
					Oldlink, olditemId = CompareStats_GetOldItem(slotID);
					-- Get the name of the old item and equipment location (Yes, we know this already but it's important for later that we know specificly
					-- how this item maps to it's location
					if(olditemId) then
						olditemname,_,_,_,_,_,_,oldItemLoc = GetItemInfo(olditemId);
					end
					CSCompare = "(Alt)";
				end
				
				-- Make the location the second ring slot
				if(itemEquipLoc == "INVTYPE_FINGER") then
					itemEquipLoc = "INVTYPE_FINGER_OTHER";
					-- Get the slot ID of the alternate item
					slotID = CompareStats_GetSlotID(CompareStats_itemLocations[itemEquipLoc]);
					-- Using the slotID get the item link of the currently equiped item.
					Oldlink, olditemId = CompareStats_GetOldItem(slotID);
					-- Get the name of the old item and equipment location (Yes, we know this already but it's important for later that we know specificly
					-- how this item maps to it's location
					if(olditemId) then
						olditemname,_,_,_,_,_,_,oldItemLoc = GetItemInfo(olditemId);
					end
					CSCompare = "(Alt)";
				end
				
				-- Make the location the second trinket slot
				if(itemEquipLoc == "INVTYPE_TRINKET") then
					itemEquipLoc = "INVTYPE_TRINKET_OTHER";
					-- Get the slot ID of the alternate item
					slotID = CompareStats_GetSlotID(CompareStats_itemLocations[itemEquipLoc]);
					-- Using the slotID get the item link of the currently equiped item.
					Oldlink, olditemId = CompareStats_GetOldItem(slotID);
					-- Get the name of the old item and equipment location (Yes, we know this already but it's important for later that we know specificly
					-- how this item maps to it's location
					if(olditemId) then
						olditemname,_,_,_,_,_,_,oldItemLoc = GetItemInfo(olditemId);
					end
					CSCompare = "(Alt)";
				end				
			else
				CSCompare = "";
			end
			
			-- If the item equipped is the same as the item moused over then we don't want to do anything
			if(olditemname ~= itemName) then
				-- Get the bonuses of the moused over item
				bonuses = BonusScanner:ScanItem(link);
				
				if(itemEquipLoc == "INVTYPE_HOLDABLE" or itemEquipLoc == "INVTYPE_SHIELD" or itemEquipLoc == "INVTYPE_WEAPON_OTHER" or itemEquipLoc == "INVTYPE_WEAPONOFFHAND" and Oldlink == 0 and not CSAltDown) then
					otherslotID = CompareStats_GetSlotID(CompareStats_itemLocations["INVTYPE_WEAPONMAINHAND"]);
					otherOldlink, otherolditemId = CompareStats_GetOldItem(otherslotID);
					if(otherolditemId) then
						local otherolditemname,_,_,_,_,_,_,otheroldItemLoc = GetItemInfo(otherolditemId);
						if(otheroldItemLoc == "INVTYPE_2HWEAPON") then
							CSCompare = "(Main)";
							Oldlink = otherOldlink;
						end
					end
				end
							
				-- If there was an item equipped then get it's bonuses
				if(Oldlink ~= 0) then
					oldbonuses = {};
					oldbonuses = BonusScanner:ScanItem(Oldlink);	
				end
				
				-- If the item moused over is a 2 handed weapon and the currently equipped item is not then we check if
				-- an item is in the offhand slot and we include it's bonuses, because they will be lost if the 2 handed weapon is equipped
				if(itemEquipLoc == "INVTYPE_2HWEAPON" and oldItemLoc ~= "INVTYPE_2HWEAPON") then
					local otherslotID = CompareStats_GetSlotID(CompareStats_itemLocations["INVTYPE_WEAPONOFFHAND"]);
					local otherOldlink,_ = CompareStats_GetOldItem(otherslotID);
					if(otherOldlink ~= 0) then
						otherbonuses = {};
						otherbonuses = BonusScanner:ScanItem(otherOldlink);
						CSCompare = "(Both)";
					end
				end
				
				-- Take all the bonuses and stir them together		
				CompareStats_GetChanges(bonuses, oldbonuses, otherbonuses);		
					
				-- Taking the combined bonus changes determine calculated stat changes		
				CompareStats_GetCalculations();
				-- Output our results
				CompareStats_Display(frame);

				CSUpdate = true;
				BonusScanner.CheckForBonusPlease = 0;
				return true;
			end
		else
			CSUpdate = false;
			return false;
		end
	end
end;

-- Function to output data to the tooltip defined by the variable "frame"
function CompareStats_Display(frame)

	--CompareStats_Tooltip:ClearLines();
	--CompareStats_Tooltip:SetOwner(GameTooltip, "ANCHOR_PRESERVE");
	
	frame:AddLine("Equipping this will change: " .. CSCompare, 0, 1, 1, 1);
	
	local bonus, i; 
	for i, bonus in BonusScanner.types do
		if(CompareStats_Final[bonus]) then
			if(CompareStats_Final[bonus] >= 0) then
				frame:AddLine(BONUSSCANNER_NAMES[bonus] .. ": " .. CompareStats_Final[bonus], 0, 1, 0);
			else
				frame:AddLine(BONUSSCANNER_NAMES[bonus] .. ": " .. CompareStats_Final[bonus], 1, 0, 0);
			end
		end
	end
	
	if(CompareStats_Calc.health ~= nil) then
		if(CompareStats_Calc.health > 0) then
			frame:AddLine("Hit Points: " .. CompareStats_Calc.health, 1, 1, 0);
		elseif(CompareStats_Calc.health < 0) then
			frame:AddLine("Hit Points: " .. CompareStats_Calc.health, 1, 0.25, 0);
		end
	end
	
	if(CompareStats_Calc.mana ~= nil) then
		if(CompareStats_Calc.mana > 0) then
			frame:AddLine("Mana: " .. CompareStats_Calc.mana, 1, 1, 0);
		elseif(CompareStats_Calc.mana < 0) then
			frame:AddLine("Mana: " .. CompareStats_Calc.mana, 1, 0.25, 0);
		end
	end
	
	if(CompareStats_Calc.AP ~= nil) then
		if(CompareStats_Calc.AP > 0) then
			frame:AddLine("AP: " .. CompareStats_Calc.AP .. " dps: " .. CompareStats_Calc.dps, 1, 1, 0);
		elseif(CompareStats_Calc.AP < 0) then
			frame:AddLine("AP: " .. CompareStats_Calc.AP .. " dps: " .. CompareStats_Calc.dps, 1, 0.25, 0);
		end
	end
	
	if(CompareStats_Calc.dbearap ~= nil and CompareStats_Calc.dcatap ~= nil) then
		if(CompareStats_Calc.dbearap > 0) then
			frame:AddLine("Bear AP: " .. CompareStats_Calc.dbearap .. " Bear dps: " .. CompareStats_Calc.dbeardps, 1, 1, 0);
		elseif(CompareStats_Calc.dbearap < 0) then
			frame:AddLine("Bear AP: " .. CompareStats_Calc.dbearap .. " Bear dps: " .. CompareStats_Calc.dbeardps, 1, 0.25, 0);
		end
		
		if(CompareStats_Calc.dcatap > 0) then
			frame:AddLine("Cat AP: " .. CompareStats_Calc.dcatap .. " Cat dps: " .. CompareStats_Calc.dcatdps, 1, 1, 0);
		elseif(CompareStats_Calc.dcatap < 0) then
			frame:AddLine("Cat AP: " .. CompareStats_Calc.dcatap .. " Cat dps: " .. CompareStats_Calc.dcatdps, 1, 0.25, 0);
		end
	end
	
	if(CompareStats_Calc.RAP ~= nil) then
		if(CompareStats_Calc.RAP > 0) then
			frame:AddLine("RAP: " .. CompareStats_Calc.RAP .. " dps: " .. CompareStats_Calc.Rdps, 1, 1, 0);
		elseif(CompareStats_Calc.RAP < 0) then
			frame:AddLine("RAP: " .. CompareStats_Calc.RAP .. " dps: " .. CompareStats_Calc.Rdps, 1, 0.25, 0);
		end
	end
	
	frame:Show();
end;
	
-- Function to determine our calculated stats. ie, attack power, ranged attack power, etc.	
function CompareStats_GetCalculations()
	local bonus, i;
	-- Setup our variables for the stats we will be calculating.
	CompareStats_Calc = {
		health = nil,
		mana = nil,
		AP = nil,
		dps = nil,
		RAP = nil,
		Rdps = nil,
		dbearap = nil,
		dcatap = nil,
		dbeardps = nil,
		dcatdps = nil
	};
	
	-- Calculate health and mana as well as placing any bonuses for agility, strength or attack powers in variables to be used later.
	if(CompareStats_Final ~= nil) then
		for i, bonus in BonusScanner.types do
			if(CompareStats_Final[bonus]) then
				if(bonus == "STA") then
					local _, race = UnitRace("Player");
					-- Tauren have a racial bonus for health and it is accounted for here
					if(race == CS_RACE_TAUREN) then
						CompareStats_Calc.health = CompareStats_Final[bonus] * 10.5;
					else
						CompareStats_Calc.health = CompareStats_Final[bonus] * 10;
					end
					-- Gnomes have a racial bonus for intellect, but after testing it doesn't seem to affect the amount of mana you earn for
					-- each point of intellect. Therefore I don't need to worry about it.
				elseif(bonus == "INT") then
					if(UnitPowerType("Player") == 0) then
						CompareStats_Calc.mana = CompareStats_Final[bonus] * 15;
					end
				elseif(bonus == "AGI") then
					CompareStats_AGI = CompareStats_Final[bonus];
				elseif(bonus == "STR") then
					CompareStats_STR = CompareStats_Final[bonus];
				elseif(bonus == "ATTACKPOWER") then
					CompareStats_AP = CompareStats_Final[bonus];
				elseif(bonus == "RANGEDATTACKPOWER") then
					CompareStats_RAP = CompareStats_Final[bonus];
				end
			end
		end
		-- If we have any one of 4 stats do the Combat calculations
		if(CompareStats_AGI ~= 0 or CompareStats_STR ~= 0 or CompareStats_AP ~= 0 or CompareStats_RAP ~= 0) then
			CompareStats_Combat();
		end
	else
		return;
	end
end;	

-- Function to calculate the attack power, ranged attack power and dps from attack power for each class	
function CompareStats_Combat()
	local level = UnitLevel("Player");
	local _, Class = UnitClass("Player");
	
	-- Here we are getting the current agility and strength of the player
	local _, StatAGI,_,_ = UnitStat("Player", 2);
	local _, StatSTR,_,_ = UnitStat("Player", 1);
	
	if(CompareStats_AGI ~= 0 or CompareStats_STR ~= 0 or CompareStats_AP ~= 0 or CompareStats_RAP ~= 0) then
		
		-- Take the player's current strength and agility and add the bonuses from the items to them.  By doing the formulas
		-- with the stat values adjusted like this I don't have to worry about talents that modify these two stats.
		local modStr = CompareStats_STR + StatSTR;
		local modAgi = CompareStats_AGI + StatAGI;
		local base, posBuff, negBuff, effective, diff, dps;
		
		--[[
			Explaination of the formulas:
			To determine the change to attack power I use the function UnitAttackPower to get the current attack power value.
			I then do the attack power formula using the modified strength and agility and also add any attack power bonuses from the items.
			I then subtract the players current attack power from the calculated attack power of the formula giving me the difference, this
			value is the increase or decrease of the original attack power.  The ranged attack power formulas work exactly the same.
		--]]
		
		-- Ranged attack power.  Applies only to Rogues, warriors, and hunters (hunter RAP is a little different).
		if(Class == "ROGUE" or Class == "WARRIOR" or Class == "HUNTER") then
			local rbase, rposBuff, rnegBuff = UnitRangedAttackPower("Player");
			if(Class == "ROGUE" or Class == "WARRIOR") then
				CompareStats_RAP = CompareStats_RAP + CompareStats_AP + level + (modAgi * 2) - 20 + rposBuff + rnegBuff;
			else
				CompareStats_RAP = (CompareStats_RAP + (level * 2) + (modAgi * 2) - 20 + rposBuff + rnegBuff) + CompareStats_AP;
			end
		
			local reffective = rbase + rposBuff + rnegBuff;
			CompareStats_Calc.RAP = CompareStats_RAP - reffective;
			CompareStats_Calc.Rdps = CSdps(CompareStats_Calc.RAP);
		end
		
		-- Rogue and Hunter attack power
		if(Class == "ROGUE" or Class == "HUNTER") then
			base, posBuff, negBuff = UnitAttackPower("Player");
			CompareStats_AP = CompareStats_AP + (level * 2) + (modStr + modAgi) - 20 + posBuff + negBuff;
			effective = base + posBuff + negBuff;
			CompareStats_Calc.AP = CompareStats_AP - effective;
			CompareStats_Calc.dps = CSdps(CompareStats_Calc.AP);
		end
		
		-- Paladin and warrior attack power
		if(Class == "PALADIN" or Class == "WARRIOR") then
			base, posBuff, negBuff = UnitAttackPower("Player");
			CompareStats_AP = CompareStats_AP + (level * 3) + (modStr * 2) - 20 + posBuff + negBuff;
			effective = base + posBuff + negBuff;
			CompareStats_Calc.AP = CompareStats_AP - effective;
			CompareStats_Calc.dps = CSdps(CompareStats_Calc.AP);
		end
		
		-- Druid attack power, including cat and bear forms
		if(Class == "DRUID") then
			base, posBuff, negBuff = UnitAttackPower("Player");
			normAPbase = (StatSTR * 2) - 20 + posBuff + negBuff;
			bearAPbase = (StatSTR * 2) - 20 + (level * 3) + posBuff + negBuff;
			catAPbase =  (StatSTR * 2) - 20 + (level * 2) + StatAGI + posBuff + negBuff;
			
			local form_normal = CompareStats_AP + (modStr * 2) - 20 + posBuff + negBuff;
			local form_bear = CompareStats_AP + (modStr * 2) - 20 + (level * 3) + posBuff + negBuff;
			local form_cat = CompareStats_AP + (modStr * 2) - 20 + (level * 2) + modAgi + posBuff + negBuff;
			
			CompareStats_Calc.AP = form_normal - normAPbase;
			CompareStats_Calc.dbearap = form_bear - bearAPbase;
			CompareStats_Calc.dcatap = form_cat - catAPbase;
			
			CompareStats_Calc.dps = CSdps(CompareStats_Calc.AP);
			CompareStats_Calc.dbeardps = CSdps(CompareStats_Calc.dbearap);
			CompareStats_Calc.dcatdps = CSdps(CompareStats_Calc.dcatap);
		end
		
		-- Shaman attack power
		if(Class == "SHAMAN") then
			base, posBuff, negBuff = UnitAttackPower("Player");
			CompareStats_AP = CompareStats_AP + (level * 2) + (modStr * 2) - 20 + posBuff + negBuff;
			effective = base + posBuff + negBuff;
			CompareStats_Calc.AP = CompareStats_AP - effective;
			CompareStats_Calc.dps = CSdps(CompareStats_Calc.AP);
		end
		
		-- Mage, Priest and Warlock attack power
		if(Class == "MAGE" or Class == "PRIEST" or Class == "WARLOCK") then
			base, posBuff, negBuff = UnitAttackPower("Player");
			CompareStats_AP = CompareStats_AP + (modStr -10) + posBuff + negBuff;
			effective = base + posBuff + negBuff;
			CompareStats_Calc.AP = CompareStats_AP - effective;
			CompareStats_Calc.dps = CSdps(CompareStats_Calc.AP);
		end
	end
end;	
	
-- Function to round the dps values to 2 decimal places	
function CSround(aDPS)
	local idp = 2;
	return tonumber(string.format("%."..idp.."f", aDPS));
end;

-- Function to determine dps based on attack power.
-- For every 14 points of attack power (Ranged as well) you get 1 dps
function CSdps (diff)
	if(diff ~= nil) then
		local aDPS = (diff / 14);
		naDPS = CSround(aDPS);
		return naDPS;
	end
end;	
	
-- Function to take the bonuses of the moused over item and the currently equipped item and combine them to get the total changes
function CompareStats_GetChanges(bonuses, oldbonuses, otherbonuses)

	-- Setup variables to hold compared bonuses
	CompareStats_Final = nil;
	CompareStats_Final = {};
	CompareStats_AGI = 0;
	CompareStats_STR = 0;
	CompareStats_AP = 0;
	CompareStats_RAP = 0;
	
	if(oldbonuses ~= false) then
		local bonus, i;
		for i, bonus in BonusScanner.types do
			if(oldbonuses[bonus]) then
				local temp = 0 - oldbonuses[bonus];
				CompareStats_Final[bonus] = tonumber(temp or 0);
			end
		end
	end
		
	if(bonuses ~= false) then
		local nbonus, j;
		for j, nbonus in BonusScanner.types do
			if(bonuses[nbonus]) then
				if(CompareStats_Final[nbonus]) then
					CompareStats_Final[nbonus] = tonumber(CompareStats_Final[nbonus] + bonuses[nbonus] or 0);
				else
					CompareStats_Final[nbonus] = tonumber(bonuses[nbonus] or 0);
				end
			end
		end
	end
	
	if(otherbonuses ~= false) then
		local tbonus, r;
		for r, tbonus in BonusScanner.types do
			if(otherbonuses[tbonus]) then
				local ttemp = 0 - otherbonuses[tbonus];
				if(CompareStats_Final[tbonus]) then
					CompareStats_Final[tbonus] = tonumber(CompareStats_Final[tbonus] + ttemp or 0);
				else
					CompareStats_Final[tbonus] = tonumber(ttemp or 0);
				end
			end
		end
	end
end;
	
function CompareStats_GetOldItem(slotID)
	local cstemp = nil;
	if(slotID) then
		cstemp = GetInventoryItemLink("Player", slotID);
		if(cstemp ~= nil) then
			local _, _, csitemlink, csitemid = string.find(cstemp, "|c%x+|H(item:(%d+):%d+:%d+:%d+)|h%[.-%]|h|r");
			return csitemlink, csitemid;
		else
			return 0;
		end
	else
		return 0;
	end
end;

function CompareStats_GetSlotID(slotName)
	if(slotName) then
		return GetInventorySlotInfo(slotName);
	end
end;	

function CSbreakLink(link)
	if (type(link) ~= 'string') then return end;
	local i,j, itemID, enchant, randomProp, uniqID, name = string.find(link, "|Hitem:(%d+):(%d+):(%d+):(%d+)|h[[]([^]]+)[]]|h");
	return tonumber(itemID or 0), tonumber(randomProp or 0), tonumber(enchant or 0), tonumber(uniqID or 0), name;
end	

function CSHyperlinkFromLink(link)
		if( not link ) then
				return nil;
		end
		_, _, hyperlink = string.find(link, "|H([^|]+)|h");
		if (hyperlink) then
			return hyperlink;
		end
		return nil;
end
