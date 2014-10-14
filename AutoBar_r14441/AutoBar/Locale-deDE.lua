--
-- AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

local AceLocale = AceLibrary("AceLocale-2.1");

AceLocale:RegisterTranslation("AutoBar", "deDE", function()
    return {
        ["AUTOBAR"] = "AutoBar",
        ["CONFIG_WINDOW"] = "Einstellungen",
        ["SLASHCMD_LONG"] = "/autobar",
        ["SLASHCMD_SHORT"] = "/atb",
        ["BUTTON"] = "Feld",
        ["EDITSLOT"] = "Bearbeiten",
        ["VIEWSLOT"] = "Blick",
    }
end);


if (GetLocale() == "deDE") then

AUTOBAR_CHAT_MESSAGE1 = "Veraltete Einstellungen wurden gefunden und gel\195\182scht. Standardeinstellungen werden wieder hergestellt.";
AUTOBAR_CHAT_MESSAGE2 = "Benutze im Mehrfachfeld #%d f\195\188r den Gegenstand #%d die zugeh\195\182rige ItemID anstelle den Namen.";
AUTOBAR_CHAT_MESSAGE3 = "Benutze f\195\188r den Gegenstand #%d die zugeh\195\182rige ItemID anstelle den Namen.";

---------------------------------------
--  AutoBar_Config.xml
---------------------------------------
AUTOBAR_CONFIG_RESET = "Zur\195\188cksetzen";
AUTOBAR_CONFIG_CONVERT = "Umwandeln";
AUTOBAR_CONFIG_DONE = "Fertig";
AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Gro\195\159schreiben+Links-Klick um Kategorien zu durchsuchen)";
AUTOBAR_CONFIG_SINGLEITEMCUSTOM = "Benutzerdefiniertes Objekt einf\195\188gen";

AUTOBAR_CONFIG_TAB_SLOTS = "Schlitze";
AUTOBAR_CONFIG_TAB_BAR = "Balken";
AUTOBAR_CONFIG_TAB_BUTTONS = "Felder";
AUTOBAR_CONFIG_TAB_POPUP = "Popup";
AUTOBAR_CONFIG_TAB_PROFILE = "Profil";

AUTOBAR_TOOLTIP1 = " (Anzahl: ";
AUTOBAR_TOOLTIP2 = " [Benutzerdefiniertes Objekt]";
AUTOBAR_TOOLTIP3 = " [Nur im Kampf]";
AUTOBAR_TOOLTIP4 = " [Nur in Schlachtfeldern]";
AUTOBAR_TOOLTIP5 = " [Nur au\195\159erhalb Kampf]";
AUTOBAR_TOOLTIP6 = " [Begrenzte Verwendung]";
AUTOBAR_TOOLTIP7 = " [Abklingzeit]";
AUTOBAR_TOOLTIP8 = "\n(Links-Klick f\195\188r Waffenhand.\nRechts-Klick f\195\188r Schildhand)";


---------------------------------------
--  AutoBar_Config.lua
---------------------------------------
AUTOBAR_CONFIG_CUSTOM_ENTRY = "Namen oder ItemID f\195\188r einen Gegenstand eingeben:";
AUTOBAR_CONFIG_EMPTY = "Leer";
AUTOBAR_CONFIG_SMARTSELFCAST = "Intelligente Selbstanwendung";
AUTOBAR_CONFIG_REMOVECAT = "Aktuelle Kategorie l\195\182schen";
AUTOBAR_CONFIG_ROW = "Zeilen";
AUTOBAR_CONFIG_COLUMN = "Spalten";
AUTOBAR_CONFIG_GAPPING = "Symbolabstand";
AUTOBAR_CONFIG_ALPHA = "Symboltranparenz";
AUTOBAR_CONFIG_BUTTONWIDTH = "Feldbreite";
AUTOBAR_CONFIG_BUTTONHEIGHT = "Feldh\195\182he";
AUTOBAR_CONFIG_DOCKSHIFTX = "Verankern: rechts/links";
AUTOBAR_CONFIG_DOCKSHIFTY = "Verankern: oben/unten";
AUTOBAR_CONFIG_DOCKING_MAINMENU = "Verankern am Men\195\188";
AUTOBAR_CONFIG_WIDTHHEIGHTLOCKED = "Feldbreite/Feldh\195\182he gleichsetzen";
AUTOBAR_CONFIG_REVERSE = "Felder umkehren";
AUTOBAR_CONFIG_HIDEKEYBINDING = "Tastenbelegung verbergen";
AUTOBAR_CONFIG_HIDECOUNT = "Anzahl verbergen";
AUTOBAR_CONFIG_SHOWEMPTY = "Leere Felder anzeigen";
AUTOBAR_CONFIG_HIDETOOLTIP = "InfoFenster verbergen";

AUTOBAR_CONFIG_NOTFOUND = "(Nicht gefunden: Gegenstand ";

AUTOBAR_TOOLTIP9 = "Mehrfachfeld\n";
AUTOBAR_TOOLTIP10 = " (Benutzerdefinifierter Gegenstand aus ItemID)";
AUTOBAR_TOOLTIP11 = "\n(ItemID nicht erkannt)";
AUTOBAR_TOOLTIP12 = " (Benutzerdefinifierter Gegenstand aus Name)";
AUTOBAR_TOOLTIP13 = "Einzelfeld\n\n";
AUTOBAR_TOOLTIP14 = "\nNicht direkt verwendbar.";
AUTOBAR_TOOLTIP15 = "\nWaffenziel\n(Links-Klick f\195\188r Waffenhand.\nRechts-Klick f\195\188r Schildhand)";
AUTOBAR_TOOLTIP16 = "\nZiel ausgew\195\164hlt.";
AUTOBAR_TOOLTIP17 = "\nNur au\195\159erhalb Kampf.";
AUTOBAR_TOOLTIP18 = "\nNur in Kampf.";
AUTOBAR_TOOLTIP19 = "\nPosition: ";
AUTOBAR_TOOLTIP20 = "\nBegrenzte Verwendung: "
AUTOBAR_TOOLTIP21 = "Einsatz bei fehlender Gesundheit";
AUTOBAR_TOOLTIP22 = "Einsatz bei fehlendem Mana";
AUTOBAR_TOOLTIP23 = "Einzelfeld\n\n";


---------------------------------------
--  AutoBar_ItemList.lua
---------------------------------------
AUTOBAR_ALTERACVALLEY = "Alteractal";
AUTOBAR_WARSONGGULCH = "Warsongschlucht";
AUTOBAR_ARATHIBASIN = "Arathibecken";
AUTOBAR_AHN_QIRAJ = "Ahn'Qiraj";

AUTOBAR_CLASS_CUSTOM = "Benutzerdefiniert";
AUTOBAR_CLASS_BANDAGES = "Verb\195\164nde";
AUTOBAR_CLASS_ALTERAC_BANDAGE = "Alterac Verb\195\164nde";
AUTOBAR_CLASS_WARSONG_BANDAGE = "Warsong Verb\195\164nde";
AUTOBAR_CLASS_ARATHI_BANDAGE = "Arathi Verb\195\164nde";
AUTOBAR_CLASS_UNGORORESTORE = "Un'Goro: Kristallflicker";

AUTOBAR_CLASS_ANTIVENOM = "Gegengift";
AUTOBAR_CLASS_AGILITYPOTIONS = "Beweglichkeitsbonus";
AUTOBAR_CLASS_STRENGTHPOTIONS = "St\195\164rkebonus";
AUTOBAR_CLASS_FORTITUDEPOTIONS = "Ausdauerbonus";
AUTOBAR_CLASS_INTELLECTPOTIONS = "Intelligenzbonus";
AUTOBAR_CLASS_WISDOMPOTIONS = "willenskraftbonus";
AUTOBAR_CLASS_DEFENSEPOTIONS = "Verteidigungsbonus";
AUTOBAR_CLASS_TROLLBLOODPOTIONS = "Trollbluttr\195\164nke";
AUTOBAR_CLASS_SCROLLOFAGILITY = "Rolle der Beweglichkeit";
AUTOBAR_CLASS_SCROLLOFINTELLECT = "Rolle der Intelligenz";
AUTOBAR_CLASS_SCROLLOFPROTECTION = "Rolle des Schutzes";
AUTOBAR_CLASS_SCROLLOFSPIRIT = "Rolle der Willenskraft";
AUTOBAR_CLASS_SCROLLOFSTAMINA = "Rolle der Ausdauer";
AUTOBAR_CLASS_SCROLLOFSTRENGTH = "Rolle der St\195\164rke";

AUTOBAR_CLASS_HEALPOTIONS = "Heiltr\195\164nke";
AUTOBAR_CLASS_PVP6HEALPOTIONS = "PVP Rang 6 - Heiltr\195\164nke";
AUTOBAR_CLASS_HEALTHSTONE = "Gesundheitssteine";
AUTOBAR_CLASS_WHIPPER_ROOT = "Peitscherwurzelknollen";
AUTOBAR_CLASS_BATTLEGROUNDHEALPOTIONS = "Schlachtfeld-Heiltr\195\164nke";
AUTOBAR_CLASS_MANAPOTIONS = "Mana Tr\195\164nke";
AUTOBAR_CLASS_PVP6MANAPOTIONS = "PVP Rang 6 - Mana Tr\195\164nke";
AUTOBAR_CLASS_MANASTONE = "Mana Edelsteine";
AUTOBAR_CLASS_BATTLEGROUNDMANAPOTIONS = "Schlachtfeld Mana Tr\195\164nke";
AUTOBAR_CLASS_DREAMLESS_SLEEP = "Traumloser Schlaf";
AUTOBAR_CLASS_NIGHT_DRAGONS_BREATH = "Nachtdrachenodem";
AUTOBAR_CLASS_REJUVENATION_POTIONS = "Verj\195\188ngungstr\195\164nke";

AUTOBAR_CLASS_BATTLESTANDARD = "Schlachtstandarte";
AUTOBAR_CLASS_BATTLESTANDARDAV = "Schlachtstandarte Alteractal";
AUTOBAR_CLASS_DEMONIC_DARK_RUNES = "D\195\164monische und Dunkle Runen";
AUTOBAR_CLASS_ARCANE_PROTECTION = "Arkanschutz";
AUTOBAR_CLASS_FIRE_PROTECTION = "Feuerschutz";
AUTOBAR_CLASS_FROST_PROTECTION = "Frostschutz";
AUTOBAR_CLASS_NATURE_PROTECTION = "Naturschutz";
AUTOBAR_CLASS_SHADOW_PROTECTION = "Schattenschutz";
AUTOBAR_CLASS_SPELL_PROTECTION = "Zauberschutz";
AUTOBAR_CLASS_HOLY_PROTECTION = "Heiligschutz";
AUTOBAR_CLASS_INVULNERABILITY_POTIONS = "Unverwundbarkeitstr\195\164nke";
AUTOBAR_CLASS_FREE_ACTION_POTION = "Bewegungsbefreiende Tr\195\164nke";

AUTOBAR_CLASS_HEARTHSTONE = "Ruhestein";
AUTOBAR_CLASS_WATER = "Wasser";
AUTOBAR_CLASS_WATER_CONJURED = "Wasser: herbeigezaubert";
AUTOBAR_CLASS_WATER_SPIRIT = "Wasser: Willenskraftbonus";
AUTOBAR_CLASS_RAGEPOTIONS = "Wut Tr\195\164nke";
AUTOBAR_CLASS_ENERGYPOTIONS = "Energie Tr\195\164nke";
AUTOBAR_CLASS_SWIFTNESSPOTIONS = "Beweglichkeits Tr\195\164nke";
AUTOBAR_CLASS_SOULSHARDS = "seelensteine";
AUTOBAR_CLASS_ARROWS = "Pfeile";
AUTOBAR_CLASS_BULLETS = "Patronen";
AUTOBAR_CLASS_THROWNWEAPON = "Wurfwaffen";
AUTOBAR_CLASS_FOOD = "Nahrung: kein Bonus";
AUTOBAR_CLASS_FOOD_PET_BREAD = "Nahrung: Begleiter Brot";
AUTOBAR_CLASS_FOOD_PET_CHEESE = "Nahrung: Begleiter K\195\164se";
AUTOBAR_CLASS_FOOD_PET_FISH = "Nahrung: Begleiter Fisch";
AUTOBAR_CLASS_FOOD_PET_FRUIT = "Nahrung: Begleiter Fr\195\188chte";
AUTOBAR_CLASS_FOOD_PET_FUNGUS = "Nahrung: Begleiter Pilze";
AUTOBAR_CLASS_FOOD_PET_MEAT = "Nahrung: Begleiter Fleisch";
AUTOBAR_CLASS_FOOD_COMBO= "Wasser & Nahrungskombination";
AUTOBAR_CLASS_FOOD_CONJURED = "Nahrung: herbeigezaubert";
AUTOBAR_CLASS_FOOD_STAMINA = "Nahrung: Ausdauer Bonus";
AUTOBAR_CLASS_FOOD_AGILITY = "Nahrung: Beweglichkeit Bonus";
AUTOBAR_CLASS_FOOD_MANAREGEN = "Nahrung: Mana Wiederherstellungsbonus";
AUTOBAR_CLASS_FOOD_HPREGEN = "Nahrung: Gesundheits-Wiederherstellungsbonus";
AUTOBAR_CLASS_FOOD_STRENGTH = "Nahrung: St\195\164rke Bonus";
AUTOBAR_CLASS_FOOD_INTELLIGENCE = "Nahrung: Intelligenz Bonus";
AUTOBAR_CLASS_FOOD_ARATHI = "Nahrung: Arathibecken";
AUTOBAR_CLASS_FOOD_WARSONG = "Nahrung: Warsongschlucht";
AUTOBAR_CLASS_SHARPENINGSTONES = "hergestellte Wetzsteine";
AUTOBAR_CLASS_WEIGHTSTONE = "hergestellte Gewichtssteine";
AUTOBAR_CLASS_POISON_CRIPPLING = "Verkr\195\188ppelndes Gift";
AUTOBAR_CLASS_POISON_DEADLY = "T\195\182dliches Gift";
AUTOBAR_CLASS_POISON_INSTANT = "Sofortwirkendes Gift";
AUTOBAR_CLASS_POISON_MINDNUMBING = "Gedankenbenebelndes Gift";
AUTOBAR_CLASS_POISON_WOUND = "Verwundendes Gift";
AUTOBAR_CLASS_EXPLOSIVES = "Ingenieurssprengstoffe";
AUTOBAR_CLASS_MOUNTS_TROLL = "Reittier: Trolle - Raptoren";
AUTOBAR_CLASS_MOUNTS_ORC = "Reittier: Orcs - W\195\182lfe";
AUTOBAR_CLASS_MOUNTS_UNDEAD = "Reittier: Untote - Skelletpferde";
AUTOBAR_CLASS_MOUNTS_TAUREN = "Reittier: Tauren - Kodos";
AUTOBAR_CLASS_MOUNTS_HUMAN = "Reittier: Menschen - Pferde";
AUTOBAR_CLASS_MOUNTS_NIGHTELF = "Reittier: Nachtelfen - Tiger";
AUTOBAR_CLASS_MOUNTS_DWARF = "Reittier: Zwerge - Widder";
AUTOBAR_CLASS_MOUNTS_GNOME = "Reittier: Gnome - Roboschreiter";
AUTOBAR_CLASS_MOUNTS_SPECIAL = "Reittier: Spezial";
AUTOBAR_CLASS_MOUNTS_QIRAJI = "Reittier: Qiraji";
AUTOBAR_CLASS_MANA_OIL = "Zauber\195\182le: Mana Regeneration";
AUTOBAR_CLASS_WIZARD_OIL = "Zauber\195\182le: Schaden/Heilung";
AUTOBAR_CLASS_FISHINGITEMS = "Angelzubeh\195\182r";

end