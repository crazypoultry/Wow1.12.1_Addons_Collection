ScaleFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.0"):new("ScaleFu");
local Dewdrop = AceLibrary("Dewdrop-2.0");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Right-click to adjust UI scale.",
	["currentuiScale"] = "Current UI Scale: ",
	["uiScale"] = "UI Scale",
	["attention"] = "Attention!",
	["validValues"] = "Only values of 0.64 to 1.0 are valid.",
	["tooLow"] = "The scale entered was too small and was automatically adjusted to 0.64",
	["tooHigh"] = "The scale entered was too large and was automatically adjusted to 1.00",
} end);

ScaleFu:RegisterDB("ScaleFuDB");
ScaleFu.hasNoText  = true;
ScaleFu.hasIcon = true;
ScaleFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = ScaleFu,
	type = "group",
	args = {};
};

ScaleFu:RegisterChatCommand({ "/scalefu" }, optionsTable);
ScaleFu.OnMenuRequest = optionsTable;

function ScaleFu:OnTooltipUpdate()
	local cat = Tablet:AddCategory(
		"text", L"currentuiScale"..floor(UIParent:GetEffectiveScale()*100+0.5).."%",
		"justify", "CENTER"
	);

	cat:AddLine("text", "");

	Tablet:SetHint(L"tabletHint");
end

function ScaleFu:OnMenuRequest(value)
	Dewdrop:AddLine(
		"text", L"uiScale",
		"hasArrow", TRUE,
		"hasEditBox", TRUE,
		"tooltipTitle", L"attention",
		"tooltipText", L"validValues",
		"editBoxFunc", function(value)
			if (tonumber(value) < 0.64) then
				value = 0.64;
				DEFAULT_CHAT_FRAME:AddMessage(L"tooLow");
			elseif (tonumber(value) > 1.00) then
				value = 1.00;
				DEFAULT_CHAT_FRAME:AddMessage(L"tooHigh");
			end
			SetCVar("useUiScale", 1, USE_UISCALE);	-- Set the use UI scale option to true
			SetCVar("uiScale", value);		-- Set the UI scale
			FuBar:OnInitialize();			-- Refresh FuBar to correctly size itself
		end,
		"editBoxText", UIParent:GetEffectiveScale()	-- Set the text to the current UI scale when opening the slider menu
	);

	Dewdrop:AddLine("text", "");
end