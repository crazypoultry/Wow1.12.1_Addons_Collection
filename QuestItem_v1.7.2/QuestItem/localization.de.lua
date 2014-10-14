-- QuestItem DE localization
-- Update: 04/27/2006 ( by Thernel )
-- Last Update : 06/04/2006 (by Morrowind)

if (GetLocale()=="deDE") then
	QUESTITEM_UNIDENTIFIED 				= "Unidentifizierte quest";
	QUESTITEM_LOADED 					= QUESTITEM_TITLE .. " " .. QUESTITEM_VERSION .. " Geladen";
	QUESTITEM_SLAIN 					= "get\195\182tet";
	QUESTITEM_QUESTITEM 				= "Questgegenstand";
	
	QUESTITEM_CANTIDENTIFY 				= "Quest nicht zuordbar f\195\188r ";
	QUESTITEM_QUESTCOMPLETE				= "Quest ist abgeschlossen";
	QUESTITEM_COMPLETEABANDONED 		= "Quest ist abgeschlossen oder abgebrochen";
	QUESTITEM_ABANDONED 				= "Quest ist abgebrochen";
	QUESTITEM_QUESTACTIVE 				= "Quest ist aktiv";
	
	-- Configuration window
	QUESTITEM_ITEMS 					= "Gegenst\195\164nde";
	QUESTITEM_SETTINGS 					= "Einstellungen";
	QUESTITEM_CFG_CHK_ENABLED 			= "Aktiviert";
	QUESTITEM_CFG_CHK_ENABLED_TT 		= "Markiert lassen um QuestItem zu aktivieren";
	QUESTITEM_CFG_CHK_ALERT 			= "Benachrichtigung, falls Zuordnung eines \n\rGegenstandes fehlschl\195\164gt";
	QUESTITEM_CFG_CHK_ALERT_TT 			= "Sichtbarer Alarm wenn ein Questgegenstand aufgesammelt wird, der noch nicht von Questitem zuordenbar ist. Dieser Alarm dient dazu, damit Du diesen Gegenstand manuell einer Quest zuordnen kannst.";
	QUESTITEM_CFG_CHK_DISREQU 			= "'Versuche Zuordnung' Tooltip";
	QUESTITEM_CFG_CHK_DISREQU_TT 		= "Zeige einen 'Versuche Zuordnung' Menueintrag im Tooltip f\195\188r nichtidentifizierte Gegenst\195\164nde.";
	QUESTITEM_CFG_CHK_SHIFTOPN 			= "'Shift + Klick' um QuestLog f\195\188r einen Gegenstand zu \195\182ffnen";
	QUESTITEM_CFG_CHK_SHIFTOPN_TT		= "'Shift + Linksklick' um das Questlog f\195\188r die Quest zu \195\182ffnen zu der dieser Gegenstand geh\195\182rt.";
	QUESTITEM_CFG_CHK_ALTOPN 			= "Alt + Rechtsklick f\195\188r das QuestLog eines Gegenstandes";
	QUESTITEM_CFG_CHK_ALTOPN_TT 		= "'Alt + Rechtsklick' \195\182ffnet das Questlog f\195\188r die Quest zu der dieser Gegenstand geh\195\182rt.";
	QUESTITEM_CFG_CHK_DISPLAYTT 		= "Tooltip in Itemliste anzeigen";
	QUESTITEM_CFG_CHK_DISPLAYTT_TT 		= "Zeigt einen Tooltip in der Itemliste, der zeigt, wie man Zuordnungen \195\164ndert";
	QUESTITEM_CFG_CHK_ONLYFORPLAYER_TT 	= "In der Itemliste nur die Questgegenst\195\164nde des aktiven Charakters anzeigen";
	QUESTITEM_CFG_CHK_ONLYFORPLAYER 	= "Questgegenst\195\164nde nur des aktiven Spielers"; 
	QUESTITEM_CFG_CHK_DISPLAYCOUNT 		= "Anzahl anzeigen";
	QUESTITEM_CFG_CHK_DISPLAYCOUNT_TT 	= "Zeigt im Tooltip an, welche Anzahl von diesem Questgegenstand f\195\188r die jeweilige Quest ben\195\182tigt wird";
	
	QUESTITEM_INP_TITLE 				= "QuestItem Zuordnung";
	QUESTITEM_ITM_SHOWALL 				= "Zeige nur unzugeordnete";
	QUESTITEM_ITM_SHOWALL_TT 			= "Markeren um nur unzugeordnete Gegenst\195\164nde anzuzeigen.";
	
	QUESTITEM_ITEMS_EDIT_M_TT 			= "Rechtsklick zum \195\164ndern";
	QUESTITEM_ITEMS_EDIT_SHIFT_M_TT 	= "Shift + Rechtsklick zum \195\164ndern";
	
	QUESTITEM_NO_QUEST 					= "Dieses Quest ist nicht im Questlog";
	
	QUESTITEM_SAVE 						= "Speichern";
	QUESTITEM_CANCEL 					= "Abbrechen";
end

-- ö = \195\182
-- ü = \195\188
-- ä = \195\164