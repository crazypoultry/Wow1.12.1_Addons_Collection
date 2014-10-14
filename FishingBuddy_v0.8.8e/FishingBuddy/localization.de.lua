-- Deutsche
--            lower      upper
-- a umlaut   \195\164   \195\132
-- o umlaut   \195\192   \195\150
-- u umlaut   \195\188   \195\156

FishingTranslations["deDE"] = {
   NAME = "Fishing Buddy",
   DESCRIPTION1 = "\195\188bersicht, wo welche Fische gefangen wurden",
   DESCRIPTION2 = "und Handhabung deiner Fischereiausr\195\188stung.",

   -- Tab labels and tooltips
   LOCATIONS_INFO = "Anzeige von Fischen nach Fanggebieten",
   LOCATIONS_TAB = "Fische",
   OUTFITS_INFO = "W\195\164hlen aus, was du beim Fischen tragen willst",
   OUTFITS_TAB = "Ausr\195\188stung",
   OPTIONS_INFO = NAME.." Einstellungen",
   OPTIONS_TAB = "Einstellungen",
   TRACKING_INFO = "Zeige graphische #NAME#-Anzeige der letzten F\195\164nge",
   TRACKING_TAB = "Saisonfische",

   POINT = "Punkt",
   POINTS = "Punkte",

   RAW = "Roher",
   FISH = "Fische",

   BOBBER_NAME = "Blinker",
   FISHINGSKILL = "Angeln",
   HELP = "Hilfe",
   SWITCH = "wechseln",
   IMPORT = "importiere",
   TRACK = "Aufzeichnung",
   NOTRACK = "Aufzeichnung-nicht",
   TRACKING = "aufzeichnen",

   -- Thanks Maischter!
   SCHOOL = "Schwarm",  -- e.g. '\195\150lige Schwarzmaul Schwarm'
   FLOATING_WRECKAGE = "Schwimmende Wrackteile",
   FLOATING_DEBRIS = "Schwimmende Tr\195\188mmer",
   ELEM_WATER = "Elementarwasser",
   OIL_SPILL = "\195\150lpest",

   ADD = "hinzuf\195\188gen",
   REPLACE = "ersetze",
   UPDATE = "update",
   CURRENT = "Session",
   RESET = "reset",
   CLEANUP = "cleanup",
   CHECK = "check",
   NOW = "now",

   WATCHER = "Watcher",
   WATCHER_LOCK = "fixieren",
   WATCHER_UNLOCK = "freigeben",

   UNKNOWN = "unbekannt",
   WEEKLY = "w\195\182chentlich",
   HOURLY = "st\195\188ndlich",

   SHOWFISHIES = "Nach Fischnamen",
   SHOWFISHIES_INFO = "Anzeigen Fischlog gruppiert nach Fischart.",
   SHOWLOCATIONS = "Nach Fanggebieten",
   SHOWLOCATIONS_INFO = "Anzeigen Fischlog gruppiert nach Fanggebiet.",
   SWITCHOUTFIT = "Ausr\195\188stung wechseln",
   SWITCHOUTFIT_INFO = "Schalter zwischen der Fischereiausstattung und was Sie vorher trugen.",

   -- Option names and tooltips
   CONFIG_SHOWNEWFISHIES_ONOFF = "Zeige neue Fische",
   CONFIG_SHOWNEWFISHIES_INFO  = "Zeigt im Chat-Log an, wenn ein neuer Fisch an der gegenw\195\164rtige Position gefangen wird.",
   CONFIG_FISHWATCH_ONOFF      = "Fisch-W\195\164chter",
   CONFIG_FISHWATCH_INFO	 = "Zeigt in einer eigenen Chat-Anzeige die Fische an, die an der gegenw\195\164rtigen Location gefangen wurden.",
   CONFIG_FISHWATCHSKILL_ONOFF = "Zeige Fishing-Skill an",
   CONFIG_FISHWATCHSKILL_INFO = "Zeigt deinen gegenw\195\164rtigen Fishing-Skill im Fanggebiet an.",
   CONFIG_FISHWATCHZONE_ONOFF      = "Zone des Fanggebietes",
   CONFIG_FISHWATCHZONE_INFO	= "Zeigt die gegenw\195\164rtige Zone im Fanggebiet an.",
   CONFIG_FISHWATCHONLY_ONOFF   = "Nur beim Fischen",
   CONFIG_FISHWATCHONLY_INFO	 = "Anzeige nur beim Fischen",
   CONFIG_FISHWATCHPERCENT_ONOFF   = "Prozent je Fischart",
   CONFIG_FISHWATCHPERCENT_INFO	 = "Zeigt den Prozentsatz der gefangenen Fische je Fischart in der Anzeige",
   CONFIG_ONLYMINE_ONOFF		 = "Angel der Fischeriausr\195\188stung",
   CONFIG_ONLYMINE_INFO		 = "Wenn aktiviert, wird \"Einfaches Werfen\" nur die Angel der aktuellen Fischereiausr\195\188stung checken (nicht nach weitern/besseren Angeln suchen).",
   CONFIG_EASYLURES_ONOFF		 = "Automatischer K\195\182der",
   CONFIG_EASYLURES_INFO		 = "Wenn aktiviert, wird falls erforderlich ein K\195\182der an der Angel angebracht, bevor man mit dem Angeln beginnt.",
   CONFIG_SHOWLOCATIONZONES_ONOFF	= "Zeige Zonen",
   CONFIG_SHOWLOCATIONZONES_INFO	= "Zeigt Zonen und Sub-Zonen an.",
   CONFIG_SORTBYPERCENT_ONOFF	= "Sortiere nach Anzahl gefangener Fische",
   CONFIG_SORTBYPERCENT_INFO	= "Anzeige sortiert nach Zahl der gefangenen Fische, anstelle von Fischnamen.",
   CONFIG_STVTIMER_ONOFF		= "Angelwettbewerb-Timer.",
   CONFIG_STVTIMER_INFO		= "Wenn Sie erm\195\182glicht werden, zeigen Sie einen Countdowntimer f\195\188r den Anfang des Fischens Extravaganza und ein Countdown vom Timer nach links an.",
   CONFIG_USEBUTTONHOLE_ONOFF	= "Verwenden Sie ButtonHole",
   CONFIG_USEBUTTONHOLE_INFO	= "Wenn es erm\195\182glicht wird, steuert das ButtonHole-addon die minimaptaste.  Nehmen bewirkt auf dem folgenden LOGON.",

   CONFIG_SKILL_INFO	 = "Gesamtausstattungs-Bonus.",
   CONFIG_SKILL_TEXT	 = "Angeln ",
   CONFIG_STYLISH_INFO		 = "Styling-Punkte, inspiriert durch die Draznars Fishing-FAQ auf den (englischen) WoW-Foren.",
   CONFIG_STYLISH_TEXT		 = "Styling: ",

   CLICKTOSWITCH_ONOFF	= "Zum Wechseln der Ausr\195\188stung klicken.",
   CLICKTOSWITCH_INFO	= "Wenn aktiviert, wechselt ein Linksklcik die Ausr\195\188stung, statt nur das #NAME#-Fenster zu \195\182ffnen.",

   LEFTCLICKTODRAG = "Link-Klicken zum Schleppen",

   MINIMAPBUTTONPLACEMENT = "Ikon-Plazierung",
   MINIMAPBUTTONPLACEMENTTOOLTIP = "Erlaubt dir, das #NAME#-Ikon um die Minimap zu verschieben",
   CONFIG_MINIMAPBUTTON_ONOFF	= "Anzeigen des Minimapikons",
   CONFIG_MINIMAPBUTTON_INFO	= "Zeige #NAME#-Ikon auf der Minimap an.",

   CONFIG_ENHANCESOUNDS_ONOFF      = "Erh\195\182hen Sie Fischent\195\182ne",
   CONFIG_ENHANCESOUNDS_INFO       = "Maximieren Sie Klangvolumen und setzen Sie umgebende Ausgabe herab, um das bobber noise zu lassen wahrnehmbareres beim Fischen.",

   -- messages
   FAILEDINIT = "Initialisierte nicht richtig.",
   IMPORTMSG = "Importierte '%s'-Datenbank.",
   NOIMPORTMSG = "Datenbanken Impp, DataFish oder FishInfo2 nicht gefunden.",
   ADDFISHIEMSG = "Hinzuf\195\188gen von %s Position %s.",
   CURSORBUSY = "Konnte Ausr\195\188stung nicht wechseln, da Computer mit anderen Aktivit\195\164ten besch\195\164ftigt!",
   NOOUTFITDEFINED = "Sie haben keine Ausr\195\188stungsteile in Ihrer Fischenausstattung angegeben.",
   NODATAMSG = "Keine Fischdaten vorhanden.",
   TRACKINGMSG = "Aufzeichnung '%s' (%s).",
   TOOFASTMSG = "Kann Ausr\195\188stung nicht schnell wechseln.",
   NOTRACKERRMSG = "Kann nicht R\195\188ckstellung saisonfisch entfernen.",
   NOTRACKMSG = "Saisonfisch '%s' entfernt.",
   POLEALREADYEQUIPPED = "Sie werden bereits f\195\188r Fischen ausger\195\188stet.",
   CANTSWITCHBACK = "Sie haben bereits Ihre Fischenausr\195\188stung entfernt.",
   CLEANUP_NONEMSG = "Keine alten Einstellungen bleiben.",
   CLEANUP_WILLMSG = "Alte Einstellungen restlich f\195\188r |c#GREEN#%s|r: %s.",
   CLEANUP_DONEMSG = "Alte Einstellungen entfernt f\195\188r |c#GREEN#%s|r: %s.",
   CLEANUP_NOOLDMSG = "Es gibt keine alten Einstellungen f\195\188r Spieler  |c#GREEN#%s|r.",

   NOTLINKABLE = "<Einzelteil ist nicht verbindbar>",

   TIMETOGO = "Angelwettbewerb beginnt in %d:%02d",
   TIMELEFT = "Angelwettbewerb endet in %d:%02d",

   STVZONENAME = "Stranglethorn",

   TOOLTIP_HINT = "Hinweis:";
   TOOLTIP_HINTSWITCH = "wechselt ein Linksklcik die Ausr\195\188stung",
   TOOLTIP_HINTTOGGLE = "das #NAME#-Fenster zu \195\182ffnen.",

   -- Key binding support
   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "#NAME# anzeigen",
   BINDING_NAME_FISHINGBUDDY_SWITCH = "Ausr\195\188stung wechseln",

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "#NAME# Zonen-Fenster anzeigen",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "#NAME# Outfit-Fenster anzeigen",
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "#NAME# Tracking-Fenster anzeigen",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "#NAME# Optionen-Fenster anzeigen",
};

FishingTranslations["deDE"].IMPORT_HELP = {
   "|c#GREEN#/fb #IMPORT#|r",
   "    Importiere Impp's Fishinfo or FishInfo2 Daten.",
};

FishingTranslations["deDE"].SWITCH_HELP = {
   "|c#GREEN#/fb #SWITCH#|r",
   "    wechsele deine Fischereiausr\195\188stung und -kleidung.",
};

FishingTranslations["deDE"].WATCHER_HELP = {
   "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r oder |c#GREEN##WATCHER_UNLOCK#|r oder |c#GREEN##RESET#|r]",
   "    fixieren .. Fixieren des Watcher-Fenster,",
   "    freigeben .. Entriegeln zum Verschieben,",
   "    reset .. Zur\195\188ckstellen",
};

FishingTranslations["deDE"].CURRENT_HELP = {
      "|c#GREEN#/fb #CURRENT# #RESET#|r",
      "   Zur\195\188ckstellen der w\195\164hrend der gegenw\195\164rtigen Session gefangenen Fische.",
   };
FishingTranslations["deDE"].CLEANUP_HELP = {
   "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN##CHECK#|r or |c#GREEN##NOW#|r]",
   "    S\195\164ubern Sie herauf alte Einstellungen. |c#GREEN##CHECK#|r verzeichnet",
   "    die alten Einstellungen, die von |c#GREEN##NOW#|r entfernt werden.",
};

FishingTranslations["deDE"].TRACKING_HELP = {
   "|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r oder |c#GREEN##WEEKLY#|r] |c#PURPLE#<Fish-Link>|r",
   "    zeichne die Angeldauer f\195\188r die angegebenen",
   "    Fischart (ein Shift-Klick Link) auf",
   "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
   "    remove the specified fish (a shift click link) from the tracker",
   "|c#GREEN#/fb #TRACKING#|r",
   "    eine einfache Anzeige, wann die gefangenen",
   "    Fische gefangen wurden",
};

FishingTranslations["deDE"].PRE_HELP = {
   "Du kannst |c#GREEN#/fishingbuddy|r oder |c#GREEN#/fb|r f\195\188r alle Befehle benutzen",
   "|c#GREEN#/fb|r: schaltet das Fenster ein/aus.",
   "|c#GREEN#/fb #HELP#|r: zeigt diesern Hilfetext",
};
FishingTranslations["deDE"].POST_HELP = {
   "Du kannst die Fensteraktivierung und den",
   "Befehl zum Wechseln deiner Ausstattung in den",
   "\"Tastaturbelegungen\" festlegen.",
};
