--[[
  Spell Stats helper by LastHime
    Spells 
]]

-- Global var
StatCompare_SpellsVals = {};

--[[
 Cast ratio :
  Instant : 0.429
  1.5s : 0.429
  2.0s : 0.571
  2.5s : 0.714
  3.0s : 0.857
  >= 3.5s : 1.0
  
   ActualBenefit = AdvertisedBenefit * (CastingTime / 3.5)

 Level ratio :
  1 : 0.288
  2 : 0.3
  4 : 0.40
  6 : 0.475
  8 : 0.55
  10 : 0.625
  12 : 0.70
  14 : 0.775
  16 : 0.845
  18 : 0.925
  >= 20 : 1.0
  
   EffectiveBonus = (1-((20-LevelLearnt)*0.0375))*AdvertisedBonus
]]

--[[
  ************* TALENTS *************
]]
-- Druid
SC_TALENT_GIF_OF_NATURE = 1;
SC_TALENT_IMPROVED_REJUVINATION = 2;
SC_TALENT_IMPROVED_MOONFIRE = 3;
SC_TALENT_VENGEANCE=4;
-- Priest
SC_TALENT_SPIRITUAL_HEALING = 11;
SC_TALENT_IMPROVED_RENEW = 12;
SC_TALENT_SPIRITUAL_GUIDANCE = 13;
SC_TALENT_FORCE_OF_WILL = 14;
SC_TALENT_SEARING_LIGHT = 15;
-- Shaman
SC_TALENT_PURIFICATION = 21;
SC_TALENT_CONVECTION = 22;
SC_TALENT_ELEMENTAL_FURY = 23;
-- Paladin
SC_TALENT_HEALING_LIGHT = 31;
-- Warlock
SC_TALENT_IMPROVED_DRAIN_LIFE = 40;
SC_TALENT_IMPROVED_CURSE_OF_AGONY = 41;
SC_TALENT_SHADOW_MASTERY = 42;
SC_TALENT_IMPROVED_IMMOLATE = 43;
SC_TALENT_RUIN = 44;
SC_TALENT_EMBERSTOM = 45;

SC_Talents = {
-- Druid
  [SC_TALENT_GIF_OF_NATURE] = {type="n", rank=5, rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Nature_ProtectionformNature" };
  [SC_TALENT_IMPROVED_REJUVINATION] = {type="n", rank=3, rankratio = {[0]=1.00; [1]=1.05; [2]=1.10; [3]=1.15}; texture="Interface\\Icons\\Spell_Nature_Rejuvenation" };
  [SC_TALENT_IMPROVED_MOONFIRE] = {type="n", rank=5, rankratio={[0]=1.0; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10};};
  [SC_TALENT_VENGEANCE] = {type="c", rank=5, rankratio={[0]=1.0;[1]=1.20;[2]=1.40;[3]=1.60;[4]=1.80;[5]=2.0};};
-- Priest
  [SC_TALENT_SPIRITUAL_HEALING] = {type="n", rank=5, rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Nature_MoonGlow" };
  [SC_TALENT_IMPROVED_RENEW] = {type="n", rank=3, rankratio = {[0]=1.00; [1]=1.05; [2]=1.10; [3]=1.15}; texture="Interface\\Icons\\Spell_Holy_Renew" };
  [SC_TALENT_SPIRITUAL_GUIDANCE] = {type="n", rank=5, spiritratio = {[0]=0.00; [1]=0.05; [2]=0.10; [3]=0.15; [4]=0.20; [5]=0.25}; texture="Interface\\Icons\\Spell_Holy_SpiritualGuidence" };
  [SC_TALENT_FORCE_OF_WILL] = {type="n", rank=5, rankratio = {[0]=1.00; [1]=1.01; [2]=1.02; [3]=1.03; [4]=1.04; [5]=1.05}};
  [SC_TALENT_SEARING_LIGHT] = {type="n", rank=2, rankratio = {[0]=1.00; [1]=1.05; [2]=1.10}};
-- Shaman
  [SC_TALENT_PURIFICATION] = {type="n", rank=5, rankratio = {[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}; texture="Interface\\Icons\\Spell_Frost_WizardMark" };
  [SC_TALENT_CONVECTION] = {type="n", rank=5, rankratio = {[0]=1.00; [1]=1.01; [2]=1.02; [3]=1.03; [4]=1.04; [5]=1.05}};
  [SC_TALENT_ELEMENTAL_FURY] = {type="c", rank=1, rankratio={[0]=1.00; [1] = 2.0};};
-- Paladin
  [SC_TALENT_HEALING_LIGHT] = {type="n", rank=3, rankratio = {[0]=1.00; [1]=1.04; [2]=1.08; [3]=1.12}; texture="Interface\\Icons\\Spell_Holy_HolyBolt" };
-- Warlock
  [SC_TALENT_IMPROVED_DRAIN_LIFE] = {type="n", rank=5, rankratio={[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}};
  [SC_TALENT_IMPROVED_CURSE_OF_AGONY] = {type="n", rank=3, rankratio={[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06}};
  [SC_TALENT_SHADOW_MASTERY] = {type="n", rank=5, rankratio={[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}};
  [SC_TALENT_IMPROVED_IMMOLATE] = {type="n", rank=5, rankratio={[0]=1.00; [1]=1.05; [2]=1.10; [3]=1.15; [4]=1.20; [5]=1.25}};
  [SC_TALENT_RUIN] = {type="c", rank=1, rankratio={[0]=1.00; [1] = 2.0};};
  [SC_TALENT_EMBERSTOM] = {type="n", rank=5, rankratio={[0]=1.00; [1]=1.02; [2]=1.04; [3]=1.06; [4]=1.08; [5]=1.10}};
};

--[[
  ************* SPELLS *************
]]

-- Druid
SC_SPELL_FIRST_DRUID = 1;
  -- Casted
SC_SPELL_HEALING_TOUCH = 1;
SC_SPELL_REGROWTH = 2;
SC_SPELL_WRATH = 3;
SC_SPELL_STARFIRE = 4;
  -- Instant
SC_SPELL_REJUVENATION = 6;
SC_SPELL_REGROWTH_HOT = 7;
SC_SPELL_MOONFIRE = 8;
SC_SPELL_MOONFIRE_HOT = 9;
SC_SPELL_INSECTSWARM = 10;

  -- Group
  -- Channel
SC_SPELL_TRANQUILITY = 11;
  -- Other
SC_SPELL_INNERVATE = 16;
SC_SPELL_REBIRTH = 17;
SC_SPELL_REMOVE_CURSE = 18;
SC_SPELL_ABOLISH_POISON = 19;
SC_SPELL_CURE_POISON = 20;
SC_SPELL_LAST_DRUID = 20;

-- Priest
SC_SPELL_FIRST_PRIEST = 31;
  -- Casted
SC_SPELL_LESSER_HEAL = 31;
SC_SPELL_HEAL = 32;
SC_SPELL_FLASH_HEAL = 33;
SC_SPELL_GREATER_HEAL = 34;
SC_SPELL_HOLYFIRE = 35;
SC_SPELL_MANABURN = 36;
SC_SPELL_MINDBLAST = 37;
SC_SPELL_SMITE = 38;
  -- Instant
SC_SPELL_RENEW = 39;
SC_SPELL_HOLYNOVA = 40;
SC_SPELL_PAIN = 41;
SC_SPELL_MINDFLAY = 42;
  -- Group
SC_SPELL_PRAYER_OF_HEALING = 43;
  -- Channel
  -- Other
SC_SPELL_RESURRECTION = 46;
SC_SPELL_PWS = 47;
SC_SPELL_LIGHTWELL = 48;
SC_SPELL_HOLY_NOVA = 49;
SC_SPELL_POWER_INFUSION = 50;
SC_SPELL_LAST_PRIEST = 50;

-- Shaman
SC_SPELL_FIRST_SHAMAN = 51;
  -- Casted
SC_SPELL_HEALING_WAVE = 51;
SC_SPELL_LESSER_HEALING_WAVE = 52;
SC_SEPLL_CHAIN_LIGHTNING = 53;
SC_SPELL_LIGHTNING_BOLT = 54;
  -- Instant
SC_SPELL_EARTH_SHOCK = 55;
SC_SPELL_FLAME_SHOCK = 56;
SC_SPELL_FLAMESHOCK_DOT = 57;
SC_SPELL_FROST_SHOCK = 58;
  -- Group
SC_SPELL_CHAIN_HEAL = 59;
  -- Channel
  -- Other
SC_SPELL_REINCARNATION = 61;
SC_SPELL_ANCESTRAL_SPIRIT = 62;
SC_SPELL_MANA_TIDE = 63;
SC_SPELL_LAST_SHAMAN = 63;

-- Paladin
SC_SPELL_FIRST_PALADIN = 71;
  -- Casted
SC_SPELL_HOLY_LIGHT = 71;
SC_SPELL_FLASH_OF_LIGHT = 72;
SC_SPELL_CONSECRATION = 73;
SC_SPELL_EXORCISM = 74;
SC_SPELL_HAMMER_OF_WRATH = 75;
  -- Instant
SC_SPELL_HOLY_SHOCK = 76;
SC_SPELL_HOLY_WRATH = 77;
  -- Group
  -- Channel
  -- Other
SC_SPELL_DIVINE_INTERVENTION = 81;
SC_SPELL_DIVINE_SHIELD = 82;
SC_SPELL_REDEMPTION = 83;
SC_SPELL_PURIFY = 84;
SC_SPELL_CLEANSE = 85;
SC_SPELL_LAST_PALADIN = 85;

-- Hunter
SC_SPELL_FIRST_HUNTER = 90;
SC_SPELL_SRCANE_SHOT = 90;
SC_SPELL_EXPLOSIVE_TRAP = 91;
SC_SPELL_EXPLOSIVE_TRAP_DOT = 92
SC_SPELL_IMMOLATION_TRAP = 93;
SC_SPELL_SERPENT_STING = 94;
SC_SPELL_VOLLEY = 95;
SC_SPELL_WYVERN_STING = 96;
SC_SPELL_LAST_HUNTER = 97;

-- Mage
SC_SPELL_FIRST_MAGE = 100;
SC_SPELL_ARCANEEXPLOSION = 100;
SC_SPELL_ARCANEMISSILES = 101;
SC_SPELL_BLASTWAVE = 102;
SC_SPELL_BLIZZARD = 103;
SC_SPELL_CONECODE = 104;
SC_SPELL_FIREBALL = 105;
SC_SPELL_FIREBLAST = 106;
SC_SPELL_FROSTBOLT = 107;
SC_SPELL_PYROBLAST = 108;
SC_SPELL_SCORCH = 109;
SC_SPELL_LAST_MAGE = 109;

-- Warlock
SC_SPELL_FIRST_WARLOCK = 110;
SC_SPELL_CONFLAGRATE = 110;
SC_SPELL_CORRUPTION = 111;
SC_SPELL_CURSE_OF_AGONY = 112;
SC_SPELL_DRAIN_LIFE = 113;
SC_SPELL_DRAIN_SOUL = 114;
SC_SPELL_DEATH_COIL = 115;
SC_SPELL_HELLFIRE = 116;
SC_SPELL_IMMOLATE = 117;
SC_SPELL_IMMOLATE_DOT = 118;
SC_SPELL_RAIN_OF_FIRE = 119;
SC_SPELL_SEARING_PAIN = 120;
SC_SPELL_SIPHON_LIFE = 121;
SC_SPELL_SHADOW_BOLT = 122;
SC_SPELL_SHADOWBURN = 123;
SC_SPELL_SOUL_FIRE = 124;
SC_SPELL_LAST_WARLOCK = 124;

SC_SpellCollections = {
-- Druid
	[SC_SPELL_HEALING_TOUCH] = {
		name = STATCOMPARE_HEALIN_TOUCH,
		type = "h",
		effect = "HEAL",
		l_rank = 1,
		h_rank = 11,
	},
	[SC_SPELL_REGROWTH] = {
		name = STATCOMPARE_REGROWTH,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 9,
		d_h_ot = SC_SPELL_REGROWTH_HOT,
	},
	[SC_SPELL_REJUVENATION] = {
		name = STATCOMPARE_REJUVENATION,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 11,
	},
	[SC_SPELL_TRANQUILITY] = {
		name = STATCOMPARE_TRANQUILITY,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 4,
	},
	[SC_SPELL_WRATH] = {
		name = STATCOMPARE_WRATH,
		effect = { "DMG", "NATUREDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_STARFIRE] = {
		name = STATCOMPARE_STARFIRE,
		effect = { "DMG", "ARCANEDMG" },
		type = "a",
		l_rank = 7,
		h_rank = 7,
	},
	[SC_SPELL_MOONFIRE] = {
		name = STATCOMPARE_MOONFIRE,
		effect = { "DMG", "ARCANEDMG" },
		type = "a",
		l_rank = 10,
		h_rank = 10,
		d_h_ot = SC_SPELL_MOONFIRE_HOT,
	},
	[SC_SPELL_INSECTSWARM] = {
		name = STATCOMPARE_INSECTSWARM,
		effect = { "DMG", "NATUREDMG" },
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
-- Priest
	[SC_SPELL_LESSER_HEAL] = {
		name = STATCOMPARE_LESSER_HEAL,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 3,
	},
	[SC_SPELL_HEAL] = {
		name = STATCOMPARE_HEAL,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 4,
	},
	[SC_SPELL_FLASH_HEAL] = {
		name = STATCOMPARE_FLASH_HEAL,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 7,
	},
	[SC_SPELL_GREATER_HEAL] = {
		name = STATCOMPARE_GREATER_HEAL,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 5,
	},
	[SC_SPELL_RENEW] = {
		name = STATCOMPARE_RENEW,
		effect = "HEAL",
		type = "h",
		l_rank = 10,
		h_rank = 10,
	},
	[SC_SPELL_PRAYER_OF_HEALING] = {
		name = STATCOMPARE_PRAYER_OF_HEALING,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 5,
	},
	[SC_SPELL_SMITE] = {
		name = STATCOMPARE_SPELL_SMITE,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_HOLYFIRE] = {
		name = STATCOMPARE_SPELL_HOLYFIRE,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_HOLYNOVA] = {
		name = STATCOMPARE_SPELL_HOLYNOVA,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
	},
	[SC_SPELL_MANABURN] = {
		name = STATCOMPARE_SPELL_MANABURN,
		effect = { "DMG", "SHADOWDMG"},
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
	[SC_SPELL_MINDBLAST] = {
		name = STATCOMPARE_SPELL_MINDBLAST,
		effect = { "DMG", "SHADOWDMG"},
		type = "a",
		l_rank = 9,
		h_rank = 9,
	},
	[SC_SPELL_PAIN] = {
		name = STATCOMPARE_SPELL_PAIN,
		effect = { "DMG", "SHADOWDMG"},
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_MINDFLAY] = {
		name = STATCOMPARE_SPELL_MINDFLAY,
		effect = { "DMG", "SHADOWDMG"},
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
-- Shaman
	[SC_SPELL_HEALING_WAVE] = {
		name = STATCOMPARE_HEALING_WAVE,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 10,
	},
	[SC_SPELL_LESSER_HEALING_WAVE] = {
		name = STATCOMPARE_LESSER_HEALING_WAVE,
		effect = { "HEAL","LESSERHEALWAVE" },
		type = "h",
		l_rank = 1,
		h_rank = 6,
	},
	[SC_SPELL_CHAIN_HEAL] = {
		name = STATCOMPARE_CHAIN_HEAL,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 3,
	},
	[SC_SEPLL_CHAIN_LIGHTNING] = {
		name = STATCOMPARE_CHAIN_LIGHTNING,
		effect = {"DMG", "NATUREDMG", "CHAINLIGHTNING"},
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
	[SC_SPELL_LIGHTNING_BOLT] = {
		name = STATCOMPARE_LIGHTNING_BOLT,
		effect = {"DMG", "NATUREDMG", "LIGHTNINGBOLT"},
		type = "a",
		l_rank = 10,
		h_rank = 10,
	},
	[SC_SPELL_EARTH_SHOCK] = {
		name = STATCOMPARE_EARTH_SHOCK,
		effect = {"DMG", "NATUREDMG", "EARTHSHOCK"},
		type = "a",
		l_rank = 7,
		h_rank = 7,
	},
	[SC_SPELL_FLAME_SHOCK] = {
		name = STATCOMPARE_FLAME_SHOCK,
		effect = {"DMG", "FIREDMG", "FLAMESHOCK"},
		type = "a",
		l_rank = 6,
		h_rank = 6,
		d_h_ot = SC_SPELL_FLAMESHOCK_DOT,
	},
	[SC_SPELL_FROST_SHOCK] = {
		name = STATCOMPARE_FROST_SHOCK,
		effect = {"DMG", "FROSTDMG", "FROSTSHOCK"},
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
-- Paladin
	[SC_SPELL_HOLY_LIGHT] = {
		name = STATCOMPARE_HOLY_LIGHT,
		effect = "HEAL",
		type = "h",
		l_rank = 1,
		h_rank = 9,
	},
	[SC_SPELL_FLASH_OF_LIGHT] = {
		name = STATCOMPARE_FLASH_OF_LIGHT,
		effect = { "HEAL", "FLASHHOLYLIGHTHEAL" },
		type = "h",
		l_rank = 1,
		h_rank = 6,
	},
	[SC_SPELL_CONSECRATION] = {
		name = STATCOMPARE_CONSECRATION,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
	[SC_SPELL_EXORCISM] = {
		name = STATCOMPARE_EXORCISM,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_HAMMER_OF_WRATH] = {
		name = STATCOMPARE_HAMMER_OF_WRATH,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
	},
	[SC_SPELL_HOLY_SHOCK] = {
		name = STATCOMPARE_HOLY_SHOCK,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
	},
	[SC_SPELL_HOLY_WRATH] = {
		name = STATCOMPARE_HOLY_WRATH,
		effect = { "DMG", "HOLYDMG" },
		type = "a",
		l_rank = 2,
		h_rank = 2,
	},
-- Hunter
	[SC_SPELL_SRCANE_SHOT] = {
		name = STATCOMPARE_SRCANE_SHOT,
		effect = { "DMG", "ARCANEDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_EXPLOSIVE_TRAP] = {
		name = STATCOMPARE_EXPLOSIVE_TRAP,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
		d_h_ot = SC_SPELL_EXPLOSIVE_TRAP_DOT,
	},
	[SC_SPELL_IMMOLATION_TRAP] = {
		name = STATCOMPARE_IMMOLATION_TRAP,
		effect = {"DMG", "FIREDMG" },
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
	[SC_SPELL_SERPENT_STING] = {
		name = STATCOMPARE_SERPENT_STING,
		effect = { "DMG", "NATUREDMG" },
		type = "a",
		l_rank = 9,
		h_rank = 9,
	},
--	[SC_SPELL_VOLLEY] = {
--		name = STATCOMPARE_VOLLEY,
--		effect = { "DMG", "ARCANEDMG" },
--		type = "a",
--		l_rank = 3,
--		h_rank = 3,
--	},
-- Mage
	[SC_SPELL_ARCANEEXPLOSION] = {
		name = STATCOMPARE_ARCANEEXPLOSION,
		effect = { "DMG", "ARCANEDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_ARCANEMISSILES] = {
		name = STATCOMPARE_ARCANEMISSILES,
		effect = { "DMG", "ARCANEDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_BLASTWAVE] = {
		name = STATCOMPARE_BLASTWAVE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
	[SC_SPELL_BLIZZARD] = {
		name = STATCOMPARE_BLIZZARD,
		effect = { "DMG", "FROSTDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_CONECODE] = {
		name = STATCOMPARE_CONECOLD,
		effect = { "DMG", "FROSTDMG" },
		type = "a",
		l_rank = 5,
		h_rank = 5,
	},
	[SC_SPELL_FIREBALL] = {
		name = STATCOMPARE_FIREBALL,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 12,
		h_rank = 12,
	},
	[SC_SPELL_FIREBLAST] = {
		name = STATCOMPARE_FIREBLAST,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 7,
		h_rank = 7,
	},
	[SC_SPELL_FROSTBOLT] = {
		name = STATCOMPARE_FROSTBOLT,
		effect = { "DMG", "FROSTDMG" },
		type = "a",
		l_rank = 11,
		h_rank = 11,
	},
	[SC_SPELL_PYROBLAST] = {
		name = STATCOMPARE_PYROBLAST,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
	},
	[SC_SPELL_SCORCH] = {
		name = STATCOMPARE_SCORCH,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 7,
		h_rank = 7,
	},
-- Warlock
	[SC_SPELL_CONFLAGRATE] = {
		name = STATCOMPARE_CONFLAGRATE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
	[SC_SPELL_CORRUPTION] = {
		name = STATCOMPARE_CORRUPTION,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 7,
		h_rank = 7,
	},
	[SC_SPELL_CURSE_OF_AGONY] = {
		name = STATCOMPARE_CURSE_OF_AGONY,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_DRAIN_LIFE] = {
		name = STATCOMPARE_DRAIN_LIFE,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_DRAIN_SOUL] = {
		name = STATCOMPARE_DRAIN_SOUL,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
	[SC_SPELL_DEATH_COIL] = {
		name = STATCOMPARE_DEATH_COIL,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
	},
	[SC_SPELL_HELLFIRE] = {
		name = STATCOMPARE_HELLFIRE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 3,
		h_rank = 3,
	},
	[SC_SPELL_IMMOLATE] = {
		name = STATCOMPARE_IMMOLATE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 8,
		h_rank = 8,
		d_h_ot = SC_SPELL_IMMOLATE_DOT,
	},
	[SC_SPELL_RAIN_OF_FIRE] = {
		name = STATCOMPARE_RAIN_OF_FIRE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
	[SC_SPELL_SEARING_PAIN] = {
		name = STATCOMPARE_SEARING_PAIN,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_SIPHON_LIFE] = {
		name = STATCOMPARE_SIPHON_LIFE,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 4,
		h_rank = 4,
	},
	[SC_SPELL_SHADOW_BOLT] = {
		name = STATCOMPARE_SHADOW_BOLT,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 10,
		h_rank = 10,
	},
	[SC_SPELL_SHADOWBURN] = {
		name = STATCOMPARE_SHADOWBURN,
		effect = { "DMG", "SHADOWDMG" },
		type = "a",
		l_rank = 6,
		h_rank = 6,
	},
	[SC_SPELL_SOUL_FIRE] = {
		name = STATCOMPARE_SOUL_FIRE,
		effect = { "DMG", "FIREDMG" },
		type = "a",
		l_rank = 2,
		h_rank = 2,
	},
}

SC_SpellRanks = {
-- Druid
  -- Casted
  [SC_SPELL_HEALING_TOUCH] = {
    [1] = { base=47, castratio=0.429, levelratio=0.288 },
    [2] = { base=106, castratio=0.571, levelratio=0.55 },
    [3] = { base=228, castratio=0.714, levelratio=0.775 },
    [4] = { base=417, castratio=0.857, levelratio=1.0 },
    [5] = { base=650, castratio=1.0, levelratio=1.0 },
    [6] = { base=838, castratio=1.0, levelratio=1.0 },
    [7] = { base=1050, castratio=1.0, levelratio=1.0 },
    [8] = { base=1339, castratio=1.0, levelratio=1.0 },
    [9] = { base=1685, castratio=1.0, levelratio=1.0 },
    [10] = { base=2086, castratio=1.0, levelratio=1.0 },
    [11] = { base=2472, castratio=1.0, levelratio=1.0 },
  },
  [SC_SPELL_REGROWTH] = { -- Only 50% of the bonus because one spell, 2 effects
    [1] = { base=100, castratio=0.571*0.50, levelratio=0.70 },
    [2] = { base=188, castratio=0.571*0.50, levelratio=0.925 },
    [3] = { base=272, castratio=0.571*0.50, levelratio=1.0 },
    [4] = { base=357, castratio=0.571*0.50, levelratio=1.0 },
    [5] = { base=451, castratio=0.571*0.50, levelratio=1.0 },
    [6] = { base=566, castratio=0.571*0.50, levelratio=1.0 },
    [7] = { base=711, castratio=0.571*0.50, levelratio=1.0 },
    [8] = { base=887, castratio=0.571*0.50, levelratio=1.0 },
    [9] = { base=1064, castratio=0.571*0.50, levelratio=1.0 },
  },
  -- Instant
  [SC_SPELL_REJUVENATION] = { 
    [1] = { base=32, castratio=1.0*0.80, levelratio=0.40 },
    [2] = { base=56, castratio=1.0*0.80, levelratio=0.625 },
    [3] = { base=116, castratio=1.0*0.80, levelratio=0.845 },
    [4] = { base=180, castratio=1.0*0.80, levelratio=1.0 },
    [5] = { base=244, castratio=1.0*0.80, levelratio=1.0 },
    [6] = { base=304, castratio=1.0*0.80, levelratio=1.0 },
    [7] = { base=388, castratio=1.0*0.80, levelratio=1.0 },
    [8] = { base=488, castratio=1.0*0.80, levelratio=1.0 },
    [9] = { base=608, castratio=1.0*0.80, levelratio=1.0 },
    [10] = { base=756, castratio=1.0*0.80, levelratio=1.0 },
    [11] = { base=888, castratio=1.0*0.80, levelratio=1.0, tick=3, totle=4 },
  },
  [SC_SPELL_REGROWTH_HOT] = { -- Only 50% of the bonus because one spell, 2 effects
    [1] = { base=98, castratio=1.0*0.50, levelratio=0.70 },
    [2] = { base=175, castratio=1.0*0.50, levelratio=0.925 },
    [3] = { base=259, castratio=1.0*0.50, levelratio=1.0 },
    [4] = { base=343, castratio=1.0*0.50, levelratio=1.0 },
    [5] = { base=427, castratio=1.0*0.50, levelratio=1.0 },
    [6] = { base=546, castratio=1.0*0.50, levelratio=1.0 },
    [7] = { base=686, castratio=1.0*0.50, levelratio=1.0 },
    [8] = { base=861, castratio=1.0*0.50, levelratio=1.0 },
    [9] = { base=1064, castratio=1.0*0.50, levelratio=1.0, tick=3, totle= 7},
  },
  [SC_SPELL_MOONFIRE] = { -- Only 50% of the bonus because one spell, 2 effects
    [10] = { base=205, castratio=1.0*0.429/2, levelratio=1.0 },
  },
  [SC_SPELL_MOONFIRE_HOT] = { -- Only 50% of the bonus because one spell, 2 effects
    [10] = { base=384, castratio=1.0*0.80/2, levelratio=1.0, tick=3 , totle = 4},
  },
  [SC_SPELL_STARFIRE] = {
    [7] = { base=540, castratio=1.0, levelratio=1.0 },
  },
  [SC_SPELL_WRATH] = {
    [8] = { base=250, castratio=0.571, levelratio=1.0 },
  },
  [SC_SPELL_INSECTSWARM] = {
    [5] = { base=324, castratio=1.0, levelratio=1.0, tick=2, totle=6 },
  },
  [SC_SPELL_MINDBLAST] = {
    [9] = { base=517, castratio=0.429, levelratio=1.0 },
  },
  -- Group
  -- Channel
  [SC_SPELL_TRANQUILITY] = {
    [1] = { base=470, castratio=0.33, levelratio=1.0 },
    [2] = { base=690, castratio=0.33, levelratio=1.0 },
    [3] = { base=1025, castratio=0.33, levelratio=1.0 },
    [4] = { base=1470, castratio=0.33, levelratio=1.0 },
  },

-- Priest
  -- Casted
  [SC_SPELL_LESSER_HEAL] = {
    [1] = { base=52, castratio=0.429, levelratio=0.288 },
    [2] = { base=83, castratio=0.571, levelratio=0.40 },
    [3] = { base=154, castratio=0.714, levelratio=0.625 },
  },
  [SC_SPELL_HEAL] = {
    [1] = { base=330, castratio=0.857, levelratio=1.0 },
    [2] = { base=476, castratio=0.857, levelratio=1.0 },
    [3] = { base=624, castratio=0.857, levelratio=1.0 },
    [4] = { base=780, castratio=0.857, levelratio=1.0 },
  },
  [SC_SPELL_FLASH_HEAL] = {
    [1] = { base=224, castratio=0.429, levelratio=1.0 },
    [2] = { base=297, castratio=0.429, levelratio=1.0 },
    [3] = { base=372, castratio=0.429, levelratio=1.0 },
    [4] = { base=453, castratio=0.429, levelratio=1.0 },
    [5] = { base=583, castratio=0.429, levelratio=1.0 },
    [6] = { base=722, castratio=0.429, levelratio=1.0 },
    [7] = { base=901, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_GREATER_HEAL] = {
    [1] = { base=981, castratio=0.857, levelratio=1.0 },
    [2] = { base=1248, castratio=0.857, levelratio=1.0 },
    [3] = { base=1556, castratio=0.857, levelratio=1.0 },
    [4] = { base=1917, castratio=0.857, levelratio=1.0 },
    [5] = { base=2080, castratio=0.857, levelratio=1.0 },
  },
  [SC_SPELL_HOLYFIRE] = {
    [8] = { base=547, castratio = 1.0, levelratio = 1.0 },
  },
  [SC_SPELL_HOLYNOVA] = {
    [3] = { base=82, castratio = 0.072, levelratio = 1.0 },
  },
  [SC_SPELL_MANABURN] = {
    [5] = { base=380, castratio = 0.429, levelratio = 1.0 },
  },
  [SC_SPELL_PAIN] = {
    [8] = { base=852, castratio = 1.0, levelratio = 1.0, tick=3, totle=6 },
  },
  [SC_SPELL_MINDFLAY] = {
    [6] = { base=426, castratio = 0.60, levelratio = 1.0, tick=1, totle = 3},
  },
  [SC_SPELL_SMITE] = {
    [8] = { base=393, castratio = 0.714, levelratio= 1.0},
  },
  -- Instant
  [SC_SPELL_RENEW] = {
    [10] = { base=970, castratio=1.0, levelratio=1.0, tick=3, totle=5 },
  },
  -- Group
  [SC_SPELL_PRAYER_OF_HEALING] = {
    [1] = { base=322, castratio=0.33, levelratio=1.0 },
    [2] = { base=472, castratio=0.33, levelratio=1.0 },
    [3] = { base=694, castratio=0.33, levelratio=1.0 },
    [4] = { base=965, castratio=0.33, levelratio=1.0 },
    [5] = { base=1070, castratio=0.33, levelratio=1.0 },
  },
  -- Channel

-- Shaman
  -- Casted
  [SC_SPELL_HEALING_WAVE] = {
    [1] = { base=41, castratio=0.429, levelratio=0.288 },
    [2] = { base=76, castratio=0.571, levelratio=0.475 },
    [3] = { base=149, castratio=0.714, levelratio=0.70 },
    [4] = { base=303, castratio=0.857, levelratio=0.925 },
    [5] = { base=421, castratio=0.857, levelratio=1.0 },
    [6] = { base=595, castratio=0.857, levelratio=1.0 },
    [7] = { base=816, castratio=0.857, levelratio=1.0 },
    [8] = { base=1092, castratio=0.857, levelratio=1.0 }, -- To update
    [9] = { base=1464, castratio=0.857, levelratio=1.0 }, -- To update
    [10] = { base=1735, castratio=0.857, levelratio=1.0 },
  },
  [SC_SPELL_LESSER_HEALING_WAVE] = {
    [1] = { base=182, castratio=0.429, levelratio=1.0 },
    [2] = { base=274, castratio=0.429, levelratio=1.0 },
    [3] = { base=371, castratio=0.429, levelratio=1.0 },
    [4] = { base=489, castratio=0.429, levelratio=1.0 },
    [5] = { base=668, castratio=0.429, levelratio=1.0 }, -- To update
    [6] = { base=880, castratio=0.429, levelratio=1.0 }, -- To update
  },
  [SC_SEPLL_CHAIN_LIGHTNING] = {
    [4] = { base=522, castratio=0.714, levelratio=1.0 },
  },
  [SC_SPELL_LIGHTNING_BOLT] = {
    [10] = { base=443, castratio=0.857, levelratio=1.0 },
  },

  -- Instant
  [SC_SPELL_EARTH_SHOCK] = {
    [7] = { base=517, castratio=0.429, levelratio=1.0 },
  },

  [SC_SPELL_FLAME_SHOCK] = {
    [6] = { base=292, castratio=1.0*0.429/2, levelratio=1.0 },
  },
  [SC_SPELL_FLAMESHOCK_DOT] = { -- Only 50% of the bonus because one spell, 2 effects
    [6] = { base=320, castratio=1.0*0.80/2, levelratio=1.0, tick=3 , totle = 4},
  },
  [SC_SPELL_FROST_SHOCK] = {
    [4] = { base=500, castratio = 0.429, levelratio=1.0},
  },
  -- Instant
  -- Group
  [SC_SPELL_CHAIN_HEAL] = {
    [1] = { base=356, castratio=0.714, levelratio=1.0 },
    [2] = { base=435, castratio=0.714, levelratio=1.0 }, -- To update
    [3] = { base=590, castratio=0.714, levelratio=1.0 }, -- To update
  },
  -- Channel

-- Paladin
  -- Casted
  [SC_SPELL_HOLY_LIGHT] = {
    [1] = { base=46, castratio=0.714, levelratio=0.288 },
    [2] = { base=88, castratio=0.714, levelratio=0.475 },
    [3] = { base=181, castratio=0.714, levelratio=0.775 },
    [4] = { base=345, castratio=0.714, levelratio=1.0 },
    [5] = { base=537, castratio=0.714, levelratio=1.0 },
    [6] = { base=758, castratio=0.714, levelratio=1.0 },
    [7] = { base=1022, castratio=0.714, levelratio=1.0 },
    [8] = { base=1343, castratio=0.714, levelratio=1.0 },
    [9] = { base=1680, castratio=0.714, levelratio=1.0 },
  },
  [SC_SPELL_FLASH_OF_LIGHT] = {
    [1] = { base=72, castratio=0.429, levelratio=1.0 },
    [2] = { base=109, castratio=0.429, levelratio=1.0 },
    [3] = { base=162, castratio=0.429, levelratio=1.0 },
    [4] = { base=218, castratio=0.429, levelratio=1.0 },
    [5] = { base=294, castratio=0.429, levelratio=1.0 },
    [6] = { base=368, castratio=0.429, levelratio=1.0 },
  },
  -- Instant
  [SC_SPELL_HOLY_SHOCK] = {
    [1] = { base=212, castratio=0.429, levelratio=1.0 },
    [2] = { base=290, castratio=0.429, levelratio=1.0 },
    [3] = { base=380, castratio=0.429, levelratio=1.0 },
  },
  -- Group
  -- Channel
  [SC_SPELL_CONSECRATION] = {
    [5] = { base=384, castratio=0.333, levelratio=1.0, tick=1, totle=8 },
  },
  [SC_SPELL_EXORCISM] = {
    [6] = { base=534, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_HAMMER_OF_WRATH] = {
    [3] = { base=530, castratio=0.429, levelratio=1.0 }
  },
  [SC_SPELL_HOLY_WRATH] = {
    [2] = { base=533, castratio=0.189, levelratio=1.0},
  },
-- Hunter
  [SC_SPELL_SRCANE_SHOT] = {
    [8] = { base=183, castratio=0.429, levelratio=1.0},
  },
  [SC_SPELL_EXPLOSIVE_TRAP] = {
    [3] = { base=229, castratio = 1.0*0.429/2, levelratio=1.0},
  },
  [SC_SPELL_EXPLOSIVE_TRAP_DOT] = {
    [3] = { base=330, castratio=1.0*0.80/2, levelratio=1.0, tick=2 , totle = 10}
  },
  [SC_SPELL_IMMOLATION_TRAP] = {
    [5] = { base=690, castratio = 1.0, levelratio=1.0, tick=3, totle=5},
  },
  [SC_SPELL_SERPENT_STING] = {
    [9] = { base=555, castratio = 1.0, levelratio=1.0},
  },
--  [SC_SPELL_VOLLEY] = {
--    [3] = { base=480, castratio = 0.333, levelratio=1.0}
--  },
-- Mage
  [SC_SPELL_ARCANEEXPLOSION] = {
    [6] = { base=253, castratio=0.143, levelratio=1.0 },
  },
  [SC_SPELL_ARCANEMISSILES] = {
    [8] = { base=960, castratio=1.0, levelratio=1.0 },
  },
  [SC_SPELL_BLASTWAVE] = {
    [5] = { base=462, castratio=0.143, levelratio=1.0 },
  },
  [SC_SPELL_BLIZZARD] = {
    [6] = { base=1192, castratio=0.333, levelratio=1.0 },
  },
  [SC_SPELL_CONECODE] = {
    [5] = { base=335, castratio=0.143, levelratio=1.0 },
  },
  [SC_SPELL_FIREBALL] = {
    [12] = {base=710, castratio=1.0, levelratio=1.0 },
  },
  [SC_SPELL_FIREBLAST] = {
    [7] = {base=431, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_FROSTBOLT] = {
    [11] = {base=535, castratio=0.814, levelratio=1.0 },
  },
  [SC_SPELL_PYROBLAST] = {
    [8] = {base=1071, castratio=1.70, levelratio=1.0 },
  },
  [SC_SPELL_SCORCH] = {
    [7] = {base=254, castratio=0.429, levelratio=1.0 },
  },
-- Warlock
  [SC_SPELL_CONFLAGRATE] = {
    [4] = {base=502, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_CORRUPTION] = {
    [7] = {base=822, castratio=1.0, levelratio=1.0, tick=3, totle=6 },
  },
  [SC_SPELL_CURSE_OF_AGONY] = {
    [6] = {base=1044, castratio=1.0, levelratio=1.0 },
  },
  [SC_SPELL_DRAIN_LIFE] = {
    [6] = {base=355, castratio=0.50, levelratio=1.0, tick=1, totle=5 },
  },
  [SC_SPELL_DRAIN_SOUL] = {
    [4] = {base=455, castratio=0.50, levelratio=1.0, tick=3, totle=5 },
  },
  [SC_SPELL_DEATH_COIL] = {
    [3] = {base=470, castratio=0.215, levelratio=1.0 },
  },
  [SC_SPELL_HELLFIRE] = {
    [3] = {base=3120, castratio=0.333, levelratio=1.0, tick=1, totle=15 },
  },
  [SC_SPELL_IMMOLATE] = {
    [8] = {base=258, castratio=1.0*0.429/2, levelratio=1.0 },
  },
  [SC_SPELL_IMMOLATE_DOT] = {
    [8] = {base=485, castratio=0.5, levelratio=1.0, tick= 3, totle=5 },
  },
  [SC_SPELL_RAIN_OF_FIRE] = {
    [4] = {base=904, castratio=0.333, levelratio=1.0, tick = 2, totle = 4 },
  },
  [SC_SPELL_SEARING_PAIN] = {
    [6] = {base=222, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_SIPHON_LIFE] = {
    [4] = {base=450, castratio=0.50, levelratio=1.0, tick = 3, totle = 10 },
  },
  [SC_SPELL_SHADOW_BOLT] = {
    [10] = {base=510, castratio=0.857, levelratio=1.0 },
  },
  [SC_SPELL_SHADOWBURN] = {
    [6] = {base=476, castratio=0.429, levelratio=1.0 },
  },
  [SC_SPELL_SOUL_FIRE] = {
    [2] = {base=792, castratio=1.0, levelratio=1.0 },
  },
};

SC_SpellTalents = {
-- Druid
  [SC_SPELL_HEALING_TOUCH] = { ratios={SC_TALENT_GIF_OF_NATURE} };
  [SC_SPELL_REGROWTH] = { ratios={SC_TALENT_GIF_OF_NATURE} };
  [SC_SPELL_REJUVENATION] = { ratios={SC_TALENT_GIF_OF_NATURE,SC_TALENT_IMPROVED_REJUVINATION} };
  [SC_SPELL_REGROWTH_HOT] = { ratios={SC_TALENT_GIF_OF_NATURE} };
  [SC_SPELL_TRANQUILITY] = { ratios={SC_TALENT_GIF_OF_NATURE} };
  [SC_SPELL_MOONFIRE] = {ratios={SC_TALENT_IMPROVED_MOONFIRE,SC_TALENT_VENGEANCE}};
  [SC_SPELL_MOONFIRE_HOT] = {ratios={SC_TALENT_IMPROVED_MOONFIRE,SC_TALENT_VENGEANCE}};
  [SC_SPELL_STARFIRE] = {ratios={SC_TALENT_VENGEANCE}};
  [SC_SPELL_WRATH] = {ratios={SC_TALENT_VENGEANCE}};
-- Priest
  [SC_SPELL_LESSER_HEAL] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_HEAL] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_FLASH_HEAL] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_GREATER_HEAL] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_RENEW] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_IMPROVED_RENEW,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_PRAYER_OF_HEALING] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_HOLY_NOVA] = { ratios={SC_TALENT_SPIRITUAL_HEALING,SC_TALENT_SPIRITUAL_GUIDANCE} };
  [SC_SPELL_SMITE] = {ratios={SC_TALENT_FORCE_OF_WILL, SC_TALENT_SEARING_LIGHT, SC_TALENT_SPIRITUAL_GUIDANCE}};
-- Shaman
  [SC_SPELL_HEALING_WAVE] = { ratios={SC_TALENT_PURIFICATION} };
  [SC_SPELL_LESSER_HEALING_WAVE] = { ratios={SC_TALENT_PURIFICATION} };
  [SC_SPELL_CHAIN_HEAL] = { ratios={SC_TALENT_PURIFICATION} };
  [SC_SEPLL_CHAIN_LIGHTNING] = {ratios={SC_TALENT_CONVECTION, SC_TALENT_ELEMENTAL_FURY}};
  [SC_SPELL_LIGHTNING_BOLT] = {ratios={SC_TALENT_CONVECTION, SC_TALENT_ELEMENTAL_FURY}};
  [SC_SPELL_EARTH_SHOCK] = {ratios={SC_TALENT_CONVECTION, SC_TALENT_ELEMENTAL_FURY}};
  [SC_SPELL_FLAME_SHOCK] = {ratios={SC_TALENT_CONVECTION, SC_TALENT_ELEMENTAL_FURY}};
  [SC_SPELL_FROST_SHOCK] = {ratios={SC_TALENT_CONVECTION, SC_TALENT_ELEMENTAL_FURY}};
-- Paladin
  [SC_SPELL_HOLY_LIGHT] = { ratios={SC_TALENT_HEALING_LIGHT}; blessing=400};
  [SC_SPELL_FLASH_OF_LIGHT] = { ratios={SC_TALENT_HEALING_LIGHT}; blessing=115 };
-- Warlock
  [SC_SPELL_DRAIN_LIFE] = {ratios={SC_TALENT_IMPROVED_DRAIN_LIFE,SC_TALENT_SHADOW_MASTERY}};
  [SC_SPELL_CURSE_OF_AGONY] = {ratios={SC_TALENT_IMPROVED_CURSE_OF_AGONY,SC_TALENT_SHADOW_MASTERY}};
  [SC_SPELL_CORRUPTION] = {ratios={SC_TALENT_SHADOW_MASTERY,SC_TALENT_RUIN}};
  [SC_SPELL_DRAIN_SOUL] = {ratios={SC_TALENT_SHADOW_MASTERY}};
  [SC_SPELL_DEATH_COIL] = {ratios={SC_TALENT_SHADOW_MASTERY, SC_TALENT_RUIN}};
  [SC_SPELL_SIPHON_LIFE] = {ratios={SC_TALENT_SHADOW_MASTERY}};
  [SC_SPELL_SHADOW_BOLT] = {ratios={SC_TALENT_SHADOW_MASTERY, SC_TALENT_RUIN}};
  [SC_SPELL_SHADOWBURN] =  {ratios={SC_TALENT_SHADOW_MASTERY, SC_TALENT_RUIN}};
  [SC_SPELL_IMMOLATE] = {ratios={SC_TALENT_IMPROVED_IMMOLATE,SC_TALENT_EMBERSTOM, SC_TALENT_RUIN}};
  [SC_SPELL_CONFLAGRATE] = {ratios={SC_TALENT_EMBERSTOM, SC_TALENT_RUIN}};
  [SC_SPELL_SEARING_PAIN] = {ratios={SC_TALENT_EMBERSTOM, SC_TALENT_RUIN}};
  [SC_SPELL_SOUL_FIRE] =  {ratios={SC_TALENT_EMBERSTOM, SC_TALENT_RUIN}};
  [SC_SPELL_CONFLAGRATE] = {ratios={SC_TALENT_EMBERSTOM, SC_TALENT_RUIN}};
  [SC_SPELL_RAIN_OF_FIRE] = {ratios={SC_TALENT_EMBERSTOM}};
  [SC_SPELL_HELLFIRE] =  {ratios={SC_TALENT_EMBERSTOM}};

};

SC_BLESSING_OF_LIGHT_TEXTURE = "spell_holy_prayerofhealing02";
SC_GREATER_BLESSING_OF_LIGHT_TEXTURE = "spell_holy_greaterblessingoflight";
SC_POWER_INFUSION_TEXTURE = "spell_holy_powerinfusion";
SC_DIVINE_FAVOR_TEXTURE = "spell_holy_heal";
SC_HEALING_OF_THE_AGES_TEXTURE = "spell_nature_healingwavegreater";
SC_UNSTABLE_POWER_TEXTURE = "spell_lightning_lightningbolt01";

local function _SC_GetEstimated(bself, SpellName,SpellRank,fullstats)
	local estimated = 0;
	local spiritadd = 0;
	local critedval = 0;
	local tickval = nil;
	local tick = nil;
	local ticktotal = nil;
	local totaltickval = nil;
	local nocrit = 0;
	local crit_talent = 0;

	if(SpellName and SpellRank and SC_SpellRanks[SpellName] and SC_SpellRanks[SpellName][SpellRank]) then
		local infos = SC_SpellRanks[SpellName][SpellRank];
		estimated = infos.base;

		-- Check Talent values
		local tinfos = SC_SpellTalents[SpellName];
		if(tinfos) then
			if(tinfos.ratios) then -- Ratio
				for _,tid in tinfos.ratios do
					if(SC_Talents[tid] and SC_Talents[tid].rank) then
						-- Talent found, and player's rank set
						if(SC_Talents[tid].rankratio) then
							-- Direct ratios
							if(SC_Talents[tid].type == "n") then
								estimated = estimated * SC_Talents[tid].rankratio[SC_Talents[tid].rank];
							elseif(SC_Talents[tid].type == "c") then
								crit_talent = SC_Talents[tid].rankratio[SC_Talents[tid].rank];
							end
						elseif(SC_Talents[tid].spiritratio) then
							-- Spirit based ratios
							if(bself == true) then
								spiritadd = SC_Talents[tid].spiritratio[SC_Talents[tid].rank] * UnitStat("player",5);
							elseif(fullstats and fullstats["SPI"]) then
								spiritadd = SC_Talents[tid].spiritratio[SC_Talents[tid].rank] * fullstats["SPI"];
							end
						end
					end
				end
			end
		end

		-- Add +heal values
		local itembonus = 0;
		if(SC_SpellCollections[SpellName] and SC_SpellCollections[SpellName].effect) then
			itembonus = tonumber(StatCompare_SpellStats_GetTotalValue(SC_SpellCollections[SpellName].effect));
		end
		if(itembonus > 0) then
			estimated = estimated + itembonus * infos.castratio * infos.levelratio;
		end

		-- Add + Blessing of light value
		if(SC_SpellTalents[SpellName] and SC_SpellTalents[SpellName].blessing) then
			-- Check for Blessing of light
		        estimated = estimated + SC_SpellTalents[SpellName].blessing;
		end
  
		-- Check for WillCrit
		local index = 0;
		local texture;
		while(bself == true and GetPlayerBuffTexture(index)) do
			texture = GetPlayerBuffTexture(index);
			applications = GetPlayerBuffApplications(index);
			if(texture and string.find(string.lower(texture), string.lower(SC_UNSTABLE_POWER_TEXTURE))) then
				estimated = estimated + (70 * applications * infos.castratio * infos.levelratio);
			elseif(texture and string.find(string.lower(texture), string.lower(SC_HEALING_OF_THE_AGES_TEXTURE))) then
				estimated = estimated + (350 * infos.castratio * infos.levelratio);
			end
			index = index + 1;
		end

		if(infos.tick) then
			tickval = estimated / infos.totle;
			tick = infos.tick;
			ticktotal = infos.totle;
			nocrit = 1;
		elseif(SC_SpellCollections[SpellName] and SC_SpellCollections[SpellName].d_h_ot) then
			if(SC_SpellRanks[SC_SpellCollections[SpellName].d_h_ot][SpellRank]) then
				local d_hot_spell = SC_SpellCollections[SpellName].d_h_ot;
				local hotestimated = SC_SpellRanks[d_hot_spell][SpellRank].base;
				-- Check Talent values
				local tmpinfos = SC_SpellTalents[d_hot_spell];
				if(tmpinfos) then
					if(tmpinfos.ratios) then -- Ratio
						for _,tmpid in tmpinfos.ratios do
							if(SC_Talents[tmpid] and SC_Talents[tmpid].rank) then
								-- Talent found, and player's rank set
								if(SC_Talents[tmpid].rankratio) then
									-- Direct ratios
									if(SC_Talents[tmpid].type == "n") then
										hotestimated = hotestimated * SC_Talents[tmpid].rankratio[SC_Talents[tmpid].rank];
									elseif(SC_Talents[tmpid].type == "c") then
										hotcrit_talent = SC_Talents[tmpid].rankratio[SC_Talents[tmpid].rank];
									end
								elseif(SC_Talents[tmpid].spiritratio) then
									-- Spirit based ratios
									if(bself == true) then
										hotspiritadd = SC_Talents[tmpid].spiritratio[SC_Talents[tmpid].rank] * UnitStat("player",5);
									elseif(fullstats and fullstats["SPI"]) then
										hotspiritadd = SC_Talents[tmpid].spiritratio[SC_Talents[tmpid].rank] * fullstats["SPI"];
									end
								end
							end
						end
					end
				end

				-- Add +heal values
				local titembonus = 0;

				if(SC_SpellCollections[SpellName] and SC_SpellCollections[SpellName].effect) then
					titembonus = tonumber(StatCompare_SpellStats_GetTotalValue(SC_SpellCollections[SpellName].effect));
				end
				totaltickval = hotestimated + titembonus * SC_SpellRanks[d_hot_spell][SpellRank].castratio * SC_SpellRanks[d_hot_spell][SpellRank].levelratio;
				tickval = totaltickval / SC_SpellRanks[d_hot_spell][SpellRank].totle;
				tick = SC_SpellRanks[d_hot_spell][SpellRank].tick;
				ticktotal = SC_SpellRanks[d_hot_spell][SpellRank].totle;
			end
		end
	end
	if(crit_talent > 0) then
		critedval = estimated * ( 1 + 0.5 * crit_talent);
	else
		critedval = estimated * 1.5;
	end
	if(totaltickval) then
		estimated = estimated + totaltickval;
		critedval = critedval + totaltickval;
	end
	if(nocrit == 1) then
		critedval = 0;
	end
	if(tickval) then
		return math.ceil(estimated + spiritadd), math.ceil(critedval), math.ceil(tickval), tick, ticktotal;
	else
		return math.ceil(estimated + spiritadd), math.ceil(critedval);
	end
end

function StatCompare_SpellStats_Scan(fullstats, unit)
	local sunit;
	local found = false;
	local bself = false;

	StatCompare_SpellsVals = {};

	if(unit) then
		sunit = unit;
	else
		sunit = "target";
	end

	if ( not UnitIsPlayer(sunit)) then
		return;
	end
	if(sunit == "player") then
		bself = true;
	end

	local level = UnitLevel(sunit);
	
	if(level ~= 60) then
		return;
	end
	
	local _, race = UnitRace(sunit);
	local _, class = UnitClass(sunit);

	local SpellsOfClass = {
		["DRUID"] = {
			first_spell = SC_SPELL_FIRST_DRUID,
			last_spell = SC_SPELL_LAST_DRUID,
		},
		["PRIEST"] = {
			first_spell = SC_SPELL_FIRST_PRIEST,
			last_spell = SC_SPELL_LAST_PRIEST,
		},
		["PALADIN"] = {
			first_spell = SC_SPELL_FIRST_PALADIN,
			last_spell = SC_SPELL_LAST_PALADIN,
		},
		["SHAMAN"] = {
			first_spell = SC_SPELL_FIRST_SHAMAN,
			last_spell = SC_SPELL_LAST_SHAMAN,
		},
		["HUNTER"] = {
			first_spell = SC_SPELL_FIRST_HUNTER,
			last_spell = SC_SPELL_LAST_HUNTER,
		},
		["MAGE"] = {
			first_spell = SC_SPELL_FIRST_MAGE,
			last_spell = SC_SPELL_LAST_MAGE,
		},
		["WARLOCK"] = {
			first_spell = SC_SPELL_FIRST_WARLOCK,
			last_spell = SC_SPELL_LAST_WARLOCK,
		},
	};

	if(SpellsOfClass[class]) then
		for i=SpellsOfClass[class].first_spell, SpellsOfClass[class].last_spell do
			if(SC_SpellCollections[i]) then
				local SpellRank = SC_SpellCollections[i].h_rank;
				local value, crit_val,tick_val,tick,ticktotal = _SC_GetEstimated(bself, i,SpellRank,fullstats);
				StatCompare_SpellsVals[i] = {};
				StatCompare_SpellsVals[i].rank = SpellRank;
				StatCompare_SpellsVals[i].spellname = SC_SpellCollections[i].name;
				StatCompare_SpellsVals[i].avg = value;
				StatCompare_SpellsVals[i].avgcrit = crit_val;
				if(tick_val) then
					StatCompare_SpellsVals[i].tickval = tick_val;
					StatCompare_SpellsVals[i].tick = tick;
					StatCompare_SpellsVals[i].ticktotal = ticktotal;
				end
			end
		end
	end
end

function StatCompare_GetSpellsTooltipText(fullstats, unit)
	local retstr="";
	local healstr="";
	local attackstr="";

	StatCompare_SpellStats_Scan(fullstats, unit);
	if(StatCompare_SpellsVals) then
		for i,e in StatCompare_SpellsVals do
			if(SC_SpellCollections[i].type == "h") then
				healstr = healstr.."\n".. e.spellname .. ":\t" .. e.avg;
				if(e.avgcrit > 0) then
					healstr = healstr .. "/" .. GREEN_FONT_COLOR_CODE .. e.avgcrit .. FONT_COLOR_CODE_CLOSE ;
				end
				if(e.tick) then
					healstr = healstr.."\n" ..STATCOMPARE_HOT_PREFIX..":\t".. e.tickval.. "/" ..e.tick.."s (".. e.ticktotal ..")";
				end
			elseif(SC_SpellCollections[i].type == "a") then
				attackstr = attackstr.."\n".. e.spellname .. ":\t" .. e.avg;
				if(e.avgcrit > 0) then
					attackstr = attackstr.. "/" .. GREEN_FONT_COLOR_CODE .. e.avgcrit .. FONT_COLOR_CODE_CLOSE ;
				end
				if(e.tick) then
					attackstr = attackstr.."\n" ..STATCOMPARE_DOT_PREFIX..":\t".. e.tickval.. "/" ..e.tick.."s (".. e.ticktotal ..")";
				end
			end
		end

		if(healstr~="") then
			retstr = GREEN_FONT_COLOR_CODE ..STATCOMPARE_HEALSPELL_PREFIX ..FONT_COLOR_CODE_CLOSE.. ":\n" .. healstr .. "\n\n";
		end
		if(healstr~="" or attackstr~="") then
			retstr = retstr .. GREEN_FONT_COLOR_CODE .. STATCOMPARE_ATTACKSPELL_PREFIX .. ":\n" ..FONT_COLOR_CODE_CLOSE.. attackstr;
		end
		local settitle="\n"..GREEN_FONT_COLOR_CODE..STATCOMPARE_SPELLSKILL_INFO..FONT_COLOR_CODE_CLOSE.."\n\n"
		if (retstr~="") then retstr=settitle..retstr; end
	end
	-- Throw it to GC
	StatCompare_SpellsVals = {};
	return retstr;
end

function StatCompare_SpellStats_GetTotalValue(effect)
	local i,e;
	local value = 0;
	if(type(effect) == "string") then
		if(StatScanner_bonuses[effect]) then
			value = StatScanner_bonuses[effect];
		end
	else 
	-- list of effects
		for i,e in effect do
			value = value + StatCompare_SpellStats_GetTotalValue(e);
		end
	end
	return value;
end;