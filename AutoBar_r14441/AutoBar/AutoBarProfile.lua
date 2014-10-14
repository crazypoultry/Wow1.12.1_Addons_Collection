--
-- AutoBarProfile
-- Copyright 2006 Toadkiller of Proudmoore.
--
-- Profile System for AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

-- Data Structure Example for Toadkiller:
--		AutoBar = {
--			buttons = {AutoBarProfile.basic + AutoBarProfile.<CLASS> + AutoBar_Config["_SHARED1"].buttons + AutoBar_Config["Toadkiller - Proudmoore"].buttons},
--			display = {AutoBar_Config["Toadkiller - Proudmoore"].display or AutoBar_Config["_SHARED1"].display},
--			smartSelfcast = AutoBarProfile.smartSelfcast + AutoBar_Config["_SHARED1"].smartSelfcast + AutoBar_Config["Toadkiller - Proudmoore"].smartSelfcast
--		};
--		AutoBar_Config["Toadkiller - Proudmoore"] = {
--			buttons = {AutoBarProfile.basic + AutoBarProfile.<CLASS> + AutoBar_Config["_SHARED1"].buttons},
--			display = {},
--			profile = {},
--		};
--		AutoBar_Config["_SHARED1"] = {
--			buttons = {},
--			smartSelfcast = {},
--			display = {},
--		};
--		AutoBar_Config["_DRUID"] = {
--			buttons = {AutoBarProfile.DRUID},
--			smartSelfcast = {},
--			display = {},
--		};
--		AutoBar_Config["_BASIC"] = {
--			buttons = {AutoBarProfile.basic},
--			smartSelfcast = {},
--			display = {},
--		};
--		AutoBarProfile.<CLASS>
--		AutoBarProfile.basic
--		AutoBarProfile.smartSelfcast (covers both basic & <CLASS>)

AutoBarProfile = {};
AutoBarProfile.MAX_SHARED_PROFILES = 4;

local POTIONSLOT = 5;
local BUFFSLOT1 = 7;
local BUFFSLOT2 = 8;
local FOODSLOT = 9;
local BUFFSLOT = 12;
local PETFOOD = 24;

local Compost = AceLibrary("Compost-2.0");
local L = AceLibrary("AceLocale-2.1"):GetInstance("AutoBar", true);



-- Set up Basic Defaults
function AutoBarProfile.InitializeBasic()
	AutoBarProfile.basic = Compost:GetTable();
	AutoBarProfile.basic[1] = { "HEARTHSTONE" };
	AutoBarProfile.basic[3] = { "BANDAGES", "ALTERAC_BANDAGES", "WARSONG_BANDAGES", "ARATHI_BANDAGES", "UNGORO_RESTORE" };
	AutoBarProfile.basic[4] = { "HEALPOTIONS", "REJUVENATION_POTIONS", "WHIPPER_ROOT", "NIGHT_DRAGONS_BREATH", "PVP_HEALPOTIONS", "ALTERAC_HEAL", "HEALTHSTONE" };
	AutoBarProfile.basic[POTIONSLOT] = Compost:GetTable();
	AutoBarProfile.basic[6] = { "PROTECTION_ARCANE", "PROTECTION_FROST", "PROTECTION_NATURE", "PROTECTION_SHADOW", "PROTECTION_FIRE", "PROTECTION_SPELLS" };
	AutoBarProfile.basic[6].arrangeOnUse = true;
	AutoBarProfile.basic[7] = Compost:GetTable();
	AutoBarProfile.basic[8] = Compost:GetTable();
	AutoBarProfile.basic[9] = Compost:GetTable();
	AutoBarProfile.basic[10] = { "FOOD", "FOOD_CONJURED" };
	AutoBarProfile.basic[11] = { "FOOD_WATER", "FOOD_ARATHI", "FOOD_WARSONG" };
	AutoBarProfile.basic[12] = Compost:GetTable();
	AutoBarProfile.basic[13] = { "SHARPENINGSTONES" };
	AutoBarProfile.basic[14] = { "WEIGHTSTONE" };
	AutoBarProfile.basic[15] = { "SWIFTNESSPOTIONS" };
	AutoBarProfile.basic[16] = { "ACTION_POTIONS" };
	AutoBarProfile.basic[17] = { "EXPLOSIVES" };
	AutoBarProfile.basic[18] = { "FISHINGITEMS" };
	AutoBarProfile.basic[19] = { "HOURGLASS_SAND", "BATTLE_STANDARD", "BATTLE_STANDARD_AV" };
	AutoBarProfile.basic[20] = Compost:GetTable();
	AutoBarProfile.basic[21] = Compost:GetTable();
	AutoBarProfile.basic[22] = Compost:GetTable();
	AutoBarProfile.basic[23] = Compost:GetTable();
	AutoBarProfile.basic[24] = Compost:GetTable();

	-- Mount Slot
	local MOUNTSLOT = 2;
	local _, raceEnglish = UnitRace("player");
	if (raceEnglish == "Troll") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_ORC", "MOUNTS_UNDEAD", "MOUNTS_TAUREN", "MOUNTS_TROLL", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Orc") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_TROLL", "MOUNTS_UNDEAD", "MOUNTS_TAUREN", "MOUNTS_ORC", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Scourge") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_TROLL", "MOUNTS_ORC", "MOUNTS_TAUREN", "MOUNTS_UNDEAD", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Tauren") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_TROLL", "MOUNTS_ORC", "MOUNTS_UNDEAD", "MOUNTS_TAUREN", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Human") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_NIGHTELF", "MOUNTS_DWARF", "MOUNTS_GNOME", "MOUNTS_HUMAN", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "NightElf") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_HUMAN", "MOUNTS_DWARF", "MOUNTS_GNOME", "MOUNTS_NIGHTELF", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Dwarf") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_HUMAN", "MOUNTS_NIGHTELF", "MOUNTS_GNOME", "MOUNTS_DWARF", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	elseif (raceEnglish == "Gnome") then
		AutoBarProfile.basic[MOUNTSLOT] = { "MOUNTS_HUMAN", "MOUNTS_NIGHTELF", "MOUNTS_DWARF", "MOUNTS_GNOME", "MOUNTS_SPECIAL", "MOUNTS_QIRAJI" };
	end
	AutoBarProfile.basic[MOUNTSLOT].arrangeOnUse = true;
end

-- Set up Basic Defaults
function AutoBarProfile.InitializeClass()
	AutoBarProfile.ROGUE = Compost:GetTable();
	AutoBarProfile.ROGUE[POTIONSLOT] = { "ENERGYPOTIONS" };
	AutoBarProfile.ROGUE[FOODSLOT] = { "FOOD_STRENGTH", "FOOD_AGILITY", "FOOD_STAMINA", "FOOD_HPREGEN" };
	AutoBarProfile.ROGUE[20] = { "POISON-MINDNUMBING" };
	AutoBarProfile.ROGUE[21] = { "POISON-WOUND" };
	AutoBarProfile.ROGUE[22] = { "POISON-CRIPPLING" };
	AutoBarProfile.ROGUE[23] = { "POISON-DEADLY" };
	AutoBarProfile.ROGUE[24] = { "POISON-INSTANT" };
	AutoBarProfile.ROGUE[BUFFSLOT] = { "SCROLL_AGILITY", "SCROLL_PROTECTION", "SCROLL_SPIRIT", "SCROLL_STAMINA", "SCROLL_STRENGTH", "BUFF_ATTACKPOWER", "BUFF_ATTACKSPEED", "BUFF_DODGE", "BUFF_FROST", "BUFF_FIRE", "SCROLL_INTELLECT" };

	AutoBarProfile.WARRIOR = Compost:GetTable();
	AutoBarProfile.WARRIOR[POTIONSLOT] = { "RAGEPOTIONS" };
	AutoBarProfile.WARRIOR[FOODSLOT] = AutoBarProfile.ROGUE[FOODSLOT];
	AutoBarProfile.WARRIOR[BUFFSLOT] = AutoBarProfile.ROGUE[BUFFSLOT];

	AutoBarProfile.DRUID = Compost:GetTable();
	AutoBarProfile.DRUID[POTIONSLOT] = { "RUNES", "MANAPOTIONS", "REJUVENATION_POTIONS", "NIGHT_DRAGONS_BREATH", "PVP_MANAPOTIONS", "ALTERAC_MANA" };
	AutoBarProfile.DRUID[BUFFSLOT1] = { "WATER", "WATER_CONJURED" };
	AutoBarProfile.DRUID[BUFFSLOT2] = { "WATER_SPIRIT" };
	AutoBarProfile.DRUID[FOODSLOT] = { "FOOD_STRENGTH", "FOOD_AGILITY", "FOOD_STAMINA", "FOOD_INTELLIGENCE", "FOOD_HPREGEN", "FOOD_MANAREGEN" };
	AutoBarProfile.DRUID[BUFFSLOT] = AutoBarProfile.ROGUE[BUFFSLOT];

	AutoBarProfile.HUNTER = Compost:GetTable();
	AutoBarProfile.HUNTER[POTIONSLOT] = AutoBarProfile.DRUID[POTIONSLOT];
	AutoBarProfile.HUNTER[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.HUNTER[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.HUNTER[FOODSLOT] = AutoBarProfile.DRUID[FOODSLOT];
	AutoBarProfile.HUNTER[PETFOOD] = { "FOOD_PET_BREAD", "FOOD_PET_CHEESE", "FOOD_PET_FISH", "FOOD_PET_FRUIT", "FOOD_PET_FUNGUS", "FOOD_PET_MEAT" };
	AutoBarProfile.HUNTER[PETFOOD].arrangeOnUse = true;
	AutoBarProfile.HUNTER[PETFOOD].rightClickTargetsPet = true;
	AutoBarProfile.HUNTER[BUFFSLOT] = AutoBarProfile.ROGUE[BUFFSLOT];

	AutoBarProfile.MAGE = Compost:GetTable();
	AutoBarProfile.MAGE[POTIONSLOT] = { "RUNES", "MANAPOTIONS", "REJUVENATION_POTIONS", "NIGHT_DRAGONS_BREATH", "PVP_MANAPOTIONS", "ALTERAC_MANA", "MANASTONE" };
	AutoBarProfile.MAGE[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.MAGE[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.MAGE[FOODSLOT] = { "FOOD_STAMINA", "FOOD_INTELLIGENCE", "FOOD_HPREGEN", "FOOD_MANAREGEN" };
	AutoBarProfile.MAGE[BUFFSLOT] = { "SCROLL_AGILITY", "SCROLL_PROTECTION", "SCROLL_SPIRIT", "SCROLL_STAMINA", "SCROLL_STRENGTH", "BUFF_ATTACKPOWER", "BUFF_ATTACKSPEED", "SCROLL_INTELLECT" };

	AutoBarProfile.PALADIN = Compost:GetTable();
	AutoBarProfile.PALADIN[POTIONSLOT] = AutoBarProfile.DRUID[POTIONSLOT];
	AutoBarProfile.PALADIN[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.PALADIN[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.PALADIN[FOODSLOT] = AutoBarProfile.DRUID[FOODSLOT];
	AutoBarProfile.PALADIN[BUFFSLOT] = AutoBarProfile.DRUID[BUFFSLOT];

	AutoBarProfile.PRIEST = Compost:GetTable();
	AutoBarProfile.PRIEST[POTIONSLOT] = AutoBarProfile.DRUID[POTIONSLOT];
	AutoBarProfile.PRIEST[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.PRIEST[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.PRIEST[FOODSLOT] = AutoBarProfile.MAGE[FOODSLOT];
	AutoBarProfile.PRIEST[BUFFSLOT] = AutoBarProfile.MAGE[BUFFSLOT];

	AutoBarProfile.SHAMAN = Compost:GetTable();
	AutoBarProfile.SHAMAN[POTIONSLOT] = AutoBarProfile.DRUID[POTIONSLOT];
	AutoBarProfile.SHAMAN[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.SHAMAN[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.SHAMAN[FOODSLOT] = AutoBarProfile.DRUID[FOODSLOT];
	AutoBarProfile.SHAMAN[BUFFSLOT] = AutoBarProfile.DRUID[BUFFSLOT];

	AutoBarProfile.WARLOCK = Compost:GetTable();
	AutoBarProfile.WARLOCK[POTIONSLOT] = AutoBarProfile.DRUID[POTIONSLOT];
	AutoBarProfile.WARLOCK[BUFFSLOT1] = AutoBarProfile.DRUID[BUFFSLOT1];
	AutoBarProfile.WARLOCK[BUFFSLOT2] = AutoBarProfile.DRUID[BUFFSLOT2];
	AutoBarProfile.WARLOCK[FOODSLOT] = AutoBarProfile.MAGE[FOODSLOT];
	AutoBarProfile.WARLOCK[BUFFSLOT] = AutoBarProfile.MAGE[BUFFSLOT];

	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (not AutoBarProfile[AutoBarProfile.CLASS][buttonIndex]) then
			AutoBarProfile[AutoBarProfile.CLASS][buttonIndex] = Compost:GetTable();
		end
	end
end

AutoBarProfile.smartSelfcast = Compost:GetTable();
AutoBarProfile.smartSelfcast["BANDAGES"] = true;
AutoBarProfile.smartSelfcast["ALTERAC_BANDAGES"] = true;
AutoBarProfile.smartSelfcast["WARSONG_BANDAGES"] = true;
AutoBarProfile.smartSelfcast["ARATHI_BANDAGES"] = true;
AutoBarProfile.smartSelfcast["UNGORO_RESTORE"] = true;


local function clone(o)
	local new_o = Compost:GetTable();	-- creates a new object
	for i, v in pairs(o) do
		if (type(v) == "table") then
			new_o[i] = clone(v);			-- store them in new table
		else
			new_o[i] = v;				-- store them in new table
		end
	end

	-- TODO: This is goddamn stupid.  Replace / revisit this in 2.0
	if (getn(new_o) ~= getn(o)) then
		table.setn(new_o, getn(o));
	end

	return new_o;
end


-- Clone the given profile, returning the clone
function AutoBarProfile.CloneUserProfile()
	if (AutoBarProfile:GetProfile()) then
		return clone(AutoBarProfile:GetProfile());
	else
		return nil;
	end
end


-- Clone the given profile, returning the clone
function AutoBarProfile.CloneProfile(profileName)
	if (AutoBar_Config[profileName]) then
		return clone(AutoBar_Config[profileName]);
	else
		return nil;
	end
end


-- Clone all profiles, return them in a table
function AutoBarProfile.CloneProfiles()
	local profilesClone = {};--Compost:GetTable();
	profilesClone[AutoBar.currentPlayer] = AutoBarProfile.CloneProfile(AutoBar.currentPlayer);
	for index = 1, AutoBarProfile.MAX_SHARED_PROFILES, 1 do
		local sharedName = "_SHARED"..index;
		profilesClone[sharedName] = AutoBarProfile.CloneProfile(sharedName);
	end
	if (AutoBar_Config[AutoBarProfile.CLASSPROFILE]) then
		profilesClone[AutoBarProfile.CLASSPROFILE] = AutoBarProfile.CloneProfile(AutoBarProfile.CLASSPROFILE);
	end
	if (AutoBar_Config["_BASIC"]) then
		profilesClone["_BASIC"] = AutoBarProfile.CloneProfile("_BASIC");
	end
	return profilesClone;
end


-- Revert all profiles from the cloned table
function AutoBarProfile.RevertProfiles(profilesClone)
	AutoBar_Config[AutoBar.currentPlayer] = profilesClone[AutoBar.currentPlayer];
	for index = 1, AutoBarProfile.MAX_SHARED_PROFILES, 1 do
		local sharedName = "_SHARED"..index;
		AutoBar_Config[sharedName] = profilesClone[sharedName];
	end
	if (profilesClone[AutoBarProfile.CLASSPROFILE]) then
		AutoBar_Config[AutoBarProfile.CLASSPROFILE] = profilesClone[AutoBarProfile.CLASSPROFILE];
	end
	if (profilesClone["_BASIC"]) then
		AutoBar_Config["_BASIC"] = profilesClone["_BASIC"];
	end
end


-- Set up space by profileName
function AutoBarProfile.InitializeProfile(profileName)
	if (not AutoBar_Config[profileName]) then
		AutoBar_Config[profileName] = Compost:GetTable();
	end
	if (not AutoBar_Config[profileName].buttons) then
		AutoBar_Config[profileName].buttons = Compost:GetTable();
	end
	if (not AutoBar_Config[profileName].display) then
		AutoBar_Config[profileName].display = Compost:GetTable();
	end
end


-- Convert all slots to use tables and not single items
function AutoBarProfile.ConvertSlots(profileName)
	if (not AutoBar_Config[profileName]) then
		return;
	end
	if (not AutoBar_Config[profileName].buttons) then
		return;
	end
	local temp;
	local buttons = AutoBar_Config[profileName].buttons;
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (buttons[buttonIndex] and type(buttons[buttonIndex]) ~= "table") then
			temp = buttons[buttonIndex];
			buttons[buttonIndex] = { temp };
		elseif (not buttons[buttonIndex]) then
			buttons[buttonIndex] = Compost:GetTable();
		end
	end
end


-- Convert all profile's slots to use tables and not single items
function AutoBarProfile:Upgrade()
	AutoBarProfile.ConvertSlots(AutoBar.currentPlayer);
	AutoBarProfile.ConvertSlots("_SHARED1");
	AutoBarProfile.ConvertSlots("_SHARED2");
	AutoBarProfile.ConvertSlots("_SHARED3");
	AutoBarProfile.ConvertSlots("_SHARED4");
	AutoBarProfile.ConvertSlots(AutoBarProfile.CLASSPROFILE);
	AutoBarProfile.ConvertSlots("_BASIC");

	upgraded = true;
end


local upgraded = false;
-- Set up defaults for the player if required
function AutoBarProfile.Initialize()
	if (not AutoBar_Config) then AutoBar_Config = Compost:GetTable(); end
	if (not AutoBar.smartSelfcast) then AutoBar.smartSelfcast = Compost:GetTable(); end

	if (not AutoBarProfile.CLASS) then
		_, AutoBarProfile.CLASS = UnitClass("player");
		AutoBarProfile.CLASSPROFILE = "_" .. AutoBarProfile.CLASS;
	end

	if (not upgraded) then
		AutoBarProfile.Upgrade();
	end

	if (not AutoBarProfile[AutoBarProfile.CLASS]) then
		AutoBarProfile.InitializeClass();
	end

	if (not AutoBarProfile[AutoBarProfile.basic]) then
		AutoBarProfile.InitializeBasic();
	end

	AutoBarProfile.InitializeProfile(AutoBar.currentPlayer);
	for index = 1, AutoBarProfile.MAX_SHARED_PROFILES, 1 do
		local sharedName = "_SHARED"..index;
		AutoBarProfile.InitializeProfile(sharedName);
	end
	if (not AutoBar_Config[AutoBarProfile.CLASSPROFILE]) then
		AutoBarProfile.InitializeProfile(AutoBarProfile.CLASSPROFILE);
		AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons = clone(AutoBarProfile[AutoBarProfile.CLASS]);
	end
	if (not AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons) then
		AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons = clone(AutoBarProfile[AutoBarProfile.CLASS]);
	end
	if (not AutoBar_Config["_BASIC"]) then
		AutoBarProfile.InitializeProfile("_BASIC");
		AutoBar_Config["_BASIC"].buttons = clone(AutoBarProfile.basic);
	end
	if (not AutoBar_Config["_BASIC"].buttons) then
		AutoBar_Config["_BASIC"].buttons = clone(AutoBarProfile.basic);
	end

	-- TODO add versioning & deal with this after Ace2
	if (AutoBar_Config[AutoBar.currentPlayer].scaling) then
		-- Config is from pre re-write. Not upgrading.
 		Compost:Erase(AutoBar_Config[AutoBar.currentPlayer]);
		AutoBar_Msg(AUTOBAR_CHAT_MESSAGE1);
	end

	if (not AutoBarProfile:GetProfile()) then
		AutoBarProfile:SetDefaults();
	end

	if (not AutoBar.buttons) then
		AutoBarProfile:ButtonsCopy();
	end

	if (not AutoBar.display) then
		AutoBarProfile:DisplayCopy();
	end
end


function AutoBarProfile:SetDefaults()
	if (not AutoBarProfile:GetProfile()) then
		AutoBar_Config[AutoBar.currentPlayer].profile = Compost:GetTable();
	end
	if (AutoBar_Config[AutoBar.currentPlayer].buttons and table.getn(AutoBar_Config[AutoBar.currentPlayer].buttons) > 0) then
		AutoBarProfile:SetDefaultsSingle();
	else
		AutoBarProfile:SetDefaultsStandard();
	end
end


function AutoBarProfile:SetDefaultsSingle()
	local profile = AutoBarProfile:GetProfile();
	profile.useCharacter = true;
	profile.useShared = false;
	profile.useClass = false;
	profile.useBasic = false;
	profile.layout = 1;
	profile.edit = 1;
	profile.editing = AutoBar.currentPlayer;
	profile.shared = "_SHARED1";
end


function AutoBarProfile:SetDefaultsShared()
	local profile = AutoBarProfile:GetProfile();
	profile.useCharacter = true;
	profile.useShared = true;
	profile.useClass = false;
	profile.useBasic = false;
	profile.layout = AutoBarConfig.checkboxes["layout"].default;
	profile.edit = 2;
	profile.editing = "_SHARED1";
	profile.shared = "_SHARED1";
end


function AutoBarProfile:SetDefaultsStandard()
	local profile = AutoBarProfile:GetProfile();
	profile.useCharacter = true;
	profile.useShared = true;
	profile.useClass = true;
	profile.useBasic = true;
	profile.layout = AutoBarConfig.checkboxes["layout"].default;
	profile.edit = 2;
	profile.editing = "_SHARED1";
	profile.shared = "_SHARED1";
end


function AutoBarProfile:SetDefaultsBlankSlate()
	local profile = AutoBarProfile:GetProfile();
	profile.useCharacter = true;
	profile.useShared = true;
	profile.useClass = false;
	profile.useBasic = false;
	profile.layout = AutoBarConfig.checkboxes["layout"].default;
	profile.edit = 2;
	profile.editing = "_SHARED1";
	profile.shared = "_SHARED1";
end


function AutoBarProfile:GetEditPlayer()
	local editPlayer;
	local profile = AutoBarProfile:GetProfile();
	if (profile.edit == 1) then
		editPlayer = AutoBar.currentPlayer;
	elseif (profile.edit == 2) then
		editPlayer = profile.shared;
	elseif (profile.edit == 3) then
		editPlayer = AutoBarProfile.CLASSPROFILE;
	else
		editPlayer = "_BASIC";
	end
	return editPlayer;
end


function AutoBarProfile:ProfileEditingChanged()
	AutoBarConfig.editPlayer = AutoBarProfile:GetEditPlayer();
	AutoBarProfile.Initialize();
	AutoBarProfile:ButtonsCopy();
	AutoBarConfig.OnShow();
	AutoBar.ConfigChanged();
end


function AutoBarProfile:GetProfile()
	return AutoBar_Config[AutoBar.currentPlayer].profile;
end


function AutoBarProfile:InitializeLayoutProfile()
	local profile = AutoBarProfile:GetProfile();
	if (profile.layout == 1) then
		profile.layoutProfile = AutoBar.currentPlayer;
	else
		profile.layoutProfile = profile.shared;
	end
end


function AutoBarProfile:LayoutChanged()
	AutoBarProfile:InitializeLayoutProfile();
	AutoBarProfile:ProfileChanged();
end


function AutoBarProfile:ProfileChanged()
	AutoBarProfile:DisplayCopy();
	AutoBarProfile:ButtonsCopy();
	AutoBarConfig.OnShow();
	AutoBar.ConfigChanged();
end


function AutoBarProfile:DisplayChanged()
	AutoBarProfile:DisplayCopy();
	AutoBar.ConfigChanged();
end


function AutoBarProfile:ButtonsChanged()
--DEFAULT_CHAT_FRAME:AddMessage("AutoBarProfile:ButtonsChanged");
	AutoBarProfile:ButtonsCopy();
	AutoBar.ConfigChanged();
	AutoBar_SetupVisual();
	AutoBarConfig:SlotsViewInitialize();
	AutoBarConfig:SlotsInitialize();
end


function AutoBarProfile:DisplayCopy()
	local profile = AutoBarProfile:GetProfile();

	AutoBar.display = nil;
	if (profile.layout == 1) then
		AutoBar.display = AutoBar_Config[AutoBar.currentPlayer].display;
	else
		AutoBar.display = AutoBar_Config[profile.shared].display;
	end
end


-- Assign buttons from eligible layer with precedence characterButtons > sharedButtons > classButtons > basicButtons
function AutoBarProfile:ButtonsCopy()
	local profile = AutoBarProfile:GetProfile();
	local characterButtons, sharedButtons, classButtons, basicButtons;

	if (profile.useCharacter and AutoBar_Config[AutoBar.currentPlayer].buttons) then
		characterButtons = AutoBar_Config[AutoBar.currentPlayer].buttons;
	end
	if (profile.useShared and profile.shared and AutoBar_Config[profile.shared] and AutoBar_Config[profile.shared].buttons) then
		sharedButtons = AutoBar_Config[profile.shared].buttons;
	end
	if (profile.useClass and AutoBar_Config[AutoBarProfile.CLASSPROFILE] and AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons) then
		classButtons = AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons;
	end
	if (profile.useBasic and AutoBar_Config["_BASIC"] and AutoBar_Config["_BASIC"].buttons) then
		basicButtons = AutoBar_Config["_BASIC"].buttons;
	end

	-- Copy the buttons
	if (not AutoBar.buttons) then
		AutoBar.buttons = Compost:GetTable();
	end
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (AutoBar.buttons[buttonIndex]) then
			Compost:Reclaim(AutoBar.buttons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (characterButtons and characterButtons[buttonIndex] and characterButtons[buttonIndex][1]) then
			AutoBar.buttons[buttonIndex] = clone(characterButtons[buttonIndex]);
		elseif (sharedButtons and sharedButtons[buttonIndex] and sharedButtons[buttonIndex][1]) then
			AutoBar.buttons[buttonIndex] = clone(sharedButtons[buttonIndex]);
		elseif (classButtons and classButtons[buttonIndex] and classButtons[buttonIndex][1]) then
			AutoBar.buttons[buttonIndex] = clone(classButtons[buttonIndex]);
		elseif (basicButtons and basicButtons[buttonIndex] and basicButtons[buttonIndex][1]) then
			AutoBar.buttons[buttonIndex] = clone(basicButtons[buttonIndex]);
		else
			AutoBar.buttons[buttonIndex] = Compost:GetTable();
		end
	end

	-- Copy the SmartCast info.
	-- This is imperfect as an absense in a table can not overide a presence.
	-- TODO: dump single item slots & fold smartSelfcast into buttons.
	Compost:Erase(AutoBar.smartSelfcast);
	-- Basic and <CLASS> are already combined
	if ((profile.useBasic or profile.useClass) and AutoBarProfile.smartSelfcast) then
		for category in pairs(AutoBarProfile.smartSelfcast) do
			if (not AutoBar.smartSelfcast[category]) then
				AutoBar.smartSelfcast[category] = true;
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar.smartSelfcast category " .. category);
--DEFAULT_CHAT_FRAME:AddMessage("AutoBar.smartSelfcast[category] " .. tostring(AutoBar.smartSelfcast[category]));
			end
		end
	end
	if (profile.useShared and profile.shared and AutoBar_Config[profile.shared] and AutoBar_Config[profile.shared].smartSelfcast) then
		for _, category in pairs(AutoBar_Config[profile.shared].smartSelfcast) do
			if (not AutoBar.smartSelfcast[category]) then
				AutoBar.smartSelfcast[category] = true;
			end
		end
	end
	if (profile.useCharacter and AutoBar_Config[AutoBar.currentPlayer].smartSelfcast) then
		for _, category in pairs(AutoBar_Config[AutoBar.currentPlayer].smartSelfcast) do
			if (not AutoBar.smartSelfcast[category]) then
				AutoBar.smartSelfcast[category] = true;
			end
		end
	end
end


-- Assign buttons from classButtons and basicButtons layer to characterButtons
function AutoBarProfile:ButtonsCopySingle()
	local profile = AutoBarProfile:GetProfile();
	local characterButtons, classButtons, basicButtons;

	characterButtons = AutoBar_Config[AutoBar.currentPlayer].buttons;
	classButtons = AutoBarProfile[AutoBarProfile.CLASS];
	basicButtons = AutoBarProfile.basic;

	-- Copy the buttons
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (characterButtons[buttonIndex]) then
			Compost:Reclaim(characterButtons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (classButtons and classButtons[buttonIndex] and classButtons[buttonIndex][1]) then
			characterButtons[buttonIndex] = clone(classButtons[buttonIndex]);
		elseif (basicButtons and basicButtons[buttonIndex] and basicButtons[buttonIndex][1]) then
			characterButtons[buttonIndex] = clone(basicButtons[buttonIndex]);
		else
			characterButtons[buttonIndex] = Compost:GetTable();
		end
	end

	-- Copy the SmartCast info.
	Compost:Erase(AutoBar_Config[AutoBar.currentPlayer].smartSelfcast);
	-- Basic and <CLASS> are already combined
	if (AutoBarProfile.smartSelfcast) then
		for category in pairs(AutoBarProfile.smartSelfcast) do
			if (not AutoBar_Config[AutoBar.currentPlayer].smartSelfcast[category]) then
				AutoBar_Config[AutoBar.currentPlayer].smartSelfcast[category] = true;
			end
		end
	end
end


-- Assign buttons from classButtons and basicButtons layers to characterButtons and sharedButtons respectively
function AutoBarProfile:ButtonsCopyShared()
	local profile = AutoBarProfile:GetProfile();
	local characterButtons, sharedButtons, classButtons, basicButtons;

	characterButtons = AutoBar_Config[AutoBar.currentPlayer].buttons;
	sharedButtons = AutoBar_Config[profile.shared].buttons;
	classButtons = AutoBarProfile[AutoBarProfile.CLASS];
	basicButtons = AutoBarProfile.basic;

	-- Copy the buttons
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		if (characterButtons[buttonIndex]) then
			Compost:Reclaim(characterButtons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (classButtons and classButtons[buttonIndex] and classButtons[buttonIndex][1]) then
			characterButtons[buttonIndex] = clone(classButtons[buttonIndex]);
		else
			characterButtons[buttonIndex] = Compost:GetTable()
		end
		if (sharedButtons[buttonIndex]) then
			Compost:Reclaim(sharedButtons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (basicButtons and basicButtons[buttonIndex] and basicButtons[buttonIndex][1]) then
			sharedButtons[buttonIndex] = clone(basicButtons[buttonIndex]);
		else
			sharedButtons[buttonIndex] = Compost:GetTable()
		end
	end

	-- Copy the SmartCast info.
	Compost:Erase(AutoBar_Config[profile.shared].smartSelfcast);
	-- Basic and <CLASS> are already combined
	if (AutoBarProfile.smartSelfcast) then
		for category in pairs(AutoBarProfile.smartSelfcast) do
			if (not AutoBar_Config[profile.shared].smartSelfcast[category]) then
				AutoBar_Config[profile.shared].smartSelfcast[category] = true;
			end
		end
	end
end


-- Reset the defaults and clear out characterButtons and sharedButtons respectively
function AutoBarProfile:ButtonsCopyStandard()
	local profile = AutoBarProfile:GetProfile();
	local characterButtons, sharedButtons, classButtons, basicButtons;
	local classLayerButtons, basicLayerButtons;

	characterButtons = AutoBar_Config[AutoBar.currentPlayer].buttons;
	sharedButtons = AutoBar_Config[profile.shared].buttons;
	classButtons = AutoBarProfile[AutoBarProfile.CLASS];
	basicButtons = AutoBarProfile.basic;
	classLayerButtons = AutoBar_Config[AutoBarProfile.CLASSPROFILE].buttons;
	basicLayerButtons = AutoBar_Config["_BASIC"].buttons;

	-- Copy the buttons
	for buttonIndex = 1, AUTOBAR_MAXBUTTONS, 1 do
		Compost:Erase(characterButtons[buttonIndex]);
		Compost:Erase(sharedButtons[buttonIndex]);
		if (classLayerButtons[buttonIndex]) then
			Compost:Reclaim(classLayerButtons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (classButtons and classButtons[buttonIndex] and classButtons[buttonIndex][1]) then
			classLayerButtons[buttonIndex] = clone(classButtons[buttonIndex]);
		else
			classLayerButtons[buttonIndex] = Compost:GetTable()
		end
		if (basicLayerButtons[buttonIndex]) then
			Compost:Reclaim(basicLayerButtons[buttonIndex]); -- depth 1 so we reclaim the autocast table as well.
		end
		if (basicButtons and basicButtons[buttonIndex] and basicButtons[buttonIndex][1]) then
			basicLayerButtons[buttonIndex] = clone(basicButtons[buttonIndex]);
		else
			basicLayerButtons[buttonIndex] = Compost:GetTable()
		end
	end

	-- Copy the SmartCast info.
	Compost:Erase(AutoBar_Config[profile.shared].smartSelfcast);
	-- Basic and <CLASS> are already combined
	if (AutoBarProfile.smartSelfcast) then
		for category in pairs(AutoBarProfile.smartSelfcast) do
			if (not AutoBar_Config[profile.shared].smartSelfcast[category]) then
				AutoBar_Config[profile.shared].smartSelfcast[category] = true;
			end
		end
	end
end


-- /script DEFAULT_CHAT_FRAME:AddMessage(tostring(AutoBarProfile[AutoBarProfile.CLASS]))
