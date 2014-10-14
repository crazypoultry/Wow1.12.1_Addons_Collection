--[[--------------------------
Variables
--------------------------]]--

-- Saved Variables
TITANDKPSavedInfo = {};
TITANDKPRaid = {};

-- Local Variables
local TitanDKPRealm = "";
local TitanDKPName = "";
local TitanDKPClass = "";
local TitanDKPDate = "";
local TitanDKPCurrentSystem = "DKP";

-- graphic settings
local TitanDKPInfoName = "";
local TitanDKPRaidSort = "name";
local TitanDKPRaidFilter = "";
local TitanDKPSavedSort = "name";
local TitanDKPSavedFilter = "";
local TitanDKPInfoSort = "name";
local TitanDKPInfoFilter = "";
local TitanDKPBackdrop = {
	bgFile = "Interface\\TutorialFrame\\TutorialFrameBackground",
	edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
	tile = true, tileSize = 32, edgeSize = 16,
	insets = {left = 5, right = 5, top = 5, bottom = 5}
	};

-- initialization timing controls
local TitanDKPinitstarted = 0;
local TitanDKPinitdone = 0;

--[[--------------------------------
Initialization Functions
--------------------------------]]--

-- Constructor
function TitanPanelTITANDKPButton_OnLoad()
    -- register events
	this:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("CHAT_MSG_ADDON");
	
	-- slash command
	SLASH_TITANDKP1 = "/titandkp";
	SlashCmdList["TITANDKP"] = TitanDKPCommand;
	
	--Create Titan Object
	this.registry = {
		id = TITANDKP_ID,
		menuText = "DKP",
		icon = TITANDKP_ICON,
		iconWidth = 16,
		buttonTextFunction = "TitanPanelTITANDKPButton_GetButtonText",
		tooltipTitle = TITANDKP_TOOLTIPTITLE,
		tooltipTextFunction = "TitanPanelTITANDKPButton_GetTooltipText",
		category = TITANDKP_CATEGORY,
		frequency = 1,
		savedVariables = {
			ShowLabel = 1,
			ShowIcon = 1,
		}
	};
end

-- initialize variables at start
function TitanDKPInitialize()
	-- return if it's already begun
	if (TitanDKPinitstarted == 1) then
		return TitanDKPinitdone;
	end
	TitanDKPinitstarted = 1;
	
    TitanDKPRealm = GetCVar("realmName");
    TitanDKPName = UnitName("player");
    TitanDKPClass = UnitClass("player");
    TitanDKPDate = date(TITANDKP_DATE);
    
	TitanDKPRaidSort = "name";
	TitanDKPSavedSort = "name";
	
	if (not TITANDKPSavedInfo) then
		TITANDKPSavedInfo = {};
	end
	
	if (not TITANDKPRaid) then
		TITANDKPRaid = {};
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"]) then
		TITANDKPSavedInfo["DKPSystem"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm]) then
		TITANDKPSavedInfo[TitanDKPRealm] = {};
	end
	
	-- init settings
	TitanDKPInitPlayer(TitanDKPName);
	TitanDKPCurrentSystem = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].CurrentDKPSystem;
	TitanDKPInitSystem(TitanDKPCurrentSystem);
	TitanDKPChangePoints();
	
	-- Check that raid still exists
	if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and GetNumRaidMembers() == 0) then
		TitanDKPSaveRaid();
		TitanDKPLeaveRaid();
	end
	
	-- check that raid is empty if not in a raid
	if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][TitanDKPName]) then
		TitanDKPLeaveRaid();
	end
	
	-- add people with saved points to raid, if not already present
	for name, values in TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"] do
		if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and TitanDKPUnitInRaid(name) 
			and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][name]) then
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][name] = values.currentDKP;
		end
	end
	
	-- add start points if not present
	if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][TitanDKPName]) then
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][TitanDKPName] = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName].currentDKP
	end

	TitanDKPUpdateFrames();
	
	TitanDKPinitdone = 1;
	
	-- perform cleaning on raids
	TitanDKPCleanRaids();
end

-- initialize a player
function TitanDKPInitPlayer(name)
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]) then
		TITANDKPSavedInfo[TitanDKPRealm][name] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name].CurrentDKPSystem) then
		TITANDKPSavedInfo[TitanDKPRealm][name].CurrentDKPSystem = "DKP";
	end

	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["started"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["started"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name].currentZone) then
		TITANDKPSavedInfo[TitanDKPRealm][name].currentZone = "";
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["raid"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["raid"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["items"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["items"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["unassigneditems"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["unassigneditems"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["killed"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["killed"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["announced"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["announced"] = {};
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["anchor"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["anchor"] = {};
		TITANDKPSavedInfo[TitanDKPRealm][name]["anchor"].x = 300;
		TITANDKPSavedInfo[TitanDKPRealm][name]["anchor"].y = -200;
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["optionsanchor"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["optionsanchor"] = {};
		TITANDKPSavedInfo[TitanDKPRealm][name]["optionsanchor"].x = 300;
		TITANDKPSavedInfo[TitanDKPRealm][name]["optionsanchor"].y = -200;
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["raidanchor"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["raidanchor"] = {};
		TITANDKPSavedInfo[TitanDKPRealm][name]["raidanchor"].x = 200;
		TITANDKPSavedInfo[TitanDKPRealm][name]["raidanchor"].y = -100;
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["savedanchor"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["savedanchor"] = {};
		TITANDKPSavedInfo[TitanDKPRealm][name]["savedanchor"].x = 200;
		TITANDKPSavedInfo[TitanDKPRealm][name]["savedanchor"].y = -100;
	end
	
	if (not TITANDKPSavedInfo[TitanDKPRealm][name]["infoanchor"]) then
		TITANDKPSavedInfo[TitanDKPRealm][name]["infoanchor"] = {};
		TITANDKPSavedInfo[TitanDKPRealm][name]["infoanchor"].x = TITANDKPSavedInfo[TitanDKPRealm][name]["savedanchor"].x + 200;
		TITANDKPSavedInfo[TitanDKPRealm][name]["infoanchor"].y = -100;
	end
end

-- initialize a TitanDKP system
function TitanDKPInitSystem(system)
	-- global system settings
	if (not TITANDKPSavedInfo["DKPSystem"][system]) then
		TITANDKPSavedInfo["DKPSystem"][system] = {};
		TITANDKPSavedInfo["DKPSystem"][system].stoponkill = true;
		TITANDKPSavedInfo["DKPSystem"][system].autodkp = true;
		TITANDKPSavedInfo["DKPSystem"][system].onlyAdd = true;
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"][system]["instance"]) then
		TITANDKPSavedInfo["DKPSystem"][system]["instance"] = {};
	end
	
	for name, zone in TITANDKP_ZONES do
		if (not TITANDKPSavedInfo["DKPSystem"][system]["instance"][name]) then
			TITANDKPSavedInfo["DKPSystem"][system]["instance"][name] = {};
			TITANDKPSavedInfo["DKPSystem"][system]["instance"][name].boss = 0;
			TITANDKPSavedInfo["DKPSystem"][system]["instance"][name].entrance = 0;
		end
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"][system].threshold) then
		TITANDKPSavedInfo["DKPSystem"][system].threshold = 3;
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"][system]["saved"]) then
		TITANDKPSavedInfo["DKPSystem"][system]["saved"] = {};
	end

	-- self specific system settings
	if (not TITANDKPSavedInfo["DKPSystem"][system]["saved"][TitanDKPName]) then
		TitanDKPChangePoints(nil, nil, system, TitanDKPClass);
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"][system]["saved"][TitanDKPName]["alts"]) then
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][TitanDKPName]["alts"] = {};
	end
	
	TitanDKPUpdateFrames();
end

-- clean raids older than a week
function TitanDKPCleanRaids()
	local month = tonumber(date("%m"));
	local day = tonumber(date("%d")) - 7;
	local year = tonumber(date("%y"));
	
	for zone, val1 in TITANDKPRaid do
		local numTimes = 0;
		for time, val2 in val1 do
			local i = 0;
			for w in string.gfind(time, "%d+") do
				if (i == 0 and tonumber(w) < month) then
					TITANDKPRaid[zone][time] = nil;
				elseif (i == 1 and tonumber(w) < day) then
					TITANDKPRaid[zone][time] = nil;
				elseif (i == 2 and tonumber(w) < year) then
					TITANDKPRaid[zone][time] = nil;
				else
					numTimes = numTimes + 1;
				end
				i = i + 1;
			end
		end
		
		if (numTimes == 0) then
			TITANDKPRaid[zone] = nil;
		end
	end
end

--[[--------------------------------
Slash Command Functions
--------------------------------]]--

-- Slash Commands
function TitanDKPCommand(cmd)
	local command = {};
	local i = 0;
	
	-- parse command
	for w in string.gfind(cmd, "%S+") do
		command[i] = w;
		i = i + 1;
	end
	
	-- help
	if (command[0] == TITANDKP_HELPCOMMAND or not command[0]) then
		TitanDKPOutput(TITANDKP_HELP1);
		TitanDKPOutput(TITANDKP_HELP2);
		TitanDKPOutput(TITANDKP_HELP3);
		TitanDKPOutput(TITANDKP_HELP4);
		TitanDKPOutput(TITANDKP_HELP5);
		TitanDKPOutput(TITANDKP_HELP6);
		
	-- add player
	elseif (command[0] == TITANDKP_ADDCOMMAND and command[1] == TITANDKP_PERSONCOMMAND and command[2]) then
		local result = TitanDKPAddPlayerCommand(command);
		if (not result) then
			TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. command[2] .. TITANDKP_ADDCOMMANDCOMPLETE2);
		else
			-- name already present
			TitanDKPOutput(TITANDKP_ADDCOMMANDFAILED1 .. result .. TITANDKP_ADDCOMMANDFAILED2);
		end
		
	-- add TitanDKP system
	elseif (command[0] == TITANDKP_ADDCOMMAND and command[1] == TITANDKP_SYSTEMCOMMAND and command[2]) then
		if (not TITANDKPSavedInfo["DKPSystem"][command[2]]) then
			TitanDKPInitSystem(command[2]);
			TitanDKPOutput(TITANDKP_SYSTEMADDCOMMANDCOMPLETE1 .. command[2] .. TITANDKP_ADDCOMMANDCOMPLETE2);
		else
			-- system exists
			TitanDKPOutput(TITANDKP_SYSTEMADDCOMMANDFAILED1 .. command[2] .. TITANDKP_ADDCOMMANDFAILED2);
		end
		
	-- remove player
	elseif (command[0] == TITANDKP_REMOVECOMMAND and command[1] == TITANDKP_PERSONCOMMAND and command[2]) then
		local result = TitanDKPRemoveCommand(command);
		if (result) then
			TitanDKPOutput(TITANDKP_REMOVECOMMANDCOMPLETE1 .. result .. TITANDKP_ADDCOMMANDCOMPLETE2);
		else
			-- player not found
			TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED1);
		end
		
	-- remove TitanDKP system
	elseif (command[0] == TITANDKP_REMOVECOMMAND and command[1] == TITANDKP_SYSTEMCOMMAND and command[2]) then
		local result = TitanDKPRemoveSystemCommand(command);
		if (result) then
			TitanDKPOutput(TITANDKP_REMOVECOMMANDCOMPLETE1 .. result .. TITANDKP_SYSTEMREMOVECOMMANDCOMPLETE2);
		else
			-- system doesn't exist
			TitanDKPOutput(TITANDKP_SYSTEMADDCOMMANDFAILED1 .. command[2] .. TITANDKP_SYSTEMREMOVECOMMANDFAILED1);
		end
		
	-- change player
	elseif (command[0] == TITANDKP_CHANGECOMMAND and command[1] == TITANDKP_PERSONCOMMAND and command[2]) then
		local result = TitanDKPChangePlayerCommand(command);
		if (result) then
			TitanDKPOutput(TITANDKP_CHANGECOMMANDCOMPLETE1 .. result .. TITANDKP_ADDCOMMANDCOMPLETE2);	
		else
			-- name not found
			TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED1);
		end
		
	-- change raid TitanDKP
	elseif (command[0] == TITANDKP_CHANGECOMMAND and command[1] == TITANDKP_RAIDCOMMAND and command[2]) then
		local result = TitanDKPChangeRaidCommand(command);
		if (result) then
			TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. result .. TITANDKP_CHANGECOMMANDCOMPLETE3);
		else
			-- bad number
			TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED2);
		end
		
	-- search
	elseif (command[0] == TITANDKP_SEARCHCOMMAND) then
		local result = TitanDKPSearchCommand(command);
		if (result) then
			TitanDKPOutput(TITANDKP_SEARCHCOMMANDCOMPLETE1);
			for key, value in result do
				TitanDKPOutput(value.name .. " (" .. value.class .. "): " .. value.currentDKP);
			end
		else
			-- nothing found
			TitanDKPOutput(TITANDKP_SEARCHCOMMANDFAILED1);
		end
		
	-- change current TitanDKP
	elseif (TitanDKPCalculate(command[0])) then
		local points0 = TitanDKPCalculate(command[0]);
		TitanDKPChangePoints(nil, points0);
		TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. points0 .. TITANDKP_CALCCOMMANDCOMPLETE2);
		
	-- wrong format
	else
		TitanDKPOutput(TITANDKP_COMMANDFAILED1);
	end

	TitanDKPUpdateFrames();
end

-- do a search
function TitanDKPSearchCommand(command)
	local result = {};
	local i = 0;

	for number, searchval in TitanDKPSortedPairs(command) do
		if (command[1] ~= TITANDKP_RAIDCOMMAND and number > 0) then
			-- search in saved
			for name, value in TitanDKPSortedPairs(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"], TitanDKPComparator) do
				if (string.find(string.lower(name), string.lower(searchval)) or string.lower(searchval) == string.lower(value.class)) then
					result[i] = {};
					result[i].name = name;
					result[i].class = value.class;
					result[i].currentDKP = value.currentDKP;
					i = i + 1;
				end
			end
		elseif (command[1] == TITANDKP_RAIDCOMMAND and number > 1) then
			-- search in raid
			for name, startdkp in TitanDKPSortedPairs(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"], TitanDKPComparator) do
				local class = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].class;
				local points = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP;
				if (string.find(string.lower(name), string.lower(searchval)) or string.lower(searchval) == string.lower(class)) then
					result[i] = {};
					result[i].name = name;
					result[i].class = class;
					result[i].currentDKP = points;
					i = i + 1;
				end
			end
		end
	end
	
	if (i == 0) then
		-- found nothing
		return nil;
	end
	
	return result;
end

-- add a player, return name if found
function TitanDKPAddPlayerCommand(command)
	local name2 = TitanDKPFindName(command[2]);
	local class3 = TitanDKPFindClass(command[3]);
	local points3 = TitanDKPCalculate(command[3]);
	local points4 = TitanDKPCalculate(command[4]);
	
	if (name2) then
		-- name found
		return name2;
	end
	
	TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][command[2]] = {};
	if (points3) then
		-- name points
		TitanDKPChangePoints(command[2], points3);
	elseif (points4) then
		-- name class points
		TitanDKPChangePoints(command[2], points4, nil, class3);
	elseif (class3) then
		-- name class
		TitanDKPChangePoints(command[2], nil, nil, class3);
	else
		-- name
		TitanDKPChangePoints(command[2]);
	end
	
	return nil;
end

-- remove player
function TitanDKPRemoveCommand(command)
	local name2 = TitanDKPFindName(command[2]);
	local class = "";
	
	if (name2) then
		-- remove from variables
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][name2] = nil;		
		TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name2] = nil;
		TITANDKPSavedInfo[TitanDKPRealm][name2] = nil;
		
		if (name2 == TitanDKPName) then
			-- init self if removed
			TitanDKPInitPlayer(name2);
			TitanDKPInitSystem(TitanDKPCurrentSystem);
			TitanDKPChangePoints(name2, nil, nil, TitanDKPClass);
		end
	else
		-- name not found
		return nil
	end
	
	return name2;
end

-- remove TitanDKP system
function TitanDKPRemoveSystemCommand(command)
	local name2 = command[2];

	if (TITANDKPSavedInfo["DKPSystem"][name2]) then
		-- remove system
		TITANDKPSavedInfo["DKPSystem"][name2] = nil
		
		-- make sure current system is set for all players
		for player, val in TITANDKPSavedInfo[TitanDKPRealm] do
			if (val.CurrentDKPSystem == name2) then
				TitanDKPInitSystem("DKP");
				TITANDKPSavedInfo[TitanDKPRealm][player].CurrentDKPSystem = "DKP";
				if (player == TitanDKPName) then
					TitanDKPCurrentSystem = "DKP";
				end
			end
		end
	else
		-- system doesn't exist
		return nil
	end
	
	return name2;
end

-- change a player, return false if not found
function TitanDKPChangePlayerCommand(command)
	local name2 = TitanDKPFindName(command[2]);
	local class3 = TitanDKPFindClass(command[3]);
	local points3 = TitanDKPCalculate(command[3]);
	local points4 = TitanDKPCalculate(command[4]);
	
	if (not name2) then
		-- name not found
		return nil;
	end
	
	if (points3) then
		-- name points
		class3 = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name2].class;
		TitanDKPChangePoints(name2, points3);
	elseif (points4) then
		-- name class points
		TitanDKPChangePoints(name2, points4, nil, class3);
	elseif (class3) then
		-- name class
		TitanDKPChangePoints(name2, nil, nil, class3);
	else
		-- name
		class3 = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name2].class;
		TitanDKPChangePoints(name2);
	end
	
	return name2;
end

-- change raid points
function TitanDKPChangeRaidCommand(command)
	local points2 = TitanDKPCalculate(command[2]);

	if (points2) then
		for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
			if (TitanDKPUnitInRaid(name)) then
				TitanDKPChangePoints(name, points2);
			end
		end
	else
		-- number not correct
		return nil;
	end
	
	return points2;
end

--[[--------------------------------
Automatic TitanDKP functions
--------------------------------]]--

-- Catch Events for autodetection
function TitanPanelTITANDKP_OnEvent(event)
	-- Majordomo catch
	if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp 
		and event == "CHAT_MSG_MONSTER_YELL") then
		if(arg1 == TITANDKP_MAJORDOMOYELL) then
			for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
				if (TitanDKPUnitInRaid(name)) then
					TitanDKPChangePoints(name, TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["MC"].boss);
				end
			end
			TitanDKPOutput(TITANDKP_MAJORDOMO .. TITANDKP_KILLTEXT .. TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["MC"].boss .. TITANDKP_ENDTEXT);
			TitanDKPSaveRaid();
		end

	-- Addon Message
	elseif (event == "CHAT_MSG_ADDON" and arg3 == "RAID" and arg1 == "TITANDKP" 
		and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp 
		and arg4 ~= TitanDKPName) then
		-- boss kill
		local points = TitanDKPGetBossPoints(arg2);
		if (points and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][arg2]) then
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["announced"][arg2] = 1;
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][arg2] = 1;
			
			for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
				if (TitanDKPUnitInRaid(name)) then
					TitanDKPChangePoints(name, points);
				end
			end
			TitanDKPOutput(arg2 .. TITANDKP_KILLTEXT .. points .. TITANDKP_ENDTEXT);
		elseif (string.sub(arg2, 1, 5) == "LOOT ") then
			-- Loot message
			local message = {};
			local i = 0;
			
			-- parse message
			for w in string.gfind(arg2, "%_") do
				message[i] = w;
				i = i + 1;
			end
			if (message[1] and message[2] and tonumber(message[3]) and tonumber(message[4])) then
				local name = message[1];
				local player = message[2];
				local rarity = tonumber(message[3]);
				local theirTotal = tonumber(message[4]);
			else
				return nil;
			end
			
			-- init variables
			if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name]) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name] = {};
			end
			if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player]) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] = 0;
			end
			if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name]) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name] = {};
			end
			if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player]) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player] = {};
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].count = 0;
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].dkp = 0;
			end
			
			-- add up total amount of this item looted for this char
			local ourTotal = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] + TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].count;
			
			-- add item if new, and above your threshold
			if (ourTotal < theirTotal 
				and rarity >= TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].threshold) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] + 1;
				TitanDKPSaveRaid();
			end
		end
	
	-- Boss Kill
	elseif (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp 
		and event == "CHAT_MSG_COMBAT_HOSTILE_DEATH") then
		for unit in string.gfind(arg1, TitanDKP_ConvertGlobalString(UNITDIESOTHER)) do
			local points = TitanDKPGetBossPoints(unit);				
			if (points and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][unit]) then
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][unit] = 1;
				if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["announced"][unit]) then
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["announced"][unit] = 1;
					SendAddonMessage("TITANDKP", unit, "RAID");
				end
				
				for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
					if (TitanDKPUnitInRaid(name)) then
						TitanDKPChangePoints(name, points);
					end
				end
				TitanDKPOutput(unit .. TITANDKP_KILLTEXT .. points .. TITANDKP_ENDTEXT);
				TitanDKPSaveRaid();
			end
		end
		
	-- Left Raid
	elseif (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and event == "RAID_ROSTER_UPDATE" and GetNumRaidMembers() == 0) then
		TitanDKPSaveRaid();
		TitanDKPLeaveRaid();
		TitanDKPUpdateFrames();
	
	-- Entered Raid
	elseif (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp
		and event == "RAID_ROSTER_UPDATE" and GetNumRaidMembers() > 0) then
		TitanDKPJoinRaid();
		TitanDKPGetNewMembers();
		TitanDKPSaveRaid();
		
	-- Someone may have entered raid
	elseif (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and event == "RAID_ROSTER_UPDATE"
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp) then
		TitanDKPGetNewMembers();
		TitanDKPSaveRaid();
	
	-- Zoned while in raid and haven't zoned in before
	elseif (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TitanDKPGetZonePoints(GetZoneText()) 
		and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["started"][GetZoneText()] 
		and event == "ZONE_CHANGED_NEW_AREA") then
		local zoneText = GetZoneText();
		local points = TitanDKPGetZonePoints(zoneText);
		if (points) then
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["started"][zoneText] = 1;
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone = zoneText;
			
			if (TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp
				and (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].stoponkill 
				or table.getn(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"]) == 0)) then
				for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
					if (TitanDKPUnitInRaid(name)) then
						TitanDKPChangePoints(name, points);
					end
				end
				TitanDKPOutput(TITANDKP_STARTTEXT1 .. zoneText .. TITANDKP_STARTTEXT2 .. points .. TITANDKP_ENDTEXT);
				TitanDKPSaveRaid();
			end
		end
		
	-- Item looted
	elseif (event == "CHAT_MSG_LOOT" and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid 
		and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp) then
		local player, link;
		
		-- parse the message
		local iStart, iEnd, playerName, item = string.find(arg1, TITANDKP_LOOT);
		if (playerName) then
			player = playerName;
			link = item;
		else
			iStart, iEnd, item = string.find(arg1, TITANDKP_SELFLOOT);
			if (item) then
				player = TitanDKPName;
				link = item;
			end
		end
		
		-- add to list
		if (player and link) then
			local itStart, itEnd, color, itemName, name = string.find(link, TITANDKP_ITEMSTRING);
			local rarity  = TITANDKP_RARITY[color];
			
			if (rarity >= TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].threshold) then
				-- init variables
				if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name]) then
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name] = {};
				end
				if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player]) then
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] = 0;
				end
				if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name]) then
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name] = {};
				end
				if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player]) then
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player] = {};
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].dkp = 0;
					TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].count = 0;
				end
				
				-- add to list of items to have points input
				TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] + 1;
				
				-- add up total amount of the item looted for this char
				local totalCount = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name][player] + TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][name][player].count;
				
				-- send loot event
				SendAddonMessage("TITANDKP", "LOOT_" .. name .. "_" .. player .. "_" .. rarity .. "_" .. totalCount, "RAID");
				TitanDKPSaveRaid();
			end
		end
	end
end

-- adds new people to raid
function TitanDKPGetNewMembers()
	for i = 0, GetNumRaidMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(i);
		
		if (name and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid
			and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp 
			and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][name]) then
			TitanDKPChangePoints(name, nil, nil, class);
			TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][name] = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP;
					
			-- add points for being in the instance if you're already in the instance
			local points = TitanDKPGetZonePoints(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone);
			if (points and (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].stoponkill 
				or table.getn(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"]) == 0)
				and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["started"][TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone]) then
				TitanDKPChangePoints(name, points, nil, class);
			end
		end
	end
	TitanDKPUpdateFrames();
end

-- copy raid info to upload info
function TitanDKPSaveRaid()
	local zone = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone;
	
	-- haven't zoned in yet
	if (zone == "" or not zone) then
		return nil;
	end

	-- make sure upload data is present for this instance
	if (not TITANDKPRaid) then
		TITANDKPRaid = {};
	end
	if (not TITANDKPRaid[zone]) then
		TITANDKPRaid[zone] = {};
	end
	if (not TITANDKPRaid[zone][TitanDKPDate]) then
		TITANDKPRaid[zone][TitanDKPDate] = {};
	end
	if (not TITANDKPRaid[zone][TitanDKPDate]["players"] ) then
		TITANDKPRaid[zone][TitanDKPDate]["players"] = {};
	end
	if (not TITANDKPRaid[zone][TitanDKPDate]["items"] ) then
		TITANDKPRaid[zone][TitanDKPDate]["items"] = {};
	end
	
	-- add players to upload info
	for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
		TITANDKPRaid[zone][TitanDKPDate]["players"][name] = {};
		TITANDKPRaid[zone][TitanDKPDate]["players"][name].dkp = TitanDKPRound(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP - startdkp);
		TITANDKPRaid[zone][TitanDKPDate]["players"][name].class = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].class;
	
		if (not TITANDKPRaid[zone][TitanDKPDate]["players"][name]["alts"]) then
			TITANDKPRaid[zone][TitanDKPDate]["players"][name]["alts"] = {};
		end
		
		-- add alts
		for alt, val in TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name]["alts"] do
			TITANDKPRaid[zone][TitanDKPDate]["players"][name]["alts"][alt] = 1;
		end
	end
	
	-- add items to upload info
	for item, playerval in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"] do
		for player, playervals in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][item] do
			if (not TITANDKPRaid[zone][TitanDKPDate]["items"][item]) then
				TITANDKPRaid[zone][TitanDKPDate]["items"][item] = {};
			end
			if (not TITANDKPRaid[zone][TitanDKPDate]["items"][item][player]) then
				TITANDKPRaid[zone][TitanDKPDate]["items"][item][player] = {};
			end
			
			if (not TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].count) then
				TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].count = playervals.count;
				TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].dkp = playervals.dkp;
			else
				TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].count = TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].count + playervals.count;
				TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].dkp = TITANDKPRaid[zone][TitanDKPDate]["items"][item][player].dkp + playervals.dkp;
			end
		end
	end
	
	-- clear stored items, now that they are saved
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"] = {};
	
	TitanDKPUpdateFrames();
end

--[[--------------------------------
Titan Menu Functions
--------------------------------]]--

-- Menu text
function TitanPanelTITANDKPButton_GetButtonText(id)
	-- initialize catch, in case this loads first
	if (TitanDKPInitialize() == 0) then
		return "DKP: 0";
	end
	local current = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName].currentDKP;

	return TitanDKPCurrentSystem .. ": " .. current .. " (" .. current + TitanDKPGetAltDKP(TitanDKPName) .. ")";
end

-- Tooltip text
function TitanPanelTITANDKPButton_GetTooltipText()
	if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid) then
		local current = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName].currentDKP;
		local start = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][TitanDKPName];
		
		return TITANDKP_STARTDKP .. start .. "\n" .. TITANDKP_CHANGEDDKP .. (current - start) .. "\n" .. TITANDKP_CURRENTDKP .. current .. "\n";
	else
		return TITANDKP_NOTINRAID;
	end
end

-- right click menu
function TitanPanelRightClickMenu_PrepareTITANDKPMenu()
	-- initialize catch, in case this loads first
	if (TitanDKPInitialize() == 0) then
		return nil;
	end
	
	local info = {};
	if (UIDROPDOWNMENU_MENU_LEVEL == 1) then
		-- altlist
		if (TitanDKPAltExists()) then
			info = {};
			info.text = TITANDKP_ALTLIST;
			info.hasArrow = 1;
			info.value = TITANDKP_ALTLIST;
			UIDropDownMenu_AddButton(info);
		end
		
		-- TitanDKP system
		info = {};
		info.text = TITANDKP_SYSTEMLIST;
		info.hasArrow = 1;
		info.value = TITANDKP_SYSTEMLIST;
		UIDropDownMenu_AddButton(info);
		
		-- Item list
		if (TitanDKPItemsExist()) then
			info = {};
			info.text = TITANDKP_ITEMLIST;
			info.hasArrow = 1;
			info.value = TITANDKP_ITEMLIST;
			UIDropDownMenu_AddButton(info);
		end
		
		TitanPanelRightClickMenu_AddSpacer();
		TitanPanelRightClickMenu_AddTitle(TITANDKP_OPTIONLIST);
		
		-- view raid frame
		info = {};
		info.text = TITANDKP_RAIDOPTION;
		info.func = TitanDKPShowPlayerWindow;
		info.arg1 = "raid";
		info.checked = nil;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		-- view saved player frame
		info = {};
		info.text = TITANDKP_SAVEDOPTION;
		info.func = TitanDKPShowPlayerWindow;
		info.arg1 = "saved";
		info.checked = nil;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		-- import data
		if (dkp_info) then
			info = {};
			info.text = TITANDKP_IMPORTOPTION;
			info.func = TitanPanelTITANDKPButton_ImportData;
			info.checked = nil;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		
		-- reset raid
		if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid) then
			info = {};
			info.text = TITANDKP_REVERT;
			info.func = TitanPanelTITANDKPButton_ResetSession;
			info.checked = nil;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		
		-- Hide Addon
		TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITANDKP_ID, TITAN_PANEL_MENU_FUNC_HIDE);
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2 and this.value == TITANDKP_ALTLIST) then
		-- add alt characters to menu
		for name, values in TitanDKPSortedPairs(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"], TitanDKPComparator) do
			if (name ~= TitanDKPName and TITANDKPSavedInfo[TitanDKPRealm][name]) then
				info = {};
				info.text = name .. ": " .. values.currentDKP .. " (" .. values.currentDKP + TitanDKPGetAltDKP(name) .. ")";
				info.textR = TitanDKPGetClassRed(values.class);
				info.textG = TitanDKPGetClassGreen(values.class);
				info.textB = TitanDKPGetClassBlue(values.class);
				info.func = TitanDKPAltCheck;
				info.keepShownOnClick = 1;
				info.checked = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName]["alts"][name];
				info.arg1 = name;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2 and this.value == TITANDKP_SYSTEMLIST) then
		-- add systems to menu
		for system, values in TitanDKPSortedPairs(TITANDKPSavedInfo["DKPSystem"], TitanDKPComparator) do
			info = {};
			info.text = system;
			info.func = TitanDKPSystemCheck;
			info.checked = TitanDKPCurrentSystem == system;
			info.arg1 = system;
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		end
		
		-- option to add system
		TitanPanelRightClickMenu_AddSpacer(UIDROPDOWNMENU_MENU_LEVEL);
		info = {};
		info.text = TITANDKP_SYSTEMADD;
		info.func = TitanDKPOpenInput;
		info.arg1 = "system";
		info.checked = nil;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		-- option to delete system
		info = {};
		info.text = TITANDKP_SYSTEMDEL;
		info.func = TitanDKPRemoveSystemCommand;
		info.arg1 = {nil, TitanDKPCurrentSystem};
		info.checked = nil;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		-- Enable System
		info = {};
		info.text = TITANDKP_ENABLEOPTION;
		info.func = TitanDKPEnableCheck;
		info.checked = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp;
		info.keepShownOnClick = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
		
		-- system settings
		info = {};
		info.text = TITANDKP_AUTOOPTIONS;
		info.func = TitanPanelTITANDKPAuto_Options;
		info.checked = nil;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	elseif (UIDROPDOWNMENU_MENU_LEVEL == 2 and this.value == TITANDKP_ITEMLIST) then
		-- item list if present
		for name, playerval in TitanDKPSortedPairs(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"], TitanDKPComparator) do
			for player, count in TitanDKPSortedPairs(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][name], TitanDKPComparator) do
				info = {};
				
				if (count > 1) then
					info.text = name .. ": " .. player .. " (" .. count .. ")";
				else
					info.text = name .. ": " .. player;
				end
				info.func = TitanDKPOpenItemInput;
				info.arg1 = name;
				info.arg2 = player;
				info.checked = nil;
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
			end
		end
	end
end

-- alt checked
function TitanDKPAltCheck(arg1)
	if (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName]["alts"][arg1]) then
		TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName]["alts"][arg1] = 1;
	else
		TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName]["alts"][arg1] = nil;
	end
end

-- enable checked
function TitanDKPEnableCheck()
	if (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp) then
		TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp = 1;
		
		-- Check that raid isn't present
		if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and GetNumRaidMembers() > 0) then			
			TitanDKPJoinRaid();
			TitanDKPGetNewMembers();
			TitanDKPSaveRaid();
		end
	else
		TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp = nil;
	end
end

-- System Checked
function TitanDKPSystemCheck(arg1)
	TitanDKPInitSystem(arg1);
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].CurrentDKPSystem = arg1;
	TitanDKPCurrentSystem = arg1;
		
	-- Check that raid isn't present
	if (TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].autodkp 
		and not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid and GetNumRaidMembers() > 0) then			
		TitanDKPJoinRaid();
		TitanDKPGetNewMembers();
		TitanDKPSaveRaid();
	end
		
	TitanDKPUpdateFrames();
end

-- import dkp_info data
function TitanPanelTITANDKPButton_ImportData()
	if (dkp_info and dkp_info["members"]) then
		for name, values in dkp_info["members"] do
			local playerName = TitanDKPFindName(name);
			local playerPoints = TitanDKPCalculate(values["dkp"]);
			local playerClass = TitanDKPFindClass(values["class"]);
			
			if (not playerName) then
				playerName = name;
			end
			if (not playerPoints) then
				playerPoints = 0;
			end
			
			TitanDKPChangePoints(playerName, playerPoints, nil, playerClass, true);
			
			-- import alts
			if (values["alts"]) then
				for alt, altval in values["alts"] do
					if (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name]["alts"]) then
						TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name]["alts"] = {};
					end
					TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name]["alts"][alt] = 1;
				end
			end
		end
		TitanDKPUpdateFrames();
	end
end

-- reset session
function TitanPanelTITANDKPButton_ResetSession()
	-- reset raid points
	for name, startdkp in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] do
		TitanDKPChangePoints(name, startdkp - TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP);
	end
	TitanDKPOutput(TITANDKP_REVERTCOMPLETE);
	TitanDKPUpdateFrames();
end

-- Titan click catcher
function TitanPanelTITANDKPButton_OnClick(button)
	local frameString = "TitanDKPInputFrame";
	local frame = getglobal(frameString);
	
	if (frame and frame:IsVisible()) then
		frame:Hide();
	else
		TitanDKPOpenInput("dkp", button);
	end
end

-- check for alts
function TitanDKPAltExists()
	for name, value in TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName]["alts"] do
		if (name ~= TitanDKPName) then
			return true;
		end
	end
	for name, value in TITANDKPSavedInfo[TitanDKPRealm] do
		if (name ~= TitanDKPName and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name]) then
			return true;
		end
	end
	return false;
end

-- check for unassigned items
function TitanDKPItemsExist()
	for name, value in TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"] do
		return true;
	end
	return false;
end

-- Hide all the frames
function TitanPanelTITANDKP_OnHide()
	local childStringList = {"TitanDKPItemInputFrame", "TitanDKPSystemInputFrame", "TitanDKPInputFrame", 
		"TitanDKPOptionFrame", "TitanDKPRaidFrame", "TitanDKPSavedFrame"};
	
	for key, children in childStringList do
		local child = getglobal(children);
		if (child) then
			child:Hide();
		end
	end
end

-- open item input
function TitanDKPOpenItemInput(name, player)
	TitanDKPOpenInput("item", name, player);
end

--[[--------------------------------
Settings Frame
--------------------------------]]--

-- Settings Frame open
function TitanPanelTITANDKPAuto_Options()
	local frameString = "TitanDKPOptionFrame";
	local okayButtonString = frameString .. "OButton";
	local cancelButtonString = frameString .. "CButton";
	local checkboxString = frameString .. "StopOnKillBox";
	local checkboxTextString = checkboxString .. "Text";
	local addboxString = frameString .. "AddBox";
	local addboxTextString = addboxString .. "Text";
	local sliderString = frameString .. "ThresholdSlider";
	local sliderLowString = sliderString .. "Low";
	local sliderHighString = sliderString .. "High";
	local sliderTextString = sliderString .. "Text";
	local frame = getglobal(frameString);
	local checkbox = getglobal(checkboxString);
	local addbox = getglobal(addboxString);
	local slider = getglobal(sliderString);
	
	-- init/update frame
	if (not frame) then
		frame = CreateFrame("Frame", frameString, UIParent);
		frame:Hide();
		frame:SetWidth(370);
		frame:SetHeight(330);
		frame:EnableMouse(true);
		frame:SetMovable(true);
		frame:SetBackdrop(TitanDKPBackdrop);
		frame:SetScript("OnMouseUp", TitanDKPDragStop);
		frame:SetScript("OnMouseDown", TitanDKPDragStart);
		frame:SetScript("OnHide", TitanDKPDragStop);
		
		--init okay button
		local okayButton = CreateFrame("Button", okayButtonString, frame, "UIPanelButtonTemplate");
		okayButton:SetText(TITANDKP_OKAY);
		okayButton:SetFont("Fonts\\FRIZQT__.TTF", 12);
		okayButton:SetWidth(50);
		okayButton:SetHeight(20);
		okayButton:SetPoint("TOPLEFT", frameString, "TOPLEFT", 95, -300);
		okayButton:SetScript("OnClick", TitanDKPOptionFrameOkayButton_OnClick);
		
		--init cancel button
		local cancelButton = CreateFrame("Button", cancelButtonString, frame, "UIPanelButtonTemplate");
		cancelButton:SetText(TITANDKP_CANCEL);
		cancelButton:SetFont("Fonts\\FRIZQT__.TTF", 12);
		cancelButton:SetWidth(50);
		cancelButton:SetHeight(20);
		cancelButton:SetPoint("TOPLEFT", frameString, "TOPLEFT", 155, -300);
		cancelButton:SetScript("OnClick", function() frame:Hide() end);
		
		-- boss title
		local bossTitleString = "DKPOptionFrameBossTitle";
		local bossTitle = frame:CreateFontString(bossTitleString, "ARTWORK");
		bossTitle:SetFont("Fonts\\FRIZQT__.TTF", 12);
		bossTitle:SetJustifyH("LEFT");
		bossTitle:SetText(TITANDKP_BOSSTITLE);
		bossTitle:SetPoint("TOPLEFT", frameString, "TOPLEFT", 135, -10);
		
		-- instance title
		local instanceTitleString = "DKPOptionFrameInstanceTitle";
		local instanceTitle = frame:CreateFontString(instanceTitleString, "ARTWORK");
		instanceTitle:SetJustifyH("LEFT");
		instanceTitle:SetFont("Fonts\\FRIZQT__.TTF", 12);
		instanceTitle:SetText(TITANDKP_INSTANCETITLE);
		instanceTitle:SetPoint("TOPLEFT", frameString, "TOPLEFT", 200, -10);
	end
	frame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["optionsanchor"].x, TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["optionsanchor"].y);
	
	-- Hide and stop if visible
	if (frame:IsVisible()) then
		frame:Hide();
		return nil;
	end
	
	-- init/update instance information
	local x1 = 10;
	local x2 = 140;
	local x3 = 215;
	local y = -30;
	local lastKey = TitanDKPGetNextKey();
	for key, value in TitanDKPSortedPairs(TITANDKP_ZONES, TitanDKPZoneComparator) do
		local bossTextString = frameString .. key .. "BossText";
		local instanceTextString = frameString .. key .. "Text";
		local bossText = getglobal(bossTextString);
		local instanceText = getglobal(instanceTextString);
		
		local nextKey = TitanDKPGetNextKey(key);
		local lastKeyTabString = frameString .. lastKey .. "Text";
		local nextKeyTabString = frameString .. nextKey .. "BossText";
		
		-- dynamically create if not present
		if (not bossText) then
			-- title string
			local bossTextTitle = frame:CreateFontString(frameString .. key .. "BossTextTitle", "ARTWORK");
			bossTextTitle:SetJustifyH("LEFT");
			bossTextTitle:SetFont("Fonts\\FRIZQT__.TTF", 12);
			bossTextTitle:SetText(value .. ":");
			bossTextTitle:SetPoint("TOPLEFT", frameString, "TOPLEFT", x1, y - 5);
			
			-- boss point editbox
			bossText = CreateFrame("EditBox", bossTextString, frame, "InputBoxTemplate");
			bossText:SetHeight(20);
			bossText:SetWidth(50);
			bossText:SetPoint("TOPLEFT", frameString, "TOPLEFT", x2, y);
			bossText:SetScript("OnEnterPressed", TitanDKPOptionFrameOkayButton_OnClick);
			bossText:SetScript("OnEscapePressed", function() frame:Hide() end);
			local bossTextLabel = frame:CreateFontString(bossTextString .. "Label", "BACKGROUND");
			bossTextLabel:SetJustifyH("CENTER");
			bossTextLabel:SetFont("Fonts\\FRIZQT__.TTF", 12);
			bossTextLabel:SetText(TITANDKP_DKPHEADING);
			bossTextLabel:SetPoint("TOPLEFT", bossTextString, "TOPLEFT", 7.5, -5);
			
			if (key == "DRAGON") then
				bossText:SetScript("OnTabPressed", function() TitanDKPTabPressed(lastKeyTabString, nextKeyTabString) end);
			else
				if (lastKey == "DRAGON") then
					lastKeyTabString = frameString .. lastKey .. "BossText";
					bossText:SetScript("OnTabPressed", function() TitanDKPTabPressed(lastKeyTabString, instanceTextString) end);
				else
					bossText:SetScript("OnTabPressed", function() TitanDKPTabPressed(lastKeyTabString, instanceTextString) end);
				end

				-- instance point editbox
				instanceText = CreateFrame("EditBox", instanceTextString, frame, "InputBoxTemplate");
				instanceText:SetHeight(20);
				instanceText:SetWidth(50);
				instanceText:SetPoint("TOPLEFT", frameString, "TOPLEFT", x3, y);
				instanceText:SetScript("OnEnterPressed", TitanDKPOptionFrameOkayButton_OnClick);
				instanceText:SetScript("OnEscapePressed", function() frame:Hide() end);
				instanceText:SetScript("OnTabPressed", function() TitanDKPTabPressed(bossTextString, nextKeyTabString) end);
				local instanceTextLabel = frame:CreateFontString(instanceTextString .. "Label", "BACKGROUND");
				instanceTextLabel:SetJustifyH("CENTER");
				instanceTextLabel:SetFont("Fonts\\FRIZQT__.TTF", 12);
				instanceTextLabel:SetText(TITANDKP_DKPHEADING);
				instanceTextLabel:SetPoint("TOPLEFT", instanceTextString, "TOPLEFT", 7.5, -5);
			end
		
			y = y - 25;
		end			
		-- set focus on first key
		if (key == "ZG") then
			bossText:SetFocus();
		end
		
		bossText:SetFont("Fonts\\FRIZQT__.TTF", 12);
		bossText:SetText(TitanDKPGetBossPoints(key));
		if (instanceText) then
			instanceText:SetFont("Fonts\\FRIZQT__.TTF", 12);
			instanceText:SetText(TitanDKPGetZonePoints(value));
		end
		
		lastKey = key;
	end
	
	-- init/update stoponkill box
	if (not checkbox) then
		checkbox = CreateFrame("CheckButton", checkboxString, frame, "UICheckButtonTemplate");
		checkbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 10, -205);
		checkbox:SetHeight(20);
		checkbox:SetWidth(20);
	end
	local checkboxText = getglobal(checkboxTextString);
	checkboxText:SetFont("Fonts\\FRIZQT__.TTF", 12);
	checkboxText:SetText(TITANDKP_STOPONKILLOPTION);
	checkbox:SetChecked(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].stoponkill);

	-- init/update add box
	if (not addbox) then
		addbox = CreateFrame("CheckButton", addboxString, frame, "UICheckButtonTemplate");
		addbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 10, -220);
		addbox:SetHeight(20);
		addbox:SetWidth(20);
	end
	local addboxText = getglobal(addboxTextString);
	addboxText:SetFont("Fonts\\FRIZQT__.TTF", 12);
	addboxText:SetText(TITANDKP_ADDBOXOPTION);
	addbox:SetChecked(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].onlyAdd);
	
	-- init/update slider
	if (not slider) then
		slider = CreateFrame("Slider", sliderString, frame, "OptionsSliderTemplate");
		slider:SetPoint("TOPLEFT", frameString, "TOPLEFT", 85, -260);
		slider:SetValueStep(1);
		slider:SetMinMaxValues(0, 5);
		slider:SetScript("OnValueChanged", TitanDKPOptionFrameThresholdSlider_ValueChange);
	end
	local sliderLow = getglobal(sliderLowString);
	local sliderHigh = getglobal(sliderHighString);
	local sliderText = getglobal(sliderTextString);
	slider.tooltipText = TITANDKP_THRESHOLDTIP;
	sliderLow:SetFont("Fonts\\FRIZQT__.TTF", 12);
	sliderLow:SetText(TITANDKP_RARITY[0]);
	sliderHigh:SetFont("Fonts\\FRIZQT__.TTF", 12);
	sliderHigh:SetText(TITANDKP_RARITY[5]);
	slider:SetValue(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].threshold);
	sliderText:SetFont("Fonts\\FRIZQT__.TTF", 12);
	sliderText:SetText(TITANDKP_RARITY[TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].threshold]);
	
	frame:Show();
end

-- Close Automatic Settings frame and save
function TitanDKPOptionFrameOkayButton_OnClick(button)
	local frameString = "TitanDKPOptionFrame";
	local checkboxString = frameString .. "StopOnKillBox";
	local addboxString = frameString .. "AddBox";
	local sliderString = frameString .. "ThresholdSlider";
	local frame = getglobal(frameString);
	local slider = getglobal(sliderString);
	local checkbox = getglobal(checkboxString);
	local addbox = getglobal(addboxString);
	frame:Hide();
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["optionsanchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["optionsanchor"].y = y;
	
	-- update values from text information
	for key, value in TITANDKP_ZONES do
		local bossText = getglobal(frameString .. key .. "BossText");
		local instanceText = getglobal(frameString .. key .. "Text");
		local bossPoints = TitanDKPCalculate(bossText:GetText());
		local instancePoints;
		
		if (instanceText) then
			instancePoints = TitanDKPCalculate(instanceText:GetText());
		end
		if (not bossPoints) then
			bossPoints = 0;
		end
		if (not instancePoints) then
			instancePoints = 0;
		end
		TitanDKPSetBossPoints(key, bossPoints);
		TitanDKPSetZonePoints(value, instancePoints);
	end
	
	-- update threshold
	TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].threshold = slider:GetValue();
	
	-- update stoponkill
	TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].stoponkill = checkbox:GetChecked();
	
	-- update add box
	TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].onlyAdd = addbox:GetChecked();
end

-- Threshold Slider Change
function TitanDKPOptionFrameThresholdSlider_ValueChange()
	local slider = getglobal("TitanDKPOptionFrameThresholdSlider");
	local sliderText = getglobal("TitanDKPOptionFrameThresholdSliderText");
	sliderText:SetFont("Fonts\\FRIZQT__.TTF", 12);
	sliderText:SetText(TITANDKP_RARITY[slider:GetValue()]);
end

-- return the next key in zone table
function TitanDKPGetNextKey(searchKey)
	local nextIsKey = false;
	local firstKey;
	local getLastKey = false;
	
	if (not searchKey) then
		getLastKey = true;
	end
	
	for key, value in TitanDKPSortedPairs(TITANDKP_ZONES, TitanDKPZoneComparator) do
		-- just plod through it all
		if (getLastKey) then
			firstKey = key;
		-- set the firstkey
		elseif (not firstKey) then
			firstKey = key;
		end
		
		-- return if you found it
		if (nextIsKey) then
			return key;
		end
		
		-- the next key is the one we want
		if (not getLastKey and key == searchKey) then
			nextIsKey = true;
		end
	end
	
	return firstKey;
end

--[[--------------------------------
Input Frames Functions
--------------------------------]]--

-- open input for item input
function TitanDKPOpenInput(inputType, val1, val2)
	local frameString = "";
	if (inputType == "item" and val1 and val2) then
		frameString = "TitanDKPItemInputFrame";
	elseif (inputType == "system") then
		frameString = "TitanDKPSystemInputFrame";
	elseif (inputType == "dkp" and val1 == "LeftButton") then
		frameString = "TitanDKPInputFrame";
	elseif (inputType == "raidpoints") then
		frameString = "TitanDKPRaidPointsInputFrame";
	elseif (inputType == "player") then
		frameString = "TitanDKPPlayerInputFrame";
	elseif (inputType == "edit") then
		frameString = "TitanDKPEditInputFrame";
	else
		return nil;
	end
	local textString = frameString .. "Text";
	local buttonString = frameString .. "OButton";
	
	-- init frame
	local frame = getglobal(frameString);
	local namebox = getglobal(textString);
	local dkpbox = getglobal(textString .. "Dkp");
	local classbox = getglobal(textString .. "Class");
	local button = getglobal(buttonString);
	if (not frame) then
		frame = CreateFrame("Frame", frameString, UIParent);
		frame:Hide();
		frame:SetHeight(35);
		frame:EnableMouse(true);
		frame:SetMovable(true);
		frame:SetBackdrop(TitanDKPBackdrop);
		frame:SetScript("OnMouseUp", TitanDKPDragStop);
		frame:SetScript("OnMouseDown", TitanDKPDragStart);
		frame:SetScript("OnHide", TitanDKPDragStop);
		
		--init okay button
		button = CreateFrame("Button", buttonString, frame, "UIPanelButtonTemplate");
		button:SetFont("Fonts\\FRIZQT__.TTF", 12);
		button:SetText(TITANDKP_OKAY);
		button:SetWidth(50);
		button:SetHeight(20);
				
		-- init name box
		namebox = CreateFrame("EditBox", textString, frame, "InputBoxTemplate");
		namebox:Hide();
		namebox:SetHeight(20);
		namebox:SetWidth(50);
		namebox:SetScript("OnEscapePressed", function() frame:Hide() end);
		local nameboxLabel = frame:CreateFontString(textString .. "Label", "BACKGROUND");
		nameboxLabel:SetJustifyH("CENTER");
		nameboxLabel:SetFont("Fonts\\FRIZQT__.TTF", 12);
		nameboxLabel:SetPoint("TOPLEFT", textString, "TOPLEFT", 5, -5);
		nameboxLabel:SetText(TITANDKP_NAMEHEADING);
		
		-- init class box
		classbox = CreateFrame("EditBox", textString .. "Class", frame, "InputBoxTemplate");
		classbox:Hide();
		classbox:SetHeight(20);
		classbox:SetWidth(50);
		classbox:SetScript("OnEscapePressed", function() frame:Hide() end);
		local classboxLabel = frame:CreateFontString(textString .. "ClassLabel", "BACKGROUND");
		classboxLabel:SetJustifyH("CENTER");
		classboxLabel:SetFont("Fonts\\FRIZQT__.TTF", 12);
		classboxLabel:SetPoint("TOPLEFT", textString .. "Class", "TOPLEFT", 5, -5);
		classboxLabel:SetText(TITANDKP_CLASSHEADING);
		
		-- init dkpbox
		dkpbox = CreateFrame("EditBox", textString .. "Dkp", frame, "InputBoxTemplate");
		dkpbox:Hide();
		dkpbox:SetHeight(20);
		dkpbox:SetWidth(50);
		dkpbox:SetScript("OnEscapePressed", function() frame:Hide() end);
		local dkpboxLabel = frame:CreateFontString(textString .. "DkpLabel", "BACKGROUND");
		dkpboxLabel:SetJustifyH("CENTER");
		dkpboxLabel:SetFont("Fonts\\FRIZQT__.TTF", 12);
		dkpboxLabel:SetPoint("TOPLEFT", textString .. "Dkp", "TOPLEFT", 5, -5);
		dkpboxLabel:SetText(TITANDKP_DKPHEADING);
	end
		
	if (inputType == "item") then
		frame:SetWidth(125);
	
		dkpbox:SetScript("OnEnterPressed", function() TitanDKPItemInputFrameButton_OnClick(val1, val2) end);
		button:SetScript("OnClick", function() TitanDKPItemInputFrameButton_OnClick(val1, val2) end);
		
		dkpbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		button:SetPoint("TOPLEFT", textString .. "Dkp", "TOPRIGHT", 5, 0);
		
		dkpbox:Show();
		dkpbox:SetFocus();
	elseif (inputType == "dkp") then
		frame:SetWidth(125);
		
		dkpbox:SetScript("OnEnterPressed", TitanDKPInputFrameButton_OnClick);
		button:SetScript("OnClick", TitanDKPInputFrameButton_OnClick);
		
		dkpbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		button:SetPoint("TOPLEFT", textString .. "Dkp", "TOPRIGHT", 5, 0);
		
		dkpbox:Show();
		dkpbox:SetFocus();
	elseif (inputType == "system") then
		frame:SetWidth(125);
		
		namebox:SetScript("OnEnterPressed", TitanDKPSystemInputFrameButton_OnClick);
		button:SetScript("OnClick", TitanDKPSystemInputFrameButton_OnClick);
		
		namebox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		button:SetPoint("TOPLEFT", textString, "TOPRIGHT", 5, 0);
		
		namebox:Show();
		namebox:SetFocus();
	elseif (inputType == "raidpoints") then
		frame:SetWidth(125);
		
		dkpbox:SetScript("OnEnterPressed", TitanDKPRaidInputFrameButton_OnClick);
		button:SetScript("OnClick", TitanDKPRaidInputFrameButton_OnClick);
		
		dkpbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		button:SetPoint("TOPLEFT", textString .. "Dkp", "TOPRIGHT", 5, 0);
		
		dkpbox:Show();
		dkpbox:SetFocus();
		
		local parent = getglobal("TitanDKPRaidFrame");
		if (parent) then
			parent:Lower();
		end
	elseif (inputType == "player") then
		frame:SetWidth(235);
		
		namebox:SetScript("OnEnterPressed", TitanDKPPlayerInputFrameButton_OnClick);
		namebox:SetScript("OnTabPressed", function() TitanDKPTabPressed(textString .. "Dkp", textString .. "Class") end);
		classbox:SetScript("OnEnterPressed", TitanDKPPlayerInputFrameButton_OnClick);
		classbox:SetScript("OnTabPressed", function() TitanDKPTabPressed(textString, textString .. "Dkp") end);
		dkpbox:SetScript("OnEnterPressed", TitanDKPPlayerInputFrameButton_OnClick);
		dkpbox:SetScript("OnTabPressed", function() TitanDKPTabPressed(textString .. "Class", textString) end);
		button:SetScript("OnClick", TitanDKPPlayerInputFrameButton_OnClick);
		
		namebox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		classbox:SetPoint("TOPLEFT", textString, "TOPRIGHT", 5, 0);
		dkpbox:SetPoint("TOPLEFT", textString .. "Class", "TOPRIGHT", 5, 0);
		button:SetPoint("TOPLEFT", textString .. "Dkp", "TOPRIGHT", 5, 0);
		
		namebox:Show();
		dkpbox:Show();
		classbox:Show();
		namebox:SetFocus();
		
		local parent = getglobal("TitanDKPSavedFrame");
		if (parent) then
			parent:Lower();
		end
	elseif (inputType == "edit") then
		frame:SetWidth(180);
		
		classbox:SetScript("OnEnterPressed", function() TitanDKPEditInputFrameButton_OnClick(val1) end);
		classbox:SetScript("OnTabPressed", function() TitanDKPTabPressed(textString .. "Dkp", textString .. "Dkp") end);
		dkpbox:SetScript("OnEnterPressed", function() TitanDKPEditInputFrameButton_OnClick(val1) end);
		dkpbox:SetScript("OnTabPressed", function() TitanDKPTabPressed(textString .. "Class", textString .. "Class") end);
		button:SetScript("OnClick", function() TitanDKPEditInputFrameButton_OnClick(val1) end);

		classbox:SetPoint("TOPLEFT", frameString, "TOPLEFT", 12.5, -7.5);
		dkpbox:SetPoint("TOPLEFT", textString .. "Class", "TOPRIGHT", 5, 0);
		button:SetPoint("TOPLEFT", textString .. "Dkp", "TOPRIGHT", 5, 0);
		
		dkpbox:Show();	
		classbox:Show();
		dkpbox:SetFocus();
		
		local parent = getglobal("TitanDKPSavedFrame");
		if (parent) then
			parent:Lower();
		end
	end
	
	frame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x, TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y);
	
	if (namebox) then
		namebox:SetText("");
	end
	if (classbox) then
		classbox:SetText("");
	end
	if (dkpbox) then
		dkpbox:SetText("");
	end
	
	frame:Show();
end

-- system input catcher
function TitanDKPSystemInputFrameButton_OnClick()
	local frameString = "TitanDKPSystemInputFrame";
	local textString = "TitanDKPSystemInputFrameText";
	local frame = getglobal(frameString);
	local nameText = getglobal(textString);
	frame:Hide();
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	local text = nameText:GetText();
	if (not text or text == "") then
		return nil;
	end
	
	if (not TITANDKPSavedInfo["DKPSystem"][text]) then
		TitanDKPInitSystem(text);
		TitanDKPOutput(TITANDKP_SYSTEMADDCOMMANDCOMPLETE1 .. text .. TITANDKP_ADDCOMMANDCOMPLETE2);
	else
		-- system exists
		TitanDKPOutput(TITANDKP_SYSTEMADDCOMMANDFAILED1 .. text .. TITANDKP_ADDCOMMANDFAILED2);
	end
	TitanDKPUpdateFrames();
end

-- item input catcher
function TitanDKPItemInputFrameButton_OnClick(inputItem, inputPlayer)
	local frameString = "TitanDKPItemInputFrame";
	local textString = "TitanDKPItemInputFrameText";
	local frame = getglobal(frameString);
	local dkpText = getglobal(textString .. "Dkp");
	frame:Hide();
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	-- get text 
	local points = TitanDKPCalculate(dkpText:GetText());
	if (not points) then
		points = 0;
	end
	
	-- remove from unassigned
	if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][inputItem][inputPlayer] 
		and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][inputItem][inputPlayer] > 1) then
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][inputItem][inputPlayer] = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][inputItem][inputPlayer] - 1;
	else
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"][inputItem][inputPlayer] = nil;
	end
	
	-- add it's points to the character
	TitanDKPChangePoints(inputPlayer, points);
	
	-- add item to items, initialize if not present
	if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem]) then
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem] = {};
	end
	if (not TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer]) then
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer] = {};
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].count = 0;
		TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].dkp = 0;
	end
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].dkp = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].dkp + points;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].count = TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"][inputItem][inputPlayer].count + 1;
	
	TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. points .. TITANDKP_CHANGECOMMANDCOMPLETE2 .. inputPlayer);
	TitanDKPUpdateFrames();
end

-- TitanDKP dkp input catcher
function TitanDKPInputFrameButton_OnClick()
	local frameString = "TitanDKPInputFrame";
	local textString = "TitanDKPInputFrameText";
	local frame = getglobal(frameString);
	local dkpText = getglobal(textString .. "Dkp");
	frame:Hide();
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	local text = dkpText:GetText();
	if (not text or text == "") then
		return nil;
	end
	
	local result = TitanDKPChangePlayerCommand({nil, TitanDKPName, text});
	if (result) then
		TitanDKPOutput(TITANDKP_CHANGECOMMANDCOMPLETE1 .. result .. TITANDKP_ADDCOMMANDCOMPLETE2);	
	else
		-- name not found
		TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED1);
	end
	TitanDKPUpdateFrames();
end

-- raid point input catcher
function TitanDKPRaidInputFrameButton_OnClick()
	local frameString = "TitanDKPRaidPointsInputFrame";
	local textString = "TitanDKPRaidPointsInputFrameText";
	local frame = getglobal(frameString);
	local dkpText = getglobal(textString .. "Dkp");

	frame:Hide();
	
	local parent = getglobal("TitanDKPRaidFrame");
	if (parent) then
		parent:Raise();
	end
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	local text = dkpText:GetText();
	if (not text or text == "") then
		return nil;
	end
	
	local result = TitanDKPChangeRaidCommand({nil, text});
	if (result) then
		TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. result .. TITANDKP_CHANGECOMMANDCOMPLETE3);
	else
		-- bad number
		TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED2);
	end
	TitanDKPUpdateFrames();
end

-- player input catcher
function TitanDKPPlayerInputFrameButton_OnClick()
	local frameString = "TitanDKPPlayerInputFrame";
	local textString = "TitanDKPPlayerInputFrameText";
	local frame = getglobal(frameString);
	local nameText = getglobal(textString);
	local dkpText = getglobal(textString .. "Dkp");
	local classText = getglobal(textString .. "Class");

	frame:Hide();
	
	local parent = getglobal("TitanDKPSavedFrame");
	if (parent) then
		parent:Raise();
	end
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	local name = nameText:GetText();
	local points = TitanDKPCalculate(dkpText:GetText());
	local class = TitanDKPFindClass(classText:GetText());
	if (name == "") then
		return nil;
	elseif (not points) then
		points = 0;
	end
	
	local result = TitanDKPAddPlayerCommand({nil, name, class, points});
	if (not result) then
		TitanDKPOutput(TITANDKP_ADDCOMMANDCOMPLETE1 .. name .. TITANDKP_ADDCOMMANDCOMPLETE2);
	else
		-- name already present
		TitanDKPOutput(TITANDKP_ADDCOMMANDFAILED1 .. result .. TITANDKP_ADDCOMMANDFAILED2);
	end
	TitanDKPUpdateFrames();
end

-- edit input catcher
function TitanDKPEditInputFrameButton_OnClick(name)
	local frameString = "TitanDKPEditInputFrame";
	local textString = "TitanDKPEditInputFrameText";
	local frame = getglobal(frameString);
	local dkpText = getglobal(textString .. "Dkp");
	local classText = getglobal(textString .. "Class");

	frame:Hide();
	
	local parent = getglobal("TitanDKPSavedFrame");
	if (parent) then
		parent:Raise();
	end
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["anchor"].y = y;
	
	local points = TitanDKPCalculate(dkpText:GetText());
	local class = classText:GetText();
	if (not points) then
		points = 0;
	end
	if (class == "") then
		class = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].class;
	end
		
	local result = TitanDKPChangePlayerCommand({nil, name, class, points});
	if (result) then
		TitanDKPOutput(TITANDKP_CHANGECOMMANDCOMPLETE1 .. result .. TITANDKP_ADDCOMMANDCOMPLETE2);	
	else
		-- name not found
		TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED1);
	end
	TitanDKPUpdateFrames();
end

--[[--------------------------------
Player Frame Functions
--------------------------------]]--

-- Open Player Frame
function TitanDKPShowPlayerWindow(windowType)
	local frameString = "";
	local anchorString = "";
	if (windowType == "raid") then
		frameString = "TitanDKPRaidFrame";
		anchorString = "raidanchor";
	elseif (windowType == "saved") then
		frameString = "TitanDKPSavedFrame";
		anchorString = "savedanchor";
	elseif (windowType == "info") then
		frameString = "TitanDKPInfoFrame";
		anchorString = "infoanchor";
	else
		return nil;
	end
	local frameTitleString = frameString .. "Title";
	local scrollString = frameString .. "ScrollBar";
	local closeButtonString = frameString .. "CloseButton";
	local nameSortString = frameString .. "NameButton";
	local classSortString = frameString .. "ClassButton";
	local dkpSortString = frameString ..  "DKPButton";
	local addButtonString = frameString .. "AddButton";
	local filterString = frameString .. "FilterBox";
	local filterTextString = frameString .. "FilterBoxText";
	local frame = getglobal(frameString);
	local filter = getglobal(filterString);
	
	-- init/update frame
	if (not frame) then
		frame = CreateFrame("Frame", frameString, UIParent);
		frame:Hide();
		frame:EnableMouse(true);
		frame:SetMovable(true);
		frame:SetBackdrop(TitanDKPBackdrop);
		frame:SetScript("OnMouseUp", TitanDKPDragStop);
		frame:SetScript("OnMouseDown", TitanDKPDragStart);
		frame:SetScript("OnSizeChanged", function() TitanDKPUpdatePlayerWindow(windowType) end);
		frame:SetScript("OnHide", function() 
			TitanDKPDragStop();
			TitanDKPHidePlayerWindow(windowType);
		end);
		
		-- frame title
		local frameTitle = frame:CreateFontString(frameTitleString, "ARTWORK");
		frameTitle:SetJustifyH("LEFT");
		frameTitle:SetFont("Fonts\\FRIZQT__.TTF", 12);
		frameTitle:SetPoint("TOPLEFT", frameString, "TOPLEFT", 10, -10);
		
		-- scroll bar
		local scroll = CreateFrame("ScrollFrame", scrollString, frame, "FauxScrollFrameTemplate");
		scroll:SetPoint("TOPLEFT", frameString, "TOPLEFT", 0, -40);
		scroll:SetPoint("BOTTOMRIGHT", frameString, "BOTTOMRIGHT", -30, 35);
		scroll:SetScript("OnVerticalScroll", function() FauxScrollFrame_OnVerticalScroll(16, function() TitanDKPUpdatePlayerWindow(windowType) end) end);
		
		-- close button
		local closeButton = CreateFrame("Button", closeButtonString, frame, "UIPanelCloseButton");
		closeButton:SetPoint("TOPRIGHT", frameString, "TOPRIGHT", -3, -3);
		closeButton:SetScript("OnClick", function() TitanDKPHidePlayerWindow(windowType) end);
		
		-- Name Sort Button
		TitanDKPCreateSortHeader(nameSortString, 100, frame);
		local nameSort = getglobal(nameSortString);
		nameSort:SetFont("Fonts\\FRIZQT__.TTF", 12);
		nameSort:SetText(TITANDKP_NAMEHEADING);
		nameSort:SetScript("OnClick", function() TitanDKPSortPlayerWindow(windowType, "name") end);
		
		-- Class Sort Button
		TitanDKPCreateSortHeader(classSortString, 60, frame);
		local classSort = getglobal(classSortString);
		classSort:SetFont("Fonts\\FRIZQT__.TTF", 12);
		classSort:SetText(TITANDKP_CLASSHEADING);
		classSort:SetScript("OnClick", function() TitanDKPSortPlayerWindow(windowType, "class") end);
		
		-- DKP Sort Button
		TitanDKPCreateSortHeader(dkpSortString, 120, frame);
		local dkpSort = getglobal(dkpSortString);
		dkpSort:SetFont("Fonts\\FRIZQT__.TTF", 12);
		dkpSort:SetText(TITANDKP_DKPHEADING);
		dkpSort:SetScript("OnClick", function() TitanDKPSortPlayerWindow(windowType, "dkp") end);
		
		-- filter editbox
		filter = CreateFrame("EditBox", filterString, frame, "InputBoxTemplate");
		filter:SetHeight(20);
		filter:SetWidth(100);
		filter:SetScript("OnEscapePressed", function() TitanDKPHidePlayerWindow(windowType) end);
		filter:SetPoint("BOTTOMRIGHT", frameString, "BOTTOMRIGHT", -10, 10);
		local filterText = frame:CreateFontString(filterTextString, "BACKGROUND");
		filterText:SetJustifyH("CENTER");
		filterText:SetFont("Fonts\\FRIZQT__.TTF", 12);
		filterText:SetText(TITANDKP_FILTERTEXT);
		filterText:SetPoint("TOPLEFT", filterString, "TOPLEFT", 33, -5);
		
		-- init add button
		local addButton = CreateFrame("Button", addButtonString, frame, "UIPanelButtonTemplate");
		addButton:SetWidth(90);
		addButton:SetHeight(20);
		addButton:SetPoint("BOTTOMLEFT", frameString, "BOTTOMLEFT", 10, 10);
		addButton:SetFont("Fonts\\FRIZQT__.TTF", 12);
		
		if (windowType == "raid") then
			frame:SetWidth(320);
			frame:SetHeight(400);
			frameTitle:SetText(TITANDKP_RAIDTITLE);
			filter:SetScript("OnTextChanged", function() TitanDKPRaidFilter = filter:GetText(); TitanDKPUpdatePlayerWindow(windowType); end);
			addButton:SetText(TITANDKP_ADDBUTTON);
			addButton:SetScript("OnClick", function() TitanDKPOpenInput("raidpoints") end);
			dkpSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 160, -3);
			classSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 100, -3);
			nameSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 0, -3);
		elseif (windowType == "saved") then
			frame:SetWidth(370);
			frame:SetHeight(400);
			frameTitle:SetText(TITANDKP_SAVEDTITLE);
			filter:SetScript("OnTextChanged", function() TitanDKPSavedFilter = filter:GetText(); TitanDKPUpdatePlayerWindow(windowType); end);
			addButton:SetText(TITANDKP_PLAYERADDBUTTON);
			addButton:SetScript("OnClick", function() TitanDKPOpenInput("player") end);
			dkpSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 160, -3);
			classSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 100, -3);
			nameSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 0, -3);
		elseif (windowType == "info") then
			frame:SetWidth(345);
			frame:SetHeight(400);
			filter:SetScript("OnTextChanged", function() TitanDKPInfoFilter = filter:GetText(); TitanDKPUpdatePlayerWindow(windowType); end);
			addButton:Hide();
			dkpSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 180, -3);
			classSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 120, -3);
			nameSort:SetPoint("TOPLEFT", frameTitleString, "BOTTOMLEFT", 20, -3);
		end
	end
	
	if (windowType == "info") then
		getglobal(frameTitleString):SetText(TitanDKPInfoName .. TITANDKP_INFOTITLE);
		local parent = getglobal("TitanDKPSavedFrame");
		if (parent) then
			parent:Lower();
		end
	end
	
	-- toggle visibilty
	if (frame:IsVisible() and not windowType == "info") then
		TitanDKPHidePlayerWindow(windowType);
	else
		frame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName][anchorString].x, TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName][anchorString].y);
		filter:SetFocus();
		TitanDKPUpdatePlayerWindow(windowType);
		frame:Show();
	end
end

-- Close Player Frame
function TitanDKPHidePlayerWindow(windowType)	
	local frameString = "";
	local anchorString = "";
	if (windowType == "raid") then
		frameString = "TitanDKPRaidFrame";
		anchorString = "raidanchor";
		childStringList = {"TitanDKPRaidPointsInputFrame"};
	elseif (windowType == "saved") then
		frameString = "TitanDKPSavedFrame";
		anchorString = "savedanchor";
		childStringList = {"TitanDKPPlayerInputFrame", "TitanDKPEditInputFrame", "TitanDKPInfoFrame"};
	elseif (windowType == "info") then
		frameString = "TitanDKPInfoFrame";
		anchorString = "infoanchor";
		childStringList = {};
	end
	
	local frame = getglobal(frameString);
	frame:Hide();
	
	if (windowType == "info") then				
		local parent = getglobal("TitanDKPSavedFrame");
		if (parent) then
			parent:Raise();
		end
	end
	
	for key, children in childStringList do
		local child = getglobal(children);
		if (child) then
			child:Hide();
		end
	end
	
	-- update window information
	local p, rf, rp, x, y = frame:GetPoint();
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName][anchorString].x = x;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName][anchorString].y = y;
end

-- Scrolling Player Frame
function TitanDKPUpdatePlayerWindow(windowType)
	local line;
	local lineoffset;
	local values = {};
	local filterList = {};
	local filter = "";
	local j = 0;
	local numberOfLines = 25;
	local frameString = "";
	local editButtonString = "";
	local infoButtonString = "";
	local deleteButtonString = "";
	local altCheckString = "";
	local isRaid = false;
	local sort = "";
	if (windowType == "raid") then
		frameString = "TitanDKPRaidFrame";
		filter = TitanDKPRaidFilter;
		sort = TitanDKPRaidSort;
	elseif (windowType == "saved") then
		frameString = "TitanDKPSavedFrame";
		filter = TitanDKPSavedFilter;
		sort = TitanDKPSavedSort;
		editButtonString = frameString .. "EditButton";
		infoButtonString = frameString .. "InfoButton";
		deleteButtonString = frameString .. "DeleteButton";
	elseif (windowType == "info") then
		frameString = "TitanDKPInfoFrame";
		filter = TitanDKPInfoFilter;
		sort = TitanDKPInfoSort;
		altCheckString = frameString .. "AltCheck";
	else
		return nil;
	end
	local scrollString = frameString .. "ScrollBar";
	local scrollText = frameString .. "Text";
	local scrollTitle = frameString .. "Title";
	local frame = getglobal(frameString);
	local scroll = getglobal(scrollString);
	
	-- parse filter
	for w in string.gfind(filter, "%S+") do
		filterList[j] = w;
		j = j + 1;
	end
	values = TitanDKPFilterList(filterList, windowType);
	
	if (sort == "class") then
		table.sort(values, TitanDKPSortClass);
	elseif (sort == "classR") then
		table.sort(values, TitanDKPSortClassR);
	elseif (sort == "dkp") then
		table.sort(values, TitanDKPSortDKP);
	elseif (sort == "dkpR") then
		table.sort(values, TitanDKPSortDKPR);
	elseif (sort == "nameR") then
		table.sort(values, TitanDKPSortNameR);
	else
		table.sort(values, TitanDKPSortName);
	end
	
	if (table.getn(values) < numberOfLines) then
		scroll:Hide();
	end
	
	FauxScrollFrame_Update(scroll, table.getn(values) + 1, numberOfLines, floor(numberOfLines/2));
	
	for line = 1, numberOfLines do
		local lineoffset = line + FauxScrollFrame_GetOffset(scroll);
		local texta = getglobal(scrollText .. line .. "a");
		local textb = getglobal(scrollText .. line .. "b");
		local textc = getglobal(scrollText .. line .. "c");
		local editButton = getglobal(editButtonString .. line);
		local infoButton = getglobal(infoButtonString .. line);
		local deleteButton = getglobal(deleteButtonString .. line);
		local altCheck = getglobal(altCheckString .. line);

		if (lineoffset <= table.getn(values) and table.getn(values) ~= 0) then
			if (not texta) then
				texta = frame:CreateFontString(scrollText .. line .. "a", "ARTWORK");
				texta:SetJustifyH("LEFT");
				textb = frame:CreateFontString(scrollText .. line .. "b", "ARTWORK");
				textb:SetJustifyH("LEFT");
				textc = frame:CreateFontString(scrollText .. line .. "c", "ARTWORK");
				textc:SetJustifyH("LEFT");
			end
			
			local name = values[lineoffset].name;
			local class = values[lineoffset].class;
			local points = values[lineoffset].currentDKP;
			local r = TitanDKPGetClassRed(class);
			local g = TitanDKPGetClassGreen(class);
			local b = TitanDKPGetClassBlue(class);
			texta:SetFont("Fonts\\FRIZQT__.TTF", 12);
			texta:SetText(name);
			texta:SetTextColor(r, g, b, 1);
			textb:SetFont("Fonts\\FRIZQT__.TTF", 12);
			textb:SetText(class);
			textb:SetTextColor(r, g, b, 1);
			textc:SetFont("Fonts\\FRIZQT__.TTF", 12);
			textc:SetText(points .. " (" .. points + TitanDKPGetAltDKP(name) .. ")");
			textc:SetTextColor(r, g, b, 1);
			
			if (windowType == "saved" and not editButton) then
				--init player edit button
				editButton = CreateFrame("Button", editButtonString .. line, frame, "UIPanelButtonTemplate");
				editButton:SetWidth(12);
				editButton:SetHeight(12);
				editButton:SetScript("OnEnter", function()
					GameTooltip:SetOwner(editButton, "ANCHOR_TOPRIGHT", 20, 0);
					GameTooltip:AddLine("|cFFFFFFFF" .. TITANDKP_EDITTIP);
					GameTooltip:Show();
				end);
				editButton:SetScript("OnLeave", function() GameTooltip:Hide() end);
				local editButtonTexture = editButton:CreateTexture(editButtonString .. line .. "Texture", "ARTWORK");
				editButtonTexture:SetTexture("Interface\\Icons\\INV_Misc_Wrench_01");
				editButtonTexture:SetPoint("TOPLEFT", editButtonString .. line);
				editButtonTexture:SetWidth(12);
				editButtonTexture:SetHeight(12);
				editButton:SetNormalTexture(editButtonTexture);
				local editButtonHighlight = editButton:CreateTexture(editButtonString .. line .. "Highlight", "ARTWORK");
				editButtonHighlight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
				editButtonHighlight:SetPoint("TOPLEFT", editButtonString .. line);
				editButtonHighlight:SetBlendMode("ADD");
				editButtonHighlight:SetWidth(12);
				editButtonHighlight:SetHeight(12);
				editButton:SetHighlightTexture(editButtonHighlight);
				
				--init player info button
				infoButton = CreateFrame("Button", infoButtonString .. line, frame, "UIPanelButtonTemplate");
				infoButton:SetWidth(12);
				infoButton:SetHeight(12);
				infoButton:SetScript("OnEnter", function()
					GameTooltip:SetOwner(infoButton, "ANCHOR_TOPRIGHT", 20, 0);
					GameTooltip:AddLine("|cFFFFFFFF" .. TITANDKP_INFOTIP);
					GameTooltip:Show();
				end);
				infoButton:SetScript("OnLeave", function() GameTooltip:Hide() end);
				local infoButtonTexture = infoButton:CreateTexture(infoButtonString .. line .. "Texture", "ARTWORK");
				infoButtonTexture:SetTexture("Interface\\Icons\\INV_Misc_Ear_Human_01");
				infoButtonTexture:SetPoint("TOPLEFT", infoButtonString .. line);
				infoButtonTexture:SetWidth(12);
				infoButtonTexture:SetHeight(12);
				infoButton:SetNormalTexture(infoButtonTexture);
				local infoButtonHighlight = infoButton:CreateTexture(infoButtonString .. line .. "Highlight", "ARTWORK");
				infoButtonHighlight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
				infoButtonHighlight:SetPoint("TOPLEFT", infoButtonString .. line);
				infoButtonHighlight:SetBlendMode("ADD");
				infoButtonHighlight:SetWidth(12);
				infoButtonHighlight:SetHeight(12);
				infoButton:SetHighlightTexture(infoButtonHighlight);
				
				--init player delete button
				deleteButton = CreateFrame("Button", deleteButtonString .. line, frame, "UIPanelCloseButton");
				deleteButton:SetWidth(22);
				deleteButton:SetHeight(22);
				deleteButton:SetScript("OnEnter", function()
					GameTooltip:SetOwner(deleteButton, "ANCHOR_TOPRIGHT", 20, 0);
					GameTooltip:AddLine("|cFFFFFFFF" .. TITANDKP_SYSTEMDEL);
					GameTooltip:Show();
				end);
				deleteButton:SetScript("OnLeave", function() GameTooltip:Hide() end);
			elseif (windowType == "info" and not altCheck) then
				altCheck = CreateFrame("CheckButton", altCheckString .. line, frame, "UICheckButtonTemplate");
				altCheck:SetHeight(18);
				altCheck:SetWidth(18);
			end
			
			if (windowType == "saved") then
				editButton:SetScript("OnClick", function() TitanDKPOpenInput("edit", name) end);
				infoButton:SetScript("OnClick", function() 
					TitanDKPInfoName = name;
					TitanDKPShowPlayerWindow("info");
				end);
				infoButton:SetPoint("TOPRIGHT", editButtonString .. line, "TOPRIGHT", 15, 0);
				deleteButton:SetScript("OnClick", function() 
					local result = TitanDKPRemoveCommand({nil, name});
					if (result) then
						TitanDKPOutput(TITANDKP_REMOVECOMMANDCOMPLETE1 .. result .. TITANDKP_ADDCOMMANDCOMPLETE2);
					else
						-- player not found
						TitanDKPOutput(TITANDKP_CHANGECOMMANDFAILED1);
					end
				end);
				deleteButton:SetPoint("TOPRIGHT", infoButtonString .. line, "TOPRIGHT", 20, 5);
			elseif (windowType == "info") then
				getglobal("TitanDKPInfoFrameTitle"):SetText(TitanDKPInfoName .. TITANDKP_INFOTITLE);
				
				if (TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPInfoName]) then
					altCheck:SetChecked(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPInfoName]["alts"][name]);
				end
				
				altCheck:SetScript("OnClick", function() 
					if (not altCheck:GetChecked()) then
						TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPInfoName]["alts"][name] = nil;
					else
						TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPInfoName]["alts"][name] = 1;
					end
					
					if (TITANDKPSavedInfo[TitanDKPRealm][TitanDKPInfoName]) then
						TitanDKPInitPlayer(name);
					end
				end);
			end
			
			if (line == 1 and windowType == "info") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 20, -20);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 120, -20);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 190, -20);
				altCheck:SetPoint("TOPLEFT", scrollText .. line .. "a", "TOPLEFT", -20, 2);
			elseif (windowType == "info") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 20, -13 * line - 7);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 120, -13 * line - 7);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 190, -13 * line - 7);
				altCheck:SetPoint("TOPLEFT", scrollText .. line .. "a", "TOPLEFT", -20, 2);
			elseif (line == 1 and windowType == "raid") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 0, -20);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 100, -20);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 170, -20);
			elseif (windowType == "raid") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 0, -13 * line - 7);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 100, -13 * line - 7);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 170, -13 * line - 7);
			elseif (line == 1 and windowType == "saved") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 0, -20);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 100, -20);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 170, -20);
				editButton:SetPoint("TOPLEFT", scrollText .. line .. "c", "TOPLEFT", 120, 0);
			elseif (windowType == "saved") then
				texta:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 0, -13 * line - 7);
				textb:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 100, -13 * line - 7);
				textc:SetPoint("TOPLEFT", scrollTitle, "BOTTOMLEFT", 170, -13 * line - 7);
				editButton:SetPoint("TOPLEFT", scrollText .. line .. "c", "TOPLEFT", 120, 0);
			end
			
			texta:Show();
			textb:Show();
			textc:Show();
		
			if (infoButton) then
				infoButton:Show();
			end
			
			if (editButton) then
				editButton:Show();
				deleteButton:Show();
			end
			
			if (altCheck) then
				altCheck:Show();
			end
		else
			if (texta) then
				texta:Hide();
				textb:Hide();
				textc:Hide();
			end
			if (infoButton) then
				infoButton:Hide();
			end
			if (editButton) then
				editButton:Hide();
				deleteButton:Hide();
			end
			if (altCheck) then
				altCheck:Hide();
			end
		end
	end
end

-- sort player window
function TitanDKPSortPlayerWindow(windowType, sortType)
	if (windowType == "raid") then
		if (sortType == "name" and TitanDKPRaidSort == "name") then
			TitanDKPRaidSort = "nameR";
		elseif (sortType == "name") then
			TitanDKPRaidSort = "name";
		elseif (sortType == "class" and TitanDKPRaidSort == "class") then
			TitanDKPRaidSort = "classR";
		elseif (sortType == "class") then
			TitanDKPRaidSort = "class";
		elseif (sortType == "dkp" and TitanDKPRaidSort == "dkp") then
			TitanDKPRaidSort = "dkpR";
		elseif (sortType == "dkp") then
			TitanDKPRaidSort = "dkp";
		end
	elseif (windowType == "saved") then
		if (sortType == "name" and TitanDKPSavedSort == "name") then
			TitanDKPSavedSort = "nameR";
		elseif (sortType == "name") then
			TitanDKPSavedSort = "name";
		elseif (sortType == "class" and TitanDKPSavedSort == "class") then
			TitanDKPSavedSort = "classR";
		elseif (sortType == "class") then
			TitanDKPSavedSort = "class";
		elseif (sortType == "dkp" and TitanDKPSavedSort == "dkp") then
			TitanDKPSavedSort = "dkpR";
		elseif (sortType == "dkp") then
			TitanDKPSavedSort = "dkp";
		end
	elseif (windowType == "info") then
		if (sortType == "name" and TitanDKPInfoSort == "name") then
			TitanDKPInfoSort = "nameR";
		elseif (sortType == "name") then
			TitanDKPInfoSort = "name";
		elseif (sortType == "class" and TitanDKPInfoSort == "class") then
			TitanDKPInfoSort = "classR";
		elseif (sortType == "class") then
			TitanDKPInfoSort = "class";
		elseif (sortType == "dkp" and TitanDKPInfoSort == "dkp") then
			TitanDKPInfoSort = "dkpR";
		elseif (sortType == "dkp") then
			TitanDKPInfoSort = "dkp";
		end
	end
	
	TitanDKPUpdatePlayerWindow(windowType);
end

-- create a table header
function TitanDKPCreateSortHeader(buttonString, width, frame)
	local button = CreateFrame("Button", buttonString, frame);
	button:SetWidth(width);
	button:SetHeight(15);
	button:SetTextFontObject("GameFontHighlightSmall");
	local buttonText = button:CreateFontString(buttonString .. "Text", "ARTWORK");
	buttonText:SetPoint("LEFT", 8, 0);
	buttonText:SetFont("Fonts\\FRIZQT__.TTF", 12);
	local buttonLeft = button:CreateTexture(buttonString .. "Left", "ARTWORK");
	buttonLeft:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
	buttonLeft:SetTexCoord(0, .078125, 0, .75);
	buttonLeft:SetPoint("TOPLEFT", buttonString);
	buttonLeft:SetWidth(5);
	buttonLeft:SetHeight(15);
	local buttonMiddle = button:CreateTexture(buttonString .. "Middle", "ARTWORK");
	buttonMiddle:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
	buttonMiddle:SetTexCoord(.078125, .90625, 0, .75);
	buttonMiddle:SetPoint("LEFT", buttonString .. "Left", "RIGHT");
	buttonMiddle:SetWidth(width - 9);
	buttonMiddle:SetHeight(15);
	local buttonRight = button:CreateTexture(buttonString .. "Right", "ARTWORK");
	buttonRight:SetTexture("Interface\\FriendsFrame\\WhoFrame-ColumnTabs");
	buttonRight:SetTexCoord(.90625, .96875, 0, .75);
	buttonRight:SetPoint("LEFT", buttonString .. "Middle", "RIGHT");
	buttonRight:SetWidth(4);
	buttonRight:SetHeight(15);
	local buttonHighlight = button:CreateTexture(buttonString .. "Highlight", "ARTWORK");
	buttonHighlight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
	buttonHighlight:SetPoint("TOPLEFT", buttonString .. "Left", "TOPLEFT", 0, 0);
	buttonHighlight:SetPoint("BOTTOMRIGHT", buttonString .. "Right", "BOTTOMRIGHT", 0, 0);
	buttonHighlight:SetBlendMode("ADD");
	button:SetHighlightTexture(buttonHighlight);
end

-- filter a list
function TitanDKPFilterList(list, windowType, depth, previousResult)
	-- init variables if first time and doing raid
	if (not depth and windowType == "raid") then
		depth = 0;
		previousResult = {};
		for name, startdkp in TitanDKPSortedPairs(TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"], TitanDKPComparator) do
			local tempArray = {};
			tempArray.name = name;
			tempArray.class = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].class;
			tempArray.currentDKP = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP;
			table.insert(previousResult, tempArray);
		end
	-- init variables if first time and doing saved or info
	elseif (not depth) then
		depth = 0;
		previousResult = {};
		for name, value in TitanDKPSortedPairs(TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"], TitanDKPComparator) do
			local tempArray = {};
			tempArray.name = name;
			tempArray.class = value.class;
			tempArray.currentDKP = value.currentDKP;
			
			-- make sure not to add yourself to your own alt list
			if (windowType ~= "info" or name ~= TitanDKPInfoName) then
				table.insert(previousResult, tempArray);
			end
		end
	end
	
	-- check that not past the list
	if (not list[depth]) then
		return previousResult;
	end

	local result = {};
	-- search previous result for the value
	for number, value in previousResult do
		if (string.find(string.lower(value.name), string.lower(list[depth])) or string.lower(list[depth]) == string.lower(value.class)) then			
			table.insert(result, value);
		end
	end
	
	-- continue the search
	return TitanDKPFilterList(list, isRaid, depth + 1, result);
end

-- sort class, then name
function TitanDKPSortClass(a, b)
	if (string.lower(a.class) == string.lower(b.class)) then
		return string.lower(a.name) < string.lower(b.name);
	end
	return string.lower(a.class) < string.lower(b.class);
end

-- sort class reverse, then name
function TitanDKPSortClassR(a, b)
	if (string.lower(a.class) == string.lower(b.class)) then
		return string.lower(a.name) < string.lower(b.name);
	end
	return string.lower(a.class) > string.lower(b.class);
end

-- sort TitanDKP, then name
function TitanDKPSortDKP(a, b)
	if (tonumber(a.currentDKP) == tonumber(b.currentDKP)) then
		return string.lower(a.name) < string.lower(b.name);
	end
	return tonumber(a.currentDKP) < tonumber(b.currentDKP);
end

-- sort TitanDKP reverse, then name
function TitanDKPSortDKPR(a, b)
	if (tonumber(a.currentDKP) == tonumber(b.currentDKP)) then
		return string.lower(a.name) < string.lower(b.name);
	end
	return tonumber(a.currentDKP) > tonumber(b.currentDKP);
end

-- sort name
function TitanDKPSortName(a, b)
	return string.lower(a.name) < string.lower(b.name)
end

-- sort name reverse
function TitanDKPSortNameR(a, b)
	return string.lower(a.name) > string.lower(b.name)
end

--[[--------------------------------
Utility Functions
--------------------------------]]--

function TitanDKPGetAltDKP(playerName)
	local altDKP = 0;
	
	-- add up alts TitanDKP
	for name, values in TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"] do
		local points = 0;
		if (TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name] 
			and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP) then
			points = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][name].currentDKP;
		end
		
		if (name ~= playerName and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][playerName]
			and TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][playerName]["alts"][name] == 1) then
			if (not TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem].onlyAdd or points > 0) then
				altDKP = altDKP + points;
			end
		end
	end
	
	return altDKP;
end

-- returns class red color 0 - 1
function TitanDKPGetClassRed(class)
	if (not RAID_CLASS_COLORS[string.upper(class)]) then
		return 1;
	end
	
	return RAID_CLASS_COLORS[string.upper(class)].r;
end

-- returns class green color 0 - 1
function TitanDKPGetClassGreen(class)
	if (not RAID_CLASS_COLORS[string.upper(class)]) then
		return 1;
	end
	
	return RAID_CLASS_COLORS[string.upper(class)].g;
end

-- returns class blue color 0 - 1
function TitanDKPGetClassBlue(class)
	if (not RAID_CLASS_COLORS[string.upper(class)]) then
		return 1;
	end
	
	return RAID_CLASS_COLORS[string.upper(class)].b;
end

-- Calculate expression
function TitanDKPCalculate(expression)
	-- don't Calculate if there's nothing
	if (not expression or expression == "") then
		return nil;
	end

	-- evaluate expressions, from xcalc
	local tempvar = "QCExpVal";
	setglobal(tempvar, nil);
	RunScript(tempvar .. "=(" .. expression .. ")");
	local result = getglobal(tempvar);

	-- return good values
	if (result and tonumber(result)) then
		return TitanDKPRound(result);
	end
	
	return nil;
end

-- Convert Global Strings to usable format
function TitanDKP_ConvertGlobalString(globalString)
	globalString = string.gsub(globalString, "%%%d%$", "%%");
	globalString = string.gsub(globalString, "%%s", "(.+)");
	globalString = string.gsub(globalString, "%%d", "(%%d+)");
	
	return globalString;
end

-- Standard Output
function TitanDKPOutput(message, red, green, blue, alpha)
	local r, g, b, a = DEFAULT_CHAT_FRAME:GetTextColor();
	
	if (not red) then
		red = TITANDKP_RED;
	end
	if (not green) then
		green = TITANDKP_GREEN;
	end
	if (not blue) then
		blue = TITANDKP_BLUE;
	end
	if (not alpha) then
		alpha = TITANDKP_ALPHA;
	end
	
	DEFAULT_CHAT_FRAME:SetTextColor(red, green, blue, alpha);
	DEFAULT_CHAT_FRAME:AddMessage("[TitanDKP] " .. message);
	
	-- reset font color
	DEFAULT_CHAT_FRAME:SetTextColor(r, g, b, a);
end

-- sort function
function TitanDKPSortedPairs(t, comparator)
	local sortedKeys = {};
	table.foreach(t, function(k, v) table.insert(sortedKeys, k) end);
	table.sort(sortedKeys, comparator);
	
	local i = 0;
	function _f(_s, _v)
		i = i + 1;
		local k = sortedKeys[i];
		if (k) then
			return k, t[k];
		end
	end
	
	return _f, nil, nil;
end

-- sort comparator
function TitanDKPComparator(a, b)
	return string.lower(a) < string.lower(b);
end

-- zone sort comparator
function TitanDKPZoneComparator(a, b)
	return string.sub(string.lower(TITANDKP_ZONES[a]), 1, 1) < string.sub(string.lower(TITANDKP_ZONES[b]), 1, 1);
end

-- find if unit is in raid
function TitanDKPUnitInRaid(name)
	for i = 0, 40 do
		if (UnitExists("raid" .. i) and UnitName("raid" .. i) == name) then
			return true;
		end
	end
	
	return false;
end

-- Change TitanDKP points/class, keep synchronized
function TitanDKPChangePoints(name, points, system, class, replace)
	if (not name) then
		name = TitanDKPName;
	end
	if (not points) then
		points = 0;
	end
	if (not system) then
		system = TitanDKPCurrentSystem;
	end

	if (not TITANDKPSavedInfo["DKPSystem"][system]["saved"][name] or not TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].currentDKP) then
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name] = {};
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name]["alts"] = {};
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].currentDKP = TitanDKPCalculate(points);
	elseif (replace) then
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].currentDKP = TitanDKPCalculate(points);
	else
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].currentDKP = TitanDKPRound(TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].currentDKP) + TitanDKPCalculate(points);
	end
	
	if (class and class ~= TitanDKPFindClass()) then
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].class = TitanDKPFindClass(class);
	else
		TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].class = TitanDKPFindClass(TITANDKPSavedInfo["DKPSystem"][system]["saved"][name].class);
	end
end

-- returns the points a zone is worth
function TitanDKPGetZonePoints(zoneText)
	for name, zone in TITANDKP_ZONES do
		if (zone == zoneText) then
			return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"][name].entrance;
		end
	end
	
	return nil;
end

-- returns the points a boss is worth
function TitanDKPGetBossPoints(boss)
	for name, zone in TITANDKP_ZONES do
		if (TITANDKP_BOSSES[boss] == "TE") then
			-- catch Twin Emperors, check that both have died
			if (boss == TITANDKP_EMPEROR1 and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_EMPEROR2]) then
				return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["AQ40"].boss;
			elseif (boss == TITANDKP_EMPEROR2 and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_EMPEROR1]) then
				return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["AQ40"].boss;
			else
				return nil;
			end
		elseif (TITANDKP_BOSSES[boss] == "LO") then
			-- catch Lord, check that all three have died
			if (boss == TITANDKP_LORD1 and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD2]
				and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD3]) then
				return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["AQ40"].boss;
			elseif (boss == TITANDKP_LORD2 and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD1]
				and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD3]) then
				return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["AQ40"].boss;
			elseif (boss == TITANDKP_LORD3 and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD1]
				and TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"][TITANDKP_LORD2]) then
				return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"]["AQ40"].boss;
			else
				return nil;
			end
		elseif (name == TITANDKP_BOSSES[boss]) then
			-- single boss kill to encounter
			return TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"][name].boss;
		end
	end
	
	return nil;	
end

-- sets the points a zone is worth
function TitanDKPSetZonePoints(zoneText, points)
	for name, zone in TITANDKP_ZONES do
		if (zone == zoneText) then
			TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"][name].entrance = points;
		end
	end
end

-- sets the points a boss is worth
function TitanDKPSetBossPoints(boss, points)
	for name, zone in TITANDKP_ZONES do
		if (name == TITANDKP_BOSSES[boss]) then
			TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["instance"][name].boss = points;
		end
	end
end

-- Stop draging frame
function TitanDKPDragStop()
	if (this.isMoving) then
		this:StopMovingOrSizing();
		this.isMoving = false;
	end
end

-- Start draging frame
function TitanDKPDragStart()
	if (((not this.isLocked) or (this.isLocked == 0)) and (arg1 == "LeftButton")) then
		this:StartMoving();
		this.isMoving = true;
	end
end

-- set focus when tab is pressed
function TitanDKPTabPressed(previousString, nextString)
	if (IsShiftKeyDown()) then
		getglobal(previousString):SetFocus();
	else
		getglobal(nextString):SetFocus();
	end
end

-- search for non-case sensitive name
function TitanDKPFindName(searchval)
	if (searchval) then
		for name, value in TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"] do
			if (string.lower(name) == string.lower(searchval)) then
				return name;
			end
		end
	end
	
	return nil;
end

-- search for non-case sensitive class
function TitanDKPFindClass(searchval)
	if (searchval) then
		for name, value in TITANDKP_CLASSES do
			if (string.lower(value) == string.lower(searchval)) then
				return value;
			end
		end
	end

	return TITANDKP_CLASSES["Unknown"];
end

-- update the frames
function TitanDKPUpdateFrames()
	local raid = getglobal("TitanDKPRaidFrame");
	local saved = getglobal("TitanDKPSavedFrame");
	local info = getglobal("TitanDKPInfoFrame");
	if (raid and raid:IsVisible()) then
		TitanDKPUpdatePlayerWindow("raid");
	end
	if (saved and saved:IsVisible()) then
		TitanDKPUpdatePlayerWindow("saved");
	end
	if (info and info:IsVisible()) then
		TitanDKPUpdatePlayerWindow("info");
	end
end

-- round the number
function TitanDKPRound(num)
	return tonumber(string.format("%.2f", num));
end

-- create a new raid
function TitanDKPJoinRaid()
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid = true;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone = "";
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["started"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["announced"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"][TitanDKPName] = TITANDKPSavedInfo["DKPSystem"][TitanDKPCurrentSystem]["saved"][TitanDKPName].currentDKP;
end

-- destroy current raid
function TitanDKPLeaveRaid()
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].inRaid = false;
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName].currentZone = "";
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["started"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["killed"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["announced"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["items"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["unassigneditems"] = {};
	TITANDKPSavedInfo[TitanDKPRealm][TitanDKPName]["raid"] = {};
end
