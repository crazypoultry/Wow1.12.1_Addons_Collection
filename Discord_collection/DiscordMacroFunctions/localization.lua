DMF_SLOTS = { "HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "RangedSlot", "AmmoSlot" };

DMF_TEXT = {
	Beast = "Beast",
	Demon = "Demon",
	Elemental = "Elemental",
	Humanoid = "Humanoid",
	Undead = "Undead",
	Dragonkin = "Dragonkin",
	Critter = "Critter",
	LevelTooLow = "Level too low for any rank.",
	Rank = "Rank ",
}

DMF_MINLVL_SPELLS = {
		AbolishDisease = "Abolish Disease",
		AbolishPoison = "Abolish Poison",
		AmplifyMagic = "Amplify Magic",
		ArcaneIntellect = "Arcane Intellect",
		Blessing = "Blessing of",
		BlessingFreedom = "Blessing of Freedom",
		BlessingKings = "Blessing of Kings",
		BlessingLight = "Blessing of Light",
		BlessingMight = "Blessing of Might",
		BlessingProtection = "Blessing of Protection",
		BlessingSacrifice = "Blessing of Sacrifice",
		BlessingSalvation = "Blessing of Salvation",
		BlessingSanctuary = "Blessing of Sanctuary",
		BlessingWisdom = "Blessing of Wisdom",
		DampenMagic = "Dampen Magic",
		DesperatePrayer = "Desperate Prayer",
		DispelMagic = "Dispel Magic",
		DivineSpirit = "Divine Spirit",
		MarkOfTheWild = "Mark of the Wild",
		PWFortitude = "Power Word: Fortitude",
		PWShield = "Power Word: Shield",
		Regrowth = "Regrowth",
		Rejuvenation = "Rejuvenation",
		Renew = "Renew",
		ShadowProtection = "Shadow Protection",
		Thorns = "Thorns"
	};

DMF_TARGET_SPELLS = {
		["Banish"] = { [DMF_TEXT.Demon] = true, [DMF_TEXT.Elemental] = true },
		["Beast Lore"] = { [DMF_TEXT.Beast] = true },
		["Enslave Demon"] = { [DMF_TEXT.Demon] = true },
		["Exorcism"] = { [DMF_TEXT.Undead] = true },
		["Hibernate"] = { [DMF_TEXT.Dragonkin] = true, [DMF_TEXT.Beast] = true },
		["Mind Control"] = { [DMF_TEXT.Humanoid] = true },
		["Mind Soothe"] = { [DMF_TEXT.Humanoid] = true },
		["Polymorph"] = { [DMF_TEXT.Humanoid] = true, [DMF_TEXT.Beast] = true, [DMF_TEXT.Critter] = true },
		["Sap"] = { [DMF_TEXT.Humanoid] = true },
		["Scare Beast"] = { [DMF_TEXT.Beast] = true },
		["Shackle Undead"] = { [DMF_TEXT.Undead] = true },
		["Soothe Animal"] = { [DMF_TEXT.Beast] = true },
		["Turn Undead"] = { [DMF_TEXT.Undead] = true },
		["Holy Wrath"] = { [DMF_TEXT.Undead] = true },
		["Viper Sting"] = { "MANA" },
		[DMF_MINLVL_SPELLS.PWShield] = { "PARTY" },
		["Curse of Doom"] = { "PLAYER" },
		["Mana Burn"] = { "MANA" }, 
		["Counterspell"] = { "MANA" },
		["Silence"] = { "MANA" }
	};



if (GetLocale() == "deDE") then
	DMF_TEXT = {
		Beast = "Wildtier",
		Demon = "D\195\164mon",
		Elemental = "Elementargeist",
		Humanoid = "Humanoid",
		Undead = "Untoter",
		Dragonkin = "Drachkin",
		Critter = "Critter",
		LevelTooLow = "Level too low for any rank.",
		Rank = "Rang ",
	};

	DMF_MINLVL_SPELLS = {
		AbolishDisease = "Krankheit aufheben",
		AbolishPoison = "Vergiftung heilen",
		AmplifyMagic = "Magie verst\195\164rken",
		ArcaneIntellect = "Arkane Intelligenz",
		Blessing = "Segen",
		BlessingFreedom = "Segen der Freiheit",
		BlessingKings = "Segen der K\195\182nige",
		BlessingLight = "Segen des Lichts",
		BlessingMight = "Segen der Macht",
		BlessingProtection = "Segen des Schutzes",
		BlessingSacrifice = "Segen der Opferung",
		BlessingSalvation = "Segen der Rettung",
		BlessingSanctuary = "Segen des Refugiums",
		BlessingWisdom = "Segen der Weisheit",
		DampenMagic = "Magied\195\164mpfer",
		DesperatePrayer = "Verzweifeltes Gebet",
		DispelMagic = "Magiebannung",
		DivineSpirit = "G\195\182ttlicher Willen",
		MarkOfTheWild = "Mal der Wildnis",
		PWFortitude = "Machtwort: Seelenst\195\164rke",
		PWShield = "Machtwort: Schild",
		Regrowth = "Nachwachsen",
		Rejuvenation = "Verj\195\188ngung",
		Renew = "Erneuerung",
		ShadowProtection = "Schattenschutz",
		Thorns = "Dornen"
	};

	DMF_TARGET_SPELLS = {
			["Verbannen"] = { [DMF_TEXT.Demon] = true, [DMF_TEXT.Elemental] = true },
			["Wildtierlehre"] = { [DMF_TEXT.Beast] = true },
			["D\195\164monensklave"] = { [DMF_TEXT.Demon] = true },
			["Exorzismus"] = { [DMF_TEXT.Undead] = true },
			["Winterschlaf"] = { [DMF_TEXT.Dragonkin] = true, [DMF_TEXT.Beast] = true },
			["Gedankenkontrolle"] = { [DMF_TEXT.Humanoid] = true },
			["Gedankenbes\195\164nftigung"] = { [DMF_TEXT.Humanoid] = true },
			["Verwandlung"] = { [DMF_TEXT.Humanoid] = true, [DMF_TEXT.Beast] = true, [DMF_TEXT.Critter] = true },
			["Kopfnuss"] = { [DMF_TEXT.Humanoid] = true },
			["Wildtier aufscheuchen"] = { [DMF_TEXT.Beast] = true },
			["Untote fesseln"] = { [DMF_TEXT.Undead] = true },
			["Tier bes\195\164nftigen"] = { [DMF_TEXT.Beast] = true },
			["Untote vertreiben"] = { [DMF_TEXT.Undead] = true },
			["Holy Wrath"] = { [DMF_TEXT.Undead] = true },
			["Schlangenbiss"] = { "MANA" },
			[DMF_MINLVL_SPELLS.PWShield] = { "PARTY" },
			["Fluch der Verdammnis"] = { "PLAYER" },
			["Manabrand"] = { "MANA" }, 
			["Counterspell"] = { "MANA" },
			["Silence"] = { "MANA" }
		};
end





if (GetLocale() == "frFR") then
	DMF_TEXT = {
		Beast = "B\195\168te",
		Demon = "D\195\169mon",
		Elemental = "El\195\169mentaire",
		Humanoid = "Humano\195\175de",
		Undead = "Mort-vivant",
		Dragonkin = "Drachkin",
		Critter = "Critter",
		LevelTooLow = "Level too low for any rank.",
		Rank = "Rang ",
	};

	DMF_MINLVL_SPELLS = {
		AbolishDisease = "Abolir maladie",
		AbolishPoison = "Abolish Poison",
		AmplifyMagic = "Amplifier la magie",
		ArcaneIntellect = "Intelligence des arcanes",
		Blessing = "B\195\169n\195\169diction",
		BlessingFreedom = "B\195\169n\195\169diction de libert\195\169",
		BlessingKings = "B\195\169n\195\169diction des Rois",
		BlessingLight = "B\195\169n\195\169diction de lumi\195\168re",
		BlessingMight = "B\195\169n\195\169diction de puissance",
		BlessingProtection = "B\195\169n\195\169diction de protection",
		BlessingSacrifice = "B\195\169n\195\169diction de sacrifice",
		BlessingSalvation = "B\195\169n\195\169diction de salut",
		BlessingSanctuary = "B\195\169n\195\169diction du sanctuaire",
		BlessingWisdom = "B\195\169n\195\169diction de sagesse",
		DampenMagic = "Att\195\169nuer la magie",
		DesperatePrayer = "Pri\195\168re d\195\169sesp\195\169e",
		DispelMagic = "Dissiper la magie",
		DivineSpirit = "Esprit divin",
		MarkOfTheWild = "Marque de la nature",
		PWFortitude = "Mot de pouvoir : Robustesse",
		PWShield = "Mot de pouvoir : Bouclier",
		Regrowth = "R\195\169tablissement",
		Rejuvenation = "R\195\169cup\195\169ration",
		Renew = "R\195\169novation",
		ShadowProtection = "Protection contre l'ombre",
		Thorns = "Epines"
	}; 

	DMF_TARGET_SPELLS = {
		["Bannir"] = { [DMF_TEXT.Demon] = true, [DMF_TEXT.Elemental] = true },
		["Connaissance des b\195\170tes"] = { [DMF_TEXT.Beast] = true },
		["Asservir d\195\169mon"] = { [DMF_TEXT.Demon] = true },
		["Exorcisme"] = { [DMF_TEXT.Undead] = true },
		["Hibernation"] = { [DMF_TEXT.Dragonkin] = true, [DMF_TEXT.Beast] = true },
		["Contr\195\180le mental"] = { [DMF_TEXT.Humanoid] = true },
		["Apaisement"] = { [DMF_TEXT.Humanoid] = true },
		["Polymorphe"] = { [DMF_TEXT.Humanoid] = true, [DMF_TEXT.Beast] = true, ["Critter"] = true },
		["Assommer"] = { [DMF_TEXT.Humanoid] = true },
		["Effrayer une b\195\170te"] = { [DMF_TEXT.Beast] = true },
		["Entraves des morts-vivants"] = { [DMF_TEXT.Undead] = true },
		["Apaiser les animaux"] = { [DMF_TEXT.Beast] = true },
		["Renvoi des morts-vivants"] = { [DMF_TEXT.Undead] = true },
		["Holy Wrath"] = { [DMF_TEXT.Undead] = true },
		["Piq\195\187re de vip\195\168re"] = { "MANA" },
		[DMF_MINLVL_SPELLS.PWShield] = { "PARTY" },
		["Mal\195\169diction funeste"] = { "PLAYER" },
		["Br\195\187lure de mana"] = { "MANA" }, 
		["Counterspell"] = { "MANA" },
		["Silence"] = { "MANA" }
	};
end