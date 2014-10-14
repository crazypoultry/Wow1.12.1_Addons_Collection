--[[
--------------------------------------------------
	File: localization.fr.lua
	Addon: Sky
	Language: French
	Translation by : Sasmira
	Last Update : 8/23/2006
--------------------------------------------------
]]--

if ( GetLocale() == "frFR" ) then

-- Colored Sky
TELEPATHY_COLOR = "|cFF99BBCCGlobalComm|r";

-- /command Help
TELEPATHY_AUTOJOIN_HELP = "Autorise les addons \195\160 joindre automatiquement le GlobalComm. Taper /gcautojoin <1/0> pour autoriser ou interdire l\'Entr\195\169e/D\195\169part automatique.";

-- Leave Warnings
TELEPATHY_LEAVE_WARNING = "|cFFFF3333Attention!|r Quitter le canal "..TELEPATHY_COLOR.." peut vous faire perdre la capacit\195\169 d\'utilisation de quelques mods. Si vous souhaitez r\195\169activer le canal "..TELEPATHY_COLOR..", taper /join GlobalComm.";

-- Slash commands
TELEPATHY_LIST_COMMANDS = {SLASH_LIST_CHANNEL1, SLASH_LIST_CHANNEL2, SLASH_LIST_CHANNEL3, SLASH_LIST_CHANNEL4, SLASH_LIST_CHANNEL5, SLASH_LIST_CHANNEL6, SLASH_LIST_CHANNEL7, "/list"};
TELEPATHY_AUTOJOIN_COMMANDS =  {"/gcautojoin"};

end
