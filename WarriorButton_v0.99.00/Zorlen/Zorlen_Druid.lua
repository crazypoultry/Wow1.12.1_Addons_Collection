--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  3.58.00
		Updated the druid functions to be able to use the action bar button slot information
  
  3.55.00
		castTravelForm() added by BigRedBrent
		castMoonkinForm() added by BigRedBrent
		castBearForm() added by BigRedBrent
		castDireBearForm() added by BigRedBrent
		castCatForm() added by BigRedBrent
		castAquaticForm() added by BigRedBrent
		isCasterForm() added by BigRedBrent
		isTravelForm() added by BigRedBrent
		isMoonkinForm() added by BigRedBrent
		isBearForm() added by BigRedBrent
		isDireBearForm() added by BigRedBrent
		isCatForm() added by BigRedBrent
		isAquaticForm() added by BigRedBrent
  
  3.53.00
		castThorns() added by BigRedBrent
		castSelfThorns() added by BigRedBrent
		isMarkOfTheWild() added by BigRedBrent
		isThornsActive() added by BigRedBrent
		isThorns() added by BigRedBrent
		Fixed: castMarkOfTheWild()
  
  3.17.00
		Zorlen_FormID() added by Jiral
		Zorlen_FormName() added by Jiral
  
  3.12.00
		castCasterForm() added by Jiral
  
  3.9.0
		isMarkOfTheWildActive() added by FelyzaChan
		castMarkOfTheWild() added by FelyzaChan
		castSelfMarkOfTheWild() added by FelyzaChan
  
  3.3.1
		Zorlen_RegisterDruidForm() added by BigRedBrent
		Zorlen_CheckDruidForm(form) added by BigRedBrent

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]


-- this is called when ever the main bar changes due to a shapeshift
-- Example: Zorlen_CurrentForm == "Bear Form"
-- The example above will return true if you are currently in the Bear Form.
function Zorlen_RegisterDruidForm()
	local i;
	local max = GetNumShapeshiftForms();
	for i = 1 , max do
		local _, name, isActive = GetShapeshiftFormInfo(i);
		if isActive then
			Zorlen_debug("You are now in "..name..".");
			Zorlen_CurrentForm = name;
			return;
		end
	end
	Zorlen_debug("You are now in Caster Form.");
	Zorlen_CurrentForm = "Caster Form";
end

-- Will return true if you are in the queried form.
-- Example: Zorlen_CheckDruidForm("Bear Form")
-- The example above will return true if you are currently in the Bear Form.
function Zorlen_CheckDruidForm(form)
	if form == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isCasterForm()
	if "Caster Form" == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isTravelForm()
	if LOCALIZATION_ZORLEN_TravelForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isMoonkinForm()
	if LOCALIZATION_ZORLEN_MoonkinForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isBearForm()
	if LOCALIZATION_ZORLEN_BearForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isDireBearForm()
	if LOCALIZATION_ZORLEN_DireBearForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isCatForm()
	if LOCALIZATION_ZORLEN_CatForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end

function isAquaticForm()
	if LOCALIZATION_ZORLEN_AquaticForm == Zorlen_CurrentForm then
		return true
	else
		return false
	end
end



function castCasterForm()
	local SpellName = Zorlen_CurrentForm
	if not isCasterForm() then
		local SpellID = Zorlen_GetSpellID(SpellName)
		CastSpell(SpellID, 0)
		return true
	end
	return false
end

function castTravelForm()
	local SpellName = LOCALIZATION_ZORLEN_TravelForm
	local SpellButton = Zorlen_Button_TravelForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castMoonkinForm()
	local SpellName = LOCALIZATION_ZORLEN_MoonkinForm
	local SpellButton = Zorlen_Button_MoonkinForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castBearForm()
	local SpellName = LOCALIZATION_ZORLEN_BearForm
	local SpellButton = Zorlen_Button_BearForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castDireBearForm()
	local SpellName = LOCALIZATION_ZORLEN_DireBearForm
	local SpellButton = Zorlen_Button_DireBearForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCatForm()
	local SpellName = LOCALIZATION_ZORLEN_CatForm
	local SpellButton = Zorlen_Button_CatForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castAquaticForm()
	local SpellName = LOCALIZATION_ZORLEN_AquaticForm
	local SpellButton = Zorlen_Button_AquaticForm
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if isCasterForm() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not Zorlen_CheckDruidForm(SpellName)) then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() and not Zorlen_CheckDruidForm(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end



function Zorlen_FormID()
	if Zorlen_CurrentForm and not (Zorlen_CurrentForm == "Caster Form") then
		local SpellName = Zorlen_CurrentForm
		local SpellID = Zorlen_GetSpellID(SpellName)
		return SpellID
	end
	return nil
end



function Zorlen_FormName()
	if Zorlen_CurrentForm and not (Zorlen_CurrentForm == "Caster Form") then
		local SpellName = Zorlen_CurrentForm
		return SpellName
	end
	return nil
end




--Returns true if Mark of the Wild is active
function isMarkOfTheWildActive()
	return Zorlen_checkBuff("Spell_Nature_Regeneration")
end

--Returns true if Thorns is active
function isThornsActive()
	return Zorlen_checkBuff("Spell_Nature_Thorns")
end

--Returns true if Mark of the Wild is active on the target
function isMarkOfTheWild(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Spell_Nature_Regeneration", u, castable)
end

--Returns true if Thorns is active on the target
function isThorns(unit, castable)
	local u = "target"
	if unit then
		u = unit
	end
	return Zorlen_checkBuff("Spell_Nature_Thorns", u, castable)
end




-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castMarkOfTheWild()
	local SpellName = LOCALIZATION_ZORLEN_MarkOfTheWild
	local SpellButton = Zorlen_Button_MarkOfTheWild
	local friend = nil;
	if SpellButton then
		if isCasterForm() then
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWild())) then
				UseAction(SpellButton)
				return true
			else if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWildActive()) then
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
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and not isMarkOfTheWild()) then
				CastSpell(SpellID, 0)
				return true
			else if (not isMarkOfTheWildActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
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
	end
	return false
end



-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfMarkOfTheWild()
	local SpellName = LOCALIZATION_ZORLEN_MarkOfTheWild
	local SpellButton = Zorlen_Button_MarkOfTheWild
	local friend = nil;
	if SpellButton then
		if isCasterForm() then
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWildActive()) then
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
		if isCasterForm() then
			local SpellID = Zorlen_GetSpellID(SpellName);
			if (not isMarkOfTheWildActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
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


-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castThorns()
	local SpellName = LOCALIZATION_ZORLEN_Thorns
	local SpellButton = Zorlen_Button_Thorns
	local friend = nil;
	if SpellButton then
		if isCasterForm() then
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isThorns())) then
				UseAction(SpellButton)
				return true
			else if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isThornsActive()) then
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
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if isCasterForm() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and not isThorns()) then
				CastSpell(SpellID, 0)
				return true
			else if (not isThornsActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
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
	end
	return false
end



-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfThorns()
	local SpellName = LOCALIZATION_ZORLEN_Thorns
	local SpellButton = Zorlen_Button_Thorns
	local friend = nil;
	if SpellButton then
		if isCasterForm() then
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isThornsActive()) then
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
		if isCasterForm() then
			local SpellID = Zorlen_GetSpellID(SpellName);
			if (not isThornsActive()) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target")) then
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

