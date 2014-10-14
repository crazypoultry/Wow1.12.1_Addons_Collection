--[[	Who manager system 
	------------------------------------------------------------------------------------------------------------------------
	Data format: { time, level, race, class, guild }
--]]

local CTAWM_TICK_TIME				= 1;
local CTAWM_WHO_COOL_DOWN_TIME 		= 5.25;
local CTAWM_PRUNE_COOL_DOWN_TIME 	= 300;

-- used to determine the life of a who entry, could be an adjustable, saved variable later
local CTAWM_ENTRY_LIFE_FACTOR		= 60;

-- timers to coordinate ui updates, sending who requests and pruning the who table
local ticker = 0.0;
local timeSinceLastWhoSent = 0;
local timeSinceLastPruning = 0;

-- stateless queues for this session
local whoQueue = {};
local urgentWhoQueue = {};

-- tracks the current status of the who manager system
-- has 2 states: 0 - paused/inactive; 1 - resumed/active.
local state = 1;

-- who manager function package
CTAWM = {};
	

	
-- CTA or an XML object must call these functions in OnEvent() and OnUpdate()

CTAWM.onEventVariablesLoaded = function( event )
	if( CTA_SavedVariables.CTAWM_Variables == nil ) then
		CTA_SavedVariables.CTAWM_Variables = {
			data = {},
			maxEntriesPerRealm = 100
		}; 
	end
	CTA_SavedVariables.CTAWM_Variables.data[GetRealmName()] = CTA_SavedVariables.CTAWM_Variables.data[GetRealmName()] or {};
	CTAWM.whoTable = CTA_SavedVariables.CTAWM_Variables.data[GetRealmName()];
	CTAWM.maxEntriesPerRealm = CTA_SavedVariables.CTAWM_Variables.maxEntriesPerRealm;
	
	CTAWM.preHookSendWho  = SendWho;
	SendWho = CTAWM.hookedSendWho;

	CTAWM.preHookFriendsFrame_OnEvent = FriendsFrame_OnEvent;
	FriendsFrame_OnEvent =  CTAWM.hookedFriendsFrame_OnEvent;
	
	CTAWM.preHookSetItemRef = SetItemRef;
	SetItemRef = CTAWM.hookedSetItemRef;
	
	CTAWM.dbg = 0;
end

CTAWM.onEventWhoListUpdated = function( event )
	--CTAWM.println( "Caught \'WhoListUpdated\' event", CTA_Util.logPrintln, CTAWM.dbg );		

	if( CTAWM.request ) then
		local numWhos, totalCount = GetNumWhoResults();
		local i, name, guild, level, race, class, zone, group;
		local ok = 0;
		for i=1, totalCount do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
			if( name == CTAWM.request ) then
				CTAWM.println( "Saving who information for "..CTAWM.request, CTA_Util.logPrintln, CTAWM.dbg );		
				CTAWM.whoTable[name] = { time(), level, race, class, guild };
				ok = 1;
				break;
			end
		end
		if( ok == 0 ) then
			CTAWM.println( "Did not get who information for ".. CTAWM.request, CTA_Util.logPrintln, CTAWM.dbg );		
			--CTAWM.addNameToWhoQueue( CTAWM.request );
		end
		CTAWM.request = nil;
		SetWhoToUI(0);				
		--FriendsFrame:RegisterEvent("WHO_LIST_UPDATE"); 
	elseif( CTAWM.urgentRequest ) then
		CTAWM.println( "Caught \'WhoListUpdated\' event after sending urgent request: "..CTAWM.urgentRequest, CTA_Util.logPrintln, CTAWM.dbg );		
		CTAWM.urgentRequest = nil;
		--[[ Commented for later
		local numWhos, totalCount = GetNumWhoResults();
		local i, name, guild, level, race, class, zone, group;
		for i=1, totalCount do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
			if( CTAWM.whoTable[name] ) then
				CTAWM.whoTable[name] = { time(), level, race, class, guild, zone, group };
			end
		end
		--]]
	end
end

CTAWM.onUpdate = function( elapsed ) 
	ticker = ticker + elapsed;
	if( ticker > 5 ) then
		--CTAWM_Label1:SetText( "Who table size: "..CTAWM.getLength( CTAWM.whoTable ) );
		--CTAWM_Label2:SetText( "queue size: "..CTAWM.getLength( whoQueue ) );
		--CTAWM_Label3:SetText( "Urgent queue size: "..CTAWM.getLength( urgentWhoQueue ) );
		ticker = 0;
	end
	timeSinceLastWhoSent = timeSinceLastWhoSent + elapsed;
	timeSinceLastPruning = timeSinceLastPruning + elapsed;
	if( timeSinceLastWhoSent > CTAWM_WHO_COOL_DOWN_TIME ) then
	
		-- if urgent requests present, then send them first		
		if( urgentWhoQueue[1] ) then
			CTAWM.println( "Sending urgent who request: "..urgentWhoQueue[1], CTA_Util.logPrintln, CTAWM.dbg );
			CTAWM.request = nil;
			CTAWM.urgentRequest = urgentWhoQueue[1];
			SetWhoToUI(0);
			SendWho( urgentWhoQueue[1] );
			table.remove( urgentWhoQueue, 1 );
		else
			
			-- if no urgent requests, only CTAWM requests, then we ask quietly
			if( whoQueue[1] ) then
			
				-- if user has who frame open, then pause requests
				if( WhoFrame:IsVisible() ) then
					if( state == 1 ) then
						CTAWM.println( "Pausing requests, Who window is open", CTA_Util.logPrintln, CTAWM.dbg );
						state = 0;
					end
				else
					-- if user has who frame closed, then resume requests
					if( state == 0 ) then
						CTAWM.println( "Resuming requests, Who window is closed", CTA_Util.logPrintln, CTAWM.dbg );
						state = 1;
					end
					
					-- cancel request in case the who data was updated after the addition of the name to the queue
					-- should not happen at this point, but left here for future changes
					if( CTAWM.whoTable[whoQueue[1]] ) then
						CTAWM.println( "CTAWM: cancelling, already have data for \'"..whoQueue[1].."\'", CTA_Util.logPrintln, CTAWM.dbg );
						table.remove( whoQueue, 1 );
						return;
					end
					
					--FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE");
					CTAWM.request = whoQueue[1];
					SetWhoToUI(1);
					SendWho( "n-"..CTAWM.request );
					CTAWM.println( "Sending who request: "..whoQueue[1], CTA_Util.logPrintln, CTAWM.dbg );
					table.remove( whoQueue, 1 );
				end			
			
			end
			
		end
		
		ticker = 0;
	end
	if( timeSinceLastPruning >= CTAWM_PRUNE_COOL_DOWN_TIME ) then
		CTAWM.pruneWhoTable();
	end
end


--  public functions


CTAWM.getInformation = function( name ) 
	if( CTAWM.whoTable[name] ) then
		return CTAWM.whoTable[name];
	else
		return nil;
	end
end

CTAWM.getPositionInQueue = function( name, tbl )
	tbl = tbl or whoQueue;
	for key, data in tbl do
		if( data == name ) then
			return key;
		end
	end
	return 0;
end

CTAWM.addNameToUrgentWhoQueue = function( name )
	if( CTAWM.getPositionInQueue( name, urgentWhoQueue ) == 0 ) then
		table.insert( urgentWhoQueue, name );
		CTAWM.println( "Adding urgent who request: "..name, CTA_Util.logPrintln, CTAWM.dbg );		
	end
end

CTAWM.addNameToWhoQueue = function( name )
	if( CTAWM.getPositionInQueue( name, whoQueue ) == 0 ) then
		table.insert( whoQueue, name );
		CTAWM.println( "Adding who request: "..name.."; queue length is "..	CTAWM.getLength( whoQueue ), CTA_Util.logPrintln, CTAWM.dbg );		
	end
end

CTAWM.printPlayerWhoData = function( name, fn, dbg )
	local data = CTAWM.whoTable[name];
	local now = time();
	if( data == nil ) then
		CTAWM.println( "No who data for ".. name.." found.", fn, dbg );
	else
		CTAWM.println( "Who data for ".. name..":", fn, dbg );
		CTAWM.println( "Time: ".. data[1], fn, dbg );
		CTAWM.println( "Level: ".. data[2], fn, dbg );
		CTAWM.println( "Race: ".. data[3], fn, dbg );
		CTAWM.println( "Class: ".. data[4], fn, dbg );
		CTAWM.println( "Guild: ".. data[5], fn, dbg );
		CTAWM.println( "Zone: ".. data[6], fn, dbg );
		CTAWM.println( "Group: ".. ( data[7] or "nil" ), fn, dbg );
		CTAWM.println( "Entry Life: ".. (data[2]*CTAWM_ENTRY_LIFE_FACTOR).."sec", fn, dbg );
		CTAWM.println( "Entry Age: ".. ((now - data[1])).."sec", fn, dbg );
		CTAWM.println( "Entry Life Left: ".. ( ( ( data[2] * CTAWM_ENTRY_LIFE_FACTOR ) - ( now - data[1] ) ) ) .."sec", fn, dbg );
		CTAWM.println( "-", fn, dbg );
	end
end

CTAWM.printWhoTable = function( fn, dbg )
	CTAWM.println( "-- Who table has ".. CTAWM.getLength(CTAWM.whoTable).. " entries: ", fn, dbg );
	for name, _ in CTAWM.whoTable do
		CTAWM.printPlayerWhoData( name, fn, dbg );
	end
	CTAWM.println( "-- End Who table", fn, dbg );
end

CTAWM.toOldFormat = function( name )
	local data = CTAWM.whoTable[name];
	if( data ) then
		return {
			level = data[2];
			class = data[4];
			guild = "<"..(data[5] or "")..">";	
		};
	else
		return nil;
	end
end

CTAWM.getQueueLength = function()
	return CTAWM.getLength( whoQueue );
end

CTAWM.showWhoTooltip = function( name, tooltip )
	local entry = CTAWM.whoTable[name];
	if( entry ) then
		ShowUIPanel(tooltip);
		if ( not tooltip:IsVisible() ) then
			tooltip:SetOwner(UIParent, "ANCHOR_PRESERVE");
		end
		tooltip:ClearLines();
		tooltip:AddLine( name, 1, 1, 1 );
		tooltip:AddLine( "Level "..entry[2] .. " " .. entry[3] .. " " .. entry[4], 1, 0.8, 0, 1, 1 );
		if( entry[5] ~= "" ) then
			tooltip:AddLine( "Member of ".. entry[5] .."", 1, 0.8, 0, 1, 1 );
		end
		tooltip:Show();
	end
end


-- hooked  functions


CTAWM.hookedSendWho = function( ... ) 
	--if ( timeSinceLastWhoSent <= CTAWM_WHO_COOL_DOWN_TIME ) then
	--	CTAWM.addNameToUrgentWhoQueue( arg[1] );
	--else
		timeSinceLastWhoSent = 0;
		CTAWM.preHookSendWho( unpack( arg ) );
	--end
end

CTAWM.hookedFriendsFrame_OnEvent = function( event ) 
	if( event ~= "WHO_LIST_UPDATE" and CTAWM.request == nil ) then
	--	CTAWM.onEventWhoListUpdated( event );
	--else
	--if( event ~= "WHO_LIST_UPDATE" or ( whoQueue[1] == nil and CTAWM.request == nil ) ) then
		CTAWM.preHookFriendsFrame_OnEvent( event );
	end
end


CTAWM.hookedSetItemRef = function(...)
	local link = arg[1];
	if ( strsub(link, 1, 6) == "player" ) then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			if ( IsShiftKeyDown() ) then
				if ( timeSinceLastWhoSent <= CTAWM_WHO_COOL_DOWN_TIME ) then
					CTA_Util.chatPrintln( CTA_GETTING_WHO_INFO.." "..name.."..." );
					CTAWM.addNameToUrgentWhoQueue( "n-"..name );
					return;
				end
			end
		end
	end
	
	CTAWM.preHookSetItemRef(unpack(arg));
end
	
	
-- private  functions

	
CTAWM.println = function( str, fn, dbg )
	fn = fn or CTA_Util.chatPrintln;
	if( not dbg or dbg == 1 ) then
		fn( "WM: "..str );
	end
end

CTAWM.getLength = function( tbl )
	local length = getn( tbl ) or 0;
	if( length == 0 ) then
		for i, j in tbl do
			length = length + 1;
		end
	end
	return length;
end

CTAWM.pruneWhoTable = function()
	CTAWM.println( "Pruning Who table; ".. CTAWM.getLength(CTAWM.whoTable).. " entries before pruning ", CTA_Util.logPrintln, CTAWM.dbg  );
	
	-- remove old entries
	local now = time();
	for name, whoData in CTAWM.whoTable do
		if( now - whoData[1] > CTAWM_ENTRY_LIFE_FACTOR*whoData[2] ) then
			CTAWM.println( "Removing old entry for "..name, CTA_Util.logPrintln, CTAWM.dbg );
			CTAWM.whoTable[name] = nil;
		end
	end
	CTAWM.println( "Who table has ".. CTAWM.getLength(CTAWM.whoTable).. " entries after pruning. ", CTA_Util.logPrintln, CTAWM.dbg  );
	
	-- remove some entries if table size excedds maximum size
	-- could be improved to remove oldest entries first
	-- this could also be incorporated into the above loop for efficiency
	local length = 0;
	for name, whoData in CTAWM.whoTable do
		length = length + 1;
		if( length > CTAWM.maxEntriesPerRealm ) then
			CTAWM.println( "Who table length exceeds ".. CTAWM.maxEntriesPerRealm  ..", removing entry for "..name, CTA_Util.logPrintln, CTAWM.dbg );
			CTAWM.whoTable[name] = nil;
			length = length - 1;
		end
	end

	timeSinceLastPruning = 0;
end

