BINDING_HEADER_REACTIONBAR = "ReactionBar"
BINDING_NAME_REACTIONBARTOGGLEEXTRA = "Toggle Extra Page"
BINDING_NAME_REACTIONBARSELFACTION1 =  "Self Action 1"
BINDING_NAME_REACTIONBARSELFACTION2 =  "Self Action 2"
BINDING_NAME_REACTIONBARSELFACTION3 =  "Self Action 3"
BINDING_NAME_REACTIONBARSELFACTION4 =  "Self Action 4"
BINDING_NAME_REACTIONBARSELFACTION5 =  "Self Action 5"
BINDING_NAME_REACTIONBARSELFACTION6 =  "Self Action 6"
BINDING_NAME_REACTIONBARSELFACTION7 =  "Self Action 7"
BINDING_NAME_REACTIONBARSELFACTION8 =  "Self Action 8"
BINDING_NAME_REACTIONBARSELFACTION9 =  "Self Action 9"
BINDING_NAME_REACTIONBARSELFACTION10 = "Self Action 10"
BINDING_NAME_REACTIONBARSELFACTION11 = "Self Action 11"
BINDING_NAME_REACTIONBARSELFACTION12 = "Self Action 12"

REACTIONBAR_TEXT_ENABLED = "is enabled";
REACTIONBAR_DISABLED = "is disabled"
REACTIONBAR_MONITOR_DUEL = "duel monitoring"
REACTIONBAR_STATUS = "status"
REACTIONBAR_RESET = "has been reset"
REACTIONBAR_FRIENDLYBAR = "friendly page id ="
REACTIONBAR_ENEMYBAR = "enemy page id ="
REACTIONBAR_EXTRABAR = "extra page id ="
REACTIONBAR_RANGEBAR = "range page id ="
REACTIONBAR_NOTARGETBAR = "no target page id ="
REACTIONBAR_CTRLBAR = "ctrl page id ="
REACTIONBAR_SHIFTBAR = "shift page id ="
REACTIONBAR_ALTBAR = "alt page id ="

REACTIONBAR_PAGE_TEXT = {
	"friendly page id =",
	"enemy page id =",
	"no target page id =",
	"extra page id =",
	"range page id =",
	"ctrl page id =",
	"shift page id =",
	"alt page id ="
}

REACTIONBAR_RANGEDSLOT = "ranged slot ="
REACTIONBAR_NIL = "Error - number input is nil"
REACTIONBAR_INVALID_SLASH = "that command is not recognised"

REACTIONBAR_SLASH_ENABLE = "enable"
REACTIONBAR_SLASH_DISABLE = "disable"
REACTIONBAR_SLASH_STATUS = "status"
REACTIONBAR_SLASH_RESET = "reset"
REACTIONBAR_SLASH_MONITOR_DUEL = "monitorduel"
REACTIONBAR_SLASH_HELP = "help"
REACTIONBAR_SLASH_FRIENDLY = "friendlypage"
REACTIONBAR_SLASH_ENEMY = "enemypage"
REACTIONBAR_SLASH_EXTRA = "extrapage"
REACTIONBAR_SLASH_NOTARGET = "notargetpage"
REACTIONBAR_SLASH_RANGE = "rangepage"
REACTIONBAR_SLASH_CTRLBAR = "ctrlpage"
REACTIONBAR_SLASH_SHIFTBAR = "shiftpage"
REACTIONBAR_SLASH_ALTBAR = "altpage"
REACTIONBAR_SLASH_CTRLENABLE = "ctrlenable"
REACTIONBAR_SLASH_SHIFTENABLE = "shiftenable"
REACTIONBAR_SLASH_ALTENABLE = "altenable"

REACTIONBAR_HELP_PAGE = {
	"Use either |c0000FF00/reactionbar|r or |c0000FF00/rb|r for all commands",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_ENABLE.."|r: enable ReactionBar functionality",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_DISABLE.."|r: disable ReactionBar functionality",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_STATUS.."|r: outputs status of ReactionBar",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_RESET.."|r: resets ReactionBar to default settings",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_MONITOR_DUEL.."|r: toggles pre-duel switching on or off",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_HELP.."|r: show this help message",
	"For the following commands page id is optional, if not given the current page is used, page id should be between 0 and 6",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_FRIENDLY.."|r |c00FF00FF[page id]|r: (default 2) set the friendly action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_ENEMY.."|r |c00FF00FF[page id]|r: (default is 1) set the enemy action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_EXTRA.."|r |c00FF00FF[page id]|r: (default is 3) set the extra action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_RANGE.."|r |c00FF00FF[page id]|r: (default is 4) set the range action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_NOTARGET.."|r |c00FF00FF[page id]|r: (default is 1) set the no target action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_CTRLBAR.."|r |c00FF00FF[page id]|r: (default is 3) set the CTRL action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_SHIFTBAR.."|r |c00FF00FF[page id]|r: (default is 4) set the SHIFT action page id",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_ALTBAR.."|r |c00FF00FF[page id]|r: (default is 2) set the ALT action page id",
	"With the following commands you can enable/disable CTRL, SHIFT or ALT page switching",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_CTRLENABLE.."|r: toggle CTRL page switching",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_SHIFTENABLE.."|r: toggle SHIFT page switching",
	"|c0000FF00/rb "..REACTIONBAR_SLASH_ALTENABLE.."|r: toggle ALT page switching",
	"",
	"To use the self cast feature and the toggleable extra page please set keybindings under the ReactionBar section of the Key Bindings window"
}

REACTIONBAR_RESTRICT = {
	"MAGE",
	"ROGUE",
	"WARLOCK",
	"WARRIOR"
}