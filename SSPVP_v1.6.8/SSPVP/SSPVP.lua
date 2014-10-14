--[[
	SSPVP By Shadowd of Icecrown PvE (US)
	Original Release: January 22th, 2006.
]]

local currentBG = -1;
local currentBGName = "";

local queuedToJoin = -1;
local queuedToLeave = -1;

local isAFK = false;
local wasAFK = false;

local PlayerFaction = "";

local friendlyFlag = "";
local enemyFlag = "";

local timeElapsed = 0;
local ScheduledEvents = {};

local soundPlayed = {};
local alreadyQueuedMaps = {};

local AVResourceStatus = {};
local ABResourceStatus = {};

local acceptInvite = nil;

local Orig_AcceptBattlefieldPort = nil;
local Orig_ChatFrame_OnEvent = nil;
local Orig_SendChatMessage = nil;
local Orig_UIErrorsFrame_OnEvent = nil;

local autoGroupQueue = false;
local autoSoloQueue = false;

local scoreCallback = nil;
local scoreCallbackArg = nil;

local blockUnknownUnit = false;

function SSPVP_OnLoad()
	this:RegisterEvent( "VARIABLES_LOADED" );

	this:RegisterEvent( "PLAYER_DEAD" );
	this:RegisterEvent( "PLAYER_ENTERING_WORLD" );
	this:RegisterEvent( "PLAYER_LEAVING_WORLD" );
	
	this:RegisterEvent( "UPDATE_BATTLEFIELD_STATUS" );
	this:RegisterEvent( "UPDATE_BATTLEFIELD_SCORE" );
		
	this:RegisterEvent( "GOSSIP_SHOW" );
	
	this:RegisterEvent( "PARTY_INVITE_REQUEST" );
		
	this:RegisterEvent( "CHAT_MSG_SYSTEM" );	
	this:RegisterEvent( "CHAT_MSG_MONSTER_YELL" );	
	this:RegisterEvent( "CHAT_MSG_BG_SYSTEM_HORDE" );
	this:RegisterEvent( "CHAT_MSG_BG_SYSTEM_ALLIANCE" );
	this:RegisterEvent( "CHAT_MSG_COMBAT_HOSTILE_DEATH" );
	
	this:RegisterEvent( "BATTLEFIELDS_SHOW" );
			
	-- SSPVP
	SLASH_SSPVPMAIN1 = "/sspvp";
	SlashCmdList["SSPVPMAIN"] = SSConfig_HandleSlashes;

	-- SSOverlay
	SLASH_SSOVERLAY1 = "/ssoverlay";
	SlashCmdList["SSOVERLAY"] = SSPVP_Overlay_LoadAddon;
	
	-- Target enemy flag
	SLASH_ETARFLAG1 = "/tarflag";
	SLASH_ETARFLAG2 = "/htarflag";
	SLASH_ETARFLAG3 = "/etarflag";
	SlashCmdList["ETARFLAG"] = SSPVP_TargetEnemyFlag;
	
	-- Target friendly flag
	SLASH_FTARFLAG1 = "/ftarflag";
	SlashCmdList["FTARFLAG"] = SSPVP_TargetFriendlyFlag;
	
	-- Arathi Basin timers
	SLASH_ABTIMERS1 = "/abtimers";
	SlashCmdList["ABTIMERS"] = SSPVP_PrintABTimers;
	
	-- Alterac Valley timers
	SLASH_AVTIMERS1 = "/avtimers";
	SlashCmdList["AVTIMERS"] = SSPVP_PrintAVTimers;
	
	-- Print AV timers to chat
	SLASH_PRINTAV1 = "/printav";
	SlashCmdList["PRINTAV"] = SSPVP_PrintAVTimersToChat;

	-- PVP Who
	SLASH_PVPWHO1 = "/pwho";
	SlashCmdList["PVPWHO"] = SSPVP_PVPWho;
end 

function SSPVP_Message( msg, color )
	if( color == nil ) then
		color = { r = 1, g = 1, b = 1 };
	end
	
	DEFAULT_CHAT_FRAME:AddMessage( msg, color.r, color.g, color.b );
end

-- Joining/Leaving a channel
function SSPVP_JoinChannel( name ) 
	ChatFrame_AddChannel( DEFAULT_CHAT_FRAME, name );
	
	JoinChannelByName( name );
end

function SSPVP_LeaveChannel( name )
	ChatFrame_RemoveChannel( DEFAULT_CHAT_FRAME, name );

	LeaveChannelByName( name );
end

function SSPVP_PlayerInBG()
	for i=1, MAX_BATTLEFIELD_QUEUES do
		status, map, id = GetBattlefieldStatus( i );
		if ( status == "active" ) then
			return true, i, map;
		end
	end

	return false, nil, nil;
end

function SSPVP_GetABTimers()
	return ABResourceStatus;
end

function SSPVP_GetAVTimers()
	return AVResourceStatus;
end

-- Are we in an instance
function SSPVP_PlayerInInstance()
	local inInstance = IsInInstance();
	local currentZone = GetRealZoneText();
	
	for _, zoneName in SS_NOT_ANINSTANCE do
		if( currentZone == zoneName ) then
			inInstance = nil;
		end
	end
	
	return inInstance;
end

-- Adds a "are you sure you want to leave battleground queue" message
function SSPVP_AcceptBattlefieldPort( index, accept, ignoreConfirm )
	
	if( ignoreConfirm == nil and accept == nil ) then
		local _, map = GetBattlefieldStatus( index );
		
		local dialog = StaticPopup_Show("CONFIRM_BATTLEFIELD_LEAVE", map, "", index );
		if( dialog ) then
			dialog.data = index;
		end
	else
		if( ignoreConfirm and accept == nil ) then
			StaticPopup_Hide( "CONFIRM_BATTLEFIELD_ENTRY", index );
		end
		
		Orig_AcceptBattlefieldPort( index, accept );
	end
end

--[[function SSPVP_Test()
	BattlefieldMinimap_LoadUI();
	BattlefieldMinimap:Show();
	
	BattlefieldMinimap:SetResizable( true );
	BattlefieldMinimap:EnableMouse( true );
	BattlefieldMinimap:SetScript( "OnSizeChanged", SSPVP_Dragging );
	
	BattlefieldMinimapResizeBottomRight:ClearAllPoints();
	BattlefieldMinimapResizeBottomRight:SetPoint( "BOTTOMRIGHT", "BattlefieldMinimap", "BOTTOMRIGHT" );
	BattlefieldMinimapResizeBottomRight:Show();	
end

function SSPVP_Dragging()
	BattlefieldMinimapBackground:ClearAllPoints();
	BattlefieldMinimapBackground:SetPoint( "TOPLEFT", "BattlefieldMinimapTab", "BOTTOMLEFT", 0, 12 );
	
	BattlefieldMinimapBackground:SetWidth( ( BattlefieldMinimap:GetWidth()/4 ) * 12 );
	BattlefieldMinimapBackground:GetHeight( BattlefieldMinimap:GetHeight() );
end]]

-- I need to fix this up somepoint
function SSPVP_CountItem( item )
	local totalBags = 4;
	local currentBag = totalBags;
	
	local totalCount = 0;
	local foundName = nil;
	
	while currentBag >= 0 do
		local currentSlot = GetContainerNumSlots( currentBag );
		
		while currentSlot > 0 do
			_, itemCount = GetContainerItemInfo( currentBag, currentSlot );
			itemName = GetContainerItemLink( currentBag, currentSlot );

			if( itemCount ) then
				SSPVPItem:SetBagItem( currentBag, currentSlot );
				
				local itemText = getglobal( "SSPVPItemTooltipTextLeft1" );
				if( itemText and itemText:GetText() ~= nil ) then
					itemName = itext:GetText();
				end
				
				if( itemName and string.find( itemName, item, 1, true ) ) then
					totalCount = totalCount + itemCount;
					foundName = itemName;
				end
			end
			
			currentSlot = currentSlot - 1;
		end
		
		currentBag = currentBag - 1;
	end
	
	return totalCount, foundName;
end

-- Event scheduling
function SSPVP_QueueEvent( functionName, timeDelay, eventName )
	table.insert( ScheduledEvents, { functionName, GetTime() + timeDelay, eventName } );
end

function SSPVP_UnQueueEvent( functionName, eventName )
	for id, row in ScheduledEvents do
		if( row[1] == functionName ) then
			if( ( eventName == nil ) or ( eventName ~= nil and eventName == row[3] ) ) then
				table.remove( ScheduledEvents, id );
			end
		end
	end
end

function SSPVP_QueueExists( functionName, eventName )
	for id, row in ScheduledEvents do
		if( row[1] == functionName ) then
			if( ( eventName == nil ) or ( eventName ~= nil and eventName == row[3] ) ) then
				return true;
			end
		end
	end
	
	return false;
end

function SSPVP_OnUpdate( elapsed )
	timeElapsed = elapsed + timeElapsed;
	
	if( timeElapsed > 0.1 ) then
		timeElapsed = timeElapsed - 0.1;
		local currentTime = GetTime();
		
		for id, row in ScheduledEvents do
			
			if( row[2] <= currentTime) then
				table.remove( ScheduledEvents, id );

				if( type( row[1] ) == "function" ) then
					row[1]( row[3] );
				else
					getglobal( row[1] )( row[3] );
				end
			end
		end
	end
end

function SecondsToTimeFull( seconds, noSeconds )
	local time = SecondsToTime( seconds, noSeconds );
	time = string.gsub( string.gsub( time, MINUTES_ABBR, SS_MINUTES ), SECONDS_ABBR, SS_SECONDS );
	
	return time;
end

-- Really only meant for times under <10 minutes, returns a format like 05:00
function SecondsToTimeBuffFormat( seconds )
	local minutes = floor( seconds / 60 );
	local seconds = floor( mod( seconds, 60 ) );
	
	-- I'll fix this later
	if( minutes < 10 ) then
		minutes = "0" .. minutes;
	end
	if( seconds < 10 ) then
		seconds = "0" .. seconds;
	end
	
	return minutes .. ":" .. seconds;
end

-- Colorised messages!
function SSPVP_PVPMessage( message, faction )
	if( faction == SS_ALLIANCE or faction == "Alliance" ) then
		SSPVP_Message( message, ChatTypeInfo["BG_SYSTEM_ALLIANCE"] );		
	elseif( faction == SS_HORDE or faction == "Horde" ) then
		SSPVP_Message( message, ChatTypeInfo["BG_SYSTEM_HORDE"] );	
	else
		SSPVP_Message( message, ChatTypeInfo["BG_SYSTEM_NEUTRAL"] );	
	end
end

-- PVP Who
function SSPVP_ClassBreakDown()
	local searchClasses = {};
	
	for i=1, GetNumBattlefieldScores() do
		local _, _, _, _, _, faction, _, _, class = GetBattlefieldScore( i );

		if( ( faction == 0 and PlayerFaction == "Alliance" ) or ( faction ~= 0 and PlayerFaction == "Horde" ) ) then
			searchClasses[ class ] = ( searchClasses[ class ] or 0 ) + 1;
		end
	end
	
	for class, total in searchClasses do
		SSPVP_Message( string.format( SS_SEARCH_CLASSROW, class, total ), ChatTypeInfo["SYSTEM"] );
	end	
end

function SSPVP_SearchBG( searchFor )
	local resultsFound = 0;
	local requiredMatchs = 0;
	local searchResults = {};
	
	for id, row in searchFor do
		requiredMatchs = requiredMatchs + 1;
	end
	
	if( requiredMatchs == 0 ) then
		return;
	end
	
	for i=1, GetNumBattlefieldScores() do
		local name, _, _, _, _, faction, rank, race, class = GetBattlefieldScore( i );
		local resultsMatched = 0;
		
		if( ( faction == 0 and PlayerFaction == "Alliance" ) or ( faction ~= 0 and PlayerFaction == "Horde" ) ) then
			if( searchFor["n"] ~= nil and string.find( string.lower( name ), searchFor["n"] ) ) then
				resultsMatched = resultsMatched + 1;	
			end
			if( searchFor["ra"] ~= nil and searchFor["ra"] >= rank ) then
				resultsMatched = resultsMatched + 1;
			end
			if( searchFor["c"] ~= nil and string.find( string.lower( class ), searchFor["c"] ) ) then
				resultsMatched = resultsMatched + 1;
			end
			if( searchFor["r"] ~= nil and string.find( string.lower( race ), searchFor["r"] ) ) then
				resultsMatched = resultsMatched + 1;
			end

			if( resultsMatched >= requiredMatchs and requiredMatchs ~= 0 ) then
				resultsFound = resultsFound + 1;
				rank = GetPVPRankInfo( rank, faction );
				
				-- If we have no rank then nil is returned, which makes string.format complain!
				if( rank == nil ) then
					rank = SS_NO_RANK;
				end
				
				table.insert( searchResults, { name, rank, race, class } );
			end
		end
	end
	
	for _, row in searchResults do
		SSPVP_Message( string.format( SS_SEARCH_ROW, row[1], row[2], row[3], row[4] ), ChatTypeInfo["SYSTEM"] );
	end	
	
	SSPVP_Message( string.format( SS_SEARCH_RESULTS, resultsFound ), ChatTypeInfo["SYSTEM"] );
end

function SSPVP_PVPWho( msg )
	if( msg == "" ) then
		SSPVP_Message( SS_SEARCH_HELP, ChatTypeInfo["SYSTEM"] );
		SSPVP_Message( SS_SEARCH_HELP_CLASSLIST, ChatTypeInfo["SYSTEM"] );
		SSPVP_Message( SS_SEARCH_HELP_NAME, ChatTypeInfo["SYSTEM"] );
		SSPVP_Message( SS_SEARCH_HELP_RANK, ChatTypeInfo["SYSTEM"] );
		SSPVP_Message( SS_SEARCH_HELP_CLASS, ChatTypeInfo["SYSTEM"] );
		SSPVP_Message( SS_SEARCH_HELP_RACE, ChatTypeInfo["SYSTEM"] );
		return;
	end
	
	if( currentBG == -1 ) then
		SSPVP_Message( SS_SEARCH_NOBG, ChatTypeInfo["SYSTEM"] );
		return;
	end
	
	local searchFor = {};
	local searchsMatched = false;
	
	for key, value in string.gfind( msg, "([a-zA-Z]+)\-\"([^\"]+)\"" ) do
		searchFor[ string.lower( key ) ] = string.lower( value );
		searchsMatched = true;
	end
		
	-- Figure out if we're suppose to do a class breakdown
	if( msg == SS_SEARCH_CLASSES ) then
		SSPVP_RequestScoreData( SSPVP_ClassBreakDown, nil );
		return;
	end
	
	-- Will change this to act closer to what /who does
	if( searchsMatched == false ) then
		searchFor = { n = msg };
	end
	
	if( searchFor["ra"] ~= nil ) then
		searchFor["ra"] = tonumber( searchFor["ra"] );
	end
		
	
	SSPVP_RequestScoreData( SSPVP_SearchBG, searchFor );
end

function SSPVP_RequestScoreData( callBack, callBackArg )
	if( WorldStateScoreFrame:IsVisible() ) then
		callBack( callBackArg );
	else
		scoreCallback = callBack;
		scoreCallbackArg = callBackArg;
		
		RequestBattlefieldScoreData();
		SSPVP_QueueEvent( "SSPVP_OnEvent", 2, "UPDATE_BATTLEFIELD_SCORE" );
	end
end

-- Display all the AB timers
function SSPVP_PrintABTimers()
	if( getn( ABResourceStatus ) == 0 ) then
		SSPVP_PVPMessage( SS_NO_TIMERS );
	end
	
	for id, row in ABResourceStatus do
		SSPVP_PVPMessage( string.format( SS_AB_ALLTIMERS, row[1], SecondsToTimeBuffFormat( row[2] + ( row[4] - GetTime() ) ) ), row[3] );
	end
end

-- Monitoring AB timers
function SSPVP_ABTimer( name )
	local resourceID, resource;
	
	for id, row in ABResourceStatus do
		
		if( row[1] == name ) then
			resourceID = id;
			resource = row;
			break;
		end
	end
	
	if( resourceID == nil or resource == nil ) then
		return;
	end
		
	-- subtract time until it's taken
	resource[2] = resource[2] - SSPVP_Config.AB.interval;
	if( resource[2] <= 0 ) then
		table.remove( ABResourceStatus, resourceID );
		return;
	end
	
	ABResourceStatus[ resourceID ] = { resource[1], resource[2], resource[3], GetTime() };
	
	
	SSPVP_PVPMessage( string.format( SS_AB_STATUS, resource[1], resource[3], SecondsToTimeFull( resource[2] ) ), resource[3] );
	SSPVP_UnQueueEvent( SSPVP_ABTimer, resource[1] );
	SSPVP_QueueEvent( SSPVP_ABTimer, SSPVP_Config.AB.interval, resource[1] );
end

-- Display all the AV timers
function SSPVP_PrintAVTimersToChat( msg )
	
	if( msg == nil or msg == "" ) then
		SSPVP_Message( SS_PRINTAV_HELP, ChatTypeInfo["SYSTEM"] );
		return;
	elseif( getn( AVResourceStatus ) == 0 ) then
		SSPVP_Message( SS_NO_TIMERS, ChatTypeInfo["SYSTEM"] );
		return;
	end
	
	local chatType, channel;
	local text = "";
	local chatText = "";
	local textList = {};
	
	msg = string.lower( msg );
	
	if( msg == "raid" or msg == "r" ) then
		chatType = "RAID";
		
	elseif( msg == "party" or msg == "p" ) then
		chatType = "PARTY";
		
	elseif( msg == "guild" or msg == "g" ) then
		chatType = "GUILD";
	
	elseif( GetChannelName( msg ) > 0 ) then
		channel = GetChannelName( msg );
		chatType = "CHANNEL";
	end
	
	for _, row in AVResourceStatus do
		if( row[4] == SS_CAPTURE ) then
			row[4] = SS_CAPTURED;
		elseif( row[4] == SS_DESTROY ) then
			row[4] = SS_DESTROYED;
		end
	
		text = string.format( SS_AV_CHATTIMERS, row[1], row[4], SecondsToTimeBuffFormat( row[2] + ( row[5] - GetTime() ) ) );
				
		if( string.len( chatText ) >= 255 ) then
			table.insert( textList,  string.sub( chatText, 4 ) );
			
			chatText = "";
		else
			chatText = chatText .. " / " .. text;
		end
	end
	
	for _, text in textList do
		SendChatMessage( text, chatType, nil, channel );
	end
	
	SendChatMessage( string.sub( chatText, 4 ), chatType, nil, channel );
end

function SSPVP_PrintAVTimers()
	if( getn( AVResourceStatus ) == 0 ) then
		SSPVP_PVPMessage( SS_NO_TIMERS );
	end

	for id, row in AVResourceStatus do
		if( row[4] == SS_CAPTURE ) then
			row[4] = SS_CAPTURED;
		elseif( row[4] == SS_DESTROY ) then
			row[4] = SS_DESTROYED;
		end
		
		SSPVP_PVPMessage( string.format( SS_AV_CHATTIMERS, row[1], row[4], SecondsToTimeBuffFormat( row[2] + ( row[5] - GetTime() ) ) ), row[3] );
	end
end

-- For monitoring AV timers
function SSPVP_AVTimer( name )
	local resource, resourceID;

	for id, row in AVResourceStatus do
		
		if( row[1] == name ) then
			resource = row;
			resourceID = id;
			break;
		end
	end
	
	if( not resourceID or not resource ) then
		return;
	end
	
	-- subtract time until capture/destory
	resource[2] = resource[2] - SSPVP_Config.AV.interval;
	if( resource[2] <= 0 ) then
		table.remove( AVResourceStatus, resourceID );
		return;
	end
	
	AVResourceStatus[ resourceID ] = { resource[1], resource[2], resource[3], resource[4], GetTime() };

	SSPVP_PVPMessage( string.format( SS_AV_STATUS, resource[1], resource[4], resource[3], SecondsToTimeFull( resource[2] ) ), resource[3] );
	SSPVP_UnQueueEvent( SSPVP_AVTimer, resource[1] );
	SSPVP_QueueEvent( SSPVP_AVTimer, SSPVP_Config.AV.interval, resource[1] );
end

-- Binding status
function SSPVP_Enable_SoloQueue()
	autoSoloQueue = true;
	autoGroupQueue = false;
	
	-- SSPVP_Message( SS_AUTOQ_SOLO, ChatTypeInfo["SYSTEM"] );
end

function SSPVP_Enable_GroupQueue()
	autoGroupQueue = true;
	autoSoloQueue = false;

	-- SSPVP_Message( SS_AUTOQ_GROUP, ChatTypeInfo["SYSTEM"] );
end

function SSPVP_Disable_SoloQueue()
	autoGroupQueue = false;
	autoSoloQueue = false;

	-- SSPVP_Message( SS_AUTOQ_DISSOLO, ChatTypeInfo["SYSTEM"] );
end

function SSPVP_Disable_GroupQueue()
	autoGroupQueue = false;
	autoSoloQueue = false;

	-- SSPVP_Message( SS_AUTOQ_DISGROUP, ChatTypeInfo["SYSTEM"] );
end

-- For loading SSInvite/SSOverlay through the slash commands
function SSPVP_Overlay_LoadAddon( msg )
	-- Debug( "Overlay loaded for cmd" );
	UIParentLoadAddOn( "SSOverlay" );
	if( SSOverlay_HandleSlashes ~= nil ) then
		SSOverlay_HandleSlashes( msg )
	end
end

-- Hook everything we need
function SSPVP_Load_Hooks()
	-- Add confirmation for leaving battleground queue
	Orig_AcceptBattlefieldPort = AcceptBattlefieldPort;
	AcceptBattlefieldPort = SSPVP_AcceptBattlefieldPort;
	
	-- Hook the send message for the $efc/$ffc variables
	Orig_SendChatMessage = SendChatMessage;
	SendChatMessage = SSPVP_SendChatMessage;

	-- ChatFrame
	Orig_ChatFrame_OnEvent = ChatFrame_OnEvent;
	ChatFrame_OnEvent = SSPVP_ChatFrame_OnEvent;
	
	-- UI Error Frame
	Orig_UIErrorsFrame_OnEvent = UIErrorsFrame_OnEvent;
	UIErrorsFrame_OnEvent = SSPVP_UIErrorsFrame_OnEvent;
	
end

-- Kills the herald stuff
function SSPVP_ChatFrame_OnEvent( event )
	if( event == "CHAT_MSG_MONSTER_YELL" and arg2 == SS_HERALD and SSPVP_Config.AV.enabled ) then
		return;	
	end
		
	Orig_ChatFrame_OnEvent( event );
end

--[[function SSPVP_Load()
	for _, row in SSPVP_Config.test do
		SSPVP_Test( row[1], row[2] );
	end
end

function SSPVP_Test( event, arg1 )
	Debug( arg1 );
		
	if( event == "CHAT_MSG_MONSTER_YELL" ) then
		local faction, eventType;
		
		-- Alliance messages
		if( string.find( arg1, SS_ALLIANCE ) ) then
			faction = SS_ALLIANCE;

		-- Horde messages
		elseif( string.find( arg1, SS_HORDE ) ) then
			faction = SS_HORDE;
		end
		
		Debug( event );
		Debug( "FACTION: " .. ( faction or "nil" ) );
		
		-- Is it a resource taken event?
		if( string.find( arg1, SS_AV_TAKEN ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_TAKEN );
			
			for id, row in AVResourceStatus do
				if( row[1] == resourceName ) then
					Debug( "Removed [" .. resourceName .. "]" );
					table.remove( AVResourceStatus, id );
				end
			end

			return;
		elseif( string.find( arg1, SS_AV_DESTROYED ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_DESTROYED );
			
			for id, row in AVResourceStatus do
				if( row[1] == resourceName ) then
					Debug( "Removed [" .. resourceName .. "]" );
					table.remove( AVResourceStatus, id );
				end
			end
			
			return;
		end
		
		-- Alright it isn't, is it a destroy or capture message?
		if( string.find( arg1, SS_DESTROY ) ) then
			eventType = SS_DESTROYED;
		elseif( string.find( arg1, SS_CAPTURE ) ) then
			eventType = SS_CAPTURED;
		else
			return;
		end
		
		local _, _, resourceName = string.find( arg1, SS_AV_UNDERATTACK );
		
		Debug( "Type " .. ( eventType or "nil" ) );
		Debug( "Name [" .. ( resourceName or "nil" ) .. "]" );
		
		if( resourceName ~= "" ) then
			table.insert( AVResourceStatus, { resourceName, ( 60 * 5 ), faction, eventType, GetTime() } ); 
			SSPVP_QueueEvent( SSPVP_AVTimer, SSPVP_Config.AV.interval, resourceName );
		end
		
	-- WSG and AB messages
	elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" or event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then	
		local factionMessage = nil;
		if( event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then
			factionMessage = SS_ALLIANCE;
		elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" ) then
			factionMessage = SS_HORDE;
		end
		
		Debug( "Faction " .. ( factionMessage or "nil" ) );

		if( string.find( arg1, SS_AV_CLAIMS ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_CLAIMS );
			
			Debug( "Name [" .. resourceName .. "]" );
			
			table.insert( AVResourceStatus, { resourceName, ( 60 * 5 ), factionMessage, SS_CAPTURED, GetTime() } );
			SSPVP_QueueEvent( SSPVP_AVTimer, SSPVP_Config.AV.interval, resourceName );
		end
	end
end]]

-- For the horde/alliance flag carrier names in the UI
function SSPVP_UpdateFlagUI()
	if( not SSPVP_Config.general.flagUI or currentBGName ~= SS_WARSONGGULCH ) then
		SSPVPWorldFlag:Hide();
		return;
	end
	
	SSPVPWorldFlag:Show();
	
	--[[local enemyClass = "";
	local friendlyClass = "";
	
	if( BGPlayerList[ enemyFlag ] ~= nil ) then
		enemyClass = "  [" .. ( BGPlayerList[ enemyFlag ].class or "--" ) .. "]";
	end

	if( BGPlayerList[ friendlyFlag ] ~= nil ) then
		friendlyClass = "  [" .. ( BGPlayerList[ friendlyFlag ].class or "--" ) .. "]";
	end]]
		
	if( PlayerFaction == "Horde" ) then
		SSPVPWorldFlagHordeText:SetText( enemyFlag );
		SSPVPWorldFlagAllianceText:SetText( friendlyFlag );
		
		if( enemyFlag == nil or enemyFlag == "" ) then
			SSPVPWorldFlagHorde:Hide();
		else
			SSPVPWorldFlagHorde:Show();
		end

		if( friendlyFlag == nil or friendlyFlag == "" ) then
			SSPVPWorldFlagAlliance:Hide();
		else
			SSPVPWorldFlagAlliance:Show();
		end

	elseif( PlayerFaction == "Alliance" ) then
		SSPVPWorldFlagAllianceText:SetText( enemyFlag  );
		SSPVPWorldFlagHordeText:SetText( friendlyFlag );
		
		if( enemyFlag == nil or enemyFlag == "" ) then
			SSPVPWorldFlagAlliance:Hide();
		else
			SSPVPWorldFlagAlliance:Show();
		end

		if( friendlyFlag == nil or friendlyFlag == "" ) then
			SSPVPWorldFlagHorde:Hide();
		else
			SSPVPWorldFlagHorde:Show();
		end
	end
	
end

function SSPVP_UnLoadFlagUI()
	SSPVPWorldFlag:Hide();

	SSPVPWorldFlagHordeText:SetText( "" );
	SSPVPWorldFlagAllianceText:SetText( "" );

	SSPVPWorldFlagHorde:Hide();
	SSPVPWorldFlagAlliance:Hide();
end

-- Kills the unknown unit errors when doing /tarflag
function SSPVP_UIErrorsFrame_OnEvent( event, message )
	if( blockUnknownUnit and event == "UI_ERROR_MESSAGE" and message == SS_UNKNOWN_UNIT ) then
		return;
	end
	
	Orig_UIErrorsFrame_OnEvent( event, message );
end

-- Targetting flag carriers
function SSPVP_TargetHordeFlag()
	if( PlayerFaction == SS_HORDE ) then
		SSPVP_TargetEnemyFlag();
	else
		SSPVP_TargetFriendlyFlag();
	end
end

function SSPVP_TargetAllianceFlag()
	if( PlayerFaction == SS_ALLIANCE ) then
		SSPVP_TargetEnemyFlag();
	else
		SSPVP_TargetFriendlyFlag();
	end
end


function SSPVP_TargetEnemyFlag( msg )
	if( msg ~= nil and msg ~= "" ) then
		enemyFlag = msg;
		SSPVP_Message( string.format( SS_FLAG_SETTO, SS_ENEMY, msg ), ChatTypeInfo["SYSTEM"] );
		
		SSPVP_UpdateFlagUI();
	end
	
	SSPVP_TargetFlag( enemyFlag );
end

function SSPVP_TargetFriendlyFlag( msg )
	if( msg ~= nil and msg ~= "" ) then
		friendlyFlag = msg;
		SSPVP_Message( string.format( SS_FLAG_SETTO, SS_FRIENDLY, msg ), ChatTypeInfo["SYSTEM"] );
		
		SSPVP_UpdateFlagUI();

	elseif( friendlyFlag == nil ) then
		friendlyFlag = SSPVP_GetFriendlyCarrier();
		SSPVP_UpdateFlagUI();
	end
	
	SSPVP_TargetFlag( friendlyFlag );
end

function SSPVP_TargetFlag( flagTarget )
	
	if( flagTarget ~= nil and flagTarget ~= "" ) then
		local oldTarget = UnitName( "target" );
		blockUnknownUnit = true;
		
		TargetByName( flagTarget );
	
		if( string.lower( ( UnitName( "target" ) or "" ) ) ~= string.lower( flagTarget ) ) then
			if( oldTarget == nil ) then
				ClearTarget();
			else
				TargetByName( oldTarget );
			end
			
			UIErrorsFrame:AddMessage( string.format( SS_TARGET_FLAGOOR, flagTarget ), 1.0, 0.1, 0.1, 1.0 );
		end
		
		blockUnknownUnit = false;
	else
		UIErrorsFrame:AddMessage( SS_NOBODY_HASFLAG, 1.0, 0.1, 0.1, 1.0 );
	end
end

function SSPVP_GetFriendlyCarrier()
	playerPositions = {};
	
	-- Figure out how many people in the raid are in the battleground
	local playerCount = 0;
	if ( GetNumRaidMembers() > 0 ) then
		for i=1, MAX_RAID_MEMBERS do
			local partyX, partyY = GetPlayerMapPosition( "raid" .. i );
			if ( ( partyX ~= 0 or partyY ~= 0 ) and not UnitIsUnit( "raid" .. i, "player" ) ) then
				playerCount = playerCount + 1;		
			end
		end
	end

	-- Now add all of the peoples position to a list	
	local numTeamMembers = GetNumBattlefieldPositions();
	for i=playerCount+1, MAX_RAID_MEMBERS do
		partyX, partyY, name = GetBattlefieldPosition( i - playerCount );
		if ( partyX ~= 0 and partyY ~= 0 ) then
			table.insert( playerPositions, { partyX, partyY, name } );
		end
	end
	
	-- Now get the position of the flag and check our list of positions
	local numFlags = GetNumBattlefieldFlagPositions();
	for i=1, NUM_WORLDMAP_FLAGS do
		if ( i <= numFlags ) then
			local flagX, flagY = GetBattlefieldFlagPosition( i );
			if( flagX ~= 0 and flagY ~= 0 ) then
				for id, row in playerPositions do
					if( row[1] == flagX and row[2] == flagY ) then
						return row[3];
					end
				end
			end
		end
	end
	
	return nil;
end

-- I'm sure theres a better way to do this, i'll have to check it out later
function SSPVP_SendChatMessage( msg, type, language, target )
	if( friendlyFlag ~= "" and string.find( msg, SS_FFC_TAG ) ) then
		
		if( friendlyFlag ~= "" ) then
			msg = string.gsub( msg, SS_FFC_TAG, friendlyFlag );
		else
			msg = string.gsub( msg, SS_FFC_TAG, SS_NO_FFC );
		end
	elseif( enemyFlag ~= "" and string.find( msg, SS_EFC_TAG ) ) then
	
		if( enemyFlag ~= "" ) then
			msg = string.gsub( msg, SS_EFC_TAG, enemyFlag );
		else
			msg = string.gsub( msg, SS_EFC_TAG, SS_NO_EFC );
		end
	end
	
	Orig_SendChatMessage( msg, type, language, target );
end

-- Where all the magic goes on
function SSPVP_OnEvent( event )
	
	-- Makes it a bit cleaner so we don't have to do this on EVERY event
	if( SSPVP_Config ~= nil and SSPVP_Config.general ~= nil  and not SSPVP_Config.general.enabled ) then
		if( event ~= "JOIN_BATTLEFIELD" and event ~= "VARIABLES_LOADED" ) then
			return;
		end
	end
		
	if( event == "VARIABLES_LOADED" ) then
		
		-- Check the config, will also handle loading in new settings.
		SSConfig_Check_Config();
		
		-- Check if the variable version has changed, incase we need to upgrade
		if( SSPVP_Config.varVersion ~= SSPVPVersion ) then
			-- Will have to update this when we get to 1.10
			if( SSPVP_Config.varVersion ~= nil ) then
				SSConfig_Upgrade_Config( string.sub( SSPVP_Config.varVersion, 0, 3 ) );
			end
			
			SSConfig_Check_Config();
		end

		if( SSPVP_Config.general.enabled ) then
			SSPVP_Message( string.format( SS_MAIN_STATUS, SSPVPVersion, GREEN_FONT_COLOR_CODE .. SS_LOADED .. FONT_COLOR_CODE_CLOSE ) );
		else
			SSPVP_Message( string.format( SS_MAIN_STATUS, SSPVPVersion, RED_FONT_COLOR_CODE .. SS_DISABLED .. FONT_COLOR_CODE_CLOSE ) );
		end
		
		
		SSUI_LoadStaticPopups();
		SSPVP_Load_Hooks();
		
		SSPVP_Config.varVersion = SSPVPVersion;
	
		-- UIPanelWindows["SSOptions"] = { area = "center", pushable = 0, whileDead = 1 };
		table.insert( UISpecialFrames, "SSOptions" );

	elseif( event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" and currentBG ~= -1 and SSPVP_Config.general.kb ) then
		if( IsAddOnLoaded( "sct" ) and string.find( arg1, SS_YOU_SLAIN ) ) then
			SCT_Display( SS_KILLING_BLOW, SSPVP_Config.general.kbColor, 1 );
		end

--[[	elseif( event == "UPDATE_BATTLEFIELD_SCORE" ) then
		BGPlayerList = {};
		for i=1, GetNumBattlefieldScores() do
			local name, _, _, _, _, faction, rank, race, class = GetBattlefieldScore( i );
			table.insert( BGPlayerList, { name = name, faction = faction, rank = rank, class = class, race = race } );
		end

		if( not SSPVP_QueueExists( "RequestBattlefieldScoreData" ) ) then
			SSPVP_QueueEvent( "RequestBattlefieldScoreData", 45 );
		end
		
		
		SSPVP_UpdateFlagUI();
]]
	elseif( event == "UPDATE_BATTLEFIELD_SCORE" and scoreCallback ~= nil ) then
		local func = scoreCallback;
		local arg = scoreCallbackArg;
		
		scoreCallback = nil;
		scoreCallbackArg = nil;
		
		func( arg );		
	
	-- AV Messages
	-- Need to clean this up later
	elseif( event == "CHAT_MSG_MONSTER_YELL" and arg2 == SS_HERALD and SSPVP_Config.AV.enabled ) then
		local faction, eventType;
		
		-- Alliance messages
		if( string.find( arg1, SS_ALLIANCE ) ) then
			faction = SS_ALLIANCE;

		-- Horde messages
		elseif( string.find( arg1, SS_HORDE ) ) then
			faction = SS_HORDE;
		end
		
		-- Send the PVP message out by in the regular view
		SSPVP_PVPMessage( arg1, faction );
		
		-- Hacky, need to fix later
		if( faction == SS_ALLIANCE and SSPVP_Config.AV.alliance ) then
		elseif( faction == SS_HORDE and SSPVP_Config.AV.horde ) then
		else
			return;
		end
		
		-- Is it a resource taken/destroyed event?
		if( string.find( arg1, SS_AV_TAKEN ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_TAKEN );
			
			for id, row in AVResourceStatus do
				if( row[1] == resourceName ) then
					table.remove( AVResourceStatus, id );
				end
			end
			return;
		elseif( string.find( arg1, SS_AV_DESTROYED ) ) then
			local _, _, resourceName = string.find( arg1, SS_AV_DESTROYED );
			
			for id, row in AVResourceStatus do
				if( row[1] == resourceName ) then
					table.remove( AVResourceStatus, id );
				end
			end
			
			return;
		end
		
		-- Alright it isn't, is it a destroying or capturing message?
		if( string.find( arg1, SS_DESTROY ) ) then
			eventType = SS_DESTROYED;
		elseif( string.find( arg1, SS_CAPTURE ) ) then
			eventType = SS_CAPTURED;
		else
			return;
		end
		
		local _, _, resourceName = string.find( arg1, SS_AV_UNDERATTACK );
		
		if( resourceName ~= "" ) then
			table.insert( AVResourceStatus, { resourceName, ( 60 * 5 ), faction, eventType, GetTime() } ); 
			SSPVP_QueueEvent( SSPVP_AVTimer, SSPVP_Config.AV.interval, resourceName );
		end
		
	-- WSG and AB messages
	elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" or event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then	
		local factionMessage = nil;
		if( event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" ) then
			factionMessage = SS_ALLIANCE;
		elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" ) then
			factionMessage = SS_HORDE;
		end

		if( currentBGName == SS_WARSONGGULCH ) then
			
			local pickedUp, dropped, captured, flagType, flagtarget;

			if( string.find( arg1, SS_ALLIANCE ) ) then			
				pickedUp = string.format( SS_WSG_PICKEDUP, SS_ALLIANCE );
				dropped = string.format( SS_WSG_DROPPED, SS_ALLIANCE );
				captured = string.format( SS_WSG_CAPTURED, SS_ALLIANCE );
				
				flagType = SS_ALLIANCE;
				
			elseif( string.find( arg1, SS_HORDE ) ) then
				pickedUp = string.format( SS_WSG_PICKEDUP, SS_HORDE );
				dropped = string.format( SS_WSG_DROPPED, SS_HORDE );
				captured = string.format( SS_WSG_CAPTURED, SS_HORDE );
				
				flagType = SS_HORDE;
			else
				return;
			end 
		
			if( string.find( arg1, pickedUp ) ) then
				_, _, flagTarget = string.find( arg1, pickedUp );

			elseif( string.find( arg1, captured ) or string.find( arg1, dropped ) ) then
				flagTarget = "";
			end
			
			flagTarget = ( flagTarget or "" );
			
			if( flagType == PlayerFaction ) then
				enemyFlag = flagTarget;
			else
				friendlyFlag = flagTarget;
			end
			
			SSPVP_UpdateFlagUI();
		elseif( currentBGName == SS_ARATHIBASIN ) then
			
			if( not SSPVP_Config.AB.enabled or factionMessage == nil ) then
				return;
			elseif( event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" and not SSPVP_Config.AB.alliance ) then
				return;
			elseif( event == "CHAT_MSG_BG_SYSTEM_HORDE" and not SSPVP_Config.AB.horde ) then
				return;
			end
			
			if( string.find( arg1, SS_AB_TAKEN ) ) then	
				local _, _, resourceName = string.find( arg1, SS_AB_TAKEN );
				for id, row in ABResourceStatus do

					if( row[1] == resourceName ) then
						table.remove( ABResourceStatus, id );
					end
				end
			
			elseif( string.find( arg1, SS_AB_ASSAULTED ) ) then
				local _, _, resourceName = string.find( arg1, SS_AB_ASSAULTED );

				table.insert( ABResourceStatus, { resourceName, 60, factionMessage, GetTime() } );
				SSPVP_QueueEvent( SSPVP_ABTimer, SSPVP_Config.AB.interval, resourceName );

			elseif( string.find( arg1, SS_AB_CLAIMS ) ) then
				local _, _, resourceName = string.find( arg1, SS_AB_CLAIMS );

				table.insert( ABResourceStatus, { resourceName, 60, factionMessage, GetTime() } );
				SSPVP_QueueEvent( SSPVP_ABTimer, SSPVP_Config.AB.interval, resourceName );
			end
		
		-- We can only claim a graveyard and can only do this at the start of AV.
		elseif( currentBGName == SS_ALTERACVALLEY ) then
			
			if( string.find( arg1, SS_AV_CLAIMS ) ) then
				local _, _, resourceName = string.find( arg1, SS_AV_CLAIMS );
				
				table.insert( AVResourceStatus, { resourceName, ( 60 * 5 ), factionMessage, SS_CAPTURED, GetTime() } );
				SSPVP_QueueEvent( SSPVP_AVTimer, SSPVP_Config.AV.interval, resourceName );
			end
		end
				
	-- Need to clean this up later
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		PlayerFaction = UnitFactionGroup( "player" );

		local inBG, bgID, bgName = SSPVP_PlayerInBG();
				
		if( inBG ) then
			
			if( SSPVP_Config.general.openMinimap ) then
				BattlefieldMinimap_LoadUI();
				SSPVP_QueueEvent( SSPVP_OnEvent, 1, "OPEN_MINIMAP" );
			end

			SSPVP_QueueEvent( "SSPVP_OnEvent", 1, "JOIN_CHANNELS" );
			
			if( SSOverlay_Config.enabled ) then
				if( bgName == SS_ALTERACVALLEY and SSOverlay_Config.AV ) then
					-- Debug( "Overlay loaded for AV" );
					UIParentLoadAddOn( "SSOverlay" );
				elseif( bgName == SS_ARATHIBASIN and SSOverlay_Config.AB ) then
					-- Debug( "Overlay loaded for AB" );
					UIParentLoadAddOn( "SSOverlay" );
				end
			end
		else
			if( getn( SSPVP_Config.activeChannels ) > 0 ) then			
				for id, name in SSPVP_Config.activeChannels do
					SSPVP_LeaveChannel( name );
				end

				SSPVP_Config.activeChannels = {};			
			end
		end	
		
		if( lockInvites ) then
			lockInvites = false;
			SSPVP_QueueEvent( SSPVP_OnEvent, 0.1, "ACCEPT_INVITE" );
		end
	
	elseif( event == "JOIN_CHANNELS" ) then
		if( getn( SSPVP_Config.channelNames ) > 0 ) then
			SSPVP_Config.activeChannels = {};

			for id, name in SSPVP_Config.channelNames do
				SSPVP_JoinChannel( name );

				table.insert( SSPVP_Config.activeChannels, name );
			end
		end
	
	elseif( event == "ACCEPT_INVITE" ) then
	
		if( acceptInvite ~= nil ) then
			SSPVP_Message( string.format( SS_ACCEPTING_INVITE, acceptInvite ), ChatTypeInfo["SYSTEM"] );

			AcceptGroup();
			StaticPopup_Hide( "PARTY_INVITE" );					
		end

		acceptInvite = nil;
	
	elseif( event == "PLAYER_LEAVING_WORLD" ) then
		lockInvites = true;
		
		if( SSPVP_Config.general.openMinimap and BattlefieldMinimap ~= nil ) then
			if( BattlefieldMinimap:IsVisible() ) then
				BattlefieldMinimap:Hide();
			end
		end
		
		if( getn( SSPVP_Config.activeChannels ) > 0 ) then

			for id, name in SSPVP_Config.activeChannels do
				SSPVP_LeaveChannel( name );
			end
			
			SSPVP_Config.activeChannels = {};
		end
			
	-- Actually opens the mini map
	elseif( event == "OPEN_MINIMAP" ) then
		if( BattlefieldMinimap ~= nil ) then
			if( MiniMapBattlefieldFrame.status == "active" ) then
				BattlefieldMinimap:Show();
			end

			-- Figure out who's the friendly flag carrier ( if any )
			friendlyFlag = SSPVP_GetFriendlyCarrier();
			SSPVP_UpdateFlagUI();
		end
		
	-- Auto accept invite
	elseif( event == "PARTY_INVITE_REQUEST" ) then
		
		-- Search our player list
		for id, name in SSPVP_Config.playerNames do	
			if( name == arg1 ) then
				acceptInvite = arg1;
			end
		end

		-- Search the battleground names
		if( SSPVP_Config.ainvite.battleground and not acceptInvite ) then
			for i=1, GetNumBattlefieldScores() do
				-- If hell freezes over, and you can invite cross faction, i'll update this to check faction
				if( GetBattlefieldScore( i ) == arg1 ) then
				acceptInvite = arg1;
				end
			end
		end
		
		-- Search friends list
		if( SSPVP_Config.ainvite.friends and not acceptInvite ) then
			for i=1, GetNumFriends() do
				friendsName = GetFriendInfo( i );
				
				if( friendsName == arg1 ) then
				acceptInvite = arg1;
				end
			end				
		end
		
		if( acceptInvite and not lockInvites ) then
			SSPVP_QueueEvent( SSPVP_OnEvent, 0.1, "ACCEPT_INVITE" );
		end
	
	-- Auto queue
	elseif( event == "BATTLEFIELDS_SHOW" and SSPVP_Config.queue.enabled ) then
		
		if( autoGroupQueue and IsPartyLeader() ) then
			JoinBattlefield( 0, 1 );
			HideUIPanel( BattlefieldFrame );
			
			SSPVP_Message( SS_AUTOQUEUE_GROUP, ChatTypeInfo["SYSTEM"] );
		
		elseif( autoGroupQueue and not IsPartyLeader() ) then
			SSPVP_Message( SS_AUTOQUEUE_NOTLEADER, ChatTypeInfo["SYSTEM"] );		
		
		elseif( autoSoloQueue ) then
			JoinBattlefield( 0 );
			HideUIPanel( BattlefieldFrame );

			SSPVP_Message( SS_AUTOQUEUE_SOLO, ChatTypeInfo["SYSTEM"] );
		end
	
	-- Gossip!
	elseif( event == "GOSSIP_SHOW" and SSPVP_Config.general.skipGossip ) then
		local gossipButton = getglobal( "GossipTitleButton1");
		
		-- Battleground mark turn in
		if( UnitName( "target" ) == SS_HORDE_TURNIN or UnitName( "target" ) == SS_ALLIANCE_TURNIN ) then
			
			local WSGMarks = SSPVP_CountItem( SS_MARKITEM_WSG );
			local AVMarks = SSPVP_CountItem( SS_MARKITEM_AV );
			local ABMarks = SSPVP_CountItem( SS_MARKITEM_AB );
			local allMarks = 0;
			
			local gossip = nil;
			local gossipTitle = "";
			local unknownGossipFound = false;
			
			local availableQuests = {};
			
			if( WSGMarks > 2 and ABMarks > 2 and AVMarks > 2 ) then
				-- Figured out what we have the least of
				if( WSGMarks <= ABMarks and WSGMarks <= AVMarks ) then
					allMarks = WSGMarks;	
				elseif( ABMarks <= WSGMarks and ABMarks <= AVMarks ) then
					allMarks = ABMarks;	
				elseif( AVMarks <= WSGMarks and AVMarks <= ABMarks ) then
					allMarks = AVMarks;
				end			
			end
						
			-- Find out what quests we have available to us, and add them to a list
			for i=1, GossipFrame.buttonIndex do
				gossip = getglobal( "GossipTitleButton" .. i );
				gossip:Hide();
				gossipTitle = gossip:GetText();
				
				-- 3/3/3
				if( gossipTitle == SS_MARKS_HALL or gossipTitle == SS_MARKS_AALL ) then
					table.insert( availableQuests, { gossipTitle, allMarks, gossip:GetID() } );
				
				-- Warsong Gulch
				elseif( gossipTitle == SS_MARKS_HWSG or gossipTitle == SS_MARKS_AWSG ) then
					table.insert( availableQuests, { gossipTitle, WSGMarks, gossip:GetID() } );
				
				-- Arathi Basin
				elseif( gossipTitle == SS_MARKS_HAB or gossipTitle == SS_MARKS_AAB ) then
					table.insert( availableQuests, { gossipTitle, ABMarks, gossip:GetID() } );
				
				-- Alterac Valley
				elseif( gossipTitle == SS_MARKS_HAV or gossipTitle == SS_MARKS_AAV ) then
					table.insert( availableQuests, { gossipTitle, AVMarks, gossip:GetID() } );
				
				-- Something changed or is wrong, show anyway
				-- elseif( gossipTitle ~= nil and gossip:GetID() ~= nil ) then
				--	unknownGossipFound = true;
				--	table.insert( availableQuests, { gossipTitle, nil, gossip:GetID(), true } );
				end
			end
			
			-- If we have no marks to turnin with add a message to let them know
			if( not unknownGossipFound and WSGMarks < 3 and ABMarks < 3 and AVMarks < 3 ) then
				GossipGreetingText:SetText( GossipGreetingText:GetText() .. "\n\n" .. SSPVP_NOTENOUGHMARKS );
				
				for i=1, GossipFrame.buttonIndex do
					getglobal( "GossipTitleButton" .. i ):Hide();
				end
				
				return;
			end			
			
			-- Now loop back through and take over the title and ID of the hidden ones.
			local gossipIndex = 1;
			for i, row in availableQuests do
				gossip = getglobal( "GossipTitleButton" .. gossipIndex );
				
				if( row[2] > 2 ) then
					
					gossip:Show();
					gossip:SetID( row[3] );
					
					gossip:SetText( string.format( SS_MARKROW, row[1], row[2] ) );
					gossipIndex = gossipIndex + 1;
				end
			end
			
		elseif( gossipButton:GetText() ~= nil ) then
			if( string.find( gossipButton:GetText(), SS_BG_GOSSIP ) or string.find( gossipButton:GetText(), SS_BG_GOSSIP2 ) ) then
				gossipButton:Click();
			end
		end
			
	-- AFK Check
	elseif( event == "CHAT_MSG_SYSTEM" ) then
		
		if( not SSPVP_Config.join.afk and string.find( arg1, MARKED_AFK ) ) then
			isAFK = true;
			wasAFK = false;
			
			SSPVP_Message( SS_NOW_AFK, ChatTypeInfo["SYSTEM"] );
		elseif( not SSPVP_Config.join.afk and string.find( arg1, CLEARED_AFK ) ) then
			isAFK = false;
			wasAFK = true;
			
			SSPVP_Message( SS_NOLONGER_AFK, ChatTypeInfo["SYSTEM"] );
			
			if( queuedToJoin == -1 )  then
				SSPVP_OnEvent( "UPDATE_BATTLEFIELD_STATUS" );
			end
		end
				
	-- Auto-release to the GY
	elseif( event == "PLAYER_DEAD" ) then
		
		if( currentBG ~= -1 and SSPVP_Config.general.release ) then
			local deathFrame = StaticPopup_FindVisible( "DEATH" );
			
			-- Don't want to auto release if they have a soulstone active!
			if( HasSoulstone() == nil ) then
				getglobal( deathFrame:GetName() .. "Text" ):SetText( SS_RELEASING );
				RepopMe();
			else
				getglobal( deathFrame:GetName() .. "Text" ):SetText( SS_SOULSTONE );
			end
		end
		
	-- Auto-join and Auto-leave of BG
	elseif( event == "UPDATE_BATTLEFIELD_STATUS" ) then
		for i = 1, MAX_BATTLEFIELD_QUEUES do
			local status, map, id = GetBattlefieldStatus( i );
			
			-- Time to enter a BG!
			if ( status == "confirm" and i ~= queuedToJoin ) then
		
				SSConfig_StopSound( true, SSPVP_Config.general.soundFile );
					
				if( string.find( SSPVP_Config.general.soundFile, "mp3" ) and not soundPlayed[ map ] ) then
					soundPlayed[ map ] = true;
					PlayMusic( "Interface\\AddOns\\SSPVP\\" .. SSPVP_Config.general.soundFile );
				
				elseif( SSPVP_Config.general.soundFile ~= "" and not soundPlayed[ map ] ) then
					soundPlayed[ map ] = true;
					PlaySoundFile( "Interface\\AddOns\\SSPVP\\" .. SSPVP_Config.general.soundFile );				
				end
				
				queuedToJoin = i;
				
				local joinTimeout = SSPVP_Config.join.timeout;
				
				if( wasAFK ) then
					-- This makes sure if the queue time remaining is less then our timeout we will auto join with 10 seconds left.
					if( ( GetBattlefieldPortExpiration( i ) / 1000 ) < SSPVP_Config.join.timeout ) then
						joinTimeout = ( GetBattlefieldPortExpiration( i ) / 1000 ) - 10;
					end
					
					wasAFK = false;
				end
												
				SSPVP_QueueEvent( SSPVP_OnEvent, joinTimeout, "JOIN_BATTLEFIELD");			
			
			-- Maybe we typed /console reloadui or we crashed
			elseif( status == "active" and i ~= currentBG ) then
				
				currentBG = i;
				currentBGName = map;
				
			-- Makes sure that if we aren't in a battleground and it says that we are to remove it.
			elseif( ( status == "queued" or status == "none" ) and i == currentBG ) then
				currentBG = -1;
				currentBGName = "";
				
				queuedToLeave = -1;
				queuedToJoin = -1;
				
				ABResourceStatus = {};
				AVResourceStatus = {};
				
				friendlyFlag = "";
				enemyFlag = "";

				SSPVP_UnLoadFlagUI();
			end
									
			if( status == "active" or status == "queued" ) then
				soundPlayed[ map ] = nil;
				alreadyQueuedMaps[ map ] = nil;
			end
		end	
			
		-- Find out if we need to load it for the queue overlay
		if( currentBG == -1 and SSOverlay_Config.enabled and SSOverlay_Config.queue and not IsAddOnLoaded( "SSOverlay" ) ) then
			-- Debug( "Overlay loaded for queue" );
			UIParentLoadAddOn( "SSOverlay" );
			SSOverlayMods_OnEvent( event );
		end

		-- Check if the BG has ended, and make sure we aren't already queued to leave.
		if( SSPVP_Config.leave.enabled and GetBattlefieldWinner() ~= nil and queuedToLeave == -1 ) then
			if( SSPVP_Config.leave.group ) then
				LeaveParty();
			end
			
			queuedToLeave = currentBG;
			SSPVP_QueueEvent( SSPVP_OnEvent, SSPVP_Config.leave.timeout, "LEAVE_BATTLEFIELD" );				
		end
		
	-- Leave battlefield
	elseif( event == "LEAVE_BATTLEFIELD" ) then
		queuedToLeave = -1;
		
		LeaveBattlefield();
	
	-- Join battlefield
	elseif( event == "JOIN_BATTLEFIELD" ) then
		status, bgName, bgID = GetBattlefieldStatus( queuedToJoin );
		
		if( status ~= "confirm" or alreadyQueuedMaps[ bgName ] ) then
			return;
		end
				
		SSConfig_StopSound( true, SSPVP_Config.general.soundFile );
		alreadyQueuedMaps[ bgName ] = true;
		
		if( not SSPVP_Config.join.gathering and CastingBarText:IsVisible() ) then

			-- If we don't have enough time left don't bother checking
			if( ( GetBattlefieldPortExpiration( bgID ) / 1000 ) > 10 ) then			
				
				if( CastingBarText:GetText() == SS_MINING ) then
					SSPVP_Message( SS_CURRENTLY_MINING, ChatTypeInfo["SYSTEM"] );
				elseif( CastingBarText:GetText() == SS_HERBING ) then
					SSPVP_Message( SS_CURRENTLY_HERBING, ChatTypeInfo["SYSTEM"] );
				end

				SSPVP_QueueEvent( SSPVP_OnEvent, 10, "JOIN_BATTLEFIELD" );
				return;
			else
				SSPVP_Message( SS_NOT_ENOUGH_TIME, ChatTypeInfo["SYSTEM"] );
			end
		end
		
		-- We hid the entry window
		if( SSPVP_Config.join.windowHidden and StaticPopup_Visible( "CONFIRM_BATTLEFIELD_ENTRY" ) == nil ) then
			SSPVP_Message( SS_WINDOW_HIDDEN, ChatTypeInfo["SYSTEM"] );
			
		-- Inside an instance
		elseif( SSPVP_PlayerInInstance() and not SSPVP_Config.join.instance ) then
			SSPVP_Message( SS_INSIDE_INSTANCE, ChatTypeInfo["SYSTEM"] );
		
		-- Inside a battleground	
		elseif( SSPVP_PlayerInBG() and not SSPVP_Config.join.bg ) then
			SSPVP_Message( SS_INSIDE_BG, ChatTypeInfo["SYSTEM"] );
		
		-- AFK
		elseif( isAFK and not SSPVP_Config.join.afk ) then
			SSPVP_Message( SS_CURRENTLY_AFK, ChatTypeInfo["SYSTEM"] );
		
		-- Was disabled before we got here
		elseif( not SSPVP_Config.general.enabled or not SSPVP_Config.join.enabled ) then
			SSPVP_Message( SS_DISABLED_QUEUED, ChatTypeInfo["SYSTEM"] );
		
		-- Join!
		else
			currentBGName = bgName;
			currentBG = bgID;
		
			AcceptBattlefieldPort( queuedToJoin, 1 );
			StaticPopup_Hide( "CONFIRM_BATTLEFIELD_ENTRY", queuedToJoin );		
		end
		
		queuedToJoin = -1;
	end


end