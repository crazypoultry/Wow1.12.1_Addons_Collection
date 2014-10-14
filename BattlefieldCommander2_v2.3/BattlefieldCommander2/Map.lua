
-- Initialize the BFC_Map namespace
BFC_Map = {};


BFC_ICON_NORMALPLAYER = "";
BFC_ICON_PARTYPLAYER = "";
BFC_ICON_DEADPLAYER = "";
BFC_ICON_COMBATPLAYER = "";


local BFC_GroupIcons = {
	"Interface\\Addons\\BattlefieldCommander2\\images\\group1",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group2",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group3",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group4",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group5",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group6",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group7",
	"Interface\\Addons\\BattlefieldCommander2\\images\\group8",
};

local BFC_MiscIcons = {
	combat = "Interface\\Addons\\BattlefieldCommander2\\images\\blip-fullred",
	locator = "Interface\\Addons\\BattlefieldCommander2\\images\\locator",
	radio = "Interface\\Addons\\BattlefieldCommander2\\images\\radio",
	dead = "Interface\\Addons\\BattlefieldCommander2\\images\\blip-black",
};

-- FIXME: refactor this crap
BFC_BATTLEFIELD_TAB_SHOW_DELAY = 0.1;
BFC_BATTLEFIELD_TAB_FADE_TIME = 0.15;
BFC_DEFAULT_BATTLEFIELD_TAB_ALPHA = 0.75;
BFC_DEFAULT_POI_ICON_SIZE = 12;
BFC_BATTLEFIELD_MINIMAP_UPDATE_RATE = 0.1;
BFC_NUM_BATTLEFIELDMAP_POIS = 0;
BFC_NUM_BATTLEFIELDMAP_OVERLAYS = 0;

BFC_Map.PlayersInCombat = {};
BFC_Map.RaidRoster = {};

-- Set a hook to prevent the stock minimap from loading
function BattlefieldMinimap_LoadUI_New()
end

BattlefieldMinimap_LoadUI = BattlefieldMinimap_LoadUI_New;



function BFC_Map.Init()
	-- Register the map-specific events
	BFC_Map_Frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	BFC_Map_Frame:RegisterEvent("PLAYER_LOGOUT");
	BFC_Map_Frame:RegisterEvent("WORLD_MAP_UPDATE");
	BFC_Map_Frame:RegisterEvent("RAID_ROSTER_UPDATE");
	BFC_Map_Frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
	BFC_Map_Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	BFC_Map_Frame:RegisterEvent("PLAYER_TARGET_CHANGED");
	
	-- Do some init stuff
	CreateMiniWorldMapArrowFrame(BFC_Map_Frame);
	BFC_Map.Viewport_Init();

	BFC_Map.updateTimer = 0;
	BFC_Map.colorUpdateTimer = 0;
	
	local position = BFC_Options.get("position");
	if (position) then
		BFC_Map_Tab:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", position.x, position.y);
		BFC_Map_Tab:SetUserPlaced(true);
	else
		BFC_Map_Tab:SetPoint("CENTER", "UIParent", "CENTER", 0,0);
	end
	
	local size = BFC_Options.get("size");
	if( size ~= nil) then
		BFC.Log(BFC.LOG_DEBUG, "Got size " .. size.w .. ", " .. size.h);
		BFC_Map_Container:SetWidth(size.w);
		BFC_Map_Container:SetHeight(size.h);
		--BFC.Log(BFC.LOG_WARN, "Got size " .. BFC_Map_Container:GetWidth() .. ", " .. BFC_Map_Container:GetHeight());
		--BFC_Map.SetVisible(true);
		BFC_Map.ResizeElements();
		--BFC_Map.SnapResizeAnchor();
		--BFC_Map.SetVisible(false);
		--BFC.Log(BFC.LOG_WARN, "Got size " .. BFC_Map_Container:GetWidth() .. ", " .. BFC_Map_Container:GetHeight());
	else
		BFC.Log(BFC.LOG_WARNING, "Got nil size");
	end

	UIDropDownMenu_Initialize(BFC_Map_TabDropDown, BFC_Map.TabDropDown_Initialize, "MENU");

	OpacityFrameSlider:SetValue(BFC_Options.get("opacity"));
	BFC_Map.SetOpacity();
	

	BFC_Map.SetNarrowMode(BFC_Options.get("narrow"));

	
	-- Register the slash commands
	SLASH_BFC1 = "/bfc";
	SlashCmdList["BFC"] = function(msg)
		BFC_Map.HandleSlashCommand(msg);
	end
	
	-- Register the comms commands
	BFC_Comms.RegisterMessage("MAP", "PING", BFC_Map.HandlePing);

end

function BFC_Map.OnEvent()
	if(event == "RAID_ROSTER_UPDATE") then
		BFC_Map.UpdateRaidRoster();
		BFC_Map.ColorizeRaidIcons();
		
	elseif(event == "PARTY_MEMBERS_CHANGED") then
		BFC_Map.UpdateRaidRoster();
		BFC_Map.ColorizeRaidIcons();
		
	elseif(event == "PLAYER_ENTERING_WORLD") then
		BFC_Map.UpdateRaidRoster();
		if(BFC_Options.get("autoShowBg") == true and MiniMapBattlefieldFrame.status == "active") then
			BFC_Map.SetVisible(true);
		elseif(MiniMapBattlefieldFrame.status ~= "active") then
			BFC_Map.SetVisible(false);
		elseif ( BFC_Map_Container:IsShown() ) then
			SetMapToCurrentZone();
		end
		
	elseif(event == "PLAYER_LOGOUT") then
		if (BFC_Map_Tab:IsUserPlaced()) then
			local position = {};
			position.x, position.y = BFC_Map_Tab:GetCenter();
			BFC_Options.set("position", position);
			
			local size = {};
			size.w = BFC_Map_Container:GetWidth();
			size.h = BFC_Map_Container:GetHeight();
			BFC_Options.set("size", size);
			
			BFC_Map_Tab:SetUserPlaced(false);
		else
			BFC_Options.set("position", nil);
		end
		
	elseif(event == "WORLD_MAP_UPDATE") then
		-- This is here to work around ZeppelinMaster
		-- (they keep diddling with the world map)
		continent = GetCurrentMapContinent();
		--BFC.Log(BFC.LOG_DEBUG, "got zone of " .. zone);
		if(continent ~= 0) then
			--BFC.Log(BFC.LOG_DEBUG, "detected zone change to " .. zone);
			--BFC_Map.currentZone = zone;
			BFC_Map.UpdateMap();
		end
	elseif(event == "ZONE_CHANGED_NEW_AREA") then
		--BFC.Log(BFC.LOG_DEBUG, "zone event: " .. event);
		if(BFC_Map_Container:IsShown()) then
			SetMapToCurrentZone();
			BFC_Map.UpdateMap();
		elseif(BFC_Options.get("autoShowBg") == true and MiniMapBattlefieldFrame.status == "active") then
			BFC_Map.SetVisible(true);
		end
	
	-- This is for the target indicator thinger on the map
	elseif(event == "PLAYER_TARGET_CHANGED") then
		if(UnitExists("target")) then
			BFC_Map.OnTargetChanged();
		end
	end
end


-- Slash command handlers
function BFC_Map.HandleSlashCommand(msg)
	if(msg == "reset") then
		BFC_Map.ResetPositionAndSize();
	end

	BFC_Map.SetVisible(true);

end


function BFC_Map.ToggleVisible()
	if ( BFC_Map_Container:IsVisible() ) then
		BFC_Map.SetVisible(false);
	else
		BFC_Map.SetVisible(true);
	end
end


function BFC_Map.SetVisible(vis)
	if(vis == true) then
		BFC_Map_Container:Show();
		BFC_Map_Frame:Show();
	else
		BFC_Map_Container:Hide();
		BFC_Map_Frame:Hide();
	end
end


function BFC_Map.ResetPositionAndSize()
	BFC_Map_Tab:ClearAllPoints();
	BFC_Map_Tab:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	BFC_Map_Tab:SetUserPlaced(true);

	local size = BFC_Options.get("size");
	BFC_Map_Container:SetWidth(size.w);
	BFC_Map_Container:SetHeight(size.h);
	
	BFC_Map.ResizeElements();
	BFC_Map.SnapResizeAnchor();
end


-- FIXME: Refactor this. ResizeElements should not handle most of the logic it does
function BFC_Map.UpdateMap()
	BFC_Map.ResizeElements();
	BFC_Map.SnapResizeAnchor();
	BFC_Map.ColorizeRaidIcons();
	
	return;
end

-- Convert an X-coordinate from widemode-space to narrowmode-space
function BFC_Map.GetScaledX(x, isNarrow)
	local width = BFC_Map_Frame:GetWidth();
	
	if(isNarrow == false) then
		return x * width;
	end

	x = x * width * 2;

	if(x < width / 2) then
		x = 0;
	else
		x = x - width / 2;
	end
	
	if(x > width) then
		x = width;
	end
	
	return x;
end


-- Converts a screen-space x-coord into a 0..1 float representing the x-coord where 0=left and 1=right. 
function BFC_Map.GetFractionalX(x, isNarrow)
	local centerX, centerY = BFC_Map_Frame:GetCenter();
	x = x / BFC_Map_Frame:GetEffectiveScale();

	local width = BFC_Map_Frame:GetWidth();
	
	if(isNarrow) then
		width = width*2;
	end
	
	x = (x - (centerX - (width/2))) / width;
	return x;
end


-- Same as GetFractionalX, but for y-coord.
function BFC_Map.GetFractionalY(y)
	local centerX, centerY = BFC_Map_Frame:GetCenter();
	y = y / BFC_Map_Frame:GetEffectiveScale();

	local height = BFC_Map_Frame:GetHeight();

	y = (centerY + (height/2) - y) / height;
	return y;
end


function BFC_Map.ResizeElements()

	-- Set up the size
	local sizeUnit;
	local unitScale;
	local fullWidth = BFC_Map_Container:GetWidth();
	local narrowMode = BFC_Options.get("narrow");

	if(fullWidth < 100) then
		fullWidth = 100;
	end
	if(narrowMode) then
		sizeUnit = fullWidth/2;
		unitScale = sizeUnit/256;
	else
		sizeUnit = fullWidth/4;
		unitScale = sizeUnit/256;
		sizeUnit = sizeUnit + 5.5*unitScale; -- compensates for the gap at edge of map
	end
	
	BFC_Map_Frame:ClearAllPoints();
	BFC_Map_Frame:SetParent(BFC_Map_Container);
	BFC_Map_Frame:SetPoint("TOPLEFT", BFC_Map_Container, "TOPLEFT");
	
	
	local mapScale = sizeUnit/256;
	local fullHeight = sizeUnit*3 - mapScale*100;
	
	BFC_Map_Frame:SetWidth(fullWidth);
	BFC_Map_Frame:SetHeight(fullHeight);

	-- Fill in map tiles
	local mapFileName, textureHeight = GetMapInfo();
	if (not mapFileName) then
		BFC_Map.SetVisible(false);
		return;
	end

	local mapPiece;
	for i=1, NUM_WORLDMAP_DETAIL_TILES do
		mapPiece = getglobal("BFC_Map_Texture"..i);
		mapPiece:SetTexture("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i);
		mapPiece:SetWidth(sizeUnit);
		mapPiece:SetHeight(sizeUnit);
	end

	-- Setup the POI's
	local numPOIs = GetNumMapLandmarks();
	local name, description, textureIndex, x, y;
	local battlefieldPOI;
	local x1, x2, y1, y2;
	if(BFC_NUM_BATTLEFIELDMAP_POIS == nil) then
		BFC_NUM_BATTLEFIELDMAP_POIS = 0;
	end

	if ( BFC_NUM_BATTLEFIELDMAP_POIS < numPOIs ) then
		for i=BFC_NUM_BATTLEFIELDMAP_POIS+1, numPOIs do
			BFC_Map.CreatePOI(i);
		end
		BFC_NUM_BATTLEFIELDMAP_POIS = numPOIs;
	end
	for i=1, BFC_NUM_BATTLEFIELDMAP_POIS, 1 do
		battlefieldPOI = getglobal("BFC_Map_POI"..i);
		if ( i <= numPOIs ) then
			name, description, textureIndex, x, y = GetMapLandmarkInfo(i);
			x1, x2, y1, y2 = WorldMap_GetPOITextureCoords(textureIndex);
			getglobal(battlefieldPOI:GetName().."Texture"):SetTexCoord(x1, x2, y1, y2);
			
			y = -y * fullHeight;
			x = BFC_Map.GetScaledX(x, narrowMode);

			battlefieldPOI:SetPoint("CENTER", "BFC_Map_Container", "TOPLEFT", x, y );
			battlefieldPOI:SetWidth(BFC_DEFAULT_POI_ICON_SIZE * GetBattlefieldMapIconScale());
			battlefieldPOI:SetHeight(BFC_DEFAULT_POI_ICON_SIZE * GetBattlefieldMapIconScale());
			battlefieldPOI:Show();
		else
			battlefieldPOI:Hide();
		end
	end

	-- Setup the overlays
	local numOverlays = GetNumMapOverlays();
	local textureName, textureWidth, textureHeight, offsetX, offsetY, mapPointX, mapPointY;
	local textureCount = 0, neededTextures;
	local texture;
	local texturePixelWidth, textureFileWidth, texturePixelHeight, textureFileHeight;
	local numTexturesWide, numTexturesTall;
	-- Use this value to scale the texture sizes and offsets
	local battlefieldMinimapScale = BFC_Map_Texture1:GetWidth()/256;
	for i=1, numOverlays do
		textureName, textureWidth, textureHeight, offsetX, offsetY, mapPointX, mapPointY = GetMapOverlayInfo(i);
		numTexturesWide = ceil(textureWidth/256);
		numTexturesTall = ceil(textureHeight/256);
		neededTextures = textureCount + (numTexturesWide * numTexturesTall);
		if ( neededTextures > BFC_NUM_BATTLEFIELDMAP_OVERLAYS ) then
			for j=BFC_NUM_BATTLEFIELDMAP_OVERLAYS+1, neededTextures do
				BFC_Map_Frame:CreateTexture("BFC_Map_Overlay"..j, "ARTWORK");
				getglobal("BFC_Map_Overlay"..j):SetParent(BFC_Map_Frame);
			end
			BFC_NUM_BATTLEFIELDMAP_OVERLAYS = neededTextures;
		end
		for j=1, numTexturesTall do
			if ( j < numTexturesTall ) then
				texturePixelHeight = 256;
				textureFileHeight = 256;
			else
				texturePixelHeight = mod(textureHeight, 256);
				if ( texturePixelHeight == 0 ) then
					texturePixelHeight = 256;
				end
				textureFileHeight = 16;
				while(textureFileHeight < texturePixelHeight) do
					textureFileHeight = textureFileHeight * 2;
				end
			end
			for k=1, numTexturesWide do
				textureCount = textureCount + 1;
				texture = getglobal("BFC_Map_Overlay"..textureCount);

				if ( k < numTexturesWide ) then
					texturePixelWidth = 256;
					textureFileWidth = 256;
				else
					texturePixelWidth = mod(textureWidth, 256);
					if ( texturePixelWidth == 0 ) then
						texturePixelWidth = 256;
					end
					textureFileWidth = 16;
					while(textureFileWidth < texturePixelWidth) do
						textureFileWidth = textureFileWidth * 2;
					end
				end

				local texoffset1 = 0;
				local texoffset2 = texturePixelWidth/textureFileWidth;
				
				local xpos = (offsetX + (256 * (k-1)));
				texture:Show();
				if(narrowMode) then
					xpos = xpos - 256;
					if(xpos < 0) then
						if(xpos == -256) then
							texture:Hide();
						else
							texoffset1 = 1-((texturePixelWidth+xpos)/textureFileWidth);
							texture:SetWidth((texturePixelWidth+xpos)*battlefieldMinimapScale);
							xpos = 0;
						end
					elseif(xpos + texturePixelWidth >= 512) then
						if(xpos >= 512) then
							texture:Hide();
						else
							local extra = (xpos + texturePixelWidth) - 512;
							texoffset2 = ((texturePixelWidth - extra)/textureFileWidth);
							texture:SetWidth((texturePixelWidth - extra)*battlefieldMinimapScale);
						end
					else
						texture:SetWidth(texturePixelWidth*battlefieldMinimapScale);
					end
					
					xpos = xpos * battlefieldMinimapScale;
					
				else
					xpos = xpos * battlefieldMinimapScale;
					texture:SetWidth(texturePixelWidth*battlefieldMinimapScale);
				end
				
				texture:SetHeight(texturePixelHeight*battlefieldMinimapScale);
				texture:SetTexCoord(texoffset1, texoffset2, 0, texturePixelHeight/textureFileHeight);

				texture:ClearAllPoints();
				-- next WAS BFC_Map_Container
				texture:SetPoint("TOPLEFT", "BFC_Map_Container", "TOPLEFT", xpos, -((offsetY + (256 * (j - 1)))*battlefieldMinimapScale));
				texture:SetTexture(textureName..(((j - 1) * numTexturesWide) + k));			
				
			end
		end
	end
	for i=textureCount+1, BFC_NUM_BATTLEFIELDMAP_OVERLAYS do
		getglobal("BFC_Map_Overlay"..i):Hide();
	end
	
end


function BFC_Map.CreatePOI(index)
	local frame = CreateFrame("Frame", "BFC_Map_POI"..index, BFC_Map_Frame);
	frame:SetWidth(BFC_DEFAULT_POI_ICON_SIZE);
	frame:SetHeight(BFC_DEFAULT_POI_ICON_SIZE);

	frame:SetFrameLevel(BFC_Map_Frame:GetFrameLevel() + 2);
	local texture = frame:CreateTexture(frame:GetName().."Texture", "BACKGROUND");

	texture:SetAllPoints(frame);
	texture:SetTexture("Interface\\Minimap\\POIIcons");
end

function BFC_Map.OnUpdate(elapsed)

	-- Update the viewport thinger
	BFC_Map.Viewport_Update();

	-- Throttle updates for everything else
	if (BFC_Map.updateTimer < 0) then
		BFC_Map.updateTimer = BFC_BATTLEFIELD_MINIMAP_UPDATE_RATE;
	else
		BFC_Map.updateTimer = BFC_Map.updateTimer - elapsed;
		return;
	end
	
	-- Update colors every second
	if (BFC_Map.colorUpdateTimer < 0) then
		BFC_Map.colorUpdateTimer = 1.0;
		BFC_Map.ColorizeRaidIcons();
	else
		BFC_Map.colorUpdateTimer = BFC_Map.colorUpdateTimer - elapsed;
	end
	
	local narrowMode = BFC_Options.get("narrow");
	
	--Position player
	UpdateWorldMapArrowFrames();
	local playerX, playerY = GetPlayerMapPosition("player");
	if ( playerX == 0 and playerY == 0 ) then
		ShowMiniWorldMapArrowFrame(nil);
	else
		playerX = BFC_Map.GetScaledX(playerX, narrowMode);
		playerY = -playerY * BFC_Map_Frame:GetHeight();
		PositionMiniWorldMapArrowFrame("CENTER", "BFC_Map_Frame", "TOPLEFT", playerX, playerY);
		ShowMiniWorldMapArrowFrame(1);
		BFC_Map_Player:SetPoint("CENTER", "BFC_Map_Frame", "TOPLEFT", playerX, playerY);
	end
	
	
	-- If resizing the frame then scale everything accordingly
	if (BFC_Map_Container.resizing) then
		BFC_Map.ResizeElements();
	end

	if (not BFC_Options.get("showPlayers")) then
		for i=1, MAX_PARTY_MEMBERS do
			getglobal("BFC_Map_Party"..i):Hide();
		end
		for i=1, MAX_RAID_MEMBERS do
			getglobal("BFC_Map_Raid"..i):Hide();
		end
	else
		--Position groupmates
		local partyX, partyY, partyMemberFrame;
		local playerCount = 0;
		if ( GetNumRaidMembers() > 0 ) then
			for i=1, MAX_PARTY_MEMBERS do
				partyMemberFrame = getglobal("BFC_Map_Party"..i);
				partyMemberFrame:Hide();
			end
			for i=1, MAX_RAID_MEMBERS do
				partyX, partyY = GetPlayerMapPosition("raid"..i);
				partyMemberFrame = getglobal("BFC_Map_Raid"..playerCount + 1);
				if ( (partyX ~= 0 or partyY ~= 0) and not UnitIsUnit("raid"..i, "player") ) then
					partyX = BFC_Map.GetScaledX(partyX, narrowMode);
					partyY = -partyY * BFC_Map_Frame:GetHeight();

					-- next WAS BFC_Map_Container
					partyMemberFrame:SetPoint("CENTER", "BFC_Map_Container", "TOPLEFT", partyX, partyY);
					partyMemberFrame.name = nil;
					partyMemberFrame:Show();
					playerCount = playerCount + 1;
				end
			end
		else
			for i=1, MAX_PARTY_MEMBERS do
				partyX, partyY = GetPlayerMapPosition("party"..i);
				partyMemberFrame = getglobal("BFC_Map_Party"..i);
				if ( partyX == 0 and partyY == 0 ) then
					partyMemberFrame:Hide();
				else
					partyX = BFC_Map.GetScaledX(partyX, narrowMode);
					partyY = -partyY * BFC_Map_Frame:GetHeight();
					
					-- next WAS BFC_Map_Container
					partyMemberFrame:SetPoint("CENTER", "BFC_Map_Container", "TOPLEFT", partyX, partyY);
					partyMemberFrame:Show();
				end
			end
		end
		
		-- Position Team Members
		local numTeamMembers = GetNumBattlefieldPositions();
		for i=playerCount+1, MAX_RAID_MEMBERS do
			partyX, partyY, name = GetBattlefieldPosition(i - playerCount);
			partyMemberFrame = getglobal("BFC_Map_Raid"..i);
			if ( partyX == 0 and partyY == 0 ) then
				partyMemberFrame:Hide();
			else
				partyX = BFC_Map.GetScaledX(partyX, narrowMode);
				partyY = -partyY * BFC_Map_Frame:GetHeight();
				-- next WAS BFC_Map_Container
				partyMemberFrame:SetPoint("CENTER", "BFC_Map_Container", "TOPLEFT", partyX, partyY);
				partyMemberFrame.name = name;
				partyMemberFrame:Show();
			end
		end

		-- Position flags
		local flagX, flagY, flagToken, flagFrame, flagTexture;
		local numFlags = GetNumBattlefieldFlagPositions();
		for i=1, NUM_WORLDMAP_FLAGS do
			flagFrame = getglobal("BFC_Map_Flag"..i);
			if ( i <= numFlags ) then
				flagX, flagY, flagToken = GetBattlefieldFlagPosition(i);
				flagTexture = getglobal("BFC_Map_Flag"..i.."Texture");
				if ( flagX == 0 and flagY == 0 ) then
					flagFrame:Hide();
				else
					flagX = BFC_Map.GetScaledX(flagX, narrowMode);
					flagY = -flagY * BFC_Map_Frame:GetHeight();
					-- next WAS BFC_Map_Container
					flagFrame:SetPoint("CENTER", "BFC_Map_Container", "TOPLEFT", flagX, flagY);
					flagTexture:SetTexture("Interface\\WorldStateFrame\\"..flagToken);
					flagFrame:Show();
				end
			else
				flagFrame:Hide();
			end
		end
	end

	-- Fadein tab if mouse is over
	if ( MouseIsOver(BFC_Map_Container, 45, -10, -5, 5) and not UIOptionsFrame:IsVisible()) then
		local xPos, yPos = GetCursorPosition();
		-- If mouse is hovering don't show the tab until the elapsed time reaches the tab show delay
		if ( BFC_Map_Container.hover ) then
			if ( (BFC_Map_Container.oldX == xPos and BFC_Map_Container.oldy == yPos) ) then
				BFC_Map_Container.hoverTime = BFC_Map_Container.hoverTime + elapsed;
			else
				BFC_Map_Container.hoverTime = 0;
				BFC_Map_Container.oldX = xPos;
				BFC_Map_Container.oldy = yPos;
			end
			if ( BFC_Map_Container.hoverTime > BFC_BATTLEFIELD_TAB_SHOW_DELAY ) then
				-- If the battlefieldtab's alpha is less than the current default, then fade it in 
				if ( not BFC_Map_Container.hasBeenFaded and (BFC_Map_Container.oldAlpha and BFC_Map_Container.oldAlpha < BFC_DEFAULT_BATTLEFIELD_TAB_ALPHA) ) then
					UIFrameFadeIn(BFC_Map_Tab, BFC_BATTLEFIELD_TAB_FADE_TIME, BFC_Map_Container.oldAlpha, BFC_DEFAULT_BATTLEFIELD_TAB_ALPHA);
					-- Set the fact that the tab has been faded so we don't try to fade it again
					BFC_Map_Container.hasBeenFaded = 1;
				end
			end
		else
			-- Start hovering counter
			BFC_Map_Container.hover = 1;
			BFC_Map_Container.hoverTime = 0;
			BFC_Map_Container.hasBeenFaded = nil;
			CURSOR_OLD_X, CURSOR_OLD_Y = GetCursorPosition();
			-- Remember the oldAlpha so we can return to it later
			if ( not BFC_Map_Container.oldAlpha ) then
				BFC_Map_Container.oldAlpha = BFC_Map_Tab:GetAlpha();
			end
		end
	else
		-- If the tab's alpha was less than the current default, then fade it back out to the oldAlpha
		if ( BFC_Map_Container.hasBeenFaded and BFC_Map_Container.oldAlpha and BFC_Map_Container.oldAlpha < BFC_DEFAULT_BATTLEFIELD_TAB_ALPHA ) then
			UIFrameFadeOut(BFC_Map_Tab, BFC_BATTLEFIELD_TAB_FADE_TIME, BFC_DEFAULT_BATTLEFIELD_TAB_ALPHA, BFC_Map_Container.oldAlpha);
			BFC_Map_Container.hover = nil;
			BFC_Map_Container.hasBeenFaded = nil;
		end
		BFC_Map_Container.hoverTime = 0;
	end
end

function BFC_Map.ShowOpacity()
	OpacityFrame:ClearAllPoints();
	OpacityFrame:SetPoint("TOPRIGHT", "BFC_Map_Container", "TOPLEFT", 0, 7);
	OpacityFrame.opacityFunc = BFC_Map.SetOpacity;
	OpacityFrame.saveOpacityFunc = BFC_Map.SaveOpacity;
	OpacityFrameSlider:SetValue(BFC_Options.get("opacity"));
	OpacityFrame:Show();
end

function BFC_Map.SetOpacity()
	local alpha = 1.0 - OpacityFrameSlider:GetValue();
	--[[BFC_Map_BackgroundT:SetAlpha(alpha);
	BFC_Map_BackgroundTL:SetAlpha(alpha);
	BFC_Map_BackgroundTR:SetAlpha(alpha);
	BFC_Map_BackgroundB:SetAlpha(alpha);
	BFC_Map_BackgroundBL:SetAlpha(alpha);
	BFC_Map_BackgroundBR:SetAlpha(alpha);
	BFC_Map_BackgroundL:SetAlpha(alpha);
	BFC_Map_BackgroundR:SetAlpha(alpha);
	BFC_Map_ResizeHandleImg:SetAlpha(alpha);
	
	for i=1, NUM_WORLDMAP_DETAIL_TILES do
		getglobal("BFC_Map_Texture"..i):SetAlpha(alpha);
	end
	if ( alpha >= 0.15 ) then
		alpha = alpha - 0.15;
	end
	for i=1, BFC_NUM_BATTLEFIELDMAP_OVERLAYS do
		getglobal("BFC_Map_Overlay"..i):SetAlpha(alpha);
	end
	BFC_Map_CloseButton:SetAlpha(alpha);
	BFC_Map_Corner:SetAlpha(alpha);]]
	
	-- Set the master alpha
	BFC_Map_Frame:SetAlpha(alpha);
	
	-- Now set the alpha on the players back to 1.0
	for i=1, BFC_NUM_BATTLEFIELDMAP_POIS, 1 do
		getglobal("BFC_Map_POI"..i):SetAlpha(1.0);
	end
	
	for i=1, MAX_PARTY_MEMBERS do
		getglobal("BFC_Map_Party"..i):SetAlpha(1.0);
	end
	
	for i=1, MAX_RAID_MEMBERS do
		getglobal("BFC_Map_Raid"..i):SetAlpha(1.0);
	end
	
	BFC_Map_Player:SetAlpha(1.0);
	BFC_Map_LocatorBlip:SetAlpha(1.0);
	BFC_Map_Flag1:SetAlpha(1.0);
	BFC_Map_Flag2:SetAlpha(1.0);
end

function BFC_Map.SaveOpacity()
	BFC_Options.set("opacity", OpacityFrameSlider:GetValue());
end

function BFC_Map.TabDropDown_Initialize()
	local checked;
	local info = {};
	-- Show battlefield players
	if ( BFC_Options.get("showPlayers") ) then
		checked = 1;
	end
	info.text = SHOW_BATTLEFIELDMINIMAP_PLAYERS;
	info.func = BFC_Map.TogglePlayers;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Battlefield minimap lock
	checked = nil;
	if ( BFC_Options.get("locked") ) then
		checked = 1;
	end
	info.text = LOCK_BATTLEFIELDMINIMAP;
	info.func = BFC_Map.ToggleLock;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

	-- Opacity
	info = {};
	info.text = BATTLEFIELDMINIMAP_OPACITY_LABEL;
	info.func = BFC_Map.ShowOpacity;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Narrow mode
	checked = nil;
	if ( BFC_Options.get("narrow") ) then
		checked = 1;
	end
	info = {};
	info.text = BFC_Strings.Menu.narrowmode;
	info.func = BFC_Map.ToggleNarrowMode;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Auto-show
	checked = nil;
	if ( BFC_Options.get("autoShowBg") ) then
		checked = 1;
	end
	info = {};
	info.text = BFC_Strings.Menu.autoshowbg;
	info.func = BFC_Map.ToggleAutoShowBG;
	info.checked = checked;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
	
	-- Options
	--info = {};
	--info.text = BFC_Strings.Menu.options;
	--info.func = BFC_Options.Show;
	--UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end

function BFC_Map.Tab_OnClick(button)
	-- If Rightclick bring up the options menu
	if ( button == "RightButton" ) then
		ToggleDropDownMenu(1, nil, BFC_Map_TabDropDown, this:GetName(), 0, 0);
		return;
	end

	-- Close all dropdowns
	CloseDropDownMenus();

	-- If frame is not locked then allow the frame to be dragged or dropped
	if ( this:GetButtonState() == "PUSHED" ) then
		BFC_Map_Tab:StopMovingOrSizing();
	else
		-- If locked don't allow any movement
		if ( BFC_Options.get("locked") ) then
			return;
		else
			BFC_Map_Tab:StartMoving();
		end
	end
end

function BFC_Map.ToggleLock()
	BFC_Options.toggle("locked");
end

function BFC_Map.TogglePlayers()
	BFC_Options.toggle("showPlayers");
end

function BFC_Map.ToggleRadioSounds()
	BFC_Options.toggle("enableRadio");
end

function BFC_Map.ToggleAutoShowBG()
	BFC_Options.toggle("autoShowBg");
end

function BFC_Map.ToggleNarrowMode()
	BFC_Map.SetNarrowMode(BFC_Options.toggle("narrow"));
end

function BFC_Map.OnTargetChanged()
	if ( not UnitExists("target") ) then
		BFC_Map_LocatorBlip:Hide();
		return;
	end
	
	local x, y = GetPlayerMapPosition("target");

	if(x == 0 or y == 0) then
		BFC_Map_LocatorBlip:Hide();
		return;
	end

	BFC_Map_LocatorBlip:ClearAllPoints();
	BFC_Map_LocatorBlip:SetPoint("CENTER", "BFC_Map_Frame", "TOPLEFT", BFC_Map.GetScaledX(x, BFC_Options.get("narrow")), -y * BFC_Map_Frame:GetHeight());

	BFC_Map_LocatorBlip:Show();
end

function BFC_Map.LocatorBlip_OnUpdate(time)
	-- FIXME: throttle this
	BFC_Map.OnTargetChanged();
end

function BFC_Map.Unit_OnClick()
	-- Target this unit
	TargetUnit(this.unit);
end

function BFC_Map.Unit_OnEnter()
	-- Adjust the tooltip based on which side the unit button is on
	local x, y = this:GetCenter();
	local parentX, parentY = this:GetParent():GetCenter();
	if ( x > parentX ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	
	-- See which POI's are in the same region and include their names in the tooltip
	local unitButton;
	local newLineString = "";
	local tooltipText = "";
	
	-- Check Objectives
	--[[for i=0, 8 do
		unitButton = getglobal("BFC_Map_Objective"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			if(unitButton:GetID() == 0) then
				tooltipText = tooltipText..newLineString..BFC_Strings.yourobjective;
			else
				tooltipText = tooltipText..newLineString..string.format(BFC_Strings.groupobjective, unitButton:GetID());
			end
			newLineString = "\n";
		end
	end
	]]
	
	
	-- Check player
	if ( MouseIsOver(BFC_Map_Player) ) then
		local lclass, eclass = UnitClass(BFC_Map_Player.unit);
		tooltipText = BFC_Util.GetClassColorString(eclass) .. UnitName(BFC_Map_Player.unit) .. " (" .. BFC_Util.GetUnitHealthPercent(BFC_Map_Player.unit) .. "%)";
		newLineString = "\n";
	end
	
	-- Check party
	for i=1, MAX_PARTY_MEMBERS do
		unitButton = getglobal("BFC_Map_Party"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			local lclass, eclass = UnitClass(unitButton.unit);
			tooltipText = tooltipText..newLineString..BFC_Util.GetClassColorString(eclass)..UnitName(unitButton.unit) .. " (" .. BFC_Util.GetUnitHealthPercent(unitButton.unit) .. "%)";
			newLineString = "\n";
		end
	end
	--Check Raid
	for i=1, MAX_RAID_MEMBERS do
		unitButton = getglobal("BFC_Map_Raid"..i);
		if ( unitButton:IsVisible() and MouseIsOver(unitButton) ) then
			-- Handle players not in your raid or party, but on your team
			if ( unitButton.name ) then
				tooltipText = tooltipText..newLineString.."|cff7f7f7f"..unitButton.name;	
			else
				local lclass, eclass = UnitClass(unitButton.unit);
				tooltipText = tooltipText..newLineString..BFC_Util.GetClassColorString(eclass)..UnitName(unitButton.unit) .. " (" .. BFC_Util.GetUnitHealthPercent(unitButton.unit) .. "%)";
			end
			newLineString = "\n";
		end
	end
	GameTooltip:SetText(tooltipText);
	GameTooltip:Show();
end


function BFC_Map.SnapResizeAnchor()
	if(not BFC_Map_Container:IsVisible()) then
		--BFC.Log(BFC.LOG_DEBUG, "Not snapping resize, map is still hidden")
		return
	end
	
	BFC_Map_Container:ClearAllPoints();
	BFC_Map_Container:SetPoint("TOPLEFT", BFC_Map_Tab, "BOTTOMLEFT", 0, -5);
	
	local mapscale = BFC_Map_Texture1:GetWidth()/256;
	--BFC.Log(BFC.LOG_DEBUG, "got mapscale " .. mapscale .. ", width " .. BFC_Map_Texture1:GetWidth());
	
	if(BFC_Options.get("narrow")) then
		--BFC.Log(BFC.LOG_DEBUG, "setting width to " .. BFC_Map_Texture1:GetWidth() * 2);
		BFC_Map_Container:SetWidth(BFC_Map_Texture1:GetWidth() * 2);
	else
		local newwidth = BFC_Map_Texture1:GetWidth() * 4 - mapscale*22;
		local delta = BFC_Map_Container:GetWidth() - newwidth;
		--BFC_Debug("Delta = " .. delta);
		if(delta > 0.15) then
			BFC_Map_Container:SetWidth(newwidth);
		end
	end
	BFC_Map_Container:SetHeight(BFC_Map_Texture1:GetHeight() * 3 - mapscale*100);
	
	BFC_Map_ResizeHandle:ClearAllPoints();
	BFC_Map_ResizeHandle:SetPoint("BOTTOMRIGHT", BFC_Map_Container, "BOTTOMRIGHT");
end



function BFC_Map.SetNarrowMode(state)

	local oldstate = BFC_Options.get("narrow");
	BFC_Options.set("narrow", state);

	if(state) then
		BFC_Map_Texture1:Hide();
		BFC_Map_Texture5:Hide();
		BFC_Map_Texture9:Hide();
		BFC_Map_Texture4:Hide();
		BFC_Map_Texture8:Hide();
		BFC_Map_Texture12:Hide();
		
		BFC_Map_Texture2:ClearAllPoints();
		BFC_Map_Texture2:SetPoint("TOPLEFT", BFC_Map_Container, "TOPLEFT");
		if(oldstate == false) then
			BFC_Map_Container:SetWidth(BFC_Map_Container:GetWidth() / 2);
		end
		
		BFC_Map.ResizeElements();
		BFC_Map.SnapResizeAnchor();
	else
		BFC_Map_Texture1:Show();
		BFC_Map_Texture5:Show();
		BFC_Map_Texture9:Show();
		BFC_Map_Texture4:Show();
		BFC_Map_Texture8:Show();
		BFC_Map_Texture12:Show();
		
		BFC_Map_Texture2:ClearAllPoints();
		BFC_Map_Texture2:SetPoint("TOPLEFT", BFC_Map_Texture1, "TOPRIGHT");
		if(oldstate == true) then
			BFC_Map_Container:SetWidth(BFC_Map_Container:GetWidth() * 2);
		end
		
		BFC_Map.ResizeElements();
		BFC_Map.SnapResizeAnchor();
	end
end


-- Send a ping to other group members
function BFC_Map.SendPing(x, y)
	BFC_Comms.SendMessage("MAP", "PING", {BFC_Map.GetFractionalX(x-6, BFC_Options.get("narrow")), BFC_Map.GetFractionalY(y-8)});
end

-- Draw a ping at the specified location
function BFC_Map.HandlePing(player, coords)
	if(not BFC_Map_Container:IsShown()) then return end
	
	x = tonumber(coords[1]);
	y = tonumber(coords[2]);
	
	BFC_Map_Ping:ClearAllPoints();
	BFC_Map_Ping:SetPoint("CENTER", "BFC_Map_Frame", "TOPLEFT", BFC_Map.GetScaledX(x, BFC_Options.get("narrow")), -y * BFC_Map_Frame:GetHeight());
	--BFC.Log(BFC.LOG_DEBUG, "Drawing ping at " .. BFC_Map.GetScaledX(x, BFC_Options.get("narrow")) .. ", " .. (-y * BFC_Map_Frame:GetHeight()));
	
	BFC_Map_Ping.timer = MINIMAPPING_TIMER;
	BFC_Map_Ping:SetAlpha(255);
	BFC_Map_Ping:Show();
	
	--if(playsound) then
		PlaySound("MapPing");
	--end
end


-- mostly based on the stock minimap ping code
function BFC_Map.Ping_OnLoad()
	BFC_Map_Ping.fadeOut = nil;
	this:SetSequence(0);
end

function BFC_Map.Ping_OnUpdate(elapsed)

	if ( BFC_Map_Ping.timer and BFC_Map_Ping.timer > 0 ) then
		BFC_Map_Ping.timer = BFC_Map_Ping.timer - elapsed;
		if (BFC_Map_Ping.timer <= 0 ) then
			BFC_Map.Ping_FadeOut();
		--else
		--	BFC_Map.HandlePing(nil, {BFC_Map_Ping.X, BFC_Map_Ping.Y});
		end
	elseif ( BFC_Map_Ping.fadeOut ) then
		BFC_Map_Ping.fadeOutTimer = BFC_Map_Ping.fadeOutTimer - elapsed;
		if ( BFC_Map_Ping.fadeOutTimer > 0 ) then
			BFC_Map_Ping:SetAlpha(255 * (BFC_Map_Ping.fadeOutTimer/MINIMAPPING_FADE_TIMER))
		else
			BFC_Map_Ping.fadeOut = nil;
			BFC_Map_Ping:Hide();
		end
	end
 end

function BFC_Map.Ping_FadeOut()
	BFC_Map_Ping.fadeOut = 1;
	BFC_Map_Ping.fadeOutTimer = MINIMAPPING_FADE_TIMER;
end



function BFC_Map.CanSendStatusUpdate(author)
	if(UnitName("player") == author) then
		return true;
	end
	
	if(GetNumRaidMembers() > 0) then
		if(BFC_Map.RaidRoster[author] == nil) then
			return false;
		else
			return true;
		end
	elseif(GetNumPartyMembers() > 0) then
		if(UnitName("party1") == author or UnitName("party2") == author or UnitName("party3") == author or UnitName("party4") == author) then
			return true;
		else
			return false;
		end
	else
		return true;
	end
end

-- update the raid roster cache whenever the raid composition changes
function BFC_Map.UpdateRaidRoster()

	BFC_Map.NewRaidRoster = {};
	local numRaidMembers = GetNumRaidMembers();
	for i=1, MAX_RAID_MEMBERS do
		--if ( i <= numRaidMembers ) then
			local name, rank, subgroup, level, class, fileName, zone, online, isDead = GetRaidRosterInfo(i);
			if(name ~= nil) then
				
				local pinfo = {};
				pinfo.rank = rank;
				pinfo.class = class;
				pinfo.subgroup = subgroup;
				pinfo.id = i;
				BFC_Map.NewRaidRoster[name] = pinfo;
			end
			
		--end
	end
	
	BFC_Map.RaidRoster = BFC_Map.NewRaidRoster;
	
--	if(numRaidMembers > 0 and (IsRaidLeader() or IsRaidOfficer())) then
--		BFC_ExpandCommanderButton:Show();
--	else
--		BFC_ExpandCommanderButton:Hide();
--	end
end

function BFC_Map.ColorizeRaidIcons()

	--name, rank, subgroup = GetRaidRosterInfo(this:GetID());
	--playername, playerrank, playersubgroup = GetRaidRosterInfo(GetNumRaidMembers());
	
	local partyMemberFrame;
	local playerCount = 0;
	
	-- Color group members
	if ( GetNumRaidMembers() > 0 ) then
		for i=1, MAX_RAID_MEMBERS do
			partyMemberFrame = getglobal("BFC_Map_Raid" .. (playerCount + 1) .. "Icon");
			if ( (partyX ~= 0 or partyY ~= 0) and not UnitIsUnit("raid"..i, "player") ) then
				if(UnitAffectingCombat("raid"..i)) then
					partyMemberFrame:SetTexture(BFC_MiscIcons["combat"]);
				elseif(UnitIsDeadOrGhost("raid"..i)) then
					partyMemberFrame:SetTexture(BFC_MiscIcons["dead"]);
				elseif(BFC_Map.RaidRoster[UnitName("raid"..i)] and BFC_Map.RaidRoster[UnitName("player")]) then
					if(BFC_Map.RaidRoster[UnitName("raid"..i)].subgroup == BFC_Map.RaidRoster[UnitName("player")].subgroup) then
						partyMemberFrame:SetTexture("Interface\\WorldMap\\WorldMapPlayerIcon");
						getglobal("BFC_Map_Raid" .. (playerCount + 1)).samegroup = true;
					else
						partyMemberFrame:SetTexture(BFC_GroupIcons[BFC_Map.RaidRoster[UnitName("raid"..i)].subgroup]);
						getglobal("BFC_Map_Raid" .. (playerCount + 1)).samegroup = false;
					end
				else
					getglobal("BFC_Map_Raid"..(playerCount + 1).."Icon"):SetTexture("Interface\\WorldMap\\WorldMapPartyIcon");
				end
				playerCount = playerCount + 1;
			end
		end
	else
		for i=1, MAX_PARTY_MEMBERS do
			if(UnitAffectingCombat("party"..i)) then
				getglobal("BFC_Map_Party"..i.."Icon"):SetTexture(BFC_MiscIcons["combat"]);
			elseif(UnitIsDeadOrGhost("party"..i)) then
				getglobal("BFC_Map_Party"..i.."Icon"):SetTexture(BFC_MiscIcons["dead"]);
			else
				getglobal("BFC_Map_Party"..i.."Icon"):SetTexture("Interface\\WorldMap\\WorldMapPlayerIcon");
			end
		end
	end
	
	-- Color team members
	local numTeamMembers = GetNumBattlefieldPositions();
	for i=playerCount+1, MAX_RAID_MEMBERS do
		getglobal("BFC_Map_Raid"..i.."Icon"):SetTexture("Interface\\WorldMap\\WorldMapPartyIcon");
		getglobal("BFC_Map_Raid" .. i).samegroup = false;
	end
end


-- This viewport stuff based on code from SimpleCompass
function BFC_Map.Viewport_Init()
	local children = {BFC_Map_Frame:GetChildren()};
	
	-- Iterate over the children of BFC_Map_Frame looking for a nameless model.
	-- This will be the direction arrow.
	for i=getn(children), 1, -1 do
		if children[i]:IsObjectType("Model") and not children[i]:GetName() then
			BFC_Map.minimapPlayerModel = children[i];
			return;
		end
	end
	
	-- If we couldn't find the one on the BFC frame for some reason, scan the regular minimap
	if(BFC_Map.minimapPlayerModel == nil) then
		children = {Minimap:GetChildren()};
		
		for i=getn(children), 1, -1 do
			if children[i]:IsObjectType("Model") and not children[i]:GetName() then
				BFC_Map.minimapPlayerModel = children[i];
				return;
			end
		end
	end
end


function BFC_Map.Viewport_Update()
	-- don't bother if we have no reference point
	if(not BFC_Map.minimapPlayerModel or not BFC_Map.minimapPlayerModel:IsVisible()) then
		BFC_Map_Player:Hide();
		return;
	else
		BFC_Map_Player:Show();
	end
	
	local facingdegrees = 315 + (BFC_Map.minimapPlayerModel:GetFacing() / (math.pi/180));

	-- convert back to radians
	-- The texture rotation is off by 135 degrees, so we fix it here.
	rads = facingdegrees * (math.pi/180) + (math.pi*0.75);

	Sin = math.sin(rads) * 0.7;
	Cos = math.cos(rads) * 0.7;

	BFC_Map_PlayerTexture:SetTexCoord(0.5-Sin, 0.5+Cos,
		 0.5+Cos, 0.5+Sin,
		 0.5-Cos, 0.5-Sin,
		 0.5+Sin, 0.5-Cos);
end