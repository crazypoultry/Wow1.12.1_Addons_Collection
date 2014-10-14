--=============================================================================
-- File:		priest.lua
-- Author:		rudy
-- Description:		configuration file for the priest class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'PRIEST' ) then

CH_EMERGENCY_SPELLS_ACTIONS = {'QUICK','SHIELD','HOT','SLOW','NONE'};

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
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_WOUNDED]  = { DRUID   = {'HOT'},
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
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_FAIR]     = { DRUID   = {'HOT','QUICK'},
                                                          HUNTER  = {'HOT','QUICK'},
                                                          MAGE    = {'SHIELD','HOT','QUICK'},
                                                          PALADIN = {'HOT','QUICK'},
                                                          PRIEST  = {'SHIELD','HOT','QUICK'},
                                                          ROGUE   = {'HOT','QUICK'},
                                                          SHAMAN  = {'HOT','QUICK'},
                                                          WARLOCK = {'SHIELD','HOT','QUICK'},
                                                          WARRIOR = {'HOT','QUICK'},
                                                          PET     = {'HOT','QUICK'}
                                                        };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_POOR]     = { DRUID   = {'SHIELD','QUICK'},
                                                          HUNTER  = {'SHIELD','HOT','QUICK'},
                                                          MAGE    = {'SHIELD','HOT','QUICK'},
                                                          PALADIN = {'HOT','QUICK'},
                                                          PRIEST  = {'SHIELD','HOT','QUICK'},
                                                          ROGUE   = {'SHIELD','HOT','QUICK'},
                                                          SHAMAN  = {'SHIELD','HOT','QUICK'},
                                                          WARLOCK = {'SHIELD','HOT','QUICK'},
                                                          WARRIOR = {'HOT','QUICK'},
                                                          PET     = {'QUICK'}
                                                        };
CH_DefaultEmergencySpells.FULL[CH_EMERGENCY_CRITIC]   = { DRUID   = {'SHIELD','QUICK'},
                                                          HUNTER  = {'SHIELD','QUICK'},
                                                          MAGE    = {'SHIELD','QUICK'},
                                                          PALADIN = {'SHIELD','QUICK'},
                                                          PRIEST  = {'SHIELD','QUICK'},
                                                          ROGUE   = {'SHIELD','QUICK'},
                                                          SHAMAN  = {'SHIELD','QUICK'},
                                                          WARLOCK = {'SHIELD','QUICK'},
                                                          WARRIOR = {'SHIELD','QUICK'},
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
                                                          WARRIOR = {'HOT'},
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
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_CRITIC]  = { DRUID   = {'SHIELD','QUICK'},
                                                          HUNTER  = {'SHIELD','QUICK'},
                                                          MAGE    = {'SHIELD','QUICK'},
                                                          PALADIN = {'SHIELD','QUICK'},
                                                          PRIEST  = {'SHIELD','QUICK'},
                                                          ROGUE   = {'SHIELD','QUICK'},
                                                          SHAMAN  = {'SHIELD','QUICK'},
                                                          WARLOCK = {'SHIELD','QUICK'},
                                                          WARRIOR = {'SHIELD','QUICK'},
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
CH_DefaultEmergencySpells.BATTLEFIELD[CH_EMERGENCY_CRITIC]  = { DRUID   = {'SHIELD','QUICK'},
                                                                HUNTER  = {'SHIELD','QUICK'},
                                                                MAGE    = {'SHIELD','QUICK'},
                                                                PALADIN = {'SHIELD','QUICK'},
                                                                PRIEST  = {'SHIELD','QUICK'},
                                                                ROGUE   = {'SHIELD','QUICK'},
                                                                SHAMAN  = {'SHIELD','QUICK'},
                                                                WARLOCK = {'SHIELD','QUICK'},
                                                                WARRIOR = {'SHIELD','QUICK'},
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
                                                          WARRIOR = {'HOT'},
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
CH_DefaultEmergencySpells.TRASH[CH_EMERGENCY_CRITIC]  = { DRUID   = {'SHIELD','QUICK'},
                                                          HUNTER  = {'SHIELD','QUICK'},
                                                          MAGE    = {'SHIELD','QUICK'},
                                                          PALADIN = {'SHIELD','QUICK'},
                                                          PRIEST  = {'SHIELD','QUICK'},
                                                          ROGUE   = {'SHIELD','QUICK'},
                                                          SHAMAN  = {'SHIELD','QUICK'},
                                                          WARLOCK = {'SHIELD','QUICK'},
                                                          WARRIOR = {'SHIELD','QUICK'},
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
  { Friend = {LeftButton={'ACTION','QUICK'},            MiddleButton={'ACTION','HOT'},                  RightButton={'ACTION','SHIELD'},
              ShiftLeftButton={'ACTION','SLOW'},        ShiftMiddleButton={'ACTION','BUFF'},            ShiftRightButton={'ACTION','DEBUFF'},
              CtrlLeftButton={'ACTION','TARGET'},       CtrlMiddleButton={'PLUGIN','BANDAGE'},          CtrlRightButton={'ACTION','ASSIST'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                       AltRightButton={'ACTION','MENU'},
             },
    Enemy  = {LeftButton={'SPELL',CH_SPELL_SMITE},      MiddleButton={'SPELL',CH_SPELL_SHADOW_WORD_PAIN}, RightButton={'SPELL',CH_SPELL_MIND_FLAY},
              ShiftLeftButton={'SPELL',CH_SPELL_MIND_BLAST},                                            ShiftRightButton={'SPELL',CH_SPELL_MANA_BURN},
                                                       ShiftMiddleButton={'SPELL',CH_SPELL_DEVOURING_PLAGUE}, 
              CtrlLeftButton={'ACTION','TARGET'},       CtrlMiddleButton={'ACTION','USEWAND'},          CtrlRightButton={'ACTION','ATTACK'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                       AltRightButton={'ACTION','MENU'},
             },
    Panic  = {LeftButton={'ACTION','PANIC'},            MiddleButton={'ACTION','GRPBUFF'},              RightButton={'ACTION','GRPCURE'},
             },
    Extra1 = {LeftButton={'ACTION','CONFIG'},           MiddleButton={'ACTION','CONFIG'},               RightButton={'ACTION','CONFIG'},
             },
    Extra2 = {
             },
    Extra3 = {LeftButton={'SPELL',CH_SPELL_PRAYER_OF_HEALING},
              CtrlLeftButton={'PLUGIN','HEALPOD'},                                                      CtrlRightButton={'PLUGIN','MANAPOD'},
              AltLeftButton={'PLUGIN','FOOD'},          AltMiddleButton={'PLUGIN','FEAST'},             AltRightButton={'PLUGIN','DRINK'},
             },
    Extra4 = {LeftButton={'SPELL',CH_SPELL_FADE},                                                       RightButton={'SPELL',CH_SPELL_PSYCHIC_SCREAM},
             },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_PRIEST_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_PRIEST_EXTRA2_LABEL, cooldownSpellName=nil,
                               },
                      Extra3 = { name=CH_PRIEST_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_PRIEST_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_FADE,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_PRIEST_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_PRIEST_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_PRIEST_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_PRIEST_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_PRIEST_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = { bPWF     = { displayName    = CH_PRIEST_BUFF_PWF_LABEL,
                              spellName      = {CH_SPELL_POWER_WORD_FORTITUDE}, 
                              partySpellName = CH_SPELL_PRAYER_OF_FORTITUDE,
                              partySpellType = 'PARTY',
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PRIEST_BUFF_PWF_EFFECT,
                              buffPriority   = 1,
                              buffEnabled    = true,
                            }, 
                 bDS      = { displayName    = CH_PRIEST_BUFF_DS_LABEL,
                              spellName      = {CH_SPELL_DIVINE_SPIRIT}, 
                              partySpellName = CH_SPELL_PRAYER_OF_SPIRIT,
                              partySpellType = 'PARTY',
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PRIEST_BUFF_DS_EFFECT,
                              buffPriority   = 2,
                              buffEnabled    = true,
                            }, 
                 bSP      = { displayName    = CH_PRIEST_BUFF_SP_LABEL,
                              spellName      = {CH_SPELL_SHADOW_PROTECTION}, 
                              partySpellName = CH_SPELL_PRAYER_OF_SHADOW_PROTECTION,
                              partySpellType = 'PARTY',
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PRIEST_BUFF_SP_EFFECT,
                              buffPriority   = 3,
                              buffEnabled    = false,
                            }, 
                 bIF      = { displayName    = CH_PRIEST_BUFF_IF_LABEL,
                              spellName      = {CH_SPELL_INNER_FIRE}, 
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_PRIEST_BUFF_IF_EFFECT,
                              buffPriority   = 4,
                              buffEnabled    = false,
                            }, 
                 bToW     = { displayName    = CH_PRIEST_BUFF_TOW_LABEL,
                              spellName      = {CH_SPELL_TOUCH_OF_WEAKNESS}, 
                              learnRaces     = {Scourge=1},
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_PRIEST_BUFF_TOW_EFFECT,
                              buffPriority   = 5,
                              buffEnabled    = false,
                            }, 
                 bEG      = { displayName    = CH_PRIEST_BUFF_EG_LABEL,
                              spellName      = {CH_SPELL_ELUNES_GRACE}, 
                              learnRaces     = {NightElf=1},
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_PRIEST_BUFF_EG_EFFECT,
                              buffPriority   = 6,
                              buffEnabled    = false,
                            }, 
                 bFW      = { displayName    = CH_PRIEST_BUFF_FW_LABEL,
                              spellName      = {CH_SPELL_FEAR_WARD}, 
                              learnRaces     = {Dwarf=1},
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=1,raidpet=1,target=1},
                              effect         = CH_PRIEST_BUFF_FW_EFFECT,
                              buffPriority   = 7,
                              buffEnabled    = false,
                            }, 
                 bSG      = { displayName    = CH_PRIEST_BUFF_SG_LABEL,
                              spellName      = {CH_SPELL_SHADOWGUARD}, 
                              learnRaces     = {Troll=1},
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_PRIEST_BUFF_SG_EFFECT,
                              buffPriority   = 8,
                              buffEnabled    = false,
                            }, 
               };

CH_SPELL_DATA = { QUICK      = { CH_SPELL_LESSER_HEAL, CH_SPELL_FLASH_HEAL,
                               },
                  SLOW       = { CH_SPELL_LESSER_HEAL, CH_SPELL_HEAL, CH_SPELL_GREATER_HEAL, 
                               },
                  HOT        = { CH_SPELL_LESSER_HEAL, CH_SPELL_RENEW,
                               },
                  SHIELD     = { CH_SPELL_LESSER_HEAL, CH_SPELL_POWER_WORD_SHIELD,
                               },
                  COOLDOWN   = { CH_SPELL_LESSER_HEAL,
                               },
                  HEALUP     = { CH_SPELL_LESSER_HEAL, CH_SPELL_HEAL, CH_SPELL_GREATER_HEAL,
                               },
                  RANGE      = { CH_SPELL_FLASH_HEAL, CH_SPELL_GREATER_HEAL, CH_SPELL_HEAL, CH_SPELL_LESSER_HEAL,
                               },
                  INSTARANGE = { CH_SPELL_RENEW,
                               },
                };

CH_SPELL_INFO = { 
  [CH_SPELL_LESSER_HEAL]          = {type="once",  ranks={1,4,10},                       checkRank=false, pattern=CH_SPELL_PATTERN_LESSER_HEAL,  min=1,   max=2,   duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_HEAL]                 = {type="once",  ranks={16,22,24,34},                  checkRank=false, pattern=CH_SPELL_PATTERN_HEAL,         min=1,   max=2,   duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_GREATER_HEAL]         = {type="once",  ranks={40,46,52,58,60},               checkRank=false, pattern=CH_SPELL_PATTERN_GREATER_HEAL, min=1,   max=2,   duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_FLASH_HEAL]           = {type="once",  ranks={20,26,32,38,44,50,56},         checkRank=false,  pattern=CH_SPELL_PATTERN_FLASH_HEAL,   min=1,   max=2,   duration=nil,  warnTime=0,   refreshTime=0,   selfOnly=false, atFullHealth=false},
  [CH_SPELL_DESPERATE_PRAYER]     = {type="once",  ranks={10,18,26,34,42,50,58},         checkRank=false, pattern=nil,                           min=nil, max=nil, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=true,  atFullHealth=false},
  [CH_SPELL_PRAYER_OF_HEALING]    = {type="group", ranks={30,40,50,60},                  checkRank=false, pattern=nil,                           min=nil, max=nil, duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_RENEW]                = {type="hot",   ranks={8,14,20,26,32,38,44,50,56,60}, checkRank=true,  pattern=CH_SPELL_PATTERN_RENEW,        heal=1,  sec=2,   duration=15,   warnTime=3,   refreshTime=3,    selfOnly=false, atFullHealth=true,},
  [CH_SPELL_POWER_WORD_SHIELD]    = {type="buff",  ranks={6,12,18,24,30,36,42,48,54,60}, checkRank=true,                                                           duration=30,   warnTime=5,   refreshTime=5,    selfOnly=false, atFullHealth=true,},
  [CH_SPELL_POWER_WORD_FORTITUDE] = {type="buff",  ranks={1,12,24,36,48,60},             checkRank=true,                                                           duration=1800, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true,},
  [CH_SPELL_PRAYER_OF_FORTITUDE]  = {type="buff",  ranks={48,60},                        checkRank=false,                                                          duration=3600, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true,},
  [CH_SPELL_DIVINE_SPIRIT]        = {type="buff",  ranks={40,42,54},                     checkRank=true,                                                           duration=1800, warnTime=180, refreshTime=1200,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_PRAYER_OF_SPIRIT]     = {type="buff",  ranks={60},                           checkRank=false,                                                          duration=3600, warnTime=180, refreshTime=1200,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_SHADOW_PROTECTION]    = {type="buff",  ranks={30,42,56},                     checkRank=true,                                                           duration=600,  warnTime=60,  refreshTime=480,   selfOnly=false, atFullHealth=true},
  [CH_SPELL_PRAYER_OF_SHADOW_PROTECTION] = {type="buff", ranks={56},                     checkRank=true,                                                           duration=1200, warnTime=180, refreshTime=900,   selfOnly=false, atFullHealth=true},
  [CH_SPELL_INNER_FIRE]           = {type="buff",  ranks={12,20,30,40,50,60},            checkRank=false,                                                          duration=600,  warnTime=120,  refreshTime=480,  selfOnly=true,  atFullHealth=true},
  [CH_SPELL_TOUCH_OF_WEAKNESS]    = {type="buff",  ranks={10,20,30,40,50,60},            checkRank=false,                                                          duration=600,  warnTime=120,  refreshTime=480,  selfOnly=true,  atFullHealth=true},
  [CH_SPELL_ELUNES_GRACE]         = {type="buff",  ranks={20,30,40,50,60},               checkRank=false,                                                          duration=180,  warnTime=60,  refreshTime=120,  selfOnly=true,  atFullHealth=true,},
  [CH_SPELL_FEAR_WARD]            = {type="buff",  ranks={20},                           checkRank=false,                                                          duration=600,  warnTime=120, refreshTime=480,  selfOnly=false, atFullHealth=true,},
  [CH_SPELL_SHADOWGUARD]          = {type="buff",  ranks={20,28,36,44,52,60},            checkRank=false,                                                          duration=600,  warnTime=120, refreshTime=480,  selfOnly=true,  atFullHealth=true,},
  [CH_SPELL_DISPEL_MAGIC]         = {type="spell", ranks={18,36},                        checkRank=true,                                                           duration=nil,  warnTime=0,   refreshTime=0,    selfOnly=true,  atFullHealth=true,},
};

CH_RESURRECT_SPELL = CH_SPELL_RESURRECTION;

end
