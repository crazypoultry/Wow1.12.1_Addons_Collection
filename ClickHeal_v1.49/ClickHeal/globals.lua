-- ==========================================================================================================================================================
-- Global definitions for ClickHeal. This file is loaded right in the beginning, before everything else
-- ==========================================================================================================================================================

-- different emergency / hurt status
CH_EMERGENCY_NONE    = 1;
CH_EMERGENCY_WOUNDED = 2
CH_EMERGENCY_FAIR    = 3;
CH_EMERGENCY_POOR    = 4;
CH_EMERGENCY_CRITIC  = 5;

-- initialization of hurt boundaries for the classes
CH_EMERGENCY_STATE = {};
CH_EMERGENCY_STATE[CH_EMERGENCY_NONE]    = {};
CH_EMERGENCY_STATE[CH_EMERGENCY_WOUNDED] = {};
CH_EMERGENCY_STATE[CH_EMERGENCY_FAIR]    = {};
CH_EMERGENCY_STATE[CH_EMERGENCY_POOR]    = {};
CH_EMERGENCY_STATE[CH_EMERGENCY_CRITIC]  = {}

-- in combat
CH_EMERGENCY_STATE[CH_EMERGENCY_NONE].Y     = { DRUID=100,HUNTER=100,MAGE=100,PALADIN=100,PRIEST=100,ROGUE=100,SHAMAN=100,WARLOCK=100,WARRIOR=100,PET=100 };
CH_EMERGENCY_STATE[CH_EMERGENCY_WOUNDED].Y  = { DRUID= 99,HUNTER= 99,MAGE= 99,PALADIN= 99,PRIEST= 99,ROGUE= 99,SHAMAN= 99,WARLOCK= 99,WARRIOR= 99,PET= 99 };
CH_EMERGENCY_STATE[CH_EMERGENCY_FAIR].Y     = { DRUID= 70,HUNTER= 70,MAGE= 80,PALADIN= 70,PRIEST= 80,ROGUE= 70,SHAMAN= 70,WARLOCK= 80,WARRIOR= 70,PET= 50 };
CH_EMERGENCY_STATE[CH_EMERGENCY_POOR].Y     = { DRUID= 50,HUNTER= 50,MAGE= 60,PALADIN= 50,PRIEST= 60,ROGUE= 50,SHAMAN= 50,WARLOCK= 60,WARRIOR= 50,PET= 10 };
CH_EMERGENCY_STATE[CH_EMERGENCY_CRITIC].Y   = { DRUID= 30,HUNTER= 30,MAGE= 40,PALADIN= 30,PRIEST= 40,ROGUE= 30,SHAMAN= 30,WARLOCK= 40,WARRIOR= 30,PET=  0 };

-- no combat
CH_EMERGENCY_STATE[CH_EMERGENCY_NONE].N    = { DRUID=100,HUNTER=100,MAGE=100,PALADIN=100,PRIEST=100,ROGUE=100,SHAMAN=100,WARLOCK=100,WARRIOR=100,PET=100 };
CH_EMERGENCY_STATE[CH_EMERGENCY_WOUNDED].N = { DRUID= 40,HUNTER= 40,MAGE= 50,PALADIN= 40,PRIEST= 50,ROGUE= 40,SHAMAN= 50,WARLOCK= 40,WARRIOR= 50,PET= 75 };
CH_EMERGENCY_STATE[CH_EMERGENCY_FAIR].N    = { DRUID=  0,HUNTER=  0,MAGE=  0,PALADIN=  0,PRIEST=  0,ROGUE=  0,SHAMAN=  0,WARLOCK=  0,WARRIOR=  0,PET=  0 };
CH_EMERGENCY_STATE[CH_EMERGENCY_POOR].N    = { DRUID=  0,HUNTER=  0,MAGE=  0,PALADIN=  0,PRIEST=  0,ROGUE=  0,SHAMAN=  0,WARLOCK=  0,WARRIOR=  0,PET=  0 };
CH_EMERGENCY_STATE[CH_EMERGENCY_CRITIC].N  = { DRUID=  0,HUNTER=  0,MAGE=  0,PALADIN=  0,PRIEST=  0,ROGUE=  0,SHAMAN=  0,WARLOCK=  0,WARRIOR=  0,PET=  0 }

-- what spells to cast on what class when how hurt (emergency)
CH_EMERGENCY_SPELLS = nil;		-- definitions in class file

-- which spells not to cast when player is at full health (definition in class files)
CH_NOT_AT_FULL_HEALTH = {};

-- spell name of the resurrect spell (definiton in class files)
CH_RESURRECT_SPELL = nil;

-- all available player classes (with and without pet)
CH_ALL_CLASSES = {'DRUID','HUNTER','MAGE','PALADIN','PRIEST','ROGUE','SHAMAN','WARLOCK','WARRIOR'};
CH_ALL_CLASSES_PET = {'DRUID','HUNTER','MAGE','PALADIN','PRIEST','ROGUE','SHAMAN','WARLOCK','WARRIOR','PET'};

-- colored labels for targets and other units
CH_DEFAULT_NAME_COLOR = { playertarget    = 'WHITE',
                          party1target    = 'PINK',
                          party2target    = 'SEAGREEN',
                          party3target    = 'SKYBLUE',
                          party4target    = 'LIGHTORANGE',
                          pettarget       = 'WHITE',
                          partypet1target = 'WHITE',
                          partypet2target = 'WHITE',
                          partypet3target = 'WHITE',
                          partypet4target = 'WHITE',
                          SHIELD          = 'VIOLET',
                          SELECTED        = 'YELLOW',
                          FRIEND          = 'WHITE',
                          DEFAULT         = 'WHITE',
                          MTT             = 'WHITE',
                        };

-- base mouse buttons
CH_MOUSE_BUTTONS = {'LeftButton','MiddleButton','RightButton','Button4','Button5'};

-- all assignable mousebuttons
CH_MOUSE_BUTTONS_ALL = {'LeftButton','MiddleButton','RightButton','Button4','Button5',
                        'ShiftLeftButton','ShiftMiddleButton','ShiftRightButton','ShiftButton4','ShiftButton5',
                        'CtrlLeftButton','CtrlMiddleButton','CtrlRightButton','CtrlButton4','CtrlButton5',
                        'AltLeftButton','AltMiddleButton','AltRightButton','AltButton4','AltButton5',
                        'ShiftCtrlLeftButton','ShiftCtrlMiddleButton','ShiftCtrlRightButton','ShiftCtrlButton4','ShiftCtrlButton5',
                        'ShiftAltLeftButton','ShiftAltMiddleButton','ShiftAltRightButton','ShiftAltButton4','ShiftAltButton5',
                        'CtrlAltLeftButton','CtrlAltMiddleButton','CtrlAltRightButton','CtrlAltButton4','CtrlAltButton5',
                        'ShiftCtrlAltLeftButton','ShiftCtrlAltMiddleButton','ShiftCtrlAltRightButton','ShiftCtrlAltButton4','ShiftCtrlAltButton5'
                       };

-- how long it takes from casting a spell on a unit until it is displayed on the unit (buff/debuff)
CH_UNIT_BUFF_VISIBLE_DELAY = 0.5;

-- various class specific settings (NOTE: More settings in globals_post.lua!!!)
CH_CLASS_INFO = { DRUID   = {canUseWand=false,isHealer=true, },
                  HUNTER  = {canUseWand=false,isHealer=false,},
                  MAGE    = {canUseWand=true, isHealer=false,},
                  PALADIN = {canUseWand=false,isHealer=true, },
                  PRIEST  = {canUseWand=true, isHealer=true, },
                  ROGUE   = {canUseWand=false,isHealer=false,},
                  SHAMAN  = {canUseWand=false,isHealer=true, },
                  WARLOCK = {canUseWand=true, isHealer=false,},
                  WARRIOR = {canUseWand=false,isHealer=false,},
                  PET     = {canUseWand=false,isHealer=false,},
                  UNKNOWN = {canUseWand=false,isHealer=false,},
                };

-- named colors
-- 00 = 0
-- 33 = 0.2
-- 66 = 0.4
-- 80 = 0.5
-- 99 = 0.6
-- CC = 0.8
-- FF = 1
CH_COLOR = { BLACK          = {name='Black',           r=0.00,g=0.00,b=0.00,html='000000'},
             DARKRED        = {name='Dark Red',        r=0.50,g=0.00,b=0.00,html='800000'},
             RED            = {name='Red',             r=1.00,g=0.00,b=0.00,html='FF0000'},
             PINK           = {name='Pink',            r=1.00,g=0.00,b=1.00,html='FF00FF'},
             ROSE           = {name='Rose',            r=1.00,g=0.60,b=0.80,html='FF99CC'},
             BROWN          = {name='Brown',           r=0.60,g=0.20,b=0.00,html='993300'},
             ORANGE         = {name='Orange',          r=1.00,g=0.40,b=0.00,html='FF6600'},
             LIGHTORANGE    = {name='Light Orange',    r=1.00,g=0.60,b=0.00,html='FF9900'},
             GOLD           = {name='Gold',            r=1.00,g=0.80,b=0.00,html='FFCC00'},
             TAN            = {name='Tan',             r=1.00,g=0.80,b=0.60,html='FFCC99'},
             OLIVEGREEN     = {name='Olive Green',     r=0.20,g=0.20,b=0.00,html='333300'},
             DARKYELLOW     = {name='Dark Yellow',     r=0.50,g=0.50,b=0.00,html='808000'},
             LIME           = {name='Lime',            r=0.60,g=0.80,b=0.00,html='99CC00'},
             YELLOW         = {name='Yellow',          r=1.00,g=1.00,b=0.00,html='FFFF00'},
             LIGHTYELLOW    = {name='Light Yellow',    r=1.00,g=1.00,b=0.60,html='FFFF99'},
             DARKGREEN      = {name='Dark Green',      r=0.00,g=0.20,b=0.00,html='003300'},
             GREEN          = {name='Green',           r=0.00,g=0.50,b=0.00,html='008000'},
             SEAGREEN       = {name='Sea Green',       r=0.20,g=0.60,b=0.40,html='339966'},
             BRIGHTGREEN    = {name='Bright Green',    r=0.00,g=1.00,b=0.00,html='00FF00'},
             LIGHTGREEN     = {name='Light Green',     r=0.80,g=1.00,b=0.80,html='CCFFCC'},
             DARKTEAL       = {name='Dark Teal',       r=0.00,g=0.20,b=0.40,html='003366'},
             TEAL           = {name='Teal',            r=0.00,g=0.50,b=0.50,html='008080'},
             AQUA           = {name='Aqua',            r=0.20,g=0.80,b=0.80,html='33CCCC'},
             TURQUOISE      = {name='Turquoise',       r=0.00,g=1.00,b=1.00,html='00FFFF'},
             LIGHTTURQUOISE = {name='Light Turquoise', r=0.80,g=1.00,b=1.00,html='CCFFFF'},
             DARKBLUE       = {name='Dark Blue',       r=0.00,g=0.00,b=0.50,html='000080'},
             BLUE           = {name='Blue',            r=0.00,g=0.00,b=1.00,html='0000FF'},
             LIGHTBLUE      = {name='Light Blue',      r=0.20,g=0.40,b=1.00,html='3366FF'},
             SKYBLUE        = {name='Sky Blue',        r=0.00,g=0.80,b=1.00,html='00CCFF'},
             PALEBLUE       = {name='Pale Blue',       r=0.60,g=0.80,b=1.00,html='99CCFF'},
             INDIGO         = {name='Indigo',          r=0.20,g=0.20,b=0.60,html='333399'},
             BLUEGRAY       = {name='Blue-Gray',       r=0.40,g=0.40,b=0.60,html='666699'},
             VIOLET         = {name='Violet',          r=0.50,g=0.00,b=0.50,html='800080'},
             PLUM           = {name='Plum',            r=0.60,g=0.20,b=0.40,html='993366'},
             LAVENDER       = {name='Lavender',        r=0.80,g=0.60,b=1.00,html='CC99FF'},
             GRAY80         = {name='Gray 80%',        r=0.20,g=0.20,b=0.20,html='333333'},
             GRAY50         = {name='Gray 50%',        r=0.50,g=0.50,b=0.50,html='808080'},
             GRAY40         = {name='Gray 40%',        r=0.60,g=0.60,b=0.60,html='969696'},
             GRAY25         = {name='Gray 25%',        r=0.75,g=0.75,b=0.75,html='C0C0C0'},
             WHITE          = {name='White',           r=1.00,g=1.00,b=1.00,html='FFFFFF'},

             WOWTEXTNORMAL    = {name='WoWTextNormal',      r=1.00,g=0.82,b=0.00,html='FFD100'},
             WOWTEXTHIGHLIGHT = {name='WoWTextHightlight',  r=1.00,g=1.00,b=1.00,html='FFFFFF'},
            };

CH_COLOR_GROUP = { [1] = {'BLACK', 'DARKRED', 'RED', 'PINK', 'ROSE',},
                   [2] = {'BROWN', 'ORANGE', 'LIGHTORANGE', 'GOLD', 'TAN',},
                   [3] = {'OLIVEGREEN', 'DARKYELLOW', 'LIME', 'YELLOW', 'LIGHTYELLOW',},
                   [4] = {'DARKGREEN', 'GREEN', 'SEAGREEN', 'BRIGHTGREEN', 'LIGHTGREEN',},
                   [5] = {'DARKTEAL', 'TEAL', 'AQUA', 'TURQUOISE', 'LIGHTTURQUOISE',},
                   [6] = {'DARKBLUE', 'BLUE', 'LIGHTBLUE', 'SKYBLUE', 'PALEBLUE',},
                   [7] = {'INDIGO', 'BLUEGRAY', 'VIOLET', 'PLUM', 'LAVENDER',},
                   [8] = {'GRAY80', 'GRAY50', 'GRAY40', 'GRAY25', 'WHITE',},
                 };

-- Needy Lists
CH_NEEDY_LIST_TYPES = {'HEAL','BUFF','CURE','DEAD'};

-- the debug levels
CH_DEBUG_NONE = 1;
CH_DEBUG_EMERG = 2;
CH_DEBUG_ALERT = 3
CH_DEBUG_CRIT = 4;
CH_DEBUG_ERR = 5;
CH_DEBUG_WARNING = 6;
CH_DEBUG_NOTICE = 7;
CH_DEBUG_INFO = 8;
CH_DEBUG_DEBUG = 9;
