-- Deutsche Lokalisierung von oneofamillion aka Cyrdhan / Alexstrasza
-- hoffentlich sind nicht zu viele Fehler drin...

-- Ä: C3 84 - \195\132
-- Ö: C3 96 - \195\150
-- Ü: C3 9C - \195\156
-- ß: C3 9F - \195\159
-- ä: C3 A4 - \195\164
-- ö: C3 B6 - \195\182
-- ü: C3 BC - \195\188

if (GetLocale() == "deDE") then

-- General
METAMAP_CATEGORY = "Interface";
METAMAP_SUBTITLE = "WorldMap Mod";
METAMAP_DESC = "MetaMap ist eine Erweiterung der standard Weltkarte.";
METAMAP_OPTIONS_BUTTON = "Optionen";
METAMAP_SLASH_OPTIONS = "Optionen";
METAMAP_STRING_LOCATION = "Ort";
METAMAP_STRING_LEVELRANGE = "Stufen";
METAMAP_STRING_PLAYERLIMIT = "Max. Spieleranzahl";
METAMAP_BUTTON_TOOLTIP1 = "Links-Klick f\195\188r Karte";
METAMAP_BUTTON_TOOLTIP2 = "Rechts-Klick f\195\188r Optionen";
METAMAP_OPTIONS_TITLE = "MetaMap Optionen";
METAMAP_KB_TEXT = "Knowledge Base"
METAMAP_HINT = "Hinweis: Links-klick \195\182ffnet MetaMap.\nRechts-klick \195\182ffnet Optionen";
METAMAPNOTES_NAME = "map notes"
METAMAP_NOTES_SHOWN = "Notizen"
METAMAP_LINES_SHOWN = "Lines"
BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_TOGGLE = "[AN/AUS] MetaMap";
BINDING_NAME_METAMAP_SAVESET = "Toggle Map Mode";
BINDING_NAME_METAMAP_KB = "Toggle Database Display"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "Capture Target Details";
BINDING_NAME_METAMAP_QUICKNOTE = "Set Quick Note";

-- Commands
METAMAP_ZDEBUG_COMMANDS = { "/mmdebug" }
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_MNTLOC_COMMANDS = { "/mntloc" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote" }
METAMAPNOTES_QUICKTLOC_COMMANDS = { "/quicktloc", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "Menu on Click";
METAMAP_OPTIONS_COORDS = "Zeige Koordinaten";
METAMAP_OPTIONS_MINICOORDS = "Zeige MiniMap Koordinaten";
METAMAP_OPTIONS_SHOWBUT = "MetaMap Schalter anzeigen";
METAMAP_OPTIONS_AUTOSEL = "Autosize Tooltip";
METAMAP_OPTIONS_BUTPOS = "MetaMap Schalterposition";
METAMAP_OPTIONS_POI = "Zeige standard POI";
METAMAP_OPTIONS_MOZZ = "Show Unexplored";
METAMAP_OPTIONS_TRANS = "Kartentransparenz";
METAMAP_OPTIONS_FWM = "Show Unexplored Areas";
METAMAP_OPTIONS_DONE = "Fertig";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap Optionen";
METAMAP_MASTERMOD_OPTIONS = "MasterMod Optionen";
METAMAP_GATHERER_OPTIONS = "Gatherer Optionen";
METAMAP_GATHERER_SEARCH = "Gatherer Search";
METAMAP_BWP_OPTIONS = "BetterWaypoints";
METAMAP_OPTIONS_SHOWCTBUT = "Zeige MasterMod Schalter";
METAMAP_OPTIONS_SCALE = "Map Scale";
METAMAP_OPTIONS_TTSCALE = "Tooltip Scale";
METAMAP_OPTIONS_SAVESET = "Map Display Mode";
METAMAP_OPTIONS_USEMAPMOD = "Create notes with MapMod";
METAMAP_LIST_TEXT = "Show Map List";
METAMAP_ACTION_MODE = "Map Action Mode";

METAMAPNOTES_WORLDMAP_HELP_1 = "Rechts-Klicken um aus der Karte zu zoomen"
METAMAPNOTES_WORLDMAP_HELP_2 = "<Strg>+Links-Klicken an Notiz erstellen"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "|cFFFF0000Karten Notizen:|r W\195\164hle eine zweite Notiz um jene\ndurch eine Linie zu verbinden/Linie wieder zu l\195\182schen."

METAMAPNOTES_NEW_MENU = "Karten Notizen"
METAMAPNOTES_NEW_NOTE = "Notiz erstellen"
METAMAPNOTES_MININOTE_OFF = "Kurz-Notizen aussch."
METAMAPNOTES_OPTIONS_TEXT = "Notizen Einstellungen"
METAMAPNOTES_CANCEL = "Abbrechen"
METAMAPNOTES_SHOW_AUTHOR = "Notizen anzeigen sch\195\182pfer"

METAMAPNOTES_POI_MENU = "Karten Notizen"
METAMAPNOTES_EDIT_NOTE = "Notiz bearbeiten"
METAMAPNOTES_MININOTE_ON = "Als Kurz-Notiz"
METAMAPNOTES_SPECIAL_ACTIONS = "Spezielle Aktionen"
METAMAPNOTES_SEND_NOTE = "Notiz senden"

METAMAPNOTES_SPECIALACTION_MENU = "Spezielle Aktionen"
METAMAPNOTES_TOGGLELINE = "Notizen verbinden"
METAMAPNOTES_DELETE_NOTE = "Notiz l\195\182schen"

METAMAPNOTES_EDIT_MENU = "Notiz Bearbeiten"
METAMAPNOTES_SAVE_NOTE = "Speichern"
METAMAPNOTES_EDIT_TITLE = "Titel (erfordert):"
METAMAPNOTES_EDIT_INFO1 = "Info Zeile 1 (optional):"
METAMAPNOTES_EDIT_INFO2 = "Info Zeile 2 (optional):"
METAMAPNOTES_EDIT_CREATOR = "Sch\195\182pfer (optional - leave blank to hide):"

METAMAPNOTES_SEND_MENU = "Notiz Senden"
METAMAPNOTES_SLASHCOMMAND = "Modus wechseln"
METAMAPNOTES_SEND_TITLE = "Notiz senden:"
METAMAPNOTES_SEND_TIP = "Diese Notiz kann von allen Benutzern der Karten Notizen MetaMap empfangen werden ('an Gruppe senden' funktioniert nur mit Sky)"
METAMAPNOTES_SEND_PLAYER = "Spielername eingeben:"
METAMAPNOTES_SENDTOPLAYER = "An Spieler senden"
METAMAPNOTES_SENDTOPARTY = "An Gruppe senden"
METAMAPNOTES_SHOWSEND = "Modus wechseln"
METAMAPNOTES_SEND_SLASHTITLE = "Slash-Befehle:"
METAMAPNOTES_SEND_SLASHTIP = "Dies markieren und STRG+C dr\195\188cken um in die Zwischenablage zu kopieren. (dann kann es zum Beispiel in einem Forum ver\195\182ffentlicht werden)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Befehl:"

METAMAPNOTES_OPTIONS_MENU = "Einstellungen"
METAMAPNOTES_SAVE_OPTIONS = "Speichern"
METAMAPNOTES_OWNNOTES = "Notizen anzeigen, die von diesem Charakter erstellt wurden"
METAMAPNOTES_OTHERNOTES = "Notizen anzeigen, die von anderen Spielern empfangen wurden"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "Zuletzt erstellte Notiz in |cFFFF0000rot|r hervorheben"
METAMAPNOTES_HIGHLIGHT_MININOTE = "Notizen die als Kurz-Notiz markiert wurden in |cFF6666FFblau|r hervorheben"
METAMAPNOTES_ACCEPTINCOMING = "Ankommende Notizen von anderen Spielern akzeptieren"
METAMAPNOTES_INCOMING_CAP = "Ankommende Notizen ablehnen wenn\nweniger als 5 freie Notizen \195\188brig bleiben"
METAMAPNOTES_AUTOPARTYASMININOTE = "Markiere Gruppen-Notizen automatisch als Kurz-Notiz"

METAMAPNOTES_CREATEDBY = "Erstellt von"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "Dieser Befehl erlaubt es zum Beispiel Notizen, die von einer Webseite empfangen wurden, einzuf\195\188gen."
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "\195\156bergeht die Einstellungen, wodurch die n\195\164chste empfangene Notiz in jedem Fall akzeptiert wird."
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "Markiert die n\195\164chste empfangene Notiz direkt als Kurz-Notiz (und f\195\188gt jene auf der Karte ein)."
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "Markiert die n\195\164chste empfangene Notiz nur als Kurz-Notiz (und f\195\188gt jene nicht auf der Karte ein)."
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "Kurz-Notizen nicht mehr anzeigen."
METAMAPNOTES_CHAT_COMMAND_MNTLOC_INFO = "Setzt eine tloc auf der Karte."
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "F\195\188gt auf der momentanen Position auf der Karte eine Notiz ein."
METAMAPNOTES_CHAT_COMMAND_QUICKTLOC = "F\195\188gt auf der angegebenen tloc Position auf der Karte, in der momentanen Zone, eine Notiz ein."
METAMAPNOTES_MAPNOTEHELP = "Dieser Befehl kann nur zum Einf\195\188gen einer Notiz benutzt werden."
METAMAPNOTES_ONENOTE_OFF = "Eine Notiz zulassen: AUS"
METAMAPNOTES_ONENOTE_ON = "Eine Notiz zulassen: AN"
METAMAPNOTES_MININOTE_SHOW_0 = "N\195\164chste als Kurz-Notiz: AUS"
METAMAPNOTES_MININOTE_SHOW_1 = "N\195\164chste als Kurz-Notiz: AN"
METAMAPNOTES_MININOTE_SHOW_2 = "N\195\164chste als Kurz-Notiz: IMMER"
METAMAPNOTES_DECLINE_SLASH = "Notiz kann nicht hinzugef\195\188gt werden, zuviele Notizen in |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_SLASH_NEAR = "Notiz kann nicht hinzugef\195\188gt werden, sie befindet sich zu nahe an |cFFFFD100%q|r in |cFFFFD100%s|r."
METAMAPNOTES_DECLINE_GET = "Notiz von |cFFFFD100%s|r konnte nicht empfangen werden: zu viele Notizen in |cFFFFD100%s|r, oder Empfang in den Einstellungen deaktiviert."
METAMAPNOTES_ACCEPT_SLASH = "Notiz auf der Karte von |cFFFFD100%s|r hinzugef\195\188gt."
METAMAPNOTES_ACCEPT_GET = "Notiz von %s in %s empfangen."
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r hat eine neue Gruppen-Notiz in |cFFFFD100%s|r hinzugef\195\188gt."
METAMAPNOTES_DECLINE_NOTETONEAR = "|cFFFFD100%s|r hat versucht dir in |cFFFFD100%s|r eine Notiz zu senden, aber jene war zu nahe bei |cFFFFD100%q|r."
METAMAPNOTES_QUICKNOTE_NOTETONEAR = "Notiz konnte nicht erstellt werden: Du befindest dich zu nahe bei |cFFFFD100%s|r."
METAMAPNOTES_QUICKNOTE_NOPOSITION = "Notiz konnte nicht erstellt werden: momentane Position konnte nicht ermittelt werden."
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "Schnell-Notiz"
METAMAPNOTES_MININOTE_DEFAULTNAME = "Kurz-Notiz"
METAMAPNOTES_QUICKNOTE_OK = "Notiz auf der Karte in |cFFFFD100%s|r erstellt."
METAMAPNOTES_QUICKNOTE_TOOMANY = "Es befinden sich bereits zu viele Notizen auf der Karte von |cFFFFD100%s|r."
METAMAPNOTES_DELETED_BY_NAME = "Alle Karten Notizen mit dem Erzeuger |cFFFFD100%s|r und dem Namen |cFFFFD100%s|r wurden gel\195\182scht"
METAMAPNOTES_DELETED_BY_CREATOR = "Alle Karten Notizen mit dem Erzeuger |cFFFFD100%s|r wurden gel\195\182scht"
METAMAPNOTES_QUICKTLOC_NOTETONEAR = "Notiz konnte nicht erstellt werden: Die Position ist zu nahe bei |cFFFFD100%s|r."
METAMAPNOTES_QUICKTLOC_NOZONE = "Notiz konnte nicht erstellt werden: momentane Zone konnte nicht ermittelt werden."
METAMAPNOTES_QUICKTLOC_NOARGUMENT = "Benutzung: '/quicktloc xx,yy [Icon] [Title]'."
METAMAPNOTES_SETMININOTE = "Setzt die Notiz als neue Kurz-Notiz."
METAMAPNOTES_THOTTBOTLOC = "Thottbot Ortsangabe"
METAMAPNOTES_PARTYNOTE = "Gruppen-Notiz"
METAMAPNOTES_SETCOORDS = "Coords (xx,yy):"
METAMAPNOTES_MNTLOC = "Virtual"
METAMAPNOTES_MNTLOC_INFO = "Creates a virtual note. Save on map of choice to bind."
METAMAPNOTES_MNTLOC_SET = "Virtual note created on the World Map."

METAMAPNOTES_CONVERSION_COMPLETE = "Konvertierung abgeschlossen. \195\156berpr\195\188fen sie bitte ihre Notes. Diese Funktion nicht nochmal ausf\195\188hren!"

-- Errors
METAMAPNOTES_ERROR_NO_OLD_ZONESHIFT = "FEHLER: Kein altes Zoneshift definiert."

-- Drop Down Menu
METAMAPNOTES_SHOWNOTES = "Notizen anzeigen"
METAMAPNOTES_DROPDOWNTITLE = "Karten Notizen"
METAMAPNOTES_DROPDOWNMENUTEXT = "Optionen"

-- Buttons, Headers, Various Text
METAKB_AUTHOR = "MetaMapKB"
METAKB_MAIN_HEADER = "World of WarCraft Knowledge Base"
METAKB_OPTIONS_HEADER = "MetaKB Optionen"
METAKB_ADDON_DESCRIPTION = "Eine Datenbank von NPC/mobs, die man getroffen hat."
METAKB_DOWNLOAD_SITES = "Sehe README f\195\188r Download Seiten"
METAKB_MOB_LEVEL = "Level"
METAKB_MAPNOTES_NW_BOUND = "NW Grenze"
METAKB_MAPNOTES_NE_BOUND = "NE Grenze"
METAKB_MAPNOTES_SE_BOUND = "SE Grenze"
METAKB_MAPNOTES_SW_BOUND = "SW Grenze"
METAKB_MAPNOTES_CENTER = "Zentrum"
METAKB_SHOW_ONLY_LOCAL_NPCS = "Nur local NPCs anzeigen"
METAKB_SHOW_UPDATES = "Updates anzeigen"
METAKB_BOUNDING_BOX = "Erzeuge MapNotes Zeichenbox"
METAKB_SEARCH_BOX = "Suchen"
METAKB_CLOSE_BUTTON = "Schlie\195\159en"
METAKB_OPTIONS_BUTTON = "Optionen"
METAKB_REFRESH_BUTTON = "Refresh"
METAKB_CLEAR_NOTES_BUTTON = "MapNotes l\195\182schen"
METAKB_AUTO_TRACK = "Auto Tracking";
METAKB_USE_KB = "Add to Database";
METAKB_TARGET_NOTE = "Add new target note";
METAKB_OPTIONS_RANGETEXT = "Targeting Range:";

METAKB_HEADER_NAME = "Name";
METAKB_HEADER_DESC = "Description";
METAKB_HEADER_LEVEL = "Level";
METAKB_HEADER_LOCATION = "Location";

-- Tooltips
METAKB_QUICK_HELP = "Quick Help"
METAKB_QUICK_HELP_1 = "1. Links-Klicken um note zu erstellen"
METAKB_QUICK_HELP_2 = "2. Rechts-Klicken um note zu entfernen"
METAKB_QUICK_HELP_3 = "3. <Strg>+<Shift>+Rechts-Klick um Eintrag aus der Datenbank zu entfernen"
METAKB_QUICK_HELP_4 = "4. <Shift>+Left-Click to add info to open message box"
METAKB_QUICK_HELP_5 = "5. Eine leere Suchabfrage zeigt alle Eintr\195\164ge"
METAKB_SHOW_ONLY_LOCAL_NPCS_HELP = "Nur die mobs/NPC in deiner momentanen Zone werden angezeigt."
METAKB_SHOW_UPDATES_HELP = "\195\132nderungen in der Datenbank werden im Chatfenster angezeigt."
METAKB_BOUNDING_BOX_HELP = "Links-Klicken um eine MapNote hinzuzufügen, f\195\188gt einen "..
    "Mittelpunkt und Punkte f\195\188r die 4 Eckpunkte die mit Linien verbunden werden hinzu.  "..
    "Andernfalls wird nur der Mittelpunkt hinzugef\195\188gt."
METAKB_AUTO_TRACK_HELP = "Turns on/off the automatic adding of NPCs/Mobs on mouseover";
METAKB_USE_KB_HELP = "Turns on/off the adding of new targets to database";
METAKB_TARGET_NOTE_HELP = "Turns on/off the adding of notes to the map for new targets. This can be over-ridden "..
													"by using the <CTRL>+<Keybinding> combination.";

-- Informational
METAKB_NO_NPC_MOB_FOUND = "Kein NPC oder Mob mit diesem Namen gefunden: \"%s\" "
METAKB_REMOVED_FROM_DATABASE = "\"%s\" in \"%s\" wurde von der Datenbank entfernt"
METAKB_DISCOVERED_UNIT = "%s! gefunden"
METAKB_ADDED_UNIT_IN_ZONE = "%s in %s hinzugef\195\188gt"
METAKB_UPDATED_MINMAX_XY = "Aktualisiert Min/Max X/Y f\195\188r %s in %s"
METAKB_UPDATED_INFO = "Updated information for %s in %s"
METAKB_IMPORT_SUCCESSFUL = "MetaKB_ImportData erfolgreich hinzugef\195\188gt, %u "..
    "Eintr\195\164ge hinzugef\195\188gt und %u aktualisiert."
METAKB_STATS_LINE = "%u NPCs in %u Zones/Instances"
METAKB_NOTARGET = "You must have something targeted to create a record."

-- German 1800.4 ZoneShift
--[[
MetaMapNotes_ZoneShiftOld = {
[0] = { [0] = 0 },
[1] = { 1, 2, 3, 4, 17, 14, 20, 5, 7, 6, 8, 9, 10, 11, 12, 13, 15, 16, 18, 19, 21 },
[2] = { 1, 2, 20, 14, 25, 3, 6, 16, 10, 15, 19, 5, 4, 23, 9, 7, 8, 11, 12, 13, 17, 18, 21, 22, 24, 26 },
}
]]

-- German 1900 ZoneShift
MetaMapNotes_ZoneShift = {
[0] = { [0] = 0 },
[1] = { 1, 2, 4, 17, 14, 20, 5, 7, 3, 6, 9, 10, 11, 12, 13, 15, 16, 8, 18, 19, 21 },
[2] = { 1, 2, 20, 14, 25, 3, 6, 16, 10, 15, 19, 11, 5, 4, 23, 9, 7, 8, 12, 13, 17, 18, 21, 22, 24, 26 },
}

MetaMapNotes_ZoneShift[1][0] = 0
MetaMapNotes_ZoneShift[2][0] = 0

METAMAPNOTES_WARSONGGULCH = "Warsongschlucht"
METAMAPNOTES_ALTERACVALLEY = "Alteractal"
METAMAPNOTES_ARATHIBASIN = "Arathibecken"

-- Game Data
MetaMap_Data = {
[1] = {
["ZoneName"] = "Blackfathom-Tiefen",
["Location"] = "Ashenvale",
["LevelRange"] = "20-27",
["PlayerLimit"] = "10"
},
[2] = {
["ZoneName"] = "Blackrocktiefen",
["Location"] = "Blackrock",
["LevelRange"] = "48-56",
["PlayerLimit"] = "10"
},
[3] = {
["ZoneName"] = "Blackrockspitze(Unten)",
["Location"] = "Blackrock",
["LevelRange"] = "53-60",
["PlayerLimit"] = "15"
},
[4] = {
["ZoneName"] = "Blackrockspitze(Oben)",
["Location"] = "Blackrock",
["LevelRange"] = "53-60",
["PlayerLimit"] = "15"
},
[5] = {
["ZoneName"] = "Pechschwingenhort",
["Location"] = "Blackrockspitze",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[6] = {
["ZoneName"] = "D\195\188sterbruch",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[7] = {
["ZoneName"] = "D\195\188sterbruch (Ost)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[8] = {
["ZoneName"] = "D\195\188sterbruch (Nord)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[9] = {
["ZoneName"] = "D\195\188sterbruch (West)",
["Location"] = "Feralas",
["LevelRange"] = "56-60",
["PlayerLimit"] = "5"
},
[10] = {
["ZoneName"] = "Gnomeregan",
["Location"] = "Dun Morogh",
["LevelRange"] = "24-33",
["PlayerLimit"] = "10"
},
[11] = {
["ZoneName"] = "Maraudon",
["Location"] = "Desolace",
["LevelRange"] = "40-49",
["PlayerLimit"] = "10"
},
[12] = {
["ZoneName"] = "Der geschmolzene Kern",
["Location"] = "Blackrocktiefen",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[13] = {
["ZoneName"] = "Onyxias Hort",
["Location"] = "Marschen von Dustwallow",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[14] = {
["ZoneName"] = "Ragefireabgrund",
["Location"] = "Orgrimmar",
["LevelRange"] = "13-15",
["PlayerLimit"] = "10"
},
[15] = {
["ZoneName"] = "H\195\188gel von Razorfen",
["Location"] = "Brachland",
["LevelRange"] = "35-40",
["PlayerLimit"] = "10"
},
[16] = {
["ZoneName"] = "Kral von Razorfen",
["Location"] = "Brachland",
["LevelRange"] = "25-35",
["PlayerLimit"] = "10"
},
[17] = {
["ZoneName"] = "Das scharlachrote Kloster",
["Location"] = "Tirisfal",
["LevelRange"] = "30-40",
["PlayerLimit"] = "10"
},
[18] = {
["ZoneName"] = "Scholomance",
["Location"] = "Westliche Pestl\195\164nder",
["LevelRange"] = "56-60",
["PlayerLimit"] = "10"
},
[19] = {
["ZoneName"] = "Burg Shadowfang",
["Location"] = "Silberwald",
["LevelRange"] = "18-25",
["PlayerLimit"] = "10"
},
[20] = {
["ZoneName"] = "Stratholme",
["Location"] = "\195\182stliche Pestl\195\164nder",
["LevelRange"] = "55-60",
["PlayerLimit"] = "10"
},
[21] = {
["ZoneName"] = "Die Todesminen",
["Location"] = "Westfall",
["LevelRange"] = "15-20",
["PlayerLimit"] = "10"
},
[22] = {
["ZoneName"] = "Die Palisaden",
["Location"] = "Stormwind",
["LevelRange"] = "23-26",
["PlayerLimit"] = "10"
},
[23] = {
["ZoneName"] = "Der versunkene Tempel",
["Location"] = "S\195\188mpfe des Elends",
["LevelRange"] = "44-50",
["PlayerLimit"] = "10"
},
[24] = {
["ZoneName"] = "Uldaman",
["Location"] = "Das \195\182dland",
["LevelRange"] = "35-45",
["PlayerLimit"] = "10"
},
[25] = {
["ZoneName"] = "Die H\195\182hlen des Wehklagens",
["Location"] = "Brachland",
["LevelRange"] = "15-21",
["PlayerLimit"] = "10"
},
[26] = {
["ZoneName"] = "Zul'Farrak",
["Location"] = "Tanaris",
["LevelRange"] = "43-47",
["PlayerLimit"] = "10"
},
[27] = {
["ZoneName"] = "Zul'Gurub",
["Location"] = "Stranglethorn",
["LevelRange"] = "60+",
["PlayerLimit"] = "20"
},
[28] = {
["ZoneName"] = "Ahn'Quiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "40"
},
[29] = {
["ZoneName"] = "Ruins Of Ahn'Qiraj",
["Location"] = "Silithus",
["LevelRange"] = "60+",
["PlayerLimit"] = "20"
}
};

MetaKB_ZoneIdentifiers = {
    [1] = {
        ["z"] = "Das Alteracgebirge",
        ["i"] = 1
    },
    [2] = {
        ["z"] = "Das Arathihochland",
        ["i"] = 2,
    },
    [3] = {
        ["z"] = "Ashenvale",
        ["i"] = 3,
    },
    [4] = {
        ["z"] = "Azshara",
        ["i"] = 4,
    },
    [5] = {
        ["z"] = "Das \195\150dland",
        ["i"] = 5,
    },
    [6] = {
        ["z"] = "Die verw\195\188steten Lande",
        ["i"] = 6,
    },
    [7] = {
        ["z"] = "Die brennende Steppe",
        ["i"] = 7,
    },
    [8] = {
        ["z"] = "Darkshore",
        ["i"] = 8,
    },
    [9] = {
        ["z"] = "Darnassus",
        ["i"] = 9,
    },
    [10] = {
        ["z"] = "Der Gebirgspass der Totenwinde",
        ["i"] = 10,
    },
    [11] = {
        ["z"] = "Desolace",
        ["i"] = 11,
    },
    [12] = {
        ["z"] = "Dun Morogh",
        ["i"] = 12,
    },
    [13] = {
        ["z"] = "Durotar",
        ["i"] = 13,
    },
    [14] = {
        ["z"] = "Duskwood",
        ["i"] = 14,
    },
    [15] = {
        ["z"] = "Die Marschen von Dustwallow",
        ["i"] = 15,
    },
    [16] = {
        ["z"] = "Die \195\182stlichen Pestl\195\164nder",
        ["i"] = 16,
    },
    [17] = {
        ["z"] = "Der Wald von Elwynn",
        ["i"] = 17,
    },
    [18] = {
        ["z"] = "Felwood",
        ["i"] = 18,
    },
    [19] = {
        ["z"] = "Feralas",
        ["i"] = 19,
    },
    [20] = {
        ["z"] = "Die Vorgebirge von Hillsbrad",
        ["i"] = 20,
    },
    [21] = {
        ["z"] = "Ironforge",
        ["i"] = 21,
    },
    [22] = {
        ["z"] = "Loch Modan",
        ["i"] = 22,
    },
    [23] = {
        ["z"] = "Moonglade",
        ["i"] = 23,
    },
    [24] = {
        ["z"] = "Mulgore",
        ["i"] = 24,
    },
    [25] = {
        ["z"] = "Orgrimmar",
        ["i"] = 25,
    },
    [26] = {
        ["z"] = "Das Redridgegebirge",
        ["i"] = 26,
    },
    [27] = {
        ["z"] = "Die Sengende Schlucht",
        ["i"] = 27,
    },
    [28] = {
        ["z"] = "Silithus",
        ["i"] = 28,
    },
    [29] = {
        ["z"] = "Der Silberwald",
        ["i"] = 29,
    },
    [30] = {
        ["z"] = "Das Steinkrallengebirge",
        ["i"] = 30,
    },
    [31] = {
        ["z"] = "Stormwind",
        ["i"] = 31,
    },
    [32] = {
        ["z"] = "Stranglethorn",
        ["i"] = 32,
    },
    [33] = {
        ["z"] = "Die S\195\188mpfe des Elends",
        ["i"] = 33,
    },
    [34] = {
        ["z"] = "Tanaris",
        ["i"] = 34,
    },
    [35] = {
        ["z"] = "Teldrassil",
        ["i"] = 35,
    },
    [36] = {
        ["z"] = "Das Brachland",
        ["i"] = 36,
    },
    [37] = {
        ["z"] = "Das Hinterland",
        ["i"] = 37,
    },
    [38] = {
        ["z"] = "Thousand Needles",
        ["i"] = 38,
    },
    [39] = {
        ["z"] = "Thunder Bluff",
        ["i"] = 39,
    },
    [40] = {
        ["z"] = "Tirisfal",
        ["i"] = 40,
    },
    [41] = {
        ["z"] = "Undercity",
        ["i"] = 41,
    },
    [42] = {
        ["z"] = "Der Un'Goro Krater",
        ["i"] = 42,
    },
    [43] = {
        ["z"] = "Die westlichen Pestl\195\164nder",
        ["i"] = 43,
    },
    [44] = {
        ["z"] = "Westfall",
        ["i"] = 44,
    },
    [45] = {
        ["z"] = "Das Sumpfland",
        ["i"] = 45,
    },
    [46] = {
        ["z"] = "Winterspring",
        ["i"] = 46,
    },

-- Instances and other special zones
    [300] = {
        ["z"] = "Die Tiefenbahn",
        ["i"] = 300,
    },
    [301] = {
        ["z"] = "Die Todesminen",
        ["i"] = 301,
    },
    [302] = {
        ["z"] = "Blackfathom-Tiefe",
        ["i"] = 302,
    },
    [303] = {
        ["z"] = "Ragefireabgrund",
        ["i"] = 303,
    },
    [304] = {
        ["z"] = "Die H\195\188gel von Razorfen",
        ["i"] = 304,
    },
    [305] = {
        ["z"] = "Der Kral von Razorfen",
        ["i"] = 305,
    },
    [306] = {
        ["z"] = "Das scharlachrote Kloster",
        ["i"] = 306,
    },
    [307] = {
        ["z"] = "Burg Shadowfang",
        ["i"] = 307,
    },
    [308] = {
        ["z"] = "Die H\195\182hlen des Wehklagens",
        ["i"] = 308,
    },
    [309] = {
        ["z"] = "Die Palisade",
        ["i"] = 309,
    },
    [310] = {
        ["z"] = "Maraudon",
        ["i"] = 310,
    },
    [311] = {
        ["z"] = "Uldaman",
        ["i"] = 311,
    },
    [312] = {
        ["z"] = "Gnomeregan",
        ["i"] = 312,
    },
    [313] = {
        ["z"] = "Zul'Gurub",
        ["i"] = 313,
    },
    [314] = {
        ["z"] = "Stratholme",
        ["i"] = 314,
    },
    [315] = {
        ["z"] = "Scholomance",
        ["i"] = 315,
    },
    [316] = {
        ["z"] = "Zul'Farrak",
        ["i"] = 316,
    },
    [317] = {
        ["z"] = "Der geschmolzene Kern",
        ["i"] = 317,
    },
    [318] = {
        ["z"] = "Der Blackrock",
        ["i"] = 318,
    },
    [319] = {
        ["z"] = "Onyxias Hort",
        ["i"] = 319,
    },
    [320] = {
        ["z"] = "Pechschwingenhort",
        ["i"] = 320,
    },
    [321] = {
        ["z"] = "Blackrocktiefen",
        ["i"] = 321,
    },
    [322] = {
        ["z"] = "D\195\188sterbruch",
        ["i"] = 322,
    },
    [323] = {
        ["z"] = "Der Tempel von Atal'Hakkar",
        ["i"] = 323,
    },
    [324] = {
        ["z"] = "Halle der Blackhand",
        ["i"] = 324,
    },
    [325] = {
        ["z"] = "Arathibecken",
        ["i"] = 325,
    },
    [326] = {
        ["z"] = "Alteractal",
        ["i"] = 326,
    },
    [327] = {
        ["z"] = "Warsongschlucht",
        ["i"] = 327,
    },
    [328] = {
        ["z"] = "Der Tempel von Ahn'Quiraj",
        ["i"] = 328,
    },

-- GetZoneText conversions/Renamed zones these must come at the end of the list so when we lookup a
-- name from the identifier we find the preferred GetRealZoneText name first.  These indices are
-- treated as invalid so they don't need to be the same in each localization file.
    [600] = {
        ["z"] = "Das Arathi Hochland",
        ["i"] = 2,
    },
    [601] = {
        ["z"] = "Gasthaus Zur H\195\182hle des L\195\182wen",
        ["i"] = 17,
    },
    [602] = {
        ["z"] = "Rathaus von Darkshire",
        ["i"] = 14,
    },
    [603] = {
        ["z"] = "Gruft",
        ["i"] = 2,
    },
    [604] = {
        ["z"] = "Gasthaus Lakeshire",
        ["i"] = 26,
    },
    [605] = {
        ["z"] = "Rathaus von Lakeshire",
        ["i"] = 26,
    },
    [606] = {
        ["z"] = "Taverne Zum roten Raben",
        ["i"] = 14,
    },
    [607] = {
        ["z"] = "Schildwachenturm",
        ["i"] = 44,
    },
    [608] = {
        ["z"] = "Anvilmar",
        ["i"] = 12,
    },
    [609] = {
        ["z"] = "Lost Rigger-Bucht",
        ["i"] = 34,
    },
    [610] = {
        ["z"] = "Stormwind-Palisade",
        ["i"] = 56,
    },
    [611] = {
        ["z"] = "Gol'Bolar Steinbruch-Mine",
        ["i"] = 12,
    },
    [612] = {
        ["z"] = "Stormwind City",
        ["i"] = 31,
    },
    [613] = {
        ["z"] = "Stonewrought-Pass",
        ["i"] = 22,
    },
    [614] = {
        ["z"] = "Deepwater-Taverne",
        ["i"] = 45,
    },
    [615] = {
        ["z"] = "Boulderfist-Au\195\159enposten",
        ["i"] = 2,
    },
    [616] = {
        ["z"] = "Mauradon",
        ["i"] = 310,
    },
    [617] = {
        ["z"] = "Brambleblade-Klamm",
        ["i"] = 24,
    },

};

end
