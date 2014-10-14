
Zorlen_Paladin_FileBuildNumber = 681

--[[
  Zorlen Library - Started by Marcus S. Zarra
 
  4.23
		isDevotionAuraActive() added by Nosrac
		isConcentrationAuraActive() added by Nosrac
		isFireResistanceAuraActive() added by Nosrac
		isFrostResistanceAuraActive() added by Nosrac
		isRetributionAuraActive() added by Nosrac
		isShadowResistanceAuraActive() added by Nosrac
		isSanctityAuraActive() added by Nosrac
		isPaladinResistanceAuraActive() added by Nosrac
		isPaladinAuraActive() added by Nosrac
		isBlessingOfFreedomActive() added by Nosrac
		isBlessingOfKingsActive() added by Nosrac
		isBlessingOfLightActive() added by Nosrac
		isBlessingOfMightActive() added by Nosrac
		isBlessingOfProtectionActive() added by Nosrac
		isBlessingOfSacrificeActive() added by Nosrac
		isBlessingOfSalvationActive() added by Nosrac
		isBlessingOfSanctuaryActive() added by Nosrac
		isBlessingOfWisdomActive() added by Nosrac
		isRegularBlessingActive() added by Nosrac
		isGreaterBlessingOfKingsActive() added by Nosrac
		isGreaterBlessingOfLightActive() added by Nosrac
		isGreaterBlessingOfMightActive() added by Nosrac
		isGreaterBlessingOfSalvationActive() added by Nosrac
		isGreaterBlessingOfSanctuaryActive() added by Nosrac
		isGreaterBlessingOfWisdomActive() added by Nosrac
		isGreaterBlessingActive() added by Nosrac
		isBlessingActive() added by Nosrac
		isSealOfCommandActive() added by Nosrac
		isSealOfJusticeActive() added by Nosrac
		isSealOfLightActive() added by Nosrac
		isSealOfRighteousnessActive() added by Nosrac
		isSealOfWisdomActive() added by Nosrac
		isSealOfTheCrusaderActive() added by Nosrac
		isSealActive() added by Nosrac
		isHolyShieldActive() added by Nosrac
		isHolyShieldActive() added by Nosrac
		isDivineProtectionActive() added by Nosrac
		isSenseUndeadActive() added by Nosrac
		isRighteousFuryActive() added by Nosrac

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]



--Added by Nosrac
function isDevotionAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_DevotionAura
	return Zorlen_checkBuffByName(SpellName)
end
	
--Added by Nosrac
function isConcentrationAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_ConcentrationAura
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isFireResistanceAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_FireResistanceAura
	return Zorlen_checkBuffByName(SpellName)
end


--Added by Nosrac
function isFrostResistanceAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_FrostResistanceAura
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isRetributionAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_RetributionAura
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isShadowResistanceAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_ShadowResistanceAura
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSanctityAuraActive()
	local SpellName = LOCALIZATION_ZORLEN_SanctityAura
	return Zorlen_checkBuffByName(SpellName)
end

function isPaladinResistanceAuraActive()
	if isShadowResistanceAuraActive() or isFrostResistanceAuraActive() or isFireResistanceAuraActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isPaladinAuraActive()
	if isPaladinResistanceAuraActive() or isSanctityAuraActive() or isRetributionAuraActive() or isDevotionAuraActive() or isConcentrationAuraActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isBlessingOfFreedomActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfFreedom
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfKingsActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfKings
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfLightActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfLight
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfMightActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfMight
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfProtectionActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfProtection
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfSacrificeActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfSacrifice
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfSalvationActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfSalvation
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfSanctuaryActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfSanctuary
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isBlessingOfWisdomActive()
	local SpellName = LOCALIZATION_ZORLEN_BlessingOfWisdom
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isRegularBlessingActive()
	if isBlessingOfFreedomActive() or isBlessingOfKingsActive() or isBlessingOfLightActive() or isBlessingOfMightActive() or isBlessingOfProtection() or isBlessingOfSacrificeActive() or isBlessingOfSalvationActive() or isBlessingOfSanctuaryActive() or isBlessingOfWisdomActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isGreaterBlessingOfKingsActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfKings
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingOfLightActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfLight
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingOfMightActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfMight
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingOfSalvationActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfSalvation
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingOfSanctuaryActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfSanctuary
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingOfWisdomActive()
	local SpellName = LOCALIZATION_ZORLEN_GreaterBlessingOfWisdom
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isGreaterBlessingActive()
	if isGreaterBlessingOfKingsActive() or isGreaterBlessingOfLightActive() or isGreaterBlessingOfMightActive() or isGreaterBlessingOfSalvationActive() or isGreaterBlessingOfSanctuaryActive() or isGreaterBlessingOfWisdomActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isBlessingActive()
	if isRegularBlessingActive() or isGreaterBlessingActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isSealOfCommandActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfCommand
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealOfJusticeActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfJustice
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealOfLightActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfLight
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealOfRighteousnessActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfRighteousness
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealOfWisdomActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfWisdom
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealOfTheCrusaderActive()
	local SpellName = LOCALIZATION_ZORLEN_SealOfTheCrusader
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSealActive()
	if isSealOfCommandActive() or isSealOfJusticeActive() or isSealOfLightActive() or isSealofRighteousnessActive() or isSealOfWisdomActive() or isSealOfTheCrusaderActive() then
		return true
	end
	return false
end

--Added by Nosrac
function isHolyShieldActive()
	local SpellName = LOCALIZATION_ZORLEN_HolyShield
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isDivineProtectionActive()
	local SpellName = LOCALIZATION_ZORLEN_DivineProtection
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isSenseUndeadActive()
	local SpellName = LOCALIZATION_ZORLEN_SenseUndead
	return Zorlen_checkBuffByName(SpellName)
end

--Added by Nosrac
function isRighteousFuryActive()
	local SpellName = LOCALIZATION_ZORLEN_RighteousFury
	return Zorlen_checkBuffByName(SpellName)
end

