--[[
	Localization stings for Gatherer config UI
	english set by default, localized versions overwrite the variables.
	Revision: $Id: UI_localization.lua 247 2006-06-26 11:08:02Z islorgris $
	
	ToDo:
		- Missing German strings
		- Missing Chinese strings	
]]

	-- Quick Menu
	GATHERER_TEXT_TITLE_BUTTON		= "Настройки Gatherer";
	
	GATHERER_TEXT_TOGGLE_MINIMAP	= "Мини-карта ";
	GATHERER_TEXT_TOGGLE_MAINMAP	= "Карта мира ";
	GATHERER_TEXT_TOGGLE_HERBS   	= "Растения ";
	GATHERER_TEXT_TOGGLE_MINERALS	= "Руда ";
	GATHERER_TEXT_TOGGLE_TREASURE	= "Сундуки и рыба ";
	GATHERER_TEXT_TOGGLE_REPORT     = "Статистика";
	GATHERER_TEXT_TOGGLE_SEARCH		= "Поиск";

	GATHERER_REPORT_TIP				= "Access Report dialog.";
	GATHERER_SEARCH_TIP				= "Access Search dialog.";
	GATHERER_MENUTITLE_TIP			= "Access Configuration dialog.";
	GATHERER_ZMBUTTON_TIP			= "Access Zone Match dialog.";

	-- Quick Menu Options
	GATHERER_TEXT_CONFIG_TITLE      = "Gatherer: Настройки";
	GATHERER_TAB_MENU_TEXT			= "Кнопка меню";

	GATHERER_TEXT_SHOWONMOUSE       = "Show on mouse over";
	GATHERER_TEXT_HIDEONMOUSE       = "Hide on mouse out";
	GATHERER_TEXT_SHOWONCLICK       = "Show on left click";
	GATHERER_TEXT_HIDEONCLICK       = "Hide on left click";
	GATHERER_TEXT_HIDEONBUTTON      = "Hide on button press";
	GATHERER_TEXT_POSITION          = "Position";
	GATHERER_TEXT_RADIUS	        = "Radius";
	GATHERER_TEXT_HIDEICON			= "Hide menu icon";

	GATHERER_SHOWONMOUSE_TIP		= "Отображать меню при наведении курсора на кнопку Gatherer.";
	GATHERER_SHOWONCLICK_TIP		= "Отображать меню по ЛКМ.";
	GATHERER_HIDEONMOUSE_TIP		= "Скрывать меню курсором мыши.";
	GATHERER_HIDEONCLICK_TIP		= "Скрывать меню по ЛКМ.";
	GATHERER_HIDEONBUTTON_TIP		= "Hide menu on selection.";
	GATHERER_HIDEICON_TIP			= "Скрыть кнопку Gatherer на мини-карте.";
	GATHERER_TEXT_POSITION_TIP  	= "Изменить позицию кнопку приложения относительно рамки.";
	GATHERER_TEXT_RADIUS_TIP  		= "Изменить положение кнопки приложения относительно центра.";

	GATHERER_TAB_MENU_TEXT_TIP		= "Access QuickMenu Options.";

	-- Globals Options
	GATHERER_TAB_GLOBALS_TEXT		= "Общие";

	GATHERER_TEXT_RAREORE           = "Couple Rare Ore/Herbs";
	GATHERER_TEXT_NO_MINICONDIST	= "No icon under min distance";
	GATHERER_TEXT_MAPMINDER			= "Activate Map Minder";
	GATHERER_TEXT_MAPMINDER_VALUE	= "Map Minder timer";
	GATHERER_TEXT_FADEPERC			= "Fade Percent";
	GATHERER_TEXT_FADEDIST			= "Fade Distance";
	GATHERER_TEXT_THEME				= "Theme: ";
	GATHERER_TEXT_MINIIDIST			= "Minimal icon distance";
	GATHERER_TEXT_NUMBER			= "Mininotes number";
	GATHERER_TEXT_MAXDIST			= "Mininotes distance";
	GATHERER_TEXT_HIDEMININOTES		= "Hide mininotes";
	GATHERER_TEXT_TOGGLEWORLDNOTES	= "Long world note names";
	GATHERER_TEXT_WMICONSIZEEB		= "Worldmap icon size";
	GATHERER_TEXT_WMICONALPHAEB		= "Worldmap icon transparency";
	GATHERER_TEXT_ALPHAUNDER_MINICON= "Transparency under min";

	GATHERER_MAPMINDER_TIP			= "Activate/Deactivate Map Minder.";
	GATHERER_TEXT_MAPMINDER_TIP		= "Adjusts the Map Minder timer.";
	GATHERER_THEME_TIP				= "Set Icon Theme.";
	GATHERER_NOMINIICONDIST_TIP		= "No display of minimap icon under min distance.";	
	GATHERER_RAREORE_TIP			= "Show common/rare ore/herbs together.";
	GATHERER_TEXT_FADEPERC_TIP		= "Adjusts icons fade percent." ;
	GATHERER_TEXT_FADEDIST_TIP		= "Adjusts icons fade distance.";
	GATHERER_TEXT_MINIIDIST_TIP		= "Adjusts minimal distance at which item icon appears.";
	GATHERER_TEXT_NUMBER_TIP		= "Adjusts number of mininotes displayed on the minimap.";
	GATHERER_TEXT_MAXDIST_TIP		= "Adjusts maximum distance to consider when looking for mininotes to display on the minimap.";
	GATHERER_HIDEMININOTES_TIP		= "Do not display mininotes on minimap.";
	GATHERER_TOGGLEWORLDNOTES_TIP	= "Toggle between short/long item name in worldmap notes.";
	GATHERER_WMICONSIZEEB_TIP		= "Set Icon size on world map.";
	GATHERER_WMICONALPHAEB_TIP		= "Set Icon transparency on world map.";
	GATHERER_TEXT_ALPHAUNDER_MINICON_TIP = "Set mininote transparency under minimal distance";
	
	GATHERER_TAB_GLOBALS_TEXT_TIP	= "Access Global Options.";
	
	-- Filters Options
	GATHERER_TAB_FILTERS_TEXT 		= "Фильтры";

	GATHERER_TEXT_FILTER_HERBS		= "Травы: ";
	GATHERER_TEXT_FILTER_ORE			= "Руда: ";
	GATHERER_TEXT_FILTER_TREASURE	= "Сундуки: ";
	GATHERER_TEXT_LINKRECORD        		= "Добавить фильтр"
	GATHERER_TEXT_WMFILTERS			= "Фильтры на карте мира";
	GATHERER_TEXT_DISABLEWMFIX		= "Кнопка \"Показать\\Скрыть\"";

	GATHERER_HERBSKLEB_TIP			= "Set min Herbalism skill for display.";
	GATHERER_ORESKLEB_TIP			= "Set min Mining skill for display.";
	GATHERER_HERBDDM_TIP			= "Filter shown herbs.";
	GATHERER_OREDDM_TIP				= "Filter shown ores.";
	GATHERER_TREASUREDDM_TIP		= "Filter shown treasures.";
	GATHERER_TEXT_LINKRECORD_TIP	= "Link recording to selected filters.";
	GATHERER_TEXT_WMFILTERS_TIP		= "Toggle items filters on world map.";
	GATHERER_TEXT_DISABLEWMFIX_TIP	= "Enable World Map Show/Hide button to display items";

	GATHERER_TAB_FILTERS_TEXT_TIP	= "Access Filters Options."

	-- Zone Rematch Dialog
	GATHERER_TEXT_REMATCH_TITLE		= "Zone Rematch";

	GATHERER_TEXT_APPLY_REMATCH		= "Apply Zone Rematch:";
	GATHERER_TEXT_SRCZONE_MISSING	= "Source Zone not selected.";
	GATHERER_TEXT_DESTZONE_MISSING	= "Destination Zone not selected.";
	GATHERER_TEXT_FIXITEMS			= "Fix Item Names";
	GATHERER_TEXT_LASTMATCH			= "Last Match: ";
	GATHERER_TEXT_LASTMATCH_NONE	= "None";
	GATHERER_TEXT_CONFIRM_REMATCH	= "Confirm Zone Rematch (WARNING, this will modify data)";

	GATHERER_ZM_FIXITEM_TIP			= "Fix Items names, localized version only.";
	GATHERER_ZM_SRCDDM_TIP			= "Set Source Map order.";
	GATHERER_ZM_DESTDDM_TIP			= "Set Destination Map order.";

	-- Report Dialog
	GATHERER_TAB_REPORT_TIP			= "Node Report by Zone.";
	
	GATHERER_REPORT_LOCATION		= "Location:";
	GATHERER_REPORT_COL_TYPE		= "Type";
	GATHERER_REPORT_COL_NAME		= "Gatherable";
	GATHERER_REPORT_COL_PTYPE		= "% Type";
	GATHERER_REPORT_COL_PDENSITY	= "% Density";
	
	GATHERER_REPORT_SUMMARY			= "Total: # gather for & nodes";

	-- Search Dialog
	GATHERER_TAB_SEARCH_TIP			= "Search for Zone containing specific item.";
	
	GATHERER_SEARCH_LOCATION		= "Item:";
	GATHERER_SEARCH_COL_CONTINENT	= "Continent";
	GATHERER_SEARCH_COL_ZONE		= "Zone";
	GATHERER_SEARCH_COL_PNODE		= "% Node";
	GATHERER_SEARCH_COL_PDENSITY	= "% Density";

	GATHERER_SEARCH_SUMMARY			= "Found: # nodes in & zones";
	
	-- World Map
	GATHERER_FILTERDM_TEXT		= "Фильтр"
	GATHERER_FILTERDM_TIP		= "Поиск предметов."

	-- Bindings
	BINDING_HEADER_GATHERER_BINDINGS_HEADER		= "Gatherer";

	BINDING_NAME_GATHERER_BINDING_QUICKMENU		= "Show/Hide Gatherer Quick Menu";
	BINDING_NAME_GATHERER_BINDING_OPTIONS		= "Show/Hide Gatherer Options";
	BINDING_NAME_GATHERER_BINDING_REPORT		= "Show/Hide Gatherer Report";
	BINDING_NAME_GATHERER_BINDING_SEARCH		= "Show/Hide Gatherer Options";

	-- MyAddons Help Pages
	GathererHelp = {};
	GathererHelp[1] ="|cffff7f3fTable of Contents|r\n\n1- Quick Menu\n2- Minimap\n3- World Map\n4- Options Dialog\n5- Zone Rematch Dialog\n6- Report Dialog\n7- Search Dialog\n8- Node Editor\n";
	GathererHelp[2] ="|cffff7f3fQuick Menu:|r\n\nAllows fast access to basic display filters (minimap, world map, herbs, ores and treasures) as well as access to the statistic dialogs (see help pages on Report and Search).\n\nClicking on the menu title will bring up the configuration dialog.\n";
	GathererHelp[3] ="|cffff7f3fMinimap:|r\n\nThe minimap will display icons for the closest gathers (25 max, according to filters, number of gather to show, max distance to consider, etc.).\n\nMousing over these icons will bring up a tooltip detailing the gatherable name, the number of time a successful gather was performed there and the distance to it from current position (in units and time to get there in a straight line at standard running speed).\n";
	GathererHelp[4] ="|cffff7f3fWorld Map:|r\n\nThe World Map will display icons for all gathered items in the selected zone (400 max, according to selected filters, etc.).\n\nSince having a great number of items to display may cause lag while trying to access the map, by default the items are shown (there is a toggle in the Filters option tab not to display them all the time, it enables a Show Items button on the world map).\n\nThe World Map also allows access to the Node Editor to do some basic manipulation on the Database, by alt-right clicking on a node.\n";
	GathererHelp[5] ="|cffff7f3fOptions Dialog:|r\n\nThe option dialog is divided in 3 tabs: Filters, Globals, Quick Menu\n\n|cffff7f3fFilters Tab|r deals with filters related option (including control for the Show/Hide button on the World Map).\n\n|cffff7f3fGlobals Tab|r handles options related to core Gatherer functionnality (most of these are also availale though command line).\n\n|cffff7f3fQuick Menu Tab|r controls the behaviour of the quick menu from the minimap icon (including icon position and show/hide control).\n";
	GathererHelp[6] ="|cffff7f3fZone Rematch Dialog:|r\n\nThis is mainly a facility for localized WoW clients in which the zone name translations were not complete by the time of the official WoW release.\n\nWhen zone names are changed, zone indexes change too because they are sorted alphabetically.\nThis facility provides transition matrixes to fix these indexes by selecting a Source Zone order (ie. previous one) and a Destination Zone order (ie. current one) identified by the WoW version and prefixed by WoW client language (the fix item checkbox allows item names that have been changed to be fixed).\n\nThis also allows global manipulation of the database, such as changing it's format, this is done with any selected source and destination zone order, for non-localized clients an identify matrix should be used (ie. same source and destination order).\n\n|cffff7f3fDatabase is modified, so keep a backup of your data, just in case.|r\n";
	GathererHelp[7] ="|cffff7f3fReport Dialog:|r\n\nIn this dialog you can display the items you have collected in the various zones (one zone at a time) for a quick overview.\n\nYou can click on the various column headings to sort (and reverse sort) the display according to that column contents.\n\nMost of the columns are self-explanatory, except for the ones detailed below:\n|cffff7f3fType %:|r\n  Percentage of the ressource compared to number of recorded gather of the same type in zone.\n\n|cffff7f3fDensity %:|r\n  Percentage of the ressource compared to number of recorded gather of the same item worldwide.\n";
	GathererHelp[8] ="|cffff7f3fSearch Dialog:|r\n\nIn this dialog you can specify an item and display the various zones in which it has already been gathered.\n\nYou can click on the various column headings to sort (and reverse sort) the display according to that column contents.\n\nMost of the columns are self-explanatory, except for the ones detailed below:\n|cffff7f3fNode %:|r\n  Percentage of the ressource compared to the number of nodes in zone.\n\n|cffff7f3fDensity %:|r\n  Percentage of the ressource compared to total matching nodes worldwide.\n";
	GathererHelp[9] ="|cffff7f3fNode Editor:|r\n\nIn this dialog you (alt-right click on a node in the World Map), you can change the node name, it's icon, toggle it as bugged or delete it.\n\n|cffff7f3fToggle Bugged|r will only work for the current selected node.\n\n|cffff7f3fDelete|r use scope (Node by default to avoid mistakes) and can be extended to Zone, Continent and World scopes.\n\n|cffff7f3fAccept|r will take into account the new node name (remember to hit enter after filling the new name) and/or icon.\nAs for the delete button, this one takes scope into account and can be applied at Node, Zone, Continent and World level.\n";
	GathererHelp.currentPage=1;

	GathererDetails = {}; -- this line MUST NOT be repeated in localization blocks
	GathererDetails["description"] = "Show gathered herbs/ores/treasures locations";
	GathererDetails["releaseDate"] = "August 27, 2006";