--------------------------------------------------------------------------------
-- Parts of the code is inspired or taken from the following AddOn(s)...
--  - MozzFullWorldMap (http://www.wowinterface.com/downloads/fileinfo.php?s=&id=4046)
--
-- Version history...
--  0.1.0 - Windowed WorlMap with standard navigation
--  0.1.1 - Player and Cursor position
--        - Ping-Marker for the Player for better visibility
--  0.1.2 - Display of undiscovered areas in an different collor (MozzFullWorldMap)
--  0.1.3 - Colored unitpins for player, party, raid
--        - *FIX* showing unitpin-tooltip
--        - Classcolored names in unitpin-tooltip
--        - Showing unit level in unitpin-tooltip
--        - Integrated FWM code
--        - Key binding
--  0.1.4 - Separating data files
--        - Filter menu
--------------------------------------------------------------------------------


-- Debug mode (true=on, nil=off)
local DEBUG_MODE = nil;

-- Version of the data structure in the saved vars
AOAWMAP_DATA_VERSION = 1;
AOAWMAP_DATA_COMPATIBILITY = 1;

-- Flags of the init routines
local AoAWMap_Initialized = false;
local AoAWMap_ADDON_LOADED = false;
local AoAWMap_VARIABLES_LOADED = false;
local AoAWMap_TabID = nil;

-- some constants, status vars
local WORLDMAP_DETAIL_TILES = 12;
local WORLDMAP_DETAIL_TEXTURE_SIZE = 169;
local WORLDMAP_DETAIL_SCALE = WORLDMAP_DETAIL_TEXTURE_SIZE / 256;
local WORLDMAP_OVERLAYS = 0;
local WORLDMAP_FLAGS = 2;
local WORLDMAP_POIS = 0;
local WORLDMAP_POI_COLUMNS = 8;
local WORLDMAP_POI_TEXTURE_WIDTH = 128;
local WORLDMAP_FILTER_POIS = 0;

local CLASS_COLORS = {
	["HUNTER"]  = { r = 0.67, g = 0.83, b = 0.45 , hex="|cffaad372" },
	["WARLOCK"] = { r = 0.58, g = 0.51, b = 0.79 , hex="|cff9382c9" },
	["PRIEST"]  = { r = 1.0,  g = 1.0,  b = 1.0 ,  hex="|cffffffff" },
	["PALADIN"] = { r = 0.96, g = 0.55, b = 0.73 , hex="|cfff48cba" },
	["MAGE"]    = { r = 0.41, g = 0.8,  b = 0.94 , hex="|cff68ccef" },
	["ROGUE"]   = { r = 1.0,  g = 0.96, b = 0.41 , hex="|cfffff468" },
	["DRUID"]   = { r = 1.0,  g = 0.49, b = 0.04 , hex="|cffff7c0a" },
	["SHAMAN"]  = { r = 0.96, g = 0.55, b = 0.73 , hex="|cfff48cba" },
	["WARRIOR"] = { r = 0.78, g = 0.61, b = 0.43 , hex="|cffc69b6d" }
	};

-- MapFilters
local AoAWMapFilter = {};


-- =============================================================================
-- misc. functions
-- =============================================================================


local function AoA_ChatMessage(text)
	AoAMod_ChatMessage("WorldMap", text);
end

local function AoA_ChatError(text)
	AoAMod_ChatError("WorldMap", text);
end

local function AoA_ChatWarning(text)
	AoAMod_ChatWarning("WorldMap", text);
end

local function AoA_ChatDebug(text)
	if (DEBUG_MODE) then AoAMod_ChatDebug("WorldMap", text); end
end


-- =============================================================================
-- ==  Filter handling
-- =============================================================================


--------------------------------------------------------------------------------
-- Register module using the info array
--
-- info.name       = the frame which will be shown
-- info.IsEnabled  = func() returns true if enabled
-- info.Toggle     = func() to toggle the filter on/off
-- info.GetPOINum  = func() to get the number of POIs to show (can be nil)
-- info.GetPOIInfo = func() to get additional info of an POI (can be nil if info.GetPOINum is nil)
--------------------------------------------------------------------------------
function AoAWMap_RegisterFilter(info)
	local nextID = getn(AoAWMapFilter) + 1;
	AoAWMapFilter[nextID] = info;
	AoAWMapFilter[nextID].id = nextID;
	return nextID;
end


function 	AoAWMap_InitWMapFilter()
	info = {
		name      = AOA_WORLDMAP_FILTER_POSPLAYER;
		IsEnabled = AoAWMap_PosPlayerIsEnabled;
		Toggle    = AoAWMap_PosPlayerToggle;
		}
	AoAWMap_RegisterFilter(info);
	info = {
		name      = AOA_WORLDMAP_FILTER_POSCURSOR;
		IsEnabled = AoAWMap_PosCursorIsEnabled;
		Toggle    = AoAWMap_PosCursorToggle;
		}
	AoAWMap_RegisterFilter(info);
	info = {
		name      = AOA_WORLDMAP_FILTER_PINPLAYER;
		IsEnabled = AoAWMap_PinPlayerIsEnabled;
		Toggle    = AoAWMap_PinPlayerToggle;
		}
	AoAWMap_RegisterFilter(info);
	info = {
		name      = AOA_WORLDMAP_FILTER_PINPARTY;
		IsEnabled = AoAWMap_PinPartyIsEnabled;
		Toggle    = AoAWMap_PinPartyToggle;
		}
	AoAWMap_RegisterFilter(info);
	info = {
		name      = AOA_WORLDMAP_FILTER_FWM;
		IsEnabled = AoAWMap_FWMIsEnabled;
		Toggle    = AoAWMap_FWMToggle;
		}
	AoAWMap_RegisterFilter(info);
end


function AoAWMap_PosPlayerIsEnabled()
	return (AoACharData.WorldMap.PosPlayer_Enabled == "on");
end
function AoAWMap_PosPlayerToggle()
	if(AoACharData.WorldMap.PosPlayer_Enabled == "on") then
		AoACharData.WorldMap.PosPlayer_Enabled = "off";
	else
		AoACharData.WorldMap.PosPlayer_Enabled = "on";
	end
end


function AoAWMap_PosCursorIsEnabled()
	return (AoACharData.WorldMap.PosCursor_Enabled == "on");
end
function AoAWMap_PosCursorToggle()
	if(AoACharData.WorldMap.PosCursor_Enabled == "on") then
		AoACharData.WorldMap.PosCursor_Enabled = "off";
	else
		AoACharData.WorldMap.PosCursor_Enabled = "on";
	end
end


function AoAWMap_PinPlayerIsEnabled()
	return (AoACharData.WorldMap.PinPlayer_Enabled == "on");
end
function AoAWMap_PinPlayerToggle()
	if(AoACharData.WorldMap.PinPlayer_Enabled == "on") then
		AoACharData.WorldMap.PinPlayer_Enabled = "off";
	else
		AoACharData.WorldMap.PinPlayer_Enabled = "on";
	end
end


function AoAWMap_PinPartyIsEnabled()
	return (AoACharData.WorldMap.PinParty_Enabled == "on");
end
function AoAWMap_PinPartyToggle()
	if(AoACharData.WorldMap.PinParty_Enabled == "on") then
		AoACharData.WorldMap.PinParty_Enabled = "off";
	else
		AoACharData.WorldMap.PinParty_Enabled = "on";
	end
end


function AoAWMap_FWMIsEnabled()
	return (AoACharData.WorldMap.FWM_Enabled == "on");
end
function AoAWMap_FWMToggle()
	if(AoACharData.WorldMap.FWM_Enabled == "on") then
		AoACharData.WorldMap.FWM_Enabled = "off";
	else
		AoACharData.WorldMap.FWM_Enabled = "on";
	end
end


-- =============================================================================
-- ==  FullMapOverlayInfo handling
-- =============================================================================


local function oinfo_combine(prefix,tname,tw,th,ofx,ofy,mpx,mpy)
	-- shorten strings by replacing redundant prefix paths with a marker token
	local result = ":"..tw..":"..th..":"..ofx..":"..ofy;
	if (mpx~=0 or mpy~=0) then result = result..":"..mpx..":"..mpy; end
	if string.sub(tname, 0, string.len(prefix)) == prefix then
		return string.sub(tname, string.len(prefix)+1)..result
	end
	return "|"..result;
end


local function oinfo_uncombine(prefix,oinfo)
	local pfxUnused,tname,tw,th,ofx,ofy,mpx,mpy;
	_,_,pfxUnused,tname,tw,th,ofx,ofy = string.find(oinfo,
		"^([|]?)([^:]+):([^:]+):([^:]+):([^:]+):([^:]+)");
	if (not tname or not ofy) then return nil; end
	if (ofy) then
		_,_,mpx,mpy = string.find(oinfo,
			"^[|]?[^:]+:[^:]+:[^:]+:[^:]+:[^:]+:([^:]+):([^:]+)");
	end
	if (not mpy) then mpx=0; mpy=0; end
	if (pfxUnused~="|") then tname = prefix..tname; end
	return tname,tw+0,th+0,ofx+0,ofy+0,mpx+0,mpy+0;
end


local function oinfo_getname(prefix,oinfo)
	local junk1,junk2,pfxUnused,tname = string.find(oinfo, "^([|]?)([^:]+):");
	if (not tname) then return nil; end
	if (pfxUnused~="|") then tname = prefix..tname; end
	return tname;
end


local function getMainTable(mapFileName)
	local t = AoAWMap_FWMOverlayInfo[mapFileName];
	if (not t) then t = { }; AoAWMap_FWMOverlayInfo[mapFileName] = t; end
	return t;
end


local function getErrataTable(mapFileName)
	local t = AoAData.WorldMap.FWM_Errata[mapFileName];
	if (not t) then t = { }; AoAData.WorldMap.FWM_Errata[mapFileName] = t; end
	return t;
end


function AoAWMap_FWMInit()
	-- Integrate the contents of the errata table into the main dataset.
	-- and while we're at it, remove anything we don't recognize from the errata table!
	
	local mapFileName, errataTable, i, oinfo;
	for mapFileName,errataTable in next,AoAData.WorldMap.FWM_Errata do
		-- hack to keep strings short and maintainable.
		local prefix = "Interface\\WorldMap\\"..mapFileName.."\\";
		
		-- build a temporary index of the mainTable, from textureName to index!
		local mainIndex = {};
		local mainTable = getMainTable(mapFileName);
		for i,oinfo in next,mainTable do
			local tname = oinfo_uncombine(prefix,oinfo);
			if (tname) then mainIndex[tname] = i; end
		end
		
		-- build a temporary index of the errata too (removing redundant entries).
		local errataIndex = {};
		for i,oinfo in next,errataTable do
			local tname = oinfo_uncombine(prefix,oinfo);
			if (not tname) then
				AoA_ChatDebug(mapFileName..": borked: "..oinfo);
				errataTable[i] = nil
			else
				if errataIndex[tname] then
					AoA_ChatDebug(mapFileName..": redundant: "..errataTable[errataIndex[tname]]);
					errataTable[errataIndex[tname]] = nil;
				end
				errataIndex[tname] = i;
			end
		end
		
		-- now integrate errata into mainTable (for this session only)
		for i,oinfo in next,errataTable do
			local tname = oinfo_uncombine(prefix,oinfo);
			if mainIndex[tname] then
				if (mainTable[mainIndex[tname]] ~= oinfo) then
					AoA_ChatDebug(mapFileName..": update "..oinfo);
					mainTable[mainIndex[tname]] = oinfo;
				else
					AoA_ChatDebug(mapFileName..": redundant: "..oinfo);
					errataTable[i] = nil;
				end
			else
				AoA_ChatDebug(mapFileName..": add "..oinfo);
				table.insert(mainTable, oinfo);
			end
		end
	end
end


-- =============================================================================
-- ==  WorldMap Frame
-- =============================================================================


--------------------------------------------------------------------------------
-- Toggle the WorldMap frame
--------------------------------------------------------------------------------
function AoAWMap_Toggle()
	AoA_Toggle(AoAWMap_TabID);
end


--------------------------------------------------------------------------------
-- OnLoad
--------------------------------------------------------------------------------
function AoAWMap_OnLoad()

	-- Register for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	
	-- init texture tiles
	for i=1, WORLDMAP_DETAIL_TILES, 1 do
		getglobal("AoAWorldMapDetailTile"..i):SetHeight(WORLDMAP_DETAIL_TEXTURE_SIZE);
		getglobal("AoAWorldMapDetailTile"..i):SetWidth(WORLDMAP_DETAIL_TEXTURE_SIZE);
	end
	
end

function AoAWMap_RegisterEvents()
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
end

function AoAWMap_UnregisterEvents()
	this:UnregisterEvent("WORLD_MAP_UPDATE");
	this:UnregisterEvent("ZONE_CHANGED_NEW_AREA");
end


--------------------------------------------------------------------------------
-- Initializes everything relating to saved variables and data in other lua files
-- This should be called ONLY when we're sure that all other files have been loaded
--------------------------------------------------------------------------------
function AoAWMap_Init()
	
	-- init module
	info = {
		frame = AoAWorldMapFrame;
		init  = AoAWMap_InitModule;
		text  = AOA_WORLDMAP_TABTEXT;
		addon = "AoA_WorldMap";
		};
	AoAWMap_TabID = AoA_RegisterModule(info);
	
	-- init filter
	AoAWMap_InitWMapFilter();
	
	-- AddOn is initialized now
	AoAWMap_Initialized = true;
	AoA_ChatMessage(string.format(AOA_LOADED, GetAddOnMetadata("AoA_WorldMap", "Version")));
	
end


--------------------------------------------------------------------------------
-- Initializes the module
-- called by the core addon
--------------------------------------------------------------------------------
function AoAWMap_InitModule()
	
	-- setup the saved variables if needed
	AoAWMap_InitSavedVars();
	
	-- init FWM
	AoAWMap_FWMInit();
	
end


--------------------------------------------------------------------------------
-- Create all the necessary saved variables if they don't exist
-- The default settings for all saved variables are stored here
--------------------------------------------------------------------------------
function AoAWMap_InitSavedVars()
	
	--
	-- global data
	--
	
	-- make shure that the saved settings are up to date
	if(AoAData.WorldMap == nil or tonumber(AoAData.WorldMap.Version) < AOAWMAP_DATA_COMPATIBILITY) then
		AoAData.WorldMap = {};
		AoAData.WorldMap.Version = AOAWMAP_DATA_VERSION;
		AoA_ChatWarning(AOA_DATA_UPDATED);
	end
	
	-- FWM OverlayErrata
	if(AoAData.WorldMap.FWM_Errata == nil) then
		AoAData.WorldMap.FWM_Errata = { };
	end
	
	--
	-- char data
	--
	
	-- make shure that the saved settings are up to date
	if(AoACharData.WorldMap == nil or tonumber(AoACharData.WorldMap.Version) < AOAWMAP_DATA_COMPATIBILITY) then
		AoACharData.WorldMap = {};
		AoACharData.WorldMap.Version = AOAWMAP_DATA_VERSION;
		AoA_ChatWarning(AOA_CHARDATA_UPDATED);
	end
	
	-- map follows player
	-- value: true/false
	if(AoACharData.WorldMap.FollowPlayer == nil) then
		AoACharData.WorldMap.FollowPlayer = true;
	end
	
	-- FWM color
	if(not AoACharData.WorldMap.FWM_ColorStyle) then
		AoACharData.WorldMap.FWM_ColorStyle = 2
	end
	
	-- FWM transparency
	if(not AoACharData.WorldMap.FWM_Transparency) then
		AoACharData.WorldMap.FWM_Transparency = 1.0
	end
	
	-- Filters
	buf = AoACharData.WorldMap.PosPlayer_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.WorldMap.PosPlayer_Enabled = "on";
	end
	buf = AoACharData.WorldMap.PosCursor_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.WorldMap.PosCursor_Enabled = "on";
	end
	buf = AoACharData.WorldMap.PinPlayer_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.WorldMap.PinPlayer_Enabled = "on";
	end
	buf = AoACharData.WorldMap.PinParty_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.WorldMap.PinParty_Enabled = "on";
	end
	buf = AoACharData.WorldMap.FWM_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.WorldMap.FWM_Enabled = "on";
	end
	
end


--------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------
function AoAWMap_OnEvent()

	if ( event == "ADDON_LOADED" and arg1 == "AoA_WorldMap") then
		AoAWMap_ADDON_LOADED = true;
	elseif ( event == "VARIABLES_LOADED" ) then
		AoAWMap_VARIABLES_LOADED = true;
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		AoAWMap_RegisterEvents();
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		AoAWMap_UnregisterEvents();
	end
	
	-- Once these two events have fired we can assume that all other files have been loaded
	-- It's now safe to initialize AtlasEnhanced if it hasn't already been done
	if ( AoAWMap_ADDON_LOADED and AoAWMap_VARIABLES_LOADED and AoAWMap_Initialized == false ) then
		AoAWMap_Init();
	end
	
	if(event == "ZONE_CHANGED_NEW_AREA") and (AoACharData.WorldMap.FollowPlayer == true) then
		-- set map to the current player position
		-- and update the map
		SetMapToCurrentZone();
		local continent = GetCurrentMapContinent();
		local zone = GetCurrentMapZone();
		if continent then
			SetMapZoom(continent, zone);
		else
			SetMapZoom(0);
		end
		AoAWMap_WorldMapUpdate();
		
	elseif(event == "WORLD_MAP_UPDATE") then
		-- simple map update
		AoAWMap_WorldMapUpdate();
		
	end
	
end


--------------------------------------------------------------------------------
-- Event: OnShow
--------------------------------------------------------------------------------
function AoAWMap_OnShow()
	if(AoACharData.WorldMap.FollowPlayer == true) then
		SetMapToCurrentZone();
	end
	AoAWMap_WorldMapUpdate();
end


--------------------------------------------------------------------------------
-- Event: OnHide
--------------------------------------------------------------------------------
function AoAWMap_OnHide()
end


--------------------------------------------------------------------------------
-- Update the map textures, overlays, pois
--------------------------------------------------------------------------------
function AoAWMap_WorldMapUpdate()

	-- Setup the MapTexture
	local mapFileName, textureHeight = GetMapInfo();
	if ( not mapFileName ) then
		mapFileName = "World";
	end
	for i=1, WORLDMAP_DETAIL_TILES, 1 do
		getglobal("AoAWorldMapDetailTile"..i):SetTexture("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i);
	end
	
	-- get scale factor
	local scale = 1 / AoAWorldMapFrame:GetEffectiveScale();

	-- Setup the POI's
	local numPOIs = GetNumMapLandmarks();
	local name, description, textureIndex, x, y;
	local worldMapPOI;
	local x1, x2, y1, y2;

	if ( WORLDMAP_POIS < numPOIs ) then
		for i=WORLDMAP_POIS+1, numPOIs do
			AoAWMap_CreatePOI(i);
		end
		WORLDMAP_POIS = numPOIs;
	end
	for i=1, WORLDMAP_POIS do
		worldMapPOI = getglobal("AoAWorldMapPOI"..i);
		if ( i <= numPOIs ) then
			name, description, textureIndex, x, y = GetMapLandmarkInfo(i);
			x1, x2, y1, y2 = AoAWMap_GetPOITextureCoords(textureIndex);
			getglobal(worldMapPOI:GetName().."Texture"):SetTexCoord(x1, x2, y1, y2);
			x = x * AoAWorldMapButton:GetWidth() * scale;
			y = -y * AoAWorldMapButton:GetHeight() * scale;
			worldMapPOI:SetPoint("CENTER", "AoAWorldMapButton", "TOPLEFT", x, y );
			worldMapPOI.name = name;
			worldMapPOI.description = description;
			worldMapPOI:Show();
		else
			worldMapPOI:Hide();
		end
	end
	
	-- Setup the overlays
	AoAWMap_WorldMapUpdateOverlays();

end


function AoAWMap_WorldMapUpdateOverlays()
	local mapOverLay;
	dtlFrame = "WorldMapDetailFrame";
	mapOverLay = "AoAWorldMapOverlay";
	
	local mapFileName, textureHeight = GetMapInfo();
	if (not mapFileName) then mapFileName = "World"; end
	
	-- hack to keep strings short and maintainable
	local prefix = "Interface\\WorldMap\\"..mapFileName.."\\";
	
	-- (1) create oinfos for discovered areas in this zone
	local i, tname, oinfo;
	local discovered = {};
	local numOverlays = GetNumMapOverlays();
	for i=1, numOverlays do
		local tname,tw,th,ofx,ofy,mpx,mpy = GetMapOverlayInfo(i);
		discovered[tname] = oinfo_combine(prefix,tname,tw,th,ofx,ofy,mpx,mpy);
	end
	
	-- (2) update any overlays for which our stored data is *incorrect* (should never happen!)
	local zoneTable = getMainTable(mapFileName);
	numOverlays = getn(zoneTable);
	for i,oinfo in next,zoneTable do
		local tname = oinfo_getname(prefix,oinfo);
		if discovered[tname] then
			if discovered[tname] == 1 then
				AoA_ChatDebug(mapFileName..": repeating "..tname.." ??");
			elseif discovered[tname] ~= oinfo then
				AoA_ChatDebug(mapFileName..": update "..discovered[tname]);
				zoneTable[i] = discovered[tname];
				-- record in the errata table for next time!
				table.insert(getErrataTable(mapFileName),discovered[tname]);
			end
			discovered[tname] = 1;
		end
	end
	
	-- (3) add any overlays which are *missing* from our stored data (should never happen!)
	for tname,oinfo in next,discovered do
		if oinfo ~= 1 then
			AoA_ChatDebug(mapFileName..": adding "..oinfo);
			table.insert(zoneTable,oinfo);
			-- record in the errata table for next time!
			table.insert(getErrataTable(mapFileName),oinfo);
		end
	end
	
	-- Modified version of original overlay stuff
	local textureName, textureWidth, textureHeight, offsetX, offsetY, mapPointX, mapPointY;
	local textureCount = 0, neededTextures;
	local texture;
	local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight;
	local numTexturesWide, numTexturesTall;
	
	for i,oinfo in next,zoneTable do
		textureName, textureWidth, textureHeight, offsetX, offsetY, mapPointX, mapPointY = oinfo_uncombine(prefix,oinfo);
		
		if(AoACharData.WorldMap.FWM_Enabled == "on" or discovered[textureName]) then
			
			-- HACK: override *known incorrect* data with hard-coded fixes
			-- Otherwise it looks quite ugly when you toggle the faint areas on and off
			-- I am assuming here that strings are interned and comparisons are fast...hmm
			if (textureName == "Interface\\WorldMap\\Tirisfal\\BRIGHTWATERLAKE") then
				if (offsetX == 587) then offsetX = 584 end
			end
			if (textureName == "Interface\\WorldMap\\Silverpine\\BERENSPERIL") then
				if (offsetY == 417) then offsetY = 415 end
			end
			
			numTexturesWide = ceil(textureWidth/256);
			numTexturesTall = ceil(textureHeight/256);
			neededTextures = textureCount + (numTexturesWide * numTexturesTall);
			if ( neededTextures > WORLDMAP_OVERLAYS ) then
				for j=WORLDMAP_OVERLAYS+1, neededTextures do
					AoAWorldMapFrame:CreateTexture("AoAWorldMapOverlay"..j, "ARTWORK");
				end
				WORLDMAP_OVERLAYS = neededTextures;
			end
			for j=1, numTexturesTall do
				if (j < numTexturesTall) then
					texturePixelHeight = 256; textureFileHeight = 256;
				else
					texturePixelHeight = mod(textureHeight, 256);
					if (texturePixelHeight == 0) then texturePixelHeight = 256; end
					textureFileHeight = 16;
					while(textureFileHeight < texturePixelHeight) do
						textureFileHeight = textureFileHeight * 2;
					end
				end
				for k=1, numTexturesWide do
					if (textureCount > WORLDMAP_OVERLAYS) then
						message("Too many worldmap overlays!"); return;
					end
					texture = getglobal( mapOverLay..(textureCount+1) );
					if (k < numTexturesWide) then
						texturePixelWidth = 256; textureFileWidth = 256;
					else
						texturePixelWidth = mod(textureWidth, 256);
						if (texturePixelWidth == 0) then texturePixelWidth = 256; end
						textureFileWidth = 16;
						while(textureFileWidth < texturePixelWidth) do
							textureFileWidth = textureFileWidth * 2;
						end
					end
					texture:SetWidth(texturePixelWidth * WORLDMAP_DETAIL_SCALE);
					texture:SetHeight(texturePixelHeight * WORLDMAP_DETAIL_SCALE);
					texture:SetTexCoord(0, texturePixelWidth/textureFileWidth, 0, texturePixelHeight/textureFileHeight);
					texture:ClearAllPoints();
					texture:SetPoint("TOPLEFT",
							offsetX*WORLDMAP_DETAIL_SCALE + (256*WORLDMAP_DETAIL_SCALE * (k-1)),
							-(offsetY*WORLDMAP_DETAIL_SCALE + (256*WORLDMAP_DETAIL_SCALE * (j - 1))));
					texture:SetTexture(textureName..(((j - 1) * numTexturesWide) + k));
					
					if discovered[textureName] then
						texture:SetVertexColor(1.0,1.0,1.0);
						texture:SetAlpha(1.0);
					else
						if(AoACharData.WorldMap.FWM_ColorStyle == 0) then
							texture:SetVertexColor(0.2,0.6,1.0);
						elseif(AoACharData.WorldMap.FWM_ColorStyle == 1) then
							texture:SetVertexColor(1.0,1.0,1.0);
						elseif(AoACharData.WorldMap.FWM_ColorStyle == 2) then
							texture:SetVertexColor(1.0,0.5,0.5);
						else
							message("Corrupt color selection detected, resetting to blue.")
							texture:SetVertexColor(0.2,0.6,1.0);
							AoACharData.WorldMap.FWM_ColorStyle = 0;
						end
						if(AoACharData.WorldMap.FWM_Transparency >= 0.0 and AoACharData.WorldMap.FWM_Transparency <= 1.0) then
							texture:SetAlpha(AoACharData.WorldMap.FWM_Transparency);
						else
							message("Corrupt transparency value detected, resetting to opaque.")
							AoACharData.WorldMap.FWM_Transparency = 1.0;
							texture:SetAlpha(AoACharData.WorldMap.FWM_Transparency);
						end
					end
					texture:Show();
					textureCount = textureCount + 1;
				end
			end
		end
	end
	-- hide unused overlays
	for i=textureCount+1, WORLDMAP_OVERLAYS do getglobal(mapOverLay..i):Hide(); end
end


--------------------------------------------------------------------------------
-- POI handling
--------------------------------------------------------------------------------


function AoAWMap_CreatePOI(index)
	local button = CreateFrame("Button", "AoAWorldMapPOI"..index, AoAWorldMapButton);
	button:SetWidth(32*WORLDMAP_DETAIL_SCALE);
	button:SetHeight(32*WORLDMAP_DETAIL_SCALE);
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:SetScript("OnEnter", AoAWMapPOI_OnEnter);
	button:SetScript("OnLeave", AoAWMapPOI_OnLeave);
	button:SetScript("OnClick", AoAWMapPOI_OnClick);

	local texture = button:CreateTexture(button:GetName().."Texture", "BACKGROUND");
	texture:SetWidth(16*WORLDMAP_DETAIL_SCALE);
	texture:SetHeight(16*WORLDMAP_DETAIL_SCALE);
	texture:SetPoint("CENTER", 0, 0);
	texture:SetTexture("Interface\\Minimap\\POIIcons");
end


function AoAWMap_GetPOITextureCoords(index)
	local worldMapIconDimension = 16;
	local xCoord1, xCoord2, yCoord1, yCoord2; 
	local coordIncrement = worldMapIconDimension / WORLDMAP_POI_TEXTURE_WIDTH;
	xCoord1 = mod(index , WORLDMAP_POI_COLUMNS) * coordIncrement;
	xCoord2 = xCoord1 + coordIncrement;
	yCoord1 = floor(index / WORLDMAP_POI_COLUMNS) * coordIncrement;
	yCoord2 = yCoord1 + coordIncrement;
	return xCoord1, xCoord2, yCoord1, yCoord2;
end


function AoAWMapPOI_OnEnter()
	AoAWorldMapFrame.poiHighlight = 1;
	if ( this.description and strlen(this.description) > 0 ) then
		AoAWorldMapFrameAreaLabel:SetText(this.name);
		AoAWorldMapFrameAreaDescription:SetText(this.description);
	else
		AoAWorldMapFrameAreaLabel:SetText(this.name);
		if(AOA_WORLDMAP_NOTES[this.name] ~= nil) then
			AoAWorldMapFrameAreaDescription:SetText(AOA_WORLDMAP_NOTES[this.name]);
		else
			AoAWorldMapFrameAreaDescription:SetText("");
		end
	end
end


function AoAWMapPOI_OnLeave()
	AoAWorldMapFrame.poiHighlight = nil;
	AoAWorldMapFrameAreaLabel:SetText(AoAWorldMapFrame.areaName);
	AoAWorldMapFrameAreaDescription:SetText("");
end


function AoAWMapPOI_OnClick()
	AoAWMapButton_OnClick(arg1, AoAWorldMapButton);
end


--------------------------------------------------------------------------------
-- FilterPOI handling
--------------------------------------------------------------------------------


function AoAWMap_CreateFilterPOI(index, size)
	if(size == nil) then size = 16; end
	
	local button = CreateFrame("Button", "AoAWorldMapFilterPOI"..index, AoAWorldMapButton);
	button:SetWidth((size+16)*WORLDMAP_DETAIL_SCALE);
	button:SetHeight((size+16)*WORLDMAP_DETAIL_SCALE);
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:SetScript("OnEnter", AoAWMapFilterPOI_OnEnter);
	button:SetScript("OnLeave", AoAWMapFilterPOI_OnLeave);
	button:SetScript("OnClick", AoAWMapFilterPOI_OnClick);
	
	local texture = button:CreateTexture(button:GetName().."Texture", "BACKGROUND");
	texture:SetWidth(size*WORLDMAP_DETAIL_SCALE);
	texture:SetHeight(size*WORLDMAP_DETAIL_SCALE);
	texture:SetPoint("CENTER", 0, 0);
end


function AoAWMapFilterPOI_OnEnter()
	local newLineString = "";
	local tooltipText = "";
	local filterPOI;
	
	-- Adjust the tooltip based on which side the unit button is on
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end

	for i=1, WORLDMAP_FILTER_POIS do
		filterPOI = getglobal("AoAWorldMapFilterPOI"..i);
		if( filterPOI:IsVisible() and MouseIsOver(filterPOI) ) then
			if(filterPOI.tiptext ~= nil) then
				tooltipText = tooltipText..newLineString..filterPOI.tiptext;		
				newLineString = "\n";
			end
		end
	end
	
	if(tooltipText ~= "") then
		GameTooltip:SetText(tooltipText);
		GameTooltip:Show();
	end
end


function AoAWMapFilterPOI_OnLeave()
	GameTooltip:Hide();
end


function AoAWMapFilterPOI_OnClick()
	AoAWMapButton_OnClick(arg1, AoAWorldMapButton);
end


--------------------------------------------------------------------------------
-- WorldMapButton handling
--------------------------------------------------------------------------------


function AoAWMapButton_OnClick(mouseButton, button)
	local curCont = GetCurrentMapContinent();
	local curZone = GetCurrentMapZone();
	
	-- get scale factor
	local scale = 1 / AoAWorldMapFrame:GetEffectiveScale();
	
	if ( mouseButton == "LeftButton" ) then
		if ( not button ) then
			button = this;
		end
		local x, y = GetCursorPosition();
		x = x / button:GetEffectiveScale();
		y = y / button:GetEffectiveScale();

		local centerX, centerY = button:GetCenter();
		local width = button:GetWidth() * scale;
		local height = button:GetHeight() * scale;
		local adjustedY = (centerY + (height/2) - y) / height;
		local adjustedX = (x - (centerX - (width/2))) / width;
		ProcessMapClick( adjustedX, adjustedY);
	else
		if ( GetCurrentMapZone() ~= 0 ) then
			SetMapZoom(GetCurrentMapContinent());
		else
			SetMapZoom(0);
		end
	end
	if (curCont ~= GetCurrentMapContinent()) or (curZone ~= GetCurrentMapZone()) then
		PlaySound("igQuestLogOpen");
	end
end


function AoAWMapButton_OnUpdate(elapsed)
	
	-- get scale factor
	local scale = 1 / AoAWorldMapFrame:GetEffectiveScale();
	
	local x, y = GetCursorPosition();
	x = x / this:GetEffectiveScale();
	y = y / this:GetEffectiveScale();

	local centerX, centerY = this:GetCenter();
	local width = this:GetWidth() * scale;
	local height = this:GetHeight() * scale;
	local adjustedY = (centerY + (height/2) - y ) / height;
	local adjustedX = (x - (centerX - (width/2))) / width;
	local name, fileName, texPercentageX, texPercentageY, textureX, textureY, scrollChildX, scrollChildY = UpdateMapHighlight( adjustedX, adjustedY );
	
	-- highlight hacks
	if fileName == "Silithus" then
		textureY = textureY * 2;
		texPercentageY = 1;
	end
	
	-- Area Label/Description
	AoAWorldMapFrame.areaName = name;
	if ( not AoAWorldMapFrame.poiHighlight ) then
		AoAWorldMapFrameAreaLabel:SetText(name);
		if(AOA_WORLDMAP_NOTES[name] ~= nil) then
			AoAWorldMapFrameAreaDescription:SetText(AOA_WORLDMAP_NOTES[name]);
		else
			AoAWorldMapFrameAreaDescription:SetText("");
		end
	end
	
	-- highlight
	if ( fileName ) then
		AoAWorldMapHighlight:SetTexCoord(0, texPercentageX, 0, texPercentageY);
		AoAWorldMapHighlight:SetTexture("Interface\\WorldMap\\"..fileName.."\\"..fileName.."Highlight");
		textureX = textureX * width;
		textureY = textureY * height;
		scrollChildX = scrollChildX * width;
		scrollChildY = -scrollChildY * height;
		if ( (textureX > 0) and (textureY > 0) ) then
			AoAWorldMapHighlight:SetWidth(textureX);
			AoAWorldMapHighlight:SetHeight(textureY);
			AoAWorldMapHighlight:SetPoint("TOPLEFT", "AoAWorldMapFrame", "TOPLEFT", scrollChildX, scrollChildY);
			AoAWorldMapHighlight:Show();
		end
	else
		AoAWorldMapHighlight:Hide();
	end
	
	-- Position player
	local playerX, playerY = GetPlayerMapPosition("player");
	if ( playerX == 0 and playerY == 0 or AoACharData.WorldMap.PinPlayer_Enabled ~= "on") then
		AoAWorldMapPlayer:Hide();
		AoAWorldMapPing:Hide();
	else
		playerX = playerX * AoAWorldMapFrame:GetWidth() * scale;
		playerY = -playerY * AoAWorldMapFrame:GetHeight() * scale;
		AoAWorldMapPlayer:Show();

		-- Position clear button to detect mouseovers
		AoAWorldMapPlayer:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", playerX, playerY);
		
		-- Position player ping if its shown
		if ( AoAWorldMapPing:IsVisible() ) then
			AoAWorldMapPing:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", playerX-7.7, playerY-8.2);
		else
			AoAWorldMapPing:SetAlpha(255);
			AoAWorldMapPing:Show();
			AoAWorldMapPing.timer = 1;
		end
	end
	
	-- Position party/raid
	local partyX, partyY, partyMemberFrame;
	local playerCount = 0;
	if ( GetNumRaidMembers() > 0 ) then
		for i=1, MAX_PARTY_MEMBERS do
			partyMemberFrame = getglobal("AoAWorldMapParty"..i);
			partyMemberFrame:Hide();
		end
		for i=1, MAX_RAID_MEMBERS do
			local unit = "raid"..i;
			partyX, partyY = GetPlayerMapPosition(unit);
			partyMemberFrame = getglobal("AoAWorldMapRaid"..playerCount + 1);
			if( (partyX ~= 0 or partyY ~= 0) and not UnitIsUnit(unit, "player") or AoACharData.WorldMap.PinParty_Enabled == "on") then
				partyX = partyX * AoAWorldMapFrame:GetWidth() * scale;
				partyY = -partyY * AoAWorldMapFrame:GetHeight() * scale;
				partyMemberFrame:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", partyX, partyY);
--				partyMemberFrame.name = nil;
--				partyMemberFrame.unit = unit;
				partyMemberFrame:Show();
				playerCount = playerCount + 1;
			else
				partyMemberFrame:Hide();
			end
		end
	else
		for i=1, MAX_PARTY_MEMBERS do
			partyX, partyY = GetPlayerMapPosition("party"..i);
			partyMemberFrame = getglobal("AoAWorldMapParty"..i);
			if( partyX == 0 and partyY == 0 or AoACharData.WorldMap.PinParty_Enabled ~= "on") then
				partyMemberFrame:Hide();
			else
				partyX = partyX * AoAWorldMapFrame:GetWidth() * scale;
				partyY = -partyY * AoAWorldMapFrame:GetHeight() * scale;
				partyMemberFrame:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", partyX, partyY);
				partyMemberFrame:Show();
			end
		end
	end
	
	-- Position team
	local numTeamMembers = GetNumBattlefieldPositions();
	for i=playerCount+1, MAX_RAID_MEMBERS do
		partyX, partyY, name = GetBattlefieldPosition(i - playerCount);
		partyMemberFrame = getglobal("AoAWorldMapRaid"..i);
		if ( partyX == 0 and partyY == 0 or AoACharData.WorldMap.PinParty_Enabled ~= "on") then
			partyMemberFrame:Hide();
		else
			partyX = partyX * AoAWorldMapFrame:GetWidth() * scale;
			partyY = -partyY * AoAWorldMapFrame:GetHeight() * scale;
			partyMemberFrame:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", partyX, partyY);
			partyMemberFrame.name = name;
			partyMemberFrame:Show();
		end
	end

	-- Position flags
	local flagX, flagY, flagToken, flagFrame, flagTexture;
	local numFlags = GetNumBattlefieldFlagPositions();
	for i=1, numFlags do
		flagX, flagY, flagToken = GetBattlefieldFlagPosition(i);
		flagFrame = getglobal("AoAWorldMapFlag"..i);
		flagTexture = getglobal("AoAWorldMapFlag"..i.."Texture");
		if ( flagX == 0 and flagY == 0 ) then
			flagFrame:Hide();
		else
			flagX = flagX * AoAWorldMapFrame:GetWidth() * scale;
			flagY = -flagY * AoAWorldMapFrame:GetHeight() * scale;
			flagFrame:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", flagX, flagY);
			flagTexture:SetTexture("Interface\\WorldStateFrame\\"..flagToken);
			flagFrame:Show();
		end
	end
	for i=numFlags+1, WORLDMAP_FLAGS do
		flagFrame = getglobal("AoAWorldMapFlag"..i);
		flagFrame:Hide();
	end

	-- Position corpse
	local corpseX, corpseY = GetCorpseMapPosition();
	if ( corpseX == 0 and corpseY == 0 ) then
		AoAWorldMapCorpse:Hide();
	else
		corpseX = corpseX * AoAWorldMapFrame:GetWidth() * scale;
		corpseY = -corpseY * AoAWorldMapFrame:GetHeight() * scale;
		AoAWorldMapCorpse:SetPoint("CENTER", "AoAWorldMapFrame", "TOPLEFT", corpseX, corpseY);
		AoAWorldMapCorpse:Show();
	end
	
	-- Position FlightNode
--	if(AtlasEnhTaxi_GetNodeWMLoc) then
--		local flightnode = AtlasEnhTaxi_GetNodeWMLoc(GetCurrentMapContinent(), GetCurrentMapZone());
--		if(flightnode ~= nil) then
--			local taxiX = flightnode.x * AtlasEnhTabWorldMapInnerFrame:GetWidth() * scale;
--			local taxiY = -flightnode.y * AtlasEnhTabWorldMapInnerFrame:GetHeight() * scale;
--			AtlasEnhTabWorldMapTaxi:Show();
--			AtlasEnhTabWorldMapTaxi:SetPoint("CENTER", "AtlasEnhTabWorldMapInnerFrame", "TOPLEFT", taxiX, taxiY);
--		else
--			AtlasEnhTabWorldMapTaxi:Hide();
--		end
--	end
	
	-- if cursor is out of the frame hide labels
	if(not MouseIsOver(AoAWorldMapFrame) ) then
		AoAWorldMapFrameAreaLabel:SetText("");
		AoAWorldMapFrameAreaDescription:SetText("");
	end
	
	-- set position labes
	if(not MouseIsOver(AoAWorldMapFrame) or AoACharData.WorldMap.PosCursor_Enabled ~= "on") then
		AoAWorldMapCursorPos:Hide();
	else
		local x, y = GetCursorPosition();
		x = x / this:GetEffectiveScale();
		y = y / this:GetEffectiveScale();
		local centerX, centerY = this:GetCenter();
		local width = this:GetWidth() * scale;
		local height = this:GetHeight() * scale;
		local adjustedY = (centerY + (height/2) - y ) / height;
		local adjustedX = (x - (centerX - (width/2))) / width;
		AoAWorldMapCursorPosText:SetText(floor(adjustedX*100)..", "..floor(adjustedY*100));
		AoAWorldMapCursorPos:Show();
	end
	playerX, playerY = GetPlayerMapPosition("player");
	if ( playerX == 0 and playerY == 0 or AoACharData.WorldMap.PosPlayer_Enabled ~= "on") then
		AoAWorldMapPlayerPos:Hide();
	else
		AoAWorldMapPlayerPosText:SetText(floor(playerX*100)..", "..floor(playerY*100));
		AoAWorldMapPlayerPos:Show();
	end
	
	-- FilterPOIs
	local filter=1;
	local lastFilterPOI = 0;
	local texture, x, y, size, tiptext;
	while(AoAWMapFilter[filter] ~= nil) do
		if(AoAWMapFilter[filter].GetPOINum ~= nil) then
			local neededPOIS = (AoAWMapFilter[filter].GetPOINum)(GetCurrentMapContinent(), GetCurrentMapZone());
			
			if(WORLDMAP_FILTER_POIS < lastFilterPOI+neededPOIS) then
				for i=WORLDMAP_FILTER_POIS+1, neededPOIS do
					AoAWMap_CreateFilterPOI(i);
				end
				WORLDMAP_FILTER_POIS = neededPOIS;
			end
			
			for POIIndex=1, neededPOIS do
				lastFilterPOI = lastFilterPOI+1;
				filterPOIBtn = getglobal("AoAWorldMapFilterPOI"..lastFilterPOI);
				filterPOITex = getglobal("AoAWorldMapFilterPOI"..lastFilterPOI.."Texture");
				
				texture, x, y, size, tiptext = (AoAWMapFilter[filter].GetPOIInfo)(POIIndex, GetCurrentMapContinent(), GetCurrentMapZone());
				filterPOIBtn.tiptext = tiptext;
				
				filterPOIBtn:SetWidth((size+16)*WORLDMAP_DETAIL_SCALE);
				filterPOIBtn:SetHeight((size+16)*WORLDMAP_DETAIL_SCALE);
				filterPOITex:SetWidth(size*WORLDMAP_DETAIL_SCALE);
				filterPOITex:SetHeight(size*WORLDMAP_DETAIL_SCALE);
				
				filterPOITex:SetTexture(texture);
				
				x = x * AoAWorldMapButton:GetWidth() * scale;
				y = -y * AoAWorldMapButton:GetHeight() * scale;
				filterPOIBtn:SetPoint("CENTER", "AoAWorldMapButton", "TOPLEFT", x, y );
				
				filterPOIBtn:Show();
			end
			
		end
		filter = filter+1;
	end
	for i=lastFilterPOI+1, WORLDMAP_FILTER_POIS do
		filterPOIBtn = getglobal("AoAWorldMapFilterPOI"..i);
		filterPOIBtn:Hide();
	end
	
	
--[[
	local numPOIs = GetNumMapLandmarks();
	local name, description, textureIndex, x, y;
	local worldMapPOI;
	local x1, x2, y1, y2;

	for i=1, WORLDMAP_POIS do
		worldMapPOI = getglobal("AoAWorldMapPOI"..i);
		if ( i <= numPOIs ) then
			name, description, textureIndex, x, y = GetMapLandmarkInfo(i);
			x1, x2, y1, y2 = AoAWMap_GetPOITextureCoords(textureIndex);
			getglobal(worldMapPOI:GetName().."Texture"):SetTexCoord(x1, x2, y1, y2);
			x = x * AoAWorldMapButton:GetWidth() * scale;
			y = -y * AoAWorldMapButton:GetHeight() * scale;
			worldMapPOI:SetPoint("CENTER", "AoAWorldMapButton", "TOPLEFT", x, y );
			worldMapPOI.name = name;
			worldMapPOI.description = description;
			worldMapPOI:Show();
		else
			worldMapPOI:Hide();
		end
	end
]]--
	
end


function AoAWorldMapUnit_OnEnter()
	-- Adjust the tooltip based on which side the unit button is on
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	
	-- See which POI's are in the same region and include their names in the tooltip
	local unitButton;
	local newLineString = "";
	local tooltipText = "";
	local class, color;
	
	-- Check player
	if ( MouseIsOver(AoAWorldMapPlayer) ) then
		_, class = UnitClass("player");
		color = CLASS_COLORS[class];
		tooltipText = UnitLevel("player").." "..color.hex..UnitName("player").."|r";
		newLineString = "\n";
	end
	
	-- Check party
	for i=1, MAX_PARTY_MEMBERS do
		unitButton = getglobal("AoAWorldMapParty"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			_, class = UnitClass("party"..i);
			color = CLASS_COLORS[class];
			tooltipText = tooltipText..newLineString..UnitLevel("party"..i).." "..color.hex..UnitName("party"..i).."|r";
			newLineString = "\n";
		end
	end
	
	--Check Raid
	for i=1, MAX_RAID_MEMBERS do
		unitButton = getglobal("AoAWorldMapRaid"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			_, class = UnitClass("raid"..i);
			color = CLASS_COLORS[class];
			tooltipText = tooltipText..newLineString..UnitLevel("raid"..i).." "..color.hex..UnitName("raid"..i).."|r";		
			newLineString = "\n";
		end
	end
	
	GameTooltip:SetText(tooltipText);
	GameTooltip:Show();
end


--------------------------------------------------------------------------------
-- Continent/Zone DropDowns
--------------------------------------------------------------------------------


function AoAWMapContinentsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, AoAWMapContinentsDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end


function AoAWMapContinentsDropDown_Initialize()
	AoAWMapFrame_LoadContinents(GetMapContinents());
end


function AoAWMapFrame_LoadContinents(...)
	local info;
	for i=1, arg.n, 1 do
		info = {};
		info.text = arg[i];
		info.func = AoAWMapContinentButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


function AoAWMapZoneDropDown_OnLoad()
	this:RegisterEvent("WORLD_MAP_UPDATE");
	UIDropDownMenu_Initialize(this, AoAWMapZoneDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end


function AoAWMapZoneDropDown_Initialize()
	AoAWMapFrame_LoadZones(GetMapZones(GetCurrentMapContinent()));
end


function AoAWMapFrame_LoadZones(...)
	local info;
	for i=1, arg.n, 1 do
		info = {};
		info.text = arg[i];
		info.func = AoAWMapZoneButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end


function AoAWMapContinentButton_OnClick()
	UIDropDownMenu_SetSelectedID(AoAWorldMapContinentDropDown, this:GetID());
	SetMapZoom(this:GetID());
end


function AoAWMapZoneButton_OnClick()
	UIDropDownMenu_SetSelectedID(AoAWorldMapZoneDropDown, this:GetID());
	SetMapZoom(GetCurrentMapContinent(), this:GetID());
end


function AoAWMap_UpdateZoneDropDownText()
	if ( GetCurrentMapZone() == 0 ) then
		UIDropDownMenu_ClearAll(AoAWorldMapZoneDropDown);
	else
		UIDropDownMenu_SetSelectedID(AoAWorldMapZoneDropDown, GetCurrentMapZone());
	end
end


function AoAWMap_UpdateContinentDropDownText()
	if ( GetCurrentMapContinent() == 0 ) then
		UIDropDownMenu_ClearAll(AoAWorldMapContinentDropDown);
	else
		UIDropDownMenu_SetSelectedID(AoAWorldMapContinentDropDown,GetCurrentMapContinent());
	end
end


--------------------------------------------------------------------------------
-- FollowButton handling
--------------------------------------------------------------------------------


function AoAWMapFollowButton_OnShow()
	if(AoACharData.WorldMap.FollowPlayer == true) then
		this:SetChecked(1);
	else
		this:SetChecked(0);
	end
end


function AoAWMapFollowButton_OnClick()
	if ( this:GetChecked() ) then
		AoACharData.WorldMap.FollowPlayer = true;
		PlaySound("igMainMenuOptionCheckBoxOn");
		SetMapToCurrentZone();
	else
		AoACharData.WorldMap.FollowPlayer = false;
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end


--------------------------------------------------------------------------------
-- FilterMenu
--------------------------------------------------------------------------------


function AoAWMapFilter_OnUpdate(elapsed)
	if ( this:IsVisible() ) then
		if ( not this.showTimer or not this.isCounting ) then
			return;
		elseif ( this.showTimer < 0 ) then
			this:Hide();
			this.showTimer = nil;
			this.isCounting = nil;
		else
			this.showTimer = this.showTimer - elapsed;
		end
	end
end


function AoAWMapFilter_Init()
  PlaySound("UChatScrollButton");
	
  local maxWidth=1;
  local buttons=0;
  
	-- set buttons
	local i=1;
  while(getglobal(this:GetName().."Button"..i) ~= nil) do
  	local button = getglobal(this:GetName().."Button"..i);
		local check  = getglobal(this:GetName().."Button"..i.."Check");
		if(AoAWMapFilter[i] ~= nil) then
			button:SetText(AoAWMapFilter[i].name);
			if((AoAWMapFilter[i].IsEnabled)() == true) then
				check:Show();
			else
				check:Hide();
			end
			button:Show();
		else
			button:Hide();
		end
  	i=i+1;
  end
	
	-- get max width
	local i=1;
  while(getglobal(this:GetName().."Button"..i) ~= nil) do
  	local button = getglobal(this:GetName().."Button"..i);
  	if(button:IsVisible()) then
  		local normalText = getglobal(button:GetName().."NormalText");
  		local btnWidth = normalText:GetWidth()+20;
  		maxWidth = math.max(maxWidth, btnWidth);
  		normalText:SetPoint("LEFT", button, "LEFT", 0, 0);
  		buttons = buttons + 1;
  	end
  	i=i+1;
  end
	
	-- set the width of each button
  i=1;
  while(getglobal(this:GetName().."Button"..i) ~= nil) do
  	getglobal(this:GetName().."Button"..i):SetWidth(maxWidth);
  	i=i+1;
  end
	
	-- set menu size
  this:SetWidth(maxWidth+40);
  this:SetHeight(32+buttons*16);
	
	-- set hide timer
  this.showTimer = 2;
  this.isCounting = 1;
end


function AoAWMapFilter_OnClick(id)
	(AoAWMapFilter[id].Toggle)();
	AoAWMap_WorldMapUpdate();
end
