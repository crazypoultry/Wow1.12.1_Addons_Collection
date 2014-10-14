--[[

data.lua

Various data load functions.

]]

-- Function: Define the EFM data variable(s)
function EFM_DefineData()
	---------------------------------
	-- Global options data definition
	if (EFM_MyConf == nil) then
		EFM_MyConf = {};
	end

	if (EFM_Globals == nil) then
		EFM_Globals = {};
	end

	if ((EFM_Globals.DataVersion == nil) 
		or (EFM_Globals.DataVersion < EFMDATABASE_VERSION)
		or (EFM_MyConf.ShowRemotePaths ~= nil)
		) then
		EFM_MyConf = {};
	end

	if (EFM_MyConf.Timer == nil) then
		EFM_MyConf.Timer		= true;
	end

	if (EFM_MyConf.ZoneMarker == nil) then
		EFM_MyConf.ZoneMarker	= true;
	end

	if (EFM_MyConf.DruidPaths == nil) then
		EFM_MyConf.DruidPaths	= true;
	end

	if (EFM_MyConf.ShowTimerBar == nil) then
		EFM_MyConf.ShowTimerBar = false;
	end

	if (EFM_MyConf.ShowLargeBar == nil) then
		EFM_MyConf.ShowLargeBar = false;
	end

	if (EFM_MyConf.TimerPosition	== nil) then
		EFM_MyConf.TimerPosition = -150;
	end

	if (EFM_MyConf.LoadAll	== nil) then
		EFM_MyConf.LoadAll = true;
	end

	------------------------------------------------------------------------------------------
	-- Make sure the global variable for the flight master location data is defined correctly.
	if (EnhancedFlightMap_TaxiData == nil) then
		EnhancedFlightMap_TaxiData = {};
	end

	-- Convert version strings from taxidata variable to globals variable
	if (EnhancedFlightMap_TaxiData.AllianceVersion ~= nil) then
		EFM_Globals.AllianceVersion = EnhancedFlightMap_TaxiData.AllianceVersion;
		EnhancedFlightMap_TaxiData.AllianceVersion = nil;
	end
	if (EnhancedFlightMap_TaxiData.HordeVersion ~= nil) then
		EFM_Globals.HordeVersion = EnhancedFlightMap_TaxiData.HordeVersion;
		EnhancedFlightMap_TaxiData.HordeVersion = nil;
	end
	if (EnhancedFlightMap_TaxiData.DruidVersion ~= nil) then
		EFM_Globals.DruidVersion = EnhancedFlightMap_TaxiData.DruidVersion;
		EnhancedFlightMap_TaxiData.DruidVersion = nil;
	end
	-------------------------------------------------------------------------------------
	-- Make sure the global variable for the known path data is defined correctly.
	if (EFM_MyNodes == nil) then
		EFM_MyNodes = {};
	end

	if (EFM_MyNodes[1] == nil) then
		EFM_MyNodes[1] = {};
	end

	if (EFM_MyNodes[2] == nil) then
		EFM_MyNodes[2] = {};
	end
end

-- Function: Validate the data set versions and load missing data.
function EFM_ValidateVersions()
	-- Check for new data version string
	if ((EFM_Globals.DataVersion == nil) or (EFM_Globals.DataVersion < EFMDATABASE_VERSION)) then
		-- Remove EnhancedFlightMap_TaxiData if Defined
		if (EnhancedFlightMap_TaxiData ~= nil) then
			EnhancedFlightMap_TaxiData		= {};
		end
		-- Remove EnhancedFlightMap_TaxiPathData if Defined
		if (EnhancedFlightMap_TaxiPathData ~= nil) then
			EnhancedFlightMap_TaxiPathData	= nil;
		end
		-- Remove EFM_MapTranslation if Defined
		if (EFM_MapTranslation ~= nil) then
			EFM_MapTranslation			= nil;
		end
		EFM_Globals.DataVersion = EFMDATABASE_VERSION;		-- Update saved database version string to current database version
	end

	-- Check precision values
	if (EFM_Globals.DataPrecision ~= EFMDATA_PRECISION) then
		EFM_Globals.DataPrecision = EFMDATA_PRECISION;

		if (EnhancedFlightMap_TaxiData ~= nil) then
			if (EnhancedFlightMap_TaxiData["Alliance"] ~= nil) then
				EFM_Data_FlightConvert(EnhancedFlightMap_TaxiData, "Alliance");
			end

			if (EnhancedFlightMap_TaxiData["Horde"] ~= nil) then
				EFM_Data_FlightConvert(EnhancedFlightMap_TaxiData, "Horde");
			end
		end
	end

	-- Check to see if the user has previous data for each race, if so then load the current data if it has changed.
	if ((EFM_Globals.HordeVersion ~= nil) and (EFM_Globals.HordeVersion ~= Default_EFM_Data_Horde.HordeVersion)) then
		EFM_Load_Stored_Data("Horde");
	end

	if ((EFM_Globals.AllianceVersion ~= nil) and (EFM_Globals.AllianceVersion ~= Default_EFM_Data_Alliance.AllianceVersion)) then
		EFM_Load_Stored_Data("Alliance");
	end

	if ((EFM_Globals.DruidVersion ~= nil) and (EFM_Globals.DruidVersion ~= Default_EFM_Data_Druid.DruidVersion)) then
		EFM_Load_Stored_Data("Druid");
	end
end

-- Function to load data from defaults.
function EFM_Load_Stored_Data(DataType)
	if (EFMDATA_CLEAR_ON_LOAD) then
		if ((DataType == "Horde") or (DataType == "Alliance")) then
			EFM_Data_Clear(DataType);
		end
	end

	local StoredData = getglobal("Default_EFM_Data_"..DataType);
	local SDVersion = DataType.."Version";

	-- If the precision is not the default, then process the stored data to the correct precision
	if (EFM_Globals.DataPrecision ~= EFMDATA_PRECISION) then
		if (DataType == "Druid") then
			EFM_Data_FlightConvert(StoredData, "Alliance");
			EFM_Data_FlightConvert(StoredData, "Horde");
		else
			EFM_Data_FlightConvert(StoredData, DataType);
		end
	end

	-- Do dataset merge.
	EFM_SF_mergeTable(StoredData, EnhancedFlightMap_TaxiData);

	EFM_Globals[SDVersion] = StoredData[SDVersion];

	-- Notify user of successful data load.
	DEFAULT_CHAT_FRAME:AddMessage(format(EFM_MSG_DATALOAD, DataType), 0.5, 0.5, 1.0);
end

-- Function: Clear data for a specific faction
function EFM_Data_Clear(faction)
	-- Delete all data for the faction.
	EnhancedFlightMap_TaxiData[faction] = nil;

	-- If we have used the preload data, clear the preload verison string.
	if (EnhancedFlightMap_TaxiData[faction.."Version"] ~= nil) then
		EnhancedFlightMap_TaxiData[faction.."Version"] = nil;
	end

	-- Tell the user
	DEFAULT_CHAT_FRAME:AddMessage(format(EFM_MSG_CLEARFACTION, faction), 1.0, 0.2, 0.2);
end

-- Function: Clear all data so flightpaths can be re-learnt.
function EFM_Data_ClearAll()
	-- Turn off recording functions, just in case.
	EFM_Timer_StartRecording	= false;
	EFM_Timer_Recording		= false;
	
	-- Clear all Variables
	EnhancedFlightMap_TaxiData	= nil;
	EFM_Globals			= nil;
	EFM_MyConf			= nil;
	EFM_MyNodes			= nil;

	-- Reset the data tables as EFM will go nuts if the basic data is not defined.
	EFM_DefineData();
	EFM_ValidateVersions();

	-- Tell the user
	DEFAULT_CHAT_FRAME:AddMessage(EFM_MSG_CLEAR, 1.0, 0.2, 0.2);
end

-- Function: Clear a specific flight point from the list.
function EFM_Clear_FlightNode(flightNode)
	DEFAULT_CHAT_FRAME:AddMessage("EFM: Flight Node deletion disabled", 1.0, 0.2, 0.2);
	return;
--[[
	local currentFaction	= UnitFactionGroup("player");

	-- Erase actual node.
	if (EnhancedFlightMap_TaxiData[currentFaction][1][flightNode] ~= nil) then
		EnhancedFlightMap_TaxiData[currentFaction][1][flightNode] = nil;
		EFM_KnownPaths[currentFaction][1][flightNode] = nil;
	end
	
	if (EnhancedFlightMap_TaxiData[currentFaction][2][flightNode] ~= nil) then
		EnhancedFlightMap_TaxiData[currentFaction][2][flightNode] = nil;
		EFM_KnownPaths[currentFaction][2][flightNode] = nil;
	end

	-- Find flight node references in base data and remove those references.
	for zone, data in EnhancedFlightMap_TaxiData[currentFaction][1] do
		local zoneRoutes = data.routes;
		
		for routeNumber in zoneRoutes do
			if (zoneRoutes[routeNumber] == flightNode) then
				table.remove(zoneRoutes, routeNumber);
			end
		end
	end

	for zone, data in EnhancedFlightMap_TaxiData[currentFaction][2] do
		local zoneRoutes = data.routes;
		
		for routeNumber in zoneRoutes do
			if (zoneRoutes[routeNumber] == flightNode) then
				table.remove(zoneRoutes, routeNumber);
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage(format(EFM_MSG_DELETENODE, flightNode), 1.0, 0.5, 0.5);
]]
end

-- Function: Hidden function to convert flight node reference points to a new precision value.
function EFM_Data_FlightConvert(orgData, faction)
--	local precValue = EFM_Globals.DataPrecision ^ 10;

	DEFAULT_CHAT_FRAME:AddMessage("---");
	DEFAULT_CHAT_FRAME:AddMessage("EFM: Flight Data Conversion underway for "..faction);

	for continent = 1,2 do
		for zone, zoneData in orgData[faction][continent] do
			if (zone ~= "mapKnown") then
				local zoneNodeList = {};
				-- Create current node list table.
				for nodeLoc, nodeData in zoneData do
					table.insert(zoneNodeList, nodeLoc);
				end

				for index = 1, table.getn(zoneNodeList) do
					local nodeLoc	= zoneNodeList[index];
					local nodeData	= orgData[faction][continent][zone][zoneNodeList[index]];

					DEFAULT_CHAT_FRAME:AddMessage("Converting reference data for "..nodeData[GetLocale()]);

					-- Fix node position reference data
					local fmX, fmY = EFM_Data_NodeLocPrecision(nodeLoc);
					local newLoc = fmX..":"..fmY;

					-- Fix route references
					local nodeRoutes = {};
					for routeIndex = 1, table.getn(nodeData["routes"]) do
						local route = nodeData["routes"][routeIndex];
						local _, _, routeNum, routeLoc = string.find(route, "(.*)~(.*)");
						local routeX, routeY = EFM_Data_NodeLocPrecision(routeLoc);
						table.insert(nodeRoutes, routeNum.."~"..routeX..":"..routeY);
					end
					nodeData["routes"] = nodeRoutes;

					-- Fix timer data
					local tempTimerList = {};
					for routeRef, timeValue in nodeData["timers"] do
						local _, _, routeTimerNum, routeTimerLoc = string.find(routeRef, "(.*)~(.*)");
						local routeTimerX, routeTimerY = EFM_Data_NodeLocPrecision(routeTimerLoc);
						tempTimerList[routeTimerNum.."~"..routeTimerX..":"..routeTimerY] = timeValue;
					end
					nodeData["timers"] = tempTimerList;

					-- Set new location reference
					nodeData.fmLoc = newLoc;

					-- Delete old zone data
					orgData[faction][continent][zone][nodeLoc] = nil;

					-- Add updated zone data
					orgData[faction][continent][zone][newLoc] = nodeData;
				end
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("---");
end

-- Function: Return a fmX and fmY to the global precision from a given nodeLoc
function EFM_Data_NodeLocPrecision(nodeLoc)
	local _, _, nodeX, nodeY = string.find(nodeLoc, "(.*):(.*)");
	nodeX = tonumber(nodeX);
	nodeY = tonumber(nodeY);

	nodeX = EFM_SF_ValueToPrecision(nodeX, EFM_Globals.DataPrecision);
	nodeY = EFM_SF_ValueToPrecision(nodeY, EFM_Globals.DataPrecision);

	return nodeX, nodeY;
end

-- Function: Function to merge user-supplied data and the base data for use with the next release of EFM...
-- Please do not use this unless you know exactly what it means, this is why it's hidden at the bottom of the file and not usable via EFM!
function EFM_Merge_Data()
	-- Do dataset merge.
	EFM_SF_mergeTable(EFM_IMPORT_DATA, EnhancedFlightMap_TaxiData);

	-- Notify user of successful data load.
	DEFAULT_CHAT_FRAME:AddMessage("External Data Imported", 0.5, 0.5, 1.0);
end

-- Function: Hidden function to move a flight node to a new location marker.
function EFM_Data_FlightMove(orgData, fmX, fmY, faction)
	DEFAULT_CHAT_FRAME:AddMessage("---");
	DEFAULT_CHAT_FRAME:AddMessage(format(EFM_MSG_MOVENODE, orgData[GetLocale()]));

	local nodeName		= orgData[GetLocale()];
	local nodeContinent	= EFM_FN_GetNodeContinent(nodeName);
	local nodeZone		= EFM_FN_GetNodeZone(nodeName);
	local nodeOrgLoc		= orgData.fmLoc;
	local nodeNewLoc	= fmX..":"..fmY;
	local nodeRoutes		= orgData.routes;
	local nodeTimers		= orgData.timers;
	local nodeMapLoc		= orgData.mapLoc;
	local nodeName_enUS	= orgData.enUS;
	local nodeName_deDE	= orgData.deDE;
	local nodeName_frFR	= orgData.frFR;

	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeOrgLoc]		= nil;

	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc]		= {};
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].routes	= nodeRoutes;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].timers	= nodeTimers;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].mapLoc	= nodeMapLoc;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].fmLoc	= nodeNewLoc;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].enUS	= nodeName_enUS;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].deDE	= nodeName_deDE;
	EnhancedFlightMap_TaxiData[faction][nodeContinent][nodeZone][nodeNewLoc].frFR	= nodeName_frFR;

	for zone, zoneData in EnhancedFlightMap_TaxiData[faction][nodeContinent] do
		if (zone ~= "mapKnown") then
			local zoneNodeList = {};
			-- Create current node list table.
			for nodeLoc, nodeData in zoneData do
				table.insert(zoneNodeList, nodeLoc);
			end

			for index = 1, table.getn(zoneNodeList) do
				local nodeLoc	= zoneNodeList[index];
				local nodeData	= EnhancedFlightMap_TaxiData[faction][nodeContinent][zone][zoneNodeList[index]];

				DEFAULT_CHAT_FRAME:AddMessage("Converting reference data for "..nodeData[GetLocale()]);

				-- Fix route references
				local nodeRoutes = {};
				for routeIndex = 1, table.getn(nodeData["routes"]) do
					local route = nodeData["routes"][routeIndex];
					if (route ~= nodeZone.."~"..nodeNewLoc) then
						if (string.find(route, nodeZone.."~"..nodeOrgLoc) ~= nil) then
							nodeData["routes"][routeIndex] = nodeZone.."~"..nodeNewLoc;
						end
					else
						table.remove(nodeData["routes"], routeIndex);
					end
				end

				-- Fix timer data
				local tempTimerList = {};
				for routeRef, timeValue in nodeData["timers"] do
					local tempRoute = routeRef;
					if (tempRoute ~= nodeZone.."~"..nodeNewLoc) then
						if (string.find(routeRef, nodeZone.."~"..nodeOrgLoc) ~= nil) then
							tempRoute = nodeZone.."~"..nodeNewLoc;
						end
						tempTimerList[tempRoute] = timeValue;
					end
				end
				nodeData["timers"] = tempTimerList;
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("---");
end

-- Function: Only import the timing data for flight paths we already know
function EFM_Data_ImportKnownTimes(faction)
	local MergeData = getglobal("Default_EFM_Data_"..faction);

	if (EnhancedFlightMap_TaxiData[faction] ~= nil) then
		for continent = 1,2 do
			if (EnhancedFlightMap_TaxiData[faction][continent] ~= nil) then
				for zone, zoneData in EnhancedFlightMap_TaxiData[faction][continent] do
					if (zone ~= "mapKnown") then
						local zoneNodeList = {};
						for nodeLoc, nodeData in zoneData do
							table.insert(zoneNodeList, nodeLoc);
						end
						for index = 1, table.getn(zoneNodeList) do
							local nodeData	= EnhancedFlightMap_TaxiData[faction][continent][zone][zoneNodeList[index]];
							for routeIndex = 1, table.getn(nodeData["routes"]) do
								local route = EnhancedFlightMap_TaxiData[faction][continent][zone][zoneNodeList[index]]["routes"][routeIndex];
								local routeTime = EnhancedFlightMap_TaxiData[faction][continent][zone][zoneNodeList[index]]["timers"][route];
								local mergeTime = MergeData[faction][continent][zone][zoneNodeList[index]]["timers"][route];
								if (mergeTime ~= nil) then
									if (routeTime ~= nil) then
										if (abs(mergeTime - routeTime) > 60) then
											routeTime = mergeTime;
										else
											routeTime = floor((routeTime + mergeTime) / 2);
										end
									else
										routeTime = mergeTime;
									end
								end
								EnhancedFlightMap_TaxiData[faction][continent][zone][zoneNodeList[index]]["timers"][route] = routeTime;
							end
						end
					end
				end
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage(format(EFM_MSG_DATALOADTIMERS, faction));
end
