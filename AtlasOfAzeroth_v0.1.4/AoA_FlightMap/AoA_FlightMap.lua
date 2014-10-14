--------------------------------------------------------------------------------
-- Parts of the code is inspired or taken from the following AddOn(s)...
--  - FlightMap (http://www.curse-gaming.com/de/wow/addons-883-1-flightmap.html)
--
-- Version history...
--  0.1.0 - Basic node recording
--        - Flighttime counter
--        - Key binding
--  0.1.1 - WorldMap Filter
--  0.1.2 - using the ZoningLibrary
--------------------------------------------------------------------------------


-- Debug mode (true=on, nil=off)
local DEBUG_MODE = nil;

-- Version of the data structure in the saved vars
AOAFMAP_DATA_VERSION = 2;
AOAFMAP_DATA_COMPATIBILITY = 1;

-- Flags of the init routines
local AoAFMap_Initialized = false;
local AoAFMap_ADDON_LOADED = false;
local AoAFMap_VARIABLES_LOADED = false;
local AoAFMap_TabID = nil;

-- some constants, status vars
local WORLDMAP_DETAIL_TILES = 12;
local WORLDMAP_DETAIL_TEXTURE_SIZE = 169;
local FLIGHTMAP_NODES = 64;
local FLIGHTMAP_ROUTES = 64;
local FLIGHTMAP_NODEINFOLINES = 40;

-- flight recording
local flightContinent = nil;
local flightStart = nil;
local flightDest = nil;
local flightTimeStart = nil;
local flightStartRecording = false;
local flightRecording = false;
local FLIGHTMAP_FADESTEP = 0.025;

-- faction to show
local selFaction = "";


-- =============================================================================
-- misc. functions
-- =============================================================================


local function AoA_ChatMessage(text)
	AoAMod_ChatMessage("FlightMap", text);
end

local function AoA_ChatError(text)
	AoAMod_ChatError("FlightMap", text);
end

local function AoA_ChatWarning(text)
	AoAMod_ChatWarning("FlightMap", text);
end

local function AoA_ChatDebug(text)
	if (DEBUG_MODE) then AoAMod_ChatDebug("FlightMap", text); end
end


-- =============================================================================
-- ==  FlightMap Frame
-- =============================================================================


--------------------------------------------------------------------------------
-- Toggle the FlightMap frame
--------------------------------------------------------------------------------
function AoAFMap_Toggle()
	AoA_Toggle(AoAFMap_TabID);
end


--------------------------------------------------------------------------------
-- OnLoad
--------------------------------------------------------------------------------
function AoAFMap_OnLoad()

	-- Register for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	
	-- init texture tiles
	for i=1, WORLDMAP_DETAIL_TILES, 1 do
		getglobal("AoAFlightMapDetailTile"..i):SetHeight(WORLDMAP_DETAIL_TEXTURE_SIZE);
		getglobal("AoAFlightMapDetailTile"..i):SetWidth(WORLDMAP_DETAIL_TEXTURE_SIZE);
		getglobal("AoAFlightMapDetailTile"..i):SetTexture("Interface\\WorldMap\\World\\World"..i);
	end
	
end

function AoAFMap_RegisterEvents()
	this:RegisterEvent("TAXIMAP_OPENED");
	this:RegisterEvent("TAXIMAP_CLOSED");
end

function AoAFMap_UnregisterEvents()
	this:UnregisterEvent("TAXIMAP_OPENED");
	this:UnregisterEvent("TAXIMAP_CLOSED");
end


--------------------------------------------------------------------------------
-- Initializes everything relating to saved variables and data in other lua files
-- This should be called ONLY when we're sure that all other files have been loaded
--------------------------------------------------------------------------------
function AoAFMap_Init()
	
	-- init module
	info = {
		frame = AoAFlightMapFrame;
		init  = AoAFMap_InitModule;
		text  = AOA_FLIGHTMAP_TABTEXT;
		addon = "AoA_FlightMap";
		};
	AoAFMap_TabID = AoA_RegisterModule(info);
	
	-- AddOn is initialized now
	AoAFMap_Initialized = true;
	AoA_ChatMessage(string.format(AOA_LOADED, GetAddOnMetadata("AoA_FlightMap", "Version")));
	
end


--------------------------------------------------------------------------------
-- Initializes the module
-- called by the core addon
--------------------------------------------------------------------------------
function AoAFMap_InitModule()
	
	-- setup the saved variables if needed
	AoAFMap_InitSavedVars();
	
	-- init Filter
	if(AoAWMap_RegisterFilter) then
		info = {
			name       = AOA_FLIGHTMAP_FILTER;
			IsEnabled  = AoAFMap_FilterIsEnabled;
			Toggle     = AoAFMap_FilterToggle;
			GetPOINum  = AoAFMap_FilterGetPOINum;
			GetPOIInfo = AoAFMap_FilterGetPOIInfo;
			}
		AoAWMap_RegisterFilter(info);
	end
	
end


--------------------------------------------------------------------------------
-- Create all the necessary saved variables if they don't exist
-- The default settings for all saved variables are stored here
--------------------------------------------------------------------------------
function AoAFMap_InitSavedVars()
	
	if(AoAData.FlightMap and AoAData.FlightMap.Version and tonumber(AoAData.FlightMap.Version) < AOAFMAP_DATA_VERSION and tonumber(AoAData.FlightMap.Version) >= AOAFMAP_DATA_COMPATIBILITY) then
		AoAFMap_UpdateSavedVars();
	end
	
	--
	-- global data
	--
	
	-- make shure that the saved settings are up to date
	if(AoAData.FlightMap == nil or AoAData.FlightMap.Version == nil or tonumber(AoAData.FlightMap.Version) < AOAFMAP_DATA_COMPATIBILITY) then
		AoAData.FlightMap = {};
		AoAData.FlightMap.Version = AOAFMAP_DATA_VERSION;
		AoA_ChatWarning(AOA_DATA_UPDATED);
	end
	
	-- Nodes data
	if(AoAData.FlightMap.Node == nil) then
		AoAData.FlightMap.Node = { };
	end
	if(AoAData.FlightMap.WMLoc == nil) then
		AoAData.FlightMap.WMLoc = { };
	end
	
	--
	-- char data
	--
	
	-- make shure that the saved settings are up to date
	if(AoACharData.FlightMap == nil or AoACharData.FlightMap.Version == nil or tonumber(AoACharData.FlightMap.Version) < AOAFMAP_DATA_COMPATIBILITY) then
		AoACharData.FlightMap = {};
		AoACharData.FlightMap.Version = AOAFMAP_DATA_VERSION;
		AoA_ChatWarning(AOA_CHARDATA_UPDATED);
	end
	
	-- Nodes data
	if(AoACharData.FlightMap.Node == nil) then
		AoACharData.FlightMap.Node = { };
	end
	
	-- Filters
	buf = AoACharData.FlightMap.Filter_Enabled;
	if(buf ~= "on" and buf ~= "off") then
		AoACharData.FlightMap.Filter_Enabled = "on";
	end
	
end


function AoAFMap_UpdateSavedVars()
	local updFlag = false;
	
	-- update: v1 -> v2
	if(tonumber(AoAData.FlightMap.Version) == 1) then
		AoAData.FlightMap.WMLoc = nil;
		AoAData.FlightMap.Version = 2;
		updFlag = true;
	end
	
	if(updFlag) then AoA_ChatWarning(AOA_FLIGHTMAP_WARN_UPDATEDVARS); end
end


--------------------------------------------------------------------------------
-- OnEvent
--------------------------------------------------------------------------------
function AoAFMap_OnEvent()

	if ( event == "ADDON_LOADED" and arg1 == "AoA_WorldMap") then
		AoAFMap_ADDON_LOADED = true;
	elseif ( event == "VARIABLES_LOADED" ) then
		AoAFMap_VARIABLES_LOADED = true;
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		AoAFMap_RegisterEvents();
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		AoAFMap_UnregisterEvents();
	end
	
	-- Once these two events have fired we can assume that all other files have been loaded
	-- It's now safe to initialize AtlasEnhanced if it hasn't already been done
	if ( AoAFMap_ADDON_LOADED and AoAFMap_VARIABLES_LOADED and AoAFMap_Initialized == false ) then
		AoAFMap_Init();
	end
	
	if(event == "TAXIMAP_OPENED") then
		AoAFMap_OnTaxiMapOpened();
	elseif(event == "TAXIMAP_CLOSED") then
		AoAFMap_OnTaxiMapClosed();
	end
	
end


--------------------------------------------------------------------------------
-- Event: OnShow
--------------------------------------------------------------------------------
function AoAFMap_OnShow()
	
	selFaction = UnitFactionGroup("player");
	if(selFaction == "Horde") then
		UIDropDownMenu_SetSelectedID(AoAFlightMapFactionsDropDown, 1);
	else
		UIDropDownMenu_SetSelectedID(AoAFlightMapFactionsDropDown, 2);
	end
	
	AoAFMap_Update();
	
end


--------------------------------------------------------------------------------
-- Event: OnHide
--------------------------------------------------------------------------------
function AoAFMap_OnHide()
end


--------------------------------------------------------------------------------
-- Update the flight nodes/routes
--------------------------------------------------------------------------------
function AoAFMap_Update()
	local _, unitClass = UnitClass("player");
	
	-- each continent
	for c=1, getn({GetMapContinents()}) do
		local frame = getglobal("AoAFlightMap"..c);
		-- each node button
		for i=1, FLIGHTMAP_NODES do
			-- get node position
			nodeX, nodeY = AoAFMapData_GetNodeTMPos(selFaction, c, i);
			-- show/hide button
			button = getglobal("AoAFlightMapNode"..c.."_"..i);
			if(nodeX ~= nil) then
				nodeX = nodeX * frame:GetWidth();
				nodeY = nodeY * frame:GetHeight();
				if(AoAFMapData_IsNodeKnown(selFaction, c, i)) then
					button:SetNormalTexture("Interface\\TaxiFrame\\UI-Taxi-Icon-White");
				else
					button:SetNormalTexture("Interface\\TaxiFrame\\UI-Taxi-Icon-Red");
				end
				button:SetPoint("CENTER", frame, "BOTTOMLEFT", nodeX, nodeY);
				button.continent = c;
				button.node = i;
				button.text = AoAFMapData_GetNodeName(selFaction, c, i);
				button:Show();
			else
				button:Hide();
			end
		end
		
		-- hide all routes
		for i=1, FLIGHTMAP_ROUTES do
			getglobal("AoAFlightMapRoute"..c.."_"..i):Hide();
		end
		
	end
	
end


function AoAFMap_UpdateNodeInfoFrame()
	
	-- move the info frame
	AoAFlightMapInfo:ClearAllPoints();
	if(this.continent == 2) then
		AoAFlightMapInfo:SetPoint("BOTTOMLEFT", AoAFlightMapFrame, "BOTTOMLEFT", 5, 5);
	else
		AoAFlightMapInfo:SetPoint("BOTTOMRIGHT", AoAFlightMapFrame, "BOTTOMRIGHT", -5, 5);
	end
	
	-- this node label
	AoAFlightMapInfoNodeThis:SetText(this.text);
	
	-- hide old node labels
	for x=1, FLIGHTMAP_NODEINFOLINES, 1 do
		getglobal("AoAFlightMapInfoNodeD"..x):Hide();
		getglobal("AoAFlightMapInfoTimeD"..x):Hide();
		getglobal("AoAFlightMapInfoNodeM"..x):Hide();
		getglobal("AoAFlightMapInfoTimeM"..x):Hide();
	end
	AoAFlightMapInfoNodeD1:SetText("|cffff0000"..AOA_FLIGHTMAP_NOKNOWNPATH);
	AoAFlightMapInfoNodeD1:Show();
	AoAFlightMapInfoNodeM1:SetText("|cffff0000"..AOA_FLIGHTMAP_NOKNOWNPATH);
	AoAFlightMapInfoNodeM1:Show();
	
	-- calculate frame size (base)
	local textHeight = AoAFlightMapInfoDirect:GetHeight();
	local frameHeight = 5 + AoAFlightMapInfoNodeThis:GetHeight() + 5 + textHeight + 5 + textHeight + 8;
	local timeWidth = 0;
	local frameWidth = 10 + AoAFlightMapInfoNodeD1:GetStringWidth();
	
	-- one-hops
	local infolines = 1;
	local hops = AoAFMapData_GetNodeOneHops(selFaction, this.continent, this.node);
	if(hops ~= nil) then
		for key, val in pairs(hops) do
			local color = "";
			if(not AoAFMapData_IsNodeKnown(selFaction, this.continent, key)) then
				color = "|cffff0000";
			end
			getglobal("AoAFlightMapInfoNodeD"..infolines):SetText(color..AoAFMapData_GetNodeName(selFaction, this.continent, key));
			getglobal("AoAFlightMapInfoNodeD"..infolines):Show();
			if(val < 5) then
				getglobal("AoAFlightMapInfoTimeD"..infolines):SetText("--:--");
			else
				local m = math.floor(val / 60);
				local s = val - m * 60;
				getglobal("AoAFlightMapInfoTimeD"..infolines):SetText(string.format("%d:%02d", m, s));
			end
			getglobal("AoAFlightMapInfoTimeD"..infolines):Show();
			timeWidth = math.max(timeWidth, getglobal("AoAFlightMapInfoTimeD"..infolines):GetStringWidth());
			frameWidth = math.max(frameWidth, 10 + getglobal("AoAFlightMapInfoNodeD"..infolines):GetStringWidth());
			infolines = infolines + 1;
		end
	end
	frameHeight = frameHeight + math.max(infolines - 1, 1) * textHeight;
	AoAFlightMapInfoMulti:ClearAllPoints();
	AoAFlightMapInfoMulti:SetPoint("TOPLEFT", getglobal("AoAFlightMapInfoNodeD"..math.max(infolines - 1, 1)), "BOTTOMLEFT", -10, -5);
	
	-- multi-hops
	local infolines = 1;
	local hops = AoAData.FlightMap.Node[selFaction][this.continent];
	for key, val in pairs(hops) do
		if((this.node ~= key) and (hops[this.node].one_hops == nil or hops[this.node].one_hops[key] == nil)) then
			local node = hops[key];
			local color = "";
			if(not AoAFMapData_IsNodeKnown(selFaction, this.continent, key)) then
				color = "|cffff0000";
			end
			getglobal("AoAFlightMapInfoNodeM"..infolines):SetText(color..node.name[GetLocale()]);
			getglobal("AoAFlightMapInfoNodeM"..infolines):Show();
			if(hops[this.node].multi_hops == nil) or (hops[this.node].multi_hops[key] == nil) then
				getglobal("AoAFlightMapInfoTimeM"..infolines):SetText("--:--");
			else
				local dur = hops[this.node].multi_hops[key];
				local m = math.floor(dur / 60);
				local s = dur - m * 60;
				getglobal("AoAFlightMapInfoTimeM"..infolines):SetText(string.format("%d:%02d", m, s));
			end
			getglobal("AoAFlightMapInfoTimeM"..infolines):Show();
			timeWidth = math.max(timeWidth, getglobal("AoAFlightMapInfoTimeM"..infolines):GetStringWidth());
			frameWidth = math.max(frameWidth, 10 + getglobal("AoAFlightMapInfoNodeM"..infolines):GetStringWidth());
			infolines = infolines + 1;
		end
	end
	frameHeight = frameHeight + math.max(infolines - 1, 1) * textHeight;
	
	-- recalculate frame size
	frameWidth = math.max(AoAFlightMapInfoNodeThis:GetStringWidth(), frameWidth + timeWidth);
	
	AoAFlightMapInfo:SetHeight(frameHeight);
	AoAFlightMapInfo:SetWidth(8 + frameWidth + 8);
	AoAFlightMapInfo:Show();
end


--------------------------------------------------------------------------------
-- Event: OnTaxiMapOpened
--------------------------------------------------------------------------------
function AoAFMap_OnTaxiMapOpened()
	local num_nodes = NumTaxiNodes();
	local current_node;
	
	-- get current player position
	SetMapToCurrentZone();
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	local px , py = GetPlayerMapPosition("player");
	
	-- save nodes
	for index = 1, num_nodes do
		local type = TaxiNodeGetType(index);
		if(type ~= "NONE") then
			local x, y = TaxiNodePosition(index);
			AoAFMapData_SaveNodeInfo(continent, x, y, TaxiNodeName(index));
			if(type == "CURRENT") then
				current_node = AoAFMapData_TMPos2index(continent, x, y);
				AoAFMapData_SaveNodeWMLoc(current_node, continent, zone, px, py);
				
				flightContinent = continent;
				flightStart = current_node;
			end
		end
	end
	
	-- save one hops
	for index = 1, num_nodes do
		if(GetNumRoutes(index) == 1) then
			local x, y = TaxiNodePosition(index);
			local hop_node = AoAFMapData_TMPos2index(continent, x, y);
			AoAFMapData_AddOneHop(continent, current_node, hop_node);
		end
	end
	
	AoAFMap_Update();
end


--------------------------------------------------------------------------------
-- Event: OnTaxiMapClosed
--------------------------------------------------------------------------------
function AoAFMap_OnTaxiMapClosed()
end


--------------------------------------------------------------------------------
-- Factions DropDowns
--------------------------------------------------------------------------------


function AoAFMapFactionsDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, AoAFMapFactionsDropDown_Initialize);
	UIDropDownMenu_SetWidth(130);
end


function AoAFMapFactionsDropDown_Initialize()
	local info;
	
	info = {};
	info.func = AoAFMapFactionsButton_OnClick;
	info.text = FACTION_HORDE;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.func = AoAFMapFactionsButton_OnClick;
	info.text = FACTION_ALLIANCE;
	UIDropDownMenu_AddButton(info);
end


function AoAFMapFactionsButton_OnClick()
	UIDropDownMenu_SetSelectedID(AoAFlightMapFactionsDropDown, this:GetID());
	if(this:GetID() == 1) then
		selFaction = "Horde";
	else
		selFaction = "Alliance"
	end
	AoAFMap_Update();
end


-- =============================================================================
-- ==  NodeButton
-- =============================================================================


function AoAFMapNode_OnEnter()
	
	-- draw one-hops
	local hops = AoAFMapData_GetNodeOneHops(selFaction, this.continent, this.node);
	if(hops ~= nil) then
		local w = getglobal("AoAFlightMap"..this.continent):GetWidth();
		local h = getglobal("AoAFlightMap"..this.continent):GetHeight();
		for key, val in pairs(hops) do
			button = getglobal("AoAFlightMapNode"..this.continent.."_"..key);
			button:SetNormalTexture("Interface\\TaxiFrame\\UI-Taxi-Icon-Green");
			
			local line = getglobal("AoAFlightMapRoute"..this.continent.."_"..key);
			local x, y;
			if(line) then
				x, y = AoAFMapData_GetNodeTMPos(selFaction, this.continent, this.node);
				sX = x*w;
				sY = y*h;
				x, y = AoAFMapData_GetNodeTMPos(selFaction, this.continent, key);
				dX = x*w;
				dY = y*h;
				DrawRouteLine(line, "AoAFlightMap"..this.continent, sX, sY, dX, dY, 32);
				line:Show();
			end
			
		end
	end
	
	AoAFMap_UpdateNodeInfoFrame();
end


function AoAFMapNode_OnLeave()
	AoAFMap_Update();
	AoAFlightMapInfo:Hide();
end


--------------------------------------------------------------------------------
-- FilterPOIs
--------------------------------------------------------------------------------
function AoAFMap_FilterIsEnabled()
	return (AoACharData.FlightMap.Filter_Enabled == "on");
end


function AoAFMap_FilterToggle()
	if(AoACharData.FlightMap.Filter_Enabled == "on") then
		AoACharData.FlightMap.Filter_Enabled = "off";
	else
		AoACharData.FlightMap.Filter_Enabled = "on";
	end
end


function AoAFMap_FilterGetPOINum(continent, zone)
	if(AoAFMap_FilterIsEnabled()) then
		if(AoAData.FlightMap.WMLoc ~= nil) then
			if(AoAData.FlightMap.WMLoc[UnitFactionGroup("player")] ~= nil) then
				if(AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent] ~= nil) then
					if(AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent][AoALibZones_ZoneShift[continent][zone]] ~= nil) then
						local count=0;
						for i=1,64 do
							if(AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent][AoALibZones_ZoneShift[continent][zone]][i] ~= nil) then
								count = count+1;
							end
						end
						return count;
					end
				end
			end
		end
	end
	return 0;
end


function AoAFMap_FilterGetPOIInfo(index, continent, zone)
	local texture = "Interface\\TaxiFrame\\UI-Taxi-Icon-Green";
	local count=0;
	local x, x, name;
	for i=1,64 do
		if(AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent][AoALibZones_ZoneShift[continent][zone]][i] ~= nil) then
			count = count+1;
			if(count == index) then
				x = AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent][AoALibZones_ZoneShift[continent][zone]][i].x;
				y = AoAData.FlightMap.WMLoc[UnitFactionGroup("player")][continent][AoALibZones_ZoneShift[continent][zone]][i].y;
				name = AoAFMapData_GetNodeName(UnitFactionGroup("player"), continent, i);
				return texture, x, y, 24, name;
			end
		end
	end
end


-- =============================================================================
-- == FlightTimer
-- =============================================================================


function AoAFMap_OnTimerUpdate()
	if (UnitOnTaxi("player") == 1) then
	
		-- start the flight counter
		if (flightStartRecording == true) then
			-- setup the flight counter
			flightStartRecording = false;
			flightRecording = true;
			flightTimeStart = time();
			-- show and init the in flight timer
			AoAFlightMapTimerFrameDest:SetText("|cffffb200"..AoAFMapData_GetNodeName(UnitFactionGroup("player"), flightContinent, flightDest));
			AoAFlightMapTimerFrameCountDown:SetText(AOA_FLIGHTMAP_FLIGHTCOUNT);
			AoAFlightMapTimerFrame.fadeIn = 1;
			AoAFlightMapTimerFrame:SetAlpha(0);
			AoAFlightMapTimerFrame:Show();
		end
		
		-- set the countdown text
		if(flightContinent ~= nil and flightStart ~= nil and flightDest ~= nil) then
			local old_time = 0;
			if(AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].one_hops ~= nil and
			   AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].one_hops[flightDest] ~= nil) then
				old_time = AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].one_hops[flightDest];
			end
			if(AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops ~= nil and
			   AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops[flightDest] ~= nil) then
				old_time = AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops[flightDest];
			end
			if(old_time > 1 and old_time < (30*60)) then
				local rest_time = math.max(0, old_time - (time() - flightTimeStart));
				local m = math.floor(rest_time / 60);
				local s = rest_time - (m * 60);
				AoAFlightMapTimerFrameCountDown:SetText(string.format(AOA_FLIGHTMAP_FLIGHTTIME, m, s));
				
			end
			if(old_time > (30*60)) then
				AoAFlightMapTimerFrameCountDown:SetText(AOA_FLIGHTMAP_FLIGHTTIMEINVALID);
			end
			if(AoAFlightMapTimerFrame.fadeIn) then
				local alpha = AoAFlightMapTimerFrame:GetAlpha() + FLIGHTMAP_FADESTEP;
				if (alpha < 1) then
					AoAFlightMapTimerFrame:SetAlpha(alpha);
				else
					AoAFlightMapTimerFrame.fadeIn = nil;
				end
			end
		end
		
	else
	
		-- save the measured flight duration
		if (flightRecording == true) then
			local flightDuration = time() - flightTimeStart;
			if(AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].one_hops[flightDest] ~= nil) then
				AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].one_hops[flightDest] = flightDuration;
			else
				if(AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops == nil) then
					AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops = {};
				end
				AoAData.FlightMap.Node[UnitFactionGroup("player")][flightContinent][flightStart].multi_hops[flightDest] = flightDuration;
			end
			flightRecording = false;
			flightStartRecording = false;
			
			-- hide the in flight timer
			AoAFlightMapTimerFrame.fadeOut = 1;
		end
		
		if(AoAFlightMapTimerFrame.fadeOut) then
			local alpha = AoAFlightMapTimerFrame:GetAlpha() - FLIGHTMAP_FADESTEP;
			if(alpha > 0) then
				AoAFlightMapTimerFrame:SetAlpha(alpha);
			else
				AoAFlightMapTimerFrame.fadeOut = nil;
				AoAFlightMapTimerFrame:Hide();
			end
		end

	end
end


-- =============================================================================
-- ==  FlightData Library
-- =============================================================================


function AoAFMapData_AddOneHop(continent, srcNode, dstNode)
	local faction = UnitFactionGroup("player");
	
	-- setup data if needed
	if(AoAData.FlightMap.Node[faction] == nil)then
		AoAData.FlightMap.Node[faction] = {};
	end
	if(AoAData.FlightMap.Node[faction][continent] == nil)then
		AoAData.FlightMap.Node[faction][continent] = {};
	end
	if(AoAData.FlightMap.Node[faction][continent][srcNode] == nil)then
		AoAData.FlightMap.Node[faction][continent][srcNode] = {};
	end
	if(AoAData.FlightMap.Node[faction][continent][srcNode].one_hops == nil)then
		AoAData.FlightMap.Node[faction][continent][srcNode].one_hops = {};
	end
	
	if(AoAData.FlightMap.Node[faction][continent][srcNode].one_hops[dstNode] == nil)then
		AoAData.FlightMap.Node[faction][continent][srcNode].one_hops[dstNode] = 1;
		AoA_ChatMessage(AOA_FLIGHTMAP_NEWPATH..AoAData.FlightMap.Node[faction][continent][dstNode].name[GetLocale()]);
	end

end


function AoAFMapData_SaveNodeInfo(continent, nodeTMPosX, nodeTMPosY, nodeName)

	local faction = UnitFactionGroup("player");
	local node = nil;
	
	nodeTMPosX = math.floor(nodeTMPosX * 1000) / 1000;
	nodeTMPosY = math.floor(nodeTMPosY * 1000) / 1000;
	
	-- setup data if needed
	if (AoAData.FlightMap.Node[faction] == nil) then
		AoAData.FlightMap.Node[faction] = {};
	end
	if (AoAData.FlightMap.Node[faction][continent] == nil) then
		AoAData.FlightMap.Node[faction][continent] = {};
	end
	if (AoACharData.FlightMap.Node[faction] == nil) then
		AoACharData.FlightMap.Node[faction] = {};
	end
	if (AoACharData.FlightMap.Node[faction][continent] == nil) then
		AoACharData.FlightMap.Node[faction][continent] = {};
	end
	
	-- check if node exists
	local next_node = 1;
	for i=1, getn(AoAData.FlightMap.Node[faction][continent]) do
		if(AoAData.FlightMap.Node[faction][continent][i].pos == nodeTMPosX..":"..nodeTMPosY) then
			node = i;
		end
		next_node = next_node + 1;
	end
	
	-- create new node if it doesn't exist
	if(node == nil) then
		node = next_node;
		AoAData.FlightMap.Node[faction][continent][node] = {
			pos = nodeTMPosX..":"..nodeTMPosY;
			name = { [GetLocale()] = nodeName; };
			one_hops = {};
			multi_hops = {};
			};
		AoA_ChatMessage(AOA_FLIGHTMAP_NEWNODE..nodeName);
	end
	
	-- update name
	if(AoAData.FlightMap.Node[faction][continent][node].name[GetLocale()] == nil or AoAData.FlightMap.Node[faction][continent][node].name[GetLocale()] ~= nodeName) then
		AoAData.FlightMap.Node[faction][continent][node].name[GetLocale()] = nodeName;
		AoA_ChatMessage(AOA_FLIGHTMAP_NODENEWNAME..nodeName);
	end
	
	-- save as known node
	if(AoACharData.FlightMap.Node[faction][continent][node] == nil) then
		AoACharData.FlightMap.Node[faction][continent][node] = true;
	end
	
end


function AoAFMapData_TMPos2index(continent, ...)
	local pos;
	
	if(arg.n == 2) then
		local x = math.floor(arg[1] * 1000) / 1000;
		local y = math.floor(arg[2] * 1000) / 1000;
		pos = x..":"..y;
	else
		pos = arg[1];
	end
	
	for i=1, getn(AoAData.FlightMap.Node[UnitFactionGroup("player")][continent]) do
		if(AoAData.FlightMap.Node[UnitFactionGroup("player")][continent][i].pos == pos) then
			return i;
		end
	end
	
	return nil;
	
end


function AoAFMapData_SaveNodeWMLoc(node, continent, zone, x, y)
	local faction = UnitFactionGroup("player");
	zone = AoALibZones_ZoneShift[continent][zone];
	
	-- setup data if needed
	if (AoAData.FlightMap.WMLoc == nil) then
		AoAData.FlightMap.WMLoc = {};
	end
	if (AoAData.FlightMap.WMLoc[faction] == nil) then
		AoAData.FlightMap.WMLoc[faction] = {};
	end
	if (AoAData.FlightMap.WMLoc[faction][continent] == nil) then
		AoAData.FlightMap.WMLoc[faction][continent] = {};
	end
	if (AoAData.FlightMap.WMLoc[faction][continent][zone] == nil) then
		AoAData.FlightMap.WMLoc[faction][continent][zone] = {};
	end
	if (AoAData.FlightMap.WMLoc[faction][continent][zone][node] == nil) then
		AoAData.FlightMap.WMLoc[faction][continent][zone][node] = {};
	end
	
	x = math.floor(x * 1000) / 1000;
	y = math.floor(y * 1000) / 1000;
	
	AoAData.FlightMap.WMLoc[faction][continent][zone][node].x = x;
	AoAData.FlightMap.WMLoc[faction][continent][zone][node].y = y;
end


function AoAFMapData_IsNodeKnown(faction, continent, node)
	if(AoACharData.FlightMap.Node[faction] ~= nil) then
		if(AoACharData.FlightMap.Node[faction][continent] ~= nil) then
			if(AoACharData.FlightMap.Node[faction][continent][node] ~= nil) then
				return true;
			end
		end
	end
	return false;
end


function AoAFMapData_GetNodeName(faction, continent, node)
	if(AoAData.FlightMap.Node[faction][continent][node].name[GetLocale()] == nil) then
		return "NAME UNKNOWN !!!";
	else
		return AoAData.FlightMap.Node[faction][continent][node].name[GetLocale()];
	end
end


function AoAFMapData_GetNodeTMPos(faction, continent, node)
	local nodeX = nil;
	local nodeY = nil;
	
	if(AoAData.FlightMap.Node[faction] ~= nil) then
		if(AoAData.FlightMap.Node[faction][continent] ~= nil) then
			if(AoAData.FlightMap.Node[faction][continent][node] ~= nil) then
				_, _, nodeX, nodeY = string.find(AoAData.FlightMap.Node[faction][continent][node].pos, "(.*):(.*)");
				nodeX = tonumber(nodeX);
				nodeY = tonumber(nodeY);
			end
		end
	end
	
	return nodeX, nodeY;
end


function AoAFMapData_GetNodeOneHops(faction, continent, node)
	return AoAData.FlightMap.Node[faction][continent][node].one_hops;
end


-- =============================================================================
-- ==  Hooks
-- =============================================================================


function AoAFMapHook_TakeTaxiNode(nodeID)
	local x, y = TaxiNodePosition(nodeID);
	flightDest = AoAFMapData_TMPos2index(flightContinent, x, y);
	flightStartRecording = true;
	
	Blizzard_TakeTaxiNode(nodeID);
end
Blizzard_TakeTaxiNode	= TakeTaxiNode;
TakeTaxiNode = AoAFMapHook_TakeTaxiNode;
