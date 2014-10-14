-- MetaMap
-- Written by MetaHawk - aka Urshurak
METAMAP_TITLE = "MetaMap";
METAMAP_VERSION = "3.01";
METAMAP_NAME = METAMAP_TITLE.."  v"..METAMAP_VERSION;
METAMAP_ICON = "Interface\\WorldMap\\WorldMap-Icon";
METAMAP_MAP_PATH = "Interface\\AddOns\\MetaMap\\Maps\\";
METAMAP_ICON_PATH = "Interface\\AddOns\\MetaMap\\Icons\\";
METAMAP_IMAGE_PATH = "Interface\\AddOns\\MetaMap\\Images\\"
METAMAP_MAPCREDITS = "Maps courtesy of WoW Cartographe and WoWGuru.com";
TITAN_METAMAP_ID = METAMAP_TITLE;
TITAN_METAMAP_FREQUENCY = 1;

METAMAPMENU_BUTTON_HEIGHT = 16;
METAKB_SCROLL_FRAME_BUTTON_HEIGHT = 16;
METAKB_SCROLL_FRAME_BUTTONS_SHOWN = 20;
METAMAPLIST_SCROLL_FRAME_BUTTON_HEIGHT = 20;
METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN = 30;

METAKB_SORTBY_NAME = "name";
METAKB_SORTBY_DESC = "desc";
METAKB_SORTBY_LEVEL = "level";
METAKB_SORTBY_LOCATION = "location";

MetaMap_Details = {
	name = METAMAP_TITLE,
	description = METAMAP_DESC,
	version = METAMAP_VERSION,
	releaseDate = "November 26, 2005",
	author = "MetaHawk",
	email = "admin@metaserve.org.uk",
	website = "",
	category = MYADDONS_CATEGORY_MAP,
}

MetaSet = {};
MetaMapOptions = {};

MetaMapNotes_Options = {};
MetaMapZones_0 = 28;
MetaMapZones_1 = 21;
MetaMapZones_2 = 26;
MetaMapNotes_Data = {};
MetaMapNotes_Data[0] = {};
MetaMapNotes_Data[1] = {};
MetaMapNotes_Data[2] = {};
MetaMapNotes_Lines = {};
MetaMapNotes_Lines[0] = {};
MetaMapNotes_Lines[1] = {};
MetaMapNotes_Lines[2] = {};
MetaMapNotes_MiniNote_Data = {};

MetaMapNotes_MiniNote_IsInCity = false;
MetaMapNotes_MiniNote_MapzoomInit = false;
MetaMapNotes_Mininote_UpdateRate = 0;
MetaMapNotes_SetNextAsMiniNote = 0;
MetaMapNotes_AllowOneNote = 0;
MetaMapNotes_LastReceivedNote_xPos = 0;
MetaMapNotes_LastReceivedNote_yPos = 0;
MetaMapNotes_ZoneNames = {};
MetaMapNotes_LastLineClick = {};
MetaMapNotes_LastLineClick.time = 0;

MetaMapNotes_TempData_Id = "";
MetaMapNotes_TempData_Creator = "";
MetaMapNotes_TempData_xPos = "";
MetaMapNotes_TempData_yPos = "";
MetaMapNotes_TempData_Icon = "";
MetaMapNotes_TempData_TextColor = "";
MetaMapNotes_TempData_Info1Color = "";
MetaMapNotes_TempData_Info2Color = "";

MetaMapNotes_PartyNoteData = {};
MetaMapNotes_tloc_xPos = nil;
MetaMapNotes_tloc_yPos = nil;
MetaMapNotes_Used_Notes = 0;
MetaMapNotes_Used_Lines = 0;
MetaMapNotes_NoteSent = "";
FWM_ShowUnexplored = false;

MetaKB_Data = {};
MetaKB_List = {};
MetaKB_UnknownZones = {};
MetaKB_Debug = false;
MetaMap_NoteList = {};

local PingTime = 15;
local Current_Map = "";
local overRide = false;
local g_LastSearch = "";
local g_SearchResults = {};
local g_NextMapNoteIcon = 0;
local g_SavedContinent = 0;
local g_SavedZone = 0;
local g_PlayerX = 0;
local g_PlayerY = 0;
local sortType = METAKB_SORTBY_NAME;
local sortDone = true;
local MetaMap_Debug = false;
local MetaMap_FullScreenMode = false;

METAMAPMENU_LIST = {
	{name = METAMAP_MENU_MODE},
	{name = METAMAP_OPTIONS_AUTOSEL},
	{name = METAMAP_OPTIONS_COORDS},
	{name = METAMAP_OPTIONS_MINICOORDS},
	{name = METAMAPNOTES_SHOWNOTES},
	{name = METAMAPNOTES_SHOW_AUTHOR},
	{name = METAMAP_LIST_TEXT},
	{name = METAMAP_ACTION_MODE},
	{name = METAMAP_OPTIONS_SAVESET},
	{name = "Spacer"},
	{name = METAMAPNOTES_OPTIONS_TEXT},
	{name = METAMAP_FLIGHTMAP_OPTIONS},
	{name = METAMAP_MASTERMOD_OPTIONS},
	{name = METAMAP_GATHERER_OPTIONS},
	{name = METAMAP_GATHERER_SEARCH},
	{name = METAMAP_BWP_OPTIONS},
	{name = METAMAP_OPTIONS_SHOWBUT},
	{name = METAMAP_OPTIONS_SHOWCTBUT},
	{name = METAMAP_OPTIONS_USEMAPMOD},
	{name = METAMAP_KB_TEXT},
	{name = METAMAP_OPTIONS_FWM}
};

METAMAP_DROPDOWN_LIST = {
	[1] = {["zone"] = 28, ["texture"] = "TempleofAhnQiraj"},
	[2] = {["zone"] = 1, ["texture"] = "BlackfathomDeeps"},
	[3] = {["zone"] = 2, ["texture"] = "BlackrockDepths"},
	[4] = {["zone"] = 3, ["texture"] = "BlackrockSpireLower"},
	[5] = {["zone"] = 4, ["texture"] = "BlackrockSpireUpper"},
	[6] = {["zone"] = 5, ["texture"] = "BlackwingLair"},
	[7] = {["zone"] = 6, ["texture"] = "DireMaul"},
	[8] = {["zone"] = 7, ["texture"] = "DireMaulEast"},
	[9] = {["zone"] = 8, ["texture"] = "DireMaulNorth"},
	[10] = {["zone"] = 9, ["texture"] = "DireMaulWest"},
	[11] = {["zone"] = 10, ["texture"] = "Gnomeregan"},
	[12] = {["zone"] = 11, ["texture"] = "Maraudon"},
	[13] = {["zone"] = 12, ["texture"] = "MoltenCore"},
	[14] = {["zone"] = 13, ["texture"] = "OnyxiasLair"},
	[15] = {["zone"] = 14, ["texture"] = "RagefireChasm"},
	[16] = {["zone"] = 15, ["texture"] = "RazorfenDowns"},
	[17] = {["zone"] = 16, ["texture"] = "RazorfenKraul"},
	[18] = {["zone"] = 29, ["texture"] = "RuinsofAhnQiraj"},
	[19] = {["zone"] = 17, ["texture"] = "ScarletMonastery"},
	[20] = {["zone"] = 18, ["texture"] = "Scholomance"},
	[21] = {["zone"] = 19, ["texture"] = "ShadowfangKeep"},
	[22] = {["zone"] = 20, ["texture"] = "Stratholme"},
	[23] = {["zone"] = 21, ["texture"] = "TheDeadmines"},
	[24] = {["zone"] = 22, ["texture"] = "TheStockades"},
	[25] = {["zone"] = 23, ["texture"] = "TheSunkenTemple"},
	[26] = {["zone"] = 24, ["texture"] = "Uldaman"},
	[27] = {["zone"] = 25, ["texture"] = "WailingCaverns"},
	[28] = {["zone"] = 26, ["texture"] = "ZulFarrak"},
	[29] = {["zone"] = 27, ["texture"] = "ZulGurub"},
};


BlackoutWorld:Hide();
WorldMapZoomOutButton:Hide();
WorldMapFrame:SetMovable(true);
WMF_OldScript = WorldMapFrame:GetScript("OnKeyDown")
WorldMapFrame:SetScript("OnKeyDown", nil);
UIPanelWindows["WorldMapFrame"] =	{ area = "center",	pushable = 9 };

function SetEffectiveScale(frame, scale)
	frame.scale = scale;
	local parent = frame:GetParent();
	if(parent) then
		scale = scale / parent:GetEffectiveScale();
	end
	frame:SetScale(scale);
end

function MetaMapTopFrame_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("VARIABLES_LOADED");
end

function MetaMapTopFrame_OnShow()
	local cZone = GetRealZoneText();
	for i in METAMAP_DROPDOWN_LIST do
		local mapName = MetaMap_Data[METAMAP_DROPDOWN_LIST[i]["zone"]]["ZoneName"];
		if(cZone == mapName) then
			UIDropDownMenu_SetSelectedID(MetaMapFrameDropDown, i);
			MetaMapOptions.MetaMapZone = METAMAP_DROPDOWN_LIST[i]["zone"];
			MetaMap_Refresh();
		end
	end
	local pX, pY = GetPlayerMapPosition("Player");
	if(pX == 0 and pY == 0) then
		MetaMap_Toggle(true)
	else
		MetaMap_Toggle(false)
	end
	MetaMapOptions_Init();
end

function MetaMapTopFrame_OnEvent()
	if(event == "ADDON_LOADED" and arg1 == "MetaMap") then
		if(MetaSet.SaveSet == nil) then MetaSet.SaveSet = 1; end
		if(MetaSet.MetaData == nil) then MetaSet.MetaData = false; end
		if(MetaSet.MapNotes == nil) then MetaSet.MapNotes = false; end
		if(MetaSet.MetaKB == nil) then MetaSet.MetaKB = false; end
		if(MetaSet.KBupdated == nil) then MetaSet.KBupdated = false; end
		if (MetaMapOptions.MetaMapAlpha1 == nil) then MetaMapOptions.MetaMapAlpha1 = 1.0; end
		if (MetaMapOptions.MetaMapAlpha2 == nil) then MetaMapOptions.MetaMapAlpha2 = 0.60; end
		if (MetaMapOptions.MetaMapScale1 == nil) then MetaMapOptions.MetaMapScale1 = 0.75; end
		if (MetaMapOptions.MetaMapScale2 == nil) then MetaMapOptions.MetaMapScale2 = 0.55; end
		if (MetaMapOptions.MetaMapTTScale1 == nil) then MetaMapOptions.MetaMapTTScale1 = 1.0; end
		if (MetaMapOptions.MetaMapTTScale2 == nil) then MetaMapOptions.MetaMapTTScale2 = 0.75; end
		if (MetaMapOptions.MetaMapCoords == nil) then MetaMapOptions.MetaMapCoords = true; end
		if (MetaMapOptions.MetaMapMiniCoords == nil) then MetaMapOptions.MetaMapMiniCoords = true; end
		if (MetaMapOptions.MetaMapButtonShown == nil) then MetaMapOptions.MetaMapButtonShown = true; end
		if (MetaMapOptions.MetaMapButtonPosition == nil) then MetaMapOptions.MetaMapButtonPosition = 220; end
		if (MetaMapOptions.MasterModButtonShown == nil) then MetaMapOptions.MasterModButtonShown = true; end
		if (MetaMapOptions.MetaMapMapName == nil) then MetaMapOptions.MetaMapMapName = true; end
		if (MetaMapOptions.MetaMapZone == nil) then MetaMapOptions.MetaMapZone = 1; end
		if (MetaMapOptions.TooltipWrap == nil) then MetaMapOptions.TooltipWrap = true; end
		if (MetaMapOptions.MetaMapShowNotes == nil) then MetaMapOptions.MetaMapShowNotes = true; end
		if (MetaMapOptions.MetaMapShowAuthor == nil) then MetaMapOptions.MetaMapShowAuthor = true; end
		if (MetaMapOptions.MenuMode == nil) then MetaMapOptions.MenuMode = false; end
		if (MetaMapOptions.UseMapMod == nil) then MetaMapOptions.UseMapMod = false; end
		if (MetaMapOptions.ShowOnlyLocalNPCs == nil) then MetaMapOptions.ShowOnlyLocalNPCs = false; end
		if (MetaMapOptions.ShowUpdates == nil) then MetaMapOptions.ShowUpdates = false; end
		if (MetaMapOptions.CreateMapNotesBoundingBox == nil) then MetaMapOptions.CreateMapNotesBoundingBox = true; end
		if (MetaMapOptions.AutoTrack == nil) then MetaMapOptions.AutoTrack = false; end
		if (MetaMapOptions.KBstate == nil) then MetaMapOptions.KBstate = false; end
		if (MetaMapOptions.NewTargetNote == nil) then MetaMapOptions.NewTargetNote = false; end
		if (MetaMapOptions.ShowMapList == nil) then MetaMapOptions.ShowMapList = false; end
		if (MetaMapOptions.ActionMode1 == nil) then MetaMapOptions.ActionMode = false; end
		if (MetaMapOptions.ActionMode2 == nil) then MetaMapOptions.ActionMode = false; end
		if (MetaMapOptions.RangeCheck == nil) then MetaMapOptions.RangeCheck = 1; end

		Current_Map = GetCurrentMapZone();
	end

	if event == "VARIABLES_LOADED" then
		if(not MetaSet.MetaData and MetaMap_NoteData ~= nil) then
			MetaMap_StatusPrint("Converting Default POI data...", true);
			Import_MetaMapData();
			MetaSet.MetaData = true;
		else
			MetaMap_NoteData = nil;
		end
		if(not MetaSet.MapNotes and MapNotes_Data ~= nil) then
			MetaMap_StatusPrint("Importing MapNotes data....", true);
			Import_MapNotes();
			MetaSet.MapNotes = true;
		end
		if(not MetaSet.MetaKB and WoWKB_Data ~= nil) then
			MetaMap_StatusPrint("Importing WoWKB data....", true);
			Import_WoWKB();
			MetaMap_StatusPrint("WoWKB data imported into MetaMap.",true);
			MetaSet.MetaKB = true;
		end
		if(not MetaSet.KBupdated and MetaKB_Data ~= nil) then
			MetaMap_StatusPrint("Updating Database to new format....", true);
			MetaKB_UpdateDB();
			MetaMap_StatusPrint("Database updated.", true);
			MetaSet.KBupdated = true;
		end

		MetaMapMenu_Init();
		MetaKB_OptionsFrameInit();
		--MetaMap_StatusPrint(format(TEXT(METAKB_STATS_LINE), MetaKB_GetDataStats()), true);
	end

	if(event == "WORLD_MAP_UPDATE") then
		if(Current_Map ~= GetCurrentMapZone()) then
			MetaMap_Toggle(false);
			Current_Map = GetCurrentMapZone();
		end
		if(MetaMap_Debug) then
			Zone_Debug();
		end
	end

	if(event == "PLAYER_ENTERING_WORLD") then
		pX, pY = GetPlayerMapPosition("Player");
		if(pX == 0 and pY == 0) then
			MetaMap_Toggle(true);
		else
			MetaMap_Toggle(false);
		end
	end
end

function MetaMap_ToggleFrame(frame)
	if frame:IsVisible() then
		frame:Hide();
	else
		frame:Show();
	end
end

function MetaMap_FullScreenToggle()
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();
	if(MetaMap_FullScreenMode) then
		WorldMapFrame:SetMovable(true);
		WorldMapFrame:SetScript("OnKeyDown", nil);
		WorldMapFrame:SetScript("OnKeyUp", nil);
		UIPanelWindows["WorldMapFrame"] =	{ area = "center",	pushable = 9 };
		MetaMapMenu:SetParent("UIParent");
		MetaMapMenu:SetFrameStrata("FULLSCREEN");
		UIPanelWindows['MetaMapMenu'] = {area = 'center', pushable = 0};
		MetaMap_FullScreenMode = false;
		BlackoutWorld:Hide();
		if(WorldMapFrame:IsVisible()) then
			CloseAllWindows();
			ShowUIPanel(WorldMapFrame);
		end
		MetaMapOptions_Init();
	else
		local WMF_AddScript = X_Frame:GetScript("OnKeyUp")
		MetaMapMenu:SetParent("WorldMapFrame");
		WorldMapFrame:SetMovable(false);
		WorldMapFrame:SetScale(1.0);
		WorldMapFrame:SetScript("OnKeyDown", WMF_OldScript);
		WorldMapFrame:SetScript("OnKeyUp", WMF_AddScript);
		UIPanelWindows["WorldMapFrame"] =	{ area = "full",	pushable = 0 };
		BlackoutWorld:Show();
		MetaMap_FullScreenMode = true;
		if(WorldMapFrame:IsVisible()) then
			CloseAllWindows();
			ShowUIPanel(WorldMapFrame);
		end
	end
	SetMapZoom(continent, zone);
end

function MetaMainMap_Toggle()
	if(WorldMapFrame:IsVisible()) then
		HideUIPanel(WorldMapFrame);
	else
		ShowUIPanel(WorldMapFrame);
	end
end

function MetaMap_Toggle(show)
	if(show) then
		ShowUIPanel(MetaMapFrame);
		HideUIPanel(WorldMapDetailFrame);
		HideUIPanel(WorldMapButton);
		ShowWorldMapArrowFrame(0);
		if(IsAddOnLoaded("CT_MapMod")) then
			WorldMapFrameCreateNoteOnPlayer:Disable();
		end
	else
		HideUIPanel(MetaMapFrame);
		ShowUIPanel(WorldMapDetailFrame);
		ShowUIPanel(WorldMapButton);
		ShowWorldMapArrowFrame(1);
		if(IsAddOnLoaded("CT_MapMod")) then
			WorldMapFrameCreateNoteOnPlayer:Enable();
		end
		MetaMapList_Init();
	end
	if(MetaMap_Debug) then
		Zone_Debug();
	end
end

function MetaMap_UpdateAlpha()
	if(MetaSet.SaveSet == 1) then
		MetaMapOptions.MetaMapAlpha1 = MetaMapAlphaSlider:GetValue();
		WorldMapFrame:SetAlpha(MetaMapOptions.MetaMapAlpha1);
	else
		MetaMapOptions.MetaMapAlpha2 = MetaMapAlphaSlider:GetValue();
		WorldMapFrame:SetAlpha(MetaMapOptions.MetaMapAlpha2);
	end
	MetaMapMainCoords:SetAlpha(255);
	MetaMapMenu:SetAlpha(255);
	WorldMapButton:SetAlpha(MetaMapAlphaSlider:GetValue() + 0.2);
end

function MetaMap_UpdateScale()
	if(not MetaMap_FullScreenMode) then
		if(MetaSet.SaveSet == 1) then
			MetaMapOptions.MetaMapScale1 = MetaMapScaleSlider:GetValue();
			SetEffectiveScale(WorldMapFrame, MetaMapOptions.MetaMapScale1);
		else
			MetaMapOptions.MetaMapScale2 = MetaMapScaleSlider:GetValue();
			SetEffectiveScale(WorldMapFrame, MetaMapOptions.MetaMapScale2);
		end
		MetaMapTopFrame:SetWidth(WorldMapButton:GetWidth()+10);
		MetaMapTopFrame:SetHeight(WorldMapButton:GetHeight()+100);
	end
end

function MetaMap_UpdateTTScale()
	if(MetaSet.SaveSet == 1) then
		MetaMapOptions.MetaMapTTScale1 = MetaMapTTScaleSlider:GetValue();
		SetEffectiveScale(WorldMapTooltip, MetaMapOptions.MetaMapTTScale1);
	else
		MetaMapOptions.MetaMapTTScale2 = MetaMapTTScaleSlider:GetValue();
		SetEffectiveScale(WorldMapTooltip, MetaMapOptions.MetaMapTTScale2);
	end
end

function MetaMap_Refresh()
	local currentZone = GetRealZoneText();
	local zoneID = MetaMapOptions.MetaMapZone;
	for i in METAMAP_DROPDOWN_LIST do
		if(METAMAP_DROPDOWN_LIST[i]["zone"] == MetaMapOptions.MetaMapZone) then
			MetaMapMap:SetTexture(METAMAP_MAP_PATH..METAMAP_DROPDOWN_LIST[i]["texture"]);
		end
	end
	MetaMapText_Instance:SetText("|cffffffff"..MetaMap_Data[zoneID]["ZoneName"]);
	MetaMapText_Location:SetText(METAMAP_STRING_LOCATION..": ".."|cffffffff"..MetaMap_Data[zoneID]["Location"]);
	MetaMapText_LevelRange:SetText(METAMAP_STRING_LEVELRANGE..": ".."|cffffffff"..MetaMap_Data[zoneID]["LevelRange"]);
	MetaMapText_PlayerLimit:SetText(METAMAP_STRING_PLAYERLIMIT..": ".."|cffffffff"..MetaMap_Data[zoneID]["PlayerLimit"]);
	MetaMapNotes_MapUpdate();
end

function MetaMapFrameDropDown_Initialize()
	local info;
	for i in METAMAP_DROPDOWN_LIST do
		if(MetaMapNotes_Data[0][i] == nil) then
			MetaMapNotes_Data[0][i] = {};
			MetaMapNotes_Lines[0][i] = {};
		end
		info = {
			text = MetaMap_Data[METAMAP_DROPDOWN_LIST[i]["zone"]]["ZoneName"];
			func = MetaMapFrameDropDownButton_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

function MetaMapFrameDropDown_OnEvent()
	if(event == "VARIABLES_LOADED") then
		UIDropDownMenu_Initialize(MetaMapFrameDropDown, MetaMapFrameDropDown_Initialize);
		for i in METAMAP_DROPDOWN_LIST do
			if(METAMAP_DROPDOWN_LIST[i]["zone"] == MetaMapOptions.MetaMapZone) then
				UIDropDownMenu_SetSelectedID(MetaMapFrameDropDown, i);
			end
		end
		UIDropDownMenu_SetWidth(175);
	end
end

function MetaMapFrameDropDownButton_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(MetaMapFrameDropDown, i);
	MetaMapOptions.MetaMapZone = METAMAP_DROPDOWN_LIST[i]["zone"];
	MetaMap_Toggle(true);
	MetaMap_Refresh();
end

------------------
-- Options Section
------------------
function MetaMapMenu_Init()
	MetaMapButton.haveAbilities = true;
	local x = 1; local y = 1;
	for i, menudata in METAMAPMENU_LIST do
		local flag = false;
		getglobal("MetaMapMenu_Option"..x):SetHeight(METAMAPMENU_BUTTON_HEIGHT);
		local button = getglobal("MetaMapMenu_Option"..x);
		if(x == 1) then
			button.toggle = MetaMapOptions.MenuMode;
		elseif(x == 2) then
			button.toggle = MetaMapOptions.TooltipWrap;
		elseif(x == 3) then
			button.toggle = MetaMapOptions.MetaMapCoords;
		elseif(x == 4) then
			button.toggle = MetaMapOptions.MetaMapMiniCoords;
		elseif(x == 5) then
			button.toggle = MetaMapOptions.MetaMapShowNotes;
		elseif(x == 6) then
			button.toggle = MetaMapOptions.MetaMapShowAuthor;
		elseif(x == 7) then
			button.toggle = MetaMapOptions.ShowMapList;
		elseif(x == 8) then
			if(MetaSet.SaveSet == 1) then
				button.toggle = MetaMapOptions.ActionMode1;
			else
				button.toggle = MetaMapOptions.ActionMode2;
			end
		elseif(x == 9) then
			button.toggle = false;
			getglobal("MetaMapMenu_Option"..x.."Text"):SetText(MetaSet.SaveSet)
		elseif(x == 10) then
			-- spacer
		elseif(x ==11) then
			button.toggle = false;
		elseif(x == 12) then
			if(IsAddOnLoaded("FlightMap")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 13) then
			if(IsAddOnLoaded("CT_MasterMod")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 14) then
			if(IsAddOnLoaded("Gatherer")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 15) then
			if(IsAddOnLoaded("Gatherer")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 16) then
			if(IsAddOnLoaded("BetterWaypoints")) then
				button.toggle = false;
			else
				flag = true;
			end
		elseif(x == 17) then
			button.toggle = MetaMapOptions.MetaMapButtonShown;
		elseif(x == 18) then
			if(IsAddOnLoaded("CT_MasterMod")) then
				button.toggle = MetaMapOptions.MasterModButtonShown;
			else
				flag = true;
			end
		elseif(x == 19) then
			if(IsAddOnLoaded("CT_MapMod")) then
				button.toggle = MetaMapOptions.UseMapMod;
			else
				MetaMapOptions.UseMapMod = false;
				flag = true;
			end
		elseif(x == 20) then
			button.toggle = false;
		elseif(x == 21) then
			button.toggle = FWM_ShowUnexplored;
		end
		
		if(flag) then
			button:SetHeight(1);
			button:Hide();
			y = y - 1;
		elseif(menudata.name == "Spacer") then
			button:SetHeight(8);
			button:Hide();
		else
			if button.toggle then
				getglobal("MetaMapMenu_Option"..x.."Check"):Show();
			else
				getglobal("MetaMapMenu_Option"..x.."Check"):Hide();
			end
			button:SetText(menudata.name);
			button:Show();
		end
		x = x + 1; y = y + 1;
	end
	MetaMapMenu:SetHeight((METAMAPMENU_BUTTON_HEIGHT * y) + (METAMAPMENU_BUTTON_HEIGHT * 2));
	MetaMapOptions_Init();
end

function MetaMapMenu_Select(id)
	id = tonumber(id)
	local button = getglobal("MetaMapMenu_Option"..id);
	if button.toggle then
		button.toggle = false;
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	else
		button.toggle = true;
		getglobal("MetaMapMenu_Option"..id.."Check"):Show()
	end
	if(id == 1) then
		MetaMapOptions.MenuMode = button.toggle;
	elseif(id == 2) then
		MetaMapOptions.TooltipWrap = button.toggle;
	elseif(id == 3) then
		MetaMapOptions.MetaMapCoords = button.toggle;
	elseif(id == 4) then
		MetaMapOptions.MetaMapMiniCoords = button.toggle;
	elseif(id == 5) then
		MetaMapOptions.MetaMapShowNotes = button.toggle;
	elseif(id == 6) then
		MetaMapOptions.MetaMapShowAuthor = button.toggle;
	elseif(id == 7) then
		MetaMapOptions.ShowMapList = button.toggle;
	elseif(id == 8) then
		ActionMode = button.toggle;
		if(MetaSet.SaveSet == 1) then
			MetaMapOptions.ActionMode1 = button.toggle;
		else
			MetaMapOptions.ActionMode2 = button.toggle;
		end
	elseif(id == 9) then
		MetaMapSaveSet_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
		getglobal("MetaMapMenu_Option"..id.."Text"):SetText(MetaSet.SaveSet)
	elseif(id ==10) then
		-- spacer
	elseif(id == 11) then
		MetaMapNotesOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 12) then
		FlightMapOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 13) then
		MasterModOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 14) then
		GathererOptions_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 15) then
		GathererSearch_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 16) then
		BWP_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 17) then
		MetaMapOptions.MetaMapButtonShown = button.toggle;
	elseif(id == 18) then
		MetaMapOptions.MasterModButtonShown = button.toggle;
	elseif(id == 19) then
		MetaMapOptions.UseMapMod = button.toggle;
	elseif(id == 20) then
		KB_Toggle();
		getglobal("MetaMapMenu_Option"..id.."Check"):Hide()
	elseif(id == 21) then
		FWM_ShowUnexplored = button.toggle;
		MetaMapFWM_Init();
	end
	MetaMapOptions_Init();	
end

function MetaMapMenu_OnShow(mode)
	MetaMapMenu:ClearAllPoints();
	local x, y = GetCursorPosition();
	if(MetaMap_FullScreenMode) then
		x = x / WorldMapFrame:GetEffectiveScale();
		y = y / WorldMapFrame:GetEffectiveScale();
	else
		x = x / UIParent:GetEffectiveScale();
		y = y / UIParent:GetEffectiveScale();
	end
	if(mode == "Minimap") then
		MetaMapMenu:SetPoint("TOPRIGHT", "UIParent", "BOTTOMLEFT", x + 10, y + 10);
		MetaMapSliderMenu:Show();
		MetaMapButtonSlider:Show();
		MetaMapAlphaSlider:Hide();
		MetaMapScaleSlider:Hide();
		MetaMapTTScaleSlider:Hide();
		MetaMapSliderMenu:SetHeight(55);
	elseif(mode == "Mainmap") then
		MetaMapMenu:SetPoint("TOP", "UIParent", "BOTTOMLEFT", x, y);
		MetaMapSliderMenu:Show();
		MetaMapButtonSlider:Hide();
		MetaMapAlphaSlider:Show();
		MetaMapScaleSlider:Show();
		MetaMapTTScaleSlider:Show();
		MetaMapSliderMenu:SetHeight(105);
	elseif(mode == "Titan") then
		MetaMapMenu:SetPoint("TOP", "UIParent", "BOTTOMLEFT", x, y);
		MetaMapSliderMenu:Hide();
	end
	MetaMapMenu:Show();
end

function MetaMapMenu_OnUpdate()
	if (MetaMapMenu:IsVisible()) then
		if (not MouseIsOver(MetaMapMenu) and not MouseIsOver(MetaMapButtonFrame) and not MouseIsOver(MetaMapFrameOptionsButton) and not MouseIsOver(MetaMapSliderMenu) and not MouseIsOver(TitanPanelMetaMapButton)) then
			MetaMapMenu:Hide();
			MetaMapOptions_Init();
		end
	end
end

function MetaMapSaveSet_Toggle()
	if(MetaSet.SaveSet == 1) then
		MetaSet.SaveSet = 2;
	else
		MetaSet.SaveSet = 1;
	end
	MetaMapOptions_Init();
end

function MetaMapFWM_Init()
	if(not IsAddOnLoaded("MetaMapFWM")) then
		LoadAddOn("MetaMapFWM");
	end
	WorldMapFrame_Update();
end

function MetaMapOptions_Init()
	local ActionMode = false;

	MetaMapButtonSlider:SetValue(MetaMapOptions.MetaMapButtonPosition);
	MetaMapButton_UpdatePosition();
	
	if(MetaSet.SaveSet == 1) then
		if(MetaMapOptions.MetaMapAlpha1 < 0.15) then MetaMapOptions.MetaMapAlpha1 = 0.15; end
		MetaMapScaleSlider:SetValue(MetaMapOptions.MetaMapScale1);
		MetaMapAlphaSlider:SetValue(MetaMapOptions.MetaMapAlpha1);
		MetaMapTTScaleSlider:SetValue(MetaMapOptions.MetaMapTTScale1);
		ActionMode = MetaMapOptions.ActionMode1;
	else
		if(MetaMapOptions.MetaMapAlpha2 < 0.15) then MetaMapOptions.MetaMapAlpha2 = 0.15; end
		MetaMapScaleSlider:SetValue(MetaMapOptions.MetaMapScale2);
		MetaMapAlphaSlider:SetValue(MetaMapOptions.MetaMapAlpha2);
		MetaMapTTScaleSlider:SetValue(MetaMapOptions.MetaMapTTScale2);
		ActionMode = MetaMapOptions.ActionMode2;
	end

	if(ActionMode) then
		WorldMapButton:EnableMouse(false);
		MetaMapTopFrame:EnableMouse(false);
		MetaMapFrame:EnableMouse(false);
	else
		WorldMapButton:EnableMouse(true);
		MetaMapTopFrame:EnableMouse(true);
		MetaMapFrame:EnableMouse(true);
	end

	if(MetaMapOptions.MetaMapButtonShown) then
		MetaMapButton:Show();
	else
		MetaMapButton:Hide();
	end

	if(MetaMapOptions.MetaMapCoords) then
		MetaMapMainCoords:Show();
	else
		MetaMapMainCoords:Hide();
	end

	if(MetaMapOptions.MetaMapMiniCoords) then
		MetaMapMiniCoords:Show();
	else
		MetaMapMiniCoords:Hide();
	end

	if(MetaMapOptions.ShowMapList) then
		MetaMapList_Init();
	else
		MetaMap_MapListFrame:Hide();
	end

	if(IsAddOnLoaded("CT_MasterMod")) then
		if(MetaMapOptions.MasterModButtonShown) then
			CT_OptionBarFrame:Show();
		else
			CT_OptionBarFrame:Hide();
		end
	end
	MetaMap_UpdateAlpha();
	MetaMap_UpdateScale();
	MetaMap_UpdateTTScale();
	MetaMapNotes_MapUpdate();
end

-----------------
-- Button Section
-----------------
function MetaMapButton_UpdatePosition()
	MetaMapButtonFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
		52 - (80 * cos(MetaMapOptions.MetaMapButtonPosition)),
		(80 * sin(MetaMapOptions.MetaMapButtonPosition)) - 52
	);
end

function MetaMap_ButtonTooltip()
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(METAMAP_TITLE, 0, 1, 0);
	GameTooltip:AddLine(METAMAP_BUTTON_TOOLTIP1, 1, 1, 1);
	if(MetaMapOptions.MenuMode) then
		GameTooltip:AddLine(METAMAP_BUTTON_TOOLTIP2, 1, 1, 1);
	end
				GameTooltip:Show();
end

------------------
-- Co-ords Section
------------------
function MetaMap_round(float)
	return floor(float+0.5);
end

function MiniMapCoords_OnUpdate()
	if (MetaMapOptions.MetaMapMiniCoords and Minimap:IsVisible()) then
		MetaMapMiniCoords:Show();
		local output = "";
		local px, py = GetPlayerMapPosition( "player" );
		output = "|cff00ff00"..MetaMap_round(px * 100)..","..MetaMap_round(py * 100);
		MetaMapMiniCoords:SetText(output);
	else
		MetaMapMiniCoords:Hide();
	end
end

function MetaMapCoordsWorldMap_OnUpdate()
	if (MetaMapOptions.MetaMapCoords and WorldMapFrame:IsVisible()) then
		local x, y = GetCursorPosition();
		local px, py = GetPlayerMapPosition("player");
		local OFFSET_X = 0.0022;
		local OFFSET_Y = -0.0262;
		local centerX, centerY = WorldMapFrame:GetCenter();
		local width = WorldMapButton:GetWidth();
		local height = WorldMapButton:GetHeight();
		x = x / WorldMapFrame:GetEffectiveScale();
		y = y / WorldMapFrame:GetEffectiveScale();
		local adjustedX = (x - (centerX - (width/2))) / width;
		local adjustedY = (centerY + (height/2) - y ) / height;
		x = 100 * (adjustedX + OFFSET_X);
		y = 100 * (adjustedY + OFFSET_Y);
		if(x < 0 or y < 0 or x > 100 or y > 100) then
			output1 = "";
		else
			output1 = "|cffffffff"..format("%d,%d",x, y);
		end
		output2 = "|cff00ff00"..MetaMap_round(px * 100)..","..MetaMap_round(py * 100);
		MetaMapCoordsCursor:SetText(output1);
		MetaMapCoordsPlayer:SetText(output2);
	end
end

function MetaMap_StatusPrint(msg, display, r, g, b)
	if(not display) then return; end
	msg = "<"..METAMAP_TITLE..">: "..msg;
	if DEFAULT_CHAT_FRAME then
		if r == nil or g == nil or b == nil then
			r = 1.0
			g = 0.5
			b = 0.25
		end
		DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
	end
end

----------------
-- Notes Section
----------------
function MetaMapNotesOptions_Toggle()
	if(MetaMapNotesOptionsFrame:IsVisible()) then
		MetaMapNotesOptionsFrame:Hide();
	else
		MetaMapNotesOptionsFrame:Show();
	end
end

-- Hooked Functions

-- local orig_MetaMapNotes_Minimap_OnClick
local orig_MetaMapNotes_WorldMapButton_OnClick -- MetaMapNotes hides WorldMapButton_OnClick on right-clicks
local orig_ToggleWorldMap
local orig_ChatFrame_OnEvent -- only hooked if Sky is not present

function MetaMapNotes_Hooker()
	-- Minimap_OnClick
--[[
	function MetaMapNotes_Minimap_OnClickHook(...)
		MetaMapNotes_Minimap_OnClick(unpack(arg))
		orig_MetaMapNotes_Minimap_OnClick(unpack(arg))
	end
	orig_MetaMapNotes_Minimap_OnClick = Minimap_OnClick
	Minimap_OnClick = MetaMapNotes_Minimap_OnClickHook
]]
	-- WorldMapButton_OnClick
	orig_MetaMapNotes_WorldMapButton_OnClick = WorldMapButton_OnClick
	WorldMapButton_OnClick = MetaMapNotes_WorldMapButton_OnClick

	-- ToggleWorldMap
	function MetaMapNotes_ToggleWorldMapHook(...)
		orig_ToggleWorldMap(unpack(arg))
		MetaMapNotes_ToggleWorldMap(unpack(arg))
	end
	orig_ToggleWorldMap = ToggleWorldMap
	ToggleWorldMap = MetaMapNotes_ToggleWorldMapHook

		-- ChatFrame_OnEvent
	if not Sky then
		-- hook when Sky is not present
		orig_ChatFrame_OnEvent = ChatFrame_OnEvent
		ChatFrame_OnEvent = MetaMapNotes_ChatFrame_OnEvent
	end
end

function MetaMapNotes_OnLoad()
	for i=1, MetaMapZones_0, 1 do
		MetaMapNotes_Data[0][i] = {};
		MetaMapNotes_Lines[0][i] = {};
	end
	for i=1, MetaMapZones_1, 1 do
		MetaMapNotes_Data[1][i] = {};
		MetaMapNotes_Lines[1][i] = {};
	end
	for i=1, MetaMapZones_2, 1 do
		MetaMapNotes_Data[2][i] = {};
		MetaMapNotes_Lines[2][i] = {};
	end

	MiniNotePOI.TimeSinceLastUpdate = 0;
	MetaMapNotes_LoadZones();
	WorldMapMagnifyingGlassButton:SetText(METAMAPNOTES_WORLDMAP_HELP_1.."\n"..METAMAPNOTES_WORLDMAP_HELP_2);
	if Sky then
		if ThottbotReplace_ReplaceIt then
			ThottbotReplace_ReplaceIt()
		end
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesEnableCmd",
			commands = METAMAPNOTES_ENABLE_COMMANDS,
			onExecute = MetaMapNotes_GetNoteBySlashCommand,
			helpText = METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesOneNoteCmd",
			commands = METAMAPNOTES_ONENOTE_COMMANDS,
			onExecute = MetaMapNotes_OneNote,
			helpText = METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesMiniNoteCmd",
			commands = METAMAPNOTES_MININOTE_COMMANDS,
			onExecute = MetaMapNotes_NextMiniNote,
			helpText = METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesMiniNoteOnlyCmd",
			commands = METAMAPNOTES_MININOTEONLY_COMMANDS,
			onExecute = MetaMapNotes_NextMiniNoteOnly,
			helpText = METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesMiniNoteOffCmd",
			commands = METAMAPNOTES_MININOTEOFF_COMMANDS,
			onExecute = MetaMapNotes_ClearMiniNote,
			helpText = METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesMntlocCmd",
			commands = METAMAPNOTES_MNTLOC_COMMANDS,
			onExecute = MetaMapNotes_mntloc,
			helpText = METAMAPNOTES_CHAT_COMMAND_MNTLOC_INFO,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesQuickNoteCmd",
			commands = METAMAPNOTES_QUICKNOTE_COMMANDS,
			onExecute = MetaMapNotes_Quicknote,
			helpText = METAMAPNOTES_CHAT_COMMAND_QUICKNOTE,
			}
		)
		Sky.registerSlashCommand(
			{
			id = "MetaMapNotesQuickTlocCmd",
			commands = METAMAPNOTES_QUICKTLOC_COMMANDS,
			onExecute = MetaMapNotes_Quicktloc,
			helpText = METAMAPNOTES_CHAT_COMMAND_QUICKTLOC,
			}
		)
		Sky.registerAlert(
			{
			id = "MN",
			func = MetaMapNotes_GetNoteFromChat,
			description = METAMAP_TITLE.." Listener",
			}
		)
	else
		SlashCmdList["MAPNOTE"] = MetaMapNotes_GetNoteBySlashCommand;
		for i = 1, table.getn(METAMAPNOTES_ENABLE_COMMANDS) do
			setglobal("SLASH_MAPNOTE"..i, METAMAPNOTES_ENABLE_COMMANDS[i]);
		end
		SlashCmdList["ONENOTE"] = MetaMapNotes_OneNote;
		for i = 1, table.getn(METAMAPNOTES_ONENOTE_COMMANDS) do
			setglobal("SLASH_ONENOTE"..i, METAMAPNOTES_ONENOTE_COMMANDS[i]);
		end
		SlashCmdList["MININOTE"] = MetaMapNotes_NextMiniNote;
		for i = 1, table.getn(METAMAPNOTES_MININOTE_COMMANDS) do
			setglobal("SLASH_MININOTE"..i, METAMAPNOTES_MININOTE_COMMANDS[i]);
		end
		SlashCmdList["MININOTEONLY"] = MetaMapNotes_NextMiniNoteOnly;
		for i = 1, table.getn(METAMAPNOTES_MININOTEONLY_COMMANDS) do
			setglobal("SLASH_MININOTEONLY"..i, METAMAPNOTES_MININOTEONLY_COMMANDS[i]);
		end
		SlashCmdList["MININOTEOFF"] = MetaMapNotes_ClearMiniNote;
		for i = 1, table.getn(METAMAPNOTES_MININOTEOFF_COMMANDS) do
			setglobal("SLASH_MININOTEOFF"..i, METAMAPNOTES_MININOTEOFF_COMMANDS[i]);
		end
		SlashCmdList["MNTLOC"] = MetaMapNotes_mntloc;
		for i = 1, table.getn(METAMAPNOTES_MNTLOC_COMMANDS) do
			setglobal("SLASH_MNTLOC"..i, METAMAPNOTES_MNTLOC_COMMANDS[i]);
		end
		SlashCmdList["QUICKNOTE"] = MetaMapNotes_Quicknote;
		for i = 1, table.getn(METAMAPNOTES_QUICKNOTE_COMMANDS) do
			setglobal("SLASH_QUICKNOTE"..i, METAMAPNOTES_QUICKNOTE_COMMANDS[i]);
		end
		SlashCmdList["QUICKTLOC"] = MetaMapNotes_Quicktloc;
		for i = 1, table.getn(METAMAPNOTES_QUICKTLOC_COMMANDS) do
			setglobal("SLASH_QUICKTLOC"..i, METAMAPNOTES_QUICKTLOC_COMMANDS[i]);
		end
		SlashCmdList["ZDEBUG"] = MetaMap_DebugToggle;
		for i = 1, table.getn(METAMAP_ZDEBUG_COMMANDS) do
			setglobal("SLASH_ZDEBUG"..i, METAMAP_ZDEBUG_COMMANDS[i]);
		end
	end
	MetaMapNotes_SetupCurrentZoneFix();
end

function MetaMapNotes_LoadZones()
	MetaMapNotes_ZoneNames = {};
	local continentNames = { GetMapContinents() };
	for i in continentNames do
		MetaMapNotes_ZoneNames[i] = {};
		local zoneNames = { GetMapZones(i) };
		for j in zoneNames do
			local js = MetaMapNotes_ZoneShift[i][j];
			MetaMapNotes_ZoneNames[i][js] = zoneNames[j];
		end
	end
end

function MetaMapNotes_VariablesLoaded()
	if MetaMapNotes_MiniNote_Data.icon == "party" then
		MetaMapNotes_ClearMiniNote(true);
	end
	if MetaMapNotes_MiniNote_Data.icon ~= nil then
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon);
	end
	if myAddOnsFrame_Register then
		myAddOnsFrame_Register(MetaMap_Details);
	end
	MetaMapNotes_Hooker();
end

function MetaMapNotes_GetZone()
	local zonetext = GetRealZoneText();
	for i=1, 2, 1 do
		local j = 1;
		for k, value in MetaMapNotes_ZoneNames[i] do
			if MetaMapNotes_ZoneNames[i][j] == zonetext then
				return i, j;
			end
			j = j + 1;
		end
	end
	return 0, 0;
end

function MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos)
	local i = 1;
	if(zone == 0 and not MetaMapFrame:IsVisible()) then
		return false;
	end
	for j, value in MetaMapNotes_Data[continent][zone] do
		local deltax = abs(MetaMapNotes_Data[continent][zone][i].xPos - xPos);
		local deltay = abs(MetaMapNotes_Data[continent][zone][i].yPos - yPos);
		if(deltax <= 0.0009765625 * MetaMapNotes_MinDiff and deltay <= 0.0013020833 * MetaMapNotes_MinDiff) then
			return i;
		end
		i = i + 1;
	end
	return false;
end

function MetaMapNotes_mntloc(msg)
	if msg == "" then
		MetaMapNotes_tloc_xPos = nil;
		MetaMapNotes_tloc_yPos = nil;
	else
		local i,j,x,y = string.find(msg,"(%d+),(%d+)");
		MetaMapNotes_tloc_xPos = x / 100;
		MetaMapNotes_tloc_yPos = y / 100;
		MetaMap_StatusPrint(METAMAPNOTES_MNTLOC_SET, true);
	end
end

function MetaMapNotes_SetQuickNote(mode)
	if(mode == 1) then
		local msg = Note_EditBox:GetText();
		msg = msg.." "..Coords_EditBox:GetText();
		MetaMapNotes_Quicknote(msg);
	else
		local msg = Coords_EditBox:GetText();
		MetaMapNotes_mntloc(msg);
	end
end

function MetaMapNotes_QuickNoteShow()
	local x, y = GetPlayerMapPosition("player");
	x = MetaKB_Round(x*100, 0);
	y = MetaKB_Round(y*100, 0);
	Coords_EditBox:SetText(x..","..y);
	MetaMapNotes_QuickNoteFrame:Show();
end

function MetaMapNotes_GetNoteFromChat(note, who)
	if who ~= UnitName("player") then
		if gsub(note,".*<MapN+>%s+%w+.*p<([^>]*)>.*","%1",1) == "1" then -- Party Note
			local continent = gsub(note,".*<MapN+> c<([^>]*)>.*","%1",1) + 0
			local zone = gsub(note,".*<MapN+>%s+%w+.*z<([^>]*)>.*","%1",1) + 0
			local xPos = gsub(note,".*<MapN+>%s+%w+.*x<([^>]*)>.*","%1",1) + 0
			local yPos = gsub(note,".*<MapN+>%s+%w+.*y<([^>]*)>.*","%1",1) + 0
			MetaMapNotes_PartyNoteData.continent = continent
			MetaMapNotes_PartyNoteData.zone = zone
			MetaMapNotes_PartyNoteData.xPos = xPos
			MetaMapNotes_PartyNoteData.yPos = yPos
			MetaMap_StatusPrint(format(METAMAPNOTES_PARTY_GET, who, MetaMapNotes_ZoneNames[continent][zone]), true)
			if MetaMapNotes_MiniNote_Data.icon == "party" or MetaMapNotes_Options[16] ~= "off" then
				MetaMapNotes_MiniNote_Data.id = -1
				MetaMapNotes_MiniNote_Data.continent = continent
				MetaMapNotes_MiniNote_Data.zone = zone
				MetaMapNotes_MiniNote_Data.xPos = xPos
				MetaMapNotes_MiniNote_Data.yPos = yPos
				MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_PARTYNOTE
				MetaMapNotes_MiniNote_Data.inf1 = ""
				MetaMapNotes_MiniNote_Data.inf2 = ""
				MetaMapNotes_MiniNote_Data.in1c = 0
				MetaMapNotes_MiniNote_Data.in2c = 0
				MetaMapNotes_MiniNote_Data.color = 0
				MetaMapNotes_MiniNote_Data.icon = "party"
				MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
				MiniNotePOI:Show()
			end
		else
			local continent = gsub(note,".*<MapN+> c<([^>]*)>.*","%1",1) + 0
			local zone = gsub(note,".*<MapN+>%s+%w+.*z<([^>]*)>.*","%1",1) + 0
			local xPos = gsub(note,".*<MapN+>%s+%w+.*x<([^>]*)>.*","%1",1) + 0
			local yPos = gsub(note,".*<MapN+>%s+%w+.*y<([^>]*)>.*","%1",1) + 0
			local title = gsub(note,".*<MapN+>%s+%w+.*t<([^>]*)>.*","%1",1)
			local info1 = gsub(note,".*<MapN+>%s+%w+.*i1<([^>]*)>.*","%1",1)
			local info2 = gsub(note,".*<MapN+>%s+%w+.*i2<([^>]*)>.*","%1",1)
			local creator = gsub(note,".*<MapN+>%s+%w+.*cr<([^>]*)>.*","%1",1)
			local icon = gsub(note,".*<MapN+>%s+%w+.*i<([^>]*)>.*","%1",1)+0
			local tcolor = gsub(note,".*<MapN+>%s+%w+.*tf<([^>]*)>.*","%1",1)+0
			local i1color = gsub(note,".*<MapN+>%s+%w+.*i1f<([^>]*)>.*","%1",1)+0
			local i2color = gsub(note,".*<MapN+>%s+%w+.*i2f<([^>]*)>.*","%1",1)+0
			if MetaMapNotes_LastReceivedNote_xPos == xPos and MetaMapNotes_LastReceivedNote_yPos == yPos then
				-- do nothing, because the previous note is exactly the same as the current note
			else
				local checknote = MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos)
				MetaMapNotes_LastReceivedNote_xPos = xPos
				MetaMapNotes_LastReceivedNote_yPos = yPos
				if checknote then
					MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_NOTETONEAR, who, MetaMapNotes_ZoneNames[continent][zone], MetaMapNotes_Data[continent][zone][checknote].name), true)
					return
				end
				local id = 0
				local i = MetaMapNotes_GetZoneTableSize(MetaMapNotes_Data[continent][zone])
				if MetaMapNotes_SetNextAsMiniNote ~= 2 then
					if (MetaMapNotes_AllowOneNote == 1 and i < MetaMapNotes_NotesPerZone) or (MetaMapNotes_Options[14] ~= "off" and MetaMapNotes_Options[15] == "off" and i < MetaMapNotes_NotesPerZone) or
							(MetaMapNotes_Options[14] ~= "off" and MetaMapNotes_Options[15] ~= "off" and
								i < MetaMapNotes_NotesPerZone - 5) then
						MetaMapNotes_TempData_Id = i + 1
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id] = {}
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].name = title
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].ncol = tcolor
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf1 = info1
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in1c = i1color
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf2 = info2
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in2c = i2color
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].creator = creator
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].icon = icon
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].xPos = xPos
						MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].yPos = yPos
						id = MetaMapNotes_TempData_Id
						MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_GET, who,
						MetaMapNotes_ZoneNames[continent][zone]), true)
					else
						MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_GET, who,
							 MetaMapNotes_ZoneNames[continent][zone]), true)
					end
				end

				if MetaMapNotes_SetNextAsMiniNote ~= 0 then
					MetaMapNotes_MiniNote_Data.xPos = xPos
					MetaMapNotes_MiniNote_Data.yPos = xPos
					MetaMapNotes_MiniNote_Data.continent = continent
					MetaMapNotes_MiniNote_Data.zone = zone
					MetaMapNotes_MiniNote_Data.id = id -- only shown if the note was written...
					MetaMapNotes_MiniNote_Data.name = title
					MetaMapNotes_MiniNote_Data.inf1 = info1
					MetaMapNotes_MiniNote_Data.inf2 = info2
					MetaMapNotes_MiniNote_Data.in1c = i1color
					MetaMapNotes_MiniNote_Data.in2c = i2color
					MetaMapNotes_MiniNote_Data.color = tcolor
					MetaMapNotes_MiniNote_Data.icon = icon
					MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..icon)
					MiniNotePOI:Show()
					MetaMapNotes_SetNextAsMiniNote = 0
				end
				MetaMapNotes_AllowOneNote = 0
			end
		end
	end
end

function MetaMapNotes_GetNoteBySlashCommand(msg)
	local returnValue = false

	if msg ~= "" and msg ~= nil then
		msg = "<MapN> "..msg
		local continent = gsub(msg,".*<MapN+> c<([^>]*)>.*","%1",1) + 0
		local zone = gsub(msg,".*<MapN+>%s+%w+.*z<([^>]*)>.*","%1",1) + 0
		local xPos = gsub(msg,".*<MapN+>%s+%w+.*x<([^>]*)>.*","%1",1) + 0
		local yPos = gsub(msg,".*<MapN+>%s+%w+.*y<([^>]*)>.*","%1",1) + 0
		local title = gsub(msg,".*<MapN+>%s+%w+.*t<([^>]*)>.*","%1",1)
		local info1 = gsub(msg,".*<MapN+>%s+%w+.*i1<([^>]*)>.*","%1",1)
		local info2 = gsub(msg,".*<MapN+>%s+%w+.*i2<([^>]*)>.*","%1",1)
		local creator = gsub(msg,".*<MapN+>%s+%w+.*cr<([^>]*)>.*","%1",1)
		local icon = gsub(msg,".*<MapN+>%s+%w+.*i<([^>]*)>.*","%1",1)+0
		local tcolor = gsub(msg,".*<MapN+>%s+%w+.*tf<([^>]*)>.*","%1",1)+0
		local i1color = gsub(msg,".*<MapN+>%s+%w+.*i1f<([^>]*)>.*","%1",1)+0
		local i2color = gsub(msg,".*<MapN+>%s+%w+.*i2f<([^>]*)>.*","%1",1)+0
		local checknote = MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos)
		local id = 0
		local i = MetaMapNotes_GetZoneTableSize(MetaMapNotes_Data[continent][zone])

		if MetaMapNotes_SetNextAsMiniNote ~= 2 then
			local checknote = MetaMapNotes_CheckNearNotes(continent, zone, xPos, yPos)
			if checknote then
				MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_SLASH_NEAR,
					 MetaMapNotes_Data[continent][zone][checknote].name,
						 MetaMapNotes_ZoneNames[continent][zone]), MetaMapOptions.ShowUpdates)
				returnValue = false
			else
				if i < MetaMapNotes_NotesPerZone then
					MetaMapNotes_TempData_Id = i + 1
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id] = {}
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].name = title
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].ncol = tcolor
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf1 = info1
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in1c = i1color
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf2 = info2
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in2c = i2color
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].creator = creator
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].icon = icon
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].xPos = xPos
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].yPos = yPos
					id = MetaMapNotes_TempData_Id
					MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_SLASH,
						 MetaMapNotes_ZoneNames[continent][zone]), MetaMapOptions.ShowUpdates)
					returnValue = true
				else
					MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_SLASH,
						 MetaMapNotes_ZoneNames[continent][zone]), MetaMapOptions.ShowUpdates)
					returnValue = false
				end
			end
		end
		if MetaMapNotes_SetNextAsMiniNote ~= 0 then
			MetaMapNotes_MiniNote_Data.xPos = xPos
			MetaMapNotes_MiniNote_Data.yPos = yPos
			MetaMapNotes_MiniNote_Data.continent = continent
			MetaMapNotes_MiniNote_Data.zone = zone
			MetaMapNotes_MiniNote_Data.id = id -- only shown if the note was written...
			MetaMapNotes_MiniNote_Data.name = title
			MetaMapNotes_MiniNote_Data.inf1 = info1
			MetaMapNotes_MiniNote_Data.inf2 = info2
			MetaMapNotes_MiniNote_Data.in1c = i1color
			MetaMapNotes_MiniNote_Data.in2c = i2color
			MetaMapNotes_MiniNote_Data.color = tcolor
			MetaMapNotes_MiniNote_Data.icon = icon
			MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..icon)
			MiniNotePOI:Show()
			MetaMapNotes_SetNextAsMiniNote = 0
		end
	else
		MetaMap_StatusPrint(METAMAPNOTES_MAPNOTEHELP, true)
		returnValue = false
	end
	return returnValue
end

function MetaMapNotes_Quicktloc(msg)
	if msg == "" then
		MetaMap_StatusPrint(METAMAPNOTES_QUICKTLOC_NOARGUMENT, true)
	else
		local data = strsub(msg, 1, 5)
		msg = strsub(msg, 7)
		local i,j,x,y = string.find(data,"(%d+),(%d+)")
		local continent, zone = MetaMapNotes_GetZone()
		x = x / 100
		y = y / 100
		local checknote = MetaMapNotes_CheckNearNotes(continent, zone, x, y)
		if checknote then
			MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_NOTETONEAR,
			MetaMapNotes_Data[continent][zone][checknote].name), true)
		elseif zone == 0 then
			MetaMap_StatusPrint(METAMAPNOTES_QUICKTLOC_NOZONE, true)
		else
			local id = 0
			local icon = 0
			local name = METAMAPNOTES_THOTTBOTLOC
			if msg ~= "" and msg ~= nil then
				local icheck = strsub(msg, 1, 2)
				if strlen(icheck) == 1 then
					icheck = icheck.." "
				end
				if icheck == "0 " or icheck == "1 " or icheck == "2 " or icheck == "3 " or
					icheck == "4 " or icheck == "5 " or icheck == "6 " or icheck == "7 " or
					icheck == "8 " or icheck == "9 " then
					icon = strsub(msg, 1, 1)+0
					msg = strsub(msg, 3)
				end
				if msg ~= "" and msg ~= nil then
					name = strsub(msg, 1, 80)
				end
			end
			if MetaMapNotes_SetNextAsMiniNote ~= 2 then
				local i = MetaMapNotes_GetZoneTableSize(MetaMapNotes_Data[continent][zone])
				if i < MetaMapNotes_NotesPerZone then
					MetaMapNotes_TempData_Id = i + 1
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id] = {}
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].name = name
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].ncol = 0
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf1 = ""
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in1c = 0
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].inf2 = ""
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].in2c = 0
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].creator = UnitName("player")
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].icon = icon
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].xPos = x
					MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].yPos = y
					id = MetaMapNotes_TempData_Id
					MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_OK, MetaMapNotes_ZoneNames[continent][zone]),true)
				else
					MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_TOOMANY, MetaMapNotes_ZoneNames[continent][zone]), true)
				end
			end
			if MetaMapNotes_SetNextAsMiniNote ~= 0 then
				MetaMapNotes_MiniNote_Data.xPos = x
				MetaMapNotes_MiniNote_Data.yPos = y
				MetaMapNotes_MiniNote_Data.continent = continent
				MetaMapNotes_MiniNote_Data.zone = zone
				MetaMapNotes_MiniNote_Data.id = id -- only shown if the note was written...
				MetaMapNotes_MiniNote_Data.name = name
				MetaMapNotes_MiniNote_Data.inf1 = ""
				MetaMapNotes_MiniNote_Data.inf2 = ""
				MetaMapNotes_MiniNote_Data.in1c = 1
				MetaMapNotes_MiniNote_Data.in2c = 1
				MetaMapNotes_MiniNote_Data.color = 0
				MetaMapNotes_MiniNote_Data.icon = icon
				MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..icon)
				MiniNotePOI:Show()
				MetaMapNotes_SetNextAsMiniNote = 0
			end
		end
	end
end

function MetaMapNotes_Quicknote(msg)
	SetMapToCurrentZone()
	local currentZone
	local zone
	local continent = GetCurrentMapContinent()
	if continent == -1 then
		if not MetaMapNotes_Data[GetRealZoneText()] then
			MetaMapNotes_Data[GetRealZoneText()] = {}
		end
		currentZone = MetaMapNotes_Data[GetRealZoneText()]
		zone = 0
	else
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
		if not MetaMapNotes_Data[continent][zone] then
			MetaMapNotes_Data[continent][zone] = {}
		end
			currentZone = MetaMapNotes_Data[continent][zone]
	end

	local x, y = GetPlayerMapPosition("player")
	local checknote = MetaMapNotes_CheckNearNotes(continent, zone, x, y)

	if checknote then
		MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_NOTETONEAR,
			 MetaMapNotes_Data[continent][zone][checknote].name), true)
	elseif (x == 0 and y == 0) or continent == 0 then
		MetaMap_StatusPrint(METAMAPNOTES_QUICKNOTE_NOPOSITION, true)
	else
		local id = 0
		local icon = 0
		local name = METAMAPNOTES_QUICKNOTE_DEFAULTNAME
		if msg ~= "" and msg ~= nil then
			local icheck = strsub(msg, 1, 2)
			if icheck == "0 " or icheck == "1 " or icheck == "2 " or icheck == "3 " or
				icheck == "4 " or icheck == "5 " or icheck == "6 " or icheck == "7 " or
				icheck == "8 " or icheck == "9 " then
				icon = strsub(msg, 1, 1)+0
				msg = strsub(msg, 3)
			end

			if msg ~= "" and msg ~= nil then
				name = strsub(msg, 1, 80)
			end
		end

		if MetaMapNotes_SetNextAsMiniNote ~= 2 then
			local i = MetaMapNotes_GetZoneTableSize(currentZone)
			if i < MetaMapNotes_NotesPerZone then
				MetaMapNotes_TempData_Id = i + 1
				currentZone[MetaMapNotes_TempData_Id] = {}
				currentZone[MetaMapNotes_TempData_Id].name = name
				currentZone[MetaMapNotes_TempData_Id].ncol = 0
				currentZone[MetaMapNotes_TempData_Id].inf1 = ""
				currentZone[MetaMapNotes_TempData_Id].in1c = 0
				currentZone[MetaMapNotes_TempData_Id].inf2 = ""
				currentZone[MetaMapNotes_TempData_Id].in2c = 0
				currentZone[MetaMapNotes_TempData_Id].creator = UnitName("player")
				currentZone[MetaMapNotes_TempData_Id].icon = icon
				currentZone[MetaMapNotes_TempData_Id].xPos = x
				currentZone[MetaMapNotes_TempData_Id].yPos = y
				id = MetaMapNotes_TempData_Id
				MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_OK, GetRealZoneText()), true)
			else
				MetaMap_StatusPrint(format(METAMAPNOTES_QUICKNOTE_TOOMANY, GetRealZoneText()), true)
			end
		end
		if MetaMapNotes_SetNextAsMiniNote ~= 0 then
			MetaMapNotes_MiniNote_Data.xPos = x
			MetaMapNotes_MiniNote_Data.yPos = y
			MetaMapNotes_MiniNote_Data.continent = continent
			MetaMapNotes_MiniNote_Data.zone = zone
			MetaMapNotes_MiniNote_Data.id = id -- only shown if the note was written...
			MetaMapNotes_MiniNote_Data.name = name
			MetaMapNotes_MiniNote_Data.inf1 = ""
			MetaMapNotes_MiniNote_Data.inf2 = ""
			MetaMapNotes_MiniNote_Data.in1c = 1
			MetaMapNotes_MiniNote_Data.in2c = 1
			MetaMapNotes_MiniNote_Data.color = 0
			MetaMapNotes_MiniNote_Data.icon = icon
			MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..icon)
			MiniNotePOI:Show()
			MetaMapNotes_SetNextAsMiniNote = 0
		end
	end
end

function MetaMapNotes_Misc_OnClick(button)
	if not MetaMapNotes_FramesHidden() then
		return
	end

	local x, y = this:GetCenter()
	x = x / WorldMapButton:GetEffectiveScale()
	y = y / WorldMapButton:GetEffectiveScale()
	local centerX, centerY = WorldMapButton:GetCenter()
	local width = WorldMapButton:GetWidth()
	local height = WorldMapButton:GetHeight()
	local ay = (centerY + (height/2) - y) / height
	local ax = (x - (centerX - (width/2))) / width
	local shiftedZone = MetaMapNotes_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()]
	local xOffset,yOffset = 0

	if button == "LeftButton" then
		if ax*1002 >= (1002 - 195) then
			xOffset = ax * width - 176
		else
			xOffset = ax * width
		end
		if ay*668 <= (668 - 156) then
			yOffset = -(ay * height) - 75
		else
			yOffset = -(ay * height) + 113
		end
		if this:GetID() == 0 then
			MetaMapNotes_TempData_Id = 0
		elseif this:GetID() == 1 then
			MetaMapNotes_TempData_Id = -1
		end
			MetaMapNotes_OpenEditForExistingNote(id);
	end
end

function MetaMapNotes_NextMiniNote(msg)
	msg = string.lower(msg)
	if msg == "on" then
		MetaMapNotes_SetNextAsMiniNote = 1
	elseif msg == "off" then
		MetaMapNotes_SetNextAsMiniNote = 0
	elseif MetaMapNotes_SetNextAsMiniNote == 1 then
		MetaMapNotes_SetNextAsMiniNote = 0
	else
		MetaMapNotes_SetNextAsMiniNote = 1
	end
end

function MetaMapNotes_NextMiniNoteOnly(msg)
	msg = string.lower(msg)
	if msg == "on" then
		MetaMapNotes_SetNextAsMiniNote = 2
	elseif msg == "off" then
		MetaMapNotes_SetNextAsMiniNote = 0
	elseif MetaMapNotes_SetNextAsMiniNote == 2 then
		MetaMapNotes_SetNextAsMiniNote = 0
	else
		MetaMapNotes_SetNextAsMiniNote = 2
	end
end

function MetaMapNotes_OneNote(msg)
	msg = string.lower(msg)
	if msg == "on" then
		MetaMapNotes_AllowOneNote = 1
	elseif msg == "off" then
		MetaMapNotes_AllowOneNote = 0
	elseif MetaMapNotes_AllowOneNote == 1 then
		MetaMapNotes_AllowOneNote = 0
	else
		MetaMapNotes_AllowOneNote = 1
	end
end

function MetaMapNotes_OnEvent(event)
	if event == "MINIMAP_UPDATE_ZOOM" then
		MetaMapNotes_MinimapUpdateZoom();
	elseif event == "VARIABLES_LOADED" then
		MetaMapNotes_VariablesLoaded();
	elseif event == "WORLD_MAP_UPDATE" then
		MetaMapNotes_WorldMapButton_OnUpdate();
	elseif event == "ZONE_CHANGED_NEW_AREA" then
		MetaMapNotes_MiniNote_OnUpdate(0);
	end
end

function MetaMapNotes_MinimapUpdateZoom()
	if MetaMapNotes_MiniNote_MapzoomInit then
		if MetaMapNotes_MiniNote_IsInCity then
			MetaMapNotes_MiniNote_IsInCity = false
		else
			MetaMapNotes_MiniNote_IsInCity = true
		end
	else
		local tempzoom = 0
		if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
			if GetCVar("minimapInsideZoom")+0 >= 3 then
				Minimap:SetZoom(Minimap:GetZoom() - 1)
				tempzoom = 1
			else
				Minimap:SetZoom(Minimap:GetZoom() + 1)
				tempzoom = -1
			end
		end

		if GetCVar("minimapInsideZoom")+0 == Minimap:GetZoom() then
			MetaMapNotes_MiniNote_IsInCity = true
		else
			MetaMapNotes_MiniNote_IsInCity = false
		end

		Minimap:SetZoom(Minimap:GetZoom() + tempzoom)
		MetaMapNotes_MiniNote_MapzoomInit = true
	end
end

function MetaMapNotes_ChatFrame_OnEvent(...)
	local event = unpack(arg)
	if strsub(event, 1, 16) == "CHAT_MSG_WHISPER" and strsub(arg1, 1, 6) == "<MapN>" then
		if strsub(event, 17) == "_INFORM" then
			-- do nothing
		else
			MetaMapNotes_GetNoteFromChat(arg1, arg2)
		end
	else
		orig_ChatFrame_OnEvent(unpack(arg))
	end
end

function MetaMapNotes_MiniNote_OnUpdate(delay)
	if MetaMapNotes_MiniNote_Data.xPos ~= nil then
		MiniNotePOI.TimeSinceLastUpdate = MiniNotePOI.TimeSinceLastUpdate + delay
		if MiniNotePOI.TimeSinceLastUpdate > MetaMapNotes_Mininote_UpdateRate then
			local zoneText
			local continent, zone = MetaMapNotes_GetZone()
			local x, y = GetPlayerMapPosition("player")
			if (MetaMapNotes_MiniNote_Data.continent > 0 and zone ~= MetaMapNotes_MiniNote_Data.zone) then
				MiniNotePOI:Hide()
				return
			end
			if zone ~= GetCurrentMapZone() or continent ~= GetCurrentMapContinent() then
				if(WorldMapFrame:IsVisible()) then
					return;
				else
					SetMapToCurrentZone();
				end
			end
			if continent < 1 then
				zoneText = GetRealZoneText()
				zone = -1
			else
				zone = MetaMapNotes_ZoneShift[continent][zone]
			end
			if x == 0 and y == 0 then
				MiniNotePOI:Hide()
				return
			end

			local currentConst
			if continent == 0 then
				currentConst = MetaMapNotes_Const[zoneText]
			elseif continent > 0 and MetaMapNotes_MiniNote_Data.continent > 0 then
				local c = MetaMapNotes_MiniNote_Data.continent
				local z = MetaMapNotes_MiniNote_Data.zone
				local zs = MetaMapNotes_ZoneShift[c][z]
				currentConst = MetaMapNotes_Const[c][zs]
			else
				MiniNotePOI:Hide()
				return
			end

			local currentZoom = Minimap:GetZoom()

			if currentConst and x ~= 0 and y ~= 0 and currentConst.scale ~= 0 then
				local xscale,yscale
				if zone > 0 then
					xscale = MetaMapNotes_Const[MetaMapNotes_MiniNote_Data.continent][currentZoom].xscale
					yscale = MetaMapNotes_Const[MetaMapNotes_MiniNote_Data.continent][currentZoom].yscale
				else
					xscale = MetaMapNotes_Const[2][currentZoom].xscale
					yscale = MetaMapNotes_Const[2][currentZoom].yscale
				end

				if MetaMapNotes_MiniNote_IsInCity then
					xscale = xscale * MetaMapNotes_Const[2][currentZoom].cityscale
					yscale = yscale * MetaMapNotes_Const[2][currentZoom].cityscale
				end
				local xpos = MetaMapNotes_MiniNote_Data.xPos * currentConst.scale + currentConst.xoffset
				local ypos = MetaMapNotes_MiniNote_Data.yPos * currentConst.scale + currentConst.yoffset
				x = x * currentConst.scale + currentConst.xoffset
				y = y * currentConst.scale + currentConst.yoffset
				local deltax = (xpos - x) * xscale
				local deltay = (ypos - y) * yscale
				if sqrt( (deltax * deltax) + (deltay * deltay) ) > 56.5 then
					local adjust = 1
					if deltax == 0 then
						deltax = deltax + 0.0000000001
					elseif deltax < 0 then
						adjust = -1
					end
					local m = math.atan(deltay / deltax)
					deltax = math.cos(m) * 57 * adjust
					deltay = math.sin(m) * 57 * adjust
				end

				MiniNotePOI:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 105 + deltax, -93 - deltay)
				MiniNotePOI:Show()
			else
				MiniNotePOI:Hide()
			end
		end
		MiniNotePOI.TimeSinceLastUpdate = 0
	else
	MiniNotePOI:Hide()
	end
end

function MetaMapNotes_MiniNote_OnClick(arg1)
	local continent = GetCurrentMapContinent();
	local zone = GetCurrentMapZone();

	SetMapToCurrentZone();
	if(not WorldMapFrame:IsVisible()) then
		MetaMapNotesEditFrame:SetParent("UIParent");
	end
	MetaMapNotes_OpenEditForExistingNote(MetaMapNotes_MiniNote_Data.id);
	SetMapZoom(continent, zone);
end

function MetaMapNotes_ShowNewFrame(ax, ay)
	if MetaMapNotes_FramesHidden() then
		local width = WorldMapButton:GetWidth();
		local height = WorldMapButton:GetHeight();
		local xOffset,yOffset;
		MetaMapNotes_TempData_xPos = ax;
		MetaMapNotes_TempData_yPos = ay;
		MetaMapNotes_TempData_Id = nil;

		if ax*1002 >= (1002 - 195) then
			xOffset = ax * width - 176;
		else
			xOffset = ax * width;
		end
		if ay*668 <= (668 - 156) then
			yOffset = -(ay * height) - 75;
		else
			yOffset = -(ay * height) + 87;
		end

		MetaMapNotesButtonMiniNoteOff:Disable();
		MetaMapNotesButtonMiniNoteOn:Disable();
		MetaMapNotesButtonDeleteNote:Disable();
		MetaMapNotesButtonToggleLine:Disable();
		MetaMapNotesButtonSendNote:Disable();
		if MetaMapNotes_NewNoteSlot() >= MetaMapNotes_NotesPerZone + 1 then
			return;
		end
		MetaMapNotesEditFrameTitle:SetText(METAMAPNOTES_NEW_NOTE);
		MetaMapNotes_OpenEditForNewNote();
	end
end

function MetaMapNotes_OpenEditForNewNote()
	if MetaMapNotes_NewNoteSlot() < MetaMapNotes_NotesPerZone + 1 then
		if MetaMapNotes_TempData_Id == 0 then
			MetaMapNotes_tloc_xPos = nil
			MetaMapNotes_tloc_yPos = nil
		end
		MetaMapNotes_TempData_Id = MetaMapNotes_NewNoteSlot()
		MetaMapNotes_TempData_Creator = UnitName("player")
		MetaMapNotes_Edit_SetIcon(0)
		MetaMapNotes_Edit_SetTextColor(0)
		MetaMapNotes_Edit_SetInfo1Color(0)
		MetaMapNotes_Edit_SetInfo2Color(0)
		TitleWideEditBox:SetText("")
		Info1WideEditBox:SetText("")
		Info2WideEditBox:SetText("")
		CreatorWideEditBox:SetText(MetaMapNotes_TempData_Creator)
		MetaMapNotes_HideAll()
		MetaMapNotesEditFrame:Show()
	else
		MetaMapNotes_HideAll()
	end
end

function MetaMapNotes_OpenEditForExistingNote(id)
	if MetaMapNotes_NewNoteSlot() >= MetaMapNotes_NotesPerZone + 1 then
		return;
	end
	MetaMapNotesEditFrameTitle:SetText(METAMAPNOTES_EDIT_NOTE);
	if(MetaMapNotes_MiniNote_Data.xPos == nil) then
		MetaMapNotesButtonMiniNoteOff:Disable();
	else
		MetaMapNotesButtonMiniNoteOff:Enable();
	end
	MetaMapNotesButtonMiniNoteOn:Enable();
	MetaMapNotesButtonDeleteNote:Enable();
	MetaMapNotesButtonToggleLine:Enable();
	MetaMapNotes_HideAll();

	local currentZone
	local continent = GetCurrentMapContinent()

	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()]
	else
		local zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
		currentZone = MetaMapNotes_Data[continent][zone]
	end
	if(MetaMapFrame:IsVisible()) then
		currentZone = MetaMapNotes_Data[0][MetaMapOptions.MetaMapZone];
		frame = "MetaMapFrame";
	end

	if(id == nil) then
		WorldMapTooltip:Hide();
		MetaMapNotes_ShowNewFrame(MetaMapNotes_tloc_xPos, MetaMapNotes_tloc_yPos);
		return;
	end

	MetaMapNotes_TempData_Id = id
	MetaMapNotes_TempData_Creator = currentZone[MetaMapNotes_TempData_Id].creator
	MetaMapNotes_TempData_xPos = currentZone[MetaMapNotes_TempData_Id].xPos
	MetaMapNotes_TempData_yPos = currentZone[MetaMapNotes_TempData_Id].yPos
	MetaMapNotes_Edit_SetIcon(currentZone[MetaMapNotes_TempData_Id].icon)
	MetaMapNotes_Edit_SetTextColor(currentZone[MetaMapNotes_TempData_Id].ncol)
	MetaMapNotes_Edit_SetInfo1Color(currentZone[MetaMapNotes_TempData_Id].in1c)
	MetaMapNotes_Edit_SetInfo2Color(currentZone[MetaMapNotes_TempData_Id].in2c)
	TitleWideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].name)
	Info1WideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].inf1)
	Info2WideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].inf2)
	CreatorWideEditBox:SetText(currentZone[MetaMapNotes_TempData_Id].creator)
	MetaMapNotesEditFrame:Show()
end

function MetaMapNotes_ShowSendFrame(number)
	if number == 1 then
		MetaMapNotesSendPlayer:Enable()
		if Sky then
			MetaMapNotesSendParty:Enable()
		else
			MetaMapNotesSendParty:Disable()
		end
		MetaMapNotesChangeSendFrame:SetText(METAMAPNOTES_SLASHCOMMAND)
		SendWideEditBox:SetText("")
		if UnitCanCooperate("player", "target") then
			SendWideEditBox:SetText(UnitName("target"))
		end
			MetaMapNotes_SendFrame_Title:SetText(METAMAPNOTES_SEND_TITLE)
			MetaMapNotes_SendFrame_Tip:SetText(METAMAPNOTES_SEND_TIP)
			MetaMapNotes_SendFrame_Player:SetText(METAMAPNOTES_SEND_PLAYER)
			MetaMapNotes_ToggleSendValue = 2
	elseif number == 2 then
		MetaMapNotesSendPlayer:Disable()
		MetaMapNotesSendParty:Disable()
		MetaMapNotesChangeSendFrame:SetText(METAMAPNOTES_SHOWSEND)
		SendWideEditBox:SetText("/mapnote"..MetaMapNotes_GenerateSendString(2))
		MetaMapNotes_SendFrame_Title:SetText(METAMAPNOTES_SEND_SLASHTITLE)
		MetaMapNotes_SendFrame_Tip:SetText(METAMAPNOTES_SEND_SLASHTIP)
		MetaMapNotes_SendFrame_Player:SetText(METAMAPNOTES_SEND_SLASHCOMMAND)
		MetaMapNotes_ToggleSendValue = 1
	end
	if not MetaMapNotesSendFrame:IsVisible() then
		MetaMapNotes_HideAll()
		MetaMapNotesSendFrame:Show()
	end
end

function MetaMapNotes_Edit_SetIcon(icon)
	MetaMapNotes_TempData_Icon = icon
	IconOverlay:SetPoint("TOPLEFT", "EditIcon"..icon, "TOPLEFT", -3, 3)
end

function MetaMapNotes_Edit_SetTextColor(color)
	MetaMapNotes_TempData_TextColor = color
	TextColorOverlay:SetPoint("TOPLEFT", "TextColor"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_Edit_SetInfo1Color(color)
	MetaMapNotes_TempData_Info1Color = color
	Info1ColorOverlay:SetPoint("TOPLEFT", "Info1Color"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_Edit_SetInfo2Color(color)
	MetaMapNotes_TempData_Info2Color = color
	Info2ColorOverlay:SetPoint("TOPLEFT", "Info2Color"..color, "TOPLEFT", -3, 3)
end

function MetaMapNotes_GenerateSendString(version)
-- <MapN> c<1> z<1> x<0.123123> y<0.123123> t<> i1<> i2<> cr<> i<8> tf<3> i1f<5> i2f<6>
	local text = ""
	if version == 1 then
		text = "<MapN>"
	end

	local currentZone;
	local continent = GetCurrentMapContinent();
	local zone;
	local mapName
	local pName = UnitName("player");
	
	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()];
		zone = -1;
	else
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		currentZone = MetaMapNotes_Data[continent][zone];
		mapName = MetaMapNotes_ZoneNames[continent][zone];
	end

	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
		mapName = MetaMap_Data[zone]["ZoneName"];
	end

	if not currentZone then
		return
	end

	MetaMapNotes_NoteSent = format(METAMAPNOTES_ACCEPT_GET, pName, mapName);
	text = text.." c<"..continent.."> z<"..zone..">"
	local xPos = floor(currentZone[MetaMapNotes_TempData_Id].xPos * 1000000)/1000000 --cut to six digits behind the 0
	local yPos = floor(currentZone[MetaMapNotes_TempData_Id].yPos * 1000000)/1000000
	text = text.." x<"..xPos.."> y<"..yPos..">"
	text = text.." t<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].name)..">"
	text = text.." i1<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].inf1)..">"
	text = text.." i2<"..MetaMapNotes_EliminateUsedChars(currentZone[MetaMapNotes_TempData_Id].inf2)..">"
	if not currentZone[MetaMapNotes_TempData_Id].creator then
		currentZone[MetaMapNotes_TempData_Id].creator = UnitName("player")
	end
	text = text.." cr<"..currentZone[MetaMapNotes_TempData_Id].creator..">"
	text = text.." i<"..currentZone[MetaMapNotes_TempData_Id].icon..">"
	text = text.." tf<"..currentZone[MetaMapNotes_TempData_Id].ncol..">"
	text = text.." i1f<"..currentZone[MetaMapNotes_TempData_Id].in1c..">"
	text = text.." i2f<"..currentZone[MetaMapNotes_TempData_Id].in2c..">"

	if continent == -1 and currentZone[MetaMapNotes_TempData_Id].zname then
		text = text.." zn<"..currentZone[MetaMapNotes_TempData_Id].zname..">"
	end

	return text
end

function MetaMapNotes_EliminateUsedChars(text)
	text = string.gsub(text, "<", "")
	text = string.gsub(text, ">", "")
	return text
end

function MetaMapNotes_SendNote(type)
	if Sky then
		if type == 1 then
			if Sky.isSkyUser(SendWideEditBox:GetText()) then
				Sky.sendAlert(MetaMapNotes_GenerateSendString(1), SKY_PLAYER, "MN", SendWideEditBox:GetText())
			else
				SendChatMessage(MetaMapNotes_GenerateSendString(1), "WHISPER", this.language, SendWideEditBox:GetText())
				SendChatMessage(MetaMapNotes_NoteSent, "WHISPER", this.language, SendWideEditBox:GetText())
			end
			MetaMapNotes_HideAll()
		elseif type == 2 then
			Sky.sendAlert(MetaMapNotes_GenerateSendString(1), SKY_PARTY, "MN")
			MetaMapNotes_HideAll()
		end
	else
		if type == 1 then
			SendChatMessage(MetaMapNotes_GenerateSendString(1), "WHISPER", this.language, SendWideEditBox:GetText())
			SendChatMessage(MetaMapNotes_NoteSent, "WHISPER", this.language, SendWideEditBox:GetText())
			MetaMapNotes_HideAll()
		else
			MetaMapNotes_HideAll()
		end
	end
end

function MetaMapNotes_OpenOptionsFrame()
	MetaMapNotesEditFrame:Hide()
	MetaMapNotesSendFrame:Hide()
	MetaMapNotes_ClearGUI()
	for i=0, 16, 1 do
		if MetaMapNotes_Options[i] ~= "off" then
			getglobal("MetaMapNotesOptionsCheckbox"..i):SetChecked(1);
		else
			getglobal("MetaMapNotesOptionsCheckbox"..i):SetChecked(0);
		end
	end
end

function MetaMapNotes_WriteOptions()
	for i=0, 16, 1 do
		if getglobal("MetaMapNotesOptionsCheckbox"..i):GetChecked() then
			MetaMapNotes_Options[i] = nil;
		else
			MetaMapNotes_Options[i] = "off";
		end
	end
	MetaMapNotes_MapUpdate();
	MetaMapNotesOptionsFrame:Hide();
end

function MetaMapNotes_SetAsMiniNote(id)
	local currentZone
	local continent = GetCurrentMapContinent()
	local zone

	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()]
		zone = -1
	else
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
		currentZone = MetaMapNotes_Data[continent][zone]
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end

	if not currentZone then
		return
	end

	MetaMapNotes_MiniNote_Data.continent = continent;
	MetaMapNotes_MiniNote_Data.zone = zone;
	if(MetaMapFrame:IsVisible()) then
		MetaMapNotes_MiniNote_Data.zonetext = MetaMap_Data[zone]["ZoneName"];
	else
		MetaMapNotes_MiniNote_Data.zonetext = GetRealZoneText();
	end

	MetaMapNotes_MiniNote_Data.id = id -- able to show, because there wasn't a delete and its not received for showing on Minimap only
	if id == 0 then
		MetaMapNotes_MiniNote_Data.xPos = MetaMapNotes_tloc_xPos
		MetaMapNotes_MiniNote_Data.yPos = MetaMapNotes_tloc_yPos
		MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_THOTTBOTLOC
		MetaMapNotes_MiniNote_Data.inf1 = ""
		MetaMapNotes_MiniNote_Data.inf2 = ""
		MetaMapNotes_MiniNote_Data.in1c = 1
		MetaMapNotes_MiniNote_Data.in2c = 1
		MetaMapNotes_MiniNote_Data.color = 0
		MetaMapNotes_MiniNote_Data.icon = "tloc"
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
		MiniNotePOI:Show()
	elseif id == -1 then
		MetaMapNotes_MiniNote_Data.xPos = MetaMapNotes_PartyNoteData.xPos
		MetaMapNotes_MiniNote_Data.yPos = MetaMapNotes_PartyNoteData.yPos
		MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_PARTYNOTE
		MetaMapNotes_MiniNote_Data.inf1 = ""
		MetaMapNotes_MiniNote_Data.inf2 = ""
		MetaMapNotes_MiniNote_Data.in1c = 1
		MetaMapNotes_MiniNote_Data.in2c = 1
		MetaMapNotes_MiniNote_Data.color = 0
		MetaMapNotes_MiniNote_Data.icon = "party"
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
		MiniNotePOI:Show()
	else
		MetaMapNotes_MiniNote_Data.xPos = currentZone[id].xPos
		MetaMapNotes_MiniNote_Data.yPos = currentZone[id].yPos
		MetaMapNotes_MiniNote_Data.name = currentZone[id].name
		MetaMapNotes_MiniNote_Data.inf1 = currentZone[id].inf1
		MetaMapNotes_MiniNote_Data.inf2 = currentZone[id].inf2
		MetaMapNotes_MiniNote_Data.in1c = currentZone[id].in1c
		MetaMapNotes_MiniNote_Data.in2c = currentZone[id].in2c
		MetaMapNotes_MiniNote_Data.color = currentZone[id].ncol
		MetaMapNotes_MiniNote_Data.icon = currentZone[id].icon
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
		MiniNotePOI:Show()
	end
	MetaMapNotesButtonMiniNoteOff:Enable();
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_ClearMiniNote(skipMapUpdate)
	MetaMapNotes_MiniNote_Data = {};
	MiniNotePOI:Hide();
	MetaMapNotesButtonMiniNoteOff:Disable();

	if not skipMapUpdate then
		MetaMapNotes_MapUpdate();
	end
end

function MetaMapNotes_WriteNote()
	MetaMapNotes_HideAll();

	local currentZone;
	local continent = GetCurrentMapContinent();
	local zone;

	if continent == -1 then
		zone = GetRealZoneText();
		if not MetaMapNotes_Data[zone] then
			MetaMapNotes_Data[zone] = {};
		end
		currentZone = MetaMapNotes_Data[zone];
		zone = -1
	else
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end

	currentZone[MetaMapNotes_TempData_Id] = {};
	currentZone[MetaMapNotes_TempData_Id].name = TitleWideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].ncol = MetaMapNotes_TempData_TextColor;
	currentZone[MetaMapNotes_TempData_Id].inf1 = Info1WideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].in1c = MetaMapNotes_TempData_Info1Color;
	currentZone[MetaMapNotes_TempData_Id].inf2 = Info2WideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].in2c = MetaMapNotes_TempData_Info2Color;
	currentZone[MetaMapNotes_TempData_Id].creator = CreatorWideEditBox:GetText();
	currentZone[MetaMapNotes_TempData_Id].icon = MetaMapNotes_TempData_Icon;
	currentZone[MetaMapNotes_TempData_Id].xPos = MetaMapNotes_TempData_xPos;
	currentZone[MetaMapNotes_TempData_Id].yPos = MetaMapNotes_TempData_yPos;

	if(continent == -1) then
		currentZone[MetaMapNotes_TempData_Id].zname = GetRealZoneText();
	end

	if(continent == MetaMapNotes_MiniNote_Data.continent and MetaMapNotes_MiniNote_Data.zone == zone and MetaMapNotes_MiniNote_Data.id == MetaMapNotes_TempData_Id) then
		MetaMapNotes_MiniNote_Data.name = TitleWideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.icon = MetaMapNotes_TempData_Icon;
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon);
		MetaMapNotes_MiniNote_Data.inf1 = Info1WideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.inf2 = Info2WideEditBox:GetText();
		MetaMapNotes_MiniNote_Data.in1c = MetaMapNotes_TempData_Info1Color;
		MetaMapNotes_MiniNote_Data.in2c = MetaMapNotes_TempData_Info2Color;
		MetaMapNotes_MiniNote_Data.color = MetaMapNotes_TempData_TextColor;
	end
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_MapUpdate()
	if(WorldMapButton:IsVisible() or MetaMapFrame:IsVisible()) then
		MetaMapNotes_WorldMapButton_OnUpdate();
	end
	if(Minimap:IsVisible()) then
		Minimap_OnUpdate(0);
	end
end

function MetaMapNotes_HideAll()
	MetaMapNotesEditFrame:Hide()
	MetaMapNotesOptionsFrame:Hide()
	MetaMapNotesSendFrame:Hide()
	MetaMapNotes_ClearGUI()
end

function MetaMapNotes_HideMenus()
	MetaMapNotes_ClearGUI()
end

function MetaMapNotes_HideFrames()
	MetaMapNotesEditFrame:Hide()
	MetaMapNotesOptionsFrame:Hide()
	MetaMapNotesSendFrame:Hide()
	MetaMapNotes_ClearGUI()
end

function MetaMapNotes_FramesHidden()
	if MetaMapNotesEditFrame:IsVisible() or
		MetaMapNotesSendFrame:IsVisible() or
		MetaMapNotesOptionsFrame:IsVisible() then
		return false
	else
		return true
	end
end

function MetaMapNotes_DeleteNote(id, continent, zone)
	MetaMapNotes_HideAll()
	if id == 0 then
		MetaMapNotes_tloc_xPos = nil;
		MetaMapNotes_tloc_yPox = nil;
		MetaMapNotes_MapUpdate();
		return;
	elseif id == -1 then
		MetaMapNotes_PartyNoteData.xPos = nil;
		MetaMapNotes_PartyNoteData.yPos = nil;
		MetaMapNotes_PartyNoteData.continent = nil;
		MetaMapNotes_PartyNoteData.zone = nil;
		MetaMapNotes_MapUpdate();
		return;
	end

	local currentZone;
	local lastEntry;

	if continent == nil or zone == nil then
		continent = GetCurrentMapContinent();
		if continent == -1 then
			currentZone = MetaMapNotes_Data[GetRealZoneText()];
			zone = 0;
		else
			zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
			currentZone = MetaMapNotes_Data[continent][zone]
		end
	else
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end

	lastEntry = MetaMapNotes_GetZoneTableSize(currentZone);

	if continent ~= -1 then
		MetaMapNotes_DeleteLines(continent, zone, MetaMapNotes_Data[continent][zone][id].xPos,MetaMapNotes_Data[continent][zone][id].yPos);
	end
	if lastEntry ~= 0 and id <= lastEntry then
		currentZone[id].name = currentZone[lastEntry].name;
		currentZone[lastEntry].name = nil;
		currentZone[id].ncol = currentZone[lastEntry].ncol;
		currentZone[lastEntry].ncol = nil;
		currentZone[id].inf1 = currentZone[lastEntry].inf1;
		currentZone[lastEntry].inf1 = nil;
		currentZone[id].in1c = currentZone[lastEntry].in1c;
		currentZone[lastEntry].in1c = nil;
		currentZone[id].inf2 = currentZone[lastEntry].inf2;
		currentZone[lastEntry].inf2 = nil;
		currentZone[id].in2c = currentZone[lastEntry].in2c;
		currentZone[lastEntry].in2c = nil;
		currentZone[id].creator = currentZone[lastEntry].creator;
		currentZone[lastEntry].creator = nil;
		currentZone[id].icon = currentZone[lastEntry].icon;
		currentZone[lastEntry].icon = nil;
		currentZone[id].xPos = currentZone[lastEntry].xPos;
		currentZone[lastEntry].xPos = nil;
		currentZone[id].yPos = currentZone[lastEntry].yPos;
		currentZone[lastEntry].yPos = nil;
		currentZone[lastEntry] = nil;
	end

	if continent == MetaMapNotes_MiniNote_Data.continent and zone == MetaMapNotes_MiniNote_Data.zone then
		if MetaMapNotes_MiniNote_Data.id > id then
			MetaMapNotes_MiniNote_Data.id = MetaMapNotes_MiniNote_Data.id - 1;
		elseif MetaMapNotes_MiniNote_Data.id == id then
			MetaMapNotes_ClearMiniNote(true);
		end
	end
	MetaMapNotes_MapUpdate();
end

function MetaMapNotes_GetZoneTableSize(zoneTable)
	local i = 0;
	for id in zoneTable do
		i = i + 1;
	end
	return i;
end

function MetaMapNotes_DeleteNotesByCreatorAndName(creator, name)
	assert(creator ~= nil, "ERROR: nil creator passed to DeleteNotesByCreatorAndName!")

	for continent, continentTable in MetaMapNotes_Data do
		for zone, zoneTable in continentTable do
			for id=MetaMapNotes_GetZoneTableSize(zoneTable), 1, -1 do
				if creator == zoneTable[id].creator and (name == zoneTable[id].name or name == nil) then
					MetaMapNotes_DeleteNote(id, continent, zone)
				end
			end
		end
	end

	if name ~= nil then
		MetaMap_StatusPrint(format(TEXT(METAMAPNOTES_DELETED_BY_NAME), creator, name), true)
	else
		MetaMap_StatusPrint(format(TEXT(METAMAPNOTES_DELETED_BY_CREATOR), creator), true)
	end
end

function MetaMapNotes_OnEnter(id)
	if MetaMapNotes_FramesHidden() then
		local x, y = this:GetCenter()
		local x2, y2 = WorldMapButton:GetCenter()
		local anchor = ""
		if x > x2 then
			anchor = "ANCHOR_LEFT"
		else
			anchor = "ANCHOR_RIGHT"
		end

		local currentZone
		local continent = GetCurrentMapContinent()

		if continent == -1 then
			currentZone = MetaMapNotes_Data[GetRealZoneText()]
		elseif continent > 0 then
			local zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
			currentZone = MetaMapNotes_Data[continent][zone]
		end
		if(MetaMapFrame:IsVisible()) then
			currentZone = MetaMapNotes_Data[0][MetaMapOptions.MetaMapZone];
		end

		if not currentZone then
			return
		end

		local cNr = currentZone[id].ncol
		WorldMapTooltip:SetOwner(this, anchor)
		WorldMapTooltip:SetText(currentZone[id].name, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
		if currentZone[id].inf1 ~= nil and currentZone[id].inf1 ~= "" then
			cNr = currentZone[id].in1c
			WorldMapTooltip:AddLine(currentZone[id].inf1, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
		end
		if currentZone[id].inf2 ~= nil and currentZone[id].inf2 ~= "" then
			cNr = currentZone[id].in2c
			WorldMapTooltip:AddLine(currentZone[id].inf2, MetaMapNotes_Colors[cNr].r, MetaMapNotes_Colors[cNr].g, MetaMapNotes_Colors[cNr].b, MetaMapOptions.TooltipWrap)
		end
		if(currentZone[id].creator ~= nil and currentZone[id].creator ~= "" and MetaMapOptions.MetaMapShowAuthor) then
			WorldMapTooltip:AddDoubleLine(METAMAPNOTES_CREATEDBY, currentZone[id].creator, 0.79, 0.69, 0.0, 0.79, 0.69, 0.0);
		end
		WorldMapTooltip:Show()
	else
		WorldMapTooltip:Hide()
	end
end

function MetaMapNotes_OnLeave(id)
	WorldMapTooltip:Hide()
end

function MetaMapNotes_Note_OnClick(button, id)
	if(not MetaMapNotes_FramesHidden() or MetaMapNotesEditFrame:IsVisible()) then
		MetaMapNotesEditFrame:Hide()
		return;
	end

	local currentZone
	local continent = GetCurrentMapContinent()
	local zone

	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()]
		zone = -1
	else
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
		currentZone = MetaMapNotes_Data[continent][zone]
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end

	if not currentZone then
		return
	end

	if MetaMapNotes_LastLineClick.GUIactive then
		id = id + 0
		local ax = currentZone[id].xPos
		local ay = currentZone[id].yPos
		if (MetaMapNotes_LastLineClick.x ~= ax or MetaMapNotes_LastLineClick.y ~= ay) and MetaMapNotes_LastLineClick.continent == continent and MetaMapNotes_LastLineClick.zone == zone then
			MetaMapNotes_ToggleLine(continent, zone, ax, ay, MetaMapNotes_LastLineClick.x, MetaMapNotes_LastLineClick.y)
		end
			MetaMapNotes_ClearGUI()
	elseif button == "LeftButton" then
		local width = WorldMapButton:GetWidth()
		local height = WorldMapButton:GetHeight()
		id = id + 0
		MetaMapNotes_TempData_Id = id
		local ax = currentZone[id].xPos
		local ay = currentZone[id].yPos
		if ax*1002 >= (1002 - 195) then
			xOffset = ax * width - 176
		else
			xOffset = ax * width
		end
		if ay*668 <= (668 - 156) then
			yOffset = -(ay * height) - 75
		else
			yOffset = -(ay * height) + 113
		end
		MetaMapNotesButtonSendNote:Enable()
		WorldMapTooltip:Hide()
		MetaMapNotes_OpenEditForExistingNote(MetaMapNotes_TempData_Id)
	elseif button == "LeftButton" and IsAltKeyDown() then
		id = id + 0
		local ax = currentZone[id].xPos
		local ay = currentZone[zone][id].yPos
		if (MetaMapNotes_LastLineClick.x ~= ax or MetaMapNotes_LastLineClick.y ~= ay) and
			MetaMapNotes_LastLineClick.continent == continent and
			MetaMapNotes_LastLineClick.zone == zone and
			MetaMapNotes_LastLineClick.time > GetTime() - 4 then
			MetaMapNotes_ToggleLine(continent, zone, ax, ay, MetaMapNotes_LastLineClick.x, MetaMapNotes_LastLineClick.y)
		else
			MetaMapNotes_LastLineClick.x = ax
			MetaMapNotes_LastLineClick.y = ay
			MetaMapNotes_LastLineClick.continent = continent
			MetaMapNotes_LastLineClick.zone = zone
			MetaMapNotes_LastLineClick.time = GetTime()
		end
	end
end

function MetaMapNotes_StartGUIToggleLine()
	MetaMapNotes_HideAll()
	WorldMapMagnifyingGlassButton:SetText(METAMAPNOTES_WORLDMAP_HELP_1.."\n"..METAMAPNOTES_WORLDMAP_HELP_2.."\n"..METAMAPNOTES_CLICK_ON_SECOND_NOTE)
	MetaMapNotes_LastLineClick.GUIactive = true
	local zone = MetaMapNotes_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()]
	local continent = GetCurrentMapContinent()
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
	end
	MetaMapNotes_LastLineClick.x = MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].xPos
	MetaMapNotes_LastLineClick.y = MetaMapNotes_Data[continent][zone][MetaMapNotes_TempData_Id].yPos
	MetaMapNotes_LastLineClick.zone = zone
	MetaMapNotes_LastLineClick.continent = continent
end

function MetaMapNotes_ClearGUI()
	WorldMapMagnifyingGlassButton:SetText(METAMAPNOTES_WORLDMAP_HELP_1.."\n"..METAMAPNOTES_WORLDMAP_HELP_2)
	MetaMapNotes_LastLineClick.GUIactive = false
end

function MetaMapNotes_DrawLine(id, x1, y1, x2, y2)
	assert(id <= METAMAPNOTES_MAXLINES)
	assert(x1 and y1 and x2 and y2)
	local MetaMapNotesLine = getglobal("MetaMapNotesLines_"..id)
	local positiveSlopeTexture = METAMAP_IMAGE_PATH.."LineTemplatePositive256"
	local negativeSlopeTexture = METAMAP_IMAGE_PATH.."LineTemplateNegative256"
	local width = WorldMapDetailFrame:GetWidth()
	local height = WorldMapDetailFrame:GetHeight()
	local deltax = math.abs((x1 - x2) * width)
	local deltay = math.abs((y1 - y2) * height)
	local xOffset = math.min(x1,x2) * width
	local yOffset = -(math.min(y1,y2) * height)
	local lowerpixel = math.min(deltax, deltay)
	lowerpixel = lowerpixel / 256
	if lowerpixel > 1 then
		lowerpixel = 1
	end
	if deltax == 0 then
		deltax = 2
		MetaMapNotesLine:SetTexture(0, 0, 0)
		MetaMapNotesLine:SetTexCoord(0, 1, 0, 1)
	elseif deltay == 0 then
		deltay = 2
		MetaMapNotesLine:SetTexture(0, 0, 0)
		MetaMapNotesLine:SetTexCoord(0, 1, 0, 1)
	elseif x1 - x2 < 0 then
		if y1 - y2 < 0 then
			MetaMapNotesLine:SetTexture(negativeSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 0, lowerpixel)
		else
			MetaMapNotesLine:SetTexture(positiveSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 1-lowerpixel, 1)
		end
	else
		if y1 - y2 < 0 then
			MetaMapNotesLine:SetTexture(positiveSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 1-lowerpixel, 1)
		else
			MetaMapNotesLine:SetTexture(negativeSlopeTexture)
			MetaMapNotesLine:SetTexCoord(0, lowerpixel, 0, lowerpixel)
		end
	end

	if(MetaMapFrame:IsVisible()) then
		MetaMapNotesLine:SetPoint("TOPLEFT", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
	else
		MetaMapNotesLine:SetPoint("TOPLEFT", "WorldMapDetailFrame", "TOPLEFT", xOffset, yOffset)
	end
	MetaMapNotesLine:SetWidth(deltax)
	MetaMapNotesLine:SetHeight(deltay)
	MetaMapNotesLine:Show()
end

function MetaMapNotes_DeleteLines(continent, zone, x, y)
	local zoneTable = MetaMapNotes_Lines[continent][zone]
	local lineCount = MetaMapNotes_GetZoneTableSize(zoneTable)
	local offset = 0

	for i = 1, lineCount, 1 do
		if (zoneTable[i-offset].x1 == x and zoneTable[i-offset].y1 == y) or (zoneTable[i-offset].x2 == x and zoneTable[i-offset].y2 == y) then
			for j = i, lineCount-1, 1 do
				zoneTable[j-offset].x1 = zoneTable[j+1-offset].x1
				zoneTable[j-offset].x2 = zoneTable[j+1-offset].x2
				zoneTable[j-offset].y1 = zoneTable[j+1-offset].y1
				zoneTable[j-offset].y2 = zoneTable[j+1-offset].y2
			end
			zoneTable[lineCount-offset] = nil
			offset = offset + 1
		end
	end
	MetaMapNotes_LastLineClick.zone = 0
end

function MetaMapNotes_ToggleLine(continent, zone, x1, y1, x2, y2)
	local zoneTable = MetaMapNotes_Lines[continent][zone]
	local newline = true
	local lineCount = MetaMapNotes_GetZoneTableSize(zoneTable)

	for i = 1, lineCount, 1 do
		if i <= lineCount then
			if (zoneTable[i].x1 == x1 and zoneTable[i].y1 == y1 and
					zoneTable[i].x2 == x2 and zoneTable[i].y2 == y2) or
					(zoneTable[i].x1 == x2 and zoneTable[i].y1 == y2 and
					zoneTable[i].x2 == x1 and zoneTable[i].y2 == y1) then
				for j = i, lineCount-1, 1 do
					zoneTable[j].x1 = zoneTable[j+1].x1
					zoneTable[j].x2 = zoneTable[j+1].x2
					zoneTable[j].y1 = zoneTable[j+1].y1
					zoneTable[j].y2 = zoneTable[j+1].y2
				end
				zoneTable[lineCount] = nil
				PlaySound("igMainMenuOption")
				newline = false
				lineCount = lineCount - 1
			end
		end
	end
	if newline and lineCount < METAMAPNOTES_MAXLINES then
		zoneTable[lineCount+1] = {}
		zoneTable[lineCount+1].x1 = x1
		zoneTable[lineCount+1].x2 = x2
		zoneTable[lineCount+1].y1 = y1
		zoneTable[lineCount+1].y2 = y2
	end
	MetaMapNotes_LastLineClick.zone = 0
	MetaMapNotes_MapUpdate()
end

function MetaMapNotes_NewNoteSlot()
	local currentZone
	local continent = GetCurrentMapContinent()

	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()]
	else
		local zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
		currentZone = MetaMapNotes_Data[continent][zone]
	end
	if(MetaMapFrame:IsVisible()) then
		currentZone = MetaMapNotes_Data[0][MetaMapOptions.MetaMapZone];
	end
	if not currentZone then
		return 1
	end
	return MetaMapNotes_GetZoneTableSize(currentZone) + 1
end

function MetaMapNotes_SetPartyNote(xPos, yPos)
	xPos = floor(xPos * 1000000) / 1000000
	yPos = floor(yPos * 1000000) / 1000000
	local continent = GetCurrentMapContinent()
	local zone = MetaMapNotes_ZoneShift[GetCurrentMapContinent()][GetCurrentMapZone()]
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	MetaMapNotes_PartyNoteData.continent = continent
	MetaMapNotes_PartyNoteData.zone = zone
	MetaMapNotes_PartyNoteData.xPos = xPos
	MetaMapNotes_PartyNoteData.yPos = yPos

	if Sky then
		Sky.sendAlert("<MapN> c<"..continent.."> z<"..zone.."> x<"..xPos.."> y<"..yPos.."> p<1>", SKY_PARTY, "MN")
	end

	if MetaMapNotes_MiniNote_Data.icon == "party" or MetaMapNotes_Options[16] ~= "off" then
		MetaMapNotes_MiniNote_Data.id = -1
		MetaMapNotes_MiniNote_Data.continent = continent
		MetaMapNotes_MiniNote_Data.zone = zone
		MetaMapNotes_MiniNote_Data.xPos = xPos
		MetaMapNotes_MiniNote_Data.yPos = yPos
		MetaMapNotes_MiniNote_Data.name = METAMAPNOTES_PARTYNOTE
		MetaMapNotes_MiniNote_Data.color = 0
		MetaMapNotes_MiniNote_Data.icon = "party"
		MiniNotePOITexture:SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon)
		MiniNotePOI:Show()
	end
	MetaMapNotes_MapUpdate()
end
--[[
-- changed functions from WorldMapFrame.lua & MinimapFrame.lua
-- function changed to be able to ping through the MiniNote (mostly direct copy) (only change: this -> Minimap)
function MetaMapNotes_Minimap_OnClick(...)
	if(arg == "LeftButton") then
		local x, y = GetCursorPosition()
		x = x / Minimap:GetEffectiveScale()
		y = y / Minimap:GetEffectiveScale()
		local cx, cy = Minimap:GetCenter()
		x = x + CURSOR_OFFSET_X - cx
		y = y + CURSOR_OFFSET_Y - cy
		if sqrt(x * x + y * y) < (Minimap:GetWidth() / 2) then
			Minimap:PingLocation(x, y)
		end
	end
end
]]
function MetaMapNotes_WorldMapButton_OnClick(...)
	if(not MetaMapNotes_FramesHidden()) then
		return;
	end

	local zone = GetCurrentMapZone()
	local mouseButton, button = unpack(arg)


		-- if we are viewing a continent or continents or it was left-click call the original handler
	
	if(MetaMapFrame:IsVisible() and mouseButton == "RightButton") then
		MetaMap_Toggle(false);
		MetaMapNotes_MapUpdate();
		return;
	elseif mouseButton == "RightButton" or (mouseButton == "LeftButton" and not IsControlKeyDown() and not IsShiftKeyDown()) then
		if(MetaMapFrame:IsVisible() and mouseButton == "LeftButton") then
			return;
		end
		orig_MetaMapNotes_WorldMapButton_OnClick(unpack(arg));
		return;
	else
		if(MetaMapOptions.UseMapMod and not MetaMapFrame:IsVisible() and IsControlKeyDown()) then
			orig_MetaMapNotes_WorldMapButton_OnClick(unpack(arg));
			return;
		end
	end

		-- <control>+left-click is used to bring up the main menu when viewing a particular zone/city
		-- shift left-click is used to set the party note at the click location

	local continent = GetCurrentMapContinent()
	if(continent == -1 or MetaMapNotes_ZoneShift[continent][zone] ~= 0 or MetaMapFrame:IsVisible()) then
		if not button then
			button = this
		end
		local centerX, centerY = button:GetCenter()
		local width = button:GetWidth()
		local height = button:GetHeight()
		local x, y = GetCursorPosition()
		x = x / button:GetEffectiveScale()
		y = y / button:GetEffectiveScale()
		local adjustedY = (centerY + height/2 - y) / height
		local adjustedX = (x - (centerX - width/2)) / width

		if IsShiftKeyDown() then
			MetaMapNotes_SetPartyNote(adjustedX, adjustedY)
		elseif IsControlKeyDown() then
			MetaMapNotes_ShowNewFrame(adjustedX, adjustedY)
		end
	end
end

function MetaMapNotes_WorldMapButton_OnUpdate(...)
	if MetaMapNotes_Drawing then
		return;
	end

	MetaMapNotes_Drawing = true;

	local width = WorldMapButton:GetWidth();
	local height = WorldMapButton:GetHeight();
	local currentZone;
	local xOffset,yOffset = 0;
	local continent = GetCurrentMapContinent();

	if continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()];
	elseif continent > 0 then
		local zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
	end
	if currentZone and MetaMapOptions.MetaMapShowNotes then
		local n = 1
		for i, value in currentZone do
			local temp = getglobal("MetaMapNotesPOI"..i)
			local xOffset = currentZone[i].xPos * width
			local yOffset = -currentZone[i].yPos * height
			if(MetaMapFrame:IsVisible()) then
				temp:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				temp:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			getglobal("MetaMapNotesPOI"..i.."Texture"):SetTexture(METAMAP_ICON_PATH.."Icon"..currentZone[i].icon)

			if(MetaMapFrame:IsVisible()) then
				getglobal("MetaMapNotesPOI"..i):SetParent("MetaMapFrame");
			else
				getglobal("MetaMapNotesPOI"..i):SetParent("WorldMapButton");
			end
			if MetaMapNotes_Options[currentZone[i].icon] ~= "off" then
				if (MetaMapNotes_Options[10] ~= "off" and currentZone[i].creator == UnitName("player")) or (MetaMapNotes_Options[11] ~= "off" and currentZone[i].creator ~= UnitName("player")) then
					temp:Show()
				end
			else
				temp:Hide()
			end
			n = n + 1
		end

		local lastnote = n - 1
		if MetaMapNotes_Options[12] ~= "off" and lastnote ~= 0 then
			if getglobal("MetaMapNotesPOI"..lastnote):IsVisible() then
				getglobal("MetaMapNotesPOI"..lastnote.."Texture"):SetTexture(METAMAP_ICON_PATH.."Icon"..currentZone[lastnote].icon.."red")
			end
		end

		if MetaMapNotes_Options[13] ~= "off" and MetaMapNotes_MiniNote_Data.continent == continent and
			MetaMapNotes_MiniNote_Data.zone == zone and MetaMapNotes_MiniNote_Data.id > 0 then
			getglobal("MetaMapNotesPOI"..MetaMapNotes_MiniNote_Data.id.."Texture"):
			SetTexture(METAMAP_ICON_PATH.."Icon"..MetaMapNotes_MiniNote_Data.icon.."blue")
		end
		
		MetaMapNotes_Used_Notes = n;
		
		for i=n, MetaMapNotes_NotesPerZone, 1 do
			getglobal("MetaMapNotesPOI"..i):Hide()
		end

		local currentLineZone
		if continent == -1 then
			currentLineZone = MetaMapNotes_Lines[GetRealZoneText()]
		else
			local zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()]
			currentLineZone = MetaMapNotes_Lines[continent][zone]
		end
		if(MetaMapFrame:IsVisible()) then
			currentLineZone = MetaMapNotes_Lines[0][MetaMapOptions.MetaMapZone];
		end
		if currentLineZone then
			local n = 1
			for i,line in currentLineZone do
				MetaMapNotes_DrawLine(i, line.x1, line.y1, line.x2, line.y2)
				n = n + 1
			end

		MetaMapNotes_Used_Lines = n;

			for i=n, METAMAPNOTES_MAXLINES, 1 do
				getglobal("MetaMapNotesLines_"..i):Hide()
			end
		end
	else
		for i=1, MetaMapNotes_NotesPerZone, 1 do
			getglobal("MetaMapNotesPOI"..i):Hide()
		end

		for i=1, METAMAPNOTES_MAXLINES, 1 do
			getglobal("MetaMapNotesLines_"..i):Hide()
		end
	end


	if currentZone then
		-- tloc button
		if MetaMapNotes_tloc_xPos ~= nil and zone ~= 0 then
			xOffset = MetaMapNotes_tloc_xPos * width
			yOffset = -MetaMapNotes_tloc_yPos * height
			if(MetaMapFrame:IsVisible()) then
				MetaMapNotesPOItloc:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				MetaMapNotesPOItloc:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			MetaMapNotesPOItloc:Show()
		else
			MetaMapNotesPOItloc:Hide()
		end

	-- party note
		if MetaMapNotes_PartyNoteData.xPos ~= nil and zone == MetaMapNotes_PartyNoteData.zone and
				continent == MetaMapNotes_PartyNoteData.continent then
			if MetaMapNotes_Options[13] ~= "off" and MetaMapNotes_MiniNote_Data.icon == "party" then
				MetaMapNotesPOIpartyTexture:SetTexture(METAMAP_ICON_PATH.."Iconpartyblue")
			else
				MetaMapNotesPOIpartyTexture:SetTexture(METAMAP_ICON_PATH.."Iconparty")
			end
			xOffset = MetaMapNotes_PartyNoteData.xPos * width
			yOffset = -MetaMapNotes_PartyNoteData.yPos * height
			if(MetaMapFrame:IsVisible()) then
				MetaMapNotesPOIparty:SetPoint("CENTER", "MetaMapFrame", "TOPLEFT", xOffset, yOffset)
			else
				MetaMapNotesPOIparty:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", xOffset, yOffset)
			end
			MetaMapNotesPOIparty:Show()
		else
			MetaMapNotesPOIparty:Hide()
		end
	end
	MetaMapNotes_Drawing = nil
	MetaMapText_NoteTotals:SetText(METAMAP_NOTES_SHOWN..": ".."|cffffffff"..(MetaMapNotes_Used_Notes - 1).."/"..MetaMapNotes_NotesPerZone.."  ".."|cfff0B300"..METAMAP_LINES_SHOWN..": ".."|cffffffff"..(MetaMapNotes_Used_Lines - 1).."/"..METAMAPNOTES_MAXLINES);

	if(MetaMapOptions.UseMapMod and IsAddOnLoaded("CT_MapMod")) then
		if(MetaMapFrame:IsVisible()) then
			CT_NumNotes:Hide();
			MetaMapText_NoteTotals:Show();
		else
			CT_NumNotes:Show();
			MetaMapText_NoteTotals:Hide();
		end
	else
		if(IsAddOnLoaded("CT_MapMod")) then
			CT_NumNotes:Hide();
		end
		MetaMapText_NoteTotals:Show();
	end
	MetaMapList_Init();
end

function MetaMapNotes_ToggleWorldMap(...)
	MetaMapNotes_HideAll()
end

function MetaMapNotes_ConvertFromOldZoneShift()
	local temp = {}

	if not MetaMapNotes_ZoneShiftOld then
		MetaMap_StatusPrint(METAMAPNOTES_ERROR_NO_OLD_ZONESHIFT, true)
		return
	end

	for z=1, 2, 1 do
		for index, value in MetaMapNotes_Data[z] do
			local zone
			for index2, value2 in MetaMapNotes_ZoneShiftOld[z] do
				if value2 == index then
					zone = index2
				end
			end
			temp[MetaMapNotes_ZoneShift[z][zone]] = value
		end
		MetaMapNotes_Data[z] = {}
		for index, value in temp do
			MetaMapNotes_Data[z][index] = value
		end
		temp = {}
	end
	MetaMap_StatusPrint(METAMAPNOTES_CONVERSION_COMPLETE, true)
end

local versionID = 20
local zoneID={}

-- hooked functions
local orig_SetMapToCurrentZone

local function MetaMapNotes_SetMapToCurrentZone(deactivate)
	if deactivate then
		SetMapToCurrentZone = orig_SetMapToCurrentZone
		CurrentZoneFix_FixInPlace = nil
		return true
	end

	orig_SetMapToCurrentZone()
	if GetCurrentMapZone() == 0 and GetCurrentMapContinent() > 0 then
		SetMapZoom(GetCurrentMapContinent(), zoneID[GetRealZoneText()])
	else
		SetMapToCurrentZone = orig_SetMapToCurrentZone
		CurrentZoneFix_FixInPlace = "Deactivated "..versionID
	end
end

function MetaMapNotes_SetupCurrentZoneFix()
	local id = CurrentZoneFix_FixInPlace

	if id then
		id = tonumber(id)
		if id and id >= versionID then
			return
		elseif not SetMapToCurrentZone(true) then
			if DEFAULT_CHAT_FRAME then
				DEFAULT_CHAT_FRAME:AddMessage("Warning! Obsolete version "..
					"of CurrentZoneFix function detected. The old "..
					"version is being loaded either as a standalone "..
					"AddOn, or as code embedded inside another AddOn. "..
					"You must update it to avoid bugs with the map!",1,0,0)
			end
			return
		end
	end

	for continent in ipairs{GetMapContinents()} do
		for zone,name in ipairs{GetMapZones(continent)} do
			zoneID[name] = zone
		end
	end

	orig_SetMapToCurrentZone = SetMapToCurrentZone
	SetMapToCurrentZone = MetaMapNotes_SetMapToCurrentZone
	CurrentZoneFix_FixInPlace = versionID
end

local function ThottbotReplace_Round(x)
	if (x - math.floor(x) > 0.5) then
		x = x + 0.5
	end
	return math.floor(x)
end

local function ThottbotReplace_UpdateMinimapText()
	if ThottbotReplace_IsActive then
		local x,y = GetPlayerMapPosition("player")
		x = ThottbotReplace_Round(x*100)
		y = ThottbotReplace_Round(y*100)
		ThottbotReplace_ThottbotText:SetText(format("%2d,%2d",x,y))
		if Chronos then
			Chronos.scheduleByName("TlocUpdate", 0.1, ThottbotReplace_UpdateMinimapText)
		end
	end
end

local function ThottbotReplace_TlocFunction(msg)
	if ThottbotReplace_IsActive and msg == "" then
		ThottbotReplace_IsActive = false
		ThottbotReplace_ThottbotText:Hide()
		if ThottbotLocationFrame then
			ThottbotLocationFrame:Hide()
		end
	else
		ThottbotReplace_IsActive = true
		if ThottbotReplace_ThottbotText then
			ThottbotReplace_ThottbotText:Show()
		else -- just in case thottbot isn't loaded (the user delete the folder or something like this)
			MetaMap_StatusPrint("Thottbot isn't loaded, this is a Thottbot function. Use '/mntloc xx,yy' to show a location on the map.", true)
			ThottbotReplace_IsActive = false
			return
		end
		ThottbotReplace_UpdateMinimapText()
		MetaMap_StatusPrint("Current Thottbot location is under the minimap.", true)
		if msg ~= "" then
			local i,j,x,y = string.find(msg,"(%d+),(%d+)")
			if x and y then
				MetaMapNotes_tloc_xPos = (x + 0.5) / 100
				MetaMapNotes_tloc_yPos = (y + 0.5) / 100
				MetaMap_StatusPrint("Target Thottbot location is on the zone map.", true)
			else
				MetaMap_StatusPrint("Usage: /tloc x,y", true)
			end
		else
			MetaMapNotes_tloc_xPos = nil
			MetaMapNotes_tloc_yPos = nil
			MetaMap_StatusPrint("Note: /tloc x,y will show coordinates on the map.", true)
			MetaMap_StatusPrint("Note2: /goto x,y will try to take you there! Use at your own risk. No refunds.", true)
		end
	end
end

function ThottbotReplace_ReplaceIt()
	if ThottbotReplace_ThottbotText then
		if Sky then
			Sky.registerSlashCommand(
				{
				id = "ThottbotReplaceTloc",
				commands = {"/tloc", "/thottbotloc"},
				onExecute = ThottbotReplace_TlocFunction,
				helpText = "display current Thottbot location coordinates",
				}
			)
		end
	end
end

function MetaMapList_OnLoad()
	table.insert(UISpecialFrames, "MetaMap_MapListFrame")
end

function MetaMapList_Init()
	if(not MetaMapOptions.ShowMapList) then
		return;
	end
	FauxScrollFrame_SetOffset(MetaMapList_ScrollFrame, 0);
	MetaMapPing_OnUpdate(30)
	MetaMapList_BuildList();
	if(not MetaMap_NoteList[1]) then
		MetaMap_MapListFrame:Hide();
		return;
	end
	MetaMapList_UpdateScroll();
	MetaMap_MapListFrame:Show();
end

function MetaMapList_BuildList()
	MetaMap_NoteList = {};
	local index = 1;
	local zone;
	local currentZone;
	local realContinent, realZone = MetaMapNotes_GetZone();
	local continent = GetCurrentMapContinent();

	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = MetaMapOptions.MetaMapZone;
		currentZone = MetaMapNotes_Data[continent][zone];
		MetaMapList_PlayerButton:Hide();
	elseif continent == -1 then
		currentZone = MetaMapNotes_Data[GetRealZoneText()];
	elseif continent > 0 then
		zone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		currentZone = MetaMapNotes_Data[continent][zone];
		if(realZone == zone) then
			MetaMapList_PlayerButton:Show();
		else
			MetaMapList_PlayerButton:Hide();
		end
	end
	if(not currentZone or zone == 0) then
		MetaMap_MapListFrame:Hide();
		return;
	end
	getglobal("MetaMapList_PlayerButton".."Name"):SetText("Show "..UnitName("Player").."'s Position");

	for i, value in currentZone do
		MetaMap_NoteList[index] = {};
		MetaMap_NoteList[index]["name"] = currentZone[i]["name"];
		MetaMap_NoteList[index]["xPos"] = currentZone[i]["xPos"];
		MetaMap_NoteList[index]["yPos"] = currentZone[i]["yPos"];
		index = index + 1;
	end
	MetaMap_NoteList.onePastEnd = index;
end

function MetaMapList_UpdateScroll()
	for i = 1, METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN, 1 do
		local buttonIndex = i + FauxScrollFrame_GetOffset(MetaMapList_ScrollFrame);
		local scrollFrameButton = getglobal("MetaMapList_ScrollFrameButton"..i);
		local NameButton = getglobal("MetaMapList_ScrollFrameButton"..i.."Name");
		if buttonIndex < MetaMap_NoteList.onePastEnd then
			NameButton:SetText(MetaMap_NoteList[i]["name"]);
			scrollFrameButton:Show();
		else
			scrollFrameButton:Hide();
		end
	end
	FauxScrollFrame_Update(MetaMapList_ScrollFrame, MetaMap_NoteList.onePastEnd - 1,
        METAMAPLIST_SCROLL_FRAME_BUTTONS_SHOWN, METAMAPLIST_SCROLL_FRAME_BUTTON_HEIGHT);
end

function MetaMapPing_SetPing(id)
	if(MetaMapPing:IsVisible()) then
		MetaMapPing:Hide();
		return;
	end
	local x, y = nil;
	if(id == 0) then
		MetaMapPing:SetParent(WorldMapButton);
		x, y = GetPlayerMapPosition("player");
	else
		local button = getglobal("MetaMapNotesPOI"..id);
		MetaMapPing:SetParent(button);
		x = MetaMap_NoteList[id]["xPos"];
		y = MetaMap_NoteList[id]["yPos"];
	end
	x = (x * WorldMapButton:GetWidth()) - (WorldMapPlayer:GetEffectiveScale() * 10);
	y = (-y * WorldMapButton:GetHeight()) - (WorldMapPlayer:GetEffectiveScale() * 10);
	MetaMapPing:SetPoint("CENTER", WorldMapButton, "TOPLEFT", x, y);
	MetaMapPing:SetAlpha(255);
	MetaMapPing.timer = PingTime;
	MetaMapPing:Show();
	PlaySound("MapPing");
end

function MetaMapPing_OnUpdate(elapsed)
	if(MetaMapPing:IsVisible()) then
		if ( MetaMapPing.timer > 0 ) then
			MetaMapPing.timer = MetaMapPing.timer - elapsed;
		else
			MetaMapPing:Hide();
		end
	end
end

function KB_Toggle()
	if(MetaKB_MainFrame:IsVisible()) then
		HideUIPanel(MetaKB_MainFrame);
	else
		ShowUIPanel(MetaKB_MainFrame);
	end
end

function MetaKB_OnLoad()
	math.randomseed(GetTime());
	table.insert(UISpecialFrames, "MetaKB_MainFrame");
	table.insert(UISpecialFrames, "MetaKB_OptionsFrame");
end

function MetaKB_OnEvent()
	if event == "UPDATE_MOUSEOVER_UNIT" then
		if(MetaMapOptions.AutoTrack) then
			MetaKB_UpdateMouseoverUnit();
		end
	end
end

function MetaKB_GetDataStats()
	local tempZones = {}
	local nameCount = 0
	local zoneCount = 0

	for name, zoneTable in MetaKB_Data do
		nameCount = nameCount + 1
		for zone in zoneTable do
			if tempZones[zone] == nil then
				zoneCount = zoneCount + 1
				tempZones[zone] = 0
			end
		end
	end
	return nameCount,zoneCount
end

function MetaKB_ClearMapNotes()
    if MetaMapNotes_DeleteNotesByCreatorAndName ~= nil then
        PlaySound("igQuestLogAbandonQuest")
        MetaMapNotes_DeleteNotesByCreatorAndName(TEXT(METAKB_AUTHOR))
    end
end

function MetaKB_Round(num, idp)
  local mult = 10^(idp or 0)
  return MetaMap_round(math.floor(num  * mult + 0.5) / mult)
end

function MetaKB_StripTextColors(textString)
    -- this function is designed to replace
    -- |cff00AA00Colored Text|r
    -- with
    -- Colored Text
    if textString ~= nil and textString ~= "" then
        return string.gsub(textString, "|c[%dA-Fa-f][%dA-Fa-f][%dA-Fa-f][%dA-Fa-f][%dA-Fa-f]"..
                           "[%dA-Fa-f][%dA-Fa-f][%dA-Fa-f](.*)|r", "%1")
    else
        assert(false, "nil or invalid parameter to StripTextColors")
    end
end

function MetaKB_ToggleSetRange(range)
	for i=1, 5 do
		if(i == range) then
			local checkButton = getglobal("MetaKB_RangeCheck"..i);
			checkButton:SetChecked(true);
		else
			local checkButton = getglobal("MetaKB_RangeCheck"..i);
			checkButton:SetChecked(false);
		end
	end
	MetaMapOptions.RangeCheck = range;
end

function MetaKB_UpdateMouseoverUnit()
	if MetaKB_Debug then
		MetaKB_DebugMouseover();
	end

	if(UnitIsPlayer("mouseover")~=1 and UnitPlayerControlled("mouseover")~=1 and UnitIsDead("mouseover")~=1) then
		MetaKB_AddUnitInfo("mouseover");
	end
end

function MetaKB_UpdateKeySelectedUnit()
	if (not UnitExists("target")) then
		MetaMap_StatusPrint(METAKB_NOTARGET,MetaMapOptions.ShowUpdates);
		return;
	else
		if(IsControlKeyDown()) then
			overRide = true;
		end
		MetaKB_AddUnitInfo("target");
			overRide = false;
	end
end

function MetaKB_AddUnitInfo(UnitSelect)
	if( not CheckInteractDistance(UnitSelect, MetaMapOptions.RangeCheck) and MetaMapOptions.RangeCheck ~= 5) then
		return;
	end

	SetMapToCurrentZone();
	local zone = MetaKB_ConvertZoneNameToIdentifier(GetRealZoneText());
	if zone == "" then
		return;
	end

	local playerX, playerY = GetPlayerMapPosition("player")
	playerX = MetaKB_Round(playerX*10000, 0)
	playerY = MetaKB_Round(playerY*10000, 0)
	local icon = 3; --green by default
	local unitName = UnitName(UnitSelect);
	local desc1 = "";
	local desc2 = "";

	-- strip off any colors
	unitName = MetaKB_StripTextColors(unitName);

	if(UnitReaction("player", UnitSelect) < 4) then
		if(UnitClassification(UnitSelect) ~= "normal") then
			desc1 = UnitClassification(UnitSelect).." ";
		end
		desc1 = desc1..UnitCreatureType(UnitSelect).." "..UnitClass(UnitSelect);
		if(UnitLevel(UnitSelect) == "-1") then
			desc2 = "Level ??";
		else
			desc2 = "Level "..UnitLevel(UnitSelect);
		end
		icon = 1;
	elseif(UnitReaction("player", UnitSelect) == 4) then
		desc1 = string.sub(GameTooltipTextLeft2:GetText(), -7, -1);
		desc2 = "Level "..UnitLevel(UnitSelect);
		icon = 0;
	elseif(UnitReaction("player", UnitSelect) > 4 and UnitIsPlayer(UnitSelect)) then
		unitName = UnitPVPName(UnitSelect);
		desc1 = UnitRace(UnitSelect).." "..UnitClass(UnitSelect);
		desc2 = "Level "..UnitLevel(UnitSelect);
		icon = 2;
	else
		local check = GameTooltipTextLeft2:GetText();
		if (check ~= nil) then
			if(string.find(check,"Level")) then
				if(GameTooltipTextLeft3 ~= "" and GameTooltipTextLeft3 ~= nil) then
					desc1 = GameTooltipTextLeft3:GetText();
					desc2 = GameTooltipTextLeft2:GetText();
				end
			else
				if(GameTooltipTextLeft2 ~= "" and GameTooltipTextLeft2 ~= nil) then
					desc1 = GameTooltipTextLeft2:GetText();
				end
				if(GameTooltipTextLeft3 ~= "" and GameTooltipTextLeft3 ~= nil) then
					desc2 = GameTooltipTextLeft3:GetText();
				end
			end
		end
	end
		if(desc1 == nil) then desc1 = ""; end
		if(desc2 == nil) then desc2 = ""; end

		local changedSomething = false;
		local addedSomething = false;
		local updatedSomething = false;

		if(MetaKB_Data[unitName] == nil) then
			MetaKB_Data[unitName] = {};
			MetaMap_StatusPrint(format(TEXT(METAKB_DISCOVERED_UNIT), unitName), MetaMapOptions.ShowUpdates,0.8,0,0);
		end

		if(MetaKB_Data[unitName][zone] == nil) then
			MetaKB_Data[unitName][zone] = {};
			MetaKB_Data[unitName][zone]["inf1"] = desc1;
			MetaKB_Data[unitName][zone]["inf2"] = desc2;
			MetaKB_Data[unitName][zone]["icon"] = icon;
			MetaKB_Data[unitName][zone][1] = 20000;
			MetaKB_Data[unitName][zone][2] = -1;
			MetaKB_Data[unitName][zone][3] = -1;
			MetaKB_Data[unitName][zone][4] = 20000;
			addedSomething = true
		else
			if(MetaKB_Data[unitName][zone]["inf1"] == "") then
				MetaKB_Data[unitName][zone]["inf1"] = desc1;
				updatedSomething = true;
			end
			if(MetaKB_Data[unitName][zone]["inf2"] == "") then
				MetaKB_Data[unitName][zone]["inf2"] = desc2;
				updatedSomething = true;
			end
		end		

		local coords = MetaKB_Data[unitName][zone]

		if(playerX < coords[4]) then
			MetaKB_Data[unitName][zone][4] = playerX;
			changedSomething = true;
		end
		if(playerY < coords[1]) then
			MetaKB_Data[unitName][zone][1] = playerY;
			changedSomething = true;
		end
		if(playerX > coords[2]) then
			MetaKB_Data[unitName][zone][2] = playerX;
			changedSomething = true;
		end
		if(playerY > coords[3]) then
			MetaKB_Data[unitName][zone][3] = playerY;
			 changedSomething = true;
		end

	if(MetaMapOptions.NewTargetNote or overRide) then
		MetaKB_AddMapNotes(unitName, GetRealZoneText());
		PlaySound("MapPing");
	end
	if(MetaMapOptions.KBstate) then
		if(addedSomething) then
			MetaKB_Search(g_LastSearch, true);
			MetaMap_StatusPrint(format(TEXT(METAKB_ADDED_UNIT_IN_ZONE), unitName, MetaKB_ConvertZoneIdentifierToName(zone)), MetaMapOptions.ShowUpdates,0.8,0,0);
		end
		if(changedSomething and not addedSomething) then
			MetaKB_Search(g_LastSearch, true);
			MetaMap_StatusPrint(format(TEXT(METAKB_UPDATED_MINMAX_XY), unitName, MetaKB_ConvertZoneIdentifierToName(zone)), MetaMapOptions.ShowUpdates,0.8,0,0);
		end
		if(updatedSomething) then
			MetaKB_Search(g_LastSearch, true);
			MetaMap_StatusPrint(format(TEXT(METAKB_UPDATED_INFO), unitName, MetaKB_ConvertZoneIdentifierToName(zone)), MetaMapOptions.ShowUpdates,0.8,0,0);
		end
	else
		MetaKB_Data[unitName][zone] = nil;
		MetaKB_RemoveNamesWithNoZones();
	end
end

function MetaKB_DebugMouseover()
	if UnitIsPlayer("mouseover")~=1 and UnitPlayerControlled("mouseover")~=1 and
		UnitIsDead("mouseover")~=1 then
		local unitName = UnitName("mouseover");
		local description = GameTooltipTextLeft2:GetText();
		local zone1 = GetZoneText();
		local zone2 = GetRealZoneText();
		MetaMap_StatusPrint(unitName..", "..description..", zone: "..zone1..", real: "..zone2);
	end
end

function MetaKB_UpdateScrollFrame()
	for iScrollFrameButton = 1, METAKB_SCROLL_FRAME_BUTTONS_SHOWN, 1 do
		local buttonIndex = iScrollFrameButton + FauxScrollFrame_GetOffset(MetaKB_ScrollFrame);
		local scrollFrameButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton);
		local NameButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Name");
		local Info1Button = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Info1");
		local Info2Button = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Info2");
		local CoordsButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Coords");

		if buttonIndex < g_SearchResults.onePastEnd then
			if g_SearchResults[buttonIndex]["zone"] == MetaKB_ConvertZoneNameToIdentifier(GetRealZoneText()) then
				-- Unit is in the same zone, show in yellow
				NameButton:SetText(g_SearchResults[buttonIndex]["name"]);
				Info1Button:SetText(g_SearchResults[buttonIndex]["desc"]);
				Info2Button:SetText(g_SearchResults[buttonIndex]["level"]);
				CoordsButton:SetText(g_SearchResults[buttonIndex]["location"]);
				if(g_SearchResults[buttonIndex]["cCode"] == 2) then
						NameButton:SetTextColor(0,1,0)
						CoordsButton:SetTextColor(0,1,0)
				else
						NameButton:SetTextColor(1,1,0)
						CoordsButton:SetTextColor(1,1,0)
				end
				scrollFrameButton:Show();
			else
				if not MetaMapOptions.ShowOnlyLocalNPCs then
					-- Unit is in a different zone, show in red
					NameButton:SetText(g_SearchResults[buttonIndex]["name"]);
					Info1Button:SetText(g_SearchResults[buttonIndex]["desc"]);
					Info2Button:SetText(g_SearchResults[buttonIndex]["level"]);
					CoordsButton:SetText(MetaKB_ConvertZoneIdentifierToName(g_SearchResults[buttonIndex]["zone"]));
					NameButton:SetTextColor(1,0,0)
					CoordsButton:SetTextColor(1,0,0)
					scrollFrameButton:Show();
				else
					scrollFrameButton:Hide();
				end
			end
			Info1Button:SetTextColor(0.8,0.8,0.8)
			Info2Button:SetTextColor(0.5,0.5,0.8)
		else
			scrollFrameButton:Hide();
		end
	end
	FauxScrollFrame_Update(MetaKB_ScrollFrame, g_SearchResults.onePastEnd - 1,
        METAKB_SCROLL_FRAME_BUTTONS_SHOWN, METAKB_SCROLL_FRAME_BUTTON_HEIGHT)
end

function MetaKB_BuildSearchResults()
	local index = 1;
	local cCode = 1;
	g_SearchResults = {};

	for name, zoneTable in MetaKB_Data do
		for zone in zoneTable do
			if(zone == MetaKB_ConvertZoneNameToIdentifier(GetRealZoneText()) or not MetaMapOptions.ShowOnlyLocalNPCs) then
				local inf1 = MetaKB_Data[name][zone]["inf1"];
				local inf2 = MetaKB_Data[name][zone]["inf2"];
				local coords = MetaKB_Data[name][zone];
				local cleanCoords = {};
				local coordString = "";
					for i=1,4 do
					-- turns 1234 into 12
					cleanCoords[i] = MetaKB_Round(coords[i]/100, 0);
				end
				local dx = coords[2]/100 - coords[4]/100;
				local dy = coords[3]/100 - coords[1]/100;
				local centerx = coords[4]/100 + dx/2;
				local centery = coords[1]/100 + dy/2;
				-- truncate to two digits after the decimal again
				centerx = MetaKB_Round(centerx, 2);
				centery = MetaKB_Round(centery, 2);
				-- if the NPC has a range of 3 map units or greater, show ranges
				if dx >= 3 or dy >= 3 then
					coordString = " ("..cleanCoords[4].."-"..cleanCoords[2].."),"..
                               " ("..cleanCoords[1].."-"..cleanCoords[3]..")"
				else
					-- otherwise just show an averaged point
					coordString = " ("..centerx..", "..centery..")"
				end
				if(centerx > (g_PlayerX +3) or centerx < (g_PlayerX -3) and centery > (g_PlayerY +3) or centery < (g_PlayerY -3)) then
					cCode = 1;
				else
	 				cCode = 2;
				end
				if(zone ~= MetaKB_ConvertZoneNameToIdentifier(GetRealZoneText())) then
					coordString = MetaKB_ConvertZoneIdentifierToName(zone);
				end
				if(string.find(string.lower(name),string.lower(g_LastSearch),1,true)~=nil
					or string.find(string.lower(inf1),string.lower(g_LastSearch),1,true)~=nil
					or string.find(string.lower(inf2),string.lower(g_LastSearch),1,true)~=nil
					or string.find(string.lower(coordString),string.lower(g_LastSearch),1,true)~=nil) then
					tinsert(g_SearchResults, {name = name, zone = zone, desc = inf1, level = inf2, location = coordString, cCode = cCode});
					index = index + 1;
				end
			end
		end
	end
	g_SearchResults.onePastEnd = index;
	MetaKBList_SortBy(sortType, sortDone)
end

function MetaKBList_SortBy(aSortType, aSortDone)
	sortType = aSortType;
	sortDone = aSortDone;
  table.sort(g_SearchResults, MetaSort_Criteria);
	if(not sortDone)then
		local count = g_SearchResults.onePastEnd;
		g_SearchResults = MetaKB_InvertList(g_SearchResults);
		g_SearchResults.onePastEnd = count;
	end
	MetaKB_UpdateScrollFrame();
end

function MetaSort_Criteria(a, b)
	if(sortType == METAKB_SORTBY_NAME) then
		if (a.name < b.name) then
			return true;
		elseif (a.name > b.name) then
			return false;
		end
	elseif(sortType == METAKB_SORTBY_DESC) then
		if (a.desc < b.desc) then
			return true;
		elseif (a.desc > b.desc) then
			return false;
		end
	elseif(sortType == METAKB_SORTBY_LEVEL) then
		if (a.level < b.level) then
			return true;
		elseif (a.level > b.level) then
			return false;
		end
	elseif(sortType == METAKB_SORTBY_LOCATION) then
		if (a.location < b.location) then
			return true;
		elseif (a.location > b.location) then
			return false;
		end
	else
		if (a == nil) then
			if (b == nil) then
				return false;
			else
				return true;
			end
		elseif (b == nil) then
			return false;
		end
	end
end

function MetaKB_InvertList(list)
  local newlist = {};
  local count = table.getn(list);
  for i=1,count
  do
    table.insert(newlist, list[(count +1) -i]);
  end
  return newlist;
end

function MetaKB_Search(searchText, suppressErrors)
	if searchText == nil then
		searchText = g_LastSearch;
	end

	if suppressErrors == nil then
		suppressErrors = false;
	end

	g_LastSearch = searchText;
	SetMapToCurrentZone();
	g_PlayerX, g_PlayerY = GetPlayerMapPosition("player");
	g_PlayerX = MetaMap_round(g_PlayerX * 100);
	g_PlayerY = MetaMap_round(g_PlayerY * 100);
	FauxScrollFrame_SetOffset(MetaKB_ScrollFrame, 0);
	MetaKB_BuildSearchResults();
	MetaKB_UpdateScrollFrame();
	MetaKB_SearchEditBox:SetText(g_LastSearch);

	if g_SearchResults.onePastEnd == 1 and not suppressErrors then
		local nameCount = MetaKB_GetDataStats();
		if nameCount ~= 0 then
			MetaMap_StatusPrint(format(TEXT(METAKB_NO_NPC_MOB_FOUND), g_LastSearch), MetaMapOptions.ShowUpdates);
		end
	end
end

function MetaKB_ConvertZoneNameToIdentifier(zoneNameToConvert)
	for index, zoneTable in MetaKB_ZoneIdentifiers do
		if(zoneNameToConvert == zoneTable.z) then
			return zoneTable.i;
		end
	end
	-- We leave zone names we don't know about (due to a patch, GetZoneText/GetRealZoneText
	-- weirdness, etc.) intact and we will convert them in a future version
	if(type(zoneNameToConvert) == "string") then
		MetaKB_UnknownZones[zoneNameToConvert] = 0;
	end
	return zoneNameToConvert;
end

function MetaKB_ConvertZoneIdentifierToName(zoneIdentifierToConvert)
	for index, zoneTable in MetaKB_ZoneIdentifiers do
		if zoneIdentifierToConvert == zoneTable.i then
			return zoneTable.z;
		end
	end
    -- A not-yet-converted zoneIdentifier (still a string) was passed to this function.  We just
    -- pass it through and hope for the best.  In all likelihood it won't be recognized by whatever
    -- is asking (its probably a bad zone name from GetZoneText, etc.)
	return zoneIdentifierToConvert;
end

function MetaKB_GetClientZoneFromZoneName(zone)
	for continentKey,continentName in ipairs{GetMapContinents()} do
		for zoneKey,zoneName in ipairs{GetMapZones(continentKey)} do
			if zone == zoneName then
				return continentKey, zoneKey;
			end
		end
	end

    -- We weren't able to find a zone in the client corresponding to our zoneIdentifier.  This is
    -- probably due to not-yet-converted data that contains bad GetZoneText information.
	return 0, 0;
end

function MetaKB_ScrollFrameButtonOnClick(button)
	local name = getglobal("MetaKB_ScrollFrameButton"..this:GetID().."Name"):GetText();
	local zone = getglobal("MetaKB_ScrollFrameButton"..this:GetID().."Coords"):GetText();
	if(string.find(zone, "%(%d+\.?-?%d*%)?, %(?%d+\.?-?%d*%)")) then
		zone = GetRealZoneText();
	end
	local zoneIdentifier = MetaKB_ConvertZoneNameToIdentifier(zone);

	if button == "LeftButton" then
		if IsShiftKeyDown() and ChatFrameEditBox:IsVisible() then
			local coords = MetaKB_Data[name][zoneIdentifier];
			local dx = coords[2]/100 - coords[4]/100;
			local dy = coords[3]/100 - coords[1]/100;
			local centerx = coords[4]/100 + dx/2;
			local centery = coords[1]/100 + dy/2;
			centerx = MetaKB_Round(centerx, 0);
			centery = MetaKB_Round(centery, 0);
			local coordString = " ("..centerx..", "..centery..")"
			ChatFrameEditBox:Insert(name.." <"..MetaKB_Data[name][zoneIdentifier].inf1.."> "..zone.." "..coordString);
		else
			PlaySound("MapPing");
			MetaKB_AddMapNotes(name, zone);
			MetaMapNotes_MapUpdate();
			PlaySound("igMiniMapClose");
		end
	elseif button == "RightButton" then
		if MetaMapNotes_DeleteNotesByCreatorAndName ~= nil then
			MetaMapNotes_DeleteNotesByCreatorAndName(TEXT(METAKB_AUTHOR), name);
		end

		if IsShiftKeyDown() and IsControlKeyDown() then
			-- delete entry from database
			MetaKB_Data[name][zoneIdentifier] = nil;
			MetaKB_RemoveNamesWithNoZones();
			PlaySound("Deathbind Sound");
			MetaMap_StatusPrint(format(TEXT(METAKB_REMOVED_FROM_DATABASE), name, zone), MetaMapOptions.ShowUpdates);
			MetaKB_Search(g_LastSearch, true);
		else
			PlaySound("igMiniMapClose");
		end
	end
end

function MetaKB_GetMapNotesZoneFromZoneName(zone)
	local continentKey,zoneKey = MetaKB_GetClientZoneFromZoneName(zone);

	if MetaMapNotes_ZoneShift ~= nil then
		return continentKey,MetaMapNotes_ZoneShift[continentKey][zoneKey];
	else
		return 0,0;
	end
end

-- c<1> z<6> x<0.62> y<0.62> t<MetaKB Note 1> i1<Info 1> i2<Info 2> cr<MetaKB> i<5> tf<3> i1f<4> i2f<5>
function MetaKB_AddMapNotes(name, zone)
	local continentKey,mapNotesZone = MetaKB_GetMapNotesZoneFromZoneName(zone)
	local coordSets = {
	[1] = { ["n"] = TEXT(METAKB_MAPNOTES_NW_BOUND), ["x"] = 4, ["y"] = 1, },
	[2] = { ["n"] = TEXT(METAKB_MAPNOTES_NE_BOUND), ["x"] = 2, ["y"] = 1, },
	[3] = { ["n"] = TEXT(METAKB_MAPNOTES_SE_BOUND), ["x"] = 2, ["y"] = 3, },
	[4] = { ["n"] = TEXT(METAKB_MAPNOTES_SW_BOUND), ["x"] = 4, ["y"] = 3, }, }

	if MetaMapNotes_GetNoteBySlashCommand ~= nil and MetaMapNotes_ToggleLine ~= nil and MetaMapNotes_NextMiniNote ~= nil and continentKey ~= 0 and mapNotesZone ~= 0 then
		local zoneIdentifier = MetaKB_ConvertZoneNameToIdentifier(zone);
		local coords = MetaKB_Data[name][zoneIdentifier];
		local infoOne = MetaKB_Data[name][zoneIdentifier]["inf1"];
		local infoTwo = MetaKB_Data[name][zoneIdentifier]["inf2"];
		local icon = MetaKB_Data[name][zoneIdentifier]["icon"];
		local namecol = 0;
		
		if(icon == 1) then
			namecol = 2;
		elseif(icon == 2) then
			namecol = 6;
		elseif(icon == 3) then
			namecol = 4;
		end

		local dx = coords[2]/100 - coords[4]/100
		local dy = coords[3]/100 - coords[1]/100
		local centerx = coords[4]/100 + dx/2
		local centery = coords[1]/100 + dy/2
		centerx = MetaKB_Round(centerx, 2)
		centery = MetaKB_Round(centery, 2)

		centerx = centerx/100
		centery = centery/100
		-- add center point
		local msg = MetaKB_CreateMapNotesMessage(continentKey, mapNotesZone, centerx, centery, name, infoOne, infoTwo, icon, namecol, 9, 6)
		if msg ~= "" then
			MetaMapNotes_NextMiniNote("on")
			PlaySound("MapPing")
			MetaMapNotes_GetNoteBySlashCommand(msg)
		end

		-- add bounding box if the range in x or y is 3 map units or more and the option is enabled
		if (dx >= 3 or dy >= 3) and MetaMapOptions.CreateMapNotesBoundingBox then
			local x2 = coords[4]/10000
			local y2 = coords[3]/10000
			local skipNext = false
			for i in coordSets do
				local x1 = coords[coordSets[i].x]/10000
				local y1 = coords[coordSets[i].y]/10000
				local msg = MetaKB_CreateMapNotesMessage(continentKey, mapNotesZone, x1, y1, name, infoOne, infoTwo, icon, namecol, 9, 6)
				if msg ~= "" then
					local noteAdded = MetaMapNotes_GetNoteBySlashCommand(msg)

					if noteAdded then
						if not skipNext then
							MetaMapNotes_ToggleLine(continentKey, mapNotesZone, x1, y1, x2, y2)
						end
						skipNext = false
					else
						skipNext = true
					end
				end
				x2,y2 = x1,y1
			end
		end
	end
end

function MetaKB_CreateMapNotesMessage(continentKey, mapNotesZone, x, y, name, infoOne, infoTwo, icon, nameColor, infoOneColor, infoTwoColor)
	if continentKey ~= 0 and mapNotesZone ~= 0 and x >= 0 and x <= 1 and y >= 0 and y <= 1
		and name ~= nil and name ~= "" and infoOne ~= nil and infoTwo ~= nil and icon >= 0
		and icon <= 9 and nameColor >= 0 and nameColor <= 9 and infoOneColor >= 0
		and infoOneColor <= 9 and infoTwoColor >= 0 and infoTwoColor <= 9 then
		return "c<"..continentKey.."> z<"..mapNotesZone.."> x<"..x.."> y<"..y.."> t<"..name.."> i1<"
				..infoOne.."> i2<"..infoTwo.."> cr<"..METAKB_AUTHOR.."> i<"..icon
				.."> tf<"..nameColor.."> i1f<"..infoOneColor.."> i2f<"..infoTwoColor..">";
	else
		assert(false, "nil or invalid parameter to CreateMapNotesMessage!");
	end
end

function MetaKB_RemoveNamesWithNoZones()
	for name,zoneTable in MetaKB_Data do
		local zoneCount = 0;
		for zone in zoneTable do
			zoneCount = zoneCount + 1;
		end
		if zoneCount == 0 then
			MetaKB_Data[name] = nil;
		end
	end
end

function MetaKB_ToggleShowOnlyLocalNPCs()
	MetaMapOptions.ShowOnlyLocalNPCs = not MetaMapOptions.ShowOnlyLocalNPCs;
	if MetaMapOptions.ShowOnlyLocalNPCs then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	MetaKB_Search();
end

function MetaKB_ToggleAutoTrack()
	MetaMapOptions.AutoTrack = not MetaMapOptions.AutoTrack;
	if(MetaMapOptions.AutoTrack) then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function MetaKB_OnEnter(header, anchor, wrap, ...)
	assert(header ~= nil and anchor ~= nil and wrap ~= nil, "ERROR: nil arguments passed to MetaKB_OnEnter!");
	local myArgs = { unpack(arg) };
	assert(table.getn(myArgs) < 30, "ERROR: too many arguments passed to MetaKB_OnEnter!");

	MetaKB_Tooltip:ClearLines();
	local xOffset, yOffset;
	if string.find(anchor, "TOP") ~= nil then
		yOffset = -5;
	elseif string.find(anchor, "BOTTOM") ~= nil then
		yOffset = 5;
	end

	if string.find(anchor, "RIGHT") ~= nil then
		xOffset = -5;
	elseif string.find(anchor, "LEFT") ~= nil then
		xOffset = 5;
	end

	MetaKB_Tooltip:SetOwner(this, anchor, xOffset, yOffset);
	MetaKB_Tooltip:SetText(header, 0.2, 0.5, 1, 1);
	for i,string in myArgs do
		MetaKB_Tooltip:AddLine(string, 1, 1, 1, MetaMapOptions.TooltipWrap);
	end
	MetaKB_Tooltip:Show();
end

function MetaKB_OptionsFrameInit()
	MetaKB_ShowOnlyLocalNPCsCheckButton:SetChecked(MetaMapOptions.ShowOnlyLocalNPCs);
	MetaKB_ShowUpdatesCheckButton:SetChecked(MetaMapOptions.ShowUpdates);
	MetaKB_BoundingBoxCheckButton:SetChecked(MetaMapOptions.CreateMapNotesBoundingBox);
	MetaKB_AutoTrackingCheckButton:SetChecked(MetaMapOptions.AutoTrack);
	MetaKB_UseKBCheckButton:SetChecked(MetaMapOptions.KBstate);
	MetaKB_SetTargetNoteCheckButton:SetChecked(MetaMapOptions.NewTargetNote);
	MetaKB_ToggleSetRange(MetaMapOptions.RangeCheck)
end


function MetaKB_ToggleShowUpdates()
	MetaMapOptions.ShowUpdates = not MetaMapOptions.ShowUpdates

	if MetaMapOptions.ShowUpdates then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function MetaKB_ToggleDbase()
	MetaMapOptions.KBstate = not MetaMapOptions.KBstate;

	if MetaMapOptions.KBstate then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function MetaKB_ToggleSetNote()
	MetaMapOptions.NewTargetNote = not MetaMapOptions.NewTargetNote

	if MetaMapOptions.NewTargetNote then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function MetaKB_ToggleBoundingBox()
	MetaMapOptions.CreateMapNotesBoundingBox = not MetaMapOptions.CreateMapNotesBoundingBox;

	if MetaMapOptions.CreateMapNotesBoundingBox then
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
end

function Import_MetaMapData()
	MetaMapNotes_Data[0] = {};
	for index, data in MetaMap_NoteData[0] do
		MetaMapNotes_Data[0][index] = data;
	end
	MetaMap_StatusPrint("Default POI data converted to user notes.", true);
end

function Import_MapNotes()
	for z=1, 2, 1 do
		for index, value in MapNotes_Data[z] do
			MetaMapNotes_Data[z][index] = value;
		end
		for index, value in MapNotes_Lines[z] do
			MetaMapNotes_Lines[z][index] = value;
		end
	end
	MetaMap_StatusPrint("MapNotes data imported into MetaMap.", true);
end

function Import_WoWKB()
	for i in WoWKB_Data do
		MetaKB_Data[i] = WoWKB_Data[i];
	end
end

function MetaKB_UpdateDB()
	local KB_TempData = {};
	for index in MetaKB_Data do
		local newname = nil;
		for i in MetaKB_Data[index] do
			if(not MetaKB_Data[index][i]["inf1"]) then
				local found = string.find(index, "(", 1, true);
				if(found) then
					newname = string.sub(index, 1, string.find(index, "(", 1, true) -2);
					local info = string.sub(index, string.find(index, "(", 1, true) +1, -2);
					KB_TempData[newname] = {};
					KB_TempData[newname][i] = {};
					KB_TempData[newname][i]["inf1"] = info;
					KB_TempData[newname][i]["inf2"] = "";
					KB_TempData[newname][i]["icon"] = 3;
					KB_TempData[newname][i][1] = MetaKB_Data[index][i][1];
					KB_TempData[newname][i][2] = MetaKB_Data[index][i][2];
					KB_TempData[newname][i][3] = MetaKB_Data[index][i][3];
					KB_TempData[newname][i][4] = MetaKB_Data[index][i][4];
				else
					MetaKB_Data[index][i]["inf1"] = "";
				end
			end
			if(not MetaKB_Data[index][i]["inf2"]) then
				MetaKB_Data[index][i]["inf2"] = "";
			end
			if(not MetaKB_Data[index][i]["icon"]) then
				MetaKB_Data[index][i]["icon"] = 3;
			end
		end
		if(newname) then
			MetaKB_Data[index] = nil;
		end
	end
	for i in KB_TempData do
		MetaKB_Data[i] = KB_TempData[i];
	end
end

function MetaKB_ImportFile()
	if(MyKB_Data == nil) then
		MetaMap_StatusPrint("No valid database found for import!", true);
		return;
	end
	local MetaKB_TempData = {};
	local dupe = false;
	for import in MyKB_Data do
		for zone in MyKB_Data[import] do
			for name in MetaKB_Data do
				if(name == import) then
					dupe = true;
					break;
				end
			end
			if(not dupe) then
				MetaKB_TempData[import] = {};
				MetaKB_TempData[import][zone] = {};
				MetaKB_TempData[import][zone]["inf1"] = MyKB_Data[import][zone].inf1;
				MetaKB_TempData[import][zone]["inf2"] = MyKB_Data[import][zone].inf2;
				MetaKB_TempData[import][zone]["icon"] = MyKB_Data[import][zone].icon;
				MetaKB_TempData[import][zone][1] = MyKB_Data[import][zone][1];
				MetaKB_TempData[import][zone][2] = MyKB_Data[import][zone][2];
				MetaKB_TempData[import][zone][3] = MyKB_Data[import][zone][3];
				MetaKB_TempData[import][zone][4] = MyKB_Data[import][zone][4];
			end
			dupe = false;
		end
	end
	for index in MetaKB_TempData do
		MetaKB_Data[index] = MetaKB_TempData[index];
	end
	MetaMap_StatusPrint("MetaMap KB data successfully imported", true);
end

function MetaMap_DebugToggle()
	if(MetaMap_Debug) then
		MetaMap_Debug = false;
		MetaMap_DebugFrame:Hide();
		MetaMap_StatusPrint("MetaMap Debug mode is OFF", true);
	else
		MetaMap_Debug = true;
		if(WorldMapFrame:IsVisible()) then Zone_Debug(); end
		MetaMap_DebugFrame:Show();
		MetaMap_StatusPrint("MetaMap Debug mode is ON", true);
	end
end

function Zone_Debug()
	local continent = GetCurrentMapContinent();
	local zone;
	local realContinent, realZone;

	if continent == -1 then
		continent = "|cfff0B300Map Continent: |cffffffff"..-1;
		zone = "   |cfff0B300Map Zone: |cffffffff"..-1;
		realContinent = "|cfff0B300Real Continent: |cffffffff"..-1;
		realZone = "   |cfff0B300Real Zone: |cffffffff"..GetRealZoneText().." (-1)";
	else
		local xzone = MetaMapNotes_ZoneShift[continent][GetCurrentMapZone()];
		realContinent, realZone = MetaMapNotes_GetZone();
		zone = xzone;
		if(xzone > 0) then
			zone = "   |cfff0B300Map Zone: |cffffffff"..MetaMapNotes_ZoneNames[continent][xzone].." ("..xzone..")";
		else
			zone = "   |cfff0B300Map Zone: |cffffffffNo Zone ("..xzone..")";
		end
		continent = "|cfff0B300Map Continent: |cffffffff"..continent;
		realContinent = "|cfff0B300Real Continent: |cffffffff"..realContinent;
		realZone = "   |cfff0B300Real Zone: |cffffffff"..GetRealZoneText();
	end
	if(MetaMapFrame:IsVisible()) then
		continent = 0;
		zone = 0;
		continent = "|cfff0B300Map Continent: |cffffffff"..continent;
		zone = "   |cfff0B300Map Zone: |cffffffff"..MetaMap_Data[MetaMapOptions.MetaMapZone]["ZoneName"].." ("..zone..")";
	end

	MetaMapDebugText1:SetText(continent..zone);
	MetaMapDebugText2:SetText(realContinent..realZone);
	MetaMap_DebugFrame:SetWidth(WorldMapDetailFrame:GetWidth()-200);
end
----------------
-- Titan Support
----------------
function TitanPanelMetaMapButton_OnLoad()
	this.registry = { 
		id = TITAN_METAMAP_ID,
		version = METAMAP_VERSION,
		menuText = METAMAP_TITLE,
		category = METAMAP_CATEGORY,
		tooltipTitle = METAMAP_TITLE ,
		tooltipTextFunction = "TitanPanelMetaMapButton_GetTooltipText",
		frequency = TITAN_METAMAP_FREQUENCY, 
		icon = METAMAP_ICON,
		iconWidth = 16,
		savedVariables = {
		ShowIcon = 1,
		}
	};
end

function TitanPanelMetaMapButton_GetTooltipText()
	if(MetaMapOptions.MenuMode) then
		retText = METAMAP_BUTTON_TOOLTIP1.."\n"..METAMAP_BUTTON_TOOLTIP2;
		return retText;
	end
end

function TitalPanelMetaMapButton_OnClick(button)
	if ( button == "LeftButton" ) then
		MetaMainMap_Toggle();
	end
end

---------
-- CT_Mod
---------
if(IsAddOnLoaded("CT_MapMod")) then
	CT_CoordX:Hide();
	CT_CoordY:Hide();
	CT_NumNotes:SetPoint("TOPLEFT","WorldMapMagnifyingGlassButton","TOPLEFT",10,10);
	WorldMapFrameCreateNoteOnPlayer:SetPoint("RIGHT","WorldMapContinentDropDown","LEFT",-190,0);
end


function MasterModOptions_Toggle()
	if(CT_CPFrame:IsVisible()) then
		CT_CPFrame:Hide();
	else
		CT_CPFrame:SetFrameStrata("FULLSCREEN");
		CT_CPFrame:Show();
	end
end

-----------
-- FlightMap
-----------

function FlightMapOptions_Toggle()
	FlightMapOptionsFrame:SetFrameStrata("FULLSCREEN");
	if(FlightMapOptionsFrame:IsVisible()) then
		FlightMapOptionsFrame:Hide();
	else
		FlightMapOptionsFrame:Show();
	end
end

-----------
-- Gatherer
-----------
function GathererOptions_Toggle()
	GathererUI_DialogFrame:SetFrameStrata("FULLSCREEN");
	if(GathererUI_DialogFrame:IsVisible()) then
		HideUIPanel(GathererUI_DialogFrame);
	else
		ShowUIPanel(GathererUI_DialogFrame);
	end
end

function GathererSearch_Toggle()
	GathererInfo_DialogFrame:SetFrameStrata("FULLSCREEN");
	if(GathererInfo_DialogFrame:IsVisible()) then
		GathererInfo_DialogFrame:Hide();
	else
		GathererInfo_DialogFrame:Show();
	end
end

-----------
-- BetterWaypoints
-----------
function BWP_Toggle()
	BetterWaypointsOptionsForm:SetFrameStrata("FULLSCREEN");
	if(BetterWaypointsOptionsForm:IsVisible()) then
		BetterWaypointsOptionsForm:Hide();
	else
		BetterWaypointsOptionsForm:Show();
	end
end