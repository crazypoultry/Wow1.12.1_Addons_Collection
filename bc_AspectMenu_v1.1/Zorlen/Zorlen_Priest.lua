
Zorlen_Priest_FileBuildNumber = 678

--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  4.17
		castPsychicScream() added by Bam
  
  4.12
		castFlashHeal() added by Bam
		castUnderFlashHeal() added by Bam
		castOverFlashHeal() added by Bam
		castMaxFlashHeal() added by Bam
  
  4.01
		castShadowguard() added by Rackartussen
  
  3.98
		Reduced lag group casting functions would cause if there is not enough mana to cast the spell
  
   3.90.01
		Fixed some broken spells
  
   3.77.00
		Updated: castGroupPriestHeal() Will now try to skip out of range group members
		Updated: castGroupPowerWordFortitude() Will now try to skip out of range group members
		Updated: castGroupDispelMagic() Will now try to skip out of range group members
  
   3.74.00
		Fixed: castPowerWordShield() and castSelfPowerWordShield()
		castGroupDispelMagic() added by BigRedBrent
		castGroupPowerWordFortitude() added by BigRedBrent
		castGroupPriestHeal() added by BigRedBrent
		castUnderGroupPriestHeal() added by BigRedBrent
		castOverGroupPriestHeal() added by BigRedBrent
		castMaxGroupPriestHeal() added by BigRedBrent
  
   3.70.00
		castSmite() added by Guylien
		isVampiricEmbrace() added by Melancholia
		castVampiricEmbrace() added by Melancholia
		castPowerWordShield() added by Melancholia
		castSelfPowerWordShield() added by Melancholia
		isPowerWordShieldActive() added by Melancholia
		isPowerWordShield() added by Melancholia
		isWeakenedSoul() added by BigRedBrent
  
   3.66.00
		castPriestHeal() added by Jiral         (this set will cast Lesser, Heal, or Greater based on damage)
		castUnderPriestHeal() added by Jiral
		castOverPriestHeal() added by Jiral
		castMaxPriestHeal() added by Jiral
		castLesserHeal() added by Jiral
		castUnderLesserHeal() added by Jiral
		castOverLesserHeal() added by Jiral
		castMaxLesserHeal() added by Jiral
		castHeal() added by Jiral
		castUnderHeal() added by Jiral
		castOverHeal() added by Jiral
		castMaxHeal() added by Jiral
		castGreaterHeal() added by Jiral
		castUnderGreaterHeal() added by Jiral
		castOverGreaterHeal() added by Jiral
		castMaxGreaterHeal() added by Jiral
  
   3.58.00
		Updated the priest functions to be able to use the action bar button slot information
  
   3.57.00
		Fixed: castTouchOfWeakness()
  
   3.56.00
		isHolyFire()	Added by Devla
		isMindControl()	Added by Devla
		isMindFlay()	Added by Devla
		isShackle()	Added by Devla
		isTouchOfWeakness()	Added by Devla
		isHexOfWeakness()	Added by Devla
		isRenew()	Added by Devla
		castRenew()	Added by Devla
		castSelfRenew()	Added by Devla
		castHolyFire()	Added by Devla
		castMindControl()	Added by Devla
		castMindFlay()	Added by Devla
		castShackle()	Added by Devla
		castTouchOfWeakness()	Added by Devla
		castHexOfWeakness()	Added by Devla
  	
  3.53.00
		isPowerWordFortitude() added by BigRedBrent
		Updated: Dispel Magic and Power Word Fortitude functions
  
  3.5.2
		isDevouringPlague() added by BigRedBrent
		isShadowWordPain() added by Despised
		isInnerFireActive() added by Despised
		isPowerWordFortitudeActive() added by Despised
		castShadowWordPain() added by Despised
		castMindBlast() added by Despised
		castDevouringPlague() added by Despised
		castInnerFire() added by Despised
		castPowerWordFortitude() added by BigRedBrent with help from Despised
		castSelfPowerWordFortitude() added by BigRedBrent with help from Despised
		castDispelMagic() added by BigRedBrent with help from Despised
		castSelfDispelMagic() added by BigRedBrent with help from Despised
		castFriendlyDispelMagic() added by BigRedBrent with help from Despised

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]


function Zorlen_Priest_SpellTimerSet()
	local Number = 0
	local TargetName = Zorlen_CastingSpellTargetName
	local SpellName = Zorlen_CastingSpellName
	
	if SpellName == LOCALIZATION_ZORLEN_ShadowWordPain then
		Number = 18
		
	end
	
	Zorlen_SetTimer(Number, SpellName, TargetName, "InternalZorlenSpellTimers", nil, nil, 1)
end



--Returns true if target has Renew on
function isRenew(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Spell_Holy_Renew", u, castable)
end

--Made By Despised
--Returns true if Shadow Word Pain is on target
function isShadowWordPain(unit, dispelable)
	return Zorlen_checkDebuff("Shadow_ShadowWordPain", unit, dispelable)
end

--Added by Devla
function isHolyFire(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Holy_SearingLight", unit, dispelable)
end

--Added by Devla
function isMindControl(unit, dispelable)
	return Zorlen_checkDebuff("Shadow_ShadowWordDominate", unit, dispelable)
end

--Added by Devla
function isMindFlay(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_SiphonMana", unit, dispelable)
end

--Added by Devla
function isShackle(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Nature_Slow", unit, dispelable)
end

--Added by Devla
function isTouchOfWeakness(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_DeadofNight", unit, dispelable)
end

--Added by Devla
function isHexOfWeakness(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_FingerOfDeath", unit, dispelable)
end

--Made By Despised
--Returns true if player has Inner Fire on
function isInnerFireActive()
	return Zorlen_checkBuff("Holy_InnerFire")
end

--Made By Despised
--Returns true if player has Power Word: Fortitude on
function isPowerWordFortitudeActive()
	return Zorlen_checkBuff("Holy_WordFortitude")
end

--Returns true if target has Power Word: Fortitude on
function isPowerWordFortitude(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Holy_WordFortitude", u, castable)
end

--Returns true if Devouring Plague is on target
function isDevouringPlague(unit, dispelable)
	local SpellName = LOCALIZATION_ZORLEN_DevouringPlague
	return Zorlen_checkDebuffByName(SpellName, unit, dispelable)
end




function castPsychicScream(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_PsychicScream
	local EnemyTargetNotNeeded = 1
	local NoRangeCheck = 1
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, NoRangeCheck)
end

--Made By Despised
--Casts Shadow Word Pain on Target if its not active already
function castShadowWordPain(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_ShadowWordPain
	local DebuffName = SpellName
	local DebuffTimer = 1
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, DebuffTimer)
end

--Added By Devla
--Casts Holy Fire on Target if its not active already
function castHolyFire(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_HolyFire
	local DebuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName)
end

--Added By Devla
--Casts Mind Control on Target if its not active already
function castMindControl(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_MindControl
	local DebuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName)
end

--Added By Devla
--Casts Mind Flay on Target if its not active already
function castMindFlay(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_MindFlay
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

--Added By Devla
--Casts Shackle Undead on Target if the target is not already cc'ed
function castShackle()
	if UnitCreatureType("target") ~= "Undead" then
		return false
	end
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_ShackleUndead
	local DebuffCheckIncluded = 1
	local DebuffCheck = Zorlen_isNoDamageCC()
	local StopCasting = DebuffCheck
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, nil, nil, nil, DebuffCheckIncluded, DebuffCheck, nil, nil, nil, nil, nil, nil, nil, nil, StopCasting)
end

--Added By Devla
--Casts Touch of Weakness on Target if its not active already
function castTouchOfWeakness(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_TouchOfWeakness
	local DebuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName)
end

--Added By Devla
--Casts Hex of Weakness on Target if its not active already
function castHexOfWeakness(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_HexOfWeakness
	local DebuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName)
end

--Made by Despised
--Casts Inner Fire if it is not active
function castInnerFire(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_InnerFire
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

--Added by Rackartussen
function castShadowguard(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Shadowguard
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName)
end

-- Will try to cast the spell on everyone in your party or raid if a debuff is found on them
-- ( I know this will not work as well as "Decursive", but it was easy to add with the other additions already in place, so I added it. )
function castGroupDispelMagic(pet)
	if not castFriendlyDispelMagic() then
		local SpellName = LOCALIZATION_ZORLEN_DispelMagic
		local SpellButton = Zorlen_Button[SpellName]
		local _ = nil
		local isUsable = nil
		local notEnoughMana = nil
		local duration = nil
		local isCurrent = nil
		local SpellID = nil
		if SpellButton then
			isUsable, notEnoughMana = IsUsableAction(SpellButton)
			_, duration, _ = GetActionCooldown(SpellButton)
			isCurrent = IsCurrentAction(SpellButton)
		elseif Zorlen_IsSpellKnown(SpellName) then
			SpellID = Zorlen_GetSpellID(SpellName)
		else
			return false
		end
		if not SpellButton or (( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 )) then
			if SpellButton or Zorlen_checkCooldown(SpellID) then
				local counter = 1
				local notunitarray = {}
				while counter do
					local u = Zorlen_GiveGroupUnitWithDispelableDebuff(pet, nil, nil, notunitarray)
					if u then
						if UnitIsUnit("target", u) then
							notunitarray[counter] = u
						else
							TargetUnit(u)
							if castFriendlyDispelMagic() then
								TargetLastTarget()
								return true
							end
							TargetLastTarget()
							notunitarray[counter] = u
						end
						counter = counter + 1
						if not SpellButton then
							counter = nil
						end
					else
						counter = nil
					end
				end
			end
		end
	end
	return false
end

-- Will only cast the spell on your self or a friend if there is a debuff found.
--If you have an enemy targeted it will cast on yourself if a debuff that can be dispeled is on you. If you have a friend targeted it will cast on them if they have a debuff on them that can be dispeled.
function castFriendlyDispelMagic()
	local SpellName = LOCALIZATION_ZORLEN_DispelMagic
	local SpellButton = Zorlen_Button[SpellName]
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) then
			if (( inRange == 1 ) and UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				UseAction(SpellButton)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				UseAction(SpellButton)
				TargetLastTarget();
				return true
			end
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				CastSpell(SpellID, 0)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				CastSpell(SpellID, 0)
				TargetLastTarget();
				return true
			end
		end
	end
	return false
end

-- Will only cast the spell on your self if you have debuffs on you that can be dispeled, and will not be able to cast on anything else.
function castSelfDispelMagic()
	local SpellName = LOCALIZATION_ZORLEN_DispelMagic
	local SpellButton = Zorlen_Button[SpellName]
	local exist = nil;
	if SpellButton and Zorlen_checkDebuff(nil, "player", "dispelable") then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) then
			if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
				exist = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (exist) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_checkDebuff(nil, "player", "dispelable") then
			local SpellID = Zorlen_GetSpellID(SpellName);
			if Zorlen_checkCooldown(SpellID) then
				if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
					exist = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (exist) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

-- Will cast the spell on an enemy target if one is targeted.
--If you have no target it will cast on yourself if a debuff is on you that can be dispeled. If you have a friend targeted it will cast on them if they have a debuff on them that can be dispeled.
function castDispelMagic()
	local SpellName = LOCALIZATION_ZORLEN_DispelMagic
	local SpellButton = Zorlen_Button[SpellName]
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) then
			if (( inRange == 1 ) and UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				UseAction(SpellButton)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				UseAction(SpellButton)
				TargetLastTarget();
				return true
			elseif ( inRange == 1 ) and Zorlen_TargetIsEnemy() then
				UseAction(SpellButton)
				return true
			end
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				CastSpell(SpellID, 0)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				CastSpell(SpellID, 0)
				TargetLastTarget();
				return true
			elseif Zorlen_TargetIsEnemy() then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	return false
end




-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castGroupPowerWordFortitude(pet)
	if not castPowerWordFortitude() then
		local SpellName = LOCALIZATION_ZORLEN_PowerWordFortitude
		local SpellButton = Zorlen_Button[SpellName]
		local _ = nil
		local isUsable = nil
		local notEnoughMana = nil
		local duration = nil
		local isCurrent = nil
		local SpellID = nil
		if SpellButton then
			isUsable, notEnoughMana = IsUsableAction(SpellButton)
			_, duration, _ = GetActionCooldown(SpellButton)
			isCurrent = IsCurrentAction(SpellButton)
		elseif Zorlen_IsSpellKnown(SpellName) then
			SpellID = Zorlen_GetSpellID(SpellName)
		else
			return false
		end
		if not SpellButton or (( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 )) then
			if SpellButton or Zorlen_checkCooldown(SpellID) then
				local counter = 1
				local notunitarray = {}
				while counter do
					local u = Zorlen_GiveGroupUnitWithoutBuffBySpellName(SpellName, pet, nil, nil, notunitarray)
					if u then
						if UnitIsUnit("target", u) or UnitIsUnit("player", u) then
							notunitarray[counter] = u
						else
							TargetUnit(u)
							if castPowerWordFortitude() then
								TargetLastTarget()
								return true
							end
							TargetLastTarget()
							notunitarray[counter] = u
						end
						counter = counter + 1
						if not SpellButton then
							counter = nil
						end
					else
						counter = nil
					end
				end
			end
		end
	end
	return false
end

-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castPowerWordFortitude()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordFortitude
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and ( isCurrent ~= 1 ) and (not isPowerWordFortitude())) then
			UseAction(SpellButton)
			if SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target") and not isPowerWordFortitude()) then
				CastSpell(SpellID, 0)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif (not isPowerWordFortitudeActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfPowerWordFortitude()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordFortitude;
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (not isPowerWordFortitudeActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castRenew()
	local SpellName = LOCALIZATION_ZORLEN_Renew
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and ( isCurrent ~= 1 ) and (not isRenew())) then
			UseAction(SpellButton)
			if SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target") and not isRenew()) then
				CastSpell(SpellID, 0)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif (not isRenew("player")) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfRenew()
	local SpellName = LOCALIZATION_ZORLEN_Renew
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (not isRenew("player")) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

--Made by Despised
--Casts Devouring Plague(undead priest spell) if cooldown is up
function castDevouringPlague(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_DevouringPlague
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end


--Made By Despised
--Casts Mind Blast if cooldown is up
function castMindBlast(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_MindBlast
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end

--Made By Guylien
--Casts Smite if cooldown is up
function castSmite(SpellRank)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_Smite
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName)
end




-- Added by Melancholia
function isVampiricEmbrace(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_UnsummonBuilding", unit, dispelable)
end

-- Added by Melancholia
--Casts Vamperic Embrace on Target if its not active already
function castVampiricEmbrace(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_VampiricEmbrace
	local DebuffName = SpellName
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName)
end

--Added by Melancholia
--Returns true if player has Power Word: Shield on
function isPowerWordShieldActive()
	return Zorlen_checkBuff("Holy_PowerWordShield")
end

--Added by Melancholia
--Returns true if target has Power Word: Shield on
function isPowerWordShield(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Holy_PowerWordShield", u, castable)
end


--Added by BigRedBrent
--Debuff
function isWeakenedSoul(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Holy_AshesToAshes", unit, dispelable)
end


--Added by Melancholia
-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castPowerWordShield()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordShield
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and ( isCurrent ~= 1 ) and (not isWeakenedSoul()) and (not isPowerWordShield())) then
			UseAction(SpellButton)
			if SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isWeakenedSoul("player")) and (not isPowerWordShieldActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target") and not isWeakenedSoul() and not isPowerWordShield()) then
				CastSpell(SpellID, 0)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif (not isWeakenedSoul("player")) and (not isPowerWordShieldActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end

--Added by Melancholia
-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfPowerWordShield()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordShield;
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( isCurrent ~= 1 ) and (not isWeakenedSoul("player")) and (not isPowerWordShieldActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			elseif SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (not isWeakenedSoul("player")) and (not isPowerWordShieldActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				elseif SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			end
		end
	end
	return false
end





-- From: Jiral
function castLesserHeal(Mode, RankAdj, unit)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_LesserHeal
	local SpellButton = Zorlen_Button[SpellName]
	local LevelLearnedArray={1,4,10}
	local ManaArray={35,50,85}
	local MinHealArray={46,71,135}
	local MaxHealArray={56,85,157}
	local TimeArray={1.5,2,2.5}
	return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
end

-- From: Jiral
function castUnderLesserHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castLesserHeal("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverLesserHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castLesserHeal("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxLesserHeal(RankAdj, unit)
	return castLesserHeal("maximum", RankAdj, unit)
end

-- From: Jiral
function castHeal(Mode, RankAdj, unit)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_Heal
	local SpellButton = Zorlen_Button[SpellName]
	local LevelLearnedArray={16,22,28,34}
	local ManaArray={170,265,375,450}
	local MinHealArray={295,499,754,948}
	local MaxHealArray={341,571,856,1072}
	local TimeArray={3,3.5,4,4}
	return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
end

-- From: Jiral
function castUnderHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castHeal("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castHeal("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxHeal(RankAdj, unit)
	return castHeal("maximum", RankAdj, unit)
end

-- From: Jiral
function castGreaterHeal(Mode, RankAdj, unit)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_GreaterHeal
	local SpellButton = Zorlen_Button[SpellName]
	local LevelLearnedArray={40,46,52,58,60}
	local ManaArray={545,665,800,960,1040}
	local MinHealArray={1201,1531,1919,2396,2618}
	local MaxHealArray={1353,1717,2147,2674,2922}
	local TimeArray={4,4,4,4,4}
	return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
end

-- From: Jiral
function castUnderGreaterHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castGreaterHeal("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverGreaterHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castGreaterHeal("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxGreaterHeal(RankAdj, unit)
	return castGreaterHeal("maximum", RankAdj, unit)
end




--This will try to heal party or raid members as long as you are not targeting a party or raid member that can be healed by the spell.
--I made it give priority to your current target so that you have the option to choose priority in the heat of battle.
--If you want it to always select for you then just clear your target or target an enemy before using the function.
function castGroupPriestHeal(pet, Mode, RankAdj)
	if Zorlen_isMoving() then
		return false
	end
	local SpellName = LOCALIZATION_ZORLEN_LesserHeal
	if UnitExists("target") and castPriestHeal(Mode, RankAdj, "target") then
		return true
	elseif not Zorlen_IsSpellKnown(SpellName) or UnitMana("player") < 35 then
		return false
	else
		local u = nil
		local counter = 1
		local notunitarray = {}
		if Zorlen_isCasting(SpellName) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Heal) or Zorlen_isCasting(LOCALIZATION_ZORLEN_GreaterHeal) then
			u = Zorlen_GiveGroupUnitWithLowestHealth(pet, 0, nil, Zorlen_CastingNotUnitArray)
			if u and Zorlen_CastingUnit == u then
				return false
			elseif not u or Zorlen_CastingUnit then
				SpellStopCasting()
				return true
			end
			return false
		elseif Zorlen_checkCooldownByName(SpellName) then
			while counter do
				u = Zorlen_GiveGroupUnitWithLowestHealth(pet, nil, nil, notunitarray)
				if u then
					if UnitIsUnit("target", u) then
						notunitarray[counter] = u
					elseif UnitIsUnit("player", u) then
						return castPriestHeal(Mode, RankAdj, u)
					else
						TargetUnit(u)
						if castPriestHeal(Mode, RankAdj, u) then
							Zorlen_CastingUnit = u
							Zorlen_CastingNotUnitArray = notunitarray
							TargetLastTarget()
							return true
						end
						TargetLastTarget()
						notunitarray[counter] = u
					end
					counter = counter + 1
				else
					counter = nil
				end
				if not u and (Zorlen_isCasting(SpellName) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Heal) or Zorlen_isCasting(LOCALIZATION_ZORLEN_GreaterHeal)) then
					SpellStopCasting()
				end
			end
		end
	end
	return false
end

function castUnderGroupPriestHeal(pet, RankAdj)
	local DefaultAdj = RankAdj or -1
	return castGroupPriestHeal(pet, "under", DefaultAdj)
end

function castOverGroupPriestHeal(pet, RankAdj)
	local DefaultAdj = RankAdj or 1
	return castGroupPriestHeal(pet, "over", DefaultAdj)
end

function castMaxGroupPriestHeal(pet, RankAdj)
	return castGroupPriestHeal(pet, "maximum", RankAdj)
end

-- From: Jiral
function castPriestHeal(Mode, RankAdj, unit)
	if Zorlen_isMoving() then
		return false
	end
	local LevelLearnedArray={1,4,10,16,22,28,34,40,46,52,58,60}
	local ManaArray={35,50,85,170,265,375,450,545,665,800,960,1040}
	local MinHealArray={46,71,135,295,499,754,948,1201,1531,1919,2396,2618}
	local MaxHealArray={56,85,157,341,571,856,1072,1353,1717,2147,2674,2922}
	local TimeArray={1.5,2,2.5,3,3.5,4,4,4,4,4,4,4}
	local SpellNameArray={}
	local SpellButtonArray={}
	local SpellRankArray={}
	for i=1,3 do
		SpellNameArray[i] = LOCALIZATION_ZORLEN_LesserHeal
		SpellButtonArray[i] = Zorlen_Button[LOCALIZATION_ZORLEN_LesserHeal]
		SpellRankArray[i] = i
	end
	for i=1,4 do
		SpellNameArray[i+3] = LOCALIZATION_ZORLEN_Heal
		SpellButtonArray[i+3] = Zorlen_Button[LOCALIZATION_ZORLEN_Heal]
		SpellRankArray[i+3] = i
	end
	for i=1,5 do
		SpellNameArray[i+7] = LOCALIZATION_ZORLEN_GreaterHeal
		SpellButtonArray[i+7] = Zorlen_Button[LOCALIZATION_ZORLEN_GreaterHeal]
		SpellRankArray[i+7] = i
	end
	return Zorlen_CastMultiNamedHealingSpell(SpellNameArray, SpellRankArray, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButtonArray)
end

-- From: Jiral
function castUnderPriestHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castPriestHeal("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverPriestHeal(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castPriestHeal("over", Default, unit)
end

-- From: Jiral
function castMaxPriestHeal(RankAdj, unit)
	return castPriestHeal("maximum", RankAdj, unit)
end

-- Added by Bam
function castFlashHeal(Mode, RankAdj, unit)
  local SpellName = LOCALIZATION_ZORLEN_FlashHeal
  local SpellButton = Zorlen_Button[SpellName]
  local LevelLearnedArray={20,26,32,38,44,50,56}
  local ManaArray={125,155,185,215,265,315,380}
  local MinHealArray={196,258,327,400,518,644,812}
  local MaxHealArray={241,314,393,478,616,764,958}
  local TimeArray={1.5,1.5,1.5,1.5,1.5,1.5,1.5}
  return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
end

-- Added by Bam
function castUnderFlashHeal(RankAdj, unit)
  local DefaultAdj = RankAdj or -1
  return castFlashHeal("under", DefaultAdj, unit)
end

-- Added by Bam
function castOverFlashHeal(RankAdj, unit)
  local DefaultAdj = RankAdj or 1
  return castFlashHeal("over", DefaultAdj, unit)
end

-- Added by Bam
function castMaxFlashHeal(RankAdj, unit)
  return castFlashHeal("maximum", RankAdj, unit)
end

