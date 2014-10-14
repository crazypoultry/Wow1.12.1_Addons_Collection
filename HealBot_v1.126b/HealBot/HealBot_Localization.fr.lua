------------
-- FRENCH --
------------

-- à = \195\160
-- â = \195\162
-- é = \195\169
-- ê = \195\170
-- ï = \195\175
-- ô = \195\180


if (GetLocale() == "frFR") then

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "Druide";
HEALBOT_HUNTER  = "Chasseur";
HEALBOT_MAGE    = "Magier";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Pr\195\170tre";
HEALBOT_ROGUE   = "Voleur";
HEALBOT_SHAMAN  = "Chaman";
HEALBOT_WARLOCK = "D\195\169moniste";
HEALBOT_WARRIOR = "Guerrier";

HEALBOT_BANDAGES                = "Bandages";

HEALBOT_LINEN_BANDAGE           = "Bandage en lin";
HEALBOT_WOOL_BANDAGE            = "Bandage en laine";
HEALBOT_SILK_BANDAGE            = "Bandage en soie";
HEALBOT_MAGEWEAVE_BANDAGE       = "Bandage en tissu de mage";
HEALBOT_RUNECLOTH_BANDAGE       = "Bandage en \195\169toffe runique";

HEALBOT_HEAVY_LINEN_BANDAGE     = "Bandage en lin \195\169pais";
HEALBOT_HEAVY_WOOL_BANDAGE      = "Bandage en laine \195\169pais";
HEALBOT_HEAVY_SILK_BANDAGE      = "Bandage en soie \195\169pais";
HEALBOT_HEAVY_MAGEWEAVE_BANDAGE = "Bandage en tissu de mage \195\169pais";
HEALBOT_HEAVY_RUNECLOTH_BANDAGE = "Bandage en \195\169toffe runique \195\169pais";

HEALBOT_HEALING_POTIONS         = "Potions de soins";

HEALBOT_MINOR_HEALING_POTION    = "Potion de soins mineure";
HEALBOT_LESSER_HEALING_POTION   = "Potion de soins inf\195\169rieure";
HEALBOT_HEALING_POTION          = "Potion de soins";
HEALBOT_GREATER_HEALING_POTION  = "Potion de soins sup\195\169rieure";
HEALBOT_SUPERIOR_HEALING_POTION = "Potion de soins excellente";
HEALBOT_MAJOR_HEALING_POTION    = "Potion de Soins majeure";

HEALBOT_HEALTHSTONES         = "Pierres de soins";

HEALBOT_MINOR_HEALTHSTONE    = "Pierre de soins mineure";
HEALBOT_LESSER_HEALTHSTONE   = "Pierre de soins inf\195\169rieure";
HEALBOT_HEALTHSTONE          = "Pierre de soins";
HEALBOT_GREATER_HEALTHSTONE  = "Pierre de soins sup\195\169rieure";
HEALBOT_MAJOR_HEALTHSTONE    = "Pierre de soins majeure";

HEALBOT_FLASH_HEAL          = "Soins rapides";
HEALBOT_FLASH_OF_LIGHT      = "Eclair lumineux";
HEALBOT_HOLY_SHOCK			= "Holy Shock";
HEALBOT_GREATER_HEAL        = "Soins sup\195\169rieurs";
HEALBOT_HEALING_TOUCH       = "Toucher gu\195\169risseur";
HEALBOT_HEAL                = "Soins";
HEALBOT_HEALING_WAVE        = "Vague de soins";
HEALBOT_HOLY_LIGHT          = "Lumi\195\168re sacr\195\169e";
HEALBOT_LESSER_HEAL         = "Soins inf\195\169rieurs";
HEALBOT_LESSER_HEALING_WAVE = "Vague de soins mineurs";
HEALBOT_MEND_PET            = "Soigner un Familier";
HEALBOT_POWER_WORD_SHIELD   = "Mot de pouvoir : Bouclier"; 
HEALBOT_REGROWTH            = "R\195\169tablissement";
HEALBOT_RENEW               = "R\195\169novation";
HEALBOT_REJUVENATION        = "R\195\169cup\195\169ration";
HEALBOT_PRAYER_OF_HEALING   = "Pri\195\168re de soins";
HEALBOT_CHAIN_HEAL          = "Salve de gu\195\169rison";

HEALBOT_POWER_WORD_FORTITUDE  = "Mot de pouvoir : Robustesse";
HEALBOT_DIVINE_SPIRIT         = "Esprit divin";
HEALBOT_MARK_OF_THE_WILD      = "Marque du fauve";
HEALBOT_THORNS                = "Epines";
HEALBOT_BLESSING_OF_SALVATION = "B\195\169n\195\169diction de salut";

HEALBOT_RESURRECTION       = "R\195\169surrection";
HEALBOT_REDEMPTION         = "R\195\169demption";
HEALBOT_REBIRTH            = "Renaissance";
HEALBOT_ANCESTRALSPIRIT    = "Esprit Ancestral";
    
HEALBOT_PURIFY             = "Purification";
HEALBOT_CLEANSE            = "Epuration";
HEALBOT_CURE_POISON        = "Gu\195\169rison du poison";
HEALBOT_REMOVE_CURSE       = "D\195\169livrance de la mal\195\169diction";
HEALBOT_ABOLISH_POISON     = "Abolir le poison";
HEALBOT_CURE_DISEASE       = "Gu\195\169rison des maladies";
HEALBOT_ABOLISH_DISEASE    = "Abolir maladie";
HEALBOT_DISPEL_MAGIC       = "Dissipation de la magie";
HEALBOT_DISEASE            = "Maladie";
HEALBOT_MAGIC              = "Magie";
HEALBOT_CURSE              = "Mal\195\169diction";
HEALBOT_POISON             = "Poison";

HEALBOT_RANK_1              = "(Rang 1)";
HEALBOT_RANK_2              = "(Rang 2)";
HEALBOT_RANK_3              = "(Rang 3)";
HEALBOT_RANK_4              = "(Rang 4)";
HEALBOT_RANK_5              = "(Rang 5)";
HEALBOT_RANK_6              = "(Rang 6)";
HEALBOT_RANK_7              = "(Rang 7)";
HEALBOT_RANK_8              = "(Rang 8)";
HEALBOT_RANK_9              = "(Rang 9)";
HEALBOT_RANK_10             = "(Rang 10)";
HEALBOT_RANK_11             = "(Rang 11)";

HEALBOT_LIBRARY_INCHEAL    = "Increases healing done by spells and effects by up to (%d+)%.";  -- ***************    needs French translation    ***************
HEALBOT_LIBRARY_INCDAMHEAL = "Increases damage and healing done by magical spells and effects by up to (%d+)%.";  -- ***************    needs French translation    ***************

HB_BONUSSCANNER_NAMES = {	
	HEAL 		= "Soins",
};

HB_BONUSSCANNER_PREFIX_EQUIP = "Equip\195\169 : ";
HB_BONUSSCANNER_PREFIX_SET = "Complet : ";

HB_BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "Augmente les effets des sorts de soins de (%d+)% au maximum.", effect = "HEAL" },
	{ pattern = "Augmente les soins prodigu\195\169s par les sorts et effets de (%d+)% au maximum.", effect = "HEAL"},
	{ pattern = "Augmente les d\195\169g\195\162ts et les soins prodigu\195\169s par les sortsfalseles effets magiques de (%d+)% au maximum.", effect = "HEAL" },
	{ pattern = "Augmente les d\195\169g\195\162ts et les soins produits par les sorts et effets magiques de (%d+)% au maximum.", effect = {"HEAL", "DMG" }},
};


HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["Sorts de Soins"] = "HEAL",
	["D\195\169g\195\162ts et soins "] = {"HEAL", "DMG"},
};

HB_SPELL_PATTERN_LESSER_HEAL         = "Soigne la cible de (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_HEAL                = "Soigne la cible de (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_GREATER_HEAL        = "Une longue incantation qui rend (%d+) \195\160 (%d+) points de vie \195\160 une cible unique";
HB_SPELL_PATTERN_FLASH_HEAL          = "Rend (%d+) \195\160 (%d+) points de vie";  
HB_SPELL_PATTERN_RENEW               = "Rend (%d+) \195\160 (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_RENEW1              = "Rend (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_REGROWTH            = "Soigne une cible amie pour (%d+) \195\160 (%d+) puis pour (%d+) points suppl.+mentaires pendant (%d+) sec";
HB_SPELL_PATTERN_REGROWTH1           = "Soigne une cible amie pour (%d+) \195\160 (%d+) puis pour (%d+) \195\160 (%d+) points suppl.+mentaires pendant (%d+) sec";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_HEALING_WAVE        = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Rend (%d+) \195\160 (%d+) points de vie";
HB_SPELL_PATTERN_REJUVENATION        = "Rend (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_REJUVENATION1       = "Rend (%d+) \195\160 (%d+) points de vie \195\160 la cible en (%d+) sec";
HB_SPELL_PATTERN_SHIELD              = "absorbe (%d+) points de d\195\169g\195\162ts. Dure (%d+) sec";
HB_SPELL_PATTERN_MEND_PET            = "Soigne votre compagnon de (%d+) points de vie chaques secondes que vous le ciblez. Dure (%d+) sec"

HB_TOOLTIP_MANA                      = "^Mana : (%d+)$";
HB_TOOLTIP_INSTANT_CAST              = 'Incantation imm\195\169diate';
HB_TOOLTIP_CAST_TIME                 = '(%d+.?%d*) sec';

HB_TOOLTIP_RANGE                     = "de (%d+) m"
HB_TOOLTIP_CHANNELED                 = "Focaliser"
HB_HASLEFTRAID                       = "^([^%s]+) a quitt\195\131\194\169 le groupe de raid$";
HB_HASLEFTPARTY                      = "^([^%s]+) has left the party$";  -- ***************    needs French translation    ***************
HB_YOULEAVETHEGROUP                  = "You leave the group"  -- ***************    needs translation    ***************
HB_YOULEAVETHERAID                   = "You have left the raid group"  -- ***************    needs translation    ***************

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " chargement.";

HEALBOT_CASTINGSPELLONYOU  = "Lance %s sur vous ...";
HEALBOT_CASTINGSPELLONUNIT = "Lance %s sur %s ...";
HEALBOT_ABORTEDSPELLONUNIT = "... arrete %s sur %s";

HEALBOT_ACTION_TITLE      = "HealBot";
HEALBOT_ACTION_OPTIONS    = "Options";
HEALBOT_ACTION_ABORT      = "Annule";


HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "Defaut";
HEALBOT_OPTIONS_CLOSE         = "Fermer";
HEALBOT_OPTIONS_TAB_GENERAL   = "General";
HEALBOT_OPTIONS_TAB_SPELLS    = "Utilisation";
HEALBOT_OPTIONS_TAB_MISC      = "Divers";
HEALBOT_OPTIONS_TAB_HEALING   = "Soins";
HEALBOT_OPTIONS_TAB_CDC       = "Cure";
HEALBOT_OPTIONS_TAB_SKIN      = "Skin";
HEALBOT_OPTIONS_TAB_TIPS      = "Tips";


HEALBOT_OPTIONS_PANEL_TEXT    = "Panneau d'option de soin:"
HEALBOT_OPTIONS_ACTIONLOCKED  = "Bloquer la position";
HEALBOT_OPTIONS_GROWUPWARDS   = "Monter";
HEALBOT_OPTIONS_AUTOSHOW      = "Ouvrir automatiquement";
HEALBOT_OPTIONS_PANELSOUNDS   = "Son a l'ouverture";
HEALBOT_OPTIONS_ALERTSECONDS  = "Death countdown timer";
HEALBOT_OPTIONS_SHOWTOOLTIP   = "Montre tooltip pour les soins";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Cache le boutton d'option";
HEALBOT_OPTIONS_QUALITYRANGE  = "Exact 27yard range check in instances";
HEALBOT_OPTIONS_INTEGRATECTRA = "Intregrer CTRA";
HEALBOT_OPTIONS_TOGGLEALTUSE  = "Toggle Alt-key";
HEALBOT_OPTIONS_PROTECTPVP    = "Avoid accidental PvP flagging";


HEALBOT_OPTIONS_ITEMS  = "Objets";
HEALBOT_OPTIONS_SPELLS = "Sorts";

HEALBOT_OPTIONS_COMBOCLASS    = "Combinaison de touche pour";
HEALBOT_OPTIONS_CLICK         = "Click";
HEALBOT_OPTIONS_SHIFT         = "Shift+click:";
HEALBOT_OPTIONS_CTRL          = "Ctrl+click:";
HEALBOT_OPTIONS_SHIFTCTRL     = "Shift+Ctrl+click:";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Autoriser boutton pour soigner la cible";


HEALBOT_OPTIONS_CASTNOTIFY1   = "Pas de messages";
HEALBOT_OPTIONS_CASTNOTIFY2   = "Dire soit meme";
HEALBOT_OPTIONS_CASTNOTIFY3   = "Avertir la cible";
HEALBOT_OPTIONS_CASTNOTIFY4   = "Avertir le groupe";
HEALBOT_OPTIONS_CASTNOTIFY5   = "Avertir le raid";
HEALBOT_OPTIONS_TARGETWHISPER = "Whisper la cible au soin";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Option de chat";


HEALBOT_OPTIONS_HEAL_BUTTONS  = "Boutton de soin pour:"
HEALBOT_OPTIONS_GROUPHEALS    = "Groupe";
HEALBOT_OPTIONS_TANKHEALS     = "Tank principal";
HEALBOT_OPTIONS_TARGETHEALS   = "Cibles";
HEALBOT_OPTIONS_EMERGENCYHEALS= "Urgences";
HEALBOT_OPTIONS_HEALLEVEL     = "Niveau de soin";
HEALBOT_OPTIONS_ALERTLEVEL    = "Alerte de niveau";
HEALBOT_OPTIONS_OVERHEAL      = "Montre annulation lors de gros soin"
HEALBOT_OPTIONS_SORTHEALTH    = "Vie";
HEALBOT_OPTIONS_SORTPERCENT   = "Pourcent";
HEALBOT_OPTIONS_SORTSURVIVAL  = "Survival";
HEALBOT_OPTIONS_EMERGFILTER   = "Montrer un boutton d'urgence pour";
HEALBOT_OPTIONS_EMERGFCLASS   = "Configurer la classe pour";
HEALBOT_OPTIONS_COMBOBUTTON   = "Boutton";
HEALBOT_OPTIONS_BUTTONLEFT    = "Left";
HEALBOT_OPTIONS_BUTTONMIDDLE  = "Middle";
HEALBOT_OPTIONS_BUTTONRIGHT   = "Right";
HEALBOT_OPTIONS_BUTTON4       = "Button4";
HEALBOT_OPTIONS_BUTTON5       = "Button5";

BINDING_HEADER_HEALBOT  = "HealBot";
BINDING_NAME_TOGGLEMAIN = "Affiche al fenetre principal";
BINDING_NAME_HEALPLAYER = "Soigne joueur";
BINDING_NAME_HEALPET    = "Soigne pet";
BINDING_NAME_HEALPARTY1 = "Soigne groupe 1";
BINDING_NAME_HEALPARTY2 = "Soigne groupe 2";
BINDING_NAME_HEALPARTY3 = "Soigne groupe 3";
BINDING_NAME_HEALPARTY4 = "Soigne groupe 4";
BINDING_NAME_HEALTARGET = "Soigne cible";


HEALBOT_CLASSES_ALL     = "Toutes les classes";
HEALBOT_CLASSES_MELEE   = "Corps a corps";
HEALBOT_CLASSES_RANGES  = "Distances";
HEALBOT_CLASSES_HEALERS = "Soigneurs";
HEALBOT_CLASSES_CUSTOM  = "Divers";

HEALBOT_OPTIONS_BARALPHAINHEAL= "Incoming heal opacity";  -- ***************    needs French translation    ***************

HEALBOT_OPTIONS_CDCBUTTONS    = "Curing buttons";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDCLEFT       = "Alt+Left";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDCRIGHT      = "Alt+Right";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDCBARS       = "Healthbar colours";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDCCLASS      = "Monitor classes";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDCWARNINGS   = "Debuff warnings";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_CDC           = "Cure/Dispel/Cleanse for";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Display warning on debuff";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Play sound on debuff";  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SOUND1        = "Sound 1"  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SOUND2        = "Sound 2"  -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SOUND3        = "Sound 3"  -- ***************    needs French translation    ***************

HEALBOT_OPTIONS_SKINTEXT      = "Use skin"   -- ***************    needs French translation    ***************
HEALBOT_SKINS_STD             = "Standard"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINTEXTURE   = "Texture"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINHEIGHT    = "Height"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINWIDTH     = "Width"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINNUMCOLS   = "No. columns"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINBRSPACE   = "Row spacer"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINBCSPACE   = "Col spacer"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_EXTRASORT     = "Sort extra bars by"   -- ***************    needs French translation    ***************
HEALBOT_SORTBY_NAME           = "Name"   -- ***************    needs French translation    ***************
HEALBOT_SORTBY_CLASS          = "Class"   -- ***************    needs French translation    ***************
HEALBOT_SORTBY_GROUP          = "Group"   -- ***************    needs French translation    ***************
HEALBOT_SORTBY_MAXHEALTH      = "Max health"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_DELSKIN       = "Delete"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_NEWSKINTEXT   = "New skin"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SAVESKIN      = "Save"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINBARS      = "Bar options"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SKINPANEL     = "Panel colours"   -- ***************    needs French translation    *************** 
HEALBOT_SKIN_ENTEXT           = "Enabled"   -- ***************    needs French translation    ***************
HEALBOT_SKIN_DISTEXT          = "Disabled"   -- ***************    needs French translation    ***************
HEALBOT_SKIN_DEBTEXT          = "Debuff"   -- ***************    needs French translation    ***************
HEALBOT_SKIN_BACKTEXT         = "Background"   -- ***************    needs French translation    ***************
HEALBOT_SKIN_BORDERTEXT       = "Border"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_HIDEABORT     = "Hide abort button"   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SHOWHEADERS   = "Show headers"

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Show tooltips";   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Show detailed spell information";   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Show target information";   -- ***************    needs French translation    ***************
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Show instant cast recommendation";   -- ***************    needs French translation    ***************
HEALBOT_TOOLTIP_POSDEFAULT      = "Default location";   -- ***************    needs French translation    ***************
HEALBOT_TOOLTIP_POSLEFT         = "Left of Healbot";   -- ***************    needs French translation    ***************
HEALBOT_TOOLTIP_POSRIGHT        = "Right of Healbot";   -- ***************    needs French translation    ***************
HEALBOT_TOOLTIP_POSABOVE        = "Above Healbot";   -- ***************    needs French translation    ***************
HEALBOT_TOOLTIP_POSBELOW        = "Below Healbot";   -- ***************    needs translation    ***************

HEALBOT_OPTIONS_SKINFHEIGHT   = "Font Size"   -- ***************    needs translation    ***************
HEALBOT_OPTIONS_ABORTSIZE     = "Abort size"   -- ***************    needs translation    ***************
HEALBOT_OPTIONS_BARALPHADIS   = "Disabled opacity"   -- ***************    needs translation    ***************

HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Instant Cast Recommendation";   -- ***************    needs translation    ***************
HEALBOT_TOOLTIP_NONE            = "none available";   -- ***************    needs translation    ***************
HEALBOT_TOOLTIP_ITEMBONUS       = "Item bonuses";   -- ***************    needs translation    ***************
HEALBOT_TOOLTIP_ACTUALBONUS     = "Actual bonus is";   -- ***************    needs translation    ***************
HEALBOT_TOOLTIP_SHIELD          = "Wards"
HEALBOT_WORDS_OVER              = "over";   -- ***************    needs translation    ***************
HEALBOT_WORDS_SEC               = "sec";   -- ***************    needs translation    ***************
HEALBOT_WORDS_TO                = "to";   -- ***************    needs translation    ***************
HEALBOT_WORDS_CAST              = "Cast"   -- ***************    needs translation    ***************
HEALBOT_WORDS_FOR               = "for";   -- ***************    needs translation    ***************

HEALBOT_WORDS_NONE              = "None";
HEALBOT_OPTIONS_ALT             = "Alt+click";
HEALBOT_DISABLED_TARGET         = "Target"
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
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Show text in class colour"
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR2 = "Overrides Enabled and Debuff on the skin tab"

end
