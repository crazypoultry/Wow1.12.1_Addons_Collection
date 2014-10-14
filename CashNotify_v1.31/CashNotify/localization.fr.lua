-- Info de version      : v1.31.11200
-- Langue               : Française 
-- Dernière mise à jour : 22 Oct 2006 21:51

if ( GetLocale() == "frFR" ) then

CN_LANG = " (FR)";

--BINDING_HEADER_CASHNOTIFY_HEADER
BINDING_NAME_CASHNOTIFY_ENABLE		= "Active les notifications";
BINDING_NAME_CASHNOTIFY_DISABLE		= "D\195\169sactive les notifications"; -- é
BINDING_NAME_CASHNOTIFY_TOGGLE		= "Inversez les notifications";
--BINDING_NAME_CASHNOTIFY_TOGMERCH	= "Toggle merchant summaries";
--BINDING_NAME_CASHNOTIFY_TOGFRAME	= "Toggle output frame";

CN_LOADED	= "CashNotify restaur\195\169"; -- é
CN_VARLOAD	= "Variables restaur\195\169es"; -- é
CN_ENTWORLD	= "Joueur entrant le monde";
CN_DISPHELP	= "montrera l'aide";

--CN_MYADDONS_DESC = "Shows money spent/gained in the chat pane."

CN_COMMANDS	= "Commandes:";
CN_ACTIVE	= "Notifications d'argent activ\195\169s."; -- é
CN_INACTIVE	= "Notifications d'argent d\195\169sactiv\195\169s."; -- é é
CN_USAGE	= "Usage:";
CN_DEBUG	= "Deboggage: ";
CN_DISABLED	= "d\195\169sactiv\195\169"; -- é é
CN_ENABLED	= "activ\195\169"; -- é
CN_HELP		= "aide";
CN_NOOPT	= "pas de param\195\168tre inverse la valeur"; -- è

CN_GAIN		= "Vous gagnez %s";
CN_SPEND	= "Vous d\195\169pensez %s"; -- é
--CN_SALES	= "sales";
--CN_PURCHASE	= "purchases";
--CN_OVERALL	= "overall";

--CN_GOLD
--CN_SILVER
--CN_COPPER
CN_AND		= "et";
CN_OR		= "ou";

CN_TOGGLE			= "Active/d\195\169sactive les notifications"; -- é
CN_SHOWHELP			= "Montrez cette page d'aide";
CN_PARAM_COLOR		= "couleur";
CN_PARAM_COLORGAIN	= CN_PARAM_COLOR..CN_NGAIN;
CN_PARAM_COLORSPEND	= CN_PARAM_COLOR..CN_NSPEND;
--CN_PARAM_FRAME		= "frame";
--CN_PARAM_MERCHANT	= "merchant";
CN_RGB				= "<r> <v> <b>";
CN_SET_NOTIF_COLOR	= "Placez la couleur de texte de notification";
CN_USING_PICKER		= "utilisant le 'choisisseur de couleur'"; -- é
--CN_SET_GAIN_COLOR	= "Set 'gains' text-color";
--CN_SET_SPEND_COLOR	= "Set 'spends' text-color";
CN_VALUES_ARE		= "valeurs sont 1-255";
--CN_TOGGLE_FRAME		= "Toggle output frame (between 'default' or 'selected')";
--CN_TOGGLE_MERCHANT	= "Toggle merchant summaries on/off";

--CN_INVALID_COLOUR	= "Invalid RGB color-value.";

--CN_COLOR_UPDATED
--CN_COLOR_UPDATED[CN_NGAIN]	= "Couleur des notifications mise \195\160 jour (gain)."; -- à
--CN_COLOR_UPDATED[CN_NSPEND]	= "Couleur des notifications mise \195\160 jour (spend)."; -- à

CN_COLPICK_CANCEL	= "Couleurs des notifications non chang\195\169e."; -- é

--CN_NOTIF_DEFAULT	= "Notifications will only show in default chat frame.";
--CN_NOTIF_CURRENT	= "Notifications will now show in selected chat frame.";

--CN_MERCH_ENABLED	= "Sales and purchases at merchants will now be summarised.";
--CN_MERCH_DISABLED	= "Sales and purchases at merchants will now be itemised.";

-- Color Picker constants
--CNCP_GAINTEXT	= "Gain text";
--CNCP_SPENDTEXT	= "Spend text";

end
