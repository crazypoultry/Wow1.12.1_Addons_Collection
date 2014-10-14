-- UI ELEMENTS
local UIElements = {

	-- Check boxes
	["SSFlagUI"] =			{ text = "GENERAL_FLAGUI", var = { "general", "flagUI" }, type = "Check" },
	["SSKillingBlow"] =		{ text = "GENERAL_KILLINGBLOW", var = { "general", "kb" }, type = "Check" },
	["SSAutoRelease"] =		{ text = "GENERAL_RELEASE", var = { "general", "release" }, type = "Check" }, 
	["SSSkipGossip"] =		{ text = "GENERAL_GOSSIP", var = { "general", "skipGossip" }, type = "Check" }, 
	["SSEnabled"] =			{ text = "GENERAL_ENABLE", var = { "general", "enabled" }, type = "Check" }, 
	["SSToggleMinimap"] =		{ text = "GENERAL_MINIMAP", var = { "general", "openMinimap" }, type = "Check" }, 
	
	["SSJoinWindowHidden"] =	{ text = "JOIN_WINDOW", var = { "join", "windowHidden" }, type = "Check" }, 
	["SSJoinInBG"] =		{ text = "JOIN_BG", var = { "join", "bg" }, type = "Check" },
	["SSJoinGathering"] =		{ text = "JOIN_GATHERING", var = { "join", "gathering" }, type = "Check" }, 
	["SSJoinAFK"] =			{ text = "JOIN_AFK", var = { "join", "afk" }, type = "Check" }, 
	["SSEnableAutoJoin"] =		{ text = "JOIN_ENABLE", var = { "join", "enabled" }, type = "Check" }, 
	["SSJoinInInstance"] = 		{ text = "JOIN_INSTANCE", var = { "join", "instance" }, type = "Check" }, 

	["SSEnableAV"] =		{ text = "AV_ENABLE", var = { "AV", "enabled" }, type = "Check" }, 
	["SSAVAllianceTimers"] =	{ text = "AV_ALLIANCE", var = { "AV", "alliance" }, type = "Check" }, 
	["SSAVHordeTimers"] =		{ text = "AV_HORDE", var = { "AV", "horde" }, type = "Check" }, 
	
	["SSEnableAutoLeave"] =		{ text = "LEAVE_ENABLE", var = { "leave", "enabled" }, type = "Check" }, 
	["SSLeaveGroup"] =		{ text = "LEAVE_GROUP", var = { "leave", "group" }, type = "Check" }, 
	
	["SSOverlayQueues"] =		{ text = "OVERLAY_QUEUE", var = { "overlay", "queue" }, type = "Check" }, 
	["SSEnableOverlay"] =		{ text = "OVERLAY_ENABLE", var = { "overlay", "enabled" }, type = "Check" }, 
	["SSOverlayAB"] =		{ text = "OVERLAY_AB", var = { "overlay", "AB" }, type = "Check" }, 
	["SSOverlayAV"] =		{ text = "OVERLAY_AV", var = { "overlay", "AV" }, type = "Check" }, 
	["SSOverlayLocked"] =		{ text = "OVERLAY_LOCK", var = { "overlay", "locked" }, type = "Check" }, 
	
	["SSShowTeammates"] =		{ text = "MAP_TEAM", var = { "map", "showPlayers" }, type = "Check" }, 
	["SSLockMinimap"] =		{ text = "MAP_LOCK", var = { "map", "locked" }, type = "Check" }, 
	
	["SSEnableAB"] =		{ text = "AB_ENABLE", var = { "AB", "enable" }, type = "Check" }, 
	["SSABAlliance"] =		{ text = "AB_ALLIANCE", var = { "AB", "alliance" }, type = "Check" }, 
	["SSABHorde"] =			{ text = "AB_HORDE", var = { "AB", "horde" }, type = "Check" }, 
	
	["SSAcceptFriends"] =		{ text = "INVITE_FRIENDS", var = { "ainvite", "friends" }, type = "Check" }, 
	["SSAcceptBattleground"] =	{ text = "INVITE_BATTLEGROUND", var = { "ainvite", "battleground" }, type = "Check" }, 

	-- Sliders
	["SSOverlayOpacity"] =		{ text = "OPACITY", var = { "overlay", "opacity" }, opacityUpdated = SSOverlay_UpdateOverlay, minValue = 0, maxValue = 1.0, minText = "0_PERCENT", maxText = "100_PERCENT", valueStep = 0.01, type = "Slider" }, 
	["SSOverlayTextOpacity"] =	{ text = "TEXT_OPACITY", var = { "overlay", "textOpacity" }, opacityUpdated = SSOverlay_UpdateOverlay, minValue = 0, maxValue = 1.0, minText = "0_PERCENT", maxText = "100_PERCENT", valueStep = 0.01, type = "Slider" }, 
	--["SSMinimapOpacity"] =		{ text = "OPACITY", var = { "map", "opacity" }, minValue = 0, maxValue = 1.0, minText = "0_PERCENT", maxText = "100_PERCENT", valueStep = 0.01, type = "Slider" }, 
	
	-- Edit boxes
	["SSSoundFile"] =		{ text = "GENERAL_SOUND", var = { "general", "soundFile" }, type = "Input" }, 
	
	["SSAutoJoin"] =		{ text = "JOIN_TIMEOUT", var = { "join", "timeout" }, varType = "int",  textLimit = 3,  type = "Input" }, 
	["SSAutoLeave"] =		{ text = "LEAVE_TIMEOUT", var = { "leave", "timeout" }, varType = "int",  textLimit = 3, type = "Input" }, 
	
	["SSAVInterval"] =		{ text = "INTERVAL", var = { "AV", "interval" }, varType = "int", textLimit = 3, type = "Input" }, 
	["SSABInterval"] =		{ text = "INTERVAL", var = { "AB", "interval" }, varType = "int",  textLimit = 3, type = "Input" }, 
	
	-- Color Boxes
	["SSBorderColor"] =		{ text = "OVERLAY_BORDERCOLOR", var = { "overlay", "border" }, colorUpdated = SSOverlay_UpdateOverlay, type = "Color" },
	["SSBackgroundColor"] =		{ text = "OVERLAY_COLOR", var = { "overlay", "color" }, colorUpdated = SSOverlay_UpdateOverlay,  type = "Color" },
	["SSTextColor"] =		{ text = "OVERLAY_TEXTCOLOR", var = { "overlay", "text" }, colorUpdated = SSOverlay_UpdateOverlay,  type = "Color" },
	["SSKillingBlowColor"] =	{ text = "GENERAL_KILLINGBLOWCOLOR", var = { "general", "kbColor" },  type = "Color" },
	
	-- Tab buttons
	["SSTabAB"] =			{ text = "TAB_AB", frameName = "SSABConfig", type = "Button" },
	["SSTabMap"] =			{ text = "TAB_MINIMAP", frameName = "SSMapConfig", type = "Button" },
	["SSTabAcceptInvite"] =		{ text = "TAB_ACCEPTINVITE", frameName = "SSAcceptInviteConfig", type = "Button" },
	["SSTabGeneral"] =		{ text = "TAB_GENERAL", frameName = "SSGeneralConfig", type = "Button" },
	["SSTabAutoJoin"] =		{ text = "TAB_AUTOJOIN", frameName = "SSAutoJoinConfig", type = "Button" },
	["SSTabAutoLeave"] =		{ text = "TAB_AUTOLEAVE", frameName = "SSAutoLeaveConfig", type = "Button" },
	["SSTabAV"] =			{ text = "TAB_AV", frameName = "SSAVConfig", type = "Button" },
	["SSTabOverlay"] =		{ text = "TAB_OVERLAY", frameName = "SSOverlayConfig", type = "Button" },
	["SSTabInvite"] =		{ text = "TAB_INVITE", frameName = "SSInviteConfig", type = "Button" },
	["SSTabClose"] =		{ text = "CLOSE", frameName = "SSTabClose", type = "Button" },

	-- Buttons
	["SSFixMinimap"] =		{ text = "MAP_RESET", func = "SSConfig_FixMinimap", type = "Button" },
	["SSShowMinimap"] =		{ text = "MAP_TOGGLE", func = "SSConfig_ToggleMinimap", type = "Button" },  

	["SSSoundPlay"] =		{ text = "PLAY", func = "SSConfig_PlaySound", type = "Button" },
	["SSSoundStop"] =		{ text = "STOP", func = "SSConfig_StopSound", type = "Button" },
	
	["SSPlayerAdd"] =		{ text = "ADD", func = "SSUI_PlayerNames_ShowAddWindow", type = "Button" },
	["SSPlayerEdit"] =		{ text = "EDIT", func = "SSUI_PlayerNames_ShowEditWindow", type = "Button" },
	["SSPlayerDelete"] =		{ text = "DEL", func = "SSUI_PlayerNames_DeleteName", type = "Button" },
	
	["SSChannelAdd"] =		{ text = "ADD", func = "SSUI_ChannelNames_ShowAddWindow", type = "Button" },
	["SSChannelEdit"] =		{ text = "EDIT", func = "SSUI_ChannelNames_ShowEditWindow", type = "Button" },
	["SSChannelDelete"] =		{ text = "DEL", func = "SSUI_ChannelNames_DeleteChannel", type = "Button" },
	
	-- DropDowns
	["SSPlayerNames"] =		{ text = "PLAYER_NAMES", table = {}, type = "DropDown" },
	["SSChannelNames"] =		{ text = "CHANNEL_NAMES", table = {}, type = "DropDown" },
};

-- UI shown, load everything
function SSOptions_OnShow()
	-- temp solution, fix later
	BattlefieldMinimap_LoadUI();
	
	for id, info in UIElements do
		local tooltipText, text = nil;
		local varValue = SSConfig_GetValue( info.var );
		
		-- Use the text key for the tooltip key if none is provided
		if( info.tooltip == nil ) then
			tooltipText = getglobal( "SS_UI_" .. info.text .. "_TOOLTIP" );
		else
			tooltipText = getglobal( info.tooltip );			
		end
		
		text = getglobal( "SS_UI_" .. info.text );
		
		if( text == nil ) then
			text = info.text;
		end
		
		if( info.type == "Check" and getglobal( id ) ) then
			checkBox = getglobal( id );
			checkBox.tooltipText = tooltipText;
			
			getglobal( id .. "Text" ):SetText( text );
						
			checkBox:SetChecked( varValue );
		
		elseif( info.type == "Slider" and getglobal( id ) ) then

			slider = getglobal( id );
			slider.tooltipText = tooltipText;
			slider:SetMinMaxValues( info.minValue, info.maxValue );
			slider:SetValueStep( info.valueStep );
			slider:SetValue( varValue );
			
			if( varValue > 0 ) then
				varValue = varValue * 100;
			end
			
			getglobal( id .. "Text" ):SetText( string.format( text, varValue ) );
			
			getglobal( id .. "Low" ):SetText( getglobal( "SS_UI_" .. info.minText ) );
			getglobal( id .. "High" ):SetText( getglobal( "SS_UI_" .. info.maxText ) );
			
		elseif( info.type == "Input" and getglobal( id ) ) then
			
			editBox = getglobal( id );
			editBox.tooltipText = tooltipText;
			editBox:SetMaxLetters( info.textLimit );
			editBox:SetText( varValue );
			
			getglobal( id .. "Text" ):SetText( text );
		
		elseif( info.type == "Color" and getglobal( id ) ) then
			colorSwatch = getglobal( id );
			colorSwatch.tooltipText = tooltipText;
			
			color = SSConfig_GetValue( info.var );
			getglobal( id .. "NormalTexture" ):SetVertexColor( color.r, color.g, color.b );
			getglobal( id .. "Text" ):SetText( text );
		
		elseif( info.type == "Button" and getglobal( id ) ) then
			button = getglobal( id );
			button:SetText( text );
			-- button.func = info.OnClick;
			-- button.tooltipText = tooltipText;
		
		elseif( info.type == "DropDown" and getglobal( id ) ) then
			selected = SSConfig_GetValue( info.var );
			
			-- Can't really have anything selected if you can choose multiple values
			if( selected == nil or info.multi ) then
				selected = 1;
			end
			
			dropdown = getglobal( id );
			dropdown.tooltipText = tooltipText;
			
			UIDropDownMenu_SetSelectedID( dropdown, selected );
			UIDropDownMenu_SetText( info.table[ selected ], dropdown );
			
			getglobal( id .. "Text" ):SetText( text );
		end
	end
end

function SSUI_DropDown_OnClick( id, wasChecked )
	local info = UIDropDownData[ id ];
	
	if( info.multi ) then
		local table = SSConfig_GetValue( info.var );

		if( wasChecked ) then
			table[ this:GetID() ] = nil;
		else
			table[ this:GetID() ] = true;
		end

		SSConfig_SetValue( info.var, table )
	else
		UIDropDownMenu_SetSelectedID( getglobal( id ), this:GetID() );
		SSConfig_SetValue( info.var, this:GetID() );
	end
end

function SSUI_DropDown_Initialize()
	local info = UIElements[ this:GetName() ];
	local button = {};
	local checked = {};
	
	if( info.multi ) then
		for id in SSConfig_GetValue( info.var ) do
			checked[ id ] = 1;
		end
	end
	
	for key, value in info.table do
		button.text = value;
		button.func = SSUI_DropDown_OnClick;
		button.arg1 = this:GetName();
		button.arg2 = checked[ key ];
		button.checked = checked[ key ];
		
		if( info.multi ) then
			button.keepShownOnClick = 1;
		end
		
		UIDropDownMenu_AddButton( button );
	end
end

-- Open the config frame using the tab name
function SSUI_OpenTab( frameName )
	if( frameName == "SSTabClose" ) then
		SSOptions:Hide();
		return;
	end
	
	for id, info in UIElements do
		if( info.type == "Button" and getglobal( info.frameName ) and info.frameName ~= "SSTabClose" ) then
			getglobal( info.frameName ):Hide();
		end
	end
	
	getglobal( frameName ):Show();
end

-- I'll probably extend this later on
function SSUI_Button_OnClick()
	local info = UIElements[ this:GetName() ];
	
	if( info.frameName ) then
		SSUI_OpenTab( info.frameName );
	end
	
	if( type( info.func ) == "function" ) then
		info.func();
	elseif( info.func ~= nil ) then	
		getglobal( info.func )();
	end
end

function SSUI_Editbox_TextChange()
	local info = UIElements[ this:GetName() ];
	local value = this:GetText();
	
	if( info.varType ~= nil ) then
		if( info.varType == "int" ) then
			value = tonumber( value );
		end
	end
	
	SSConfig_SetValue( info.var, value );
end

function SSUI_Slider_OnValueChanged()
	local info = UIElements[ this:GetName() ];
	local textValue = this:GetValue();
	
	if( textValue > 0 ) then
		textValue = textValue * 100;
	end
	
	if( getglobal( "SS_UI_" .. info.text ) ) then
		getglobal( this:GetName() .. "Text" ):SetText( string.format( getglobal( "SS_UI_" .. info.text ), textValue ) );
	end
	SSConfig_SetValue( info.var, this:GetValue() );
	
	if( info.opacityUpdated ) then
		if( ( info.var[1] ~= "overlay" ) or ( info.var[1] == "overlay" and IsAddOnLoaded( "SSOverlay" ) ) ) then
			info.opacityUpdated();
		end
	end
end

function SSUI_Checkbox_OnClick()
	local info = UIElements[ this:GetName() ];
	
	if( getglobal( this:GetName() ):GetChecked() ) then
		SSConfig_SetValue( info.var, true );	
	else
		SSConfig_SetValue( info.var, false );	
	end
	
	if( info.var ~= nil and info.var[1] == "overlay" and IsAddOnLoaded( "SSOverlay" ) ) then
		SSOverlay_ReloadOverlay();
	end
end

function SSUI_OpenColorPicker()
	local info = UIElements[ this:GetName() ];
	local color = SSConfig_GetValue( info.var );
	
	ColorPickerFrame.UIElementID = this:GetName();
	ColorPickerFrame.func = SSUI_SetColor;
	ColorPickerFrame.cancelFunc = SSUI_CancelColor;
	ColorPickerFrame.previousValues = { r = color.r, g = color.g, b = color.b };
	ColorPickerFrame:SetColorRGB( color.r, color.g, color.b );
	ColorPickerFrame:Show();
end

function SSUI_SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB();
	local info = UIElements[ ColorPickerFrame.UIElementID ];

	getglobal( ColorPickerFrame.UIElementID .. "NormalTexture" ):SetVertexColor( r, g, b );
	
	SSConfig_SetValue( info.var, { r = r, g = g, b = b } );
		
	if( info.colorUpdated ) then
		if( ( info.var[1] ~= "overlay" ) or ( info.var[1] == "overlay" and IsAddOnLoaded( "SSOverlay" ) ) ) then
			info.colorUpdated();
		end
	end
end

function SSUI_CancelColor( prevColor )
	local info = UIElements[ ColorPickerFrame.UIElementID ];
	
	getglobal( ColorPickerFrame.UIElementID .. "NormalTexture" ):SetVertexColor( prevColor.r, prevColor.g, prevColor.b );
	
	SSConfig_SetValue( info.var, prevColor );

	if( info.colorUpdated ) then
		if( ( info.var[1] ~= "overlay" ) or ( info.var[1] == "overlay" and IsAddOnLoaded( "SSOverlay" ) ) ) then
			info.colorUpdated();
		end
	end
end
	
-- STATIC POPUPS
function SSUI_LoadStaticPopups()
		
		-- Confirmation to leave the battlegrounds
		StaticPopupDialogs["CONFIRM_BATTLEFIELD_LEAVE"] = {
			text = TEXT( SS_CONFIRM_BGLEAVE ),
			
			button1 = TEXT( YES ),
			button2 = TEXT( NO ),
			
			OnAccept = function( data )
				SSPVP_AcceptBattlefieldPort( data, nil, true );
			end,
			
			timeout = 0,
			whileDead = 1,
			hideOnEscape = 1,
			multiple = 1
		}
		
		-- Editing a players name for auto accept invites
		StaticPopupDialogs["EDIT_PLAYER_NAME"] = {
			text = TEXT( SS_UI_EDITNAME ),
			
			button1 = TEXT( OKAY ),
			button2 = TEXT( CANCEL ),
			
			hasEditBox = 1,
			maxLetters = 24,
			
			OnAccept = function( data )
				local newName = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_PlayerNames_EditName( data, newName );
			end,
			
			EditBoxOnEnterPressed = function( data )
				local newName = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_PlayerNames_EditName( data, newName );
			end,
			
			OnShow = function()
				getglobal( this:GetName() .. "EditBox" ):SetFocus();
			end,
			
			OnHide = function()
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:SetFocus();
				end
				getglobal( this:GetName() .. "EditBox" ):SetText("");
			end,
			
			whileDead = 1,
			timeout = 0,
			exclusive = 1,
			hideOnEscape = 1
		};
		
		-- Adding a players name for auto accept invites
		StaticPopupDialogs["ADD_PLAYER_NAME"] = {
			text = TEXT( SS_UI_ADDNAME ),
			
			button1 = TEXT( OKAY ),
			button2 = TEXT( CANCEL ),
			
			hasEditBox = 1,
			maxLetters = 24,
			
			OnAccept = function()
				local name = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_PlayerNames_AddName( name );
			end,
			
			EditBoxOnEnterPressed = function()
				local name = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_PlayerNames_AddName( name );
			end,
			
			OnShow = function( )
				getglobal( this:GetName() .. "EditBox" ):SetFocus();
			end,
			
			OnHide = function()
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:SetFocus();
				end
				getglobal( this:GetName() .. "EditBox" ):SetText( "" );
			end,
			
			whileDead = 1,
			timeout = 0,
			exclusive = 1,
			hideOnEscape = 1
		};


		-- Editing a players name for auto accept invites
		StaticPopupDialogs["EDIT_CHANNEL_NAME"] = {
			text = TEXT( SS_UI_EDITCHANNEL ),
			
			button1 = TEXT( OKAY ),
			button2 = TEXT( CANCEL ),
			
			hasEditBox = 1,
			maxLetters = 24,
			
			OnAccept = function( data )
				local newChannel = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_ChannelNames_EditChannel( data, newChannel );
			end,
			
			EditBoxOnEnterPressed = function( data )
				local newChannel = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_ChannelNames_EditChannel( data, newChannel );
			end,
			
			OnShow = function( )
				getglobal( this:GetName() .. "EditBox" ):SetFocus();
			end,
			
			OnHide = function()
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:SetFocus();
				end
				getglobal( this:GetName() .. "EditBox" ):SetText("");
			end,
			
			whileDead = 1,
			timeout = 0,
			exclusive = 1,
			hideOnEscape = 1
		};
		
		-- Adding a players name for auto accept invites
		StaticPopupDialogs["ADD_CHANNEL_NAME"] = {
			text = TEXT( SS_UI_ADDCHANNEL ),
			
			button1 = TEXT( OKAY ),
			button2 = TEXT( CANCEL ),
			
			hasEditBox = 1,
			maxLetters = 24,
			
			OnAccept = function()
				local name = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_ChannelNames_AddChannel( name );
			end,
			
			EditBoxOnEnterPressed = function()
				local name = getglobal( this:GetParent():GetName() .. "EditBox" ):GetText();
				SSUI_ChannelNames_AddChannel( name );
			end,
			
			OnShow = function( )
				getglobal( this:GetName() .. "EditBox" ):SetFocus();
			end,
			
			OnHide = function()
				if ( ChatFrameEditBox:IsVisible() ) then
					ChatFrameEditBox:SetFocus();
				end
				getglobal( this:GetName() .. "EditBox" ):SetText( "" );
			end,
			
			whileDead = 1,
			timeout = 0,
			exclusive = 1,
			hideOnEscape = 1
		};
 
end

-- PLAYER NAME GUI
function SSUI_PlayerNames_AddName( addName )
	-- Make sure it doesn't exist
	for id, name in SSPVP_Config.playerNames do
		if( name == addName ) then
			return;
		end
	end

	table.insert( SSPVP_Config.playerNames, addName );

	local info = {};
	info.text = addName;
	info.arg1 = addName;
	info.owner = this;
	info.func = SSUI_PlayerNames_OnClick;

	UIDropDownMenu_AddButton( info );
	UIDropDownMenu_SetSelectedName( SSPlayerNames, addName, 1 );
	UIDropDownMenu_SetText( addName, SSPlayerNames );
end

function SSUI_PlayerNames_EditName( oldName, newName )
	-- Make sure it doesn't exist!	
	for id, name in SSPVP_Config.playerNames do
		if( name == newName ) then
			return;
		end
	end
	
	for id, name in SSPVP_Config.playerNames do
		
		if( name == oldName ) then
			SSPVP_Config.playerNames[ id ] = newName;
			UIDropDownMenu_SetSelectedName( SSPlayerNames, newName, 1 );
			UIDropDownMenu_SetText( newName, SSPlayerNames );
		end
	end
end

function SSUI_PlayerNames_DeleteName()
	local deleteName = UIDropDownMenu_GetSelectedName( SSPlayerNames );
	if( deleteName == nil or deleteName == "" ) then
		return;
	end
	
	for id, name in SSPVP_Config.playerNames do
		if( name == deleteName ) then
			table.remove( SSPVP_Config.playerNames, id );
		end
	end
	
	
	SSUI_PlayerNames_Initialize();
	
	if( getn( SSPVP_Config.playerNames ) == 0 ) then
		UIDropDownMenu_SetText( SS_UI_PLAYER_NAMES, SSPlayerNames );
	else
		UIDropDownMenu_SetText( SSPVP_Config.playerNames[1], SSPlayerNames );
		UIDropDownMenu_SetSelectedName( SSPlayerNames, SSPVP_Config.playerNames[1], 1 );
	end
end

function SSUI_PlayerNames_ShowAddWindow()
	StaticPopup_Show( "ADD_PLAYER_NAME" );
end

function SSUI_PlayerNames_ShowEditWindow()
	local selectedName = UIDropDownMenu_GetSelectedName( SSPlayerNames );
	
	if( selectedName == nil or selectedName == "" ) then
		return;
	end

	local dialog = StaticPopup_Show( "EDIT_PLAYER_NAME", "", "", selectedName );
	if( dialog ) then
		dialog.data = selectedName;
		getglobal( dialog:GetName() .. "EditBox" ):SetText( dialog.data );
	end
end



function SSUI_PlayerNames_OnClick( name )
	UIDropDownMenu_SetSelectedName( SSPlayerNames, name, 1 );
end

function SSUI_PlayerNames_Initialize()
	UIDROPDOWNMENU_INIT_MENU = "SSPlayerNames";
	
	if( SSPVP_Config == nil ) then
		UIDropDownMenu_SetText( SS_UI_PLAYER_NAMES, SSPlayerNames );
		UIDropDownMenu_SetSelectedName( SSPlayerNames, "", 1 );		
		return;
	end
	
	for id, name in SSPVP_Config.playerNames do	
		local info = {};
		info.text = name;
		info.arg1 = name;
		info.owner = this;
		info.func = SSUI_PlayerNames_OnClick;

		UIDropDownMenu_AddButton( info );
	end

	if( SSPVP_Config.playerNames[1] ~= nil ) then
		UIDropDownMenu_SetText( SSPVP_Config.playerNames[1], SSPlayerNames );
		UIDropDownMenu_SetSelectedName( SSPlayerNames, SSPVP_Config.playerNames[1], 1 );
	else
		UIDropDownMenu_SetText( SS_UI_PLAYER_NAMES, SSPlayerNames );	
	end
end

function SSUI_PlayerNames_OnLoad()
	UIDropDownMenu_Initialize( this, SSUI_PlayerNames_Initialize );
end

-- CHANNEL NAME GUI
-- It's nice when you can build a whole feature in 10 minutes by reusing code
function SSUI_ChannelNames_AddChannel( addChannel )
	-- Make sure it doesn't exist
	for id, name in SSPVP_Config.channelNames do
		if( name == addChannel ) then
			return;
		end
	end
	
	-- If we're inside a BG, add the channel
	if( SSPVP_PlayerInBG() ) then
		
		table.insert( SSPVP_Config.activeChannels, addChannel );
		SSPVP_JoinChannel( addChannel );
	end
	
	table.insert( SSPVP_Config.channelNames, addChannel );

	local info = {};
	info.text = addChannel;
	info.arg1 = addChannel;
	info.owner = this;
	info.func = SSUI_ChannelNames_OnClick;

	UIDropDownMenu_AddButton( info );
	UIDropDownMenu_SetSelectedName( SSChannelNames, addChannel, 1 );
	UIDropDownMenu_SetText( addChannel, SSChannelNames );
end

function SSUI_ChannelNames_EditChannel( oldChannel, newChannel )
	-- Make sure it doesn't exist
	for id, name in SSPVP_Config.channelNames do
		if( name == newChannel ) then
			return;
		end
	end

	for id, name in SSPVP_Config.channelNames do
		
		if( name == oldChannel ) then
			SSPVP_Config.channelNames[ id ] = newChannel;
			
			UIDropDownMenu_SetSelectedName( SSChannelNames, newChannel, 1 );
			UIDropDownMenu_SetText( newChannel, SSChannelNames );
		end
	end
	
	-- If we're in any of the active channels, make sure we leave
	-- the old one and join the new one

	if( getn( SSPVP_Config.activeChannels ) > 0 ) then
		
		for id, name in SSPVP_Config.activeChannels do
			
			if( name == oldChannel ) then
				SSPVP_LeaveChannel( oldDame );
				SSPVP_JoinChannel( newName );
				
				SSPVP_Config.activeChannels[ id ] = newName;
			end
		end
		
	end
end

function SSUI_ChannelNames_DeleteChannel()
	local deleteName = UIDropDownMenu_GetSelectedName( SSChannelNames );
	if( deleteName == nil or deleteName == "" ) then
		return;
	end

	for id, name in SSPVP_Config.channelNames do
		if( name == deleteName ) then
			table.remove( SSPVP_Config.channelNames, id );
		end
	end
	
	SSUI_ChannelNames_Initialize();
	
	if( getn( SSPVP_Config.activeChannels ) > 0 ) then
		
		for id, name in SSPVP_Config.activeChannels do
			
			if( name == deleteName ) then
				SSPVP_LeaveChannel( deleteName );
				table.remove( SSPVP_Config.activeChannels, id );
			end
		end
		
	end
	
	if( getn( SSPVP_Config.channelNames ) == 0 ) then
		UIDropDownMenu_SetText( SS_UI_CHANNEL_NAMES, SSChannelNames );
	else
		UIDropDownMenu_SetText( SSPVP_Config.channelNames[1], SSChannelNames );
		UIDropDownMenu_SetSelectedName( SSChannelNames, SSPVP_Config.channelNames[1], 1 );
	end
end


function SSUI_ChannelNames_ShowAddWindow()
	StaticPopup_Show( "ADD_CHANNEL_NAME" );
end

function SSUI_ChannelNames_ShowEditWindow()
	local selectedName = UIDropDownMenu_GetSelectedName( SSChannelNames );
	
	if( selectedName == nil or selectedName == "" ) then
		return;
	end

	local dialog = StaticPopup_Show( "EDIT_CHANNEL_NAME", "", "", selectedName );
	if( dialog ) then
		dialog.data = selectedName;
		getglobal( dialog:GetName() .. "EditBox" ):SetText( dialog.data );
	end
end

function SSUI_ChannelNames_OnClick( name )
	UIDropDownMenu_SetSelectedName( SSChannelNames, name, 1 );
end

function SSUI_ChannelNames_Initialize()
	UIDROPDOWNMENU_INIT_MENU = "SSChannelNames";
	
	if( SSPVP_Config == nil ) then
		UIDropDownMenu_SetText( SS_UI_CHANNEL_NAMES, SSChannelNames );
		UIDropDownMenu_SetSelectedName( SSChannelNames, "", 1 );		
		return;
	end
	
	for id, name in SSPVP_Config.channelNames do	
		local info = {};
		info.text = name;
		info.arg1 = name;
		info.owner = this;
		info.func = SSUI_ChannelNames_OnClick;

		UIDropDownMenu_AddButton( info );

		if( id == 1 and SSChannelNames.selectedName == nil ) then
			UIDropDownMenu_SetText( name, SSChannelNames );
			UIDropDownMenu_SetSelectedName( SSChannelNames, name, 1 );
		end
	end

	if( getn( SSPVP_Config.channelNames ) == 0 ) then
		UIDropDownMenu_SetText( SS_UI_CHANNEL_NAMES, SSChannelNames );
	end
end

function SSUI_ChannelNames_OnLoad()
	UIDropDownMenu_Initialize( this, SSUI_ChannelNames_Initialize );
end

function SSUI_Open_Config()
	ShowUIPanel( SSOptions );
	-- SSOptions:Show();
end

function SSUI_Close_Config()
	HideUIPanel( SSOptions );
	-- SSOptions:Hide();
end