------------------------------------------------------------------------------
-- BigMinimapCore.lua
--
-- Author: Daniel Stephens <daniel@vigilance-committee.org>
-- Author: Iriel <iriel@vigilance-committee.org>
--
-- Actual implementation code
---------------------------------------------------------------------------

---------------------------------------------------------------------------
-- Local active configuration
local SCALE_FACTOR = {
   small = 1.15,
   big = 2.00
};
local CURRENT_SIZE = "small";

local OLD_ZOOM = {};

local AUTO_SCALE_OPTION = nil;
local BUFF_SLIDE_OPTION = nil;

---------------------------------------------------------------------------
-- Utility
local function WriteMessage(msg)
   DEFAULT_CHAT_FRAME:AddMessage(msg);
end

---------------------------------------------------------------------------
-- Config management
local function BigMinimap_FixScale()
   local newScale = SCALE_FACTOR[CURRENT_SIZE];
   if (newScale and (newScale ~= Minimap:GetScale())) then
      MinimapCluster:SetScale(newScale);
      local tmpScale = Minimap:GetScale();
      Minimap:SetScale(tmpScale + 0.1);
      Minimap:SetScale(tmpScale)
   end
end

local BUFF_SLIDE_BEFORE = nil;
local TicketStatusFrame_OnEvent_BeforeHook = nil;
function BigMinimap_AnchorBuffs(skipEnchantReset)
   if (not (BUFF_SLIDE_BEFORE or BUFF_SLIDE_OPTION)) then
      return;
   end
   -- Must hook ticket status display because it normally moves
   -- the enchantment frame.
   if (not TicketStatusFrame_OnEvent_BeforeHook) then
      TicketStatusFrame_OnEvent_BeforeHook = TicketStatusFrame_OnEvent;
      TicketStatusFrame_OnEvent = 
	 function()
	    TicketStatusFrame_OnEvent_BeforeHook();
	    BigMinimap_AnchorBuffs(true);
	 end
   end
	    
   BUFF_SLIDE_BEFORE = true;
   
   if (BUFF_SLIDE_OPTION) then
      BuffButton0:ClearAllPoints();
      BuffButton0:SetPoint("TOPRIGHT", "MinimapBorder", "TOPLEFT", -41, -5);

      TemporaryEnchantFrame:ClearAllPoints();
      TemporaryEnchantFrame:SetPoint("TOPLEFT", "BuffButton0", 
				     "TOPRIGHT", 10, 0);
   else
      BuffButton0:ClearAllPoints();
      if (not skipEnchantReset) then
	 TemporaryEnchantFrame:ClearAllPoints();
	 TemporaryEnchantFrame:SetPoint("TOPRIGHT", "UIParent",
					"TOPRIGHT", -175, -13);
      end
      BuffButton0:SetPoint("TOPRIGHT", "BuffFrame", "TOPRIGHT", 0, 0);
   end
end

local function BigMinimap_UpdateConfig()
   AUTO_SCALE_OPTION = BigMinimapConfig.autoScale;
   BUFF_SLIDE_OPTION = BigMinimapConfig.buffSlide;
   
   SCALE_FACTOR["small"] = BigMinimapConfig.scale_small or 1.15;
   SCALE_FACTOR["big"]   = BigMinimapConfig.scale_big or 2.00;

   if (AUTO_SCALE_OPTION) then
      BigMinimap_FixScale();
      BigMinimapFrame:Show();
   else
      BigMinimapFrame:Hide();
   end

   BigMinimap_AnchorBuffs();
end

local function BigMinimap_InitConfig(skipUpdate)
   BigMinimapConfig = {
      scale_small = 1.15,
      scale_big = 2.00,
      autoScale = true
   };
   if (not skipUpdate) then
      BigMinimap_UpdateConfig();
   end
end

local function BigMinimap_CheckConfig(skipUpdate) 
   if (BigMinimapConfig == nil) then
      BigMinimap_InitConfig(skipUpdate);
   end
end

local function BigMinimap_GetConfig(key)
   BigMinimap_CheckConfig();
   if (key == nil) then
      return BigMinimapConfig;
   else
      return BigMinimapConfig[key];
   end
end

local function BigMinimap_SetConfig(key, value)
   BigMinimap_CheckConfig(true);
   BigMinimapConfig[key] = value;
   BigMinimap_UpdateConfig();
   return BigMinimapConfig;
end

local function BigMinimap_SetConfigScale(scaleSize, value)
   BigMinimap_SetConfig("scale_" .. scaleSize, value);
   if (CURRENT_SIZE == scaleSize) then
      BigMinimap_FixScale();
   end
   WriteMessage("BigMinimap: Set " .. scaleSize .. " scale to " .. value);
end

---------------------------------------------------------------------------
-- Action functions
function BigMinimap_ToggleSize()
   local NEW_SIZE = "small";
   if (CURRENT_SIZE == 'small') then
      NEW_SIZE = 'big';
   end
   BigMinimap_SetSize(NEW_SIZE);
end

function BigMinimap_SetSize(newSize)
   BigMinimap_CheckConfig();
   if ((newSize == CURRENT_SIZE) or (not SCALE_FACTOR[newSize])) then
      return;
   end
      
   local oldZoom = Minimap:GetZoom();
   OLD_ZOOM[CURRENT_SIZE] = oldZoom;
   
   local NEW_SIZE = "small";
   if (CURRENT_SIZE == 'small') then
      NEW_SIZE = 'big';
   end

   local newScale = SCALE_FACTOR[NEW_SIZE];
   local newZoom = OLD_ZOOM[NEW_SIZE];

   CURRENT_SIZE = NEW_SIZE;

   if ((newZoom ~= nil) and (newZoom ~= oldZoom)) then
      Minimap:SetZoom(newZoom);
      if ( newZoom == (Minimap:GetZoomLevels() - 1) ) then
	 MinimapZoomIn:Disable();
      else
	 MinimapZoomIn:Enable();
      end
      
      if ( newZoom == 0 ) then
	 MinimapZoomOut:Disable();
      else
	 MinimapZoomOut:Enable();
      end
   end

   MinimapCluster:SetScale(newScale);
   local tmpScale = Minimap:GetScale();
   Minimap:SetScale(tmpScale + 0.1);
   Minimap:SetScale(tmpScale)
end

local function ValidateScale(argstr)
   arg = tonumber(argstr);
   if (arg) then
      if ((arg >= 0.0001) and (arg < 200)) then
	 return arg;
      end
   end
   WriteMessage("BigMinimap: Invalid scale factor '" .. argstr .. "'");
end

local function BigMinimap_Command(msg)
   local b,e,command,rest = string.find(msg, "^%s*([^%s]+)%s*(.*)$");
   local conf = BigMinimap_GetConfig();
   if (not b) then
      WriteMessage("BigMinimap (v0.9) - Current config:");
      WriteMessage("  /bigminimap smallscale " .. SCALE_FACTOR["small"]);
      WriteMessage("  /bigminimap bigscale " .. SCALE_FACTOR["big"]);
      if (AUTO_SCALE_OPTION) then
	 WriteMessage("  /bigminimap auto on");
      else
	 WriteMessage("  /bigminimap auto off");
      end
      if (BUFF_SLIDE_OPTION) then
	 WriteMessage("  /bigminimap buffslide on");
      else
	 WriteMessage("  /bigminimap buffslide off");
      end
      WriteMessage("  Other commands are: reset");
      return;
   end

   if (command == 'smallscale') then
      local scale = ValidateScale(rest);
      if (not scale) then
	 return;
      end
      BigMinimap_SetConfigScale("small", scale, true);
      return
   end

   if (command == 'bigscale') then
      local scale = ValidateScale(rest);
      if (not scale) then
	 return;
      end
      BigMinimap_SetConfigScale("big", scale, true);
      return
   end

   if (command == "auto") then
      if (rest == "on") then
	 BigMinimap_SetConfig("autoScale", true);
	 WriteMessage("BigMinimap: Enabled auto-application of scale");
      elseif (rest == "off") then
	 BigMinimap_SetConfig("autoScale", nil);
	 WriteMessage("BigMinimap: Disabled auto-application of scale");
      else
	 WriteMessage("BigMinimap: Unknown auto option '" .. rest .. "'");
      end
      return;
   end

   if (command == "buffslide") then
      if (rest == "on") then
	 BigMinimap_SetConfig("buffSlide", true);
	 WriteMessage("BigMinimap: Enabled buff sliding");
      elseif (rest == "off") then
	 BigMinimap_SetConfig("buffSlide", nil);
	 WriteMessage("BigMinimap: Disabled buff sliding");
      else
	 WriteMessage("BigMinimap: Unknown buffslide option '" .. rest .. "'");
      end
      return;
   end

   if (command == "reset") then
      BigMinimapConfig = nil;
      BigMinimap_InitConfig();
      WriteMessage("BigMinimap: Reset all options.");
      return;
   end

   WriteMessage("BigMinimap: Unknown command '" .. command .. "'");
end

---------------------------------------------------------------------------
-- FRAME FUNCTIONS

function BigMinimap_Frame_Init()
   SlashCmdList["BIGMINIMAPCOMMAND"] = BigMinimap_Command;
   this:RegisterEvent("ADDON_LOADED");
end

function BigMinimap_Frame_OnEvent(event)
   if ((event == 'ADDON_LOADED') and (arg1 == 'BigMinimap')) then
      BigMinimap_CheckConfig(true);
      BigMinimap_UpdateConfig();
      return;
   end
end

local NEXT_SCALE_RESET_TIME = GetTime() - 1;

function BigMinimap_Frame_OnUpdate(event)
   local keepShown = false;

   -- In theory this isn't needed anymore but i'll keep it for now
   if (AUTO_SCALE_OPTION) then
      keepShown = true;
      local curScale = MinimapCluster:GetScale();
      local newScale = SCALE_FACTOR[CURRENT_SIZE];

      if (newScale and (newScale ~= curScale)) then
	 local now = GetTime();
	 -- Dont spam rescales
	 if (now >= NEXT_SCALE_RESET_TIME) then
	    NEXT_SCALE_RESET_TIME = now + 5;
	    MinimapCluster:SetScale(newScale);
	    local tmpScale = Minimap:GetScale();
	    Minimap:SetScale(tmpScale + 0.1);
	    Minimap:SetScale(tmpScale)
	 end
      end
   end

   if (not keepShown) then
      this:Hide();
      return;
   end
end

