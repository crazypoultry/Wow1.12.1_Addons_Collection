--[[	
	ImmersionRP Alpha 4 English string resource.
	Purpose: Provide localized strings in English.
	Author: Seagale.
	Last update: March 9th, 2007.
	
	WARNING: DO NOT EDIT ANYTHING NOT IN QUOTATION MARKS!
  ]]

-- Tab titles
IRP_STRING_SETTINGS = "Settings";
IRP_STRING_CHARACTERINFO = "Character Info";
IRP_STRING_HELP = "Help";
IRP_STRING_SOCIAL = "Social";

-- Menu strings
IRP_STRING_MENU_TOGGLE = "Open ImmersionRP";
IRP_STRING_MENU_FIND = "Find Character";
IRP_STRING_MENU_NORPSTATUS = "No RP Status";
IRP_STRING_MENU_TOGGLEINFOBOX = "Toggle description";
IRP_STRING_MENU_DISABLE = "Disable IRP temporarily";
IRP_STRING_MENU_ENABLE = "Enable ImmersionRP";
IRP_STRING_MENU_TOGGLEHELM = "Show/hide helm";
IRP_STRING_MENU_TOGGLECLOAK = "Show/hide cloak";

-- Settings tab
IRP_STRING_MODIFY_TOOLTIP = "Modify tooltip";

IRP_STRING_ALWAYS_SHOW_GUILDS = "Show guild names";
IRP_STRING_NEVER_SHOW_GUILDS = "Don't show guild names";
IRP_STRING_KNOWN_SHOW_GUILDS = "Show guild names for known players";

IRP_STRING_ALWAYS_SHOW_PVP = "Show PvP ranks";
IRP_STRING_NEVER_SHOW_PVP = "Don't show PvP ranks";
IRP_STRING_KNOWN_SHOW_PVP = "Show ranks for known players";

IRP_STRING_SHOW_RELATIVE = "Show relative levels";

IRP_STRING_HIDE_UNKNOWN_PLAYERS = "Hide names of unknown players"

--IRP_STRING_COMM_PROTOCOL = "Communication method: ";
IRP_STRING_COMM_CHANNEL = "Communication channel: ";
IRP_STRING_CHANGE = "Change";
IRP_STRING_JOINCHANNEL = "Join channel";

-- Character Info tab
IRP_STRING_CHARACTER_DESCRIPTION = "Description:";
IRP_STRING_CHARACTER_NOTES = "Notes:";

IRP_STRING_CHARACTER_FIRST_NAME = "Name prefix: ";
IRP_STRING_CHARACTER_LAST_NAME = "Name suffix: ";

IRP_STRING_REVERT = "Revert";

IRP_STRING_CHARACTER_TITLE = "Title: ";

-- flagRSP RP style strings
IRP_STRING_RSP_NORP = "No roleplaying flag"; 
IRP_STRING_RSP_RP = "Normal roleplaying style"; 
IRP_STRING_RSP_CASUALRP = "Casual roleplaying, partial OOC"; 
IRP_STRING_RSP_FULLTIMERP = "Fulltime roleplaying, no OOC at all"; 
IRP_STRING_RSP_BEGINNERRP = "Roleplaying beginner"; 

-- Tooltip strings
IRP_STRING_ALTLEVEL_TOOLTIP = "%s %s of %s power"; -- Examples: "Human Rogue of little power", "Undead Mage of immense power"

IRP_STRING_UNKNOWNPLAYER_TOOLTIP = "<Unknown>";

IRP_STRING_DELTA10_TOOLTIP = "immense"; -- Lowercase!
IRP_STRING_DELTA7_TOOLTIP = "formidable"; -- Lowercase!
IRP_STRING_DELTA5_TOOLTIP = "greater"; -- Lowercase!
IRP_STRING_DELTA2_TOOLTIP = "equal"; -- Lowercase!
IRP_STRING_DELTAMINUS5_TOOLTIP = "lesser"; -- Lowercase!
IRP_STRING_DELTAMINUS7_TOOLTIP = "little"; -- Lowercase!
IRP_STRING_DELTAMINUS10_TOOLTIP = "miniscule"; -- Lowercase!

IRP_STRING_RSP_RP_TOOLTIP = "Roleplayer";
IRP_STRING_RSP_CASUALRP_TOOLTIP = "Casual roleplayer";
IRP_STRING_RSP_FULLTIMERP_TOOLTIP = "Fulltime roleplayer";
IRP_STRING_RSP_BEGINNERRP_TOOLTIP = "Beginner roleplayer";

IRP_STRING_RSP_OOC_TOOLTIP = "Out of character";
IRP_STRING_RSP_IC_TOOLTIP = "In character";
IRP_STRING_RSP_ICFFA_TOOLTIP = "In character, looking for contact";
IRP_STRING_RSP_STORYTELLER_TOOLTIP = "Storyteller";

-- Find character dialog
IRP_STRING_CHARACTERLOOKUP_TEXT = "Type the name of the character you wish to find (or a part of it) :";
IRP_STRING_CHARACTERLOOKUP_FIND = "Find";
IRP_STRING_CHARACTERLOOKUP_NOMATCH = "Could not find '%s'.";
IRP_STRING_CHARACTERLOOKUP_NOINFO = "Could not find information about '%s'.";

-- Join channel dialog
IRP_STRING_NOTINCHANNEL = "You are not connected to the ImmersionRP communication channel.\nWould you like to join this channel now?";

-- Key bindings
BINDING_NAME_IRP_TOGGLE = IRP_STRING_MENU_TOGGLE;
BINDING_NAME_IRP_CHARACTERLOOKUP = IRP_STRING_MENU_FIND;
BINDING_NAME_IRP_RPMODE = "Toggle RP mode";

-- Flag messages
IRP_STRING_LOADED = "ImmersionRP Alpha 4 loaded successfully."; -- Do not translate "ImmersionRP Alpha 4"
IRP_STRING_PURGED_FLAGS = "Purged %d old flags. (Purge time is %d days)";
IRP_STRING_INFOBOXEXPAND = "Click to view description."

-- Info change confirmation
IRP_STRING_STATUSCHANGED = "RP status changed to %s.";
IRP_STRING_STYLECHANGED = "RP style changed to %s.";
IRP_STRING_FIRSTNAMECHANGED = "First name changed to %s.";
IRP_STRING_FIRSTNAMECLEARED = "First name cleared.";
IRP_STRING_LASTNAMECHANGED = "Last name changed to %s.";
IRP_STRING_LASTNAMECLEARED = "Last name cleared.";
IRP_STRING_TITLECHANGED = "Title changed to '%s'.";
IRP_STRING_DESCRIPTIONCHANGED = "Description updated.";
IRP_STRING_NAMECLEARED = "Custom name cleared."
IRP_STRING_TITLECLEARED = "Title cleared."
IRP_STRING_DESCRIPTIONCLEARED = "Description cleared."

-- Help window
IRP_STRING_EXTENDEDHELP = [[
Available Commands:
*******************************
/irp - Opens Character Info Panel.
/irp character - Same as above.
/irp social - Opens Social panel. (if available)
/irp settings - Opens Settings panel.
/irp help - Opens Help panel.
/irp rpmode - Toggles RP Mode.
/irp toggleicon - Toggles minimap icon.
/irp moverpbutton - Toggles dragging of the RP mode button.
/irp centerrpbutton - Places RP mode button in the center of the UI.
/irp owntooltip - Displays what others would see if they mouse over you.
/irp find <first or last name> - Looks up a character. Pops up window if name is omitted.

Usage Notes:
****************
The "Revert" button is used to reverse any changes you've made to your information since opening the Character Info panel.
Note that the description field is meant for a physical description ONLY. Please do not use it to reveal your character's history.

Troubleshooting:
********************
If you can't see descriptions or other kinds of character information, click on "Join Channel" in Settings, and make sure you click on the description box to open it.

Thanks:
*********
Angthoron, guild master of Silver Dawn, and the rest of the guild for the support.
Thanar of Silver Dawn for coming up with RP mode.
Dalrick Cogspinner for the minimap icon.]];