local categories = {};
local totalCategories = 1;

local maximumRows = 20;

local timeElapsed = 0;

local activeTimers = {};
local totalActiveTimers = { total = 0, item = 0, up = 0, down = 0, text = 0 };

function SSOverlay_OnLoad()
	this:RegisterEvent( "ADDON_LOADED" );
	this:RegisterEvent( "BAG_UPDATE" );
end

function SSOverlay_OnEvent( event )
	if( event == "ADDON_LOADED" and arg1 == "SSOverlay" ) then
		if( SSOverlay_Config.position ) then
			SSOverlay:ClearAllPoints();
			SSOverlay:SetPoint( "TOPLEFT", "UIParent", "BOTTOMLEFT", SSOverlay_Config.position.x, SSOverlay_Config.position.y );
			SSOverlay:SetUserPlaced( true );
		else
			SSOverlay:SetPoint( "TOPLEFT", "UIParent", "TOPLEFT", 200, -100 );
		end

	elseif( event == "BAG_UPDATE" and totalActiveTimers.item > 0 ) then
		for id, row in activeTimers do
			if( row.type == "item" ) then
				row.count = SSPVP_CountItem( row.itemName );
				activeTimers[id] = row;	
			end
		end
		
		SSOverlay_Resize();
		SSOverlay_UpdateRows();
	end
end

-- Stopped moving the overlay, update the position
function SSOverlay_SavePosition()
	if( SSOverlay:IsUserPlaced() ) then
		if( not SSOverlay_Config.position ) then
			SSOverlay_Config.position = {};
		end
		
		SSOverlay_Config.position.x, SSOverlay_Config.position.y = SSOverlay:GetLeft(), SSOverlay:GetTop();
		SSOverlay:SetUserPlaced( true );
	else
		SSOverlay_Config.position = nil;		
	end
end

-- Config for the overlay was updated, check if we need to init anything
function SSOverlay_ReloadOverlay()
	if( SSOverlay_Config.enabled ) then
		local _, _, currentBGName = SSPVP_PlayerInBG();
					
		if( SSOverlay_Config.AV and currentBGName == SS_ALTERACVALLEY ) then
			SSOverlayMods_Init_AV();
			
			-- The overlay clears all timers when uninit, so we check the ones from SSPVP and use those ( if any )
			for id, row in SSPVP_GetAVTimers() do
				local seconds = row[2] - ( GetTime() - row[5] );
				SSOverlayMods_AddAVTimer( row[1], row[3], seconds );
			end
		else
			SSOverlayMods_UnInit_AV();
		end

		if( SSOverlay_Config.AB and currentBGName == SS_ARATHIBASIN ) then
			SSOverlayMods_Init_AB();
			
			for id, row in SSPVP_GetABTimers() do
				local seconds = row[2] - ( GetTime() - row[4] );
				SSOverlayMods_AddABTimer( row[1], row[3], seconds );
			end
		else
			SSOverlayMods_UnInit_AB();
		end

		if( SSOverlay_Config.queue and currentBGName == nil ) then
			SSOverlayMods_Init_Queue();
		else
			SSOverlayMods_UnInit_Queue();
		end
	else
		SSOverlayMods_UnInit_AV();
		SSOverlayMods_UnInit_AB();
		SSOverlayMods_UnInit_Queue();
	end
end

function SSOverlay_UpdateOverlay()
	SSOverlay:SetBackdropColor( SSOverlay_Config.color.r, SSOverlay_Config.color.g, SSOverlay_Config.color.b );
	SSOverlay:SetBackdropBorderColor( SSOverlay_Config.border.r, SSOverlay_Config.border.g, SSOverlay_Config.border.b );	

	SSOverlay:SetBackdropColor( SSOverlay_Config.color.r, SSOverlay_Config.color.g, SSOverlay_Config.color.b, SSOverlay_Config.opacity );
	SSOverlay:SetBackdropBorderColor( SSOverlay_Config.border.r, SSOverlay_Config.border.g, SSOverlay_Config.border.b, SSOverlay_Config.opacity );

	SSOverlay_UpdateRows();
end

-- Help messages!
function SSOverlay_HelpMessage()
	SSPVP_Message( SSO_HELP_MOD, ChatTypeInfo["SYSTEM"] );
	SSPVP_Message( SSO_HELP_UI, ChatTypeInfo["SYSTEM"] );
	SSPVP_Message( SSO_HELP, ChatTypeInfo["SYSTEM"] );
end

-- Slash handler
function SSOverlay_HandleSlashes( msg ) 
	if( msg == "on" ) then
		SSPVP_Message( SSO_CMD_ON, ChatTypeInfo["SYSTEM"] );
		SSOverlay_Config.enabled = true;
	
	elseif( msg == "off" ) then
		SSPVP_Message( SSO_CMD_OFF, ChatTypeInfo["SYSTEM"] );
		SSOverlay_Config.enabled = false;
	
	elseif( msg == "show" ) then
		SSUI_Open_Config();
		SSUI_OpenTab( "SSOverlayConfig" );
		
	elseif( msg == "hide" ) then
		SSUI_Close_Config();
	else
		SSOverlay_HelpMessage();
	end
end

-- This makes it easier when attempting to use categories
-- So we don't have to pass/remember the number
function SSOverlay_AddCategory( name )
	if( categories[ name] == nil ) then
		categories[ name ] = totalCategories;
		totalCategories = totalCategories + 1;
	end
end

-- Search
function SSOverlay_SearchRow( text, type, category )
	for id, row in activeTimers do
		if( row.text == text and ( category == nil or row.category == categories[ category ] ) and row.type == type ) then
			return id, row;
		end
	end
	
	return nil, {};
end

-- Updating rows
function SSOverlay_UpdateTimer( text, secondsLeft, category, format, textColor )
	local id, data = SSOverlay_SearchRow( text, "down", category );
	
	textColor = ( textColor or data.color );
	format = ( format or data.format );
	data.lastUpdate = ( data.lastUpdate or GetTime() );
	
	SSOverlay_UpdateRow( id, { text = text, secondsLeft = secondsLeft, lastUpdate = data.lastUpdate, category = categories[ category ], format = format, type = "down", color = textColor } );	
end

function SSOverlay_UpdateElapsed( text, elapsed, category, format, textColor )
	local id, data = SSOverlay_SearchRow( text, "up", category );
	
	textColor = ( textColor or data.color );
	format = ( format or data.format );
	data.lastUpdate = ( data.lastUpdate or GetTime() );
	
	SSOverlay_UpdateRow( id, { text = text, elapsed = elapsed, lastUpdate = data.lastUpdate, type = "up", category = categories[ category ], color = textColor, format = format } );	
end

function SSOverlay_UpdateItem( text, itemName, category, format, textColor )
	local id, data = SSOverlay_SearchRow( text, "item", category );
	
	textColor = ( textColor or data.color );
	format = ( format or data.format );
	
	SSOverlay_UpdateRow( id, { text = text, count = SSPVP_CountItem( itemName ), itemName = itemName, category = categories[ category ], color = textColor, format = format, type = "item" } );	
end

function SSOverlay_UpdateText( oldText, newText, category, textColor )
	local id, data = SSOverlay_SearchRow( oldText, "text", category );
	textColor = ( textColor or data.color );
	
	SSOverlay_UpdateRow( id, { text = newText, category = categories[ category ], type = "text", color = textColor } );
end

function SSOverlay_UpdateRow( id, args )
	if( id == nil or activeTimers[ id ] == nil ) then
		SSOverlay_AddRow( args );
	else
		activeTimers[ id ] = args;

		SSOverlay_UpdateRows();
		SSOverlay_Resize();
	end
end

-- Adding a row
function SSOverlay_AddTimer( text, secondsLeft, category, format, textColor )
	SSOverlay_AddRow( { text = text, secondsLeft = secondsLeft, lastUpdate = GetTime(), category = categories[ category ], format = format, type = "down", color = textColor } );
end

function SSOverlay_AddElapsed( text, elapsedStart, category, format, textColor )
	SSOverlay_AddRow( { text = text, elapsed = elapsedStart, lastUpdate = GetTime(), type = "up", category = categories[ category ], color = textColor, format = format } );
end

function SSOverlay_AddItem( text, itemName, category, format, textColor )
	SSOverlay_AddRow( { text = text, count = SSPVP_CountItem( itemName ), itemName = itemName, category = categories[ category ], color = textColor, format = format, type = "item" } );
end

-- I'll change this isn't category later on, and make sorting also work around that
function SSOverlay_AddText( text, category, textColor )
	SSOverlay_AddRow( { text = text, category = categories[ category ], color = textColor, type = "text" } );
end

function SSOverlay_AddRow( args )
	table.insert( activeTimers, args );
	
	totalActiveTimers.total = totalActiveTimers.total + 1;
	totalActiveTimers[ args.type ] = totalActiveTimers[ args.type ] + 1;
	
	SSOverlay_SortAll();
	SSOverlay_UpdateRows();
	SSOverlay_Resize();
	SSOverlay_Show();
end

-- Remove anything that matches the passed text
function SSOverlay_RemoveByText( text )
	local removeList = {};
	
	text = string.lower( text );
	
	for id, row in activeTimers do
		if( string.find( string.lower( row.text ), text ) ) then
			totalActiveTimers.total = totalActiveTimers.total - 1;
			totalActiveTimers[ row.type ] = totalActiveTimers[ row.type ] - 1;
			
			table.insert( removeList, id );
		end
	end	
	
	for _, id in removeList do
		table.remove( activeTimers, id );
	end
	
	SSOverlay_UpdateRows();
	SSOverlay_Resize();
	
	if( totalActiveTimers.total <= 0 ) then
		SSOverlay_Hide();
	end
end

-- Removes everything inside a specific category
function SSOverlay_RemoveByCategory( category )	
	local removeList = {};
	for id, row in activeTimers do
		if( row.category == categories[ category ] ) then
			totalActiveTimers.total = totalActiveTimers.total - 1;
			totalActiveTimers[ row.type ] = totalActiveTimers[ row.type ] - 1;
			
			table.insert( removeList, id );
		end
	end	
	
	for _,id in removeList do
		table.remove( activeTimers, id );
	end
	
	SSOverlay_UpdateRows();
	SSOverlay_Resize();
	
	if( totalActiveTimers.total <= 0 ) then
		SSOverlay_Hide();
	end
end

-- If comment is needed for this, stop reading
function SSOverlay_RemoveAll()
	
	activeTimers = {};
	totalActiveTimers = { total = 0, down = 0, up = 0, item = 0, text = 0 };	

	for i=1, maximumRows do
		getglobal( "SSOverlayRow" .. i ):SetText( "" );
	end
	
	SSOverlay_Hide();
end

-- This only deals with rows
function SSOverlay_Resize()
	if( totalActiveTimers.total == 0 ) then
		return;
	end
	
	local timerHeight = 0;
	local timerWidth = 0;
	local overlayWidth = SSOverlay:GetWidth();
	
	if( totalActiveTimers.total > maximumRows ) then
		timerHeight = ( getglobal( "SSOverlayRow1" ):GetHeight() + 2 ) * maximumRows;
	else
		timerHeight = ( getglobal( "SSOverlayRow1" ):GetHeight() + 2 ) * totalActiveTimers.total;
	end
	
	for i = 1, maximumRows do
		local width = getglobal( "SSOverlayRow" .. i ):GetWidth();
		if( width > timerWidth ) then
			timerWidth = width;
		end
	
	end
	
	timerWidth = timerWidth + 20;
	
	-- Don't adjust width if it's only changed by 1
	if( ( timerWidth - 1 ) <= overlayWidth and ( timerWidth + 1 ) >= overlayWidth ) then
		SSOverlay:SetHeight( timerHeight + 12 );
		return;
	end
	
	SSOverlay:SetWidth( timerWidth );
	SSOverlay:SetHeight( timerHeight + 12 );
end

-- Show/Hide overlay
function SSOverlay_Show()
	SSOverlay_UpdateOverlay();
	SSOverlay:Show();
end

function SSOverlay_Hide()
	SSOverlay:Hide();
end

function SSOverlay_UpdateRows()
	-- Clear everything to remove any "ghost" timers
	for i=1, maximumRows do
		if( getglobal( "SSOverlayRow" .. i ) ) then
			getglobal( "SSOverlayRow" .. i ):SetText( "" );
		end
	end
	
	totalActiveTimers = { total = 0, down = 0, up = 0, item = 0, text = 0 };
	local currentTime = GetTime();
	
	-- Re-add all of the timers
	for id, row in activeTimers do
		totalActiveTimers.total = totalActiveTimers.total + 1;
		totalActiveTimers[ row.type ] = totalActiveTimers[ row.type ] + 1;
		
		if( id <= maximumRows ) then
			local timerRow = getglobal( "SSOverlayRow" .. id );

			if( timerRow ) then
				-- Set the color
				if( row.color == nil ) then
					timerRow:SetTextColor( SSOverlay_Config.text.r, SSOverlay_Config.text.g, SSOverlay_Config.text.b, SSOverlay_Config.textOpacity );
				else
					timerRow:SetTextColor( row.color.r, row.color.g, row.color.b, SSOverlay_Config.textOpacity );
				end
				
				if( row.type == "down" ) then
					row.secondsLeft = row.secondsLeft - ( currentTime - row.lastUpdate );
				elseif( row.type == "up" ) then
					row.elapsed = row.elapsed + ( currentTime - row.lastUpdate )
				end

				-- Add the text
				timerRow:SetText( SSOverlay_FormatText( row ) );
			end
		end
	end
end

function SSOverlay_FormatText( data )
	local text = "";

	if( data.format == nil or data.format == "" ) then
		text = data.text;
		
		if( data.type == "down" ) then
			text = text .. " " .. SecondsToTime( data.secondsLeft );
		elseif( data.type == "up" ) then
			text = text .. " " .. SecondsToTime( data.elapsed );
		elseif( data.type == "item" ) then
			text = text .. " " .. row.count;
		end
	else
		if( data.type == "down" ) then
			text = string.format( data.format, data.text, SecondsToTime( data.secondsLeft ) );
		elseif( data.type == "up" ) then
			text = string.format( data.format, data.text, SecondsToTime( data.elapsed ) );
		elseif( data.type == "item" ) then
			text = string.format( data.format, data.text, data.count );
		elseif( data.type == "text" ) then
			text = string.format( data.format, data.text );
		end
	end
	
	return text;
end


-- Sorts all active timers
function SSOverlay_SortAll()
	activeTimers = SSOverlay_SortList( activeTimers, false );
	SSOverlay_UpdateRows();
end

-- Text > Categories > Counting up timers > Counting down timers > item count timers
function SSOverlay_SortList( sortList, disableSort )
	if( sortList == nil ) then
		return nil;
	end
	
	local countDown = {};
	local countUp = {};
	local itemCount = {};
	local categoryTimers = {};
	
	local sortedTimers = {};
	
	for id, row in sortList do
		if( row.category == nil or disableSort ) then
			if( row.type == "down" ) then
				table.insert( countDown, row );		
			elseif( row.type == "up" ) then
				table.insert( countUp, row );
			elseif( row.type == "item" ) then
				table.insert( itemCount, row );
			elseif( row.type == "text" ) then
				table.insert( sortedTimers, row );
			end
		else	
			if( categoryTimers[ row.category ] == nil ) then
				categoryTimers[ row.category ] = {};
			end
			table.insert( categoryTimers[ row.category ], row );
		end
	end
	
	for cat in categoryTimers do
		for id, row in SSOverlay_SortList( categoryTimers[ cat ], true ) do
			table.insert( sortedTimers, row );
		end
	end
	
	for id, row in countUp do
		table.insert( sortedTimers, row );
	end
	
	for id, row in countDown do
		table.insert( sortedTimers, row );
	end
	
	for id, row in itemCount do
		table.insert( sortedTimers, row );
	end

	return sortedTimers;
end

-- Updates the count down
function SSOverlay_OnUpdate( elapsed )
	timeElapsed = timeElapsed + elapsed;
	
	if( timeElapsed > 0.5 and ( totalActiveTimers.up > 0 or totalActiveTimers.down > 0 ) ) then
		timeElapsed = timeElapsed - 0.5;
		local currentTime = GetTime();
		local removeList = {};
		local timersRemoved = true;
		
		for id, row in activeTimers do
			if( id > maximumRows ) then
				break;
			end
			
			-- Timer is counting down
			if( row.type == "down" ) then
				row.secondsLeft = row.secondsLeft - ( currentTime - row.lastUpdate );
				row.lastUpdate = currentTime;
			
				if( row.secondsLeft > 0 ) then
					getglobal( "SSOverlayRow" .. id ):SetText( SSOverlay_FormatText( row ) );
					activeTimers[id] = row;
				else
					table.insert( removeList, id );
					timersRemoved = true;
				end

			-- Timer is counting up
			elseif( row.type == "up" ) then
				row.elapsed = row.elapsed + ( currentTime - row.lastUpdate )
				row.lastUpdate = currentTime;

				activeTimers[id] = row;

				getglobal( "SSOverlayRow" .. id ):SetText( SSOverlay_FormatText( row ) );
				
				if( mod( ceil( row.elapsed ), 15 ) == 0 ) then
					SSOverlay_Resize();
				end
			end
		end

		if( timersRemoved ) then
			for id in removeList do
				table.remove( activeTimers, id );
			end

			SSOverlay_UpdateRows();
			SSOverlay_Resize();
			
			if( totalActiveTimers.total == 0 ) then
				SSOverlay_Hide();
			end
		end
	end
end