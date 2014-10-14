------------------------------------------------------------------------------
-- Globals required by localized tables
------------------------------------------------------------------------------
INNERFIRE_EM = {
	ON = "|cffffff00",					-- Yellow (default emphasis color)
	RED = "|cffff4000",					-- Red (used for warnings)
	OFF = "|r",
};


------------------------------------------------------------------------------
-- English localization (default)
--
-- Original text by Cirk
------------------------------------------------------------------------------
INNERFIRE_TEXT = {
	-- Name of spell in spellbook
	SPELLNAME_INNER_FIRE = "Inner Fire",

	-- Slash commands
	COMMAND_HELP = "help",
	COMMAND_ON = "on",
	COMMAND_ENABLE = "enable",
	COMMAND_OFF = "off",
	COMMAND_DISABLE = "disable",
	COMMAND_STATUS = "status",
	COMMAND_DEBUGON = "debugon",
	COMMAND_DEBUGOFF = "debugoff",

	-- Slash command responses
	COMMAND_ENABLE_CONFIRM = INNERFIRE_EM.ON.."Innerfire is enabled"..INNERFIRE_EM.OFF,
	COMMAND_DISABLE_CONFIRM = INNERFIRE_EM.ON.."Innerfire is disabled"..INNERFIRE_EM.OFF,
	COMMAND_ENABLE_FAILED = INNERFIRE_EM.RED.."Innerfire cannot be enabled for your class"..INNERFIRE_EM.OFF,
	COMMAND_ENABLED_STATUS = INNERFIRE_EM.ON.."Innerfire is currently enabled"..INNERFIRE_EM.OFF,
	COMMAND_DISABLED_STATUS = INNERFIRE_EM.ON.."Innerfire is currently disabled"..INNERFIRE_EM.OFF,
	COMMAND_UNABLE_STATUS = INNERFIRE_EM.ON.."Innerfire is not enabled for your class"..INNERFIRE_EM.OFF,
	COMMAND_DEBUGON_CONFIRM = "Innerfire debug is enabled",
	COMMAND_DEBUGOFF_CONFIRM = "Innerfire debug is disabled",

	-- Debug header
	DEBUG = INNERFIRE_EM.ON.."Innerfire: "..INNERFIRE_EM.OFF;
};

-- Help text
INNERFIRE_HELP = {
	INNERFIRE_EM.ON.."Provides a counter showing how many charges remain on a priest's Inner Fire buff"..INNERFIRE_EM.OFF,
	"   /innerfire "..INNERFIRE_TEXT.COMMAND_HELP..INNERFIRE_EM.ON.." shows this help message"..INNERFIRE_EM.OFF,
	"   /innerfire "..INNERFIRE_TEXT.COMMAND_ON..INNERFIRE_EM.ON.." enables Innerfire"..INNERFIRE_EM.OFF,
	"   /innerfire "..INNERFIRE_TEXT.COMMAND_OFF..INNERFIRE_EM.ON.." disables Innerfire"..INNERFIRE_EM.OFF,
	"   /innerfire "..INNERFIRE_TEXT.COMMAND_STATUS..INNERFIRE_EM.ON.." shows the status of Innerfire"..INNERFIRE_EM.OFF,
	INNERFIRE_EM.ON.."Also provides the macro-callable function "..INNERFIRE_EM.OFF.."HasInnerFire(minCharges, minDuration)"
};


------------------------------------------------------------------------------
-- French localization
------------------------------------------------------------------------------
if (GetLocale() == "frFR") then

end


------------------------------------------------------------------------------
-- German localization
------------------------------------------------------------------------------
if (GetLocale() == "deDE") then

end
