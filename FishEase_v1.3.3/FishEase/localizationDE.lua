-- Version : German (thanks to Maischter and Xinari)
-- Last Update : 10/15/2005



if ( GetLocale() == "deDE" ) then

FE_BOBBER_NAME        = "Blinker";

-- binding strings
BINDING_HEADER_FE_BINDS   = FE_ADDON_NAME;
BINDING_NAME_FE_CAST      = "Start Fishing";
BINDING_NAME_FE_SWITCH    = "Switch Gear";
BINDING_NAME_FE_TURNORACTION = "Hijacked";

-- commands
FE_CMD_EASYCAST  = "EasyCast";
FE_CMD_SHIFTCAST = "ShiftCast";
FE_CMD_SAFEMODE  = "BoxMode";
FE_CMD_STICKYBOX = "StickyBox";
FE_CMD_SWITCH    = "Switch";
FE_CMD_RESET     = "Reset";
FE_CMD_LOCK      = "Lock";
FE_CMD_UNLOCK    = "Unlock";
FE_CMD_FIX       = "FixMe"

-- syntax
FE_SYNTAX_ERROR     = FE_ADDON_NAME.." Syntaxfehler: ";
FE_SYNTAX_EASYCAST  = " |cff00ff00"..FE_CMD_EASYCAST.. "|r [|cffffff00on|r | |cffffff00off|r] (Das Rechtklicken wirft, waehrend ein Angel ausgeruestet wird.)";
FE_SYNTAX_SHIFTCAST = " |cff00ff00"..FE_CMD_SHIFTCAST.."|r [|cffffff00on|r | |cffffff00off|r] (Benoetigt das Anhalten der Umschalttaste, um EasyCast zu verwenden.)";
FE_SYNTAX_SAFEMODE  = " |cff00ff00"..FE_CMD_SAFEMODE.. "|r [|cffffff00on|r | |cffffff00off|r] (Enables the new fishing box method of click casting.)";
FE_SYNTAX_STICKYBOX = " |cff00ff00"..FE_CMD_STICKYBOX.."|r [|cffffff00on|r | |cffffff00off|r] (Fishing box stays on screen when not in fishing gear.)";
FE_SYNTAX_SWITCH    = " |cff00ff00"..FE_CMD_SWITCH..   "|r (Schalten Sie zwischen Ihre Fischereiausruestung und normales Zahnrad.)";
FE_SYNTAX_RESET     = " |cff00ff00"..FE_CMD_RESET..    "|r (Loescht Ihre gesicherten Zahnradsets.)";
FE_SYNTAX_LOCK      = " |cff00ff00"..FE_CMD_LOCK..     "|r (Locks the fishing box wherever you placed it.)";
FE_SYNTAX_UNLOCK    = " |cff00ff00"..FE_CMD_UNLOCK..   "|r (Unlocks the fishing box so you can drag it.)";
FE_SYNTAX_FIX       = " |cff00ff00"..FE_CMD_FIX..      "|r (Resets the fishing box to the center of the screen.)";

-- Command Help
FE_COMMAND_HELP = {
	"/fishease or /fe |cff00ff00<command>|r |cffffff00[args]|r um die folgenden Befehle durchzufuehren:",
	FE_SYNTAX_EASYCAST,
	FE_SYNTAX_SHIFTCAST,
--	FE_SYNTAX_SAFEMODE,
--	FE_SYNTAX_STICKYBOX,
	FE_SYNTAX_SWITCH,
	FE_SYNTAX_RESET,
--	FE_SYNTAX_LOCK,
--	FE_SYNTAX_UNLOCK,
--	FE_SYNTAX_FIX,
}

-- Output Strings
FE_OUT_SET_POLE           = "Angel auf %s eingestellt.";
FE_OUT_SET_MAIN           = "Waffenhand auf %s eingestellt.";
FE_OUT_SET_SECONDARY      = "Schildhand auf %s eingestellt.";
FE_OUT_SET_FISHING_GLOVES = "Angelhandschuhe auf %s eingestellt.";
FE_OUT_SET_FISHING_HAT    = "Angelhut auf %s eingestellt.";
FE_OUT_SET_FISHING_BOOT   = "Angelschuhe auf %s eingestellt.";
FE_OUT_SET_GLOVES         = "Normale Handschuhe auf %s eingestellt.";
FE_OUT_SET_HAT            = "Normale Hut auf %s eingestellt.";
FE_OUT_SET_BOOT           = "Normale Schuhe auf %s eingestellt.";
FE_OUT_NEED_SET_POLE      = "Bitte die Angel, die benutzt werden soll, in die Hand nehmen und nochmal versuchen.";
FE_OUT_NEED_SET_NORMAL    = "Bitte die Waffe, die benutzt werden soll, in die Hand nehmen und nochmal versuchen.";
FE_OUT_ON                 = "|cff32c8ffaktiviert|r";
FE_OUT_OFF                = "|cffffc832deaktiviet|r";
FE_OUT_EASYCAST           = " |cff00ff00"..FE_CMD_EASYCAST.. "|r (Einfaches Werfen)";
FE_OUT_SHIFTCAST          = " |cff00ff00"..FE_CMD_SHIFTCAST.."|r (Shift Werfen)";
FE_OUT_RESET              = "Ihre gesicherten Zahnradsets sind zurueckgesetzt worden.";
FE_OUT_LOCKED             = "The fishing box is now locked in place.";
FE_OUT_UNLOCKED           = "The fishing box is now unlocked. Drag it with the left mouse button.";
FE_OUT_SAFEMODE           = " |cff00ff00"..FE_CMD_SAFEMODE.. "|r (Box right-click casting)";
FE_OUT_STICKYBOX          = " |cff00ff00"..FE_CMD_STICKYBOX.."|r (Box never fully hides)";

end