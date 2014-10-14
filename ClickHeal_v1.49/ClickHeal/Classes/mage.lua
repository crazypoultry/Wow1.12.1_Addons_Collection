--=============================================================================
-- File:		warlock.lua
-- Author:		rudy
-- Description:		configuration file for the warlock class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'MAGE' ) then

CH_EMERGENCY_SPELLS_ACTIONS = nil;
CH_DefaultEmergencySpells = nil;

CH_DEF_MOUSE_SPELLS = 
  { Friend = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'PLUGIN','BANDAGE'},           CtrlRightButton={'ACTION','ASSIST'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
             },
    Enemy  = {LeftButton={'SPELL',CH_SPELL_FIREBALL},                                                       RightButton={'SPELL',CH_SPELL_FROSTBOLT},
              CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'ACTION','USEWAND'},           CtrlRightButton={'ACTION','ATTACK'},
              AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
             },
    Panic  = {                                             MiddleButton={'ACTION','GRPBUFF'},
             },
    Extra1 = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},                RightButton={'ACTION','CONFIG'},
             },
    Extra2 = {
             },
    Extra3 = {ShiftLeftButton={'SPELL',CH_SPELL_CONFURE_FOOD},                                              ShiftRightButton={'SPELL',CH_SPELL_CONJURE_WATER},
              CtrlLeftButton={'PLUGIN','HEALPOD'},                                                          CtrlRightButton={'PLUGIN','MANAPOD'},
              AltLeftButton={'PLUGIN','FOOD'},             AltMiddleButton={'PLUGIN','FEAST'},              AltRightButton={'PLUGIN','DRINK'},
             },
    Extra4 = {LeftButton={'SPELL',CH_SPELL_FROST_NOVA},                                                     RightButton={'SPELL',CH_SPELL_BLINK},
             },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_MAGE_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_MAGE_EXTRA2_LABEL, cooldownSpellName=nil,
                               },
                      Extra3 = { name=CH_MAGE_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_MAGE_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_FROST_NOVA,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_MAGE_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_MAGE_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_MAGE_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_MAGE_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_MAGE_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = { bAIB     = { displayName    = CH_MAGE_BUFF_AIB_LABEL,
                              spellName      = {CH_SPELL_ARCANE_INTELLECT},
                              partySpellName = CH_SPELL_ARCANE_BRILLIANCE,
                              partySpellType = 'PARTY',
                              classes        = {WARRIOR=0,PALADIN=1,SHAMAN=1,ROGUE=0,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=0},
                              units          = {player=1,pet=0,party=1,partypet=0,raid=1,raidpet=0,target=1},
                              effect         = CH_MAGE_BUFF_AIB_EFFECT,
                              buffPriority   = 1,
                              buffEnabled    = true,
                            }, 
                 bFA      = { displayName    = CH_MAGE_BUFF_FA_LABEL,
                              spellName      = {CH_SPELL_FROST_ARMOR,CH_SPELL_ICE_ARMOR}, 
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_MAGE_BUFF_FA_EFFECT,
                              buffPriority   = 2,
                              buffEnabled    = false,
                            }, 
                 bMA      = { displayName    = CH_MAGE_BUFF_MA_LABEL,
                              spellName      = {CH_SPELL_MAGE_ARMOR}, 
                              classes        = {WARRIOR=-1,PALADIN=-1,SHAMAN=-1,ROGUE=-1,HUNTER=-1,DRUID=-1,PRIEST=-1,MAGE=1,WARLOCK=-1,PET=-1},
                              units          = {player=1,pet=-1,party=-1,partypet=-1,raid=-1,raidpet=-1,target=-1},
                              effect         = CH_MAGE_BUFF_AM_EFFECT,
                              buffPriority   = 3,
                              buffEnabled    = false,
                            }, 
                 bAM      = { displayName    = CH_MAGE_BUFF_AM_LABEL,
                              spellName      = {CH_SPELL_AMPLIFY_MAGIC},
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=0,raidpet=0,target=1},
                              effect         = CH_MAGE_BUFF_AM_EFFECT,
                              buffPriority   = 4,
                              buffEnabled    = false,
                            }, 
                 bDM      = { displayName    = CH_MAGE_BUFF_DM_LABEL,
                              spellName      = {CH_SPELL_DAMPEN_MAGIC},
                              classes        = {WARRIOR=1,PALADIN=1,SHAMAN=1,ROGUE=1,HUNTER=1,DRUID=1,PRIEST=1,MAGE=1,WARLOCK=1,PET=1},
                              units          = {player=1,pet=1,party=1,partypet=1,raid=0,raidpet=0,target=1},
                              effect         = CH_MAGE_BUFF_DM_EFFECT,
                              buffPriority   = 5,
                              buffEnabled    = false,
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
                  COOLDOWN  = { CH_SPELL_FROST_ARMOR,
                              },
                  HEALUP    = { 
                              },
                  RANGE     = { 
                              },
                };

CH_SPELL_INFO = { [CH_SPELL_ARCANE_INTELLECT]  = {type="buff", ranks={1,14,28,42,56},  checkRank=true,  duration=1800, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true},
                  [CH_SPELL_ARCANE_BRILLIANCE] = {type="buff", ranks={56},             checkRank=false, duration=3600, warnTime=180, refreshTime=1200, selfOnly=false, atFullHealth=true},
                  [CH_SPELL_FROST_ARMOR]       = {type="buff", ranks={1,10,20},        checkRank=false, duration=1800, warnTime=120, refreshTime=1200, selfOnly=true,  atFullHealth=true},
                  [CH_SPELL_ICE_ARMOR]         = {type="buff", ranks={30,40,50,60},    checkRank=false, duration=1800, warnTime=120, refreshTime=1200, selfOnly=true,  atFullHealth=true},
                  [CH_SPELL_MAGE_ARMOR]        = {type="buff", ranks={34,46,58},       checkRank=false, duration=1800, warnTime=120, refreshTime=1200, selfOnly=true,  atFullHealth=true},
                  [CH_SPELL_AMPLIFY_MAGIC]     = {type="buff", ranks={18,30,42,54},    checkRank=true,  duration=600,  warnTime=60,  refreshTime=480,  selfOnly=false, atFullHealth=true},
                  [CH_SPELL_DAMPEN_MAGIC]      = {type="buff", ranks={12,24,36,48,60}, checkRank=true,  duration=600,  warnTime=60,  refreshTime=480,  selfOnly=false, atFullHealth=true},
                };

CH_RESURRECT_SPELL = nil;

end
