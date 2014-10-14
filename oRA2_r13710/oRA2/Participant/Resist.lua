
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAPResist")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["resist"] = true,
	["resistparticipant"] = true,
	["Options for resistance checks."] = true,
	["Participant/Resist"] = true,
} end )

L:RegisterTranslations("koKR", function() return {
--	["resist"] = "저항",
--	["resistparticipant"] = "저항부분",

	["Options for resistance checks."] = "저항 확인 설정",
	["Participant/Resist"] = "부분/저항",
} end )

L:RegisterTranslations("zhCN", function() return {
	["resist"] = "抗性",
	["resistparticipant"] = "resistparticipant",
	["Options for resistance checks."] = "抗性助手选项",
	["Participant/Resist"] = "Participant/Resist",
} end )
----------------------------------
--      Module Declaration      --
----------------------------------

oRAPResist = oRA:NewModule(L["resistparticipant"])
oRAPResist.defaults = {
}
oRAPResist.participant = true
oRAPResist.name = L["Participant/Resist"]
-- oRAPResist.consoleCmd = L["resist"]
-- oRAPResist.consoleOptions = {
-- 	type = "group",
-- 	desc = L"Options for resistance checks.",
-- 	args = {
-- 	}
-- }

------------------------------
--      Initialization      --
------------------------------

function oRAPResist:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRAPResist:OnEnable()
	self:RegisterCheck("RSTC", "oRA_ResistanceCheck")
end

function oRAPResist:OnDisable()
	self:UnregisterAllEvents()
	self:UnregisterCheck("RSTC")
end


-------------------------
--   Event Handlers    --
-------------------------

function oRAPResist:oRA_ResistanceCheck( msg, author)
	if not self:IsValidRequest(author) then return end
	local resiststr = ""
	for i = 2, 6, 1 do
		local _, res, _, _ = UnitResistance("player", i)
		resiststr = resiststr .." " .. res
	end
	self:SendMessage(string.format("RST%s %s", resiststr, author))	
end
