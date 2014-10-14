--=============================================================================
-- File:		shaman.lua
-- Author:		rudy
-- Description:		configuration file for the shaman class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'SHAMAN' ) then

CH_EMERGENCY_SPELLS_ACTIONS = {'QUICK','SLOW','NONE'};

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
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
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
                                                          MAGE    = {'QUICK'},
                                                          PALADIN = {'QUICK'},
                                                          PRIEST  = {'QUICK'},
                                                          ROGUE   = {'QUICK'},
                                                          SHAMAN  = {'QUICK'},
                                                          WARLOCK = {'QUICK'},
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
                                                                PET     = {}
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
                                                                MAGE    = {'QUICK'},
                                                                PALADIN = {'QUICK'},
                                                                PRIEST  = {'QUICK'},
                                                                ROGUE   = {'QUICK'},
                                                                SHAMAN  = {'QUICK'},
                                                                WARLOCK = {'QUICK'},
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
  { Friend = {LeftButton={'ACTION','QUICK'},               MiddleButton={'ACTION','SHIELD'},       RightButton={'ACTION','HOT'},
              ShiftLeftButton={'ACTION','SLOW'},           ShiftMiddleButton={'ACTION','BUFF'},    ShiftRightButton={'ACTION','DEBUFF'},
              CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'PLUGIN','BANDAGE'},  CtrlRightButton={'ACTION','ASSIST'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                  AltRightButton={'ACTION','MENU'},
             },
    Enemy  = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'ACTION','USEWAND'},  CtrlRightButton={'ACTION','ATTACK'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                  AltRightButton={'ACTION','MENU'},
             },
    Panic  = {LeftButton={'ACTION','PANIC'},               MiddleButton={'ACTION','GRPBUFF'},      RightButton={'ACTION','GRPCURE'},
             },
    Extra1 = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},       RightButton={'ACTION','CONFIG'},
             },
    Extra2 = {
             },
    Extra3 = {LeftButton={'SPELL',CH_SPELL_HEALING_STREAM_TOTEM},                                  RightButton={'SPELL',CH_SPELL_MANA_SPRING_TOTEM},
              CtrlLeftButton={'PLUGIN','HEALPOD'},                                                 CtrlRightButton={'PLUGIN','MANAPOD'},
              AltLeftButton={'PLUGIN','FOOD'},             AltMiddleButton={'PLUGIN','FEAST'},     AltRightButton={'PLUGIN','DRINK'},
             },
    Extra4 = {
             },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_SHAMAN_EXTRA1_LABEL, cooldownSpellName=nil, 
                               },
                      Extra2 = { name=CH_SHAMAN_EXTRA2_LABEL, cooldownSpellName=nil,  
                               },
                      Extra3 = { name=CH_SHAMAN_EXTRA3_LABEL, cooldownSpellName=nil,  
                               },
                      Extra4 = { name=CH_SHAMAN_EXTRA4_LABEL, cooldownSpellName=nil,  
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_SHAMAN_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_SHAMAN_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_SHAMAN_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_SHAMAN_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_SHAMAN_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = { bLS      = { displayName       = CH_SHAMAN_BUFF_LS_LABEL,
                              spellName         = {CH_SPELL_LIGHTNING_SHIELD}, 
                              classes           = {WARRIOR=-1,PALADIN=-1,SHAMAN=1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units             = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect            = CH_SHAMAN_BUFF_LS_EFFECT,
                              buffPriority      = 1,
                              buffEnabled       = true,
                            }, 
                 wRB      = { displayName       = CH_SHAMAN_BUFF_RB_LABEL,
                              spellName         = {CH_SPELL_ROCKBITER_WEAPON}, 
                              classes           = {WARRIOR=-1,PALADIN=-1,SHAMAN=1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units             = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect            = CH_SHAMAN_BUFF_RB_EFFECT,
                              isWeaponBuff      = true,
                              weaponBuffPattern = CH_BUFF_ROCKBITER_PATTERN;
                              buffPriority      = 2,
                              buffEnabled       = true,
                            }, 
                 wFT      = { displayName       = CH_SHAMAN_BUFF_FT_LABEL,
                              spellName         = {CH_SPELL_FLAMETONGUE_WEAPON}, 
                              classes           = {WARRIOR=-1,PALADIN=-1,SHAMAN=1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units             = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect            = CH_SHAMAN_BUFF_FT_EFFECT,
                              isWeaponBuff      = true,
                              weaponBuffPattern = CH_BUFF_FLAMETONGUE_PATTERN;
                              buffPriority      = 3,
                              buffEnabled       = false,
                            }, 
                 wFB      = { displayName       = CH_SHAMAN_BUFF_FB_LABEL,
                              spellName         = {CH_SPELL_FROSTBRAND_WEAPON}, 
                              classes           = {WARRIOR=-1,PALADIN=-1,SHAMAN=1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units             = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect            = CH_SHAMAN_BUFF_FB_EFFECT,
                              isWeaponBuff      = true,
                              weaponBuffPattern = CH_BUFF_FROSTBRAND_PATTERN;
                              buffPriority      = 4,
                              buffEnabled       = false,
                            }, 
                 wWF      = { displayName       = CH_SHAMAN_BUFF_WF_LABEL,
                              spellName         = {CH_SPELL_WINDFURY_WEAPON}, 
                              classes           = {WARRIOR=-1,PALADIN=-1,SHAMAN=1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=-1,PET=-1},
                              units             = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect            = CH_SHAMAN_BUFF_WF_EFFECT,
                              isWeaponBuff      = true,
                              weaponBuffPattern = CH_BUFF_WINDFURY_PATTERN;
                              buffPriority      = 5,
                              buffEnabled       = false,
                            }, 
               };

CH_SPELL_DATA = { QUICK      = { CH_SPELL_HEALING_WAVE, CH_SPELL_LESSER_HEALING_WAVE,
                               },
                  SLOW       = { CH_SPELL_HEALING_WAVE,
                               },
                  HOT        = { CH_SPELL_HEALING_WAVE, CH_SPELL_CHAIN_HEAL,
                               },
                  SHIELD     = { CH_SPELL_HEALING_WAVE, CH_SPELL_NATURES_SWIFTNESS,
                               },
                  COOLDOWN   = { CH_SPELL_HEALING_WAVE,
                               },
                  HEALUP     = { CH_SPELL_HEALING_WAVE,
                               },
                  RANGE      = { CH_SPELL_LESSER_HEALING_WAVE, CH_SPELL_HEALING_WAVE,
                               },
                  INSTARANGE = { 
                               },
                };

CH_SPELL_INFO = { 
  [CH_SPELL_HEALING_WAVE]        = {type="once",  ranks={1,6,12,18,24,32,40,48,56,60}, checkRank=false, pattern=CH_SPELL_PATTERN_HEALING_WAVE,        min=1,   max=2,   duration=nil, warnTime=0,  refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_LESSER_HEALING_WAVE] = {type="once",  ranks={20,28,36,44,52,60},           checkRank=false, pattern=CH_SPELL_PATTERN_LESSER_HEALING_WAVE, min=1,   max=2,   duration=nil, warnTime=0,  refreshTime=0,    selfOnly=false, atFullHealth=false},
  [CH_SPELL_CHAIN_HEAL]          = {type="group", ranks={40,46,54},                    checkRank=false, pattern=nil,                                  min=nil, max=nil, duration=nil, warnTime=0,  refreshTime=0,    selfOnly=false, atFullHealth=true},
  [CH_SPELL_LIGHTNING_SHIELD]    = {type="buff",  ranks={8,16,24,32,40,48,56},         checkRank=false,                                                                 duration=600, warnTime=60, refreshTime=480,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_ROCKBITER_WEAPON]    = {type="wbuff", ranks={1,8,16,24,34,44,54},          checkRank=false,                                                                 duration=300, warnTime=60, refreshTime=240,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_FLAMETONGUE_WEAPON]  = {type="wbuff", ranks={10,18,26,36,46,56},           checkRank=false,                                                                 duration=300, warnTime=60, refreshTime=240,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_FROSTBRAND_WEAPON]   = {type="wbuff", ranks={10,28,38,48,58},              checkRank=false,                                                                 duration=300, warnTime=60, refreshTime=240,  selfOnly=false, atFullHealth=true},
  [CH_SPELL_WINDFURY_WEAPON]     = {type="wbuff", ranks={30,40,50,60},                 checkRank=false,                                                                 duration=300, warnTime=60, refreshTime=240,  selfOnly=false, atFullHealth=true},
};

CH_SPELL_INFO[CH_SPELL_HEALING_WAVE].pattern1 = CH_SPELL_PATTERN_HEALING_WAVE1;
CH_SPELL_INFO[CH_SPELL_LESSER_HEALING_WAVE].pattern1 = CH_SPELL_PATTERN_LESSER_HEALING_WAVE1;

CH_RESURRECT_SPELL = CH_SPELL_ANCESTRAL_SPIRIT;

CH_TOTEMS = { {totem=CH_SPELL_STONESKIN_TOTEM,         element='Earth'},
              {totem=CH_SPELL_EARTHBIND_TOTEM,         element='Earth'},
              {totem=CH_SPELL_STONECLAW_TOTEM,         element='Earth'},
              {totem=CH_SPELL_STRENGTH_OF_EARTH_TOTEM, element='Earth'},
              {totem=CH_SPELL_TREMOR_TOTEM,            element='Earth'},

              {totem=CH_SPELL_FIRE_NOVA_TOTEM,         element='Fire'},
              {totem=CH_SPELL_SEARING_TOTEM,           element='Fire'},
              {totem=CH_SPELL_FROST_RESISTANCE_TOTEM,  element='Fire'},
              {totem=CH_SPELL_MAGMA_TOTEM,             element='Fire'},
              {totem=CH_SPELL_FLAMETONGUE_TOTEM,       element='Fire'},

              {totem=CH_SPELL_POISON_CLEANSING_TOTEM,  element='Water'},
              {totem=CH_SPELL_HEALING_STREAM_TOTEM,    element='Water'},
              {totem=CH_SPELL_MANA_SPRING_TOTEM,       element='Water'},
              {totem=CH_SPELL_DISEASE_CLEANSING_TOTEM, element='Water'},
              {totem=CH_SPELL_FIRE_RESISTANCE_TOTEM,   element='Water'},
              {totem=CH_SPELL_MANA_TIDE_TOTEM,         element='Water'},

              {totem=CH_SPELL_GROUNDING_TOTEM,         element='Air'},
              {totem=CH_SPELL_NATURE_RESISTANCE_TOTEM, element='Air'},
              {totem=CH_SPELL_WINDFURY_TOTEM,          element='Air'},
              {totem=CH_SPELL_SENTRY_TOTEM,            element='Air'},
              {totem=CH_SPELL_WINDWALL_TOTEM,          element='Air'},
              {totem=CH_SPELL_GRACE_OF_AIR_TOTEM,      element='Air'},
              {totem=CH_SPELL_TRANQUIL_AIR_TOTEM,      element='Air'},
            };

end
