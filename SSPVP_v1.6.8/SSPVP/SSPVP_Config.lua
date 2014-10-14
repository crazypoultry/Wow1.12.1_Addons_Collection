local defaultConfig = {
	playerNames = {},
	channelNames = {},
	activeChannels = {},
	ainvite = { friends = 0, battleground = 0 },

	join = {	enabled = 1,
			timeout = 30,
			instance = 0,
			afk = 1,
			gathering = 0,
			windowHidden = 0 },
			
	leave = {	enabled = 1,
			timeout = 30,
			group = 0 },
			
	general = {	enabled = 1,
			soundFile = "",
			openMinimap = 1,
			release = 1,
			skipGossip = 1,
			debug = 0,
			kb = 1,
			kbColor = { r = 0, g = 0, b = 1 }
		},
	
	AB = {		enabled = 1,
			interval = 30,
			horde = 1,
			allliance = 1 },
	
	AV = {		enabled = 1,
			interval = 60,
			alliance = 1,
			horde = 1 },
	
	overlay = {	enabled = 1,
			queue = 1,
			AV = 1,
			AB = 1,
			locked = 1,
			textOpacity = 1,
			color = { r = 0, g = 0, b = 0 },
			text = { r = 1, g = 1, b = 1 },
			border = { r = 0.5, g = 0.5, b = 0.5 } },
	queue = { enabled = 1 },
};

-- Sound testing
function SSConfig_StopSound( noOutput, soundFile )
	soundFile = ( soundFile or SSSoundFile:GetText() );
	
	if( soundFile == nil or soundFile == "" ) then
		return;
	end
	
	if( string.find( soundFile, "mp3" ) ) then
		StopMusic();
	else
		local oldMasterSound = GetCVar( "MasterSoundEffects" );
		
		SetCVar( "MasterSoundEffects", 0 );
		SetCVar( "MasterSoundEffects", oldMasterSound );
	end
	
	if( noOutput == nil ) then
		SSPVP_Message( SS_STOPPED_PLAYING, ChatTypeInfo["SYSTEM"] );
	end
end

-- Play the entered sound file
function SSConfig_PlaySound()
	SSConfig_StopSound( true );
	
	local soundFile = SSSoundFile:GetText();
	
	if( soundFile ~= "" ) then
		if( string.find( soundFile, "mp3" ) ) then
			PlayMusic( "Interface\\AddOns\\SSPVP\\" .. soundFile );
			
			if( tonumber( GetCVar( "EnableMusic" ) ) == 0 or tonumber( GetCVar( "MusicVolume" ) ) == 0 or tonumber( GetCVar( "MasterVolume" ) ) == 0 ) then
				SSPVP_Message( SS_MP3_ERROR, ChatTypeInfo["SYSTEM"] );
			else
				SSPVP_Message( SS_PLAY_INFO, ChatTypeInfo["SYSTEM"] );
				SSPVP_Message( string.format( SS_PLAYING_SOUND, soundFile ), ChatTypeInfo["SYSTEM"] );
			end
		else
			PlaySoundFile( "Interface\\AddOns\\SSPVP\\" .. soundFile );
			
			if( tonumber( GetCVar( "MasterSoundEffects" ) ) == 0 or tonumber( GetCVar( "SoundVolume" ) ) == 0 or tonumber( GetCVar( "MasterVolume" ) ) == 0 ) then
				SSPVP_Message( SS_WAV_ERROR, ChatTypeInfo["SYSTEM"] );
			else
				SSPVP_Message( SS_PLAY_INFO, ChatTypeInfo["SYSTEM"] );
				SSPVP_Message( string.format( SS_PLAYING_SOUND, soundFile ), ChatTypeInfo["SYSTEM"] );
			end
		end
	end
end

-- Resets the minimap location, incase it got dragged off the screen.
function SSConfig_FixMinimap()
	BattlefieldMinimap_LoadUI();
	
	if( BattlefieldMinimap ~= nil ) then
		BattlefieldMinimapTab:SetPoint( "CENTER", "UIParent", "TOPLEFT", 200, -100 );
		BattlefieldMinimapTab:SetUserPlaced( true );								
	end
end

-- Toggle the minimap
function SSConfig_ToggleMinimap()
	BattlefieldMinimap_LoadUI();

	if( BattlefieldMinimap ~= nil ) then
			if( BattlefieldMinimap:IsVisible() ) then
			BattlefieldMinimap:Hide();
			SSPVP_Message( SS_HIDING_MINIMAP, ChatTypeInfo["SYSTEM" ] );
		else
			BattlefieldMinimap:Show();								
			SSPVP_Message( SS_SHOWING_MINIMAP, ChatTypeInfo["SYSTEM"] );
		end
	end
end

-- Getting/Setting variables
function SSConfig_GetValue( var )
	if( var == nil ) then
		return nil;
	end
	
	local varValue = nil;
	
	if( var[1] == "overlay" and SSOverlay_Config ~= nil ) then
		SSConfig_CheckTable( var[1], var[2] );
		varValue = SSOverlay_Config[ var[2] ];
		
	elseif( var[1] == "map" ) then
		varValue = BattlefieldMinimapOptions[ var[2] ];
	
	elseif( var[1] ~= nil and var[2] ~= nil and SSPVP_Config ~= nil ) then
		SSConfig_CheckTable( var[1], var[2] );
		varValue = SSPVP_Config[ var[1] ][ var[2] ];
	
	elseif( var[1] ~= nil and var[2] == nil and SSPVP_Config ~= nil ) then
		SSConfig_CheckTable( var[1] );
		varValue = SSPVP_Config[ var[1] ];
	end
	
	return varValue;
end

function SSConfig_SetValue( var, value )
	if( var == nil ) then
		return;
	end

	if( var[1] == "overlay" ) then
		SSOverlay_Config[ var[2] ] = value;
	
	elseif( var[1] == "map" ) then
		BattlefieldMinimap_LoadUI();
		
		if( BattlefieldMinimapOptions ~= nil ) then
			BattlefieldMinimapOptions[ var[2] ] = value;
		end
	
	elseif( var[1] ~= nil and var[2] ~= nil ) then
		SSConfig_CheckTable( var[1], nil );
		SSPVP_Config[ var[1] ][ var[2] ] = value;
	
	elseif( var[1] ~= nil and var[2] == nil ) then
		SSPVP_Config[ var[1] ] = value;
	end
end

function SSConfig_CheckTable( category, key )
	if( category == nil ) then
		return;
	end
	
	if( category == "overlay" and SSOverlay_Config ~= nil ) then
		if( SSOverlay_Config[ key ] == nil ) then
			SSOverlay_Config[ key ] = defaultConfig[ category ][ key ];
		end

	elseif( SSPVP_Config ~= nil ) then
		if( SSPVP_Config[ category ] == nil ) then
			SSPVP_Config[ category ] = defaultConfig[ category ];
		elseif( key ~= nil and SSPVP_Config[ category ][ key ] == nil ) then
			SSPVP_Config[ category ][ key ] = defaultConfig[ category ][ key ];
		end
	end
end


function SSConfig_Upgrade_Config( version )

	if( version == "1.4" or version == "1.5" ) then
		
		if( SSPVP_Config.AV.hordeCaptures or SSPVP_Config.AV.hordeDestroys ) then
			SSPVP_Config.AV.horde = 1;
		else
			SSPVP_Config.AV.horde = 0;
		end
		
		if( SSPVP_Config.AV.allianceCaptures or SSPVP_Config.AV.allianceDestroys ) then
			SSPVP_Config.AV.alliance = 1;
		else
			SSPVP_Config.AV.alliance = 0;
		end

		if( SSPVP_Config.map ~= nil and SSPVP_Config.map.channel ~= nil ) then
			SSPVP_LeaveChannel( SSPVP_Config.map.channel );
		end

		SSOverlay_Config = SSPVP_Config.overlay;
		
		SSPVP_Config.overlay = nil;
		SSPVP_Config.map = nil;
		SSPVP_Config.AV.hordeCaptures = nil;
		SSPVP_Config.AV.hordeDestroys = nil;
		SSPVP_Config.AV.allianceCaptures = nil;
		SSPVP_Config.AV.allianeDestroys = nil;
	end

end

-- Defaults
function SSConfig_Check_Config()
		
	if( SSPVP_Config == nil ) then
		SSPVP_Config = {};
		SSPVP_Config.varVersion = SSPVPVersion;
	end	
		
	for category, table in defaultConfig do
		if( category ~= "overlay" and SSPVP_Config[ category ] == nil ) then
			SSPVP_Config[ category ] = table;
		end
	end

	-- Now check SSOverlay config
	if( SSOverlay_Config == nil ) then
		SSOverlay_Config = {};
		
		SSOverlay_Config.enabled = 1;
		
		SSOverlay_Config.locked = 1;
		SSOverlay_Config.opacity = 1;
		SSOverlay_Config.textOpacity = 1;

		SSOverlay_Config.AV = 1;
		SSOverlay_Config.AB = 1;
		SSOverlay_Config.queue = 1;

		SSOverlay_Config.color = { r = 0, g = 0, b = 0 };
		SSOverlay_Config.border = { r = 1, g = 1, b = 1 };
		SSOverlay_Config.text = { r = 1, g = 1, b = 1 };
	end	
end

function SSConfig_Load_Default()

	SSPVP_Config = nil;
	SSOverlay_Config = nil;
	
	SSConfig_Check_Config();
end


-- SLASH COMMAND HANDLER
function SSConfig_HandleSlashes( msg )
	
	if( msg == "show" ) then
		SSUI_Open_Config();

	elseif( msg == "hide" ) then
		SSUI_Close_Config();

	elseif( msg == "off" ) then		
		SSPVP_Config.general.enabled = false;
		SSPVP_Message( string.format( SS_CMD_MOD, RED_FONT_COLOR_CODE .. SS_OFF .. FONT_COLOR_CODE_CLOSE ) );

	elseif( msg == "on" ) then		
		SSPVP_Config.general.enabled = true;
		SSPVP_Message( string.format( SS_CMD_MOD, GREEN_FONT_COLOR_CODE .. SS_ON .. FONT_COLOR_CODE_CLOSE ) );	
	else
		SSUI_Open_Config();
	end
end 
