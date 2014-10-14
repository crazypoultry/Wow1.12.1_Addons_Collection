--------------------------------------------------------------------------
-- localization.lua
--------------------------------------------------------------------------



SLASH_ALPHAMAPSLASH1 = "/AlphaMap";
SLASH_ALPHAMAPSLASH2 = "/am";

AM_SLASH_LOAD_HELP_USAGE	= "Alpha Map"

BINDING_HEADER_ALPHAMAP		= "AlphaMap Key Bindings";
BINDING_NAME_TOGGLEALPHAMAP	= "Toggle AlphaMap";
BINDING_NAME_INCREMENTALPHAMAP 	= "Increase AlphaMap Opacity";
BINDING_NAME_DECREMENTALPHAMAP 	= "Decrease AlphaMap Opacity";
BINDING_NAME_CLEARVIEWALPHAMAP	= "Show/Hide all Notes/Icons";
BINDING_NAME_CYCLEWMMODE	= "Cycle WorldMap Modes";
BINDING_NAME_HOT_SPOT		= "Hot Spot";

--Colored State values
ALPHA_MAP_GREEN_ENABLED = "|c0000FF00Enabled|r";
ALPHA_MAP_RED_DISABLED = "|c00FF0000Disabled|r";

--Slash Help
AM_SLASH_HELP_USAGE         = "AlphaMap Usage: /alphamap or /am:";
AM_SLASH_HELP_ENABLE        = "/am enable - enable / re-enable AlphaMap";
AM_SLASH_HELP_DISABLE       = "/am disable - disable AlphaMap";
AM_SLASH_HELP_RESET         = "/am reset - reset AlphaMap options to default.";
AM_SLASH_HELP_RAID          = "/am raid - show Raid Pins";
AM_SLASH_HELP_PTIPS         = "/am ptips - show party tooltips";
AM_SLASH_HELP_MNTIPS        = "/am mntips - show MapNotes tips";
AM_SLASH_HELP_GTIPS         = "/am gtips - show Gatherer tips";
AM_SLASH_HELP_MNGTIPS       = "/am mngtips - show MapNotes Gathering tips";
AM_SLASH_HELP_MOVESLIDER    = "/am moveslider - toggle movement of the slider";
AM_SLASH_HELP_SLIDER        = "/am slider - toggle display of slider";
AM_SLASH_HELP_GATHERER      = "/am gatherer - toggle support for Gatherer";
AM_SLASH_HELP_MAPNOTES      = "/am mapnotes - toggle support for MapNotes";
AM_SLASH_HELP_GATHERING     = "/am gathering - toggle support for MapNotes Gathering";
AM_SLASH_HELP_AUTOCLOSE     = "/am combat - toggle Autoclose on Combat";
AM_SLASH_HELP_AUTOOPEN	    = "/am reopen - toggle Re-Open after Combat";
AM_SLASH_HELP_WMCLOSE       = "/am wmclose - toggle Autoclose on WorldMap close";
AM_SLASH_HELP_LOCK          = "/am lock - toggle movement of the AlphaMap";
AM_SLASH_HELP_SCALE         = "/am scale |c0000AA00<value>|r - set the alphamap window scale (Range 0.0 - 1.0)";
AM_SLASH_HELP_TOG           = "|c00FF0000/am tog  - toggle display of alphamap|r";
AM_SLASH_HELP_ALPHA         = "/am alpha |c0000AA00<value>|r - set the transparency of alphamap (Range 0.0 - 1.0)";
AM_SLASH_HELP_MINIMAP	    = "/am minimap - toggle the display of the Minimap button";
AM_SLASH_HELP_HELP	    = "/am help  <OR>  /am ?  - lists the AlphaMap slash commands";

ALPHA_MAP_LOAD_CONFIRM = "|c0000BFFFAlphaMap |c0000FF00v."..ALPHA_MAP_VERSION.."|c0000BFFF is Loaded - Type "..SLASH_ALPHAMAPSLASH1.." or "..SLASH_ALPHAMAPSLASH2.." for options|r";

ALPHA_MAP_ENABLED = "|c0000BFFFAlphaMap is now "..ALPHA_MAP_GREEN_ENABLED;
ALPHA_MAP_DISABLED = "|c0000BFFFAlphaMap is now "..ALPHA_MAP_RED_DISABLED;

ALPHA_MAP_UI_LOCKED = "AlphaMap: User Interface |c00FF0000Locked|r.";
ALPHA_MAP_UI_UNLOCKED = "AlphaMap: User Interface |c0000FF00Unlocked|r.";
ALPHA_MAP_UI_LOCK_HELP = "If this option is checked, the AlphaMap will be locked into place and can't be moved.";

ALPHA_MAP_DISABLED_HINT = "Hint: AlphaMap is "..ALPHA_MAP_RED_DISABLED..".  Type |C0000AA00'/am Enable'|R to re-enable.";

ALPHA_MAP_CONFIG_SLIDER_STATE       = "AlphaMap: Slider Movement ";
ALPHA_MAP_CONFIG_COMBAT_STATE       = "AlphaMap: AutoClose on Combat ";
ALPHA_MAP_CONFIG_REOPEN_STATE	    = "AlphaMap: Re-Open after Combat ";
ALPHA_MAP_CONFIG_RAID_STATE         = "AlphaMap: Raid Pins ";
ALPHA_MAP_CONFIG_PTIPS_STATE        = "AlphaMap: Party/Raid ToolTips ";
ALPHA_MAP_CONFIG_MNTIPS_STATE       = "AlphaMap: MapNotes ToolTips ";
ALPHA_MAP_CONFIG_MNGTIPS_STATE      = "AlphaMap: MapNotes Gathering ToolTips ";
ALPHA_MAP_CONFIG_GTIPS_STATE        = "AlphaMap: Gatherer ToolTips ";
ALPHA_MAP_CONFIG_WMCLOSE_STATE      = "AlphaMap: Close on WorldMap Close ";
ALPHA_MAP_CONFIG_GATHERING_STATE    = "AlphaMap: MapNotes Gathering Support ";
ALPHA_MAP_CONFIG_GATHERER_STATE     = "AlphaMap: Gatherer Support ";
ALPHA_MAP_CONFIG_MAPNOTES_STATE     = "AlphaMap: MapNotes Support ";

AM_OPTIONS			= "Options";
AM_OPTIONS_TITLE		= "AlphaMap "..AM_OPTIONS;
AM_OPTIONS_RESET		= "Reset ALL";
AM_OPTIONS_CLOSE		= "Close";
AM_OPTIONS_MAPNOTES		= "Enable Map Notes";
AM_OPTIONS_MAPNOTES_TOOLTIPS	= "Display Map Notes Tooltips";
AM_OPTIONS_MAPNOTESG		= "Enable MapNotes Gathering Icons";
AM_OPTIONS_MAPNOTESG_TOOLTIPS 	= "Display MapNotes Gathering Tooltips";
AM_OPTIONS_GATHERER		= "Enable Gatherer Icons";
AM_OPTIONS_GATHERER_TOOLTIPS	= "Display Gatherer Tooltips";
AM_OPTIONS_PARTY_TOOLTIPS	= "Display Group Tooltips";
AM_OPTIONS_RAID_PINS		= "Enable Group Pins";
AM_OPTIONS_SLIDER		= "Display Alpha Slider on Map";
AM_OPTIONS_SLIDER_MOVE		= "Allow Movement of Alpha Slider";
AM_OPTIONS_AUTOCLOSE_COMBAT	= "Close Map when Combat starts";
AM_OPTIONS_AUTOOPEN_COMBAT	= "Re-Open Map after Combat ends";
AM_OPTIONS_AUTOCLOSE_WORLDMAP	= "Close Map when World Map closes";
AM_OPTIONS_ANGLESLIDER		= "Minimap Angle  : ";
AM_OPTIONS_RADIUSLIDER		= "Minimap Radius : ";
AM_OPTIONS_ALPHASLIDER		= "Map Opacity : ";
AM_OPTIONS_SCALESLIDER		= " Map Scale  : ";
AM_OPTIONS_MAP_LOCK		= "Lock AlphaMap Position";
AM_OPTIONS_MINIMAP		= "Display Minimap Button";
AM_OPTIONS_CLEARVIEW_OFF	= "Hide Enabled Icons";
AM_OPTIONS_CLEARVIEW_ON		= "|c00FF0000All Icons Currently Hidden|r";
AM_OPTIONS_LEGACYPLAYER		= "Display Legacy style Player Icon";
AM_OPTIONS_ZONE_SELECTOR	= "Display Map Selector";
AM_OPTIONS_GENERAL_CHAT		= "General Chat";
AM_OPTIONS_DUNGEON		= "Dungeons";
AM_OPTIONS_MAPS			= "Map Selector";
AM_OPTIONS_ADDONS		= "WorldMap Notes & Icons : ";
AM_OPTIONS_MISC			= "Internal AddOn Options : ";
AM_OPTIONS_DUNGEON_NOTES	= "AlphaMap Note Options : ";
AM_OPTIONS_DUNGEON_FRAMES	= "AlphaMap Extra Information : ";
AM_OPTIONS_DM_NOTES		= "Display AlphaMap Notes";
AM_OPTIONS_DM_NOTES_TOOLTIPS	= "Display AlphaMap Note Tooltips";
AM_OPTIONS_DM_NOTES_BCKGRND	= "Show Note Background";
AM_OPTIONS_DM_NBG_SET		= "Set Note Background Colour";
AM_OPTIONS_DM_HEADER		= "Show Header Information";
AM_OPTIONS_DM_EXTRA		= "Show Footer Information";
AM_OPTIONS_DM_KEY		= "Show Map Key";
AM_OPTIONS_DM_KEY_TOOLTIPS	= "Show Map Key Tooltips";
AM_OPTIONS_DM_SAVE_LABEL	= "Control settings for all INSTANCE Maps : ";
AM_OPTIONS_DM_ALL		= "Changes affect ALL INSTANCE Maps";
AM_OPTIONS_DM_SAVE		= "Apply to ALL INSTANCE Maps";
AM_OPTIONS_RESTORE		= "Apply";
AM_MISC				= "Miscellaneous";
AM_OPTIONS_DM_MISC		= AM_MISC.." : ";
AM_OPTIONS_DM_MAP_BCKGRND	= "Show Map Background";
AM_OPTIONS_DM_MBG_SET		= "Set Map Background Colour";
AM_OPTIONS_DM_TEXT_BCKGRND	= "Show Text Background";
AM_OPTIONS_DM_TEXTBG_SET	= "Set Text Background Colour";
AM_OPTIONS_MAP_BOXES		= "Position of AlphaMap Selector :";
AM_OPTIONS_UNDOCKED		= "AlphaMap Selector is : ";
AM_OPTIONS_FREE			= "Free Floating";
AM_OPTIONS_FREE_LOCKED		= "(Locked)";
AM_OPTIONS_MAPPED		= "Attached to AlphaMap";
AM_OPTIONS_DOCK_IT		= "Dock to Options Frame";
AM_OPTIONS_FREE_IT		= "Free Floating";
AM_OPTIONS_MAP_IT		= "Attach to AlphaMap";
AM_OPTIONS_HOW_TO_MAP		= "Anchor to AlphaMap by : ";
AM_OPTIONS_MAP_LINK		= "to";
AM_OPTIONS_HOTSPOT_BEHAVE	= "HotSpot Behaviour : ";
AM_OPTIONS_HOTSPOT_DISABLE	= "Enable HotSpot Functionality";
AM_OPTIONS_HOTSPOT_OPEN		= "Open AlphaMap if Closed";
AM_OPTIONS_HOTSPOT_OPACITY	= "Fully Opaque AlphaMap";
AM_OPTIONS_HOTSPOT_WORLDI	= "Toggle World Icons/Notes";
AM_OPTIONS_HOTSPOT_DUNGI	= "Toggle Dungeon AlphaMap Notes";
AM_OPTIONS_HOTSPOT_NBG		= "Toggle Note Backgrounds";
AM_OPTIONS_HOTSPOT_MBG		= "Toggle Map Background";
AM_OPTIONS_HOTSPOT_MINIMAP	= "Enable Minimap Button as HotSpot";
AM_OPTIONS_HOTSPOT_INFO		= "Toggle Key/Header/Footer";
AM_OPTIONS_BG_USE_AM		= "Use AlphaMap's BattleGround maps\nby default when in Battlegrounds";
AM_OPTIONS_BG_SAVE_LABEL	= "Control settings for all BG Maps : ";
AM_OPTIONS_BG_ALL		= "Setting Changes affect ALL BG Maps";
AM_OPTIONS_BG_SAVE		= "Apply to ALL BG Maps";
AM_OPTIONS_RAID_SAVE_LABEL	= "Control Settings for all Non-Instance Maps :";
AM_OPTIONS_RAID_ALL		= "Changes affect ALL Non-Instance Maps";
AM_OPTIONS_RAID_SAVE		= "Apply to ALL Non-Instance Maps";
AM_OPTIONS_BG_MESSAGES		= "Send Battlefield Messages to : ";
AM_OPTIONS_RAID			= "Raid";
AM_OPTIONS_PARTY		= "Party";
AM_OPTIONS_GENERAL		= "General";
AM_OPTIONS_GUILD		= "Guild";
AM_OPTIONS_GROUP_DEFAULT	= "Group Dependant";
AM_OPTIONS_NUN_AUTO		= "Auto-Send NuN Note Settings";
AM_OPTIONS_NUN_FORMAT		= "Send Formatted Notes";
AM_OPTIONS_NUN_MESSAGES		= "Auto Send NuN Notes to : ";
AM_OPTIONS_WMAP_MODES		= "World Map View Modes :";
AM_OPTIONS_GMAP_MODES		= "Blizzard Map Settings :";
AM_OPTIONS_GMAP_ALLOW		= "Allow changes to Blizzard Map";
AM_OPTIONS_GMAP_CHANGE		= "Check to change Blizzard Map";
AM_OPTIONS_WMAP_SMODE		= "Standard";
AM_OPTIONS_WMAP_OMODE		= "Compact";
AM_OPTIONS_WMAP_MINIMODE	= "Minimap Textures";
AM_OPTIONS_WMAP_ZMINIMODE	= "Zoomed Minimap";
AM_OPTIONS_WMOTHER		= "Other Map Controls : ";
AM_OPTIONS_WM_ESCAPE		= "Enable <Escape> Closing";
AM_OPTIONS_WM_MOUSE		= "Enable Mouse Interaction";
AM_OPTIONS_MUTE			= "Mute";
AM_OPTIONS_COORDS		= "(x, y)";
AM_OPTIONS_MAPS1		= "AlphaMap Maps 1";
AM_OPTIONS_MAPS2		= "  ..... 2";
AM_OPTIONS_HELP_TIPS		= "Help Tooltips";

AM_INSTANCE_TITLE_LOCATION	= "Location ";
AM_INSTANCE_TITLE_LEVELS	= "Levels ";
AM_INSTANCE_TITLE_PLAYERS	= "Max. Players ";
AM_INSTANCE_CHESTS		= "Chest ";
AM_INSTANCE_STAIRS		= "Stairs";
AM_INSTANCE_ENTRANCES		= "Entrance ";
AM_INSTANCE_EXITS		= "Exit ";
AM_LEADSTO			= "Leads to...";
AM_INSTANCE_PREREQS		= "Prerequisites : ";
AM_INSTANCE_GENERAL		= "General Notes : ";
AM_RARE				= "(Rare)";
AM_VARIES			= "(Varies)";
AM_WANDERS			= "(Patrols)";
AM_OPTIONAL			= "(Optional)";

AM_NO_LIMIT			= "No Player Limit";

AM_MOB_LOOT 			= "Mob Loot";
AM_RBOSS_DROP 			= "Random Boss Drops";
AM_ENCHANTS			= "Enchants";
AM_CLASS_SETS			= "Class Sets";
AM_TIER0_SET			= "Tier 0 Sets";
AM_TIER1_SET			= "Tier 1 Sets";
AM_TIER2_SET			= "Tier 2 Sets";
AM_TIER3_SET			= "Tier 3 Sets";
AM_PVP_SET			= "PvP Sets";

AM_ANCHOR_POINT 	= {	{ Display = "Top",			-- Localise
				  Command = "TOP" },					-- Do NOT Localise
				{ Display = "Top Right",		-- Localise
				  Command = "TOPRIGHT" },				-- Do NOT Localise
				{ Display = "Right",			-- Localise
				  Command = "RIGHT" },					-- Do NOT Localise
				{ Display = "Bottom Right",		-- Localise
				  Command = "BOTTOMRIGHT" },				-- Do NOT Localise
				{ Display = "Bottom",			-- Localise
				  Command = "BOTTOM" },					-- Do NOT Localise
				{ Display = "Bottom Left",		-- Localise
				  Command = "BOTTOMLEFT" },				-- Do NOT Localise
				{ Display = "Left",			-- Localise
				  Command = "LEFT" },					-- Do NOT Localise
				{ Display = "Top Left",			-- Localise
				  Command = "TOPLEFT" }					-- Do NOT Localise
			};

AM_BG_BASE			= "Base";
AM_BG_BASES			= "Bases";
AM_BG_REQUIRED			= "Required to Win !";

AM_EXTERIOR = " Exterior";

AM_RCMENU_INC			= " Inc ";		-- as in 5 inc Blacksmith   or  3 inc farm
AM_RCMENU_ZERG			= "Zerg";		-- as in Zerg Inc Frostwolf GY
AM_OK				= "OK";
AM_RCMENU_HIGHLIGHT		= "Highlight";		-- as in leave this note highlighted on the map
AM_RCMENU_NUN_AUTO		= "Auto-Send Note";	-- send the NotesUNeed note for the current map note to Raid/Party/...
AM_RCMENU_NUN_MAN		= "Manual Send Note";
AM_RCMENU_NUN_OPEN		= "Open Note";
AM_RCMENU_AFLAG			= "Alliance Flag ";
AM_RCMENU_HFLAG			= "Horde Flag ";
AM_RCMENU_FLAGLOC		= {	"Our Tunnel",
					"Our Roof",
					"Going West",
					"Going East",
					"In Middle",
					"Their Tunnel",
					"Their Roof",
					"Their Flag Room",
					"Their GY"
				};

AM_OPENING = "AQ Opening Quest Chain";

AM_HORDE		= "Horde";
AM_PICKED		= { 	word = "picked",
				posWord = " by ",
				extraChars = 1 };

-- Deutsch
--AM_PICKED		= {	word = "aufgenommen" };

-- Francais
--AM_PICKED		= {	word = "ramass\195\169",
--				posWord = " par ",
--				extraChars = 2 };

AM_NEUTRAL		= "Neutral";
AM_FRIENDLY		= "Friendly";
AM_HONOURED		= "Honoured";
AM_REVERED		= "Revered";
AM_EXALTED		= "Exalted";

AM_CONFIG_SAVED			= "AlphaMap Settings changed for : ";

AM_CANCEL			= "Cancel";

--------------------------------------------------------------------------------------------------------------------------------------
-- TOOLTIPS															    --
--------------------------------------------------------------------------------------------------------------------------------------

AM_TT_MINIMAP_BUTTON	= "AlphaMap\nLeft Click Toggles AlphaMap\nRight Click Toggles Options";
AM_TT_ALPHA_BUTTON1	= "AlphaMap";
AM_TT_ALPHA_BUTTON2	= "Left Click Toggles AlphaMap\nRight Click Toggles Options";
AM_TT_PAUSE1		= "Pause";
AM_TT_PAUSE2		= "Click to Pause map updates and allow you to open/close without resetting to current map Also use if another conflicting AddOn continually resets the AlphaMap to the current zone";
AM_TT_PLAY1		= "Play";
AM_TT_PLAY2		= "i.e. Click now to Un-Pause map updates";
AM_TT_HOTSPOT1		= "HotSpot";
AM_TT_HOTSPOT2		= "Quick Mouse-Over facility to change the AlphaMap view e.g. show/hide the map or Notes/Icons, or make fully opaque See Map Selector Tab of Options for full list (Key Binding available)";
AM_TT_LOCK1		= "Lock Map Selector";
AM_TT_LOCK2		= "Un-lock to show a frame with which to move the Map Selection drop down boxes";
AM_TT_TAB1		= "Original AlphaMap Options";
AM_TT_TAB2A		= "Specific options only for Maps included with AlphaMap and NOT Blizzard maps.";
AM_TT_TAB2B		= "e.g. Map/Note/Text backgrounds, and which notes/extra information to show NOTE : Only applies to AlphaMap Maps, and not applicable when viewing world map zones";
AM_TT_TAB3A		= "Further settings only applicable to AlphaMap Maps";
AM_TT_TAB3B		= "NOTE : Only applies to AlphaMap Maps, and not applicable when viewing world map zones";
AM_TT_TAB4		= "Set the position of the Map Selector Drop Down box controls  and define Hot Spot behaviour";
AM_TT_TAB5		= "Miscallaneous AlphaMap settings and integration with other AddOns";
AM_TT_MAPNOTES		= "Enable display of MapNotes, CTMap_Mod notes, MetaMapNotes, MapNotes(Cosmos)";
AM_TT_RAID1		= "Un-Check to ONLY show Party Pins";
AM_TT_RAID2		= "(Even when in Raid)";
AM_TT_CLEAR1		= "Show/Hide all above Enabled Icons/Notes Also see Key Binding for same function";
AM_TT_CLEAR2		= "e.g. Quick way to un-clutter the map OR Hide all, and use Hot Spot to make them visible when needed";
AM_TT_SLIDER		= "Show an Opacity Slider Control On the AlphaMap";
AM_TT_SLIDERM1		= "Check to enable movement of the on-map Opacity Slider";
AM_TT_SLIDERM2		= "Drop anywhere on the Map to re-locate it there Drop 'off' the AlphaMap to detach it (Can also be moved with the mouse when the Control key is pressed in Mouse Interaction mode)";
AM_TT_ACLOSE1		= "Auto-Close AlphaMap when entering Combat";
AM_TT_ACLOSE2		= "(Useful if you play with map always displayed)";
AM_TT_AOPEN		= "Auto-Re-Open AlphaMap when leaving Combat";
AM_TT_LEGACY1		= "Original Player & Party Directional Icons";
AM_TT_LEGACY2		= "May suffer from blinking Minimap Icons";
AM_TT_AM_NOTES1		= "Display AlphaMap's on-map notes";
AM_TT_AM_NOTES2		= "(These are NOT the same as MapNotes  and can not be changed)";
AM_TT_ALL_INSTANCE1	= "Un-check to save the settings for each Instance map seperately";
AM_TT_ALL_INSTANCE2	= "e.g. you might want a dark background for Zul'Farrak, but a light one for Molten Core. Keep checked if you want to make sure that when you make ANY change to ANY Instance Map then the settings will be copied to ALL the other Instance maps";
AM_TT_KEY		= "i.e. Show Map Legend";
AM_TT_ALL_BG1		= "Un-check to save the settings for each Battleground map seperately";
AM_TT_ALL_BG2		= "e.g. you might want AV to display at a larger scale than Warsong.  Keep checked if you want to make sure that when you make ANY change to ANY Battleground Map then the settings will be copied to ALL the other Battleground maps";
AM_TT_ALL_NI1		= "Un-check to save the settings for each Non-Instance map seperately";
AM_TT_ALL_NI2		= "e.g. you might not want to display the Map Legend for dungeon exteriors   but do want it for World Boss maps.  Keep checked if you want to make sure that when you make ANY change to ANY Non-Instance Map then the settings will be copied to ALL the other Non-Instance maps";
AM_TT_MSG		= "Battleground Messages will be sent to :";
AM_TT_MSG_DFLT2		= " - your Raid if you were in a Raid BEFORE you entered the Battleground\n - your Party if you were in a Party BEFORE you entered the Battleground\n - the Battleground channel otherwise";
AM_TT_MSG_PARTY2	= " - only your Party as long as you were in a Raid or Party BEFORE you entered the Battleground\n - the Battleground channel otherwise";
AM_TT_MSG_BG2		= " - the Battleground channel only";
AM_TT_AUTO_BG1		= "Makes AlphaMap's Battleground map the default map to be used in Battlegrounds";
AM_TT_AUTO_BG2		= "Battlegound maps will open automatically when you enter a Battleground if this option is checked Un-Check if you wish to use the normal Blizzard style map in Battlegrounds (The map will not open automatically when you enter a BG)";
AM_TT_NUN_F1		= "Formatted NotesUNeed notes can be added to the database of people who receive them";
AM_TT_NUN_F2		= "(However, people without NotesUNeed installed will see extra formatting characters rather than just the note's text.)";
AM_TT_NUN		= "NotesUNeed notes will be auto-sent to :";
AM_TT_NUN_DFLT2		= " - your Raid if in a Raid\n - your Party if in a Party\n - otherwise you will just '/Say' the note  \n\nNote that Raid/Party messages will fail inside Battlegrounds unless \nyou were in the Raid/Party BEFORE you entered the Battleground";
AM_TT_NUN_PARTY2	= " - only your Party, if you are in a Raid OR Party\n - otherwise you will just '/Say' the note \n\nNote that Raid/Party messages will fail inside Battlegrounds unless \nyou were in the Raid/Party BEFORE you entered the Battleground";
AM_TT_NUN_GUILD2	= " - your Guild";
AM_TT_MOUSE1		= "Mouse Interaction mode allows you to Control-Click the AlphaMap";
AM_TT_MOUSE2		= "Normally the AlphaMap is invisible to the mouse. However, in mouse interaction mode, then when the Control key is pressed you will be able to see the name of map regions that your mouse hovers  over, and can Control-Left Click and Control-Right Click to zoom in and out. When in Mouse Interaction mode, you can also Control-Click on the AlphaMap Slider and on-map Coordinates to reposition them";
AM_TT_MUTE		= "Toggle the sound when Opening/Closing the AlphaMap";
AM_TT_XY		= "Toggle the display of Player/Cursor coordinates";
AM_TT_STANDARD		= "Standard View - world map Zones as displayed in the original Blizzard Map";
AM_TT_COMPACT1		= "Compact View - Only display explorable areas in the current Zone";
AM_TT_COMPACT2		= "Note that areas that you have NOT discovered will not be displayed unless you have installed MozzFullWorldMap (Fan's Update) AddOn";
AM_TT_BLIZZ_ALLOW1	= "While checked, AlphaMap will save any changes you make to the Blizzard Map position/opacity/scale";
AM_TT_BLIZZ_ALLOW2	= "Un-Check to restore the original Blizzard Map settings This requires a 'ReloadUI' during which the game will pause for a few seconds";
AM_TT_BLIZZ_CHANGE1	= "While checked, then changes to the opacity and scale sliders below Will only affect the original Blizzard Map";
AM_TT_HELP_TIPS1	= "Toggle Help Tooltips";
AM_TT_HELP_TIPS2	= "Does not affect on map icon tooltips";

--------------------------------------------------------------------------------------------------------------------------------------
-- Everything below should be localised apart from the 'filename', 'lootid' entries which should NOT be changed                     --
-- The first  'name'  field is used to equate with in game Zone name information to help determine when the player is in a specific --
-- Instance, and must therefore be spelt IDENTICALLY to the names of the Instances as displayed by the WoW Client in other native   --
-- frames.															    --
--------------------------------------------------------------------------------------------------------------------------------------

AM_TYP_WM			= "World Map";
AM_TYP_INSTANCE 		= "Instances";
AM_TYP_BG			= "BattleGrounds";
AM_TYP_RAID			= "Non-Instance Maps";
AM_TYP_GM			= "Blizzard Map";

AM_ALPHAMAP_LIST = {
		{	name = "Blackfathom Deeps",			-- Blackfathom Deeps
			type = AM_TYP_INSTANCE,
			displayname = "Blackfathom Deeps",
			displayshort = "BFD",
			filename = "BlackfathomDeeps",
			location = "Ashenvale (14, 14)",
			levels = "24-32",
			players = "10",
			prereq = "",
			general = "Some underwater sections",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {33, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {50, 68} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Ghamoo-ra", colour = AM_RED, coords = { {23.5, 42} }, symbol = { "1" },
					tooltiptxt = "Lvl25 Elite Beast (Giant Turtle)", lootid = "BFDGhamoora" },
			dtl4  = { text = "Lorgalis Manuscript", colour = AM_ORANGE, coords = { {23.5, 30} }, symbol = { "2" },
					tooltiptxt = "Quest Item for 'Knowledge of the Deeps',\nin chest" },
			dtl5  = { text = "Lady Sarevess", colour = AM_RED, coords = { {3, 29} }, symbol = { "3" },
					tooltiptxt = "Lvl25 Elite Humanoid", lootid = "BFDLadySarevess" },
			dtl6  = { text = "Argent Guard Thaelrid", colour = AM_BLUE, coords = { {11, 51} }, symbol = { "4" },
					tooltiptxt = "Target of Quest 'In Search of Thaelrid',\n& Quest Start for 'Villainy'" },
			dtl7  = { text = "Gelihast", colour = AM_RED, coords = { {43, 40} }, symbol = { "5" },
					tooltiptxt = "Lvl25 Elite Humanoid (Murloc)", lootid = "BFDGelihast" },
			dtl8  = { text = "Lorgus Jett", colour = AM_RED, coords = { {49, 43}, {55, 46} }, symbol = { "6" },
					tooltiptxt = "Lvl26 Elite Humanoid", special = AM_VARIES },
			dtl9  = { text = "Baron Aquanis", colour = AM_RED, coords = { {52, 76} }, symbol = { "7" },
					tooltiptxt = "Lvl28 Elite Humanoid", lootid = "BFDBaronAquanis" },
			dtl10 = { text = "Fathom Core", colour = AM_BLUE, coords = { {52, 76} }, symbol = { " " },
					tooltiptxt = "" },
			dtl11 = { text = "Twilight Lord Kelris", colour = AM_RED, coords = { {63, 81} }, symbol = { "8" },
					tooltiptxt = "Lvl27 Elite Humanoid", lootid = "BFDTwilightLordKelris" },
			dtl12 = { text = "Blackfathom-Tiefen Altar", colour = AM_BLUE, coords = { {63, 81} }, symbol = { " " },
					tooltiptxt = "" },
			dtl13 = { text = "Old Serra'kis", colour = AM_RED, coords = { {63, 74} }, symbol = { "9" },
					tooltiptxt = "Lvl26 Elite Beast", lootid = "BFDOldSerrakis" },
			dtl14 = { text = "Aku'mai", colour = AM_RED, coords = { {95, 85} }, symbol = { "10" },
					tooltiptxt = "Lvl29 Elite Beast (Hydra)", lootid = "BFDAkumai", leaveGap = 1 },
			dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "BFDTrash", leaveGap = 1 }
		},

		{	name = "Blackrock Depths",			-- Blackrock Depths
			type = AM_TYP_INSTANCE,
			displayname = "Blackrock Depths",
			displayshort = "BRD",
			filename = "BlackrockDepths",
			location = "Blackrock Mountain",
			levels = "52-60",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {21, 83} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Lord Roccor", colour = AM_RED, coords = { {33, 80} }, symbol = { "1" },
					tooltiptxt = "Lvl51 Elite Elemental", lootid = "BRDLordRoccor" },
			dtl3  = { text = "High Interrogator Gerstahn", colour = AM_RED, coords = { {38, 95} }, symbol = { "2" },
					tooltiptxt = "Lvl52 Elite Humanoid", lootid = "BRDHighInterrogatorGerstahn" },
			dtl4  = { text = "Marshal Windsor", colour = AM_BLUE, coords = { {46, 95} }, symbol = { "3" },
					tooltiptxt = "Link in Onyxia Quest Chain" },
			dtl5  = { text = "Commander Gor'shak", colour = AM_BLUE, coords = { {40, 90} }, symbol = { "4" },
					tooltiptxt = "'Commander Gor'shak' Quest" },
			dtl6  = { text = "Kharan Mighthammer", colour = AM_BLUE, coords = { {44, 86} }, symbol = { "5" },
					tooltiptxt = "'Kharan Mighthammer' Quest" },
			dtl7  = { text = "Ring of Law", colour = AM_GREEN, coords = { {42, 73.4} }, symbol = { "6" },
					tooltiptxt = "Defeat Mobs here to turn \nUpper level spectators from \nRed Aggro. to Yellow", lootid = "BRDArena" },
			dtl8  = { text = "Theldren", colour = AM_RED, coords = { {42, 73.4} }, symbol = { " " },
					tooltiptxt = "NPC Group Leader", lootid = "BRDArena" },
			dtl9  = { text = "Franclorn Forgewright", colour = AM_BLUE, coords = { {45.8, 78.1} }, symbol = { "7" },
					tooltiptxt = "'Dark Iron Legacy' Quest" },
			dtl10  = { text = "Pyromancer Loregrain", colour = AM_RED, coords = { {48, 78} }, symbol = { "8" },
					tooltiptxt = "Lvl52 Elite Humanoid", special = AM_RARE, lootid = "BRDPyromantLoregrain" },
			dtl11 = { text = "The Vault", colour = AM_GREEN, coords = { {54, 54} }, symbol = { "9" },
					tooltiptxt = "" },
			dtl12  = { text = "Fineous Darkvire", colour = AM_RED, coords = { {55, 41} }, symbol = { "10" },
					tooltiptxt = "Lvl54 Elite Humanoid", lootid = "BRDFineousDarkvire" },
			dtl13 = { text = "Warder Stilgliss", colour = AM_RED, coords = { {48, 55} }, symbol = { "11" },
					tooltiptxt = "Lvl56 Elite Humanoid", lootid = "BRDWarderStilgiss" },
			dtl14 = { text = "Verek", colour = AM_RED, coords = { {54, 54} }, symbol = { " " },
					tooltiptxt = "Lvl55 Elite" },
			dtl15 = { text = "Lord Incendius", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { "12" },
					tooltiptxt = "'Incendius!' Quest", lootid = "BRDLordIncendius" },
			dtl16 = { text = "The Black Anvil", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { " " },
					tooltiptxt = "" },
			dtl17 = { text = "ShadowForge Lock", colour = AM_GREEN, coords = { {31, 72.4} }, symbol = { "13" },
					tooltiptxt = "Unlock to allow deeper access to higher level areas\nRequires Shadowforge Key" },
			dtl18 = { text = "Bael'Gar", colour = AM_RED, coords = { {8, 62} }, symbol = { "14" },
					tooltiptxt = "Lvl57 Elite Mountain Giant", lootid = "BRDBaelGar" },
			dtl19 = { text = "General Angerforge", colour = AM_RED, coords = { {24, 64} }, symbol = { "15" },
					tooltiptxt = "Lvl57 Elite Dwarf", lootid = "BRDGeneralAngerforge" },
			dtl20 = { text = "Golem Lord Argelmach", colour = AM_RED, coords = { {24, 51} }, symbol = { "16" },
					tooltiptxt = "Lvl58 Elite Dwarf", lootid = "BRDGolemLordArgelmach" },
			dtl21 = { text = "The Grim Guzzler", colour = AM_GREEN, coords = { {40, 50} }, symbol = { "17" },
					tooltiptxt = "Buy 6 Dark Iron Ale mugs\nand give them to Rocknot ;P", lootid = "BRDGuzzler" },
			dtl22 = { text = "Ambassador Flamelash", colour = AM_RED, coords = { {46, 38} }, symbol = { "18" },
					tooltiptxt = "Lvl57 Elite Humanoid", lootid = "BRDFlamelash" },
			dtl23 = { text = "Panzor the Invincible", colour = AM_RED, coords = { {40, 27} }, symbol = { "19" },
					tooltiptxt = "Lvl57 Elite Golem", special = AM_RARE, lootid = "BRDPanzor" },
			dtl24 = { text = "Summoner's Tomb", colour = AM_GREEN, coords = { {46, 18} }, symbol = { "20" },
					tooltiptxt = "Defeat 7 bosses in sequence to go deeper\n& Chest", lootid = "BRDTomb" },
			dtl25 = { text = "The Lyceum", colour = AM_GREEN, coords = { {61, 8.5} }, symbol = { "21" },
					tooltiptxt = "Find and defeat 2 Flamekeepers\nand light both torches to progress.\nOnly have 3 minutes from killing the first." },
			dtl26 = { text = "Magmus", colour = AM_RED, coords = { {78, 8.5} }, symbol = { "22" },
					tooltiptxt = "Lvl57 Elite Mountain Giant", lootid = "BRDMagmus" },
			dtl27 = { text = "Princess Moira Bronzebeard", colour = AM_RED, coords = { {90, 8} }, symbol = { "23" },
					tooltiptxt = "Lvl58 Elite Humanoid", lootid = "BRDPrincess" },
			dtl28 = { text = "Emperor Dagran Thaurissan", colour = AM_RED, coords = { {93, 8.5} }, symbol = { "24" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "BRDImperatorDagranThaurissan" },
			dtl29 = { text = "The Black Forge", colour = AM_GREEN, coords = { {63, 22} }, symbol = { "23" },
					tooltiptxt = "Forge Dark Iron,\nand make Smoking Heart of the Mountain" },
			dtl30 = { text = "Molten Core", colour = AM_ORANGE, coords = { {65, 30} }, symbol = { "24" },
					tooltiptxt = "'Attunement to the Core' Quest\nMolten Core Entrance", toMap = "Molten Core", leaveGap = 1 }
		},

		{	name = "Blackrock Spire",		-- Blackrock Spire
			type = AM_TYP_INSTANCE,
			displayname = "Blackrock Spire (Lower)",
			displayshort = "LBRS",
			filename = "LBRS",			-- LBRS
			location = "Blackrock Mountain",
			levels = "53-60",
			players = "15",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Blacrock Spire (Upper)", colour = AM_BLUE, coords = { {22, 4} }, symbol = { "U" },
					tooltiptxt = "", toMap = "Blackrock Spire (Upper)" },
			dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {45.2, 29}, {73, 46} }, symbol = { "x1" },
					tooltiptxt = "" },
			dtl4  = { text = "Bridge to High Lord Omokk", colour = AM_GREEN, coords = { {38, 32.1}, {15, 32.1} }, symbol = { "B" },
					tooltiptxt = "" },
			dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {71, 22}, {94, 26} }, symbol = { "x2" },
					tooltiptxt = "Lower Level" },
			dtl6  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {29, 53}, {29, 77} }, symbol = { "x3" },
					tooltiptxt = "" },
			dtl7  = { text = "Ramps", colour = AM_BLUE, coords = { {86, 40}, {89, 58} }, symbol = { "R" },
					tooltiptxt = "", leaveGap = 1 },
			dtl8  = { text = "Vaelan", colour = AM_RED, coords = { {31, 17} }, symbol = { "1" },
					tooltiptxt = "Lvl55 Elite\nSeal of Ascension Quest"  },
			dtl9  = { text = "Warosh", colour = AM_RED, coords = { {53, 14} }, symbol = { "2" },
					tooltiptxt = "Lvl60 Elite Humanoid"  },
			dtl10 = { text = "Roughshod Pike", colour = AM_ORANGE, coords = { {69, 29} }, symbol = { "3" },
					tooltiptxt = "Quest Item"  },
			dtl11 = { text = "Bijou", colour = AM_BLUE, coords = { {62, 25 } }, symbol = { "4" },
					tooltiptxt = "Bijou Quest chain\nNot Lower Level" },
			dtl12 = { text = "Spirestone Butcher", colour = AM_RED, coords = { {42, 32.1} }, symbol = { "5" },
					tooltiptxt = "Lvl59 Elite Humanoid\nPatrols bridge to Highlord Omokk", lootid = "LBRSSpirestoneButcher", special = AM_RARE  },
			dtl13 = { text = "Highlord Omokk", colour = AM_RED, coords = { {2, 32.1} }, symbol = { "6" },
					tooltiptxt = "Lvl?? Elite Humanoid", lootid = "LBRSOmokk"  },
			dtl14 = { text = "Spirestone Battle Lord", colour = AM_RED, coords = { {2, 32.1} }, symbol = { " " },
					tooltiptxt = "Spawns on hill near Lord Omokk", lootid = "LBRSSpirestoneLord", special = AM_RARE },
			dtl15 = { text = "Shadow Hunter Vosh'gajin", colour = AM_RED, coords = { {77, 64} }, symbol = { "7" },
					tooltiptxt = "Lvl?? Elite Humanoid", lootid = "LBRSVosh"  },
			dtl16 = { text = "Fith Mosh'aru Tablet", colour = AM_ORANGE, coords = { {77, 68} }, symbol = { "8" },
					tooltiptxt = "Quest Item"  },
			dtl17 = { text = "Bannok Grimaxe", colour = AM_RED, coords = { {41.5, 26.5} }, symbol = { "9" },
					tooltiptxt = "Lvl59 Elite Humanoid\nOn Lower Level", lootid = "LBRSGrimaxe", special = AM_RARE },
			dtl18 = { text = "War Master Voone", colour = AM_RED, coords = { {73, 32} }, symbol = { "10" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "LBRSVoone" },
			dtl19 = { text = "Sixth Mosh'aru Tablet", colour = AM_ORANGE, coords = { {75, 29} }, symbol = { "11" },
					tooltiptxt = "Quest Item"  },
			dtl20 = { text = "Mor Grayhoof", colour = AM_RED, coords = { {75, 35} }, symbol = { "12" },
					tooltiptxt = "Lvl60 Elite\nRequires Summoning Brazier\nInterrupt their heals", lootid = "LBRSGrayhoof" },
			dtl21  = { text = "Mother Smolderweb", colour = AM_RED, coords = { {54, 58} }, symbol = { "13" },
					tooltiptxt = "Lvl59 Elite Beast", lootid = "LBRSSmolderweb"  },
			dtl22 = { text = "Crystal Fang", colour = AM_RED, coords = { {36, 49} }, symbol = { "14" },
					tooltiptxt = "Lvl60 Elite Beast", special = AM_RARE, lootid = "LBRSCrystalFang"  },
			dtl23 = { text = "Urok Doomhowl", colour = AM_RED, coords = { {30, 30} }, symbol = { "15" },
					tooltiptxt = "Lvl60 Elite Humanoid", lootid = "LBRSDoomhowl"  },
			dtl24 = { text = "Quartermaster Zigris", colour = AM_RED, coords = { {50, 89} }, symbol = { "16" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "LBRSZigris"  },
			dtl25 = { text = "Halcyon", colour = AM_RED, coords = { {19, 92} }, symbol = { "17" },
					tooltiptxt = "Lvl59 Elite Beast\nKill to trigger spawn of Gizrul", lootid = "LBRSHalycon"  },
			dtl26 = { text = "Gizrul the Slavener", colour = AM_RED, coords = { {19, 92} }, symbol = { " " },
					tooltiptxt = "Lvl60 Elite Beast\nSpawn triggered by death of Halcyon", lootid = "LBRSSlavener"  },
			dtl27 = { text = "Overlord Wyrmthalak", colour = AM_RED, coords = { {42, 62} }, symbol = { "18" },
					tooltiptxt = "Lvl?? Elite Dragon", lootid = "LBRSWyrmthalak", leaveGap = 1  },
			dtl28 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
			dtl29 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "LBRSTrash", leaveGap = 1 }
		},

		{	name = "Blackrock Spire (Upper)",
			type = AM_TYP_INSTANCE,
			displayname = "Blackrock Spire (Upper)",
			displayshort = "UBRS",
			filename = "UBRS",			-- UBRS
			location = "Blackrock Mountain",
			levels = "53-60",
			players = "15",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 80.7} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Blackrock Spire (Lower)", colour = AM_BLUE, coords = { {18.2, 86.6} }, symbol = { "L" },
					tooltiptxt = "", toMap = "Blackrock Spire", leaveGap = 1 },
			dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {11.9, 58.4}, {8.65, 25} }, symbol = { "x1" },
					tooltiptxt = "" },
			dtl4  = { text = "Pyroguard Emberseer", colour = AM_RED, coords = { {8.2, 31.0} }, symbol = { "1" },
					tooltiptxt = "Lvl?? Elite Elemental", lootid = "UBRSEmberseer", leaveGap = 1  },
			dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {8.6, 38.9}, {36.4, 61.2} }, symbol = { "x2" },
					tooltiptxt = "" },
			dtl6  = { text = "Doomrigger's Clasp", colour = AM_ORANGE, coords = { {41.3, 68.65} }, symbol = { "2" },
					tooltiptxt = "Quest Item\nIn large Chest among toppled pillars\nCan be hard to spot\nCan drop down from General Drakkisath"  },
			dtl7  = { text = "Father Flame", colour = AM_ORANGE, coords = { {50, 65.45} }, symbol = { "3" },
					tooltiptxt = "Fight spawns near doorway\nStop hatchers hatching eggs", lootid = "UBRSFLAME"  },
			dtl8  = { text = "Solakar Flamewreath", colour = AM_RED, coords = { {50, 65.45} }, symbol = { " " },
					tooltiptxt = "Lvl60 Elite Dragonkin\nSpawned after Looting Father Flame", lootid = "UBRSSolakar" },
			dtl9  = { text = "Jed Runewatcher", colour = AM_RED, coords = { {47, 52.6} }, symbol = { "4" },
					tooltiptxt = "Lvl59 Elite Humanoid", special = AM_RARE, lootid = "UBRSRunewatcher"  },
			dtl10 = { text = "Goraluk Anvilcrack", colour = AM_RED, coords = { {34, 52.6} }, symbol = { "5" },
					tooltiptxt = "Lvl61 Elite Humanoid", lootid = "UBRSAnvilcrack"  },
			dtl11 = { text = "Warchief Rend Blackhand", colour = AM_RED, coords = { {67.5, 51} }, symbol = { "6" },
					tooltiptxt = "Boss\nLimited to 'For the Horde!' Quest\nComes mounted on Gyth", lootid = "UBRSRend"  },
			dtl12  = { text = "Gyth", colour = AM_RED, coords = { {67.5, 51} }, symbol = { " " },
					tooltiptxt = "Lvl?? Elite Dragon", lootid = "UBRSGyth" },
			dtl13 = { text = "Awbee", colour = AM_BLUE, coords = { {68.1, 65.9} }, symbol = { "7" },
					tooltiptxt = "Limited to 'The Matron Protectorate' Quest"  },
			dtl14 = { text = "The Beast", colour = AM_RED, coords = { {95.7, 60.8} }, symbol = { "8" },
					tooltiptxt = "Lvl?? Elite Beast", lootid = "UBRSBeast"  },
			dtl15 = { text = "Lord Valthalak", colour = AM_RED, coords = { {95.7, 56.5} }, symbol = { "9" },
					tooltiptxt = "Lvl?? Elite\nNeed Quest to Summon\nClear Hall of Blackhand first", lootid = "UBRSValthalak" },
			dtl16  = { text = "General Drakkisath", colour = AM_RED, coords = { {41.6, 73.2} }, symbol = { "10" },
					tooltiptxt = "Lvl?? Elite Dragon", lootid = "UBRSDrakkisath"  },
			dtl17 = { text = "Blackwing Lair", colour = AM_BLUE, coords = { {78.5, 27.6} }, symbol = { "BWL" },
					tooltiptxt = "", toMap = "Blackwing Lair", leaveGap = 1 },
			dtl18 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
			dtl19 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "UBRSTrash", leaveGap = 1 }
		},

		{	name = "Blackwing Lair",		-- Blackwing Lair
			type = AM_TYP_INSTANCE,
			displayname = "Blackwing Lair",
			displayshort = "BWL",
			filename = "BlackwingLair",
			location = "Blackrock Spire",
			levels = "60+",
			players = "40",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {65, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", toMap = "Blackrock Spire (Upper)", leaveGap = 1 },
			dtl2 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {32.8, 78}, {61, 48} }, symbol = { "x1" },
					tooltiptxt = "" },
			dtl3 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {40, 96}, {68, 65} }, symbol = { "x2" },
					tooltiptxt = "" },
			dtl4 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {47, 51}, {17, 52} }, symbol = { "x3" },
					tooltiptxt = "", leaveGap = 1 },
			dtl5  = { text = "Razorgore the Untamed", colour = AM_RED, coords = { {51, 66} }, symbol = { "1" },
					tooltiptxt = "Boss", lootid = "BWLRazorgore"  },
			dtl6  = { text = "Vaelastrasz the Corrupt", colour = AM_RED, coords = { {32.5, 67} }, symbol = { "2" },
					tooltiptxt = "Boss", lootid = "BWLVaelastrasz"  },
			dtl7  = { text = "Broodlord Lashlayer", colour = AM_RED, coords = { {77, 42} }, symbol = { "3" },
					tooltiptxt = "Boss", lootid = "BWLLashlayer"  },
			dtl8  = { text = "Firemaw", colour = AM_RED, coords = { {12, 44} }, symbol = { "4" },
					tooltiptxt = "Boss", lootid = "BWLFiremaw"  },
			dtl9  = { text = "Ebonroc", colour = AM_RED, coords = { {10, 29} }, symbol = { "5" },
					tooltiptxt = "Boss", lootid = "BWLEbonroc"  },
			dtl10 = { text = "Flamegor", colour = AM_RED, coords = { {18, 29} }, symbol = { "6" },
					tooltiptxt = "Boss", lootid = "BWLFlamegor"  },
			dtl11 = { text = "Chromaggus", colour = AM_RED, coords = { {33, 40} }, symbol = { "7" },
					tooltiptxt = "Boss", lootid = "BWLChromaggus"  },
			dtl12 = { text = "Nefarian", colour = AM_RED, coords = { {60, 14} }, symbol = { "8" },
					tooltiptxt = "Boss", lootid = "BWLNefarian", leaveGap = 1 },
			dtl13 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "BWLTrashMobs", leaveGap = 1 },
			dtl14 = { text = AM_TIER2_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "T2SET", leaveGap = 1 }
		},

		{	name = "Dire Maul"..AM_EXTERIOR,		-- Dire Maul Exterior
			type = AM_TYP_RAID,
			displayname = AM_EXTERIOR.." - Dire Maul",
			displayshort = "DM",
			filename = "DireMaulExt",
			location = "Feralas (59, 44)",
			levels = "",
			players = "",
			prereq = "",
			general = "",
			area = "Kalimdor",
			wmData = { minX = 0.4268, maxX = 0.441, minY =  0.6648, maxY = 0.696 },
			amData = { minX = 0.29, maxX = 0.97, minY = 0.025, maxY = 0.98 },
			dtl1  = { text = "Entrance", colour = AM_GREEN, coords = { {32, 97}  }, symbol = { "X" },
					tooltiptxt = "", toMap = "Dire Maul", leaveGap = 1 },
			dtl2  = { text = "Eldereth Row", colour = AM_BLUE, coords = { {57, 73} }, symbol = { "1" },
					tooltiptxt = "" },
			dtl3  = { text = "Broken Commons", colour = AM_BLUE, coords = { {62, 50} }, symbol = { "2" },
					tooltiptxt = "" },
			dtl4  = { text = "Skarr the Unbreakable", colour = AM_RED, coords = { {62, 33} }, symbol = { "3" },
					tooltiptxt = "Lvl58 Elite Humanoid" },
			dtl5  = { text = "The Maul", colour = AM_RED, coords = { {62, 26} }, symbol = { "4" },
					tooltiptxt = "PvP Area" },
			dtl6  = { text = "Path to The Maul", colour = AM_BLUE, coords = { {44, 47}, {58, 33} }, symbol = { "P" },
					tooltiptxt = "Sleeping Hyena Guards" },
			dtl7  = { text = "Chamber with roof Exit from DM East", colour = AM_BLUE, coords = { {85, 19.4} }, symbol = { "5" },
					tooltiptxt = "", leaveGap = 1 },
			dtl8  = { text = "Dire Maul East", colour = AM_GREEN, coords = { {84, 32}, {96, 62} }, symbol = { "E" },
					tooltiptxt = "Click to Open Dire Maul East Map", toMap = "Dire Maul East" },
			dtl9  = { text = "Dire Maul North", colour = AM_GREEN, coords = { {62, 4} }, symbol = { "N" },
					tooltiptxt = "Click to Open Dire Maul North Map", toMap = "Dire Maul North" },
			dtl10 = { text = "Dire Maul West", colour = AM_GREEN, coords = { {42, 40} }, symbol = { "W" },
					tooltiptxt = "Click to Open Dire Maul West Map", toMap = "Dire Maul West", leaveGap = 1 }
		},

		{	name = "Dire Maul",		-- Dire Maul
			type = AM_TYP_INSTANCE,
			displayname = "Dire Maul - Overview",
			displayshort = "DM",
			filename = "DireMaul",
			location = "Feralas (59, 44)",
			levels = "56-60",
			players = "5",
			prereq = "",
			general = "",
			dtl1  = { text = "Dire Maul East", colour = AM_GREEN, coords = { {53, 81}, {57, 96}, {100, 80} }, symbol = { "E" },
					tooltiptxt = "Click to Open Dire Maul East Map", toMap = "Dire Maul East" },
			dtl2  = { text = "Dire Maul North", colour = AM_GREEN, coords = { {67.5, 38} }, symbol = { "N" },
					tooltiptxt = "Click to Open Dire Maul North Map", toMap = "Dire Maul North" },
			dtl3  = { text = "Dire Maul West", colour = AM_GREEN, coords = { {47, 88} }, symbol = { "W" },
					tooltiptxt = "Click to Open Dire Maul West Map", toMap = "Dire Maul West", leaveGap = 1 },
			dtl4  = { text = "Library", colour = AM_BLUE, coords = { {24, 58}, {41, 41} }, symbol = { "L" },
					tooltiptxt = "Reached from North or West Dire Maul", leaveGap = 1 }
		},


		{	name = "Dire Maul East",		-- Dire Maul East
			type = AM_TYP_INSTANCE,
			displayname = "Dire Maul (East)",
			displayshort = "DM",
			filename = "DMEast",		--DMEast
			location = "Feralas (59, 44)",
			levels = "56-60",
			players = "5",
			prereq = "",
			general = "",
			dtl1  = { text = "Entrance : Broken Commons", colour = AM_GREEN, coords = { {6, 58}  }, symbol = { "X1" },
					tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
			dtl2  = { text = "Entrance : Eldereth Row", colour = AM_GREEN, coords = { {12, 92} }, symbol = { "X2" },
					tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
			dtl3  = { text = "Entrance : Pavillion", colour = AM_GREEN, coords = { {98, 64} }, symbol = { "X3" },
					tooltiptxt = "" },
			dtl4  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {8, 40} }, symbol = { AM_EXIT_SYMBOL },
					tooltiptxt = "Drop to Broken Commons\nside Chamber" },
			dtl5  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {41, 85}, {61, 93} }, symbol = { "L1" },
					tooltiptxt = "" },
			dtl6  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {75, 92}, {55, 82} }, symbol = { "L2" },
					tooltiptxt = "" },
			dtl7  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {67, 63}, {83, 73} }, symbol = { "L3" },
					tooltiptxt = "", leaveGap = 1 },
			dtl8  = { text = "Pusillin Chase Starts", colour = AM_GREEN, coords = { {10, 50} }, symbol = { "P" },
					tooltiptxt = "Chase to get Dire Maul (Crescent) Key", lootid = "DMEPusillin"  },
			dtl9  = { text = "Pusillin Chase End", colour = AM_RED, coords = { {79, 61} }, symbol = { "P" },
					tooltiptxt = "Oooh, you little Imp!", lootid = "DMEPusillin"  },
			dtl10 = { text = "Zevrim Thornhoof", colour = AM_RED, coords = { {83, 88} }, symbol = { "1" },
					tooltiptxt = "Lvl57 Elite Demon", lootid = "DMEZevrimThornhoof"  },
			dtl11 = { text = "Hydrospawn", colour = AM_RED, coords = { {64, 77} }, symbol = { "2" },
					tooltiptxt = "Lvl57 Elite Elemental", lootid = "DMEHydro"  },
			dtl12 = { text = "Lethendris", colour = AM_RED, coords = { {46, 66} }, symbol = { "3" },
					tooltiptxt = "Lvl57 Elite Humanoid", lootid = "DMELethtendris"  },
			dtl13 = { text = "Old Ironbark", colour = AM_RED, coords = { {21, 69} }, symbol = { "4" },
					tooltiptxt = "Opens door"  },
			dtl14 = { text = "Alzzin the Wildshaper", colour = AM_RED, coords = { {42, 23} }, symbol = { "5" },
					tooltiptxt = "Lvl58 Elite Demon", lootid = "DMEAlzzin"  },
			dtl15 = { text = "Isalien", colour = AM_RED, coords = { {42, 23} }, symbol = { " " },
					tooltiptxt = "Need Brazier of Beckoning to summon\nQuest from Bodley in Blackrock Mountain", lootid = "DMEIsalien", leaveGap = 2 },
			dtl16 = { text = "Books", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
			dtl17 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DMETrash", leaveGap = 1 }
		},

		{	name = "Dire Maul North",		-- Dire Maul North
			type = AM_TYP_INSTANCE,
			displayname = "Dire Maul (North)",
			displayshort = "DM",
			filename = "DMNorth",		-- DMNorth
			location = "Feralas (59, 44)",
			levels = "56-60",
			players = "5",
			prereq = "Requires Crescent Key from Pusillin Chase in DM East",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {74, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
			dtl2  = { text = "Dire Maul(West)", colour = AM_GREEN, coords = { {9, 98} }, symbol = { "W" },
					tooltiptxt = "", toMap = "Dire Maul West" },
			dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {49.2, 59.4} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "Guard Mol'dar", colour = AM_RED, coords = { {76.4, 55.5} }, symbol = { "1" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "DMNGuardMoldar"  },
			dtl5  = { text = "Stomper Kreeg", colour = AM_RED, coords = { {67, 49} }, symbol = { "2" },
					tooltiptxt = "Lvl57 Elite Demon", lootid = "DMNStomperKreeg"  },
			dtl6  = { text = "Guard Fengus", colour = AM_RED, coords = { {49.2, 56.1} }, symbol = { "3" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "DMNGuardFengus"  },
			dtl7  = { text = "Guard Slip'kik", colour = AM_RED, coords = { {17, 41} }, symbol = { "4" },
					tooltiptxt = "Lvl59 Elite Humanoid", lootid = "DMNGuardSlipkik"  },
			dtl8  = { text = "Knot Thimblejack", colour = AM_RED, coords = { {19, 37} }, symbol = { "5" },
					tooltiptxt = "", lootid = "DMNThimblejack"  },
			dtl9  = { text = "Captain Kromcrush", colour = AM_RED, coords = { {24.6, 34.8} }, symbol = { "6" },
					tooltiptxt = "", lootid = "DMNCaptainKromcrush"  },
			dtl10 = { text = "King Gordok", colour = AM_RED, coords = { {24.2, 11.2} }, symbol = { "7" },
					tooltiptxt = "", lootid = "DMNKingGordok"  },
			dtl11 = { text = "Library", colour = AM_BLUE, coords = { {20, 89} }, symbol = { "8" },
					tooltiptxt = "", leaveGap = 2  },
			dtl12 = { text = "Tribute Run", colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "DMNTRIBUTERUN" },
			dtl13 = { text = "Books", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 }
		},

		{	name = "Dire Maul West",		-- Dire Maul West
			type = AM_TYP_INSTANCE,
			displayname = "Dire Maul (West)",
			displayshort = "DM",
			filename = "DMWest",		-- DMWest
			location = "Feralas (59, 44)",
			levels = "56-60",
			players = "5",
			prereq = "Requires Crescent Key from Pusillin Chase in DM East",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {97, 78} }, symbol = { "X1" },
					tooltiptxt = "", toMap = "Dire Maul"..AM_EXTERIOR },
			dtl2  = { text = "Dire Maul (North)", colour = AM_GREEN, coords = { {66, 9} }, symbol = { "N" },
					tooltiptxt = "", toMap = "Dire Maul North", leaveGap = 1 },
			dtl3  = { text = "Stairs", colour = AM_BLUE, coords = { {49.2, 25}, {52, 60} }, symbol = { AM_STAIRS_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "Pylons", colour = AM_GREEN, coords = { {83, 80}, {64, 61}, {64, 87}, {27, 62}, {27, 37} }, symbol = { "P" },
					tooltiptxt = "Destroy these", leaveGap = 1 },
			dtl5  = { text = "Shen'dralar Ancient", colour = AM_ORANGE, coords = { {68, 74} }, symbol = { "1" },
					tooltiptxt = "Quest to Kill Prince" },
			dtl6  = { text = "Tendris Warpwood", colour = AM_RED, coords = { {58, 74} }, symbol = { "2" },
					tooltiptxt = "Lvl60 Elite Elemental", lootid = "DMWTendrisWarpwood" },
			dtl7  = { text = "Illyanna Ravnoak", colour = AM_RED, coords = { {49, 87} }, symbol = { "3" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "DMWIllyannaRavenoak" },
			dtl8  = { text = "Tsu'Zee", colour = AM_RED, coords = { {48, 60} }, symbol = { "4" },
					tooltiptxt = "Lvl59 Elite Undead", special = AM_RARE, lootid = "DMWTsuzee" },
			dtl9  = { text = "Magister Kalendris", colour = AM_RED, coords = { {53, 51} }, symbol = { "5" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "DMWMagisterKalendris" },
			dtl10 = { text = "Immol'thar", colour = AM_RED, coords = { {19, 49} }, symbol = { "6" },
					tooltiptxt = "Lvl61 Elite Demon", lootid = "DMWImmolthar" },
			dtl11 = { text = "Lord Hel'nurath", colour = AM_RED, coords = { { 19, 49} }, symbol = { " " },
					tooltiptxt = "Lvl62 Elite Demon\nSummon as part of Warlock Epic Mount quest", lootid = "DMWHelnurath" },
			dtl12 = { text = "Prince Tortheldrin", colour = AM_RED, coords = { {41, 26} }, symbol = { "7" },
					tooltiptxt = "Lvl61 Elite Humanoid", lootid = "DMWPrinceTortheldrin", leaveGap = 1  },
			dtl13 = { text = "Library", colour = AM_BLUE, coords = { {51, 20} }, symbol = { "8" },
					tooltiptxt = "", leaveGap = 1 },
			dtl14 = { text = "Books", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
			dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DMWTrash", leaveGap = 1 }
		},

		{	name = "Gnomeregan",			-- Gnomeregan
			type = AM_TYP_INSTANCE,
			displayname = "Gnomeregan",
			filename = "Gnomeregan",
			location = "Dun Morogh (25, 41)",
			levels = "26-33",
			players = "10",
			prereq = "",
			general = "Horde access via Teleporter in Booty Bay.\nInitial Quest from Orgrimmar Engineer.",
			dtl1  = { text = "Front Entrance (Clockwerk Run)", colour = AM_GREEN, coords = { {70.5, 16} }, symbol = { "X1" },
					tooltiptxt = "", toMap = "Gnomeregan"..AM_EXTERIOR },
			dtl2  = { text = "Rear Entrance (Workshop)", colour = AM_GREEN, coords = { {87, 59} }, symbol = { "X2" },
					tooltiptxt = "Workshop Key Required", toMap = "Gnomeregan"..AM_EXTERIOR },
			dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {75, 38}, {79, 56} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "Viscous Fallout", colour = AM_RED, coords = { {71.5, 33.5} }, symbol = { "1" },
					tooltiptxt = "Lvl30 Elite Elemental\nLower level", lootid = "GnViscousFallout" },
			dtl5  = { text = "Grubbis", colour = AM_RED, coords = { {95, 46} }, symbol = { "2" },
					tooltiptxt = "Lvl32 Elite Humanoid\nTriggered Spawn\nSpeak to Blastmaster at same location", lootid = "GnGrubbis"  },
			dtl6  = { text = "Kernobee (The Dormitory)", colour = AM_BLUE, coords = { {76, 54} }, symbol = { "3" },
					tooltiptxt = ""  },
			dtl7  = { text = "Matrix Punchograh 3005-B", colour = AM_GREEN, coords = { {70, 50} }, symbol = { "B" },
					tooltiptxt = "Card Upgrade"  },
			dtl8  = { text = "The Clean Zone", colour = AM_GREEN, coords = { {64, 46} }, symbol = { "4" },
					tooltiptxt = ""  },
			dtl9  = { text = "Electrocutioner 6000", colour = AM_RED, coords = { {30, 49} }, symbol = { "5" },
					tooltiptxt = "Lvl32 Elite Mechanical\nDrops Workshop Key", lootid = "GnElectrocutioner6000"  },
			dtl10 = { text = "Matrix Puchograph 3005-C", colour = AM_GREEN, coords = { {33.2, 49.6} }, symbol = { "C" },
					tooltiptxt = "Card Upgrade"  },
			dtl11 = { text = "Crowd Pummeler 9-60", colour = AM_RED, coords = { {47.6, 77.3} }, symbol = { "6" },
					tooltiptxt = "Lvl32 Elite Mechanical", lootid = "GnCrowdPummeler960"  },
			dtl12 = { text = "Matrix Punchograph 3005-D", colour = AM_GREEN, coords = { {48.9, 75.7} }, symbol = { "D" },
					tooltiptxt = "Card Upgrade"  },
			dtl13 = { text = "Dark Iron Ambassador", colour = AM_RED, coords = { {9, 52} }, symbol = { "5" },
					tooltiptxt = "Lvl33 Elite Humanoid", special = AM_RARE, lootid = "GnDIAmbassador"  },
			dtl14 = { text = "Mekgineer Thermoplugg", colour = AM_RED, coords = { {11.8, 42.2} }, symbol = { "8" },
					tooltiptxt = "Lvl35 Elite Demon", lootid = "GnMekgineerThermaplugg", leaveGap = 1  },
			dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "GnTrash", leaveGap = 1 }
		},

		{	name = "Gnomeregan"..AM_EXTERIOR,			-- Gnomeregan
			type = AM_TYP_RAID,
			displayname = AM_EXTERIOR.." - Gnomeregan Instance",
			filename = "GnomereganExt",
			location = "Dun Morogh (25, 41)",
			levels = "",
			players = "",
			prereq = "",
			general = "Horde access via Teleporter in Booty Bay.\nInitial Quest from Orgrimmar Engineer.",
			wmData = { minX = 0.42812, maxX = 0.43726, minY =  0.52503, maxY = 0.53932 },
			amData = { minX = 0.198, maxX = 0.905, minY = 0.21, maxY = 0.940 },
			dtl1  = { text = "Outside", colour = AM_GREEN, coords = { {91.0, 92.5} }, symbol = { "O" },
					tooltiptxt = "" },
			dtl2  = { text = "Elevator", colour = AM_GREEN, coords = { {81.59, 87.65} }, symbol = { "L" },
					tooltiptxt = "" },
			dtl3  = { text = "Transpolyporter", colour = AM_GREEN, coords = { {60.95, 72.95} }, symbol = { "P" },
					tooltiptxt = "From Booty Bay" },
			dtl4  = { text = "Sprok", colour = AM_BLUE, coords = { {60.95, 72.95} }, symbol = { " " },
					tooltiptxt = "Away Team", leaveGap = 1 },
			dtl5  = { text = "Matrix Punchograh 3005-A", colour = AM_PURPLE, coords = { {67.29, 42.22}, {61.43, 41.78}, {64.00, 26.52}, {69.46, 26.75} }, symbol = { "A" },
					tooltiptxt = "Card Upgrade" },
			dtl6  = { text = "Techbot", colour = AM_RED, coords = { {44.0, 36.53} }, symbol = { "1" },
					tooltiptxt = "Lvl26 Elite Mechanical", leaveGap = 1 },
			dtl7  = { text = "Main Instance Entrance", colour = AM_ORANGE, coords = { {18.89, 88.0} }, symbol = { "I" },
					tooltiptxt = "", toMap = "Gnomeregan" },
			dtl8  = { text = "Workshop Instance Entrance", colour = AM_ORANGE, coords = { {62.46, 22.75} }, symbol = { "W" },
					tooltiptxt = "Requires Workshop Key", toMap = "Gnomeregan", leaveGap = 1  }
		},

		{	name = "Kazzak",			-- Lord Kazzak
			type = AM_TYP_RAID,
			displayname = "Lord Kazzak",
			filename = "AM_Kazzak_Map",
			location = "Blasted Lands : The Tainted Scar (32, 44)",
			minimapZoom = 1.42,
			minimapXOffset = 95,
			minimapYOffset = 0,
			area = "BlastedLands",
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "",
			wmData = { minX = 0.33, maxX = 0.49, minY = 0.47, maxY = 0.79 },
			amData = { minX = 0.25, maxX = 0.99, minY = 0.01, maxY = 0.98 },
			dtl1 = { text = "Approach", colour = AM_GREEN, coords = { {79, 30} }, symbol = { AM_ENTRANCE },
					tooltiptxt = "", leaveGap = 1 },
			dtl2 = { text = "Lord Kazzak", colour = AM_RED, coords = { {42, 84} }, symbol = { "1" },
					tooltiptxt = "Boss", lootid = "KKazzak", leaveGap = 1 },
			dtl3 = { text = "Daio the Decrepit", colour = AM_GREEN, coords = { {29.5, 8.5} }, symbol = { "2" },
					tooltiptxt = "", leaveGap = 1 }
		},

		{	name = "Azuregos",				-- Azuregos
			type = AM_TYP_RAID,
			displayname = "Azuregos",
			filename = "AM_Azuregos_Map",
			location = "Azshara (Approx. 56, 81)",
			minimapZoom = 1.5385,
			minimapXOffset = 0,
			minimapYOffset = 0,
			area = "Aszhara",				-- Deliberately spelt Aszhara !
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "",
			wmData = { minX = 0.485, maxX = 0.62743, minY = 0.71498, maxY = 0.917 },
			amData = { minX = 0.005, maxX = 0.995, minY = 0.005, maxY = 0.995 },
			dtl1 = { text = "Azuregos", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "Talk with to trigger combat", lootid = "AAzuregos", leaveGap = 1 }
		},

		{	name = "Four Dragons: Duskwood",		-- Four Dragons
			type = AM_TYP_RAID,
			displayname = "Four Dragons: Duskwood",
			filename = "AM_Dragon_Duskwood_Map",
			location = "Duskwood : Twighlight Grove (46, 36)",
			minimapZoom = 2.11,
			minimapXOffset = 54,
			minimapYOffset = 0,
			area = "Duskwood",
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "",
			wmData = { minX = 0.421, maxX = .526, minY = 0.292, maxY = 0.54 },
			amData = { minX = 0.29, maxX = .85, minY = 0.115, maxY = 0.97 },
			dtl1 = { text = "Approach", colour = AM_GREEN, coords = { {48, 96} }, symbol = { AM_ENTRANCE },
					tooltiptxt = "", leaveGap = 1 },
			dtl2 = { text = "Emerald Gate", colour = AM_GREEN, coords = { {54, 47} }, symbol = { "1" },
					tooltiptxt = "Boss\nYsondre", special = AM_WANDERS, leaveGap = 1 },
			dtl3 = { text = "Emeriss", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DEmeriss" },
			dtl4 = { text = "Lethon", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DLethon" },
			dtl5 = { text = "Taerar", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DTaerar" },
			dtl6 = { text = "Ysondre", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DYsondre" },
		},

		{	name = "Four Dragons: Hinterlands",			-- Four Dragons
			type = AM_TYP_RAID,
			displayname = "Four Dragons: Hinterlands",
			filename = "AM_Dragon_Hinterlands_Map",
			location = "Hinterlands : Seradane (46, 36)",
			minimapZoom = 2,
			minimapXOffset = 0,
			minimapYOffset = 0,
			area = "Hinterlands",
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "Wandering trios of level 62 & 61 Elites",
			wmData = { minX = 0.561, maxX = .697, minY = 0.159, maxY = 0.362 },
			amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
			dtl1 = { text = "Approach", colour = AM_GREEN, coords = { {37, 98} }, symbol = { AM_ENTRANCE },
					tooltiptxt = "", leaveGap = 1 },
			dtl2 = { text = "Rothos", colour = AM_RED, coords = { {52.5, 59} }, symbol = { "1" },
					tooltiptxt = "Lvl62 Elite Dragonkin", special = AM_WANDERS },
			dtl3 = { text = "Dreamtracker", colour = AM_RED, coords = { {51, 49} }, symbol = { "2" },
					tooltiptxt = "Lvl62 Elite Dragonkin" },
			dtl4 = { text = "Emerald Gate", colour = AM_GREEN, coords = { {46, 39} }, symbol = { "3" },
					tooltiptxt = "Boss\nTaerar", leaveGap = 1 },
			dtl5 = { text = "Emeriss", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DEmeriss" },
			dtl6 = { text = "Lethon", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DLethon" },
			dtl7 = { text = "Taerar", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DTaerar" },
			dtl8 = { text = "Ysondre", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DYsondre" },
		},

		{	name = "Four Dragons: Feralas",			-- Four Dragons
			type = AM_TYP_RAID,
			displayname = "Four Dragons: Feralas",
			filename = "AM_Dragon_Feralas_Map",
			location = "Feralas : Dream Bough (51, 9)",	-- Jademir Lake
			minimapZoom = 2,
			minimapXOffset = 0,
			minimapYOffset = 0,
			area = "Feralas",
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "Wandering trios of level 62 & 61 Elites",
			wmData = { minX = 0.47695, maxX = .55113, minY = 0.04585, maxY = 0.15963 },
			amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
			dtl1 = { text = "Dreamroarer", colour = AM_RED, coords = { {36, 63} }, symbol = { "1" },
					tooltiptxt = "Lvl62 Elite Dragonkin\nPatrols round Island", special = AM_WANDERS },
			dtl2 = { text = "Lethlas", colour = AM_RED, coords = { {46, 68} }, symbol = { "2" },
					tooltiptxt = "Lvl62 Elite Dragonkin\nPatrols round Island", special = AM_WANDERS },
			dtl3 = { text = "Emerald Gate", colour = AM_GREEN, coords = { {45, 57} }, symbol = { "3" },
					tooltiptxt = "Boss\nEmeriss", leaveGap = 1 },
			dtl4 = { text = "Emeriss", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DEmeriss" },
			dtl5 = { text = "Lethon", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DLethon" },
			dtl6 = { text = "Taerar", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DTaerar" },
			dtl7 = { text = "Ysondre", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DYsondre" },
		},

		{	name = "Four Dragons: Ashenvale",		-- Four Dragons
			type = AM_TYP_RAID,
			displayname = "Four Dragons: Ashenvale",
			filename = "AM_Dragon_Ashenvale_Map",
			location = "Ashenvale : Bough Shadow (93, 36)",
			minimapZoom = 2,
			minimapXOffset = 0,
			minimapYOffset = 0,
			area = "Ashenvale",
			levels = "60",
			players = AM_NO_LIMIT,
			prereq = "",
			general = "Wandering trios of level 62 & 61 Elites",
			wmData = { minX = 0.895, maxX = .984, minY = 0.299, maxY = 0.4286 },
			amData = { minX = 0.005, maxX = .995, minY = 0.005, maxY = 0.995 },
			dtl1 = { text = "Phantim", colour = AM_RED, coords = { {57, 75} }, symbol = { "1" },
					tooltiptxt = "Lvl62 Elite Dragonkin", special = AM_WANDERS },
			dtl2 = { text = "Dreamstalker", colour = AM_RED, coords = { {50.4, 57} }, symbol = { "2" },
					tooltiptxt = "Lvl62 Elite Dragonkin" },
			dtl3 = { text = "Emerald Gate", colour = AM_GREEN, coords = { {50.8, 48} }, symbol = { "3" },
					tooltiptxt = "Boss\nLethon", leaveGap = 1 },
			dtl4 = { text = "Emeriss", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DEmeriss" },
			dtl5 = { text = "Lethon", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DLethon" },
			dtl6 = { text = "Taerar", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DTaerar" },
			dtl7 = { text = "Ysondre", colour = AM_RED, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "DYsondre" },
		},

		{	name = "Maraudon",			-- Maraudon
			type = AM_TYP_INSTANCE,
			displayname = "Maraudon",
			filename = "Maraudon",
			location = "Desolace (29, 62)",
			levels = "40-49",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = "Entrance (Orange)", colour = AM_ORANGE, coords = { {71, 12} }, symbol = { "X1" },
					tooltiptxt = "", toMap = "Maraudon"..AM_EXTERIOR },
			dtl2  = { text = "Entrance (Purple)", colour = AM_PURPLE, coords = { {85, 31} }, symbol = { "X2" },
					tooltiptxt = "", toMap = "Maraudon"..AM_EXTERIOR },
			dtl3  = { text = "Entrance (Portal)", colour = AM_GREEN, coords = { {36, 55} }, symbol = { "P" },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {64, 44}, {39, 31} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl5  = { text = "Veng (Fifth Khan)", colour = AM_RED, coords = { {59, 6} }, symbol = { "1" },
					tooltiptxt = "", special = AM_WANDERS  },
			dtl6  = { text = "Noxxion", colour = AM_RED, coords = { {51, 3} }, symbol = { "2" },
					tooltiptxt = "Lvl48 Elite Elemental", lootid = "MaraNoxxion"  },
			dtl7  = { text = "Razorlash", colour = AM_RED, coords = { {36, 14} }, symbol = { "3" },
					tooltiptxt = "Lvl47 Elite Beast", lootid = "MaraRazorlash"  },
			dtl8  = { text = "Maraudos (Fourth Khan)", colour = AM_RED, coords = { {64, 27} }, symbol = { "4" },
					tooltiptxt = ""  },
			dtl9  = { text = "Lord Vyletongue", colour = AM_RED, coords = { {53.3, 32} }, symbol = { "5" },
					tooltiptxt = "Lvl47 Elite Humanoid", lootid = "MaraLordVyletongue"  },
			dtl10 = { text = "Meshlok the Harvester", colour = AM_RED, coords = { {43, 30} }, symbol = { "6" },
					tooltiptxt = "", special = AM_RARE, lootid = "MaraMeshlok"  },
			dtl11 = { text = "Celebras the Cursed", colour = AM_RED, coords = { {31, 35} }, symbol = { "7" },
					tooltiptxt = "Lvl49 Elite Humanoid", lootid = "MaraCelebras"  },
			dtl12 = { text = "Landslide", colour = AM_RED, coords = { {51.3, 60} }, symbol = { "8" },
					tooltiptxt = "Lvl50 Elite Elemental", lootid = "MaraLandslide"  },
			dtl13 = { text = "Tinkerer Gizlock", colour = AM_RED, coords = { {61, 74} }, symbol = { "9" },
					tooltiptxt = "Lvl50 Elite Humanoid", lootid = "MaraTinkererGizlock"  },
			dtl14 = { text = "Rotgrip", colour = AM_RED, coords = { {45, 82} }, symbol = { "10" },
					tooltiptxt = "Lvl50 Elite Beast", lootid = "MaraRotgrip"  },
			dtl15 = { text = "Princess Theradras", colour = AM_RED, coords = { {32, 85} }, symbol = { "11" },
					tooltiptxt = "Lvl51 Elite Elemental", lootid = "MaraPrincessTheradras" },
			dtl16 = { text = "Zaetar's Spirit", colour = AM_RED, coords = { {32, 85} }, symbol = { " " },
					tooltiptxt = "", leaveGap = 1 }
		},

		{	name = "Maraudon"..AM_EXTERIOR,		-- Maraudon Exterior
			type = AM_TYP_RAID,
			displayname = AM_EXTERIOR.." - Maraudon",
			displayshort = "",
			filename = "MaraudonExt",
			location = "Desolace (29, 62)",
			levels = "40-49",
			players = "",
			prereq = "",
			general = "",
			area = "Kalimdor",
			wmData = { minX = 0.3807325, maxX = 0.393785, minY =  0.5679875, maxY = 0.58772 },
			amData = { minX = 0.02, maxX = 0.92, minY = 0.01, maxY = 0.98 },
			dtl1  = { text = "Entrance", colour = AM_GREEN, coords = { {23, 59}  }, symbol = { "X" },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "First Khan", colour = AM_RED, coords = { {31, 45} }, symbol = { "1" },
					tooltiptxt = "" },
			dtl3  = { text = "Second Khan", colour = AM_RED, coords = { {24, 29} }, symbol = { "2" },
					tooltiptxt = "Mid level between pools" },
			dtl4  = { text = "Third Khan", colour = AM_RED, coords = { {80, 46} }, symbol = { "3" },
					tooltiptxt = "" },
			dtl5  = { text = "Cavindra", colour = AM_GREEN, coords = { {48, 64} }, symbol = { "4" },
					tooltiptxt = "Quest Giver", leaveGap = 1 },
			dtl6  = { text = "Maraudon Portal", colour = AM_BLUE, coords = { {24, 47} }, symbol = { "P" },
					tooltiptxt = "Requires Scepter of Celebras" },
			dtl7  = { text = "Maraudon (Orange)", colour = AM_ORANGE, coords = { {84, 71} }, symbol = { "X1" },
					tooltiptxt = "Click to Open Maraudon Instance Map", toMap = "Maraudon" },
			dtl8  = { text = "Maraudon (Purple)", colour = AM_PURPLE, coords = { {39, 12.4} }, symbol = { "X2" },
					tooltiptxt = "Click to Open Maraudon Instance Map", toMap = "Maraudon" }
		},


		{	name = "Molten Core",			-- Molten Core
			type = AM_TYP_INSTANCE,
			displayname = "Molten Core",
			displayshort = "MC",
			filename = "MoltenCore",
			location = "Blackrock Depths",
			levels = "60+",
			players = "40",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 20} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", toMap = "Blackrock Depths", leaveGap = 1 },
			dtl2  = { text = "Lucifron", colour = AM_RED, coords = { {62, 35} }, symbol = { "1" },
					tooltiptxt = "Boss Humanoid", lootid = "MCLucifron" },
			dtl3  = { text = "Magmadar", colour = AM_RED, coords = { {70, 16} }, symbol = { "2" },
					tooltiptxt = "Boss Beast", lootid = "MCMagmadar" },
			dtl4  = { text = "Gehennas", colour = AM_RED, coords = { {13, 46} }, symbol = { "3" },
					tooltiptxt = "Boss Humanoid", lootid = "MCGehennas" },
			dtl5  = { text = "Garr", colour = AM_RED, coords = { {8, 71} }, symbol = { "4" },
					tooltiptxt = "Boss Elemental", lootid = "MCGarr"  },
			dtl6  = { text = "Shazzrah", colour = AM_RED, coords = { {44, 80} }, symbol = { "5" },
					tooltiptxt = "Boss Humanoid", lootid = "MCShazzrah"  },
			dtl7  = { text = "Baron Geddon", colour = AM_RED, coords = { {53, 68} }, symbol = { "6" },
					tooltiptxt = "Boss Elemental", lootid = "MCGeddon"  },
			dtl8  = { text = "Golemagg the Incinerator", colour = AM_RED, coords = { {66, 57} }, symbol = { "7" },
					tooltiptxt = "Boss Giant", lootid = "MCGolemagg"  },
			dtl9  = { text = "Sulfuron Harbinger", colour = AM_RED, coords = { {87, 80} }, symbol = { "8" },
					tooltiptxt = "Boss Humanoid", lootid = "MCSulfuron"  },
			dtl10 = { text = "Majordomo Executus", colour = AM_RED, coords = { {89, 62} }, symbol = { "9" },
					tooltiptxt = "Boss Humanoid", lootid = "MCMajordomo"  },
			dtl11 = { text = "Ragnaros", colour = AM_RED, coords = { {47, 52} }, symbol = { "10" },
					tooltiptxt = "Boss Elemental", lootid = "MCRagnaros", leaveGap = 2  },
			dtl12 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "MCTrashMobs", lootlink = true },
			dtl13 = { text = AM_RBOSS_DROP, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "MCRANDOMBOSSDROPPS", leaveGap = 1 },
			dtl14 = { text = AM_TIER1_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "T1SET", leaveGap = 1 }
		},

		{	name = "Naxxramas",			-- Naxxramas
			type = AM_TYP_INSTANCE,
			displayname = "Naxxramas",
			filename = "Naxxramas",
			location = "Stratholme",
			levels = "60+",
			players = "40",
			prereq = "",
			general = "",
			dtl1  = { text ="Abomination Wing" , colour = AM_BLUE, coords = { {2, 15} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Patchwerk", colour = AM_RED, coords = { {22, 36} }, symbol = { "1" },
					tooltiptxt = "Abomination Wing", lootid = "NAXPatchwerk" },
			dtl3  = { text = "Grobbulus", colour = AM_RED, coords = { {32, 29} }, symbol = { "2" },
					tooltiptxt = "Abomination Wing", lootid = "NAXGrobbulus" },
			dtl4  = { text = "Gluth", colour = AM_RED, coords = { {20, 20} }, symbol = { "3" },
					tooltiptxt = "Abomination Wing", lootid = "NAXGluth" },
			dtl5  = { text = "Thaddius", colour = AM_RED, coords = { {5, 4} }, symbol = { "4" },
					tooltiptxt = "Abomination Wing", lootid = "NAXThaddius", leaveGap = 1  },
			dtl6  = { text = "Spider Wing", colour = AM_BLUE, coords = { {67, 3} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = ""  },
			dtl7  = { text = "Anub'Rekhan", colour = AM_RED, coords = { {45.2, 20} }, symbol = { "1" },
					tooltiptxt = "Spider Wing", lootid = "NAXAnubRekhan"  },
			dtl8  = { text = "Grand Widow Faerlina", colour = AM_RED, coords = { {55, 16} }, symbol = { "2" },
					tooltiptxt = "Spider Wing", lootid = "NAXGrandWidowFaerlina"  },
			dtl9  = { text = "Maexxna", colour = AM_RED, coords = { {74, 5} }, symbol = { "3" },
					tooltiptxt = "Spider Wing", lootid = "NAXMaexxna", leaveGap = 1  },
			dtl10 = { text = "Necro Wing", colour = AM_BLUE, coords = { {79, 56} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = ""  },
			dtl11 = { text = "Noth the Plaguebringer", colour = AM_RED, coords = { {47, 64} }, symbol = { "1" },
					tooltiptxt = "Necro Wing", lootid = "NAXNothderPlaguebringer"  },
			dtl12 = { text = "Helgan the Unclean", colour = AM_RED, coords = { {60, 58} }, symbol = { "2" },
					tooltiptxt = "Necro Wing", lootid = "NAXHeiganderUnclean"  },
			dtl13 = { text = "Loatheb", colour = AM_RED, coords = { {82, 47} }, symbol = { "3" },
					tooltiptxt = "Necro Wing", lootid = "NAXLoatheb", leaveGap = 1  },
			dtl14 = { text = "Deathknight Wing", colour = AM_BLUE, coords = { {15, 79} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = ""  },
			dtl15 = { text = "Instructor Razuvious", colour = AM_RED, coords = { {18, 58} }, symbol = { "1" },
					tooltiptxt = "Deathknight Wing", lootid = "NAXInstructorRazuvious"  },
			dtl16 = { text = "Gothik the Harvester", colour = AM_RED, coords = { {37, 64} }, symbol = { "2" },
					tooltiptxt = "Deathknight Wing", lootid = "NAXGothikderHarvester" },
			dtl17 = { text = "The Four Horsemen", colour = AM_RED, coords = { {8, 75} }, symbol = { "3" },
					tooltiptxt = "Deathknight Wing", lootid = "NAXTheFourHorsemen" },
			dtl18 = { text = "Thane Korth'azz", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
					tooltiptxt = "" },
			dtl19 = { text = "Sir Zeliek", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
					tooltiptxt = "" },
			dtl20 = { text = "Highlord Mograine", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
					tooltiptxt = "" },
			dtl21 = { text = "Lady Blaumeaux", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
					tooltiptxt = "", leaveGap = 1 },
			dtl22 = { text = "Frostwyrm Lair", colour = AM_BLUE, coords = { {74, 93} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "Frostwyrm Lair"  },
			dtl23 = { text = "Sapphiron", colour = AM_RED, coords = { {87, 91} }, symbol = { "1" },
					tooltiptxt = "Frostwyrm Lair", lootid = "NAXSapphiron"  },
			dtl24 = { text = "Kel'Thuzard", colour = AM_RED, coords = { {75, 79} }, symbol = { "2" },
					tooltiptxt = "Frostwyrm Lair", lootid = "NAXKelThuzard", leaveGap = 2  },
			dtl25 = { text = AM_TIER3_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "T3SET", leaveGap = 1 },
			dtl26 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "NAXTrash", leaveGap = 1 }
		},

		{	name = "Onyxia's Lair",				-- Onyxia's Lair
			type = AM_TYP_INSTANCE,
			displayname = "Onyxia's Lair",
			filename = "OnyxiasLair",
			location = "Dustwallow Marsh (52, 76)",
			levels = "60+",
			players = "40",
			prereq = "Requires Drakefire Amulet\n(Complete quest in UBRS to kill General Drakkisath)",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 12} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Onyxian Warders", colour = AM_RED, coords = { {26, 41}, {29, 56}, {39, 68}, {50, 80} }, symbol = { "1" },
					tooltiptxt = "Lvl62 Elite Dragonkin" },
			dtl3  = { text = "Whelp Eggs", colour = AM_RED, coords = { {45, 40}, {51, 54}, {84, 41}, {79, 54} }, symbol = { "2" },
					tooltiptxt = "" },
			dtl4  = { text = "Onyxia", colour = AM_RED, coords = { {66, 27} }, symbol = { "3" },
					tooltiptxt = "Boss Dragonkin", lootid = "Onyxia", leaveGap = 1 }
		},

		{	name = "Ragefire Chasm",			-- Ragefire Chasm
			type = AM_TYP_INSTANCE,
			displayname = "Ragefire Chasm",
			displayshort = "RFC",
			filename = "RagefireChasm",			-- RagefireChasm
			location = "Orgrimmar",
			levels = "13-18",
			players = "10",
			general = "",
			dtl1  = { text = "Entrance", colour = AM_GREEN, coords = { {72, 4} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Maur Grimtotem", colour = AM_GOLD, coords = { {71, 53} }, symbol = { "1" },
					tooltiptxt = "Satchel Quest"  },
			dtl3  = { text = "Taragaman the Hungerer", colour = AM_RED, coords = { {34, 59} }, symbol = { "2" },
					tooltiptxt = "Lvl16 Elite Demon", lootid = "RFCTaragaman" },
			dtl4  = { text = "Jergosh the Invoker", colour = AM_RED, coords = { {24, 86} }, symbol = { "3" },
					tooltiptxt = "Lvl16 Elite Humanoid", lootid = "RFCJergosh" },
			dtl5  = { text = "Bazzalan", colour = AM_RED, coords = { {36, 91} }, symbol = { "4" },
					tooltiptxt = "Lvl16 Elite Demon", leaveGap = 1  }

		},

		{	name = "Razorfen Downs",			-- Razorfen Downs
			type = AM_TYP_INSTANCE,
			displayname = "Razorfen Downs",
			displayshort = "RFD",
			filename = "RazorfenDowns",
			location = "Southern Barrens (48, 88)",
			levels = "38-43",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {4, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {77, 45} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Tuten'kash", colour = AM_RED, coords = { {52, 36} }, symbol = { "1" },
					tooltiptxt = "Lvl40 Elite Undead", lootid = "RFDTutenkash" },
			dtl4  = { text = "Gong to spawn Tuten'kash", colour = AM_GREEN, coords = { {54, 30} }, symbol = { "2" },
					tooltiptxt = "" },
			dtl5  = { text = "Henry Stern,\n& Belnistrasz", colour = AM_BLUE, coords = { {76, 27} }, symbol = { "3" },
					tooltiptxt = "Learn how to make :\nGoldthorn Tea, \nMighty Troll's Blood Potion"  },
			dtl6  = { text = "Mordresh Fire Eye", colour = AM_RED, coords = { {87, 47} }, symbol = { "4" },
					tooltiptxt = "Lvl39 Elite Undead", lootid = "RFDMordreshFireEye"  },
			dtl7  = { text = "Glutton", colour = AM_RED, coords = { {19, 65} }, symbol = { "5" },
					tooltiptxt = "Lvl40 Elite Humanoid", lootid = "RFDGlutton"  },
			dtl8  = { text = "Ragglesnout", colour = AM_RED, coords = { {41, 67} }, symbol = { "6" },
					tooltiptxt = "Lvl40 Elite Humanoid", special = AM_RARE, lootid = "RFDRagglesnout"  },
			dtl9  = { text = "Amnennar the Coldbringer", colour = AM_RED, coords = { {33, 59} }, symbol = { "0" },
					tooltiptxt = "Lvl41 Elite Undead", lootid = "RFDAmnennar", leaveGap = 1 },
			dtl10 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "RFDTrash", leaveGap = 1 }
		},

		{	name = "Razorfen Kraul",			-- Razorfen Kraul
			type = AM_TYP_INSTANCE,
			displayname = "Razorfen Kraul",
			displayshort = "RFK",
			filename = "RazorfenKraul",
			location = "Southern Barrens (42, 86)",
			levels = "28-33",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 71} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Roogug", colour = AM_RED, coords = { {73, 44} }, symbol = { "1" },
					tooltiptxt = "Lvl28 Elite Humanoid" },
			dtl3  = { text = "Aggem Thorncurse", colour = AM_RED, coords = { {88, 48} }, symbol = { "2" },
					tooltiptxt = "Lvl30 Elite Humanoid" },
			dtl4  = { text = "Death Speaker Jargba", colour = AM_RED, coords = { {93, 38} }, symbol = { "3" },
					tooltiptxt = "Lvl30 Elite Humanoid", lootid = "RFKDeathSpeakerJargba" },
			dtl5  = { text = "Overlord Ramtusk", colour = AM_RED, coords = { {60, 29} }, symbol = { "4" },
					tooltiptxt = "Lvl32 Elite Humanoid", lootid = "RFKOverlordRamtusk"  },
			dtl6 = { text = "Earthcaller Halmgar", colour = AM_RED, coords = { {49, 37} }, symbol = { "5" },
					tooltiptxt = "Lvl32 Elite Humanoid", special = AM_RARE, lootid = "RFKEarthcallerHalmgar"  },
			dtl7 = { text = "Willix the Importer,\n& Heralath Fallowbrook", colour = AM_BLUE, coords = { {35, 33} }, symbol = { "6" },
					tooltiptxt = ""  },
			dtl8  = { text = "Charlga Razorflank", colour = AM_RED, coords = { {21, 33} }, symbol = { "7" },
					tooltiptxt = "Lvl33 Elite Humanoid", lootid = "RFKCharlgaRazorflank"  },
			dtl9  = { text = "Blind Hunter", colour = AM_RED, coords = { {6, 32} }, symbol = { "8" },
					tooltiptxt = "Lvl32 Elite Beast\n& Chest", special = AM_RARE, lootid = "RFKBlindHunter"  },
			dtl10  = { text = "Ward Sealing Agathelos", colour = AM_GREEN, coords = { {4, 54} }, symbol = { "9" },
					tooltiptxt = ""  },
			dtl11  = { text = "Agathelos the Raging", colour = AM_RED, coords = { {11, 65} }, symbol = { "10" },
					tooltiptxt = "Lvl33 Elite Beast", lootid = "RFKAgathelos", leaveGap = 1  },
			dtl12 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "RFKTrash", leaveGap = 1 }
		},

		{	name = "Ruins of Ahn'Qiraj",		-- Ruins of Ahn'Qiraj
			type = AM_TYP_INSTANCE,
			displayname = "Ruins of Ahn'Qiraj",
			displayshort = "AQ20",
			filename = "RuinsofAhnQiraj",		-- RuinsofAhnQiraj
			location = "Silithus (29, 96)",
			levels = "60+",
			players = "20",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {64, 2} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Kurinnaxx", colour = AM_RED, coords = { {55, 29} }, symbol = { "1" },
					tooltiptxt = "Boss & Elites", lootid = "AQ20Kurinnaxx" },
			dtl3  = { text ="Lieutenant General Andorov,\n&Four Kaldorei Elites", colour = AM_RED, coords = { {55, 29} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ20Andorov" },
			dtl4  = { text = "Captain Qeez", colour = AM_RED, coords = { {52.1, 46.9} }, symbol = { "2" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN" },
			dtl5  = { text = "Captain Tuubid", colour = AM_RED, coords = { {55.4, 46.9} }, symbol = { "3" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN" },
			dtl6  = { text = "Captain Drenn", colour = AM_RED, coords = { {57.2, 47.9} }, symbol = { "4" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
			dtl7  = { text = "Captain Xurrem", colour = AM_RED, coords = { {59.2, 49.2} }, symbol = { "5" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
			dtl8  = { text = "Major Yeggeth", colour = AM_RED, coords = { {61.3, 50.3} }, symbol = { "6" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
			dtl9  = { text = "Major Pakkong", colour = AM_RED, coords = { {60, 53.4} }, symbol = { "7" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
			dtl10  = { text = "Colonel Zerran", colour = AM_RED, coords = { {56, 51.2} }, symbol = { "8" },
					tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
			dtl11 = { text = "General Rajaxx", colour = AM_RED, coords = { {52.2, 49.5} }, symbol = { "9" },
					tooltiptxt = "Boss", lootid = "AQ20Rajaxx"  },
			dtl12 = { text = "Moam", colour = AM_RED, coords = { {13, 31} }, symbol = { "10" },
					tooltiptxt = "Boss", lootid = "AQ20Moam"  },
			dtl13 = { text = "Buru the Gorger", colour = AM_RED, coords = { {83, 55} }, symbol = { "11" },
					tooltiptxt = "Boss", lootid = "AQ20Buru"  },
			dtl14 = { text = "Safe Room", colour = AM_GREEN, coords = { {65, 70} }, symbol = { "12" },
					tooltiptxt = ""  },
			dtl15 = { text = "Ayamiss the Hunter", colour = AM_RED, coords = { {67, 91} }, symbol = { "13" },
					tooltiptxt = "Boss", lootid = "AQ20Ayamiss"  },
			dtl16 = { text = "Ossirian the Unscarred", colour = AM_RED, coords = { {29, 73} }, symbol = { "14" },
					tooltiptxt = "Boss", lootid = "AQ20Ossirian", leaveGap = 2  },
			dtl17 = { text = "Class Books", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ20ClassBooks" },
			dtl18 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQEnchants" },
			dtl19 = { text = "AQ20"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ20SET", leaveGap = 1 }
		},

		{	name = "Scarlet Monastery",			-- Scarlet Monastery
			type = AM_TYP_INSTANCE,
			displayname = "Scarlet Monastery",
			displayshort = "SM",
			filename = "ScarletMonastery",
			location = "Tirisfal Glades (83.6, 34)",
			levels = "30-40",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = "Graveyard Entrance", colour = AM_GREEN, coords = { {61, 97} }, symbol = { "G" },
					tooltiptxt = "" },
			dtl2  = { text = "Ironspine", colour = AM_RED, coords = { {21, 88} }, symbol = { "1" },
					tooltiptxt = "Lvl33 Elite Undead\nGraveyard", special = AM_RARE, lootid = "SMIronspine"  },
			dtl3  = { text = "Azshir the Sleepless", colour = AM_RED, coords = { {5, 88} }, symbol = { "2" },
					tooltiptxt = "Lvl33 Elite Undead\nGraveyard", special = AM_RARE, lootid = "SMAzshir"  },
			dtl4  = { text = "Fallen Champion", colour = AM_RED, coords = { {8, 80} }, symbol = { "3" },
					tooltiptxt = "Lvl33 Elite Undead\nGraveyard", special = AM_RARE, lootid = "SMFallenChampion" },
			dtl5  = { text = "Bloodmage Thalnos", colour = AM_RED, coords = { {5, 77} }, symbol = { "4" },
					tooltiptxt = "Lvl34 Elite Undead\nGraveyard", lootid = "SMBloodmageThalnos" },
			dtl6  = { text = "Library Entrance", colour = AM_GREEN, coords = { {56, 74} }, symbol = { "L" },
					tooltiptxt = "" },
			dtl7  = { text = "Houndmaster Loksey", colour = AM_RED, coords = { {66.1, 95} }, symbol = { "5" },
					tooltiptxt = "Lvl34 Elite Humanoid\nLibrary", lootid = "SMHoundmasterLoksey"  },
			dtl8  = { text = "Arcanist Doan", colour = AM_RED, coords = { {95.1, 92} }, symbol = { "6" },
					tooltiptxt = "Lvl37 Elite Humanoid\nLibrary", lootid = "SMDoan", leaveGap = 1  },
			dtl9  = { text = "Armoury Entrance", colour = AM_GREEN, coords = { {54, 65} }, symbol = { "A" },
					tooltiptxt = "" },
			dtl10 = { text = "Herod", colour = AM_RED, coords = { {74.8, 6.2} }, symbol = { "7" },
					tooltiptxt = "Lvl40 Elite Humanoid\nArmoury", lootid = "SMHerod", leaveGap = 1  },
			dtl11 = { text = "Cathedral Entrance", colour = AM_GREEN, coords = { {37, 65} }, symbol = { "C" },
					tooltiptxt = "" },
			dtl12 = { text = "High Inquisitor Fairbanks", colour = AM_RED, coords = { {31, 11} }, symbol = { "8" },
					tooltiptxt = "Lvl40 Elite Humanoid\nCathedral", lootid = "SMFairbanks"  },
			dtl13 = { text = "Scarlet Commander Mograine", colour = AM_RED, coords = { {23.4, 12} }, symbol = { "9" },
					tooltiptxt = "Lvl42 Elite Humanoid\nCathedral", lootid = "SMMograine"  },
			dtl14 = { text = "High Inquisitor Whitemane", colour = AM_RED, coords = { {23.4, 4.4} }, symbol = { "10" },
					tooltiptxt = "Lvl42 Elite Humanoid\nCathedral", lootid = "SMWhitemane", leaveGap = 2  },
			dtl15 = { text = "Set : Chain of the Scarlet Crusade", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "6 Piece", lootid = "SMScarletSET", leaveGap = 1 },
			dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "SMTrash", leaveGap = 1 }
		},

		{	name = "Ahn'Qiraj",			-- Ahn'Qiraj
			type = AM_TYP_INSTANCE,
			displayname = "Temple of Ahn'Qiraj",
			displayshort = "AQ40",
			filename = "TempleofAhnQiraj",		-- TempleofAhnQiraj
			location = "Silithus (29, 96)",
			levels = "60+",
			players = "40",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {16, 37} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Arygos\n& Caelestrasz\n& Merithra of the Dream", colour = AM_BLUE, coords = { {21, 56} }, symbol = { "A" },
					tooltiptxt = ""  },
			dtl3  = { text = "Andorgos\n& Vethsera\n& Kandrostrasz", colour = AM_BLUE, coords = { {27, 43} }, symbol = { "B" },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "The Prophet Skeram", colour = AM_RED, coords = { {19, 41} }, symbol = { "1" },
					tooltiptxt = "Boss\nOutside", lootid = "AQ40Skeram" },
			dtl5  = { text = "Vem & Co", colour = AM_RED, coords = { {15, 52} }, symbol = { "2" },
					tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Vem" },
			dtl6  = { text = "Battleguard Sartura", colour = AM_RED, coords = { {40, 30} }, symbol = { "3" },
					tooltiptxt = "Boss", lootid = "AQ40Sartura" },
			dtl7  = { text = "Fankriss the Unyielding", colour = AM_RED, coords = { {67, 14} }, symbol = { "4" },
					tooltiptxt = "Boss", lootid = "AQ40Fankriss"  },
			dtl8  = { text = "Viscidus", colour = AM_RED, coords = { {82, 7} }, symbol = { "5" },
					tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Viscidus"  },
			dtl9  = { text = "Princess Huhuran", colour = AM_RED, coords = { {41, 49} }, symbol = { "6" },
					tooltiptxt = "Boss", lootid = "AQ40Huhuran"  },
			dtl10 = { text = "Twin Emperors", colour = AM_RED, coords = { {72, 67} }, symbol = { "7" },
					tooltiptxt = "Boss", lootid = "AQ40Emperors"  },
			dtl11 = { text = "Ouro", colour = AM_RED, coords = { { 22, 87 } }, symbol = { "8" },
					tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Ouro" },
			dtl12 = { text = "Eye of C'Thun", colour = AM_RED, coords = { {25, 50} }, symbol = { "9" },
					tooltiptxt = "", lootid = "AQ40CThun" },
			dtl13 = { text = "C'Thun", colour = AM_RED, coords = { {25, 50} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ40CThun", leaveGap = 2 },
			dtl14 = { text = AM_MOB_LOOT, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ40Trash", leaveGap = 1 },
			dtl15 = { text = "AQ40 "..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQ40SET", leaveGap = 1 },
			dtl16 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "AQEnchants", leaveGap = 1 },
			dtl17 = { text = "AQ Brood Rings", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQBroodRings", leaveGap = 1 },
			dtl18 = { text = AM_OPENING, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "AQOpening", leaveGap = 1 }
		},

		{	name = "The Deadmines",			-- The Deadmines
			type = AM_TYP_INSTANCE,
			displayname = "The Deadmines",
			filename = "TheDeadmines",
			location = "Westfall (42, 72)",
			levels = "16-26",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {99, 42} }, symbol = { AM_EXIT_SYMBOL },
					tooltiptxt = "" },
			dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {80, 40} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "Rhahk'Zor", colour = AM_RED, coords = { {21, 58} }, symbol = { "1" },
					tooltiptxt = "Lvl19 Elite Humanoid", lootid = "VCRhahkZor" },
			dtl5  = { text = "Miner Johnson", colour = AM_RED, coords = { {41, 50} }, symbol = { "2" },
					tooltiptxt = "Lvl19 Elite Humanoid", lootid = "VCMinerJohnson", special = AM_RARE  },
			dtl6  = { text = "Sneed", colour = AM_RED, coords = { {37, 77} }, symbol = { "3" },
					tooltiptxt = "Lvl20 Elite Mechanical (in Shredder)", lootid = "VCSneed"  },
			dtl7  = { text = "Gilnid", colour = AM_RED, coords = { {48.8, 60.2} }, symbol = { "4" },
					tooltiptxt = "Lvl20 Elite Humanoid", lootid = "VCGilnid"  },
			dtl8  = { text = "Defias Gunpowder", colour = AM_GREEN, coords = { {55.6, 39} }, symbol = { "5" },
					tooltiptxt = "...Blast Powder to blow the doors"  },
			dtl9  = { text = "Mr. Smite", colour = AM_RED, coords = { {76, 31} }, symbol = { "6" },
					tooltiptxt = "Lvl20 Elite Humanoid", lootid = "VCMrSmite"  },
			dtl10 = { text = "Cookie", colour = AM_RED, coords = { {81, 36} }, symbol = { "7" },
					tooltiptxt = "", lootid = "VCCookie"  },
			dtl11 = { text = "Captain Greenskin", colour = AM_RED, coords = { {76, 37} }, symbol = { "8" },
					tooltiptxt = "Lvl21 Elite Humanoid", lootid = "VCCaptainGreenskin"  },
			dtl12 = { text = "Edwin VanCleef", colour = AM_RED, coords = { {79, 37} }, symbol = { "9" },
					tooltiptxt = "Lvl21 Elite Humanoid", lootid = "VCVanCleef", leaveGap = 2 },
			dtl13 = { text = "Set : Defias Leather", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "VCDefiasSET", leaveGap = 1 }
		},

		{	name = "The Stockade",			-- The Stockade
			type = AM_TYP_INSTANCE,
			displayname = "The Stockade",
			filename = "TheStockade",
			location = "Stormwind City",
			levels = "24-32",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {50, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {69, 60}, {75, 40}, {26, 57}, {31, 36}, {18, 29} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Targorr the Dread", colour = AM_RED, coords = { {58, 63}, {41, 55}, {50, 37}, {27, 50} }, symbol = { "1" },
					tooltiptxt = "Lvl24 Elite Humanoid", special = AM_VARIES },
			dtl4  = { text = "Kam Deepfury", colour = AM_RED, coords = { {73, 43} }, symbol = { "2" },
					tooltiptxt = "Lvl27 Elite Humanoid", lootid = "SWStKamDeepfury" },
			dtl5  = { text = "Hamhock", colour = AM_RED, coords = { {85, 56} }, symbol = { "3" },
					tooltiptxt = "Lvl28 Elite Humanoid"  },
			dtl6  = { text = "Bazil Thredd", colour = AM_RED, coords = { {95, 62} }, symbol = { "4" },
					tooltiptxt = ""  },
			dtl7  = { text = "Dextren Ward", colour = AM_RED, coords = { {15, 40} }, symbol = { "5" },
					tooltiptxt = "Lvl26 Elite Humanoid"  },
			dtl8  = { text = "Bruegal Ironknuckle", colour = AM_RED, coords = { {22, 54} }, symbol = { "6" },
					tooltiptxt = "Lvl26 Elite Humanoid", special = AM_RARE, lootid = "SWStBruegalIronknuckle", leaveGap = 1 }
		},

		{	name = "The Temple of Atal'Hakkar",			-- The Sunken Temple
			type = AM_TYP_INSTANCE,
			displayname = "Sunken Temple",
			displayshort = "ST",
			filename = "TheSunkenTemple",
			location = "Swamp of Sorrows (70, 53)",
			levels = "45-60",
			players = "10",
			prereq = "",
			general = "Also called Temple of Atal'Hakkar",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {62, 7} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Stairs at Entrance to Lower", colour = AM_GREEN, coords = { {54, 11.3}, {13.9, 47} }, symbol = { "SL" },
					tooltiptxt = "" },
			dtl3  = { text = "Stairs at Entrance to Mid", colour = AM_GREEN, coords = { {69, 11.3} }, symbol = { "SM" },
					tooltiptxt = "", leaveGap = 1 },
			dtl4  = { text = "Stairs reaching Upper levels", colour = AM_BLUE, coords = { {52, 18}, {69, 18}, {52, 48}, {69, 48} }, symbol = { AM_STAIRS_SYMBOL },
					tooltiptxt = "" },
			dtl5  = { text = "Troll Minibosses (Upper level)", colour = AM_RED, coords = { {55, 23}, {66, 23}, {72, 33}, {49, 33}, {54, 43}, {66, 43} }, symbol = { "T1", "T2", "T3", "T4", "T5", "T6" },
					tooltiptxt = "Kill all, then Jammal'an\nto fight Eranikus", lootid = "STTrollMinibosses", leaveGap = 1 },
			dtl6  = { text = "Statues (Lower level)", colour = AM_ORANGE, coords = { {22, 82}, {22, 64}, {13, 77}, {30, 77}, {13, 68}, {30, 68} }, symbol = { "S1", "S2", "S3", "S4", "S5", "S6" },
					tooltiptxt = "Activate in numerical order to\nsummon Atal'alarion" },
			dtl7  = { text = "Altar of Hakkar", colour = AM_ORANGE, coords = { {22, 74} }, symbol = { "1" },
					tooltiptxt = ""  },
			dtl8  = { text = "Atal'alarion", colour = AM_RED, coords = { {22, 71} }, symbol = { "2" },
					tooltiptxt = "Lvl50 Elite Humanoid", lootid = "STAtalalarion", leaveGap = 1  },
			dtl9  = { text = "Dreamscythe", colour = AM_RED, coords = { {58, 33} }, symbol = { "3" },
					tooltiptxt = "Lvl53 Elite Dragonkin", lootid = "STDreamscythe"  },
			dtl10 = { text = "Weaver", colour = AM_RED, coords = { {62, 33} }, symbol = { "4" },
					tooltiptxt = "Lvl51 Elite Dragonkin", lootid = "STWeaver"  },
			dtl11 = { text = "Avatar of Hakkar", colour = AM_RED, coords = { {32, 33} }, symbol = { "5" },
					tooltiptxt = "Lvl50 Elite Dragon", lootid = "STAvatarofHakkar"  },
			dtl12 = { text = "Jammal'an the Prophet", colour = AM_RED, coords = { {88, 27} }, symbol = { "6" },
					tooltiptxt = "Lvl54 Elite Humanoid", lootid = "STJammalan"  },
			dtl13 = { text = "Ogom the Wretched", colour = AM_RED, coords = { {88, 31} }, symbol = { "7" },
					tooltiptxt = "Lvl53 Elite Undead", lootid = "STOgom"  },
			dtl14 = { text = "Morphaz", colour = AM_RED, coords = { {59, 62} }, symbol = { "8" },
					tooltiptxt = "Lvl52 Elite Dragon", lootid = "STMorphaz"  },
			dtl15 = { text = "Hazzas", colour = AM_RED, coords = { {62, 62} }, symbol = { "9" },
					tooltiptxt = "Lvl53 Elite Dragon", lootid = "STHazzas"  },
			dtl16 = { text = "Shade of Eranikus", colour = AM_RED, coords = { {80, 62} }, symbol = { "10" },
					tooltiptxt = "Lvl55 Elite Dragon", lootid = "STEranikus"  },
			dtl17 = { text = "Essence Font", colour = AM_ORANGE, coords = { {85, 57} }, symbol = { "11" },
					tooltiptxt = "", leaveGap = 1 },
			dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "STTrash", leaveGap = 1 }
		},

		{	name = "Uldaman",			-- Uldaman
			type = AM_TYP_INSTANCE,
			displayname = "Uldaman",
			filename = "Uldaman",
			location = "The Badlands (44, 12)",
			levels = "35-50",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = "Front Entrance", colour = AM_GREEN, coords = { {89, 73.1} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "Click to open Uldaman Exterior Map", toMap = "Uldaman"..AM_EXTERIOR },
			dtl2  = { text = "Rear Entrance", colour = AM_GREEN, coords = { {21, 71} }, symbol = { "XR" },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Baelog", colour = AM_RED, coords = { {73, 93} }, symbol = { "1" },
					tooltiptxt = "Lvl41 Elite" },
			dtl4  = { text = "Remains of a Paladin", colour = AM_ORANGE, coords = { {62.8, 63.2} }, symbol = { "2" },
					tooltiptxt = "" },
			dtl5  = { text = "Revelosh", colour = AM_RED, coords = { {64, 73.3} }, symbol = { "3" },
					tooltiptxt = "Lvl40 Elite Humanoid", lootid = "UldRevelosh"  },
			dtl6  = { text = "Ironaya", colour = AM_RED, coords = { {38, 75} }, symbol = { "4" },
					tooltiptxt = "Boss Giant", lootid = "UldIronaya"  },
			dtl7  = { text = "Annora (Master Enchanter)", colour = AM_BLUE, coords = { {56, 61} }, symbol = { "5" },
					tooltiptxt = ""  },
			dtl8  = { text = "Obsidian Sentinel", colour = AM_RED, coords = { {24.4, 62} }, symbol = { "6" },
					tooltiptxt = "Lvl42 Elite Mechanical"  },
			dtl9  = { text = "Ancient Stone Keeper", colour = AM_RED, coords = { {54.7, 43} }, symbol = { "7" },
					tooltiptxt = "Lvl44 Elite Elemental", lootid = "UldAncientStoneKeeper"  },
			dtl10 = { text = "Galgann Firehammer", colour = AM_RED, coords = { {21, 31} }, symbol = { "8" },
					tooltiptxt = "Boss Humanoid", lootid = "UldGalgannFirehammer"  },
			dtl11 = { text = "Grimlok", colour = AM_RED, coords = { {17, 19} }, symbol = { "9" },
					tooltiptxt = "Lvl45 Elite Humanoid", lootid = "UldGrimlok"  },
			dtl12 = { text = "Archaedas", colour = AM_RED, coords = { {45.2, 14.4} }, symbol = { "10" },
					tooltiptxt = "Boss Giant\nLower level", lootid = "UldArchaedas"  },
			dtl13 = { text = "The Discs of Norgannon", colour = AM_ORANGE, coords = { {39.7, 6.2} }, symbol = { "11" },
					tooltiptxt = "Upper level"  },
			dtl14 = { text = "Ancient Treasure", colour = AM_ORANGE, coords = { {42.3, 4.9} }, symbol = { "12" },
					tooltiptxt = "Lower level", leaveGap = 1 },
			dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "UldTrash", leaveGap = 1 }
		},

		{	name = "Uldaman"..AM_EXTERIOR,		-- Uldaman Exterior
			type = AM_TYP_RAID,
			displayname = AM_EXTERIOR.." - Uldaman",
			filename = "UldamanExt",
			location = "The Badlands (44, 12)",
			levels = "",
			players = "",
			prereq = "",
			general = "",
			area = "Azeroth",
			wmData = { minX = 0.536226, maxX = 0.544795, minY =  0.57594, maxY = 0.586616 },
			amData = { minX = 0.075, maxX = 0.95, minY = 0.20, maxY = 0.935 },
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {95, 33}  }, symbol = { "X" },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_BLUE, coords = { {23, 64}, {33, 88} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "Quest Related", leaveGap = 1 },
			dtl3  = { text = "Uldaman", colour = AM_GREEN, coords = { {30.5, 23} }, symbol = { "U" },
					tooltiptxt = "Click to Open Uldaman Instance Map", toMap = "Uldaman", leaveGap = 1 }
		},

		{ 	name = "Wailing Caverns",			-- Wailing Caverns
			type = AM_TYP_INSTANCE,
			displayname = "Wailing Caverns",
			displayshort = "WC",
			filename = "WailingCaverns",
			location = "The Barrens (46, 36)",
			levels = "16-25",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {44, 58} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", toMap = "Wailing Caverns"..AM_EXTERIOR },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {62, 47}, {94, 49} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Disciple of Naralex", colour = AM_BLUE, coords = { {45, 53} }, symbol = { "1" },
					tooltiptxt = "Triggers Instance Final" },
			dtl4  = { text = "Lord Cobrahn", colour = AM_RED, coords = { {14, 55} }, symbol = { "2" },
					tooltiptxt = "Lvl20 Elite Humanoid", lootid = "WCLordCobrahn" },
			dtl5  = { text = "Lady Anacondra", colour = AM_RED, coords = { {39, 35} }, symbol = { "3" },
					tooltiptxt = "Lvl20 Elite Humanoid", lootid = "WCLadyAnacondra" },
			dtl6  = { text = "Kresh", colour = AM_RED, coords = { {45, 42} }, symbol = { "4" },
					tooltiptxt = "Lvl20 Elite Humanoid", lootid = "WCKresh"  },
			dtl7  = { text = "Deviate Faerie Dragon", colour = AM_RED, coords = { {63, 43} }, symbol = { "5" },
					tooltiptxt = "Lvl20 Elite Dragonkin", lootid = "WCDeviateFaerieDragon", special = AM_RARE },
			dtl8  = { text = "Lord Pythas", colour = AM_RED, coords = { {86, 34} }, symbol = { "6" },
					tooltiptxt = "Lvl22 Elite Humanoid", lootid = "WCLordPythas"  },
			dtl9  = { text = "Skum", colour = AM_RED, coords = { {93, 69} }, symbol = { "7" },
					tooltiptxt = "Lvl21 Elite Humanoid", lootid = "WCSkum"  },
			dtl10  = { text = "Lord Serpentis", colour = AM_RED, coords = { {60, 52} }, symbol = { "8" },
					tooltiptxt = "Lvl22 Elite Humanoid\nUpper level", lootid = "WCLordSerpentis"  },
			dtl11 = { text = "Verdan the Everliving", colour = AM_RED, coords = { {56, 48} }, symbol = { "9" },
					tooltiptxt = "Lvl24 Elite Elemental\nUpper level", lootid = "WCVerdan"  },
			dtl12 = { text = "Mutanus the Devourer", colour = AM_RED, coords = { {29.9, 23.9} }, symbol = { "10" },
					tooltiptxt = "Lvl22 Elite Humanoid\nTriggered Spawn", lootid = "WCMutanus"  },
			dtl13 = { text = "Naralex", colour = AM_RED, coords = { {32.4, 25.4} }, symbol = { "11" },
					tooltiptxt = "Lvl25 Elite Humanoid", leaveGap = 2  },
			dtl14 = { text = "Set : Embrace of the Viper", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "WCViperSET", leaveGap = 1 }
		},

		{	name = "Wailing Caverns"..AM_EXTERIOR,		-- Wailing Caverns Exterior
			type = AM_TYP_RAID,
			displayname = AM_EXTERIOR.." - Wailing Caverns",
			filename = "WailingCavernsExt",
			location = "The Barrens (46, 36)",
			levels = "",
			players = "",
			prereq = "",
			general = "",
			area = "Kalimdor",
			wmData = { minX = 0.5178145, maxX = 0.529001, minY =  0.543372, maxY = 0.555871 },
			amData = { minX = 0.05, maxX = 0.97, minY = 0.15, maxY = 0.80 },
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {14.2, 81.5}  }, symbol = { "X" },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Wailing Caverns", colour = AM_GREEN, coords = { {55.1, 62.2} }, symbol = { "W" },
					tooltiptxt = "Click to Open Wailing Caverns Instance Map", toMap = "Wailing Caverns", leaveGap = 1 }
		},

		{	name = "Zul'Farrak",			-- Zul'Farrak
			type = AM_TYP_INSTANCE,
			displayname = "Zul'Farrak",
			displayshort = "ZF",
			filename = "ZulFarrak",
			location = "Tanaris (37, 15)",
			levels = "43-47",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {69, 89} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl2  = { text = "Zerillis", colour = AM_RED, coords = { {63, 47} }, symbol = { "1" },
					tooltiptxt = "Lvl45 Elite Humanoid", special = AM_RARE.." "..AM_WANDERS, lootid = "ZFZerillis" },
			dtl3  = { text = "Sandarr Dunereaver", colour = AM_RED, coords = { {55, 59} }, symbol = { "2" },
					tooltiptxt = "Lvl45 Elite Humanoid", special = AM_RARE },
			dtl4  = { text = "Hydromancer Velratha", colour = AM_RED, coords = { {34, 43} }, symbol = { "3" },
					tooltiptxt = "Lvl46 Elite Humanoid" },
			dtl5  = { text = "Gahz'rilla", colour = AM_RED, coords = { {37, 46} }, symbol = { "4" },
					tooltiptxt = "Lvl46 Elite Beast", lootid = "ZFGahzrilla"  },
			dtl6  = { text = "Dustwraith", colour = AM_RED, coords = { {32, 46} }, symbol = { "5" },
					tooltiptxt = "Lvl45 Elite Humanoid", special = AM_RARE, lootid = "ZFDustwraith"  },
			dtl7  = { text = "Antu'sul", colour = AM_RED, coords = { {80, 35} }, symbol = { "6" },
					tooltiptxt = "Lvl48 Elite Humanoid", lootid = "ZFAntusul"  },
			dtl8  = { text = "Theka the Martyr", colour = AM_RED, coords = { {67, 33} }, symbol = { "7" },
					tooltiptxt = "Lvl46 Elite Humanoid"  },
			dtl9  = { text = "Witch Doctor Zum'rah", colour = AM_RED, coords = { {53, 23} }, symbol = { "8" },
					tooltiptxt = "Lvl46 Elite Humanoid", lootid = "ZFWitchDoctorZumrah"  },
			dtl10 = { text = "Zul'Farrak Dead Hero", colour = AM_RED, coords = { {51, 27} }, symbol = { "9" },
					tooltiptxt = "Lvl46 Elite Humanoid"  },
			dtl11 = { text = "Shadowpriest Sezz'ziz", colour = AM_RED, coords = { {36, 26} }, symbol = { "10" },
					tooltiptxt = "Lvl47 Elite Humanoid", lootid = "ZFSezzziz" },
			dtl12 = { text = "Nekrum Gutchewer", colour = AM_RED, coords = { {36, 26} }, symbol = { " " },
					tooltiptxt = "Lvl46 Elite Undead"  },
			dtl13 = { text = "Sergeant Bly", colour = AM_ORANGE, coords = { {26, 26} }, symbol = { "11" },
					tooltiptxt = "Divino-matic Rod Quest\nHostile/Friendly depending on\nfaction and actions taken" },
			dtl14 = { text = "Ruuzlu", colour = AM_RED, coords = { {51, 39} }, symbol = { "12" },
					tooltiptxt = "Lvl46 Elite Humanoid"  },
			dtl15 = { text = "Chief Ukorz Sandscalp", colour = AM_RED, coords = { {55, 42} }, symbol = { "13" },
					tooltiptxt = "Lvl48 Elite Humanoid", lootid = "ZFChiefUkorzSandscalp", leaveGap = 1 },
			dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "ZFTrash", leaveGap = 1 }
		},

		{	name = "Zul'Gurub",			-- Zul'Gurub
			type = AM_TYP_INSTANCE,
			displayname = "Zul'Gurub",
			displayshort = "ZG",
			filename = "ZulGurub",
			location = "Stranglethorn Vale (54, 17)",
			levels = "60+",
			players = "20",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 50} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Muddy Churning Waters", colour = AM_BLUE, coords = { {33, 41}, {47, 48}, {57, 47}, {60, 32}, {47, 30} }, symbol = { "W" },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "High Priestess Jeklik", colour = AM_RED, coords = { {34, 78} }, symbol = { "1" },
					tooltiptxt = "Boss Humanoid", special = "(Bat)", lootid = "ZGJeklik" },
			dtl4  = { text = "High Priest Venoxis", colour = AM_RED, coords = { {56, 57} }, symbol = { "2" },
					tooltiptxt = "Boss Humanoid", special = "(Snake)", lootid = "ZGVenoxis" },
			dtl5  = { text = "High Priestess Mar'li", colour = AM_RED, coords = { {48, 85} }, symbol = { "3" },
					tooltiptxt = "Boss Humanoid", special = "(Spider)", lootid = "ZGMarli"  },
			dtl6  = { text = "Bloodlord Mandokir", colour = AM_RED, coords = { {76, 73} }, symbol = { "4" },
					tooltiptxt = "Boss Humanoid", special = "(Raptor)"..AM_OPTIONAL, lootid = "ZGMandokir"  },
			dtl7  = { text = "Edge of Madness", colour = AM_RED, coords = { {72, 47} }, symbol = { "5" },
					tooltiptxt = "", special = AM_OPTIONAL  },
			dtl8  = { text = "Gri'lek, of the Iron Blood", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
					tooltiptxt = "Boss Undead", lootid = "ZGGrilek"  },
			dtl9  = { text = "Hazza'rah, the Dreamweaver", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
					tooltiptxt = "Boss Undead", lootid = "ZGHazzarah"  },
			dtl10 = { text = "Renataki, of the Thousand Blades", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
					tooltiptxt = "Boss Undead", lootid = "ZGRenataki"  },
			dtl11 = { text = "Wushoolay, the Storm Witch", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
					tooltiptxt = "Boss Undead", lootid = "ZGWushoolay"  },
			dtl12 = { text = "Gahz'ranka", colour = AM_RED, coords = { {66, 33} }, symbol = { "6" },
					tooltiptxt = "Boss Humanoid", special = AM_OPTIONAL, lootid = "ZGGahzranka"  },
			dtl13 = { text = "High Priest Thekal", colour = AM_RED, coords = { {80, 32} }, symbol = { "7" },
					tooltiptxt = "Boss Humanoid", special = "(Tiger)", lootid = "ZGThekal" },
			dtl14 = { text = "High Priestess Arlokk", colour = AM_RED, coords = { {49, 16} }, symbol = { "8" },
					tooltiptxt = "Boss Humanoid", special = "(Panther)", lootid = "ZGArlokk"  },
			dtl15 = { text = "Jin'do the Hexxer", colour = AM_RED, coords = { {20, 18} }, symbol = { "9" },
					tooltiptxt = "Boss Humanoid", special = "(Undead)"..AM_OPTIONAL, lootid = "ZGJindo" },
			dtl16 = { text = "Hakkar", colour = AM_RED, coords = { {54, 40} }, symbol = { "10" },
					tooltiptxt = "Boss Dragon", lootid = "ZGHakkar", leaveGap = 2 },
			dtl17 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "ZGTrash", leaveGap = 1 },
			dtl18 = { text = "ZG"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "ZGSET", leaveGap = 1 },
			dtl19 = { text = AM_RBOSS_DROP, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "ZGShared", leaveGap = 1 },
			dtl20 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "ZGEnchants", leaveGap = 1 }
		},

		{	name = "Scholomance",			-- Scholomance
			type = AM_TYP_INSTANCE,
			displayname = "Scholomance",
			filename = "Scholomance",		-- Scholomance*
			location = "Western Plaguelands (69, 73)",
			levels = "56-60",
			players = "5",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {24, 30} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {28, 38} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "" },
			dtl3  = { text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {6.5, 22}, {62, 22} }, symbol = { "S1" },
					tooltiptxt = "" },
			dtl4  = {text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {41, 41}, {34, 80} }, symbol = { "S2" },
					tooltiptxt = "", leaveGap = 1 },
			dtl5  = { text = "Blood Steward of Kirtonos", colour = AM_RED, coords = { {54, 32} }, symbol = { "1" },
					tooltiptxt = "Lvl61 Elite Demon", lootid = "SCHOLOBloodSteward"  },
			dtl6  = { text = "Kirtonos the Herald", colour = AM_RED, coords = { {30, 5} }, symbol = { "2" },
					tooltiptxt = "", lootid = "SCHOLOKirtonostheHerald" },
			dtl7  = { text = "Jandice Barov", colour = AM_RED, coords = { {96, 8.5} }, symbol = { "3" },
					tooltiptxt = "Lvl61 Elite Undead", lootid = "SCHOLOJandiceBarov"  },
			dtl8  = { text = "Rattlegore", colour = AM_RED, coords = { {10, 41} }, symbol = { "4" },
					tooltiptxt = "Lvl61 Elite Undead\nLower level\nDrops key to Viewing Room", lootid = "SCHOLORattlegore"  },
			dtl9  = { text = "Death Knight Darkreaver", colour = AM_RED, coords = { {10, 41} }, symbol = { " " },
					tooltiptxt = "Lvl62 Elite Undead\nPaladins/Shaman Quest to Summon", lootid = "SCHOLODeathKnight" },
			dtl10  = { text = "Marduk Blackpool", colour = AM_BLUE, coords = { {23.7, 42} }, symbol = { "5" },
					tooltiptxt = "Lvl58 Elite\nAggro by placing Dawn's Gambit\nin Viewing room", lootid = "SCHOLOMarduk"  },
			dtl11 = { text = "Vectus", colour = AM_BLUE, coords = { {27.2, 42} }, symbol = { "6" },
					tooltiptxt = "Lvl60 Elite Undead\nAggro by placing Dawn's Gambit\nin Viewing room", lootid = "SCHOLOVectus"  },
			dtl12 = { text = "Ras Frostwhisper", colour = AM_RED, coords = { {18, 87} }, symbol = { "8" },
					tooltiptxt = "Lvl62 Elite Undead", lootid = "SCHOLORasFrostwhisper"  },
			dtl13 = { text = "Kormok", colour = AM_RED, coords = { {18, 80} }, symbol = { "9" },
					tooltiptxt = "Lvl60 Elite", lootid = "SCHOLOKormok" },
			dtl14 = { text = "Instructor Malicia", colour = AM_RED, coords = { {44.5, 94} }, symbol = { "10" },
					tooltiptxt = "Lvl60 Elite Humanoid", lootid = "SCHOLOInstructorMalicia"  },
			dtl15 = { text = "Doctor Theolen Krastinov", colour = AM_RED, coords = { {64, 74.2} }, symbol = { "11" },
					tooltiptxt = "Lvl60 Elite Humanoid", lootid = "SCHOLODoctorTheolenKrastinov"  },
			dtl16 = { text = "Lorekeeper Polkelt", colour = AM_RED, coords = { {44.8, 55.2} }, symbol = { "12" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "SCHOLOLorekeeperPolkelt"  },
			dtl17 = { text = "The Ravenian", colour = AM_RED, coords = { {75.8, 92} }, symbol = { "13" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "SCHOLOTheRavenian"  },
			dtl18 = { text = "Lord Alexei Barov", colour = AM_RED, coords = { {96.2, 74.5} }, symbol = { "14" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "SCHOLOLordAlexeiBarov"  },
			dtl19 = { text = "Lady Illucia Barov", colour = AM_RED, coords = { {75.6, 54} }, symbol = { "15" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "SCHOLOLadyIlluciaBarov" },
			dtl20 = { text = "Darkmaster Gandling", colour = AM_RED, coords = { {76.2, 74.4} }, symbol = { "16" },
					tooltiptxt = "Lvl61 Elite Humanoid", lootid = "SCHOLODarkmasterGandling", leaveGap = 1 },
			dtl21 = { text = "Torch Lever", colour = AM_GREEN, coords = { {89, 19} }, symbol = { "T" },
					tooltiptxt = "" },
			dtl22 = { text = "Alchemy Lab", colour = AM_GREEN, coords = { {14, 70} }, symbol = { "AL" },
					tooltiptxt = "", leaveGap = 1 },
			dtl23 = { text = "Deed to Southshore", colour = AM_ORANGE, coords = { {56, 25} }, symbol = { "D" },
					tooltiptxt = ""  },
			dtl24 = { text = "Deed to Tarren Mill", colour = AM_ORANGE, coords = { {11, 36} }, symbol = { "D" },
					tooltiptxt = ""  },
			dtl25 = { text = "Deed to Brill", colour = AM_ORANGE, coords = { {15, 77} }, symbol = { "D" },
					tooltiptxt = ""  },
			dtl26 = { text = "Deed to Caer Darrow", colour = AM_ORANGE, coords = { {94, 72} }, symbol = { "D" },
					tooltiptxt = "Lvl60 Elite Humanoid", leaveGap = 1},
		},

		{	name = "Stratholme",			-- Stratholme
			type = AM_TYP_INSTANCE,
			displayname = "Stratholme",
			filename = "Stratholme",
			location = "Eastern Plaguelands (30, 12)",
			levels = "55-60",
			players = "5",
			prereq = "",
			general = "Side entrance at EP (47, 24)",
			dtl1  = { text = "Front Entrance", colour = AM_GREEN, coords = { {50, 91} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Side Entrance", colour = AM_GREEN, coords = { {83, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Fras Siabi's Postbox", colour = AM_ORANGE, coords = { {37, 86} }, symbol = { "P1" },
					tooltiptxt = "" },
			dtl4  = { text = "King's Square Postbox", colour = AM_ORANGE, coords = { {47, 74} }, symbol = { "P2" },
					tooltiptxt = "" },
			dtl5  = { text = "Crusader's Postbox", colour = AM_ORANGE, coords = { {24, 66} }, symbol = { "P3" },
					tooltiptxt = "" },
			dtl6  = { text = "Market Row Postbox", colour = AM_ORANGE, coords = { {50, 62} }, symbol = { "P4" },
					tooltiptxt = ""  },
			dtl7  = { text = "Festival Lane Postbox", colour = AM_ORANGE, coords = { {61, 62} }, symbol = { "P5" },
					tooltiptxt = ""  },
			dtl8  = { text = "Elders' Square Postbox", colour = AM_ORANGE, coords = { {80, 68} }, symbol = { "P6" },
					tooltiptxt = "" },
			dtl9 = { text = "Postmaster Malown", colour = AM_RED, coords = { {37, 86}, {47, 74}, {24, 66}, {50, 62}, {61, 62}, {80, 68} }, symbol = { " " },
					tooltiptxt = "Lvl60 Elite Undead\nSpawns on opening of a 3rd Mail box\nMail box keys looted from Courier", leaveGap = 1 },
			dtl10 = { text = "Skul", colour = AM_RED, coords = { {42, 83} }, symbol = { "1" },
					tooltiptxt = "Lvl58 Elite Undead", special = AM_RARE.." "..AM_WANDERS, lootid = "STRATSkull" },
			dtl11 = { text = "Stratholme Courier", colour = AM_RED, coords = { {43, 78} }, symbol = { "2" },
					tooltiptxt = "Lvl57 Elite Undead", lootid = "STRATStratholmeCourier"  },
			dtl12 = { text = "Fras Siabi", colour = AM_RED, coords = { {39, 83} }, symbol = { "3" },
					tooltiptxt = "Lvl61 Elite Undead", lootid = "STRATFrasSiabi"  },
			dtl13 = { text = "Hearthsinger Forresten", colour = AM_RED, coords = { {45, 62}, {65, 58}, {66, 66} }, symbol = { "4" },
					tooltiptxt = "Lvl57 Elite Undead\nWill continue to respawn if any\nGhouls that spawn in his place\nare killed", special = AM_VARIES, lootid = "STRATHearthsingerForresten" },
			dtl14 = { text = "The Unforgiven", colour = AM_RED, coords = { {56, 57} }, symbol = { "5" },
					tooltiptxt = "Lvl57 Elite Undead", lootid = "STRATTheUnforgiven"  },
			dtl15 = { text = "Timmy the Cruel", colour = AM_RED, coords = { {26, 61.5} }, symbol = { "6" },
					tooltiptxt = "Lvl58 Elite Undead", lootid = "STRATTimmytheCruel"  },
			dtl16 = { text = "Cannon Master Willey", colour = AM_RED, coords = { {1, 74} }, symbol = { "7" },
					tooltiptxt = "Lvl60 Elite Humanoid", lootid = "STRATCannonMasterWilley"  },
			dtl17 = { text = "Archivist Galford", colour = AM_RED, coords = { {24, 92} }, symbol = { "8" },
					tooltiptxt = "Lvl60 Elite Humanoid", lootid = "STRATArchivistGalford"  },
			dtl18 = { text = "Balnazzar", colour = AM_RED, coords = { {17, 97} }, symbol = { "9" },
					tooltiptxt = "Lvl62 Elite Demon", lootid = "STRATBalnazzar"  },
			dtl19 = { text = "Sothos", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
					tooltiptxt = "Requires Jarien & Sothos's Brazier of Summoning", lootid = "STRATSothosJarien" },
			dtl20 = { text = "Jarien", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
					tooltiptxt = "Requires Jarien & Sothos's Brazier of Summoning", lootid = "STRATSothosJarien" },
			dtl21 = { text = "Aurius", colour = AM_BLUE, coords = { {81, 61} }, symbol = { "10" },
					tooltiptxt = ""  },
			dtl22 = { text = "Stonespine", colour = AM_RED, coords = { {78, 42} }, symbol = { "11" },
					tooltiptxt = "Lvl60 Elite Undead", special = AM_RARE, lootid = "STRATStonespine"  },
			dtl23 = { text = "Baroness Anastari", colour = AM_RED, coords = { {90, 39} }, symbol = { "12" },
					tooltiptxt = "Lvl59 Elite Undead", lootid = "STRATBaronessAnastari"  },
			dtl24 = { text = "Nerub'enkan", colour = AM_RED, coords = { {64, 39} }, symbol = { "13" },
					tooltiptxt = "Lvl60 Elite Undead", lootid = "STRATNerubenkan"  },
			dtl25 = { text = "Maleki the Pallid", colour = AM_RED, coords = { {81, 14} }, symbol = { "14" },
					tooltiptxt = "Lvl61 Elite Humanoid", lootid = "STRATMalekithePallid"  },
			dtl26 = { text = "Magistrate Barthilas", colour = AM_RED, coords = { {66, 10}, {74, 60} }, symbol = { "15" },
					tooltiptxt = "Lvl58 Elite Undead", special = AM_VARIES, lootid = "STRATMagistrateBarthilas" },
			dtl27 = { text = "Ramstein the Gorger", colour = AM_RED, coords = { {56, 15} }, symbol = { "16" },
					tooltiptxt = "Lvl61 Elite Undead", lootid = "STRATRamsteintheGorger"  },
			dtl28 = { text = "Baron Rivendare", colour = AM_RED, coords = { {42, 15} }, symbol = { "17" },
					tooltiptxt = "Lvl62 Elite Undead", lootid = "STRATBaronRivendare", leaveGap = 1 }
		},

		{	name = "Shadowfang Keep",			-- Shadowfang Keep
			type = AM_TYP_INSTANCE,
			displayname = "Shadowfang Keep",
			displayshort = "SFK",
			filename = "ShadowfangKeep",
			location = "Silverpine Forest (45, 67)",
			levels = "20-30",
			players = "10",
			prereq = "",
			general = "",
			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 69} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {57, 57}, {36, 55}, {29, 12} }, symbol = { AM_CHEST_SYMBOL },
					tooltiptxt = "" },
			dtl3  = { text = "Battlements", colour = AM_BLUE, coords = { {38, 71}, {54, 93} }, symbol = { "B1" },
					tooltiptxt = "" },
			dtl4  = {text = "Battlements", colour = AM_BLUE, coords = { {69, 85}, {35, 37} }, symbol = { "B2" },
					tooltiptxt = "" },
			dtl5  = { text = "Deathsworn Captain", colour = AM_RED, coords = { {69, 85}, {35, 37} }, symbol = { " " },
					tooltiptxt = "Lvl25 Elite Undead", special = AM_RARE  },
			dtl6  = { text = "Stairs", colour = AM_GREEN, coords = { {29.8, 34.8}, {50, 46.8} }, symbol = { "S1" },
					tooltiptxt = "" },
			dtl7  = { text = "Stairs", colour = AM_GREEN, coords = { {42, 32}, {67, 33} }, symbol = { "S2" },
					tooltiptxt = "", leaveGap = 1 },
			dtl8  = { text = "Rethilgore", colour = AM_RED, coords = { {70, 78} }, symbol = { "1" },
					tooltiptxt = "Lvl20 Elite Humanoid\nThe Cell Keeper" },
			dtl9  = { text = "Sorcerer Ashcrombe", colour = AM_RED, coords = { {67, 73} }, symbol = { "2" },
					tooltiptxt = "Lvl18 Elite Humanoid"  },
			dtl10 = { text = "Deathstalker Adamant", colour = AM_RED, coords = { {71, 74} }, symbol = { "3" },
					tooltiptxt = "Lvl18 Elite Humanoid"  },
			dtl11 = { text = "Razorclaw the Butcher", colour = AM_RED, coords = { {25, 59} }, symbol = { "4" },
					tooltiptxt = "Lvl22 Elite Humanoid", lootid = "BSFRazorclawtheButcher"  },
			dtl12 = { text = "Baron Silverlaine", colour = AM_RED, coords = { {13, 87} }, symbol = { "5" },
					tooltiptxt = "Lvl24 Elite Undead", lootid = "BSFSilverlaine" },
			dtl13 = { text = "Commander Springvale", colour = AM_RED, coords = { {26, 69} }, symbol = { "6" },
					tooltiptxt = "Lvl24 Elite Undead", lootid = "BSFSpringvale"  },
			dtl14 = { text = "Odo the Blindwatcher", colour = AM_RED, coords = { {61, 84} }, symbol = { "7" },
					tooltiptxt = "Lvl24 Elite Humanoid", lootid = "BSFOdotheBlindwatcher"  },
			dtl15 = { text = "Fenrus the Devourer", colour = AM_RED, coords = { {53.4, 33.4} }, symbol = { "8" },
					tooltiptxt = "Lvl25 Elite Beast", lootid = "BSFFenrustheDevourer"  },
			dtl16 = { text = "Wolf Master Nandos", colour = AM_RED, coords = { {80, 29} }, symbol = { "9" },
					tooltiptxt = "Lvl25 Elite Humanoid", lootid = "BSFWolfMasterNandos"  },
			dtl17 = { text = "Archmage Arugal", colour = AM_RED, coords = { {84, 13} }, symbol = { "10" },
					tooltiptxt = "Lvl26 Elite Humanoid", lootid = "BSFArchmageArugal", leaveGap = 1 },
			dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "BSFTrash", leaveGap = 1 }
		},

		{ 	name = "Warsong Gulch",			-- Warsong Gulch
			type = AM_TYP_BG,
			displayname = "Warsong Gulch",
			displayshort = "WSG",
			filename = "WarsongGulch",
			location = "Ashenvale (62, 84) / The Barrens (47, 8)",
			levels = "10+ Banded",
			players = "10",
			prereq = "",
			general = "",
			wmData = { minX = 0.26, maxX = 0.74, minY =  0.05, maxY = 0.95 },
			amData = { minX = 0.33, maxX = 0.97, minY = 0.12, maxY = 0.88 },
			dtl1  = { text = "Alliance Flag Room", colour = AM_BLUE, coords = { {64.31, 14.15} }, symbol = { "F" },
					tooltiptxt = "Alliance players start here" },
			dtl2  = { text = "Alliance Exit", colour = AM_BLUE, coords = { {45.93, 22.34} }, symbol = { AM_EXIT_SYMBOL },
					tooltiptxt = "Use or /afk", leaveGap = 1 },
			dtl3  = { text = "Horde Flag Room", colour = AM_RED, coords = { {70.75, 85.31} }, symbol = { "F" },
					tooltiptxt = "Horde players start here" },
			dtl4  = { text = "Horde Exit", colour = AM_RED, coords = { {87.75, 77.12} }, symbol = { AM_EXIT_SYMBOL },
					tooltiptxt = "Use or /afk", leaveGap = 1 },
			dtl5  = { text = "Power Buff", colour = AM_GREEN, coords = { {55.35, 60.26}, {76.26, 39.67} }, symbol = { "P" },
					tooltiptxt = "" },
			dtl6  = { text = "Rejuvination", colour = AM_GREEN, coords = { {81.09, 61.43}, {56.04, 39.20} }, symbol = { "R" },
					tooltiptxt = "Restores HP & Mana", leaveGap = 2 },
			dtl7  = { text = "Alliance Flag Carrier", colour = AM_BLUE, coords = { {30, 15} }, symbol = { "FC" },
					tooltiptxt = "", bgFlag = "A" },
			dtl8  = { text = "Horde Flag Carrier", colour = AM_RED, coords = { {30, 85} }, symbol = { "FC" },
					tooltiptxt = "", bgFlag = "H", leaveGap = 2 },
			dtl9  = { text = AM_FRIENDLY, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "WSGFriendly" },
			dtl10 = { text = AM_HONOURED, colour = AM_GREEN, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "WSGHonored" },
			dtl11 = { text = AM_REVERED, colour = AM_BLUE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "WSGRevered" },
			dtl12 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "WSGExalted", leaveGap = 1 },
			dtl13 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
		},

		{ 	name = "Arathi Basin",			-- Arathi Basin
			type = AM_TYP_BG,
			displayname = "Arathi Basin",
			displayshort = "AB",
			filename = "ArathiBasin",
			location = "Arathi Highlands (73, 28)",
			levels = "20+ Banded",
			players = "15",
			prereq = "",
			general = "",
			wmData = { minX = 0.23, maxX = 0.71, minY =  0.09, maxY = 0.76 },
			amData = { minX = 0.15, maxX = 0.93, minY = 0.05, maxY = 0.87 },
			dtl1  = { text = "Alliance Start", colour = AM_BLUE, coords = { {21.8, 12.98} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "Alliance players start here", bgBase = "A" },
			dtl2  = { text = "Horde Start", colour = AM_RED, coords = { {91.89, 80.63} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "Horde players start here", bgBase = "H", leaveGap = 1 },
			dtl3  = { text = "Stables", colour = AM_GREEN, coords = { {34.67, 29.6}, {9, 28.0} }, symbol = { "S" },
					tooltiptxt = "Capture", bgPOI = true },
			dtl4  = { text = "Gold Mine", colour = AM_GREEN, coords = { {72.81, 30.54}, {9, 34.0} }, symbol = { "M" },
					tooltiptxt = "Capture", bgPOI = true },
			dtl5  = { text = "Blacksmith", colour = AM_GREEN, coords = { {51.9, 50.2}, {9, 50.2} }, symbol = { "B" },
					tooltiptxt = "Capture", bgPOI = true },
			dtl6  = { text = "Lumber Mill", colour = AM_GREEN, coords = { {41.10, 62.37}, {9, 62.0} }, symbol = { "L" },
					tooltiptxt = "Capture", bgPOI = true },
			dtl7  = { text = "Farm", colour = AM_GREEN, coords = { {70.52, 67.75}, {9, 68.0} }, symbol = { "F" },
					tooltiptxt = "Capture", bgPOI = true, leaveGap = 1 },
			dtl8  = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "ABFriendly" },
			dtl9  = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "ABHonored" },
			dtl10 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "ABRevered" },
			dtl11 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "ABExalted", leaveGap = 1 },
			dtl12 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
		},

		{ 	name = "Alterac Valley",			-- Alterac Valley
			type = AM_TYP_BG,
			displayname = "Alterac Valley",
			displayshort = "AV",
			filename = "AlteracValley",
			location = "Alterac Mountains (63, 58)",
			levels = "51-60",
			players = "40",
			prereq = "",
			general = "",
			notescale = 0.7,
			wmData = { minX = 0.395, maxX = 0.586, minY =  0.106, maxY = 0.9187 },
			amData = { minX = 0.65, maxX = 0.95, minY = 0.036, maxY = 0.98 },
			dtl1  = { text = "Alliance Entrance", colour = AM_BLUE, coords = { {87.98, 2.69} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "" },
			dtl2  = { text = "Horde Entrance", colour = AM_RED, coords = { {91.01, 71.03} }, symbol = { AM_ENTRANCE_SYMBOL },
					tooltiptxt = "", leaveGap = 1 },
			dtl3  = { text = "Dun Baldar", colour = AM_BLUE, coords = { {67.38, 6.47} }, symbol = { "!" },
					tooltiptxt = "Kill boss to win the game" },
			dtl4  = { text = "Frostwolf Keep", colour = AM_RED, coords = { {75.38, 92.42} }, symbol = { "!" },
					tooltiptxt = "Kill boss to win the game", leaveGap = 1 },
			dtl5  = { text = "Graveyards", colour = AM_GREEN, coords = { {68.26, 9.55}, {79.29, 8.36}, {83.68, 32.53}, {70.89, 44.37}, {83.49, 60.99}, {80.66, 80.18}, {80.27, 94.31} }, symbol = { " " },
					tooltiptxt = "Capture to allow your faction to resurrect here", bgPOI = true },
			dtl6  = { text = "Stormpike Aid Station", colour = AM_GREEN, coords = { {68.26, 9.55}, {57, 9.55} }, symbol = { "1" },
					tooltiptxt = "", bgPOI = true },
			dtl7  = { text = "Stormpike Graveyard", colour = AM_GREEN, coords = { {79.29, 8.36}, {57, 12} }, symbol = { "2" },
					tooltiptxt = "", bgPOI = true },
			dtl8  = { text = "Stonehearth Graveyard", colour = AM_GREEN, coords = { {83.68, 32.53}, {57, 32.53} }, symbol = { "3" },
					tooltiptxt = "", bgPOI = true },
			dtl9  = { text = "Snowfall Graveyard", colour = AM_GREEN, coords = { {72.2, 44.8}, {57, 44.37} }, symbol = { "4" },
					tooltiptxt = "", bgPOI = true },
			dtl10 = { text = "Iceblood Graveyard", colour = AM_GREEN, coords = { {83.49, 60.99}, {57, 60.99} }, symbol = { "5" },
					tooltiptxt = "", bgPOI = true },
			dtl11 = { text = "Frostwolf Graveyard", colour = AM_GREEN, coords = { {82.0, 80.18}, {57, 80.18} }, symbol = { "6" },
					tooltiptxt = "", bgPOI = true },
			dtl12 = { text = "Frostwolf Relief Hut", colour = AM_GREEN, coords = { {80.27, 94.31}, {57, 94.31} }, symbol = { "7" },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl13 = { text = "Stonehearth Outpost", bgPOI = true, colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { "C" },
					tooltiptxt = "" },
			dtl14 = { text = "Balinda", colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl15 = { text = "Iceblood Garrison", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { "C" },
					tooltiptxt = "", bgPOI = true },
			dtl16 = { text = "Glavangar", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl17 = { text = "Alliance Bunkers", colour = AM_BLUE, coords = { {85.54, 41.98}, {82.02, 27.16}, {70.50, 13.53}, {73.04, 7.37} }, symbol = { " " },
					tooltiptxt = "Horde can destroy for honour\nGuards stop respawning when destroyed", bgPOI = true },
			dtl18 = { text = "Stonehearth Bunker", colour = AM_BLUE, coords = { {85.54, 41.98}, {60, 41.98} }, symbol = { "8" },
					tooltiptxt = "", bgPOI = true },
			dtl19 = { text = "Icewing Bunker", colour = AM_BLUE, coords = { {82.02, 27.16}, {60, 27.16} }, symbol = { "9" },
					tooltiptxt = "Alliance Wing Commander Karl Philips\nHorde Wing Commander Guse", bgPOI = true },
			dtl20 = { text = "Dun Baldar South Bunker", colour = AM_BLUE, coords = { {71.00, 13.00}, {60, 13.53} }, symbol = { "10" },
					tooltiptxt = "", bgPOI = true },
			dtl21 = { text = "Dun Baldar North Bunker", colour = AM_BLUE, coords = { {73.04, 7.37}, {60, 7.37} }, symbol = { "11" },
					tooltiptxt = "Horde Wing Commander Mulverick", bgPOI = true, leaveGap = 1 },
			dtl22 = { text = "Horde Towers", colour = AM_RED, coords = { {78.31, 59.29}, {81.83, 67.25}, {80.4, 89.04}, {77, 88.5}  }, symbol = { " " },
					tooltiptxt = "Alliance can destroy for honour\nGuards stop respawning when destroyed", bgPOI = true },
			dtl23 = { text = "Iceblood Tower", colour = AM_RED, coords = { {78.31, 59.29}, {60, 59.29} }, symbol = { "12" },
					tooltiptxt = "", bgPOI = true },
			dtl24 = { text = "Tower Point", colour = AM_RED, coords = { {81.83, 67.25}, {60, 67.25} }, symbol = { "13" },
					tooltiptxt = "Alliance Wing Commander Louis Philips\nHorde Wing Commander Slidore", bgPOI = true },
			dtl25 = { text = "East Frostwolf Tower", colour = AM_RED, coords = { {80.6, 89.04}, {63, 89.05} }, symbol = { "14" },
					tooltiptxt = "", bgPOI = true },
			dtl26 = { text = "West Frostwolf Tower", colour = AM_RED, coords = { {78.5, 88.8}, {60.5, 88.5} }, symbol = { "15" },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl27 = { text = "Mines", colour = AM_ORANGE, coords = { {81.15, 1.69}, {73.33, 74.61} }, symbol = { " " },
					tooltiptxt = "Capture to farm resources", bgPOI = true },
			dtl28 = { text = "Irondeep Mine", colour = AM_GREEN, coords = { {81.15, 1.69}, {63, 1.69} }, symbol = { "IM" },
					tooltiptxt = "", bgPOI = true },
			dtl29 = { text = "Coldtooth Mine", colour = AM_GREEN, coords = { {73.33, 74.61}, {63, 74.61} }, symbol = {"CM" },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
-- Pad to dtl32 to control the page break
			dtl30 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "" },
			dtl31 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "" },
			dtl32 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "" },
-- Pad to dtl32 to control the page break
			dtl33 = { text = "Summoning Zones", colour = AM_GREEN, coords = { {80.76, 44.27}, {73.14, 48.05} }, symbol = { " " },
					tooltiptxt = "Summon a Factions Avatar at these points" },
			dtl34 = { text = "Ivus the Forest Lord", colour = AM_BLUE, coords = { {80.76, 44.27} }, symbol = { "IF" },
					tooltiptxt = "Escort summoning NPCs to this point\nfrom Dun Baldar" },
			dtl35 = { text = "Lokholar the Ice Lord", colour = AM_RED, coords = { {73.14, 48.05} }, symbol = { "LI" },
					tooltiptxt = "Escort summoning NPCs to this point\nfrom Frostwolf Keep", leaveGap = 1 },
			dtl36 = { text = "Alliance Wing Commanders", colour = AM_BLUE, coords = { {82.02, 27.16}, {81.05, 85.46}, {81.83, 67.25}, {80.4, 89.04} }, symbol = { " " },
					tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
			dtl37 = { text = "Karl Philips (9 Icewing Bunker)", colour = AM_BLUE, coords = { {82.02, 27.16} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true },
			dtl38 = { text = "Slidore (13 Tower Point)", colour = AM_BLUE, coords = { {81.83, 67.25} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true },
			dtl39 = { text = "Vipore", colour = AM_BLUE, coords = { {81.05, 85.46} }, symbol = { "W" },
					tooltiptxt = "" },
			dtl40 = { text = "Ichman (14 East Frostwolf Tower)", colour = AM_BLUE, coords = { {80.4, 89.04} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl41 = { text = "Horde Wing Commanders", colour = AM_RED, coords = { {81.83, 67.25}, {82.02, 27.16}, {88.96, 23.38}, {73.04, 7.37} }, symbol = { " " },
					tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
			dtl42 = { text = "Louis Philips (13 Tower Point)", colour = AM_RED, coords = { {81.83, 67.25} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true },
			dtl43 = { text = "Guse (9 Icewing Bunker)", colour = AM_RED, coords = { {82.02, 27.16} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true },
			dtl44 = { text = "Jeztore", colour = AM_RED, coords = { {88.96, 23.38} }, symbol = { "W" },
					tooltiptxt = "" },
			dtl45 = { text = "Mulverick (11 Dun Baldar North Bunker)", colour = AM_RED, coords = { {73.04, 7.37} }, symbol = { " " },
					tooltiptxt = "", bgPOI = true, leaveGap = 1 },
			dtl46 = { text = "Steamsaw Locations", colour = AM_PURPLE, coords = { {83, 54.72}, {88.57, 15.42} }, symbol = { " " },
					tooltiptxt = "" },
			dtl47 = { text = "Alliance Steamsaw", colour = AM_BLUE, coords = { {83, 54.72} }, symbol = { "S" },
					tooltiptxt = "Required for Reaper quest" },
			dtl48 = { text = "Horde Steamsaw", colour = AM_RED, coords = { {88.57, 15.42} }, symbol = { "S" },
					tooltiptxt = "Required for Reaper quest", leaveGap = 1 },
			dtl49 = { text = "Caverns", colour = AM_GREEN, coords = { {64.54, 24.08}, {85.93, 94.71} }, symbol = { " " },
					tooltiptxt = "" },
			dtl50 = { text = "Icewing", colour = AM_GREEN, coords = { {64.54, 24.08} }, symbol = { "IC" },
					tooltiptxt = "" },
			dtl51 = { text = "Wildpaw", colour = AM_GREEN, coords = { {85.93, 94.71} }, symbol = { "WC" },
					tooltiptxt = "", leaveGap = 1 },
			dtl52 = { text = "Wolf Rider Commander", colour = AM_RED, coords = { {91.2, 86.55} }, symbol = { "WR" },
					tooltiptxt = "Tame Wolves and hand in Ram hides to summon Cavalry\nAlliance counterpart in Dun Baldar, just south of Aid Station GY", leaveGap = 2 },
			dtl53 = { text = AM_FRIENDLY, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "AVFriendly" },
			dtl54 = { text = AM_HONOURED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "AVHonored" },
			dtl55 = { text = AM_REVERED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "AVRevered" },
			dtl56 = { text = AM_EXALTED, colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
					tooltiptxt = "", lootid = "AVExalted", leaveGap = 1 },
			dtl57 = { text = AM_PVP_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
					tooltiptxt = "", lootid = "PVPSET", leaveGap = 1 }
		}

};




---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Below is the template for Adding new Instance Maps with Text and Information
-- The fields   name, type, filename, location, levels, and players   are Mandatory
-- All other fields are optional and can be deleted or left blank
-- Fields can contain multiple co-ordinates up to a maximum of AM_MAX_MULT_COORDS which
--  is set to 8 by default - Different symbols can be used at each coordinate, or just 1
-- As long as a blp/tga exists with the given filename, then nothing else needs to be
-- done to see notes on the map
-- Use 'lootid = ""' where a link to Atlas Loot information exists - must be the same as the id
--  used in that AddOn to identify the mob/set
-- Use 'toMap = ""' to place a link to a different map, e.g. links between DM West and North,
--  so that when the user clicks on the button, the map changes to the other
-- Use 'special = ' to add information such as Rare/Wanders, etc to the Key in a different colour
-- Use 'leaveGap = x' where 'x' is a number specifying the size of the gap to appear AFTER the
--  current Map Key entry
-- A symbol of "" will be blank on the map and the key. A symbol of " " will use the default
-- After 32 dtl_ fields, there will be a page break on the Map Key with arrows to show the
-- the other fields.  You can control where the page break appears amongst your notes by
-- padding with extra blank dtl_ records as per Alterac Valley above
--
-- COORDINATE MAPPING
-- wmData and amData are used to translate WorldMap coordinates in to coordinates on the
-- Instance style map. Obviously this won't help in an Instance as player coordinates are
-- not given, but plotting player positions is possible in BattleGrounds and in 'external'
-- dungeons/raid maps  -  The basic process for calulating these figures is as follows :
--  First create your map to be displayed in AlphaMap so you can see it in game and it is
--    possible to mark down mouse coordinates
--  Then move to the Far West of the dungeon/location and record your Player coordinates as
--    they would be calculated by GetPlayerMapPosition("player") - In caves like Gnomeregan and Maraudon
--    the player coordinates are actually your coords on the Continent. For Azuregos and other maps,
--    the player coordinates are normal map coords - call the West most 'X' coordinate wmData.minX
--  Then display the AlphaMap of the area, and move your mouse to the point where your player
--    is and mark down the cursor coords - call the mouse's 'X' coordinate amData.minX
--  Basically, the furthest West point of the AlphaMap is the Minimum X value where a player
--    can be displayed on the map and wmData.minX on the WorldMap is equivalent to amData.minX on the
--    AlphaMap
--  Then repeat this process for the furthest Eastern point and wmData.maxX = amData.maxX
--  Then repeat for Northern and Southern most points, .minY and maxY
--  AlphaMap should then use these comparitive coordinate systems to plot your player positions
--    on the AlphaMap based on World Map coordinates
--  This process can take a lot of fine tuning.  I found 5 decimal places was accurate enough when
--    dealing with Continent based player coords for cave systems.  Also be very wary of the fact
--    that some maps are slightly rotated in game, which can make your coordinate system accurate
--    in the middle, but with increasing variance toward the edges of the map. Also, if you make
--    any errors when you create the map, by overlapping tiles or stretching one to make it fit,
--    or whatever,  then these kinds of issues can result in strange coordinate problems too.
--
--------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
--		{	name = "",
--			type = AM_TYP_INSTANCE,
--			displayname = "",
--			filename = "",
--			location = "",
--			levels = "",
--			players = "",
--			prereq = "",
--			general = "",
--			dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {0, 0} }, symbol = { AM_ENTRANCE_SYMBOL },
--					tooltiptxt = "" },
--			dtl2  = { text = AM_INSTANCE_EXITS, colour = AM_GREEN, coords = { {0, 0} }, symbol = { AM_EXIT_SYMBOL },
--					tooltiptxt = "" },
--			dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {0, 0} }, symbol = { AM_CHEST_SYMBOL },
--					tooltiptxt = "" },
--			dtl4  = { text = AM_INSTANCE_STAIRS, colour = AM_GREEN, coords = { {0, 0} }, symbol = { AM_STAIRS_SYMBOL },
--					tooltiptxt = "", toMap = "", leaveGap = 1,  },
--			dtl5  = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = "", special = AM_RARE..AM_WANDERS, leaveGap = 2  },
--			dtl6  = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl7  = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl8  = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl9  = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl10 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl11 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl12 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl13 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl14 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl15 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl16 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl17 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl18 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl19 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl20 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl21 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl22 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl23 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl24 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl25 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = "" },
--			dtl26 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl27 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl28 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl29 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl30 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl31 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = ""  },
--			dtl32 = { text = "", colour = AM_RED, coords = { {0, 0} }, symbol = { "0" },
--					tooltiptxt = "", leaveGap = 1  },
--		}
--
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------


