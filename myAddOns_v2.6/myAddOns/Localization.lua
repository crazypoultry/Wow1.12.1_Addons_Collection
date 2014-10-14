-- myAddOns v2.6 --


--------------------------------------------------------------------------------------------------
-- Localized global variables
--------------------------------------------------------------------------------------------------

MYADDONS_HELP = {
	"FAQ\n===\n\nQ: My AddOn XYZ is not listed! Why??\n\nA: Check if you enabled it at the character selection screen. Check if it has a required dependency that is missing.\n\nQ: I get the following error in my chat: \"Error during the registration of <addon> in myAddOns.\". What does it mean?\n\nA: This error message means that the AddOn named \"<addon>\" is trying to register with an unknown name/title. Check with the author if he can update his AddOn to make it compatible with the new registration method. Anyway this has no impact on the gameplay or on myAddOns so everything should be working okay."
};
MYADDONS_TAB_DETAILS = "Details";
MYADDONS_TAB_HELP = "Help";
MYADDONS_TAB_LOAD = "Load";
MYADDONS_BUTTON_LOAD = "Load";
MYADDONS_BUTTON_OPTIONS = "Options";
MYADDONS_BUTTON_ADD = "Add";
MYADDONS_BUTTON_REMOVE = "Remove";
MYADDONS_LABEL_RELEASE_DATE = "Release Date";
MYADDONS_LABEL_AUTHOR = "Author";
MYADDONS_LABEL_WEBSITE = "Website";
MYADDONS_LABEL_DESCRIPTION = "Description";
MYADDONS_LABEL_NOTES = "Notes";
MYADDONS_LABEL_MANUAL = "Manual";
MYADDONS_LABEL_AUTOMATIC = "Automatic";
MYADDONS_LABEL_CLASS = "Automatic per class";
MYADDONS_LABEL_DRUID = "Druid";
MYADDONS_LABEL_HUNTER = "Hunter";
MYADDONS_LABEL_MAGE = "Mage";
MYADDONS_LABEL_PALADIN = "Paladin";
MYADDONS_LABEL_PRIEST = "Priest";
MYADDONS_LABEL_ROGUE = "Rogue";
MYADDONS_LABEL_SHAMAN = "Shaman";
MYADDONS_LABEL_WARLOCK = "Warlock";
MYADDONS_LABEL_WARRIOR = "Warrior";
MYADDONS_LABEL_CHARACTER = "Automatic per character";
MYADDONS_CLICK_COPY = "Click to copy the address";
MYADDONS_ADDRESS_COPY = "You can copy the address below.";
MYADDONS_CATEGORY_AUDIO = "Audio";
MYADDONS_CATEGORY_BARS = "Bars";
MYADDONS_CATEGORY_BATTLEGROUNDS = "Battlegrounds";
MYADDONS_CATEGORY_CHAT = "Chat";
MYADDONS_CATEGORY_CLASS = "Class";
MYADDONS_CATEGORY_COMBAT = "Combat";
MYADDONS_CATEGORY_COMPILATIONS = "Compilations";
MYADDONS_CATEGORY_DEVELOPMENT = "Development";
MYADDONS_CATEGORY_GUILD = "Guild";
MYADDONS_CATEGORY_INVENTORY = "Inventory";
MYADDONS_CATEGORY_MAP = "Map";
MYADDONS_CATEGORY_OTHERS = "Others";
MYADDONS_CATEGORY_PLUGINS = "Plugins";
MYADDONS_CATEGORY_PROFESSIONS = "Professions";
MYADDONS_CATEGORY_QUESTS = "Quests";
MYADDONS_CATEGORY_RAID = "Raid";
MYADDONS_CATEGORY_UNKNOWN = "Unknown";
MYADDONS_REGISTRATION_ERROR = "Error during the registration of addon in myAddOns.";
MYADDONS_NOT_LOADED = "Not loaded";
MYADDONS_NOT_LOAD_ONDEMAND = "This AddOn is not load on demand.";

-- Get the client language
local clientLanguage = GetLocale();

-- Check the client language
if (clientLanguage == "deDE") then
	MYADDONS_HELP = {
		"FAQ\n===\n\nF: Mein AddOn XYZ ist nicht in der Liste! Warum das??\n\nA: Das AddOn muss im Charakterwahl Bildschirm unter Addons aktiviert sein. Überprüfe auch eventuelle Abhängigkeiten.\n\nF: Ich habe folgenden Fehler in meinem Chat: \"Fehler während der Addonregistrierung des AddOns <addon> in myAddOns.\". Was bedeutet diese Fehlermeldung?\n\nA: Diese Meldung bedeutet, dass das AddOn \"<addon>\" einen unbekannten Name/Titel benutzt, um sich im myAddOns zu registrieren. Fragen Sie den Autor ob er das Addon an die neue Registrierungsmethode von myAddOns anpassen kann. Dies hat auf jeden Fall keinerlei Auswirkungen auf den Spielfluss oder die Funktion von myAddOns, alles sollte wie gewohnt funktionieren."
	};
	MYADDONS_TAB_DETAILS = "Einzelheiten";
	MYADDONS_TAB_HELP = "Hilfe";
	MYADDONS_TAB_LOAD = "Geladen";
	MYADDONS_BUTTON_LOAD = "Laden";
	MYADDONS_BUTTON_OPTIONS = "Optionen";
	MYADDONS_BUTTON_ADD = "Hinzufügen";
	MYADDONS_BUTTON_REMOVE = "Entfernen";
	MYADDONS_LABEL_RELEASE_DATE = "Datum";
	MYADDONS_LABEL_AUTHOR = "Autor";
	MYADDONS_LABEL_WEBSITE = "Webseite";
	MYADDONS_LABEL_DESCRIPTION = "Beschreibung";
	MYADDONS_LABEL_NOTES = "Anmerkungen";
	MYADDONS_LABEL_MANUAL = "Manuell";
	MYADDONS_LABEL_AUTOMATIC = "Automatisch";
	MYADDONS_LABEL_CLASS = "Automatisch pro Klasse";
	MYADDONS_LABEL_DRUID = "Druide";
	MYADDONS_LABEL_HUNTER = "Jäger";
	MYADDONS_LABEL_MAGE = "Magier";
	MYADDONS_LABEL_PALADIN = "Paladin";
	MYADDONS_LABEL_PRIEST = "Priester";
	MYADDONS_LABEL_ROGUE = "Schurke";
	MYADDONS_LABEL_SHAMAN = "Schamane";
	MYADDONS_LABEL_WARLOCK = "Hexenmeister";
	MYADDONS_LABEL_WARRIOR = "Krieger";
	MYADDONS_LABEL_CHARACTER = "Automatisch pro Charakter";
	MYADDONS_CLICK_COPY = "Klicken um die Addresse zu kopieren";
	MYADDONS_ADDRESS_COPY = "Sie können die Adresse kopieren.";
	MYADDONS_CATEGORY_AUDIO = "Audio";
	MYADDONS_CATEGORY_BARS = "Leisten";
	MYADDONS_CATEGORY_BATTLEGROUNDS = "Schlachtfelder";
	MYADDONS_CATEGORY_CHAT = "Chat";
	MYADDONS_CATEGORY_CLASS = "Klasse";
	MYADDONS_CATEGORY_COMBAT = "Kampf";
	MYADDONS_CATEGORY_COMPILATIONS = "Kompilationen";
	MYADDONS_CATEGORY_DEVELOPMENT = "Entwicklung";
	MYADDONS_CATEGORY_GUILD = "Gilde";
	MYADDONS_CATEGORY_INVENTORY = "Inventar";
	MYADDONS_CATEGORY_MAP = "Karte";
	MYADDONS_CATEGORY_OTHERS = "Andere";
	MYADDONS_CATEGORY_PLUGINS = "Plugins";
	MYADDONS_CATEGORY_PROFESSIONS = "Berufe";
	MYADDONS_CATEGORY_QUESTS = "Quests";
	MYADDONS_CATEGORY_RAID = "Schlachtzug";
	MYADDONS_CATEGORY_UNKNOWN = "Unbekannt";
	MYADDONS_REGISTRATION_ERROR = "Fehler während der Addonregistrierung des AddOns addon in myAddOns.";
	MYADDONS_NOT_LOADED = "Nicht geladen";
	MYADDONS_NOT_LOAD_ONDEMAND = "Diese AddOn wird nicht auf Wunsch geladen.";
elseif (clientLanguage == "frFR") then
	MYADDONS_HELP = {
		"FAQ\n===\n\nQ: Mon AddOn XYZ n'est pas listé! Pourquoi??\n\nR: Vérifiez que cet AddOn est activé sur l'écran de choix du personnage. Vérifiez qu'il n'a pas une dépendance manquante.\n\nQ: J'ai l'erreur suivante dans ma fenêtre de chat: \"Erreur lors de l'enregistrement de <addon> dans myAddOns.\". Qu'est ce que cela signifie?\n\nR: Ce message d'erreur signifie que l'AddOn nommé \"<addon>\" essaie de s'enregistrer avec un nom/titre inconnu. Vérifiez avec l'auteur s'il peut mettre à jour son AddOn afin d'utiliser la nouvelle méthode d'enregistrement. En tous cas, ceci n'a aucun effet sur le jeu ni sur le bon fonctionnement de myAddOns."
	};
	MYADDONS_TAB_DETAILS = "Détails";
	MYADDONS_TAB_HELP = "Aide";
	MYADDONS_TAB_LOAD = "Chargement";
	MYADDONS_BUTTON_LOAD = "Charger";
	MYADDONS_BUTTON_OPTIONS = "Options";
	MYADDONS_BUTTON_ADD = "Ajouter";
	MYADDONS_BUTTON_REMOVE = "Retirer";
	MYADDONS_LABEL_RELEASE_DATE = "Date";
	MYADDONS_LABEL_AUTHOR = "Auteur";
	MYADDONS_LABEL_WEBSITE = "Site web";
	MYADDONS_LABEL_DESCRIPTION = "Description";
	MYADDONS_LABEL_NOTES = "Notes";
	MYADDONS_LABEL_MANUAL = "Manuel";
	MYADDONS_LABEL_AUTOMATIC = "Automatique";
	MYADDONS_LABEL_CLASS = "Automatique par classe";
	MYADDONS_LABEL_DRUID = "Druide";
	MYADDONS_LABEL_HUNTER = "Chasseur";
	MYADDONS_LABEL_MAGE = "Mage";
	MYADDONS_LABEL_PALADIN = "Paladin";
	MYADDONS_LABEL_PRIEST = "Prêtre";
	MYADDONS_LABEL_ROGUE = "Voleur";
	MYADDONS_LABEL_SHAMAN = "Chaman";
	MYADDONS_LABEL_WARLOCK = "Démoniste";
	MYADDONS_LABEL_WARRIOR = "Guerrier";
	MYADDONS_LABEL_CHARACTER = "Automatique par personnage";
	MYADDONS_CLICK_COPY = "Clickez pour copier l'addresse";
	MYADDONS_ADDRESS_COPY = "Vous pouvez copier l'adresse ci-dessous.";
	MYADDONS_CATEGORY_AUDIO = "Audio";
	MYADDONS_CATEGORY_BARS = "Barres";
	MYADDONS_CATEGORY_BATTLEGROUNDS = "Champs de bataille";
	MYADDONS_CATEGORY_CHAT = "Chat";
	MYADDONS_CATEGORY_CLASS = "Classe";
	MYADDONS_CATEGORY_COMBAT = "Combat";
	MYADDONS_CATEGORY_COMPILATIONS = "Compilations";
	MYADDONS_CATEGORY_DEVELOPMENT = "Développement";
	MYADDONS_CATEGORY_GUILD = "Guilde";
	MYADDONS_CATEGORY_INVENTORY = "Inventaire";
	MYADDONS_CATEGORY_MAP = "Carte";
	MYADDONS_CATEGORY_OTHERS = "Autres";
	MYADDONS_CATEGORY_PLUGINS = "Plugins";
	MYADDONS_CATEGORY_PROFESSIONS = "Professions";
	MYADDONS_CATEGORY_QUESTS = "Quêtes";
	MYADDONS_CATEGORY_RAID = "Raid";
	MYADDONS_CATEGORY_UNKNOWN = "Inconnu";
	MYADDONS_REGISTRATION_ERROR = "Erreur lors de l'enregistrement de addon dans myAddOns.";
	MYADDONS_NOT_LOADED = "Non chargé";
	MYADDONS_NOT_LOAD_ONDEMAND = "Cet AddOn n'est pas chargé à la demande.";
end
