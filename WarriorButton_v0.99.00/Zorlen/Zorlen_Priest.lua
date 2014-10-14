--[[
  Zorlen Library - Started by Marcus S. Zarra
  
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
	return Zorlen_checkDebuffBySpellName(SpellName, unit, dispelable)
end

--Made By Despised
--Casts Shadow Word Pain on Target if its not active already
function castShadowWordPain()
	local SpellName = LOCALIZATION_ZORLEN_ShadowWordPain
	local SpellButton = Zorlen_Button_ShadowWordPain
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isShadowWordPain()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isShadowWordPain()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Holy Fire on Target if its not active already
function castHolyFire()
	local SpellName = LOCALIZATION_ZORLEN_HolyFire
	local SpellButton = Zorlen_Button_HolyFire
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isHolyFire()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isHolyFire()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Mind Control on Target if its not active already
function castMindControl()
	local SpellName = LOCALIZATION_ZORLEN_MindControl
	local SpellButton = Zorlen_Button_MindControl
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isMindControl()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isMindControl()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Mind Flay on Target if its not active already
function castMindFlay()
	local SpellName = LOCALIZATION_ZORLEN_MindFlay
	local SpellButton = Zorlen_Button_MindFlay
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isMindFlay()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isMindFlay()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Shackle Undead on Target if the target is not already cc'ed
function castShackle()
	local SpellName = LOCALIZATION_ZORLEN_ShackleUndead
	local SpellButton = Zorlen_Button_ShackleUndead
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not Zorlen_isNoDamageCC()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not Zorlen_isNoDamageCC()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Touch of Weakness on Target if its not active already
function castTouchOfWeakness()
	local SpellName = LOCALIZATION_ZORLEN_TouchOfWeakness
	local SpellButton = Zorlen_Button_TouchOfWeakness
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isTouchOfWeakness()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isTouchOfWeakness()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Added By Devla
--Casts Hex of Weakness on Target if its not active already
function castHexOfWeakness()
	local SpellName = LOCALIZATION_ZORLEN_HexOfWeakness
	local SpellButton = Zorlen_Button_HexOfWeakness
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isHexOfWeakness()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isHexOfWeakness()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

--Made by Despised
--Casts Inner Fire if it is not active
function castInnerFire()
	local SpellName = LOCALIZATION_ZORLEN_InnerFire
	local SpellButton = Zorlen_Button_InnerFire
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isInnerFireActive()) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isInnerFireActive()) then
			CastSpell(SpellID, 0)
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
	local SpellButton = Zorlen_Button_DispelMagic
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			if (( inRange == 1 ) and UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				UseAction(SpellButton)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				end
				return true
			else if UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				UseAction(SpellButton)
				TargetLastTarget();
				return true
			else if ( inRange == 1 ) and Zorlen_TargetIsEnemy() then
				UseAction(SpellButton)
				return true
			end
			end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if (UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			return true
		else if UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
			TargetUnit("player");
			CastSpell(SpellID, 0)
			TargetLastTarget();
			return true
		else if Zorlen_TargetIsEnemy() then
			CastSpell(SpellID, 0)
			return true
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
	local SpellButton = Zorlen_Button_DispelMagic
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			if (( inRange == 1 ) and UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
				UseAction(SpellButton)
				if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
					SpellTargetUnit("player");
				end
				return true
			else if UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
				TargetUnit("player");
				UseAction(SpellButton)
				TargetLastTarget();
				return true
			end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if (UnitIsFriend("player", "target") and Zorlen_checkDebuff(nil, nil, "dispelable")) or (not UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable")) then
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			return true
		else if UnitExists("target") and Zorlen_checkDebuff(nil, "player", "dispelable") then
			TargetUnit("player");
			CastSpell(SpellID, 0)
			TargetLastTarget();
			return true
		end
		end
	end
	end
	return false
end

-- Will only cast the spell on your self if you have debuffs on you that can be dispeled, and will not be able to cast on anything else.
function castSelfDispelMagic()
	local SpellName = LOCALIZATION_ZORLEN_DispelMagic
	local SpellButton = Zorlen_Button_DispelMagic
	local exist = nil;
	if SpellButton and Zorlen_checkDebuff(nil, "player", "dispelable") then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
			if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
				exist = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (exist) then
				TargetLastTarget();
			end
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if Zorlen_checkDebuff(nil, "player", "dispelable") then
			local SpellID = Zorlen_GetSpellID(SpellName);
			if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
				exist = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (exist) then
				TargetLastTarget();
			end
			return true
		end
	end
	end
	return false
end

-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castPowerWordFortitude()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordFortitude
	local SpellButton = Zorlen_Button_PowerWordFortitude
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isPowerWordFortitude())) then
			UseAction(SpellButton)
			return true
		else if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target") and not isPowerWordFortitude()) then
			CastSpell(SpellID, 0)
			return true
		else if (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
				friend = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
		end
	end
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfPowerWordFortitude()
	local SpellName = LOCALIZATION_ZORLEN_PowerWordFortitude;
	local SpellButton = Zorlen_Button_PowerWordFortitude
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if (not isPowerWordFortitudeActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
				friend = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
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
	local SpellButton = Zorlen_Button_Renew
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isRenew())) then
			UseAction(SpellButton)
			return true
		else if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target") and not isRenew()) then
			CastSpell(SpellID, 0)
			return true
		else if (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
				friend = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
		end
	end
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfRenew()
	local SpellName = LOCALIZATION_ZORLEN_Renew
	local SpellButton = Zorlen_Button_Renew
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if (not isRenew("player")) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player", "target")) then
				friend = 1;
				TargetUnit("player");
			end
			CastSpell(SpellID, 0)
			if (SpellIsTargeting() and SpellCanTargetUnit("player")) then
				SpellTargetUnit("player");
			end
			if (friend) then
				TargetLastTarget();
			end
			return true
		end
	end
	end
	return false
end

--Made by Despised
--Casts Devouring Plague(undead priest spell) if cooldown is up
function castDevouringPlague()
	local SpellName = LOCALIZATION_ZORLEN_DevouringPlague
	local SpellButton = Zorlen_Button_DevouringPlague
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
		if (Zorlen_checkCooldown(SpellID)) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end


--Made By Despised
--Casts Mind Blast if cooldown is up
function castMindBlast()
	local SpellName = LOCALIZATION_ZORLEN_MindBlast
	local SpellButton = Zorlen_Button_MindBlast
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

