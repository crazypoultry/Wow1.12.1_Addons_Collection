local aura = AceLibrary("SpecialEvents-Aura-2.0")

local buffs = {
	["Stealth"] = true,
	["Vanish"] = true,
	["Prowl"] = true,
	["Feign Death"] = true,
	["Shadowmeld"] = true,
	["Food"] = true,
	["Drink"] = true,
	["Enriched Manna Biscuit"] = true,
	["First Aid"] = true,
}

local debuffs = {
	["Gouge"] = true,
	["Sap"] = true,
	["Seduction"] = true,
	["Polymorph"] = true,
	["Tame Beast"] = true,
	["Scare Beast"] = true,
	["Sleep"] = true,
	["Hibernate"] = true,
	["Fear"] = true,
	["Mind Control"] = true,
	["Blind"] = true,
	["Scatter Shot"] = true,
	["Enslave Demon"] = true,
	["Shackle Undead"] = true,
	["Reckless Charge"] = true,
	["Freezing Trap Effect"] = true,
	["Intimidating Shout"] = true,
	["Cheap Shot"] = true,
}

AutoAttack = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0")

function AutoAttack:OnEnable()
	self:RegisterEvent("PLAYER_ENTER_COMBAT")
	self:RegisterEvent("PLAYER_LEAVE_COMBAT")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("START_AUTOREPEAT_SPELL")
	self:RegisterEvent("STOP_AUTOREPEAT_SPELL")
	
	self:RegisterEvent("SpecialEvents_AuraTargetChanged")
	self:RegisterEvent("SpecialEvents_PlayerBuffGained")
	self:RegisterEvent("SpecialEvents_PlayerBuffLost")
	self:RegisterEvent("SpecialEvents_UnitDebuffGained")
	self:RegisterEvent("SpecialEvents_UnitDebuffLost")
end

function AutoAttack:PLAYER_ENTER_COMBAT()
	if not self.inCombat then
		self.selfImposedCombat = true
	end

	self.attacking = true
end

function AutoAttack:PLAYER_LEAVE_COMBAT()
	self.attacking = false
	self.selfImposedCombat = false
end

function AutoAttack:PLAYER_REGEN_ENABLED()
	self.inCombat = false
	self.selfImposedCombat = false
	self:StopAttacking()
end

function AutoAttack:PLAYER_REGEN_DISABLED()
	self.selfImposedCombat = false
	self.inCombat = true
	self:Check()
end

function AutoAttack:START_AUTOREPEAT_SPELL()
	self.autoRepeating = true
	self:StopAttacking()
end

function AutoAttack:STOP_AUTOREPEAT_SPELL()
	self.autoRepeating = false
	self:Check()
end

function AutoAttack:SpecialEvents_AuraTargetChanged()
	self:Check()
end

function AutoAttack:SpecialEvents_PlayerBuffGained(buff)
	if buffs[buff] then
		self:StopAttacking()
	end
end

function AutoAttack:SpecialEvents_PlayerBuffLost(buff)
	if buffs[buff] then
		self:Check()
	end
end

function AutoAttack:SpecialEvents_UnitDebuffGained(unitID, debuff)
	if unitID == "target" and debuffs[debuff] then
		self:StopAttacking()
	end
end

function AutoAttack:SpecialEvents_UnitDebuffLost(unitID, debuff)
	if unitID == "target" and debuffs[debuff] then
		self:Check()
	end
end


function AutoAttack:Check()
	if (not self.inCombat and not self.selfImposedCombat) or self.autoRepeating or not UnitExists("target") or UnitIsUnit("target", "player") or UnitIsDeadOrGhost("target") or not UnitCanAttack("player", "target") or UnitIsFriend("player", "target") or self:PlayerHasSpecialBuff() or self:TargetIsCrowdControlled() then
		self:StopAttacking()
	else
		self:StartAttacking()
	end
end

function AutoAttack:StopAttacking()
	if self.attacking then
		AttackTarget()
	end
end

function AutoAttack:StartAttacking()
	if not self.attacking then
		AttackTarget()
	end
end

function AutoAttack:PlayerHasSpecialBuff()
	for buff in pairs(buffs) do
		if aura:UnitHasBuff("player", buff) then
			return true
		end
	end

	return false
end

function AutoAttack:TargetIsCrowdControlled()
	for debuff in pairs(debuffs) do
		if aura:UnitHasDebuff("target", debuff) then
			return true
		end
	end

	return false
end