-- Version Info  : v1.31.11200
-- Language      : English
-- Last Update   : 28 Oct 2006

-- << Any GetLocale() other than "deDE" or "frFR" >>

CN_LANG = "";

BINDING_HEADER_CASHNOTIFY_HEADER	= CASH_NOTIFY;
BINDING_NAME_CASHNOTIFY_ENABLE		= "Enable notifications";
BINDING_NAME_CASHNOTIFY_DISABLE		= "Disable notifications";
BINDING_NAME_CASHNOTIFY_TOGGLE		= "Toggle notifications";
BINDING_NAME_CASHNOTIFY_TOGMERCH	= "Toggle merchant summaries";
BINDING_NAME_CASHNOTIFY_TOGFRAME	= "Toggle output frame";

CN_LOADED	= "CashNotify loaded";
CN_VARLOAD	= "Variables loaded";
CN_ENTWORLD	= "Player entering world";
CN_DISPHELP	= "will show help";

CN_MYADDONS_DESC = "Shows money spent/gained in the chat pane."

CN_COMMANDS	= "Commands:";
CN_ACTIVE	= "Cash notifications enabled.";
CN_INACTIVE	= "Cash notifications disabled.";
CN_USAGE	= "Usage:";
CN_DEBUG	= "Debug: ";
CN_DISABLED	= "disabled";
CN_ENABLED	= "enabled";
CN_HELP		= "help";
CN_NOOPT	= "no parameter toggles setting";

CN_GAIN		= "You gain %s";
CN_SPEND	= "You spend %s";
CN_SALES	= "sales";
CN_PURCHASE	= "purchases";
CN_OVERALL	= "overall";

CN_GOLD		= " "..strlower(GOLD);
CN_SILVER	= " "..strlower(SILVER);
CN_COPPER	= " "..strlower(COPPER);
CN_AND		= "and";
CN_OR		= "or";

CN_TOGGLE			= "Toggle notification on/off";
CN_SHOWHELP			= "Show this help";
CN_PARAM_COLOR		= "color";
CN_PARAM_COLORGAIN	= CN_PARAM_COLOR..CN_NGAIN;
CN_PARAM_COLORSPEND	= CN_PARAM_COLOR..CN_NSPEND;
CN_PARAM_FRAME		= "frame";
CN_PARAM_MERCHANT	= "merchant";
CN_RGB				= "<r> <g> <b>";
CN_SET_NOTIF_COLOR	= "Set notification text-color";
CN_USING_PICKER		= "using the 'Color Picker'";
CN_SET_GAIN_COLOR	= "Set 'gains' text-color";
CN_SET_SPEND_COLOR	= "Set 'spends' text-color";
CN_VALUES_ARE		= "values are 1-255";
CN_TOGGLE_FRAME		= "Toggle output frame (between 'default' or 'selected')";
CN_TOGGLE_MERCHANT	= "Toggle merchant summaries on/off";

CN_INVALID_COLOUR	= "Invalid RGB color-value.";

CN_COLOR_UPDATED = {};
CN_COLOR_UPDATED[CN_NGAIN]	= "Notification color updated (gain).";
CN_COLOR_UPDATED[CN_NSPEND]	= "Notification color updated (spend).";

CN_COLPICK_CANCEL	= "Notification colors not changed.";

CN_NOTIF_DEFAULT	= "Notifications will only show in default chat frame.";
CN_NOTIF_CURRENT	= "Notifications will now show in selected chat frame.";

CN_MERCH_ENABLED	= "Sales and purchases at merchants will now be summarised.";
CN_MERCH_DISABLED	= "Sales and purchases at merchants will now be itemised.";

-- Color Picker constants
CNCP_GAINTEXT	= "Gain text";
CNCP_SPENDTEXT	= "Spend text";
