--[[----------------------------------------------------------------------------
  ReMinimap.lua
  Author:	phresno
  Version:	1.2
  Revision:	7
  Created:	2006.06.27
  Updated:	2006.10.05

  See ChangeLog.txt for changes.

  See Readme.txt for more information and additional credits.
------------------------------------------------------------------------------]]

-- pseudo constants --
RMM_S_BORDER    = 01; -- indexes
RMM_S_MASK      = 02;
RMM_S_TRACK     = 03;
RMM_S_MAIL      = 04;
RMM_S_ZOOMIN    = 05;
RMM_S_ZOOMOUT   = 06;
RMM_S_BATTLE    = 07;
RMM_S_MEET      = 08;

RMM_ENABLE      = 01; -- indexes
RMM_CFG_VER     = 02;
RMM_STYLE       = 03;
RMM_SHOWTIME    = 04;
RMM_SHOWZOOM    = 05;
RMM_SHOWZONE    = 06;
RMM_ZOOMWHEEL   = 07;
RMM_MOVABLE     = 08;
RMM_ALPHA       = 10;
RMM_MAP_X       = 11;
RMM_MAP_Y       = 12;

RMM_ON          = "ON";
RMM_OFF         = "OFF";
RMM_BUTTON      = "BUTTON";
RMM_TOGGLE      = "TOGGLE"; -- state
RMM_DEFAULT     = "DEFAULT"; -- style
RMM_RESET       = "RESET";
RMM_VERSION     = "1.2";
RMM_VERSION_STR = "R|cffcc0000e|rMinimap v"..RMM_VERSION;
RMM_STYLE_PATH  = "Interface\\AddOns\\ReMinimap\\styles";
RMM_ALPHA_RATE  = 0.05;
RMM_DEF_X       = 1108.7059618725
RMM_DEF_Y       = 807.52936113582

RMM_FRAMES = {
   Minimap,
   MinimapCluster,
   MinimapBackdrop,
   MinimapZoneTextButton,
   MiniMapBattlefieldFrame,
   MiniMapMeetingStoneFrame,
   MiniMapMailFrame,
   GameTimeFrame,
   MiniMapTrackingFrame,
   MinimapZoomIn,
   MinimapZoomOut,
};

-- configuration settings (user changeable) --
rmm_default_cfg = {
   [RMM_ENABLE]     = true, -- entire mod
   [RMM_CFG_VER]    = RMM_VERSION,
   [RMM_STYLE]      = "DLX", -- minimap style
   [RMM_SHOWZOOM]   = true, -- show zoom buttons
   [RMM_ZOOMWHEEL]  = true, -- allow zoom control w/ mouse wheel
   [RMM_SHOWTIME]   = true, -- show the day/night indicator
   [RMM_SHOWZONE]   = true, -- show the location bar
   [RMM_MOVABLE]    = false,
   [RMM_ALPHA]      = 1, -- 100% opaque
   [RMM_MAP_X]      = false,
   [RMM_MAP_Y]      = false,
};

rmm_cfg = {};

--------------------------------------------------------------------------------
-- Main Program Control & Config Functions
--------------------------------------------------------------------------------

function Rmm_OnLoad()
   -- register events
   this:RegisterEvent("VARIABLES_LOADED");

   -- register slash commands
   SlashCmdList["REMINIMAP"] = Rmm_SlashCmdHandler;
   SLASH_REMINIMAP1 = "/rmm";

   -- register for movement
   for k,v in pairs(RMM_FRAMES) do
      v:RegisterForDrag("LeftButton");
      v:SetScript("OnDragStart", Rmm_OnDragStart);
      v:SetScript("OnDragStop", Rmm_OnDragStop);
   end

   -- print version string
   Rmm_Print(RMM_VERSION_STR.." loaded.");
end

function Rmm_OnEvent()
   if ("VARIABLES_LOADED" == event) then
      Rmm_Init();
      Rmm_Update();
   end
end

function Rmm_SlashCmdHandler(_msg)
   if (_msg) then
      local _, _, cmd, arg1 = string.find(string.upper(_msg), "([%w]+)%s*(.*)$");

      if ("HELP" == cmd) then
         Rmm_Cmd_Help();
      elseif ("TIME" == cmd) then
         Rmm_Cmd_Time(arg1);
      elseif ("ZOOM" == cmd) then
        Rmm_Cmd_Zoom(arg1);
      elseif ("WHEEL" == cmd or "ZOOMWHEEL" == cmd) then
         Rmm_Cmd_Wheel(arg1);
      elseif ("ZONE" == cmd or "LOCATION" == cmd) then
         Rmm_Cmd_Zone(arg1);
      elseif ("STYLE" == cmd) then
         Rmm_Cmd_Style(arg1);
      elseif ("ALPHA" == cmd) then
         Rmm_Cmd_Alpha(arg1);
      elseif ("MOVE" == cmd) then
         Rmm_Cmd_Movable(arg1);
      elseif ("RESET" == cmd) then
         Rmm_Cmd_Defaults(arg1);
      elseif ("STATUS" == cmd) then
         Rmm_Cmd_Status();
      elseif ("LOADMSG" == cmd) then
         Rmm_Cmd_Loadmsg();
      elseif ("REFRESH" == cmd) then
         Rmm_Update();
      else
         Rmm_Cmd_ModEnable(cmd);
      end
   end
end

--------------------------------------------------------------------------------
-- Slash commands (note: Rmm_Update() must be explicitly called)
--------------------------------------------------------------------------------

function Rmm_Cmd_Help()
   Rmm_Print(RMM_VERSION_STR.."\n");

   for k, v in pairs(RMM_HELP) do
      Rmm_Print(v);
   end
end

function Rmm_Cmd_Time(_set)
   Rmm_CfgToggle(RMM_SHOWTIME, _set);
   Rmm_Update();
end

function Rmm_Cmd_Zoom(_set)
   Rmm_CfgToggle(RMM_SHOWZOOM, _set);
   Rmm_Update();
end

function Rmm_Cmd_Wheel(_set)
   Rmm_CfgToggle(RMM_ZOOMWHEEL, _set);
end

function Rmm_Cmd_Zone(_set)
   Rmm_CfgToggle(RMM_SHOWZONE, _set);
   Rmm_Update();
end

function Rmm_Cmd_Movable(_set)
   if (RMM_RESET == _set) then
      Rmm_SetMapPos();
      Rmm_CfgSet(RMM_MAP_X, false);
      Rmm_CfgSet(RMM_MAP_Y, false);
   else
      if (RMM_ON == _set) then
         Rmm_FramesMovable(true);
         Rmm_CfgSet(RMM_MOVABLE, true);
      elseif (RMM_OFF == _set) then
         Rmm_FramesMovable(false);
         Rmm_CfgSet(RMM_MOVABLE, false);
      end
   end
end

function Rmm_Cmd_Alpha(_set)
   -- range and sanity checks
   _set = math.floor(_set); -- Blizz lua does not properly typecast

   if (nil == _set or 0 > _set) then
      _set = 0;
   elseif (100 < _set) then
      _set = 100;
   end

   _set = _set / 100;

   Rmm_CfgSet(RMM_ALPHA, _set);
   Rmm_Update();
end

function Rmm_Cmd_ModEnable(_set)
   Rmm_CfgToggle(RMM_ENABLE, _set);
   Rmm_Update();
end

function Rmm_Cmd_Style(_set)
   if (nil == _set) then _set = RMM_DEFAULT end

   if (nil ~= RMM_STYLES[_set]) then
      Rmm_CfgSet(RMM_STYLE, _set);
      Rmm_Update();
   else
      Rmm_Print("'".._set.."' "..RMM_HELP_INVSTYLE);
   end
end

function Rmm_Cmd_Defaults(_set)
   Rmm_Cfg_Init();
   Rmm_SetMapPos();
   Rmm_Update();
end

function Rmm_Cmd_Status()
   for k, v in pairs(rmm_cfg) do
      if (nil == v) then vstr = "nil";
      elseif (false == v) then vstr = "false";
      elseif (true == v) then vstr = "true";
      else vstr = v;
      end
      Rmm_Print("K:V = "..k..":"..vstr);
   end
end

function Rmm_Cmd_Loadmsg(_set)
   Rmm_CfgToggle(RMM_LOAD_MSG, _set);
end

--------------------------------------------------------------------------------
-- Main Program Control & Config Functions
--------------------------------------------------------------------------------

-- configuration (re)initialization
function Rmm_Cfg_Init()
   rmm_cfg = rmm_default_cfg;

   -- frames always (re)start locked
   rmm_cfg[RMM_MOVABLE] = false;
end

function Rmm_Init()
   -- if vars not loaded, or there's a version mismatch - defaults
   if (nil == rmm_cfg
       or nil == rmm_cfg[RMM_CFG_VER]
       or RMM_VERSION ~= rmm_cfg[RMM_CFG_VER]
      )
   then
      Rmm_Cfg_Init();
   end
end

function Rmm_Update()
   -- minimap style
   if (false == rmm_cfg[RMM_ENABLE]) then
      Rmm_SetStyle(RMM_DEFAULT);
      Rmm_SetZoomButton(true);
      Rmm_SetTimeOfDay(true);
      Rmm_SetZone(true);
      Rmm_SetAlpha(1);
   else
      Rmm_SetStyle(rmm_cfg[RMM_STYLE]);
      Rmm_SetZoomButton(rmm_cfg[RMM_SHOWZOOM]);
      Rmm_SetTimeOfDay(rmm_cfg[RMM_SHOWTIME]);
      Rmm_SetZone(rmm_cfg[RMM_SHOWZONE]);
      Rmm_SetAlpha(rmm_cfg[RMM_ALPHA]);
      MiniMapTrackingFrame:SetFrameStrata("HIGH"); -- fix tracking icon
   end

   -- zoom wheel is handled in the event function itself
end

function Rmm_SetStyle(_style)
   MinimapBorder:SetTexture(RMM_STYLES[_style][RMM_S_BORDER]);
   Minimap:SetMaskTexture(RMM_STYLES[_style][RMM_S_MASK]);
end

function Rmm_SetZoomButton(_state)
   -- do not disable the buttons, they're called by the scroll wheel
   if (false == _state) then
      MinimapZoomIn:Hide();
      MinimapZoomOut:Hide();
   else
      MinimapZoomIn:Show();
      MinimapZoomOut:Show();
   end
end

function Rmm_SetTimeOfDay(_state)
   if (false == _state) then
      GameTimeFrame:Hide();
   else
      GameTimeFrame:Show();
   end
end

function Rmm_SetZone(_state)
   if (false == _state) then
      MinimapZoneTextButton:Disable();
      MinimapToggleButton:Disable();
      MinimapZoneTextButton:Hide();
      MinimapToggleButton:Hide();
      MinimapBorderTop:Hide();
   else
      MinimapZoneTextButton:Show();
      MinimapToggleButton:Show();
      MinimapBorderTop:Show();
      MinimapZoneTextButton:Enable();
      MinimapToggleButton:Enable();
   end
end

function Rmm_SetAlpha(_val)
   Rmm_CfgSet(RMM_ALPHA, _val);
   MinimapCluster:SetAlpha(_val);
end

function Rmm_SetMapPos(_x, _y)
   MinimapCluster:ClearAllPoints()

   if (_x and _y) then
      MinimapCluster:SetPoint("CENTER", UIParent, "BOTTOMLEFT", _x, _y);
   else
      MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT");
   end
end

--------------------------------------------------------------------------------
-- On<Event> functions
--------------------------------------------------------------------------------

function Rmm_OnDragStart()
--Rmm_Print("____________________");
   if (rmm_cfg[RMM_MOVABLE]) then
--Rmm_Print("Movable: ok");
      MinimapCluster.moving = true;
      MinimapCluster:StartMoving();
   end
end

function Rmm_OnDragStop()
   MinimapCluster.moving  = false;

   MinimapCluster:StopMovingOrSizing();

   x, y = MinimapCluster:GetCenter();

   Rmm_CfgSet(RMM_MAP_X, x);
   Rmm_CfgSet(RMM_MAP_Y, y);
end

function Rmm_Map_OnMouseWheel(_arg)
   if (IsControlKeyDown()) then
      Rmm_SetAlpha(Rmm_AlphaChange(rmm_cfg[RMM_ALPHA], _arg));
   elseif (rmm_cfg[RMM_ZOOMWHEEL]) then
      if (_arg > 0) then
         Minimap_ZoomIn();
      elseif (_arg < 0 ) then
         Minimap_ZoomOut();
      end
   end
end

--------------------------------------------------------------------------------
-- Generic functions (library style functions)
--------------------------------------------------------------------------------

function Rmm_Print(_text)
   if (_text) then DEFAULT_CHAT_FRAME:AddMessage(_text); end
end

function Rmm_CfgToggle(_opt, _state)
   if (nil ~= _state) then
      _state = string.upper(_state); -- insurance
   end

   if (RMM_ON == _state) then
      rmm_cfg[_opt] = true;
   elseif (RMM_OFF == _state) then
      rmm_cfg[_opt] = false;
   else
      if (rmm_cfg[_opt]) then
         rmm_cfg[_opt] = false;
      else
         rmm_cfg[_opt] = true;
      end
   end

   return rmm_cfg[_opt];
end

function Rmm_CfgSet(_opt, _val)
   rmm_cfg[_opt] = _val;

   return rmm_cfg[_opt];
end

function Rmm_AlphaChange(_cur, _chg)
   -- change by arbitrary rate
   if(_chg > 0 and _cur < 1) then
      _cur = _cur + RMM_ALPHA_RATE;
   elseif (_chg < 0 and _cur > 0) then
      _cur = _cur - RMM_ALPHA_RATE;
   end

   -- sanity check
   if (0 > _cur) then
      _cur = 0;
   elseif (1 < _cur) then
      _cur = 1;
   end

   return _cur;
end

function Rmm_FramesMovable(_state)
   for _, frame in pairs(RMM_FRAMES) do
      frame:SetMovable(_state);
   end
end