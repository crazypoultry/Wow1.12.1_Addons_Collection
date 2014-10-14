KTMFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.2"):new("KTMFu");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Click to toggle KLH Threat Meter.",
	["labelName"] = "KTM",
} end);

KTMFu:RegisterDB("KTMFuDB");
KTMFu.hasIcon = true;
KTMFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = KTMFu,
	type = "group",
	args = {};
};

local state = KLHTM_GuiState;

KTMFu:RegisterChatCommand({ "/ktmfu" }, optionsTable);
KTMFu.OnMenuRequest = optionsTable;

function KTMFu:OnTextUpdate()
	if (self:IsTextShown()) then
		self:ShowText();
		self:SetText("|cffffffff"..L["labelName"].."|r");
	else
		self:HideText();
	end
end

function KTMFu:OnTooltipUpdate()
	Tablet:SetHint(L["tabletHint"]);
end

function KTMFu:OnClick()
	if (state.closed == false) then
		KLHTM_SetVisible(false);
	else
		KLHTM_SetVisible(true);
	end
end