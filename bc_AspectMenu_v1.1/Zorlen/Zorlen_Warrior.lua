
Zorlen_Warrior_FileBuildNumber = 681

--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  4.20
		castLastStand() added by BigRedBrent
		isPiercingHowl() added by BigRedBrent
  
  4.15
		castPiercingHowl() added by BigRedBrent
  
  3.97
		castShieldBlock() will now only cast if your target is targeting you
  
  3.78
		Zorlen_TacticalMasteryRagePoints() added by BigRedBrent
		Zorlen_BerserkerRageRagePoints() added by BigRedBrent
		Zorlen_BloodrageRagePoints() added by BigRedBrent
  
  3.76.00
		castConcussionBlow() added by BigRedBrent

  3.75.00
		Hamstring should now detect immunity again

  3.70.00
		Fixed Zorlen_WarriorAOE() so that it does not switch stances back and forth if you have Sweeping Strikes

  3.68.00
		Updated the rage cost of Shield Slam

  3.64.00
		Improved Sunder Armor casting some

  3.63.00
		isDeepWounds() added by BigRedBrent
		isShieldBlockActive() added by BigRedBrent

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



function Zorlen_Warrior_SpellTimerSet()
	local Number = 0
	local TargetName = Zorlen_CastingSpellTargetName
	local SpellName = Zorlen_CastingSpellName
	
	if SpellName == LOCALIZATION_ZORLEN_SunderArmor then
		Number = 30
		TargetName = nil
	
	elseif SpellName == LOCALIZATION_ZORLEN_Devastate then
		if isSunder() then
			Number = 30
			TargetName = nil
			SpellName = LOCALIZATION_ZORLEN_SunderArmor
		end
		
	elseif SpellName == LOCALIZATION_ZORLEN_Rend then
		if Zorlen_CastingSpellRank <= 5 then
			Number = 6 + (Zorlen_CastingSpellRank * 3)
		else
			Number = 21
		end
		
	elseif SpellName == LOCALIZATION_ZORLEN_Overpower then
		Zorlen_ClearTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer")
		
	end
	
	Zorlen_SetTimer(Number, SpellName, TargetName, "InternalZorlenSpellTimers", nil, nil, 1)
end


function Zorlen_Warrior_OnUpdate(arg1, TimerRunDown)
	if not Zorlen_isCurrentClassWarrior then
		return false
	end
	if TimerRunDown then
			if Zorlen_IsTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer") then
				if Zorlen_GetTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer") <= 0 then
					if isHamstring() then
						Zorlen_RegisterIfWasHamstring()
					else
						Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_Hamstring.."!")
						Zorlen_WasHamstringSpellCastImmune = 1
						Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_Hamstring, "immune", "InternalZorlenMiscTimer")
					end
					Zorlen_ClearTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
				end
			end
			if Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer") then
				if (Zorlen_GetTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer") <= 0) or (Zorlen_Button[LOCALIZATION_ZORLEN_Charge] and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN_Charge]) ~= 1) then
					Zorlen_ClearTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
				end
			end
			if Zorlen_IsTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer") then
				if Zorlen_GetTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer") <= 0 then
					Zorlen_castBerserkerRageSwap_SwapStart = nil
					Zorlen_castBerserkerRageSwap_SwapBack = nil
					Zorlen_castBerserkerRageSwap_OldStance = nil
					Zorlen_ClearTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer")
				end
			end
	else
		return false
	end
	return true
end


function Zorlen_Warrior_OnEvent_UPDATE_BONUS_ACTIONBAR()
	Zorlen_RegisterWarriorStance()
	if Zorlen_IsTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer") then
		Zorlen_castBerserkerRageSwap_SwapStart = nil
		Zorlen_castBerserkerRageSwap_SwapBack = nil
		Zorlen_castBerserkerRageSwap_OldStance = nil
		Zorlen_ClearTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer")
	elseif Zorlen_castBerserkerRageSwap_SwapStart then
		Zorlen_castBerserkerRageSwap_SwapStart = nil
		Zorlen_SetTimer(30, "castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer", 2, 1)
	end
end


function Zorlen_Warrior_OnEvent_PLAYER_TARGET_CHANGED()
	Zorlen_WasSunderSpellCastImmune = nil
	Zorlen_WasRendSpellCastImmune = nil
	Zorlen_DemoSpellCastImmune = nil
	Zorlen_PiercingHowlSpellCastImmune = nil
	Zorlen_DisarmSpellCastImmune = nil
	Zorlen_WasHamstring = nil
	Zorlen_WasHamstringSpellCastImmune = nil
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_SunderArmor, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_Rend, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_Hamstring, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
	Zorlen_ClearTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
	Zorlen_RegisterIfWasHamstring()
end


function Zorlen_Warrior_OnEvent_CHAT_MSG_COMBAT_SELF_MISSES(arg1, arg2, arg3)
	if string.find(arg1, LOCALIZATION_ZORLEN_dodges) then
		Zorlen_debug("Target dodged your attack. "..LOCALIZATION_ZORLEN_Overpower.." now!")
		Zorlen_SetTimer(5, "TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer", 2, 1)
	end
end


function Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_SELF_DAMAGE(arg1, arg2, arg3, TargetName, failed, immune, hit)
	if failed and Zorlen_LastCastingSpellName == LOCALIZATION_ZORLEN_Devastate then
		Zorlen_ClearTimer(LOCALIZATION_ZORLEN_SunderArmor, nil, "InternalZorlenSpellTimers", 1)
	end
	if not immune and string.find(arg1, LOCALIZATION_ZORLEN_dodged) then
		Zorlen_debug("Target dodged. "..LOCALIZATION_ZORLEN_Overpower.." now!")
		Zorlen_SetTimer(5, "TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer", 2, 1)
	elseif not immune and not failed and hit and string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN_HitsOrCritsArray[hit], "%(%.%+%)", LOCALIZATION_ZORLEN_Hamstring, "%(%.%*%)", TargetName)) then
		Zorlen_SetTimer(1, "CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer", 2, 1)
	elseif not immune then
		return
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_Hamstring, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_Hamstring.."!")
		Zorlen_WasHamstringSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_Hamstring, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_SunderArmor, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_SunderArmor.."!")
		Zorlen_WasSunderSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_SunderArmor, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_Rend, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_Rend.."!")
		Zorlen_WasRendSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_Rend, "immune", "InternalZorlenMiscTimer")
	end
end



function Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_FAILED_LOCALPLAYER(arg1, arg2, arg3)
	if string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN_no_weapons_equipped, "%(%.%+%)", LOCALIZATION_ZORLEN_Disarm)) then
			Zorlen_debug(LOCALIZATION_ZORLEN_Disarm.." failed!")
			Zorlen_DisarmSpellCastImmune = 1
	elseif string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN_A_more_powerful_spell_is_already_active, "%(%.%+%)", LOCALIZATION_ZORLEN_SunderArmor)) then
		Zorlen_debug(LOCALIZATION_ZORLEN_SunderArmor.." failed!")
		Zorlen_WasSunderSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_SunderArmor, "immune", "InternalZorlenMiscTimer")
	end
end



function castUnlimitedSunderArmor(test)
	return castSunderArmor(99, test)
end

function castSunderArmor(RemainingDurationCastTime, test)
	local RemainingDurationCastTime = RemainingDurationCastTime or 10
	local SpellName = LOCALIZATION_ZORLEN_SunderArmor
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	local ManaNeeded = nil
	if Zorlen_GetTimer(SpellName, nil, "InternalZorlenSpellTimers") <= RemainingDurationCastTime or not isSunderFull() then
		if not Zorlen_Button[SpellName] then
			ManaNeeded = Zorlen_SunderArmorRageCost()
		end
		return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
	end
	return false
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

function Zorlen_RegisterIfWasHamstring()
	if not Zorlen_WasHamstring then
		if isHamstring() then
			Zorlen_debug(LOCALIZATION_ZORLEN_Hamstring.." was found on target: "..UnitName("target").."");
			Zorlen_ClearTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
			Zorlen_WasHamstring = 1;
		end
	end
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

function isDeepWounds(unit, dispelable)
	return Zorlen_checkDebuff("Ability_BackStab", unit, dispelable)
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

function isShieldBlockActive()
	return Zorlen_checkBuff("Ability_Defend")
end

function isBattleShoutActive()
	return Zorlen_checkBuff("Ability_Warrior_BattleShout")
end

function isEnrageActive()
	return Zorlen_checkBuff("Spell_Shadow_UnholyFrenzy")
end



-- Returns the number of rage points the Tactical Mastery ability will allow you to keep when you switch stances.
-- Will return 0 if no rank of the ability has been learned.
function Zorlen_TacticalMasteryRagePoints()
	return (5 * Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TacticalMastery))
end

-- Returns the number of rage points the Berserker Rage ability will give.
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_BerserkerRageRagePoints()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_BerserkerRage) then
		return (5 * Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage))
	end
	return 0
end

-- Returns the number of rage points the Bloodrage ability will give.
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_BloodrageRagePoints()
	if not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Bloodrage) then
		return 0
	end
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBloodrage)
	if (t == 2) then
		return 15
	elseif (t == 1) then
		return 12
	end
	return 10
end


-- Returns the number of rage points the Execute ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ExecuteRageCost()
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Execute)) then
		return 0
	end
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedExecute)
	local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage)
	if (t == 2) then
		return (10 - f)
	elseif (t == 1) then
		return (13 - f)
	end
	return (15 - f)
end

-- Returns the number of rage points the Heroic Strike ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_HeroicStrikeRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_HeroicStrike) then
		return (15 - (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedHeroicStrike) + Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage)))
	end
	return 0
end

-- Returns the number of rage points the "Sunder Armor" ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_SunderArmorRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SunderArmor) then
		return (15 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedSunderArmor))
	end
	return 0
end

function Zorlen_WhirlwindRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) then
		return (25 - ((Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedWhirlwind) * 2) + Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage)))
	end
	return 0
end

function Zorlen_RendRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Rend) then
		return (10 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage))
	end
	return 0
end

-- Returns the number of rage points the Thunder Clap ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ThunderClapRageCost()
	if not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ThunderClap) then
		return 0
	end
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedThunderClap)
	local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage)
	if (t == 3) then
		return (16 - f)
	elseif (t == 2) then
		return (18 - f)
	elseif (t == 1) then
		return (19 - f)
	end
	return (20 - f)
end

-- Returns a value of 30 if the talent Mortal Strike has been learned and will return 0 if the talent has not been learned.
function Zorlen_MortalStrikeRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_MortalStrike) == 1 then
		return (30 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage))
	end
	return 0
end

-- Returns a value of 30 if the talent Bloodthirst has been learned and will return 0 if the talent has not been learned.
function Zorlen_BloodthirstRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Bloodthirst) == 1 then
		return (30 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage))
	end
	return 0
end

-- Returns a value of 30 if the talent Shield Slam has been learned and will return 0 if the talent has not been learned.
function Zorlen_ShieldSlamRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ShieldSlam) == 1 then
		return (20 - Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FocusedRage))
	end
	return 0
end



function castBattleStance(test)
	local SpellName = LOCALIZATION_ZORLEN_BattleStance
	local EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castDefensiveStance(test)
	local SpellName = LOCALIZATION_ZORLEN_DefensiveStance
	local EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castBerserkerStance(test)
	local SpellName = LOCALIZATION_ZORLEN_BerserkerStance
	local EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end


function castMortalStrike(test)
	local SpellName = LOCALIZATION_ZORLEN_MortalStrike
	local ManaNeeded = 30
	if not Zorlen_Button[SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castBloodthirst(test)
	local SpellName = LOCALIZATION_ZORLEN_Bloodthirst
	local ManaNeeded = 30
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castShieldSlam(test)
	local SpellName = LOCALIZATION_ZORLEN_ShieldSlam
	local ManaNeeded = 20
	if not Zorlen_Button[SpellName] then
		if not Zorlen_isShieldEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end


function castConcussionBlow(test)
	local SpellName = LOCALIZATION_ZORLEN_ConcussionBlow
	local ManaNeeded = 15
	if not Zorlen_Button[SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castCharge(test)
	local SpellName = LOCALIZATION_ZORLEN_Charge
	if not Zorlen_Button[SpellName] then
		if not isBattleStance() or Zorlen_inCombat() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castTaunt(test)
	local SpellName = LOCALIZATION_ZORLEN_Taunt
	if not Zorlen_Button[SpellName] then
		if not isDefensiveStance() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castMockingBlow(test)
	local SpellName = LOCALIZATION_ZORLEN_MockingBlow
	if not Zorlen_Button[SpellName] then
		if not isBattleStance() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castIntercept(test)
	local SpellName = LOCALIZATION_ZORLEN_Intercept
	local ManaNeeded = 10
	if not Zorlen_Button[SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castOverpower(test)
	local SpellName = LOCALIZATION_ZORLEN_Overpower
	local ManaNeeded = 5
	if not Zorlen_Button[SpellName] then
		if not isBattleStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castRevenge(test)
	local SpellName = LOCALIZATION_ZORLEN_Revenge
	local ManaNeeded = 5
	if not Zorlen_Button[SpellName] then
		if not isDefensiveStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castCleave(test)
	local SpellName = LOCALIZATION_ZORLEN_Cleave
	local ManaNeeded = 20
	if not Zorlen_Button[SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castWhirlwind(test)
	local SpellName = LOCALIZATION_ZORLEN_Whirlwind
	local ManaNeeded = 25
	if not Zorlen_Button[SpellName] then
		if not isBerserkerStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castSweepingStrikes(test)
	local SpellName = LOCALIZATION_ZORLEN_SweepingStrikes
	local ManaNeeded = 30
	if not Zorlen_Button[SpellName] then
		if not isBattleStance() then
			return false
		end
	end
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castRend(test)
	local SpellName = LOCALIZATION_ZORLEN_Rend
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	local ManaNeeded = 10
	if not Zorlen_Button[SpellName] then
		if isBerserkerStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	local DebuffTimer = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test, DebuffTimer)
end

function castDisarm(test)
	local SpellName = LOCALIZATION_ZORLEN_Disarm
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_DisarmSpellCastImmune
	local ManaNeeded = 20
	if not Zorlen_Button[SpellName] then
		if not isDefensiveStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castHamstring(test)
	local SpellName = LOCALIZATION_ZORLEN_Hamstring
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	local ManaNeeded = 10
	if not Zorlen_Button[SpellName] then
		if isDefensiveStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castExecute(test)
	local SpellName = LOCALIZATION_ZORLEN_Execute
	local ManaNeeded = nil
	if not Zorlen_Button[SpellName] then
		if isDefensiveStance() or not Zorlen_TargetIsDieingEnemy() or not Zorlen_isMainHandEquipped() then
			return false
		end
		ManaNeeded = Zorlen_ExecuteRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castThunderClap(test)
	local SpellName = LOCALIZATION_ZORLEN_ThunderClap
	local DebuffName = SpellName
	local ManaNeeded = nil
	local NoRangeCheck = 1
	if not Zorlen_Button[SpellName] then
		if not isBattleStance() then
			return false
		end
		ManaNeeded = Zorlen_ThunderClapRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck, test)
end

function castShieldBash(test)
	local SpellName = LOCALIZATION_ZORLEN_ShieldBash
	local ManaNeeded = 10
	if not Zorlen_Button[SpellName] then
		if isBerserkerStance() or not Zorlen_isShieldEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castPummel(test)
	local SpellName = LOCALIZATION_ZORLEN_Pummel
	local ManaNeeded = 10
	if not Zorlen_Button[SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castShieldBlock(test)
	local SpellName = LOCALIZATION_ZORLEN_ShieldBlock
	local ManaNeeded = 10
	local BuffName = SpellName
	if not Zorlen_Button[SpellName] then
		if not isDefensiveStance() or not Zorlen_isShieldEquipped() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, BuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castHeroicStrike(test)
	local SpellName = LOCALIZATION_ZORLEN_HeroicStrike
	local ManaNeeded = nil
	if not Zorlen_Button[SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
		ManaNeeded = Zorlen_HeroicStrikeRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castDemoralizingShout(test)
	local SpellName = LOCALIZATION_ZORLEN_DemoralizingShout
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_DemoSpellCastImmune
	local ManaNeeded = 10
	local NoRangeCheck = 1
	if not CheckInteractDistance("target", 3) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck, test)
end

function castPiercingHowl(test)
	local SpellName = LOCALIZATION_ZORLEN_PiercingHowl
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_PiercingHowlSpellCastImmune
	local ManaNeeded = 10
	local NoRangeCheck = 1
	if not CheckInteractDistance("target", 3) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck, test)
end

function castBattleShout(test)
	local SpellName = LOCALIZATION_ZORLEN_BattleShout
	local ManaNeeded = 10
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castBerserkerRage(test)
	local SpellName = LOCALIZATION_ZORLEN_BerserkerRage
	local EnemyTargetNotNeeded = 1
	if not Zorlen_Button[SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castBloodrage(test)
	local SpellName = LOCALIZATION_ZORLEN_Bloodrage
	local SelfHealthGreaterThanPercent = 20
	local EnemyTargetNotNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, SelfHealthGreaterThanPercent, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castDeathWish(test)
	local SpellName = LOCALIZATION_ZORLEN_DeathWish
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
end

function castLastStand(test)
	local SpellName = LOCALIZATION_ZORLEN_LastStand
	local EnemyTargetNotNeeded = 1
	if Zorlen_HealthDamagePercent("player") < 30 then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, test)
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
	elseif Zorlen_inCombat() and not UnitExists("target") and (e or (t and not u)) then
		TargetLastEnemy()
		return true
	end
	return false
end

function Zorlen_TargetEnemyThenChargeOrIntercept()
	if not Zorlen_TargetIsEnemy() then
		Zorlen_TargetEnemy()
		return true
	elseif castCharge() then
		return true
	elseif castIntercept() then
		return true
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
			Zorlen_SetTimer(5, "CastChargeDelay_timer", nil, "InternalZorlenMiscTimer", 2, 1)
			return true
		elseif castIntercept() then
			return true
		elseif Zorlen_Button[LOCALIZATION_ZORLEN_Charge] and (mode == "force" or mode == "swap" or mode == "mid") and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN_Charge]) == 1 and not isBattleStance() and Zorlen_notInCombat() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Charge) then
			return castBattleStance()
		elseif Zorlen_Button[LOCALIZATION_ZORLEN_Intercept] and (mode == "force" or mode == "swap" or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and (Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Charge) or not Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")) and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN_Intercept]) == 1 and not isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and ((UnitMana("player") >= 10 and Zorlen_TacticalMasteryRagePoints() >= 10) or ((mode == "force" or mode == "mid") and ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Bloodrage) and UnitHealth("player") / UnitHealthMax("player") > 0.2) or ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_BerserkerRage)) and (Zorlen_BerserkerRageRagePoints() >= 10 or (Zorlen_BerserkerRageRagePoints() >= 5 and Zorlen_TacticalMasteryRagePoints() >= 5 and UnitMana("player") >= 5)))))) then
			return castBerserkerStance()
		elseif Zorlen_Button[LOCALIZATION_ZORLEN_Intercept] and isBerserkerStance() and Zorlen_inCombat() and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN_Intercept]) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and UnitMana("player") < 10 and (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 2 or (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedBerserkerRage) == 1 and UnitMana("player") >= 5)) and castBerserkerRage() then
			return true
		elseif Zorlen_Button[LOCALIZATION_ZORLEN_Intercept] and isBerserkerStance() and ((mode == "force") or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and Zorlen_inCombat() and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN_Intercept]) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Intercept) and UnitMana("player") < 10 and castBloodrage() then
			return true
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button[LOCALIZATION_ZORLEN_Charge] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Charge) then
			Zorlen_debug("You must put "..LOCALIZATION_ZORLEN_Charge.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!", 1);
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button[LOCALIZATION_ZORLEN_Intercept] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Intercept) then
			Zorlen_debug("You must put "..LOCALIZATION_ZORLEN_Intercept.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!", 1);
		end
	end
	return false
end


-- This will go back to the stance you had been in after Berserker Rage is cast.
function castBerserkerRageSwap()
	if Zorlen_castBerserkerRageSwap_OldStance and (Zorlen_CheckWarriorStance(Zorlen_castBerserkerRageSwap_OldStance) or (not Zorlen_CheckWarriorStance(Zorlen_castBerserkerRageSwap_OldStance) and not isBerserkerStance())) then
		Zorlen_castBerserkerRageSwap_SwapStart = nil
		Zorlen_castBerserkerRageSwap_SwapBack = nil
		Zorlen_castBerserkerRageSwap_OldStance = nil
		Zorlen_ClearTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer")
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
			elseif castBerserkerRage() then
				if Zorlen_IsTimer("castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer") then
					Zorlen_castBerserkerRageSwap_SwapBack = 1;
				else
					Zorlen_castBerserkerRageSwap_SwapBack = nil;
					Zorlen_castBerserkerRageSwap_OldStance = nil;
				end
				return true
			end
		elseif Zorlen_castBerserkerRageSwap_SwapBack and isBerserkerStance() and Zorlen_castBerserkerRageSwap_OldStance then
			local SpellName = Zorlen_castBerserkerRageSwap_OldStance
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
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
		elseif isBerserkerStance() and castDefensiveStance() then
			return true
		end
	end
	return false
end

function Zorlen_WarriorAOE()
	if Zorlen_TargetIsActiveEnemy() then
		castAttack()
	else
		stopAttack()
		return castBattleShout()
	end
	local t = Zorlen_TacticalMasteryRagePoints()
	local m = UnitMana("player")
	if castBattleShout() then
		return true
	elseif castDemoralizingShout() then
		return true
	elseif castSweepingStrikes() then
		return true
	elseif not isBattleStance() and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) and m <= (t + 10) and castBattleStance() then
		return true
	elseif (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) or not (m <= (t + 10))) and castWhirlwind() then
		return true
	elseif not isBerserkerStance() and (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes)) and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind) and m <= (t + 10) and castBerserkerStance() then
		return true
	elseif (not isBattleStance() or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes)) and (not isBerserkerStance() or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and castCleave() then
		return true
	elseif (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SweepingStrikes) or (not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_SweepingStrikes) and not Zorlen_checkBuff(Ability_Rogue_SliceDice))) and castThunderClap() then
		return true
	elseif not isBattleStance() and not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Cleave) and (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Whirlwind) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_Whirlwind)) and m <= (t + 10) and castBattleStance() then
		return true
	end
	return false
end


