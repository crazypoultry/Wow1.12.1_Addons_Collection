TITAN_FRIENDS_MENU_TEXT = "Titan Friends"
TITAN_FRIENDS_BUTTON_LABEL = "Friends: "
TITAN_FRIENDS_BUTTON_TEXT = "%s"..TitanUtils_GetHighlightText("/").."%s"..TitanUtils_GetHighlightText("/").."%s";
TITAN_FRIENDS_TOOLTIP_ONLINE = "Online"
TITAN_FRIENDS_TOOLTIP_OFFLINE = "Offline"
TITAN_FRIENDS_TOOLTIP_IGNORE = "Currently Ignored"
TITAN_FRIENDS_MENU_WHISPER = "Whisper"
TITAN_FRIENDS_MENU_INVITE = "Invite"
TITAN_FRIENDS_MENU_REMOVE = "Remove"
TITAN_FRIENDS_VERSION = "1.0.0"
TITAN_FRIENDS_TOOLTIP = "Titan Friends <v"..TITAN_FRIENDS_VERSION..">";
TITAN_FRIENDS_HELP = {};
TITAN_FRIENDS_HELP[1] = "Titan Friends <v"..TITAN_FRIENDS_VERSION.."> - Slash Commands:";
TITAN_FRIENDS_HELP[2] = "|cff68ccef".."/titanfriends showoffline ".."|cffffffff".." Toggles showing your offline friends";
TITAN_FRIENDS_HELP[3] = "|cff68ccef".."/titanfriends showignored ".."|cffffffff".." Toggles showing your ignore list";	
TITAN_FRIENDS_HELP[4] = "|cff68ccef".."/titanfriends showclass ".."|cffffffff".." Toggles showing your friends class";


-- German localization by ven
if ( GetLocale() == "deDE" ) then
	TITAN_FRIENDS_MENU_TEXT = "Freunde"
	TITAN_FRIENDS_MENU_WHISPER = "Fl\195\188stern"
	TITAN_FRIENDS_MENU_INVITE = "Einladen"
	TITAN_FRIENDS_BUTTON_LABEL = "Freunde: "
	TITAN_FRIENDS_BUTTON_TEXT = "%s"..TitanUtils_GetHighlightText("/").."%s";
	TITAN_FRIENDS_TOOLTIP = "Freunde-Info"
end

-- French localization by alainb
if ( GetLocale() == "frFR" ) then
	TITAN_FRIENDS_MENU_TEXT = "Amis"
	TITAN_FRIENDS_MENU_WHISPER = "Chuchoter"
	TITAN_FRIENDS_MENU_INVITE = "Inviter"
	TITAN_FRIENDS_BUTTON_LABEL = "Amis: "
	TITAN_FRIENDS_BUTTON_TEXT = "%s"..TitanUtils_GetHighlightText("/").."%s";
	TITAN_FRIENDS_TOOLTIP = "Liste des Amis"
end 