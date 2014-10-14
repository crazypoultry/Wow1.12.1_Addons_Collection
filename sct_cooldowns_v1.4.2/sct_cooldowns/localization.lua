SCTC_NAME = "SCT Cooldowns";
SCTC_SHORTNAME = "SCTC";
SCTC_VERSION = "1.4.2";


SCTC_LOADMSG = SCTC_NAME.." v"..SCTC_VERSION.." loaded. |c000064ff/sctc|r for help.";

SCTC_MSG 		    = "|c000064ff"..SCTC_NAME..":|r ";
SCTC_TURNEDON		= SCTC_MSG.."Turned |c0000ff00on|r.";
SCTC_ALREADYON		= SCTC_MSG.."Already on.";
SCTC_TURNEDOFF		= SCTC_MSG.."Turned |c00ff0000off|r.";
SCTC_ALREADYOFF		= SCTC_MSG.."Already off.";
SCTC_FORMATRESET	= SCTC_MSG.."Format |c00ff0000reset|r.";
SCTC_FORMATSET		= SCTC_MSG.."Format |c0000ff00set|r: ";
SCTC_FORMATERROR	= SCTC_MSG.."|c00ff0000There a error in the format string.|r";
SCTC_COLORSET		= SCTC_MSG.."Color |c0000ff00set|r.";
SCTC_CRITTRUE		= SCTC_MSG.."The message will now show as |c0000ff00a crit|r.";
SCTC_CRITFALSE		= SCTC_MSG.."The message will now show as |c00ff0000normal|r.";
SCTC_DISABLED		= SCTC_MSG.."The spell is now |c00ff0000disabled|r.";
SCTC_ENABLED		= SCTC_MSG.."The spell is now |c0000ff00enabled|r.";
SCTC_DISABLEDLIST	= SCTC_MSG.."These spells are disabled:";
SCTC_WARNINGDISABLED	= SCTC_MSG.."Warning is now |c00ff0000disabled|r.";
SCTC_WARNINGENABLED	= SCTC_MSG.."Warning is now set: |c0000ff00";


SCTC_HELP = {
	[1] = SCTC_NAME.." v"..SCTC_VERSION.." by Bonecleaver (Burning Legion EU)\n",
	[2] = "/sctc or /sctcooldowns for help.\n",
	[3] = "/sctc [on/off] : Turn SCTC on/off.\n",
	[4] = "/sctc format [string/reset] : Change the format string, or reset (%s is replaced by the spell name).\n",
	[5] = "/sctc color [red(0.0-1.0)] [green(0.0-1.0)] [blue(0.0-1.0)] : Change the color of the message (color value range is 1.0 to 0.0).\n",
	[6] = "/sctc crit [true/false] : Show message like a crit.\n",
	[7] = "/sctc disable [spell name] : Disable the message for that spell. Run it again to enable.\n",
	[8] = "/sctc list : Spells currently disabled.\n",
	[9] = "/sctc warning [seconds] : Show a warning x seconds before cooldown finishes (0 to disable).\n",
	[10] = "/sctc wformat [string/reset] : Change the format string of the warning message, or reset (%s is replaced by the spell name).",
};

SCTC_RENATAKI = "Renataki's Charm of Beasts";
SCTC_RENATAKI_SPELLS = {
	[1] = "Aimed Shot",
	[2] = "Multi-Shot",
	[3] = "Arcane Shot",
	[4] = "Volley",
};

SCTC_CS = "Cold Snap";
SCTC_CS_SPELLS = {
	[1] = "Frost Nova",
	[2] = "Ice Barrier",
	[3] = "Cone of Cold",
	[4] = "Ice Block",
	[5] = "Frost Ward",
};

SCTC_PREP = "Preparation";
SCTC_PREP_SPELLS = {
	[1] = "Vanish",
	[2] = "Cold Blood",
	[3] = "Sprint",
	[4] = "Premeditation",
	[5] = "Blind",
	[6] = "Evasion",
	[7] = "Kick",
	[8] = "Kidney Shot",
	[9] = "Ghostly Strike",
	[10] = "Distract",
	[11] = "Feint",
};

SCTC_GROUPS = {
	["Arcane/Aimed Shot"] = {
		[1] = "Arcane Shot",
		[2] = "Aimed Shot",
	},
	["Traps"] = {
		[1] = "Freezing Trap",
		[2] = "Immolation Trap",
		[3] = "Explosive Trap",
		[4] = "Frost Trap",
	},
	["Reta/SW/Reck"] = {
		[1] = "Retaliation",
		[2] = "Shield Wall",
		[3] = "Recklessness",
	},
	["Shocks"] = {
		[1] = "Earth Shock",
		[2] = "Flame Shock",
		[3] = "Frost Shock",
	},
	["Wards"] = {
		[1] = "Frost Ward",
		[2] = "Fire Ward",
	},
};