--[[
  Zorlen Library - Started by Marcus S. Zarra

  3.10.0
		isSliceActive() added by Mizz
		isStealthActive() added by BigRedBrent
		isComboPointsFull() added by BigRedBrent
		Zorlen_CheapShotEnergyCost() added by BigRedBrent
		Zorlen_SinisterStrikeEnergyCost() added by Mizz
		castSinisterStrike() added by Mizz
		castBackstab() added by Mizz
		castKick() added by Mizz
		castCheapShot() added by BigRedBrent

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]


function isComboPointsFull()
	if GetComboPoints() == 5 then
		return true
	end
	return false
end



function isStealthActive()
	return Zorlen_checkBuff("Ability_Stealth")
end 



function isSliceActive()
	return Zorlen_checkBuff("Ability_Rogue_SliceDice")
end 



-- Returns the energy cost the CheapShot ability will need for it to cast (even if talent points are spent on it to lower its required energy cost).
-- Will return 0 if no rank of the ability has been learned from the Rouge Trainer.
function Zorlen_CheapShotEnergyCost()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedCheapShot)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_CheapShot)) then
		return 0
	else if (t == 2) then
		return 40
	else if (t == 1) then
		return 50
	else
		return 60
	end
	end
	end
end



-- Returns the energy cost the Sinister Strike ability will need for it to cast (even if talent points are spent on it to lower its required energy cost).
-- Will return 0 if no rank of the ability has been learned from the Rouge Trainer.
function Zorlen_SinisterStrikeEnergyCost()
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedSinisterStrike)
	if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_SinisterStrike)) then
		return 0
	else if (t == 2) then
		return 40
	else if (t == 1) then
		return 42
	else
		return 45
	end
	end
	end
end



function castSinisterStrike()
	local SpellName = LOCALIZATION_ZORLEN_SinisterStrike
	local SpellButton = Zorlen_Button_SinisterStrike
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_TargetIsEnemy() and UnitMana("player") >= Zorlen_SinisterStrikeEnergyCost() and Zorlen_isMainHandEquipped() then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	return false
end



function castCheapShot()
	local SpellName = LOCALIZATION_ZORLEN_CheapShot
	local SpellButton = Zorlen_Button_CheapShot
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_TargetIsEnemy() and (UnitMana("player") >= Zorlen_CheapShotEnergyCost() and Zorlen_isMainHandEquipped() and isStealthActive()) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	return false
end



function castBackstab()
	local SpellName = LOCALIZATION_ZORLEN_Backstab
	local SpellButton = Zorlen_Button_Backstab
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			UseAction(SpellButton)
			return true
		end
	else
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and Zorlen_isMainHandDagger() then
				CastSpell(SpellID, 0)
				return true
			end
		end	
	end	
	return false
end



function castKick()
	local SpellName = LOCALIZATION_ZORLEN_Kick
	local SpellButton = Zorlen_Button_Kick
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and usesMana() then
			UseAction(SpellButton)
			return true
		end
	else
		if Zorlen_IsSpellKnown(SpellName) then
			local SpellID = Zorlen_GetSpellID(SpellName)
			if Zorlen_TargetIsEnemy() and Zorlen_checkCooldown(SpellID) and UnitMana("player") >= 25 and usesMana() then
				CastSpell(SpellID, 0)
				return true
			end
		end	
	end	
	return false
end
