-- German localization

if( GetLocale() == "deDE" ) then

NOVAWATCH_SPELL = "Frostnova"

NOVAWATCH_TEXT_ENABLED = "NovaWatch: Aktiviert"
NOVAWATCH_TEXT_DISABLED = "NovaWatch: Deaktiviert"

NOVAWATCH_TEXT_LOADED = "NovaWatch " .. NOVAWATCH_VERSION .. " geladen - /novawatch"
NOVAWATCH_TEXT_WORLD_NOT_LOADED = "NovaWatch: Welt noch nicht geladen, bitte warten..."
NOVAWATCH_TEXT_PROFILECLEARED = "NovaWatch: Deine Einstellungen sind nicht zu dieser Version kompatibel und wurden geloescht.\nNovaWatch: Bitte konfiguriere NovaWatch mit /novawatch"
NOVAWATCH_TEXT_LOCKED = "NovaWatch: Frame fixiert."
NOVAWATCH_TEXT_UNLOCKED = "NovaWatch: Frame beweglich."
NOVAWATCH_TEXT_INVERSION_ON = "NovaWatch: Statusanzeige abnehmend."
NOVAWATCH_TEXT_INVERSION_OFF = "NovaWatch: Statusanzeige zunehmend."
NOVAWATCH_TEXT_VERBOSE_ON = "NovaWatch: Statusausgaben aktiviert."
NOVAWATCH_TEXT_VERBOSE_OFF = "NovaWatch: Statusausgaben deaktiviert."
NOVAWATCH_TEXT_DECIMALS_ON = "NovaWatch: Dezimalstellen im Zaehler aktiviert."
NOVAWATCH_TEXT_DECIMALS_OFF = "NovaWatch: Dezimalstellen im Zaehler deaktiviert."
NOVAWATCH_TEXT_COUNTER_ON = "NovaWatch: Zaehler aktiviert."
NOVAWATCH_TEXT_COUNTER_OFF = "NovaWatch: Zaehler deaktiviert."
NOVAWATCH_TEXT_ANNOUNCE_CAST = " gezaubert gegen "
NOVAWATCH_TEXT_ANNOUNCE_BREAK = NOVAWATCH_SPELL .. " wurde entfernt von "
NOVAWATCH_TEXT_ANNOUNCE_FADE = NOVAWATCH_SPELL .. " schwindet von "
NOVAWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "NovaWatch: Du hast den Kampfmodus verlassen."
NOVAWATCH_LABEL_ENABLE = "NovaWatch Einschalten"
NOVAWATCH_LABEL_VERBOSE = "Verbose Modus"
NOVAWATCH_LABEL_CLOSE = "Schliessen"
NOVAWATCH_LABEL_MOVE = "Unlock"
NOVAWATCH_LABEL_MOVE2 = "Lock"
NOVAWATCH_LABEL_COUNTER = "Zaehler aktivieren"
NOVAWATCH_LABEL_COUNTER_DIGITS = "Zeige Millisekunden"
NOVAWATCH_LABEL_DIRECTION_LABEL = "Richtung: "
NOVAWATCH_LABEL_COLOR_LABEL = "Bar Farbe:"
NOVAWATCH_LABEL_TRANSPARENCY = "Bar Transparenz"
NOVAWATCH_LABEL_SCALING = "Bar Scaling"
NOVAWATCH_LIST_DIRECTIONS = { 
					{ name = "Aufsteigend", value = 1 },
					{ name = "Abnehmend", value = 2 }
}

NOVAWATCH_HELP1  = " - Konfigurieren mit '/novawatch option'"
NOVAWATCH_HELP2  = "Optionen:"
NOVAWATCH_HELP3  = " on     : Aktiviert NovaWatch"
NOVAWATCH_HELP4  = " off    : Deaktiviert NovaWatch"
NOVAWATCH_HELP5  = " lock   : Fixiert den Statusbalken"
NOVAWATCH_HELP6  = " invert : Statusbalken abnehmend statt zunehmend anzeigen"
NOVAWATCH_HELP7  = " unlock : Erlaubt das Bewegen des Statusbalkens"
NOVAWATCH_HELP8  = " counter  : Aktiviert/deaktiviert einen Zaehler ueber dem Statusbalken"
NOVAWATCH_HELP9  = " decimals : Aktiviert/deaktiviert die Nachkommastellen im Zaehler"
NOVAWATCH_HELP10  = " verbose  : Aktiviert/deaktiviert Statusausgaben"
NOVAWATCH_HELP11 = " status   : Gibt die aktuelle Konfiguration aus"

NOVAWATCH_EVENT_ON = "(.+) ist von " .. NOVAWATCH_SPELL .. " betroffen."
NOVAWATCH_EVENT_CAST = "Ihr wirkt " .. NOVAWATCH_SPELL .. " auf (.+)."
NOVAWATCH_EVENT_BREAK = "(.+)s " .. NOVAWATCH_SPELL .. " wurde entfernt."
NOVAWATCH_EVENT_FADE = NOVAWATCH_SPELL .. " schwindet von (.+)."
NOVAWATCH_EVENT_DEATH = "(.+) stirbt."

end
