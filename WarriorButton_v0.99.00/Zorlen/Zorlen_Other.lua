--[[
  Zorlen Library - Started by Marcus S. Zarra
  
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



--Tells the pet to back off and follow you, as well as turning off attack and auto shot or shoot.
function backOff()
	PetFollow()
	PetPassiveMode()
	stopAttack()
	SpellStopCasting()
end

--Tells the pet to back off and follow you if you have the same target as your pet, as well as turning off attack and auto shot or shoot.
function backOffTarget()
	if UnitIsUnit("target","pettarget") or (UnitExists("pettarget") and not Zorlen_TargetIsActiveEnemy("pettarget")) then
		PetFollow()
		PetPassiveMode()
	end
	stopAttack()
	SpellStopCasting()
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

function castWillOfTheForsaken()
	local SpellName = LOCALIZATION_ZORLEN_WillOfTheForsaken
	if Zorlen_IsSpellKnown(SpellName) then
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if
			Zorlen_checkDebuff("Spell_Shadow_Possession", "player") --Fear
			or
			Zorlen_checkDebuff("Spell_Shadow_DeathScream", "player") --Fear: Howl of Terror
			or
			Zorlen_checkDebuff("Spell_Shadow_PsychicScream", "player") --Fear: Psychic Scream
			or
			Zorlen_checkDebuff("Spell_Nature_Sleep", "player") --Sleep
			or
			Zorlen_checkDebuff("INV_Spear_02", "player") --Sleep: Wyvern Sting
			or
			Zorlen_checkDebuff("Spell_Shadow_MindSteal", "player") --Succubus Seduction
			then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	return false
end

function castAttack()
	local SpellName = LOCALIZATION_ZORLEN_Attack
	local SpellButton = Zorlen_Button_Attack
	if SpellButton then
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and not ( isCurrent == 1 ) and not Zorlen_isCastingOrChanneling() then
			AttackTarget()
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not Zorlen_Melee and Zorlen_TargetIsEnemy() and not Zorlen_isCastingOrChanneling() then
			AttackTarget()
			return true
		end
	end
	return false
end

function stopAttack()
	local SpellName = LOCALIZATION_ZORLEN_Attack
	local SpellButton = Zorlen_Button_Attack
	if SpellButton then
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isCurrent == 1 ) then
			AttackTarget()
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_Melee then
			AttackTarget()
			return true
		end
	end
	return false
end

function castShoot()
	local SpellName = LOCALIZATION_ZORLEN_Shoot
	local SpellButton = Zorlen_Button_Shoot
	if SpellButton then
		local isAutoRepeating = IsAutoRepeatAction(SpellButton)
		if Zorlen_TargetIsEnemy() and not ( isAutoRepeating == 1 ) then
			CastSpellByName(LOCALIZATION_ZORLEN_Shoot)
			return true
		end
	else
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not Zorlen_AutoShoot and Zorlen_TargetIsEnemy() then
			CastSpellByName(LOCALIZATION_ZORLEN_Shoot)
			return true
		end
	end
	return false
end

function stopShoot()
	local SpellName = LOCALIZATION_ZORLEN_Shoot
	local SpellButton = Zorlen_Button_Shoot
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
