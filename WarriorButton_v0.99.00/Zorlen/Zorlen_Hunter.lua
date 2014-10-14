--[[
  Zorlen Library - Started by Marcus S. Zarra

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
	local SpellName = LOCALIZATION_ZORLEN_AimedShot
	local AimedCooldown = 0
	if not (mode == "nofeign") and not (mode == "nomultiorfeign") and Zorlen_inCombat() and SpellName and Zorlen_AimedShotRotationWindow and not UnitIsPlayer("target") then
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			start, AimedCooldown, enable = GetSpellCooldown(SpellID, 0)
		end
	end
	if not (mode == "nofeign") and not (mode == "nomultiorfeign") and Zorlen_inCombat() and Zorlen_AimedShotRotationWindow and not UnitIsPlayer("target") and (AimedCooldown > 1.5 or Zorlen_TargetIsEnemyTargetingYou()) and castFeign() then
		return true
	else if castTrueshot() then
		castAutoShot()
		return true
	else if not isAspectActive() and castHawk() then
		castAutoShot()
		return true
	else if castMark() then
		castAutoShot()
		return true
	else if not (mode == "nomulti") and not (mode == "nomultiorfeign") and castMulti() then
		return true
	else if not isQuickshotsActive() and not (isRapidActive() and isHawkActive() and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedAspectOfTheHawk) > 0) and Zorlen_AimedShotRotationWindow and castAimed() then
		return true
	else
		castAutoShot()
	end
	end
	end
	end
	end
	end
	return false
end


function castAutoShot()
	local SpellName = LOCALIZATION_ZORLEN_AutoShot
	local SpellButton = Zorlen_Button_AutoShot
	if SpellButton then
		local isAutoRepeating = IsAutoRepeatAction(SpellButton)
		if Zorlen_TargetIsEnemy() and not ( isAutoRepeating == 1 ) and not Zorlen_isCastingOrChanneling() then
			CastSpellByName(LOCALIZATION_ZORLEN_AutoShot)
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not Zorlen_AutoShoot and Zorlen_TargetIsEnemy() and not Zorlen_isCastingOrChanneling() then
			CastSpellByName(LOCALIZATION_ZORLEN_AutoShot)
			return true
		end
	end
	return false
end

function stopAutoShot()
	local SpellName = LOCALIZATION_ZORLEN_AutoShot
	local SpellButton = Zorlen_Button_AutoShot
	if SpellButton then
		local isAutoRepeating = IsAutoRepeatAction(SpellButton)
		if ( isAutoRepeating == 1 ) then
			SpellStopCasting()
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_AutoShoot then
			SpellStopCasting()
			return true
		end
	end
	return false
end


function testMSZ()
--if mana caster checkViper.  If available cast else cast arcane
--if not mana caster checkScorpid.  If available cast else cast arcane
	DEFAULT_CHAT_FRAME:AddMessage("DEPRECATED FUNCTION - this will be removed in a future release")
end

function testMong() 
	local SpellName = LOCALIZATION_ZORLEN_ArcaneShot
	--local SpellName = LOCALIZATION_ZORLEN_MongooseBite
	local SpellID = Zorlen_GetSpellID(SpellName)
	local start, duration, enable = GetSpellCooldown(SpellID, 0)
	DEFAULT_CHAT_FRAME:AddMessage("Enable is " .. enable .. " Duration is " .. duration .. " Start is " .. start)
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
	if
	not isHawkActive()
	and
	not isMonkActive()
	and
	not isCheetahActive()
	and
	not isBeastActive()
	then
		return Zorlen_checkBuff("Ability_Mount_WhiteTiger")
	end
	return false
end

--Returns true if Trueshot Aura is active
function isTrueshotActive()
	return Zorlen_checkBuff("Ability_TrueShot")
--  return Zorlen_checkBuff("JungleTiger")
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
	return Zorlen_checkDebuff("Ability_Hunter_Quickshot", unit, dispelable)
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
	if
	isSerpent(unit, dispelable)
	or
	isScorpid(unit, dispelable)
	or
	isViper(unit, dispelable)
	or
	isWyvern(unit, dispelable)
	then
		return true
	end
	return false
end

--Returns true if the hunter is currently feigned
--Written by Malnyth of Ravencrest
--edited by BigRedBrent
function isFeign()
	return Zorlen_checkBuff("FeignDeath")
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
	if not Zorlen_TargetIsDieingEnemy() then
		if UnitIsPlayer("target") then
			if Zorlen_isClass("Warrior") or Zorlen_isClass("Rogue") then
				return castScorpid()
			else      
				return castViper()
			end
		end
		return castSerpent()
	end
	return false
end

--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castSerpent()
	local SpellName = LOCALIZATION_ZORLEN_SerpentSting
	local SpellButton = Zorlen_Button_SerpentSting
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isSerpent() or isWyvern() or IsControlKeyDown()) and not Zorlen_SerpentStingSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and (not isSerpent() or isWyvern() or IsControlKeyDown()) and not Zorlen_SerpentStingSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Wynn 12/27/05 - Refactor to use existing usesMana and isViper checks
--edited by BigRedBrent
function castViper()
	local SpellName = LOCALIZATION_ZORLEN_ViperSting
	local SpellButton = Zorlen_Button_ViperSting
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isViper() or isWyvern() or IsControlKeyDown()) and usesMana() and not Zorlen_ViperStingSpellCastImmune then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and (not isViper() or isWyvern() or IsControlKeyDown()) and usesMana() and not Zorlen_ViperStingSpellCastImmune then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castScorpid()
	local SpellName = LOCALIZATION_ZORLEN_ScorpidSting
	local SpellButton = Zorlen_Button_ScorpidSting
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not (isScorpid() or isWyvern()) and not Zorlen_ScorpidStingSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and not (isScorpid() or isWyvern()) and not Zorlen_ScorpidStingSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added by Nuckin
--edited by BigRedBrent
function castMong()
	local SpellName = LOCALIZATION_ZORLEN_MongooseBite
	local SpellButton = Zorlen_Button_MongooseBite
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 30, 40, 50, 65 }
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			if q == 0 then
				UseAction(SpellButton)
				return true
			else
				for i = 4, 1, -1 do
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if (mana >= (m[i] + q )) or (health == 0) then
							UseAction(SpellButton)
							return true
						end
						break
					end
				end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			for i = 4, 1, -1 do
				if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
					if (mana >= (m[i] + q )) or (health == 0) then
						CastSpell(SpellID, 0)
						return true
					end
					break
				end
			end
		end
	end	
	end	
	return false
end

function castCounter()
	local SpellName = LOCALIZATION_ZORLEN_Counterattack
	local SpellButton = Zorlen_Button_Counterattack
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castFlare()
	local SpellName = LOCALIZATION_ZORLEN_Flare
	local SpellButton = Zorlen_Button_Flare
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
		if Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added by Nuckin
--edited by BigRedBrent
function castCon()
	local SpellName = LOCALIZATION_ZORLEN_ConcussiveShot
	local SpellButton = Zorlen_Button_ConcussiveShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isConned() and not Zorlen_ConcussiveShotSpellCastImmune then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and not isConned() and not Zorlen_ConcussiveShotSpellCastImmune then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added by Nuckin
--edited by BigRedBrent
function castRaptor()
	local SpellName = LOCALIZATION_ZORLEN_RaptorStrike
	local SpellButton = Zorlen_Button_RaptorStrike
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 15, 25, 35, 45, 55, 70, 85, 100 }
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			if q == 0 then
				UseAction(SpellButton)
				return true
			else
				for i = 8, 1, -1 do
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if (mana >= (m[i] + q )) or (health == 0) then
							UseAction(SpellButton)
							return true
						end
						break
					end
				end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			for i = 8, 1, -1 do
				if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
					if (mana >= (m[i] + q )) or (health == 0) then
						CastSpell(SpellID, 0)
						return true
					end
					break
				end
			end
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
	local SpellButton = Zorlen_Button_AspectOfTheHawk
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isHawkActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isHawkActive()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

-- Added by Wildbill
--edited by BigRedBrent
function castWild()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheWild
	local SpellButton = Zorlen_Button_AspectOfTheWild
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isWildActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isWildActive()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castBeast()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheBeast
	local SpellButton = Zorlen_Button_AspectOfTheBeast
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isBeastActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isBeastActive()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castDistract()
	local SpellName = LOCALIZATION_ZORLEN_DistractingShot
	local SpellButton = Zorlen_Button_DistractingShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castArcane()
	local SpellName = LOCALIZATION_ZORLEN_ArcaneShot
	local SpellButton = Zorlen_Button_ArcaneShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

-- Added by Wildbill
--edited by BigRedBrent
function castDisengage()
	local SpellName = LOCALIZATION_ZORLEN_Disengage
	local SpellButton = Zorlen_Button_Disengage
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castScatter()
	local SpellName = LOCALIZATION_ZORLEN_ScatterShot
	local SpellButton = Zorlen_Button_ScatterShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not Zorlen_isCrowedControlled() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and not Zorlen_isCrowedControlled() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castMulti()
	local SpellName = LOCALIZATION_ZORLEN_MultiShot
	local SpellButton = Zorlen_Button_MultiShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castAimed()
	local SpellName = LOCALIZATION_ZORLEN_AimedShot
	local SpellButton = Zorlen_Button_AimedShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--If A Hunter's Mark is not already on the target will cast highest level
--Written by Andrew Young(andrew@inmyroom.org)
--Wynn 12/27/05 - Refactor to use existing active check
--edited by BigRedBrent
function castMark()
	local SpellName = LOCALIZATION_ZORLEN_HuntersMark
	local SpellButton = Zorlen_Button_HuntersMark
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isMarked()) and not Zorlen_HuntersMarkSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and not isMarked() and not Zorlen_HuntersMarkSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--If Aspect of the Monkey is not already active, it will cast it
--Wynn 12/27/05 - Added return values to function
--edited by BigRedBrent
function castMonkey()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfTheMonkey
	local SpellButton = Zorlen_Button_AspectOfTheMonkey
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isMonkActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if (not isMonkActive()) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castFeign()
	local SpellName = LOCALIZATION_ZORLEN_FeignDeath
	local SpellButton = Zorlen_Button_FeignDeath
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isFeign()) and UnitHealth("player") > 0 then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isFeign() and UnitHealth("player") > 0 and Zorlen_checkCooldown(SpellID) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Testing function.  Will return the name of the current aspect
function Zorlen_getAspectName()
	local x = 1
	while (UnitBuff("player", x)) do
		if (string.find(UnitBuff("player", x), "Aspect")) then
			DEFAULT_CHAT_FRAME:AddMessage(UnitBuff("player", x))
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
	local SpellButton = Zorlen_Button_AspectOfTheCheetah
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isCheetahActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCheetahActive() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castPack()
	local SpellName = LOCALIZATION_ZORLEN_AspectOfThePack
	local SpellButton = Zorlen_Button_AspectOfThePack
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isPackActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isPackActive() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--If Trueshot Aura is not already active, it will cast it
function castTrueshot()
	local SpellName = LOCALIZATION_ZORLEN_TrueshotAura
	local SpellButton = Zorlen_Button_TrueshotAura
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isTrueshotActive()) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isTrueshotActive() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castBestialWrath()
	local SpellName = LOCALIZATION_ZORLEN_BestialWrath
	local SpellButton = Zorlen_Button_BestialWrath
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	end
	return false
end

function castIntimidation()
	local SpellName = LOCALIZATION_ZORLEN_Intimidation
	local SpellButton = Zorlen_Button_Intimidation
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	end
	return false
end

function castRapid()
	local SpellName = LOCALIZATION_ZORLEN_RapidFire
	local SpellButton = Zorlen_Button_RapidFire
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else if (Zorlen_IsSpellKnown(SpellName)) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	end
	return false
end

--Aded by Jayphen
--edited by BigRedBrent
function castClip()
	local SpellName = LOCALIZATION_ZORLEN_WingClip
	local SpellButton = Zorlen_Button_WingClip
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 40, 60, 80 }
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isClipped()) and not Zorlen_WingClipSpellCastImmune then
			if q == 0 then
				UseAction(SpellButton)
				return true
			else
				for i = 3, 1, -1 do
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if (mana >= (m[i] + q )) or (health == 0) then
							UseAction(SpellButton)
							return true
						end
						break
					end
				end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_TargetIsEnemy() and not isClipped() and Zorlen_checkCooldown(SpellID) and not Zorlen_WingClipSpellCastImmune then
			for i = 3, 1, -1 do
				if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
					if (mana >= (m[i] + q )) or (health == 0) then
						CastSpell(SpellID, 0)
						return true
					end
					break
				end
			end
		end
	end
	end
	return false
end




function castWyvernStingWithPetPassive()
	return castWyvernSting("passive")
end

function castWyvernSting(mode)
	local SpellName = LOCALIZATION_ZORLEN_WyvernSting
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 115, 155, 205 }
	local q = 0
	if (Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath)) and not canTrap() then
		q = 80
	end
	if Zorlen_IsSpellKnown(SpellName) and Zorlen_TargetIsEnemy() and not Zorlen_isNoDamageCC() then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			for i = 3, 1, -1 do
				if (mana >= (m[i] + q)) or (health == 0) then
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if canTrap() then
							CastSpell(SpellID, 0)
							if mode == "passive" then
								PetPassiveMode()
							end
							return true
						else
							if Zorlen_IsSpellKnown(FeignSpellName) then
								local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
								if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
									if UnitExists("pettarget") then
										PetPassiveMode()
									end
									--ClearTarget()
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
	end
	return false
end




function castFreezingTrapWithPetPassive()
	return castFreezingTrap("passive")
end

function castFreezingTrap(mode)
	local SpellName = LOCALIZATION_ZORLEN_FreezingTrap
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 50, 75, 100 }
	local q = 0
	if (Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath)) and not canTrap() then
		q = 80
	end
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			for i = 3, 1, -1 do
				if (mana >= (m[i] + q)) or (health == 0) then
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if canTrap() then
							CastSpell(SpellID, 0)
							if mode == "passive" then
								PetPassiveMode()
							end
							return true
						else
							if Zorlen_IsSpellKnown(FeignSpellName) then
								local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
								if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
									if UnitExists("pettarget") then
										PetPassiveMode()
									end
									--ClearTarget()
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
	end
	return false
end

function castImmolationTrap()
	local SpellName = LOCALIZATION_ZORLEN_ImmolationTrap
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 50, 90, 135, 190, 245 }
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			for i = 5, 1, -1 do
				if (mana >= (m[i] + q)) or (health == 0) then
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if canTrap() then
							CastSpell(SpellID, 0)
							return true
						else
							if Zorlen_IsSpellKnown(FeignSpellName) then
								local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
								if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
									if UnitExists("pettarget") then
										PetPassiveMode()
									end
									--ClearTarget()
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
	end
	return false
end

function castFrostTrap()
	local SpellName = LOCALIZATION_ZORLEN_FrostTrap
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local q = 0
	if (Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath)) and not canTrap() then
		q = 80
	end
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if (UnitMana("player") >= (60 + q)) or (UnitHealth("player") == 0) then
				if canTrap() then
					CastSpell(SpellID, 0)
					return true
				else
					if Zorlen_IsSpellKnown(FeignSpellName) then
						local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
						if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
							if UnitExists("pettarget") then
								PetPassiveMode()
							end
							--ClearTarget()
							CastSpell(FeignSpellID, 0)
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function castExplosiveTrap()
	local SpellName = LOCALIZATION_ZORLEN_ExplosiveTrap
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local r = Zorlen_GetSpellRank(SpellName)
	local mana = UnitMana("player")
	local health = UnitHealth("player")
	local m = { 275, 395, 520 }
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			for i = 3, 1, -1 do
				if (mana >= (m[i] + q)) or (health == 0) then
					if r == ""..LOCALIZATION_ZORLEN_Rank.." "..i.."" then
						if canTrap() then
							CastSpell(SpellID, 0)
							return true
						else
							if Zorlen_IsSpellKnown(FeignSpellName) then
								local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
								if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
									if UnitExists("pettarget") then
										PetPassiveMode()
									end
									--ClearTarget()
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
	end
	return false
end


--Mend Pet function
--written by Trev
--edited by BigRedBrent
--casts closest heal to damage taken when in combat
function castMend(mode)
	local SpellName = LOCALIZATION_ZORLEN_MendPet
	local mana = UnitMana("player")
	local pethealth = UnitHealth("pet")
	local petmaxhealth = UnitHealthMax("pet")
	local petdamage = petmaxhealth - pethealth
	local q = 0
	if Zorlen_Button_FeignDeath or Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_FeignDeath) then
		q = 80
	end
	local m = { 50, 90, 155, 225, 300, 385, 480 }; --table of mana costs for each rank of mend
	local d = { 0, 146, 266, 428, 613, 828, 1086 }; --table of pet damage values that are closest to a given rank of mend
	if mode == "over" then
		d = { 0, 100, 190, 340, 515, 710, 945 }; --table of pet damage values that will "overheal" pet by one rank
	else if mode == "maximum" then
		d = { 0, 0, 0, 0, 0, 0, 0 }; --pet damage values set to 0 to ensure highest level of mend used in combat
	else if ( (canTrap() and not petInCombat()) or (mode == "under") or (UnitHealthMax("pet") == UnitHealth("pet")) ) then
		d = { 0, 190, 340, 515, 710, 945, 1225 }; --out of combat pet damage values, minimizes overhealing, will "underheal" pet by one rank
	end
	end
	end
	if not (petmaxhealth == pethealth) or (UnitDebuff("pet", 1) and Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedMendPet) > 0) then
		for i = 7, 1, -1 do
			if ( (petdamage) >= d[i] ) then
				if( mana >= (m[i] + q) ) then
					if Zorlen_IsSpellRankKnown(SpellName, ""..LOCALIZATION_ZORLEN_Rank.." "..i.."") then
						local CurrentChannelingSpellRank = Zorlen_ChannelingSpellRank;
						if not CurrentChannelingSpellRank then
							CurrentChannelingSpellRank = 0;
						end
						if not Zorlen_isChanneling(SpellName) or ((i - CurrentChannelingSpellRank) > 1) then
							Zorlen_ChannelingSpellName = SpellName;
							Zorlen_ChannelingSpellRank = i;
							CastSpellByName(""..SpellName.."("..LOCALIZATION_ZORLEN_Rank.." "..i..")");
							return true;
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
		CastSpellByName(LOCALIZATION_ZORLEN_DismissPet)
	else if Zorlen_PetIsDead then
		CastSpellByName(LOCALIZATION_ZORLEN_RevivePet)
	else
		CastSpellByName(LOCALIZATION_ZORLEN_CallPet)
	end
	end
end
