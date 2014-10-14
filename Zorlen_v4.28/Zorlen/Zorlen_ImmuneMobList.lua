
Zorlen_ImmuneMobList_FileBuildNumber = 683





function Zorlen_FireImmuneMobList()
	local name = UnitName("target")
	if name and not UnitIsPlayer("target") and not UnitIsPet("target") then
		if
		(name == LOCALIZATION_ZORLEN.Firelord) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.Firewalker) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.Flameguard) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.LavaSpawn) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.BaronGeddon) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.Ragnaros) -- Molten Core
		or
		(name == LOCALIZATION_ZORLEN.PyroguardEmberseer) -- Upper Blackrock Spire
		or
		(name == LOCALIZATION_ZORLEN.Fireguard) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.FireguardDestroyer) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.BlazingFireguard) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.AmbassadorFlamelash) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.LordIncendius) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.BlazingElemental) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN.InfernoElemental) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN.ScorchingElemental) -- Un'Goro Crater
		or
		(name == LOCALIZATION_ZORLEN.LivingBlaze) -- Un'Goro Crater
		or
		(name == LOCALIZATION_ZORLEN.Blazerunner) -- Un'Goro Crater
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
		(name == LOCALIZATION_ZORLEN.MoltenWarGolem) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.PanzorTheInvincible) -- Blackrock Depths
		or
		(name == LOCALIZATION_ZORLEN.HeavyWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN.FaultyWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN.TemperedWarGolem) -- Searing Gorge
		or
		(name == LOCALIZATION_ZORLEN.RagereaverGolem) -- Searing Gorge
		then
			Zorlen_debug("Target is Immune to Drain Life: "..name);
			return true
		end
	end
	return false
end


