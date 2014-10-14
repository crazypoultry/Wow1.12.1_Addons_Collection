DRUIDBAR_CHAT_COMMAND_USAGE	= "Commands: /DruidBar or /dbar.\n/dbar function to see behavioral parameters\n/dbar cosmetic to see cosmetic parameters.";
DRUIDBAR_CHAT_FUNCTIONAL_USAGE 	= "Functional Parameters: [Toggle/Update/Lock/Hide/Replace/EZShift/kmg/best/message]";
DRUIDBAR_CHAT_COSMETIC_USAGE	= "Cosmetic Parameters: [barcolor/ShowText/Percent/Changex (1-??)/Changey (1-??)/PlayerFrame/TextType/TextColor]\ntype /dbar textcolor for more info on it";
DRUIDBAR_CHAT_TEXTCOLOR_USE	= "TextColor use: /dbar textcolor -color- (\"original, red, orange, yellow, green, blue, purple, black, white\")\n/dbar textcolor [r/g/b] (0.00 to 1.00)\n/dbar textcolor set # # #";
DRUIDBAR_DRUIDCLASS	= "Druid";
DRUIDBAR_INNERVATE	= "Innervate";
DRUIDBAR_FORM = "Form";
DRUIDBAR_FORMX = "Aquatic";
DRUIDBAR_FORMX2 = "Travel";
BINDING_HEADER_DRUIDBAR = "Druid Bar";
BINDING_NAME_DruidBarBest = "Best Form";

if ( GetLocale() == "frFR" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Innervation";
	DRUIDBAR_FORM = "Forme";
	DRUIDBAR_FORMX = "aquatique";
	DRUIDBAR_FORMX2 = "voyage";
	BINDING_NAME_DruidBarBest = "Forme de bof seulement! euh... bonne Forme?";
elseif ( GetLocale() == "deDE" ) then
	DRUIDBAR_DRUIDCLASS	= "Druide";
	DRUIDBAR_INNERVATE = "Anregen";
	DRUIDBAR_FORM = "gestalt"
	DRUIDBAR_FORMX = "Wasser";
	DRUIDBAR_FORMX2 = "Reise";
end
