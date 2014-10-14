
Zorlen_Rogue_FileBuildNumber = 680

--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  4.22
		castAmbush() added by charroux
		castKidneyShot(ComboPointsNumber) added by charroux
		castBladeFlurry() added by charroux
		castGouge() added by charroux
		castFeint(GroupOnly) added by charroux
		castBlind(RequiredPowderReserve) added by charroux
  
  4.21
		Added option to remove the debuff check with: castHemorrhage(1)
  
  4.20
		castHemorrhage() added by charroux
		isHemorrhage() added by charroux
		castGhostlyStrike() added by charroux
		Added hand option to all isPoisonActive(hand) functions -- Valid options are: "main", "off", 1, 2, and nil
  
  4.15
		Fixed: unStealth()
  
  4.12
		isAdrenalineRushActive() added by Nosrac
		isBladeFlurryActive() added by Nosrac
		isEvasionActive() added by Nosrac
		isSprintActive() added by Nosrac
		isCripplingPoisonActive() added by Nosrac
		isDeadlyPoisonActive() added by Nosrac
		isInstantPoisonActive() added by Nosrac
		isMindnumbingPoisonActive() added by Nosrac
		isWoundPoisonActive() added by Nosrac
		isPoisonActive() added by BigRedBrent
  
  3.92
		castStealth() added by BigRedBrent
		unStealth() added by BigRedBrent
		castVanish() added by BigRedBrent
  
  3.78
		castFeint() added by Xek
		castEviscerate() added by Xek
		castRiposte() added by Xek
		castSliceAndDice() added by Xek
		isComboPoints(number) added by BigRedBrent

  3.70.00
		castColdBlood() added by Mainline

  3.10.00
		isSliceActive() added by Mizz
		isStealthActive() added by BigRedBrent
		isComboPointsFull() added by BigRedBrent
		Zorlen_CheapShotEnergyCost() added by BigRedBrent
		Zorlen_SinisterStrikeEnergyCost() added by Mizz
		castSinisterStrike() added by Mizz
		castBackstab() added by Mizz
		castKick() added by Mizz
		castCheapShot() added by BigRedBrent

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]


function isComboPointsFull()
	return isComboPoints(5)
end

function isComboPoints(number)
	if number then
		if GetComboPoints() >= number then
			return true
		end
	elseif GetComboPoints() > 0 then
		return true
	end
	return false
end



function isStealthActive()
	return Zorlen_checkBuff("Ability_Stealth")
end

function isSliceActive()
	return Zorlen_checkBuff("Ability_Rogue_SliceDice")
end 

--Added by Nosrac
function isAdrenalineRushActive()
	local SpellName = LOCALIZATION_ZORLEN_AdrenalineRush
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBladeFlurryActive()
	local SpellName = LOCALIZATION_ZORLEN_BladeFlurry
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isEvasionActive()
	local SpellName = LOCALIZATION_ZORLEN_Evasion
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSprintActive()
	local SpellName = LOCALIZATION_ZORLEN_Sprint
	return Zorlen_checkBuffByName(SpellName)
end

--Added by charroux
function isHemorrhage(unit)
	return Zorlen_checkDebuff("Spell_Shadow_LifeDrain", unit)
end


--Added by Nosrac
function isCripplingPoisonActive(hand)
	local SpellName = LOCALIZATION_ZORLEN_CripplingPoison
	return Zorlen_checkItemBuffByName(SpellName, hand)
end

--Added by Nosrac
function isDeadlyPoisonActive(hand)
	local SpellName = LOCALIZATION_ZORLEN_DeadlyPoison
	return Zorlen_checkItemBuffByName(SpellName, hand)
end

--Added by Nosrac
function isInstantPoisonActive(hand)
	local SpellName = LOCALIZATION_ZORLEN_InstantPoison
	return Zorlen_checkItemBuffByName(SpellName, hand)
end

--Added by Nosrac
function isMindnumbingPoisonActive(hand)
	local SpellName = LOCALIZATION_ZORLEN_MindnumbingPoison
	return Zorlen_checkItemBuffByName(SpellName, hand)
end

--Added by Nosrac
function isWoundPoisonActive(hand)
	local SpellName = LOCALIZATION_ZORLEN_WoundPoison
	return Zorlen_checkItemBuffByName(SpellName, hand)
end

--Added by BigRedBrent
function isPoisonActive(hand)
	if isCripplingPoisonActive(hand) or isDeadlyPoisonActive(hand) or isInstantPoisonActive(hand) or isMindnumbingPoisonActive(hand) or isWoundPoisonActive(hand) then
		return true
	end
	return false
end

-- Returns the energy cost the CheapShot ability will need for it to cast (even if talent points are spent on it to lower its required energy cost).
-- Will return 0 if no rank of the ability has been learned from the Rouge Trainer.
function Zorlen_CheapShotEnergyCost()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedCheapShot)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_CheapShot)) then
		return 0
	else if (t == 2) then
		return 40
	else if (t == 1) then
		return 50
	else
		return 60
	end
	end
	end
end



-- Returns the energy cost the Sinister Strike ability will need for it to cast (even if talent points are spent on it to lower its required energy cost).
-- Will return 0 if no rank of the ability has been learned from the Rouge Trainer.
function Zorlen_SinisterStrikeEnergyCost()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedSinisterStrike)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SinisterStrike)) then
		return 0
	else if (t == 2) then
		return 40
	else if (t == 1) then
		return 42
	else
		return 45
	end
	end
	end
end



function castSinisterStrike()
	local SpellName = LOCALIZATION_ZORLEN_SinisterStrike
	local ManaNeeded = Zorlen_SinisterStrikeEnergyCost()
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end



function castCheapShot()
	local SpellName = LOCALIZATION_ZORLEN_CheapShot
	local ManaNeeded = Zorlen_CheapShotEnergyCost()
	local DoBuffIncluded = 1
	local DoBuff = isStealthActive()
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, DoBuffIncluded, DoBuff)
end



function castBackstab()
	local SpellName = LOCALIZATION_ZORLEN_Backstab
	local ManaNeeded = 60
	if not Zorlen_isMainHandDagger() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end



function castKick()
	local SpellName = LOCALIZATION_ZORLEN_Kick
	local ManaNeeded = 25
	local TargetThatUsesManaNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, nil, nil, TargetThatUsesManaNeeded)
end



--Added by Mainline
function castColdBlood()
	local SpellName = LOCALIZATION_ZORLEN_ColdBlood
	local EnemyTargetNotNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded)
end




--Added by Xek
function castFeint()
	local SpellName = LOCALIZATION_ZORLEN_Feint
	local ManaNeeded = 20
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by Xek
function castEviscerate(ComboPointsNumber)
	local SpellName = LOCALIZATION_ZORLEN_Eviscerate
	local ManaNeeded = 35
	if not isComboPoints(ComboPointsNumber) or not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by Xek
function castRiposte()
	local SpellName = LOCALIZATION_ZORLEN_Riposte
	local ManaNeeded = 10
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by Xek
function castSliceAndDice()
	local SpellName = LOCALIZATION_ZORLEN_SliceAndDice
	local ManaNeeded = 25
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
--Edited by BigRedBrent
function castHemorrhage(RemoveDebuffCheck)
	local SpellName = LOCALIZATION_ZORLEN_Hemorrhage
	local ManaNeeded = 35
	local DebuffName = nil
	if not Zorlen_isMainHandEquipped() then
		return false 
	elseif not RemoveDebuffCheck then
		DebuffName = SpellName
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, DebuffName, nil, ManaNeeded)
end

--Added by charroux
function castGhostlyStrike()
	local SpellName = LOCALIZATION_ZORLEN_GhostlyStrike
	local ManaNeeded = 40
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

function castStealth()
	local SpellName = LOCALIZATION_ZORLEN_Stealth
	local EnemyTargetNotNeeded = 1
	if Zorlen_inCombat() or isStealthActive() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded)
end

function unStealth()
	return Zorlen_CancelSelfBuff("Ability_Stealth")
end

function castVanish()
	local SpellName = LOCALIZATION_ZORLEN_Vanish
	local EnemyTargetNotNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded)
end

--Added by charroux
function castAmbush()
	local SpellName = LOCALIZATION_ZORLEN_Ambush
	local ManaNeeded = 60
	if not Zorlen_isMainHandDagger() or not isStealthActive() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
function castKidneyShot(ComboPointsNumber)
	local SpellName = LOCALIZATION_ZORLEN_KidneyShot
	local ManaNeeded = 25
	if not isComboPoints(ComboPointsNumber) or not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
function castBladeFlurry()
	local SpellName = LOCALIZATION_ZORLEN_BladeFlurry
	local ManaNeeded = 25
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
function castGouge()
	local SpellName = LOCALIZATION_ZORLEN_Gouge
	local ManaNeeded = 45
	if not Zorlen_isMainHandEquipped() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
function castFeint(GroupOnly)
	local SpellName = LOCALIZATION_ZORLEN_Feint
	local ManaNeeded = 20
	if GroupOnly then
		local raid = UnitInRaid("player")
		if (not raid and GetNumPartyMembers() == 0) or (raid and GetNumRaidMembers() <= 1) then
			return false
		end
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end

--Added by charroux
function castBlind(RequiredPowderReserve)
	local SpellName = LOCALIZATION_ZORLEN_Blind
	local ManaNeeded = 30
	local RequiredPowderReserve = RequiredPowderReserve or 1
	if Zorlen_GiveContainerItemCountByItemID(5530) < RequiredPowderReserve then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded)
end
