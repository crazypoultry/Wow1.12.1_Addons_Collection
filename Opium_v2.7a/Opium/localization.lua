OPIUM_TEXT_LASTSEEN = "Last Seen";
OPIUM_TEXT_NAME = "Name";
OPIUM_TEXT_LEVEL = "Level";
OPIUM_TEXT_CLASS = "Class";
OPIUM_TEXT_GUILD = "Guild";
OPIUM_TEXT_FACTION = "Faction";
OPIUM_TEXT_KILLS = "Kills";
OPIUM_TEXT_DEATHS = "Deaths";

OPIUM_TEXT_ALL = "All";
OPIUM_TEXT_PLAYERSEARCH = "Player Search";
OPIUM_TEXT_PLAYERPURGE = "Player Purge";
OPIUM_TEXT_MATCHES = "matches";
OPIUM_TEXT_OF = "of";
OPIUM_TEXT_LEVEL = "Level";

OPIUM_TEXT_KOSPLAYER = "KoS Player";
OPIUM_TEXT_KOSGUILD = "KoS Guild";
OPIUM_TEXT_KILLSDEATHS = "Kills/Deaths";
OPIUM_TEXT_LASTSEEN = "Last seen";
OPIUM_TEXT_AGO = "ago";
OPIUM_TEXT_SEEN = "seen";

--- Slash command config section, not too important.
OPIUM_TEXT_OPIUMHELP = "Opium help:";
OPIUM_TEXT_HELP1 = "Display servers/records stored.";
OPIUM_TEXT_HELP2 = "Specify which players to store automatically. Default is all.";
OPIUM_TEXT_HELP3 = "Delete all Opium data.";
OPIUM_TEXT_HELP4 = "Delete all timestamps.";
OPIUM_TEXT_HELP5 = "Looks up a player if the player name is supplied. Otherwise shows the main Opium window.";
OPIUM_TEXT_HELP6 = "Displays guild KoS list, or adds a guild to it if arguments are specified";
OPIUM_TEXT_HELP7 = "Displays player KoS list, or adds a player to if it arguments are specified";
OPIUM_TEXT_HELP8 = "Toggle showing the guildname in player tooltip";
OPIUM_TEXT_HELP9 = "Toggle keeping track of PvP and duel wins/losses";
OPIUM_TEXT_HELP10 = "Choose which chat frame Opium should print messages to. 1 is general, 2 is combat etc";
OPIUM_TEXT_HELP11 = "Toggle text alert when seeing a KoS'ed player";
OPIUM_TEXT_HELP12 = "Toggle sound alert when seeing a KoS'ed player";
OPIUM_TEXT_HELP13 = "Import data from the Kill on Sight (aka. Player Notes) AddOn";
OPIUM_TEXT_HELP14 = "Toggle minimap button";
OPIUM_TEXT_IMPORTINGDATA = "Importing data:";
OPIUM_TEXT_RECORDSIMPORTED = "records imported";
OPIUM_TEXT_MINIMAPBUTTONSHOWN = "Opium minimap button shown.";
OPIUM_TEXT_MINIMAPBUTTONNOTSHOWN = "Opium minimap button not shown.";
OPIUM_TEXT_SHOWTEXTALERT = "Opium will now show a text alert when seeing a KoS'ed player";
OPIUM_TEXT_NOTSHOWTEXTALERT = "Opium will not show a text alert when seeing a KoS'ed player";
OPIUM_TEXT_SOUNDALERT = "Opium will now play a sound when seeing a KoS'ed player";
OPIUM_TEXT_NOTSOUNDALERT = "Opium will not play a sound when seeing a KoS'ed player";
OPIUM_TEXT_CHATFRAMEISNOW = "Opium chatframe is now";
OPIUM_TEXT_TRACKPVPSTATS = "Opium will now track PvP kill stats";
OPIUM_TEXT_NOTPVPSTATS = "Opium will not track PvP kill stats";
OPIUM_TEXT_NOTGUILDNAMES = "Opium will no longer show guild names in player tooltip";
OPIUM_TEXT_GUILDNAMES = "Opium will now show guild names in player tooltip";
OPIUM_TEXT_DBRECORDS = "Opium database records";
OPIUM_TEXT_PLAYERRECORDS = "player records.";
OPIUM_TEXT_KOSEDPLAYERS = "KoSed players.";
OPIUM_TEXT_KOSEDGUILDS = "KoSed guilds.";
OPIUM_TEXT_DELETINGTIMESTAMPS = "Deleting all timestamps.";
OPIUM_TEXT_CURRENTLYSTORE = "Opium will currently store";
OPIUM_TEXT_NOTARGETS = "no targets.";
OPIUM_TEXT_ALLIEDTARGETS = "allied targets.";
OPIUM_TEXT_ENEMYTARGETS = "enemy targets.";
OPIUM_TEXT_INCOMBATWITH = "everyone you're involved in combat with.";
OPIUM_TEXT_ALLTARGETS = "all targets.";
OPIUM_TEXT_NOWSTORE = "Opium will now store ";
OPIUM_TEXT_DELETEALLWARNING = "Warning: This will erase ALL Opium data.";
OPIUM_TEXT_CAPDO = "Do";
OPIUM_TEXT_DELETEALL = "to delete it all.";
OPIUM_TEXT_LONGDELETIONMSG = "All Opium data deleted. If you regret doing this, " ..
	       "Alt+Tab to Windows, make a copy of the SavedVariables.lua file in " ..
	       "the WTF\\Account\\'your account name'\\ directory. Log out of the game, replace " ..
	       "the current SavedVariables.lua file with the copy you made, and re-enter the game.";
OPIUM_TEXT_INVALIDCOMMAND = "Invalid Opium command";


OPIUM_TEXT_DATACONVERTED = "Opium: Data converted to new internal format.";
OPIUM_TEXT_CONVERTINGTABLES = "Opium: Converting KoS tables to be server specific.";
OPIUM_TEXT_CONVERSIONCOMPLETE = "Opium: Conversion complete.";
OPIUM_TEXT_CONVERTANDCOMPRESS = "Opium: Converting and compressing database to new version.";
OPIUM_TEXT_KOSLISTFOUND = "Opium: Player Notes addon found. Type '/op import' to import data to Opium";
OPIUM_TEXT_MYADDONSDESCRIPTION = "KoS lists / player database";

OPIUM_TEXT_WELCOMEMSG = "loaded. '/pwho' for main window, '/op' for console commands";

OPIUM_TEXT_PLAYERNOTINDB = "Player not in database";
OPIUM_TEXT_THEUNKNOWNLEVEL = "the unknown level";
OPIUM_TEXT_THELEVEL = "the level";


-- Text in the main window
OPIUM_TEXT_RESET = "Reset";
OPIUM_TEXT_SEARCH = "Search";
OPIUM_TEXT_PURGE = "Purge";
OPIUM_TEXT_KOSPLAYERS = "KoS Players";
OPIUM_TEXT_KOSGUILDS = "KoS Guilds";
OPIUM_TEXT_OPTIONS = "Options";
OPIUM_TEXT_PVPSTATS = "PvP Stats";

-- Text in the search and purge frame
OPIUM_TEXT_PLAYERNAME = "Player name";
OPIUM_TEXT_MINIMUMLEVEL = "Minimum level";
OPIUM_TEXT_MAXIMUMLEVEL = "Maximum level";
OPIUM_TEXT_RACE = "Race";
OPIUM_TEXT_GUILDNAME = "Guild name";
OPIUM_TEXT_CANCEL = "Cancel";
OPIUM_TEXT_OKAY = "OK";
OPIUM_TEXT_PURGEWARNING = "Are you SURE want to purge the player data matching your criteria? This " ..
                          "will also erase all PvP records for the purged players.";
OPIUM_TEXT_YES = "Yes";
OPIUM_TEXT_NO = "No";

-- Minimap button tooltip text
OPIUM_TEXT_MINIMAPBUTTONTOOLTIP = "Open Opium";

-- Options dialog text
OPIUM_TEXT_NONE = "None";
OPIUM_TEXT_ALLIES = "Allies";
OPIUM_TEXT_ENEMIES = "Enemies";
OPIUM_TEXT_ALL = "All";
OPIUM_TEXT_COMBAT = "Combat";

OPIUM_OPTIONS_TITLE = "Opium Options";

OPIUM_TEXT_OPTIONS_SHOWMINIMAP = "Show Minimap Button";
OPIUM_TEXT_OPTIONS_MINIMAPPOS = "Minimap Button Position";
OPIUM_TEXT_OPTIONS_GUILDNAME = "Guild name in tooltip";
OPIUM_TEXT_OPTIONS_TEXTALERT = "Text alert on KoS mouseover";
OPIUM_TEXT_OPTIONS_SOUNDALERT = "Sound alert on KoS mouseover";
OPIUM_TEXT_OPTIONS_TARGETFRAMEBUTTON = "Enable target frame button";
OPIUM_TEXT_OPTIONS_PVPSTATS = "Enable PvP stats tracking";
OPIUM_TEXT_OPTIONS_PVPRANKS = "Store PvP ranks";
OPIUM_TEXT_OPTIONS_STOREPLAYERS = "Store players";
OPIUM_TEXT_OPTIONS_USECHATFRAME = "Use chat frame";


OPIUM_TEXT_OPTIONS_DONE = "Done";

-- Tooltip help for the Option frame options.

OPIUM_TEXT_OPTIONS_STOREOPTIONSHELP = 
             "This allows you to control what targets Opium \nautomatically stores in its database. PvP stats\n" ..
	      "will also only be collected for targets you \nstore. 'Enemies' means everyone you \n" ..
	      "target/mouseover in the opposing faction,\n 'Allies' similarly for your own faction,\n" ..
	     "'All' means everyone you see, and 'Combat' means \nthat only people you're involved with in combat\n" ..
	     "(technically, everyone who damages you, and everyone\n you damage) will be stored, from both factions.";
OPIUM_TEXT_OPTIONS_CHATFRAMEHELP = 
             "This lets you specify which chat window\n" ..
	     "Opium should send its text output to.\n"..
	     "'General' is 1, 'Combat' is 2, and so on.";
OPIUM_TEXT_OPTIONS_TARGETBUTTONHELP =
             "Opium can place a small button on your\n"..
	     "current target which will allow you to\n"..
	     "toggle KoS status for your target. This\n"..
	     "option turns it on or off.";
OPIUM_TEXT_OPTIONS_PVPSTATSHELP =
             "Opium can store in its player records\n"..
	     "who kills you and who you kill, for\n"..
	     "the PvP Statistics screen. This turns\n"..
	     "that functionality on or off";
OPIUM_TEXT_OPTIONS_PVPRANKSHELP =
             "This enables or disables storing the honor\n"..
	     "rank of players you store in the Opium\n"..
	     "database";
OPIUM_TEXT_OPTIONS_SOUNDALERTHELP =
             "Toggle whether Opium should play a sound\n"..
	     "whenever you mouseover or target a player\n"..
	     "who's in your KoS list (or belongs to a \n"..
	     "guild which is.";
OPIUM_TEXT_OPTIONS_TEXTALERTHELP =
             "Toggle whether Opium should display a text alert\n"..
	     "whenever you mouseover or target a player\n"..
	     "who's in your KoS list (or belongs to a guild\n"..
	     "which is.";
OPIUM_TEXT_OPTIONS_GUILDNAMEHELP =
             "Choose whether Opium should show a players guild in\n"..
	     "the player tooltip. Disable this if you're using\n"..
	     "a tooltip addon.";
OPIUM_TEXT_OPTIONS_MINIMAPPOSHELP =
             "Drag this slider to determine where the Opium \n"..
	     "minimap button should be positioned";
OPIUM_TEXT_OPTIONS_MINIMAPTOGGLEHELP =
             "Show or hide the Opium Minimap button.";



-- KoS window and output strings
OPIUM_TEXT_KOS_MEMBERSSTORED = "Members stored";
OPIUM_TEXT_KOS_KILLS = "Kills";
OPIUM_TEXT_KOS_DEATHS = "Deaths";
OPIUM_TEXT_KOS_ADDED = "added to KoS list.";
OPIUM_TEXT_KOS_REMOVED = "removed from KoS list.";
OPIUM_TEXT_KOS = "KoS";
OPIUM_TEXT_KOS_NOSPECIFIED = "No name/guild specified";
OPIUM_TEXT_KOS_NEEDMORETHANSPACES = "Need more than just spaces.";
OPIUM_TEXT_KOS_PLAYER = "Player";
OPIUM_TEXT_KOS_ISNOWKOS = "is now KoS, reason:";
OPIUM_TEXT_KOS_NOLONGER = "is no longer KoS.";
OPIUM_TEXT_KOS_ISKOSNOW = "is now KoS.";

OPIUM_TEXT_KOS_PLAYERKOS = "Player KoS";
OPIUM_TEXT_KOS_GUILDKOS = "Guild KoS";
OPIUM_TEXT_KOS_ADDPLAYER = "Add player to KoS list";
OPIUM_TEXT_KOS_ADD = "Add";
OPIUM_TEXT_KOS_EDIT = "Edit";
OPIUM_TEXT_KOS_REMOVE = "Remove";

OPIUM_TEXT_ADDDIALOGTITLE = "Add to KoS list";
OPIUM_TEXT_KOS_REASON = "Reason";



-- PvP stats strings
OPIUM_TEXT_STATS_TITLE = "PvP Stats";

OPIUM_TEXT_STATS_TODAY = "Today";
OPIUM_TEXT_STATS_TOTAL = "Total";
OPIUM_TEXT_STATS_TOTALKILLS = "Total kills";
OPIUM_TEXT_STATS_UNIQUEKILLS = "Unique kills";
OPIUM_TEXT_STATS_AVERAGELEVEL = "Average level";
OPIUM_TEXT_STATS_TOTALDEATHS = "Total deaths";
OPIUM_TEXT_STATS_UNIQUEKILLERS = "Unique killers";
OPIUM_TEXT_STATS_TOP10KILLEDPLAYERS = "Top 10 killed players";
OPIUM_TEXT_STATS_TOP10KILLEDGUILDS = "Top 10 killed guilds";
OPIUM_TEXT_STATS_TOPKILLEDCLASSES = "Top killed classes";
OPIUM_TEXT_STATS_TOPKILLEDRACES = "Top killed races";
OPIUM_TEXT_STATS_KILLEDBYPLAYERS = "Top 10 killed by players";
OPIUM_TEXT_STATS_KILLEDBYGUILDS = "Top 10 killed by guilds";
OPIUM_TEXT_STATS_TOPKILLEDBYCLASSES = "Top killed by classes";
OPIUM_TEXT_STATS_TOPKILLEDBYRACES = "Top killed by races";

OPIUM_TEXT_STATS_LOGGINGDEATH = "Logging death by";
OPIUM_TEXT_STATS_LOGGINGKILL = "Logging kill of";



OPIUM_TEXT_SHARE = "Share";

OPIUM_TEXT_SHAREDIALOGTITLE = "Share KoS list with player";
OPIUM_TEXT_SHAREWITHWHO = "Player to send to (needs Sky):";
OPIUM_TEXT_SHARE_SENTTABLE = "Opium: Sent KoS table to";
OPIUM_TEXT_SHARE_NOTSKYUSER1 = "Can't tell if";  
OPIUM_TEXT_SHARE_NOTSKYUSER2 = "is online and a Sky user! If he/she is, " ..
	           "try to join the Sky channel (both of you, with '/join sky') and then you can retry.";
           

OPIUM_TEXT_SHARE_RECEIVECONFIRM = "OPIUM: Accept KoS list from";

OPIUM_TEXT_BLOCK = "Block sender";
OPIUM_TEXT_OPTIONS_BLOCKSENDERS = "Silently block KoS sends";
OPIUM_TEXT_OPTIONS_BLOCKSENDERSHELP = "Enabling this will cause Opium to automatically\n"..
                                      "discard all incoming KoS lists, without prompting you\n";

OPIUM_TEXT_SHARE_ENTRIES = "entries";
OPIUM_TEXT_SHARE_GUILDS = "guild";
OPIUM_TEXT_SHARE_PLAYERS = "player";
OPIUM_TEXT_SHARE_NEW = "new";
OPIUM_TEXT_SHARE_ADDED = "added";

OPIUM_TEXT_EITHER = "Either";
OPIUM_TEXT_PVPSTATSLABEL = "Has PvP Stats";
OPIUM_TEXT_MINDAYSLABEL = "Min days";
OPIUM_TEXT_MAXDAYSLABEL = "Max days";
OPIUM_TEXT_OPTIONS_COLORWHO = "Color KoS players in /who";
OPIUM_TEXT_OPTIONS_COLORWHOHELP = "Turning this on will cause all players who are KoS\n" ..
                                  "or in KoS guilds, to show up in red on the /who list";

--- Added in 2.5
OPIUM_TEXT_KOS_FLAG = "Flag";
OPIUM_TEXT_KOS_FLAG_KOS = "KoS";
OPIUM_TEXT_KOS_FLAG_FRIEND = "Friendly";
OPIUM_TEXT_PLAYER = "Player";
OPIUM_TEXT_GUILD = "Guild";
OPIUM_TEXT_OPTIONS_ONLYENEMYALERTS = "Only alert for enemy KoS members";
OPIUM_TEXT_OPTIONS_ONLYENEMYALERTSHELP = "Enable this to set Opium to only alert you\n"..
                                     "(text or sound depending on above options)\n"..
				     "when encountering someone not in your own\n"..
				     "faction, who is also on your KoS lists.";

OPIUM_TEXT_HELP15 = "Adds a new flag, in addition to the inbuilt 'KoS' and 'Friendly' flags";

--- Added in 2.5a
OPIUM_TEXT_STATS_SURVIVABILITY = "Survivability";

OPIUM_RANKTITLE = { };

OPIUM_RANKTITLE[1] = { };
OPIUM_RANKTITLE[1][0] = "";
OPIUM_RANKTITLE[1][1] = "";
OPIUM_RANKTITLE[1][2] = "";
OPIUM_RANKTITLE[1][3] = "";
OPIUM_RANKTITLE[1][4] = "";
OPIUM_RANKTITLE[1][5] = "Private";
OPIUM_RANKTITLE[1][6] = "Corporal";
OPIUM_RANKTITLE[1][7] = "Sergeant";
OPIUM_RANKTITLE[1][8] = "Master Sergeant";
OPIUM_RANKTITLE[1][9] = "Sergeant Major";
OPIUM_RANKTITLE[1][10] = "Knight";
OPIUM_RANKTITLE[1][11] = "Knight-Lieutenant";
OPIUM_RANKTITLE[1][12] = "Knight-Captain";
OPIUM_RANKTITLE[1][13] = "Knight-Champion";
OPIUM_RANKTITLE[1][14] = "Lieutenant Commander";
OPIUM_RANKTITLE[1][15] = "Commander";
OPIUM_RANKTITLE[1][16] = "Marshal";
OPIUM_RANKTITLE[1][17] = "Field Marshal";
OPIUM_RANKTITLE[1][18] = "Grand Marshal";
OPIUM_RANKTITLE[1][19] = "";
OPIUM_RANKTITLE[1][20] = "";

OPIUM_RANKTITLE[2] = { };
OPIUM_RANKTITLE[2][0] = "";
OPIUM_RANKTITLE[2][1] = "";
OPIUM_RANKTITLE[2][2] = "";
OPIUM_RANKTITLE[2][3] = "";
OPIUM_RANKTITLE[2][4] = "";
OPIUM_RANKTITLE[2][5] = "Scout";
OPIUM_RANKTITLE[2][6] = "Grunt";
OPIUM_RANKTITLE[2][7] = "Sergeant";
OPIUM_RANKTITLE[2][8] = "Senior Sergeant";
OPIUM_RANKTITLE[2][9] = "First Sergeant";
OPIUM_RANKTITLE[2][10] = "Stone Guard";
OPIUM_RANKTITLE[2][11] = "Blood Guard";
OPIUM_RANKTITLE[2][12] = "Legionnaire";
OPIUM_RANKTITLE[2][13] = "Centurion";
OPIUM_RANKTITLE[2][14] = "Champion";
OPIUM_RANKTITLE[2][15] = "Lieutenant General";
OPIUM_RANKTITLE[2][16] = "General";
OPIUM_RANKTITLE[2][17] = "Warlord";
OPIUM_RANKTITLE[2][18] = "High Warlord";
OPIUM_RANKTITLE[2][18] = "";
OPIUM_RANKTITLE[2][19] = "";





opiumDeathString = " dies.";
opiumDuelString = "(.+) has defeated (.+) in a duel";

-- Damage strings borrowed from PvPLog
opiumYourDamageMatch = {
	-- Your damage or healing
	{ pattern = "Your (.+) hits (.+) for (%d+)", spell = 0, mob = 1, pts = 2 },
	{ pattern = "Your (.+) crits (.+) for (%d+)", spell = 0, mob = 1, pts = 2 },
	{ pattern = "You drain (%d+) (.+) from (.+)", mob = 2, pts = 0, stat = 1 },
	{ pattern = "Your (.+) causes (.+) (%d+) damage", spell = 0, mob = 1, pts = 2 },
	{ pattern = "You reflect (%d+) (.+) damage to (.+)", mob = 2, pts = 0, type = 1 },
	{ pattern = "(.+) suffers (%d+) (.+) damage from your (.+)", spell = 3, mob = 0, 
                                                                 pts = 1, type = 2 },
	{ pattern = "You hit (.+) for (%d+)", mob = 0, pts = 1 },
	{ pattern = "You crit (.+) for (%d+)", mob = 0, pts = 1 }
};

opiumDamageToYouMatch = {
	{ pattern = "(.+)'s (.+) hits you for (%d+)", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+)'s (.+) crits you for (%d+)", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) drains (%d+) (.+) from you", pts = 1, stat = 2, cause = 0 },
	{ pattern = "(.+)'s (.+) causes you (%d+) damage", spell = 1, pts = 2, cause = 0 },
	{ pattern = "(.+) reflects (%d+) (.+) damage to you", pts = 1, type = 2, cause = 0 },
	{ pattern = "You suffer (%d+) (.+) damage from (.+)'s (.+)", spell = 3, pts = 0, 
                                                                 type = 1, cause = 2 },
	{ pattern = "(.+) hits you for (%d+)", pts = 1, cause = 0 },
	{ pattern = "(.+) crits you for (%d+)", pts = 1, cause = 0 }
};

   OPIUM_RACEINDEX = { };
   OPIUM_CLASSINDEX = { };
   OPIUM_FACTIONINDEX = { };


   OPIUM_RACEINDEX["Dwarf"]     = 1;
   OPIUM_RACEINDEX["Gnome"]     = 2;
   OPIUM_RACEINDEX["Human"]     = 3;
   OPIUM_RACEINDEX["Night Elf"] = 4;
   OPIUM_RACEINDEX["Orc"]       = 5;
   OPIUM_RACEINDEX["Tauren"]    = 6;
   OPIUM_RACEINDEX["Troll"]     = 7;
   OPIUM_RACEINDEX["Undead"]    = 8;

   OPIUM_RACEINDEX[1] = "Dwarf";
   OPIUM_RACEINDEX[2] = "Gnome";
   OPIUM_RACEINDEX[3] = "Human";
   OPIUM_RACEINDEX[4] = "Night Elf";
   OPIUM_RACEINDEX[5] = "Orc";
   OPIUM_RACEINDEX[6] = "Tauren";
   OPIUM_RACEINDEX[7] = "Troll";
   OPIUM_RACEINDEX[8] = "Undead";


   OPIUM_CLASSINDEX["Druid"]   = 1;
   OPIUM_CLASSINDEX["Hunter"]  = 2;
   OPIUM_CLASSINDEX["Mage"]    = 3;
   OPIUM_CLASSINDEX["Paladin"] = 4;
   OPIUM_CLASSINDEX["Priest"]  = 5;
   OPIUM_CLASSINDEX["Rogue"]   = 6;
   OPIUM_CLASSINDEX["Shaman"]  = 7;
   OPIUM_CLASSINDEX["Warlock"] = 8;
   OPIUM_CLASSINDEX["Warrior"] = 9;

   OPIUM_CLASSINDEX[1] = "Druid";
   OPIUM_CLASSINDEX[2] = "Hunter";
   OPIUM_CLASSINDEX[3] = "Mage";
   OPIUM_CLASSINDEX[4] = "Paladin";
   OPIUM_CLASSINDEX[5] = "Priest";
   OPIUM_CLASSINDEX[6] = "Rogue";
   OPIUM_CLASSINDEX[7] = "Shaman";
   OPIUM_CLASSINDEX[8] = "Warlock";
   OPIUM_CLASSINDEX[9] = "Warrior";


