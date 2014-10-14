--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005, 2006 Dan Gilbert
	Email me at loglow@gmail.com

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

--Atlas, an instance map browser
--Author: Dan Gilbert
--Email: loglow@gmail.com
--AIM: dan5981

ATLAS_VERSION = "1.8.5a |cFFFF8080PRE-TBC|r";

local Atlas_Vars_Loaded = nil;
ATLAS_DROPDOWN_LIST_EK = {};
ATLAS_DROPDOWN_LIST_KA = {};
ATLAS_DROPDOWN_LIST_BG = {};
ATLAS_DROPDOWN_LIST_FP = {};
ATLAS_DROPDOWN_LIST_DL = {};
ATLAS_DROPDOWN_LIST_RE = {};

local DefaultAtlasOptions = {
	["AtlasVersion"] = ATLAS_VERSION;
	["AtlasZone"] = 1;
	["AtlasAlpha"] = 1.0;
	["AtlasLocked"] = false;
	["AtlasMapName"] = true;
	["AtlasAutoSelect"] = false;
	["AtlasButtonPosition"] = 15;
	["AtlasButtonRadius"] = 78;
	["AtlasButtonShown"] = true;
	["AtlasReplaceWorldMap"] = false;
	["AtlasRightClick"] = false;
	["AtlasType"] = 1;
	["AtlasAcronyms"] = true;
	["AtlasScale"] = 1.0;
	["AtlasClamped"] = true;
};

function Atlas_FreshOptions()
	AtlasOptions = CloneTable(DefaultAtlasOptions);
end

--Code by Grayhoof (SCT)
function CloneTable(t)				-- return a copy of the table t
	local new = {};					-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then 
			v=CloneTable(v);
		end 
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end

--Called when the Atlas frame is first loaded
--We CANNOT assume that data in other files is available yet!
function Atlas_OnLoad()

	--Register the Atlas frame for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");

	--Allows Atlas to be closed with the Escape key
	tinsert(UISpecialFrames, "AtlasFrame");
	
	--Dragging involves some special registration
	AtlasFrame:RegisterForDrag("LeftButton");
	
	--Setting up slash commands involves referencing some strage auto-generated variables
	SLASH_ATLAS1 = ATLAS_SLASH;
	SlashCmdList["ATLAS"] = Atlas_SlashCommand;
end

--Removal of articles in map names (for proper alphabetic sorting)
--For example: "The Deadmines" will become "Deadmines"
--Thus it will be sorted under D and not under T
local function Atlas_SanitizeName(text)
   text = string.lower(text);
   if (AtlasSortIgnore) then
	   for _,v in pairs(AtlasSortIgnore) do
		   local match; 
           if ( string.gmatch ) then 
                match = string.gmatch(text, v)();
           else 
                match = string.gfind(text, v)(); 
           end
		   if (match) and ((string.len(text) - string.len(match)) <= 4) then
			   return match;
		   end
	   end
   end
   return text;
end

--Comparator function for alphabetic sorting of EK maps
local function Atlas_SortZonesAlphaEK(a, b)
	local aa = Atlas_SanitizeName(AtlasEK[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasEK[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of KA maps
local function Atlas_SortZonesAlphaKA(a, b)
	local aa = Atlas_SanitizeName(AtlasKalimdor[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasKalimdor[b].ZoneName);
	return aa < bb;
end


--Comparator function for alphabetic sorting of BG maps
local function Atlas_SortZonesAlphaBG(a, b)
	local aa = Atlas_SanitizeName(AtlasBG[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasBG[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of FP maps
local function Atlas_SortZonesAlphaFP(a, b)
	local aa = Atlas_SanitizeName(AtlasFP[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasFP[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of DL maps
local function Atlas_SortZonesAlphaDL(a, b)
	local aa = Atlas_SanitizeName(AtlasDL[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasDL[b].ZoneName);
	return aa < bb;
end

--Comparator function for alphabetic sorting of RE maps
local function Atlas_SortZonesAlphaRE(a, b)
	local aa = Atlas_SanitizeName(AtlasRE[a].ZoneName);
	local bb = Atlas_SanitizeName(AtlasRE[b].ZoneName);
	return aa < bb;
end

--These are the REAL level range values!
--Overrides the values that may be found in the localization files
function Atlas_UpdateLevelRanges()
	AtlasKalimdor.BlackfathomDeeps.LevelRange =		"24-32";
	AtlasKalimdor.WailingCaverns.LevelRange =		"17-24";
	AtlasKalimdor.DireMaulNorth.LevelRange =		"56-60";
	AtlasKalimdor.DireMaulEast.LevelRange =			"56-60";
	AtlasKalimdor.DireMaulWest.LevelRange =			"56-60";
	AtlasKalimdor.RazorfenDowns.LevelRange =		"37-46";
	AtlasKalimdor.RazorfenKraul.LevelRange =		"29-38";
	AtlasKalimdor.Maraudon.LevelRange =				"46-55";
	AtlasKalimdor.OnyxiasLair.LevelRange =			"60+";
	AtlasKalimdor.RagefireChasm.LevelRange =		"13-18";
	AtlasKalimdor.ZulFarrak.LevelRange =			"44-54";
	AtlasKalimdor.TheTempleofAhnQiraj.LevelRange =	"60+";
	AtlasKalimdor.TheRuinsofAhnQiraj.LevelRange =	"60+";

	AtlasEK.BlackrockSpireLower.LevelRange =		"55-60";
	AtlasEK.BlackrockSpireUpper.LevelRange =		"55-60";
	AtlasEK.BlackrockDepths.LevelRange =			"52-60";
	AtlasEK.ShadowfangKeep.LevelRange =				"22-30";
	AtlasEK.ScarletMonastery.LevelRange =			"34-45";
	AtlasEK.MoltenCore.LevelRange =					"60+";
	AtlasEK.TheSunkenTemple.LevelRange =			"50-60";
	AtlasEK.TheStockade.LevelRange =				"24-32";
	AtlasEK.TheDeadmines.LevelRange =				"17-26";
	AtlasEK.Gnomeregan.LevelRange =					"29-38";
	AtlasEK.BlackwingLair.LevelRange =				"60+";
	AtlasEK.Scholomance.LevelRange =				"58-60";
	AtlasEK.Stratholme.LevelRange =					"58-60";
	AtlasEK.Uldaman.LevelRange =					"41-51";
	AtlasEK.ZulGurub.LevelRange =					"60+";
	AtlasEK.Naxxramas.LevelRange =					"60+";
	
	AtlasBG.AlteracValleyNorth.LevelRange =			"51-60";
	AtlasBG.AlteracValleySouth.LevelRange =			"51-60";
	AtlasBG.ArathiBasin.LevelRange =				"20-60";
	AtlasBG.WarsongGulch.LevelRange =				"10-60";
	
	AtlasFP.FPAllianceEast.LevelRange =				"---";
	AtlasFP.FPAllianceWest.LevelRange =				"---";
	AtlasFP.FPHordeEast.LevelRange =				"---";
	AtlasFP.FPHordeWest.LevelRange =				"---";
	
	AtlasDL.DLEast.LevelRange =						"---";
	AtlasDL.DLWest.LevelRange =						"---";
	
	AtlasRE.Azuregos.LevelRange =					"60+";
	AtlasRE.FourDragons.LevelRange =				"60+";
	AtlasRE.Kazzak.LevelRange =						"60+";
end

--These are the REAL player limit values!
--Overrides the values that may be found in the localization files
function Atlas_UpdatePlayerLimits()
	AtlasKalimdor.BlackfathomDeeps.PlayerLimit =	"10";
	AtlasKalimdor.WailingCaverns.PlayerLimit =		"10";
	AtlasKalimdor.DireMaulNorth.PlayerLimit =		"5";
	AtlasKalimdor.DireMaulEast.PlayerLimit =		"5";
	AtlasKalimdor.DireMaulWest.PlayerLimit =		"5";
	AtlasKalimdor.RazorfenDowns.PlayerLimit =		"10";
	AtlasKalimdor.RazorfenKraul.PlayerLimit =		"10";
	AtlasKalimdor.Maraudon.PlayerLimit =			"10";
	AtlasKalimdor.OnyxiasLair.PlayerLimit =			"40";
	AtlasKalimdor.RagefireChasm.PlayerLimit =		"10";
	AtlasKalimdor.ZulFarrak.PlayerLimit =			"10";
	AtlasKalimdor.TheTempleofAhnQiraj.PlayerLimit =	"40";
	AtlasKalimdor.TheRuinsofAhnQiraj.PlayerLimit =	"20";
	
	AtlasEK.BlackrockSpireLower.PlayerLimit =		"10";
	AtlasEK.BlackrockSpireUpper.PlayerLimit =		"10";
	AtlasEK.BlackrockDepths.PlayerLimit =			"5";
	AtlasEK.ShadowfangKeep.PlayerLimit =			"10";
	AtlasEK.ScarletMonastery.PlayerLimit =			"10";
	AtlasEK.MoltenCore.PlayerLimit =				"40";
	AtlasEK.TheSunkenTemple.PlayerLimit =			"10";
	AtlasEK.TheStockade.PlayerLimit =				"10";
	AtlasEK.TheDeadmines.PlayerLimit =				"10";
	AtlasEK.BlackwingLair.PlayerLimit =				"40";
	AtlasEK.Scholomance.PlayerLimit =				"5";
	AtlasEK.Stratholme.PlayerLimit =				"5";
	AtlasEK.Uldaman.PlayerLimit =					"10";
	AtlasEK.ZulGurub.PlayerLimit =					"20";
	AtlasEK.Naxxramas.PlayerLimit =					"40";
	AtlasEK.Gnomeregan.PlayerLimit =				"10";
	
	AtlasBG.AlteracValleyNorth.PlayerLimit =		"40";
	AtlasBG.AlteracValleySouth.PlayerLimit =		"40";
	AtlasBG.ArathiBasin.PlayerLimit =				"15";
	AtlasBG.WarsongGulch.PlayerLimit =				"10";
	
	AtlasFP.FPAllianceEast.PlayerLimit =			"---";
	AtlasFP.FPAllianceWest.PlayerLimit =			"---";
	AtlasFP.FPHordeEast.PlayerLimit =				"---";
	AtlasFP.FPHordeWest.PlayerLimit =				"---";
	
	AtlasDL.DLEast.PlayerLimit =					"---";
	AtlasDL.DLWest.PlayerLimit =					"---";
	
	AtlasRE.Azuregos.PlayerLimit =					"40";
	AtlasRE.FourDragons.PlayerLimit =				"40";
	AtlasRE.Kazzak.PlayerLimit =					"40";
end

--Main Atlas event handler
function Atlas_OnEvent()

	if (event == "ADDON_LOADED") then
		if (strlower(arg1) == "atlas") then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	elseif (event == "VARIABLES_LOADED") then
		if (not Atlas_Vars_Loaded) then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	end
	
end

--Initializes everything relating to saved variables and data in other lua files
--This should be called ONLY when we're sure that all other files have been loaded
function Atlas_Init()

	if ( AtlasOptions == nil or AtlasOptions["AtlasVersion"] ~= ATLAS_VERSION) then
		Atlas_FreshOptions();
	end

	--Take all the maps listed in the localization files and import them into the dropdown list structure
    for k,v in pairs(AtlasEK) do table.insert(ATLAS_DROPDOWN_LIST_EK, k); end
    for k,v in pairs(AtlasKalimdor) do table.insert(ATLAS_DROPDOWN_LIST_KA, k); end
    for k,v in pairs(AtlasBG) do table.insert(ATLAS_DROPDOWN_LIST_BG, k); end
    for k,v in pairs(AtlasFP) do table.insert(ATLAS_DROPDOWN_LIST_FP, k); end
    for k,v in pairs(AtlasDL) do table.insert(ATLAS_DROPDOWN_LIST_DL, k); end
    for k,v in pairs(AtlasRE) do table.insert(ATLAS_DROPDOWN_LIST_RE, k); end

	--Update the level ranges and player limits
	--Overrides the values in the localization files because I'm too lazy to change them all
	--It's also nice to have all the these figures come from only one place
	Atlas_UpdateLevelRanges();
	Atlas_UpdatePlayerLimits();
	
	--Sort the lists of maps alphabetically
	table.sort(ATLAS_DROPDOWN_LIST_EK, Atlas_SortZonesAlphaEK);
	table.sort(ATLAS_DROPDOWN_LIST_KA, Atlas_SortZonesAlphaKA);
	table.sort(ATLAS_DROPDOWN_LIST_BG, Atlas_SortZonesAlphaBG);
	table.sort(ATLAS_DROPDOWN_LIST_FP, Atlas_SortZonesAlphaFP);
	table.sort(ATLAS_DROPDOWN_LIST_DL, Atlas_SortZonesAlphaDL);
	table.sort(ATLAS_DROPDOWN_LIST_RE, Atlas_SortZonesAlphaRE);
	
	--Now that saved variables have been loaded, update everything accordingly
	Atlas_Refresh();
	AtlasOptions_Init();
	Atlas_UpdateLock();
	AtlasButton_UpdatePosition();
	Atlas_UpdateAlpha();
	AtlasFrame:SetClampedToScreen(AtlasOptions.AtlasClamped);

	--Cosmos integration
	if(EarthFeature_AddButton) then
		EarthFeature_AddButton(
		{
			id = ATLAS_TITLE;
			name = ATLAS_TITLE;
			subtext = ATLAS_SUBTITLE;
			tooltip = ATLAS_DESC;
			icon = "Interface\\AddOns\\Atlas\\Images\\AtlasIcon";
			callback = Atlas_Toggle;
			test = nil;
		}
	);
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			ATLAS_DESC,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			Atlas_Toggle
		);
	end
	
	--CTMod integration
	if(CT_RegisterMod) then
		CT_RegisterMod(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			5,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			ATLAS_DESC,
			"switch",
			"",
			Atlas_Toggle
		);
	end
end

--Simple function to toggle the Atlas frame's lock status and update it's appearance
function Atlas_ToggleLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasOptions.AtlasLocked = false;
		Atlas_UpdateLock();
	else
		AtlasOptions.AtlasLocked = true;
		Atlas_UpdateLock();
	end
end

--Updates the appearance of the lock button based on the status of AtlasLocked
function Atlas_UpdateLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down");
	else
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down");
	end
end

--Begin moving the Atlas frame if it's unlocked
function Atlas_StartMoving()
	if(not AtlasOptions.AtlasLocked) then
		AtlasFrame:StartMoving();
	end
end

--Parses slash commands
--If an unrecognized command is given, toggle Atlas
function Atlas_SlashCommand(msg)
	if(msg == ATLAS_SLASH_OPTIONS) then
		AtlasOptions_Toggle();
	else
		Atlas_Toggle();
	end
end

--Sets the transparency of the Atlas frame based on AtlasAlpha
function Atlas_UpdateAlpha()
	AtlasFrame:SetAlpha(AtlasOptions.AtlasAlpha);
end

--Sets the scale of the Atlas frame based on AtlasScale
function Atlas_UpdateScale()
	AtlasFrame:SetScale(AtlasOptions.AtlasScale);
end

--Simple function to toggle the visibility of the Atlas frame
function Atlas_Toggle()
	if(AtlasFrame:IsVisible()) then
		HideUIPanel(AtlasFrame);
	else
		ShowUIPanel(AtlasFrame);
	end
end

--Refreshes the Atlas frame, usually because a new map needs to be displayed
--The zoneID variable represents the internal name used for each map
--Also responsible for updating all the text when a map is changed
function Atlas_Refresh()
	local zoneID;
	local textSource;
	
	--Just in case AtlasType hasn't been initialized
	--Added in response to a possible error
	if ( AtlasOptions.AtlasType == nil ) then
		AtlasOptions.AtlasType = 1;
	end
	
	if ( AtlasOptions.AtlasType == 1 ) then
		zoneID = ATLAS_DROPDOWN_LIST_EK[AtlasOptions.AtlasZone];
		textSource = AtlasEK;
	elseif ( AtlasOptions.AtlasType == 2 ) then
		zoneID = ATLAS_DROPDOWN_LIST_KA[AtlasOptions.AtlasZone];
		textSource = AtlasKalimdor;
	elseif ( AtlasOptions.AtlasType == 3 ) then
		zoneID = ATLAS_DROPDOWN_LIST_BG[AtlasOptions.AtlasZone];
		textSource = AtlasBG;
	elseif ( AtlasOptions.AtlasType == 4 ) then
		zoneID = ATLAS_DROPDOWN_LIST_FP[AtlasOptions.AtlasZone];
		textSource = AtlasFP;
	elseif ( AtlasOptions.AtlasType == 5 ) then
		zoneID = ATLAS_DROPDOWN_LIST_DL[AtlasOptions.AtlasZone];
		textSource = AtlasDL;
	elseif ( AtlasOptions.AtlasType == 6 ) then
		zoneID = ATLAS_DROPDOWN_LIST_RE[AtlasOptions.AtlasZone];
		textSource = AtlasRE;
	end
	AtlasMap:ClearAllPoints();
	AtlasMap:SetWidth(512);
	AtlasMap:SetHeight(512);
	AtlasMap:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", 18, -84);
	AtlasMap:SetTexture("Interface\\AddOns\\Atlas\\Images\\"..zoneID);
	local ZoneNameText = textSource[zoneID]["ZoneName"];
	if ( AtlasOptions.AtlasAcronyms and textSource[zoneID]["Acronym"] ~= nil) then
		local _RED = "|cffcc6666";
		ZoneNameText = ZoneNameText.._RED.." ["..textSource[zoneID]["Acronym"].."]";
	end
	AtlasText_ZoneName:SetText(ZoneNameText);
	AtlasText_Location:SetText(ATLAS_STRING_LOCATION..": "..textSource[zoneID]["Location"]);
	AtlasText_LevelRange:SetText(ATLAS_STRING_LEVELRANGE..": "..textSource[zoneID]["LevelRange"]);
	AtlasText_PlayerLimit:SetText(ATLAS_STRING_PLAYERLIMIT..": "..textSource[zoneID]["PlayerLimit"]);
	for i = 1, 27, 1 do
		getglobal("AtlasText_"..i):SetText(textSource[zoneID][i]);
	end
end

--Function used to initialize the map type dropdown menu
--Cycle through Atlas_MapTypes to populate the dropdown
function AtlasFrameDropDownType_Initialize()
	local info;
	for i = 1, getn(Atlas_MapTypes), 1 do
		info = {
			text = Atlas_MapTypes[i];
			func = AtlasFrameDropDownType_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDownType, AtlasFrameDropDownType_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, AtlasOptions.AtlasType);
	UIDropDownMenu_SetWidth(190, AtlasFrameDropDownType);
end

--Called whenever an item in the map type dropdown menu is clicked
--Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, i);
	AtlasOptions.AtlasType = i;
	AtlasOptions.AtlasZone = 1;
	AtlasFrameDropDown_OnShow();
	Atlas_Refresh();
end

--Function used to initialize the main dropdown menu
--Looks at the status of AtlasType to determine how to populate the list
function AtlasFrameDropDown_Initialize()
	if ( AtlasOptions.AtlasType == 1 ) then
		AtlasFrameDropDown_Populate(AtlasEK, ATLAS_DROPDOWN_LIST_EK);
	elseif ( AtlasOptions.AtlasType == 2 ) then
		AtlasFrameDropDown_Populate(AtlasKalimdor, ATLAS_DROPDOWN_LIST_KA);
	elseif ( AtlasOptions.AtlasType == 3 ) then
		AtlasFrameDropDown_Populate(AtlasBG, ATLAS_DROPDOWN_LIST_BG);
	elseif ( AtlasOptions.AtlasType == 4 ) then
		AtlasFrameDropDown_Populate(AtlasFP, ATLAS_DROPDOWN_LIST_FP);
	elseif ( AtlasOptions.AtlasType == 5 ) then
		AtlasFrameDropDown_Populate(AtlasDL, ATLAS_DROPDOWN_LIST_DL);
	elseif ( AtlasOptions.AtlasType == 6 ) then
		AtlasFrameDropDown_Populate(AtlasRE, ATLAS_DROPDOWN_LIST_RE);
	end
end

--Populates the main dropdown menu based on the arguments given
--mapType is the name used in the localization files for the category of map
--dropList is the (hopefully) sorted list made from one of those categories
function AtlasFrameDropDown_Populate(mapType, dropList)
	local info;
	for i = 1, getn(dropList), 1 do
		info = {
			text = mapType[dropList[i]]["ZoneName"];
			func = AtlasFrameDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDown, AtlasFrameDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, AtlasOptions.AtlasZone);
	UIDropDownMenu_SetWidth(190, AtlasFrameDropDown);
end

--Called whenever an item in the main dropdown menu is clicked
--Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
	AtlasOptions.AtlasZone = i;
	Atlas_Refresh();
end

--Modifies the value of GetRealZoneText to account for some naming conventions
--Always use this function instead of GetRealZoneText within Atlas
function Atlas_GetFixedZoneText()
   local currentZone = GetRealZoneText();
   if (AtlasZoneSubstitutions[currentZone]) then
      return AtlasZoneSubstitutions[currentZone];
   end
   return currentZone;
end 

--Checks the player's current location against all Atlas maps
--If a match is found display that map right away
function Atlas_AutoSelect()
	local currentZone = Atlas_GetFixedZoneText();
	
	
	--god, there MUST be a better way to do this. This makes me sick
	-------------------------------
	local currentType = UIDropDownMenu_GetSelectedID(AtlasFrameDropDownType);
	local currentDB, currentDD;
	if currentType == 1 then
		currentDB = AtlasEK;
		currentDD = ATLAS_DROPDOWN_LIST_EK;
	elseif currentType == 2 then
		currentDB = AtlasKalimdor;
		currentDD = ATLAS_DROPDOWN_LIST_KA;
	else
		return;
	end
	local currentMap = currentDB[currentDD[AtlasOptions.AtlasZone]]["ZoneName"];
	----------------------------------
	
	
	if(currentZone ~= currentMap) then
		for i = 1, getn(ATLAS_DROPDOWN_LIST_EK), 1 do
			local mapName = AtlasEK[ATLAS_DROPDOWN_LIST_EK[i]]["ZoneName"];
			if(currentZone == mapName) then
				AtlasOptions.AtlasType = 1;
				AtlasOptions.AtlasZone = i;
				UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
				Atlas_Refresh();
				return;
			end
		end
		for i = 1, getn(ATLAS_DROPDOWN_LIST_KA), 1 do
			local mapName = AtlasKalimdor[ATLAS_DROPDOWN_LIST_KA[i]]["ZoneName"];
			if(currentZone == mapName) then
				AtlasOptions.AtlasType = 2;
				AtlasOptions.AtlasZone = i;
				UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
				Atlas_Refresh();
				return;
			end
		end
	end
end

--Called whenever the Atlas frame is displayed
function Atlas_OnShow()
	if(AtlasOptions.AtlasAutoSelect) then
		Atlas_AutoSelect();
	end
end

--Checks to see if the World Map should be replaced by Atlas or not
--Is the feature turned on? Is the player in an instance?
function Atlas_ReplaceWorldMap()
	if(AtlasOptions.AtlasReplaceWorldMap) then
		local currentZone = Atlas_GetFixedZoneText();
		for i = 1, getn(ATLAS_DROPDOWN_LIST_EK), 1 do
			local mapName = AtlasEK[ATLAS_DROPDOWN_LIST_EK[i]]["ZoneName"];
			if(currentZone == mapName) then
				return true;
			end
		end
		for i = 1, getn(ATLAS_DROPDOWN_LIST_KA), 1 do
			local mapName = AtlasKalimdor[ATLAS_DROPDOWN_LIST_KA[i]]["ZoneName"];
			if(currentZone == mapName) then
				return true;
			end
		end
	end
	return false;
end

--Replaces the default ToggleWorldMap function
local oldToggleWorldMap = ToggleWorldMap;
function ToggleWorldMap()
	if (not WorldMapFrame:IsVisible() and Atlas_ReplaceWorldMap()) then
		Atlas_Toggle();
	else
		SetupFullscreenScale(WorldMapFrame);
		oldToggleWorldMap();
	end
end

--Code provided by tyroney
--Bugfix code by Cold
--Runs when the Atlas frame is clicked on
--RightButton closes Atlas and open the World Map if the RightClick option is turned on
function Atlas_OnClick()
	if ( arg1 == "RightButton" ) then
		if (AtlasOptions.AtlasRightClick) then
			local OldAtlasOptReplWMap = AtlasOptions.AtlasReplaceWorldMap;
			AtlasOptions.AtlasReplaceWorldMap = false;
			Atlas_Toggle();
			ToggleWorldMap();
			AtlasOptions.AtlasReplaceWorldMap = OldAtlasOptReplWMap;
		end
	end
end
