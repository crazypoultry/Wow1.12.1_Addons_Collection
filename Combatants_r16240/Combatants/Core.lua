
------------------------------
--      Are you local?      --
------------------------------

local tablet = AceLibrary("Tablet-2.0")

local iconsafe = "Interface\\Icons\\Spell_Arcane_TeleportIronForge"
local iconcombat = "Interface\\Icons\\Spell_Arcane_TeleportOrgrimmar"
local count = 0


-------------------------------------
--      Namespace Declaration      --
-------------------------------------

Combatants = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
Combatants.hasIcon = iconsafe
Combatants.tooltipHiddenWhenEmpty = true
Combatants.independentProfile = true
Combatants:RegisterDB("CombatantsDB")
Combatants:RegisterDefaults("profile", {
	showpets = true,
	threshold = 4,
})
Combatants.OnMenuRequest = {
	type = "group",
	args = {
		pets = {
			name = "Include Pets",
			desc = "Include Pets as Combatants",
			type = "toggle",
			get = function() return Combatants.db.profile.showpets end,
			set = function(v) Combatants.db.profile.showpets = v end,
		},
		threshold = {
			name = "Condense threshold",
			desc = "Threshold for displaying \"## players in combat\" in detached tooltip",
			type = "range",
			min = 0, max = 40, step = 1,
			get = function() return Combatants.db.profile.threshold end,
			set = function(v) Combatants.db.profile.threshold = v end,
			disabled = function() return not Combatants:IsTooltipDetached() end,
		},
	}
}


function Combatants:OnEnable()
	self:ScheduleRepeatingEvent("Combatants_Update", self.Update, 0.25, self)
end


function Combatants:OnDataUpdate()
	local pmem, rmem = GetNumPartyMembers(), GetNumRaidMembers()
	count = 0

	if rmem > 0 then
		for i = 1,rmem do
			if UnitAffectingCombat("raid"..i) then count = count + 1 end
			if self.db.profile.showpets and UnitExists("raidpet"..i) and UnitAffectingCombat("raidpet"..i) then count = count + 1 end
		end
	elseif pmem > 0 then
		for i = 1,pmem do
			if UnitAffectingCombat("party"..i) then count = count + 1 end
			if self.db.profile.showpets and UnitExists("partypet"..i) and UnitAffectingCombat("partypet"..i) then count = count + 1 end
		end
	end
	if UnitAffectingCombat("player") and rmem == 0 then count = count + 1 end
	if self.db.profile.showpets and UnitExists("pet") and UnitAffectingCombat("pet") then count = count + 1 end
end


function Combatants:OnTextUpdate()
	self:SetText((count > 0 and "|cffff0000" or "|cff8888ff")..count)
	self:SetIcon(count > 0 and iconcombat or iconsafe)
end


function Combatants:OnTooltipUpdate()
	local cat = tablet:AddCategory()

	if count > self.db.profile.threshold then cat:AddLine("text", string.format("%d players in combat", count))
	else
		local pmem, rmem = GetNumPartyMembers(), GetNumRaidMembers()
		if UnitAffectingCombat("player") and rmem == 0 then cat:AddLine("text", UnitName("player")) end
		if self.db.profile.showpets and UnitExists("pet") and UnitAffectingCombat("pet") then cat:AddLine("text", UnitName("pet")) end

		if rmem > 0 then
			for i = 1,rmem do
				if UnitAffectingCombat("raid"..i) then cat:AddLine("text", UnitName("raid"..i)) end
				if self.db.profile.showpets and UnitExists("raidpet"..i) and UnitAffectingCombat("raidpet"..i) then cat:AddLine("text", UnitName("raidpet"..i)) end
			end
		elseif pmem > 0 then
			for i = 1,pmem do
				if UnitAffectingCombat("party"..i) then cat:AddLine("text", UnitName("party"..i)) end
				if self.db.profile.showpets and UnitExists("partypet"..i) and UnitAffectingCombat("partypet"..i) then cat:AddLine("text", UnitName("partypet"..i)) end
			end
		end
	end
end

