--[[	********************************************************
		MiniGroup 0.5
		localization.lua

		Translations:
			Drathal - MiniGroup_German.lua
			Sarbian - MiniGroup_French.lua
			Hurdlove - MiniGroup_Korean.lua
		********************************************************
]]

-- Informational Text
MG_MSG_UNINITIALIZED = "Not Initialized...";
MG_MSG_UNKNOWNGENERIC = "Unknown";
MG_MSG_PROFILECREATED = " profile created.";
MG_MSG_CLASSNOTFOUND = "Error: Class not found - ";

-- /commands
MG_SLASHCOMMAND = "/mg";
MG_SLASHCOMMAND_CONFIG = "config";
MG_SLASHCOMMAND_SHOW = "show";
MG_SLASHCOMMAND_HIDE = "hide";
MG_SLASHCOMMAND_CLEAR = "clear";

-- Labels
MG_MSG_COMBOS = "Combos";
MG_RXP = "\nXP Remaining: ";
MG_XP = "XP: ";
MG_RB = "\nRest Bonus: ";
MG_TP = "\nTP: ";

-- Status
MG_MSG_CORPSE = "Corpse";
MG_MSG_DEAD = "Dead";
MG_MSG_GHOST = "Ghost";
MG_MSG_OFFLINE = "Offline";

MG_NOTSPECIFIED = "Not specified";

-- Debuffs
MG_DEBUFFS = {
	["Magic"] = "Magic",
	["Poison"] = "Poison",
	["Disease"] = "Disease",
	["Curse"] = "Curse",
	["None"] = "None"
};

-- Options Frame
MG_OPTIONS_CB5_TEXT = "Group Party Members";
MG_OPTIONS_CB5_TIP = "Check to combine member frames into one frame";
MG_OPTIONS_CB6_TEXT = "Show MiniGroup PlayerFrame";
MG_OPTIONS_CB6_TIP = "Check to show the MiniGroup PlayerFrame";
MG_OPTIONS_CB7_TEXT = "Show MiniGroup TargetFrame";
MG_OPTIONS_CB7_TIP = "Check to show the MiniGroup TargetFrame";
MG_OPTIONS_CB8_TEXT = "Show MiniGroup PartyFrame";
MG_OPTIONS_CB8_TIP = "Check to show the MiniGroup PartyFrame";
MG_OPTIONS_CB9_TEXT = "Show Actual Health Values";
MG_OPTIONS_CB9_TIP = "Check to show actual health instead of percentages. Pulls from Telo's MobHealth if available";
MG_OPTIONS_CB10_TEXT = "Smooth HealthBar Color";
MG_OPTIONS_CB10_TIP = "Check this to smooth healthbar colors from green to red as units' health decreases";
MG_OPTIONS_CB11_TEXT = "Use Independent Scaling";
MG_OPTIONS_CB11_TIP = "Check this to scale MiniGroup independently from your UI";
MG_OPTIONS_CB14_TEXT = "Show Player XP Bar";
MG_OPTIONS_CB14_TIP = "Check this to show an experience bar in the MiniGroup PlayerFrame";
MG_OPTIONS_CB15_TEXT = "Show Pet XP Bar";
MG_OPTIONS_CB15_TIP = "Check this to show an experience bar in the MiniGroup Pet Frame";
MG_OPTIONS_CB19_TEXT = "Show Keybindings";
MG_OPTIONS_CB19_TIP = "Check this to show keybindings next to each party member's name";
MG_OPTIONS_CB20_TEXT = "Use Party Raid Colors";
MG_OPTIONS_CB20_TIP = "Check this to use standard raid colors in the MiniGroup window";
MG_OPTIONS_CB21_TEXT = "Enable Party Aura Tooltips";
MG_OPTIONS_CB21_TIP = "Check this to enable the standard Blizzard aura tips";
MG_OPTIONS_CB22_TEXT = "Use Target Raid Colors";
MG_OPTIONS_CB22_TIP = "Check this to use standard raid colors in the target window";
MG_OPTIONS_CB24_TEXT = "Enable Target Aura Tooltips";
MG_OPTIONS_CB24_TIP = "Check this to enable target aura tips";
MG_OPTIONS_CB26_TEXT = "Player Color Indicators";
MG_OPTIONS_CB26_TIP = "Check to color-code your name according to debuff settings";
MG_OPTIONS_CB27_TEXT = "Player ColorBlind Indicators";
MG_OPTIONS_CB27_TIP = "Check to add color-blind debuff indicators to your name";
MG_OPTIONS_CB28_TEXT = "Party Color Indicators";
MG_OPTIONS_CB28_TIP = "Check to color-code party members' names according to debuff settings";
MG_OPTIONS_CB29_TEXT = "Party ColorBlind Indicators";
MG_OPTIONS_CB29_TIP = "Check to add color-blind debuff indicators to party members' names";
MG_OPTIONS_CB30_TEXT = "Target Color Indicators";
MG_OPTIONS_CB30_TIP = "Check to color-code target names according to debuff settings";
MG_OPTIONS_CB31_TEXT = "Target ColorBlind Indicators";
MG_OPTIONS_CB31_TIP = "Check to add color-blind indicators to target names";
MG_OPTIONS_CB32_TEXT = "Use Global Settings";
MG_OPTIONS_CB32_TIP = "Check to use the same debuff color/character/order settings for all of your characters";
MG_OPTIONS_CB33_TEXT = "Highlight Selected";
MG_OPTIONS_CB33_TIP = "Check to highlight the party member in MG when they are selected";
MG_OPTIONS_CB34_TEXT = "Show all color-blind indicators";
MG_OPTIONS_CB34_TIP = "Check to show all debuff indicators";
MG_OPTIONS_CB35_TEXT = "Show Player combat text";
MG_OPTIONS_CB35_TIP = "Check to show combat text over player status bars";
MG_OPTIONS_CB36_TEXT = "Show Pet combat text";
MG_OPTIONS_CB36_TIP = "Check to show combat text over pet status bars";
MG_OPTIONS_CB37_TEXT = "Grow Frame from Bottom";
MG_OPTIONS_CB37_TIP = "Check to add new members above the playerframe instead of below";
MG_OPTIONS_CB42_TEXT = "Group with Party";
MG_OPTIONS_CB42_TIP = "Check to include player frame in party group frame";
MG_OPTIONS_CB43_TEXT = "Flash";
MG_OPTIONS_CB43_TIP = "Check to flash the selected rest indicator when resting (rest indicators are not used for level 60 players)";
MG_OPTIONS_CB44_TEXT = "Flash";
MG_OPTIONS_CB44_TIP = "Check to flash the selected combat indicator when you are in combat";
MG_OPTIONS_CB45_TEXT = "Flash";
MG_OPTIONS_CB45_TIP = "Check to flash the selected aggro indicator when you an enemy acquires you as a target";
MG_OPTIONS_CB46_TEXT = "Show health/mana/XP endcaps";
MG_OPTIONS_CB46_TIP = "Check to show the white indicators at the ends of the health/mana/xp bars";
MG_OPTIONS_CB47_TEXT = "Enable CastParty support";
MG_OPTIONS_CB47_TIP = "Check to allow customized actions for frame clicks (requires installation of CastParty AND CUSTOMIZATION OF RIGHT CLICK IN CASTPARTY CONFIGURATION).\n\nNote: Kaitlin does not support the use of scripting to make healing decisions.";
MG_OPTIONS_CB48_TEXT = "Show CastParty frame";
MG_OPTIONS_CB48_TIP = "Check to show the CastParty frame";

MG_OPTIONS_SLIDE1_TEXT = "";
MG_OPTIONS_SLIDE1_TIP = "Adjust the scale of the MiniGroup Windows";

MG_OPTIONS_DD1 = {
	TEXT = "Aura Style",	--party aura style
	OPTIONS = 7,
	OPTION1_TEXT = "5/5 Split",
	OPTION1_TIP =  "Auras will be split: 5 Buffs filling from the left and 5 Debuffs filling from the right",
	OPTION2_TEXT = "Show 10 Buffs",
	OPTION2_TIP =  "All 10 Auras will be buffs filling from the left",
	OPTION3_TEXT = "Show 10 Debuffs",
	OPTION3_TIP =  "All 10 Auras will be debuffs filling from the left",
	OPTION4_TEXT = "Show B+/D Auras",
	OPTION4_TIP =  "Buffs will fill from the left, and debuffs will fill remaining spots from the right",
	OPTION5_TEXT = "Show B/D+ Auras",
	OPTION5_TIP =  "Debuffs will fill from the right, and buffs will fill remaining spots from the left",
	OPTION6_TEXT = "10 Buffs and 10 Debuffs on 2 lines",
	OPTION6_TIP =  "Show 2 lines of auras, first line of buffs, second line of debuffs",
	OPTION7_TEXT = "Hide auras",
	OPTION7_TIP =  "Do not show auras on frame"
};

MG_OPTIONS_DD3 = {
	TEXT = "Aura Tooltip",
	OPTIONS = 4,
	OPTION1_TEXT = "Disabled",
	OPTION1_TIP =  "Aura Tooltip will not display",
	OPTION2_TEXT = "Show buffs only in Aura Tooltip",
	OPTION2_TIP =  "Only buffs will display in Aura Tooltip",
	OPTION3_TEXT = "Show debuffs only in Aura Tooltip",
	OPTION3_TIP =  "Only debuffs will display in Aura Tooltip",
	OPTION4_TEXT = "Show both buffs and debuffs in Aura Tooltip",
	OPTION4_TIP =  "Buffs and debuffs will display in Aura Tooltip"
};

MG_OPTIONS_DD5 = {
	TEXT = "Aura Position",
	OPTIONS = 5,
	OPTION1_TEXT = "Float above",
	OPTION1_TIP =  "Auras will float above (outside) the frame",
	OPTION2_TEXT = "Float below",
	OPTION2_TIP =  "Auras will float below (outside) the frame",
	OPTION3_TEXT = "Float at right",
	OPTION3_TIP =  "Auras will float to the right (outside) of the frame",
	OPTION4_TEXT = "Float left",
	OPTION4_TIP =  "Auras will float to the left (outside) of the frame",
	OPTION5_TEXT = "Dock auras inside target frame",
	OPTION5_TIP =  "Auras will appear inside of the frame"
};

MG_OPTIONS_DD6 = {
	TEXT = "Rest Indicator",
	OPTIONS =6,
	OPTION1_TEXT = "Frame border (original)",
	OPTION1_TIP =  "Use the player/party frame border to show that you are resting",
	OPTION2_TEXT = "Frame border (thin)",
	OPTION2_TIP =  "Use the player/party frame border to show that you are resting",
	OPTION3_TEXT = "Frame border (thick)",
	OPTION3_TIP =  "Use the player/party frame border to show that you are resting",
	OPTION4_TEXT = "Player name",
	OPTION4_TIP =  "Use the player name to show that you are resting",
	OPTION5_TEXT = "Frame background",
	OPTION5_TIP =  "Use the player's frame background to show that you are resting",
	OPTION6_TEXT = "No rest indicator",
	OPTION6_TIP =  "Never indicate that you are resting"
};

MG_OPTIONS_DD7 = {
	TEXT = "Combat Indicator",
	OPTIONS = 6,
	OPTION1_TEXT = "Frame border (original)",
	OPTION1_TIP =  "Use the player/party frame border to show that you are  in combat",
	OPTION2_TEXT = "Frame border (thin)",
	OPTION2_TIP =  "Use the player/party frame border to show that you are  in combat",
	OPTION3_TEXT = "Frame border (thick)",
	OPTION3_TIP =  "Use the player/party frame border to show that you are  in combat",
	OPTION4_TEXT = "Player name",
	OPTION4_TIP =  "Use the player name to show that you are  in combat",
	OPTION5_TEXT = "Frame background",
	OPTION5_TIP =  "Use the player's frame background to show that you are in combat",
	OPTION6_TEXT = "No rest indicator",
	OPTION6_TIP =  "Never indicate that you are in combat"
};

MG_OPTIONS_DD8 = {
	TEXT = "Aggro Indicator",
	OPTIONS = 6,
	OPTION1_TEXT = "Frame border (original)",
	OPTION1_TIP =  "Use the player/party frame border to show that you have attracted aggravation",
	OPTION2_TEXT = "Frame border (thin)",
	OPTION2_TIP =  "Use the player/party frame border to show that you have attracted aggravation",
	OPTION3_TEXT = "Frame border (thick)",
	OPTION3_TIP =  "Use the player/party frame border to show that you have attracted aggravation",
	OPTION4_TEXT = "Player name",
	OPTION4_TIP =  "Use the player name to show that you have attracted aggravation",
	OPTION5_TEXT = "Frame background",
	OPTION5_TIP =  "Use the player's frame background to show that you have attracted aggravation",
	OPTION6_TEXT = "No rest indicator",
	OPTION6_TIP =  "Never indicate that you have attracted aggravation"
};

MG_OPTIONS_DD9 = {
	TEXT = "Frame style",
	OPTIONS = 4,
	OPTION1_TEXT = "Blizzard",
	OPTION1_TIP =  "Normal Blizzard frame",
	OPTION2_TEXT = "Normal",
	OPTION2_TIP =  "Mingroup frame, 62 pixels high",
	OPTION3_TEXT = "Compact",
	OPTION3_TIP =  "Mingroup frame, 32 pixels high",
	OPTION4_TEXT = "Raid",
	OPTION4_TIP =  "Mingroup frame, 23 pixels high"
};

MG_OPTIONS_DD13 = {
	TEXT = "Health/mana text style", --Player
	OPTIONS = 4,
	OPTION1_TEXT = "Absolute points",
	OPTION1_TIP =  "Show hit points/mana points./nExample: 800/1000",
	OPTION2_TEXT = "Percent",
	OPTION2_TIP =  "Show percentage of full health/mana./nExample: 80%",
	OPTION3_TEXT = "Difference (points)",
	OPTION3_TIP =  "Show missing health/mana./nExample: 200",
	OPTION4_TEXT = "Hide text (show full size bars)",
	OPTION4_TIP =  "Do not show any health/mana text"
};

MG_OPTIONS_DD14 = {
	TEXT = "Grouping",
	OPTIONS = 4,
	OPTION1_TEXT = "Group with owner",
	OPTION1_TIP =  "Group the pet into the owner's frame",
	OPTION2_TEXT = "Group with other pets in party window",
	OPTION2_TIP =  "Group the pet with other pets intoo the party window",
	OPTION3_TEXT = "Group with other pets in pet window",
	OPTION3_TIP =  "Group the pet with other pets into the pets window",
	OPTION4_TEXT = "Do not group",
	OPTION4_TIP =  "Keep the pet frame separate"
};

MG_OPTIONS_DD15 = {
	TEXT = "Frame Growth",
	OPTIONS = 4,
	OPTION1_TEXT = "Grow down",
	OPTION1_TIP =  "Frames are added to the bottom of the first frame",
	OPTION2_TEXT = "Grow up",
	OPTION2_TIP =  "Frames are added to the top of the first frame",
	OPTION3_TEXT = "Grow right",
	OPTION3_TIP =  "Frames are added to the right of the first frame",
	OPTION4_TEXT = "Grow left",
	OPTION4_TIP =  "Frames are added to the left of the first frame"
};

-- General Tab
MG_OPTIONS_SUBFRAME1 = "Bar Display";
MG_OPTIONS_SUBFRAME2 = "Other Addon Support";
MG_OPTIONS_SUBFRAME3 = "Scaling";
-- Player Tab
MG_OPTIONS_SUBFRAME4 = "Player Options";
MG_OPTIONS_SUBFRAME13 = "";
MG_OPTIONS_SUBFRAME19 = "";
-- Pet Tab
MG_OPTIONS_SUBFRAME11 = "Player Pet Options";
MG_OPTIONS_SUBFRAME17 = "";
MG_OPTIONS_SUBFRAME18 = "";
-- Party Tab
MG_OPTIONS_SUBFRAME6 = "Party Options";
MG_OPTIONS_SUBFRAME12 = "";
MG_OPTIONS_SUBFRAME14 = "";
-- Target Tab
MG_OPTIONS_SUBFRAME7 = "Target Options";
MG_OPTIONS_SUBFRAME15 = "";
MG_OPTIONS_SUBFRAME16 = "";
-- Debuff Tab
MG_OPTIONS_SUBFRAME8 = "Debuff Options";
MG_OPTIONS_SUBFRAME9 = "Debuff Indicators";
MG_OPTIONS_SUBFRAME10 = "More Debuff Options";
MG_OPTIONS_SUBFRAME5 = "Version Information";

-- Tab / Dropdown Text
MG_OPTIONS_TABS_GENERAL = "General";
MG_OPTIONS_TABS_PLAYER = "Player";
MG_OPTIONS_TABS_PET = "Pet";
MG_OPTIONS_TABS_PARTY = "Party";
MG_OPTIONS_TABS_TARGET = "Target";
MG_OPTIONS_TABS_DEBUFF = "Debuff";
MG_OPTIONS_TABS_VERSION = "TBD";
MG_OPTIONS_OPENCONFIGWINDOW = "Open Config Panel";
MG_OPTIONS_LOCKFRAMES = "Lock Frames";
MG_OPTIONS_UNLOCKFRAMES = "Unlock Frames";
MG_OPTIONS_WINDOWCOLORS = "Frame Colors";
MG_OPTIONS_PARTYWINDOW = "Party Frame";
MG_OPTIONS_TARGETWINDOW = "Target Frame";

MG_OPTIONS_DEFAULTS_TOOLTIP1 = "Clear all settings";
MG_OPTIONS_DEFAULTS_TOOLTIP2 = "-Warning-\n\nClicking this will reset all of your settings to defaults.  You cannot cancel this action.";
