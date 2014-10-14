--{{{ Libraries

local RL = AceLibrary("RosterLib-2.0")
local Banzai = AceLibrary("Banzai-1.0")
local BS = AceLibrary("Babble-Spell-2.2")
local L = AceLibrary("AceLocale-2.2"):new("Grid")

--}}}

GridStatusHeals = GridStatus:NewModule("GridStatusHeals", "AceComm-2.0", "AceHook-2.1")
GridStatusHeals.menuName = L["Heals"]

--{{{ AceDB defaults

GridStatusHeals.defaultDB = {
	debug = false,
	alert_heals = {
		text = "incoming heals",
		enable = true,
		color = { r = 0, g = 1, b = 0, a = 1 },
		priority = 50,
		range = true,
	},
}

--}}}

--{{{ locals

-- whenever this module recieves an AceComm event, combat log scan from sender 
-- will be skipped and AceComm will be used instead
local gridusers = {} 

-- spells we want to watch. need to add localizations via BabbleSpell later
local watchSpells = {
	[BS["Holy Light"]] = true,
	[BS["Flash of Light"]] = true,
	[BS["Flash Heal"]] = true,
	[BS["Greater Heal"]] = true,
	[BS["Heal"]] = true,
	[BS["Healing Touch"]] = true,
	[BS["Lesser Healing Wave"]] = true,
	[BS["Healing Wave"]] = true,
	[BS["Regrowth"]] = true,
	[BS["Prayer of Healing"]] = true,
}

--}}}



if not Grid.isTBC then

--{{{ 1.12 version

	function GridStatusHeals:OnInitialize()
		self.super.OnInitialize(self)
		self:RegisterStatus("alert_heals", L["Incoming heals"])
		self:SetCommPrefix("Grid")
	end


	function GridStatusHeals:OnEnable()
		-- create tooltip to parse outgoing spells
		if not self.tooltip then
			self.tooltip = CreateFrame("GameTooltip", "GridStatusHeals_Tooltip", UIParent, "GameTooltipTemplate")
			self.tooltip:SetScript("OnLoad",function() this:SetOwner(WorldFrame, "ANCHOR_NONE") end)
		end
		-- find healing spells being cast to send to others
		self:Hook("CastSpell")
		self:Hook("CastSpellByName")
		self:Hook("UseAction")
		self:Hook("SpellTargetUnit")
		self:Hook("SpellStopTargeting")
		self:Hook("TargetUnit")
		self:HookScript(WorldFrame,"OnMouseDown","GridStatusHealsOnMouseDown")
		-- register events
		self:RegisterEvent("SPELLCAST_START")
		self:RegisterEvent("SPELLCAST_STOP")
		self:RegisterEvent("CHAT_MSG_SPELL_FRIENDLYPLAYER_BUFF","CombatLogHeal")
		self:RegisterEvent("CHAT_MSG_SPELL_PARTY_BUFF","CombatLogHeal")
		-- AceComm
		self:RegisterComm(self.commPrefix, "GROUP", "OnCommReceive")
	end


	function GridStatusHeals:CombatLogHeal(msg)
		-- SPELLCASTOTHERSTART = "%s begins to cast %s.";
		for helper, spell in string.gfind(msg, L["(.+) begins to cast (.+)."]) do
			self:Debug("::"..spell);
			if not watchSpells[spell] then return end
			local unitid = RL:GetUnitIDFromName(helper)

			if not helper or not spell or not unitid then return end
			if gridusers[helper] then return end
			if spell == BS["Prayer of Healing"] then
				self:GroupHeal(helper)
			else
				local u = RL:GetUnitObjectFromUnit(unitid.."target")
				if not u then return end
				-- filter units that are probably not the correct unit
				if UnitHealth(u.unitid)/UnitHealthMax(u.unitid) < 0.9 or Banzai:GetUnitAggroByUnitId(u.unitid) then
					self:UnitIsHealed(u.name)
				end
			end
		end
	end


	function GridStatusHeals:OnCommReceive(prefix, sender, distribution, what, who)
	    if sender == UnitName("player") then return end
		if not RL:GetUnitIDFromName(sender) then return end
		gridusers[sender] = true
		if what == "HN" then
			self:UnitIsHealed(who)
		elseif what == "HG" then
			self:GroupHeal(sender)
		end
	end


	function GridStatusHeals:GroupHeal(healer)
		local u1 = RL:GetUnitObjectFromName(healer)
		if not u1 then return end

		for u2 in RL:IterateRoster() do
			if u2.subgroup == u1.subgroup then
				self:UnitIsHealed(u2.name)
			end
		end
	end


	function GridStatusHeals:UnitIsHealed(name)
		local settings = self.db.profile.alert_heals
		self.core:SendStatusGained(name, "alert_heals",
				  settings.priority,
				  (settings.range and 40),
				  settings.color,
				  settings.text)

		-- this will overwrite any previously scheduled event for the same name
		self:ScheduleEvent("HealCompleted_"..name, self.HealCompleted, 2, self, name)
	end


	function GridStatusHeals:HealCompleted(name)
		self.core:SendStatusLost(name, "alert_heals")
	end


	function GridStatusHeals:SPELLCAST_START()
		-- problem: with high latency the message is sent at latency*2+scheduler as we're waiting for the server ack
		if self.spell == arg1 and watchSpells[arg1] and self.target then
			if self.spell == BS["Prayer of Healing"] then
				self:GroupHeal(playerName)
				self:SendCommMessage("GROUP", "HG")
			else
				if RL:GetUnitIDFromName(self.target) then
					self:SendCommMessage("GROUP", "HN", self.target)
				end
			end
		end
	end


	function GridStatusHeals:SPELLCAST_STOP()
		self.target = nil
	end


	--{{{ hooks 
	
	-- we need to replace these in TBC by a different logic

	function GridStatusHeals:CastSpell(spellId, spellbookTabNum)
		self.hooks["CastSpell"](spellId, spellbookTabNum)
		GridStatusHeals_Tooltip:SetSpell(spellId, spellbookTabNum)
		local spellName = GridStatusHeals_TooltipTextLeft1:GetText()
		if SpellIsTargeting() then 
			self.spell = spellName
		elseif UnitExists("target") then
			self.spell = spellName
			self.target = UnitName("target")
		end
	end


	function GridStatusHeals:CastSpellByName(a1, a2)
		self.hooks["CastSpellByName"](a1, a2)
		local _, _, spellName = string.find(a1, "^([^%(]+)");
		if spellName then
			if SpellIsTargeting() then
				self.spell = spellName
			else
				self.spell = spellName
				self.target = UnitName("target")
			end
		end
	end


	function GridStatusHeals:UseAction(a1, a2, a3)
		GridStatusHeals_Tooltip:SetAction(a1)
		local spellName = GridStatusHeals_TooltipTextLeft1:GetText()
		self.spell = spellName
		self.hooks["UseAction"](a1, a2, a3)
		if GetActionText(a1) or not self.spell then return end
		if SpellIsTargeting() then return
		elseif a3 then
			self.target = UnitName("player")
		elseif UnitExists("target") then
			self.target = UnitName("target")
		end
	end


	function GridStatusHeals:SpellTargetUnit(a1)
		local shallTargetUnit
		if SpellIsTargeting() then
			shallTargetUnit = true
		end
		self.hooks["SpellTargetUnit"](a1)
		if shallTargetUnit and self.spell and not SpellIsTargeting() then
			self.target = UnitName(a1)
		end
	end


	function GridStatusHeals:SpellStopTargeting()
		self.hooks["SpellStopTargeting"]()
		self.spell = nil
		self.target = nil
	end


	function GridStatusHeals:TargetUnit(a1)
		self.hooks["TargetUnit"](a1)
		if self.spell and UnitExists(a1) then
			self.target = UnitName(a1)
		end
	end


	function GridStatusHeals:GridStatusHealsOnMouseDown()
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

	--}}}

--}}}



elseif Grid.isTBC then


--{{{ TBC version


	function GridStatusHeals:OnInitialize()
		self.super.OnInitialize(self)
		self:RegisterStatus("alert_heals", L["Incoming heals"])
		self:SetCommPrefix("Grid")
	end


	function GridStatusHeals:OnEnable()
		-- register events
		self:RegisterEvent("UNIT_SPELLCAST_START")
		self:RegisterEvent("UNIT_SPELLCAST_SENT")
		-- AceComm
		self:RegisterComm(self.commPrefix, "GROUP", "OnCommReceive")
	end

	function GridStatusHeals:UNIT_SPELLCAST_START(unit)
		local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
		-- find out how spell and displayName differ. I guess displayName is localized?
	
		if not watchSpells[spell] then return end
		local helper = UnitName(unit)
		local unitid = RL:GetUnitIDFromName(helper)
	
		if not helper or not spell or not unitid then return end
		if gridusers[helper] then return end
	
		if spell == BS["Prayer of Healing"] then
			self:GroupHeal(helper)
		else
			local u = RL:GetUnitObjectFromUnit(unit.."target")
			if not u then return end
	--		self:Debug(UnitName(unit), "is healing", u.name)
			-- filter units that are probably not the correct unit
			if UnitHealth(u.unitid)/UnitHealthMax(u.unitid) < 0.9 or Banzai:GetUnitAggroByUnitId(u.unitid) then
				self:UnitIsHealed(u.name)
			end
		end
	end


	function GridStatusHeals:OnCommReceive(prefix, sender, distribution, what, who)
		self:Debug("OnCommReceive", prefix, sender, distribution)
	    if sender == UnitName("player") then return end
		if not RL:GetUnitIDFromName(sender) then return end
		gridusers[sender] = true
		if what == "HN" then
			self:UnitIsHealed(who)
		elseif what == "HG" then
			self:GroupHeal(sender)
		end
	end


	function GridStatusHeals:GroupHeal(healer)
		local u1 = RL:GetUnitObjectFromName(healer)
		if not u1 then return end

		for u2 in RL:IterateRoster() do
			if u2.subgroup == u1.subgroup then
				self:UnitIsHealed(u2.name)
			end
		end
	end


	function GridStatusHeals:UnitIsHealed(name)
		local settings = self.db.profile.alert_heals
		self.core:SendStatusGained(name, "alert_heals",
				  settings.priority,
				  (settings.range and 40),
				  settings.color,
				  settings.text)

		-- this will overwrite any previously scheduled event for the same name
		self:ScheduleEvent("HealCompleted_"..name, self.HealCompleted, 2, self, name)
	end


	function GridStatusHeals:HealCompleted(name)
		self.core:SendStatusLost(name, "alert_heals")
	end



	function GridStatusHeals:UNIT_SPELLCAST_SENT(unit, spell, rank, target)
		if not unit == "player" then
			self:Debug("UNIT_SPELLCAST_SENT for unit:", unit)
		else
	--		self:Debug("UNIT_SPELLCAST_SENT", unit, spell, rank, target)
			if watchSpells[spell] then
				if spell == BS["Prayer of Healing"] then
					self:GroupHeal(playerName)
	--				self:Debug("sending group heal")
					self:SendCommMessage("GROUP", "HG")
				else
	--				self:Debug("sending heal on", target)
					self:SendCommMessage("GROUP", "HN", target )
				end
			end
		end
	end

--}}}

end
