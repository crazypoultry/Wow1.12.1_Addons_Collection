-- default to American English

FishingTranslations = {};
FishingTranslations["enUS"] = {
   NAME = "Fishing Buddy",
   DESCRIPTION1 = "Keep track of the fish you've caught",
   DESCRIPTION2 = "and manage your fishing gear.",
   DESCRIPTION = "#DESCRIPTION1# #DESCRIPTION2#",

   ID = "FishingBuddy",

   WINDOW_TITLE = "#NAME# v#VERSION#",
   FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing",

   -- Tab labels and tooltips
   LOCATIONS_INFO = "Show fishing location information",
   LOCATIONS_TAB = "Locations",
   OUTFITS_INFO = "Pick out what to wear when fishing",
   OUTFITS_TAB = "Outfits",
   OPTIONS_INFO = "Set #NAME# options",
   OPTIONS_TAB = "Options",
   TRACKING_INFO = "Show #NAME# cycle fish information",
   TRACKING_TAB = "Tracking",

   POINT = "point",
   POINTS = "points",

   RAW = "Raw",
   FISH = "Fish",

   BOBBER_NAME = "Fishing Bobber",
   FISHINGSKILL = "Fishing",
   HELP = "help",
   SWITCH = "switch",
   IMPORT = "import",
   TRACK = "track",
   NOTRACK = "notrack",
   TRACKING = "tracking",
   UPDATEDB = "updatedb",
   FORCE = "force",

   SCHOOL = "School",  -- e.g. 'Oily Blackmouth School'
   FLOATING_WRECKAGE = "Floating Wreckage",
   FLOATING_DEBRIS = "Floating Debris",
   ELEM_WATER = "Elemental Water",
   OIL_SPILL = "Oil Spill",

   ADD = "add",
   REPLACE = "replace",
   UPDATE = "update",
   CURRENT = "current",
   RESET = "reset",
   CLEANUP = "cleanup",
   CHECK = "check",
   NOW = "now",

   NOREALM = "unknown realm",

   WATCHER = "watcher",
   WATCHER_LOCK = "lock",
   WATCHER_UNLOCK = "unlock",

   UNKNOWN = "Unknown",
   WEEKLY = "weekly",
   HOURLY = "hourly",

   OFFSET_LABEL_TEXT = "Offset:";

   KEYS_LABEL_TEXT = "Modifiers:",
   KEYS_NONE_TEXT = "None",
   KEYS_SHIFT_TEXT = "Shift",
   KEYS_CTRL_TEXT = "Control",
   KEYS_ALT_TEXT = "Alt",

   SHOWFISHIES = "Show fish",
   SHOWFISHIES_INFO = "Display fishing history grouped by fish type.",

   SHOWLOCATIONS = "Locations",
   SHOWLOCATIONS_INFO = "Display fishing history grouped by where caught.",

   SWITCHOUTFIT = "Switch",
   SWITCHOUTFIT_INFO = "Switch between the fishing outfit and what you were wearing before.",

   -- Option names and tooltips
   CONFIG_SHOWNEWFISHIES_ONOFF   = "Show new fish",
   CONFIG_SHOWNEWFISHIES_INFO    = "Display a message in the chat area when a new fish for the current location is caught.",
   CONFIG_FISHWATCH_ONOFF        = "Fish watcher",
   CONFIG_FISHWATCH_INFO	 	 = "Display a text overlay with the fish caught in the current location.",
   CONFIG_FISHWATCHONLY_ONOFF    = "Only while fishing",
   CONFIG_FISHWATCHONLY_INFO	 = "Only watch the fish caught when we're actually fishing",
   CONFIG_FISHWATCHSKILL_ONOFF   = "Current skill",
   CONFIG_FISHWATCHSKILL_INFO	 = "Display your current fishing skill and mods in the fish watch area.",
   CONFIG_FISHWATCHZONE_ONOFF    = "Current zone",
   CONFIG_FISHWATCHZONE_INFO	 = "Display the current zone in the fish watch area.",
   CONFIG_FISHWATCHPERCENT_ONOFF = "Show percentages",
   CONFIG_FISHWATCHPERCENT_INFO	 = "Display the percentage of each kind of fish on the watch display",
   CONFIG_SUITUPFIRST_ONOFF      = "Dress for success",
   CONFIG_SUITUPFIRST_INFO       = "Put on your fishing outfit if you're not wearing it when the binding key is pressed",
   CONFIG_EASYCAST_ONOFF	 = "Easy Cast",
   CONFIG_EASYCAST_INFO		 = "If enabled, then when a fishing pole is equipped and you right click, you will cast the line.",
   CONFIG_EASYLURES_ONOFF	 = "Easy Lures",
   CONFIG_EASYLURES_INFO	 = "If enabled, a lure will applied to your fishing pole before you start fishing, whenever you need one.",
   CONFIG_ONLYMINE_ONOFF	 = "Outfit Pole Only",
   CONFIG_ONLYMINE_INFO		 = "If enabled, easy cast will only check for your outfit's fishing pole (i.e. it won't search all possible poles for a match).",
   CONFIG_MOUSEFISHING_ONOFF	 = "Mouse fishing",
   CONFIG_MOUSEFISHING_INFO	     = "If enabled, left-click throws your line and right-click loots the bobber",
   CONFIG_SHOWLOCATIONZONES_ONOFF	= "Show Zones",
   CONFIG_SHOWLOCATIONZONES_INFO	= "Display both zones and subzones.",
   CONFIG_SORTBYPERCENT_ONOFF	= "Sort by number caught",
   CONFIG_SORTBYPERCENT_INFO	= "Order displays by the number of fish caught instead of by name.",
   CONFIG_STVTIMER_ONOFF		= "Fishing Extravaganza timer",
   CONFIG_STVTIMER_INFO		= "If enabled, display a countdown timer for the start of the Fishing Extravaganza and a countdown of the timer left.",
   CONFIG_STVPOOLSONLY_ONOFF	= "Only cast in pools",
   CONFIG_STVPOOLSONLY_INFO	= "If enabled, easy cast will only be enabled if the cursor is over a fishing hole.",
   CONFIG_USEBUTTONHOLE_ONOFF	= "Use ButtonHole",
   CONFIG_USEBUTTONHOLE_INFO	= "If enabled, the ButtonHole addon will control the minimap button. Takes effect on the next login.",
   CONFIG_USEGATHERER_ONOFF	= "Use Gatherer",
   CONFIG_USEGATHERER_INFO	= "If enabled, #NAME# will inform Gatherer about fishing holes.",

   CONFIG_SKILL_INFO		= "Total outfit skill bonus.",
   CONFIG_SKILL_TEXT		= "Fishing ",
   CONFIG_STYLISH_INFO		= "Style points loosely inspired by Draznar's Fishing FAQ in the WoW forums.",
   CONFIG_STYLISH_TEXT		= "Style: ",

   CONFIG_OUTFITTER_TEXT      = "Outfit skill bonus: %s\r\nDraznar's style score: %d ",

   CLICKTOSWITCH_ONOFF	        = "Click to switch",
   CLICKTOSWITCH_INFO	        = "If enabled, a left click switches outfits, otherwise it brings up the Fishing Buddy window.",

   LEFTCLICKTODRAG = "Left-click to drag",
   RIGHTCLICKFORMENU = "Right-click for menu",
   WATCHERCLICKHELP = "#LEFTCLICKTODRAG#\n#RIGHTCLICKFORMENU#",

   MINIMAPBUTTONPLACEMENT = "Button Placement",
   MINIMAPBUTTONPLACEMENTTOOLTIP = "Allows you to move the #NAME# icon around the minimap",
   CONFIG_MINIMAPBUTTON_ONOFF	= "Display minimap icon",
   CONFIG_MINIMAPBUTTON_INFO	= "Display a #NAME# icon on the minimap.",

   CONFIG_ENHANCESOUNDS_ONOFF      = "Enhance fishing sounds",
   CONFIG_ENHANCESOUNDS_INFO       = "Maximize sound volume and minimize ambient volume to make the bobber noise more noticeable while fishing.",

   TRACKINGFRAME = "Tracking Frame",
   TRACKINGFRAME_RIGHTCLICK = "Right-click to draw graphs for fish",
   TRACKINGFRAME_LEFTCLICK = "Left-click to choose fish to track",
-- TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
   TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#",

   TRACKFISHHOURLY = "Track this fish hourly",
   TRACKFISHWEEKLY = "Track this fish weekly",
   HIDEINWATCHER = "Display this fish in the watcher",

   -- messages
   COMPATIBLE_SWITCHER = "No compatible outfit switcher found.",
   TOOMANYFISHERMEN = "You have more than one easy cast mod installed.",
   FAILEDINIT = "Did not initialize correctly.",
   IMPORTMSG = "Imported '%s' database.",
   NOIMPORTMSG = "No Impp, DataFish, or FishInfo2 databases found.",
   ADDFISHIEMSG = "Adding %s to location %s.",
   ADDSCHOOLMSG = "Adding '%s' to location %s.",
   CURSORBUSYMSG = "Couldn't switch because the cursor is busy!",
   NOOUTFITDEFINED = "You don't have any items in your fishing outfit.",
   NODATAMSG = "No fishing data available.",
   TRACKINGMSG = "Tracking '%s' %s.",
   NOTRACKERRMSG = "Can't remove default cycle fish.",
   NOTRACKMSG = "Removed cycle fish '%s'.",
   POLEALREADYEQUIPPED = "You're already equipped for fishing.",
   CANTSWITCHBACK = "You've already removed your fishing equipment.",
   CLEANUP_NONEMSG = "No old settings remain.",
   CLEANUP_WILLMSG = "Old settings remaining for |c#RED#%s|r: %s.",
   CLEANUP_DONEMSG = "Old settings removed for |c#RED#%s|r: %s.",
   CLEANUP_NOOLDMSG = "There are no old settings for player |c#GREEN#%s|r.",
   NONEAVAILABLE_MSG = "None available",
   UPDATEDB_MSG = "Updated %d fish names.",

   MINIMUMSKILL = "Minimum skill: %d",
   NOTLINKABLE = "<Item is not linkable>",
   CAUGHTTHISMANY = "Caught %d",
   CAUGHTTHISTOTAL = "Total %d",
   FISHTYPES = "Fish types: %d",

   DASH = " -- ",
   FISHCAUGHT = "%d %s",
   TIMETOGO = "Extravaganza starts in %d:%02d",
   TIMELEFT = "Extravaganza ends in %d:%02d",
   FATLADYSINGS = "|c#RED#Extravaganza is over|r (%d:%02d left)",
   RIGGLE_BASSBAIT = "^Riggle Bassbait .*: .*! (.*) .*!$",

   STVZONENAME = "Stranglethorn Vale",

   TOOLTIP_HINT = "Hint:",
   TOOLTIP_HINTSWITCH = "click to switch outfits",
   TOOLTIP_HINTTOGGLE = "click to show the #NAME# window.",

   -- months for Tracking frame
   ABBREV_JANUARY = "Jan",
   ABBREV_APRIL = "Apr",
   ABBREV_JULY = "Jul",
   ABBREV_OCTOBER = "Oct",
   ABBREV_DECEMBER = "Dec",

   -- Key binding support
   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "Toggle #NAME# Window",
   BINDING_NAME_FISHINGBUDDY_SWITCH = "Switch Fishing Outfit",
   BINDING_NAME_FISHINGBUDDY_GOFISHING = "Suit up and go fishing",

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "Toggle #NAME# Locations Pane",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "Toggle #NAME# Outfit Pane",
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "Toggle #NAME# Tracking Pane",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "Toggle #NAME# Options Pane",
};

FishingTranslations["enUS"].IMPORT_HELP = {
      "|c#GREEN#/fb #IMPORT#|r",
      "    Import Impp's fishinfo or FishInfo2 data.",
};
FishingTranslations["enUS"].SWITCH_HELP = {
      "|c#GREEN#/fb #SWITCH#|r",
      "    swap outfits (if OutfitDisplayFrame or Outfitter is available)",
};
FishingTranslations["enUS"].WATCHER_HELP = {
      "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r or |c#GREEN##WATCHER_UNLOCK#|r or |c#GREEN##RESET#|r]",
      "    Unlock the watcher to move the window,",
      "    lock to stop, reset to reset",
};
FishingTranslations["enUS"].CURRENT_HELP = {
   "|c#GREEN#/fb #CURRENT# #RESET#|r",
   "    Reset the fish caught during the current session.",
};
FishingTranslations["enUS"].UPDATEDB_HELP = {
   "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r",
   "    Try and find the names of all the fish we don't know already.",
   "    An attempt is made to skip 'rare' fish that may disconnect you",
   "    from the server -- use the '#FORCE#' option to override the check.",
};
FishingTranslations["enUS"].CLEANUP_HELP = {
      "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN#f#CHECK#|r or |c#GREEN##NOW#|r]",
      "    Clean up old settings. |c#GREEN##CHECK#|r lists which",
      "    settings will be removed by |c#GREEN##NOW#|r.",
};
FishingTranslations["enUS"].TRACKING_HELP = {
      "|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r or |c#GREEN##WEEKLY#|r] |c#PURPLE#<fish link>|r",
      "    track the catch times for the specified fish (a shift click link)",
      "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
      "    remove the specified fish (a shift click link) from the tracker",
      "|c#GREEN#/fb #TRACKING#|r",
      "    a really bad display of when tracked fish were caught",
};

FishingTranslations["enUS"].PRE_HELP = {
      "You can use |c#GREEN#/fishingbuddy|r or |c#GREEN#/fb|r for all commands",
      "|c#GREEN#/fb|r: by itself, toggle the Fishing Buddy window",
      "|c#GREEN#/fb #HELP#|r: display this message",
};
FishingTranslations["enUS"].POST_HELP = {
      "You can bind both the window toggle and the outfit",
      " switch command to keys in the \"Key Bindings\" window.",
};

FishingTranslations["enUS"].HELPMSG = {
      "@PRE_HELP",
      "@SWITCH_HELP",
      "@WATCHER_HELP",
      "@CURRENT_HELP",
      "@CLEANUP_HELP",
      "@IMPORT_HELP",
      "@TRACKING_HELP",
      "@UPDATEDB_HELP",
      " ",
      "@POST_HELP",
};

