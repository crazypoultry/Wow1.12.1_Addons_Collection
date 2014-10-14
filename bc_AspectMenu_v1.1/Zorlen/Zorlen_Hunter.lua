
Zorlen_Hunter_FileBuildNumber = 681

--[[
  Zorlen Library - Started by Marcus S. Zarra

  4.18
		castScareBeast() added by BigRedBrent

  4.13
		Updated castSting() to work for bosses
		Added a new "z Shot Rotation" macro with "/zorlen make macros"

  4.12
		isAutoShotActive() added by BigRedBrent

  4.02
		Removed lag that the eat and drink functions may have caused hunters during combat

  4.01
		Updated: castWyvernSting()
		Updated: castMend()

  3.98.08
		Fixed trap functions

  3.98.02
		Updated castShotRotation() to not cast buffs and will now use aimed shot if the target is not aggroed or if it is cc'ed

  3.98
		Added isClipped() check to castCon()

  3.97
		Fixed buff and debuff detection that I (BigRedBrent) broke

  3.67.02
		Fixed: castBestialWrath() and castIntimidation()

  3.67.00
		Updated Trap functions some
		Fixed: castFrostTrap()

  3.63.00
		Updated Trap functions
		Removed Hunter's Mark from castShotRotation()

  3.62.00
		Added Hunters Mark to the castShotRotation() functions

  3.61.00
		Added Feign Death to castShotRotation() and castShotRotationWithoutMulti() by BigRedBrent
		castShotRotationWithoutMultiOrFeign() added by BigRedBrent
		castShotRotationWithoutFeign() added by BigRedBrent
		isAspectActive() added by BigRedBrent

  3.60.00
		Updated: castShotRotation() -- Increased the auto shot delay for aimed shot from  one fourth a second to one half a second for those who may be slower.

  3.59.00
		castShotRotation() added by BigRedBrent
		castShotRotationWithoutMulti() added by BigRedBrent
		isScatter() added by BigRedBrent
		castMong() will now reserve mana for Feign Death
		castRaptor() will now reserve mana for Feign Death
		castClip() will now reserve mana for Feign Death
		castExplosiveTrap() will now reserve mana for Feign Death
		castImmolationTrap() will now reserve mana for Feign Death
		castMend() will now reserve mana for Feign Death

  3.58.00
		castSting() added by BigRedBrent

  3.57.00
		Updated: castAutoShot()
		Updated: stopAutoShot()

  3.56.00
		Fixed: castWyvernStingWithPetPassive()
		castRapid() added by BigRedBrent
		isRapidActive() added by BigRedBrent

  3.55.00
		castBestialWrath() added by BigRedBrent
		castIntimidation() added by BigRedBrent

  3.54.00
		Fixed some bugs with castMend()

  3.52.00
		Updated Feign Death and Trap functions some

  3.34.00
		Pressing and holding down the Control Key will now suppress the debuff checking for viper sting.

  3.33.33
		isWyvern() added by BigRedBrent
		isStung() added by BigRedBrent
		Improved castMend() casting.
		Replaced the alt key modifier with the control key.

  3.33.00
		isPackActive() added by BigRedBrent
		castPack() added by BigRedBrent
		isBeastActive() added by BigRedBrent
		castBeast() added by BigRedBrent
		Pressing and holding down the Control Key will now suppress the debuff checking for serpent sting.

  3.31.00
		isTrueshotActive() added by BigRedBrent
		castTrueshot() added by BigRedBrent

  3.30.00
		castWyvernSting() added by BigRedBrent
		castWyvernStingWithPetPassive() added by BigRedBrent
		Moved needPet() and rezPet() back to the Zorlen_Pets.lua file.

  3.18.00
		castWild() added by Wildbill
		castDisengage() added by Wildbill
		Added some debuff immunity detection by BigRedBrent
		Improved pet death detection significantly by BigRedBrent

  3.10.0
		stopAutoShot() added by BigRedBrent

  3.9.12
		castFeign() added by BigRedBrent
		castScatter() added by BigRedBrent

  3.9.11
		Updated castCallAndDismissPet() to detect pet deaths.

  3.9.9f
		castMulti() added by BigRedBrent

  3.9.9c
		castAutoShot() added by BigRedBrent

  3.5.5
		Moved some hunter funtions from the Zorlen_Pets.lua file to the Zorlen_Hunter.lua file.

  3.5.2
  		castCounter() added by BigRedBrent

  3.1.0  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
  		castFreezingTrap() added by BigRedBrent
		castFreezingTrapWithPetPassive() added by BigRedBrent
		castFrostTrap() added by BigRedBrent
		castExplosiveTrap() added by BigRedBrent
		castImmolationTrap() added by BigRedBrent

  3.0.0  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
  		Moved Hunter specific functions from Zorlen.lua
		castHawk() refactored to use existing isHawkActive function		  
		castSerpent() refactored to use existing isSerpent function
		castViper() refactored to use existing usesMana and isViper()
		castScorpid() refactored to use existing isScorpid function
		castMark() refactored to use existing isMarked function
		castMonkey() added return true/false
		castCheetah() added return true/false
--]]



function Zorlen_Hunter_SpellTimerSet()
	local Number = 0
	local TargetName = Zorlen_CastingSpellTargetName
	local SpellName = Zorlen_CastingSpellName
	
	if SpellName == LOCALIZATION_ZORLEN_SerpentSting then
		Number = 15
		
	elseif SpellName == LOCALIZATION_ZORLEN_ViperSting then
		Number = 8
		
	elseif SpellName == LOCALIZATION_ZORLEN_ScorpidSting then
		Number = 20
		
	elseif SpellName == LOCALIZATION_ZORLEN_WyvernSting then
		Number = 26
		
	elseif SpellName == LOCALIZATION_ZORLEN_ScareBeast then
		Number = 5 + (Zorlen_CastingSpellRank * 5)
		
	end
	
	Zorlen_SetTimer(Number, SpellName, TargetName, "InternalZorlenSpellTimers", nil, nil, 1)
end

function Zorlen_Hunter_AfterPreSpellCancelTimers(Name, Pre, Tag)
	if Tag == "InternalZorlenSpellTimers" then
		if
			Name == LOCALIZATION_ZORLEN_SerpentSting
			 or
			Name == LOCALIZATION_ZORLEN_ViperSting
			 or
			Name == LOCALIZATION_ZORLEN_ScorpidSting
			 or
			Name == LOCALIZATION_ZORLEN_WyvernSting
		then
			if Name ~= LOCALIZATION_ZORLEN_SerpentSting then
				Zorlen_ClearTimer(LOCALIZATION_ZORLEN_SerpentSting, Pre, Tag)
			end
			if Name ~= LOCALIZATION_ZORLEN_ViperSting then
				Zorlen_ClearTimer(LOCALIZATION_ZORLEN_ViperSting, Pre, Tag)
			end
			if Name ~= LOCALIZATION_ZORLEN_ScorpidSting then
				Zorlen_ClearTimer(LOCALIZATION_ZORLEN_ScorpidSting, Pre, Tag)
			end
			if Name ~= LOCALIZATION_ZORLEN_WyvernSting then
				Zorlen_ClearTimer(LOCALIZATION_ZORLEN_WyvernSting, Pre, Tag)
			end
		end
	end
end



function Zorlen_Hunter_MakeMacros()
	if Zorlen_isCurrentClassHunter then
		Zorlen_MakeMacro("z Mend Pet", "/script if not needPet()then castOverMend()end--CastSpellByName(\""..LOCALIZATION_ZORLEN_MendPet.."("..LOCALIZATION_ZORLEN_Rank.." 1)\")", 1, "Ability_Hunter_MendPet", nil, nil, 1)
		Zorlen_MakeMacro("z FreezingTrap", "/script castFreezingTrapWithPetPassive()--CastSpellByName(\""..LOCALIZATION_ZORLEN_FreezingTrap.."\")", 1, "Spell_Frost_ChainsOfIce", nil, nil, 1)
		Zorlen_MakeMacro("z FrostTrap", "/script castFrostTrap()--CastSpellByName(\""..LOCALIZATION_ZORLEN_FrostTrap.."\")", 1, "Spell_Frost_FreezingBreath", nil, nil, 1)
		Zorlen_MakeMacro("z ExplosiveTrap", "/script castExplosiveTrap()--CastSpellByName(\""..LOCALIZATION_ZORLEN_ExplosiveTrap.."\")", 1, "Spell_Fire_SelfDestruct", nil, nil, 1)
		Zorlen_MakeMacro("z ImmolationTrap", "/script castImmolationTrap()--CastSpellByName(\""..LOCALIZATION_ZORLEN_ImmolationTrap.."\")", 1, "Spell_Fire_FlameShock", nil, nil, 1)
		Zorlen_MakeMacro("z Call Pet", "/script castCallAndDismissPet()--CastSpellByName(\""..LOCALIZATION_ZORLEN_CallPet.."\")", 1, "Ability_Hunter_BeastCall", nil, nil, 1)
		Zorlen_MakeMacro("z Shot Rotation", "/script local a=Zorlen_TargetIsActiveEnemy()if a or Zorlen_isEnemyPlayer()then if a then castAutoShot()end if not a or not castSting()then castShotRotation()end else Zorlen_TargetActiveEnemyOnly()end--CastSpellByName(\""..LOCALIZATION_ZORLEN_AimedShot.."\")", 1, "Ability_SearingArrow", nil, nil, 1)
		Zorlen_MakeMacro("z Wyvern Sting", "/script castWyvernSting()--CastSpellByName(\""..LOCALIZATION_ZORLEN_WyvernSting.."\")", 1, "Ability_Rogue_DualWeild", nil, nil, 1)
	end
end

function Zorlen_Hunter_OnUpdate(arg1, TimerRunDown)
	if not Zorlen_isCurrentClassHunter then
		return false
	end
	if Zorlen_PetIsDead then
		if UnitHealth("pet") > 0 then
			Zorlen_debug("Your pet is now alive!")
			Zorlen_PetIsDead = nil
			ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] = nil
		end
	elseif UnitHealth("pet") == 0 and (UnitIsDead("pet") or PetCanBeAbandoned()) then
		Zorlen_debug("Your pet is now dead!")
		Zorlen_PetIsDead = 1
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] = true
	end
	if TimerRunDown then
			if Zorlen_IsTimer("CheckForWingClipDebuffWindow_timer", nil, "InternalZorlenMiscTimer") then
				if Zorlen_GetTimer("CheckForWingClipDebuffWindow_timer", nil, "InternalZorlenMiscTimer") <= 0 then
					if not isClipped() then
						Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_WingClip.."!")
						Zorlen_WasWingClipSpellCastImmune = 1
						Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_WingClip, "immune", "InternalZorlenMiscTimer")
					end
					Zorlen_ClearTimer("CheckForWingClipDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
				end
			end
	end
	return true
end


function Zorlen_Hunter_OnEvent_CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES(arg1, arg2, arg3)
	if string.find(arg1, LOCALIZATION_ZORLEN_You_dodge) then
		Zorlen_debug("You dodged an attack. Cast "..LOCALIZATION_ZORLEN_MongooseBite.." now!")
		if not ZorlenInitialized then
			Zorlen_CheckVariables()
		elseif (not ZorlenConfig[ZORLEN_ZPN][ZORLEN_ZDS]) then
			PlaySound("LEVELUPSOUND")
		end
	end
end


function Zorlen_Hunter_OnEvent_PLAYER_TARGET_CHANGED()
	Zorlen_WasWingClipSpellCastImmune = nil
	Zorlen_WasConcussiveShotSpellCastImmune = nil
	Zorlen_SerpentStingSpellCastImmune = nil
	Zorlen_WasViperStingSpellCastImmune = nil
	Zorlen_ScorpidStingSpellCastImmune = nil
	Zorlen_HuntersMarkSpellCastImmune = nil
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_ViperSting, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_ConcussiveShot, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer(LOCALIZATION_ZORLEN_WingClip, "immune", "InternalZorlenMiscTimer")
	Zorlen_ClearTimer("CheckForWingClipDebuffWindow_timer", nil, "InternalZorlenMiscTimer")
	if Zorlen_TrapClearTargetFlag and UnitExists("target") then
		Zorlen_TrapClearTargetFlag = nil
	end
end


function Zorlen_Hunter_OnEvent_CHAT_MSG_SPELL_SELF_DAMAGE(arg1, arg2, arg3, TargetName, failed, immune, hit)
	if not immune and not failed and hit and string.find(arg1, Zorlen_gsub(LOCALIZATION_ZORLEN_HitsOrCritsArray[hit], "%(%.%+%)", LOCALIZATION_ZORLEN_WingClip, "%(%.%*%)", TargetName)) then
		Zorlen_SetTimer(1, "CheckForWingClipDebuffWindow_timer", nil, "InternalZorlenMiscTimer", 2, 1)
	elseif not immune then
		return
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_WingClip, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_WingClip.."!")
		Zorlen_WasWingClipSpellCastImmune = 1
		Zorlen_SetTimer(7, LOCALIZATION_ZORLEN_WingClip, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_ConcussiveShot, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ConcussiveShot.."!")
		Zorlen_WasConcussiveShotSpellCastImmune = 1
		Zorlen_SetTimer(10, LOCALIZATION_ZORLEN_ConcussiveShot, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_ViperSting, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ViperSting.."!")
		Zorlen_WasViperStingSpellCastImmune = 1
		Zorlen_SetTimer(10, LOCALIZATION_ZORLEN_ViperSting, "immune", "InternalZorlenMiscTimer")
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_SerpentSting, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_SerpentSting.."!")
		Zorlen_SerpentStingSpellCastImmune = 1
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_ScorpidSting, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_ScorpidSting.."!")
		Zorlen_ScorpidStingSpellCastImmune = 1
	elseif string.find(arg1, Zorlen_gsub_immune(LOCALIZATION_ZORLEN_HuntersMark, TargetName)) then
		Zorlen_debug("Target is immune to "..LOCALIZATION_ZORLEN_HuntersMark.."!")
		Zorlen_HuntersMarkSpellCastImmune = 1
	end
end


function Zorlen_Hunter_OnEvent_UI_ERROR_MESSAGE(arg1, arg2, arg3)
	if string.find(arg1, LOCALIZATION_ZORLEN_pet_is_not_dead) then
		Zorlen_debug(LOCALIZATION_ZORLEN_pet_is_not_dead)
		Zorlen_PetIsDead = nil
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] = nil
	elseif string.find(arg1, LOCALIZATION_ZORLEN_pet_is_dead) then
		Zorlen_debug(LOCALIZATION_ZORLEN_pet_is_dead)
		Zorlen_PetIsDead = 1
		ZorlenConfig[ZORLEN_ZPN][ZORLEN_PETISDEAD] = true
	end
end



function castShotRotationWithoutMulti()
	return castShotRotation("nomulti")
end

function castShotRotationWithoutMultiOrFeign()
	return castShotRotation("nomultiorfeign")
end

function castShotRotationWithoutFeign()
	return castShotRotation("nofeign")
end

function castShotRotation(mode)
	if Zorlen_isActiveEnemy() then
		if Zorlen_isEnemyPlayer() and not UnitExists("targettarget") and castAimed() then
			return true
		end
	else
		stopAutoShot()
		return castAimed()
	end
	local SpellName = LOCALIZATION_ZORLEN_AimedShot
	local AimedCooldown = 0
	local start = nil
	local enable = nil
	if mode ~= "nofeign" and mode ~= "nomultiorfeign" and Zorlen_inCombat() and SpellName and Zorlen_IsTimer("AimedShotRotationWindow", nil, "InternalZorlenMiscTimer") and not UnitIsPlayer("target") then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			start, AimedCooldown, enable = GetSpellCooldown(SpellID, 0)
		end
	end
	local Classification = UnitClassification("target") or ""
	local boss = string.find(string.lower(Classification), "boss")
	if mode ~= "nofeign" and mode ~= "nomultiorfeign" and Zorlen_inCombat() and Zorlen_IsTimer("AimedShotRotationWindow", nil, "InternalZorlenMiscTimer") and not UnitIsPlayer("target") and (AimedCooldown > 1.5 or Zorlen_TargetIsEnemyTargetingYou()) and castFeign() then
		return true
	elseif mode ~= "nomulti" and mode ~= "nomultiorfeign" and castMulti() then
		return true
	elseif not UnitIsUnit("player", "targettarget") and (boss or not Zorlen_isDieingEnemy()) and not isQuickshotsActive() and not (isRapidActive() and isHawkActive() and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedAspectOfTheHawk) > 0) and Zorlen_IsTimer("AimedShotRotationWindow", nil, "InternalZorlenMiscTimer") and castAimed() then
		return true
	end
	return false
end


function castAutoShot()
	if not Zorlen_isCastingOrChanneling() and Zorlen_isEnemy() and not isAutoShotActive() then
		CastSpellByName(LOCALIZATION_ZORLEN_AutoShot)
		return true
	end
	return false
end

function stopAutoShot()
	if isAutoShotActive() then
		SpellStopCasting()
		return true
	end
	return false
end

function isAutoShotActive()
	local SpellName = LOCALIZATION_ZORLEN_AutoShot
	local SpellButton = Zorlen_Button[SpellName]
	if SpellButton then
		local isAutoRepeating = IsAutoRepeatAction(SpellButton)
		if ( isAutoRepeating == 1 ) then
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_AutoShoot then
			return true
		end
	end
	return false
end


function testMSZ()
--if mana caster checkViper.  If available cast else cast arcane
--if not mana caster checkScorpid.  If available cast else cast arcane
	Zorlen_debug("DEPRECATED FUNCTION - this will be removed in a future release", 1)
end

function testMong() 
	local SpellName = LOCALIZATION_ZORLEN_ArcaneShot
	--local SpellName = LOCALIZATION_ZORLEN_MongooseBite
	local SpellID = Zorlen_GetSpellID(SpellName)
	local start, duration, enable = GetSpellCooldown(SpellID, 0)
	Zorlen_debug("Enable is " .. enable .. " Duration is " .. duration .. " Start is " .. start, 1)
end


--Returns true if you are not in combat and can place a trap
function canTrap()
	if (Zorlen_Combat) then
		return false
	end
	return true
end

--Returns true if any Aspect is active
function isAspectActive()
	if
	isHawkActive()
	or
	isMonkActive()
	or
	isCheetahActive()
	or
	isBeastActive()
	or
	isWildActive()
	or
	isPackActive()
	then
		return true
	end
	return false
end

--Returns true if Aspect of the Wild is active
function isWildActive()
	if
	not isHawkActive()
	and
	not isMonkActive()
	and
	not isCheetahActive()
	and
	not isBeastActive()
	then
		return Zorlen_checkBuff("Spell_Nature_ProtectionformNature")
	end
	return false
end

--Returns true if Aspect of the Beast is active
function isBeastActive()
	return Zorlen_checkBuff("Ability_Mount_PinkTiger")
end

--Returns true if Aspect of the Hawk is active
function isHawkActive()
	return Zorlen_checkBuff("Spell_Nature_RavenForm")
end

--Returns true if Aspect of the Monkey is active
function isMonkActive()
	return Zorlen_checkBuff("Ability_Hunter_AspectOfTheMonkey")
end

--Returns true if Aspect of the Cheetah is active
function isCheetahActive()
	return Zorlen_checkBuff("Ability_Mount_JungleTiger")
--  return Zorlen_checkBuff("JungleTiger")
end

--Returns true if Aspect of the Cheetah is active
function isPackActive()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfThePack
	if
	not isHawkActive()
	and
	not isMonkActive()
	and
	not isCheetahActive()
	and
	not isBeastActive()
	then
		return Zorlen_checkBuffByName(SpellName)
	end
	return false
end

--Returns true if Trueshot Aura is active
function isTrueshotActive(HasDuration)
	return Zorlen_checkSelfBuff("Ability_TrueShot", nil, nil, nil, HasDuration)
end

--Returns true if the target has Wing Clip on it
function isClipped(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Rogue_Trip", unit, dispelable)
end

--Returns true if the target has Concussion Shot on it
function isConned(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Frost_Stun", unit, dispelable)
end

--Returns true if the target has Hunter's Mark cast on it already
function isMarked(unit, dispelable)
	return Zorlen_checkDebuff("Sniper", unit, dispelable)
end

function isScatter(unit, dispelable)
	return Zorlen_checkDebuff("Ability_GolemStormBolt", unit, dispelable)
end

function isSerpent(unit, dispelable)
	local u = unit or "target"
	local Name = UnitName(u)
	if Zorlen_IsTimer(LOCALIZATION_ZORLEN_SerpentSting, Name, "InternalZorlenSpellTimers") and Zorlen_checkDebuff("Ability_Hunter_Quickshot", unit, dispelable) then
		return true
	end
	return false
end

function isScorpid(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Hunter_CriticalShot", unit, dispelable)
end

function isViper(unit, dispelable)
	return Zorlen_checkDebuff("Ability_Hunter_AimedShot", unit, dispelable)
end

function isWyvern(unit, dispelable)
	return Zorlen_checkDebuff("INV_Spear_02", unit, dispelable)
end

function isStung(unit, dispelable)
	local u = unit or "target"
	local Name = UnitName(u)
	if
	(Zorlen_IsTimer(LOCALIZATION_ZORLEN_SerpentSting, Name, "InternalZorlenSpellTimers") and Zorlen_checkDebuff("Ability_Hunter_Quickshot", unit, dispelable))
	 or
	(Zorlen_IsTimer(LOCALIZATION_ZORLEN_ScorpidSting, Name, "InternalZorlenSpellTimers") and Zorlen_checkDebuff("Ability_Hunter_CriticalShot", unit, dispelable))
	 or
	(Zorlen_IsTimer(LOCALIZATION_ZORLEN_ViperSting, Name, "InternalZorlenSpellTimers") and Zorlen_checkDebuff("Ability_Hunter_AimedShot", unit, dispelable))
	 or
	(Zorlen_IsTimer(LOCALIZATION_ZORLEN_WyvernSting, Name, "InternalZorlenSpellTimers") and Zorlen_checkDebuff("INV_Spear_02", unit, dispelable))
	then
		return true
	end
	return false
end

--Returns true if the hunter is currently feigned
--Written by Malnyth of Ravencrest
--edited by BigRedBrent
function isFeign()
	if UnitHealth("player") == 0 then
		return true
	end
	return false
end

--Returns true if Hunter Quickshots is active
function isQuickshotsActive()
	return Zorlen_checkBuff("InnerRage")
end

--Returns true if Hunter Rapid Fire is active
function isRapidActive()
	return Zorlen_checkBuff("RunningShot")
end



function castSting()
	local Classification = UnitClassification("target") or ""
	local boss = string.find(string.lower(Classification), "boss")
	local stung = isStung()
	if boss then
		if castViper() then
			return true
		elseif not stung then
			return castSerpent()
		end
	elseif not stung and not Zorlen_TargetIsDieingEnemy() then
		if UnitPlayerControlled("target") then
			if UnitPowerType("target") == 0 then
				return castViper()
			end
			return castScorpid()
		end
		return castSerpent()
	end
	return false
end

function castScareBeast(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	if UnitCreatureType("target") ~= "Beast" and not isDruid() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_ScareBeast
	local DebuffCheckIncluded = 1
	local DebuffCheck = Zorlen_isCrowedControlled()
	local Name = UnitName("target")
	if Zorlen_IsTimer(SpellName, Name, "InternalZorlenSpellTimers") and DebuffCheck then
		if Zorlen_GetTimer(SpellName, Name, "InternalZorlenSpellTimers") <= 1.5 then
			if not Zorlen_isNoDamageCC() then
				DebuffCheck = nil
			end
		end
	end
	local StopCasting = DebuffCheck
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, nil, nil, nil, DebuffCheckIncluded, DebuffCheck, nil, nil, nil, nil, nil, nil, nil, nil, StopCasting)
end

--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castSerpent(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_SerpentSting
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_SerpentStingSpellCastImmune
	local DebuffTimer = 1
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, DebuffTimer)
end

--Wynn 12/27/05 - Refactor to use existing usesMana and isViper checks
--edited by BigRedBrent
function castViper(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ViperSting
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	local TargetThatUsesManaNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune, nil, nil, nil, nil, TargetThatUsesManaNeeded)
end

--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castScorpid(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ScorpidSting
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_ScorpidStingSpellCastImmune
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune)
end

--Added by Nuckin
--edited by BigRedBrent
function castMong(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_MongooseBite
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 30, 40, 50, 65 }
	local q = 0
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	if Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName) then
		q = 80
	end
	if q == 0 then
		return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
	elseif SpellRank then
		if (mana >= (m[r] + q )) or (health == 0) then
			return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
		end
	else
		for i = 4, 1, -1 do
			if r == i then
				if (mana >= (m[i] + q )) or (health == 0) then
					return Zorlen_CastCommonRegisteredSpell(nil, SpellName)
				end
				break
			end
		end
	end
	return false
end

function castCounter(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Counterattack
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

--Added by Nuckin
--edited by BigRedBrent
function castCon(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ConcussiveShot
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	if isClipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune)
end

--Added by Nuckin
--edited by BigRedBrent
function castRaptor(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_RaptorStrike
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 15, 25, 35, 45, 55, 70, 85, 100 }
	local q = 0
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	if Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName) then
		q = 80
	end
	if q == 0 then
		return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
	elseif SpellRank then
		if (mana >= (m[r] + q )) or (health == 0) then
			return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
		end
	else
		for i = 8, 1, -1 do
			if r == i then
				if (mana >= (m[i] + q )) or (health == 0) then
					return Zorlen_CastCommonRegisteredSpell(nil, SpellName)
				end
				break
			end
		end
	end
	return false
end

--If Aspect of the Hawk is not already active, cast highest level
--Written by Andrew Young(andrew@inmyroom.org)
--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castHawk()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheHawk
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

-- Added by Wildbill
--edited by BigRedBrent
function castWild()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheWild
	local EnemyTargetNotNeeded = 1
	local BuffCheckIncluded = 1
	local BuffCheck = isWildActive()
	local NoRangeCheck = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, BuffCheckIncluded, BuffCheck, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end

function castBeast()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheBeast
	local EnemyTargetNotNeeded = 1
	local BuffCheckIncluded = 1
	local BuffCheck = isBeastActive()
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, BuffCheckIncluded, BuffCheck)
end

function castDistract(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_DistractingShot
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

function castArcane(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ArcaneShot
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

-- Added by Wildbill
--edited by BigRedBrent
function castDisengage(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Disengage
	if not Zorlen_TargetIsEnemyMob() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

function castScatter(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ScatterShot
	if Zorlen_isCrowedControlled() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

function castMulti(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_MultiShot
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

function castAimed(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_AimedShot
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

--If A Hunter's Mark is not already on the target will cast highest level
--Written by Andrew Young(andrew@inmyroom.org)
--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castMark(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_HuntersMark
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_HuntersMarkSpellCastImmune
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune)
end

--If Aspect of the Monkey is not already active, it will cast it
--Wynn 12/27/05 - Added return values to function
--edited by BigRedBrent
function castMonkey()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheMonkey
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

function castFeign()
	local SpellName = LOCALIZATION_ZORLEN_FeignDeath
	local EnemyTargetNotNeeded = 1
	if isFeign() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded)
end

--Testing function.  Will return the name of the current aspect
function Zorlen_getAspectName()
	local x = 1
	while (UnitBuff("player", x)) do
		if (string.find(UnitBuff("player", x), "Aspect")) then
			Zorlen_debug(UnitBuff("player", x), 1)
			break
		end
		x = x + 1
	end
end

--If Aspect of the Cheetah is not already active, it will cast it
--Wynn 12/27/05 - Added return values to function
--edited by BigRedBrent
function castCheetah()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheCheetah
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

function castPack()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfThePack
	local EnemyTargetNotNeeded = 1
	local BuffCheckIncluded = 1
	local BuffCheck = isPackActive()
	local NoRangeCheck = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, BuffCheckIncluded, BuffCheck, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end

--If Trueshot Aura is not already active, it will cast it
function castTrueshot(HasDuration)
	local SpellName = LOCALIZATION_ZORLEN_TrueshotAura
	local EnemyTargetNotNeeded = 1
	local BuffCheckIncluded = 1
	local BuffCheck = isTrueshotActive(HasDuration)
	local NoRangeCheck = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, BuffCheckIncluded, BuffCheck, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end

function castBestialWrath()
	local SpellName = LOCALIZATION_ZORLEN_BestialWrath
	local EnemyTargetNotNeeded = 1
	local NoRangeCheck = 1
	if not (UnitHealth("pet") > 0) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end
castBeastialWrath = castBestialWrath

function castIntimidation()
	local SpellName = LOCALIZATION_ZORLEN_Intimidation
	local EnemyTargetNotNeeded = 1
	local NoRangeCheck = 1
	if not (UnitHealth("pet") > 0) then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end

function castRapid()
	local SpellName = LOCALIZATION_ZORLEN_RapidFire
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName)
end

--Aded by Jayphen
--edited by BigRedBrent
function castClip(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_WingClip
	local DebuffName = SpellName
	local DebuffImmune = Zorlen_IsTimer(SpellName, "immune", "InternalZorlenMiscTimer")
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 40, 60, 80 }
	local q = 0
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	if Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName) then
		q = 80
	end
	if q == 0 then
		return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, DebuffImmune)
	elseif SpellRank then
		if (mana >= (m[r] + q )) or (health == 0) then
			return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
		end
	else
		for i = 3, 1, -1 do
			if r == i then
				if (mana >= (m[i] + q )) or (health == 0) then
					return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, DebuffImmune)
				end
				break
			end
		end
	end
	return false
end




function castWyvernStingWithPetPassive(SpellRank)
	return castWyvernSting(SpellRank, "passive")
end

function castWyvernSting(SpellRank, mode)
	local SpellName = LOCALIZATION_ZORLEN_WyvernSting
	local FeignSpellID = nil
	local start, duration, enable = 0, 0, 0
	local FeignSpellKnown = nil
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 115, 155, 205 }
	local q = 0
	local DebuffCheckIncluded = 1
	local DebuffCheck = Zorlen_isNoDamageCC()
	local SpellCheckNotNeeded = 1
	if (Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName)) then
		FeignSpellKnown = 1
		FeignSpellID = Zorlen_GetSpellID(FeignSpellName, 0)
		start, duration, enable = GetSpellCooldown(FeignSpellID, 0)
		if not canTrap() then
			q = 80
		end
	end
	if Zorlen_checkCooldownByName(SpellName) then
		for i = 3, 1, -1 do
			if (mana >= (m[i] + q)) or (health == 0) then
				if r == i then
					if canTrap() then
						if Zorlen_TrapClearTargetFlag then
							TargetLastEnemy()
							Zorlen_TrapClearTargetFlag = nil
						end
						if health == 0 and not UnitIsPlayer("target") and not UnitExists("targettarget") then
							return false
						elseif not Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, nil, nil, nil, DebuffCheckIncluded, DebuffCheck, nil, nil, SpellCheckNotNeeded) then
							return false
						end
						if mode == "passive" then
							PetPassiveMode()
						end
						return true
					else
						if FeignSpellKnown then
							if duration == 0 and health > 0 then
								if UnitExists("target") then
									Zorlen_TrapClearTargetFlag = 1
									ClearTarget()
								end
								if UnitExists("pettarget") or (mode == "passive") then
									if UnitExists("pettarget") then
										PetFollow()
									end
									PetPassiveMode()
								end
								CastSpell(FeignSpellID, 0)
								return true
							end
						end
					end
					break
				end
			end
		end
	end
	if Zorlen_TrapClearTargetFlag and duration > 1.5 then
		TargetLastEnemy()
		Zorlen_TrapClearTargetFlag = nil
	end
	return false
end




function castFreezingTrapWithPetPassive(SpellRank)
	return castFreezingTrap(SpellRank, "passive")
end

function castFreezingTrap(SpellRank, mode)
	local SpellName = LOCALIZATION_ZORLEN_FreezingTrap
	local FeignSpellID = nil
	local start, duration, enable = 0, 0, 0
	local FeignSpellKnown = nil
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 50, 75, 100 }
	local q = 0
	if (Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName)) then
		FeignSpellKnown = 1
		FeignSpellID = Zorlen_GetSpellID(FeignSpellName, 0)
		start, duration, enable = GetSpellCooldown(FeignSpellID, 0)
		if not canTrap() then
			q = 80
		end
	end
	if Zorlen_checkCooldownByName(SpellName) then
		for i = 3, 1, -1 do
			if (mana >= (m[i] + q)) or (health == 0) then
				if r == i then
					if canTrap() then
						if not Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, 1) then
							return false
						end
						if mode == "passive" then
							PetPassiveMode()
						end
						if Zorlen_TrapClearTargetFlag then
							TargetLastEnemy()
							Zorlen_TrapClearTargetFlag = nil
						end
						return true
					else
						if FeignSpellKnown then
							if duration == 0 and health > 0 then
								if UnitExists("target") then
									Zorlen_TrapClearTargetFlag = 1
									ClearTarget()
								end
								if UnitExists("pettarget") or (mode == "passive") then
									if UnitExists("pettarget") then
										PetFollow()
									end
									PetPassiveMode()
								end
								CastSpell(FeignSpellID, 0)
								return true
							end
						end
					end
					break
				end
			end
		end
	end
	if Zorlen_TrapClearTargetFlag and duration > 1.5 then
		TargetLastEnemy()
		Zorlen_TrapClearTargetFlag = nil
	end
	return false
end

function castImmolationTrap(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ImmolationTrap
	local FeignSpellID = nil
	local start, duration, enable = 0, 0, 0
	local FeignSpellKnown = nil
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 50, 90, 135, 190, 245 }
	local q = 0
	if (Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName)) then
		FeignSpellKnown = 1
		FeignSpellID = Zorlen_GetSpellID(FeignSpellName, 0)
		start, duration, enable = GetSpellCooldown(FeignSpellID, 0)
		if not canTrap() then
			q = 80
		end
	end
	if Zorlen_checkCooldownByName(SpellName) then
		for i = 5, 1, -1 do
			if (mana >= (m[i] + q)) or (health == 0) then
				if r == i then
					if canTrap() then
						if not Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, 1) then
							return false
						end
						if Zorlen_TrapClearTargetFlag then
							TargetLastEnemy()
							Zorlen_TrapClearTargetFlag = nil
						end
						return true
					else
						if FeignSpellKnown then
							if duration == 0 and health > 0 then
								if UnitExists("target") then
									Zorlen_TrapClearTargetFlag = 1
									ClearTarget()
								end
								if UnitExists("pettarget") then
									PetFollow()
									PetPassiveMode()
								end
								CastSpell(FeignSpellID, 0)
								return true
							end
						end
					end
					break
				end
			end
		end
	end
	if Zorlen_TrapClearTargetFlag and duration > 1.5 then
		TargetLastEnemy()
		Zorlen_TrapClearTargetFlag = nil
	end
	return false
end

function castFrostTrap()
	local SpellName = LOCALIZATION_ZORLEN_FrostTrap
	local FeignSpellID = nil
	local start, duration, enable = 0, 0, 0
	local FeignSpellKnown = nil
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local q = 0
	if (Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName)) then
		FeignSpellKnown = 1
		FeignSpellID = Zorlen_GetSpellID(FeignSpellName, 0)
		start, duration, enable = GetSpellCooldown(FeignSpellID, 0)
		if not canTrap() then
			q = 80
		end
	end
	if Zorlen_checkCooldownByName(SpellName) then
		if (mana >= (60 + q)) or (health == 0) then
			if canTrap() then
				if not Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, 1) then
					return false
				end
				if Zorlen_TrapClearTargetFlag then
					TargetLastEnemy()
					Zorlen_TrapClearTargetFlag = nil
				end
				return true
			else
				if FeignSpellKnown then
					if duration == 0 and health > 0 then
						if UnitExists("target") then
							Zorlen_TrapClearTargetFlag = 1
							ClearTarget()
						end
						if UnitExists("pettarget") then
							PetFollow()
							PetPassiveMode()
						end
						CastSpell(FeignSpellID, 0)
						return true
					end
				end
			end
		end
	end
	if Zorlen_TrapClearTargetFlag and duration > 1.5 then
		TargetLastEnemy()
		Zorlen_TrapClearTargetFlag = nil
	end
	return false
end

function castExplosiveTrap(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ExplosiveTrap
	local FeignSpellID = nil
	local start, duration, enable = 0, 0, 0
	local FeignSpellKnown = nil
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = SpellRank or Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 275, 395, 520 }
	local q = 0
	if (Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName)) then
		FeignSpellKnown = 1
		FeignSpellID = Zorlen_GetSpellID(FeignSpellName, 0)
		start, duration, enable = GetSpellCooldown(FeignSpellID, 0)
		if not canTrap() then
			q = 80
		end
	end
	if Zorlen_checkCooldownByName(SpellName) then
		for i = 3, 1, -1 do
			if (mana >= (m[i] + q)) or (health == 0) then
				if r == i then
					if canTrap() then
						if not Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, 1, nil, nil, nil, nil, nil, nil, 1) then
							return false
						end
						if Zorlen_TrapClearTargetFlag then
							TargetLastEnemy()
							Zorlen_TrapClearTargetFlag = nil
						end
						return true
					else
						if FeignSpellKnown then
							if duration == 0 and health > 0 then
								if UnitExists("target") then
									Zorlen_TrapClearTargetFlag = 1
									ClearTarget()
								end
								if UnitExists("pettarget") then
									PetFollow()
									PetPassiveMode()
								end
								CastSpell(FeignSpellID, 0)
								return true
							end
						end
					end
					break
				end
			end
		end
	end
	if Zorlen_TrapClearTargetFlag and duration > 1.5 then
		TargetLastEnemy()
		Zorlen_TrapClearTargetFlag = nil
	end
	return false
end


--Mend Pet function
--written by Trev
--edited by BigRedBrent
--casts closest heal to damage taken when in combat
function castMend(mode)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_MendPet
	local mana = UnitMana("player")
	local pethealth = UnitHealth("pet")
	local petmaxhealth = UnitHealthMax("pet")
	local petdamage = petmaxhealth - pethealth
	local q = 0
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	if Zorlen_Button[FeignSpellName..".Any"] or Zorlen_IsSpellKnown(FeignSpellName) then
		q = 80
	end
	local m = { 50, 90, 155, 225, 300, 385, 480 }; --table of mana costs for each rank of mend
	local d = { 0, 146, 266, 428, 613, 828, 1086 }; --table of pet damage values that are closest to a given rank of mend
	if mode == "under" or pethealth / petmaxhealth > 0.95 or canTrap() then
		d = { 0, 190, 340, 515, 710, 945, 1225 }; --out of combat pet damage values, minimizes overhealing, will "underheal" pet by one rank
	elseif mode == "over" then
		d = { 0, 100, 190, 340, 515, 710, 945 }; --table of pet damage values that will "overheal" pet by one rank
	elseif mode == "maximum" then
		d = { 0, 0, 0, 0, 0, 0, 0 }; --pet damage values set to 0 to ensure highest level of mend used in combat
	end
	if pethealth / petmaxhealth <= 0.95 or (UnitDebuff("pet", 1) and Zorlen_HasTalent(LOCALIZATION_ZORLEN_ImprovedMendPet)) then
		for i = 7, 1, -1 do
			if ( (petdamage) >= d[i] ) then
				if( mana >= (m[i] + q) ) then
					if Zorlen_IsSpellKnown(SpellName, i) then
						local CurrentChannelingSpellRank = Zorlen_ChannelingSpellRank;
						if not CurrentChannelingSpellRank then
							CurrentChannelingSpellRank = 0;
						end
						if not Zorlen_isChanneling(SpellName) or ((i - CurrentChannelingSpellRank) > 1) then
							if Zorlen_checkCooldownByName(LOCALIZATION_ZORLEN_MendPet) then
								CastSpellByName(""..SpellName.."("..LOCALIZATION_ZORLEN_Rank.." "..i..")");
								Zorlen_debug("Casting: "..LOCALIZATION_ZORLEN_MendPet.."("..LOCALIZATION_ZORLEN_Rank.." "..i..") on "..UnitName("pet"))
								return true;
							end
						end
						return false;
					end
				end
			end		
		end
	end
	return false;
end

function castMaxMend()
	return castMend("maximum")
end

function castOverMend()
	return castMend("over")
end

function castUnderMend()
	return castMend("under")
end

--written by BigRedBrent
function castCallAndDismissPet()
	if UnitHealth("pet") > 0 then
		if Zorlen_isMoving() then
			return false
		end
		CastSpellByName(LOCALIZATION_ZORLEN_DismissPet)
	elseif Zorlen_PetIsDead then
		if Zorlen_isMoving() then
			return false
		end
		CastSpellByName(LOCALIZATION_ZORLEN_RevivePet)
	else
		CastSpellByName(LOCALIZATION_ZORLEN_CallPet)
	end
end
