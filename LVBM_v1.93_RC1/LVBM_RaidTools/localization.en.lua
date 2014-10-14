


LVRT_SLASHHELP			= {
	"Welcome to the La Vendetta Raid Tools /lvrt",
	"list of the slash commands:",
	" ",
	"/lvrt logout <name> - this logs a player out of the game after 20 sec",
	"/lvrt pull <x> - Announces a pull in X sec (alias: /pull <x>)",
	"/lvrt enable <addon> <player> - Enables an AddOn for the specific player (player can be 'all')",
	"/lvrt disable <addon> <player> - Disables an AddOn for the specific player (player can be 'all')",
	"/lvrt announce <addon> <player> <on|off> - Disables/enables announce for an AddOn for the specific player (player can be 'all')",
	"/lvrt bosslist - shows a list of correct AddOn names",
	"/lvrt emote <emote> [target] - Forces a raid member to do an emote on 'target' (optional)",
	"/lvrt remote <on|off> - Enables/Disables remote commands",
	"/lvrt ver - Checks for other versions of LV Raid Tools",
	" ",
	"Thanks for using La Vendetta Raid Tools",
}

LVRT_CHAT_PREFIX		= "<LV_RaidTools> ";
LVRT_SENDLOGOUT			= "Sending logout command to: %s";
LVRT_SENDLOGOUT_RAID_NOTICE	= LVRT_CHAT_PREFIX.."received logout command from %s - logging out...";
LVRT_SENDLOGOUT_NEED_NAME	= "Incorrect name or unknown problem, can't send logout command";

LVRT_PULLCOMMAND_ANNOUNCE	= "*** Incoming Pull ***";
LVRT_PULLCOMMAND_SELFWARN	= "PULL NOW";
LVRT_PULLCOMMAND_PREWARN	= "*** Pull in %d sec ***";
LVRT_PULLCOMMAND_FAILED		= "Please use /pull 10 or /lvrt pull 10";

LVRT_VERSION_WHISPER		= "LV RaidTools v%s";
LVRT_VERSION_MESSAGE		= "Checking for other LVBM RaidTools versions";

LVRT_COMMAND_FAILD		= "Please check the '/lvrt help' command, your command is unknown";

LVRT_ENABLEADDON_MESSAGE	= "Sending 'Enable' AddOn command to '%s'";
LVRT_DISANABLEADDON_MESSAGE	= "Sending 'Disable' AddOn command to '%s'";

LVRT_ANNOUNCEON_MESSAGE		= "Sending 'Announce ON' AddOn command to '%s'";
LVRT_ANNOUNCEOFF_MESSAGE	= "Sending 'Announce OFF' AddOn command to '%s'";

LVRT_REMOTE_ON			= "Remote commands enabled";
LVRT_REMOTE_OFF			= "Remote commands disabled";

LVRT_EMOTE_MESSAGE		= "Sending raid emote '%s'";
LVRT_EMOTE_RECIVE		= "Recived emote command from '%s'";

