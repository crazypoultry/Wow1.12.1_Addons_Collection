--=============================================================================
-- File:		hunter.lua
-- Author:		rudy
-- Description:		configuration file for the hunter class
--============================================================================

local lClass, iClass = UnitClass('player');
if ( iClass == 'HUNTER' ) then

CH_EMERGENCY_SPELLS_ACTIONS = nil;
CH_DefaultEmergencySpells = nil;

CH_DEF_MOUSE_SPELLS = 
  { Friend     = {CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'PLUGIN','BANDAGE'},    CtrlRightButton={'ACTION','ASSIST'},
                  AltLeftButton={'ACTION','TOOLTIP'},                                                    AltRightButton={'ACTION','MENU'},
                 },
    EnemyMELEE = {CtrlLeftButton={'ACTION','TARGET'},                                                    CtrlRightButton={'ACTION','ATTACK'},
                  AltLeftButton={'ACTION','TOOLTIP'},                                                    AltRightButton={'ACTION','MENU'},
                 },
    EnemyRANGE = {LeftButton={'SPELL',CH_SPELL_ARCANE_SHOT},
                  ShiftMiddleButton={'SPELL',CH_SPELL_HUNTERS_MARK},                                     ShiftRightButton={'ACTION','PETATTACK'},
                  CtrlLeftButton={'ACTION','TARGET'},          CtrlMiddleButton={'SPELL','Auto Shot'},   CtrlRightButton={'ACTION','ATTACK'},
                  AltLeftButton={'ACTION','TOOLTIP'},                                                    AltRightButton={'ACTION','MENU'},
                 },
    Panic      = {
                 },
    Extra1     = {LeftButton={'ACTION','CONFIG'},              MiddleButton={'ACTION','CONFIG'},          RightButton={'ACTION','CONFIG'},
                 },
    Extra2     = {LeftButton={'SPELL',CH_SPELL_IMMOLATION_TRAP},                                          RightButton={'SPELL',CH_SPELL_FREEZING_TRAP},
                  ShiftLeftButton={'SPELL',CH_SPELL_EXPLOSIVE_TRAP},                                      ShiftRightButton={'SPELL',CH_SPELL_FROST_TRAP},
                 },
    Extra3     = {LeftButton={'SPELL',CH_SPELL_ASPECT_OF_THE_HAWK},                                       RightButton={'SPELL',CH_SPELL_ASPECT_OF_THE_CHEETAH},
                                                               MiddleButton={'SPELL',CH_SPELL_ASPECT_OF_THE_MONKEY},
                  ShiftLeftButton={'SPELL',CH_SPELL_ASPECT_OF_THE_WILD},                                  ShiftRightButton={'SPELL',CH_SPELL_ASPECT_OF_THE_PACK},
                                                               ShiftMiddleButton={'SPELL',CH_SPELL_ASPECT_OF_THE_BEAST},
                  CtrlLeftButton={'PLUGIN','HEALPOD'},         CtrlMiddleButton={'SPELL',CH_SPELL_FEIGN_DEATH},  CtrlRightButton={'PLUGIN','MANAPOD'},
                  AltLeftButton={'PLUGIN','FOOD'},             AltMiddleButton={'PLUGIN','FEAST'},        AltRightButton={'PLUGIN','DRINK'},
                 },
    Extra4     = {LeftButton={'SPELL',CH_SPELL_MEND_PET},      MiddleButton={'SPELL',CH_SPELL_BESTIAL_WRATH},RightButton={'SPELL',CH_SPELL_INTIMIDATION},
                  ShiftLeftButton={'SPELL',CH_SPELL_CALL_PET}, ShiftMiddleButton={'SPELL',CH_SPELL_REVIVE_PET},ShiftRightButton={'SPELL',CH_SPELL_DISMISS_PET},
                 },
 };

CH_DEF_EXTRA_DATA = { Extra1 = { name=CH_HUNTER_EXTRA1_LABEL, cooldownSpellName=nil,
                               },
                      Extra2 = { name=CH_HUNTER_EXTRA2_LABEL, cooldownSpellName=CH_SPELL_IMMOLATION_TRAP,
                               },
                      Extra3 = { name=CH_HUNTER_EXTRA3_LABEL, cooldownSpellName=nil,
                               },
                      Extra4 = { name=CH_HUNTER_EXTRA4_LABEL, cooldownSpellName=CH_SPELL_INTIMIDATION,
                               },
                    };

CH_ACTION_TYPE_TEXT = { QUICK     = CH_HUNTER_ACTION_TYPE_TEXT_QUICK,
                        HOT       = CH_HUNTER_ACTION_TYPE_TEXT_HOT,
                        SLOW      = CH_HUNTER_ACTION_TYPE_TEXT_SLOW,
                        SHIELD    = CH_HUNTER_ACTION_TYPE_TEXT_SHIELD,
                        BUFF      = CH_ACTION_TYPE_TEXT_BUFF,
                        DEBUFF    = CH_ACTION_TYPE_TEXT_DEBUFF,
                        CONFIG    = CH_ACTION_TYPE_TEXT_CONFIG,
                        TARGET    = CH_ACTION_TYPE_TEXT_TARGET,
                        ASSIST    = CH_ACTION_TYPE_TEXT_ASSIST,
                        ATTACK    = CH_ACTION_TYPE_TEXT_ATTACK,
                        PETATTACK = CH_ACTION_TYPE_TEXT_PETATTACK,
                        USEWAND   = CH_HUNTER_ACTION_TYPE_TEXT_USEWAND,
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
                  COOLDOWN  = {CH_SPELL_TRACK_BEASTS, 
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
