-- PocketHelper localization

-- Create a table to store global values
PocketHelper = {};

-- Texture name for the skill, used as first stage of search.
PocketHelper.PICKPOCKET_TEXTURE = "Interface\\Icons\\INV_Misc_Bag_11";
-- Skill name from the tooltip for the skill, used as second stage of search.
PocketHelper.PICKPOCKET_NAME = "Pick Pocket";

-- Message catalog
PocketHelper.MSG = {};
local MSG = PocketHelper.MSG;

MSG.ConfigHeader        = "PocketHelper (%s) - Current configuration:";
MSG.ConfigScale         = "  /pockethelper scale %s";
MSG.ConfigAlpha         = "  /pockethelper alpha %s";
MSG.ConfigXOffset       = "  /pockethelper xoffset %s";
MSG.ConfigYOffset       = "  /pockethelper yoffset %s";
MSG.ConfigInRange       = "  /pockethelper inrange %s";
MSG.ConfigCheckCombat   = "  /pockethelper checkcombat %s";
MSG.ConfigDisabled      = "  PocketHelper is disabled.";
MSG.ConfigEnabled       = "  PocketHelper is enabled.";
MSG.ToggleHidden        = "  PocketHelper is hidden (via key binding).";
MSG.ConfigOtherCommands = "  Other commands are: reset enable disable"

MSG.SetConfigScale    = "PocketHelper Scale set to %s.";
MSG.SetConfigAlpha    = "PocketHelper Alpha set to %s.";
MSG.SetConfigXOffset  = "PocketHelper X Offset set to %s.";
MSG.SetConfigYOffset  = "PocketHelper Y Offset set to %s.";
MSG.SetConfigInRange  = "PocketHelper Range Checking set to %s.";
MSG.SetConfigCheckCombat = "PocketHelper Combat Checking set to %s.";
MSG.SetConfigDisabled = "PocketHelper is now disabled.";
MSG.SetConfigEnabled  = "PocketHelper is now enabled.";
MSG.ResetConfig       = "PocketHelper configuration reset.";

MSG.UnknownCommand    = "PocketHelper: Unknown command '%s'";

MSG.MissingFlagOption  = 
   "Setting %s requires a value (0 or 1).";
MSG.InvalidRangeOption  = 
   "Provided %s value '%s' is invalid, it must be between %s and %s.";
MSG.InvalidNumberOption  =
   "Provided %s value '%s' is invalid, it must be a number.";

-- SLASH COMMANDS
SLASH_POCKETHELPERCOMMAND1 = "/pockethelper";

BINDING_HEADER_POCKETHELPER="PocketHelper"
BINDING_NAME_TOGGLEPOCKETHELPER="Toggle PocketHelper"

-- German localization from Suan!
if(GetLocale() == "deDE") then
   PocketHelper.PICKPOCKET_NAME = "Taschendiebstahl";
end

-- French localization from Viny
if (GetLocale() == "frFR") then
   PocketHelper.PICKPOCKET_NAME = "Vol \195\160 la tire";
end