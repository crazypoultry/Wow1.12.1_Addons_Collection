
-- Last update: 25/08/2006


TITANROLL_NAME		= "TitanPanel[Roll]"
TITANROLL_VERSION 	= "0.45"
TITANROLL_NAMEVERSION	= TITANROLL_NAME.." v"..TITANROLL_VERSION

TITANROLL_MAXTTLEN	= 25


-- Version: English
-- Last update: 25/08/2006

TITANROLL_MENUTEXT	= "Roll"
TITANROLL_LABELTEXT	= "Last roll: "
TITANROLL_LABELWINNER	= "Winner: "
TITANROLL_TOOLTIP	= "Latest rolls"
TITANROLL_NOROLL	= "No rolls yet!"
TITANROLL_TTALERT	= "One or more rolls aren't shown here!"
TITANROLL_HINT		= "Hint: Left-click to perform roll.|nAlt-Click to announce winner.|nShift-Click to erase list."

TITANROLL_OPTIONS	= "Options"

TITANROLL_TOGWINNER	= "Show winner on the bar";
TITANROLL_TOGREPLACE	= "Replace bad rolls when rerolled"
TITANROLL_TOGSORTLIST	= "Sort rolls by value"
TITANROLL_TOGHIGHLIGHT	= "Highlight group members rolls"
TITANROLL_ERASELIST	= "Erase list"

TITANROLL_PERFORMED	= "Change performed roll"
TITANROLL_CHANGELENGTH	= "Change list length"
TITANROLL_SETTIMEOUT	= "Set timeout"
TITANROLL_CURRENTACTION = "Current boundaries: "

TITANROLL_TIMEOUTS_TEXT = {
	"10 sec",
	"20 sec",
	"30 sec",
	"1 min",
	"2 min",
	"3 min",
	"None"
	}
TITANROLL_TOGERASETO	= "Erase timed out rolls from list"


TITANROLL_SEARCHPATTERN	= "(.+) rolls (%d+) %((%d+)%-(%d+)%)"

TITANROLL_TOGGOODWIN	= "Only accept 1-100 rolls as winner"
TITANROLL_TOGGROUPACC	= "Process group members rolls only"
TITANROLL_TOGIGNOREMUL	= "Ignore multirolls"
TITANROLL_TOGIGNOREBAD	= "Ignore bad rolls"
TITANROLL_TOGPOPUPTT	= "Popup tooltip when roll registered"
TITANROLL_SHOWTIME	= "Change timestamp style"
TITANROLL_ANNOUNCE	= "Change announcement text"
TITANROLL_CHATFORHELP	= "Look at the chatbox for help"

TITANROLL_WINNER_HIGH	= "Announce highest roll"
TITANROLL_WINNER_LOW	= "Announce lowest roll"


TITANROLL_ANNPATT	= "[Roll]: $aNo active rolls.$b$w won with a roll of $r$d$y rolled lowest with $z. There were $n rolls.$c Invalid rolls were made by: $i"
TITANROLL_ANNHELP01	= "TitanPanel[Roll] announcement change..."
TITANROLL_ANNHELP02	= "Current announcement pattern:\n "
TITANROLL_ANNHELP03	= "Useable tags: "
TITANROLL_ANNHELP04	= " $a - following text displays when there's no active roll"
TITANROLL_ANNHELP05	= " $b - following text displays when there's at least one active roll. Use following tags here:"
TITANROLL_ANNHELP06	= "     $w - winners name "
TITANROLL_ANNHELP07	= "     $r - winners dice roll"
TITANROLL_ANNHELP08	= "	$l - a list of the rolls"
TITANROLL_ANNHELP09	= "     $n - number of total rolls"
TITANROLL_ANNHELP10	= " $c - following text displays when there's at least one invalid roll. Use the following tag here: "
TITANROLL_ANNHELP11	= "     $i - a list of players with invalid rolls"

-- 10/05/06: Adding for lowest roll support
TITANROLL_ANNHELP12 = " $d - following text displays when lowest roll displayed. Use following tags here:"
TITANROLL_ANNHELP13 = " new: $y - lowest roll name"
TITANROLL_ANNHELP14 = " new: $z - lowest dice roll"

BINDING_HEADER_TitanRoll  = TITANROLL_NAME;
BINDING_NAME_TRANNOUNCE   = "Announce (both low and high)";
BINDING_NAME_TRANNOUNCEHIGH   = "Announce highest roll";
BINDING_NAME_TRANNOUNCELOW   = "Announce lowest roll";
BINDING_NAME_TRCLEAR      = "Clears the roll list";


if ( GetLocale() == "deDE" ) then

-- Version: Deutsch (German)
-- Last update: 03.Mai.2006
-- Thanks to Max Power for this!
-- changes for version 044b by Tayedaen

TITANROLL_MENUTEXT = "W\195\188rfeln"
TITANROLL_LABELTEXT = "Letzter Wurf: "
TITANROLL_LABELWINNER = "Sieger: "
TITANROLL_TOOLTIP = "Letzte W\195\188rfe"
TITANROLL_NOROLL = "Keine W\195\188rfe !"
TITANROLL_TTALERT = "Mindestens ein Wurf wird hier nicht angezeigt !"
TITANROLL_HINT = "Links klicken zum w\195\188rfeln"

TITANROLL_OPTIONS = "Optionen"

TITANROLL_TOGWINNER = "Zeige Gewinner in der Leiste";
TITANROLL_TOGREPLACE = "Entferne schlechte W\195\188rfe"
TITANROLL_TOGSORTLIST = "W\195\188rfe nach h\195\182he sortieren"
TITANROLL_TOGHIGHLIGHT = "Highlight W\195\188rfe der Gruppenmitglieder"
TITANROLL_ERASELIST = "Liste l\195\182schen"

TITANROLL_PERFORMED = "W\195\188rfelbereich"
TITANROLL_CHANGELENGTH = "L\195\164nge der Liste"
TITANROLL_SETTIMEOUT = "Timeout einstellen"
TITANROLL_CURRENTACTION = "Momentane Grenze: "

TITANROLL_TIMEOUTS_TEXT = {
"10 Sek",
"20 Sek",
"30 Sek",
"1 Min",
"2 Min",
"3 Min",
"Kein"
}

TITANROLL_TOGERASETO = "Abgelaufene W\195\188rfe aus der Liste entfernen"

TITANROLL_SEARCHPATTERN = "(.+) w\195\188rfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)"

TITANROLL_TOGGOODWIN = "Akzeptiere nur 1-100 W\195\188rfe als Gewinner"
TITANROLL_TOGGROUPACC = "Nur Gruppenmitglieder w\195\188rfeln"
TITANROLL_TOGIGNOREMUL = "Ignoriere Mehrfachw\195\188rfeln"
TITANROLL_TOGIGNOREBAD = "Ignoriere schlechte W\195\188rfe"
TITANROLL_SHOWTIME = "Zeit anders ausschreiben"
TITANROLL_ANNOUNCE = "Ansagetext \195\164ndern"
TITANROLL_CHATFORHELP = "Der Hilfe-Text steht im Chat-Fenster"

TITANROLL_ANNPATT = "[Wurf]: $aMomentan keine W\195\188rfe.$b$w gewinnt einen Wurf von $r$dNiedrigste Wurf bei $y mit $z. Es wurde $n gew\195\188rfelt.$c Ung\195\188ltig gew\195\188rfelt haben: $i"
TITANROLL_ANNHELP01 = "TitanPanel[Roll] Ansagetext\195\164nderung..."
TITANROLL_ANNHELP02 = "Momentanes Ansagetextmuster:\n "
TITANROLL_ANNHELP03 = "Benutzbare tags: "
TITANROLL_ANNHELP04 = " $a - Folgender Text erscheint, wenn momentan niemand w\195\188rfelt"
TITANROLL_ANNHELP05 = " $b - Folgender Text erscheint, wenn zumindest einer w\195\188rfelt. Benutze folgende tags hier:"
TITANROLL_ANNHELP06 = " $w - Name des Siegers "
TITANROLL_ANNHELP07 = " $r - Wurf des Siegers"
TITANROLL_ANNHELP08 = " $l - Liste der W\195\188rfe"
TITANROLL_ANNHELP09 = " $n - Anzahl der gesamten W\195\188rfe"
TITANROLL_ANNHELP10 = " $c - Folgender Text erscheint, wenn es zumindest einen ung\195\188ltigen Wurf gibt. Benutze folgenden tag hier: "
TITANROLL_ANNHELP11 = " $i - Eine Liste von Spielern mit ung\195\188ltigen W\195\188rfen"

end


if ( GetLocale() == "frFR" ) then

-- Version: Francais (French)
-- Last update: 19/6/2005
-- Thanks to Toblerone and Sasmira for this!

TITANROLL_MENUTEXT = "Roll"
TITANROLL_LABELTEXT = "Dernier Roll : "
TITANROLL_LABELWINNER = "Gagnant : "
TITANROLL_TOOLTIP = "Les Derniers Rolls"
TITANROLL_NOROLL = "Aucun Roll Actuellement !"
TITANROLL_HINT = "Usage : Clic-Gauche pour Roll."

TITANROLL_TOGWINNER = "Voir le gagnant dans la barre";
TITANROLL_TOGREPLACE = "Remplacez les mauvais Rolls quand ils sont reroll\195\169s"
TITANROLL_TOGSORTLIST = "Trier les rolls par valeur"
TITANROLL_TOGHIGHLIGHT = "Highlight sur les membres du groupe rollants"
TITANROLL_ERASELIST = "R\195\169initialiser la liste"

TITANROLL_PERFORMED = "Changer la valeur du Roll"
TITANROLL_CHANGELENGTH = "Taille de la liste"
TITANROLL_SETTIMEOUT = "Selection de la Dur\195\169e"
TITANROLL_CURRENTACTION = "Limites courantes : "

TITANROLL_TIMEOUTS_TEXT = {
	"10 sec",
	"20 sec",
	"30 sec",
	"1 min",
	"2 min",
	"3 min",
	"Aucune"
	}

TITANROLL_SEARCHPATTERN = "(.+) obtient un (%d+) %((%d+)%-(%d+)%)"

end