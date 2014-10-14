
STATUSBARS_INVALID_TARGET		= 'Invalid target "';
STATUSBARS_OR_OPTION			= '" or option "';
STATUSBARS_INVALID_VALUE		= 'Invalid value "';
STATUSBARS_FOR_OPTION			= '" for option "';
STATUSBARS_SYNTAX_LOCK			= 'Syntax: /statusbars (lock||unlock)';
STATUSBARS_SYNTAX_LOAD			= 'Syntax: /statusbars (load||save) (<name>||defaults)';
STATUSBARS_SYNTAX			= 'Syntax: /statusbars <target> <option> (<value>||print||reset)';
STATUSBARS_TARGETS			= 'Targets: ';
STATUSBARS_OPTIONS			= 'Options: ';
STATUSBARS_INVALID_COLOR		= 'Invalid color expression "';
STATUSBARS_MULTIPLE_DEFAULT_COLOR	= 'Color expression contains multiple defaults "';
STATUSBARS_NO_DEFAULT_COLOR		= 'Color expression does not contain a default "';
STATUSBARS_UNKNOWN_OPERATOR		= 'Unknown operator "';
STATUSBARS_DRUID			= 'Druid';
STATUSBARS_LOCKED			= 'StatusBars is now locked, use "/statusbars unlock" to unlock';
STATUSBARS_UNLOCKED			= 'StatusBars is now unlocked, use "/statusbars lock" to lock';
STATUSBARS_LOAD_NONEXISTANT		= 'Could not load settings, nothing is saved under the name "';
STATUSBARS_DEFAULTS_LOADED		= 'Defaults loaded.';
STATUSBARS_LOADED			= 'Loaded settings from "';
STATUSBARS_SAVED			= 'Saved settings to "';
STATUSBARS_NO_SAVEDEFAULTS		= 'Defaults cannot be overwritten';

if GetLocale() == "frFR" then
	-- Traduit par Juki <Unskilled>

	STATUSBARS_INVALID_TARGET		= 'Cible non valide "';
	STATUSBARS_OR_OPTION			= '" ou option "';
	STATUSBARS_INVALID_VALUE		= 'Valeur non valide "';
	STATUSBARS_FOR_OPTION			= '" pour l’option "';
	STATUSBARS_SYNTAX_LOCK			= 'Syntaxe : /statusbars (lock||unlock)';
	STATUSBARS_SYNTAX			= 'Syntaxe : /statusbars <cible> <option> (<valeur>||print||reset)';
	STATUSBARS_TARGETS			= 'Cibles : ';
	STATUSBARS_OPTIONS			= 'Options : ';
	STATUSBARS_INVALID_COLOR		= 'Expression de couleur non valide "';
	STATUSBARS_MULTIPLE_DEFAULT_COLOR	= 'L’expression de couleur contient plusieurs couleurs par défaut "';
	STATUSBARS_NO_DEFAULT_COLOR		= 'L’expression de couleur ne contient pas de couleur par défaut "';
	STATUSBARS_UNKNOWN_OPERATOR		= 'Opérateur Inconnu "';
	STATUSBARS_DRUID			= 'Druide';

elseif GetLocale() == "deDE" then
	-- By Tenvan

	STATUSBARS_INVALID_TARGET		= 'Ungültiges Ziel "';
	STATUSBARS_OR_OPTION			= '" oder Option "';
	STATUSBARS_INVALID_VALUE		= 'Ungültiger Wert "';
	STATUSBARS_FOR_OPTION			= '" für Option "';
	STATUSBARS_SYNTAX			= 'Syntax: /statusbars <Ziel> <Option> (<Wert>||print||reset)';
	STATUSBARS_TARGETS			= 'Ziele: ';
	STATUSBARS_OPTIONS			= 'Optionen: ';
	STATUSBARS_INVALID_COLOR		= 'Ungültige Farbdefinition "';
	STATUSBARS_MULTIPLE_DEFAULT_COLOR	= 'Farbdefinition enthält mehrere Standards "';
	STATUSBARS_NO_DEFAULT_COLOR		= 'Farbdefinition enthält keinen Standard "';
	STATUSBARS_UNKNOWN_OPERATOR		= 'Unbekannter Operator "';
	STATUSBARS_DRUID			= 'Druide';

end
