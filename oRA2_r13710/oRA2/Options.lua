
assert(oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAOptions")
local Tablet = AceLibrary("Tablet-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	tablethint = "oRA Options.",
	["Active boss modules"] = true,
	["Hidden"] = true,
	["Shown"] = true,
	["minimap"] = true,
	["Minimap"] = true,
	["Toggle the minimap button."] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	tablethint = "oRA 설정.",
--	["minimap"] = "미니맵",

	["Active boss modules"] = "보스 모듈 활성화",
	["Hidden"] = "숨김",
	["Shown"] = "표시",
	["Minimap"] = "미니맵",
	["Toggle the minimap button."] = "미니맵 버튼 토글",
} end)


L:RegisterTranslations("zhCN", function() return {
	tablethint = "oRA 选项",
	["Active boss modules"] = "激活boss模块",
	["Hidden"] = "隐藏",
	["Shown"] = "显示",
	["minimap"] = "小地图",
	["Minimap"] = "小地图",
	["Toggle the minimap button."] = "显示小地图图标",
} end)

----------------------------------
--      Module Declaration      --
----------------------------------

local deuce = oRA:NewModule("Options Menu")
deuce.consoleCmd = not FuBar and L["minimap"]
deuce.consoleOptions = not FuBar and {
	type = "toggle",
	name = L["Minimap"],
	desc = L["Toggle the minimap button."],
	get = function() return oRAOptions.minimapFrame and oRAOptions.minimapFrame:IsVisible() or false end,
	set = function(v) if v then oRAOptions:Show() else oRAOptions:Hide() end end,
	map = {[false] = L["Hidden"], [true] = L["Shown"]},
	hidden = function() return FuBar and true end,
}

----------------------------
--      FuBar Plugin      --
----------------------------

oRAOptions = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
oRAOptions.name = "FuBar - oRA"
oRAOptions:RegisterDB("oRAFubarDB")

oRAOptions.hasIcon = "Interface\\Icons\\INV_Misc_Orb_02"
oRAOptions.defaultMinimapPosition = 180
oRAOptions.cannotDetachTooltip = true
oRAOptions.hideWithoutStandby = true

-- total hack
oRAOptions.OnMenuRequest = deuce.core.consoleOptions
local args = AceLibrary("FuBarPlugin-2.0"):GetAceOptionsDataTable(oRAOptions)
for k,v in pairs(args) do
	if oRAOptions.OnMenuRequest.args[k] == nil then
		oRAOptions.OnMenuRequest.args[k] = v
	end
end
-- end hack

-----------------------------
--      FuBar Methods      --
-----------------------------

function oRAOptions:OnTooltipUpdate()
	Tablet:SetHint(L["tablethint"])
end
