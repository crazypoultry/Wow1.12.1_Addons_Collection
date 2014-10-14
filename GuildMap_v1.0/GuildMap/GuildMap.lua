-- GuildMap by Bru on Blackhand(DE) - wow@docbru.de
GUILDMAP_VERSION = "1.0";

-- Change History
--
-- Current Version:
-- 1.0:    New: GuildMap is now using the 1.12 addon messaging. No chat channel is required anymore.
--         Fix: German zone offsets
--         Chg: Updated interface version to 11200
-- 0.9.9:  New: GuildMap is not limited to guilds anymore, communication channel can now be set.
--              This allows to use it with your friends also, or within united guilds.
--         New: Configuration options (/guildmap slash command)
--         New: Minimap arrows and new (green) minimap icon
--         New: Included version number tracking, this may be used in later versions for new features
--         Chg: Updated interface version to 1700
--         Chg: Initialization changed, chat channel should start up faster and not grab /1 anymore
--         Chg: Better (faster) detection of new players online and players leaving
--         Chg: Increased number of allowed minimap icons from 25 to 75 (due to new arrow concept)
--         Chg: Lots of other changes under the hood which should make GuildMap more stable and reliable
--         Fix: Minimap does now show people which are near, but in different zone (like Orgrimmar - Durotar)
--         Fix: French zone offsets
-- 0.9.6b: Chg: Slightly modified the minimap fading for people out of range
--         New: Right-Click guild members on the minimap to target them
-- 0.9.6:  New: People that are near you but not in the minimap range are also displayed 
--              with fading color depending on the distance.
--         Fix: Raid and Party members of your guild should not show up twice anymore.
--         Fix: Very long guild names should now work
--         Fix: Sometimes the addon could not join chat channel which could cause server disconnects.
--              Reason unclear yet. The addon will now disable itself instead of retrying forever.
--         Fix: Worldmap Tooltip should now also show over villages / cities
-- 0.9.5b: Updated interface version
-- 0.9.5:  Initial release for public beta test
-- 
-- Old Versions:
-- 0.9 - 0.9.3b: Clan internal alpha test releases

-- Credits go to the developer(s) of MapNotes for their region data table
-- which helped me to start this addon without testing out every single zone.


-- seconds after which the UI shall be repainted
GUILDMAP_UPDATE_INTERVAL = 0.25;

-- seconds after which the init process is re-triggered
GUILDMAP_INIT_INTERVAL = 1.0;


-- loglevel
GUILDMAP_LOGLEVEL_TRACE = 1;
GUILDMAP_LOGLEVEL_DEBUG = 2;
GUILDMAP_LOGLEVEL_NONE = 5;
GUILDMAP_LOGLEVEL = GUILDMAP_LOGLEVEL_NONE;

-- seconds to wait between announces when a player is moving
GUILDMAP_EARLIEST_ANNOUNCE = 3.0;
-- seconds after which an announce must take place when a player is standing still
GUILDMAP_LATEST_ANNOUNCE = 30.0;

-- seconds after which a player without updated status info will be removed
GUILDMAP_PLAYER_TIMEOUT = 45.0;

-- constants (do not modify)
GUILDMAP_MAX_MINIMAP_ICONS = 75;
GUILDMAP_MAX_WORLDMAP_ICONS = 250;


-- main temporary data table
GuildMapData = {
	self = {continent = 0, zone = 0, x = 0, y = 0, inCity = false},
	lastAnnounce = 0,
	announceVersion = true,
	pendingAnnounce = false,
	players = {},
	worldMapOpen = false,
	jobs = {},
};

-- permanent data saved to disk
GuildMapPermData = {};

-- current player's config
GuildMapConfig = {};


function GuildMap_OnLoad()

	-- GuildMap_SetupDummies();
	
	GuildMap_InitRegionData();
	
	this:RegisterEvent("CHAT_MSG_ADDON");
	this:RegisterEvent("MINIMAP_UPDATE_ZOOM");
	this:RegisterEvent("WORLD_MAP_UPDATE");
	this:RegisterEvent("RAID_ROSTER_UPDATE");
	this:RegisterEvent("PARTY_MEMBERS_CHANGED");	
	this:RegisterEvent("VARIABLES_LOADED");
	
	SlashCmdList["GUILDMAP"] = GuildMap_SlashCommandHandler;
	SLASH_GUILDMAP1 = "/guildmap";
	SLASH_GUILDMAP2 = "/gmap";
	
	

end

function GuildMap_Init()


	GuildMap_SetupConfig();
	
	GuildMap_Schedule(GUILDMAP_UPDATE_INTERVAL, GuildMap_Update);

	local loadedMessage = string.format(GUILDMAP_TEXT_LOADED, GUILDMAP_VERSION);
	GuildMap_Print(loadedMessage);
	UIErrorsFrame:AddMessage(loadedMessage, 0.0, 1.0, 0.0, 1.0, UIERRORS_HOLD_TIME);

end




function GuildMap_OnEvent()

	if (event == "CHAT_MSG_ADDON") then
		GuildMap_ParseMessage(arg1, arg4, arg2);
	elseif (event == "VARIABLES_LOADED") then
		GuildMap_Init();
	elseif (event == "MINIMAP_UPDATE_ZOOM") then
		GuildMapData.self.inCity = GuildMap_IsMinimapInCity();
	elseif (event == "WORLD_MAP_UPDATE") then
		GuildMapData.worldMapOpen = GuildMap_IsWorldMapOpen();
		if (GuildMapData.worldMapOpen) then
			GuildMap_UpdateWorldMap();
		end
	elseif (event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED") then
		GuildMap_UpdatePartyOrRaid();
	end
end

function GuildMap_Print(msg, ...)
	if (DEFAULT_CHAT_FRAME) then
	
		for i = 1, arg.n, 1 do
			if ( arg[i] ) then
				msg = msg .. "#" .. i .. "=" .. arg[i];
			end
		end	
	
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00" .. msg);
	end
end

function GuildMap_Debug(msg)
	if (GUILDMAP_LOGLEVEL <= GUILDMAP_LOGLEVEL_DEBUG) then
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("|c000000ffGuildMap Debug: " .. msg);
		end
	end
end

function GuildMap_Trace(msg)
	if (GUILDMAP_LOGLEVEL <= GUILDMAP_LOGLEVEL_TRACE) then
		if (DEFAULT_CHAT_FRAME) then
			DEFAULT_CHAT_FRAME:AddMessage("|c00ccccccGuildMap Trace: " .. msg);
		end
	end
end


function GuildMap_IsWorldMapOpen()
	if (WorldMapFrame:IsVisible()) then
		return true;
	else
		return false;
	end
end


function GuildMap_UpdateWorldMap() 


	local currFrame = 1;	

	local currentContinent, currentZone = GuildMap_GetMapZone();
	
	-- there was a crash for battlegrounds (which return -1 for continent I think)
	if (currentContinent < 0 or currentContinent > 2) then
		for i = 1, GUILDMAP_MAX_WORLDMAP_ICONS do
			local poi = getglobal("GuildMapMain" .. i);
			poi:Hide();		
		end
		return;
	end
	

	GuildMap_Trace("Now drawing world map for " .. currentContinent .. " " .. currentZone);

	for player, playerData in GuildMapData.players do
	
		if (playerData.show) then

			-- world map
			if (currentContinent == 0) then

				local playerX = playerData.x / 10000;
				local playerY = playerData.y / 10000;
				local mnX,mnY;

				local absx, absy = GuildMap_LocalToAbs(playerData.continent, playerData.zone, playerX, playerY);
				local worldx, worldy = GuildMap_LocalToAbs(playerData.continent, 0, absx, absy);

				mnX = worldx * WorldMapDetailFrame:GetWidth();
				mnY = -worldy * WorldMapDetailFrame:GetHeight();

				local poi = getglobal("GuildMapMain" .. currFrame);
				poi:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", mnX, mnY);
				poi:Show();

				poi.unit = player;

				currFrame = currFrame + 1;		

			-- continent map
			elseif (currentZone == 0) then

				-- only players on the same continent are taken into account
				if (playerData.continent == currentContinent) then

					local playerX = playerData.x / 10000;
					local playerY = playerData.y / 10000;
					local mnX,mnY;

					local absx, absy = GuildMap_LocalToAbs(playerData.continent, playerData.zone, playerX, playerY);

					mnX = absx * WorldMapDetailFrame:GetWidth();
					mnY = -absy * WorldMapDetailFrame:GetHeight();

					local poi = getglobal("GuildMapMain" .. currFrame);
					poi:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", mnX, mnY);
					poi:Show();

					poi.unit = player;


					currFrame = currFrame + 1;

				end

			-- zone map
			else 

				-- only players on the same continent are taken into account
				if (playerData.continent == currentContinent) then

					local playerX = playerData.x / 10000;
					local playerY = playerData.y / 10000;
					if (playerData.zone ~= currentZone) then
						-- players which are not directly in the zone have to be checked too
						-- example: map of Mulgore should still show people in thunder bluff (though different zone)
						local absx, absy = GuildMap_LocalToAbs(playerData.continent, playerData.zone, playerX, playerY);
						playerX, playerY = GuildMap_AbsToLocal(currentContinent, currentZone, absx, absy);
					end



					-- only use players that are really visible
					if (playerX >= 0 and playerX <= 1 and playerY >= 0 and playerY <= 1) then
						local mnX,mnY;
						mnX = playerX * WorldMapDetailFrame:GetWidth();
						mnY = -playerY * WorldMapDetailFrame:GetHeight();

						local poi = getglobal("GuildMapMain" .. currFrame);
						poi:SetPoint("CENTER", "WorldMapDetailFrame", "TOPLEFT", mnX, mnY);
						poi:Show();

						poi.unit = player;

						currFrame = currFrame + 1;
					end				

				end

			end
		
		end
		
		-- no more than 250 players on world map
		if (currFrame == GUILDMAP_MAX_WORLDMAP_ICONS) then
			break;
		end

	end

	for i = currFrame, GUILDMAP_MAX_WORLDMAP_ICONS do
		local poi = getglobal("GuildMapMain" .. i);
		poi:Hide();		
	end


end


function GuildMap_UpdateMiniMap()

	local currFrame = 1;	

	local continent = GuildMapData.self.continent;
	local zone = GuildMapData.self.zone;
	
	if (continent < 0 or continent > 2) then
		for i = 1, GUILDMAP_MAX_MINIMAP_ICONS do
			local poi = getglobal("GuildMapMini" .. i);
			poi:Hide();		
		end
		return;
	end


	for player, playerData in GuildMapData.players do
	

		if (playerData.show and continent == playerData.continent) then

			local x = GuildMapData.self.x / 10000;
			local y = GuildMapData.self.y / 10000;

			local playerX = playerData.x / 10000;
			local playerY = playerData.y / 10000;


			if (playerData.zone ~= zone) then
				local absx, absy = GuildMap_LocalToAbs(playerData.continent, playerData.zone, playerX, playerY);
				playerX, playerY = GuildMap_AbsToLocal(continent, zone, absx, absy);
			end
			

			local xscale = GuildMap_Const[continent][Minimap:GetZoom()].xscale;
			local yscale = GuildMap_Const[continent][Minimap:GetZoom()].yscale;
			if (GuildMapData.self.inCity) then
				xscale = xscale * GuildMap_Const[2][Minimap:GetZoom()].cityscale;
				yscale = yscale * GuildMap_Const[2][Minimap:GetZoom()].cityscale;
			end
			local xpos = playerX * GuildMap_Const[continent][zone].scale + GuildMap_Const[continent][zone].xoffset;
			local ypos = playerY * GuildMap_Const[continent][zone].scale + GuildMap_Const[continent][zone].yoffset;

			x = x * GuildMap_Const[continent][zone].scale + GuildMap_Const[continent][zone].xoffset;
			y = y * GuildMap_Const[continent][zone].scale + GuildMap_Const[continent][zone].yoffset;


			local deltax = (xpos - x) * xscale;
			local deltay = (y - ypos) * yscale;

			local poi = getglobal("GuildMapMini" .. currFrame);
			local poiTexture = getglobal("GuildMapMini" .. currFrame .. "Texture");
			
			local distFromCenter = sqrt((deltax * deltax) + (deltay * deltay));
			
			if (distFromCenter > 56.5 and distFromCenter < GuildMapConfig.mmDistance and GuildMapConfig.mmArrows) then
				deltax = deltax * 56.5 / distFromCenter;
				deltay = deltay * 56.5 / distFromCenter;
				poiTexture:SetTexture(GuildMap_Angle(deltax, deltay));

				poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107 + deltax, -92 + deltay);
				poi:Show();
				poi.unit = player;
				currFrame = currFrame + 1;
			elseif (distFromCenter < 56.5) then
				poiTexture:SetTexture("Interface\\AddOns\\GuildMap\\Images\\MiniMapIcon");

				poi:SetPoint("CENTER", "MinimapCluster", "TOPLEFT", 107 + deltax, -92 + deltay);
				poi:Show();
				poi.unit = player;
				currFrame = currFrame + 1;
			end
		
		end

		-- no more than 75 players on mini map
		if (currFrame == GUILDMAP_MAX_MINIMAP_ICONS) then
			break;
		end
		
	end
	
	
	for i = currFrame, GUILDMAP_MAX_MINIMAP_ICONS do
		local poi = getglobal("GuildMapMini" .. i);
		poi:Hide();		
	end
	
end




function GuildMap_OnUpdate(timeDelta) 	

	
	GuildMap_ExecutePendingJobs();
	
end

function GuildMap_Update() 	


	GuildMap_UpdatePartyOrRaid();

	local announceDelta = GetTime() - GuildMapData.lastAnnounce;


	local positionChanged = GuildMap_UpdatePlayerPos();
	-- an announce is scheduled if the player position has changed or 
	-- the maximum time without an announce was exceeded
	GuildMapData.pendingAnnounce =
		GuildMapData.pendingAnnounce or
		positionChanged or
		(announceDelta > GUILDMAP_LATEST_ANNOUNCE);

	if (GuildMapData.pendingAnnounce and announceDelta > GUILDMAP_EARLIEST_ANNOUNCE) then
		GuildMap_AnnouncePosition();
	end

	-- garbage collect timed out players
	GuildMap_RemoveOldPlayers();

	GuildMapData.worldMapOpen = GuildMap_IsWorldMapOpen();
	if (GuildMapData.worldMapOpen) then
		GuildMap_UpdateWorldMap();
	else
		GuildMap_EnsureZoneMap();
		GuildMap_UpdateMiniMap();
	end;
	
	GuildMap_Schedule(GUILDMAP_UPDATE_INTERVAL, GuildMap_Update);
end




function GuildMap_UpdatePlayerPos() 

	local continent, zone = GuildMap_GetCurrentZone();
	
	if (continent < 1 or continent > 2 or zone == 0) then
		return false;
	end
	
	local x, y = GetPlayerMapPosition("player");
	x = math.floor(x * 10000);
	y = math.floor(y * 10000);
	
	if (GuildMapData.self.x ~= x or
		GuildMapData.self.y ~= y) then

		GuildMapData.self.continent = continent;
		GuildMapData.self.zone = zone;
		GuildMapData.self.x = x;
		GuildMapData.self.y = y;

		return true;
	end
	
	return false;

end

function GuildMap_AnnouncePosition()
	if (GuildMap_IsValidPosition(GuildMapData.self.continent, GuildMapData.self.zone, GuildMapData.self.x, GuildMapData.self.y)) then 
		GuildMapData.pendingAnnounce = false;
		GuildMapData.lastAnnounce = GetTime();
		local message = "POS " .. GuildMapData.self.continent .. " " .. GuildMapData.self.zone .. " " .. GuildMapData.self.x .. " " .. GuildMapData.self.y;
		if (GuildMapData.announceVersion) then
			message = message .. "#V " .. GUILDMAP_VERSION;
			GuildMapData.announceVersion = false;
		end
		GuildMap_Broadcast(message);
	end
end


function GuildMap_Broadcast(message)
	local clearAFK = GetCVar("autoClearAFK");
	SetCVar("autoClearAFK", 0);
	if (IsInGuild()) then
		SendAddonMessage("GUILDMAP", message, "GUILD");
	end
	SetCVar("autoClearAFK", clearAFK);
end

function GuildMap_ParseMessage(channel, sender, message)

	-- other addon? return
	if (channel ~= "GUILDMAP") then
		return
	end

	-- do not care about messages from myself
	local playerName = UnitName("player");
	if (playerName and playerName == sender) then
		return;
	end

	if ( string.find(message, "#") ) then
		local arr = GuildMap_Split(message, "#");
		for k, v in arr do
			GuildMap_HandleMessage(sender, v);
		end
	else
		GuildMap_HandleMessage(sender, message);
	end

end

function GuildMap_HandleMessage(sender, message) 
	if (strsub(message, 1, 4) == "POS ") then
		GuildMap_HandlePosition(sender, message);
	elseif (strsub(message, 1, 2) == "V ") then
		GuildMap_HandleVersion(sender, message);
	end
end

function GuildMap_HandlePosition(sender, message)
	local useless, continent, zone, x, y;

	useless, useless, val1, val2, val3, val4 = string.find(message, "POS (%d+) (%d+) (%d+) (%d+)");
	if (val1 and val2 and val3 and val4) then

		-- perform some validations to prevent crashes later ;-)
		local tmpcont = tonumber(val1);
		local tmpzone = tonumber(val2);
		local tmpx = tonumber(val3);
		local tmpy = tonumber(val4);

		if (GuildMap_IsValidPosition(tmpcont, tmpzone, tmpx, tmpy)) then 
			if (GuildMapData.players[sender] == nil) then
				-- new player: announce 
				GuildMapData.announceVersion = true;
				GuildMapData.pendingAnnounce = true;
				GuildMapData.players[sender] = { continent = tmpcont, zone = tmpzone, x = tmpx, y = tmpy, lastUpdate = GetTime(), show = true};
			else
				-- if we have the player already, do update him only to not reset the show flag
				GuildMapData.players[sender].continent = tmpcont;
				GuildMapData.players[sender].zone = tmpzone;
				GuildMapData.players[sender].x = tmpx;
				GuildMapData.players[sender].y = tmpy;
				GuildMapData.players[sender].lastUpdate = GetTime();
			end
			GuildMap_Trace("Player Position " .. sender .. ": " .. val1 .. " " .. val2 .. " " .. val3 .. " " .. val4);
		end

	end
end

function GuildMap_HandleVersion(sender, message)
	local version = strsub(message, 3, strlen(message));
	if (GuildMapData.players[sender] ~= nil) then
		GuildMapData.players[sender].version = version;
	end
end

function GuildMap_MiniMap_OnClick(arg1)
	if (arg1 == "RightButton") then
		GuildMap_MiniMapAction(GuildMapConfig.mmRMB);
	else
		GuildMap_MiniMapAction(GuildMapConfig.mmLMB);
	end
end

function GuildMap_MiniMapAction(action)
	if (action == "TARGET") then
		TargetByName(this.unit);
	elseif (action == "PING") then
		-- ping thru
		local x, y = GetCursorPosition();
		x = x / Minimap:GetScale();
		y = y / Minimap:GetScale();

		local cx, cy = Minimap:GetCenter();
		x = x + CURSOR_OFFSET_X - cx;
		y = y + CURSOR_OFFSET_Y - cy;
		if ( sqrt(x * x + y * y) < (Minimap:GetWidth() / 2) ) then
			Minimap:PingLocation(x, y);
		end
	end
end


function GuildMap_RemoveOldPlayers()
	for player, playerData in GuildMapData.players do
		if (GetTime() - playerData.lastUpdate > GUILDMAP_PLAYER_TIMEOUT) then
			GuildMapData.players[player] = nil;
		end
	end	
end

function GuildMap_SetupDummies()
GuildMapData.players["Ashenvale"] = { continent = 1, zone = 1, x = 5000, y = 5000, lastUpdate = 10000000, show = true, show = true };
GuildMapData.players["Aszhara"] = { continent = 1, zone = 2, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Darkshore"] = { continent = 1, zone = 3, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Darnassis"] = { continent = 1, zone = 4, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Desolace"] = { continent = 1, zone = 5, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Durotar"] = { continent = 1, zone = 6, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Dustwallow"] = { continent = 1, zone = 7, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Felwood"] = { continent = 1, zone = 8, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Feralas"] = { continent = 1, zone = 9, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Moonglade"] = { continent = 1, zone = 10, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Mulgore"] = { continent = 1, zone = 11, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Orgrimmar"] = { continent = 1, zone = 12, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Silithus"] = { continent = 1, zone = 13, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["StonetalonMountains"] = { continent = 1, zone = 14, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Tanaris"] = { continent = 1, zone = 15, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Teldrassil"] = { continent = 1, zone = 16, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Barrens"] = { continent = 1, zone = 17, x = 5199, y = 4777, lastUpdate = 10000000, show = true };
GuildMapData.players["ThousandNeedles"] = { continent = 1, zone = 18, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["ThunderBluff"] = { continent = 1, zone = 19, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["UngoroCrater"] = { continent = 1, zone = 20, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Winterspring"] = { continent = 1, zone = 21, x = 5000, y = 5000, lastUpdate = 10000000, show = true };

GuildMapData.players["Alterac"] = { continent = 2, zone = 1, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Arathi"] = { continent = 2, zone = 2, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Badlands"] = { continent = 2, zone = 3, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["BlastedLands"] = { continent = 2, zone = 4, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["BurningSteppes"] = { continent = 2, zone = 5, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["DeadwindPass"] = { continent = 2, zone = 6, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["DunMorogh"] = { continent = 2, zone = 7, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Duskwood"] = { continent = 2, zone = 8, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["EasternPlaguelands"] = { continent = 2, zone = 9, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Elwynn"] = { continent = 2, zone = 10, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Hilsbrad"] = { continent = 2, zone = 11, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Ironforge"] = { continent = 2, zone = 12, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
	GuildMapData.players["Ironforge-Overlap"] = { continent = 2, zone = 12, x = 5010, y = 5010, lastUpdate = 10000000, show = true };
	GuildMapData.players["Ironforge-Test"] = { continent = 2, zone = 12, x = 2800, y = 6200, lastUpdate = 10000000, show = true };
GuildMapData.players["LochModan"] = { continent = 2, zone = 13, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Redridge"] = { continent = 2, zone = 14, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["SearingGorge"] = { continent = 2, zone = 15, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Silverpine"] = { continent = 2, zone = 16, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Stormwind"] = { continent = 2, zone = 17, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Stranglethorn"] = { continent = 2, zone = 18, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["SwampOfSorrows"] = { continent = 2, zone = 19, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Hinterlands"] = { continent = 2, zone = 20, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Tirisfal"] = { continent = 2, zone = 21, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Undercity"] = { continent = 2, zone = 22, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["WesternPlaguelands"] = { continent = 2, zone = 23, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Westfall"] = { continent = 2, zone = 24, x = 5000, y = 5000, lastUpdate = 10000000, show = true };
GuildMapData.players["Wetlands"] = { continent = 2, zone = 25, x = 5000, y = 5000, lastUpdate = 10000000, show = true };	
	
	
end


function GuildMap_IsValidPosition(continent, zone, x, y)

	if (continent < 1 or continent > 2) then
		return false;
	end
	if (continent == 1 and (zone < 1 or zone > 21)) then
		return false;
	end
	if (continent == 2 and (zone < 1 or zone > 26)) then
		return false;
	end
	
	if (x < 1 or x > 9999) then
		return false;
	end
	if (y < 1 or y > 9999) then
		return false;
	end	

	return true;

end

function GuildMap_ShowMiniMapToolTip()

	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");

	local unitButton;
	local newLineString = "";
	local tooltipText = "";
	
	for i=1, 25 do
		unitButton = getglobal("GuildMapMini"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			tooltipText = tooltipText .. newLineString .. unitButton.unit;
			newLineString = "\n";
		elseif (not unitButton:IsVisible()) then
			break;
		end
	end

	GameTooltip:SetText(tooltipText, 1.0, 0.82, 0.0, 1,1);
	GameTooltip:Show();
	
end

function GuildMap_ShowWorldMapToolTip()
	
	-- determine tooltip anchor
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		WorldMapTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		WorldMapTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end	
	
	local unitButton;
	local newLineString = "";
	local tooltipText = "";
	
	for i=1, 250 do
		unitButton = getglobal("GuildMapMain"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			tooltipText = tooltipText .. newLineString .. unitButton.unit;
			newLineString = "\n";
		elseif (not unitButton:IsVisible()) then
			break;
		end
	end

	WorldMapTooltip:SetText(tooltipText, 1.0, 0.82, 0.0, 1,1);
	WorldMapTooltip:Show();
	
end





function GuildMap_UpdatePartyOrRaid() 

	for player, playerData in GuildMapData.players do
		playerData.show = true;
	end	

	local numRaidMembers = GetNumRaidMembers();
	for i = 1, numRaidMembers do
		local name = GetRaidRosterInfo(i);
		if (name and GuildMapData.players[name]) then
			GuildMapData.players[name].show = false;	
		end
	end

	local numPartyMembers = GetNumPartyMembers();
	for i = 1, numPartyMembers do
		local name = UnitName("party" .. i);
		if (name and GuildMapData.players[name]) then
			GuildMapData.players[name].show = false;	
		end
	end

end



function GuildMap_Angle(x, y)
	local angle = asin(x / 56.5);
	if (x <= 0 and y <= 0) then
		angle = 180 - angle;
	elseif (x <= 0 and y > 0) then
		angle = 360 + angle;
	elseif (x > 0 and y >= 0) then
		angle = angle;
	else
		angle = 180 - angle;
	end
	local fileNumber = GuildMap_Round(angle / 10) * 10;
	if (fileNumber == 360) then
		fileNumber = 0;
	end
	
	return "Interface\\Addons\\GuildMap\\images\\MiniMapArrow" .. fileNumber;
end

-- Round function
function GuildMap_Round(x)
	return floor(x + 0.5);
end

function GuildMap_SlashCommandHandler()
	GuildMap_ShowOptions();
end



function GuildMap_Schedule(delay, delegate, ...)

	local job = {};
	job.due = delay + GetTime();
	job.delegate = delegate;
	job.args = arg;
	table.insert(GuildMapData.jobs, job);
  
end

function GuildMap_ExecutePendingJobs()
	local currentTime = GetTime();
	for key, job in GuildMapData.jobs do
		if (currentTime >= job.due) then
			if (job.args ~= nil) then
				job.delegate(unpack(job.args));
			else
				job.delegate();
			end
			GuildMapData.jobs[key] = nil;
		end
	end
end

function GuildMap_SetupConfig()
	local key = GetCVar("realmName") .. "-" .. UnitName("player");
	if (GuildMapPermData[key] == nil) then
		GuildMap_Print(GUILDMAP_FIRST_TIME_USAGE);
		GuildMapPermData[key] = {};
	end
	if (GuildMapPermData[key].mmArrows == nil) then
		GuildMapPermData[key].mmArrows = true;
	end
	if (GuildMapPermData[key].mmDistance == nil) then
		GuildMapPermData[key].mmDistance = 400;
	end
	if (GuildMapPermData[key].mmLMB == nil) then
		GuildMapPermData[key].mmLMB = "PING";
	end
	if (GuildMapPermData[key].mmRMB == nil) then
		GuildMapPermData[key].mmRMB = "TARGET";
	end
	
	GuildMapConfig = GuildMapPermData[key];
end




function GuildMap_CloneTable(t)
  local new = {};
  local i, v = next(t, nil);
  while i do
    new[i] = v
    i, v = next(t, i);
  end
  return new;
end


function GuildMap_Split(msg, char)
	local arr = { };
	while (string.find(msg, char) ) do
		local iStart, iEnd = string.find(msg, char);
		tinsert(arr, strsub(msg, 1, iStart-1));
		msg = strsub(msg, iEnd+1, strlen(msg));
	end
	if ( strlen(msg) > 0 ) then
		tinsert(arr, msg);
	end
	return arr;
end
