if ( GetLocale() == "deDE" ) then
	-- Umlautersetzung: Unicode for Gemrman Umlauts
	-- ä->\195\164; ö->\195\182; ü->\195\188; ß->\195\159
	
	--TITLES
	CHAT_LOG_MWINDOW_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
	CHAT_LOG_MWINDOW_INFO = "Maximal " .. CHAT_LOG_MAXSIZE .. " Zeilen.";
	CHAT_LOG_MWINDOW_HEADER_TOOLTIP = "Linksklick, um zu verschieben.\nRechtsklick, um zur\195\188ckzusetzen.";
	CHAT_LOG_COPYWINDOW_TITLE = "Chat Kopieren";

	--BINDINGS
	BINDING_HEADER_CHAT_LOG_BHEADER = "ChatLog";
	BINDING_NAME_CHAT_LOG_TOGGLE = "ChatLog anzeigen/verstecken";

	--LOG NAMES
	--Game
	CHAT_LOG_WHISPER_NAME = "Fl\195\188stern";
	CHAT_LOG_RAID_NAME = "Raid";
	CHAT_LOG_PARTY_NAME = "Gruppe";
	CHAT_LOG_SAY_NAME = "Sagen";
	CHAT_LOG_YELL_NAME = "Schreien";
	CHAT_LOG_OFFICER_NAME = "Offizier";
	CHAT_LOG_GUILD_NAME = "Gilde";
	--General: Names to display
	CHAT_LOG_GENERAL_NAME = "Allgemein";
	CHAT_LOG_TRADE_NAME = "Handel";
	CHAT_LOG_LOCALDEFENSE_NAME = "LokaleVerteidigung";
	CHAT_LOG_WORLDDEFENSE_NAME = "WeltVerteidigung";
	CHAT_LOG_LOOKINGFORGROUP_NAME = "SucheNachGruppe";
	CHAT_LOG_GUILDRECRUITMENT_NAME = "Gildenrekrutierung";
	--General: String to look for
	CHAT_LOG_GENERAL_STR = "allgemein";
	CHAT_LOG_TRADE_STR = "handel";
	CHAT_LOG_LOCALDEFENSE_STR = "lokaleverteidigung";
	CHAT_LOG_WORLDDEFENSE_STR = "weltverteidigung";
	CHAT_LOG_LOOKINGFORGROUP_STR = "suchenachgruppe";
	CHAT_LOG_GUILDRECRUITMENT_STR = "gildenrekrutierung";

	--BUTTONS
	CHAT_LOG_HIDE = "Schlie\195\159en";
	CHAT_LOG_ALLCLEAR = "Alle Leeren";
	CHAT_LOG_CLEAR = "Leeren";
	CHAT_LOG_DELETE = "L\195\182schen";
	CHAT_LOG_ENABLE_THIS_LOG = "Einschalten";
	CHAT_LOG_DISABLE_THIS_LOG = "Ausschalten";
	CHAT_LOG_COPY = "Kopieren";
	CHAT_LOG_ENABLE_ALL = "Alle einschalten";
	CHAT_LOG_DISABLE_ALL = "Alle ausschalten";

	--CHECKBOXES
	CHAT_LOG_CHAT_CHECKBOX_TITLE = "Chat in Datei speichern";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_TITLE = "Speichert den Chat in einer Datei.";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG1 = "Speichert den Chat (nicht das Kampflog)";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG2 = "in Logs\\WoWChatLog.txt";

	CHAT_LOG_COMBATCHAT_CHECKBOX_TITLE = "Kampflog in Datei speichern";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_TITLE = "Speichert das Kampflog in einer Datei.";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG1 = "Speichert das Kampflog";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG2 = "in Logs\\WoWCombatLog.txt";
	
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TITLE = "Logge neue Channels.";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_TITLE = "Logge neue Channels";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE1 = "Startet automatsich das Loggen, wenn ";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE2 = "ein neuer Channel betreten wird.";

	--SLIDERS
	CHAT_LOG_ALPHA_SLIDER_TITLE = "Transparenz";

	--TOOLTIPS
	CHAT_LOG_TOGGLE_TOOLTIP_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
	CHAT_LOG_TOGGLE_TOOLTIP_LINE1 = "Linksklick, um ChatLog anzuzeigen/zu verstecken";
	CHAT_LOG_TOGGLE_TOOLTIP_LINE2 = "Rechts-Klick zum Verschieben des Buttons.";
	CHAT_LOG_DISPLAY_DROPDOWN = "Zeige Chats";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE1 = "W\195\164hle den anzuzeigenden Chat aus";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE2 = "dem Dropdown-Men\195\188. Oder";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE3 = "Rechts-Klicke auf den Rahmen .";
	CHAT_LOG_SCROLL_LINE_UP = "Scroll one line up"
	CHAT_LOG_SCROLL_LINE_DOWN = "Scroll one line down"
	CHAT_LOG_SCROLL_SCREEN_UP = "Scroll one page up"
	CHAT_LOG_SCROLL_SCREEN_DOWN = "Scroll one page down"
	CHAT_LOG_SCROLL_TOP = "Scroll to top"
	CHAT_LOG_SCROLL_BOTTOM = "Scroll to bottom"

	--PARAMETERS
	--First parameters
	CHAT_LOG_PHELP = "hilfe";
	CHAT_LOG_PRESET = "zur\195\188cksetzen";
	CHAT_LOG_PRESETBUTTON = "schalterzur\195\188cksetzen";
	CHAT_LOG_PCLEAR = "leeren";
	CHAT_LOG_PALLCLEAR = "alleleeren";
	--Second parameters
	CHAT_LOG_PCLEAR_WHISPER = "fl\195\188stern";
	CHAT_LOG_PCLEAR_RAID = "raid";
	CHAT_LOG_PCLEAR_PARTY = "gruppe";
	CHAT_LOG_PCLEAR_SAY = "sagen";
	CHAT_LOG_PCLEAR_YELL = "schreien";
	CHAT_LOG_PCLEAR_OFFICER = "offizier";
	CHAT_LOG_PCLEAR_GUILD = "gilde";

	--SLASHCOMMANDS HELP
	CHAT_LOG_PHELP_TITLE = "ChatLog Befehle:";
	CHAT_LOG_PHELP_TOGGLE = "ChatLog anzeigen/verstecken.";
	CHAT_LOG_PHELP_RESET = "Positionen der Fenster zur\195\188cksetzen.";
	CHAT_LOG_PHELP_RESETBUTTON = "Position des ChatLog-Schalters zur\195\188cksetzen.";
	CHAT_LOG_PHELP_CLEAR = "Das ausgew\195\164hlte Log leeren.";
	CHAT_LOG_PHELP_ALLCLEAR = "Alle Logs leeren.";
	CHAT_LOG_PHELP_HELP = "Diese Hilfe anzeigen.";

	--GENERAL INFORMATION
	CHAT_LOG_LOADED_MESSAGE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION .. " geladen. Tippe /chatlog " .. CHAT_LOG_PHELP .. " f\195\188r weitere Befehle. (\195\156bersetzung: harl & Antikleia)"
	CHAT_LOG_ALLCLEARED_MESSAGE = CHAT_LOG_TITLE .. ": Logs geleert."
	CHAT_LOG_CLEARED_MESSAGE = " Log geleert."
	CHAT_LOG_WRONG_PARAMETER_MESSAGE = "/chatlog clear: Falscher Parameter."
	CHAT_LOG_LOGGING_STARTED_ON = "Log gestartet am";
	CHAT_LOG_LOGGING_STARTED_AT = "um";
	CHAT_LOG_LOGGING_STOPPED_AT = "Log gestoppt am";
	CHAT_LOG_PLAYER_RECEIVE_WHISPER = "fl\195\188stert";
	CHAT_LOG_PLAYER_SEND_WHISPER = "Zu";
	CHAT_LOG_ENABLED_ALL = CHAT_LOG_TITLE .. ": Alle Chats werden geloggt.";
	CHAT_LOG_DISABLED_ALL = CHAT_LOG_TITLE .. ": Alle Logs gestoppt.";
	
	-- DIALOGS
	CHAT_LOG_DIALOG_CLEARALL_TEXT = "This will clear all logs.";
	CHAT_LOG_DIALOG_CLEARALL_BUTTON1 = "Ok";
	CHAT_LOG_DIALOG_CLEARALL_BUTTON2 = "Cancel";
end