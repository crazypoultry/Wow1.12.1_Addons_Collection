-------------------------------------------------------------------------------
-- German
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then

-- Bindings
BINDING_HEADER_BFC_HEADER = "Battlefield Commander";
BINDING_NAME_BFC_GLOBALCOMMSMENU = "Kommunikationsmen\195\188: Allgemein";
BINDING_NAME_BFC_LOCALCOMMSMENU = "Kommunikationsmen\195\188: Orte";
BINDING_NAME_BFC_TOGGLEMAP = "Karte ein- bzw. ausblenden";
BINDING_NAME_BFC_VIEWMAP = "Karte einblenden";

BFC_Strings = {
	bfcommander = "Battlefield Commander",
};

-- Tab dropdown menu
BFC_Strings.Menu = {
	narrowmode = "Schmale Ansicht",
	autoshowbg = "Auf Schlachtfeldern automatisch \195\182ffnen",
	options = "Einstellungen...",
};


-- Log message prefixes
BFC_Strings.LogPrefix = {
	"<BFC>Debug: ",
	"<BFC>Warnung: ",
	"<BFC>Fehler: ",
	"<BFC> ",
};

-- Error messages
BFC_Strings.Errors = {
	cannotshow = "BFC kann in Instanzen nicht angezeigt werden.",
	notingroup = "Ihr m\195\188sst Teil einer Gruppe bzw. Schlachtgruppe sein, um diese Funktion nutzen zu k\195\182nnen.",

	-- timer
	uninitialized = "Ein zu startender Timer wurde nicht initialisiert. Zuerst SetTime verwenden.",

	-- common
	modinuse = "Modul %q kann nicht registriert werden: Name wird bereits verwendet.",
	unknownmodtype = "Modul %q kann nicht registriert werden: Unbekannter Typ %q.",
	nomodname = "Modul kann nicht registriert werden: Kein Name und/oder Typ gefunden.",
	noupdatefunc = "Keine Updatefunktion mit dem Namen %q ist registriert.",
	updatefuncregistered = "Eine Updatefunktion mit dem Namen %q ist bereits registriert.",
	
	-- comms
	ccpairregistered = "Das Komponenten-Befehlspaar %q ist bereits registriert.",
	noccpairregistered = "Kein Komponenten-Befehlspaar %q ist registriert.",
	
	-- radio
	msgnotfound = "Nachricht wurde nicht gefunden.",

	--options
	defaultoptions = "Standardeinstellungen geladen",

	-- info frame
	nilobject = "nil-Objekte kann nicht registriert werden.",
};

-- Options interface
BFC_Strings.Options = {
	nooptions = "Dieses Modul verf\195\188gt \195\188ber keine Einstellungen.",
};

BFC_Strings.Factions = {
	alliance = "Allianz",
	horde = "Horde",
};

-- General battleground plugin stuff
BFC_Strings.BG_Base = {
	elapsed = "Verstrichene Zeit: %s min",
	acount = "Ap: %s",
	hcount = "Hp: %s",
	apug = "As: %s%%",
	hpug = "Hs: %s%%",
	apugheader = "Server der Allianzspieler",
	hpugheader = "Server der Hordespieler",
	players = "Spieler",
	team = "Team",
};


-- Info frame dropdown
BFC_Strings.InfoFrame = {
	lock = "Fenster fixieren",
	hidedefaultscore = "Blizzard-Punkteanzeige ausblenden",
	hideborder = "Rahmen ausblenden",
	hideframe = "Fenster ausblenden",
	cancel = "Abbrechen",
};


-- Things that the WSG herald yells
BFC_Strings.WSG = {
	modname = "Plugin: Warsongschlucht",
	zone = "Warsongschlucht",

	event_picked = "([^%s]+) hat die Flagge der [^%s]+ aufgenommen!",
	event_dropped = "fallen lassen",
	event_returned = "zur\195\188ckgebracht",
	event_captured = "errungen",
	event_placed = "aufgestellt",
	
	
	atbase = "In der Basis",
	dropped = "Fallen gelassen",
	unknown = "Unbekannt",
	captured = "Errungen",
	
	rezwavedefault = "Wiederbelebung in: ??",
	rezwave = "Wiederbelebung in: %ss",

	scorestring = "Punkte: %s/%s",
	score = "Punkte",
};


-- Arathi Basin stuff
BFC_Strings.AB = {
	modname = "Plugin: Arathibecken",
	zone = "Arathibecken",
	
	event_assaulted = "hat d?[eia]?[nes]? ?(.+) angegriffen!",
	event_taken = "hat d?[eia]?[nes]? ?(.+) eingenommen!",
	event_defended = "hat d?[eia]?[nes]? ?(.+) verteidigt!",
	event_claims = "hat d?[eia]?[nes]? ?(.+) besetzt!",
	
	-- These have changed!! They should now match the text you see when you mouse
	-- over the node on the main map.
	farm = "Hof",
	blacksmith = "Schmied",
	mill = "S\195\164gewerk",
	stables = "St\195\164lle",
	mine = "Goldmine",
	trollbane = "Trollbanes Halle",
	defilers = "Die entweihte Feste",
	
	rezloc = "Rez bei: %s",
	
	scorestring = "Punkte: %s/%s",
	score = "Punkte",
	scorepattern = "Basen: (%d)  Ressourcen: (%d+)/2000",
	alliancetimetowin = "Die Allianz siegt in",
	hordetimetowin = "Die Horde siegt in",
	basestowin = "Zum Sieg ben\195\182tigte Basen",
};

-- These need to exactly match the text in the event strings above
BFC_Strings.AB_Nodes = {
	farm = "Hof",
	blacksmith = "Schmiede",
	mill = "S\195\164gewerk",
	stables = "St\195\164lle",
	mine = "Mine",
};

-- AB options dropdown
BFC_Strings.AB_Options = {
	showscore = "Punktzahl anzeigen",
	lockwindow = "Fenster fixieren",
	showtimers = "Timer anzeigen",
	hidewindow = "|c00FF8080Fenster ausblenden|r",
	hidescoreboard = "Punktzahl ausblenden",
};

-- The names of the classes
BFC_Strings.Classes = {
	WARLOCK = "Hexenmeister",
	WARRIOR = "Krieger",
	HUNTER = "J\195\164ger",
	MAGE = "Magier",
	PRIEST = "Priester",
	DRUID = "Druide",
	PALADIN = "Paladin",
	SHAMAN = "Schamane",
	ROGUE = "Schurke",
}

-- Just a plain old array with up to 5 entries, same for the zone-specific ones
BFC_Strings.CommsMenu = {
	"Feind gesichtet!",
	"Situation unter Kontrolle.",
	"Brauche Verst\195\164rkung!",
	"Verstanden.",
	"Negativ.",
}

-- gulch-specific comms menu
BFC_Strings.CommsMenu_WSG = {
	"Rampe",
	"Tunnel",
	"Friedhof",
	"Flaggenraum",
	"Balkon",
	"Dach",
	"Mitte",
}

BFC_Strings.CommsMenu_AB = {
	BFC_Strings.AB.blacksmith,
	BFC_Strings.AB.farm,
	BFC_Strings.AB.mill,
	BFC_Strings.AB.mine,
	BFC_Strings.AB.stables,
};

end
