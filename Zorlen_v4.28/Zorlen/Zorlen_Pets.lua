
Zorlen_Pets_FileBuildNumber = 683

--[[
  Zorlen Library - Started by Marcus S. Zarra

  4.20
		Added OnlyIfYourTargetIsTargetingYou option to: zAutoSacrifice(PlayerHealthPercent, PetHealthPercent, OnlyIfYourTargetIsTargetingYou)

  4.17
		zCharge() added by BigRedBrent
		zChargeAutocastOn() added by BigRedBrent
		zChargeAutocastOff() added by BigRedBrent

  4.04
		zAutoSacrifice(PlayerHealthPercent, PetHealthPercent) added by BigRedBrent
		zAutoConsumeShadows(PetHealthPercent) added by BigRedBrent
		zAutoGrowl(PetHealthPercent) added by BigRedBrent
		zAutoCower(PetHealthPercent) added by BigRedBrent

  3.70.00
		Updated zProwl() to detect if in combat

  3.63.00
		zDashAutocastOn() added by BigRedBrent
		zDashAutocastOff() added by BigRedBrent
		zDiveAutocastOn() added by BigRedBrent
		zDiveAutocastOff() added by BigRedBrent
		zBiteAutocastOn() added by BigRedBrent
		zBiteAutocastOff() added by BigRedBrent
		zClawAutocastOn() added by BigRedBrent
		zClawAutocastOff() added by BigRedBrent
		zCowerAutocastOn() added by BigRedBrent
		zCowerAutocastOff() added by BigRedBrent
		zGrowlAutocastOn() added by BigRedBrent
		zGrowlAutocastOff() added by BigRedBrent
		zProwlAutocastOn() added by BigRedBrent
		zProwlAutocastOff() added by BigRedBrent
		zScreechAutocastOn() added by BigRedBrent
		zScreechAutocastOff() added by BigRedBrent
		zThunderstompAutocastOn() added by BigRedBrent
		zThunderstompAutocastOff() added by BigRedBrent
		zFuriousHowlAutocastOn() added by BigRedBrent
		zFuriousHowlAutocastOff() added by BigRedBrent
		zShellShieldAutocastOn() added by BigRedBrent
		zShellShieldAutocastOff() added by BigRedBrent
		zLightningBreathAutocastOn() added by BigRedBrent
		zLightningBreathAutocastOff() added by BigRedBrent
		zScorpidPoisonAutocastOn() added by BigRedBrent
		zScorpidPoisonAutocastOff() added by BigRedBrent
		zFireShieldAutocastOn() added by BigRedBrent
		zFireShieldAutocastOff() added by BigRedBrent
		zBloodPactAutocastOn() added by BigRedBrent
		zBloodPactAutocastOff() added by BigRedBrent
		zFireboltAutocastOn() added by BigRedBrent
		zFireboltAutocastOff() added by BigRedBrent
		zPhaseShiftAutocastOn() added by BigRedBrent
		zPhaseShiftAutocastOff() added by BigRedBrent
		zSufferingAutocastOn() added by BigRedBrent
		zSufferingAutocastOff() added by BigRedBrent
		zTormentAutocastOn() added by BigRedBrent
		zTormentAutocastOff() added by BigRedBrent
		zDevourMagicAutocastOn() added by BigRedBrent
		zDevourMagicAutocastOff() added by BigRedBrent
		zParanoiaAutocastOn() added by BigRedBrent
		zParanoiaAutocastOff() added by BigRedBrent
		zSpellLockAutocastOn() added by BigRedBrent
		zSpellLockAutocastOff() added by BigRedBrent
		zTaintedBloodAutocastOn() added by BigRedBrent
		zTaintedBloodAutocastOff() added by BigRedBrent
		zLashOfPainAutocastOn() added by BigRedBrent
		zLashOfPainAutocastOff() added by BigRedBrent
		zSeductionAutocastOn() added by BigRedBrent
		zSeductionAutocastOff() added by BigRedBrent
		zSoothingKissAutocastOn() added by BigRedBrent
		zSoothingKissAutocastOff() added by BigRedBrent
		zLesserInvisibilityAutocastOn() added by BigRedBrent
		zLesserInvisibilityAutocastOff() added by BigRedBrent

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
		Zorlen_debug("Your pet is not active or alive to use pet ability: "..SpellName)
		return false
	end
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local slotspellname, slotspellsubtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		if (slotspellname and slotspellname == SpellName) then
			local start, dur, enable = GetPetActionCooldown(i)
			if ManaNoRanks then
				m = ManaNoRanks
			elseif ManaPercent then
				m = (ManaPercent/100)
			elseif ManaSpellRank1 then
				if string.find(slotspellsubtext, " 1") then
					m = ManaSpellRank1
				elseif ManaSpellRank2 then
					if string.find(slotspellsubtext, " 2") then
						m = ManaSpellRank2
					elseif ManaSpellRank3 then
						if string.find(slotspellsubtext, " 3") then
							m = ManaSpellRank3
						elseif ManaSpellRank4 then
							if string.find(slotspellsubtext, " 4") then
								m = ManaSpellRank4
							elseif ManaSpellRank5 then
								if string.find(slotspellsubtext, " 5") then
									m = ManaSpellRank5
								elseif ManaSpellRank6 then
									if string.find(slotspellsubtext, " 6") then
										m = ManaSpellRank6
									elseif ManaSpellRank7 then
										if string.find(slotspellsubtext, " 7") then
											m = ManaSpellRank7
										elseif ManaSpellRank8 then
											if string.find(slotspellsubtext, " 8") then
												m = ManaSpellRank8
											elseif ManaSpellRank9 then
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
			if m then
				if ManaPercent then
					if UnitMana("pet") / UnitManaMax("pet") < m then
						Zorlen_debug("Your pet does not have enouph mana for pet ability: "..SpellName..", unable to cast")
						return false
					end
				elseif UnitMana("pet") < m then
					Zorlen_debug("Your pet does not have enouph mana for pet ability: "..SpellName..", unable to cast")
					return false
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



function Zorlen_TogglePetSpellAutocast(SpellName, mode)
	local m = nil
	if not (UnitHealth("pet") > 0) then
		Zorlen_debug("Your pet is not active or alive to use pet ability: "..SpellName)
		return false
	end
	for i=1, NUM_PET_ACTION_SLOTS, 1 do
		local slotspellname, slotspellsubtext, texture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(i)
		if (slotspellname and slotspellname == SpellName) then
			if (mode == "on") then
				if not autoCastEnabled then
					TogglePetAutocast(i)
					return true
				end
			elseif (mode == "off") then
				if autoCastEnabled then
					TogglePetAutocast(i)
					return true
				end
			else
				TogglePetAutocast(i)
				return true
			end
		end
	end
	Zorlen_debug("Unable to locate pet ability: "..SpellName)
	return false
end

function Zorlen_PetSpellAutocastOn(SpellName)
	return Zorlen_TogglePetSpellAutocast(SpellName, "on")
end

function Zorlen_PetSpellAutocastOff(SpellName)
	return Zorlen_TogglePetSpellAutocast(SpellName, "off")
end


function Zorlen_petInCombat()
	if Zorlen_PetCombat then
		return true
	end
	return false
end
petInCombat = Zorlen_petInCombat

--Written by Wynn, returns true if your target is someones pet.
function Zorlen_isPet(unit)
	local u = unit or "target"
	if UnitPlayerControlled(u) then
		if UnitIsPlayer(u) then
			return false
		end
		return true
	end
	return false
end
UnitIsPet = Zorlen_isPet
Zorlen_UnitIsPet = Zorlen_isPet
isPet = Zorlen_isPet

function Zorlen_isPetDead()
	if UnitHealth("pet") > 0 then
		return false
	elseif not Zorlen_isCurrentClassHunter then
		return true
	elseif Zorlen_PetIsDead then
		return true
	end
	return false
end
isPetDead = Zorlen_isPetDead

--calls pet if it is unavailable, returns false otherwise
--function to rez dead pet, or return false if it is alive
--written by Trev, redone by BigRedBrent
function needPet()
	if UnitHealth("pet") > 0 then
		return false
	elseif not Zorlen_isCurrentClassHunter then
		return true
	elseif Zorlen_PetIsDead then
		CastSpellByName(LOCALIZATION_ZORLEN.RevivePet)
	else
		CastSpellByName(LOCALIZATION_ZORLEN.CallPet)
	end
	return true
end

--written by Trev,  replaced by BigRedBrent
function rezPet()
	return needPet()
end


function Zorlen_AutoPetAttack(SwitchTargets)
	if not UnitExists("pettarget") or (SwitchTargets and not UnitIsUnit("pettarget", "target")) then
		if Zorlen_isActiveEnemy() then
			PetAttack()
			return true
		end
	end
	if not Zorlen_isActiveEnemy("pettarget") then
		PetFollow()
	end
	return false
end
zAutoPetAttack = Zorlen_AutoPetAttack

function Zorlen_PetAttack(NoTargetSwitch)
	if (not UnitExists("pettarget") or (not NoTargetSwitch and not UnitIsUnit("pettarget", "target"))) and Zorlen_isEnemy() and not Zorlen_isBreakOnDamageCC() then
		PetAttack()
		return true
	end
	if Zorlen_isBreakOnDamageCC("pettarget") then
		PetFollow()
	end
	return false
end
zPetAttack = Zorlen_PetAttack


-- Hunter Pet Spells

function zDash()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Dash, 20)
end

function zDashAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Dash)
end

function zDashAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Dash)
end



function zDive()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Dive, 20)
end

function zDiveAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Dive)
end


function zDiveAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Dive)
end


function zCharge()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Charge, 35)
end

function zChargeAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Charge)
end

function zChargeAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Charge)
end



function zBite()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Bite, 35)
end

function zBiteAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Bite)
end

function zBiteAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Bite)
end



function zClaw()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Claw, 25)
end

function zClawAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Claw)
end

function zClawAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Claw)
end



function zCower()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Cower, 15)
end


function zAutoCower(PetHealthPercent)
	local PetHP = PetHealthPercent or 33
	if UnitHealth("pet") > 0 then
		if UnitPlayerControlled("pettarget") or (UnitPlayerControlled("target") and not UnitExists("pettarget")) then
			return zCowerAutocastOff()
		elseif UnitHealth("pet") / UnitHealthMax("pet") <= PetHP / 100 and UnitIsUnit("pet", "pettargettarget") and UnitHealth("pet") < UnitHealth("player") then
			return zCowerAutocastOn()
		end
		return zCowerAutocastOff()
	end
	return false
end

function zCowerAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Cower)
end

function zCowerAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Cower)
end



function zGrowl()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Growl, 15)
end


function zAutoGrowl(PetHealthPercent)
	local PetHP = PetHealthPercent or 33
	if UnitHealth("pet") > 0 then
		if UnitPlayerControlled("pettarget") or (UnitPlayerControlled("target") and not UnitExists("pettarget")) then
			return zGrowlAutocastOff()
		elseif UnitHealth("pet") / UnitHealthMax("pet") > PetHP / 100 or UnitHealth("pet") >= UnitHealth("player") then
			return zGrowlAutocastOn()
		end
		return zGrowlAutocastOff()
	end
	return false
end

function zGrowlAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Growl)
end

function zGrowlAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Growl)
end



function zProwl()
	if Zorlen_notInCombat() then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Prowl, 40)
	end
	return false
end

function zProwlAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Prowl)
end

function zProwlAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Prowl)
end



function zScreech()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Screech, 20)
end

function zScreechAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Screech)
end

function zScreechAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Screech)
end



function zThunderstomp()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Thunderstomp, 60)
end

function zThunderstompAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Thunderstomp)
end

function zThunderstompAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Thunderstomp)
end



function zFuriousHowl()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.FuriousHowl, 60)
end

function zFuriousHowlAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.FuriousHowl)
end

function zFuriousHowlAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.FuriousHowl)
end



function zShellShield()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.ShellShield, 10)
end

function zShellShieldAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.ShellShield)
end

function zShellShieldAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.ShellShield)
end



function zLightningBreath()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.LightningBreath, 50)
end

function zLightningBreathAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.LightningBreath)
end

function zLightningBreathAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.LightningBreath)
end



function zScorpidPoison()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.ScorpidPoison, 30)
end

function zScorpidPoisonAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.ScorpidPoison)
end

function zScorpidPoisonAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.ScorpidPoison)
end



-- Warlock Pet Spells

--Returns true if Fire Shield is active on the target
function isFireShield(unit, castable)
	local u = unit or "target"
	return Zorlen_checkBuff("Spell_Fire_FireArmor", u, castable)
end

function zFireShield()
	if not Zorlen_checkBuff("Spell_Fire_FireArmor", "target") and UnitPlayerOrPetInParty("target") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.FireShield, nil, nil, 60, 90, 115, 140, 165)
	end
	return false
end

function zFireShieldAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.FireShield)
end

function zFireShieldAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.FireShield)
end



function zBloodPact()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.BloodPact)
end

function zBloodPactAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.BloodPact)
end

function zBloodPactAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.BloodPact)
end



function zFirebolt()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Firebolt, nil, nil, 10, 20, 35, 50, 70, 95, 115)
end

function zFireboltAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Firebolt)
end

function zFireboltAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Firebolt)
end



function zPhaseShift()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.PhaseShift)
end

function zPhaseShiftAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.PhaseShift)
end

function zPhaseShiftAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.PhaseShift)
end



function zConsumeShadows()
	if not Zorlen_checkBuff("Spell_Shadow_AntiShadow", "pet") and not (UnitHealth("pet") == UnitHealthMax("pet")) then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.ConsumeShadows, nil, nil, 85, 150, 215, 285, 380, 480)
	end
	return false
end

function zAutoConsumeShadows(PetHealthPercent)
	local PetHP = PetHealthPercent or 30
	if Zorlen_notInCombat() and UnitCreatureFamily("pet") == LOCALIZATION_ZORLEN.Voidwalker and UnitHealth("pet") > 0 and UnitHealth("pet") / UnitHealthMax("pet") <= PetHP / 100 and not Zorlen_checkBuff("Spell_Shadow_AntiShadow", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.ConsumeShadows, nil, nil, 85, 150, 215, 285, 380, 480)
	end
	return false
end


function zSacrifice()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Sacrifice)
end

function zAutoSacrifice(PlayerHealthPercent, PetHealthPercent, OnlyIfYourTargetIsTargetingYou)
	local PlayerHP = PlayerHealthPercent or 30
	local PetHP = PetHealthPercent or 20
	if Zorlen_inCombat() and UnitCreatureFamily("pet") == LOCALIZATION_ZORLEN.Voidwalker and UnitHealth("pet") > 0 and (UnitHealth("pet") / UnitHealthMax("pet") <= PetHP / 100 or ((not OnlyIfYourTargetIsTargetingYou or UnitIsUnit("player", "targettarget")) and UnitHealth("player") / UnitHealthMax("player") <= PlayerHP / 100)) and not Zorlen_checkDebuffByName(LOCALIZATION_ZORLEN.Banish, "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Sacrifice)
	end
	return false
end



function zSuffering()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Suffering, nil, nil, 150, 300, 450, 600)
end

function zSufferingAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Suffering)
end

function zSufferingAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Suffering)
end



function zTorment()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Torment, nil, nil, 20, 40, 65, 90, 115, 145)
end

function zTormentAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Torment)
end

function zTormentAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Torment)
end



function zDevourMagic()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.DevourMagic, nil, nil, 100, 130, 170, 215)
end

function zDevourMagicAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.DevourMagic)
end

function zDevourMagicAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.DevourMagic)
end



function zParanoia()
	if not Zorlen_checkBuff("Spell_Shadow_AuraOfDarkness", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Paranoia)
	end
	return false
end

function zParanoiaAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Paranoia)
end

function zParanoiaAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Paranoia)
end



function zSpellLock()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.SpellLock, nil, nil, 120, 200)
end

function zSpellLockAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.SpellLock)
end

function zSpellLockAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.SpellLock)
end



function zTaintedBlood()
	if not Zorlen_checkBuff("Spell_Shadow_LifeDrain", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.TaintedBlood, nil, nil, 75, 105, 135, 170)
	end
	return false
end

function zTaintedBloodAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.TaintedBlood)
end

function zTaintedBloodAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.TaintedBlood)
end



function zLashOfPain()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.LashOfPain, nil, nil, 65, 80, 105, 125, 145, 160)
end

function zLashOfPainAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.LashOfPain)
end

function zLashOfPainAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.LashOfPain)
end



function zSeduction()
	local l = UnitLevel("pet")
	local Mana = nil
	if l then
		if l == 60 then
			Mana = 362
		--[[elseif l == 70 then
			Mana = 
		elseif l == 69 then
			Mana = 
		elseif l == 68 then
			Mana = 
		elseif l == 67 then
			Mana = 
		elseif l == 66 then
			Mana = 
		elseif l == 65 then
			Mana = 
		elseif l == 64 then
			Mana = 
		elseif l == 63 then
			Mana = 
		elseif l == 62 then
			Mana = 
		elseif l == 61 then
			Mana = 
		elseif l == 59 then
			Mana = 
		elseif l == 58 then
			Mana = 
		elseif l == 57 then
			Mana = 
		elseif l == 56 then
			Mana = 
		elseif l == 55 then
			Mana = 
		elseif l == 54 then
			Mana = 
		elseif l == 53 then
			Mana = 
		elseif l == 52 then
			Mana = 
		elseif l == 51 then
			Mana = 
		elseif l == 50 then
			Mana = 
		elseif l == 49 then
			Mana = 
		elseif l == 48 then
			Mana = 
		elseif l == 47 then
			Mana = 
		elseif l == 46 then
			Mana = 
		elseif l == 45 then
			Mana = 
		elseif l == 44 then
			Mana = 
		elseif l == 43 then
			Mana = 
		elseif l == 42 then
			Mana = 
		elseif l == 41 then
			Mana = 
		elseif l == 40 then
			Mana = 
		elseif l == 39 then
			Mana = 
		elseif l == 38 then
			Mana = 
		elseif l == 37 then
			Mana = 
		elseif l == 36 then
			Mana = 
		elseif l == 35 then
			Mana = 
		elseif l == 34 then
			Mana = 
		elseif l == 33 then
			Mana = 
		elseif l == 32 then
			Mana = 
		elseif l == 31 then
			Mana = 
		elseif l == 30 then
			Mana = 
		elseif l == 29 then
			Mana = 
		elseif l == 28 then
			Mana = 
		elseif l == 27 then
			Mana = 
		elseif l == 26 then
			Mana = 
		--]]
		end
	end
	if UnitExists("pettarget") then
		if UnitCreatureType("pettarget") ~= "Humanoid" or Zorlen_isBreakOnDamageCC("pettarget") then
			return false
		end
	elseif Zorlen_isEnemy() then
		if UnitCreatureType("target") ~= "Humanoid" or Zorlen_isBreakOnDamageCC() then
			return false
		end
	else
		return false
	end
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.Seduction, Mana)
end

function zSeductionAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.Seduction)
end

function zSeductionAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.Seduction)
end



function zSoothingKiss()
	return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.SoothingKiss, nil, nil, 30, 50, 75, 100)
end

function zSoothingKissAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.SoothingKiss)
end

function zSoothingKissAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.SoothingKiss)
end



function zLesserInvisibility()
	if not Zorlen_checkBuff("Spell_Magic_LesserInvisibility", "pet") then
		return Zorlen_castPetSpell(LOCALIZATION_ZORLEN.LesserInvisibility, 100)
	end
	return false
end

function zLesserInvisibilityAutocastOn()
	return Zorlen_PetSpellAutocastOn(LOCALIZATION_ZORLEN.LesserInvisibility)
end

function zLesserInvisibilityAutocastOff()
	return Zorlen_PetSpellAutocastOff(LOCALIZATION_ZORLEN.LesserInvisibility)
end
