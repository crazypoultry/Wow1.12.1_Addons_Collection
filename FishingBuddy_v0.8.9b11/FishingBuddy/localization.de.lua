-- Deutsche
--            lower      upper
-- a umlaut   \195\164   \195\132
-- o umlaut   \195\192   \195\150
-- u umlaut   \195\188   \195\156

FishingTranslations["deDE"] = {
   NAME = "Fishing Buddy",
   DESCRIPTION1 = "\195\156bersicht, wo welche Fische gefangen wurden",
   DESCRIPTION2 = "und Handhabung deiner Fischereiausr\195\188stung.",

   -- Tab labels and tooltips
   LOCATIONS_INFO = "Anzeige von Fischen nach Fanggebieten",
   LOCATIONS_TAB = "Fische",
   OPTIONS_INFO = NAME.."-Einstellungen",
   OPTIONS_TAB = "Einstellungen",

   POINT = "Punkt",
   POINTS = "Punkte",

   RAW = "Roher",
   FISH = "Fische",

   BOBBER_NAME = "Blinker",
   FISHINGSKILL = "Angeln",
   HELP = "Hilfe",
   SWITCH = "wechseln",
   IMPORT = "importiere",

   -- Thanks Maischter!
   SCHOOL = "schwarm",  -- e.g. '\195\150lige Schwarzmaul Schwarm'
   FLOATING_WRECKAGE = "Schwimmende Wrackteile",
   FLOATING_DEBRIS = "Schwimmende Tr\195\188mmer",
   ELEM_WATER = "Elementarwasser",

   ADD = "hinzuf\195\188gen",
   REPLACE = "ersetze",
   UPDATE = "update",
   CURRENT = "Session",
   RESET = "reset",
   CLEANUP = "cleanup",
   CHECK = "check",
   NOW = "now",
   
   NOREALM = "unbekannter Realm",

   WATCHER = "Watcher",
   WATCHER_LOCK = "fixieren",
   WATCHER_UNLOCK = "freigeben",

   UNKNOWN = "unbekannt",
   WEEKLY = "w\195\182chentlich",
   HOURLY = "st\195\188ndlich",
   
   OFFSET_LABEL_TEXT = "Versatz:";

   KEYS_LABEL_TEXT = "Umschalter:",
   KEYS_NONE_TEXT = "Keiner",
   KEYS_SHIFT_TEXT = "Shift",
   KEYS_CTRL_TEXT = "Strg",
   KEYS_ALT_TEXT = "Alt",
   
   SHOWFISHIES = "Nach Fischnamen",
   SHOWFISHIES_INFO = "Fisch-Log nach Fischart gruppiert anzeigen.",
   SHOWLOCATIONS = "Nach Fanggebieten",
   SHOWLOCATIONS_INFO = "Fisch-Log nach Fanggebiet gruppiert anzeigen.",
   SWITCHOUTFIT = "Ausr\195\188stung wechseln",
   SWITCHOUTFIT_INFO = "Zwischen der Angelausr\195\188stung und der vorherigen umschalten.",

   -- Option names and tooltips
   CONFIG_SHOWNEWFISHIES_ONOFF = "Zeige neue Fische",
   CONFIG_SHOWNEWFISHIES_INFO  = "Zeigt im Chat-Log an, wenn ein neuer Fisch an der gegenw\195\164rtigen Position gefangen wird.",
   CONFIG_FISHWATCH_ONOFF      = "Fisch-W\195\164chter",
   CONFIG_FISHWATCH_INFO	 = "Zeigt in einer eigenen Chat-Anzeige die Fische an, die an der gegenw\195\164rtigen Position gefangen wurden.",
   CONFIG_FISHWATCHSKILL_ONOFF = "Zeige Angelskill an",
   CONFIG_FISHWATCHSKILL_INFO = "Zeigt deinen gegenw\195\164rtigen Angelskill in der \195\156bersicht an.",
   CONFIG_FISHWATCHZONE_ONOFF      = "Zone des Fanggebietes",
   CONFIG_FISHWATCHZONE_INFO	= "Zeigt die gegenw\195\164rtige Zone in der \195\156bersicht an.",
   CONFIG_FISHWATCHONLY_ONOFF   = "Nur beim Fischen",
   CONFIG_FISHWATCHONLY_INFO	 = "Anzeige nur beim Fischen",
   CONFIG_FISHWATCHPERCENT_ONOFF   = "Prozent je Fischart",
   CONFIG_FISHWATCHPERCENT_INFO	 = "Zeigt den Prozentsatz der gefangenen Fische je Fischart in der Anzeige.",
   CONFIG_SUITUPFIRST_ONOFF      = "Dress for success",
   CONFIG_SUITUPFIRST_INFO       = "Angelausrstung anlegen, wenn Du sie nicht tr\195\164gst, sobald die festgelegte Taste gedr\195\188ckt wird.",
   CONFIG_EASYCAST_ONOFF	 = "\"Einfaches Werfen\"",
   CONFIG_EASYCAST_INFO		 = "Wenn aktiviert, und eine Angel angelegt ist, wird bei einem Rechtsklick die Leine ausgeworfen.",
   CONFIG_ONLYMINE_ONOFF		 = "Nur die Angel anlegen",
   CONFIG_ONLYMINE_INFO		 = "Wenn aktiviert, wird \"Einfaches Werfen\" nur die Angel der aktuellen Fischereiausr\195\188stung checken (d.h. es sucht nicht nach weiteren/besseren Angeln).",
   CONFIG_EASYLURES_ONOFF		 = "Automatischer K\195\182der",
   CONFIG_EASYLURES_INFO		 = "Wenn aktiviert, wird (falls erforderlich) ein K\195\182der an der Angel angebracht, bevor man mit dem Angeln beginnt.",
   CONFIG_MOUSEFISHING_ONOFF	 = "Maus-Angeln",
   CONFIG_MOUSEFISHING_INFO	     = "Wenn aktiviert, wirft ein Linksklick die Leine aus und mit Rechtsklick wird der Fang eingeholt.",
   CONFIG_SHOWLOCATIONZONES_ONOFF	= "Zeige Zonen",
   CONFIG_SHOWLOCATIONZONES_INFO	= "Zeigt Zonen und Sub-Zonen an.",
   CONFIG_SORTBYPERCENT_ONOFF	= "Sortiere nach Anzahl gefangener Fische",
   CONFIG_SORTBYPERCENT_INFO	= "Anzeige sortiert nach Zahl der gefangenen Fische, anstelle von Fischnamen.",
   CONFIG_STVTIMER_ONOFF		= "Angelwettbewerb-Timer.",
   CONFIG_STVTIMER_INFO		= "Wenn aktiviert, wird je ein Countdown f\195\188r den Anfang und das Ende des Angelwettbewerbs angezeigt.",
   CONFIG_STVPOOLSONLY_ONOFF	= "Nur in Schw\195\164rme auswerfen",
   CONFIG_STVPOOLSONLY_INFO	= "Wenn aktiviert, wird \"Einfaches Werfen\" nur dann verwendet, wenn der Mauszeiger auf einen Schwarm zeigt.",
   CONFIG_USEBUTTONHOLE_ONOFF	= "ButtonHole verwenden",
   CONFIG_USEBUTTONHOLE_INFO	= "Wenn es erm\195\182glicht wird, steuert das ButtonHole-addon die minimaptaste.  Nehmen bewirkt auf dem folgenden LOGON.",
   CONFIG_USEGATHERER_ONOFF	= "Gatherer verwenden",
   CONFIG_USEGATHERER_INFO	= "Wenn aktiviert, werden Schw\195\164rme von #NAME# im Gatherer eingetragen.",
   CONFIG_SKILL_INFO	 = "Gesamtbonus durch Ausr\195\188stung.",
   CONFIG_SKILL_TEXT	 = "Angeln ",
   CONFIG_STYLISH_INFO		 = "Styling-Punkte, inspiriert durch die Draznars Fishing-FAQ in den (englischen) WoW-Foren.",
   CONFIG_STYLISH_TEXT		 = "Styling: ",

   TITAN_CLICKTOSWITCH_ONOFF	= "Zum Wechseln der Ausr\195\188stung klicken.",
   TITAN_CLICKTOSWITCH_INFO	= "Wenn aktiviert, wechselt ein Linksklick die Ausr\195\188stung, ansonsten \195\182ffnet sich das #NAME#-Fenster.",

   LEFTCLICKTODRAG = "Linksklick zum Ziehen",
   RIGHTCLICKFORMENU = "Rechtsklick \195\182ffnet das Men\195\188.",
   WATCHERCLICKHELP = "#LEFTCLICKTODRAG#\n#RIGHTCLICKFORMENU#",
   
   MINIMAPBUTTONPLACEMENT = "Plazierung des Icons",
   MINIMAPBUTTONPLACEMENTTOOLTIP = "Erlaubt Dir, das #NAME#-Icon um die Minimap zu verschieben.",
   CONFIG_MINIMAPBUTTON_ONOFF	= "Anzeigen des Minimap-Icons",
   CONFIG_MINIMAPBUTTON_INFO	= "Zeige das #NAME#-Icon an der Minimap an.",

   CONFIG_ENHANCESOUNDS_ONOFF = "Angel-Ger\195\164usche verst\195\164rken",
   CONFIG_ENHANCESOUNDS_INFO = "Maximiere Gesamtlautst\195\164rke und reduziere die Umgebungslautst\195\164rke, um das Pl\195\164tschern des K\195\182ders besser wahrnehmen zu k\195\182nnen.",
   
   -- messages
   COMPATIBLE_SWITCHER = "Kein kompatibles Ausr\195\188stungs-Wechsel-Addon gefunden.",
   FAILEDINIT = "Nicht richtig initialisiert.",
   IMPORTMSG = "'%s'-Datenbank importiert.",
   NOIMPORTMSG = "Datenbanken Impp, DataFish oder FishInfo2 nicht gefunden.",
   ADDFISHIEMSG = "F\195\188ge %s an Position %s hinzu.",
   ADDSCHOOLMSG = "F\195\188ge '%s' an Position %s hinzu.",
   NODATAMSG = "Keine Fischdaten vorhanden.",
   TOOFASTMSG = "Kann Ausr\195\188stung nicht schnell wechseln.",
   CLEANUP_NONEMSG = "Keine alten Einstellungen zur\195\188ckbehalten.",
   CLEANUP_WILLMSG = "Alte Einstellungen verblieben f\195\188r |c#GREEN#%s|r: %s.",
   CLEANUP_DONEMSG = "Alte Einstellungen entfernt f\195\188r |c#GREEN#%s|r: %s.",
   CLEANUP_NOOLDMSG = "Es gibt keine alten Einstellungen f\195\188r Spieler |c#GREEN#%s|r.",
   NONEAVAILABLE_MSG = "Keine verf\195\188gbar",
   UPDATEDB_MSG = "%d Fischnamen aktualisiert.",
   
   NOTLINKABLE = "<Einzelteil ist nicht verbindbar>",

   TIMETOGO = "Angelwettbewerb beginnt in %d:%02d",
   TIMELEFT = "Angelwettbewerb endet in %d:%02d",

   STVZONENAME = "Schlingendorntal",

   TOOLTIP_HINT = "Hinweis:";
   TOOLTIP_HINTSWITCH = "wechselt ein Linksklick die Ausr\195\188stung",
   TOOLTIP_HINTTOGGLE = "Linksklick \195\182ffnet das #NAME#-Fenster.",

   -- Key binding support
   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "#NAME# anzeigen",
   BINDING_NAME_FISHINGBUDDY_SWITCH = "Ausr\195\188stung wechseln",

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "Zonen-Fenster anzeigen",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "Outfit-Fenster anzeigen",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "Optionen-Fenster anzeigen",
};

FishingTranslations["deDE"].IMPORT_HELP = {
   "|c#GREEN#/fb #IMPORT#|r",
   "    Importiere Impps Fishinfo- oder FishInfo2-Daten.",
};

FishingTranslations["deDE"].SWITCH_HELP = {
   "|c#GREEN#/fb #SWITCH#|r",
   "    wechsle deine Angelausr\195\188stung und -kleidung.",
};

FishingTranslations["deDE"].WATCHER_HELP = {
   "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r oder |c#GREEN##WATCHER_UNLOCK#|r oder |c#GREEN##RESET#|r]",
   "    fixieren .. Fixieren der \195\156bersicht,",
   "    freigeben .. Entriegeln zum Verschieben,",
   "    reset .. Zur\195\188cksetzen",
};

FishingTranslations["deDE"].CURRENT_HELP = {
      "|c#GREEN#/fb #CURRENT# #RESET#|r",
      "   Zur\195\188cksetzen der w\195\164hrend der gegenw\195\164rtigen Session gefangenen Fische.",
   };
FishingTranslations["deDE"].CLEANUP_HELP = {
   "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN##CHECK#|r or |c#GREEN##NOW#|r]",
   "    Alte Einstellungen aufr\195\164umen. |c#GREEN##CHECK#|r verzeichnet",
   "    die alten Einstellungen, die von |c#GREEN##NOW#|r entfernt werden.",
};

FishingTranslations["deDE"].PRE_HELP = {
   "Du kannst |c#GREEN#/fishingbuddy|r oder |c#GREEN#/fb|r f\195\188r alle Befehle benutzen",
   "|c#GREEN#/fb|r: schaltet das Fenster ein/aus.",
   "|c#GREEN#/fb #HELP#|r: zeigt diesen Hilfetext",
};
FishingTranslations["deDE"].POST_HELP = {
   "Du kannst die Fensteraktivierung und den",
   "Befehl zum Wechseln deiner Ausstattung in den",
   "\"Tastaturbelegungen\" festlegen.",
};
