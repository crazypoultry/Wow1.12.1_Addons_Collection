--[[
  Zorlen Library - Started by Marcus S. Zarra

  3.58.01
		Updated: Zorlen_WarriorAOE()

  3.57.00
		castUnlimitedSunderArmor() added by BigRedBrent

  3.55.00
		castBattleStance() added by BigRedBrent
		castDefensiveStance() added by BigRedBrent
		castBerserkerStance() added by BigRedBrent
		isBattleStance() added by BigRedBrent
		isDefensiveStance() added by BigRedBrent
		isBerserkerStance() added by BigRedBrent

  3.51.00
		castSweepingStrikes() added by BigRedBrent
		Zorlen_WarriorAOE() added by BigRedBrent

  3.34.00
		castCleave() added by BigRedBrent
		castWhirlwind() added by BigRedBrent

  3.33.33
		isDisarm() added by BigRedBrent
		Replaced the alt key modifier with the control key.

  3.33.00
		Pressing and holding down the Control Key will now suppress the debuff checking for rend.
  
  3.17.00
		castBerserkerRageSwap() added by BigRedBrent
		forceBerserkerRage() added by BigRedBrent
  
  3.9.15
		Updated castDisarm() to not cast a second time for the same target unless targets change if the target does not have a weapon to disarm.
  
  3.9.14
		Updated castSunderArmor(), castHamstring(), and castRend() to not cast for 7 seconds if the target is immune.
  
  3.9.13
		Updated castSunderArmor() to detect misses.
  
  3.9.12
		swapChargeAndIntercept() added by BigRedBrent
  
  3.9.9h
		castBerserkerRageDefensiveStanceSwap() added by BigRedBrent
  
  3.9.9e
		castChargeAndIntercept() added by BigRedBrent
		forceChargeAndIntercept() added by BigRedBrent
		castBloodrage() added by BigRedBrent
  
  3.9.7
		castDisarm() added by BigRedBrent
  
  3.9.0
		castSunderArmor() will now only cast if sunder stack is not full or 20 seconds after the last sunder if it is full.
		Zorlen_TargetEnemyThenChargeOrIntercept() added by BigRedBrent
		castDeathWish() added by BigRedBrent
  
  3.5.0
		Zorlen_RegisterWarriorStance() added by BigRedBrent
		Zorlen_CheckWarriorStance(stance) added by BigRedBrent
		isSunderFull() added by BigRedBrent
		castSunderArmor() added by BigRedBrent
		
  
  3.2.3
		isEnrageActive() added by BigRedBrent
		castEnrage() added by BigRedBrent
  
  3.0.3b  
		castMortalStrike() added by BigRedBrent
		castBloodthirst() added by BigRedBrent
		castShieldSlam() added by BigRedBrent
		Removed: Zorlen_WarriorEndTierTalentRageCost()
  
  3.0.3  
		isThunderClap() added by BigRedBrent
		isBattleShoutActive() added by BigRedBrent
		Zorlen_ExecuteRageCost() added by BigRedBrent
		Zorlen_HeroicStrikeRageCost() added by BigRedBrent
		Zorlen_SunderArmorRageCost() added by BigRedBrent
		Zorlen_ThunderClapRageCost() added by BigRedBrent
		Zorlen_MortalStrikeRageCost() added by BigRedBrent
		Zorlen_BloodthirstRageCost() added by BigRedBrent
		Zorlen_ShieldSlamRageCost() added by BigRedBrent
		castCharge() added by BigRedBrent
		castTaunt() added by BigRedBrent
		castIntercept() added by BigRedBrent
		castOverpower() added by BigRedBrent
		castRevenge() added by BigRedBrent
		castRend() added by BigRedBrent
		castHamstring() added by BigRedBrent
		castExecute() added by BigRedBrent
		castThunderClap() added by BigRedBrent
		castShieldBash() added by BigRedBrent
		castPummel() added by BigRedBrent
		castShieldBlock() added by BigRedBrent
		castHeroicStrike() added by BigRedBrent
		castDemoralizingShout() added by BigRedBrent
		castBattleShout() added by BigRedBrent
		castBerserkerRage() added by BigRedBrent

  3.0.0  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		isSunder() added by Wynn
		isRend() added by Wynn
		isHamstring() added by Wynn
		isDemoralized() added by Wynn
--]]

function castUnlimitedSunderArmor()
	return castSunderArmor("unlimited")
end

function castSunderArmor(mode)
	local SpellName = LOCALIZATION_ZORLEN_SunderArmor
	local SpellButton = Zorlen_Button_SunderArmor
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and ((mode == "unlimited") or Zorlen_SunderTimerHasPassed or Zorlen_SunderSpellCastFailed or not isSunderFull()) and not Zorlen_SunderSpellCastImmune then
			UseAction(SpellButton)
			Zorlen_SetSunderTimer()
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= Zorlen_SunderArmorRageCost() and ((mode == "unlimited") or Zorlen_SunderTimerHasPassed or Zorlen_SunderSpellCastFailed or not isSunderFull()) and not Zorlen_SunderSpellCastImmune) then
			CastSpell(SpellID, 0)
			Zorlen_SetSunderTimer()
			return true
		end
	end
	end
	return false
end

function Zorlen_SetSunderTimer()
	ZorlenFrame.Sunder_timer = 20;
	Zorlen_SunderSpellCastEnd = nil;
	Zorlen_SunderSpellCastFailed = nil;
	Zorlen_SunderSpellCastStart = 1;
	ZorlenFrame:Show();
end

-- Will return false if Sunder Armor is stacked less than 5 times on the target.
function isSunderFull(unit)
	if Zorlen_GetDebuffStack("Ability_Warrior_Sunder", unit) == 5 then
		return true
	else
		return false
	end
end

-- this is called when ever the main bar changes due to chainging stance
-- Example: Zorlen_CurrentStance == "Battle Stance"
-- The example above will return true if you are currently in the Battle Stance.
function Zorlen_RegisterWarriorStance()
	local i;
	local max = GetNumShapeshiftForms();
	for i = 1 , max do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			Zorlen_debug("You are now in "..name..".");
			Zorlen_CurrentStance = name;
			return;
		end
	end
	Zorlen_CurrentStance = "Default";
end

-- Will return true if you are in the queried stance.
-- Example: Zorlen_CheckWarriorStance("Battle Stance")
-- The example above will return true if you are currently in the Battle Stance.
function Zorlen_CheckWarriorStance(stance)
	if stance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isBattleStance()
	if LOCALIZATION_ZORLEN_BattleStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isDefensiveStance()
	if LOCALIZATION_ZORLEN_DefensiveStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isBerserkerStance()
	if LOCALIZATION_ZORLEN_BerserkerStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isSunder(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Warrior_Sunder", unit, dispelable)
end

function isRend(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Gouge", unit, dispelable)
end

function isHamstring(unit, dispelable)
	return Zorlen_checkDebuff("Ability_ShockWave", unit, dispelable)
end

function isPiercingHowl(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_DeathScream", unit, dispelable)
end

function isDemoralized(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Warrior_WarCry", unit, dispelable)
end

function isThunderClap(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Nature_ThunderClap", unit, dispelable)
end

function isDisarm(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Warrior_Disarm", unit, dispelable)
end

function isBattleShoutActive()
	return Zorlen_checkBuff("Ability_Warrior_BattleShout")
end

function isEnrageActive()
	return Zorlen_checkBuff("Spell_Shadow_UnholyFrenzy")
end



-- Returns the number of rage points the LOCALIZATION_ZORLEN_Execute ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ExecuteRageCost()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedExecute)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Execute)) then
		return 0
	else if (t == 2) then
		return 10
	else if (t == 1) then
		return 13
	else
		return 15
	end
	end
	end
end

-- Returns the number of rage points the LOCALIZATION_ZORLEN_HeroicStrike ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_HeroicStrikeRageCost()
	if (Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_HeroicStrike)) then
		return (15 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedHeroicStrike))
	else
		return 0
	end
end

-- Returns the number of rage points the "Sunder Armor" ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_SunderArmorRageCost()
	if (Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SunderArmor)) then
		return (15 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedSunderArmor))
	else
		return 0
	end
end

-- Returns the number of rage points the LOCALIZATION_ZORLEN_ThunderClap ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ThunderClapRageCost()
local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedThunderClap)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ThunderClap)) then
		return 0
	else if (t == 3) then
		return 16
	else if (t == 2) then
		return 18
	else if (t == 1) then
		return 19
	else
		return 20
	end
	end
	end
	end
end

-- Returns a value of 30 if the talent LOCALIZATION_ZORLEN_MortalStrike has been learned and will return 0 if the talent has not been learned.
function Zorlen_MortalStrikeRageCost()
	if (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_MortalStrike) == 1) then
		return 30
	else
		return 0
	end
end

-- Returns a value of 30 if the talent LOCALIZATION_ZORLEN_Bloodthirst has been learned and will return 0 if the talent has not been learned.
function Zorlen_BloodthirstRageCost()
	if (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Bloodthirst) == 1) then
		return 30
	else
		return 0
	end
end

-- Returns a value of 30 if the talent LOCALIZATION_ZORLEN_ShieldSlam has been learned and will return 0 if the talent has not been learned.
function Zorlen_ShieldSlamRageCost()
	if (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ShieldSlam) == 1) then
		return 30
	else
		return 0
	end
end



function castBattleStance()
	local SpellName = LOCALIZATION_ZORLEN_BattleStance
	if not Zorlen_CheckWarriorStance(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	return false
end

function castDefensiveStance()
	local SpellName = LOCALIZATION_ZORLEN_DefensiveStance
	if not Zorlen_CheckWarriorStance(SpellName) and Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	return false
end

function castBerserkerStance()
	local SpellName = LOCALIZATION_ZORLEN_BerserkerStance
	if not Zorlen_CheckWarriorStance(SpellName) and Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	return false
end


function castMortalStrike()
	local SpellName = LOCALIZATION_ZORLEN_MortalStrike
	local SpellButton = Zorlen_Button_MortalStrike
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 30 and Zorlen_isMainHandEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castBloodthirst()
	local SpellName = LOCALIZATION_ZORLEN_Bloodthirst
	local SpellButton = Zorlen_Button_Bloodthirst
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 30) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castShieldSlam()
	local SpellName = LOCALIZATION_ZORLEN_ShieldSlam
	local SpellButton = Zorlen_Button_ShieldSlam
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 30 and Zorlen_isShieldEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castCharge()
	local SpellName = LOCALIZATION_ZORLEN_Charge
	local SpellButton = Zorlen_Button_Charge
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (Zorlen_notInCombat() and isBattleStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castTaunt()
	local SpellName = LOCALIZATION_ZORLEN_Taunt
	local SpellButton = Zorlen_Button_Taunt
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (Zorlen_TargetIsEnemyTargetingFriendButNotYou() and isDefensiveStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castMockingBlow()
	local SpellName = LOCALIZATION_ZORLEN_MockingBlow
	local SpellButton = Zorlen_Button_MockingBlow
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (Zorlen_TargetIsEnemyTargetingFriendButNotYou() and isBattleStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castIntercept()
	local SpellName = LOCALIZATION_ZORLEN_Intercept
	local SpellButton = Zorlen_Button_Intercept
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and isBerserkerStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castOverpower()
	local SpellName = LOCALIZATION_ZORLEN_Overpower
	local SpellButton = Zorlen_Button_Overpower
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			Zorlen_TargetDodgedYou_Overpower = nil;
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 5 and isBattleStance() and Zorlen_isMainHandEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				Zorlen_TargetDodgedYou_Overpower = nil;
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castRevenge()
	local SpellName = LOCALIZATION_ZORLEN_Revenge
	local SpellButton = Zorlen_Button_Revenge
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 5 and isDefensiveStance() and Zorlen_isMainHandEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castCleave()
	local SpellName = LOCALIZATION_ZORLEN_Cleave
	local SpellButton = Zorlen_Button_Cleave
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 20 and Zorlen_isMainHandEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castWhirlwind()
	local SpellName = LOCALIZATION_ZORLEN_Whirlwind
	local SpellButton = Zorlen_Button_Whirlwind
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 25 and Zorlen_isMainHandEquipped() and isBerserkerStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castSweepingStrikes()
	local SpellName = LOCALIZATION_ZORLEN_SweepingStrikes
	local SpellButton = Zorlen_Button_SweepingStrikes
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and Zorlen_isMainHandEquipped() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 30 and Zorlen_isMainHandEquipped() and isBattleStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castConcussionBlow()
	local SpellName = LOCALIZATION_ZORLEN_ConcussionBlow
	local SpellButton = Zorlen_Button_ConcussionBlow
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and Zorlen_isMainHandEquipped() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 15 and Zorlen_isMainHandEquipped()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castPiercingHowl()
	local SpellName = LOCALIZATION_ZORLEN_PiercingHowl
	local SpellButton = Zorlen_Button_PiercingHowl
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castRend()
	local SpellName = LOCALIZATION_ZORLEN_Rend
	local SpellButton = Zorlen_Button_Rend
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isRend() or IsControlKeyDown()) and not Zorlen_RendSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and (not isRend() or IsControlKeyDown()) and not (isBerserkerStance()) and Zorlen_isMainHandEquipped() and not Zorlen_RendSpellCastImmune and not Zorlen_AllDebuffSlotsUsed()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castDisarm()
	local SpellName = LOCALIZATION_ZORLEN_Disarm
	local SpellButton = Zorlen_Button_Disarm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isDisarm() and not Zorlen_DisarmSpellCastImmune then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 20 and not isDisarm() and isDefensiveStance() and not Zorlen_DisarmSpellCastImmune) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castHamstring()
	local SpellName = LOCALIZATION_ZORLEN_Hamstring
	local SpellButton = Zorlen_Button_Hamstring
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isHamstring() and not Zorlen_HamstringSpellCastImmune then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and not isHamstring() and not (isDefensiveStance()) and Zorlen_isMainHandEquipped() and not Zorlen_HamstringSpellCastImmune) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castExecute()
	local SpellName = LOCALIZATION_ZORLEN_Execute
	local SpellButton = Zorlen_Button_Execute
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= Zorlen_ExecuteRageCost() and Zorlen_TargetIsDieingEnemy() and not (isDefensiveStance()) and Zorlen_isMainHandEquipped()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castThunderClap()
	local SpellName = LOCALIZATION_ZORLEN_ThunderClap
	local SpellButton = Zorlen_Button_ThunderClap
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not isThunderClap() and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= Zorlen_ThunderClapRageCost() and not isThunderClap() and isBattleStance() and not Zorlen_AllDebuffSlotsUsed()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castShieldBash()
	local SpellName = LOCALIZATION_ZORLEN_ShieldBash
	local SpellButton = Zorlen_Button_ShieldBash
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and Zorlen_isShieldEquipped() and not (isBerserkerStance())) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castPummel()
	local SpellName = LOCALIZATION_ZORLEN_Pummel
	local SpellButton = Zorlen_Button_Pummel
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and isBerserkerStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castShieldBlock()
	local SpellName = LOCALIZATION_ZORLEN_ShieldBlock
	local SpellButton = Zorlen_Button_ShieldBlock
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and Zorlen_isShieldEquipped() and isDefensiveStance()) then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castHeroicStrike()
	local SpellName = LOCALIZATION_ZORLEN_HeroicStrike
	local SpellButton = Zorlen_Button_HeroicStrike
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= Zorlen_HeroicStrikeRageCost() and Zorlen_isMainHandEquipped()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castDemoralizingShout()
	local SpellName = LOCALIZATION_ZORLEN_DemoralizingShout
	local SpellButton = Zorlen_Button_DemoralizingShout
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not isDemoralized() and not Zorlen_DemoSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() and CheckInteractDistance("target", 3) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and not isDemoralized() and not Zorlen_DemoSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() and CheckInteractDistance("target", 3)) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castBattleShout()
	local SpellName = LOCALIZATION_ZORLEN_BattleShout
	local SpellButton = Zorlen_Button_BattleShout
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not isBattleShoutActive() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitMana("player") >= 10 and not isBattleShoutActive()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castBerserkerRage()
	local SpellName = LOCALIZATION_ZORLEN_BerserkerRage
	local SpellButton = Zorlen_Button_BerserkerRage
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if isBerserkerStance() then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castBloodrage()
	local SpellName = LOCALIZATION_ZORLEN_Bloodrage
	local SpellButton = Zorlen_Button_Bloodrage
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( duration == 0 ) and not ( isCurrent == 1 ) and UnitHealth("player") / UnitHealthMax("player") > 0.2 then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if UnitHealth("player") / UnitHealthMax("player") > 0.2 then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castDeathWish()
	local SpellName = LOCALIZATION_ZORLEN_DeathWish
	local SpellButton = Zorlen_Button_DeathWish
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if isBerserkerStance() then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

-- Will some times make getting critted on much more likely.
-- This may cause you more damage so use cautiously.
function castEnrage()
	local u = UnitHealth("player") / UnitHealthMax("player") > 0.2
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Enrage) > 0
	local e = isEnrageActive()
	if not e and t and u and not Zorlen_TargetIsDieingEnemy() then
		ClearTarget()
		DoEmote(LOCALIZATION_ZORLEN_sit)
		backOff()
		return true
	else if Zorlen_inCombat() and not UnitExists("target") and (e or (t and not u)) then
		TargetLastEnemy()
		return true
	end
	end
	return false
end

function Zorlen_TargetEnemyThenChargeOrIntercept()
	if not Zorlen_TargetIsEnemy() then
		Zorlen_TargetEnemy()
		return true
	else if castCharge() then
		return true
	else if castIntercept() then
		return true
	end
	end
	end
	return false
end


function swapChargeAndIntercept()
	return castChargeAndIntercept("swap")
end


function forceChargeAndIntercept()
	return castChargeAndIntercept("force")
end


function castChargeAndIntercept(mode)
	if Zorlen_TargetIsEnemy() then
		if castCharge() then
			Zorlen_CastChargeDelay = 1;
			ZorlenFrame.CastChargeDelay_timer = 5;
			ZorlenFrame:Show();
			return true
		else if castIntercept() then
			return true
		else if Zorlen_Button_Charge and (mode == "force" or mode == "swap" or mode == "mid") and IsActionInRange(Zorlen_Button_Charge) == 1 and not isBattleStance() and Zorlen_notInCombat() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Charge) then
			return castBattleStance()
		else if Zorlen_Button_Intercept and (mode == "force" or mode == "swap" or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and (Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Charge) or not Zorlen_CastChargeDelay) and IsActionInRange(Zorlen_Button_Intercept) == 1 and not isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and ((UnitMana("player") >= 10 and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TacticalMastery) >= 2) or ((mode == "force" or mode == "mid") and ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage) and UnitHealth("player") / UnitHealthMax("player") > 0.2) or ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 2 or (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 1 and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TacticalMastery) >= 1 and UnitMana("player") >= 5)))))) then
			return castBerserkerStance()
		else if Zorlen_Button_Intercept and isBerserkerStance() and Zorlen_inCombat() and IsActionInRange(Zorlen_Button_Intercept) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and UnitMana("player") < 10 and (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 2 or (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 1 and UnitMana("player") >= 5)) and castBerserkerRage() then
			return true
		else if Zorlen_Button_Intercept and isBerserkerStance() and ((mode == "force") or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and Zorlen_inCombat() and IsActionInRange(Zorlen_Button_Intercept) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and UnitMana("player") < 10 and castBloodrage() then
			return true
		end
		end
		end
		end
		end
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button_Charge then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Charge) then
			DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Charge.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!");
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button_Intercept then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Intercept) then
			DEFAULT_CHAT_FRAME:AddMessage("You must put "..LOCALIZATION_ZORLEN_Intercept.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!");
		end
	end
	return false
end


-- This will go back to the stance you had been in after Berserker Rage is cast.
function castBerserkerRageSwap()
	if Zorlen_castBerserkerRageSwap_OldStance and (Zorlen_CheckWarriorStance(Zorlen_castBerserkerRageSwap_OldStance) or (not Zorlen_CheckWarriorStance(Zorlen_castBerserkerRageSwap_OldStance) and not isBerserkerStance())) then
		Zorlen_castBerserkerRageSwap_OldStance = nil;
		Zorlen_castBerserkerRageSwap_SwapWindow = nil;
		Zorlen_castBerserkerRageSwap_SwapBack = nil;
	end
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage) then
			if not isBerserkerStance() then
				if not Zorlen_castBerserkerRageSwap_OldStance then
					Zorlen_castBerserkerRageSwap_OldStance = Zorlen_CurrentStance;
				end
				Zorlen_castBerserkerRageSwap_SwapStart = 1;
				Zorlen_castBerserkerRageSwap_SwapBack = nil;
				return castBerserkerStance()
			else if castBerserkerRage() then
				if Zorlen_castBerserkerRageSwap_SwapWindow then
					Zorlen_castBerserkerRageSwap_SwapBack = 1;
				else
					Zorlen_castBerserkerRageSwap_SwapBack = nil;
					Zorlen_castBerserkerRageSwap_OldStance = nil;
				end
				return true
			end
			end
		else if Zorlen_castBerserkerRageSwap_SwapBack and isBerserkerStance() and Zorlen_castBerserkerRageSwap_OldStance then
			local SpellName = Zorlen_castBerserkerRageSwap_OldStance
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
		end
	end
	return false
end


-- This will only go to Berserker Stance if Berserker Rage can be cast.
function forceBerserkerRage()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage) then
			if not isBerserkerStance() then
				return castBerserkerStance()
			else
				return castBerserkerRage()
			end
		end
	end
	return false
end


-- This will always go back to Defensive Stance after Berserker Rage is cast.
-- This has been replaced with castBerserkerRageSwap() since that will go back to the stance that you had been in.
function castBerserkerRageDefensiveStanceSwap()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage) then
			if not isBerserkerStance() then
				return castBerserkerStance()
			else
				return castBerserkerRage()
			end
		else if isBerserkerStance() and castDefensiveStance() then
			return true
		end
		end
	end
	return false
end

function Zorlen_WarriorAOE()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TacticalMastery);
	local m = UnitMana("player")
	if Zorlen_TargetIsActiveEnemy() then
		castAttack()
	else
		stopAttack()
	end
	if castBattleShout() then
		return true
	else if castDemoralizingShout() then
		return true
	else if castSweepingStrikes() then
		return true
	else if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) and not isBattleStance() and ((t == 0 and m <= 10) or (t >= 1 and m <= 15) or (t >= 2 and m <= 20) or (t >= 3 and m <= 25) or (t >= 4 and m <= 30) or (t >= 5 and m <= 35)) and castBattleStance() then
		return true
	else if castWhirlwind() then
		return true
	else if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind) and not isBerserkerStance() and ((t == 0 and m <= 10) or (t >= 1 and m <= 15) or (t >= 2 and m <= 20) or (t >= 3 and m <= 25) or (t >= 4 and m <= 30) or (t >= 5 and m <= 35)) and castBerserkerStance() then
		return true
	else if ((not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) or not isBattleStance()) and (not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind) or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) or not isBerserkerStance())) and castCleave() then
		return true
	end
	end
	end
	end
	end
	end
	end
	return false
end


