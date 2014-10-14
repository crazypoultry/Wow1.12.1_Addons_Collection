
Zorlen_Shaman_FileBuildNumber = 681

--[[
  Zorlen Library - Started by Marcus S. Zarra
 
  4.23
		isRockbiterWeaponActive() added by Nosrac
		isFlametongueWeaponActive() added by Nosrac
		isFrostbrandWeaponActive() added by Nosrac
		isWindfuryWeaponActive() added by Nosrac
		isShamanWeaponBuffActive() added by Nosrac
		isFarsightActive() added by Nosrac
		isWaterBreathingActive() added by Nosrac
		isWaterWalkingActive() added by Nosrac
		isLightningShieldActive() added by Nosrac

  3.00  Rewrite by Wynn (Bleeding Hollow), break units into class functions.
		  
--]]


-- Added by Nosrac
function isRockbiterWeaponActive()
	local SpellName = LOCALIZATION_ZORLEN_RockbiterWeapon
	Zorlen_checkItemBuffByName(SpellName)
end

-- Added by Nosrac
function isFlametongueWeaponActive()
	local SpellName = LOCALIZATION_ZORLEN_FlametongueWeapon
	Zorlen_checkItemBuffByName(SpellName)
end

-- Added by Nosrac
function isFrostbrandWeaponActive()
	local SpellName = LOCALIZATION_ZORLEN_FrostbrandWeapon
	Zorlen_checkItemBuffByName(SpellName)
end

-- Added by Nosrac
function isWindfuryWeaponActive()
	local SpellName = LOCALIZATION_ZORLEN_WindfuryWeapon
	Zorlen_checkItemBuffByName(SpellName)
end

-- Added by Nosrac
function isShamanWeaponBuffActive()
	if isRockbiterWeaponActive() or isFlametongueWeaponActive() or isFrostbrandWeaponActive() or isWindfuryWeaponActive() then
		return true
	end
	return false
end

-- Added by Nosrac
function isFarsightActive()
	local SpellName = LOCALIZATION_ZORLEN_FarSight
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isWaterBreathingActive()
	local SpellName = LOCALIZATION_ZORLEN_WaterBreathing
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isWaterWalkingActive()
	local SpellName = LOCALIZATION_ZORLEN_WaterWalking
	return Zorlen_checkBuffByName(SpellName)
end

-- Added by Nosrac
function isLightningShieldActive()
	local SpellName = LOCALIZATION_ZORLEN_LightningShield
	return Zorlen_checkBuffByName(SpellName)
end

