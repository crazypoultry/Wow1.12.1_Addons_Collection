-- Version: English (by Guvante, because I know this one :P)
-- Last Update: 03/08/05

SortEnchant_EncTitle = "Enchanting"; --Title of the enchanting window

--Commands, must be lowercase
SortEnchant_Toggle = "toggle";
SortEnchant_On = "on";
SortEnchant_Off = "off";
SortEnchant_Grey = "grey";
SortEnchant_Gray = "gray";
SortEnchant_Green = "green";
SortEnchant_Yellow = "yellow";
SortEnchant_Orange = "orange";
SortEnchant_Armor = "armor";
SortEnchant_Type = "type";
SortEnchant_Available = "available";
SortEnchant_Reset = "reset";
SortEnchant_ResetConfirm = "reset confirm";
SortEnchant_NewType = "newtype";
SortEnchant_Type = "type";
SortEnchant_HelpAdvanced = "help advanced";
SortEnchant_Shorten = "shorten";

--Dropdown stuff
SortEnchant_DropDown_Armor = "All Armor";
SortEnchant_DropDown_Type = "All Types";

--Names of searchtypes
SortEnchant_Armor_C = "Armor";
SortEnchant_Type_C = "Type";
SortEnchant_Available_C = "Available";

--Messages that are returned after commands
SortEnchant_OnMsg = "SortEnchant Enabled, Enchantment window will be sorted by ";
SortEnchant_OffMsg = "SortEnchant Disabled, Enchantment window will not be sorted";
SortEnchant_AllOnMsg = "All qualities of enchantments will be displayed in the Enchantment window";
SortEnchant_NoGreyMsg = "Only Orange, Yellow, and Green enchantments will displayed in the Enchantment window";
SortEnchant_NoGreenMsg = "Only Orange and Yellow enchantments will displayed in the Enchantment window";
SortEnchant_NoYellowMsg = "Only Orange enchantments will displayed in the Enchantment window";
SortEnchant_TypeMsg = "Enchantment window will be sorted by ";
SortEnchant_ResetConfirmDialog = "Confirm reseting of _all_ SortEnchant data with /SortEnchant Reset Confirm";
SortEnchant_ResetMsg = "All SortEnchant data reset to defaults";

--Messages for tooltips for buttons
SortEnchant_EnableOptions = {
	[true] = "Currently Enabled";
	[false] = "Currently Disabled"
}
SortEnchant_EnableLine = "Click to enable and disable SortEnchant";
SortEnchant_PreType = ""; --Not used, but may be nice for other languages
SortEnchant_PostType = " currently selected";
SortEnchant_TypeLine = "Click to cycle through types";
SortEnchant_GreyOptions = {
	[true] = "Currently showing grey items";
	[false] = "Currently hiding grey items"
}
SortEnchant_GreyLine = "Click to show and hide grey items";

--Start up message
SortEnchant_LoadMsgPre = "Loaded Sort Enchant ";
SortEnchant_LoadMsgPost = ", type /SortEnchant for help";

--Help Definitions
function SortEnchant_DisplayHelp()
	DEFAULT_CHAT_FRAME:AddMessage("Sort Enchant Mod: By Guvante");
	DEFAULT_CHAT_FRAME:AddMessage("Use /SortEnchant or /se");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant help - Return this message");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant on - Enables Sort Enchant");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant off - Disables Sort Enchant");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant toggle - Toggles Sort Enchant");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Armor - sets Sort Enchant to categorize by armor type");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Type - sets SortEnchant to categorize by stat buffed");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Available - sets SortEnchant to categorize by number you can make");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Shorten - shortens names when linking recipes");
	DEFAULT_CHAT_FRAME:AddMessage("For advanced commands, type /SortEnchant help advanced");
end

function SortEnchant_DisplayAdvancedHelp()
	DEFAULT_CHAT_FRAME:AddMessage("The following commands are only recomended for advanced users");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Type <Cat> - sets to categorize by <Cat>");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant NewType <Cat> - Creates a new category, MUST be used to initialize before doing modify commands");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant NewTypeF <Cat> <Function> - Creates a new category, searched using <Function>");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Modify <Cat> '<Search>' '<Show>' - Adds a new searchable category to <Cat>, omit <Search> if it is a Func based category");
	DEFAULT_CHAT_FRAME:AddMessage("--Note that <Search> is being searched for and <Show> will be the title, and that both must be surrounded by '");
	DEFAULT_CHAT_FRAME:AddMessage("/SortEnchant Save - sets SortEnchant to preserve its default tables, enable if you have customized them");
end

--Not vital
SortEnchant_Armor_Show = "Armor";
SortEnchant_1H_Weapon = "1H Weapon";
SortEnchant_All_Stats = "All stats";
SortEnchant_Resist_All = "Resist All";
SortEnchant_Defense_Skill = "Defense";

SortEnchant_SearchString = "Enchant ([^%-]*) %- ([^%s]*) ?(.*)";
--Description of Search String:
-- Enchant - Starts off every enchantment that does not make an item
-- ([^%-]*) - any character that is not a -, any number of times, capture this value
-- %- - the character -
-- ([^%s]*) - any chacter that is not white space, any number of times, also capture this value
--  ? (Space followed by a ?) - Either 1 or 0 spaces


SortEnchant_Values = {
	Minor = 1,
	Lesser = 3,
	Greater = 7,
	Major = 9,
	Advanced = 2
}
SortEnchant_Minor = "Minor";
SortEnchant_Lesser = "Lesser";
SortEnchant_Greater = "Greater";
SortEnchant_Superior = "Superior";
SortEnchant_Major = "Major";
SortEnchant_Advanced = "Advanced";
SortEnchant_Minor_Impact = "Minor Impact";
SortEnchant_Resist = {
	Fire = {
		Search = "Fire Resist";
		Show = "Fire Resist";
	};
	
	Shadow = {
		Search = "Shadow Resistance";
		Show = "Shadow Resist";
	};
	
	Frost = {
		Search = "Frost Resistance";
		Show = "Frost Resist";
	};
}
--Done with new ones

--New tables
--Show table notes
--Be sure to set n = total number of values

--Search tables notes
--Index by string, return int that points to a value in show table

SortEnchant_Show = {
	[SortEnchant_Armor_C] = {
		[1] = "Boots";
		[2] = "Bracer";
		[3] = "Chest";
		[4] = "Cloak";
		[5] = "Gloves";
		[6] = "Shield";
		[7] = "Weapon";
		[8] = "Misc";
		["n"] = 11;
	};

	[SortEnchant_Type_C] = {
		[1] = "Agility";
		[2] = "Intellect";
		[3] = "Spirit";
		[4] = "Stamina";
		[5] = "Strength";
		[6] = "Health";
		[7] = "Mana";
		[8] = "Stats";
		[9] = "Defense";
		[10] = "Resistance";
		[11] = "Damage";
		[12] = "Specialty";
		[13] = "Proc";
		[14] = "Skill";
		[15] = "Spell Power";
		[16] = "Misc";
		["n"] = 16;
	};

	[SortEnchant_Available_C] = {
		[1] = "Lots";
		[2] = "5-10";
		[3] = "1-4";
		[4] = "None";
		["n"] = 4;
	};
}

SortEnchant_Search = {
	[SortEnchant_Armor_C] = {
		["Boots"] = 1;
		["Bracer"] = 2;
		["Chest"] = 3;
		["Cloak"] = 4;
		["Gloves"] = 5;
		["Shield"] = 6;
		["Weapon"] = 7;
		[""] = 8;
	};

	[SortEnchant_Type_C] = {
		["Agility"] = 1;
		["Intellect"] = 2;
		["Spirit"] = 3;
		["Stamina"] = 4;
		["Strength"] = 5;
		["Health"] = 6;
		["Mana"] = 7;
		["Stats"] = 8;
		["Deflect"] = 9;
		["Defense"] = 9;
		["Protection"] = 9;
		["Absorption"] = 9;
		["Resistance"] = 10;
		["Shadow Resistance"] = 10;
		["Fire Resistance"] = 10;
		["Nature Resistance"] = 10;
		["Impact"] = 11;
		["Striking"] = 11;
		["Beastslayer"] = 12;
		["Elemental Slayer"] = 12;
		["Demonslaying"] = 12;
		["Crusader"] = 13;
		["Weapon"] = 13; --Unholy/Firey Weapon
		["Chill"] = 13; --Icy Chill
		["Lifestealing"] = 13;
		["Herbalism"] = 14;
		["Mining"] = 14;
		["Skinning"] = 14;
		["Fishing"] = 14;
		["Skill"] = 14; --Riding Skill
		["Speed"] = 14;
		["Haste"] = 14;
		["Stealth"] = 14;
		["Dodge"] = 14;
		["Threat"] = 14;
		["Power"] = 15;
		[""] = 16;
	};

	[SortEnchant_Available_C] = function(id)
		local _, _, _, numAvailible = SortEnchant_origGetInfo(id);
		if numAvailible > 10 then
			return 1;
		elseif (numAvailible > 4) and (numAvailible < 11) then
			return 2;
		elseif (numAvailible > 0) and (numAvailible < 5) then
			return 3;
		else
			return 4;
		end
	end;
}

--Cosmos configuration constants
SortEnchant_Cosmos_Section = "Sort Enchant";
SortEnchant_Cosmos_Section_Desc = "Sort Enchant allows sorting of the Enchantment window";
SortEnchant_Cosmos_Main = "General Options";
SortEnchant_Cosmos_Main_Desc = "Settings related to general look of the AddOn";
SortEnchant_Cosmos_Enable = "Enable Sort Enchant";
SortEnchant_Cosmos_Enable_Desc = "Enables or Disables the AddOn";
SortEnchant_Cosmos_Grey = "Show Greys";
SortEnchant_Cosmos_Grey_Desc = "Uncheck to hide greys from the list of usable recipies";
SortEnchant_Cosmos_Shorten = "Shorten Links";
SortEnchant_Cosmos_Shorten_Desc = "Shortens the descriptions that are retrieved by shift clicking";
SortEnchant_Cosmos_Sort = "Sort by";
SortEnchant_Cosmos_Sort_Desc = "Determines what the list of usable recipies will be sorted by";
SortEnchant_Cosmos_Type_Name = "Select";
SortEnchant_Cosmos_Type_Armor_Desc = "Will sort the window by type of Armor being enchanted";
SortEnchant_Cosmos_Type_Type_Desc = "Will sort the window by Type of enchantment being applied";
SortEnchant_Cosmos_Type_Available_Desc = "Will sort the window by number of Availible times the enchantment can be applied";