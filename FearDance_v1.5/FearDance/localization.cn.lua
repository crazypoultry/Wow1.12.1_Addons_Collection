--	FearDance: Localization file.
--	Language: Simplified Chinese

if GetLocale() == "zhCN" then

	BINDING_NAME_DOFEARDANCE = "Perform " .. FEARDANCE_NAME;		-- [Todo: Translate]
	FEARDANCE_LOADED = COLOR_GREEN .. FEARDANCE_NAME .. COLOR_OFF .. " %s is loaded.";		-- [Todo: Translate]
	FEARDANCE_BERSERKER_RAGE = "\231\139\130\230\154\180\228\185\139\230\128\146";
	FEARDANCE_STANCES = {"\230\136\152\230\150\151\229\167\191\230\128\191", "\233\152\178\229\190\161\229\167\191\230\128\191", "\231\139\130\230\154\180\229\167\191\230\128\191"};
	FEARDANCE_COOLDOWN = FEARDANCE_HEADER .. "The Berserker Rage cooldown is at %.1f seconds.";		-- [Todo: Translate]

	FEARDANCE_ON = "on";		-- [Todo: Translate]
	FEARDANCE_OFF = "off";		-- [Todo: Translate]

	FEARDANCE_MSG_RAGED = FEARDANCE_HEADER .. "Using fear protection: %s.";		-- [Todo: Translate]
	FEARDANCE_MSG_FEARLESS = FEARDANCE_HEADER .. "You already have protection from fear effects.";		-- [Todo: Translate]
	FEARDANCE_MSG_STANCE = FEARDANCE_HEADER .. "Switching to stance %s.";		-- [Todo: Translate]
	FEARDANCE_MSG_NOVAR = FEARDANCE_HEADER .. "The variable you specified was not found.";		-- [Todo: Translate]
	FEARDANCE_MSG_USEHELP = FEARDANCE_HEADER .. "Use " .. COLOR_GREEN .. "/fd help" .. COLOR_OFF .. " to view all available options.";		-- [Todo: Translate]

	FEARDANCE_HELP_LONG = "help";		-- [Todo: Translate]
	FEARDANCE_HELP_SHORT = "h";		-- [Todo: Translate]

	FEARDANCE_DEBUG_LONG = "debug";		-- [Todo: Translate]
	FEARDANCE_DEBUG_SHORT = "d";		-- [Todo: Translate]
	FEARDANCE_DEBUG_TITLE = COLOR_GREEN .. "Debug:" .. COLOR_OFF;		-- [Todo: Translate]
	FEARDANCE_DEBUG_DESC1 = "This is the debug mode. It will display a more information regarding what " .. FEARDANCE_NAME .. " is doing.";		-- [Todo: Translate]
	FEARDANCE_DEBUG_DESC2 = "You must specify a value: " .. COLOR_BLUE .. FEARDANCE_ON .. COLOR_OFF .. " or " .. COLOR_BLUE .. FEARDANCE_OFF .. COLOR_OFF .. ".";		-- [Todo: Translate]
	FEARDANCE_DEBUG_SET = FEARDANCE_HEADER .. "The Debug switch has been set to " .. COLOR_BLUE .. "[%s]" .. COLOR_OFF;		-- [Todo: Translate]

	FEARDANCE_USAGE_TITLE = COLOR_GREEN .. "Usage:" .. COLOR_OFF;		-- [Todo: Translate]
	FEARDANCE_USAGE_MAIN = "   - " .. COLOR_GREEN .. "/fd" .. COLOR_OFF .. " - Performs the primary " .. FEARDANCE_NAME .. " functionality.";		-- [Todo: Translate]
	FEARDANCE_USAGE_HELP = "   - " .. COLOR_GREEN .. "/fd " .. FEARDANCE_HELP_LONG .. COLOR_OFF .. " - Displays a list of available options and their current status.";		-- [Todo: Translate]
	FEARDANCE_USAGE_DEBUG = "   - " .. COLOR_GREEN .. "/fd " .. FEARDANCE_DEBUG_LONG .. " <value>" .. COLOR_OFF .. COLOR_BLUE .. " [%s] " .. COLOR_OFF .. "- Displays more information regarding your actions.";		-- [Todo: Translate]
end
