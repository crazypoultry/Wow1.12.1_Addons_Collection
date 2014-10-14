--	FearDance: Localization file.
--	General Declarations

-- Declare Constants
FEARDANCE_NAME = "FearDance";
FEARDANCE_VERSION = "v1.5";
BINDING_HEADER_FEARDANCE = FEARDANCE_NAME;
FEARDANCE_EMPTY = "";

-- Protection Types
FEARDANCE_PROTECTION_FEARWARD = "Spell_Holy_Excorcism";
FEARDANCE_PROTECTION_RAGE = "Spell_Nature_AncestralGuardian";

-- Declare Colors
COLOR_GREEN = "|cff00ff00";
COLOR_BLUE = "|cff4d4dff";
COLOR_RED = "|cffff0000";
COLOR_ORANGE = "|cffff6d00";
COLOR_PURPLE = "|cff700090";
COLOR_YELLOW = "|cffffff00";
COLOR_GREY = "|cff808080";
COLOR_OFF = "|r";

-- FearDance Header for displaying messages
FEARDANCE_HEADER = COLOR_GREEN .. FEARDANCE_NAME .. ": " .. COLOR_OFF;

-- Debug Messages. These have been removed from the final code. No need for translations.
FEARDANCE_MSG_BUFF_FOUND = FEARDANCE_HEADER .. "Buff " .. COLOR_ORANGE .. "%s" .. COLOR_OFF .. " is currently on the player.";
FEARDANCE_MSG_BUFF_NOTFOUND = FEARDANCE_HEADER .. "Buff " .. COLOR_ORANGE .. "%s" .. COLOR_OFF .. " is not on the player.";
