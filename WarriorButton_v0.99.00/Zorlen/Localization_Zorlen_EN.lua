-- English Translation
-- If you want to translate this to another language, make sure the names of buffs and abilities are *EXACTLY* the same as in-game. Spelling, punctuation, upper/lowercase letters, etc. MUST BE EXACT. Also, any 'foreign' characters must be converted to UNICODE.
-- Unicode resource:  http://www.allegro-c.de/unicode/zcodes.htm


-- To lower the upkeep we will not be adding Localization for english words that do not break compatibility in other game clients.
-- This Localization is only added for compatibility so that it may work in non english game clients and not as a translation.


-- All file Localization
	LOCALIZATION_ZORLEN_Rank = "Rank";
	LOCALIZATION_ZORLEN_sit = "sit";
	LOCALIZATION_ZORLEN_You_dodge = "You dodge";
	LOCALIZATION_ZORLEN_Your = "Your";
	LOCALIZATION_ZORLEN_immune = "immune";
	LOCALIZATION_ZORLEN_no_weapons_equipped = "no weapons equipped";
	LOCALIZATION_ZORLEN_dodged = "dodged";
	LOCALIZATION_ZORLEN_dodges = "dodges";
	LOCALIZATION_ZORLEN_pet_is_not_dead = "pet is not dead";
	LOCALIZATION_ZORLEN_pet_is_dead = "pet is dead";
	
	LOCALIZATION_ZORLEN_PlusHealMinScan = "%+(%d+).+Healing Spells";
	LOCALIZATION_ZORLEN_PlusHealMaxScan = "%+%d+%-(%d+).+Healing Spells";
	LOCALIZATION_ZORLEN_VariableHealScanEquip = "^Equip:.*Increases.*healing.*spells.*by up to (%d+).";
	LOCALIZATION_ZORLEN_VariableHealScanSet = "^Set.*Increases.*healing.*spells.*by up to (%d+).";

-- Example: /script Zorlen_GiveName_OffHandType()
-- The example above will give the name required for LOCALIZATION_ZORLEN_Shields
-- You must have a shield equipped to get the correct name.
-- You can also get the correct name from the auction house filters under the Armor section.
	LOCALIZATION_ZORLEN_Shields = "Shields";
	
-- Example: /script Zorlen_GiveName_MainHandType()
-- The example above will give the name required for the weapons below.
-- You must have the weapon equipped to get the correct name.
-- You can also get the correct names from the auction house filters under the Weapon section.
	LOCALIZATION_ZORLEN_Daggers = "Daggers";
	LOCALIZATION_ZORLEN_OneHandedSwords = "One-Handed Swords";
	LOCALIZATION_ZORLEN_TwoHandedSwords = "Two-Handed Swords";
	LOCALIZATION_ZORLEN_OneHandedAxes = "One-Handed Axes";
	LOCALIZATION_ZORLEN_TwoHandedAxes = "Two-Handed Axes";
	LOCALIZATION_ZORLEN_OneHandedMaces = "One-Handed Maces";
	LOCALIZATION_ZORLEN_TwoHandedMaces = "Two-Handed Maces";
	LOCALIZATION_ZORLEN_Polearms = "Polearms";
	LOCALIZATION_ZORLEN_Staves = "Staves";
	LOCALIZATION_ZORLEN_FistWeapons = "Fist Weapons";
	LOCALIZATION_ZORLEN_FishingPole = "Fishing Pole";



-- Zorlen_Other.lua file Localization
	LOCALIZATION_ZORLEN_Attack = "Attack";
	LOCALIZATION_ZORLEN_Throw = "Throw";
	LOCALIZATION_ZORLEN_ShootBow = "Shoot Bow";
	LOCALIZATION_ZORLEN_ShootCrossbow = "Shoot Crossbow";
	LOCALIZATION_ZORLEN_ShootGun = "Shoot Gun";
	LOCALIZATION_ZORLEN_Shoot = "Shoot";
-- Human Racial
	LOCALIZATION_ZORLEN_Perception = "Perception";
-- Dwarf Racial
	LOCALIZATION_ZORLEN_FindTreasure = "Find Treasure";
	LOCALIZATION_ZORLEN_Stoneform = "Stoneform";
-- Gnome Racial
	LOCALIZATION_ZORLEN_EscapeArtist = "Escape Artist";
-- Night Elf Racial
	LOCALIZATION_ZORLEN_Shadowmeld = "Shadowmeld";
-- Orc Racial
	LOCALIZATION_ZORLEN_BloodFury = "Blood Fury";
-- Undead Racial
	LOCALIZATION_ZORLEN_Cannibalize = "Cannibalize";
	LOCALIZATION_ZORLEN_WillOfTheForsaken = "Will of the Forsaken";
-- Tauren Racial
	LOCALIZATION_ZORLEN_WarStomp = "War Stomp";
-- Troll Racial
	LOCALIZATION_ZORLEN_Berserking = "Berserking";



-- Zorlen_Pets.lua file Localization
-- Hunter Pets
	LOCALIZATION_ZORLEN_Dash = "Dash";
	LOCALIZATION_ZORLEN_Dive = "Dive";
	LOCALIZATION_ZORLEN_Bite = "Bite";
	LOCALIZATION_ZORLEN_Claw = "Claw";
	LOCALIZATION_ZORLEN_Cower = "Cower";
	LOCALIZATION_ZORLEN_Growl = "Growl";
	LOCALIZATION_ZORLEN_Prowl = "Prowl";
	LOCALIZATION_ZORLEN_Charge = "Charge";
	LOCALIZATION_ZORLEN_Screech = "Screech";
	LOCALIZATION_ZORLEN_FuriousHowl = "Furious Howl";
	LOCALIZATION_ZORLEN_LightningBreath = "Lightning Breath";
	LOCALIZATION_ZORLEN_ShellShield = "Shell Shield";
	LOCALIZATION_ZORLEN_Thunderstomp = "Thunderstomp";
	LOCALIZATION_ZORLEN_ScorpidPoison = "Scorpid Poison";
-- Warlock Pets
	LOCALIZATION_ZORLEN_BloodPact = "Blood Pact";
	LOCALIZATION_ZORLEN_FireShield = "Fire Shield";
	LOCALIZATION_ZORLEN_Firebolt = "Firebolt";
	LOCALIZATION_ZORLEN_PhaseShift = "Phase Shift";
	LOCALIZATION_ZORLEN_ConsumeShadows = "Consume Shadows";
	LOCALIZATION_ZORLEN_Sacrifice = "Sacrifice";
	LOCALIZATION_ZORLEN_Suffering = "Suffering";
	LOCALIZATION_ZORLEN_Torment = "Torment";
	LOCALIZATION_ZORLEN_DevourMagic = "Devour Magic";
	LOCALIZATION_ZORLEN_Paranoia = "Paranoia";
	LOCALIZATION_ZORLEN_SpellLock = "Spell Lock";
	LOCALIZATION_ZORLEN_TaintedBlood = "Tainted Blood";
	LOCALIZATION_ZORLEN_LashOfPain = "Lash of Pain";
	LOCALIZATION_ZORLEN_Seduction = "Seduction";
	LOCALIZATION_ZORLEN_SoothingKiss = "Soothing Kiss";
	LOCALIZATION_ZORLEN_LesserInvisibility = "Lesser Invisibility";



-- Zorlen_Hunter.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedAspectOfTheHawk = "Improved Aspect of the Hawk";
	LOCALIZATION_ZORLEN_ImprovedMendPet = "Improved Mend Pet";
	LOCALIZATION_ZORLEN_MendPet = "Mend Pet";
	LOCALIZATION_ZORLEN_CallPet = "Call Pet";
	LOCALIZATION_ZORLEN_RevivePet = "Revive Pet";
	LOCALIZATION_ZORLEN_DismissPet = "Dismiss Pet";
	LOCALIZATION_ZORLEN_AutoShot = "Auto Shot";
	LOCALIZATION_ZORLEN_MongooseBite = "Mongoose Bite";
	LOCALIZATION_ZORLEN_ArcaneShot = "Arcane Shot";
	LOCALIZATION_ZORLEN_ConcussiveShot = "Concussive Shot";
	LOCALIZATION_ZORLEN_RaptorStrike = "Raptor Strike";
	LOCALIZATION_ZORLEN_SerpentSting = "Serpent Sting";
	LOCALIZATION_ZORLEN_ViperSting = "Viper Sting";
	LOCALIZATION_ZORLEN_ScorpidSting = "Scorpid Sting";
	LOCALIZATION_ZORLEN_DistractingShot = "Distracting Shot";
	LOCALIZATION_ZORLEN_AimedShot = "Aimed Shot";
	LOCALIZATION_ZORLEN_HuntersMark = "Hunter's Mark";
	LOCALIZATION_ZORLEN_AspectOfTheHawk = "Aspect of the Hawk";
	LOCALIZATION_ZORLEN_AspectOfTheMonkey = "Aspect of the Monkey";
	LOCALIZATION_ZORLEN_AspectOfTheCheetah = "Aspect of the Cheetah";
	LOCALIZATION_ZORLEN_AspectOfThePack = "Aspect of the Pack";
	LOCALIZATION_ZORLEN_AspectOfTheWild = "Aspect of the Wild";
	LOCALIZATION_ZORLEN_AspectOfTheBeast = "Aspect of the Beast";
	LOCALIZATION_ZORLEN_WingClip = "Wing Clip";
	LOCALIZATION_ZORLEN_FreezingTrap = "Freezing Trap";
	LOCALIZATION_ZORLEN_FrostTrap = "Frost Trap";
	LOCALIZATION_ZORLEN_ExplosiveTrap = "Explosive Trap";
	LOCALIZATION_ZORLEN_ImmolationTrap = "Immolation Trap";
	LOCALIZATION_ZORLEN_FeignDeath = "Feign Death";
	LOCALIZATION_ZORLEN_Counterattack = "Counterattack";
	LOCALIZATION_ZORLEN_TranquilizingShot = "Tranquilizing Shot";
	LOCALIZATION_ZORLEN_Disengage = "Disengage";
	LOCALIZATION_ZORLEN_EyesOfTheBeast = "Eyes of the Beast";
	LOCALIZATION_ZORLEN_BeastLore = "Beast Lore";
	LOCALIZATION_ZORLEN_TrackBeasts = "Track Beasts";
	LOCALIZATION_ZORLEN_TrackDemons = "Track Demons";
	LOCALIZATION_ZORLEN_TrackDragonkin = "Track Dragonkin";
	LOCALIZATION_ZORLEN_TrackElementals = "Track Elementals";
	LOCALIZATION_ZORLEN_TrackGiants = "Track Giants";
	LOCALIZATION_ZORLEN_TrackHumanoids = "Track Humanoids";
	LOCALIZATION_ZORLEN_TrackUndead = "Track Undead";
	LOCALIZATION_ZORLEN_TrackHidden = "Track Hidden";
	LOCALIZATION_ZORLEN_BestialWrath = "Bestial Wrath";
	LOCALIZATION_ZORLEN_TrueshotAura = "Trueshot Aura";
	LOCALIZATION_ZORLEN_ScatterShot = "Scatter Shot";
	LOCALIZATION_ZORLEN_WyvernSting = "Wyvern Sting";
	LOCALIZATION_ZORLEN_Deterrence = "Deterrence";
	LOCALIZATION_ZORLEN_EagleEye = "Eagle Eye";
	LOCALIZATION_ZORLEN_RapidFire = "Rapid Fire";
	LOCALIZATION_ZORLEN_MultiShot = "Multi-Shot";
	LOCALIZATION_ZORLEN_Flare = "Flare";
	LOCALIZATION_ZORLEN_ScareBeast = "Scare Beast";
	LOCALIZATION_ZORLEN_Volley = "Volley";
	LOCALIZATION_ZORLEN_Intimidation = "Intimidation";



-- Zorlen_Warlock.lua file Localization
	LOCALIZATION_ZORLEN_SoulShard = "Soul Shard";
	LOCALIZATION_ZORLEN_AmplifyCurse = "Amplify Curse";
	LOCALIZATION_ZORLEN_CurseOfAgony = "Curse of Agony";
	LOCALIZATION_ZORLEN_CurseOfDoom = "Curse of Doom";
	LOCALIZATION_ZORLEN_CurseOfShadow = "Curse of Shadow";
	LOCALIZATION_ZORLEN_CurseOfTheElements = "Curse of the Elements";
	LOCALIZATION_ZORLEN_CurseOfWeakness = "Curse of Weakness";
	LOCALIZATION_ZORLEN_CurseOfExhaustion = "Curse of Exhaustion";
	LOCALIZATION_ZORLEN_CurseOfRecklessness = "Curse of Recklessness";
	LOCALIZATION_ZORLEN_CurseOfTongues = "Curse of Tongues";
	LOCALIZATION_ZORLEN_Corruption = "Corruption";
	LOCALIZATION_ZORLEN_ImprovedCorruption = "Improved Corruption";
	LOCALIZATION_ZORLEN_Immolate = "Immolate";
	LOCALIZATION_ZORLEN_SiphonLife = "Siphon Life";
	LOCALIZATION_ZORLEN_DrainLife = "Drain Life";
	LOCALIZATION_ZORLEN_DrainMana = "Drain Mana";
	LOCALIZATION_ZORLEN_Hellfire = "Hellfire";
	LOCALIZATION_ZORLEN_RainOfFire = "Rain of Fire";
	LOCALIZATION_ZORLEN_DrainSoul = "Drain Soul";
	LOCALIZATION_ZORLEN_LifeTap = "Life Tap";
	LOCALIZATION_ZORLEN_ImprovedLifeTap = "Improved Life Tap";
	LOCALIZATION_ZORLEN_DarkPact = "Dark Pact";
	LOCALIZATION_ZORLEN_Nightfall = "Nightfall";
	LOCALIZATION_ZORLEN_ShadowBolt = "Shadow Bolt";
	LOCALIZATION_ZORLEN_Banish = "Banish";
	LOCALIZATION_ZORLEN_Conflagrate = "Conflagrate";
	LOCALIZATION_ZORLEN_CreateFirestoneLesser = "Create Firestone (Lesser)";
	LOCALIZATION_ZORLEN_CreateFirestone = "Create Firestone";
	LOCALIZATION_ZORLEN_CreateFirestoneGreater = "Create Firestone (Greater)";
	LOCALIZATION_ZORLEN_CreateFirestoneMajor = "Create Firestone (Major)";
	LOCALIZATION_ZORLEN_CreateHealthstoneMinor = "Create Healthstone (Minor)";
	LOCALIZATION_ZORLEN_CreateHealthstoneLesser = "Create Healthstone (Lesser)";
	LOCALIZATION_ZORLEN_CreateHealthstone = "Create Healthstone";
	LOCALIZATION_ZORLEN_CreateHealthstoneGreater = "Create Healthstone (Greater)";
	LOCALIZATION_ZORLEN_CreateHealthstoneMajor = "Create Healthstone (Major)";
	LOCALIZATION_ZORLEN_CreateSoulstoneMinor = "Create Soulstone (Minor)";
	LOCALIZATION_ZORLEN_CreateSoulstoneLesser = "Create Soulstone (Lesser)";
	LOCALIZATION_ZORLEN_CreateSoulstone = "Create Soulstone";
	LOCALIZATION_ZORLEN_CreateSoulstoneGreater = "Create Soulstone (Greater)";
	LOCALIZATION_ZORLEN_CreateSoulstoneMajor = "Create Soulstone (Major)";
	LOCALIZATION_ZORLEN_CreateSpellstone = "Create Spellstone";
	LOCALIZATION_ZORLEN_CreateSpellstoneGreater = "Create Spellstone (Greater)";
	LOCALIZATION_ZORLEN_CreateSpellstoneMajor = "Create Spellstone (Major)";
	LOCALIZATION_ZORLEN_DeathCoil = "Death Coil";
	LOCALIZATION_ZORLEN_DemonArmor = "Demon Armor";
	LOCALIZATION_ZORLEN_DemonSkin = "Demon Skin";
	LOCALIZATION_ZORLEN_DemonicSacrifice = "Demonic Sacrifice";
	LOCALIZATION_ZORLEN_DetectLesserInvisibility = "Detect Lesser Invisibility";
	LOCALIZATION_ZORLEN_DetectInvisibility = "Detect Invisibility";
	LOCALIZATION_ZORLEN_DetectGreaterInvisibility = "Detect Greater Invisibility";
	LOCALIZATION_ZORLEN_EnslaveDemon = "Enslave Demon";
	LOCALIZATION_ZORLEN_EyeOfKilrogg = "Eye of Kilrogg";
	LOCALIZATION_ZORLEN_Fear = "Fear";
	LOCALIZATION_ZORLEN_FelDomination = "Fel Domination";
	LOCALIZATION_ZORLEN_HealthFunnel = "Health Funnel";
	LOCALIZATION_ZORLEN_HowlOfTerror = "Howl of Terror";
	LOCALIZATION_ZORLEN_Inferno = "Inferno";
	LOCALIZATION_ZORLEN_RitualOfDoom = "Ritual of Doom";
	LOCALIZATION_ZORLEN_RitualOfSummoning = "Ritual of Summoning";
	LOCALIZATION_ZORLEN_SearingPain = "Searing Pain";
	LOCALIZATION_ZORLEN_SenseDemons = "Sense Demons";
	LOCALIZATION_ZORLEN_ShadowWard = "Shadow Ward";
	LOCALIZATION_ZORLEN_Shadowburn = "Shadowburn";
	LOCALIZATION_ZORLEN_SoulFire = "Soul Fire";
	LOCALIZATION_ZORLEN_SoulLink = "Soul Link";
	LOCALIZATION_ZORLEN_SummonDreadsteed = "Summon Dreadsteed";
	LOCALIZATION_ZORLEN_SummonFelhunter = "Summon Felhunter";
	LOCALIZATION_ZORLEN_SummonFelsteed = "Summon Felsteed";
	LOCALIZATION_ZORLEN_SummonImp = "Summon Imp";
	LOCALIZATION_ZORLEN_SummonSuccubus = "Summon Succubus";
	LOCALIZATION_ZORLEN_SummonVoidwalker = "Summon Voidwalker";
	LOCALIZATION_ZORLEN_UnendingBreath = "Unending Breath";
	LOCALIZATION_ZORLEN_FelConcentration = "Fel Concentration";



-- Zorlen_Druid.lua file Localization
	LOCALIZATION_ZORLEN_TravelForm = "Travel Form";
	LOCALIZATION_ZORLEN_MoonkinForm = "Moonkin Form";
	LOCALIZATION_ZORLEN_BearForm = "Bear Form";
	LOCALIZATION_ZORLEN_DireBearForm = "Dire Bear Form";
	LOCALIZATION_ZORLEN_CatForm = "Cat Form";
	LOCALIZATION_ZORLEN_AquaticForm = "Aquatic Form";
	LOCALIZATION_ZORLEN_ChallengingRoar = "Challenging Roar";
	LOCALIZATION_ZORLEN_DemoralizingRoar = "Demoralizing Roar";
	LOCALIZATION_ZORLEN_AbolishPoison = "Abolish Poison";
	LOCALIZATION_ZORLEN_Barkskin = "Barkskin";
	LOCALIZATION_ZORLEN_Bash = "Bash";
	LOCALIZATION_ZORLEN_Claw = "Claw";
	LOCALIZATION_ZORLEN_Cower = "Cower";
	LOCALIZATION_ZORLEN_Dash = "Dash";
	LOCALIZATION_ZORLEN_Enrage = "Enrage";
	LOCALIZATION_ZORLEN_EntanglingRoots = "Entangling Roots";
	LOCALIZATION_ZORLEN_FaerieFire = "Faerie Fire";
	LOCALIZATION_ZORLEN_FaerieFireFeral = "Faerie Fire (Feral)";
	LOCALIZATION_ZORLEN_FeralCharge = "Feral Charge";
	LOCALIZATION_ZORLEN_FerociousBite = "Ferocious Bite";
	LOCALIZATION_ZORLEN_FrenziedRegeneration = "Frenzied Regeneration";
	LOCALIZATION_ZORLEN_GiftOfTheWild = "Gift of the Wild";
	LOCALIZATION_ZORLEN_HealingTouch = "Healing Touch";
	LOCALIZATION_ZORLEN_Hibernate = "Hibernate";
	LOCALIZATION_ZORLEN_Hurricane = "Hurricane";
	LOCALIZATION_ZORLEN_Innervate = "Innervate";
	LOCALIZATION_ZORLEN_InsectSwarm = "Insect Swarm";
	LOCALIZATION_ZORLEN_LeaderOfThePack = "Leader of the Pack";
	LOCALIZATION_ZORLEN_MarkOfTheWild = "Mark of the Wild";
	LOCALIZATION_ZORLEN_Maul = "Maul";
	LOCALIZATION_ZORLEN_Moonfire = "Moonfire";
	LOCALIZATION_ZORLEN_NaturesGrasp = "Nature's Grasp";
	LOCALIZATION_ZORLEN_NaturesSwiftness = "Nature's Swiftness";
	LOCALIZATION_ZORLEN_OmenOfClarity = "Omen of Clarity";
	LOCALIZATION_ZORLEN_Pounce = "Pounce";
	LOCALIZATION_ZORLEN_Prowl = "Prowl";
	LOCALIZATION_ZORLEN_Rake = "Rake";
	LOCALIZATION_ZORLEN_Ravage = "Ravage";
	LOCALIZATION_ZORLEN_Rebirth = "Rebirth";
	LOCALIZATION_ZORLEN_Regrowth = "Regrowth";
	LOCALIZATION_ZORLEN_Rejuvenation = "Rejuvenation";
	LOCALIZATION_ZORLEN_RemoveCurse = "Remove Curse";
	LOCALIZATION_ZORLEN_Rip = "Rip";
	LOCALIZATION_ZORLEN_Shred = "Shred";
	LOCALIZATION_ZORLEN_SootheAnimal = "Soothe Animal";
	LOCALIZATION_ZORLEN_Starfire = "Starfire";
	LOCALIZATION_ZORLEN_Swipe = "Swipe";
	LOCALIZATION_ZORLEN_Thorns = "Thorns";
	LOCALIZATION_ZORLEN_TigersFury = "Tiger's Fury";
	LOCALIZATION_ZORLEN_TrackHumanoids = "Track Humanoids";
	LOCALIZATION_ZORLEN_Tranquility = "Tranquility";
	LOCALIZATION_ZORLEN_Wrath = "Wrath";
	LOCALIZATION_ZORLEN_ImprovedWrath = "Improved Wrath";
	LOCALIZATION_ZORLEN_ImprovedNaturesGrasp = "Improved Nature's Grasp";
	LOCALIZATION_ZORLEN_ImprovedEntanglingRoots = "Improved Entangling Roots";
	LOCALIZATION_ZORLEN_ImprovedMoonfire = "Improved Moonfire";
	LOCALIZATION_ZORLEN_NaturalWeapons = "Natural Weapons";
	LOCALIZATION_ZORLEN_NaturalShapeshifter = "Natural Shapeshifter";
	LOCALIZATION_ZORLEN_ImprovedThorns = "Improved Thorns";
	LOCALIZATION_ZORLEN_NaturesReach = "Nature's Reach";
	LOCALIZATION_ZORLEN_Vengeance = "Vengeance";
	LOCALIZATION_ZORLEN_ImprovedStarfire = "Improved Starfire";
	LOCALIZATION_ZORLEN_NaturesGrace = "Nature's Grace";
	LOCALIZATION_ZORLEN_Moonglow = "Moonglow";
	LOCALIZATION_ZORLEN_Moonfury = "Moonfury";
	LOCALIZATION_ZORLEN_Ferocity = "Ferocity";
	LOCALIZATION_ZORLEN_FeralAggression = "Feral Aggression";
	LOCALIZATION_ZORLEN_FeralInstinct = "Feral Instinct";
	LOCALIZATION_ZORLEN_BrutalImpact = "Brutal Impact";
	LOCALIZATION_ZORLEN_ThickHide = "Thick Hide";
	LOCALIZATION_ZORLEN_FelineSwiftness = "Feline Swiftness";
	LOCALIZATION_ZORLEN_SharpenedClaws = "Sharpened Claws";
	LOCALIZATION_ZORLEN_ImprovedShred = "Improved Shred";
	LOCALIZATION_ZORLEN_PredatoryStrikes = "Predatory Strikes";
	LOCALIZATION_ZORLEN_BloodFrenzy = "Blood Frenzy";
	LOCALIZATION_ZORLEN_PrimalFury = "Primal Fury";
	LOCALIZATION_ZORLEN_SavageFury = "Savage Fury";
	LOCALIZATION_ZORLEN_HeartOfTheWild = "Heart of the Wild";
	LOCALIZATION_ZORLEN_ImprovedMarkOfTheWild = "Improved Mark of the Wild";
	LOCALIZATION_ZORLEN_Furor = "Furor";
	LOCALIZATION_ZORLEN_ImprovedHealingTouch = "Improved Healing Touch";
	LOCALIZATION_ZORLEN_NaturesFocus = "Nature's Focus";
	LOCALIZATION_ZORLEN_ImprovedEnrage = "Improved Enrage";
	LOCALIZATION_ZORLEN_Reflection = "Reflection";
	LOCALIZATION_ZORLEN_Subtlety = "Subtlety";
	LOCALIZATION_ZORLEN_TranquilSpirit = "Tranquil Spirit";
	LOCALIZATION_ZORLEN_ImprovedRejuvenation = "Improved Rejuvenation";
	LOCALIZATION_ZORLEN_GiftOfNature = "Gift of Nature";
	LOCALIZATION_ZORLEN_ImprovedTranquility = "Improved Tranquility";
	LOCALIZATION_ZORLEN_ImprovedRegrowth = "Improved Regrowth";



-- Zorlen_Mage.lua file Localization
	LOCALIZATION_ZORLEN_AmplifyMagic = "Amplify Magic";
	LOCALIZATION_ZORLEN_ArcaneBrilliance = "Arcane Brilliance";
	LOCALIZATION_ZORLEN_ArcaneExplosion = "Arcane Explosion";
	LOCALIZATION_ZORLEN_ArcaneIntellect = "Arcane Intellect";
	LOCALIZATION_ZORLEN_ArcaneMissiles = "Arcane Missiles";
	LOCALIZATION_ZORLEN_ArcanePower = "Arcane Power";
	LOCALIZATION_ZORLEN_BlastWave = "Blast Wave";
	LOCALIZATION_ZORLEN_Blink = "Blink";
	LOCALIZATION_ZORLEN_Blizzard = "Blizzard";
	LOCALIZATION_ZORLEN_ColdSnap = "Cold Snap";
	LOCALIZATION_ZORLEN_Combustion = "Combustion";
	LOCALIZATION_ZORLEN_ConeOfCold = "Cone of Cold";
	LOCALIZATION_ZORLEN_ConjureFood = "Conjure Food";
	LOCALIZATION_ZORLEN_ConjureManaAgate = "Conjure Mana Agate";
	LOCALIZATION_ZORLEN_ConjureManaJade = "Conjure Mana Jade";
	LOCALIZATION_ZORLEN_ConjureManaCitrine = "Conjure Mana Citrine";
	LOCALIZATION_ZORLEN_ConjureManaRuby = "Conjure Mana Ruby";
	LOCALIZATION_ZORLEN_ConjureWater = "Conjure Water";
	LOCALIZATION_ZORLEN_Counterspell = "Counterspell";
	LOCALIZATION_ZORLEN_DampenMagic = "Dampen Magic";
	LOCALIZATION_ZORLEN_DetectMagic = "Detect Magic";
	LOCALIZATION_ZORLEN_Evocation = "Evocation";
	LOCALIZATION_ZORLEN_FireBlast = "Fire Blast";
	LOCALIZATION_ZORLEN_FireWard = "Fire Ward";
	LOCALIZATION_ZORLEN_Fireball = "Fireball";
	LOCALIZATION_ZORLEN_Flamestrike = "Flamestrike";
	LOCALIZATION_ZORLEN_FrostArmor = "Frost Armor";
	LOCALIZATION_ZORLEN_FrostNova = "Frost Nova";
	LOCALIZATION_ZORLEN_FrostWard = "Frost Ward";
	LOCALIZATION_ZORLEN_Frostbolt = "Frostbolt";
	LOCALIZATION_ZORLEN_IceArmor = "Ice Armor";
	LOCALIZATION_ZORLEN_IceBarrier = "Ice Barrier";
	LOCALIZATION_ZORLEN_IceBlock = "Ice Block";
	LOCALIZATION_ZORLEN_MageArmor = "Mage Armor";
	LOCALIZATION_ZORLEN_ManaShield = "Mana Shield";
	LOCALIZATION_ZORLEN_Polymorph = "Polymorph";
	LOCALIZATION_ZORLEN_PortalDarnassus = "Portal: Darnassus";
	LOCALIZATION_ZORLEN_PortalIronforge = "Portal: Ironforge";
	LOCALIZATION_ZORLEN_PortalOrgrimmar = "Portal: Orgrimmar";
	LOCALIZATION_ZORLEN_PortalStormwind = "Portal: Stormwind";
	LOCALIZATION_ZORLEN_PortalThunderBluff = "Portal: Thunder Bluff";
	LOCALIZATION_ZORLEN_PortalUndercity = "Portal: Undercity";
	LOCALIZATION_ZORLEN_TeleportDarnassus = "Teleport: Darnassus";
	LOCALIZATION_ZORLEN_TeleportIronforge = "Teleport: Ironforge";
	LOCALIZATION_ZORLEN_TeleportOrgrimmar = "Teleport: Orgrimmar";
	LOCALIZATION_ZORLEN_TeleportStormwind = "Teleport: Stormwind";
	LOCALIZATION_ZORLEN_TeleportThunderBluff = "Teleport: Thunder Bluff";
	LOCALIZATION_ZORLEN_TeleportUndercity = "Teleport: Undercity";
	LOCALIZATION_ZORLEN_PresenceOfMind = "Presence of Mind";
	LOCALIZATION_ZORLEN_Pyroblast = "Pyroblast";
	LOCALIZATION_ZORLEN_RemoveLesserCurse = "Remove Lesser Curse";
	LOCALIZATION_ZORLEN_Scorch = "Scorch";
	LOCALIZATION_ZORLEN_SlowFall = "Slow Fall";



-- Zorlen_Paladin.lua file Localization
	LOCALIZATION_ZORLEN_BlessingOfFreedom = "Blessing of Freedom";
	LOCALIZATION_ZORLEN_BlessingOfKings = "Blessing of Kings";
	LOCALIZATION_ZORLEN_BlessingOfLight = "Blessing of Light";
	LOCALIZATION_ZORLEN_BlessingOfMight = "Blessing of Might";
	LOCALIZATION_ZORLEN_BlessingOfProtection = "Blessing of Protection";
	LOCALIZATION_ZORLEN_BlessingOfSacrifice = "Blessing of Sacrifice";
	LOCALIZATION_ZORLEN_BlessingOfSalvation = "Blessing of Salvation";
	LOCALIZATION_ZORLEN_BlessingOfSanctuary = "Blessing of Sanctuary";
	LOCALIZATION_ZORLEN_BlessingOfWisdom = "Blessing of Wisdom";
	LOCALIZATION_ZORLEN_Cleanse = "Cleanse";
	LOCALIZATION_ZORLEN_ConcentrationAura = "Concentration Aura";
	LOCALIZATION_ZORLEN_Consecration = "Consecration";
	LOCALIZATION_ZORLEN_DevotionAura = "Devotion Aura";
	LOCALIZATION_ZORLEN_DivineFavor = "Divine Favor";
	LOCALIZATION_ZORLEN_DivineIntervention = "Divine Intervention";
	LOCALIZATION_ZORLEN_DivineProtection = "Divine Protection";
	LOCALIZATION_ZORLEN_DivineShield = "Divine Shield";
	LOCALIZATION_ZORLEN_Exorcism = "Exorcism";
	LOCALIZATION_ZORLEN_FireResistanceAura = "Fire Resistance Aura";
	LOCALIZATION_ZORLEN_FlashOfLight = "Flash of Light";
	LOCALIZATION_ZORLEN_FrostResistanceAura = "Frost Resistance Aura";
	LOCALIZATION_ZORLEN_GreaterBlessingOfKings = "Greater Blessing of Kings";
	LOCALIZATION_ZORLEN_GreaterBlessingOfLight = "Greater Blessing of Light";
	LOCALIZATION_ZORLEN_GreaterBlessingOfMight = "Greater Blessing of Might";
	LOCALIZATION_ZORLEN_GreaterBlessingOfSalvation = "Greater Blessing of Salvation";
	LOCALIZATION_ZORLEN_GreaterBlessingOfSanctuary = "Greater Blessing of Sanctuary";
	LOCALIZATION_ZORLEN_GreaterBlessingOfWisdom = "Greater Blessing of Wisdom";
	LOCALIZATION_ZORLEN_HammerOfJustice = "Hammer of Justice";
	LOCALIZATION_ZORLEN_HammerOfWrath = "Hammer of Wrath";
	LOCALIZATION_ZORLEN_HolyLight = "Holy Light";
	LOCALIZATION_ZORLEN_HolyShield = "Holy Shield";
	LOCALIZATION_ZORLEN_HolyShock = "Holy Shock";
	LOCALIZATION_ZORLEN_HolyWrath = "Holy Wrath";
	LOCALIZATION_ZORLEN_Judgement = "Judgement";
	LOCALIZATION_ZORLEN_LayOnHands = "Lay on Hands";
	LOCALIZATION_ZORLEN_Purify = "Purify";
	LOCALIZATION_ZORLEN_Redemption = "Redemption";
	LOCALIZATION_ZORLEN_Repentance = "Repentance";
	LOCALIZATION_ZORLEN_RetributionAura = "Retribution Aura";
	LOCALIZATION_ZORLEN_RighteousFury = "Righteous Fury";
	LOCALIZATION_ZORLEN_SanctityAura = "Sanctity Aura";
	LOCALIZATION_ZORLEN_SealOfCommand = "Seal of Command";
	LOCALIZATION_ZORLEN_SealOfJustice = "Seal of Justice";
	LOCALIZATION_ZORLEN_SealOfLight = "Seal of Light";
	LOCALIZATION_ZORLEN_SealOfRighteousness = "Seal of Righteousness";
	LOCALIZATION_ZORLEN_SealOfWisdom = "Seal of Wisdom";
	LOCALIZATION_ZORLEN_SealOfTheCrusader = "Seal of the Crusader";
	LOCALIZATION_ZORLEN_SenseUndead = "Sense Undead";
	LOCALIZATION_ZORLEN_ShadowResistanceAura = "Shadow Resistance Aura";
	LOCALIZATION_ZORLEN_SummonCharger = "Summon Charger";
	LOCALIZATION_ZORLEN_SummonWarhorse = "Summon Warhorse";
	LOCALIZATION_ZORLEN_TurnUndead = "Turn Undead";



-- Zorlen_Priest.lua file Localization
	LOCALIZATION_ZORLEN_AbolishDisease = "Abolish Disease";
	LOCALIZATION_ZORLEN_CureDisease = "Cure Disease";
	LOCALIZATION_ZORLEN_DesperatePrayer = "Desperate Prayer";
	LOCALIZATION_ZORLEN_DevouringPlague = "Devouring Plague";
	LOCALIZATION_ZORLEN_DispelMagic = "Dispel Magic";
	LOCALIZATION_ZORLEN_DivineSpirit = "Divine Spirit";
	LOCALIZATION_ZORLEN_ElunesGrace = "Elune's Grace";
	LOCALIZATION_ZORLEN_Fade = "Fade";
	LOCALIZATION_ZORLEN_FearWard = "Fear Ward";
	LOCALIZATION_ZORLEN_Feedback = "Feedback";
	LOCALIZATION_ZORLEN_FlashHeal = "Flash Heal";
	LOCALIZATION_ZORLEN_FocusedCasting = "Focused Casting";
	LOCALIZATION_ZORLEN_LesserHeal = "Lesser Heal";
	LOCALIZATION_ZORLEN_Heal = "Heal";
	LOCALIZATION_ZORLEN_GreaterHeal = "Greater Heal";
	LOCALIZATION_ZORLEN_HexOfWeakness = "Hex of Weakness";
	LOCALIZATION_ZORLEN_HolyFire = "Holy Fire";
	LOCALIZATION_ZORLEN_HolyNova = "Holy Nova";
	LOCALIZATION_ZORLEN_InnerFire = "Inner Fire";
	LOCALIZATION_ZORLEN_InnerFocus = "Inner Focus";
	LOCALIZATION_ZORLEN_Levitate = "Levitate";
	LOCALIZATION_ZORLEN_ManaBurn = "Mana Burn";
	LOCALIZATION_ZORLEN_MindBlast = "Mind Blast";
	LOCALIZATION_ZORLEN_MindControl = "Mind Control";
	LOCALIZATION_ZORLEN_MindFlay = "Mind Flay";
	LOCALIZATION_ZORLEN_MindSoothe = "Mind Soothe";
	LOCALIZATION_ZORLEN_MindVision = "Mind Vision";
	LOCALIZATION_ZORLEN_PowerWordFortitude = "Power Word: Fortitude";
	LOCALIZATION_ZORLEN_PowerWordShield = "Power Word: Shield";
	LOCALIZATION_ZORLEN_PrayerOfFortitude = "Prayer of Fortitude";
	LOCALIZATION_ZORLEN_PrayerOfHealing = "Prayer of Healing";
	LOCALIZATION_ZORLEN_PsychicScream = "Psychic Scream";
	LOCALIZATION_ZORLEN_Renew = "Renew";
	LOCALIZATION_ZORLEN_Resurrection = "Resurrection";
	LOCALIZATION_ZORLEN_ShackleUndead = "Shackle Undead";
	LOCALIZATION_ZORLEN_ShadowProtection = "Shadow Protection";
	LOCALIZATION_ZORLEN_ShadowWordPain = "Shadow Word: Pain";
	LOCALIZATION_ZORLEN_Shadowform = "Shadowform";
	LOCALIZATION_ZORLEN_Shadowguard = "Shadowguard";
	LOCALIZATION_ZORLEN_Silence = "Silence";
	LOCALIZATION_ZORLEN_Smite = "Smite";
	LOCALIZATION_ZORLEN_SpiritOfRedemption = "Spirit of Redemption";
	LOCALIZATION_ZORLEN_Starshards = "Starshards";
	LOCALIZATION_ZORLEN_TouchOfWeakness = "Touch of Weakness";
	LOCALIZATION_ZORLEN_VampiricEmbrace = "Vampiric Embrace";



-- Zorlen_Rogue.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedCheapShot = "Improved Cheap Shot";
	LOCALIZATION_ZORLEN_ImprovedSinisterStrike = "Improved Sinister Strike";
	LOCALIZATION_ZORLEN_CripplingPoison = "Crippling Poison";
	LOCALIZATION_ZORLEN_CripplingPoisonII = "Crippling Poison II";
	LOCALIZATION_ZORLEN_DeadlyPoison = "Deadly Poison";
	LOCALIZATION_ZORLEN_DeadlyPoisonII = "Deadly Poison II";
	LOCALIZATION_ZORLEN_DeadlyPoisonIII = "Deadly Poison III";
	LOCALIZATION_ZORLEN_DeadlyPoisonIV = "Deadly Poison IV";
	LOCALIZATION_ZORLEN_DeadlyPoisonV = "Deadly Poison V";
	LOCALIZATION_ZORLEN_InstantPoison = "Instant Poison";
	LOCALIZATION_ZORLEN_InstantPoisonII = "Instant Poison II";
	LOCALIZATION_ZORLEN_InstantPoisonIII = "Instant Poison III";
	LOCALIZATION_ZORLEN_InstantPoisonIV = "Instant Poison IV";
	LOCALIZATION_ZORLEN_InstantPoisonV = "Instant Poison V";
	LOCALIZATION_ZORLEN_InstantPoisonVI = "Instant Poison VI";
	LOCALIZATION_ZORLEN_MindnumbingPoison = "Mind-numbing Poison";
	LOCALIZATION_ZORLEN_MindnumbingPoisonII = "Mind-numbing Poison II";
	LOCALIZATION_ZORLEN_MindnumbingPoisonIII = "Mind-numbing Poison III";
	LOCALIZATION_ZORLEN_WoundPoison = "Wound Poison";
	LOCALIZATION_ZORLEN_WoundPoisonII = "Wound Poison II";
	LOCALIZATION_ZORLEN_WoundPoisonIII = "Wound Poison III";
	LOCALIZATION_ZORLEN_WoundPoisonIV = "Wound Poison IV";
	LOCALIZATION_ZORLEN_AdrenalineRush = "Adrenaline Rush";
	LOCALIZATION_ZORLEN_Ambush = "Ambush";
	LOCALIZATION_ZORLEN_Backstab = "Backstab";
	LOCALIZATION_ZORLEN_BladeFlurry = "Blade Flurry";
	LOCALIZATION_ZORLEN_Blind = "Blind";
	LOCALIZATION_ZORLEN_BlindingPowder = "Blinding Powder";
	LOCALIZATION_ZORLEN_CheapShot = "Cheap Shot";
	LOCALIZATION_ZORLEN_ColdBlood = "Cold Blood";
	LOCALIZATION_ZORLEN_DetectTraps = "Detect Traps";
	LOCALIZATION_ZORLEN_DisarmTrap = "Disarm Trap";
	LOCALIZATION_ZORLEN_Distract = "Distract";
	LOCALIZATION_ZORLEN_Evasion = "Evasion";
	LOCALIZATION_ZORLEN_Eviscerate = "Eviscerate";
	LOCALIZATION_ZORLEN_ExposeArmor = "Expose Armor";
	LOCALIZATION_ZORLEN_Feint = "Feint";
	LOCALIZATION_ZORLEN_Garrote = "Garrote";
	LOCALIZATION_ZORLEN_GhostlyStrike = "Ghostly Strike";
	LOCALIZATION_ZORLEN_Gouge = "Gouge";
	LOCALIZATION_ZORLEN_Hemorrhage = "Hemorrhage";
	LOCALIZATION_ZORLEN_Kick = "Kick";
	LOCALIZATION_ZORLEN_KidneyShot = "Kidney Shot";
	LOCALIZATION_ZORLEN_PickLock = "Pick Lock";
	LOCALIZATION_ZORLEN_PickPocket = "Pick Pocket";
	LOCALIZATION_ZORLEN_Premeditation = "Premeditation";
	LOCALIZATION_ZORLEN_Preparation = "Preparation";
	LOCALIZATION_ZORLEN_RelentlessStrikes = "Relentless Strikes";
	LOCALIZATION_ZORLEN_Riposte = "Riposte";
	LOCALIZATION_ZORLEN_Rupture = "Rupture";
	LOCALIZATION_ZORLEN_Sap = "Sap";
	LOCALIZATION_ZORLEN_SinisterStrike = "Sinister Strike";
	LOCALIZATION_ZORLEN_SliceAndDice = "Slice and Dice";
	LOCALIZATION_ZORLEN_Sprint = "Sprint";
	LOCALIZATION_ZORLEN_Stealth = "Stealth";
	LOCALIZATION_ZORLEN_Vanish = "Vanish";



-- Zorlen_Shaman.lua file Localization
	LOCALIZATION_ZORLEN_DiseaseCleansingTotem = "Disease Cleansing Totem";
	LOCALIZATION_ZORLEN_EarthbindTotem = "Earthbind Totem";
	LOCALIZATION_ZORLEN_FireNovaTotem = "Fire Nova Totem";
	LOCALIZATION_ZORLEN_FireResistanceTotem = "Fire Resistance Totem";
	LOCALIZATION_ZORLEN_FlametongueTotem = "Flametongue Totem";
	LOCALIZATION_ZORLEN_FrostResistanceTotem = "Frost Resistance Totem";
	LOCALIZATION_ZORLEN_GraceOfAirTotem = "Grace of Air Totem";
	LOCALIZATION_ZORLEN_GroundingTotem = "Grounding Totem";
	LOCALIZATION_ZORLEN_HealingStreamTotem = "Healing Stream Totem";
	LOCALIZATION_ZORLEN_MagmaTotem = "Magma Totem";
	LOCALIZATION_ZORLEN_ManaSpringTotem = "Mana Spring Totem";
	LOCALIZATION_ZORLEN_ManaTideTotem = "Mana Tide Totem";
	LOCALIZATION_ZORLEN_NatureResistanceTotem = "Nature Resistance Totem";
	LOCALIZATION_ZORLEN_PoisonCleansingTotem = "Poison Cleansing Totem";
	LOCALIZATION_ZORLEN_SearingTotem = "Searing Totem";
	LOCALIZATION_ZORLEN_SentryTotem = "Sentry Totem";
	LOCALIZATION_ZORLEN_StoneclawTotem = "Stoneclaw Totem";
	LOCALIZATION_ZORLEN_StoneskinTotem = "Stoneskin Totem";
	LOCALIZATION_ZORLEN_StrengthOfEarthTotem = "Strength of Earth Totem";
	LOCALIZATION_ZORLEN_TremorTotem = "Tremor Totem";
	LOCALIZATION_ZORLEN_WindfuryTotem = "Windfury Totem";
	LOCALIZATION_ZORLEN_WindwallTotem = "Windwall Totem";
	LOCALIZATION_ZORLEN_EarthShock = "Earth Shock";
	LOCALIZATION_ZORLEN_FlameShock = "Flame Shock";
	LOCALIZATION_ZORLEN_FrostShock = "Frost Shock";
	LOCALIZATION_ZORLEN_FlametongueWeapon = "Flametongue Weapon";
	LOCALIZATION_ZORLEN_FrostbrandWeapon = "Frostbrand Weapon";
	LOCALIZATION_ZORLEN_RockbiterWeapon = "Rockbiter Weapon";
	LOCALIZATION_ZORLEN_WindfuryWeapon = "Windfury Weapon";
	LOCALIZATION_ZORLEN_AncestralSpirit = "Ancestral Spirit";
	LOCALIZATION_ZORLEN_AstralRecall = "Astral Recall";
	LOCALIZATION_ZORLEN_ChainHeal = "Chain Heal";
	LOCALIZATION_ZORLEN_ChainLightning = "Chain Lightning";
	LOCALIZATION_ZORLEN_CureDisease = "Cure Disease";
	LOCALIZATION_ZORLEN_CurePoison = "Cure Poison";
	LOCALIZATION_ZORLEN_ElementalFocus = "Elemental Focus";
	LOCALIZATION_ZORLEN_ElementalMastery = "Elemental Mastery";
	LOCALIZATION_ZORLEN_FarSight = "Far Sight";
	LOCALIZATION_ZORLEN_GhostWolf = "Ghost Wolf";
	LOCALIZATION_ZORLEN_LesserHealingWave = "Lesser Healing Wave";
	LOCALIZATION_ZORLEN_HealingWave = "Healing Wave";
	LOCALIZATION_ZORLEN_LightningBolt = "Lightning Bolt";
	LOCALIZATION_ZORLEN_LightningShield = "Lightning Shield";
	LOCALIZATION_ZORLEN_NaturesSwiftness = "Nature's Swiftness";
	LOCALIZATION_ZORLEN_Purge = "Purge";
	LOCALIZATION_ZORLEN_Reincarnation = "Reincarnation";
	LOCALIZATION_ZORLEN_Stormstrike = "Stormstrike";
	LOCALIZATION_ZORLEN_WaterBreathing = "Water Breathing";
	LOCALIZATION_ZORLEN_WaterWalking = "Water Walking";



-- Zorlen_Warrior.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedOverpower = "Improved Overpower";
	LOCALIZATION_ZORLEN_ImprovedBerserkerRage = "Improved Berserker Rage";
	LOCALIZATION_ZORLEN_ImprovedExecute = "Improved Execute";
	LOCALIZATION_ZORLEN_Execute = "Execute";
	LOCALIZATION_ZORLEN_ImprovedHeroicStrike = "Improved Heroic Strike";
	LOCALIZATION_ZORLEN_HeroicStrike = "Heroic Strike";
	LOCALIZATION_ZORLEN_ImprovedSunderArmor = "Improved Sunder Armor";
	LOCALIZATION_ZORLEN_SunderArmor = "Sunder Armor";
	LOCALIZATION_ZORLEN_ImprovedThunderClap = "Improved Thunder Clap";
	LOCALIZATION_ZORLEN_ThunderClap = "Thunder Clap";
	LOCALIZATION_ZORLEN_MortalStrike = "Mortal Strike";
	LOCALIZATION_ZORLEN_Bloodthirst = "Bloodthirst";
	LOCALIZATION_ZORLEN_ShieldSlam = "Shield Slam";
	LOCALIZATION_ZORLEN_Charge = "Charge";
	LOCALIZATION_ZORLEN_Taunt = "Taunt";
	LOCALIZATION_ZORLEN_Intercept = "Intercept";
	LOCALIZATION_ZORLEN_Overpower = "Overpower";
	LOCALIZATION_ZORLEN_Revenge = "Revenge";
	LOCALIZATION_ZORLEN_Rend = "Rend";
	LOCALIZATION_ZORLEN_Hamstring = "Hamstring";
	LOCALIZATION_ZORLEN_ShieldBash = "Shield Bash";
	LOCALIZATION_ZORLEN_Pummel = "Pummel";
	LOCALIZATION_ZORLEN_ShieldBlock = "Shield Block";
	LOCALIZATION_ZORLEN_DemoralizingShout = "Demoralizing Shout";
	LOCALIZATION_ZORLEN_BattleShout = "Battle Shout";
	LOCALIZATION_ZORLEN_BerserkerRage = "Berserker Rage";
	LOCALIZATION_ZORLEN_Enrage = "Enrage";
	LOCALIZATION_ZORLEN_DefensiveStance = "Defensive Stance";
	LOCALIZATION_ZORLEN_BattleStance = "Battle Stance";
	LOCALIZATION_ZORLEN_BerserkerStance = "Berserker Stance";
	LOCALIZATION_ZORLEN_AngerManagement = "Anger Management";
	LOCALIZATION_ZORLEN_Bloodrage = "Bloodrage";
	LOCALIZATION_ZORLEN_ChallengingShout = "Challenging Shout";
	LOCALIZATION_ZORLEN_Cleave = "Cleave";
	LOCALIZATION_ZORLEN_ConcussionBlow = "Concussion Blow";
	LOCALIZATION_ZORLEN_DeathWish = "Death Wish";
	LOCALIZATION_ZORLEN_Disarm = "Disarm";
	LOCALIZATION_ZORLEN_IntimidatingShout = "Intimidating Shout";
	LOCALIZATION_ZORLEN_LastStand = "Last Stand";
	LOCALIZATION_ZORLEN_MockingBlow = "Mocking Blow";
	LOCALIZATION_ZORLEN_PiercingHowl = "Piercing Howl";
	LOCALIZATION_ZORLEN_Recklessness = "Recklessness";
	LOCALIZATION_ZORLEN_Retaliation = "Retaliation";
	LOCALIZATION_ZORLEN_ShieldWall = "Shield Wall";
	LOCALIZATION_ZORLEN_Slam = "Slam";
	LOCALIZATION_ZORLEN_SweepingStrikes = "Sweeping Strikes";
	LOCALIZATION_ZORLEN_Whirlwind = "Whirlwind";
	LOCALIZATION_ZORLEN_TacticalMastery = "Tactical Mastery";

