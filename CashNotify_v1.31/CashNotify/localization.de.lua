-- Versions-Info  : v1.31.11200
-- Sprache        : Deutsch
-- Letztes Update : 28 oct 2006

if ( GetLocale() == "deDE" ) then

CN_LANG = " (DE)";

--BINDING_HEADER_CASHNOTIFY_HEADER
BINDING_NAME_CASHNOTIFY_ENABLE		= "Meldungen einschalten";
BINDING_NAME_CASHNOTIFY_DISABLE		= "Meldungen ausschalten";
BINDING_NAME_CASHNOTIFY_TOGGLE		= "Meldungen umschalten";
BINDING_NAME_CASHNOTIFY_TOGMERCH	= "H\195\164ndler Zusammenfassung an/ausschalten"; --ä Toggle merchant summaries on/off
BINDING_NAME_CASHNOTIFY_TOGFRAME	= "Ausgabeframe ein/ausschalten"; --Toggle output frame

CN_LOADED	= "CashNotify geladen";
CN_VARLOAD	= "Variabeln geladen";
CN_ENTWORLD	= "Spieler betritt Welt";
CN_DISPHELP = "zeigt Hilfe an";

CN_MYADDONS_DESC = "Zeigt Verm\195\182gens-\195\132nderungen im Chat Fenster." --öÄ "Shows money changes in the chat pane."

CN_COMMANDS	= "Befehle:";
CN_ACTIVE	= "Geld Meldungen eingeschaltet.";
CN_INACTIVE	= "Geld Meldungen ausgeschaltet.";
CN_USAGE	= "Verwendung:";
CN_DEBUG	= "Debug: ";
CN_DISABLED	= "ausgeschaltet";
CN_ENABLED	= "eingeschaltet";
CN_HELP		= "hilfe";
CN_NOOPT	= "'keine Parameter' schaltet Einstellungen";

CN_GAIN		= "Sie bekommen %s";
CN_SPEND	= "Sie geben %s aus";
CN_SALES	= "Verk\195\164ufe"; --ä
CN_PURCHASE	= "Eink\195\164ufe"; --ä
CN_OVERALL	= "insgesamt";

--CN_GOLD
--CN_SILVER
--CN_COPPER
CN_AND		= "und";
CN_OR		= "oder";

CN_TOGGLE			= "Schaltet Meldungen an/aus";
CN_SHOWHELP			= "Zeigen Sie diese Hilfe an";
CN_PARAM_COLOR		= "farbe";
CN_PARAM_COLORGAIN	= CN_PARAM_COLOR..CN_NGAIN;
CN_PARAM_COLORSPEND	= CN_PARAM_COLOR..CN_NSPEND;
CN_PARAM_FRAME		= "frame"; --should be Frame - no uppercase or accents
CN_PARAM_MERCHANT	= "haendler"; --should be Händler - no uppercase or accents
CN_RGB				= "<r> <g> <b>";
CN_SET_NOTIF_COLOR	= "Stellen Sie die Meldungs-Farbe ein";
CN_USING_PICKER		= "den 'Farbe Picker' verwenden";
CN_SET_GAIN_COLOR	= "Legt 'Gewinne'-Farbe fest";
CN_SET_SPEND_COLOR	= "Legt 'Ausgaben'-Farbe fest";
CN_VALUES_ARE		= "Werte sind 1-255";
CN_TOGGLE_FRAME		= "Ausgabeframe umschalten (zwischen 'Standard' und 'Auswahl')";
CN_TOGGLE_MERCHANT	= "Schaltet H\195\164ndler Zusammenfassungen an/aus"; --ä

CN_INVALID_COLOUR	= "Ung\195\188ltiger RGB Farb-Wert"; --ü

--CN_COLOR_UPDATED
CN_COLOR_UPDATED[CN_NGAIN]	= "Mitteilungs-Farbe aktualisiert (Gewinne).";
CN_COLOR_UPDATED[CN_NSPEND]	= "Mitteilungs-Farbe aktualisiert (Ausgaben).";

CN_COLPICK_CANCEL	= "Mitteilungs-Farben nicht ge\195\164ndert."; -- geändert

CN_NOTIF_DEFAULT	= "Benachrichtigungen werden nur im Standard-Chat Frame angezeigt.";
CN_NOTIF_CURRENT	= "Benachrichtigungen werden im ausgew\195\164hlten Chat Frame angezeigt."; --ä

CN_MERCH_ENABLED	= "Ein- und Verk\195\164ufe werden zusammengefasst."; --ä
CN_MERCH_DISABLED	= "Ein- und Verk\195\164ufe werden nun aufgelistet."; --ä

-- Color Picker constants
CNCP_GAINTEXT	= "Gewinntext";
CNCP_SPENDTEXT	= "Ausgabe Text";

end
