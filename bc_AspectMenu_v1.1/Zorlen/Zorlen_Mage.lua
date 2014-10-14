
Zorlen_Mage_FileBuildNumber = 681

--[[
  Zorlen Library - Started by Marcus S. Zarra
 
  4.23
		isArcaneIntellectActive() added by Nosrac
		isFrostArmorActive() added by Nosrac
		isMageArmorActive() added by Nosrac
		isArmorActive() added by Nosrac
		castArcaneIntellect() added by Nosrac
		castSelfArcaneIntellect() added by BigRedBrent
		isArcaneIntellect() added by BigRedBrent

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]



-- Added by Nosrac
function isArcaneIntellectActive()
	local SpellName = LOCALIZATION_ZORLEN_ArcaneIntellect
	return Zorlen_checkBuffByName(SpellName)
end

function isArcaneIntellect(unit, castable)
	local SpellName = LOCALIZATION_ZORLEN_ArcaneIntellect
	local unit = unit or "target"
	return Zorlen_checkBuffByName(SpellName, unit, castable)
end

-- Added by Nosrac
function isFrostArmorActive()
	local SpellName = LOCALIZATION_ZORLEN_FrostArmor
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isMageArmorActive()
	local SpellName = LOCALIZATION_ZORLEN_MageArmor
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isArmorActive()
	if isFrostArmorActive() or isMageArmorActive() then
		return true
	end
	return false
end

-- Added by Nosrac
-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castArcaneIntellect()
	local SpellName = LOCALIZATION_ZORLEN_ArcaneIntellect
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isArcaneIntellect())) then
			UseAction(SpellButton)
			if SpellIsTargeting() then
				SpellStopTargeting()
				return false
			end
			return true
		elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isArcaneIntellectActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if SpellIsTargeting() then
				if SpellCanTargetUnit("player") then
					SpellTargetUnit("player")
				else
					SpellStopTargeting()
					return false
				end
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if Zorlen_checkCooldown(SpellID) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and not isArcaneIntellect()) then
				CastSpell(SpellID, 0)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif (not isArcaneIntellectActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if SpellIsTargeting() then
					if SpellCanTargetUnit("player") then
						SpellTargetUnit("player")
					else
						SpellStopTargeting()
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfArcaneIntellect()
	local SpellName = LOCALIZATION_ZORLEN_ArcaneIntellect
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isArcaneIntellectActive()) then
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
				friend = 1;
				TargetUnit("player");
			end
			UseAction(SpellButton)
			if (friend) then
				TargetLastTarget();
			end
			if SpellIsTargeting() then
				if SpellCanTargetUnit("player") then
					SpellTargetUnit("player")
				else
					SpellStopTargeting()
					return false
				end
			end
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName);
		if Zorlen_checkCooldown(SpellID) then
			if (not isArcaneIntellectActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
					friend = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (friend) then
					TargetLastTarget();
				end
				if SpellIsTargeting() then
					if SpellCanTargetUnit("player") then
						SpellTargetUnit("player")
					else
						SpellStopTargeting()
						return false
					end
				end
				return true
			end
		end
	end
	return false
end



