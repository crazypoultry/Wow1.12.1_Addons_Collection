
Zorlen_Warrior_FileBuildNumber = 688

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




-- Will return false if Sunder Armor is stacked less than 5 times on the target.
function isSunderFull(unit)
	if Zorlen_GetDebuffStack("Ability_Warrior_Sunder", unit) == 5 then
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





--------   All functions below this line will only load if you are playing the corresponding class   --------
if not Zorlen_isCurrentClassWarrior then return end







function Zorlen_Warrior_SpellTimerSet()
	local Number = 0
	local TargetName = Zorlen_CastingSpellTargetName
	local SpellName = Zorlen_CastingSpellName
	local DebuffName = nil
	local DebuffTargetName = nil
	
	if SpellName == LOCALIZATION_ZORLEN.SunderArmor then
		Number = 30
		TargetName = nil
	
	elseif SpellName == LOCALIZATION_ZORLEN.Devastate then
		if isSunder() then
			Number = 30
			TargetName = nil
			SpellName = LOCALIZATION_ZORLEN.SunderArmor
		end
		
	elseif SpellName == LOCALIZATION_ZORLEN.Rend then
		if Zorlen_CastingSpellRank <= 5 then
			Number = 6 + (Zorlen_CastingSpellRank * 3)
		else
			Number = 21
		end
		
	elseif SpellName == LOCALIZATION_ZORLEN.Overpower then
		Zorlen_ClearTimer("TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer")
		
	end
	
	Zorlen_SetTimer(1, DebuffName, DebuffTargetName, "InternalZorlenSpellCastDelay", 2)
	if Zorlen_CastingSpellTargetName then
		Zorlen_SetTimer(Number, SpellName, TargetName, "InternalZorlenSpellTimers", nil, nil, 1)
	end
end


function Zorlen_CheckForHamstringDebuffWindow_timer_function()
	if isHamstring() then
		Zorlen_RegisterIfWasHamstring()
	else
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN.Hamstring.."!")
		Zorlen_WasHamstringSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
	end
end

function Zorlen_castBerserkerRageSwap_SwapWindow_timer_function()
	Zorlen_castBerserkerRageSwap_SwapStart = nil
	Zorlen_castBerserkerRageSwap_SwapBack = nil
	Zorlen_castBerserkerRageSwap_OldStance = nil
end

function Zorlen_Warrior_OnUpdate(TimerRunDown)
	if TimerRunDown then
		if Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer") then
			if Zorlen_Button[LOCALIZATION_ZORLEN.Charge..".Any"] and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Charge..".Any"]) == 0 then
				Zorlen_ClearTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
			end
		end
	end
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
		Zorlen_SetTimer(30, "castBerserkerRageSwap_SwapWindow", nil, "InternalZorlenMiscTimer", 2, Zorlen_castBerserkerRageSwap_SwapWindow_timer_function)
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
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN.Rend, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")
	Zorlen_ClearTimer("CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
	Zorlen_RegisterIfWasHamstring()
end


function Zorlen_Warrior_OnEvent_CHAT_MSG_COMBAT_SELF_MISSES(arg1, arg2, arg3)
	if string.find(arg1, LOCALIZATION_ZORLEN.dodges) then
		Zorlen_debug("Target dodged your attack. "..LOCALIZATION_ZORLEN.Overpower.." now!")
		Zorlen_SetTimer(5, "TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer", 2, 1)
	end
end


function Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_SELF_DAMAGE(arg1, arg2, arg3, TargetName, failed, immune, hit)
	if failed and Zorlen_LastCastingSpellName and Zorlen_LastCastingSpellName == LOCALIZATION_ZORLEN.Devastate and string.find(arg1, Zorlen_LastCastingSpellName) then
		Zorlen_ClearTimer(LOCALIZATION_ZORLEN.SunderArmor, nil, "InternalZorlenSpellTimers", 1)
	end
	if not immune and string.find(arg1, LOCALIZATION_ZORLEN.dodged) then
		Zorlen_debug("Target dodged. "..LOCALIZATION_ZORLEN.Overpower.." now!")
		Zorlen_SetTimer(5, "TargetDodgedYou_Overpower", nil, "InternalZorlenMiscTimer", 2, 1)
	elseif not immune and not failed and hit and string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.HitsOrCritsArray[hit], "%(%.%+%)", LOCALIZATION_ZORLEN.Hamstring, "%(%.%*%)", TargetName)) then
		Zorlen_SetTimer(1, "CheckForHamstringDebuffWindow_timer", nil, "InternalZorlenMiscTimer", 2, Zorlen_CheckForHamstringDebuffWindow_timer_function)
	elseif not immune then
		return
	elseif string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.ImmuneArray[immune], "%(%.%+%)", LOCALIZATION_ZORLEN.Hamstring, "%(%.%*%)", TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN.Hamstring.."!")
		Zorlen_WasHamstringSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN.Hamstring, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.ImmuneArray[immune], "%(%.%+%)", LOCALIZATION_ZORLEN.SunderArmor, "%(%.%*%)", TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN.SunderArmor.."!")
		Zorlen_WasSunderSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.ImmuneArray[immune], "%(%.%+%)", LOCALIZATION_ZORLEN.Rend, "%(%.%*%)", TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN.Rend.."!")
		Zorlen_WasRendSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN.Rend, "immune", "InternalZorlenMiscTimer")
	end
end



function Zorlen_Warrior_OnEvent_CHAT_MSG_SPELL_FAILED_LOCALPLAYER(arg1, arg2, arg3)
	if string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN.no_weapons_equipped, "%(%.%+%)", LOCALIZATION_ZORLEN.Disarm)) then
			Zorlen_debug(LOCALIZATION_ZORLEN.Disarm.." failed!")
			Zorlen_DisarmSpellCastImmune = 1
	elseif string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN["You fail to perform (.+): A more powerful spell is already active."], "%(%.%+%)", LOCALIZATION_ZORLEN.SunderArmor)) then
		Zorlen_debug(LOCALIZATION_ZORLEN.SunderArmor.." failed!")
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN.SunderArmor, "immune", "InternalZorlenMiscTimer")
	end
end



function castUnlimitedSunderArmor(test)
	return castSunderArmor(99, test)
end

function castSunderArmor(RemainingDurationCastTime, test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.SunderArmor
	z.DebuffImmune = Zorlen_IsTimer(z.SpellName, "immune", "InternalZorlenMiscTimer")
	RemainingDurationCastTime = RemainingDurationCastTime or 10
	if Zorlen_GetTimer(z.SpellName, nil, "InternalZorlenSpellTimers") <= RemainingDurationCastTime or not isSunderFull() then
		if not Zorlen_Button[z.SpellName] then
			z.ManaNeeded = Zorlen_SunderArmorRageCost()
		end
		return Zorlen_CastCommonRegisteredSpell(z)
	end
	return false
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
			Zorlen_debug(LOCALIZATION_ZORLEN.Hamstring.." was found on target: "..UnitName("target").."");
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
	if LOCALIZATION_ZORLEN.BattleStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isDefensiveStance()
	if LOCALIZATION_ZORLEN.DefensiveStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
end

function isBerserkerStance()
	if LOCALIZATION_ZORLEN.BerserkerStance == Zorlen_CurrentStance then
		return true
	else
		return false
	end
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
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.TacticalMastery)
	return (5 * t)
end

-- Returns the number of rage points the Berserker Rage ability will give.
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_BerserkerRageRagePoints()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BerserkerRage) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedBerserkerRage)
		return (5 * t)
	end
	return 0
end

-- Returns the number of rage points the Bloodrage ability will give.
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_BloodrageRagePoints()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Bloodrage) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedBloodrage)
		if t == 2 then
			return 15
		elseif t == 1 then
			return 12
		end
		return 10
	end
	return 0
end


-- Returns the number of rage points the Execute ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ExecuteRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Execute) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedExecute)
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		if t == 2 then
			return (10 - f)
		elseif t == 1 then
			return (13 - f)
		end
		return (15 - f)
	end
	return 0
end

-- Returns the number of rage points the Heroic Strike ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_HeroicStrikeRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.HeroicStrike) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedHeroicStrike)
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (15 - (t + f))
	end
	return 0
end

-- Returns the number of rage points the "Sunder Armor" ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_SunderArmorRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SunderArmor) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedSunderArmor)
		return (15 - t)
	end
	return 0
end

function Zorlen_WhirlwindRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Whirlwind) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedWhirlwind)
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (25 - ((t * 2) + f))
	end
	return 0
end

function Zorlen_RendRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Rend) then
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (10 - f)
	end
	return 0
end

-- Returns the number of rage points the Thunder Clap ability will need for it to cast (even if talent points are spent on it to lower its required rage points).
-- Will return 0 if no rank of the ability has been learned from the Warrior Trainer.
function Zorlen_ThunderClapRageCost()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.ThunderClap) then
		local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedThunderClap)
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		if t == 3 then
			return (16 - f)
		end
		return (20 - (t + f))
	end
	return 0
end

-- Returns a value of 30 if the talent Mortal Strike has been learned and will return 0 if the talent has not been learned.
function Zorlen_MortalStrikeRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.MortalStrike) == 1 then
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (30 - f)
	end
	return 0
end

-- Returns a value of 30 if the talent Bloodthirst has been learned and will return 0 if the talent has not been learned.
function Zorlen_BloodthirstRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.Bloodthirst) == 1 then
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (30 - f)
	end
	return 0
end

-- Returns a value of 30 if the talent Shield Slam has been learned and will return 0 if the talent has not been learned.
function Zorlen_ShieldSlamRageCost()
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ShieldSlam) == 1 then
		local f = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.FocusedRage)
		return (20 - f)
	end
	return 0
end



function castBattleStance(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.BattleStance
	z.EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(z.SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castDefensiveStance(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.DefensiveStance
	z.EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(z.SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castBerserkerStance(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.BerserkerStance
	z.EnemyTargetNotNeeded = 1
	if Zorlen_CheckWarriorStance(z.SpellName) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end


function castMortalStrike(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.MortalStrike
	z.ManaNeeded = 30
	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castBloodthirst(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Bloodthirst
	z.ManaNeeded = 30
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castShieldSlam(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ShieldSlam
	z.ManaNeeded = 20
	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_isShieldEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end


function castConcussionBlow(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ConcussionBlow
	z.ManaNeeded = 15
	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castCharge(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Charge
	if not Zorlen_Button[z.SpellName] then
		if not isBattleStance() or Zorlen_inCombat() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castTaunt(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Taunt
	if not Zorlen_Button[z.SpellName] then
		if not isDefensiveStance() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castMockingBlow(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.MockingBlow
	if not Zorlen_Button[z.SpellName] then
		if not isBattleStance() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingFriendButNotYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castIntercept(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Intercept
	z.ManaNeeded = 10
	if not Zorlen_Button[z.SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castOverpower(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Overpower
	z.ManaNeeded = 5
	if not Zorlen_Button[z.SpellName] then
		if not isBattleStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castRevenge(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Revenge
	z.ManaNeeded = 5
	if not Zorlen_Button[z.SpellName] then
		if not isDefensiveStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castCleave(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Cleave
	z.ManaNeeded = 20
	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castWhirlwind(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Whirlwind
	z.ManaNeeded = 25
	if not Zorlen_Button[z.SpellName] then
		if not isBerserkerStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	if not CheckInteractDistance("target", 3) then
		return false
	end
	if Zorlen_Button[LOCALIZATION_ZORLEN.Charge..".Any"] then
		if Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Charge) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Intercept..".Any"] then
		if Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Intercept) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Rend..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Rend) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Hamstring) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.SunderArmor) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Overpower..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Overpower) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Revenge..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Revenge) then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castSweepingStrikes(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.SweepingStrikes
	z.ManaNeeded = 30
	if not Zorlen_Button[z.SpellName] then
		if not isBattleStance() then
			return false
		end
	end
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castRend(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Rend
	z.DebuffName = z.SpellName
	z.DebuffImmune = Zorlen_IsTimer(z.SpellName, "immune", "InternalZorlenMiscTimer")
	z.ManaNeeded = 10
	if not Zorlen_Button[z.SpellName] then
		if isBerserkerStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	z.DebuffTimer = 1
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castDisarm(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Disarm
	z.DebuffName = z.SpellName
	z.DebuffImmune = Zorlen_DisarmSpellCastImmune
	z.ManaNeeded = 20
	if not Zorlen_Button[z.SpellName] then
		if not isDefensiveStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castHamstring(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Hamstring
	z.DebuffName = z.SpellName
	z.DebuffImmune = Zorlen_IsTimer(z.SpellName, "immune", "InternalZorlenMiscTimer")
	z.ManaNeeded = 10
	if not Zorlen_Button[z.SpellName] then
		if isDefensiveStance() or not Zorlen_isMainHandEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castExecute(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Execute
	if not Zorlen_Button[z.SpellName] then
		if isDefensiveStance() or not Zorlen_TargetIsDieingEnemy() or not Zorlen_isMainHandEquipped() then
			return false
		end
		z.ManaNeeded = Zorlen_ExecuteRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castThunderClap(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ThunderClap
	z.DebuffName = z.SpellName
	z.NoRangeCheck = 1
	if not CheckInteractDistance("target", 3) then
		return false
	end
	if Zorlen_Button[LOCALIZATION_ZORLEN.Charge..".Any"] then
		if Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Charge) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Intercept..".Any"] then
		if Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Intercept) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Rend..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Rend) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Hamstring..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Hamstring) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.SunderArmor..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.SunderArmor) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Overpower..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Overpower) then
			return false
		end
	elseif Zorlen_Button[LOCALIZATION_ZORLEN.Revenge..".Any"] then
		if not Zorlen_isActionInRangeBySpellName(LOCALIZATION_ZORLEN.Revenge) then
			return false
		end
	end
	if not Zorlen_Button[z.SpellName] then
		if not isBattleStance() then
			return false
		end
		z.ManaNeeded = Zorlen_ThunderClapRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castShieldBash(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ShieldBash
	z.ManaNeeded = 10
	if not Zorlen_Button[z.SpellName] then
		if isBerserkerStance() or not Zorlen_isShieldEquipped() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castPummel(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Pummel
	z.ManaNeeded = 10
	if not Zorlen_Button[z.SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castShieldBlock(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ShieldBlock
	z.ManaNeeded = 10
	z.BuffName = z.SpellName
	if not Zorlen_Button[z.SpellName] then
		if not isDefensiveStance() or not Zorlen_isShieldEquipped() then
			return false
		end
	end
	if not Zorlen_TargetIsEnemyTargetingYou() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castHeroicStrike(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.HeroicStrike
	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_isMainHandEquipped() then
			return false
		end
		z.ManaNeeded = Zorlen_HeroicStrikeRageCost()
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castDemoralizingShout(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.DemoralizingShout
	z.DebuffName = z.SpellName
	z.DebuffImmune = Zorlen_DemoSpellCastImmune
	z.ManaNeeded = 10
	z.NoRangeCheck = 1
	if not CheckInteractDistance("target", 3) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castPiercingHowl(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.PiercingHowl
	z.DebuffName = z.SpellName
	z.DebuffImmune = Zorlen_PiercingHowlSpellCastImmune
	z.ManaNeeded = 10
	z.NoRangeCheck = 1
	if not CheckInteractDistance("target", 3) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castBattleShout(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.BattleShout
	z.ManaNeeded = 10
	z.EnemyTargetNotNeeded = 1
	z.BuffName = z.SpellName
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castBerserkerRage(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.BerserkerRage
	z.EnemyTargetNotNeeded = 1
	if not Zorlen_Button[z.SpellName] then
		if not isBerserkerStance() then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castBloodrage(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Bloodrage
	z.SelfHealthGreaterThanPercent = 20
	z.EnemyTargetNotNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castDeathWish(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.DeathWish
	return Zorlen_CastCommonRegisteredSpell(z)
end

function castLastStand(test)
	local z = {}
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.LastStand
	z.EnemyTargetNotNeeded = 1
	if Zorlen_HealthDamagePercent("player") < 30 then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(z)
end

-- Will some times make getting critted on much more likely.
-- This may cause you more damage so use cautiously.
function castEnrage()
	local u = UnitHealth("player") / UnitHealthMax("player") > 0.2
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.Enrage) > 0
	local e = isEnrageActive()
	if not e and t and u and not Zorlen_TargetIsDieingEnemy() then
		ClearTarget()
		DoEmote(LOCALIZATION_ZORLEN.sit)
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
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.Charge] and (mode == "force" or mode == "swap" or mode == "mid") and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Charge]) == 1 and not isBattleStance() and Zorlen_notInCombat() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge) then
			return castBattleStance()
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and (mode == "force" or mode == "swap" or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and (Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Charge) or not Zorlen_IsTimer("CastChargeDelay", nil, "InternalZorlenMiscTimer")) and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept]) == 1 and not isBerserkerStance() and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept) and ((UnitMana("player") >= 10 and Zorlen_TacticalMasteryRagePoints() >= 10) or ((mode == "force" or mode == "mid") and ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Bloodrage) and UnitHealth("player") / UnitHealthMax("player") > 0.2) or ((Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage)) and (Zorlen_BerserkerRageRagePoints() >= 10 or (Zorlen_BerserkerRageRagePoints() >= 5 and Zorlen_TacticalMasteryRagePoints() >= 5 and UnitMana("player") >= 5)))))) then
			return castBerserkerStance()
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and isBerserkerStance() and Zorlen_inCombat() and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept]) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept) and UnitMana("player") < 10 and (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedBerserkerRage) == 2 or (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN.ImprovedBerserkerRage) == 1 and UnitMana("player") >= 5)) and castBerserkerRage() then
			return true
		elseif Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] and isBerserkerStance() and ((mode == "force") or (mode == "mid" and UnitHealth("player") / UnitHealthMax("player") >= 0.5)) and Zorlen_inCombat() and IsActionInRange(Zorlen_Button[LOCALIZATION_ZORLEN.Intercept]) == 1 and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Intercept) and UnitMana("player") < 10 and castBloodrage() then
			return true
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button[LOCALIZATION_ZORLEN.Charge] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Charge) then
			Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Charge.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!", 1);
		end
	end
	if (mode == "force" or mode == "swap") and not Zorlen_Button[LOCALIZATION_ZORLEN.Intercept] then
		if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Intercept) then
			Zorlen_debug("You must put "..LOCALIZATION_ZORLEN.Intercept.." on one of your action bars (even if it is hidden) for Zorlen's castChargeAndIntercept() to work right!", 1);
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
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage) then
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
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage) then
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
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.BerserkerRage) then
		if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.BerserkerRage) then
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
	elseif not isBattleStance() and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SweepingStrikes) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.SweepingStrikes) and m <= (t + 10) and castBattleStance() then
		return true
	elseif (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.SweepingStrikes) or not (m <= (t + 10))) and castWhirlwind() then
		return true
	elseif not isBerserkerStance() and (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.SweepingStrikes)) and Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Whirlwind) and Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Whirlwind) and m <= (t + 10) and castBerserkerStance() then
		return true
	elseif (not isBattleStance() or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SweepingStrikes) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.SweepingStrikes)) and (not isBerserkerStance() or not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Whirlwind) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Whirlwind)) and castCleave() then
		return true
	elseif (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.SweepingStrikes) or (not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.SweepingStrikes) and not Zorlen_checkBuff(Ability_Rogue_SliceDice))) and castThunderClap() then
		return true
	elseif not isBattleStance() and not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Cleave) and (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN.Whirlwind) or not Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN.Whirlwind)) and m <= (t + 10) and castBattleStance() then
		return true
	end
	return false
end


