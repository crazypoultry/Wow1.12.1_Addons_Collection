-- MetaMapWKB
-- Written by MetaHawk - aka Urshurak

MetaKB_dbID = "db1.1";
METAKB_AUTHOR = "MetaMapWKB";

METAKB_SCROLL_FRAME_BUTTON_HEIGHT = 22;
METAKB_SCROLL_FRAME_BUTTONS_SHOWN = 24;
METAKB_SORTBY_NAME = "name";
METAKB_SORTBY_DESC = "desc";
METAKB_SORTBY_LEVEL = "level";
METAKB_SORTBY_LOCATION = "location";

MetaKB_Data = {};
MetaKB_Data[MetaKB_dbID] = {};
MetaKBOptions = {};
MetaKB_List = {};

MetaKB_Default = {
	["ShowUpdates"]   = false,
	["BoundingBox"]   = false,
	["AutoTrack"]     = false,
	["KBstate"]       = false,
	["NewTargetNote"] = false,
	["SetMapShow"]    = false,
	["Dsearch"]       = true,
	["RangeCheck"]    = 1,
}

MetaKB_overRide = false;
MetaKB_ShowAllZones = false;
MetaKB_ScrollFrameButtonID = 0;
MetaKB_VarsLoaded = false;

local MetaKB_LastSearch = "";
local MetaKB_SearchResults = {};
local MetaKB_PlayerX = 0;
local MetaKB_PlayerY = 0;

function MetaKB_EventFrame_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("UPDATE_MOUSEOVER_UNIT");
end
function MetaKB_OnEvent(event)
	if(event == "ADDON_LOADED" and arg1 == "MetaMapWKB") then
		for option, value in pairs(MetaKB_Default) do
			if(MetaKBOptions[option] == nil) then MetaKBOptions[option] = value; end
		end
		MetaKB_ToggleSetRange(MetaKBOptions.RangeCheck);
		MetaMapWKB_VerifyData();
	end
	if(event == "INSTANCE_MAP_UPDATE" and WorldMapFrame:IsVisible()) then
		if(MetaKB_DisplayFrame:IsVisible() and not MetaKB_ShowAllZones) then
			MetaKB_Search();
		end
	end
	if(event == "WORLD_MAP_UPDATE" and WorldMapFrame:IsVisible()) then
		if(MetaKB_DisplayFrame:IsVisible() and not MetaKB_ShowAllZones) then
			MetaKB_Search();
		end
	end
	if(event == "ZONE_CHANGED_NEW_AREA") then
		if(MetaKB_DisplayFrame:IsVisible() and not MetaKB_ShowAllZones) then
			MetaKB_Search();
		end
	end
	if(event == "UPDATE_MOUSEOVER_UNIT" and MetaKBOptions.AutoTrack) then
		if(UnitIsPlayer("mouseover")~=1 and UnitPlayerControlled("mouseover")~=1 and UnitIsDead("mouseover")~=1) then
			MetaKB_AddUnitInfo("mouseover");
		end
	end
end

function MetaKB_InitFrame()
	MetaKB_Header1:SetWidth(MetaKB_HeaderPanel:GetWidth()*0.26);
	MetaKB_Header2:SetWidth(MetaKB_HeaderPanel:GetWidth()*0.38);
	MetaKB_Header3:SetWidth(MetaKB_HeaderPanel:GetWidth()*0.16);
	MetaKB_Header4:SetWidth(MetaKB_HeaderPanel:GetWidth()*0.20);
	for i=1, METAKB_SCROLL_FRAME_BUTTONS_SHOWN,1 do
		getglobal("MetaKB_ScrollFrameButton"..i):SetWidth(MetaKB_HeaderPanel:GetWidth());
		getglobal("MetaKB_ScrollFrameButton"..i.."Name"):SetWidth(MetaKB_Header1:GetWidth());
		getglobal("MetaKB_ScrollFrameButton"..i.."Info1"):SetWidth(MetaKB_Header2:GetWidth());
		getglobal("MetaKB_ScrollFrameButton"..i.."Info2"):SetWidth(MetaKB_Header3:GetWidth());
		getglobal("MetaKB_ScrollFrameButton"..i.."Coords"):SetWidth(MetaKB_Header4:GetWidth());
	end
end

function MetaMapWKB_VerifyData()
	local TempData = {}
	TempData[MetaKB_dbID] = {};
	for name, continentTable in pairs(MetaKB_Data[MetaKB_dbID]) do
		for continent, zoneTable in pairs(continentTable) do
			if(type(continent) ~= "String") then
				for zone, value in pairs(zoneTable) do
					if(zone ~= 0) then
						TempData[MetaKB_dbID][name] = {};
						TempData[MetaKB_dbID][name][continent] = {};
						TempData[MetaKB_dbID][name][continent][zone] = {};
						TempData[MetaKB_dbID][name][continent][zone] = value;
					end
				end
			end
		end
	end
	MetaKB_Data = {};
	MetaKB_Data[MetaKB_dbID] = {};
	MetaKB_Data[MetaKB_dbID] = TempData[MetaKB_dbID];
	TempData = nil;
end

function MetaKB_ToggleFrame(mode)
	if(MetaKB_DisplayFrame:IsVisible()) then
		MetaMapContainer_ShowFrame();
		if(mode == 1) then
			MetaMap_ToggleFrame(WorldMapFrame);
		end
	else
		if(not WorldMapFrame:IsVisible()) then
			MetaMap_ToggleFrame(WorldMapFrame);
		end
		MetaMapContainer_ShowFrame(MetaKB_DisplayFrame);
	end
end

function MetaKB_StripTextColors(textString)
	-- this function is designed to replace
	-- |cff00AA00Colored Text|r with Colored Text
	if(textString ~= nil and textString ~= "") then
		return string.gsub(textString, "|c[%dA-Fa-f][%dA-Fa-f][%dA-Fa-f][%dA-Fa-f][%dA-Fa-f]"..
				"[%dA-Fa-f][%dA-Fa-f][%dA-Fa-f](.*)|r", "%1");
	else
		assert(false, "nil or invalid parameter to StripTextColors");
	end
end

function MetaKB_ToggleSetRange(range)
	for i=1, 5 do
		local checkButton = getglobal("MetaKB_RangeCheck_"..i);
		if(i == tonumber(range)) then
			checkButton:SetChecked(true);
		else
			checkButton:SetChecked(false);
		end
	end
	MetaKBOptions.RangeCheck = range;
end

function MetaKB_UpdateKeySelectedUnit()
	if (not UnitExists("target")) then
		MetaMap_StatusPrint(METAKB_NOTARGET,MetaKBOptions.ShowUpdates);
		return;
	else
		if(IsControlKeyDown()) then
			MetaKB_overRide = true;
		end
		MetaKB_AddUnitInfo("target");
			MetaKB_overRide = false;
	end
end

function MetaKB_AddUnitInfo(UnitSelect)
	if( not CheckInteractDistance(UnitSelect, MetaKBOptions.RangeCheck) and MetaKBOptions.RangeCheck ~= 5) then
		return;
	end
	local continent, zone = MetaMap_NameToZoneID(GetRealZoneText());
	if(type(continent) == "string") then
		MetaMap_StatusPrint(METAMAPNOTES_INVALIDZONE, MetaKBOptions.ShowUpdates);
		return;
	end
	local icon = 3; --green by default
	local unitName = UnitName(UnitSelect);
	local ncol = 0;
	local desc1 = "";
	local desc2 = "";
	local playerX, playerY = GetPlayerMapPosition("player")

	playerX = MetaMap_round(playerX*10000)
	playerY = MetaMap_round(playerY*10000)
	unitName = MetaKB_StripTextColors(unitName);

	if(UnitReaction("player", UnitSelect) < 4) then
		if(UnitClassification(UnitSelect) ~= "normal") then
			desc1 = UnitClassification(UnitSelect).." ";
		end
		if(UnitCreatureType(UnitSelect) ~= nil) then
			desc1 = desc1..UnitCreatureType(UnitSelect).." "
		end
		if(UnitClass(UnitSelect) ~= nil) then
			desc1 = desc1..UnitClass(UnitSelect);
		end
		if(UnitLevel(UnitSelect) == "-1") then
			desc2 = METAKB_MOB_LEVEL.." ??";
		else
			desc2 = METAKB_MOB_LEVEL.." "..UnitLevel(UnitSelect);
		end
		icon = 1;
	elseif(UnitReaction("player", UnitSelect) == 4) then
		if(GameTooltipTextLeft2:GetText() ~= nil) then
			desc1 = string.sub(GameTooltipTextLeft2:GetText(), 9);
		end
		desc2 = METAKB_MOB_LEVEL.." "..UnitLevel(UnitSelect);
		icon = 0;
	elseif(UnitReaction("player", UnitSelect) > 4 and UnitIsPlayer(UnitSelect)) then
		unitName = UnitPVPName(UnitSelect);
		desc1 = UnitRace(UnitSelect).." "..UnitClass(UnitSelect);
		desc2 = METAKB_MOB_LEVEL.." "..UnitLevel(UnitSelect);
		icon = 7;
	elseif(UnitReaction("player", UnitSelect) < 4 and UnitIsPlayer(UnitSelect)) then
		unitName = UnitPVPName(UnitSelect);
		desc1 = UnitRace(UnitSelect).." "..UnitClass(UnitSelect);
		desc2 = METAKB_MOB_LEVEL.." "..UnitLevel(UnitSelect);
		icon = 6;
	else
		local check = GameTooltipTextLeft2:GetText();
		if (check ~= nil) then
			if(string.find(check, METAKB_MOB_LEVEL)) then
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
		icon = 3;
	end
	if(desc1 == nil) then desc1 = ""; end
	if(desc2 == nil) then desc2 = ""; end

	local changedSomething = false;
	local addedSomething = false;
	local updatedSomething = false;
	local currentUnit;

	if(MetaKB_Data[MetaKB_dbID][unitName] == nil) then
		MetaKB_Data[MetaKB_dbID][unitName] = {};
		MetaMap_StatusPrint(format(TEXT(METAKB_DISCOVERED_UNIT), unitName), true);
	end
	currentUnit = MetaKB_Data[MetaKB_dbID][unitName];
	if(currentUnit[continent] == nil) then
		currentUnit[continent] = {};
	end
	if(currentUnit[continent][zone] == nil) then
		currentUnit[continent][zone] = {};
		currentUnit[continent][zone]["inf1"] = desc1;
		currentUnit[continent][zone]["inf2"] = desc2;
		currentUnit[continent][zone]["icon"] = icon;
		currentUnit[continent][zone][1] = 20000;
		currentUnit[continent][zone][2] = -1;
		currentUnit[continent][zone][3] = -1;
		currentUnit[continent][zone][4] = 20000;
		addedSomething = true
	else
		currentUnit[continent][zone]["icon"] = icon;
		if(currentUnit[continent][zone]["inf1"] == "") then
			currentUnit[continent][zone]["inf1"] = desc1;
			updatedSomething = true;
		end
		if(currentUnit[continent][zone]["inf2"] == "") then
			currentUnit[continent][zone]["inf2"] = desc2;
			updatedSomething = true;
		end
	end		

	local coords = currentUnit[continent][zone];

	if(playerX < coords[4]) then
		currentUnit[continent][zone][4] = playerX;
		changedSomething = true;
	end
	if(playerY < coords[1]) then
		currentUnit[continent][zone][1] = playerY;
		changedSomething = true;
	end
	if(playerX > coords[2]) then
		currentUnit[continent][zone][2] = playerX;
		changedSomething = true;
	end
	if(playerY > coords[3]) then
		currentUnit[continent][zone][3] = playerY;
		changedSomething = true;
	end

	if(MetaKBOptions.NewTargetNote or MetaKB_overRide) then
		MetaKB_AddMapNotes(unitName, GetRealZoneText(), 0);
	end
	if(MetaKBOptions.KBstate) then
		if(addedSomething) then
			MetaMap_StatusPrint(format(TEXT(METAKB_ADDED_UNIT_IN_ZONE), unitName, GetRealZoneText()), MetaKBOptions.ShowUpdates);
		end
		if(changedSomething and not addedSomething) then
			MetaMap_StatusPrint(format(TEXT(METAKB_UPDATED_MINMAX_XY), unitName, GetRealZoneText()), MetaKBOptions.ShowUpdates);
		end
		if(updatedSomething) then
			MetaMap_StatusPrint(format(TEXT(METAKB_UPDATED_INFO), unitName, GetRealZoneText()), MetaKBOptions.ShowUpdates);
		end
	else
		currentUnit = nil;
	end
end

function MetaKB_Search(searchText, suppressErrors)
	if(searchText == nil) then searchText = MetaKB_LastSearch; end
	if(suppressErrors == nil) then suppressErrors = false; end
	MetaKB_LastSearch = searchText;
	MetaKB_PlayerX, MetaKB_PlayerY = GetPlayerMapPosition("player");
	MetaKB_PlayerX = MetaMap_round(MetaKB_PlayerX * 100);
	MetaKB_PlayerY = MetaMap_round(MetaKB_PlayerY * 100);
	FauxScrollFrame_SetOffset(MetaKB_ScrollFrame, 0);
	MetaKB_BuildSearchResults();
	MetaKB_UpdateScrollFrame();
	MetaKB_SearchBox:SetText(MetaKB_LastSearch);
end

function MetaKB_BuildSearchResults()
	MetaKB_SearchResults = {};
	local nameCount = 0;
	local zoneCount = 0;
	local tempZones = {};
	local currentContinent, currentZone, _, mapName = MetaMap_GetCurrentMapInfo();

	for name, continentTable in pairs(MetaKB_Data[MetaKB_dbID]) do
		for continent, zoneTable in pairs(continentTable) do
			for zone in pairs(zoneTable) do
				local cCode = 1;
				local showAll = false;
				local coordString = "";
				if(mapName == "World" and continent ~= 0) then showAll = true; end
				for index, name in pairs(MetaMap_Continents) do
					if(continent == currentContinent and mapName == name) then showAll = true; end
				end
				if(continent == currentContinent and zone == currentZone or MetaKB_ShowAllZones or showAll) then
					local zoneName = MetaMap_ZoneNames[continent][zone];
					local selectedData = MetaKB_Data[MetaKB_dbID][name][continent][zone];
					local inf1 = selectedData["inf1"];
					local inf2 = selectedData["inf2"];
					local ncol = selectedData["icon"];
					if(ncol == 1) then ncol = 2;
					elseif(ncol == 2) then ncol = 6;
					elseif(ncol == 3) then ncol = 4;
					elseif(ncol == 6) then ncol = 1; end
					if(zoneName ~= GetRealZoneText() or continent == 0) then
						coordString = zoneName;
					else
						coordString, cCode = MetaKB_FormatCoords(selectedData);
					end
					if(string.find(string.lower(name),string.lower(MetaKB_LastSearch),1,true)~=nil
						or string.find(string.lower(inf1),string.lower(MetaKB_LastSearch),1,true)~=nil
						or string.find(string.lower(inf2),string.lower(MetaKB_LastSearch),1,true)~=nil
						or string.find(string.lower(coordString),string.lower(MetaKB_LastSearch),1,true)~=nil) then
						tinsert(MetaKB_SearchResults, {name = name, zoneName = zoneName, desc = inf1, level = inf2, ncol = ncol, location = coordString, cCode = cCode});
						nameCount = nameCount + 1;
						if(tempZones[zoneName] == nil and zoneName ~= nil) then
							zoneCount = zoneCount + 1;
							tempZones[zoneName] = 1;
						end
					end
				end
			end
		end
	end
	MetaKB_HeaderText:SetText(mapName);
	MetaKB_InfoText1:SetText("Found "..nameCount.." NPC/MoBs in "..zoneCount.." zones");
	MetaKB_SearchResults.onePastEnd = nameCount +1;
	MetaKBList_SortBy(MetaMap_sortType, MetaMap_sortDone)
end

function MetaKB_UpdateScrollFrame()
	for iScrollFrameButton = 1, METAKB_SCROLL_FRAME_BUTTONS_SHOWN, 1 do
		local buttonIndex = iScrollFrameButton + FauxScrollFrame_GetOffset(MetaKB_ScrollFrame);
		local scrollFrameButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton);
		local NameButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Name");
		local Info1Button = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Info1");
		local Info2Button = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Info2");
		local CoordsButton = getglobal("MetaKB_ScrollFrameButton"..iScrollFrameButton.."Coords");

		if(buttonIndex < MetaKB_SearchResults.onePastEnd) then
			if(MetaKB_SearchResults[buttonIndex]["zoneName"] == GetRealZoneText()) then
				-- Unit is in the same zone, show in yellow
				NameButton:SetText(MetaKB_SearchResults[buttonIndex]["name"]);
				Info1Button:SetText(MetaKB_SearchResults[buttonIndex]["desc"]);
				Info2Button:SetText(MetaKB_SearchResults[buttonIndex]["level"]);
				CoordsButton:SetText(MetaKB_SearchResults[buttonIndex]["location"]);
				if(MetaKB_SearchResults[buttonIndex]["cCode"] == 2) then
					CoordsButton:SetTextColor(0,1,0)
				else
					-- Unit is within range, show in green
					CoordsButton:SetTextColor(1,1,0)
				end
				scrollFrameButton:Show();
			else
					-- Unit is in a different zone, show in red
					NameButton:SetText(MetaKB_SearchResults[buttonIndex]["name"]);
					Info1Button:SetText(MetaKB_SearchResults[buttonIndex]["desc"]);
					Info2Button:SetText(MetaKB_SearchResults[buttonIndex]["level"]);
					CoordsButton:SetText(MetaKB_SearchResults[buttonIndex]["zoneName"]);
					CoordsButton:SetTextColor(1,0,0)
					scrollFrameButton:Show();
			end
			local ncol = MetaKB_SearchResults[buttonIndex]["ncol"];
			NameButton:SetTextColor(MetaMapNotes_Colors[ncol].r,MetaMapNotes_Colors[ncol].g,MetaMapNotes_Colors[ncol].b)
			Info1Button:SetTextColor(0.8,0.8,0.8)
			Info2Button:SetTextColor(0.5,0.5,0.8)
		else
			scrollFrameButton:Hide();
		end
	end
	FauxScrollFrame_Update(MetaKB_ScrollFrame, MetaKB_SearchResults.onePastEnd - 1,
        METAKB_SCROLL_FRAME_BUTTONS_SHOWN, METAKB_SCROLL_FRAME_BUTTON_HEIGHT)
end

function MetaKB_FormatCoords(dataSet, mode)
	local cleanCoords = {};
	local coordString = "";
	for i=1,4 do
		cleanCoords[i] = MetaMap_round(dataSet[i]/100, 0);
	end
	local dx = dataSet[2]/100 - dataSet[4]/100;
	local dy = dataSet[3]/100 - dataSet[1]/100;
	local centerx = dataSet[4]/100 + dx/2;
	local centery = dataSet[1]/100 + dy/2;
	-- truncate to two digits after the decimal again
	centerx = MetaMap_round(centerx, 0);
	centery = MetaMap_round(centery, 0);
	if(mode == nil) then
		if dx >= 3 or dy >= 3 then
		-- if the NPC has a range of 3 map units or greater, show ranges
			coordString = " ("..cleanCoords[4].."-"..cleanCoords[2].."),"..
 	                          " ("..cleanCoords[1].."-"..cleanCoords[3]..")"
		else
			-- otherwise just show an averaged point
			coordString = " ("..centerx..", "..centery..")"
		end
		if(centerx > (MetaKB_PlayerX +3) or centerx < (MetaKB_PlayerX -3) and centery > (MetaKB_PlayerY +3) or centery < (MetaKB_PlayerY -3)) then
			cCode = 1;
		else
			cCode = 2;
		end
		return coordString, cCode;
	elseif(mode == 1) then
		if(centerx == 0 and centery == 0) then
			centerx = 75;
			centery = 95;
		end
		centerx = centerx/100;
		centery = centery/100;
		return centerx, centery, dx, dy;
	end
	return centerx, centery;
end

function MetaKBList_SortBy(aSortType, aSortDone)
	MetaMap_sortType = aSortType;
	MetaMap_sortDone = aSortDone;
  table.sort(MetaKB_SearchResults, MetaMap_SortCriteria);
	if(not MetaMap_sortDone)then
		local count = MetaKB_SearchResults.onePastEnd;
		MetaKB_SearchResults = MetaMap_InvertList(MetaKB_SearchResults);
		MetaKB_SearchResults.onePastEnd = count;
	end
	MetaKB_UpdateScrollFrame();
end

function MetaKB_ScrollFrameButtonOnClick(button)
	if(button == "LeftButton") then
		MetaKB_ScrollFrameButtonID = this:GetID();
		local x, y = GetCursorPosition();
		x = x / UIParent:GetEffectiveScale();
		y = y / UIParent:GetEffectiveScale();
		MetaKBMenu:SetPoint("TOP", "UIParent", "BOTTOMLEFT", x , y +10);
		MetaKBMenu:Show();
	elseif(button == "RightButton") then
		if(IsControlKeyDown()) then
			MetaKBMenu_CRBSelect(this:GetID());
		elseif(IsShiftKeyDown()) then
			MetaKBMenu_SRBSelect(this:GetID());
		else
			MetaMap_LoadBWP(this:GetID(), 1);
		end
	end
end

function MetaKBMenu_Select(id)
	local name = getglobal("MetaKB_ScrollFrameButton"..MetaKB_ScrollFrameButtonID.."Name"):GetText();
	local zoneName = getglobal("MetaKB_ScrollFrameButton"..MetaKB_ScrollFrameButtonID.."Coords"):GetText();
	if(string.find(zoneName, "%(%d+\.?-?%d*%)?, %(?%d+\.?-?%d*%)")) then
		zoneName = GetRealZoneText();
	end
	local continent, zone = MetaMap_NameToZoneID(zoneName);
	local currentZone = MetaMapNotes_Data[continent][zone];
	local tUpdate = MetaKBOptions.ShowUpdates;

	if(id == 1) then
		MetaKBOptions.ShowUpdates = true;
		PlaySound("MapPing");
		MetaKB_AddMapNotes(name, zoneName, 0);
		MetaMapNotes_MapUpdate();
		PlaySound("igMiniMapClose");
	elseif(id == 2) then
		MetaKBOptions.ShowUpdates = true;
		PlaySound("MapPing");
		MetaKB_AddMapNotes(name, zoneName, 2);
		PlaySound("igMainMenuOption")
	elseif(id == 3) then
		MetaKBOptions.ShowUpdates = true;
		MetaMap_DeleteNotes(METAKB_AUTHOR, name);
	elseif(id == 4) then
		MetaKBOptions.ShowUpdates = true;
		PlaySound("igQuestLogAbandonQuest");
		MetaMap_DeleteNotes(METAKB_AUTHOR);
	elseif(id == 5) then
		MetaKB_Data[MetaKB_dbID][name] = nil;
		PlaySound("Deathbind Sound");
		MetaMap_StatusPrint(format(TEXT(METAKB_REMOVED_FROM_DATABASE), name, zoneName), true);
		MetaKB_Search(MetaKB_LastSearch, true);
	elseif(id == 6) then
			StaticPopupDialogs["Trim_Dbase"] = {
				text = TEXT(METAKB_TRIM_DBASE),
				button1 = TEXT(ACCEPT),
				button2 = TEXT(DECLINE),
				OnAccept = function()
					MetaKB_TrimDatabase();
				end,
				timeout = 60,
				showAlert = 1,
			};
			StaticPopup_Show("Trim_Dbase");
	elseif(id == 7 and ChatFrameEditBox:IsVisible()) then
		local selectedData = MetaKB_Data[MetaKB_dbID][name][continent][zone];
		local centerx, centery = MetaKB_FormatCoords(selectedData, 2)
		local mInfo = " "
		if(selectedData.inf1 ~= "") then mInfo = " ["..selectedData.inf1.."] "; end
		local coordString = centerx..", "..centery;
		ChatFrameEditBox:Insert(name..mInfo.."("..zoneName.." - "..coordString..")");
	elseif(id == 8) then
		local noteID;
		if(MetaKBOptions.SetMapShow) then
			if(MetaKB_AddMapNotes(name, zoneName, 0)) then
				MetaMapNotes_MapUpdate();
				noteID = MetaMap_ZoneTableSize(zoneName);
			end
		end
		MetaMap_ShowLocation(zoneName, name, noteID);
	end
	MetaKBOptions.ShowUpdates = tUpdate;
end

function MetaKBMenu_OnUpdate()
	if (MetaKBMenu:IsVisible()) then
		if (not MouseIsOver(MetaKBMenu)) then
			MetaKBMenu:Hide();
		end
	end
end

function MetaKB_TrimDatabase()
	local nameCount = 0;

	for i=1, MetaMap_TableSize(MetaKB_SearchResults) do
		local Name = MetaKB_SearchResults[i].name;
		MetaKB_Data[MetaKB_dbID][Name] = nil;
		nameCount = nameCount + 1
	end
	if(strlen(MetaKB_LastSearch) > 0) then
		MetaMap_StatusPrint("Removed "..nameCount.." entries from database linked to '"..MetaKB_LastSearch.."'", true);
	else
		MetaMap_StatusPrint("Removed ALL entries from database", true);
	end
	MetaKB_Search(MetaKB_LastSearch, true);
end

function MetaKB_AddMapNotes(name, zoneName, mininote)
	if(mininote == nil) then mininote = 0; end
	local continent, zone = MetaMap_NameToZoneID(zoneName);
	local currentZone = MetaKB_Data[MetaKB_dbID][name][continent][zone];
	local coordSets = {
	[1] = { ["n"] = TEXT(METAKB_MAPNOTES_NW_BOUND), ["x"] = 4, ["y"] = 1, },
	[2] = { ["n"] = TEXT(METAKB_MAPNOTES_NE_BOUND), ["x"] = 2, ["y"] = 1, },
	[3] = { ["n"] = TEXT(METAKB_MAPNOTES_SE_BOUND), ["x"] = 2, ["y"] = 3, },
	[4] = { ["n"] = TEXT(METAKB_MAPNOTES_SW_BOUND), ["x"] = 4, ["y"] = 3, }, };
	local infoOne = currentZone["inf1"];
	local infoTwo = currentZone["inf2"];
	local icon = currentZone["icon"];
	local namecol = icon;
	if(icon == 1) then namecol = 2;
	elseif(icon == 2) then namecol = 6;
	elseif(icon == 3) then namecol = 4;
	elseif(icon == 6) then namecol = 1; end
	local centerx, centery, dx, dy = MetaKB_FormatCoords(currentZone, 1)
	local noteAdded, nearNote = MetaMapNotes_AddNewNote(continent, zone, centerx, centery, name, infoOne, infoTwo, METAKB_AUTHOR, icon, namecol, 9, 6, mininote);
	if(noteAdded) then
		if(mininote ~= 2) then
			MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_NOTE, MetaMap_ZoneNames[continent][zone]), MetaKBOptions.ShowUpdates);
		end
	else
		MetaMap_StatusPrint(format(METAMAPNOTES_DECLINE_NOTE, MetaMapNotes_Data[continent][zone][nearNote].name, MetaMap_ZoneNames[continent][zone]), MetaKBOptions.ShowUpdates);
	end
	if(mininote > 0) then
		MetaMap_StatusPrint(format(METAMAPNOTES_ACCEPT_MININOTE, GetRealZoneText()), true);
	end
	if(noteAdded and mininote == 0 and (dx >= 3 or dy >= 3) and MetaKBOptions.BoundingBox) then
		local x2 = currentZone[coordSets[4].x]/10000
		local y2 = currentZone[coordSets[4].y]/10000
		local skipNext = false
		for i in coordSets do
			local x1 = currentZone[coordSets[i].x]/10000
			local y1 = currentZone[coordSets[i].y]/10000
			local noteAdded = MetaMapNotes_AddNewNote(continent, zone, x1, y1, name, infoOne, infoTwo, METAKB_AUTHOR, 10, namecol, 9, 6);
			if(noteAdded) then
				if(not skipNext) then
					MetaMapNotes_ToggleLine(continent, zone, x2, y2, x1, y1);
					MetaMapNotes_ToggleLine(continent, zone, centerx, centery, x1, y1);
				end
				skipNext = false;
			else
				skipNext = true;
			end
			x2,y2 = x1,y1;
		end
	end
	return noteAdded;
end

function WKB_HintTooltip()
	WorldMapTooltip:SetOwner(this, "ANCHOR_TOPLEFT");
	WorldMapTooltip:SetText(WKB_TTHINT_H0, 0.2, 0.5, 1, 1);
	WorldMapTooltip:AddDoubleLine("LeftClick", WKB_TTHINT_T0, 1, 1, 1, 1);
	WorldMapTooltip:AddDoubleLine("RightClick", WKB_TTHINT_T1, 1, 1, 1, 1);
	WorldMapTooltip:Show();
end

function MetaKB_ToggleAllZones()
	MetaKB_ShowAllZones = not MetaKB_ShowAllZones;
	if MetaKB_ShowAllZones then
		this:SetText(METAKB_SHOW_LOCALZONE);
		PlaySound("igMainMenuOptionCheckBoxOn");
	else
		this:SetText(METAKB_SHOW_ALLZONES);
		PlaySound("igMainMenuOptionCheckBoxOff");
	end
	MetaKB_Search();
end

function MetaKB_ToggleOptions(key, value)
	if(value) then
		MetaKBOptions[key] = value;
	else
		MetaKBOptions[key] = not MetaKBOptions[key];
	end
	return MetaKBOptions[key];
end

