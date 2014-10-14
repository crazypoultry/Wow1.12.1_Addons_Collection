--[[
   Version: $Rev: 2521 $
   Last Changed by: $LastChangedBy: stardust $
   Date: $Date: 2005-09-26 07:33:34 -0400 (lun., 26 sept. 2005) $
   
   Note: Please don't remove commented line and change the layout of this file, the main goal is to have 3 localization files with the same layout for easy spotting of missing information.
   The SVN tag at the begining of the file will automaticaly update upon uploading.
]]--

if (GetLocale() == "deDE") then
	
	-- Configuration variables
	--   SLASH_CHARACTERSVIEWER1                    = "/charactersviewer";
	--   SLASH_CHARACTERSVIEWER2                    = "/cv";
	--   CHARACTERSVIEWER_SUBCMD_SHOW               = "show";
	--   CHARACTERSVIEWER_SUBCMD_CLEAR              = "clear";
	--   CHARACTERSVIEWER_SUBCMD_CLEARALL           = "clearall";
	--   CHARACTERSVIEWER_SUBCMD_PREVIOUS           = "previous";
	--   CHARACTERSVIEWER_SUBCMD_NEXT               = "next";
	--   CHARACTERSVIEWER_SUBCMD_SWITCH             = "switch";
	--   CHARACTERSVIEWER_SUBCMD_LIST               = "list";

	-- Localization text
	BINDING_HEADER_CHARACTERSVIEWER                 = "Charakter Anzeiger";
	BINDING_NAME_CHARACTERSVIEWER_TOGGLE            = "Fenster anzeigen/verbergen";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS   = "Auf vorherigen Charakter wechseln";
	BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT       = "Auf n\195\164chsten Charakter wechseln";

	CHARACTERSVIEWER_CRIT                           = "Kritisch";

	CHARACTERSVIEWER_SELPLAYER                      = "Wechseln";
	CHARACTERSVIEWER_DROPDOWN2                      = "Vergleichen";
	CHARACTERSVIEWER_TOOLTIP_BAGRESET               = "Links-Klick: Schaltet die Taschen ein/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	CHARACTERSVIEWER_TOOLTIP_MAIL                   = "Links-Klick: Postkasten (MailTo) Anzeige an/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	CHARACTERSVIEWER_TOOLTIP_BANK                  	= "Links-Klick: Schaltet die Bank ein/aus.\nRight-Click: Reset Bank position.";
	CHARACTERSVIEWER_TOOLTIP_DROPDOWN2              = "Klicken um einen deiner anderen Charaktere vom selben Server auszuw\195\164hlen und im Fenster des CharaktersAnzeigers darzustellen.";
	CHARACTERSVIEWER_TOOLTIP_BANKBAG                = "Links-Klick: Schaltet die Bank Taschen ein/aus.\nRechts-Klick: Setzt die Anzeige zur\195\188ck.";
	      
	CHARACTERSVIEWER_PROFILECLEARED                 = "Dieses Profil wurde gel\195\182scht: ";
	CHARACTERSVIEWER_ALLPROFILECLEARED              = "Profile aller Server wurden gel\195\182scht. Der aktuelle Charakter wurde neu hinzugef\195\188gt.";
	CHARACTERSVIEWER_NOT_FOUND                      = "Charakter nicht gefunden: ";

	CHARACTERSVIEWER_USAGE                          = "Benutzung: '/cv <Befehl>' <Befehl> kann folgendes sein";
	CHARACTERSVIEWER_USAGE_SUBCMD                   = {};
	CHARACTERSVIEWER_USAGE_SUBCMD[1]                = CHARACTERSVIEWER_SUBCMD_SHOW.." : Ausr\195\188stung/Werte in einem Charakterfenster anzeigen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[2]                = CHARACTERSVIEWER_SUBCMD_CLEAR.." <arg1>: Charakterprofil von <arg1> l\195\182schen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[3]                = CHARACTERSVIEWER_SUBCMD_CLEARALL.." : Alle gespeicherten Daten f\195\188r ALLE Charaktere auf allen Servern l\195\182schen.";
	CHARACTERSVIEWER_USAGE_SUBCMD[4]                = CHARACTERSVIEWER_SUBCMD_PREVIOUS.." : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_PREVIOUS;
	CHARACTERSVIEWER_USAGE_SUBCMD[5]                = CHARACTERSVIEWER_SUBCMD_NEXT .." : " .. BINDING_NAME_CHARACTERSVIEWER_SWITCH_NEXT;
	CHARACTERSVIEWER_USAGE_SUBCMD[6]                = CHARACTERSVIEWER_SUBCMD_SWITCH.." <arg1>: Zu Charakter <arg1> wechseln.";
	CHARACTERSVIEWER_USAGE_SUBCMD[7]                = CHARACTERSVIEWER_SUBCMD_LIST.." : Zeigt verschieden Informationen \195\188ber den Spieler am aktuellen Server an.";

	CHARACTERSVIEWER_DESCRIPTION                      = "|cFF00CC00CharactersViewer|r\nSpeichert die Ausr\195\188stung, den Tascheninhalt und die Fertigkeiten all deiner Charaktere.";
	CHARACTERSVIEWER_SHORT_DESC                     = "CharakterAnzeiger anzeigen/verbergen";
	-- CHARACTERSVIEWER_ICON                        = "Interface\\Buttons\\Button-Backpack-Up";

	CHARACTERSVIEWER_NOT_CACHED                     = "Objekt nicht im lokalen Cache";
	CHARACTERSVIEWER_RESTED                         = "ausgeruht";
	CHARACTERSVIEWER_RESTING                        = "ruhen";
	CHARACTERSVIEWER_NOT_RESTING                    = "nicht ruhend";

	CHARACTERSVIEWER_BANK_TITLE			= "Charakter Anzeiger (Bank)";
end