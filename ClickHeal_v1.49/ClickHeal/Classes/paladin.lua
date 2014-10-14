--=============================================================================
-- File:		paladin.lua
-- Author:		rudy
-- Description:		configuration file for the paladin class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'PALADIN' ) then

CH_EMERGENCY_SPELLS_ACTIONS = {'QUICK','SHIELD','SHIELD','NONE'};

CH_DefaultEmergencySpells = { FULL={}, TRASH={}, BATTLEFIELD={}, CUSTOM1={}, CUSTOM2={}, CUSTOM3={} };

CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_NONE]     = { DRUID   = {},
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
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_WOUNDED]  = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_FAIR]     = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_POOR]     = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_CRITIC]   = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'SHIELD','QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'SHIELD','QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'SHIELD','QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };

CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_NONE]    = { DRUID   = {},
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
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_WOUNDED] = { DRUID   = {},
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
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_FAIR]    = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_POOR]    = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_CRITIC]  = { DRUID   = {'QUICK'},
                                                          HUNTER  = {'QUICK'},
                                                          MAGE    = {'SHIELD','QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'SHIELD','QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'SHIELD','QUICK'},
                                                          WARRIOR = {'QUICK'},
                                                          PET     = {'QUICK'}
                                                        };

CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_NONE]    = { DRUID   = {},
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
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_WOUNDED] = { DRUID   = {},
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
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_FAIR]    = { DRUID   = {'QUICK'},
                                                                HUNTER  = {'QUICK'},
                                                                MAGE    = {'QUICK'},
                                                                PALADIN = {'QUICK'},
                                                                PRIEST  = {'QUICK'},
                                                                ROGUE   = {'QUICK'},
                                                                SHAMAN  = {'QUICK'},
                                                                WARLOCK = {'QUICK'},
                                                                WARRIOR = {'QUICK'},
                                                                PET     = {'QUICK'}
                                                              };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_POOR]    = { DRUID   = {'QUICK'},
                                                                HUNTER  = {'QUICK'},
                                                                MAGE    = {'QUICK'},
                                                                PALADIN = {'QUICK'},
                                                                PRIEST  = {'QUICK'},
                                                                ROGUE   = {'QUICK'},
                                                                SHAMAN  = {'QUICK'},
                                                                WARLOCK = {'QUICK'},
                                                                WARRIOR = {'QUICK'},
                                                                PET     = {'QUICK'}
                                                              };
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_CRITIC]  = { DRUID   = {'QUICK'},
                                                                HUNTER  = {'QUICK'},
                                                                MAGE    = {'SHIELD','QUICK'},
                                                                PALADIN = {'QUICK'},
                                                                PRIEST  = {'SHIELD','QUICK'},
                                                                ROGUE   = {'QUICK'},
                                                                SHAMAN  = {'QUICK'},
                                                                WARLOCK = {'SHIELD','QUICK'},
                                                                WARRIOR = {'QUICK'},
                                                                PET     = {'QUICK'}
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
  { Friend = {LeftButton={'ACTION','QUICK'},              MiddleButton={'ACTION','HOT'},            RightButton={'ACTION','SLOW'},
              ShiftLeftButton={'ACTION','SHIELD'},        ShiftMiddleButton={'ACTION','BUFF'},      ShiftRightButton={'ACTION','DEBUFF'},
              CtrlLeftButton={'ACTION','TARGET'},         CtrlMiddleButton={'PLUGIN','BANDAGE'},    CtrlRightButton={'ACTION','ASSIST'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                   AltRightButton={'ACTION','MENU'},
             },
    Enemy  = {CtrlLeftButton={'ACTION','TARGET'},                                                   CtrlRightButton={'ACTION','ATTACK'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                   AltRightButton={'ACTION','MENU'},
             },
    Panic  = {LeftButton={'ACTION','PANIC'},              MiddleButton={'ACTION','GRPBUFF'},        RightButton={'ACTION','GRPCURE'},
             },
    Extra1 = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},                RightButton={'ACTION','CONFIG'},
             },
    Extra2 = {
             },
    Extra3 = {CtrlLeftButton={'PLUGIN','HEALPOD'},                                                  CtrlRightButton={'PLUGIN','MANAPOD'},
              AltLeftButton={'PLUGIN','FOOD'},            AltMiddleButton={'PLUGIN','FEAST'},       AltRightButton={'PLUGIN','DRINK'},
             },
    Extra4 = {LeftButton={'SPELL',CH_SPELL_DIVINE_PROTECTION},
             },
  };


CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_PALADIN_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_PALADIN_EXTRA2_LABEL, cooldownSpellName=nil,
                               },
                      Extra3 = { name=CH_PALADIN_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_PALADIN_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_DIVINE_PROTECTION,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_PALADIN_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_PALADIN_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_PALADIN_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_PALADIN_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_PALADIN_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = { bRF      = { displayName    = CH_PALADIN_BUFF_RF_LABEL,
                              spellName      = {CH_SPELL_RIGHTEOUS_FURY}, 
                              classes        = {WARRIOR=-1,PALADIN=1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_PALADIN_BUFF_RF_EFFECT,
                              buffPriority   = 1,
                              buffEnabled    = true,
                            }, 
                 bBoM     = { displayName    = CH_PALADIN_BUFF_BOM_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_MIGHT}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_MIGHT,
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=0,ROGUE=1,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOM_EFFECT,
                              buffPriority   = 2,
                              buffEnabled    = true,
                            }, 
                 bBoW     = { displayName    = CH_PALADIN_BUFF_BOW_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_WISDOM}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_WISDOM,
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=1,ROGUE=0,HUNTER=0,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOW_EFFECT,
                              buffPriority   = 3,
                              buffEnabled    = true,
                            }, 
                 bBoS     = { displayName    = CH_PALADIN_BUFF_BOS_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_SALVATION}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_SALVATION, 
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOS_EFFECT,
                              buffPriority   = 4,
                              buffEnabled    = true,
                            }, 
                 bBoA     = { displayName    = CH_PALADIN_BUFF_BOA_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_SANCTUARY}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_SANCTUARY, 
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOA_EFFECT,
                              buffPriority   = 5,
                              buffEnabled    = true,
                            }, 
                 bBoL     = { displayName    = CH_PALADIN_BUFF_BOL_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_LIGHT}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_LIGHT, 
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOL_EFFECT,
                              buffPriority   = 6,
                              buffEnabled    = false,
                            }, 
                 bBoP     = { displayName    = CH_PALADIN_BUFF_BOP_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_PROTECTION}, 
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOP_EFFECT,
                              buffPriority   = 7,
                              buffEnabled    = false,
                            }, 
                 bBoF     = { displayName    = CH_PALADIN_BUFF_BOF_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_FREEDOM}, 
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOF_EFFECT,
                              buffPriority   = 8,
                              buffEnabled    = false,
                            }, 
                 bBoC     = { displayName    = CH_PALADIN_BUFF_BOC_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_SACRIFICE}, 
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOC_EFFECT,
                              buffPriority   = 9,
                              buffEnabled    = false,
                            }, 
                 bBoK     = { displayName    = CH_PALADIN_BUFF_BOK_LABEL,
                              spellName      = {CH_SPELL_BLESSING_OF_KINGS}, 
                              partySpellName = CH_SPELL_GREATER_BLESSING_OF_KINGS, 
                              partySpellType = 'BLESSING',
                              classes        = {WARRIOR=0,PALADIN=0,SHAMAN=0,ROGUE=0,HUNTER=0,DRUID=0,PRIEST=0,MAGE=0,WARLOCK=0,PET=0},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PALADIN_BUFF_BOK_EFFECT,
                              buffPriority   = 10,
                              buffEnabled    = false,
                            }, 
               };

CH_SPELL_DATA = { QUICK      = { CH_SPELL_HOLY_LIGHT, CH_SPELL_FLASH_OF_LIGHT
                               },
                  SLOW       = { CH_SPELL_HOLY_LIGHT,
                               },
                  HOT        = { CH_SPELL_HOLY_LIGHT, CH_SPELL_LAY_ON_HANDS,
                               },
                  SHIELD     = { CH_SPELL_HOLY_LIGHT, CH_SPELL_BLESSING_OF_PROTECTION,
                               },
                  COOLDOWN   = { CH_SPELL_HOLY_LIGHT,
                               },
                  HEALUP     = { CH_SPELL_HOLY_LIGHT,
                               },
                  RANGE      = { CH_SPELL_FLASH_OF_LIGHT, CH_SPELL_HOLY_LIGHT,
                               },
                  INSTARANGE = { 
                               },
                };

CH_SPELL_INFO = { 
 [CH_SPELL_HOLY_LIGHT]                    = {type="once", ranks={1,6,14,22,30,38,46,54,60}, checkRank=false, pattern=CH_SPELL_PATTERN_HOLY_LIGHT,     min=1, max=2, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
 [CH_SPELL_FLASH_OF_LIGHT]                = {type="once", ranks={20,26,34,42,50,58},        checkRank=false, pattern=CH_SPELL_PATTERN_FLASH_OF_LIGHT, min=1, max=2, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
 [CH_SPELL_LAY_ON_HANDS]                  = {type="once", ranks={10,30,50},                 checkRank=true,  pattern=nil,                             min=1, max=2, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
 [CH_SPELL_DIVINE_INTERVENTION]           = {type="buff", ranks={30},                       checkRank=false,                                                        duration=180,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=true},
 [CH_SPELL_RIGHTEOUS_FURY]                = {type="buff", ranks={16},                       checkRank=false,                                                        duration=1800, warnTime=180, refreshTime=1200, selfOnly=true,  atFullHealth=true},
 [CH_SPELL_BLESSING_OF_MIGHT]             = {type="buff", ranks={4,12,22,32,42,52,60},      checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_MIGHT]     = {type="buff", ranks={52,60},                    checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_WISDOM]            = {type="buff", ranks={14,24,34,44,54,60},        checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_WISDOM]    = {type="buff", ranks={54,60},                    checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_SALVATION]         = {type="buff", ranks={26},                       checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_SALVATION] = {type="buff", ranks={60},                       checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_SANCTUARY]         = {type="buff", ranks={30,40,50,60},              checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_SANCTUARY] = {type="buff", ranks={60},                       checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_LIGHT]             = {type="buff", ranks={40,50,60},                 checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_LIGHT]     = {type="buff", ranks={60},                       checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_PROTECTION]        = {type="buff", ranks={10,24,38},                 checkRank=true,                                                         duration=6,    warnTime=2,   refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_FREEDOM]           = {type="buff", ranks={18},                       checkRank=true,                                                         duration=10,   warnTime=2,   refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_SACRIFICE]         = {type="buff", ranks={46,54},                    checkRank=true,                                                         duration=30,   warnTime=5,   refreshTime=20,   selfOnly=false, atFullHealth=true},
 [CH_SPELL_BLESSING_OF_KINGS]             = {type="buff", ranks={20},                       checkRank=true,                                                         duration=300,  warnTime=60,  refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_GREATER_BLESSING_OF_KINGS]     = {type="buff", ranks={60},                       checkRank=true,                                                         duration=960,  warnTime=120, refreshTime=240,  selfOnly=false, atFullHealth=true},
 [CH_SPELL_HOLY_SHOCK]                    = {type="spell",ranks={40,48,56},                 checkRank=true,                                                         duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
};

CH_RESURRECT_SPELL = CH_SPELL_REDEMPTION;

end
