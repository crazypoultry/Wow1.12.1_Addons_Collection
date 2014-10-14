--=============================================================================
-- File:		warlock.lua
-- Author:		rudy
-- Description:		configuration file for the warlock class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'WARLOCK' ) then

CH_EMERGENCY_SPELLS_ACTIONS = nil;
CH_DefaultEmergencySpells = nil;

CH_DEF_MOUSE_SPELLS = 
  { Friend = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'PLUGIN','BANDAGE'},           CtrlRightButton={'ACTION','ASSIST'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
             },
    Enemy  = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'ACTION','USEWAND'},           CtrlRightButton={'ACTION','ATTACK'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
             },
    Panic  = {                                             MiddleButton={'ACTION','GRPBUFF'},
             },
    Extra1 = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},                RightButton={'ACTION','CONFIG'},
             },
    Extra2 = {ShiftLeftButton={'SPELL',CH_SPELL_SUMMON_IMP},                                                ShiftRightButton={'SPELL',CH_SPELL_SUMMON_SUCCUBUS},
                                                           ShiftMiddleButton={'SPELL',CH_SPELL_SUMMON_VOIDWALKER},
              CtrlLeftButton={'SPELL',CH_SPELL_SUMMON_FELHUNTER},                                           CtrlRightButton={'SPELL',CH_SPELL_RITUAL_OF_SUMMONING},
                                                           CtrlMiddleButton={'SPELL',CH_SPELL_EYE_OF_KILROGG},  
             },
    Extra3 = {CtrlLeftButton={'PLUGIN','HEALPOD'},                                                          CtrlRightButton={'PLUGIN','MANAPOD'},
              AltLeftButton={'PLUGIN','FOOD'},             AltMiddleButton={'PLUGIN','FEAST'},              AltRightButton={'PLUGIN','DRINK'},
             },
    Extra4 = {LeftButton={'SPELL',CH_SPELL_HOWL_OF_TERROR},MiddleButton={'PETSPELL',CH_PETSPELL_SACRIFICE},
             },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_WARLOCK_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_WARLOCK_EXTRA2_LABEL, cooldownSpellName=nil,
                               },
                      Extra3 = { name=CH_WARLOCK_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_WARLOCK_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_HOWL_OF_TERROR,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_WARLOCK_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_WARLOCK_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_WARLOCK_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_WARLOCK_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_WARLOCK_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = { bDSk     = { displayName  = CH_WARLOCK_BUFF_DSK_LABEL,
                              spellName    = {CH_SPELL_DEMON_SKIN,CH_SPELL_DEMON_ARMOR}, 
                              classes      = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=-1,WARLOCK=1,PET=-1},
                              units        = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect       = CH_WARLOCK_BUFF_DSK_EFFECT,
                              buffPriority = 1,
                              buffEnabled  = true,
                            }, 
                 bUB      = { displayName  = CH_WARLOCK_BUFF_UB_LABEL,
                              spellName    = {CH_SPELL_UNENDING_BREATH}, 
                              classes      = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=0},
                              units        = {player=1,pet=0,party=1,partypet=0,raid=0,raidpet=0,target=1},
                              effect       = CH_WARLOCK_BUFF_UB_EFFECT,
                              buffPriority = 2,
                              buffEnabled  = false,
                            }, 
                 bDIW     = { displayName  = CH_WARLOCK_BUFF_DIW_LABEL,
                              spellName    = {CH_SPELL_DETECT_LESSER_INVISIBILITY,CH_SPELL_DETECT_INVISIBILITY,CH_SPELL_DETECT_GREATER_INVISIBILITY},
                              classes      = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units        = {player=1,pet=1,party=1,partypet=1,raid=0,raidpet=0,target=1},
                              effect       = CH_WARLOCK_BUFF_DIW_EFFECT,
                              buffPriority = 3,
                              buffEnabled  = false,
                            }, 
               };

CH_SPELL_DATA = { QUICK =     { 
                              },
                  SLOW      = { 
                              },
                  HOT       = {
                              },
                  SHIELD    = {
                              },
                  COOLDOWN  = { CH_SPELL_DEMON_SKIN,
                              },
                  HEALUP    = { 
                              },
                  RANGE     = { 
                              },
                };

CH_SPELL_INFO = { [CH_SPELL_DEMON_SKIN]                  = {type="buff",  ranks={1,10},           checkRank=false, duration=1800, warnTime=120, refreshTime=1200, selfOnly=true,  atFullHealth=true},
                  [CH_SPELL_DEMON_ARMOR]                 = {type="buff",  ranks={20,30,40,50,60}, checkRank=false, duration=1800, warnTime=120, refreshTime=1200, selfOnly=true,  atFullHealth=true},
                  [CH_SPELL_UNENDING_BREATH]             = {type="buff",  ranks={16},             checkRank=false, duration=600,  warnTime=120, refreshTime=480,  selfOnly=false, atFullHealth=true},
                  [CH_SPELL_DETECT_LESSER_INVISIBILITY]  = {type="buff",  ranks={26},             checkRank=false, duration=600,  warnTime=60,  refreshTime=480,  selfOnly=false, atFullHealth=true},
                  [CH_SPELL_DETECT_INVISIBILITY]         = {type="buff",  ranks={38},             checkRank=false, duration=600,  warnTime=60,  refreshTime=480,  selfOnly=false, atFullHealth=true},
                  [CH_SPELL_DETECT_GREATER_INVISIBILITY] = {type="buff",  ranks={50},             checkRank=false, duration=600,  warnTime=60,  refreshTime=480,  selfOnly=false, atFullHealth=true},
                };

CH_RESURRECT_SPELL = nil;

end
