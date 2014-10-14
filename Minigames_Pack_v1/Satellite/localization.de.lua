--[[
--------------------------------------------------
	File: localization.de.lua
	Addon: Satellite
	Language: German
	Translation by : StarDust
	Last Update : 7/12/2006
--------------------------------------------------
]]--

if ( GetLocale() == "deDE" ) then

	-- /print
	SATELLITE_PRINT_COMMANDS	= {"/print", "/ausgabe"};
	SATELLITE_PRINT_HEADER		= "Ausgabe: ";
	SATELLITE_PRINT_HEADER2		= "[Ausgabe]: ";
	SATELLITE_PRINT_TEXT		= "Ausgeben";
	SATELLITE_PRINT_HELP		= "Gibt den ausgef\195\188hrten Code aus. Print executed code. Abk\195\188rzung f\195\188r /script Satellite. GenerateChatEvent('PRINT', table.concat( { msg } ) ); ";

	-- /printComma
	SATELLITE_PRINT_COMMA_COMMANDS	= {"/printc", "/printComma"};
	SATELLITE_PRINT_COMMA_HELP	= "Gibt die ausgef\195\188hrten Code-Variablen, getrennt durch Beistriche, aus. Abk\195\188rzung f\195\188r /script Sea.io.printComma(msg); ";

	-- /z
	SATELLITE_Z_HEADER		= "Script: ";
	SATELLITE_Z_HELP		= "Abk\195\188rzung f\195\188r das Ausf\195\188hren von /script Code.";

end