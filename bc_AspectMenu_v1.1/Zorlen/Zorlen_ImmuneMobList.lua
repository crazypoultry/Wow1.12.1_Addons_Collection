
Zorlen_ImmuneMobList_FileBuildNumber = 648





function Zorlen_FireImmuneMobList()
	local name = UnitName("target")
	if name and not UnitIsPlayer("target") and not UnitIsPet("target") then
		if
		(name == LOCALIZATION_ZORLEN_Firelord) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_Firewalker) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_Flameguard) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_LavaSpawn) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_BaronGeddon) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_Ragnaros) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN_PyroguardEmberseer) -- Upper Blackrock Spire
		or
		(name == LOCALIZATION_ZORLEN_Fireguard) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_FireguardDestroyer) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_BlazingFireguard) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_AmbassadorFlamelash) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_LordIncendius) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_BlazingElemental) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN_InfernoElemental) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN_ScorchingElemental) -- Un'Goro Crater
		or
		(name == LOCALIZATION_ZORLEN_LivingBlaze) -- Un'Goro Crater
		or
		(name == LOCALIZATION_ZORLEN_Blazerunner) -- Un'Goro Crater
		then
			Zorlen_debug("Target is Immune to Fire: "..name);
			return true
		end
	end
	return false
end



function Zorlen_DrainLifeImmuneMobList()
	local name = UnitName("target")
	if name and not UnitIsPlayer("target") and not UnitIsPet("target") then
		if
		(name == LOCALIZATION_ZORLEN_MoltenWarGolem) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_PanzorTheInvincible) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN_HeavyWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN_FaultyWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN_TemperedWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN_RagereaverGolem) -- Searing Gorge
		then
			Zorlen_debug("Target is Immune to Drain Life: "..name);
			return true
		end
	end
	return false
end


