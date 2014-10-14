--[[
   Version: $Rev: 2303 $
   Last Changed by: $LastChangedBy: flisher $
   Date: $Date: 2005-08-14 20:49:51 -0700 (Sun, 14 Aug 2005) $

   Note: Please don't remove commented line and change the layout of this file, the main goal is to have 3 localization files with the same layout for easy spotting of missing information.
   The SVN tag at the begining of the file will automaticaly update upon uploading.
]]--

-- Default English text

   -- Configuration variables
   SLASH_CHARACTERSVIEWER1                         = "/charactersviewer";
   SLASH_CHARACTERSVIEWER2                         = "/cv";
   CHARACTERSVIEWER_SUBCMD_SHOW                    = "show";
   CHARACTERSVIEWER_SUBCMD_CLEAR                   = "clear";
   CHARACTERSVIEWER_SUBCMD_CLEARALL                = "clearall";
   CHARACTERSVIEWER_SUBCMD_PREVIOUS                = "previous";
   CHARACTERSVIEWER_SUBCMD_NEXT                    = "next";
   CHARACTERSVIEWER_SUBCMD_SWITCH                  = "switch";
   CHARACTERSVIEWER_SUBCMD_LIST                    = "list";

   -- Localization text
   BINDING_HEADER_CHARACTERSVIEWER                 = "Characters Viewer";
   BINDING_NAME_CHARACTERSVIEWER_TOGGLE            = "Open / Close CharactersViewer";
   BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS   = "Switch to the previous character";
   BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT       = "Switch to the next character";

   CHARACTERSVIEWER_CRIT                           = "Critical";

   CHARACTERSVIEWER_SELPLAYER                      = "Switch";
   CHARACTERSVIEWER_DROPDOWN2                      = "Compare";
   CHARACTERSVIEWER_TOOLTIP_BAGRESET               = "Left-Click: Toggle bags display on/off.\nRight-Click: Reset layout position.";
   CHARACTERSVIEWER_TOOLTIP_MAIL                   = "Left-Click: Toggle the Inbox(MailTo) display on/off.\nRight-Click: Reset layout position.";
	CHARACTERSVIEWER_TOOLTIP_BANK                   = "Left-Click: Toggle the Bank display on/off.\nRight-Click: Reset layout position.";
   CHARACTERSVIEWER_TOOLTIP_DROPDOWN2              = "Click to select one of your other characters from the same server,\nit'll be displayed with CharactersViewer Frame";
	CHARACTERSVIEWER_TOOLTIP_BANKBAG                = "Left-Click: Toggle bank bags display on/off.\nRight-Click: Reset layout position.";

   CHARACTERSVIEWER_PROFILECLEARED                 = "This profile has been deleted: ";
   CHARACTERSVIEWER_ALLPROFILECLEARED              = "Profiles for all server have been cleared. Current character profile added";
   CHARACTERSVIEWER_NOT_FOUND                      = "Character not found: ";

   CHARACTERSVIEWER_USAGE                          = "Usage: '/cv <command>' where <command> is";
   CHARACTERSVIEWER_USAGE_SUBCMD                   = {};
   CHARACTERSVIEWER_USAGE_SUBCMD[1]                = " show : displays equipment/stats in a PaperDoll window";
   CHARACTERSVIEWER_USAGE_SUBCMD[2]                = " clear <arg1>: clear the profile of character <arg1>";
   CHARACTERSVIEWER_USAGE_SUBCMD[3]                = " clearall : clear all stored equipement/stats for all chars in all servers";
   CHARACTERSVIEWER_USAGE_SUBCMD[4]                = " previous : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS;
   CHARACTERSVIEWER_USAGE_SUBCMD[5]                = " next : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT;
   CHARACTERSVIEWER_USAGE_SUBCMD[6]                = " switch <arg1>: Switch to character <arg1>";
   CHARACTERSVIEWER_USAGE_SUBCMD[7]                = " list : Display various information about player on the current server";

   CHARACTERSVIEWER_DESCRIPTION                    = "|cFF00CC00CharactersViewer|r\nView your other characters equipment, inventory and stats";
   CHARACTERSVIEWER_SHORT_DESC                     = "Toggle CV";
   CHARACTERSVIEWER_ICON                           = "Interface\\Buttons\\Button-Backpack-Up";
   
   CHARACTERSVIEWER_NOT_CACHED                     = "Item not in local cache";
   CHARACTERSVIEWER_RESTED                         = "rested";
   CHARACTERSVIEWER_RESTING                        = "resting";
   CHARACTERSVIEWER_NOT_RESTING                    = "not resting";
	
	CHARACTERSVIEWER_BANK_TITLE							= "CharactersViewer (Bank)";