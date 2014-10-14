--[[
  Zorlen Library - Started by Marcus S. ZarraZorlen_WarlockDotSpam(mode)

  3.60.00
		Zorlen_GiveSoulShardCount() added by BigRedBrent, Taken from "lock tools"

  3.56.00
		Updated castImmolate() and castCorruption() to trigger the spell to stop casting if the target is immune to or already afflicted by the spell
		castDemonArmor() added by BigRedBrent
		isDemonArmorActive() added by BigRedBrent
		Updated: Zorlen_WarlockDotSpam() by BigRedBrent

  3.55.00
		Updated Zorlen_WarlockDotSpam() to cast drain life more intelligently, by BigRedBrent

  3.51.00
		Updated: Zorlen_WarlockDotSpam() by BigRedBrent

  3.50.00
		Updated: castDrainSoul() by BigRedBrent
		Updated: Zorlen_WarlockDotSpam() by BigRedBrent

  3.33.33
		Replaced the alt key modifier with the control key.
  
  3.33.00
		Renamed: isNightfall() to: isNightfallActive()
		Pressing and holding down the Control Key will now suppress the debuff checking for castCurseOfAgony(), castCorruption(), castImmolate(), castSiphonLife(), and castCurseOfDoom().
  
  3.32.00
		Zorlen_WarlockDotSpamWithoutFire() added by BigRedBrent
		Zorlen_WarlockDotSpamWithoutDrain() added by BigRedBrent
		Zorlen_WarlockDotSpamWithoutFireOrDrain() added by BigRedBrent
		Added immunity detection for fire and life draining spells.
  
  3.31.00
		isCursed() added by Drauka
		castAmplifyCurse() added by Drauka
		Zorlen_WarlockDotSpam() added by BigRedBrent with help from Drauka
		isAmplifyCurseActive() added by BigRedBrent
  
  3.24.00
		Added casting detection and updated warlock section to support it.
  
  3.19.00
		isCurseOfWeakness() added by BigRedBrent
		isCurseOfExhaustion() added by BigRedBrent
		isCurseOfRecklessness() added by BigRedBrent
		isCurseOfTongues() added by BigRedBrent
		castCurseOfWeakness() added by BigRedBrent
		castCurseOfExhaustion() added by BigRedBrent
		castCurseOfRecklessness() added by BigRedBrent
		castCurseOfTongues() added by BigRedBrent
  
  3.9.12
		Added action bar button slot detection.
  
  3.2.5  
		Added: castDrainSoul("maximum") & castDrainSoul("lowest") to do the same as castMaxDrainSoul() & castLowestDrainSoul()
  
  3.0.3  
		castLowestDrainSoul() added by BigRedBrent
		castSelfSacrifice() added by BigRedBrent
		isCurseOfAgony() added by BigRedBrent
		castCurseOfAgony() added by BigRedBrent
		isCorruption() added by BigRedBrent
		castCorruption() added by BigRedBrent
		isImmolate() added by BigRedBrent
		castImmolate() added by BigRedBrent
		isSiphonLife() added by BigRedBrent
		castSiphonLife() added by BigRedBrent
		isCurseOfDoom() added by BigRedBrent
		castCurseOfDoom() added by BigRedBrent
		isCurseOfShadow() added by BigRedBrent
		castCurseOfShadow() added by BigRedBrent
		isCurseOfTheElements() added by BigRedBrent
		castCurseOfTheElements() added by BigRedBrent
		castDrainLife() added by BigRedBrent
		castDrainMana() added by BigRedBrent
		isNightfallActive() added by BigRedBrent
		castNightfall() added by BigRedBrent
		castShadowBolt() added by BigRedBrent
		castHellfire() added by BigRedBrent
		castRainOfFire() added by BigRedBrent

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		castDrainSoul() added by BigRedBrent
		castMaxDrainSoul() added by BigRedBrent
		castDarkPactAndLifeTap() added by BigRedBrent
		castDarkPact() added by BigRedBrent
		castLifeTap() added by BigRedBrent
		castAutoTap() added by BigRedBrent
--]]

--Taken from "lock tools"
--This will return the numerical value of how many soul shards you have in your bags.
function Zorlen_GiveSoulShardCount()
	local SoulShards = 0;
	for bag=0,4 do
		for slot=1,GetContainerNumSlots(bag) do
			if (GetContainerItemLink(bag,slot)) then
				if (string.find(GetContainerItemLink(bag,slot), LOCALIZATION_ZORLEN_SoulShard)) then
					SoulShards = SoulShards+1;
				end
			end
		end
	end
	--Zorlen_debug("Soul Shard Count: "..SoulShards)
	return SoulShards
end


function isCursed(unit, dispelable)
   if
   isCurseOfWeakness(unit, dispelable)
   or
   isCurseOfExhaustion(unit, dispelable)
   or
   isCurseOfRecklessness(unit, dispelable)
   or
   isCurseOfTongues(unit, dispelable)
   or
   isCurseOfAgony(unit, dispelable)
   or
   isCurseOfDoom(unit, dispelable)
   or
   isCurseOfShadow(unit, dispelable)
   or
   isCurseOfTheElements(unit, dispelable)
   then
      return true
   end
   return false
end

function isCurseOfAgony(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_CurseOfSargeras", unit, dispelable)
end

function isCorruption(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_AbominationExplosion", unit, dispelable)
end

function isImmolate(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Fire_Immolation", unit, dispelable)
end

function isSiphonLife(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_Requiem", unit, dispelable)
end

function isCurseOfDoom(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_AuraOfDarkness", unit, dispelable)
end

function isCurseOfShadow(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_CurseOfAchimonde", unit, dispelable)
end

function isCurseOfTheElements(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_ChillTouch", unit, dispelable)
end

function isCurseOfWeakness(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_CurseOfMannoroth", unit, dispelable)
end

function isCurseOfRecklessness(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_UnholyStrength", unit, dispelable)
end

function isCurseOfTongues(unit, dispelable)
	return Zorlen_checkDebuff("Spell_Shadow_CurseOfTounges", unit, dispelable)
end

function isCurseOfExhaustion(unit, dispelable)
	local SpellName = LOCALIZATION_ZORLEN_CurseOfExhaustion
	return Zorlen_checkDebuffBySpellName(SpellName, unit, dispelable)
end

function isAmplifyCurseActive()
   return Zorlen_checkBuff("Spell_Shadow_Contagion")
end 

function isDemonArmorActive()
	return Zorlen_checkBuff("Spell_Shadow_RagingScream")
end







function castDemonArmor()
	local SpellName = LOCALIZATION_ZORLEN_DemonArmor
	local SpellButton = Zorlen_Button_DemonArmor
	if not SpellButton then
		if not Zorlen_IsSpellKnown(SpellName) then
			SpellName = LOCALIZATION_ZORLEN_DemonSkin
			SpellButton = Zorlen_Button_DemonSkin
		end
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not isDemonArmorActive() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(""..SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isDemonArmorActive()) then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castAmplifyCurse()
   local SpellName = LOCALIZATION_ZORLEN_AmplifyCurse
   local SpellButton = Zorlen_Button_AmplifyCurse
   if SpellButton then
      local isUsable, notEnoughMana = IsUsableAction(SpellButton)
      local _, duration, _ = GetActionCooldown(SpellButton)
      if ( isUsable == 1 ) and ( duration == 0 ) then
         UseAction(SpellButton)
         return true
      end
   else if Zorlen_IsSpellKnown(SpellName) then
      Zorlen_debug(SpellName.." was not found on any of the action bars!")
      local SpellID = Zorlen_GetSpellID(SpellName)
      CastSpell(SpellID, 0)
      return true
   end
   end
   return false
end


function castCurseOfAgony()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfAgony
	local SpellButton = Zorlen_Button_CurseOfAgony
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isCurseOfAgony() or isAmplifyCurseActive() or IsControlKeyDown()) and not Zorlen_AllDebuffSlotsUsed() then
			if Zorlen_checkBuff("Spell_Shadow_Contagion") then
				SpellStopCasting()
				UseAction(SpellButton)
				return true
			else
				UseAction(SpellButton)
				return true
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isCurseOfAgony() or isAmplifyCurseActive() or IsControlKeyDown()) and not Zorlen_AllDebuffSlotsUsed() then
			if Zorlen_checkBuff("Spell_Shadow_Contagion") then
				SpellStopCasting()
				CastSpell(SpellID, 0)
				return true
			else
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end

function castCorruption()
	local SpellName = LOCALIZATION_ZORLEN_Corruption
	local SpellButton = Zorlen_Button_Corruption
	if Zorlen_isCasting(SpellName) and (isCorruption() and not IsControlKeyDown()) then
		Zorlen_debug("Target has "..SpellName.." on them! Stopping "..SpellName.." spell cast.");
		SpellStopCasting()
		return false
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isCorruption() or IsControlKeyDown()) and not Zorlen_isCasting(SpellName) and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isCorruption() or IsControlKeyDown()) and not Zorlen_isCasting(SpellName) and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castImmolate()
	local SpellName = LOCALIZATION_ZORLEN_Immolate
	local SpellButton = Zorlen_Button_Immolate
	if Zorlen_isCasting(SpellName) and (Zorlen_FireSpellCastImmune or (isImmolate() and not IsControlKeyDown())) then
		if Zorlen_FireSpellCastImmune then
			Zorlen_debug("Target is immune to fire damage! Stopping "..SpellName.." spell cast.");
		else
			Zorlen_debug("Target has "..SpellName.." on them! Stopping "..SpellName.." spell cast.");
		end
		SpellStopCasting()
		return false
	end
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isImmolate() or IsControlKeyDown()) and not Zorlen_isCasting(SpellName) and not Zorlen_FireSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isImmolate() or IsControlKeyDown()) and not Zorlen_isCasting(SpellName) and not Zorlen_FireSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castSiphonLife()
	local SpellName = LOCALIZATION_ZORLEN_SiphonLife
	local SpellButton = Zorlen_Button_SiphonLife
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isSiphonLife() or IsControlKeyDown()) and not Zorlen_DrainLifeSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isSiphonLife() or IsControlKeyDown()) and not Zorlen_DrainLifeSpellCastImmune and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfDoom()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfDoom
	local SpellButton = Zorlen_Button_CurseOfDoom
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and (not isCurseOfDoom() or IsControlKeyDown()) and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if (not isCurseOfDoom() or IsControlKeyDown()) and not Zorlen_AllDebuffSlotsUsed() then
			if Zorlen_checkCooldown(SpellID) then
				CastSpell(SpellID, 0)
				return true
			end
		end
	end
	end
	return false
end



function castCurseOfShadow()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfShadow
	local SpellButton = Zorlen_Button_CurseOfShadow
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfShadow() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfShadow() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfTheElements()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfTheElements
	local SpellButton = Zorlen_Button_CurseOfTheElements
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfTheElements() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfTheElements() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfWeakness()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfWeakness
	local SpellButton = Zorlen_Button_CurseOfWeakness
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfWeakness() and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfWeakness() and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfExhaustion()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfExhaustion
	local SpellButton = Zorlen_Button_CurseOfExhaustion
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfExhaustion() and not Zorlen_AllDebuffSlotsUsed() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfExhaustion() and not Zorlen_AllDebuffSlotsUsed() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfRecklessness()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfRecklessness
	local SpellButton = Zorlen_Button_CurseOfRecklessness
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfRecklessness() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfRecklessness() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castCurseOfTongues()
	local SpellName = LOCALIZATION_ZORLEN_CurseOfTongues
	local SpellButton = Zorlen_Button_CurseOfTongues
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not isCurseOfTongues() and usesMana() then
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not isCurseOfTongues() and usesMana() then
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end



function castDrainLife()
	local SpellName = LOCALIZATION_ZORLEN_DrainLife
	local SpellButton = Zorlen_Button_DrainLife
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not Zorlen_isChanneling(SpellName) and not Zorlen_DrainLifeSpellCastImmune then
			Zorlen_ChannelingSpellName = SpellName;
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not Zorlen_isChanneling(SpellName) and not Zorlen_DrainLifeSpellCastImmune then
			Zorlen_ChannelingSpellName = SpellName;
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castDrainMana()
	local SpellName = LOCALIZATION_ZORLEN_DrainMana
	local SpellButton = Zorlen_Button_DrainMana
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) and not Zorlen_isChanneling(SpellName) and usesMana() then
			Zorlen_ChannelingSpellName = SpellName;
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not Zorlen_isChanneling(SpellName) and usesMana() then
			Zorlen_ChannelingSpellName = SpellName;
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castHellfire()
	local SpellName = LOCALIZATION_ZORLEN_Hellfire
	local SpellButton = Zorlen_Button_Hellfire
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not Zorlen_isChanneling(SpellName) then
			Zorlen_ChannelingSpellName = SpellName;
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not Zorlen_isChanneling(SpellName) then
			Zorlen_ChannelingSpellName = SpellName;
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end

function castRainOfFire()
	local SpellName = LOCALIZATION_ZORLEN_RainOfFire
	local SpellButton = Zorlen_Button_RainOfFire
	if SpellButton then
		local SpellID = Zorlen_GetSpellID(SpellName)
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and not ( isCurrent == 1 ) and not Zorlen_isChanneling(SpellName) then
			Zorlen_ChannelingSpellName = SpellName;
			UseAction(SpellButton)
			return true
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if not Zorlen_isChanneling(SpellName) and not SpellIsTargeting() then
			Zorlen_ChannelingSpellName = SpellName;
			CastSpell(SpellID, 0)
			return true
		end
	end
	end
	return false
end



function castDrainSoul(mode)
	local SpellName = LOCALIZATION_ZORLEN_DrainSoul
	local m = { 55, 375, 630, 870 };
	local h = UnitHealth("player")
	local mana = UnitMana("player")
	local p = UnitMana("pet")
	if Zorlen_IsSpellKnown(SpellName) then
		SpellStopCasting()
		if not Zorlen_TargetIsActiveEnemy() then
			Zorlen_TargetActiveEnemyOnly()
		end
		if not Zorlen_TargetIsActiveEnemy() then
			return false
		end
		if mana >= 55 then
			if mode == "lowest" then
				if not Zorlen_isChanneling(SpellName) then
					Zorlen_ChannelingSpellName = SpellName;
					CastSpellByName(""..SpellName.."("..LOCALIZATION_ZORLEN_Rank.." 1)")
					return true
				end
			else
				if mode == "maximum" then
					m = { 55, 125, 210, 290 }
				end
				for i = 4, 1, -1 do
					if ( mana >= m[i] ) then
						if Zorlen_IsSpellRankKnown(SpellName, ""..LOCALIZATION_ZORLEN_Rank.." "..i.."") then
							if not Zorlen_isChanneling(SpellName) then
								Zorlen_ChannelingSpellName = SpellName;
								CastSpellByName(""..SpellName.."("..LOCALIZATION_ZORLEN_Rank.." "..i..")");
								return true
							end
							break
						end
					end	
				end
			end
		else if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DarkPact) and p >= 150 then
			if p / UnitManaMax("pet") >= 0.95 then
				castDarkPact()
			else
				CastSpellByName(""..LOCALIZATION_ZORLEN_DarkPact.."("..LOCALIZATION_ZORLEN_Rank.." 1)")
			end
			return true
		else if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_LifeTap) then
			local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedLifeTap)
			local q = 25
			if t == 2 then
				q = 19
			else if t == 1 then
				q = 22
			end
			end
			if UnitHealth("player") / UnitHealthMax("player") >= 0.95 and not (Zorlen_TargetIsEnemyTargetingYou() and Zorlen_inCombat()) then
				castLifeTap()
				return true
			else if mana < q and h > 75 and Zorlen_IsSpellRankKnown(LOCALIZATION_ZORLEN_LifeTap, ""..LOCALIZATION_ZORLEN_Rank.." 2") then
				CastSpellByName(""..LOCALIZATION_ZORLEN_LifeTap.."("..LOCALIZATION_ZORLEN_Rank.." 2)")
				return true
			else if (mana >= q and h > 30) or (mana < q and h > 60) then
				CastSpellByName(""..LOCALIZATION_ZORLEN_LifeTap.."("..LOCALIZATION_ZORLEN_Rank.." 1)")
				return true
			end
			end
			end
		end
		end
		end
	end
	return false
end

function castMaxDrainSoul()
	return castDrainSoul("maximum")
end

function castLowestDrainSoul()
	return castDrainSoul("lowest")
end



function castAutoTap()
	local c = Zorlen_inCombat()
	local m = UnitMana("player")
	local mm = UnitManaMax("player")
	local p = UnitMana("pet")
	local pm = UnitManaMax("pet")
	local h = UnitHealth("player")
	local hm = UnitHealthMax("player")
	local d = Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DarkPact)
	local l = Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_LifeTap)
	if not Zorlen_isCastingOrChanneling() and not (c and m / mm >= 0.9) then
		if d and mm - m >= 150 and (p == pm or (p / pm >= 0.99 and (h < hm or not l))) and castDarkPact() then
			return true
		else if not (Zorlen_TargetIsEnemyTargetingYou() and c) and ((m / mm >= 0.8 and h / hm >= 0.98) or (m / mm < 0.8 and h / hm >= 0.95)) and castLifeTap() then
			return true
		end
		end
	end
	return false
end



function castDarkPactAndLifeTap()
	if not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_DarkPact) then
		return castLifeTap()
	else if not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_LifeTap) then
		return castDarkPact()
	else if ((not (UnitMana("pet") < UnitManaMax("pet")) and not (UnitHealth("player") / UnitHealthMax("player") > 0.97)) or (Zorlen_TargetIsEnemyTargetingYou() and Zorlen_inCombat())) and castDarkPact() then
		return true
	else if castLifeTap() then
		return true
	end
	end
	end
	end
	return false
end



function castDarkPact()
	local m = { 150, 200, 250 }; --table of mana loss and cost required for each rank of Dark Pact
	for i = 3, 1, -1 do
		if ( UnitManaMax("player") - UnitMana("player") >= m[i] ) then
			if ( UnitMana("pet") >= m[i] ) then
				if Zorlen_IsSpellRankKnown(LOCALIZATION_ZORLEN_DarkPact, ""..LOCALIZATION_ZORLEN_Rank.." "..i.."") then
					CastSpellByName(""..LOCALIZATION_ZORLEN_DarkPact.."("..LOCALIZATION_ZORLEN_Rank.." "..i..")");
					return true
				end
			end
		end	
	end
	return false
end


function castLifeTap()
	local h = { 30, 75, 140, 220, 310, 424 }; --table of health costs for each rank of Life Tap
	local m = { 30, 75, 140, 220, 310, 424 }; --table of mana loss required for each rank of Life Tap
	local t = Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedLifeTap)
	if t == 2 then
		m = { 36, 90, 168, 264, 372, 508 }
	else if t == 1 then
		m = { 33, 83, 154, 242, 341, 466 }
	end
	end
	for i = 6, 1, -1 do
		if ( UnitManaMax("player") - UnitMana("player") >= m[i] ) then
			if ( UnitHealth("player") > h[i] ) then
				if Zorlen_IsSpellRankKnown(LOCALIZATION_ZORLEN_LifeTap, ""..LOCALIZATION_ZORLEN_Rank.." "..i.."") then
					CastSpellByName(""..LOCALIZATION_ZORLEN_LifeTap.."("..LOCALIZATION_ZORLEN_Rank.." "..i..")");
					return true
				end
			end
		end	
	end
	return false
end

-- I added this since the other added functions will not allow a quick self suicide since the other functions that use life tap will stop if your mana is full.
-- The ability for a warlock to be able to kill himself can be helpful to escape the 10% durability hit when killed in PvE by a mob,
-- or to get to a hard to reach location by killing your warlock within corps resurrecting distance to the desired location.
function castSelfSacrifice()
	local health = UnitHealth("player")
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Hellfire) then
		SpellStopCasting()
		if health / UnitHealthMax("player") > 0.1 and castLifeTap() then
			return true
		else if castHellfire() then
			return true
		end
		end
	end
	return false
end



function isNightfallActive()
	return Zorlen_checkBuff("Spell_Shadow_Twilight")
end



function castNightfall()
	if Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_ShadowBolt) then
		if isNightfallActive() then castShadowBolt()
		else if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
			if (not Zorlen_IsSpellKnown(LOCALIZATION_ZORLEN_Corruption) or isCorruption()) and castDrainLife() then
				return true
			else if not Zorlen_isChanneling(LOCALIZATION_ZORLEN_DrainLife) and castCorruption() then
				return true
			end
			end
		end
		end
	end
	return false
end



function castShadowBolt()
	local SpellName = LOCALIZATION_ZORLEN_ShadowBolt
	local SpellButton = Zorlen_Button_ShadowBolt
	if SpellButton then
		local isUsable, notEnoughMana = IsUsableAction(SpellButton)
		local _, duration, _ = GetActionCooldown(SpellButton)
		local inRange = IsActionInRange(SpellButton)
		local isCurrent = IsCurrentAction(SpellButton)
		if Zorlen_TargetIsEnemy() and ( isUsable == 1 ) and ( not notEnoughMana ) and ( duration == 0 ) and ( inRange == 1 ) and not ( isCurrent == 1 ) then
			if isNightfallActive() then
				SpellStopCasting()
				UseAction(SpellButton)
				return true
			else if not Zorlen_isCasting(SpellName) then
				UseAction(SpellButton)
				return true
			end
			end
		end
	else if Zorlen_IsSpellKnown(SpellName) then
		Zorlen_debug(SpellName.." was not found on any of the action bars!")
		local SpellID = Zorlen_GetSpellID(SpellName)
		if isNightfallActive() then
			SpellStopCasting()
			CastSpell(SpellID, 0)
			return true
		else if not Zorlen_isCasting(SpellName) then
			CastSpell(SpellID, 0)
			return true
		end
		end
	end
	end
	return false
end




function Zorlen_WarlockDotSpamWithoutFire()
	return Zorlen_WarlockDotSpam("nofire")
end

function Zorlen_WarlockDotSpamWithoutDrain()
	return Zorlen_WarlockDotSpam("nodrain")
end

function Zorlen_WarlockDotSpamWithoutFireOrDrain()
	return Zorlen_WarlockDotSpam("nofireordrain")
end


function Zorlen_WarlockDotSpam(mode)
	local isCastingOrChanneling = Zorlen_isCastingOrChanneling()
	local healthpercent = UnitHealth("player") / UnitHealthMax("player")
	local manapercent = UnitMana("player") / UnitManaMax("player")
	local TargetIsEnemyPlayer = Zorlen_TargetIsEnemyPlayer()
	local TargetIsEnemyTargetingYou = Zorlen_TargetIsEnemyTargetingYou()
	local TargetIsDieingEnemy = Zorlen_TargetIsDieingEnemy()
	local IsCurseOfAgonyInRange = nil
	local notEnoughManaCoA = nil
	local IsDrainLifeInRange = nil
	if Zorlen_Button_CurseOfAgony then
		isUsableCoA, notEnoughManaCoA = IsUsableAction(Zorlen_Button_CurseOfAgony)
		IsCurseOfAgonyInRange = IsActionInRange(Zorlen_Button_CurseOfAgony)
	end
	if Zorlen_Button_DrainLife then
		IsDrainLifeInRange = IsActionInRange(Zorlen_Button_DrainLife)
	end
	if (Zorlen_isCasting(LOCALIZATION_ZORLEN_Immolate) and (isImmolate() or TargetIsDieingEnemy or Zorlen_FireSpellCastImmune)) or (Zorlen_isCasting(LOCALIZATION_ZORLEN_Corruption) and (isCorruption() or TargetIsDieingEnemy)) then
		SpellStopCasting()
	end
	if not isCastingOrChanneling and manapercent >= 0.5 and castDemonArmor() then
		return true
	end
	if not isCastingOrChanneling and castAutoTap() then
		return true
	end
	if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_FelConcentration) >= 3 then
		if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedCorruption) == 5 then
			if (TargetIsEnemyTargetingYou and CheckInteractDistance("target", 1)) then
				if Zorlen_isCasting(LOCALIZATION_ZORLEN_Immolate) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Corruption) then
					SpellStopCasting()
				end
				if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
					if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
						return true
					else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
						return true
					else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and castSiphonLife() then
						return true
					else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
						return true
					else if not isCastingOrChanneling and castDrainLife() then
						return true
					end
					end
					end
					end
					end
					end
					end
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
			else if (UnitHealth("target") < UnitHealthMax("target")) then
				if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
					if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
						return true
					else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
						return true
					else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
						return true
					else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
						return true
					else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
						return true
					else if not isCastingOrChanneling and castDrainLife() then
						return true
					end
					end
					end
					end
					end
					end
					end
					end
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
				return true
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
		else if (TargetIsEnemyTargetingYou and CheckInteractDistance("target", 1)) then
			if Zorlen_isCasting(LOCALIZATION_ZORLEN_Immolate) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Corruption) then
				SpellStopCasting()
			end
			if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and castDrainLife() then
				return true
			end
			end
			end
			end
			end
			end
		else if (UnitHealth("target") < UnitHealthMax("target")) then
			if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
				return true
			end
			end
			end
			end
			end
			end
			end
			end
		else if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
			if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and castDrainLife() then
				return true
			end
			end
			end
			end
			end
			end
			end
			end
		else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
			return true
		else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
			return true
		else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
			return true
		else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
			return true
		else if not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
			return true
		else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
			return true
		else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
			return true
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
	else
		if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_ImprovedCorruption) == 5 then
			if (TargetIsEnemyTargetingYou and CheckInteractDistance("target", 1)) then
				if Zorlen_isCasting(LOCALIZATION_ZORLEN_Immolate) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Corruption) then
					SpellStopCasting()
				end
				if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
					if not isAmplifyCurseActive() and isNightfallActive() and castShadowBolt() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and castCorruption() then
						return true
					else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling)) and castCurseOfAgony() then
						return true
					else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and castSiphonLife() then
						return true
					end
					end
					end
					end
					end
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling)) and castCurseOfAgony() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and castCorruption() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and castSiphonLife() then
					return true
				end
				end
				end
				end
				end
			else if (UnitHealth("target") < UnitHealthMax("target")) then
				if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
					if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
						return true
					else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
						return true
					else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
						return true
					else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
						return true
					else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
						return true
					else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
						return true
					else if not isCastingOrChanneling and castDrainLife() then
						return true
					end
					end
					end
					end
					end
					end
					end
					end
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
				return true
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
		else if (TargetIsEnemyTargetingYou and CheckInteractDistance("target", 1)) then
			if Zorlen_isCasting(LOCALIZATION_ZORLEN_Immolate) or Zorlen_isCasting(LOCALIZATION_ZORLEN_Corruption) then
				SpellStopCasting()
			end
			if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and castShadowBolt() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling)) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and castSiphonLife() then
					return true
				end
				end
				end
				end
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling)) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and castSiphonLife() then
				return true
			end
			end
			end
			end
		else if (UnitHealth("target") < UnitHealthMax("target")) then
			if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
				if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
					return true
				else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
					return true
				else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
					return true
				else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
					return true
				else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
					return true
				else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
					return true
				else if not isCastingOrChanneling and castDrainLife() then
					return true
				end
				end
				end
				end
				end
				end
				end
				end
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
				return true
			end
			end
			end
			end
			end
			end
			end
			end
		else if Zorlen_GetTalentRank(LOCALIZATION_ZORLEN_Nightfall) > 0 then
			if not isAmplifyCurseActive() and isNightfallActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castShadowBolt() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
				return true
			else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
				return true
			else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
				return true
			else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
				return true
			else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
				return true
			else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
				return true
			else if not isCastingOrChanneling and castDrainLife() then
				return true
			end
			end
			end
			end
			end
			end
			end
			end
		else if not (mode == "nofire") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not isAmplifyCurseActive() and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castImmolate() then
			return true
		else if not TargetIsDieingEnemy and not isCastingOrChanneling and TargetIsEnemyPlayer and IsCurseOfAgonyInRange and not notEnoughManaCoA and castAmplifyCurse() then
			return true
		else if (isAmplifyCurseActive() or (not TargetIsDieingEnemy and not isCursed() and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange))) and castCurseOfAgony() then
			return true
		else if not (mode == "nodrain") and not (mode == "nofireordrain") and not TargetIsDieingEnemy and not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castSiphonLife() then
			return true
		else if not isCastingOrChanneling and not (healthpercent <= 0.8 and manapercent <= 0.2 and IsDrainLifeInRange) and castCorruption() then
			return true
		else if not isCastingOrChanneling and (not TargetIsEnemyTargetingYou or (IsDrainLifeInRange)) and (manapercent < 0.8 and healthpercent >= 0.95) and castLifeTap() then
			return true
		else if not isCastingOrChanneling and healthpercent <= 0.8 and castDrainLife() then
			return true
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
	return false
end


