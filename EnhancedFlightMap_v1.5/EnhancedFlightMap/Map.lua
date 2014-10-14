--[[

Map modifications

]]

-- Function: Clear the POI buttons
function EFM_Map_ClearPOI()
	for i = 1, EFM_MAX_POI, 1 do
		POI = getglobal("EFM_MAP_POI"..i);
		if(POI) then
			POI:ClearAllPoints();
			POI.Location = nil;
			POI:Hide();
		end
	end
end

-- Function: Get map points for world map.
function EFM_Map_CheckPoints(myFaction, myContinent, myZone)
	for key,val in pairs(EFM_MapTranslation[myFaction][myContinent]) do
		if (val == myZone) then
			if (not EFM_SF_StringInTable(knownPoints, key)) then
				table.insert(knownPoints, key);
			end
		end
	end
end

-- Function: World Map Update thingy.
function EFM_Map_WorldMapEvent()
--	DEFAULT_CHAT_FRAME:AddMessage("EFM: Got world map event");

	if (EFM_MyConf == nil) then
		return;
	end
--	DEFAULT_CHAT_FRAME:AddMessage("EFM: Yep, we have configuration...");

	if (not EFM_MyConf.ZoneMarker) then
		return;
	end
--	DEFAULT_CHAT_FRAME:AddMessage("EFM: And we want to display the zone markers, great!");

	if (WorldMapDetailFrame:IsVisible()) then
		EFM_Map_ClearPOI();

		local myFaction		= UnitFactionGroup("player");
		local myContinent	= GetCurrentMapContinent();
		local myZone		= GetCurrentMapZone();
		
		local w			= WorldMapButton:GetWidth();
		local h			= WorldMapButton:GetHeight();

		local zoneList		= {};
		local zoneName		= "";
		knownPoints		= {};

		local buttonCount	= 0;

		if ((myFaction == nil) or (myContinent == 0) or (myZone == 0)) then
			return nil;
		end

		EFM_Map_ClearPOI();

		if (EnhancedFlightMap_TaxiData[myFaction] == nil) then
			return;
		end
		if (EnhancedFlightMap_TaxiData[myFaction][myContinent] == nil) then
			return;
		end
		if (EnhancedFlightMap_TaxiData[myFaction][myContinent].mapKnown == nil) then
			return;
		end
		knownPoints = EnhancedFlightMap_TaxiData[myFaction][myContinent].mapKnown;

		local POI;
		local POITexture;

		for key, flightNode in knownPoints do
			-- Debugging
			--DEFAULT_CHAT_FRAME:AddMessage("key: "..key..", node: "..flightNode);
			-- Debugging

			local tempNode = EFM_FN_GetNodeByName(flightNode, "enUS");

			if (tempNode == nil) then
				table.remove(EnhancedFlightMap_TaxiData[myFaction][myContinent].mapKnown, key);
			else
				flightNode = tempNode.enUS;

				if (myZone == EFM_FN_GetNodeZone(flightNode, myContinent)) then
					local myNode	= EFM_FN_GetNodeByName(flightNode, "enUS");
					local nodeName	= myNode[GetLocale()];
					local mapX,mapY	= EFM_FN_GetNodeMapLocation(myNode);

					if ((mapX ~= nil) and (mapY ~= nil)) then
						buttonCount	= buttonCount + 1;
						POI			= getglobal("EFM_MAP_POI"..buttonCount);
						POITexture		= getglobal("EFM_MAP_POI"..buttonCount.."Icon");

						-- Display the actual POI Button
						if (EFM_KP_CheckPaths(myContinent, nodeName)) then
							POITexture:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Icon-Yellow");
						else
							POITexture:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Icon-Gray");
						end

						POI:ClearAllPoints();
						POI:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", (mapX/100) * w, -((mapY/100) * h));
						POI:Show();

						-- Set the Location Field.
						POI.Location = nodeName;
					end
				end
			end
		end
	end
end

-- Function: POI On Enter
function EFM_MAP_POIOnEnter()
	local px, py = this:GetCenter();
	local wx, wy = WorldMapButton:GetCenter();
	local align = "ANCHOR_LEFT";
	if (px <= wx) then
		align = "ANCHOR_RIGHT";
	end

	WorldMapFrameAreaLabel:SetText(this.Location);
	WorldMapTooltip:SetOwner(this, align);
	WorldMapTooltip:AddLine(this.Location);
	
	-- Flight path display stuff...
	local myNode = EFM_FN_GetNodeByName(this.Location);
	
	if (myNode) then
		local flightDuration = "";

		WorldMapTooltip:AddLine(EFM_MAP_PATHLIST, 1.0, 1.0, 1.0);

		for key, val in pairs(myNode.routes) do
			local routeName	= EFM_FN_GetNodeNameByRouteData(val);
			flightDuration	= EFM_FN_GetFlightDuration(this.Location, routeName);

			if (EFM_KP_CheckPaths(GetCurrentMapContinent(), routeName)) then
				flightColour = "|c0000FF00";
			else
				flightColour = "|c00909090";
			end
		
			if (flightDuration) then
				WorldMapTooltip:AddDoubleLine(flightColour..routeName, EFM_SF_FormatTime(flightDuration));
			else
				WorldMapTooltip:AddLine(flightColour..routeName);
			end
		end
	end
	
	-- Show the Tooltip
	WorldMapTooltip:Show();
end

-- Function: POI On Leave
function EFM_MAP_POIOnLeave()
	WorldMapTooltip:Hide();
end
