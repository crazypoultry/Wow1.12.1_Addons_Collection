--[[
--------------------------------------------------
	File: localization.de.lua
	Addon: Sky
	Language: German
	Translation by : StarDust
	Last Update : 8/23/2006
--------------------------------------------------
]]--

if ( GetLocale() == "deDE" ) then

	-- Colored Sky
	TELEPATHY_COLOR			= "|cFF99BBCCGlobalComm|r";

	-- /command Help
	TELEPATHY_AUTOJOIN_HELP		= "Erlaubt es AddOns, GlobalComm automatisch beizutreten. Gib /gcautojoin <1/0> um automatisches Beitreten zu erlauben oder nicht.";

	-- Leave Warnings
	TELEPATHY_LEAVE_WARNING		= "|cFFFF3333Warnung!|r Das Verlassen des "..TELEPATHY_COLOR.." Channels kann dazu f\195\188hren, dass zahlreiche AddOns nicht mehr richtig funktionieren. Um denm "..TELEPATHY_COLOR.." Channel wieder beizutreten, gib /join GlobalComm ein.";

	-- Slash commands
	TELEPATHY_LIST_COMMANDS		= {SLASH_LIST_CHANNEL1, SLASH_LIST_CHANNEL2, SLASH_LIST_CHANNEL3, SLASH_LIST_CHANNEL4, SLASH_LIST_CHANNEL5, SLASH_LIST_CHANNEL6, SLASH_LIST_CHANNEL7, "/list", "/liste"};
	TELEPATHY_AUTOJOIN_COMMANDS	= {"/gcautojoin", "/gcautobeitreten"};

end