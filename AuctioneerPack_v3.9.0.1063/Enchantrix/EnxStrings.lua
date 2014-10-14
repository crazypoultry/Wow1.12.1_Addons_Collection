--[[
	WARNING: This is a generated file.
	If you wish to perform or update localizations, please go to our Localizer website at:
	http://norganna.org/localizer/index.php

	AddOn: Enchantrix
	Revision: $Id: EnxStrings.lua 1000 2006-09-12 02:19:20Z mentalpower $
	Version: 3.9.0.1000 (Kangaroo)

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
]]

EnchantrixLocalizations = {

	deDE = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Das Enchantrix-Fenster ist nicht ge\195\182ffnet. Das Enchantrix-Fenster muss ge\195\182ffnet sein um Barker nutzen zu k\195\182nnen.";
		BarkerNoEnchantsAvail	= "Enchantrix: Sie haben entweder keine Entzauberungen oder keine Gegenst\195\164nde um welche herzustellen.";
		FrmtActClearall	= "L\195\182sche alle Entzauberungsdaten";
		FrmtActClearFail	= "Kann Gegenstand %s nicht finden";
		FrmtActClearOk	= "Daten f\195\188r Gegenstand %s gel\195\182scht";
		FrmtActDefault	= "Die Enchantrix-Option '%s' wurde auf den Standardwert zur\195\188ckgesetzt.";
		FrmtActDefaultAll	= "Alle Enchantrix-Optionen wurden auf die Standardwerte zur\195\188ckgesetzt.";
		FrmtActDisable	= "Zeige keine Daten von Gegenstand %s";
		FrmtActEnable	= "Zeige Daten von Gegenstand %s";
		FrmtActEnabledOn	= "Zeige Gegenstand %s auf %s";
		FrmtActSet	= "Setze %s zu '%s'";
		FrmtActUnknown	= "Unbekannter Befehl: '%s'";
		FrmtActUnknownLocale	= "Das angegebene Gebietsschema ('%s') ist unbekannt. G\195\188ltige Gebietsschemata sind:";
		FrmtPrintin	= "Die Enchantrix-Meldungen werden nun im Chat-Fenster \"%s\" angezeigt";
		FrmtUsage	= "Syntax:";
		MesgDisable	= "Das automatische Laden von Enchantrix wird deaktiviert";
		MesgNotloaded	= "Enchantrix ist nicht geladen. Geben Sie /enchantrix ein um mehr Informationen zu erhalten.";


		-- Section: Command Options
		CmdClearAll	= "all";
		OptClear	= "([Gegenstand]|all)";
		OptDefault	= "(<Option>|all)";
		OptFindBidauct	= "<Silber>";
		OptFindBuyauct	= "<Prozent>";
		OptLocale	= "<Sprache>";
		OptPrintin	= "(<Fenster-Index>[Nummer]|<Fenster-Name>[String])";


		-- Section: Commands
		BarkerOff	= "Barker ausgeschaltet.";
		BarkerOn	= "Barker eingeschaltet.";
		CmdBarker	= "barker";
		CmdClear	= "clear";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "percentless";
		CmdFindBuyauctShort	= "pl";
		CmdHelp	= "help";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPrintin	= "print-in";
		CmdToggle	= "toggle";
		ShowCount	= "counts";
		ShowEmbed	= "embed";
		ShowGuessAuctioneerHsp	= "valuate-hsp";
		ShowGuessAuctioneerMed	= "valuate-median";
		ShowGuessBaseline	= "valuate-baseline";
		ShowHeader	= "header";
		ShowRate	= "rates";
		ShowTerse	= "terse";
		ShowValue	= "valuate";
		StatOff	= "Die Anzeige von Entzauberungsdaten wurde deaktiviert";
		StatOn	= "Die Anzeige von Entzauberungsdaten wurde aktiviert";


		-- Section: Config Text
		GuiLoad	= "Enchantrix laden";
		GuiLoad_Always	= "immer";
		GuiLoad_Never	= "nie";


		-- Section: Game Constants
		ArgSpellname	= "Entzaubern";
		BarkerOpening	= "Verkaufe Verzauberungen:";
		Darnassus	= "Darnassus";
		Ironforge	= "Ironforge";
		OneLetterGold	= "G";
		OneLetterSilver	= "S";
		Orgrimmar	= "Orgrimmar";
		PatReagents	= "Reagenzien: (.+)";
		ShortDarnassus	= "Dar";
		ShortIronForge	= "IF";
		ShortOrgrimmar	= "Org";
		ShortStormwind	= "SW";
		ShortThunderBluff	= "TB";
		ShortUndercity	= "UC";
		StormwindCity	= "Stormwind";
		TextCombat	= "Kampflog";
		TextGeneral	= "Allgemein";
		ThunderBluff	= "Thunderbluff";
		Undercity	= "Undercity";


		-- Section: Generic Messages
		FrmtCredit	= "(besuche http://enchantrix.org/ um deine Entzauberdaten mit anderen zu teilen)";
		FrmtWelcome	= "Enchantrix v%s geladen";
		MesgAuctVersion	= "Enchantrix ben\195\182tigt Auctioneer Version 3.4 oder h\195\182her. Einige Funktionen werden nicht verf\195\188gbar sein, bis Sie ihre Auctioneer Version aktualisieren.";


		-- Section: Help Text
		GuiBarker	= "Barker aktivieren";
		GuiClearall	= "Alle Enchantrix-Daten l\195\182schen";
		GuiClearallButton	= "Alles l\195\182schen";
		GuiClearallHelp	= "Hier klicken um alle Enchantrix-Daten auf dem aktuellen Realm zu l\195\182schen.";
		GuiClearallNote	= "der aktuellen Fraktion auf dem aktuellen Realm";
		GuiCount	= "Zeige die genaue Anzahl aus der Datenbank";
		GuiDefaultAll	= "Alle Einstellungen zur\195\188cksetzen";
		GuiDefaultAllButton	= "Zur\195\188cksetzen";
		GuiDefaultAllHelp	= "Hier klicken um alle Enchantrix-Optionen auf ihren Standardwert zu setzen.\nWARNUNG: Dieser Vorgang kann NICHT r\195\188ckg\195\164ngig gemacht werden.";
		GuiDefaultOption	= "Zur\195\188cksetzen folgender Einstellung";
		GuiEmbed	= "In-Game Tooltip zur Anzeige verwenden";
		GuiLocale	= "Setze das Gebietsschema auf";
		GuiMainEnable	= "Enchantrix aktivieren";
		GuiMainHelp	= "Einstellungen f\195\188r Enchantrix - ein AddOn, das Informationen \195\188ber die m\195\182glichen Entzauberungen eines Gegenstands als Tooltip anzeigt.";
		GuiOtherHeader	= "Sonstige Optionen";
		GuiOtherHelp	= "Sonstige Enchantrix-Optionen";
		GuiPrintin	= "Fenster f\195\188r Meldungen ausw\195\164hlen";
		GuiRate	= "Zeige die durchschnittliche Anzahl der Entzauberungen";
		GuiReloadui	= "Benutzeroberfl\195\164che neu laden";
		GuiReloaduiButton	= "Neu laden";
		GuiReloaduiFeedback	= "WoW-Benutzeroberfl\195\164che wird neu geladen";
		GuiReloaduiHelp	= "Hier klicken um die WoW-Benutzeroberfl\195\164che nach einer \n\195\132nderung des Gebietsschemas neu zu laden, so dass die Sprache des Konfigurationsmen\195\188s diesem entspricht.\nHinweis: Dieser Vorgang kann einige Minuten dauern.";
		GuiTerse	= "Kurzinfo-Modus aktivieren";
		GuiValuateAverages	= "Verkaufspreis anzeigen (Auctioneer Durchschnittswerte)";
		GuiValuateBaseline	= "Verkaufspreis anzeigen (Interne Preisliste)";
		GuiValuateEnable	= "Wertsch\195\164tzung aktivieren";
		GuiValuateHeader	= "Wertsch\195\164tzung";
		GuiValuateMedian	= "Ermitteln von Durchschnittspreisen (Auctioneer Median)";
		HelpBarker	= "Schaltet Barker ein und aus";
		HelpClear	= "L\195\182sche die Daten des angegebenen Gegenstands (Gegenst\195\164nde m\195\188ssen mit Shift-Klick einf\195\188gt werden). Mit dem Schl\195\188sselwort \"all\" werden alle Daten gel\195\182scht.";
		HelpCount	= "Ausw\195\164hlen ob die genaue Anzahl der Entzauberungen aus der Datenbank angezeigt wird";
		HelpDefault	= "Setzt die angegebene Enchantrix-Option auf ihren Standardwert zur\195\188ck. Mit dem Schl\195\188sselwort \"all\" werden alle Enchantrix-Optionen zur\195\188ckgesetzt.";
		HelpDisable	= "Verhindert das automatische Laden von Enchantrix beim Login";
		HelpEmbed	= "Zeige den Text im In-Game Tooltip \n(Hinweis: Einige Funktionen stehen dann nicht zur Verf\195\188gung)";
		HelpFindBidauct	= "Suche Auktionen deren Entzauberungswert einen bestimmten Betrag (in Silber) unter dem Gebotspreis liegt";
		HelpFindBuyauct	= "Suche Auktionen deren Entzauberungswert einen bestimmten Prozentsatz unter dem Sofortkaufpreis liegt";
		HelpGuessAuctioneerHsp	= "Wenn die Wertsch\195\164tzung aktiviert und Auctioneer installiert ist, zeige den maximalen Verkaufspreis (Auctioneer-HVP) f\195\188r das Entzaubern";
		HelpGuessAuctioneerMedian	= "Wenn die Wertsch\195\164tzung aktiviert und Auctioneer installiert ist, zeige den durchschnittlichen Verkaufspreis (Auctioneer-MEDIAN) f\195\188r das Entzaubern";
		HelpGuessBaseline	= "Wenn die Wertsch\195\164tzung aktiviert ist, zeige den Marktpreis aus der internen Preisliste (Auctioneer wird nicht ben\195\182tigt)";
		HelpGuessNoauctioneer	= "Die Befehle \"valuate-hsp\" und \"valuate-median\" sind nicht verf\195\188gbar weil Auctioneer nicht installiert ist";
		HelpHeader	= "Ausw\195\164hlen ob die Kopfzeile angezeigt werden soll";
		HelpLoad	= "Ladeverhalten von Enchantrix f\195\188r diesen Charakter \195\164ndern";
		HelpLocale	= "\195\132ndern des Gebietsschemas das zur Anzeige \nvon Enchantrix-Meldungen verwendet wird";
		HelpOnoff	= "Schaltet die Anzeige von Entzauberungsdaten ein oder aus";
		HelpPrintin	= "Ausw\195\164hlen in welchem Fenster die Enchantrix-Meldungen angezeigt werden. Es kann entweder der Fensterindex oder der Fenstername angegeben werden.";
		HelpRate	= "Ausw\195\164hlen ob die durchschnittliche Anzahl der Entzauberungen angezeigt wird";
		HelpTerse	= "Aktivieren/Deaktivieren des Kurzinfo-Modus, bei dem nur der Entzauberungswert angezeigt wird. Durch dr\195\188cken der STRG-Taste werden in diesem Modus alle Infos gezeigt.";
		HelpValue	= "Ausw\195\164hlen ob gesch\195\164tzte Verkaufspreise aufgrund \nder Anteile an m\195\182glichen Entzauberungen angezeigt werden";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "aktGeb";
		FrmtBidbrokerDone	= "Die Auktionssuche (Betrag unter Gebotspreis) ist abgeschlossen.";
		FrmtBidbrokerHeader	= "Auktionen mit %s Silber Einsparung auf den durchschnittlichen Entzauberungswert:";
		FrmtBidbrokerLine	= "%s, Wert bei: %s, %s: %s, Ersparnis: %s, %s weniger, Zeit: %s";
		FrmtBidbrokerMinbid	= "minGeb";
		FrmtBidBrokerSkipped	= "%d% Auktionen \195\188bersprungen da Gewinnspanne von (%d%%) unterschritten";
		FrmtPctlessDone	= "Die Auktionssuche (Prozent unter Sofortkauf) ist abgeschlossen.";
		FrmtPctlessHeader	= "Sofortkauf-Auktionen mit %d%% Einsparung auf durchschnittlichen Entzauberungswert:";
		FrmtPctlessLine	= "%s, Wert bei: %s, SK: %s, Ersparnis: %s, %s weniger";
		FrmtPctlessSkipped	= "%d Auktionen \195\188bersprungen, da Gewinngrenze von (%s) Prozen unterschritten";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Barker Preis (%d%% Gewinn)";
		FrmtCounts	= "(Basis=%d, Alt=%d, Neu=%d)";
		FrmtDisinto	= "M\195\182gliche Entzauberung zu:";
		FrmtFound	= "%s wird entzaubert zu:";
		FrmtPriceEach	= "(%s/stk)";
		FrmtSuggestedPrice	= "vorgeschlagener Preis";
		FrmtTotal	= "Gesamtsumme";
		FrmtValueAuctHsp	= "Entzauberungswert (HVP)";
		FrmtValueAuctMed	= "Entzauberungswert (Median)";
		FrmtValueMarket	= "Entzauberungswert (Marktpreis)";
		FrmtWarnAuctNotLoaded	= "Auktionstool nicht geladen, es werden gespeicherte Preise benutzt";
		FrmtWarnNoPrices	= "Keine Preise verf\195\188gbar";
		FrmtWarnPriceUnavail	= "Einige Preise nicht verf\195\188gbar";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "H\195\182chster Preisfaktor";
		BarkerOptionsHighestPriceForFactorTooltip	= "Entzauberungen erhalten einen Score von null f\195\188r die Preispriorit\195\164t, auf diesem bzw. \195\188ber diesem Wert.";
		BarkerOptionsHighestProfitTitle	= "H\195\182chster Gewinn";
		BarkerOptionsHighestProfitTooltip	= "H\195\182chster machbarer Gewinn f\195\188r eine Entzauberung.";
		BarkerOptionsLowestPriceTitle	= "Niedrigster Preis";
		BarkerOptionsLowestPriceTooltip	= "Niedrigster Angebotspreis f\195\188r eine Entzauberung. ";
		BarkerOptionsPricePriorityTitle	= "Gesamt-Preispriorit\195\164t";
		BarkerOptionsPricePriorityTooltip	= "Legt die Wichtigkeit, der Preisermittlung innerhalb der Gesamtpriorit\195\164t der Werbema\195\159nahmen, fest.";
		BarkerOptionsPriceSweetspotTitle	= "Preisfaktor SweetSpot";
		BarkerOptionsPriceSweetspotTooltip	= "Preisbereich der bevorzugten Entzauberungen f\195\188r Werbema\195\159nahmen.";
		BarkerOptionsProfitMarginTitle	= "Gewinnspanne";
		BarkerOptionsProfitMarginTooltip	= "Der prozentuale Gewinnanteil, welcher zu den Standartkosten hinzuaddiert werden soll.";
		BarkerOptionsRandomFactorTitle	= "Zufallsfaktor";
		BarkerOptionsRandomFactorTooltip	= "Legt die Gr\195\182\195\159e des Zufallsfaktors, in welchem Entzauberungen f\195\188r die Handelsausrufe ausgew\195\164hlt werden fest.";
		BarkerOptionsTab1Title	= "Gewinn und Preispriorit\195\164ten";

	};

	enUS = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Enchantrix: The enchant window is not open. The enchanting window must be open in order to use the barker.";
		BarkerNoEnchantsAvail	= "Enchantrix: You either don't have any enchants or don't have the reagents to make them.";
		FrmtActClearall	= "Clearing all enchant data";
		FrmtActClearFail	= "Unable to find item: %s";
		FrmtActClearOk	= "Cleared data for item: %s";
		FrmtActDefault	= "Enchantrix's %s option has been reset to its default setting";
		FrmtActDefaultAll	= "All Enchantrix options have been reset to default settings.";
		FrmtActDisable	= "Not displaying item's %s data";
		FrmtActEnable	= "Displaying item's %s data";
		FrmtActEnabledOn	= "Displaying item's %s on %s";
		FrmtActSet	= "Set %s to '%s'";
		FrmtActUnknown	= "Unknown command keyword: '%s'";
		FrmtActUnknownLocale	= "The locale you specified ('%s') is unknown. Valid locales are:";
		FrmtPrintin	= "Enchantrix's messages will now print on the \"%s\" chat frame";
		FrmtUsage	= "Usage:";
		MesgDisable	= "Disabling automatic loading of Enchantrix";
		MesgNotloaded	= "Enchantrix is not loaded. Type /enchantrix for more info.";


		-- Section: Command Options
		CmdClearAll	= "all";
		OptClear	= "([Item]|all)";
		OptDefault	= "(<option>|all)";
		OptFindBidauct	= "<silver>";
		OptFindBuyauct	= "<percent>";
		OptLocale	= "<locale>";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String])";


		-- Section: Commands
		BarkerOff	= "Barker function disabled.";
		BarkerOn	= "Barker function enabled.";
		CmdBarker	= "barker";
		CmdClear	= "clear";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "percentless";
		CmdFindBuyauctShort	= "pl";
		CmdHelp	= "help";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPrintin	= "print-in";
		CmdToggle	= "toggle";
		ShowCount	= "counts";
		ShowEmbed	= "embed";
		ShowGuessAuctioneerHsp	= "valuate-hsp";
		ShowGuessAuctioneerMed	= "valuate-median";
		ShowGuessBaseline	= "valuate-baseline";
		ShowHeader	= "header";
		ShowRate	= "rates";
		ShowTerse	= "terse";
		ShowValue	= "valuate";
		StatOff	= "Not displaying any enchant data";
		StatOn	= "Displaying configured enchant data";


		-- Section: Config Text
		GuiLoad	= "Load Enchantrix";
		GuiLoad_Always	= "always";
		GuiLoad_Never	= "never";


		-- Section: Game Constants
		ArgSpellname	= "Disenchant";
		BarkerOpening	= "Selling Enchants:";
		Darnassus	= "Darnassus";
		Ironforge	= "City of IronForge";
		OneLetterGold	= "g";
		OneLetterSilver	= "s";
		Orgrimmar	= "Orgrimmar";
		PatReagents	= "Reagents: (.+)";
		ShortDarnassus	= "Dar";
		ShortIronForge	= "IF";
		ShortOrgrimmar	= "Org";
		ShortStormwind	= "SW";
		ShortThunderBluff	= "TB";
		ShortUndercity	= "UC";
		StormwindCity	= "Stormwind City";
		TextCombat	= "Combat";
		TextGeneral	= "General";
		ThunderBluff	= "Thunder Bluff";
		Undercity	= "Undercity";


		-- Section: Generic Messages
		FrmtCredit	= "  (go to http://enchantrix.org/ to share your data)";
		FrmtWelcome	= "Enchantrix v%s loaded";
		MesgAuctVersion	= "Enchantrix requires Auctioneer version 3.4 or higher. Some features will be unavailable until you update your Auctioneer installation.";


		-- Section: Help Text
		GuiBarker	= "Enable Barker";
		GuiClearall	= "Clear All Enchantrix Data";
		GuiClearallButton	= "Clear All";
		GuiClearallHelp	= "Click here to clear all of Enchantrix data for the current server-realm.";
		GuiClearallNote	= "for the current server-faction";
		GuiCount	= "Show the exact counts in the database";
		GuiDefaultAll	= "Reset All Enchantrix Options";
		GuiDefaultAllButton	= "Reset All";
		GuiDefaultAllHelp	= "Click here to set all Enchantrix options to their default values.\nWARNING: This action is NOT undoable.";
		GuiDefaultOption	= "Reset this setting";
		GuiEmbed	= "Embed info in in-game tooltip";
		GuiLocale	= "Set locale to";
		GuiMainEnable	= "Enable Enchantrix";
		GuiMainHelp	= "Contains settings for Enchantrix \nan AddOn that displays information in item tooltips pertaining to the results of disenchanting said item.";
		GuiOtherHeader	= "Other Options";
		GuiOtherHelp	= "Miscellaneous Enchantrix Options";
		GuiPrintin	= "Select the desired message frame";
		GuiRate	= "Show the average quantity of disenchant";
		GuiReloadui	= "Reload User Interface";
		GuiReloaduiButton	= "ReloadUI";
		GuiReloaduiFeedback	= "Now Reloading the WoW UI";
		GuiReloaduiHelp	= "Click here to reload the WoW User Interface after changing the locale so that the language in this configuration screen matches the one you selected.\nNote: This operation may take a few minutes.";
		GuiTerse	= "Enable terse mode";
		GuiValuateAverages	= "Valuate with Auctioneer Averages";
		GuiValuateBaseline	= "Valuate with Built-in Data";
		GuiValuateEnable	= "Enable Valuation";
		GuiValuateHeader	= "Valuation";
		GuiValuateMedian	= "Valuate with Auctioneer Medians";
		HelpBarker	= "Turns Barker on and off";
		HelpClear	= "Clear the specified item's data (you must shift click insert the item(s) into the command) You may also specify the special keyword \"all\"";
		HelpCount	= "Select whether to show the exact counts in the database";
		HelpDefault	= "Set an Enchantrix option to it's default value. You may also specify the special keyword \"all\" to set all Enchantrix options to their default values.";
		HelpDisable	= "Stops enchantrix from automatically loading next time you log in";
		HelpEmbed	= "Embed the text in the original game tooltip (note: certain features are disabled when this is selected)";
		HelpFindBidauct	= "Find auctions whose possible disenchant value is a certain silver amount less than the bid price";
		HelpFindBuyauct	= "Find auctions whose buyout price is a certain percent less than the possible disenchant value (and, optionally, a certain amount less than the disenchant value)";
		HelpGuessAuctioneerHsp	= "If valuation is enabled, and you have Auctioneer installed, display the sellable price (HSP) valuation of disenchanting the item.";
		HelpGuessAuctioneerMedian	= "If valuation is enabled, and you have Auctioneer installed, display the median based valuation of disenchanting the item.";
		HelpGuessBaseline	= "If valuation is enabled, (Auctioneer not needed) display the baseline valuation of disenchanting the item, based upon the inbuilt prices.";
		HelpGuessNoauctioneer	= "The valuate-hsp and valuate-median commands are not available because you do not have auctioneer installed";
		HelpHeader	= "Select whether to show the header line";
		HelpLoad	= "Change Enchantrix's load settings for this toon";
		HelpLocale	= "Change the locale that is used to display Enchantrix messages";
		HelpOnoff	= "Turns the enchant data display on and off";
		HelpPrintin	= "Select which frame Enchantix will print out it's messages. You can either specify the frame's name or the frame's index.";
		HelpRate	= "Select whether to show the average quantity of disenchant";
		HelpTerse	= "Enable/disable terse mode, showing only disenchant value. Can be overridden by holding down the control key.";
		HelpValue	= "Select whether to show item's estimated values based on the proportions of possible disenchants";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "curBid";
		FrmtBidbrokerDone	= "Bid brokering done";
		FrmtBidbrokerHeader	= "Bids having %s silver savings on average disenchant value (min %%less = %d):";
		FrmtBidbrokerLine	= "%s, Valued at: %s, %s: %s, Save: %s, Less %s, Time: %s";
		FrmtBidbrokerMinbid	= "minBid";
		FrmtBidBrokerSkipped	= "Skipped %d auctions due to profit margin cutoff (%d%%)";
		FrmtPctlessDone	= "Percent less done.";
		FrmtPctlessHeader	= "Buyouts having %d%% savings over average item disenchant value (min savings = %s):";
		FrmtPctlessLine	= "%s, Valued at: %s, BO: %s, Save: %s, Less %s";
		FrmtPctlessSkipped	= "Skipped %d auctions due to profitability cutoff (%s)";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Barker Price (%d%% margin)";
		FrmtCounts	= "    (base=%d, old=%d, new=%d)";
		FrmtDisinto	= "Disenchants into:";
		FrmtFound	= "Found that %s disenchants into:";
		FrmtPriceEach	= "(%s ea)";
		FrmtSuggestedPrice	= "Suggested price:";
		FrmtTotal	= "Total";
		FrmtValueAuctHsp	= "Disenchant value (HSP)";
		FrmtValueAuctMed	= "Disenchant value (Median)";
		FrmtValueMarket	= "Disenchant value (Baseline)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer not loaded, using cached prices]";
		FrmtWarnNoPrices	= "[No prices available]";
		FrmtWarnPriceUnavail	= "[Some prices unavailable]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "PriceFactor Highest";
		BarkerOptionsHighestPriceForFactorTooltip	= "Enchants receive a score of zero for price priority at or above this value.";
		BarkerOptionsHighestProfitTitle	= "Highest Profit";
		BarkerOptionsHighestProfitTooltip	= "The highest total cash profit to make on an enchant.";
		BarkerOptionsLowestPriceTitle	= "Lowest Price";
		BarkerOptionsLowestPriceTooltip	= "The lowest cash price to quote for an enchant.";
		BarkerOptionsPricePriorityTitle	= "Overall Price Priority";
		BarkerOptionsPricePriorityTooltip	= "This sets how important pricing is to the overall priority for advertising.";
		BarkerOptionsPriceSweetspotTitle	= "PriceFactor SweetSpot";
		BarkerOptionsPriceSweetspotTooltip	= "This is used to prioritise enchants near this price for advertising.";
		BarkerOptionsProfitMarginTitle	= "Profit Margin";
		BarkerOptionsProfitMarginTooltip	= "The percentage profit to add to the base mats cost.";
		BarkerOptionsRandomFactorTitle	= "Random Factor";
		BarkerOptionsRandomFactorTooltip	= "The amount of randomness in the enchants chosen for the trade shout.";
		BarkerOptionsTab1Title	= "Profit and Price Priorities";

	};

	esES = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Enchantrix: La ventana del encantar no est\195\161 abierta. La ventana encantadora debe estar abierta para utilizar el barker.";
		BarkerNoEnchantsAvail	= "Enchantrix: Usted no tiene cualesquiera encanta o no tiene los reactivo para hacerlos.";
		FrmtActClearall	= "Eliminando toda informaci\195\179n de desencantamientos";
		FrmtActClearFail	= "Imposible encontrar art\195\173\194\173culo: %s";
		FrmtActClearOk	= "Informacion eliminada para el art\195\173\194\173culo: %s";
		FrmtActDefault	= "La opci\195\179n %s de Enchantrix ha sido revertida a su configuraci\195\179n de f\195\161brica.";
		FrmtActDefaultAll	= "Todas las opciones de Enchantrix han sido revertidas a sus configuraciones de f\195\161brica.";
		FrmtActDisable	= "Ocultando informaci\195\179n de art\195\173culo: %s ";
		FrmtActEnable	= "Mostrando informaci\195\179n del art\195\173\194\173culo: %s ";
		FrmtActEnabledOn	= "Mostrando %s de los art\195\173\194\173culos usando %s";
		FrmtActSet	= "%s ajustado(a) a '%s'";
		FrmtActUnknown	= "Comando o palabra clave desconocida: '%s'";
		FrmtActUnknownLocale	= "La localizaci\195\179n que usted especifico ('%s') no es valida. Locales v\195\161lidos son:";
		FrmtPrintin	= "Los mensajes de Enchantrix se imprimir\195\161n en la ventana de comunicaci\195\179n \"%s\"";
		FrmtUsage	= "Uso:";
		MesgDisable	= "Deshabilitando la carga autom\195\161tica de Enchantrix";
		MesgNotloaded	= "Enchantrix no esta cargado. Escriba /enchantrix para mas informaci\195\179n.";


		-- Section: Command Options
		CmdClearAll	= "todo";
		OptClear	= "([Item]|todo)";
		OptDefault	= "(<opci\195\179n>|todo)";
		OptFindBidauct	= "<dinero>";
		OptFindBuyauct	= "<porciento>";
		OptLocale	= "<localidad>";
		OptPrintin	= "(<indiceVentana>[N\195\186mero]|<nombreVentana>[Serie])";


		-- Section: Commands
		BarkerOff	= "La funci\195\179n de Barker inhabilit\195\179.";
		BarkerOn	= "Funci\195\179n de Barker permitida.";
		CmdBarker	= "barker";
		CmdClear	= "borrar";
		CmdDefault	= "original";
		CmdDisable	= "deshabilitar";
		CmdFindBidauct	= "corredorofertas";
		CmdFindBidauctShort	= "co";
		CmdFindBuyauct	= "porcientomenos";
		CmdFindBuyauctShort	= "pm";
		CmdHelp	= "ayuda";
		CmdLocale	= "localidad";
		CmdOff	= "apagado";
		CmdOn	= "prendido";
		CmdPrintin	= "imprimir-en";
		CmdToggle	= "invertir";
		ShowCount	= "conteo";
		ShowEmbed	= "integrar";
		ShowGuessAuctioneerHsp	= "valorizar-pmv";
		ShowGuessAuctioneerMed	= "valorizar-mediano";
		ShowGuessBaseline	= "valorizar-referencia";
		ShowHeader	= "titulo";
		ShowRate	= "razones";
		ShowTerse	= "conciso";
		ShowValue	= "valorizar";
		StatOff	= "Ocultando toda informaci\195\179n de los desencantamientos";
		StatOn	= "Mostrando la configuraci\195\179n corriente para la informaci\195\179n de los desencantamientos";


		-- Section: Config Text
		GuiLoad	= "Cargar Enchantrix";
		GuiLoad_Always	= "siempre";
		GuiLoad_Never	= "nunca";


		-- Section: Game Constants
		ArgSpellname	= "Desencantar";
		BarkerOpening	= "La venta encanta:";
		Darnassus	= "Darnassus";
		Ironforge	= "Ciudad de IronForge";
		OneLetterGold	= "g";
		OneLetterSilver	= "s";
		Orgrimmar	= "Orgrimmar";
		PatReagents	= "Reactivos: (.+)";
		ShortDarnassus	= "Dar";
		ShortIronForge	= "IF";
		ShortOrgrimmar	= "Org";
		ShortStormwind	= "SW";
		ShortThunderBluff	= "TB";
		ShortUndercity	= "UC";
		StormwindCity	= "Ciudad de Stormwind";
		TextCombat	= "Combate";
		TextGeneral	= "General";
		ThunderBluff	= "Thunder Bluff";
		Undercity	= "Undercity";


		-- Section: Generic Messages
		FrmtCredit	= "(vaya a http://enchantrix.org/ para compart\195\173\194\173r su data)";
		FrmtWelcome	= "Enchantrix versi\195\179n %s cargado";
		MesgAuctVersion	= "Enchantrix requiere la versi\195\179n 3.4 del Auctioneer o m\195\161s alto. Algunas caracter\195\173sticas ser\195\161n inasequibles hasta que usted pone al d\195\173a su instalaci\195\179n del Auctioneer.";


		-- Section: Help Text
		GuiBarker	= "Permita a Barker";
		GuiClearall	= "Eliminar toda la informaci\195\179n";
		GuiClearallButton	= "Eliminar Todo";
		GuiClearallHelp	= "Seleccione aqui para eliminar toda la informaci\195\179n de Enchantrix para el reino-facci\195\179n corriente.";
		GuiClearallNote	= "el reino-facci\195\179n corriente.";
		GuiCount	= "Var valores exactos";
		GuiDefaultAll	= "Revertir todas las opciones de Enchantrix";
		GuiDefaultAllButton	= "Revertir Todo";
		GuiDefaultAllHelp	= "Seleccione aqui para revertir todas las opciones de Auctioneer a sus configuraciones de f\195\161brica.\nADVERTENCIA: Esta acci\195\179n NO es reversible.";
		GuiDefaultOption	= "Revertir esta opci\195\179n";
		GuiEmbed	= "Integrar informaci\195\179n en la caja de ayuda";
		GuiLocale	= "Ajustar localidad a";
		GuiMainEnable	= "Encender Enchantrix";
		GuiMainHelp	= "Contiene ajustes para Enchantrix \nun aditamento que muestra informaci\195\179n en la caja de ayuda con relaci\195\179n a los resultados de desencantar el art\195\173\194\173culo.";
		GuiOtherHeader	= "Otras Opciones";
		GuiOtherHelp	= "Opciones miscel\195\161neas de Enchantrix";
		GuiPrintin	= "Seleccione la ventana deseada";
		GuiRate	= "Ver cantidad promedio";
		GuiReloadui	= "Recargar Interf\195\161z";
		GuiReloaduiButton	= "Recargar";
		GuiReloaduiFeedback	= "Recargando el Interf\195\161z de WoW";
		GuiReloaduiHelp	= "Presione aqui para recargar el interf\195\161z de WoW luego de haber seleccionado una localidad diferente. Esto es para que el lenguaje de configuraci\195\179n sea el mismo que el de Auctioneer.\nNota: Esta operaci\195\179n puede tomar unos minutos.";
		GuiTerse	= "Permita el modo conciso";
		GuiValuateAverages	= "Valorizar con promedios de Auctioneer";
		GuiValuateBaseline	= "Valorizar con valores de referencia";
		GuiValuateEnable	= "Encender Valorizaci\195\179nes";
		GuiValuateHeader	= "Valorizaci\195\179nes";
		GuiValuateMedian	= "Valorizar con medianos de Auctioneer";
		HelpBarker	= "Vueltas Barker por intervalos";
		HelpClear	= "Eliminar la informacion existente sobre el art\195\173\194\173culo(se debe usar shift-click para insertar el/los articulo(s) en el comando) Tambien se pueden especificar las palabra clave \"todo\"";
		HelpCount	= "Selecciona para mostrar los valores exactos de la base de datos";
		HelpDefault	= "Revertir una opci\195\179n de Enchantrix a su configuraci\195\179n de f\195\161brica. Tambi\195\169n puede especificar la palabra clave \"todo\" pata revertir todas las opciones de Enchantrix a sus configuraciones de f\195\161brica.";
		HelpDisable	= "Impide que Enchantrix se carge automaticamente la proxima vez que usted entre al juego";
		HelpEmbed	= "Insertar el texto en la caja de ayuda original del juego (nota: Algunas capacidades se desabilitan cuando esta opci\195\179n es seleccionada)";
		HelpFindBidauct	= "Encontrar subastas donde el valor posible de los desencantamientos es una cierta cantidad de plata menos que el precio de oferta";
		HelpFindBuyauct	= "Encontrar subastas donde el valor posible de los desencantamientos es un cierto porciento menos que el precio de la opci\195\179n a compra";
		HelpGuessAuctioneerHsp	= "Si la valorizaci\195\179n esta seleccionada, y usted tiene Auctioneer instalado, mostrar la valorizaci\195\179n de los desencantamientos del art\195\173\194\173culo basandose en los precios m\195\161ximos de venta (PMV) de Auctioneer.";
		HelpGuessAuctioneerMedian	= "Si la valorizaci\195\179n esta seleccionada, y usted tiene Auctioneer instalado, mostrar la valorizaci\195\179n de los desencantamientos del art\195\173\194\173culo basandose en los precios medianos de Auctioneer.";
		HelpGuessBaseline	= "Si la valorizaci\195\179n esta seleccionada, (Auctioneer no es necesario) mostrar la valorizaci\195\179n de los desencantamientos del art\195\173\194\173culo, basandose en los valores de referencia incluidos.";
		HelpGuessNoauctioneer	= "Los comandos valorizar-pmv y valorizar-mediano no estan disponibles porque usted no tiene Auctioneer instalado";
		HelpHeader	= "Selecciona para mostrar la l\195\173\194\173nea del t\195\173\194\173tulo";
		HelpLoad	= "Cambiar las opciones de carga de Enchantrix para este personaje";
		HelpLocale	= "Cambiar la localidad que Enchantrix usa para sus mensajes";
		HelpOnoff	= "Enciende o apaga la informaci\195\179n de encantos";
		HelpPrintin	= "Selecciona cual ventana de mensajes va a usar Enchantrix para imprimir su informacion. Puede especificar el nombre o el \195\173\194\173ndice de la ventana.";
		HelpRate	= "Selecciona para mostrar las cantidades promedio de los desencantamientos";
		HelpTerse	= "Permitainhabilite el modo conciso, el demostrar desencanta solamente valor. Puede ser eliminado manteniendo la llave de control.";
		HelpValue	= "Selecciona para mostrar el precio estimado de los art\195\173\194\173culos basandose en la proporci\195\179n de los desencantamientos posibles";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "ofertaCorr";
		FrmtBidbrokerDone	= "Corredor de ofertas finalizado";
		FrmtBidbrokerHeader	= "Ofertas teniendo promedios de ahorros de %s plata en el valor de los desencantamientos:";
		FrmtBidbrokerLine	= "%s, Valorado en: %s, %s: %s, Ahorra: %s, Menos %s, Tiempo: %s";
		FrmtBidbrokerMinbid	= "ofertaMin";
		FrmtBidBrokerSkipped	= "Saltadas %d subastas por que estan por debajo de el margen de ganancias (%d%%)";
		FrmtPctlessDone	= "Porcentajes menores finalizado.";
		FrmtPctlessHeader	= "Opciones a compra teniendo %d%% de ahorro sobre el precio promedio de desencantar el art\195\173\194\173culo:";
		FrmtPctlessLine	= "%s, Valorado en: %s, OC: %s, Ahorra: %s, Menos %s";
		FrmtPctlessSkipped	= "Saltadas %d subastas por que estan por debajo de el margen de ganancias (%s)";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Precio de Barker (%d%% margen)";
		FrmtCounts	= "(referencia=%d, viejo=%d, nuevo=%d)";
		FrmtDisinto	= "Se convierte en:";
		FrmtFound	= "Se encontro que %s se convierte en:";
		FrmtPriceEach	= "(%s c/u)";
		FrmtSuggestedPrice	= "Precio Surgido";
		FrmtTotal	= "Total";
		FrmtValueAuctHsp	= "Valor de desencantamientos (PMV)";
		FrmtValueAuctMed	= "Valor de desencantamientos (Mediano)";
		FrmtValueMarket	= "Valor de desencantamientos (Referencia)";
		FrmtWarnAuctNotLoaded	= "[El programa Auctioneer no empez\195\179, se utilizar\195\161 la informaci\195\179n previamente almacenada]";
		FrmtWarnNoPrices	= "[No precios son disponible]";
		FrmtWarnPriceUnavail	= "[Algunos precios no son disponible]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "Factor del precio m\195\161s alto";
		BarkerOptionsHighestPriceForFactorTooltip	= "Encanta reciben una cuenta de cero para la prioridad del precio en o sobre este valor.";
		BarkerOptionsHighestProfitTitle	= "El beneficio m\195\161s alto";
		BarkerOptionsHighestProfitTooltip	= "El beneficio total m\195\161s alto del efectivo a hacer en un encantar.";
		BarkerOptionsLowestPriceTitle	= "El precio bajo";
		BarkerOptionsLowestPriceTooltip	= "El precio del contado m\195\161s bajo a cotizar para un encantar.";
		BarkerOptionsPricePriorityTitle	= "Prioridad total del precio";
		BarkerOptionsPricePriorityTooltip	= "Esto fija c\195\179mo la tasaci\195\179n importante est\195\161 a la prioridad total para anunciar.";
		BarkerOptionsPriceSweetspotTitle	= "Punto del dulce del factor del precio";
		BarkerOptionsPriceSweetspotTooltip	= "Esto se utiliza para dar la prioridad encanta cerca de este precio para anunciar.";
		BarkerOptionsProfitMarginTitle	= "Margen de beneficio";
		BarkerOptionsProfitMarginTooltip	= "El beneficio del porcentaje a agregar a la base mats coste.";
		BarkerOptionsRandomFactorTitle	= "Factor al azar";
		BarkerOptionsRandomFactorTooltip	= "La cantidad de aleatoriedad en encanta elegido para el grito comercial.";
		BarkerOptionsTab1Title	= "Beneficio y prioridades del precio";

	};

	frFR = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Enchantrix : La fen\195\170tre d'enchantement n'est pas ouverte. Elle doit l'\195\170tre pour utiliser le Trader.";
		BarkerNoEnchantsAvail	= "Enchantrix : Vous n'avez aucun enchantement ou vous ne disposez pas des ingr\195\169dients n\195\169cessaires pour les faire.";
		FrmtActClearall	= "Effacement de toutes les donn\195\169es d'enchantement";
		FrmtActClearFail	= "Impossible de trouver l'objet : %s";
		FrmtActClearOk	= "Information effac\195\169e pour l'objet : %s";
		FrmtActDefault	= "L'option %s d'Enchantrix a \195\169t\195\169 r\195\169initialis\195\169e \195\160 sa valeur par d\195\169faut";
		FrmtActDefaultAll	= "Toutes les options d'Enchantrix ont \195\169t\195\169 r\195\169initialis\195\169es \195\160\194\160 leurs valeurs par d\195\169faut.";
		FrmtActDisable	= "N'affiche pas les donn\195\169es de l'objet %s";
		FrmtActEnable	= "Affichage des donn\195\169es de l'objet %s";
		FrmtActEnabledOn	= "Affichage de l'objet %s sur %s";
		FrmtActSet	= "Fixe la valeur de %s \195\160 '%s'";
		FrmtActUnknown	= "Mot-cl\195\169 de commande inconnu : '%s'";
		FrmtActUnknownLocale	= "La langue que vous avez specifi\195\169e ('%s') est inconnue. Les langues valides sont :";
		FrmtPrintin	= "Les messages d'Enchantrix seront maintenant affich\195\169s dans la fen\195\170tre de dialogue \"%s\"";
		FrmtUsage	= "Syntaxe :";
		MesgDisable	= "D\195\169sactivation du chargement automatique d'Enchantrix";
		MesgNotloaded	= "Enchantrix n'est pas charg\195\169. Tapez /enchantrix pour plus d'informations.";


		-- Section: Command Options
		CmdClearAll	= "tout";
		OptClear	= "([Objet]|tout)";
		OptDefault	= "([option]|tout)";
		OptFindBidauct	= "<argent>";
		OptFindBuyauct	= "<pourcent>";
		OptLocale	= "<langue>";
		OptPrintin	= "(<fenetreIndex>[nombre]|<fenetreNom>[Chaine])";


		-- Section: Commands
		BarkerOff	= "Fonction Trader activ\195\169e";
		BarkerOn	= "Fonction Trader d\195\169sactiv\195\169e";
		CmdBarker	= "trader";
		CmdClear	= "effacer";
		CmdDefault	= "par d\195\169faut";
		CmdDisable	= "d\195\169sactiver";
		CmdFindBidauct	= "agent-enchere";
		CmdFindBidauctShort	= "ae";
		CmdFindBuyauct	= "sans-pourcentage";
		CmdFindBuyauctShort	= "pl";
		CmdHelp	= "aide";
		CmdLocale	= "langue";
		CmdOff	= "arret";
		CmdOn	= "marche";
		CmdPrintin	= "afficher-dans";
		CmdToggle	= "activer-desactiver";
		ShowCount	= "comptes";
		ShowEmbed	= "integrer";
		ShowGuessAuctioneerHsp	= "evaluer-pvm";
		ShowGuessAuctioneerMed	= "evaluer-median";
		ShowGuessBaseline	= "evaluer-reference";
		ShowHeader	= "en-tete";
		ShowRate	= "taux";
		ShowTerse	= "concis";
		ShowValue	= "evaluer";
		StatOff	= "Aucune donn\195\169e d'enchantement affich\195\169e";
		StatOn	= "Affichage des donn\195\169es d'enchantement format\195\169es";


		-- Section: Config Text
		GuiLoad	= "Charger Enchantrix";
		GuiLoad_Always	= "toujours";
		GuiLoad_Never	= "jamais";


		-- Section: Game Constants
		ArgSpellname	= "D\195\169senchanter";
		BarkerOpening	= "Vends enchantements :";
		Darnassus	= "Darnassus";
		Ironforge	= "Ironforge";
		OneLetterGold	= "po";
		OneLetterSilver	= "pa";
		Orgrimmar	= "Orgrimmar";
		PatReagents	= "Ingr\195\169dients: (.+)";
		ShortDarnassus	= "Darna";
		ShortIronForge	= "IF";
		ShortOrgrimmar	= "Orgri";
		ShortStormwind	= "SW";
		ShortThunderBluff	= "TB";
		ShortUndercity	= "UC";
		StormwindCity	= "Cit\195\169 de Stormwind";
		TextCombat	= "Combat";
		TextGeneral	= "G\195\169n\195\169ral";
		ThunderBluff	= "Thunder Bluff";
		Undercity	= "Undercity";


		-- Section: Generic Messages
		FrmtCredit	= "(visitez http://enchantrix.org/ pour partager vos donn\195\169es)";
		FrmtWelcome	= "Enchantrix v%s charg\195\169";
		MesgAuctVersion	= "Enchantrix n\195\169cessite Auctioneer version 3.4 ou plus. Quelques fonctions seront d\195\169sactiv\195\169es tant que vous ne mettrez pas \195\160 jour auctioneer.";


		-- Section: Help Text
		GuiBarker	= "Activer Trader";
		GuiClearall	= "R\195\169initialiser toutes les donn\195\169es d'Enchantrix";
		GuiClearallButton	= "Effacer tout";
		GuiClearallHelp	= "Cliquer ici pour r\195\169initialiser toutes les donn\195\169es d'Enchantrix pour le serveur-faction actuel.";
		GuiClearallNote	= "pour le serveur-faction actuel";
		GuiCount	= "Afficher le compte exact dans la base de donn\195\169es";
		GuiDefaultAll	= "R\195\169initialiser toutes les Options d'Enchantrix";
		GuiDefaultAllButton	= "Tout r\195\169initialiser";
		GuiDefaultAllHelp	= "Cliquer ici pour r\195\169initialiser toutes les options d'Enchantrix. ATTENTION: Cette op\195\169ration est irr\195\169versible.";
		GuiDefaultOption	= "R\195\169initialiser ce r\195\169glage";
		GuiEmbed	= "Int\195\169grer les infos dans les bulles d'aide originales";
		GuiLocale	= "Changer la langue pour";
		GuiMainEnable	= "Activer Enchantrix";
		GuiMainHelp	= "Contient les r\195\168glages d'Enchantrix, un AddOn qui affiche les informations li\195\169es au d\195\169senchantement des objets.";
		GuiOtherHeader	= "Autres Options";
		GuiOtherHelp	= "Options diverses d'Enchantrix";
		GuiPrintin	= "Choisir la fen\195\170tre de message souhait\195\169e";
		GuiRate	= "Afficher la quantit\195\169 moyenne de d\195\169senchantement";
		GuiReloadui	= "Recharger l'Interface Utilisateur";
		GuiReloaduiButton	= "RechargerIU";
		GuiReloaduiFeedback	= "Rechargement de l'IU de WoW";
		GuiReloaduiHelp	= "Cliquer ici pour recharger l'Interface Utilisateur (IU) de WoW apr\195\168s avoir chang\195\169 la langue afin de refl\195\169ter les changements dans cet \195\169cran de configuration. Remarque: Cette op\195\169ration peut prendre quelques minutes.";
		GuiTerse	= "Active le mode concis";
		GuiValuateAverages	= "Evaluer avec les moyennes d'Auctioneer";
		GuiValuateBaseline	= "Evaluer avec les donn\195\169es int\195\169gr\195\169es.";
		GuiValuateEnable	= "Activer Evaluation";
		GuiValuateHeader	= "Evaluation";
		GuiValuateMedian	= "Evaluer avec les moyennes d'Auctioneer";
		HelpBarker	= "Active ou d\195\169sactive le Trader";
		HelpClear	= "Efface les donn\195\169es de l'objet sp\195\169cifi\195\169 (vous devez maj-cliquer le ou les objets dans la ligne de commande) Vous pouvez \195\169galement sp\195\169cifier le mot-clef \"tout\"";
		HelpCount	= "Choisir d'afficher le compte exact dans la base de donn\195\169es.";
		HelpDefault	= "R\195\169initialise une option d'Enchantrix \195\160 sa valeur par d\195\169faut. Vous pouvez sp\195\169cifier le mot-clef \"tout\" pour r\195\169initialiser toutes les options d'Enchantrix.";
		HelpDisable	= "Emp\195\170che le chargement automatique d'Enchantrix lors de votre prochaine connexion.";
		HelpEmbed	= "Int\195\168gre le texte dans la bulle d'aide originale (Remarque: Certaines fonctionnalit\195\169s sont d\195\169sactiv\195\169es dans ce cas)";
		HelpFindBidauct	= "Trouver les ench\195\168res dont la valeur de d\195\169senchantement potentielle est inf\195\169rieure d'un certain montant en pi\195\168ces d'argent au prix d'ench\195\168re.";
		HelpFindBuyauct	= "Trouver les ench\195\168res dont la valeur de d\195\169senchantement potentielle est inf\195\168rieure d'un certain pourcentage au prix d'achat imm\195\169diat.";
		HelpGuessAuctioneerHsp	= "Si \195\169valuation est activ\195\169 et qu'Auctioneer est install\195\169, affiche l'estimation de plus haut prix de vente (HSP) de d\195\169senchantement de cet objet.";
		HelpGuessAuctioneerMedian	= "Si \195\169valuation est activ\195\169 et qu'Auctioneer est install\195\169, affiche l'\195\169valuation bas\195\169e sur la moyenne de d\195\169senchantement de l'objet.";
		HelpGuessBaseline	= "Si \195\169valuation est activ\195\169 (Auctioneer n'est pas n\195\169cessaire), affiche les informations de base de d\195\169senchantement, en s'appuyant sur la liste de prix int\195\169gr\195\169e.";
		HelpGuessNoauctioneer	= "Les commandes \"evaluer-hsp\" et \"evaluer-moyenne\" ne sont pas disponibles car vous n'avez pas Auctioneer d'install\195\169";
		HelpHeader	= "Choisir d'afficher la ligne d'en-t\195\170te";
		HelpLoad	= "Change les r\195\168glages de chargement pour ce personnage";
		HelpLocale	= "Change la langue utilis\195\169e pour afficher les messages d'Enchantrix";
		HelpOnoff	= "Active ou d\195\169sactive les informations d'enchantement";
		HelpPrintin	= "Choisir dans quelle fen\195\170tre Enchantrix affichera ses messages. Vous pouvez sp\195\169cifier le nom de la fen\195\170tre ou son index.";
		HelpRate	= "Choisir d'afficher la quantit\195\169 moyenne de d\195\169senchantement";
		HelpTerse	= "Active ou d\195\169sactive le mode concis, qui ne montre que les valeurs de d\195\169senchantement. Peut \195\170tre annul\195\169 en appuyant sur la touche contr\195\180le.";
		HelpValue	= "Choisir d'afficher les valeurs estim\195\169es bas\195\169es sur les proportions de d\195\169senchantement possible";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "EnchAct";
		FrmtBidbrokerDone	= "L'agent d'ench\195\168res a termin\195\169";
		FrmtBidbrokerHeader	= "Ench\195\168res pr\195\169sentant %s pi\195\168ces d'argent d'\195\169conomie sur la valeur moyenne de d\195\169senchantement (min. %d%% de moins) :";
		FrmtBidbrokerLine	= "%s, Estim\195\169 \195\160\194\160: %s, %s: %s, Economie: %s, Moins %s, Temps: %s";
		FrmtBidbrokerMinbid	= "EnchMin";
		FrmtBidBrokerSkipped	= "%d ench\195\168res ignor\195\169es pour marge trop faible (%d%%)";
		FrmtPctlessDone	= "Pourcentage inf\195\169rieur termin\195\169.";
		FrmtPctlessHeader	= "Achats imm\195\169diats %d%% \195\169conomisant plus que la valeur moyenne de d\195\169senchantement de l'objet (min. %s d'\195\169conomie) :";
		FrmtPctlessLine	= "%s, Estim\195\169 \195\160\194\160: %s, AI: %s, Economie: %s, Moins %s";
		FrmtPctlessSkipped	= "%d ench\195\168res ignor\195\169es pour marge trop faible (%s)";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Prix Trader (marge : %d%%)";
		FrmtCounts	= "(base=%d, ancienne=%d, nouvelle=%d)";
		FrmtDisinto	= "Se d\195\169senchante en :";
		FrmtFound	= "%s se d\195\169senchante en :";
		FrmtPriceEach	= "(%s l'unit\195\169)";
		FrmtSuggestedPrice	= "Prix sugg\195\169r\195\169:";
		FrmtTotal	= "Total";
		FrmtValueAuctHsp	= "Valeur d\195\169senchant\195\169e (HSP)";
		FrmtValueAuctMed	= "Valeur d\195\169senchant\195\169e (Moyenne)";
		FrmtValueMarket	= "Valeur d\195\169senchant\195\169e (R\195\169f\195\169rence)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer non charg\195\169, utilisation du prix en cache]";
		FrmtWarnNoPrices	= "[Aucun prix disponible]";
		FrmtWarnPriceUnavail	= "[Quelques prix indisponibles]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "Plus haut facteur prix";
		BarkerOptionsHighestPriceForFactorTooltip	= "Les enchantements ont un score de z\195\169ro pour les priorit\195\169s de prix \195\169gales ou sup\195\169rieures \195\160 cette valeur";
		BarkerOptionsHighestProfitTitle	= "B\195\169n\195\169fice le plus \195\169lev\195\169";
		BarkerOptionsHighestProfitTooltip	= "Le profit maximal par enchantement.";
		BarkerOptionsLowestPriceTitle	= "Plus bas Prix";
		BarkerOptionsLowestPriceTooltip	= "Le prix minimal \195\160 annoncer par enchantement.";
		BarkerOptionsPricePriorityTitle	= "Priorit\195\169 de prix g\195\169n\195\169rale";
		BarkerOptionsPricePriorityTooltip	= "Sp\195\169cifie l'importance du prix lors des annonces.";
		BarkerOptionsPriceSweetspotTitle	= "Sweetspot pour le facteur prix";
		BarkerOptionsPriceSweetspotTooltip	= "Ceci est utilis\195\169 pour donner la priorit\195\169 aux enchantements proches de ce prix pour la publicit\195\169";
		BarkerOptionsProfitMarginTitle	= "Marge b\195\169n\195\169ficiaire";
		BarkerOptionsProfitMarginTooltip	= "Le pourcentage de b\195\169n\195\169fice \195\160 ajouter au co\195\187t des mat\195\169riaux de base";
		BarkerOptionsRandomFactorTitle	= "Facteur al\195\169atoire";
		BarkerOptionsRandomFactorTooltip	= "La quantit\195\169 de hasard dans les enchantements choisis pour les cris de commerce";
		BarkerOptionsTab1Title	= "Priorit\195\169s de b\195\169n\195\169fice et de prix";

	};

	itIT = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Enchantrix: la finestra per gli enchantments non \195\168 aperta. La finestra degli enchantments deve essere aperta per usare il barker";
		BarkerNoEnchantsAvail	= "Enchantrix: non hai nessun enchantment o non hai ireagenti per poterlo fare";
		FrmtActClearall	= "Eliminando tutti i dati di enchant";
		FrmtActClearFail	= "Impossibile trovare l'oggetto: %s";
		FrmtActClearOk	= "Eliminati i dati dell'oggetto: %s";
		FrmtActDefault	= "L'opzione %s di Enchantrix e' stata resettata al valore di default";
		FrmtActDefaultAll	= "Tutte le opzioni di Enchantrix sono stae resettate al valore di default";
		FrmtActDisable	= "Non visualizza i dati dell'oggetto %s";
		FrmtActEnable	= "Visualizzando i dati dell'oggetto %s";
		FrmtActEnabledOn	= "Visualizzando i %s dell'oggetto in %s";
		FrmtActSet	= "Imposta %s a '%s'";
		FrmtActUnknown	= "Comando sconosciuto: '%s'";
		FrmtActUnknownLocale	= "La lingua specificata ('%s') e' sconosciuta. Le lingue valide sono:";
		FrmtPrintin	= "I messaggi di Enchantrix compariranno nella chat \"%s\"";
		FrmtUsage	= "Sintassi:";
		MesgDisable	= "Il caricamento automatico di Enchantrix \195\168 disabilitato";
		MesgNotloaded	= "Enchantrix non e' caricato. Digita /enchantrix per maggiori informazioni.";


		-- Section: Command Options
		CmdClearAll	= "tutto";
		OptClear	= "([item]|tutto)";
		OptDefault	= "(<opzione>|tutto)";
		OptFindBidauct	= "<denaro>";
		OptFindBuyauct	= "<percento>";
		OptLocale	= "<lingua>";
		OptPrintin	= "(<frameIndex>[Numero]|<frameName>[Stringa])";


		-- Section: Commands
		BarkerOff	= "Funzione Imbonitore disabilitata";
		BarkerOn	= "Funzione Imbonitore abilitata";
		CmdBarker	= "Imbonitore";
		CmdClear	= "cancella";
		CmdDefault	= "default";
		CmdDisable	= "disabilita";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "percentomeno";
		CmdFindBuyauctShort	= "pm";
		CmdHelp	= "aiuto";
		CmdLocale	= "lingua";
		CmdOff	= "fuori di";
		CmdOn	= "abilitato";
		CmdPrintin	= "stampa-in";
		CmdToggle	= "inverti";
		ShowCount	= "conteggio";
		ShowEmbed	= "integra";
		ShowGuessAuctioneerHsp	= "valuta-hsp";
		ShowGuessAuctioneerMed	= "valuta-mediana";
		ShowGuessBaseline	= "valuta-base";
		ShowHeader	= "intestazione";
		ShowRate	= "tassi";
		ShowTerse	= "conciso";
		ShowValue	= "valuta";
		StatOff	= "Visualizzazione dei dati di enchant disabilitata";
		StatOn	= "Visualizzazione dei dati di enchant configurati";


		-- Section: Config Text
		GuiLoad	= "Carica Enchantrix";
		GuiLoad_Always	= "sempre";
		GuiLoad_Never	= "mai";


		-- Section: Game Constants
		ArgSpellname	= "disincanta";
		BarkerOpening	= "Vendita:";
		Darnassus	= "Darnassus";
		Ironforge	= "Ironforge";
		OneLetterGold	= "g";
		OneLetterSilver	= "s";
		Orgrimmar	= "Orgrimmar";
		PatReagents	= "Reagente:(.+)";
		ShortDarnassus	= "Darn.";
		ShortIronForge	= "IF";
		ShortOrgrimmar	= "Org";
		ShortStormwind	= "SW";
		ShortThunderBluff	= "TB";
		ShortUndercity	= "UC";
		StormwindCity	= "Stormwind";
		TextCombat	= "Combattimento";
		TextGeneral	= "Generico";
		ThunderBluff	= "Thunder Bluff";
		Undercity	= "Undercity";


		-- Section: Generic Messages
		FrmtCredit	= "(vai su http://enchantrix.org/ per condividere i tuoi dati) ";
		FrmtWelcome	= "Enchantrix v%s caricato";
		MesgAuctVersion	= "Enchantrix richiede Auctioneer versione 3.4 o superiore. Alcune funzionalit\195\160 non saranno disponibili finch\195\169 Auctioneer non verr\195\160 aggiornato.";


		-- Section: Help Text
		GuiBarker	= "Abilita imbonitore";
		GuiClearall	= "Cancella tutti i dati di Enchantrix";
		GuiClearallButton	= "Cancella tutto";
		GuiClearallHelp	= "Clicca qui per eliminare tutti i dati di Enchantrix per il server/realm corrente";
		GuiClearallNote	= "per il corrente server/fazione";
		GuiCount	= "Mostra il conteggio esatto nel database";
		GuiDefaultAll	= "Ripristina tutte le opzioni di Enchantrix";
		GuiDefaultAllButton	= "Ripristina tutto";
		GuiDefaultAllHelp	= "Clicca qui per resettare tutte le opzioni di Enchantrix. ATTENZIONE: Questa azione non \195\168 reversibile.";
		GuiDefaultOption	= "Ripristina questa opzione";
		GuiEmbed	= "Aggiungi le informazioni al tooltip";
		GuiLocale	= "Imposta la lingua a";
		GuiMainEnable	= "Abilita Enchantrix";
		GuiMainHelp	= "Contiene le opzioni di Enchantrix, un AddOn che mostra nel tooltip informazioni relative al disenchant dell'oggetto selezionato";
		GuiOtherHeader	= "Altre opzioni";
		GuiOtherHelp	= "Opzioni aggiuntive di Enchantrix";
		GuiPrintin	= "Seleziona la finestra di chat desiderata";
		GuiRate	= "Mostra la quantit\195\160\194\160 media di disenchant";
		GuiReloadui	= "Ricarica l'interfaccia utente";
		GuiReloaduiButton	= "ReloadUI";
		GuiReloaduiFeedback	= "ReloadUI in corso";
		GuiReloaduiHelp	= "Dopo aver cambiato la lingua, cliccare qui per ricaricare l'interfaccia utente di WoW, e visualizzare cos\195\172 la lingua scelta. L'operazione pu\195\178 richiedere qualche minuto.";
		GuiTerse	= "Abilita modo conciso";
		GuiValuateAverages	= "Valuta con le medie di Auctioneer";
		GuiValuateBaseline	= "Valuta con i dati di base";
		GuiValuateEnable	= "Abilita la valutazione";
		GuiValuateHeader	= "Valutazione";
		GuiValuateMedian	= "Valuta con le mediane di Auctioneer";
		HelpBarker	= "Abilita / disabilita imbonitore";
		HelpClear	= "Cancella i dati sull'oggetto specificato (devi inserire l'oggetto nella linea di comando usando shift-click). Puoi anche specificare il comando speciale \"tutto\"";
		HelpCount	= "Scegli se visualizzare o meno i conteggi esatti nel database";
		HelpDefault	= "Imposta un'opzione di Enchantrix al suo valore di default. Puoi inoltre specificare la parola chiave \"tutto\" per impostare tutte le opzioni di Enchantrix ai loro valori di default.";
		HelpDisable	= "Impedisci che Enchantrix sia caricato automaticamente la prossima volta che entri nel gioco.";
		HelpEmbed	= "Integra il testo nel tooltip originale del gioco. (nota: alcune caratteristiche vengono disabilitate quando si seleziona questa opzione)";
		HelpFindBidauct	= "Trova gli oggetti con il valore possibile di disenchant  inferiore di un importo specificato all'offerta fatta in asta (bid)";
		HelpFindBuyauct	= "Trova glioggetti con il valore possibile di disenchant inferiore di una data percentuale all'offerta fatta in asta (bid)";
		HelpGuessAuctioneerHsp	= "Se la valutazione \195\131\194\168 attivata, e tu hai Auctioneer installato, mostra la valutazione massima del prezzo di vendita dell'oggetto disincantato.";
		HelpGuessAuctioneerMedian	= "Se la valutazione \195\168 attivata, e tu hai Auctioneer installato, mostra la valutazione mediana dell'oggetto disincantato.";
		HelpGuessBaseline	= "Se la valutazione \195\168 abilitata (Auctioneer non \195\168 necessario), visualizza il prezzo di base per il disenchant dell'oggetto (dai dati interni)";
		HelpGuessNoauctioneer	= "I comandi valuate-hsp e valuate-median non sono disponibili perch\195\168 non hai auctioneer installato.";
		HelpHeader	= "Seleziona per mostrare la linea del titolo";
		HelpLoad	= "Cambia le impostazioni di caricamento di Enchantrix per questo personaggio";
		HelpLocale	= "Cambia la lingua con la quale vuoi che Enchantrix comunichi";
		HelpOnoff	= "Abilita o disabilita le informazioni sull'incantesimo";
		HelpPrintin	= "Seleziona in quale finestra di chat verranno mandati i messaggi di Enchantrix. Puoi specificare il nome del frame oppure l'indice.";
		HelpRate	= "Seleziona se visualizzare o meno la quantit\195\160\194\160media di disenchant";
		HelpTerse	= "Abilita/disabilita il modo conciso, facendo vedre solo il valore disenchant. Pu\195\178 essere cambiato tenendo premuto il tasto control.";
		HelpValue	= "Seleziona per visualizzare il valore stimato dell'oggetto in base alla proporzione dei disincantamenti possibili";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "curBid";
		FrmtBidbrokerDone	= "Bid brokering terminato";
		FrmtBidbrokerHeader	= "Bid che hanno %s silver di meno del valore medio di disenchant:";
		FrmtBidbrokerLine	= "%s, Valutato: %s, %s: %s, Risparmia: %s, Meno %s, Tempo: %s";
		FrmtBidbrokerMinbid	= "minBid";
		FrmtBidBrokerSkipped	= "Saltate le aste %d a causa del superamento del limite del margine di profitto (%d%%)";
		FrmtPctlessDone	= "Percentomeno completato";
		FrmtPctlessHeader	= "Buyout che hanno un risparmio di %s sul prezzo medio di disincantamento: ";
		FrmtPctlessLine	= "%s, Valutato: %s, BO: %s, Risparmio: %s, Meno %s ";
		FrmtPctlessSkipped	= "Saltate le aste %d per un taglio del profitto (%s)";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Prezzo imbonitore (margine %d%%)";
		FrmtCounts	= "(base=%d, vecchio=%d, nuovo=%d) ";
		FrmtDisinto	= "Si disincanta in:";
		FrmtFound	= "%s si disincanta in: ";
		FrmtPriceEach	= "(%s ognuno)";
		FrmtSuggestedPrice	= "Prezzo suggerito";
		FrmtTotal	= "Totale";
		FrmtValueAuctHsp	= "Valore di disincantamento(HSP)";
		FrmtValueAuctMed	= "Valore di disincantamento(Medio)";
		FrmtValueMarket	= "Valore di disincantamento(Base)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer non caricato, usando i prezzi nascosti]";
		FrmtWarnNoPrices	= "[Prezzi non disponibili]";
		FrmtWarnPriceUnavail	= "[Alcuni prezzi non disponibili]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "Massimo prezzo di costo";
		BarkerOptionsHighestPriceForFactorTooltip	= "Con questo valore l'enchant riceve un punteggio di 0 per la priorit\195\160 di prezzo";
		BarkerOptionsHighestProfitTitle	= "Massimo profitto";
		BarkerOptionsHighestProfitTooltip	= "Massimo profitto totale su un enchant.";
		BarkerOptionsLowestPriceTitle	= "Prezzo pi\195\185 basso";
		BarkerOptionsLowestPriceTooltip	= "Il prezzo pi\195\185 basso da riportare per un Enchantment";
		BarkerOptionsPricePriorityTitle	= "Priorit\195\160 totale del prezzo";
		BarkerOptionsPricePriorityTooltip	= "Questo imposta l'importanza del prezzo sulla priorita' totale per l'annuncio.";
		BarkerOptionsPriceSweetspotTitle	= "SweetSpot del Fattore di Prezzo";
		BarkerOptionsPriceSweetspotTooltip	= "Questo si usa per dare priorit\195\160 agli enchant vicini a questo prezzo per la pubblicit\195\160.";
		BarkerOptionsProfitMarginTitle	= "Margine di profitto";
		BarkerOptionsProfitMarginTooltip	= "La percentuale di profitto da aggiungere al prezzo della materia prima.";
		BarkerOptionsRandomFactorTitle	= "Fattore casuale";
		BarkerOptionsRandomFactorTooltip	= "Il grado di casualit\195\160 nella scelta degli enchant da proporre in vendita.";
		BarkerOptionsTab1Title	= "Priorit\195\160 di profitto e prezzo";

	};

	koKR = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "Enchantrix: \235\167\136\235\160\165\235\182\128\236\151\172 \236\176\189\236\157\180 \236\151\180\235\160\164\236\158\136\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. Barker\235\165\188 \236\130\172\236\154\169\237\149\152\235\160\164\235\169\180 \235\167\136\235\160\165\235\182\128\236\151\172 \236\176\189\236\157\180 \236\151\180\235\160\164\236\158\136\236\150\180\236\149\188\235\167\140 \237\149\169\235\139\136\235\139\164.";
		BarkerNoEnchantsAvail	= "Enchantrix: \235\167\136\235\178\149\235\182\128\236\151\172 \236\158\172\235\163\140\234\176\128 \237\149\152\235\130\152\235\143\132 \236\151\134\234\177\176\235\130\152 \236\182\148\236\182\156\237\149\160 \236\158\172\235\163\140\234\176\128 \237\149\152\235\130\152\235\143\132 \236\151\134\236\138\181\235\139\136\235\139\164.";
		FrmtActClearall	= "\235\170\168\235\147\160 \235\167\136\235\178\149\235\182\128\236\151\172 \235\141\176\236\157\180\237\132\176\235\165\188 \236\130\173\236\160\156\237\149\169\235\139\136\235\139\164.";
		FrmtActClearFail	= "\236\149\132\236\157\180\237\133\156\236\157\132 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\157\140: %s";
		FrmtActClearOk	= "\236\149\132\236\157\180\237\133\156 \235\141\176\236\157\180\237\132\176 \236\130\173\236\160\156: %s ";
		FrmtActDefault	= "Enchantrix\236\157\152 %s \236\132\164\236\160\149\236\157\180 \236\180\136\234\184\176\237\153\148 \235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.";
		FrmtActDefaultAll	= "\235\170\168\235\147\160 Enchantrix \236\132\164\236\160\149\236\157\180 \236\180\136\234\184\176\237\153\148 \235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.";
		FrmtActDisable	= "\236\149\132\236\157\180\237\133\156\236\157\152 %s \235\141\176\236\157\180\237\132\176\235\165\188 \237\145\156\236\139\156\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.";
		FrmtActEnable	= "\236\149\132\236\157\180\237\133\156\236\157\152 %s \235\141\176\236\157\180\237\132\176\235\165\188 \237\145\156\236\139\156\237\149\169\235\139\136\235\139\164.";
		FrmtActEnabledOn	= "\236\149\132\236\157\180\237\133\156\236\157\152 %s \237\145\156\236\139\156(%s\236\151\144)";
		FrmtActSet	= "%s\235\165\188 '%s'|1\236\156\188\235\161\156;\235\161\156; \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164.";
		FrmtActUnknown	= "\236\149\140 \236\136\152 \236\151\134\235\138\148 \235\170\133\235\160\185\236\150\180: '%s'";
		FrmtActUnknownLocale	= "('%s') \236\157\128 \236\149\140 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\152\172\235\176\148\235\165\184 \236\167\128\236\151\173 \236\132\164\236\160\149\236\157\128 \235\139\164\236\157\140\234\179\188 \234\176\153\236\138\181\235\139\136\235\139\164.:";
		FrmtPrintin	= "Enchantrix\236\157\152 \235\169\148\236\132\184\236\167\128\235\138\148 \"%s\" \236\177\132\237\140\133\236\176\189\236\151\144 \236\182\156\235\160\165\235\144\169\235\139\136\235\139\164.";
		FrmtUsage	= "\236\130\172\236\154\169\235\178\149:";
		MesgDisable	= "Enchantrix\235\165\188 \236\158\144\235\143\153 \235\161\156\235\148\169\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.";
		MesgNotloaded	= "Enchantrix\234\176\128 \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164. /enchantrix \235\165\188 \236\158\133\235\160\165\237\149\152\236\139\156\235\169\180 \235\141\148 \235\167\142\236\157\128 \236\160\149\235\179\180\235\165\188 \235\179\180\236\139\164 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";


		-- Section: Command Options
		CmdClearAll	= "\235\170\168\235\145\144";
		OptClear	= "([\236\149\132\236\157\180\237\133\156]|\235\170\168\235\145\144)";
		OptDefault	= "(<\236\132\164\236\160\149>|\235\170\168\235\145\144)";
		OptFindBidauct	= "<\236\139\164\235\178\132>";
		OptFindBuyauct	= "<\237\141\188\236\132\188\237\138\184>";
		OptLocale	= "<\236\167\128\236\151\173>";
		OptPrintin	= "(<\236\176\189\235\178\136\237\152\184>[\235\178\136\237\152\184]|<\236\176\189\236\157\180\235\166\132>[\235\172\184\236\158\144\236\151\180])";


		-- Section: Commands
		BarkerOff	= "\236\149\140\235\166\188 \234\184\176\235\138\165 \236\130\172\236\154\169\236\149\136\237\149\168.";
		BarkerOn	= "\236\149\140\235\166\188 \234\184\176\235\138\165 \236\130\172\236\154\169.";
		CmdBarker	= "\236\149\140\235\166\188";
		CmdClear	= "\236\130\173\236\160\156";
		CmdDefault	= "\234\184\176\235\179\184\234\176\146";
		CmdDisable	= "\235\185\132\237\153\156\236\132\177\237\153\148";
		CmdFindBidauct	= "\236\158\133\236\176\176\236\164\145\234\176\156\236\157\184";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "\236\157\180\237\149\152\237\153\149\235\165\160";
		CmdFindBuyauctShort	= "pl ";
		CmdHelp	= "\235\143\132\236\155\128\235\167\144";
		CmdLocale	= "\236\167\128\236\151\173";
		CmdOff	= "\235\129\148";
		CmdOn	= "\236\188\172";
		CmdPrintin	= "\236\182\156\235\160\165\237\149\152\235\138\148\234\179\179";
		CmdToggle	= "\236\160\132\237\153\152";
		ShowCount	= "\236\136\152\235\159\137";
		ShowEmbed	= "\235\130\180\236\158\165";
		ShowGuessAuctioneerHsp	= "\237\143\137\234\176\128\235\144\156 HSP";
		ShowGuessAuctioneerMed	= "\237\143\137\234\176\128\235\144\156 \236\164\145\236\149\153\234\176\146";
		ShowGuessBaseline	= "\237\143\137\234\176\128\235\144\156 \234\184\176\235\179\184\234\176\146";
		ShowHeader	= "\235\168\184\235\166\172\235\167\144";
		ShowRate	= "\235\185\132\236\156\168";
		ShowTerse	= "\234\176\132\234\178\176";
		ShowValue	= "\237\143\137\234\176\128";
		StatOff	= "\236\150\180\235\150\164 \235\167\136\235\178\149\235\182\128\236\151\172\236\158\144\235\163\140\235\143\132 \237\145\156\236\139\156\237\149\152\236\167\128 \236\149\138\236\157\140";
		StatOn	= "\236\132\164\236\160\149\235\144\156 \235\167\136\235\178\149\235\182\128\236\151\172\236\158\144\235\163\140 \237\145\156\236\139\156";


		-- Section: Config Text
		GuiLoad	= "Enchantrix \235\161\156\235\147\156";
		GuiLoad_Always	= "\237\149\173\236\131\129";
		GuiLoad_Never	= "\236\130\172\236\154\169\236\149\136\237\149\168";


		-- Section: Game Constants
		ArgSpellname	= "\235\167\136\235\160\165\236\182\148\236\182\156";
		BarkerOpening	= "\237\140\144\235\167\164\235\138\148 \235\167\164\237\152\185\237\149\156\235\139\164:";
		Darnassus	= "\235\139\164\235\165\180\235\130\152\236\132\156\236\138\164";
		Ironforge	= "\236\149\132\236\157\180\236\150\184\237\143\172\236\167\128";
		OneLetterGold	= "\234\179\168\235\147\156";
		OneLetterSilver	= "\236\139\164\235\178\132";
		Orgrimmar	= "\236\152\164\234\183\184\235\166\172\235\167\136";
		PatReagents	= "\236\158\172\235\163\140: (.+)";
		ShortDarnassus	= "\235\139\164\235\165\180";
		ShortIronForge	= "\236\149\132\237\143\172";
		ShortOrgrimmar	= "\236\152\164\234\183\184";
		ShortStormwind	= "\236\138\164\237\134\176";
		ShortThunderBluff	= "\236\141\172\235\141\148";
		ShortUndercity	= "\236\150\184\235\141\148";
		StormwindCity	= "\236\138\164\237\134\176\236\156\136\235\147\156";
		TextCombat	= "\236\160\132\237\136\172";
		TextGeneral	= "\236\157\188\235\176\152";
		ThunderBluff	= "\236\141\172\235\141\148\235\184\148\235\159\172\237\148\132";
		Undercity	= "\236\150\184\235\141\148\236\139\156\237\139\176";


		-- Section: Generic Messages
		FrmtCredit	= "(\235\139\185\236\139\160\236\157\152 \235\141\176\236\157\180\237\132\176\235\165\188 \234\179\181\236\156\160\237\149\152\235\160\164\235\169\180 http://enchantrix.org/ \236\151\144 \235\176\169\235\172\184\237\149\152\236\139\173\236\139\156\236\152\164.)";
		FrmtWelcome	= "Enchantrix v%s \235\161\156\235\148\169\236\153\132\235\163\140";
		MesgAuctVersion	= "Enchantrix\235\138\148 Auctioneer \235\178\132\236\160\132 3.4 \236\157\180\236\131\129\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164. \236\151\172\235\159\172\235\182\132\236\157\180 \236\131\136\235\161\156\236\154\180 Auctioneer\235\165\188 \236\132\164\236\185\152\237\149\152\234\184\176\236\160\132\234\185\140\236\167\128 \235\170\135\234\176\128\236\167\128 \234\184\176\235\138\165\236\157\132 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.";


		-- Section: Help Text
		GuiBarker	= "\236\149\140\235\166\188 \236\130\172\236\154\169";
		GuiClearall	= "\235\170\168\235\147\160 Enchantrix \235\141\176\236\157\180\237\132\176 \236\130\173\236\160\156";
		GuiClearallButton	= "\235\170\168\235\145\144 \236\130\173\236\160\156";
		GuiClearallHelp	= "\237\129\180\235\166\173\237\149\152\235\169\180 \237\152\132\236\158\172 \236\132\156\235\178\132\236\157\152 Enchantrix \236\158\144\235\163\140\234\176\128 \235\170\168\235\145\144 \236\130\173\236\160\156\235\144\169\235\139\136\235\139\164.";
		GuiClearallNote	= "\237\152\132\236\158\172 \236\132\156\235\178\132-\236\167\132\236\152\129";
		GuiCount	= "\236\158\144\235\163\140\236\157\152 \236\160\149\237\153\149\237\149\156 \236\136\152\235\159\137 \235\179\180\234\184\176";
		GuiDefaultAll	= "\235\170\168\235\147\160 Enchantrix \236\152\181\236\133\152 \236\180\136\234\184\176\237\153\148";
		GuiDefaultAllButton	= "\235\170\168\235\145\144 \236\180\136\234\184\176\237\153\148";
		GuiDefaultAllHelp	= "\237\129\180\235\166\173\237\149\152\235\169\180 Enchantrix\236\157\152 \236\132\164\236\160\149\236\157\132 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \235\143\140\235\166\189\235\139\136\235\139\164. \234\178\189\234\179\160: \236\157\180 \236\158\145\236\151\133\236\157\128 \235\144\152\235\143\140\235\166\180 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.";
		GuiDefaultOption	= "\236\157\180 \236\132\164\236\160\149 \236\180\136\234\184\176\237\153\148";
		GuiEmbed	= "\236\160\149\235\179\180\235\165\188 \234\184\176\235\179\184 \237\136\180\237\140\129\236\151\144 \237\143\172\237\149\168";
		GuiLocale	= "\236\167\128\236\151\173\236\132\164\236\160\149";
		GuiMainEnable	= "Enchantrix \237\153\156\236\132\177\237\153\148";
		GuiMainHelp	= "\236\149\132\236\157\180\237\133\156\236\151\144 \235\140\128\237\149\156 \235\167\136\235\160\165\236\182\148\236\182\156\236\157\152 \234\178\176\234\179\188\236\153\128 \234\180\128\235\160\168\235\144\156 \236\160\149\235\179\180\235\165\188 \237\136\180\237\140\129\236\151\144 \237\145\156\236\139\156\237\149\180\236\163\188\235\138\148 \236\149\160\235\147\156\236\152\168\236\157\184 Enchantrix\236\151\144 \234\180\128\237\149\156 \236\132\164\236\160\149\236\157\132 \237\143\172\237\149\168\237\149\169\235\139\136\235\139\164.";
		GuiOtherHeader	= "\234\184\176\237\131\128 \236\132\164\236\160\149";
		GuiOtherHelp	= "\234\184\176\237\131\128 Enchantrix \236\132\164\236\160\149";
		GuiPrintin	= "\236\155\144\237\149\152\235\138\148 \235\169\148\236\139\156\236\167\128 \237\148\132\235\160\136\236\158\132\236\157\132 \236\132\160\237\131\157";
		GuiRate	= "\237\143\137\234\183\160\236\160\129\236\157\184 \235\167\136\235\160\165\236\182\148\236\182\156 \236\150\145 \235\179\180\234\184\176";
		GuiReloadui	= "UI \236\158\172\236\139\156\236\158\145";
		GuiReloaduiButton	= "UI \236\158\172\236\139\156\236\158\145";
		GuiReloaduiFeedback	= "WOW UI\235\165\188 \236\158\172\236\139\156\236\158\145\237\149\152\235\138\148 \236\164\145";
		GuiReloaduiHelp	= "\236\167\128\236\151\173\236\189\148\235\147\156\235\165\188 \235\179\128\234\178\189\237\155\132\236\151\144 WOW \236\130\172\236\154\169\236\158\144 \236\157\184\237\132\176\237\142\152\236\157\180\236\138\164\235\165\188 \235\179\128\234\178\189\237\149\152\235\160\164\235\169\180 \236\157\180\234\179\179\236\157\132 \237\129\180\235\166\173\237\149\180\236\132\156 \236\151\172\235\159\172\235\182\132\236\157\180 \236\132\160\237\131\157\237\149\156 \234\178\131\234\179\188 \236\132\164\236\160\149 \237\153\148\235\169\180\236\157\152 \236\150\184\236\150\180\234\176\128 \234\176\153\236\149\132\236\167\128\235\143\132\235\161\157 \237\149\152\236\139\173\236\139\156\236\152\164. \236\163\188\236\157\152: \236\157\180 \236\158\145\236\151\133\236\157\128 \235\170\135\235\182\132 \236\160\149\235\143\132 \234\177\184\235\166\180 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		GuiTerse	= "\234\176\132\234\178\176 \235\170\168\235\147\156 \236\130\172\236\154\169";
		GuiValuateAverages	= "Autcioneer \237\143\137\234\183\160\236\156\188\235\161\156 \237\143\137\234\176\128";
		GuiValuateBaseline	= "\235\130\180\236\158\165\235\144\156 \236\158\144\235\163\140\235\165\188 \236\157\180\236\154\169\237\149\180 \237\143\137\234\176\128";
		GuiValuateEnable	= "\237\143\137\234\176\128 \237\153\156\236\132\177\237\153\148";
		GuiValuateHeader	= "\237\143\137\234\176\128";
		GuiValuateMedian	= "Autctioneer \236\164\145\236\149\153\234\176\146\236\156\188\235\161\156 \237\143\137\234\176\128";
		HelpBarker	= "\236\149\140\235\166\188 \236\188\156\234\184\176\234\179\160 \235\129\132\234\184\176";
		HelpClear	= "\236\167\128\236\160\149\235\144\156 \236\149\132\236\157\180\237\133\156\236\157\152 \235\141\176\236\157\180\237\131\128\235\165\188 \236\130\173\236\160\156\237\149\169\235\139\136\235\139\164.(\236\157\180\235\149\140 \236\149\132\236\157\180\237\133\156\236\167\128\236\160\149\236\157\128 Shift-click \236\156\188\235\161\156 \235\170\133\235\160\185\236\150\180\236\176\189\236\151\144 \235\132\163\236\150\180\236\149\188\237\149\169\235\139\136\235\139\164.) \235\170\168\235\147\160 \236\149\132\236\157\180\237\133\156\235\141\176\236\157\180\237\131\128\235\165\188 \236\130\173\236\160\156\237\149\152\234\184\176 \236\156\132\237\149\180 \"\235\170\168\235\145\144\" \235\165\188 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpCount	= "\235\141\176\236\157\180\237\131\128\235\178\160\236\157\180\236\138\164\236\151\144 \236\158\136\235\138\148 \236\160\149\237\153\149\237\149\156 \236\136\152\235\159\137\236\157\132 \237\145\156\236\139\156\237\149\160\236\167\128 \236\132\160\237\131\157\237\149\169\235\139\136\235\139\164.";
		HelpDefault	= "Enchantrix\236\157\152 \236\152\181\236\133\152\236\157\132 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164. \235\170\168\235\147\160 Enchantrix \236\132\164\236\160\149\236\157\132 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \237\149\152\236\139\156\235\160\164\235\169\180 \"\235\170\168\235\145\144\" \235\165\188 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpDisable	= "\235\139\164\236\157\140 \235\161\156\234\183\184\236\157\184\236\139\156 \236\158\144\235\143\153\236\156\188\235\161\156 Enchantrix\235\165\188 \235\161\156\235\147\156\237\149\152\236\167\128 \236\149\138\236\157\140";
		HelpEmbed	= "\235\130\180\236\154\169\236\157\132 \234\184\176\235\179\184 \234\178\140\236\158\132 \237\136\180\237\140\129\236\151\144 \237\143\172\237\149\168(\236\157\180 \236\132\164\236\160\149\236\157\180 \236\132\160\237\131\157\235\144\152\235\169\180, \236\157\188\235\182\128 \234\184\176\235\138\165\236\157\132 \236\130\172\236\154\169\237\149\160\236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.)";
		HelpFindBidauct	= "\234\176\128\235\138\165\237\149\156 \235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169\236\157\180 \236\158\133\236\176\176\234\176\128 \235\179\180\235\139\164 \235\130\174\236\157\128 \234\178\189\235\167\164\237\146\136 \236\176\190\234\184\176";
		HelpFindBuyauct	= "\234\176\128\235\138\165\237\149\156 \235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169\236\157\180 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128\235\179\180\235\139\164 \235\130\174\236\157\128 \234\178\189\235\167\164\237\146\136 \236\176\190\234\184\176";
		HelpGuessAuctioneerHsp	= "\235\167\140\236\149\189 \237\143\137\234\176\128\234\176\128 \237\153\156\236\132\177\237\153\148 \235\144\152\236\151\136\236\156\188\235\169\180, \234\183\184\235\166\172\234\179\160 Auctioneer\234\176\128 \236\132\164\236\185\152\235\144\152\236\150\180 \236\158\136\236\156\188\235\169\180, \236\149\132\236\157\180\237\133\156\236\157\132 \235\167\136\235\160\165\236\182\148\236\182\156\236\139\156 \234\176\128\236\185\152\236\157\152 \236\181\156\234\179\160\237\140\144\235\167\164\234\176\128\235\138\165\234\176\128\234\178\169(HSP)\236\157\180 \237\145\156\236\139\156\235\144\169\235\139\136\235\139\164.";
		HelpGuessAuctioneerMedian	= "\235\167\140\236\149\189 \237\143\137\234\176\128\234\176\128 \237\153\156\236\132\177\237\153\148 \235\144\152\236\151\136\236\156\188\235\169\180, \234\183\184\235\166\172\234\179\160 Auctioneer\234\176\128 \236\132\164\236\185\152\235\144\152\236\150\180 \236\158\136\236\156\188\235\169\180, \236\149\132\236\157\180\237\133\156\236\157\132 \235\167\136\235\160\165\236\182\148\236\182\156\236\139\156 \234\176\128\236\185\152\236\157\152 \236\164\145\236\149\153\234\176\146\236\157\180 \237\145\156\236\139\156\235\144\169\235\139\136\235\139\164.";
		HelpGuessBaseline	= "\235\167\140\236\149\189 \237\143\137\234\176\128\234\176\128 \237\153\156\236\132\177\237\153\148 \235\144\152\236\151\136\236\156\188\235\169\180, (Autctionner\235\138\148 \237\149\132\236\154\148\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164) \236\149\132\236\157\180\237\133\156\236\157\132 \235\167\136\235\160\165\236\182\148\236\182\156\236\139\156 \234\176\128\236\185\152\236\157\152 \234\184\176\235\179\184\234\176\146\236\157\180 \237\145\156\236\139\156\235\144\169\235\139\136\235\139\164.";
		HelpGuessNoauctioneer	= "Auctioneer\234\176\128 \236\132\164\236\185\152\235\144\152\236\150\180 \236\158\136\236\167\128 \236\149\138\236\149\132\236\132\156 \237\143\137\234\176\128\235\144\156 HSP, \237\143\137\234\176\128\235\144\156 \236\164\145\236\149\153\234\176\146 \235\170\133\235\160\185\236\150\180\235\165\188 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.";
		HelpHeader	= "\235\168\184\235\166\172\235\167\144 \235\179\180\234\184\176 \236\151\172\235\182\128 \236\132\160\237\131\157";
		HelpLoad	= "\236\157\180 \236\188\128\235\166\173\237\132\176\236\157\152 Enchantrix \235\161\156\235\147\156 \236\132\164\236\160\149 \235\179\128\234\178\189";
		HelpLocale	= "Enchantrix\234\176\128 \235\169\148\236\139\156\236\167\128\235\165\188 \237\145\156\236\139\156\237\149\152\234\184\176\236\156\132\237\149\180 \236\130\172\236\154\169\237\149\152\235\138\148 \236\150\184\236\150\180 \235\179\128\234\178\189";
		HelpOnoff	= "Enchantrix\236\158\144\235\163\140 \237\145\156\236\139\156 \236\188\172/\235\129\148";
		HelpPrintin	= "Enchantrix\234\176\128 \235\169\148\236\139\156\236\167\128\235\165\188 \236\182\156\235\160\165\237\149\160 \237\148\132\235\160\136\236\158\132 \236\132\160\237\131\157. \237\148\132\235\160\136\236\158\132\236\157\152 \236\157\180\235\166\132\236\157\180\235\130\152, \235\178\136\237\152\184\235\165\188 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpRate	= "\237\143\137\234\183\160\236\160\129\236\157\184 \235\167\136\235\160\165\236\182\148\236\182\156 \236\150\145\236\157\152 \235\179\180\234\184\176 \236\151\172\235\182\128 \236\132\160\237\131\157";
		HelpTerse	= "\235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169\235\167\140 \235\179\180\236\157\180\235\143\132\235\161\157\237\149\152\235\138\148 \234\176\132\234\178\176 \235\170\168\235\147\156 \236\130\172\236\154\169/\236\130\172\236\154\169\236\149\136\237\149\168. \236\187\168\237\138\184\235\161\164 \237\130\164\235\165\188 \235\136\140\235\159\172\236\132\156 \234\178\185\236\179\144\236\147\184 \236\136\152 \236\158\136\236\157\140.";
		HelpValue	= "\234\176\128\235\138\165\237\149\156 \235\167\136\235\160\165\236\182\148\236\182\156 \235\185\132\236\156\168\236\151\144 \234\183\188\234\177\176\237\149\156 \236\149\132\236\157\180\237\133\156\236\157\152 \237\143\137\234\176\128\234\176\146 \235\179\180\234\184\176 \236\151\172\235\182\128 \236\132\160\237\131\157";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\237\152\132\236\158\172 \236\158\133\236\176\176";
		FrmtBidbrokerDone	= "\236\158\133\236\176\176 \236\164\145\234\176\156 \236\153\132\235\163\140";
		FrmtBidbrokerHeader	= "\236\158\133\236\176\176\236\157\180 \237\143\137\234\183\160 \235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169\236\151\144\236\132\156 %S \236\139\164\235\178\132 \236\160\136\236\149\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164:";
		FrmtBidbrokerLine	= "%s, \234\176\128\234\178\169: %s, %s: %s, \234\176\144\236\134\140: %s, %s \236\157\180\237\149\152, \236\139\156\234\176\132: %s";
		FrmtBidbrokerMinbid	= "\236\181\156\236\134\140 \236\158\133\236\176\176";
		FrmtBidBrokerSkipped	= "%d\234\176\156\236\157\152 \234\178\189\235\167\164\237\146\136\236\157\180 \235\167\136\236\167\132(%d%%)\236\157\132 \236\156\132\237\149\180 \234\177\180\235\132\136\235\155\176\236\150\180\236\167\144";
		FrmtPctlessDone	= "\236\153\132\235\163\140 \236\157\180\237\149\152 \237\153\149\235\165\160. ";
		FrmtPctlessHeader	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128\234\178\169\236\157\180 \237\143\137\234\183\160 \235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169\236\131\129\236\151\144\236\132\156 %d%% \236\160\136\236\149\189\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.:";
		FrmtPctlessLine	= "%s, \234\176\128\234\178\169: %s, BO: %s, \234\176\144\236\134\140: %s, %s \236\157\180\237\149\152";
		FrmtPctlessSkipped	= "%d\234\176\156\236\157\152 \234\178\189\235\167\164\237\146\136\236\157\180 \236\136\152\236\157\181\236\132\177(%s)\236\157\132 \236\156\132\237\149\180 \234\177\180\235\132\136\235\155\176\236\150\180\236\167\144";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "\234\176\128\234\178\169 \236\149\140\235\166\188 (%d%% \235\167\136\236\167\132)";
		FrmtCounts	= "(\234\184\176\236\164\128=%d, \234\179\188\234\177\176=%d, \236\139\160\234\183\156=%d)";
		FrmtDisinto	= "\235\167\136\235\160\165 \236\182\148\236\182\156:";
		FrmtFound	= "%s|1\236\157\180;\234\176\128; \235\167\136\235\160\165\236\182\148\236\182\156\235\144\152\235\138\148 \236\149\132\236\157\180\237\133\156: ";
		FrmtPriceEach	= "(%s \234\176\156)";
		FrmtSuggestedPrice	= "\236\160\156\236\149\136 \234\176\128\234\178\169:";
		FrmtTotal	= "\236\180\157";
		FrmtValueAuctHsp	= "\235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169 (HSP)";
		FrmtValueAuctMed	= "\235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169 (\236\164\145\236\149\153\234\176\146)";
		FrmtValueMarket	= "\235\167\136\235\160\165\236\182\148\236\182\156 \234\176\128\234\178\169 (\234\184\176\236\164\128\234\176\146)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer\234\176\128 \236\139\164\237\150\137\235\144\152\236\167\128 \236\149\138\236\149\132\236\132\156, \236\160\128\236\158\165\235\144\156 \234\176\128\234\178\169\236\157\132 \236\130\172\236\154\169]";
		FrmtWarnNoPrices	= "[\234\176\128\235\138\165\237\149\156 \234\176\128\234\178\169 \236\151\134\236\157\140]";
		FrmtWarnPriceUnavail	= "[\236\157\188\235\182\128 \234\176\128\234\178\169\236\157\132 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\151\134\236\157\140]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "\234\176\128\234\178\169\236\154\148\234\177\180 \236\181\156\234\179\160\234\176\128\234\178\169";
		BarkerOptionsHighestPriceForFactorTooltip	= "\235\167\136\235\178\149\235\182\128\236\151\172\234\176\128 \234\176\128\234\178\169 \236\154\176\236\132\160\236\136\156\236\156\132\236\151\144\236\132\156 0\236\160\144\236\157\132 \235\176\155\236\149\152\234\177\176\235\130\152 \236\157\180\236\160\144\236\136\152 \236\157\180\236\131\129\236\158\133\235\139\136\235\139\164.";
		BarkerOptionsHighestProfitTitle	= "\236\181\156\234\179\160 \236\157\180\236\157\181";
		BarkerOptionsHighestProfitTooltip	= "\235\167\136\235\178\149\235\182\128\236\151\172\235\165\188 \237\149\152\235\169\180 \236\181\156\234\179\160\234\176\128\235\161\156 \236\157\180\235\147\157\236\157\180 \235\144\169\235\139\136\235\139\164.";
		BarkerOptionsLowestPriceTitle	= "\236\181\156\236\160\128 \234\176\128\234\178\169";
		BarkerOptionsLowestPriceTooltip	= "\235\167\136\235\178\149\235\182\128\236\151\172\236\151\144 \235\140\128\237\149\156 \236\139\156\236\132\184\234\176\128 \236\181\156\236\160\128 \237\152\132\234\184\136 \234\176\128\234\178\169\236\156\188\235\161\156 \237\143\137\234\176\128\235\144\169\235\139\136\235\139\164.";
		BarkerOptionsPricePriorityTitle	= "\236\160\132\236\178\180 \234\176\128\234\178\169 \236\160\149\236\177\133";
		BarkerOptionsPricePriorityTooltip	= "\234\176\128\234\178\169 \236\164\145\236\154\148\235\143\132\234\176\128 \234\180\145\234\179\160\236\151\144 \235\140\128\237\149\156 \236\160\132\236\178\180 \236\154\176\236\132\160\236\136\156\236\156\132\236\151\144\236\132\156 \236\150\188\235\167\136\235\130\152 \235\144\160\236\167\128 \236\132\164\236\160\149\237\149\169\235\139\136\235\139\164. ";
		BarkerOptionsPriceSweetspotTitle	= "\234\176\128\234\178\169\236\154\148\234\177\180 \234\180\128\236\139\172\234\181\172\235\167\164\234\176\128\234\178\169";
		BarkerOptionsPriceSweetspotTooltip	= "\234\180\145\234\179\160\236\151\144 \235\140\128\237\149\180 \236\157\180\234\176\128\234\178\169\236\151\144 \234\176\128\234\185\140\236\154\180 \235\167\136\235\178\149\235\182\128\236\151\172 \236\154\176\236\132\160\236\136\156\236\156\132\235\165\188 \234\178\176\236\160\149\237\149\156\235\138\148\235\141\176 \236\130\172\236\154\169\235\144\169\235\139\136\235\139\164.";
		BarkerOptionsProfitMarginTitle	= "\236\157\180\236\156\164\237\143\173";
		BarkerOptionsProfitMarginTooltip	= "\234\184\176\235\179\184 \235\185\132\236\154\169\236\151\144 \236\182\148\234\176\128\237\149\152\234\184\176 \236\160\129\237\149\169\237\149\156 \235\185\132\236\156\168\236\158\133\235\139\136\235\139\164.";
		BarkerOptionsRandomFactorTitle	= "\235\172\180\236\158\145\236\156\132 \236\154\148\234\177\180";
		BarkerOptionsRandomFactorTooltip	= "\235\167\136\235\178\149\235\182\128\236\151\172\236\151\144\236\132\156 \235\172\180\236\158\145\236\156\132\235\161\156 \234\177\176\235\158\152 \236\153\184\236\185\168\236\157\132 \236\132\160\237\131\157\237\149\169\235\139\136\235\139\164.";
		BarkerOptionsTab1Title	= "\236\157\180\236\157\181\234\179\188 \234\176\128\234\178\169 \236\154\176\236\132\160\236\136\156\236\156\132";

	};

	zhCN = {


		-- Section: Command Messages
		BarkerEnxWindowNotOpen	= "\233\153\132\233\173\148\229\138\169\230\137\139\239\188\154\233\153\132\233\173\148\231\170\151\229\143\163\230\178\161\230\156\137\230\137\147\229\188\128\227\128\130\228\189\191\231\148\168barker\230\140\135\228\187\164\229\191\133\233\161\187\230\137\147\229\188\128\233\153\132\233\173\148\231\170\151\229\143\163";
		BarkerNoEnchantsAvail	= "\233\153\132\233\173\148\229\138\169\230\137\139\239\188\154\230\130\168\230\178\161\230\156\137\233\153\132\233\173\148\230\138\128\232\131\189\230\136\150\230\178\161\230\156\137\229\136\182\228\189\156\232\175\149\229\137\130";
		FrmtActClearall	= "\230\184\133\233\153\164\229\133\168\233\131\168\233\153\132\233\173\148\230\149\176\230\141\174\227\128\130";
		FrmtActClearFail	= "\230\151\160\230\179\149\230\137\190\229\136\176\231\137\169\229\147\129\239\188\154%s\227\128\130";
		FrmtActClearOk	= "\231\137\169\229\147\129\239\188\154%s\231\154\132\230\149\176\230\141\174\229\183\178\230\184\133\233\153\164\227\128\130";
		FrmtActDefault	= "\233\153\132\233\173\148\229\138\169\230\137\139\231\154\132\233\128\137\233\161\185\229\183\178\233\135\141\231\189\174\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130";
		FrmtActDefaultAll	= "\230\137\128\230\156\137\233\153\132\233\173\148\229\138\169\230\137\139\233\128\137\233\161\185\229\183\178\233\135\141\231\189\174\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130";
		FrmtActDisable	= "\228\184\141\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132%s\230\149\176\230\141\174\227\128\130";
		FrmtActEnable	= "\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132%s\230\149\176\230\141\174\227\128\130";
		FrmtActEnabledOn	= "\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132%s\228\186\142%s\227\128\130";
		FrmtActSet	= "\232\174\190\231\189\174%s\228\184\186'%s'\227\128\130";
		FrmtActUnknown	= "\230\156\170\231\159\165\229\145\189\228\187\164\229\133\179\233\148\174\229\173\151\239\188\154'%s'\227\128\130";
		FrmtActUnknownLocale	= "\228\189\160\232\190\147\229\133\165\231\154\132\229\156\176\229\159\159\228\187\163\231\160\129('%s')\230\156\170\231\159\165\227\128\130\230\156\137\230\149\136\231\154\132\229\156\176\229\159\159\228\187\163\231\160\129\228\184\186\239\188\154";
		FrmtPrintin	= "\233\153\132\233\173\148\229\138\169\230\137\139\228\191\161\230\129\175\231\142\176\229\156\168\229\176\134\230\152\190\231\164\186\229\156\168\"%s\"\229\175\185\232\175\157\230\161\134\227\128\130";
		FrmtUsage	= "\231\148\168\233\128\148\239\188\154";
		MesgDisable	= "\231\166\129\231\148\168\232\135\170\229\138\168\229\138\160\232\189\189\233\153\132\233\173\148\229\138\169\230\137\139\227\128\130";
		MesgNotloaded	= "\233\153\132\233\173\148\229\138\169\230\137\139\230\178\161\230\156\137\229\138\160\232\189\189\227\128\130\233\148\174\229\133\165/enchantrix\228\187\165\232\142\183\229\143\150\230\155\180\229\164\154\228\191\161\230\129\175\227\128\130";


		-- Section: Command Options
		CmdClearAll	= "all\229\133\168\233\131\168";
		OptClear	= "([\231\137\169\229\147\129]|all\229\133\168\233\131\168)";
		OptDefault	= "(<\233\128\137\233\161\185>|all\229\133\168\233\131\168)";
		OptFindBidauct	= "<\233\147\182\229\184\129>";
		OptFindBuyauct	= "<\230\175\148\231\142\135>";
		OptLocale	= "<\229\156\176\229\159\159\228\187\163\231\160\129>";
		OptPrintin	= "(<\231\170\151\229\143\163\230\160\135\231\173\190>[\230\149\176\229\173\151]|<\231\170\151\229\143\163\229\144\141\231\167\176>[\229\173\151\231\172\166\228\184\178])";


		-- Section: Commands
		BarkerOff	= "\229\129\156\231\148\168Barker\229\135\189\230\149\176";
		BarkerOn	= "\229\144\175\231\148\168Barker\229\135\189\230\149\176";
		CmdBarker	= "barker";
		CmdClear	= "clear\230\184\133\233\153\164";
		CmdDefault	= "default\233\187\152\232\174\164";
		CmdDisable	= "disable\231\166\129\231\148\168";
		CmdFindBidauct	= "bidbroker\229\135\186\228\187\183\228\187\163\231\144\134";
		CmdFindBidauctShort	= "bb(\229\135\186\228\187\183\228\187\163\231\144\134\231\154\132\231\188\169\229\134\153)";
		CmdFindBuyauct	= "percentless\230\175\148\231\142\135\229\183\174\233\162\157";
		CmdFindBuyauctShort	= "pl(\230\175\148\231\142\135\229\183\174\233\162\157\231\154\132\231\188\169\229\134\153)";
		CmdHelp	= "help\229\184\174\229\138\169";
		CmdLocale	= "locale\229\156\176\229\159\159\228\187\163\231\160\129";
		CmdOff	= "off\229\133\179";
		CmdOn	= "on\229\188\128";
		CmdPrintin	= "print-in\232\190\147\229\135\186\228\186\142";
		CmdToggle	= "toggle\229\188\128\229\133\179\232\189\172\230\141\162";
		ShowCount	= "counts\232\174\161\230\149\176";
		ShowEmbed	= "embed\229\181\140\229\133\165";
		ShowGuessAuctioneerHsp	= "valuate-hsp\228\188\176\228\187\183-\230\156\128\233\171\152";
		ShowGuessAuctioneerMed	= "valuate-median\228\188\176\228\187\183-\228\184\173\229\128\188";
		ShowGuessBaseline	= "valuate-baseline\228\188\176\228\187\183-\229\159\186\229\135\134";
		ShowHeader	= "header\230\160\135\233\162\152";
		ShowRate	= "rates\228\188\176\228\187\183";
		ShowTerse	= "terse\231\174\128\230\180\129";
		ShowValue	= "valuate\228\188\176\228\187\183";
		StatOff	= "Not displaying any enchant data\228\184\141\230\152\190\231\164\186\228\187\187\228\189\149\229\136\134\232\167\163\230\149\176\230\141\174";
		StatOn	= "Displaying configured enchant data\230\152\190\231\164\186\232\174\190\229\174\154\231\154\132\229\136\134\232\167\163\230\149\176\230\141\174";


		-- Section: Config Text
		GuiLoad	= "\229\138\160\232\189\189\233\153\132\233\173\148\229\138\169\230\137\139\227\128\130";
		GuiLoad_Always	= "\230\128\187\230\152\175";
		GuiLoad_Never	= "\228\187\142\228\184\141";


		-- Section: Game Constants
		ArgSpellname	= "\229\136\134\232\167\163";
		BarkerOpening	= "\229\135\186\229\148\174\233\153\132\233\173\148\239\188\154";
		Darnassus	= "\232\190\190\231\186\179\232\139\143\230\150\175";
		Ironforge	= "\233\147\129\231\130\137\229\160\161";
		OneLetterGold	= "G";
		OneLetterSilver	= "S";
		Orgrimmar	= "\229\165\165\230\160\188\231\145\158\231\142\155";
		PatReagents	= "\230\157\144\230\150\153\239\188\154(.+)";
		ShortDarnassus	= "Dar ";
		ShortIronForge	= "IF ";
		ShortOrgrimmar	= "Org ";
		ShortStormwind	= "SW ";
		ShortThunderBluff	= "TB ";
		ShortUndercity	= "UC ";
		StormwindCity	= "\230\154\180\233\163\142\229\159\142";
		TextCombat	= "\230\136\152\230\150\151";
		TextGeneral	= "\230\153\174\233\128\154";
		ThunderBluff	= "\233\155\183\233\156\134\229\180\150";
		Undercity	= "\229\185\189\230\154\151\229\159\142";


		-- Section: Generic Messages
		FrmtCredit	= "(\229\142\187http://enchantrix.org/\231\189\145\231\171\153\229\133\177\228\186\171\230\149\176\230\141\174)";
		FrmtWelcome	= "\233\153\132\233\173\148\229\138\169\230\137\139(Enchantrix) v%s \229\183\178\229\138\160\232\189\189\239\188\129";
		MesgAuctVersion	= "Enchantrix\233\156\128\232\166\129Auctioneer\231\137\136\230\156\1723.4\230\136\150\230\155\180\233\171\152\227\128\130\230\159\144\228\186\155\231\137\185\230\128\167\228\188\154\229\164\177\230\149\136\232\175\183\229\141\135\231\186\167\228\189\160\231\154\132Auctioneer";


		-- Section: Help Text
		GuiBarker	= "\229\133\129\232\174\184Barker";
		GuiClearall	= "\230\184\133\233\153\164\229\133\168\233\131\168\233\153\132\233\173\148\229\138\169\230\137\139\230\149\176\230\141\174\227\128\130";
		GuiClearallButton	= "\229\133\168\233\131\168\230\184\133\233\153\164";
		GuiClearallHelp	= "\231\130\185\230\173\164\230\184\133\233\153\164\229\175\185\228\186\142\229\189\147\229\137\141\230\156\141\229\138\161\229\153\168-\233\152\181\232\144\165\231\154\132\229\133\168\233\131\168\233\153\132\233\173\148\229\138\169\230\137\139\230\149\176\230\141\174\227\128\130";
		GuiClearallNote	= "\229\175\185\228\186\142\229\189\147\229\137\141\230\156\141\229\138\161\229\153\168-\233\152\181\232\144\165";
		GuiCount	= "\230\152\190\231\164\186\231\178\190\231\161\174\231\154\132\230\149\176\230\141\174\229\186\147\232\174\161\230\149\176\227\128\130";
		GuiDefaultAll	= "\233\135\141\231\189\174\229\133\168\233\131\168\233\153\132\233\173\148\229\138\169\230\137\139\232\174\190\231\189\174\227\128\130";
		GuiDefaultAllButton	= "\229\133\168\233\131\168\233\135\141\231\189\174";
		GuiDefaultAllHelp	= "\231\130\185\230\173\164\233\135\141\231\189\174\229\133\168\233\131\168\233\153\132\233\173\148\229\138\169\230\137\139\233\128\137\233\161\185\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130\232\173\166\229\145\138\239\188\154\230\173\164\230\147\141\228\189\156\230\151\160\230\179\149\232\191\152\229\142\159\227\128\130";
		GuiDefaultOption	= "\233\135\141\231\189\174\232\175\165\232\174\190\231\189\174";
		GuiEmbed	= "\228\191\161\230\129\175\230\152\190\231\164\186\229\156\168\230\184\184\230\136\143\233\187\152\232\174\164\230\143\144\231\164\186\228\184\173\227\128\130";
		GuiLocale	= "\232\174\190\231\189\174\229\156\176\229\159\159\228\187\163\231\160\129\228\184\186";
		GuiMainEnable	= "\229\144\175\231\148\168\233\153\132\233\173\148\229\138\169\230\137\139\227\128\130";
		GuiMainHelp	= "\229\140\133\229\144\171\230\143\146\228\187\182 - \233\153\132\233\173\148\229\138\169\230\137\139\231\154\132\232\174\190\231\189\174\227\128\130\229\174\131\231\148\168\228\186\142\230\152\190\231\164\186\231\137\169\229\147\129\229\136\134\232\167\163\228\186\167\231\137\169\228\191\161\230\129\175\227\128\130";
		GuiOtherHeader	= "\229\133\182\228\187\150\233\128\137\233\161\185";
		GuiOtherHelp	= "\233\153\132\233\173\148\229\138\169\230\137\139\230\157\130\233\161\185";
		GuiPrintin	= "\233\128\137\230\139\169\230\156\159\230\156\155\231\154\132\232\174\175\230\129\175\231\170\151\229\143\163\227\128\130";
		GuiRate	= "\230\152\190\231\164\186\229\136\134\232\167\163\229\185\179\229\157\135\230\149\176\233\135\143\227\128\130";
		GuiReloadui	= "\233\135\141\230\150\176\229\138\160\232\189\189\231\148\168\230\136\183\231\149\140\233\157\162\227\128\130";
		GuiReloaduiButton	= "\233\135\141\232\189\189UI";
		GuiReloaduiFeedback	= "\230\173\163\229\156\168\233\135\141\230\150\176\229\138\160\232\189\189\233\173\148\229\133\189\231\148\168\230\136\183\231\149\140\233\157\162\227\128\130";
		GuiReloaduiHelp	= "\229\156\168\230\148\185\229\143\152\229\156\176\229\159\159\228\187\163\231\160\129\229\144\142\231\130\185\230\173\164\233\135\141\230\150\176\229\138\160\232\189\189\233\173\148\229\133\189\231\148\168\230\136\183\231\149\140\233\157\162\228\189\191\230\173\164\233\133\141\231\189\174\229\177\143\229\185\149\228\184\173\231\154\132\232\175\173\232\168\128\229\140\185\233\133\141\233\128\137\230\139\169\227\128\130\230\179\168\230\132\143\239\188\154\230\173\164\230\147\141\228\189\156\229\143\175\232\131\189\232\128\151\230\151\182\229\135\160\229\136\134\233\146\159\227\128\130";
		GuiTerse	= "\229\188\128\229\144\175\231\174\128\230\180\129\230\168\161\229\188\143";
		GuiValuateAverages	= "\228\187\165\230\139\141\229\141\150\229\138\169\230\137\139\229\185\179\229\157\135\228\187\183\232\191\155\232\161\140\228\188\176\228\187\183\227\128\130";
		GuiValuateBaseline	= "\228\187\165\229\134\133\231\189\174\230\149\176\230\141\174\228\188\176\228\187\183\227\128\130";
		GuiValuateEnable	= "\229\144\175\231\148\168\228\188\176\228\187\183\227\128\130";
		GuiValuateHeader	= "\228\188\176\228\187\183";
		GuiValuateMedian	= "\228\187\165\230\139\141\229\141\150\229\138\169\230\137\139\228\184\173\229\128\188\228\187\183\232\191\155\232\161\140\228\188\176\228\187\183\227\128\130";
		HelpBarker	= "\229\136\135\230\141\162Barker\229\188\128\229\133\179";
		HelpClear	= "\230\184\133\233\153\164\230\140\135\229\174\154\231\137\169\229\147\129\231\154\132\230\149\176\230\141\174(\229\191\133\233\161\187Shift+\231\130\185\229\135\187\229\176\134\231\137\169\229\147\129\230\143\146\229\133\165\229\145\189\228\187\164)\227\128\130\228\189\160\228\185\159\229\143\175\228\187\165\230\140\135\229\174\154\231\137\185\229\174\154\229\133\179\233\148\174\229\173\151\"all\"\227\128\130";
		HelpCount	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\230\149\176\230\141\174\229\186\147\228\184\173\231\154\132\233\162\157\229\164\150\232\174\161\230\149\176\227\128\130";
		HelpDefault	= "\232\174\190\231\189\174\230\159\144\228\184\170\233\153\132\233\173\148\229\138\169\230\137\139\233\128\137\233\161\185\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130\228\189\160\228\185\159\229\143\175\228\187\165\232\190\147\229\133\165\231\137\185\229\174\154\229\133\179\233\148\174\229\173\151\"all\" \230\157\165\232\174\190\231\189\174\230\137\128\230\156\137\233\153\132\233\173\148\229\138\169\230\137\139\233\128\137\233\161\185\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130";
		HelpDisable	= "\233\152\187\230\173\162\233\153\132\233\173\148\229\138\169\230\137\139\228\184\139\228\184\128\230\172\161\231\153\187\229\189\149\230\151\182\232\135\170\229\138\168\229\138\160\232\189\189\227\128\130";
		HelpEmbed	= "\229\181\140\229\133\165\230\150\135\229\173\151\229\136\176\229\142\159\230\184\184\230\136\143\230\143\144\231\164\186\228\184\173(\230\143\144\231\164\186\239\188\154\230\159\144\228\186\155\231\137\185\230\128\167\229\156\168\232\175\165\230\168\161\229\188\143\228\184\139\231\166\129\231\148\168)\227\128\130";
		HelpFindBidauct	= "\230\137\190\229\136\176\230\139\141\229\141\150\229\147\129\229\133\182\229\143\175\232\131\189\229\136\134\232\167\163\228\187\183\229\128\188\228\189\142\228\186\142\231\171\158\230\139\141\228\187\183\228\184\128\229\174\154\233\147\182\229\184\129\233\162\157\227\128\130";
		HelpFindBuyauct	= "\230\137\190\229\136\176\230\139\141\229\141\150\229\147\129\229\133\182\229\143\175\232\131\189\229\136\134\232\167\163\228\187\183\229\128\188\228\189\142\228\186\142\228\184\128\229\143\163\228\187\183\228\184\128\229\174\154\230\175\148\231\142\135\227\128\130";
		HelpGuessAuctioneerHsp	= "\229\166\130\230\158\156\229\144\175\231\148\168\228\188\176\228\187\183\239\188\140\229\185\182\228\184\148\229\174\137\232\163\133\228\186\134\230\139\141\229\141\150\232\161\140\229\138\169\230\137\139(Auctioneer)\239\188\140\230\152\190\231\164\186\229\175\185\228\186\142\231\137\169\229\147\129\229\136\134\232\167\163\231\154\132\230\155\190\229\148\174\228\187\183\230\160\188(\230\156\128\233\171\152\228\187\183)\227\128\130";
		HelpGuessAuctioneerMedian	= "\229\166\130\230\158\156\229\144\175\231\148\168\228\188\176\228\187\183\239\188\140\229\185\182\228\184\148\229\174\137\232\163\133\228\186\134\230\139\141\229\141\150\229\138\169\230\137\139(Auctioneer)\239\188\140\230\152\190\231\164\186\229\159\186\228\186\142\231\137\169\229\147\129\229\136\134\232\167\163\228\188\176\228\187\183\231\154\132\228\184\173\229\128\188\227\128\130";
		HelpGuessBaseline	= "\229\166\130\230\158\156\229\144\175\231\148\168\228\188\176\228\187\183\239\188\140\230\152\190\231\164\186\229\175\185\228\186\142\231\137\169\229\147\129\229\136\134\232\167\163\231\154\132\229\159\186\229\135\134\228\188\176\228\187\183\239\188\140\229\159\186\228\186\142\231\179\187\231\187\159\229\134\133\231\189\174\228\187\183\230\160\188(\228\184\141\233\156\128\232\166\129\230\139\141\229\141\150\229\138\169\230\137\139Auctioneer)\227\128\130";
		HelpGuessNoauctioneer	= "\228\187\183\230\160\188\232\175\132\228\188\176\228\184\138\233\153\144\228\184\142\228\187\183\230\160\188\232\175\132\228\188\176\229\185\179\229\157\135\229\128\188\229\145\189\228\187\164\228\184\141\232\131\189\228\189\191\231\148\168\230\152\175\229\155\160\228\184\186\230\178\161\230\156\137\229\174\137\232\163\133\230\139\141\229\141\150\229\138\169\230\137\139\227\128\130";
		HelpHeader	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\230\160\135\233\162\152\231\186\191\227\128\130";
		HelpLoad	= "\230\148\185\229\143\152\233\153\132\233\173\148\229\138\169\230\137\139\231\154\132\229\138\160\232\189\189\232\174\190\231\189\174\227\128\130";
		HelpLocale	= "\230\155\180\230\148\185\233\153\132\233\173\148\229\138\169\230\137\139\230\152\190\231\164\186\232\174\175\230\129\175\231\154\132\229\156\176\229\159\159\228\187\163\231\160\129\227\128\130";
		HelpOnoff	= "\230\137\147\229\188\128/\229\133\179\233\151\173\233\153\132\233\173\148\230\149\176\230\141\174\231\154\132\230\152\190\231\164\186\227\128\130";
		HelpPrintin	= "\233\128\137\230\139\169\233\153\132\233\173\148\229\138\169\230\137\139\228\189\191\231\148\168\229\147\170\228\184\170\231\170\151\229\143\163\230\157\165\230\152\190\231\164\186\232\190\147\229\135\186\232\174\175\230\129\175\227\128\130\228\189\160\229\143\175\228\187\165\230\140\135\229\174\154\231\170\151\229\143\163\229\144\141\231\167\176\230\136\150\231\180\162\229\188\149\227\128\130";
		HelpRate	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\229\136\134\232\167\163\231\154\132\229\185\179\229\157\135\230\149\176\233\135\143\227\128\130";
		HelpTerse	= "\229\188\128\229\144\175/\229\133\179\233\151\173 \231\174\128\230\180\129\230\168\161\229\188\143\239\188\140\229\143\170\230\152\190\231\164\186\229\136\134\232\167\163\228\187\183\229\128\188\227\128\130\232\131\189\230\140\129\231\187\173\229\191\189\231\149\165\230\142\167\229\136\182\233\148\174\227\128\130";
		HelpValue	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\231\137\169\229\147\129\229\159\186\228\186\142\229\143\175\232\131\189\229\136\134\232\167\163\229\135\160\231\142\135\231\154\132\233\162\132\232\174\161\228\187\183\229\128\188\227\128\130";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\229\189\147\229\137\141\230\139\141\229\141\150\228\187\183";
		FrmtBidbrokerDone	= "\228\186\164\230\152\147\228\187\183\228\187\163\231\144\134\229\174\140\230\136\144";
		FrmtBidbrokerHeader	= "\230\139\141\228\184\139\232\175\165\231\137\169\229\147\129\229\176\134\232\138\130\231\156\129%s\233\147\182\229\184\129\239\188\140\229\185\179\229\157\135\229\136\134\232\167\163\228\187\183\229\128\188\239\188\154";
		FrmtBidbrokerLine	= "%s\239\188\140\228\188\176\228\187\183\239\188\154%s\239\188\140%s\239\188\154%s\239\188\140\232\138\130\231\156\129\239\188\154%s\239\188\140\229\183\174\233\162\157%s\239\188\140\230\172\161\230\149\176\239\188\154%s";
		FrmtBidbrokerMinbid	= "\230\156\128\228\189\142\229\135\186\228\187\183";
		FrmtBidBrokerSkipped	= "\229\183\178\232\183\179\232\191\135%d \230\139\141\229\141\150\233\161\185 \232\190\185\233\153\133\229\136\169\230\182\166 cutoff (%d%%)";
		FrmtPctlessDone	= "\230\175\148\231\142\135\229\183\174\233\162\157\229\174\140\230\136\144\227\128\130";
		FrmtPctlessHeader	= "\228\184\128\229\143\163\228\187\183\230\139\141\228\184\139\232\175\165\231\137\169\229\147\129\229\176\134\232\138\130\231\156\129%d%%\239\188\140\229\185\179\229\157\135\229\136\134\232\167\163\228\187\183\229\128\188\239\188\154";
		FrmtPctlessLine	= "%s\239\188\140\228\188\176\228\187\183\239\188\154%s\239\188\140\228\184\128\229\143\163\228\187\183\239\188\154%s\239\188\140\232\138\130\231\156\129\239\188\154%s\239\188\140\229\183\174\233\162\157%s";
		FrmtPctlessSkipped	= "\229\183\178\232\183\179\232\191\135%d\230\139\141\229\141\150\233\161\185 \229\136\169\230\182\166\231\142\135 cutoff (%s)";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Barker\228\187\183\230\160\188(%d%% \230\156\128\228\189\142\229\136\169\230\182\166)";
		FrmtCounts	= "(\229\159\186\230\156\172=%d\239\188\140\230\151\167\229\128\188=%d\239\188\140\230\150\176\229\128\188=%d)";
		FrmtDisinto	= "\229\143\175\229\136\134\232\167\163\228\184\186:";
		FrmtFound	= "\229\143\145\231\142\176%s\229\143\175\229\136\134\232\167\163\228\184\186\239\188\154";
		FrmtPriceEach	= "(\230\175\143\228\187\182%s)";
		FrmtSuggestedPrice	= "\229\187\186\232\174\174\228\187\183\230\160\188\239\188\154";
		FrmtTotal	= "\229\144\136\232\174\161";
		FrmtValueAuctHsp	= "\229\136\134\232\167\163\228\187\183\229\128\188(\230\156\128\233\171\152)";
		FrmtValueAuctMed	= "\229\136\134\232\167\163\228\187\183\229\128\188(\228\184\173\229\128\188)";
		FrmtValueMarket	= "\229\136\134\232\167\163\228\187\183\229\128\188(\229\159\186\229\135\134)";
		FrmtWarnAuctNotLoaded	= "[\230\139\141\229\141\150\229\138\169\230\137\139\230\156\170\229\138\160\232\189\189\239\188\140\228\189\191\231\148\168\231\188\147\229\134\178\228\187\183\230\160\188]";
		FrmtWarnNoPrices	= "[\230\151\160\228\187\183\229\143\175\231\148\168]";
		FrmtWarnPriceUnavail	= "[\230\159\144\228\186\155\228\187\183\230\160\188\228\184\141\229\143\175\231\148\168]";


		-- Section: User Interface
		BarkerOptionsHighestPriceForFactorTitle	= "\230\156\128\233\171\152\228\187\183\230\160\188\228\187\163\231\144\134";
		BarkerOptionsHighestPriceForFactorTooltip	= "\233\153\132\233\173\148\230\142\165\229\143\151\230\175\148\229\136\134\228\187\183\230\160\188\228\184\186\233\155\182\230\136\150\229\156\168\232\191\153\228\187\183\229\128\188\228\185\139\228\184\138\228\188\152\229\133\136\227\128\130";
		BarkerOptionsHighestProfitTitle	= "\230\156\128\229\164\167\230\148\182\231\155\138";
		BarkerOptionsHighestProfitTooltip	= "\233\153\132\233\173\148\232\142\183\229\190\151\230\156\128\233\171\152\231\154\132\230\128\187\230\148\182\231\155\138\233\135\145\227\128\130";
		BarkerOptionsLowestPriceTitle	= "\230\156\128\228\189\142\230\160\135\228\187\183";
		BarkerOptionsLowestPriceTooltip	= "\230\143\144\228\190\155\233\153\132\233\173\148\230\156\128\228\189\142\231\154\132\231\142\176\232\180\183\228\187\183\230\160\188\227\128\130";
		BarkerOptionsPricePriorityTitle	= "\230\128\187\228\187\183\230\160\188\228\188\152\229\133\136";
		BarkerOptionsPricePriorityTooltip	= "\232\191\153\232\174\190\231\189\174\230\128\142\228\185\136\233\135\141\232\166\129\229\174\154\228\187\183\230\152\175\229\136\176\230\149\180\228\189\147\228\188\152\229\133\136\230\157\131\228\184\186\229\129\154\229\185\191\229\145\138\227\128\130";
		BarkerOptionsPriceSweetspotTitle	= "\228\187\183\230\160\188\228\187\163\231\144\134\231\148\156\231\130\185";
		BarkerOptionsPriceSweetspotTooltip	= "\232\191\153\231\148\168\228\186\142\231\187\153\228\186\136\228\188\152\229\133\136\229\156\168\232\191\153\228\184\170\228\187\183\230\160\188\233\153\132\232\191\145\233\153\132\233\173\148\228\184\186\229\129\154\229\185\191\229\145\138\227\128\130";
		BarkerOptionsProfitMarginTitle	= "\232\190\185\231\188\152\230\148\182\231\155\138";
		BarkerOptionsProfitMarginTooltip	= "\229\162\158\229\138\160\232\181\162\229\136\169\231\153\190\229\136\134\230\175\148\229\136\176\229\159\186\230\156\172\232\190\185\233\153\133\230\148\182\231\155\138\232\180\185\231\148\168\227\128\130";
		BarkerOptionsRandomFactorTitle	= "\233\154\143\230\156\186\232\166\129\231\180\160";
		BarkerOptionsRandomFactorTooltip	= "\231\155\184\229\189\147\230\149\176\233\135\143\233\154\143\230\156\186\230\128\167\229\156\168\233\153\132\233\173\148\228\184\186\229\149\134\228\184\154\233\128\137\230\139\169\227\128\130";
		BarkerOptionsTab1Title	= "\230\148\182\231\155\138\228\184\142\228\187\183\230\160\188\228\188\152\229\133\136";

	};

	csCZ = {


		-- Section: Command Messages
		FrmtActClearall	= "Mazu vsechna Enchant data";
		FrmtActClearFail	= "Nelze najit predmet: %s";
		FrmtActClearOk	= "Smazana data k predmetu: %s";
		FrmtActDefault	= "Nastaveni Enchantrixu '%s' bylo vraceno na vychozi hodnotu.";
		FrmtActDefaultAll	= "Vsechna nastaveni Enchantrixu byla vracena na vychozi hodnoty.";
		FrmtActDisable	= "Nejsou zobrazovana data k predmetu %s";
		FrmtActEnable	= "Zobrazuji data k predmetu %s";
		FrmtActEnabledOn	= "Zobrazuji %s predmetu na %s";
		FrmtActSet	= "%s nastaveno na '%s'";
		FrmtActUnknown	= "Neznamy prikaz: '%s'";
		FrmtActUnknownLocale	= "Zvoleny jazyk ('%s') neni dostupny. Dostupne jsou: ";
		FrmtPrintin	= "Enchantrix bude zpravy zobrazovat v okne: \"%s\"";
		FrmtUsage	= "Pouzivani:";
		MesgDisable	= "Vypinam automaticke spusteni Enchantrix";
		MesgNotloaded	= "Enchantrix neni spusten. Napis /enchantrix a dozvis se vic.";


		-- Section: Command Options
		CmdClearAll	= "vse";
		OptClear	= "([Objekt]|vse)";
		OptDefault	= "(<nastaveni>|vse)";
		OptFindBidauct	= "<stribro>";
		OptFindBuyauct	= "<procent>";
		OptLocale	= "<jazyk>";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String])";


		-- Section: Commands
		CmdClear	= "smazat";
		CmdDefault	= "vychozi";
		CmdDisable	= "vypnout";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "procent-mene";
		CmdFindBuyauctShort	= "pm";
		CmdHelp	= "pomoc";
		CmdLocale	= "jazyk";
		CmdOff	= "vyp";
		CmdOn	= "zap";
		CmdPrintin	= "zobraz-v";
		CmdToggle	= "prepnout";
		ShowCount	= "pocet";
		ShowEmbed	= "integrace";
		ShowGuessAuctioneerHsp	= "urcit-nuc";
		ShowGuessAuctioneerMed	= "urcit-stred";
		ShowGuessBaseline	= "urcit-zaklad";
		ShowHeader	= "nadpis";
		ShowRate	= "sazby";
		ShowValue	= "ohodnotit";
		StatOff	= "Nejsou zobrazovana zadna Enchant data";
		StatOn	= "Jsou zobrazovana zvolena enchant data";


		-- Section: Config Text
		GuiLoad	= "Spustit Enchantrix";
		GuiLoad_Always	= "vzdy";
		GuiLoad_Never	= "nikdy";


		-- Section: Game Constants
		ArgSpellname	= "Rozcarovani";
		PatReagents	= "regenty: (.+)";
		TextCombat	= "Boj";
		TextGeneral	= "Obecne";


		-- Section: Generic Messages
		FrmtCredit	= "(navstiv http://enchantrix.org/ a podel se o sva data)";
		FrmtWelcome	= "Enchantrix v%s spusten";


		-- Section: Help Text
		GuiClearall	= "Smazat vsechna Enchantrix data";
		GuiClearallButton	= "Smazat vse";
		GuiClearallHelp	= "Klikni zde pro smazani vsech Enchantrix zaznamu pro tento server";
		GuiClearallNote	= "pro tento server";
		GuiCount	= "Zobraz presne pocty v databazi";
		GuiDefaultAll	= "Obnov vsechna vychozi Enchantrix nastaveni";
		GuiDefaultAllButton	= "Restartovat vse";
		GuiDefaultAllHelp	= "Klikni zde pro obnoveni vsech Enchantrix nastaveni na vychozi hodnoty. POZOR: Vlastni nastaveni budou ztracena";
		GuiDefaultOption	= "Obnov vychozi";
		GuiEmbed	= "Popis integrovan do in-game popisku";
		GuiLocale	= "Zvol jazyk";
		GuiMainEnable	= "Aktivovat Enchantrix";
		GuiMainHelp	= "Obsahuje nastaveni Enchantrixu, AddOnu ktery v popiskach udava informace ohledne odcarovani predmetu";
		GuiOtherHeader	= "Dalsi moznosti";
		GuiOtherHelp	= "Ruzne Enchantrix moznosti";
		GuiPrintin	= "Vyber si textove okno";
		GuiRate	= "Zobrazit prumerne mnozstvi odkouzleni";
		GuiReloadui	= "Znovu nahraj interface";
		GuiReloaduiButton	= "NahrajUI";
		GuiReloaduiFeedback	= "Nahravam WoW interface";
		GuiReloaduiHelp	= "Klikni zde pro nove nahrani interface. Bude take nahran zvoleny jazyk. Pozor: Toto muze trvat nekolik minut.";
		GuiValuateAverages	= "Ohodnot pomoci Auctioneer prumeru";
		GuiValuateBaseline	= "Ohodnot pomoci vlastnich dat";
		GuiValuateEnable	= "Zapnout ohodnoceni";
		GuiValuateHeader	= "Ohodnoceni";
		GuiValuateMedian	= "Ohodnotit pomoci Auctioneer strednich cen";
		HelpClear	= "Smazat data k urcenemu objektu (shift - klikem ho vlozite do prikazu, nebo pouzijte urceni \"vse\" nebo \"all\")";
		HelpCount	= "Nastavi zda se ma zobrazovat pocet zaznamu v databazi";
		HelpDefault	= "Vrati urcene Enchantrix nastaveni na vychozi. Take lze pouzit urceni \"vse\" nebo \"all\" pro navrat vsech nastaveni na vychozi.";
		HelpDisable	= "- Deaktivuje automaticke zapinani Enchantrixu pri vstupu do hry";
		HelpEmbed	= "Integruje Enchantrix popisy do puvodnich hernich popisek objektu (pozor: nektere funkce nejsou v tomto rezimu dostupne)";
		HelpFindBidauct	= "Najde aukce u nichz je cena mozneho produktu odcarovanio urcenou sumu stribra nizsi nez momentalni naBIDka";
		HelpFindBuyauct	= "Najde aukce u nichz je cena mozneho produktu odcarovani o urcenou sumu stribra nizsi nez Vykupni cena";
		HelpGuessAuctioneerHsp	= "Je-li Ohodnocovani zapnuto a je-li instalovan Auctioneer - zobrazi Ohodnoceni pomoci Nejvyssi Uspesne Ceny (NUC)  za odcarovani predmetu. ";
		HelpGuessAuctioneerMedian	= "Je-li Ohodnocovani zapnuto a je-li instalovan Auctioneer - zobrazi Ohodnoceni podle Stredni Ceny za odcarovani predmetu.";
		HelpGuessBaseline	= "Je-li Ohodnocovani zapnuto - zobrazi jednoduche Ohodnoceni podle jistych cen za odcarovani predmetu.";
		HelpGuessNoauctioneer	= "Ohodnoceni-NUC a Ohodnoceni-StrednichCen nejsou mozna protoze nemate instalovany Auctioneer. ";
		HelpHeader	= "Nastavi zda se ma zobrazovat nadpis";
		HelpLoad	= "Nastavi spousteni Enchantrix pro tuto postavu";
		HelpLocale	= "Nastavi jazyk Enchantrix zprav";
		HelpOnoff	= "Nastavi zda se maji zobrazovat informace o ocarovani predmetu";
		HelpPrintin	= "Nastavi v kterem okne ma Enchantrix zobrazovat zpravy. Muzete zvolit nazev okna nebo jeho index.";
		HelpRate	= "Nastavi zda se ma zobrazovat prumerne mnozstvi odcarovaneho materialu";
		HelpValue	= "Nastavi zda se ma zobrazovat odhadovana cena predmetu na zaklade jeho moznych odcarovani";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "soucBid";
		FrmtBidbrokerDone	= "Prihazovani dokonceno";
		FrmtBidbrokerHeader	= "Nabidky usetri %s stribra na prumerne hodnote odcarovani:";
		FrmtBidbrokerLine	= "%s, Hodnota na: %s, %s: %s, Usetrit: %s, Mene %s, Cas: %s";
		FrmtBidbrokerMinbid	= "minBid";
		FrmtPctlessDone	= "Procentuelni snizeni hotovo.";
		FrmtPctlessHeader	= "Vykupy usetri %d%% oproti prumerne hodnote odcarovani:";
		FrmtPctlessLine	= "%s, Hodnota na: %s, Vykup: %s, Usetrit: %s, Mene %s";


		-- Section: Tooltip Messages
		FrmtCounts	= "(zaklad=%d, stare=%d, nove=%d)";
		FrmtDisinto	= "Odcarovatelne na: ";
		FrmtFound	= "Zjisteno ze %s je odcarovatelne na:";
		FrmtPriceEach	= "(%s ks)";
		FrmtSuggestedPrice	= "Navrhnuta cena:";
		FrmtTotal	= "Celkem";
		FrmtValueAuctHsp	= "Hodnota Odkouzleni (NUC)";
		FrmtValueAuctMed	= "Hodnota Odkouzleni (StredniCena)";
		FrmtValueMarket	= "Hodnota Odkouzleni (ZakladniCena)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer nenaloadovan, pouzivam cached ceny]";
		FrmtWarnNoPrices	= "[Ceny nejsou dostupne]";
		FrmtWarnPriceUnavail	= "[Nektere ceny nedostupne]";

	};

	daDK = {


		-- Section: Command Messages
		FrmtActClearall	= "Nulstiller al Enchant data";
		FrmtActClearFail	= "Kan ikke finde item: %s";
		FrmtActClearOk	= "Data nulstillet for item: %s";
		FrmtActDefault	= "Enchantrix's %s indstilling er blevet nulstillet";
		FrmtActDefaultAll	= "Alle Enchantrix indstillinger er blevet gensat til normal";
		FrmtActDisable	= "Viser ikke item's %s data";
		FrmtActEnable	= "Viser item's %s data";
		FrmtActEnabledOn	= "Viser item's %s p\195\165 %s";
		FrmtActSet	= "S\195\166t %s til '%s'";
		FrmtActUnknown	= "Ukendt kommando n\195\184gleord: '%s'";
		FrmtActUnknownLocale	= "Sproget du har valgt ('%s') er ukendt. Tilladte sprog er:";
		FrmtPrintin	= "Encantrix's beskeder vil nu vises i \"%s\" chat rammen";
		FrmtUsage	= "Brug:";
		MesgDisable	= "Sl\195\165r automatisk loading af Enchantrix fra";
		MesgNotloaded	= "Enchantrix er ikke indl\195\166st. Skriv /enchantrix for mere information";


		-- Section: Command Options
		CmdClearAll	= "alt";
		OptClear	= "([Item]alt)";
		OptDefault	= "(<option>|alt)";
		OptFindBidauct	= "<s\195\184lv>";
		OptFindBuyauct	= "<procent>";
		OptLocale	= "<sprog>";
		OptPrintin	= "(<index>[Nummer]<rammenavn>[Streng])";


		-- Section: Commands
		BarkerOff	= "Funzione Imbonitore disabilitata.";
		BarkerOn	= "Funzione Imbonitore abilitata.";
		CmdBarker	= "Imbonitore";
		CmdClear	= "slet";
		CmdDefault	= "standard";
		CmdDisable	= "deaktiver";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "procentunder";
		CmdFindBuyauctShort	= "pu";
		CmdHelp	= "hj\195\166lp";
		CmdLocale	= "sprog";
		CmdOff	= "fra";
		CmdOn	= "til";
		CmdPrintin	= "skriv-i";
		CmdToggle	= "skift";
		ShowCount	= "opt\195\166lling";
		ShowEmbed	= "integreret";
		ShowGuessAuctioneerHsp	= "evaluer-hsp";
		ShowGuessAuctioneerMed	= "evaluer-middel";
		ShowGuessBaseline	= "evaluer-basev\195\166rdi";
		ShowHeader	= "Overskrift";
		ShowRate	= "Ratio";
		ShowTerse	= "conciso";
		ShowValue	= "Evaluer";
		StatOff	= "Viser ingen enchant data";
		StatOn	= "Viser konfigureret enchant data";


		-- Section: Config Text
		GuiLoad	= "Load Auctioneer";
		GuiLoad_Always	= "altid";
		GuiLoad_Never	= "aldrig";


		-- Section: Game Constants
		ArgSpellname	= "Disenchant";
		PatReagents	= "Ingredienser: (.+)";
		TextCombat	= "Kamp";
		TextGeneral	= "Generelt";


		-- Section: Generic Messages
		FrmtCredit	= "G\195\165 til http://enchantrix.org/ for at dele dine data";
		FrmtWelcome	= "Enchantrix v%s l\195\166st ind";
		MesgAuctVersion	= "Enchantix kr\195\166ver Auctioneer version 3.4 eller h\195\184jere. Nogle muligheder vil v\195\166re utilg\195\166ngelige indtil du opdatere din Auctioneer installation.";


		-- Section: Help Text
		GuiBarker	= "Aktiver Udr\195\165ber";
		GuiClearall	= "Slet alle Enchantrix data";
		GuiClearallButton	= "Slet alt";
		GuiClearallHelp	= "Klik her for at slette alle Enchantrix data for den aktuelle server.";
		GuiClearallNote	= "for den aktuelle server/faktion";
		GuiCount	= "Vis de pr\195\166cise tal fra databasen";
		GuiDefaultAll	= "Nulstil alle Enchantrix valg";
		GuiDefaultAllButton	= "Nulstil alt";
		GuiDefaultAllHelp	= "Klik her for at s\195\166tte alle Enchantrix options til deres standard v\195\166rdi. ADVARSEL. Dette kan IKKE fortrydes.";
		GuiDefaultOption	= "Nulstil denne v\195\166rdi";
		GuiEmbed	= "Vis indlejrede information i spillets tooltip";
		GuiLocale	= "S\195\166t sprog til";
		GuiMainEnable	= "Aktiver Enchantrix";
		GuiMainHelp	= "Indeholder v\195\166rdier for Enchantrix et Add-On som viser information om hvad en ting bliver til ved disenchant.";
		GuiOtherHeader	= "Andre valg";
		GuiOtherHelp	= "Diverse Enchantrix valg";
		GuiPrintin	= "V\195\166lg den \195\184nskede meddelelses frame";
		GuiRate	= "Vis det gennemsnitlige antal af disenchant";
		GuiReloadui	= "Genindl\195\166s bruger interface";
		GuiReloaduiButton	= "Genindl\195\166sUI";
		GuiReloaduiFeedback	= "Genindl\195\166ser WoW UI";
		GuiReloaduiHelp	= "Klik her for at genindl\195\166se WoW bruger interfacet efter at have \195\166ndret localet, s\195\165 sproget i konfigurations sk\195\166rmen passer med det som du har valgt. Bem\195\166rk: Dette kan tage nogle minutter.";
		GuiTerse	= "Aktiver kortfattet indstilling";
		GuiValuateAverages	= "Evaluer mod Auctioneer gennemsnit";
		GuiValuateBaseline	= "Evaluer mod standard data";
		GuiValuateEnable	= "Aktiver Evaluering";
		GuiValuateHeader	= "Evaluering";
		GuiValuateMedian	= "Evaluer mod Auctioneer middel";
		HelpBarker	= "Sl\195\165r udr\195\165ber til og fra";
		HelpClear	= "Slet det valgte item data (du skal shift-klikke item ind i kommandoen). Du kan ogs\195\131\194\165 angive all for at slette alt.";
		HelpCount	= "V\195\166lg om der skal vises n\195\184jagtige tal fra databasen.";
		HelpDefault	= "S\195\166t et Enchantrix valg til dets standard v\195\131\194\166rdi. Du kan ogs\195\165 angive all for at s\195\166tte alle valg til deres standard v\195\166rdi.";
		HelpDisable	= "Undlader at loade Enchantrix automatisk n\195\166ste gang du logger ind.";
		HelpEmbed	= "Indlejrer teksten i spillets egne tooltip (Bem\195\131\194\166rk: Visse valg kan ikke bruges sammen med dette)";
		HelpFindBidauct	= "Find auktioner hvis potentielle disenchant v\195\166rdi er et vist s\195\184lvbel\195\184b mindre end bud prisen.";
		HelpFindBuyauct	= "Find auktioner hvis potentielle disenchant v\195\166rdi er vis procent v\195\166rdi mindre end bud prisen.";
		HelpGuessAuctioneerHsp	= "Hvis Evaluer er sl\195\165et til og du har Auctioneer installeret, vis salgspris (HSP) vurderingen af at disenchante tingen.";
		HelpGuessAuctioneerMedian	= "Hvis Evaluer er sl\195\165et til og du har Auctioneer installeret, vis middel v\195\166rdien af at disenchante tingen.";
		HelpGuessBaseline	= "Hvis Evaluer er sl\195\165et til (Auctioneer er ikke n\195\184dvendig) vis base v\195\166rdien af at disenchante ting. Baseret p\195\165 de indbyggede priser.";
		HelpGuessNoauctioneer	= "Kommandoerne evaluer-hsp og evaluer-middel er ikke tilg\195\166ngelige fordi du ikke har Auctioneer installeret.";
		HelpHeader	= "V\195\166lg om overskriften skal vises";
		HelpLoad	= "\195\134ndre Enchantrix load indstillinger for denne karakter";
		HelpLocale	= "\195\134ndrer sproget som bruges til at vises Enchantrix meddelelser";
		HelpOnoff	= "Skifter mellem om enchant data vises eller ej.";
		HelpPrintin	= "V\195\166lg hvilken ramme Enchantrix viser sine meddelelser i.\nDu kan enten angive navnet eller nummeret.";
		HelpRate	= "V\195\166lg om det gennemsnitlige antal af disenchant skal vises.";
		HelpTerse	= "Aktiver/deaktiver kortfattet indstilling. Viser kun disenchant v\195\166rdi. Kan tilsides\195\166ttes ved at holde control-tasten nede.";
		HelpValue	= "V\195\166lg om tingens v\195\166rdi baseret p\195\131 udfaldet af mulige disenchants skal vises.";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "BudNu";
		FrmtBidbrokerDone	= "Genneml\195\184b for lave priser udf\195\184rt.";
		FrmtBidbrokerHeader	= "Auktioner som har %s s\195\131\194\184lv besparelse baseret p\195\165 gennemsnitlig disenchant v\195\166rdi.";
		FrmtBidbrokerLine	= "%s, Vurderet til: %s, %s: %s. Besparelse: %s, Under %s, Tid: %s";
		FrmtBidbrokerMinbid	= "BudMin";
		FrmtPctlessDone	= "Bud under gennemf\195\131\194\184rt.";
		FrmtPctlessHeader	= "Buyouts som har %d%% besparelse i forhold til gennemsnitlige disenchant v\195\166rdi:";
		FrmtPctlessLine	= "%s, vurderet til: %s, BO: %s, spar: %d, %s under.";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Udr\195\165bspris (%d%% margen)";
		FrmtCounts	= "(base=%d, gammel=%d, ny=%d)";
		FrmtDisinto	= "Disenchants til:";
		FrmtFound	= "Fandt at %s disenchants til:";
		FrmtPriceEach	= "(%s/stk.)";
		FrmtSuggestedPrice	= "Anbefalet pris:";
		FrmtTotal	= "I alt";
		FrmtValueAuctHsp	= "Disenchant v\195\166rdi (HSP)";
		FrmtValueAuctMed	= "Disenchant v\195\166rdi (Middel)";
		FrmtValueMarket	= "Disenchant v\195\166rdi (Base)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer ikke indl\195\166st, bruger priser fra cachen]";
		FrmtWarnNoPrices	= "[Ingen priser er tilg\195\166ngelige]";
		FrmtWarnPriceUnavail	= "[Nogen af priserne er ikke tilg\195\166ngelige]";

	};

	nlNL = {


		-- Section: Command Messages
		FrmtActClearall	= "Wissen van alle enchant gegevens";
		FrmtActClearFail	= "Kan item niet vinden: %s";
		FrmtActClearOk	= "Data gewist voor item: %s";
		FrmtActDefault	= "Enchantrix'x %s optie is teruggezet naar standaard instelling";
		FrmtActDefaultAll	= "Alle Enchantrix opties zijn teruggezet naar standaard instelling.";
		FrmtActDisable	= "Item's %s gegevens worden niet weergegeven";
		FrmtActEnable	= "Item's %s gegevens worden weergegeven";
		FrmtActEnabledOn	= "Weergeven Item's %s op %s";
		FrmtActSet	= "Stel %s naar '%s' in";
		FrmtActUnknown	= "Onbekende opdracht: '%s'";
		FrmtActUnknownLocale	= "De opgegeven taal ('%s') is onbekend. Geldige talen zijn:";
		FrmtPrintin	= "Berichten van Enchantrix worden nu weergegeven op de \"%s\" chat frame";
		FrmtUsage	= "Gebruik:";
		MesgDisable	= "Uitschakelen automatisch laden van Enchantrix";
		MesgNotloaded	= "Enchantrix is niet geladen. Type /enchantrix voor meer info.";


		-- Section: Command Options
		OptFindBidauct	= "<zilver>";
		OptFindBuyauct	= "<procent>";
		OptLocale	= "<taal>";
		OptPrintin	= "(<frameIndex>[Nummer]|<frameNaam>[Tekst])";


		-- Section: Commands
		BarkerOff	= "De-activeren Omroep functie";
		BarkerOn	= "Activeren Omroep Functie";
		CmdBarker	= "Omroeper";
		ShowTerse	= "Beknopt";
		StatOff	= "Enchant gegevens worden niet getoond";
		StatOn	= "De geconfigureerde enchant gegevens worden getoond";


		-- Section: Config Text
		GuiLoad	= "Laden van Enchantrix";
		GuiLoad_Always	= "altijd";
		GuiLoad_Never	= "nooit";


		-- Section: Game Constants
		ArgSpellname	= "Disenchant";
		PatReagents	= "Benodigdheden: (.+)";
		TextCombat	= "Gevecht";
		TextGeneral	= "Algemeen";


		-- Section: Generic Messages
		FrmtCredit	= "(ga naar http://enchantrix.org/ om uw data te delen)";
		FrmtWelcome	= "Enchantrix v%s geladen";
		MesgAuctVersion	= "Enchantrix heeft Auctioneer versie 3.4 of hoger nodig. Sommige functionaliteiten zijn niet beschikbaar totdat Auctioneer is geupgrade.";


		-- Section: Help Text
		GuiBarker	= "Activeren Omroeper";
		GuiClearall	= "Opschonen alle Enchantrix Data";
		GuiClearallButton	= "Alles opschonen";
		GuiClearallHelp	= "Klik hier om alle enchantrix data van de huidige Server/Realm op te schonen.";
		GuiClearallNote	= "voor de huidige Server-factie";
		GuiCount	= "Toon de exacte telling in de database.";
		GuiDefaultAll	= "Herstel alle Enchantrix Opties";
		GuiDefaultAllButton	= "Herstel Alles";
		GuiDefaultAllHelp	= "Klik hier om alle standaard waardes van de Enchantrix opties te laden. LET OP: Deze actie kan NIET ongedaan worde n gemaakt.";
		GuiDefaultOption	= "Herstel deze instelling";
		GuiMainEnable	= "Activeren Enchantrix";
		GuiOtherHeader	= "Andere Opties";
		GuiOtherHelp	= "Verschillende Enchantrix Opties";
		GuiPrintin	= "Selecteer het gewenste berichten scherm";
		GuiRate	= "Toon de gemiddelde hoeveelheid van de disenchant";
		GuiReloadui	= "Opnieuw laden Gebruikers scherm.";
		GuiReloaduiButton	= "HerladenUI";
		GuiReloaduiFeedback	= "Nu bezig met het herladen van de WoW UI";
		GuiTerse	= "Activeer Beknopte Mode";
		GuiValuateAverages	= "Taxatie met Auctioneer gemiddelden";
		GuiValuateBaseline	= "Taxatie met Standaard Data";
		GuiValuateEnable	= "Activeer Taxatie";
		GuiValuateHeader	= "Taxatie";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "HuidigBod";
		FrmtBidbrokerDone	= "Een regelend bod gedaan";
		FrmtBidbrokerHeader	= "Een bod bespaart %s zilver op de gemiddelde disenchant waarde:";
		FrmtBidbrokerLine	= "%s, Waarde van %s, %s: %s, Bespaard: %s, Minder %s, Tijd: %s";
		FrmtBidbrokerMinbid	= "MinimaleBod";
		FrmtPctlessDone	= "Percentage minder gedaan.";
		FrmtPctlessHeader	= "Opkoop waarde bespaard %d%% op de gemiddelde disenchant waarde:";
		FrmtPctlessLine	= "%s, Geschat op %s, BO: %s, Bespaar: %s, Minder %s";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Omroep Prijs (%d%% marge)";
		FrmtCounts	= "basis=%d, oud=%d, nieuw=%d";
		FrmtDisinto	= "Gedisenchant in:";
		FrmtFound	= "Gevonden dat %s wordt gedisenchant in:";
		FrmtPriceEach	= "Prijs per item";
		FrmtSuggestedPrice	= "Voorstel Prijs:";
		FrmtTotal	= "Totaal";
		FrmtValueAuctHsp	= "Disenchant Waarde";
		FrmtValueAuctMed	= "Disenchant Waarde (Gemiddeld)";
		FrmtValueMarket	= "Disenchant Waarde";
		FrmtWarnAuctNotLoaded	= "Auctioneer niet geladen. Opgeslagen waardes worden gebruikt.";
		FrmtWarnNoPrices	= "Geen prijs beschikbaar ";
		FrmtWarnPriceUnavail	= "Sommige prijzen niet beschikbaar";

	};

	ptPT = {


		-- Section: Command Messages
		FrmtActClearall	= "A limpar toda a informa\195\167\195\163o de enchanting";
		FrmtActClearFail	= "Imposs\195\173vel encontrar objecto: %s";
		FrmtActClearOk	= "Informa\195\167\195\163o eliminada do objecto: %s";
		FrmtActDefault	= "%s do Enchantrix voltaram \195\160s defini\195\167\195\181es padr\195\163o";
		FrmtActDefaultAll	= "Todas as op\195\167\195\181es Enchantrix revertidas para o normal.";
		FrmtActDisable	= "N\195\163o est\195\161 a ser mostrada informa\195\167\195\163o do objecto %s";
		FrmtActEnable	= "Est\195\161 a ser mostrada informa\195\167\195\163o do objecto %s";
		FrmtActEnabledOn	= "A mostrar o objecto %s em %s";
		FrmtActSet	= "Definir %s para '%s'";
		FrmtActUnknown	= "Comando de palavra-chave desconhecido: '%s'";
		FrmtActUnknownLocale	= "A localiza\195\167\195\163o dada ('%s') nao foi encontrada. Localiza\195\167\195\181es v\195\161lidas s\195\163o:";
		FrmtPrintin	= "Mensagens do Enchantrix v\195\163o ser mostradas no chat \"%s\"";
		FrmtUsage	= "Uso:";
		MesgDisable	= "A desactivar o carregamento autom\195\161tico do Enchantrix";
		MesgNotloaded	= "Enchantrix n\195\163o est\195\161 carregado.  Escreva /enchantrix para mais informa\195\167\195\181es.";


		-- Section: Command Options
		CmdClearAll	= "todos";
		OptClear	= "[Objecto]|todos";
		OptDefault	= "(<op\195\167\195\163o>|todos)";
		OptFindBidauct	= "<prata>";
		OptFindBuyauct	= "<percentagem>";
		OptLocale	= "<local>";
		OptPrintin	= "(<frameIndex>[N\195\186mero]<frameName>[Corda])";


		-- Section: Commands
		BarkerOff	= "Fun\195\167\195\163o Barker Desligada";
		BarkerOn	= "Fun\195\167\195\163o Barker Ligada";
		CmdBarker	= "Vendedor";
		CmdClear	= "apagar";
		CmdDefault	= "por defeito";
		CmdDisable	= "desactivar";
		CmdHelp	= "ajuda";
		CmdLocale	= "localiza\195\167\195\163o";
		CmdOff	= "desligado";
		CmdOn	= "ligado";
		CmdPrintin	= "imprimir em";
		CmdToggle	= "alternar";
		ShowCount	= "contagens";
		ShowEmbed	= "embebido";
		ShowGuessAuctioneerMed	= "valor m\195\169dio";
		ShowGuessBaseline	= "valor base";
		ShowHeader	= "cabe\195\167alho";
		ShowRate	= "taxas";
		ShowTerse	= "breve";
		ShowValue	= "avaliar";
		StatOff	= "N\195\163o est\195\161 a ser mostrada informa\195\167\195\163o do enchant";
		StatOn	= "Est\195\161 a ser mostrada a informa\195\167\195\163o configurada do enchant";


		-- Section: Config Text
		GuiLoad	= "A carregar Enchantrix";
		GuiLoad_Always	= "sempre";
		GuiLoad_Never	= "nunca";


		-- Section: Game Constants
		ArgSpellname	= "Desencantar";
		PatReagents	= "Reagentes: (.+)";
		TextCombat	= "Combate";
		TextGeneral	= "Geral";


		-- Section: Generic Messages
		FrmtCredit	= "(vai a http://enchantrix.org para partilhares a tua informa\195\167\195\163o)";
		FrmtWelcome	= "Enchantrix v%s carregado";
		MesgAuctVersion	= "Enchantrix requer a vers\195\163o 3.4 do Auctioneer ou mais elevado. Algumas caracter\195\173sticas ser\195\163o desligadas at\195\169 que voc\195\170 actualize sua instala\195\167\195\163o do Auctioneer. ";


		-- Section: Help Text
		GuiBarker	= "Ligar Vendedor";
		GuiClearall	= "Limpar toda a informa\195\167\195\163o do Enchantrix";
		GuiClearallButton	= "Limpar tudo";
		GuiClearallHelp	= "Carrega aqui para limpar toda a informa\195\167\195\163o do Enchantrix do servidor actual.";
		GuiClearallNote	= "para o servidor/fac\195\167\195\163o actual";
		GuiCount	= "Mostrar a contagem exacta na base de dados";
		GuiDefaultAll	= "Limpar todas as op\195\167\195\181es do Enchantrix";
		GuiDefaultAllButton	= "Limpar tudo";
		GuiDefaultAllHelp	= "Carrega aqui para voltar \195\160s defini\195\167\195\181es padr\195\163o do Enchantrix. ATEN\195\135\195\131O: Esta ac\195\167\195\163o N\195\131O \195\169 revers\195\173vel.";
		GuiDefaultOption	= "Limpar esta defini\195\167\195\163o";
		GuiEmbed	= "Informa\195\167\195\163o junta na tooltip do jogo";
		GuiLocale	= "Definir localiza\195\167\195\163o para";
		GuiMainEnable	= "Activar Enchantrix";
		GuiMainHelp	= "Cont\195\169m defini\195\167\195\181es para o Enchantrix, um AddOn que mostra informa\195\167\195\163o na tooltip dos objectos com poss\195\173veis resultados de desencantamento do dito objecto.";
		GuiOtherHeader	= "Outras Op\195\167\195\181es";
		GuiOtherHelp	= "Outras Op\195\167\195\181es do Enchantrix";
		GuiPrintin	= "Seleccionar a express\195\163o desejada da mensagem";
		GuiRate	= "Mostrar a quantidade m\195\169dia de desencanto";
		GuiReloadui	= "Recarregar o Interface do Utilizador";
		GuiReloaduiButton	= "RecarregarUI";
		GuiReloaduiFeedback	= "A recarregar o UI do WoW";
		GuiReloaduiHelp	= "Carrega aqui para recarregar o Interface de Utilizador (UI) do WoW ap\195\179s mudar a localiza\195\167\195\163o para que a linguagem neste menu de configura\195\167\195\163o confira com a que escolheste. Nota: Esta opera\195\167\195\163o poder\195\161 demorar alguns minutos.";
		GuiTerse	= "Ligar modo breve";
		GuiValuateAverages	= "Validar com as m\195\169dias Auctioneer";
		GuiValuateBaseline	= "Validar com a Data Padr\195\163o";
		GuiValuateEnable	= "Activar Valida\195\167\195\163o";
		GuiValuateHeader	= "Valida\195\167\195\163o";
		GuiValuateMedian	= "Validar com os N\195\186meros M\195\169dios Auctioneer";
		HelpBarker	= "Ligar e Desligar Vendedor";
		HelpClear	= "Limpar a informa\195\167\195\163o espec\195\173fica de um objecto (tem de carregar shift+click o objecto no comando) Tamb\195\169m podes especificar a palavra especial \"Todos\"";
		HelpCount	= "Seleccionar se quer ver a contagem exacta dos objectos na Database";
		HelpDefault	= "Aplicar uma op\195\167\195\163o do Enchantrix para o seu Padr\195\163o. Tamb\195\169m podes especificar a palavra especial \"Todos\" para por todos as op\195\167\195\181es Padr\195\163o.";
		HelpDisable	= "Pro\195\173bir o Enchantrix de se ligar da pr\195\179xima vez que entrar no jogo";
		HelpEmbed	= "Encaixar o texto no tooltip original do jogo (nota: determinadas caracter\195\173sticas s\195\163o desligadas quando esta op\195\167\195\163o \195\169 selecionada)";
		HelpFindBidauct	= "Encontrar os leil\195\181es cujo poss\195\173vel valor do desencanto \195\169 uma determinada quantidade de prata menos do que o pre\195\167o de oferta";
		HelpFindBuyauct	= "Encontrar os auctions cujo poss\195\173vel valor de desencanto \195\169 um determinado por cento menos do que o pre\195\167o compra directa";
		HelpGuessAuctioneerHsp	= "Se a valida\195\167\195\163o estiver permitida, e voc\195\170 tiver o Auctioneer instalado, indicar o pre\195\167o de venda (HSP) de disencanto do artigo. ";
		HelpGuessAuctioneerMedian	= "Se a valida\195\167\195\163o estiver permitida, e voc\195\170 tiver o Auctioneer instalado, indicar o valor baseado mediano de disencanto do artigo. ";
		HelpGuessBaseline	= "Se a valida\195\167\195\163o for permitida, (Auctioneer n\195\163o necessitado) indicar o valor da linha de base de disencanto do artigo, baseado nos pre\195\167os inbutidos. ";
		HelpGuessNoauctioneer	= "Se a valida\195\167\195\163o for permitida, (Auctioneer n\195\163o necessitado) indicar o valor da linha de base de disencanto do artigo, baseado nos pre\195\167os inbutidos";
		HelpHeader	= "Selecionar se quer mostrar o cabe\195\167alho";
		HelpLoad	= "Mudar as op\195\167\195\181es de carregamento para este personagem";
		HelpLocale	= "Mudar a localiza\195\167\195\163o que \195\169 usada para mostrar as mensagens do Enchantrix";
		HelpOnoff	= "Liga e Desliga a exposi\195\167\195\163o de dados do Enchant";
		HelpPrintin	= "Selecionar em que janela o Enchantrix ir\195\161 imprimir as suas mensagens. Poder\195\161s expecificar o nome da janela ou o inicio da janela.";
		HelpRate	= "Seleccionar se quer exibir as quantidades m\195\169dias do desencanto.";
		HelpTerse	= "Ligar/Desligar o modo breve, montrando somente o valor do desencanto. Pode ser sobreposto carregando na tecla Ctrl.";
		HelpValue	= "Seleccionar se quer ver os valores estimados baseados em propor\195\167\195\181es possiveis dos desencantos.";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "Ofcur";
		FrmtBidbrokerDone	= "Oferta do corrector feita";
		FrmtBidbrokerHeader	= "As ofertas que t\195\170m as economias de prata de %s na m\195\169dia do valor disencanto:";
		FrmtBidbrokerLine	= "%s, Avaliado em: %s, %s: %s, Excepto: %s, Menos %s, Tempo: %s";
		FrmtBidbrokerMinbid	= "Ofmin";
		FrmtPctlessDone	= "Percentagem menos feito";
		FrmtPctlessHeader	= "As Compras Directas que t\195\170m excesso do artigo m\195\169dio das economias de %d%% do valor do desencanto: ";
		FrmtPctlessLine	= "%s, Avaliado em: %s, BO: %s, Excepto: %s, Menos %s ";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Pre\195\167o de Vendedor (%d%% margem)";
		FrmtCounts	= "(base=%d, antigo=%d, novo=%d) ";
		FrmtDisinto	= "Desencanta em:";
		FrmtFound	= "Observado que %s desencanta em: ";
		FrmtPriceEach	= "(%s cada)";
		FrmtSuggestedPrice	= "Pre\195\167o sugerido:";
		FrmtTotal	= "Total";
		FrmtValueAuctHsp	= "Valor do Desencanto (MPV)";
		FrmtValueAuctMed	= "Valor do Desencanto (N\195\186meros m\195\169dios)";
		FrmtValueMarket	= "Valor de Disencanto (Refer\195\170ncia)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer n\195\163o carregado, usando pre\195\167os em cache]";
		FrmtWarnNoPrices	= "[Nenhuns Pre\195\167os Disponiveis]";
		FrmtWarnPriceUnavail	= "[Alguns pre\195\167os indisponiveis]";

	};

	ruRU = {


		-- Section: Command Messages
		FrmtActClearall	= "\208\163\208\177\208\184\209\128\208\176\209\142 \208\178\209\129\209\142 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\142 \208\191\209\128\208\190 enchant";
		FrmtActClearFail	= "\208\157\208\181 \208\188\208\190\208\179\209\131 \208\189\208\176\208\185\209\130\208\184 \208\191\209\128\208\181\208\180\208\188\208\181\209\130: %s";
		FrmtActClearOk	= "\208\163\208\177\209\128\208\176\208\189\208\176 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\143 \208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\181: %s";
		FrmtActDefault	= "\208\146\208\176\209\128\208\184\208\176\208\189\209\130 %s Enchantrix's \208\177\209\139\208\187 \208\191\208\181\209\128\208\181\209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189 \208\186 \209\129\208\178\208\190\208\181\208\185 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\186\208\181 \208\189\208\181\208\178\209\139\208\191\208\190\208\187\208\189\208\181\208\189\208\184\209\143 \208\190\208\177\209\143\208\183\208\176\209\130\208\181\208\187\209\140\209\129\209\130\208\178\208\176\n";
		FrmtActDefaultAll	= "\208\146\209\129\208\181 \208\178\208\176\209\128\208\184\208\176\208\189\209\130\209\139 Enchantrix \208\177\209\139\208\187\208\184 \208\191\208\181\209\128\208\181\209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\209\139 \208\186 \208\189\208\176\209\135\208\176\208\187\209\140\208\189\209\139\208\188 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\186\208\176\208\188.\n";
		FrmtActDisable	= "\208\159\208\190\208\186\208\176\208\183 \208\180\208\176\208\189\208\189\209\139\209\133 \208\191\208\190 %s \208\180\208\181\209\130\208\176\208\187\209\143\n";
		FrmtActEnable	= "\208\159\208\190\208\186\208\176\208\183 \208\180\208\176\208\189\208\189\209\139\209\133 \208\191\208\190 %s \208\180\208\181\209\130\208\176\208\187\209\143\n";
		FrmtActEnabledOn	= "\208\159\208\190\208\186\208\176\208\183 %s \208\180\208\181\209\130\208\176\208\187\209\143 \208\189\208\176 %s\n";
		FrmtActSet	= "\208\163\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\208\181 %s \208\186 ' %s'\n";
		FrmtActUnknown	= "\208\157\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\209\139\208\185 keyword \208\186\208\190\208\188\208\176\208\189\208\180\209\139: ' %s'\n";
		FrmtActUnknownLocale	= "Locale, \208\186\208\190\209\130\208\190\209\128 \208\178\209\139 \208\190\208\191\209\128\208\181\208\180\208\181\208\187\208\184\208\187\208\184 (' %s') \208\189\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\209\139. \208\148\208\181\208\185\209\129\209\130\208\178\208\184\209\130\208\181\208\187\209\140\208\189\209\139\208\181 locales \209\143\208\178\208\187\209\143\209\142\209\130\209\129\209\143 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\208\184\208\188\208\184:\n";
		FrmtPrintin	= "\208\161\208\190\208\190\208\177\209\137\208\181\208\189\208\184\209\143 Encantrix's \209\130\208\181\208\191\208\181\209\128\209\140 \208\189\208\176\208\191\208\181\209\135\208\176\209\130\208\176\209\142\209\130 \208\189\208\176 \209\128\208\176\208\188\208\186\208\181 \208\177\208\190\209\128\208\188\208\190\209\130\209\131\209\136\208\186 \"%s\"\n";
		FrmtUsage	= "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\208\181:\n";
		MesgDisable	= "\208\146\209\139\208\178\208\190\208\180\209\143 \208\184\208\183 \209\129\209\130\209\128\208\190\209\143 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\176\209\143 \208\189\208\176\208\179\209\128\209\131\208\183\208\186\208\176 Enchantrix\n";
		MesgNotloaded	= "Enchantrix \208\189\208\181 \208\189\208\176\208\179\209\128\209\131\208\182\208\181\208\189\208\190. \208\157\208\176\208\191\208\181\209\135\208\176\209\130\208\176\208\185\209\130\208\181 /enchantrix \208\189\208\176 \208\188\208\176\209\136\208\184\208\189\208\186\208\181 \208\180\208\187\209\143 \208\177\208\190\208\187\209\140\209\136\208\181 info.\n";


		-- Section: Command Options
		CmdClearAll	= "\208\178\209\129\208\181\n";
		OptClear	= "([Item]|all) ";
		OptDefault	= "(<option>|all) ";
		OptFindBidauct	= "<silver> ";
		OptFindBuyauct	= "<percent> ";
		OptLocale	= "<locale> ";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String]) ";


		-- Section: Commands
		CmdClear	= "\208\158\209\135\208\184\209\129\209\130\208\184\209\130\209\140";
		CmdDefault	= "\208\161\209\130\208\176\208\189\208\180\208\176\209\128\209\130\208\189\209\139\208\181";
		CmdDisable	= "\208\178\209\139\208\178\208\181\208\180\208\184\209\130\208\181 \208\184\208\183 \209\129\209\130\209\128\208\190\209\143\n";
		CmdFindBidauct	= "bidbroker ";
		CmdFindBidauctShort	= "bb ";
		CmdFindBuyauct	= "percentless ";
		CmdFindBuyauctShort	= "pl ";
		CmdHelp	= "\208\191\208\190\208\188\208\190\209\137\209\140\n";
		CmdOff	= "off";
		CmdOn	= "\208\189\208\176\n";
		CmdPrintin	= "print-in ";
		CmdToggle	= "\208\191\208\181\209\128\208\181\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		ShowCount	= "\208\190\209\130\209\129\209\135\208\181\209\130\209\139\n";
		ShowHeader	= "\208\183\208\176\208\179\208\190\208\187\208\190\208\178\208\190\208\186";
		ShowRate	= "\208\190\209\134\208\181\208\189\208\184\208\178\208\176\208\181\209\130\209\129\209\143";


		-- Section: Config Text
		GuiLoad	= "\208\151\208\176\208\179\209\128\209\131\208\183\208\184\209\130\209\140 Enchantrix ";
		GuiLoad_Always	= "\208\178\209\129\208\181\208\179\208\180\208\176";
		GuiLoad_Never	= "\208\189\208\184\208\186\208\190\208\179\208\180\208\176";


		-- Section: Game Constants
		ArgSpellname	= "\208\148\208\184\208\183\208\181\208\189\209\135\208\176\208\189\209\130";
		PatReagents	= "\208\160\208\181\208\176\208\179\208\181\208\189\209\130\209\139: (.+) ";
		TextGeneral	= "\208\158\209\129\208\189\208\190\208\178\208\189\208\190\208\185";


		-- Section: Generic Messages
		FrmtCredit	= "(\208\189\208\176 http://enchantrix.org/ \208\188\208\190\208\182\208\190 \208\191\208\190\208\180\208\181\208\187\208\184\209\130\209\140\209\129\209\143 \209\129\208\178\208\190\208\184\208\188\208\184 \208\180\208\176\208\189\208\189\209\139\208\188\208\184)";
		FrmtWelcome	= "Enchantrix v%s \208\183\208\176\208\179\209\128\209\131\208\182\208\181\208\189";


		-- Section: Help Text
		GuiClearall	= "\208\158\208\177\208\189\209\131\208\187\208\184\209\130\209\140 \208\178\209\129\208\181 \208\180\208\176\208\189\208\189\209\139\208\181 Enchantrix";
		GuiClearallButton	= "\208\158\208\177\208\189\209\131\208\187\208\184\209\130\209\140 \208\178\209\129\209\145";
		GuiClearallHelp	= "\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \209\129\209\142\208\180\208\176, \209\135\209\130\208\190\208\177\209\139 \208\190\208\177\208\189\209\131\208\187\208\184\209\130\209\140 \208\178\209\129\208\181 \208\180\208\176\208\189\208\189\209\139\208\181 Enchantrix \208\180\208\187\209\143 \209\130\208\181\208\186\209\131\209\137\208\181\208\179\208\190 \209\129\208\181\209\128\208\178\208\181\209\128\208\176";
		GuiCount	= "\208\159\208\190\208\186\208\176\208\183\208\176\209\130\209\140 \209\130\208\190\209\135\208\189\208\190\208\181 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190 \208\178 \208\177\208\176\208\183\208\181 \208\180\208\176\208\189\208\189\209\139\209\133";
		GuiDefaultAll	= "\208\146\208\190\209\129\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\209\140 \208\178\209\129\208\181 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 Enchantrix \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142";
		GuiDefaultAllButton	= "\208\161\208\177\209\128\208\190\209\129\208\184\209\130\209\140 \208\178\209\129\209\145";
		GuiDefaultAllHelp	= "\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \209\129\209\142\208\180\208\176 \208\180\208\187\209\143 \208\178\208\190\208\183\208\178\209\128\208\176\209\130\208\176 \208\178\209\129\208\181\209\133 \208\189\208\176\209\129\209\130\209\128\208\190\208\181\208\186 Enchantrix \208\186 \208\184\209\133 \208\191\208\181\209\128\208\178\208\190\208\189\208\176\209\135\208\176\208\187\209\140\208\189\209\139\208\188 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143\208\188. WARNING: \208\173\209\130\208\190 \208\180\208\181\208\185\209\129\209\130\208\178\208\184\208\181 \208\157\208\149\208\155\208\172\208\151\208\175 \208\158\208\162\208\156\208\149\208\157\208\152\208\162\208\172.";
		GuiDefaultOption	= "\208\146\208\190\209\129\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\209\140 \208\180\208\176\208\189\208\189\209\139\208\185 \208\191\208\176\209\128\208\176\208\188\208\181\209\130\209\128";
		GuiLocale	= "\208\161\208\188\208\181\208\189\208\184\209\130\209\140 \209\143\208\183\209\139\208\186 \208\189\208\176";
		GuiMainEnable	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 Enchantrix";
		GuiOtherHeader	= "\208\148\209\128\209\131\208\179\208\184\208\181 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184";
		GuiReloadui	= "\208\159\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\183\208\176 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129\208\176 \208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\208\181\208\187\209\143";
		GuiReloaduiFeedback	= "\208\152\208\180\208\181\209\130 \208\191\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\183\208\186\208\176 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129\208\176 \208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\208\181\208\187\209\143";
		HelpDisable	= "\208\157\208\181 \208\183\208\176\208\179\209\128\209\131\208\182\208\176\209\130\209\140 enchantrix \208\178 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\208\184\208\185 \209\128\208\176\208\183, \208\186\208\190\208\179\208\180\208\176 \208\178\209\139 \208\178\208\190\208\185\208\180\208\181\209\130\208\181 \208\178 \208\184\208\179\209\128\209\131";


		-- Section: Tooltip Messages
		FrmtPriceEach	= "(%s \208\186\208\176\208\182\208\180\208\176\209\143)";
		FrmtSuggestedPrice	= "\208\160\208\181\208\186\208\190\208\188\208\181\208\189\208\180\209\131\208\181\208\188\208\176\209\143 \209\134\208\181\208\189\208\176:";
		FrmtTotal	= "\208\152\209\130\208\190\208\179\208\190";
		FrmtWarnAuctNotLoaded	= "[Auctioneer \208\189\208\181 \208\183\208\176\208\179\209\128\209\131\208\182\208\181\208\189, \208\184\209\129\208\191\208\190\208\187\209\140\208\183\209\131\209\142 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\189\209\139\208\181 \209\128\208\176\208\189\208\181\208\181 \208\180\208\176\208\189\208\189\209\139\208\181]";
		FrmtWarnNoPrices	= "[\208\166\208\181\208\189\209\139 \208\189\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\209\139]";
		FrmtWarnPriceUnavail	= "[\208\157\208\181\208\186\208\190\209\130\208\190\209\128\209\139\208\181 \209\134\208\181\208\189\209\139 \208\189\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\209\139]";

	};

	trTR = {


		-- Section: Command Messages
		FrmtActClearall	= "T\195\131\194\188m enchant verilerini siliyor";
		FrmtActClearFail	= "Cisim bulunamad\195\132\194\177: %s";
		FrmtActClearOk	= "Verileri silinen cisim: %s";
		FrmtActDefault	= "Enchantrix'in %s se\195\131\194\167ene\195\132\197\184i varsay\195\132\194\177lan haline d\195\131\194\182nd\195\131\194\188r\195\131\194\188ld\195\131\194\188.";
		FrmtActDefaultAll	= "T\195\131\194\188m Enchantrix se\195\131\194\167enekleri varsay\195\132\194\177lan hallerine d\195\131\194\182nd\195\131\194\188r\195\131\194\188ld\195\131\194\188.";
		FrmtActDisable	= "Cismin %s verisi g\195\131\194\182sterilmiyor";
		FrmtActEnable	= "Cismin %s verisi g\195\131\194\182steriliyor";
		FrmtActEnabledOn	= "Cismin %s si %s de g\195\131\194\182steriliyor";
		FrmtActSet	= "%s yi '%s' ye ayarla";
		FrmtActUnknown	= "Bilinmeyen komut anahtar kelimesi: '%s' ";


		-- Section: Commands
		CmdDisable	= "iptal";

	};

	zhTW = {


		-- Section: Command Messages
		FrmtActClearall	= "\230\184\133\233\153\164\230\137\128\230\156\137\233\153\132\233\173\148\232\179\135\230\150\153";
		FrmtActClearFail	= "\231\132\161\230\179\149\230\137\190\229\136\176\231\137\169\229\147\129\239\188\154%s";
		FrmtActClearOk	= "\230\184\133\233\153\164\231\137\169\229\147\129\232\179\135\230\150\153\239\188\154%s ";
		FrmtActDefault	= "Enchantrix\231\154\132%s\232\168\173\229\174\154\229\183\178\231\182\147\233\135\141\232\168\173\231\130\186\229\136\157\229\167\139\229\128\188";
		FrmtActDefaultAll	= "\230\137\128\230\156\137Enchantrix\231\154\132\232\168\173\229\174\154\229\183\178\231\182\147\233\135\141\232\168\173\231\130\186\229\136\157\229\167\139\229\128\188";
		FrmtActDisable	= "\228\184\141\232\166\129\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132 %s \232\179\135\230\150\153";
		FrmtActEnable	= "\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132 %s \232\179\135\230\150\153";
		FrmtActEnabledOn	= "\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132 %s \229\156\168 %s";
		FrmtActSet	= "\232\168\173\229\174\154%s\231\130\186'%s'";
		FrmtActUnknown	= "\230\156\170\231\159\165\231\154\132\229\145\189\228\187\164\233\151\156\233\141\181\229\173\151\239\188\154'%s'";
		FrmtActUnknownLocale	= "\230\137\190\228\184\141\229\136\176\230\130\168\233\129\184\230\147\135\231\154\132\232\170\158\232\168\128('%s')\227\128\130\229\143\175\231\148\168\231\154\132\232\170\158\232\168\128\230\156\137\239\188\154";
		FrmtPrintin	= "Encantrix\231\154\132\232\168\138\230\129\175\229\176\135\230\156\131\233\161\175\231\164\186\229\156\168 \"%s\" \232\129\138\229\164\169\230\161\134\230\158\182";
		FrmtUsage	= "\231\148\168\233\128\148:";
		MesgDisable	= "\233\151\156\233\150\137Enchantrix\228\185\139\232\135\170\229\139\149\232\188\137\229\133\165";
		MesgNotloaded	= "Enchantrix\230\156\170\232\188\137\229\133\165,\232\188\184\229\133\165 /enchantrix \229\143\150\229\190\151\232\170\170\230\152\142";


		-- Section: Command Options
		CmdClearAll	= "all";
		OptClear	= "([Item]|all)";
		OptDefault	= "(<option>|all)";
		OptFindBidauct	= "<silver>";
		OptFindBuyauct	= "<percent>";
		OptLocale	= "<locale>";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String])";


		-- Section: Commands
		BarkerOff	= "\229\129\156\231\148\168\232\129\178\230\156\155\230\143\144\231\164\186\229\138\159\232\131\189";
		BarkerOn	= "\229\149\159\231\148\168\232\129\178\230\156\155\230\143\144\231\164\186\229\138\159\232\131\189";
		CmdBarker	= "\232\129\178\230\156\155\230\143\144\231\164\186";
		CmdClear	= "clear";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdFindBidauct	= "bidbroker";
		CmdFindBidauctShort	= "bb";
		CmdFindBuyauct	= "percentless";
		CmdFindBuyauctShort	= "pl";
		CmdHelp	= "\229\185\171\229\138\169";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPrintin	= "print-in";
		CmdToggle	= "toggle";
		ShowCount	= "counts";
		ShowEmbed	= "embed";
		ShowGuessAuctioneerHsp	= "valuate-hsp";
		ShowGuessAuctioneerMed	= "valuate-median";
		ShowGuessBaseline	= "valuate-baseline";
		ShowHeader	= "header";
		ShowRate	= "rates";
		ShowTerse	= "\231\178\190\231\176\161";
		ShowValue	= "valuate";
		StatOff	= "\228\184\141\233\161\175\231\164\186\228\187\187\228\189\149\233\153\132\233\173\148\232\179\135\230\150\153";
		StatOn	= "\233\161\175\231\164\186\229\183\178\232\168\173\229\174\154\233\153\132\233\173\148\232\179\135\230\150\153\228\184\173";


		-- Section: Config Text
		GuiLoad	= "\232\188\137\229\133\165Enchantrix";
		GuiLoad_Always	= "always";
		GuiLoad_Never	= "never";


		-- Section: Game Constants
		ArgSpellname	= "Disenchant";
		PatReagents	= "Reagents: (.+) ";
		TextCombat	= "Combat";
		TextGeneral	= "General";


		-- Section: Generic Messages
		FrmtCredit	= " (\232\171\139\232\135\179 http://enchantrix.org/ \228\187\165\229\136\134\228\186\171\230\130\168\231\154\132\232\179\135\230\150\153) ";
		FrmtWelcome	= "Enchantrix v%s \229\183\178\232\188\137\229\133\165";
		MesgAuctVersion	= "Enchantrix\233\156\128\232\166\129Auctioneer3.4\230\136\150\230\155\180\230\150\176\231\137\136\230\156\172\227\128\130\230\159\144\228\186\155\229\138\159\232\131\189\229\156\168\230\130\168\230\156\170\230\155\180\230\150\176\230\130\168\231\154\132Auctioneer\229\137\141\231\132\161\230\179\149\228\189\191\231\148\168\227\128\130";


		-- Section: Help Text
		GuiBarker	= "\229\149\159\231\148\168Barker";
		GuiClearall	= "\230\184\133\233\153\164\230\137\128\230\156\137\233\153\132\233\173\148\232\179\135\230\150\153";
		GuiClearallButton	= "\230\184\133\233\153\164\229\133\168\233\131\168";
		GuiClearallHelp	= "\233\187\158\230\147\138\230\173\164\232\153\149\239\188\140\230\184\133\233\153\164\231\155\174\229\137\141\228\188\186\230\156\141\229\153\168\228\185\139\230\137\128\230\156\137\233\153\132\233\173\148\232\179\135\230\150\153";
		GuiClearallNote	= "\231\155\174\229\137\141\231\154\132\228\188\186\230\156\141\229\153\168";
		GuiCount	= "\233\161\175\231\164\186\229\156\168\232\179\135\230\150\153\229\186\171\228\184\173\231\154\132\231\162\186\229\136\135\230\149\184\233\135\143";
		GuiDefaultAll	= "\233\135\141\231\189\174\230\137\128\230\156\137Enchantrix\233\129\184\233\160\133";
		GuiDefaultAllButton	= "\233\135\141\232\168\173\230\137\128\230\156\137\232\168\173\229\174\154";
		GuiDefaultAllHelp	= "\233\187\158\230\147\138\233\128\153\232\163\161\228\187\165\233\135\141\232\168\173\230\137\128\230\156\137Enchantrix\231\154\132\233\129\184\233\160\133\229\155\158\233\160\144\232\168\173\229\128\188\227\128\130\232\173\166\229\145\138\239\188\154\233\128\153\229\128\139\229\139\149\228\189\156\230\152\175\231\132\161\230\179\149\233\130\132\229\142\159\231\154\132\227\128\130";
		GuiDefaultOption	= "\233\135\141\232\168\173\233\128\153\229\128\139\232\168\173\229\174\154";
		GuiEmbed	= "\229\156\168\233\129\138\230\136\178\230\143\144\231\164\186\228\184\173\229\181\140\229\133\165\232\179\135\232\168\138";
		GuiLocale	= "\232\168\173\229\174\154\232\170\158\232\168\128\231\130\186";
		GuiMainEnable	= "\229\149\159\229\139\149 Enchantrix";
		GuiMainHelp	= "\230\138\138\233\153\132\233\173\148\232\179\135\232\168\138\229\181\140\229\133\165\233\129\138\230\136\178\232\179\135\232\168\138\231\170\151";
		GuiOtherHeader	= "\229\133\182\228\187\150\233\129\184\233\160\133";
		GuiOtherHelp	= "\229\133\182\228\187\150 Enchantrix \233\155\156\233\160\133\232\168\173\229\174\154";
		GuiPrintin	= "\233\129\184\230\147\135\229\180\129\229\133\165\231\154\132\232\168\138\230\129\175\230\161\134\230\158\182";
		GuiRate	= "\233\161\175\231\164\186\229\136\134\230\158\144\229\190\140\231\154\132\229\136\134\232\167\163\232\179\135\232\168\138";
		GuiReloadui	= "\233\135\141\230\150\176\232\188\137\229\133\165\228\189\191\231\148\168\232\128\133\231\149\140\233\157\162";
		GuiReloaduiButton	= "\233\135\141\230\150\176\232\188\137\229\133\165UI";
		GuiReloaduiFeedback	= "\230\173\163\229\156\168\233\135\141\230\150\176\229\149\159\229\139\149UI";
		GuiReloaduiHelp	= "\233\187\158\233\129\184\229\190\140\229\176\135\233\135\141\230\150\176\229\149\159\229\139\149UI\239\188\140\228\184\166\232\189\137\230\143\155\231\130\186\231\142\169\229\174\182\230\137\128\233\129\184\230\147\135\231\154\132\232\170\158\232\168\128\231\137\136\230\156\172\227\128\130\230\179\168\230\132\143\239\184\176\230\173\164\230\172\161\230\147\141\228\189\156\229\143\175\232\131\189\232\138\177\232\178\187\229\185\190\229\136\134\233\144\152\227\128\130 ";
		GuiTerse	= "\229\149\159\231\148\168\231\178\190\231\176\161\230\168\161\229\188\143";
		GuiValuateAverages	= "\230\139\141\232\179\163\232\169\149\228\188\176";
		GuiValuateBaseline	= "\229\180\129\229\133\165\230\139\141\232\179\163\232\179\135\230\150\153";
		GuiValuateEnable	= "\229\149\159\229\139\149\232\169\149\228\188\176\231\179\187\231\181\177";
		GuiValuateHeader	= "\228\188\176\229\131\185";
		GuiValuateMedian	= "\232\169\149\228\188\176\230\139\141\232\179\163\229\185\179\229\157\135\229\131\185\229\128\188";
		HelpBarker	= "\229\149\159\231\148\168/\229\129\156\231\148\168 Baker";
		HelpClear	= "Clear the specified item's data (you must shift click insert the item(s) into the command) You may also specify the special keyword \"all\"";
		HelpCount	= "\233\129\184\230\147\135\230\152\175\229\144\166\229\156\168\230\149\184\230\147\154\229\186\171\232\163\161\233\161\175\231\164\186\231\178\190\231\162\186\231\154\132\230\149\184\229\173\151 ";
		HelpDefault	= "Set an Enchantrix option to it's default value. You may also specify the special keyword \"all\" to set all Enchantrix options to their default values.";
		HelpDisable	= "Stops enchantrix from automatically loading next time you log in";
		HelpEmbed	= "Embed the text in the original game tooltip (note: certain features are disabled when this is selected)";
		HelpFindBidauct	= "Find auctions whose possible disenchant value is a certain silver amount less than the bid price";
		HelpFindBuyauct	= "Find auctions whose possible disenchant value is a certain percent less than the buyout price";
		HelpGuessAuctioneerHsp	= "If valuation is enabled, and you have Auctioneer installed, display the sellable price (HSP) valuation of disenchanting the item.";
		HelpGuessAuctioneerMedian	= "If valuation is enabled, and you have Auctioneer installed, display the median based valuation of disenchanting the item.";
		HelpGuessBaseline	= "If valuation is enabled, (Auctioneer not needed) display the baseline valuation of disenchanting the item, based upon the inbuilt prices.";
		HelpGuessNoauctioneer	= "The valuate-hsp and valuate-median commands are not available because you do not have auctioneer installed";
		HelpHeader	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\230\168\153\233\161\140\229\136\151";
		HelpLoad	= "Change Enchantrix's load settings for this toon";
		HelpLocale	= "\230\148\185\232\174\138\231\148\168\228\190\134\233\161\175\231\164\186Enchantrix\232\168\138\230\129\175\231\154\132\232\170\158\232\168\128";
		HelpOnoff	= "\233\153\132\233\173\148\232\179\135\230\150\153\233\150\139\229\149\159\230\136\150\233\151\156\233\150\137";
		HelpPrintin	= "\233\129\184\230\147\135Enchantrix\232\168\138\230\129\175\233\161\175\231\164\186\231\154\132\230\161\134\230\158\182\227\128\130\228\189\160\229\143\175\228\187\165\232\188\184\229\133\165\230\161\134\230\158\182\229\144\141\229\173\151\230\136\150\232\128\133\230\152\175index\227\128\130";
		HelpRate	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\229\136\134\232\167\163\231\154\132\229\185\179\229\157\135\233\135\143";
		HelpValue	= "Select whether to show item's estimated values based on the proportions of possible disenchants";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "curBid";
		FrmtBidbrokerDone	= "Bid brokering done";
		FrmtBidbrokerHeader	= "Bids having %s silver savings on average disenchant value:";
		FrmtBidbrokerLine	= "%s, Valued at: %s, %s: %s, Save: %s, Less %s, Time: %s";
		FrmtBidbrokerMinbid	= "minBid";
		FrmtPctlessDone	= "Percent less done.";
		FrmtPctlessHeader	= "Buyouts having %d%% savings over average item disenchant value:";
		FrmtPctlessLine	= "%s, Valued at: %s, BO: %s, Save: %s, Less %s";


		-- Section: Tooltip Messages
		FrmtBarkerPrice	= "Barker \229\131\185\230\160\188 (%d%% \228\191\157\232\168\188\233\135\145) ";
		FrmtCounts	= "(\229\142\159\230\156\172=%d, \232\136\138=%d, \230\150\176=%d)";
		FrmtDisinto	= "\229\136\134\232\167\163\230\136\144\239\188\154";
		FrmtFound	= "%s\229\143\175\229\136\134\232\167\163\230\136\144\239\188\154";
		FrmtPriceEach	= "(%s \230\175\143\229\128\139) ";
		FrmtSuggestedPrice	= "\229\187\186\232\173\176\229\131\185\230\160\188\239\188\154";
		FrmtTotal	= "\231\184\189\229\133\177";
		FrmtValueAuctHsp	= "\229\136\134\232\167\163\229\131\185\229\128\188(HSP)";
		FrmtValueAuctMed	= "\229\136\134\232\167\163\229\131\185\229\128\188(Median)";
		FrmtValueMarket	= "\229\136\134\232\167\163\229\131\185\229\128\188(Baseline)";
		FrmtWarnAuctNotLoaded	= "[Auctioneer\230\156\170\232\188\137\229\133\165\239\188\140\228\189\191\231\148\168\230\154\171\229\173\152\229\141\128\229\131\185\230\160\188]";
		FrmtWarnNoPrices	= "[\231\132\161\230\156\137\230\149\136\229\131\185\230\160\188]";
		FrmtWarnPriceUnavail	= "[\233\131\168\229\136\134\229\131\185\230\160\188\231\132\161\230\149\136]";

	};
}