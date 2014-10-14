-- English Data for MetaMap

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap is a modification to the standard World Map.";
METAMAP_OPTIONS_BUTTON = "Options";
METAMAP_SLASH_OPTIONS = "options";
METAMAP_STRING_LOCATION = "Location";
METAMAP_STRING_LEVELRANGE = "Level Range";
METAMAP_STRING_PLAYERLIMIT = "Player Limit";
METAMAP_BUTTON_TOOLTIP1 = "LeftClick to Show Map";
METAMAP_BUTTON_TOOLTIP2 = "RightClick for Options";
METAMAP_OPTIONS_TITLE = "MetaMap Options";
METAMAP_KB_TEXT = "Knowledge Base"
METAMAP_HINT = "Hint: Left-click to open MetaMap.\nRight-click for options";
METAMAPNOTES_NAME = "map notes"
METAMAP_NOTES_SHOWN = "Notes"
METAMAP_LINES_SHOWN = "Lines"
BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_TOGGLE = "Toggle MetaMap";
BINDING_NAME_METAMAP_FSTOGGLE = "Toggle FullScreen";
BINDING_NAME_METAMAP_SAVESET = "Toggle Map Mode";
BINDING_NAME_METAMAP_KB = "Toggle Database Display"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Capture Target Details";
BINDING_NAME_METAMAP_QUICKNOTE = "Set Quick Note";

-- Commands
METAMAP_ZDEBUG_COMMANDS = { "/mmdebug" }
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_MNTLOC_COMMANDS = { "/mntloc" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote" }
METAMAPNOTES_QUICKTLOC_COMMANDS = { "/quicktloc", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Menu on Click";
METAMAP_OPTIONS_COORDS = "Show Main Coords";
METAMAP_OPTIONS_MINICOORDS = "Show MiniMap Coords";
METAMAP_OPTIONS_SHOWBUT = "Show MetaMapButton";
METAMAP_OPTIONS_AUTOSEL = "Autosize Tooltip";
METAMAP_OPTIONS_BUTPOS = "MetaMap Button Position";
METAMAP_OPTIONS_POI = "Show Default POI";
METAMAP_OPTIONS_MOZZ = "Show Unexplored";
METAMAP_OPTIONS_TRANS = "Map Transparency";
METAMAP_OPTIONS_FWM = "Show Unexplored Areas";
METAMAP_OPTIONS_DONE = "Done";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap Options";
METAMAP_MASTERMOD_OPTIONS = "MasterMod Options";
METAMAP_GATHERER_OPTIONS = "Gatherer Options";
METAMAP_GATHERER_SEARCH = "Gatherer Search";
METAMAP_BWP_OPTIONS = "BetterWaypoints";
METAMAP_OPTIONS_SHOWCTBUT = "Show MasterMod Button";
METAMAP_OPTIONS_SCALE = "Map Scale";
METAMAP_OPTIONS_TTSCALE = "Tooltip Scale";
METAMAP_OPTIONS_SAVESET = "Map Display Mode";
METAMAP_OPTIONS_USEMAPMOD = "Create notes with MapMod";
METAMAP_LIST_TEXT = "Show Map List";
METAMAP_ACTION_MODE = "Map Action Mode";

METAMAPNOTES_WORLDMAP_HELP_1 = "Right-Click On Map To Zoom Out"
METAMAPNOTES_WORLDMAP_HELP_2 = "<Control>+Left-Click to create note"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "|cFFFF0000"..METAMAPNOTES_NAME..":|r Choose Second Note To Draw/Clear A Line"

METAMAPNOTES_NEW_MENU = METAMAPNOTES_NAME
METAMAPNOTES_NEW_NOTE = "Create Note"
METAMAPNOTES_MININOTE_OFF = "MiniNote Off"
METAMAPNOTES_OPTIONS_TEXT = "Notes Options"
METAMAPNOTES_CANCEL = "Cancel"
METAMAPNOTES_SHOW_AUTHOR = "Show notes author"

METAMAPNOTES_POI_MENU = METAMAPNOTES_NAME
METAMAPNOTES_EDIT_NOTE = "Edit Note"
METAMAPNOTES_MININOTE_ON = "Set MiniNote"
METAMAPNOTES_SPECIAL_ACTIONS = "Special Actions"
METAMAPNOTES_SEND_NOTE = "Send Note"

METAMAPNOTES_SPECIALACTION_MENU = "Special Actions"
METAMAPNOTES_TOGGLELINE = "Toggle Line"
METAMAPNOTES_DELETE_NOTE = "Delete Note"

METAMAPNOTES_EDIT_MENU = "Edit Note"
METAMAPNOTES_SAVE_NOTE = "Save"
METAMAPNOTES_EDIT_TITLE = "Title (required):"
METAMAPNOTES_EDIT_INFO1 = "Info Line 1 (optional):"
METAMAPNOTES_EDIT_INFO2 = "Info Line 2 (optional):"
METAMAPNOTES_EDIT_CREATOR = "Creator (optional - leave blank to hide):"

METAMAPNOTES_SEND_MENU = "Send Note"
METAMAPNOTES_SLASHCOMMAND = "Change Mode"
METAMAPNOTES_SEND_TITLE = "Send Note:"
METAMAPNOTES_SEND_TIP = "These notes can be received by all MetaMap users ('Send to party' works only with Sky)"
METAMAPNOTES_SEND_PLAYER = "Enter player name:"
METAMAPNOTES_SENDTOPLAYER = "Send to player"
METAMAPNOTES_SENDTOPARTY = "Send to party"
METAMAPNOTES_SHOWSEND = "Change Mode"
METAMAPNOTES_SEND_SLASHTITLE = "Get slash Command:"
METAMAPNOTES_SEND_SLASHTIP = "Highlight this and use CTRL+C to copy to clipboard (then you can post it in a forum for example)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Command:"

METAMAPNOTES_OPTIONS_MENU = "Options"
METAMAPNOTES_SAVE_OPTIONS = "Save"
METAMAPNOTES_OWNNOTES = "Show notes created by your character"
METAMAPNOTES_OTHERNOTES = "Show notes received from other characters"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Highlight last created note in |cFFFF0000red|r"
METAMAPNOTES_HIGHLIGHT_MININOTE = "Highlight note selected for MiniNote in |cFF6666FFblue|r"
METAMAPNOTES_ACCEPTINCOMING = "Accept incoming notes from other players"
METAMAPNOTES_INCOMING_CAP = "Decline notes if they would leave less than 5 notes free"
METAMAPNOTES_AUTOPARTYASMININOTE = "Automatically set party notes as MiniNote."

METAMAPNOTES_CREATEDBY = "Created by"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "This command enables you to instert notes gotten by a webpage for example."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "Overrides the options setting, so that the next note you receive is accepted."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Displays the next received note directly as MiniNote (and insterts it into the map):"
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Displays the next note received as MiniNote only (not inserted into map)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "Turns the MiniNote off."
METAMAPNOTES_CHAT_COMMAND_MNTLOC_INFO = "Sets a tloc on the map."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "Creates a note at the current position on the map."
METAMAPNOTES_CHAT_COMMAND_QUICKTLOC = "Creates a note at the given tloc position on the map in the current zone."
METAMAPNOTES_MAPNOTEHELP = "This command can only be used to insert a note"
METAMAPNOTES_ONENOTE_OFF = "Allow one note: OFF"
METAMAPNOTES_ONENOTE_ON = "Allow one note: ON"
METAMAPNOTES_MININOTE_SHOW_0 = "Next as MiniNote: OFF"
METAMAPNOTES_MININOTE_SHOW_1 = "Next as MiniNote: ON"
METAMAPNOTES_MININOTE_SHOW_2 = "Next as MiniNote: ONLY"
METAMAPNOTES_DECLINE_SLASH = "Could not add, too many notes in |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_SLASH_NEAR = "Could not add, this note is too near to |cFFFFD100%q|r in |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_GET = "Could not receive note from |cFFFFD100%s|r: too many notes in |cFFFFD100%s|r, or reception disabled in the options."
METAMAPNOTES_ACCEPT_SLASH = "Note added to the map of |cFFFFD100%s|r."
METAMAPNOTES_ACCEPT_GET = "You received a map note from %s for %s."
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r set a new party note in |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_NOTETONEAR = "|cFFFFD100%s|r tried to send you a note in |cFFFFD100%s|r, but it was too near to |cFFFFD100%q|r."
METAMAPNOTES_QUICKNOTE_NOTETONEAR = "Can't create note. You are too near to |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_NOPOSITION = "Can't create note: could not retrieve current position."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "QuickNote"
METAMAPNOTES_MININOTE_DEFAULTNAME = "MiniNote"
METAMAPNOTES_QUICKNOTE_OK = "Created note on the map of |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_TOOMANY = "There are already too many notes on the map of |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_NAME = "Deleted all "..METAMAPNOTES_NAME.." with creator |cFFFFD100%s|r and name |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_CREATOR = "Deleted all "..METAMAPNOTES_NAME.." with creator |cFFFFD100%s|r."
METAMAPNOTES_QUICKTLOC_NOTETONEAR = "Can't create note. The location is too near to the note |cFFFFD100%s|r."
METAMAPNOTES_QUICKTLOC_NOZONE = "Can't create note: could not retrieve current zone."
METAMAPNOTES_QUICKTLOC_NOARGUMENT = "Usage: '/quicktloc xx,yy [icon] [title]'."
METAMAPNOTES_SETMININOTE = "Set note as new MiniNote"
METAMAPNOTES_THOTTBOTLOC = "Thottbot Location"
METAMAPNOTES_PARTYNOTE = "Party Note"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_MNTLOC = "Virtual"
METAMAPNOTES_MNTLOC_INFO = "Creates a virtual note. Save on map of choice to bind."
METAMAPNOTES_MNTLOC_SET = "Virtual note created on the World Map."
METAMAPNOTES_MININOTE_INFO = "Creates a note on the Minimap only."

METAMAPNOTES_CONVERSION_COMPLETE = "Conversion complete. Please check your notes. Don't run this function again!"

-- Errors
METAMAPNOTES_ERROR_NO_OLD_ZONESHIFT = "ERROR: No old zoneshift defined."

-- Drop Down Menu
METAMAPNOTES_SHOWNOTES = "Show Notes"
METAMAPNOTES_DROPDOWNTITLE = METAMAPNOTES_NAME
METAMAPNOTES_DROPDOWNMENUTEXT = "Quick Options"

-- Buttons, Headers, Various Text
METAKB_AUTHOR = "MetaMapKB"
METAKB_MAIN_HEADER = "World of WarCraft Knowledge Base"
METAKB_OPTIONS_HEADER = "MetaKB Options"
METAKB_ADDON_DESCRIPTION = "A moused-over NPC/mob database."
METAKB_DOWNLOAD_SITES = "See README for download sites"
METAKB_MOB_LEVEL = "Level"
METAKB_MAPNOTES_NW_BOUND = "NW Bound"
METAKB_MAPNOTES_NE_BOUND = "NE Bound"
METAKB_MAPNOTES_SE_BOUND = "SE Bound"
METAKB_MAPNOTES_SW_BOUND = "SW Bound"
METAKB_MAPNOTES_CENTER = "Center"
METAKB_SHOW_ONLY_LOCAL_NPCS = "Show Only Local NPCs"
METAKB_SHOW_UPDATES = "Show Updates"
METAKB_BOUNDING_BOX = "Create MapNotes Bounding Box"
METAKB_SEARCH_BOX = "Search"
METAKB_CLOSE_BUTTON = "Close"
METAKB_OPTIONS_BUTTON = "Options"
METAKB_REFRESH_BUTTON = "Refresh"
METAKB_CLEAR_NOTES_BUTTON = "Clear MapNotes"
METAKB_AUTO_TRACK = "Auto Tracking";
METAKB_USE_KB = "Add to Database";
METAKB_TARGET_NOTE = "Add new target note";
METAKB_OPTIONS_RANGETEXT = "Targeting Range:";

METAKB_HEADER_NAME = "Name";
METAKB_HEADER_DESC = "Description";
METAKB_HEADER_LEVEL = "Level";
METAKB_HEADER_LOCATION = "Location";

-- Tooltips
METAKB_QUICK_HELP = "Quick Help"
METAKB_QUICK_HELP_1 = "1. Left-Click to add note(s)"
METAKB_QUICK_HELP_2 = "2. Right-Click to remove note(s)"
METAKB_QUICK_HELP_3 = "3. <Ctrl>+<Shift>+Right-Click to remove from database"
METAKB_QUICK_HELP_4 = "4. <Shift>+Left-Click to add info to open message box"
METAKB_QUICK_HELP_5 = "5. Leaving the search box blank returns all records"
METAKB_SHOW_ONLY_LOCAL_NPCS_HELP = "Only the mobs/NPCs in the zone you are currently in are shown."
METAKB_SHOW_UPDATES_HELP = "Any change to the database will be displayed in the chat frame."
METAKB_BOUNDING_BOX_HELP = "Left-Clicking to add MapNotes will add a center point as well as "..
    "points for the four bounding corners and lines connecting them.  Otherwise only the center "..
    "point is added."
METAKB_AUTO_TRACK_HELP = "Turns on/off the automatic adding of NPCs/Mobs on mouseover";
METAKB_USE_KB_HELP = "Turns on/off the adding of new targets to database";
METAKB_TARGET_NOTE_HELP = "Turns on/off the adding of notes to the map for new targets. This can be over-ridden "..
													"by using the <CTRL>+<Keybinding> combination.";

-- Informational
METAKB_NO_NPC_MOB_FOUND = "No NPCs/mobs matching \"%s\" found"
METAKB_REMOVED_FROM_DATABASE = "Removed \"%s\" in \"%s\" from the database"
METAKB_DISCOVERED_UNIT = "Discovered %s!"
METAKB_ADDED_UNIT_IN_ZONE = "Added %s in %s"
METAKB_UPDATED_MINMAX_XY = "Updated Min/Max X/Y for %s in %s"
METAKB_UPDATED_INFO = "Updated information for %s in %s"
METAKB_IMPORT_SUCCESSFUL = "MetaKB_ImportData merged successfully, added %u entries and updated %u"
METAKB_STATS_LINE = "%u NPCs in %u Zones/Instances"
METAKB_NOTARGET = "You must have something targeted to create a record."


MetaMapNotes_ZoneShift = {
    [0] = { [0] = 0 },
    [1] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21 },
    [2] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 },
}

MetaMapNotes_ZoneShift[1][0] = 0
MetaMapNotes_ZoneShift[2][0] = 0

METAMAPNOTES_WARSONGGULCH = "Warsong Gulch"
METAMAPNOTES_ALTERACVALLEY = "Alterac Valley"
METAMAPNOTES_ARATHIBASIN = "Arathi Basin"

MetaMap_Data = {
	[1] = {
		["ZoneName"] = "Blackfathom Deeps",
		["Location"] = "Ashenvale",
		["LevelRange"] = "20-27",
		["PlayerLimit"] = "10"
	},
	[2] = {
		["ZoneName"] = "Blackrock Depths",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "48-56",
		["PlayerLimit"] = "10"
	},
	[3] = {
		["ZoneName"] = "Blackrock Spire (Lower)",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "53-60",
		["PlayerLimit"] = "15"
	},
	[4] = {
		["ZoneName"] = "Blackrock Spire (Upper)",
		["Location"] = "Blackrock Mountain",
		["LevelRange"] = "53-60",
		["PlayerLimit"] = "15"
	},
	[5] = {
		["ZoneName"] = "Blackwing Lair",
		["Location"] = "Blackrock Spire",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40"
	},
	[6] = {
		["ZoneName"] = "Dire Maul",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5"
	},
	[7] = {
		["ZoneName"] = "Dire Maul (East)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5"
	},
	[8] = {
		["ZoneName"] = "Dire Maul (North)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5"
	},
	[9] = {
		["ZoneName"] = "Dire Maul (West)",
		["Location"] = "Feralas",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5"
	},
	[10] = {
		["ZoneName"] = "Gnomeregan",
		["Location"] = "Dun Morogh",
		["LevelRange"] = "24-33",
		["PlayerLimit"] = "10"
	},
	[11] = {
		["ZoneName"] = "Maraudon",
		["Location"] = "Desolace",
		["LevelRange"] = "40-49",
		["PlayerLimit"] = "10"
	},
	[12] = {
		["ZoneName"] = "Molten Core",
		["Location"] = "Blackrock Depths",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40"
	},
	[13] = {
		["ZoneName"] = "Onyxia's Lair",
		["Location"] = "Dustwallow Marsh",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40"
	},
	[14] = {
		["ZoneName"] = "Ragefire Chasm",
		["Location"] = "Orgrimmar",
		["LevelRange"] = "13-15",
		["PlayerLimit"] = "10"
	},
	[15] = {
		["ZoneName"] = "Razorfen Downs",
		["Location"] = "The Barrens",
		["LevelRange"] = "35-40",
		["PlayerLimit"] = "10"
	},
	[16] = {
		["ZoneName"] = "Razorfen Kraul",
		["Location"] = "The Barrens",
		["LevelRange"] = "25-35",
		["PlayerLimit"] = "10"
	},
	[17] = {
		["ZoneName"] = "Scarlet Monastery",
		["Location"] = "Tirisfal Glades",
		["LevelRange"] = "30-40",
		["PlayerLimit"] = "10"
	},
	[18] = {
		["ZoneName"] = "Scholomance",
		["Location"] = "Western Plaguelands",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "10"
	},
	[19] = {
		["ZoneName"] = "Shadowfang Keep",
		["Location"] = "Silverpine Forest",
		["LevelRange"] = "18-25",
		["PlayerLimit"] = "10"
	},
	[20] = {
		["ZoneName"] = "Stratholme",
		["Location"] = "Eastern Plaguelands",
		["LevelRange"] = "55-60",
		["PlayerLimit"] = "10"
	},
	[21] = {
		["ZoneName"] = "The Deadmines",
		["Location"] = "Westfall",
		["LevelRange"] = "15-20",
		["PlayerLimit"] = "10"
	},
	[22] = {
		["ZoneName"] = "The Stockades",
		["Location"] = "Stormwind",
		["LevelRange"] = "23-26",
		["PlayerLimit"] = "10"
	},
	[23] = {
		["ZoneName"] = "The Sunken Temple",
		["Location"] = "Swamp of Sorrows",
		["LevelRange"] = "44-50",
		["PlayerLimit"] = "10"
	},
	[24] = {
		["ZoneName"] = "Uldaman",
		["Location"] = "The Badlands",
		["LevelRange"] = "35-45",
		["PlayerLimit"] = "10"
	},
	[25] = {
		["ZoneName"] = "Wailing Caverns",
		["Location"] = "The Barrens",
		["LevelRange"] = "15-21",
		["PlayerLimit"] = "10"
	},
	[26] = {
		["ZoneName"] = "Zul'Farrak",
		["Location"] = "Tanaris Desert",
		["LevelRange"] = "43-47",
		["PlayerLimit"] = "10"
	},
	[27] = {
		["ZoneName"] = "Zul'Gurub",
		["Location"] = "Stranglethorn Vale",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20"
	},
	[28] = {
		["ZoneName"] = "Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40"
	},
	[29] = {
		["ZoneName"] = "Ruins Of Ahn'Qiraj",
		["Location"] = "Silithus",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20"
	}
};

MetaKB_ZoneIdentifiers = {
    [1] = {
        ["z"] = "Alterac Mountains",
        ["i"] = 1
    },
    [2] = {
        ["z"] = "Arathi Highlands",
        ["i"] = 2,
    },
    [3] = {
        ["z"] = "Ashenvale",
        ["i"] = 3,
    },
    [4] = {
        ["z"] = "Azshara",
        ["i"] = 4,
    },
    [5] = {
        ["z"] = "Badlands",
        ["i"] = 5,
    },
    [6] = {
        ["z"] = "Blasted Lands",
        ["i"] = 6,
    },
    [7] = {
        ["z"] = "Burning Steppes",
        ["i"] = 7,
    },
    [8] = {
        ["z"] = "Darkshore",
        ["i"] = 8,
    },
    [9] = {
        ["z"] = "Darnassus",
        ["i"] = 9,
    },
    [10] = {
        ["z"] = "Deadwind Pass",
        ["i"] = 10,
    },
    [11] = {
        ["z"] = "Desolace",
        ["i"] = 11,
    },
    [12] = {
        ["z"] = "Dun Morogh",
        ["i"] = 12,
    },
    [13] = {
        ["z"] = "Durotar",
        ["i"] = 13,
    },
    [14] = {
        ["z"] = "Duskwood",
        ["i"] = 14,
    },
    [15] = {
        ["z"] = "Dustwallow Marsh",
        ["i"] = 15,
    },
    [16] = {
        ["z"] = "Eastern Plaguelands",
        ["i"] = 16,
    },
    [17] = {
        ["z"] = "Elwynn Forest",
        ["i"] = 17,
    },
    [18] = {
        ["z"] = "Felwood",
        ["i"] = 18,
    },
    [19] = {
        ["z"] = "Feralas",
        ["i"] = 19,
    },
    [20] = {
        ["z"] = "Hillsbrad Foothills",
        ["i"] = 20,
    },
    [21] = {
        ["z"] = "Ironforge",
        ["i"] = 21,
    },
    [22] = {
        ["z"] = "Loch Modan",
        ["i"] = 22,
    },
    [23] = {
        ["z"] = "Moonglade",
        ["i"] = 23,
    },
    [24] = {
        ["z"] = "Mulgore",
        ["i"] = 24,
    },
    [25] = {
        ["z"] = "Orgrimmar",
        ["i"] = 25,
    },
    [26] = {
        ["z"] = "Redridge Mountains",
        ["i"] = 26,
    },
    [27] = {
        ["z"] = "Searing Gorge",
        ["i"] = 27,
    },
    [28] = {
        ["z"] = "Silithus",
        ["i"] = 28,
    },
    [29] = {
        ["z"] = "Silverpine Forest",
        ["i"] = 29,
    },
    [30] = {
        ["z"] = "Stonetalon Mountains",
        ["i"] = 30,
    },
    [31] = {
        ["z"] = "Stormwind City",
        ["i"] = 31,
    },
    [32] = {
        ["z"] = "Stranglethorn Vale",
        ["i"] = 32,
    },
    [33] = {
        ["z"] = "Swamp of Sorrows",
        ["i"] = 33,
    },
    [34] = {
        ["z"] = "Tanaris",
        ["i"] = 34,
    },
    [35] = {
        ["z"] = "Teldrassil",
        ["i"] = 35,
    },
    [36] = {
        ["z"] = "The Barrens",
        ["i"] = 36,
    },
    [37] = {
        ["z"] = "The Hinterlands",
        ["i"] = 37,
    },
    [38] = {
        ["z"] = "Thousand Needles",
        ["i"] = 38,
    },
    [39] = {
        ["z"] = "Thunder Bluff",
        ["i"] = 39,
    },
    [40] = {
        ["z"] = "Tirisfal Glades",
        ["i"] = 40,
    },
    [41] = {
        ["z"] = "Undercity",
        ["i"] = 41,
    },
    [42] = {
        ["z"] = "Un'Goro Crater",
        ["i"] = 42,
    },
    [43] = {
        ["z"] = "Western Plaguelands",
        ["i"] = 43,
    },
    [44] = {
        ["z"] = "Westfall",
        ["i"] = 44,
    },
    [45] = {
        ["z"] = "Wetlands",
        ["i"] = 45,
    },
    [46] = {
        ["z"] = "Winterspring",
        ["i"] = 46,
    },

-- Instances and other special zones
    [300] = {
        ["z"] = "Deeprun Tram",
        ["i"] = 47,
    },
    [301] = {
        ["z"] = "The Deadmines",
        ["i"] = 48,
    },
    [302] = {
        ["z"] = "Blackfathom Deeps",
        ["i"] = 49,
    },
    [303] = {
        ["z"] = "Ragefire Chasm",
        ["i"] = 50,
    },
    [304] = {
        ["z"] = "Razorfen Downs",
        ["i"] = 51,
    },
    [305] = {
        ["z"] = "Razorfen Kraul",
        ["i"] = 52,
    },
    [306] = {
        ["z"] = "Scarlet Monastery",
        ["i"] = 53,
    },
    [307] = {
        ["z"] = "Shadowfang Keep",
        ["i"] = 54,
    },
    [308] = {
        ["z"] = "The Wailing Caverns",
        ["i"] = 55,
    },
    [309] = {
        ["z"] = "The Stockade",
        ["i"] = 56,
    },
    [310] = {
        ["z"] = "Maraudon",
        ["i"] = 310,
    },
    [311] = {
        ["z"] = "Uldaman",
        ["i"] = 311,
    },
    [312] = {
        ["z"] = "Gnomeregan",
        ["i"] = 312,
    },
    [313] = {
        ["z"] = "Zul'Gurub",
        ["i"] = 313,
    },
    [314] = {
        ["z"] = "Stratholme",
        ["i"] = 314,
    },
    [315] = {
        ["z"] = "Scholomance",
        ["i"] = 315,
    },
    [316] = {
        ["z"] = "Zul'Farrak",
        ["i"] = 316,
    },
    [317] = {
        ["z"] = "The Molten Core",
        ["i"] = 317,
    },
    [318] = {
        ["z"] = "Blackrock Mountain",
        ["i"] = 318,
    },
    [319] = {
        ["z"] = "Onyxia's Lair",
        ["i"] = 319,
    },
    [320] = {
        ["z"] = "Blackwing Lair",
        ["i"] = 320,
    },
    [321] = {
        ["z"] = "Blackrock Depths",
        ["i"] = 321,
    },
    [322] = {
        ["z"] = "Dire Maul",
        ["i"] = 322,
    },
    [323] = {
        ["z"] = "The Temple of Atal'Hakkar",
        ["i"] = 323,
    },
    [324] = {
        ["z"] = "Hall of Blackhand",
        ["i"] = 324,
    },
    [325] = {
        ["z"] = "Arathi Basin",
        ["i"] = 325,
    },
    [326] = {
        ["z"] = "Alterac Valley",
        ["i"] = 326,
    },
    [327] = {
        ["z"] = "Warsong Gulch",
        ["i"] = 327,
    },
    [328] = {
        ["z"] = "The Temple Of Ahn'Qiraj",
        ["i"] = 328,
    },

-- GetZoneText conversions/Renamed zones these must come at the end of the list so when we lookup a
-- name from the identifier we find the preferred GetRealZoneText name first.  These indices are
-- treated as invalid so they don't need to be the same in each localization file.
    [600] = {
        ["z"] = "City of Ironforge",
        ["i"] = 21,
    },
    [601] = {
        ["z"] = "Lion's Pride Inn",
        ["i"] = 17,
    },
    [602] = {
        ["z"] = "Darkshire Town Hall",
        ["i"] = 14,
    },
    [603] = {
        ["z"] = "Crypt",
        ["i"] = 2,
    },
    [604] = {
        ["z"] = "Lakeshire Inn",
        ["i"] = 26,
    },
    [605] = {
        ["z"] = "Lakeshire Town Hall",
        ["i"] = 26,
    },
    [606] = {
        ["z"] = "Scarlet Raven Tavern",
        ["i"] = 14,
    },
    [607] = {
        ["z"] = "Sentinel Tower",
        ["i"] = 44,
    },
    [608] = {
        ["z"] = "Thistlefur Hold",
        ["i"] = 3,
    },
    [609] = {
        ["z"] = "Hillsbrad",
        ["i"] = 20,
    },
    [610] = {
        ["z"] = "Stormwind Stockade",
        ["i"] = 56,
    },
    [611] = {
        ["z"] = "Anvilmar",
        ["i"] = 12,
    },
};
