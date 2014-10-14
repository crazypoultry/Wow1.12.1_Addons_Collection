-- German Translation
-- If you want to translate this to another language, make sure the names of buffs and abilities are *EXACTLY* the same as in-game. Spelling, punctuation, upper/lowercase letters, etc. MUST BE EXACT. Also, any 'foreign' characters must be converted to UNICODE.
-- Unicode resource:  http://www.allegro-c.de/unicode/zcodes.htm


-- To lower the upkeep we will not be adding Localization for english words that do not break compatibility in other game clients.
-- This Localization is only added for compatibility so that it may work in non english game clients and not as a translation.

if GetLocale() == "deDE" then
-- All file Localization
	LOCALIZATION_ZORLEN_Rank = "Rang";
	LOCALIZATION_ZORLEN_sit = "sitzen";
	LOCALIZATION_ZORLEN_You_dodge = "Ausgewichen";
	LOCALIZATION_ZORLEN_Your = "Euer";
	LOCALIZATION_ZORLEN_immune = "Imun";
	--LOCALIZATION_ZORLEN_no_weapons_equipped = "";
	--LOCALIZATION_ZORLEN_dodged = "";
	--LOCALIZATION_ZORLEN_dodges = "";
	LOCALIZATION_ZORLEN_pet_is_not_dead = "Euer Begleiter ist nicht tot";
	LOCALIZATION_ZORLEN_pet_is_dead = "Euer Begleiter ist tot";
	
	--LOCALIZATION_ZORLEN_PlusHealMinScan = "";
	--LOCALIZATION_ZORLEN_PlusHealMaxScan = "";
	--LOCALIZATION_ZORLEN_VariableHealScanEquip = "";
	--LOCALIZATION_ZORLEN_VariableHealScanSet = "";

-- Example: /script Zorlen_GiveName_OffHandType()
-- The example above will give the name required for LOCALIZATION_ZORLEN_Shields
-- You must have a shield equipped to get the correct name.
-- You can also get the correct name from the auction house filters under the Armor section.
	LOCALIZATION_ZORLEN_Shields = "Schilde";
	
-- Example: /script Zorlen_GiveName_MainHandType()
-- The example above will give the name required for the weapons below.
-- You must have the weapon equipped to get the correct name.
-- You can also get the correct names from the auction house filters under the Weapon section.
	LOCALIZATION_ZORLEN_Daggers = "Dolch";
	LOCALIZATION_ZORLEN_OneHandedSwords = "Schwert";
	LOCALIZATION_ZORLEN_TwoHandedSwords = "Zweihandschwert";
	LOCALIZATION_ZORLEN_OneHandedAxes = "Axt";
	LOCALIZATION_ZORLEN_TwoHandedAxes = "Zweihandaxt";
	LOCALIZATION_ZORLEN_OneHandedMaces = "Streitkolben";
	LOCALIZATION_ZORLEN_TwoHandedMaces = "Zweihandstreitkolben";
	LOCALIZATION_ZORLEN_Polearms = "Stangenwaffe";
	LOCALIZATION_ZORLEN_Staves = "Stab";
	LOCALIZATION_ZORLEN_FistWeapons = "Faustwaffe";
	LOCALIZATION_ZORLEN_FishingPole = "Angel";



-- Zorlen_Other.lua file Localization
	LOCALIZATION_ZORLEN_Attack = "Angriff";
	LOCALIZATION_ZORLEN_Throw = "Wurf";
	--LOCALIZATION_ZORLEN_ShootBow = "";
	--LOCALIZATION_ZORLEN_ShootCrossbow = "";
	--LOCALIZATION_ZORLEN_ShootGun = "";
	LOCALIZATION_ZORLEN_Shoot = "Schie\195\159en";
-- Human Racial
	LOCALIZATION_ZORLEN_Perception = "Wachsamkeit";
-- Dwarf Racial
	LOCALIZATION_ZORLEN_FindTreasure = "Schatzsucher";
	LOCALIZATION_ZORLEN_Stoneform = "Steingestalt";
-- Gnome Racial
	LOCALIZATION_ZORLEN_EscapeArtist = "Entfesselungsk\195\188nstler";
-- Night Elf Racial
	LOCALIZATION_ZORLEN_Shadowmeld = "Schattenhaftigkeit";
-- Orc Racial
	LOCALIZATION_ZORLEN_BloodFury = "Kochendes Blut";
-- Undead Racial
	LOCALIZATION_ZORLEN_Cannibalize = "Kannibalismus";
	LOCALIZATION_ZORLEN_WillOfTheForsaken = "Wille der Verlassenen";
-- Tauren Racial
	LOCALIZATION_ZORLEN_WarStomp = "Kriegsdonner";
-- Troll Racial
	LOCALIZATION_ZORLEN_Berserking = "Berserker";



-- Zorlen_Pets.lua file Localization
-- Hunter Pets
	LOCALIZATION_ZORLEN_Dash = "Spurt";
	LOCALIZATION_ZORLEN_Dive = "Sturzflug";
	LOCALIZATION_ZORLEN_Bite = "Bei\195\159en";
	LOCALIZATION_ZORLEN_Claw = "Klaue";
	LOCALIZATION_ZORLEN_Cower = "Ducken";
	LOCALIZATION_ZORLEN_Growl = "Knurren";
	LOCALIZATION_ZORLEN_Prowl = "Schleichen";
	LOCALIZATION_ZORLEN_Charge = "Sturmangriff";
	LOCALIZATION_ZORLEN_Screech = "Schrei";
	--LOCALIZATION_ZORLEN_FuriousHowl = "";
	LOCALIZATION_ZORLEN_LightningBreath = "Blitzschlagatem";
	LOCALIZATION_ZORLEN_ShellShield = "Panzerschild";
	LOCALIZATION_ZORLEN_Thunderstomp = "Donnerstampfer";
	LOCALIZATION_ZORLEN_ScorpidPoison = "Scorpidgift";
-- Warlock Pets
	LOCALIZATION_ZORLEN_BloodPact = "Blut Pakt";
	LOCALIZATION_ZORLEN_FireShield = "Feuerschild";
	LOCALIZATION_ZORLEN_Firebolt = "Feuerball";
	LOCALIZATION_ZORLEN_PhaseShift = "Phasenverschiebung";
	LOCALIZATION_ZORLEN_ConsumeShadows = "Schatten verzerren";
	LOCALIZATION_ZORLEN_Sacrifice = "Opferung";
	--LOCALIZATION_ZORLEN_Suffering = "";
	LOCALIZATION_ZORLEN_Torment = "Qual";
	LOCALIZATION_ZORLEN_DevourMagic = "Magie verzehren";
	--LOCALIZATION_ZORLEN_Paranoia = "";
	--LOCALIZATION_ZORLEN_SpellLock = "";
	--LOCALIZATION_ZORLEN_TaintedBlood = "";
	--LOCALIZATION_ZORLEN_LashOfPain = "";
	--LOCALIZATION_ZORLEN_Seduction = "";
	--LOCALIZATION_ZORLEN_SoothingKiss = "";
	LOCALIZATION_ZORLEN_LesserInvisibility = "geringe Unsichtbarkeit";



-- Zorlen_Hunter.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedAspectOfTheHawk = "Verbesserte Aspekt des Falken";
	LOCALIZATION_ZORLEN_ImprovedMendPet = "Verbesserte Tier heilen";
	LOCALIZATION_ZORLEN_MendPet = "Tier heilen";
	LOCALIZATION_ZORLEN_CallPet = "Tier rufen";
	LOCALIZATION_ZORLEN_RevivePet = "Tier wiederbeleben";
	LOCALIZATION_ZORLEN_DismissPet = "Tier freigeben";
	LOCALIZATION_ZORLEN_AutoShot = "Autom. Schuss";
	LOCALIZATION_ZORLEN_MongooseBite = "Mungobiss";
	LOCALIZATION_ZORLEN_ArcaneShot = "Arkaner Schuss";
	LOCALIZATION_ZORLEN_ConcussiveShot = "Ersch\195\188tternder Schuss";
	LOCALIZATION_ZORLEN_RaptorStrike = "Raptorsto/195/159";
	LOCALIZATION_ZORLEN_SerpentSting = "Schlangenbiss";
	LOCALIZATION_ZORLEN_ViperSting = "Vipernbiss";
	LOCALIZATION_ZORLEN_ScorpidSting = "Skorpidstich";
	LOCALIZATION_ZORLEN_DistractingShot = "Ablenkender Schuss";
	LOCALIZATION_ZORLEN_AimedShot = "Gezielter Schuss";
	LOCALIZATION_ZORLEN_HuntersMark = "Mal des J\195\164gers";
	LOCALIZATION_ZORLEN_AspectOfTheHawk = "Aspekt des Falken";
	LOCALIZATION_ZORLEN_AspectOfTheMonkey = "Aspekt des Affen";
	LOCALIZATION_ZORLEN_AspectOfTheCheetah = "Aspekt des Geparden";
	LOCALIZATION_ZORLEN_AspectOfThePack = "Aspekt des Rudels";
	LOCALIZATION_ZORLEN_AspectOfTheWild = "Aspekt der Wildniss";
	LOCALIZATION_ZORLEN_AspectOfTheBeast = "Aspekt des Wildtieres";
	LOCALIZATION_ZORLEN_WingClip = "Zurechtstutzen";
	LOCALIZATION_ZORLEN_FreezingTrap = "Eisk\195\164ltefalle";
	LOCALIZATION_ZORLEN_FrostTrap = "Frostfalle";
	LOCALIZATION_ZORLEN_ExplosiveTrap = "Sprengfalle";
	LOCALIZATION_ZORLEN_ImmolationTrap = "Feuerbrandfalle";
	LOCALIZATION_ZORLEN_FeignDeath = "Totstellen";
	LOCALIZATION_ZORLEN_Counterattack = "Gegenangriff";
	LOCALIZATION_ZORLEN_TranquilizingShot = "Einlullender Schuss";
	LOCALIZATION_ZORLEN_Disengage = "R\195\188ckzug";
	LOCALIZATION_ZORLEN_EyesOfTheBeast = "Augen des Wildtiers";
	LOCALIZATION_ZORLEN_BeastLore = "Wildtierkunde";
	LOCALIZATION_ZORLEN_TrackBeasts = "Wildtiere aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackDemons = "D\195\164monen aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackDragonkin = "Drachkin aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackElementals = "Elementare aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackGiants = "Riesen aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackHumanoids = "Humanoide aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackUndead = "Untote aufsp\195\188ren";
	LOCALIZATION_ZORLEN_TrackHidden = "Verborgenes aufsp\195\188ren";
	LOCALIZATION_ZORLEN_BestialWrath = "Zorn des Wildtiers";
	LOCALIZATION_ZORLEN_TrueshotAura = "Aura des Volltreffers";
	LOCALIZATION_ZORLEN_ScatterShot = "Streuschuss";
	LOCALIZATION_ZORLEN_WyvernSting = "Stich des Fl\195\188geldrachen";
	LOCALIZATION_ZORLEN_Deterrence = "Abschreckung";
	LOCALIZATION_ZORLEN_EagleEye = "Adlerauge";
	LOCALIZATION_ZORLEN_RapidFire = "Schnellfeuer";
	LOCALIZATION_ZORLEN_MultiShot = "Mehrfachschuss";
	LOCALIZATION_ZORLEN_Flare = "Leuchtfeuer";
	LOCALIZATION_ZORLEN_ScareBeast = "Wildtier \195\164ngstigen";
	LOCALIZATION_ZORLEN_Volley = "Salve";
	LOCALIZATION_ZORLEN_Intimidation = "Einsch\195\188chterung";



-- Zorlen_Warlock.lua file Localization
	--LOCALIZATION_ZORLEN_SoulShard = "";
	LOCALIZATION_ZORLEN_AmplifyCurse = "Fluch verst\195\164rken";
	LOCALIZATION_ZORLEN_CurseOfAgony = "Fluch der Pein";
	LOCALIZATION_ZORLEN_CurseOfDoom = "Fluch der Verdammnis";
	LOCALIZATION_ZORLEN_CurseOfShadow = "Schattenfluch";
	LOCALIZATION_ZORLEN_CurseOfTheElements = "Fluch der Elemente";
	LOCALIZATION_ZORLEN_CurseOfWeakness = "Fluch der Schw\195\164che";
	LOCALIZATION_ZORLEN_CurseOfExhaustion = "Fluch der Ersch\195\182pfung";
	LOCALIZATION_ZORLEN_CurseOfRecklessness = "Fluch der Tollk\195\188hnheit";
	LOCALIZATION_ZORLEN_CurseOfTongues = "Fluch der Sprachen";
	LOCALIZATION_ZORLEN_Corruption = "Verderbnis";
	LOCALIZATION_ZORLEN_ImprovedCorruption = "Verbesserte Verderbnis";
	LOCALIZATION_ZORLEN_Immolate = "Feuerbrand";
	LOCALIZATION_ZORLEN_SiphonLife = "Lebensentzug";
	LOCALIZATION_ZORLEN_DrainLife = "Blutsauger";
	LOCALIZATION_ZORLEN_DrainMana = "Mana entziehen";
	LOCALIZATION_ZORLEN_Hellfire = "H\195\182llenfeuer";
	LOCALIZATION_ZORLEN_RainOfFire = "Feuerregen";
	LOCALIZATION_ZORLEN_DrainSoul = "Seelendieb";
	LOCALIZATION_ZORLEN_LifeTap = "Aderlass";
	LOCALIZATION_ZORLEN_ImprovedLifeTap = "Verbesserter Aderlass";
	LOCALIZATION_ZORLEN_DarkPact = "Dunkler Pakt";
	LOCALIZATION_ZORLEN_Nightfall = "Einbruch der Nacht";
	LOCALIZATION_ZORLEN_ShadowBolt = "Schattenblitz";
	LOCALIZATION_ZORLEN_Banish = "Verbannen";
	LOCALIZATION_ZORLEN_Conflagrate = "Feuersbrunst";
	LOCALIZATION_ZORLEN_CreateFirestoneLesser = "Feuerstein herstellen (gering)";
	LOCALIZATION_ZORLEN_CreateFirestone = "Feuerstein herstellen";
	LOCALIZATION_ZORLEN_CreateFirestoneGreater = "Feuerstein herstellen (gro\195\159)";
	LOCALIZATION_ZORLEN_CreateFirestoneMajor = "Feuerstein herstellen (erheblich)";
	LOCALIZATION_ZORLEN_CreateHealthstoneMinor = "Gesundheitsstein herstellen (schwach)";
	LOCALIZATION_ZORLEN_CreateHealthstoneLesser = "Gesundheitsstein herstellen (gering)";
	LOCALIZATION_ZORLEN_CreateHealthstone = "Gesundheitsstein herstellen";
	LOCALIZATION_ZORLEN_CreateHealthstoneGreater = "Gesundheitsstein herstellen (gro\195\159)";
	LOCALIZATION_ZORLEN_CreateHealthstoneMajor = "Gesundheitsstein herstellen (erheblich)";
	LOCALIZATION_ZORLEN_CreateSoulstoneMinor = "Seelenstein herstellen (schwach)";
	LOCALIZATION_ZORLEN_CreateSoulstoneLesser = "Seelenstein herstellen (gering)";
	LOCALIZATION_ZORLEN_CreateSoulstone = "Seelenstein herstellen";
	LOCALIZATION_ZORLEN_CreateSoulstoneGreater = "Seelenstein herstellen (gro\195\159)";
	LOCALIZATION_ZORLEN_CreateSoulstoneMajor = "Seelenstein herstellen (erheblich)";
	LOCALIZATION_ZORLEN_CreateSpellstone = "Zauberstein herstellen";
	LOCALIZATION_ZORLEN_CreateSpellstoneGreater = "Zauberstein herstellen (gro\195\159)";
	LOCALIZATION_ZORLEN_CreateSpellstoneMajor = "Zauberstein herstellen (erheblich)";
	LOCALIZATION_ZORLEN_DeathCoil = "Todesmantel";
	LOCALIZATION_ZORLEN_DemonArmor = "D\195\164monenr\195\188stung";
	LOCALIZATION_ZORLEN_DemonSkin = "D\195\164monenhaut";
	LOCALIZATION_ZORLEN_DemonicSacrifice = "D\195\164monenopferung";
	LOCALIZATION_ZORLEN_DetectLesserInvisibility = "Geringe Unsichtbarkeit entdecken";
	LOCALIZATION_ZORLEN_DetectInvisibility = "Unsichtbarkeit entdecken";
	LOCALIZATION_ZORLEN_DetectGreaterInvisibility = "Gro\195\159e Unsichtbarkeit entdecken";
	LOCALIZATION_ZORLEN_EnslaveDemon = "D\195\164monensklave";
	LOCALIZATION_ZORLEN_EyeOfKilrogg = "Auge von Kilrogg";
	LOCALIZATION_ZORLEN_Fear = "Furcht";
	LOCALIZATION_ZORLEN_FelDomination = "Teufelsbeherrschung";
	LOCALIZATION_ZORLEN_HealthFunnel = "Lebenslinie";
	LOCALIZATION_ZORLEN_HowlOfTerror = "Schreckgeheul";
	LOCALIZATION_ZORLEN_Inferno = "Inferno";
	LOCALIZATION_ZORLEN_RitualOfDoom = "Ritual der Verdammnis";
	LOCALIZATION_ZORLEN_RitualOfSummoning = "Ritual der Herbeirufung";
	LOCALIZATION_ZORLEN_SearingPain = "Sengender Schmerz";
	LOCALIZATION_ZORLEN_SenseDemons = "D\195\164monen sp\195\188ren";
	LOCALIZATION_ZORLEN_ShadowWard = "Schatten-Zauberschutz";
	LOCALIZATION_ZORLEN_Shadowburn = "Schattenbrand";
	LOCALIZATION_ZORLEN_SoulFire = "Seelenfeuer";
	LOCALIZATION_ZORLEN_SoulLink = "Seelenverbindung";
	--LOCALIZATION_ZORLEN_SummonDreadsteed = "";
	LOCALIZATION_ZORLEN_SummonFelhunter = "teufelsj\195\164ger beschw\195\182ren";
	--LOCALIZATION_ZORLEN_SummonFelsteed = "";
	LOCALIZATION_ZORLEN_SummonImp = "Wichtel beschw\195\182ren";
	LOCALIZATION_ZORLEN_SummonSuccubus = "Succubus beschw\195\182ren";
	LOCALIZATION_ZORLEN_SummonVoidwalker = "Leerwandler beschw\195\182ren";
	LOCALIZATION_ZORLEN_UnendingBreath = "Unendlicher Atem";
	--LOCALIZATION_ZORLEN_FelConcentration = "";



-- Zorlen_Druid.lua file Localization
	LOCALIZATION_ZORLEN_TravelForm = "Reisegestalt";
	LOCALIZATION_ZORLEN_MoonkinForm = "Moonkingestalt";
	LOCALIZATION_ZORLEN_BearForm = "B\195\164rengestalt";
	LOCALIZATION_ZORLEN_DireBearForm = "Terrorb\195\164rengestalt";
	LOCALIZATION_ZORLEN_CatForm = "Katzengestalt";
	LOCALIZATION_ZORLEN_AquaticForm = "Wassergestalt";
	--LOCALIZATION_ZORLEN_ChallengingRoar = "";
	--LOCALIZATION_ZORLEN_DemoralizingRoar = "";
	--LOCALIZATION_ZORLEN_AbolishPoison = "";
	--LOCALIZATION_ZORLEN_Barkskin = "";
	--LOCALIZATION_ZORLEN_Bash = "";
	LOCALIZATION_ZORLEN_Claw = "Klaue";
	LOCALIZATION_ZORLEN_Cower = "Ducken";
	LOCALIZATION_ZORLEN_Dash = "Spurt";
	--LOCALIZATION_ZORLEN_Enrage = "";
	--LOCALIZATION_ZORLEN_EntanglingRoots = "";
	--LOCALIZATION_ZORLEN_FaerieFire = "";
	--LOCALIZATION_ZORLEN_FaerieFireFeral = "";
	--LOCALIZATION_ZORLEN_FeralCharge = "";
	--LOCALIZATION_ZORLEN_FerociousBite = "";
	--LOCALIZATION_ZORLEN_FrenziedRegeneration = "";
	--LOCALIZATION_ZORLEN_GiftOfTheWild = "";
	--LOCALIZATION_ZORLEN_HealingTouch = "";
	--LOCALIZATION_ZORLEN_Hibernate = "";
	--LOCALIZATION_ZORLEN_Hurricane = "";
	--LOCALIZATION_ZORLEN_Innervate = "";
	--LOCALIZATION_ZORLEN_InsectSwarm = "";
	--LOCALIZATION_ZORLEN_LeaderOfThePack = "";
	--LOCALIZATION_ZORLEN_MarkOfTheWild = "";
	--LOCALIZATION_ZORLEN_Maul = "";
	--LOCALIZATION_ZORLEN_Moonfire = "";
	--LOCALIZATION_ZORLEN_NaturesGrasp = "";
	--LOCALIZATION_ZORLEN_NaturesSwiftness = "";
	--LOCALIZATION_ZORLEN_OmenOfClarity = "";
	--LOCALIZATION_ZORLEN_Pounce = "";
	LOCALIZATION_ZORLEN_Prowl = "Schleichen";
	--LOCALIZATION_ZORLEN_Rake = "";
	--LOCALIZATION_ZORLEN_Ravage = "";
	--LOCALIZATION_ZORLEN_Rebirth = "";
	--LOCALIZATION_ZORLEN_Regrowth = "";
	--LOCALIZATION_ZORLEN_Rejuvenation = "";
	--LOCALIZATION_ZORLEN_RemoveCurse = "";
	--LOCALIZATION_ZORLEN_Rip = "";
	--LOCALIZATION_ZORLEN_Shred = "";
	--LOCALIZATION_ZORLEN_SootheAnimal = "";
	--LOCALIZATION_ZORLEN_Starfire = "";
	--LOCALIZATION_ZORLEN_Swipe = "";
	--LOCALIZATION_ZORLEN_Thorns = "";
	--LOCALIZATION_ZORLEN_TigersFury = "";
	LOCALIZATION_ZORLEN_TrackHumanoids = "Humanoide aufsp\195\188ren";
	--LOCALIZATION_ZORLEN_Tranquility = "";
	--LOCALIZATION_ZORLEN_Wrath = "";
	--LOCALIZATION_ZORLEN_ImprovedWrath = "";
	--LOCALIZATION_ZORLEN_ImprovedNaturesGrasp = "";
	--LOCALIZATION_ZORLEN_ImprovedEntanglingRoots = "";
	--LOCALIZATION_ZORLEN_ImprovedMoonfire = "";
	--LOCALIZATION_ZORLEN_NaturalWeapons = "";
	--LOCALIZATION_ZORLEN_NaturalShapeshifter = "";
	--LOCALIZATION_ZORLEN_ImprovedThorns = "";
	--LOCALIZATION_ZORLEN_NaturesReach = "";
	--LOCALIZATION_ZORLEN_Vengeance = "";
	--LOCALIZATION_ZORLEN_ImprovedStarfire = "";
	--LOCALIZATION_ZORLEN_NaturesGrace = "";
	--LOCALIZATION_ZORLEN_Moonglow = "";
	--LOCALIZATION_ZORLEN_Moonfury = "";
	--LOCALIZATION_ZORLEN_Ferocity = "";
	--LOCALIZATION_ZORLEN_FeralAggression = "";
	--LOCALIZATION_ZORLEN_FeralInstinct = "";
	--LOCALIZATION_ZORLEN_BrutalImpact = "";
	--LOCALIZATION_ZORLEN_ThickHide = "";
	--LOCALIZATION_ZORLEN_FelineSwiftness = "";
	--LOCALIZATION_ZORLEN_SharpenedClaws = "";
	--LOCALIZATION_ZORLEN_ImprovedShred = "";
	--LOCALIZATION_ZORLEN_PredatoryStrikes = "";
	--LOCALIZATION_ZORLEN_BloodFrenzy = "";
	--LOCALIZATION_ZORLEN_PrimalFury = "";
	--LOCALIZATION_ZORLEN_SavageFury = "";
	--LOCALIZATION_ZORLEN_HeartOfTheWild = "";
	--LOCALIZATION_ZORLEN_ImprovedMarkOfTheWild = "";
	--LOCALIZATION_ZORLEN_Furor = "";
	--LOCALIZATION_ZORLEN_ImprovedHealingTouch = "";
	--LOCALIZATION_ZORLEN_NaturesFocus = "";
	--LOCALIZATION_ZORLEN_ImprovedEnrage = "";
	--LOCALIZATION_ZORLEN_Reflection = "";
	--LOCALIZATION_ZORLEN_Subtlety = "";
	--LOCALIZATION_ZORLEN_TranquilSpirit = "";
	--LOCALIZATION_ZORLEN_ImprovedRejuvenation = "";
	--LOCALIZATION_ZORLEN_GiftOfNature = "";
	--LOCALIZATION_ZORLEN_ImprovedTranquility = "";
	--LOCALIZATION_ZORLEN_ImprovedRegrowth = "";



-- Zorlen_Mage.lua file Localization
	--LOCALIZATION_ZORLEN_AmplifyMagic = "";
	--LOCALIZATION_ZORLEN_ArcaneBrilliance = "";
	--LOCALIZATION_ZORLEN_ArcaneExplosion = "";
	--LOCALIZATION_ZORLEN_ArcaneIntellect = "";
	--LOCALIZATION_ZORLEN_ArcaneMissiles = "";
	--LOCALIZATION_ZORLEN_ArcanePower = "";
	--LOCALIZATION_ZORLEN_BlastWave = "";
	--LOCALIZATION_ZORLEN_Blink = "";
	--LOCALIZATION_ZORLEN_Blizzard = "";
	--LOCALIZATION_ZORLEN_ColdSnap = "";
	--LOCALIZATION_ZORLEN_Combustion = "";
	--LOCALIZATION_ZORLEN_ConeOfCold = "";
	--LOCALIZATION_ZORLEN_ConjureFood = "";
	--LOCALIZATION_ZORLEN_ConjureManaAgate = "";
	--LOCALIZATION_ZORLEN_ConjureManaJade = "";
	--LOCALIZATION_ZORLEN_ConjureManaCitrine = "";
	--LOCALIZATION_ZORLEN_ConjureManaRuby = "";
	--LOCALIZATION_ZORLEN_ConjureWater = "";
	--LOCALIZATION_ZORLEN_Counterspell = "";
	--LOCALIZATION_ZORLEN_DampenMagic = "";
	--LOCALIZATION_ZORLEN_DetectMagic = "";
	--LOCALIZATION_ZORLEN_Evocation = "";
	--LOCALIZATION_ZORLEN_FireBlast = "";
	--LOCALIZATION_ZORLEN_FireWard = "";
	--LOCALIZATION_ZORLEN_Fireball = "";
	--LOCALIZATION_ZORLEN_Flamestrike = "";
	--LOCALIZATION_ZORLEN_FrostArmor = "";
	--LOCALIZATION_ZORLEN_FrostNova = "";
	--LOCALIZATION_ZORLEN_FrostWard = "";
	--LOCALIZATION_ZORLEN_Frostbolt = "";
	--LOCALIZATION_ZORLEN_IceArmor = "";
	--LOCALIZATION_ZORLEN_IceBarrier = "";
	--LOCALIZATION_ZORLEN_IceBlock = "";
	--LOCALIZATION_ZORLEN_MageArmor = "";
	--LOCALIZATION_ZORLEN_ManaShield = "";
	--LOCALIZATION_ZORLEN_Polymorph = "";
	--LOCALIZATION_ZORLEN_PortalDarnassus = "";
	--LOCALIZATION_ZORLEN_PortalIronforge = "";
	--LOCALIZATION_ZORLEN_PortalOrgrimmar = "";
	--LOCALIZATION_ZORLEN_PortalStormwind = "";
	--LOCALIZATION_ZORLEN_PortalThunderBluff = "";
	--LOCALIZATION_ZORLEN_PortalUndercity = "";
	--LOCALIZATION_ZORLEN_TeleportDarnassus = "";
	--LOCALIZATION_ZORLEN_TeleportIronforge = "";
	--LOCALIZATION_ZORLEN_TeleportOrgrimmar = "";
	--LOCALIZATION_ZORLEN_TeleportStormwind = "";
	--LOCALIZATION_ZORLEN_TeleportThunderBluff = "";
	--LOCALIZATION_ZORLEN_TeleportUndercity = "";
	--LOCALIZATION_ZORLEN_PresenceOfMind = "";
	--LOCALIZATION_ZORLEN_Pyroblast = "";
	--LOCALIZATION_ZORLEN_RemoveLesserCurse = "";
	--LOCALIZATION_ZORLEN_Scorch = "";
	--LOCALIZATION_ZORLEN_SlowFall = "";



-- Zorlen_Paladin.lua file Localization
	--LOCALIZATION_ZORLEN_BlessingOfFreedom = "";
	--LOCALIZATION_ZORLEN_BlessingOfKings = "";
	--LOCALIZATION_ZORLEN_BlessingOfLight = "";
	--LOCALIZATION_ZORLEN_BlessingOfMight = "";
	--LOCALIZATION_ZORLEN_BlessingOfProtection = "";
	--LOCALIZATION_ZORLEN_BlessingOfSacrifice = "";
	--LOCALIZATION_ZORLEN_BlessingOfSalvation = "";
	--LOCALIZATION_ZORLEN_BlessingOfSanctuary = "";
	--LOCALIZATION_ZORLEN_BlessingOfWisdom = "";
	--LOCALIZATION_ZORLEN_Cleanse = "";
	--LOCALIZATION_ZORLEN_ConcentrationAura = "";
	--LOCALIZATION_ZORLEN_Consecration = "";
	--LOCALIZATION_ZORLEN_DevotionAura = "";
	--LOCALIZATION_ZORLEN_DivineFavor = "";
	--LOCALIZATION_ZORLEN_DivineIntervention = "";
	--LOCALIZATION_ZORLEN_DivineProtection = "";
	--LOCALIZATION_ZORLEN_DivineShield = "";
	--LOCALIZATION_ZORLEN_Exorcism = "";
	--LOCALIZATION_ZORLEN_FireResistanceAura = "";
	--LOCALIZATION_ZORLEN_FlashOfLight = "";
	--LOCALIZATION_ZORLEN_FrostResistanceAura = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfKings = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfLight = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfMight = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfSalvation = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfSanctuary = "";
	--LOCALIZATION_ZORLEN_GreaterBlessingOfWisdom = "";
	--LOCALIZATION_ZORLEN_HammerOfJustice = "";
	--LOCALIZATION_ZORLEN_HammerOfWrath = "";
	--LOCALIZATION_ZORLEN_HolyLight = "";
	--LOCALIZATION_ZORLEN_HolyShield = "";
	--LOCALIZATION_ZORLEN_HolyShock = "";
	--LOCALIZATION_ZORLEN_HolyWrath = "";
	--LOCALIZATION_ZORLEN_Judgement = "";
	--LOCALIZATION_ZORLEN_LayOnHands = "";
	--LOCALIZATION_ZORLEN_Purify = "";
	--LOCALIZATION_ZORLEN_Redemption = "";
	--LOCALIZATION_ZORLEN_Repentance = "";
	--LOCALIZATION_ZORLEN_RetributionAura = "";
	--LOCALIZATION_ZORLEN_RighteousFury = "";
	--LOCALIZATION_ZORLEN_SanctityAura = "";
	--LOCALIZATION_ZORLEN_SealOfCommand = "";
	--LOCALIZATION_ZORLEN_SealOfJustice = "";
	--LOCALIZATION_ZORLEN_SealOfLight = "";
	--LOCALIZATION_ZORLEN_SealOfRighteousness = "";
	--LOCALIZATION_ZORLEN_SealOfWisdom = "";
	--LOCALIZATION_ZORLEN_SealOfTheCrusader = "";
	--LOCALIZATION_ZORLEN_SenseUndead = "";
	--LOCALIZATION_ZORLEN_ShadowResistanceAura = "";
	--LOCALIZATION_ZORLEN_SummonCharger = "";
	--LOCALIZATION_ZORLEN_SummonWarhorse = "";
	--LOCALIZATION_ZORLEN_TurnUndead = "";



-- Zorlen_Priest.lua file Localization
	--LOCALIZATION_ZORLEN_AbolishDisease = "";
	--LOCALIZATION_ZORLEN_CureDisease = "";
	--LOCALIZATION_ZORLEN_DesperatePrayer = "";
	--LOCALIZATION_ZORLEN_DevouringPlague = "";
	--LOCALIZATION_ZORLEN_DispelMagic = "";
	--LOCALIZATION_ZORLEN_DivineSpirit = "";
	--LOCALIZATION_ZORLEN_ElunesGrace = "";
	--LOCALIZATION_ZORLEN_Fade = "";
	--LOCALIZATION_ZORLEN_FearWard = "";
	--LOCALIZATION_ZORLEN_Feedback = "";
	--LOCALIZATION_ZORLEN_FlashHeal = "";
	--LOCALIZATION_ZORLEN_FocusedCasting = "";
	--LOCALIZATION_ZORLEN_LesserHeal = "";
	--LOCALIZATION_ZORLEN_Heal = "";
	--LOCALIZATION_ZORLEN_GreaterHeal = "";
	--LOCALIZATION_ZORLEN_HexOfWeakness = "";
	--LOCALIZATION_ZORLEN_HolyFire = "";
	--LOCALIZATION_ZORLEN_HolyNova = "";
	--LOCALIZATION_ZORLEN_InnerFire = "";
	--LOCALIZATION_ZORLEN_InnerFocus = "";
	--LOCALIZATION_ZORLEN_Levitate = "";
	--LOCALIZATION_ZORLEN_ManaBurn = "";
	--LOCALIZATION_ZORLEN_MindBlast = "";
	--LOCALIZATION_ZORLEN_MindControl = "";
	--LOCALIZATION_ZORLEN_MindFlay = "";
	--LOCALIZATION_ZORLEN_MindSoothe = "";
	--LOCALIZATION_ZORLEN_MindVision = "";
	--LOCALIZATION_ZORLEN_PowerWordFortitude = "";
	--LOCALIZATION_ZORLEN_PowerWordShield = "";
	--LOCALIZATION_ZORLEN_PrayerOfFortitude = "";
	--LOCALIZATION_ZORLEN_PrayerOfHealing = "";
	--LOCALIZATION_ZORLEN_PsychicScream = "";
	--LOCALIZATION_ZORLEN_Renew = "";
	--LOCALIZATION_ZORLEN_Resurrection = "";
	--LOCALIZATION_ZORLEN_ShackleUndead = "";
	--LOCALIZATION_ZORLEN_ShadowProtection = "";
	--LOCALIZATION_ZORLEN_ShadowWordPain = "";
	--LOCALIZATION_ZORLEN_Shadowform = "";
	--LOCALIZATION_ZORLEN_Shadowguard = "";
	--LOCALIZATION_ZORLEN_Silence = "";
	--LOCALIZATION_ZORLEN_Smite = "";
	--LOCALIZATION_ZORLEN_SpiritOfRedemption = "";
	--LOCALIZATION_ZORLEN_Starshards = "";
	--LOCALIZATION_ZORLEN_TouchOfWeakness = "";
	--LOCALIZATION_ZORLEN_VampiricEmbrace = "";



-- Zorlen_Rogue.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedCheapShot = "Verbesserter Fieser Trick";
	LOCALIZATION_ZORLEN_ImprovedSinisterStrike = "Verbesserter Finsterer Sto/195/159";
	LOCALIZATION_ZORLEN_CripplingPoison = "Verkr\195\188ppeldes Gift";
	LOCALIZATION_ZORLEN_CripplingPoisonII = "Verkr\195\188ppeldes Gift II";
	LOCALIZATION_ZORLEN_DeadlyPoison = "T\195\182dliches Gift";
	LOCALIZATION_ZORLEN_DeadlyPoisonII = "T\195\182dliches Gift II";
	LOCALIZATION_ZORLEN_DeadlyPoisonIII = "T\195\182dliches Gift III";
	LOCALIZATION_ZORLEN_DeadlyPoisonIV = "T\195\182dliches Gift IV";
	LOCALIZATION_ZORLEN_DeadlyPoisonV = "T\195\182dliches Gift V";
	LOCALIZATION_ZORLEN_InstantPoison = "Sofortwirkendes Gift";
	LOCALIZATION_ZORLEN_InstantPoisonII = "Sofortwirkendes Gift II";
	LOCALIZATION_ZORLEN_InstantPoisonIII = "Sofortwirkendes Gift III";
	LOCALIZATION_ZORLEN_InstantPoisonIV = "Sofortwirkendes Gift IV";
	LOCALIZATION_ZORLEN_InstantPoisonV = "Sofortwirkendes Gift V";
	LOCALIZATION_ZORLEN_InstantPoisonVI = "Sofortwirkendes Gift VI";
	LOCALIZATION_ZORLEN_MindnumbingPoison = "Gedankenblendendes Gift";
	LOCALIZATION_ZORLEN_MindnumbingPoisonII = "Gedankenblendendes Gift II";
	LOCALIZATION_ZORLEN_MindnumbingPoisonIII = "Gedankenblendendes Gift III";
	LOCALIZATION_ZORLEN_WoundPoison = "Wundgift";
	LOCALIZATION_ZORLEN_WoundPoisonII = "Wundgift II";
	LOCALIZATION_ZORLEN_WoundPoisonIII = "Wundgift III";
	LOCALIZATION_ZORLEN_WoundPoisonIV = "Wundgift IV";
	LOCALIZATION_ZORLEN_AdrenalineRush = "Adrenalinrausch";
	LOCALIZATION_ZORLEN_Ambush = "Hinterhalt";
	LOCALIZATION_ZORLEN_Backstab = "Meucheln";
	LOCALIZATION_ZORLEN_BladeFlurry = "Klingenwirbel";
	LOCALIZATION_ZORLEN_Blind = "Blenden";
	LOCALIZATION_ZORLEN_BlindingPowder = "Blendungspulver";
	LOCALIZATION_ZORLEN_CheapShot = "Fieser Trick";
	LOCALIZATION_ZORLEN_ColdBlood = "Kaltbl\195\188tigkeit";
	LOCALIZATION_ZORLEN_DetectTraps = "Fallen entdecken";
	LOCALIZATION_ZORLEN_DisarmTrap = "Fallen entsch\195\164rfen";
	LOCALIZATION_ZORLEN_Distract = "Ablenken";
	LOCALIZATION_ZORLEN_Evasion = "Entrinnen";
	LOCALIZATION_ZORLEN_Eviscerate = "Ausweiden";
	LOCALIZATION_ZORLEN_ExposeArmor = "R\195\188stung schw\195\164chen";
	LOCALIZATION_ZORLEN_Feint = "Finte";
	LOCALIZATION_ZORLEN_Garrote = "Erdrosseln";
	LOCALIZATION_ZORLEN_GhostlyStrike = "Geisterhafter Sto/195/159";
	LOCALIZATION_ZORLEN_Gouge = "Solarplexus";
	LOCALIZATION_ZORLEN_Hemorrhage = "Blutsturz";
	LOCALIZATION_ZORLEN_Kick = "Tritt";
	LOCALIZATION_ZORLEN_KidneyShot = "Nierenhieb";
	LOCALIZATION_ZORLEN_PickLock = "Schl\195\182sser knacken";
	LOCALIZATION_ZORLEN_PickPocket = "Taschendiebstahl";
	LOCALIZATION_ZORLEN_Premeditation = "Konzentration";
	LOCALIZATION_ZORLEN_Preparation = "Vorbereitung";
	LOCALIZATION_ZORLEN_RelentlessStrikes = "Unerbitliche St\195\182/195/159e";
	LOCALIZATION_ZORLEN_Riposte = "Riposte";
	LOCALIZATION_ZORLEN_Rupture = "Blutung";
	LOCALIZATION_ZORLEN_Sap = "Kopfnuss";
	LOCALIZATION_ZORLEN_SinisterStrike = "Finsterer Sto/195/159";
	LOCALIZATION_ZORLEN_SliceAndDice = "Zerh\195\164chseln";
	LOCALIZATION_ZORLEN_Sprint = "Sprinten";
	LOCALIZATION_ZORLEN_Stealth = "Verstohlenheit";
	LOCALIZATION_ZORLEN_Vanish = "Verschwinden";



-- Zorlen_Shaman.lua file Localization
	--LOCALIZATION_ZORLEN_DiseaseCleansingTotem = "";
	--LOCALIZATION_ZORLEN_EarthbindTotem = "";
	--LOCALIZATION_ZORLEN_FireNovaTotem = "";
	--LOCALIZATION_ZORLEN_FireResistanceTotem = "";
	--LOCALIZATION_ZORLEN_FlametongueTotem = "";
	--LOCALIZATION_ZORLEN_FrostResistanceTotem = "";
	--LOCALIZATION_ZORLEN_GraceOfAirTotem = "";
	--LOCALIZATION_ZORLEN_GroundingTotem = "";
	--LOCALIZATION_ZORLEN_HealingStreamTotem = "";
	--LOCALIZATION_ZORLEN_MagmaTotem = "";
	--LOCALIZATION_ZORLEN_ManaSpringTotem = "";
	--LOCALIZATION_ZORLEN_ManaTideTotem = "";
	--LOCALIZATION_ZORLEN_NatureResistanceTotem = "";
	--LOCALIZATION_ZORLEN_PoisonCleansingTotem = "";
	--LOCALIZATION_ZORLEN_SearingTotem = "";
	--LOCALIZATION_ZORLEN_SentryTotem = "";
	--LOCALIZATION_ZORLEN_StoneclawTotem = "";
	--LOCALIZATION_ZORLEN_StoneskinTotem = "";
	--LOCALIZATION_ZORLEN_StrengthOfEarthTotem = "";
	--LOCALIZATION_ZORLEN_TremorTotem = "";
	--LOCALIZATION_ZORLEN_WindfuryTotem = "";
	--LOCALIZATION_ZORLEN_WindwallTotem = "";
	--LOCALIZATION_ZORLEN_EarthShock = "";
	--LOCALIZATION_ZORLEN_FlameShock = "";
	--LOCALIZATION_ZORLEN_FrostShock = "";
	--LOCALIZATION_ZORLEN_FlametongueWeapon = "";
	--LOCALIZATION_ZORLEN_FrostbrandWeapon = "";
	--LOCALIZATION_ZORLEN_RockbiterWeapon = "";
	--LOCALIZATION_ZORLEN_WindfuryWeapon = "";
	--LOCALIZATION_ZORLEN_AncestralSpirit = "";
	--LOCALIZATION_ZORLEN_AstralRecall = "";
	--LOCALIZATION_ZORLEN_ChainHeal = "";
	--LOCALIZATION_ZORLEN_ChainLightning = "";
	--LOCALIZATION_ZORLEN_CureDisease = "";
	--LOCALIZATION_ZORLEN_CurePoison = "";
	--LOCALIZATION_ZORLEN_ElementalFocus = "";
	--LOCALIZATION_ZORLEN_ElementalMastery = "";
	--LOCALIZATION_ZORLEN_FarSight = "";
	--LOCALIZATION_ZORLEN_GhostWolf = "";
	--LOCALIZATION_ZORLEN_LesserHealingWave = "";
	--LOCALIZATION_ZORLEN_HealingWave = "";
	--LOCALIZATION_ZORLEN_LightningBolt = "";
	--LOCALIZATION_ZORLEN_LightningShield = "";
	--LOCALIZATION_ZORLEN_NaturesSwiftness = "";
	--LOCALIZATION_ZORLEN_Purge = "";
	--LOCALIZATION_ZORLEN_Reincarnation = "";
	--LOCALIZATION_ZORLEN_Stormstrike = "";
	--LOCALIZATION_ZORLEN_WaterBreathing = "";
	--LOCALIZATION_ZORLEN_WaterWalking = "";



-- Zorlen_Warrior.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedOverpower = "Verbesserter Überw\195\164ltigen";
	LOCALIZATION_ZORLEN_ImprovedBerserkerRage = "Verbesserter Berserkerwut";
	LOCALIZATION_ZORLEN_ImprovedExecute = "Verbessertes Hinrichten";
	LOCALIZATION_ZORLEN_Execute = "Hinrichten";
	LOCALIZATION_ZORLEN_ImprovedHeroicStrike = "Verbesserter Heldenhafter Sto\195\159";
	LOCALIZATION_ZORLEN_HeroicStrike = "Heldenhafter Sto\195\159";
	LOCALIZATION_ZORLEN_ImprovedSunderArmor = "Verbessertes R\195\188stung zerrei\195\159en";
	LOCALIZATION_ZORLEN_SunderArmor = "R\195\188stung zerrei\195\159en";
	LOCALIZATION_ZORLEN_ImprovedThunderClap = "Verbesserter Donnerknall";
	LOCALIZATION_ZORLEN_ThunderClap = "Donnerknall";
	LOCALIZATION_ZORLEN_MortalStrike = "T\195\182dlicher Sto\195\159";
	LOCALIZATION_ZORLEN_Bloodthirst = "Blutdurst";
	LOCALIZATION_ZORLEN_ShieldSlam = "Schilddisziplin";
	LOCALIZATION_ZORLEN_Charge = "Sturmangriff";
	LOCALIZATION_ZORLEN_Taunt = "Spott";
	LOCALIZATION_ZORLEN_Intercept = "Abfangen";
	LOCALIZATION_ZORLEN_Overpower = "Überw\195\164ltigen";
	LOCALIZATION_ZORLEN_Revenge = "Rache";
	LOCALIZATION_ZORLEN_Rend = "Verwunden";
	LOCALIZATION_ZORLEN_Hamstring = "Kniesehne";
	LOCALIZATION_ZORLEN_ShieldBash = "Schildhieb";
	LOCALIZATION_ZORLEN_Pummel = "Zuschlagen";
	LOCALIZATION_ZORLEN_ShieldBlock = "Schildblock";
	LOCALIZATION_ZORLEN_DemoralizingShout = "Demoralisierungsruf";
	LOCALIZATION_ZORLEN_BattleShout = "Schlachtruf";
	LOCALIZATION_ZORLEN_BerserkerRage = "Berserkerwut";
	LOCALIZATION_ZORLEN_Enrage = "Wutanfall";
	LOCALIZATION_ZORLEN_DefensiveStance = "Verteidigungshaltung";
	LOCALIZATION_ZORLEN_BattleStance = "Kampfhaltung";
	LOCALIZATION_ZORLEN_BerserkerStance = "Berserkerhaltung";
	LOCALIZATION_ZORLEN_AngerManagement = "Agressionskontrolle";
	LOCALIZATION_ZORLEN_Bloodrage = "Blutrausch";
	LOCALIZATION_ZORLEN_ChallengingShout = "Herausforderungsruf";
	LOCALIZATION_ZORLEN_Cleave = "Spalten";
	LOCALIZATION_ZORLEN_ConcussionBlow = "Ersch\195\188tternder Schlag";
	LOCALIZATION_ZORLEN_DeathWish = "Todeswunsch";
	LOCALIZATION_ZORLEN_Disarm = "Entwaffnen";
	LOCALIZATION_ZORLEN_IntimidatingShout = "Drohruf";
	LOCALIZATION_ZORLEN_LastStand = "Letztes Gefecht";
	LOCALIZATION_ZORLEN_MockingBlow = "Sp\195\182ttischer Schlag";
	LOCALIZATION_ZORLEN_PiercingHowl = "Durchdringendes Heulen";
	LOCALIZATION_ZORLEN_Recklessness = "Tollk\195\188hnheit";
	LOCALIZATION_ZORLEN_Retaliation = "Gegenschlag";
	LOCALIZATION_ZORLEN_ShieldWall = "Schildwall";
	LOCALIZATION_ZORLEN_Slam = "Zerschmettern";
	LOCALIZATION_ZORLEN_SweepingStrikes = "Weitreichende St\195\182\195\159e";
	LOCALIZATION_ZORLEN_Whirlwind = "Wirbelwind";
	LOCALIZATION_ZORLEN_TacticalMastery = "Taktischer Einsatz";
end
