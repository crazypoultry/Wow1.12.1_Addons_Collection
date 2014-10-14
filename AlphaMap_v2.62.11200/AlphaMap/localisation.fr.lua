--------------------------------------------------------------------------
-- localization.lua <French>
--------------------------------------------------------------------------
--
--	À	\195\128
--	Á	\195\129
--	Â	\195\130
--	Ä	\195\132
--	È	\195\136
--	É	\195\137
--	Ê	\195\138
--	Ë	\195\139
--	Î	\195\142
--	Ï	\195\143
--	Ô	\195\148
--	Ö	\195\150
--	Û	\195\155
--	Ü	\195\156
--	à	\195\160
--	á	\195\161
--	â	\195\162
--	ä	\195\164
--	è	\195\168
--	é	\195\169
--	ê	\195\170
--	ë	\195\171
--	î	\195\174
--	ï	\195\175
--	ô	\195\180
--	ö	\195\182
--	û	\195\187
--	ü	\195\188
--
--------------------------------------------------------------------------

if ( GetLocale() == "frFR" ) then

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
	AM_OPTIONS_GENERAL		= "General";
	AM_OPTIONS_GENERAL_CHAT		= "General Chat";
	AM_OPTIONS_DUNGEON		= "Dungeons";
	AM_OPTIONS_MAPS			= "Map Selector";
	AM_OPTIONS_ADDONS		= "WorldMap Notes & Icons : ";
	AM_OPTIONS_MISC			= "Internal AddOn Options : ";
	AM_OPTIONS_DUNGEON_NOTES	= "Dungeon Note Options : ";
	AM_OPTIONS_DUNGEON_FRAMES	= "Dungeon Extra Information : ";
	AM_OPTIONS_DM_NOTES		= "Display Dungeon Notes";
	AM_OPTIONS_DM_NOTES_TOOLTIPS	= "Display Dungeon Note Tooltips";
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
	AM_OPTIONS_BG_USE_AM		= "Use Instance Map in BattleGrounds";
	AM_OPTIONS_BG_SAVE_LABEL	= "Control settings for all BG Maps : ";
	AM_OPTIONS_BG_ALL		= "Setting Changes affect ALL BG Maps";
	AM_OPTIONS_BG_SAVE		= "Apply to ALL BG Maps";
	AM_OPTIONS_RAID_SAVE_LABEL	= "Control Settings for all Non-Instance Maps :";
	AM_OPTIONS_RAID_ALL		= "Changes affect ALL Non-Instance Maps";
	AM_OPTIONS_RAID_SAVE		= "Apply to ALL Non-Instance Maps";
	AM_OPTIONS_BG_MESSAGES		= "Send Battlefield Messages to : ";
	AM_OPTIONS_RAID			= "Raid";
	AM_OPTIONS_PARTY		= "Party";
	AM_OPTIONS_GUILD		= "Guild";
	AM_OPTIONS_GROUP_DEFAULT	= "Group Dependant";
	AM_OPTIONS_NUN_AUTO		= "Auto-Send NuN Note Settings";
	AM_OPTIONS_NUN_FORMAT		= "Send Formatted Notes";
	AM_OPTIONS_NUN_MESSAGES		= "Auto Send NuN Notes to : ";
	AM_OPTIONS_WMAP_MODES		= "World Map View Modes :";
	AM_OPTIONS_GMAP_MODES		= "Blizzard Carte Settings :";
	AM_OPTIONS_GMAP_ALLOW		= "Allow changes to Blizzard Carte";
	AM_OPTIONS_GMAP_CHANGE		= "Check to change Blizzard Carte";
	AM_OPTIONS_WMAP_SMODE		= "Standard";
	AM_OPTIONS_WMAP_OMODE		= "Compact";
	AM_OPTIONS_WMAP_MINIMODE	= "Minimap Textures";
	AM_OPTIONS_WMAP_ZMINIMODE	= "Zoomed Minimap";
	AM_OPTIONS_WMOTHER		= "Other Map Controls : ";
	AM_OPTIONS_WM_ESCAPE		= "Enable <Escape> Closing";
	AM_OPTIONS_WM_MOUSE		= "Enable Mouse Interaction";
	AM_OPTIONS_MUTE			= "Sourdine";
	AM_OPTIONS_COORDS		= "(x, y)";
	AM_OPTIONS_MAPS1		= "AlphaMap Cartes 1";
	AM_OPTIONS_MAPS2		= "  ..... 2";

	AM_INSTANCE_TITLE_LOCATION	= "Lieu ";
	AM_INSTANCE_TITLE_LEVELS	= "Niveaux ";
	AM_INSTANCE_TITLE_PLAYERS	= "Max. Joueurs ";
	AM_INSTANCE_CHESTS		= "Coffre ";
	AM_INSTANCE_STAIRS		= "Escaliers ";
	AM_INSTANCE_ENTRANCES		= "Entr\195\169e ";
	AM_INSTANCE_EXITS		= "Sortie ";
	AM_LEADSTO			= "Chemin...";
	AM_INSTANCE_PREREQS		= "Prerequisites : ";
	AM_INSTANCE_GENERAL		= "General Notes : ";
	AM_RARE				= "(Rare)";
	AM_VARIES			= "(Variable)";
	AM_WANDERS			= "(Patrols)";
	AM_OPTIONAL			= "(Optional)";

	AM_NO_LIMIT			= "Pas de limite de joueurs";

	AM_MOB_LOOT 			= "Mob Loot";
	AM_RBOSS_DROP 			= "Butin Al\195\169atoire des Boss";
	AM_ENCHANTS			= "Enchantements";
	AM_CLASS_SETS			= "Ensembles de Classe";
	AM_TIER0_SET			= "Tier 0 Sets";
	AM_TIER1_SET			= "Tier 1 Sets";
	AM_TIER2_SET			= "Tier 2 Sets";
	AM_TIER3_SET			= "Tier 3 Sets";
	AM_PVP_SET			= "PvP Sets";

	AM_ANCHOR_POINT 	= {	{ Display = "Dessus",			-- Localise
					  Command = "TOP" },					-- Do NOT Localise
					{ Display = "Dessus-droite",		-- Localise
					  Command = "TOPRIGHT" },				-- Do NOT Localise
					{ Display = "Droite",			-- Localise
					  Command = "RIGHT" },					-- Do NOT Localise
					{ Display = "Fond-droite",		-- Localise
					  Command = "BOTTOMRIGHT" },				-- Do NOT Localise
					{ Display = "Fond",			-- Localise
					  Command = "BOTTOM" },				-- Do NOT Localise
					{ Display = "Fond-gauche",		-- Localise
					  Command = "BOTTOMLEFT" },				-- Do NOT Localise
					{ Display = "Gauche",			-- Localise
					  Command = "LEFT" },					-- Do NOT Localise
					{ Display = "Dessus-gauche",			-- Localise
					  Command = "TOPLEFT" }				-- Do NOT Localise
				};

	AM_BG_BASE			= "Base";
	AM_BG_BASES			= "Bases";
	AM_BG_REQUIRED			= "Required to Win !";

	AM_EXTERIOR = " Ext\195\169rieur";

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

	AM_OPENING = "Chaine de quetes d'ouverture d'AQ";

	AM_HORDE		= "Horde";
--	AM_PICKED		= { 	word = "picked",
--					posWord = " by ",
--					extraChars = 1 };

-- Deutsch
--AM_PICKED			= {	word = "aufgenommen" };

-- Francais
	AM_PICKED		= {	word = "ramass\195\169",
					posWord = " par ",
					extraChars = 2 };

	AM_NEUTRAL		= "Neutre";
	AM_FRIENDLY		= "Amical";
	AM_HONOURED		= "Honor\195\169";
	AM_REVERED		= "R\195\169v\195\169r\195\169";
	AM_EXALTED		= "Exalt\195\169";

	AM_CONFIG_SAVED			= "AlphaMap Settings changed for : ";

	AM_CANCEL			= "Annuler";

	--------------------------------------------------------------------------------------------------------------------------------------
	-- TOOLTIPS															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TT_MINIMAP_BUTTON		= "AlphaMap\nLeft Click Toggles AlphaMap\nRight Click Toggles Options";
	AM_TT_ALPHA_BUTTON1		= "AlphaMap";
	AM_TT_ALPHA_BUTTON2		= "Left Click Toggles AlphaMap\nRight Click Toggles Options";


	--------------------------------------------------------------------------------------------------------------------------------------
	-- Everything below should be localised apart from the 'filename', 'lootid' entries which should NOT be changed                               --
	-- The first  'name'  field is used to equate with in game Zone name information to help determine when the player is in a specific --
	-- Instance, and must therefore be spelt IDENTICALLY to the names of the Instances as displayed by the WoW Client in other native   --
	-- frames.															    --
	--------------------------------------------------------------------------------------------------------------------------------------

	AM_TYP_WM			= "Carte Du Monde";
	AM_TYP_INSTANCE 		= "Instances";
	AM_TYP_BG			= "Champs de Bataille";
	AM_TYP_RAID			= "Autre";
	AM_TYP_GM			= "Blizzard Carte";

	AM_ALPHAMAP_LIST = {
			{	name = "Profondeurs de Brassenoire",			-- Blackfathom Deeps
				type = AM_TYP_INSTANCE,
				displayname = "Profondeurs de Brassenoire",
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
				dtl4  = { text = "Manuscrit de Lorgalis", colour = AM_ORANGE, coords = { {23.5, 30} }, symbol = { "2" },
						tooltiptxt = "Quest Item for 'Knowledge of the Deeps',\nin chest" },
				dtl5  = { text = "Dame Sarevess", colour = AM_RED, coords = { {3, 29} }, symbol = { "3" },
						tooltiptxt = "Lvl25 Elite  Humano\195\175de", lootid = "BFDLadySarevess" },
				dtl6  = { text = "Garde d\'Argent de Thaelrid", colour = AM_BLUE, coords = { {11, 51} }, symbol = { "4" },
						tooltiptxt = "Target of Quest 'In Search of Thaelrid',\n& Quest Start for 'Villainy'" },
				dtl7  = { text = "Autel de Gelihast", colour = AM_RED, coords = { {43, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl25 Elite  Humano\195\175de (Murloc)", lootid = "BFDGelihast" },
				dtl8  = { text = "Lorgus Jett", colour = AM_RED, coords = { {49, 43}, {55, 46} }, symbol = { "6" },
						tooltiptxt = "Lvl26 Elite  Humano\195\175de", special = AM_VARIES },
				dtl9  = { text = "Baron Aquanis", colour = AM_RED, coords = { {52, 76} }, symbol = { "7" },
						tooltiptxt = "Lvl28 Elite  Humano\195\175de", lootid = "BFDBaronAquanis" },
				dtl10 = { text = "Noyau de Fathom", colour = AM_BLUE, coords = { {52, 76} }, symbol = { " " },
						tooltiptxt = "" },
				dtl11 = { text = "Seigneur Kelris Cr\195\169pusculaire", colour = AM_RED, coords = { {63, 81} }, symbol = { "8" },
						tooltiptxt = "Lvl27 Elite  Humano\195\175de", lootid = "BFDTwilightLordKelris" },
				dtl12 = { text = "Autel", colour = AM_BLUE, coords = { {63, 81} }, symbol = { " " },
						tooltiptxt = "" },
				dtl13 = { text = "Vieux Serra'kis", colour = AM_RED, coords = { {63, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl26 Elite Beast", lootid = "BFDOldSerrakis" },
				dtl14 = { text = "Aku'mai", colour = AM_RED, coords = { {95, 85} }, symbol = { "10" },
						tooltiptxt = "Lvl29 Elite Beast (Hydra)", lootid = "BFDAkumai", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BFDTrash", leaveGap = 1 }
			},

			{	name = "Profondeurs de Blackrock",			-- Blackrock Depths
				type = AM_TYP_INSTANCE,
				displayname = "Profondeurs de Blackrock",
				displayshort = "BRD",
				filename = "BlackrockDepths",
				location = "Montagne de Blackrock",
				levels = "52-60",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {21, 83} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "Seigneur Roccor", colour = AM_RED, coords = { {33, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl51 Elite `", lootid = "BRDLordRoccor" },
				dtl3  = { text = "Grand Interrogateur Gerstahn", colour = AM_RED, coords = { {38, 95} }, symbol = { "2" },
						tooltiptxt = "Lvl52 Elite  Humano\195\175de", lootid = "BRDHighInterrogatorGerstahn" },
				dtl4  = { text = "Mar\195\169chal Windsor", colour = AM_BLUE, coords = { {46, 95} }, symbol = { "3" },
						tooltiptxt = "Link in Onyxia Quest Chain" },
				dtl5  = { text = "Commandant Gor'shak", colour = AM_BLUE, coords = { {40, 90} }, symbol = { "4" },
						tooltiptxt = "'Commander Gor'shak' Quest" },
				dtl6  = { text = "Kharan Mighthammer", colour = AM_BLUE, coords = { {44, 86} }, symbol = { "5" },
						tooltiptxt = "'Kharan Mighthammer' Quest" },
				dtl7  = { text = "L'Ar\195\168ne", colour = AM_GREEN, coords = { {42, 73.4} }, symbol = { "6" },
						tooltiptxt = "Defeat Mobs here to turn \nUpper level spectators from \nRed Aggro. to Yellow", lootid = "BRDArena" },
				dtl8  = { text = "Theldren", colour = AM_RED, coords = { {42, 73.4} }, symbol = { " " },
						tooltiptxt = "NPC Group Leader", lootid = "BRDArena" },
				dtl9  = { text = "Franclorn Forgewright", colour = AM_BLUE, coords = { {45.8, 78.1} }, symbol = { "7" },
						tooltiptxt = "'Dark Iron Legacy' Quest" },
				dtl10  = { text = "Pyromancer Loregrain", colour = AM_RED, coords = { {48, 78} }, symbol = { "8" },
						tooltiptxt = "Lvl52 Elite  Humano\195\175de", special = AM_RARE, lootid = "BRDPyromantLoregrain" },
				dtl11 = { text = "La Chambre forte", colour = AM_GREEN, coords = { {54, 54} }, symbol = { "9" },
						tooltiptxt = "" },
				dtl12  = { text = "Fineous Darkvire", colour = AM_RED, coords = { {55, 41} }, symbol = { "10" },
						tooltiptxt = "Lvl54 Elite  Humano\195\175de", lootid = "BRDFineousDarkvire" },
				dtl13 = { text = "Warder Stilgliss", colour = AM_RED, coords = { {48, 55} }, symbol = { "11" },
						tooltiptxt = "Lvl56 Elite  Humano\195\175de", lootid = "BRDWarderStilgiss" },
				dtl14 = { text = "Verek", colour = AM_RED, coords = { {54, 54} }, symbol = { " " },
						tooltiptxt = "Lvl55 Elite" },
				dtl15 = { text = "Seigneur Incendius", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { "12" },
						tooltiptxt = "'Incendius!' Quest", lootid = "BRDLordIncendius" },
				dtl16 = { text = "L'Enclume Noire", colour = AM_RED, coords = { {48.7, 48.1} }, symbol = { " " },
						tooltiptxt = "" },
				dtl17 = { text = "Serrure De Shadowforge", colour = AM_GREEN, coords = { {31, 72.4} }, symbol = { "13" },
						tooltiptxt = "Unlock to allow deeper access to higher level areas\nRequires Shadowforge Key" },
				dtl18 = { text = "Bael'Gar", colour = AM_RED, coords = { {8, 62} }, symbol = { "14" },
						tooltiptxt = "Lvl57 Elite Mountain Giant", lootid = "BRDBaelGar" },
				dtl19 = { text = "General Angerforge", colour = AM_RED, coords = { {24, 64} }, symbol = { "15" },
						tooltiptxt = "Lvl57 Elite Dwarf", lootid = "BRDGeneralAngerforge" },
				dtl20 = { text = "Seigneur Golem Argelmach", colour = AM_RED, coords = { {24, 51} }, symbol = { "16" },
						tooltiptxt = "Lvl58 Elite Dwarf", lootid = "BRDGolemLordArgelmach" },
				dtl21 = { text = "The Grim Guzzler", colour = AM_GREEN, coords = { {40, 50} }, symbol = { "17" },
						tooltiptxt = "Buy 6 Dark Iron Ale mugs\nand give them to Rocknot ;P", lootid = "BRDGuzzler" },
				dtl22 = { text = "Ambassadeur Cingleflammes", colour = AM_RED, coords = { {46, 38} }, symbol = { "18" },
						tooltiptxt = "Lvl57 Elite  Humano\195\175de", lootid = "BRDFlamelash" },
				dtl23 = { text = "Panzor L'Invincible", colour = AM_RED, coords = { {40, 27} }, symbol = { "19" },
						tooltiptxt = "Lvl57 Elite Golem", special = AM_RARE, lootid = "BRDPanzor" },
				dtl24 = { text = "Le Tombeau des Sept", colour = AM_GREEN, coords = { {46, 18} }, symbol = { "20" },
						tooltiptxt = "Defeat 7 bosses in sequence to go deeper\n& Chest", lootid = "BRDTomb" },
				dtl25 = { text = "Le Lyceum", colour = AM_GREEN, coords = { {61, 8.5} }, symbol = { "21" },
						tooltiptxt = "Find and defeat 2 Flamekeepers\nand light both torches to progress.\nOnly have 3 minutes from killing the first." },
				dtl26 = { text = "Magmus", colour = AM_RED, coords = { {78, 8.5} }, symbol = { "22" },
						tooltiptxt = "Lvl57 Elite Mountain Giant", lootid = "BRDMagmus" },
				dtl27 = { text = "Princesse Moira Bronzebeard", colour = AM_RED, coords = { {90, 8} }, symbol = { "23" },
						tooltiptxt = "Lvl58 Elite  Humano\195\175de", lootid = "BRDPrincess" },
				dtl28 = { text = "Empereur Dagran Thaurissan", colour = AM_RED, coords = { {93, 8.5} }, symbol = { "24" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "BRDImperatorDagranThaurissan" },
				dtl29 = { text = "La Forge Noire", colour = AM_GREEN, coords = { {63, 22} }, symbol = { "23" },
						tooltiptxt = "Forge Dark Iron,\nand make Smoking Heart of the Mountain" },
				dtl30 = { text = "C\197\147ur du Magma", colour = AM_ORANGE, coords = { {65, 30} }, symbol = { "24" },
						tooltiptxt = "'Attunement to the Core' Quest\nMolten Core Entrance", toMap = "C\197\147ur du Magma", leaveGap = 1 }
			},

			{	name = "Pic Blackrock",		-- Blackrock Spire
				type = AM_TYP_INSTANCE,
				displayname = "Pic Blackrock (Inf\195\169rieur)",
				displayshort = "LBRS",
				filename = "LBRS",			-- LBRS
				location = "Montagne de Blackrock",
				levels = "53-60",
				players = "15",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 10} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Pic Blackrock (Sup\195\169rieur)", colour = AM_BLUE, coords = { {22, 4} }, symbol = { "U" },
						tooltiptxt = "", toMap = "Pic Blackrock (Sup\195\169rieur)" },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {45.2, 29}, {73, 46} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "Pont \195\160 G\195\169n\195\169ralissime Omokk", colour = AM_GREEN, coords = { {38, 32.1}, {15, 32.1} }, symbol = { "B" },
						tooltiptxt = "" },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {71, 22}, {94, 26} }, symbol = { "x2" },
						tooltiptxt = "Niveau plus bas" },
				dtl6  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {29, 53}, {29, 77} }, symbol = { "x3" },
						tooltiptxt = "" },
				dtl7  = { text = "Rampes", colour = AM_BLUE, coords = { {86, 40}, {89, 58} }, symbol = { "R" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "Vaelan", colour = AM_RED, coords = { {31, 17} }, symbol = { "1" },
						tooltiptxt = "Lvl55 Elite\nSeal of Ascension Quest"  },
				dtl9  = { text = "Warosh", colour = AM_RED, coords = { {53, 14} }, symbol = { "2" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de"  },
				dtl10 = { text = "Pique de Roughshod", colour = AM_ORANGE, coords = { {69, 29} }, symbol = { "3" },
						tooltiptxt = "Quest Item"  },
				dtl11 = { text = "Bijou", colour = AM_BLUE, coords = { {62, 25 } }, symbol = { "4" },
						tooltiptxt = "Bijou Quest chain\nPas Niveau plus bas" },
				dtl12 = { text = "Boucher Spirestone", colour = AM_RED, coords = { {42, 32.1} }, symbol = { "5" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de\nPatrols bridge to Highlord Omokk", lootid = "LBRSSpirestoneButcher", special = AM_RARE  },
				dtl13 = { text = "G\195\169n\195\169ralissime Omokk", colour = AM_RED, coords = { {2, 32.1} }, symbol = { "6" },
						tooltiptxt = "Lvl?? Elite  Humano\195\175de", lootid = "LBRSOmokk"  },
				dtl14 = { text = "Seigneur de guerre Spirestone", colour = AM_RED, coords = { {2, 32.1} }, symbol = { " " },
						tooltiptxt = "Spawns on hill near Lord Omokk", lootid = "LBRSSpirestoneLord", special = AM_RARE },
				dtl15 = { text = "Chasseur d'ombres Vosh'gajin", colour = AM_RED, coords = { {77, 64} }, symbol = { "7" },
						tooltiptxt = "Lvl?? Elite  Humano\195\175de", lootid = "LBRSVosh"  },
				dtl16 = { text = "Cinqui\195\168me tablette Mosh'aru", colour = AM_ORANGE, coords = { {77, 68} }, symbol = { "8" },
						tooltiptxt = "Quest Item"  },
				dtl17 = { text = "Bannok Grimaxe", colour = AM_RED, coords = { {41.5, 26.5} }, symbol = { "9" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de\nNiveau plus bas", lootid = "LBRSGrimaxe", special = AM_RARE },
				dtl18 = { text = "Maitre de Guerre Voone", colour = AM_RED, coords = { {73, 32} }, symbol = { "10" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "LBRSVoone" },
				dtl19 = { text = "Sixi\195\168me tablette Mosh'aru", colour = AM_ORANGE, coords = { {75, 29} }, symbol = { "11" },
						tooltiptxt = "Quest Item"  },
				dtl20 = { text = "Mor Grayhoof", colour = AM_RED, coords = { {75, 35} }, symbol = { "12" },
						tooltiptxt = "Lvl60 Elite\nRequires Summoning Brazier\nInterrupt their heals", lootid = "LBRSGrayhoof" },
				dtl21  = { text = "Matriarche Couveuse", colour = AM_RED, coords = { {54, 58} }, symbol = { "13" },
						tooltiptxt = "Lvl59 Elite Beast", lootid = "LBRSSmolderweb"  },
				dtl22 = { text = "Croc Cristalin", colour = AM_RED, coords = { {36, 49} }, symbol = { "14" },
						tooltiptxt = "Lvl60 Elite Beast", special = AM_RARE, lootid = "LBRSCrystalFang"  },
				dtl23 = { text = "Urok Hurleruine", colour = AM_RED, coords = { {30, 30} }, symbol = { "15" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", lootid = "LBRSDoomhowl"  },
				dtl24 = { text = "Intendant Zigris", colour = AM_RED, coords = { {50, 89} }, symbol = { "16" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "LBRSZigris"  },
				dtl25 = { text = "Halcyon", colour = AM_RED, coords = { {19, 92} }, symbol = { "17" },
						tooltiptxt = "Lvl59 Elite Beast\nKill to trigger spawn of Gizrul", lootid = "LBRSHalycon"  },
				dtl26 = { text = "Gizrul l'Esclavagiste", colour = AM_RED, coords = { {19, 92} }, symbol = { " " },
						tooltiptxt = "Lvl60 Elite Beast\nSpawn triggered by death of Halcyon", lootid = "LBRSSlavener"  },
				dtl27 = { text = "Seigneur Wyrmthalak", colour = AM_RED, coords = { {42, 62} }, symbol = { "18" },
						tooltiptxt = "Lvl?? Elite  Draconien", lootid = "LBRSWyrmthalak", leaveGap = 1  },
				dtl28 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl29 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "LBRSTrash", leaveGap = 1 }
			},

			{	name = "Pic Blackrock (Sup\195\169rieur)",
				type = AM_TYP_INSTANCE,
				displayname = "Pic Blackrock (Sup\195\169rieur)",
				displayshort = "UBRS",
				filename = "UBRS",			-- UBRS
				location = "Montagne de Blackrock",
				levels = "53-60",
				players = "15",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 80.7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Pic Blackrock (Inf\195\169rieur)", colour = AM_BLUE, coords = { {18.2, 86.6} }, symbol = { "L" },
						tooltiptxt = "", toMap = "Pic Blackrock", leaveGap = 1 },
				dtl3  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {11.9, 58.4}, {8.65, 25} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl4  = { text = "Pyroguard Proph\195\168te Ardent", colour = AM_RED, coords = { {8.2, 31.0} }, symbol = { "1" },
						tooltiptxt = "Lvl?? Elite  El\195\169mentaire", lootid = "UBRSEmberseer", leaveGap = 1  },
				dtl5  = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {8.6, 38.9}, {36.4, 61.2} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl6  = { text = "Fermoir de Doomrigger", colour = AM_ORANGE, coords = { {41.3, 68.65} }, symbol = { "2" },
						tooltiptxt = "Quest Item\nIn large Chest among toppled pillars\nCan be hard to spot\nCan drop down from General Drakkisath"  },
				dtl7  = { text = "Flamme du p\195\168re", colour = AM_ORANGE, coords = { {50, 65.45} }, symbol = { "3" },
						tooltiptxt = "Fight spawns near doorway\nStop hatchers hatching eggs", lootid = "UBRSFLAME"  },
				dtl8  = { text = "Solakar Voluteflamme", colour = AM_RED, coords = { {50, 65.45} }, symbol = { " " },
						tooltiptxt = "Lvl60 Elite  Draconien\nSpawned after Looting Father Flame", lootid = "UBRSSolakar" },
				dtl9  = { text = "Jed Runewatcher", colour = AM_RED, coords = { {47, 52.6} }, symbol = { "4" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", special = AM_RARE, lootid = "UBRSRunewatcher"  },
				dtl10 = { text = "Goraluk Anvilcrack", colour = AM_RED, coords = { {34, 52.6} }, symbol = { "5" },
						tooltiptxt = "Lvl61 Elite  Humano\195\175de", lootid = "UBRSAnvilcrack"  },
				dtl11 = { text = "Rend Blackhand", colour = AM_RED, coords = { {67.5, 51} }, symbol = { "6" },
						tooltiptxt = "Boss\nLimited to 'For the Horde!' Quest\nComes mounted on Gyth", lootid = "UBRSRend"  },
				dtl12  = { text = "Gyth", colour = AM_RED, coords = { {67.5, 51} }, symbol = { " " },
						tooltiptxt = "Lvl?? Elite  Draconien", lootid = "UBRSGyth" },
				dtl13 = { text = "Awbee", colour = AM_BLUE, coords = { {68.1, 65.9} }, symbol = { "7" },
						tooltiptxt = "Limited to 'The Matron Protectorate' Quest"  },
				dtl14 = { text = "La B\195\170te", colour = AM_RED, coords = { {95.7, 60.8} }, symbol = { "8" },
						tooltiptxt = "Lvl?? Elite Beast", lootid = "UBRSBeast"  },
				dtl15 = { text = "Seigneur Valthalak", colour = AM_RED, coords = { {95.7, 56.5} }, symbol = { "9" },
						tooltiptxt = "Lvl?? Elite\nNeed Quest to Summon\nClear Hall of Blackhand first", lootid = "UBRSValthalak" },
				dtl16  = { text = "G\195\169n\195\169ral Drakkisath", colour = AM_RED, coords = { {41.6, 73.2} }, symbol = { "10" },
						tooltiptxt = "Lvl?? Elite  Draconien", lootid = "UBRSDrakkisath"  },
				dtl17 = { text = "Repaire de l'Aile noire", colour = AM_BLUE, coords = { {78.5, 27.6} }, symbol = { "BWL" },
						tooltiptxt = "", toMap = "Repaire de l'Aile noire", leaveGap = 1 },
				dtl18 = { text = AM_TIER0_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T0SET", leaveGap = 1 },
				dtl19 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UBRSTrash", leaveGap = 1 }
			},

			{	name = "Repaire de l'Aile noire",		-- Blackwing Lair
				type = AM_TYP_INSTANCE,
				displayname = "Repaire de l'Aile noire",
				displayshort = "BWL",
				filename = "BlackwingLair",
				location = "Pic Blackrock",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {65, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "Pic Blackrock (Sup\195\169rieur)", leaveGap = 1 },
				dtl2 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {32.8, 78}, {61, 48} }, symbol = { "x1" },
						tooltiptxt = "" },
				dtl3 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {40, 96}, {68, 65} }, symbol = { "x2" },
						tooltiptxt = "" },
				dtl4 = { text = AM_LEADSTO, colour = AM_GREEN, coords = { {47, 51}, {17, 52} }, symbol = { "x3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "Tranchetripe l'Indompt\195\169", colour = AM_RED, coords = { {51, 66} }, symbol = { "1" },
						tooltiptxt = "Boss", lootid = "BWLRazorgore"  },
				dtl6  = { text = "Vaelastrasz le Corrompu", colour = AM_RED, coords = { {32.5, 67} }, symbol = { "2" },
						tooltiptxt = "Boss", lootid = "BWLVaelastrasz"  },
				dtl7  = { text = "Seigneur des couv\195\169es Lashlayer", colour = AM_RED, coords = { {77, 42} }, symbol = { "3" },
						tooltiptxt = "Boss", lootid = "BWLLashlayer"  },
				dtl8  = { text = "Gueule de Feu", colour = AM_RED, coords = { {12, 44} }, symbol = { "4" },
						tooltiptxt = "Boss", lootid = "BWLFiremaw"  },
				dtl9  = { text = "Roch\195\169b\195\168ne", colour = AM_RED, coords = { {10, 29} }, symbol = { "5" },
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

			{	name = "Hache-Tripes"..AM_EXTERIOR,		-- Hache-Tripes Ext\195\169rieur
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - Hache-Tripes",
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
						tooltiptxt = "", toMap = "Hache-Tripes", leaveGap = 1 },
				dtl2  = { text = "Eldereth Row", colour = AM_BLUE, coords = { {57, 73} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "Broken Commons", colour = AM_BLUE, coords = { {62, 50} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "Skarr l'Invaincu", colour = AM_RED, coords = { {62, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl58 Elite  Humano\195\175de" },
				dtl5  = { text = "L'Ar\195\168ne", colour = AM_RED, coords = { {62, 26} }, symbol = { "4" },
						tooltiptxt = "PvP Area" },
				dtl6  = { text = "Path to L'Ar\195\168ne", colour = AM_BLUE, coords = { {44, 47}, {58, 33} }, symbol = { "P" },
						tooltiptxt = "Sleeping Hyena Guards" },
				dtl7  = { text = "Chamber with roof Exit from DM Est", colour = AM_BLUE, coords = { {85, 19.4} }, symbol = { "5" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "Hache-Tripes Est", colour = AM_GREEN, coords = { {84, 32}, {96, 62} }, symbol = { "E" },
						tooltiptxt = "Click to Open Hache-Tripes Est Map", toMap = "Hache-Tripes Est" },
				dtl9  = { text = "Hache-Tripes Nord", colour = AM_GREEN, coords = { {62, 4} }, symbol = { "N" },
						tooltiptxt = "Click to Open Hache-Tripes Nord Map", toMap = "Hache-Tripes Nord" },
				dtl10 = { text = "Hache-Tripes Ouest", colour = AM_GREEN, coords = { {42, 40} }, symbol = { "W" },
						tooltiptxt = "Click to Open Hache-Tripes Ouest Map", toMap = "Hache-Tripes Ouest", leaveGap = 1 }
			},

			{	name = "Hache-Tripes",		-- Hache-Tripes
				type = AM_TYP_INSTANCE,
				displayname = "Hache-Tripes - Enti\195\168re",
				displayshort = "DM",
				filename = "DireMaul",
				location = "Feralas (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "Hache-Tripes Est", colour = AM_GREEN, coords = { {53, 81}, {57, 96}, {100, 80} }, symbol = { "E" },
						tooltiptxt = "Click to Open Hache-Tripes Est Map", toMap = "Hache-Tripes Est" },
				dtl2  = { text = "Hache-Tripes Nord", colour = AM_GREEN, coords = { {67.5, 38} }, symbol = { "N" },
						tooltiptxt = "Click to Open Hache-Tripes Nord Map", toMap = "Hache-Tripes Nord" },
				dtl3  = { text = "Hache-Tripes Ouest", colour = AM_GREEN, coords = { {47, 88} }, symbol = { "W" },
						tooltiptxt = "Click to Open Hache-Tripes Ouest Map", toMap = "Hache-Tripes Ouest", leaveGap = 1 },
				dtl4  = { text = "Biblioth\195\168que", colour = AM_BLUE, coords = { {24, 58}, {41, 41} }, symbol = { "L" },
						tooltiptxt = "Reached from Nord or Ouest Hache-Tripes", leaveGap = 1 }
			},


			{	name = "Hache-Tripes Est",		-- Hache-Tripes Est
				type = AM_TYP_INSTANCE,
				displayname = "Hache-Tripes (Est)",
				displayshort = "DM",
				filename = "DMEast",		--DMEast
				location = "Feralas (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "",
				general = "",
				dtl1  = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {6, 58}  }, symbol = { "X1" },
						tooltiptxt = "", toMap = "Hache-Tripes"..AM_EXTERIOR },
				dtl2  = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {12, 92} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "Hache-Tripes"..AM_EXTERIOR },
				dtl3  = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {98, 64} }, symbol = { "X3" },
						tooltiptxt = "" },
				dtl4  = { text = AM_INSTANCE_EXITS, colour = AM_RED, coords = { {8, 40} }, symbol = { AM_EXIT_SYMBOL },
						tooltiptxt = "Drop to Broken Commons\nside Chamber" },
				dtl5  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {41, 85}, {61, 93} }, symbol = { "L1" },
						tooltiptxt = "" },
				dtl6  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {75, 92}, {55, 82} }, symbol = { "L2" },
						tooltiptxt = "" },
				dtl7  = { text = AM_LEADSTO, colour = AM_BLUE, coords = { {67, 63}, {83, 73} }, symbol = { "L3" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "D\195\169but de la chasse \195\160 Pusillin", colour = AM_GREEN, coords = { {10, 50} }, symbol = { "P" },
						tooltiptxt = "Chase to get Hache-Tripes (Crescent) Key", lootid = "DMEPusillin"  },
				dtl9  = { text = "Fin de la chasse \195\160 Pusillin", colour = AM_RED, coords = { {79, 61} }, symbol = { "P" },
						tooltiptxt = "Oooh, you little Imp!", lootid = "DMEPusillin"  },
				dtl10 = { text = "Zevrim Thornhoof", colour = AM_RED, coords = { {83, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl57 Elite Demon", lootid = "DMEZevrimThornhoof"  },
				dtl11 = { text = "Hydrog\195\169nos", colour = AM_RED, coords = { {64, 77} }, symbol = { "2" },
						tooltiptxt = "Lvl57 Elite  El\195\169mentaire", lootid = "DMEHydro"  },
				dtl12 = { text = "Lethendris", colour = AM_RED, coords = { {46, 66} }, symbol = { "3" },
						tooltiptxt = "Lvl57 Elite  Humano\195\175de", lootid = "DMELethtendris"  },
				dtl13 = { text = "Viel Ironbark", colour = AM_RED, coords = { {21, 69} }, symbol = { "4" },
						tooltiptxt = "Opens door"  },
				dtl14 = { text = "Alzzin le modeleur", colour = AM_RED, coords = { {42, 23} }, symbol = { "5" },
						tooltiptxt = "Lvl58 Elite Demon", lootid = "DMEAlzzin"  },
				dtl15 = { text = "Isalien", colour = AM_RED, coords = { {42, 23} }, symbol = { " " },
						tooltiptxt = "Need Brazier of Beckoning to summon\nQuest from Bodley in Blackrock Mountain", lootid = "DMEIsalien", leaveGap = 2 },
				dtl16 = { text = "Livres", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMETrash", leaveGap = 1 }
			},

			{	name = "Hache-Tripes Nord",		-- Hache-Tripes Nord
				type = AM_TYP_INSTANCE,
				displayname = "Hache-Tripes (Nord)",
				displayshort = "DM",
				filename = "DMNorth",		-- DMNorth
				location = "Feralas (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "Requires Crescent Key from Pusillin Chase in DM East",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {74, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "Hache-Tripes"..AM_EXTERIOR },
				dtl2  = { text = "Hache-Tripes(Ouest)", colour = AM_GREEN, coords = { {9, 98} }, symbol = { "W" },
						tooltiptxt = "", toMap = "Hache-Tripes Ouest" },
				dtl3  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {49.2, 59.4} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "Garde Mol'dar", colour = AM_RED, coords = { {76.4, 55.5} }, symbol = { "1" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "DMNGuardMoldar"  },
				dtl5  = { text = "Kreeg le marteleur", colour = AM_RED, coords = { {67, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl57 Elite Demon", lootid = "DMNStomperKreeg"  },
				dtl6  = { text = "Garde Fengus", colour = AM_RED, coords = { {49.2, 56.1} }, symbol = { "3" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "DMNGuardFengus"  },
				dtl7  = { text = "Garde Slip'kik", colour = AM_RED, coords = { {17, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl59 Elite  Humano\195\175de", lootid = "DMNGuardSlipkik"  },
				dtl8  = { text = "Knot Thimblejack", colour = AM_RED, coords = { {19, 37} }, symbol = { "5" },
						tooltiptxt = "", lootid = "DMNThimblejack"  },
				dtl9  = { text = "Capitaine Kromcrush", colour = AM_RED, coords = { {24.6, 34.8} }, symbol = { "6" },
						tooltiptxt = "", lootid = "DMNCaptainKromcrush"  },
				dtl10 = { text = "Roi Gordok", colour = AM_RED, coords = { {24.2, 11.2} }, symbol = { "7" },
						tooltiptxt = "", lootid = "DMNKingGordok"  },
				dtl11 = { text = "Biblioth\195\168que", colour = AM_BLUE, coords = { {20, 89} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 2  },
				dtl12 = { text = "Tribute Run", colour = AM_PURPLE, coords = { {0, 0 } }, symbol = { " " },
						tooltiptxt = "", lootid = "DMNTRIBUTERUN" },
				dtl13 = { text = "Livres", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "DMBooks", leaveGap = 1 }
			},

			{	name = "Hache-Tripes Ouest",		-- Hache-Tripes Ouest
				type = AM_TYP_INSTANCE,
				displayname = "Hache-Tripes (Ouest)",
				displayshort = "DM",
				filename = "DMWest",		-- DMWest
				location = "Feralas (59, 44)",
				levels = "56-60",
				players = "5",
				prereq = "Requires Crescent Key from Pusillin Chase in DM East",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {97, 78} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "Hache-Tripes"..AM_EXTERIOR },
				dtl2  = { text = "Hache-Tripes (Nord)", colour = AM_GREEN, coords = { {66, 9} }, symbol = { "N" },
						tooltiptxt = "", toMap = "Hache-Tripes Nord", leaveGap = 1 },
				dtl3  = { text = "Escaliers", colour = AM_BLUE, coords = { {49.2, 25}, {52, 60} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "Les Pyl\195\180nes", colour = AM_GREEN, coords = { {83, 80}, {64, 61}, {64, 87}, {27, 62}, {27, 37} }, symbol = { "P" },
						tooltiptxt = "Destroy these", leaveGap = 1 },
				dtl5  = { text = "Ancienne de Shen'Dralar", colour = AM_ORANGE, coords = { {68, 74} }, symbol = { "1" },
						tooltiptxt = "Quest to Kill Prince" },
				dtl6  = { text = "Tendris Crochebois", colour = AM_RED, coords = { {58, 74} }, symbol = { "2" },
						tooltiptxt = "Lvl60 Elite  El\195\169mentaire", lootid = "DMWTendrisWarpwood" },
				dtl7  = { text = "Illyanna Ravnoak", colour = AM_RED, coords = { {49, 87} }, symbol = { "3" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "DMWIllyannaRavenoak" },
				dtl8  = { text = "Tsu'Zee", colour = AM_RED, coords = { {48, 60} }, symbol = { "4" },
						tooltiptxt = "Lvl59 Elite Mort-vivant", special = AM_RARE, lootid = "DMWTsuzee" },
				dtl9  = { text = "Magistrat Kalendris", colour = AM_RED, coords = { {53, 51} }, symbol = { "5" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "DMWMagisterKalendris" },
				dtl10 = { text = "Immol'thar", colour = AM_RED, coords = { {19, 49} }, symbol = { "6" },
						tooltiptxt = "Lvl61 Elite Demon", lootid = "DMWImmolthar" },
				dtl11 = { text = "Seigneur Hel'nurath", colour = AM_RED, coords = { { 19, 49} }, symbol = { " " },
						tooltiptxt = "Lvl62 Elite Demon\nSummon as part of Warlock Epic Mount quest", lootid = "DMWHelnurath" },
				dtl12 = { text = "Prince Tortheldrin", colour = AM_RED, coords = { {41, 26} }, symbol = { "7" },
						tooltiptxt = "Lvl61 Elite  Humano\195\175de", lootid = "DMWPrinceTortheldrin", leaveGap = 1  },
				dtl13 = { text = "Biblioth\195\168que", colour = AM_BLUE, coords = { {51, 20} }, symbol = { "8" },
						tooltiptxt = "", leaveGap = 1 },
				dtl14 = { text = "Livres", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
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
				dtl4  = { text = "Retomb\195\169es Visqueuses", colour = AM_RED, coords = { {71.5, 33.5} }, symbol = { "1" },
						tooltiptxt = "Lvl30 Elite  El\195\169mentaire\nNiveau plus bas", lootid = "GnViscousFallout" },
				dtl5  = { text = "Grubbis", colour = AM_RED, coords = { {95, 46} }, symbol = { "2" },
						tooltiptxt = "Lvl32 Elite  Humano\195\175de\nTriggered Spawn\nSpeak to Blastmaster at same location", lootid = "GnGrubbis"  },
				dtl6  = { text = "Kernobee (The Dormitory)", colour = AM_BLUE, coords = { {76, 54} }, symbol = { "3" },
						tooltiptxt = ""  },
				dtl7  = { text = "Matrice d'Encodage 3005-B", colour = AM_GREEN, coords = { {70, 50} }, symbol = { "B" },
						tooltiptxt = "Card Upgrade"  },
				dtl8  = { text = "Zone Propre", colour = AM_GREEN, coords = { {64, 46} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "Electrocuteur 6000", colour = AM_RED, coords = { {30, 49} }, symbol = { "5" },
						tooltiptxt = "Lvl32 Elite Mechanical\nDrops Workshop Key", lootid = "GnElectrocutioner6000"  },
				dtl10 = { text = "Matrice d'Encodage 3005-C", colour = AM_GREEN, coords = { {33.2, 49.6} }, symbol = { "C" },
						tooltiptxt = "Card Upgrade"  },
				dtl11 = { text = "Faucheur de foule 9-60", colour = AM_RED, coords = { {47.6, 77.3} }, symbol = { "6" },
						tooltiptxt = "Lvl32 Elite Mechanical", lootid = "GnCrowdPummeler960"  },
				dtl12 = { text = "Matrice d'Encodage 3005-D", colour = AM_GREEN, coords = { {48.9, 75.7} }, symbol = { "D" },
						tooltiptxt = "Card Upgrade"  },
				dtl13 = { text = "Dark Iron Ambassadeur", colour = AM_RED, coords = { {9, 52} }, symbol = { "5" },
						tooltiptxt = "Lvl33 Elite  Humano\195\175de", special = AM_RARE, lootid = "GnDIAmbassador"  },
				dtl14 = { text = "Mekgineer Thermoplugg", colour = AM_RED, coords = { {11.8, 42.2} }, symbol = { "8" },
						tooltiptxt = "Lvl35 Elite Demon", lootid = "GnMekgineerThermaplugg", leaveGap = 1  },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "GnTrash", leaveGap = 1 }
			},

			{	name = "Gnomeregan"..AM_EXTERIOR,			-- Gnomeregan
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - Gnomeregan",
				filename = "GnomereganExt",
				location = "Dun Morogh (25, 41)",
				levels = "",
				players = "",
				prereq = "",
				general = "Horde access via Teleporter in Booty Bay.\nInitial Quest from Orgrimmar Engineer.",
				wmData = { minX = 0.42812, maxX = 0.43726, minY =  0.52503, maxY = 0.53932 },
				amData = { minX = 0.198, maxX = 0.905, minY = 0.21, maxY = 0.940 },
				dtl1  = { text = "Ext\195\169rieur", colour = AM_GREEN, coords = { {91.0, 92.5} }, symbol = { "O" },
						tooltiptxt = "" },
				dtl2  = { text = "Ascenseur", colour = AM_GREEN, coords = { {81.59, 87.65} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl3  = { text = "Transpolyporter", colour = AM_GREEN, coords = { {60.95, 72.95} }, symbol = { "P" },
						tooltiptxt = "From Booty Bay" },
				dtl4  = { text = "Sprok", colour = AM_BLUE, coords = { {60.95, 72.95} }, symbol = { " " },
						tooltiptxt = "Away Team", leaveGap = 1 },
				dtl5  = { text = "Matrice d'Encodage 3005-A", colour = AM_PURPLE, coords = { {67.29, 42.22}, {61.43, 41.78}, {64.00, 26.52}, {69.46, 26.75} }, symbol = { "A" },
						tooltiptxt = "Card Upgrade" },
				dtl6  = { text = "Techbot", colour = AM_RED, coords = { {44.0, 36.53} }, symbol = { "1" },
						tooltiptxt = "Lvl26 Elite Mechanical", leaveGap = 1 },
				dtl7  = { text = "Gnomeregan", colour = AM_ORANGE, coords = { {18.89, 88.0} }, symbol = { "I" },
						tooltiptxt = "", toMap = "Gnomeregan" },
				dtl8  = { text = "Gnomeregan Atelier", colour = AM_ORANGE, coords = { {62.46, 22.75} }, symbol = { "W" },
						tooltiptxt = "Requires Workshop Key", toMap = "Gnomeregan", leaveGap = 1  }
			},

			{	name = "Kazzak",			-- Seigneur Kazzak
				type = AM_TYP_RAID,
				displayname = "Seigneur Kazzak",
				filename = "AM_Kazzak_Map",
				location = "Les Terres Foudroy\195\169es : The Tainted Scar (32, 44)",
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
				dtl1 = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {79, 30} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "Seigneur Kazzak", colour = AM_RED, coords = { {42, 84} }, symbol = { "1" },
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

			{	name = "Les Dragons du Cauchemar: Bois de la P\195\169nombre",		-- Les Dragons du Cauchemar
				type = AM_TYP_RAID,
				displayname = "Les Dragons du Cauchemar: Bois de la P\195\169nombre",
				filename = "AM_Dragon_Duskwood_Map",
				location = "Bois de la P\195\169nombre : Twighlight Grove (46, 36)",
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
				dtl1 = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {48, 96} }, symbol = { AM_ENTRANCE },
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

			{	name = "Les Dragons du Cauchemar: Hinterlands",			-- Les Dragons du Cauchemar
				type = AM_TYP_RAID,
				displayname = "Les Dragons du Cauchemar: Hinterlands",
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
				dtl1 = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {37, 98} }, symbol = { AM_ENTRANCE },
						tooltiptxt = "", leaveGap = 1 },
				dtl2 = { text = "Rothos", colour = AM_RED, coords = { {52.5, 59} }, symbol = { "1" },
						tooltiptxt = "Lvl62 Elite  Draconien", special = AM_WANDERS },
				dtl3 = { text = "Dreamtracker", colour = AM_RED, coords = { {51, 49} }, symbol = { "2" },
						tooltiptxt = "Lvl62 Elite  Draconien" },
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

			{	name = "Les Dragons du Cauchemar: Feralas",			-- Les Dragons du Cauchemar
				type = AM_TYP_RAID,
				displayname = "Les Dragons du Cauchemar: Feralas",
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
						tooltiptxt = "Lvl62 Elite  Draconien\nPatrols round Island", special = AM_WANDERS },
				dtl2 = { text = "Lethlas", colour = AM_RED, coords = { {46, 68} }, symbol = { "2" },
						tooltiptxt = "Lvl62 Elite  Draconien\nPatrols round Island", special = AM_WANDERS },
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

			{	name = "Les Dragons du Cauchemar: Ashenvale",		-- Les Dragons du Cauchemar
				type = AM_TYP_RAID,
				displayname = "Les Dragons du Cauchemar: Ashenvale",
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
						tooltiptxt = "Lvl62 Elite  Draconien", special = AM_WANDERS },
				dtl2 = { text = "Dreamstalker", colour = AM_RED, coords = { {50.4, 57} }, symbol = { "2" },
						tooltiptxt = "Lvl62 Elite  Draconien" },
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
				dtl1  = { text = "Entr\195\169e (Orange)", colour = AM_ORANGE, coords = { {71, 12} }, symbol = { "X1" },
						tooltiptxt = "", toMap = "Maraudon"..AM_EXTERIOR },
				dtl2  = { text = "Entr\195\169e (Pourpre)", colour = AM_PURPLE, coords = { {85, 31} }, symbol = { "X2" },
						tooltiptxt = "", toMap = "Maraudon"..AM_EXTERIOR },
				dtl3  = { text = "Entr\195\169e (Portail)", colour = AM_GREEN, coords = { {36, 55} }, symbol = { "P" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {64, 44}, {39, 31} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl5  = { text = "Veng (Cinqui\195\168me Khan)", colour = AM_RED, coords = { {59, 6} }, symbol = { "1" },
						tooltiptxt = "", special = AM_WANDERS  },
				dtl6  = { text = "Noxxion", colour = AM_RED, coords = { {51, 3} }, symbol = { "2" },
						tooltiptxt = "Lvl48 Elite  El\195\169mentaire", lootid = "MaraNoxxion"  },
				dtl7  = { text = "Tranchefouet", colour = AM_RED, coords = { {36, 14} }, symbol = { "3" },
						tooltiptxt = "Lvl47 Elite Beast", lootid = "MaraRazorlash"  },
				dtl8  = { text = "Maraudos (Quatri\195\168me Khan)", colour = AM_RED, coords = { {64, 27} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl9  = { text = "Seigneur Vyletongue", colour = AM_RED, coords = { {53.3, 32} }, symbol = { "5" },
						tooltiptxt = "Lvl47 Elite  Humano\195\175de", lootid = "MaraLordVyletongue"  },
				dtl10 = { text = "Meshlok le Collecteur", colour = AM_RED, coords = { {43, 30} }, symbol = { "6" },
						tooltiptxt = "", special = AM_RARE, lootid = "MaraMeshlok"  },
				dtl11 = { text = "Celebras le Maudit", colour = AM_RED, coords = { {31, 35} }, symbol = { "7" },
						tooltiptxt = "Lvl49 Elite  Humano\195\175de", lootid = "MaraCelebras"  },
				dtl12 = { text = "Glissement de terrain", colour = AM_RED, coords = { {51.3, 60} }, symbol = { "8" },
						tooltiptxt = "Lvl50 Elite  El\195\169mentaire", lootid = "MaraLandslide"  },
				dtl13 = { text = "Artisan Gizlock", colour = AM_RED, coords = { {61, 74} }, symbol = { "9" },
						tooltiptxt = "Lvl50 Elite  Humano\195\175de", lootid = "MaraTinkererGizlock"  },
				dtl14 = { text = "Rotgrip", colour = AM_RED, coords = { {45, 82} }, symbol = { "10" },
						tooltiptxt = "Lvl50 Elite Beast", lootid = "MaraRotgrip"  },
				dtl15 = { text = "Princess Theradras", colour = AM_RED, coords = { {32, 85} }, symbol = { "11" },
						tooltiptxt = "Lvl51 Elite  El\195\169mentaire", lootid = "MaraPrincessTheradras" },
				dtl16 = { text = "Zaetar's Spirit", colour = AM_RED, coords = { {32, 85} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 }
			},

			{	name = "Maraudon"..AM_EXTERIOR,		-- Maraudon Ext\195\169rieur
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
				dtl1  = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {23, 59}  }, symbol = { "X" },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "Premier Khan", colour = AM_RED, coords = { {31, 45} }, symbol = { "1" },
						tooltiptxt = "" },
				dtl3  = { text = "Deuxi\195\168me Khan", colour = AM_RED, coords = { {24, 29} }, symbol = { "2" },
						tooltiptxt = "Mid level between pools" },
				dtl4  = { text = "Troisi\195\168me Khan", colour = AM_RED, coords = { {80, 46} }, symbol = { "3" },
						tooltiptxt = "" },
				dtl5  = { text = "Cavindra", colour = AM_GREEN, coords = { {48, 64} }, symbol = { "4" },
						tooltiptxt = "Quest Giver", leaveGap = 1 },
				dtl6  = { text = "Maraudon Portail", colour = AM_BLUE, coords = { {24, 47} }, symbol = { "P" },
						tooltiptxt = "Requires Scepter of Celebras" },
				dtl7  = { text = "Maraudon (Orange)", colour = AM_ORANGE, coords = { {84, 71} }, symbol = { "X1" },
						tooltiptxt = "Click to Open Maraudon Instance Map", toMap = "Maraudon" },
				dtl8  = { text = "Maraudon (Pourpre)", colour = AM_PURPLE, coords = { {39, 12.4} }, symbol = { "X2" },
						tooltiptxt = "Click to Open Maraudon Instance Map", toMap = "Maraudon" }
			},


			{	name = "C\197\147ur du Magma",			-- C\197\147ur du Magma
				type = AM_TYP_INSTANCE,
				displayname = "C\197\147ur du Magma",
				displayshort = "MC",
				filename = "MoltenCore",
				location = "Profondeurs de Blackrock",
				levels = "60+",
				players = "40",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {3, 20} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "Profondeurs de Blackrock", leaveGap = 1 },
				dtl2  = { text = "Lucifron", colour = AM_RED, coords = { {62, 35} }, symbol = { "1" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "MCLucifron" },
				dtl3  = { text = "Magmadar", colour = AM_RED, coords = { {70, 16} }, symbol = { "2" },
						tooltiptxt = "Boss Beast", lootid = "MCMagmadar" },
				dtl4  = { text = "Gehennas", colour = AM_RED, coords = { {13, 46} }, symbol = { "3" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "MCGehennas" },
				dtl5  = { text = "Garr", colour = AM_RED, coords = { {8, 71} }, symbol = { "4" },
						tooltiptxt = "Boss  El\195\169mentaire", lootid = "MCGarr"  },
				dtl6  = { text = "Shazzrah", colour = AM_RED, coords = { {44, 80} }, symbol = { "5" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "MCShazzrah"  },
				dtl7  = { text = "Baron Geddon", colour = AM_RED, coords = { {53, 68} }, symbol = { "6" },
						tooltiptxt = "Boss  El\195\169mentaire", lootid = "MCGeddon"  },
				dtl8  = { text = "Golemagg l'Incin\195\169rateur", colour = AM_RED, coords = { {66, 57} }, symbol = { "7" },
						tooltiptxt = "Boss Giant", lootid = "MCGolemagg"  },
				dtl9  = { text = "Messager de Sulfuron", colour = AM_RED, coords = { {87, 80} }, symbol = { "8" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "MCSulfuron"  },
				dtl10 = { text = "Majordome Executus", colour = AM_RED, coords = { {89, 62} }, symbol = { "9" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "MCMajordomo"  },
				dtl11 = { text = "Ragnaros", colour = AM_RED, coords = { {47, 52} }, symbol = { "10" },
						tooltiptxt = "Boss  El\195\169mentaire", lootid = "MCRagnaros", leaveGap = 2  },
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
				dtl1  = { text ="Aile d'abominations" , colour = AM_BLUE, coords = { {2, 15} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Patchwerk", colour = AM_RED, coords = { {22, 36} }, symbol = { "1" },
						tooltiptxt = "Aile d'abominations", lootid = "NAXPatchwerk" },
				dtl3  = { text = "Grobbulus", colour = AM_RED, coords = { {32, 29} }, symbol = { "2" },
						tooltiptxt = "Aile d'abominations", lootid = "NAXGrobbulus" },
				dtl4  = { text = "Gluth", colour = AM_RED, coords = { {20, 20} }, symbol = { "3" },
						tooltiptxt = "Aile d'abominations", lootid = "NAXGluth" },
				dtl5  = { text = "Thaddius", colour = AM_RED, coords = { {5, 4} }, symbol = { "4" },
						tooltiptxt = "Aile d'abominations", lootid = "NAXThaddius", leaveGap = 1  },
				dtl6  = { text = "Aile D'Araign\195\169es", colour = AM_BLUE, coords = { {67, 3} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl7  = { text = "Anub'Rekhan", colour = AM_RED, coords = { {45.2, 20} }, symbol = { "1" },
						tooltiptxt = "Aile D'Araign\195\169es", lootid = "NAXAnubRekhan"  },
				dtl8  = { text = "Grand Widow Faerlina", colour = AM_RED, coords = { {55, 16} }, symbol = { "2" },
						tooltiptxt = "Aile D'Araign\195\169es", lootid = "NAXGrandWidowFaerlina"  },
				dtl9  = { text = "Maexxna", colour = AM_RED, coords = { {74, 5} }, symbol = { "3" },
						tooltiptxt = "Aile D'Araign\195\169es", lootid = "NAXMaexxna", leaveGap = 1  },
				dtl10 = { text = "Aile du Fl\195\169au", colour = AM_BLUE, coords = { {79, 56} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl11 = { text = "Noth the Plaguebringer", colour = AM_RED, coords = { {47, 64} }, symbol = { "1" },
						tooltiptxt = "Aile du Fl\195\169au", lootid = "NAXNothderPlaguebringer"  },
				dtl12 = { text = "Helgan the Unclean", colour = AM_RED, coords = { {60, 58} }, symbol = { "2" },
						tooltiptxt = "Aile du Fl\195\169au", lootid = "NAXHeiganderUnclean"  },
				dtl13 = { text = "Loatheb", colour = AM_RED, coords = { {82, 47} }, symbol = { "3" },
						tooltiptxt = "Aile du Fl\195\169au", lootid = "NAXLoatheb", leaveGap = 1  },
				dtl14 = { text = "Aile de Chevaliers de la Mort", colour = AM_BLUE, coords = { {15, 79} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = ""  },
				dtl15 = { text = "Instructeur Razuvious", colour = AM_RED, coords = { {18, 58} }, symbol = { "1" },
						tooltiptxt = "Aile de Chevaliers de la Mort", lootid = "NAXInstructorRazuvious"  },
				dtl16 = { text = "Gothik le Collecteur", colour = AM_RED, coords = { {37, 64} }, symbol = { "2" },
						tooltiptxt = "Aile de Chevaliers de la Mort", lootid = "NAXGothikderHarvester" },
				dtl17 = { text = "Les Quatre Cavaliers", colour = AM_RED, coords = { {8, 75} }, symbol = { "3" },
						tooltiptxt = "Aile de Chevaliers de la Mort", lootid = "NAXTheFourHorsemen" },
				dtl18 = { text = "Thane Korth'azz", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl19 = { text = "Sir Zeliek", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl20 = { text = "Commandant Mograine", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "" },
				dtl21 = { text = "Dame Blaumeaux", colour = AM_RED, coords = { {8, 75} }, symbol = { " " },
						tooltiptxt = "", leaveGap = 1 },
				dtl22 = { text = "Repaire De Frostwyrm", colour = AM_BLUE, coords = { {74, 93} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "Repaire De Frostwyrm"  },
				dtl23 = { text = "Sapphiron", colour = AM_RED, coords = { {87, 91} }, symbol = { "1" },
						tooltiptxt = "Repaire De Frostwyrm", lootid = "NAXSapphiron"  },
				dtl24 = { text = "Kel'Thuzard", colour = AM_RED, coords = { {75, 79} }, symbol = { "2" },
						tooltiptxt = "Repaire De Frostwyrm", lootid = "NAXKelThuzard", leaveGap = 2  },
				dtl25 = { text = AM_TIER3_SET, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "T3SET", leaveGap = 1 },
				dtl26 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "NAXTrash", leaveGap = 1 }
			},

			{	name = "Repaire d'Onyxia",				-- Repaire d'Onyxia
				type = AM_TYP_INSTANCE,
				displayname = "Onyxia's Lair",
				filename = "OnyxiasLair",
				location = "Mar\195\169cage d\'Aprefange (52, 76)",
				levels = "60+",
				players = "40",
				prereq = "Requires Drakefire Amulet\n(Complete quest in UBRS to kill General Drakkisath)",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {9, 12} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Gardiens Onyxian", colour = AM_RED, coords = { {26, 41}, {29, 56}, {39, 68}, {50, 80} }, symbol = { "1" },
						tooltiptxt = "Lvl62 Elite  Draconien" },
				dtl3  = { text = "Oeufs", colour = AM_RED, coords = { {45, 40}, {51, 54}, {84, 41}, {79, 54} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl4  = { text = "Onyxia", colour = AM_RED, coords = { {66, 27} }, symbol = { "3" },
						tooltiptxt = "Boss  Draconien", lootid = "Onyxia", leaveGap = 1 }
			},

			{	name = "Gouffre de Ragefeu",			-- Gouffre de Ragefeu
				type = AM_TYP_INSTANCE,
				displayname = "Gouffre de Ragefeu",
				displayshort = "RFC",
				filename = "RagefireChasm",
				location = "Orgrimmar",
				levels = "13-18",
				players = "10",
				general = "",
				dtl1  = { text = "Entr\195\169e", colour = AM_GREEN, coords = { {72, 4} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "Maur Grimtotem", colour = AM_GOLD, coords = { {71, 53} }, symbol = { "1" },
						tooltiptxt = "Satchel Quest"  },
				dtl3  = { text = "Taragaman l'Affam\195\169", colour = AM_RED, coords = { {34, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl16 Elite Demon", lootid = "RFCTaragaman" },
				dtl4  = { text = "Jergosh l'Invocateur", colour = AM_RED, coords = { {24, 86} }, symbol = { "3" },
						tooltiptxt = "Lvl16 Elite  Humano\195\175de", lootid = "RFCJergosh" },
				dtl5  = { text = "Bazzalan", colour = AM_RED, coords = { {36, 91} }, symbol = { "4" },
						tooltiptxt = "Lvl16 Elite Demon", leaveGap = 1  }

			},

			{	name = "Souilles de Tranchebauge",			-- Souilles de Tranchebauge
				type = AM_TYP_INSTANCE,
				displayname = "Souilles de Tranchebauge",
				displayshort = "RFD",
				filename = "RazorfenDowns",
				location = "Les Tarides (48, 88)",
				levels = "38-43",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {4, 23} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {77, 45} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Tuten'kash", colour = AM_RED, coords = { {52, 36} }, symbol = { "1" },
						tooltiptxt = "Lvl40 Elite Mort-vivant", lootid = "RFDTutenkash" },
				dtl4  = { text = "Gong to spawn Tuten'kash", colour = AM_GREEN, coords = { {54, 30} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "Henry Stern,\n& Belnistrasz", colour = AM_BLUE, coords = { {76, 27} }, symbol = { "3" },
						tooltiptxt = "Learn how to make :\nGoldthorn Tea, \nMighty Troll's Blood Potion"  },
				dtl6  = { text = "Mordresh Oeil de Feu", colour = AM_RED, coords = { {87, 47} }, symbol = { "4" },
						tooltiptxt = "Lvl39 Elite Mort-vivant", lootid = "RFDMordreshFireEye"  },
				dtl7  = { text = "Glutton", colour = AM_RED, coords = { {19, 65} }, symbol = { "5" },
						tooltiptxt = "Lvl40 Elite  Humano\195\175de", lootid = "RFDGlutton"  },
				dtl8  = { text = "Ragglesnout", colour = AM_RED, coords = { {41, 67} }, symbol = { "6" },
						tooltiptxt = "Lvl40 Elite  Humano\195\175de", special = AM_RARE, lootid = "RFDRagglesnout"  },
				dtl9  = { text = "Amnennar le Porte-Froid", colour = AM_RED, coords = { {33, 59} }, symbol = { "0" },
						tooltiptxt = "Lvl41 Elite Mort-vivant", lootid = "RFDAmnennar", leaveGap = 1 },
				dtl10 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFDTrash", leaveGap = 1 }
			},

			{	name = "Kraal de Tranchebauge",			-- Kraal de Tranchebauge
				type = AM_TYP_INSTANCE,
				displayname = "Kraal de Tranchebauge",
				displayshort = "RFK",
				filename = "RazorfenKraul",
				location = "Les Tarides (42, 86)",
				levels = "28-33",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 71} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl2  = { text = "Roogug", colour = AM_RED, coords = { {73, 44} }, symbol = { "1" },
						tooltiptxt = "Lvl28 Elite  Humano\195\175de" },
				dtl3  = { text = "Aggem Thorncurse", colour = AM_RED, coords = { {88, 48} }, symbol = { "2" },
						tooltiptxt = "Lvl30 Elite  Humano\195\175de" },
				dtl4  = { text = "M\195\169dium Jargba", colour = AM_RED, coords = { {93, 38} }, symbol = { "3" },
						tooltiptxt = "Lvl30 Elite  Humano\195\175de", lootid = "RFKDeathSpeakerJargba" },
				dtl5  = { text = "Seigneur Brusquebroche", colour = AM_RED, coords = { {60, 29} }, symbol = { "4" },
						tooltiptxt = "Lvl32 Elite  Humano\195\175de", lootid = "RFKOverlordRamtusk"  },
				dtl6 = { text = "Implorateur de la terre Halmgar", colour = AM_RED, coords = { {49, 37} }, symbol = { "5" },
						tooltiptxt = "Lvl32 Elite  Humano\195\175de", special = AM_RARE, lootid = "RFKEarthcallerHalmgar"  },
				dtl7 = { text = "Willix l'Importateur,\n& Heralath Fallowbrook", colour = AM_BLUE, coords = { {35, 33} }, symbol = { "6" },
						tooltiptxt = ""  },
				dtl8  = { text = "Charlga Trancheflanc", colour = AM_RED, coords = { {21, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl33 Elite  Humano\195\175de", lootid = "RFKCharlgaRazorflank"  },
				dtl9  = { text = "Chasseur Aveugle", colour = AM_RED, coords = { {6, 32} }, symbol = { "8" },
						tooltiptxt = "Lvl32 Elite Beast\n& Chest", special = AM_RARE, lootid = "RFKBlindHunter"  },
				dtl10  = { text = "Ward Sealing Agathelos", colour = AM_GREEN, coords = { {4, 54} }, symbol = { "9" },
						tooltiptxt = ""  },
				dtl11  = { text = "Agathelos l'Enrag\195\169", colour = AM_RED, coords = { {11, 65} }, symbol = { "10" },
						tooltiptxt = "Lvl33 Elite Beast", lootid = "RFKAgathelos", leaveGap = 1  },
				dtl12 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "RFKTrash", leaveGap = 1 }
			},

			{	name = "Ruines d'Ahn'Qiraj",		-- Ruines d'Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "Ruines d'Ahn'Qiraj",
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
				dtl3  = { text ="G\195\169n\195\169ral de division Andorov,\n&Quatre \195\169lites kaldorei", colour = AM_RED, coords = { {55, 29} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20Andorov" },
				dtl4  = { text = "Capitaine Qeez", colour = AM_RED, coords = { {52.1, 46.9} }, symbol = { "2" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN" },
				dtl5  = { text = "Capitaine Tuubid", colour = AM_RED, coords = { {55.4, 46.9} }, symbol = { "3" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN" },
				dtl6  = { text = "Capitaine Drenn", colour = AM_RED, coords = { {57.2, 47.9} }, symbol = { "4" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
				dtl7  = { text = "Capitaine Xurrem", colour = AM_RED, coords = { {59.2, 49.2} }, symbol = { "5" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
				dtl8  = { text = "Major Yeggeth", colour = AM_RED, coords = { {61.3, 50.3} }, symbol = { "6" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
				dtl9  = { text = "Major Pakkong", colour = AM_RED, coords = { {60, 53.4} }, symbol = { "7" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
				dtl10  = { text = "Colonel Zerran", colour = AM_RED, coords = { {56, 51.2} }, symbol = { "8" },
						tooltiptxt = "Lvl63 Elite", lootid = "AQ20CAPTIAN"  },
				dtl11 = { text = "G\195\169n\195\169ral Rajaxx", colour = AM_RED, coords = { {52.2, 49.5} }, symbol = { "9" },
						tooltiptxt = "Boss", lootid = "AQ20Rajaxx"  },
				dtl12 = { text = "Moam", colour = AM_RED, coords = { {13, 31} }, symbol = { "10" },
						tooltiptxt = "Boss", lootid = "AQ20Moam"  },
				dtl13 = { text = "Buru Grandgosier", colour = AM_RED, coords = { {83, 55} }, symbol = { "11" },
						tooltiptxt = "Boss", lootid = "AQ20Buru"  },
				dtl14 = { text = "Pi\195\168ce s\195\187re", colour = AM_GREEN, coords = { {65, 70} }, symbol = { "12" },
						tooltiptxt = ""  },
				dtl15 = { text = "Ayamiss le chasseur", colour = AM_RED, coords = { {67, 91} }, symbol = { "13" },
						tooltiptxt = "Boss", lootid = "AQ20Ayamiss"  },
				dtl16 = { text = "Ossirian l'Intouch\195\169", colour = AM_RED, coords = { {29, 73} }, symbol = { "14" },
						tooltiptxt = "Boss", lootid = "AQ20Ossirian", leaveGap = 2  },
				dtl17 = { text = "Livres de Classe", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20ClassBooks" },
				dtl18 = { text = AM_ENCHANTS, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQEnchants" },
				dtl19 = { text = "AQ20"..AM_CLASS_SETS, colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "AQ20SET", leaveGap = 1 }
			},

			{	name = "Monast\195\168re \195\169carlate",			-- Monast\195\168re \195\169carlate
				type = AM_TYP_INSTANCE,
				displayname = "Monast\195\168re \195\169carlate",
				displayshort = "SM",
				filename = "ScarletMonastery",
				location = "Clairi\195\168re de Tirisfal (83.6, 34)",
				levels = "30-40",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "Cimeti\195\168re - Entr\195\169e", colour = AM_GREEN, coords = { {61, 97} }, symbol = { "G" },
						tooltiptxt = "" },
				dtl2  = { text = "Ironspine", colour = AM_RED, coords = { {21, 88} }, symbol = { "1" },
						tooltiptxt = "Lvl33 Elite Mort-vivant\nCimeti\195\168re", special = AM_RARE, lootid = "SMIronspine"  },
				dtl3  = { text = "Azshir le Sans-sommeil", colour = AM_RED, coords = { {5, 88} }, symbol = { "2" },
						tooltiptxt = "Lvl33 Elite Mort-vivant\nCimeti\195\168re", special = AM_RARE, lootid = "SMAzshir"  },
				dtl4  = { text = "Champion Mort", colour = AM_RED, coords = { {8, 80} }, symbol = { "3" },
						tooltiptxt = "Lvl33 Elite Mort-vivant\nCimeti\195\168re", special = AM_RARE, lootid = "SMFallenChampion" },
				dtl5  = { text = "Mage de Sang Thalnos", colour = AM_RED, coords = { {5, 77} }, symbol = { "4" },
						tooltiptxt = "Lvl34 Elite Mort-vivant\nCimeti\195\168re", lootid = "SMBloodmageThalnos" },
				dtl6  = { text = "Biblioth\195\168que - Entr\195\169e", colour = AM_GREEN, coords = { {56, 74} }, symbol = { "L" },
						tooltiptxt = "" },
				dtl7  = { text = "Maitre-Chien Loksey", colour = AM_RED, coords = { {66.1, 95} }, symbol = { "5" },
						tooltiptxt = "Lvl34 Elite  Humano\195\175de\nBiblioth\195\168que", lootid = "SMHoundmasterLoksey"  },
				dtl8  = { text = "Arcaniste Doan", colour = AM_RED, coords = { {95.1, 92} }, symbol = { "6" },
						tooltiptxt = "Lvl37 Elite  Humano\195\175de\nBiblioth\195\168que", lootid = "SMDoan", leaveGap = 1  },
				dtl9  = { text = "Armurie - Entr\195\169e", colour = AM_GREEN, coords = { {54, 65} }, symbol = { "A" },
						tooltiptxt = "" },
				dtl10 = { text = "Herod", colour = AM_RED, coords = { {74.8, 6.2} }, symbol = { "7" },
						tooltiptxt = "Lvl40 Elite  Humano\195\175de\nArmurie", lootid = "SMHerod", leaveGap = 1  },
				dtl11 = { text = "Cath\195\169drale - Entr\195\169e", colour = AM_GREEN, coords = { {37, 65} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl12 = { text = "Grand Inquisiteur Fairbanks", colour = AM_RED, coords = { {31, 11} }, symbol = { "8" },
						tooltiptxt = "Lvl40 Elite  Humano\195\175de\nCath\195\169drale", lootid = "SMFairbanks"  },
				dtl13 = { text = "Commandant Mograine", colour = AM_RED, coords = { {23.4, 12} }, symbol = { "9" },
						tooltiptxt = "Lvl42 Elite  Humano\195\175de\nCath\195\169drale", lootid = "SMMograine"  },
				dtl14 = { text = "Grand Inquisiteur Whitemane", colour = AM_RED, coords = { {23.4, 4.4} }, symbol = { "10" },
						tooltiptxt = "Lvl42 Elite  Humano\195\175de\nCath\195\169drale", lootid = "SMWhitemane", leaveGap = 2  },
				dtl15 = { text = "Set : Chain of the Scarlet Crusade", colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "6 Piece", lootid = "SMScarletSET", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "SMTrash", leaveGap = 1 }
			},

			{	name = "Ahn'Qiraj",			-- Ahn'Qiraj
				type = AM_TYP_INSTANCE,
				displayname = "Le temple d'Ahn'Qiraj",
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
				dtl4  = { text = "Proph\195\168te Skeram", colour = AM_RED, coords = { {19, 41} }, symbol = { "1" },
						tooltiptxt = "Boss\nExt\195\169rieur", lootid = "AQ40Skeram" },
				dtl5  = { text = "Vem & Co", colour = AM_RED, coords = { {15, 52} }, symbol = { "2" },
						tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Vem" },
				dtl6  = { text = "Garde de guerre Sartura", colour = AM_RED, coords = { {40, 30} }, symbol = { "3" },
						tooltiptxt = "Boss", lootid = "AQ40Sartura" },
				dtl7  = { text = "Fankriss l'Inflexible", colour = AM_RED, coords = { {67, 14} }, symbol = { "4" },
						tooltiptxt = "Boss", lootid = "AQ40Fankriss"  },
				dtl8  = { text = "Viscidus", colour = AM_RED, coords = { {82, 7} }, symbol = { "5" },
						tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Viscidus"  },
				dtl9  = { text = "Princesse Huhuran", colour = AM_RED, coords = { {41, 49} }, symbol = { "6" },
						tooltiptxt = "Boss", lootid = "AQ40Huhuran"  },
				dtl10 = { text = "Empereurs Jumeaux. Vek'lor & Vek'nilash", colour = AM_RED, coords = { {72, 67} }, symbol = { "7" },
						tooltiptxt = "Boss", lootid = "AQ40Emperors"  },
				dtl11 = { text = "Ouro", colour = AM_RED, coords = { { 22, 87 } }, symbol = { "8" },
						tooltiptxt = "Boss", special = AM_OPTIONAL, lootid = "AQ40Ouro" },
				dtl12 = { text = "Oeil de C'Thun", colour = AM_RED, coords = { {25, 50} }, symbol = { "9" },
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

			{	name = "Les Mortemines",			-- Les Mortemines
				type = AM_TYP_INSTANCE,
				displayname = "Les Mortemines",
				filename = "TheDeadmines",
				location = "Marche de l'Ouest (42, 72)",
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
						tooltiptxt = "Lvl19 Elite  Humano\195\175de", lootid = "VCRhahkZor" },
				dtl5  = { text = "Mineur Johnson", colour = AM_RED, coords = { {41, 50} }, symbol = { "2" },
						tooltiptxt = "Lvl19 Elite  Humano\195\175de", lootid = "VCMinerJohnson", special = AM_RARE  },
				dtl6  = { text = "Sneed", colour = AM_RED, coords = { {37, 77} }, symbol = { "3" },
						tooltiptxt = "Lvl20 Elite Mechanical (in Shredder)", lootid = "VCSneed"  },
				dtl7  = { text = "Gilnid", colour = AM_RED, coords = { {48.8, 60.2} }, symbol = { "4" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de", lootid = "VCGilnid"  },
				dtl8  = { text = "Poudre \195\160 canon D\195\169fias", colour = AM_GREEN, coords = { {55.6, 39} }, symbol = { "5" },
						tooltiptxt = "...Blast Powder to blow the doors"  },
				dtl9  = { text = "Mr. Smite", colour = AM_RED, coords = { {76, 31} }, symbol = { "6" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de", lootid = "VCMrSmite"  },
				dtl10 = { text = "Cookie", colour = AM_RED, coords = { {81, 36} }, symbol = { "7" },
						tooltiptxt = "", lootid = "VCCookie"  },
				dtl11 = { text = "Captain Greenskin", colour = AM_RED, coords = { {76, 37} }, symbol = { "8" },
						tooltiptxt = "Lvl21 Elite  Humano\195\175de", lootid = "VCCaptainGreenskin"  },
				dtl12 = { text = "Edwin VanCleef", colour = AM_RED, coords = { {79, 37} }, symbol = { "9" },
						tooltiptxt = "Lvl21 Elite  Humano\195\175de", lootid = "VCVanCleef", leaveGap = 2 },
				dtl13 = { text = "Set : Defias Leather", colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "VCDefiasSET", leaveGap = 1 }
			},

			{	name = "La Prison",			-- La Prison
				type = AM_TYP_INSTANCE,
				displayname = "La Prison",
				filename = "TheStockade",
				location = "Cit\195\169 de Stormwind",
				levels = "24-32",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {50, 74} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {69, 60}, {75, 40}, {26, 57}, {31, 36}, {18, 29} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Targorr le Terrifiant", colour = AM_RED, coords = { {58, 63}, {41, 55}, {50, 37}, {27, 50} }, symbol = { "1" },
						tooltiptxt = "Lvl24 Elite  Humano\195\175de", special = AM_VARIES },
				dtl4  = { text = "Kam Deepfury", colour = AM_RED, coords = { {73, 43} }, symbol = { "2" },
						tooltiptxt = "Lvl27 Elite  Humano\195\175de", lootid = "SWStKamDeepfury" },
				dtl5  = { text = "Hamhock", colour = AM_RED, coords = { {85, 56} }, symbol = { "3" },
						tooltiptxt = "Lvl28 Elite  Humano\195\175de"  },
				dtl6  = { text = "Bazil Thredd", colour = AM_RED, coords = { {95, 62} }, symbol = { "4" },
						tooltiptxt = ""  },
				dtl7  = { text = "Dextren Ward", colour = AM_RED, coords = { {15, 40} }, symbol = { "5" },
						tooltiptxt = "Lvl26 Elite  Humano\195\175de"  },
				dtl8  = { text = "Bruegal Ironknuckle", colour = AM_RED, coords = { {22, 54} }, symbol = { "6" },
						tooltiptxt = "Lvl26 Elite  Humano\195\175de", special = AM_RARE, lootid = "SWStBruegalIronknuckle", leaveGap = 1 }
			},

			{	name = "Le temple d'Atal'Hakkar",			-- Le temple d'Atal'Hakkar
				type = AM_TYP_INSTANCE,
				displayname = "Le Temple Englouti",
				displayshort = "ST",
				filename = "TheSunkenTemple",
				location = "Marais des Chagrins (70, 53)",
				levels = "45-60",
				players = "10",
				prereq = "",
				general = "Le temple d'Atal'Hakkar",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {62, 7} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Escaliers \195\160 Niveau Plus bas", colour = AM_GREEN, coords = { {54, 11.3}, {13.9, 47} }, symbol = { "SL" },
						tooltiptxt = "" },
				dtl3  = { text = "Escaliers", colour = AM_GREEN, coords = { {69, 11.3} }, symbol = { "SM" },
						tooltiptxt = "", leaveGap = 1 },
				dtl4  = { text = "Escaliers \195\160 Niveau supérieur", colour = AM_BLUE, coords = { {52, 18}, {69, 18}, {52, 48}, {69, 48} }, symbol = { AM_STAIRS_SYMBOL },
						tooltiptxt = "" },
				dtl5  = { text = "Troll Minibosses (Niveau supérieur)", colour = AM_RED, coords = { {55, 23}, {66, 23}, {72, 33}, {49, 33}, {54, 43}, {66, 43} }, symbol = { "T1", "T2", "T3", "T4", "T5", "T6" },
						tooltiptxt = "Kill all, then Jammal'an\nto fight Eranikus", lootid = "STTrollMinibosses", leaveGap = 1 },
				dtl6  = { text = "Statues (Inf\195\169rieur level)", colour = AM_ORANGE, coords = { {22, 82}, {22, 64}, {13, 77}, {30, 77}, {13, 68}, {30, 68} }, symbol = { "S1", "S2", "S3", "S4", "S5", "S6" },
						tooltiptxt = "Activate in numerical order to\nsummon Atal'alarion" },
				dtl7  = { text = "Autel d'Hakkar", colour = AM_ORANGE, coords = { {22, 74} }, symbol = { "1" },
						tooltiptxt = ""  },
				dtl8  = { text = "Atal'alarion", colour = AM_RED, coords = { {22, 71} }, symbol = { "2" },
						tooltiptxt = "Lvl50 Elite  Humano\195\175de", lootid = "STAtalalarion", leaveGap = 1  },
				dtl9  = { text = "Fauche-r\195\170ve", colour = AM_RED, coords = { {58, 33} }, symbol = { "3" },
						tooltiptxt = "Lvl53 Elite  Draconien", lootid = "STDreamscythe"  },
				dtl10 = { text = "Tisserand", colour = AM_RED, coords = { {62, 33} }, symbol = { "4" },
						tooltiptxt = "Lvl51 Elite  Draconien", lootid = "STWeaver"  },
				dtl11 = { text = "Avatar d'Hakkar", colour = AM_RED, coords = { {32, 33} }, symbol = { "5" },
						tooltiptxt = "Lvl50 Elite  Draconien", lootid = "STAvatarofHakkar"  },
				dtl12 = { text = "Jammal'an le Proph\195\168te", colour = AM_RED, coords = { {88, 27} }, symbol = { "6" },
						tooltiptxt = "Lvl54 Elite  Humano\195\175de", lootid = "STJammalan"  },
				dtl13 = { text = "Ogom le Corrompu", colour = AM_RED, coords = { {88, 31} }, symbol = { "7" },
						tooltiptxt = "Lvl53 Elite Mort-vivant", lootid = "STOgom"  },
				dtl14 = { text = "Morphaz", colour = AM_RED, coords = { {59, 62} }, symbol = { "8" },
						tooltiptxt = "Lvl52 Elite  Draconien", lootid = "STMorphaz"  },
				dtl15 = { text = "Hazzas", colour = AM_RED, coords = { {62, 62} }, symbol = { "9" },
						tooltiptxt = "Lvl53 Elite  Draconien", lootid = "STHazzas"  },
				dtl16 = { text = "Ombre d'Eranikus", colour = AM_RED, coords = { {80, 62} }, symbol = { "10" },
						tooltiptxt = "Lvl55 Elite  Draconien", lootid = "STEranikus"  },
				dtl17 = { text = "Essence d'Eranikus enchain\195\169e", colour = AM_ORANGE, coords = { {85, 57} }, symbol = { "11" },
						tooltiptxt = "", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "STTrash", leaveGap = 1 }
			},

			{	name = "Uldaman",			-- Uldaman
				type = AM_TYP_INSTANCE,
				displayname = "Uldaman",
				filename = "Uldaman",
				location = "Terres ingrates (44, 12)",
				levels = "35-50",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = "Avant-Entr\195\169e", colour = AM_GREEN, coords = { {89, 73.1} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", toMap = "Uldaman"..AM_EXTERIOR },
				dtl2  = { text = "Arri\195\168re-Entr\195\169e", colour = AM_GREEN, coords = { {21, 71} }, symbol = { "XR" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Baelog", colour = AM_RED, coords = { {73, 93} }, symbol = { "1" },
						tooltiptxt = "Lvl41 Elite" },
				dtl4  = { text = "Restes de Paladin", colour = AM_ORANGE, coords = { {62.8, 63.2} }, symbol = { "2" },
						tooltiptxt = "" },
				dtl5  = { text = "Revelosh", colour = AM_RED, coords = { {64, 73.3} }, symbol = { "3" },
						tooltiptxt = "Lvl40 Elite  Humano\195\175de", lootid = "UldRevelosh"  },
				dtl6  = { text = "Ironaya", colour = AM_RED, coords = { {38, 75} }, symbol = { "4" },
						tooltiptxt = "Boss Giant", lootid = "UldIronaya"  },
				dtl7  = { text = "Annora (Maitre Enchanteur)", colour = AM_BLUE, coords = { {56, 61} }, symbol = { "5" },
						tooltiptxt = ""  },
				dtl8  = { text = "Sentinelle d'obsidienne", colour = AM_RED, coords = { {24.4, 62} }, symbol = { "6" },
						tooltiptxt = "Lvl42 Elite Mechanical"  },
				dtl9  = { text = "Garde en pierre Antique", colour = AM_RED, coords = { {54.7, 43} }, symbol = { "7" },
						tooltiptxt = "Lvl44 Elite  El\195\169mentaire", lootid = "UldAncientStoneKeeper"  },
				dtl10 = { text = "Galgann Firehammer", colour = AM_RED, coords = { {21, 31} }, symbol = { "8" },
						tooltiptxt = "Boss  Humano\195\175de", lootid = "UldGalgannFirehammer"  },
				dtl11 = { text = "Grimlok", colour = AM_RED, coords = { {17, 19} }, symbol = { "9" },
						tooltiptxt = "Lvl45 Elite  Humano\195\175de", lootid = "UldGrimlok"  },
				dtl12 = { text = "Archaedas", colour = AM_RED, coords = { {45.2, 14.4} }, symbol = { "10" },
						tooltiptxt = "Boss Giant\nNiveau plus bas", lootid = "UldArchaedas"  },
				dtl13 = { text = "Les Disques de Norgannon", colour = AM_ORANGE, coords = { {39.7, 6.2} }, symbol = { "11" },
						tooltiptxt = "Niveau supérieur"  },
				dtl14 = { text = "Ancient Treasure", colour = AM_ORANGE, coords = { {42.3, 4.9} }, symbol = { "12" },
						tooltiptxt = "Niveau plus bas", leaveGap = 1 },
				dtl15 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "UldTrash", leaveGap = 1 }
			},

			{	name = "Uldaman"..AM_EXTERIOR,		-- Uldaman Exterior
				type = AM_TYP_RAID,
				displayname = AM_EXTERIOR.." - Uldaman",
				filename = "UldamanExt",
				location = "Terres ingrates (44, 12)",
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
						tooltiptxt = "Quests", leaveGap = 1 },
				dtl3  = { text = "Uldaman", colour = AM_GREEN, coords = { {30.5, 23} }, symbol = { "U" },
						tooltiptxt = "", toMap = "Uldaman", leaveGap = 1 }
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
				dtl4  = { text = "Seigneur Cobrahn", colour = AM_RED, coords = { {14, 55} }, symbol = { "2" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de", lootid = "WCLordCobrahn" },
				dtl5  = { text = "Dame Anacondra", colour = AM_RED, coords = { {39, 35} }, symbol = { "3" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de", lootid = "WCLadyAnacondra" },
				dtl6  = { text = "Kresh", colour = AM_RED, coords = { {45, 42} }, symbol = { "4" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de", lootid = "WCKresh"  },
				dtl7  = { text = "Dragon f\195\169\195\169rique D\195\169viant", colour = AM_RED, coords = { {63, 43} }, symbol = { "5" },
						tooltiptxt = "Lvl20 Elite  Draconien", lootid = "WCDeviateFaerieDragon", special = AM_RARE },
				dtl8  = { text = "Seigneur Pythas", colour = AM_RED, coords = { {86, 34} }, symbol = { "6" },
						tooltiptxt = "Lvl22 Elite  Humano\195\175de", lootid = "WCLordPythas"  },
				dtl9  = { text = "Skum", colour = AM_RED, coords = { {93, 69} }, symbol = { "7" },
						tooltiptxt = "Lvl21 Elite  Humano\195\175de", lootid = "WCSkum"  },
				dtl10  = { text = "Seigneur Serpentis", colour = AM_RED, coords = { {60, 52} }, symbol = { "8" },
						tooltiptxt = "Lvl22 Elite  Humano\195\175de\nNiveau supérieur", lootid = "WCLordSerpentis"  },
				dtl11 = { text = "Verdan the Everliving", colour = AM_RED, coords = { {56, 48} }, symbol = { "9" },
						tooltiptxt = "Lvl24 Elite  El\195\169mentaire\nNiveau supérieur", lootid = "WCVerdan"  },
				dtl12 = { text = "Mutanus the Devourer", colour = AM_RED, coords = { {29.9, 23.9} }, symbol = { "10" },
						tooltiptxt = "Lvl22 Elite  Humano\195\175de\nTriggered Spawn", lootid = "WCMutanus"  },
				dtl13 = { text = "Naralex", colour = AM_RED, coords = { {32.4, 25.4} }, symbol = { "11" },
						tooltiptxt = "Lvl25 Elite  Humano\195\175de", leaveGap = 2  },
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
						tooltiptxt = "Lvl45 Elite  Humano\195\175de", special = AM_RARE.." "..AM_WANDERS, lootid = "ZFZerillis" },
				dtl3  = { text = "Sandarr Dunereaver", colour = AM_RED, coords = { {55, 59} }, symbol = { "2" },
						tooltiptxt = "Lvl45 Elite  Humano\195\175de", special = AM_RARE },
				dtl4  = { text = "Hydromancienne Velratha", colour = AM_RED, coords = { {34, 43} }, symbol = { "3" },
						tooltiptxt = "Lvl46 Elite  Humano\195\175de" },
				dtl5  = { text = "Gahz'rilla", colour = AM_RED, coords = { {37, 46} }, symbol = { "4" },
						tooltiptxt = "Lvl46 Elite Beast", lootid = "ZFGahzrilla"  },
				dtl6  = { text = "Dustwraith", colour = AM_RED, coords = { {32, 46} }, symbol = { "5" },
						tooltiptxt = "Lvl45 Elite  Humano\195\175de", special = AM_RARE, lootid = "ZFDustwraith"  },
				dtl7  = { text = "Antu'sul", colour = AM_RED, coords = { {80, 35} }, symbol = { "6" },
						tooltiptxt = "Lvl48 Elite  Humano\195\175de", lootid = "ZFAntusul"  },
				dtl8  = { text = "Theka le Martyr", colour = AM_RED, coords = { {67, 33} }, symbol = { "7" },
						tooltiptxt = "Lvl46 Elite  Humano\195\175de"  },
				dtl9  = { text = "Sorcier-docteur Zum'rah", colour = AM_RED, coords = { {53, 23} }, symbol = { "8" },
						tooltiptxt = "Lvl46 Elite  Humano\195\175de", lootid = "ZFWitchDoctorZumrah"  },
				dtl10 = { text = "H\195\169ros Mort Zul'Farrak", colour = AM_RED, coords = { {51, 27} }, symbol = { "9" },
						tooltiptxt = "Lvl46 Elite  Humano\195\175de"  },
				dtl11 = { text = "Pr\195\170tre des ombres Sezz'ziz", colour = AM_RED, coords = { {36, 26} }, symbol = { "10" },
						tooltiptxt = "Lvl47 Elite  Humano\195\175de", lootid = "ZFSezzziz" },
				dtl12 = { text = "Nekrum M\195\162chetripes", colour = AM_RED, coords = { {36, 26} }, symbol = { " " },
						tooltiptxt = "Lvl46 Elite Mort-vivant"  },
				dtl13 = { text = "Sergeant Bly", colour = AM_ORANGE, coords = { {26, 26} }, symbol = { "11" },
						tooltiptxt = "Divino-matic Rod Quest\nHostile/Friendly depending on\nfaction and actions taken" },
				dtl14 = { text = "Ruuzlu", colour = AM_RED, coords = { {51, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl46 Elite  Humano\195\175de"  },
				dtl15 = { text = "Chef Ukorz Scalpessable", colour = AM_RED, coords = { {55, 42} }, symbol = { "13" },
						tooltiptxt = "Lvl48 Elite  Humano\195\175de", lootid = "ZFChiefUkorzSandscalp", leaveGap = 1 },
				dtl16 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZFTrash", leaveGap = 1 }
			},

			{	name = "Zul'Gurub",			-- Zul'Gurub
				type = AM_TYP_INSTANCE,
				displayname = "Zul'Gurub",
				displayshort = "ZG",
				filename = "ZulGurub",
				location = "Vall\195\169e de Strangleronce (54, 17)",
				levels = "60+",
				players = "20",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {12, 50} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Eaux troubles et agit\195\169es", colour = AM_BLUE, coords = { {33, 41}, {47, 48}, {57, 47}, {60, 32}, {47, 30} }, symbol = { "W" },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Grande Pr\195\170tresse Jeklik", colour = AM_RED, coords = { {34, 78} }, symbol = { "1" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Chauve-souris)", lootid = "ZGJeklik" },
				dtl4  = { text = "Grand Pr\195\170tre Venoxis", colour = AM_RED, coords = { {56, 57} }, symbol = { "2" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Serpent)", lootid = "ZGVenoxis" },
				dtl5  = { text = "Grande Pr\195\170tresse Mar'li", colour = AM_RED, coords = { {48, 85} }, symbol = { "3" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Araign\195\169e)", lootid = "ZGMarli"  },
				dtl6  = { text = "Seigneur sanglant Mandokir", colour = AM_RED, coords = { {76, 73} }, symbol = { "4" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Raptor)"..AM_OPTIONAL, lootid = "ZGMandokir"  },
				dtl7  = { text = "Fronti\195\168re de la folie", colour = AM_RED, coords = { {72, 47} }, symbol = { "5" },
						tooltiptxt = "", special = AM_OPTIONAL  },
				dtl8  = { text = "Gri'lek, du Sang de fer", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "Boss  Mort-vivant", lootid = "ZGGrilek"  },
				dtl9  = { text = "Hazza'rah, Tisser\195\170ve", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "Boss  Mort-vivant", lootid = "ZGHazzarah"  },
				dtl10 = { text = "Renataki, des Mille lames", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "Boss  Mort-vivant", lootid = "ZGRenataki"  },
				dtl11 = { text = "Wushoolay, la Sorci\195\168re des temp\195\170tes", colour = AM_RED, coords = { {72, 47} }, symbol = { " " },
						tooltiptxt = "Boss  Mort-vivant", lootid = "ZGWushoolay"  },
				dtl12 = { text = "Gahz'ranka", colour = AM_RED, coords = { {66, 33} }, symbol = { "6" },
						tooltiptxt = "Boss  Humano\195\175de", special = AM_OPTIONAL, lootid = "ZGGahzranka"  },
				dtl13 = { text = "Grand Pr\195\170tre Thekal", colour = AM_RED, coords = { {80, 32} }, symbol = { "7" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Tigre)", lootid = "ZGThekal" },
				dtl14 = { text = "Grande Pr\195\170tresse Arlokk", colour = AM_RED, coords = { {49, 16} }, symbol = { "8" },
						tooltiptxt = "Boss  Humano\195\175de", special = "(Panth\195\168re)", lootid = "ZGArlokk"  },
				dtl15 = { text = "Jin'do le mal\195\169ficieur", colour = AM_RED, coords = { {20, 18} }, symbol = { "9" },
						tooltiptxt = "Boss  Humano\195\175de", special = "( Mort-vivant)"..AM_OPTIONAL, lootid = "ZGJindo" },
				dtl16 = { text = "Hakkar", colour = AM_RED, coords = { {54, 40} }, symbol = { "10" },
						tooltiptxt = "Boss Dragon", lootid = "ZGHakkar", leaveGap = 2 },
				dtl17 = { text = AM_MOB_LOOT, colour = AM_PURPLE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "ZGTrash", leaveGap = 1 },
				dtl18 = { text = "ZG"..AM_CLASS_SETS.." 3", colour = AM_ORANGE, coords = { {0, 0} }, symbol = { " " },
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
				location = "Maleterres de l'Ouest (69, 73)",
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
				dtl5  = { text = "R\195\169gisseur sanglant de Kirtonos", colour = AM_RED, coords = { {54, 32} }, symbol = { "1" },
						tooltiptxt = "Lvl61 Elite Demon", lootid = "SCHOLOBloodSteward"  },
				dtl6  = { text = "Kirtonos le H\195\169rault", colour = AM_RED, coords = { {30, 5} }, symbol = { "2" },
						tooltiptxt = "", lootid = "SCHOLOKirtonostheHerald" },
				dtl7  = { text = "Jandice Barov", colour = AM_RED, coords = { {96, 8.5} }, symbol = { "3" },
						tooltiptxt = "Lvl61 Elite Mort-vivant", lootid = "SCHOLOJandiceBarov"  },
				dtl8  = { text = "Rattlegore", colour = AM_RED, coords = { {10, 41} }, symbol = { "4" },
						tooltiptxt = "Lvl61 Elite Mort-vivant\nInf\195\169rieur level\nDrops key to Viewing Room", lootid = "SCHOLORattlegore"  },
				dtl9  = { text = "Chevalier de la mort Darkreaver", colour = AM_RED, coords = { {10, 41} }, symbol = { " " },
						tooltiptxt = "Lvl62 Elite Mort-vivant\nPaladins/Shaman Quest to Summon", lootid = "SCHOLODeathKnight" },
				dtl10  = { text = "Marduk Noir\195\169tang", colour = AM_BLUE, coords = { {23.7, 42} }, symbol = { "5" },
						tooltiptxt = "Lvl58 Elite\nAggro by placing Dawn's Gambit\nin Viewing room", lootid = "SCHOLOMarduk"  },
				dtl11 = { text = "Vectus", colour = AM_BLUE, coords = { {27.2, 42} }, symbol = { "6" },
						tooltiptxt = "Lvl60 Elite Mort-vivant\nAggro by placing Dawn's Gambit\nin Viewing room", lootid = "SCHOLOVectus"  },
				dtl12 = { text = "Ras Murmegivre", colour = AM_RED, coords = { {18, 87} }, symbol = { "8" },
						tooltiptxt = "Lvl62 Elite Mort-vivant", lootid = "SCHOLORasFrostwhisper"  },
				dtl13 = { text = "Kormok", colour = AM_RED, coords = { {18, 80} }, symbol = { "9" },
						tooltiptxt = "Lvl60 Elite", lootid = "SCHOLOKormok" },
				dtl14 = { text = "Instructor Malicia", colour = AM_RED, coords = { {44.5, 94} }, symbol = { "10" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", lootid = "SCHOLOInstructorMalicia"  },
				dtl15 = { text = "Docteur Theolen Krastinov", colour = AM_RED, coords = { {64, 74.2} }, symbol = { "11" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", lootid = "SCHOLODoctorTheolenKrastinov"  },
				dtl16 = { text = "Gardien du Savoir Polkelt", colour = AM_RED, coords = { {44.8, 55.2} }, symbol = { "12" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "SCHOLOLorekeeperPolkelt"  },
				dtl17 = { text = "Le Voracien", colour = AM_RED, coords = { {75.8, 92} }, symbol = { "13" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "SCHOLOTheRavenian"  },
				dtl18 = { text = "Seigneur Alexei Barov", colour = AM_RED, coords = { {96.2, 74.5} }, symbol = { "14" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "SCHOLOLordAlexeiBarov"  },
				dtl19 = { text = "Dame Illucia Barov", colour = AM_RED, coords = { {75.6, 54} }, symbol = { "15" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "SCHOLOLadyIlluciaBarov" },
				dtl20 = { text = "Sombre Maitre Gandling", colour = AM_RED, coords = { {76.2, 74.4} }, symbol = { "16" },
						tooltiptxt = "Lvl61 Elite  Humano\195\175de", lootid = "SCHOLODarkmasterGandling", leaveGap = 1 },
				dtl21 = { text = "Torche levier", colour = AM_GREEN, coords = { {89, 19} }, symbol = { "T" },
						tooltiptxt = "" },
				dtl22 = { text = "Laboratoire d'alchimie", colour = AM_GREEN, coords = { {14, 70} }, symbol = { "AL" },
						tooltiptxt = "", leaveGap = 1 },
				dtl23 = { text = "Titre de propri\195\169t\195\169 de Southshore", colour = AM_ORANGE, coords = { {56, 25} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl24 = { text = "Titre de propri\195\169t\195\169 de Moulin-de-Tarren", colour = AM_ORANGE, coords = { {11, 36} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl25 = { text = "Titre de propri\195\169t\195\169 de Brill", colour = AM_ORANGE, coords = { {15, 77} }, symbol = { "D" },
						tooltiptxt = ""  },
				dtl26 = { text = "Titre de propri\195\169t\195\169 de Caer Darrow", colour = AM_ORANGE, coords = { {94, 72} }, symbol = { "D" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", leaveGap = 1},
			},

			{	name = "Stratholme",			-- Stratholme
				type = AM_TYP_INSTANCE,
				displayname = "Stratholme",
				filename = "Stratholme",
				location = "Maleterres de l'Est (30, 12)",
				levels = "55-60",
				players = "5",
				prereq = "",
				general = "Côté-Entrée \195\160 EP (47, 24)",
				dtl1  = { text = "Avant-Entr\195\169e", colour = AM_GREEN, coords = { {50, 91} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "C\195\180t\195\169-Entr\195\169e", colour = AM_GREEN, coords = { {83, 72} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Boite aux lettres de Fras Siabi", colour = AM_ORANGE, coords = { {37, 86} }, symbol = { "P1" },
						tooltiptxt = "" },
				dtl4  = { text = "Boite aux lettres de la Place du Roi", colour = AM_ORANGE, coords = { {47, 74} }, symbol = { "P2" },
						tooltiptxt = "" },
				dtl5  = { text = "Boite aux lettres de la Place des Crois\195\169s", colour = AM_ORANGE, coords = { {24, 66} }, symbol = { "P3" },
						tooltiptxt = "" },
				dtl6  = { text = "Boite aux lettres de l'All\195\169e du march\195\169", colour = AM_ORANGE, coords = { {50, 62} }, symbol = { "P4" },
						tooltiptxt = ""  },
				dtl7  = { text = "Boite aux lettres de l'All\195\169e du festival", colour = AM_ORANGE, coords = { {61, 62} }, symbol = { "P5" },
						tooltiptxt = ""  },
				dtl8  = { text = "Boite aux lettres de la Place des Anciens", colour = AM_ORANGE, coords = { {80, 68} }, symbol = { "P6" },
						tooltiptxt = "" },
				dtl9 = { text = "Malown De Ma\195\174tre de poste", colour = AM_RED, coords = { {37, 86}, {47, 74}, {24, 66}, {50, 62}, {61, 62}, {80, 68} }, symbol = { " " },
						tooltiptxt = "Lvl60 Elite Mort-vivant\nSpawns on opening of a 3rd Mail box\nMail box keys looted from Courier", leaveGap = 1 },
				dtl10 = { text = "Skul", colour = AM_RED, coords = { {42, 83} }, symbol = { "1" },
						tooltiptxt = "Lvl58 Elite Mort-vivant", special = AM_RARE.." "..AM_WANDERS, lootid = "STRATSkull" },
				dtl11 = { text = "Stratholme Courier", colour = AM_RED, coords = { {43, 78} }, symbol = { "2" },
						tooltiptxt = "Lvl57 Elite Mort-vivant", lootid = "STRATStratholmeCourier"  },
				dtl12 = { text = "Fras Siabi", colour = AM_RED, coords = { {39, 83} }, symbol = { "3" },
						tooltiptxt = "Lvl61 Elite Mort-vivant", lootid = "STRATFrasSiabi"  },
				dtl13 = { text = "Hearthsinger Forresten", colour = AM_RED, coords = { {45, 62}, {65, 58}, {66, 66} }, symbol = { "4" },
						tooltiptxt = "Lvl57 Elite Mort-vivant\nWill continue to respawn if any\nGhouls that spawn in his place\nare killed", special = AM_VARIES, lootid = "STRATHearthsingerForresten" },
				dtl14 = { text = "Le Condamn\195\169", colour = AM_RED, coords = { {56, 57} }, symbol = { "5" },
						tooltiptxt = "Lvl57 Elite Mort-vivant", lootid = "STRATTheUnforgiven"  },
				dtl15 = { text = "Timmy the Cruel", colour = AM_RED, coords = { {26, 61.5} }, symbol = { "6" },
						tooltiptxt = "Lvl58 Elite Mort-vivant", lootid = "STRATTimmytheCruel"  },
				dtl16 = { text = "Maitre Cannonier Willey", colour = AM_RED, coords = { {1, 74} }, symbol = { "7" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", lootid = "STRATCannonMasterWilley"  },
				dtl17 = { text = "Archiviste Galford", colour = AM_RED, coords = { {24, 92} }, symbol = { "8" },
						tooltiptxt = "Lvl60 Elite  Humano\195\175de", lootid = "STRATArchivistGalford"  },
				dtl18 = { text = "Balnazzar", colour = AM_RED, coords = { {17, 97} }, symbol = { "9" },
						tooltiptxt = "Lvl62 Elite Demon", lootid = "STRATBalnazzar"  },
				dtl19 = { text = "Sothos", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "Requires Jarien & Sothos's Brazier of Summoning", lootid = "STRATSothosJarien" },
				dtl20 = { text = "Jarien", colour = AM_RED, coords = { {17, 97} }, symbol = { " " },
						tooltiptxt = "Requires Jarien & Sothos's Brazier of Summoning", lootid = "STRATSothosJarien" },
				dtl21 = { text = "Aurius", colour = AM_BLUE, coords = { {81, 61} }, symbol = { "10" },
						tooltiptxt = ""  },
				dtl22 = { text = "Stonespine", colour = AM_RED, coords = { {78, 42} }, symbol = { "11" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", special = AM_RARE, lootid = "STRATStonespine"  },
				dtl23 = { text = "Barone Anastari", colour = AM_RED, coords = { {90, 39} }, symbol = { "12" },
						tooltiptxt = "Lvl59 Elite Mort-vivant", lootid = "STRATBaronessAnastari"  },
				dtl24 = { text = "Nerub'enkan", colour = AM_RED, coords = { {64, 39} }, symbol = { "13" },
						tooltiptxt = "Lvl60 Elite Mort-vivant", lootid = "STRATNerubenkan"  },
				dtl25 = { text = "Maleki le Blafard", colour = AM_RED, coords = { {81, 14} }, symbol = { "14" },
						tooltiptxt = "Lvl61 Elite  Humano\195\175de", lootid = "STRATMalekithePallid"  },
				dtl26 = { text = "Magistrate Barthilas", colour = AM_RED, coords = { {66, 10}, {74, 60} }, symbol = { "15" },
						tooltiptxt = "Lvl58 Elite Mort-vivant", special = AM_VARIES, lootid = "STRATMagistrateBarthilas" },
				dtl27 = { text = "Ramstein Grandgosier", colour = AM_RED, coords = { {56, 15} }, symbol = { "16" },
						tooltiptxt = "Lvl61 Elite Mort-vivant", lootid = "STRATRamsteintheGorger"  },
				dtl28 = { text = "Baron Rivendare", colour = AM_RED, coords = { {42, 15} }, symbol = { "17" },
						tooltiptxt = "Lvl62 Elite Mort-vivant", lootid = "STRATBaronRivendare", leaveGap = 1 }
			},

			{	name = "Donjon d'Ombrecroc",			-- Donjon d'Ombrecroc
				type = AM_TYP_INSTANCE,
				displayname = "Donjon d'Ombrecroc",
				displayshort = "SFK",
				filename = "ShadowfangKeep",
				location = "For\195\170t des Pins Argent\195\169s (45, 67)",
				levels = "20-30",
				players = "10",
				prereq = "",
				general = "",
				dtl1  = { text = AM_INSTANCE_ENTRANCES, colour = AM_GREEN, coords = { {75, 69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = AM_INSTANCE_CHESTS, colour = AM_GOLD, coords = { {57, 57}, {36, 55}, {29, 12} }, symbol = { AM_CHEST_SYMBOL },
						tooltiptxt = "" },
				dtl3  = { text = "Remparts", colour = AM_BLUE, coords = { {38, 71}, {54, 93} }, symbol = { "B1" },
						tooltiptxt = "" },
				dtl4  = {text = "Remparts", colour = AM_BLUE, coords = { {69, 85}, {35, 37} }, symbol = { "B2" },
						tooltiptxt = "" },
				dtl5  = { text = "Capitaine Deathsworn", colour = AM_RED, coords = { {69, 85}, {35, 37} }, symbol = { " " },
						tooltiptxt = "Lvl25 Elite Mort-vivant", special = AM_RARE  },
				dtl6  = { text = "Escaliers", colour = AM_GREEN, coords = { {29.8, 34.8}, {50, 46.8} }, symbol = { "S1" },
						tooltiptxt = "" },
				dtl7  = { text = "Escaliers", colour = AM_GREEN, coords = { {42, 32}, {67, 33} }, symbol = { "S2" },
						tooltiptxt = "", leaveGap = 1 },
				dtl8  = { text = "Rethilgore", colour = AM_RED, coords = { {70, 78} }, symbol = { "1" },
						tooltiptxt = "Lvl20 Elite  Humano\195\175de\nThe Cell Keeper" },
				dtl9  = { text = "Sorcier Ashcrombe", colour = AM_RED, coords = { {67, 73} }, symbol = { "2" },
						tooltiptxt = "Lvl18 Elite  Humano\195\175de"  },
				dtl10 = { text = "Traqueur noir Adamant", colour = AM_RED, coords = { {71, 74} }, symbol = { "3" },
						tooltiptxt = "Lvl18 Elite  Humano\195\175de"  },
				dtl11 = { text = "Razorclaw le Boucher", colour = AM_RED, coords = { {25, 59} }, symbol = { "4" },
						tooltiptxt = "Lvl22 Elite  Humano\195\175de", lootid = "BSFRazorclawtheButcher"  },
				dtl12 = { text = "Baron Silverlaine", colour = AM_RED, coords = { {13, 87} }, symbol = { "5" },
						tooltiptxt = "Lvl24 Elite Mort-vivant", lootid = "BSFSilverlaine" },
				dtl13 = { text = "Commandant Springvale", colour = AM_RED, coords = { {26, 69} }, symbol = { "6" },
						tooltiptxt = "Lvl24 Elite Mort-vivant", lootid = "BSFSpringvale"  },
				dtl14 = { text = "Odo l'Aveugle", colour = AM_RED, coords = { {61, 84} }, symbol = { "7" },
						tooltiptxt = "Lvl24 Elite  Humano\195\175de", lootid = "BSFOdotheBlindwatcher"  },
				dtl15 = { text = "Fenrus le D\195\169voreur", colour = AM_RED, coords = { {53.4, 33.4} }, symbol = { "8" },
						tooltiptxt = "Lvl25 Elite Beast", lootid = "BSFFenrustheDevourer"  },
				dtl16 = { text = "Ma\195\174tre-loup Nandos", colour = AM_RED, coords = { {80, 29} }, symbol = { "9" },
						tooltiptxt = "Lvl25 Elite  Humano\195\175de", lootid = "BSFWolfMasterNandos"  },
				dtl17 = { text = "Archimage Arugal", colour = AM_RED, coords = { {84, 13} }, symbol = { "10" },
						tooltiptxt = "Lvl26 Elite  Humano\195\175de", lootid = "BSFArchmageArugal", leaveGap = 1 },
				dtl18 = { text = AM_MOB_LOOT, colour = AM_BLUE, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "", lootid = "BSFTrash", leaveGap = 1 }
			},

			{ 	name = "Goulet des Warsong",			-- Goulet des Warsong
				type = AM_TYP_BG,
				displayname = "Goulet des Warsong",
				displayshort = "WSG",
				filename = "WarsongGulch",
				location = "Ashenvale (62, 84) / Les Tarrides (47, 8)",
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

			{ 	name = "Bassin d'Arathi",			-- Bassin d'Arathi
				type = AM_TYP_BG,
				displayname = "Bassin d'Arathi",
				displayshort = "AB",
				filename = "ArathiBasin",
				location = "Hautes-terres d'Arathi (73, 28)",
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
				dtl3  = { text = "Ecuries", colour = AM_GREEN, coords = { {34.67, 29.6}, {9, 28.0} }, symbol = { "S" },
						tooltiptxt = "Capture", bgPOI = true },
				dtl4  = { text = "Mine d'or", colour = AM_GREEN, coords = { {72.81, 30.54}, {9, 34.0} }, symbol = { "M" },
						tooltiptxt = "Capture", bgPOI = true },
				dtl5  = { text = "Forge", colour = AM_GREEN, coords = { {51.9, 50.2}, {9, 50.2} }, symbol = { "B" },
						tooltiptxt = "Capture", bgPOI = true },
				dtl6  = { text = "Scierie", colour = AM_GREEN, coords = { {41.10, 62.37}, {9, 62.0} }, symbol = { "L" },
						tooltiptxt = "Capture", bgPOI = true },
				dtl7  = { text = "Ferme", colour = AM_GREEN, coords = { {70.52, 67.75}, {9, 68.0} }, symbol = { "F" },
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

			{ 	name = "Vall\195\169e d'Alterac",			-- Vall\195\169e d'Alterac
				type = AM_TYP_BG,
				displayname = "Vall\195\169e d'Alterac",
				displayshort = "AV",
				filename = "AlteracValley",
				location = "Montagnes d'Alterac (63, 58)",
				levels = "51-60",
				players = "40",
				prereq = "",
				general = "",
				notescale = 0.7,
				wmData = { minX = 0.395, maxX = 0.586, minY =  0.106, maxY = 0.9187 },
				amData = { minX = 0.65, maxX = 0.95, minY = 0.036, maxY = 0.98 },
				dtl1  = { text = "Alliance - Entr\195\169e", colour = AM_BLUE, coords = { {87.98, 2.69} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "" },
				dtl2  = { text = "Horde - Entr\195\169e", colour = AM_RED, coords = { {91.01, 71.03} }, symbol = { AM_ENTRANCE_SYMBOL },
						tooltiptxt = "", leaveGap = 1 },
				dtl3  = { text = "Dun Baldar", colour = AM_BLUE, coords = { {67.38, 6.47} }, symbol = { "!" },
						tooltiptxt = "Kill boss to win the game" },
				dtl4  = { text = "Frostwolf Keep", colour = AM_RED, coords = { {75.38, 92.42} }, symbol = { "!" },
						tooltiptxt = "Kill boss to win the game", leaveGap = 1 },
				dtl5  = { text = "Cimeti\195\168res", colour = AM_GREEN, coords = { {68.26, 9.55}, {79.29, 8.36}, {83.68, 32.53}, {70.89, 44.37}, {83.49, 60.99}, {80.66, 80.18}, {80.27, 94.31} }, symbol = { " " },
						tooltiptxt = "Capture to allow your faction to resurrect here", bgPOI = true },
				dtl6  = { text = "Poste de secours Stormpike", colour = AM_GREEN, coords = { {68.26, 9.55}, {57, 9.55} }, symbol = { "1" },
						tooltiptxt = "", bgPOI = true },
				dtl7  = { text = "Cimeti\195\168re Stormpike", colour = AM_GREEN, coords = { {79.29, 8.36}, {57, 12} }, symbol = { "2" },
						tooltiptxt = "", bgPOI = true },
				dtl8  = { text = "Cimeti\195\168re Stonehearth", colour = AM_GREEN, coords = { {83.68, 32.53}, {57, 32.53} }, symbol = { "3" },
						tooltiptxt = "", bgPOI = true },
				dtl9  = { text = "Cimeti\195\168re des Neiges", colour = AM_GREEN, coords = { {72.2, 44.8}, {57, 44.37} }, symbol = { "4" },
						tooltiptxt = "", bgPOI = true },
				dtl10 = { text = "Cimeti\195\168re  de Glacesang", colour = AM_GREEN, coords = { {83.49, 60.99}, {57, 60.99} }, symbol = { "5" },
						tooltiptxt = "", bgPOI = true },
				dtl11 = { text = "Cimeti\195\168re Frostwolf", colour = AM_GREEN, coords = { {82.0, 80.18}, {57, 80.18} }, symbol = { "6" },
						tooltiptxt = "", bgPOI = true },
				dtl12 = { text = "Hutte de gu\195\169rison Frostwolf", colour = AM_GREEN, coords = { {80.27, 94.31}, {57, 94.31} }, symbol = { "7" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl13 = { text = "Avant-poste de Stonehearth", bgPOI = true, colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { "C" },
						tooltiptxt = "" },
				dtl14 = { text = "Balinda", colour = AM_BLUE, coords = { {79, 36.71} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl15 = { text = "Garnison de Glacesang", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { "C" },
						tooltiptxt = "", bgPOI = true },
				dtl16 = { text = "Glavangar", colour = AM_RED, coords = { {73.82, 57.7} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl17 = { text = "Fortin d'Alliance", colour = AM_BLUE, coords = { {85.54, 41.98}, {82.02, 27.16}, {70.50, 13.53}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "Horde can destroy for honour\nGuards stop respawning when destroyed", bgPOI = true },
				dtl18 = { text = "Fortin de Stonehearth", colour = AM_BLUE, coords = { {85.54, 41.98}, {60, 41.98} }, symbol = { "8" },
						tooltiptxt = "", bgPOI = true },
				dtl19 = { text = "Fortin de l'Aile de glace", colour = AM_BLUE, coords = { {82.02, 27.16}, {60, 27.16} }, symbol = { "9" },
						tooltiptxt = "Alliance Wing Commander Karl Philips\nHorde Wing Commander Guse", bgPOI = true },
				dtl20 = { text = "Fortin sud de Dun Baldar", colour = AM_BLUE, coords = { {71.00, 13.00}, {60, 13.53} }, symbol = { "10" },
						tooltiptxt = "", bgPOI = true },
				dtl21 = { text = "Fortin nord de Dun Baldar", colour = AM_BLUE, coords = { {73.04, 7.37}, {60, 7.37} }, symbol = { "11" },
						tooltiptxt = "Horde Wing Commander Mulverick", bgPOI = true, leaveGap = 1 },
				dtl22 = { text = "Tours d'Horde", colour = AM_RED, coords = { {78.31, 59.29}, {81.83, 67.25}, {80.4, 89.04}, {77, 88.5}  }, symbol = { " " },
						tooltiptxt = "Alliance can destroy for honour\nGuards stop respawning when destroyed", bgPOI = true },
				dtl23 = { text = "Tour de Glacesang", colour = AM_RED, coords = { {78.31, 59.29}, {60, 59.29} }, symbol = { "12" },
						tooltiptxt = "", bgPOI = true },
				dtl24 = { text = "Tour de la Halte", colour = AM_RED, coords = { {81.83, 67.25}, {60, 67.25} }, symbol = { "13" },
						tooltiptxt = "Alliance Wing Commander Louis Philips\nHorde Wing Commander Slidore", bgPOI = true },
				dtl25 = { text = "Tour De Frostwolf Est", colour = AM_RED, coords = { {80.6, 89.04}, {63, 89.05} }, symbol = { "14" },
						tooltiptxt = "", bgPOI = true },
				dtl26 = { text = "Tour De Frostwolf Ouest", colour = AM_RED, coords = { {78.5, 88.8}, {60.5, 88.5} }, symbol = { "15" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl27 = { text = "Mines", colour = AM_ORANGE, coords = { {81.15, 1.69}, {73.33, 74.61} }, symbol = { " " },
						tooltiptxt = "Capture to farm resources", bgPOI = true },
				dtl28 = { text = "Mine de Gouffrefer", colour = AM_GREEN, coords = { {81.15, 1.69}, {63, 1.69} }, symbol = { "IM" },
						tooltiptxt = "", bgPOI = true },
				dtl29 = { text = "Mine de Froidedent", colour = AM_GREEN, coords = { {73.33, 74.61}, {63, 74.61} }, symbol = {"CM" },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
	-- Pad to dtl32 to control the page break
				dtl30 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl31 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
				dtl32 = { text = "", colour = AM_GREEN, coords = { {0, 0} }, symbol = { " " },
						tooltiptxt = "" },
	-- Pad to dtl32 to control the page break
				dtl33 = { text = "Zones d'invocation", colour = AM_GREEN, coords = { {80.76, 44.27}, {73.14, 48.05} }, symbol = { " " },
						tooltiptxt = "Summon a Factions Avatar at these points" },
				dtl34 = { text = "Ivus le Seigneur des for\195\170ts", colour = AM_BLUE, coords = { {80.76, 44.27} }, symbol = { "IF" },
						tooltiptxt = "Escort summoning NPCs to this point\nfrom Dun Baldar" },
				dtl35 = { text = "Lokholar le Seigneur de glace", colour = AM_RED, coords = { {73.14, 48.05} }, symbol = { "LI" },
						tooltiptxt = "Escort summoning NPCs to this point\nfrom Frostwolf Keep", leaveGap = 1 },
				dtl36 = { text = "Alliance Commandants", colour = AM_BLUE, coords = { {82.02, 27.16}, {81.05, 85.46}, {81.83, 67.25}, {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
				dtl37 = { text = "Karl Philips (9 Fortin de l'Aile de glace)", colour = AM_BLUE, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl38 = { text = "Slidore (13 Tour de la Halte)", colour = AM_BLUE, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl39 = { text = "Vipore", colour = AM_BLUE, coords = { {81.05, 85.46} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl40 = { text = "Ichman (14 Tour De Frostwolf Est)", colour = AM_BLUE, coords = { {80.4, 89.04} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl41 = { text = "Horde Commandants", colour = AM_RED, coords = { {81.83, 67.25}, {82.02, 27.16}, {88.96, 23.38}, {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "Rescue and escort back to base to get Air support", bgPOI = true },
				dtl42 = { text = "Louis Philips (13 Tour de la Halte)", colour = AM_RED, coords = { {81.83, 67.25} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl43 = { text = "Guse (9 Fortin de l'Aile de glace)", colour = AM_RED, coords = { {82.02, 27.16} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true },
				dtl44 = { text = "Jeztore", colour = AM_RED, coords = { {88.96, 23.38} }, symbol = { "W" },
						tooltiptxt = "" },
				dtl45 = { text = "Mulverick (11 Fortin nord de Dun Baldar)", colour = AM_RED, coords = { {73.04, 7.37} }, symbol = { " " },
						tooltiptxt = "", bgPOI = true, leaveGap = 1 },
				dtl46 = { text = "Scie m\195\169canique Endroits", colour = AM_PURPLE, coords = { {83, 54.72}, {88.57, 15.42} }, symbol = { " " },
						tooltiptxt = "" },
				dtl47 = { text = "Alliance Scie m\195\169canique", colour = AM_BLUE, coords = { {83, 54.72} }, symbol = { "S" },
						tooltiptxt = "Required for Reaper quest" },
				dtl48 = { text = "Horde Scie m\195\169canique", colour = AM_RED, coords = { {88.57, 15.42} }, symbol = { "S" },
						tooltiptxt = "Required for Reaper quest", leaveGap = 1 },
				dtl49 = { text = "Cavernes", colour = AM_GREEN, coords = { {64.54, 24.08}, {85.93, 94.71} }, symbol = { " " },
						tooltiptxt = "" },
				dtl50 = { text = "Caverne de l'Aile de glace", colour = AM_GREEN, coords = { {64.54, 24.08} }, symbol = { "IC" },
						tooltiptxt = "" },
				dtl51 = { text = "Caverne des Follepatte", colour = AM_GREEN, coords = { {85.93, 94.71} }, symbol = { "WC" },
						tooltiptxt = "", leaveGap = 1 },
				dtl52 = { text = "Commandant des chevaucheurs de loup", colour = AM_RED, coords = { {91.2, 86.55} }, symbol = { "WR" },
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

end