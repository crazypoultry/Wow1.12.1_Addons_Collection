HEALBOT_VERSION = "v1.126b4";

-------------
-- ENGLISH --
-------------

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "Druid";
HEALBOT_HUNTER  = "Hunter";
HEALBOT_MAGE    = "Mage";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Priest";
HEALBOT_ROGUE   = "Rogue";
HEALBOT_SHAMAN  = "Shaman";
HEALBOT_WARLOCK = "Warlock";
HEALBOT_WARRIOR = "Warrior";

HEALBOT_BANDAGES = "Bandages";

HEALBOT_LINEN_BANDAGE     = "Linen Bandage";
HEALBOT_WOOL_BANDAGE      = "Wool Bandage";
HEALBOT_SILK_BANDAGE      = "Silk Bandage";
HEALBOT_MAGEWEAVE_BANDAGE = "Mageweave Bandage";
HEALBOT_RUNECLOTH_BANDAGE = "Runecloth Bandage";

HEALBOT_HEAVY_LINEN_BANDAGE     = "Heavy Linen Bandage";
HEALBOT_HEAVY_WOOL_BANDAGE      = "Heavy Wool Bandage";
HEALBOT_HEAVY_SILK_BANDAGE      = "Heavy Silk Bandage";
HEALBOT_HEAVY_MAGEWEAVE_BANDAGE = "Heavy Mageweave Bandage";
HEALBOT_HEAVY_RUNECLOTH_BANDAGE = "Heavy Runecloth Bandage";

HEALBOT_HEALING_POTIONS         = "Healing Potions";

HEALBOT_MINOR_HEALING_POTION    = "Minor Healing Potion";
HEALBOT_LESSER_HEALING_POTION   = "Lesser Healing Potion";
HEALBOT_HEALING_POTION          = "Healing Potion";
HEALBOT_GREATER_HEALING_POTION  = "Greater Healing Potion";
HEALBOT_SUPERIOR_HEALING_POTION = "Superior Healing Potion";
HEALBOT_MAJOR_HEALING_POTION    = "Major Healing Potion";

HEALBOT_HEALTHSTONES         = "Healthstones";

HEALBOT_MINOR_HEALTHSTONE    = "Minor Healthstone";
HEALBOT_LESSER_HEALTHSTONE   = "Lesser Healthstone";
HEALBOT_HEALTHSTONE          = "Healthstone";
HEALBOT_GREATER_HEALTHSTONE  = "Greater Healthstone";
HEALBOT_MAJOR_HEALTHSTONE    = "Major Healthstone";

HEALBOT_FLASH_HEAL          = "Flash Heal";
HEALBOT_FLASH_OF_LIGHT      = "Flash of Light";
HEALBOT_HOLY_SHOCK	    = "Holy Shock";
HEALBOT_GREATER_HEAL        = "Greater Heal";
HEALBOT_HEALING_TOUCH       = "Healing Touch";
HEALBOT_HEAL                = "Heal";
HEALBOT_HEALING_WAVE        = "Healing Wave";
HEALBOT_HOLY_LIGHT          = "Holy Light";
HEALBOT_LESSER_HEAL         = "Lesser Heal";
HEALBOT_LESSER_HEALING_WAVE = "Lesser Healing Wave";
HEALBOT_MEND_PET            = "Mend Pet";
HEALBOT_POWER_WORD_SHIELD   = "Power Word: Shield";
HEALBOT_REGROWTH            = "Regrowth";
HEALBOT_RENEW               = "Renew";
HEALBOT_REJUVENATION        = "Rejuvenation";
HEALBOT_PRAYER_OF_HEALING   = "Prayer of Healing";
HEALBOT_CHAIN_HEAL          = "Chain Heal";

HEALBOT_POWER_WORD_FORTITUDE  = "Power Word: Fortitude";
HEALBOT_DIVINE_SPIRIT         = "Divine Spirit";
HEALBOT_MARK_OF_THE_WILD      = "Mark of the Wild";
HEALBOT_THORNS                = "Thorns";
HEALBOT_BLESSING_OF_SALVATION = "Blessing of Salvation";

HEALBOT_RESURRECTION       = "Resurrection";
HEALBOT_REDEMPTION         = "Redemption";
HEALBOT_REBIRTH            = "Rebirth";
HEALBOT_ANCESTRALSPIRIT    = "Ancestral Spirit";

HEALBOT_PURIFY             = "Purify";
HEALBOT_CLEANSE            = "Cleanse";
HEALBOT_CURE_POISON        = "Cure Poison";
HEALBOT_REMOVE_CURSE       = "Remove Curse";
HEALBOT_ABOLISH_POISON     = "Abolish Poison";
HEALBOT_CURE_DISEASE       = "Cure Disease";
HEALBOT_ABOLISH_DISEASE    = "Abolish Disease";
HEALBOT_DISPEL_MAGIC       = "Dispel Magic";
HEALBOT_DISEASE            = "Disease";
HEALBOT_MAGIC              = "Magic";
HEALBOT_CURSE              = "Curse";
HEALBOT_POISON             = "Poison";
HEALBOT_DISEASE_en         = "Disease";  -- Do NOT localize this value.
HEALBOT_MAGIC_en           = "Magic";  -- Do NOT localize this value.
HEALBOT_CURSE_en           = "Curse";  -- Do NOT localize this value.
HEALBOT_POISON_en          = "Poison";  -- Do NOT localize this value.

HEALBOT_RANK_1              = "(Rank 1)";
HEALBOT_RANK_2              = "(Rank 2)";
HEALBOT_RANK_3              = "(Rank 3)";
HEALBOT_RANK_4              = "(Rank 4)";
HEALBOT_RANK_5              = "(Rank 5)";
HEALBOT_RANK_6              = "(Rank 6)";
HEALBOT_RANK_7              = "(Rank 7)";
HEALBOT_RANK_8              = "(Rank 8)";
HEALBOT_RANK_9              = "(Rank 9)";
HEALBOT_RANK_10             = "(Rank 10)";
HEALBOT_RANK_11             = "(Rank 11)";

HEALBOT_LIBRARY_INCHEAL    = "Increases healing done by spells and effects by up to (%d+)%.";
HEALBOT_LIBRARY_INCDAMHEAL = "Increases damage and healing done by magical spells and effects by up to (%d+)%.";

HB_BONUSSCANNER_NAMES = {	
	HEAL 		= "Healing",
};

HB_BONUSSCANNER_PREFIX_EQUIP = "Equip: ";
HB_BONUSSCANNER_PREFIX_SET = "Set: ";

HB_BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
	{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = {"HEAL", "DMG"} },
};

HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["Healing Spells"] 		= "HEAL",
	["Increases Healing"] 	= "HEAL",
	["Healing and Spell Damage"] = {"HEAL", "DMG"},
	["Damage and Healing Spells"] = {"HEAL", "DMG"},
	["Spell Damage and Healing"] = {"HEAL", "DMG"},	
};	

HB_BONUSSCANNER_PATTERNS_OTHER = {
	{ pattern = "Zandalar Signet of Mojo", effect = {"DMG", "HEAL"}, value = 18 },
	{ pattern = "Zandalar Signet of Serenity", effect = "HEAL", value = 33 },
	
	{ pattern = "Minor Wizard Oil", effect = {"DMG", "HEAL"}, value = 8 },
	{ pattern = "Lesser Wizard Oil", effect = {"DMG", "HEAL"}, value = 16 },
	{ pattern = "Wizard Oil", effect = {"DMG", "HEAL"}, value = 24 },
	{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

	{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
};

HEALBOT_BUFF_FIRST_AID           = "Interface\\Icons\\Spell_Holy_Heal";
HEALBOT_BUFF_POWER_WORD_SHIELD   = "Interface\\Icons\\Spell_Holy_PowerWordShield";
HEALBOT_BUFF_REJUVENATION        = "Interface\\Icons\\Spell_Nature_Rejuvenation";
HEALBOT_BUFF_REGROWTH            = "Interface\\Icons\\Spell_Nature_ResistNature";
HEALBOT_BUFF_RENEW               = "Interface\\Icons\\Spell_Holy_Renew";
HEALBOT_DEBUFF_WEAKENED_SOUL     = "Interface\\Icons\\Spell_Holy_AshesToAshes";
HEALBOT_DEBUFF_RECENTLY_BANDAGED = "Interface\\Icons\\INV_Misc_Bandage_08";


HB_SPELL_PATTERN_LESSER_HEAL         = "Heal your target for (%d+) to (%d+)";
HB_SPELL_PATTERN_HEAL                = "Heal your target for (%d+) to (%d+)";
HB_SPELL_PATTERN_GREATER_HEAL        = "A slow casting spell that heals a single target for (%d+) to (%d+)";
HB_SPELL_PATTERN_FLASH_HEAL          = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_RENEW               = "Heals the target of (%d+) to (%d+) damage over (%d+) sec";
HB_SPELL_PATTERN_RENEW1              = "Heals the target of (%d+) damage over (%d+) sec";
HB_SPELL_PATTERN_RENEW2              = "Not needed for en";
HB_SPELL_PATTERN_RENEW3              = "Not needed for en";
HB_SPELL_PATTERN_SHIELD              = "absorbing (%d+) damage.  Lasts (%d+) sec.";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_REGROWTH            = "Heals a friendly target for (%d+) to (%d+) and another (%d+) over (%d+) sec";
HB_SPELL_PATTERN_REGROWTH1           = "Heals a friendly target for (%d+) to (%d+) and another (%d+) to (%d+) over (%d+) sec";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_HEALING_WAVE        = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Heals a friendly target for (%d+) to (%d+)";
HB_SPELL_PATTERN_REJUVENATION        = "Heals the target for (%d+) over (%d+) sec";
HB_SPELL_PATTERN_REJUVENATION1       = "Heals the target for (%d+) to (%d+) over (%d+) sec";
HB_SPELL_PATTERN_MEND_PET            = "Heals your pet (%d+) health every second while you focus.  Lasts (%d+) sec";

HB_TOOLTIP_MANA                    = "^(%d+) Mana$";
HB_TOOLTIP_RANGE                   = "(%d+) yd range";
HB_TOOLTIP_INSTANT_CAST            = "Instant cast";
HB_TOOLTIP_CAST_TIME               = "(%d+.?%d*) sec cast";
HB_TOOLTIP_CHANNELED               = "Channeled";
HB_HASLEFTRAID                     = "^([^%s]+) has left the raid group$";
HB_HASLEFTPARTY                    = "^([^%s]+) leaves the party$";
HB_YOULEAVETHEGROUP                = "You leave the group."
HB_YOULEAVETHERAID                 = "You have left the raid group"


-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " loaded.";

HEALBOT_CASTINGSPELLONYOU  = "Casting %s on you ...";
HEALBOT_CASTINGSPELLONUNIT = "Casting %s on %s ...";
HEALBOT_ABORTEDSPELLONUNIT = "... aborted %s on %s";

HEALBOT_ACTION_TITLE      = "HealBot";
HEALBOT_ACTION_OPTIONS    = "Options";
HEALBOT_ACTION_ABORT      = "Abort";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "Defaults";
HEALBOT_OPTIONS_CLOSE         = "Close";
HEALBOT_OPTIONS_TAB_GENERAL   = "General";
HEALBOT_OPTIONS_TAB_SPELLS    = "Spells";
HEALBOT_OPTIONS_TAB_HEALING   = "Healing";
HEALBOT_OPTIONS_TAB_CDC       = "Cure";
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
HEALBOT_OPTIONS_TAB_TIPS      = "Tips";

HEALBOT_OPTIONS_PANEL_TEXT    = "Healing panel options"
HEALBOT_OPTIONS_BARALPHA      = "Bar opacity";
HEALBOT_OPTIONS_BARALPHAINHEAL= "Incoming heals opacity";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Lock position";
HEALBOT_OPTIONS_GROWUPWARDS   = "Grow upwards";
HEALBOT_OPTIONS_AUTOSHOW      = "Close automatically";
HEALBOT_OPTIONS_PANELSOUNDS   = "Play sound on open";
--HEALBOT_OPTIONS_ALERTSECONDS  = "Death countdown timer";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Hide options button";
HEALBOT_OPTIONS_QUALITYRANGE  = "Exact 27yard range check in instances";
--HEALBOT_OPTIONS_INTEGRATECTRA = "Integrate CTRA";
HEALBOT_OPTIONS_TOGGLEALTUSE  = "Toggle Alt-key";
HEALBOT_OPTIONS_PROTECTPVP    = "Avoid accidental PvP flagging";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Chat Options";

HEALBOT_OPTIONS_SKINTEXT      = "Use skin"
HEALBOT_SKINS_STD             = "Standard"
HEALBOT_OPTIONS_SKINTEXTURE   = "Texture"
HEALBOT_OPTIONS_SKINHEIGHT    = "Height"
HEALBOT_OPTIONS_SKINWIDTH     = "Width"
HEALBOT_OPTIONS_SKINNUMCOLS   = "No. columns"
HEALBOT_OPTIONS_SKINBRSPACE   = "Row spacer"
HEALBOT_OPTIONS_SKINBCSPACE   = "Col spacer"
HEALBOT_OPTIONS_EXTRASORT     = "Sort extra bars by"
HEALBOT_SORTBY_NAME           = "Name"
HEALBOT_SORTBY_CLASS          = "Class"
HEALBOT_SORTBY_GROUP          = "Group"
HEALBOT_SORTBY_MAXHEALTH      = "Max health"
HEALBOT_OPTIONS_DELSKIN       = "Delete"
HEALBOT_OPTIONS_NEWSKINTEXT   = "New skin"
HEALBOT_OPTIONS_SAVESKIN      = "Save"
HEALBOT_OPTIONS_SKINBARS      = "Bar options"
HEALBOT_OPTIONS_SKINPANEL     = "Panel colours"
HEALBOT_SKIN_ENTEXT           = "Enabled"
HEALBOT_SKIN_DISTEXT          = "Disabled"
HEALBOT_SKIN_DEBTEXT          = "Debuff"
HEALBOT_SKIN_BACKTEXT         = "Background"
HEALBOT_SKIN_BORDERTEXT       = "Border"
HEALBOT_OPTIONS_HIDEABORT     = "Hide abort button"
HEALBOT_OPTIONS_SKINFHEIGHT   = "Font Size"
HEALBOT_OPTIONS_ABORTSIZE     = "Abort size"
HEALBOT_OPTIONS_BARALPHADIS   = "Disabled opacity"
HEALBOT_OPTIONS_SHOWHEADERS   = "Show headers"

HEALBOT_OPTIONS_ITEMS  = "Items";
HEALBOT_OPTIONS_SPELLS = "Spells";

HEALBOT_OPTIONS_COMBOCLASS    = "Key combos for";
HEALBOT_OPTIONS_CLICK         = "Click";
HEALBOT_OPTIONS_SHIFT         = "Shift+click:";
HEALBOT_OPTIONS_CTRL          = "Ctrl+click:";
HEALBOT_OPTIONS_SHIFTCTRL     = "Shift+Ctrl+click:";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Enable unwounded targets";

HEALBOT_OPTIONS_CASTNOTIFY1   = "No messages";
HEALBOT_OPTIONS_CASTNOTIFY2   = "Notify self";
HEALBOT_OPTIONS_CASTNOTIFY3   = "Notify target";
HEALBOT_OPTIONS_CASTNOTIFY4   = "Notify party";
HEALBOT_OPTIONS_CASTNOTIFY5   = "Notify raid";
HEALBOT_OPTIONS_TARGETWHISPER = "Whisper target when healing";

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Healing buttons for:";

HEALBOT_OPTIONS_CDCBUTTONS    = "Curing buttons";
HEALBOT_OPTIONS_CDCLEFT       = "Alt+Left";
HEALBOT_OPTIONS_CDCRIGHT      = "Alt+Right";
HEALBOT_OPTIONS_CDCBARS       = "Healthbar colours";
HEALBOT_OPTIONS_CDCCLASS      = "Monitor classes";
HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff warnings";
HEALBOT_OPTIONS_CDC           = "Cure/Dispel/Cleanse for";
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Display warning on debuff";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Play sound on debuff";
HEALBOT_OPTIONS_SOUND1        = "Sound 1"
HEALBOT_OPTIONS_SOUND2        = "Sound 2"
HEALBOT_OPTIONS_SOUND3        = "Sound 3"

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Healing bars";
HEALBOT_OPTIONS_EMERGFILTER   = "Show extra bars for";

HEALBOT_OPTIONS_GROUPHEALS    = "Group";
HEALBOT_OPTIONS_TANKHEALS     = "Main tanks";
HEALBOT_OPTIONS_TARGETHEALS   = "Targets";
HEALBOT_OPTIONS_EMERGENCYHEALS= "Extra";
HEALBOT_OPTIONS_HEALLEVEL     = "Healing Level";
HEALBOT_OPTIONS_ALERTLEVEL    = "Alert Level";
HEALBOT_OPTIONS_OVERHEAL      = "Show Abort button when overhealing"
HEALBOT_OPTIONS_SORTHEALTH    = "Health";
HEALBOT_OPTIONS_SORTPERCENT   = "Percent";
HEALBOT_OPTIONS_SORTSURVIVAL  = "Survival";
HEALBOT_OPTIONS_EMERGFCLASS   = "Configure classes for";
HEALBOT_OPTIONS_COMBOBUTTON   = "Button";
HEALBOT_OPTIONS_BUTTONLEFT    = "Left";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "Middle";
HEALBOT_OPTIONS_BUTTONRIGHT   = "Right";
HEALBOT_OPTIONS_BUTTON4       = "Button4";
HEALBOT_OPTIONS_BUTTON5       = "Button5";

BINDING_HEADER_HEALBOT  = "HealBot";
BINDING_NAME_TOGGLEMAIN = "Toggle main panel";
BINDING_NAME_HEALPLAYER = "Heal player";
BINDING_NAME_HEALPET    = "Heal pet";
BINDING_NAME_HEALPARTY1 = "Heal party1";
BINDING_NAME_HEALPARTY2 = "Heal party2";
BINDING_NAME_HEALPARTY3 = "Heal party3";
BINDING_NAME_HEALPARTY4 = "Heal party4";
BINDING_NAME_HEALTARGET = "Heal target";

HEALBOT_OPTIONS_PROFILE    = "Set Profile:";
HEALBOT_OPTIONS_ProfilePvP = "PvP";
HEALBOT_OPTIONS_ProfilePvE = "PvE";

HEALBOT_CLASSES_ALL     = "All classes";
HEALBOT_CLASSES_MELEE   = "Melee";
HEALBOT_CLASSES_RANGES  = "Ranged";
HEALBOT_CLASSES_HEALERS = "Healers";
HEALBOT_CLASSES_CUSTOM  = "Custom";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Show tooltips";
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Show detailed spell information";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Show target information";
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Show instant cast recommendation";
HEALBOT_TOOLTIP_POSDEFAULT      = "Default location";
HEALBOT_TOOLTIP_POSLEFT         = "Left of Healbot";
HEALBOT_TOOLTIP_POSRIGHT        = "Right of Healbot";
HEALBOT_TOOLTIP_POSABOVE        = "Above Healbot";
HEALBOT_TOOLTIP_POSBELOW        = "Below Healbot";
HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Instant Cast Recommendation";
HEALBOT_TOOLTIP_NONE            = "none available";
HEALBOT_TOOLTIP_ITEMBONUS       = "Item bonuses";
HEALBOT_TOOLTIP_ACTUALBONUS     = "Actual bonus is";
HEALBOT_TOOLTIP_SHIELD          = "Ward";
HEALBOT_WORDS_OVER              = "over";
HEALBOT_WORDS_SEC               = "sec";
HEALBOT_WORDS_TO                = "to";
HEALBOT_WORDS_CAST              = "Cast";
HEALBOT_WORDS_FOR               = "for";

HEALBOT_WORDS_NONE              = "None";
HEALBOT_OPTIONS_ALT             = "Alt+click";
HEALBOT_DISABLED_TARGET         = "Target";
HEALBOT_OPTIONS_ENABLEDBARS     = "Enabled Bars";
HEALBOT_OPTIONS_DISABLEDBARS    = "Disabled Bars when out of combat";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "Show class on bar";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "Show health on bar";
HEALBOT_OPTIONS_BARHEALTH1      = "as delta";
HEALBOT_OPTIONS_BARHEALTH2      = "as percentage";
HEALBOT_OPTIONS_TIPTEXT         = "Tooltip information";
HEALBOT_OPTIONS_BARINFOTEXT     = "Bar information";
HEALBOT_OPTIONS_POSTOOLTIP      = "Position tooltip";
HEALBOT_OPTIONS_SHOWCLASSNAME   = "Include name";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Show text in class colour";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR2 = "Overrides Enabled and Debuff on the skin tab";
HEALBOT_OPTIONS_EMERGFILTERGROUPS   = "Include groups";

HEALBOT_ONE   = "1";
HEALBOT_TWO   = "2";
HEALBOT_THREE = "3";
HEALBOT_FOUR  = "4";
HEALBOT_FIVE  = "5";
HEALBOT_SIX   = "6";
HEALBOT_SEVEN = "7";
HEALBOT_EIGHT = "8";
