
Zorlen_Mage_FileBuildNumber = 687

--[[
  Zorlen Library - Started by Marcus S. Zarra
 
  4.26
		isFrostArmorActive() added by CodeMaster Rapture
		isIceArmorActive() added by CodeMaster Rapture
		isMageArmorActive() added by CodeMaster Rapture
		castArcaneExplosion() added by CodeMaster Rapture
		castArcaneMissiles() added by CodeMaster Rapture
		castBlastWave() added by CodeMaster Rapture
		castBlizzard() added by CodeMaster Rapture
		castFireBlast() added by CodeMaster Rapture
		castFireball() added by CodeMaster Rapture
		castFlamestrike() added by CodeMaster Rapture
		castFrostbolt() added by CodeMaster Rapture
		castIceArmor() added by CodeMaster Rapture
		castMageArmor() added by CodeMaster Rapture
		castPyroblast() added by CodeMaster Rapture
		castScorch() added by CodeMaster Rapture
		cast_ManaEfficient_ArcaneExplosion() added by CodeMaster Rapture
		cast_ManaEfficient_ArcaneMissiles() added by CodeMaster Rapture
		cast_ManaEfficient_BlastWave() added by CodeMaster Rapture
		cast_ManaEfficient_Blizzard() added by CodeMaster Rapture
		cast_ManaEfficient_FireBlast() added by CodeMaster Rapture
		cast_ManaEfficient_Fireball() added by CodeMaster Rapture
		cast_ManaEfficient_Flamestrike() added by CodeMaster Rapture
		cast_ManaEfficient_Frostbolt() added by CodeMaster Rapture
		cast_ManaEfficient_PyroBlast() added by CodeMaster Rapture
		cast_ManaEfficient_Scorch() added by CodeMaster Rapture
 
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



function isArcaneIntellect(unit, castable)
	local SpellName = LOCALIZATION_ZORLEN.ArcaneIntellect
	local unit = unit or "target"
	return Zorlen_checkBuffByName(SpellName, unit, castable)
end




--------   All functions below this line will only load if you are playing the corresponding class   --------
if not Zorlen_isCurrentClassMage then return end





-- Added by Nosrac
function isArcaneIntellectActive()
	local SpellName = LOCALIZATION_ZORLEN.ArcaneIntellect
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isFrostArmorActive()
	local SpellName = LOCALIZATION_ZORLEN.FrostArmor
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isMageArmorActive()
	local SpellName = LOCALIZATION_ZORLEN.MageArmor
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
	local SpellName = LOCALIZATION_ZORLEN.ArcaneIntellect
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
	local SpellName = LOCALIZATION_ZORLEN.ArcaneIntellect
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








--Added By CodeMaster Rapture
function castArcaneExplosion(SpellRank, test)
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ArcaneExplosion
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castArcaneMissiles(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.ArcaneMissiles
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castBlastWave(SpellRank, test)
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.BlastWave
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castBlizzard(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Blizzard
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castFireBlast(SpellRank, test)
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.FireBlast
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castFireball(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Fireball
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castFlamestrike(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Flamestrike
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castFrostbolt(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Frostbolt
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castPyroblast(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Pyroblast
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function castScorch(SpellRank, test)
	if Zorlen_isMoving() then
		return false
	end
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.Scorch
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
function isFrostArmorActive()
	local SpellName = LOCALIZATION_ZORLEN.FrostArmor
	return Zorlen_checkBuffByName(SpellName)
end

--Added By CodeMaster Rapture
function isIceArmorActive()
	local SpellName = LOCALIZATION_ZORLEN.IceArmor
	return Zorlen_checkBuffByName(SpellName)
end

--Added By CodeMaster Rapture
function isMageArmorActive()
	local SpellName = LOCALIZATION_ZORLEN.MageArmor
	return Zorlen_checkBuffByName(SpellName)
end

--Added By CodeMaster Rapture
--Casts Frost/Ice Armor if it is not active
function castIceArmor(SpellRank, test)
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.IceArmor
	z.EnemyTargetNotNeeded = 1
	z.BuffName = z.SpellName

	if not Zorlen_Button[z.SpellName] then
		if not Zorlen_IsSpellKnown(z.SpellName) then
			z.SpellName = LOCALIZATION_ZORLEN.FrostArmor
			z.BuffName = z.SpellName
		else
			z.SpellCheckNotNeeded = 1
		end
	end

	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added By CodeMaster Rapture
--Casts Mage Armor if it is not active
function castMageArmor(SpellRank, test)
	local z = {}
	z.Rank = SpellRank
	z.Test = test
	z.SpellName = LOCALIZATION_ZORLEN.MageArmor
	z.EnemyTargetNotNeeded = 1
	z.BuffName = z.SpellName

	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Arcane Explosion based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_ArcaneExplosion(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castArcaneExplosion(SpellRank, test)
	end
	local z = {}
	z.Test = test
	local DamageList = { 33, 58, 98, 140, 187, 244 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.ArcaneExplosion
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Arcane Missles based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_ArcaneMissiles(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castArcaneMissiles(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 73, 145, 281, 416, 576, 756, 960, 1150 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.ArcaneMissiles
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Blast Wave based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_BlastWave(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castBlastWave(SpellRank, test)
	end
	local z = {}
	z.Test = test
	local DamageList = { 202, 278, 366, 463 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.BlastWave
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Blizzard based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Blizzard(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castBlizzard(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 201, 353, 521, 721, 937, 1193 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.Blizzard
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Fire Blast based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_FireBlast(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castFireBlast(SpellRank, test)
	end
	local z = {}
	z.Test = test
	local DamageList = { 25, 58, 104, 169, 243, 333, 432 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.FireBlast
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Fireball based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Fireball(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castFireball(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 17, 32, 54, 85, 140, 200, 256, 319, 393, 476, 562, 597 } 
	local TargetHealth = MobHealth_GetTargetCurHP()
	local iter = 0

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end
	z.SpellName = LOCALIZATION_ZORLEN.Fireball
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Flamestrike based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Flamestrike(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castFlamestrike(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 53, 97, 155, 221, 292, 376 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.Flamestrike
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Frostbolt based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Frostbolt(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castFrostbolt(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 19, 32, 52, 75, 127, 175, 228, 293, 354, 430, 516 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.Frostbolt
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Pyroblast based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Pyroblast(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castPyroblast(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 181, 256, 330, 408, 503, 601, 717 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.Pyroblast
	return Zorlen_CastCommonRegisteredSpell(z)
end

--Added by CodeMaster Rapture
--Casts Scorch based on target hitpoints for mana efficiency. Requires MobInfo2!!!
function cast_ManaEfficient_Scorch(SpellRank, test)
	if not IsAddOnLoaded("MobHealth2") then
		return castScorch(SpellRank, test)
	end
	local z = {}
	z.Test = test
	if Zorlen_isMoving() then
		return false
	end

	local DamageList = { 54, 78, 101, 134, 163, 201, 234 }
	local TargetHealth = MobHealth_GetTargetCurHP()

	if (TargetHealth) then
		for iter = 1, table.getn(DamageList) do
			if (TargetHealth < DamageList[iter]) then
				z.Rank = iter
				break
			end
		end
	end

	z.SpellName = LOCALIZATION_ZORLEN.Scorch
	return Zorlen_CastCommonRegisteredSpell(z)
end






