-------------------------------------------------------------------------------
-- All the gameplay constants for the buff spells that can be cast
-------------------------------------------------------------------------------
FFY_TYPE_NORMAL         = 1;
FFY_TYPE_BLESSING       = 2;
FFY_TYPE_POISON         = 4;
FFY_TYPE_ITEM           = 8;

FFY_TYPE_PARTYBLESSING  = 16;
FFY_TYPE_SELF           = 32;
FFY_TYPE_GROUP          = 64;
FFY_TYPE_RAIDCLASS      = 128;
FFY_TYPE_RISKY          = 256;
FFY_TYPE_CASTERSONLY    = 512;


FFY_SPELL_DATA = {
    [FFY_CLASS_PRIEST] = {
        [FFY_SPELL_PRYR_FORTITUDE] = {
            shortcut =  { "prayer", "group fort", "group fortitude", "group stam", "group stamina",
                "pri\195\168re", "robustesse groupe", "endu groupe", "endurance groupe" },
            behavior = FFY_TYPE_GROUP,
            levels = { 48, 60 },
            manacost = { 2600, 3400 },
            duration = { 3600.0 },
        },
        [FFY_SPELL_FORTITUDE] = {
            shortcut =  { "fort", "fortitude", "stam", "stamina",
                "robustesse", "endu", "endurance" },
            behavior = FFY_TYPE_NORMAL,
            levels = { 1, 12, 24, 36, 48, 60 },
            manacost = { 60, 155, 400, 745, 1170, 1695 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_PRYR_SHADOWPROT] = {
            shortcut = { "group shadow",
                "group ombre" },
            behavior = FFY_TYPE_GROUP,
            levels = { 60 },
            manacost = { 1170 },
            duration = { 1200.0 },
        },
        [FFY_SPELL_SHADOWPROT] = {
            shortcut =  { "shadow",
                "ombre" },
            behavior = FFY_TYPE_NORMAL,
            levels = { 30, 42, 56 },
            manacost = { 250, 450, 650 },
            duration = { 600.0 },
        },
        [FFY_SPELL_PRYR_SPIRIT] = {
            shortcut = { "group spirit",
                "group esprit" },
            behavior = FFY_TYPE_GROUP,
            levels = { 60 },
            manacost = { 1746 },
            duration = { 3600.0 },
        },
        [FFY_SPELL_DIVINESPIRIT] = {
            shortcut =  { "spirit",
                "esprit" },
            behavior = FFY_TYPE_CASTERSONLY,
            levels = { 30, 40, 50, 60 },
            manacost = { 285, 420, 785, 970 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_INNERFIRE] = {
            shortcut =  { "inner",
                "feu" },
            behavior = FFY_TYPE_SELF,
            levels = { 12, 20, 30, 40, 50, 60 },
            manacost = { 20, 45, 75, 115, 165, 225 },
            duration = { 600.0 },
        },
        [FFY_SPELL_ELUNESGRACE] = {
            shortcut =  { "elune",
                "grace" },
            behavior = FFY_TYPE_SELF,
            levels = { 20,30,40,50,60 } ,
            manacost = { 150, 230, 350, 465, 575 },
            duration = { 180.0 },
        },
        [FFY_SPELL_SHADOWGUARD] = {
            shortcut =  { "guard",
                "gardien ombre" },
            behavior = FFY_TYPE_SELF,
            levels = { 20, 28, 36, 44, 52, 60 } ,
            manacost = { 50, 85, 120, 160, 200, 250 },
            duration = { 600.0 },
        },
    },
    [FFY_CLASS_DRUID] = {
        [FFY_SPELL_GIFTWILD] = {
            shortcut =  { "gift",
                "don" },
            behavior = FFY_TYPE_GROUP,
            levels = { 50, 60 },
            manacost = { 900, 1200 },
            duration = { 3600.0 },
        },
        [FFY_SPELL_MARKWILD] = {
            shortcut =  { "mark",
                "marque" },
            behavior = FFY_TYPE_NORMAL,
            levels = { 1, 10, 20, 30, 40, 50, 60 },
            manacost = { 20, 50, 100, 160, 240, 340, 445 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_THORNS] = {
            shortcut =  { "thorns",
                "epines" },
            behavior = FFY_TYPE_NORMAL,
            levels = { 6, 14, 24, 34, 44, 54 },
            manacost = { 35, 60, 105, 170, 240, 320 },
            duration = { 600.0 },
        },
    },
    [FFY_CLASS_PALADIN] = {
        [FFY_BLESSING_KINGS] = {
            shortcut =  { "kings",
                "rois" },
            behavior = FFY_TYPE_BLESSING,
            levels = { 40 },
            manacost = { 75 },
            duration = { 300.0 },
        },
        [FFY_BLESSING_SANCTUARY] = {
            shortcut =  { "sanctuary", "sanct",
                "sanctuaire" },
            behavior = FFY_TYPE_BLESSING,
            levels = { 20, 30, 40, 50, 60 },
            manacost = { 60, 85, 110, 135 },
            duration = { 300.0 },
        },
        [FFY_BLESSING_MIGHT] = {
            shortcut =  { "might",
                "puissance" },
            behavior = FFY_TYPE_BLESSING,
            levels = { 4, 12, 22, 32, 42, 52 },
            manacost = { 20, 30, 45, 60, 85, 110 },
            duration = { 300.0 },
        },
        [FFY_BLESSING_WISDOM] = {
            shortcut =  { "wisdom",
                "sagesse" },
            behavior = FFY_TYPE_BLESSING,
            levels = { 14, 24, 34, 44, 54 },
            manacost = { 30, 45, 65, 90, 115 },
            duration = { 300.0 },
        },
        [FFY_BLESSING_SALVATION] = {
            shortcut =  { "salvation", "salv",
                "salut", },
            behavior = FFY_TYPE_PARTYBLESSING,
            levels = { 26 },
            manacost = { 400 },
            duration = { 300.0 },
        },
        [FFY_BLESSING_LIGHT] = {
            shortcut =  { "light",
                "lumiere", "lumi\195\168re" },
            behavior = FFY_TYPE_BLESSING,
            levels = { 40, 50, 60 },
            manacost = { 85, 110, 135 },
            duration = { 300.0 },
        },
    },
    [FFY_CLASS_MAGE] = {
        [FFY_SPELL_ARCANEBRILLIANCE] = {
            shortcut =  { "brilliance",
                "illumination" },
            behavior = FFY_TYPE_GROUP,
            levels = { 56 },
            manacost = { 3400 },
            duration = { 3600.0 },
        },
        [FFY_SPELL_ARCANEINT] = {
            shortcut =  { "arcane",
                "int\195\169", "intelligence" },
            behavior = FFY_TYPE_CASTERSONLY,
            levels = { 1, 14, 28, 42, 56 },
            manacost = { 60, 185, 520, 945, 1510 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_AMPLIFYMAGIC] = {
            shortcut =  { "amplify",
                "amplifier" },
            behavior = FFY_TYPE_RISKY,
            levels = { 18, 30, 42, 54 },
            manacost = { 150, 250, 350, 450 },
            duration = { 600.0 },
        },
        [FFY_SPELL_DAMPENMAGIC] = {
            shortcut =  { "dampen",
                "att\195\169nuer", "attenuer" },
            behavior = FFY_TYPE_RISKY,
            levels = { 12, 24, 36, 48, 60 },
            manacost = { 100, 200, 300, 400, 500 },
            duration = { 600.0 },
        },
        [FFY_SPELL_FROSTARMOR] = {
            shortcut =  { "frost",
                "froid", "givre" },
            behavior = FFY_TYPE_SELF,
            levels = { 1, 10, 20 },
            manacost = { 60, 110, 170 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_ICEARMOR] = {
            shortcut =  { "ice",
                "glace" },
            behavior = FFY_TYPE_SELF,
            levels = { 30, 40, 50, 60 },
            manacost = { 240, 320, 410, 500 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_MAGEARMOR] = {
            shortcut =  { "mage",
                "armure mage" },
            behavior = FFY_TYPE_SELF,
            levels = { 34, 46, 58 },
            manacost = { 270, 380, 490 },
            duration = { 1800.0 },
        },
    },
    [FFY_CLASS_WARLOCK] = {
        [FFY_SPELL_DEMONSKIN] = {
            shortcut =  { "skin",
                "peau", "peau demon", "demon" },
            behavior = FFY_TYPE_SELF,
            levels = { 1, 10 },
            manacost = { 50, 120 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_DEMONARMOR] = {
            shortcut =  { "demon", "armor",
                "demoniaque", "armure demoniaque" },
            behavior = FFY_TYPE_SELF,
            levels = { 20, 30, 40, 50, 60 },
            manacost = { 275, 520, 800, 1150, 1580 },
            duration = { 1800.0 },
        },
        [FFY_SPELL_BREATH] = {
            shortcut =  { "breath", "waterbreathing", "water",
                "respiration", "eau" },
            behavior = FFY_TYPE_NORMAL,
            levels = { 16, },
            manacost = { 50, },
            duration = { 600.0 },
        },
    },
    [FFY_CLASS_WARRIOR] = {
        [FFY_SPELL_BATTLESHOUT] = {
            shortcut =  { "shout" },
            behavior = FFY_TYPE_SELF,
            levels = { 1, 12, 22, 32, 42, 52, 60 },
            manacost = { 10, 10, 10, 10, 10, 10, 10 },
            duration = { 120.0 },
        },
    },
}


FFY_WEAPONBUFF_DATA = {
    [1] = {
        text = FFY_ITEM_NONE,
        type = FFY_TYPE_ITEM,
    },
    [2] = {
        text = FFY_POISON_CRIPPLING,
        type = FFY_TYPE_POISON,
    },
    [3] = {
        text = FFY_POISON_DEADLY,
        type = FFY_TYPE_POISON,
    },
    [4] = {
        text = FFY_POISON_INSTANT,
        type = FFY_TYPE_POISON,
    },
    [5] = {
        text = FFY_ITEM_MANAOIL,
        type = FFY_TYPE_ITEM,
    },
    [6] = {
        text = FFY_POISON_MIND,
        type = FFY_TYPE_POISON,
    },
    [7] = {
        text = FFY_ITEM_SHARPENING,
        type = FFY_TYPE_ITEM,
    },
    [8] = {
        text = FFY_ITEM_WEIGHTSTONE,
        type = FFY_TYPE_ITEM,
    },
    [9] = {
        text = FFY_ITEM_WIZARDOIL,
        type = FFY_TYPE_ITEM,
    },
    [10] = {
        text = FFY_POISON_WOUND,
        type = FFY_TYPE_POISON,
    },
}
