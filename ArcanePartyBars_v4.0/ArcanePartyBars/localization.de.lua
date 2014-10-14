-- Version : German (by StarDust)
-- $LastChangedBy: stardust $
-- $Date: 2006-07-12 09:19:25 -0500 (Wed, 12 Jul 2006) $

if ( GetLocale() == "deDE" ) then

	BINDING_HEADER_APB_HEADER			= "Geheime Gruppen-Zauberleiste";
	BINDING_NAME_APB_TOGGLE_MOBILITY		= "Leisten zur\195\188cksetzen";
	BINDING_DESCRIPTION_APB_TOGGLE_MOBILITY		= "Erlaubt es die Zauberleisten der Gruppenmitglieder zu verschieben und zur\195\188ckzusetzen.";

	RESET_ALL					= "Alle R\195\188cksetzen";

	ArcanePartyBars.localization = {};
	ArcanePartyBars.localization.TOOLTIP_TEXT	= "Klicken um %s zu verschieben.\nShift-Rechtsklick f\195\188rs Reset-Men\195\188.";
	ArcanePartyBars.localization.PARTY_BAR_TITLE	= "Gruppenleiste %d";
	ArcanePartyBars.localization.RAID_BAR_TITLE	= "Schlachtzugsleiste %d";
	ArcanePartyBars.localization.SIMULATION_FAILURE = "Kann nicht das OnUpdate-Event simulieren. Bitte aktualisiere das AddOn Chronos.";

	ArcanePartyBars.localization.info		= {};
	ArcanePartyBars.localization.MASTER_ENABLE	= "Geheime Gruppen-Zauberleiste";
	ArcanePartyBars.localization.info.MASTER_ENABLE = "Diese Einstellungen konfigurieren die Geheimen Gruppen-Zauberleiste, welche den Zauberfortschritt der Gruppenmitglieder anzeigt.";
	ArcanePartyBars.localization.OPTIONS_HEADER	= "Geheime Gruppen-Zauberleiste";
	ArcanePartyBars.localization.info.OPTIONS_HEADER= "Diese Einstellungen konfigurieren die Geheimen Gruppen-Zauberleiste, welche den Zauberfortschritt der Gruppenmitglieder anzeigt.";
	ArcanePartyBars.localization.RESET_BARS		= "Positionen der Leisten zur\195\188cksetzen";
	ArcanePartyBars.localization.info.RESET_BARS	= "Setzt die Position der Zauberleisten von Gruppenmitgliedern auf die Standardposition zur\195\188ck, welche Oben Rechts beim Fenster des jeweiligen Gruppenmitglieds ist.";
	ArcanePartyBars.localization.MAKE_DRAGGABLE	= "Zauberleisten verschiebbar machen";
	ArcanePartyBars.localization.info.MAKE_DRAGGABLE= "Macht die Zauberleisten sichtbar um jene verschieben zu k\195\182nnen. Erneut klicken um die Zauberleisten wieder zu verbergen und auf der momentanen Position festzusetzen.";
	ArcanePartyBars.localization.UIPARENT		= "innerhalb eigener Gruppenfenster verwenden";
	ArcanePartyBars.localization.info.UIPARENT	= "Legt das Parent-Fenster auf UIParent, wodurch die Geheimen Gruppen-Zauberleisten auch angezeigt werden wenn die standard Gruppenfenster ausgeblendet sind (zum Beispiel durch ein anderes AddOn).";
	ArcanePartyBars.localization.SPELL_TEXTURES	= "Icon des Zaubers neben der Zauberleiste anzeigen";
	ArcanePartyBars.localization.info.SPELL_TEXTURES= "Wenn aktiviert, wird neben der jeweiligen Zauberleiste das Icon des jeweils gerade gewirkten Zaubers angezeigt.";
	ArcanePartyBars.localization.ONLY_ON_TARGET	= "nur Zauber auf momentanes Ziel anzeigen";
	ArcanePartyBars.localization.info.ONLY_ON_TARGET= "Wenn aktiviert, werden nur Zauber angezeigt, welche auf dein momentanes Ziel gewirkt werden.";
	ArcanePartyBars.localization.TOP_TEXT		= "Text nach Oben bewegen";
	ArcanePartyBars.localization.info.TOP_TEXT	= "Wenn aktiviert, wird der Ziel- und Zauberzeit-Text \195\188ber die Zauberleiste bewegt. Standard ist Rechts neben der Zauberleiste.";
	ArcanePartyBars.localization.AUTO_JOIN		= "SkyGruppe Channel automatisch beitreten.";
	ArcanePartyBars.localization.AUTO_JOIN_ALERT	= "Du musst dem SkyGruppe Channel beitreten damit die Geheime Gruppen-Zauberleiste funktioniert.";
	ArcanePartyBars.localization.info.AUTO_JOIN	= "Wenn aktiviert, wird versucht dem richtigen SkyGruppe Channel immer automatisch beizutreten, sobald du einer Gruppe beitrittst oder dessen Anf\195\188hrer wechselt.";
	ArcanePartyBars.localization.SEND_CASTS		= "Zauber-Ereignisse an andere Gruppenmitglieder senden";
	ArcanePartyBars.localization.info.SEND_CASTS	= "Wenn aktiviert, k\195\182nnen andere Gruppenmitglieder deine Zauberzeit \195\188ber deren Geheime Gruppen-Zauberleiste sehen.";
	ArcanePartyBars.localization.SHOW_CASTS		= "Zauber-Ereignisse anderer Gruppenmitglieder anzeigen";
	ArcanePartyBars.localization.info.SHOW_CASTS	= "Wenn aktiviert, kannst du die Zauberzeit anderer Gruppenmitglieder sehen, sofern jene die Option \"Zauber-Ereignisse an andere Gruppenmitglieder senden\" aktiviert haben.";
	ArcanePartyBars.localization.SIMULATE_ONUPDATE	= "OnUpdate Event simulieren";
	ArcanePartyBars.localization.info.SIMULATE_ONUPDATE = "Wenn aktiviert, wird die Animationsgeschwindigkeit der Geheimen Gruppen-Zauberleiste eingebremst. Verwende diese Option, wenn sich deine FPS-Rate (Bilder pro Sekunde) stark verschlechtert sobald Gruppenmitglieder Zaubern.";
	ArcanePartyBars.localization.SIM_PERIOD		= "OnUpdate Event Zyklus";
	ArcanePartyBars.localization.SIM_PERIOD_TEXT	= "Aktualisierungen pro Sekunde";
	ArcanePartyBars.localization.info.SIM_PERIOD	= "Legt fest, wie oft pro Sekunde die Geheime Gruppen-Zauberleiste seine Zauberleisten aktualisiert.";

end 