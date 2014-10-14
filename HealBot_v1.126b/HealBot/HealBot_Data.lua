HealBot_ConfigDefaults = {
  Version = HEALBOT_VERSION,
  AlertLevel = 0.95,
  AutoClose = 1,
  PanelSounds = 1,
  GroupHeals = 1,
  TankHeals = 1,
  TargetHeals = 1,
  EmergencyHeals = 1,
  ActionLocked = 0,
  OverHeal = 0.25,
  CastNotify = 1,
  HideOptions = 0,
  HideAbort = 1,
  ShowTooltip = 1,
  GrowUpwards = 0,
  ProtectPvP = 1,
  QualityRange = 0,
  EmergIncMonitor = 1,
  EmergencyFClass = 4,
  ExtraOrder      = 1,
  ShowDebuffWarning = 0,
  SoundDebuffWarning = 0,
  SoundDebuffPlay = 1,
  CDCMonitor = 1,
  PanelAnchorX = -1,
  PanelAnchorY = -1,
  ShowClassOnBar = 0,
  ShowHealthOnBar = 0,
  BarHealthType = 1,
  ShowClassOnBarWithName = 0,
  SetClassColourText = 0,
  CDCBarColour = {
    [HEALBOT_DISEASE_en] = { R = 0.1, G = 0.05, B = 0.2, },
    [HEALBOT_MAGIC_en] = { R = 0.05, G = 0.05, B = 0.1, },
    [HEALBOT_POISON_en] = { R = 0.05, G = 0.2, B = 0.1, },
    [HEALBOT_CURSE_en] = { R = 0.2, G = 0.05, B = 0.05, },
  },
  Debuff_Left = {
    [HEALBOT_DRUID]    = 1,
    [HEALBOT_PALADIN]  = 1,
    [HEALBOT_PRIEST]   = 1,
    [HEALBOT_SHAMAN]   = 1,
  },
  Debuff_Right = {
    [HEALBOT_DRUID]    = 1,
    [HEALBOT_PALADIN]  = 1,
    [HEALBOT_PRIEST]   = 1,
    [HEALBOT_SHAMAN]   = 1,
  },
  EmergIncRange = {
    [HEALBOT_DRUID]    = 0,
    [HEALBOT_HUNTER]   = 1,
    [HEALBOT_MAGE]     = 1,
    [HEALBOT_PALADIN]  = 0,
    [HEALBOT_PRIEST]   = 0,
    [HEALBOT_ROGUE]    = 0,
    [HEALBOT_SHAMAN]   = 0,
    [HEALBOT_WARLOCK]  = 1,
    [HEALBOT_WARRIOR]  = 0,
  },
  EmergIncMelee = {
    [HEALBOT_DRUID]    = 0,
    [HEALBOT_HUNTER]   = 0,
    [HEALBOT_MAGE]     = 0,
    [HEALBOT_PALADIN]  = 0,
    [HEALBOT_PRIEST]   = 0,
    [HEALBOT_ROGUE]    = 1,
    [HEALBOT_SHAMAN]   = 0,
    [HEALBOT_WARLOCK]  = 0,
    [HEALBOT_WARRIOR]  = 1,
  },
  EmergIncHealers = {
    [HEALBOT_DRUID]    = 1,
    [HEALBOT_HUNTER]   = 0,
    [HEALBOT_MAGE]     = 0,
    [HEALBOT_PALADIN]  = 0,
    [HEALBOT_PRIEST]   = 1,
    [HEALBOT_ROGUE]    = 0,
    [HEALBOT_SHAMAN]   = 0,
    [HEALBOT_WARLOCK]  = 0,
    [HEALBOT_WARRIOR]  = 0,
  },
  EmergIncCustom = {
    [HEALBOT_DRUID]    = 1,
    [HEALBOT_HUNTER]   = 0,
    [HEALBOT_MAGE]     = 1,
    [HEALBOT_PALADIN]  = 1,
    [HEALBOT_PRIEST]   = 1,
    [HEALBOT_ROGUE]    = 0,
    [HEALBOT_SHAMAN]   = 1,
    [HEALBOT_WARLOCK]  = 1,
    [HEALBOT_WARRIOR]  = 0,
  },
  KeyCombo = {
    [HEALBOT_DRUID] = {
      ["Left"] = HEALBOT_REGROWTH,
      ["ShiftLeft"] = HEALBOT_REGROWTH .. HEALBOT_RANK_7,
      ["CtrlLeft"] = HEALBOT_REGROWTH .. HEALBOT_RANK_5,
      ["ShiftCtrlLeft"] = HEALBOT_REGROWTH .. HEALBOT_RANK_3,
      ["Right"] = HEALBOT_HEALING_TOUCH,
      ["ShiftRight"] = HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_8,
      ["CtrlRight"] = HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_6,
      ["ShiftCtrlRight"] = HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_4,
      ["Middle"] = HEALBOT_REJUVENATION,
      ["ShiftMiddle"] = HEALBOT_REJUVENATION .. HEALBOT_RANK_8,
      ["CtrlMiddle"] = HEALBOT_REJUVENATION .. HEALBOT_RANK_6,
      ["ShiftCtrlMiddle"] = HEALBOT_REJUVENATION .. HEALBOT_RANK_4,
      ["Button4"] = HEALBOT_MARK_OF_THE_WILD,
    },
    [HEALBOT_PALADIN] = {
      ["Left"] = HEALBOT_FLASH_OF_LIGHT,
      ["ShiftLeft"] = HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_5,
      ["CtrlLeft"] = HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_3,
      ["ShiftCtrlLeft"] = HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_1,
      ["Right"] = HEALBOT_HOLY_LIGHT,
      ["ShiftRight"] = HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_8,
      ["CtrlRight"] = HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_6,
      ["ShiftCtrlRight"] = HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_4,
      ["Middle"] =  HEALBOT_BLESSING_OF_SALVATION,
    },
    [HEALBOT_PRIEST] = {
      ["Left"] = HEALBOT_FLASH_HEAL,
      ["ShiftLeft"] = HEALBOT_FLASH_HEAL .. HEALBOT_RANK_5,
      ["CtrlLeft"] = HEALBOT_FLASH_HEAL .. HEALBOT_RANK_3,
      ["ShiftCtrlLeft"] = HEALBOT_FLASH_HEAL .. HEALBOT_RANK_1,
      ["Right"] = HEALBOT_GREATER_HEAL,
      ["ShiftRight"] = HEALBOT_GREATER_HEAL .. HEALBOT_RANK_2,
      ["CtrlRight"] = HEALBOT_HEAL .. HEALBOT_RANK_4,
      ["ShiftCtrlRight"] = HEALBOT_HEAL .. HEALBOT_RANK_2,
      ["Middle"] = HEALBOT_RENEW,
      ["ShiftMiddle"] = HEALBOT_RENEW .. HEALBOT_RANK_7,
      ["CtrlMiddle"] = HEALBOT_RENEW .. HEALBOT_RANK_5,
      ["ShiftCtrlMiddle"] = HEALBOT_RENEW .. HEALBOT_RANK_3,
      ["Button4"] = HEALBOT_POWER_WORD_SHIELD,
      ["ShiftButton4"] = HEALBOT_POWER_WORD_FORTITUDE,
      ["Button5"] = HEALBOT_PRAYER_OF_HEALING,
    },
    [HEALBOT_SHAMAN] = {
      ["Left"] = HEALBOT_LESSER_HEALING_WAVE,
      ["ShiftLeft"] = HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_5,
      ["CtrlLeft"] = HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_3,
      ["ShiftCtrlLeft"] = HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_1,
      ["Right"] = HEALBOT_HEALING_WAVE,
      ["ShiftRight"] = HEALBOT_HEALING_WAVE .. HEALBOT_RANK_8,
      ["CtrlRight"] = HEALBOT_HEALING_WAVE .. HEALBOT_RANK_6,
      ["ShiftCtrlRight"] = HEALBOT_HEALING_WAVE .. HEALBOT_RANK_4,
      ["Middle"] = HEALBOT_CHAIN_HEAL,
    },
  },
  DisKeyCombo = {
    [HEALBOT_DRUID] = {
      ["Left"] = HEALBOT_DISABLED_TARGET,
      ["AltLeft"] = HEALBOT_THORNS,
      ["Right"] = HEALBOT_MARK_OF_THE_WILD,
      ["Middle"] = HEALBOT_REJUVENATION,
      ["AltMiddle"] = HEALBOT_REBIRTH,
    },
    [HEALBOT_PALADIN] = {
      ["Left"] = HEALBOT_DISABLED_TARGET,
      ["Right"] = HEALBOT_REDEMPTION,
      ["Middle"] =  HEALBOT_BLESSING_OF_SALVATION,
    },
    [HEALBOT_PRIEST] = {
      ["Left"] = HEALBOT_DISABLED_TARGET,
      ["AltLeft"] = HEALBOT_RESURRECTION,
      ["Right"] = HEALBOT_POWER_WORD_FORTITUDE,
      ["AltRight"] = HEALBOT_DIVINE_SPIRIT,
      ["Middle"] = HEALBOT_POWER_WORD_SHIELD,
      ["AltMiddle"] = HEALBOT_RENEW,
    },
    [HEALBOT_SHAMAN] = {
      ["Left"] = HEALBOT_DISABLED_TARGET,
      ["Right"] = HEALBOT_ANCESTRALSPIRIT,
    },
  },
  EnableHealthy = 0,
  ActionVisible = 0,
  CDCLeftText = {[HEALBOT_PRIEST]="None", [HEALBOT_SHAMAN]="None", [HEALBOT_DRUID]="None", [HEALBOT_PALADIN]="None",},
  CDCRightText = {[HEALBOT_PRIEST]="None", [HEALBOT_SHAMAN]="None", [HEALBOT_DRUID]="None", [HEALBOT_PALADIN]="None",},
  Current_Skin = HEALBOT_SKINS_STD,
  Skin_ID = 1,
  Skins = {HEALBOT_SKINS_STD, "HealBot Party", "HealBot Raid", "Alteric Valley"},
  numcols = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 4, ["Alteric Valley"] = 2},
  btexture = {[HEALBOT_SKINS_STD] = 8,["HealBot Party"] = 6, ["HealBot Raid"] = 7, ["Alteric Valley"] = 9},
  bcspace = {[HEALBOT_SKINS_STD] = 4, ["HealBot Party"] = 4, ["HealBot Raid"] = 2, ["Alteric Valley"] = 2},
  brspace = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 2, ["HealBot Raid"] = 2, ["Alteric Valley"] = 1},
  bwidth =  {[HEALBOT_SKINS_STD] = 122, ["HealBot Party"] = 115, ["HealBot Raid"] = 90, ["Alteric Valley"] = 85},
  bheight = {[HEALBOT_SKINS_STD] = 19, ["HealBot Party"] = 18, ["HealBot Raid"] = 14, ["Alteric Valley"] = 16},
  btextenabledcolr = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextenabledcolg = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextenabledcolb = {[HEALBOT_SKINS_STD] = 0, ["HealBot Party"] = 0, ["HealBot Raid"] = 0, ["Alteric Valley"] = 0},
  btextenabledcola = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextdisbledcolr = {[HEALBOT_SKINS_STD] = 0.5, ["HealBot Party"] = 0.5, ["HealBot Raid"] = 0.5, ["Alteric Valley"] = 0.4},
  btextdisbledcolg = {[HEALBOT_SKINS_STD] = 0.5, ["HealBot Party"] = 0.5, ["HealBot Raid"] = 0.5, ["Alteric Valley"] = 0.4},
  btextdisbledcolb = {[HEALBOT_SKINS_STD] = 0.5, ["HealBot Party"] = 0.5, ["HealBot Raid"] = 0.5, ["Alteric Valley"] = 0.4},
  btextdisbledcola = {[HEALBOT_SKINS_STD] = 0.45, ["HealBot Party"] = 0.75, ["HealBot Raid"] = 0.75, ["Alteric Valley"] = 0},
  btextcursecolr = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextcursecolg = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextcursecolb = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  btextcursecola = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  backcola = {[HEALBOT_SKINS_STD] = 0.05, ["HealBot Party"] = 0.25, ["HealBot Raid"] = 0.25, ["Alteric Valley"] = 0},
  Barcola    = {[HEALBOT_SKINS_STD] = 0.85, ["HealBot Party"] = 0.85, ["HealBot Raid"] = 0.85, ["Alteric Valley"] = 0.85},
  BarcolaInHeal = {[HEALBOT_SKINS_STD] = 0.40, ["HealBot Party"] = 0.35, ["HealBot Raid"] = 0.35, ["Alteric Valley"] = 0.5},
  backcolr = {[HEALBOT_SKINS_STD] = 0.1, ["HealBot Party"] = 0.1, ["HealBot Raid"] = 0.1, ["Alteric Valley"] = 0.2},
  backcolg = {[HEALBOT_SKINS_STD] = 0.1, ["HealBot Party"] = 0.1, ["HealBot Raid"] = 0.1, ["Alteric Valley"] = 0.2},
  backcolb = {[HEALBOT_SKINS_STD] = 0.7, ["HealBot Party"] = 0.7, ["HealBot Raid"] = 0.7, ["Alteric Valley"] = 0.2},
  borcolr = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 0.2},
  borcolg = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 0.2},
  borcolb = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 0.2},
  borcola = {[HEALBOT_SKINS_STD] = 0.25, ["HealBot Party"] = 0.8, ["HealBot Raid"] = 0.8, ["Alteric Valley"] = 0.1},
  btextheight = {[HEALBOT_SKINS_STD] = 10, ["HealBot Party"] = 10, ["HealBot Raid"] = 9, ["Alteric Valley"] = 10},
  bardisa = {[HEALBOT_SKINS_STD] = 0.15, ["HealBot Party"] = 0.75, ["HealBot Raid"] = 0.75, ["Alteric Valley"] = 0},
  abortsize = {[HEALBOT_SKINS_STD] = 7, ["HealBot Party"] = 10, ["HealBot Raid"] = 5, ["Alteric Valley"] = 6},
  babortcolr = {[HEALBOT_SKINS_STD] = 0.1, ["HealBot Party"] = 0.1, ["HealBot Raid"] = 0.1, ["Alteric Valley"] = 0.2},
  babortcolg = {[HEALBOT_SKINS_STD] = 0.1, ["HealBot Party"] = 0.1, ["HealBot Raid"] = 0.1, ["Alteric Valley"] = 0.2},
  babortcolb = {[HEALBOT_SKINS_STD] = 0.5, ["HealBot Party"] = 0.5, ["HealBot Raid"] = 0.5, ["Alteric Valley"] = 0.6},
  babortcola = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  ShowHeader = {[HEALBOT_SKINS_STD] = 1, ["HealBot Party"] = 1, ["HealBot Raid"] = 1, ["Alteric Valley"] = 1},
  Tooltip_ShowSpellDetail = 0,
  Tooltip_ShowTarget = 1,
  Tooltip_Recommend = 1,
  TooltipPos = 1,  
  ExtraIncGroup = {[1] = true, [2] = true, [3] = true, [4] = true, 
                   [5] = true, [6] = true, [7] = true, [8] = true},
};

HealBot_Config = {};

--HealBot_EmergIncMelee = {};
--HealBot_EmergIncRange = {};
--HealBot_EmergIncHealers = {};
--HealBot_EmergIncCustom = {};
--HealBot_KeyCombo = {};
HealBot_HealsIn = {};
HealBot_Healers = {};
HealBot_UnitDebuff = {};

HealBot_ResetHealsInFlag=true;

HEALBOT_ADDON_ID="HealBot_Heals"

HealBot_AbortButton=1;

HealBot_Groups = {
  ["ITEMS"] = {
    HEALBOT_BANDAGES,
    HEALBOT_HEALING_POTIONS,
    HEALBOT_HEALTHSTONES,
  },
  ["PALADIN"] = {
    HEALBOT_HOLY_LIGHT,
    HEALBOT_FLASH_OF_LIGHT,
  },
}

HealBot_Spells = {
-- Cast     = secs until effect starts
-- Channel  = secs until caster available
-- Duration = secs until effect ends
-- Shield   = maximum duration

  [HEALBOT_LINEN_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 6.0, 
    Mana =  0, HealsExt =   66, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_HEAVY_LINEN_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 6.0, 
    Mana =  0, HealsExt =  114, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_WOOL_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 7.0, 
    Mana =  0, HealsExt =  161, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_HEAVY_WOOL_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 7.0, 
    Mana =  0, HealsExt =  301, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_SILK_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt =  400, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_HEAVY_SILK_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt =  640, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_MAGEWEAVE_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt =  800, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_HEAVY_MAGEWEAVE_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt = 1104, Level =  1,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_RUNECLOTH_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt = 1360, Level = 52,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },
  [HEALBOT_HEAVY_RUNECLOTH_BANDAGE] = {
    Group = HEALBOT_BANDAGES, Range = 15, Channel = 8.0, 
    Mana =  0, HealsExt = 2000, Level = 58,
    Buff = HEALBOT_BUFF_FIRST_AID, Debuff = HEALBOT_DEBUFF_RECENTLY_BANDAGED },

  [HEALBOT_MINOR_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =   70, HealsMax =   90, Level =  5 },
  [HEALBOT_LESSER_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  140, HealsMax =  180, Level = 13 },
  [HEALBOT_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  280, HealsMax =  360, Level = 22 },
  [HEALBOT_GREATER_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  455, HealsMax =  585, Level = 31 },
  [HEALBOT_SUPERIOR_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  700, HealsMax =  900, Level = 45 },
  [HEALBOT_MAJOR_HEALING_POTION] = {
    Group = HEALBOT_HEALING_POTIONS, Range = 15, Target = {"player"},
    Mana =  0, HealsMin = 1050, HealsMax = 1750, Level = 55 },

  [HEALBOT_MINOR_HEALTHSTONE] = {
    Group = HEALBOT_HEALTHSTONES, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  110, HealsMax =  110, Level = 10 },
  [HEALBOT_LESSER_HEALTHSTONE] = {
    Group = HEALBOT_HEALTHSTONES, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  275, HealsMax =  275, Level = 22 },
  [HEALBOT_HEALTHSTONE] = {
    Group = HEALBOT_HEALTHSTONES, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  500, HealsMax =  500, Level = 34 },
  [HEALBOT_GREATER_HEALTHSTONE] = {
    Group = HEALBOT_HEALTHSTONES, Range = 1, Target = {"player"},
    Mana =  0, HealsMin =  880, HealsMax =  880, Level = 46 },
  [HEALBOT_MAJOR_HEALTHSTONE] = {
    Group = HEALBOT_HEALTHSTONES, Range = 1, Target = {"player"},
    Mana =  0, HealsMin = 1440, HealsMax = 1440, Level = 58 },

-- PALADIN

  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_1] = { Group = HEALBOT_HOLY_LIGHT, Level =  1 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_2] = { Group = HEALBOT_HOLY_LIGHT, Level =  6 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_3] = { Group = HEALBOT_HOLY_LIGHT, Level = 14 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_4] = { Group = HEALBOT_HOLY_LIGHT, Level = 22 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_5] = { Group = HEALBOT_HOLY_LIGHT, Level = 30 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_6] = { Group = HEALBOT_HOLY_LIGHT, Level = 38 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_7] = { Group = HEALBOT_HOLY_LIGHT, Level = 46 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_8] = { Group = HEALBOT_HOLY_LIGHT, Level = 54 },
  [HEALBOT_HOLY_LIGHT .. HEALBOT_RANK_9] = { Group = HEALBOT_HOLY_LIGHT, Level = 60 },

  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_1] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 20 },
  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_2] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 26 },
  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_3] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 34 },
  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_4] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 42 },
  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_5] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 50 },
  [HEALBOT_FLASH_OF_LIGHT .. HEALBOT_RANK_6] = { Group = HEALBOT_FLASH_OF_LIGHT, Level = 58 },

-- DRUID

  [HEALBOT_REJUVENATION .. HEALBOT_RANK_1 ] = { Group = HEALBOT_REJUVENATION, Level =  4, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_2 ] = { Group = HEALBOT_REJUVENATION, Level = 10, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_3 ] = { Group = HEALBOT_REJUVENATION, Level = 16, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_4 ] = { Group = HEALBOT_REJUVENATION, Level = 22, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_5 ] = { Group = HEALBOT_REJUVENATION, Level = 28, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_6 ] = { Group = HEALBOT_REJUVENATION, Level = 34, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_7 ] = { Group = HEALBOT_REJUVENATION, Level = 40, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_8 ] = { Group = HEALBOT_REJUVENATION, Level = 46, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_9 ] = { Group = HEALBOT_REJUVENATION, Level = 52, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_10] = { Group = HEALBOT_REJUVENATION, Level = 58, Buff = HEALBOT_BUFF_REJUVENATION },
  [HEALBOT_REJUVENATION .. HEALBOT_RANK_11] = { Group = HEALBOT_REJUVENATION, Level = 60, Buff = HEALBOT_BUFF_REJUVENATION },

  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_1 ] = { Group = HEALBOT_HEALING_TOUCH, Level =  1 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_2 ] = { Group = HEALBOT_HEALING_TOUCH, Level =  8 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_3 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 14 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_4 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 20 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_5 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 26 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_6 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 32 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_7 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 38 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_8 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 44 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_9 ] = { Group = HEALBOT_HEALING_TOUCH, Level = 50 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_10] = { Group = HEALBOT_HEALING_TOUCH, Level = 56 },
  [HEALBOT_HEALING_TOUCH .. HEALBOT_RANK_11] = { Group = HEALBOT_HEALING_TOUCH, Level = 60 },

  [HEALBOT_REGROWTH .. HEALBOT_RANK_1] = { Group = HEALBOT_REGROWTH, Level = 12, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_2] = { Group = HEALBOT_REGROWTH, Level = 18, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_3] = { Group = HEALBOT_REGROWTH, Level = 24, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_4] = { Group = HEALBOT_REGROWTH, Level = 30, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_5] = { Group = HEALBOT_REGROWTH, Level = 36, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_6] = { Group = HEALBOT_REGROWTH, Level = 42, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_7] = { Group = HEALBOT_REGROWTH, Level = 48, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_8] = { Group = HEALBOT_REGROWTH, Level = 54, Buff = HEALBOT_BUFF_REGROWTH },
  [HEALBOT_REGROWTH .. HEALBOT_RANK_9] = { Group = HEALBOT_REGROWTH, Level = 60, Buff = HEALBOT_BUFF_REGROWTH },

-- PRIEST

  [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_1] = { Group = HEALBOT_LESSER_HEAL, Level =  1 }, 
  [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_2] = { Group = HEALBOT_LESSER_HEAL, Level =  4 }, 
  [HEALBOT_LESSER_HEAL .. HEALBOT_RANK_3] = { Group = HEALBOT_LESSER_HEAL, Level = 10 }, 

  [HEALBOT_HEAL .. HEALBOT_RANK_1] = { Group = HEALBOT_HEAL, Level = 16 }, 
  [HEALBOT_HEAL .. HEALBOT_RANK_2] = { Group = HEALBOT_HEAL, Level = 22 }, 
  [HEALBOT_HEAL .. HEALBOT_RANK_3] = { Group = HEALBOT_HEAL, Level = 28 }, 
  [HEALBOT_HEAL .. HEALBOT_RANK_4] = { Group = HEALBOT_HEAL, Level = 34 }, 

  [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_1] = { Group = HEALBOT_GREATER_HEAL, Level = 40 }, 
  [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_2] = { Group = HEALBOT_GREATER_HEAL, Level = 46 }, 
  [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_3] = { Group = HEALBOT_GREATER_HEAL, Level = 52 }, 
  [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_4] = { Group = HEALBOT_GREATER_HEAL, Level = 58 }, 
  [HEALBOT_GREATER_HEAL .. HEALBOT_RANK_5] = { Group = HEALBOT_GREATER_HEAL, Level = 60 }, 

  [HEALBOT_RENEW .. HEALBOT_RANK_1] = { Group = HEALBOT_RENEW, Level =  8, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_2] = { Group = HEALBOT_RENEW, Level = 14, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_3] = { Group = HEALBOT_RENEW, Level = 20, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_4] = { Group = HEALBOT_RENEW, Level = 26, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_5] = { Group = HEALBOT_RENEW, Level = 32, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_6] = { Group = HEALBOT_RENEW, Level = 38, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_7] = { Group = HEALBOT_RENEW, Level = 44, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_8] = { Group = HEALBOT_RENEW, Level = 50, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_9] = { Group = HEALBOT_RENEW, Level = 56, Buff = HEALBOT_BUFF_RENEW }, 
  [HEALBOT_RENEW .. HEALBOT_RANK_10] = { Group = HEALBOT_RENEW, Level = 60, Buff = HEALBOT_BUFF_RENEW },

  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_1] = { Group = HEALBOT_FLASH_HEAL, Level = 20 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_2] = { Group = HEALBOT_FLASH_HEAL, Level = 26 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_3] = { Group = HEALBOT_FLASH_HEAL, Level = 32 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_4] = { Group = HEALBOT_FLASH_HEAL, Level = 38 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_5] = { Group = HEALBOT_FLASH_HEAL, Level = 44 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_6] = { Group = HEALBOT_FLASH_HEAL, Level = 50 }, 
  [HEALBOT_FLASH_HEAL .. HEALBOT_RANK_7] = { Group = HEALBOT_FLASH_HEAL, Level = 56 }, 
	  
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_1] = { Group = HEALBOT_POWER_WORD_SHIELD, Level =  6, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_2] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 12, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_3] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 18, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_4] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 24, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_5] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 30, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_6] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 36, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_7] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 42, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_8] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 48, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_9] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 54, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 
  [HEALBOT_POWER_WORD_SHIELD .. HEALBOT_RANK_10] = { Group = HEALBOT_POWER_WORD_SHIELD, Level = 60, Buff= HEALBOT_BUFF_POWER_WORD_SHIELD, Debuff = HEALBOT_DEBUF_WEAKENED_SOUL }, 

-- SHAMAN

  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_1] = { Group = HEALBOT_HEALING_WAVE, Level =  1 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_2] = { Group = HEALBOT_HEALING_WAVE, Level =  6 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_3] = { Group = HEALBOT_HEALING_WAVE, Level = 12 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_4] = { Group = HEALBOT_HEALING_WAVE, Level = 18 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_5] = { Group = HEALBOT_HEALING_WAVE, Level = 24 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_6] = { Group = HEALBOT_HEALING_WAVE, Level = 32 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_7] = { Group = HEALBOT_HEALING_WAVE, Level = 40 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_8] = { Group = HEALBOT_HEALING_WAVE, Level = 48 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_9] = { Group = HEALBOT_HEALING_WAVE, Level = 56 }, 
  [HEALBOT_HEALING_WAVE .. HEALBOT_RANK_10] = { Group = HEALBOT_HEALING_WAVE, Level = 60 }, 

  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_1] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 20 }, 
  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_2] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 28 }, 
  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_3] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 36 }, 
  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_4] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 44 }, 
  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_5] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 52 }, 
  [HEALBOT_LESSER_HEALING_WAVE .. HEALBOT_RANK_6] = { Group = HEALBOT_LESSER_HEALING_WAVE, Level = 60 }, 

};
   
HealBot_Debuff_Spells = {
  [HEALBOT_PALADIN] = {
    HEALBOT_PURIFY,
    HEALBOT_CLEANSE,
                      },
  [HEALBOT_DRUID] = {
    HEALBOT_CURE_POISON,
    HEALBOT_REMOVE_CURSE,
    HEALBOT_ABOLISH_POISON,
                      },
  [HEALBOT_PRIEST] = {
    HEALBOT_CURE_DISEASE,
    HEALBOT_ABOLISH_DISEASE,
    HEALBOT_DISPEL_MAGIC..HEALBOT_RANK_1,
    HEALBOT_DISPEL_MAGIC..HEALBOT_RANK_2,
                      },
  [HEALBOT_SHAMAN] = {
    HEALBOT_CURE_POISON,
    HEALBOT_CURE_DISEASE,
                       },
}

HealBot_Debuff_Types = {
  [HEALBOT_PURIFY] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en},
  [HEALBOT_CLEANSE] = {HEALBOT_DISEASE_en, HEALBOT_POISON_en, HEALBOT_MAGIC_en},
  [HEALBOT_CURE_POISON] = {HEALBOT_POISON_en},
  [HEALBOT_REMOVE_CURSE] = {HEALBOT_CURSE_en},
  [HEALBOT_ABOLISH_POISON] = {HEALBOT_POISON_en},
  [HEALBOT_CURE_DISEASE] = {HEALBOT_DISEASE_en},
  [HEALBOT_ABOLISH_DISEASE] = {HEALBOT_DISEASE_en},
  [HEALBOT_DISPEL_MAGIC..HEALBOT_RANK_1] = {HEALBOT_MAGIC_en},
  [HEALBOT_DISPEL_MAGIC..HEALBOT_RANK_2] = {HEALBOT_MAGIC_en},  
}

HealBot_IsFighting = false;

HealBot_DebuffPriority = {"none"};
HealBot_DebuffWatch = {[HEALBOT_DISEASE_en]="NO", [HEALBOT_MAGIC_en]="NO", [HEALBOT_POISON_en]="NO", [HEALBOT_CURSE_en]="NO"};

HealBot_Heals = {};

HealBot_CurrentSpells = {};

HealBot_EmergInc = {};
HealBot_CDCInc = {};
HealBot_Skins = {};
HealBot_ErrorCnt=0;
HealBot_SpamCnt=0;
HealBot_Action_TooltipUnit=nil;
HealBot_Ressing = {};
HealBot_IamRessing = nil;
HealBot_Enabled = {};
