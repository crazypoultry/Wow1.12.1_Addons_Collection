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
SortEnchant = AceAddon:new({
	name            = SORTENCHANT.NAME,
	version         = "2.2.1",
	releaseDate     = "5/7/2006",
	aceCompatible   = 103,
	author          = "Guvante",
	email           = "guvante@gmail.com",
	website         = "http://",
	category        = "professions",
	--optionsFrame  = "SortEnchantOptionsFrame",
	db              = AceDatabase:new("SortEnchantDB"),
	defaults        = {
						LowestShown = 0,
						GroupBy     = "armor",
						ArmorFilter = 1,
						BonusFilter = 1
				      },
	cmd             = AceChatCmd:new(SORTENCHANT.COMMANDS, SORTENCHANT.CMD_OPTIONS),
	DifficultyTable = {trivial = 1, easy = 2, medium = 3, optimal = 4},
	TempData        = {Invalidated = TRUE}, --Holds data which should not be saved to SavedVars, initialy empty, so not valid
	Locale		    = SORTENCHANT --Stores our settings in a more OO fashion
})

----------------------------------------------------------------------------------------------------
-- Addon Enabling/Disabling
----------------------------------------------------------------------------------------------------
function SortEnchant:Enable()
	--Hide the craft frame, as it needs to be completly reloaded once we are disabled
	if CraftFrame and CraftFrame:IsVisible() then
		CraftFrame:Hide();
	end

	--Reset the drop down settings, since I have not tested having them stay between sessions
	self:SetOpt("ArmorFilter", 1);
	self:SetOpt("BonusFilter", 1);

	--Catch the event that tell us when something in the Enchanting window changes
	--This event also triggers whenever the window is opened, so we need not worry
	--About any other events
	self:RegisterEvent("CRAFT_UPDATE", "CheckValidWindow");

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
end

function SortEnchant:Disable()
	--Hide any UI elements we created
	self.ArmorDropDown:Hide();
	self.BonusDropDown:Hide();

	--Hide the craft frame, as it needs to be completly reloaded once we are disabled
	if CraftFrame and CraftFrame:IsVisible() then
		CraftFrame:Hide();
	end
end

----------------------------------------------------------------------------------------------------
-- Event Processing
----------------------------------------------------------------------------------------------------
function SortEnchant:UpdateCraftFrame()
	--Make the CraftFrame update itself it has not yet
	if CraftFrame and CraftFrame:IsVisible() then
		--Recreate all data, to ensure nothing changed that we did not track
		self:InitializeTempData();
		CraftFrame_Update();
	end
end

function SortEnchant:CheckValidWindow()
	--Invalidate our TempData to ensure it is not wrongfully used
	self:InvalidateTempData();

	--Make sure we don't try and show the drop downs before they exist
	if not self.ArmorDropDown or not self.BonusDropDown then return end

	--Check to ensure we arn't in the Pet Training window
	if not self:CheckSkill() then
	     self.ArmorDropDown:Hide();
		 self.BonusDropDown:Hide();
	else
	    self.ArmorDropDown:Show();
		self.BonusDropDown:Show();
	end
end

----------------------------------------------------------------------------------------------------
-- Functions for dealing with the LowestShown setting
-- All of the setting functions need to have status messages displayed saying what happened
----------------------------------------------------------------------------------------------------
-- Get accessor
function SortEnchant:LowestShown()
	return self:GetOpt("LowestShown");
end

-- Displays a status message to the user
function SortEnchant:LowestShownStatus()
	self.cmd:status(self.Locale.STATUS.LATESTSHOWN, self:LowestShown(), self.Locale.MAP.LOWESTSHOWN);
end

-- Various Set accessors that are used by the command line functions
function SortEnchant:LowestShown_Grey()
	self:SetOpt("LowestShown", 1);
	SortEnchant:UpdateCraftFrame();
	self:LowestShownStatus();
end

function SortEnchant:LowestShown_Green()
	self:SetOpt("LowestShown", 2);
	SortEnchant:UpdateCraftFrame();
	self:LowestShownStatus();
end

function SortEnchant:LowestShown_Yellow()
	self:SetOpt("LowestShown", 3);
	SortEnchant:UpdateCraftFrame();
	self:LowestShownStatus();
end

function SortEnchant:LowestShown_Orange()
	self:SetOpt("LowestShown", 4);
	SortEnchant:UpdateCraftFrame();
	self:LowestShownStatus();
end

----------------------------------------------------------------------------------------------------
-- Functions for dealing with the GroupBy setting
----------------------------------------------------------------------------------------------------
-- Get accessor
function SortEnchant:GroupBy()
	return self:GetOpt("GroupBy");
end

-- Displays a status message to the user
function SortEnchant:GroupByStatus()
	self.cmd:status(self.Locale.STATUS.GROUPBY, self:GroupBy(), self.Locale.MAP.GROUPBY);
end

-- Various Set accessors that are used by the command line functions
function SortEnchant:GroupBy_Armor()
	self:SetOpt("GroupBy", "armor");
	SortEnchant:UpdateCraftFrame();
	self:GroupByStatus();
end

function SortEnchant:GroupBy_Bonus()
	self:SetOpt("GroupBy", "bonus");
	SortEnchant:UpdateCraftFrame();
	self:GroupByStatus();
end

function SortEnchant:GroupBy_Quantity()
	self:SetOpt("GroupBy", "quantity");
	SortEnchant:UpdateCraftFrame();
	self:GroupByStatus();
end

function SortEnchant:GroupBy_Difficulty()
	self:SetOpt("GroupBy", "difficulty");
	SortEnchant:UpdateCraftFrame();
	self:GroupByStatus();
end

function SortEnchant:GroupBy_None()
	self:SetOpt("GroupBy", "none");
	SortEnchant:UpdateCraftFrame();
	self:GroupByStatus();
end

----------------------------------------------------------------------------------------------------
-- Reporting function used by Ace
----------------------------------------------------------------------------------------------------
function SortEnchant:Report()
	self.cmd:report({
		{text=self.Locale.STATUS.LATESTSHOWN, val=self:LowestShown(), map=self.Locale.MAP.LOWESTSHOWN},
		{text=self.Locale.STATUS.GROUPBY,     val=self:GroupBy(),     map=self.Locale.MAP.GROUPBY}
	})
end

----------------------------------------------------------------------------------------------------
-- Temporary Data functions
-- Functions for the TempData field of our class
--
-- This table will hold any data that we do not want stored in the SavedVars
--
-- Also note that this is not stored in a database object as I want full control over the data
-- Structure
----------------------------------------------------------------------------------------------------
--Flag the data as invalid
function SortEnchant:InvalidateTempData()
	self.TempData.Invalidated = TRUE;
end

--Check the validity of the data we have stored
function SortEnchant:TempDataIsValid()
	return not self.TempData.Invalidated;
end

--Recreate our temporary data from scratch
function SortEnchant:InitializeTempData()
	--Recreate the table as an empty table (Which clears the Invalidated flag)
	self.TempData = {n=0, IsCollapsed={}};

	local subTable, craftName, Armor, BonusLevel, Bonus --Various locals used by the program
																   --Defined here to ensure we don't have 100 copies of them

	--Indexes all of the craft data, to minimize the number of times we call the native code
	local allCraftData = {n=0};

	--The current item we are working with while building allCraftData
	local thisCraftData;

	for i = 1, self.Hooks.GetNumCrafts.orig() do
		thisCraftData = {self.Hooks.GetCraftInfo.orig(i)};
		thisCraftData.gameId = i;

		tinsert(allCraftData, thisCraftData);
	end

	for tableName, searchTable in pairs(self.Locale.SEARCH) do
		--Create a new table at the named index
		self.TempData[tableName] = {n=0};
		self.TempData.IsCollapsed[tableName] = {};

		--Create empty tables at each possible index, to ensure
		--ipairs works properly in the final section
		for i = 1, self.Locale.DISPLAY[tableName].n do
			self.TempData[tableName][i] = {n=0};
		end

		if type(searchTable) == "table" then
			for i = 1, allCraftData.n do
				craftName = allCraftData[i][1]; --Grab the name on its own, since we will use it alot

				--Grab the three parts of the array
				ArmorType  = string.gsub(craftName, self.Locale.SEARCHSTRING, "%1");
				BonusLevel = string.gsub(craftName, self.Locale.SEARCHSTRING, "%2");
				BonusType  = string.gsub(craftName, self.Locale.SEARCHSTRING, "%3");

				--Set the subTable to the first match in our search table, or the misc table
				subTable = searchTable[ArmorType] or searchTable[BonusLevel] or searchTable[BonusType] or searchTable[""];

				--Store the full data for the item in the sub table
				tinsert(self.TempData[tableName][subTable], allCraftData[i]);

				--Store a flag for the fact that this sort group has this item
				self.TempData[tableName][subTable][craftName] = TRUE;
			end
		elseif type(searchTable) == "function" then
			for i = 1, allCraftData.n do
				craftName = allCraftData[i][1]; --Grab the name on its own, since we will use it alot

				--Run the function to see what sub table we should use
				subTable = searchTable(self, allCraftData[i]);

				--Create the sub table if is nil
				if not self.TempData[tableName][subTable] then
					self.TempData[tableName][subTable] = {};
				end

				--Store the full data for the item in the sub table
				tinsert(self.TempData[tableName][subTable],allCraftData[i]);

				--Store a flag for the fact that this sort group has this item
				self.TempData[tableName][subTable][craftName] = TRUE;
			end
		else
			--If it is not a table or a function, just ignore it, and do nothing
		end
	end

	--Now our TempData has a table for each of the sorting algorithms we use
	--Call the type select function to set up the actual data for the settings the user has chosen
	self:SetupTempData();
end

--Set up the specific data we are using based on user settings
function SortEnchant:SetupTempData()
	--Delete all integer indexed data
	--i points to the next item to be deleted, and we
	--Delete from end to beginning due to the way remove
	--Functions (It brings items down to fill the spaces)
	for i = self.TempData.n, 1, -1 do
		tremove(self.TempData,i);
	end

	--Ensure that our n got set to 0, this should be handled by
	--table.remove, but I am parinoid :P
	self.TempData.n = 0;

	--Turns FALSE once a header has actual data in it
	local headerEmpty;

	--Holds the display name of the item we are working with
	local displayName;

	--Holds whether the table can be expanded or not
	local tableExpanded;

	--Recreate the data to be visible on the main page
	for index,subTable in ipairs(self.TempData[self:GroupBy()]) do
		--Figure out the name of the header
		displayName = self.Locale.DISPLAY[self:GroupBy()][index];

		--Is the table expanded?
		tableExpanded = self:TableExpanded(index);

		if displayName ~= "" then
			--Insert the header field
			tinsert(self.TempData,{displayName, "", "header", 0, tableExpanded, 0, 0, headerId = index});

			--Set our header variable, it will be cleared if we have data in this category
			headerEmpty = TRUE;
		else
			--If the display name is an empty string, dot no create a header, so clear
			--The header now, as we do not want to try and remove what does not exist,
			--As instead of deleting the header, we will delete a useful item
			headerEmpty = FALSE;
		end

		--Go through each item in the category, and add it to our list
		for _,craftData in ipairs(subTable) do
			if self:IsVisible(craftData) then
				if tableExpanded then
					tinsert(self.TempData,craftData);
					headerEmpty = FALSE;
				else
					--We only need to get one truth to ensure we don't show an otherwise empty group
					--But we do not need to check any other 
					headerEmpty = FALSE;
					break;
				end
			end
		end

		--If the header is empty, then remove
		if headerEmpty then
			tremove(self.TempData);
		end
	end
end

--Grabs the inverse of the value stored in memory, because that is the way it is stored there
function SortEnchant:TableExpanded(tableIndex)
	return not self.TempData.IsCollapsed[self:GroupBy()][tableIndex];
end

--Checks if the item should be visible, using dropdowns and lowest shown
function SortEnchant:IsVisible(craftData)
	--Fetch our indexes, if they are nil, assume All
	local ArmorIndex = (self:GetOpt("ArmorFilter") or 1) - 1;
	local BonusIndex = (self:GetOpt("BonusFilter") or 1) - 1;

	--If we have something other than All selected, and it is not in that category, return FALSE
	if ArmorIndex ~= 0 and not self.TempData.armor[ArmorIndex][craftData[1]] then
		return FALSE;
	end

	--If we have something other than All selected, and it is no in that category, return FALSE
	if BonusIndex ~= 0 and not self.TempData.bonus[BonusIndex][craftData[1]] then
		return FALSE;
	end

	--If we have a minimum required difficulty, check it here
	if self.DifficultyTable[craftData[3]] < self:LowestShown() then
		return FALSE;
	end

	--Otherwise, return TRUE
	return TRUE;
end

----------------------------------------------------------------------------------------------------
-- Miscelanious functions
-- Used by other functions for repeated sets of code
----------------------------------------------------------------------------------------------------
function SortEnchant:CheckSkill()
	--Simply return the first value from this function, as it will be a string in the case of the
	--Enchanting window, or nil in the case of the Beast Training window
	return (GetCraftDisplaySkillLine())
end

function SortEnchant:GetOpt(var)
	--Return the var from the current profile
	return self.db:get(self.profilePath,var);
end

function SortEnchant:SetOpt(var,val)
	--Store the var in the current profile
	return self.db:set(self.profilePath,var,val);
end

function SortEnchant:TogOpt(var)
	--Toggle and return the var in the current profile
	return self.db:toggle(self.profilePath,var)
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
-- If we only read from the TempData variable, then check its validity to ensure it is not bad
--
-- Note to myself:
-- Need to organize these in some more logical fashion
----------------------------------------------------------------------------------------------------
--------------------------------------------------
-- Overall functions, return basic data
-- Hooked to return data we have instead
--------------------------------------------------
function SortEnchant:GetNumCrafts()
	if not self:CheckSkill() then return self.Hooks.GetNumCrafts.orig(); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end

	--The n only references integer indexed variables, so it gives how
	--Many enchantments we want the GUI to worry about
	return self.TempData.n;
end

function SortEnchant:GetCraftInfo(id)
	if not self:CheckSkill() then return self.Hooks.GetCraftInfo.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end

	--Simply grab the cache we have for the requested item
	if not self.TempData[id] then
		return nil;
	else
		return self.TempData[id][1], self.TempData[id][2], self.TempData[id][3], self.TempData[id][4], self.TempData[id][5], self.TempData[id][6], self.TempData[id][7];
	end
end

--------------------------------------------------
-- Expansion code, change expanded/contracted for
-- Various headers, not supported in default
-- Enchanting environment, so we support them here
--------------------------------------------------
function SortEnchant:ExpandCraftSkillLine(id)
	if not self:CheckSkill() then return self.Hooks.ExpandCraftSkillLine.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end

	--If they pressed the ExpandAll button, expand all catgories
	if id == 0 then
		--self.Locale.DISPLAY holds the number of total categories
		for i = 1, self.Locale.DISPLAY[self:GroupBy()].n do
			self.TempData.IsCollapsed[self:GroupBy()][i] = FALSE;
		end
	else
		--Clear the flag for the selected variable
		self.TempData.IsCollapsed[self:GroupBy()][self.TempData[id].headerId] = FALSE;
	end

	--Get the data for the currently selected item
	local craftData = self.HiddenSelection or self.TempData[self.Selected];
	local craftName = craftData and craftData[1] or "";

	--Redo the visible portion of our temporary data
	if self:TempDataIsValid() then
		self:SetupTempData();
	else
		self:InitializeTempData();
	end

	--Try to select the craft
	if self:SelectCraftByName(craftName) then
		--If we succeed, clear our hidden selection
		self.HiddenSelection = nil;
	else
		--Otherwise, store the hidden selection
		self.HiddenSelection = craftData;
		self.Selected = nil;
	end

	--Causes the window to be refreshed with new settings
	if CraftFrame:IsVisible() then
		CraftFrame_Update();
	end
end

function SortEnchant:CollapseCraftSkillLine(id)
	if not self:CheckSkill() then return self.Hooks.CollapseCraftSkillLine.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end

	--Set the flag for the selected variable
	if id == 0 then
		--self.Locale.DISPLAY holds the number of total categories
		for i = 1, self.Locale.DISPLAY[self:GroupBy()].n do
			self.TempData.IsCollapsed[self:GroupBy()][i] = TRUE;
		end
	else
		self.TempData.IsCollapsed[self:GroupBy()][self.TempData[id].headerId] = TRUE;
	end

	--Get the data for the currently selected item
	local craftData = self.HiddenSelection or self.TempData[self.Selected];
	local craftName = craftData[1];

	--Redo the visible portion of our temporary data
	if self:TempDataIsValid() then
		self:SetupTempData();
	else
		self:InitializeTempData();
	end

	--Try to select the craft
	if self:SelectCraftByName(craftName) then
		--If we succeed, clear our hidden selection
		self.HiddenSelection = nil;
	else
		--Otherwise, store the hidden selection
		self.HiddenSelection = craftData;
		self.Selected = nil;
	end

	--Causes the window to be refreshed with new settings
	CraftFrame_Update();
end

--------------------------------------------------
-- Selection code, these set the selection in our
-- Database instead of the game's
--------------------------------------------------
function SortEnchant:SelectCraft(id)
	if not self:CheckSkill() then return self.Hooks.SelectCraft.orig(id); end

	--Store the new selection
	self.Selected = id;

	--Clear any hidden selection we have
	self.HiddenSelection = nil;
end

--Selects a skill by its name, returns whether the operation succeded or not
function SortEnchant:SelectCraftByName(craftName)
	--Don't need to check header, as only our functions will call this
	for i = 1, self.TempData.n do
		if self.TempData[i][1] == craftName then
			--Found the item, select it, use the GUI to ensure it catches up too
			CraftFrame_SetSelection(i);
			return TRUE;
		end
	end

	--Could not find the item in our GUI list
	return FALSE;
end


function SortEnchant:GetCraftSelectionIndex()
	if not self:CheckSkill() then return self.Hooks.GetCraftSelectionIndex.orig(); end

	--Simply retrieve the stored selection
	return self.Selected;
end

--------------------------------------------------
-- Get functions, these get data about the
-- Currently selected index, we must supply the
-- Real gameId to the sub functions for these
--------------------------------------------------
function SortEnchant:DoCraft(id)
	if not self:CheckSkill() then return self.Hooks.DoCraft.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.DoCraft.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.DoCraft.orig(self.TempData[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftIcon(id)
	if not self:CheckSkill() then return self.Hooks.GetCraftIcon.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftIcon.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftIcon.orig(self.TempData[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftDescription(id)
	if not self:CheckSkill() then return self.Hooks.GetCraftDescription.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftDescription.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftDescription.orig(self.TempData[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftNumReagents(id)
	if not self:CheckSkill() then return self.Hooks.GetCraftNumReagents.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftNumReagents.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftNumReagents.orig(self.TempData[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftReagentInfo(id, reagentId)
	if not self:CheckSkill() then return self.Hooks.GetCraftReagentInfo.orig(id, reagentId); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftReagentInfo.orig(self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftReagentInfo.orig(self.TempData[id].gameId, reagentId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftSpellFocus(id)
	if not self:CheckSkill() then return self.Hooks.GetCraftSpellFocus.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftSpellFocus.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftSpellFocus.orig(self.TempData[id].gameId);
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
	if not self:CheckSkill() then return self.Hooks.GetCraftItemLink.orig(id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftItemLink.orig(self.HiddenSelection.gameId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftItemLink.orig(self.TempData[id].gameId);
		else
			return;
		end
	end
end

function SortEnchant:GetCraftReagentItemLink(id, reagentId)
	if not self:CheckSkill() then return self.Hooks.GetCraftReagentItemLink.orig(id, reagentId); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks.GetCraftReagentItemLink.orig(self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else --Otherwise, use the Selected index
		if self.TempData[id].gameId then
			return self.Hooks.GetCraftReagentItemLink.orig(self.TempData[id].gameId, reagentId);
		else
			return;
		end
	end
end

--------------------------------------------------
-- Tooltip related functions, called by Default
-- UI during Mouseovers of specific buttons
--------------------------------------------------
function SortEnchant:TooltipSetCraftItem(id, reagentId)
	if not self:CheckSkill() then return self.Hooks[GameTooltip].SetCraftItem.orig(GameTooltip, id, reagentId); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks[GameTooltip].SetCraftItem.orig(GameTooltip, self.HiddenSelection.gameId, reagentId);
		else
			return;
		end
	else
		if self.TempData[id].gameId then
			return self.Hooks[GameTooltip].SetCraftItem.orig(GameTooltip, self.TempData[id].gameId, reagentId);
		else
			return;
		end
	end
end

function SortEnchant:TooltipSetCraftSpell(id)
	if not self:CheckSkill() then return self.Hooks[GameTooltip].SetCraftSpell.orig(GameTooltip, id); end
	if not self:TempDataIsValid() then self:InitializeTempData(); end
	
	--If we have a selection that is not on screen, use it
	if self.HiddenSelection and not id then
		if self.HiddenSelection.gameId then
			return self.Hooks[GameTooltip].SetCraftSpell.orig(GameTooltip, self.HiddenSelection.gameId);
		else
			return;
		end
	else
		if self.TempData[id].gameId then
			return self.Hooks[GameTooltip].SetCraftSpell.orig(GameTooltip, self.TempData[id].gameId);
		else
			return;
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Drop down handling functions
-- Except for OnClick, these all explicitly reference the SortEnchant table, because of weird
-- Parameter rules (Can't figure out the problem)
----------------------------------------------------------------------------------------------------
--------------------------------------------------
-- OnLoad functions - Ran when the craft frame is
-- Created
--------------------------------------------------
function SortEnchant:ArmorDropDown_OnLoad()
	Ace:print(this:GetName());
	--Initialize the drop down menu with all of its items
	UIDropDownMenu_Initialize(this, self.ArmorDropDown_Initialize);

	--Update the width of the drop down to ensure it is accurate
	UIDropDownMenu_SetWidth(120);

	--Set the selected index of the drop down to the default
	UIDropDownMenu_SetSelectedID(this, 1);
end

function SortEnchant:BonusDropDown_OnLoad()
	--Initialize the drop down menu with all of its items
	UIDropDownMenu_Initialize(this, self.BonusDropDown_Initialize);

	--Update the width of the drop down to ensure it is accurate
	UIDropDownMenu_SetWidth(120);

	--Set the selected index of the drop down to the default
	UIDropDownMenu_SetSelectedID(this, 1);
end

--------------------------------------------------
-- OnShow functions - Ran when the craft frame is
-- Shown on the screen
--------------------------------------------------
function SortEnchant:ArmorDropDown_OnShow()
	--Initialize the drop down menu with all of its items
	UIDropDownMenu_Initialize(this, self.ArmorDropDown_Initialize);

	--Update the width of the drop down to ensure it is accurate
	UIDropDownMenu_SetWidth(120);

	--Update the selected index to what we have stored
	UIDropDownMenu_SetSelectedID(this, self:GetOpt("ArmorFilter"));
end

function SortEnchant:BonusDropDown_OnShow()
	--Initialize the drop down menu with all of its items
	UIDropDownMenu_Initialize(this, self.BonusDropDown_Initialize);

	--Update the width of the drop down to ensure it is accurate
	UIDropDownMenu_SetWidth(120);

	--Update the selected index to what we have stored
	UIDropDownMenu_SetSelectedID(this, self:GetOpt("BonusFilter"));
end

--------------------------------------------------
-- Initialize functions - Ran during OnLoad and
-- OnShow, to ensure the DropDowns
-- Have the proper information in them
--------------------------------------------------
function SortEnchant.ArmorDropDown_Initialize()
	--Set our self variable, since it can not be passed in
	local self = SortEnchant;

	--Variable used to store table while we are building it (To be passed to UIDropDownMenu functions)
	local info = {};
	--Store the title text, function, and checked into the table, then add it to the menu
	info.text = self.Locale.ARMORDROPDOWN_TITLE;
	info.func = self.ArmorDropDown_OnClick;
	info.arg1 = self; --Tells the functions to pass in this object
	info.checked = (self:GetOpt("ArmorFilter") == 1);
	info.value  = 1;
	
	--If the button is supposed to be checked, set our drop down title to that
	if info.checked then
		UIDropDownMenu_SetText(self.Locale.ARMORDROPDOWN_TITLE, self.ArmorDropDown);
	end

	UIDropDownMenu_AddButton(info);

	for i,v in ipairs(self.Locale.DISPLAY.armor) do
		--Create a new table and fill its values
		info = {};
		info.text = v;
		info.func = self.ArmorDropDown_OnClick;
		info.arg1 = self;
		info.checked = (self:GetOpt("ArmorFilter") == i + 1);
		info.value = i + 1;

		--If the button is supposed to be checked, set our drop down title to that
		if info.checked then
			UIDropDownMenu_SetText(v, self.ArmorDropDown);
		end

		UIDropDownMenu_AddButton(info);
	end
end

function SortEnchant.BonusDropDown_Initialize()
	--Set our self variable, since it can not be passed in
	local self = SortEnchant;

	--Variable used to store table while we are building it (To be passed to UIDropDownMenu functions)
	local info = {};
	--Store the title text, function, and checked into the table, then add it to the menu
	info.text = self.Locale.BONUSDROPDOWN_TITLE;
	info.func = self.BonusDropDown_OnClick;
	info.arg1 = self; --Tells the functions to pass in this object
	info.checked = (self:GetOpt("BonusFilter") == 1);
	info.value  = 1;
	UIDropDownMenu_AddButton(info);
	
	--If the button is supposed to be checked, set our drop down title to that
	if info.checked then
		UIDropDownMenu_SetText(self.Locale.BONUSDROPDOWN_TITLE, self.BonusDropDown);
	end

	for i,v in ipairs(self.Locale.DISPLAY.bonus) do
		--Create a new table and fill its values
		info = {};
		info.text = v;
		info.func = self.BonusDropDown_OnClick;
		info.arg1 = self;
		info.checked = (self:GetOpt("BonusFilter") == i + 1);
		info.value = i + 1;

		--If the button is supposed to be checked, set our drop down title to that
		if info.checked then
			UIDropDownMenu_SetText(v, self.BonusDropDown);
		end

		UIDropDownMenu_AddButton(info);
	end
end

--------------------------------------------------
-- OnClick functions - Set our own variable for
-- What we have selected for DropDowns,
-- And updates the UI with the new information
--------------------------------------------------
function SortEnchant:ArmorDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(self.ArmorDropDown, this:GetID());
	self:SetOpt("ArmorFilter", this:GetID());

	--If our data is still valid, then simply recreate the data the window sees
	--Otherwise, recreate all data
	if self:TempDataIsValid() then
		self:SetupTempData();
	else
		self:InitializeTempData();
	end

	--If we have data in the window, reset our selection
	if self.TempData.n > 1 then
		CraftFrame_SetSelection(2);
	end

	--Update the craft frame if it hasn't been closed yet
	if CraftFrame:IsVisible() then
		CraftFrame_Update();
	end
end

function SortEnchant:BonusDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(self.BonusDropDown, this:GetID());
	self:SetOpt("BonusFilter", this:GetID());

	--If our data is still valid, then simply recreate the data the window sees
	--Otherwise, recreate all data
	if self:TempDataIsValid() then
		self:SetupTempData();
	else
		self:InitializeTempData();
	end

	--If we have data in the window, reset our selection
	if self.TempData.n > 1 then
		CraftFrame_SetSelection(2);
	end

	--Update the craft frame if it hasn't been closed yet
	if CraftFrame:IsVisible() then
		CraftFrame_Update();
	end
end

----------------------------------------------------------------------------------------------------
-- Register the Addon
----------------------------------------------------------------------------------------------------
SortEnchant:RegisterForLoad();