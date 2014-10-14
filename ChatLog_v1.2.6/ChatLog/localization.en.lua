--TITLES
CHAT_LOG_MWINDOW_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
CHAT_LOG_MWINDOW_INFO = "Max log: " .. CHAT_LOG_MAXSIZE .. " lines.";
CHAT_LOG_MWINDOW_HEADER_TOOLTIP = "Left-Click to drag.\nRight-Click to reset.";
CHAT_LOG_COPYWINDOW_TITLE = "Copy window";

--BINDINGS
BINDING_HEADER_CHAT_LOG_BHEADER = "ChatLog";
BINDING_NAME_CHAT_LOG_TOGGLE = "Toggle ChatLog";

--LOG NAMES
--Game
CHAT_LOG_WHISPER_NAME = "Whispers";
CHAT_LOG_RAID_NAME = "Raid";
CHAT_LOG_PARTY_NAME = "Party";
CHAT_LOG_SAY_NAME = "Say";
CHAT_LOG_YELL_NAME = "Yell";
CHAT_LOG_OFFICER_NAME = "Officer";
CHAT_LOG_GUILD_NAME = "Guild";
--General: Names to display
CHAT_LOG_GENERAL_NAME = "General";
CHAT_LOG_TRADE_NAME = "Trade";
CHAT_LOG_LOCALDEFENSE_NAME = "LocalDefense";
CHAT_LOG_WORLDDEFENSE_NAME = "WorldDefense";
CHAT_LOG_LOOKINGFORGROUP_NAME = "LookingForGroup";
CHAT_LOG_GUILDRECRUITMENT_NAME = "GuildRecruitment";
--General: String to look for
CHAT_LOG_GENERAL_STR = "general";
CHAT_LOG_TRADE_STR = "trade";
CHAT_LOG_LOCALDEFENSE_STR = "localdefense";
CHAT_LOG_WORLDDEFENSE_STR = "worlddefense";
CHAT_LOG_LOOKINGFORGROUP_STR = "lookingforgroup";
CHAT_LOG_GUILDRECRUITMENT_STR = "guildrecruitment";

--BUTTONS
CHAT_LOG_HIDE = "Close";
CHAT_LOG_ALLCLEAR = "Clear all";
CHAT_LOG_CLEAR = "Empty";
CHAT_LOG_DELETE = "Delete";
CHAT_LOG_ENABLE_THIS_LOG = "Enable";
CHAT_LOG_DISABLE_THIS_LOG = "Disable";
CHAT_LOG_COPY = "Copy";
CHAT_LOG_ENABLE_ALL = "Enable all logs";
CHAT_LOG_DISABLE_ALL = "Disable all logs";

--CHECKBOXES
CHAT_LOG_CHAT_CHECKBOX_TITLE = "Log the chat to a file.";
CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_TITLE = "Log the chat to a file";
CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG1 = "Logs the chat (not the combat log)";
CHAT_LOG_CHAT_CHECKBOX_TOOLTIP_MSG2 = "to Logs\\WoWChatLog.txt";

CHAT_LOG_COMBATCHAT_CHECKBOX_TITLE = "Log the combat chat to a file.";
CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_TITLE = "Log the combat chat to a file";
CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG1 = "Logs the combat chat";
CHAT_LOG_COMBATCHAT_CHECKBOX_TOOLTIP_MSG2 = "to Logs\\WoWCombatLog.txt";

CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TITLE = "Log new channels.";
CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_TITLE = "Log new channels";
CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE1 = "Automaticaly starts logging";
CHAT_LOG_ENABLED_DEFAULT_CHECKBOX_TOOLTIP_LINE2 = "when you join a new channel.";

--SLIDERS
CHAT_LOG_ALPHA_SLIDER_TITLE = "Alpha";

--TOOLTIPS
CHAT_LOG_TOGGLE_TOOLTIP_TITLE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION;
CHAT_LOG_TOGGLE_TOOLTIP_LINE1 = "Left-Click to toggle Chatlog.";
CHAT_LOG_TOGGLE_TOOLTIP_LINE2 = "Right-Click to drag this button.";
CHAT_LOG_DISPLAY_DROPDOWN = "Display chats";
CHAT_LOG_DISPLAY_DROPDOWN_LINE1 = "Select the chat you want";
CHAT_LOG_DISPLAY_DROPDOWN_LINE2 = "to read in the dropdown menu.";
CHAT_LOG_DISPLAY_DROPDOWN_LINE3 = "You can also Right-Click on the frame.";
CHAT_LOG_SCROLL_LINE_UP = "Scroll one line up"
CHAT_LOG_SCROLL_LINE_DOWN = "Scroll one line down"
CHAT_LOG_SCROLL_SCREEN_UP = "Scroll one page up"
CHAT_LOG_SCROLL_SCREEN_DOWN = "Scroll one page down"
CHAT_LOG_SCROLL_TOP = "Scroll to top"
CHAT_LOG_SCROLL_BOTTOM = "Scroll to bottom"

--PARAMETERS
--First parameters
CHAT_LOG_PHELP = "help";
CHAT_LOG_PRESET = "reset";
CHAT_LOG_PRESETBUTTON = "resetbutton";
CHAT_LOG_PCLEAR = "clear";
CHAT_LOG_PALLCLEAR = "clearall";
--Second parameters
CHAT_LOG_PCLEAR_WHISPER = "whispers";
CHAT_LOG_PCLEAR_RAID = "raid";
CHAT_LOG_PCLEAR_PARTY = "party";
CHAT_LOG_PCLEAR_SAY = "say";
CHAT_LOG_PCLEAR_YELL = "yell";
CHAT_LOG_PCLEAR_OFFICER = "officer";
CHAT_LOG_PCLEAR_GUILD = "guild";

--SLASHCOMMANDS HELP
CHAT_LOG_PHELP_TITLE = "ChatLog commands:";
CHAT_LOG_PHELP_TOGGLE = "Toggle ChatLog.";
CHAT_LOG_PHELP_RESET = "Reset all windows position.";
CHAT_LOG_PHELP_RESETBUTTON = "Reset the ChatLog button position.";
CHAT_LOG_PHELP_CLEAR = "Clear the specified log.";
CHAT_LOG_PHELP_ALLCLEAR = "Clear all the logs.";
CHAT_LOG_PHELP_HELP = "Show this message.";

--GENERAL INFORMATION
CHAT_LOG_LOADED_MESSAGE = CHAT_LOG_TITLE .. " " .. CHAT_LOG_VERSION .. " loaded. Type /chatlog " .. CHAT_LOG_PHELP .. " for commands."
CHAT_LOG_ALLCLEARED_MESSAGE = CHAT_LOG_TITLE .. ": Logs cleared."
CHAT_LOG_CLEARED_MESSAGE = " log cleared."
CHAT_LOG_WRONG_PARAMETER_MESSAGE = "/chatlog clear: Wrong parameter."
CHAT_LOG_LOGGING_STARTED_ON = "Logging started on";
CHAT_LOG_LOGGING_STARTED_AT = "at";
CHAT_LOG_LOGGING_STOPPED_AT = "Logging stopped at";
CHAT_LOG_PLAYER_RECEIVE_WHISPER = "whispers";
CHAT_LOG_PLAYER_SEND_WHISPER = "To";
CHAT_LOG_ENABLED_ALL = CHAT_LOG_TITLE .. ": All chats will be logged.";
CHAT_LOG_DISABLED_ALL = CHAT_LOG_TITLE .. ": Stopped all logs.";

-- DIALOGS
CHAT_LOG_DIALOG_CLEARALL_TEXT = "This will clear all logs.";
CHAT_LOG_DIALOG_CLEARALL_BUTTON1 = "Ok";
CHAT_LOG_DIALOG_CLEARALL_BUTTON2 = "Cancel";