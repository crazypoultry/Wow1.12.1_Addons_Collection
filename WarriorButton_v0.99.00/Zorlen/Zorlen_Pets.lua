--[[
  Zorlen Library - Started by Marcus S. Zarra

  3.58.00
		Zorlen_PetAttack() added by BigRedBrent
		Added focus and mana checking for pet spell casting functions. (zSeduction() will only be able to detect the correct mana level when the pet is level 60)

  3.55.00
		Zorlen_AutoPetAttack() added by BigRedBrent

  3.52.00
		Added true and false returns to Zorlen_castPetSpell(name)

  3.32.01
		Fixed: needPet()

  3.30.00
		isPetDead() added by BigRedBrent
		Moved needPet() and rezPet() back from the Zorlen_Hunter.lua file.

  3.23.00
		zBloodPact() added by BigRedBrent
		zFireShield() added by BigRedBrent
		zFirebolt() added by BigRedBrent
		zPhaseShift() added by BigRedBrent
		zConsumeShadows() added by BigRedBrent
		zSacrifice() added by BigRedBrent
		zSuffering() added by BigRedBrent
		zTorment() added by BigRedBrent
		zDevourMagic() added by BigRedBrent
		zParanoia() added by BigRedBrent
		zSpellLock() added by BigRedBrent
		zTaintedBlood() added by BigRedBrent
		zLashOfPain() added by BigRedBrent
		zSeduction() added by BigRedBrent
		zSoothingKiss() added by BigRedBrent
		zLesserInvisibility() added by BigRedBrent

  3.21.00
		Moved backOff() to the Zorlen_Other.lua file.

  3.18.00
		Put back petInCombat()
		Removed Zorlen_petInCombat()

  3.9.0
		zScreech() added by Ahrlbrand
		zThunderstomp() added by Ahrlbrand
		zFuriousHowl() added by Ahrlbrand
		zShellShield() added by Ahrlbrand
		zLightningBreath() added by Ahrlbrand
		zScorpidPoison() added by Ahrlbrand

  3.5.5
		Moved some hunter funtions from the Zorlen_Pets.lua file to the Zorlen_Hunter.lua file.
  
  3.2.5  
		Added: castMend("maximum"), castMend("over"), & castMend("under") To Replace: castMaxMend(), castOverMend(), & castUnderMend()

  3.2.4
		castUnderMend() added by BigRedBrent

  3.2.2
		castCallAndDismissPet() added by BigRedBrent

  3.0.0  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		This unit will contain all Pet related functions.
		added UnitIsPet() - returns true if your target is someones pet.
--]]

function Zorlen_castPetSpell(SpellName, ManaNoRanks, ManaPercent, ManaSpellRank1, ManaSpellRank2, ManaSpellRank3, ManaSpellRank4, ManaSpellRank5, ManaSpellRank6, ManaSpellRank7, ManaSpellRank8, ManaSpellRank9)
	local m = nil
	if not (UnitHealth("pet") > 0) then
		Zorlen_debug("Your pet is not active or alive to use pet ability: "..SpellName..", unable to cast")
		return false
	end
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local slotspellname, slotspellsubtext, texture, isToken, isActive = GetPetActionInfo(i)
		if (slotspellname and slotspellname == SpellName) then
			local start, dur, enable = GetPetActionCooldown(i)
			if ManaNoRanks then
				m = ManaNoRanks
			else if ManaPercent then
				m = (ManaPercent/100)
			else if ManaSpellRank1 then
				if string.find(slotspellsubtext, " 1") then
					m = ManaSpellRank1
				else if ManaSpellRank2 then
					if string.find(slotspellsubtext, " 2") then
						m = ManaSpellRank2
					else if ManaSpellRank3 then
						if string.find(slotspellsubtext, " 3") then
							m = ManaSpellRank3
						else if ManaSpellRank4 then
							if string.find(slotspellsubtext, " 4") then
								m = ManaSpellRank4
							else if ManaSpellRank5 then
								if string.find(slotspellsubtext, " 5") then
									m = ManaSpellRank5
								else if ManaSpellRank6 then
									if string.find(slotspellsubtext, " 6") then
										m = ManaSpellRank6
									else if ManaSpellRank7 then
										if string.find(slotspellsubtext, " 7") then
											m = ManaSpellRank7
										else if ManaSpellRank8 then
											if string.find(slotspellsubtext, " 8") then
												m = ManaSpellRank8
											else if ManaSpellRank9 then
												if string.find(slotspellsubtext, " 9") then
													m = ManaSpellRank9
												end
											end
											end
										end
										end
									end
									end
								end
								end
							end
							end
						end
						end
					end
					end
				end
				end
			end
			end
			end
			if m then
				if ManaPercent then
					if UnitMana("pet") / UnitManaMax("pet") < m then
						Zorlen_debug("Your pet does not have enouph mana for pet ability: "..SpellName..", unable to cast")
						return false
					end
				else if UnitMana("pet") < m then
					Zorlen_debug("Your pet does not have enouph mana for pet ability: "..SpellName..", unable to cast")
					return false
				end
				end
			end
			if (dur > 0) then
				Zorlen_debug("Cooldown is enabled for pet ability: "..SpellName..", unable to cast")
				return false
			end
			if isActive then
				Zorlen_debug("The pet ability "..SpellName.." is active, unable to cast")
				return false
			end
			CastPetAction(i)
			return true
		end
	end
	Zorlen_debug("Unable to locate pet ability: " .. SpellName)
	return false
end

function petInCombat()
	if Zorlen_PetCombat then
		return true
	end
	return false
end

--Written by Wynn, returns true if your target is someones pet.
function UnitIsPet(unit)
	local u = "target"
	if unit then
		u = unit
	end
	if UnitPlayerControlled(u) then
		if UnitIsPlayer(u) then
			return false
		end
		return true
	end
	return false
end

function isPetDead()
	if UnitHealth("pet") > 0 then
		return false
	else if not Zorlen_isCurrentClassHunter then
		return true
	else if Zorlen_PetIsDead then
		return true
	end
	end
	end
	return false
end

--calls pet if it is unavailable, returns false otherwise
--function to rez dead pet, or return false if it is alive
--written by Trev, redone by BigRedBrent
function needPet()
	if UnitHealth("pet") > 0 then
		return false
	else if not Zorlen_isCurrentClassHunter then
		return true
	else if Zorlen_PetIsDead then
		CastSpellByName(LOCALIZATION_ZORLEN_RevivePet)
	else
		CastSpellByName(LOCALIZATION_ZORLEN_CallPet)
	end
	end
	end
	return true
end

--written by Trev,  replaced by BigRedBrent
function rezPet()
	return needPet()
end


function Zorlen_AutoPetAttack()
	if not UnitExists("pettarget") and Zorlen_TargetIsActiveEnemy() then
		PetAttack()
		return true
	else if Zorlen_isBreakOnDamageCC("pettarget") then
		PetFollow()
	end
	end
	return false
end

function Zorlen_PetAttack()
	if not UnitExists("pettarget") and Zorlen_TargetIsEnemy() and not Zorlen_isBreakOnDamageCC() then
		PetAttack()
		return true
	else if Zorlen_isBreakOnDamageCC("pettarget") then
		PetFollow()
	end
	end
	return false
end



-- Hunter Pet Spells

function zDash()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Dash, 20)
end

function zDive()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Dive, 20)
end

function zBite()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Bite, 35)
end

function zClaw()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Claw, 25)
end

function zCower()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Cower, 15)
end

function zGrowl()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Growl, 15)
end

function zProwl()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Prowl, 40)
end

function zScreech()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Screech, 20)
end

function zThunderstomp()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Thunderstomp, 60)
end

function zFuriousHowl()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_FuriousHowl, 60)
end

function zShellShield()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_ShellShield, 10)
end

function zLightningBreath()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_LightningBreath, 50)
end

function zScorpidPoison()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_ScorpidPoison, 30)
end



-- Warlock Pet Spells

--Returns true if Fire Shield is active on the target
function isFireShield(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Spell_Fire_FireArmor", u, castable)
end

function zBloodPact()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_BloodPact)
end

function zFireShield()
	if not isFireShield() and UnitInParty("target") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_FireShield, nil, nil, 60, 90, 115, 140, 165)
	end
	return false
end

function zFirebolt()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Firebolt, nil, nil, 10, 20, 35, 50, 70, 95, 115)
end

function zPhaseShift()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_PhaseShift)
end

function zConsumeShadows()
	if not Zorlen_checkBuff("Spell_Shadow_AntiShadow", "pet") and not (UnitHealth("pet") == UnitHealthMax("pet")) then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_ConsumeShadows, nil, nil, 85, 150, 215, 285, 380, 480)
	end
	return false
end

function zSacrifice()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Sacrifice)
end

function zSuffering()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Suffering, nil, nil, 150, 300, 450, 600)
end

function zTorment()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Torment, nil, nil, 20, 40, 65, 90, 115, 145)
end

function zDevourMagic()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_DevourMagic, nil, nil, 100, 130, 170, 215)
end

function zParanoia()
	if not Zorlen_checkBuff("Spell_Shadow_AuraOfDarkness", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Paranoia)
	end
	return false
end

function zSpellLock()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_SpellLock, nil, nil, 120, 200)
end

function zTaintedBlood()
	if not Zorlen_checkBuff("Spell_Shadow_LifeDrain", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_TaintedBlood, nil, nil, 75, 105, 135, 170)
	end
	return false
end

function zLashOfPain()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_LashOfPain, nil, nil, 65, 80, 105, 125, 145, 160)
end

function zSeduction()
	local l = UnitLevel("pet")
	local Mana = nil
	if l then
		if l == 70 then
			Mana = nil
		else if l == 69 then
			Mana = nil
		else if l == 68 then
			Mana = nil
		else if l == 67 then
			Mana = nil
		else if l == 66 then
			Mana = nil
		else if l == 65 then
			Mana = nil
		else if l == 64 then
			Mana = nil
		else if l == 63 then
			Mana = nil
		else if l == 62 then
			Mana = nil
		else if l == 61 then
			Mana = nil
		else if l == 60 then
			Mana = 362
		else if l == 59 then
			Mana = nil
		else if l == 58 then
			Mana = nil
		else if l == 57 then
			Mana = nil
		else if l == 56 then
			Mana = nil
		else if l == 55 then
			Mana = nil
		else if l == 54 then
			Mana = nil
		else if l == 53 then
			Mana = nil
		else if l == 52 then
			Mana = nil
		else if l == 51 then
			Mana = nil
		else if l == 50 then
			Mana = nil
		else if l == 49 then
			Mana = nil
		else if l == 48 then
			Mana = nil
		else if l == 47 then
			Mana = nil
		else if l == 46 then
			Mana = nil
		else if l == 45 then
			Mana = nil
		else if l == 44 then
			Mana = nil
		else if l == 43 then
			Mana = nil
		else if l == 42 then
			Mana = nil
		else if l == 41 then
			Mana = nil
		else if l == 40 then
			Mana = nil
		else if l == 39 then
			Mana = nil
		else if l == 38 then
			Mana = nil
		else if l == 37 then
			Mana = nil
		else if l == 36 then
			Mana = nil
		else if l == 35 then
			Mana = nil
		else if l == 34 then
			Mana = nil
		else if l == 33 then
			Mana = nil
		else if l == 32 then
			Mana = nil
		else if l == 31 then
			Mana = nil
		else if l == 30 then
			Mana = nil
		else if l == 29 then
			Mana = nil
		else if l == 28 then
			Mana = nil
		else if l == 27 then
			Mana = nil
		else if l == 26 then
			Mana = nil
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
		end
	end
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_Seduction, Mana)
end

function zSoothingKiss()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_SoothingKiss, nil, nil, 30, 50, 75, 100)
end

function zLesserInvisibility()
	if not Zorlen_checkBuff("Spell_Magic_LesserInvisibility", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN_LesserInvisibility, 100)
	end
	return false
end
