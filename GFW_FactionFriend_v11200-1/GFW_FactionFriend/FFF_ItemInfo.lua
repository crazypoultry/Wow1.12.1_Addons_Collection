------------------------------------------------------
-- FFF_ItemInfo.lua
------------------------------------------------------
-- LOCALIZATION: nothing locale-specific here (the localized names are all in comments)
------------------------------------------------------

FFF_ZoneFactions = {
	["Horde"] = {
		[ZONE_AV] = FACTION_FROSTWOLF,
		[ZONE_AB] = FACTION_DEFILERS,
		[ZONE_WSG] = FACTION_WARSONG,
	},
	["Alliance"] = {
		[ZONE_AV] = FACTION_STORMPIKE,
		[ZONE_AB] = FACTION_ARATHOR,
		[ZONE_WSG] = FACTION_SILVERWING,
		[ZONE_HINTERLANDS] = FACTION_WILDHAMMER,
	},
	["Neutral"] = {
		[ZONE_SILITHUS] = FACTION_CENARION_CIRCLE,
		[ZONE_AQ20] = FACTION_CENARION_CIRCLE,
		[ZONE_AQ40] = FACTION_BROOD_NOZDORMU,
		[ZONE_ZG] = FACTION_ZANDALAR,
		[ZONE_WPL] = FACTION_ARGENT_DAWN,
		[ZONE_EPL] = FACTION_ARGENT_DAWN,
		[ZONE_STRATHOLME] = FACTION_ARGENT_DAWN,
		[ZONE_SCHOLOMANCE] = FACTION_ARGENT_DAWN,
		[ZONE_NAXXRAMAS] = FACTION_ARGENT_DAWN,
		[ZONE_FELWOOD] = FACTION_TIMBERMAW,
		[ZONE_WINTERSPRING] = FACTION_TIMBERMAW,
	},
};

FFF_ItemInfo = {
	-- TODO: need to figure out how faction reward scales with level for these
	--[[
	[FACTION_WILDHAMMER] = {
		TrollNecklaceBounty = {
			value = 25,		-- scales to 2.5 at lvl 60
			level = 45,
			items = {
				[9259] = 1,	-- Troll Tribal Necklace
			},
		},
	},
	[FACTION_GADGETZAN] = {
		WaterPouchBounty = {
			value = 10,		-- ?? unverified
			level = 44,
			items = {
				[8483] = 1,	-- Wastewander Water Pouch
			},
		},
	},
	]]

	-- TODO: morrowgrain turnins for darnassus/thunderbluff?
	-- may also need level scaling	
	
	-- Racial factions: Horde
	[FACTION_FORSAKEN] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21438] = 10,	-- Horde Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21438] = 1,	-- Horde Commendation Signet
			},
		},
	},
	[FACTION_TROLL] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21438] = 10,	-- Horde Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21438] = 1,	-- Horde Commendation Signet
			},
		},
	},
	[FACTION_TAUREN] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21438] = 10,	-- Horde Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21438] = 1,	-- Horde Commendation Signet
			},
		},
	},
	[FACTION_ORC] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},
		
		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21436] = 10,	-- Alliance Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21436] = 1,	-- Alliance Commendation Signet
			},
		},

		-- AV turnins
		RiderHarnesses = {
			value = 10,
			items = {
				[17642] = 1,	-- Alterac Ram Hide
			},
		},
		BossSummonGroup = {
			value = 50,
			items = {
				[17306] = 5,	-- Stormpike Soldier's Blood
			},
		},
		BossSummonSingle = {
			value = 10,
			items = {
				[17306] = 1,	-- Stormpike Soldier's Blood
			},
		},
		ArmorScraps = {
			value = 10,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		FirstAirstrike = {
			value = 10,
			items = {
				[17326] = 1,	-- Stormpike Soldier's Flesh
			},
		},
		SecondAirstrike = {
			value = 10,
			items = {
				[17327] = 1,	-- Stormpike Lieutenant's Flesh
			},
		},
		ThirdAirstrike = {
			value = 10,
			items = {
				[17328] = 1,	-- Stormpike Commander's Flesh
			},
		},
	},
	
	-- Racial factions: Alliance
	[FACTION_HUMAN] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21436] = 10,	-- Alliance Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21436] = 1,	-- Alliance Commendation Signet
			},
		},
	},
	[FACTION_GNOME] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21436] = 10,	-- Alliance Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21436] = 1,	-- Alliance Commendation Signet
			},
		},
	},
	[FACTION_NELF] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},

		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21436] = 10,	-- Alliance Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21436] = 1,	-- Alliance Commendation Signet
			},
		},
	},
	[FACTION_DWARF] = {
		Runecloth = {
			value = 50,
			items = {
				[14047] = 20,	-- Runecloth
			},
		},
		
		-- AQ war effort turnins
		CommendationSignet_10 = {
			value = 75,
			items = {
				[21436] = 10,	-- Alliance Commendation Signet
			},
		},
		CommendationSignet_01 = {
			value = 5,
			items = {
				[21436] = 1,	-- Alliance Commendation Signet
			},
		},

		-- AV turnins
		RiderHarnesses = {
			value = 10,
			items = {
				[17643] = 1,	-- Frostwolf Hide
			},
		},
		BossSummonGroup = {
			value = 50,
			items = {
				[17423] = 5,	-- Storm Crystal
			},
		},
		BossSummonSingle = {
			value = 10,
			items = {
				[17423] = 1,	-- Storm Crystal
			},
		},
		ArmorScraps = {
			value = 10,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		FirstAirstrike = {
			value = 10,
			items = {
				[17502] = 1,	-- Frostwolf Soldier's Medal
			},
		},
		SecondAirstrike = {
			value = 10,
			items = {
				[17503] = 1,	-- Frostwolf Lieutenant's Medal
			},
		},
		ThirdAirstrike = {
			value = 10,
			items = {
				[17504] = 1,	-- Frostwolf Commander's Medal
			},
		},
	},
	
	-- BG factions
	[FACTION_FROSTWOLF] = {
		RiderHarnesses = {
			value = 1,
			items = {
				[17642] = 1,	-- Alterac Ram Hide
			},
		},
		BossSummonGroup = {
			value = 5,
			items = {
				[17306] = 5,	-- Stormpike Soldier's Blood
			},
		},
		BossSummonSingle = {
			value = 1,
			items = {
				[17306] = 1,	-- Stormpike Soldier's Blood
			},
		},
		ArmorScraps = {
			value = 1,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		FirstAirstrike = {
			value = 1,
			items = {
				[17326] = 1,	-- Stormpike Soldier's Flesh
			},
		},
		SecondAirstrike = {
			value = 2,
			items = {
				[17327] = 1,	-- Stormpike Lieutenant's Flesh
			},
		},
		ThirdAirstrike = {
			value = 3,
			items = {
				[17328] = 1,	-- Stormpike Commander's Flesh
			},
		},
	},
	[FACTION_STORMPIKE] = {
		RiderHarnesses = {
			value = 1,
			items = {
				[17643] = 1,	-- Frostwolf Hide
			},
		},
		BossSummonGroup = {
			value = 5,
			items = {
				[17423] = 5,	-- Storm Crystal
			},
		},
		BossSummonSingle = {
			value = 1,
			items = {
				[17423] = 1,	-- Storm Crystal
			},
		},
		ArmorScraps = {
			value = 1,
			items = {
				[17422] = 20,	-- Armor Scraps
			},
		},
		FirstAirstrike = {
			value = 1,
			items = {
				[17502] = 1,	-- Frostwolf Soldier's Medal
			},
		},
		SecondAirstrike = {
			value = 2,
			items = {
				[17503] = 1,	-- Frostwolf Lieutenant's Medal
			},
		},
		ThirdAirstrike = {
			value = 3,
			items = {
				[17504] = 1,	-- Frostwolf Commander's Medal
			},
		},
	},

	-- Other factions
	[FACTION_DARKMOON] = {
		SmallFurryPaw = {
			value = 100,
			maxStanding = 4,
			maxValue = 500, 
			items = {
				[5134] = 5,		-- Small Furry Paw
			},
		},
		TornBearPelt = {
			value = 100,
			maxStanding = 4,
			maxValue = 1100, 
			items = {
				[11407] = 5,	-- Torn Bear Pelt
			},
		},
		SoftBushyTail = {
			value = 100,
			maxStanding = 4,
			maxValue = 1700, 
			items = {
				[4582] = 5,		-- Soft Bushy Tail
			},
		},
		VibrantPlume = {
			value = 100,
			maxStanding = 4,
			maxValue = 2500, 
			items = {
				[5117] = 5,		-- Vibrant Plume
			},
		},
		EvilBatEye = {
			value = 100,
			items = {
				[11404] = 10,	-- Evil Bat Eye
			},
		},
		GlowingScorpidBlood = {
			value = 100,
			items = {
				[19933] = 10,	-- Glowing Scorpid Blood
			},
		},

		CoarseWeightstone = {
			value = 100,
			maxStanding = 4,
			maxValue = 500, 
			items = {
				[3240] = 10,	-- Coarse Weightstone
			},
		},
		HeavyGrindingStone = {
			value = 100,
			maxStanding = 4,
			maxValue = 1100, 
			items = {
				[3486] = 7,		-- Heavy Grinding Stone
			},
		},
		GreenIronBracers = {
			value = 100,
			maxStanding = 4,
			maxValue = 1700, 
			items = {
				[3835] = 3,		-- Green Iron Bracers
			},
		},
		BigBlackMace = {
			value = 100,
			maxStanding = 4,
			maxValue = 2500, 
			items = {
				[7945] = 1,		-- Big Black Mace
			},
		},
		DenseGrindingStone = {
			value = 100,
			items = {
				[12644] = 8,	-- Dense Grinding Stone
			},
		},

		CopperModulator = {
			value = 100,
			maxStanding = 4,
			maxValue = 500, 
			items = {
				[4363] = 5,		-- Copper Modulator
			},
		},
		WhirringBronzeGizmo = {
			value = 100,
			maxStanding = 4,
			maxValue = 1100, 
			items = {
				[4375] = 7,		-- Whirring Bronzze Gizmo
			},
		},
		GreenFirework = {
			value = 100,
			maxStanding = 4,
			maxValue = 1700, 
			items = {
				[9313] = 36,	-- Green Firework
			},
		},
		MechanicalRepairKit = {
			value = 100,
			maxStanding = 4,
			maxValue = 2500, 
			items = {
				[11590] = 6,	-- Mechanical Repair Kit
			},
		},
		ThoriumWidget = {
			value = 100,
			items = {
				[15994] = 6,	-- Thorium Widget
			},
		},

		EmbossedLeatherBoots = {
			value = 100,
			maxStanding = 4,
			maxValue = 500, 
			items = {
				[2309] = 3,	-- Embossed Leather Boots
			},
		},
		ToughenedLeatherArmor = {
			value = 100,
			maxStanding = 4,
			maxValue = 1100, 
			items = {
				[2314] = 3,	-- Toughened Leather Armor
			},
		},
		BarbaricHarness = {
			value = 100,
			maxStanding = 4,
			maxValue = 1700, 
			items = {
				[5739] = 3,	-- Barbaric Harness
			},
		},
		TurtleScaleLeggings = {
			value = 100,
			maxStanding = 4,
			maxValue = 2500, 
			items = {
				[8185] = 1,	-- Turtle Scale Leggings
			},
		},
		RuggedArmorKit = {
			value = 100,
			items = {
				[15564] = 8,	-- Rugged Armor Kit
			},
		},
	},
	[FACTION_ZANDALAR] = {
		RedBijou = {
			value = 75,
			items = {
				[19707] = 1,		-- Red Hakkari Bijou
			},
		},
		BlueBijou = {
			value = 75,
			items = {
				[19708] = 1,		-- Blue Hakkari Bijou
			},
		},
		YellowBijou = {
			value = 75,
			items = {
				[19709] = 1,		-- Yellow Hakkari Bijou
			},
		},
		OrangeBijou = {
			value = 75,
			items = {
				[19710] = 1,		-- Orange Hakkari Bijou
			},
		},
		GreenBijou = {
			value = 75,
			items = {
				[19711] = 1,		-- Green Hakkari Bijou
			},
		},
		PurpleBijou = {
			value = 75,
			items = {
				[19712] = 1,		-- Purple Hakkari Bijou
			},
		},
		BronzeBijou = {
			value = 75,
			items = {
				[19713] = 1,		-- Bronze Hakkari Bijou
			},
		},
		SilverBijou = {
			value = 75,
			items = {
				[19714] = 1,		-- Silver Hakkari Bijou
			},
		},
		GoldBijou = {
			value = 75,
			items = {
				[19715] = 1,		-- Gold Hakkari Bijou
			},
		},

		ZulianRazzashiHakkariCoins = {
			value = 25,
			items = {
				[19698] = 1,	-- Zulian Coin
				[19699] = 1,	-- Razzashi Coin
				[19700] = 1,	-- Hakkari Coin
			},
		},
		GurubashiVilebranchWitherbarkCoins = {
			value = 25,
			items = {
				[19701] = 1,	-- Gurubashi Coin
				[19702] = 1,	-- Vilebranch Coin
				[19703] = 1,	-- Witherbark Coin
			},
		},
		SandfurySkullsplitterBloodscalpCoins = {
			value = 25,
			items = {
				[19704] = 1,	-- Sandfury Coin
				[19705] = 1,	-- Skullsplitter Coin
				[19706] = 1,	-- Bloodscalp Coin
			},
		},
		
		UseHonorTokens = {
			value = 50,
			useItem = 1,
			items = {
				[19858] = 1,	-- Zandalar Honor Token
			},
		},
	},
	[FACTION_BROOD_NOZDORMU] = {
		MortalChampions = {
			value = 500,
			items = {
				[21229] = 1,	-- Qiraji Lord's Insignia
			},
		},
		SecretsOfTheQiraji = {
			value = 1000,
			items = {
				[21230] = 1,	-- Ancient Qiraji Artifact
			},
		},
	},
	[FACTION_CENARION_CIRCLE] = {
		MortalChampions = {
			value = 100,
			items = {
				[21229] = 1,	-- Qiraji Lord's Insignia
			},
		},

		AbyssalCrests = {
			value = 50,
			items = {
				[20513] = 3,	-- Abyssal Crest
			},
		},
		AbyssalSignets = {
			value = 100,
			items = {
				[20514] = 3,	-- Abyssal Signet
			},
		},
		AbyssalScepters = {
			value = 150,
			items = {
				[20515] = 3,	-- Abyssal Scepter
			},
		},
		
		TwilightTexts = {
			value = 100,
			items = {
				[20404] = 10,	-- Encrypted Twilight Text
			},
		},

	},
	[FACTION_ARGENT_DAWN] = {
		CryptFiendParts = {
			value = 10,
			minStanding = 5,
			items = {
				[22525] = 30,	-- Crypt Fiend Parts
			},
		},
		BoneFragments = {
			value = 10,
			minStanding = 5,
			items = {
				[22526] = 30,	-- Bone Fragments
			},
		},
		CoresOfElements = {
			value = 10,
			minStanding = 5,
			items = {
				[22527] = 30,	-- Core of Elements
			},
		},
		DarkIronScraps = {
			value = 10,
			minStanding = 5,
			items = {
				[22528] = 30,	-- Dark Iron Scraps
			},
		},
		SavageFronds = {
			value = 10,
			minStanding = 5,
			items = {
				[22529] = 30,	-- Savage Frond
			},
		},

		Cauldron1_GahrronsWithering = {
			value = 25,
			items = {
				[13354] = 4,	-- Ectoplasmic Resonator
				[14047] = 4,	-- Runecloth
			},
		},
		Cauldron2_DalsonsTears = {
			value = 25,
			items = {
				[13356] = 5,	-- Somatic Intensifier
				[14047] = 4,	-- Runecloth
			},
		},
		Cauldron3_WrithingHaunt = {
			value = 25,
			items = {
				[13356] = 5,	-- Somatic Intensifier
				[14047] = 4,	-- Runecloth
			},
		},
		Cauldron4_FelstoneField = {
			value = 15,
			items = {
				[13357] = 6,	-- Osseous Agitator
				[14047] = 4,	-- Runecloth
			},
		},

		MinionsScourgestones = {
			value = 25,
			items = {
				[12840] = 20,	-- Minion's Scourgestone
			},
		},
		InvadersScourgestones = {
			value = 25,
			items = {
				[12841] = 10,	-- Invader's Scourgestone
			},
		},
		CorruptorsScourgestones = {
			value = 25,
			items = {
				[12843] = 1,	-- Corruptor's Scourgestone
			},
		},

		UseValorTokens = {
			value = 25,
			useItem = 1,
			items = {
				[12844] = 1,	-- Argent Dawn Valor Token
			},
		},
		HealthyDragonScale = {
			value = 50,
			items = {
				[13920] = 1,	-- Healthy Dragon Scale
			},
		},
	},
	[FACTION_TIMBERMAW] = {
		WinterfallBeads = {
			value = 50,
			items = {
				[21383] = 5,	-- Winterfall Spirit Beads
			},
		},
		DeadwoodFeathers = {
			value = 50,
			items = {
				[21377] = 5,	-- Deadwood Headdress Feather
			},
		},
		WinterfallTotem = {
			value = 150,
			items = {
				[20742] = 1,	-- Winterfall Ritual Totem
			},
		},
		DeadwoodTotem = {
			value = 150,
			items = {
				[20741] = 1,	-- Deadwood Ritual Totem
			},
		},
	},
	[FACTION_THORIUM_BROTHERHOOD] = {
		FieryFluxLeather = {
			value = 25,
			minStanding = 4,
			maxStanding = 4, 
			items = {
				[4234] = 10,	-- Heavy Leather
				[18944] = 2,	-- Incendosaur Scale
			},
		},
		FieryFluxKingsblood = {
			value = 25,
			minStanding = 4,
			maxStanding = 4, 
			items = {
				[3356] = 4,		-- Kingsblood
				[18944] = 2,	-- Incendosaur Scale
			},
		},
		FieryFluxIron = {
			value = 25,
			minStanding = 4,
			maxStanding = 4, 
			items = {
				[3575] = 4,		-- Iron Bar
				[18944] = 2,	-- Incendosaur Scale
			},
		},
		DarkIronResidue = {
			value = 25,
			minStanding = 5,
			maxStanding = 5, 
			items = {
				[18945] = 4,	-- Dark Iron Residue
			},
		},
		DarkIronOre = {
			value = 50,
			items = {
				[11370] = 10,	-- Dark Iron Ore
			},
		},
		CoreLeather = {
			value = 150,
			items = {
				[17012] = 2,	-- Core Leather
			},
		},
		FieryCore = {
			value = 200,
			items = {
				[17010] = 1,	-- Fiery Core
			},
		},
		LavaCore = {
			value = 200,
			items = {
				[17011] = 1,	-- Lava Core
			},
		},
		BloodOfTheMountain = {
			value = 200,
			items = {
				[11382] = 1,	-- Blood of the Mountain
			},
		},
	},
};



