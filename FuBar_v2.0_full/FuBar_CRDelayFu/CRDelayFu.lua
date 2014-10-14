CRDelayFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceConsole-2.0", "AceDB-2.0")

CRDelayFu.version = "2.0." .. string.sub("$Revision: 1$", 12, -3)
CRDelayFu.date    = string.sub("$Date: 2006-08-25 01:18:28 -0400 (Fri, 25 Aug 2006) $", 8, 17)
CRDelayFu.hasIcon = "Interface\\Icons\\Ability_Vanish"

AceLibrary("AceLocale-2.1"):RegisterTranslation("CRDelayFu", "enUS", function()
	return { ["No Delay"] = "No Delay" }
end)

local L      = AceLibrary("AceLocale-2.1"):GetInstance("CRDelayFu", true)
local Abacus = AceLibrary("Abacus-2.0")
local Crayon = AceLibrary("Crayon-2.0")
local Metro  = AceLibrary("Metrognome-2.0")

CRDelayFu:RegisterChatCommand({"/crdelayfu", "/crdfu"})

function CRDelayFu:OnEnable()
	Metro:Register("CRDelayFu", self.Update, 1, self)
	Metro:Start(self.name)
end

function CRDelayFu:OnDisable()
	Metro:Stop("CRDelayFu")
end

function CRDelayFu:OnTextUpdate()
	local crDelay = GetCorpseRecoveryDelay()
	if crDelay == 0 then
		self:SetText(format("|cff%s%s|r", Crayon.COLOR_HEX_GREEN, L["No Delay"]))
	else
		self:SetText(format("|cff%s%s|r", Crayon:GetThresholdHexColor(1 - crDelay/30), Abacus:FormatDurationCondensed(crDelay)))
	end
end
