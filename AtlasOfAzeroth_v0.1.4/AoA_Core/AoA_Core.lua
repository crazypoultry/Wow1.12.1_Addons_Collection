--------------------------------------------------------------------------------
-- Version history...
--  0.1.0 - MainFrame and basic Module handling
--  0.1.1 - Minimap Button
--  0.1.2 - Module handling optimized
--        - Button to make the frame translucent 
--        - Debug messages
--        - Key binding
--  0.1.3 - Key binding (transluency)
--        - "WorldMap" is now always the first tab
--        - Small options frame (at the MMButton)
--  0.1.4 - ZoningLibrary
--------------------------------------------------------------------------------


-- Debug mode (true=on, nil=off)
local DEBUG_MODE = nil;

-- Version of the data structure in the saved vars
AOA_DATA_VERSION = 2;
AOA_DATA_COMPATIBILITY = 2;

-- Flags of the init routines
local AoA_Initialized = false;
local AoA_ADDON_LOADED = false;
local AoA_VARIABLES_LOADED = false;
local AoA_PLAYER_ENTERING_WORLD = false;

-- All the registered modules
local AoAModules = {};


-- =============================================================================
-- misc. functions
-- =============================================================================


local function AoA_ChatMessage(text)
	AoAMod_ChatMessage("Core", text);
end

local function AoA_ChatError(text)
	AoAMod_ChatError("Core", text);
end

local function AoA_ChatWarning(text)
	AoAMod_ChatWarning("Core", text);
end

local function AoA_ChatDebug(text)
	if (DEBUG_MODE) then AoAMod_ChatDebug("Core", text); end
end

function AoAMod_ChatMessage(mod, text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff4169e1AoA|r|cfff1c603"..mod.."|r|cff4169e1:|r "..text);
end

function AoAMod_ChatError(mod, text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff4169e1AoA|r|cfff1c603"..mod.."|r|cff4169e1:|r |cffff0000"..text.."|r");
end

function AoAMod_ChatWarning(mod, text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff4169e1AoA|r|cfff1c603"..mod.."|r|cff4169e1:|r |cffffff00"..text.."|r");
end

function AoAMod_ChatDebug(mod, text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff4169e1AoA|r|cfff1c603"..mod.."|r|cff4169e1:|r |cffff00ff"..text.."|r");
end


-- =============================================================================
-- ==  Module handling
-- =============================================================================


--------------------------------------------------------------------------------
-- Register module using the info array
--
-- info.frame = the frame which will be shown
-- info.init  = function to call after all modules are loaded
-- info.text  = text which will be shown on the tab
-- info.addon = addonname used as param for GetAddOnMetadata()
--------------------------------------------------------------------------------
function AoA_RegisterModule(info)
	local nextID = getn(AoAModules) + 1;
	if(info.addon == "AoA_WorldMap") then
		for index=getn(AoAModules),1,-1 do
			AoAModules[index+1] = AoAModules[index];
		end
		AoAModules[1] = info;
		AoAModules[1].id = nextID;
		return nextID;
	else
		AoAModules[nextID] = info;
		AoAModules[nextID].id = nextID;
		return nextID;
	end
end


-- =============================================================================
-- ==  Main Frame
-- =============================================================================


--------------------------------------------------------------------------------
-- OnLoad
--------------------------------------------------------------------------------
function AoA_OnLoad()

	-- Register for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	
	-- some special functionality
	tinsert(UISpecialFrames, "AoAFrame");
	AoAFrame:RegisterForDrag("LeftButton");
	
	-- Setting up slash commands involves referencing some strange auto-generated variables
	SLASH_AtlasOfAzeroth1 = "/atlasofazeroth";
	SLASH_AtlasOfAzeroth2 = "/aoa";
	SlashCmdList["AtlasOfAzeroth"] = function(msg)
		AoA_SlashCommand(msg);
	end

end

function AoA_RegisterEvents()
end

function AoA_UnregisterEvents()
end


--------------------------------------------------------------------------------
-- Initializes everything relating to saved variables and data in other lua files
-- This should be called ONLY when we're sure that all other files have been loaded
--------------------------------------------------------------------------------
function AoA_Init()
	
	-- setup the saved variables if needed
	AoA_InitSavedVars();
	
	-- init minimap button
	AoAMMButton_Init();

	-- init the lock button
	AoA_UpdateLock();
	
	-- other AddOn integration
	AoA_InitCosmos();
	AoA_InitCTMod();
	
	-- set some strings
	AoAFrameVersion:SetText(GetAddOnMetadata("AoA_Core", "Version"));
	
	-- AddOn is initialized now
	AoA_Initialized = true;
	AoA_ChatMessage(string.format(AOA_LOADED, GetAddOnMetadata("AoA_Core", "Version")));
	
	-- init modules
	AoA_InitModuleData();
	
	-- set the scaling
	if(AoACharData.Core.Scale ~= nil) then
		AoAFrame:SetScale(AoACharData.Core.Scale);
	end
	
end

function AoA_InitCosmos()
end

function AoA_InitCTMod()
end


--------------------------------------------------------------------------------
-- Init Module data
--------------------------------------------------------------------------------
function AoA_InitModuleData()
	
	-- init, register and update tabs
	for i=1, getn(AoAModules) do
		-- init module
		(AoAModules[i].init)();
		-- set tab text
		getglobal("AoAFrameTab"..i):SetText(AoAModules[i].text);
		-- disable/enable tab
		if(AoAModules[i].frame == nil) then
			PanelTemplates_DisableTab(AoAFrame, i);
		end
	end
	
	-- some tab init
	PanelTemplates_SetNumTabs(AoAFrame, getn(AoAModules));
	AoAFrame.selectedTab = 1;
	PanelTemplates_UpdateTabs(AoAFrame);
	if(getn(AoAModules) > 0) then
		AoA_OnTabClick(1);
	end
	
	-- hide unused tabs
	for i=getn(AoAModules)+1, 10 do
		getglobal("AoAFrameTab"..i):Hide();
	end
	
	AoA_ChatMessage(string.format(AOA_MODULES_INITIALIZED, getn(AoAModules)));
end


--------------------------------------------------------------------------------
-- Create all the necessary saved variables if they don't exist
-- The default settings for all saved variables are stored here
--------------------------------------------------------------------------------
function AoA_InitSavedVars()
	
	--
	-- global data
	--
	
	-- make shure that the saved settings are up to date
	if(AoAData == nil or tonumber(AoAData.Version) < AOA_DATA_COMPATIBILITY) then
		AoAData = {};
		AoAData.Version = AOA_DATA_VERSION;
		AoA_ChatWarning(AOA_DATA_UPDATED);
	end
	
	--
	-- char data
	--
	
	-- make shure that the saved settings are up to date
	if(AoACharData == nil or tonumber(AoACharData.Version) < AOA_DATA_COMPATIBILITY) then
		AoACharData = {};
		AoACharData.Version = AOA_DATA_VERSION;
		AoA_ChatWarning(AOA_CHARDATA_UPDATED);
	end
	
	-- subarrays
	if(AoACharData.Core == nil) then
		AoACharData.Core = {};
	end
	if(AoACharData.MMButton == nil) then
		AoACharData.MMButton = {};
	end
	
	-- allow dragging of main frame
	-- value: false/true
	if(AoACharData.Core.Locked == nil) then
		AoACharData.Core.Locked = false;
	end
	
	-- position of the minimap icon around the border of the minimap
	-- value: 0..360
	if(AoACharData.MMButton.Position == nil) then
		AoACharData.MMButton.Position = 268;
	end
	
	-- show/hide the minimap button
	-- value: false/true
	if(AoACharData.MMButton.Visible == nil) then
		AoACharData.MMButton.Visible = true;
	end
	
	-- show/hide the minimap button
	-- value: false/true
	if(AoACharData.Core.Alpha == nil) then
		AoACharData.Core.Alpha = 0.5;
	end
	
end


--------------------------------------------------------------------------------
-- AtlasEnh_StartMoving
--------------------------------------------------------------------------------
function AoA_StartMoving()

	if(not AoACharData.Core.Locked) then
		AoAFrame:StartMoving();
	end
	
end


--------------------------------------------------------------------------------
-- Simple function to toggle the Atlas frame's alpha
--------------------------------------------------------------------------------
function AoA_ToggleAlpha()

	if(AoAFrame:GetAlpha() == 1.0) then
		AoAFrame:SetAlpha(AoACharData.Core.Alpha);
	else
		AoAFrame:SetAlpha(1.0);
	end
	
	PlaySound("UChatScrollButton");
	
end


--------------------------------------------------------------------------------
-- Simple function to toggle the Atlas frame's lock status
--------------------------------------------------------------------------------
function AoA_ToggleLock()

	if(AoACharData.Core.Locked) then
		AoACharData.Core.Locked = false;
	else
		AoACharData.Core.Locked = true;
	end
	
	AoA_UpdateLock();
	PlaySound("UChatScrollButton");
	
end


--------------------------------------------------------------------------------
-- Updates the appearance of the lock button
--------------------------------------------------------------------------------
function AoA_UpdateLock()

	if(AoACharData.Core.Locked) then
		AoAFrameLockButtonNorm:SetTexture("Interface\\AddOns\\AoA_Core\\Images\\LockButton-Locked-Up");
		AoAFrameLockButtonPush:SetTexture("Interface\\AddOns\\AoA_Core\\Images\\LockButton-Locked-Down");
	else
		AoAFrameLockButtonNorm:SetTexture("Interface\\AddOns\\AoA_Core\\Images\\LockButton-Unlocked-Up");
		AoAFrameLockButtonPush:SetTexture("Interface\\AddOns\\AoA_Core\\Images\\LockButton-Unlocked-Down");
	end
	
end


--------------------------------------------------------------------------------
-- Simple function to toggle the visibility of the main frame
--------------------------------------------------------------------------------
function AoA_Toggle(modID)
	
	local selTab = AoAFrame.selectedTab;
	local selMod = AoAModules[selTab].id;
	if(modID == nil) then
		modID = selMod;
	end
	
	if(not AoAFrame:IsVisible()) then
		ShowUIPanel(AoAFrame);
		PlaySound("igMainMenuOpen");
	elseif(selMod == modID) then
		HideUIPanel(AoAFrame);
		PlaySound("igMainMenuClose");
		return;
	end
	
	if(selMod ~= selTab) then
		local newTab = 1;
		for i=1,getn(AoAModules) do
			if(AoAModules[i].id == modID) then
				newTab = i;
			end
		end
		AoAFrame.selectedTab = newTab;
		PanelTemplates_UpdateTabs(AoAFrame);
		AoA_OnTabClick(newTab);
		ShowUIPanel(AoAFrame);
		PlaySound("igMainMenuOpen");
	end
	
end


--------------------------------------------------------------------------------
-- AoA_SlashCommand
--------------------------------------------------------------------------------
function AoA_SlashCommand(msg)

	if (msg) then
	
		-- decode slash command
		-- format is "/atlasofazeroth [key] [param_1 param_2 ... param_n]"
		local key, params;
		if (strfind(msg, " ") == nil) then
			key = msg;
			params = nil;
		else
			key = strsub(msg, 0, strfind(msg, " ") - 1);
			params = strsub(msg, strfind(msg, " ") + 1, strlen(msg));
			local paramsTemp = strsub(params, 0, 1);
			if ((params == "") or (paramsTemp == " ")) then
				params = nil;
			end
		end
		
		if (key == "help") then
			-- TODO
			
		elseif (key == "xyz" and params ~= nil) then
			-- TODO
		
		-- default: toggle the window
		else
			AoA_Toggle();
		end
		
	end

end


--------------------------------------------------------------------------------
-- Event: OnEvent
--------------------------------------------------------------------------------
function AoA_OnEvent()

	if ( event == "ADDON_LOADED" and arg1 == "AoA_Core") then
		AoA_ADDON_LOADED = true;
	elseif ( event == "VARIABLES_LOADED" ) then
		AoA_VARIABLES_LOADED = true;
	elseif ( event == "PLAYER_ENTERING_WORLD" ) then
		AoA_PLAYER_ENTERING_WORLD = true;
		AoA_RegisterEvents();
	elseif ( event == "PLAYER_LEAVING_WORLD" ) then
		AoA_UnregisterEvents();
	end
	
	-- Once these two events have fired we can assume that all other files have been loaded
	-- It's now safe to initialize AtlasEnhanced if it hasn't already been done
	if ( AoA_ADDON_LOADED and AoA_VARIABLES_LOADED and AoA_PLAYER_ENTERING_WORLD and AoA_Initialized == false ) then
		AoA_Init();
	end
	
end


--------------------------------------------------------------------------------
-- Event: OnShow
--------------------------------------------------------------------------------
function AoA_OnShow()
end


--------------------------------------------------------------------------------
-- OnTabClick
--------------------------------------------------------------------------------
function AoA_OnTabClick(tabID)
	local index = 1;
	while(AoAModules[index] ~= nil) do
		if(AoAModules[index].frame) then
			if(index == tabID) then
				(AoAModules[index].frame):Show();
				AoAFrameTitle:SetText(AOA_TITLE.." - "..AoAModules[index].text);
				AoAFrameVersion:SetText("Core:"..GetAddOnMetadata("AoA_Core", "Version").." Mod:"..GetAddOnMetadata(AoAModules[index].addon, "Version"));
			else
				(AoAModules[index].frame):Hide();
			end
		end
		index = index + 1;
	end
	PlaySound("UChatScrollButton");
end


-- =============================================================================
-- ==  Minimap Button
-- =============================================================================


--------------------------------------------------------------------------------
-- Initialize
--------------------------------------------------------------------------------
function AoAMMButton_Init()

	-- update the position of the button
	AoAMMButton_UpdatePosition();
	
	-- show/hide the button
	if(AoACharData.MMButton.Visible) then
		AoAMMButtonFrame:Show();
	else
		AoAMMButtonFrame:Hide();
	end
	
end


--------------------------------------------------------------------------------
-- DragMode, recalculate the position of the button
--------------------------------------------------------------------------------
function AoAMMButton_BeingDragged()
	local xpos,ypos = GetCursorPosition() 
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom() 
	
	xpos = xmin-xpos/UIParent:GetScale()+70 
	ypos = ypos/UIParent:GetScale()-ymin-70 
	
	AoAMMButton_SetPosition(math.deg(math.atan2(ypos,xpos)));
end


--------------------------------------------------------------------------------
-- Event: OnClick
--------------------------------------------------------------------------------
function AoAMMButton_OnClick()
	if(IsControlKeyDown()) then
		if(AoAMMButtonOptionsFrame:IsVisible()) then
			AoAMMButtonOptionsFrame:Hide();
		else
			AoAMMButtonOptionsFrame:Show();
		end
	else
		AoA_Toggle();
	end
end


--------------------------------------------------------------------------------
-- Event: OnEnter
--------------------------------------------------------------------------------
function AoAMMButton_OnEnter()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(AOA_MMBUTTON_TOOLTIP);
	GameTooltip:AddLine(AOA_MMBUTTON_TOOLTIP2, 0.8, 0.8, 0.8, 1);
	GameTooltip:Show();
end


--------------------------------------------------------------------------------
-- Check and save the position of the button
--------------------------------------------------------------------------------
function AoAMMButton_SetPosition(v)
	if(v < 0) then
		v = v + 360;
	end
	
	AoACharData.MMButton.Position = v;
	AoAMMButton_UpdatePosition();
end


--------------------------------------------------------------------------------
-- Update the position of the button
--------------------------------------------------------------------------------
function AoAMMButton_UpdatePosition()
	AoAMMButtonFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT",
		54 - (78 * cos(AoACharData.MMButton.Position)),
		(78 * sin(AoACharData.MMButton.Position)) - 55
		);
end


--------------------------------------------------------------------------------
-- Toggle the button
--------------------------------------------------------------------------------
function AoAMMButton_Toggle()
	if(AoAMMButtonFrame:IsVisible()) then
		AoAMMButtonFrame:Hide();
		AoACharData.MMButton.Visible = false;
	else
		AoAMMButtonFrame:Show();
		AoACharData.MMButton.Visible = true;
	end
end


-- =============================================================================
-- ==  Core Options Frame
-- =============================================================================


function AoACore_OptionsInit()

	-- init position
	AoAMMButtonOptionsFrame:ClearAllPoints();
	local x, y = GetCursorPosition();
	x = x / UIParent:GetEffectiveScale();
	y = y / UIParent:GetEffectiveScale();
	local point = "";
	if(x+100 > (UIParent:GetWidth() / UIParent:GetEffectiveScale())) then
		point = "RIGHT";
		x = (UIParent:GetWidth() / UIParent:GetEffectiveScale());
	end
	if(x-100 < 0) then
		point = "LEFT";
		x = 0;
	end
	if(y < (UIParent:GetHeight() /2)) then
		AoAMMButtonOptionsFrame:SetPoint("BOTTOM"..point, "UIParent", "BOTTOMLEFT", x, y -10);
	else
		AoAMMButtonOptionsFrame:SetPoint("TOP"..point, "UIParent", "BOTTOMLEFT", x, y +10);
	end
	
	-- MMButton pos
	AoACoreOptionMMButtonPos:SetValue(AoACharData.MMButton.Position);
	
	-- Scale of the MainFrame
	AoACoreOptionScale:SetValue(AoAFrame:GetScale());
	
	-- Alpha for the AlphaMode
	if(AoAFrame:IsVisible() and AoAFrame:GetAlpha() == 1.0) then
		AoAMMButtonOptionsFrame.restorAlpha = true;
	else
		AoAMMButtonOptionsFrame.restorAlpha = false;
	end
	AoACoreOptionAlpha:SetValue(AoACharData.Core.Alpha);
	
end


function AoACore_OptionsOnUpdate(elapsed)
	if ( this:IsVisible() ) then
		if ( not this.showTimer or not this.isCounting ) then
			return;
		elseif ( this.showTimer < 0 ) then
			this:Hide();
			this.showTimer = nil;
			this.isCounting = nil;
			if(this.restorAlpha) then
				AoAFrame:SetAlpha(1.0)
			end
		else
			this.showTimer = this.showTimer - elapsed;
		end
	end
end
