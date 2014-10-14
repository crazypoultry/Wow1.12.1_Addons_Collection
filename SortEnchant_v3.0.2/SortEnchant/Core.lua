----------------------------------------------------------------------------------------------------
-- SortEnchant by Guvante
--
-- Adds sortability to the enchanting profession window, by hooking into the data gathering methods
-- Used by the Blizzard UI elements, and replacing them with my own data that is sorted and filtered
-- Based on the users choices
--
-- Sorting/Filtering can be done by Armor class, Enchantment type, quality, and number producable
--
-- A quick note about this AddOn, it hooks into nearly every Blizzard API function related to the
-- CraftFrame, and it makes DESCRTUCTIVE changes to its return values, this AddOn should never be
-- Used in conjunction with any other AddOn that attempts to change these same values, as bad things
-- Will happen, and no one knows what the outcome will be
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Class Setup
----------------------------------------------------------------------------------------------------
-- Define our main class object
SortEnchant = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0", "AceHook-2.0", "AceConsole-2.0", "AceDebug-2.0");

-- Define libraries we will be using
local Dewdrop = AceLibrary("Dewdrop-2.0");
local Compost = AceLibrary("Compost-2.0");

--Grab the database of translations for the current spec
local L = AceLibrary("AceLocale-2.1"):GetInstance("SortEnchant", true);

--Register our database with AceDB
SortEnchant:RegisterDB("SortEnchantDB");

--Register default settings
SortEnchant:RegisterDefaults("profile", {
		LowestShown = 1,
		GroupBy     = L.Armor
});

----------------------------------------------------------------------------------------------------
-- Addon Initializing/Enabling/Disabling
----------------------------------------------------------------------------------------------------
function SortEnchant:OnInitialize()
	--Define a debug level to a level that does not completly spam the user with stuff from us
	self:SetDebugLevel(2);

	--Setup our conversion tables
	self.DifficultyTable = {
		trivial = 1,
		easy = 2,
		medium = 3,
		optimal = 4
	};
	self.DifficultyNames = {
		"|cFFF7F7F7" .. L.Grey .. "|r",
		"|cFF3FBF3F" .. L.Green .. "|r",
		"|cFFFFFF00" .. L.Yellow .. "|r",
		"|cFFFF7F3F" .. L.Orange .. "|r"
	};
	self.DifficultyValidate = {
		[string.lower(L.Grey)] = 1,
		[string.lower(L.Green)] = 2,
		[string.lower(L.Yellow)] = 3,
		[string.lower(L.Orange)] = 4
	};
	self.DifficultyToInt = {
	    grey = 1,
		green = 2,
		yellow = 3,
		orange = 4
	};

	self.ArmorSubTypes = {
		INVTYPE_FEET = 1,
		INVTYPE_WRIST = 2,
		INVTYPE_ROBE = 3,
		INVTYPE_CHEST = 3,
		INVTYPE_CLOAK = 4,
		INVTYPE_HAND = 5,
		INVTYPE_SHIELD = 6
	};

	--Setup our graphics table
	self.Graphics = {
		On = "Interface\\Icons\\INV_Jewelry_Talisman_03.blp",
		Off = "Interface\\Icons\\INV_Jewelry_Talisman_04.blp",
		Armor = {
			All = "Interface\\Icons\\INV_Shield_04.blp",
			Some = "Interface\\Icons\\INV_Shield_06.blp",
			One = "Interface\\Icons\\INV_Shield_05.blp"
		},
		Bonus = {
			All = "Interface\\Icons\\INV_Enchant_DustSoul.blp",
			Some = "Interface\\Icons\\INV_Enchant_ShardGlimmeringSmall.blp",
			One = "Interface\\Icons\\INV_Enchant_EssenceMagicSmall.blp"
		},
		Difficulty = {
			["0"] = "Interface\\Icons\\INV_Misc_Gem_Variety_02.blp",
			["1"] = "Interface\\Icons\\INV_Misc_Gem_Emerald_02.blp",
			["2"] = "Interface\\Icons\\INV_Misc_Gem_Topaz_02.blp",
			["3"] = "Interface\\Icons\\INV_Misc_Gem_Opal_01.blp"
		},
		Quantity = {
			Lots = "Interface\\Icons\\INV_Misc_Coin_02.blp",
			Some = "Interface\\Icons\\INV_Misc_Coin_04.blp",
			Any = "Interface\\Icons\\INV_Misc_Coin_05.blp"
		}
	};

	--Define the header displays, which are the text shown for the groupings
	self.HeaderDisplay = {
		[L.Armor] = {
			L.ArmorBoots,
			L.ArmorBracer,
			L.ArmorChest,
			L.ArmorCloak,
			L.ArmorGloves,
			L.ArmorShield,
			L.ArmorWeapon,
			L.ArmorCrafted,
			n = 8
		},

		[L.Bonus] = {
			L.BonusAgility,
			L.BonusIntellect,
			L.BonusSpirit,
			L.BonusStamina,
			L.BonusStrength,
			L.BonusHealth,
			L.BonusMana,
			L.BonusStats,
			L.BonusDefense,
			L.BonusResistance,
			L.BonusDamage,
			L.BonusSpecialty,
			L.BonusProc,
			L.BonusSkil,
			L.BonusSpellPower,
			L.BonusOils,
			L.BonusMisc,
			L.BonusWands,
			L.BonusRods,
			n = 19
		},

		[L.Quantity] = {
			L.QuantityOver10,
			L.Quantity5to10,
			L.Quantity1to4,
			L.QuantityNone,
			n = 4
		},

		[L.Difficulty] = {
			L.Difficulty1,
			L.Difficulty2,
			L.Difficulty3,
			L.Difficulty4,
			n = 4
		}
	}
			

	--Setup our regex for finding enchantment id
	self.EnchantRegex = "|c%x+|Henchant:(%d+)|h%[.*%]|h|r";
	self.ItemRegex    = "|c%x+|H(item:%d+:%d+:%d+:%d+)|h%[.*%]|r";

	--Setup our default user enchant database as an empty one, to ensure all of the erase commands work properly
	self.UserEnchantDB = Compost:AcquireHash("IsInvalidated", true, "IsCollapsed", Compost:Acquire());

	--Setup our chat command interface
	self:RegisterChatCommand({"/sortenchant", "/sorte"},
		{
			type = "group",
			args = {
				lowestshown = {
					type = "text",
					name = L.LowestShown,
					desc = L.LowestShownDesc,
					get = function() return self.DifficultyNames[self.db.profile.LowestShown] end,
					set = function(value) self.db.profile.LowestShown = self.DifficultyValidate[string.lower(value)]; self:UpdateCraftFrame() end,
					usage = "{" .. self.DifficultyNames[1] .. " || " .. self.DifficultyNames[2] .. " || " .. self.DifficultyNames[3] .. " || " .. self.DifficultyNames[4] .. "}",
					validate = function(value) return self.DifficultyValidate[string.lower(value)] end
				},
				groupby = {
					type = "text",
					name = L.GroupBy,
					desc = L.GroupByDesc,
					get = function() return self.db.profile.GroupBy end,
					set = function(value) self.db.profile.GroupBy = value; self.UserEnchantDB.IsCollapsed = Compost:Recycle(self.UserEnchantDB.IsCollapsed); self:UpdateCraftFrame() end,
					validate = {L.Armor, L.Bonus, L.Quantity, L.Difficulty, L.None}
				}
			}
		},
		"SORTENCHANT"
	);

	self:LevelDebug(1, "SortEnchant has been Initialized");
end

function SortEnchant:OnEnable()
	--Reset our saved data if it is from the old version of SortEnchant
	if (not self.db.profile.LowestShown) or (not self.db.profile.GroupBy) then
		self:ResetDB("profile");
	end

	--Catch the event that tell us when something in the Enchanting window changes
	--This event also triggers whenever the window is opened, so we need not worry
	--About any other events
	self:RegisterEvent("CRAFT_UPDATE");

	--Catch the profile change event so we can close the GUI to ensure it is updated
	self:RegisterEvent("ACE_PROFILE_LOADED", "UpdateCraftFrame");

	--Hook into all the functions we will be using
	self:Hook("GetNumCrafts");
	self:Hook("GetCraftInfo");
	self:Hook("ExpandCraftSkillLine");
	self:Hook("CollapseCraftSkillLine");
	self:Hook("SelectCraft");
	self:Hook("GetCraftSelectionIndex");
	self:Hook("DoCraft");
	self:Hook("GetCraftIcon");
	self:Hook("GetCraftDescription");
	self:Hook("GetCraftNumReagents");
	self:Hook("GetCraftReagentInfo");
	self:Hook("GetCraftSpellFocus");
	self:Hook("GetCraftItemLink");
	self:Hook("GetCraftReagentItemLink");
	self:Hook(GameTooltip, "SetCraftItem", "TooltipSetCraftItem");
	self:Hook(GameTooltip, "SetCraftSpell", "TooltipSetCraftSpell");

	self:UpdateCraftFrame();

	self:LevelDebug(1, "SortEnchant has been Enabled");
end

function SortEnchant:OnDisable()
	--Refresh the craft frame to ensure it picks up its new data
	self:UpdateCraftFrame();

	self:LevelDebug(1, "SortEnchant has been Disabled");
end

----------------------------------------------------------------------------------------------------
-- Event Processing
----------------------------------------------------------------------------------------------------
function SortEnchant:UpdateCraftFrame()
	--Make the CraftFrame update itself it has not yet
	if CraftFrame and CraftFrame:IsVisible() then
		--Recreate all data, to ensure nothing changed that we did not track
		if self.IsEnabled then
			self:CreateUserEnchantDB();
		end
		CraftFrame_Update();
	end
end

function SortEnchant:CRAFT_UPDATE()
	self:LevelDebug(2, "CRAFT_UPDATE event fired, invalidating data");
	--Invalidate our db to ensure it is not wrongfully used
	self.UserEnchantDB.IsInvalidated = true;
end

----------------------------------------------------------------------------------------------------
-- User Enchant DB functions
-- Functions for the UserEnchantDB field of our class
--
-- The structure is as follows:
-- TODO: explain it here
----------------------------------------------------------------------------------------------------
--Recreate our temporary data from scratch
function SortEnchant:CreateUserEnchantDB()
	self:LevelDebug(2, "Creating the UserEnchantDB");
	--Clear out the invalidated flag, this is not part of any of the bottom databases
	self.UserEnchantDB.IsInvalidated = false;
	--Clear all of our databases, to ensure that we start fresh
	Compost:Reclaim(self.UserEnchantDB.AllEnchants);
	self.UserEnchantDB.AllEnchants = Compost:AcquireHash("n", 0);
	Compost:Reclaim(self.UserEnchantDB.CurrentList);
	self.UserEnchantDB.CurrentList = Compost:AcquireHash("n", 0);

	local EnchantValue;
	local EnchantId;

	--Insert the type tables of all of the user's enchants into the AllEnchants table
	for i = 1, self.hooks.GetNumCrafts.orig() do
		EnchantId = gsub(self.hooks.GetCraftItemLink.orig(i), self.EnchantRegex, "%1");
		EnchantValue = self.EnchantDB[tonumber(EnchantId, 10)];
		if EnchantValue then
			tinsert(self.UserEnchantDB.AllEnchants, EnchantValue);
		else
			self:Print("Could not find value " .. EnchantId .. " which is part of " .. self.hooks.GetCraftItemLink.orig(i) .. " please contact the author with these details.");
		end
	end

	--Now our basic data has been setup
	--Call the type select function to set up the actual data for the settings the user has chosen
	local SubTables = Compost:AcquireHash("n", self.HeaderDisplay[self.db.profile.GroupBy].n);
	--Define an insert function which avoids nil reference errors
	SubTables.insert = function(self, i, data) if not self[i] then self[i] = Compost:AcquireHash("n", 0); end; tinsert(self[i], data); end;
	local craftData;

	for i = 1, self.UserEnchantDB.AllEnchants.n do
		--Create a table with the data for the current enchant in it
		craftData = Compost:Acquire(self.hooks.GetCraftInfo.orig(i));
		craftData.gameId = i;

		--Only add the data to the sub table if it is visible
		if self:IsVisible(craftData) then
			--Add that data to the appropriate sub table
			if self.db.profile.GroupBy == L.Armor then
				if not self.UserEnchantDB.AllEnchants[i] then
					self:Print(i);
				end
				SubTables:insert(self.UserEnchantDB.AllEnchants[i].armor, craftData);
			elseif self.db.profile.GroupBy == L.Bonus then
				SubTables:insert(self.UserEnchantDB.AllEnchants[i].bonus, craftData);
			elseif self.db.profile.GroupBy == L.Quantity then
				if craftData[4] > 10 then
					SubTables:insert(SubTables[1], craftData);
				elseif craftData[4] > 5 then
					SubTables:insert(2, craftData);
				elseif craftData[4] > 0 then
					SubTables:insert(3, craftData);
				else
					SubTables:insert(4, craftData);
				end
			elseif self.db.profile.GroupBy == L.Difficulty then
				SubTables:insert(self.DifficultyTable[craftData[3]], craftData);
			elseif self.db.profile.GroupBy == L.None then
				tinsert(self.UserEnchantDB.CurrentList, craftData);
			else
				self:LevelDebug("Unknown groupby setting " .. self.db.profile.GroupBy .. " reseting to None", 2);
				self.db.profile.GroupBy = L.None;
				tinsert(self.UserEnchantDB.CurrentList, craftData);
			end
		end
	end

	--If we are sorting by none then we do not need to create the headers, as there are none
	if self.db.profile.GroupBy == L.None then
		Compost:Reclaim(SubTables);
		return;
	end

	local tableExpanded;

	--Convert our sub tables into the final current list that is used to communicate with the craft frame
	for i = 1, SubTables.n do
		if SubTables[i] then
			tinsert(self.UserEnchantDB.CurrentList,{self.HeaderDisplay[self.db.profile.GroupBy][i], "", "header", 0, not self.UserEnchantDB.IsCollapsed[i], 0, 0, headerId = i});
			if not self.UserEnchantDB.IsCollapsed[i] then
				for j = 1, SubTables[i].n do
					tinsert(self.UserEnchantDB.CurrentList, SubTables[i][j]);
				end
			end
		end
	end

	--Note this should be 1 and not 2 as would be intuitive, this is because the lowest layer (CraftData) is used as a table outside
	--Of this function, and should be left alone
	Compost:Reclaim(SubTables, 1);

	--Just to be safe, nil out the refence to the table
	SubTables = nil;
end

--Grabs the inverse of the value stored in memory, because that is the way it is stored there
function SortEnchant:TableExpanded(tableIndex)
	return not self.UserEnchantDB.IsCollapsed[tableIndex];
end

--Checks if the item should be visible, using dropdowns and lowest shown
function SortEnchant:IsVisible(craftData)
	--TODO: Implement filtering

	--If we have a minimum required difficulty, check it here
	if self.DifficultyTable[craftData[3]] < self.db.profile.LowestShown then
		return false;
	end

	--If we got this far, there is nothing to stop the item from being displayed
	return true;
end

----------------------------------------------------------------------------------------------------
-- Misc functions
-- Used by other functions for repeated sets of code
----------------------------------------------------------------------------------------------------
function SortEnchant:CheckSkill()
	--Simply return the first value from this function, as it will be a string in the case of the
	--Enchanting window, or nil in the case of the Beast Training window
	return (GetCraftDisplaySkillLine())
end

function SortEnchant:VerifyUserEnchantDB()
	if self.UserEnchantDB.IsInvalidated then
		self:CreateUserEnchantDB();
	end
end
----------------------------------------------------------------------------------------------------
-- Hooking functions
-- Note that any complicated functions should move the hardest code to another function in the class
-- To make this section as simple as possible (Due to its extreme size)
--
-- A note about why these are being hooked:
-- We are replacing the default return values of a list of items with our own specially formatted
-- List of values, so whenever we call the Blizzard API, we need to overwrite the default value
-- With our own
--
-- Quick note about things that are pretty standard across functions
-- Always check title of display to ensure we are not in the pet window, which uses the same frame
--
-- Note to myself:
-- Need to organize these in some more logical fashion
----------------------------------------------------------------------------------------------------
--------------------------------------------------
-- Function to auto-filter in the case of trading
--------------------------------------------------
function SortEnchant:CraftFrame_Show()
	if TradeFrame:IsVisible() then
		--If this value is non-nil, that means we have an item in the "Do Not Trade" section of the
		--Other player's trade window, because of this, filter by that armor type, since we are
		--Pretty much guarenteed to be wanting to enchant it
		if GetTradeTargetItemLink(7) ~= nil then
			local link = GetTradeTargetItemLink(7)
			local itemId = gsub(link, self.ItemRegex, "%1")
			local _, _, _, _, _, SubType = GetItemInfo(itemId)
		end
	end
end
--------------------------------------------------
-- Overall functions, return basic data
-- Hooked to return data we have instead
--------------------------------------------------
function SortEnchant:GetNumCrafts()
	self:LevelDebug(3, "GetNumCrafts called");
	if not self:CheckSkill() then return self.hooks.GetNumCrafts.orig(); end
	self:VerifyUserEnchantDB();

	--The n only references integer indexed variables, so it gives how
	--Many enchantments we want the GUI to worry about
	return self.UserEnchantDB.CurrentList.n;
end

function SortEnchant:GetCraftInfo(id)
	self:LevelDebug(3, "GetCraftInfo called");
	if not self:CheckSkill() then return self.hooks.GetCraftInfo.orig(id); end
	self:VerifyUserEnchantDB();

	--Simply grab the cache we have for the requested item
	if not self.UserEnchantDB.CurrentList[id] then
		return nil;
	else
		return self.UserEnchantDB.CurrentList[id][1], self.UserEnchantDB.CurrentList[id][2], self.UserEnchantDB.CurrentList[id][3],
				self.UserEnchantDB.CurrentList[id][4], self.UserEnchantDB.CurrentList[id][5], self.UserEnchantDB.CurrentList[id][6],
				 self.UserEnchantDB.CurrentList[id][7];
	end
end

--------------------------------------------------
-- Expansion code, change expanded/contracted for
-- Various headers, not supported in default
-- Enchanting environment, so we support them here
--------------------------------------------------
function SortEnchant:ExpandCraftSkillLine(id)
	self:LevelDebug(2, "ExpandCraftSkillLine called, id = " .. id);
	if not self:CheckSkill() then return self.hooks.ExpandCraftSkillLine.orig(id); end
	self:VerifyUserEnchantDB();

	--If they pressed the ExpandAll button, expand all catgories
	if id == 0 then
		--Empty the table, this will ensure they all count as collapsed now
		self.UserEnchantDB.IsCollapsed = Compost:Erase(self.UserEnchantDB.IsCollapsed);
	else
		--Clear the flag for the selected variable
		self.UserEnchantDB.IsCollapsed[self.UserEnchantDB.CurrentList[id].headerId] = false;
	end

	--Get the data for the currently selected item
	--local craftData = self.HiddenSelection or self.TempData[self.Selected];
	--local craftName = craftData and craftData[1] or "";

	--Recreate our db from scratch
	self:CreateUserEnchantDB();

--	--Try to select the craft
--	if self:SelectCraftByName(craftName) then
--		--If we succeed, clear our hidden selection
--		self.HiddenSelection = nil;
--	else
--		--Otherwise, store the hidden selection
--		self.HiddenSelection = craftData;
--		self.Selected = nil;
--	end

	--Causes the window to be refreshed with new settings
	self:UpdateCraftFrame();
end

function SortEnchant:CollapseCraftSkillLine(id)
	self:LevelDebug(2, "CollapseCraftSkillLine called id = " .. id);
	if not self:CheckSkill() then return self.hooks.CollapseCraftSkillLine.orig(id); end
	self:VerifyUserEnchantDB();

	--Set the flag for the selected variable
	if id == 0 then
		--self.Locale.DISPLAY holds the number of total categories
		for i = 1, self.HeaderDisplay[self.db.profile.GroupBy].n do
			self.UserEnchantDB.IsCollapsed[i] = true;
		end
	else
		self.UserEnchantDB.IsCollapsed[self.UserEnchantDB.CurrentList[id].headerId] = true;
	end

	--Get the data for the currently selected item
--	local craftData = self.HiddenSelection or self.TempData[self.Selected];
--	local craftName = craftData[1];

	--Redo the visible portion of our temporary data
	self:CreateUserEnchantDB();

--	--Try to select the craft
--	if self:SelectCraftByName(craftName) then
--		--If we succeed, clear our hidden selection
--		self.HiddenSelection = nil;
--	else
--		--Otherwise, store the hidden selection
--		self.HiddenSelection = craftData;
--		self.Selected = nil;
--	end

	--Causes the window to be refreshed with new settings
	self:UpdateCraftFrame();
end

--------------------------------------------------
-- Selection code, these set the selection in our
-- Database instead of the game's
--------------------------------------------------
function SortEnchant:SelectCraft(id)
	self:LevelDebug(3, "SelectCraft called");
	if not self:CheckSkill() then return self.hooks.SelectCraft.orig(id); end

	--Store the new selection
	self.Selected = id;

	--Clear any hidden selection we have
	self.HiddenSelection = nil;
end

--Selects a skill by its name, returns whether the operation succeded or not
function SortEnchant:SelectCraftByName(craftName)
	self:LevelDebug(2, "SelectCraftByName called name = " .. craftName);
	--Don't need to check header, as only our functions will call this
	for i = 1, self.UserEnchantDB.CurrentList.n do
		if self.UserEnchantDB.CurrentList[i][1] == craftName then
			--Found the item, select it, use the GUI to ensure it catches up too
			CraftFrame_SetSelection(i);
			return TRUE;
		end
	end

	--Could not find the item in our GUI list
	return FALSE;
end


function SortEnchant:GetCraftSelectionIndex()
	self:LevelDebug(3, "GetCraftSelectionIndex called");
	if not self:CheckSkill() then return self.hooks.GetCraftSelectionIndex.orig(); end

	--Simply retrieve the stored selection
	return self.Selected;
end

--------------------------------------------------
-- Get functions, these get data about the
-- Currently selected index, we must supply the
-- Real gameId to the sub functions for these
--------------------------------------------------
function SortEnchant:DoCraft(id)
	self:LevelDebug(2, "DoCraft called id = " .. id);
	if not self:CheckSkill() then return self.hooks.DoCraft.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.DoCraft.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.DoCraft.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftIcon(id)
	self:LevelDebug(3, "GetCraftIcon called");
	if not self:CheckSkill() then return self.hooks.GetCraftIcon.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftIcon.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftIcon.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftDescription(id)
	self:LevelDebug(3, "GetCraftDescription called");
	if not self:CheckSkill() then return self.hooks.GetCraftDescription.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftDescription.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftDescription.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftNumReagents(id)
	self:LevelDebug(3, "GetCraftNumReagents called");
	if not self:CheckSkill() then return self.hooks.GetCraftNumReagents.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftNumReagents.orig(self.HiddenSelection.gameId);
		else
			return 0;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftNumReagents.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return 0;
		end
	end
end

function SortEnchant:GetCraftReagentInfo(id, reagentId)
	self:LevelDebug(3, "GetCraftReagentInfo called");
	if not self:CheckSkill() then return self.hooks.GetCraftReagentInfo.orig(id, reagentId); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftReagentInfo.orig(self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftReagentInfo.orig(self.UserEnchantDB.CurrentList[id].gameId, reagentId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftSpellFocus(id)
	self:LevelDebug(3, "GetCraftSpellFocus called");
	if not self:CheckSkill() then return self.hooks.GetCraftSpellFocus.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftSpellFocus.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftSpellFocus.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end

--------------------------------------------------
-- Item link creation functions, called by Default
-- UI during Shift Click of specific buttons
--
-- May later make these more verbouse
--------------------------------------------------
function SortEnchant:GetCraftItemLink(id)
	self:LevelDebug(3, "GetCraftItemLink called");
	if not self:CheckSkill() then return self.hooks.GetCraftItemLink.orig(id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftItemLink.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftItemLink.orig(self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftReagentItemLink(id, reagentId)
	self:LevelDebug(3, "GetCraftReagentItemLink called");
	if not self:CheckSkill() then return self.hooks.GetCraftReagentItemLink.orig(id, reagentId); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks.GetCraftReagentItemLink.orig(self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks.GetCraftReagentItemLink.orig(self.UserEnchantDB.CurrentList[id].gameId, reagentId);
		else
			return;
		end
	end
end

--------------------------------------------------
-- Tooltip related functions, called by Default
-- UI during Mouseovers of specific buttons
--------------------------------------------------
function SortEnchant:TooltipSetCraftItem(tooltip, id, reagentId)
	self:LevelDebug(3, "TooltipSetCraftItem called");
	if not self:CheckSkill() then return self.hooks[tooltip].SetCraftItem.orig(GameTooltip, id, reagentId); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks[tooltip].SetCraftItem.orig(tooltip, self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks[tooltip].SetCraftItem.orig(tooltip, self.UserEnchantDB.CurrentList[id].gameId, reagentId);
		else
			return;
		end
	end
end

function SortEnchant:TooltipSetCraftSpell(tooltip, id)
	self:LevelDebug(3, "TooltipSetCraftSpell called");
	if not self:CheckSkill() then return self.hooks[tooltip].SetCraftSpell.orig(GameTooltip, id); end
	self:VerifyUserEnchantDB();
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.hooks[tooltip].SetCraftSpell.orig(tooltip, self.HiddenSelection.gameId);
		else
			return;
		end
	else
		if self.UserEnchantDB.CurrentList[id].gameId then
			return self.hooks[tooltip].SetCraftSpell.orig(tooltip, self.UserEnchantDB.CurrentList[id].gameId);
		else
			return;
		end
	end
end