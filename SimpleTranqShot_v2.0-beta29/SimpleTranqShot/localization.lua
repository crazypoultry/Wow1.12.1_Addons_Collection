--------------------------------------
-- SimpleTranqShot localization.lua --
--          enUS - English          --
--------------------------------------

STRANQ_STRINGS = {};

-- Strings that need to be translated for proper mod functionality
STRANQ_STRINGS.HUNTER = "Hunter";
STRANQ_STRINGS.TRANQ = "Tranquilizing Shot";
STRANQ_STRINGS.SPELLSELF = "You cast "..STRANQ_STRINGS.TRANQ.." on (.+).";
STRANQ_STRINGS.SPELLOTHER = "(.+) casts "..STRANQ_STRINGS.TRANQ.." on (.+).";
STRANQ_STRINGS.SPELLOTHERMISS = "([^%s]+)'s "..STRANQ_STRINGS.TRANQ.." missed (.+)";
STRANQ_STRINGS.FRENZY = "Frenzy";
STRANQ_STRINGS.FAILSELF = "You fail to dispel (.+)'s "..STRANQ_STRINGS.FRENZY.."."
STRANQ_STRINGS.FAILOTHER = "(.+) fails to dispel (.+)'s "..STRANQ_STRINGS.FRENZY..".";
STRANQ_STRINGS.GAINFRENZY = "(.+) gains "..STRANQ_STRINGS.FRENZY..".";
STRANQ_STRINGS.REMOVED = "(.+)'s "..STRANQ_STRINGS.FRENZY.." is removed.";
STRANQ_STRINGS.FRENZYEMOTE = "goes into a .*frenzy!";

STRANQ_STRINGS.PANIC = "Panic";
STRANQ_STRINGS.TIMELAPSE = "Time Lapse";
STRANQ_STRINGS.TIMESTOP = "Time Stop";				-- Brood Affliction: Bronze stun
STRANQ_STRINGS.WYVERNSTING = "Wyvern Sting";
STRANQ_STRINGS.MANABURN = "Mana Burn";
STRANQ_STRINGS.MINDFLAY = "Mind Flay";
STRANQ_STRINGS.CAUSEINSANITY = "Cause Insanity";

STRANQ_STRINGS.FEAR = " fear";
STRANQ_STRINGS.STUN = " stun";
STRANQ_STRINGS.FLEE = " flee";

-- mob names
STRANQ_STRINGS.MAGMADAR = "Magmadar";
STRANQ_STRINGS.CHROMAGGUS = "Chromaggus";
STRANQ_STRINGS.MAWS = "Maws";
STRANQ_STRINGS.PRINCESS_HUHURAN = "Princess Huhuran";
STRANQ_STRINGS.FLAMEGOR = "Flamegor";
STRANQ_STRINGS.GLUTH = "Gluth";
STRANQ_STRINGS.QIRAJI_SLAYER = "Qiraji Slayer";
STRANQ_STRINGS.DEATH_TALON_SEETHER = "Death Talon Seether";
STRANQ_STRINGS.VEKNISS_DRONE = "Vekniss Drone";
STRANQ_STRINGS.VEKNISS_SOLDIER = "Vekniss Soldier";
STRANQ_STRINGS.ROACH = "Roach";
STRANQ_STRINGS.BEETLE = "Beetle";
STRANQ_STRINGS.SCORPION = "Scorpion";

-- Default broadcast and error messages
STRANQ_STRINGS.CASTMSG = "-- casting tranq shot on %t --";
STRANQ_STRINGS.MISSMSG = "== TRANQ SHOT MISSED %T ==";
STRANQ_STRINGS.MISSERR = "TRANQUILIZING SHOT MISSED";
STRANQ_STRINGS.RAIDERR = "%P MISSED TRANQUILIZING SHOT";
STRANQ_STRINGS.FAILMSG = "== TRANQ SHOT FAILED ON %T ==";
STRANQ_STRINGS.FAILERR = "TRANQUILIZING SHOT FAILED";
STRANQ_STRINGS.RAIDFAILERR = "%P'S TRANQUILIZING SHOT FAILED";

-- %t normal case target name
-- %T upper case target name
-- %p normal case player name
-- %P upper case player name
STRANQ_STRINGS.SUB_NORMALCASE_TARGET = "%%t";
STRANQ_STRINGS.SUB_UPPERCASE_TARGET = "%%T";
STRANQ_STRINGS.SUB_NORMALCASE_PLAYER = "%%p";
STRANQ_STRINGS.SUB_UPPERCASE_PLAYER = "%%P";

STRANQ_STRINGS.CHATHEADER = "<STranq>";
STRANQ_STRINGS.BROADCASTROTHEADER = STRANQ_STRINGS.CHATHEADER.." Hunter Tranq Rotation  - ";

STRANQ_STRINGS.GROUP = "Group%d: %s  ";
STRANQ_STRINGS.BACKUP = "Reserve: %s  ";

STRANQ_STRINGS.ROTATION_OF = "Rotation of %d";
STRANQ_STRINGS.GROUPS_OF = "%d Groups of %d";
STRANQ_STRINGS.GROUP_OF = "Group of %d";
STRANQ_STRINGS.IN_RESERVE = "%d in Reserve";

STRANQ_STRINGS.NOTFOUND = "not found";

STRANQ_STRINGS.MISSED = "MISSED";
STRANQ_STRINGS.FAILED = "FAILED";

STRANQ_STRINGS.NEW_FRENZY_MOB = "Found new mob that frenzies.  Adding %s to the list of known mobs.";
STRANQ_STRINGS.ROTBROADCASTEDBY = "New tranq rotation recieved from %s.";
STRANQ_STRINGS.VERSIONCOMPARE = "%s is using SimpleTranqShot %s, which appears to be a more recent version.  An update may be available."

STRANQ_STRINGS.DEAD = "dead";
STRANQ_STRINGS.LOWMANA = "low mana";
STRANQ_STRINGS.OFFLINE = "offline";


-- Strings for the UI
STRANQ_TITLE = "SimpleTranqShot";
STRANQ_TITLESHORT = "STranq";

STRANQ_LOADED = " |c99999999: loaded :|r /stranq";

STRANQ_BROADCAST_ERROR_NOCHANNEL = "Cast Message Broadcast Channel is not set.  Yelling instead.  Type /stranq and choose a channel.";
STRANQ_BROADCAST_ERROR_CHANNEL = "Cast Message Broadcast Channel |r%s|c99999999 is not a currently joined channel.  Yelling instead.";

STRANQ_BROADCAST_TEXT = "Broadcasted Messages";
STRANQ_ERROR_TEXT = "Error Messages";
STRANQ_TIMERS_TEXT = "Timer Bars Setup";
STRANQ_CASTMSG_TEXT = "Successful Cast Message";
STRANQ_MISSMSG_TEXT = "Missed Cast Message";
STRANQ_MISSERR_TEXT = "Missed Cast Error";
STRANQ_RAIDERR_TEXT = "Raid Missed Cast Error";
STRANQ_FAILMSG_TEXT = "Failed Tranquilize Message";
STRANQ_FAILERR_TEXT = "Failed Tranquilize Error";
STRANQ_RAIDFAILERR_TEXT = "Raid Failed Tranquilize Error";
STRANQ_CASTTYPE_TEXT = "Cast Broadcast Type";
STRANQ_CASTCHAN_TEXT = "Channel";
STRANQ_CASTPLAY_TEXT = "Target Player";

STRANQ_NOCHANNEL_TEXT = "no channel";
STRANQ_NOPLAYER_TEXT = "no players";

STRANQ_TEST_TEXT = "Test";
STRANQ_DEFAULTSALL_TEXT = "All Defaults";

STRANQ_MISSCOLOR_TEXT = "Missed Cast Color";
STRANQ_RAIDCOLOR_TEXT = "Raid Missed Cast Color";
STRANQ_RAIDMISS_TEXT = "Show Raid Misses";
STRANQ_SOUNDS_TEXT = "Play Audio on Miss";
STRANQ_RS_TEXT = "Rebroadcast to /rs";
STRANQ_HIDEBARS_TEXT = "Disable Timer Bars";
STRANQ_AUTOHIDEBARS_TEXT = "Hide Outside of Raid";
STRANQ_LOCKBARS_TEXT = "Lock Bar Positions";
STRANQ_BARSGROWUP_TEXT = "Grow Bars Up";
STRANQ_LOCKROT_TEXT = "Lock Hunter Rotation";
STRANQ_HIDEEXTRA_TEXT = "Hide Extra Hunters";
STRANQ_SHOWOTHERCLASSES_TEXT = "Display on Non Hunters";
STRANQ_HIDEROT_TEXT = "Broadcast Rotation";
STRANQ_OFFICERSONLY_TEXT = "Only Raid Officer Rotations";

STRANQ_CASTMSG_TIP = "This message is broadcasted on a successful cast of Tranquilizing Shot.";
STRANQ_CASTMSGTEST_TIP = "Test successful cast message with selected settings.";
STRANQ_MISSMSG_TIP = "This message is broadcasted when Tranquilizing Shot misses.";
STRANQ_MISSMSGTEST_TIP = "Test missed cast message with selected settings.";
STRANQ_FAILMSG_TIP = "This message is broadcasted when Tranquilizing Shot fails to remove frenzy on the target it was cast on.";
STRANQ_FAILMSGTEST_TIP = "Test failed tranquilize message with selected settings.";

STRANQ_MISSERR_TIP = "This message is displayed when your Traquilizing Shot misses."
STRANQ_MISSERRTEST_TIP = "Test miss warning with selected settings.";
STRANQ_RAIDERR_TIP = "This message is displayed when someone else's Traquilizing Shot misses."
STRANQ_RAIDERRTEST_TIP = "Test raid miss warning with selected settings.";
STRANQ_FAILERR_TIP = "This message is displayed when your Traquilizing Shot fails."
STRANQ_FAILERRTEST_TIP = "Test failed tranquilize warning with selected settings.";
STRANQ_RAIDFAILERR_TIP = "This message is displayed when someone else's Traquilizing Shot fails."
STRANQ_RAIDFAILERRTEST_TIP = "Test raid failed tranquilize warning with selected settings.";

STRANQ_CASTTYPE_TIP = "Chat type to broadcast hit, miss, and fail messages to."
STRANQ_CASTCHAN_TIP = "Channel or player to broadcast to (if broadcast type requires it)."
STRANQ_RS_TIP = "Broadcast to CT_RaidAssist /rs (if available, otherwise /raid) as well as the selected broadcast type."
STRANQ_HIDEBARS_TIP = "Hide the timer bars for the raid's tranq shot cooldown and upcoming frenzy."
STRANQ_AUTOHIDEBARS_TIP = "Hide the timer bars when not in a raid.";
STRANQ_LOCKBARS_TIP = "Lock the position of the timer bars to prevent them from being dragged around.";
STRANQ_BARSGROWUP_TIP = "Change the direction the hunter timer bars extend from the main frenzy timer bar.";
STRANQ_LOCKROT_TIP = "Lock the order of the hunter rotation.";
STRANQ_HIDEEXTRA_TIP = "Hide hunters who are not part of the rotation.";
STRANQ_SHOWOTHERCLASSES_TIP = "Show timer bars and warnings on classes other than hunters.";
STRANQ_HIDEROT_TIP = "Broadcast the hunter rotation to raid or the custom channel.";
STRANQ_OFFICERSONLY_TIP = "Only accept hunter tranq rotations from the raid leader or raid assistants.";

STRANQ_MISSCOLOR_TIP = "Change the color of the miss or fail warning."
STRANQ_RAIDCOLOR_TIP = "Change the color of the raid miss or fail warning."
STRANQ_RAIDMISS_TIP = "Display a warning when a near by raid member's Tranquilizing Shot fails or misses."
STRANQ_SOUND_TIP = "Play sound when warning on misses. Plays a sound for both raid misses and your own misses."

STRANQ_BARALPHA_TIP = "Change the opacity of the timer bars.";
STRANQ_BARSCALE_TIP = "Change the scale of the timer bars.";

STRANQ_DROPDOWN_BARS_TEXT = "Timer Bar Options";
STRANQ_DROPDOWN_ROT_TEXT = "Hunter Rotation";

STRANQ_TOOLTIP_INACTIVE = "Inactive";
STRANQ_TOOLTIP_RESERVE = "Reserve";
STRANQ_TOOLTIP_GROUP = "Group";
STRANQ_TOOLTIP_IN_ROTATION = "In Rotation";
STRANQ_TOOLTIP_DEAD = "Dead";
STRANQ_TOOLTIP_FEIGN_DEATH = "Feign Death";

STRANQ_MENU_UNLOCK_POSITION = "Unlock Position";
STRANQ_MENU_LOCK_POSITION = "Lock Position";
STRANQ_MENU_GROW_DOWN = "Grow Down";
STRANQ_MENU_GROW_UP = "Grow Up";
STRANQ_MENU_SHOW_OUTSIDE_RAID = "Show Outside Raid";
STRANQ_MENU_HIDE_OUTSIDE_RAID = "Hide Outside Raid";
STRANQ_MENU_UNLOCK_ROTATION = "Unlock Rotation";
STRANQ_MENU_LOCK_ROTATION = "Lock Rotation";
STRANQ_MENU_SHOW_EXTRA = "Show Extra Hunters";
STRANQ_MENU_HIDE_EXTRA = "Hide Extra Hunters";
STRANQ_MENU_BROADCAST_ROT = "Broadcast Rotation";
STRANQ_MENU_CLOSE_OPTIONS = "Close STranq Options";
STRANQ_MENU_OPEN_OPTIONS = "Open STranq Options";

STRANQ_ROTATION_GROUP = "Hunters Per Group";
STRANQ_ROTATION_BACKUP = "Active Hunters Cutoff";
STRANQ_ROTATION_GROUPS = "Number of Groups";

STRANQ_DEFAULTS_POPUP = "This page's settings will be reset to their defaults.\nAre you sure you want to do this?\n\n|cffbbbbbbIf you have previously saved your settings, they will not be overwritten until the save button is pressed.";
STRANQ_DEFAULTSALL_POPUP = "All settings will be reset to their defaults?\nAre you sure you want to do this?\n\n|cffbbbbbbIf you have previously saved your settings, they will not be overwritten until the save button is pressed.";
STRANQ_NEEDSAVE_POPUP = "You have unsaved changes, do you want to save them now?";
STRANQ_NOVALID_MSG_POPUP = "No valid chat channel or player found.";
STRANQ_NOVALID_SAVE_POPUP = STRANQ_NOVALID_MSG_POPUP.."\nUnable to save settings.";
STRANQ_NEWROTATION_POPUP = "%s wants to change the hunter rotation, accept?";

STRANQ_SLASH1 = "/simpletranq";
STRANQ_SLASH2 = "/stranq";

STRANQ_COMMAND_RESET = "reset";
STRANQ_COMMAND_VER = "ver";
STRANQ_COMMAND_ROT = "rot";
STRANQ_COMMAND_ENABLEALL = "enableall";
STRANQ_COMMAND_DISABLEALL = "disableall";
STRANQ_COMMAND_SHOWBARS = "show";
STRANQ_COMMAND_HIDEBARS = "hide";
STRANQ_COMMAND_BARS = "bars";

STRANQ_CONSOLE_HELP = {
	"/stranq console commands are:",
	"|cffffffff"..STRANQ_COMMAND_RESET.." |cff999999: forces all options to default",
	"|cffffffff"..STRANQ_COMMAND_VER.." |cff999999: does a version check on hunters",
	"|cffffffff"..STRANQ_COMMAND_ROT.." |cff999999: broadcast hunter rotation",
	"|cffffffff"..STRANQ_COMMAND_ENABLEALL.." |cff999999: enables stranq to load on all classes",
	"|cffffffff"..STRANQ_COMMAND_DISABLEALL.." |cff999999: disables stranq from loading on any class but hunters",
	"|cffffffff"..STRANQ_COMMAND_SHOWBARS.." |cff999999: display timer bars",
	"|cffffffff"..STRANQ_COMMAND_HIDEBARS.." |cff999999: hide timer bars",
	"|cffffffff"..STRANQ_COMMAND_BARS.." |cff999999:  toggle timer bars",
	"No command will show the options window.",
	};

STRANQ_CONSOLE_RESETTING = "Resetting to defaults";
STRANQ_CONSOLE_NOTHUNTER = "This addon is not enabled for non hunters by default.  To enable type:\n/stranq enableall";
STRANQ_CONSOLE_ENABLEALL = "SimpleTranqShot is now enabled on all classes.  To disable, type:\n/stranq disableall";
STRANQ_CONSOLE_DISABLEALL = "SimpleTranqShot is now disabled on all classes but hunters.  This change will not take effect until you've logged off of this character.";

BINDING_HEADER_SIMPLETRANQSHOT = "Simple Tranq Shot"
BINDING_NAME_TOGGLESTRANQTIMERS = "Toggle Timer Bars";
BINDING_NAME_TOGGLESTRANQOPTIONS = "Toggle Options";

