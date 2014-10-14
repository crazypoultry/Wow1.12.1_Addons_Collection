BankItemsFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0");
local L = AceLibrary("AceLocale-2.2"):new("BankItemsFu");
local Tablet = AceLibrary("Tablet-2.0");

L:RegisterTranslations("enUS", function() return {
	["tabletHint"] = "Click to toggle BankItems.",
	["labelName"] = "BankItems",
} end);

BankItemsFu:RegisterDB("BankItemsFuDB");
BankItemsFu.hasIcon = true;
BankItemsFu.defaultPosition = "RIGHT";

local optionsTable = {
	handler = BankItemsFu,
	type = "group",
	args = {};
};

BankItemsFu:RegisterChatCommand({ "/bankitemsfu" }, optionsTable);
BankItemsFu.OnMenuRequest = optionsTable;

function BankItemsFu:OnTextUpdate()
	if (self:IsTextShown()) then
		self:ShowText();
		self:SetText("|cffffffff"..L["labelName"].."|r");
	else
		self:HideText();
	end
end

function BankItemsFu:OnTooltipUpdate()
	Tablet:SetHint(L["tabletHint"]);
end

function BankItemsFu:OnClick()
	BankItems_SlashHandler("all");
end
