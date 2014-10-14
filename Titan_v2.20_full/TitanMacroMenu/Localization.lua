---  Variables, don't need translated ---
TITAN_MACROMENU_LOC_US = "enUS";
TITAN_MACROMENU_LOC_DE = "deDE";
TITAN_MACROMENU_LOC_FR = "frFR";
TITAN_MACROMENU_SPACER = 42;

if ( GetLocale() == "frFR" ) then -- Français (French)

	TITAN_MACROMENU_MENU_BARTEXT = "Macros";
	TITAN_MACROMENU_MENU_TEXT = "MacroMenu";
	TITAN_MACROMENU_MENURIGHT_TEXT = "MacroMenu (Right)";
	TITAN_MACROMENU_TOOLTIP_TEXT = "Shows a list of all macros.";
	TITAN_MACROMENU_TOOLTIP_HINT = "Hint: Right-click.";

	TITAN_MACROMENU_CAT_ACCOUNT = "Account";
	TITAN_MACROMENU_CAT_CHAR = "Character";
	TITAN_MACROMENU_CAT_SUPER = "SuperMacro";

elseif ( GetLocale() == "deDE" ) then -- Deutsch (German)

	TITAN_MACROMENU_MENU_BARTEXT = "Macros";
	TITAN_MACROMENU_MENU_TEXT = "MacroMenu";
	TITAN_MACROMENU_MENURIGHT_TEXT = "MacroMenu (Right)";
	TITAN_MACROMENU_TOOLTIP_TEXT = "Shows a list of all macros.";
	TITAN_MACROMENU_TOOLTIP_HINT = "Hint: Right-click.";

	TITAN_MACROMENU_CAT_ACCOUNT = "Account";
	TITAN_MACROMENU_CAT_CHAR = "Character";
	TITAN_MACROMENU_CAT_SUPER = "SuperMacro";

else -- ENGLISH

	TITAN_MACROMENU_MENU_BARTEXT = "Macros";
	TITAN_MACROMENU_MENU_TEXT = "MacroMenu";
	TITAN_MACROMENU_MENURIGHT_TEXT = "MacroMenu (Right)";
	TITAN_MACROMENU_TOOLTIP_TEXT = "Shows a list of all macros.";
	TITAN_MACROMENU_TOOLTIP_HINT = "Hint: Right-click.";

	TITAN_MACROMENU_CAT_ACCOUNT = "Account";
	TITAN_MACROMENU_CAT_CHAR = "Character";
	TITAN_MACROMENU_CAT_SUPER = "SuperMacro";

end
