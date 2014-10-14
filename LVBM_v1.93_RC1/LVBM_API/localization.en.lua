-- -------------------------------------------- --
-- La Vendetta Boss Mods - english localization --
--          by Destiny|Tandanu                  --
-- -------------------------------------------- --

--classes
LVBM_MAGE		= "Mage";
LVBM_PRIEST		= "Priest";
LVBM_PALADIN		= "Paladin";
LVBM_DRUID		= "Druid";
LVBM_WARLOCK		= "Warlock";
LVBM_ROGUE		= "Rogue";
LVBM_HUNTER		= "Hunter";
LVBM_WARRIOR		= "Warrior";
LVBM_SHAMAN		= "Shaman";

--zones
LVBM_NAXX			= "Naxxramas";
LVBM_AQ40			= "Ahn'Qiraj";
LVBM_BWL			= "Blackwing Lair";
LVBM_MC				= "Molten Core";
LVBM_AQ20			= "Ruins of Ahn'Qiraj";
LVBM_ZG 			= "Zul'Gurub";
LVBM_ONYXIAS_LAIR	= "Onyxia's Lair";
LVBM_DUSKWOOD		= "Duskwood";
LVBM_ASHENVALE		= "Ashenvale";
LVBM_FERALAS		= "Feralas";
LVBM_HINTERLANDS	= "The Hinterlands";
LVBM_BLASTED_LANDS	= "Blasted Lands";
LVBM_AZSHARA		= "Azshara";
LVBM_OTHER			= "Other";

--Gui Tabs
LVBMGUI_TAB_NAXX				= "Naxxramas";		-- DONT TRANSLATE !!!
LVBMGUI_TAB_AQ40				= "Ahn'Qiraj";		-- DONT TRANSLATE !!!
LVBMGUI_TAB_BWL					= "BlackWingLair";	-- DONT TRANSLATE !!!
LVBMGUI_TAB_MC					= "Molten Core";	-- DONT TRANSLATE !!!
LVBMGUI_TAB_20PL				= "20 Player";		-- DONT TRANSLATE !!!
LVBMGUI_TAB_OTHER				= "Other";		-- DONT TRANSLATE !!!


--spells/buffs
LVBM_CHARGE			= "Charge";
LVBM_FERALCHARGE		= "Feral Charge";
LVBM_BLOODRAGE			= "Bloodrage";
LVBM_REDEMPTION 		= "Spirit of Redemption";
LVBM_FEIGNDEATH			= "Feign Death";
LVBM_MINDCONTROL		= "Mind Control";

--create status bar timer localization table
LVBM_SBT = {};

--key bindings
BINDING_HEADER_LVBM 		= "La Vendetta Boss Mods";
BINDING_NAME_TOGGLE 		= "Toggle GUI";

--OnLoad messages
LVBM_LOADED			= "La Vendetta Boss Mods v%s by La Vendetta|Nitram @ EU-Azshara and DeadlyMinds|Tandanu @ EU-Aegwynn loaded.";
LVBM_MODS_LOADED		= "%s %s boss mods loaded."

--Slash command messages
LVBM_MOD_ENABLED		= "Boss mod enabled.";
LVBM_MOD_DISABLED		= "Boss mod disabled.";
LVBM_ANNOUNCE_ENABLED		= "Announce enabled.";
LVBM_ANNOUNCE_DISABLED		= "Announce disabled.";
LVBM_MOD_STOPPED		= "Timers stopped.";
LVBM_MOD_INFO			= "Boss mod v%s by %s";
LVBM_SLASH_HELP1		= " on/off";
LVBM_SLASH_HELP2		= " announce on/off";
LVBM_SLASH_HELP3		= " stop";
LVBM_SLASH_HELP4		= "You can use %s instead of /%s.";
LVBM_RANGE_CHECK		= "More than 30 yards away: ";
LVBM_FOUND_CLIENTS		= "Found %s players with Vendetta Boss Mods";

--Sync options
LVBM_SOMEONE_SET_SYNC_CHANNEL	= "%s set the sync channel to: %s";
LVBM_SET_SYNC_CHANNEL		= "Sync channel set to: %s";
LVBM_CHANNEL_NOT_SET		= "Channel not set. Cannot broadcast.";
LVBM_NEED_LEADER		= "You need to be promoted or leader to broadcast the channel!";
LVBM_NEED_LEADER_STOP_ALL	= "You need to be promoted or leader to use this function!";
LVBM_ALL_STOPPED		= "Stopped all timers.";
LVBM_REC_STOP_ALL		= "Received stop all command from %s.";

--Update dialog
LVBM_UPDATE_DIALOG		= "Your version of La Vendetta Boss Mods is out of date!\n%s and %s got version %s.\nPlease visit www.curse-gaming.com to get the latest version.";
LVBM_YOUR_VERSION_SUCKS	= "Your version of La Vendetta Boss Mods is out of date! Please visit www.curse-gaming.com to get the latest version.";
LVBM_REQ_PATCHNOTES		= "Requesting patch notes from %s...please wait.";
LVBM_SHOW_PATCHNOTES		= "Show patch notes";
LVBM_PATCHNOTES			= "Patch Notes";
LVBM_COPY_PASTE_URL		= "Copy & paste URL";
LVBM_COPY_PASTE_NOW		= "Press ctrl-c to copy the URL to the clipboard";

--Status Bar Timers
LVBM_SBT_TIMELEFT				= "Time left:";
LVBM_SBT_TIMEELAPSED			= "Time elapsed:";
LVBM_SBT_TOTALTIME				= "Total time:";
LVBM_SBT_REPETITIONS			= "Repetitions:";
LVBM_SBT_INFINITE				= "infinite";
LVBM_SBT_BOSSMOD				= "Boss mod:";
LVBM_SBT_STARTEDBY				= "Started by:";
LVBM_SBT_RIGHTCLICK				= "Right-click on the bar to hide it.";
LVBM_SBT_LEFTCLICK				= "Shift + left-click on the bar to announce it";
LVBM_TIMER_IS_ABOUT_TO_EXPIRE	= "Timer \"%s\" is about to expire!";
LVBM_BAR_STYLE_DEFAULT			= "Default";
LVBM_BAR_STYLE_MODERN			= "Modern";
LVBM_BAR_STYLE_CLOUDS			= "Clouds";
LVBM_BAR_STYLE_PERL				= "Perl";


--Combat messages
LVBM_BOSS_ENGAGED			= "%s engaged. Good luck and have fun! :)";
LVBM_BOSS_SYNCED_BY			= "(received sync command from %s)";
LVBM_BOSS_DOWN				= "%s down after %s!";
LVBM_COMBAT_ENDED			= "Combat ended after %s.";
LVBM_DEFAULT_BUSY_MSG			= "%P is busy. (Fighting against %B - %HP - %ALIVE/%RAID people alive) You will be informed after the fight.";
LVBM_RAID_STATUS_WHISPER		= "%B - %HP - %ALIVE/%RAID people alive.";
LVBM_SEND_STATUS_INFO			= "Whisper \"status\" to query the raid's status.";
LVBM_AUTO_RESPOND_SHORT			= "Auto-responded.";
LVBM_AUTO_RESPOND_LONG			= "Auto-responded to a whisper from %s";
LVBM_MISSED_WHISPERS			= "Missed whispers during combat:";
LVBM_SHOW_MISSED_WHISPER		= "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
LVBM_BALCONY_PHASE			= "Balcony phase #%s";

--Misc stuff
LVBM_YOU					= "You";
LVBM_ARE					= "are";
LVBM_IS						= "is";
LVBM_OR						= "or";
LVBM_AND					= "and";
LVBM_UNKNOWN			 		= "unknown";
LVBM_LOCAL					= "local";
LVBM_DEFAULT_DESCRIPTION			= "Description not available.";
LVBM_SEC					= "sec";
LVBM_MIN					= "min";
LVBM_SECOND					= "second";
LVBM_SECONDS					= "seconds";
LVBM_MINUTES					= "minutes";
LVBM_MINUTE					= "minute";
LVBM_HIT					= "hit";
LVBM_HITS					= "hits";
LVBM_CRIT					= "crit";
LVBM_CRITS					= "crits";
LVBM_MISS					= "miss";
LVBM_DODGE					= "dodge";
LVBM_PARRY					= "parry";
LVBM_FROST					= "Frost";
LVBM_ARCANE					= "Arcane";
LVBM_FIRE					= "Fire";
LVBM_HOLY					= "Holy";
LVBM_NATURE					= "Nature";
LVBM_SHADOW					= "Shadow";
LVBM_CLOSE					= "Close";
LVBM_AGGRO_FROM					= "Aggro from ";
LVBM_SET_ICON					= "Set icon";
LVBM_SEND_WHISPER				= "Send whisper";
LVBM_DEAD					= "Dead";
LVBM_OFFLINE					= "Offline";
LVBM_PHASE					= "Phase %s";
LVBM_WAVE					= "Wave %s";


-- Added 11.11.06
LVBM_NOGUI_ERROR				= "Sorry, please activate the LVBM GUI to access this function";
LVBM_NOSYNCBARS					= "Currently there are no bars";





