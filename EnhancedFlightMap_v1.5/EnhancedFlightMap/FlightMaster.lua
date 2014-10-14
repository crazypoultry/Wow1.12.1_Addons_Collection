--[[

FlightMaster.lua

The various routines for handling the flight master displays

]]

-- Function: Replacement for blizzard function...
function EFM_FM_DrawOneHopLines()
	-- Check to see if we are displaying the remote flight path display.
	-- If so we don't want to do anything as we could be modifying our data and not knowing it.
	-- Also the blizzard functions error if you attempt to show flight path details when you aren't at the flight master...
	local taxiText = TaxiMerchant:GetText();
	if (string.find(taxiText, EFM_MSG_REMOTENAME) ~= nil) then
		return;
	end

	-- Call original Blizzard function.
	EFM_Orig_DrawOneHopLines();

	-- The following code adds in the single-hop routes so the remote flight path display can show the correct flight paths...
	local nodeTargets	= {};
	local routeList		= {};
	local faction		= UnitFactionGroup("player");
	local continent		= GetCurrentMapContinent();

	for i=1, NumTaxiNodes() do
		local nodeName	= TaxiNodeName(i);
		local fmX, fmY	= TaxiNodePosition(i);

		fmX = EFM_SF_ValueToPrecision(fmX, EFM_Globals.DataPrecision);
		fmY = EFM_SF_ValueToPrecision(fmY, EFM_Globals.DataPrecision);

		if (TaxiNodeGetType(i) == "CURRENT") then
			EFM_TaxiOrigin = nodeName;
			-- Add the current node
			local mapX, mapY = GetPlayerMapPosition("player");
			mapX = floor(mapX * 10000) / 100;
			mapY = floor(mapY * 10000) / 100;
			EFM_FN_AddNode(nodeName, fmX, fmY, mapX, mapY);
			EFM_KP_AddLocation(continent, nodeName);
		else
			-- Add the remote node locations
			EFM_FN_AddNode(nodeName, fmX, fmY);
			-- Add the node to the routelist table
			if (GetNumRoutes(i) == 1) then
				routeList[nodeName] = fmX..":"..fmY;
				EFM_KP_AddLocation(continent, nodeName);
			end
		end
	end

	-- Add the node route data (new method)
	EFM_FN_AddRoutes(EFM_TaxiOrigin, routeList);
end

-- Function: Commands to run when we get the TAXIMAP_OPEN event
function EFM_FM_TaxiMapOpenEvent()
	EFM_FM_ClearTaxiMap(false);

	-- If displaying the remote flight display, end processing.
	local taxiText = TaxiMerchant:GetText();
	if (string.find(taxiText, EFM_MSG_REMOTENAME) ~= nil) then
		return;
	end

	if (EFM_ShowUnknownTimes == true) then
		if (EFM_TaxiOrigin ~= nil) then
			local seenNodes	= {};
			local seenHops	= false;
			table.insert(seenNodes, EFM_TaxiOrigin);
			DEFAULT_CHAT_FRAME:AddMessage(EFM_DEBUG_HEADER_MT, 1.0, 0.1, 0.1);

			local nodes = NumTaxiNodes();

			local myHops = 1;
			while (myHops ~= 0) do
				DEFAULT_CHAT_FRAME:AddMessage(format("%s: Displaying routes with missing times that are %s hop(s) away.", EFM_DESC, myHops), 1.0, 0.1, 0.1);
				for i = 1, nodes, 1 do
					local destNode = TaxiNodeName(i);
					if (not EFM_SF_StringInTable(seenNodes, destNode)) then
						if ((myHops > 3) or (GetNumRoutes(i) == myHops)) then
							local flightTime = EFM_FN_GetFlightDuration(EFM_TaxiOrigin, destNode);
							if (flightTime == nil) then
								DEFAULT_CHAT_FRAME:AddMessage(format(EFM_DEBUG_MT, EFM_TaxiOrigin, destNode, GetNumRoutes(i)), 1.0, 0.1, 0.1);
								seenHops = true;
							end
							table.insert(seenNodes, destNode);
						end
					end
				end
				-- Exit if we have shown a route, or we have gotten to > 3 hops as all hops get displayed by > 3 no matter what.
				if ((seenHops == true) or (myHops > 3)) then
					myHops = 0;
				else
					DEFAULT_CHAT_FRAME:AddMessage(format("%s: none", EFM_DESC), 1.0, 0.1, 0.1);
					myHops = myHops + 1;
				end
			end

		end
	end
end

-- Function: Replacement handler for the TaxiNodeOnButtonEnter function
function EFM_FM_TaxiNodeOnButtonEnter(button)
	local recordedDuration	= 0;
	local calcDuration		= 0;
	local hopCount		= 0;
	local missingHop		= false;

	local index = button:GetID();
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT");

	-- Check the TaxiMerchant text to see if this is a remote display or not.
	if (string.find(TaxiMerchant:GetText(), EFM_MSG_REMOTENAME) ~= nil) then
		GameTooltip:AddLine(EFM_TaxiDistantButtonData[index][GetLocale()], "", 1.0, 1.0, 1.0);
		GameTooltip:Show();
		return;
	end
	
	GameTooltip:AddLine(TaxiNodeName(index), "", 1.0, 1.0, 1.0);
	
	-- Setup variables
	local numRoutes = GetNumRoutes(index);
	local line;
	local sX, sY, dX, dY;
	local w = TaxiRouteMap:GetWidth();
	local h = TaxiRouteMap:GetHeight();

	local type = TaxiNodeGetType(index);
	if ( type == "REACHABLE" ) then
		-- This next bit is for the duration data.
		if (EFM_FN_GetFlightDuration(EFM_TaxiOrigin, TaxiNodeName(index)) ~= nil) then
			recordedDuration = EFM_FN_GetFlightDuration(EFM_TaxiOrigin, TaxiNodeName(index));
		end

		-- Original Blizzard Stuff
		TaxiNodeSetCurrent(index);

		for i=1, EFM_FM_MAXPATHS do
			line = getglobal("TaxiRoute"..i);
			if (line ~= nil) then
				if ( i <= numRoutes ) then
					sX = TaxiGetSrcX(index, i) * w;
					sY = TaxiGetSrcY(index, i) * h;
					dX = TaxiGetDestX(index, i) * w;
					dY = TaxiGetDestY(index, i) * h;

					-- Added to caculate flight routes from blizzard sources.
					local sLoc = EFM_SF_ValueToPrecision(TaxiGetSrcX(index, i), EFM_Globals.DataPrecision)..":"..EFM_SF_ValueToPrecision(TaxiGetSrcY(index, i), EFM_Globals.DataPrecision);
					local dLoc = EFM_SF_ValueToPrecision(TaxiGetDestX(index, i), EFM_Globals.DataPrecision)..":"..EFM_SF_ValueToPrecision(TaxiGetDestY(index, i), EFM_Globals.DataPrecision);
					local mySNode = EFM_FN_GetNodeByFMLoc(sLoc);
					local myDNode = EFM_FN_GetNodeByFMLoc(dLoc);
					hopCount = hopCount + 1;

					if ((mySNode ~= nil) and (myDNode ~= nil)) then
						if (EFM_FN_GetFlightDuration(mySNode[GetLocale()],myDNode[GetLocale()]) ~= nil) then
							calcDuration = calcDuration + EFM_FN_GetFlightDuration(mySNode[GetLocale()],myDNode[GetLocale()]);
						else
							missingHop = true;
						end
					end

					DrawRouteLine(line, "TaxiRouteMap", sX, sY, dX, dY, 32);
					line:Show();
				else
					line:Hide();
				end
			else
				line = EFM_FM_MAXPATHS;
			end
		end

		-- Check to see if there is a missing single-hop in calculated flights, if so, do not update recorded times
		if ((missingHop == false) and (calcDuration ~= 0)) then
			-- If Duration unknown set duration to calculated duration.
			if (recordedDuration == 0) then 
				EFM_FN_AddFlightTime(EFM_TaxiOrigin, TaxiNodeName(index), calcDuration);
			end

			-- If the calculated duration is different by more than 120 seconds to the recorded duration,
			-- replace recorded duration with calculated duration.
			if (abs(calcDuration - recordedDuration) > 120) then
				EFM_FN_AddFlightTime(EFM_TaxiOrigin, TaxiNodeName(index), calcDuration);
			end
		end

		-- Add Durations
		if (recordedDuration ~= 0) then
			GameTooltip:AddLine(EFM_FT_FLIGHT_TIME..EFM_SF_FormatTime(recordedDuration), "", 0.5, 1.0, 0.5);
		else
			GameTooltip:AddLine(EFM_FT_FLIGHT_TIME..UNKNOWN, "", 0.5, 1.0, 0.5);
		end
		if (hopCount > 1) then
			if (calcDuration ~= 0) then
				if (missingHop == false) then
					GameTooltip:AddLine(EFM_FT_FLIGHT_TIME_CALC..EFM_SF_FormatTime(calcDuration), "", 0.5, 1.0, 0.5);
				else
					GameTooltip:AddLine(EFM_FT_FLIGHT_TIME_CALC..EFM_SF_FormatTime(calcDuration).." *", "", 0.5, 1.0, 0.5);
				end
			else
				if (missingHop == false) then
					GameTooltip:AddLine(EFM_FT_FLIGHT_TIME_CALC..UNKNOWN, "", 0.5, 1.0, 0.5);
				else
					GameTooltip:AddLine(EFM_FT_FLIGHT_TIME_CALC..UNKNOWN.." *", "", 0.5, 1.0, 0.5);
				end
			end
		end

		-- Moved money line here so it will show after the flight time display information
		SetTooltipMoney(GameTooltip, TaxiNodeCost(this:GetID()));

	elseif ( type == "CURRENT" ) then
		GameTooltip:AddLine(TEXT(TAXINODEYOUAREHERE), "", 0.5, 1.0, 0.5);

		DrawOneHopLines();
	end

	GameTooltip:Show();
end

-- Function: Check to see if the TaxiNode is already on the map.
function EFM_FM_TaxiNodeOnMap(zone)
	local nodes = NumTaxiNodes();
	for i = 1, nodes, 1 do
		if( TaxiNodeName(i) == zone ) then
			return true;
		end
	end
	return false;
end

-- Function: What to do to show the flight master display when not at the flight master...
function EFM_FM_TaxiMapRemote(continent)
	EFM_FM_ClearTaxiMap(true);
	SetMapToCurrentZone();

	local continentNum	= GetCurrentMapContinent();
	local continentMap	= "Interface\\TaxiFrame\\TAXIMAP0";

	if (continent == EFM_FMCMD_CURRENT) then
		continentMap	= "Interface\\TaxiFrame\\TAXIMAP"..abs(continentNum - 2);
	elseif (continent == EFM_FMCMD_KALIMDOR) then
		continentMap	= "Interface\\TaxiFrame\\TAXIMAP1";
		continentNum	= 1;
	elseif (continent == EFM_FMCMD_AZEROTH) then
		continentMap	= "Interface\\TaxiFrame\\TAXIMAP0";
		continentNum	= 2;
	end

	if (continentNum == 1) then
		continentName	= EFM_MSG_KALIMDOR;
	elseif(continentNum == 2) then
		continentName	= EFM_MSG_AZEROTH;
	else
		DEFAULT_CHAT_FRAME:AddMessage(EFM_MSG_UNKNOWNCONTINENT, 1.0, 0.2, 0.2);
		return;
	end

	-- Show the merchant we're dealing with
	TaxiMerchant:SetText(format(EFM_MSG_REMOTENAME.." - %s", continentName));
	SetPortraitTexture(TaxiPortrait, "player");

	-- Set the texture coords on the map
	TaxiMap:SetTexCoord(0,1,0,1);
	TaxiMap:SetTexture(continentMap);

	local EFM_FM_Texture_AltKnown = "Interface\\TaxiFrame\\UI-Taxi-Icon-Gray";
	local EFM_FM_Texture_CurKnown = "Interface\\TaxiFrame\\UI-Taxi-Icon-Yellow";

	local numLines	= 0;
	local displayNode	= true;
	local routepoi	= 0;
	local numNodes	= 0;

	-- Set variables that get used a lot...
	local w		= TaxiRouteMap:GetWidth();
	local h		= TaxiRouteMap:GetHeight();

	-- Clear the seenRoutes variable.
	seenRoutes = {};

	-- Add all distant taxi buttons.
	EFM_TaxiDistantButtonData = {};

	local nodeList = EFM_FN_GetNodeList(continentNum);
	if (nodeList == nil) then
		ShowUIPanel(TaxiFrame);
		return;
	end

	for key, zone in nodeList do
		numNodes		= numNodes + 1;
		displayNode	= true;  -- Default to not displaying the flight node.
		myNode		= EFM_FN_GetNodeByName(zone);

		if (myNode ~= nil) then
			if (string.find(zone, "Nighthaven, Moonglade") ~= nil) then
				-- Are we allowed to show the druid flight paths
				if (EFM_MyConf.DruidPaths == false) then
					numNodes = numNodes - 1;
					displayNode = false;
				end
			end

			-- If the node is not already drawn, and we are allowed to display it, then draw it...
			if (displayNode)then
--				DEFAULT_CHAT_FRAME:AddMessage("EFM Debug: numNodes:"..numNodes.." Zone:"..zone, 0.4, 0.4, 0.4);

				-- Set the texture for the flight path
				local myTexture = EFM_FM_Texture_AltKnown;
				if (EFM_KP_CheckPaths(continentNum, zone)) then
					myTexture = EFM_FM_Texture_CurKnown;
				end

				-- Create a button for the flight node if needed
				button = getglobal("EFM_TaxiButton"..numNodes);
				if (button == nil) then
					button = CreateFrame("Button", "EFM_TaxiButton"..numNodes, TaxiRouteMap, "TaxiButtonTemplate");
				end
				button:SetID(numNodes);

				-- Save the data for this button along with the zone name.
				EFM_TaxiDistantButtonData[numNodes]= {};
				EFM_SF_mergeTable(myNode, EFM_TaxiDistantButtonData[numNodes]);

				-- Get the x and y co-ords for the node.
				local origX, origY	= EFM_FN_GetNodeFlightMapLocation(myNode);
				sX			= origX * w;
				sY			= origY * h;

				-- Display it.
				button:ClearAllPoints();
				button:SetPoint("CENTER", "TaxiMap", "BOTTOMLEFT", sX, sY);
				button:SetNormalTexture(myTexture);
				button:Show();

				-- Draw Routes on map
				if (myNode.routes ~= nil) then
					local flightDuration = "";

					WorldMapTooltip:AddLine(EFM_MAP_PATHLIST, 1.0, 1.0, 1.0);

					for key, val in pairs(myNode.routes) do
						local routeName	= EFM_FN_GetNodeNameByRouteData(val, continentNum);

						if (not EFM_SF_StringInTable(seenRoutes, routeName)) then
							routepoi		= routepoi + 1;
							local endNode	= EFM_FN_GetNodeByName(routeName);

							-- Create a new texture for the route line if needed
							line = getglobal("EFM_TaxiRoute"..routepoi);
							if (line == nil) then
								line = TaxiRouteMap:CreateTexture("EFM_TaxiRoute"..routepoi, "BACKGROUND");
							end
							line:SetTexture("Interface\\TaxiFrame\\UI-Taxi-Line");

							if (line) then
								local destX, destY	= EFM_FN_GetNodeFlightMapLocation(endNode);

								dX = destX * w;
								dY = destY * h;
								DrawRouteLine(line, "TaxiRouteMap", sX, sY, dX, dY, 32);
								line:Show();
							end
						end
					end
					table.insert(seenRoutes, zone);
				end

			end
		end
	end

	ShowUIPanel(TaxiFrame);
end

-- Function: Keybinding routine called to display the continents
function EFM_Map_BindingDisplay(display)
	local myContinent = GetCurrentMapContinent();

	if TaxiFrame:IsVisible() then
		HideUIPanel(TaxiFrame)
	else
		if (display == 0) then
			EFM_FM_TaxiMapRemote(EFM_FMCMD_CURRENT);
		elseif (display == 1) then
			EFM_FM_TaxiMapRemote(EFM_FMCMD_KALIMDOR);
		elseif (display == 2) then
			EFM_FM_TaxiMapRemote(EFM_FMCMD_AZEROTH);
		end
	end
end

-- Function: Clears all node and flight lines from the taximap window.
function EFM_FM_ClearTaxiMap(blizData)
	if (blizData == true) then
		-- Clear blizzard flight route lines
		for index = 1, EFM_FM_MAXPATHS do
			-- Clear route lines
			local line = getglobal("TaxiRoute" .. index);
			if (line ~= nil) then
				line:ClearAllPoints();
				line:Hide();
			end

			-- Clear nodes
			local button = getglobal("TaxiButton"..index);
			if (button ~= nil) then
				button:ClearAllPoints();
				button:Hide();
			end

			-- Clear EFM Nodes
			local EFMbutton = getglobal("EFM_TaxiButton"..index);
			if (EFMbutton ~= nil) then
				EFMbutton:ClearAllPoints();
				EFMbutton:Hide();
			end

			-- Clear EFM route lines
			local EFMLine = getglobal("EFM_TaxiRoute" .. index);
			if (EFMLine ~= nil) then
				EFMLine:ClearAllPoints();
				EFMLine:Hide();
			end
		end
	else
		for index = 1, EFM_FM_MAXPATHS do
			-- Clear EFM Nodes
			local EFMbutton = getglobal("EFM_TaxiButton"..index);
			if (EFMbutton ~= nil) then
				EFMbutton:ClearAllPoints();
				EFMbutton:Hide();
			end

			-- Clear EFM route lines
			local EFMLine = getglobal("EFM_TaxiRoute" .. index);
			if (EFMLine ~= nil) then
				EFMLine:ClearAllPoints();
				EFMLine:Hide();
			end
		end
	end
end
