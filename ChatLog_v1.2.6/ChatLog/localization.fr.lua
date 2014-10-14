if ( GetLocale() == "frFR" ) then
	--TITLES
	CHAT_LOG_MWINDOW_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
	CHAT_LOG_MWINDOW_INFO = "Log max: " .. CHAT_LOG_MAXSIZE .. " lignes.";
	CHAT_LOG_MWINDOW_HEADER_TOOLTIP = "Clic gauche pour déplacer.\nClic droit pour réinitialiser.";
	CHAT_LOG_COPYWINDOW_TITLE = "Fenêtre de copie";
	
	--BINDINGS
	BINDING_HEADER_CHAT_LOG_BHEADER = "ChatLog";
	BINDING_NAME_CHAT_LOG_TOGGLE = "Ouvrir/Fermer ChatLog";

	--LOG NAMES
	--Game
	CHAT_LOG_WHISPER_NAME = "Chuchoter";
	CHAT_LOG_RAID_NAME = "Raid";
	CHAT_LOG_PARTY_NAME = "Groupe";
	CHAT_LOG_SAY_NAME = "Dire";
	CHAT_LOG_YELL_NAME = "Crier";
	CHAT_LOG_OFFICER_NAME = "Officier";
	CHAT_LOG_GUILD_NAME = "Guilde";
	--General: Names to display
	CHAT_LOG_GENERAL_NAME = "Général";
	CHAT_LOG_TRADE_NAME = "Commerce";
	CHAT_LOG_LOCALDEFENSE_NAME = "DéfenseLocale";
	CHAT_LOG_WORLDDEFENSE_NAME = "DéfenseUniverselle";
	CHAT_LOG_LOOKINGFORGROUP_NAME = "RechercheGroupe";
	CHAT_LOG_GUILDRECRUITMENT_NAME = "RecrutementDeGuilde";
	--General: String to look for
	CHAT_LOG_GENERAL_STR = "général";
	CHAT_LOG_TRADE_STR = "commerce";
	CHAT_LOG_LOCALDEFENSE_STR = "défenselocale";
	CHAT_LOG_WORLDDEFENSE_STR = "défenseuniverselle";
	CHAT_LOG_LOOKINGFORGROUP_STR = "recherchegroupe";
	CHAT_LOG_GUILDRECRUITMENT_STR = "recrutementdeguilde";

	--BUTTONS
	CHAT_LOG_HIDE = "Fermer";
	CHAT_LOG_ALLCLEAR = "Tout effacer";
	CHAT_LOG_CLEAR = "Vider";
	CHAT_LOG_DELETE = "Delete";
	CHAT_LOG_ENABLE_THIS_LOG = "Activer";
	CHAT_LOG_DISABLE_THIS_LOG = "Désactiver";
	CHAT_LOG_COPY = "Copier";
	CHAT_LOG_ENABLE_ALL = "Activer tous les enregistrements";
	CHAT_LOG_DISABLE_ALL = "Désactiver tous les enregistrements";

	--CHECKBOXES
	CHAT_LOG_CHAT_CHECKBOX_TITLE = "Log le chat dans un fichier.";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_TITLE = "Log le chat dans un fichier";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG1 = "Log le chat (pas le journal de combat)";
	CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG2 = "dans Logs\\WoWChatLog.txt";

	CHAT_LOG_COMBATCHAT_CHECKBOX_TITLE = "Log le journal de combat\ndans un fichier.";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_TITLE = "Log le journal de combat dans un fichier";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG1 = "Log le journal de combat";
	CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG2 = "dans Logs\\WoWCombatLog.txt";
	
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TITLE = "Log automatique.";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_TITLE = "Log automatique";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE1 = "Active ChatLog automatiquement";
	CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE2 = "pour les nouveaux chats.";

	--SLIDERS
	CHAT_LOG_ALPHA_SLIDER_TITLE = "Transparence";
	
	--TOOLTIPS
	CHAT_LOG_TOGGLE_TOOLTIP_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
	CHAT_LOG_TOGGLE_TOOLTIP_LINE1 = "Clic gauche pour ouvrir/fermer ChatLog.";
	CHAT_LOG_TOGGLE_TOOLTIP_LINE2 = "Clic droit pour déplacer.";
	CHAT_LOG_DISPLAY_DROPDOWN = "Afficher les chats";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE1 = "Sélectionnez le chat que vous voulez";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE2 = "lire dans le menu déroulant.";
	CHAT_LOG_DISPLAY_DROPDOWN_LINE3 = "Vous pouvez aussi faire un clic droit sur la fenêtre.";
	CHAT_LOG_SCROLL_LINE_UP = "Monter d'une ligne"
	CHAT_LOG_SCROLL_LINE_DOWN = "Descendre d'une ligne"
	CHAT_LOG_SCROLL_SCREEN_UP = "Monter d'une page"
	CHAT_LOG_SCROLL_SCREEN_DOWN = "Descendre d'une page"
	CHAT_LOG_SCROLL_TOP = "Aller tout en haut"
	CHAT_LOG_SCROLL_BOTTOM = "Aller tout en bas"

	--PARAMETERS
	--First parameters
	CHAT_LOG_PHELP = "aide";
	CHAT_LOG_PRESET = "reset";
	CHAT_LOG_PRESETBUTTON = "resetbouton";
	CHAT_LOG_PCLEAR = "vider";
	CHAT_LOG_PALLCLEAR = "vidertout";
	--Second parameters
	CHAT_LOG_PCLEAR_WHISPER = "chuchoter";
	CHAT_LOG_PCLEAR_RAID = "raid";
	CHAT_LOG_PCLEAR_PARTY = "groupe";
	CHAT_LOG_PCLEAR_SAY = "dire";
	CHAT_LOG_PCLEAR_YELL = "crier";
	CHAT_LOG_PCLEAR_OFFICER = "officier";
	CHAT_LOG_PCLEAR_GUILD = "guilde";
	
	--SLASHCOMMANDS HELP
	CHAT_LOG_PHELP_TITLE = "Commandes de ChatLog:";
	CHAT_LOG_PHELP_TOGGLE = "Ouvrir/Fermer ChatLog.";
	CHAT_LOG_PHELP_RESET = "Réinitialiser toutes les fenêtres.";
	CHAT_LOG_PHELP_RESETBUTTON = "Réinitialiser le bouton de ChatLog.";
	CHAT_LOG_PHELP_CLEAR = "Supprime le log spécifié.";
	CHAT_LOG_PHELP_ALLCLEAR = "Supprime tous les logs.";
	CHAT_LOG_PHELP_HELP = "Affiche ce message.";

	--GENERAL INFORMATION
	CHAT_LOG_LOADED_MESSAGE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION .. " chargé. Tapez /chatlog " .. CHAT_LOG_PHELP .. " pour les commandes."
	CHAT_LOG_CLEARED_MESSAGE = CHAT_LOG_TITLE .. ": Logs effacés."
	CHAT_LOG_CLEARED_MESSAGE = " log effacé."
	CHAT_LOG_WRONG_PARAMETER_MESSAGE = "/chatlog clear: Mauvais paramètre."
	CHAT_LOG_LOGGING_STARTED_ON = "Log commencé le";
	CHAT_LOG_LOGGING_STARTED_AT = "à";
	CHAT_LOG_LOGGING_STOPPED_AT = "Log arrêté à";
	CHAT_LOG_PLAYER_RECEIVE_WHISPER = "chuchote";
	CHAT_LOG_PLAYER_SEND_WHISPER = "A";
	CHAT_LOG_ENABLED_ALL = CHAT_LOG_TITLE .. ": Tous les chats seront enregistrés.";
	CHAT_LOG_DISABLED_ALL = CHAT_LOG_TITLE .. ": Arrêt des enregistrements.";
	
	-- DIALOGS
	CHAT_LOG_DIALOG_CLEARALL_TEXT = "Cela va effacer tous les logs.";
	CHAT_LOG_DIALOG_CLEARALL_BUTTON1 = "Ok";
	CHAT_LOG_DIALOG_CLEARALL_BUTTON2 = "Annuler";
end