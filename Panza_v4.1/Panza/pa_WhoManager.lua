----------------------------------	
-- Who manager system 
-- Thanks CTA
-- for in pairs() completed for BC
----------------------------------

local PAWM_TICK_TIME				= 1;
local PAWM_WHO_COOL_DOWN_TIME 		= 5.25;
local PAWM_PRUNE_COOL_DOWN_TIME 	= 300;

-- used to determine the life of a who entry, could be an adjustable, saved variable later
local PAWM_ENTRY_LIFE_FACTOR		= 60;

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

-- who manager function pack
PAWM = {};
		
-- Panza or an XML object must call these functions in OnEvent() and OnUpdate()

PAWM.onEventVariablesLoaded = function( event )
	if( PA.PAWM_Variables == nil ) then
		PA.PAWM_Variables = {
			data = {},
			maxEntriesPerRealm = 100
		}; 
	end
	PA.PAWM_Variables.data[GetRealmName()] = PA.PAWM_Variables.data[GetRealmName()] or {};
	PAWM.whoTable = PA.PAWM_Variables.data[GetRealmName()];
	PAWM.maxEntriesPerRealm = PA.PAWM_Variables.maxEntriesPerRealm;
	
	PAWM.preHookSendWho  = SendWho;
	SendWho = PAWM.hookedSendWho;

	PAWM.preHookFriendsFrame_OnEvent = FriendsFrame_OnEvent;
	FriendsFrame_OnEvent =  PAWM.hookedFriendsFrame_OnEvent;
	
	PAWM.dbg = 0;
end

PAWM.onEventWhoListUpdated = function( event )
	PA:Message3("Core",5,"(PAWM) \'WhoListUpdated\' event");		

	if( PAWM.request ) then
		local numWhos, totalCount = GetNumWhoResults();
		local i, name, guild, level, race, class, zone, group;
		local ok = 0;
		for i=1, totalCount do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
			if( name == PAWM.request ) then
				PA:Message3("Core",5,"(PAWM) Saving who information for "..PAWM.request);		
				PAWM.whoTable[name] = { time(), level, race, class, guild };
				ok = 1;
				break;
			end
		end
		if( ok == 0 ) then
			PA:Message3("Core",5,"Did not get who information for ".. PAWM.request);		
			--PAWM.addNameToWhoQueue( PAWM.request );
		end
		PAWM.request = nil;
		SetWhoToUI(0);				
		--FriendsFrame:RegisterEvent("WHO_LIST_UPDATE"); 
	elseif( PAWM.urgentRequest ) then
		PA:Message3("Core",5,"(PAWM) \'WhoListUpdated\' event after sending urgent request: "..PAWM.urgentRequest);		
		PAWM.urgentRequest = nil;
		--[[ Commented for later
		local numWhos, totalCount = GetNumWhoResults();
		local i, name, guild, level, race, class, zone, group;
		for i=1, totalCount do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
			if( PAWM.whoTable[name] ) then
				PAWM.whoTable[name] = { time(), level, race, class, guild, zone, group };
			end
		end
		--]]
	end
end

PAWM.onUpdate = function( elapsed ) 
	ticker = ticker + elapsed;
	if( ticker > 5 ) then
		--PAWM_Label1:SetText( "Who table size: "..PAWM.getLength( PAWM.whoTable ) );
		--PAWM_Label2:SetText( "queue size: "..PAWM.getLength( whoQueue ) );
		--PAWM_Label3:SetText( "Urgent queue size: "..PAWM.getLength( urgentWhoQueue ) );
		ticker = 0;
	end
	timeSinceLastWhoSent = timeSinceLastWhoSent + elapsed;
	timeSinceLastPruning = timeSinceLastPruning + elapsed;
	if( timeSinceLastWhoSent > PAWM_WHO_COOL_DOWN_TIME ) then
	
		-- if urgent requests present, then send them first		
		if( urgentWhoQueue[1] ) then
			PA:Message3("Core",5,"(PAWM) Sending urgent who request: "..urgentWhoQueue[1]);
			PAWM.request = nil;
			PAWM.urgentRequest = urgentWhoQueue[1];
			SetWhoToUI(0);
			SendWho( urgentWhoQueue[1] );
			table.remove( urgentWhoQueue, 1 );
		else
			
			-- if no urgent requests, only PAWM requests, then we ask quietly
			if( whoQueue[1] ) then
			
				-- if user has who frame open, then pause requests
				if( WhoFrame:IsVisible() ) then
					if( state == 1 ) then
						PA:Message3("Core",5,"(PAWM) Pausing requests, Who window is open");
						state = 0;
					end
				else
					-- if user has who frame closed, then resume requests
					if( state == 0 ) then
						PA:Message3("Core",5,"(PAWM) Resuming requests, Who window is closed");
						state = 1;
					end
					
					-- cancel request in case the who data was updated after the addition of the name to the queue
					-- should not happen at this point, but left here for future changes
					if( PAWM.whoTable[whoQueue[1]] ) then
						PA:Message3("Core",5,"(PAWM) cancelling, already have data for \'"..whoQueue[1].."\'");
						table.remove( whoQueue, 1 );
						return;
					end
					
					--FriendsFrame:UnregisterEvent("WHO_LIST_UPDATE");
					PAWM.request = whoQueue[1];
					SetWhoToUI(1);
					SendWho( "n-"..PAWM.request );
					PA:Message3("Core",5 "(PAWM) Sending who request: "..whoQueue[1]);
					table.remove( whoQueue, 1 );
				end			
			
			end
			
		end
		
		ticker = 0;
	end
	if( timeSinceLastPruning >= PAWM_PRUNE_COOL_DOWN_TIME ) then
		PAWM.pruneWhoTable();
	end
end



--  the 'interface', ie. public functions

PAWM.getInformation = function( name ) 
	if( PAWM.whoTable[name] ) then
		return unpack( PAWM.whoTable[name].whoData );
	else
		return nil;
	end
end

PAWM.getPositionInQueue = function( name, tbl )
	tbl = tbl or whoQueue;
	for key, data in pairs(tbl) do
		if( data == name ) then
			return key;
		end
	end
	return 0;
end

PAWM.addNameToUrgentWhoQueue = function( name )
	if( PAWM.getPositionInQueue( name, urgentWhoQueue ) == 0 ) then
		table.insert( urgentWhoQueue, name );
		PA:Message3("Core",5, "(PAWM) Adding urgent who request: "..name);		
	end
end

PAWM.addNameToWhoQueue = function( name )
	if( PAWM.getPositionInQueue( name, whoQueue ) == 0 ) then
		table.insert( whoQueue, name );
		PA:Message3("Core",5,"(PAWM) Adding who request: "..name.."; queue length is "..	PAWM.getLength( whoQueue ));		
	end
end

PAWM.printPlayerWhoData = function( name )
	local data = PAWM.whoTable[name];
	local now = time();
	if( data == nil ) then
		PA:Message3("Core",1,"No who data for ".. name.." found.");
	else
		PA:Message3("Core",1, "Who data for ".. name..":");
		PA:Message3("Core",1, "Time: ".. data[1]);
		PA:Message3("Core",1, "Level: ".. data[2]);
		PA:Message3("Core",1, "Race: ".. data[3]);
		PA:Message3("Core",1, "Class: ".. data[4]);
		PA:Message3("Core",1, "Guild: ".. data[5]);
		PA:Message3("Core",1, "Zone: ".. data[6]);
		PA:Message3("Core",1, "Group: ".. ( data[7] or "nil" ));
		PA:Message3("Core",1, "Entry Life: ".. (data[2]*PAWM_ENTRY_LIFE_FACTOR).."sec");
		PA:Message3("Core",1, "Entry Age: ".. ((now - data[1])).."sec");
		PA:Message3("Core",1, "Entry Life Left: ".. ( ( ( data[2] * PAWM_ENTRY_LIFE_FACTOR ) - ( now - data[1] ) ) ) .."sec");
		PA:Message3("Core",1, "-");
	end
end

PAWM.printWhoTable = function()
	PA:Message3("Core",1,"(PAWM) Who table has ".. PAWM.getLength(PAWM.whoTable).. " entries: ");
	for name, _ in pairs(PAWM.whoTable) do
		PAWM.printPlayerWhoData( name );
	end
	PA:Message3("Core",1,"(PAWM) -- End Who table");
end

PAWM.toOldFormat = function( name )
	local data = PAWM.whoTable[name];
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

PAWM.getQueueLength = function()
	return PAWM.getLength( whoQueue );
end

PAWM.showWhoTooltip = function( name, tooltip )
	local entry = PAWM.whoTable[name];
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

-- private  functions

PAWM.hookedSendWho = function( ... ) 
	if ( timeSinceLastWhoSent <= PAWM_WHO_COOL_DOWN_TIME ) then
		PAWM.addNameToUrgentWhoQueue( arg[1] );
	else
		timeSinceLastWhoSent = 0;
		PAWM.preHookSendWho( unpack( arg ) );
	end
end

PAWM.hookedFriendsFrame_OnEvent = function( event ) 
	if( event ~= "WHO_LIST_UPDATE" and PAWM.request == nil ) then
	--	PAWM.onEventWhoListUpdated( event );
	--else
	--if( event ~= "WHO_LIST_UPDATE" or ( whoQueue[1] == nil and PAWM.request == nil ) ) then
		PAWM.preHookFriendsFrame_OnEvent( event );
	end
end
	
PAWM.getLength = function( tbl )
	local length = getn( tbl ) or 0;
	if( length == 0 ) then
		for i, j in pairs(tbl) do
			length = length + 1;
		end
	end
	return length;
end

PAWM.pruneWhoTable = function()
	PA:Message3("Core",5,"Pruning Who table; ".. PAWM.getLength(PAWM.whoTable).. " entries before pruning ");
	
	-- remove old entries
	local now = time();
	for name, whoData in pairs(PAWM.whoTable) do
		if( now - whoData[1] > PAWM_ENTRY_LIFE_FACTOR*whoData[2] ) then
			PA:Message3("Core",5,"Removing old entry for "..name);
			PAWM.whoTable[name] = nil;
		end
	end
	PA:Message3("Core",5,"(PAWM) Who table has ".. PAWM.getLength(PAWM.whoTable).. " entries after pruning. ");
	
	-- remove some entries if table size excedds maximum size
	-- could be improved to remove oldest entries first
	-- this could also be incorporated into the above loop for efficiency
	local length = 0;
	for name, whoData in pairs(PAWM.whoTable) do
		length = length + 1;
		if( length > PAWM.maxEntriesPerRealm ) then
			PA:Message3("Core",5,"(PAWM) Who table length exceeds ".. PAWM.maxEntriesPerRealm  ..", removing entry for "..name);
			PAWM.whoTable[name] = nil;
			length = length - 1;
		end
	end

	timeSinceLastPruning = 0;
end

