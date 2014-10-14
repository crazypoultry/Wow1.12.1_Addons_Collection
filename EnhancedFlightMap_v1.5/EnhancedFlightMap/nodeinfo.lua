--[[

nodeinfo.lua

This file contains all the various information routines related to flight nodes.

]]

-- Function: Return which zone number related to a particular flight node.
function EFM_FN_GetNodeZone(flightNode, myLocale)
	local flightZone;
	local zoneIndex;
	local testIndex	= nil;
	local zonelist	= {};

	if (myLocale == nil) then
		myLocale	= GetLocale();
	end

	_, _, flightZone	= string.find(flightNode, ".*, (.*)");

	if (flightZone == nil) then
		flightZone = flightNode;
	end

	zoneIndex = LLC_SearchZones(flightZone, myLocale);

	-- If reference zone is 6 and 11 on Kalimdor and 7, 10 or 21 on Azeroth, check by first part of node name, just in case this is the flight node inside a town.
	if ((zoneIndex == 6) or (zoneIndex == 11) or
		(zoneIndex == 7) or (zoneIndex == 10) or (zoneIndex == 21)) then
		_, _, flightZone	= string.find(flightNode, "(.*), .*");
		testIndex = LLC_SearchZones(flightZone, myLocale);
	end

	if (testIndex ~= nil) then
		zoneIndex = testIndex;
	end

	return zoneIndex;
end

-- Function: Get a flight node by data reference, this will create the basic features if the flight node does not exist.
function EFM_FN_GetNode(continent, zone, fmLoc)
	local faction = UnitFactionGroup("player");

	-- Add faction if no faction data.
	if (EnhancedFlightMap_TaxiData[faction] == nil) then
		EnhancedFlightMap_TaxiData[faction] = {};
	end

	-- Add continent if no continent data.
	if (EnhancedFlightMap_TaxiData[faction][continent] == nil) then
		EnhancedFlightMap_TaxiData[faction][continent] = {};
	end

	-- Add mapKnown variable if missing.
	if (EnhancedFlightMap_TaxiData[faction][continent].mapKnown == nil) then
		EnhancedFlightMap_TaxiData[faction][continent].mapKnown = {};
	end

	-- Add zone if no zone data.
	if (EnhancedFlightMap_TaxiData[faction][continent][zone] == nil) then
		EnhancedFlightMap_TaxiData[faction][continent][zone] = {};
	end

	-- Add node if unknown node.
	if (EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc] == nil) then
		EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc] = {};
	end

	-- Add node entry for the routes table.
	if (EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc].routes == nil) then
		EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc].routes = {};
	end

	-- Add node entry for the timers table.
	if (EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc].timers == nil) then
		EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc].timers = {};
	end

	return EnhancedFlightMap_TaxiData[faction][continent][zone][fmLoc];
end

-- Function: Get a flight node by flight master location.  Only to be used if the flight node zone is unknown.
function EFM_FN_GetNodeByFMLoc(myLoc)
	local faction	= UnitFactionGroup("player");
	local zone;

	if (EnhancedFlightMap_TaxiData[faction] == nil) then
		return nil;
	end

	if (locale == nil) then
		locale = GetLocale();
	end
	
	for continent = 1, 2 do
		if (EnhancedFlightMap_TaxiData[faction][continent] ~= nil) then
			for zone in EnhancedFlightMap_TaxiData[faction][continent] do
				if (EnhancedFlightMap_TaxiData[faction][continent][zone] ~= nil) then
					local zoneRef = EnhancedFlightMap_TaxiData[faction][continent][zone];
					for location in zoneRef do
						if (myLoc == location) then
							return EnhancedFlightMap_TaxiData[faction][continent][zone][location];
						end
					end
				end
			end
		end
	end

	return nil;
end

-- Function: Get a flight node by name.  Only to be used if the flight master location is unknown.
function EFM_FN_GetNodeByName(flightNode, locale)
	local faction	= UnitFactionGroup("player");
	local zone;

	if (EnhancedFlightMap_TaxiData[faction] == nil) then
		return nil;
	end

	if (locale == nil) then
		locale = GetLocale();
	end
	
	for continent = 1, 2 do
		if (EnhancedFlightMap_TaxiData[faction][continent] ~= nil) then
			zone = EFM_FN_GetNodeZone(flightNode);
			if (zone ~= nil) then
				if (EnhancedFlightMap_TaxiData[faction][continent][zone] ~= nil) then
					local zoneRef = EnhancedFlightMap_TaxiData[faction][continent][zone];
					for location in zoneRef do
						if (EnhancedFlightMap_TaxiData[faction][continent][zone][location][locale] == flightNode) then
							return EnhancedFlightMap_TaxiData[faction][continent][zone][location];
						end
					end
				end
			end
		end
	end

	return nil;
end

-- Function: Get the list of available nodes for the current 
function EFM_FN_GetNodeList(continent)
	local faction	= UnitFactionGroup("player");
	local myLocale	= GetLocale();
	local nodeList	= {};

	if (EnhancedFlightMap_TaxiData == nil) then
		return nil;
	end
	
	if (EnhancedFlightMap_TaxiData[faction] == nil) then
		return nil;
	end

	if (EnhancedFlightMap_TaxiData[faction][continent] == nil) then
		return nil;
	end

	for zone in EnhancedFlightMap_TaxiData[faction][continent] do
		if (zone ~= "mapKnown") then
			for location in EnhancedFlightMap_TaxiData[faction][continent][zone] do
				if (EnhancedFlightMap_TaxiData[faction][continent][zone][location][myLocale] ~= nil) then
					table.insert(nodeList, EnhancedFlightMap_TaxiData[faction][continent][zone][location][myLocale]);
				end
			end
		end
	end

	return nodeList;
end

-- Function: Add a node to the data table.
function EFM_FN_AddNode(flightNode, fmX, fmY, mapX, mapY)
	local fmLoc		= fmX..":"..fmY;
	local myZone	= EFM_FN_GetNodeZone(flightNode);

	if (myZone == nil) then
		local _, _, flightZone	= string.find(flightNode, ".*, (.*)");
		if (flightZone ~= nil) then
			DEFAULT_CHAT_FRAME:AddMessage(format(LLC_MSG_ERRORZONE, flightZone), 1.0, 0.2, 0.2);
		else
			DEFAULT_CHAT_FRAME:AddMessage(format(LLC_MSG_ERRORZONE, flightNode), 1.0, 0.2, 0.2);
		end
		return;
	end

	-- This botch-up here is to cover for a major blizzard bug - in that you can get the flight nodes for nodes that are not of your faction!
	if (UnitFactionGroup("player") == "Horde") then
		if ((myZone == 13) and (fmX == 0.418)) then
			return;
--		elseif ((myZone == 10) and (fmX == 0.549)) then
--			return;
		end
	else
		if ((myZone == 13) and (fmX == 0.416)) then
			return;
--		elseif ((myZone == 10) and (fmX == 0.549)) then
--			return;		
		end
	end
	
	local myNode	= EFM_FN_GetNode(GetCurrentMapContinent(), myZone, fmLoc);

	-- Blizzard sometimes changes it's mind about names for flight masters, so this updates if the name has changed, or is non-existant.
	if (myNode[GetLocale()] ~= flightNode) then
		myNode[GetLocale()]	= flightNode;
	end

	-- Add the node location if unknown
	if (myNode.fmLoc == nil) then
		myNode.fmLoc = fmX..":"..fmY;
	end

	-- Add zone map location if provided.
	if ((mapX ~= nil) and (mapY ~= nil)) then
		myNode.mapLoc = mapX..":"..mapY;
		EFM_FN_AddMapKnown(flightNode);
	end
end

-- Function: Add flight node to known nodes.
function EFM_FN_AddMapKnown(flightNode)
	local faction	= UnitFactionGroup("player");
	local continent	= GetCurrentMapContinent();

	local tempNode	= EFM_FN_GetNodeByName(flightNode);

	if (tempNode ~= nil) then
		local mapNodeName = tempNode.enUS;
		if (not EFM_SF_StringInTable(EnhancedFlightMap_TaxiData[faction][continent].mapKnown, mapNodeName)) then
			table.insert(EnhancedFlightMap_TaxiData[faction][continent].mapKnown, mapNodeName);
		end
	end
end

-- Function: Add routes to a flight node.
function EFM_FN_AddRoutes(flightNode, routeList)
	for name, data in routeList do
		local myNode	= EFM_FN_GetNodeByName(flightNode);
		local routeData	= EFM_FN_GetNodeZone(name).."~"..data;
		if (myNode) then
			local myRoutes	= myNode.routes;

			if (not EFM_SF_StringInTable(myRoutes, routeData)) then
				table.insert(myRoutes, routeData);
				DEFAULT_CHAT_FRAME:AddMessage(format(EFM_NEW_NODE, EFM_TaxiOrigin, name), 0.5, 0.5, 1.0);
			end
		end
	end
end

-- Function: Get route reference data from route name.
function EFM_FN_GetRouteDataByName(routeName)
	local myNode = EFM_FN_GetNodeByName(routeName);
	local myZone = EFM_FN_GetNodeZone(routeName);

	if (myZone ~= nil) then
		local routeData = myZone.."~"..myNode.fmLoc;
		return routeData;
	else
		return nil;
	end
end

-- Function: Get name for node by route reference data
function EFM_FN_GetNodeNameByRouteData(routeData, continent)
	if (continent == nil) then
		continent = GetCurrentMapContinent();
	end

	local _, _, zone, fmLoc = string.find(routeData, "(.*)~(.*)");

	zone = tonumber(zone);

	local myNode = EFM_FN_GetNode(continent, zone, fmLoc);

	return myNode[GetLocale()];
end

-- Function: Get the flight master map location data for the flight node given
function EFM_FN_GetNodeFlightMapLocation(nodeRef)
	local _, _, fmX, fmY = string.find(nodeRef.fmLoc, "(.*):(.*)");
	
	mapX = tonumber(fmX);
	mapY = tonumber(fmY);

	return fmX, fmY;
end

-- Function: Get the map location data for the flight node given
function EFM_FN_GetNodeMapLocation(nodeRef)
	local _, _, mapX, mapY = string.find(nodeRef.mapLoc, "(.*):(.*)");

	mapX = tonumber(mapX);
	mapY = tonumber(mapY);

	return mapX, mapY;
end

-- Function: Return the flight time to fly between two flight nodes.  Nodes are the flight node names.
function EFM_FN_GetFlightDuration(origNode, destNode)
	local myNode = EFM_FN_GetNodeByName(origNode);
	if (myNode ~= nil) then
		local destData = EFM_FN_GetRouteDataByName(destNode);
		if (destData ~= nil) then
			local flightTime = myNode["timers"][destData];
			if (flightTime ~= nil) then
				return flightTime;
			end
		end
	end

	return nil;
end

-- Function: Add the flight time for a known flight path
function EFM_FN_AddFlightTime(origNode, destNode, flightTime)
	local myNode	= EFM_FN_GetNodeByName(origNode);
	local destData	= EFM_FN_GetRouteDataByName(destNode);

	-- Check to see if we already know the flight time for this route.
	-- If we do, check to see if the time is off by less than or equal to 10 seconds.
	-- If so, then average the two flight times and store the new entry, this will mean flight times can average out over time.
	-- If not, then the new flight time becomes the base flight time for that route.
	if (myNode["timers"][destData] ~= nil) then
		local diff = myNode["timers"][destData] - flightTime;
		diff = abs(diff);
		if (diff <= 10) then
			myNode["timers"][destData] = floor((flightTime + myNode["timers"][destData]) / 2);
		else
			myNode["timers"][destData] = flightTime;
		end
	else
		myNode["timers"][destData] = flightTime;
	end
end

-- Function: Get the continent for a specific named flight node.
function EFM_FN_GetNodeContinent(flightNode)
	local faction	= UnitFactionGroup("player");
	local locale		= GetLocale();

	for continent = 1, 2 do
		if (EnhancedFlightMap_TaxiData[faction][continent] ~= nil) then
			local zone = EFM_FN_GetNodeZone(flightNode);
			if (zone ~= nil) then
				if (EnhancedFlightMap_TaxiData[faction][continent][zone] ~= nil) then
					local zoneRef = EnhancedFlightMap_TaxiData[faction][continent][zone];
					for location in zoneRef do
						if (EnhancedFlightMap_TaxiData[faction][continent][zone][location][locale] == flightNode) then
							return continent;
						end
					end
				end
			end
		end
	end
	
	return nil;
end
