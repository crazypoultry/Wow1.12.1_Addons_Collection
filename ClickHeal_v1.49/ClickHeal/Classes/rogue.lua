--=============================================================================
-- File:		warlock.lua
-- Author:		rudy
-- Description:		configuration file for the warlock class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'ROGUE' ) then

CH_EMERGENCY_SPELLS_ACTIONS = nil;
CH_DefaultEmergencySpells = nil;

CH_DEF_MOUSE_SPELLS = 
  { Friend       = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'PLUGIN','BANDAGE'},           CtrlRightButton={'ACTION','ASSIST'},
                    AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
                   },
    EnemyMELEE   = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'ACTION','USEWAND'},           CtrlRightButton={'ACTION','ATTACK'},
                    AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
                   },
    EnemySTEALTH = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'ACTION','USEWAND'},           CtrlRightButton={'ACTION','ATTACK'},
                    AltLeftButton={'ACTION','TOOLTIP'},                                                           AltRightButton={'ACTION','MENU'},
                   },
    Panic        = {
                   },
    Extra1       = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},                RightButton={'ACTION','CONFIG'},
                   },
    Extra2       = {
                   },
    Extra3       = {
                   },
    Extra4       = {
                   },
  };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_ROGUE_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_ROGUE_EXTRA2_LABEL, cooldownSpellName=nil,
                               },
                      Extra3 = { name=CH_ROGUE_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_ROGUE_EXTRA4_LABEL, cooldownSpellName=nil,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_ROGUE_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_ROGUE_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_ROGUE_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_ROGUE_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_ROGUE_ACTION_TYPE_TEXT_USEWAND,
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
CH_BUFF_DATA = {};

CH_SPELL_DATA = { QUICK =     { 
                              },
                  SLOW      = { 
                              },
                  HOT       = {
                              },
                  SHIELD    = {
                              },
                  COOLDOWN  = {
                              },
                  HEALUP    = { 
                              },
                  RANGE     = { 
                              },
                };

CH_SPELL_INFO = {
                };

CH_RESURRECT_SPELL = nil;

end
