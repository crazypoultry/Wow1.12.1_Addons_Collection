-- Binding Configuration
BINDING_HEADER_AUTOTARGET     = "AutoTarget"
BINDING_NAME_AUTOTARGETSELECT = "Toggle selection on/off"
BINDING_NAME_AUTOTARGETCONFIG = "Toggle config. window"
BINDING_NAME_AUTOTARGETTARGET = "Target of current target"
BINDING_NAME_AUTOTARGETCLEAR  = "Clear the current target"

-- Text labels
AT_TITLE    = "AutoTarget Config."
AT_LEVELS   = "Levels"
AT_ON       = "On"
AT_OFF      = "Off"
AT_MIN      = "Min"
AT_MAX      = "Max"
AT_HEALTH   = "Max Health %"
AT_NAME     = "Name"
AT_ANY      = "Any %s"
AT_TYPE     = "Type"
AT_CLASS    = "Class"
AT_FAMILY   = "Family"
AT_CHARMED  = "Target charmed."
AT_CIVILIAN = "Target civilians."
AT_CRITTER  = "Target critters."
AT_DEADLY   = "Target deadlies."
AT_ELITE    = "Target elite."
AT_ENEMY    = "Target enemies."
AT_FRIEND   = "Target friendly."
AT_MARKED   = "Target marked."
AT_MYKILL   = "Target my kills."
AT_NEUTRAL  = "Target neutrals."
AT_NOTMINE  = "Target not mine."
AT_PLAYER   = "Target players."
AT_PVP      = "Target PvP flagged."
AT_SKIN     = "Target skinnables."
AT_TARGME   = "Target targeting me."
AT_TRIVIAL  = "Target trivials."
AT_SET      = "Set"
AT_CLEAR    = "Clear"
AT_DFLTON   = "Default-to-On is "
AT_PVPLOG   = "PvP target log is "
AT_NOLOG    = "No PvP target log entries."
AT_LIST     = "Current PvP target log:"
AT_DEBUG    = "Debug tracing "
AT_UNKNOWN  = "Unknown command: "

-- Menus
AT_TYPE_NAMES  = {'Beast','Critter','Demon','Dragonkin','Elemental','Giant',
                  'Humanoid','Mechanical','Not specified','Undead'};
AT_CLASS_NAMES = {'Druid','Hunter','Mage','Paladin','Priest','Rogue','Shaman','Warlock','Warrior'};
AT_FAMILY_NAMES= {'Bat','Bear','Boar','Carrion Bird','Cat','Crab','Crocolisk','Gorilla','Hyena',
                  'Owl','Raptor','Scorpid','Spider','Tallstrider','Turtle','Wind Serpent','Wolf'};

-- Tooltips
AT_ON_TIP       = "Enables target selection."
AT_CLICK_TIP    = "Click to copy target name."
AT_MENU_TIP     = "Click to select attribute names."
AT_REQUIRED_TIP = "Select to make this a required attribute."
AT_CHARMED_TIP  = "Charmed targets don't fight unless attacked."
AT_CIVILIAN_TIP = "Civilians targets are dishonorable kills."
AT_CRITTER_TIP  = "Critters give no XP, but may be skinned."
AT_DEADLY_TIP   = "Deadly targets have a skull level and will usually kill you."
AT_ELITE_TIP    = "Elites are much harder to kill for their level."
AT_ENEMY_TIP    = "Enemies have red names and may attack."
AT_FRIEND_TIP   = "Friendlies have green names and can't be attacked."
AT_MYKILL_TIP   = "My kills are targets which I (or my group) can loot."
AT_MARKED_TIP   = "Targets with the Hunter's Mark debuf."
AT_SKIN_TIP     = "Beast corpses that can be skinned if you have the skill."
AT_NEUTRAL_TIP  = "Neutrals have yellow names and don't attack."
AT_NOTMINE_TIP  = "Targets that belong to someone else can't be looted."
AT_PLAYER_TIP   = "Only flagged enemy players may be attacked."
AT_PVP_TIP      = "Attacking PvP flagged targets sets your PvP flag."
AT_TARGME_TIP   = "Units targeting you are watching or attacking you."
AT_TRIVIAL_TIP  = "Trivial targets give no XP, but may have loot."

-- Help text
AT_Help = { ['?'] = 'AutoTarget';
	at = { ['?'] = "The main chat command",
		  [''] = "Toggle auto-targeting on or off",
		  config = "Toggle the configuration window",
		  debug = "Toggle debug tracing",
		  list = "Display the PvP target log",
		  log = "Toggle PvP target logging",
		  on = "Toggle auto-targeting default on login on or off", };
	}
