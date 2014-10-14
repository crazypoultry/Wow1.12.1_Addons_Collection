-- General

NOVAWATCH_VERSION = "11100.3"

-- English localization

NOVAWATCH_SPELL = "Frost Nova"

NOVAWATCH_TEXT_ENABLED = "NovaWatch: Enabled"
NOVAWATCH_TEXT_DISABLED = "NovaWatch: Disabled"

NOVAWATCH_TEXT_LOADED = "NovaWatch " .. NOVAWATCH_VERSION .. " loaded - Configure with /novawatch"
NOVAWATCH_TEXT_WORLD_NOT_LOADED = "World isn't loaded. Please wait..."
NOVAWATCH_TEXT_PROFILECLEARED = "NovaWatch: Your settings are incompatible for this version so your profile was cleared.\nNovaWatch: Please configure NovaWatch with /novawatch"
NOVAWATCH_TEXT_LOCKED = "NovaWatch: Frame locked."
NOVAWATCH_TEXT_UNLOCKED = "NovaWatch: Frame unlocked for moving."
NOVAWATCH_TEXT_INVERSION_ON = "NovaWatch: Statusbar decreasing."
NOVAWATCH_TEXT_INVERSION_OFF = "NovaWatch: Statusbar increasing."
NOVAWATCH_TEXT_VERBOSE_ON = "NovaWatch: Being verbose."
NOVAWATCH_TEXT_VERBOSE_OFF = "NovaWatch: Being quiet."
NOVAWATCH_TEXT_COUNTER_ON = "NovaWatch: Counter enabled."
NOVAWATCH_TEXT_COUNTER_OFF = "NovaWatch: Counter disabled."
NOVAWATCH_TEXT_DECIMALS_ON = "NovaWatch: Decimals are shown in the counter."
NOVAWATCH_TEXT_DECIMALS_OFF = "NovaWatch: Decimals are hidden in the counter."
NOVAWATCH_TEXT_ANNOUNCE_CAST = " casted on "
NOVAWATCH_TEXT_ANNOUNCE_BREAK = NOVAWATCH_SPELL .. " broke on "
NOVAWATCH_TEXT_ANNOUNCE_FADE = NOVAWATCH_SPELL .. " faded from "
NOVAWATCH_TEXT_ANNOUNCE_LEAVECOMBAT = "NovaWatch: You left combat mode."
NOVAWATCH_LABEL_ENABLE = "Enable NovaWatch"
NOVAWATCH_LABEL_VERBOSE = "Be verbose"
NOVAWATCH_LABEL_CLOSE = "Close"
NOVAWATCH_LABEL_MOVE = "Move bar"
NOVAWATCH_LABEL_MOVE2 = "Lock bar"
NOVAWATCH_LABEL_COUNTER = "Display an additional counter"
NOVAWATCH_LABEL_COUNTER_DIGITS = "Show miliseconds"
NOVAWATCH_LABEL_DIRECTION_LABEL = "Bar direction:"
NOVAWATCH_LABEL_COLOR_LABEL = "Bar color:"
NOVAWATCH_LABEL_TRANSPARENCY = "Bar transparency"
NOVAWATCH_LABEL_SCALING = "Bar scaling"
NOVAWATCH_LIST_DIRECTIONS = { 
					{ name = "Increasing", value = 1 },
					{ name = "Decreasing", value = 2 }
}

NOVAWATCH_HELP1  = " - Configure with '/novawatch option'"
NOVAWATCH_HELP2  = "Options:"
NOVAWATCH_HELP3  = " on       : Enables NovaWatch"
NOVAWATCH_HELP4  = " off      : Disables NovaWatch"
NOVAWATCH_HELP5  = " lock     : Lock the statusbar and enable NovaWatch"
NOVAWATCH_HELP6  = " unlock   : Allows you to move the statusbar"
NOVAWATCH_HELP7  = " invert   : Toggles statusbar in- or decreasing"
NOVAWATCH_HELP8  = " counter  : Toggles a counter shown above the progress bar"
NOVAWATCH_HELP9  = " decimals : Toggles the display of the counters digits."
NOVAWATCH_HELP10  = " verbose  : Toggles verbosity"
NOVAWATCH_HELP11 = " status   : Displays the current configuration."

NOVAWATCH_EVENT_ON = "(.+) is afflicted by " .. NOVAWATCH_SPELL .. "."
NOVAWATCH_EVENT_CAST = "You cast " .. NOVAWATCH_SPELL .. " on (.+)."
NOVAWATCH_EVENT_BREAK = "(.+)'s " .. NOVAWATCH_SPELL .. " is removed."
NOVAWATCH_EVENT_FADE = NOVAWATCH_SPELL .. " fades from (.+)."
NOVAWATCH_EVENT_DEATH = "(.+) has died."