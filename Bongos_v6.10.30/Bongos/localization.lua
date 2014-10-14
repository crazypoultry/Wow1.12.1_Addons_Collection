--[[
	Bongos Localization file
--]]

--[[
	English - Default Language
		This version MUST always be loaded, as it has default values for all strings.
--]]

--[[ System Messages ]]--

BONGOS_NEW_USER = "Bongos: New user detected. Type /bongos to bring up the options menu"
BONGOS_UPDATED = "Bongos: Settings have been updated to v%s"
BONGOS_UNKNOWN_COMMAND = "Bongos: '%s' is an unknown command"
BONGOS_BOTTOMBAR_LOADED = "There is a conflict between CT_BottomBar and Bongos. Please disable CT_BottomBar if you want to use Bongos without issue"

--[[ Slash Command Help Message ]]--

BONGOS_COMMANDS = "Bongos Commands:"
BONGOS_SHOW_OPTIONS = "/bob - Shows the options menu, if present"
BONGOS_SHOW_HELP = "/bob help or /bob ? - Displays list of commands"
BONGOS_LOCK = "/bob lock - Locks the position all bars"
BONGOS_UNLOCK = "/bob unlock - Unlocks the positions all bars"
BONGOS_SHOW = "/bob show <bar> - Shows the given bar"
BONGOS_HIDE = "/bob hide <bar> - Hides the given bar"
BONGOS_TOGGLE = "/bob toggle <bar> - Toggles the given bar"
BONGOS_SET_SCALE = "/bob scale <bar> <value> - Set the scale of the given bar. 1 is normal size"
BONGOS_SET_OPACITY = "/bob setAlpha <bar> <value> - Set the opacity of a bar to <value>. 0 is translucent, 1 is opaque"
BONGOS_SET_STICKY = "/bob stickyBars  <on | off> - Enable/disable bars automatically \"sticking\" to each other when positioning them"

BONGOS_LOAD_PROFILE = "/bob load <profile> - Loads the given layout"
BONGOS_SAVE_PROFILE = "/bob save <profile> - Saves the current setup as <profile>"
BONGOS_DELETE_PROFILE = "/bob delete <profile> - Deletes the given saved layout"
BONGOS_RESET = "/bob reset - Loads standard settings"
BONGOS_SET_DEFAULT_PROFILE = "/bob setDefault <profile> - Sets a given saved profile as the default settings for new characters"
BONGOS_CLEAR_DEFAULT_PROFILE = "/bob clearDefault - Uses standard settings as default"
BONGOS_REUSE = "/bob reuse <on | off> - Toggles reusing default buttons"

BONGOS_REUSE_ENABLED = "Reusing buttons enabled"
BONGOS_REUSE_DISABLED = "Reusing buttons disabled"

--[[ Profile Messages ]]--

BONGOS_NO_PROFILES = "Bongos: No profiles saved yet"
BONGOS_NO_PROFILE_NAME = "Bongos: No profile name specified"
BONGOS_INVALID_PROFILE = "Bongos: '%s' is an invalid profile"
BONGOS_PROFILE_SAVED = "Bongos: Saved your current configuration as '%s'"
BONGOS_PROFILE_LOADED = "Bongos: Loaded profile '%s'"
BONGOS_PROFILE_DELETED = "Bongos: Deleted profile '%s'"
BONGOS_PROFILE_DEFAULT_DISABLED = "Bongos: Default profile disabled"
BONGOS_PROFILE_DEFAULT_SET = "Bongos: '%s' set as your default configuration"

--[[ Menu Components ]]--

BONGOS_SCALE = "Scale"
BONGOS_OPACITY = "Opacity"
BONGOS_SPACING = "Spacing"
BONGOS_HIDE_BAR = "Hide Bar"

--[[ Tooltips ]]--

BONGOS_SHOW_CONFIG = "<Right Click> to Configure"