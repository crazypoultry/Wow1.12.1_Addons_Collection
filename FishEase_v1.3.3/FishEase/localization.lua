-- Version : English Default (by Aalny)
-- Last Update : 04/01/2005

-- version strings
FE_ADDON_NAME  = "FishEase";
FE_ADDON_VER   = "1.3.3";

FE_BOBBER_NAME        = "Fishing Bobber";

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
FE_SYNTAX_ERROR     = FE_ADDON_NAME.." Syntax Error: ";
FE_SYNTAX_EASYCAST  = " |cff00ff00"..FE_CMD_EASYCAST.. "|r [|cffffff00on|r | |cffffff00off|r] (Right clicking will cast while a fishing pole is equipped.)";
FE_SYNTAX_SHIFTCAST = " |cff00ff00"..FE_CMD_SHIFTCAST.."|r [|cffffff00on|r | |cffffff00off|r] (Requires holding the Shift key to use EasyCast.)";
FE_SYNTAX_SAFEMODE  = " |cff00ff00"..FE_CMD_SAFEMODE.. "|r [|cffffff00on|r | |cffffff00off|r] (Enables the new fishing box method of click casting.)";
FE_SYNTAX_STICKYBOX = " |cff00ff00"..FE_CMD_STICKYBOX.."|r [|cffffff00on|r | |cffffff00off|r] (Fishing box stays on screen when not in fishing gear.)";
FE_SYNTAX_SWITCH    = " |cff00ff00"..FE_CMD_SWITCH..   "|r (Switch between your fishing gear and regular gear.)";
FE_SYNTAX_RESET     = " |cff00ff00"..FE_CMD_RESET..    "|r (Clears your saved gear sets.)";
FE_SYNTAX_LOCK      = " |cff00ff00"..FE_CMD_LOCK..     "|r (Locks the fishing box wherever you placed it.)";
FE_SYNTAX_UNLOCK    = " |cff00ff00"..FE_CMD_UNLOCK..   "|r (Unlocks the fishing box so you can drag it.)";
FE_SYNTAX_FIX       = " |cff00ff00"..FE_CMD_FIX..      "|r (Resets the fishing box to the center of the screen in case you lose it.)";

-- Command Help
FE_COMMAND_HELP = {
	"/fishease or /fe |cff00ff00<command>|r |cffffff00[args]|r to perform the following commands:",
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
FE_OUT_SET_POLE           = "Fishing pole set to %s.";
FE_OUT_SET_MAIN           = "Main hand set to %s.";
FE_OUT_SET_SECONDARY      = "Secondary hand set to %s.";
FE_OUT_SET_FISHING_GLOVES = "Fishing gloves set to %s.";
FE_OUT_SET_FISHING_HAT    = "Fishing hat set to %s.";
FE_OUT_SET_FISHING_BOOT   = "Fishing boots set to %s.";
FE_OUT_SET_GLOVES         = "Normal gloves set to %s.";
FE_OUT_SET_HAT            = "Normal hat set to %s.";
FE_OUT_SET_BOOT           = "Normal boots set to %s.";
FE_OUT_NEED_SET_POLE      = "Please equip the fishing gear you want to use and run this command again.";
FE_OUT_NEED_SET_NORMAL    = "Please equip your primary gear and run this command again.";
FE_OUT_ON                 = "|cff32c8ffon|r.";
FE_OUT_OFF                = "|cffffc832off|r.";
FE_OUT_EASYCAST           = " |cff00ff00"..FE_CMD_EASYCAST.. "|r %s (Right-click casting)";
FE_OUT_SHIFTCAST          = " |cff00ff00"..FE_CMD_SHIFTCAST.."|r %s (Requires holding Shift to right-click cast";
FE_OUT_RESET              = "Your saved gear sets have been reset.";
FE_OUT_LOCKED             = "The fishing box is now locked in place.";
FE_OUT_UNLOCKED           = "The fishing box is now unlocked. Drag it with the left mouse button.";
FE_OUT_SAFEMODE           = " |cff00ff00"..FE_CMD_SAFEMODE.. "|r %s (Right-click casting with FishBox)";
FE_OUT_STICKYBOX          = " |cff00ff00"..FE_CMD_STICKYBOX.."|r %s (FishBox never fully hides)";
