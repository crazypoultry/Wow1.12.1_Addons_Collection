local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local _G = getfenv(0)

TinyTipFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "FuBarPlugin-2.0")
TinyTipFu.version = "1"
TinyTipFu.hasIcon = true
TinyTipFu.hasNoText = true
TinyTipFu.defaultPosition = "LEFT"

local HINT

if ( GetLocale() == "koKR" ) then
	HINT = "우클릭시 TinyTip 설정창을 엽니다."
else
	HINT = "Right-Click to open TinyTip options."
end

function TinyTipFu:OnMenuRequest(level, value)
  _G.TinyTip_LoDRun("TinyTipOptions", "TinyTipOptions_SetLocals", _G.TinyTip_GetDB())
  _G.TinyTipOptions_CreateDDMenu(level, value)
  
  -- Add a spacer between this and the rest of the FBP menu.
  if level == 1 then
    dewdrop:AddLine()
  end
end

function TinyTipFu:OnTooltipUpdate()
  tablet:SetHint(HINT)
end