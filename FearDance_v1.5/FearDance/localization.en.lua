--	FearDance: Localization file.
--	Language: English

if GetLocale() == "enUS" or GetLocale() == "enGB" then

	BINDING_NAME_DOFEARDANCE = "Perform " .. FEARDANCE_NAME;
	FEARDANCE_LOADED = COLOR_GREEN .. FEARDANCE_NAME .. COLOR_OFF .. " %s is loaded.";
	FEARDANCE_BERSERKER_RAGE = "Berserker Rage";
	FEARDANCE_STANCES = {"Battle Stance", "Defensive Stance", "Berserker Stance"};
	FEARDANCE_COOLDOWN = FEARDANCE_HEADER .. "The Berserker Rage cooldown is at %.1f seconds.";

	FEARDANCE_ON = "on";
	FEARDANCE_OFF = "off";

	FEARDANCE_MSG_RAGED = FEARDANCE_HEADER .. "Using fear protection: %s.";
	FEARDANCE_MSG_FEARLESS = FEARDANCE_HEADER .. "You already have protection from fear effects.";
	FEARDANCE_MSG_STANCE = FEARDANCE_HEADER .. "Switching to stance %s.";
	FEARDANCE_MSG_NOVAR = FEARDANCE_HEADER .. "The variable you specified was not found.";
	FEARDANCE_MSG_USEHELP = FEARDANCE_HEADER .. "Use " .. COLOR_GREEN .. "/fd help" .. COLOR_OFF .. " to view all available options.";

	FEARDANCE_HELP_LONG = "help";
	FEARDANCE_HELP_SHORT = "h";

	FEARDANCE_DEBUG_LONG = "debug";
	FEARDANCE_DEBUG_SHORT = "d";
	FEARDANCE_DEBUG_TITLE = COLOR_GREEN .. "Debug:" .. COLOR_OFF;
	FEARDANCE_DEBUG_DESC1 = "This is the debug mode. It will display a more information regarding what " .. FEARDANCE_NAME .. " is doing.";
	FEARDANCE_DEBUG_DESC2 = "You must specify a value: " .. COLOR_BLUE .. FEARDANCE_ON .. COLOR_OFF .. " or " .. COLOR_BLUE .. FEARDANCE_OFF .. COLOR_OFF .. ".";
	FEARDANCE_DEBUG_SET = FEARDANCE_HEADER .. "The Debug switch has been set to " .. COLOR_BLUE .. "[%s]" .. COLOR_OFF;

	FEARDANCE_USAGE_TITLE = COLOR_GREEN .. "Usage:" .. COLOR_OFF;
	FEARDANCE_USAGE_MAIN = "   - " .. COLOR_GREEN .. "/fd" .. COLOR_OFF .. " - Performs the primary " .. FEARDANCE_NAME .. " functionality.";
	FEARDANCE_USAGE_HELP = "   - " .. COLOR_GREEN .. "/fd " .. FEARDANCE_HELP_LONG .. COLOR_OFF .. " - Displays a list of available options and their current status.";
	FEARDANCE_USAGE_DEBUG = "   - " .. COLOR_GREEN .. "/fd " .. FEARDANCE_DEBUG_LONG .. " <value>" .. COLOR_OFF .. COLOR_BLUE .. " [%s] " .. COLOR_OFF .. "- Displays more information regarding your actions.";
end
