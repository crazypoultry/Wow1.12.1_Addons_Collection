VASSIST_NAME = "vAssist";
VASSIST_VERSION = 0.8;
VASSIST_CWHITE = "|cFFFFFFFF";

VASSIST_DESC = "Tank management";
VASSIST_LOADED = VASSIST_NAME .. " v" .. VASSIST_VERSION .. " for %s loaded."

BINDING_HEADER_VASSIST = VASSIST_NAME;
BINDING_NAME_VA_ASSIST = "Assist MT";
BINDING_NAME_VA_SET = "Set MT";

VASSIST_MTSET = "%s is now set as main tank";
VASSIST_MTNOGROUP = "%s is not in your party/raid.";
VASSIST_MTLEFT = "%s left your party/raid.";
VASSIST_MTNOINFO =  "Main tank's target information can not be retrieved.";
VASSIST_NOTARGET = "No valid target!";
VASSIST_MTTINFOMSG = "%s's target: [%s] %s. HP: %s%%."; -- MT's Name, MTT's Level, MTT's Name, MTT's Health Percentage
VASSIST_MTTARGET = "%s's target";
VASSIST_NOTANK = "No tank set!";
VASSIST_TARGET = "Target";

VASSIST_HELPMSG = {"Commands:",
	VASSIST_CWHITE.."'/vassist [<num>]'|r - Assists MT #<num>. If <num> is not specified most valid MT will be assisted.",
	VASSIST_CWHITE.."'/vassist set  [<num>]'|r - Sets your target as main tank #<num>. Example: '/va set 1'. Without <num> first free MT slot will be used.",
	VASSIST_CWHITE.."'/vassist unset <num>'|r - Unsets main tank #<num>. Example '/va unset 1'.",
	VASSIST_CWHITE.."'/vassist unsetall'|r - Unsets all main tanks.",
	VASSIST_CWHITE.."'/vassist hide'|r - Hides the MTTarget windows (If you just want to use the binding or the '/vassist' command.)",
	VASSIST_CWHITE.."'/vassist show'|r - Makes the MTTarget windows visible again.",
	VASSIST_CWHITE.."'/vassist scale <num>'|r - Scales the MTTarget windows. <num> can be a number between 1 and 15.",
	VASSIST_CWHITE.."'/vassist showinfo <num>'|r - Displays short information about the tank's target in your chat frame.",
	VASSIST_CWHITE.."'/vassist mttt on/off'|r - Displays a small text which tells the current target of MT's target.",
	VASSIST_CWHITE.."'/vassist colors on/off'|r - Enables/Disables the use of colors to show aggro status.",
	VASSIST_CWHITE.."'/vassist border on/off'|r - Enable/Disable the display of borders.",
	VASSIST_CWHITE.."'/vassist interval <num>'|r - Changes the update interval. <num> in seconds.",
	VASSIST_CWHITE.."'/vassist help'|r - show ingame help.",
	VASSIST_CWHITE.."'/va'|r can be used instead of "..VASSIST_CWHITE.."'/vassist'|r",
	VASSIST_CWHITE.."Shift + Click|r will move the MTTarget windows." };

-- German localization..
if( GetLocale() == "deDE" ) then

	VASSIST_DESC = "Tank-Verwaltung";
	VASSIST_LOADED = VASSIST_NAME .. " v" .. VASSIST_VERSION .. " für %s geladen."

	BINDING_HEADER_VASSIST = VASSIST_NAME;
	BINDING_NAME_VA_ASSIST = "MT assistieren";
	BINDING_NAME_VA_SET = "MT setzen";

	VASSIST_MTSET = "%s ist jetzt als Main-Tank gesetzt";
	VASSIST_MTNOGROUP = "%s ist nicht in deiner Gruppe/Schlachtzug.";
	VASSIST_MTLEFT = "%s hat deine Gruppe/Schlachtzug verlassen.";
	VASSIST_MTNOINFO =  "Informationen über das Ziel des Main-Tanks können nicht weiter bezogen werden.";
	VASSIST_NOTARGET = "Kein gültiges Ziel!";
	VASSIST_MTTINFOMSG = "%ss Ziel: [%s] %s. HP: %s%%."; -- MT's Name, MTT's Level, MTT's Name, MTT's Health Percentage
	VASSIST_MTTARGET = "%ss Ziel";
	VASSIST_NOTANK = "Kein Tank gesetzt!";
	VASSIST_TARGET = "Ziel";

	VASSIST_HELPMSG = {"Commands:",
		VASSIST_CWHITE.."'/vassist [<num>]'|r - Assistiert dem MT #<num>. Wenn <num> nicht angegeben wird, wird der MT, dessen Ziel am wenigsten HP hat, assistiert.",
		VASSIST_CWHITE.."'/vassist set  [<num>]'|r - Setzt das Ziel als MT #<num>. Beispiel: '/va set 1'. Wenn <num> nicht angegeben wird, wird der erste freie MT Platz genutzt.",
		VASSIST_CWHITE.."'/vassist unset <num>'|r - Löscht den MT #<num>. Beispiel: '/va unset 1'.",
		VASSIST_CWHITE.."'/vassist unsetall'|r - Löscht alle MTs.",
		VASSIST_CWHITE.."'/vassist hide'|r - Versteckt das MT-Ziel-Fenster (Wenn man z.B nur den '/vassist'-Befehl verwenden möchte.)",
		VASSIST_CWHITE.."'/vassist show'|r - Macht das MT-Ziel-Fenster wieder sichtbar.",
		VASSIST_CWHITE.."'/vassist scale <num>'|r - Skaliert die MT-Ziel-Fenster. <num> kann zwischen 1 und 15 liegen.",
		VASSIST_CWHITE.."'/vassist showinfo <num>'|r - Zeigt eine kurze Info über das Ziel des MTs im Chat-Fenster an.",
		VASSIST_CWHITE.."'/vassist mttt on/off'|r - Zeigt das Ziel vom Ziel des MTs im Fenster an.",
		VASSIST_CWHITE.."'/vassist colors on/off'|r - De-/Aktiviert die Benutzung von Farben im MT-Ziel-Fenster.",
		VASSIST_CWHITE.."'/vassist border on/off'|r - De-/Aktiviert die Rahmen um die MT-Ziel-Fenster.",
		VASSIST_CWHITE.."'/vassist interval <num>'|r - Ändert den Intervall zwischen den Updates der MT-Ziel-Fenster. <num> in Sekunden.",
		VASSIST_CWHITE.."'/vassist help'|r - Zeigt diese Hilfe an.",
		VASSIST_CWHITE.."'/va'|r kann anstelle von "..VASSIST_CWHITE.."'/vassist'|r benutzt werden",
		"Mit "..VASSIST_CWHITE.."Umschalt + Klick|r kann man die Fenster bewegen." };

end