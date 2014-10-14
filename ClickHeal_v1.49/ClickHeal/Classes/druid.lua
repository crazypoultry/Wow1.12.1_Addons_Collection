--=============================================================================
-- File:		druid.lua
-- Author:		rudy
-- Description:		configuration file for the druid class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'DRUID' ) then

CH_EMERGENCY_SPELLS_ACTIONS = {'QUICK','HOT','SLOW','SHIELD','NONE'};

CH_DefaultEmergencySpells = { FULL={}, TRASH={}, BATTLEFIELD={}, CUSTOM1={}, CUSTOM2={}, CUSTOM3={} };

CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_NONE]      = { DRUID   = {},
                                                           HUNTER  = {},
                                                           MAGE    = {},
                                                           PALADIN = {},
                                                           PRIEST  = {},
                                                           ROGUE   = {},
                                                           SHAMAN  = {},
                                                           WARLOCK = {},
                                                           WARRIOR = {},
                                                           PET     = {}
                                                         };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_WOUNDED]   = { DRUID   = {'HOT'},
                                                           HUNTER  = {'HOT'},
                                                           MAGE    = {'HOT'},
                                                           PALADIN = {'HOT'},
                                                           PRIEST  = {'HOT'},
                                                           ROGUE   = {'HOT'},
                                                           SHAMAN  = {'HOT'},
                                                           WARLOCK = {'HOT'},
                                                           WARRIOR = {'HOT'},
                                                           PET     = {'HOT'}
                                                         };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_FAIR]      = { DRUID   = {'HOT','QUICK'},
                                                           HUNTER  = {'HOT','QUICK'},
                                                           MAGE    = {'HOT','QUICK'},
                                                           PALADIN = {'HOT','QUICK'},
                                                           PRIEST  = {'HOT','QUICK'},
                                                           ROGUE   = {'HOT','QUICK'},
                                                           SHAMAN  = {'HOT','QUICK'},
                                                           WARLOCK = {'HOT','QUICK'},
                                                           WARRIOR = {'HOT','QUICK'},
                                                           PET     = {'HOT','QUICK'}
                                                         };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_POOR]      = { DRUID   = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           HUNTER  = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           MAGE    = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           PALADIN = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           PRIEST  = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           ROGUE   = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           SHAMAN  = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           WARLOCK = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           WARRIOR = {'SHIELD','QUICK','HOT','!QUICK'},
                                                           PET     = {'SHIELD','QUICK'}
                                                         };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_CRITIC]    = { DRUID   = {'SHIELD','!QUICK'},
                                                           HUNTER  = {'SHIELD','!QUICK'},
                                                           MAGE    = {'SHIELD','!QUICK'},
                                                           PALADIN = {'SHIELD','!QUICK'},
                                                           PRIEST  = {'SHIELD','!QUICK'},
                                                           ROGUE   = {'SHIELD','!QUICK'},
                                                           SHAMAN  = {'SHIELD','!QUICK'},
                                                           WARLOCK = {'SHIELD','!QUICK'},
                                                           WARRIOR = {'SHIELD','!QUICK'},
                                                           PET     = {'SHIELD','!QUICK'}
                                                         };
 
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_NONE]     = { DRUID   = {},
                                                           HUNTER  = {},
                                                           MAGE    = {},
                                                           PALADIN = {},
                                                           PRIEST  = {},
                                                           ROGUE   = {},
                                                           SHAMAN  = {},
                                                           WARLOCK = {},
                                                           WARRIOR = {},
                                                           PET     = {}
                                                         };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_WOUNDED]  = { DRUID   = {},
                                                           HUNTER  = {},
                                                           MAGE    = {},
                                                           PALADIN = {},
                                                           PRIEST  = {},
                                                           ROGUE   = {},
                                                           SHAMAN  = {},
                                                           WARLOCK = {},
                                                           WARRIOR = {'HOT'},
                                                           PET     = {}
                                                         };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_FAIR]     = { DRUID   = {'!QUICK'},
                                                           HUNTER  = {'!QUICK'},
                                                           MAGE    = {'!QUICK'},
                                                           PALADIN = {'!QUICK'},
                                                           PRIEST  = {'!QUICK'},
                                                           ROGUE   = {'!QUICK'},
                                                           SHAMAN  = {'!QUICK'},
                                                           WARLOCK = {'!QUICK'},
                                                           WARRIOR = {'!QUICK'},
                                                           PET     = {}
                                                         };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_POOR]     = { DRUID   = {'!QUICK'},
                                                           HUNTER  = {'!QUICK'},
                                                           MAGE    = {'!QUICK'},
                                                           PALADIN = {'!QUICK'},
                                                           PRIEST  = {'!QUICK'},
                                                           ROGUE   = {'!QUICK'},
                                                           SHAMAN  = {'!QUICK'},
                                                           WARLOCK = {'!QUICK'},
                                                           WARRIOR = {'!QUICK'},
                                                           PET     = {'QUICK'}
                                                         };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_CRITIC]   = { DRUID   = {'SHIELD','!QUICK'},
                                                           HUNTER  = {'SHIELD','!QUICK'},
                                                           MAGE    = {'SHIELD','!QUICK'},
                                                           PALADIN = {'SHIELD','!QUICK'},
                                                           PRIEST  = {'SHIELD','!QUICK'},
                                                           ROGUE   = {'SHIELD','!QUICK'},
                                                           SHAMAN  = {'SHIELD','!QUICK'},
                                                           WARLOCK = {'SHIELD','!QUICK'},
                                                           WARRIOR = {'SHIELD','!QUICK'},
                                                           PET     = {'SHIELD','!QUICK'}
                                                  };

CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_NONE]     = { DRUID   = {},
                                                                 HUNTER  = {},
                                                                 MAGE    = {},
                                                                 PALADIN = {},
                                                                 PRIEST  = {},
                                                                 ROGUE   = {},
                                                                 SHAMAN  = {},
                                                                 WARLOCK = {},
                                                                 WARRIOR = {},
                                                                 PET     = {}
                                                               };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_WOUNDED]  = { DRUID   = {},
                                                                 HUNTER  = {},
                                                                 MAGE    = {},
                                                                 PALADIN = {},
                                                                 PRIEST  = {},
                                                                 ROGUE   = {},
                                                                 SHAMAN  = {},
                                                                 WARLOCK = {},
                                                                 WARRIOR = {},
                                                                 PET     = {}
                                                               };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_FAIR]     = { DRUID   = {'QUICK'},
                                                                 HUNTER  = {'QUICK'},
                                                                 MAGE    = {'QUICK'},
                                                                 PALADIN = {'!QUICK'},
                                                                 PRIEST  = {'QUICK'},
                                                                 ROGUE   = {'QUICK'},
                                                                 SHAMAN  = {'QUICK'},
                                                                 WARLOCK = {'QUICK'},
                                                                 WARRIOR = {'!QUICK'},
                                                                 PET     = {}
                                                               };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_POOR]     = { DRUID   = {'!QUICK'},
                                                                 HUNTER  = {'!QUICK'},
                                                                 MAGE    = {'!QUICK'},
                                                                 PALADIN = {'!QUICK'},
                                                                 PRIEST  = {'!QUICK'},
                                                                 ROGUE   = {'!QUICK'},
                                                                 SHAMAN  = {'!QUICK'},
                                                                 WARLOCK = {'!QUICK'},
                                                                 WARRIOR = {'!QUICK'},
                                                                 PET     = {'QUICK'}
                                                               };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_CRITIC]   = { DRUID   = {'SHIELD','!QUICK'},
                                                                 HUNTER  = {'SHIELD','!QUICK'},
                                                                 MAGE    = {'SHIELD','!QUICK'},
                                                                 PALADIN = {'SHIELD','!QUICK'},
                                                                 PRIEST  = {'SHIELD','!QUICK'},
                                                                 ROGUE   = {'SHIELD','!QUICK'},
                                                                 SHAMAN  = {'SHIELD','!QUICK'},
                                                                 WARLOCK = {'SHIELD','!QUICK'},
                                                                 WARRIOR = {'SHIELD','!QUICK'},
                                                                 PET     = {'SHIELD','!QUICK'}
                                                        };

CH_DefaultEmergencySpells.CUSTOM1[CH_EMERGENCY_NONE]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM1[CH_EMERGENCY_WOUNDED] = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM1[CH_EMERGENCY_FAIR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM1[CH_EMERGENCY_POOR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM1[CH_EMERGENCY_CRITIC]  = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
 
CH_DefaultEmergencySpells.CUSTOM2[CH_EMERGENCY_NONE]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM2[CH_EMERGENCY_WOUNDED] = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM2[CH_EMERGENCY_FAIR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM2[CH_EMERGENCY_POOR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM2[CH_EMERGENCY_CRITIC]  = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
 
CH_DefaultEmergencySpells.CUSTOM3[CH_EMERGENCY_NONE]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM3[CH_EMERGENCY_WOUNDED] = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM3[CH_EMERGENCY_FAIR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM3[CH_EMERGENCY_POOR]    = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
CH_DefaultEmergencySpells.CUSTOM3[CH_EMERGENCY_CRITIC]  = { DRUID = {}, HUNTER = {}, MAGE = {}, PALADIN = {}, PRIEST = {}, ROGUE = {}, SHAMAN = {}, WARLOCK = {}, WARRIOR = {}, PET = {} };
 
CH_DEF_MOUSE_SPELLS =
  { Friend      = {LeftButton={'ACTION','QUICK'},       MiddleButton={'ACTION','SHIELD'},      RightButton={'ACTION','HOT'},
                   ShiftLeftButton={'ACTION','SLOW'},   ShiftMiddleButton={'ACTION','BUFF'},   ShiftRightButton={'ACTION','DEBUFF'},
                   CtrlLeftButton={'ACTION','TARGET'},  CtrlMiddleButton={'PLUGIN','BANDAGE'}, CtrlRightButton={'ACTION','ASSIST'},
                   AltLeftButton={'ACTION','TOOLTIP'},                                         AltRightButton={'ACTION','MENU'},
                  },
    EnemyCASTER = {CtrlLeftButton={'ACTION','TARGET'},  CtrlMiddleButton={'ACTION','USEWAND'}, CtrlRightButton={'ACTION','ATTACK'},
                    AltLeftButton={'ACTION','TOOLTIP'},                                         AltRightButton={'ACTION','MENU'},
                  },
    Panic       = {LeftButton={'ACTION','PANIC'},       MiddleButton={'ACTION','GRPBUFF'},     RightButton={'ACTION','GRPCURE'},
                  },
    Extra1      = {LeftButton={'ACTION','CONFIG'},      MiddleButton={'ACTION','CONFIG'},      RightButton={'ACTION','CONFIG'},
                  },
    Extra2      = {
                  },
    Extra3      = {LeftButton={'SPELL',CH_SPELL_TRANQUILITY},
                   CtrlLeftButton={'PLUGIN','HEALPOD'},                                        CtrlRightButton={'PLUGIN','MANAPOD'},
                   AltLeftButton={'PLUGIN','FOOD'},     AltMiddleButton={'PLUGIN','FEAST'},    AltRightButton={'PLUGIN','DRINK'},
                  },
    Extra4      = {LeftButton={'SPELL',CH_SPELL_BARKSKIN},
                  },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_DRUID_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_DRUID_EXTRA2_LABEL, cooldownSpellName=nil,  
                               },
                      Extra3 = { name=CH_DRUID_EXTRA3_LABEL, cooldownSpellName=nil,  
                               },
                      Extra4 = { name=CH_DRUID_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_BARKSKIN,  
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_DRUID_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_DRUID_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_DRUID_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_DRUID_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_DRUID_ACTION_TYPE_TEXT_USEWAND,
                        ANYITEM   = CH_ACTION_TYPE_TEXT_ANYITEM,
                        TOTEMSET  = CH_ACTION_TYPE_TEXT_TOTEMSET,
                        CHAIN     = CH_ACTION_TYPE_TEXT_CHAIN,
                        SCRIPT    = CH_ACTION_TYPE_TEXT_SCRIPT,
                        MENU      = CH_ACTION_TYPE_TEXT_MENU,
                        TOOLTIP   = CH_ACTION_TYPE_TEXT_TOOLTIP,
                        SPELL     = CH_ACTION_TYPE_TEXT_SPELL,
                        PETSPELL  = CH_ACTION_TYPE_TEXT_PETSPELL,
                        PANIC     = CH_ACTION_TYPE_TEXT_PANIC,
                        GRPBUFF   = CH_ACTION_TYPE_TEXT_GRPBUFF,
                        GRPCURE   = CH_ACTION_TYPE_TEXT_GRPCURE,
                        NONE      = CH_ACTION_TYPE_TEXT_NONE,
                      };

-- NOTE: When adding new buff, buff priority must be new high value. If instered in the middle,
--       you have to reset all buffs of this class!!
CH_BUFF_DATA = { bT       = { displayName    = CH_DRUID_BUFF_BT_LABEL,
                              spellName      = {CH_SPELL_THORNS}, 
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=0,MAGE=0,WARLOCK=0,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_DRUID_BUFF_BT_EFFECT,
                              buffPriority   = 1,
                              buffEnabled    = true,
                            }, 
                 bMotW    = { displayName    = CH_DRUID_BUFF_MOTW_LABEL,
                              spellName      = {CH_SPELL_MARK_OF_THE_WILD}, 
                              partySpellName = CH_SPELL_GIFT_OF_THE_WILD,
                              partySpellType = 'PARTY',
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_DRUID_BUFF_MOTW_EFFECT,
                              buffPriority   = 2,
                              buffEnabled    = true,
                            }, 
                 bOoC     = { displayName    = CH_DRUID_BUFF_OOC_LABEL,
                              spellName      = {CH_SPELL_OMEN_OF_CLARITY}, 
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_DRUID_BUFF_OOC_EFFECT,
                              buffPriority   = 3,
                              buffEnabled    = true,
                            }, 
               };

CH_SPELL_DATA = { QUICK      = { CH_SPELL_HEALING_TOUCH, CH_SPELL_REGROWTH,
                               },
                  SLOW       = { CH_SPELL_HEALING_TOUCH,
                               },
                  HOT        = { CH_SPELL_HEALING_TOUCH, CH_SPELL_REJUVENATION,
                               },
                  SHIELD     = { CH_SPELL_HEALING_TOUCH, CH_SPELL_REGROWTH, CH_SPELL_SWIFTMEND,
                               },
                  COOLDOWN   = { CH_SPELL_HEALING_TOUCH,
                               },
                  HEALUP     = { CH_SPELL_HEALING_TOUCH,
                               },
                  RANGE      = { CH_SPELL_REGROWTH, CH_SPELL_HEALING_TOUCH,
                               },
                  INSTARANGE = { CH_SPELL_REJUVENATION,
                               },
                };

CH_SPELL_INFO = { 
  [CH_SPELL_HEALING_TOUCH]    = {type="once",    ranks={1,8,14,20,26,32,38,44,50,56,60},  checkRank=false, pattern=CH_SPELL_PATTERN_HEALING_TOUCH, min=1,   max=2,   duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_REGROWTH]         = {type="regrowth",ranks={12,18,24,30,36,42,48,54,60},      checkRank=true,  pattern=CH_SPELL_PATTERN_REGROWTH,      min=1,   max=2,   duration=21,   warnTime=5,   refreshTime=5,    selfOnly=false, atFullHealth=true},
  [CH_SPELL_REJUVENATION]     = {type="once",    ranks={4,10,16,22,28,34,40,46,52,58,60}, checkRank=true,  pattern=nil,                            min=nil, max=nil, duration=12,   warnTime=3,   refreshTime=3,    selfOnly=false, atFullHealth=true},
  [CH_SPELL_TRANQUILITY]      = {type="channel", ranks={30,40,50,60},                     checkRank=false, pattern=nil,                            min=nil, max=nil, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=true},
  [CH_SPELL_MARK_OF_THE_WILD] = {type="buff",    ranks={1,10,20,30,40,50,60},             checkRank=true,                                                            duration=1800, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true},
  [CH_SPELL_GIFT_OF_THE_WILD] = {type="buff",    ranks={50,60},                           checkRank=false,                                                           duration=3600, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true},
  [CH_SPELL_THORNS]           = {type="buff",    ranks={6,14,24,34,44,54},                checkRank=true,                                                            duration=600,  warnTime=120, refreshTime=480,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_OMEN_OF_CLARITY]  = {type="buff",    ranks={20},                              checkRank=false,                                                           duration=600,  warnTime=120, refreshTime=480,  selfOnly=true,  atFullHealth=true},
};

CH_SPELL_INFO[CH_SPELL_REGROWTH].pattern1 = CH_SPELL_PATTERN_REGROWTH1;

CH_RESURRECT_SPELL = CH_SPELL_REBIRTH;

end
