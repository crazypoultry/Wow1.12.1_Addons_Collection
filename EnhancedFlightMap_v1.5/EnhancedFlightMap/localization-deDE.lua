--[[
German Localization file

Special thanks go to
Gazzis who did the initial german localisation.
Elkano for updating the german translation.
themicro for updating this once more.

Initial Unicode update by Khisanth.
]]

-- Begin German Localization --
if ( GetLocale() == "deDE" ) then

--EFM_DESC						= "Enhanced Flight Map";
--EFM_Version_String				= format("%s - Version %s", EFM_DESC, EFM_Version);

-- Slash Commands
EFM_CMD_HELP					= "hilfe";
EFM_CMD_CLEAR					= "l\195\182schen";
EFM_CMD_CLEAR_ALL				= "alle l\195\182schen";
--EFM_CMD_GUI					= "config";
EFM_CMD_MAP					= "karte";
EFM_CMD_REPORT				= "melden";

--EFM_SLASH1					= "/enhancedflightmap";
--EFM_SLASH2					= "/efm";

-- Help Text
EFM_HELP_TEXT0				= "---";
EFM_HELP_TEXT1				= format("%s Hilfe / Beschreibung der Befehle:",					  EFM_Version_String);
EFM_HELP_TEXT2				= format("Benutze %s oder %s um die folgenden Befehle auszuf\195\188hren:-",	  format(EFM_HELPCMD_STRING, EFM_SLASH1.." <command>"), format(EFM_HELPCMD_STRING, EFM_SLASH2.." <command>"));
EFM_HELP_TEXT3				= format("%s: Zeigt diese Hilfe an.",						   format(EFM_HELPCMD_STRING, EFM_CMD_HELP));
EFM_HELP_TEXT4				= format("%s: Zeigt das Optionsfenster.",						format(EFM_HELPCMD_STRING, EFM_CMD_GUI));
EFM_HELP_TEXT5				= format("%s: L\195\182scht die Liste der bekannten Flugpunkte und -routen.",	  format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR));
EFM_HELP_TEXT6				= format("%s: Löscht die bekannten Flugpunkte und -routen f\195\188r %s.",			format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR.." <faction>"), format(EFM_HELPCMD_STRING, "<faction>"));
EFM_HELP_TEXT7				= format("%s: Zeigt eine Karte \195\164hnlich der des Flugmeisters f\195\188r den aktuellen Kontinent.",   format(EFM_HELPCMD_STRING, EFM_CMD_MAP));
EFM_HELP_TEXT8				= format("%s: Zeigt eine Karte \195\164hnlich der des Flugmeisters f\195\188r den Kontinent <kontinent>, wobei <kontinent> gleich kalimdor oder azeroth.",					 format(EFM_HELPCMD_STRING, EFM_CMD_MAP.." <kontinent>"));
EFM_HELP_TEXT9				= format("%s: Meldet das aktuelle Flugziel sowie Ankunftszeit in <channel>, <channel> kann enweder gilde, party oder eine Nummer, welche f\195\188r einen aktiven Channel steht, sein.",   format(EFM_HELPCMD_STRING, EFM_CMD_REPORT.." <channel>"));

-- Other messages
EFM_CLEAR_HELP					= format("%s: Um die Liste wirklich zu l\195\182schen %s eintippen. Dies ist ein Sicherheitsfeature.",	  EFM_DESC, format(EFM_HELPCMD_STRING, EFM_CMD_CLEAR_ALL));
EFM_MSG_CLEAR					= format("%s: Alle Flugdaten gel\195\182scht.",					 EFM_DESC);
EFM_MSG_CLEARFACTION			= format("%s: Flugdaten f\195\188r %%s gel\195\182scht.",			   EFM_DESC);  
EFM_MSG_DATALOAD				= format("%s: Flugdaten f\195\188r %%s geladen.",					 EFM_DESC);
EFM_MSG_DATALOADTIMERS			= format("%s: Flugdaten f\195\188r %%s geladen. Es wurden nur Daten bekannter Flugpunkte geladen.",   EFM_DESC);
EFM_NEW_NODE					= format("%s: %s %%s nach %%s.", EFM_DESC, ERR_NEWTAXIPATH);
EFM_MSG_DELETENODE				= format("%s: Flugdaten f\195\188r %%s und alle zugeh\195\182rigen Daten gel\195\182scht!",   EFM_DESC);
EFM_MSG_MOVENODE				= format("%s: Bewege Flugpunkt %%s an die richtige Kartenposition.", EFM_DESC);

-- Remote flight path messages
EFM_MSG_REMOTENAME			= "Entfernte Fl\195\188ge";
--EFM_MSG_KALIMDOR				= "Kalimdor";
EFM_MSG_AZEROTH				= "Azeroth (\195\150stliche K\195\182nigreiche)";
EFM_FMCMD_CURRENT				= "aktuell";
--EFM_FMCMD_KALIMDOR			= "kalimdor";
--EFM_FMCMD_AZEROTH				= "azeroth";

-- Flight time messages
EFM_FT_FLIGHT_TIME				= "Flugzeit: ";
EFM_FT_FLIGHT_TIME_CALC			= "Berechnete Flugzeit: ";
EFM_FT_DESTINATION				= "Ziel: ";
EFM_FT_ARRIVAL_TIME				= "Ankunft in: ";
EFM_FT_INCORRECT				= "Flugzeit inkorrekt, Zeiten werden bei der Landung aktualisiert.";

-- Flight time report messages
EFM_MSG_REPORT				= "EFM: Reise nach %s, voraussichtliche Ankunft in %s.";
EFM_MSG_REPORTERROR			= "EFM: Fehler: Nicht am fliegen oder Flugziel unbekannt!";
EFM_MSG_REPORTERRORTIME		= "EFM: Fehler: Ankunftszeit unbekannt!";
EFM_MSG_UNKNOWNCONTINENT		= "EFM: Fehler: Unbekannter Kontinent, bitte einen Kontinent zur Anzeige ausw\195\164hlen!";

-- Map screen messages
EFM_MAP_PATHLIST				= "Verf\195\188gbare Flugrouten";

-- GUI Options Screen
EFM_GUITEXT_Header				= format("%s Einstellungen", EFM_DESC);
EFM_GUITEXT_Done				= "Fertig";
EFM_GUITEXT_Defaults				= "Voreinstellungen";
EFM_GUITEXT_Timer				= "Zeige Timer w\195\164hrend dem Flug";
EFM_GUITEXT_ShowTimerBar			= "Zeige Timer Statusleiste w\195\164hrend dem Flug";
EFM_GUITEXT_ShowLargeBar			= "Gro\195\159e Timer Statusleiste w\195\164hrend dem Flug";
EFM_GUITEXT_ZoneMarker			= "Zeige Flugmeister Standorte auf der Karte";
EFM_GUITEXT_DruidPaths			= "Zeige Druiden Flugrouten";
EFM_GUITEXT_DisplaySlider			= "Timer Position.  Offset: %s.";
EFM_GUITEXT_LoadHeader			= "Lade Daten";
--EFM_GUITEXT_LoadAlliance			= FACTION_ALLIANCE;			-- Should not need localization as this is the official blizzard locale-string.
EFM_GUITEXT_LoadDruid			= "Druide";
--EFM_GUITEXT_LoadHorde			= FACTION_HORDE;			-- Should not need localization as this is the official blizzard locale-string.
EFM_GUITEXT_LoadAll				= "Alle vorbereiteten Daten laden.";

-- GUI Option Screen Tooltips
EFM_GUITEXT_Tooltip_Timer			= "Aktivieren um den Timer während des Fluges anzuzeigen.";
EFM_GUITEXT_Tooltip_ShowTimerBar	= "Den Timer während des Fluges als Zauberleiste anzeigen.";
EFM_GUITEXT_Tooltip_ShowLargeBar	= "Den Timer während des Fluges extra gro\195\159 anzeigen. (Praktisch, wenn man die Flugzeit von weiter weg lesen will).";
EFM_GUITEXT_Tooltip_ZoneMarker		= "Flugmeister Standorte auf der Karte anzeigen (soweit bekannt). Ein Flugmeister muss nur einmal für alle Charaktere besucht werden.";
EFM_GUITEXT_Tooltip_DruidPaths		= "Druiden Flugrouten auf der Karte anzeigen.";
EFM_GUITEXT_Tooltip_DisplaySlider		= "Timer Position bestimmen.\n\n0 ist die Bildschirmmitte.\n\nGr\195\192\195\159ere Werte verschieben den Timer nach oben, kleinere nach unten.";
EFM_GUITEXT_Tooltip_LoadAll		= "Aktivieren: Lädt alle Daten.(Standard) Deaktiviert: Nur Flugzeiten bekannter Flugrouten laden.";

-- Key Binding Strings
--BINDING_HEADER_EFM			= "Enhanced Flight Map";
BINDING_NAME_OPTIONS			= "Optionsfenster anzeigen";
BINDING_NAME_MAP1				= "Karte wechseln - Aktueller Kontinent";
BINDING_NAME_MAP2				= "Karte wechseln - Kalimdor";
BINDING_NAME_MAP3				= "Karte wechseln - Azeroth";

-- Debug Strings
EFM_DEBUG_HEADER_MT			= format("%s: Flugrouten ohne Flugzeiten:-", EFM_DESC);
EFM_DEBUG_MT				   	= format("%s: Flugzeit von %%s nach %%s fehlt.  %%s Hop(s).", EFM_DESC);

-- Druid flightpath strings
--EFM_TEST_NIGHTHAVEN			= "I'd like to fly";			-- This is EXACTLY the text given by the druid flight masters for Nighthaven.
--												-- This should match as much of the option text as possible to match both horde and alliance flight master options.
--EFM_NIGHTHAVEN				= "Nighthaven, Moonglade";

-- End German Localization --
end 