-- myClock v1.8 --


--------------------------------------------------------------------------------------------------
-- Localized global variables
--------------------------------------------------------------------------------------------------

MYCLOCK_RELEASE_DATE = "March 30, 2006";
MYCLOCK_HELP_PAGE1 = "Usage\n=====\n\nTo access the options window, you can use the \"/myclock\" command or this AddOn manager.\n\nThe default options are:\n\n     - Show Clock = Yes\n     - Show Day/Night Button = No\n     - Lock Position = Yes\n     - Half-hour Offsets = No\n     - Time Format = 12 Hours\n     - Offset = 0 Hour";
MYCLOCK_LOADED = "myClock AddOn loaded";
MYCLOCK_OPTIONS_TITLE = "myClock Options";
MYCLOCK_OPTIONS_SHOW_CLOCK = "Show Clock";
MYCLOCK_OPTIONS_SHOW_DAYNIGHT = "Show Day/Night Button";
MYCLOCK_OPTIONS_LOCK = "Lock Position";
MYCLOCK_OPTIONS_HALFHOUR_OFFSETS = "Half-hour Offsets";
MYCLOCK_OPTIONS_TIME_FORMAT = "Time Format";
MYCLOCK_OPTIONS_OFFSET = "Offset";
MYCLOCK_OPTIONS_HOURS = " Hours";
MYCLOCK_DEFAULT_TIME_FORMAT = 12;

-- Get the client language
local clientLanguage = GetLocale();

-- Check the client language
if (clientLanguage == "deDE") then
	MYCLOCK_RELEASE_DATE = "30. März 2006";
	MYCLOCK_HELP_PAGE1 = "Benutzung\n========\n\nSie können den \"/myclock\" Befehl oder diesen AddOn-Manager benutzen um das Optionenfenster zu öffnen.\n\nDie Standardoptionen sind:\n\n     - Uhr anzeigen = Ja\n     - Tag/Nacht Knopf anzeigen = Nein\n     - Sperre Position = Ja\n     - Halbstunde Zeitunterschiede = Nein\n     - Zeitformat = 24 Stunden\n     - Zeitunterschied = 0 Stunde";
	MYCLOCK_LOADED = "myClock AddOn geladen";
	MYCLOCK_OPTIONS_TITLE = "myClock Optionen";
	MYCLOCK_OPTIONS_SHOW_CLOCK = "Uhr anzeigen";
	MYCLOCK_OPTIONS_SHOW_DAYNIGHT = "Tag/Nacht Knopf anzeigen";
	MYCLOCK_OPTIONS_LOCK = "Sperre Position";
	MYCLOCK_OPTIONS_HALFHOUR_OFFSETS = "Halbstunde Zeitunterschiede";
	MYCLOCK_OPTIONS_TIME_FORMAT = "Zeitformat";
	MYCLOCK_OPTIONS_OFFSET = "Zeitunterschied";
	MYCLOCK_OPTIONS_HOURS = " Stunden";
	MYCLOCK_DEFAULT_TIME_FORMAT = 24;
elseif (clientLanguage == "frFR") then
	MYCLOCK_RELEASE_DATE = "30 Mars 2006";
	MYCLOCK_HELP_PAGE1 = "Utilisation\n========\n\nPour ouvrir la fenêtre des options, vous pouvez utiliser la commande \"/myclock\" ou ce gestionnaire d'AddOn.\n\nLes options par défaut sont:\n\n     - Afficher l'horloge = Oui\n     - Afficher le bouton Jour/Nuit = Non\n     - Verrouiller la position = Oui\n     - Décalages d'une-demie heure = Non\n     - Affichage de l'heure = 24 Heures\n     - Décalage = 0 Heure";
	MYCLOCK_LOADED = "AddOn myClock chargé";
	MYCLOCK_OPTIONS_TITLE = "myClock Options";
	MYCLOCK_OPTIONS_SHOW_CLOCK = "Afficher l'horloge";
	MYCLOCK_OPTIONS_SHOW_DAYNIGHT = "Afficher le bouton Jour/Nuit";
	MYCLOCK_OPTIONS_LOCK = "Verrouiller la position";
	MYCLOCK_OPTIONS_HALFHOUR_OFFSETS = "Décalages d'une demie-heure";
	MYCLOCK_OPTIONS_TIME_FORMAT = "Affichage de l'heure";
	MYCLOCK_OPTIONS_OFFSET = "Décalage";
	MYCLOCK_OPTIONS_HOURS = " Heures";
	MYCLOCK_DEFAULT_TIME_FORMAT = 24;
end
