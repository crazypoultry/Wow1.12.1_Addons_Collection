-- Chinese (traditional) Translation
-- If you want to translate this to another language, make sure the names of buffs and abilities are *EXACTLY* the same as in-game. Spelling, punctuation, upper/lowercase letters, etc. MUST BE EXACT. Also, any 'foreign' characters must be converted to UNICODE.
-- Unicode resource:  http://www.allegro-c.de/unicode/zcodes.htm


-- To lower the upkeep we will not be adding Localization for english words that do not break compatibility in other game clients.
-- This Localization is only added for compatibility so that it may work in non english game clients and not as a translation.

if GetLocale() == "zhTW" then
-- All file Localization
	LOCALIZATION_ZORLEN_Rank = "等級";
	LOCALIZATION_ZORLEN_sit = "坐下";
	LOCALIZATION_ZORLEN_You_dodge = "你閃躲";
	LOCALIZATION_ZORLEN_Your = "你的";
	LOCALIZATION_ZORLEN_immune = "免疫";
	--LOCALIZATION_ZORLEN_no_weapons_equipped = "";
	LOCALIZATION_ZORLEN_dodged = "閃躲過去";
	LOCALIZATION_ZORLEN_dodges = "閃躲開";
	--LOCALIZATION_ZORLEN_pet_is_not_dead = "";
	--LOCALIZATION_ZORLEN_pet_is_dead = "";
	
	--LOCALIZATION_ZORLEN_PlusHealMinScan = "";
	--LOCALIZATION_ZORLEN_PlusHealMaxScan = "";
	--LOCALIZATION_ZORLEN_VariableHealScanEquip = "";
	--LOCALIZATION_ZORLEN_VariableHealScanSet = "";

-- Example: /script Zorlen_GiveName_OffHandType()
-- The example above will give the name required for LOCALIZATION_ZORLEN_Shields
-- You must have a shield equipped to get the correct name.
-- You can also get the correct name from the auction house filters under the Armor section.
	--LOCALIZATION_ZORLEN_Shields = "";
	
-- Example: /script Zorlen_GiveName_MainHandType()
-- The example above will give the name required for the weapons below.
-- You must have the weapon equipped to get the correct name.
-- You can also get the correct names from the auction house filters under the Weapon section.
	LOCALIZATION_ZORLEN_Daggers = "匕首";
	LOCALIZATION_ZORLEN_OneHandedSwords = "單手劍";
	LOCALIZATION_ZORLEN_TwoHandedSwords = "雙手劍";
	LOCALIZATION_ZORLEN_OneHandedAxes = "單手斧";
	LOCALIZATION_ZORLEN_TwoHandedAxes = "雙手斧";
	LOCALIZATION_ZORLEN_OneHandedMaces = "單手錘";
	LOCALIZATION_ZORLEN_TwoHandedMaces = "雙手錘";
	LOCALIZATION_ZORLEN_Polearms = "長柄武器";
	LOCALIZATION_ZORLEN_Staves = "法杖";
	LOCALIZATION_ZORLEN_FistWeapons = "拳套";
	LOCALIZATION_ZORLEN_FishingPole = "魚竿";



-- Zorlen_Other.lua file Localization
	LOCALIZATION_ZORLEN_Attack = "攻擊";
	LOCALIZATION_ZORLEN_Throw = "投擲";
	LOCALIZATION_ZORLEN_ShootBow = "弓射擊";
	LOCALIZATION_ZORLEN_ShootCrossbow = "弩射擊";
	LOCALIZATION_ZORLEN_ShootGun = "槍械射擊";
	--LOCALIZATION_ZORLEN_Shoot = "";
-- Human Racial
	LOCALIZATION_ZORLEN_Perception = "感知";
-- Dwarf Racial
	LOCALIZATION_ZORLEN_FindTreasure = "尋找財寶";
	LOCALIZATION_ZORLEN_Stoneform = "石像形態";
-- Gnome Racial
	LOCALIZATION_ZORLEN_EscapeArtist = "脫逃大師";
-- Night Elf Racial
	LOCALIZATION_ZORLEN_Shadowmeld = "影遁";
-- Orc Racial
	LOCALIZATION_ZORLEN_BloodFury = "血性狂暴";
-- Undead Racial
	LOCALIZATION_ZORLEN_Cannibalize = "食屍";
	LOCALIZATION_ZORLEN_WillOfTheForsaken = "亡靈意志";
-- Tauren Racial
	LOCALIZATION_ZORLEN_WarStomp = "戰爭踐踏";
-- Troll Racial
	LOCALIZATION_ZORLEN_Berserking = "狂暴";



-- Zorlen_Pets.lua file Localization
-- Hunter Pets
	LOCALIZATION_ZORLEN_Dash = "突進";
	--LOCALIZATION_ZORLEN_Dive = "";
	LOCALIZATION_ZORLEN_Bite = "撕咬";
	LOCALIZATION_ZORLEN_Claw = "爪擊";
	--LOCALIZATION_ZORLEN_Cower = "";
	--LOCALIZATION_ZORLEN_Growl = "";
	--LOCALIZATION_ZORLEN_Prowl = "";
	--LOCALIZATION_ZORLEN_Charge = "";
	--LOCALIZATION_ZORLEN_Screech = "";
	--LOCALIZATION_ZORLEN_FuriousHowl = "";
	--LOCALIZATION_ZORLEN_LightningBreath = "";
	--LOCALIZATION_ZORLEN_ShellShield = "";
	--LOCALIZATION_ZORLEN_Thunderstomp = "";
	--LOCALIZATION_ZORLEN_ScorpidPoison = "";
-- Warlock Pets
	--LOCALIZATION_ZORLEN_BloodPact = "";
	--LOCALIZATION_ZORLEN_FireShield = "";
	--LOCALIZATION_ZORLEN_Firebolt = "";
	--LOCALIZATION_ZORLEN_PhaseShift = "";
	--LOCALIZATION_ZORLEN_ConsumeShadows = "";
	--LOCALIZATION_ZORLEN_Sacrifice = "";
	--LOCALIZATION_ZORLEN_Suffering = "";
	--LOCALIZATION_ZORLEN_Torment = "";
	--LOCALIZATION_ZORLEN_DevourMagic = "";
	--LOCALIZATION_ZORLEN_Paranoia = "";
	--LOCALIZATION_ZORLEN_SpellLock = "";
	--LOCALIZATION_ZORLEN_TaintedBlood = "";
	--LOCALIZATION_ZORLEN_LashOfPain = "";
	--LOCALIZATION_ZORLEN_Seduction = "";
	--LOCALIZATION_ZORLEN_SoothingKiss = "";
	--LOCALIZATION_ZORLEN_LesserInvisibility = "";



-- Zorlen_Hunter.lua file Localization
	LOCALIZATION_ZORLEN_ImprovedAspectOfTheHawk = "強化雄鷹守護";
	LOCALIZATION_ZORLEN_ImprovedMendPet = "強化治療寵物";
	LOCALIZATION_ZORLEN_MendPet = "治療寵物";
	LOCALIZATION_ZORLEN_CallPet = "召喚寵物";
	LOCALIZATION_ZORLEN_RevivePet = "復活寵物";
	LOCALIZATION_ZORLEN_DismissPet = "解散野獸";
	LOCALIZATION_ZORLEN_AutoShot = "自動射擊";
	LOCALIZATION_ZORLEN_MongooseBite = "貓鼬撕咬";
	LOCALIZATION_ZORLEN_ArcaneShot = "祕法射擊";
	LOCALIZATION_ZORLEN_ConcussiveShot = "震盪射擊";
	LOCALIZATION_ZORLEN_RaptorStrike = "猛禽一擊";
	LOCALIZATION_ZORLEN_SerpentSting = "毒蛇釘刺";
	LOCALIZATION_ZORLEN_ViperSting = "腹蛇釘刺";
	LOCALIZATION_ZORLEN_ScorpidSting = "毒蠍釘刺";
	LOCALIZATION_ZORLEN_DistractingShot = "擾亂射擊";
	LOCALIZATION_ZORLEN_AimedShot = "瞄準射擊";
	LOCALIZATION_ZORLEN_HuntersMark = "獵人印記";
	LOCALIZATION_ZORLEN_AspectOfTheHawk = "雄鷹守護";
	LOCALIZATION_ZORLEN_AspectOfTheMonkey = "靈猴守護";
	LOCALIZATION_ZORLEN_AspectOfTheCheetah = "獵豹守護";
	LOCALIZATION_ZORLEN_AspectOfThePack = "豹群守護";
	LOCALIZATION_ZORLEN_AspectOfTheWild = "野性守護";
	LOCALIZATION_ZORLEN_AspectOfTheBeast = "野獸守護";
	LOCALIZATION_ZORLEN_WingClip = "摔絆";
	LOCALIZATION_ZORLEN_FreezingTrap = "冰凍陷阱";
	LOCALIZATION_ZORLEN_FrostTrap = "冰霜陷阱";
	LOCALIZATION_ZORLEN_ExplosiveTrap = "爆炸陷阱";
	LOCALIZATION_ZORLEN_ImmolationTrap = "獻祭陷阱";
	LOCALIZATION_ZORLEN_FeignDeath = "假死";
	LOCALIZATION_ZORLEN_Counterattack = "反擊";
	LOCALIZATION_ZORLEN_TranquilizingShot = "寧神射擊";
	LOCALIZATION_ZORLEN_Disengage = "逃脫";
	LOCALIZATION_ZORLEN_EyesOfTheBeast = "野獸之眼";
	LOCALIZATION_ZORLEN_BeastLore = "野獸知識";
	LOCALIZATION_ZORLEN_TrackBeasts = "追蹤野獸";
	LOCALIZATION_ZORLEN_TrackDemons = "追蹤惡魔";
	LOCALIZATION_ZORLEN_TrackDragonkin = "追蹤龍類";
	LOCALIZATION_ZORLEN_TrackElementals = "追蹤元素生物";
	LOCALIZATION_ZORLEN_TrackGiants = "追蹤巨人";
	LOCALIZATION_ZORLEN_TrackHumanoids = "追蹤人型生物";
	LOCALIZATION_ZORLEN_TrackUndead = "追蹤亡靈";
	LOCALIZATION_ZORLEN_TrackHidden = "追蹤隱藏生物";
	LOCALIZATION_ZORLEN_BestialWrath = "狂野怒火";
	LOCALIZATION_ZORLEN_TrueshotAura = "強擊光環";
	LOCALIZATION_ZORLEN_ScatterShot = "驅散射擊";
	LOCALIZATION_ZORLEN_WyvernSting = "翼龍釘刺";
	LOCALIZATION_ZORLEN_Deterrence = "威懾";
	LOCALIZATION_ZORLEN_EagleEye = "鷹眼術";
	LOCALIZATION_ZORLEN_RapidFire = "急速射擊";
	LOCALIZATION_ZORLEN_MultiShot = "多重射擊";
	LOCALIZATION_ZORLEN_Flare = "照明彈";
	LOCALIZATION_ZORLEN_ScareBeast = "恐嚇野獸";
	LOCALIZATION_ZORLEN_Volley = "亂射";
	LOCALIZATION_ZORLEN_Intimidation = "脅迫";



-- Zorlen_Warlock.lua file Localization
	--LOCALIZATION_ZORLEN_SoulShard = "";
	--LOCALIZATION_ZORLEN_AmplifyCurse = "";
	--LOCALIZATION_ZORLEN_CurseOfAgony = "";
	--LOCALIZATION_ZORLEN_CurseOfDoom = "";
	--LOCALIZATION_ZORLEN_CurseOfShadow = "";
	--LOCALIZATION_ZORLEN_CurseOfTheElements = "";
	--LOCALIZATION_ZORLEN_CurseOfWeakness = "";
	--LOCALIZATION_ZORLEN_CurseOfExhaustion = "";
	--LOCALIZATION_ZORLEN_CurseOfRecklessness = "";
	--LOCALIZATION_ZORLEN_CurseOfTongues = "";
	--LOCALIZATION_ZORLEN_Corruption = "";
	--LOCALIZATION_ZORLEN_ImprovedCorruption = "";
	--LOCALIZATION_ZORLEN_Immolate = "";
	--LOCALIZATION_ZORLEN_SiphonLife = "";
	--LOCALIZATION_ZORLEN_DrainLife = "";
	--LOCALIZATION_ZORLEN_DrainMana = "";
	--LOCALIZATION_ZORLEN_Hellfire = "";
	--LOCALIZATION_ZORLEN_RainOfFire = "";
	--LOCALIZATION_ZORLEN_DrainSoul = "";
	--LOCALIZATION_ZORLEN_LifeTap = "";
	--LOCALIZATION_ZORLEN_ImprovedLifeTap = "";
	--LOCALIZATION_ZORLEN_DarkPact = "";
	--LOCALIZATION_ZORLEN_Nightfall = "";
	--LOCALIZATION_ZORLEN_ShadowBolt = "";
	--LOCALIZATION_ZORLEN_Banish = "";
	--LOCALIZATION_ZORLEN_Conflagrate = "";
	--LOCALIZATION_ZORLEN_CreateFirestoneLesser = "";
	--LOCALIZATION_ZORLEN_CreateFirestone = "";
	--LOCALIZATION_ZORLEN_CreateFirestoneGreater = "";
	--LOCALIZATION_ZORLEN_CreateFirestoneMajor = "";
	--LOCALIZATION_ZORLEN_CreateHealthstoneMinor = "";
	--LOCALIZATION_ZORLEN_CreateHealthstoneLesser = "";
	--LOCALIZATION_ZORLEN_CreateHealthstone = "";
	--LOCALIZATION_ZORLEN_CreateHealthstoneGreater = "";
	--LOCALIZATION_ZORLEN_CreateHealthstoneMajor = "";
	--LOCALIZATION_ZORLEN_CreateSoulstoneMinor = "";
	--LOCALIZATION_ZORLEN_CreateSoulstoneLesser = "";
	--LOCALIZATION_ZORLEN_CreateSoulstone = "";
	--LOCALIZATION_ZORLEN_CreateSoulstoneGreater = "";
	--LOCALIZATION_ZORLEN_CreateSoulstoneMajor = "";
	--LOCALIZATION_ZORLEN_CreateSpellstone = "";
	--LOCALIZATION_ZORLEN_CreateSpellstoneGreater = "";
	--LOCALIZATION_ZORLEN_CreateSpellstoneMajor = "";
	--LOCALIZATION_ZORLEN_DeathCoil = "";
	--LOCALIZATION_ZORLEN_DemonArmor = "";
	--LOCALIZATION_ZORLEN_DemonSkin = "";
	--LOCALIZATION_ZORLEN_DemonicSacrifice = "";
	--LOCALIZATION_ZORLEN_DetectLesserInvisibility = "";
	--LOCALIZATION_ZORLEN_DetectInvisibility = "";
	--LOCALIZATION_ZORLEN_DetectGreaterInvisibility = "";
	--LOCALIZATION_ZORLEN_EnslaveDemon = "";
	--LOCALIZATION_ZORLEN_EyeOfKilrogg = "";
	--LOCALIZATION_ZORLEN_Fear = "";
	--LOCALIZATION_ZORLEN_FelDomination = "";
	--LOCALIZATION_ZORLEN_HealthFunnel = "";
	--LOCALIZATION_ZORLEN_HowlOfTerror = "";
	--LOCALIZATION_ZORLEN_Inferno = "";
	--LOCALIZATION_ZORLEN_RitualOfDoom = "";
	--LOCALIZATION_ZORLEN_RitualOfSummoning = "";
	--LOCALIZATION_ZORLEN_SearingPain = "";
	--LOCALIZATION_ZORLEN_SenseDemons = "";
	--LOCALIZATION_ZORLEN_ShadowWard = "";
	--LOCALIZATION_ZORLEN_Shadowburn = "";
	--LOCALIZATION_ZORLEN_SoulFire = "";
	--LOCALIZATION_ZORLEN_SoulLink = "";
	--LOCALIZATION_ZORLEN_SummonDreadsteed = "";
	--LOCALIZATION_ZORLEN_SummonFelhunter = "";
	--LOCALIZATION_ZORLEN_SummonFelsteed = "";
	--LOCALIZATION_ZORLEN_SummonImp = "";
	--LOCALIZATION_ZORLEN_SummonSuccubus = "";
	--LOCALIZATION_ZORLEN_SummonVoidwalker = "";
	--LOCALIZATION_ZORLEN_UnendingBreath = "";
	--LOCALIZATION_ZORLEN_FelConcentration = "";



-- Zorlen_Druid.lua file Localization
	LOCALIZATION_ZORLEN_TravelForm = "旅行形態";
	LOCALIZATION_ZORLEN_MoonkinForm = "梟獸形態";
	LOCALIZATION_ZORLEN_BearForm = "熊形態";
	LOCALIZATION_ZORLEN_DireBearForm = "巨熊形態";
	LOCALIZATION_ZORLEN_CatForm = "獵豹形態";
	LOCALIZATION_ZORLEN_AquaticForm = "水棲形態";
	LOCALIZATION_ZORLEN_ChallengingRoar = "挑戰咆哮";
	LOCALIZATION_ZORLEN_DemoralizingRoar = "挫志咆哮";
	LOCALIZATION_ZORLEN_AbolishPoison = "驅毒術";
	LOCALIZATION_ZORLEN_Barkskin = "樹皮術";
	LOCALIZATION_ZORLEN_Bash = "重擊";
	LOCALIZATION_ZORLEN_Claw = "爪擊";
	LOCALIZATION_ZORLEN_Cower = "畏縮";
	LOCALIZATION_ZORLEN_Dash = "急奔";
	LOCALIZATION_ZORLEN_Enrage = "狂怒";
	LOCALIZATION_ZORLEN_EntanglingRoots = "糾纏根鬚";
	LOCALIZATION_ZORLEN_FaerieFire = "精靈之火";
	LOCALIZATION_ZORLEN_FaerieFireFeral = "精靈之火 (野性)";
	LOCALIZATION_ZORLEN_FeralCharge = "野性衝鋒";
	LOCALIZATION_ZORLEN_FerociousBite = "兇猛撕咬";
	LOCALIZATION_ZORLEN_FrenziedRegeneration = "狂暴回復";
	LOCALIZATION_ZORLEN_GiftOfTheWild = "野性賜福";
	LOCALIZATION_ZORLEN_HealingTouch = "治療之觸";
	LOCALIZATION_ZORLEN_Hibernate = "休眠";
	LOCALIZATION_ZORLEN_Hurricane = "颶風";
	LOCALIZATION_ZORLEN_Innervate = "啟動";
	LOCALIZATION_ZORLEN_InsectSwarm = "蟲群";
	LOCALIZATION_ZORLEN_LeaderOfThePack = "獸群領袖";
	LOCALIZATION_ZORLEN_MarkOfTheWild = "野性印記";
	LOCALIZATION_ZORLEN_Maul = "槌擊";
	LOCALIZATION_ZORLEN_Moonfire = "月火術";
	LOCALIZATION_ZORLEN_NaturesGrasp = "自然之握";
	LOCALIZATION_ZORLEN_NaturesSwiftness = "自然迅捷";
	LOCALIZATION_ZORLEN_OmenOfClarity = "清晰預兆";
	LOCALIZATION_ZORLEN_Pounce = "突襲";
	LOCALIZATION_ZORLEN_Prowl = "潛行";
	LOCALIZATION_ZORLEN_Rake = "掃擊";
	LOCALIZATION_ZORLEN_Ravage = "毀滅";
	LOCALIZATION_ZORLEN_Rebirth = "複生";
	LOCALIZATION_ZORLEN_Regrowth = "癒合";
	LOCALIZATION_ZORLEN_Rejuvenation = "回春術";
	LOCALIZATION_ZORLEN_RemoveCurse = "解除詛咒";
	LOCALIZATION_ZORLEN_Rip = "撕扯";
	LOCALIZATION_ZORLEN_Shred = "撕碎";
	LOCALIZATION_ZORLEN_SootheAnimal = "安撫動物";
	LOCALIZATION_ZORLEN_Starfire = "星火術";
	LOCALIZATION_ZORLEN_Swipe = "揮擊";
	LOCALIZATION_ZORLEN_Thorns = "荊棘術";
	LOCALIZATION_ZORLEN_TigersFury = "猛虎之怒";
	LOCALIZATION_ZORLEN_TrackHumanoids = "追蹤人型生物";
	LOCALIZATION_ZORLEN_Tranquility = "寧靜";
	LOCALIZATION_ZORLEN_Wrath = "憤怒";
	LOCALIZATION_ZORLEN_ImprovedWrath = "強化憤怒";
	LOCALIZATION_ZORLEN_ImprovedNaturesGrasp = "強化自然之握";
	LOCALIZATION_ZORLEN_ImprovedEntanglingRoots = "強化糾纏根鬚";
	LOCALIZATION_ZORLEN_ImprovedMoonfire = "強化月火術";
	LOCALIZATION_ZORLEN_NaturalWeapons = "武器平衡";
	LOCALIZATION_ZORLEN_NaturalShapeshifter = "自然變形";
	LOCALIZATION_ZORLEN_ImprovedThorns = "強化荊棘術";
	LOCALIZATION_ZORLEN_NaturesReach = "自然延伸";
	LOCALIZATION_ZORLEN_Vengeance = "復仇";
	LOCALIZATION_ZORLEN_ImprovedStarfire = "強化星火術";
	LOCALIZATION_ZORLEN_NaturesGrace = "自然之賜";
	LOCALIZATION_ZORLEN_Moonglow = "月光";
	LOCALIZATION_ZORLEN_Moonfury = "月怒";
	LOCALIZATION_ZORLEN_Ferocity = "兇暴";
	LOCALIZATION_ZORLEN_FeralAggression = "野性侵略";
	LOCALIZATION_ZORLEN_FeralInstinct = "野性本能";
	LOCALIZATION_ZORLEN_BrutalImpact = "野蠻衝撞";
	LOCALIZATION_ZORLEN_ThickHide = "厚皮";
	LOCALIZATION_ZORLEN_FelineSwiftness = "豹之迅捷";
	LOCALIZATION_ZORLEN_SharpenedClaws = "鋒利獸爪";
	LOCALIZATION_ZORLEN_ImprovedShred = "強化撕碎";
	LOCALIZATION_ZORLEN_PredatoryStrikes = "猛獸攻擊";
	LOCALIZATION_ZORLEN_BloodFrenzy = "血之狂暴";
	LOCALIZATION_ZORLEN_PrimalFury = "原始狂怒";
	LOCALIZATION_ZORLEN_SavageFury = "野蠻暴怒";
	LOCALIZATION_ZORLEN_HeartOfTheWild = "野性之心";
	LOCALIZATION_ZORLEN_ImprovedMarkOfTheWild = "強化野性印記";
	LOCALIZATION_ZORLEN_Furor = "激怒";
	LOCALIZATION_ZORLEN_ImprovedHealingTouch = "強化治療之觸";
	LOCALIZATION_ZORLEN_NaturesFocus = "自然集中";
	LOCALIZATION_ZORLEN_ImprovedEnrage = "強化狂怒";
	LOCALIZATION_ZORLEN_Reflection = "反射";
	LOCALIZATION_ZORLEN_Subtlety = "微妙";
	LOCALIZATION_ZORLEN_TranquilSpirit = "寧靜之魂";
	LOCALIZATION_ZORLEN_ImprovedRejuvenation = "強化回春術";
	LOCALIZATION_ZORLEN_GiftOfNature = "自然賜福";
	LOCALIZATION_ZORLEN_ImprovedTranquility = "強化寧靜";
	LOCALIZATION_ZORLEN_ImprovedRegrowth = "強化癒合";



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
	LOCALIZATION_ZORLEN_ImprovedCheapShot = "強化偷襲";
	LOCALIZATION_ZORLEN_ImprovedSinisterStrike = "強化邪惡攻擊";
	LOCALIZATION_ZORLEN_CripplingPoison = "致殘毒藥";
	LOCALIZATION_ZORLEN_CripplingPoisonII = "致殘毒藥 II";
	LOCALIZATION_ZORLEN_DeadlyPoison = "致命毒藥";
	LOCALIZATION_ZORLEN_DeadlyPoisonII = "致命毒藥 II";
	LOCALIZATION_ZORLEN_DeadlyPoisonIII = "致命毒藥 III";
	LOCALIZATION_ZORLEN_DeadlyPoisonIV = "致命毒藥 IV";
	LOCALIZATION_ZORLEN_DeadlyPoisonV = "致命毒藥 V";
	LOCALIZATION_ZORLEN_InstantPoison = "速效毒藥";
	LOCALIZATION_ZORLEN_InstantPoisonII = "速效毒藥 II";
	LOCALIZATION_ZORLEN_InstantPoisonIII = "速效毒藥 III";
	LOCALIZATION_ZORLEN_InstantPoisonIV = "速效毒藥 IV";
	LOCALIZATION_ZORLEN_InstantPoisonV = "速效毒藥 V";
	LOCALIZATION_ZORLEN_InstantPoisonVI = "速效毒藥 VI";
	LOCALIZATION_ZORLEN_MindnumbingPoison = "麻痺毒藥";
	LOCALIZATION_ZORLEN_MindnumbingPoisonII = "麻痺毒藥 II";
	LOCALIZATION_ZORLEN_MindnumbingPoisonIII = "麻痺毒藥 III";
	LOCALIZATION_ZORLEN_WoundPoison = "致傷毒藥";
	LOCALIZATION_ZORLEN_WoundPoisonII = "致傷毒藥 II";
	LOCALIZATION_ZORLEN_WoundPoisonIII = "致傷毒藥 III";
	LOCALIZATION_ZORLEN_WoundPoisonIV = "致傷毒藥 IV";
	LOCALIZATION_ZORLEN_AdrenalineRush = "衝動";
	LOCALIZATION_ZORLEN_Ambush = "伏擊";
	LOCALIZATION_ZORLEN_Backstab = "背刺";
	LOCALIZATION_ZORLEN_BladeFlurry = "劍刃亂舞";
	LOCALIZATION_ZORLEN_Blind = "致盲";
	LOCALIZATION_ZORLEN_BlindingPowder = "致盲粉";
	LOCALIZATION_ZORLEN_CheapShot = "偷襲";
	LOCALIZATION_ZORLEN_ColdBlood = "冷血";
	LOCALIZATION_ZORLEN_DetectTraps = "偵測陷阱";
	LOCALIZATION_ZORLEN_DisarmTrap = "解除陷阱";
	LOCALIZATION_ZORLEN_Distract = "擾亂";
	LOCALIZATION_ZORLEN_Evasion = "閃避";
	LOCALIZATION_ZORLEN_Eviscerate = "剔骨";
	LOCALIZATION_ZORLEN_ExposeArmor = "破甲";
	LOCALIZATION_ZORLEN_Feint = "佯攻";
	LOCALIZATION_ZORLEN_Garrote = "絞喉";
	LOCALIZATION_ZORLEN_GhostlyStrike = "鬼魅攻擊";
	LOCALIZATION_ZORLEN_Gouge = "鑿擊";
	LOCALIZATION_ZORLEN_Hemorrhage = "出血";
	LOCALIZATION_ZORLEN_Kick = "腳踢";
	LOCALIZATION_ZORLEN_KidneyShot = "腎擊";
	LOCALIZATION_ZORLEN_PickLock = "開鎖";
	LOCALIZATION_ZORLEN_PickPocket = "偷竊";
	LOCALIZATION_ZORLEN_Premeditation = "預謀";
	LOCALIZATION_ZORLEN_Preparation = "伺機待發";
	LOCALIZATION_ZORLEN_RelentlessStrikes = "無情打擊";
	LOCALIZATION_ZORLEN_Riposte = "還擊";
	LOCALIZATION_ZORLEN_Rupture = "割裂";
	LOCALIZATION_ZORLEN_Sap = "悶棍";
	LOCALIZATION_ZORLEN_SinisterStrike = "邪惡攻擊";
	LOCALIZATION_ZORLEN_SliceAndDice = "切割";
	LOCALIZATION_ZORLEN_Sprint = "疾跑";
	LOCALIZATION_ZORLEN_Stealth = "潛行";
	LOCALIZATION_ZORLEN_Vanish = "消失";



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
	LOCALIZATION_ZORLEN_ImprovedOverpower = "強化壓制";
	LOCALIZATION_ZORLEN_ImprovedBerserkerRage = "強化狂暴之怒";
	LOCALIZATION_ZORLEN_ImprovedExecute = "強化斬殺";
	LOCALIZATION_ZORLEN_Execute = "斬殺";
	LOCALIZATION_ZORLEN_ImprovedHeroicStrike = "強化英勇打擊";
	LOCALIZATION_ZORLEN_HeroicStrike = "英勇打擊";
	LOCALIZATION_ZORLEN_ImprovedSunderArmor = "強化破甲攻擊";
	LOCALIZATION_ZORLEN_SunderArmor = "破甲攻擊";
	LOCALIZATION_ZORLEN_ImprovedThunderClap = "強化雷霆一擊";
	LOCALIZATION_ZORLEN_ThunderClap = "雷霆一擊";
	LOCALIZATION_ZORLEN_MortalStrike = "致死打擊";
	LOCALIZATION_ZORLEN_Bloodthirst = "嗜血";
	LOCALIZATION_ZORLEN_ShieldSlam = "盾牌猛擊";
	LOCALIZATION_ZORLEN_Charge = "衝鋒";
	LOCALIZATION_ZORLEN_Taunt = "嘲諷";
	LOCALIZATION_ZORLEN_Intercept = "攔截";
	LOCALIZATION_ZORLEN_Overpower = "壓制";
	LOCALIZATION_ZORLEN_Revenge = "復仇";
	LOCALIZATION_ZORLEN_Rend = "撕裂";
	LOCALIZATION_ZORLEN_Hamstring = "斷筋";
	LOCALIZATION_ZORLEN_ShieldBash = "盾擊";
	LOCALIZATION_ZORLEN_Pummel = "拳擊";
	LOCALIZATION_ZORLEN_ShieldBlock = "盾牌格擋";
	LOCALIZATION_ZORLEN_DemoralizingShout = "挫志怒吼";
	LOCALIZATION_ZORLEN_BattleShout = "戰鬥怒吼";
	LOCALIZATION_ZORLEN_BerserkerRage = "狂暴之怒";
	LOCALIZATION_ZORLEN_Enrage = "狂怒";
	LOCALIZATION_ZORLEN_DefensiveStance = "防禦姿態";
	LOCALIZATION_ZORLEN_BattleStance = "戰鬥姿態";
	LOCALIZATION_ZORLEN_BerserkerStance = "狂暴姿態";
	LOCALIZATION_ZORLEN_AngerManagement = "憤怒掌控";
	LOCALIZATION_ZORLEN_Bloodrage = "血性狂暴";
	LOCALIZATION_ZORLEN_ChallengingShout = "挑戰怒吼";
	LOCALIZATION_ZORLEN_Cleave = "順劈斬";
	LOCALIZATION_ZORLEN_ConcussionBlow = "震盪猛擊";
	LOCALIZATION_ZORLEN_DeathWish = "死亡之願";
	LOCALIZATION_ZORLEN_Disarm = "繳械";
	LOCALIZATION_ZORLEN_IntimidatingShout = "破膽怒吼";
	LOCALIZATION_ZORLEN_LastStand = "破釜沉舟";
	LOCALIZATION_ZORLEN_MockingBlow = "慫戒痛擊";
	LOCALIZATION_ZORLEN_PiercingHowl = "刺耳怒吼";
	LOCALIZATION_ZORLEN_Recklessness = "魯莽";
	LOCALIZATION_ZORLEN_Retaliation = "反擊風暴";
	LOCALIZATION_ZORLEN_ShieldWall = "盾牆";
	LOCALIZATION_ZORLEN_Slam = "猛擊";
	LOCALIZATION_ZORLEN_SweepingStrikes = "橫掃攻擊";
	LOCALIZATION_ZORLEN_Whirlwind = "旋風斬";
	LOCALIZATION_ZORLEN_TacticalMastery = "戰術專精";
end
