
Zorlen_Druid_FileBuildNumber = 678

--[[
  Zorlen Library - Started by Marcus S. Zarra
  
  4.18
		isFeralForm() added by BigRedBrent
  
  4.14.02
		Fixed: castCasterForm()
  
  3.98
		Reduced lag group casting functions would cause if there is not enough mana to cast the spell
  
  3.92
		Fixed double casting from Regrowth
		castOmenOfClarity() added by Nosrac
		isOmenOfClarityActive() added by Nosrac
  
   3.78
		castGroupRejuvenation() added by BigRedBrent
		castUnderGroupRejuvenation() added by BigRedBrent
		castOverGroupRejuvenation() added by BigRedBrent
		castMaxGroupRejuvenation() added by BigRedBrent
		castGroupRegrowth() added by BigRedBrent
		castUnderGroupRegrowth() added by BigRedBrent
		castOverGroupRegrowth() added by BigRedBrent
		castMaxGroupRegrowth() added by BigRedBrent
		castGroupSwiftmend() added by BigRedBrent
  
   3.77.00
		Updated: castGroupHealingTouch() Will now try to skip out of range group members
		Updated: castGroupMarkOfTheWild() Will now try to skip out of range group members
		Updated: castGroupThorns() Will now try to skip out of range group members
  
  3.74.00
		castGroupMarkOfTheWild() added by BigRedBrent
		castGroupThorns() added by BigRedBrent
		castGroupHealingTouch() added by BigRedBrent
		castUnderGroupHealingTouch() added by BigRedBrent
		castOverGroupHealingTouch() added by BigRedBrent
		castMaxGroupHealingTouch() added by BigRedBrent
  
  3.71.00
		castWrath() added by BigRedBrent
		Fixed a few other druid functions added in the last release
  
  3.70.01
		Updated: castHealingTouch()
  
  3.70.00
		castSwiftmend() added by BigRedBrent
		castSelfSwiftmend() added by BigRedBrent
		forceSwiftmend() added by BigRedBrent
		forceSelfSwiftmend() added by BigRedBrent
		castInnervate() added by BigRedBrent
		castSelfInnervate() added by BigRedBrent
		castBarkskin() added by Mithrael
		castNaturesGrasp() added by Mithrael
		castProwl() added by Mithrael
		castNaturesSwiftness() added by Mithrael
		castEntanglingRoots() added by Mithrael
		castInsectSwarm() added by Mithrael
		castFaerieFire() added by Mithrael
		castMoonfire() added by Mithrael
		castStarfire() added by Mithrael
		isRejuvenationActive() added by BigRedBrent
		isRegrowthActive() added by BigRedBrent
		isRejuvenation() added by BigRedBrent
		isRegrowth() added by BigRedBrent
		isBarkskinActive() added by Mithrael
		isNaturesGraspActive() added by Mithrael
		isProwlActive() added by Mithrael
		isNaturesSwiftnessActive() added by Mithrael
		isRooted() added by Mithrael
		isInsectSwarm() added by Mithrael
		isFaerieFire() added by Mithrael
		isMoonfire() added by Mithrael
  
  3.67.00
		All included spell functions that require caster form will now cast caster form if you are not in the required form
		castBearForm() will now use Dire Bear Form if that form is known
  
  3.66.00
		castHealingTouch() added by Jiral
		castUnderHealingTouch() added by Jiral
		castOverHealingTouch() added by Jiral
		castMaxHealingTouch() added by Jiral
		castRegrowth() added by Jiral
		castUnderRegrowth() added by Jiral
		castOverRegrowth() added by Jiral
		castMaxRegrowth() added by Jiral
		castRejuvenation() added by Jiral
		castUnderRejuvenation() added by Jiral
		castOverRejuvenation() added by Jiral
		castMaxRejuvenation() added by Jiral
  
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



function Zorlen_Druid_SpellTimerSet()
	local Number = 0
	local TargetName = Zorlen_CastingSpellTargetName
	local SpellName = Zorlen_CastingSpellName
	
	if SpellName == LOCALIZATION_ZORLEN_Moonfire then
		if Zorlen_CastingSpellRank == 1 then
			Number = 9
		else
			Number = 12
		end
		
	elseif SpellName == LOCALIZATION_ZORLEN_InsectSwarm then
		Number = 12
		
	end
	
	Zorlen_SetTimer(Number, SpellName, TargetName, "InternalZorlenSpellTimers", nil, nil, 1)
end




function Zorlen_Druid_OnEvent_UPDATE_BONUS_ACTIONBAR()
	Zorlen_RegisterDruidForm()
end



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
	end
	return false
end

function isCasterForm(unit)
	if not unit or unit == "player" then
		if "Caster Form" == Zorlen_CurrentForm then
			return true
		end
	elseif not isDruid(unit) or (not isTravelForm(unit) and not isMoonkinForm(unit) and not isBearForm(unit) and not isDireBearForm(unit) and not isCatForm(unit) and not isAquaticForm(unit)) then
		return true
	end
	return false
end

function isFeralForm(unit)
	if isCasterForm(unit) then
		return false
	end
	return true
end

function isTravelForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_TravelForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_TravelForm, unit)
	end
	return false
end

function isMoonkinForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_MoonkinForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_MoonkinForm, unit)
	end
	return false
end

function isBearForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_BearForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_BearForm, unit)
	end
	return false
end

function isDireBearForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_DireBearForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_DireBearForm, unit)
	end
	return false
end

function isCatForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_CatForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_CatForm, unit)
	end
	return false
end

function isAquaticForm(unit)
	if not unit or unit == "player" then
		if LOCALIZATION_ZORLEN_AquaticForm == Zorlen_CurrentForm then
			return true
		end
	else
		return Zorlen_checkBuffByName(LOCALIZATION_ZORLEN_AquaticForm, unit)
	end
	return false
end



function castCasterForm()
	local SpellName = Zorlen_CurrentForm
	if isCasterForm() then
		return false
	end
	CastSpellByName(SpellName)
	return true
end

function castTravelForm()
	local SpellName = LOCALIZATION_ZORLEN_TravelForm
	local EnemyTargetNotNeeded = 1
	local SpellCheckNotNeeded = 1
	if Zorlen_CheckDruidForm(SpellName) then
		return false
	elseif not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

function castMoonkinForm()
	local SpellName = LOCALIZATION_ZORLEN_MoonkinForm
	local EnemyTargetNotNeeded = 1
	local SpellCheckNotNeeded = 1
	if Zorlen_CheckDruidForm(SpellName) then
		return false
	elseif not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

function castBearForm()
	local SpellName = LOCALIZATION_ZORLEN_BearForm
	local EnemyTargetNotNeeded = 1
	local SpellCheckNotNeeded = 1
	local spellknown = Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DireBearForm)
	if spellknown then
		SpellName = LOCALIZATION_ZORLEN_DireBearForm
	end
	if Zorlen_CheckDruidForm(SpellName) then
		return false
	elseif not spellknown and not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

function castDireBearForm()
	return castBearForm()
end

function castCatForm()
	local SpellName = LOCALIZATION_ZORLEN_CatForm
	local EnemyTargetNotNeeded = 1
	local SpellCheckNotNeeded = 1
	if Zorlen_CheckDruidForm(SpellName) then
		return false
	elseif not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

function castAquaticForm()
	local SpellName = LOCALIZATION_ZORLEN_AquaticForm
	local EnemyTargetNotNeeded = 1
	local SpellCheckNotNeeded = 1
	if Zorlen_CheckDruidForm(SpellName) then
		return false
	elseif not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
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


-- Added by: Nosrac
function isOmenOfClarityActive()
	return Zorlen_checkBuff("Spell_Nature_CrystalBall")
end

--Returns true if Mark of the Wild is active
function isMarkOfTheWildActive()
	return Zorlen_checkBuff("Spell_Nature_Regeneration")
end

--Returns true if Thorns is active
function isThornsActive()
	return Zorlen_checkBuff("Spell_Nature_Thorns")
end

--Returns true if Thorns is active
function isRejuvenationActive()
	return Zorlen_checkBuff("Spell_Nature_Rejuvenation")
end

--Returns true if Thorns is active
function isRegrowthActive()
	return Zorlen_checkBuff("Spell_Nature_ResistNature")
end

--Returns true if Mark of the Wild is active on the target
function isMarkOfTheWild(unit, castable)
	local u = unit or "target"
	return Zorlen_checkBuff("Spell_Nature_Regeneration", u, castable)
end

--Returns true if Thorns is active on the target
function isThorns(unit, castable)
	local u = unit or "target"
	return Zorlen_checkBuff("Spell_Nature_Thorns", u, castable)
end

--Returns true if Thorns is active on the target
function isRejuvenation(unit, castable)
	local u = unit or "target"
	return Zorlen_checkBuff("Spell_Nature_Rejuvenation", u, castable)
end

--Returns true if Thorns is active on the target
function isRegrowth(unit, castable)
	local u = unit or "target"
	return Zorlen_checkBuff("Spell_Nature_ResistNature", u, castable)
end



-- Added by: Nosrac
-- Edited by: BigRedBrent
function castOmenOfClarity()
	local SpellName = LOCALIZATION_ZORLEN_OmenOfClarity
	local ManaNeeded = 120
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(nil, SpellName, nil, nil, ManaNeeded, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castGroupMarkOfTheWild(pet)
	if not castMarkOfTheWild() then
		local SpellName = LOCALIZATION_ZORLEN_MarkOfTheWild
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
		if not SpellButton or (( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 )) then
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
							if castMarkOfTheWild() then
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
function castMarkOfTheWild()
	local SpellName = LOCALIZATION_ZORLEN_MarkOfTheWild
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWild())) then
				UseAction(SpellButton)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWildActive()) then
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
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_checkCooldown(SpellID) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and not isMarkOfTheWild()) then
					CastSpell(SpellID, 0)
					if SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif (not isMarkOfTheWildActive()) then
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
	end
	return false
end

-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfMarkOfTheWild()
	local SpellName = LOCALIZATION_ZORLEN_MarkOfTheWild
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isMarkOfTheWildActive()) then
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
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName);
			if Zorlen_checkCooldown(SpellID) then
				if (not isMarkOfTheWildActive()) then
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
	end
	return false
end



-- Will cast the spell if it is not on your target, if it is on your target or it can not be cast on your target, then it will cast on yourself if it is not on you.
function castGroupThorns(pet)
	if not castThorns() then
		local SpellName = LOCALIZATION_ZORLEN_Thorns
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
		if not SpellButton or (( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 )) then
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
							if castThorns() then
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
function castThorns()
	local SpellName = LOCALIZATION_ZORLEN_Thorns
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		if not isCasterForm() and not isMoonkinForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isThorns())) then
				UseAction(SpellButton)
				if SpellIsTargeting() then
					SpellStopTargeting()
					return false
				end
				return true
			elseif ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isThornsActive()) then
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
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() and not isMoonkinForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_checkCooldown(SpellID) then
				if (UnitIsFriend("player", "target") and not UnitIsUnit("player","target") and not isThorns()) then
					CastSpell(SpellID, 0)
					if SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif (not isThornsActive()) then
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
	end
	return false
end



-- Will only cast the spell on your self if you do not have it on you and will not be able to cast on anything else.
function castSelfThorns()
	local SpellName = LOCALIZATION_ZORLEN_Thorns
	local SpellButton = Zorlen_Button[SpellName]
	local friend = nil;
	if SpellButton then
		if not isCasterForm() and not isMoonkinForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (not isThornsActive()) then
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
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() and not isMoonkinForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName);
			if Zorlen_checkCooldown(SpellID) then
				if (not isThornsActive()) then
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
	end
	return false
end





--This will try to heal party or raid members as long as you are not targeting a unit that can be healed by the spell.
--I made it give priority to your current target so that you have the option to choose priority in the heat of battle.
--If you want it to always select for you then just clear your target or target an enemy before using the function.
function castGroupHealingTouch(pet, Mode, RankAdj)
	local SpellName = LOCALIZATION_ZORLEN_HealingTouch
	local LowestMana = 25
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TranquilSpirit)
	if t and t > 0 then
		local ManaReduction = 1 - (t * .02)
		LowestMana = (LowestMana * ManaReduction) + 1
	end
	if UnitExists("target") and castHealingTouch(Mode, RankAdj, "target") then
		return true
	elseif not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	elseif UnitMana("player") < LowestMana then
		return false
	else
		if Zorlen_isMoving() and not isNaturesSwiftnessActive() then
			return false
		end
		local u = nil
		local counter = 1
		local notunitarray = {}
		if Zorlen_isCasting(SpellName) then
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
						return castHealingTouch(Mode, RankAdj, u)
					else
						TargetUnit(u)
						if castHealingTouch(Mode, RankAdj, u) then
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
			end
			if not u and Zorlen_isCasting(SpellName) then
				SpellStopCasting()
			end
		end
	end
	return false
end

function castUnderGroupHealingTouch(pet, RankAdj)
	local DefaultAdj = RankAdj or -1
	return castGroupHealingTouch(pet, "under", DefaultAdj)
end

function castOverGroupHealingTouch(pet, RankAdj)
	local DefaultAdj = RankAdj or 1
	return castGroupHealingTouch(pet, "over", DefaultAdj)
end

function castMaxGroupHealingTouch(pet, RankAdj)
	return castGroupHealingTouch(pet, "maximum", RankAdj)
end

-- From: Jiral
-- Casts Healing Touch of a rank appropriate to the damage taken.
--   Note: WoW doesn't return actual health numbers for non-self/party/raid members (only percents), so maximum rank will be used by default
function castHealingTouch(Mode, RankAdj, unit)
	local SpellName = LOCALIZATION_ZORLEN_HealingTouch
	local SpellButton = Zorlen_Button[SpellName]
	if Zorlen_IsSpellKnown(SpellName) and not isCasterForm() then
		return castCasterForm()
	else
		if Zorlen_isMoving() and not isNaturesSwiftnessActive() then
			return false
		end
		local LevelLearnedArray={1,8,14,20,26,32,38,44,50,56,60}
		local ManaArray={25,55,110,185,270,335,405,495,600,720,800}
		local MinHealArray={40,094,195,363,572,742,0936,1199,1516,1890,2267}
		local MaxHealArray={55,119,243,445,694,894,1120,1427,1796,2230,2677}
		local TimeArray={1.5,2.0,2.5,3.0,3.5,3.5,3.5,3.5,3.5,3.5,3.5}
		if Zorlen_HasTalent(LOCALIZATION_ZORLEN_ImprovedHealingTouch) then
			local TimeReduction = (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedHealingTouch) / 10)
			for i=1,11 do
				TimeArray[i] = (TimeArray[i] - TimeReduction)
			end		
		end
		if Zorlen_HasTalent(LOCALIZATION_ZORLEN_TranquilSpirit) then
			local ManaReduction = 1 - (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_TranquilSpirit) * .02)
			for i=1,11 do
				ManaArray[i] = (ManaArray[i] * ManaReduction) + 1
			end		
		end
		if Zorlen_HasTalent(LOCALIZATION_ZORLEN_GiftofNature) then
			local HealImproved = 1 + (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_GiftofNature) * .02)
			for i=1,SpellRanks do
				MinHealArray[i] = MinHealArray[i] * HealImproved
				MaxHealArray[i] = MaxHealArray[i] * HealImproved
			end
		end
		return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, unit, SpellButton)
	end
end

-- From: Jiral
function castUnderHealingTouch(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castHealingTouch("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverHealingTouch(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castHealingTouch("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxHealingTouch(RankAdj, unit)
	return castHealingTouch("maximum", RankAdj, unit)
end





--This will try to heal party or raid members as long as you are not targeting a unit that can be healed by the spell.
--I made it give priority to your current target so that you have the option to choose priority in the heat of battle.
--If you want it to always select for you then just clear your target or target an enemy before using the function.
function castGroupRegrowth(pet, Mode, RankAdj)
	local SpellName = LOCALIZATION_ZORLEN_Regrowth
	if UnitExists("target") and castRegrowth(Mode, RankAdj, "target") then
		return true
	elseif not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	elseif UnitMana("player") < 120 then
		return false
	else
		if Zorlen_isMoving() and not isNaturesSwiftnessActive() then
			return false
		end
		local u = nil
		local counter = 1
		local notunitarray = {}
		if Zorlen_isCasting(SpellName) then
			u = Zorlen_GiveGroupUnitWithLowestHealthWithoutBuffBySpellName(SpellName, pet, 0, nil, Zorlen_CastingNotUnitArray)
			if u and Zorlen_CastingUnit == u then
				return false
			elseif not u or Zorlen_CastingUnit then
				SpellStopCasting()
				return true
			end
			return false
		elseif Zorlen_checkCooldownByName(SpellName) then
			while counter do
				u = Zorlen_GiveGroupUnitWithLowestHealthWithoutBuffBySpellName(SpellName, pet, nil, nil, notunitarray)
				if u then
					if UnitIsUnit("target", u) then
						notunitarray[counter] = u
					elseif UnitIsUnit("player", u) then
						return castRegrowth(Mode, RankAdj, u)
					else
						local unitname = UnitName(u)
						if not Zorlen_IsTimer(SpellName, unitname, "InternalZorlenSpellCastDelay") then
							TargetUnit(u)
							if castRegrowth(Mode, RankAdj, u) then
								Zorlen_CastingUnit = u
								Zorlen_CastingNotUnitArray = notunitarray
								TargetLastTarget()
								return true
							end
							TargetLastTarget()
						end
						notunitarray[counter] = u
					end
					counter = counter + 1
				else
					counter = nil
				end
			end
			if not u and Zorlen_isCasting(SpellName) then
				SpellStopCasting()
			end
		end
	end
	return false
end

function castUnderGroupRegrowth(pet, RankAdj)
	local DefaultAdj = RankAdj or -1
	return castGroupRegrowth(pet, "under", DefaultAdj)
end

function castOverGroupRegrowth(pet, RankAdj)
	local DefaultAdj = RankAdj or 1
	return castGroupRegrowth(pet, "over", DefaultAdj)
end

function castMaxGroupRegrowth(pet, RankAdj)
	return castGroupRegrowth(pet, "maximum", RankAdj)
end

-- From: Jiral
function castRegrowth(Mode, RankAdj, unit)
	local SpellName = LOCALIZATION_ZORLEN_Regrowth
	local SpellButton = Zorlen_Button[SpellName]
	if Zorlen_IsSpellKnown(SpellName) and not isCasterForm() then
		return castCasterForm()
	else
		if Zorlen_isMoving() and not isNaturesSwiftnessActive() then
			return false
		end
		local TargetID = unit or "target"
		if unit then
			if not UnitExists(unit) or UnitCanAttack("player", unit) or not UnitIsFriend(unit, "player") or not (UnitHealth(unit) > 0) or not UnitIsVisible(unit) or UnitIsDeadOrGhost(unit) then
				return false
			end
		elseif not UnitExists("target") or UnitCanAttack("player", "target") or not UnitIsFriend("target", "player") or not (UnitHealth("target") > 0) or not UnitIsVisible("target") or UnitIsDeadOrGhost("target") or UnitIsUnit("target", "player") then
			TargetID = "player"
		end
		local unitname = UnitName(TargetID)
		if not Zorlen_IsTimer(SpellName, unitname, "InternalZorlenSpellCastDelay") and not isRegrowth(TargetID) then
			local LevelLearnedArray={12,18,24,30,36,42,48,54,60}
			local ManaArray={120,205,280,350,420,510,615,740,880}
			local MinHealArray={182,339,499,661,832,1057,1332,1670,2067}
			local MaxHealArray={196,363,533,661,884,1121,1410,1766,2183}
			local TimeArray={2,2,2,2,2,2,2,2,2}
			if Zorlen_HasTalent(LOCALIZATION_ZORLEN_GiftofNature) then
				local HealImproved = 1 + (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_GiftofNature) * .02)
				for i=1,SpellRanks do
					MinHealArray[i] = MinHealArray[i] * HealImproved
					MaxHealArray[i] = MaxHealArray[i] * HealImproved
				end
			end
			return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, TargetID, SpellButton)
		else
			return false
		end
	end
end

-- From: Jiral
function castUnderRegrowth(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castRegrowth("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverRegrowth(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castRegrowth("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxRegrowth(RankAdj, unit)
	return castRegrowth("maximum", RankAdj, unit)
end





--This will try to heal party or raid members as long as you are not targeting a unit that can be healed by the spell.
--I made it give priority to your current target so that you have the option to choose priority in the heat of battle.
--If you want it to always select for you then just clear your target or target an enemy before using the function.
function castGroupRejuvenation(pet, Mode, RankAdj)
	local SpellName = LOCALIZATION_ZORLEN_Rejuvenation
	if UnitExists("target") and castRejuvenation(Mode, RankAdj, "target") then
		return true
	elseif not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	elseif UnitMana("player") < 25 then
		return false
	else
		local SpellButton = Zorlen_Button[SpellName]
		local _ = nil
		local isUsable = nil
		local duration = nil
		local isCurrent = nil
		local SpellID = nil
		if SpellButton then
			isUsable = IsUsableAction(SpellButton)
			_, duration, _ = GetActionCooldown(SpellButton)
			isCurrent = IsCurrentAction(SpellButton)
		else
			SpellID = Zorlen_GetSpellID(SpellName)
		end
		if not SpellButton or (( isUsable == 1 ) and ( duration == 0 ) and not ( isCurrent == 1 )) then
			if SpellButton or Zorlen_checkCooldown(SpellID) then
				local counter = 1
				local notunitarray = {}
				while counter do
					local u = Zorlen_GiveGroupUnitWithLowestHealthWithoutBuffBySpellName(SpellName, pet, nil, nil, notunitarray)
					if u then
						if UnitIsUnit("target", u) then
							notunitarray[counter] = u
						elseif UnitIsUnit("player", u) then
							return castRejuvenation(Mode, RankAdj, u)
						else
							TargetUnit(u)
							if castRejuvenation(Mode, RankAdj, u) then
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
				end
			end
		end
	end
	return false
end

function castUnderGroupRejuvenation(pet, RankAdj)
	local DefaultAdj = RankAdj or -1
	return castGroupRejuvenation(pet, "under", DefaultAdj)
end

function castOverGroupRejuvenation(pet, RankAdj)
	local DefaultAdj = RankAdj or 1
	return castGroupRejuvenation(pet, "over", DefaultAdj)
end

function castMaxGroupRejuvenation(pet, RankAdj)
	return castGroupRejuvenation(pet, "maximum", RankAdj)
end

-- From: Jiral
function castRejuvenation(Mode, RankAdj, unit)
	local SpellName = LOCALIZATION_ZORLEN_Rejuvenation
	local SpellButton = Zorlen_Button[SpellName]
	if Zorlen_IsSpellKnown(SpellName) and not isCasterForm() then
		return castCasterForm()
	else
		local TargetID = unit or "target"
		if unit then
			if not UnitExists(unit) or UnitCanAttack("player", unit) or not UnitIsFriend(unit, "player") or not (UnitHealth(unit) > 0) or not UnitIsVisible(unit) or UnitIsDeadOrGhost(unit) then
				return false
			end
		elseif not UnitExists("target") or UnitCanAttack("player", "target") or not UnitIsFriend("target", "player") or not (UnitHealth("target") > 0) or not UnitIsVisible("target") or UnitIsDeadOrGhost("target") or UnitIsUnit("target", "player") then
			TargetID = "player"
		end
		if not isRejuvenation(TargetID) then
			local LevelLearnedArray={4,10,16,22,28,34,40,46,52,58,60}
			local ManaArray={25,40,75,105,135,160,195,235,280,335,360}
			local MinHealArray={32,56,116,180,244,304,388,488,608,756,888}
			local MaxHealArray={32,56,116,180,244,304,388,488,608,756,888}
			local TimeArray={0,0,0,0,0,0,0,0,0,0,0}
			local HealImproved = 1
			if Zorlen_HasTalent(LOCALIZATION_ZORLEN_GiftofNature) then
				HealImproved = HealImproved + (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_GiftofNature) * .02)
			end
			if Zorlen_HasTalent(LOCALIZATION_ZORLEN_ImprovedRejuvenation) then
				HealImproved = HealImproved + (Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedRejuvenation) * .05)
			end
			if HealImproved > 1 then
				for i=1,11 do
					MinHealArray[i] = MinHealArray[i] * HealImproved
					MaxHealArray[i] = MaxHealArray[i] * HealImproved
				end
			end
			return Zorlen_CastHealingSpell(SpellName, ManaArray, MinHealArray, MaxHealArray, TimeArray, LevelLearnedArray, Mode, RankAdj, TargetID, SpellButton)
		else
			return false
		end
	end
end

-- From: Jiral
function castUnderRejuvenation(RankAdj, unit)
	local DefaultAdj = RankAdj or -1
	return castRejuvenation("under", DefaultAdj, unit)
end

-- From: Jiral
function castOverRejuvenation(RankAdj, unit)
	local DefaultAdj = RankAdj or 1
	return castRejuvenation("over", DefaultAdj, unit)
end

-- From: Jiral
function castMaxRejuvenation(RankAdj, unit)
	return castRejuvenation("maximum", RankAdj, unit)
end




function castGroupSwiftmend(pet)
	local SpellName = LOCALIZATION_ZORLEN_Swiftmend
	if UnitExists("target") and castSwiftmend() then
		return true
	elseif not Zorlen_IsSpellKnown(SpellName) then
		return false
	elseif not isCasterForm() then
		return castCasterForm()
	else
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
		else
			SpellID = Zorlen_GetSpellID(SpellName)
		end
		if not SpellButton or (( isUsable == 1 ) and ( duration == 0 ) and not ( isCurrent == 1 ) and ( not notEnoughMana )) then
			if SpellButton or Zorlen_checkCooldown(SpellID) then
				local counter = 1
				local notunitarray = {}
				local SpellName1 = LOCALIZATION_ZORLEN_Rejuvenation
				local SpellName2 = LOCALIZATION_ZORLEN_Regrowth
				while counter do
					local u = Zorlen_GiveGroupUnitWithLowestHealthWithBuffBySpellName(SpellName1, SpellName2, pet, nil, nil, notunitarray)
					if u then
						if UnitIsUnit("target", u) then
							notunitarray[counter] = u
						elseif UnitIsUnit("player", u) then
							return castSwiftmend()
						else
							TargetUnit(u)
							if castSwiftmend() then
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


function castSwiftmend()
	local SpellName = LOCALIZATION_ZORLEN_Swiftmend
	local SpellButton = Zorlen_Button[SpellName]
	local TargetDamage = UnitHealthMax("target") - UnitHealth("target")
	local PlayerDamage = UnitHealthMax("player") - UnitHealth("player")
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
				if (( inRange == 1 ) and TargetDamage > 0 and UnitIsFriend("player", "target") and (isRejuvenation() or isRegrowth())) or (PlayerDamage > 0 and not UnitExists("target") and (isRejuvenationActive() or isRegrowthActive())) then
					UseAction(SpellButton)
					if (PlayerDamage > 0 and SpellIsTargeting() and SpellCanTargetUnit("player")) then
						SpellTargetUnit("player");
					elseif SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif PlayerDamage > 0 and UnitExists("target") and (isRejuvenationActive() or isRegrowthActive()) then
					TargetUnit("player");
					UseAction(SpellButton)
					TargetLastTarget();
					return true
				end
			end
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName);
			if Zorlen_checkCooldown(SpellID) then
				if (TargetDamage > 0 and UnitIsFriend("player", "target") and (isRejuvenation() or isRegrowth())) or (PlayerDamage > 0 and not UnitExists("target") and (isRejuvenationActive() or isRegrowthActive())) then
					CastSpell(SpellID, 0)
					if (PlayerDamage > 0 and SpellIsTargeting() and SpellCanTargetUnit("player")) then
						SpellTargetUnit("player");
					elseif SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif PlayerDamage > 0 and UnitExists("target") and (isRejuvenationActive() or isRegrowthActive()) then
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


function castSelfSwiftmend()
	local SpellName = LOCALIZATION_ZORLEN_Swiftmend
	local SpellButton = Zorlen_Button[SpellName]
	local PlayerDamage = UnitHealthMax("player") - UnitHealth("player")
	local exist = nil;
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if PlayerDamage > 0 and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and (isRejuvenationActive() or isRegrowthActive()) then
				if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
					exist = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (exist) then
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
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			if PlayerDamage > 0 and (isRejuvenationActive() or isRegrowthActive()) then
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
	end
	return false
end


function forceSwiftmend()
	if castSwiftmend() then
		return true
	end
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Swiftmend) and not (not UnitExists("target") and (isRejuvenationActive() or isRegrowthActive())) and not (UnitExists("target") and (isRejuvenation() or isRegrowth())) then
		return castMaxRejuvenation()
	end
	return false
end



function forceSelfSwiftmend()
	if castSelfSwiftmend() then
		return true
	end
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Swiftmend) and not (isRejuvenationActive() or isRegrowthActive()) then
		return castMaxRejuvenation(nil, "player")
	end
	return false
end



function castInnervate()
	local SpellName = LOCALIZATION_ZORLEN_Innervate
	local SpellButton = Zorlen_Button[SpellName]
	local TargetManaUsed = UnitManaMax("target") - UnitMana("target")
	local PlayerManaUsed = UnitManaMax("player") - UnitMana("player")
	local PlayerHealth = UnitHealth("player")
	local TargetHealth = UnitHealth("target")
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local inRange = IsActionInRange(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) then
				if (usesMana() and ( inRange == 1 ) and TargetManaUsed > 0 and UnitIsFriend("player", "target") and TargetHealth > 0) or (PlayerManaUsed > 0 and not UnitExists("target") and PlayerHealth > 0) then
					UseAction(SpellButton)
					if (PlayerManaUsed > 0 and SpellIsTargeting() and SpellCanTargetUnit("player")) then
						SpellTargetUnit("player");
					elseif SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif PlayerManaUsed > 0 and UnitExists("target") and PlayerHealth > 0 then
					TargetUnit("player");
					UseAction(SpellButton)
					TargetLastTarget();
					return true
				end
			end
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			local SpellID = Zorlen_GetSpellID(SpellName);
			if Zorlen_checkCooldown(SpellID) then
				if (usesMana() and TargetManaUsed > 0 and UnitIsFriend("player", "target") and TargetHealth > 0) or (PlayerManaUsed > 0 and not UnitExists("target") and PlayerHealth > 0) then
					CastSpell(SpellID, 0)
					if (PlayerManaUsed > 0 and SpellIsTargeting() and SpellCanTargetUnit("player")) then
						SpellTargetUnit("player");
					elseif SpellIsTargeting() then
						SpellStopTargeting()
						return false
					end
					return true
				elseif PlayerManaUsed > 0 and UnitExists("target") and PlayerHealth > 0 then
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


function castSelfInnervate()
	local SpellName = LOCALIZATION_ZORLEN_Innervate
	local SpellButton = Zorlen_Button[SpellName]
	local PlayerManaUsed = UnitManaMax("player") - UnitMana("player")
	local PlayerHealth = UnitHealth("player")
	local exist = nil;
	if SpellButton then
		if not isCasterForm() then
			return castCasterForm()
		else
			local isUsable, notEnoughMana = IsUsableAction(SpellButton)
			local _, duration, _ = GetActionCooldown(SpellButton)
			local isCurrent = IsCurrentAction(SpellButton)
			if PlayerManaUsed > 0 and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and PlayerHealth > 0 then
				if (UnitExists("target")) and (not UnitIsUnit("player", "target")) then
					exist = 1;
					TargetUnit("player");
				end
				CastSpell(SpellID, 0)
				if (exist) then
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
	elseif Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		if not isCasterForm() then
			return castCasterForm()
		else
			if PlayerManaUsed > 0 and PlayerHealth > 0 then
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
	end
	return false
end





--Added by Mithrael
--Returns true if Barkskin is active
function isBarkskinActive()
	return Zorlen_checkBuff("Spell_Nature_StoneClawTotem")
end

--Added by Mithrael
--Returns true if Nature's Grasp is active
function isNaturesGraspActive()
	return Zorlen_checkBuff("Spell_Nature_NaturesWrath")
end

--Added by Mithrael
--Returns true if Prowl is active
function isProwlActive()
	return Zorlen_checkBuff("Ability_Ambush")
end

--Added by Mithrael
--Returns true if Nature's Swiftness is active
function isNaturesSwiftnessActive()
	return Zorlen_checkBuff("Spell_Nature_RavenForm")
end

--Added by Mithrael
--Returns true if the target has Entangling Root on it
function isRooted(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Nature_StrangleVines", unit, dispelable)
end

--Added by Mithrael
--Returns true if the target has Insect Swarm on it
function isInsectSwarm(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Nature_InsectSwarm", unit, dispelable)
end

--Added by Mithrael
--Returns true if the target has Faerie Fire on it
function isFaerieFire(unit, dispelable)
	local SpellName = LOCALIZATION_ZORLEN_FaerieFire
	return Zorlen_checkDebuffByName(SpellName, unit, dispelable)
end

--Added by Mithrael
--Returns true if the target has Moonfire on it
function isMoonfire(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Nature_StarFall", unit, dispelable)
end

--Added by Mithrael
--If Bark Skin is not already active, it will cast it
function castBarkskin(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Barkskin
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

--Added by Mithrael
--If Nature's Grasp is not already active, it will cast it
function castNaturesGrasp(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_NaturesGrasp
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

--Added by Mithrael
--If Prowl is not already active, it will cast it
function castProwl(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Prowl
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCatForm() then
		return castCatForm()
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

--Added by Mithrael
--If Nature's Swiftness is not already active, it will cast it
function castNaturesSwiftness(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_NaturesSwiftness
	local EnemyTargetNotNeeded = 1
	local BuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, EnemyTargetNotNeeded, BuffName, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end


--Added by Mithrael
function castEntanglingRoots(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_EntanglingRoots
	local DebuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	if Zorlen_isMoving() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

--Added by Mithrael
function castInsectSwarm(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_InsectSwarm
	local DebuffName = SpellName
	local SpellCheckNotNeeded = 1
	local DebuffTimer = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() then
		return castCasterForm()
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, DebuffTimer)
end

--Added by Mithrael
--Edited by BigRedBrent
function castFaerieFire()
	local SpellName = LOCALIZATION_ZORLEN_FaerieFire
	local FeralSpellName = LOCALIZATION_ZORLEN_FaerieFireFeral
	if Zorlen_IsSpellKnown(FeralSpellName) and (isDireBearForm() or isBearForm() or isCatForm()) then
		local SpellID = Zorlen_GetSpellID(FeralSpellName)
		if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and not isFaerieFire() then
			CastSpell(SpellID, 0)
			return true
		end
	elseif Zorlen_IsSpellKnown(SpellName) then
		if isCasterForm() or isMoonkinForm() then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and not isFaerieFire() then
				CastSpell(SpellID, 0)
				return true
			end
		else
			return castCasterForm()
		end
	end
	return false
end

--Added by Mithrael
--Edited by BigRedBrent
function castMoonfire(SpellRank, NoDebuffCheck)
	local SpellName = LOCALIZATION_ZORLEN_Moonfire
	local DebuffName = SpellName
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	local DebuffTimer = 1
	if NoDebuffCheck then
		DebuffName = nil
		DebuffTimer = nil
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, DebuffName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded, nil, nil, nil, nil, nil, nil, nil, nil, DebuffTimer)
end

--Added by Mithrael
function castStarfire(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Starfire
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	if Zorlen_isMoving() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end


function castWrath(SpellRank)
	local SpellName = LOCALIZATION_ZORLEN_Wrath
	local SpellCheckNotNeeded = 1
	if not Zorlen_Button_MaxRank[SpellName] and not Zorlen_IsSpellKnown(SpellName) then
		return false
	end
	if not isCasterForm() and not isMoonkinForm() then
		return castCasterForm()
	end
	if Zorlen_isMoving() then
		return false
	end
	return Zorlen_CastCommonRegisteredSpell(SpellRank, SpellName, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, SpellCheckNotNeeded)
end

