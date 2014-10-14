------------
-- GERMAN --
------------

-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188


if (GetLocale() == "deDE") then

-------------------
-- Compatibility --
-------------------

HEALBOT_DRUID   = "Druide";
HEALBOT_HUNTER  = "J\195\164ger";
HEALBOT_MAGE    = "Magier";
HEALBOT_PALADIN = "Paladin";
HEALBOT_PRIEST  = "Priester";
HEALBOT_ROGUE   = "Schurke";
HEALBOT_SHAMAN  = "Schamane";
HEALBOT_WARLOCK = "Hexenmeister";
HEALBOT_WARRIOR = "Krieger";

HEALBOT_BANDAGES                = "Verb\195\164nde";

HEALBOT_LINEN_BANDAGE           = "Leinenverband";
HEALBOT_WOOL_BANDAGE            = "Wollverband";
HEALBOT_SILK_BANDAGE            = "Seidenverband";
HEALBOT_MAGEWEAVE_BANDAGE       = "Magiestoffverband";
HEALBOT_RUNECLOTH_BANDAGE       = "Runenstoffverband";

HEALBOT_HEAVY_LINEN_BANDAGE     = "Schwerer Leinenverband";
HEALBOT_HEAVY_WOOL_BANDAGE      = "Schwerer Wollverband";
HEALBOT_HEAVY_SILK_BANDAGE      = "Schwerer Seidenverband";
HEALBOT_HEAVY_MAGEWEAVE_BANDAGE = "Schwerer Magiestoffverband";
HEALBOT_HEAVY_RUNECLOTH_BANDAGE = "Schwerer Runenstoffverband";

HEALBOT_HEALING_POTIONS         = "Heiltr\195\164nke";

HEALBOT_MINOR_HEALING_POTION    = "Geringer Heiltrank";
HEALBOT_LESSER_HEALING_POTION   = "Schwacher Heiltrank";
HEALBOT_HEALING_POTION          = "Heiltrank";
HEALBOT_GREATER_HEALING_POTION  = "Gro\195\159er Heiltrank";
HEALBOT_SUPERIOR_HEALING_POTION = "\195\156berragender Heiltrank";
HEALBOT_MAJOR_HEALING_POTION    = "Erheblicher Heiltrank";

HEALBOT_HEALTHSTONES         = "Gesundheitssteine";

HEALBOT_MINOR_HEALTHSTONE    = "Geringer Gesundheitsstein";
HEALBOT_LESSER_HEALTHSTONE   = "Schwacher Gesundheitsstein";
HEALBOT_HEALTHSTONE          = "Gesundheitsstein";
HEALBOT_GREATER_HEALTHSTONE  = "Gro\195\159er Gesundheitsstein";
HEALBOT_MAJOR_HEALTHSTONE    = "Erheblicher Gesundheitsstein";

HEALBOT_FLASH_HEAL          = "Blitzheilung";
HEALBOT_FLASH_OF_LIGHT      = "Lichtblitz";
HEALBOT_HOLY_SHOCK			= "Heiliger Schock";
HEALBOT_GREATER_HEAL        = "Gro\195\159e Heilung";
HEALBOT_HEALING_TOUCH       = "Heilende Ber\195\188hrung";
HEALBOT_HEAL                = "Heilen";
HEALBOT_HEALING_WAVE        = "Welle der Heilung";
HEALBOT_HOLY_LIGHT          = "Heiliges Licht";
HEALBOT_LESSER_HEAL         = "Geringes Heilen";
HEALBOT_LESSER_HEALING_WAVE = "Geringe Welle der Heilung";
HEALBOT_MEND_PET            = "Tier Heilen";
HEALBOT_POWER_WORD_SHIELD   = "Machtwort: Schild";
HEALBOT_REGROWTH            = "Nachwachsen";
HEALBOT_RENEW               = "Erneuerung";
HEALBOT_REJUVENATION        = "Verj\195\188ngung";
HEALBOT_PRAYER_OF_HEALING   = "Gebet der Heilung";
HEALBOT_CHAIN_HEAL          = "Kettenheilung";

HEALBOT_POWER_WORD_FORTITUDE  = "Machtwort: Seelenst\195\164rke";
HEALBOT_DIVINE_SPIRIT         = "G\195\182ttlicher Willen";
HEALBOT_MARK_OF_THE_WILD      = "Mal der Wildnis";
HEALBOT_THORNS                = "Dornen";
HEALBOT_BLESSING_OF_SALVATION = "Segen der Rettung";

HEALBOT_RESURRECTION        = "Auferstehung";
HEALBOT_REDEMPTION          = "Erl\195\182sung";
HEALBOT_REBIRTH             = "Wiedergeburt";
HEALBOT_ANCESTRALSPIRIT     = "Geist der Ahnen";

HEALBOT_CURE_DISEASE       = "Krankheit heilen";
HEALBOT_ABOLISH_DISEASE    = "Krankheit aufheben";
HEALBOT_PURIFY             = "L\195\164utern";
HEALBOT_CLEANSE            = "Reinigung des Glaubens";
HEALBOT_DISPEL_MAGIC       = "Magiebannung";
HEALBOT_CURE_POISON        = "Vergiftung heilen";
HEALBOT_ABOLISH_POISON     = "Vergiftung aufheben";
HEALBOT_REMOVE_CURSE       = "Fluch aufheben"; 
HEALBOT_DISEASE            = "Krankheit";   
HEALBOT_MAGIC              = "Magie";
HEALBOT_CURSE              = "Fluch";   
HEALBOT_POISON             = "Gift";

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

HEALBOT_LIBRARY_INCHEAL    = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.";
HEALBOT_LIBRARY_INCDAMHEAL = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)%.";

HB_BONUSSCANNER_NAMES = {	
	HEAL 		= "Heilung",
}

HB_BONUSSCANNER_PREFIX_EQUIP = "Anlegen: ";
HB_BONUSSCANNER_PREFIX_SET = "Set: ";

HB_BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "Erh\195\182ht durch Zauber und magische Effekte zugef\195\188gten Schaden und Heilung um bis zu (%d+)%.", effect = {"HEAL","DMG"} },
	{ pattern = "Erh\195\182ht durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
	{ pattern = "Erh\195\182ht die durch Zauber und Effekte verursachte Heilung um bis zu (%d+)%.", effect = "HEAL" },
};

HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
	["Heilzauber"] 			= "HEAL",
	["Heilung und Zauberschaden"] = {"HEAL","DMG"},
};

HB_BONUSSCANNER_PATTERNS_OTHER = {
	{ pattern = "Zandalarianisches Siegel des Mojo", effect = {"DMG", "HEAL"}, value = 18 },
	{ pattern = "Zandalarianisches Siegel der Inneren Ruhe", effect = "HEAL", value = 33 },
	
	{ pattern = "Schwaches Zauber", effect = {"DMG", "HEAL"}, value = 8 },
	{ pattern = "Geringes Zauber", effect = {"DMG", "HEAL"}, value = 16 },
	{ pattern = "Zauber", effect = {"DMG", "HEAL"}, value = 24 },
	{ pattern = "Hervorragendes Zauber", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

	{ pattern = "Hervorragendes Mana", effect = { "MANAREG", "HEAL"}, value = {12, 25} }

};

HEALBOT_BUFF_FIRST_AID           = "Interface\\Icons\\Spell_Holy_Heal";
HEALBOT_BUFF_POWER_WORD_SHIELD   = "Interface\\Icons\\Spell_Holy_PowerWordShield";
HEALBOT_BUFF_REJUVENATION        = "Interface\\Icons\\Spell_Nature_Rejuvenation";
HEALBOT_BUFF_REGROWTH            = "Interface\\Icons\\Spell_Nature_ResistNature";
HEALBOT_BUFF_RENEW               = "Interface\\Icons\\Spell_Holy_Renew";
HEALBOT_DEBUFF_WEAKENED_SOUL     = "Interface\\Icons\\Spell_Holy_AshesToAshes";
HEALBOT_DEBUFF_RECENTLY_BANDAGED = "Interface\\Icons\\INV_Misc_Bandage_08";


HB_SPELL_PATTERN_LESSER_HEAL         = "Euer Ziel um (%d+) bis (%d+) Punkt%(e%) heilen";
HB_SPELL_PATTERN_HEAL                = "Euer Ziel um (%d+) bis (%d+) Punkt%(e%) heilen";
HB_SPELL_PATTERN_GREATER_HEAL        = "Ein langsam zu wirkender Zauber, der ein einzelnes Ziel um (%d+) bis (%d+) Punkt%(e%) heilt";
HB_SPELL_PATTERN_FLASH_HEAL          = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_RENEW2              = "Heilt das Ziel (%d+) Sek. lang um (%d+) bis (%d+) Schadenspunk";
HB_SPELL_PATTERN_RENEW3              = "Heilt das Ziel (%d+) Sek. lang um (%d+) Schadenspunk";
HB_SPELL_PATTERN_SHIELD              = "absorbiert dabei (%d+) Punkt%(e%) Schaden. H\195\164lt (%d+) Sek";
HB_SPELL_PATTERN_HEALING_TOUCH       = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_REGROWTH            = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) und \195\188ber (%d+) Sek%. um weitere (%d+)";
HB_SPELL_PATTERN_REGROWTH1           = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) und \195\188ber (%d+) Sek%. um weitere (%d+) bis (%d+)";
HB_SPELL_PATTERN_HOLY_LIGHT          = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_FLASH_OF_LIGHT      = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_HEALING_WAVE        = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_LESSER_HEALING_WAVE = "Heilt ein befreundetes Ziel um (%d+) bis (%d+) Punkt%(e%)";
HB_SPELL_PATTERN_REJUVENATION        = "Heilt das Ziel von (%d+) \195\188ber (%d+) Sek";
HB_SPELL_PATTERN_REJUVENATION1       = "Heilt das Ziel von (%d+) bis (%d+) \195\188ber (%d+) Sek";

HB_TOOLTIP_MANA                      = "^(%d+) Mana$";
HB_TOOLTIP_RANGE                     = "(%d+) m";
HB_TOOLTIP_INSTANT_CAST              = "Spontanzauber";
HB_TOOLTIP_CAST_TIME                 = "(%d+.?%d*) Sek";
HB_TOOLTIP_CHANNELED                 = "Abgebrochen"; 
HB_HASLEFTRAID                       = "^([^%s]+) hat die \195\131\197\147berfallgruppe verlassen%.$";
HB_HASLEFTPARTY                      = "^([^%s]+) hat die Gruppe verlassen"; 
HB_YOULEAVETHEGROUP                  = "Du hast die Gruppe verlassen"  
HB_YOULEAVETHERAID                   = "Du hast den Schlachtzug verlassen" 

-----------------
-- Translation --
-----------------

HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
HEALBOT_LOADED = " geladen.";

HEALBOT_CASTINGSPELLONYOU  = "Wirke %s auf Euch ...";
HEALBOT_CASTINGSPELLONUNIT = "Wirke %s auf %s ...";
HEALBOT_ABORTEDSPELLONUNIT = "... abgebrochen %s bei %s";

HEALBOT_ACTION_TITLE      = "HealBot";
HEALBOT_ACTION_OPTIONS    = "Optionen";
HEALBOT_ACTION_ABORT      = "Abbruch";

HEALBOT_OPTIONS_TITLE         = HEALBOT_ADDON;
HEALBOT_OPTIONS_DEFAULTS      = "Reset";
HEALBOT_OPTIONS_CLOSE         = "Schlie\195\159en";
HEALBOT_OPTIONS_TAB_GENERAL   = "Allg.";
HEALBOT_OPTIONS_TAB_SPELLS    = "Spr\195\188che";  
HEALBOT_OPTIONS_TAB_HEALING   = "Heilung";
HEALBOT_OPTIONS_TAB_CDC       = "Debuffs";  
HEALBOT_OPTIONS_TAB_SKIN      = "Skin"   
HEALBOT_OPTIONS_TAB_TIPS      = "Tips";

HEALBOT_OPTIONS_PANEL_TEXT    = "Heilungspanel Optionen:"
HEALBOT_OPTIONS_BARALPHA      = "Leisten Transparenz";
HEALBOT_OPTIONS_BARALPHAINHEAL = "Ankomm.Heilung Transparenz";
HEALBOT_OPTIONS_ACTIONLOCKED  = "Fenster fixieren";
HEALBOT_OPTIONS_GROWUPWARDS   = "Aufw\195\164rts sort.";
HEALBOT_OPTIONS_AUTOSHOW      = "Automatisch \195\150ffnen";
HEALBOT_OPTIONS_PANELSOUNDS   = "Sound beim \195\150ffnen";
HEALBOT_OPTIONS_ALERTSECONDS  = "Todescountdown";
HEALBOT_OPTIONS_HIDEOPTIONS   = "Verstecke Optionen Knopf";
HEALBOT_OPTIONS_QUALITYRANGE  = "Exakter 25 Meter Check in Instanzen";
HEALBOT_OPTIONS_INTEGRATECTRA = "Integriere CTRA";
HEALBOT_OPTIONS_TOGGLEALTUSE  = "Toggle Alt-key";
HEALBOT_OPTIONS_PROTECTPVP    = "Vermeidung des PvP Flags";
HEALBOT_OPTIONS_HEAL_CHATOPT  = "Chat Optionen";

HEALBOT_OPTIONS_SKINTEXT      = "Skin"  
HEALBOT_SKINS_STD             = "Standard"
HEALBOT_OPTIONS_SKINTEXTURE   = "Textur"  
HEALBOT_OPTIONS_SKINHEIGHT    = "H\195\182he"  
HEALBOT_OPTIONS_SKINWIDTH     = "Breite"   
HEALBOT_OPTIONS_SKINNUMCOLS   = "Anzahl Spalten"  
HEALBOT_OPTIONS_SKINBRSPACE   = "Reihenabstand"   
HEALBOT_OPTIONS_SKINBCSPACE   = "Spaltenabstand"  
HEALBOT_OPTIONS_EXTRASORT     = "Sort. Extraleisten nach"  
HEALBOT_SORTBY_NAME           = "Name"  
HEALBOT_SORTBY_CLASS          = "Klasse"  
HEALBOT_SORTBY_GROUP          = "Gruppe" 
HEALBOT_SORTBY_MAXHEALTH      = "Max Leben"   
HEALBOT_OPTIONS_DELSKIN       = "L\195\182schen" 
HEALBOT_OPTIONS_NEWSKINTEXT   = "Neuer Skin"   
HEALBOT_OPTIONS_SAVESKIN      = "Speichern"  
HEALBOT_OPTIONS_SKINBARS      = "Leisten Optionen"   
HEALBOT_OPTIONS_SKINPANEL     = "Panel Farben"   
HEALBOT_SKIN_ENTEXT           = "Aktiv"   
HEALBOT_SKIN_DISTEXT          = "Inaktiv"   
HEALBOT_SKIN_DEBTEXT          = "Debuff"   
HEALBOT_SKIN_BACKTEXT         = "Hintergrund" 
HEALBOT_SKIN_BORDERTEXT       = "Rand" 
HEALBOT_OPTIONS_HIDEABORT     = "Verstecke Abbruch Knopf"   
HEALBOT_OPTIONS_SHOWHEADERS   = "Zeige \195\156berschriften"

HEALBOT_OPTIONS_ITEMS  = "Items";
HEALBOT_OPTIONS_SPELLS = "Spr\195\188che";

HEALBOT_OPTIONS_COMBOCLASS    = "Tastenkombinationen f\195\188r";
HEALBOT_OPTIONS_CLICK         = "Klick";
HEALBOT_OPTIONS_SHIFT         = "Shift+Klick:";
HEALBOT_OPTIONS_CTRL          = "Strg+Klick:";
HEALBOT_OPTIONS_SHIFTCTRL     = "Shift+Strg+Klick:";
HEALBOT_OPTIONS_ENABLEHEALTHY = "Auch unverletzte Ziele heilen";

HEALBOT_OPTIONS_CASTNOTIFY1   = "Keine Benachrichtigungen";
HEALBOT_OPTIONS_CASTNOTIFY2   = "Nachricht an sich selbst";
HEALBOT_OPTIONS_CASTNOTIFY3   = "Nachricht ans Ziel";
HEALBOT_OPTIONS_CASTNOTIFY4   = "Nachricht an die Gruppe";
HEALBOT_OPTIONS_CASTNOTIFY5   = "Nachricht an den Raid ";
HEALBOT_OPTIONS_TARGETWHISPER = "Ziel bei Heilung anfl\195\188stern";

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Heilungsknopf f\195\188r:"

HEALBOT_OPTIONS_CDCBUTTONS    = "Maustasten bei Debuffs"; 
HEALBOT_OPTIONS_CDCLEFT       = "Alt+Links";  
HEALBOT_OPTIONS_CDCRIGHT      = "Alt+Rechts";  
HEALBOT_OPTIONS_CDCBARS       = "Farbe f\195\188r Art des Zaubers";   
HEALBOT_OPTIONS_CDCCLASS      = "\195\156berwache Klasse"; 
HEALBOT_OPTIONS_CDCWARNINGS   = "Warnung bei Debuffs";
HEALBOT_OPTIONS_CDC           = "Heilen/Bannen/Reinigen f\195\188r"; 
HEALBOT_OPTIONS_SHOWDEBUFFWARNING = "Zeige Warnung bei Debuff";
HEALBOT_OPTIONS_SOUNDDEBUFFWARNING = "Spiele Ton bei Debuff"; 
HEALBOT_OPTIONS_SOUND1        = "Ton 1"  
HEALBOT_OPTIONS_SOUND2        = "Ton 2"  
HEALBOT_OPTIONS_SOUND3        = "Ton 3" 

HEALBOT_OPTIONS_HEAL_BUTTONS  = "Heilungsleisten f\195\188r";
HEALBOT_OPTIONS_EMERGFILTER   = "Notfall Optionen f\195\188r";

HEALBOT_OPTIONS_GROUPHEALS    = "Gruppe";
HEALBOT_OPTIONS_TANKHEALS     = "Maintanks";
HEALBOT_OPTIONS_TARGETHEALS   = "Ziele";
HEALBOT_OPTIONS_EMERGENCYHEALS= "Notf\195\164lle";
HEALBOT_OPTIONS_HEALLEVEL     = "Heilstufe";
HEALBOT_OPTIONS_ALERTLEVEL    = "Alarmstufe";
HEALBOT_OPTIONS_OVERHEAL      = "Abbruch Knopf bei \195\156berheilung"
HEALBOT_OPTIONS_SORTHEALTH    = "Gesundheit";
HEALBOT_OPTIONS_SORTPERCENT   = "Prozent"
HEALBOT_OPTIONS_SORTSURVIVAL  = "Todescountdown";
HEALBOT_OPTIONS_EMERGFCLASS   = "Klassenauswahl nach";
HEALBOT_OPTIONS_COMBOBUTTON   = "Maustaste";  
HEALBOT_OPTIONS_BUTTONLEFT    = "Linke";  
HEALBOT_OPTIONS_BUTTONMIDDLE  = "Mittlere";   
HEALBOT_OPTIONS_BUTTONRIGHT   = "Rechte";  
HEALBOT_OPTIONS_BUTTON4       = "Taste4";  
HEALBOT_OPTIONS_BUTTON5       = "Taste5";  

BINDING_HEADER_HEALBOT  = "HealBot";
BINDING_NAME_TOGGLEMAIN = "Hauptfenster an-/ausschalten";
BINDING_NAME_HEALPLAYER = "Spieler heilen";
BINDING_NAME_HEALPET    = "Begleiter heilen";
BINDING_NAME_HEALPARTY1 = "Gruppenmitglied 1 heilen";
BINDING_NAME_HEALPARTY2 = "Gruppenmitglied 2 heilen";
BINDING_NAME_HEALPARTY3 = "Gruppenmitglied 3 heilen";
BINDING_NAME_HEALPARTY4 = "Gruppenmitglied 4 heilen";
BINDING_NAME_HEALTARGET = "Ziel heilen";

HEALBOT_OPTIONS_PROFILE    = "Set Profile:";
HEALBOT_OPTIONS_ProfilePvP = "PvP";
HEALBOT_OPTIONS_ProfilePvE = "PvE";

HEALBOT_CLASSES_ALL     = "Alle Klassen";
HEALBOT_CLASSES_MELEE   = "Nahkampf";
HEALBOT_CLASSES_RANGES  = "Fernkampf";
HEALBOT_CLASSES_HEALERS = "Heiler";
HEALBOT_CLASSES_CUSTOM  = "pers\195\182nlich";

HEALBOT_OPTIONS_SHOWTOOLTIP     = "Zeige Tooltips"; 
HEALBOT_OPTIONS_SHOWDETTOOLTIP  = "Zeige detaillierte Spruchinfos";
HEALBOT_OPTIONS_SHOWUNITTOOLTIP = "Zeige Zielinfos";  
HEALBOT_OPTIONS_SHOWRECTOOLTIP  = "Zeige empf. Sofortzauber";  
HEALBOT_TOOLTIP_POSDEFAULT      = "Standardposition";  
HEALBOT_TOOLTIP_POSLEFT         = "Links vom Healbot";  
HEALBOT_TOOLTIP_POSRIGHT        = "Rechts vom Healbot";   
HEALBOT_TOOLTIP_POSABOVE        = "\195\156ber dem Healbot";  
HEALBOT_TOOLTIP_POSBELOW        = "Unter dem Healbot";   

HEALBOT_OPTIONS_SKINFHEIGHT   = "Schrift Gr\195\182\195\159e"
HEALBOT_OPTIONS_ABORTSIZE     = "Abbruch Gr\195\182\195\159e"
HEALBOT_OPTIONS_BARALPHADIS   = "Inaktiv Transparenz"

HEALBOT_TOOLTIP_RECOMMENDTEXT   = "Sofortzauber Empfehlung"
HEALBOT_TOOLTIP_NONE            = "nicht verf\195\188gbar"
HEALBOT_TOOLTIP_ITEMBONUS       = "Item Bonus";
HEALBOT_TOOLTIP_ACTUALBONUS     = "Aktueller Bonus ist";
HEALBOT_TOOLTIP_SHIELD          = "Absorbiert"
HEALBOT_WORDS_OVER              = "\195\188ber";
HEALBOT_WORDS_SEC               = "Sek";
HEALBOT_WORDS_TO                = "zu";
HEALBOT_WORDS_CAST              = "Zauber"
HEALBOT_WORDS_FOR               = "f\195\188r";

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
