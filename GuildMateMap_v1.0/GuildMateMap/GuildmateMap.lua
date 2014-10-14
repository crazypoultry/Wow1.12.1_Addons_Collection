-- *******************************************************************************************
-- * GuildMateMap
-- * Author: Wolfsokta on ThrallsHonor(US) -- wolfsokta _AT_ thrallshonor dot com. 
-- * Version 1.0
-- * Credits: Many thanks to Bru on Blackhand(DE) - wow@docbru.de for the help with map offset code
-- *
-- * 1.0 You can now left click on a guildmate icon in the world map to whisper them, or right click to invite them to your party
-- * Fixed the problem where you would disapear or jump to bad location on other peoples maps when you opened your minimap.
-- * As a result though, position information won't be sent and minimap icons won't draw while you have your map open to continent or world levels
-- * No known erros exist in the US version.
-- * 
-- * 
-- * 0.95 Now doesn't display guildmate icon for guildmates in your party. Added a rightclick menu on minimap. Updated
-- *      the German localization (Thanks Aprophis for providing it).
-- *
-- * 0.9 You can now click on a guildmate in the minimap to select them. Added a really bad, incomplete german translation.
-- *
-- * 0.8 Added the minimap distances to the preferences. Fixed the last error I hope.
-- *
-- * 0.7 Added an option to turn off the Message to the guild when you level. Added persistent options
-- *     so your pref items will be remembered across sessions. More bug Fixes.
-- *
-- * 0.6 Fixed an error during startup.
-- *
-- * 0.5 Initial release
-- *
-- *
-- *
-- *******************************************************************************************

-- **
-- * Constants
-- **
-- Max number of icons to show on the main map. Do guilds ever have 200 online at once?
local GuildMateMap_MAX_MAP_ICONS = 200;
local GuildMateMap_MAX_MINI_MAP_ICONS = 50;
 -- How often the positions will be sent out and redrawn on the maps.
local GuildMateMap_SEND_UPDATE_INTERVAL = 5.0;
local GuildMateMap_UPDATE_MINIMAP_INTERVAL = 0.25;
local GuildMateMap_UPDATE_MAP_INTERVAL = 1.0; -- Only draws if the map is actually open

-- Distance that guildMates will show up in the minimap.
local GuildMateMap_MaxMiniMapDistance = 120;
local GuildMateMap_MiniMapCircDistance = 60.5;

-- An Array containing all the zones and thier continent and zone indexes
local GuildMateMap_WorldInfo = {};


GuildMateMapPrefs = {};

-- **
-- * List of people currently in our group. If we aren't in a group this will be empty.
-- **
local GuildMateMap_GroupMembers = nil;


-- **
-- * List of mates currently being tracked.
-- **
local GuildMateMap_GuldMates = {};

-- **
-- * Message types sent to other guildmates
-- **
local GuildMateMap_UPDATE_MSG  = "update"; -- Used to send position data
local GuildMateMap_LOGOUT_MSG  = "logout"; -- Used when a guildmate is logging out.


-- **
-- * function GuildMateMap_OnLoad called at load time.
-- **
function GuildMateMap_OnLoad()
	this.TimeSinceLastUpdate = 0;
	this.TimeSinceLastMiniMapUpdate = 0;
	this.TimeSinceLastMapUpdate = 0;
	
	-- Get information about the user to pass to other guildmates
	-- TODO put all player vars into a table.
	this.playerName = UnitName("player");
	this.playerClass = UnitClass("player");
	this.playerLevel = UnitLevel("player");
	this.playerRank = GuildMateMap_GetGuildRank();
	this.playerContinent = 0;
	this.playerZone = 0;
	this.playerX = 0;
	this.playerY = 0;
	this.isInCity = false;
	
    SLASH_GUILDMATEMAP1 = "/gmm"
    SLASH_GUILDMATEMAP2 = "/guildmatemap"
    SlashCmdList[ "GUILDMATEMAP"] = GuildMateMap_Slasher;
    GuildMateMap_ChatMessage( GuildMateMap_LOADED_TEXT );
	
	GuildMateMap_InitWorldInfo();
	-- Listen for our variables to be loaded so we can create any new ones
	-- that don't exist in older versions.
	this:RegisterEvent( "VARIABLES_LOADED" );
end

function GuildMateMap_InitPrefs()
	-- Added for version 0.7
	if ( GuildMateMapPrefs.enabled == nil ) then
		GuildMateMapPrefs.enabled = true;
		GuildMateMapPrefs.debug = false;
		GuildMateMapPrefs.msgOnLevel = true; -- Displays a message in guild chat that you have achieved a new level.
	end
	-- Added for verrsion 0.8
	if ( GuildMateMapPrefs.maxMiniMapDist == nil ) then
		GuildMateMapPrefs.maxMiniMapDist = GuildMateMap_MaxMiniMapDistance;
		GuildMateMapPrefs.miniMapCircDist = GuildMateMap_MiniMapCircDistance;
	end
	
	GuildMateMap_SetEnabled( GuildMateMapPrefs.enabled );
end;

function GuildMateMap_GetGuildRank()
	local guildName, guildRank, guildRankIndex = GetGuildInfo("player");
	if ( guildRank == nil ) then
		guildRank = GuildMateMap_Updating;
	end
	
	return guildRank;
end

-- **
-- * function GuildMateMap_DebugMessage Prints a message to the chat window if debug is on.
-- **
function GuildMateMap_DebugMessage( message )
	if ( GuildMateMapPrefs.debug ) then
		DEFAULT_CHAT_FRAME:AddMessage( "DEBUG - "..message, 0.2, 0.2, 1, 1.0, DEFAULT_CHAT_FRAME:GetFadeDuration());
	end
end

-- **
-- * function GuildMateMap_ChatMessage Prints a message to the chat window
-- **
function GuildMateMap_ChatMessage( msg )
    DEFAULT_CHAT_FRAME:AddMessage( msg, 0.29, 0.81, 0.08, 1.0, DEFAULT_CHAT_FRAME:GetFadeDuration());
end

-- **
-- * function GuildMateMap_OnEvent Called when we receive an event we have registered for.
-- **
function GuildMateMap_OnEvent( event )
    if ( GuildMateMapPrefs.enabled ) then
		if ( event == "CHAT_MSG_ADDON" ) then
			-- We received a message from another guildmate
			if ( arg1 == "GuildMateMap" ) then
				-- Filter out messages from ourselves
				if ( GuildMateMapPrefs.debug or arg4 ~= this.playerName ) then -- always process if debug is on.
					-- GuildMateMap_DebugMessage( "Received message "..tostring(arg2) );
					GuildMateMap_ProcessMessage( arg2 );
				end
			end
		elseif ( event == "PLAYER_LEVEL_UP" ) then
			-- We just leveled. Update our level for the next message to guild.
			GuildMateMap_SendLvlMessage( arg1 );
		elseif ( event == "PLAYER_LEAVING_WORLD" ) then
			-- We are logging let guildmates know about it
			GuildMateMap_SendLogoutMessage( );
		elseif ( event == "MINIMAP_UPDATE_ZOOM" ) then
			this.isInCity = GuildMateMap_IsInCity();
		elseif (event == "WORLD_MAP_UPDATE") then
			-- The world map was opened or closed. Draw our guildies
				GuildMateMap_DrawWorldMap();
		elseif (event == "PARTY_MEMBERS_CHANGED") then
			-- The world map was opened or closed. Draw our guildies
				GuildMateMap_UpdatePartyMembers();
		elseif (event == "VARIABLES_LOADED") then
			GuildMateMap_InitPrefs(); -- Init our prefs defaults.
		elseif (event == "MINIMAP_ZONE_CHANGED") then
			 this.playerContinent, this.playerZone = GuildMateMap_GetWorldLoc();
			 this.isInCity = GuildMateMap_IsInCity();
		end
		
	end
end

-- **
-- * function GuildMateMap_OnUpdate Called when WoW can update the addon.
-- **
function GuildMateMap_OnUpdate(elapsed)
	if ( GuildMateMapPrefs.enabled and IsInGuild()) then
		-- only Send Update at the specified update interval.
		this.TimeSinceLastUpdate = this.TimeSinceLastUpdate + elapsed;
		if (this.TimeSinceLastUpdate > GuildMateMap_SEND_UPDATE_INTERVAL ) then
			GuildMateMap_SendPosition();
			this.TimeSinceLastUpdate = 0;
		end
		-- See if it's time to update the minimap		
		this.TimeSinceLastMiniMapUpdate = this.TimeSinceLastMiniMapUpdate + elapsed;
		if ( this.TimeSinceLastMiniMapUpdate > GuildMateMap_UPDATE_MINIMAP_INTERVAL ) then
			GuildMateMap_DrawMiniMap();
			this.TimeSinceLastMiniMapUpdate = 0;
		end
		
		-- See if it's time to update the WorldMap		
		this.TimeSinceLastMapUpdate = this.TimeSinceLastMapUpdate + elapsed;
		if ( this.TimeSinceLastMapUpdate > GuildMateMap_UPDATE_MAP_INTERVAL ) then
			GuildMateMap_DrawWorldMap();
			this.TimeSinceLastMapUpdate = 0;
		end
	elseif (GuildMateMapPrefs.enabled == nil ) then
		-- We don't ever want our prefs to be not set.
		GuildMateMap_InitPrefs();
	end
	
end

-- **
-- * function GuildMateMap_SendPosition Sends our info to the other guildMates
-- **
function GuildMateMap_SendPosition( )
	positionInfo = GuildMateMap_MakePositionMessage();
	-- We are getting weird position info when the map is open for the current player
	-- So disable the sending of position if the user has the Zone or World map displayed.
	if ( WorldMapFrame:IsVisible() ) then
		local mapCont = GetCurrentMapContinent();
		local mapZone = GetCurrentMapZone();
		if ( mapCon == 0 or mapZone == 0 ) then
			return;
		end
	end
	
	GuildMateMap_DebugMessage( "Sending Position Info "..positionInfo )
	SendAddonMessage( "GuildMateMap", GuildMateMap_UPDATE_MSG..":"..positionInfo, "GUILD" );
end

-- **
-- * function GuildMateMap_SendPosition Sends a logout message to our guildMates
-- **
function GuildMateMap_SendLogoutMessage( )
	SendAddonMessage("GuildMateMap", GuildMateMap_LOGOUT_MSG..":"..this.playerName, "GUILD" ); 
end

-- **
-- * function GuildMateMap_SendLvlMessage Lets our guildmates know how cool we are.
-- **
function GuildMateMap_SendLvlMessage( newLevel )
	if ( GuildMateMapPrefs.msgOnLevel ) then
		SendChatMessage( string.format(GuildMateMap_LevelMessage, this.playerName, newLevel), "GUILD"  );
	end
	this.playerLevel = newLevel;
end
	
function GuildMateMap_InitWorldInfo()

	local continentNames = { GetMapContinents() } ;
	for index, name in continentNames do 
		
		local zoneNames = { GetMapZones(index) } ;
		for zIndex, zName in zoneNames do
			local zoneData = { index, zIndex };
			GuildMateMap_WorldInfo[zName] = zoneData;
		end
	end
	
	GuildMateMap_GetWorldLoc();
end

function GuildMateMap_GetWorldLoc()
	local continent = -2; -- Set to an unknown value
	local zone = -2;
	local zoneText = GetZoneText();
	zoneData = GuildMateMap_WorldInfo[zoneText];
	if ( zoneData ~= nil ) then
		continent = zoneData[1];
		zone = zoneData[2]
	end
	GuildMateMap_DebugMessage("Finding Current Continent for "..zoneText..": "..tostring(continent).." Zone: "..tostring(zone) );
	return continent, zone;
end


-- **
-- * function GuildMateMap_MakePositionMessage Builds the message to send to our guildmates
-- **
function GuildMateMap_MakePositionMessage( )
	 GuildMateMap_UpdatePlayerPosition();
	 
	 -- If our Continent isn't set yet put try to update it.
	 if ( this.playerContinent == nil or this.playerContinent == 0 ) then
	 	this.playerContinent, this.playerZone = GuildMateMap_GetWorldLoc();
	 end
	 	 
	 -- seems the guild ranking isn't initialized when the addons are loaded.
	 if ( this.playerRank == GuildMateMap_Updating ) then
	 	this.playerRank = GuildMateMap_GetGuildRank();
	 end
	 
	 -- Having issues with the level not being set before our onload. Check for it here.
	 if ( this.playerLevel == 0 ) then
	 	this.playerLevel = UnitLevel("player");
	 end
	 
	 -- Find out if we are in a city or not
	 -- this.isInCity = GuildMateMap_IsInCity();
	 
	 return this.playerName..":"..this.playerClass..":"..this.playerLevel..":"..this.playerRank..":"..this.playerContinent..":"..this.playerZone..":"..this.playerX..":"..this.playerY;
end

-- **
-- * function GuildMateMap_MakePositionMessage Builds the message to send to our guildmates
-- **
function GuildMateMap_UpdatePlayerPosition()
	this.playerX, this.playerY = GetPlayerMapPosition("player");
end

-- **
-- * function GuildMateMap_IsInCity Determines if you are in a major city.
-- **
function GuildMateMap_IsInCity()

	local isInCity = false;
	-- First if we aren't resting then we for sure aren't in a city
	if ( IsResting() ) then
		-- Now do a more thorough check
		local zoneText = GetZoneText();
		if ( zoneText == nil ) then
			zoneText = GuildMateMap_Updating;
		end
		
		GuildMateMap_DebugMessage("We are resting in ".. zoneText);
		for index, cityName in GuildMateMapMajorCities do
			if ( cityName == zoneText ) then
				isInCity = true;
				break;
			end
		end
	end
	
	return isInCity;	
end

-- **
-- * function GuildMateMap_ProcessMessage Parses the messages sent to us
-- **
function GuildMateMap_ProcessMessage( msg )
	-- Strip off the first param to see which message we have received
	start, finish, messageType, subMessage = string.find( msg, "(%a+):(.*)"); 
	
	if ( messageType == GuildMateMap_UPDATE_MSG ) then
		-- Add the player to the list.
		GuildMateMap_AddPlayerToList( subMessage );
	elseif ( messageType == GuildMateMap_LOGOUT_MSG ) then
		-- Remove the player from the list being drawn
		GuildMateMap_RemovePlayerWithMsg( subMessage );
	else
		-- Unknown message type recieved
		GuildMateMap_DebugMessage( "Unknown message received. Type: "..messageType.." Message: "..subMessage );
	end	
	
	-- Force a redraw of the minimap or map if open.
	GuildMateMap_DrawWorldMap();
	
end

-- **
-- * function GuildMateMap_AddPlayerToList Adds Players to the GuildMates list.
-- **
function GuildMateMap_AddPlayerToList( msg )
    local start, finish, namev, classv, levelv, rankv, continentv, zonev, xv, yv = string.find( msg, "(.+):(.+):(.+):(.+):(.+):(.+):(.+):(.*)" )
	-- GuildMateMap_DebugMessage( "Adding: "..namev.." class "..classv.." Level "..levelv.." rank ".. rankv.." continent "..continentv.." zone "..zonev.." Posx "..xv.." Posy "..yv );
	local values = { name=namev, class=classv, level=tonumber(levelv), rank=rankv, continent=tonumber(continentv), 
						zone=tonumber(zonev), x=tonumber(xv), y=tonumber(yv) };
						
	-- We need to see if the item exists first, if it does replace it
	GuildMateMap_UpdatePlayer( values );	
end

-- **
-- * function GuildMateMap_RemovePlayerWithMsg Removes a player based on the logout message.
-- **
function GuildMateMap_RemovePlayerWithMsg( msg )
    start, finish, removeName = string.find( msg, "(.+):(.*)" );
	if ( removeName ~= nil ) then
		GuildMateMap_UpdatePlayer( {name=removeName} );
	end
end

-- **
-- * function GuildMateMap_UpdatePlayer Removes the specified player from the list of guildies
-- **
function GuildMateMap_UpdatePlayer( guildMate, removeMate )
	local found = false;
	for index, info in GuildMateMap_GuldMates do
		if ( info.name == guildMate.name ) then 
			if ( removeMate ) then
				table.remove(GuildMateMap_GuldMates, index );
				GuildMateMap_DebugMessage( "Removing player "..guildmate.name.." at index: "..index  );
			else
				found = true;
				-- Update the current data
				info.level = guildMate.level;
				info.continent = guildMate.continent;
				info.zone = guildMate.zone;
				info.x = guildMate.x;
				info.y = guildMate.y;
			end
			break;
		end
	end
	if ( not removeMate and not found ) then
		table.insert( GuildMateMap_GuldMates, guildMate );
	end 
	
end



-- **
-- * function GuildMateMap_Slasher Handles the slash commands from the user.
-- **
function GuildMateMap_Slasher(cmd)
	if ( string.find( cmd, "^"..GuildMateMap_DEBUG_PARAM ) ~= nil ) then     -- GuildMateMap_DEBUG_PARAM
		debugStr = string.sub( cmd, string.len(GuildMateMap_DEBUG_PARAM) + 2 );
		if ( debugStr == "false" or debugStr == "off") then
			GuildMateMapPrefs.debug = false;
		else
			GuildMateMapPrefs.debug = true;
		end
		GuildMateMap_ChatMessage( "GuildMateMap debug is "..tostring(GuildMateMapPrefs.debug) );
	elseif (string.find( cmd, "^"..GuildMateMap_PRINT_LIST_PARAM ) ~= nil) then  -- GuildMateMap_PRINT_LIST_PARAM
		GuildMateMap_printGuildies();
	elseif (string.find( cmd, "^"..GuildMateMap_CLEAR_LIST_PARAM) ~= nil ) then -- GuildMateMap_CLEAR_LIST_PARAM
		GuildMateMap_ChatMessage("Position List Cleared...");
		GuildMateMap_GuldMates = {};
	elseif (string.find( cmd, "^"..GuildMateMap_Mates_PARAM) ~= nil ) then -- Adds some fake guildmates
		GuildMateMap_AddFakeMembers();
	elseif (string.find( cmd, "^"..GuildMateMap_Reload_PARAM) ~= nil ) then -- Reloads the WoW UI
		ReloadUI();
	elseif (string.find( cmd, "^"..GuildMateMap_MsgOnLevel_PARAM) ~= nil ) then -- Turns on/off the message to guildies when you level.
		debugStr = string.sub( cmd, string.len(GuildMateMap_MsgOnLevel_PARAM) + 2 );
		if (debugStr == "false" or debugStr == "off" ) then
			GuildMateMapPrefs.msgOnLevel = false;
		else
			GuildMateMapPrefs.msgOnLevel = true;
		end
	elseif ( string.find( cmd, "^"..GuildMateMap_Enabled_PARAM ) ~= nil ) then -- GuildMateMap_Enabled_PARAM
		debugStr = string.sub( cmd, string.len(GuildMateMap_Enabled_PARAM) + 2 );
		if (debugStr == "false" or debugStr == "off" ) then
			GuildMateMap_SetEnabled( false );
		else
			GuildMateMap_SetEnabled( true );
		end
	elseif ( string.find( cmd, "^worldinfo" ) ~= nil ) then
		GuildMateMap_InitWorldInfo();
	else
		GuildMateMap_info();
	end
	
end

-- **
-- * function  GuildMateMap_AddFakeMembers adds fake guildmates to the list.
-- **
function GuildMateMap_AddFakeMembers()
	GuildMateMap_AddPlayerToList("Trisfal1:Priest:45:Grunt:2:21:0.53235123:0.53231531312");
	GuildMateMap_AddPlayerToList("Trisfal2:Warrior:40:ShadowMaster:2:21:0.53235123:0.13231531312");
	GuildMateMap_AddPlayerToList("Trisfal3:Hunter:12:Peon:2:21:0.43235123:0.23231531312");
	GuildMateMap_AddPlayerToList("Trisfal4:Druid:44:Officer:2:21:0.33235123:0.73231531312");
	GuildMateMap_AddPlayerToList("GromGul:Rogue:51:Officer:2:18:0.3173:0.29159");
	GuildMateMap_AddPlayerToList("Durotar:Shaman:12:Peon:1:6:0.49042:0.14268");
	GuildMateMap_AddPlayerToList("Org:Hunter:32:Inner Guardian:1:12:0.52003:0.82838");
	GuildMateMap_AddPlayerToList("Silverpine1:Warrior:13:Grunt:2:16:0.65681:0.07916");
	GuildMateMap_AddPlayerToList("WolfMaster:Hunter:61:The Right Hand:2:16:0.43161:0.41367");
	GuildMateMap_AddPlayerToList("UnderCity1:Warlock:2:Peon:2:22:0.65987:0.44968");
	GuildMateMap_AddPlayerToList("RFC1:Warlock:20:Peon:2:0:0:0");
	GuildMateMap_AddPlayerToList("Moovinator1:Druid:23:Grunt:1:19:0.44762:0.5302");
	
end

-- **
-- * function GuildMateMap_SetEnabled Enables or disables GuildMateMap. Will unregister events
-- **
function GuildMateMap_SetEnabled ( enable )
	GuildMateMapPrefs.enabled = enable;
	GuildMateMap_ChatMessage( "GuildMateMap Enabled is "..tostring(enable) );
	local GuildMateFrame = getglobal("GuildMateMapFrame" );
	if ( enable ) then
		GuildMateFrame:RegisterEvent( "CHAT_MSG_ADDON" );
		GuildMateFrame:RegisterEvent( "PLAYER_LEVEL_UP" );
		GuildMateFrame:RegisterEvent( "PLAYER_LEAVING_WORLD");
		GuildMateFrame:RegisterEvent( "WORLD_MAP_UPDATE" );
		GuildMateFrame:RegisterEvent( "MINIMAP_UPDATE_ZOOM" );
		GuildMateFrame:RegisterEvent( "MINIMAP_ZONE_CHANGED" );
		GuildMateFrame:RegisterEvent( "PARTY_MEMBERS_CHANGED" );
		GuildMateMap_DrawWorldMap();
		GuildMateMap_DrawMiniMap();
	else
		GuildMateFrame:UnregisterEvent( "CHAT_MSG_ADDON" );
		GuildMateFrame:UnregisterEvent( "PLAYER_LEVEL_UP" );
		GuildMateFrame:UnregisterEvent( "PLAYER_LEAVING_WORLD");
		GuildMateFrame:UnregisterEvent( "WORLD_MAP_UPDATE" );
		GuildMateFrame:UnregisterEvent( "PARTY_MEMBERS_CHANGED" );
		GuildMateFrame:UnregisterEvent( "MINIMAP_ZONE_CHANGED" );
		GuildMateMap_HideGuildMates( 1, "GuildMateMap", GuildMateMap_MAX_MAP_ICONS );
		GuildMateMap_HideGuildMates( 1, "GuildMateMiniMap", GuildMateMap_MAX_MINI_MAP_ICONS );
		
	end
end


-- **
-- * function GuildMateMap_printGuildies -- Print the current list of members being tracked
-- **
function GuildMateMap_printGuildies( )
	
	for zone, info in GuildMateMap_GuldMates do
		local data = tostring(zone).."-->";
		data = data.."Name: "..info.name.." Class: "..info.class;
		data = data.." Level: "..info.level.." Rank: "..info.rank.." Continent: "..info.continent;
		data = data.." Zone: "..info.zone.." PosX "..info.x.." PosY "..info.y;
		GuildMateMap_ChatMessage( data );
	end
end

-- **
-- * function GuildMateMap_info -- Print out our slash commands
-- **
function GuildMateMap_info()
    GuildMateMap_ChatMessage( GuildMateMapIntro );
	GuildMateMap_ChatMessage( GuildMateMapClickInfo );
	GuildMateMap_ChatMessage( GuildMateMap_LOADED_TEXT );
	GuildMateMap_ChatMessage( GuildMateMapParameters );
	GuildMateMap_ChatMessage( GuildMateMapDebug );
	GuildMateMap_ChatMessage( GuildMateMapEnable );
	GuildMateMap_ChatMessage( GuildMateMapMsgLvl );
	GuildMateMap_ChatMessage( GuildMateMapPrint );
	GuildMateMap_ChatMessage( GuildMateMapClear );
	GuildMateMap_ChatMessage( GuildMateMapMates );
end

-- **
-- * function GuildMateMap_DrawWorldMap -- Draws our guildmates on the worldmap
-- **
function GuildMateMap_DrawWorldMap() 

	-- if the map isn't open don't do anything.
	if (not WorldMapFrame:IsVisible()) then
		return;
	end
	
	local currentIcon = 1;	
	
	local mapContinent = GetCurrentMapContinent();
	local mapZone = GetCurrentMapZone();
	
	if ( mapContinent < 0 ) then
		-- We are in a battleground if our guildmates are with us we
		-- don't care about their position
		GuildMateMap_HideGuildMates( 1, "GuildMateMap", GuildMateMap_MAX_MAP_ICONS );
		return;
	end
	

	GuildMateMap_DebugMessage("Drawing map for Continent: " .. mapContinent .. " Zone: " .. mapZone);

	for index, guildMate in GuildMateMap_GuldMates do

		GuildMateMap_DebugMessage("Drawing GuildMate "..guildMate.name.." located on continent "..guildMate.continent.." zone "..guildMate.zone);
		local mnX,mnY;
		local playerX = guildMate.x;
		local playerY = guildMate.y;
		local showMate = true;
		
		local notPartyMember = true;
		if ( GuildMateMap_GroupMembers ~= nil and GuildMateMap_GroupMembers[guildMate.name] ~= nil) then
			notPartyMember = false;
		end
		
		GuildMateMap_DebugMessage("Guild mate: ".. guildMate.name.." is in party : "..tostring(partyMember));
		if ( (not (playerX == 0 and playerY == 0) and (guildMate.continent > 0 and guildMate.continent < 3)) and notPartyMember ) then -- Player is in an instance or unknown location
			-- world map
			if ( mapContinent == 0  ) then -- MapType if begin
			
				local absx, absy = GuildMateMap_LocalToAbs(guildMate.continent, guildMate.zone, playerX, playerY);
				local worldx, worldy = GuildMateMap_LocalToAbs(guildMate.continent, 0, absx, absy);
		
				mnX = worldx * WorldMapDetailFrame:GetWidth();
				mnY = -worldy * WorldMapDetailFrame:GetHeight();
			elseif (mapZone == 0) then -- Continent Map
				-- Only display mates on our continent
				if (guildMate.continent == mapContinent) then
					local absx, absy = GuildMateMap_LocalToAbs(guildMate.continent, guildMate.zone, playerX, playerY);
					mnX = absx * WorldMapDetailFrame:GetWidth();
					mnY = -absy * WorldMapDetailFrame:GetHeight();
				else
					showMate = false;
				end
			else -- Zone Map
				if (guildMate.continent == mapContinent) then
					
					if (guildMate.zone ~= mapZone) then
						-- players which are not directly in the zone have to be checked too
						-- example: map of Mulgore should still show people in thunder bluff (though different zone)
						 local absx, absy = GuildMateMap_LocalToAbs(guildMate.continent, guildMate.zone, playerX, playerY);
						 playerX, playerY = GuildMateMap_AbsToLocal(mapContinent, mapZone, absx, absy);
					end
		
					-- only use players that are really visible
					if (playerX >= 0 and playerX <= 1 and playerY >= 0 and playerY <= 1) then
						
						mnX = playerX * WorldMapDetailFrame:GetWidth();
						mnY = -playerY * WorldMapDetailFrame:GetHeight();
					end				
				else
					showMate = false;
				end
			end -- MapType if end
		end -- Player in Instance
		
		-- Now display the guildMate
		if ( showMate ) then
			local mateIcon = getglobal("GuildMateMap" .. currentIcon);
			local guildMateTexture = getglobal("GuildMateMap" .. currentIcon .. "Texture");
		
			-- GuildMateMap_DebugMessage( "Setting icon for "..guildMate.name.." at "..mnX..","..mnY );
			mateIcon:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", mnX, mnY);
			local iconName = "MiniMapIcon"..GuildMateMapClasses[guildMate.class];
			guildMateTexture:SetTexture("Interface\\AddOns\\GuildMateMap\\images\\"..iconName);
			mateIcon:Show();

			mateIcon.guildMate = guildMate;

			currentIcon = currentIcon + 1;
		end
		
		if (currentIcon == GuildMateMap_MAX_MAP_ICONS) then
			break;
		end
	end
	
	-- Hide the rest of the icons
	GuildMateMap_HideGuildMates( currentIcon, "GuildMateMap", GuildMateMap_MAX_MAP_ICONS );

end

function GuildMateMap_HideGuildMates( startIndex, iconPrefix, maxNumIcons )

	for i = startIndex, maxNumIcons do
		local guildMateIcon = getglobal(iconPrefix .. i);
		if ( guildMateIcon ~= nil ) then
			guildMateIcon:Hide();
		end
	end

end

function GuildMateMap_ShowToolTip()
	-- determine tooltip anchor
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		WorldMapTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end	
	
	WorldMapTooltip:SetText(" "..this.guildMate.name.." ("..this.guildMate.level.." "..this.guildMate.class..") ", 1.0, 0.82, 0.0, 1,1);
	WorldMapTooltip:Show();
	
end

function GuildMateMap_ShowMiniMapToolTip()
	-- If the popup menu is open don't show the tooltip
	if (not GuildMateMap_Popup:IsVisible()) then
		GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
		GameTooltip:SetText(this.guildMate.name, 1.0, 0.82, 0.0, 1,1);
		
		GameTooltip:AddLine("("..this.guildMate.level..") "..this.guildMate.class, 
			GuildMateMapClassColor[GuildMateMapClasses[this.guildMate.class]].r, 
			GuildMateMapClassColor[GuildMateMapClasses[this.guildMate.class]].g, 
			GuildMateMapClassColor[GuildMateMapClasses[this.guildMate.class]].b);
		
		-- Now add the guild rank to the bottom. Color them in the future.
			GameTooltip:AddLine( this.guildMate.rank, 1.0, 0.82, 0.0 );
	
		GameTooltip:Show();
	end
end

-- **
-- * GuildMateMap_UpdatePartyMembers keeps track of our current party members.
-- **
function GuildMateMap_UpdatePartyMembers()
	local numGroupMembers = GetNumPartyMembers();
	if ( numGroupMembers > 0 ) then
		GuildMateMap_GroupMembers = {};
		-- We are in a party or raid so check the members to see if they match this member...
		local unitPrefix = "party";
		if ( UnitInRaid("player") ) then
			numGroupMembers = GetNumRaidMembers();
			unitPrefix = "raid";
		end
		
		for i = 1, numGroupMembers do
			GuildMateMap_GroupMembers[UnitName(unitPrefix..tostring(i))] = i;
		end
		if ( GuildMateMapPrefs.debug ) then
			
			for memberName, index in  GuildMateMap_GroupMembers do
				GuildMateMap_DebugMessage("GroupMember "..tostring(index).." "..memberName);
			end
		end
		
		
	else
		GuildMateMap_GroupMembers = nil;
	end
end
-- **
-- * function GuildMateMap_DrawWorldMap -- Draws our guildmates on the worldmap
-- **
function GuildMateMap_DrawMiniMap() 
	-- GuildMateMap_DebugMessage("Drawing minimap");
	
	local currentIcon = 1;
	local hideMiniIcons = false;
	-- hide mates if we are displaying a continent or world on the main map
	-- We are having really weird position issues when this happens.
	if ( WorldMapFrame:IsVisible() and (GetCurrentMapContinent() == 0 or GetCurrentMapZone() == 0)) then
		hideMiniIcons = true;
	end
	
	-- If we don't know where we are don't draw. -1 == BG, > 2 is unknown.
	-- 0 is in an instance and we don't want to draw our minimap when in an instance
	if ( this.playerContinent == nil or this.playerContinent < 1 or this.playerContinent > 2 or hideMiniIcons ) then
		GuildMateMap_HideGuildMates(currentIcon, "GuildMateMiniMap", GuildMateMap_MAX_MINI_MAP_ICONS);
		return;
	end
	
	GuildMateMap_UpdatePlayerPosition();
	
	
	for index, guildMate in GuildMateMap_GuldMates do
		local partyMember = false;
		if ( GuildMateMap_GroupMembers ~= nil and GuildMateMap_GroupMembers[guildMate.name] ~= nil) then
			partyMember = true;
		end
		
		local x = this.playerX;
		local y = this.playerY;
		local playerContinent = this.playerContinent;
		local playerZone = this.playerZone;
		
		if ( not partyMember and playerContinent == guildMate.continent) then

			local guildMateX = guildMate.x;
			local guildMateY = guildMate.y;

			if (guildMate.zone ~= playerZone) then
				local absx, absy = GuildMateMap_LocalToAbs(guildMate.continent, guildMate.zone, guildMateX, guildMateY);
				guildMateX, guildMateY = GuildMateMap_AbsToLocal(playerContinent, playerZone, absx, absy);
			end
			
			local miniMapZoom = Minimap:GetZoom();
			if ( miniMapZoom == nil ) then
				return; -- We need this value and if we can't get it we'll wait until we can.
			end

			local xscale = GuildMateMap_Const[playerContinent][miniMapZoom].xscale;
			local yscale = GuildMateMap_Const[playerContinent][miniMapZoom].yscale;
			if (this.isInCity) then
				xscale = xscale * GuildMateMap_Const[2][miniMapZoom].cityscale;
				yscale = yscale * GuildMateMap_Const[2][miniMapZoom].cityscale;
			end
			
			local xpos = guildMateX * GuildMateMap_Const[playerContinent][playerZone].scale + GuildMateMap_Const[playerContinent][playerZone].xoffset;
			local ypos = guildMateY * GuildMateMap_Const[playerContinent][playerZone].scale + GuildMateMap_Const[playerContinent][playerZone].yoffset;

			x = x * GuildMateMap_Const[playerContinent][playerZone].scale + GuildMateMap_Const[playerContinent][playerZone].xoffset;
			y = y * GuildMateMap_Const[playerContinent][playerZone].scale + GuildMateMap_Const[playerContinent][playerZone].yoffset;


			local deltax = (xpos - x) * xscale;
			local deltay = (y - ypos) * yscale;

			local guildMateIcon = getglobal("GuildMateMiniMap" .. currentIcon);
			local guildMateTexture = getglobal("GuildMateMiniMap" .. currentIcon .. "Texture");
			
			local distFromCenter = sqrt((deltax * deltax) + (deltay * deltay));
			
			local showMate = true;
			if (distFromCenter > GuildMateMapPrefs.miniMapCircDist and distFromCenter < GuildMateMapPrefs.maxMiniMapDist ) then
				deltax = deltax * GuildMateMapPrefs.miniMapCircDist / distFromCenter;
				deltay = deltay * GuildMateMapPrefs.miniMapCircDist / distFromCenter;
				
			elseif (distFromCenter > GuildMateMapPrefs.miniMapCircDist) then
				showMate = false;				
			end
			
			if ( showMate ) then
			
				local iconName = "MiniMapIcon"..GuildMateMapClasses[guildMate.class];
				guildMateTexture:SetTexture("Interface\\AddOns\\GuildMateMap\\images\\"..iconName);
	
				guildMateIcon:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107 + deltax, -92 + deltay);
				guildMateIcon:Show();
				guildMateIcon.guildMate = guildMate;
				currentIcon = currentIcon + 1;
			
			end
		
		end

		-- no more than 75 players on mini map
		if (currentIcon == GuildMateMap_MAX_MINI_MAP_ICONS) then
			break;
		end
		
	end
	
	GuildMateMap_HideGuildMates(currentIcon, "GuildMateMiniMap", GuildMateMap_MAX_MINI_MAP_ICONS);
	
end

function GuildMateMap_OnClickMini(arg1)
	-- If the user left clicks on a guildmate in the minimap
	-- target that user.
	if ( arg1 == "LeftButton" ) then
		TargetByName( this.guildMate.name );
	else
		GuildMateMap_ShowPopup(this.guildMate);
	end
end

function GuildMateMap_OnClickMate(arg1)
	-- If the user left clicks on a guildmate in the minimap
	-- target that user.
	if ( arg1 == "LeftButton" ) then
		ChatFrame_SendTell(this.guildMate.name);
	else
		InviteByName( this.guildMate.name );
	end
end
-- *******************************************************************************************************
-- * The following  constants and functions were written by Bru on Blackhand(DE) - wow@docbru.de
-- * See his addon that is almost identical, named GuildMap that I didn't know existed until I was 90% done
-- * with this addon... :-(
-- * 
-- *******************************************************************************************************

GuildMateMap_Const = {};
GuildMateMap_Const[1] = {};
GuildMateMap_Const[2] = {};
-- first approach with some inaccurate coordinates for the world map
-- GuildMateMap_Const[1][0] = { xscale = 11016.6, yscale = 7399.9 };
GuildMateMap_Const[1][0] = {  scale = 0.825, xoffset = -0.19, yoffset = 0.06, xscale = 11016.6, yscale = 7399.9 };
GuildMateMap_Const[1][1] = {  scale = 0.15670371525706, xoffset = 0.41757282062541, yoffset = 0.33126468682991, xscale = 12897.3, yscale = 8638.1 };
GuildMateMap_Const[1][2] = {  scale = 0.13779501505279, xoffset = 0.55282036918049, yoffset = 0.30400571307545, xscale = 15478.8, yscale = 10368.0 };
GuildMateMap_Const[1][3] = {  scale = 0.17799008894522, xoffset = 0.38383175154516, yoffset = 0.18206216123156, xscale = 19321.8, yscale = 12992.7 };
GuildMateMap_Const[1][4] = {  scale = 0.02876626176374, xoffset = 0.38392150175204, yoffset = 0.10441296545475, xscale = 25650.4, yscale = 17253.2 };
GuildMateMap_Const[1][5] = {  scale = 0.12219839120669, xoffset = 0.34873187115693, yoffset = 0.50331046935371, xscale = 38787.7, yscale = 26032.1 };
GuildMateMap_Const[1][6] = {  scale = 0.14368294970080, xoffset = 0.51709782709100, yoffset = 0.44802818134926 };
GuildMateMap_Const[1][7] = {  scale = 0.14266384095509, xoffset = 0.49026338351379, yoffset = 0.60461876174686 };
GuildMateMap_Const[1][8] = {  scale = 0.15625084006464, xoffset = 0.41995800144849, yoffset = 0.23097545880609 };
GuildMateMap_Const[1][9] = {  scale = 0.18885970960818, xoffset = 0.31589651244686, yoffset = 0.61820581746798 };
GuildMateMap_Const[1][10] = { scale = 0.06292695969921, xoffset = 0.50130287793373, yoffset = 0.17560823085517 };
GuildMateMap_Const[1][11] = { scale = 0.13960673216274, xoffset = 0.40811854919226, yoffset = 0.53286226907346 };
GuildMateMap_Const[1][12] = { scale = 0.03811449638057, xoffset = 0.56378554142668, yoffset = 0.42905218646258 };
GuildMateMap_Const[1][13] = { scale = 0.09468465888932, xoffset = 0.39731975488374, yoffset = 0.76460608512626 };
GuildMateMap_Const[1][14] = { scale = 0.13272833611061, xoffset = 0.37556627748617, yoffset = 0.40285135292988 };
GuildMateMap_Const[1][15] = { scale = 0.18750104661175, xoffset = 0.46971301480866, yoffset = 0.76120931364891 };
GuildMateMap_Const[1][16] = { scale = 0.13836131003639, xoffset = 0.36011098024729, yoffset = 0.03948322979210 };
GuildMateMap_Const[1][17] = { scale = 0.27539211944292, xoffset = 0.39249347333450, yoffset = 0.45601063260257 };
GuildMateMap_Const[1][18] = { scale = 0.11956582877920, xoffset = 0.47554411191734, yoffset = 0.68342356389650 };
GuildMateMap_Const[1][19] = { scale = 0.02836291430658, xoffset = 0.44972878210917, yoffset = 0.55638479002362 };
GuildMateMap_Const[1][20] = { scale = 0.10054401185671, xoffset = 0.44927594451520, yoffset = 0.76494573629405 };
GuildMateMap_Const[1][21] = { scale = 0.19293573573141, xoffset = 0.47237382938446, yoffset = 0.17390990272233 };
-- first approach with some inaccurate coordinates for the world map
-- GuildMateMap_Const[2][0] = { xscale = 10448.3, yscale = 7072.7, cityscale = 1.565 };
GuildMateMap_Const[2][0] = {  scale = 0.77, xoffset = 0.38, yoffset = 0.09, xscale = 10448.3, yscale = 7072.7, cityscale = 1.565 };
GuildMateMap_Const[2][1] = {  scale = 0.07954563533736, xoffset = 0.43229874660542, yoffset = 0.25425926375262, xscale = 12160.5, yscale = 8197.8, cityscale = 1.687 };
GuildMateMap_Const[2][2] = {  scale = 0.10227310921644, xoffset = 0.47916793249546, yoffset = 0.32386170078419, xscale = 14703.1, yscale = 9825.0, cityscale = 1.882 };
GuildMateMap_Const[2][3] = {  scale = 0.07066771883566, xoffset = 0.51361415033147, yoffset = 0.56915717993261, xscale = 18568.7, yscale = 12472.2, cityscale = 2.210 };
GuildMateMap_Const[2][4] = {  scale = 0.09517074521836, xoffset = 0.48982154167011, yoffset = 0.76846519986510, xscale = 24390.3, yscale = 15628.5, cityscale = 2.575 };
GuildMateMap_Const[2][5] = {  scale = 0.08321525646393, xoffset = 0.04621224670174, yoffset = 0.61780780524905, xscale = 37012.2, yscale = 25130.6, cityscale = 2.651 };
GuildMateMap_Const[2][6] = {  scale = 0.07102298961531, xoffset = 0.47822105868635, yoffset = 0.73863555048516 };
GuildMateMap_Const[2][7] = {  scale = 0.13991525534426, xoffset = 0.40335096278072, yoffset = 0.48339696712179 };
GuildMateMap_Const[2][8] = {  scale = 0.07670475476181, xoffset = 0.43087243362495, yoffset = 0.73224350550454 };
GuildMateMap_Const[2][9] = {  scale = 0.10996723642661, xoffset = 0.51663255550387, yoffset = 0.15624753972085 };
GuildMateMap_Const[2][10] = { scale = 0.09860350595046, xoffset = 0.41092682316676, yoffset = 0.65651531970162 };
GuildMateMap_Const[2][11] = { scale = 0.09090931690055, xoffset = 0.42424361247460, yoffset = 0.30113436864162 };
GuildMateMap_Const[2][12] = { scale = 0.02248317426784, xoffset = 0.47481923366335, yoffset = 0.51289242617182 };
GuildMateMap_Const[2][13] = { scale = 0.07839152145224, xoffset = 0.51118749188138, yoffset = 0.50940913489577 };
GuildMateMap_Const[2][14] = { scale = 0.06170112311456, xoffset = 0.49917278340928, yoffset = 0.68359285304999 };
GuildMateMap_Const[2][15] = { scale = 0.06338794005823, xoffset = 0.46372051266487, yoffset = 0.57812379382509 };
GuildMateMap_Const[2][16] = { scale = 0.11931848806212, xoffset = 0.35653502290090, yoffset = 0.24715695496522 };
GuildMateMap_Const[2][17] = { scale = 0.03819701270887, xoffset = 0.41531450060561, yoffset = 0.67097280492581 };
GuildMateMap_Const[2][18] = { scale = 0.18128603034401, xoffset = 0.39145470225916, yoffset = 0.79412224886668 };
GuildMateMap_Const[2][19] = { scale = 0.06516347991404, xoffset = 0.51769795272070, yoffset = 0.72815974701615 };
GuildMateMap_Const[2][20] = { scale = 0.10937523495111, xoffset = 0.49929119700867, yoffset = 0.25567971676068 };
GuildMateMap_Const[2][21] = { scale = 0.12837403412087, xoffset = 0.36837217317549, yoffset = 0.15464954319582 };
GuildMateMap_Const[2][22] = { scale = 0.02727719546939, xoffset = 0.42973999245660, yoffset = 0.23815358517831 };
GuildMateMap_Const[2][23] = { scale = 0.12215946583965, xoffset = 0.44270955019641, yoffset = 0.17471356786018 };
GuildMateMap_Const[2][24] = { scale = 0.09943208435841, xoffset = 0.36884571674582, yoffset = 0.71874918595783 };
GuildMateMap_Const[2][25] = { scale = 0.11745423014662, xoffset = 0.46561438951659, yoffset = 0.40971063365152 };


function GuildMateMap_LocalToAbs(continent, zone, localx, localy)
	local absx = localx;
	local absy = localy;
	absx = localx * GuildMateMap_Const[continent][zone].scale + GuildMateMap_Const[continent][zone].xoffset;
	absy = localy * GuildMateMap_Const[continent][zone].scale + GuildMateMap_Const[continent][zone].yoffset;
	return absx, absy;
end

function GuildMateMap_AbsToLocal(continent, zone, absx, absy)
	local localx = (absx - GuildMateMap_Const[continent][zone].xoffset) / GuildMateMap_Const[continent][zone].scale;
	local localy = (absy - GuildMateMap_Const[continent][zone].yoffset) / GuildMateMap_Const[continent][zone].scale;
	return localx, localy;
end



-- **
-- *
-- **
function GuildMateMap_InitializeMenu( guildMate )

	-- Set the text for the buttons while keeping track of how many
	-- buttons we actually need.
	GuildMateMap_DebugMessage("InitMenu");
	
	GuildMateMap_TitleButton:SetText( guildMate.name );
	GuildMateMap_TitleButton:Disable();
	
	local count = 1;
	for index, buttonText in GuildMateMapMiniMapPopupButtons do
		local button = getglobal("GuildMateMap_PopupButton"..index);
		
		if ( buttonText ~= "" ) then
			button:SetText(buttonText);
			button.memberName = guildMate.name;
			button.actionIndex = index;
		end
		button:Show();
		count = index;
	end
	
	-- Set the width for the menu.
	local width = GuildMateMap_TitleButton:GetWidth();
	for i = 1, count do
		GuildMateMap_DebugMessage("width max: "..width);
		width = math.max(width, getglobal("GuildMateMap_PopupButton"..i):GetTextWidth());
	end
	GuildMateMap_Popup:SetWidth(width + 2 * 30);

	-- By default, the width of the button is set to the width of the text
	-- on the button.  Set the width of each button to the width of the
	-- menu so that you can still click on it without being directly
	-- over the text.
	for i = 1, count do
		getglobal("GuildMateMap_PopupButton"..i):SetWidth(width);
	end

	-- Set the height for the menu.
	GuildMateMap_Popup:SetHeight(12 + ((count + 1) * 12) + (3 * 12));
end


function GuildMateMap_OptionButtonClick()
	if (this.actionIndex == 3 ) then -- Follow
		FollowByName(this.memberName);
	elseif ( this.actionIndex == 2 ) then
		ChatFrame_SendTell(this.memberName);
	elseif (this.actionIndex == 1 ) then -- Invite
		InviteByName( this.memberName );
	end
	
	GuildMateMap_Popup:Hide();
end



-- ******************************************************************
function GuildMateMap_ShowPopup(guildMate)
	
	GuildMateMap_DebugMessage("Showing menu for "..guildMate.name);
	
	GameTooltip:Hide();
	if (GuildMateMap_Popup:IsVisible()) then
		GuildMateMap_DebugMessage("menu is visible returning...");
		GuildMateMap_Popup:Hide();
		return;
	else
		GuildMateMap_InitializeMenu( guildMate );
	end

		-- Get the cursor position.  Point is relative to the bottom left corner of the screen.
	local x, y = GetCursorPosition();

	local anchor = "topright";
	
	GuildMateMap_DebugMessage("menu is being displayed with anchor: "..anchor.." x:"..x.." y:"..y);
	
	
	-- Adjust for the UI scale.
	x = x / UIParent:GetEffectiveScale();
	y = y / UIParent:GetEffectiveScale();

	-- Adjust for the height/width/anchor of the menu.
	if (anchor == "topright") then
		x = x - GuildMateMap_Popup:GetWidth();
		y = y - GuildMateMap_Popup:GetHeight();
	elseif (anchor == "topleft") then
		y = y - GuildMateMap_Popup:GetHeight();
	elseif (anchor == "bottomright") then
		x = x - GuildMateMap_Popup:GetWidth();
	elseif (anchor == "bottomleft") then
		-- do nothing.
	else
		-- anchor is either "center" or not a valid value.
		 x = x - GuildMateMap_Popup:GetWidth() / 2;
		 y = y - GuildMateMap_Popup:GetHeight() / 2;
	end
	GuildMateMap_DebugMessage("New Point is x:"..x.." y:"..y);

	-- Clear the current anchor point, and set it to be centered under the mouse.
	GuildMateMap_Popup:ClearAllPoints();
	GuildMateMap_Popup:SetPoint("BOTTOMLEFT", "UIParent", "BOTTOMLEFT", x, y);
	
	GuildMateMap_Popup:Show();
end

function GuildMateMap_HidePopup()
	-- GuildMateMap_Popup:Hide();
	-- find out if the mouse is still in our bounds.
end
