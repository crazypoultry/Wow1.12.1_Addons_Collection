local queueEnabled = false;
local AVEnabled = false;
local ABEnabled = false;

local queueDisplaying = {};
local addActiveText = false;
local currentBG = -1;
local currentBGName = "";
local timerFormat = "%s: %s";

function SSOverlayMods_OnLoad()
	this:RegisterEvent( "UPDATE_BATTLEFIELD_STATUS" );

	this:RegisterEvent( "CHAT_MSG_MONSTER_YELL" );
	this:RegisterEvent( "CHAT_MSG_BG_SYSTEM_HORDE" );
	this:RegisterEvent( "CHAT_MSG_BG_SYSTEM_ALLIANCE" );
end

function SSOverlayMods_OnEvent( event )	
	-- Alterac Valley capture/destroy events
	if( event == "CHAT_MSG_MONSTER_YELL" and arg2 == SS_HERALD ) then
		local faction;
		
		if( string.find( arg1, SS_ALLIANCE ) ) then
			faction = SS_ALLIANCE;		
		elseif( string.find( arg1, SS_HORDE ) ) then
			faction = SS_HORDE;
		end
		
		-- Is it a resource taken event?
		if( string.find( arg1, SS_AV_TAKEN ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_TAKEN );
			
			SSOverlay_RemoveByText( resourceName );
		elseif( string.find( arg1, SS_AV_DESTROYED ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_DESTROYED );
			
			SSOverlay_RemoveByText( resourceName );
		elseif( string.find( arg1, SS_AV_UNDERATTACK ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_UNDERATTACK );

			SSOverlayMods_AddAVTimer( resourceName, faction );
		end
	
	-- AV/AB messages
	elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" or event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then
		local faction;
		
		if( event == "CHAT_MSG_BG_SYSTEM_HORDE" ) then
			faction = SS_HORDE;
		elseif( event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then
			faction = SS_ALLIANCE;
		end
		
		if( currentBGName == SS_ALTERACVALLEY ) then
			if( string.find( arg1, SS_AV_CLAIMS ) ) then
				local _, _, resourceName = string.find( arg1, SS_AV_CLAIMS );
				
				SSOverlay_RemoveByText( resourceName );
				SSOverlayMods_AddAVTimer( resourceName, faction );
			end

		elseif( currentBGName == SS_ARATHIBASIN ) then
			-- Node taken, either 60 seconds have elapsed or it was taken back
			if( string.find( arg1, SS_AB_TAKEN ) ) then	
				local _, _, resourceName = string.find( arg1, SS_AB_TAKEN );
				
				SSOverlay_RemoveByText( resourceName );
				
			-- Node assaulted, start the 60 second count down
			elseif( string.find( arg1, SS_AB_ASSAULTED ) ) then
				local _, _, resourceName = string.find( arg1, SS_AB_ASSAULTED );
			
				SSOverlayMods_AddABTimer( resourceName, faction );

			-- Node claimed, this can only start during the begging of a match
			elseif( string.find( arg1, SS_AB_CLAIMS ) ) then
				local _, _, resourceName = string.find( arg1, SS_AB_CLAIMS );
				
				SSOverlayMods_AddABTimer( resourceName, faction );
			end
		end

	
	elseif( event == "UPDATE_BATTLEFIELD_STATUS" and SSOverlay_Config.enabled ) then
		local queuedBGs = MAX_BATTLEFIELD_QUEUES;
		
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, map, id = GetBattlefieldStatus( i );

			if( status == "active" and i ~= currentBG ) then
				SSOverlayMods_UnInit_Queue();
				SSOverlayMods_UnInit_AV();
				SSOverlayMods_UnInit_AB();

				if( map == SS_ALTERACVALLEY and SSOverlay_Config.AV ) then
					SSOverlayMods_Init_AV();

				elseif( map == SS_ARATHIBASIN and SSOverlay_Config.AB ) then
					SSOverlayMods_Init_AB();
				end
				
				currentBG = i;
				currentBGName = map;
				
			elseif( ( status == "queued" or status == "none" ) and i == currentBG ) then
				SSOverlayMods_UnInit_AV();
				SSOverlayMods_UnInit_AB();
				
				currentBG = -1;
				currentBGName = "";
			end
			
			if( status == "active" ) then
				queuedBGs = queuedBGs - 1;
			end
		end
		
		if( SSOverlay_Config.queue ) then
			if( MAX_BATTLEFIELD_QUEUES == queuedBGs and not queueEnabled ) then
				SSOverlayMods_Init_Queue();

			elseif( MAX_BATTLEFIELD_QUEUES == queuedBGs and queueEnabled ) then
				SSOverlayMods_UpdateQueue();
			end
		end
	end
end

function SSOverlayMods_GetFactionColor( faction )
	if( faction == SS_HORDE or faction == "Horde" ) then
		return ChatTypeInfo["BG_SYSTEM_HORDE"];
	elseif( faction == SS_ALLIANCE or faction == "Alliance" ) then
		return ChatTypeInfo["BG_SYSTEM_ALLIANCE"];
	end
	
	return ChatTypeInfo["BG_SYSTEM_NEUTRAL"];
end

-- ALTERAC VALLEY OVERLAY
function SSOverlayMods_Init_AV()
	if( AVEnabled ) then
		return;
	end

	SSOverlay_AddCategory( "av" );
	AVEnabled = true;
end

function SSOverlayMods_UnInit_AV()
	SSOverlay_RemoveByCategory( "av" );
	AVEnabled = false;
end

function SSOverlayMods_AddAVTimer( text, faction, secondsLeft )
	if( AVEnabled ) then
		SSOverlay_AddTimer( text, ( secondsLeft or 300 ), "av", timerFormat, SSOverlayMods_GetFactionColor( faction ) );
	end
end

-- ARATHI BASIN OVERLAY
function SSOverlayMods_Init_AB()
	if( ABEnabled ) then
		return;
	end

	SSOverlay_AddCategory( "ab" );
	ABEnabled = true;
end

function SSOverlayMods_UnInit_AB()
	SSOverlay_RemoveByCategory( "ab" );
	ABEnabled = false;
end

function SSOverlayMods_AddABTimer( text, faction, secondsLeft )
	if( ABEnabled ) then
		if( GetLocale() == "enUS" and string.len( text ) > 1 ) then
			text = string.upper( string.sub( text, 0, 1 ) ) .. string.sub( text, 2 );
		end
		
		SSOverlay_AddTimer( text, ( secondsLeft or 60 ), "ab", timerFormat, SSOverlayMods_GetFactionColor( faction ) );
	end
end

-- BATTLEFIELD QUEUE STATUS OVERLAY
function SSOverlayMods_Init_Queue()	
	if( queueEnabled ) then
		return;
	end
	
	queueEnabled = true;

	SSOverlay_AddCategory( "queue" );
	SSOverlay_AddText( SSO_QUEUED, "queue" );
	SSOverlayMods_UpdateQueue();
end

function SSOverlayMods_UnInit_Queue()	
	SSOverlay_RemoveByCategory( "queue" );
	queueEnabled = false;
end

-- Need to clean this up later
function SSOverlayMods_UpdateQueue()
	if( not queueEnabled ) then
		return;
	end
	
	if( addActiveText ) then
		SSOverlay_AddText( SSO_QUEUED, "queue" );
		addActiveText = false;
	end
	
	local activeQueues = {};
	local totalQueues = 0;
	
	for i=1, MAX_BATTLEFIELD_QUEUES do
		local status, map = GetBattlefieldStatus( i );
		
		if( status == "queued" or status == "confirm" ) then
			activeQueues[ map ] = true;
			queueDisplaying[ map ] = true;
			totalQueues = totalQueues + 1;

		end
		
		if( status == "queued" ) then
			SSOverlay_UpdateElapsed( map .. ":", ( GetBattlefieldTimeWaited( i ) / 1000 ), "queue" );	
		
		elseif( status == "confirm" ) then
			
			SSOverlay_RemoveByText( map );
			if( SSPVP_Config.join.enabled ) then
				local timeout = 120 - ( GetBattlefieldPortExpiration( i ) / 1000 );
				if( timeout >= SSPVP_Config.join.timeout ) then
					timeout = 0;
				else
					timeout = SSPVP_Config.join.timeout - timeout;
				end
				
				SSOverlay_AddTimer( SSO_JOINING .. " " .. map .. ":", timeout, "queue" );
			else
				SSOverlay_AddText( map .. ":" .. SSO_JOINDISABLED, "queue" );
			end
		end
	end
	
	if( totalQueues == 0 ) then
		SSOverlay_RemoveByCategory( "queue" );
		addActiveText = true;
	end
	
	-- Check for whats being displayed vs whats active
	for map in queueDisplaying do 
		if( activeQueues[ map ] == nil ) then
			SSOverlay_RemoveByText( map );
		end
	end
end