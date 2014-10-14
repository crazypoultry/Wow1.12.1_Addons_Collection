
Zorlen_Other_FileBuildNumber = 678

--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  4.19
		isSelfPoisoned() added by BigRedBrent
		isSelfDiseased() added by BigRedBrent
		castStoneform() added by BigRedBrent
  
  4.12
		isAttackActive() added by BigRedBrent
		isShootActive() added by BigRedBrent
  
  3.78
		Moved Zorlen_Eat() and Zorlen_Drink() to Zorlen.lua file
  
  3.76.00
		isEatingActive() added by BigRedBrent
		isDrinkingActive() added by BigRedBrent
  
  3.70.00
		Zorlen_isTrackingTexture(texture) added by BigRedBrent
		isTrackingActive() added by BigRedBrent
		isTrackHumanoidsActive() added by BigRedBrent
		isTrackMineralsActive() added by BigRedBrent
		isTrackBeastsActive() added by BigRedBrent
		isTrackDemonsActive() added by BigRedBrent
		isTrackDragonsActive() added by BigRedBrent
		isTrackElementalsActive() added by BigRedBrent
		isTrackGiantsActive() added by BigRedBrent
		isTrackHiddenActive() added by BigRedBrent
		isTrackUndeadActive() added by BigRedBrent
		isTrackHerbsActive() added by BigRedBrent
  
  3.63.00
		Zorlen_TargetEnemyTotem() added by BigRedBrent
  
  3.57.00
		Updated: castAttack()
		Updated: stopAttack()
		Updated: castShoot()
		Updated: stopShoot()
  
  3.52.00
		castShadowmeld() added by BigRedBrent
		castWillOfTheForsaken() added by BigRedBrent
  
  3.21.00
		Moved backOff() to the Zorlen_Other.lua file from the Zorlen_Pets.lua file.
		Removed: Zorlen_backOff()
		backOffTarget() added by BigRedBrent
  
  3.10.00
		stopShoot() added by BigRedBrent
  
  3.9.9c
		castAttack() added by BigRedBrent
		stopAttack() added by BigRedBrent
		castShoot() added by BigRedBrent
  
  3.5.5
		Moved isMeld() to the Zorlen_Other.lua file.

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]



function isSelfPoisoned()
	return Zorlen_checkSelfBuff(nil, nil, nil, "Poison")
end

function isSelfDiseased()
	return Zorlen_checkSelfBuff(nil, nil, nil, "Disease")
end





function Zorlen_isTrackingTexture(texture)
	local t = GetTrackingTexture()
	if t then
		if (string.find(t, texture)) then
			return true
		end
	end
	return false
end

function isTrackingActive()
	if GetTrackingTexture() then
		return true
	end
	return false
end

function isTrackHumanoidsActive()
	return Zorlen_isTrackingTexture("Spell_Holy_PrayerOfHealing")
end

function isTrackMineralsActive()
	return Zorlen_isTrackingTexture("Spell_Nature_Earthquake")
end

function isTrackBeastsActive()
	return Zorlen_isTrackingTexture("Ability_Tracking")
end

function isTrackDemonsActive()
	return Zorlen_isTrackingTexture("Spell_Shadow_SummonFelHunter")
end

function isTrackDragonsActive()
	return Zorlen_isTrackingTexture("INV_Misc_Head_Dragon_01")
end

function isTrackElementalsActive()
	return Zorlen_isTrackingTexture("Spell_Frost_SummonWaterElemental")
end

function isTrackGiantsActive()
	return Zorlen_isTrackingTexture("Ability_Racial_Avatar")
end

function isTrackHiddenActive()
	return Zorlen_isTrackingTexture("Ability_Stealth")
end

function isTrackUndeadActive()
	return Zorlen_isTrackingTexture("Spell_Shadow_DarkSummoning")
end

function isTrackHerbsActive()
	return Zorlen_isTrackingTexture("INV_Misc_Flower_02")
end



function isEatingActive()
	return Zorlen_checkBuff("Fork&Knife")
end

function isDrinkingActive()
	return Zorlen_checkBuff("Drink")
end



--Tells the pet to back off and follow you, as well as turning off attack and auto shot or shoot.
function backOff()
	PetFollow()
	PetPassiveMode()
	stopAttack()
	SpellStopCasting()
	SpellStopTargeting()
end

--Tells the pet to back off and follow you if you have the same target as your pet, as well as turning off attack and auto shot or shoot.
function backOffTarget()
	if UnitIsUnit("target","pettarget") or (UnitExists("pettarget") and not Zorlen_TargetIsActiveEnemy("pettarget")) then
		PetFollow()
		PetPassiveMode()
	end
	stopAttack()
	SpellStopCasting()
	SpellStopTargeting()
end


--Returns true if shadow meld is activated
--Written by Malnyth of Ravencrest
function isMeld()
	return Zorlen_checkBuff("Ambush")
end

function castShadowmeld()
	local SpellName = LOCALIZATION_ZORLEN_Shadowmeld
	local FeignSpellName = LOCALIZATION_ZORLEN_FeignDeath
	local q = 80
	if Zorlen_IsSpellKnown(SpellName) and not isMeld() then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if Zorlen_isCurrentClassHunter and Zorlen_notInCombat() then
				q = 0
			end
			if not Zorlen_isCurrentClassHunter or (UnitMana("player") >= q) or (UnitHealth("player") == 0) then
				if Zorlen_notInCombat() then
					CastSpell(SpellID, 0)
					return true
				else
					if Zorlen_isCurrentClassHunter and Zorlen_IsSpellKnown(FeignSpellName) then
						local FeignSpellID = Zorlen_GetSpellID(FeignSpellName)
						if Zorlen_checkCooldown(FeignSpellID) and not isFeign() then
							CastSpell(FeignSpellID, 0)
							if UnitExists("pettarget") then
								PetFollow()
								PetPassiveMode()
							end
							return true
						end
					end
				end
			end
		end
	end
	return false
end

function castStoneform()
	local SpellName = LOCALIZATION_ZORLEN_Stoneform
	local EnemyTargetNotNeeded = 1
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded)
end

function castWillOfTheForsaken()
	local SpellName = LOCALIZATION_ZORLEN_WillOfTheForsaken
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if
			Zorlen_checkDebuff("Spell_Shadow_Possession", "player", nil, LOCALIZATION_ZORLEN_Fear) --Fear
			or
			Zorlen_checkDebuff("Spell_Shadow_DeathScream", "player", nil, LOCALIZATION_ZORLEN_HowlOfTerror) --Fear: Howl of Terror
			or
			Zorlen_checkDebuff("Spell_Shadow_PsychicScream", "player", dispelable, LOCALIZATION_ZORLEN_PsychicScream) --Fear: Psychic Scream
			or
			Zorlen_checkDebuff("Spell_Nature_Sleep", "player") --Sleep
			or
			Zorlen_checkDebuff("INV_Spear_02", "player", nil, LOCALIZATION_ZORLEN_WyvernSting, LOCALIZATION_ZORLEN_Asleep) --Sleep: Wyvern Sting
			or
			Zorlen_checkDebuff("Spell_Shadow_MindSteal", "player", nil, LOCALIZATION_ZORLEN_Seduction) --Succubus Seduction
			then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	return false
end

function castAttack(test)
	if not Zorlen_isCastingOrChanneling() and Zorlen_isEnemy() and not isAttackActive() then
		if not test then
			AttackTarget()
		end
		return true
	end
	return false
end

function stopAttack()
	if isAttackActive() then
		AttackTarget()
		return true
	end
	return false
end

function isAttackActive()
	local SpellName = LOCALIZATION_ZORLEN_Attack
	local SpellButton = Zorlen_Button[SpellName]
	if SpellButton then
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isCurrent == 1 ) then
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_Melee then
			return true
		end
	end
	return false
end

function castShoot()
	if not Zorlen_isCastingOrChanneling() and Zorlen_isEnemy() and not isShootActive() then
		CastSpellByName(LOCALIZATION_ZORLEN_Shoot)
		return true
	end
	return false
end

function stopShoot()
	if isShootActive() then
		SpellStopCasting()
		return true
	end
	return false
end

function isShootActive()
	local SpellName = LOCALIZATION_ZORLEN_Shoot
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



function Zorlen_TargetTotem()
	local t = {
		LOCALIZATION_ZORLEN_GreaterHealingWard,
		LOCALIZATION_ZORLEN_LavaSpoutTotem,
		LOCALIZATION_ZORLEN_TremorTotem,
		LOCALIZATION_ZORLEN_EarthbindTotem,
		LOCALIZATION_ZORLEN_HealingStreamTotem,
		LOCALIZATION_ZORLEN_ManaTideTotem,
		LOCALIZATION_ZORLEN_ManaSpringTotem,
		LOCALIZATION_ZORLEN_SearingTotem,
		LOCALIZATION_ZORLEN_MagmaTotem,
		LOCALIZATION_ZORLEN_FireNovaTotem,
		LOCALIZATION_ZORLEN_GroundingTotem,
		LOCALIZATION_ZORLEN_WindfuryTotem,
		LOCALIZATION_ZORLEN_FlametongueTotem,
		LOCALIZATION_ZORLEN_StrengthOfEarthTotem,
		LOCALIZATION_ZORLEN_GraceOfAirTotem,
		LOCALIZATION_ZORLEN_StoneskinTotem,
		LOCALIZATION_ZORLEN_WindwallTotem,
		LOCALIZATION_ZORLEN_FireResistanceTotem,
		LOCALIZATION_ZORLEN_FrostResistanceTotem,
		LOCALIZATION_ZORLEN_NatureResistanceTotem,
		LOCALIZATION_ZORLEN_PoisonCleansingTotem,
	}
	Zorlen_TargetNamesFromArray(t, 1, 1)
end
Zorlen_TargetEnemyTotem = Zorlen_TargetTotem
zTargetTotem = Zorlen_TargetTotem


