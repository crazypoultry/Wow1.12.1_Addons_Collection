assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRAPResurrection")
local G = AceLibrary("Gratuity-2.0")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["resurrection"] = true,
	["resurrectionparticipant"] = true,
	["Participant/Resurrection"] = true,
	["Options for resurrection."] = true,
	["Toggle"] = true,
	["toggle"] = true,
	["Rebirth"] = true,
	["Resurrection"] = true,
	["Redemption"] = true,
	["Ancestral Spirit"] = true,
	["Reincarnation"] = true,
	["^Corpse of (.+)$"] = true,
} end )

L:RegisterTranslations("deDE", function() return {
	["Rebirth"] = "Wiedergeburt",
	["Resurrection"] = "Auferstehung",
	["Redemption"] = "Auferstehung",
	["Ancestral Spirit"] = "Geist der Ahnen",
	["Reincarnation"] = "Reincarnation",
} end )

L:RegisterTranslations("frFR", function() return {
	["Rebirth"] = "Renaissance",
	["Resurrection"] = "R\195\169surrection",
	["Redemption"] = "R\195\169demption",
	["Ancestral Spirit"] = "Esprit Ancestral",
	["Reincarnation"] = "R\195\169incarnation",
} end )

L:RegisterTranslations("koKR", function() return {
--	["resurrection"] = "부활",
--	["resurrectionparticipant"] = "부활부분",
--	["toggle"] = "토글",

	["Participant/Resurrection"] = "부분/부활",
	["Options for resurrection."] = "부활 설정",
	["Toggle"] = "토글",
	["Rebirth"] = "환생",
	["Resurrection"] = "부활",
	["Redemption"] = "구원",
	["Ancestral Spirit"] = "고대의 영혼",
	["Reincarnation"] = "윤회",
	["^Corpse of (.+)$"] = "^([^%s]+)의 시체",
} end )

L:RegisterTranslations("zhCN", function() return {
	["resurrection"] = "复活术",
	["resurrectionparticipant"] = "resurrectionparticipant",
	["Participant/Resurrection"] = "Participant/Resurrection",
	["Options for resurrection."] = "复活的选项",
	["Toggle"] = "显示",
	["toggle"] = "显示",
	["Rebirth"] = "复生",
	["Resurrection"] = "复活术",
	["Redemption"] = "救赎",
	["Ancestral Spirit"] = "先祖之魂",
	["Reincarnation"] = "复生",
	["^Corpse of (.+)$"] = "^([^%s]+)的尸体",
} end )
----------------------------------
--      Module Declaration      --
----------------------------------

oRAPResurrection = oRA:NewModule(L["resurrectionparticipant"], "AceHook-2.0")
oRAPResurrection.defaults = {
}
oRAPResurrection.participant = true
oRAPResurrection.name = L["Participant/Resurrection"]
-- oRAPResurrection.consoleCmd = L"resurrection"
-- oRAPResurrection.consoleOptions = {
-- 	type = "group",
-- 	desc = L"Options for resurrection.",
-- 	args = {
-- 	}
-- }

------------------------------
--      Initialization      --
------------------------------

function oRAPResurrection:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRAPResurrection:OnEnable()
	self.spell = nil
	self.target = nil
	self.enabled = nil
	self:HookAndRegister()
end

function oRAPResurrection:OnDisable()
	self:UnregisterAllEvents()
	self:UnhookAll()
end

function oRAPResurrection:HookAndRegister()
	self:RegisterEvent("oRA_JoinedRaid")
	self:RegisterEvent("oRA_LeftRaid")
end

------------------------
--   Event Handlers   --
------------------------

function oRAPResurrection:oRA_JoinedRaid()
	if not self.enabled then
		self.enabled = true
		local _, c = UnitClass("player")
		if c == "DRUID" or c == "PRIEST" or c == "SHAMAN" or c == "PALADIN" then
			self:RegisterEvent("SPELLCAST_START")
			self:RegisterEvent("SPELLCAST_INTERRUPTED", "SpellFailed")
			self:RegisterEvent("SPELLCAST_FAILED", "SpellFailed")
			self:RegisterEvent("SPELLCAST_STOP", "SpellFailed")
			self:Hook("CastSpell")
			self:Hook("CastSpellByName")
			self:Hook("UseAction")
			self:Hook("SpellTargetUnit")
			self:Hook("SpellStopTargeting")
			self:Hook("TargetUnit")
			self:HookScript(WorldFrame, "OnMouseDown", "WorldFrameOnMouseDown")
		end
		self:Hook(StaticPopupDialogs["DEATH"], "OnShow", function()
				self.hooks[StaticPopupDialogs["DEATH"]].OnShow()
				if HasSoulstone() then self:SendMessage("CANRES") end end )

		self:Hook(StaticPopupDialogs["RESURRECT"], "OnShow", function()
				self.hooks[StaticPopupDialogs["RESURRECT"]].OnShow()
				self:SendMessage("RESSED") end )

		self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnShow", function()
				self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnShow()
				self:SendMessage("RESSED") end )

		self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnShow", function()
				self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnShow()
				self:SendMessage("RESSED") end )

		-- hrmf we can't hook the OnHide's normally, since they are not there. But
		-- blizzard will fire the OnHide if it finds it.
		-- so some more magic to get this working. And be friendly if someone else created
		-- an OnHide already.

		if not StaticPopupDialogs["RESURRECT"].OnHide then
			StaticPopupDialogs["RESURRECT"].OnHide = function() self:SendMessage("RESSED") end
		else 
			self:Hook(StaticPopupDialogs["RESURRECT"], "OnHide", function()
				self.hooks[StaticPopupDialogs["RESURRECT"]].OnHide()
				self:SendMessage("RESSED") end )
		end
		if not StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide then
			StaticPopupDialogs["RESURRECT_NO_SICKNESS"].OnHide = function() self:SendMessage("RESSED") end
		else
			self:Hook(StaticPopupDialogs["RESURRECT_NO_SICKNESS"], "OnHide", function()
				self.hooks[StaticPopupDialogs["RESURRECT_NO_SICKNESS"]].OnHide()
				self:SendMessage("RESSED") end )
		end
		if not StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide then
			StaticPopupDialogs["RESURRECT_NO_TIMER"].OnHide = function() self:SendMessage("RESSED") end
		else
			self:Hook(StaticPopupDialogs["RESURRECT_NO_TIMER"], "OnHide", function()
				self.hooks[StaticPopupDialogs["RESURRECT_NO_TIMER"]].OnHide()
				self:SendMessage("RESSED") end )
		end
	end
end

function oRAPResurrection:oRA_LeftRaid()
	self:DisableSpellHooking()
end

function oRAPResurrection:SPELLCAST_START(spell)
	if L:HasReverseTranslation(spell) and self.spell == spell and self.target then
		self:SendMessage("RES " .. self.target )
	end
end

function oRAPResurrection:SpellFailed()
	if self.spell and self.target and L:HasReverseTranslation(self.spell) then
		self:SendMessage("RESNO")
		self.spell = nil
		self.target = nil
	end
end

--------------
-- Disabler --
--------------

function oRAPResurrection:DisableSpellHooking()
	self:UnhookAll()
	self:UnregisterAllEvents()
	-- register our old stuff again
	self:HookAndRegister()
end

-------------
--  HOOKS  --
-------------	

function oRAPResurrection:CastSpell(id, tab)
	self.hooks["CastSpell"](id, tab)
	G:Erase()
	G:SetSpell(id, tab)
	local spellname = G:GetText(1,1,false,true)
	
	if spellname then
		if SpellIsTargeting() then
			self.spell = spellname
		elseif UnitExists("target") then
			self.spell = spellname
			self.target = UnitName("target")
		end
	end
end

function oRAPResurrection:CastSpellByName( a1, a2)
	self.hooks["CastSpellByName"](a1,a2)
	local _,_,spell = string.find(a1, "^([^%(]+)")
	if spell then
		if SpellIsTargeting() then
			self.spell = spell
		elseif UnitExists("target") then
			self.spell = spell
			self.target = UnitName("target")
		end
	end
end

function oRAPResurrection:UseAction( a1, a2, a3)
	self.hooks["UseAction"](a1, a2, a3)

	G:Erase()
	G:SetAction(a1)
	local spellname = G:GetLine(1)

	self.spell = spellname
	-- Test to see if this is a macro
	if GetActionText(a1) or not self.spell then
		return
	end
	
	if SpellIsTargeting() then
		-- Spell is waiting for a target
		return
	elseif a3 then
		-- Spell is being cast on the player
		self.target = UnitName("player")
	elseif UnitExists("target") then
		-- Spell is being cast on the current target
		self.target = UnitName("target")
	end
end

function oRAPResurrection:SpellTargetUnit( a1 )
	local shallTargetUnit
	if SpellIsTargeting() then
		shallTargetUnit = true
	end

	self.hooks["SpellTargetUnit"](a1)
	
	if shallTargetUnit and self.spell and not SpellIsTargeting() then
		self.target = UnitName(a1)
	end
end

function oRAPResurrection:SpellStopTargeting()
	self.hooks["SpellStopTargeting"]()
	self.spell = nil
	self.target = nil
end

function oRAPResurrection:TargetUnit( a1 )
	self.hooks["TargetUnit"](a1)

	if self.spell and UnitExists(a1) then
		self.target = UnitName(a1)
	end
end

function oRAPResurrection:WorldFrameOnMouseDown()
	if self.spell and UnitName("mouseover") then
		self.target = UnitName("mouseover")
	elseif self.spell and GameTooltipTextLeft1:IsVisible() then
		local _, _, name = string.find(GameTooltipTextLeft1:GetText(), L["^Corpse of (.+)$"])
		if ( name ) then
			self.target = name;
		end
	end
	self.hooks[WorldFrame]["OnMouseDown"]()
end

