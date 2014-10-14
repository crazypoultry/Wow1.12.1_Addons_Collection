assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAPCoolDown")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["cd"] = true,
	["cooldown"] = true,
	["cooldownparticipant"] = true,
	["Options for cooldowns."] = true,
	["Rebirth"] = true,
	["Soulstone Resurrection"] = true,
	["Reincarnation"] = true,
	["Improved Reincarnation"] = true,
	["gain Soulstone Resurrection"] = true,
	["gains Soulstone Resurrection"] = true,
	["Divine Intervention"] = true,
	["Participant/CoolDown"] = true,
} end )

L:RegisterTranslations("deDE", function() return {
	["Rebirth"] = "Wiedergeburt",
	["Soulstone Resurrection"] = "Seelenstein-Auferstehung",
	["Reincarnation"] = "Reinkarnation",
	["Improved Reincarnation"] = "Verbesserte Reinkarnation",
} end )

L:RegisterTranslations("frFR", function() return {
	["Rebirth"] = "Renaissance",
	["Soulstone Resurrection"] = "R\195\169surrection de Pierre d\'\195\162me",
	["Reincarnation"] = "R\195\169incarnation",
	["Improved Reincarnation"] = "R\195\169incarnation am\195\169lior\195\169e",
	["gain Soulstone Resurrection"] = "gagnez R\195\169surrection de Pierre d'\195\162me",
	["gains Soulstone Resurrection"] = "gagne R\195\169surrection de Pierre d'\195\162me",
} end )

L:RegisterTranslations("koKR", function() return {
--	["cd"] = "재사용",
--	["cooldown"] = "재사용대기시간",
--	["cooldownparticipant"] = "재사용대기시간부분",

	["Options for cooldowns."] = "재사용대기시간 설정",
	["Rebirth"] = "환생",
	["Soulstone Resurrection"] = "영혼석 보관",
	["Reincarnation"] = "윤회",
	["Improved Reincarnation"] = "윤회 연마",
	["gain Soulstone Resurrection"] = "영혼석 보관 효과를 얻었습니다",
	["gains Soulstone Resurrection"] = "님이 영혼석 보관 효과를 얻었습니다",
	["Divine Intervention"] = "성스러운 중재",
	["Participant/CoolDown"] = "부분/재사용대기시간",
} end )

L:RegisterTranslations("zhCN", function() return {
	["cd"] = "cd",
	["cooldown"] = "cooldown",
	["cooldownparticipant"] = "cooldownparticipant",
	["Options for cooldowns."] = "冷却监视器选项",
	["Rebirth"] = "复生",
	["Soulstone Resurrection"] = "灵魂石冷却",
	["Reincarnation"] = "复生",
	["Improved Reincarnation"] = "强化复生",
	["gain Soulstone Resurrection"] = "获得灵魂石",
	["gains Soulstone Resurrection"] = "获得灵魂石",
	["Divine Intervention"] = "神圣干涉",
	["Participant/CoolDown"] = "Participant/CoolDown",
} end )
----------------------------------
--      Module Declaration      --
----------------------------------

oRAPCoolDown = oRA:NewModule(L["cooldownparticipant"], "AceHook-2.0")
oRAPCoolDown.defaults = {
}
oRAPCoolDown.participant = true
oRAPCoolDown.name = L["Participant/CoolDown"]
-- oRAPCoolDown.consoleCmd = L"cd"
-- oRAPCoolDown.consoleOptions = {
-- 	type = "group",
-- 	desc = L"Options for cooldowns.",
-- 	args = {
-- 	}
-- }


------------------------------
--      Initialization      --
------------------------------

function oRAPCoolDown:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRAPCoolDown:OnEnable()

	self.spell = nil
	self.sscasting = nil
	self.rescasting = nil

	local _, c = UnitClass("player")
	if c == "DRUID" or c == "WARLOCK" or c == "PALADIN" then
		self:RegisterEvent("SPELLCAST_START")
		self:RegisterEvent("SPELLCAST_FAILED", "SpellFailed")
		self:RegisterEvent("SPELLCAST_INTERRUPTED", "SpellFailed")
		self:RegisterEvent("SPELLCAST_STOP")
		if c == "WARLOCK" then
			self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_FRIENDLYPLAYER_BUFFS", "CheckSoulstone")
			self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS", "CheckSoulstone")
			self:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_BUFFS", "CheckSoulstone")
		end
	elseif c == "SHAMAN" then
		self:Hook("UseSoulstone")
	end
end

function oRAPCoolDown:OnDisable()
	self:UnregisterAllEvents()
	self:UnhookAll()
end


-------------------------------
--      Event Handlers       --
-------------------------------

function oRAPCoolDown:SPELLCAST_START( arg1 )
	self.spell = arg1
	if self.spell == L["Soulstone Resurrection"] then
		self.sscasting = true
	elseif self.spell == L["Rebirth"] then
		self.rescasting = true
	elseif self.spell == L["Divine Intervention"] then
		self.rescasting = true
	end
end

function oRAPCoolDown:SPELLCAST_STOP( arg1 )
	if self.spell == L["Rebirth"] then
		self.rescasting = nil
		self.spell = nil
		self:SendMessage("CD 1 30")
	elseif self.spell == L["Divine Intervention"] then
		self.rescasting = nil
		self.spell = nil
		self:SendMessage("CD 4 60", true) -- only oRA2 clients will receive this cooldown I just numbered on.
	end
end

function oRAPCoolDown:SpellFailed()
	if self.spell == L["Rebirth"] then self.rescasting = nil end
	if self.spell == L["Soulstone Resurrection"] then self.sscasting = nil end
	if self.spell == L["Divine Intervention"] then self.rescasting = nil end
end

function oRAPCoolDown:CheckSoulstone( arg1 )
	if self.sscasting then
		if string.find(arg1, L["gains Soulstone Resurrection"] or string.find( arg1, L["gain Soulstone Resurrection"]) ) then
			self.spell = nil
			self.sscasting = nil
			self:SendMessage("CD 3 30")
		end
	end
end

---------------
--   Hooks   --
---------------

function oRAPCoolDown:UseSoulstone()
	local text = HasSoulstone()
	if text and text == L["Reincarnation"] then
		local cooldown = 60
		for tab = 1, GetNumTalentTabs(), 1 do
			for talent = 1, GetNumTalents(tab), 1 do
				local name, _, _, _, rank = GetTalentInfo(tab, talent)
				if name == L["Improved Reincarnation"] then
					cooldown = cooldown - (rank*10)
					break
				end
			end
			if cooldown then break end
			self:SendMessage("CD 2 " .. cooldown )
		end
	end
	self.hooks["UseSoulstone"]()
end