MINIGROUP2 = {}

-- The ace:LoadTranslation() method looks for a specific translation function for
-- the addon. If it finds one, that translation is loaded. See AceHelloLocals_xxXX.lua
-- for an example and description of function naming.
if( not ace:LoadTranslation("MiniGroup2") ) then

-- All text inside quotes is translatable, except for 'method' lines.

ace:RegisterGlobals({
    -- Match this version to the library version you are pulling from.
    version = 1.01,

    -- Place any AceUtil globals your addon needs here.
    ACEG_MAP_ONOFF = {[0]="|cffff5050Off|r",[1]="|cff00ff00On|r"},
})

MINIGROUP2.NAME				= "MiniGroup2.h"
MINIGROUP2.DESCRIPTION		= "Themeable user frames for player, target, tot, party and raid."

MINIGROUP2.ENABLED			= "Enabled"
MINIGROUP2.DISABLED			= "Disabled"

-- experience

MINIGROUP2.MSG_COMBOS = "Combos";
MINIGROUP2.RXP = "\nXP Remaining: ";
MINIGROUP2.RREP = "\nRemaining to Next Rank: ";
MINIGROUP2.XP = "XP: ";
MINIGROUP2.REP = "Reputation: ";
MINIGROUP2.RB = "\nRest Bonus: ";
MINIGROUP2.TP = "\nTP: ";

-- Chat handler locals
-- You probably only want two or three command options in your addons, but this shows
-- that you're not very restricted in what you can do.
MINIGROUP2.COMMANDS		  = {"/minigroup2", "/mg2"}
MINIGROUP2.CMD_OPTIONS	  = {
	{
		option = "reload",
		desc   = "Reload changes to settings. This can fix things if you're experiencing a bug, perhaps.",
		method = "ApplySettings",
	},	
	{
		option = "togglelock",
		desc   = "Locks/Unlocks frames.",
		method = "ToggleLock",
	},
	{
		option = "options",
		desc   = "Opens the options frame.",
		method = "ShowOptions",
	},				
}

--[[ Old MiniGroup locals ]]
-- Labels
MG_MSG_COMBOS = "Combos";
MG_RXP = "\nXP Remaining: ";
MG_XP = "XP: ";
MG_RB = "\nRest Bonus: ";
MG_TP = "\nTP: ";

-- Status
MG_MSG_CORPSE = "CORPSE";
MG_MSG_DEAD = "DEAD";
MG_MSG_GHOST = "GHOST";
MG_MSG_OFFLINE = "OFFLINE";

MG_NOTSPECIFIED = "Not specified";

-- Spell Names
MG_DETECT_MAGIC = "Detect Magic";
MG_WEAKENED_SOUL = "Weakened Soul";

MG_CLASS_PRIEST = "Priest";
MG_CLASS_DRUID = "Druid";
MG_CLASS_HUNTER = "Hunter";
MG_CLASS_WARRIOR = "Warrior";
MG_CLASS_WARLOCK = "Warlock";
MG_CLASS_ROGUE = "Rogue";
MG_CLASS_MAGE = "Mage";
MG_CLASS_SHAMAN = "Shaman";
MG_CLASS_PALADIN = "Paladin";

MG_OPTIONS_OPENCONFIGWINDOW = "Open Config Panel";
MG_OPTIONS_LOCKFRAMES   = "Lock Frames";
MG_OPTIONS_UNLOCKFRAMES = "Unlock Frames";
MG_OPTIONS_WINDOWCOLORS = "Frame Colors";
MG_OPTIONS_PARTYWINDOW  = "Party Frame";
MG_OPTIONS_TARGETWINDOW = "Target Frame";
MG_OPTIONS_BORDER_TRANSPARENT = "Transparent Borders";
MG_OPTIONS_BORDER_SOLID = "Solid Borders";

MG_OPTIONS_HELP        = "Help / Bugs";
MG_OPTIONS_HELPHEADER  = "Help Q/A";
MG_OPTIONS_HELPTEXT    = "|c00FFFFFFQ: |rThe Blizzard party frames keep popping up when people leave/join the party. What is wrong?\n\n|c00FFFFFFA: |rYou're probably using CT_RaidAssist. Go to the CT_RaidAssist options and check the two checkboxes '|c00FFFFFFHide party frame|r' and '|c00FFFFFFHide party frame out of raid|r'.\n\n\n|c00FFFFFFQ: |rI have a problem/found a bug, I am pretty sure it is a problem unique and only related to MiniGroup and I have |c00FFFFFFtried backing up/removing my WTF folder and all other mods than MiniGroup|r. The bug still occurs. What should I do?\n\n|c00FFFFFFA: |rOk, |c00FFFFFFMake sure you've really tried removing other mods and old settings(WTF)|r and if the bug still occurs please report it at the MiniGroup forum so we can have a look at it.";
MG_OPTIONS_HELPCREDITS  = "Visit the MiniGroup homepage at http://wow.jaslaughter.com/";
MG_MYADDONS_DESCRIPTION = "MiniGroup is a flexible player/party window replacement with a minimalistic interface";
MG_OPTIONS_HELPTEXT_PAGE2     = "Author and mod master:\njaslaughter (Kaitlin of Medivh)\n\nCurrent mod maintainer:\nDrewkeller\n\nAdditions and fixes:\nandreasg (Lindsay of Ravencrest)";


----


-- Options Frame
MG_OPTIONS_ICONPOSITION_TEXT = "Position"
MG_OPTIONS_ICONPOSITION_TIP = "Adjusts the position of the tracking icon around the border of the minimap"

MG_OPTIONS_OORSELECT_TEXT = "OOR Range Spell"
MG_OPTIONS_OORSELECT_TOOLTIPTEXT = "Select the spell to use for checking the range with your target."
MG_OPTIONS_SPACING_TEXT = "Group Spacing"
MG_OPTIONS_SPACING_TIP = "Adjusts the spacing between grouped units"

MG_OPTIONS_CB1_TEXT = "Show Blizzard Frame"
MG_OPTIONS_CB1_TIP = "Check to show the original Blizzard frame"
MG_OPTIONS_CB5_TEXT = "Group Party Members"
MG_OPTIONS_CB5_TIP = "Check to combine member frames into one frame"
MG_OPTIONS_CB6_TEXT = "Show MiniGroup PlayerFrame"
MG_OPTIONS_CB6_TIP = "Check to show the MiniGroup PlayerFrame"
MG_OPTIONS_CB7_TEXT = "Show MiniGroup TargetFrame"
MG_OPTIONS_CB7_TIP = "Check to show the MiniGroup TargetFrame"
MG_OPTIONS_CB8_TEXT = "Show MiniGroup PartyFrame"
MG_OPTIONS_CB8_TIP = "Check to show the MiniGroup PartyFrame"
MG_OPTIONS_CB9_TEXT = "Show Actual Health Values"
MG_OPTIONS_CB9_TIP = "Check to show actual health instead of percentages. Pulls from Telo's MobHealth if available"
MG_OPTIONS_CB10_TEXT = "Smooth HealthBar Color"
MG_OPTIONS_CB10_TIP = "Check this to smooth healthbar colors from green to red as units' health decreases"
MG_OPTIONS_CB11_TEXT = "Use Independent Scaling"
MG_OPTIONS_CB11_TIP = "Check this to scale MiniGroup independently from your UI"
MG_OPTIONS_CB14_TEXT = "Show Player XP/Rep Bar"
MG_OPTIONS_CB14_TIP = "Check this to show an experience/reputation bar in the MiniGroup PlayerFrame"
MG_OPTIONS_CB15_TEXT = "Show Pet XP Bar"
MG_OPTIONS_CB15_TIP = "Check this to show an experience bar in the MiniGroup Pet Frame"
MG_OPTIONS_CB16_TEXT = "Hide Pet happyness bar"
MG_OPTIONS_CB16_TIP = "Check this to hide the pet happyness bar"
MG_OPTIONS_CB19_TEXT = "Show Keybindings"
MG_OPTIONS_CB19_TIP = "Check this to show keybindings next to each party member's name"
MG_OPTIONS_CB20_TEXT = "Use Raid Colors Class"
MG_OPTIONS_CB20_TIP = "Check this to use standard raid colors for class titles"
MG_OPTIONS_CB21_TEXT = "Enable Party Aura Tooltips"
MG_OPTIONS_CB21_TIP = "Check this to enable the standard Blizzard aura tips"
MG_OPTIONS_CB22_TEXT = "Use Target Raid Colors"
MG_OPTIONS_CB22_TIP = "Check this to use standard raid colors in the target window"
MG_OPTIONS_CB24_TEXT = "Enable Target Aura Tooltips"
MG_OPTIONS_CB24_TIP = "Check this to enable target aura tips"
MG_OPTIONS_CB26_TEXT = "Player Color Indicators"
MG_OPTIONS_CB26_TIP = "Check to color-code your name according to debuff settings"
MG_OPTIONS_CB27_TEXT = "Player ColorBlind Indicators"
MG_OPTIONS_CB27_TIP = "Check to add color-blind debuff indicators to your name"
MG_OPTIONS_CB28_TEXT = "Party Color Indicators"
MG_OPTIONS_CB28_TIP = "Check to color-code party members' names according to debuff settings"
MG_OPTIONS_CB29_TEXT = "Party ColorBlind Indicators"
MG_OPTIONS_CB29_TIP = "Check to add color-blind debuff indicators to party members' names"
MG_OPTIONS_CB30_TEXT = "Target Color Indicators"
MG_OPTIONS_CB30_TIP = "Check to color-code target names according to debuff settings"
MG_OPTIONS_CB31_TEXT = "Target ColorBlind Indicators"
MG_OPTIONS_CB31_TIP = "Check to add color-blind indicators to target names"
MG_OPTIONS_CB32_TEXT = "Use Global Settings"
MG_OPTIONS_CB32_TIP = "Check to use the same debuff color/character/order settings for all of your characters"
MG_OPTIONS_CB33_TEXT = "Highlight Selected"
MG_OPTIONS_CB33_TIP = "Check to highlight the party member in MG when they are selected"
MG_OPTIONS_CB34_TEXT = "Show all color-blind indicators"
MG_OPTIONS_CB34_TIP = "Check to show all debuff indicators"
MG_OPTIONS_CB35_TEXT = "Show Player Combat Text"
MG_OPTIONS_CB35_TIP = "Check to show combat text over player status bars"
MG_OPTIONS_CB36_TEXT = "Show Pet Combat Text"
MG_OPTIONS_CB36_TIP = "Check to show combat text over pet status bars"
MG_OPTIONS_CB42_TEXT = "Group with Party"
MG_OPTIONS_CB42_TIP = "Check to include player frame in party group frame"
MG_OPTIONS_CB43_TEXT = "Flash"
MG_OPTIONS_CB43_TIP = "Check to flash the selected rest indicator when resting (rest indicators are not used for level 60 players)"
MG_OPTIONS_CB44_TEXT = "Flash"
MG_OPTIONS_CB44_TIP = "Check to flash the selected combat indicator when you are in combat"
MG_OPTIONS_CB45_TEXT = "Flash"
MG_OPTIONS_CB45_TIP = "Check to flash the selected aggro indicator when you an enemy acquires you as a target"
MG_OPTIONS_CB46_TEXT = "Show Bar Endcaps"
MG_OPTIONS_CB46_TIP = "Check to show the white indicators at the ends of the health/mana/xp bars"
MG_OPTIONS_CB47_TEXT = "Enable CastParty support"
MG_OPTIONS_CB47_TIP = "Check to allow customized actions for frame clicks (requires installation of CastParty and customization in CastParty configuration).\n\nNote: Kaitlin does not support the use of scripting to make healing decisions."
MG_OPTIONS_CB48_TEXT = "Show CastParty frame"
MG_OPTIONS_CB48_TIP = "Check to show the CastParty frame"
MG_OPTIONS_CB49_TEXT = "Always Show Party Frames"
MG_OPTIONS_CB49_TIP = "Check to persistently show the party frames so they do not hide"
MG_OPTIONS_CB50_TEXT = "Always Show Pet Frames"
MG_OPTIONS_CB50_TIP = "Check to persistently show the pet frame so it does not hide"
MG_OPTIONS_CB51_TEXT = "Use the global configuration"
MG_OPTIONS_CB51_TIP = "Check to use your global configuration for this character. The global configuration is shared between characters.\n\nChanges you save with this setting checked will save into the global configuration."
MG_OPTIONS_CB52_TEXT = "Enable for Target"
MG_OPTIONS_CB52_TIP = "Check to use CastParty click customization for the MiniGroup target.\n\nNOTE: Requires special version of CastParty.lua (included in MiniGroup zip file)"
MG_OPTIONS_CB53_TEXT = "Force MG Rightclick Menu"
MG_OPTIONS_CB53_TIP = "Check to use the MiniGroup right click menu instead of your CastParty right click setting"
MG_OPTIONS_CB54_TEXT = "Alt"
MG_OPTIONS_CB54_TIP = ""
MG_OPTIONS_CB55_TEXT = "Ctrl"
MG_OPTIONS_CB55_TIP = ""
MG_OPTIONS_CB56_TEXT = "Shift"
MG_OPTIONS_CB56_TIP = ""
MG_OPTIONS_CB57_TEXT = "Show MG Button on Minimap"
MG_OPTIONS_CB57_TIP = "Check to show the MiniGroup button on the minimap"
MG_OPTIONS_CB58_TEXT = "Hide MG Frames in Raid"
MG_OPTIONS_CB58_TIP = "Check to hide or show all MG frames (except target) when you join a raid"
MG_OPTIONS_CB59_TEXT = "Hide MG party Frames in Raid"
MG_OPTIONS_CB59_TIP = "Check to hide or show the MG party frames when you join a raid"
MG_OPTIONS_CB60_TEXT = "Always Show Party Pets"
MG_OPTIONS_CB60_TIP = "Check to persistently show the party pet frames so they do not hide (requires 'Always show party' to be enabled)"
MG_OPTIONS_CB61_TEXT = "Hide Groupleader Icons"
MG_OPTIONS_CB61_TIP = "Check to hide the leader and masterlooter icons"
MG_OPTIONS_CB62_TEXT = "Hide the PvP icons"
MG_OPTIONS_CB62_TIP = "Check to hide the PvP icon"
MG_OPTIONS_CB63_TEXT = "Always Show Raid Anchors"
MG_OPTIONS_CB63_TIP = "Check to show all the raid frame group anchors"
MG_OPTIONS_CB64_TEXT = "Always Show Raid Pet Frames"
MG_OPTIONS_CB64_TIP = "Check to persistently show the raid pet frames so they do not hide"
MG_OPTIONS_CB65_TEXT = "Group Raid Members"
MG_OPTIONS_CB65_TIP = "Check to combine member frames into one frame"

MG_OPTIONS_CB66_TEXT = "Show Party Combat Text"
MG_OPTIONS_CB66_TIP = "Check to show combat text over party status bars"
MG_OPTIONS_CB67_TEXT = "Show Party Pet Combat Text"
MG_OPTIONS_CB67_TIP = "Check to show combat text over party pet status bars"
MG_OPTIONS_CB68_TEXT = "Show Raid Combat Text"
MG_OPTIONS_CB68_TIP = "Check to show combat text over raid status bars"
MG_OPTIONS_CB69_TEXT = "Show Raid Pet Combat Text"
MG_OPTIONS_CB69_TIP = "Check to show combat text over raid pet status bars"
MG_OPTIONS_CB70_TEXT = "Show Target Combat Text"
MG_OPTIONS_CB70_TIP = "Check to show combat text over target status bar"
MG_OPTIONS_CB71_TEXT = "Show ToT Combat Text"
MG_OPTIONS_CB71_TIP = "Check to show combat text over the target of target status bar"

MG_OPTIONS_CB72_TEXT = "Use Independent Raid Scaling"
MG_OPTIONS_CB72_TIP = "Check to use independent raid scaling"

MG_OPTIONS_CB73_TEXT = "Group Raid Units by Class"
MG_OPTIONS_CB73_TIP = "Check to group raid units by their classes"

MG_OPTIONS_CB74_TEXT = "Show Raid Anchors"
MG_OPTIONS_CB74_TIP = "Check to show anchors available raid groups"

MG_OPTIONS_CB75_TEXT = "Hide Anchor Backgrunds"
MG_OPTIONS_CB75_TIP = "Check to hide the background frames of the anchors"

MG_OPTIONS_CB76_TEXT = "Use Raid Color Names"
MG_OPTIONS_CB76_TIP = "Check this to use standard raid colors for unit names"

MG_OPTIONS_CB77_TEXT = "Filter Auras"
MG_OPTIONS_CB77_TIP = "Check this to only display buffs and debuffs relevant to your class"

MG_OPTIONS_CB78_TEXT = "Color When Debuffed"
MG_OPTIONS_CB78_TIP = "Check this to color highlight the unit when debuffed"

MG_OPTIONS_CB79_TEXT = "Display Target/ToT Reaction"
MG_OPTIONS_CB79_TIP = "Check this to color the target/tot healthbar by reaction (friend, neutral, hostile, tagged)"

MG_OPTIONS_CB80_TEXT = "Hide Player Manabar"
MG_OPTIONS_CB80_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB81_TEXT = "Hide Player Frame"
MG_OPTIONS_CB81_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB82_TEXT = "Hide Party Manabars"
MG_OPTIONS_CB82_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB83_TEXT = "Hide Party Frames"
MG_OPTIONS_CB83_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB84_TEXT = "Hide Party Pet Manabars"
MG_OPTIONS_CB84_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB85_TEXT = "Hide Party Pet Frames"
MG_OPTIONS_CB85_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB86_TEXT = "Hide Raid Manabars"
MG_OPTIONS_CB86_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB87_TEXT = "Hide Raid Frames"
MG_OPTIONS_CB87_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB88_TEXT = "Hide Raid Pet Manabars"
MG_OPTIONS_CB88_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB89_TEXT = "Hide Raid Pet Frames"
MG_OPTIONS_CB89_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB90_TEXT = "Hide Target Manabar"
MG_OPTIONS_CB90_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB91_TEXT = "Hide Target Frame"
MG_OPTIONS_CB91_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB92_TEXT = "Hide ToT Manabar"
MG_OPTIONS_CB92_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB93_TEXT = "Hide ToT Frames"
MG_OPTIONS_CB93_TIP = "Check this hide this type of frame"

MG_OPTIONS_CB94_TEXT = "Hide Pet Manabar"
MG_OPTIONS_CB94_TIP = "Check this to remove the manabar from this type of frame"

MG_OPTIONS_CB95_TEXT = "Hide Pet Frame"
MG_OPTIONS_CB95_TIP = "Check this hide this type of frame"


-- New in MiniGroup2.h
MG_OPTIONS_CB150_TEXT = "Hide Player Cast Bars"
MG_OPTIONS_CB150_TIP = "Check this to hide the spell target cast bars."
MG_OPTIONS_CB151_TEXT = "Hide OOR Alerts"
MG_OPTIONS_CB151_TIP = "Check this to hide the target out of range alerts."
MG_OPTIONS_CB152_TEXT = "Hide Not Here Alerts"
MG_OPTIONS_CB152_TIP = "Check this to hide the Not Here (100 yards) alerts."
MG_OPTIONS_CB153_TEXT = "Show CTRaid Buff Times"
MG_OPTIONS_CB153_TIP = "Check this to show the remaining buff times imported from CTRaid.\n\nOnly works if you have CT_RaidAssist installed."
MG_OPTIONS_CB154_TEXT = "Hide NH Alert when Offline"
MG_OPTIONS_CB154_TIP = "Check this to hide the Not Here (100 yards) alerts when players are OFFLINE."
MG_OPTIONS_CB155_TEXT = "Use Big Health Fonts"
MG_OPTIONS_CB155_TIP = "Check this to apply a +2 font size increase to the health text.\n\nUseful when using Smart for health text, especially for yaABF.h."
MG_OPTIONS_CB156_TEXT = "Hide FSR Status"
MG_OPTIONS_CB156_TIP = "Check this to hide the FSR (Five Second Rule) status border indicator."
MG_OPTIONS_CB157_TEXT = "Hide FSR Status OOFSR"
MG_OPTIONS_CB157_TIP = "Check this to hide the FSR status border indicator when out of the Five Second Rule.\n\nThis will hide the blue border when you are IN COMBAT and out of the FSR."


MG_OPTIONS_COLOR1_TEXT = "Cast Bar Color"


MG_OPTIONS_SLIDE1_TEXT = ""
MG_OPTIONS_SLIDE1_TIP = "Adjust the scale of the MiniGroup Windows"

MG_OPTIONS_SLIDE3_TEXT = ""
MG_OPTIONS_SLIDE3_TIP = "Adjust the scale of the MiniGroup Raid Windows"

MG_OPTIONS_DD1 = {
	TEXT = "Aura Style",	--party aura style
	OPTIONS = 5,
	OPTION1_TEXT = "Show one line of auras",
	OPTION1_TIP =  "Debuffs will fill from the right, and buffs will fill remaining spots from the left, up to 10",
	OPTION2_TEXT = "Show two lines of auras",
	OPTION2_TIP =  "Show 2 lines of auras, up to 20",
	OPTION3_TEXT = "Show one line of debuffs",
	OPTION3_TIP =  "Debuffs will fill from the right, up to 10",
	OPTION4_TEXT = "Show two lines of debuffs",
	OPTION4_TIP =  "Show 2 lines of debuffs, up to 16",	
	OPTION5_TEXT = "Hide auras",
	OPTION5_TIP =  "Do not show auras on frame"

}


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
}

MG_OPTIONS_DD5 = {
	TEXT = "Aura Position",
	OPTIONS = 6,
	OPTION1_TEXT = "Float above",
	OPTION1_TIP =  "Auras will float above (outside) the frame",
	OPTION2_TEXT = "Float below",
	OPTION2_TIP =  "Auras will float below (outside) the frame",
	OPTION3_TEXT = "Float at right",
	OPTION3_TIP =  "Auras will float to the right (outside) of the frame",
	OPTION4_TEXT = "Float left",
	OPTION4_TIP =  "Auras will float to the left (outside) of the frame",
	OPTION5_TEXT = "Dock inside",
	OPTION5_TIP =  "Auras will appear inside of the frame",
	OPTION6_TEXT = "Automatic",
	OPTION6_TIP =  "Auras will appear on the left or the right side depending on frame position"
}

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
}

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
	OPTION6_TEXT = "No combat indicator",
	OPTION6_TIP =  "Never indicate that you are in combat"
}

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
	OPTION6_TEXT = "No aggro indicator",
	OPTION6_TIP =  "Never indicate that you have attracted aggravation"
}

MG_OPTIONS_DD9 = {
	TEXT = "MiniGroup frame style",
	OPTIONS = 7,
	OPTION1_TEXT = "Normal",
	OPTION1_TIP =  "Mingroup frame, 62 pixels high",
	OPTION2_TEXT = "Compact",
	OPTION2_TIP =  "Mingroup frame, 32 pixels high",
	OPTION3_TEXT = "Raid",
	OPTION3_TIP =  "Mingroup frame, 23 pixels high",
	OPTION4_TEXT = "Pet",
	OPTION4_TIP =  "Special pet-style",
	OPTION5_TEXT = "ABF",
	OPTION5_TIP =  "ABF-style",
	OPTION6_TEXT = "ABF(simple)",
	OPTION6_TIP =  "ABF-style, without mana bar",
	OPTION7_TEXT = "Hidden",
	OPTION7_TIP =  "Hides the frame"	
}

MG_OPTIONS_DD13 = {
	TEXT = "Health/mana text (right)", --Player
	OPTIONS = 5, --sai increased options by one
	OPTION1_TEXT = "Absolute points",
	OPTION1_TIP =  "Show hit points/mana points./nExample: 800/1000",
	OPTION2_TEXT = "Percent",
	OPTION2_TIP =  "Show percentage of full health/mana./nExample: 80%",
--sai changed label
	OPTION3_TEXT = "Absolute/Difference (points)",
	OPTION3_TIP =  "Show missing health/mana./nExample: 200",
	OPTION4_TEXT = "Hide text (show full size bars)",
	OPTION4_TIP =  "Do not show any health/mana text",
--sai smart style
	OPTION5_TEXT = "Smart",
	OPTION5_TIP =  "HP: Only show the differenz / MP: Show current mana",
}

MG_OPTIONS_DD14 = {
	TEXT = "Grouping",
	OPTIONS = 2,
	OPTION1_TEXT = "Group with owner",
	OPTION1_TIP =  "Group the pet into the owner's frame",
	OPTION2_TEXT = "Do not group",
	OPTION2_TIP =  "Keep the pet frame separate"
}

MG_OPTIONS_DD15 = {
	TEXT = "Frame Growth",
	OPTIONS = 2,
	OPTION1_TEXT = "Grow down",
	OPTION1_TIP =  "Frames are added to the bottom of the first frame",
	OPTION2_TEXT = "Grow up",
	OPTION2_TIP =  "Frames are added to the top of the first frame",
--	OPTION3_TEXT = "Grow right",
--	OPTION3_TIP =  "Frames are added to the right of the first frame",
--	OPTION4_TEXT = "Grow left",
--	OPTION4_TIP =  "Frames are added to the left of the first frame"
}

MG_OPTIONS_DD16 = {
	TEXT = "MiniGroup right click menu",
	OPTIONS = 4,
	OPTION1_TEXT = "Left button",
	OPTION1_TIP =  "",
	OPTION2_TEXT = "Right button",
	OPTION2_TIP =  "",
	OPTION3_TEXT = "Middle button",
	OPTION3_TIP =  "",
	OPTION4_TEXT = "Use CastParty setting",
	OPTION4_TIP =  ""
}

MG_OPTIONS_DD17 = {
	TEXT = "Health/mana text (center)", --Player
	OPTIONS = 5, --sai increased options by one
	OPTION1_TEXT = "Absolute points",
	OPTION1_TIP =  "Show hit points/mana points./nExample: 800/1000",
	OPTION2_TEXT = "Percent",
	OPTION2_TIP =  "Show percentage of full health/mana./nExample: 80%",
	OPTION3_TEXT = "Absolute/Difference (points)",
	OPTION3_TIP =  "Show missing health/mana./nExample: 200",
	OPTION4_TEXT = "Hide text (show full size bars)",
	OPTION4_TIP =  "Do not show any health/mana text",
--sai smart style
	OPTION5_TEXT = "Smart",
	OPTION5_TIP =  "HP: Only show the differenz / MP: Show current mana",
}

MG_OPTIONS_DD18 = {
	TEXT = "Border Style", --Player
	OPTIONS = 3,
	OPTION1_TEXT = "Original Style",
	OPTION1_TIP =  "Normal style MiniGroup2 frame borders",
	OPTION2_TEXT = "Nurfed Style",
	OPTION2_TIP =  "Nurfed Unit Frames style MiniGroup2 borders",
	OPTION3_TEXT = "None",
	OPTION3_TIP =  "Hide all MiniGroup2 frame borders",
}

MG_OPTIONS_DD19 = {
	TEXT = "Bar Style", --Player
	OPTIONS = 3, -- sai options increased by one
	OPTION1_TEXT = "Original Style",
	OPTION1_TIP =  "Normal style MiniGroup2 bars",
	OPTION2_TEXT = "ABF Style",
	OPTION2_TIP =  "AceBarFrames style MiniGroup2 bars",
--sai new barstyle
	OPTION3_TEXT = "Smooth Style",
	OPTION3_TIP =  "Smooth style MiniGroup2 bars",
}

--MG_OPTIONS_SUBFRAME2_TEXT = "NOTE: Enabling target requires special version of CastParty.lua (see zip file)"

-- General Tab
MG_OPTIONS_SUBFRAME1 = "General"
MG_OPTIONS_SUBFRAME2 = "Other Addon Support"
MG_OPTIONS_SUBFRAME3 = "Layout"
-- Player Tab
MG_OPTIONS_SUBFRAME4 = "Player Options"
MG_OPTIONS_SUBFRAME5 = ""	--13
MG_OPTIONS_SUBFRAME6 = ""  --19
-- Pet Tab
MG_OPTIONS_SUBFRAME7 = "Player Pet Options" --11
MG_OPTIONS_SUBFRAME8 = ""	--17
MG_OPTIONS_SUBFRAME9 = ""	--18
-- Party Tab
MG_OPTIONS_SUBFRAME10 = "Party Options" --6
MG_OPTIONS_SUBFRAME11 = ""	--12
MG_OPTIONS_SUBFRAME12 = ""	--14
-- Party Pet Tab
MG_OPTIONS_SUBFRAME13 = "Party Pet Options" --20
MG_OPTIONS_SUBFRAME14 = ""	--21
MG_OPTIONS_SUBFRAME15 = ""	--22
-- Target Tab
MG_OPTIONS_SUBFRAME16 = "Target Options"
MG_OPTIONS_SUBFRAME17 = ""	--15
MG_OPTIONS_SUBFRAME18 = ""	--16
-- Debuff Tab
MG_OPTIONS_SUBFRAME19 = "Raid Options"
MG_OPTIONS_SUBFRAME20 = ""	--9
MG_OPTIONS_SUBFRAME21 = ""	--10

MG_OPTIONS_SUBFRAME22 = "Raid Pet Options"
MG_OPTIONS_SUBFRAME23 = ""	--9
MG_OPTIONS_SUBFRAME24 = ""	--10

MG_OPTIONS_SUBFRAME25 = "Target of Target Options"
MG_OPTIONS_SUBFRAME26 = ""	--9
MG_OPTIONS_SUBFRAME27 = ""	--10

MG_OPTIONS_SUBFRAME28 = "Other Options"
MG_OPTIONS_SUBFRAME29 = "Theme Options"

-- Tab / Dropdown Text
MG_OPTIONS_TABS_GENERAL = "General"
MG_OPTIONS_TABS_PLAYER  = "Player"
MG_OPTIONS_TABS_PET     = "Pet"
MG_OPTIONS_TABS_PARTY   = "Party"
MG_OPTIONS_TABS_PARTYPETS = "Party Pets"
MG_OPTIONS_TABS_RAID = "Raid"
MG_OPTIONS_TABS_RAIDPETS = "Raid Pets"
MG_OPTIONS_TABS_TARGET  = "Target"
MG_OPTIONS_TABS_OTHERS  = "Others"
MG_OPTIONS_TABS_VERSION = "TBD"

MG_OPTIONS_DEFAULTS_TOOLTIP1 = "Clear all settings"
MG_OPTIONS_DEFAULTS_TOOLTIP2 = "-Warning-\n\nClicking this will reset all of your settings to defaults.  You cannot cancel this action."
MG_OPTIONS_GLOBAL_TOOLTIP1   = "Load global settings"
MG_OPTIONS_GLOBAL_TOOLTIP2   = "-Warning-\n\nClicking this will reset all of your settings to the global settings.  You cannot cancel this action."
end
