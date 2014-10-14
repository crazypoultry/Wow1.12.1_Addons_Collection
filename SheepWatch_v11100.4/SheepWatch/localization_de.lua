-- German localization

if( GetLocale() == "deDE" ) then

SHEEPWATCH_SPELL = "Verwandlung"

SHEEPWATCH_TEXT_LOADED = "SheepWatch " .. SHEEPWATCH_VERSION .. " geladen - /sheepwatch"
SHEEPWATCH_TEXT_WORLD_NOT_LOADED = "SheepWatch: Welt noch nicht geladen, bitte warten..."
SHEEPWATCH_TEXT_PROFILECLEARED = "SheepWatch: Deine Einstellungen sind nicht zu dieser Version kompatibel und wurden geloescht.\nSheepWatch: Bitte konfiguriere SheepWatch mit /sheepwatch"
SHEEPWATCH_TEXT_LOCKED = "SheepWatch: Frame fixiert."
SHEEPWATCH_TEXT_UNLOCKED = "SheepWatch: Frame beweglich."
SHEEPWATCH_TEXT_RANK  = " der ".. SHEEPWATCH_SPELL .. " geladen."
SHEEPWATCH_TEXT_NORANK  = "SheepWatch: Fehler: Kein Rang fuer " .. SHEEPWATCH_SPELL .. " gefunden!\nSheepWatch: Ich habe mich fuer diese Session deaktiviert."
SHEEPWATCH_TEXT_ANNOUNCE_NOTARGET = "SheepWatch: Falsches Ziel. Bitte mit \'/sheepwatch\' konfigurieren."
SHEEPWATCH_TEXT_ANNOUNCE = "$s ($r) gezaubert gegen $t (Lvl $l)"
SHEEPWATCH_TEXT_ANNOUNCE_CAST = " gezaubert gegen "
SHEEPWATCH_TEXT_ANNOUNCE_BREAK = SHEEPWATCH_SPELL .. " wurde entfernt von "
SHEEPWATCH_TEXT_ANNOUNCE_FADE = SHEEPWATCH_SPELL .. " schwindet von "
SHEEPWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "SheepWatch: Du hast den Kampfmodus verlassen."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETSUCCESS = "SheepWatch: Wiederanwahl erfolgreich."
SHEEPWATCH_TEXT_ANNOUNCE_TARGETFAILED = "SheepWatch: Wiederanwahl des alten Targets fehlgeschlagen."
SHEEPWATCH_TEXT_ANNOUNCE_ABORTCAST = "SheepWatch: Zaubern abgebrochen."
SHEEPWATCH_TEXT_RESETPOS = "SheepWatch: Position zurueckgesetzt."
SHEEPWATCH_TOOLTIP_TRANSPARENCY = "Verschiebe den Slider, um die Transparenz anzupassen"
SHEEPWATCH_TOOLTIP_SCALING = "Verschiebe den Slider, um das Scaling anzupassen"
SHEEPWATCH_LABEL_ENABLE = "SheepWatch aktivieren."
SHEEPWATCH_LABEL_ANNOUNCE = "Mitteilung aktivieren"
SHEEPWATCH_LABEL_VERBOSE = "Verbose"
SHEEPWATCH_LABEL_CLOSE = "Schliessen"
SHEEPWATCH_LABEL_MOVE = "Verschieben"
SHEEPWATCH_LABEL_MOVE2 = "Fixieren"
SHEEPWATCH_LABEL_ANNOUNCE_TARGET_LABEL = "Mitteilen an:"
SHEEPWATCH_LABEL_ANNOUNCE_TIME_LABEL = "Wann :"
SHEEPWATCH_LABEL_COUNTER = "Zaehler aktivieren"
SHEEPWATCH_LABEL_COUNTER_DIGITS = "Zeige Millisekunden"
SHEEPWATCH_LABEL_DIRECTION_LABEL = "Statusanzeige :"
SHEEPWATCH_LABEL_COLOR_LABEL = "Bar Farbe:"
SHEEPWATCH_LABEL_TRANSPARENCY = "Bar Transparenz"
SHEEPWATCH_LABEL_SCALING = "Bar Scaling"
SHEEPWATCH_LIST_DIRECTIONS = { 
					{ name = "Aufsteigend", value = 1 },
					{ name = "Absteigend", value = 2 }
}
SHEEPWATCH_LIST_ANNOUNCETIME = {
					{ name = "Vor dem Zaubern", value = 1 },
					{ name = "Nach dem Zaubern", value = 2 }
}
-- DON'T LOCALIZE THIS
SHEEPWATCH_LIST_ANNOUNCETARGETS = {
					{ name = "SAY", value = 1 },
					{ name = "YELL", value = 2 },
					{ name = "PARTY", value = 3 },
					{ name = "RAID", value = 4 },
					{ name = "GUILD", value = 5 },
					{ name = "AUTO", value = 6 }
}

SHEEPWATCH_HELP1  = " - Konfigurieren mit '/sheepwatch'"

SHEEPWATCH_EVENT_ON = "(.+) ist von " .. SHEEPWATCH_SPELL .. " betroffen."
SHEEPWATCH_EVENT_CAST = "Ihr wirkt (.+) auf (.+)."
SHEEPWATCH_EVENT_BREAK = "(.+)s (.+) wurde entfernt."
SHEEPWATCH_EVENT_FADE = "(.+) schwindet von (.+)."
SHEEPWATCH_EVENT_DEATH = "(.+) stirbt."

end
