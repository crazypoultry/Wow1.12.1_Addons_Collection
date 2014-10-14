--[[
FelwoodGather 
Timer manager for felwood fruit gathering.
Author: nor3
]]--

-- constant definition

FELWOODGATHER_VERSION="0.98";

FELWOODGATHER_TIMER = 1500;
FELWOODGATHER_TIMER_WARN1 = 300;
FELWOODGATHER_TIMER_WARN2 = 60;
FELWOODGATHER_CHECK_INTERVAL=3.0;
FELWOODGATHER_NOTIFY="TellMessage";
FWG_BROADCAST_HEADER="<FWGBRDCST>";

FELWOODGATHER_ACTIVE = false;
FelwoodGather_WorldMapDetailFrameWidth = 0;
FelwoodGather_WorldMapDetailFrameHeight = 0;
FelwoodGather_Config = {
	notify=true,
	warn1=FELWOODGATHER_TIMER_WARN1,
	warn2=FELWOODGATHER_TIMER_WARN2,
	acceptTimer=true,
	alpha=0.7,
	scale=12,
	countdown=5,
	minimap = true,
	minimapInterval = 0.3,
	useMsg = true
};
FelwoodGather_DebugMode=false;
FelwoodGather_DebugLevel=0;
--[[
FelwoodGather_Details = {
	name      = FELWOODGATHER_FELWOODGATHER,
	version   = FELWOODGATHER_VERSION,
	author    = "nor3",
	email     = "norf@asuraguild.org",
	website   = "http://asuraguild.org/nor3/archives/AddOn/FelwoodGather/",
	category  = MYADDONS_CATEGORY_MAP
};
]]--

FelwoodGather_Help = {};
FelwoodGather_Help[1] = FELWOODGATHER_HELPMSG1;
FelwoodGather_Help[2] = FELWOODGATHER_HELPMSG2;
FelwoodGather_Help[3] = FELWOODGATHER_HELPMSG3;
FelwoodGather_Help[4] = FELWOODGATHER_HELPMSG4;
FelwoodGather_Help[5] = FELWOODGATHER_HELPMSG5;

-- Object Infomation
FelwoodGather_WorldObjs = {
	[1] = {x = 49.42668974399567, y = 12.17063516378403, timer = 0, status = 0,
		item     = FWG_WHIPPER_ROOT_TUBER,
	 	location = FWG_NORTH_FELWOOD, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE
	}, 
	[2] = {x = 42.46181547641754, y = 13.91413062810898, timer = 0, status = 0,
		item     = FWG_NIGHT_DRAGON_BREATH,
	 	location = FWG_JADEFIRE_RUN,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_NDB_TEXTURE 
	},
	[3] = {x = 40.72512984275818, y = 19.1241592168808, timer = 0, status = 0,
		item     = FWG_WHIPPER_ROOT_TUBER, 
		location = FWG_JADEFIRE_RUN, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE 
	},
	[4] = {x = 50.58137178421021, y = 18.25950741767883, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
 		location = FWG_IRONTREE_WOODS,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE 
	},
	[5] = {x = 50.58045387268066, y = 30.43979704380035, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH,
	 	location = FWG_GRAVEYARD,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_NDB_TEXTURE 
	},
	[6] = {x = 43.04592311382294, y = 46.96584641933441, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
 		location = FWG_FALLS, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE 
	},
	[7] = {x = 34.06030833721161, y = 60.22599339485169, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER, 
		location = FWG_JADENAR, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE 
	}, 
	[8] = {x = 35.10781228542328, y = 58.92908573150635, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH,
		location = FWG_JADENAR, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_NDB_TEXTURE 
	}, 
	[9] = {x = 40.72316586971283, y = 78.26110124588013, timer = 0, status = 0, 
		item     = FWG_NIGHT_DRAGON_BREATH, 
		location = FWG_JADEFIRE_GLEN, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_NDB_TEXTURE 
	}, 
	[10] = { x = 40.14275968074799, y = 85.20773649215698, timer = 0, status = 0, 
		item     = FWG_WHIPPER_ROOT_TUBER,
		location = FWG_JADEFIRE_GLEN, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WRT_TEXTURE 
	},
	[11] = { x = 55.79817891120911, y =  06.95948526263237, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_NORTH_FELWOOD, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[12] = { x = 45.36115825176239, y = 18.25985163450241, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADEFIRE_RUN, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[13] = { x = 38.7915700674057, y = 21.9449520111084, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADEFIRE_RUN, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[14] = { x = 44.78032290935516, y = 41.73710644245148, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_SHATTER_SCAR_VALE, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[15] = { x = 34.34630036354065, y = 48.69555830955505, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_RIVER, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[16] = { x = 38.98676931858063, y = 59.1268002986908, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADENAR, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[17] = { x = 36.56003475189209, y = 61.97691559791565, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_JADENAR, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[18] = { x = 49.99851882457733, y = 80.00218868255615, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_EMERALD_SANCTUARY, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[19] = { x = 55.21707534790039, y = 23.47771376371384, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_IRONTREE_WOODS, 
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[20] = { x = 57.53765106201172, y = 20.00246793031693, timer = 0, status = 0, 
		item     = FWG_WINDBLOSSOM_BERRIES,
		location = FWG_IRONTREE_WOODS,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_WBB_TEXTURE 
	},
	[21] = { x = 48.26133251190186, y = 75.65300464630127, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_EMERALD_SANCTUARY,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[22] = { x = 63.91310095787048, y = 6.086909770965576, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_FELPAW_VILLAGE,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[23] = { x = 45.94005942344666, y = 85.21153926849365, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_JADEFIRE_GLEN,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[24] = { x = 40.14521837234497, y = 44.34954524040222, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_SHATTER_SCAR_VALE,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[25] = { x = 40.13031125068665, y = 56.4990222454071, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_JADENAR,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[26] = { x = 52.90505886077881, y = 87.82834410667419, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_DEADWOOD_VILLAGE,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[27] = { x = 63.34181427955627, y = 22.58936911821365, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_TALONBRANCH_GLADE,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[28] = { x = 50.56964159011841, y = 13.91630917787552, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_NORTH_FELWOOD,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	},
	[29] = { x = 55.79237341880798, y = 10.42394265532494, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_NORTH_FELWOOD,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 

 	},
	[30] = { x = 34.35567021369934, y = 52.17941403388977, timer = 0, status = 0, 
		item     = FWG_SONGFLOWER,
		location = FWG_BLOODVENOM_OUTPOST,
		isThere = true,
		firstSeen = 0,
		times = 0,
		texture  = FWG_CSF_TEXTURE 
	}
};


-- quick pointer to latest object (next spawn)
FelwoodGather_Latest={};
FelwoodGather_Latest.index = 0;
FelwoodGather_Latest.timer = 0;

-- count down caller
FelwoodGather_PickupCount = {};
FelwoodGather_PickupCount.inProgress=false;
FelwoodGather_PickupCount.count = 0;

-- color map
FelwoodGather_LabelColorPast      ={ r=0.7, g=0.7, b=0.7 };
FelwoodGather_LabelColorWarn2     ={ r=1.0, g=0.0, b=0.0 };
FelwoodGather_LabelColorWarn1     ={ r=1.0, g=1.0, b=0.0 };
FelwoodGather_LabelColorNormal    ={ r=0.0, g=1.0, b=0.0 };
FelwoodGather_LabelColorHighlight ={ r=1.0, g=1.0, b=1.0 };

-- minimap data
FelwoodGather_MinimapCoord = { 
	scale = 0.15625084006464, 
	offset_x = 0.41995800144849, 
	offset_y = 0.23097545880609 
};

FelwoodGather_MinimapScales = {};
FelwoodGather_MinimapScales[0] = { xscale = 11016.6, yscale = 7399.9 };
FelwoodGather_MinimapScales[1] = { xscale = 12897.3, yscale = 8638.1 };
FelwoodGather_MinimapScales[2] = { xscale = 15478.8, yscale = 10368.0 };
FelwoodGather_MinimapScales[3] = { xscale = 19321.8, yscale = 12992.7 };
FelwoodGather_MinimapScales[4] = { xscale = 25650.4, yscale = 17253.2 };
FelwoodGather_MinimapScales[5] = { xscale = 38787.7, yscale = 26032.1 };


-- ***************** Zone finder **********************

FelwoodGather_Continents = {};
FelwoodGather_MapZones = {};

function FelwoodGather_LoadContinents(...)
   for i=1, arg.n do
      FelwoodGather_Continents[i] = arg[i];
   end
end
function FelwoodGather_LoadMapZones(...)
   for i=1, arg.n do
      FelwoodGather_MapZones[i] = arg[i];
   end
end


-- ***************** Handlers **********************

function FelwoodGather_OnLoad()
	-- Event Registration
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("CLOSE_WORLD_MAP");
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_RAID");
	this:RegisterEvent("CHAT_MSG_RAID_LEADER");
	this:RegisterEvent("CHAT_MSG_PARTY");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("CHAT_MSG_ADDON");

	-- command registration
	SLASH_FELWOODGATHER1="/felwoodgather";
	SLASH_FELWOODGATHER2="/fwg";

	SlashCmdList["FELWOODGATHER"] = function (msg)
		FelwoodGahter_SlashCmd(msg);
	end
end

-- Slash Command Handler
function FelwoodGahter_SlashCmd(msg)
	msg = string.lower (msg);
	if (msg == FWG_SUBCOMMAND_SHARE) then
		FelwoodGather_ShareTimer();
	elseif (msg == FWG_SUBCOMMAND_CONFIG) then
		FelwoodGather_ToggleConfigWindow();
	elseif (msg == FWG_SUBCOMMAND_COUNT ) then
		FelwoodGather_PickupCountDown(true);
	elseif (msg == FWG_SUBCOMMAND_MAP) then
		FelwoodGatherMap_ToggleMapWindow();
	elseif (msg == FWG_SUBCOMMAND_RESET) then
		FelwoodGatherMap_ResetMapPosition();
	elseif (msg == FWG_SUBCOMMAND_MINIMAP) then
		FelwoodGather_ToggleMiniMap();
	else
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG1);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG2);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG3);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG4);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG5);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG6);
		DEFAULT_CHAT_FRAME:AddMessage(FWG_SLASHHELPMSG7);
	end
end


function FelwoodGather_IsActivate() 
	if(table.getn(FelwoodGather_Continents) == 0) then
		FelwoodGather_Continents = {};
		FelwoodGather_MapZones = {};
		FelwoodGather_LoadContinents(GetMapContinents());
		for n, cont in FelwoodGather_Continents do
			if ( cont == FWG_KALIMDOR_MAPNAME ) then
				FelwoodGather_LoadMapZones(GetMapZones(n));
			end
		end
	end
	if((FelwoodGather_Continents[GetCurrentMapContinent()] == FWG_KALIMDOR_MAPNAME) and (FelwoodGather_MapZones[GetCurrentMapZone()]==FWG_FELWOOD_MAPNAME)) then
		return true;
	end
	return false;
end


-- OnEvent handler for main window
function FelwoodGather_OnEvent(event)
	if (strfind(event, "CHAT_MSG_LOOT")) then
		FelwoodGather_CheckAndStart(arg1);
	elseif ( event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS" ) then
		if ( arg1 == FWG_SONGFLOWER_BUFFMSG ) then
			FelwoodGather_CheckBuffAndStart();
		end
	elseif ( event == "UNIT_AURA") then
		if (arg1=="player") then
			FelwoodGather_CheckBuffAndStart();
		end
	elseif (event == "WORLD_MAP_UPDATE") then
		FELWOODGATHER_ACTIVE = FelwoodGather_IsActivate();
		if ( FELWOODGATHER_ACTIVE ) then
			FelwoodMapOverlayFrame:SetParent("WorldMapDetailFrame");
			FWGMapTooltip:SetParent("WorldMapFrame");
			FWGMapTooltip:SetFrameLevel(FelwoodMapOverlayFrame1:GetFrameLevel()+1)
			FelwoodMapOverlayFrame:SetPoint("TOPLEFT", "WorldMapDetailFrame","TOPLEFT", 0, 0);
			FelwoodGather_WorldMapDetailFrameWidth = WorldMapDetailFrame:GetWidth();
			FelwoodGather_WorldMapDetailFrameHeight = WorldMapDetailFrame:GetHeight();
			FelwoodMapOverlayFrame:Show();
			FelwoodGather_MainDraw();
		else
			FelwoodGather_HideAll();
		end
	elseif ( event == "CLOSE_WORLD_MAP") then
		FelwoodMapOverlayFrame:Hide();
		FelwoodGather_MainDraw();
	elseif( event == "ADDON_LOADED") then
		if( arg1 == FELWOODGATHER_FELWOODGATHER ) then
			-- myAddOns support
--			if ( myAddOnsFrame_Register ) then
--				myAddOnsFrame_Register(FelwoodGather_Details, FelwoodGather_Help);
--			end
			-- store MapWindow size
			FelwoodGather_WorldMapDetailFrameWidth = WorldMapDetailFrame:GetWidth();
			FelwoodGather_WorldMapDetailFrameHeight = WorldMapDetailFrame:GetHeight();
			FelwoodGather_Print("FelwoodGather by nor3 ver."..FELWOODGATHER_VERSION.." loaded.");
		end
	elseif (event == "VARIABLES_LOADED") then

		local playerName = UnitName("player");
		UIDropDownMenu_Initialize(FelwoodMainMenu, FelwoodMainMenu_Initialize, "MENU");
		-- TODO make charscter depends settings.
		if ((playerName) and (playerName ~= UNKNOWNOBJECT)) then
-- TODO
			if( FelwoodGather_Config.notify == nil ) then
				FelwoodGather_Config.notify = true;
			end
			if( FelwoodGather_Config.warn1 == nil ) then
				FelwoodGather_Config.warn1 = FELWOODGATHER_TIMER_WARN1;
			end
			if( FelwoodGather_Config.warn2 == nil ) then
				FelwoodGather_Config.warn2 = FELWOODGATHER_TIMER_WARN2;
			end
			if( FelwoodGather_Config.acceptTimer == nil ) then
				FelwoodGather_Config.acceptTimer = true;
			end
			if( FelwoodGather_Config.alpha == nil ) then
				FelwoodGather_Config.alpha = 0.7;
			end
			if( FelwoodGather_Config.scale == nil ) then
				FelwoodGather_Config.scale = 12;
			end
			if( FelwoodGather_Config.countdown == nil ) then
				FelwoodGather_Config.countdown = 5;
			end
			if ( FelwoodGather_Config.minimap == nil ) then
				FelwoodGather_Config.minimap = true;
			end
			if ( FelwoodGather_Config.minimapInterval == nil ) then
				FelwoodGather_Config.minimapInterval = 0.3;
			end
			if ( FelwoodGather_Config.useMsg == nil ) then
				FelwoodGather_Config.useMsg = true;
			end
		end
		FelwoodGather_Options_Init();
	elseif ( event == "ZONE_CHANGED_NEW_AREA" or event == "PLAYER_ENTERING_WORLD") then
		local curZone = GetRealZoneText();
		if( (curZone ~= nil) and curZone ~= FWG_FELWOOD_MAPNAME) then
			FelwoodGather_HideMinimapPOI();
		end
	elseif( event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" ) then
		if (not FELWOODGATHER_ACTIVE) then
			return;
		end
		if (strsub(arg1, 1, string.len(FWG_BROADCAST_HEADER)) == FWG_BROADCAST_HEADER) then
			FelwoodGather_ParseMessage(arg1);
		end
	elseif( event == "CHAT_MSG_PARTY") then
		if (not FELWOODGATHER_ACTIVE) then
			return;
		end
		if (strsub(arg1, 1, string.len(FWG_BROADCAST_HEADER)) == FWG_BROADCAST_HEADER) then
			FelwoodGather_ParseMessage(arg1);
		end
	elseif ( event == "CHAT_MSG_ADDON" ) then
		if (  arg1 == "FWG" ) then
			FelwoodGather_ParseMessage(arg2);
		end
	else
		FelwoodGather_Print("Unknown event: "..event);
	end
end

-- map update handler (seems main window not updated while map window open.)
function FelwoodGather_MapUpdate(elapsed)
	if (not FelwoodGather_UpdateMapTimer ) then
		FelwoodGather_UpdateMapTimer = 0;
	else
		FelwoodGather_UpdateMapTimer = FelwoodGather_UpdateMapTimer + elapsed;
		if (FelwoodGather_UpdateMapTimer > FELWOODGATHER_CHECK_INTERVAL) then
			FelwoodGather_UpdateMapTimer = 0;
			FelwoodGather_MainDraw();
		end
	end
end

-- timer update handler 
function FelwoodGather_TimeCheck(elapsed)
--	if ((not FELWOODGATHER_ACTIVE) or (not FelwoodGather_Config.notify)) then
--		return;
--	end
	if (not FelwoodGather_UpdateTimer) then
		FelwoodGather_UpdateTimer = 0;
	else
		FelwoodGather_UpdateTimer = FelwoodGather_UpdateTimer + elapsed;
		if (FelwoodGather_UpdateTimer > FELWOODGATHER_CHECK_INTERVAL) then
			FelwoodGather_UpdateTimer = 0;
			FelwoodGather_OnUpdate();
		end
	end
	-- countdown check
	if(FelwoodGather_PickupCount.inProgress) then
		FelwoodGather_PickupCount.elapse = FelwoodGather_PickupCount.elapse + elapsed;
		if(FelwoodGather_PickupCount.elapse > 1 ) then
			FelwoodGather_PickupCount.elapse = FelwoodGather_PickupCount.elapse -1;
			FelwoodGather_PickupCountDown(false);
		end
	end
	if (not FelwoodGather_MinimapTimer ) then
		FelwoodGather_MinimapTimer = 0;
	else
		FelwoodGather_MinimapTimer = FelwoodGather_MinimapTimer + elapsed;
		if (FelwoodGather_MinimapTimer > FelwoodGather_Config.minimapInterval) then
			FelwoodGather_MinimapTimer = 0;
			FelwoodGather_MinimapDraw();
		end
	end
end

-- parser for share timer message
function FelwoodGather_ParseMessage(msg)
	if( not FelwoodGather_Config.acceptTimer ) then
		return;
	end
	local useless1, useless2, var0, var1, var2, var3 = string.find(msg, FELWOODGATHER_PARSE_FORMAT);
--	FelwoodGather_Print(useless1 .. ", "..  useless2 .. ", "..  var1 .. ", "..  var2);
	curTime = GetTime();
	if ( tonumber(var1) and tonumber(var2) and tonumber(var3)) then
		FelwoodGather_SetTimer(tonumber(var1), curTime + tonumber(var2)*60 + tonumber(var3) - FELWOODGATHER_TIMER);
	end

end

-- Main drawer function
function FelwoodGather_MainDraw()
	FelwoodGather_DebugPrint("FelwoodGather_MainDraw called.");
	if(not FELWOODGATHER_ACTIVE) then
		return;
	end
	local curTime = GetTime();
	local eta;
	local etatext;
	local seentext;
	for n, Objs in FelwoodGather_WorldObjs do 
		-- set texture
		local mainNoteTexture = getglobal("FelwoodMain"..n.."Texture");
		if (mainNoteTexture == nil) then 
			FelwoodGather_Print("get texture failed" .. n);
		else 
			mainNoteTexture:SetTexture(Objs.texture);
			if ( Objs.isThere == false ) then
				mainNoteTexture:SetVertexColor(0.5, 0.5, 0.5, 1);
			else 
				mainNoteTexture:SetVertexColor(1,1,1,1);
			end
		end

		-- draw icon
		local mainNote = getglobal("FelwoodMain"..n);

		mnX = Objs.x/100 * FelwoodGather_WorldMapDetailFrameWidth;
		mnY = -Objs.y/100 * FelwoodGather_WorldMapDetailFrameHeight;
--		FelwoodGather_Print("position["..n.."]=("..mnX..","..mnY..")");
		mainNote:SetPoint("CENTER", "FelwoodMapOverlayFrame", "TOPLEFT", mnX, mnY);
		mainNote:SetAlpha(FelwoodGather_Config.alpha);
		mainNote:SetWidth(FelwoodGather_Config.scale);
		mainNote:SetHeight(FelwoodGather_Config.scale);
		mainNote:Show();

		-- calculate estimation time
		if (Objs.timer == 0) then
			eta = nil;
			etatext = FWG_NO_TIMER;
		else
			eta = (Objs.timer + FELWOODGATHER_TIMER) - curTime;
			if(eta < 0 ) then
				est = "-";
			else 
				est = "";
			end
			d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
			etatext = format("%s%02d:%02d", est, m, s);
		end

		-- set tooltip text
		seentext = "";
		if (Objs.firstSeen ~= 0) then
			spent = GetTime() - Objs.firstSeen;
			d, h, m, s = ChatFrame_TimeBreakDown(spent);
			seentext = format(FWG_FIRSTSEEN_FORMAT, h,m,s);
		else
			seentext = FWG_NO_TIMER;
		end
		mainNote.toolTip = format(FWG_TOOLTIP_TEXT, Objs.item, Objs.location, etatext, seentext);
		mainNote.toolTip = mainNote.toolTip  .. format(FWG_TOOLTIP_TEXT_EXT, Objs.times);
--		mainNote:SetText(Objs.toolTip);

		-- set label text
		local mainNoteLabel = getglobal("FelwoodMain"..n.."Label");
		if (mainNoteLabel == nil) then 
--			FelwoodGather_Print("get label failed" .. n);
		else 
			mainNoteLabel:SetText(etatext);
			if (FelwoodGather_Latest.index == n ) then
--				mainNoteLabel:SetTextColor(0,1,1);
				mainNoteLabel:SetTextColor(FelwoodGather_LabelColorHighlight.r, 
							FelwoodGather_LabelColorHighlight.g, 
							FelwoodGather_LabelColorHighlight.b);
			else
--				mainNoteLabel:SetTextColor(1,1,1);
--[[
				local r = 1; g = 1; b = 1;
				local r = 1; g = 1; b = 1;
				if( eta < 0) then
					r=1; g=0; b=0;
				elseif (eta == 0) then
					r=0.7; g=0.7; b=0.7;
				else 
					r=1; g=1;
					b = eta / FELWOODGATHER_TIMER;
					if( b > 1) then
						b = 1;
					end
				end
]]--
				if ( Objs.timer == 0 ) then
					mainNoteLabel:SetTextColor(
						FelwoodGather_LabelColorPast.r, 
						FelwoodGather_LabelColorPast.g, 
						FelwoodGather_LabelColorPast.b);
				else
					if( eta < 0) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 2) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn2.r, 
							FelwoodGather_LabelColorWarn2.g, 
							FelwoodGather_LabelColorWarn2.b);
					elseif (Objs.status == 1) then
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorWarn1.r, 
							FelwoodGather_LabelColorWarn1.g, 
							FelwoodGather_LabelColorWarn1.b);
					else
						mainNoteLabel:SetTextColor(
							FelwoodGather_LabelColorNormal.r, 
							FelwoodGather_LabelColorNormal.g, 
							FelwoodGather_LabelColorNormal.b);
					end
				end
--				mainNoteLabel:SetTextColor(r, g, b);
			end
			mainNoteLabel:Show();
		end
	end
end

-- trigger timer function
function FelwoodGather_CheckSongflowerBuff() 
	for i=0,23 do
		local buffIndex, untilCancelled = GetPlayerBuff(i, HELPFUL);
		if (buffIndex >= 0) then
			FWGBuffTooltip:SetPlayerBuff(buffIndex);
			buffname = FWGBuffTooltipTextLeft1:GetText();
			if (buffname~= nil and buffname == FWG_SONGFLOWER_BUFFNAME) then
				FelwoodGather_DebugPrint("find songflower buf");
				if(3590 < GetPlayerBuffTimeLeft(buffIndex)) then
					return true;
				else 
					--found songflower but too short remains. ignore it.
					return false;
				end
			else
				if( buffname ~= nil ) then
					FelwoodGather_DebugPrint("unmatch:".. buffname);
				else
					FelwoodGather_DebugPrint("buffname returned nil");
				end
			end
			-- continue until songflower found.
		end
	end
	return false;
end
function FelwoodGather_CheckBuffAndStart()
	if(not FELWOODGATHER_ACTIVE ) then
		return;
	end

--	if ( arg1 == "You gain Songflower Serenade" ) then
	if (FelwoodGather_CheckSongflowerBuff()) then
		x, y = GetPlayerMapPosition("player");
		x= x*100;
		y= y*100;
		curTime = GetTime();
		for n, Objs in FelwoodGather_WorldObjs do 
			if( (Objs.x - x)*(Objs.x - x)+(Objs.y - y)*(Objs.y - y) < 2) then
				if ( Objs.timer < curTime - 10) then
					-- avoid dup
					Objs.times = Objs.times + 1 ;
				end
				Objs.timer = curTime;
				Objs.status = 0;
				if (Objs.isThere == false) then
					Objs.isThere = true;
					Objs.firstSeen = curTime;
				elseif ( Objs.firstSeen == 0 ) then
					Objs.firstSeen = curTime;
				end
				-- send rosters
				if( FelwoodGather_Config.useMsg ) then
					local channel = nil;
					if (GetNumRaidMembers() > 0) then
						channel = "RAID";
					elseif (GetNumPartyMembers() > 0) then
						channel = "PARTY";
					end
					if( channel ~= nil ) then
						eta = FELWOODGATHER_TIMER;
						d, h, m, s = ChatFrame_TimeBreakDown(eta);
						message = string.format(FELWOODGATHER_SHARE_TIMER_FORMAT, FWG_BROADCAST_HEADER, n, m, s, Objs.item, Objs.location, Objs.x, Objs.y);
						SendAddonMessage("FWG", message, channel);
					end
				end
				
			else 
				if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
				((FelwoodGather_Latest.timer == 0) or (FelwoodGather_Latest.timer > Objs.timer))) then
					FelwoodGather_Latest.index = n;
					FelwoodGather_Latest.timer = Objs.timer;
				end
			end
		end
	else 
		FelwoodGather_DebugPrint("FelwoodGather_CheckBuffAndStart checked but ignored this loot.");
	end
end


function FelwoodGather_CheckAndStart(arg1) 
	if(not FELWOODGATHER_ACTIVE) then
		return;
	end
--	local iStart, iEnd, sItem = string.find(arg1, FWG_LOOTMSG_MATCH_PATTERN);
--	if(( sItem ~= nil ) and ((sItem == "[Night Dragon's Breath]") or (sItem =="[Whipper Root Tuber]"))) then
	if(( string.find(arg1, FWG_NIGHT_DRAGON_BREATH)) 
		or (string.find(arg1, FWG_WINDBLOSSOM_BERRIES))
		or (string.find(arg1, FWG_WHIPPER_ROOT_TUBER))) then

		x, y = GetPlayerMapPosition("player");
		x= x*100;
		y= y*100;
		curTime = GetTime();
		for n, Objs in FelwoodGather_WorldObjs do 
			if( (Objs.x - x)*(Objs.x - x)+(Objs.y - y)*(Objs.y - y) < 2) then
				Objs.timer = curTime;
				Objs.status = 0;
				Objs.times = Objs.times + 1;
				if(Objs.isThere == false) then
					Objs.isThere = true;
					Objs.firstSeen = curTime;
				elseif (Objs.firstSeen == 0) then
					Objs.firstSeen = curTime;
				end
				if( FelwoodGather_Config.useMsg ) then
					local channel = nil;
					if (GetNumRaidMembers() > 0) then
						channel = "RAID";
					elseif (GetNumPartyMembers() > 0) then
						channel = "PARTY";
					end
					if( channel ~= nil ) then
						eta = FELWOODGATHER_TIMER;
						d, h, m, s = ChatFrame_TimeBreakDown(eta);
						message = string.format(FELWOODGATHER_SHARE_TIMER_FORMAT, FWG_BROADCAST_HEADER, n, m, s, Objs.item, Objs.location, Objs.x, Objs.y);
						SendAddonMessage("FWG", message, channel);
					end
				end
			else 
				if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
				((FelwoodGather_Latest.timer == 0) or (FelwoodGather_Latest.timer > Objs.timer))) then
					FelwoodGather_Latest.index = n;
					FelwoodGather_Latest.timer = Objs.timer;
				end
			end
		end
	else 
		FelwoodGather_DebugPrint("FelwoodGather_CheckAndStart checked but ignored this loot.");
	end
end

-- hide window
function FelwoodGather_HideAll()
	for n, Objs in FelwoodGather_WorldObjs do 
		local mainNote = getglobal("FelwoodMain"..n);
		mainNote:Hide();
	end
end

-- timer update function with notification check.
function FelwoodGather_OnUpdate()
	FelwoodGather_DebugPrint("FelwoodGather_OnUpdate called");
	local curTime = GetTime();

	if (curTime > FelwoodGather_Latest.timer + FELWOODGATHER_TIMER ) then
		FelwoodGather_Latest.index = 0;
		FelwoodGather_Latest.timer = 0;
	end
	for n, Objs in FelwoodGather_WorldObjs do 
		if (Objs.timer == 0) then
		else
			eta = (Objs.timer + FELWOODGATHER_TIMER) - curTime;
			if ((eta < FelwoodGather_Config.warn1) and (Objs.status < 1)) then
				Objs.status = 1;
				FelwoodGather_NotifyEstimate(Objs, eta, false);
			elseif ( (eta < FelwoodGather_Config.warn2) and (Objs.status <2) ) then
				Objs.status = 2;
				FelwoodGather_NotifyEstimate(Objs, eta, false);
			end
			if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
			(((FelwoodGather_Latest.timer == 0) and (eta > 0)) or (FelwoodGather_Latest.timer > Objs.timer))) then
				FelwoodGather_Latest.index = n;
				FelwoodGather_Latest.timer = Objs.timer;
			end
		end
		
	end
	FelwoodGather_CheckBuffAndStart();
	--alhamap support
	FelwoodGather_CheckAndOverlayAlphaMap();
end

function FelwoodGather_CheckAndOverlayAlphaMap()
	if (AlphaMapDetailFrame == nil ) then
		return;
	end
	if (AlphaMapDetailFrame:IsVisible()) then
		local curZone = GetRealZoneText();
		if( (curZone ~= nil) and curZone == FWG_FELWOOD_MAPNAME) then
			FelwoodMapOverlayFrame:SetParent("AlphaMapDetailFrame");
			FelwoodMapOverlayFrame:SetParent("AlphaMapDetailFrame");
			FWGMapTooltip:SetParent("AlphaMapFrame");
			FWGMapTooltip:SetFrameLevel(AlphaMapDetailFrame:GetFrameLevel()+1)
			FelwoodMapOverlayFrame:SetPoint("TOPLEFT", "AlphaMapDetailFrame","TOPLEFT", 0, 0);
			FelwoodMapOverlayFrame:Show();
		else
			FelwoodMapOverlayFrame:Hide();
		end
	end
end

-- notifier
function FelwoodGather_NotifyEstimate(Objs, eta, useChannel) 
	if (not FelwoodGather_Config.notify ) then
		return;
	end
	local d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
	local message = format(FWG_NOTIFY_MESSAGE, Objs.item, m, s, Objs.location);
	if (useChannel) then
		local channel;
		if (GetNumRaidMembers() > 0) then
			channel = "RAID";
		elseif (GetNumPartyMembers() > 0) then
			channel = "PARTY";
		else
			return;
		end
		SendChatMessage(message, channel);
	else 
		FelwoodGather_Print(message);
	end
	PlaySound(FELWOODGATHER_NOTIFY);
end

-- broadcast timers 
-- test needed. I dont know whether the GetTime() values are same for everyone.
-- if not, this should send delta value.
function FelwoodGather_ShareTimer() 
	local channel;
	if (GetNumRaidMembers() > 0) then
		channel = "RAID";
	elseif (GetNumPartyMembers() > 0) then
		channel = "PARTY";
	else
		return;
	end
	local curTime = GetTime();
	local message;
	local count = 0;
	for n, Objs in FelwoodGather_WorldObjs do 
		if ((Objs.timer ~= 0) and (Objs.timer + FELWOODGATHER_TIMER > curTime)) then
			eta = Objs.timer + FELWOODGATHER_TIMER - curTime;
			d, h, m, s = ChatFrame_TimeBreakDown(eta);
			
			message = string.format(FELWOODGATHER_SHARE_TIMER_FORMAT, FWG_BROADCAST_HEADER, n, m, s, Objs.item, Objs.location, Objs.x, Objs.y);
			SendChatMessage(message, channel);
			count = count + 1;
		end
	end
	FelwoodGather_Print(count .. FWG_BROADCAST_COUNTS);
end

--for test
function FelwoodGather_SetTimer(n, time)
	if (FelwoodGather_WorldObjs[n]~=nil) then
		FelwoodGather_WorldObjs[n].timer=time;
		FelwoodGather_WorldObjs[n].status=0;

		FelwoodGather_Latest.index = 0;
		FelwoodGather_Latest.timer = 0;
		curTime = GetTime();
		for n, Objs in FelwoodGather_WorldObjs do 
			if ((Objs.timer + FELWOODGATHER_TIMER > curTime ) and
			((FelwoodGather_Latest.timer == 0) or (FelwoodGather_Latest.timer > Objs.timer))) then
				FelwoodGather_Latest.index = n;
				FelwoodGather_Latest.timer = Objs.timer;
			end
		end
	end
end

function FelwoodGather_Print(message)
	if ( DEFAULT_CHAT_FRAME ) then 
		DEFAULT_CHAT_FRAME:AddMessage(message or "", 1.0, 0.5, 0.25);
	end
end

function FelwoodGather_DebugModePrint(message, level)
	if (level < FelwoodGather_DebugLevel) then
		FelwoodGather_Print(message);
	end
end	

function FelwoodGather_DebugPrint(message)
	if (FelwoodGather_DebugMode) then
		FelwoodGather_Print(message);
	end
end	
-- ************** menu handler **********************
-- click handler
function FelwoodGather_OnClick(button, id, parent) 
	ToggleDropDownMenu(1, id, FelwoodMainMenu, parent, 0, 0);
end

-- Menu initializer
function FelwoodMainMenu_Initialize() 
	local info = {};

	if (UIDROPDOWNMENU_MENU_LEVEL == 2) then
	else
		info.isTitle = true;
		info.text = FELWOODGATHER_FELWOODGATHER.." "..FELWOODGATHER_VERSION;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_Announce;

		info.text = FELWOODGATHER_ANNOUNCE;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_StartTimer;
		info.text = FELWOODGATHER_STARTTIMER;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_ClearTimer;
		info.text = FELWOODGATHER_CLEARTIMER;
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_Menu_Mark;
		info.text = FELWOODGATHER_MARK_AS_DEPOP;
		if ( FelwoodGather_WorldObjs[UIDROPDOWNMENU_MENU_VALUE] ~= nil) then
			info.checked = not FelwoodGather_WorldObjs[UIDROPDOWNMENU_MENU_VALUE].isThere;
		else
			info.checked = false;
		end
		UIDropDownMenu_AddButton(info);

		info = {};
		info.func = FelwoodGather_ShareTimer;
		info.text = FELWOODGATHER_SHARETIMER;
		UIDropDownMenu_AddButton(info);
	end
end

function FelwoodGather_Menu_StartTimer()
	FelwoodGather_SetTimer(UIDROPDOWNMENU_MENU_VALUE, GetTime());
end

function FelwoodGather_Menu_ClearTimer() 
--	FelwoodGather_Print(UIDROPDOWNMENU_MENU_VALUE);
	FelwoodGather_SetTimer(UIDROPDOWNMENU_MENU_VALUE, 0);
end

function FelwoodGather_Menu_Mark()
	Objs = FelwoodGather_WorldObjs[UIDROPDOWNMENU_MENU_VALUE];
	if (Objs ~= nil) then
		if (Objs.isThere) then
			Objs.isThere = false;
			Objs.firstSeen = 0;
		else
			Objs.isThere = true;
			Objs.firstSeen = GetTime();
		end
	end
end

function FelwoodGather_Menu_Announce()
	Objs = FelwoodGather_WorldObjs[UIDROPDOWNMENU_MENU_VALUE];
	if ( (Objs ~= nil) and (Objs.timer ~= 0) ) then
		local eta = (Objs.timer + FELWOODGATHER_TIMER) - GetTime();
		FelwoodGather_NotifyEstimate(Objs, eta, true);
	else 
		FelwoodGather_Print(FWG_NOT_HAVE_TIMER);
	end
end

function FelwoodGather_ToggleConfigWindow()
	if(FelwoodGather_OptionsFrame:IsVisible()) then
		FelwoodGather_OptionsFrame:Hide();
	else
		FelwoodGather_OptionsFrame:Show();
	end
end

function FelwoodGather_Options_OnLoad()
	UIPanelWindows['FelwoodGather_OptionsFrame'] = {area = 'center', pushable = 0};
end

function FelwoodGather_Options_Init()
	FelwoodGather_MinimapInterval:SetValue(FelwoodGather_Config.minimapInterval);
	FelwoodGather_SliderWarn1:SetValue(FelwoodGather_Config.warn1);
	FelwoodGather_SliderWarn2:SetValue(FelwoodGather_Config.warn2);
	FelwoodGather_SliderAlpha:SetValue(FelwoodGather_Config.alpha);
	FelwoodGather_SliderScale:SetValue(FelwoodGather_Config.scale);
	FelwoodGather_Notify:SetChecked(FelwoodGather_Config.notify);
	FelwoodGather_AcceptTimer:SetChecked(FelwoodGather_Config.acceptTimer);
	FelwoodGather_SendAddonMessage:SetChecked(FelwoodGather_Config.useMsg);
	FelwoodGather_ShowMinimapIcons:SetChecked(FelwoodGather_Config.minimap);
	FelwoodGather_DebugPrint("Option_Init()");
end

function FelwoodGather_Options_OnHide()
--	if(MYADDONS_ACTIVE_OPTIONSFRAME == this) then
--		ShowUIPanel(myAddOnsFrame);
--	end
end

function FelwoodGather_GetLatestObject()
	if (FelwoodGather_Latest.index ~= 0) then
		return FelwoodGather_WorldObjs[FelwoodGather_Latest.index];
	else
		return nil;
	end
end

function FelwoodGather_PickupCountDown(byUI)
	if(FelwoodGather_PickupCount.inProgress and byUI) then
		-- count down in progress. ignored
		return;
	end

	if(not FelwoodGather_PickupCount.inProgress ) then
		-- start count down
		FelwoodGather_PickupCount.count = FelwoodGather_Config.countdown;
		FelwoodGather_PickupCount.elapse = 0;
		FelwoodGather_PickupCount.inProgress = true;
	end
	-- counter in progress.
	if(FelwoodGather_PickupCount.count == FelwoodGather_Config.countdown) then
		SendChatMessage(FELWOODGATHER_OPENNOW, "SAY");
	elseif (FelwoodGather_PickupCount.count <= 0) then 
		SendChatMessage(FELWOODGATHER_PICKUP, "SAY");
		FelwoodGather_PickupCount.inProgress = false;
	else
		SendChatMessage(""..FelwoodGather_PickupCount.count, "SAY");
	end
	FelwoodGather_PickupCount.count = FelwoodGather_PickupCount.count - 1;
end


-- minimap support
function FelwoodGather_CalcMinimapCoords(x, y)
	if not FelwoodGather_IsActivate() then
		return 0, 0;
	end
	local absX = x * FelwoodGather_MinimapCoord.scale + FelwoodGather_MinimapCoord.offset_x;
	local absY = y * FelwoodGather_MinimapCoord.scale + FelwoodGather_MinimapCoord.offset_y;
	return absX, absY;
end



function FelwoodGather_MinimapDraw()
	if ( not FelwoodGather_Config.minimap ) then 
		return;
	end
	local curZone = GetRealZoneText();
	if( (curZone ~= nil) and curZone ~= FWG_FELWOOD_MAPNAME) then
		return;
	end
	local x, y = GetPlayerMapPosition("player");
	x, y = FelwoodGather_CalcMinimapCoords(x, y);
	FelwoodGather_DebugModePrint("playerMinimapPos:" .. x ..", ".. y, 3);
	local zoomLevel = Minimap:GetZoom();
	local inMap = false;
	for n, Objs in FelwoodGather_WorldObjs do 
		local tx, ty = FelwoodGather_CalcMinimapCoords(Objs.x/100, Objs.y/100);
		FelwoodGather_DebugModePrint("objMinimapPos:".. n .. ":" .. tx ..", ".. ty, 3);
		
		local mx = (tx - x)*FelwoodGather_MinimapScales[zoomLevel].xscale;
		local my = (ty - y)*FelwoodGather_MinimapScales[zoomLevel].yscale;
		local dist = math.sqrt(mx*mx + my*my);
		if dist < 57 then
			local poi = getglobal("FWGMinimapPOI"..n);
			if ( poi == nil ) then
				FelwoodGather_Print("FWGMinimapPOI"..n .. " does not found");
			end
			local poiTexture = getglobal("FWGMinimapPOI".. n .. "Texture");
			if ( Objs.isThere == false ) then
				poiTexture:SetVertexColor(0.5, 0.5, 0.5, 1);
			else 
				poiTexture:SetVertexColor(1,1,1,1);
			end
			
			FelwoodGather_DebugModePrint("MinimapPos:".. n .. ":" .. mx ..", ".. my, 3);
			poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 
				107 + mx, 
				-92 - my);
			poiTexture:SetTexture(Objs.texture);
			poi:SetAlpha(FelwoodGather_Config.alpha);
			poi:SetWidth(FelwoodGather_Config.scale);
			poi:SetHeight(FelwoodGather_Config.scale);
			poi:Show();
		elseif (dist < 100) then
			mx, my = FelwoodGather_CalcAngle(mx, my);
			local poi = getglobal("FWGMinimapPOI"..n);
			if ( poi == nil ) then
				FelwoodGather_Print("FWGMinimapPOI"..n .. " does not found");
			end
			local poiTexture = getglobal("FWGMinimapPOI".. n .. "Texture");
			poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 
				107 + mx, 
				-92 - my);
			poiTexture:SetTexture(Objs.texture);
			poi:SetAlpha(FelwoodGather_Config.alpha * ((100-67) / 100));
			poi:SetWidth(FelwoodGather_Config.scale);
			poi:SetHeight(FelwoodGather_Config.scale);
			poi:Show();
		else
			local poi = getglobal("FWGMinimapPOI"..n);
			poi:Hide();
		end
	end

	local Objs = FelwoodGather_GetLatestObject();
	if ( (Objs ~= nil) and (Objs.timer ~= 0) ) then
		local tx, ty = FelwoodGather_CalcMinimapCoords(Objs.x/100, Objs.y/100);
		local mx = (tx - x)*FelwoodGather_MinimapScales[zoomLevel].xscale;
		local my = (ty - y)*FelwoodGather_MinimapScales[zoomLevel].yscale;
		local dist = math.sqrt(mx*mx + my*my);
		if ( dist >= 57 ) then
			mx, my = FelwoodGather_CalcAngle(mx, my);
			local poi = getglobal("FWGMinimapPOI"..FelwoodGather_Latest.index);
			local poiTexture = getglobal("FWGMinimapPOI".. FelwoodGather_Latest.index .. "Texture");
			poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 
				107 + mx, 
				-92 - my);
			poiTexture:SetTexture(Objs.texture);
			poi:SetAlpha(FelwoodGather_Config.alpha);
			poiTexture:SetVertexColor(1.0, 1.0, 0.0, 1);
			poi:SetWidth(FelwoodGather_Config.scale);
			poi:SetHeight(FelwoodGather_Config.scale);
			poi:Show();
		end
	end
end
function FelwoodGather_CalcAngle(x, y)
	local flipAxis = 1;
	if (x == 0) then x = 0.0000000001;
	elseif (x < 0) then flipAxis = -1;
	end
	local angle = math.atan(y / x);
	local mx = math.cos(angle) * 63 * flipAxis;
	local my = math.sin(angle) * 63 * flipAxis;
	return mx, my;
end

function FelwoodGather_HideMinimapPOI()
		for i=1, 30 do
			local poi = getglobal("FWGMinimapPOI"..i);
			poi:Hide();
		end
end

function FelwoodGather_ToggleMiniMap() 
	if (FelwoodGather_Config.minimap ) then
		FelwoodGather_Config.minimap = false;
		FelwoodGather_Print(FELWOODGATHER_MINIMAP_TURN_OFF);
		FelwoodGather_HideMinimapPOI();
	else
		FelwoodGather_Config.minimap = true;
		FelwoodGather_Print(FELWOODGATHER_MINIMAP_TURN_ON);
	end
end

function FelwoodGather_SetMinimapTooltipText(id)
	FelwoodGather_DebugPrint("FelwoodGather_SetMinimapTooltipText id:" .. id);
	local Objs = FelwoodGather_WorldObjs[id]
	local curTime = GetTime();
	local etatext = FWG_NO_TIMER;
	if (Objs.timer ~= 0) then
		eta = (Objs.timer + FELWOODGATHER_TIMER) - curTime;
		if(eta < 0 ) then
			est = "-";
		else 
			est = "";
		end
		local d, h, m, s = ChatFrame_TimeBreakDown(math.abs(eta));
		etatext = format("%s%02d:%02d", est, m, s);
	end

	FWGMapTooltip:SetText(etatext);
	FWGMapTooltip:Show();
end
