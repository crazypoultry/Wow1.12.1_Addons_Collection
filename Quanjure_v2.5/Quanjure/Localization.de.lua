--[[
German Version
Text translated by my guild mate Beth (Resident Knuddelmaus of Praemium Callidus).

Should you find any errors in the naming of spells or items, please send me a correction.

Thank you. 
Quantuvis   quantuvis@represent.dk
]]--

if ( GetLocale() == "deDE" ) then
	QUANJURE_MAGE = "Magier";
	QUANJURE_MAGE_WARNING = "Derzeitiger Charakter ist kein Magier (oder zu geringes Level) - wird abgebrochen.";
	QUANJURE_TOOLTIP = "Links-Klick f\195\188r Quanjure.\nRechts-Klick f\195\188 Men\195\188.\nShift+Rechts-Klick zum verschieben."
	QUANJURE_MINIMAP = "Minikartenknopf ausblenden"
	QUANJURE_MINIMAP_SETUP = "Zeige Minikartenknopf";
	QUANJURE_MINIMAP_TOOLTIP = "Ankreuzen um den Knopf an der Minikarte zu sehen.";	
	QUANJURE_TITAN_OPTIONS = "Optionen";
	QUANJURE_SETUP = "Quanjure Einstellungen";
	QUANJURE_ALLIANCE = "Allianz";
	QUANJURE_HORDE = "Horde";
	QUANJURE_READY = "Bereit";
	QUANJURE_BAG = "Rucksack";
	QUANJURE_HEARTHSTONE = "Ruhestein";
	
	QUANJURE_WATERTYPES = {
		"Herbeigezaubertes Wasser",
		"Herbeigezaubertes frisches Wasser",
		"Herbeigezaubertes gel\195\164utertes Wasser",
		"Herbeigezaubertes Quellwasser",
		"Herbeigezaubertes Mineralwasser",
		"Herbeigezaubertes Sprudelwasser",
		"Herbeigezaubertes Kristallwasser" 
	};
	QUANJURE_FOODTYPES = {
		"Herbeigezauberter Muffin",
		"Herbeigezaubertes Brot",
		"Herbeigezaubertes Roggenbrot",
		"Herbeigezauberter Pumpernickel",
		"Herbeigezauberter Sauerteig",
		"Herbeigezaubertes Milchbr\195\182tchen",
		"Herbeigezauberte Zimtschnecke"
	};
	
	QUANJURE_CONJURE = "Herbeizaubern";
	QUANJURE_CONJURE_WATER = "Wasser herbeizaubern";
	QUANJURE_CONJURE_FOOD = "Essen herbeizaubern";
	QUANJURE_CONJURE_RANK = "Rang";
	QUANJURE_CONJURE_RUBY = "Manarubin herbeizaubern";
	QUANJURE_CONJURE_CITRINE = "Manacitrin herbeizaubern";
	QUANJURE_CONJURE_JADE = "Manajadestein herbeizaubern";
	QUANJURE_CONJURE_AGATE = "Manaachat herbeizaubern";
	QUANJURE_RUBY = "Manarubin";
	QUANJURE_CITRINE = "Manacitrin";
	QUANJURE_JADE = "Manajadestein";
	QUANJURE_AGATE = "Manaachat";
	QUANJURE_GEM_OPTIONS = "Anzahl der herbeizuzaubernden Manaedelsteine"; 
	QUANJURE_GEM_OPTIONS_SHORT = "Edelsteine:"; 

	QUANJURE_TARGETCONJURE_SETUP = "Target dependant conjuring";
	QUANJURE_TARGETCONJURE_TOOLTIP = "Enables conjuring for your current target's level and class.";
	QUANJURE_TRADECONJURE_SETUP = "Trade dependant conjuring";
	QUANJURE_TRADECONJURE_TOOLTIP = "Enables trading and conjuring for your current trade target's level and class."
	
	QUANJURE_REAGENTS = "Autoreagenzien";
	QUANJURE_REAGENTS_ENABLED = "Autoreagenzien aktiviert."; 
	QUANJURE_REAGENTS_DISABLED = "Autoreagenzien deaktiviert - Derzeitiger Charakter ist kein Magier." 
	QUANJURE_REAGENTS_POWDER = "Arkanes Pulver";
	QUANJURE_REAGENTS_TELEPORT = "Rune der Teleportation";
	QUANJURE_REAGENTS_PORTAL = "Rune der Portale";
	QUANJURE_REAGENTS_ARCANEBRILLIANCE = "Arkane Brillanz";
	QUANJURE_REAGENTS_CURRENCY = {"G","S","K"};
	QUANJURE_POWDER_OPTIONS = "Anzahl der einzukaufenden Stacks des Arkanen Pulvers"; 
	QUANJURE_POWDER_OPTIONS_SHORT = "Pulver:"; 
	QUANJURE_TELEPORT_OPTIONS = "Anzahl der einzukaufenden Stacks der Rune der Teleportation"; 
	QUANJURE_TELEPORT_OPTIONS_SHORT = "Teleporte:"; 
	QUANJURE_PORTAL_OPTIONS = "Anzahl der einzukaufenden Stacks der Rune der Portale"; 
	QUANJURE_PORTAL_OPTIONS_SHORT = "Portale:";
	
	QUANJURE_EVOCATION = "Hervorrufung"; -- Name of the Evocation Spell
	QUANJURE_EVOCATION_WARNING = "Hervorrufung nicht gefunden - wird abgebrochen."; 
	QUANJURE_EVOCATION_CHECKBOX = "Einmal-Klick Hervorrufung"; 
	QUANJURE_EVOCATION_SETUP = "Hervorrufungs Einstellungen";
	QUANJURE_EVOCATION_MAINHAND = "Haupthand";
	QUANJURE_EVOCATION_OFFHAND = "Nebenhand";
	QUANJURE_EVOCATION_WAND = "Zauberstab";
	QUANJURE_EVOCATION_HELP = "Waffen mit Willenskraft, die w\195\164hrend der Hervorrufung benutzt werden, in die gew\195\188nschten Felder ziehen.";
	QUANJURE_EVOCATION_MACRO_HELP = "Das Folgende in ein Macro kopieren/einf\195\188gen, oder eine Taste in der Tastaturbelegungen einstellen, um Quanjure's Hervorrufung zu benutzen.";
	QUANJURE_EVOCATION_TOOLTIP = "|cFFFFFFFFDreifach-Klick Version:|r\n- Erster Klick zieht Waffen mit Willenskraft an.\n- Zweiter Klick (nach globalen Cooldown) beschw\195\182rt Hervorrufung.\n- Dritter Klick zieht die Waffen ohne Willenskraft wieder an.\n\n|cFFFFFFFFEinmal-Klick Version:|r\nZieht Waffen mit Willenskraft sofort nach Beginn der Hervorrufung an und zieht wieder\ndie normalen Waffen an, sobald weniger als 1.6 Sekunden der Kanalisierung \195\188brig sind.\nKann verursachen, dass der Anfang der Hervorrufung ohne Waffen mit Willenskraft ablaufen kann.";
	QUANJURE_INNERVATE = "Anregen";
	QUANJURE_INNERVATE_CHECKBOX = "F\195\188r Anregen benutzen"; 
	QUANJURE_INNERVATE_TOOLTIP = "Automatisches Anziehen von Waffen mit Willenskraft w\195\164hrend der Anregung."; 
	QUANJURE_DRINKING_CHECKBOX = "F\195\188r essen und trinken benutzen";
	QUANJURE_DRINKING_TOOLTIP = "Automatisches Anziehen von Waffen mit Willenskraft w\195\164hrend essen und trinken.";
	QUANJURE_DRINKING_EXCLUDE_HELP = "Enter any zones where you wish to |cFFFFFFFFoverride|r the current setting. Seperate by comma. \n\n|cFFFFFFFFExample:|r Arathi Basin, Alterac Valley\n|cFFFFFFFFCurrent Zone:|r "
	QUANJURE_DARKMOON = "Aura des blauen Drachen";
	QUANJURE_DARKMOON_CHECKBOX = "Dunkelmond-Karte: Blauer Drache";
	QUANJURE_DARKMOON_TOOLTIP = "Automatisches Anziehen von Waffen mit Willenskraft\nw\195\164hrend Blauen Drachen proc.";

	QUANJURE_PORTALS_TELEPORT = "Teleportieren"
	QUANJURE_PORTALS_PORTAL = "Portal"
	QUANJURE_PORTALS_TELEPORT_WARNING = "Zaubert Teleport in einer Gruppe!";
	QUANJURE_PORTALS_PORTAL_WARNING = "Zaubert Portal ausserhalb einer Gruppe!";
	QUANJURE_PORTALS_SINGULAR = "Rune"; -- 1 rune
	QUANJURE_PORTALS_PLURAL = "Runen"; -- 2 runes
	QUANJURE_PORTALS_ALLIANCE = {"Ironforge", "Stormwind", "Darnassus"};
	QUANJURE_PORTALS_HORDE = {"Orgrimmar", "Undercity", "Thunder Bluff"};

	QUANJURE_DISMOUNTING = "Absitzen..."; 
	
	QUANJURE_MISC_TITLE = "Verschiedene Teleporter";
	QUANJURE_MISC_ENGINEER = {"Extrem sicherer Transporter: Gadgetzan", "Dimensionszerfetzer - Everlook"};
	QUANJURE_MISC_SPELLS = {"Astraler R\195\188ckruf", "Teleportieren: Moonglade"}
	QUANJURE_MISC_BG_HORDE = {
		"Abzeichen der Frostwolf Rang 6",
		"Abzeichen der Frostwolf Rang 5",
		"Abzeichen der Frostwolf Rang 4",
		"Abzeichen der Frostwolf Rang 3",
		"Abzeichen der Frostwolf Rang 2",
		"Abzeichen der Frostwolf Rang 1"
	};
	QUANJURE_MISC_BG_ALLIANCE = {
		"Abzeichen der Stormpike Rang 6",
		"Abzeichen der Stormpike Rang 5",
		"Abzeichen der Stormpike Rang 4",
		"Abzeichen der Stormpike Rang 3",
		"Abzeichen der Stormpike Rang 2",
		"Abzeichen der Stormpike Rang 1"
	};

	QUANJURE_WARRIOR = "Krieger";
	QUANJURE_ROGUE = "Schurke";
	QUANJURE_HUNTER = "J\195\164ger";
	QUANJURE_MAGE = "Magier";
	QUANJURE_WARLOCK = "Hexenmeister";
	QUANJURE_DRUID = "Druide";
	QUANJURE_PRIEST = "Priester";
	QUANJURE_SHAMAN = "Schamane";
	QUANJURE_PALADIN = "Paladin";
	
	QUANJURE_NOTFOUND = "nicht gefunden."
end