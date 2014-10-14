-- Settings
DefenseTracker_historyLength = 7200;

-- Variables for important info
DefenseTracker_numAttacks = 0;	
DefenseTracker_nextHistoryPurge = nil;
DefenseTracker_uploadNotRequested = TRUE;
DefenseTracker_subzones = {};

-- Tables for attack summaries
DefenseTracker_attacks = {}; -- [Timestamp] = Subzone
DefenseTracker_SubzoneSum = {}; -- [Subzone] = Sum
DefenseTracker_ZoneSum = {}; -- [Zone] = Sum
DefenseTracker_SubzoneTimestamp = {}; -- [Subzone] = timestamp
DefenseTracker_ZoneTimestamp = {}; -- [Zone] = timestamp
DefenseTracker_SortedSubzoneSum = {}; -- [Rank] = Subzone
DefenseTracker_SortedZoneSum = {}; -- [Rank] = Zone
DefenseTracker_SortedSubzoneTimestamp = {}; -- [Rank] = Subzone
DefenseTracker_SortedZoneTimestamp = {}; -- [Rank] = Zone

-- Savedvariables 
--[[
DefenseTracker_newSubzones -- [Subzone] = Zone
DefenseTracker_unknowns -- List of unknown subzones 
]]--

DefenseTracker_DebugOutput = false;

function DT_DebugFunc(func, args)
	local argstring = "(";
	if args then
		for i=1, table.getn(args) do
			if (not (i==1)) then argstring = argstring.. ", "; end
			argstring = argstring.. args[i];
		end
	end
	argstring = argstring.. ")";
	if (DefenseTracker_DebugOutput) then DEFAULT_CHAT_FRAME:AddMessage("DefTrackDebug: ".. func.. argstring); end
end

function DT_Debug(msg)
	if (DefenseTracker_DebugOutput) then DEFAULT_CHAT_FRAME:AddMessage("DefTrackDebug: ".. msg); end
end

------------------------------
--      Event Handlers      --
------------------------------

function DefenseTracker_OnUpdate(elapsed)
	if( not this.updateTimer ) then
		this.updateTimer = 0;
	else
		this.updateTimer = this.updateTimer - elapsed;
	end
	if (DefenseTracker_nextHistoryPurge) then
		if (DefenseTracker_nextHistoryPurge < time()) then 
			DefenseTracker_CleanHistory(); 
		end
	end
	if( this.updateTimer <= 0 ) then
		this.updateTimer = 1.00;
	end
end

function DefenseTracker_OnLoad()
	DT_DebugFunc("DefenseTracker_OnLoad");
	this:RegisterEvent("VARIABLES_LOADED"); 
	this:RegisterEvent("ZONE_UNDER_ATTACK"); 
end

function DefenseTracker_OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
	if (event == "VARIABLES_LOADED") then 
		DefenseTracker_Init(); 
	end 
	if (event == "CHAT_MSG_CHANNEL") then
		-- We have chatter, lets see if it's Def related
		DefenseTracker_getchannel(arg1, arg2, arg9);
	end
	if (event == "ZONE_UNDER_ATTACK") then
		Sea.IO.printComma(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
	end
	if (event == "ZONE_CHANGED_NEW_AREA") then
		DefenseTracker_handleZoneChange();
	end
	if (event == "ZONE_CHANGED") then
		DefenseTracker_handleZoneChange();
	end
	if (event == "ZONE_CHANGED_INDOORS") then
		DefenseTracker_handleZoneChange();
	end
end

function DefenseTracker_Init()
	DT_DebugFunc("DefenseTracker_Init");

	this:RegisterEvent("CHAT_MSG_CHANNEL");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	this:RegisterEvent("ZONE_CHANGED");
	this:RegisterEvent("ZONE_CHANGED_INDOORS");

	-- Init some variables
	if (not DefenseTracker_newSubzones) then DefenseTracker_newSubzones = {}; end
	if (not DefenseTracker_unknowns) then DefenseTracker_unknowns = {}; end
	
	DefenseTracker_cleanNewSubzones();
	
	-- Register with myAddOns
	if(myAddOnsFrame) then
		myAddOnsList.DefenseTracker = {
		name = DEFENSETRACKER_STRINGS_MODNAME,
		description = DEFENSETRACKER_STRINGS_MODDESC,
		version = DEFENSETRACKER_STRINGS_MODVERSION,
		category = MYADDONS_CATEGORY_BARS,
		frame = DEFENSETRACKER_STRINGS_BARFRAMENAME
		};
	end
end

------------------------------
--      Chat Functions      --
------------------------------

function DefenseTracker_getchannel(msg, auth, chan)
	if (strfind(chan, DEFENSETRACKER_STRINGS_WDCHANNAME)) then
		DefenseTracker_HandleWorld(msg);
	elseif (strfind(chan, DEFENSETRACKER_STRINGS_LDCHANNAME)) then
		DefenseTracker_HandleLocal(msg, auth);
	end
end

function DefenseTracker_HandleWorld(msg)
	DT_DebugFunc("DefenseTracker_HandleWorld", {msg});
	
	local location;
	for location in string.gfind(msg, DEFENSETRACKER_STRINGS_UNDERATTACK) do
		DefenseTracker_RecordAttack(location, time());
	end;
end

function DefenseTracker_HandleLocal(msg, auth)
	
	if (strfind(msg, DEFENSETRACKER_STRINGS_UNDERATTACK)) then
		DT_DebugFunc("DefenseTracker_HandleLocal", {msg, auth});

		-- local location=string.sub(msg, 11, strlen(msg)-19);
		local zone, location;
		for location in string.gfind(msg, DEFENSETRACKER_STRINGS_UNDERATTACK) do
			zone = GetZoneText();
			DefenseTracker_updateZoneList(location, zone);
		end;
	end
end

------------------------------
--Attack Tracking Functions --
------------------------------

function DefenseTracker_RecordAttack(subzone, timestamp)
	DT_DebugFunc("DefenseTracker_RecordAttack", {subzone, timestamp});
	DefenseTracker_attacks[timestamp] = subzone;
	DefenseTracker_AddToTables(timestamp, subzone);
	DefenseTracker_SortTables();
	
	DefenseTracker_numAttacks = DefenseTracker_numAttacks + 1;
	
	if (not DefenseTracker_nextHistoryPurge) then
		DefenseTracker_nextHistoryPurge = DefenseTracker_historyLength + timestamp;
	end
end

function DefenseTracker_CleanHistory()
	local minstamp = 0;
	
	if (DefenseTracker_historyLength > 0) then
		for timestamp in DefenseTracker_attacks do
			if (timestamp + DefenseTracker_historyLength < time()) then
				DefenseTracker_EraseAttack(DefenseTracker_attacks[timestamp], timestamp);
			elseif ( (minstamp == 0) or (timestamp < minstamp) ) then
				minstamp = timestamp;
			end
		end
		
		if (DefenseTracker_numAttacks == 0) then DefenseTracker_nextHistoryPurge = nil; 
		else DefenseTracker_nextHistoryPurge = DefenseTracker_historyLength + minstamp; end
	end
end

function DefenseTracker_EraseAttack(subzone, timestamp)
	DefenseTracker_attacks[timestamp] = nil;
	DefenseTracker_RemoveFromTables(timestamp, subzone);
	DefenseTracker_SortTables();
		
	DefenseTracker_numAttacks = DefenseTracker_numAttacks - 1;
end

function DefenseTracker_AddToTables(timestamp, subzone)
	local mainzone = DefenseTracker_getMainZone(subzone);

	if (not DefenseTracker_SubzoneSum[subzone]) then DefenseTracker_SubzoneSum[subzone] = 0; end
	if (not DefenseTracker_ZoneSum[mainzone]) then DefenseTracker_ZoneSum[mainzone] = 0; end

	DefenseTracker_SubzoneSum[subzone] = DefenseTracker_SubzoneSum[subzone] + 1;
	DefenseTracker_ZoneSum[mainzone] = DefenseTracker_ZoneSum[mainzone] + 1;
	DefenseTracker_SubzoneTimestamp[subzone] = timestamp;
	DefenseTracker_ZoneTimestamp[mainzone] = timestamp;
end

function DefenseTracker_RemoveFromTables(timestamp, subzone)
	local mainzone = DefenseTracker_getMainZone(subzone);
	
	DefenseTracker_SubzoneSum[subzone] = DefenseTracker_SubzoneSum[subzone] - 1;
	DefenseTracker_ZoneSum[mainzone] = DefenseTracker_ZoneSum[mainzone] - 1;

	if (DefenseTracker_SubzoneSum[subzone] == 0) then
		DefenseTracker_SubzoneSum[subzone] = nil;
		DefenseTracker_SubzoneTimestamp[subzone] = nil;
	end
	if (DefenseTracker_ZoneSum[mainzone] == 0) then 
		DefenseTracker_ZoneSum[mainzone] = nil; 
		DefenseTracker_ZoneTimestamp[mainzone] = nil;
	end
end

function DefenseTracker_SortTables()
	DefenseTracker_SortedSubzoneSum = DefenseTracker_Sort(DefenseTracker_SubzoneSum);
	DefenseTracker_SortedZoneSum = DefenseTracker_Sort(DefenseTracker_ZoneSum);
	DefenseTracker_SortedSubzoneTimestamp = DefenseTracker_Sort(DefenseTracker_SubzoneTimestamp);
	DefenseTracker_SortedZoneTimestamp = DefenseTracker_Sort(DefenseTracker_ZoneTimestamp);
end

function DefenseTracker_Sort(intable)
	local table1 = {};	
	local returntable = {};
	for key,val in intable do table1[key] = val; end;
	
	local tablesize = 0;
	for key,val in table1 do tablesize = tablesize+1; end;
	
	for i=1, tablesize do
		local maxval = 0;
		local maxkey = "";
		for key,val in table1 do
			if (val > maxval) then
				maxval = val;
				maxkey = key;
			end
		end
		returntable[i] = maxkey;
		table1[maxkey] = nil;
	end
	
	return returntable;
end

------------------------------
--  Zone Tracking Functions --
------------------------------

function DefenseTracker_handleZoneChange()
	local subzone = GetSubZoneText();
	local zone = GetZoneText();
	
	if (subzone == nil) then
		subzone = zone;
	end
	if (subzone == "") then
		subzone = zone;
	end

	DefenseTracker_updateZoneList(subzone, zone);	
end

function DefenseTracker_updateZoneList(subzone, zone)
	if (DefenseTracker_subzones[subzone] == nil) then
		if (DefenseTracker_newSubzones[subzone] == nil) then
			-- Subzone has not been seen before
			DefenseTracker_newSubzones[subzone] = zone;
			if (DefenseTracker_uploadNotRequested) then
				DEFAULT_CHAT_FRAME:AddMessage(DEFENSETRACKER_STRINGS_NEWZONE1.. subzone.. "/".. zone.. DEFENSETRACKER_STRINGS_NEWZONE2);
				DefenseTracker_uploadNotRequested = FALSE;
			end
			return 1;
		end
	end
	
	return 0;
end

function DefenseTracker_isLocal(subzone)
	local zone = GetZoneText();

	if (DefenseTracker_subzones[subzone] == zone) then
		return true;
	end

	if (DefenseTracker_newSubzones[subzone] == zone) then
		return true;
	end
	
	return false;
end

function DefenseTracker_cleanNewSubzones()
	local DefenseTracker_oldNewSubzones = DefenseTracker_newSubzones;
	DefenseTracker_newSubzones = {};
	
	for loc in DefenseTracker_oldNewSubzones do
		if(DefenseTracker_subzones[loc] == nil) then
			DefenseTracker_newSubzones[loc] = DefenseTracker_oldNewSubzones[loc];
		end
	end
end

function DefenseTracker_getMainZone(subzone)
	if (DefenseTracker_subzones[subzone]) then
		return DefenseTracker_subzones[subzone];
	end

	if (DefenseTracker_newSubzones[subzone]) then
		return DefenseTracker_newSubzones[subzone];
	end
	
	if (not DefenseTracker_unknowns[subzone]) then
		DefenseTracker_unknowns[subzone] = 1;
	end
	
	return DEFENSETRACKER_STRINGS_UNKNOWNZONE;

end



------------------------------
--     Output Functions     --
--     Used in plugins      --
------------------------------

function DefenseTracker_GetTimeText(secs)
	local returnstring = "";
	
	if (secs < 60) then
		returnstring = secs.. DEFENSETRACKER_STRINGS_SECONDS;
	elseif (secs < 300) then
		returnstring = math.floor(secs/60*4)/4 .. DEFENSETRACKER_STRINGS_MINUTES;
	elseif (secs < 3600) then
		returnstring = math.floor(secs/60) .. DEFENSETRACKER_STRINGS_MINUTES;
	else
		returnstring = math.floor(secs/3600*4)/4 .. DEFENSETRACKER_STRINGS_HOUR;
	end
	
	return returnstring
end

function DefenseTracker_GetTooltipRawData(dataarray)	
	if (DefenseTracker_numAttacks == 0) then return nil; end
	
	local returnstring = "";
	
	if dataarray then
		for key,val in dataarray do
			returnstring = returnstring.. "[".. key.. "] ".. val.. "\n";
		end
	end
	
	return retrunstring;
end

function DefenseTracker_GetTooltipData(dataarray, numvals, isSubzone)	
	local linestr = "------------";

	local returnstring = "";
		
	for i=1,numvals do
		if (dataarray[i]) then
			local zone = dataarray[i];
			local atttime = 0;
			local numatt = 0;
			
			if (isSubzone) then
				numatt = DefenseTracker_SubzoneSum[zone];
				atttime = DefenseTracker_SubzoneTimestamp[zone];
			else
				numatt = DefenseTracker_ZoneSum[zone];
				atttime = DefenseTracker_ZoneTimestamp[zone];
			end
			
			local elapsedtime = DefenseTracker_GetTimeText(time() - atttime);
			local mainzone = DefenseTracker_getMainZone(zone);
			
			if (isSubzone) then
				if (DefenseTracker_isLocal(zone)) then
					returnstring = returnstring.. DEFENSETRACKER_STRINGS_LOCALHEADER.. zone.. " (".. numatt.. ") - ".. elapsedtime.. DEFENSETRACKER_STRINGS_AGOENDER.. "\n";
				elseif (mainzone == loc) then
					returnstring = returnstring.. zone.. " (".. numatt.. ") - ".. elapsedtime.. DEFENSETRACKER_STRINGS_AGOENDER.. "\n";
				else
					returnstring = returnstring.. mainzone.. ": ".. zone.. " (".. numatt.. ") - ".. elapsedtime.. DEFENSETRACKER_STRINGS_AGOENDER.. "\n";
				end
			else
				returnstring = returnstring.. zone.. " (".. numatt.. ") - ".. elapsedtime.. DEFENSETRACKER_STRINGS_AGOENDER.. "\n";
			end
		end
	end
	
	return returnstring;
end

function DefenseTracker_getLastAttack()
	if (DefenseTracker_numAttacks == 0) then return nil; end

	local lasttime = 0;
	local lastsubzone = "";
	
	for timestamp,subzone in DefenseTracker_attacks do
		if (timestamp > lasttime) then
			lasttime = timestamp;
			lastsubzone = subzone;
		end
	end		
		
	local returnstring = ""..lastsubzone.." ("..DefenseTracker_SubzoneSum[lastsubzone]..")";
	local islocal = false;
	
	if (DefenseTracker_isLocal(lastsubzone)) then
		islocal = true;
	end
	
	return returnstring, islocal, lasttime;
end

function DefenseTracker_GetNumAttText()
	if (DefenseTracker_numAttacks == 0) then
		return DEFENSETRACKER_STRINGS_NOATTACKS;
	elseif (DefenseTracker_numAttacks == 1) then
		return DEFENSETRACKER_STRINGS_ATTACKTEXT;
	else
		return DefenseTracker_numAttacks.. DEFENSETRACKER_STRINGS_ATTACKSTEXT;
	end
end