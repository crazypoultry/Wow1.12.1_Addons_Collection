-- ***DEBUGGING STUFF*** --
ScriptErrors:SetWidth(600);
ScriptErrors_Message:SetWidth(580);
ScriptErrors:SetPoint("BOTTOM", "UIParent", "BOTTOM", 0, 100);
ScriptErrors:SetPoint("TOP", "UIParent", "BOTTOM", 0, 220);
---***BLIZZARD 1.6 BUG FIX*** ---
if (ITEM_QUALITY6_TOOLTIP_COLOR == nil) then
	ITEM_QUALITY6_TOOLTIP_COLOR = { r = 1.0, g = 0.5, b = 0 };
end
if (BHALDIEINFOBAR_LOADED == nil or BHALDIEMOVEIT_LOADED == nil) then
	BM_PLAYERNAME_REALM = "";
end
-- ***FONT COLOR SHORT FORM*** --
BM_WHITE = HIGHLIGHT_FONT_COLOR_CODE;
BM_RED = RED_FONT_COLOR_CODE;
BM_GREEN = GREEN_FONT_COLOR_CODE;
BM_YELLOW = NORMAL_FONT_COLOR_CODE;
BM_GRAY = GRAY_FONT_COLOR_CODE;
BM_FONT_OFF = FONT_COLOR_CODE_CLOSE;
-- ***SAVED VARIABLES*** --
BRL_CONFIG								= {};
ZONE_TABLE								= {};
INSTANCE_TABLE							= {};
DEFAULT_BRL_ZONE_INFO_ENABLE			= true;
DEFAULT_BRL_TOOLTIP_ENABLE			= true;
DEFAULT_BRL_MAP_TEXT_ENABLE			= true;
DEFAULT_BRL_TOOLTIP_OFFSET_LEFT		= true;	
DEFAULT_BRL_TOOLTIP_OFFSET_BOTTOM	= true;
DEFAULT_BRL_SHOW_TOOLTIP_FACTION	= false;
DEFAULT_BRL_SHOW_TOOLTIP_INSTANCE	= true;
DEFAULT_BRL_SHOW_ZONE				= false;
DEFAULT_BRL_BORDER_ALPHASLIDER		= 1;
BRL_SET_LEFT_RIGHT						= "LEFT";
BRL_SET_BOTTOM_TOP					= "BOTTOM";
-- ***TRANSLATION FUNCTION*** --
function BM_Translation()
	local location = GetLocale();
	if ( location == "deDE" ) then
		BM_Translation_DE();
	elseif ( location == "frFR" ) then
		BM_Translation_FR();
	else
		BM_Translation_EN();
	end
end
-- ***ENGLISH TRANSLATION*** --
function BM_Translation_EN()
	-- ***GLOBAL VARIABLES ***--
	BRL_LOADED_INFO						= BM_GREEN .. "\nType '/brlconfig' in the chat frame, to open the User settings window" .. BM_FONT_OFF
	BRL_ACTIVE_INFO						= BM_GREEN .. "Recommended Level UI Menu is ACTIVE\nYou can type /brlconfig in the chat window to bring up the UI Menu." .. BM_FONT_OFF; -- New
	BRL_DISABLED_INFO						= BM_GREEN .. "Recommended Level UI Menu is DISABLED\nTyping /brlconfig in the chat window will not bring up the UI Menu." .. BM_FONT_OFF; -- New
	BRL_RESET_ALL_TEXT						= "Do you really want to reset all settings?";
	BRL_CITY								= "City";
	BRL_CONTESTED							= "Contested";
	BRL_ALLIANCE							= "Alliance";
	BRL_HORDE								= "Horde";
	BRL_NONE								= "None";
	BRL_TOOLTIP_CURRENT					= "Current:";
	BRL_TOOLTIP_CLEVEL						= "Current Level: ";
	BRL_TOOLTIP_CZONE						= "Current Zone: ";
	BRL_TOOLTIP_CRANGE						= "Zone Range: ";
	BRL_TOOLTIP_CINSTANCES				= "Instances: ";
	BRL_TOOLTIP_RECOMMEND				= "Recommended Zones:";
	BRL_TOOLTIP_RZONE						= "Zone: ";
	BRL_TOOLTIP_RRANGE						= "Zone Range: ";
	BRL_TOOLTIP_RFACTION					= "Faction: ";
	BRL_TOOLTIP_RINSTANCES				= "Instances: ";
	BRL_TOOLTIP_RCONTINENT				= "Continent: "; 
	BRL_TOOPTIP_TITLE						= "Zone Info";
	BRL_ERROR_MESSAGE_1					= "Number must be between 0 and 1.";
	BRL_TOOLTIP_BG							= "Battlegrounds";
	BRL_RECOMMEND_TO						= "to "; 
	BRL_RECOMMEND_AND_UP					= " and up "; 
	BRL_RECOMMEND_INSTANCES				= "Recommended Instances:"; 
	BRL_RECOMMEND_BATTLEGROUNDS			= "Recommended Battlegrounds:";
	

	-- *** MENU OPTIONS *** --
	BRL_ZONE_INFO_ENABLE					= "Zone Info Bar Show/Hide";
	BRL_TOOLTIP_ENABLE						= "Tooltip Show/Hide";
	BRL_MAP_TEXT_ENABLE					= "Map Text Show/Hide";
	BRL_TOOLTIP_OFFSET_LEFT				= "Offset Left/Right";	
	BRL_TOOLTIP_OFFSET_BOTTOM			= "Offset Bottom/Top";
	BRL_SHOW_TOOLTIP_FACTION				= "Show Faction in Tooltip";
	BRL_SHOW_TOOLTIP_INSTANCE			= "Show Instances in Tooltip";
	BRL_BORDER_ALPHASLIDER					= "Alpha Shade on Border";
	BRL_SHOW_ZONE							= "Show Zone in Frame";
	BRL_SHOW_REC_INSTANCE				= "Show Recommended Instances"; 
	BRL_SHOW_REC_BATTLEGROUNDS			= "Show Recommended Battlegrounds"; 
	BRL_SHOW_TOOLTIP_CONTINENT			= "Show Continent in Tooltip";
	BRL_MOVABLE_FRAME_ENABLE				= "Show Moveable Frame"; --New


	-- ***RECOMMENDED LEVEL  INFORMATION*** --
	BMRECLEVEL_TITLE						= "Bhaldie Recommended Level";
	BMRECLEVEL_VERSION						= "2.15";
	BMRECLEVEL_DESCRIPTION				= "Displays the zone level ranage of the zone you are in and also gives you a suggest zone to be in.";
	BMRECLEVEL_LOADED						= "|cffffff00" .. BMRECLEVEL_TITLE .. " v" .. BMRECLEVEL_VERSION .. " loaded";
	
	-- *** TABLE VARIABLES *** --
	BRL_EASTERNKINGDOM					= "Eastern Kingdoms";
	BRL_KALIMDOR							= "Kalimdor";


	-- ***LIST OF ZONES*** --
	ZONE_TABLE = {
				["ironforge"]			="City of Ironforge",
				["stormwind"]			="Stormwind City",
				["undercity"]			="The Undercity",
				["dun_morogh"]		="Dun Morogh",
				["elwynn_forest"]		="Elwynn Forest",
				["tirisfal_glades"]		="Tirisfal Glades",
				["loch_modan"]		="Loch Modan",
				["westfall"]			="Westfall",
				["silverpine"]			="Silverpine Forest",
				["redridge"]			="Redridge Mountains",
				["wetlands"]			="Wetlands",
				["duskwood"]			="Duskwood",
				["hillsbrad"]			="Hillsbrad Foothills",
				["alterac"]			="Alterac Mountains",
				["arathi"]			="Arathi Highlands",
				["badlands"]			="Badlands",
				["stranglethorn"]		="Stranglethorn Vale",
				["swamp_sorrows"]	="Swamp of Sorrows",
				["blasted_lands"]		="Blasted Lands",
				["searing_gorge"]		="Searing Gorge",
				["hinterlands"]		="The Hinterlands",
				["blackrock"]			="Blackrock Mountain",
				["burning_steppes"]	="Burning Steppes",
				["deadwind"]			="Deadwind Pass",
				["eastern_plague"]	="Eastern Plaguelands",
				["western_plague"]	="Western Plaguelands",
				["darnassus"]			="City of Darnassus",
				["orgrimmar"]			= "City of Orgrimmar",
				["thunder_bluff"]		="City of Thunder Bluff",
				["durotar"]			="Durotar",
				["mulgore"]			="Mulgore",
				["teldrassil"]			="Teldrassil",
				["darkshore"]			="Darkshore",
				["barrens"]			="The Barrens",
				["ashenvale"]			="Ashenvale",
				["stonetalon"]		="Stonetalon Mountains",
				["thousand_needles"]	="Thousand Needles",
				["desolace"]			="Desolace",
				["dustwallow"]		="Dustwallow Marsh",
				["feralas"]			="Feralas",
				["silithus"]			="Silithus",
				["tanaris"]			="Tanaris",
				["ungoro"]			="Un'Goro Crater",
				["azshara"]			="Azshara",
				["felwood"]			="Felwood",
				["moonglade"]		="Moonglade",
				["wintersprings"]		="Winterspring",
	}
	-- ***LIST OF INSTANCES***
	INSTANCE_TABLE = {
				["ironforge_instances"]		= {{["instance"] = BRL_NONE}},
				["stormwind_instances"]		= {{["itype"] = "instance", ["instance"] = "Stockades", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_ALLIANCE}},
				["undercity_instances"]		= {{["instance"] = BRL_NONE}},
				["dun_morogh_instances"]		= {{["itype"] = "instance", ["instance"] = "Gnomeregan", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_ALLIANCE}}, 
				["elwynn_forest_instances"]	= {{["instance"] = BRL_NONE}},
				["tirisfal_glades_instances"]	= {{["itype"] = "instance", ["instance"] = "Scarlet Monastary", ["low_level"] = 34, ["high_level"] = 45, ["faction"] = BRL_NONE}},
				["loch_modan_instances"]		= {{["instance"] = BRL_NONE}},
				["westfall_instances"]			= {{["itype"] = "instance", ["instance"] = "The Deadmines", ["low_level"] = 17, ["high_level"] = 26, ["faction"] = BRL_ALLIANCE}},
				["silverpine_instances"]		= {{["itype"] = "instance", ["instance"] = "Shadowfang Keep", ["low_level"] = 22, ["high_level"] = 30, ["faction"] = BRL_HORDE}},
				["redridge_instances"]			= {{["instance"] = BRL_NONE}},
				["wetlands_instances"]		= {{["instance"] = BRL_NONE}},
				["duskwood_instances"]		= {{["instance"] = BRL_NONE}},
				["hillsbrad_instances"]			= {{["instance"] = BRL_NONE}},
				["alterac_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Alterac Valley", ["low_level"] = 51, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["arathi_instances"]			= {{["itype"] = "battlegrounds", ["instance"] = "Arathi Basin", ["low_level"] = 20, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["badlands_instances"]		= {{["itype"] = "instance", ["instance"] = "Uldaman", ["low_level"] = 41, ["high_level"] = 51, ["faction"] = BRL_NONE}},
				["stranglethorn_instances"]	= {{["itype"] = "instance", ["instance"] = "Zul'Grub", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["swamp_sorrows_instances"]	= {{["itype"] = "instance", ["instance"] = "Sunken Temple of Atal'Hakkar", ["low_level"] = 50, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["blasted_lands_instances"]	= {{["instance"] = BRL_NONE}},
				["searing_gorge_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Molten Core", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackwing Lair", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Spire", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Depths", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["hinterlands_instances"]		= {{["instance"] = BRL_NONE}},
				["blackrock_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Molten Core", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackwing Lair", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Spire", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Depths", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["burning_steppes_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Molten Core", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackwing Lair", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Spire", ["low_level"] = 55, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Blackrock Depths", ["low_level"] = 52, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["deadwind_instances"]		= {{["instance"] = BRL_NONE}},
				["eastern_plague_instances"]	= {
												{["itype"] = "instance", ["instance"] = "Stratholme", ["low_level"] = 58, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Naxxramas", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["western_plague_instances"]	= {{["itype"] = "instance", ["instance"] = "Scholomance", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["darnassus_instances"]		= {{["instance"] = BRL_NONE}},
				["orgrimmar_instances"]		= {{["itype"] = "instance", ["instance"] = "Ragefire Chasm", ["low_level"] = 13, ["high_level"] = 18, ["faction"] = BRL_HORDE}},
				["thunder_bluff_instances"]	= {{["instance"] = BRL_NONE}},
				["durotar_instances"]			= {{["instance"] = BRL_NONE}},
				["mulgore_instances"]			= {{["instance"] = BRL_NONE}},
				["teldrassil_instances"]		= {{["instance"] = BRL_NONE}},
				["darkshore_instances"]		= {{["instance"] = BRL_NONE}},
				["barrens_instances"]			= {
												{["itype"] = "instance", ["instance"] = "Wailing Caverns", ["low_level"] = 17, ["high_level"] = 24, ["faction"] = BRL_HORDE},
												{["itype"] = "instance", ["instance"] = "Razorfen Kraul", ["low_level"] = 29, ["high_level"] = 38, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Razorfen Downs", ["low_level"] = 37, ["high_level"] = 46, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Warsong Gulch", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_HORDE},
											},
				["ashenvale_instances"]		= {
												{["itype"] = "instance", ["instance"] = "Blackfathom Deeps", ["low_level"] = 24, ["high_level"] = 32, ["faction"] = BRL_NONE},
												{["itype"] = "battlegrounds", ["instance"] = "Warsong Gulch", ["low_level"] = 10, ["high_level"] = 60, ["faction"] = BRL_ALLIANCE},
											},
				["stonetalon_instances"]		= {{["instance"] = BRL_NONE}},
				["thousand_needles_instances"] = {{["instance"] = BRL_NONE}},
				["desolace_instances"]		= {{["itype"] = "instance", ["instance"] = "Maraudon", ["low_level"] = 46, ["high_level"] = 55, ["faction"] = BRL_NONE}},
				["dustwallow_instances"]		= {{["itype"] = "instance", ["instance"] = "Onyxia's Lair", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["feralas_instances"]			= {{["itype"] = "instance", ["instance"] = "Dire Maul", ["low_level"] = 56, ["high_level"] = 60, ["faction"] = BRL_NONE}},
				["silithus_instances"]			= {
												{["itype"] = "instance", ["instance"] = "Ruins of Ahn'Qiraj", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
												{["itype"] = "instance", ["instance"] = "Temple of Ahn'Qiraj", ["low_level"] = 60, ["high_level"] = 60, ["faction"] = BRL_NONE},
											},
				["tanaris_instances"]			= {{["itype"] = "instance", ["instance"] = "Zul'Farrak", ["low_level"] = 44, ["high_level"] = 54, ["faction"] = BRL_NONE}},
				["ungoro_instances"]			= {{["instance"] = BRL_NONE}},
				["azshara_instances"]			= {{["instance"] = BRL_NONE}},
				["felwood_instances"]			= {{["instance"] = BRL_NONE}},
				["moonglade_instances"]		= {{["instance"] = BRL_NONE}},
				["wintersprings_instances"]	= {{["instance"] = BRL_NONE}},
	}
end

function Common_Variables()
	-- ***FRAME TEXT*** --
	BRL_ZONE_RANGE					= BM_WHITE .. BRL_TOOLTIP_RRANGE .. BM_FONT_OFF;
	RECOMMEND_TEXT_RED			= BM_RED.."%d-%d"..BM_FONT_OFF;
	RECOMMEND_TEXT_GREEN			= BM_GREEN.."%d-%d"..BM_FONT_OFF;
	RECOMMEND_TEXT_YELLOW		= BM_YELLOW.."%d-%d"..BM_FONT_OFF;
	RECOMMEND_TEXT_GRAY			= BM_GRAY.."%d-%d"..BM_FONT_OFF;
	RECOMMEND_TEXT_WHITE			= BM_WHITE .. "%s" .. BM_FONT_OFF;

	-- ***MAP TEXT*** --
	REC_WORLDMAP_TEXT_RED		= BM_RED .."(%d-%d)".. BM_FONT_OFF .. "\n\n";
	REC_WORLDMAP_TEXT_GREEN		= BM_GREEN .."(%d-%d)".. BM_FONT_OFF .. "\n\n";
	REC_WORLDMAP_TEXT_YELLOW	= BM_YELLOW .."(%d-%d)".. BM_FONT_OFF .. "\n\n";
	REC_WORLDMAP_TEXT_GRAY		= BM_GRAY .."(%d-%d)".. BM_FONT_OFF .. "\n\n";
	REC_WORLDMAP_TEXT			= BM_WHITE .."%s".. BM_FONT_OFF .. "\n\n";

	-- ***TOOLTIP AND MAP TEXT*** --
	BM_REC_LEVEL_TOOLTIP_TEXT = "";
	BM_REC_ZONE = "";
	BM_PLAYER_LEVEL = 0;
	BM_RECOMMEND = {
				[0] = {
					["zone"] =ZONE_TABLE["ironforge"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["ironforge_instances"],
				},
				[1] = {
					["zone"] =ZONE_TABLE["stormwind"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["stormwind_instances"],
				},
				[2] = {
					["zone"] = ZONE_TABLE["undercity"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["undercity_instances"],
				},
				[3] = {
					["zone"] =ZONE_TABLE["dun_morogh"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["dun_morogh_instances"],
				},
				[4] = {
					["zone"] =ZONE_TABLE["elwynn_forest"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["elwynn_forest_instances"],
				},
				[5] = {
					["zone"] =ZONE_TABLE["tirisfal_glades"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_HORDE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["tirisfal_glades_instances"],
				},
				[6] = {
					["zone"] =ZONE_TABLE["loch_modan"],
					["low_level"] = 10,
					["high_level"] = 20,
					["range_level"] = 10,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["loch_modan_instances"],

				},
				[7] = {
					["zone"] =ZONE_TABLE["westfall"],
					["low_level"] = 10,
					["high_level"] = 20,
					["range_level"] = 10,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["westfall_instances"],
				},
				[8] = {
					["zone"] =ZONE_TABLE["silverpine"],
					["low_level"] = 10,
					["high_level"] = 20,
					["range_level"] = 10,
					["player_faction"] = BRL_HORDE,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["silverpine_instances"],
				},
				[9] = {
					["zone"] =ZONE_TABLE["redridge"],
					["low_level"] = 15,
					["high_level"] = 25,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["redridge_instances"],
				},
				[10] = {
					["zone"] =ZONE_TABLE["wetlands"],
					["low_level"] = 20,
					["high_level"] = 30,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["wetlands_instances"],
				},
				[11] = {
					["zone"] =ZONE_TABLE["duskwood"],
					["low_level"] = 20,
					["high_level"] = 30,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["duskwood_instances"],
				},
				[12] = {
					["zone"] =ZONE_TABLE["hillsbrad"],
					["low_level"] = 20,
					["high_level"] = 30,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["hillsbrad_instances"],
				},
				[13] = {
					["zone"] =ZONE_TABLE["alterac"],
					["low_level"] = 30,
					["high_level"] = 40,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["alterac_instances"],
				},
				[14] = {
					["zone"] =ZONE_TABLE["arathi"],
					["low_level"] = 30,
					["high_level"] = 40,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["arathi_instances"],
				},
				[15] = {
					["zone"] =ZONE_TABLE["badlands"],
					["low_level"] = 35,
					["high_level"] = 45,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["badlands_instances"],
				},
				[16] = {
					["zone"] =ZONE_TABLE["stranglethorn"],
					["low_level"] = 30,
					["high_level"] = 45,
					["range_level"] = 15,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["stranglethorn_instances"],
				},
				[17] = {
					["zone"] =ZONE_TABLE["swamp_sorrows"],
					["low_level"] = 35,
					["high_level"] = 45,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["swamp_sorrows_instances"],
				},
				[18] = {
					["zone"] =ZONE_TABLE["blasted_lands"],
					["low_level"] = 47,
					["high_level"] = 55,
					["range_level"] = 8,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["blasted_lands_instances"],
				},
				[19] = {
					["zone"] =ZONE_TABLE["searing_gorge"],
					["low_level"] = 43,
					["high_level"] = 50,
					["range_level"] = 7,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["searing_gorge_instances"],
				},
				[20] = {
					["zone"] =ZONE_TABLE["hinterlands"],
					["low_level"] = 40,
					["high_level"] = 50,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["hinterlands_instances"],
				},
				[21] = {
					["zone"] =ZONE_TABLE["blackrock"],
					["low_level"] = 50,
					["high_level"] = 60,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["blackrock_instances"],
				},
				[22] = {
					["zone"] =ZONE_TABLE["burning_steppes"],
					["low_level"] = 50,
					["high_level"] = 60,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["burning_steppes_instances"],
				},
				[23] = {
					["zone"] =ZONE_TABLE["deadwind"],
					["low_level"] = 55,
					["high_level"] = 60,
					["range_level"] = 5,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["deadwind_instances"],
				},
				[24] = {
					["zone"] =ZONE_TABLE["eastern_plague"],
					["low_level"] = 55,
					["high_level"] = 60,
					["range_level"] = 5,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["eastern_plague_instances"],
				},
				[25] = {
					["zone"] =ZONE_TABLE["western_plague"],
					["low_level"] = 50,
					["high_level"] = 60,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_EASTERNKINGDOM,
					["instances"] = INSTANCE_TABLE["western_plague_instances"],
				},
				[26] = {
					["zone"] =ZONE_TABLE["darnassus"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["darnassus_instances"],
				},
				[27] = {
					["zone"] =ZONE_TABLE["orgrimmar"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["orgrimmar_instances"],
				},
				[28] = {
					["zone"] =ZONE_TABLE["thunder_bluff"],
					["low_level"] = 0,
					["high_level"] = 0,
					["range_level"] = 0,
					["player_faction"] = BRL_CITY,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["thunder_bluff_instances"],
				},
				[29] = {
					["zone"] =ZONE_TABLE["durotar"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_HORDE,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["durotar_instances"],
				},
				[30] = {
					["zone"] =ZONE_TABLE["mulgore"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_HORDE,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["mulgore_instances"],
				},
				[31] = {
					["zone"] =ZONE_TABLE["teldrassil"],
					["low_level"] = 1,
					["high_level"] = 12,
					["range_level"] = 11,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["teldrassil_instances"],
				},
				[32] = {
					["zone"] =ZONE_TABLE["darkshore"],
					["low_level"] = 10,
					["high_level"] = 20,
					["range_level"] = 10,
					["player_faction"] = BRL_ALLIANCE,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["darkshore_instances"],
				},
				[33] = {
					["zone"] =ZONE_TABLE["barrens"],
					["low_level"] = 10,
					["high_level"] = 25,
					["range_level"] = 15,
					["player_faction"] = BRL_HORDE,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["barrens_instances"],
				},
				[34] = {
					["zone"] =ZONE_TABLE["ashenvale"],
					["low_level"] = 15,
					["high_level"] = 30,
					["range_level"] = 15,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["ashenvale_instances"],
				},
				[35] = {
					["zone"] =ZONE_TABLE["stonetalon"],
					["low_level"] = 15,
					["high_level"] = 27,
					["range_level"] = 12,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["stonetalon_instances"],
				},
				[36] = {
					["zone"] =ZONE_TABLE["thousand_needles"],
					["low_level"] = 25,
					["high_level"] = 35,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["thousand_needles_instances"],
				},
				[37] = {
					["zone"] =ZONE_TABLE["desolace"],
					["low_level"] = 30,
					["high_level"] = 40,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["desolace_instances"],
				},
				[38] = {
					["zone"] =ZONE_TABLE["dustwallow"],
					["low_level"] = 35,
					["high_level"] = 45,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["dustwallow_instances"],
				},
				[39] = {
					["zone"] =ZONE_TABLE["feralas"],
					["low_level"] = 40,
					["high_level"] = 50,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["feralas_instances"],
				},
				[40] = {
					["zone"] =ZONE_TABLE["silithus"],
					["low_level"] = 55,
					["high_level"] = 60,
					["range_level"] = 5,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["silithus_instances"],
				},
				[41] = {
					["zone"] =ZONE_TABLE["tanaris"],
					["low_level"] = 40,
					["high_level"] = 50,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["tanaris_instances"],
				},
				[42] = {
					["zone"] =ZONE_TABLE["ungoro"],
					["low_level"] = 48,
					["high_level"] = 55,
					["range_level"] = 7,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["ungoro_instances"],
				},
				[43] = {
					["zone"] =ZONE_TABLE["azshara"],
					["low_level"] = 48,
					["high_level"] = 55,
					["range_level"] = 7,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["azshara_instances"],
				},
				[44] = {
					["zone"] =ZONE_TABLE["felwood"],
					["low_level"] = 48,
					["high_level"] = 55,
					["range_level"] = 7,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["felwood_instances"],
				},
				[45] = {
					["zone"] =ZONE_TABLE["moonglade"],
					["low_level"] = 50,
					["high_level"] = 60,
					["range_level"] = 10,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["moonglade_instances"],
				},
				[46] = {
					["zone"] =ZONE_TABLE["wintersprings"],
					["low_level"] = 55,
					["high_level"] = 60,
					["range_level"] = 5,
					["player_faction"] = BRL_CONTESTED,
					["continent"] = BRL_KALIMDOR,
					["instances"] = INSTANCE_TABLE["wintersprings_instances"],
				},

	}
end