--[[
	WARNING: This is a generated file.
	If you wish to perform or update localizations, please go to our Localizer website at:
	http://norganna.org/localizer/index.php

	AddOn: Auctioneer
	Revision: $Id: AucStrings.lua 1000 2006-09-12 02:19:20Z mentalpower $
	Version: 3.9.0.1063 (Kangaroo)

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

AuctioneerLocalizations = {

	csCZ = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Zjisti cenu sady/stacku %sx[ItemLink] (x = velikost sady) ";
		FrmtAskPriceBuyoutMedianHistorical	= "%sVykup-median historicky: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sVykup-median posledni zaznam: %s%s";
		FrmtAskPriceDisable	= "Vypinam nastaveni %s VychoziCena";
		FrmtAskPriceEach	= "(%s kazdy)";
		FrmtAskPriceEnable	= "Zapinam nastaveni %s VychoziCena";
		FrmtAskPriceVendorPrice	= "%sProdejne v obchode za: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Predmet byl odstranen z aukce %s .";
		FrmtAuctinfoHist	= "%d zaznamy";
		FrmtAuctinfoLow	= "Nejnizsi cena";
		FrmtAuctinfoMktprice	= "Obvykla trzni cena";
		FrmtAuctinfoNolow	= "Predmet zatim nebyl v aukci zaznamenan.";
		FrmtAuctinfoOrig	= "Puvodni nabidka";
		FrmtAuctinfoSnap	= "%d posledni zaznam";
		FrmtAuctinfoSugbid	= "Pocatecni nabidka";
		FrmtAuctinfoSugbuy	= "Vykupni cena";
		FrmtWarnAbovemkt	= "Zvolena cena je NADprumerna";
		FrmtWarnMarkup	= "Navyseni vendor ceny o %s%%";
		FrmtWarnMyprice	= "Pouzita dosavadni cena";
		FrmtWarnNocomp	= "Neni konkurence";
		FrmtWarnNodata	= "Malo zaznamu k stanoveni nejvyssi vhodne ceny";
		FrmtWarnToolow	= "Existuje konkurencni nabidka pod cenou";
		FrmtWarnUndercut	= "Podcenuji objekt o %s%%";
		FrmtWarnUser	= "Pouzita jiz zvolena cena";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Momentalne jste vedouci v teto aukci: %s (x%d)";
		FrmtBidAuction	= "Bid na aukci: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Chyba: Bid fronta nebyla syncovana!";
		FrmtBoughtAuction	= "Vykoupena aukce: %s (x%d)";
		FrmtMaxBidsReached	= "Bylo nalezeno vice aukci %s (x%d), ale bidovaci limit byl jiz dosazen {%d)";
		FrmtNoAuctionsFound	= "Nenalezena zadna aukce: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "Zadna dalsi aukce nebyla nalezenea: %s (x%d)";
		FrmtNotEnoughMoney	= "Nedostatek penez na bid teto aukce: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Nelze bidovat s vyssim bidem: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Nelze bidovat s mensim bidem: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Nelze bidovat na vlastni aukci: %s (x%d)";
		UiProcessingBidRequests	= "Provadim bidovaci pozadavek...";


		-- Section: Command Messages
		FrmtActClearall	= "Mazu vsechna aukcni data k %s";
		FrmtActClearFail	= "Nelze najit objekt: %s";
		FrmtActClearOk	= "Smazana data k objektu: %s";
		FrmtActClearsnap	= "Mazu cely posledni zaznam z AH.";
		FrmtActDefault	= "Obnoveno vychozi nastaveni pro %s ";
		FrmtActDefaultall	= "Obnovuji defaultni hodnoty VSECH Auctioneer nastaveni.";
		FrmtActDisable	= "Nezobrazuji %s data";
		FrmtActEnable	= "Zobrazuji %s data";
		FrmtActSet	= "Nastavuji %s na '%s'";
		FrmtActUnknown	= "Neznamy prikaz: '%s'";
		FrmtAuctionDuration	= "Zakladni trvani aukce nastaveno na: %s";
		FrmtAutostart	= "Auto-cena nastavena: %s naBIDka a %s Vykup (%dh)\n%s";
		FrmtFinish	= "Po skonceni skenu bude %s";
		FrmtPrintin	= "Zpravy z Auctioneeru se nyni budou zobrazovat v okne \"%s\"";
		FrmtProtectWindow	= "Ochrana AH okna proti zavreni nastavena na: %s";
		FrmtUnknownArg	= "'%s'neni platna hodnota pro '%s'";
		FrmtUnknownLocale	= "Zadany jazyk ('%s') je neznamy. Dostupne jsou:";
		FrmtUnknownRf	= "Neznamy parametr ('%s'). Platny format je: [server]-[strana]. Napriklad: Shadow Moon-Horde";


		-- Section: Command Options
		OptAlso	= "(server-frakce|protivnik)";
		OptAuctionDuration	= "(trvani||2h||8h||24h)";
		OptBidbroker	= "<stribro_zisk>";
		OptBidLimit	= "<cislo>";
		OptBroker	= "<stribro_zisk>";
		OptClear	= "([Objekt]|vse|zaznam)";
		OptCompete	= "<stribro_mene>";
		OptDefault	= "(<nastaveni>|vse)";
		OptFinish	= "(off|logout|exit|reloadui)";
		OptLocale	= "<jazyk>";
		OptPctBidmarkdown	= "<procent>";
		OptPctMarkup	= "<procent>";
		OptPctMaxless	= "<procent>";
		OptPctNocomp	= "<procent>";
		OptPctUnderlow	= "<procento>";
		OptPctUndermkt	= "<procent>";
		OptPercentless	= "<procent>";
		OptPrintin	= "(<oknoIndex>[Cislo]|<oknoJmeno>[String])";
		OptProtectWindow	= "(nikdy||sken||vzdy)";
		OptScale	= "<rozmer_nasobek>";
		OptScan	= "<sken_parametr>";


		-- Section: Commands
		CmdAlso	= "take";
		CmdAlsoOpposite	= "protistrana";
		CmdAlt	= "Alt";
		CmdAskPriceAd	= "oznameni";
		CmdAskPriceGuild	= "guilda";
		CmdAskPriceParty	= "parta";
		CmdAskPriceSmart	= "chytre";
		CmdAskPriceSmartWord1	= "co";
		CmdAskPriceSmartWord2	= "cenny";
		CmdAskPriceTrigger	= "spoustec";
		CmdAskPriceVendor	= "vendor";
		CmdAuctionClick	= "aukcni-klik";
		CmdAuctionDuration	= "trvani-aukce";
		CmdAuctionDuration0	= "posledni";
		CmdAuctionDuration1	= "2hod";
		CmdAuctionDuration2	= "8hod";
		CmdAuctionDuration3	= "24hod";
		CmdAutofill	= "autoceny";
		CmdBidbroker	= "bidfiltr";
		CmdBidbrokerShort	= "bf";
		CmdBidLimit	= "bid-limit";
		CmdBroker	= "filtr";
		CmdClear	= "smazat";
		CmdClearAll	= "vse";
		CmdClearSnapshot	= "zapomen";
		CmdCompete	= "konkurfiltr";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "vychozi";
		CmdDisable	= "deaktivovat";
		CmdEmbed	= "integrovat";
		CmdFinish	= "dokonci";
		CmdFinish0	= "vypni";
		CmdFinish1	= "logout";
		CmdFinish2	= "quit";
		CmdFinish3	= "realoadui";
		CmdHelp	= "pomoc";
		CmdLocale	= "jazyk";
		CmdOff	= "vypnout";
		CmdOn	= "zapnout";
		CmdPctBidmarkdown	= "proc-snizit";
		CmdPctMarkup	= "proc-zvysit";
		CmdPctMaxless	= "proc-maxztr";
		CmdPctNocomp	= "proc-bezkonkr";
		CmdPctUnderlow	= "proc-nejsleva";
		CmdPctUndermkt	= "proc-podtrhem";
		CmdPercentless	= "procfiltr";
		CmdPercentlessShort	= "pf";
		CmdPrintin	= "zobrazovat-v";
		CmdProtectWindow	= "ochran-okno";
		CmdProtectWindow0	= "nikdy";
		CmdProtectWindow1	= "sken";
		CmdProtectWindow2	= "vzdy";
		CmdScan	= "skenuj";
		CmdShift	= "Shift";
		CmdToggle	= "prepnout";
		CmdUpdatePrice	= "update-cena";
		CmdWarnColor	= "varovat-barva";
		ShowAverage	= "zobraz-prumer";
		ShowEmbedBlank	= "integruj-oddelovac";
		ShowLink	= "zobraz-linky";
		ShowMedian	= "zobraz-stred";
		ShowRedo	= "zobraz-varovani";
		ShowStats	= "zobraz-statistiky";
		ShowSuggest	= "zobraz-doporuceni";
		ShowVerbose	= "zobraz-podrobnosti";


		-- Section: Config Text
		GuiAlso	= "Take zobraz data o";
		GuiAlsoDisplay	= "Zobrazuji data o %s";
		GuiAlsoOff	= "Nezobrazuji data o jinych serverech/frakcich.";
		GuiAlsoOpposite	= "Zobrazuji take data o protistrane.";
		GuiAskPrice	= "Zapnout AskPrice";
		GuiAskPriceAd	= "Zaslat data ";
		GuiAskPriceGuild	= "Odpovedet na guildchat";
		GuiAskPriceHeader	= "AskPrice nastaveni";
		GuiAskPriceHeaderHelp	= "Zmenit AskPrice chovani";
		GuiAskPriceParty	= "Odpovedet na partychat";
		GuiAskPriceSmart	= "Pouzit chytra slova";
		GuiAskPriceTrigger	= "AskPrice prepinac";
		GuiAskPriceVendor	= "Zaslat info o vendorovi";
		GuiAuctionDuration	= "Zakladni trvani aukce";
		GuiAuctionHouseHeader	= "Aukci Dum - nastaveni";
		GuiAuctionHouseHeaderHelp	= "Tato nastaveni ovlivnuji fungovani Aukcniho Domu";
		GuiAutofill	= "Automaticke zadavani cen v Aukci";
		GuiAverages	= "Zobraz prumery";
		GuiBidmarkdown	= "Procento z ceny";
		GuiClearall	= "Smaz vsechny Auctioneer zaznamy";
		GuiClearallButton	= "Smaz Vse";
		GuiClearallHelp	= "Klikni zde pro smazani vsech zaznamu pro zvoleny server";
		GuiClearallNote	= "pro zvoleny server a frakci.";
		GuiClearHeader	= "Mazani zaznamu";
		GuiClearHelp	= "Smaze Auctioneerovi zaznamy. Vyberte - vse, nebo posledni zaznam. POZOR: Smazana data nelze obnovit.";
		GuiClearsnap	= "Smazat posledni zaznam";
		GuiClearsnapButton	= "Smazat zaznam";
		GuiClearsnapHelp	= "Klikni zde pro smazani posledniho Auctioneer zaznamu.";
		GuiDefaultAll	= "Obnov vsechna vychozi Auctioneer nastaveni.";
		GuiDefaultAllButton	= "Obnov vse";
		GuiDefaultAllHelp	= "Klikni zde pro navrat vsech Auctioneer nastaveni na vychozi hodnoty. POZOR: Nelze vratit! ";
		GuiDefaultOption	= "Obnov vychozi nastaveni";
		GuiEmbed	= "Integrovane statistiky v popiskach objektu";
		GuiEmbedBlankline	= "Integruj oddelovac do popisek objektu";
		GuiEmbedHeader	= "Integrace";
		GuiFinish	= "Po skonceni scanu";
		GuiLink	= "Zobraz cislo linku";
		GuiLoad	= "Spust Auctioneer";
		GuiLoad_Always	= "vzdy";
		GuiLoad_AuctionHouse	= "v Aukcnim Dome";
		GuiLoad_Never	= "nikdy";
		GuiLocale	= "Nastavit jazyk na";
		GuiMainEnable	= "Spustit Auctioneer";
		GuiMainHelp	= "Obsahuje nastaveni pro Auctioneer - AddOn ktery sbira a zobrazuje informace z aukce ohledne cen. Klikni na \"Sken\" v Aukci pro zaznamenani aktualnich statistik. ";
		GuiMarkup	= "Procento navyseni vendor ceny";
		GuiMaxless	= "Nejvyssi mozna sleva vuci trzni cene";
		GuiMedian	= "Zobrazuj stredni hodnoty";
		GuiNocomp	= "Neni konkurence - nelze slevit";
		GuiNoWorldMap	= "Auctioneer: Protekce Aukce - Zablokovano otevreni mapy!";
		GuiOtherHeader	= "Dalsi nastaveni";
		GuiOtherHelp	= "Rozlicna Auctioneer nastaveni ";
		GuiPercentsHeader	= "Procentuelne limitujici nastaveni";
		GuiPercentsHelp	= "POZOR: Nasledujici nastaveni urcuji trzni strategii nastavovani cen pomoci Auctioneeru. Jakekoliv zmeny proto zvazte, nejste-li zkuseni hraci a ekonomove.";
		GuiPrintin	= "Vyber textove okno";
		GuiProtectWindow	= "Ochran Aukci proti nechtenemu zavreni";
		GuiRedo	= "Zobraz varovani zasekleho skenu";
		GuiReloadui	= "Znovu nahraj interface\n";
		GuiReloaduiButton	= "NahrajInterface";
		GuiReloaduiFeedback	= "Nahravam interface";
		GuiReloaduiHelp	= "Klikni zde pro opetovne nahrani herniho interface vcetne zvoleneho jazyka. Nahravani muze trvat nekolik minut.";
		GuiRememberText	= "Ukladej ceny";
		GuiStatsEnable	= "Zobrazuj statistiky";
		GuiStatsHeader	= "Statistiky cen objektu";
		GuiStatsHelp	= "Zobrazuj tyto statistiky v popiskach";
		GuiSuggest	= "Zobrazuj doporucene ceny";
		GuiUnderlow	= "Nejnizsi zlevneni trzni ceny";
		GuiUndermkt	= "Krizova sleva z trzni ceny pro pripad ze \"maxztrata\" nestaci";
		GuiVerbose	= "Podrobny mod";
		GuiWarnColor	= "Barevny cenovy model";


		-- Section: Conversion Messages
		MesgConvert	= "Prevod Auctioneer databaze. Nejdriv si prosim zalohujte soubor SavedVariables\Auctioneer.lua first.%s%s";
		MesgConvertNo	= "Vypnout Auctioneer";
		MesgConvertYes	= "Prevest";
		MesgNotconverting	= "Neprevedli jste vasi databazi, Auctioneer ale nebude fungovat dokud tak neucinite. ";


		-- Section: Game Constants
		TimeLong	= "Dlouze";
		TimeMed	= "Stredne";
		TimeShort	= "Kratce";
		TimeVlong	= "Velmi douze";


		-- Section: Generic Messages
		DisableMsg	= "Deaktivuji automaticke zapinani Auctioneeru";
		FrmtWelcome	= "Auctioneer v%s poprve spusten, pripraven k akci!";
		MesgNotLoaded	= "Auctioneer neni spusten. Zadejte /auctioneer pro vice informaci. ";
		StatAskPriceOff	= "AskPrice je vypnut";
		StatAskPriceOn	= "AskPrice je zapnut";
		StatOff	= "Nezobrazuji zadna data.";
		StatOn	= "Zobrazuji (vami) nastavene polozky.";


		-- Section: Generic Strings
		TextAuction	= "Aukce";
		TextCombat	= "Boj";
		TextGeneral	= "Hlavni";
		TextNone	= "nic";
		TextScan	= "Sken\n";
		TextUsage	= "Uziti:";


		-- Section: Help Text
		HelpAlso	= "Prikaz Also zobrazi do popisku statistiky platne pro JINY server. Server a frakci zvolite zadanim nazvu nebo slovem \"protistrana\". Pouziti: /auctioneer also Shadow Moon-Horde.";
		HelpAskPrice	= "Zapnout nebo vypnout AskPrice.";
		HelpAskPriceAd	= "Zapnout nebo vypnout nove schopnosti AskPrice";
		HelpAskPriceGuild	= "Odpovedet na dotazy v guild chatu.";
		HelpAskPriceParty	= "Odpovedet na dotazy v party chatu.";
		HelpAskPriceSmart	= "Zapnout nebo vypnout kontrolu SmartWords.";
		HelpAskPriceTrigger	= "Zmenit znak, ktery spousti AskPrice.";
		HelpAskPriceVendor	= "Zapnout nebo vypnout odesilani dat o cenach u prodavacu.";
		HelpAuctionClick	= "Umoznuje automaticky vlozit objekt z inventare do aukce pomoci Alt-Kliku.";
		HelpAuctionDuration	= "Pri otevreni Aukce nastavi zvolenou vychozi hodnotu jejiho trvani. ";
		HelpAutofill	= "Nastavi zda ma Auctioneer vyplnit doporucene ceny pri vytvareni aukce (ty vzdy lze zmenit)";
		HelpAverage	= "Nastavi zda se maji zobrazovat prumerne aukci ceny";
		HelpBidbroker	= "Zobrazi kratke a stredni aukce z posledniho zaznamu jejichz momentalni nabidka je pod cenou a tak na nich lze vydelat";
		HelpBidLimit	= "Maximalni pocet aukci, na ktere se da bidovat nebo buyoutovat, kdyz stisknete Bid nebo Buyout tlacitko na Search Auctions karte.";
		HelpBroker	= "Zobrazi vsechny aukce z posledniho zaznamu, ktere koupene za momentalni naBIDku lze pozdeji prodat se ziskem";
		HelpClear	= "Smaze zaznamy k vybranemu objektu (objekt vlozite do prikazu Shift-Klikem) nebo zadanim \"vse\" nebo jen posledni \"zaznam\". ";
		HelpCompete	= "Zobrazi vsechny aukce z posledniho zaznamu, jejichz Vykupni cena je nizsi, nez ta vase za stejny predmet";
		HelpDefault	= "Obnovi vychozu hodnotu zvoleneho nastaveni Auctioneeru. Take lze zadat \"vse\" pro obnoveni vsech nastaveni na vychozi hodnoty. ";
		HelpDisable	= "Deaktivuje automaticke zapinani Auctioneeru pri pristim prihlaseni ";
		HelpEmbed	= "Prida/integruje Auctioneer statistiky do puvodniho popisku objektu (ale nektere moznosti jsou v tomto modu nedostupne)";
		HelpEmbedBlank	= "Nastavi zda se ma zobrazovat prazdny radek mezi puvodnim popiskem predmetu a pridanymi statistikami, jsou-li integrovane do popisku objektu";
		HelpFinish	= "Nastavit, jestli automaticky odhlasit nebo vypnout hru po ukonceni skenovani aukci";
		HelpLink	= "Nastavi zda se ma zobrazovat ID/cislo linku objektu do popisku";
		HelpLoad	= "Zmeni zapinani Auctioneeru pro tuto postavu";
		HelpLocale	= "Zmeni jazyk, v jakem s vami Auctioneer komunikuje";
		HelpMedian	= "Nastavi zda se ma zobrazovat \"median\" vykupni cena predmetu";
		HelpOnoff	= "Zapne nebo vypne zobrazovani ziskanych cenovych zaznamu";
		HelpPctBidmarkdown	= "Nastavi procento Vykupni ceny, podle ktereho se urci pocatecni nabidka";
		HelpPctMarkup	= "Nastavi procento, o ktere se nadsadi vykupni cena v obchode, nejsou-li k dispozici jine udaje";
		HelpPctMaxless	= "Nastavi maximalni procento, o ktere se Auctioneer pokusi slevit z bezne trzni ceny";
		HelpPctNocomp	= "Nastavi procento o ktere Auctioneer slevi z bezne trzni ceny, kdyz neexistuje konkurence";
		HelpPctUnderlow	= "Nastavi procento, o ktere ma Auctioneer \"podrazit\" nejnizsi cenu daneho objektu v aktualnim zaznamu";
		HelpPctUndermkt	= "Procento slevy z trzni ceny pro prekonani konkurence kdyz rozdil prekonal \"maxztrata\" limit";
		HelpPercentless	= "Zobrazi vsechny aukce z posledniho zaznamu, jejichz vykupni cena je o urcene procento nizsi, nez jejich zaznamenana nejvyssi uspesna vykupni cena";
		HelpPrintin	= "Nastavi v kterem okne ma Auctioneer vypisovat zpravy. Muzete zvolit jmeno okna nebo jeho index.";
		HelpProtectWindow	= "Zabrani nechtenemu zavreni Aukcniho okna";
		HelpRedo	= "Nastavi zda se ma zobrazovat varovani, kdyz nacitani aktualni aukcni stranky trva prilis dlouho kvuli pretizeni serveru.";
		HelpScan	= "Provede sken vybrannych aukci pri vasi pristi navsteve, nebo hned (take je zde \"sken\" tlacitko v aukcnim okne). Zaskrtnete ktere kategorie chcete naskenovat.";
		HelpStats	= "Nastavi zda se ma zobrazovat procenta u nabidky a vykupni ceny";
		HelpSuggest	= "Nastavi zda se ma zobrazovat doporucena aukci cena";
		HelpUpdatePrice	= "Automaticky updatuje pocatecni cenu pro aukci na tabulce Podavani aukci, pri zmene Vykupni ceny.";
		HelpVerbose	= "Nastavi zda se maji zobrazovat detailni prumerne a doporucene ceny (\"vypnuto\" znamena ze se budou zobrazovat v jednom radku)";
		HelpWarnColor	= "Vyber jestli ukazovat aktualni AH cenovy model v intuitivnich barvach.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Zadne volne pack misto pro vytvoreni aukce!";
		FrmtNotEnoughOfItem	= "Nedostatek %s penez pro vytvoreni aukce!";
		FrmtPostedAuction	= "Podana 1 aukce %s (x%d)";
		FrmtPostedAuctions	= "Podano %d aukci %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "tedNabidka";
		FrmtBidbrokerDone	= "Vypis nabidek dokoncen";
		FrmtBidbrokerHeader	= "Minimalni zisk: %s, NDC = 'Nejvyssi Dosazitelna Cena'";
		FrmtBidbrokerLine	= "%s, poslecnich %s zaznamenanych, NDC: %s, %s: %s, Zisk: %s, Cas: %s";
		FrmtBidbrokerMinbid	= "minNabidka";
		FrmtBrokerDone	= "Vypis dokoncen";
		FrmtBrokerHeader	= "Minimalni zisk: %s, NDC = 'Nejvyssi Dosazitelna Cena'";
		FrmtBrokerLine	= "%s, poslednich %s zaznamenanych, NDC: %s, Vykup: %s, zisk: %s";
		FrmtCompeteDone	= "Prebijeni aukci dokonceno";
		FrmtCompeteHeader	= "Prebit aukce alespon o %s za 1 kus.";
		FrmtCompeteLine	= "%s, Nabidka: %s, Vykup %s vs %s, %s levnejsi";
		FrmtHspLine	= "Nejvyssi Dosazitelna Cena za jeden %s je: %s";
		FrmtLowLine	= "%s, Vykup: %s, Prodejce: %s, Za jeden: %s, Mene nez median: %s";
		FrmtMedianLine	= "U poslednich %d zaznamenanych, median Vykup za 1 kus %s je: %s";
		FrmtNoauct	= "Nenalezeny zadne aukce predmetu: %s";
		FrmtPctlessDone	= "Vypis \"percentless\" dokoncen. ";
		FrmtPctlessHeader	= "Procentuelni rozdil od Nejvyssi Dosazitelne Ceny (NDC): %d%%";
		FrmtPctlessLine	= "%s, Poslednich %d zaznamenanych, NDC: %s, Vykup: %s, Zisk: %s, Levnejsi %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Neplatnych aukci odstraneno: %s";
		AuctionDiscrepancies	= "Odlisnosti: %s";
		AuctionNewAucts	= "Novych aukci zaznamenano: %s";
		AuctionOldAucts	= "Jiz drive zaznamenanych: %s";
		AuctionPageN	= "Auctioneer: skenuji %s, stranu %d z %d Aukci za vterinu: %s Odhadovany cas do konce: %s";
		AuctionScanDone	= "Auctioneer: Skenovani aukci ukonceno.";
		AuctionScanNexttime	= "Auctioneer provede kompletni sken aukci pri pristi navsteve.";
		AuctionScanNocat	= "Musi byt vybrana alespon jedna kategorie.";
		AuctionScanRedo	= "Posledni strana trvala pres %d vterin, zkousim to znovu...";
		AuctionScanStart	= "Auctioneer: Skenuji prvni stranu %s...";
		AuctionTotalAucts	= "Celkem zaznamenano aukci: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Videno %d -krat na %s";
		FrmtInfoAverage	= "%s min/%s Vykup (%s nabidka)";
		FrmtInfoBidMulti	= "Nabidnuto (%s%s za kus)";
		FrmtInfoBidOne	= "Nabidnuto %s";
		FrmtInfoBidrate	= "%d%% ma nabidku, %d%% ma Vykup";
		FrmtInfoBuymedian	= "Median vykup ";
		FrmtInfoBuyMulti	= "Vykup (%s%s za kus)";
		FrmtInfoBuyOne	= "Vykup %s";
		FrmtInfoForone	= "Za 1: %s min/%s Vykup (%s nabidka) [v %d's]";
		FrmtInfoHeadMulti	= "Prumery pro %d predmetu: ";
		FrmtInfoHeadOne	= "Prumery pro tento predmet: ";
		FrmtInfoHistmed	= "Poslednich %d, median vykup za kus";
		FrmtInfoMinMulti	= "Prvni nabidka (%s za kus)";
		FrmtInfoMinOne	= "Prvni nabidka";
		FrmtInfoNever	= "Nikdy nezaznamenano na %s";
		FrmtInfoSeen	= "Zaznamenano %d-krat na aukci";
		FrmtInfoSgst	= "Doporucena cena: %s min/%s Vykup";
		FrmtInfoSgststx	= "Doporucena cena za vasi %d sadu: %s min/%s Vykup";
		FrmtInfoSnapmed	= "Zaznamenano %d, stredni Vykup (za kus)";
		FrmtInfoStacksize	= "Prumerna velikost sady: %d objektu";


		-- Section: User Interface
		UiBid	= "Bid";
		UiBidHeader	= "Bid";
		UiBidPerHeader	= "Bid per";
		UiBuyout	= "BO";
		UiBuyoutHeader	= "BO";
		UiBuyoutPerHeader	= "BO per";
		UiBuyoutPriceLabel	= "BO cena";
		UiBuyoutPriceTooLowError	= "(Prilis nizke)";
		UiCategoryLabel	= "Omezeni kategorii";
		UiDepositLabel	= "Zaloha:";
		UiDurationLabel	= "Trvani:";
		UiItemLevelHeader	= "Lvl";
		UiMakeFixedPriceLabel	= "Zafixuj cenu";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Nejvyssi cena:";
		UiMaximumTimeLeftLabel	= "Maximalni zbyvajici doba:";
		UiMinimumPercentLessLabel	= "Nejmensi procentualni rozdil:";
		UiMinimumProfitLabel	= "Nejmensi profit:";
		UiMinimumQualityLabel	= "Nejnizsi kvalita:";
		UiMinimumUndercutLabel	= "Nejmensi prebiti:";
		UiNameHeader	= "Jmeno";
		UiNoPendingBids	= "Vsechny pozadovane nabidky dokonceny!";
		UiNotEnoughError	= "(nedostatek)";
		UiPendingBidInProgress	= "1 pozadavek na nabidku se zpracovava...";
		UiPendingBidsInProgress	= "%d pozadavku na nabidky se zpracovava...";
		UiPercentLessHeader	= "Pct";
		UiPost	= "Podat";
		UiPostAuctions	= "Podat aukci";
		UiPriceBasedOnLabel	= "Cena zalozena na:";
		UiPriceModelAuctioneer	= "Auctioneer cena";
		UiPriceModelCustom	= "Vlastni cena";
		UiPriceModelFixed	= "Pevna cena";
		UiProfitHeader	= "Zisk";
		UiProfitPerHeader	= "Zisk za kus";
		UiQuantityHeader	= "Pocet";
		UiQuantityLabel	= "Mnozstvi:";
		UiRemoveSearchButton	= "Smazat";
		UiSavedSearchLabel	= "Ulozena vyhledavani:";
		UiSaveSearchButton	= "Ulozit";
		UiSaveSearchLabel	= "Ulozit toto vyhledavani:";
		UiSearch	= "Hledat";
		UiSearchAuctions	= "Prohledat aukce";
		UiSearchDropDownLabel	= "Hledat:";
		UiSearchForLabel	= "Vyhledat predmet:";
		UiSearchTypeBids	= "NaBIDky";
		UiSearchTypeBuyouts	= "Vykupy";
		UiSearchTypeCompetition	= "Konkurence";
		UiSearchTypePlain	= "Predmet";
		UiStacksLabel	= "Sady";
		UiStackTooBigError	= "(Sada je prilis velka)";
		UiStackTooSmallError	= "(Sada je prilis mala)";
		UiStartingPriceLabel	= "Vychozi cena:";
		UiStartingPriceRequiredError	= "(Nutne)";
		UiTimeLeftHeader	= "Zbyvajici cas";
		UiUnknownError	= "(tajuplna chyba)";

	};

	daDK = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Hent stak priser for %sx[ItemLink] (x = stacksize) ";
		FrmtAskPriceBuyoutMedianHistorical	= "%sOpk\195\184bs-median historisk: %s%s ";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sOpk\195\184bs-median ved sidste skanning: %s%s";
		FrmtAskPriceDisable	= "Deaktiver AskPrices %s funktionen";
		FrmtAskPriceEach	= "(%s pr. stk.)";
		FrmtAskPriceEnable	= "Aktiverer AskPrices %s funktionen";
		FrmtAskPriceVendorPrice	= "%sS\195\166lg til forhandler for: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Fjerner auktion %s fra nuv\195\166rende Auktionshus snapshot.";
		FrmtAuctinfoHist	= "%d historisk";
		FrmtAuctinfoLow	= "Mindste pris";
		FrmtAuctinfoMktprice	= "Markedspris";
		FrmtAuctinfoNolow	= "Ikke set ved sidste skanning";
		FrmtAuctinfoOrig	= "Oprindeligt bud";
		FrmtAuctinfoSnap	= "%d sidste scanning";
		FrmtAuctinfoSugbid	= "Foresl\195\165et startbud";
		FrmtAuctinfoSugbuy	= "Foresl\195\165et opk\195\184bspris";
		FrmtWarnAbovemkt	= "Konkurrence ligger over markedet";
		FrmtWarnMarkup	= "Overbyder forhandlere med %s%%";
		FrmtWarnMyprice	= "Bruger min nuv\195\166rende pris";
		FrmtWarnNocomp	= "Ingen konkurrence";
		FrmtWarnNodata	= "Ingen data for HSP";
		FrmtWarnToolow	= "Kan ikke konkurrere med laveste pris";
		FrmtWarnUndercut	= "Underbyder med %s%%";
		FrmtWarnUser	= "Anvender brugerdefineret pris";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Allerede den h\195\184jestbydende p\195\165 auktion: %s (x%d)";
		FrmtBidAuction	= "Byd p\195\165 auktion: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Fejl: Bud k\195\184 ude af synkronisering!";
		FrmtBoughtAuction	= "Opk\195\184bt auktion: %s (x%d)";
		FrmtMaxBidsReached	= "Flere auktioner af %s (x%d) fundet, men bud gr\195\166nse n\195\165et (%d)";
		FrmtNoAuctionsFound	= "Ingen auktioner fundet: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "Ikke flere auktioner fundet: %s (x%d)";
		FrmtNotEnoughMoney	= "Ikke nok penge til at byde p\195\165 auktion: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Sprang over auktion med h\195\184jere bud: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Sprang over auktion med lavere bud: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Sprang over egen auktion: %s (x%d)";
		UiProcessingBidRequests	= "Bearbejder bud foresp\195\184rgelser...";


		-- Section: Command Messages
		FrmtActClearall	= "Fjerner alle data for auktionen %s";
		FrmtActClearFail	= "Kan ikke finde genstand: %s";
		FrmtActClearOk	= "Fjerner data for genstand: %s";
		FrmtActClearsnap	= "Fjerner nuv\195\166rende Auktionhus data.";
		FrmtActDefault	= "Auctioneers %s indstillinger er blevet nulstillet til standard v\195\166rdier";
		FrmtActDefaultall	= "Alle Auctioneers indstillinger er blevet nulstillet til standard v\195\166rdier.";
		FrmtActDisable	= "Viser ikke data for: %s ";
		FrmtActEnable	= "Viser data for: %s ";
		FrmtActSet	= "S\195\166tter %s til '%s'";
		FrmtActUnknown	= "Ukendt kommando eller n\195\184gleord: '%s'";
		FrmtAuctionDuration	= "Normal auktions tid sat til: %s";
		FrmtAutostart	= "Starter automatisk auktion for %s minimum, %s opk\195\184b (%dh)\n%s";
		FrmtFinish	= "Efter en scanning er afsluttet, skal vi %s";
		FrmtPrintin	= "Auctioneers beskeder vil nu blive skrevet til \"%s\" chat ramme";
		FrmtProtectWindow	= "Auktionshus vinduebeskyttelse sat til: %s";
		FrmtUnknownArg	= "'%s' er ikke et gyldigt argument for '%s'";
		FrmtUnknownLocale	= "Sproget du har angivet: ('%s') er ukendt. Gyldige sprog er:";
		FrmtUnknownRf	= "Ugyldig parameter ('%s'). Parameteret skal se s\195\165dan ud: [realm]-[faction]. Eksempelvis: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(realm-faction|modsat|hjemme|neutral)";
		OptAuctionDuration	= "(sidst||2t||8t||24t)";
		OptBidbroker	= "<fortjeneste_i_s\195\184lv>";
		OptBidLimit	= "<nummer>";
		OptBroker	= "<fortjeneste_i_s\195\184lv>";
		OptClear	= "([Genstand]alt|snapshot)";
		OptCompete	= "<s\195\184lv_under>";
		OptDefault	= "(<Indstilling>|alt)";
		OptFinish	= "(sluk|log af|slut|genindl\195\166sUI) ";
		OptLocale	= "<lokal>";
		OptPctBidmarkdown	= "<procent>";
		OptPctMarkup	= "<procent>";
		OptPctMaxless	= "<procent>";
		OptPctNocomp	= "<procent>";
		OptPctUnderlow	= "<procent>";
		OptPctUndermkt	= "<procent>";
		OptPercentless	= "<procent>";
		OptPrintin	= "(<frameIndex>[Nummer]|<frameNavn>[Streng]) ";
		OptProtectWindow	= "(aldrig|scan|altid) ";
		OptScale	= "<skalerings_faktor>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "ogs\195\165";
		CmdAlsoOpposite	= "modsatte";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "reklame";
		CmdAskPriceGuild	= "guild";
		CmdAskPriceParty	= "gruppe";
		CmdAskPriceSmart	= "smart";
		CmdAskPriceSmartWord1	= "Hvad";
		CmdAskPriceSmartWord2	= "v\195\166rd";
		CmdAskPriceTrigger	= "udl\195\184ser";
		CmdAskPriceVendor	= "forhandler";
		CmdAuctionClick	= "auktion-klik";
		CmdAuctionDuration	= "Auktionsvarighed";
		CmdAuctionDuration0	= "sidst";
		CmdAuctionDuration1	= "2t";
		CmdAuctionDuration2	= "8t";
		CmdAuctionDuration3	= "24t";
		CmdAutofill	= "auto udfyld";
		CmdBidbroker	= "bidbroker";
		CmdBidbrokerShort	= "bb";
		CmdBidLimit	= "bud-gr\195\166nse";
		CmdBroker	= "broker";
		CmdClear	= "ryd";
		CmdClearAll	= "alt";
		CmdClearSnapshot	= "billede";
		CmdCompete	= "konkurrere";
		CmdCtrl	= "ctrl";
		CmdDefault	= "standard";
		CmdDisable	= "sl\195\165 fra";
		CmdEmbed	= "indkapsle";
		CmdFinish	= "f\195\166rdig";
		CmdFinish0	= "sluk";
		CmdFinish1	= "log af";
		CmdFinish2	= "luk";
		CmdFinish3	= "genindl\195\166sUI";
		CmdHelp	= "hj\195\166lp";
		CmdLocale	= "lokal";
		CmdOff	= "sluk";
		CmdOn	= "t\195\166nd";
		CmdPctBidmarkdown	= "pct-bidmarkdown ";
		CmdPctMarkup	= "pct-markup ";
		CmdPctMaxless	= "pct-maxless ";
		CmdPctNocomp	= "pct-nocomp ";
		CmdPctUnderlow	= "pct-underlow ";
		CmdPctUndermkt	= "pct-undermkt ";
		CmdPercentless	= "percentless ";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "print-til";
		CmdProtectWindow	= "beskyt-vindue";
		CmdProtectWindow0	= "aldrig";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "altid";
		CmdScan	= "scan";
		CmdShift	= "skift";
		CmdToggle	= "t\195\166nd/sluk";
		CmdUpdatePrice	= "opdater-pris";
		CmdWarnColor	= "advarsels-farve";
		ShowAverage	= "vis-gennemsnit";
		ShowEmbedBlank	= "vis-indkapsle-blanklinje";
		ShowLink	= "vis-link";
		ShowMedian	= "vis-median";
		ShowRedo	= "vis-advarsel";
		ShowStats	= "vis-stats";
		ShowSuggest	= "vis-forslag";
		ShowVerbose	= "vis-ordrig";


		-- Section: Config Text
		GuiAlso	= "Vis ogs\195\165 data for";
		GuiAlsoDisplay	= "Viser data for %s";
		GuiAlsoOff	= "Viser ikke l\195\166ngere data fra andre realm-fraktioner.";
		GuiAlsoOpposite	= "Viser nu ogs\195\165 data for modsatte fraktion.";
		GuiAskPrice	= "Sl\195\165 AskPrice til";
		GuiAskPriceAd	= "Send reklame for egenskaber";
		GuiAskPriceGuild	= "Svar p\195\165 guildchat foresp\195\184rgsler";
		GuiAskPriceHeader	= "AskPrice indstillinger";
		GuiAskPriceHeaderHelp	= "Skift AskPrices opf\195\184rsel";
		GuiAskPriceParty	= "Svar p\195\165 partychat foresp\195\184rgsler";
		GuiAskPriceSmart	= "Brug smarte ord";
		GuiAskPriceTrigger	= "AskPrice udl\195\184ser";
		GuiAskPriceVendor	= "Send forhandler informationer";
		GuiAuctionDuration	= "Normal auktions varighed";
		GuiAuctionHouseHeader	= "Auktionshus vindue";
		GuiAuctionHouseHeaderHelp	= "\195\134ndr Auktionshusets vinduesindstillinger";
		GuiAutofill	= "Autoudfyld priser i Auktionshuset";
		GuiAverages	= "Vis middel";
		GuiBidmarkdown	= "Neds\195\166t bud med xx procent";
		GuiClearall	= "Ryd alle data fra Auctioneer";
		GuiClearallButton	= "Ryd alt";
		GuiClearallHelp	= "Klik her for at fjerne alle data fra Auctioneer for den nuv\195\166rende server-realm.";
		GuiClearallNote	= "for den nuv\195\166rende server-fraktion";
		GuiClearHeader	= "Ryd data";
		GuiClearHelp	= "Ryd Auctioneer data. \nV\195\166lg alle data eller det nuv\195\166rende snapshot.\nADVARSEL: Disse handlinger kan IKKE fortrydes.";
		GuiClearsnap	= "Ryd Snapshotdata";
		GuiClearsnapButton	= "Fjern Snapshot";
		GuiClearsnapHelp	= "Klik her for at slette den sidste skanning af auktionen.";
		GuiDefaultAll	= "Nulstil alle Auctioneer indstillinger";
		GuiDefaultAllButton	= "Nulstil alt";
		GuiDefaultAllHelp	= "Klik her for at s\195\166tte alle Auctioneer valg til standard v\195\166rdier.\nADVARSEL: Denne handling kan IKKE fortrydes.";
		GuiDefaultOption	= "Nulstil denne ops\195\166tning.";
		GuiEmbed	= "Indrammet info i spillets tooltip";
		GuiEmbedBlankline	= "Viser blank linje i spillets tooltip";
		GuiEmbedHeader	= "Indrammet";
		GuiFinish	= "Efter en skanning er afsluttet";
		GuiLink	= "Viser LinkID";
		GuiLoad	= "Hent Auctioneer";
		GuiLoad_Always	= "altid";
		GuiLoad_AuctionHouse	= "ved Auktionshuset";
		GuiLoad_Never	= "aldrig";
		GuiLocale	= "S\195\166t sprog til";
		GuiMainEnable	= "Start Auctioneer";
		GuiMainHelp	= "Indeholder v\195\166rdier for Auctioneer. En AddOn som viser information om genstande og analysere auktionsdata. \nKlik p\195\165 \"Skan\" knappen p\195\165 Auktionshuset for at indsamle auktionsdata.";
		GuiMarkup	= "Procent overbud iht. forhandler";
		GuiMaxless	= "Procent maks. under markeds pris";
		GuiMedian	= "Vis medianer";
		GuiNocomp	= "Procent under markedets pris ved ingen konkurence";
		GuiNoWorldMap	= "Auctioneer: Undertrykker visningen af World Map";
		GuiOtherHeader	= "Andre indstillinger";
		GuiOtherHelp	= "Diverse indstillinger til Auctioneer";
		GuiPercentsHeader	= "Auctioneer graense procent";
		GuiPercentsHelp	= "Advarsel: De f\195\184lgende valgmuligheder er KUN for Superbrugere.\nVed at \195\166ndre p\195\165 f\195\184lgende muligheder \195\166ndrer du hvor aggresivt Auctioneer vil v\195\166re n\195\165r den udregner profit.";
		GuiPrintin	= "Vaelg den oenskede chat ramme.";
		GuiProtectWindow	= "Forhindrer lukning af Auktionshus vindue ved uheld";
		GuiRedo	= "Vis advarsel ved lang skanning.";
		GuiReloadui	= "Genindl\195\166ser brugerflade.";
		GuiReloaduiButton	= "Genindl\195\166sUI";
		GuiReloaduiFeedback	= "Genindl\195\166ser nu WoW UI";
		GuiReloaduiHelp	= "Klik her for at genindlaese WoW brugerfladen efter at have \195\166ndret sprog.\nBem\195\166rk: Dette kan tage et par minutter.";
		GuiRememberText	= "Husk prisen";
		GuiStatsEnable	= "Vis Statistik";
		GuiStatsHeader	= "Genstand Pris Statistik";
		GuiStatsHelp	= "Vis f\195\184lgende statistikker i tooltippet.";
		GuiSuggest	= "Vis foresl\195\165ede priser";
		GuiUnderlow	= "Laveste auktionspris";
		GuiUndermkt	= "Underbyd markedet n\195\165r der ingen maxpris findes.";
		GuiVerbose	= "Tekst Mode";
		GuiWarnColor	= "Farve Pris Model";


		-- Section: Conversion Messages
		MesgConvert	= "Konverterer Auctioneer Databasen. Tag venligst en backup af SavedVariables\\Auctioneer.lua inden.%s%s";
		MesgConvertNo	= "Indlaes ikke Auctioneer";
		MesgConvertYes	= "Konventer nu";
		MesgNotconverting	= "Auctioneer konventerer ikke din database, men vil ikke virke faar du goer.";


		-- Section: Game Constants
		TimeLong	= "Lang";
		TimeMed	= "Middel";
		TimeShort	= "Kort";
		TimeVlong	= "Meget Lang";


		-- Section: Generic Messages
		DisableMsg	= "Stopper automatisk indlaesning af Auctioneer";
		FrmtWelcome	= "Auctioneer v%s er indlaest";
		MesgNotLoaded	= "Auctioneer er ikke indlaest. Skriv /auctioneer for mere info.";
		StatAskPriceOff	= "AskPrice er nu deaktiveret.";
		StatAskPriceOn	= "AskPrice er nu aktiveret.";
		StatOff	= "Viser ikke nogen auktionsdata.";
		StatOn	= "Viser konfigureret auktionsdata.";


		-- Section: Generic Strings
		TextAuction	= "auktion";
		TextCombat	= "Kamp";
		TextGeneral	= "General";
		TextNone	= "ingen";
		TextScan	= "Scan";
		TextUsage	= "Brug:";


		-- Section: Help Text
		HelpAlso	= "Viser ogsaa en anden servers priser i tooltipet. For realm, indsaet realmnavnet og faction navnet. Som eksempel: \"/auctioneer also Al'Akir-Horde\". Det speciale noegleord \"opposite\" betyder den modstridne fraktion, \"off\" stopper denne funktion.";
		HelpAskPrice	= "Sl\195\165 AskPrice til eller fra";
		HelpAskPriceAd	= "Tillad eller bloker nye AskPrice funktions reklame.";
		HelpAskPriceGuild	= "Svarer p\195\165 en forsp\195\184rgelse lavet i guild chat.";
		HelpAskPriceParty	= "Svarer p\195\165 en forsp\195\184rgelse lavet i party chat.";
		HelpAskPriceSmart	= "Tillad eller bloker SmartWrods check";
		HelpAskPriceTrigger	= "\195\134ndre AskPrice's kommando.";
		HelpAskPriceVendor	= "Tillad eller bloker sendingen af vendor pris data.";
		HelpAuctionClick	= "Giver dig mulighed for at Alt-klikke paa et objekt i dine tasker for automatisk at starte en auktion for det";
		HelpAuctionDuration	= "Saet den normale auktions varighed ved aabning af AH vindue";
		HelpAutofill	= "Saet om Auctioneer skal autoudfylde priser naar objekter overfoeres til auktionshusets boks.";
		HelpAverage	= "Vaelger om middelprisen paa en auktion skal vises.";
		HelpBidbroker	= "Viser korte og middel auktioner som kan blive budt paa og solgt med fortjeneste.";
		HelpBidLimit	= "Maksimalt antal af auktion p\195\165 bud eller opk\195\184b n\195\165r Byd eller Opk\195\184b knappen er valgt p\195\165 S\195\184g Auktioner fanen";
		HelpBroker	= "Viser auktioner fra sidste scanning som kan blive opkoebt og solgt med fortjeneste.";
		HelpClear	= "Sletter data for et specifikt objekt (du skal shift-klikke p\195\165 objektet s\195\165 det kommer ned i kommando boxen.) Du kan ogs\195\165 specifisere enkelte n\195\184gle ord som \"all\" eller \"snapshot\"";
		HelpCompete	= "Viser objekter fra sidste skanning som har lavere opk\195\184bspris end dine ting.";
		HelpDefault	= "S\195\166tter Auctioneer til dens standard v\195\166rdi. Du kan eventuelt bruge n\195\184gleord som: \"all\" for at s\195\166tte alle valg til deres standard v\195\166rdier.";
		HelpDisable	= "Stopper Auctioneer s\195\165 det ikke indl\195\166ses automatisk n\195\166ste gang du logger ind.";
		HelpEmbed	= "Indrammer teksten i spillets egen tooltip (bem\195\166rk: nogle muligheder vil v\195\166re utilg\195\166ngelige i denne mode.)";
		HelpEmbedBlank	= "V\195\166lg om der skal v\195\166re blanke linjer mellem tooltip info og auktions info n\195\165r embedded mode er valgt";
		HelpFinish	= "set for automatisk logge ud eller exit spil ved auktions scan afslutning";
		HelpLink	= "V\195\166lger om der skal vises link id i tooltippet.";
		HelpLoad	= "\195\134ndre Auctioneers load indstillinger for denne karakter";
		HelpLocale	= "Skifter sprog p\195\165 auctioneer scriptet.";
		HelpMedian	= "V\195\166lger om der skal vises middel opk\195\184bspris.";
		HelpOnoff	= "Sl\195\165r visning af auktions data til og fra.";
		HelpPctBidmarkdown	= "S\195\166t procenter Auctioneer vil s\195\166tte prisen under objektets opk\195\184bspris.";
		HelpPctMarkup	= "Procenten som Auctioneer vil overbyde forhandleren p\195\165 et objekt hvor prisen ikke kendes.";
		HelpPctMaxless	= "S\195\131\194\166t den maksimale procent som Auctioneer vil g\195\131\194\165 under markeds v\195\131\194\166rdi inden den giver op.";
		HelpPctNocomp	= "Procenten Auctioneer vil g\195\131\194\165 under markedet pris n\195\131\194\165r der ikke findes konkurrenter";
		HelpPctUnderlow	= "S\195\131\194\166t procenter some Auctioneer vil g\195\131\194\165 under den laveste pris";
		HelpPctUndermkt	= "Procenter Auctioneer vil bruge hvis den ikke kan g\195\131\194\165 under konkurrenter (pga. maks/min)";
		HelpPercentless	= "Viser objekter fra sidste skanning hvis opk\195\131\194\184bspris er en bestemt procent lavere end den h\195\131\194\184jst s\195\131\194\166lgende pris.";
		HelpPrintin	= "V\195\166lg hvilken ramme Auctioneer vil skrive til. Du kan enten angive et ramme navn eller rammens indeks nummer.";
		HelpProtectWindow	= "Forhindrer dig i at lukke AH vinduet ved et uheld";
		HelpRedo	= "V\195\131\194\166lg om der skal vises en advarsel hvis den nuv\195\131\194\166rende skanning har taget for lang tid p\195\131\194\165 grund af server lag.";
		HelpScan	= "Udf\195\131\194\184rer en scan af auktionshuset n\195\131\194\166ste gang du bes\195\131\194\184ger det, eller mens du er der.(Der er ogs\195\131\194\165 en knap i auktionshuset under browse, der kan du ogs\195\131\194\165 v\195\131\194\166lge hvilke katagorier du \195\131\194\184nsker at skanne ved at bruge flueben..";
		HelpStats	= "Vaelger om der skal vises bud/opkoebs pris i procenter.";
		HelpSuggest	= "Vaelger om der skal vises foresl\195\165et salgspris ved auktion.";
		HelpUpdatePrice	= "Automatisk opdater start prisen for en auktion p\195\165 Post Auctions fanebladdet n\195\165r udk\195\184bsprisen \195\166ndres.";
		HelpVerbose	= "Vaelger hvordan teksten formuleres. (forslag, middelpriser eller off for at vise dem paa en enkelt linje.)";
		HelpWarnColor	= "V\195\166lg at vise den nuv\195\166rende AH pris model (Underbydde med...) i intuitive farver.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Ingen tomme pack rum fundet til at lave auktionen!";
		FrmtNotEnoughOfItem	= "Ikke nok %s fundet til at lave auktionen!";
		FrmtPostedAuction	= "(x%d) %s sat p\195\165 auktion";
		FrmtPostedAuctions	= "%d auktioner af (x%d) %s lavet";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "Nuvaerende bud";
		FrmtBidbrokerDone	= "Prisliste faerdig";
		FrmtBidbrokerHeader	= "Minimum profit: %s, HSP = 'Hoejeste Saelgende Pris'";
		FrmtBidbrokerLine	= "%s, sidst %s set, HSP: %s, %s: %s, Profit: %s, Tid: %s";
		FrmtBidbrokerMinbid	= "Mindste bud";
		FrmtBrokerDone	= "Liste faerdig.";
		FrmtBrokerHeader	= "Minimum profit: %s, HSP = 'Hoejeste Saelgende Pris'";
		FrmtBrokerLine	= "%s, Sidst %s set, HSP: %s, KoebNu: %s, Profit: %s";
		FrmtCompeteDone	= "Konkurerende auktioner er afsluttet";
		FrmtCompeteHeader	= "Konkurerende auktioner er mindst %s under pr. vare.";
		FrmtCompeteLine	= "%s, Bud: %s, BO %s mod %s, %s mindre";
		FrmtHspLine	= "H\195\131\194\184jeste S\195\131\194\166lgende Pris for en %s er: %s";
		FrmtLowLine	= "%s, BO: %s, s\195\131\194\166lger: %s, For en: %s, under middel: %s";
		FrmtMedianLine	= "Af sidste %d set, middel BO for 1 %s er: %s";
		FrmtNoauct	= "Ingen auktioner blev fundet for: %s";
		FrmtPctlessDone	= "Udregning af Procenter faerdig.";
		FrmtPctlessHeader	= "Procent mindre end hoejeste saelgende pris(HSP): %d%%";
		FrmtPctlessLine	= "%s, sidst %d set, HSP: %s, BO: %s, Profit: %s, Mindre %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Afsluttede auktioner fjernet: %s";
		AuctionDiscrepancies	= "Uoverensstemmelser: %s";
		AuctionNewAucts	= "Nye auktioner skannet: %s";
		AuctionOldAucts	= "Skannet foer: %s";
		AuctionPageN	= "Auctioneer: skanner nu %s side %d af %d\nAuktioner pr sekund: %s\nBeregnet tid tilbage: %s";
		AuctionScanDone	= "Auctioneer: Skanningen af auktionerne er faerdig.";
		AuctionScanNexttime	= "Auctioneer vil udfoere en komplet scanning af auktionshuset naeste gang du snakker med en auktioaer.";
		AuctionScanNocat	= "Du skal vaelge mindst en kategori for at kan skanne.";
		AuctionScanRedo	= "Nuvaerende side tog mere end %d sekunder at faerdigoere, forsoeger at indlaese siden igen.";
		AuctionScanStart	= "Auctioneer: skanner %s side 1...";
		AuctionTotalAucts	= "Auktioner skannet ialt: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Set %d gange paa %s";
		FrmtInfoAverage	= "%s min/%s BO (%s bud)";
		FrmtInfoBidMulti	= "Bud (%s%s stk.)";
		FrmtInfoBidOne	= "Bud%s";
		FrmtInfoBidrate	= "%d%% har budt, %d%% har BO";
		FrmtInfoBuymedian	= "Opk\195\184b median";
		FrmtInfoBuyMulti	= "Opk\195\184b (%s%s Stk)";
		FrmtInfoBuyOne	= "Opk\195\184b%s";
		FrmtInfoForone	= "For 1: %s min/%s BO (%s bud) [i %d's]";
		FrmtInfoHeadMulti	= "Middel for %d stk.:";
		FrmtInfoHeadOne	= "Middel for denne vare:";
		FrmtInfoHistmed	= "Sidste %d, middel BO (stk)";
		FrmtInfoMinMulti	= "Start bud (%s stk.)";
		FrmtInfoMinOne	= "Start bud";
		FrmtInfoNever	= "Aldrig set paa %s";
		FrmtInfoSeen	= "Set %d gange paa auktion ialt";
		FrmtInfoSgst	= "Prisforslag: %s min/%s BO";
		FrmtInfoSgststx	= "Prisforslag for dine %d stk: %s min/%s BO";
		FrmtInfoSnapmed	= "Skannede %d, middel BO (stk)";
		FrmtInfoStacksize	= "Normal bundt stoerrelse: %d stk.";


		-- Section: User Interface
		UiBid	= "bud";
		UiBidHeader	= "bud";
		UiBidPerHeader	= "Bud pr.";
		UiBuyout	= "Opk\195\184b";
		UiBuyoutHeader	= "Opk\195\184b";
		UiBuyoutPerHeader	= "Opk\195\184b pr.";
		UiBuyoutPriceLabel	= "Opk\195\184b bud:";
		UiBuyoutPriceTooLowError	= "(For lav)";
		UiCategoryLabel	= "kategori begr\195\166nsning:";
		UiDepositLabel	= "Depositum";
		UiDurationLabel	= "Varighed:";
		UiItemLevelHeader	= "Lvl";
		UiMakeFixedPriceLabel	= "Opret fixed pris";
		UiMaxError	= "(%d - Max)";
		UiMaximumPriceLabel	= "Maximum pris:";
		UiMaximumTimeLeftLabel	= "Maximum tid tilbage:";
		UiMinimumPercentLessLabel	= "Minimum procent mindre:";
		UiMinimumProfitLabel	= "Minimum profit:";
		UiMinimumQualityLabel	= "Minimum kvalitet:";
		UiMinimumUndercutLabel	= "Minimum underbyder";
		UiNameHeader	= "Navn";
		UiNoPendingBids	= "Alle bud anmodninger f\195\166rdige";
		UiNotEnoughError	= "(Ikke nok)";
		UiPendingBidInProgress	= "1 bud anmodning i gang...";
		UiPendingBidsInProgress	= "%d bud anmodninger i gang.";
		UiPercentLessHeader	= "procent";
		UiPost	= "Opret";
		UiPostAuctions	= "Set auktioner";
		UiPriceBasedOnLabel	= "Pris baseret p\195\165:";
		UiPriceModelAuctioneer	= "Auctioneer Pris";
		UiPriceModelCustom	= "Personlig pris";
		UiPriceModelFixed	= "Fast pris";
		UiProfitHeader	= "Profit";
		UiProfitPerHeader	= "Profit pr.";
		UiQuantityHeader	= "Kvalitet";
		UiQuantityLabel	= "M\195\166ngde:";
		UiRemoveSearchButton	= "Slet";
		UiSavedSearchLabel	= "Gemte s\195\184gninger:";
		UiSaveSearchButton	= "Gem";
		UiSaveSearchLabel	= "Gem denne s\195\184gning:";
		UiSearch	= "S\195\184g";
		UiSearchAuctions	= "S\195\184g auktioner";
		UiSearchDropDownLabel	= "S\195\184g:";
		UiSearchForLabel	= "S\195\184g efter genstand:";
		UiSearchTypeBids	= "Bud";
		UiSearchTypeBuyouts	= "k\195\184b";
		UiSearchTypeCompetition	= "Konkurrence";
		UiSearchTypePlain	= "Genstand";
		UiStacksLabel	= "Stakke";
		UiStackTooBigError	= "(Stak for stor)";
		UiStackTooSmallError	= "(Stak for lille)";
		UiStartingPriceLabel	= "Start pris:";
		UiStartingPriceRequiredError	= "(n\195\184dvendig)";
		UiTimeLeftHeader	= "Tid tilbage";
		UiUnknownError	= "(ukendt fejl)";

	};

	deDE = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Stapelpreis mit %sx[ItemLink] (x = Stapelgr\195\182\195\159e)";
		FrmtAskPriceBuyoutMedianHistorical	= "%sSofortkauf Median: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sSofortkauf Median letzter Scan: %s%s";
		FrmtAskPriceDisable	= "Preisabfrage %s Option ausgeschaltet";
		FrmtAskPriceEach	= "(%s pro St\195\188ck)";
		FrmtAskPriceEnable	= "Preisabfrage %s Option eingeschaltet";
		FrmtAskPriceVendorPrice	= "%sVerkauf an NPC f\195\188r: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Entferne Auktion %s vom derzeitigen AH-Abbild.";
		FrmtAuctinfoHist	= "%d historisch";
		FrmtAuctinfoLow	= "niedrigster Preis";
		FrmtAuctinfoMktprice	= "Marktpreis";
		FrmtAuctinfoNolow	= "Item nicht im letzten AH-Abbild enthalten";
		FrmtAuctinfoOrig	= "Originalgebot";
		FrmtAuctinfoSnap	= "%d aus letztem Scan";
		FrmtAuctinfoSugbid	= "Anfangsgebot";
		FrmtAuctinfoSugbuy	= "Empf. Sofortkauf";
		FrmtWarnAbovemkt	= "Konkurrenz keine Gefahr";
		FrmtWarnMarkup	= "%s%% erh\195\182hter H\195\164ndlerpreis";
		FrmtWarnMyprice	= "Verwende eigenen Preis";
		FrmtWarnNocomp	= "Monopol";
		FrmtWarnNodata	= "Keine HVP-Daten";
		FrmtWarnToolow	= "Konkurrenz zu g\195\188nstig";
		FrmtWarnUndercut	= "Unterbiete um %s%%";
		FrmtWarnUser	= "Verwende Benutzer-Preisvorgabe";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Bereits H\195\182chstbietender f\195\188r Auktion: %s (x%d)";
		FrmtBidAuction	= "Gebot f\195\188r Auktion: %s (x%d) ";
		FrmtBidQueueOutOfSync	= "Fehler: Gebotsliste nicht synchron!";
		FrmtBoughtAuction	= "Direktkauf der Auktion: %s (x%d) ";
		FrmtMaxBidsReached	= "Mehr Auktionen von %s (x%d)gefunden, aber Gebot Begrenzung erreicht (%d) ";
		FrmtNoAuctionsFound	= "Keine Auktionen gefunden: %s (x%d) ";
		FrmtNoMoreAuctionsFound	= "Keine weiteren Auktionen gefunden: %s (x%d) ";
		FrmtNotEnoughMoney	= "Nicht genug Geld f\195\188r Gebot auf Auktion: %s (x%d) ";
		FrmtSkippedAuctionWithHigherBid	= "\195\156berspringe Auktion mit h\195\182herem Gebot: %s (x%d) ";
		FrmtSkippedAuctionWithLowerBid	= "\195\156berspringe Auktion mit niedrigerem Gebot: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "\195\156berspringe Gebot auf eigene Auktion: %s (x%d)";
		UiProcessingBidRequests	= "Bearbeite Gebote...";


		-- Section: Command Messages
		FrmtActClearall	= "L\195\182sche alle Auktionsdaten f\195\188r %s";
		FrmtActClearFail	= "Objekt nicht gefunden: %s";
		FrmtActClearOk	= "Daten gel\195\182scht f\195\188r: %s";
		FrmtActClearsnap	= "L\195\182sche aktuelles Auktionshaus-Abbild.";
		FrmtActDefault	= "%s wurde auf den Standardwert zur\195\188ckgesetzt.";
		FrmtActDefaultall	= "Alle Einstellungen wurden auf Standardwerte zur\195\188ckgesetzt.";
		FrmtActDisable	= "%s wird nicht angezeigt";
		FrmtActEnable	= "%s wird angezeigt";
		FrmtActSet	= "Setze %s auf '%s'";
		FrmtActUnknown	= "Unbekannter Befehl: '%s'";
		FrmtAuctionDuration	= "Standard-Auktionsdauer wurde auf \"%s\" gesetzt";
		FrmtAutostart	= "Automatischer Start der Auktion f\195\188r %s:\n%s Minimum, %s Sofortkauf (%dh)\n%s";
		FrmtFinish	= "Nach abgeschlossenem Scan werden wir %s";
		FrmtPrintin	= "Die Auctioneer-Meldungen werden nun im Chat-Fenster \"%s\" angezeigt";
		FrmtProtectWindow	= "Schutzmodus des Auktionshaus-Fensters auf \"%s\" gesetzt";
		FrmtUnknownArg	= "'%s' ist kein g\195\188ltiges Argument f\195\188r '%s'";
		FrmtUnknownLocale	= "Das angegebene Gebietsschema ('%s') ist unbekannt. G\195\188ltige Gebietsschemen sind:";
		FrmtUnknownRf	= "Ung\195\188ltiger Parameter ('%s'). Der Parameter erfordert das Format: [Realm]-[Fraktion]. Bspw.: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "([Realm]-[Fraktion]|opposite|home|neutral)";
		OptAuctionDuration	= "(last|2h|8h|24h)";
		OptBidbroker	= "<Profit in Silber>";
		OptBidLimit	= "<Nummer> ";
		OptBroker	= "<Profit in Silber>";
		OptClear	= "([Gegenstand]|all|snapshot)";
		OptCompete	= "<silber_weniger>";
		OptDefault	= "(<Option>|all)";
		OptFinish	= "(off|logout|exit|reloadui)";
		OptLocale	= "<Sprache>";
		OptPctBidmarkdown	= "<Prozent>";
		OptPctMarkup	= "<Prozent>";
		OptPctMaxless	= "<Prozent>";
		OptPctNocomp	= "<Prozent>";
		OptPctUnderlow	= "<Prozent>";
		OptPctUndermkt	= "<Prozent>";
		OptPercentless	= "<Prozent>";
		OptPrintin	= "(<Fenster-Index>[Nummer]|<Fenster-Name>[String])";
		OptProtectWindow	= "(never|scan|always)";
		OptScale	= "<Skalierungsfaktor>";
		OptScan	= "Befehlsformat der Scanparameter";


		-- Section: Commands
		CmdAlso	= "also";
		CmdAlsoOpposite	= "opposite";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "ad";
		CmdAskPriceGuild	= "guild";
		CmdAskPriceParty	= "party";
		CmdAskPriceSmart	= "smart";
		CmdAskPriceSmartWord1	= "what";
		CmdAskPriceSmartWord2	= "worth";
		CmdAskPriceTrigger	= "trigger";
		CmdAskPriceVendor	= "vendor";
		CmdAskPriceWhispers	= "whispers";
		CmdAskPriceWord	= "word";
		CmdAuctionClick	= "auction-click";
		CmdAuctionDuration	= "auction-duration";
		CmdAuctionDuration0	= "last";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "autofill";
		CmdBidbroker	= "bidbroker";
		CmdBidbrokerShort	= "bb";
		CmdBidLimit	= "bid-limit";
		CmdBroker	= "broker";
		CmdClear	= "clear";
		CmdClearAll	= "all";
		CmdClearSnapshot	= "snapshot";
		CmdCompete	= "compete";
		CmdCtrl	= "strg";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdEmbed	= "embed";
		CmdFinish	= "finish";
		CmdFinish0	= "off";
		CmdFinish1	= "logout";
		CmdFinish2	= "exit";
		CmdFinish3	= "reloadui";
		CmdFinishSound	= "finish-sound";
		CmdHelp	= "help";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPctBidmarkdown	= "pct-bidmarkdown";
		CmdPctMarkup	= "pct-markup";
		CmdPctMaxless	= "pct-maxless";
		CmdPctNocomp	= "pct-nocomp";
		CmdPctUnderlow	= "pct-underlow";
		CmdPctUndermkt	= "pct-undermkt";
		CmdPercentless	= "percentless";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "print-in";
		CmdProtectWindow	= "protect-window";
		CmdProtectWindow0	= "never";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "always";
		CmdScan	= "scan";
		CmdShift	= "shift";
		CmdToggle	= "toggle";
		CmdUpdatePrice	= "update-price";
		CmdWarnColor	= "warn-color";
		ShowAverage	= "show-average";
		ShowEmbedBlank	= "show-embed-blankline";
		ShowLink	= "show-link";
		ShowMedian	= "show-median";
		ShowRedo	= "show-warning";
		ShowStats	= "show-stats";
		ShowSuggest	= "show-suggest";
		ShowVerbose	= "show-verbose";


		-- Section: Config Text
		GuiAlso	= "Zeige zus\195\164tzlich Daten von";
		GuiAlsoDisplay	= "Zeige Daten f\195\188r %s an";
		GuiAlsoOff	= "Daten f\195\188r andere Realm-Fraktion werden nicht mehr angezeigt.";
		GuiAlsoOpposite	= "Daten der gegnerischen Fraktion werden jetzt ebenfalls angezeigt.";
		GuiAskPrice	= "AskPrice einschalten";
		GuiAskPriceAd	= "Sende feature Werbung";
		GuiAskPriceGuild	= "Reagiere auf Gildenchat-Anfragen";
		GuiAskPriceHeader	= "AskPrice Optionen";
		GuiAskPriceHeaderHelp	= "\195\132ndere AskPrice Verhalten";
		GuiAskPriceParty	= "Reagiere auf Gruppenchat-Anfragen";
		GuiAskPriceSmart	= "Benutze Schlagw\195\182rter";
		GuiAskPriceTrigger	= "AskPrice Ausl\195\182ser";
		GuiAskPriceVendor	= "Sende H\195\164ndler Info";
		GuiAskPriceWhispers	= "Ausgehende Whispers anzeigen";
		GuiAskPriceWord	= "Eigenes SmartWord %d";
		GuiAuctionDuration	= "Auktionsstandarddauer";
		GuiAuctionHouseHeader	= "Auktionshausfenster";
		GuiAuctionHouseHeaderHelp	= "Verhalten des Auktionshausfensters \195\164ndern";
		GuiAutofill	= "Preise im AH automatisch eintragen";
		GuiAverages	= "Durchschnitt anzeigen";
		GuiBidmarkdown	= "Gebot um %x unterbieten";
		GuiClearall	= "L\195\182sche alle Auctioneerdaten";
		GuiClearallButton	= "Alles l\195\182schen";
		GuiClearallHelp	= "Hier dr\195\188cken, um die gesamten Auctioneerdaten des aktuellen Realms zu l\195\182schen.";
		GuiClearallNote	= "der aktuellen Fraktion dieses Realms";
		GuiClearHeader	= "Daten l\195\182schen";
		GuiClearHelp	= "Auctioneerdaten l\195\182schen.\nW\195\164hle entweder alle Daten oder das aktuelle Abbild.\nWARNUNG: Der L\195\182schvorgang kann NICHT r\195\188ckg\195\164ngig gemacht werden!";
		GuiClearsnap	= "Abbilddaten l\195\182schen";
		GuiClearsnapButton	= "Abbild l\195\182schen";
		GuiClearsnapHelp	= "Zum L\195\182schen der letzten Auctioneer-Abbild-Daten, hier klicken.";
		GuiDefaultAll	= "Alle Einstellungen zur\195\188cksetzen";
		GuiDefaultAllButton	= "Alles zur\195\188cksetzen";
		GuiDefaultAllHelp	= "Hier klicken, um alle Auctioneer-Optionen auf ihren Standardwert zu setzen.\nWARNUNG: Dieser Vorgang kann NICHT r\195\188ckg\195\164ngig gemacht werden.";
		GuiDefaultOption	= "Zur\195\188cksetzen dieser Einstellung";
		GuiEmbed	= "Info im In-Game Tooltipp anzeigen";
		GuiEmbedBlankline	= "Leerzeile im In-Game Tooltipp einf\195\188gen";
		GuiEmbedHeader	= "Art der Anzeige";
		GuiFinish	= "Nach abgeschlossenem Scan";
		GuiFinishSound	= "Spiele Ton ab nach Beenden des Scans";
		GuiLink	= "Zeige LinkID an";
		GuiLoad	= "Auctioneer laden";
		GuiLoad_Always	= "immer";
		GuiLoad_AuctionHouse	= "im Auktionshaus";
		GuiLoad_Never	= "nie";
		GuiLocale	= "Setze das Gebietsschema auf";
		GuiMainEnable	= "Auctioneer aktivieren";
		GuiMainHelp	= "Einstellungen f\195\188r Auctioneer.\nEinem AddOn, das zus\195\164tzliche Informationen zu Gegenst\195\164nden anzeigt und Auktionsdaten analysiert.\nDr\195\188cke den \"Scannen\"-Knopf im Auktionshaus, um Auktionsdaten zu sammeln.";
		GuiMarkup	= "H\195\164ndlerpreis um x% erh\195\182hen";
		GuiMaxless	= "Marktpreis um max. x% unterbieten";
		GuiMedian	= "Zeige Mediane an.";
		GuiNocomp	= "Marktpreis um x% bei Monopol\nverringern";
		GuiNoWorldMap	= "Auctioneer: Die Anzeige der Weltkarte wurde unterdr\195\188ckt";
		GuiOtherHeader	= "Sonstige Einstellungen";
		GuiOtherHelp	= "Sonstige Auctioneer-Einstellungen";
		GuiPercentsHeader	= "Auctioneer Prozent-Schwellenwerte";
		GuiPercentsHelp	= "WARNUNG: Die folgenden Einstellungen sind NUR f\195\188r erfahrene Benutzer.\nVer\195\164ndere die folgenden Werte um festzulegen, wie aggressiv Auctioneer beim Bestimmen profitabler Preise vorgehen soll.";
		GuiPrintin	= "Fenster f\195\188r Meldungen ausw\195\164hlen";
		GuiProtectWindow	= "Versehentliches Schlie\195\159en des AH-Fensters verhindern";
		GuiRedo	= "Zeige Warnung bei langer Scandauer";
		GuiReloadui	= "Benutzeroberfl\195\164che neu laden";
		GuiReloaduiButton	= "Interface neu laden";
		GuiReloaduiFeedback	= "WoW-Benutzeroberfl\195\164che wird neu geladen";
		GuiReloaduiHelp	= "Hier klicken, um die WoW-Benutzeroberfl\195\164che nach einer \n\195\132nderung des Gebietsschemas neu zu laden, so dass die Sprache des Konfigurationsmen\195\188s diesem entspricht.\nHinweis: Dieser Vorgang kann einige Minuten dauern.";
		GuiRememberText	= "Preis merken";
		GuiStatsEnable	= "Statistiken anzeigen";
		GuiStatsHeader	= "Preisstatistiken";
		GuiStatsHelp	= "Zeigt die folgenden Statistiken im Tooltip an.";
		GuiSuggest	= "Zeige empfohlene Preise an.";
		GuiUnderlow	= "G\195\188nstigste Auktion unterbieten";
		GuiUndermkt	= "Marktpreis unterbieten, wenn\nKonkurrenz zu g\195\188nstig ist";
		GuiVerbose	= "Detaillierte Informationen";
		GuiWarnColor	= "Farbiges Preismodell";


		-- Section: Conversion Messages
		MesgConvert	= "Auctioneer Datenbankkonvertierung. Bitte zuerst eine Sicherung von SavedVariables\\Auctioneer.lua anlegen!%s%s";
		MesgConvertNo	= "Deaktivieren";
		MesgConvertYes	= "Konvertieren";
		MesgNotconverting	= "Auctioneer konvertiert die Datenbank nicht, bleibt aber au\195\159er Funktion, bis dies erfolgte.";


		-- Section: Game Constants
		TimeLong	= "Lang";
		TimeMed	= "Mittel";
		TimeShort	= "Kurz";
		TimeVlong	= "Sehr lang";


		-- Section: Generic Messages
		DisableMsg	= "Das automatische Laden von Auctioneer wird deaktiviert";
		FrmtWelcome	= "Auctioneer v%s geladen";
		MesgNotLoaded	= "Auctioneer ist nicht geladen. Gib /auctioneer f\195\188r mehr Informationen ein.";
		StatAskPriceOff	= "Preisnachfrage deaktiviert.";
		StatAskPriceOn	= "Preisnachfrage aktiviert.";
		StatOff	= "Auktionsdaten werden nicht angezeigt.";
		StatOn	= "Auktionsdaten werden angezeigt.";


		-- Section: Generic Strings
		TextAuction	= "Auktion";
		TextCombat	= "Kampflog";
		TextGeneral	= "Allgemein";
		TextNone	= "nichts";
		TextScan	= "Scannen";
		TextUsage	= "Syntax:";


		-- Section: Help Text
		HelpAlso	= "Zeigt ebenfalls die Werte anderer Server im Tooltip an. Setze den Namen des Realms f\195\188r Realm und den Namen der Fraktion f\195\188r Fraktion ein. Zum Beispiel: \"/auctioneer auch Kil'Jaeden-Alliance\". Das spezielle Schl\195\188sselwort \"Gegenseite\" bezeichnet die gegnerische Fraktion, \"aus\" deaktiviert die Funktionalit\195\164t.";
		HelpAskPrice	= "Preisnachfrage ein-/ausschalten.";
		HelpAskPriceAd	= "Anzeige der neuen Preisnachfrage-Eigenschaften ein-/ausschalten.";
		HelpAskPriceGuild	= "Auf Gildenchat-Anfragen reagieren.";
		HelpAskPriceParty	= "Auf Gruppenchat-Anfragen reagieren.";
		HelpAskPriceSmart	= "Schlagwortcheck ein-/ausschalten.";
		HelpAskPriceTrigger	= "\195\132ndere AskPrice Ausl\195\182ser.";
		HelpAskPriceVendor	= "Anzeige von H\195\164ndler Informationen ein-/ausschalten.";
		HelpAskPriceWhispers	= "Aktiviere oder deaktiviere das Verbergen von allen von AskPrice abgehenden gefl\195\188sterten Meldungen.";
		HelpAskPriceWord	= "Hinzuf\195\188gen bzw. modifizieren von eigenen AskPrice SmartWords.";
		HelpAuctionClick	= "Mittels Alt-Klick auf einen Gegenstand in einer Tasche wird automatisch eine Auktion daf\195\188r erstellt.";
		HelpAuctionDuration	= "Setzt die Standard-Auktionsdauer beim \195\150ffnen des Auktionshausfensters";
		HelpAutofill	= "Festlegen, ob die Preise automatisch ausgef\195\188llt werden sollen, wenn ein Gegenstand in das Auktionshaus gelegt wird.";
		HelpAverage	= "Festlegen, ob der durchschnittliche Auktionspreis angezeigt wird.";
		HelpBidbroker	= "Zeigt vom letzten Abbild alle Auktionen mit kurzer oder mittlerer Laufzeit an, auf die f\195\188r Profit geboten werden k\195\182nnte.";
		HelpBidLimit	= "Maximum Auktionen auf die geboten werden soll oder Sofortkauf wenn der Gebots- oder Sofortkaufbutton geklickt wurde, w\195\164hrend eine Suchaktion l\195\164uft.";
		HelpBroker	= "Zeigt alle Auktionen vom letzten Abbild an, auf die geboten und die mit Gewinn wieder verkauft werden k\195\182nnten.";
		HelpClear	= "L\195\182scht die Daten der angegebenen Gegenst\195\164nde (Gegenst\195\164nde m\195\188ssen dem Befehl mittels Shift + Klick hinzugef\195\188gt werden). Es k\195\182nnen auch die speziellen Schl\195\188sselworte \"alle\" und \"Abbild\" hinzugef\195\188gt werden.";
		HelpCompete	= "Zeigt alle Auktionen des letzten Scans an, deren Sofortkaufpreis geringer ist als der eines eigenen im AH angebotenen Gegenstandes.";
		HelpDefault	= "Setzt eine Auctioneer-Einstellung auf ihren Standardwert zur\195\188ck. Mit dem Schl\195\188sselwort \"alle\" werden alle Auctioneer-Einstellungen zur\195\188ckgesetzt.";
		HelpDisable	= "Stoppt den Autostart von Auctioneer ab dem n\195\164chsten Einloggen.";
		HelpEmbed	= "Bettet den Auktionsinfotext in den WoW-Tooltip ein (Hinweis: Einige Funktionen sind in diesem Modus deaktiviert)";
		HelpEmbedBlank	= "Schaltet die Anzeige einer Leerzeile zwischen der Tooltipinfo und der Auktionsinfo im Einbettungsmodus ein/aus.";
		HelpFinish	= "W\195\164hle zwischen automatischem Ausloggen oder Beenden des Spieles nach abgeschlossenem Scan";
		HelpFinishSound	= "Legt fest, ob nach Beenden eines Scans ein Ton abgespielt werden soll.";
		HelpLink	= "Schaltet die Anzeige der Link-ID im Tooltip ein/aus.";
		HelpLoad	= "Ladeverhalten von Auctioneer f\195\188r diesen Charakter \195\164ndern";
		HelpLocale	= "\195\132ndern des Gebietsschemas das zur Anzeige \nvon Auctioneer-Meldungen verwendet wird";
		HelpMedian	= "Schaltet die Anzeige des Median-Sofortkaufpreises ein/aus";
		HelpOnoff	= "Schaltet die Anzeige der Auktionsdaten ein/aus";
		HelpPctBidmarkdown	= "Legt den Prozentsatz fest, um den das Mindestgebot niedriger als der Sofortkaufpreis ist.";
		HelpPctMarkup	= "Legt den Prozentsatz f\195\188r erh\195\182hte H\195\164ndlerpreise fest, der verwendet wird, falls sonst keine anderen Werte verf\195\188gbar sind.";
		HelpPctMaxless	= "Legt den maximalen Prozentsatz fest, um den Auctioneer den Marktpreis h\195\182chstens unterschreiten darf.";
		HelpPctNocomp	= "Legt den Prozentsatz fest, um den der Marktpreis bei Monopol unterboten wird.";
		HelpPctUnderlow	= "Legt den Prozentsatz fest, um den das g\195\188nstigste konkurrierende Angebot unterboten wird.";
		HelpPctUndermkt	= "Legt den Prozentsatz fest, um den der Marktpreis unterboten wird, wenn durch den gew\195\164hlten Prozentsatz f\195\188r maxless ein konkurrierendes Angebot nicht unterboten werden kann.";
		HelpPercentless	= "Zeigt alle Auktionen des letzten Abbilds an, deren Sofortkaufpreis einen gewissen Prozentsatz unter dem h\195\182chstm\195\182glichen Verkaufspreis liegt.";
		HelpPrintin	= "Ausw\195\164hlen in welchem Fenster die Auctioneer-Meldungen angezeigt werden. Es kann entweder der Fensterindex oder der Fenstername angegeben werden.";
		HelpProtectWindow	= "Verhindert das versehentliche Schlie\195\159en des Auktionshaus-Fensters.";
		HelpRedo	= "Legt fest, ob eine Warnung angezeigt wird, wenn das Scannen der aktuellen Seite im Auktionshaus wegen Serverlag zu lange dauert.";
		HelpScan	= "F\195\188hrt einen Scan des Auktionshauses beim n\195\164chsten Besuch durch bzw. sofort, wenn man schon dort ist (es gibt ebenfalls einen Knopf im Auktionshausfenster). \195\156ber die Auswahlboxen k\195\182nnen die zu scannenden Kategorien gew\195\164hlt werden.";
		HelpStats	= "Schaltet die Prozentanzeige vom Gebot/Sofortkauf ein/aus.";
		HelpSuggest	= "Schaltet die Anzeige des empfohlenen Auktionspreises ein/aus.";
		HelpUpdatePrice	= "Aktualisiert automatisch das Startgebot f\195\188r eine Auktion auf der Auktionserstellungsseite wenn sich der Sofortkaufpreis \195\164ndert.";
		HelpVerbose	= "Festlegen, ob detaillierte Anzeige der Durchschnittswerte und Preisempfehlungen (Ausschalten f\195\188r Anzeige in einzelner Zeile)";
		HelpWarnColor	= "Festlegen, ob das aktuelle AH-Preismodell (Unterbiete um ...) mit intuitiven Farben angezeigt wird.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Keinen leeren Taschenplatz gefunden, um die Auktion zu erstellen!";
		FrmtNotEnoughOfItem	= "Nicht genug %s gefunden, um die Auktion zu erstellen!";
		FrmtPostedAuction	= "Es wurde 1 Auktion mit %s (x%d) erstellt";
		FrmtPostedAuctions	= "Es wurden %d Auktionen mit %s (x%d) erstellt";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "aktGebot";
		FrmtBidbrokerDone	= "Gebotsmakeln fertig";
		FrmtBidbrokerHeader	= "Mindestprofit: %s, HVP = 'H\195\182chster Verkaufspreis'";
		FrmtBidbrokerLine	= "%s, zuletzt %s gesehen, HVP: %s, %s: %s, Profit: %s, Restzeit: %s";
		FrmtBidbrokerMinbid	= "niedrGebot";
		FrmtBrokerDone	= "Makeln beendet";
		FrmtBrokerHeader	= "Mindestprofit: %s, HVP = 'H\195\182chster Verkaufspreis'";
		FrmtBrokerLine	= "%s, zuletzt %s gesehen, HVP: %s, Sofortkauf: %s, Profit: %s";
		FrmtCompeteDone	= "Konkurrierende Auktionen abgeschlossen.";
		FrmtCompeteHeader	= "Konkurrierende Auktionen mindestens %s billiger pro St\195\188ck.";
		FrmtCompeteLine	= "%s, Gebot: %s, Sofortkauf %s gg. %s, %s billiger";
		FrmtHspLine	= "H\195\182chster Verkaufspreis pro %s ist: %s";
		FrmtLowLine	= "%s, Sofortkauf: %s, Verk\195\164ufer: %s, %s/St\195\188ck, %s unter dem Median";
		FrmtMedianLine	= "Aus %d ist der Median-Sofortkaufpreis f\195\188r 1 %s: %s";
		FrmtNoauct	= "Keine Aktionen f\195\188r %s gefunden.";
		FrmtPctlessDone	= "Prozent unter HVP beendet.";
		FrmtPctlessHeader	= "Prozent billiger als der h\195\182chste Verkaufspreis (HVP): %d%%";
		FrmtPctlessLine	= "%s, zuletzt %d gesehen, HVP: %s, Sofortkauf: %s, Profit: %s, Billiger %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Abgelaufene Auktionen: %s";
		AuctionDiscrepancies	= "Unstimmigkeiten: %s";
		AuctionNewAucts	= "Davon neu: %s";
		AuctionOldAucts	= "Schon bekannt: %s";
		AuctionPageN	= "Auctioneer: Erfasse %s Seite %d von %d\nAuktionen pro Sekunde: %s\nGesch\195\164tzte Restzeit: %s";
		AuctionScanDone	= "Auctioneer: Scannen abgeschlossen";
		AuctionScanNexttime	= "Auctioneer wird einen vollst\195\164ndigen Auktionsscan durchf\195\188hren, wenn das n\195\164chste Mal ein Auktionator angesprochen wird.";
		AuctionScanNocat	= "Zum Scannen muss zumindest eine Kategorie ausgew\195\164hlt sein.";
		AuctionScanRedo	= "Das Erfassen der aktuelle Seite ben\195\182tigte mehr als %d Sekunden, erneuter Versuch.";
		AuctionScanStart	= "Auctioneer: Scanne %s Seite 1...";
		AuctionTotalAucts	= "Insgesamt gescannte Auktionen: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "%d mal f\195\188r %s gesehen";
		FrmtInfoAverage	= "%s min/%s Sofortkauf (%s geboten)";
		FrmtInfoBidMulti	= "Geboten (%s%s pro St\195\188ck)";
		FrmtInfoBidOne	= "Geboten %s";
		FrmtInfoBidrate	= "%d%% mit Gebot, %d%% mit Sofortkauf";
		FrmtInfoBuymedian	= "Sofortkaufsmedian";
		FrmtInfoBuyMulti	= "Sofortkauf (%s%s pro St\195\188ck)";
		FrmtInfoBuyOne	= "Sofortkauf %s";
		FrmtInfoForone	= "Pro St\195\188ck: %s min/%s Sofortkauf (%s geboten) [in %d]";
		FrmtInfoHeadMulti	= "Durchschnitt f\195\188r %d St\195\188ck:";
		FrmtInfoHeadOne	= "Durchschnitt f\195\188r dieses Objekt:";
		FrmtInfoHistmed	= "Sofortkaufmeadian (pro St\195\188ck) der %d letzten Auktionen:";
		FrmtInfoMinMulti	= "Startgebot (%s pro St\195\188ck)";
		FrmtInfoMinOne	= "Startgebot";
		FrmtInfoNever	= "Noch nie in %s gesehen";
		FrmtInfoSeen	= "Insgesamt %d mal in Auktionen gesehen";
		FrmtInfoSgst	= "Empfohlener Preis: %s min/%s Sofortkauf";
		FrmtInfoSgststx	= "Empfohlener Preis f\195\188r diesen %der Stapel: %s min/%s Sofortkauf";
		FrmtInfoSnapmed	= "Sofortkaufsmedian (pro St\195\188ck) aus %d gescannten Auktionen:";
		FrmtInfoStacksize	= "Durchschnittliche Stapelgr\195\182\195\159e: %d St\195\188ck";


		-- Section: User Interface
		FrmtLastSoldOn	= "Zuletzt verkauft f\195\188r %s";
		UiBid	= "Gebot";
		UiBidHeader	= "Gebot";
		UiBidPerHeader	= "Gebot pro";
		UiBuyout	= "Sofortkauf";
		UiBuyoutHeader	= "Sofortkauf";
		UiBuyoutPerHeader	= "Sofortkauf pro";
		UiBuyoutPriceLabel	= "Sofortkaufpreis:";
		UiBuyoutPriceTooLowError	= "(zu niedrig)";
		UiCategoryLabel	= "Kategoriebeschr\195\164nkung:";
		UiDepositLabel	= "Anzahlung:";
		UiDurationLabel	= "Dauer:";
		UiItemLevelHeader	= "Stufe";
		UiMakeFixedPriceLabel	= "Als Festpreis setzen";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Maximaler Preis:";
		UiMaximumTimeLeftLabel	= "Maximale Restzeit:";
		UiMinimumPercentLessLabel	= "Prozent unter HVP:";
		UiMinimumProfitLabel	= "Mindestgewinn:";
		UiMinimumQualityLabel	= "Mindestqualit\195\164t:";
		UiMinimumUndercutLabel	= "Unterbieten um:";
		UiNameHeader	= "Name";
		UiNoPendingBids	= "Alle Gebotsanfragen komplett!";
		UiNotEnoughError	= "(nicht genug)";
		UiPendingBidInProgress	= "1 Gebotsanfrage in Bearbeitung...";
		UiPendingBidsInProgress	= "%d Gebotsanfragen in Bearbeitung...";
		UiPercentLessHeader	= "%";
		UiPost	= "Erstellen";
		UiPostAuctions	= "Erstelle Auktionen";
		UiPriceBasedOnLabel	= "Preis basiert auf:";
		UiPriceModelAuctioneer	= "Auctioneer-Preis";
		UiPriceModelCustom	= "Benutzerdef. Preis";
		UiPriceModelFixed	= "Festpreis";
		UiPriceModelLastSold	= "Zuletzt verkauft f\195\188r";
		UiProfitHeader	= "Gewinn";
		UiProfitPerHeader	= "Gewinn pro";
		UiQuantityHeader	= "Anz.";
		UiQuantityLabel	= "Anzahl:";
		UiRemoveSearchButton	= "L\195\182schen";
		UiSavedSearchLabel	= "Gespeicherte Suchen:";
		UiSaveSearchButton	= "Speichern";
		UiSaveSearchLabel	= "Suche speichern:";
		UiSearch	= "Suche";
		UiSearchAuctions	= "Durchsuche Auktionen";
		UiSearchDropDownLabel	= "Suche:";
		UiSearchForLabel	= "Gegenstand suchen:";
		UiSearchTypeBids	= "Gebote";
		UiSearchTypeBuyouts	= "Sofortk\195\164ufe";
		UiSearchTypeCompetition	= "Konkurrenz";
		UiSearchTypePlain	= "Gegenstand";
		UiStacksLabel	= "Stapel";
		UiStackTooBigError	= "(Stapel zu gro\195\159)";
		UiStackTooSmallError	= "(Stapel zu klein)";
		UiStartingPriceLabel	= "Startpreis:";
		UiStartingPriceRequiredError	= "(erforderlich)";
		UiTimeLeftHeader	= "Restzeit";
		UiUnknownError	= "(Unbekannt)";

	};

	enUS = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Get stack prices with %sx[ItemLink] (x = stacksize)";
		FrmtAskPriceBuyoutMedianHistorical	= "%sBuyout-median historical: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sBuyout-median last scan: %s%s";
		FrmtAskPriceDisable	= "Disabling AskPrice's %s option";
		FrmtAskPriceEach	= "(%s each)";
		FrmtAskPriceEnable	= "Enabling AskPrice's %s option";
		FrmtAskPriceVendorPrice	= "%sSell to vendor for: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Removing auction signature %s from current AH snapshot.";
		FrmtAuctinfoHist	= "%d historical";
		FrmtAuctinfoLow	= "Snapshot Low";
		FrmtAuctinfoMktprice	= "Market price";
		FrmtAuctinfoNolow	= "Item not seen last snapshot";
		FrmtAuctinfoOrig	= "Original Bid";
		FrmtAuctinfoSnap	= "%d last scan";
		FrmtAuctinfoSugbid	= "Starting bid";
		FrmtAuctinfoSugbuy	= "Suggested buyout";
		FrmtWarnAbovemkt	= "Competition above market";
		FrmtWarnMarkup	= "Marking up vendor by %s%%";
		FrmtWarnMyprice	= "Using my current price";
		FrmtWarnNocomp	= "No competition";
		FrmtWarnNodata	= "No data for HSP";
		FrmtWarnToolow	= "Cannot match lowest price";
		FrmtWarnUndercut	= "Undercutting by %s%%";
		FrmtWarnUser	= "Using user pricing";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Already the high bidder on auction: %s (x%d)";
		FrmtBidAuction	= "Bid on auction: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Error: Bid queue out of sync!";
		FrmtBoughtAuction	= "Bought out auction: %s (x%d)";
		FrmtMaxBidsReached	= "More auctions of %s (x%d) found, but bid limit reached (%d)";
		FrmtNoAuctionsFound	= "No auctions found: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "No more auctions found: %s (x%d)";
		FrmtNotEnoughMoney	= "Not enough money to bid on auction: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Skipped auction with higher bid: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Skipped auction with lower bid: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Skipped bidding on own auction: %s (x%d)";
		UiProcessingBidRequests	= "Processing bid requests...";


		-- Section: Command Messages
		FrmtActClearall	= "Clearing all auction data for %s";
		FrmtActClearFail	= "Unable to find item: %s";
		FrmtActClearOk	= "Cleared data for item: %s";
		FrmtActClearsnap	= "Clearing current Auction House snapshot.";
		FrmtActDefault	= "Auctioneer's %s option has been reset to its default setting";
		FrmtActDefaultall	= "All Auctioneer options have been reset to default settings.";
		FrmtActDisable	= "Not displaying item's %s data";
		FrmtActEnable	= "Displaying item's %s data";
		FrmtActSet	= "Set %s to '%s'";
		FrmtActUnknown	= "Unknown command or keyword: '%s'";
		FrmtAuctionDuration	= "Default action duration set to: %s";
		FrmtAutostart	= "Automatically starting auction for %s: %s minimum, %s buyout (%dh)\n%s";
		FrmtFinish	= "After a scan has finished, we will %s";
		FrmtPrintin	= "Auctioneer's messages will now print on the \"%s\" chat frame";
		FrmtProtectWindow	= "Auction House window protection set to: %s";
		FrmtUnknownArg	= "'%s' is no valid argument for '%s'";
		FrmtUnknownLocale	= "The locale you specified ('%s') is unknown. Valid locales are:";
		FrmtUnknownRf	= "Invalid parameter ('%s'). The parameter must be formated like: [realm]-[faction]. For example: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(realm-faction|opposite|home|neutral)";
		OptAuctionDuration	= "(last|2h|8h|24h)";
		OptBidbroker	= "<silver_profit>";
		OptBidLimit	= "<number>";
		OptBroker	= "<silver_profit>";
		OptClear	= "([Item]|all|snapshot)";
		OptCompete	= "<silver_less>";
		OptDefault	= "(<option>|all)";
		OptFinish	= "(off|logout|exit|reloadui)";
		OptLocale	= "<locale>";
		OptPctBidmarkdown	= "<percent>";
		OptPctMarkup	= "<percent>";
		OptPctMaxless	= "<percent>";
		OptPctNocomp	= "<percent>";
		OptPctUnderlow	= "<percent>";
		OptPctUndermkt	= "<percent>";
		OptPercentless	= "<percent>";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String])";
		OptProtectWindow	= "(never|scan|always)";
		OptScale	= "<scale_factor>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "also";
		CmdAlsoOpposite	= "opposite";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "ad";
		CmdAskPriceGuild	= "guild";
		CmdAskPriceParty	= "party";
		CmdAskPriceSmart	= "smart";
		CmdAskPriceSmartWord1	= "what";
		CmdAskPriceSmartWord2	= "worth";
		CmdAskPriceTrigger	= "trigger";
		CmdAskPriceVendor	= "vendor";
		CmdAskPriceWhispers	= "whispers";
		CmdAskPriceWord	= "word";
		CmdAuctionClick	= "auction-click";
		CmdAuctionDuration	= "auction-duration";
		CmdAuctionDuration0	= "last";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "autofill";
		CmdBidbroker	= "bidbroker";
		CmdBidbrokerShort	= "bb";
		CmdBidLimit	= "bid-limit";
		CmdBroker	= "broker";
		CmdClear	= "clear";
		CmdClearAll	= "all";
		CmdClearSnapshot	= "snapshot";
		CmdCompete	= "compete";
		CmdCtrl	= "ctrl";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdEmbed	= "embed";
		CmdFinish	= "finish";
		CmdFinish0	= "off";
		CmdFinish1	= "logout";
		CmdFinish2	= "exit";
		CmdFinish3	= "reloadui";
		CmdFinishSound	= "finish-sound";
		CmdHelp	= "help";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPctBidmarkdown	= "pct-bidmarkdown";
		CmdPctMarkup	= "pct-markup";
		CmdPctMaxless	= "pct-maxless";
		CmdPctNocomp	= "pct-nocomp";
		CmdPctUnderlow	= "pct-underlow";
		CmdPctUndermkt	= "pct-undermkt";
		CmdPercentless	= "percentless";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "print-in";
		CmdProtectWindow	= "protect-window";
		CmdProtectWindow0	= "never";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "always";
		CmdScan	= "scan";
		CmdShift	= "shift";
		CmdToggle	= "toggle";
		CmdUpdatePrice	= "update-price";
		CmdWarnColor	= "warn-color";
		ShowAverage	= "show-average";
		ShowEmbedBlank	= "show-embed-blankline";
		ShowLink	= "show-link";
		ShowMedian	= "show-median";
		ShowRedo	= "show-warning";
		ShowStats	= "show-stats";
		ShowSuggest	= "show-suggest";
		ShowVerbose	= "show-verbose";


		-- Section: Config Text
		GuiAlso	= "Also display data for";
		GuiAlsoDisplay	= "Displaying data for %s";
		GuiAlsoOff	= "No longer displaying other realm-faction data.";
		GuiAlsoOpposite	= "Now also displaying data for opposite faction.";
		GuiAskPrice	= "Enable AskPrice";
		GuiAskPriceAd	= "Send features ad";
		GuiAskPriceGuild	= "Respond to guildchat queries";
		GuiAskPriceHeader	= "AskPrice Options";
		GuiAskPriceHeaderHelp	= "Change AskPrice's behaviour";
		GuiAskPriceParty	= "Respond to partychat queries";
		GuiAskPriceSmart	= "Use smartwords";
		GuiAskPriceTrigger	= "AskPrice trigger";
		GuiAskPriceVendor	= "Send vendor info";
		GuiAskPriceWhispers	= "Show outgoing whispers";
		GuiAskPriceWord	= "Custom SmartWord %d";
		GuiAuctionDuration	= "Default auction duration";
		GuiAuctionHouseHeader	= "Auction House window";
		GuiAuctionHouseHeaderHelp	= "Change the behavior of the Auction House window";
		GuiAutofill	= "Autofill prices in the AH";
		GuiAverages	= "Show Averages";
		GuiBidmarkdown	= "Bid Markdown Percent";
		GuiClearall	= "Clear All Auctioneer Data";
		GuiClearallButton	= "Clear All";
		GuiClearallHelp	= "Click here to clear all of Auctioneer data for the current server-realm.";
		GuiClearallNote	= "for the current server-faction";
		GuiClearHeader	= "Clear Data";
		GuiClearHelp	= "Clears Auctioneer data. \nSelect either all data or the current snapshot.\nWARNING: These actions are NOT undoable.";
		GuiClearsnap	= "Clear Snapshot data";
		GuiClearsnapButton	= "Clear Snapshot";
		GuiClearsnapHelp	= "Click here to clear the last Auctioneer snapshot data.";
		GuiDefaultAll	= "Reset All Auctioneer Options";
		GuiDefaultAllButton	= "Reset All";
		GuiDefaultAllHelp	= "Click here to set all Auctioneer options to their default values.\nWARNING: This action is NOT undoable.";
		GuiDefaultOption	= "Reset this setting";
		GuiEmbed	= "Embed info in in-game tooltip";
		GuiEmbedBlankline	= "Show blankline in in-game tooltip";
		GuiEmbedHeader	= "Embed";
		GuiFinish	= "After a scan has finished";
		GuiFinishSound	= "Play sound on scan finish";
		GuiLink	= "Show LinkID";
		GuiLoad	= "Load Auctioneer";
		GuiLoad_Always	= "always";
		GuiLoad_AuctionHouse	= "at Auction House";
		GuiLoad_Never	= "never";
		GuiLocale	= "Set locale to";
		GuiMainEnable	= "Enable Auctioneer";
		GuiMainHelp	= "Contains settings for Auctioneer \nan AddOn that displays item info and analyzes auction data. \nClick the \"Scan\" button at the AH to collect auction data.";
		GuiMarkup	= "Vendor Price Markup Percent";
		GuiMaxless	= "Max Market Undercut Percent";
		GuiMedian	= "Show Medians";
		GuiNocomp	= "No Competition Undercut Percent";
		GuiNoWorldMap	= "Auctioneer: suppressed displaying of world map";
		GuiOtherHeader	= "Other Options";
		GuiOtherHelp	= "Miscellaneous Auctioneer Options";
		GuiPercentsHeader	= "Auctioneer Threshold Percents";
		GuiPercentsHelp	= "WARNING: The following setting are for Power Users ONLY.\nAdjust the following values to change how aggresive Auctioneer will be when deciding profitable levels.";
		GuiPrintin	= "Select the desired message frame";
		GuiProtectWindow	= "Prevent accidental closing of AH window";
		GuiRedo	= "Show Long Scan Warning";
		GuiReloadui	= "Reload User Interface";
		GuiReloaduiButton	= "ReloadUI";
		GuiReloaduiFeedback	= "Now Reloading the WoW UI";
		GuiReloaduiHelp	= "Click here to reload the WoW User Interface after changing the locale so that the language in this configuration screen matches the one you selected.\nNote: This operation may take a few minutes.";
		GuiRememberText	= "Remember price";
		GuiStatsEnable	= "Show Stats";
		GuiStatsHeader	= "Item Price Statistics";
		GuiStatsHelp	= "Show the following statistics in the tooltip.";
		GuiSuggest	= "Show Suggested Prices";
		GuiUnderlow	= "Lowest Auction Undercut";
		GuiUndermkt	= "Undercut Market When Maxless";
		GuiVerbose	= "Verbose Mode";
		GuiWarnColor	= "Color Pricing Model";


		-- Section: Conversion Messages
		MesgConvert	= "Auctioneer Database Conversion. Please backup your SavedVariables\\Auctioneer.lua first.%s%s";
		MesgConvertNo	= "Disable Auctioneer";
		MesgConvertYes	= "Convert";
		MesgNotconverting	= "Auctioneer is not converting your database, but will not function until you do.";


		-- Section: Game Constants
		TimeLong	= "Long";
		TimeMed	= "Medium";
		TimeShort	= "Short";
		TimeVlong	= "Very Long";


		-- Section: Generic Messages
		DisableMsg	= "Disabling automatic loading of Auctioneer";
		FrmtWelcome	= "Auctioneer v%s loaded";
		MesgNotLoaded	= "Auctioneer is not loaded. Type /auctioneer for more info.";
		StatAskPriceOff	= "AskPrice is now disabled.";
		StatAskPriceOn	= "AskPrice is now enabled.";
		StatOff	= "Not displaying any auction data";
		StatOn	= "Displaying configured auction data";


		-- Section: Generic Strings
		TextAuction	= "auction";
		TextCombat	= "Combat";
		TextGeneral	= "General";
		TextNone	= "none";
		TextScan	= "Scan";
		TextUsage	= "Usage:";


		-- Section: Help Text
		HelpAlso	= "Also display another server's values in the tooltip. For realm, insert the realmname and for faction the faction's name. For example: \"/auctioneer also Al'Akir-Horde\". The special keyword \"opposite\" means the opposite faction, \"off\" disables the functionality.";
		HelpAskPrice	= "Enable or disable AskPrice.";
		HelpAskPriceAd	= "Enable or disable new AskPrice features ad.";
		HelpAskPriceGuild	= "Respond to queries made in guild chat.";
		HelpAskPriceParty	= "Respond to queries made in party chat.";
		HelpAskPriceSmart	= "Enable or disable SmartWords checking.";
		HelpAskPriceTrigger	= "Change AskPrice's trigger character.";
		HelpAskPriceVendor	= "Enable or disable the sending of vendor pricing data.";
		HelpAskPriceWhispers	= "Enable or disable the hiding of all AskPrice outgoing whispers.";
		HelpAskPriceWord	= "Add or modify AskPrice's custom SmartWords.";
		HelpAuctionClick	= "Allows you to Alt-Click an item in your bag to automatically start an auction for it";
		HelpAuctionDuration	= "Set the default auction duration upon opening the Auction House interface";
		HelpAutofill	= "Set whether to autofill prices when dropping new auction items into the auction house window";
		HelpAverage	= "Select whether to show item's average auction price";
		HelpBidbroker	= "Show short or medium term auctions from the recent scan that may be bid on for profit";
		HelpBidLimit	= "Maximum number of auctions to bid on or buyout when the Bid or Buyout button is clicked on the Search Auctions tab.";
		HelpBroker	= "Show any auctions from the most recent scan that may be bid on and then resold for profit";
		HelpClear	= "Clear the specified item's data (you must shift click insert the item(s) into the command) You may also specify the special keywords \"all\" or \"snapshot\"";
		HelpCompete	= "Show any recently scanned auctions whose buyout is less than one of your items";
		HelpDefault	= "Set an Auctioneer option to it's default value. You may also specify the special keyword \"all\" to set all Auctioneer options to their default values.";
		HelpDisable	= "Stops Auctioneer from automatically loading next time you log in";
		HelpEmbed	= "Embed the text in the original game tooltip (note: certain features are disabled when this is selected)";
		HelpEmbedBlank	= "Select whether to show a blank line between the tooltip info and the auction info when embedded mode is on";
		HelpFinish	= "Set whether to automatically logout or exit the game upon finishing an auction house scan";
		HelpFinishSound	= "Set whether to play a sound at the end of an Auction House scan.";
		HelpLink	= "Select whether to show the link id in the tooltip";
		HelpLoad	= "Change Auctioneer's load settings for this toon";
		HelpLocale	= "Change the locale that is used to display Auctioneer messages";
		HelpMedian	= "Select whether to show item's median buyout price";
		HelpOnoff	= "Turns the auction data display on and off";
		HelpPctBidmarkdown	= "Set the percentage that Auctioneer will mark down bids from the buyout price";
		HelpPctMarkup	= "The percentage that vendor prices will be marked up when no other values are available";
		HelpPctMaxless	= "Set the maximum percentage that Auctioneer will undercut market value before it gives up";
		HelpPctNocomp	= "The percentage that Auctioneer will undercut market value when there is no competition";
		HelpPctUnderlow	= "Set the percentage that Auctioneer will undercut the lowest auction price";
		HelpPctUndermkt	= "Percentage to cut market value by when unable to beat competition (due to maxless)";
		HelpPercentless	= "Show any recently scanned auctions whose buyout is a certain percent less than the highest sellable price";
		HelpPrintin	= "Select which frame Auctioneer will print out it's messages. You can either specify the frame's name or the frame's index.";
		HelpProtectWindow	= "Prevents you from accidentally closing the Auction House interface";
		HelpRedo	= "Select whether to show a warning when the currently scanned AH page has taken too long to scan due to server lag.";
		HelpScan	= "Perform a scan of the auction house at the next visit, or while you are there (there is also a button in the auction pane). Choose which categories you want to scan with the checkboxes.";
		HelpStats	= "Select whether to show item's bid/buyout percentages";
		HelpSuggest	= "Select whether to show item's suggested auction price";
		HelpUpdatePrice	= "Automatically update the starting price for an auction on the Post Auctions tab when the buyout price changes.";
		HelpVerbose	= "Select whether to show averages and suggestions verbosely (or off to show them on a single line)";
		HelpWarnColor	= "Select whether to show the current AH pricing model (Undercutting by...) in intuitive colors.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "No empty pack space found to create auction!";
		FrmtNotEnoughOfItem	= "Not enough %s found to create auction!";
		FrmtPostedAuction	= "Posted 1 auction of %s (x%d)";
		FrmtPostedAuctions	= "Posted %d auctions of %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "curBid";
		FrmtBidbrokerDone	= "Bid brokering done";
		FrmtBidbrokerHeader	= "Minimum profit: %s, HSP = 'Highest Sellable Price'";
		FrmtBidbrokerLine	= "%s, Last %s seen, HSP: %s, %s: %s, Prof: %s, Time: %s";
		FrmtBidbrokerMinbid	= "minBid";
		FrmtBrokerDone	= "Brokering done";
		FrmtBrokerHeader	= "Minimum profit: %s, HSP = 'Highest Sellable Price'";
		FrmtBrokerLine	= "%s, Last %s seen, HSP: %s, BO: %s, Prof: %s";
		FrmtCompeteDone	= "Competing auctions done.";
		FrmtCompeteHeader	= "Competing auctions at least %s less per item.";
		FrmtCompeteLine	= "%s, Bid: %s, BO %s vs %s, %s less";
		FrmtHspLine	= "Highest Sellable Price for one %s is: %s";
		FrmtLowLine	= "%s, BO: %s, Seller: %s, For one: %s, Less than median: %s";
		FrmtMedianLine	= "Of last %d seen, median BO for 1 %s is: %s";
		FrmtNoauct	= "No auctions found for the item: %s";
		FrmtPctlessDone	= "Percent less done.";
		FrmtPctlessHeader	= "Percent Less than Highest Sellable Price (HSP): %d%%";
		FrmtPctlessLine	= "%s, Last %d seen, HSP: %s, BO: %s, Prof: %s, Less %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Defunct auctions removed: %s";
		AuctionDiscrepancies	= "Discrepancies: %s";
		AuctionNewAucts	= "New auctions scanned: %s";
		AuctionOldAucts	= "Previously scanned: %s";
		AuctionPageN	= "Auctioneer: scanning %s page %d of %d\nAuctions per second: %s\nEstimated time left: %s";
		AuctionScanDone	= "Auctioneer: auction scanning finished";
		AuctionScanNexttime	= "Auctioneer will perform a full auction scan the next time you talk to an auctioneer.";
		AuctionScanNocat	= "You must have at least one category selected to scan.";
		AuctionScanRedo	= "Current page took more than %d seconds to complete, retrying page.";
		AuctionScanStart	= "Auctioneer: scanning %s page 1...";
		AuctionTotalAucts	= "Total auctions scanned: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Seen %d times at %s";
		FrmtInfoAverage	= "%s min/%s BO (%s bid)";
		FrmtInfoBidMulti	= "Bids (%s%s ea)";
		FrmtInfoBidOne	= "Bids%s";
		FrmtInfoBidrate	= "%d%% have bids, %d%% have BO";
		FrmtInfoBuymedian	= "Buyout median";
		FrmtInfoBuyMulti	= "Buyout (%s%s ea)";
		FrmtInfoBuyOne	= "Buyout%s";
		FrmtInfoForone	= "For 1: %s min/%s BO (%s bid) [in %d's]";
		FrmtInfoHeadMulti	= "Averages for %d items:";
		FrmtInfoHeadOne	= "Averages for this item:";
		FrmtInfoHistmed	= "Last %d, median BO (ea)";
		FrmtInfoMinMulti	= "Starting bid (%s ea)";
		FrmtInfoMinOne	= "Starting bid";
		FrmtInfoNever	= "Never seen at %s";
		FrmtInfoSeen	= "Seen %d times at auction total";
		FrmtInfoSgst	= "Suggested price: %s min/%s BO";
		FrmtInfoSgststx	= "Suggested price for your %d stack: %s min/%s BO";
		FrmtInfoSnapmed	= "Scanned %d, median BO (ea)";
		FrmtInfoStacksize	= "Average stack size: %d items";


		-- Section: User Interface
		FrmtLastSoldOn	= "Last Sold on %s";
		UiBid	= "Bid";
		UiBidHeader	= "Bid";
		UiBidPerHeader	= "Bid Per";
		UiBuyout	= "Buyout";
		UiBuyoutHeader	= "Buyout";
		UiBuyoutPerHeader	= "Buyout Per";
		UiBuyoutPriceLabel	= "Buyout Price:";
		UiBuyoutPriceTooLowError	= "(Too Low)";
		UiCategoryLabel	= "Category Restriction:";
		UiDepositLabel	= "Deposit:";
		UiDurationLabel	= "Duration:";
		UiItemLevelHeader	= "Lvl";
		UiMakeFixedPriceLabel	= "Make fixed price";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Maximum Price:";
		UiMaximumTimeLeftLabel	= "Maximum Time Left:";
		UiMinimumPercentLessLabel	= "Minimum Percent Less:";
		UiMinimumProfitLabel	= "Minimum Profit:";
		UiMinimumQualityLabel	= "Minimum Quality:";
		UiMinimumUndercutLabel	= "Minimum Undercut:";
		UiNameHeader	= "Name";
		UiNoPendingBids	= "All bid requests complete!";
		UiNotEnoughError	= "(Not Enough)";
		UiPendingBidInProgress	= "1 bid request in progress...";
		UiPendingBidsInProgress	= "%d bid requests in progress...";
		UiPercentLessHeader	= "Pct";
		UiPost	= "Post";
		UiPostAuctions	= "Post Auctions";
		UiPriceBasedOnLabel	= "Price Based On:";
		UiPriceModelAuctioneer	= "Auctioneer Price";
		UiPriceModelCustom	= "Custom Price";
		UiPriceModelFixed	= "Fixed Price";
		UiPriceModelLastSold	= "Last Price Sold";
		UiProfitHeader	= "Profit";
		UiProfitPerHeader	= "Profit Per";
		UiQuantityHeader	= "Qty";
		UiQuantityLabel	= "Quantity:";
		UiRemoveSearchButton	= "Delete";
		UiSavedSearchLabel	= "Saved searches:";
		UiSaveSearchButton	= "Save";
		UiSaveSearchLabel	= "Save this search:";
		UiSearch	= "Search";
		UiSearchAuctions	= "Search Auctions";
		UiSearchDropDownLabel	= "Search:";
		UiSearchForLabel	= "Search For Item:";
		UiSearchTypeBids	= "Bids";
		UiSearchTypeBuyouts	= "Buyouts";
		UiSearchTypeCompetition	= "Competition";
		UiSearchTypePlain	= "Item";
		UiStacksLabel	= "Stacks";
		UiStackTooBigError	= "(Stack Too Big)";
		UiStackTooSmallError	= "(Stack Too Small)";
		UiStartingPriceLabel	= "Starting Price:";
		UiStartingPriceRequiredError	= "(Required)";
		UiTimeLeftHeader	= "Time Left";
		UiUnknownError	= "(Unknown)";

	};

	esES = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Recibe precios para paquetes con %sx[Enlace de Art\195\173culo] (x = tama\195\177o del paquete)";
		FrmtAskPriceBuyoutMedianHistorical	= "%sMediano historico: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sMediano \195\186ltima busqueda: %s%s";
		FrmtAskPriceDisable	= "Desabilitando la opci\195\179n %s de PreguntaPrecios";
		FrmtAskPriceEach	= "(%s c/u)";
		FrmtAskPriceEnable	= "Encendiendo la opci\195\179n %s de PreguntaPrecios";
		FrmtAskPriceVendorPrice	= "%sVender a vendedores por: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Quitando %s de la casa de subastas.";
		FrmtAuctinfoHist	= "%d Hist\195\179rico";
		FrmtAuctinfoLow	= "Precio mas bajo";
		FrmtAuctinfoMktprice	= "Precio del mercado";
		FrmtAuctinfoNolow	= "Objeto no ha sido visto antes en la Casa de Subastas";
		FrmtAuctinfoOrig	= "Oferta Original";
		FrmtAuctinfoSnap	= "%d en la \195\186ltima exploraci\195\179n";
		FrmtAuctinfoSugbid	= "Oferta inicial";
		FrmtAuctinfoSugbuy	= "Opci\195\179n a compra sugerida";
		FrmtWarnAbovemkt	= "Competencia sobre mercado";
		FrmtWarnMarkup	= "Superando vendedor por %s%%";
		FrmtWarnMyprice	= "Usando mi precio actual";
		FrmtWarnNocomp	= "Sin competencia";
		FrmtWarnNodata	= "Sin informaci\195\179n para PMV";
		FrmtWarnToolow	= "Imposible igualar m\195\173nimo";
		FrmtWarnUndercut	= "Socavando por %s%%";
		FrmtWarnUser	= "Usando precio de usuario";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Ya eres el licitador mas alto en la subasta: %s (x%d)";
		FrmtBidAuction	= "Oferta en la subasta: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Error: \194\161Lista de ofertas fuera de sinc.!";
		FrmtBoughtAuction	= "Se compr\195\179 subasta: %s (x%d)";
		FrmtMaxBidsReached	= "Mas subastas de %s (x%d) encontradas, pero se lleg\195\179 al limite de peticiones (%d)";
		FrmtNoAuctionsFound	= "No se encontro subasta: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "No se encontraron mas subastas: %s (x%d)";
		FrmtNotEnoughMoney	= "No tienes suficiente dinero para pujar en la subasta: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Saltando subasta con petici\195\179n mayor: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Saltando subasta con petici\195\179n menor: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Saltando petici\195\179n en subasta propia: %s (x%d)";
		UiProcessingBidRequests	= "Procesando petici\195\179n de oferta...";


		-- Section: Command Messages
		FrmtActClearall	= "Eliminando toda la informaci\195\179n de subastas para %s";
		FrmtActClearFail	= "Imposible encontrar art\195\173\194\173culo: %s";
		FrmtActClearOk	= "Informaci\195\179n eliminada para el art\195\173\194\173culo: %s";
		FrmtActClearsnap	= "Removiendo informacion de la casa de subastas.";
		FrmtActDefault	= "La opci\195\179n %s de Auctioneer ha sido cambiada a su modo original";
		FrmtActDefaultall	= "Todas las opciones de Auctioneer han sido cambiadas a su modo original";
		FrmtActDisable	= "Ocultando informacion de: %s ";
		FrmtActEnable	= "Mostrando informacion de: %s ";
		FrmtActSet	= "%s ajustado(a) a '%s'";
		FrmtActUnknown	= "Palabra clave desconocida: '%s'";
		FrmtAuctionDuration	= "Duraci\195\179n de las subastas fijado a: %s";
		FrmtAutostart	= "Comenzando subasta automaticamente para %s: %s m\195\173\194\173nimo, %s opci\195\179n a compra (%dh)\n%s";
		FrmtFinish	= "Despues de una exploraci\195\179n ha terminado, nosotros %s";
		FrmtPrintin	= "Los mensajes de Auctioneer se imprimir\195\161n en la ventana de comunicaci\195\179n \"%s\"";
		FrmtProtectWindow	= "Protecci\195\179n de la ventana de la Casa de Subastas fijado a: %s";
		FrmtUnknownArg	= "'%s' no es un argumento valido de '%s'";
		FrmtUnknownLocale	= "La localizaci\195\179n que usted especifico ('%s') no es valida. Locales v\195\161lidos son:";
		FrmtUnknownRf	= "Parametro inv\195\161lido ('%s'). El par\195\161metro debe de estar en la forma de: [reino]-[facci\195\179n]. Por ejemplo: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(reino-facci\195\179n|opuesta|casa|neutral)";
		OptAuctionDuration	= "(\195\186ltima|2h|8h|24h)";
		OptBidbroker	= "<ganancia_plata>";
		OptBidLimit	= "<n\195\186mero>";
		OptBroker	= "<ganancia_plata>";
		OptClear	= "([Art\195\173\194\173culo]|todo|imagen)";
		OptCompete	= "<plata_menos>";
		OptDefault	= "(<opci\195\179n>|todo)";
		OptFinish	= "(apagado|de-registrarse|salir)";
		OptLocale	= "<localidad>";
		OptPctBidmarkdown	= "<porciento>";
		OptPctMarkup	= "<porciento>";
		OptPctMaxless	= "<porciento>";
		OptPctNocomp	= "<porciento>";
		OptPctUnderlow	= "<porciento>";
		OptPctUndermkt	= "<porciento>";
		OptPercentless	= "<porciento>";
		OptPrintin	= "(<\195\173ndiceVentana>[N\195\186mero]|<nombreVentana>[Serie])";
		OptProtectWindow	= "(nunca|explorar|siempre)";
		OptScale	= "<escala>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "tambien";
		CmdAlsoOpposite	= "opuesta";
		CmdAlt	= "Alt";
		CmdAskPriceAd	= "anuncio";
		CmdAskPriceGuild	= "gremio";
		CmdAskPriceParty	= "grupo";
		CmdAskPriceSmart	= "inteligente";
		CmdAskPriceSmartWord1	= "cuanto";
		CmdAskPriceSmartWord2	= "vale";
		CmdAskPriceTrigger	= "gatillo";
		CmdAskPriceVendor	= "vendedor";
		CmdAskPriceWhispers	= "susurros";
		CmdAskPriceWord	= "palabra";
		CmdAuctionClick	= "click-subasta";
		CmdAuctionDuration	= "duracion-subasta";
		CmdAuctionDuration0	= "\195\186ltima";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "autoinsertar";
		CmdBidbroker	= "corredor de ofertas";
		CmdBidbrokerShort	= "co";
		CmdBidLimit	= "limite-peticiones";
		CmdBroker	= "corredor";
		CmdClear	= "borrar";
		CmdClearAll	= "todo";
		CmdClearSnapshot	= "imagen";
		CmdCompete	= "competir";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "original";
		CmdDisable	= "deshabilitar";
		CmdEmbed	= "integrado";
		CmdFinish	= "terminar";
		CmdFinish0	= "apagado";
		CmdFinish1	= "salir";
		CmdFinish2	= "salir";
		CmdFinish3	= "recargar";
		CmdFinishSound	= "sonido-terminar";
		CmdHelp	= "ayuda";
		CmdLocale	= "localidad";
		CmdOff	= "apagado";
		CmdOn	= "activar";
		CmdPctBidmarkdown	= "pct-menosoferta";
		CmdPctMarkup	= "pct-mas";
		CmdPctMaxless	= "pct-sinmaximo";
		CmdPctNocomp	= "pct-sincomp";
		CmdPctUnderlow	= "pct-bajomenor";
		CmdPctUndermkt	= "pct-bajomercado";
		CmdPercentless	= "porcientomenos";
		CmdPercentlessShort	= "pm";
		CmdPrintin	= "imprimir-en";
		CmdProtectWindow	= "protejer-ventana";
		CmdProtectWindow0	= "nunca";
		CmdProtectWindow1	= "explorar";
		CmdProtectWindow2	= "siempre";
		CmdScan	= "explorar";
		CmdShift	= "Shift";
		CmdToggle	= "invertir";
		CmdUpdatePrice	= "actualizaci\195\179n-precio";
		CmdWarnColor	= "color-advertencia";
		ShowAverage	= "ver-promedio";
		ShowEmbedBlank	= "ver-integrado-lineavacia";
		ShowLink	= "ver-enlace";
		ShowMedian	= "ver-promedio";
		ShowRedo	= "ver-advertencia";
		ShowStats	= "ver-estad\195\173sticas";
		ShowSuggest	= "ver-sugerencia";
		ShowVerbose	= "ver-literal";


		-- Section: Config Text
		GuiAlso	= "Tambi\195\169n mostrar valores para";
		GuiAlsoDisplay	= "Mostrando informaci\195\179n para %s";
		GuiAlsoOff	= "Dejar de mostrar informaci\195\179n para otro(s) reino(s)-facci\195\179n(es)";
		GuiAlsoOpposite	= "Mostrando informaci\195\179n para la facci\195\179n opuesta.";
		GuiAskPrice	= "Encender AskPrice";
		GuiAskPriceAd	= "Enviar anuncio";
		GuiAskPriceGuild	= "Responder al gremio";
		GuiAskPriceHeader	= "Opciones de AskPrice";
		GuiAskPriceHeaderHelp	= "Cambia el functionamiento de AskPrice";
		GuiAskPriceParty	= "Responder al grupo";
		GuiAskPriceSmart	= "Usar palabras inteligentes";
		GuiAskPriceTrigger	= "Gatillo de AskPrice";
		GuiAskPriceVendor	= "Enviar informaci\195\179n de Venta a Vendedores";
		GuiAskPriceWhispers	= "Ver susurros salientes";
		GuiAskPriceWord	= "Palabra inteligente particular %d";
		GuiAuctionDuration	= "Duraci\195\179n por defecto de las subastas";
		GuiAuctionHouseHeader	= "Ventana de la Casa de Subastas";
		GuiAuctionHouseHeaderHelp	= "Modificar el comportamiento de la ventana de la Casa de Subastas";
		GuiAutofill	= "Autocompletar precios en la casa de subastas";
		GuiAverages	= "Mostrar Promedios";
		GuiBidmarkdown	= "Porciento menos oferta";
		GuiClearall	= "Eliminar toda la informaci\195\179n";
		GuiClearallButton	= "Eliminar Todo";
		GuiClearallHelp	= "Seleccione aqui para eliminar toda la informaci\195\179n de Auctioneer para el servidor-reino actual.";
		GuiClearallNote	= "para el servidor-reino actual.";
		GuiClearHeader	= "Eliminar Informaci\195\179n";
		GuiClearHelp	= "Elimina la informacion de Auctioneer. \nSelecciona si eliminar toda la informaci\195\179n o solamente la im\195\161gen actual.\nADVERTENCIA: Estas acciones NO son reversibles.";
		GuiClearsnap	= "Eliminar imagen corriente";
		GuiClearsnapButton	= "Eliminar Imagen";
		GuiClearsnapHelp	= "Presione aqui para eliminar la ultima imagen de informacion de Auctioneer.";
		GuiDefaultAll	= "Revertir todas las opciones";
		GuiDefaultAllButton	= "Revertir Todo";
		GuiDefaultAllHelp	= "Seleccione aqui para revertir todas las opciones de Auctioneer a sus configuraciones de f\195\161brica.\nADVERTENCIA: Esta acci\195\179n NO es reversible.";
		GuiDefaultOption	= "Revertir esta opci\195\179n";
		GuiEmbed	= "Integrar informaci\195\179n en la caja de ayuda";
		GuiEmbedBlankline	= "Mostrar linea en blanco.";
		GuiEmbedHeader	= "Integraci\195\179n";
		GuiFinish	= "Despues de completar exploracion";
		GuiFinishSound	= "Tocar sonido al completar exploraci\195\179n";
		GuiLink	= "Ver numero de enlace";
		GuiLoad	= "Cargar Auctioneer";
		GuiLoad_Always	= "siempre";
		GuiLoad_AuctionHouse	= "en la Casa de Subastas";
		GuiLoad_Never	= "nunca";
		GuiLocale	= "Ajustar localidad a";
		GuiMainEnable	= "Encender Auctioneer";
		GuiMainHelp	= "Contiene ajustes para Auctioneer \nun aditamento que muestra informacion sobre art\195\173culos y analiza informaci\195\179n de subastas. \nSeleccione \"Explorar\" en la casa de subastas para coleccionar informacion sobre las subastas.";
		GuiMarkup	= "Porciento sobre vendedor";
		GuiMaxless	= "Porciento m\195\161ximo bajo mercado";
		GuiMedian	= "Mostrar Medianos";
		GuiNocomp	= "Porciento sin competencia.";
		GuiNoWorldMap	= "Auctioneer: suprimi\195\179 la exhibici\195\179n del mapa del mundo";
		GuiOtherHeader	= "Otras Opciones";
		GuiOtherHelp	= "Opciones miscel\195\161neas de Auctioneer";
		GuiPercentsHeader	= "Limites de Porcentajes de Auctioneer";
		GuiPercentsHelp	= "ADVERTENCIA: Las siguientes opciones son para usuarios expertos SOLAMENTE.\nAjuste los siguientes valores para cambiar cuan agresivo es Auctioneer al determinar niveles provechosos.";
		GuiPrintin	= "Seleccione la ventana deseada";
		GuiProtectWindow	= "Prevenir el cierre de la ventana de la Casa de Subastas";
		GuiRedo	= "Mostrar Advertencia de Exploraci\195\179n";
		GuiReloadui	= "Recargar Interf\195\161z";
		GuiReloaduiButton	= "Recargar";
		GuiReloaduiFeedback	= "Recargando el Interf\195\161z de WoW";
		GuiReloaduiHelp	= "Presione aqui para recargar el interf\195\161z de WoW luego de haber seleccionado una localidad diferente. Esto es para que el lenguaje de configuraci\195\179n sea el mismo que el de Auctioneer.\nNota: Esta operaci\195\179n puede tomar unos minutos.";
		GuiRememberText	= "Recordar precio";
		GuiStatsEnable	= "Ver estad\195\173sticas";
		GuiStatsHeader	= "Estad\195\173sticas de precios de art\195\173culos";
		GuiStatsHelp	= "Mostrar las siguientes estad\195\173sticas en la caja de ayuda.";
		GuiSuggest	= "Mostrar Precios Sugeridos";
		GuiUnderlow	= "Porciento bajo menor subasta";
		GuiUndermkt	= "Porciento bajo mercado";
		GuiVerbose	= "Modo literal";
		GuiWarnColor	= "Colorizar Modelo de Valuaci\195\179n";


		-- Section: Conversion Messages
		MesgConvert	= "Conversi\195\179n de base de datos de Auctioneer. Favor de hacer una copia del SavedVariables\\Auctioneer.lua para la reserva primero.%s%s";
		MesgConvertNo	= "Deshabilitar Auctioneer";
		MesgConvertYes	= "Convertir";
		MesgNotconverting	= "Auctioneer no convertir\195\161 su base de datos, pero no funcionar\195\161 hasta que la base de datos sea convertida.";


		-- Section: Game Constants
		TimeLong	= "Largo";
		TimeMed	= "Mediano";
		TimeShort	= "Corto";
		TimeVlong	= "Muy Largo";


		-- Section: Generic Messages
		DisableMsg	= "Deshabilitando la auto-carga de Auctioneer";
		FrmtWelcome	= "Auctioneer versi\195\179n %s cargado";
		MesgNotLoaded	= "Auctioneer no esta cargado. Escriba /auctioneer para mas informaci\195\179n.";
		StatAskPriceOff	= "AskPrice ha sido deshabilitado";
		StatAskPriceOn	= "AskPrice ha sido encendido";
		StatOff	= "Ocultando toda informaci\195\179n de subastas";
		StatOn	= "Mostrando la configuraci\195\179n corriente para la informacion de subastas";


		-- Section: Generic Strings
		TextAuction	= "Subasta";
		TextCombat	= "Combate";
		TextGeneral	= "General";
		TextNone	= "ningun";
		TextScan	= "Explorar";
		TextUsage	= "Uso:";


		-- Section: Help Text
		HelpAlso	= "Mostrar tambi\195\169n los valores de otros servidores en la caja de ayuda. Para el reino escribe el nombre del reino y para facci\195\179n escribe el nombre de la facci\195\179n. Por ejemplo: \"/auctioneer tambien Al'Akir-Horde\". La palabra clave \"opuesta\" significa facci\195\179n opuesta, la palabra clave \"casa\" significa la casa de subastas del reino-facci\195\179n corriente, la palabra clave \"neutral\" significa la casa de subastas neutral para el reino corriente, \"apagar\" desabilita la funci\195\179n.";
		HelpAskPrice	= "Encender o apagar AskPrice.";
		HelpAskPriceAd	= "Encender o apagar el anuncio de AskPrice.";
		HelpAskPriceGuild	= "Responder a preguntas en el gremio.";
		HelpAskPriceParty	= "Responder a preguntas en el grupo.";
		HelpAskPriceSmart	= "Encender o apagar las palabras inteligentes.";
		HelpAskPriceTrigger	= "Cambiar el gatillo de AskPrice";
		HelpAskPriceVendor	= "Encender o apagar el envio de informaci\195\179n de venta a vendedores.";
		HelpAskPriceWhispers	= "Encender o apagar el oculto de los susurros salientes de AskPrice.";
		HelpAskPriceWord	= "A\195\177adir o modificar las palabras inteligentes particulares de AskPrice.";
		HelpAuctionClick	= "Permite hacer Alt-Click a un objeto en su bolsa para autom\195\161ticamente iniciar una subasta de \195\169l";
		HelpAuctionDuration	= "Fijar la duraci\195\179n de las subastas al abrir el interf\195\161z de la Casa de Subastas";
		HelpAutofill	= "Auto-completar precios cuando se a\195\177adan art\195\173\194\173culos a subastar en el panel de la casa de subastas";
		HelpAverage	= "Selecciona para mostrar precio promedio de la subasta para el art\195\173\194\173culo";
		HelpBidbroker	= "Muestra subastas de corto o medio termino de la exploraci\195\179n mas reciente a las cuales se puede poner una oferta y obtener ganancia";
		HelpBidLimit	= "M\195\161ximo n\195\186mero de subastas que comprar cuando se aprietan los botones de \"Bid\" o \"Buyout\" en la pesta\195\177a de Explorar Subastas.";
		HelpBroker	= "Muestra las subastas de la exploraci\195\179n mas reciente en las cuales se puede poner una oferta para luego revenderlas para ganancia";
		HelpClear	= "Eliminar la informacion existente sobre el art\195\173\194\173culo(se debe usar shift-click para insertar el/los articulo(s) en el comando) Tambien se pueden especificar las palabras claves \"todo\" or \"imagen\"";
		HelpCompete	= "Muestra cualquier subasta explorada recientemente cuya opci\195\179n a compra es menor que alguno de tus art\195\173\194\173culos";
		HelpDefault	= "Revertir una opci\195\179n de Auctioneer a su configuraci\195\179n de fabrica. Tambi\195\169n puede especificar la palabra clave \"todo\" para revertir todas las opciones de Auctioneer a sus configuraciones de f\195\161brica.";
		HelpDisable	= "Impide que Auctioneer se carge automaticamente la proxima vez que usted entre al juego";
		HelpEmbed	= "Insertar el texto en la caja de ayuda original del juego (nota: algunas capacidades se desabilitan cuando esta opci\195\179n es seleccionada)";
		HelpEmbedBlank	= "Selecciona para mostrar una linea en blanco entre informacion de la caja de ayuda y la informacion de subasta cuando el modo integrado esta seleccionado";
		HelpFinish	= "Selecciona si nos de-registramos o salimos del juego una vez terminada una exploraci\195\179n de la casa de subastas";
		HelpFinishSound	= "Selecciona si tocamos un sonido al finalizar una exploraci\195\179n de la casa de subastas";
		HelpLink	= "Selecciona para mostrar el numero de enlace del art\195\173culo en la caja de ayuda";
		HelpLoad	= "Cambiar las opciones de carga de Auctioneer para este personaje";
		HelpLocale	= "Cambiar la localidad que Auctioneer usa para sus mensajes";
		HelpMedian	= "Selecciona para mostrar el precio promedio para la opci\195\179n a compra";
		HelpOnoff	= "Enciende o apaga la informacion sobre las subastas";
		HelpPctBidmarkdown	= "Ajusta el porcentaje del precio de compra por debajo del cual Auctioneer marcara las ofertas";
		HelpPctMarkup	= "El porcentaje que sera incrementado el precio de venta del vendedor cuando no existan otros valores disponibles.";
		HelpPctMaxless	= "Ajusta el maximo porcentaje por debajo del valor de mercado que Auctioneer tratara de igualar antes de darse por vencido.";
		HelpPctNocomp	= "El porcentaje bajo el precio del mercado que Auctioneer usar\195\161 cuando no hay competencia";
		HelpPctUnderlow	= "Ajusta el porcentaje bajo el menor precio m\195\161\194\173nimo de subasta que Auctioneer aplicar\195\161";
		HelpPctUndermkt	= "Porcentaje a usar cuando sea imposible vencer a la competencia (debido al sinmaximo)";
		HelpPercentless	= "Muestra cualquier subasta recientemente explorada en la que la compra de participaciones es un porcentaje menor del precio de venta mas alto.";
		HelpPrintin	= "Selecciona cual ventana de mensajes va a usar Auctioneer para imprimir su informacion. Puede especificar el nombre o el \195\131\194\173ndice de la ventana.";
		HelpProtectWindow	= "Previene que usted cierre accidentalmente el interf\195\161z de la Casa de Subastas";
		HelpRedo	= "Selecciona para mostrat una advertencia cuando la p\195\161gina corriente en la casa de subastas ha tomado demasiado tiempo para explorar debido a problemas con el servidor.";
		HelpScan	= "Realiza una exploracion de la casa de subastas en la proxima visita, o mientras este alli (tambien existe un bot\195\179n en el panel de la casa de subastas). Seleccione alli las categorias a explorar.";
		HelpStats	= "Selecciona para mostrar porcentajes para ofertas/opci\195\179n a compra del art\195\173\194\173culo";
		HelpSuggest	= "Selecciona para mostrar el precio sugerido de subasta para el art\195\173\194\173culo";
		HelpUpdatePrice	= "Ponga al d\195\173a autom\195\161ticamente el precio que comienza para una subasta en la leng\195\188eta de las subastas del poste cuando el precio buyout cambia.";
		HelpVerbose	= "Selecciona para mostrar promedios literales (O apaga para que aparezcan en una sola linea)";
		HelpWarnColor	= "Selecciona para mostrar en colores intuitivos el modelo de valuaci\195\179n corriente (Socavando por...) de la casa de subastas";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "No se encontr\195\179 espacio en su inventario para crear la subasta!";
		FrmtNotEnoughOfItem	= "No se encontro %s sufuciente para crear la subasta!";
		FrmtPostedAuction	= "Se creo una subasta de %s (x%d)";
		FrmtPostedAuctions	= "Se crearon %d subastas de %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "OfertaCorriente";
		FrmtBidbrokerDone	= "Corredor de ofertas finalizado";
		FrmtBidbrokerHeader	= "Ganancia Minima: %s, PMV = 'Precio Maximo de Venta'";
		FrmtBidbrokerLine	= "%s, Ultimo(s) %s visto(s), PMV: %s, %s: %s, Ganancia: %s, Tiempo: %s";
		FrmtBidbrokerMinbid	= "ofertaMinima";
		FrmtBrokerDone	= "Corredor finalizado";
		FrmtBrokerHeader	= "Ganancia Minima: %s, PMV = 'Precio Maximo de Venta'";
		FrmtBrokerLine	= "%s, Ultimo(s) %s visto(s), PMV: %s, BO: %s, Prof: %s";
		FrmtCompeteDone	= "Subastas compitiendo finalizado.";
		FrmtCompeteHeader	= "Subastas compitiendo por al menos %s debajo por art\195\173\194\173culo.";
		FrmtCompeteLine	= "%s, Oferta: %s, OC %s vs %s, %s menos";
		FrmtHspLine	= "Precio Maximo de Venta por uno %s es: %s";
		FrmtLowLine	= "%s, OC: %s, Vendedor: %s, Por uno: %s, Menos que el mediano: %s";
		FrmtMedianLine	= "De los \195\186ltimos(s) %d vistos, OC mediano por 1 %s es: %s";
		FrmtNoauct	= "No se hallaron subastas para el art\195\173\194\173culo: %s";
		FrmtPctlessDone	= "Porcentajes menores finalizado.";
		FrmtPctlessHeader	= "Porcentaje bajo el Precio Maximo de Venta (PMV): %d%%";
		FrmtPctlessLine	= "%s, \195\186ltimo(s) %d visto(s), PMV: %s, OC: %s, Ganancia: %s, menos %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Subastas viejas removidas: %s";
		AuctionDiscrepancies	= "Discrepancias: %s";
		AuctionNewAucts	= "Nuevas subastas exploradas: %s";
		AuctionOldAucts	= "Subastas exploradas previamente: %s";
		AuctionPageN	= "Auctioneer: Explorando \"%s\" p\195\161gina %d de %d\nSubastas por segundo: %s\nTiempo estimado para completar: %s";
		AuctionScanDone	= "Auctioneer: La exploraci\195\179n de las subastas ha finalizado";
		AuctionScanNexttime	= "Auctioneer ejecutara una exploracion de las subastas la proxima vez que usted hable con un subastador.";
		AuctionScanNocat	= "Usted debe tener al menos una categoria seleccionada para poder explorar.";
		AuctionScanRedo	= "La p\195\161gina corriente ha tomado mas de %d segundos para completar. Tratando p\195\161gina otra vez.";
		AuctionScanStart	= "Auctioneer: Explorando \"%s\" p\195\161gina 1...";
		AuctionTotalAucts	= "Total de subastas exploradas: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Visto %d veces en %s";
		FrmtInfoAverage	= "%s min/%s OC (%s oferta)";
		FrmtInfoBidMulti	= "  Oferta (%s%s c/u)";
		FrmtInfoBidOne	= " %s con propuestas";
		FrmtInfoBidrate	= "%d%% tienen ofertas, %d%% tienen OC";
		FrmtInfoBuymedian	= "  Opci\195\179n a compra promedio";
		FrmtInfoBuyMulti	= "  Opci\195\179n a compra(%s%s c/u)";
		FrmtInfoBuyOne	= " %s con opci\195\179n a compra";
		FrmtInfoForone	= "Por 1: %s min/%s OC (%s oferta) [en %d's]";
		FrmtInfoHeadMulti	= "Promedios para %d art\195\173\194\173culos:";
		FrmtInfoHeadOne	= "Promedios para este art\195\173\194\173culo:";
		FrmtInfoHistmed	= "\195\154ltimo(s) %d, OC mediano (c/u)";
		FrmtInfoMinMulti	= "  Oferta a empezar (%s c/u)";
		FrmtInfoMinOne	= "  Oferta a empezar";
		FrmtInfoNever	= "Nunca visto en %s";
		FrmtInfoSeen	= "Visto un total de %d veces en subasta";
		FrmtInfoSgst	= "Precio sugerido: %s min/%s OC";
		FrmtInfoSgststx	= "Precio sugerido para su lote de %d: %s min/%s OC";
		FrmtInfoSnapmed	= "Explorados %d, OC mediano (c/u)";
		FrmtInfoStacksize	= "Tama\195\177o promedio del paquete: %d art\195\131\194\173culos";


		-- Section: User Interface
		FrmtLastSoldOn	= "\195\154ltima venta en %s";
		UiBid	= "Oferta";
		UiBidHeader	= "Ofertas";
		UiBidPerHeader	= "Oferta c/u";
		UiBuyout	= "Opci\195\179n a Compra";
		UiBuyoutHeader	= "Opci\195\179n a Compra";
		UiBuyoutPerHeader	= "Opci\195\179n a Compra c/u";
		UiBuyoutPriceLabel	= "Precio de Opci\195\179n a compra:";
		UiBuyoutPriceTooLowError	= "(Muy Bajo)";
		UiCategoryLabel	= "Restricci\195\179n de Categor\195\173a:";
		UiDepositLabel	= "Dep\195\179sito:";
		UiDurationLabel	= "Duraci\195\179n:";
		UiItemLevelHeader	= "Nivel";
		UiMakeFixedPriceLabel	= "Hacer precio fijo";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Precio M\195\161ximo";
		UiMaximumTimeLeftLabel	= "Tiempo Restante M\195\161ximo";
		UiMinimumPercentLessLabel	= "Pociento Menos M\195\173nimo";
		UiMinimumProfitLabel	= "Ganancia M\195\173nima";
		UiMinimumQualityLabel	= "Calidad M\195\173nima";
		UiMinimumUndercutLabel	= "Socavaci\195\179n Minima";
		UiNameHeader	= "Nombre";
		UiNoPendingBids	= "\194\161Todos hicieron una oferta las peticiones completas!";
		UiNotEnoughError	= "(No Hay Suficiente)";
		UiPendingBidInProgress	= "1 petici\195\179n hecha una oferta en marcha...";
		UiPendingBidsInProgress	= "%d la oferta solicita en marcha...";
		UiPercentLessHeader	= "Porciento";
		UiPost	= "Fijando";
		UiPostAuctions	= "Fijando Subasta";
		UiPriceBasedOnLabel	= "Precio Basado En:";
		UiPriceModelAuctioneer	= "Precio de Auctioneer";
		UiPriceModelCustom	= "Precio Propio";
		UiPriceModelFixed	= "Precio Fijo";
		UiPriceModelLastSold	= "\195\154ltimo Precio Vendido";
		UiProfitHeader	= "Ganancia";
		UiProfitPerHeader	= "Ganancia c/u";
		UiQuantityHeader	= "Cantidad";
		UiQuantityLabel	= "Cantidad:";
		UiRemoveSearchButton	= "Borrar";
		UiSavedSearchLabel	= "B\195\186squedas grabadas";
		UiSaveSearchButton	= "Grabar";
		UiSaveSearchLabel	= "Grabar esta b\195\186squeda";
		UiSearch	= "Buscar";
		UiSearchAuctions	= "Explorar Subastas";
		UiSearchDropDownLabel	= "Buscar";
		UiSearchForLabel	= "Buscar por art\195\173culo";
		UiSearchTypeBids	= "Ofertas";
		UiSearchTypeBuyouts	= "Opciones a compra";
		UiSearchTypeCompetition	= "Competencia";
		UiSearchTypePlain	= "Art\195\173culo";
		UiStacksLabel	= "Lotes";
		UiStackTooBigError	= "(Lote Muy Grande)";
		UiStackTooSmallError	= "(Lote Muy Peque\195\177o)";
		UiStartingPriceLabel	= "Precio de Inicio";
		UiStartingPriceRequiredError	= "(Requerido)";
		UiTimeLeftHeader	= "Tiempo restante";
		UiUnknownError	= "(Desconocido)";

	};

	frFR = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Prix de la pile pour %sx[LienItem] (x=quantit\195\169)";
		FrmtAskPriceBuyoutMedianHistorical	= "%sAchat imm\195\169diat - historique m\195\169dian: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sAchat imm\195\169diat - m\195\169dian dernier scan: %s%s";
		FrmtAskPriceDisable	= "D\195\169sactiver l'option Demande Prix %s";
		FrmtAskPriceEach	= "(%s chaque)";
		FrmtAskPriceEnable	= "Activer l'option Demande Prix %s";
		FrmtAskPriceVendorPrice	= "%sVente au marchand pour : %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Suppression de %s de l'image de l'HV.";
		FrmtAuctinfoHist	= "%d historique";
		FrmtAuctinfoLow	= "Prix le plus bas";
		FrmtAuctinfoMktprice	= "Prix du march\195\169";
		FrmtAuctinfoNolow	= "Objet non d\195\169tect\195\169 \195\160 la derni\195\168re analyse";
		FrmtAuctinfoOrig	= "Prix de d\195\169part";
		FrmtAuctinfoSnap	= "%d \195\160 la derni\195\168re analyse";
		FrmtAuctinfoSugbid	= "Mise \195\160 prix";
		FrmtAuctinfoSugbuy	= "AI sugg\195\169r\195\169";
		FrmtWarnAbovemkt	= "Concurrence au-dessus du march\195\169";
		FrmtWarnMarkup	= "Prix marchand + %s%%";
		FrmtWarnMyprice	= "Utiliser mon prix actuel";
		FrmtWarnNocomp	= "Aucune concurrence";
		FrmtWarnNodata	= "Prix de vente maximum inconnu";
		FrmtWarnToolow	= "Plus bas prix pratiquable";
		FrmtWarnUndercut	= "Moins cher de %s%%";
		FrmtWarnUser	= "Prix d\195\169fini par l'utilisateur";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "D\195\169j\195\160 le plus haut ench\195\169risseur sur l'ench\195\168re : %s (x%d)";
		FrmtBidAuction	= "Offre sur l'ench\195\168re : %s (x%d)";
		FrmtBidQueueOutOfSync	= "Erreur : File d'ench\195\168re d\195\169synchronis\195\169e";
		FrmtBoughtAuction	= "Achat direct : %s (x%d)";
		FrmtMaxBidsReached	= "D'autres ench\195\168res de %s (x%d) trouv\195\169es, mais nombre limite d'ench\195\168res atteint (%d)";
		FrmtNoAuctionsFound	= "Aucune ench\195\168re trouv\195\169e : %s (x%d)";
		FrmtNoMoreAuctionsFound	= "Plus d'autres ench\195\168res trouv\195\169es : %s (x%d)";
		FrmtNotEnoughMoney	= "Pas assez d'argent pour l'ench\195\168re : %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Ignore ench\195\168res avec une offre plus \195\169lev\195\169e : %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Ignore ench\195\168res avec l'offre inf\195\169rieure : %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Ignore mes propres ench\195\168res : %s (x%d)";
		UiProcessingBidRequests	= "Traitement des ench\195\168res...";


		-- Section: Command Messages
		FrmtActClearall	= "Effacer toutes les donn\195\169es pour l'ench\195\168re %s";
		FrmtActClearFail	= "Objet introuvable : %s";
		FrmtActClearOk	= "Effacer les infos de l'objet : %s";
		FrmtActClearsnap	= "Effacement de l'image actuelle de l'H\195\180tel des Ventes";
		FrmtActDefault	= "R\195\169initialisation de l'option %s \195\160 sa valeur par d\195\169faut";
		FrmtActDefaultall	= "Toutes les options d'Auctioneer ont \195\169t\195\169 r\195\169initialis\195\169es \195\160 leur valeur par d\195\169faut";
		FrmtActDisable	= "Les donn\195\169es de %s ne sont pas affich\195\169es";
		FrmtActEnable	= "Les donn\195\169es de %s sont affich\195\169es";
		FrmtActSet	= "Valeur de %s chang\195\169e en %s";
		FrmtActUnknown	= "Commande inconnue : %s";
		FrmtAuctionDuration	= "La dur\195\169e par d\195\169faut des ench\195\168res est d\195\169sormais de %s";
		FrmtAutostart	= "Ench\195\168re automatique pour %s: mise \195\160 prix %s, achat imm\195\169diat %s (%dh) %s";
		FrmtFinish	= "Apr\195\168s la fin d'un scan, nous allons %s \n";
		FrmtPrintin	= "Les messages d'Auctioneer s'afficheront d\195\169sormais dans la fen\195\170tre de dialogue \"%s\"";
		FrmtProtectWindow	= "Protection de la fen\195\170tre de l'H\195\180tel des Ventes : \"%s\"";
		FrmtUnknownArg	= "'%s' : argument invalide pour '%s'";
		FrmtUnknownLocale	= "La langue que vous avez sp\195\169cifi\195\169e ('%s') est inconnue. Les langues valides sont :";
		FrmtUnknownRf	= "'%s' n'est pas un param\195\168tre valide, doit \195\170tre au format [Royaume]-[Faction] ! Ex : Medhiv-Alliance";


		-- Section: Command Options
		OptAlso	= "(royaume-faction|oppose|allie|neutre)";
		OptAuctionDuration	= "(court|2h|8h|24h)";
		OptBidbroker	= "<gain_argent>";
		OptBidLimit	= "<nombre>";
		OptBroker	= "<gain_argent>";
		OptClear	= "([Objet]|tout|capture)";
		OptCompete	= "<argent_moins>";
		OptDefault	= "(<option>|tout)";
		OptFinish	= "(arret|deconnecter|quitter|rechargeIU)";
		OptLocale	= "<langue>";
		OptPctBidmarkdown	= "<pourcentage>";
		OptPctMarkup	= "<pourcentage>";
		OptPctMaxless	= "<pourcentage>";
		OptPctNocomp	= "<pourcentage>";
		OptPctUnderlow	= "<pourcentage>";
		OptPctUndermkt	= "<pourcentage>";
		OptPercentless	= "<pourcentage>";
		OptPrintin	= "(<IndexFenetre>[Nombre]|<NomFenetre>[Chaine])";
		OptProtectWindow	= "(jamais|analyse|toujours)";
		OptScale	= "<facteur_\195\169chelle>";
		OptScan	= "<parametre_d_analyse>";


		-- Section: Commands
		CmdAlso	= "aussi";
		CmdAlsoOpposite	= "oppose";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "annonce";
		CmdAskPriceGuild	= "guilde";
		CmdAskPriceParty	= "groupe";
		CmdAskPriceSmart	= "intelligent";
		CmdAskPriceSmartWord1	= "que";
		CmdAskPriceSmartWord2	= "vaut";
		CmdAskPriceTrigger	= "declencheur";
		CmdAskPriceVendor	= "vendeur";
		CmdAskPriceWhispers	= "chuchotements";
		CmdAskPriceWord	= "mot-cle";
		CmdAuctionClick	= "enchere-clic";
		CmdAuctionDuration	= "duree-enchere";
		CmdAuctionDuration0	= "dernier";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "remplissage-auto";
		CmdBidbroker	= "agent-enchere";
		CmdBidbrokerShort	= "ae";
		CmdBidLimit	= "limite-offre";
		CmdBroker	= "agent";
		CmdClear	= "effacer";
		CmdClearAll	= "tout";
		CmdClearSnapshot	= "capture";
		CmdCompete	= "concurrence";
		CmdCtrl	= "ctrl";
		CmdDefault	= "defaut";
		CmdDisable	= "desactiver";
		CmdEmbed	= "integrer";
		CmdFinish	= "fin";
		CmdFinish0	= "arret";
		CmdFinish1	= "deconnection";
		CmdFinish2	= "quitter";
		CmdFinish3	= "rechargeIU";
		CmdFinishSound	= "son-final";
		CmdHelp	= "aide";
		CmdLocale	= "langue";
		CmdOff	= "arret";
		CmdOn	= "marche";
		CmdPctBidmarkdown	= "pct-baisse";
		CmdPctMarkup	= "pct-hausse";
		CmdPctMaxless	= "pct-baissemaxi";
		CmdPctNocomp	= "pct-pasdeconcurrence";
		CmdPctUnderlow	= "pct-sousbas";
		CmdPctUndermkt	= "pct-sousmarche";
		CmdPercentless	= "pct-moins";
		CmdPercentlessShort	= "pm";
		CmdPrintin	= "afficher-dans";
		CmdProtectWindow	= "proteger-fenetre";
		CmdProtectWindow0	= "jamais";
		CmdProtectWindow1	= "analyse";
		CmdProtectWindow2	= "toujours";
		CmdScan	= "analyse";
		CmdShift	= "shift";
		CmdToggle	= "active-desactive";
		CmdUpdatePrice	= "actualiser-prix";
		CmdWarnColor	= "couleur-avertissement";
		ShowAverage	= "voir-moyenne";
		ShowEmbedBlank	= "voir-ligneblanche-integree";
		ShowLink	= "voir-lien";
		ShowMedian	= "voir-median";
		ShowRedo	= "voir-avertissement";
		ShowStats	= "voir-stats";
		ShowSuggest	= "voir-suggestion";
		ShowVerbose	= "voir-detail";


		-- Section: Config Text
		GuiAlso	= "Afficher aussi les donn\195\169es pour";
		GuiAlsoDisplay	= "Affichage des donn\195\169es pour %s";
		GuiAlsoOff	= "Ne plus afficher les donn\195\169es provenant d'autres royaumes/factions.";
		GuiAlsoOpposite	= "Afficher maintenant les donn\195\169es de la faction oppos\195\169e.";
		GuiAskPrice	= "Activer DemandePrix";
		GuiAskPriceAd	= "Envoyer les dispositifs d'annonce";
		GuiAskPriceGuild	= "R\195\169pondre aux demandes sur le canal de guilde";
		GuiAskPriceHeader	= "Options de DemandePrix";
		GuiAskPriceHeaderHelp	= "Changer le comportement de DemandePrix";
		GuiAskPriceParty	= "R\195\169pondre aux requ\195\170tes sur le canal de groupe";
		GuiAskPriceSmart	= "Utiliser mots-cl\195\169s intelligents";
		GuiAskPriceTrigger	= "Activateur de DemandePrix";
		GuiAskPriceVendor	= "Envoyer les info du vendeur";
		GuiAskPriceWhispers	= "Montrer chuchotements envoy\195\169s";
		GuiAskPriceWord	= "Mot-cl\195\169 intelligent personnalis\195\169 %d";
		GuiAuctionDuration	= "Dur\195\169e de l'ench\195\168re par d\195\169faut";
		GuiAuctionHouseHeader	= "Fen\195\170tre de l'H\195\180tel des Ventes";
		GuiAuctionHouseHeaderHelp	= "Change le comportement de la fen\195\170tre de l'H\195\180tel des Ventes";
		GuiAutofill	= "Remplit automatiquement les prix \195\160 l'HV";
		GuiAverages	= "Voir moyennes";
		GuiBidmarkdown	= "Pourcentage de baisse d'ench\195\168re";
		GuiClearall	= "Effacer toutes les donn\195\169es d'Auctioneer";
		GuiClearallButton	= "Tout effacer";
		GuiClearallHelp	= "Cliquer ici pour effacer toutes les donn\195\168es d'Auctioneer pour le royaume actuel.";
		GuiClearallNote	= "pour la faction courante du serveur";
		GuiClearHeader	= "Effacer les donn\195\169es";
		GuiClearHelp	= "Effacement des donn\195\169es d'Auctioneer. S\195\169lectionnez toutes les donn\195\169es ou l'image courante. ATTENTION : Ces op\195\168rations sont irreversibles.";
		GuiClearsnap	= "Effacer les donn\195\169es de l'image";
		GuiClearsnapButton	= "Effacer l'image";
		GuiClearsnapHelp	= "Cliquer ici pour effacer les donn\195\169es de la derni\195\168re image d'Auctioneer";
		GuiDefaultAll	= "R\195\169initialisation de toutes les options d'Auctioneer";
		GuiDefaultAllButton	= "R\195\169initialiser tout";
		GuiDefaultAllHelp	= "Cliquer ici pour r\195\169initialiser toutes les options d'Auctioneer. ATTENTION : Cette op\195\169ration est irr\195\169versible.";
		GuiDefaultOption	= "R\195\169initialiser ce param\195\168tre";
		GuiEmbed	= "Int\195\169grer les informations dans la bulle d'aide originale";
		GuiEmbedBlankline	= "Afficher une ligne blanche dans la bulle d'aide";
		GuiEmbedHeader	= "Int\195\169grer";
		GuiFinish	= "Apr\195\168s la fin d'une analyse";
		GuiFinishSound	= "Jouer un son \195\160 la fin d'une analyse";
		GuiLink	= "Montrer ID du Lien";
		GuiLoad	= "Charger Auctioneer";
		GuiLoad_Always	= "toujours";
		GuiLoad_AuctionHouse	= "\195\160 l'H\195\180tel des Ventes";
		GuiLoad_Never	= "jamais";
		GuiLocale	= "Changer la langue en";
		GuiMainEnable	= "Activer Auctioneer";
		GuiMainHelp	= "Contient les r\195\169glages d'Auctionner, un AddOn affichant les infos des objets et analyse les donn\195\169es de vente aux ench\195\168res. Cliquez le bouton \"Analyse\" de l'H\195\180tel des Ventes pour r\195\169cup\195\169rer les donn\195\169es.";
		GuiMarkup	= "Pourcentage de hausse du prix des vendeurs PNJ";
		GuiMaxless	= "Pourcentage maximal de remise par rapport au march\195\169";
		GuiMedian	= "Voir prix m\195\169dians";
		GuiNocomp	= "Pourcentage de remise en cas de monopole";
		GuiNoWorldMap	= "Auctioneer : affichage de la carte du monde bloqu\195\169e";
		GuiOtherHeader	= "Autres Options";
		GuiOtherHelp	= "Options diverses d'Auctioneer";
		GuiPercentsHeader	= "Pourcentage de tol\195\169rance d'Auctioneer";
		GuiPercentsHelp	= "ATTENTION: Les options suivantes sont pour les utilisateurs exp\195\169riment\195\169s SEULEMENT. La Modification de ces valeurs change l'aggressivit\195\169 d'Auctioneer sur le niveau de marge n\195\169cessaire pour la profitabilit\195\169.";
		GuiPrintin	= "S\195\169lectionner la fen\195\170tre de discussion voulue";
		GuiProtectWindow	= "Emp\195\170che la fermeture accidentelle de la fen\195\170tre de l'HV";
		GuiRedo	= "Afficher l'avertissement d'analyse trop longue";
		GuiReloadui	= "Recharger l'interface utilisateur";
		GuiReloaduiButton	= "RechargerUI";
		GuiReloaduiFeedback	= "Red\195\169marrage de l'UI de WoW";
		GuiReloaduiHelp	= "Cliquer ici pour recharger l'Interface Utilisateur (UI) de WoW apr\195\168s avoir chang\195\169 la langue afin de prendre en compte les changements dans cet \195\169cran de configuration. Remarque : cette op\195\169ration peut prendre quelques minutes.";
		GuiRememberText	= "M\195\169moriser le prix";
		GuiStatsEnable	= "Voir Statistiques";
		GuiStatsHeader	= "Statistiques du Prix de l'Objet";
		GuiStatsHelp	= "Afficher les statistiques suivantes dans la bulle d'aide";
		GuiSuggest	= "Voir les Prix Sugg\195\169r\195\169s";
		GuiUnderlow	= "R\195\169duire le prix de l'ench\195\168re la plus basse";
		GuiUndermkt	= "En dessous du march\195\169 si inf\195\169rieur";
		GuiVerbose	= "Mode d\195\169taill\195\169";
		GuiWarnColor	= "Couleur du mod\195\168le de prix";


		-- Section: Conversion Messages
		MesgConvert	= "Conversion de la base de donn\195\169es d'Auctioneer. Veuillez sauvegarder votre fichier SavedVariables\\Auctioneer.lua avant. %s%s";
		MesgConvertNo	= "D\195\169sactiver Auctioneer";
		MesgConvertYes	= "Convertir";
		MesgNotconverting	= "Auctioneer ne convertit pas votre base de donn\195\169es, mais ne fonctionnera pas tant que vous ne l'aurez pas fait.";


		-- Section: Game Constants
		TimeLong	= "Longue";
		TimeMed	= "Moyenne";
		TimeShort	= "Courte";
		TimeVlong	= "Tr\195\168s Longue";


		-- Section: Generic Messages
		DisableMsg	= "D\195\169sactiver le chargement automatique d'Auctioneer";
		FrmtWelcome	= "Auctioneer v%s est charg\195\169";
		MesgNotLoaded	= "Auctioneer n'est pas charg\195\169. Tapez /auctioneer pour plus d'informations.";
		StatAskPriceOff	= "La fonction DemandePrix est d\195\169sormais d\195\169sactiv\195\169e.";
		StatAskPriceOn	= "La fonction DemandePrix est d\195\169sormais activ\195\169e.";
		StatOff	= "Aucune ench\195\168re \195\160 afficher";
		StatOn	= "Afficher la configuration des ench\195\168res";


		-- Section: Generic Strings
		TextAuction	= "Ench\195\168re";
		TextCombat	= "Combat";
		TextGeneral	= "G\195\169n\195\169ral";
		TextNone	= "Aucun";
		TextScan	= "Analyser";
		TextUsage	= "Utilisation :";


		-- Section: Help Text
		HelpAlso	= "Afficher \195\169galement les donn\195\169es d'un autre serveur dans la bulle d'aide. Pour le royaume, ins\195\169rer le nom du royaume et pour la faction, le nom de la faction. Par exemple : \"/auctioneer additionnel Medhiv-Horde\". Le mot-clef \"oppos\195\169\" indique la faction oppos\195\169e, \"arr\195\170t\" d\195\169sactive cette fonctionnalit\195\169.";
		HelpAskPrice	= "Activer ou d\195\169sactiver DemandePrix.";
		HelpAskPriceAd	= "Activer ou d\195\169sactiver la nouvelle fonction d'annonce DemandePrix.";
		HelpAskPriceGuild	= "R\195\169pondre aux demandes faites dans le canal de guilde.";
		HelpAskPriceParty	= "R\195\169pondre aux demandes faites dans le canal de groupe.";
		HelpAskPriceSmart	= "Activer ou d\195\169sactiver la v\195\169rification de MotCl\195\169";
		HelpAskPriceTrigger	= "Changer la clef d'amorcage de DemandePrix.";
		HelpAskPriceVendor	= "Activer ou d\195\169sactiver l'envoie des infos de prix au marchand";
		HelpAskPriceWhispers	= "Cacher ou non les chuchotements envoy\195\169s par DemandePrix\n";
		HelpAskPriceWord	= "Ajouter ou modifier un mot-cl\195\169 intelligent personnalis\195\169 de DemandePrix.";
		HelpAuctionClick	= "ALT-Clic d'un objet de votre sac pour le placer automatiquement aux ench\195\168res";
		HelpAuctionDuration	= "D\195\169finit la dur\195\169e d'ench\195\168re par d\195\169faut lors de l'ouverture de la fen\195\170tre de l'H\195\180tel de Ventes";
		HelpAutofill	= "Active le remplissage automatique du prix de vente lors de la mise aux ench\195\168res d'un objet dans la fen\195\170tre de l'H\195\180tel des Ventes";
		HelpAverage	= "Choisir d'afficher le prix moyen d'ench\195\168re des objets";
		HelpBidbroker	= "Afficher les ench\195\168res \195\160 court ou moyen terme de l'analyse la plus r\195\169cente sur lesquelles ench\195\169rir pour revendre avec b\195\169n\195\169fice";
		HelpBidLimit	= "Nombre maximum d'ench\195\168res sur lesquelless ench\195\169rir ou acheter imm\195\169diatement lorsque le bouton Ench\195\169rir ou Acheter est s\195\169lectionn\195\169 dans l'onglet Recherche Ench\195\168res";
		HelpBroker	= "Montrer toutes les ench\195\168res de l'analyse la plus r\195\169cente sur lesquelles ench\195\169rir pour revendre avec b\195\169n\195\169fice";
		HelpClear	= "Effacer les donn\195\169es d'un objet sp\195\169cifi\195\169 (vous devez 'SHIFT-cliquer' l'objet dans la ligne de commande) Vous pouvez \195\169galement sp\195\169cifier les mots-cl\195\169s \"tout\" ou \"capture\"";
		HelpCompete	= "Montrer parmi les ench\195\168res r\195\169cemment scann\195\169es celles dont le prix d'achat imm\195\169diat est inf\195\169rieur \195\160 celui d'un de vos objets.";
		HelpDefault	= "R\195\169initialise une option d'Auctionner \195\160 sa valeur par d\195\169faut. Vous pouvez \195\169galement sp\195\169cifier le mot-cl\195\169 \"tout\" pour r\195\169initialiser toutes les options d'Autionneer \195\160 leurs valeurs par d\195\169faut.";
		HelpDisable	= "Emp\195\170che le chargement automatique d'Auctioneer lors de votre prochaine connexion";
		HelpEmbed	= "Int\195\168gre le texte dans les bulles d'aide originale (remarque: certaines fonctions seront d\195\169sactiv\195\169es)";
		HelpEmbedBlank	= "Choisir d'afficher une ligne vide entre les infos de bulle d'aide et d'ench\195\168re en mode int\195\169gr\195\169";
		HelpFinish	= "Se d\195\169connecter ou sortir du jeu apr\195\168s avoir fini un scan de l'H\195\180tel des ventes";
		HelpFinishSound	= "D\195\169termine si il faut jouer un son \195\160 la fin d'une analyse de l'H\195\180tel des ventes";
		HelpLink	= "Choisir d'afficher l'identifiant du lien dans la bulle d'aide";
		HelpLoad	= "Change les r\195\169glages de chargement pour ce personnage";
		HelpLocale	= "Choisir la langue dans laquelle afficher les messages d'Auctioneer";
		HelpMedian	= "Choisir d'afficher le prix d'achat imm\195\169diat moyen";
		HelpOnoff	= "Active ou d\195\169sactive l'affichage des donn\195\169es des ench\195\168res";
		HelpPctBidmarkdown	= "D\195\169finit le pourcentage de r\195\169duction par rapport au prix d'achat imm\195\169diat utilis\195\169 par Auctioneer";
		HelpPctMarkup	= "Pourcentage \195\160 utiliser par rapport au prix des marchands quand aucune autre donn\195\169e n'est disponible";
		HelpPctMaxless	= "D\195\169finit la r\195\169duction maximale en pourcentage qu'Auctionner utilisera par rapport au prix du march\195\169 avant d'abandonner";
		HelpPctNocomp	= "Pourcentage qu'Auctionner doit utiliser pour g\195\169n\195\169rer  une r\195\169duction par rapport au prix du march\195\169 quand il n'y a pas de concurrence";
		HelpPctUnderlow	= "D\195\169finit le pourcentage de r\195\169duction par rapport au prix le plus bas de l'H\195\180tel des ventes qu'Auctionner doit utiliser ";
		HelpPctUndermkt	= "Pourcentage de r\195\169duction par rapport au prix du march\195\169 quand la concurrence ne peut \195\170tre battue (\195\160 cause du maxbas)";
		HelpPercentless	= "Afficher parmi les ench\195\168res r\195\169cemment scann\195\169es celles dont le prix d'achat imm\195\169diat est inf\195\169rieur d'un certain pourcentage au prix de vente maximum";
		HelpPrintin	= "Choisir quelle fen\195\170tre affichera les messages d'Auctioneer. Vous pouvez sp\195\169cifier le nom de la fen\195\170tre ou son indice.";
		HelpProtectWindow	= "Emp\195\170che la fermeture accidentelle de la fen\195\170tre de l'H\195\180tel des Ventes";
		HelpRedo	= "Choisir d'afficher un avertissement lorsque l'analyse de la page actuelle de l'H\195\180tel des Ventes prend trop longtemps en raison d'une latence du serveur.";
		HelpScan	= "Ex\195\169cute une analyse de l'H\195\180tel des ventes lors de votre prochaine visite, ou imm\195\169diatement si vous y \195\170tes (il y a \195\169galement un bouton dans l'interface de l'H\195\180tel des ventes). Choisissez les cat\195\169gories que vous souhaitez analyser avec les cases \195\160 cocher.";
		HelpStats	= "Choisir d'afficher les pourcentages d'ench\195\168re/achat imm\195\169diat";
		HelpSuggest	= "Choisir d'afficher le prix sugg\195\169r\195\169 pour l'objet";
		HelpUpdatePrice	= "Dans l'onglet 'Ventes avanc\195\169es', mettre \195\160 jour automatiquement le prix de d\195\169part quand le prix d'achat directe change.";
		HelpVerbose	= "Choisir d'afficher les moyennes et les suggestions de mani\195\168re d\195\169taill\195\169e (ou \"arr\195\170t\" pour les afficher sur une seule ligne)";
		HelpWarnColor	= "Choisir de montrer le mod\195\168le de prix de l'HV courant (en dessous du march\195\169, ...) avec des couleurs intuitives.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Aucun emplacement vide n'a \195\169t\195\169 trouv\195\169 pour cr\195\169er l'ench\195\168re !";
		FrmtNotEnoughOfItem	= "Pas assez de %s trouv\195\169 pour cr\195\169er l'ench\195\168re !";
		FrmtPostedAuction	= "Cr\195\169\195\169 1 ench\195\168re de %s (x%d)";
		FrmtPostedAuctions	= "Cr\195\169\195\169 %d ench\195\168res de %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "EnchAct";
		FrmtBidbrokerDone	= "L'agent d'ench\195\168re \195\160 termin\195\169";
		FrmtBidbrokerHeader	= "Gain minimum : %s, PVM = 'Prix de Vente Maximum'";
		FrmtBidbrokerLine	= "%s, Derniers %s vus, PVM : %s, %s : %s, Gain : %s, Temps : %s";
		FrmtBidbrokerMinbid	= "EnchMin";
		FrmtBrokerDone	= "L'agent a termin\195\169";
		FrmtBrokerHeader	= "Gain Minimum : %s, PVM = 'Prix de Vente Maximum'";
		FrmtBrokerLine	= "%s, Derniers %s vus, PVM : %s, AI : %s, Gain : %s";
		FrmtCompeteDone	= "Ench\195\168res en concurrence termin\195\169es.";
		FrmtCompeteHeader	= "Ench\195\168res en concurrence d'au moins %s de moins par objet.";
		FrmtCompeteLine	= "%s, Ench : %s, AI %s vs %s, %s de moins";
		FrmtHspLine	= "Le prix de vente maximum pour un %s est de : %s";
		FrmtLowLine	= "%s, AI : %s, Vendeur : %s, L'unit\195\169e : %s, Inf\195\169rieur au m\195\169dian de : %s";
		FrmtMedianLine	= "Des derniers %d vus, l'achat moyen pour 1 %s est de : %s";
		FrmtNoauct	= "Pas d'ench\195\168res trouv\195\169es pour l'objet : %s";
		FrmtPctlessDone	= "Pourcentage inf\195\169rieur termin\195\169.";
		FrmtPctlessHeader	= "R\195\169duction par rapport au PVM : %d%%";
		FrmtPctlessLine	= "%s, Derniers %d vus, PVM : %s, AI : %s, Gain : %s, Moins %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Ventes termin\195\169es retir\195\169es : %s";
		AuctionDiscrepancies	= "Ecarts :";
		AuctionNewAucts	= "Nouvelles ench\195\168res analys\195\169es : %s";
		AuctionOldAucts	= "Analys\195\169es pr\195\169c\195\169demment : %s";
		AuctionPageN	= "Auctioneer : analyse en cours, cat\195\169gorie '%s', \npage %d sur %d,\n%s ench\195\168res/s. \nTemps restant estim\195\169 : %s";
		AuctionScanDone	= "Auctioneer : analyse termin\195\169e";
		AuctionScanNexttime	= "Auctioneer fera une analyse compl\195\168te de l'H\195\180tel des Ventes la prochaine fois que vous parlerez \195\160 un commissaire-priseur.";
		AuctionScanNocat	= "Vous devez s\195\169lectionner au moins une cat\195\169gorie pour analyser.";
		AuctionScanRedo	= "La page actuelle a mis plus de %d secondes pour \195\170tre analys\195\169e, nouvelle tentative.";
		AuctionScanStart	= "Auctioneer : analyse '%s', page 1";
		AuctionTotalAucts	= "Nb total d'ench\195\168res analys\195\169es : %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Vu %d fois \195\160 %s";
		FrmtInfoAverage	= "%s min/%s AI (%s ench\195\168re)";
		FrmtInfoBidMulti	= "Offre (%s%s l'unit\195\169)";
		FrmtInfoBidOne	= "Offre (%s)";
		FrmtInfoBidrate	= "%d%% avec offre, %d%% avec AI";
		FrmtInfoBuymedian	= "Achat Imm\195\169diat m\195\169dian";
		FrmtInfoBuyMulti	= "Achat imm\195\169diat (%s%s l'unit\195\169)";
		FrmtInfoBuyOne	= "Achat imm\195\169diat (%s)";
		FrmtInfoForone	= "Pour 1 : %s min/%s AI (%s ench\195\168re) [par %d]";
		FrmtInfoHeadMulti	= "Moyennes pour %d objets :";
		FrmtInfoHeadOne	= "Moyennes pour cet objet :";
		FrmtInfoHistmed	= "%d derniers vus. AI moyen (l'unit\195\169) :";
		FrmtInfoMinMulti	= "Mise \195\160 prix initiale (%s l'unit\195\169)";
		FrmtInfoMinOne	= "Mise \195\160 prix initiale";
		FrmtInfoNever	= "Jamais vu en %s";
		FrmtInfoSeen	= "Vu %d fois aux ench\195\168res";
		FrmtInfoSgst	= "Prix sugg\195\169r\195\169 : %s min/%s AI";
		FrmtInfoSgststx	= "Prix sugg\195\169r\195\169 pour votre pile de %d : %s min/%s AI";
		FrmtInfoSnapmed	= "Vu %d fois \195\160 la derni\195\168re analyse, AI moyen (pce) :";
		FrmtInfoStacksize	= "Nombre d'objets moyens par pile : %s";


		-- Section: User Interface
		FrmtLastSoldOn	= "Derni\195\168re vente le %s";
		UiBid	= "Offre";
		UiBidHeader	= "Offre";
		UiBidPerHeader	= "Offre par";
		UiBuyout	= "Acheter";
		UiBuyoutHeader	= "Achat Imm\195\169diat";
		UiBuyoutPerHeader	= "Achat Imm\195\169diat par";
		UiBuyoutPriceLabel	= "Prix d'achat :";
		UiBuyoutPriceTooLowError	= "(Trop faible)";
		UiCategoryLabel	= "Restriction de cat\195\169gorie : \n";
		UiDepositLabel	= "D\195\169p\195\180t :";
		UiDurationLabel	= "Dur\195\169e :";
		UiItemLevelHeader	= "Niv";
		UiMakeFixedPriceLabel	= "M\195\169moriser le prix";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Prix maximum :";
		UiMaximumTimeLeftLabel	= "Temps restant maximum :";
		UiMinimumPercentLessLabel	= "% min de gain :";
		UiMinimumProfitLabel	= "Gain minimum : ";
		UiMinimumQualityLabel	= "Qualit\195\169 minimum :";
		UiMinimumUndercutLabel	= "Marge minimum :";
		UiNameHeader	= "Nom";
		UiNoPendingBids	= "Toutes les offres ont \195\169t\195\169 soumises!";
		UiNotEnoughError	= "(Pas assez)";
		UiPendingBidInProgress	= "1 offre en cours...";
		UiPendingBidsInProgress	= "%d offres en cours...";
		UiPercentLessHeader	= "% de";
		UiPost	= "Vendre";
		UiPostAuctions	= "Vendre";
		UiPriceBasedOnLabel	= "Prix Bas\195\169 sur :";
		UiPriceModelAuctioneer	= "Prix Auctioneer";
		UiPriceModelCustom	= "Prix personnalis\195\169";
		UiPriceModelFixed	= "Prix m\195\169moris\195\169";
		UiPriceModelLastSold	= "Dernier prix de vente";
		UiProfitHeader	= "B\195\169n\195\169fices";
		UiProfitPerHeader	= "B\195\169n\195\169fices par";
		UiQuantityHeader	= "Qt\195\169";
		UiQuantityLabel	= "Quantit\195\169 :";
		UiRemoveSearchButton	= "Supprimer";
		UiSavedSearchLabel	= "Recherches sauvegard\195\169es :";
		UiSaveSearchButton	= "Sauvegarder";
		UiSaveSearchLabel	= "Sauvegarder cette recherche :";
		UiSearch	= "Recherche";
		UiSearchAuctions	= "Recherche Ench\195\168res";
		UiSearchDropDownLabel	= "Recherche :";
		UiSearchForLabel	= "Recherche d'un objet :";
		UiSearchTypeBids	= "Offres";
		UiSearchTypeBuyouts	= "Achats Imm\195\169diats";
		UiSearchTypeCompetition	= "Concurrence ";
		UiSearchTypePlain	= "Objet";
		UiStacksLabel	= "Piles";
		UiStackTooBigError	= "(Pile trop grosse)";
		UiStackTooSmallError	= "(Pile trop petite)";
		UiStartingPriceLabel	= "Prix de d\195\169part :";
		UiStartingPriceRequiredError	= "(Requis)";
		UiTimeLeftHeader	= "Temps restant";
		UiUnknownError	= "(Inconnu)";

	};

	itIT = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Prezzo di uno stack da %sx[ItemLink]";
		FrmtAskPriceBuyoutMedianHistorical	= "%sBuyout-medio degli scan: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sBuyout-medio ultimo scan: %s%s";
		FrmtAskPriceDisable	= "Disabilita l'opzione Prezzo Richiesto di %s";
		FrmtAskPriceEach	= "(%s l'una)";
		FrmtAskPriceEnable	= "Attivando l'opzione %s di AskPrice";
		FrmtAskPriceVendorPrice	= "%sVendi al vendor per: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Asta %s rimossa dalla lista corrente.";
		FrmtAuctinfoHist	= "%d storico";
		FrmtAuctinfoLow	= "Prezzo minimo";
		FrmtAuctinfoMktprice	= "Prezzo di mercato";
		FrmtAuctinfoNolow	= "Oggetto non visto nell'ultimo scan";
		FrmtAuctinfoOrig	= "Offerta originale";
		FrmtAuctinfoSnap	= "%d ultimo scan";
		FrmtAuctinfoSugbid	= "Offerta suggerita";
		FrmtAuctinfoSugbuy	= "Prezzo d'acquisto suggerito";
		FrmtWarnAbovemkt	= "Prezzo superiore alla media di mercato.";
		FrmtWarnMarkup	= "Oltre il prezzo del vendor di %s%%";
		FrmtWarnMyprice	= "Sto usando il mio prezzo attuale";
		FrmtWarnNocomp	= "Nessuna competizione";
		FrmtWarnNodata	= "Nessun dato per HSP";
		FrmtWarnToolow	= "Minimo troppo inferiore al prezzo di mercato";
		FrmtWarnUndercut	= "Prezzo ribassato del %s%%";
		FrmtWarnUser	= "Il prezzo coincide con il prezzo del vendor";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "E' gi\195\160 la piu' alta richiesta all'asta: %s (x%d)";
		FrmtBidAuction	= "Offerta all'asta: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Errore: La coda delle offerte e' fuori sincrono!";
		FrmtBoughtAuction	= "Comprato di Buyout: %s (x%d)";
		FrmtMaxBidsReached	= "Altre aste per %d (x%d) sono state trovate, ma il limite di offerta e' stato raggiunto (%d) ";
		FrmtNoAuctionsFound	= "Nessuna asta trovata: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "Nessun'altra asta trovata: %s (x%d)";
		FrmtNotEnoughMoney	= "Denaro insufficiente per fare un offerta: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Escluse aste con bid piu' alto: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Escluse aste con bid piu' basso: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Saltata offerta su una propria asta: %s (x%d)";
		UiProcessingBidRequests	= "Analisi delle richieste di bid...";


		-- Section: Command Messages
		FrmtActClearall	= "Sto eliminando tutti i dati per %s";
		FrmtActClearFail	= "Impossibile trovare: %s";
		FrmtActClearOk	= "Rimossi dati per l'oggetto: %s";
		FrmtActClearsnap	= "Sto cancellando la lista attuale.";
		FrmtActDefault	= "Opzione %s riportata al valore predefinito";
		FrmtActDefaultall	= "Tutte le opzioni riportate ai valori predefiniti.";
		FrmtActDisable	= "I dati per %s non sono visualizzati";
		FrmtActEnable	= "I dati per %s sono visualizzati";
		FrmtActSet	= "Opzione %s impostata a '%s'";
		FrmtActUnknown	= "Comando non riconosciuto: '%s'";
		FrmtAuctionDuration	= "Durata predefinita: %s";
		FrmtAutostart	= "Asta automatica per %s minimo, %s buyout(%dh)\n%s";
		FrmtFinish	= "Quando lo scan sia finito, %s";
		FrmtPrintin	= "I messaggi di Auctioneer saranno visualizzati nella chat \"%s\"";
		FrmtProtectWindow	= "Protezione della finestra AH impostata a: %s";
		FrmtUnknownArg	= "'%s' non e' un argomento valido per '%s'";
		FrmtUnknownLocale	= "La lingua specificata ('%s') e' sconosciuta. Lingue valide:";
		FrmtUnknownRf	= "Parametro non valido('%s'). Il parametro deve avere un formato [reame]-[fazione]. Esempio: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(reame-fazione|opposta)";
		OptAuctionDuration	= "(durata||2h||8h||24h)";
		OptBidbroker	= "<guadagno_silver>";
		OptBidLimit	= "<numero>";
		OptBroker	= "<guadagno_silver>";
		OptClear	= "([Oggetto]|tutto|lista) ";
		OptCompete	= "<silver_in_meno>";
		OptDefault	= "(<opzione>|tutto) ";
		OptFinish	= "(spento||stacca||esci)";
		OptLocale	= "<lingua>";
		OptPctBidmarkdown	= "<percento>";
		OptPctMarkup	= "<percento>";
		OptPctMaxless	= "<percento>";
		OptPctNocomp	= "<percento>";
		OptPctUnderlow	= "<percento>";
		OptPctUndermkt	= "<percento>";
		OptPercentless	= "<percento>";
		OptPrintin	= "(<Indiceframe>[Numero]|<Nomeframe>[Stringa]) ";
		OptProtectWindow	= "(mai||scan||sempre)";
		OptScale	= "<fattore_scala>";
		OptScan	= "parametri di scan";


		-- Section: Commands
		CmdAlso	= "anche";
		CmdAlsoOpposite	= "opposta";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "aggiunto";
		CmdAskPriceGuild	= "gilda";
		CmdAskPriceParty	= "gruppo";
		CmdAskPriceSmart	= "corte";
		CmdAskPriceSmartWord1	= "che";
		CmdAskPriceSmartWord2	= "Ricerca multipla";
		CmdAskPriceTrigger	= "automatismo";
		CmdAskPriceVendor	= "Venditore";
		CmdAskPriceWhispers	= "Whispers";
		CmdAskPriceWord	= "word";
		CmdAuctionClick	= "auction-click";
		CmdAuctionDuration	= "durata-asta";
		CmdAuctionDuration0	= "precedente";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "auto-riempimento";
		CmdBidbroker	= "Agente d'Offerta";
		CmdBidbrokerShort	= "ao";
		CmdBidLimit	= "limite-offerta";
		CmdBroker	= "Agente";
		CmdClear	= "cancella";
		CmdClearAll	= "tutto";
		CmdClearSnapshot	= "lista";
		CmdCompete	= "competere";
		CmdCtrl	= "ctrl";
		CmdDefault	= "default";
		CmdDisable	= "disabilita";
		CmdEmbed	= "integra";
		CmdFinish	= "finale";
		CmdFinish0	= "spento";
		CmdFinish1	= "stacca";
		CmdFinish2	= "esci";
		CmdFinish3	= "Ricarica l'Interfaccia";
		CmdFinishSound	= "avviso sonoro al termine";
		CmdHelp	= "aiuto";
		CmdLocale	= "lingua";
		CmdOff	= "disattivo";
		CmdOn	= "attivo";
		CmdPctBidmarkdown	= "pct-bidmarkdown";
		CmdPctMarkup	= "pct-markup";
		CmdPctMaxless	= "pct-senzamassimo";
		CmdPctNocomp	= "pct-nocomp";
		CmdPctUnderlow	= "pct-underlow";
		CmdPctUndermkt	= "pct-sottomercato";
		CmdPercentless	= "percentless";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "stampa-in";
		CmdProtectWindow	= "proteggere-finestra";
		CmdProtectWindow0	= "mai";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "sempre";
		CmdScan	= "scan";
		CmdShift	= "shift";
		CmdToggle	= "attiva-disattiva";
		CmdUpdatePrice	= "aggiorna-prezzo";
		CmdWarnColor	= "avviso-colore";
		ShowAverage	= "mostra-media";
		ShowEmbedBlank	= "mostra-lineavuota-integrata";
		ShowLink	= "mostra-collegamento";
		ShowMedian	= "mostra-media";
		ShowRedo	= "mostra-avvertenze";
		ShowStats	= "mostra-statistiche";
		ShowSuggest	= "mostra-consigli";
		ShowVerbose	= "mostra-dettagliato";


		-- Section: Config Text
		GuiAlso	= "Mostra informazioni anche per";
		GuiAlsoDisplay	= "Mostra informazioni per %s";
		GuiAlsoOff	= "Visualizzazione informazioni di altri reami-fazioni disabilitata.";
		GuiAlsoOpposite	= "Visualizzazione informazioni di altri reami-fazioni abilitata.";
		GuiAskPrice	= "Attivare AskPrice";
		GuiAskPriceAd	= "Manda le novit\195\160";
		GuiAskPriceGuild	= "Rispondi alle richieste in chat gilda";
		GuiAskPriceHeader	= "Opzioni di AskPrice";
		GuiAskPriceHeaderHelp	= "Cambia le opzioni del PrezzoRichiesto";
		GuiAskPriceParty	= "Rispondi alle richieste in chat gruppo";
		GuiAskPriceSmart	= "Usa parole-corte";
		GuiAskPriceTrigger	= "PrezzoRichiesto automatico";
		GuiAskPriceVendor	= "Manda le info del vendor";
		GuiAskPriceWhispers	= "Mostra i whispers in uscita";
		GuiAskPriceWord	= "Parola chiave personalizzata %d";
		GuiAuctionDuration	= "Durata asta predefinita";
		GuiAuctionHouseHeader	= "Finestra Casa d'Aste (AH)";
		GuiAuctionHouseHeaderHelp	= "Impostazioni della finestra Casa d'Aste (AH)";
		GuiAutofill	= "Inserimento automatico prezzi";
		GuiAverages	= "Mostra Medie";
		GuiBidmarkdown	= "Percentuale di bid markdown";
		GuiClearall	= "Cancella tutti i dati di Auctioneer";
		GuiClearallButton	= "Cancella dati fazione-reame attuali";
		GuiClearallHelp	= "Fare click qui per cancellare tutti i dati della fazione-reame attuale.";
		GuiClearallNote	= "per la fazione-reame attuale.";
		GuiClearHeader	= "Cancella Dati";
		GuiClearHelp	= "Cancella i dati di Auctioneer. Selezionare tutti i dati o solo la lista attuale. ATTENZIONE: queste operazioni NON sono annullabili.";
		GuiClearsnap	= "Cancella lista attuale";
		GuiClearsnapButton	= "Cancella lista";
		GuiClearsnapHelp	= "Fare click qui per canecllare l'ultima lista.";
		GuiDefaultAll	= "Reimposta tutte le opzioni di Auctioneer";
		GuiDefaultAllButton	= "Reimposta tutto";
		GuiDefaultAllHelp	= "Fare click qui per riportare tutte le opzioni ai loro valori predefiniti. ATTENZIONE: questa azione NON e' annullabile.";
		GuiDefaultOption	= "Reimposta al valore predefinito";
		GuiEmbed	= "Includi info nei tooltip";
		GuiEmbedBlankline	= "Mostra linea vuota nei tooltip";
		GuiEmbedHeader	= "Integra";
		GuiFinish	= "Dopo finita una scansione";
		GuiFinishSound	= "Avvisa con un suono quando lo scan \195\168 terminato";
		GuiLink	= "Mostra LinkID";
		GuiLoad	= "Carica Auctioneer";
		GuiLoad_Always	= "sempre";
		GuiLoad_AuctionHouse	= "nella Casa d'Aste (AH)";
		GuiLoad_Never	= "mai";
		GuiLocale	= "Imposta lingua a";
		GuiMainEnable	= "Attiva Auctioneer";
		GuiMainHelp	= "Contiene le impostazioni per Auctioneer, un AddOn che mostra informazioni sugli oggetti e analizza i dati delle aste. Fare click sul pulsante \"Scan\" nella Casa d'Aste (AH) per acquisire le informazioni.";
		GuiMarkup	= "Percentuale di Markup sul prezzo del vendor";
		GuiMaxless	= "Percentuale massima di ribasso";
		GuiMedian	= "Mostra mediane";
		GuiNocomp	= "Percentuale di ribasso senza concorrenti";
		GuiNoWorldMap	= "Auctioneer: visualizzazione Atlante impedita ";
		GuiOtherHeader	= "Altre opzioni";
		GuiOtherHelp	= "Opzioni varie";
		GuiPercentsHeader	= "Percentuali soglia di Auctioneer";
		GuiPercentsHelp	= "ATTENZIONE: I parametri seguenti sono SOLAMENTE per utenti esperti. Modifica i valori seguenti per impostare quanto aggressivo deve essere Auctioneer nel determinare i livelli di profitto.";
		GuiPrintin	= "Seleziona la finestra desiderata";
		GuiProtectWindow	= "Previeni chiusure accidentali della finestra della CdA";
		GuiRedo	= "Mostra avvertimento scansione lunga";
		GuiReloadui	= "Ricarica l'interfaccia utente";
		GuiReloaduiButton	= "RicaricaIU";
		GuiReloaduiFeedback	= "Caricamento Interfaccia di WoW";
		GuiReloaduiHelp	= "Clicca qui per ricaricare l'Interfaccia Utente di WoW dopo aver modificato la localizzazione. Facendo ci\195\178 la lingua delle schermate di configurazione coincider\195\160  con quella di Auctioneer. Nota: questa operazione pu\195\178 richiedere alcuni minuti.";
		GuiRememberText	= "Ricorda il prezzo";
		GuiStatsEnable	= "Mostra statistiche";
		GuiStatsHeader	= "Statistiche del prezzo dell'oggetto";
		GuiStatsHelp	= "Mostra le seguenti statistiche nel Tooltip";
		GuiSuggest	= "Mostra prezzo consigliato";
		GuiUnderlow	= "Ribasso maggiore";
		GuiUndermkt	= "Ribasso se Maxless";
		GuiVerbose	= "Informazioni dettagliate";
		GuiWarnColor	= "Colora Modello Prezzi";


		-- Section: Conversion Messages
		MesgConvert	= "Conversione del Database di Auctioneer. Fate prima una copia del vostro SavedVariables\\Auctioneer.lua %s%s";
		MesgConvertNo	= "Disattiva Auctioneer";
		MesgConvertYes	= "Convertire";
		MesgNotconverting	= "Auctioneer non sta\194\160convertendo il tuo database, ma non funzioner\195\160\194\160finch\195\168 il database non sar\195\160 convertito.";


		-- Section: Game Constants
		TimeLong	= "Lungo";
		TimeMed	= "Medio";
		TimeShort	= "Breve";
		TimeVlong	= "Molto Lungo";


		-- Section: Generic Messages
		DisableMsg	= "Disattiva il caricamento automatico di Auctioneer";
		FrmtWelcome	= "Auctioneer v%s caricato";
		MesgNotLoaded	= "Auctioneer non e' caricato. digita /auctioneer per maggiori informazioni.";
		StatAskPriceOff	= "AskPrice e' disattivato ora.";
		StatAskPriceOn	= "AskPrice e' attivato ora.";
		StatOff	= "Visualizzazione delle informazioni sulle aste disattivata";
		StatOn	= "Visualizzazione delle informazioni sulle aste attivata";


		-- Section: Generic Strings
		TextAuction	= "Asta";
		TextCombat	= "Combattimento";
		TextGeneral	= "Generale";
		TextNone	= "nessuno";
		TextScan	= "Scan";
		TextUsage	= "Sintassi:";


		-- Section: Help Text
		HelpAlso	= "Mostra anche i valori di un altro server nei suggerimenti. Occorre inserire nome del reame e della fazione. Esempio: \"/auctioneer also Al'Akir-Horde\". Con la parola chiave \"opposite\" si specifica la fazione opposta, mentre \"off\" disattiva la funzionalita'\194\160.";
		HelpAskPrice	= "Attiva o disattiva AskPrice.";
		HelpAskPriceAd	= "Attiva o disattiva l'annuncio delle caratteristiche nuove di AskPrice.";
		HelpAskPriceGuild	= "Rispondi alle richieste fatte nella chat di gilda";
		HelpAskPriceParty	= "Rispondi alle richieste fatte nella chat del gruppo";
		HelpAskPriceSmart	= "Attiva o disattiva il controllo sulle SmartWords";
		HelpAskPriceTrigger	= "Cambia il carattere del PrezzoRichiesto";
		HelpAskPriceVendor	= "Attiva o Disattiva l'invio dei prezzi del vendor.";
		HelpAskPriceWhispers	= "Attiva o disattiva l'occultamento di tutti i whispers AskPrice in uscita";
		HelpAskPriceWord	= "Aggiungi o modifica le SmartWords abituali dell'AskPrice";
		HelpAuctionClick	= "Consente di creare automaticamente un'asta tenendo premuto Alt e cliccando su di un oggetto nell'inventario";
		HelpAuctionDuration	= "Imposta la durata di default delle aste all'apertura dell'interfaccia della Casa d'Aste";
		HelpAutofill	= "Imposta se auto-inserire o meno i prezzi quando si mette all'asta un nuovo oggetto nella finestra della Casa d'Aste";
		HelpAverage	= "Imposta la visualizzazione del prezzo d'asta medio dell'oggetto";
		HelpBidbroker	= "Mostra le aste a breve o medio termine selezionate dall'ultima scansione su cui puoi fare un'offerta per trarne profitto";
		HelpBidLimit	= "Numero massimo le aste da fare un'offerta sopra o buyout di quando il tasto di buyout o di offerta \195\168 scattato sulla linguetta delle aste di ricerca.";
		HelpBroker	= "Mostra tutte le aste selezionate dall'ultima scansione su cui puoi fare un'offerta per trarne profitto rivendendo";
		HelpClear	= "Elimina i dati sull'oggetto specificato (inserisci l'oggetto nel comando con shift-click). Puoi anche usare le parole chiave \"all\" o \"snapshot\"";
		HelpCompete	= "Mostra tutte le aste scansionate di recente il cui buyout \195\168 inferiore ad uno dei tuoi oggetti";
		HelpDefault	= "Imposta un opzione di Auctioneer al valore di default. Puoi anche usare la parola chiave \"all\" per impostare tutte le opzioni di Auctioneer ai valori di default.";
		HelpDisable	= "Non attivare automaticamente Auctioneer la prossima volta che ti colleghi";
		HelpEmbed	= "Integra il testo nei tooltip originali del gioco (nota: alcune funzionalit\195\160\194\160 vengono disabilitate quando quest'opzione \195\168 attiva)";
		HelpEmbedBlank	= "Imposta se visualizzare o meno una riga vuota fra le informazioni del tooltip e le informazioni sull'asta quando il modo integrato \195\168 attivo";
		HelpFinish	= "Imposta se effettuare il LogOut o Chiudere  automaticamente il gioco alla fine di uno scan dell AH";
		HelpFinishSound	= "Seleziona se avere o meno un avviso sonoro alla fine dello scan della casa d'aste";
		HelpLink	= "Imposta se visualizzare il link id nel tooltip";
		HelpLoad	= "Cambia le impostazioni di caricamento di Auctioneer per questo personaggio";
		HelpLocale	= "Cambia la lingua utilizzata per i messaggi di Auctioneer";
		HelpMedian	= "Imposta se visualizzare il buyout medio dell'oggetto";
		HelpOnoff	= "Attiva/disattiva la visualizzazione dei dati dell'asta";
		HelpPctBidmarkdown	= "Regola la percentuale con cui auctioneer contrassegner\195\160\194\160 le offerte al ribasso dal prezzo di buyout";
		HelpPctMarkup	= "La percentuale dei prezzi del vendor sar\195\160 evidenziata quando non ci saranno altri valori disponibili";
		HelpPctMaxless	= "Regola la percentuale massima con cui auctioneer diminuira' il valore del mercato prima che scada";
		HelpPctNocomp	= "La percentuale con cui auctioneer diminuira'\194\160il valore del mercato dell'oggetto quando non c'\195\168 concorrenza";
		HelpPctUnderlow	= "Regola la percentuale con cui auctioneer abbassera' il prezzo dell'asta pi\195\185 basso";
		HelpPctUndermkt	= "Percentuale da diminuire al valore del mercato quando non si pu\195\178 battere la concorrenza (senza limiti)";
		HelpPercentless	= "Mostra tutte le aste nelle ultime scansioni il cui buyout e' piu' basso di una certa percentuale rispetto al prezzo di vendita pi\195\185 alto";
		HelpPrintin	= "Seleziona in quale frame Auctioneer visualizzera'\194\160 i suoi messaggi. Puoi specificare il nome del frame o il suo numero.";
		HelpProtectWindow	= "Impedisce la chiusura accidentale dell'interfaccia dell'AH";
		HelpRedo	= "Seleziona per mostare un avviso quando lo scan di una pagina dell'AH ha impiegato troppo tempo a causa del lag.";
		HelpScan	= "Eseguire uno scan dell'AH alla prossima visita, o mentre sei li (c'e' un bottone sulla finestra dell'asta). Scegli su quali categorie vuoi eseguire lo scan con i checkbox.";
		HelpStats	= "Seleziona per mostrare le percentuali di bid/buyout di un oggetto";
		HelpSuggest	= "Seleziona per mostrare i prezzi d'asta consigliati di un oggetto";
		HelpUpdatePrice	= "Aggiorni automaticamente il prezzo iniziante per un'asta sulla linguetta delle aste dell'alberino quando il prezzo buyout cambia.";
		HelpVerbose	= "Seleziona per mostrare le medie e i consigli completi (oppure disattiva per mostrarli su linea singola)";
		HelpWarnColor	= "Seleziona se mostrare il modello dei prezzi attuale (Ribassato da...) in colori intuitivi.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Non hai spazio sufficente per poter creare l'asta!";
		FrmtNotEnoughOfItem	= "%s insufficenti per creare l'asta!";
		FrmtPostedAuction	= "Inserita 1 asta su %s (x%d)";
		FrmtPostedAuctions	= "Inserite %d aste su %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "OffertaCorrente";
		FrmtBidbrokerDone	= "Bid brokering completato.";
		FrmtBidbrokerHeader	= "Profitto minimo: %s, HSP ='Prezzo Massimo Applicabile(Vendibile)'";
		FrmtBidbrokerLine	= "%s, Ultimi %s visti, HSP: %s, %s: %s, Prof: %s, Volte: %s";
		FrmtBidbrokerMinbid	= "OffertaMinima";
		FrmtBrokerDone	= "Brokeraggio completato";
		FrmtBrokerHeader	= "Profitto minimo: %s, PMV = 'Prezzo Massimo di Vendita' ";
		FrmtBrokerLine	= "%s, Ultimi %s visti, HSP: %s, BO: %s, Prof: %s";
		FrmtCompeteDone	= "Confronto delle auction completato.";
		FrmtCompeteHeader	= "Confrontando auction con ribasso di almeno %s per oggetto.";
		FrmtCompeteLine	= "%s, Puntata: %s, BO %s vs %s, %s meno";
		FrmtHspLine	= "Prezzo Massimo di Vendita per un %s \195\168: %s";
		FrmtLowLine	= "%s, BO: %s, Venditore: %s, Per uno: %s, Meno della mediana: %s";
		FrmtMedianLine	= "Degli ultimi %d visti, BO mediano per 1 %s \195\168: %s ";
		FrmtNoauct	= "Nessuna asta trovata per: %s ";
		FrmtPctlessDone	= "Ribasso applicato.";
		FrmtPctlessHeader	= "Ribasso sul Prezzo Applicabile Massimo (HSP): %d%%";
		FrmtPctlessLine	= "%s, Ultime %d viste, HSP: %s, BO: %s, Prof: %s, Ribasso %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Aste obsolete rimosse: %s ";
		AuctionDiscrepancies	= "Discrepanze: %s  ";
		AuctionNewAucts	= "Nuove aste scansionate: %s";
		AuctionOldAucts	= "Scansionate precedentemente: %s";
		AuctionPageN	= "Auctioneer: scansione %s pagina %d di %d,\nAste al secondo: %s,\nTempo rimasto: %s ";
		AuctionScanDone	= "Auctioneer: scansione delle aste completata";
		AuctionScanNexttime	= "Auctioneer eseguira' una scansione completa delle aste la prossima volta che parlerai con un banditore.";
		AuctionScanNocat	= "Selezionare almeno una categoria per la scansione.";
		AuctionScanRedo	= "La pagina corrente ha impiegato piu' di %d secondi per essere scansionata, nuovo tentativo di scansione .";
		AuctionScanStart	= "Auctioneer: scansione %s pagina 1... ";
		AuctionTotalAucts	= "Totale aste scansionate: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Visto %d volte a %s";
		FrmtInfoAverage	= "%s min/%s BO (%s offerta)";
		FrmtInfoBidMulti	= "Offerta (%s%s cad)";
		FrmtInfoBidOne	= "Con offerte%s";
		FrmtInfoBidrate	= "%d%% hanno offerte, %d%% hanno BO";
		FrmtInfoBuymedian	= "Buyout mediano";
		FrmtInfoBuyMulti	= "Buyout (%s%s cad) ";
		FrmtInfoBuyOne	= "Buyout%s";
		FrmtInfoForone	= "Per 1: %s min/%s BO (%s offerta) [in %d]";
		FrmtInfoHeadMulti	= "Medie per %d oggetti:";
		FrmtInfoHeadOne	= "Medie per questo oggetto:";
		FrmtInfoHistmed	= "Ultimo %d, BO mediano (cad)";
		FrmtInfoMinMulti	= "Offerta iniziale (%s cad)";
		FrmtInfoMinOne	= "Offerta iniziale";
		FrmtInfoNever	= "Mai visto a %s";
		FrmtInfoSeen	= "Visto un totale di %d volte all'asta";
		FrmtInfoSgst	= "Prezzo suggerito: %s min/%s BO";
		FrmtInfoSgststx	= "Prezzo suggerito per la tua pila di %d: %s min/%s BO";
		FrmtInfoSnapmed	= "Scansionato %d, BO mediano (cad)";
		FrmtInfoStacksize	= "Dimensione media della pila: %d oggetti";


		-- Section: User Interface
		FrmtLastSoldOn	= "Ultima Vendita a %s";
		UiBid	= "Bid";
		UiBidHeader	= "Bid";
		UiBidPerHeader	= "Percentuale Bid:";
		UiBuyout	= "Buyout";
		UiBuyoutHeader	= "Buyout";
		UiBuyoutPerHeader	= "Percentuale Buyout";
		UiBuyoutPriceLabel	= "Prezzo Buyout:";
		UiBuyoutPriceTooLowError	= "(Troppo Basso)";
		UiCategoryLabel	= "Filtro Categoria:";
		UiDepositLabel	= "Deposito:";
		UiDurationLabel	= "Durata:";
		UiItemLevelHeader	= "Liv";
		UiMakeFixedPriceLabel	= "Usa prezzo fisso";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Prezzo Massimo:";
		UiMaximumTimeLeftLabel	= "Massimo Tempo Mancante:";
		UiMinimumPercentLessLabel	= "Percentuale minima in meno:";
		UiMinimumProfitLabel	= "Profitto Minimo:";
		UiMinimumQualityLabel	= "Qualita' minima:";
		UiMinimumUndercutLabel	= "Ribasso minimo:";
		UiNameHeader	= "Nome";
		UiNoPendingBids	= "Tutte le richieste di bid completate!";
		UiNotEnoughError	= "(Non Abbastanza)";
		UiPendingBidInProgress	= "1 richiesta di bid in corso...";
		UiPendingBidsInProgress	= "%d richieste di bid in corso...";
		UiPercentLessHeader	= "%";
		UiPost	= "Inserisci";
		UiPostAuctions	= "Inserisci Asta";
		UiPriceBasedOnLabel	= "Prezzo basato su:";
		UiPriceModelAuctioneer	= "Prezzo Auctioneer";
		UiPriceModelCustom	= "Prezzo personale";
		UiPriceModelFixed	= "Prezzo fisso";
		UiPriceModelLastSold	= "Ultimo Prezzo di Vendita";
		UiProfitHeader	= "Guadagno";
		UiProfitPerHeader	= "Guadagno %";
		UiQuantityHeader	= "Q.ta'";
		UiQuantityLabel	= "Quantita':";
		UiRemoveSearchButton	= "Cancella";
		UiSavedSearchLabel	= "Ricerche salvate:";
		UiSaveSearchButton	= "Salva";
		UiSaveSearchLabel	= "Salva questa ricerca:";
		UiSearch	= "Cerca";
		UiSearchAuctions	= "Cerca Aste";
		UiSearchDropDownLabel	= "Cerca:";
		UiSearchForLabel	= "Cerca un oggetto:";
		UiSearchTypeBids	= "Offerte";
		UiSearchTypeBuyouts	= "Buyout";
		UiSearchTypeCompetition	= "Competizione";
		UiSearchTypePlain	= "Oggetto";
		UiStacksLabel	= "Pile";
		UiStackTooBigError	= "(Pila troppo grande)";
		UiStackTooSmallError	= "(Pila troppo piccola)";
		UiStartingPriceLabel	= "Prezzo di partenza:";
		UiStartingPriceRequiredError	= "(Obbligatorio)";
		UiTimeLeftHeader	= "Tempo rimanente";
		UiUnknownError	= "(Sconosciuto)";

	};

	koKR = {


		-- Section: AskPrice Messages
		AskPriceAd	= "%sx[\236\149\132\236\157\180\237\133\156\235\167\129\237\129\172]\236\151\144 \235\140\128\237\149\156 \235\172\182\236\157\140 \234\176\128\234\178\169\236\157\132 \236\150\187\236\150\180\236\152\181\235\139\136\235\139\164.(x=\235\172\182\236\157\140\236\136\152\235\159\137)";
		FrmtAskPriceBuyoutMedianHistorical	= "%s \234\184\176\235\161\157\235\144\152\236\150\180\236\158\136\235\138\148 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\234\176\132\234\176\146: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%s \236\181\156\234\183\188 \234\178\128\236\131\137\235\144\156 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\234\176\132\234\176\146: %s%s";
		FrmtAskPriceDisable	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\152 %s \236\132\164\236\160\149 \235\185\132\237\153\156\236\132\177\237\153\148";
		FrmtAskPriceEach	= "(\234\176\156\235\139\185 %s)";
		FrmtAskPriceEnable	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\152 %s \236\132\164\236\160\149 \237\153\156\236\132\177\237\153\148";
		FrmtAskPriceVendorPrice	= "%s \236\131\129\236\160\144 \237\140\144\235\167\164\234\176\128: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "\234\178\189\235\167\164\236\158\165 \235\141\176\236\157\180\237\132\176\236\151\144\236\132\156 %s|1\236\157\132;\235\165\188; \236\130\173\236\160\156\237\149\169\235\139\136\235\139\164.";
		FrmtAuctinfoHist	= "\234\184\176\236\161\180 %d\234\176\156";
		FrmtAuctinfoLow	= "\235\130\174\236\157\128 \234\184\176\235\161\157";
		FrmtAuctinfoMktprice	= "\236\131\129\236\160\144\234\176\128";
		FrmtAuctinfoNolow	= "\236\181\156\234\183\188 \234\184\176\235\161\157\235\144\156 \236\160\149\235\179\180\236\151\144\236\132\156 \235\179\184\236\160\129\236\157\180 \236\151\134\235\138\148 \236\149\132\236\157\180\237\133\156.";
		FrmtAuctinfoOrig	= "\236\155\144\235\158\152 \236\158\133\236\176\176\234\176\128";
		FrmtAuctinfoSnap	= "\236\181\156\234\183\188 \236\161\176\236\130\172 %d\234\176\156";
		FrmtAuctinfoSugbid	= "\236\160\156\236\149\136\235\144\156 \236\158\133\236\176\176\234\176\128";
		FrmtAuctinfoSugbuy	= "\236\160\156\236\149\136\235\144\156 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128";
		FrmtWarnAbovemkt	= "\236\131\129\236\160\144\234\176\128 \236\157\180\236\131\129\235\167\140 \234\178\189\237\149\169";
		FrmtWarnMarkup	= "\236\131\129\236\160\144\234\176\128 \235\179\180\235\139\164 %s%% \235\134\146\234\178\140";
		FrmtWarnMyprice	= "\235\130\180 \237\152\132\236\158\172 \234\176\128\234\178\169 \236\130\172\236\154\169";
		FrmtWarnNocomp	= "\234\178\189\237\149\169 \236\151\134\236\157\140";
		FrmtWarnNodata	= "\236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128(HSP)\236\151\144\235\140\128\237\149\156 \235\141\176\236\157\180\237\132\176 \236\151\134\236\157\140";
		FrmtWarnToolow	= "\236\181\156\236\160\128\234\176\128\236\151\144 \235\167\158\236\182\156 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.";
		FrmtWarnUndercut	= "%s%% \235\167\140\237\129\188 \237\149\160\236\157\184";
		FrmtWarnUser	= "\236\130\172\236\154\169\236\158\144 \234\176\128\234\178\169 \236\130\172\236\154\169";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "\234\178\189\235\167\164\236\151\144 \236\157\180\235\175\184 \235\141\148 \235\134\146\236\157\128 \236\158\133\236\176\176\236\158\144\234\176\128 \236\158\136\236\157\140: %s (x%d)";
		FrmtBidAuction	= "\234\178\189\235\167\164\236\151\144 \236\158\133\236\176\176: %s (x%d)";
		FrmtBidQueueOutOfSync	= "\236\152\164\235\165\152: \236\158\133\236\176\176 \235\140\128\234\184\176\236\151\180 \235\143\153\234\184\176\237\153\148\236\151\144 \235\172\184\236\160\156\234\176\128 \235\176\156\236\131\157\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164!";
		FrmtBoughtAuction	= "\236\166\137\236\139\156\234\181\172\236\158\133\235\144\156 \234\178\189\235\167\164: %s (x%d)";
		FrmtMaxBidsReached	= "%s(x%d)\236\157\152 \234\178\189\235\167\164\237\146\136\235\147\164\236\157\132 \236\162\128\235\141\148 \236\176\190\236\149\152\236\167\128\235\167\140, \236\158\133\236\176\176 \237\149\156\234\179\132\236\151\144 \235\143\132\235\139\172\237\150\136\236\138\181\235\139\136\235\139\164.(%d)";
		FrmtNoAuctionsFound	= "\234\178\189\235\167\164\235\165\188 \236\176\190\236\157\132 \236\136\152\236\151\134\236\157\140: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "\235\141\148\236\157\180\236\131\129 \234\178\189\235\167\164\237\146\136\236\157\132 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164: %s(x%d)";
		FrmtNotEnoughMoney	= "\234\178\189\235\167\164\236\151\144 \236\158\133\236\176\176\237\149\152\234\184\176 \236\156\132\237\149\156 \235\169\148\235\170\168\235\166\172\234\176\128 \235\182\128\236\161\177\237\149\169\235\139\136\235\139\164: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "\235\141\148 \235\134\146\236\157\128 \236\158\133\236\176\176\235\161\156 \236\157\184\237\149\180 \234\177\180\235\132\136\235\155\180 \234\178\189\235\167\164: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "\235\141\148 \235\130\174\236\157\128 \236\158\133\236\176\176\235\161\156 \236\157\184\237\149\180 \234\177\180\235\132\136\235\155\180 \234\178\189\235\167\164: %s (x$d)";
		FrmtSkippedBiddingOnOwnAuction	= "\236\158\144\236\139\160\236\157\152 \234\178\189\235\167\164\235\157\188\236\132\156 \236\158\133\236\176\176\236\157\132 \234\177\180\235\132\136\235\156\128: %s (x%d)";
		UiProcessingBidRequests	= "\236\158\133\236\176\176 \236\154\148\236\178\173 \236\136\152\237\150\137\236\164\145...";


		-- Section: Command Messages
		FrmtActClearall	= "%s\236\151\144 \235\140\128\237\149\156 \235\170\168\235\147\160 \234\178\189\235\167\164 \235\141\176\236\157\180\237\132\176 \236\130\173\236\160\156";
		FrmtActClearFail	= "\236\176\190\236\157\132 \236\136\152 \236\151\134\235\138\148 \236\149\132\236\157\180\237\133\156: %s";
		FrmtActClearOk	= "\236\149\132\236\157\180\237\133\156\234\180\128\235\160\168 \236\130\173\236\160\156\235\144\156 \235\141\176\236\157\180\237\131\128: %s";
		FrmtActClearsnap	= "\237\152\132\236\158\172 \234\178\189\235\167\164\236\158\165 \234\184\176\235\161\157 \236\160\149\235\179\180 \236\130\173\236\160\156";
		FrmtActDefault	= "Auctioneer\236\157\152 %s \236\132\164\236\160\149\236\157\180 \236\180\136\234\184\176\237\153\148\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.";
		FrmtActDefaultall	= "\235\170\168\235\147\160 Auctioneer\236\157\152 \236\132\164\236\160\149\236\157\180 \236\180\136\234\184\176\237\153\148\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164.";
		FrmtActDisable	= "\236\149\132\236\157\180\237\133\156\236\157\152 %s \235\141\176\236\157\180\237\132\176 \237\145\156\236\139\156\237\149\152\236\167\128 \236\149\138\236\157\140";
		FrmtActEnable	= "\236\149\132\236\157\180\237\133\156\236\157\152 %s \235\141\176\236\157\180\237\132\176 \237\145\156\236\139\156";
		FrmtActSet	= "%s\236\157\152 \236\132\164\236\160\149\236\157\132 '%s'\236\156\188\235\161\156";
		FrmtActUnknown	= "\236\149\140 \236\136\152 \236\151\134\235\138\148 \235\170\133\235\160\185\236\150\180: '%s'";
		FrmtAuctionDuration	= "\234\184\176\235\179\184 \234\178\189\235\167\164 \234\184\176\234\176\132\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\168: %s ";
		FrmtAutostart	= "\236\158\144\235\143\153\236\156\188\235\161\156 \234\178\189\235\167\164 \236\139\156\236\158\145: \236\181\156\236\160\128\234\176\128 %s, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 %s(%d\236\139\156\234\176\132) %s";
		FrmtFinish	= "\234\178\128\236\131\137\236\157\180 \235\129\157\235\130\152\235\169\180, %s|1\236\157\132;\235\165\188; \236\136\152\237\150\137\237\149\169\235\139\136\235\139\164.";
		FrmtPrintin	= "Auctioneer\236\157\152 \235\169\148\236\139\156\236\167\128\234\176\128 \"%s\" \236\177\132\237\140\133 \236\176\189\236\151\144 \237\145\156\236\139\156\235\144\169\235\139\136\235\139\164.";
		FrmtProtectWindow	= "AH\236\176\189 \235\179\180\237\152\184\234\176\128 \236\132\164\236\160\149\235\144\168: %s";
		FrmtUnknownArg	= "'%s'\235\138\148 '%s'\236\151\144 \236\156\160\237\154\168\237\149\152\236\167\128 \236\149\138\236\157\128 \235\167\164\234\176\156\235\179\128\236\136\152 \236\158\133\235\139\136\235\139\164.";
		FrmtUnknownLocale	= "\236\132\164\236\160\149\235\144\156 \236\167\128\236\151\173 ('%s')\236\157\132 \236\149\140\236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164. \236\156\160\237\154\168\237\149\156 \236\167\128\236\151\173:";
		FrmtUnknownRf	= "\236\156\160\237\154\168\237\149\152\236\167\128 \236\149\138\236\157\128 \235\167\164\234\176\156\235\179\128\236\136\152 ('%s'). \235\167\164\234\176\156\235\179\128\236\136\152\236\157\152 \237\152\149\236\139\157\236\157\128 \235\139\164\236\157\140\234\179\188 \234\176\153\236\149\132\236\149\188 \237\149\168: [realm]-[faction]. \236\152\136: \235\147\128\235\161\156\237\131\132-\237\152\184\235\147\156";


		-- Section: Command Options
		OptAlso	= "(\236\132\156\235\178\132-\236\167\132\236\152\129|\236\160\129\236\167\132\236\152\129|\236\149\132\234\181\176\236\167\132\236\152\129|\236\164\145\235\166\189\236\167\132\236\152\129)";
		OptAuctionDuration	= "(\236\167\128\235\130\156|2\236\139\156\234\176\132|8\236\139\156\234\176\132|24\236\139\156\234\176\132)";
		OptBidbroker	= "<\236\139\164\235\178\132_\236\157\180\236\156\164>";
		OptBidLimit	= "<\236\136\171\236\158\144>";
		OptBroker	= "<\236\139\164\235\178\132_\236\157\180\236\156\164>";
		OptClear	= "([\236\149\132\236\157\180\237\133\156]|\235\170\168\235\145\144|\236\138\164\235\132\181\236\131\183) ";
		OptCompete	= "<\236\139\164\235\178\132_\236\157\180\237\149\152>";
		OptDefault	= "(<\236\132\164\236\160\149>|\235\170\168\235\145\144)";
		OptFinish	= "(\235\129\148|\235\161\156\234\183\184\236\149\132\236\155\131|\235\130\152\234\176\128\234\184\176|\235\166\172\235\161\156\235\147\156) ";
		OptLocale	= "<\236\167\128\236\151\173>";
		OptPctBidmarkdown	= "<\237\141\188\236\132\188\237\138\184>";
		OptPctMarkup	= "<\237\141\188\236\132\188\237\138\184>";
		OptPctMaxless	= "<\237\141\188\236\132\188\237\138\184>";
		OptPctNocomp	= "<\237\141\188\236\132\188\237\138\184>";
		OptPctUnderlow	= "<\237\141\188\236\132\188\237\138\184>";
		OptPctUndermkt	= "<\237\141\188\236\132\188\237\138\184>";
		OptPercentless	= "<\237\141\188\236\132\188\237\138\184>";
		OptPrintin	= "(<\237\148\132\235\160\136\236\158\132\236\157\184\235\141\177\236\138\164>[\236\136\171\236\158\144]|<\237\148\132\235\160\136\236\158\132\236\157\180\235\166\132>[\235\172\184\236\158\144\236\151\180]) ";
		OptProtectWindow	= "(\236\130\172\236\154\169\236\149\136\237\149\168|\234\178\128\236\131\137|\237\149\173\236\131\129\236\130\172\236\154\169) ";
		OptScale	= "<\235\185\132\236\156\168_\236\157\184\236\158\144> ";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "also";
		CmdAlsoOpposite	= "\236\160\129\236\167\132\236\152\129";
		CmdAlt	= "Alt";
		CmdAskPriceAd	= "\234\180\145\234\179\160";
		CmdAskPriceGuild	= "\234\184\184\235\147\156";
		CmdAskPriceParty	= "\237\140\140\237\139\176";
		CmdAskPriceSmart	= "\236\138\164\235\167\136\237\138\184";
		CmdAskPriceSmartWord1	= "\235\172\180\236\151\135";
		CmdAskPriceSmartWord2	= "\234\176\128\236\185\152";
		CmdAskPriceTrigger	= "\237\138\184\235\166\172\234\177\176";
		CmdAskPriceVendor	= "\236\131\129\236\160\144";
		CmdAskPriceWhispers	= "\236\134\141\236\130\173\236\158\132";
		CmdAskPriceWord	= "\235\130\177\235\167\144";
		CmdAuctionClick	= "\234\178\189\235\167\164-\237\129\180\235\166\173 ";
		CmdAuctionDuration	= "\234\178\189\235\167\164-\234\184\176\234\176\132";
		CmdAuctionDuration0	= "\236\181\156\234\183\188";
		CmdAuctionDuration1	= "2\236\139\156\234\176\132";
		CmdAuctionDuration2	= "8\236\139\156\234\176\132";
		CmdAuctionDuration3	= "24\236\139\156\234\176\132";
		CmdAutofill	= "\236\158\144\235\143\153 \236\158\133\235\160\165";
		CmdBidbroker	= "\236\158\133\236\176\176\236\164\145\234\179\132\236\157\184";
		CmdBidbrokerShort	= "bb ";
		CmdBidLimit	= "\236\158\133\236\176\176-\237\149\156\234\179\132";
		CmdBroker	= "\236\164\145\234\179\132\236\157\184";
		CmdClear	= "\236\130\173\236\160\156";
		CmdClearAll	= "\235\170\168\235\145\144";
		CmdClearSnapshot	= "\236\138\164\235\132\181\236\131\183";
		CmdCompete	= "\234\178\189\237\149\169";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "\234\184\176\235\179\184\234\176\146";
		CmdDisable	= "\235\185\132\237\153\156\236\132\177\237\153\148";
		CmdEmbed	= "\237\143\172\237\149\168";
		CmdFinish	= "\235\167\136\236\185\168";
		CmdFinish0	= "\235\129\148";
		CmdFinish1	= "\236\160\145\236\134\141\236\162\133\235\163\140";
		CmdFinish2	= "\235\130\152\234\176\128\234\184\176";
		CmdFinish3	= "\235\166\172\235\161\156\235\147\156";
		CmdFinishSound	= "\235\129\157\235\130\180 \236\134\140\235\166\172";
		CmdHelp	= "\235\143\132\236\155\128\235\167\144";
		CmdLocale	= "\236\167\128\236\151\173";
		CmdOff	= "\235\129\148";
		CmdOn	= "\236\188\172";
		CmdPctBidmarkdown	= "pct-bidmarkdown";
		CmdPctMarkup	= "pct-markup";
		CmdPctMaxless	= "pct-maxless";
		CmdPctNocomp	= "pct-nocomp";
		CmdPctUnderlow	= "pct-underlow";
		CmdPctUndermkt	= "pct-undermkt";
		CmdPercentless	= "percentless";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "print-in";
		CmdProtectWindow	= "protect-window";
		CmdProtectWindow0	= "\236\130\172\236\154\169\236\149\136\237\149\168";
		CmdProtectWindow1	= "\234\178\128\236\131\137";
		CmdProtectWindow2	= "\237\149\173\236\131\129\236\130\172\236\154\169";
		CmdScan	= "\234\178\128\236\131\137";
		CmdShift	= "Shift";
		CmdToggle	= "\237\134\160\234\184\128";
		CmdUpdatePrice	= "\234\176\177\236\139\160-\234\176\128\234\178\169";
		CmdWarnColor	= "\234\178\189\234\179\160-\236\131\137\236\131\129";
		ShowAverage	= "\237\145\156\236\139\156-\237\143\137\234\183\160";
		ShowEmbedBlank	= "\237\145\156\236\139\156-\237\143\172\237\149\168-\234\179\181\235\176\177\236\164\132";
		ShowLink	= "\237\145\156\236\139\156-\235\167\129\237\129\172";
		ShowMedian	= "\237\145\156\236\139\156-\236\164\145\234\176\132\234\176\146";
		ShowRedo	= "\237\145\156\236\139\156-\234\178\189\234\179\160";
		ShowStats	= "\237\145\156\236\139\156-\237\134\181\234\179\132";
		ShowSuggest	= "\237\145\156\236\139\156-\236\160\156\236\149\136\234\176\146";
		ShowVerbose	= "\237\145\156\236\139\156-\236\149\140\235\166\188";


		-- Section: Config Text
		GuiAlso	= "\236\182\148\234\176\128 \236\160\149\235\179\180 \237\145\156\236\139\156";
		GuiAlsoDisplay	= "%s\236\151\144 \234\180\128\237\149\156 \235\141\176\236\157\180\237\132\176 \237\145\156\236\139\156";
		GuiAlsoOff	= "\235\141\148\236\157\180\236\131\129 \236\132\156\235\178\132-\236\167\132\236\152\129 \235\141\176\236\157\180\237\132\176\235\165\188 \237\145\156\236\139\156\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.";
		GuiAlsoOpposite	= "\236\160\129\235\140\128 \236\167\132\236\152\129\236\151\144\235\140\128\237\149\156 \236\182\148\234\176\128\236\160\129\236\157\184 \235\141\176\236\157\180\237\132\176\235\165\188 \237\145\156\236\139\156\237\149\169\235\139\136\235\139\164.";
		GuiAskPrice	= "\234\176\128\234\178\169\236\154\148\236\178\173 \237\153\156\236\132\177\237\153\148";
		GuiAskPriceAd	= "\237\138\185\236\167\149 \234\180\145\234\179\160 \236\160\132\236\134\161";
		GuiAskPriceGuild	= "\234\184\184\235\147\156\235\140\128\237\153\148 \236\191\188\235\166\172 \236\157\145\235\139\181";
		GuiAskPriceHeader	= "\234\176\128\234\178\169\236\154\148\236\178\173 \236\132\164\236\160\149";
		GuiAskPriceHeaderHelp	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\152 \235\176\169\235\178\149 \235\179\128\234\178\189";
		GuiAskPriceParty	= "\237\140\140\237\139\176\235\140\128\237\153\148 \236\191\188\235\166\172 \236\157\145\235\139\181";
		GuiAskPriceSmart	= "\236\138\164\235\167\136\237\138\184\236\155\140\235\147\156 \236\130\172\236\154\169";
		GuiAskPriceTrigger	= "\234\176\128\234\178\169\236\154\148\236\178\173 \237\138\184\235\166\172\234\177\176";
		GuiAskPriceVendor	= "\236\131\129\236\160\144 \236\160\149\235\179\180 \236\160\132\236\134\161";
		GuiAskPriceWhispers	= "\236\135\188 \235\130\152\234\176\128\235\138\148 \236\134\141\236\130\173\236\158\132";
		GuiAskPriceWord	= "\236\163\188\235\172\184 \235\152\145\235\152\145\237\149\156 \235\130\177\235\167\144 %d";
		GuiAuctionDuration	= "\234\184\176\235\179\184 \234\178\189\235\167\164 \234\184\176\234\176\132";
		GuiAuctionHouseHeader	= "AH\236\176\189";
		GuiAuctionHouseHeaderHelp	= "AH\236\176\189\236\157\152 \235\143\153\236\158\145 \235\179\128\234\178\189";
		GuiAutofill	= "\234\178\189\235\167\164\236\158\165\236\151\144\236\132\156 \236\158\144\235\143\153\236\156\188\235\161\156 \234\176\128\234\178\169 \236\158\133\235\160\165";
		GuiAverages	= "\237\143\137\234\183\160\234\176\146 \235\179\180\234\184\176";
		GuiBidmarkdown	= "\236\158\133\236\176\176 \234\176\128\234\178\169 \236\157\184\237\149\152 \235\185\132\236\156\168";
		GuiClearall	= "\235\170\168\235\147\160 Auctioneer \235\141\176\236\157\180\237\131\128 \236\130\173\236\160\156";
		GuiClearallButton	= "\235\170\168\235\145\144 \236\130\173\236\160\156";
		GuiClearallHelp	= "\237\152\132\236\158\172 \236\132\156\235\178\132\236\151\144\235\140\128\237\149\156 \235\170\168\235\147\160 \234\178\189\235\167\164\236\157\184 \235\141\176\236\157\180\237\131\128\235\165\188 \236\130\173\236\160\156\237\149\152\235\160\164\235\169\180 \236\157\180\234\179\179\236\157\132 \237\129\180\235\166\173\237\149\152\236\139\173\236\139\156\236\152\164.";
		GuiClearallNote	= "\237\152\132\236\158\172 \236\132\156\235\178\132 \236\167\132\236\152\129";
		GuiClearHeader	= "\235\141\176\236\157\180\237\132\176 \236\130\173\236\160\156";
		GuiClearHelp	= "\234\178\189\235\167\164\236\157\184 \235\141\176\236\157\180\237\132\176 \236\130\173\236\160\156. \n\235\170\168\235\147\160 \235\141\176\236\157\180\237\131\128 \235\152\144\235\138\148 \237\152\132\236\158\172 \234\184\176\235\161\157\236\160\149\235\179\180\235\165\188 \236\132\160\237\131\157.\n\234\178\189\234\179\160: \236\130\173\236\160\156\235\144\156 \234\178\189\235\167\164 \236\160\149\235\179\180\235\138\148 \235\179\181\234\181\172\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.";
		GuiClearsnap	= "\234\184\176\235\161\157 \236\160\149\235\179\180 \236\130\173\236\160\156";
		GuiClearsnapButton	= "\234\184\176\235\161\157 \236\130\173\236\160\156";
		GuiClearsnapHelp	= "\236\181\156\234\183\188 \234\178\189\235\167\164\236\157\184\236\157\152 \234\184\176\235\161\157 \236\160\149\235\179\180\235\165\188 \236\130\173\236\160\156\237\149\152\236\139\156\235\160\164\235\169\180 \236\157\180\234\179\179\236\157\132 \237\129\180\235\166\173\237\149\152\236\139\173\236\139\156\236\152\164.";
		GuiDefaultAll	= "\235\170\168\235\147\160 Auctioneer \236\132\164\236\160\149 \236\180\136\234\184\176\237\153\148";
		GuiDefaultAllButton	= "\235\170\168\235\145\144 \236\180\136\234\184\176\237\153\148";
		GuiDefaultAllHelp	= "Auctioneer \236\132\164\236\160\149\236\157\132 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\152\235\160\164\235\169\180 \236\151\172\234\184\176\235\165\188 \237\129\180\235\166\173\237\149\152\236\139\173\236\139\156\236\152\164. \n\234\178\189\234\179\160: \236\167\128\234\184\136 \234\178\189\235\167\164\235\138\148 \236\136\152\237\150\137\235\144\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.";
		GuiDefaultOption	= "\236\132\164\236\160\149 \236\180\136\234\184\176\237\153\148";
		GuiEmbed	= "\234\178\140\236\158\132 \237\136\180\237\140\129\236\151\144 \236\160\149\235\179\180\235\165\188 \237\143\172\237\149\168\236\139\156\237\130\180";
		GuiEmbedBlankline	= "\234\178\140\236\158\132 \237\136\180\237\140\129\236\151\144 \234\179\181\235\176\177\236\164\132 \237\145\156\236\139\156";
		GuiEmbedHeader	= "\237\143\172\237\149\168";
		GuiFinish	= "\234\178\128\236\131\137\236\157\180 \235\129\157\235\130\152\235\169\180";
		GuiFinishSound	= "\234\178\128\236\130\172 \235\129\157\236\151\144 \235\134\128\236\157\180 \236\134\140\235\166\172";
		GuiLink	= "\235\167\129\237\129\172\236\149\132\236\157\180\235\148\148 \235\179\180\234\184\176";
		GuiLoad	= "Auctioneer \235\182\136\235\159\172\236\152\164\234\184\176";
		GuiLoad_Always	= "\237\149\173\236\131\129\236\130\172\236\154\169";
		GuiLoad_AuctionHouse	= "\234\178\189\235\167\164\236\158\165\236\151\144\236\132\156";
		GuiLoad_Never	= "\236\130\172\236\154\169\236\149\136\237\149\168";
		GuiLocale	= "\236\167\128\236\151\173 \236\132\164\236\160\149:";
		GuiMainEnable	= "Auctioneer \237\153\156\236\132\177\237\153\148";
		GuiMainHelp	= "\236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\236\153\128 \234\178\189\235\167\164 \235\141\176\236\157\180\237\131\128\235\165\188 \235\182\132\236\132\157\237\149\152\236\151\172 \237\145\156\236\139\156\237\149\180\236\163\188\235\138\148 \236\149\160\235\147\156\236\152\168\236\157\184 Auctioneer\236\151\144 \235\140\128\237\149\156 \236\132\164\236\160\149\236\157\132 \237\143\172\237\149\168. \234\178\189\235\167\164\236\158\165\236\151\144\236\132\156 \234\178\189\235\167\164 \235\141\176\236\157\180\237\131\128\235\165\188 \236\136\152\236\167\145\237\149\152\235\160\164\235\169\180 \"\234\178\128\236\131\137\" \235\178\132\237\138\188\236\157\132 \237\129\180\235\166\173\237\149\152\236\139\173\236\139\156\236\152\164.";
		GuiMarkup	= "\236\131\129\236\160\144 \234\176\128\234\178\169 \236\157\184\236\131\129 \235\185\132\236\156\168";
		GuiMaxless	= "\236\181\156\235\140\128 \236\139\156\236\158\165\234\176\128 \236\160\136\236\130\173 \235\185\132\236\156\168";
		GuiMedian	= "\236\164\145\236\149\153\234\176\146 \235\179\180\234\184\176";
		GuiNocomp	= "\234\178\189\237\149\169 \236\160\136\236\130\173 \235\185\132\236\156\168 \236\151\134\236\157\140";
		GuiNoWorldMap	= "Auctioneer: \236\155\148\235\147\156\235\167\181 \237\145\156\236\139\156\235\165\188\236\156\132\237\149\180 \234\176\144\236\182\176\236\167\144";
		GuiOtherHeader	= "\234\184\176\237\131\128 \236\152\181\236\133\152\235\147\164";
		GuiOtherHelp	= "\236\158\144\236\132\184\237\149\156 \234\178\189\235\167\164\236\157\184 \236\152\181\236\133\152\235\147\164";
		GuiPercentsHeader	= "Auctioneer \234\178\189\234\179\132\234\176\146 \237\141\188\236\132\188\237\138\184";
		GuiPercentsHelp	= "\234\178\189\234\179\160: \235\139\164\236\157\140 \236\132\164\236\160\149\236\157\128 \234\179\160\234\184\137 \236\130\172\236\154\169\236\158\144\235\167\140\236\157\132 \236\156\132\237\149\156 \234\178\131\236\158\133\235\139\136\235\139\164. \235\139\164\236\157\140 \236\161\176\236\160\136\234\176\146\235\147\164\236\157\128 \236\150\188\235\167\136\235\130\152 \236\160\129\234\183\185\236\160\129\236\156\188\235\161\156 Auctioneer\234\176\128 \236\157\180\236\156\164 \236\136\152\236\164\128\236\157\132 \234\178\176\236\160\149\237\149\160 \234\178\131\236\157\184\236\167\128\236\151\144 \234\180\128\237\149\156 \234\178\131\236\158\133\235\139\136\235\139\164.";
		GuiPrintin	= "\236\155\144\237\149\152\235\138\148 \235\169\148\236\139\156\236\167\128 \237\148\132\235\160\136\236\158\132 \236\132\160\237\131\157";
		GuiProtectWindow	= "\236\139\164\236\136\152\235\161\156 AH\236\176\189 \235\139\171\234\184\176 \235\176\169\236\167\128";
		GuiRedo	= "\236\158\165\234\184\176 \234\178\128\236\131\137 \234\178\189\234\179\160 \235\179\180\234\184\176";
		GuiReloadui	= "\236\130\172\236\154\169\236\158\144 \236\157\184\237\132\176\237\142\152\236\157\180\236\138\164 \235\166\172\235\161\156\235\147\156";
		GuiReloaduiButton	= "UI\235\166\172\235\161\156\235\147\156";
		GuiReloaduiFeedback	= "WoW UI\235\165\188 \235\166\172\235\161\156\235\147\156 \237\149\152\235\138\148\236\164\145";
		GuiReloaduiHelp	= "\236\157\180 \236\132\164\236\160\149 \237\153\148\235\169\180\236\151\144 \235\167\158\235\138\148 \236\167\128\236\151\173 \236\150\184\236\150\180\235\165\188 \236\132\160\237\131\157\237\149\156 \237\155\132\236\151\144 WoW \236\130\172\236\154\169\236\158\144 \236\157\184\237\132\176\237\142\152\236\157\180\236\132\156\235\165\188 \235\139\164\236\139\156 \235\161\156\235\147\156\237\149\152\234\184\176 \236\156\132\237\149\180 \236\157\180 \234\179\179\236\157\132 \237\129\180\235\166\173\237\149\152\236\139\173\236\139\156\236\152\164.\n\236\163\188\236\157\152: \236\157\180 \236\152\181\236\133\152\236\157\128 \235\170\135\235\182\132 \236\160\149\235\143\132 \234\177\184\235\166\180 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		GuiRememberText	= "\234\176\128\234\178\169 \234\184\176\236\150\181";
		GuiStatsEnable	= "\237\134\181\234\179\132 \235\179\180\234\184\176";
		GuiStatsHeader	= "\236\149\132\236\157\180\237\133\156 \234\176\128\234\178\169 \237\134\181\234\179\132";
		GuiStatsHelp	= "\237\136\180\237\140\129\236\151\144 \235\139\164\236\157\140 \237\134\181\234\179\132\235\159\137\236\157\132 \237\145\156\236\139\156\237\149\169\235\139\136\235\139\164.";
		GuiSuggest	= "\236\160\156\236\149\136\234\176\128 \235\179\180\234\184\176";
		GuiUnderlow	= "\234\176\128\236\158\165 \235\130\174\236\157\128 \234\178\189\235\167\164\234\176\128 \236\160\136\236\130\173";
		GuiUndermkt	= "Maxless\236\157\188 \235\149\140 \236\160\136\236\130\173\235\144\156 \236\139\156\236\158\165\234\176\128";
		GuiVerbose	= "\236\149\140\235\166\188 \235\170\168\235\147\156";
		GuiWarnColor	= "\234\176\128\234\178\169 \235\170\168\235\141\184 \236\131\137\236\131\129";


		-- Section: Conversion Messages
		MesgConvert	= "Auctioneer \235\141\176\236\157\180\237\132\176\235\178\160\236\157\180\236\138\164\235\165\188 \236\131\136\235\161\173\234\178\140 \235\179\128\237\153\152\237\149\169\235\139\136\235\139\164. SavedVariables\\Auctioneer.lua \237\140\140\236\157\188\236\157\132 \235\175\184\235\166\172 \235\176\177\236\151\133\237\149\180\235\145\144\236\139\156\234\184\184 \234\182\140\236\158\165\237\149\169\235\139\136\235\139\164.%s%s";
		MesgConvertNo	= "Auctioneer \235\185\132\237\153\156\236\132\177\237\153\148";
		MesgConvertYes	= "\235\179\128\237\153\152";
		MesgNotconverting	= "\235\141\176\236\157\180\237\132\176\235\178\160\236\157\180\236\138\164\235\165\188 \235\179\128\237\153\152\237\149\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164. \234\183\184\235\159\172\235\130\152 \235\179\128\237\153\152\236\157\132 \237\149\152\236\167\128 \236\149\138\236\156\188\235\169\180 Auctioneer\235\138\148 \235\143\153\236\158\145\237\149\152\236\167\128 \236\149\138\236\157\132 \234\178\131\236\158\133\235\139\136\235\139\164.";


		-- Section: Game Constants
		TimeLong	= "\236\158\165\234\184\176";
		TimeMed	= "\236\164\145\234\184\176";
		TimeShort	= "\235\139\168\234\184\176";
		TimeVlong	= "\236\181\156\236\158\165\234\184\176";


		-- Section: Generic Messages
		DisableMsg	= "Auctioneer \236\158\144\235\143\153\236\156\188\235\161\156 \235\182\136\235\159\172\236\152\164\234\184\176 \235\185\132\237\153\156\236\132\177\237\153\148";
		FrmtWelcome	= "Auctioneer v%s \235\161\156\235\147\156\235\144\168.";
		MesgNotLoaded	= "Auctioneer \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\157\140. \235\141\148 \235\167\142\236\157\128 \236\160\149\235\179\180\235\165\188 \235\179\180\235\160\164\235\169\180 /auctioneer \235\157\188\234\179\160 \236\158\133\235\160\165\237\149\152\236\132\184\236\154\148.";
		StatAskPriceOff	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\180 \235\185\132\237\153\156\236\132\177\237\153\148\235\144\169\235\139\136\235\139\164.";
		StatAskPriceOn	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\180 \237\153\156\236\132\177\237\153\148\235\144\169\235\139\136\235\139\164.";
		StatOff	= "\236\150\180\235\150\164 \234\178\189\235\167\164 \236\160\149\235\179\180\235\143\132 \237\145\156\236\139\156\235\144\152\236\167\128 \236\149\138\236\157\140";
		StatOn	= "\236\132\164\236\160\149\235\144\156 \234\178\189\235\167\164 \235\141\176\236\157\180\237\131\128 \237\145\156\236\139\156";


		-- Section: Generic Strings
		TextAuction	= "\234\178\189\235\167\164";
		TextCombat	= "\236\160\132\237\136\172";
		TextGeneral	= "\236\157\188\235\176\152";
		TextNone	= "\236\151\134\236\157\140";
		TextScan	= "\234\178\128\236\131\137";
		TextUsage	= "\236\130\172\236\154\169\235\178\149:";


		-- Section: Help Text
		HelpAlso	= "\235\139\164\235\165\184 \236\132\156\235\178\132\236\151\144\236\132\156\236\157\152 \234\176\128\234\178\169\236\157\132 \237\136\180\237\140\129\236\151\144 \237\145\156\236\139\156. \236\132\156\235\178\132\235\170\133\234\179\188 \236\167\132\236\152\129\236\157\132 \236\182\148\234\176\128. \236\152\136\236\160\156: \"/auctioneer also Al'Akir-Horde\". \237\138\185\235\179\132\237\149\156 \237\130\164\236\155\140\235\147\156\236\157\184 \"opposite\"\236\157\128 \236\160\129\235\140\128 \236\167\132\236\152\129\236\157\132 \236\157\152\235\175\184\237\149\152\234\179\160, \"off\"\235\138\148 \234\184\176\235\138\165 \235\129\132\234\184\176.";
		HelpAskPrice	= "\234\176\128\234\178\169\236\154\148\236\178\173 \237\153\156\236\132\177\237\153\148 \235\152\144\235\138\148 \235\185\132\237\153\156\236\132\177\237\153\148";
		HelpAskPriceAd	= "\236\131\136\235\161\156\236\154\180 \237\138\185\236\167\149 \234\180\145\234\179\160 \234\176\128\234\178\169\236\154\148\236\178\173 \237\153\156\236\132\177\237\153\148 \235\152\144\235\138\148 \235\185\132\237\153\156\236\132\177\237\153\148";
		HelpAskPriceGuild	= "\234\184\184\235\147\156 \235\140\128\237\153\148\236\151\144\236\132\156 \237\128\152\235\166\172\236\151\144 \236\157\145\235\139\181\237\149\169\235\139\136\235\139\164.";
		HelpAskPriceParty	= "\237\140\140\237\139\176 \235\140\128\237\153\148\236\151\144\236\132\156 \237\128\152\235\166\172\236\151\144 \236\157\145\235\139\181\237\149\169\235\139\136\235\139\164.";
		HelpAskPriceSmart	= "\236\138\164\235\167\136\237\138\184\236\155\140\235\147\156 \237\153\156\236\132\177\237\153\148 \235\152\144\235\138\148 \235\185\132\237\153\156\236\132\177\237\153\148\235\165\188 \234\178\128\236\130\172\237\149\169\235\139\136\235\139\164.";
		HelpAskPriceTrigger	= "\234\176\128\234\178\169\236\154\148\236\178\173\236\157\152 \237\138\184\235\166\172\234\177\176 \235\172\184\236\158\144\235\165\188 \235\179\128\234\178\189\237\149\169\235\139\136\235\139\164.";
		HelpAskPriceVendor	= "\236\131\129\236\160\144 \234\176\128\234\178\169 \235\141\176\236\157\180\237\131\128 \236\160\132\236\134\161 \237\153\156\236\132\177\237\153\148 \235\152\144\235\138\148 \235\185\132\237\153\156\236\132\177\237\153\148 \237\149\169\235\139\136\235\139\164.";
		HelpAskPriceWhispers	= "\235\170\168\235\145\144\236\157\152 \236\136\168\234\184\176\234\184\176 \235\172\187\235\138\148\235\139\164 \234\176\128\234\178\169\236\151\144\234\178\140 \235\130\152\234\176\128\235\138\148 \236\134\141\236\130\173\236\158\132\236\157\132 \234\176\128\235\138\165\237\149\152\234\178\140 \237\149\152\234\177\176\235\130\152 \235\172\180\235\138\165\237\149\152\234\178\140 \237\149\152\236\139\173\236\139\156\236\152\164.";
		HelpAskPriceWord	= "\235\172\187\235\138\148\235\139\164 \234\176\128\234\178\169\236\157\152 \236\163\188\235\172\184 \235\152\145\235\152\145\237\149\156 \235\130\177\235\167\144\236\157\132 \236\182\148\234\176\128\237\149\152\234\177\176\235\130\152 \235\179\128\234\178\189\237\149\152\236\139\173\236\139\156\236\152\164.";
		HelpAuctionClick	= "\234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156\236\157\132 Alt-\237\129\180\235\166\173 \237\149\152\235\169\180 \236\158\144\235\143\153\236\156\188\235\161\156 \234\178\189\235\167\164\236\139\156\236\158\145";
		HelpAuctionDuration	= "AH\236\176\189\236\157\132 \236\151\180\235\149\140 \234\184\176\235\179\184 \234\178\189\235\167\164 \234\184\176\234\176\132\236\157\132 \236\132\164\236\160\149";
		HelpAutofill	= "AH\236\176\189\236\151\144 \236\131\136\235\161\156\236\154\180 \234\178\189\235\167\164\235\165\188 \235\147\177\235\161\157\237\149\152\235\169\180 \236\158\144\235\143\153\236\156\188\235\161\156 \234\176\128\234\178\169 \236\158\133\235\160\165 \237\149\160\234\178\131\236\157\184\236\167\128 \236\132\164\236\160\149";
		HelpAverage	= "\236\149\132\236\157\180\237\133\156\236\157\152 \237\143\137\234\183\160 \234\178\189\235\167\164\234\176\128 \237\145\156\236\139\156 \236\151\172\235\182\128 \236\132\160\237\131\157";
		HelpBidbroker	= "\236\181\156\234\183\188 \234\178\128\236\131\137\237\149\156 \236\157\180\236\157\181\236\157\132 \236\156\132\237\149\180 \236\158\133\236\176\176\237\149\156 \234\178\189\235\167\164\236\151\144\236\132\156 \235\139\168\234\184\176 \235\152\144\235\138\148 \236\164\145\234\184\176\236\157\184 \234\178\189\235\167\164\235\165\188 \237\145\156\236\139\156";
		HelpBidLimit	= "\234\178\189\235\167\164\237\146\136 \234\178\128\236\131\137 \237\131\173\236\151\144\236\132\156 \236\158\133\236\176\176 \235\152\144\235\138\148 \236\166\137\236\139\156 \234\181\172\236\158\133 \235\178\132\237\138\188\236\157\180 \237\129\180\235\166\173 \235\144\152\236\151\136\236\157\132 \235\149\140 \236\158\133\236\176\176 \235\152\144\235\138\148 \236\166\137\236\139\156 \234\181\172\236\158\133\237\149\160 \234\178\189\235\167\164\237\146\136\236\157\152 \236\181\156\235\140\128 \236\136\152\235\159\137";
		HelpBroker	= "\236\181\156\234\183\188 \234\178\128\236\131\137\237\149\156 \234\178\189\235\167\164\236\151\144\236\132\156 \235\139\164\236\139\156 \237\140\148\234\178\189\236\154\176 \236\157\180\236\157\181\236\157\180 \236\131\157\234\184\176\235\138\148 \236\149\132\236\157\180\237\133\156 \235\170\168\235\145\144 \237\145\156\236\139\156";
		HelpClear	= "\237\138\185\236\160\149 \236\149\132\236\157\180\237\133\156\236\151\144 \235\140\128\237\149\156 \236\160\149\235\179\180 \236\130\173\236\160\156 (\235\176\152\235\147\156\236\139\156 Shift \237\129\180\235\166\173\236\157\132\237\134\181\237\149\180 \235\170\133\235\160\185\236\164\132\236\151\144 \236\149\132\236\157\180\237\133\156\236\157\132 \236\158\133\235\160\165\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164.) \235\152\144\237\149\156 \237\138\185\235\179\132\237\158\136 all \235\152\144\235\138\148 snapshot \237\130\164\236\155\140\235\147\156\235\165\188 \236\130\172\236\154\169\237\149\160\236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpCompete	= "\236\181\156\234\183\188 \234\178\128\236\131\137\235\144\156 \234\178\189\235\167\164\236\151\144\236\132\156 \236\158\144\236\139\160\235\179\180\235\139\164 \235\130\174\236\157\128 \236\166\137\234\181\172\234\176\128\235\165\188 \234\176\128\236\167\132 \236\149\132\236\149\132\237\133\156 \235\179\180\234\184\176";
		HelpDefault	= "Auctioneer\236\157\152 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \235\179\128\234\178\189. \"all\" \237\130\164\236\155\140\235\147\156\235\165\188 \237\134\181\237\149\180\236\132\156 \235\170\168\235\147\160 \236\132\164\236\160\149\236\157\132 \234\184\176\235\179\184\234\176\146\236\156\188\235\161\156 \236\132\164\236\160\149\237\149\160\236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpDisable	= "\235\139\164\236\157\140 \235\161\156\234\183\184\236\157\184 \235\182\128\237\132\176 \236\158\144\235\143\153\236\156\188\235\161\156 Auctioneer\235\165\188 \235\161\156\235\147\156\237\149\152\236\167\128 \236\149\138\236\157\140";
		HelpEmbed	= "\234\184\176\235\179\184 \234\178\140\236\158\132 \237\136\180\237\140\129\236\151\144 \237\133\141\236\138\164\237\138\184 \237\143\172\237\149\168(\236\163\188\236\157\152: \236\157\180\234\178\131\236\157\132 \236\132\160\237\131\157\237\149\152\235\169\180 \236\150\180\235\150\164 \237\138\185\236\132\177\235\147\164\236\157\128 \236\130\172\236\154\169\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.)";
		HelpEmbedBlank	= "\237\143\172\237\149\168 \235\170\168\235\147\156\234\176\128 \236\188\156\236\158\136\236\157\132 \235\149\140 \237\136\180\237\140\129 \236\160\149\235\179\180\236\153\128 \234\178\189\235\167\164 \236\160\149\235\179\180 \236\130\172\236\157\180\236\151\144 \237\149\156\236\164\132 \235\157\132\236\154\176\234\184\176";
		HelpFinish	= "\234\178\189\235\167\164 \234\178\128\236\131\137\236\157\180 \235\129\157\235\130\152\235\169\180 \236\158\144\235\143\153\236\156\188\235\161\156 \235\161\156\234\183\184\236\149\132\236\155\131 \235\152\144\235\138\148 \234\178\140\236\158\132\236\157\132 \235\130\152\234\176\136\234\178\131\236\157\184\236\167\128\235\165\188 \236\132\164\236\160\149";
		HelpFinishSound	= "\234\178\189\235\167\164 \236\167\145 \234\178\128\236\130\172\236\157\152 \235\129\157\236\151\144 \236\134\140\235\166\172\235\165\188 \235\134\128\234\184\176 \236\156\132\237\149\152\236\151\172 \235\134\147\236\156\188\236\139\173\236\139\156\236\152\164.";
		HelpLink	= "\237\136\180\237\140\129\236\151\144 \235\167\129\237\129\172 \236\149\132\236\157\180\235\148\148 \235\179\180\234\184\176";
		HelpLoad	= "Auctioneer \235\161\156\235\147\156 \236\132\164\236\160\149 \235\179\128\234\178\189";
		HelpLocale	= "\234\178\189\235\167\164\236\157\184 \235\169\148\236\132\184\236\167\128 \237\145\156\236\139\156\236\151\144 \236\130\172\236\154\169\235\144\152\235\138\148 \236\167\128\236\151\173 \236\160\149\235\179\180 \235\179\128\234\178\189";
		HelpMedian	= "\236\149\132\236\157\180\237\133\156\236\157\152 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\236\149\153\234\176\146 \235\179\180\234\184\176";
		HelpOnoff	= "\234\178\189\235\167\164 \235\141\176\236\157\180\237\131\128 \237\145\156\236\139\156 \236\188\156\234\184\176 \235\152\144\235\138\148 \235\129\132\234\184\176";
		HelpPctBidmarkdown	= "\234\178\189\235\167\164\236\157\184\236\157\180 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128\235\179\180\235\139\164 \235\130\174\236\157\128 \234\176\128\234\178\169\236\151\144 \236\158\133\236\176\176\237\149\160 \235\185\132\236\156\168 \236\132\164\236\160\149";
		HelpPctMarkup	= "\235\139\164\235\165\184 \234\176\146\236\157\180 \237\145\156\236\139\156 \234\176\128\235\138\165\237\149\152\236\167\128 \236\149\138\236\157\132 \235\149\140 \236\131\129\236\160\144 \234\176\128\234\178\169\236\157\180 \236\132\160\237\131\157\235\144\160 \235\185\132\236\156\168.";
		HelpPctMaxless	= "\237\143\172\234\184\176\237\149\152\234\184\176 \236\160\132\236\151\144 Auctioneer\234\176\128 \236\139\156\236\158\165\234\176\128\235\165\188 \236\160\136\236\130\173\237\149\160 \236\181\156\235\140\128 \235\185\132\236\156\168 \236\132\164\236\160\149.";
		HelpPctNocomp	= "\234\178\189\237\149\169\236\157\180 \236\151\134\236\157\132 \235\149\140 Auctioneer\234\176\128 \236\139\156\236\158\165\234\176\128\235\165\188 \236\160\136\236\130\173\237\149\160 \235\185\132\236\156\168.";
		HelpPctUnderlow	= "Auctioneer\234\176\128 \234\176\128\236\158\165 \236\160\129\236\157\128 \234\178\189\235\167\164\234\176\128\235\165\188 \236\160\136\236\130\173\237\149\160 \235\185\132\236\156\168 \236\132\164\236\160\149.";
		HelpPctUndermkt	= "\234\178\189\237\149\169\236\151\144\236\132\156 \236\158\133\236\176\176 \237\149\160 \236\136\152 \236\151\134\235\138\148 \234\178\189\236\154\176 \236\139\156\236\158\165 \234\176\128\234\178\169\236\157\132 \236\160\136\236\130\173\237\149\160 \235\185\132\236\156\168.(maxless\236\151\144 \236\157\152\237\149\180)";
		HelpPercentless	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128\234\176\128 \236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128 \236\157\180\237\149\152\236\157\152 \237\153\149\235\165\160\236\157\184 \236\181\156\234\183\188 \234\178\128\236\131\137\235\144\156 \234\178\189\235\167\164 \235\172\188\237\146\136\235\147\164 \235\179\180\234\184\176";
		HelpPrintin	= "Auctioneer\234\176\128 \235\169\148\236\139\156\236\167\128\235\165\188 \237\145\156\236\139\156\237\149\160 \236\176\189\236\157\132 \236\132\164\236\160\149. \237\148\132\235\160\136\236\158\132\235\170\133\236\157\180\235\130\152 \235\178\136\237\152\184\235\165\188 \237\134\181\237\149\180 \234\178\176\236\160\149\237\149\160\236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164.";
		HelpProtectWindow	= "\236\139\164\236\136\152\235\161\156 AH\236\176\189 \235\139\171\234\184\176 \235\176\169\236\167\128";
		HelpRedo	= "\236\132\156\235\178\132\236\157\152 \235\158\153 \235\149\140\235\172\184\236\151\144 \234\178\189\235\167\164 \234\178\128\236\131\137\236\157\180 \236\152\164\235\158\152 \234\177\184\235\166\180 \234\178\189\236\154\176 \234\178\189\234\179\160";
		HelpScan	= "\235\139\164\236\157\140 \235\176\169\235\172\184 \235\149\140 \235\152\144\235\138\148 \234\183\184\234\179\179\236\151\144 \236\158\136\235\138\148 \235\143\153\236\149\136 \234\178\189\235\167\164\236\158\165 \234\178\128\236\131\137 \236\136\152\237\150\137(\234\178\189\235\167\164\236\176\189\236\151\144\235\143\132 \235\178\132\237\138\188\236\157\180 \236\158\136\236\157\140). \234\178\128\236\131\137\237\149\160 \235\182\132\235\165\152\236\151\144 \236\178\180\237\129\172 \236\131\129\236\158\144\235\165\188 \236\132\160\237\131\157\237\149\152\236\139\173\236\139\156\236\152\164.";
		HelpStats	= "\236\149\132\236\157\180\237\133\156\236\157\152 \236\158\133\236\176\176/\236\166\137\234\181\172 \237\141\188\236\132\188\237\138\184 \235\179\180\234\184\176 \236\151\172\235\182\128 \236\132\164\236\160\149";
		HelpSuggest	= "\236\149\132\236\157\180\237\133\156\236\157\152 \236\160\156\236\149\136 \234\178\189\235\167\164\234\176\128 \235\179\180\234\184\176 \236\151\172\235\182\128 \234\178\176\236\160\149";
		HelpUpdatePrice	= "\234\178\189\235\167\164\237\146\136 \237\131\173\236\151\144\236\132\156 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128\234\176\128 \235\179\128\234\178\189\235\144\152\235\169\180 \234\178\189\235\167\164\237\146\136\236\151\144 \235\140\128\237\149\156 \236\139\156\236\158\145\234\176\128\235\165\188 \236\158\144\235\143\153\236\156\188\235\161\156 \234\176\177\236\139\160\237\149\169\235\139\136\235\139\164.";
		HelpVerbose	= "\237\143\137\234\183\160\234\179\188 \236\151\172\235\159\172\234\176\128\236\167\128 \236\160\156\236\149\136 \236\130\172\237\149\173 \235\179\180\234\184\176(\235\152\144\235\138\148 \237\149\156\236\164\132\236\151\144 \235\179\180\234\184\176 \235\129\132\234\184\176)";
		HelpWarnColor	= "\237\152\132\236\158\172 AH \234\176\128\234\178\169 \235\170\168\235\141\184(\236\160\136\236\130\173\235\144\156...)\236\157\132 \236\167\129\234\180\128\236\160\129\236\157\184 \236\131\137\236\131\129\236\156\188\235\161\156 \237\145\156\236\139\156\237\149\160\236\167\128 \236\132\160\237\131\157\237\149\169\235\139\136\235\139\164.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "\234\178\189\235\167\164 \236\131\157\236\132\177\236\157\132 \236\156\132\237\149\156 \235\185\136 \234\179\181\234\176\132\236\157\180 \236\151\134\236\157\140";
		FrmtNotEnoughOfItem	= "\234\178\189\235\167\164 \236\131\157\236\132\177\236\157\132 \236\156\132\237\149\156 %s|1\236\157\180;\234\176\128; \236\182\169\235\182\132\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.";
		FrmtPostedAuction	= "%s (x%d) 1\234\176\156\235\165\188 \234\178\140\236\139\156\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.";
		FrmtPostedAuctions	= "%s (x%d) %d\234\176\156\235\165\188 \234\178\140\236\139\156\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\237\152\132\236\158\172\236\158\133\236\176\176";
		FrmtBidbrokerDone	= "\236\158\133\236\176\176 \236\164\145\234\176\156 \236\153\132\235\163\140";
		FrmtBidbrokerHeader	= "\236\181\156\236\160\128 \236\157\180\236\156\164: %s, HSP = '\236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128'";
		FrmtBidbrokerLine	= "%s, \236\181\156\234\183\188 %s\237\154\140 \234\178\128\236\131\137\235\144\168, \236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128(HSP): %s, %s: %s, \236\157\180\236\156\164: %s, \236\139\156\234\176\132: %s";
		FrmtBidbrokerMinbid	= "\236\181\156\236\160\128\236\158\133\236\176\176";
		FrmtBrokerDone	= "\236\158\133\236\176\176 \236\164\145\234\176\156 \236\153\132\235\163\140";
		FrmtBrokerHeader	= "\236\181\156\236\160\128 \236\157\180\236\156\164: %s, HSP = '\236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128'";
		FrmtBrokerLine	= "%s, \236\181\156\234\183\188 %s\237\154\140 \234\178\128\236\131\137\235\144\168, \236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128(HSP): %s, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128(BO): %s, \236\157\180\236\156\164: %s";
		FrmtCompeteDone	= "\234\178\189\235\167\164 \235\172\188\237\146\136 \234\178\189\237\149\169 \236\153\132\235\163\140.";
		FrmtCompeteHeader	= "\236\160\129\236\150\180\235\143\132 \236\149\132\236\157\180\237\133\156 \235\139\185 %s \236\157\180\237\149\152\236\157\152 \234\178\189\235\167\164 \235\172\188\237\146\136\236\151\144 \234\178\189\237\149\169.";
		FrmtCompeteLine	= "%s, \236\158\133\236\176\176: %s, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128(BO) %s \235\140\128 %s, %s \236\157\180\237\149\152";
		FrmtHspLine	= "%s \234\176\156\235\139\185 \236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128\235\138\148: %s";
		FrmtLowLine	= "%s, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128: %s, \237\140\144\235\167\164\236\158\144: %s, \234\176\156\235\139\185: %s, \236\164\145\236\149\153\234\176\146 \236\157\180\237\149\152: %s";
		FrmtMedianLine	= "\236\181\156\234\183\188 %d\237\154\140 \234\178\128\236\131\137\235\144\168, %s \237\149\156 \234\176\156\235\139\185 \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\236\149\153\234\176\146: %s";
		FrmtNoauct	= "\237\149\180\235\139\185 \236\149\132\236\157\180\237\133\156\236\151\144 \235\140\128\237\149\180 \236\176\190\236\157\132 \236\136\152 \236\151\134\236\157\140: %s";
		FrmtPctlessDone	= "\236\132\177\236\130\172\235\144\152\236\167\128 \236\149\138\236\157\132 \237\153\149\235\165\160.";
		FrmtPctlessHeader	= "\236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128(HSP)\235\179\180\235\139\164 \235\130\174\236\157\132 \237\153\149\235\165\160: %d%%";
		FrmtPctlessLine	= "%s, \236\181\156\234\183\188 %d\237\154\140 \234\178\128\236\131\137\235\144\168, \236\181\156\234\179\160 \237\140\144\235\167\164\234\176\128\235\138\165\234\176\128(HSP): %s, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128(BO): %s, \236\157\180\236\156\164: %s, %s \236\157\180\237\149\152";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "\236\130\173\236\160\156\235\144\156 \234\184\176\235\179\184 \234\178\189\235\167\164 \235\172\188\237\146\136 \236\136\152\235\159\137: %s";
		AuctionDiscrepancies	= "\236\176\168\236\157\180\235\130\152\235\138\148 \236\136\152\235\159\137: %s";
		AuctionNewAucts	= "\236\131\136\235\161\173\234\178\140 \234\178\128\236\131\137\235\144\156 \234\178\189\235\167\164 \235\172\188\237\146\136 \236\136\152\235\159\137: %s";
		AuctionOldAucts	= "\236\157\180\236\160\132\236\151\144 \234\178\128\236\131\137\235\144\156 \234\178\189\235\167\164 \235\172\188\237\146\136 \236\136\152\235\159\137: %s";
		AuctionPageN	= "Auctioneer: %s %d/%d \234\178\128\236\131\137\236\164\145 \236\180\136\235\139\185 \234\178\128\236\131\137 \234\178\189\235\167\164\237\146\136: %s \236\182\148\236\160\149 \235\130\168\236\157\128 \236\139\156\234\176\132: %s";
		AuctionScanDone	= "Auctioneer: \234\178\189\235\167\164 \235\172\188\237\146\136 \234\178\128\236\131\137 \236\153\132\235\163\140";
		AuctionScanNexttime	= "\235\139\164\236\157\140 \234\178\189\235\167\164\236\157\184\234\179\188 \235\140\128\237\153\148\237\149\160 \235\149\140, Auctioneer\235\138\148 \236\160\132\236\178\180 \234\178\128\236\131\137\236\157\132 \237\149\160 \234\178\131\236\158\133\235\139\136\235\139\164.";
		AuctionScanNocat	= "\234\178\128\236\131\137\236\157\132 \236\156\132\237\149\180 \236\181\156\236\134\140\237\149\156 \237\149\156\234\176\156 \236\157\180\236\131\129\236\157\152 \235\182\132\235\165\152\235\165\188 \236\132\160\237\131\157\237\149\152\236\151\172\236\149\188 \237\149\169\235\139\136\235\139\164.";
		AuctionScanRedo	= "\237\152\132\236\158\172 \237\142\152\236\157\180\236\167\128\235\165\188 \236\153\132\235\163\140\237\149\152\235\160\164\235\169\180 %d \236\180\136 \236\157\180\236\131\129 \234\177\184\235\166\189\235\139\136\235\139\164. \237\142\152\236\157\180\236\167\128 \236\158\172\236\139\156\235\143\132.";
		AuctionScanStart	= "Auctioneer: %s \237\142\152\236\157\180\236\167\128 1 \234\178\128\236\131\137\236\164\145...";
		AuctionTotalAucts	= "\234\178\128\236\131\137\235\144\156 \234\178\189\235\167\164 \235\172\188\237\146\136 \236\180\157 \236\136\152\235\159\137: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "%s\236\151\144\236\132\156 %d\237\154\140 \235\180\132";
		FrmtInfoAverage	= "\236\181\156\236\160\128 %s/%s \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 (%s\236\151\144 \236\158\133\236\176\176)";
		FrmtInfoBidMulti	= "\236\158\133\236\176\176 (%s%s \234\176\156)";
		FrmtInfoBidOne	= "\236\158\133\236\176\176 %s";
		FrmtInfoBidrate	= "\236\158\133\236\176\176 \237\153\149\235\165\160 %d%%, \236\166\137\236\139\156 \234\181\172\236\158\133 \237\153\149\235\165\160 %d%%";
		FrmtInfoBuymedian	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\236\149\153\234\176\146";
		FrmtInfoBuyMulti	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 (%s%s \234\176\156)";
		FrmtInfoBuyOne	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 %s";
		FrmtInfoForone	= "\234\176\156\235\139\185: \236\181\156\236\160\128 %s/%s \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 (%s \236\158\133\236\176\176) [%d\234\176\156\236\157\152 \236\136\152\235\159\137 \236\164\145]";
		FrmtInfoHeadMulti	= "%d\234\176\156\236\157\152 \237\143\137\234\183\160:";
		FrmtInfoHeadOne	= "\237\143\137\234\183\160:";
		FrmtInfoHistmed	= "\236\181\156\234\183\188 %d, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\236\149\153\234\176\146 (\234\176\156)";
		FrmtInfoMinMulti	= "\234\178\189\235\167\164 \236\139\156\236\158\145\234\176\128 (%s \234\176\156)";
		FrmtInfoMinOne	= "\234\178\189\235\167\164 \236\139\156\236\158\145\234\176\128";
		FrmtInfoNever	= "%s\236\151\144\236\132\156 \235\179\184\236\160\129 \236\151\134\236\157\140";
		FrmtInfoSeen	= "\236\160\132\236\178\180 \234\178\189\235\167\164\236\151\144\236\132\156 %d\237\154\140 \234\178\128\236\131\137\235\144\168";
		FrmtInfoSgst	= "\236\160\156\236\149\136 \234\176\128\234\178\169: \236\181\156\236\160\128 %s /%s \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128";
		FrmtInfoSgststx	= "%d \234\176\156\236\151\144 \235\140\128\237\149\156 \236\160\156\236\149\136 \234\176\128\234\178\169: \236\181\156\236\160\128\234\176\128 %s/ \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 %s";
		FrmtInfoSnapmed	= "%d\237\154\140 \234\178\128\236\131\137\235\144\168, \236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128 \236\164\145\236\149\153\234\176\146 (\234\176\156)";
		FrmtInfoStacksize	= "\237\143\137\234\183\160 \237\149\156 \235\172\182\236\157\140 \236\136\152\235\159\137: %d\234\176\156";


		-- Section: User Interface
		FrmtLastSoldOn	= "\236\181\156\234\183\188 \237\140\144\235\167\164\234\176\128 : %s";
		UiBid	= "\236\158\133\236\176\176";
		UiBidHeader	= "\236\158\133\236\176\176";
		UiBidPerHeader	= "\234\176\156\235\139\185 \236\158\133\236\176\176";
		UiBuyout	= "\236\166\137\236\139\156 \234\181\172\236\158\133";
		UiBuyoutHeader	= "\236\166\137\236\139\156 \234\181\172\236\158\133";
		UiBuyoutPerHeader	= "\234\176\156\235\139\185 \236\166\137\236\139\156 \234\181\172\236\158\133";
		UiBuyoutPriceLabel	= "\236\166\137\236\139\156 \234\181\172\236\158\133\234\176\128";
		UiBuyoutPriceTooLowError	= "(\235\132\136\235\172\180 \235\130\174\236\157\140)";
		UiCategoryLabel	= "\235\182\132\235\165\152 \236\160\156\237\149\156:";
		UiDepositLabel	= "\235\179\180\236\166\157\234\184\136";
		UiDurationLabel	= "\234\178\189\235\167\164 \234\184\176\234\176\132";
		UiItemLevelHeader	= "\235\160\136\235\178\168";
		UiMakeFixedPriceLabel	= "\234\176\128\234\178\169 \234\179\160\236\160\149";
		UiMaxError	= "(%d \236\181\156\235\140\128)";
		UiMaximumPriceLabel	= "\236\181\156\234\179\160\234\176\128:";
		UiMaximumTimeLeftLabel	= "\236\181\156\235\140\128 \235\130\168\236\157\128 \234\184\176\234\176\132";
		UiMinimumPercentLessLabel	= "\236\181\156\236\134\140 \234\176\144\236\134\140 \235\185\132\236\156\168:";
		UiMinimumProfitLabel	= "\236\181\156\236\134\140 \236\157\180\236\157\181";
		UiMinimumQualityLabel	= "\236\181\156\236\134\140 \237\146\136\236\167\136:";
		UiMinimumUndercutLabel	= "\236\181\156\236\134\140 \236\130\173\234\176\144:";
		UiNameHeader	= "\236\157\180\235\166\132";
		UiNoPendingBids	= "\235\170\168\235\147\160 \236\158\133\236\176\176 \236\153\132\235\163\140\235\165\188 \236\154\148\236\178\173\237\150\136\236\138\181\235\139\136\235\139\164!";
		UiNotEnoughError	= "(\236\182\169\235\182\132\237\149\152\236\167\128 \236\149\138\236\157\140)";
		UiPendingBidInProgress	= "1\234\176\156\236\157\152 \236\158\133\236\176\176\236\157\180 \236\178\152\235\166\172 \236\154\148\236\178\173\235\144\168...";
		UiPendingBidsInProgress	= "%d\234\176\156\236\157\152 \234\178\176\236\160\149\235\144\152\236\167\128\236\149\138\236\157\128 \236\158\133\236\176\176\236\157\180 \236\154\148\236\178\173\235\144\168...";
		UiPercentLessHeader	= "%";
		UiPost	= "\234\178\140\236\139\156";
		UiPostAuctions	= "\234\178\189\235\167\164 \234\178\140\236\139\156";
		UiPriceBasedOnLabel	= "\234\176\128\234\178\169 \234\183\188\234\177\176:";
		UiPriceModelAuctioneer	= "Auctioneer \234\176\128\234\178\169";
		UiPriceModelCustom	= "\236\130\172\236\154\169\236\158\144 \234\176\128\234\178\169";
		UiPriceModelFixed	= "\234\179\160\236\160\149\235\144\156 \234\176\128\234\178\169";
		UiPriceModelLastSold	= "\236\181\156\234\183\188 \237\140\144\235\167\164\234\176\128";
		UiProfitHeader	= "\236\157\180\236\157\181";
		UiProfitPerHeader	= "\234\176\156\235\139\185 \236\157\180\236\157\181";
		UiQuantityHeader	= "\236\136\152\235\159\137";
		UiQuantityLabel	= "\236\136\152\235\159\137:";
		UiRemoveSearchButton	= "\236\130\173\236\160\156";
		UiSavedSearchLabel	= "\236\160\128\236\158\165\235\144\156 \234\178\128\236\131\137\235\130\180\236\154\169:";
		UiSaveSearchButton	= "\236\160\128\236\158\165";
		UiSaveSearchLabel	= "\236\157\180\235\178\136 \234\178\128\236\131\137 \236\160\128\236\158\165:";
		UiSearch	= "\234\178\128\236\131\137";
		UiSearchAuctions	= "\234\178\189\235\167\164 \234\178\128\236\131\137";
		UiSearchDropDownLabel	= "\234\178\128\236\131\137";
		UiSearchForLabel	= "\236\149\132\236\157\180\237\133\156\236\156\188\235\161\156 \234\178\128\236\131\137:";
		UiSearchTypeBids	= "\236\158\133\236\176\176";
		UiSearchTypeBuyouts	= "\236\166\137\236\139\156\234\181\172\236\158\133";
		UiSearchTypeCompetition	= "\234\178\189\236\159\129";
		UiSearchTypePlain	= "\236\149\132\236\157\180\237\133\156";
		UiStacksLabel	= "\235\172\182\236\157\140";
		UiStackTooBigError	= "(\235\172\182\236\157\140\236\157\180 \235\132\136\235\172\180 \237\129\188)";
		UiStackTooSmallError	= "(\235\172\182\236\157\140\236\157\180 \235\132\136\235\172\180 \236\158\145\236\157\140)";
		UiStartingPriceLabel	= "\234\178\189\235\167\164 \236\139\156\236\158\145\234\176\128:";
		UiStartingPriceRequiredError	= "(\237\149\132\236\154\148\237\149\168)";
		UiTimeLeftHeader	= "\235\130\168\236\157\128 \236\139\156\234\176\132";
		UiUnknownError	= "(\236\149\140\236\136\152\236\151\134\236\157\140)";

	};

	nlNL = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Verkrijg stapel prijzen met %sx[ItemLink] (x = stapelprijs)";
		FrmtAskPriceBuyoutMedianHistorical	= "%sOpkoop-mediaan historisch: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sOpkoop-mediaan laatste scan: %s%s";
		FrmtAskPriceDisable	= "AskPrice's %s optie uitgeschakeld";
		FrmtAskPriceEach	= "(%s ieder)";
		FrmtAskPriceEnable	= "AskPrice's %s optie ingeschakeld";
		FrmtAskPriceVendorPrice	= "%sVerkoop aan winkelier voor: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "Veiling-id %s verwijderd van huidige AH momentopname.";
		FrmtAuctinfoHist	= "%d historisch";
		FrmtAuctinfoLow	= "Momentopname Laag";
		FrmtAuctinfoMktprice	= "Marktprijs";
		FrmtAuctinfoNolow	= "Item niet gezien in laatste Momentopname";
		FrmtAuctinfoOrig	= "Oorspronkelijk Bod";
		FrmtAuctinfoSnap	= "%d laatste scan";
		FrmtAuctinfoSugbid	= "Startbod";
		FrmtAuctinfoSugbuy	= "Opkoop voorstel";
		FrmtWarnAbovemkt	= "Competitie boven de markt";
		FrmtWarnMarkup	= "Winkelprijs opgehoogd met %s%%";
		FrmtWarnMyprice	= "Gebruik mijn huidige prijs";
		FrmtWarnNocomp	= "Geen concurrentie";
		FrmtWarnNodata	= "Geen gegevens voor HVP";
		FrmtWarnToolow	= "Kan de laagste prijs niet matchen";
		FrmtWarnUndercut	= "Onderbieden met %s%%";
		FrmtWarnUser	= "Gebruik gebruikersprijs";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Al hoogste bieder op veiling: %s (x%d)";
		FrmtBidAuction	= "Geboden op veiling: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Error: ongesynchroniseerde bod rij";
		FrmtBoughtAuction	= "Veiling opgekocht: %s (x%d)";
		FrmtMaxBidsReached	= "Meer veilingen van %s (x%d) gevonden, maar bodlimiet bereikt (%d)";
		FrmtNoAuctionsFound	= "Geen veilingen gevonden: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "Geen verdere veilingen gevonden: %s (x%d)";
		FrmtNotEnoughMoney	= "Niet genoeg geld om te bieden op veiling: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Veiling met hoger bod overgeslagen: %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Veiling met lager bod overgeslagen: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Bieden op eigen veiling overgeslagen: %s (x%d)";
		UiProcessingBidRequests	= "Bezig biedingen te verwerken...";


		-- Section: Command Messages
		FrmtActClearall	= "Alle veiling-gegevens voor %s verwijderd";
		FrmtActClearFail	= "Kan item niet vinden: %s";
		FrmtActClearOk	= "Veiling-gegevens voor item verwijderd: %s";
		FrmtActClearsnap	= "Bezig huidige AH momentopname te wissen";
		FrmtActDefault	= "Auctioneers %s optie is hersteld naar zijn standaardwaarde";
		FrmtActDefaultall	= "Alle Auctioneer opties zijn hersteld naar de standaardwaarden";
		FrmtActDisable	= "Verberg item's %s gegevens";
		FrmtActEnable	= "Toon item's %s gegevens";
		FrmtActSet	= "%s op %s gezet";
		FrmtActUnknown	= "Onbekend commando of sleutelwoord: '%s'";
		FrmtAuctionDuration	= "Standaard veilingduur gezet op: %s";
		FrmtAutostart	= "Automatisch veiling gemaakt voor %s: %s minimum, %s buyout (%d uur) %s";
		FrmtFinish	= "Nadat een scan is afgelopen, zullen we %s";
		FrmtPrintin	= "Auctioneers berichten worden nu naar het \"%s\" chat frame geprint";
		FrmtProtectWindow	= "AH-venster bescherming gezet op: %s";
		FrmtUnknownArg	= "'%s' is geen geldig argument voor '%s'";
		FrmtUnknownLocale	= "De opgegeven taal ('%s') is onbekend. Geldige talen zijn:";
		FrmtUnknownRf	= "Ongeldige parameter ('%s'). De parameter moet zo geformatteerd zijn: [realm]-[faction]. Bijvoorbeeld: Al'Akir-Horde";


		-- Section: Command Options
		OptBidbroker	= "<opbrengst in zilver>";
		OptBidLimit	= "<nummer>";
		OptBroker	= "<opbrengst in zilver>";
		OptCompete	= "<verschil in zilver>";
		OptLocale	= "<taal>";
		OptPctBidmarkdown	= "<procent>";
		OptPctMarkup	= "<procent>";
		OptPctMaxless	= "<procent>";
		OptPctNocomp	= "<procent>";
		OptPctUnderlow	= "<procent>";
		OptPctUndermkt	= "<procent>";
		OptPercentless	= "<procent>";
		OptPrintin	= "(<frameIndex>[Nummer]|<frameNaam>[Tekst])";
		OptScale	= "<schaalfactor>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAskPriceWhispers	= "fluister";
		CmdAskPriceWord	= "woord";
		CmdFinishSound	= "einde geluid";


		-- Section: Config Text
		GuiAlso	= "Toon ook gegevens voor";
		GuiAlsoDisplay	= "Gegevens voor %s worden getoond";
		GuiAlsoOff	= "Andere realm-faction gegevens worden niet meer getoond.";
		GuiAlsoOpposite	= "Gegevens voor tegengestelde faction worden nu ook getoond.";
		GuiAskPrice	= "Gebruik AskPrice";
		GuiAskPriceAd	= "Stuur nieuwe features";
		GuiAskPriceGuild	= "Reageer op guildchat vragen";
		GuiAskPriceHeader	= "AskPrice opties";
		GuiAskPriceHeaderHelp	= "Verander AskPrice's gedrag";
		GuiAskPriceParty	= "Reageer op partychat vragen";
		GuiAskPriceSmart	= "Gebruik smartwords";
		GuiAskPriceTrigger	= "VraagPrijs trigger";
		GuiAskPriceVendor	= "Verstuur verkoper info";
		GuiAskPriceWhispers	= "Toon uitgaande priv\195\169berichten";
		GuiAskPriceWord	= "Custom SmartWord %d";
		GuiAuctionDuration	= "Standaard veiling duur";
		GuiAuctionHouseHeader	= "Veiling venster";
		GuiAuctionHouseHeaderHelp	= "Verander de standaard instellingen van het veiling venster";
		GuiAutofill	= "Vul prijzen in de AH automatisch aan";
		GuiAverages	= "Toon gemiddelden";
		GuiBidmarkdown	= "Bod verlaag percentage";
		GuiClearall	= "Verwijder alle auctioneer data";
		GuiClearallButton	= "Verwijder alles";
		GuiClearallHelp	= "Klik hier om alle auctioneer data voor de huidige realm te verwijderen";
		GuiClearallNote	= "voor de huidige server-factie";
		GuiClearHeader	= "Verwijder data";
		GuiClearHelp	= "Verwijdert auctioneer data. Selecteer alle data of de laatste scan. WAARSCHUWING: Deze acties zijn onomkeerbaar";
		GuiClearsnap	= "Verwijder scan data";
		GuiClearsnapButton	= "Verwijder scan";
		GuiClearsnapHelp	= "Klik hier om de data van de laatste scan te verwijderen";
		GuiDefaultAll	= "Herstel alle auctioneer opties";
		GuiDefaultAllButton	= "Herstel alles";
		GuiDefaultAllHelp	= "Klik hier om alle auctioneer opties te herstellen naar de originele waarden. WAARSCHUWING: Deze actie is onomkeerbaar.";
		GuiDefaultOption	= "Herstel deze instelling";
		GuiEmbed	= "Intergreer info in de in-game tooltip";
		GuiEmbedBlankline	= "Toon een lege regel in de in-game tooltip";
		GuiEmbedHeader	= "Intergreer";
		GuiFinish	= "Nadat een scan is voltooid";
		GuiFinishSound	= "Speel geluid na het voltooien van een scan";
		GuiLink	= "Toon linkID";
		GuiLoad	= "Laad Auctioneer";
		GuiLoad_Always	= "altijd";
		GuiLoad_AuctionHouse	= "bij het veilinghuis";
		GuiLoad_Never	= "nooit";
		GuiLocale	= "Stel de localisering in op";
		GuiMainEnable	= "Gebruik Auctioneer";
		GuiMainHelp	= "Bevat instellingen voor auctioneer, een AddOn die item info toont en auctionhouse data analiseert. Klik de 'scan' knop bij de auctionhouse om veiling gegevens te verzamelen";
		GuiMarkup	= "Verkoper prijs ophoog percentage";
		GuiMaxless	= "Max markt onderbod percentage";
		GuiMedian	= "Toon gemiddelden";
		GuiNocomp	= "Onderbod percentage zonder concurentie";
		GuiNoWorldMap	= "Auctioneer: Tonen van de wereldkaart onderdrukt";
		GuiOtherHeader	= "Andere opties";
		GuiOtherHelp	= "Andere auctioneer opties";
		GuiPercentsHeader	= "Auctioneer grens percentages";
		GuiPercentsHelp	= "WAARSCHUWING: De volgende instellingen zijn ALLEEN voor ervaren gebruikers. Pas de volgende waarden aan om te veranderen hoe aggressief auctioneer is bij het bepalen van winstgevende waarden";
		GuiPrintin	= "Selecteer het gewenste berichtscherm";
		GuiProtectWindow	= "Voorkom per ongeluk sluiten van het AH venster";
		GuiRedo	= "Toon langdurige scan waarschuwing";
		GuiReloadui	= "Herlaad gebruikers interface";
		GuiReloaduiButton	= "ReloadUI";
		GuiReloaduiFeedback	= "Nu de WoW UI aan het herladen";
		GuiReloaduiHelp	= "Klik hier om de WOW Gebruikers interface te herladen na het aanpassen van de localisatie zodat de taal in dit configuratiescherm gelijk wordt aan de gekozen taal. Let op: Dit kan enkele minuten duren.";
		GuiRememberText	= "Onthoud prijs";
		GuiStatsEnable	= "Toon statistieken";
		GuiStatsHeader	= "Item prijs statistieken";
		GuiStatsHelp	= "Toon de volgende statistieken in de tooltip";
		GuiSuggest	= "Toon geadviseerde prijs";
		GuiUnderlow	= "Laagste veiling onderbod";
		GuiUndermkt	= "Onderbied de maxloze markt";
		GuiVerbose	= "Verbose modus";
		GuiWarnColor	= "Kleur prijzenmodel";


		-- Section: Conversion Messages
		MesgConvert	= "Auctioneer Database Conversie. Backup uw SavedVariables\\Auctioneer.lua eerst. %s%s";
		MesgConvertNo	= "Uitschakelen van Auctioneer";
		MesgConvertYes	= "Converteer";
		MesgNotconverting	= "Auctioneer converteert uw database niet. Het zal dan ook niet functioneren totdat u dit wel doet.";


		-- Section: Game Constants
		TimeLong	= "Lang";
		TimeMed	= "Gemiddeld";
		TimeShort	= "Kort";
		TimeVlong	= "Zeer Lang";


		-- Section: Generic Messages
		DisableMsg	= "Automatisch laden van Auctioneer uitgeschakeld";
		FrmtWelcome	= "Auctioneer v%s geladen";
		MesgNotLoaded	= "Auctioneer is niet geladen. Type /auctioneer voor meer info.";
		StatAskPriceOff	= "AskPrice is nu uitgeschakeld.";
		StatAskPriceOn	= "AskPrice is nu ingeschakeld.";
		StatOff	= "Veiling-gegevens worden niet weergegeven";
		StatOn	= "Ingestelde veiling-gegevens worden getoond";


		-- Section: Generic Strings
		TextAuction	= "veiling";
		TextCombat	= "Gevecht";
		TextGeneral	= "Algemeen";
		TextNone	= "geen";
		TextScan	= "Scan";
		TextUsage	= "Gebruik:";


		-- Section: Help Text
		HelpAlso	= "Toon ook gegevens van een andere server in de tooltip. Vul bij 'realm' de realmnaam in en bij 'faction' de naam van de faction. Bijvoorbeeld: \"/auctioneer also Al'Akir-Horde\". Het speciale sleutelwoord \"opposite\" betekent de andere faction, \"off\" schakelt de functionalitiet uit.";
		HelpAskPrice	= "Zet AskPrice aan of uit.";
		HelpAskPriceAd	= "Zet de nieuwe reclame-feature van AskPrice aan of uit.";
		HelpAskPriceGuild	= "Reageer op vragen in de guildchat.";
		HelpAskPriceParty	= "Reageer op vragen in de partychat.";
		HelpAskPriceSmart	= "Zet SmartWords controle aan of uit.";
		HelpAskPriceTrigger	= "Verander het trigger-karakter van AskPrice.";
		HelpAskPriceVendor	= "Zet het verzenden van verkoper gegevens aan of uit.";
		HelpAskPriceWhispers	= "Zet het verbergen van alle AskPrice uitgaande priv\195\169berichten aan of uit.";
		HelpAskPriceWord	= "Voeg persoonlijke AskPrice SmartWords toe of modificeer ze.";
		HelpAuctionClick	= "Stelt je in staat automatisch een veiling te beginnen voor een item in je inventaris door Alt-Klik.";
		HelpAuctionDuration	= "Stel de standaard veilingduur in met het openen van het AH venster";
		HelpAutofill	= "Stel in of prijzen automatisch ingevuld moeten worden wanneer er een item op de AH wordt gezet.";
		HelpAverage	= "Selecteer of de gemiddelde veilingprijs van items getoond moet worden";
		HelpBidbroker	= "Toon kort of gemiddeld durende veilingen van de recente scan waar met een bod winst mogelijk is.";
		HelpBidLimit	= "Maximum aantal veilingen om op te bieden of op te kopen wanneer de bod- of opkoopknop is geklikt in het Zoek Veilingen tabblad.";
		HelpBroker	= "Toon veilingen van de recentste scan waar op geboden kan worden om door te verkopen met winst.";
		HelpClear	= "Wis de data voor het aangegeven item (voeg de items in het commando met shift-klik). Je kunt ook de speciale sleutelwoorden \"all\" of \"snapshot\" aangeven.";
		HelpCompete	= "Toon alle recent gescande veilingen waarvan de opkoopprijs minder is dan die van een van jouw items.";
		HelpDefault	= "Zet een Auctioneer-optie op zijn standaardwaarde. Je kunt ook het speciale keyword \"all\" gebruiken om alle Auctioneer-opties op hun standaardwaarde te zetten.";
		HelpDisable	= "Stopt het automatisch laden van Auctioneer de volgende keer dat je inlogt.";
		HelpEmbed	= "Integreer de tekst in het originele spel tooltip (NB.: Bepaalde features worden uitgezet wanneer dit geselecteerd is)";
		HelpEmbedBlank	= "Selecteer of een lege regel getoond moet worden tussen de tooltip info en de auction info als embedded mode aan staat.";
		HelpFinish	= "Geef aan of World of Warcraft automatich moet afsluiten als het Scannen van het veilinghuis compleet is.";
		HelpFinishSound	= "Zet het spelen van een geluid aan aan het einde van een Auction House scan.";
		HelpLink	= "Selecteer of het link id in de tooltip getoond moet worden";
		HelpLoad	= "Verander Auctioneer's laad settings voor dit karakter.";
		HelpLocale	= "Verander de taal die gebruikt wordt om Auctioneer berichten te tonen.";
		HelpMedian	= "Selecteer dat de median buyout prijs van het item wordt getoond.";
		HelpOnoff	= "Zet het tonen van veilinggegevens aan en uit.";
		HelpPctBidmarkdown	= "Zet het percentage waarmee Auctioneer de bid-prijs onder de buyout prijs noteert.";
		HelpPctMarkup	= "Het percentage waarmee vendor prijzen hoger genoteerd worden wanneer geen andere waarden beschikbaar zijn";
		HelpPctMaxless	= "Legt percentage vast tot waar Auctioneer de markt prijs blijft onderbieden voordat het opgeeft";
		HelpPctNocomp	= "Het percentage waarmee Auctioneer onder de marktprijs bied als er geen concurentie is";
		HelpPctUnderlow	= "Legt het percentage vast waarmee Auctioneer onder de laagste auction prijs bied";
		HelpPctUndermkt	= "Percentage waarmee de marktprijs onderboden wordt wanneer de prijs van de concurentie niet meer onderboden kan worden (vanwege maxless)\n";
		HelpPercentless	= "Toon alle recent gescande veilingen waarvan de opkoopprijs een bepaald percentage minder is dan de maximale verkoopprijs.";
		HelpPrintin	= "Selecteer in welk frame Auctioneer zijn berichten toont. Je kunt of de naam van het frame of de index aangeven.";
		HelpProtectWindow	= "Voorkom dat je perongeluk het veilinghuis interface sluit";
		HelpRedo	= "Selecteer of je een waarschuwing wilt krijgen als de te scennen pagina van het veilinghuis er te lang over doet door een server probleem (Server Lag)";
		HelpScan	= "Doe een Veilinghuis scan bij het eerstvolgende bezoek aan het veilinghuis, of gelijk als je er al bent (er is ook een knop in het veilinghuis paneel) Kies welke catagorieen je wild scannen met de checkboxen (naast de catagorieen)";
		HelpStats	= "Selecteer of je het bod of opkoop percentage van items wilt zien.";
		HelpSuggest	= "Selecteer of je de adviesprijs wilt zien.";
		HelpUpdatePrice	= "Past automatisch de startprijs aan van een veiling in de \"plaats veiling tab\" als de opkoop prijs verandert";
		HelpVerbose	= "Selecteerd of gemiddelden en suggesties voledig getoond moeten worden (of off om ze op een enkele regel te tonen).\n";
		HelpWarnColor	= "Selecteer of het huidige AH prijs model (b.v. Undercutting by...) getoond moet worden in intuitieve kleuren.\n";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Geen lege ruimte gevonden om veiling te starten!";
		FrmtNotEnoughOfItem	= "Niet genoeg %s gevonden om veiling te starten!";
		FrmtPostedAuction	= "1 Veiling van %s (x%d) geplaatst";
		FrmtPostedAuctions	= "%d veilingen van %s (x%d) geplaatst";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "HuidigBod";
		FrmtBidbrokerDone	= "Bod bepalen voltooid";
		FrmtBidbrokerHeader	= "Minimum winst: %s, HVP ='Hoogst Verkoopbare Prijs'";
		FrmtBidbrokerLine	= "%s, Laatst %s gezien, HVP: %s, %s, Winst: %s, Tijd: %s";
		FrmtBidbrokerMinbid	= "MinBod";
		FrmtBrokerDone	= "Prijsbepaling voltooid";
		FrmtBrokerHeader	= "Minimale winst: %s, HVP ='Hoogst Verkoopbare Prijs'";
		FrmtBrokerLine	= "%s, Laatst %s gezien, HVP: %s, BO: %s, Winst: %s";
		FrmtCompeteDone	= "Concurerende veilingen voltooid";
		FrmtCompeteHeader	= "Concurerende veilingen ten minste %s minder per item";
		FrmtCompeteLine	= "%s, Bod: %s, BO %s vs %s, %s minder";
		FrmtHspLine	= "Hoogst Verkoopbare Prijs voor 1 %s is: %s";
		FrmtLowLine	= "%s, BO: %s, Verkopen: %s, Voor 1: %s, Minder dan gemiddeld: %s";
		FrmtMedianLine	= "Van de laatste %d gezien, gemiddelde BO voor 1 %s is: %s";
		FrmtNoauct	= "Geen veilingen gevonden voor item: %s";
		FrmtPctlessDone	= "Procenten minder voltooid";
		FrmtPctlessHeader	= "Procent minder dan Hoogst verkoopbare prijs (HVP): %d%%";
		FrmtPctlessLine	= "%s, Laatste %d gezien, HVP: %s, BO: %s, Winst: %s, Minder: %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Niet meer bestaande veilingen verwijderd: %s";
		AuctionDiscrepancies	= "Discrepanties: %s";
		AuctionNewAucts	= "Nieuwe veilingen gescand: %s";
		AuctionOldAucts	= "Eerder gescand: %s";
		AuctionPageN	= "Auctioneer: scannen van %s pagina %d van %d Veilingen per seconde: %s Verwachte tijdsduur: %s";
		AuctionScanDone	= "Auctioneer: veiling scan klaar";
		AuctionScanNexttime	= "Auctioneer zal een volledige scan uitvoeren de volgende keer dat gepraat wordt met een veilingmeester.";
		AuctionScanNocat	= "U moet tenminste \195\169\195\169n categorie hebben geselecteerd om te kunnen scannen.";
		AuctionScanRedo	= "Huidige pagina deed er meer dan %d secondes over om te laden, nieuwe poging.";
		AuctionScanStart	= "Auctioneer: scannen %s pagina 1...";
		AuctionTotalAucts	= "Totaal aantal veilingen gescand: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "%d keer gezien voor %s";
		FrmtInfoAverage	= "%s min/%s BO (%s bod)";
		FrmtInfoBidMulti	= "Boden (%s%s ea)";
		FrmtInfoBidOne	= "Boden%s";
		FrmtInfoBidrate	= "%d%% hebben een bod, %d%% hebben BO";
		FrmtInfoBuymedian	= "BO gemiddelde";
		FrmtInfoBuyMulti	= "Buyout (%s%s ea)";
		FrmtInfoBuyOne	= "Buyout%s";
		FrmtInfoForone	= "Voor 1: %s min/%s BO (%s geboden) [in %d's]";
		FrmtInfoHeadMulti	= "Gemiddelden voor %d items:";
		FrmtInfoHeadOne	= "Gemiddelden voor dit item";
		FrmtInfoHistmed	= "Laatste %d, gemiddelde BO (ea)";
		FrmtInfoMinMulti	= "Begin bod (%s ea)";
		FrmtInfoMinOne	= "Begin bod";
		FrmtInfoNever	= "Nooit gezien in %s";
		FrmtInfoSeen	= "Totaal %d keer gezien bij de AH";
		FrmtInfoSgst	= "Geadviseerde prijs: %s min/%s BO";
		FrmtInfoSgststx	= "Geadviseerde prijs voor jouw %d stack: %s min/%s BO";
		FrmtInfoSnapmed	= "%d gescanned, gemiddelde BO (ea)";
		FrmtInfoStacksize	= "Gemiddelde stack grootte: %d items";


		-- Section: User Interface
		FrmtLastSoldOn	= "Laatst Verkocht op %s";
		UiBid	= "Bod";
		UiBidHeader	= "Bod";
		UiBidPerHeader	= "Bod Per";
		UiBuyout	= "Opkoop";
		UiBuyoutHeader	= "Opkoop";
		UiBuyoutPerHeader	= "Opkoop Per";
		UiBuyoutPriceLabel	= "Opkoopprijs:";
		UiBuyoutPriceTooLowError	= "(Te laag)";
		UiCategoryLabel	= "Categorie beperking:";
		UiDepositLabel	= "Storting:";
		UiDurationLabel	= "Duur:";
		UiItemLevelHeader	= "Lvl";
		UiMakeFixedPriceLabel	= "Maak vaste prijs";
		UiMaxError	= "(%d Max)";
		UiMaximumPriceLabel	= "Maximum Prijs:";
		UiMaximumTimeLeftLabel	= "Maximale Tijd Over:";
		UiMinimumPercentLessLabel	= "Laagste Verschil Percentage:";
		UiMinimumProfitLabel	= "Minimale Opbrengst:";
		UiMinimumQualityLabel	= "Minimum Kwaliteit:";
		UiMinimumUndercutLabel	= "Minimum Onderbieding:";
		UiNameHeader	= "Naam";
		UiNoPendingBids	= "Alle bodverzoeken compleet!";
		UiNotEnoughError	= "(Niet genoeg)";
		UiPendingBidInProgress	= "1 bodverzoek in behandeling...";
		UiPendingBidsInProgress	= "%d bodverzoeken in behandeling...";
		UiPercentLessHeader	= "Pct";
		UiPost	= "Plaats";
		UiPostAuctions	= "Plaats Veiling";
		UiPriceBasedOnLabel	= "Prijs Gebaseerd Op:";
		UiPriceModelAuctioneer	= "Auctioneer Prijs";
		UiPriceModelCustom	= "Eigen Prijs";
		UiPriceModelFixed	= "Vaste Prijs";
		UiPriceModelLastSold	= "Laatste verkoopprijs";
		UiProfitHeader	= "Winst";
		UiProfitPerHeader	= "Winst Per";
		UiQuantityHeader	= "Hoev.";
		UiQuantityLabel	= "Hoeveelheid:";
		UiRemoveSearchButton	= "Verwijder";
		UiSavedSearchLabel	= "Bewaarde zoekopdrachten:";
		UiSaveSearchButton	= "Bewaar";
		UiSaveSearchLabel	= "Bewaar deze zoekopdracht:";
		UiSearch	= "Zoek";
		UiSearchAuctions	= "Zoek Veilingen";
		UiSearchDropDownLabel	= "Zoek:";
		UiSearchForLabel	= "Zoek Naar Item:";
		UiSearchTypeBids	= "Biedingen";
		UiSearchTypeBuyouts	= "Opkopingen";
		UiSearchTypeCompetition	= "Concurrentie";
		UiSearchTypePlain	= "Item";
		UiStacksLabel	= "Stapels";
		UiStackTooBigError	= "(Stapel Te Groot)";
		UiStackTooSmallError	= "(Stapel Te Klein)";
		UiStartingPriceLabel	= "Start Prijs:";
		UiStartingPriceRequiredError	= "(Benodigd)";
		UiTimeLeftHeader	= "Tijd over";
		UiUnknownError	= "(Onbekend)";

	};

	ptPT = {


		-- Section: AskPrice Messages
		AskPriceAd	= "Obtenha pre\195\167o da pilha com %sx[ItemLink] (x = stacksize) ";
		FrmtAskPriceBuyoutMedianHistorical	= "%sHist\195\179rico m\195\169dio das vendas: %s%s ";
		FrmtAskPriceBuyoutMedianSnapshot	= "%sHistorico medio do ultimo scan: %s%s ";
		FrmtAskPriceDisable	= "Desativar perguntar pre\195\167o";
		FrmtAskPriceEach	= "(%s cada)";
		FrmtAskPriceEnable	= "Activar perguntar pre\195\167o %s";
		FrmtAskPriceVendorPrice	= "%sVenda para fornecedor por: %s%s ";


		-- Section: Auction Messages
		FrmtActRemove	= "Removendo %s da image corrente da AH";
		FrmtAuctinfoHist	= "%s historial";
		FrmtAuctinfoLow	= "Pre\195\167o mais baixo";
		FrmtAuctinfoMktprice	= "Pre\195\167o de mercado";
		FrmtAuctinfoNolow	= "Objecto n\195\163o visto no \195\186ltimo leil\195\163o";
		FrmtAuctinfoOrig	= "Oferta original";
		FrmtAuctinfoSnap	= "%d do \195\186ltimo scan";
		FrmtAuctinfoSugbid	= "Oferta inicial";
		FrmtAuctinfoSugbuy	= "Pre\195\167o de saida proposto";
		FrmtWarnAbovemkt	= "Pre\195\167o acima do mercado";
		FrmtWarnMarkup	= "Colocando pre\195\167o %s%% acima do vendedor";
		FrmtWarnMyprice	= "Usando pre\195\167o actual";
		FrmtWarnNocomp	= "Sem competi\195\167\195\163o";
		FrmtWarnNodata	= "Sem informa\195\167\195\163oo para pre\195\167o mais alto";
		FrmtWarnToolow	= "Impossivel igualar pre\195\167o minimo";
		FrmtWarnUndercut	= "Baixando o pre\195\167o em %s%%";
		FrmtWarnUser	= "Usando o seu pre\195\167o actual";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "Esse bid \195\169 teu: %s (x%d) ";
		FrmtBidAuction	= "Bid no leil\195\163o: %s (x%d)";
		FrmtBidQueueOutOfSync	= "Error: Bid queue out of sync!\nErro: Fila de ofertas fora de sincronia!";
		FrmtBoughtAuction	= "Leil\195\163o comprado: %s (x%d)";
		FrmtMaxBidsReached	= "Mais auctions de %s (x%d)encontrado, mas ofere\195\167a o limite alcan\195\167ado (%d)";
		FrmtNoAuctionsFound	= "Nenhum leil\195\163o encontrado: %s (x%d)";
		FrmtNoMoreAuctionsFound	= "N\195\163o mais auctions encontrados: %s (x%d)";
		FrmtNotEnoughMoney	= "N\195\163o bastante dinheiro a oferecer no auction: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "Auction saltado com oferta mais elevada:  %s (x%d)";
		FrmtSkippedAuctionWithLowerBid	= "Auction saltado com oferta mais elevada: %s (x%d)";
		FrmtSkippedBiddingOnOwnAuction	= "Oferecer saltado em pr\195\179prio auction: %s (x%d)";
		UiProcessingBidRequests	= "Processando pedidos oferecidos...";


		-- Section: Command Messages
		FrmtActClearall	= "Removendo todos dados para o leil\195\131\194\163o %s";
		FrmtActClearFail	= "Impossivel encontrar o objeto: %s";
		FrmtActClearOk	= "Removida a informa\195\131\194\167\195\131\194\163o para o objecto %s";
		FrmtActClearsnap	= "Removendo a informa\195\131\194\167\195\131\194\163o actual da casa de leil\195\131\194\181es";
		FrmtActDefault	= "A op\195\131\194\167\195\131\194\163o %s do Auctioneer foi alterada para o modo original";
		FrmtActDefaultall	= "Todas as op\195\131\194\167\195\131\194\181es do Auctioneer foram alteradas para o modo original";
		FrmtActDisable	= "Ocultando informa\195\131\194\167\195\131\194\163o para %s";
		FrmtActEnable	= "Mostrando informa\195\131\194\167\195\131\194\163o para %s";
		FrmtActSet	= "%s alterado para '%s'";
		FrmtActUnknown	= "Comando ou palavra-chave desconhecida: '%s'";
		FrmtAuctionDuration	= "Tempo da ac\195\131\194\167\195\131\194\163o original mudado para: %s";
		FrmtAutostart	= "Mudando leil\195\131\194\163o autom\195\131\194\161tico para %s minimo, %s pre\195\131\194\167o de sa\195\131\194\173da (%dh)\n%s";
		FrmtFinish	= "Depois de uma pesquisa terminar, n\195\179s faremos %s";
		FrmtPrintin	= "Mensagens do Auctioneer v\195\131\194\163o agora ser mostradas na janela de comunica\195\131\194\167\195\131\194\163o \"%s\"";
		FrmtProtectWindow	= "Protec\195\131\194\167\195\131\194\163o da janela de leil\195\131\194\181es mudada para: %s";
		FrmtUnknownArg	= "'%s' n\195\131\194\163o \195\131\194\169 um argumento valido para '%s'";
		FrmtUnknownLocale	= "A localiza\195\131\194\167\195\131\194\163o que especificou ('%s') \195\131\194\169 desconhecida. Localiza\195\131\194\167\195\131\194\181es v\195\131\194\161lidas s\195\131\194\163o:";
		FrmtUnknownRf	= "Parametro inv\195\131\194\161lido ('%s'). O parametro tem de estar na forma: [reino]-[fac\195\131\194\167\195\131\194\163o]. Por exemplo: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(reino-fac\195\131\194\167\195\131\194\163o|oposto)";
		OptAuctionDuration	= "(\195\186ltima||2h||8h||24h)";
		OptBidbroker	= "<proveito_prata>";
		OptBidLimit	= "<n\195\186mero>";
		OptBroker	= "<proveito_prata>";
		OptClear	= "([Item]|todo|imagem)";
		OptCompete	= "<prata_menos>";
		OptDefault	= "(<op\195\131\194\167\195\131\194\163o>|todo)";
		OptFinish	= "(desligar||sair||terminar)";
		OptLocale	= "<localidade>";
		OptPctBidmarkdown	= "<porcento>";
		OptPctMarkup	= "<porcento>";
		OptPctMaxless	= "<porcento>";
		OptPctNocomp	= "<porcento>";
		OptPctUnderlow	= "<porcento>";
		OptPctUndermkt	= "<porcento>";
		OptPercentless	= "<porcento>";
		OptPrintin	= "(<indiceJanela>[N\195\131\194\186mero]|<nomeJanela>[Serie])";
		OptProtectWindow	= "(nunca||pesquisa||sempre)";
		OptScale	= "<factor_escala>";
		OptScan	= "par\195\162metro de pesquisa";


		-- Section: Commands
		CmdAlso	= "tamb\195\131\194\169m";
		CmdAlsoOpposite	= "oposto";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "ad";
		CmdAskPriceGuild	= "guild ";
		CmdAskPriceParty	= "party";
		CmdAskPriceSmart	= "esperto";
		CmdAskPriceSmartWord1	= "que";
		CmdAskPriceSmartWord2	= "valor";
		CmdAskPriceTrigger	= "disparador";
		CmdAskPriceVendor	= "vendor";
		CmdAskPriceWhispers	= "suspiros";
		CmdAskPriceWord	= "palavra";
		CmdAuctionClick	= "click-leil\195\131\194\163o";
		CmdAuctionDuration	= "dura\195\131\194\167\195\131\194\163o-leil\195\131\194\163o";
		CmdAuctionDuration0	= "\195\186ltimo";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "autoinserir";
		CmdBidbroker	= "corretor-ofertas";
		CmdBidbrokerShort	= "co";
		CmdBidLimit	= "ofere\195\167-limite";
		CmdBroker	= "corretor";
		CmdClear	= "limpar";
		CmdClearAll	= "tudo";
		CmdClearSnapshot	= "imagem";
		CmdCompete	= "competir";
		CmdCtrl	= "ctrl";
		CmdDefault	= "iriginal";
		CmdDisable	= "desligar";
		CmdEmbed	= "integrado";
		CmdFinish	= "finish";
		CmdFinish0	= "off";
		CmdFinish1	= "logout";
		CmdFinish2	= "exit";
		CmdFinish3	= "reloadui";
		CmdFinishSound	= "som final";
		CmdHelp	= "ajuda";
		CmdLocale	= "localiza\195\131\194\167\195\131\194\163o";
		CmdOff	= "desligado";
		CmdOn	= "ligado";
		CmdPctBidmarkdown	= "pct-menosoferta";
		CmdPctMarkup	= "pct-mais";
		CmdPctMaxless	= "pct-semmaximo";
		CmdPctNocomp	= "pct-semcomp";
		CmdPctUnderlow	= "pct-abaixomenor";
		CmdPctUndermkt	= "pct-abaixomercado";
		CmdPercentless	= "sempercentagem";
		CmdPercentlessShort	= "sp";
		CmdPrintin	= "imprimir-em";
		CmdProtectWindow	= "proteger-janela";
		CmdProtectWindow0	= "nunca";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "sempre";
		CmdScan	= "scan";
		CmdShift	= "shift";
		CmdToggle	= "mudar";
		CmdUpdatePrice	= "update-pre\195\167o ";
		CmdWarnColor	= "aviso-cor";
		ShowAverage	= "ver-media";
		ShowEmbedBlank	= "ver-integrado-linhavazia";
		ShowLink	= "ver-link";
		ShowMedian	= "ver-mediano";
		ShowRedo	= "ver-aviso";
		ShowStats	= "ver-estatisticas";
		ShowSuggest	= "ver-sugerido";
		ShowVerbose	= "ver-detalhe";


		-- Section: Config Text
		GuiAlso	= "Tamb\195\169m mostrar informa\195\167\195\163o para";
		GuiAlsoDisplay	= "Mostrando informa\195\167\195\163o para %s";
		GuiAlsoOff	= "N\195\131\194\163o mostrando informa\195\167\195\163o de outro reino-fac\195\167\195\163o";
		GuiAlsoOpposite	= "Mostrando informa\195\167\195\163o da fac\195\167\195\163o oposta";
		GuiAskPrice	= "Permita AskPrice";
		GuiAskPriceAd	= "Emita caracter\195\173sticas ad";
		GuiAskPriceGuild	= "Responda \195\160s perguntas do guildchat";
		GuiAskPriceHeader	= "Op\195\167\195\181es De AskPrice";
		GuiAskPriceHeaderHelp	= "Mude o comportamento de AskPrice";
		GuiAskPriceParty	= "Responda \195\160s perguntas do partychat";
		GuiAskPriceSmart	= "Use smartwords";
		GuiAskPriceTrigger	= "Disparador de AskPrice";
		GuiAskPriceVendor	= "Emita o vendor info ";
		GuiAskPriceWhispers	= "Mostrar suspiros enviados";
		GuiAskPriceWord	= "SmartWord regular %d";
		GuiAuctionDuration	= "Dura\195\167\195\163o de leil\195\181es pre-definida";
		GuiAuctionHouseHeader	= "Janela da casa de leil\195\181es";
		GuiAuctionHouseHeaderHelp	= "Mudar o comportamento da janela da casa de leil\195\181es";
		GuiAutofill	= "Auto completar pre\195\167os na casa de leil\195\181es";
		GuiAverages	= "Mostrar medias";
		GuiBidmarkdown	= "Porcento menos oferta";
		GuiClearall	= "Eliminar toda a informa\195\167\195\163o do Auctioneer";
		GuiClearallButton	= "Eliminar tudo";
		GuiClearallHelp	= "Seleccione aqui para eliminar toda a informa\195\167\195\163o do Auctioneer para o reino-fac\195\167\195\163o actual.";
		GuiClearallNote	= "para o reino-fac\195\167\195\163o actual";
		GuiClearHeader	= "Eliminar informa\195\167\195\163o";
		GuiClearHelp	= "Elimina a informa\195\167\195\163o do Auctioneer. Selecione toda a informa\195\167\195\163o ou s\195\179 a imagem actual. AVISO: Esta altera\195\167\195\163o \195\169 irreversivel.";
		GuiClearsnap	= "Eliminar Imagem actual";
		GuiClearsnapButton	= "Eliminar Imagem";
		GuiClearsnapHelp	= "Pressione aqui para eliminar a ultima imagem de informa\195\167\195\163o do Auctioneer.";
		GuiDefaultAll	= "Reverter todas as op\195\167\195\181es";
		GuiDefaultAllButton	= "Reverter tudo";
		GuiDefaultAllHelp	= "Pressione aqui para reverter todas as op\195\167\195\181es do Auctioneer de volta ao inicial. AVISO: Estas ac\195\167\195\181es n\195\163o s\195\163o reversiveis.";
		GuiDefaultOption	= "Reverter esta op\195\167\195\163o";
		GuiEmbed	= "Integrar informa\195\167\195\163o na caixa de ajuda";
		GuiEmbedBlankline	= "Mostrar linha em branco na caixa de ajuda";
		GuiEmbedHeader	= "Integrar";
		GuiFinish	= "Depois da pesquisa acabar";
		GuiFinishSound	= "Tocar som quando acabar scan";
		GuiLink	= "Mostrar LinkID";
		GuiLoad	= "Carregar o Auctioneer";
		GuiLoad_Always	= "sempre";
		GuiLoad_AuctionHouse	= "na casa de leil\195\181es";
		GuiLoad_Never	= "nunca";
		GuiLocale	= "Ajustar localidade para";
		GuiMainEnable	= "Activar Auctioneer";
		GuiMainHelp	= "Cont\195\131\194\169m op\195\167\195\181es para o Auctioneer, um AddOn que mostra informa\195\167\195\163o acerca de items e analiza a casa de leil\195\181es. Pressione \"Scan\" na janela de leil\195\181es para receber a informa\195\167\195\163o dos leil\195\181es.";
		GuiMarkup	= "Percentagem sobre o vendedor";
		GuiMaxless	= "Percentagem m\195\161xima abaixo do mercado";
		GuiMedian	= "Mostrar Medianos";
		GuiNocomp	= "Percentagem sem competi\195\167\195\163o";
		GuiNoWorldMap	= "Auctioneer: suprimiu a mostra do mapa do mundo";
		GuiOtherHeader	= "Outras Op\195\167\195\181es";
		GuiOtherHelp	= "Op\195\167\195\181es diversas do Auctioneer";
		GuiPercentsHeader	= "Limites de Percentagem do Auctioneer";
		GuiPercentsHelp	= "AVISO: As seguintes op\195\167\195\181es s\195\163o apenas para utilizadores experientes. Ajuste os seguintes valores para mudar o qu\195\131\194\163o agressivo o Auctioneer vai ser quando decidindo valores proveitosos.";
		GuiPrintin	= "Seleccione a janela desejada";
		GuiProtectWindow	= "Prevenir o encerrar acidental da janela de leil\195\181es";
		GuiRedo	= "Mostrar advert\195\170ncia de scan longo";
		GuiReloadui	= "Recarregar interface de utilizador";
		GuiReloaduiButton	= "RecarregarUI";
		GuiReloaduiFeedback	= "Recarregando o interface do WoW";
		GuiReloaduiHelp	= "Pressione aqui para recarregar o interface de utilizador ap\195\179s mudar a localidade para que a linguagem neste ecr\195\163 de configura\195\167\195\163o coincida com a que voc\195\170 escolheu. Nota: Esta opera\195\167\195\163o pode durar alguns minutos.";
		GuiRememberText	= "Recordar pre\195\167o";
		GuiStatsEnable	= "Mostrar estat\195\173sticas";
		GuiStatsHeader	= "Estat\195\173stissa de pre\195\167o de itens";
		GuiStatsHelp	= "Mostrar as seguintes estat\195\173sticas na tooltip.";
		GuiSuggest	= "Mostrar pre\195\167os sugeridos";
		GuiUnderlow	= "Redu\195\167\195\163o de leil\195\163o mais baixa";
		GuiUndermkt	= "Abaixo de mercado quando sem m\195\161ximo";
		GuiVerbose	= "Modo detalhe";
		GuiWarnColor	= "Modelo de colora\195\167\195\163o dos pre\195\167os";


		-- Section: Conversion Messages
		MesgConvert	= "Conver\195\131\194\167\195\131\194\163o da informa\195\131\194\167\195\131\194\163o do Auctioneer. Por favor guarde uma c\195\131\194\179pia de SavedVariables\Auctioneer.lua primeiro. %s%s";
		MesgConvertNo	= "Desactivar Auctioneer";
		MesgConvertYes	= "Converter";
		MesgNotconverting	= "O Auctioneer n\195\131\194\163o est\195\131\194\161 a converter a sua base de dados, mas n\195\131\194\163o funcionar\195\131\194\161 at\195\131\194\169 que o fa\195\131\194\167a.";


		-- Section: Game Constants
		TimeLong	= "Longo";
		TimeMed	= "M\195\131\194\169dio";
		TimeShort	= "Curto";
		TimeVlong	= "Muito Longo";


		-- Section: Generic Messages
		DisableMsg	= "Desactivando o carregamento autom\195\131\194\161tico do Auctioneer";
		FrmtWelcome	= "Auctioneer v%s inicializado. Boas Compras.";
		MesgNotLoaded	= "O Auctioneer n\195\131\194\163o est\195\131\194\161 inicializado. Estreca /auctioneer para mais informa\195\131\194\167\195\131\194\163o.";
		StatAskPriceOff	= "AskPrice \195\169 incapacitado agora.";
		StatAskPriceOn	= "AskPrice \195\169 incapacitado agora.";
		StatOff	= "Ocultando informa\195\131\194\167\195\131\194\163o de leil\195\131\194\181es";
		StatOn	= "Mostrando informa\195\131\194\167\195\131\194\163o de leil\195\131\194\181es";


		-- Section: Generic Strings
		TextAuction	= "leil\195\131\194\163o";
		TextCombat	= "Combate";
		TextGeneral	= "Geral";
		TextNone	= "nenhum";
		TextScan	= "Scan";
		TextUsage	= "Utiliza\195\131\194\167\195\131\194\163o:";


		-- Section: Help Text
		HelpAlso	= "Mostrar tamb\195\169m valores de outros servidores na janela. Para o reino, insira o nome do reino e para fac\195\167\195\163o insira o nome da fac\195\167\195\163o. Por exemplo: \"/auctioneer also Al'Akir-Horde\". A palavra chave \"oposto\" significa a fac\195\167\195\163o oposta, \"off\" desliga a funcionalidade.";
		HelpAskPrice	= "Permita ou incapacite AskPrice.";
		HelpAskPriceAd	= "Permita ou incapacite caracter\195\173sticas novas de AskPrice ad.";
		HelpAskPriceGuild	= "Responda \195\160s perguntas feitas no bate-papo do guild.";
		HelpAskPriceParty	= "Responda \195\160s perguntas feitas no bate-papo do partido.";
		HelpAskPriceSmart	= "Permita ou incapacite verificar de SmartWords.";
		HelpAskPriceTrigger	= "Mude o car\195\161ter do disparador de AskPrice.";
		HelpAskPriceVendor	= "Permita ou incapacite a emiss\195\163o de dados fixando o pre\195\167o do vendor.";
		HelpAskPriceWhispers	= "Mostrar ou Esconder todos os suspiros de ida do AskPrice.";
		HelpAskPriceWord	= "Adicionar ou Modificar as SmartWords do AskPrice.";
		HelpAuctionClick	= "Permite fazer Alt-Click a um objecto nas suas malas para iniciar automaticamente um leil\195\163o desse objecto";
		HelpAuctionDuration	= "Selecciona a dura\195\167\195\163o padr\195\163o de leil\195\181es ao abrir a janela de leil\195\181es";
		HelpAutofill	= "Define se auto-completa pre\195\167os quando se coloca um novo leil\195\163o na janela de leil\195\181es";
		HelpAverage	= "Define se mostra o pre\195\167o m\195\169dio do produto em leil\195\163o";
		HelpBidbroker	= "Mostrar leil\195\163es de tempo curto ou m\195\169dio do recente scan que podem ser comprados para proveito";
		HelpBidLimit	= "N\195\186mero m\195\161ximo dos auctions a oferecer sobre ou do buyout quando a tecla da oferta ou do buyout for estalada na aba dos auctions da busca.";
		HelpBroker	= "Mostrar leil\195\131\194\181es do recente scan que podem ser comprados e depois re-leiloados para proveito";
		HelpClear	= "Eliminar a informa\195\167\195\163o do produto especificado (tem que premir Shift-Clique no(s) produto(s) para o colocar na caixa de texto) Tamb\195\169m pode espicificar as palavras-chave \"todo\" ou \"imagem\"";
		HelpCompete	= "Mostrar leil\195\181es recentes cujo pre\195\167o de sa\195\131\195\173da seja menor que um dos seus produtos.";
		HelpDefault	= "Reverter uma op\195\167\195\163o ao seu valor original. Voc\195\170 tambem pode usar a palavra-chave \"tudo\" para reverter todas as op\195\167\195\181es do Auctioneer ao seu valor inicial.";
		HelpDisable	= "Impede o Auctioneer de carregar automaticamente na proxima vez que entrar no jogo";
		HelpEmbed	= "Inserir o texto na caixa de ajuda original. (note: algumas capacidades s\195\163o desactivadas quando esta op\195\167\195\163o \195\169 seleccionada)";
		HelpEmbedBlank	= "Selecciona se mostra uma linha branca entre a janela de ajuda e a informa\195\167\195\163o de leil\195\163o quando o modo avan\195\167ado est\195\161 seleccionado";
		HelpFinish	= "Selecciona se sai ou se termina ap\195\179s o fim de uma pesquisa na casa de leil\195\181es";
		HelpFinishSound	= "Escolher se quer tocar um som no fim do scan da Casa de Leil\195\181es.";
		HelpLink	= "Seleccionar se mostra o LinkID na janela de ajuda";
		HelpLoad	= "Mudar as op\195\167\195\181es e carregamento para este personagem";
		HelpLocale	= "Alterar o local que \195\169usado para mostrar mensagens do Auctioneer";
		HelpMedian	= "Define se mostra a media do pre\195\167o de saida";
		HelpOnoff	= "Define se a informa\195\131\194\167\195\131\194\163o de leil\195\131\194\181es est\195\131\194\161 ligada ou desligada";
		HelpPctBidmarkdown	= "Define a percentagem que o Auctioneer vai marcar pre\195\131\194\167os abaixo do pre\195\131\194\167o de sa\195\131\194\173da";
		HelpPctMarkup	= "A percentagem que o pre\195\131\194\167o de vendedores vai ser inflaccionada quando n\195\131\194\163o existem outros valores disponiveis";
		HelpPctMaxless	= "Define a percentagem m\195\131\194\161xima que o Auctioneer vai reduzir em rela\195\131\194\167\195\131\194\163o ao pre\195\131\194\167o de mercado antes de desistir";
		HelpPctNocomp	= "A percentagem que o Auctioneer vai reduzir em rela\195\131\194\167\195\131\194\163o ao pre\195\131\194\167o de mercado quando n\195\131\194\163o existir compet\195\131\194\170ncia";
		HelpPctUnderlow	= "Define a percentagem qua o Auctioneer vai reduzir em rela\195\131\194\167\195\131\194\163o ao leil\195\131\194\163o mais baixo";
		HelpPctUndermkt	= "Percentagem a reduzir em rela\195\131\194\167\195\131\194\163o ao pre\195\131\194\167o de mercado quando for impossivel bater a compet\195\131\194\170ncia (devido ao semm\195\131\194\161ximo)";
		HelpPercentless	= "Mostra qualquer leil\195\131\194\163o scaneado recentemente cujo buyout apresenta porcentagem menor do que o mais alto pre\195\131\194\167o de venda";
		HelpPrintin	= "Seleciona qual janela ir\195\131\194\161 mostrar mensagens. Voc\195\131\194\170 pode tamb\195\131\194\169m especificar o nome da janela ou o t\195\131\194\173tulo.";
		HelpProtectWindow	= "Previne que voc\195\131\194\170 feche acidentalmente a janela";
		HelpRedo	= "Selecciona se mostra um aviso quando a pagina da AH actualmente a ser pesquisada demorou muito devido a lag no servidor.";
		HelpScan	= "Efectua uma pesquisa da casa de leil\195\131\194\181es na pr\195\179xima visita, ou enquanto voc\195\131\194\170 l\195\161 est\195\161 (h\195\161 tamb\195\131\194\169m um bot\195\131\194\163o na janela de leil\195\131\194\181es). Escolha que categorias quer pesquisar usando as chackboxes.";
		HelpStats	= "Selecionar se mostra as percentagens de licita\195\167\195\131\194\163o/sa\195\131\194\173ddd os itens.";
		HelpSuggest	= "Selecionar se mostra o pre\195\131\194\167o de licita\195\167\195\131\194\163o/sa\195\131\194\173ad dos itens";
		HelpUpdatePrice	= "Atualize automaticamente o pre\195\167o come\195\167ando para um auction na aba dos auctions do borne quando o pre\195\167o buyout muda.";
		HelpVerbose	= "Selecionar se mostra medias e sugest\195\131\194\181es (ou desligar para mostr\195\161-las numa linha \195\186nica)";
		HelpWarnColor	= "Selecione se mostrar o atual AH fixando o pre\195\167o do modelo (que undercutting por...) em cores intuitive.";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "Nenhum espa\195\167o vazio do bloco encontrou para criar o auction!";
		FrmtNotEnoughOfItem	= "N\195\163o bastantes %s encontrado para criar o auction! ";
		FrmtPostedAuction	= "Afixado 1 auction de %s (x%d)";
		FrmtPostedAuctions	= "Afixado %d auctions de %s (x%d) ";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "curOferta";
		FrmtBidbrokerDone	= "Brokering da oferta feito";
		FrmtBidbrokerHeader	= "Lucro m\195\173nimo: %s, HSP = 'Valor de venda mais elevado'";
		FrmtBidbrokerLine	= "%s, visto \195\186ltima vez, HSP: %s, %s: %s, Lucro: %s, Tempo: %s";
		FrmtBidbrokerMinbid	= "liciMin";
		FrmtBrokerDone	= "Corre\195\167\195\131\194\163o acabada";
		FrmtBrokerHeader	= "Lucro m\195\173nimo: %s, HSP = 'Valor de venda mais elevado'";
		FrmtBrokerLine	= "%s,\195\154ltimo %s visto, HSP: %s, BO: %s, lucro: %s";
		FrmtCompeteDone	= "Auctions competindo feitos.";
		FrmtCompeteHeader	= "Auctions competindo ao menos %s mais menos cada uns.";
		FrmtCompeteLine	= "%s, oferta: %s, BO %s vs %s, %s menos ";
		FrmtHspLine	= "O pre\195\167o o mais elevado de Sellable para um %s \195\169: %s";
		FrmtLowLine	= "%s, BO:  %s, seller:  %s, para um:  %s, menos do que o n\195\186mero m\195\169dio:  %s";
		FrmtMedianLine	= "De \195\186ltimo %d visto, BO mediano para 1 %s \195\169:  %s";
		FrmtNoauct	= "Nenhum auctions encontrou para o artigo:  %s";
		FrmtPctlessDone	= "Por cento feitos mais menos.";
		FrmtPctlessHeader	= "Pre\195\167o de Sellable dos por cento menos do que o mais altamente (HSP):  %d%%";
		FrmtPctlessLine	= "%s, \195\186ltimo %d visto, HSP:  %s, BO:  %s, prof:  %s, menos %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "Os auctions defunct removeram:  %s";
		AuctionDiscrepancies	= "Discrep\195\162ncias:  %s";
		AuctionNewAucts	= "Auctions novos feitos a varredura:  %s";
		AuctionOldAucts	= "Feito a varredura previamente:  %s";
		AuctionPageN	= "Auctioneer:  p\195\161gina %d da explora\195\167\195\163o %s de auctions de %d por o segundo:  tempo de %s estimado deixado:  %s";
		AuctionScanDone	= "Auctioneer:  a explora\195\167\195\163o do auction terminou";
		AuctionScanNexttime	= "Auctioneer ir\195\131\194\161 iniciar o full scan na proxima vez que voc\195\131\194\170 falar com o com o auctioneer.";
		AuctionScanNocat	= "Voc\195\170 deve ter ao menos uma categoria selecionada para fazer a varredura";
		AuctionScanRedo	= "A p\195\161gina atual f\195\170z exame de mais do que segundos de %d para terminar, retrying a p\195\161gina";
		AuctionScanStart	= "Auctioneer: Procurando %s p\195\131\194\161gina 1...";
		AuctionTotalAucts	= "Os auctions totais fizeram a varredura: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "Visto %d vezes em %s";
		FrmtInfoAverage	= "%s min/%s BO (%s oferecido)";
		FrmtInfoBidMulti	= "Ofertas (%s%s ea)";
		FrmtInfoBidOne	= "Com o valor %s";
		FrmtInfoBidrate	= "%d%% tem oferta, %d%% tem compra directa";
		FrmtInfoBuymedian	= "Compra Directa valor m\195\131\194\169dio";
		FrmtInfoBuyMulti	= "Compra Directa (%s%s)";
		FrmtInfoBuyOne	= "Compra Directa %s";
		FrmtInfoForone	= "Por 1: %s min/%s BO (%s oferta) [em %s]";
		FrmtInfoHeadMulti	= "Medias por %d unidades:";
		FrmtInfoHeadOne	= "M\195\131\194\169dias para esta unidade:";
		FrmtInfoHistmed	= "Ultima vez visto a %d, pre\195\131\194\167o m\195\131\194\169dio (ea)";
		FrmtInfoMinMulti	= "Oferta inicial (%s unidade)";
		FrmtInfoMinOne	= "Oferta inicial";
		FrmtInfoNever	= "Nunca visto na %s";
		FrmtInfoSeen	= "Visto %d vezes em leil\195\131\194\163o";
		FrmtInfoSgst	= "Pre\195\131\194\167o recomendado: %s min/%s BO";
		FrmtInfoSgststx	= "Pre\195\131\194\167o recomendado para os %d: %s min/%s BO";
		FrmtInfoSnapmed	= "Visto a %d, BO (ea)";
		FrmtInfoStacksize	= "Quantidade m\195\131\194\169dia: %d items";


		-- Section: User Interface
		FrmtLastSoldOn	= "Ultima Venda";
		UiBid	= "Oferta";
		UiBidHeader	= "Oferta";
		UiBidPerHeader	= "Oferta Por";
		UiBuyout	= "Compra Directa";
		UiBuyoutHeader	= "Compra Directa";
		UiBuyoutPerHeader	= "Compra Directa Por";
		UiBuyoutPriceLabel	= "Pre\195\167o de Compra Directa:";
		UiBuyoutPriceTooLowError	= "(Demasiado Baixo)";
		UiCategoryLabel	= "Limita\195\167\195\163o Da Categoria:";
		UiDepositLabel	= "Dep\195\179sito:";
		UiDurationLabel	= "Dura\195\167\195\163o:";
		UiItemLevelHeader	= "N\195\173vel";
		UiMakeFixedPriceLabel	= "Fazer pre\195\167o fixo";
		UiMaxError	= "(%d m\195\161ximo)";
		UiMaximumPriceLabel	= "Pre\195\167o M\195\161ximo:";
		UiMaximumTimeLeftLabel	= "Tempo M\195\161ximo Deixado:";
		UiMinimumPercentLessLabel	= "Menos Percentagem Minima:";
		UiMinimumProfitLabel	= "Lucro M\195\173nimo:";
		UiMinimumQualityLabel	= "Qualidade M\195\173nima:";
		UiMinimumUndercutLabel	= "O M\195\173nimo Cortado:";
		UiNameHeader	= "Nome";
		UiNoPendingBids	= "Todos os pedidos completos!";
		UiNotEnoughError	= "(N\195\163o Suficientes)";
		UiPendingBidInProgress	= "1 pedido oferecido em andamento... ";
		UiPendingBidsInProgress	= "%d a oferta pedida em progresso... ";
		UiPercentLessHeader	= "Pct";
		UiPost	= "Postado";
		UiPostAuctions	= "Leil\195\181es Postados";
		UiPriceBasedOnLabel	= "Pre\195\167o Baseado Sobre:";
		UiPriceModelAuctioneer	= "Pre\195\167o De Auctioneer";
		UiPriceModelCustom	= "Pre\195\167o Costume";
		UiPriceModelFixed	= "Pre\195\167o Fixo";
		UiPriceModelLastSold	= "Ultimo Pre\195\167o Vendido";
		UiProfitHeader	= "Lucro";
		UiProfitPerHeader	= "Lucro Por";
		UiQuantityHeader	= "Qtn";
		UiQuantityLabel	= "Quantidade:";
		UiRemoveSearchButton	= "Apagar";
		UiSavedSearchLabel	= "Salvar pesquisas:";
		UiSaveSearchButton	= "Salvar";
		UiSaveSearchLabel	= "Salvar esta Pesquisa:";
		UiSearch	= "Procurar";
		UiSearchAuctions	= "Procurar Leil\195\181es";
		UiSearchDropDownLabel	= "Procurar:";
		UiSearchForLabel	= "Procurar Pelo Item:";
		UiSearchTypeBids	= "Ofertas";
		UiSearchTypeBuyouts	= "Compras Directas";
		UiSearchTypeCompetition	= "Competi\195\167\195\163o";
		UiSearchTypePlain	= "Objecto";
		UiStacksLabel	= "Pacote";
		UiStackTooBigError	= "(Pacote Muito Grande)";
		UiStackTooSmallError	= "(Pacote Muito Pequeno)";
		UiStartingPriceLabel	= "Pre\195\167o Inicial:";
		UiStartingPriceRequiredError	= "(Requerido)";
		UiTimeLeftHeader	= "Tempo Restante";
		UiUnknownError	= "(Desconhecido)";

	};

	ruRU = {


		-- Section: AskPrice Messages
		AskPriceAd	= "\208\159\208\190\208\187\209\131\209\135\208\184\209\130\208\181 \209\134\208\181\208\189\209\139 \208\189\208\176 \208\186\209\131\209\135\209\131 \209\129 %sx[ItemLink] (x = \209\128\208\176\208\183\208\188\208\181\209\128 \208\186\209\131\209\135\208\184)";
		FrmtAskPriceBuyoutMedianHistorical	= "%s\209\129\209\128\208\181\208\180\208\189\208\184\208\185 \208\178\209\139\208\186\209\131\208\191 \208\183\208\176 \208\178\209\129\208\181 \208\178\209\128\208\181\208\188\209\143: %s%s\n";
		FrmtAskPriceBuyoutMedianSnapshot	= "%s\208\161\209\128\208\181\208\180\208\189\208\184\208\185 \208\178\209\139\208\186\209\131\208\191 \208\183\208\176 \208\191\208\190\209\129\208\187. \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\208\181: %s%s";
		FrmtAskPriceDisable	= "\208\146\209\139\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181 %s \208\190\208\191\209\134\208\184\208\184 AskPrice";
		FrmtAskPriceEach	= "(%s \208\186\208\176\208\182\208\180\208\190\208\181)\n";
		FrmtAskPriceEnable	= "\208\146\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181 %s \208\190\208\191\209\134\208\184\208\184 AskPrice\n";
		FrmtAskPriceVendorPrice	= "%s \208\159\209\128\208\190\208\180\208\176\208\182\208\176 \208\178 \208\188\208\176\208\179\208\176\208\183\208\184\208\189: %s%s\n";


		-- Section: Auction Messages
		FrmtActRemove	= "\208\161\209\130\208\184\209\128\208\176\208\181\208\188 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\142 \208\190\208\177 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181 %s \208\184\208\183 \209\130\208\181\208\186\209\131\209\137\208\181\208\179\208\190 \209\129\208\189\208\184\208\188\208\186\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178.";
		FrmtAuctinfoHist	= "%d \208\183\208\176 \208\178\209\129\208\181 \208\178\209\128\208\181\208\188\209\143";
		FrmtAuctinfoLow	= "\208\157\208\184\208\182\208\176\208\185\209\136\208\176\209\143 \208\178 \209\129\208\189\208\184\208\188\208\186\208\181";
		FrmtAuctinfoMktprice	= "\208\160\209\139\208\189\208\190\209\135\208\189\208\176\209\143 \209\134\208\181\208\189\208\176";
		FrmtAuctinfoNolow	= "\208\159\209\128\208\181\208\180\208\188\208\181\209\130 \208\189\208\181 \209\131\208\178\208\184\208\180\208\181\208\189 \208\178 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\181\208\188 \209\129\208\189\208\184\208\188\208\186\208\181.";
		FrmtAuctinfoOrig	= "\208\159\208\181\209\128\208\178\208\190\208\189\208\176\209\135\208\176\208\187\209\140\208\189\208\176\209\143 \209\129\209\130\208\176\208\178\208\186\208\176";
		FrmtAuctinfoSnap	= "%d \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\184\208\185 \209\129\208\186\208\176\208\189";
		FrmtAuctinfoSugbid	= "\208\157\208\176\209\135\208\176\208\187\209\140\208\189\208\176\209\143 \209\129\209\130\208\176\208\178\208\186\208\176";
		FrmtAuctinfoSugbuy	= "\208\160\208\181\208\186\208\190\208\188\208\181\208\189\208\180\209\131\208\181\208\188\208\176\209\143 \209\134\208\181\208\189\208\176 \208\178\209\139\208\186\209\131\208\191\208\176";
		FrmtWarnAbovemkt	= "\208\154\208\190\208\189\208\186\209\131\209\128\208\181\208\189\209\134\208\184\209\143 \209\129 \209\128\209\139\208\189\208\186\208\190\208\188";
		FrmtWarnMarkup	= "\208\163\208\178\208\181\208\187\208\184\209\135\208\181\208\189\208\184\208\181 \209\134\208\181\208\189\209\139 \208\178\208\181\208\189\208\180\208\190\209\128\208\176 \208\189\208\176 %s%%";
		FrmtWarnMyprice	= "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\208\181 \208\188\208\190\208\181\208\185 \209\130\208\181\208\186\209\131\209\137\208\181\208\185 \209\134\208\181\208\189\209\139";
		FrmtWarnNocomp	= "\208\157\208\181\209\130 \208\186\208\190\208\189\208\186\209\131\209\128\208\181\208\189\209\130\208\190\208\178";
		FrmtWarnNodata	= "\208\157\208\181\209\130 \208\180\208\176\208\189\208\189\209\139\209\133 \208\180\208\187\209\143 \208\188\208\176\208\186\209\129. \209\134\208\181\208\189\209\139 \208\191\209\128\208\190\208\180\208\176\208\182\208\184\n";
		FrmtWarnToolow	= "\208\157\208\181\208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190 \209\129\208\190\208\191\208\190\209\129\209\130\208\176\208\178\208\184\209\130\209\140 \209\129\208\176\208\188\208\190\208\185 \208\189\208\184\208\183\208\186\208\190\208\185 \209\134\208\181\208\189\208\181\n";
		FrmtWarnUndercut	= "\208\163\209\134\208\181\208\189\208\186\208\176 \208\189\208\176 %s%%";
		FrmtWarnUser	= "\208\166\208\181\208\189\208\176, \208\190\208\191\209\128\208\181\208\180\208\181\208\187\208\181\208\189\208\189\208\176\209\143 \208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\208\181\208\187\208\181\208\188";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "\208\146\208\176\209\136\208\176 \209\129\209\130\208\176\208\178\208\186\208\176 \209\131\208\182\208\181 \209\129\208\176\208\188\208\176\209\143 \208\178\209\139\209\129\208\190\208\186\208\176\209\143: %s (x%d)\n";
		FrmtBidAuction	= "\208\161\209\130\208\176\208\178\208\184\209\130\209\140 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189: %s (x%d)\n";
		FrmtBidQueueOutOfSync	= "\208\158\209\136\208\184\208\177\208\186\208\176: \208\190\209\136\208\184\208\177\208\186\208\176 \208\191\208\190\209\129\208\187\208\181\208\180\208\190\208\178\208\176\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\208\184 \209\129\209\130\208\176\208\178\208\190\208\186";
		FrmtBoughtAuction	= "\208\146\209\139\208\186\209\131\208\191\208\187\208\181\208\189\208\190: %s (x%d)\n";
		FrmtMaxBidsReached	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178 %s (x%d) \208\177\209\139\208\187\208\190 \208\189\208\176\208\185\208\180\208\181\208\189\208\190 \208\177\208\190\208\187\209\140\209\136\208\181, \208\189\208\190 \208\187\208\184\208\188\208\184\209\130 \209\129\209\130\208\176\208\178\208\190\208\186 \208\180\208\190\209\129\209\130\208\184\208\179\208\189\209\131\209\130 (%d)";
		FrmtNoAuctionsFound	= "\208\157\208\181 \208\189\208\176\208\185\208\180\208\181\208\189\208\190: %s (x%d)\n";
		FrmtNoMoreAuctionsFound	= "\208\145\208\190\208\187\209\140\209\136\208\181 \208\189\208\181 \208\189\208\176\208\185\208\180\208\181\208\189\208\190: %s (x%d)\n";
		FrmtNotEnoughMoney	= "\208\157\208\181 \209\133\208\178\208\176\209\130\208\176\208\181\209\130 \208\180\208\181\208\189\208\181\208\179 \208\180\208\187\209\143 \209\129\209\130\208\176\208\178\208\186\208\184 \208\189\208\176: %s (x%d)";
		FrmtSkippedAuctionWithHigherBid	= "\208\159\209\128\208\190\208\191\209\131\209\137\208\181\208\189 \208\176\209\131\208\186\209\134\208\184\208\190\208\189 \209\129 \208\177\208\190\208\187\208\181\208\181 \208\178\209\139\209\129\208\190\208\186\208\190\208\185 \208\183\208\176\209\143\208\178\208\186\208\190\208\185: %s (x%d)\n";
		FrmtSkippedAuctionWithLowerBid	= "\208\159\209\128\208\190\208\191\209\131\209\137\208\181\208\189 \208\176\209\131\208\186\209\134\208\184\208\190\208\189 \209\129 \208\177\208\190\208\187\208\181\208\181 \208\189\208\184\208\183\208\186\208\190\208\185 \208\183\208\176\209\143\208\178\208\186\208\190\208\185: %s (x%d)\n";
		FrmtSkippedBiddingOnOwnAuction	= "\208\159\209\128\208\190\208\191\209\131\209\137\208\181\208\189\208\176 \209\129\209\130\208\176\208\178\208\186\208\176 \208\189\208\176 \209\129\208\190\208\177\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\176\209\131\208\186\209\134\208\184\208\190\208\189: %s (x%d)";
		UiProcessingBidRequests	= "\208\158\208\177\209\128\208\176\208\177\208\190\209\130\208\186\208\176 \208\183\208\176\208\191\209\128\208\190\209\129\208\190\208\178 \208\189\208\176 \209\129\209\130\208\176\208\178\208\186\208\184...\n";


		-- Section: Command Messages
		FrmtActClearall	= "\208\158\209\135\208\184\209\129\209\130\208\186\208\176 \208\178\209\129\208\181\209\133 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\189\209\139\209\133 \208\180\208\176\208\189\208\189\209\139\209\133 \208\180\208\187\209\143 %s\n";
		FrmtActClearFail	= "\208\157\208\181\208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190 \208\189\208\176\208\185\209\130\208\184 \208\191\209\128\208\181\208\180\208\188\208\181\209\130: %s";
		FrmtActClearOk	= "\208\148\208\176\208\189\208\189\209\139\208\181 \208\180\208\187\209\143 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176 \209\131\208\180\208\176\208\187\208\181\208\189\209\139: %s\n";
		FrmtActClearsnap	= "\208\158\209\135\208\184\209\129\209\130\208\186\208\176 \209\130\208\181\208\186\209\131\209\137\208\181\208\179\208\190 \209\129\208\189\208\184\208\188\208\186\208\176 \209\129 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176.\n";
		FrmtActDefault	= "\208\157\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176 %s \208\177\209\139\208\187\208\176 \208\191\208\181\209\128\208\181\209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\208\176 \208\189\208\176 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\181 \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142";
		FrmtActDefaultall	= "\208\146\209\129\208\181 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176 \208\177\209\139\208\187\208\184 \208\191\208\181\209\128\208\181\209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\209\139 \208\186 \208\189\208\176\209\135\208\176\208\187\209\140\208\189\209\139\208\188 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\186\208\176\208\188.\n";
		FrmtActDisable	= "\208\157\208\181 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 %s \208\180\208\176\208\189\208\189\209\139\208\181 \208\191\208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\209\131";
		FrmtActEnable	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 %s \208\180\208\176\208\189\208\189\209\139\208\181 \208\191\208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\209\131";
		FrmtActSet	= "\208\163\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\208\181 %s \208\186 ' %s'\n";
		FrmtActUnknown	= "\208\157\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\208\176\209\143 \208\186\208\190\208\188\208\176\208\189\208\180\208\176 \208\184\208\187\208\184 \208\186\208\187\209\142\209\135: '%s' ";
		FrmtAuctionDuration	= "\208\159\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140 \208\180\208\181\208\185\209\129\209\130\208\178\208\184\209\143 \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\208\176 \208\189\208\176: %s\n";
		FrmtAutostart	= "\208\144\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\184 \208\189\208\176\209\135\208\184\208\189\208\176\209\130\209\140 \208\176\209\131\208\186\209\134\208\184\208\190\208\189 \208\180\208\187\209\143 \208\188\208\184\208\189\208\184\208\188\209\131\208\188\208\176 %s, buyout %s (%dh) %s\n";
		FrmtFinish	= "\208\156\209\139 %s \208\191\208\190\209\129\208\187\208\181 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176\n";
		FrmtPrintin	= "\208\161\208\190\208\190\208\177\209\137\208\181\208\189\208\184\209\143 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176 \209\130\208\181\208\191\208\181\209\128\209\140 \209\130\208\181\208\191\208\181\209\128\209\140 \208\177\209\131\208\180\209\131\209\130 \208\191\208\181\209\135\208\176\209\130\208\176\209\130\209\140\209\129\209\143 \208\178 \"%s\" \208\190\208\186\208\189\208\181 \209\135\208\176\209\130\208\176\n";
		FrmtProtectWindow	= "\208\151\208\176\209\137\208\184\209\130\208\176 \208\190\208\186\208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176 \209\131\209\129\209\130\208\176\208\189\208\190\208\178\208\187\208\181\208\189\208\176 \208\186: %s\n";
		FrmtUnknownArg	= "'%s' \208\189\208\181 \209\143\208\178\208\187\209\143\208\181\209\130\209\129\209\143 \208\191\209\128\208\176\208\178\208\184\208\187\209\140\208\189\209\139\208\188 \208\176\209\128\208\179\209\131\208\188\208\181\208\189\209\130\208\190\208\188 \208\180\208\187\209\143 '%s'\n";
		FrmtUnknownLocale	= "\208\155\208\190\208\186\208\176\208\187\208\184\208\183\208\176\209\134\208\184\209\143, \209\131\208\186\208\176\208\183\208\176\208\189\208\189\208\176\209\143 \208\178\208\176\208\188\208\184 ('%s') \208\189\208\181\208\191\209\128\208\176\208\178\208\184\208\187\209\140\208\189\208\176. \208\159\209\128\208\176\208\178\208\184\208\187\209\140\208\189\209\139\208\181 \208\187\208\190\208\186\208\176\208\187\208\184\208\183\208\176\209\134\208\184\208\184:";
		FrmtUnknownRf	= "\208\157\208\181\208\178\208\181\209\128\208\189\209\139\208\185 \208\191\208\176\209\128\208\176\208\188\208\181\209\130\209\128 (' %s'). \208\158\208\182\208\184\208\180\208\176\208\181\208\188\209\139\208\185 \209\132\208\190\209\128\208\188\208\176\209\130: [ realm]-[faction ]. \208\157\208\176\208\191\209\128\208\184\208\188\208\181\209\128: Al'Akir-Horde\n";


		-- Section: Command Options
		OptAlso	= "(\209\134\208\176\209\128\209\129\209\130\208\178\208\190-faction|opposite|home|neutral)";
		OptAuctionDuration	= "(\208\191\208\190\209\129\208\187|2\209\135|8\209\135|24\209\135) ";
		OptBidbroker	= "<\208\191\209\128\208\184\208\177\209\139\208\187\209\140_\209\129\208\181\209\128\208\181\208\177\209\128\208\190> ";
		OptBidLimit	= "<\209\135\208\184\209\129\208\187\208\190>";
		OptBroker	= "<\208\191\209\128\208\184\208\177\209\139\208\187\209\140_\209\129\208\181\209\128\208\181\208\177\209\128\208\190>";
		OptClear	= "([\208\191\209\128\208\181\208\180\208\188\208\181\209\130]|\208\178\209\129\208\181|snapshot) ";
		OptCompete	= "<silver_less> ";
		OptDefault	= "(<\208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184>|\208\178\209\129\208\181) ";
		OptFinish	= " (\208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140|\208\178\209\139\208\185\209\130\208\184|\208\178\209\139\208\185\209\130\208\184|\208\191\208\181\209\128\208\181\208\179\209\128\209\131\208\183\208\184\209\130\209\140)  ";
		OptLocale	= "<\208\187\208\190\208\186\208\176\208\187\208\184\208\183\208\176\209\134\208\184\209\143> ";
		OptPctBidmarkdown	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPctMarkup	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPctMaxless	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPctNocomp	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPctUnderlow	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPctUndermkt	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPercentless	= "<\208\191\209\128\208\190\209\134\208\181\208\189\209\130>";
		OptPrintin	= "(<frameIndex>[\208\189\208\190\208\188\208\181\209\128]|<frameName>[String]) ";
		OptProtectWindow	= "(\208\189\208\181 \208\186\208\190\208\179\208\180\208\176|\209\129\208\186\208\176\208\189|\208\178\209\129\209\145\209\128\208\176\208\178\208\189\208\190) ";
		OptScale	= "<scale_factor> ";
		OptScan	= "<> ";


		-- Section: Commands
		CmdAlso	= "\209\130\208\176\208\186\208\182\208\181\n";
		CmdAlsoOpposite	= "\208\191\209\128\208\190\209\130\208\184\208\178\208\190\208\191\208\190\208\187\208\190\208\182\208\189\208\190\n";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "\208\190\208\177\209\138\209\143\208\178\208\187\208\181\208\189\208\184\208\181\n";
		CmdAskPriceGuild	= "\208\179\208\184\208\187\209\140\208\180\208\184\209\143\n";
		CmdAskPriceParty	= "\208\179\209\128\209\131\208\191\208\191\208\176\n";
		CmdAskPriceSmart	= "\209\131\208\188\208\189\209\139\208\185";
		CmdAskPriceSmartWord1	= "\209\135\209\130\208\190";
		CmdAskPriceSmartWord2	= "\209\134\208\181\208\189\208\189\208\190\209\129\209\130\209\140";
		CmdAskPriceTrigger	= "\209\130\209\128\208\184\208\179\208\179\208\181\209\128";
		CmdAskPriceVendor	= "\208\191\209\128\208\190\208\180\208\176\208\178\208\181\209\134";
		CmdAskPriceWhispers	= "\208\178\208\184\209\129\208\191\208\181\209\128\209\139";
		CmdAskPriceWord	= "\209\129\208\187\208\190\208\178\208\190";
		CmdAuctionClick	= "\208\176\209\131\208\186\209\134\208\184\208\190\208\189-\208\190\208\180\208\184\208\189 \208\186\208\187\208\184\208\186";
		CmdAuctionDuration	= "\208\176\209\131\208\186\209\134\208\184\208\190\208\189-\208\180\208\187\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140";
		CmdAuctionDuration0	= "\208\191\209\128\208\190\209\136\208\187\209\139\208\185";
		CmdAuctionDuration1	= "2\209\135";
		CmdAuctionDuration2	= "8\209\135";
		CmdAuctionDuration3	= "24\209\135";
		CmdAutofill	= "\208\176\208\178\209\130\208\190\208\183\208\176\208\191\208\190\208\187\208\189\209\143\209\130\209\140  ";
		CmdBidbroker	= "\208\183\208\176\209\143\208\178\208\186\208\190-\208\188\208\176\208\186\208\187\208\181\209\128";
		CmdBidbrokerShort	= "\208\183\208\188";
		CmdBidLimit	= "\208\191\209\128\208\181\208\180\208\181\208\187 \208\191\209\128\208\181\208\180\208\187\208\190\208\182\208\181\208\189\208\184\209\143";
		CmdBroker	= "\208\188\208\176\208\186\208\187\208\181\209\128";
		CmdClear	= "\209\131\208\177\208\184\209\128\208\176\209\130\209\140";
		CmdClearAll	= "\208\178\209\129\209\145";
		CmdClearSnapshot	= "\209\129\208\189\208\184\208\188\208\190\208\186";
		CmdCompete	= "\208\186\208\190\208\189\208\186\209\131\209\128\208\184\209\128\208\190\208\178\208\176\209\130\209\140";
		CmdCtrl	= "ctrl";
		CmdDefault	= "\209\129\209\130\208\176\208\189\208\180\208\176\209\128\209\130";
		CmdDisable	= "\208\190\209\130\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		CmdEmbed	= "\208\178\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		CmdFinish	= "\208\186\208\190\208\189\208\181\209\134";
		CmdFinish0	= "\208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		CmdFinish1	= "logout";
		CmdFinish2	= "\208\178\209\139\209\133\208\190\208\180";
		CmdFinish3	= "\208\191\208\181\209\128\208\181\208\179\209\128\209\131\208\183\208\184\209\130\209\140 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129";
		CmdFinishSound	= "\208\183\208\178\209\131\208\186-\208\190\208\186\208\190\208\189\209\135\208\176\208\189\208\184\208\181 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143";
		CmdHelp	= "\208\191\208\190\208\188\208\190\209\137\209\140";
		CmdLocale	= "\209\143\208\183\209\139\208\186";
		CmdOff	= "\208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		CmdOn	= "\208\178\208\186\208\187\209\142\209\135\208\184\209\130\209\140";
		CmdPctBidmarkdown	= "%-\208\188\208\176\209\128\208\186\208\176 \208\191\209\128\208\181\208\180\208\187\208\190\208\182\208\181\208\189\208\184\209\143 \208\178\208\189\208\184\208\183";
		CmdPctMarkup	= "%-\208\191\208\190\208\178\209\139\209\129\208\184\209\130\209\140";
		CmdPctMaxless	= "%-m\208\176\208\186\209\129 \208\188\208\181\208\189\209\140\209\136\208\181";
		CmdPctNocomp	= "%-\208\189\208\184\208\186\208\176\208\186\208\190\208\181 \209\129\208\190\209\128\208\181\208\178\208\189\208\190\208\178\208\176\208\189\208\184\208\181";
		CmdPctUnderlow	= "%-\208\191\208\190\208\180 \208\189\208\184\208\183\208\186\208\190";
		CmdPctUndermkt	= "%-\208\191\208\190\208\180 \209\128\209\139\208\189\208\186\208\190\208\188";
		CmdPercentless	= "\208\191\209\128\208\190\209\134\208\181\208\189\209\130 \208\188\208\181\208\189\209\140\209\136\208\181";
		CmdPercentlessShort	= "\208\191\208\188";
		CmdPrintin	= "\208\191\208\181\209\135\208\176\209\130\209\140-\208\178";
		CmdProtectWindow	= "\208\183\208\176\209\137\208\184\209\137\208\176\209\130\209\140-\208\190\208\186\208\189\208\190";
		CmdProtectWindow0	= "\208\189\208\184\208\186\208\190\208\179\208\180\208\176";
		CmdProtectWindow1	= "\208\191\209\128\208\190\209\129\208\188\208\190\209\130\209\128";
		CmdProtectWindow2	= "\208\178\209\129\208\181\208\179\208\180\208\176";
		CmdScan	= "\208\191\209\128\208\190\209\129\208\188\208\190\209\130\209\128";
		CmdShift	= "shift";
		CmdToggle	= "\208\184\208\183\208\188\208\181\208\189\208\181\208\189\208\184\208\181-\208\191\209\131\208\179\208\190\208\178\208\184\209\134\209\139";
		CmdUpdatePrice	= "\209\134\208\181\208\189\208\176-\208\189\208\176-\208\188\208\190\208\180\208\181\209\128\208\189\208\184\208\183\208\176\209\134\208\184\209\142";
		CmdWarnColor	= "\208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\176\209\142\209\137\208\184\208\185 \209\134\208\178\208\181\209\130";
		ShowAverage	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\129\209\128\208\181\208\180\208\189\208\181\208\181";
		ShowEmbedBlank	= "\208\191\208\190\208\186\208\176\208\183 \208\178\208\186\208\187\209\142\209\135\208\176\208\181\209\130 \209\135\208\184\209\129\209\130\209\131\209\142 \208\187\208\184\208\189\208\184\209\142";
		ShowLink	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\129\208\178\209\143\208\183\209\140";
		ShowMedian	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\129\209\128\208\181\208\180\208\189\208\181\208\181";
		ShowRedo	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\209\143";
		ShowStats	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\129\209\130\208\176\209\130\208\184\209\129\209\130\208\184\208\186\209\131";
		ShowSuggest	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\128\208\181\208\186\208\190\208\188\208\181\208\189\208\180\209\131\208\181\208\188\209\139\208\181";
		ShowVerbose	= "\208\191\208\190\208\186\208\176\208\183\208\176\209\130\209\140-\209\128\208\176\209\129\209\136\208\184\209\128\208\181\208\189\208\189\208\190";


		-- Section: Config Text
		GuiAlso	= "\208\162\208\176\208\186\208\182\208\181 \208\191\208\190\208\186\208\176\208\182\208\184\209\130\208\181 \208\180\208\176\208\189\208\189\209\139\208\181 \208\180\208\187\209\143";
		GuiAlsoDisplay	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\142\209\130\209\129\209\143 \208\180\208\176\208\189\208\189\209\139\208\181 \208\180\208\187\209\143 %s";
		GuiAlsoOff	= "\208\152\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\143 \208\191\208\190 \208\180\209\128\209\131\208\179\208\184\208\188 \208\188\208\184\209\128\208\176\208\188 \208\177\208\190\208\187\209\140\209\136\208\181 \208\189\208\181 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\208\181\209\130\209\129\209\143.";
		GuiAlsoOpposite	= "\208\162\208\181\208\191\208\181\209\128\209\140 \209\130\208\176\208\186\208\182\208\181 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\142\209\130\209\129\209\143 \208\180\208\176\208\189\208\189\209\139\208\181 \208\183\208\176 \208\191\209\128\208\190\209\130\208\184\208\178\208\190\208\191\208\190\208\187\208\190\208\182\208\189\209\139\208\181 \209\129\208\184\208\187\209\139.";
		GuiAskPrice	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 AskPrice";
		GuiAskPriceAd	= "\208\159\208\190\209\129\209\139\208\187\208\176\209\130\209\140 \208\190\208\177\209\138\209\143\208\178\208\187\208\181\208\189\208\184\209\143 \208\190 \208\178\208\190\208\183\208\188\208\190\208\182\208\189\208\190\209\129\209\130\209\143\209\133";
		GuiAskPriceGuild	= "\208\158\209\130\208\178\208\181\209\135\208\176\209\130\209\140 \208\189\208\176 \208\183\208\176\208\191\209\128\208\190\209\129\209\139 \208\178 \209\135\208\176\209\130\208\181 \208\179\208\184\208\187\209\140\208\180\208\184\208\184";
		GuiAskPriceHeader	= "\208\157\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 AskPrice";
		GuiAskPriceHeaderHelp	= "\208\152\208\183\208\188\208\181\208\189\208\181\208\189\208\184\208\181 \208\191\208\190\208\178\208\181\208\180\208\181\208\189\208\184\209\143 AskPrice";
		GuiAskPriceParty	= "\208\158\209\130\208\178\208\181\209\135\208\176\209\130\209\140 \208\189\208\176 \208\183\208\176\208\191\209\128\208\190\209\129\209\139 \208\178 \209\135\208\176\209\130\208\181 \208\179\209\128\209\131\208\191\208\191\209\139";
		GuiAskPriceSmart	= "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\131\208\188\208\189\209\139\208\181 \209\129\208\187\208\190\208\178\208\176";
		GuiAskPriceTrigger	= "AskPrice \209\130\209\128\208\184\208\179\208\179\208\181\209\128";
		GuiAskPriceVendor	= "\208\159\208\190\209\129\209\139\208\187\208\176\209\130\209\140 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\142 \208\191\209\128\208\190\208\180\208\176\208\178\209\134\208\176";
		GuiAskPriceWhispers	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\184\209\129\209\133\208\190\208\180\209\143\209\137\208\184\208\181 \208\178\208\184\209\129\208\191\208\181\209\128\209\139";
		GuiAskPriceWord	= "\208\161\208\190\208\177\209\129\209\130\208\178\208\181\208\189\208\189\209\139\208\185 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 SmartWord %d";
		GuiAuctionDuration	= "\208\159\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140 \208\180\208\181\208\185\209\129\209\130\208\178\208\184\209\143 \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142";
		GuiAuctionHouseHeader	= "\208\158\208\186\208\189\208\190 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		GuiAuctionHouseHeaderHelp	= "\208\152\208\183\208\188\208\181\208\189\208\181\208\189\208\184\208\181 \208\191\208\190\208\178\208\181\208\180\208\181\208\189\208\184\209\143 \208\190\208\186\208\189\208\176 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		GuiAutofill	= "\208\144\208\178\209\130\208\190\208\183\208\176\208\191\208\190\208\187\208\189\208\181\208\189\208\184\208\181 \209\134\208\181\208\189 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181";
		GuiAverages	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\161\209\128\208\181\208\180\208\189\208\181\208\181";
		GuiBidmarkdown	= "\208\161\208\186\208\184\208\180\208\186\208\176 \209\129 \209\134\208\181\208\189\209\139 \208\178\209\139\208\186\209\131\208\191\208\176 ";
		GuiClearall	= "\208\158\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \208\178\209\129\208\181 \208\180\208\176\208\189\208\189\209\139\208\181 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		GuiClearallButton	= "\208\158\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \208\178\209\129\208\181";
		GuiClearallHelp	= "\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \209\129\209\142\208\180\208\176 \208\180\208\187\209\143 \209\130\208\190\208\179\208\190, \209\135\209\130\208\190\208\177\209\139 \208\190\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \208\178\209\129\208\181 \208\180\208\176\208\189\208\189\209\139\208\181 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176 \208\180\208\187\209\143 \209\141\209\130\208\190\208\179\208\190 \209\129\208\181\209\128\208\178\208\181\209\128\208\176.";
		GuiClearallNote	= "\208\180\208\187\209\143 \209\130\208\181\208\186\209\131\209\137\208\181\208\185 \209\129\209\130\208\190\209\128\208\190\208\189\209\139";
		GuiClearHeader	= "\208\158\209\135\208\184\209\129\209\130\208\186\208\176 \208\148\208\176\208\189\208\189\209\139\209\133";
		GuiClearHelp	= "\208\158\209\135\208\184\209\137\208\176\208\181\209\130 \208\180\208\176\208\189\208\189\209\139\208\181 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176. \208\146\209\139\208\177\208\181\209\128\208\181\209\130\208\181 \208\184\208\187\208\184 \208\178\209\129\208\181 \208\180\208\176\208\189\208\189\209\139\208\181, \208\184\208\187\208\184 \209\130\208\181\208\186\209\131\209\137\208\184\208\185 \209\129\208\189\208\184\208\188\208\190\208\186. \208\158\208\161\208\162\208\158\208\160\208\158\208\150\208\157\208\158: \209\141\209\130\208\184 \208\180\208\181\208\185\209\129\209\130\208\178\208\184\209\143 \208\190\209\130\208\188\208\181\208\189\208\184\209\130\209\140 \208\157\208\149\208\146\208\158\208\151\208\156\208\158\208\150\208\157\208\158.";
		GuiClearsnap	= "\208\158\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \208\180\208\176\208\189\208\189\209\139\208\181 \209\129\208\189\208\184\208\188\208\186\208\176";
		GuiClearsnapButton	= "\208\158\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \209\129\208\189\208\184\208\188\208\190\208\186";
		GuiClearsnapHelp	= "\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \208\183\208\180\208\181\209\129\209\140 \208\180\208\187\209\143 \209\130\208\190\208\179\208\190, \209\135\209\130\208\190\208\177\209\139 \208\190\209\135\208\184\209\129\209\130\208\184\209\130\209\140 \208\180\208\176\208\189\208\189\209\139\208\181 \208\191\208\190 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\181\208\188\209\131 \209\129\208\189\208\184\208\188\208\186\209\131 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176.";
		GuiDefaultAll	= "\208\161\208\177\209\128\208\190\209\129 \208\178\209\129\208\181\209\133 \208\189\208\176\209\129\209\130\209\128\208\190\208\181\208\186 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		GuiDefaultAllButton	= "\208\161\208\177\209\128\208\190\209\129\208\184\209\130\209\140 \208\178\209\129\208\181";
		GuiDefaultAllHelp	= "\208\157\208\176\208\182\208\188\208\184\209\130\208\181 \208\183\208\180\208\181\209\129\209\140, \209\135\209\130\208\190\208\177\209\139 \209\129\208\177\209\128\208\190\209\129\208\184\209\130\209\140 \208\178\209\129\208\181 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176 \208\186 \208\191\208\181\209\128\208\178\208\190\208\189\208\176\209\135\208\176\208\187\209\140\208\189\209\139\208\188 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143\208\188. \208\158\208\161\208\162\208\158\208\160\208\158\208\150\208\157\208\158: \209\141\209\130\208\184 \208\180\208\181\208\185\209\129\209\130\208\178\208\184\209\143 \208\190\209\130\208\188\208\181\208\189\208\184\209\130\209\140 \208\157\208\149\208\146\208\158\208\151\208\156\208\158\208\150\208\157\208\158.";
		GuiDefaultOption	= "\208\161\208\177\209\128\208\190\209\129\208\184\209\130\209\140 \209\141\209\130\208\184 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184";
		GuiEmbed	= "\208\146\209\139\208\178\208\190\208\180\208\184\209\130\209\140 \208\180\208\176\208\189\208\189\209\139\208\181 \208\178 \208\190\208\186\208\189\208\190 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176";
		GuiEmbedBlankline	= "\208\148\208\190\208\177\208\176\208\178\208\187\209\143\209\130\209\140 \208\191\209\131\209\129\209\130\209\131\209\142 \209\129\209\130\209\128\208\190\208\186\209\131";
		GuiEmbedHeader	= "\208\152\208\189\209\130\208\181\208\179\209\128\208\176\209\134\208\184\209\143";
		GuiFinish	= "\208\159\208\190\209\129\208\187\208\181 \208\190\208\186\208\190\208\189\209\135\208\176\208\189\208\184\209\143 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143";
		GuiFinishSound	= "\208\159\209\128\208\190\208\184\208\179\209\128\209\139\208\178\208\176\209\130\209\140 \208\183\208\178\209\131\208\186 \208\191\208\190 \208\190\208\186\208\190\208\189\209\135\208\176\208\189\208\184\209\142 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		GuiLink	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 LinkID";
		GuiLoad	= "\208\151\208\176\208\179\209\128\209\131\208\182\208\176\209\130\209\140 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128";
		GuiLoad_Always	= "\208\178\209\129\208\181\208\179\208\180\208\176";
		GuiLoad_AuctionHouse	= "\208\178 \208\183\208\180\208\176\208\189\208\184\208\184 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		GuiLoad_Never	= "\208\189\208\184\208\186\208\190\208\179\208\180\208\176";
		GuiLocale	= "\208\155\208\190\208\186\208\176\208\187\208\184\208\183\208\176\209\134\208\184\209\143";
		GuiMainEnable	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128";
		GuiMainHelp	= "\208\161\208\190\208\180\208\181\209\128\208\182\208\184\209\130 \208\189\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\184 \208\180\208\187\209\143 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176. \208\144\208\180\208\180\208\158\208\189\208\176, \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\142\209\137\208\181\208\179\208\190 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\142 \208\190 \208\178\208\181\209\137\208\176\209\133 \208\184 \208\176\208\189\208\176\208\187\208\184\208\183\208\184\209\128\209\131\209\142\209\137\208\181\208\179\208\190 \208\180\208\176\208\189\208\189\209\139\208\181 \209\129 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176. \208\157\208\176\208\182\208\188\208\184\209\130\208\181 \208\186\208\189\208\190\208\191\208\186\209\131 \"\208\161\208\186\208\176\208\189\" \208\189\208\176 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181 \208\180\208\187\209\143 \209\129\208\177\208\190\209\128\208\176 \208\180\208\176\208\189\208\189\209\139\209\133";
		GuiMarkup	= "\208\159\209\128\208\190\209\134\208\181\208\189\209\130 \208\189\208\176\208\180\208\177\208\176\208\178\208\186\208\184 \208\190\209\130 \209\134\208\181\208\189\209\139 \208\178\208\181\208\189\208\180\208\190\209\128\208\176";
		GuiMaxless	= "\208\156\208\176\208\186\209\129\208\184\208\188\208\176\208\187\209\140\208\189\209\139\208\185 \208\191\209\128\208\190\209\134\208\181\208\189\209\130 \209\129\208\177\208\184\208\178\208\176\208\189\208\184\209\143 \209\128\209\139\208\189\208\190\209\135\208\189\208\190\208\185 \209\134\208\181\208\189\209\139";
		GuiMedian	= "\208\159\208\190\208\186\208\176\208\183\208\176\209\130\209\140 \209\129\209\128\208\181\208\180\208\189\208\184\208\181 \209\134\208\181\208\189\209\139";
		GuiNocomp	= "\208\159\209\128\208\190\209\134\208\181\208\189\209\130 \209\129\208\177\208\184\208\178\208\176\208\189\208\184\209\143 \209\134\208\181\208\189\209\139 \208\181\209\129\208\187\208\184 \208\189\208\181\209\130 \208\186\208\190\208\189\208\186\209\131\209\128\209\128\208\181\208\189\209\134\208\184\208\184";
		GuiNoWorldMap	= "\208\144\209\131\209\134\208\186\208\184\208\190\208\189\208\181\209\128: \208\186\208\176\209\128\209\130\209\131 \208\188\208\184\209\128\208\176 \208\189\208\181 \208\191\208\190\208\186\208\176\208\183\208\176\208\189\208\176";
		GuiOtherHeader	= "\208\159\209\128\208\190\209\135\208\181\208\181";
		GuiOtherHelp	= "\208\161\208\188\208\181\209\136\208\176\208\189\208\189\209\139\208\181 \208\190\208\191\209\134\208\184\208\184 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		GuiPercentsHeader	= "\208\159\208\190\209\128\208\190\208\179\208\190\208\178\209\139\208\181 \208\178\208\181\208\187\208\184\209\135\208\184\208\189\209\139 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		GuiPercentsHelp	= "\208\146\208\157\208\152\208\156\208\144\208\157\208\152\208\149: \208\162\208\158\208\155\208\172\208\154\208\158 \208\180\208\187\209\143 \208\190\208\191\209\139\209\130\208\189\209\139\209\133 \208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\208\181\208\187\208\181\208\185. \208\157\208\176\209\129\209\130\209\128\208\190\208\185\208\186\208\176 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\208\185 \209\130\208\190\208\179\208\190, \208\189\208\176\209\129\208\186\208\190\208\187\209\140\208\186\208\190 \208\176\208\179\209\128\208\181\209\129\209\129\208\184\208\178\208\181\208\189 \208\177\209\131\208\180\208\181\209\130 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128, \208\191\208\190\208\180\208\177\208\184\209\128\208\176\209\143 \208\180\208\190\209\133\208\190\208\180\208\189\209\139\208\181 \208\183\208\189\208\176\209\135\208\181\208\189\208\184\209\143";
		GuiPrintin	= "\208\146\209\139\208\177\208\181\209\128\208\184\209\130\208\181 \208\182\208\181\208\187\208\176\208\181\208\188\208\190\208\181 \208\190\208\186\208\189\208\190 \209\129\208\190\208\190\208\177\209\137\208\181\208\189\208\184\208\185";
		GuiProtectWindow	= "\208\151\208\176\209\137\208\184\209\130\208\184\209\130\209\140 \208\190\209\130 \209\129\208\187\209\131\209\135\208\176\208\185\208\189\208\190\208\179\208\190 \208\183\208\176\208\186\209\128\209\139\209\130\208\184\209\143 \208\190\208\186\208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		GuiRedo	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\191\209\128\208\181\208\180\209\131\208\191\209\128\208\181\208\182\208\180\208\181\208\189\208\184\208\181 \208\183\208\176\208\180\208\181\209\128\208\182\208\186\208\184 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143";
		GuiReloadui	= "\208\159\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\183\208\184\209\130\209\140 UI";
		GuiReloaduiButton	= "\208\159\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\183\208\184\209\130\209\140 UI";
		GuiReloaduiFeedback	= "\208\159\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\182\208\176\208\181\209\130\209\129\209\143 \208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\208\181\208\187\209\140\209\129\208\186\208\184\208\185 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129";
		GuiReloaduiHelp	= "\208\159\208\190\209\129\208\187\208\181 \209\129\208\188\208\181\208\189\209\139 \209\143\208\183\209\139\208\186\208\176, \208\189\208\176\208\182\208\188\208\184\209\130\208\181 \208\183\208\180\208\181\209\129\209\140 \209\135\209\130\208\190\208\177\209\139 \208\191\208\181\209\128\208\181\208\183\208\176\208\179\209\128\209\131\208\183\208\184\209\130\209\140 \208\184\208\189\209\130\208\181\209\128\209\132\208\181\208\185\209\129, \208\180\208\187\209\143 \209\130\208\190\208\179\208\190 \209\135\209\130\208\190\208\177\209\139 \208\184\208\183\208\188\208\181\208\189\208\181\208\189\208\184\209\143 \208\178\209\129\209\130\209\131\208\191\208\184\208\187\208\184 \208\178 \209\129\208\184\208\187\209\131. \208\173\209\130\208\176 \208\190\208\191\208\181\209\128\208\176\209\134\208\184\209\143 \208\188\208\190\208\182\208\181\209\130 \208\183\208\176\208\189\209\143\209\130\209\140 \208\189\208\181\209\129\208\186\208\190\208\187\209\140\208\186\208\190 \208\188\208\184\208\189\209\131\209\130. ";
		GuiRememberText	= "\208\151\208\176\208\191\208\190\208\188\208\184\208\189\208\176\209\130\209\140 \209\134\208\181\208\189\209\131";
		GuiStatsEnable	= "\208\159\208\190\208\186\208\176\208\183\208\176\209\130\209\140 \209\129\209\130\208\176\209\130\208\184\209\129\209\130\208\184\208\186\209\131";
		GuiStatsHeader	= "\208\161\209\130\208\176\209\130\208\184\209\129\209\130\208\184\208\186\208\176 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176";
		GuiStatsHelp	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\209\131\209\142 \209\129\209\130\208\176\209\130\208\184\209\129\209\130\208\184\208\186\209\131 \208\178 \208\191\208\190\208\180\209\129\208\186\208\176\208\183\208\186\208\181";
		GuiSuggest	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\191\209\128\208\181\208\180\208\187\208\176\208\179\208\176\208\181\208\188\209\139\208\181 \209\134\208\181\208\189\209\139";
		GuiUnderlow	= "\208\161\208\176\208\188\208\190\208\181 \208\188\208\176\208\187\208\181\208\189\209\140\208\186\208\190\208\181 \209\129\208\177\208\184\208\178\208\176\208\189\208\184\208\181 \209\134\208\181\208\189\209\139";
		GuiUndermkt	= "\208\161\208\177\208\184\208\178\208\176\208\189\208\184\208\181 \209\128\209\139\208\189\208\186\208\176";
		GuiVerbose	= "\208\156\208\189\208\190\208\179\208\190\209\129\208\187\208\190\208\178\208\189\209\139\208\185 \209\128\208\181\208\182\208\184\208\188";
		GuiWarnColor	= "\208\166\208\178\208\181\209\130\208\190\208\178\208\176\209\143 \208\191\208\190\208\180\209\129\208\178\208\181\209\130\208\186\208\176 \209\134\208\181\208\189";


		-- Section: Conversion Messages
		MesgConvert	= "\208\157\208\181\208\190\208\177\209\133\208\190\208\180\208\184\208\188\208\190 \208\191\209\128\208\190\208\184\208\183\208\178\208\181\209\129\209\130\208\184 \208\191\209\128\208\181\208\190\208\177\209\128\208\176\208\183\208\190\208\178\208\176\208\189\208\184\208\181 \208\177\208\176\208\183\209\139 \208\180\208\176\208\189\208\189\209\139\209\133 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176. \208\159\208\190\208\182\208\176\208\187\209\131\208\185\209\129\209\130\208\176, \208\191\209\128\208\181\208\180\208\178\208\176\209\128\208\184\209\130\208\181\208\187\209\140\208\189\208\190 \209\129\208\180\208\181\208\187\208\176\208\185\209\130\208\181 \209\128\208\181\208\183\208\181\209\128\208\178\208\189\209\139\208\181 \208\186\208\190\208\191\208\184\208\184 \209\132\208\176\208\185\208\187\208\176 SavedVariables\\Auctioneer.lua";
		MesgConvertNo	= "\208\146\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128";
		MesgConvertYes	= "\208\159\209\128\208\181\208\190\208\177\209\128\208\176\208\183\208\190\208\178\208\176\209\130\209\140";
		MesgNotconverting	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128 \208\189\208\181 \208\191\209\128\208\181\208\190\208\177\209\128\208\176\208\183\208\190\208\178\209\139\208\178\208\176\208\181\209\130 \209\129\208\178\208\190\209\142 \208\177\208\176\208\183\209\131 \208\184 \208\189\208\181 \209\128\208\176\208\177\208\190\209\130\208\176\208\181\209\130.";


		-- Section: Game Constants
		TimeLong	= "\208\148\208\190\208\187\208\179\208\184\208\185";
		TimeMed	= "\208\161\209\128\208\181\208\180\208\189\208\184\208\185";
		TimeShort	= "\208\154\208\190\209\128\208\190\209\130\208\186\208\184\208\185";
		TimeVlong	= "\208\158\209\135\208\181\208\189\209\140 \208\180\208\190\208\187\208\179\208\184\208\185";


		-- Section: Generic Messages
		DisableMsg	= "\208\146\209\139\208\186\208\187\209\142\209\135\208\181\208\189\208\184\208\181 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\190\208\185 \208\183\208\176\208\179\209\128\209\131\208\183\208\186\208\184 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		FrmtWelcome	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128 v%s \208\183\208\176\208\179\209\128\209\131\208\182\208\181\208\189";
		MesgNotLoaded	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128 \208\189\208\181 \208\183\208\176\208\179\209\128\209\131\208\182\208\181\208\189. \208\157\208\176\208\177\208\181\209\128\208\184\209\130\208\181 /auctioneer \208\180\208\187\209\143 \208\180\208\190\208\191\208\190\208\187\208\189\208\184\209\130\208\181\208\187\209\140\208\189\208\190\208\185 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\208\184.";
		StatAskPriceOff	= "AskPrice \209\130\208\181\208\191\208\181\209\128\209\140 \208\178\209\139\208\186\208\187\209\142\209\135\208\181\208\189.";
		StatAskPriceOn	= "AskPrice \209\130\208\181\208\191\208\181\209\128\209\140 \208\178\208\186\208\187\209\142\209\135\208\181\208\189.";
		StatOff	= "\208\157\208\181 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\208\181\209\130\209\129\209\143 \208\189\208\184\208\186\208\176\208\186\208\190\208\185 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\208\184 \208\191\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\209\131";
		StatOn	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\208\181\209\130\209\129\209\143 \208\184\208\189\209\132\208\190\209\128\208\188\208\176\209\134\208\184\209\143 \208\191\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\209\131";


		-- Section: Generic Strings
		TextAuction	= "\208\176\209\131\208\186\209\134\208\184\208\190\208\189";
		TextCombat	= "\208\145\208\190\208\185";
		TextGeneral	= "\208\158\209\129\208\189\208\190\208\178\208\189\208\190\208\185";
		TextNone	= "\208\189\208\181\209\130";
		TextScan	= "\208\161\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\209\130\209\140";
		TextUsage	= "\208\152\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\208\189\208\184\208\181:";


		-- Section: Help Text
		HelpAlso	= "\208\162\208\176\208\186 \208\182\208\181 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \208\180\208\176\208\189\208\189\209\139\208\181 \208\180\209\128\209\131\208\179\208\184\209\133 \209\129\208\181\209\128\208\178\208\181\209\128\208\190\208\178 \208\178 \208\191\208\190\208\180\209\129\208\186\208\176\208\183\208\186\208\181. \208\146\209\129\209\130\208\176\208\178\209\140\209\130\208\181 \208\184\208\188\209\143 \209\129\208\181\209\128\208\178\208\181\209\128\208\176, \208\184 \208\184\208\188\209\143 \209\132\209\128\208\176\208\186\209\134\208\184\208\184. \208\157\208\176\208\191\209\128\208\184\208\188\208\181\209\128: \"/auctioneer also Warsong-Horde\". \208\161\208\187\208\190\208\178\208\190 \"opposite\" \208\190\208\177\208\190\208\183\208\189\208\176\209\135\208\176\208\181\209\130 \208\191\209\128\208\190\209\130\208\184\208\178\208\190\208\191\208\190\208\187\208\190\208\182\208\189\209\131\209\142 \209\132\209\128\208\176\208\186\209\134\208\184\209\142, \"off\" - \208\190\209\130\208\186\208\187\209\142\209\135\208\176\208\181\209\130 \209\132\209\131\208\189\208\186\209\134\208\184\208\184.";
		HelpAskPrice	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\184\208\187\208\184 \208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140 AskPrice";
		HelpAskPriceGuild	= "\208\158\209\130\208\178\208\181\209\135\208\176\209\130\209\140 \208\189\208\176 \208\183\208\176\208\191\209\128\208\190\209\129\209\139, \209\129\208\180\208\181\208\187\208\176\208\189\208\189\209\139\208\181 \208\189\208\176 \208\186\208\176\208\189\208\176\208\187\208\181 \208\179\208\184\208\187\209\140\208\180\208\184\208\184";
		HelpAskPriceParty	= "\208\158\209\130\208\178\208\181\209\135\208\176\209\130\209\140 \208\189\208\176 \208\183\208\176\208\191\209\128\208\190\209\129\209\139, \209\129\208\180\208\181\208\187\208\176\208\189\208\189\209\139\208\181 \208\189\208\176 \208\186\208\176\208\189\208\176\208\187\208\181 \208\179\209\128\209\131\208\191\208\191\209\139";
		HelpAskPriceSmart	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\184\208\187\208\184 \208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\191\209\128\208\190\208\178\208\181\209\128\208\186\209\131 \208\189\208\176 \208\186\208\187\209\142\209\135\208\181\208\178\209\139\208\181 \209\129\208\187\208\190\208\178\208\176";
		HelpAskPriceVendor	= "\208\146\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\184\208\187\208\184 \208\178\209\139\208\186\208\187\209\142\209\135\208\184\209\130\209\140 \208\190\209\130\209\129\209\139\208\187\208\186\209\131 \209\134\208\181\208\189 \209\130\208\190\209\128\208\179\208\190\208\178\209\134\208\176.";
		HelpAuctionClick	= "\208\159\208\190\208\183\208\178\208\190\208\187\209\143\208\181\209\130 \208\189\208\176\208\182\208\176\209\130\208\184\208\181\208\188 Alt-Click \208\189\208\176 \208\178\208\181\209\137\208\184 \208\178 \208\178\208\176\209\136\208\181\208\188 \208\184\208\189\208\178\208\181\208\189\209\130\208\176\209\128\208\181 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\209\130\208\186\208\184 \208\191\208\190\209\129\209\130\208\176\208\178\208\184\209\130\209\140 \208\181\208\181 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189";
		HelpAuctionDuration	= "\208\163\209\129\209\130\208\176\208\189\208\176\208\178\208\187\208\184\208\178\208\176\208\181\209\130 \208\191\209\128\208\190\208\180\208\190\208\187\208\182\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176, \208\191\209\128\208\181\208\187\208\176\208\179\208\176\208\181\208\188\209\131\209\142 \208\191\208\190 \209\131\208\188\208\190\208\187\209\135\208\176\208\189\208\184\209\142.";
		HelpAutofill	= "\208\163\209\129\209\130\208\176\208\189\208\190\208\178\208\184\209\130\208\181, \209\135\209\130\208\190\208\177\209\139 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\184 \208\183\208\176\208\191\208\190\208\187\208\189\209\143\209\130\209\140 \209\134\208\181\208\189\209\139 \208\191\209\128\208\184 \209\129\208\190\208\183\208\180\208\176\208\189\208\184\208\184 \208\189\208\190\208\178\208\190\208\179\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176";
		HelpAverage	= "\208\146\209\139\208\177\208\181\209\128\208\184\209\130\208\181, \209\135\209\130\208\190\208\177\209\139 \208\191\208\190\208\186\208\176\208\183\209\139\208\178\208\176\209\130\209\140 \209\129\209\128\208\181\208\180\208\189\209\142\209\142 \209\134\208\181\208\189\209\139 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181 \208\189\208\176 \209\141\209\130\209\131 \208\178\208\181\209\137\209\140";
		HelpBidbroker	= "\208\146\209\139\208\177\208\181\209\128\208\184\209\130\208\181, \208\186\208\176\208\186\208\190\208\185 \208\180\208\187\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\208\184 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\209\139 \209\129 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\181\208\179\208\190 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143 \208\177\209\131\208\180\209\131\209\130 \208\176\208\189\208\176\208\187\208\184\208\183\208\184\209\128\208\190\208\178\208\176\209\130\209\140\209\129\209\143 \208\189\208\176 \208\191\209\128\208\181\208\180\208\188\208\181\209\130 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\184\209\143 \208\191\209\128\208\184\208\177\209\139\208\187\208\184.";
		HelpBidLimit	= "\208\156\208\176\208\186\209\129\208\184\208\188\208\176\208\187\209\140\208\189\208\190\208\181 \208\186\208\190\208\187\208\184\209\135\208\181\209\129\209\130\208\178\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178 \208\189\208\176 \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\180\208\181\208\187\208\176\208\181\209\130\209\129\209\143 \209\129\209\130\208\176\208\178\208\186\208\176 \208\184\208\187\208\184 \208\178\209\139\208\186\209\131\208\191\208\176\208\181\209\130\209\129\209\143 \208\191\209\128\208\184 \208\189\208\176\208\182\208\176\209\130\208\184\208\184 \208\189\208\176 \208\186\208\189\208\190\208\191\208\186\209\131 \208\178 \208\190\208\186\208\189\208\181 \208\191\208\190\208\184\209\129\208\186\208\176.";
		HelpBroker	= "\208\159\208\190\208\186\208\176\208\183\209\139\208\178\208\176\208\181\209\130 \208\178\209\129\208\181 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\209\139 \209\129 \208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\181\208\179\208\190 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143, \208\189\208\176 \208\186\208\190\209\130\208\190\209\128\209\139\208\181 \208\188\208\190\208\182\208\181\209\130 \208\177\209\139\209\130\209\140 \209\129\208\180\208\181\208\187\208\176\208\189\208\176 \209\129\209\130\208\176\208\178\208\186\208\176 \209\129 \209\134\208\181\208\187\209\140\209\142 \208\180\208\176\208\187\209\140\208\189\208\181\208\185\209\136\208\181\208\179\208\190 \208\191\208\190\208\187\209\131\209\135\208\181\208\189\208\184\209\143 \208\191\209\128\208\184\208\177\209\139\208\187\208\184.";
		HelpClear	= "\208\158\209\130\209\135\208\184\209\137\208\176\208\181\209\130 \208\180\208\176\208\189\208\189\209\139\208\181 \208\191\208\190 \208\186\208\190\208\189\208\186\209\128\208\181\209\130\208\189\208\190\208\185 \208\178\208\181\209\137\208\184 (shift-click \208\180\208\187\209\143 \208\178\209\129\209\130\208\176\208\178\208\186\208\184 \208\189\208\176\208\183\208\178\208\176\208\189\208\184\209\143) \208\146\209\139 \209\130\208\176\208\186\208\182\208\181 \208\188\208\190\208\182\208\181\209\130\208\181 \208\184\209\129\208\191\208\190\208\187\209\140\208\183\208\190\208\178\208\176\209\130\209\140 \209\129\208\187\208\190\208\178\208\176: \"All\" (\208\178\209\129\208\181) \208\184 \"snapshot\" (\208\191\208\190\209\129\208\187\208\181\208\180\208\189\208\184\208\185 \209\129\208\186\208\176\208\189)";
		HelpDisable	= "\208\157\208\181 \208\183\208\176\208\179\209\128\209\131\208\182\208\176\209\130\209\140 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128 \208\176\208\178\209\130\208\190\208\188\208\176\209\130\208\184\209\135\208\181\209\129\208\186\208\184 \208\191\209\128\208\184 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\208\181\208\188 \208\178\209\133\208\190\208\180\208\181 \208\178 \208\184\208\179\209\128\209\131.";
		HelpOnoff	= "\208\146\208\186\208\187\209\142\209\135\208\176\208\181\209\130 \208\184 \208\178\209\139\208\186\208\187\209\142\209\135\208\176\208\181\209\130 \208\191\208\190\208\186\208\176\208\183 \208\180\208\176\208\189\208\189\209\139\209\133 \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "\208\157\208\181 \209\133\208\178\208\176\209\130\208\176\208\181\209\130 \209\129\208\178\208\190\208\177\208\190\208\180\208\189\208\190\208\179\208\190 \208\188\208\181\209\129\209\130\208\176 \208\178 \209\129\209\131\208\188\208\186\208\176\209\133 \208\180\208\187\209\143 \209\129\208\190\208\183\208\180\208\176\208\189\208\184\209\143 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176!";
		FrmtNotEnoughOfItem	= "\208\163 \208\178\208\176\209\129 \208\189\208\181\208\180\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190 %s \208\180\208\187\209\143 \209\129\208\190\208\183\208\180\208\176\208\189\208\184\209\143 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176!";
		FrmtPostedAuction	= "\208\161\208\190\208\183\208\180\208\176\208\189 1 \208\176\209\131\208\186\209\134\208\184\208\190\208\189 \208\184\208\183 %s (x%d)";
		FrmtPostedAuctions	= "\208\161\208\190\208\183\208\180\208\176\208\189\208\190 %d \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178 \208\184\208\183 %s (x%d)";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\209\130\208\181\208\186\208\161\209\130\208\176\208\178\208\186\208\176";
		FrmtBidbrokerMinbid	= "\208\188\208\184\208\189\208\161\209\130\208\176\208\178\208\186\208\176";
		FrmtNoauct	= "\208\157\208\181 \208\189\208\176\208\185\208\180\208\181\208\189\208\190 \208\189\208\184 \208\190\208\180\208\189\208\190\208\179\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176 \208\180\208\187\209\143 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176: %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "\208\163\208\180\208\176\208\187\208\181\208\189\208\190 \208\189\208\181 \209\129\209\131\209\137\208\181\209\129\209\130\208\178\209\131\209\142\209\137\208\184\209\133 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178: %s";
		AuctionDiscrepancies	= "\208\157\208\176\208\185\208\180\208\181\208\189\208\190 \208\189\208\181\209\129\208\190\208\190\209\130\208\178\208\181\209\130\209\129\209\130\208\178\208\184\208\185: %s";
		AuctionNewAucts	= "\208\158\209\130\209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\190 \208\189\208\190\208\178\209\139\209\133 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178: %s";
		AuctionOldAucts	= "\208\158\209\130\209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\190 \208\180\208\190 \209\141\209\130\208\190\208\179\208\190: %s";
		AuctionPageN	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128: \209\129\208\186\208\176\208\189\208\184\209\128\209\131\208\181\209\130\209\129\209\143 %s \209\129\209\130\209\128\208\176\208\189\208\184\209\134\208\176 %d \208\184\208\183 %d \208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178 \208\178 \209\129\208\181\208\186\209\131\208\189\208\180\209\131: %s \208\158\209\129\209\130\208\176\208\187\208\190\209\129\209\140 \208\178\209\128\208\181\208\188\208\181\208\189\208\184 %s";
		AuctionScanDone	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128: \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\208\181 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176 \208\183\208\176\208\178\208\181\209\128\209\136\208\181\208\189\208\190.";
		AuctionScanNexttime	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128 \209\129\208\180\208\181\208\187\208\176\208\181\209\130 \208\191\208\190\208\187\208\189\208\190\208\181 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\208\181 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176, \208\186\208\190\208\179\208\180\208\176 \208\146\209\139 \208\178 \209\129\208\187\208\181\208\180\209\131\209\142\209\137\208\184\208\185 \209\128\208\176\208\183 \208\191\208\190\208\179\208\190\208\178\208\190\209\128\208\184\209\130\208\181 \209\129 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\190\208\188.";
		AuctionScanNocat	= "\208\146\209\139 \208\180\208\190\208\187\208\182\208\189\209\139 \208\178\209\139\208\177\209\128\208\176\209\130\209\140 \208\189\208\181 \208\188\208\181\208\189\208\181\208\181 \208\190\208\180\208\189\208\190\208\185 \208\186\208\176\209\130\208\181\208\179\208\190\209\128\208\184\208\184 \208\180\208\187\209\143 \209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\184\209\143.";
		AuctionScanRedo	= "\208\162\208\181\208\186\209\131\209\137\208\176\209\143 \209\129\209\130\209\128\208\176\208\189\208\184\209\134\208\176 \208\183\208\176\208\189\209\143\208\187\208\176 \208\177\208\190\208\187\209\140\209\136\208\181 \209\135\208\181\208\188 %d \209\129\208\181\208\186\209\131\208\189\208\180 \208\180\208\187\209\143 \208\190\208\177\209\128\208\176\208\177\208\190\209\130\208\186\208\184. \208\159\208\190\208\178\209\130\208\190\209\128\208\189\208\176\209\143 \208\190\208\177\209\128\208\176\208\177\208\190\209\130\208\186\208\176.";
		AuctionScanStart	= "\208\144\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128: \209\129\208\186\208\176\208\189\208\184\209\128\209\131\208\181\209\130\209\129\209\143 %s \209\129\209\130\209\128\208\176\208\189\208\184\209\134\208\176 1";
		AuctionTotalAucts	= "\208\146\209\129\208\181\208\179\208\190 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\190\208\178 \208\190\209\130\209\129\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\190: %s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "\208\146\208\184\208\180\208\181\208\189 %d \209\128\208\176\208\183 \208\178 %s";
		FrmtInfoAverage	= "%s \208\188\208\184\208\189/%s \208\146\209\139\208\186\209\131\208\191 (%s \209\129\209\130\208\176\208\178\208\186\208\176)";
		FrmtInfoBidMulti	= "\208\161\209\130\208\176\208\178\208\186\208\184 (%s%s \208\183\208\176 \209\136\209\130)";
		FrmtInfoBidOne	= "\208\161\209\130\208\176\208\178\208\186\208\184%s";
		FrmtInfoBidrate	= "%d %% \208\184\208\188\208\181\209\142\209\130 \209\129\209\130\208\176\208\178\208\186\208\184, %d %% \208\184\208\188\208\181\209\142\209\130 \209\134\208\181\208\189\209\131 \208\178\209\139\208\186\209\131\208\191\208\176";
		FrmtInfoBuymedian	= "\208\161\209\128\208\181\208\180\208\189\209\143\209\143 \209\134\208\181\208\189\208\176 \208\178\209\139\208\186\209\131\208\191\208\176";
		FrmtInfoBuyMulti	= "\208\146\209\139\208\186\209\131\208\191 (%s%s \208\183\208\176 \209\136\209\130)";
		FrmtInfoBuyOne	= "\208\146\209\139\208\186\209\131\208\191%s";
		FrmtInfoForone	= "\208\151\208\176 1: %s \208\188\208\184\208\189/%s \208\178\209\139\208\186\209\131\208\191 (%s \209\129\209\130\208\176\208\178\208\186\208\176) [\208\178 %d's]";
		FrmtInfoHeadMulti	= "\208\161\209\128\208\181\208\180\208\189\208\181\208\181 \208\183\208\176 %d \209\136\209\130:";
		FrmtInfoHeadOne	= "\208\161\209\128\208\181\208\180\208\189\208\181\208\181 \208\183\208\176 \209\141\209\130\209\131 \208\178\208\181\209\137\209\140:";
		FrmtInfoHistmed	= "\208\159\208\190\209\129\208\187\208\181\208\180\208\189\208\184\208\185 %d, \209\129\209\128\208\181\208\180\208\189\208\184\208\185 \208\178\209\139\208\186\209\131\208\191 (\208\183\208\176 \209\136\209\130)";
		FrmtInfoMinMulti	= "\208\157\208\176\209\135\208\176\208\187\209\140\208\189\208\176\209\143 \209\129\209\130\208\176\208\178\208\186\208\176 (%s \208\183\208\176 \209\136\209\130)";
		FrmtInfoMinOne	= "\208\157\208\176\209\135\208\176\208\187\209\140\208\189\208\176\209\143 \209\129\209\130\208\176\208\178\208\186\208\176";
		FrmtInfoNever	= "\208\157\208\184 \209\128\208\176\208\183\209\131 \208\189\208\181 \208\177\209\139\208\187 \208\183\208\176\208\188\208\181\209\135\208\181\208\189 \208\189\208\176 %s";
		FrmtInfoSeen	= "\208\152\209\130\208\190\208\179\208\190 %d \209\128\208\176\208\183 \208\178\208\184\208\180\208\181\208\189 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181";
		FrmtInfoSgst	= "\208\159\209\128\208\181\208\180\208\187\208\176\208\179\208\176\208\181\208\188\208\176\209\143 \209\134\208\181\208\189\208\176: %s \208\188\208\184\208\189/%s \208\178\209\139\208\186\209\131\208\191";
		FrmtInfoSgststx	= "\208\159\209\128\208\181\208\180\208\187\208\176\208\179\208\176\208\181\208\188\208\176\209\143 \209\134\208\181\208\189\208\176 \208\183\208\176 %d \209\136\209\130: %s \208\188\208\184\208\189/%s \208\178\209\139\208\186\209\131\208\191";
		FrmtInfoSnapmed	= "\208\161\208\186\208\176\208\189\208\184\209\128\208\190\208\178\208\176\208\189\208\189\209\139\208\185 %d, \209\129\209\128\208\181\208\180\208\189\208\184\208\185 \208\178\209\139\208\186\209\131\208\191 (\208\183\208\176 \209\136\209\130)";
		FrmtInfoStacksize	= "\208\161\209\128\208\181\208\180\208\189\208\184\208\185 \209\128\208\176\208\183\208\188\208\181\209\128 \208\186\209\131\209\135\208\184: %d \209\136\209\130";


		-- Section: User Interface
		FrmtLastSoldOn	= "\208\159\208\190\209\129\208\187\208\181\208\180\208\189\209\143\209\143 \208\191\209\128\208\190\208\180\208\176\208\182\208\176 %s";
		UiBid	= "\208\159\209\128\208\181\208\180\208\187\208\190\208\182\208\181\208\189\208\184\208\181";
		UiBidHeader	= "\208\159\209\128\208\181\208\180\208\187\208\190\208\182\208\181\208\189\208\184\208\181";
		UiBidPerHeader	= "\208\161\209\130\208\176\208\178\208\186\208\176 \208\183\208\176";
		UiBuyout	= "\208\146\209\139\208\186\209\131\208\191\208\184\209\130\209\140";
		UiBuyoutHeader	= "\208\161\208\186\209\131\208\191\208\186\208\176";
		UiBuyoutPerHeader	= "\208\146\209\139\208\186\209\131\208\191\208\184\209\130\209\140 \208\183\208\176";
		UiBuyoutPriceLabel	= "\208\166\208\181\208\189\208\176 \208\189\208\176 \208\161\208\186\209\131\208\191\208\186\209\131:";
		UiBuyoutPriceTooLowError	= "(\208\161\208\187\208\184\209\136\208\186\208\190\208\188 \208\189\208\184\208\183\208\186\208\176\209\143)";
		UiCategoryLabel	= "\208\158\208\179\209\128\208\176\208\189\208\184\209\135\208\181\208\189\208\184\208\181 \208\186\208\176\209\130\208\181\208\179\208\190\209\128\208\184\208\184:";
		UiDepositLabel	= "\208\148\208\181\208\191\208\190\208\183\208\184\209\130:";
		UiDurationLabel	= "\208\148\208\187\208\184\209\130\208\181\208\187\209\140\208\189\208\190\209\129\209\130\209\140";
		UiItemLevelHeader	= "\208\163\209\128\208\190\208\178\208\181\208\189\209\140";
		UiMakeFixedPriceLabel	= "\208\156\208\176\208\186\209\129. \209\132\208\184\208\186\209\129\208\184\209\128\208\190\208\178\208\176\208\189\208\189\208\176\209\143 \209\134\208\181\208\189\208\176";
		UiMaxError	= "(%d \208\156\208\176\208\186\209\129) ";
		UiMaximumPriceLabel	= "\208\156\208\176\208\186\209\129. \209\134\208\181\208\189\208\176";
		UiMaximumTimeLeftLabel	= "\208\156\208\176\208\186\209\129. \208\178\209\128\208\181\208\188\209\143 \208\190\209\129\209\130\208\176\208\187\208\190\209\129\209\140:";
		UiMinimumPercentLessLabel	= "\208\156\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\209\139\208\185 \208\159\209\128\208\190\209\134\208\181\208\189\209\130 \208\156\208\181\208\189\209\140\209\136\208\181:";
		UiMinimumProfitLabel	= "\208\156\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\208\176\209\143 \208\191\209\128\208\184\208\177\209\139\208\187\209\140:";
		UiMinimumQualityLabel	= "\208\156\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\208\190\208\181 \208\186\208\190\208\187-\208\178\208\190";
		UiMinimumUndercutLabel	= "\208\156\208\184\208\189\208\184\208\188\208\176\208\187\209\140\208\189\208\176\209\143 \209\131\209\134\208\181\208\189\208\186\208\176";
		UiNameHeader	= "\208\152\208\188\209\143";
		UiNoPendingBids	= "\208\146\209\129\208\181 \209\129\209\130\208\176\208\178\208\186\208\184 \208\190\208\177\209\128\208\176\208\177\208\190\209\130\208\176\208\189\209\139!";
		UiNotEnoughError	= "(\208\157\208\181\208\180\208\190\209\129\209\130\208\176\209\130\208\190\209\135\208\189\208\190)";
		UiPendingBidInProgress	= "1 \209\129\209\130\208\176\208\178\208\186\208\176 \208\190\208\177\209\128\208\176\208\177\208\176\209\130\209\139\208\178\208\176\208\181\209\130\209\129\209\143...";
		UiPendingBidsInProgress	= "%d \209\129\209\130\208\176\208\178\208\190\208\186 \208\190\208\177\209\128\208\176\208\177\208\176\209\130\209\139\208\178\208\176\208\181\209\130\209\129\209\143...";
		UiPercentLessHeader	= "%";
		UiPost	= "\208\159\208\190\209\129\209\130\208\176\208\178\208\184\209\130\209\140";
		UiPostAuctions	= "\208\159\208\190\209\129\209\130\208\176\208\178\208\184\209\130\209\140 \208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189";
		UiPriceBasedOnLabel	= "\208\166\208\181\208\189\208\176 \208\177\208\176\208\183\208\184\209\128\209\131\209\142\209\137\208\176\209\143\209\129\209\143 \208\189\208\176:";
		UiPriceModelAuctioneer	= "\208\166\208\181\208\189\208\176 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\181\209\128\208\176";
		UiPriceModelCustom	= "\208\166\208\181\208\189\208\176 \208\178\209\128\209\131\209\135\208\189\209\131\209\142";
		UiPriceModelFixed	= "\208\164\208\184\208\186\209\129. \208\166\208\181\208\189\208\176";
		UiPriceModelLastSold	= "\208\159\208\190\209\129\208\187\208\181\208\180\208\189\209\143\209\143 \208\166\208\181\208\189\208\176 \208\159\209\128\208\190\208\180\208\176\208\182\208\184";
		UiProfitHeader	= "\208\159\209\128\208\184\208\177\209\139\208\187\209\140";
		UiProfitPerHeader	= "\208\159\209\128\208\184\208\177\209\139\208\187\209\140 \208\183\208\176";
		UiQuantityHeader	= "\208\154\208\190\208\187-\208\178\208\190";
		UiQuantityLabel	= "\208\154\208\190\208\187-\208\178\208\190";
		UiRemoveSearchButton	= "\208\163\208\180\208\176\208\187\208\184\209\130\209\140";
		UiSavedSearchLabel	= "\208\161\208\190\209\133\209\128\208\176\208\189\208\181\208\189\208\189\209\139\208\181 \208\191\208\190\208\184\209\129\208\186\208\184";
		UiSaveSearchButton	= "\208\161\208\190\209\133\209\128\208\176\208\189\208\184\209\130\209\140";
		UiSaveSearchLabel	= "\208\161\208\190\209\133\209\128\208\176\208\189\208\184\209\130\209\140 \208\191\208\190\208\184\209\129\208\186";
		UiSearch	= "\208\152\209\129\208\186\208\176\209\130\209\140";
		UiSearchAuctions	= "\208\152\209\129\208\186\208\176\209\130\209\140 \208\178 \208\176\209\131\208\186\209\134\208\184\208\190\208\189\208\176\209\133";
		UiSearchDropDownLabel	= "\208\159\208\190\208\184\209\129\208\186:";
		UiSearchForLabel	= "\208\159\208\190\208\184\209\129\208\186 \208\191\209\128\208\181\208\180\208\188\208\181\209\130\208\176:";
		UiSearchTypeBids	= "\208\161\209\130\208\176\208\178\208\186\208\184";
		UiSearchTypeBuyouts	= "\208\166\208\181\208\189\209\139 \208\178\209\139\208\186\209\131\208\191\208\176";
		UiSearchTypeCompetition	= "\208\186\208\190\208\189\208\186\209\131\209\128\208\181\208\189\209\134\208\184\209\143";
		UiSearchTypePlain	= "\208\191\209\128\208\181\208\180\208\188\208\181\209\130";
		UiStacksLabel	= "\208\154\209\131\209\135\208\176";
		UiStackTooBigError	= "(\208\154\209\131\209\135\208\176 \208\161\208\187\208\184\209\136\208\186\208\190\208\188 \208\146\208\181\208\187\208\184\208\186\208\176)";
		UiStackTooSmallError	= "(\208\154\209\131\209\135\208\176 \208\161\208\187\208\184\209\136\208\186\208\190\208\188 \208\156\208\176\208\187\208\176)";
		UiStartingPriceLabel	= "\208\157\208\176\209\135. \209\134\208\181\208\189\208\176";
		UiStartingPriceRequiredError	= "(\208\162\209\128\208\181\208\177\209\131\208\181\209\130\209\129\209\143)";
		UiTimeLeftHeader	= "\208\158\209\129\209\130\208\176\208\178\209\136\208\181\208\181\209\129\209\143 \208\178\209\128\208\181\208\188\209\143";
		UiUnknownError	= "(\208\157\208\181\208\184\208\183\208\178\208\181\209\129\209\130\208\189\209\139\208\185)";

	};

	zhCN = {


		-- Section: AskPrice Messages
		AskPriceAd	= "\228\187\165%sx[\231\137\169\229\147\129\233\147\190\230\142\165](x=\229\160\134\229\143\160\230\149\176\233\135\143)\232\142\183\229\143\150\229\160\134\229\143\160\228\187\183\230\160\188\227\128\130";
		FrmtAskPriceBuyoutMedianHistorical	= "%s\230\151\162\229\190\128\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188\239\188\154%s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%s\230\156\128\232\191\145\230\137\171\230\143\143\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188\239\188\154%s%s";
		FrmtAskPriceDisable	= "\231\166\129\231\148\168\232\175\162\228\187\183%s\233\128\137\233\161\185\227\128\130";
		FrmtAskPriceEach	= "(\230\175\143\228\187\182%s)";
		FrmtAskPriceEnable	= "\229\144\175\231\148\168\232\175\162\228\187\183%s\233\128\137\233\161\185\227\128\130";
		FrmtAskPriceVendorPrice	= "%s\229\148\174\228\186\142\229\149\134\232\180\169\239\188\154%s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "\228\187\142\229\189\147\229\137\141\230\139\141\229\141\150\232\161\140\230\177\135\230\128\187\228\184\173\229\136\160\233\153\164\230\160\135\232\175\134%s\227\128\130";
		FrmtAuctinfoHist	= "\230\151\162\229\190\128%d\230\172\161";
		FrmtAuctinfoLow	= "\230\177\135\230\128\187\229\144\142\233\153\141\232\135\179";
		FrmtAuctinfoMktprice	= "\229\184\130\229\156\186\228\187\183\230\160\188";
		FrmtAuctinfoNolow	= "\230\156\128\232\191\145\230\177\135\230\128\187\230\156\170\229\143\145\231\142\176\232\175\165\231\137\169\229\147\129";
		FrmtAuctinfoOrig	= "\229\142\159\232\181\183\230\139\141\228\187\183";
		FrmtAuctinfoSnap	= "\229\136\154\230\137\171\230\143\143\229\136\176%d\230\172\161";
		FrmtAuctinfoSugbid	= "\229\187\186\232\174\174\232\181\183\230\139\141\228\187\183";
		FrmtAuctinfoSugbuy	= "\229\187\186\232\174\174\228\184\128\229\143\163\228\187\183";
		FrmtWarnAbovemkt	= "\231\171\158\229\141\150\232\182\133\229\135\186\232\161\140\230\131\133";
		FrmtWarnMarkup	= "\230\160\135\233\171\152\228\184\186\229\149\134\232\180\169\230\148\182\232\180\173\228\187\183\231\154\132%s%%";
		FrmtWarnMyprice	= "\228\189\191\231\148\168\229\189\147\229\137\141\232\135\170\229\174\154\228\187\183";
		FrmtWarnNocomp	= "\230\151\160\231\171\158\228\187\183";
		FrmtWarnNodata	= "\230\151\160\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\231\154\132\230\149\176\230\141\174";
		FrmtWarnToolow	= "\230\151\160\230\179\149\229\140\185\233\133\141\230\156\128\228\189\142\228\187\183";
		FrmtWarnUndercut	= "\229\137\138\228\187\183%s%%";
		FrmtWarnUser	= "\228\189\191\231\148\168\232\135\170\229\174\154\228\187\183";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "\229\183\178\230\152\175\229\186\148\230\139\141\239\188\154%s (x%d)\231\154\132\229\177\133\233\171\152\229\135\186\228\187\183\228\186\186\227\128\130";
		FrmtBidAuction	= "\229\135\186\228\187\183\231\171\158\230\139\141\239\188\154%s (x%d)\227\128\130";
		FrmtBidQueueOutOfSync	= "\233\148\153\232\175\175\239\188\154\231\171\158\230\139\141\233\152\159\229\136\151\228\184\141\229\144\140\230\173\165\239\188\129";
		FrmtBoughtAuction	= "\228\184\128\229\143\163\228\187\183\229\186\148\230\139\141\239\188\154%s (x%d)\227\128\130";
		FrmtMaxBidsReached	= "\230\137\190\229\136\176\230\155\180\229\164\154\230\139\141\229\141\150\239\188\154%s (x%d),\228\189\134\230\152\175\229\183\178\232\190\190\229\136\176\231\171\158\230\139\141\233\153\144\229\186\166(%d)\227\128\130";
		FrmtNoAuctionsFound	= "\230\156\170\230\137\190\229\136\176\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";
		FrmtNoMoreAuctionsFound	= "\230\156\170\230\137\190\229\136\176\230\155\180\229\164\154\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";
		FrmtNotEnoughMoney	= "\231\171\158\230\139\141\232\181\132\233\135\145\228\184\141\232\182\179\239\188\154%s (x%d)\227\128\130";
		FrmtSkippedAuctionWithHigherBid	= "\229\191\189\231\149\165\230\155\180\233\171\152\229\135\186\228\187\183\231\154\132\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";
		FrmtSkippedAuctionWithLowerBid	= "\229\191\189\231\149\165\230\155\180\228\189\142\229\135\186\228\187\183\231\154\132\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";
		FrmtSkippedBiddingOnOwnAuction	= "\229\191\189\231\149\165\229\175\185\232\135\170\232\186\171\230\139\141\229\141\150\231\154\132\229\135\186\228\187\183\239\188\154%s (x%d)\227\128\130";
		UiProcessingBidRequests	= "\229\135\186\228\187\183\232\175\183\230\177\130\229\164\132\231\144\134\228\184\173...";


		-- Section: Command Messages
		FrmtActClearall	= "\230\184\133\233\153\164%s\231\154\132\229\133\168\233\131\168\230\139\141\229\141\150\230\149\176\230\141\174\227\128\130";
		FrmtActClearFail	= "\230\151\160\230\179\149\230\137\190\229\136\176\231\137\169\229\147\129:%s\227\128\130";
		FrmtActClearOk	= "%s\231\154\132\230\149\176\230\141\174\229\183\178\230\184\133\233\153\164\227\128\130";
		FrmtActClearsnap	= "\230\184\133\233\153\164\229\189\147\229\137\141\230\139\141\229\141\150\232\161\140\230\177\135\230\128\187\227\128\130";
		FrmtActDefault	= "\230\139\141\229\141\150\229\138\169\230\137\139\233\128\137\233\161\185%s\229\183\178\233\135\141\231\189\174\228\184\186\233\187\152\232\174\164\232\174\190\231\189\174\227\128\130";
		FrmtActDefaultall	= "\229\133\168\233\131\168\230\139\141\229\141\150\229\138\169\230\137\139\233\128\137\233\161\185\229\183\178\233\135\141\231\189\174\228\184\186\233\187\152\232\174\164\232\174\190\231\189\174\227\128\130";
		FrmtActDisable	= "\233\154\144\232\151\143\231\137\169\229\147\129%s\231\154\132\230\149\176\230\141\174\227\128\130";
		FrmtActEnable	= "\230\152\190\231\164\186\231\137\169\229\147\129%s\231\154\132\230\149\176\230\141\174\227\128\130";
		FrmtActSet	= "\232\174\190\231\189\174%s\228\184\186'%s'\227\128\130";
		FrmtActUnknown	= "\230\156\170\231\159\165\229\145\189\228\187\164\230\136\150\229\133\179\233\148\174\229\173\151\239\188\154'%s'\227\128\130";
		FrmtAuctionDuration	= "\233\187\152\232\174\164\230\139\141\229\141\150\230\151\182\233\153\144\232\174\190\231\189\174\228\184\186\239\188\154%s\227\128\130";
		FrmtAutostart	= "\232\135\170\229\138\168\229\188\128\229\167\139\230\139\141\229\141\150\239\188\154\230\156\128\228\189\142\228\187\183%s\239\188\140\228\184\128\229\143\163\228\187\183%s(%d\229\176\143\230\151\182)%s\227\128\130";
		FrmtFinish	= "\230\137\171\230\143\143\229\174\140\230\136\144\228\185\139\229\144\142\239\188\140\229\176\134%s\227\128\130";
		FrmtPrintin	= "\230\139\141\229\141\150\229\138\169\230\137\139\232\174\175\230\129\175\231\142\176\229\156\168\229\176\134\230\152\190\231\164\186\229\156\168'%s'\229\175\185\232\175\157\230\161\134\228\184\173\227\128\130";
		FrmtProtectWindow	= "\230\139\141\229\141\150\232\161\140\231\170\151\229\143\163\228\191\157\230\138\164\232\174\190\228\184\186\239\188\154%s\227\128\130";
		FrmtUnknownArg	= "\229\175\185'%s'\232\128\140\232\168\128\239\188\140'%s'\230\152\175\230\151\160\230\149\136\229\128\188\227\128\130";
		FrmtUnknownLocale	= "\228\189\160\230\140\135\229\174\154\231\154\132\229\156\176\229\159\159\228\187\163\231\160\129('%s')\230\156\170\231\159\165\227\128\130\230\156\137\230\149\136\231\154\132\229\156\176\229\159\159\228\187\163\231\160\129\228\184\186\239\188\154";
		FrmtUnknownRf	= "\233\148\153\232\175\175\231\154\132\230\149\176\230\141\174('%s')\239\188\154\230\173\163\231\161\174\231\154\132\230\160\188\229\188\143\228\184\186\239\188\154[\230\156\141\229\138\161\229\153\168\229\144\141]-[\233\152\181\232\144\165]\239\188\140\229\133\182\228\184\173\233\152\181\232\144\165\228\184\186\232\139\177\230\150\135(\232\129\148\231\155\159-Alliance\239\188\140\233\131\168\232\144\189-Horde)\227\128\130\228\190\139\229\166\130\239\188\154\230\179\176\229\133\176\229\190\183-Alliance\227\128\130";


		-- Section: Command Options
		OptAlso	= "(\230\156\141\229\138\161\229\153\168\229\144\141-\233\152\181\232\144\165|opposite\229\175\185\231\171\139)";
		OptAuctionDuration	= "(last\230\156\128\231\187\136||2h\229\176\143\230\151\182||8h\229\176\143\230\151\182||24h\229\176\143\230\151\182)";
		OptBidbroker	= "<\233\147\182\229\184\129\232\174\161\229\136\169\230\182\166>";
		OptBidLimit	= "<\230\149\176\231\155\174>";
		OptBroker	= "<\233\147\182\229\184\129\232\174\161\229\136\169\230\182\166>";
		OptClear	= "([\231\137\169\229\147\129]|all\229\133\168\233\131\168|snapshot\230\177\135\230\128\187)";
		OptCompete	= "<\233\147\182\229\184\129\232\174\161\229\183\174\233\162\157>";
		OptDefault	= "(<\233\128\137\233\161\185>|all\229\133\168\233\131\168)";
		OptFinish	= "(off\229\133\179\233\151\173||logout\230\179\168\233\148\128||exit\233\128\128\229\135\186)";
		OptLocale	= "<\229\156\176\229\159\159\228\187\163\231\160\129>";
		OptPctBidmarkdown	= "<\230\175\148\231\142\135>";
		OptPctMarkup	= "<\230\175\148\231\142\135>";
		OptPctMaxless	= "<\230\175\148\231\142\135>";
		OptPctNocomp	= "<\230\175\148\231\142\135>";
		OptPctUnderlow	= "<\230\175\148\231\142\135>";
		OptPctUndermkt	= "<\230\175\148\231\142\135>";
		OptPercentless	= "<\230\175\148\231\142\135>";
		OptPrintin	= "(<\231\170\151\229\143\163\230\160\135\231\173\190>[\230\149\176\229\173\151]|<\231\170\151\229\143\163\229\144\141\231\167\176>[\229\173\151\231\172\166\228\184\178])";
		OptProtectWindow	= "(never\228\187\142\228\184\141|scan\230\137\171\230\143\143|always\230\128\187\230\152\175)";
		OptScale	= "<\230\175\148\228\190\139\231\179\187\230\149\176>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "also\232\128\140\228\184\148";
		CmdAlsoOpposite	= "opposite\229\175\185\231\171\139";
		CmdAlt	= "Alt";
		CmdAskPriceAd	= "ad\229\144\175\228\186\139";
		CmdAskPriceGuild	= "guild\229\133\172\228\188\154";
		CmdAskPriceParty	= "party\233\152\159\228\188\141";
		CmdAskPriceSmart	= "smart\231\129\181\230\180\187";
		CmdAskPriceSmartWord1	= "what\228\187\128\228\185\136";
		CmdAskPriceSmartWord2	= "worth\229\128\188\233\146\177";
		CmdAskPriceTrigger	= "trigger\232\167\166\229\143\145\229\153\168";
		CmdAskPriceVendor	= "vendor\229\149\134\232\180\169";
		CmdAskPriceWhispers	= "whispers \229\175\134\232\175\173";
		CmdAskPriceWord	= "word";
		CmdAuctionClick	= "auction-click\230\139\141\229\141\150\231\130\185\229\135\187";
		CmdAuctionDuration	= "auction-duration\230\139\141\229\141\150\230\151\182\233\153\144";
		CmdAuctionDuration0	= "last\230\156\128\232\191\145";
		CmdAuctionDuration1	= "2h\229\176\143\230\151\182";
		CmdAuctionDuration2	= "8h\229\176\143\230\151\182";
		CmdAuctionDuration3	= "24h\229\176\143\230\151\182";
		CmdAutofill	= "autofill\232\135\170\229\138\168\229\161\171\228\187\183";
		CmdBidbroker	= "bidbroker\229\135\186\228\187\183\228\187\163\231\144\134";
		CmdBidbrokerShort	= "bb(\229\135\186\228\187\183\228\187\163\231\144\134\231\154\132\231\188\169\229\134\153)";
		CmdBidLimit	= "bid-limit\231\171\158\230\139\141\233\153\144\230\149\176";
		CmdBroker	= "broker\228\187\163\231\144\134";
		CmdClear	= "clear\230\184\133\233\153\164";
		CmdClearAll	= "all\229\133\168\233\131\168";
		CmdClearSnapshot	= "snapshot\230\177\135\230\128\187";
		CmdCompete	= "compete\231\171\158\229\141\150";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "default\233\187\152\232\174\164";
		CmdDisable	= "disable\231\166\129\231\148\168";
		CmdEmbed	= "embed\229\181\140\229\133\165";
		CmdFinish	= "finish\229\174\140\230\136\144";
		CmdFinish0	= "off\229\133\179\233\151\173";
		CmdFinish1	= "logout\230\179\168\233\148\128";
		CmdFinish2	= "exit\233\128\128\229\135\186";
		CmdFinish3	= "reloadui\233\135\141\230\150\176\229\138\160\232\189\189\231\148\168\230\136\183\231\149\140\233\157\162";
		CmdFinishSound	= "finish-sound\229\174\140\230\136\144\230\146\173\230\148\190\229\163\176\233\159\179";
		CmdHelp	= "help\229\184\174\229\138\169";
		CmdLocale	= "locale\229\156\176\229\159\159\228\187\163\231\160\129";
		CmdOff	= "off\229\133\179";
		CmdOn	= "on\229\188\128";
		CmdPctBidmarkdown	= "pct-bidmarkdown\232\181\183\228\187\183\233\153\141\228\189\142\230\175\148\231\142\135";
		CmdPctMarkup	= "pct-markup\230\182\168\228\187\183\230\175\148\231\142\135";
		CmdPctMaxless	= "pct-maxless\230\156\128\229\164\167\229\137\138\228\187\183\230\175\148\231\142\135";
		CmdPctNocomp	= "pct-nocomp\230\151\160\231\171\158\228\187\183\230\175\148\231\142\135";
		CmdPctUnderlow	= "pct-underlow\230\156\128\228\189\142\228\187\183\230\175\148\231\142\135";
		CmdPctUndermkt	= "pct-undermkt\229\184\130\229\156\186\228\187\183\229\142\139\228\189\142\230\175\148\231\142\135";
		CmdPercentless	= "percentless\230\175\148\231\142\135\229\183\174\233\162\157";
		CmdPercentlessShort	= "pl(\230\175\148\231\142\135\229\183\174\233\162\157\231\154\132\231\188\169\229\134\153)";
		CmdPrintin	= "print-in\232\190\147\229\135\186";
		CmdProtectWindow	= "protect-window\228\191\157\230\138\164\231\170\151\229\143\163";
		CmdProtectWindow0	= "never\228\187\142\228\184\141";
		CmdProtectWindow1	= "scan\230\137\171\230\143\143";
		CmdProtectWindow2	= "always\230\128\187\230\152\175";
		CmdScan	= "scan\230\137\171\230\143\143";
		CmdShift	= "Shift";
		CmdToggle	= "toggle\229\188\128\229\133\179\232\189\172\230\141\162";
		CmdUpdatePrice	= "update-price\230\155\180\230\150\176\228\187\183\230\160\188";
		CmdWarnColor	= "warn-color\232\173\166\231\164\186\232\137\178";
		ShowAverage	= "show-average\230\152\190\231\164\186\229\157\135\229\128\188";
		ShowEmbedBlank	= "show-embed-blankline\230\152\190\231\164\186\229\181\140\229\133\165\231\169\186\232\161\140";
		ShowLink	= "show-link\230\152\190\231\164\186\233\147\190\230\142\165";
		ShowMedian	= "show-median\230\152\190\231\164\186\228\184\173\229\128\188";
		ShowRedo	= "show-warning\230\152\190\231\164\186\232\173\166\229\145\138";
		ShowStats	= "show-stats\230\152\190\231\164\186\231\187\159\232\174\161";
		ShowSuggest	= "show-suggest\230\152\190\231\164\186\229\187\186\232\174\174";
		ShowVerbose	= "show-verbose\230\152\190\231\164\186\231\187\134\232\138\130";


		-- Section: Config Text
		GuiAlso	= "\229\144\140\230\151\182\230\152\190\231\164\186\230\149\176\230\141\174";
		GuiAlsoDisplay	= "\230\152\190\231\164\186%s\231\154\132\230\149\176\230\141\174";
		GuiAlsoOff	= "\228\184\141\229\134\141\230\152\190\231\164\186\229\133\182\228\187\150\230\156\141\229\138\161\229\153\168-\233\152\181\232\144\165\231\154\132\230\149\176\230\141\174\227\128\130";
		GuiAlsoOpposite	= "\229\144\140\230\151\182\230\152\190\231\164\186\229\175\185\231\171\139\233\152\181\232\144\165\231\154\132\230\149\176\230\141\174\227\128\130";
		GuiAskPrice	= "\229\144\175\231\148\168\232\175\162\228\187\183";
		GuiAskPriceAd	= "\229\143\145\233\128\129\231\137\185\232\137\178\229\144\175\228\186\139";
		GuiAskPriceGuild	= "\229\147\141\229\186\148\229\133\172\228\188\154\233\162\145\233\129\147\230\159\165\232\175\162";
		GuiAskPriceHeader	= "\232\175\162\228\187\183\233\128\137\233\161\185";
		GuiAskPriceHeaderHelp	= "\230\155\180\230\148\185\232\175\162\228\187\183\230\150\185\229\188\143";
		GuiAskPriceParty	= "\229\147\141\229\186\148\233\152\159\228\188\141\233\162\145\233\129\147\230\159\165\232\175\162";
		GuiAskPriceSmart	= "\228\189\191\231\148\168\230\153\186\232\131\189\229\173\151";
		GuiAskPriceTrigger	= "\232\175\162\228\187\183\232\167\166\229\143\145\229\153\168";
		GuiAskPriceVendor	= "\229\143\145\233\128\129\229\149\134\232\180\169\228\191\161\230\129\175";
		GuiAskPriceWhispers	= "\230\152\190\231\164\186\229\183\178\229\143\145\233\128\129\229\175\134\232\175\173";
		GuiAskPriceWord	= "\232\135\170\229\174\154\228\185\137\230\153\186\232\131\189\229\133\179\233\148\174\229\173\151 %d";
		GuiAuctionDuration	= "\233\187\152\232\174\164\230\139\141\229\141\150\230\151\182\233\153\144";
		GuiAuctionHouseHeader	= "\230\139\141\229\141\150\232\161\140\231\170\151\229\143\163";
		GuiAuctionHouseHeaderHelp	= "\230\155\180\230\148\185\230\139\141\229\141\150\232\161\140\231\170\151\229\143\163\230\150\185\229\188\143";
		GuiAutofill	= "\230\139\141\229\141\150\232\161\140\228\184\173\232\135\170\229\138\168\229\161\171\228\187\183";
		GuiAverages	= "\230\152\190\231\164\186\229\185\179\229\157\135\228\187\183\230\160\188";
		GuiBidmarkdown	= "\231\171\158\230\139\141\229\135\143\228\187\183\230\175\148\231\142\135";
		GuiClearall	= "\230\184\133\233\153\164\229\133\168\233\131\168\230\139\141\229\141\150\229\138\169\230\137\139\230\149\176\230\141\174";
		GuiClearallButton	= "\230\184\133\233\153\164\229\133\168\233\131\168";
		GuiClearallHelp	= "\231\130\185\230\173\164\230\184\133\233\153\164\229\189\147\229\137\141\230\156\141\229\138\161\229\153\168\230\139\141\229\141\150\229\138\169\230\137\139\231\154\132\229\133\168\233\131\168\230\149\176\230\141\174\227\128\130";
		GuiClearallNote	= "\229\175\185\228\186\142\229\189\147\229\137\141\230\156\141\229\138\161\229\153\168-\233\152\181\232\144\165";
		GuiClearHeader	= "\230\184\133\233\153\164\230\149\176\230\141\174";
		GuiClearHelp	= "\230\184\133\233\153\164\230\139\141\229\141\150\229\138\169\230\137\139\230\149\176\230\141\174\227\128\130\233\128\137\230\139\169\230\184\133\233\153\164\229\133\168\233\131\168\230\149\176\230\141\174\230\136\150\229\189\147\229\137\141\230\177\135\230\128\187\230\149\176\230\141\174\227\128\130\232\173\166\229\145\138\239\188\154\232\191\153\228\186\155\230\147\141\228\189\156\230\151\160\230\179\149\232\191\152\229\142\159\227\128\130";
		GuiClearsnap	= "\230\184\133\233\153\164\230\177\135\230\128\187\230\149\176\230\141\174";
		GuiClearsnapButton	= "\230\184\133\233\153\164\230\177\135\230\128\187";
		GuiClearsnapHelp	= "\231\130\185\230\173\164\230\184\133\233\153\164\228\184\138\230\172\161\230\139\141\229\141\150\229\138\169\230\137\139\230\177\135\230\128\187\230\149\176\230\141\174\227\128\130";
		GuiDefaultAll	= "\233\135\141\231\189\174\229\133\168\233\131\168\230\139\141\229\141\150\229\138\169\230\137\139\233\128\137\233\161\185";
		GuiDefaultAllButton	= "\233\135\141\231\189\174\229\133\168\233\131\168";
		GuiDefaultAllHelp	= "\231\130\185\229\135\187\230\129\162\229\164\141\230\139\141\229\141\150\229\138\169\230\137\139\230\137\128\230\156\137\233\128\137\233\161\185\228\184\186\233\187\152\232\174\164\229\128\188\227\128\130\232\173\166\229\145\138\239\188\154\232\191\153\228\186\155\230\147\141\228\189\156\230\151\160\230\179\149\232\191\152\229\142\159\227\128\130";
		GuiDefaultOption	= "\233\135\141\231\189\174\232\191\153\233\161\185\232\174\190\231\189\174";
		GuiEmbed	= "\229\181\140\229\133\165\228\191\161\230\129\175\229\136\176\230\184\184\230\136\143\230\143\144\231\164\186\228\184\173";
		GuiEmbedBlankline	= "\229\156\168\230\184\184\230\136\143\230\143\144\231\164\186\228\184\173\230\152\190\231\164\186\231\169\186\232\161\140";
		GuiEmbedHeader	= "\229\181\140\229\133\165";
		GuiFinish	= "\229\189\147\230\137\171\230\143\143\229\174\140\230\136\144\229\144\142";
		GuiFinishSound	= "\230\137\171\230\143\143\229\174\140\230\136\144\229\144\142\230\146\173\230\148\190\229\163\176\230\149\136";
		GuiLink	= "\230\152\190\231\164\186\233\147\190\230\142\165\230\160\135\232\175\134";
		GuiLoad	= "\229\138\160\232\189\189\230\139\141\229\141\150\229\138\169\230\137\139";
		GuiLoad_Always	= "\230\128\187\230\152\175";
		GuiLoad_AuctionHouse	= "\229\156\168\230\139\141\229\141\150\232\161\140";
		GuiLoad_Never	= "\228\187\142\228\184\141";
		GuiLocale	= "\232\174\190\231\189\174\229\156\176\229\159\159\228\187\163\231\160\129\228\184\186";
		GuiMainEnable	= "\229\144\175\231\148\168\230\139\141\229\141\150\229\138\169\230\137\139";
		GuiMainHelp	= "\229\140\133\229\144\171\230\143\146\228\187\182 - \230\139\141\229\141\150\229\138\169\230\137\139\231\154\132\232\174\190\231\189\174\227\128\130\229\174\131\231\148\168\228\186\142\230\152\190\231\164\186\231\137\169\229\147\129\228\191\161\230\129\175\239\188\140\229\185\182\229\136\134\230\158\144\230\139\141\229\141\150\230\149\176\230\141\174\227\128\130\229\156\168\230\139\141\229\141\150\232\161\140\231\130\185\229\135\187\"\230\137\171\230\143\143\"\230\140\137\233\146\174\230\157\165\230\148\182\233\155\134\230\139\141\229\141\150\230\149\176\230\141\174\227\128\130";
		GuiMarkup	= "\229\149\134\232\180\169\228\187\183\230\182\168\229\185\133\230\175\148\231\142\135";
		GuiMaxless	= "\229\184\130\229\156\186\228\187\183\230\156\128\229\164\167\229\137\138\229\135\143\230\175\148\231\142\135";
		GuiMedian	= "\230\152\190\231\164\186\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188";
		GuiNocomp	= "\230\151\160\231\171\158\230\139\141\229\137\138\228\187\183\230\175\148\231\142\135";
		GuiNoWorldMap	= "\230\139\141\229\141\150\229\138\169\230\137\139\239\188\154\233\152\178\230\173\162\230\152\190\231\164\186\228\184\150\231\149\140\229\156\176\229\155\190";
		GuiOtherHeader	= "\229\133\182\228\187\150\233\128\137\233\161\185";
		GuiOtherHelp	= "\230\139\141\229\141\150\229\138\169\230\137\139\230\157\130\233\161\185";
		GuiPercentsHeader	= "\230\139\141\229\141\150\229\138\169\230\137\139\230\158\129\233\153\144\230\175\148\231\142\135";
		GuiPercentsHelp	= "\232\173\166\229\145\138\239\188\154\228\184\139\229\136\151\232\174\190\231\189\174\228\187\133\233\128\130\229\144\136\228\186\142\233\171\152\231\186\167\231\148\168\230\136\183\227\128\130\232\176\131\230\149\180\228\184\139\229\136\151\230\149\176\229\128\188\228\187\165\230\148\185\229\143\152\230\139\141\229\141\150\229\138\169\230\137\139\229\136\164\229\174\154\230\148\182\231\155\138\230\176\180\229\185\179\231\154\132\229\138\155\229\186\166\227\128\130";
		GuiPrintin	= "\233\128\137\230\139\169\230\156\159\230\156\155\231\154\132\232\174\175\230\129\175\231\170\151\229\143\163\227\128\130";
		GuiProtectWindow	= "\233\152\178\230\173\162\230\132\143\229\164\150\229\133\179\233\151\173\230\139\141\229\141\150\232\161\140\231\170\151\229\143\163\227\128\130";
		GuiRedo	= "\230\152\190\231\164\186\233\149\191\230\151\182\233\151\180\230\144\156\231\180\162\232\173\166\229\145\138\227\128\130";
		GuiReloadui	= "\233\135\141\230\150\176\229\138\160\232\189\189\231\148\168\230\136\183\231\149\140\233\157\162\227\128\130";
		GuiReloaduiButton	= "\233\135\141\232\189\189UI ";
		GuiReloaduiFeedback	= "\231\142\176\229\156\168\230\173\163\233\135\141\230\150\176\229\138\160\232\189\189\233\173\148\229\133\189\231\148\168\230\136\183\231\149\140\233\157\162\227\128\130";
		GuiReloaduiHelp	= "\229\156\168\230\148\185\229\143\152\229\156\176\229\159\159\228\187\163\231\160\129\229\144\142\231\130\185\230\173\164\233\135\141\230\150\176\229\138\160\232\189\189\233\173\148\229\133\189\231\148\168\230\136\183\231\149\140\233\157\162\228\189\191\230\173\164\233\133\141\231\189\174\229\177\143\229\185\149\228\184\173\231\154\132\232\175\173\232\168\128\229\140\185\233\133\141\233\128\137\230\139\169\227\128\130\230\179\168\230\132\143\239\188\154\230\173\164\230\147\141\228\189\156\229\143\175\232\131\189\232\128\151\230\151\182\229\135\160\229\136\134\233\146\159\227\128\130";
		GuiRememberText	= "\232\174\176\228\189\143\228\187\183\230\160\188";
		GuiStatsEnable	= "\230\152\190\231\164\186\231\187\159\232\174\161";
		GuiStatsHeader	= "\231\137\169\229\147\129\228\187\183\230\160\188\231\187\159\232\174\161";
		GuiStatsHelp	= "\229\156\168\230\143\144\231\164\186\228\184\173\230\152\190\231\164\186\228\184\139\229\136\151\231\187\159\232\174\161\228\191\161\230\129\175";
		GuiSuggest	= "\230\152\190\231\164\186\229\187\186\232\174\174\228\187\183\230\160\188";
		GuiUnderlow	= "\230\156\128\228\189\142\230\139\141\229\141\150\229\137\138\228\187\183\230\175\148\231\142\135";
		GuiUndermkt	= "\230\156\128\229\164\167\229\185\133\233\153\141\228\187\183\230\151\182\229\137\138\229\135\143\229\184\130\229\156\186\228\187\183\230\175\148\231\142\135";
		GuiVerbose	= "\232\175\166\231\187\134\230\168\161\229\188\143";
		GuiWarnColor	= "\229\189\169\232\137\178\230\160\135\228\187\183\230\168\161\229\188\143";


		-- Section: Conversion Messages
		MesgConvert	= "\230\139\141\229\141\150\229\138\169\230\137\139\230\149\176\230\141\174\229\186\147\232\189\172\230\141\162\227\128\130\232\175\183\229\133\136\229\164\135\228\187\189\228\189\160\231\154\132SavedVariables\Auctioneer.lua\230\150\135\228\187\182\227\128\130%s%s";
		MesgConvertNo	= "\231\166\129\231\148\168\230\139\141\229\141\150\229\138\169\230\137\139";
		MesgConvertYes	= "\232\189\172\230\141\162";
		MesgNotconverting	= "\230\139\141\229\141\150\229\138\169\230\137\139\230\156\170\232\189\172\230\141\162\228\189\160\231\154\132\230\149\176\230\141\174\229\186\147\239\188\140\228\189\134\229\174\140\230\136\144\228\185\139\229\137\141\229\176\134\229\129\156\230\173\162\229\183\165\228\189\156\227\128\130";


		-- Section: Game Constants
		TimeLong	= "\233\149\191";
		TimeMed	= "\228\184\173";
		TimeShort	= "\231\159\173";
		TimeVlong	= "\233\157\158\229\184\184\233\149\191";


		-- Section: Generic Messages
		DisableMsg	= "\231\166\129\230\173\162\232\135\170\229\138\168\229\138\160\232\189\189\230\139\141\229\141\150\229\138\169\230\137\139\227\128\130";
		FrmtWelcome	= "\230\139\141\229\141\150\229\138\169\230\137\139(Auctioneer) v%s\229\183\178\229\138\160\232\189\189\239\188\129";
		MesgNotLoaded	= "\230\139\141\229\141\150\229\138\169\230\137\139(Auctioneer)\230\156\170\229\138\160\232\189\189\227\128\130\233\148\174\229\133\165/auctioneer\230\156\137\230\155\180\229\164\154\228\191\161\230\129\175\227\128\130";
		StatAskPriceOff	= "\232\175\162\228\187\183\231\155\174\229\137\141\232\162\171\231\166\129\231\148\168\227\128\130";
		StatAskPriceOn	= "\232\175\162\228\187\183\231\155\174\229\137\141\232\162\171\229\144\175\231\148\168\227\128\130";
		StatOff	= "\228\184\141\230\152\190\231\164\186\228\187\187\228\189\149\230\139\141\229\141\150\230\149\176\230\141\174\227\128\130";
		StatOn	= "\230\152\190\231\164\186\232\174\190\229\174\154\231\154\132\230\139\141\229\141\150\230\149\176\230\141\174\227\128\130";


		-- Section: Generic Strings
		TextAuction	= "\230\139\141\229\141\150";
		TextCombat	= "\230\136\152\230\150\151";
		TextGeneral	= "\229\184\184\232\167\132";
		TextNone	= "\230\151\160";
		TextScan	= "\230\137\171\230\143\143";
		TextUsage	= "\231\148\168\233\128\148\239\188\154";


		-- Section: Help Text
		HelpAlso	= "\230\143\144\231\164\186\228\184\173\230\152\190\231\164\186\229\133\182\228\187\150\230\156\141\229\138\161\229\153\168\228\184\138\231\154\132\228\187\183\230\160\188\227\128\130\232\190\147\229\133\165[\230\156\141\229\138\161\229\153\168\229\144\141]-[\233\152\181\232\144\165]\239\188\140\229\133\182\228\184\173\233\152\181\232\144\165\228\184\186\232\139\177\230\150\135(\232\129\148\231\155\159-Alliance\239\188\140\233\131\168\232\144\189-Horde)\227\128\130\228\190\139\229\166\130\239\188\154\"/auctioneer also \230\179\176\229\133\176\229\190\183-Alliance\"\227\128\130\231\137\185\229\174\154\231\154\132\229\133\179\233\148\174\229\173\151\239\188\154\"opposite\"\230\152\175\230\140\135\229\175\185\231\171\139\233\152\181\232\144\165\239\188\140\"off\"\231\166\129\231\148\168\232\175\165\229\138\159\232\131\189\227\128\130";
		HelpAskPrice	= "\229\144\175\231\148\168\230\136\150\231\166\129\231\148\168\232\175\162\228\187\183\227\128\130";
		HelpAskPriceAd	= "\229\144\175\231\148\168\230\136\150\231\166\129\231\148\168\230\150\176\231\154\132\232\175\162\228\187\183\231\137\185\232\137\178\229\144\175\228\186\139\227\128\130";
		HelpAskPriceGuild	= "\229\147\141\229\186\148\229\133\172\228\188\154\233\162\145\233\129\147\228\184\173\231\154\132\230\159\165\232\175\162\227\128\130";
		HelpAskPriceParty	= "\229\147\141\229\186\148\233\152\159\228\188\141\233\162\145\233\129\147\228\184\173\231\154\132\230\159\165\232\175\162\227\128\130";
		HelpAskPriceSmart	= "\229\144\175\231\148\168\230\136\150\231\166\129\231\148\168\230\153\186\232\131\189\229\173\151\230\163\128\230\159\165\227\128\130";
		HelpAskPriceTrigger	= "\230\155\180\230\148\185\232\175\162\228\187\183\232\167\166\229\143\145\229\153\168\231\137\185\230\128\167\227\128\130";
		HelpAskPriceVendor	= "\229\144\175\231\148\168\230\136\150\231\166\129\231\148\168\229\143\145\233\128\129\229\149\134\232\180\169\229\174\154\228\187\183\230\149\176\230\141\174\227\128\130";
		HelpAskPriceWhispers	= "\233\154\144\232\151\143\230\136\150\230\152\190\231\164\186\230\137\128\230\156\137\232\175\162\228\187\183\229\164\150\229\143\145\229\175\134\232\175\173";
		HelpAskPriceWord	= "\229\162\158\229\138\160\230\136\150\228\191\174\230\148\185\232\175\162\228\187\183\232\135\170\229\174\154\228\185\137\230\153\186\232\131\189\229\133\179\233\148\174\229\173\151";
		HelpAuctionClick	= "\229\133\129\232\174\184\228\189\160Alt\231\130\185\229\135\187\232\131\140\229\140\133\228\184\173\231\154\132\231\137\169\229\147\129\230\157\165\232\135\170\229\138\168\229\188\128\229\167\139\230\139\141\229\141\150\227\128\130";
		HelpAuctionDuration	= "\232\174\190\231\189\174\230\137\147\229\188\128\230\139\141\229\141\150\232\161\140\231\149\140\233\157\162\228\184\138\231\154\132\233\187\152\232\174\164\230\139\141\229\141\150\230\151\182\233\153\144\227\128\130";
		HelpAutofill	= "\232\174\190\231\189\174\229\144\145\230\139\141\229\141\150\232\161\140\231\170\151\229\143\163\229\138\160\229\133\165\230\150\176\230\139\141\229\141\150\231\137\169\229\147\129\230\151\182\230\152\175\229\144\166\232\135\170\229\138\168\229\161\171\228\187\183\227\128\130";
		HelpAverage	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132\229\185\179\229\157\135\230\139\141\229\141\150\228\187\183\230\160\188\227\128\130";
		HelpBidbroker	= "\230\152\190\231\164\186\230\156\128\232\191\145\230\137\171\230\143\143\228\184\173\229\143\175\229\186\148\230\139\141\232\142\183\229\136\169\231\154\132\228\184\173\231\159\173\230\156\159\230\139\141\229\141\150\227\128\130";
		HelpBidLimit	= "\229\189\147\229\156\168\230\144\156\231\180\162\230\139\141\229\141\150\233\161\181\233\157\162\228\184\138\231\130\185\229\135\187\231\171\158\230\139\141\230\136\150\228\184\128\229\143\163\228\187\183\230\140\137\233\146\174\230\151\182\239\188\140\229\135\186\228\187\183\230\136\150\228\184\128\229\143\163\228\187\183\229\186\148\230\139\141\231\154\132\230\156\128\229\164\167\230\149\176\231\155\174\227\128\130";
		HelpBroker	= "\230\152\190\231\164\186\230\156\128\232\191\145\230\137\171\230\143\143\228\184\173\228\187\187\228\189\149\229\143\175\229\186\148\230\139\141\229\185\182\232\189\172\230\137\139\232\142\183\229\136\169\231\154\132\230\139\141\229\141\150\227\128\130";
		HelpClear	= "\230\184\133\233\153\164\230\140\135\229\174\154\231\154\132\231\137\169\229\147\129\230\149\176\230\141\174(\228\189\160\229\191\133\233\161\187\231\148\168Shift+\231\130\185\229\135\187\230\138\138\229\147\129\229\144\141\230\143\146\229\133\165\229\145\189\228\187\164\228\184\173)\227\128\130\228\189\160\228\185\159\229\143\175\228\187\165\230\140\135\229\174\154\229\133\179\233\148\174\229\173\151\"all\"\230\136\150\"snapshot\"\227\128\130";
		HelpCompete	= "\230\152\190\231\164\186\230\156\128\232\191\145\230\137\171\230\143\143\228\184\173\228\187\187\228\189\149\230\175\148\228\189\160\231\154\132\228\184\128\229\143\163\228\187\183\228\189\142\231\154\132\230\139\141\229\141\150\227\128\130";
		HelpDefault	= "\232\174\190\231\189\174\228\184\128\228\184\170\230\139\141\229\141\150\229\138\169\230\137\139\233\128\137\233\161\185\228\184\186\229\133\182\233\187\152\232\174\164\229\128\188,\228\189\160\228\185\159\229\143\175\228\187\165\230\140\135\229\174\154\231\137\185\230\174\138\229\133\179\233\148\174\229\173\151\"all\"\230\157\165\233\135\141\231\189\174\229\133\168\233\131\168\230\139\141\229\141\150\229\138\169\230\137\139\233\128\137\233\161\185\228\184\186\229\133\182\233\187\152\232\174\164\229\128\188\227\128\130";
		HelpDisable	= "\233\152\187\230\173\162\230\139\141\229\141\150\229\138\169\230\137\139\229\156\168\228\184\139\230\172\161\231\153\187\229\189\149\230\151\182\232\135\170\229\138\168\229\138\160\232\189\189\227\128\130";
		HelpEmbed	= "\229\181\140\229\133\165\230\150\135\229\173\151\229\136\176\230\184\184\230\136\143\233\187\152\232\174\164\230\143\144\231\164\186\228\184\173(\230\179\168\230\132\143\239\188\154\230\159\144\228\186\155\231\137\185\230\128\167\229\156\168\232\175\165\230\168\161\229\188\143\228\184\139\228\184\141\229\143\175\231\148\168)\227\128\130";
		HelpEmbedBlank	= "\233\128\137\230\139\169\229\189\147\229\181\140\229\133\165\230\168\161\229\188\143\229\144\175\231\148\168\230\151\182\230\152\175\229\144\166\229\156\168\230\143\144\231\164\186\228\191\161\230\129\175\229\146\140\230\139\141\229\141\150\232\161\140\228\191\161\230\129\175\228\184\173\230\143\146\229\133\165\231\169\186\232\161\140\227\128\130";
		HelpFinish	= "\232\174\190\231\189\174\230\139\141\229\141\150\232\161\140\230\137\171\230\143\143\229\174\140\230\136\144\229\144\142\230\152\175\229\144\166\232\135\170\229\138\168\230\179\168\233\148\128\230\136\150\233\128\128\229\135\186\230\184\184\230\136\143\227\128\130";
		HelpFinishSound	= "\232\174\190\231\189\174\230\152\175\229\144\166\229\156\168\230\139\141\229\141\150\232\161\140\230\137\171\230\143\143\229\174\140\230\136\144\229\144\142\230\146\173\230\148\190\229\163\176\230\149\136";
		HelpLink	= "\233\128\137\230\139\169\230\152\175\229\144\166\229\156\168\230\143\144\231\164\186\228\184\173\230\152\190\231\164\186\233\147\190\230\142\165\230\160\135\232\175\134\227\128\130";
		HelpLoad	= "\230\148\185\229\143\152\230\139\141\229\141\150\229\138\169\230\137\139\229\175\185\232\191\153\228\184\170\232\167\146\232\137\178\231\154\132\229\138\160\232\189\189\232\174\190\231\189\174\227\128\130";
		HelpLocale	= "\230\148\185\229\143\152\231\148\168\228\186\142\230\152\190\231\164\186\230\139\141\229\141\150\229\138\169\230\137\139\232\174\175\230\129\175\231\154\132\232\175\173\232\168\128\232\174\190\231\189\174\227\128\130";
		HelpMedian	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188\227\128\130";
		HelpOnoff	= "\230\137\147\229\188\128/\229\133\179\233\151\173\230\139\141\229\141\150\232\161\140\230\149\176\230\141\174\230\152\190\231\164\186\227\128\130";
		HelpPctBidmarkdown	= "\232\174\190\231\189\174\230\139\141\229\141\150\229\138\169\230\137\139\231\148\177\228\184\128\229\143\163\228\187\183\229\137\138\229\135\143\229\135\186\228\187\183\231\154\132\230\175\148\231\142\135\227\128\130";
		HelpPctMarkup	= "\229\189\147\230\178\161\230\156\137\229\143\175\229\143\130\232\128\131\228\187\183\230\160\188\230\151\182\230\140\137\229\149\134\232\180\169\228\187\183\230\182\168\229\185\133\230\175\148\231\142\135\227\128\130";
		HelpPctMaxless	= "\232\174\190\231\189\174\230\139\141\229\141\150\229\138\169\230\137\139\230\148\190\229\188\131\230\139\141\229\141\150\228\185\139\229\137\141\229\137\138\229\135\143\229\184\130\229\156\186\228\187\183\231\154\132\230\156\128\229\164\167\230\175\148\231\142\135\227\128\130";
		HelpPctNocomp	= "\232\174\190\231\189\174\230\151\160\231\171\158\230\139\141\230\151\182\230\139\141\229\141\150\229\138\169\230\137\139\229\137\138\229\135\143\229\184\130\229\156\186\228\187\183\231\154\132\230\175\148\231\142\135\227\128\130";
		HelpPctUnderlow	= "\232\174\190\231\189\174\230\139\141\229\141\150\229\138\169\230\137\139\229\137\138\229\135\143\230\156\128\228\189\142\230\139\141\229\141\150\228\187\183\230\160\188\231\154\132\230\175\148\231\142\135\227\128\130";
		HelpPctUndermkt	= "\229\189\147\230\151\160\230\179\149\229\135\187\232\180\165\231\171\158\229\141\150\229\175\185\230\137\139\230\151\182\229\137\138\229\135\143\229\184\130\229\156\186\228\187\183\231\154\132\230\175\148\231\142\135(\230\156\159\232\135\179\230\156\128\229\164\167\229\137\138\228\187\183\230\175\148\231\142\135)\227\128\130";
		HelpPercentless	= "\230\152\190\231\164\186\230\156\128\232\191\145\230\137\171\230\143\143\232\191\135\230\137\128\230\156\137\228\184\128\229\143\163\228\187\183\228\189\142\228\186\142\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\231\161\174\229\174\154\230\175\148\231\142\135\231\154\132\230\139\141\229\141\150\227\128\130";
		HelpPrintin	= "\233\128\137\230\139\169\230\139\141\229\141\150\229\138\169\230\137\139\232\174\175\230\129\175\229\176\134\230\152\190\231\164\186\229\156\168\229\147\170\228\184\170\231\170\151\229\143\163\227\128\130\229\143\175\228\187\165\230\140\135\229\174\154\231\170\151\229\143\163\229\144\141\231\167\176\230\136\150\231\180\162\229\188\149\227\128\130";
		HelpProtectWindow	= "\233\152\178\230\173\162\230\132\143\229\164\150\229\133\179\233\151\173\230\139\141\229\141\150\232\161\140\231\149\140\233\157\162\227\128\130";
		HelpRedo	= "\233\128\137\230\139\169\229\189\147\230\156\141\229\138\161\229\153\168\229\187\182\232\191\159\229\175\188\232\135\180\229\189\147\229\137\141\230\144\156\231\180\162\231\154\132\230\139\141\229\141\150\232\161\140\233\161\181\233\157\162\229\183\178\232\128\151\230\151\182\229\164\170\233\149\191\230\151\182\230\152\175\229\144\166\230\152\190\231\164\186\232\173\166\229\145\138\227\128\130";
		HelpScan	= "\228\184\139\230\172\161\233\153\141\228\184\180\230\136\150\233\169\187\232\182\179\230\139\141\229\141\150\232\161\140\230\151\182\230\137\167\232\161\140\230\137\171\230\143\143(\230\139\141\229\141\150\232\161\140\233\157\162\230\157\191\228\184\138\228\185\159\230\156\137\228\184\128\228\184\170\230\137\171\230\143\143\230\140\137\233\146\174)\227\128\130\229\139\190\233\128\137\230\131\179\232\166\129\230\137\171\230\143\143\231\154\132\231\167\141\231\177\187\227\128\130";
		HelpStats	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132\228\187\165\231\171\158\230\139\141\228\187\183/\228\184\128\229\143\163\228\187\183\230\136\144\228\186\164\231\154\132\230\175\148\231\142\135\227\128\130";
		HelpSuggest	= "\233\128\137\230\139\169\230\152\175\229\144\166\230\152\190\231\164\186\231\137\169\229\147\129\231\154\132\229\187\186\232\174\174\230\139\141\229\141\150\228\187\183\230\160\188\227\128\130";
		HelpUpdatePrice	= "\229\189\147\228\184\128\229\143\163\228\187\183\230\148\185\229\143\152\230\151\182\239\188\140\232\135\170\229\138\168\230\155\180\230\150\176\230\139\141\229\141\150\229\147\129\229\156\168\229\143\145\229\184\131\230\139\141\229\141\150\233\161\181\233\157\162\228\184\138\231\154\132\232\181\183\230\139\141\228\187\183\227\128\130";
		HelpVerbose	= "\233\128\137\230\139\169\230\152\175\229\144\166\232\175\166\231\187\134\230\152\190\231\164\186\229\185\179\229\157\135\229\146\140\229\187\186\232\174\174\228\187\183\230\160\188(\229\133\179\233\151\173\229\136\153\230\152\190\231\164\186\228\186\142\229\141\149\232\161\140)\227\128\130";
		HelpWarnColor	= "\233\128\137\230\139\169\230\152\175\229\144\166\231\148\168\231\155\180\232\167\130\231\154\132\233\162\156\232\137\178\232\161\168\231\164\186\230\139\141\229\141\150\232\161\140\230\160\135\228\187\183\230\168\161\229\188\143\227\128\130";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "\230\151\160\232\131\140\229\140\133\231\169\186\233\151\180\231\148\168\228\186\142\230\150\176\229\187\186\230\139\141\229\141\150\239\188\129";
		FrmtNotEnoughOfItem	= "\230\151\160\232\182\179\229\164\159%s\231\148\168\228\186\142\230\150\176\229\187\186\230\139\141\229\141\150\239\188\129";
		FrmtPostedAuction	= "\229\183\178\229\143\145\229\184\1311\228\187\182\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";
		FrmtPostedAuctions	= "\229\183\178\229\143\145\229\184\131%d\228\187\182\230\139\141\229\141\150\239\188\154%s (x%d)\227\128\130";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\229\189\147\229\137\141\229\135\186\228\187\183";
		FrmtBidbrokerDone	= "\228\186\164\230\152\147\228\187\183\228\187\163\231\144\134\229\174\140\230\136\144\227\128\130";
		FrmtBidbrokerHeader	= "\230\156\128\228\189\142\229\136\169\230\182\166\239\188\154%s\239\188\140\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183='\230\155\190\232\167\129\228\186\142\230\139\141\229\141\150\232\161\140\228\184\173\231\154\132\230\156\128\233\171\152\228\187\183\230\160\188'";
		FrmtBidbrokerLine	= "%s\239\188\140\230\156\128\232\191\145\229\135\186\231\142\176%s\230\172\161\239\188\140\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\239\188\154%s\239\188\140%s\239\188\154%s\239\188\140\229\136\169\230\182\166\239\188\154%s\239\188\140\230\172\161\230\149\176\239\188\154%s";
		FrmtBidbrokerMinbid	= "\230\156\128\228\189\142\229\135\186\228\187\183";
		FrmtBrokerDone	= "\228\187\163\231\144\134\229\174\140\230\136\144\227\128\130";
		FrmtBrokerHeader	= "\230\156\128\228\189\142\229\136\169\230\182\166\239\188\154%s\239\188\140\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183='\230\155\190\232\167\129\228\186\142\230\139\141\229\141\150\232\161\140\228\184\173\231\154\132\230\156\128\233\171\152\228\187\183\230\160\188'";
		FrmtBrokerLine	= "%s\239\188\140\230\156\128\232\191\145\229\135\186\231\142\176%s\230\172\161\239\188\140\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\239\188\154%s\239\188\140\228\184\128\229\143\163\228\187\183\239\188\154%s\239\188\140\229\136\169\230\182\166\239\188\154%s";
		FrmtCompeteDone	= "\231\171\158\230\139\141\229\174\140\230\136\144\227\128\130";
		FrmtCompeteHeader	= "\231\171\158\230\139\141\230\156\128\229\176\145\230\175\143\233\161\185\229\137\138\229\135\143%s\227\128\130";
		FrmtCompeteLine	= "%s\239\188\140\231\171\158\230\139\141\228\187\183\239\188\154%s\239\188\140\228\184\128\229\143\163\228\187\183%s vs %s\239\188\140\229\183\174\233\162\157%s";
		FrmtHspLine	= "\230\175\143\228\187\182%s\231\154\132\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\228\184\186\239\188\154%s";
		FrmtLowLine	= "%s\239\188\140\228\184\128\229\143\163\228\187\183\239\188\154%s\239\188\140\229\135\186\229\148\174\232\128\133\239\188\154%s\239\188\140\229\141\149\228\187\183\239\188\154%s\239\188\140\228\189\142\228\186\142\228\184\173\229\128\188:%s";
		FrmtMedianLine	= "\230\156\128\232\191\145\229\135\186\231\142\176%d\230\172\161\239\188\140\230\175\143\228\187\182%s\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188\228\184\186\239\188\154%s";
		FrmtNoauct	= "\231\137\169\229\147\129\239\188\154%s\230\178\161\230\156\137\230\139\141\229\141\150\232\174\176\229\189\149";
		FrmtPctlessDone	= "\230\175\148\231\142\135\229\183\174\233\162\157\229\174\140\230\136\144\227\128\130";
		FrmtPctlessHeader	= "\228\189\142\228\186\142\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\230\175\148\231\142\135\239\188\154%d%%";
		FrmtPctlessLine	= "%s\239\188\140\230\156\128\232\191\145\229\135\186\231\142\176%d\230\172\161\239\188\140\230\156\128\233\171\152\230\155\190\229\148\174\228\187\183\239\188\154%s\239\188\140\228\184\128\229\143\163\228\187\183\239\188\154%s\239\188\140\229\136\169\230\182\166\239\188\154%s\239\188\140\229\183\174\233\162\157%s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "\229\136\160\233\153\164\232\191\135\230\156\159\230\139\141\229\141\150\239\188\154%s\233\161\185";
		AuctionDiscrepancies	= "\229\135\186\229\133\165\228\185\139\229\164\132\239\188\154%s\233\161\185";
		AuctionNewAucts	= "\230\137\171\230\143\143\230\150\176\229\162\158\230\139\141\229\141\150\239\188\154%s\233\161\185";
		AuctionOldAucts	= "\228\185\139\229\137\141\229\183\178\230\137\171\230\143\143\239\188\154%s\233\161\185";
		AuctionPageN	= "\230\139\141\229\141\150\229\138\169\230\137\139\239\188\154\230\173\163\230\137\171\230\143\143%s\n\231\172\172%d\233\161\181 \229\133\177%d\233\161\181 %s\233\161\185/\231\167\146\n\228\188\176\232\174\161\229\137\169\228\189\153\230\151\182\233\151\180: %s";
		AuctionScanDone	= "\230\139\141\229\141\150\229\138\169\230\137\139\239\188\154\230\139\141\229\141\150\230\137\171\230\143\143\229\174\140\230\175\149\227\128\130";
		AuctionScanNexttime	= "\230\139\141\229\141\150\229\138\169\230\137\139\229\176\134\229\156\168\228\184\139\230\172\161\228\184\142\230\139\141\229\141\150\229\145\152\229\175\185\232\175\157\230\151\182\232\191\155\232\161\140\229\174\140\229\133\168\230\137\171\230\143\143\227\128\130";
		AuctionScanNocat	= "\229\191\133\233\161\187\232\135\179\229\176\145\233\128\137\230\139\169\228\184\128\231\177\187\232\191\155\232\161\140\230\137\171\230\143\143\227\128\130";
		AuctionScanRedo	= "\229\189\147\229\137\141\233\161\181\233\156\128\232\166\129\229\164\154\228\186\142%d\231\167\146\230\137\141\232\131\189\229\174\140\230\136\144\239\188\140\230\173\163\233\135\141\232\175\149\233\161\181\233\157\162\227\128\130";
		AuctionScanStart	= "\230\139\141\229\141\150\229\138\169\230\137\139\239\188\154\230\173\163\230\137\171\230\143\143%s\n\231\172\1721\233\161\181...";
		AuctionTotalAucts	= "\229\183\178\230\137\171\230\143\143\229\133\168\233\131\168\230\139\141\229\141\150\239\188\154%s\233\161\185";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "\229\135\186\231\142\176\232\191\135%d\230\172\161\228\186\142%s";
		FrmtInfoAverage	= "\230\156\128\228\189\142\228\187\183%s/\228\184\128\229\143\163\228\187\183%s(\231\171\158\230\139\141\228\187\183%s)";
		FrmtInfoBidMulti	= "\231\171\158\230\139\141\228\187\183(%s\230\175\143\228\187\182%s)";
		FrmtInfoBidOne	= "\231\171\158\230\139\141\228\187\183%s";
		FrmtInfoBidrate	= "\231\171\158\230\139\141\228\187\183%d%%,\228\184\128\229\143\163\228\187\183%d%%";
		FrmtInfoBuymedian	= "\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188";
		FrmtInfoBuyMulti	= "\228\184\128\229\143\163\228\187\183(%s\230\175\143\228\187\182%s)";
		FrmtInfoBuyOne	= "\228\184\128\229\143\163\228\187\183%s";
		FrmtInfoForone	= "\230\175\143\228\187\182:\230\156\128\228\189\142\228\187\183%s/\228\184\128\229\143\163\228\187\183%s(\231\171\158\230\139\141\228\187\183%s)[%d\228\187\182]";
		FrmtInfoHeadMulti	= "%d\228\187\182\231\137\169\229\147\129\229\185\179\229\157\135:";
		FrmtInfoHeadOne	= "\232\175\165\231\137\169\229\147\129\229\185\179\229\157\135:";
		FrmtInfoHistmed	= "\228\185\139\229\137\141\230\156\137%d\230\172\161,\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188(\230\175\143\228\187\182)";
		FrmtInfoMinMulti	= "\232\181\183\230\139\141\228\187\183(\230\175\143\228\187\182%s)";
		FrmtInfoMinOne	= "\232\181\183\230\139\141\228\187\183";
		FrmtInfoNever	= "\228\187\142\230\156\170\229\156\168%s\229\135\186\231\142\176\232\191\135";
		FrmtInfoSeen	= "\230\139\141\229\141\150\229\144\136\232\174\161\229\135\186\231\142\176\232\191\135%d\230\172\161";
		FrmtInfoSgst	= "\229\187\186\232\174\174\228\187\183\230\160\188:\230\156\128\228\189\142\228\187\183%s/\228\184\128\229\143\163\228\187\183%s";
		FrmtInfoSgststx	= "\229\175\185\228\186\142\229\160\134\229\143\160%d\228\187\182\231\154\132\229\187\186\232\174\174\228\187\183\230\160\188:\230\156\128\228\189\142\228\187\183%s/\228\184\128\229\143\163\228\187\183%s";
		FrmtInfoSnapmed	= "\230\137\171\230\143\143\229\136\176%d\230\172\161,\228\184\128\229\143\163\228\187\183\228\184\173\229\128\188(\230\175\143\228\187\182)";
		FrmtInfoStacksize	= "\229\185\179\229\157\135\229\160\134\229\143\160\230\149\176\233\135\143:%d\228\187\182";


		-- Section: User Interface
		FrmtLastSoldOn	= "\230\156\128\231\187\136\228\187\165%s\229\148\174\229\135\186";
		UiBid	= "\231\171\158\230\160\135";
		UiBidHeader	= "\229\135\186\228\187\183";
		UiBidPerHeader	= "\229\141\149\228\187\182\229\135\186\228\187\183";
		UiBuyout	= "\228\184\128\229\143\163\228\187\183";
		UiBuyoutHeader	= "\228\184\128\229\143\163\228\187\183";
		UiBuyoutPerHeader	= "\228\184\128\229\143\163\229\141\149\228\187\183";
		UiBuyoutPriceLabel	= "\228\184\128\229\143\163\228\187\183\239\188\154";
		UiBuyoutPriceTooLowError	= "(\232\191\135\228\189\142)";
		UiCategoryLabel	= "\231\167\141\231\177\187\233\153\144\229\136\182";
		UiDepositLabel	= "\228\191\157\231\174\161\232\180\185\239\188\154";
		UiDurationLabel	= "\230\139\141\229\141\150\230\151\182\233\153\144\239\188\154";
		UiItemLevelHeader	= "\231\173\137\231\186\167";
		UiMakeFixedPriceLabel	= "\229\189\162\230\136\144\229\155\186\229\174\154\228\187\183\230\160\188";
		UiMaxError	= "(\230\156\128\229\164\154%d\228\187\182)";
		UiMaximumPriceLabel	= "\230\156\128\233\171\152\228\187\183\230\160\188";
		UiMaximumTimeLeftLabel	= "\230\156\128\229\164\154\229\137\169\228\189\153\230\151\182\233\151\180\239\188\154";
		UiMinimumPercentLessLabel	= "\230\156\128\229\176\143\230\175\148\231\142\135\229\183\174\233\162\157\239\188\154";
		UiMinimumProfitLabel	= "\230\156\128\228\189\142\229\136\169\230\182\166\239\188\154";
		UiMinimumQualityLabel	= "\230\156\128\228\189\142\229\147\129\232\180\168\239\188\154";
		UiMinimumUndercutLabel	= "\230\156\128\228\189\142\229\137\138\228\187\183\239\188\154";
		UiNameHeader	= "\229\144\141\231\167\176";
		UiNoPendingBids	= "\229\133\168\233\131\168\231\171\158\230\160\135\232\175\183\230\177\130\229\174\140\230\136\144\239\188\129";
		UiNotEnoughError	= "(\228\184\141\229\164\159)";
		UiPendingBidInProgress	= "1\228\187\182\231\171\158\230\139\141\232\175\183\230\177\130\230\173\163\229\156\168\232\191\155\232\161\140...";
		UiPendingBidsInProgress	= "%d\228\187\182\231\171\158\230\139\141\232\175\183\230\177\130\230\173\163\229\156\168\232\191\155\232\161\140...";
		UiPercentLessHeader	= "\230\175\148\231\142\135";
		UiPost	= "\229\143\145\229\184\131\229\164\132";
		UiPostAuctions	= "\229\143\145\229\184\131\230\139\141\229\141\150";
		UiPriceBasedOnLabel	= "\230\160\135\228\187\183\229\159\186\228\186\142\239\188\154";
		UiPriceModelAuctioneer	= "\230\139\141\229\141\150\229\138\169\230\137\139\230\160\135\228\187\183";
		UiPriceModelCustom	= "\232\135\170\229\174\154\228\187\183\230\160\188";
		UiPriceModelFixed	= "\229\155\186\229\174\154\228\187\183\230\160\188";
		UiPriceModelLastSold	= "\230\156\128\231\187\136\229\148\174\228\187\183";
		UiProfitHeader	= "\229\136\169\230\182\166";
		UiProfitPerHeader	= "\229\141\149\228\187\182\229\136\169\230\182\166";
		UiQuantityHeader	= "\230\149\176\233\135\143";
		UiQuantityLabel	= "\230\149\176\233\135\143\239\188\154";
		UiRemoveSearchButton	= "\229\136\160\233\153\164";
		UiSavedSearchLabel	= "\231\142\176\230\156\137\230\144\156\231\180\162\239\188\154";
		UiSaveSearchButton	= "\228\191\157\229\173\152";
		UiSaveSearchLabel	= "\228\191\157\229\173\152\230\173\164\230\172\161\230\144\156\231\180\162";
		UiSearch	= "\230\144\156\231\180\162";
		UiSearchAuctions	= "\230\144\156\231\180\162\230\139\141\229\141\150";
		UiSearchDropDownLabel	= "\230\144\156\231\180\162";
		UiSearchForLabel	= "\230\144\156\231\180\162\231\137\169\229\147\129";
		UiSearchTypeBids	= "\229\135\186\228\187\183";
		UiSearchTypeBuyouts	= "\228\184\128\229\143\163\228\187\183";
		UiSearchTypeCompetition	= "\231\171\158\229\141\150";
		UiSearchTypePlain	= "\231\137\169\229\147\129";
		UiStacksLabel	= "\229\160\134\229\143\160";
		UiStackTooBigError	= "(\229\160\134\229\143\160\229\164\170\229\164\154)";
		UiStackTooSmallError	= "(\229\160\134\229\143\160\229\164\170\229\176\145)";
		UiStartingPriceLabel	= "\232\181\183\230\139\141\228\187\183\239\188\154";
		UiStartingPriceRequiredError	= "(\229\191\133\232\166\129\231\154\132)";
		UiTimeLeftHeader	= "\229\137\169\228\189\153\230\151\182\233\151\180";
		UiUnknownError	= "(\230\156\170\231\159\165)";

	};

	zhTW = {


		-- Section: AskPrice Messages
		AskPriceAd	= "\229\190\151\229\136\176\230\175\143\231\150\138\229\131\185\230\160\188: %sx[ItemLink ] (x = stacksize)\n";
		FrmtAskPriceBuyoutMedianHistorical	= "%s\230\173\183\228\190\134\229\185\179\229\157\135\229\148\174\229\135\186\229\131\185: %s%s";
		FrmtAskPriceBuyoutMedianSnapshot	= "%s\228\184\138\230\172\161\230\142\131\231\158\132\229\185\179\229\157\135\229\148\174\229\135\186\229\131\185: %s%s";
		FrmtAskPriceDisable	= "\231\166\129\231\148\168\232\169\162\229\131\185\233\129\184\233\160\133:%s";
		FrmtAskPriceEach	= "%s \230\175\143\228\187\182";
		FrmtAskPriceEnable	= "\229\149\159\231\148\168\232\169\162\229\131\185\233\129\184\233\160\133:%s";
		FrmtAskPriceVendorPrice	= "%sNPC\229\155\158\230\148\182\229\131\185: %s%s";


		-- Section: Auction Messages
		FrmtActRemove	= "\229\190\158\231\155\174\229\137\141\230\139\141\232\179\163\229\160\180\229\191\171\231\133\167\228\184\173\231\167\187\233\153\164 %s\227\128\130";
		FrmtAuctinfoHist	= "%d \232\161\140\232\168\152\233\140\132";
		FrmtAuctinfoLow	= "\229\131\185\230\160\188\228\189\142\230\150\188\228\184\138\230\172\161\230\142\131\230\143\143";
		FrmtAuctinfoMktprice	= "\229\184\130\229\160\180\229\131\185";
		FrmtAuctinfoNolow	= "\230\156\170\229\156\168\228\184\138\230\172\161\230\142\131\230\143\143\231\153\188\231\143\190\232\169\178\231\137\169\229\147\129";
		FrmtAuctinfoOrig	= "\232\181\183\230\168\153\229\131\185";
		FrmtAuctinfoSnap	= "%d \228\184\138\230\172\161\230\142\131\230\143\143";
		FrmtAuctinfoSugbid	= "\229\187\186\232\173\176\232\181\183\230\168\153\229\131\185";
		FrmtAuctinfoSugbuy	= "\229\187\186\232\173\176\231\155\180\232\179\188\229\131\185";
		FrmtWarnAbovemkt	= "\229\131\185\230\160\188\230\175\148\229\184\130\229\160\180\229\131\185\233\171\152";
		FrmtWarnMarkup	= "\229\174\154\229\131\185\230\175\148\229\149\134\229\186\151\233\171\152 %s%%";
		FrmtWarnMyprice	= "\228\189\191\231\148\168\230\173\164\231\149\182\229\137\141\229\131\185\230\160\188";
		FrmtWarnNocomp	= "\231\132\161\228\186\186\231\171\182\229\131\185";
		FrmtWarnNodata	= "\230\178\146\230\156\137\230\156\128\233\171\152\229\148\174\229\131\185\230\160\188\230\149\184\230\147\154";
		FrmtWarnToolow	= "\228\189\142\230\150\188\229\184\130\233\157\162\228\184\138\230\156\128\228\189\142\229\131\185";
		FrmtWarnUndercut	= "\229\137\138\230\184\155\229\131\185\230\160\188 %s%%";
		FrmtWarnUser	= "\230\142\161\231\148\168\232\135\170\232\168\130\229\131\185\230\160\188";


		-- Section: Bid Messages
		FrmtAlreadyHighBidder	= "\229\183\178\231\182\147\230\152\175\230\156\128\233\171\152\229\135\186\229\131\185\232\128\133: %s (x%d) ";
		FrmtBidAuction	= "\228\184\139\230\168\153\239\188\154\239\188\133s (x%d)";
		FrmtBidQueueOutOfSync	= "\233\140\175\232\170\164\239\188\154\230\168\153\229\131\185\230\142\146\231\168\139\229\183\178\233\157\158\229\144\140\230\173\165";
		FrmtBoughtAuction	= "\231\155\180\230\142\165\232\179\188\232\178\183\239\188\154\239\188\133s (x%d)";
		FrmtMaxBidsReached	= "\230\137\190\229\136\176\230\155\180\229\164\154\230\139\141\232\179\163\233\160\133\231\155\174:%s (x%d), \228\189\134\230\152\175\229\183\178\231\182\147\229\136\176\233\129\148\230\159\165\232\169\162\230\149\184\233\135\143\233\153\144\229\136\182(%d)";
		FrmtNoAuctionsFound	= "\230\156\170\230\137\190\229\136\176\230\139\141\232\179\163\239\188\154%s (x%d)";
		FrmtNoMoreAuctionsFound	= "\230\137\190\228\184\141\229\136\176\230\150\176\231\154\132\230\139\141\232\179\163\233\160\133\231\155\174:%s (x%d) ";
		FrmtNotEnoughMoney	= "\233\140\162\228\184\141\229\164\160\230\168\153\230\139\141\232\179\163\239\188\154%s (x%d) ";
		FrmtSkippedAuctionWithHigherBid	= "\229\191\189\231\149\165\233\171\152\230\168\153\229\131\185\231\154\132\230\139\141\232\179\163\239\188\154%s (x%d) ";
		FrmtSkippedAuctionWithLowerBid	= "\229\191\189\231\149\165\228\189\142\230\168\153\229\131\185\231\154\132\230\139\141\232\179\163\239\188\154%s (x%d) ";
		FrmtSkippedBiddingOnOwnAuction	= "\229\191\189\231\149\165\228\184\139\230\168\153\232\135\170\229\183\177\231\154\132\230\139\141\232\179\163\239\188\154%s (x%d)";
		UiProcessingBidRequests	= "\233\128\178\232\161\140\228\184\139\230\168\153\232\166\129\230\177\130\228\184\173\239\188\142\239\188\142\239\188\142";


		-- Section: Command Messages
		FrmtActClearall	= "\230\184\133\233\153\164\230\137\128\230\156\137%s\232\179\135\230\150\153";
		FrmtActClearFail	= "\230\156\170\230\137\190\229\136\176\239\188\154%s";
		FrmtActClearOk	= "\230\184\133\233\153\164\230\137\128\230\156\137\239\188\154%s\231\154\132\232\179\135\230\150\153";
		FrmtActClearsnap	= "\230\184\133\233\153\164\231\155\174\229\137\141\230\142\131\231\158\132\231\154\132\231\181\144\230\158\156\229\191\171\231\133\167";
		FrmtActDefault	= "\230\139\141\232\179\163\229\138\169\230\137\139\233\129\184\233\160\133 %s \229\183\178\233\135\141\231\189\174\231\130\186\233\160\144\232\168\173\229\128\188";
		FrmtActDefaultall	= "\233\135\141\231\189\174\230\137\128\230\156\137\232\168\173\229\174\154\231\130\186\233\160\144\232\168\173\229\128\188\227\128\130";
		FrmtActDisable	= "\233\154\177\232\151\143\231\137\169\229\147\129 %s \231\154\132\232\179\135\230\150\153";
		FrmtActEnable	= "\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132 %s \231\154\132\232\179\135\230\150\153";
		FrmtActSet	= "\232\168\173\229\174\154 %s \231\130\186 '%s'";
		FrmtActUnknown	= "\231\132\161\230\149\136\229\145\189\228\187\164\230\136\150\233\151\156\233\141\181\229\173\151\239\188\154'%s'";
		FrmtAuctionDuration	= "\233\160\144\232\168\173\230\139\141\232\179\163\230\153\130\233\150\147\232\168\173\229\174\154\231\130\186\239\188\154%s";
		FrmtAutostart	= "\232\135\170\229\139\149\230\139\141\232\179\163\233\150\139\229\167\139\239\188\154\232\181\183\230\168\153\229\131\185 %s ,\231\155\180\232\179\188\229\131\185 %s (%dh)%s";
		FrmtFinish	= "\229\156\168\230\142\131\230\143\143\229\174\140\230\136\144\228\186\134\228\185\139\229\190\140, \230\136\145\230\131\179%s";
		FrmtPrintin	= "\230\139\141\232\179\163\229\138\169\230\137\139\231\154\132\232\168\138\230\129\175\229\176\135\233\161\175\231\164\186\229\156\168\"%s\"\229\176\141\232\169\177\230\161\134\228\184\173";
		FrmtProtectWindow	= "\230\139\141\232\179\163\232\161\140\232\166\150\231\170\151\228\191\157\232\173\183\232\168\173\229\174\154\231\130\186\239\188\154%s";
		FrmtUnknownArg	= "\229\176\141'%s'\232\128\140\232\168\128,'%s'\230\152\175\231\132\161\230\149\136\229\128\188";
		FrmtUnknownLocale	= "\230\130\168\230\140\135\229\174\154\231\154\132\232\170\158\232\168\128('%s')\231\132\161\230\179\149\232\190\168\232\173\152\227\128\130\231\155\174\229\137\141\230\148\175\230\143\180\231\154\132\232\170\158\232\168\128\231\137\136\230\156\172\231\130\186\239\188\154";
		FrmtUnknownRf	= "\233\140\175\232\170\164\231\154\132\230\149\184\230\147\154 ('%s').\230\173\163\231\162\186\231\154\132\230\160\188\229\188\143\231\130\186\239\188\154[\228\188\186\230\156\141\229\153\168]-[\233\153\163\231\135\159]\239\188\140\228\190\139\229\166\130\239\188\154\229\184\131\232\152\173\229\141\161\229\190\183-\232\129\175\231\155\159.";


		-- Section: Command Options
		OptAlso	= "(\228\188\186\230\156\141\229\153\168-\232\129\175\231\155\159|\233\131\168\232\144\189|opposite(\230\149\181\229\176\141\233\153\163\231\135\159))";
		OptAuctionDuration	= "(last(\228\184\138\230\172\161)|2h(2\229\176\143\230\153\130)|8h(8\229\176\143\230\153\130)|24h(24\229\176\143\230\153\130))";
		OptBidbroker	= "<\229\143\175\229\190\151\229\136\169\230\189\164>";
		OptBidLimit	= "<\230\149\184\233\135\143>";
		OptBroker	= "<\229\143\175\229\190\151\229\136\169\230\189\164>";
		OptClear	= "([\231\137\169\229\147\129\229\144\141\231\168\177]|all(\229\133\168\233\131\168)|snapshot(\229\191\171\231\133\167))";
		OptCompete	= "<\230\144\141\229\164\177\229\136\169\230\189\164>";
		OptDefault	= "(<\231\137\185\229\174\154\233\129\184\233\160\133>|all(\229\133\168\233\131\168))";
		OptFinish	= "(off(\233\151\156\233\150\137)||logout(\231\153\187\229\135\186)||exit(\233\155\162\233\150\139))";
		OptLocale	= "<\232\170\158\232\168\128>";
		OptPctBidmarkdown	= "<\231\153\190\229\136\134\230\175\148>";
		OptPctMarkup	= "<\231\153\190\229\136\134\230\175\148>";
		OptPctMaxless	= "<\231\153\190\229\136\134\230\175\148>";
		OptPctNocomp	= "<\231\153\190\229\136\134\230\175\148>";
		OptPctUnderlow	= "<\239\188\133>";
		OptPctUndermkt	= "<\239\188\133>";
		OptPercentless	= "<\239\188\133>";
		OptPrintin	= "(<frameIndex>[Number]|<frameName>[String])";
		OptProtectWindow	= "(never(\231\181\149\228\184\141)||scan(\230\142\131\231\158\132\230\153\130)||always(\231\184\189\230\152\175))";
		OptScale	= "<\230\175\148\228\190\139\228\191\130\230\149\184>";
		OptScan	= "<>";


		-- Section: Commands
		CmdAlso	= "also";
		CmdAlsoOpposite	= "opposite";
		CmdAlt	= "alt";
		CmdAskPriceAd	= "ad";
		CmdAskPriceGuild	= "guild";
		CmdAskPriceParty	= "party";
		CmdAskPriceSmart	= "smart";
		CmdAskPriceSmartWord1	= "what";
		CmdAskPriceSmartWord2	= "worth";
		CmdAskPriceTrigger	= "trigger";
		CmdAskPriceVendor	= "vendor";
		CmdAskPriceWhispers	= "whispers";
		CmdAskPriceWord	= "word";
		CmdAuctionClick	= "auction-click";
		CmdAuctionDuration	= "auction-duration";
		CmdAuctionDuration0	= "last";
		CmdAuctionDuration1	= "2h";
		CmdAuctionDuration2	= "8h";
		CmdAuctionDuration3	= "24h";
		CmdAutofill	= "autofill";
		CmdBidbroker	= "bidbroker";
		CmdBidbrokerShort	= "bb";
		CmdBidLimit	= "bid-limit";
		CmdBroker	= "broker";
		CmdClear	= "clear";
		CmdClearAll	= "all";
		CmdClearSnapshot	= "snapshot";
		CmdCompete	= "compete";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "default";
		CmdDisable	= "disable";
		CmdEmbed	= "embed";
		CmdFinish	= "finish";
		CmdFinish0	= "off";
		CmdFinish1	= "logout";
		CmdFinish2	= "exit";
		CmdFinish3	= "reloadui";
		CmdFinishSound	= "finish-sound";
		CmdHelp	= "help";
		CmdLocale	= "locale";
		CmdOff	= "off";
		CmdOn	= "on";
		CmdPctBidmarkdown	= "pct-bidmarkdown";
		CmdPctMarkup	= "pct-markup";
		CmdPctMaxless	= "pct-maxless";
		CmdPctNocomp	= "pct-nocomp";
		CmdPctUnderlow	= "pct-underlow";
		CmdPctUndermkt	= "pct-undermkt";
		CmdPercentless	= "percentless";
		CmdPercentlessShort	= "pl";
		CmdPrintin	= "print-in";
		CmdProtectWindow	= "protect-window";
		CmdProtectWindow0	= "never";
		CmdProtectWindow1	= "scan";
		CmdProtectWindow2	= "always";
		CmdScan	= "scan";
		CmdShift	= "Shift";
		CmdToggle	= "toggle";
		CmdUpdatePrice	= "update-price";
		CmdWarnColor	= "warn-color";
		ShowAverage	= "show-average";
		ShowEmbedBlank	= "show-embed-blankline";
		ShowLink	= "show-link";
		ShowMedian	= "show-median";
		ShowRedo	= "show-stats";
		ShowStats	= "show-stats";
		ShowSuggest	= "show-suggest";
		ShowVerbose	= "show-verbose";


		-- Section: Config Text
		GuiAlso	= "\231\184\189\230\152\175\233\161\175\231\164\186\232\179\135\230\150\153";
		GuiAlsoDisplay	= "\233\161\175\231\164\186 %s \231\154\132\232\179\135\230\150\153";
		GuiAlsoOff	= "\228\184\141\229\134\141\233\161\175\231\164\186\229\133\182\228\187\150\228\188\186\230\156\141\229\153\168-\233\153\163\231\135\159\231\154\132\232\179\135\230\150\153\227\128\130";
		GuiAlsoOpposite	= "\229\144\140\230\153\130\233\161\175\231\164\186\230\149\181\231\171\139\233\153\163\231\135\159\231\154\132\230\149\184\230\147\154\227\128\130";
		GuiAskPrice	= "\229\149\159\229\139\149\232\169\162\229\131\185\229\138\159\232\131\189";
		GuiAskPriceAd	= "\231\153\188\233\128\129\230\150\176\229\138\159\232\131\189\229\187\163\229\145\138";
		GuiAskPriceGuild	= "\229\155\158\230\135\137\229\156\152\233\154\138\233\160\187\233\129\147\231\154\132\232\169\162\229\131\185";
		GuiAskPriceHeader	= "\232\169\162\229\131\185\233\129\184\233\160\133";
		GuiAskPriceHeaderHelp	= "\232\174\138\230\155\180\232\169\162\229\131\185\229\138\159\232\131\189\230\168\161\229\188\143";
		GuiAskPriceParty	= "\229\155\158\230\135\137\233\154\138\228\188\141\233\160\187\233\129\147\231\154\132\232\169\162\229\131\185";
		GuiAskPriceSmart	= "\228\189\191\231\148\168\230\153\186\230\133\167\232\167\184\231\153\188\229\173\151\229\133\131(smartwords)\n";
		GuiAskPriceTrigger	= "\232\169\162\229\131\185(AskPrice)\232\167\184\231\153\188\229\153\168\n";
		GuiAskPriceVendor	= "\233\128\129\228\190\155\230\135\137\229\149\134\228\191\161\230\129\175\n";
		GuiAskPriceWhispers	= "\233\161\175\231\164\186\233\128\129\229\135\186\231\154\132\232\128\179\232\170\158";
		GuiAskPriceWord	= "\232\135\170\232\168\130\230\153\186\230\133\167\232\167\184\231\153\188\229\173\151\229\133\131(smartwords)";
		GuiAuctionDuration	= "\233\160\144\232\168\173\230\139\141\232\179\163\230\153\130\233\150\147";
		GuiAuctionHouseHeader	= "\230\139\141\232\179\163\229\160\180\232\166\150\231\170\151";
		GuiAuctionHouseHeaderHelp	= "\230\155\180\230\148\185\230\139\141\232\179\163\229\160\180\232\166\150\231\170\151\231\139\128\230\133\139";
		GuiAutofill	= "\229\156\168\230\139\141\232\179\163\230\153\130\232\135\170\229\139\149\229\161\171\229\133\165\229\131\185\230\160\188";
		GuiAverages	= "\233\161\175\231\164\186\229\185\179\229\157\135\230\136\144\228\186\164\229\131\185\230\160\188";
		GuiBidmarkdown	= "\229\137\138\229\131\185%";
		GuiClearall	= "\230\184\133\233\153\164\230\137\128\230\156\137\230\139\141\232\179\163\229\138\169\230\137\139\232\179\135\230\150\153";
		GuiClearallButton	= "\230\184\133\233\153\164\230\137\128\230\156\137";
		GuiClearallHelp	= "\233\187\158\230\147\138\230\184\133\233\153\164\231\155\174\229\137\141\228\188\186\230\156\141\229\153\168\231\154\132\230\137\128\230\156\137\230\139\141\232\179\163\229\138\169\230\137\139\232\179\135\230\150\153";
		GuiClearallNote	= "\229\156\168\231\149\182\229\137\141\228\188\186\230\156\141\229\153\168-\233\153\163\231\135\159";
		GuiClearHeader	= "\230\184\133\233\153\164\232\179\135\230\150\153";
		GuiClearHelp	= "\230\184\133\233\153\164\230\139\141\232\179\163\229\138\169\230\137\139\230\149\184\230\147\154\227\128\130\233\129\184\230\147\135\230\184\133\233\153\164\230\137\128\230\156\137\232\179\135\230\150\153\230\136\150\231\149\182\229\137\141\229\191\171\231\133\167\227\128\130\232\173\166\229\145\138\239\188\154\233\128\153\228\186\155\230\147\141\228\189\156\231\132\161\230\179\149\233\130\132\229\142\159\227\128\130";
		GuiClearsnap	= "\230\184\133\233\153\164\231\155\174\229\137\141\229\191\171\231\133\167\232\179\135\230\150\153";
		GuiClearsnapButton	= "\230\184\133\233\153\164\229\191\171\231\133\167";
		GuiClearsnapHelp	= "\233\187\158\230\147\138\230\184\133\233\153\164\228\184\138\230\172\161\229\191\171\231\133\167\232\179\135\230\150\153.";
		GuiDefaultAll	= "\233\130\132\229\142\159\230\137\128\230\156\137\230\139\141\232\179\163\229\138\169\230\137\139\233\129\184\233\160\133";
		GuiDefaultAllButton	= "\229\133\168\233\131\168\233\135\141\231\189\174";
		GuiDefaultAllHelp	= "\233\187\158\230\147\138\233\135\141\231\189\174\230\139\141\232\179\163\229\138\169\230\137\139\230\137\128\230\156\137\233\129\184\233\160\133\231\130\186\233\160\144\232\168\173\229\128\188\227\128\130\232\173\166\229\145\138\239\188\154\233\128\153\228\186\155\230\147\141\228\189\156\231\132\161\230\179\149\233\130\132\229\142\159\227\128\130";
		GuiDefaultOption	= "\233\135\141\231\189\174\230\173\164\232\168\173\229\174\154";
		GuiEmbed	= "\229\181\140\229\133\165\228\191\161\230\129\175\229\136\176\233\129\138\230\136\178\230\143\144\231\164\186\228\184\173";
		GuiEmbedBlankline	= "\229\156\168\233\129\138\230\136\178\230\143\144\231\164\186\228\184\173\233\161\175\231\164\186\231\169\186\232\161\140";
		GuiEmbedHeader	= "\229\181\140\229\133\165";
		GuiFinish	= "\229\156\168\230\142\131\231\158\132\229\174\140\230\136\144\228\185\139\229\190\140";
		GuiFinishSound	= "\230\142\131\231\158\132\229\174\140\230\136\144\228\185\139\229\190\140\230\146\173\230\148\190\233\159\179\230\149\136";
		GuiLink	= "\233\161\175\231\164\186 LinkID";
		GuiLoad	= "\232\188\137\229\133\165\230\139\141\232\179\163\229\138\169\230\137\139";
		GuiLoad_Always	= "\231\184\189\230\152\175\232\135\170\229\139\149\232\188\137\229\133\165";
		GuiLoad_AuctionHouse	= "\229\143\170\229\156\168\230\139\141\232\179\163\229\160\180\230\153\130\232\188\137\229\133\165";
		GuiLoad_Never	= "\230\176\184\228\184\141\232\135\170\229\139\149\232\188\137\229\133\165";
		GuiLocale	= "\232\168\173\229\174\154\232\170\158\232\168\128\231\130\186";
		GuiMainEnable	= "\229\149\159\231\148\168\230\139\141\232\179\163\229\138\169\230\137\139";
		GuiMainHelp	= "\229\140\133\230\139\172\230\139\141\232\179\163\229\138\169\230\137\139\231\154\132\232\168\173\231\189\174\227\128\130\228\184\128\229\128\139\233\161\175\231\164\186\231\137\169\229\147\129\228\191\161\230\129\175\239\188\140\228\184\166\229\136\134\230\158\144\230\139\141\232\179\163\230\149\184\230\147\154\231\154\132\230\143\146\228\187\182\227\128\130\229\156\168\230\139\141\232\179\163\232\161\140\233\187\158\230\147\138\"\230\142\131\230\143\143\"\230\140\137\233\136\149\228\190\134\230\148\182\233\155\134\230\139\141\232\179\163\230\149\184\230\147\154\227\128\130";
		GuiMarkup	= "\229\149\134\229\186\151\229\131\185\230\160\188\230\175\148\228\190\139";
		GuiMaxless	= "\230\156\128\229\164\167\228\189\142\230\150\188\229\184\130\229\160\180\229\131\185\230\160\188\230\175\148\228\190\139";
		GuiMedian	= "\233\161\175\231\164\186\229\185\179\229\157\135\229\131\185";
		GuiNocomp	= "\231\132\161\228\186\186\231\171\182\230\168\153\233\153\141\229\131\185\230\175\148\228\190\139";
		GuiNoWorldMap	= "\230\139\141\232\179\163\229\138\169\230\137\139\239\188\154\230\154\171\230\153\130\231\166\129\230\173\162\233\161\175\231\164\186\228\184\150\231\149\140\229\156\176\229\156\150";
		GuiOtherHeader	= "\229\133\182\228\187\150\233\129\184\233\160\133";
		GuiOtherHelp	= "\230\139\141\232\179\163\229\138\169\230\137\139\233\155\156\233\160\133";
		GuiPercentsHeader	= "\230\139\141\232\179\163\229\138\169\230\137\139\233\150\165\229\128\188\231\153\190\229\136\134\230\175\148";
		GuiPercentsHelp	= "\232\173\166\229\145\138\239\188\154\228\184\139\229\136\151\232\168\173\231\189\174\229\131\133\233\129\169\229\144\136\233\171\152\231\180\154\231\148\168\230\136\182\227\128\130\230\148\185\232\174\138\228\184\139\229\136\151\230\149\184\229\128\188\229\176\135\230\148\185\232\174\138\230\139\141\232\179\163\229\138\169\230\137\139\229\176\141\230\148\182\231\155\138\231\154\132\229\136\164\230\150\183\227\128\130";
		GuiPrintin	= "\233\129\184\230\147\135\231\155\174\230\168\153\232\168\138\230\129\175\230\161\134\230\158\182";
		GuiProtectWindow	= "\233\152\178\230\173\162\230\132\143\229\164\150\233\151\156\233\150\137\230\139\141\232\179\163\229\160\180\232\166\150\231\170\151";
		GuiRedo	= "\233\161\175\231\164\186\230\142\131\230\143\143\230\153\130\233\150\147\233\129\142\233\149\183\231\154\132\232\173\166\229\145\138\232\168\138\230\129\175";
		GuiReloadui	= "\233\135\141\230\150\176\232\188\137\229\133\165\228\189\191\231\148\168\232\128\133\228\187\139\233\157\162(UI)";
		GuiReloaduiButton	= "\233\135\141\230\150\176\232\188\137\229\133\165UI";
		GuiReloaduiFeedback	= "\230\173\163\229\156\168\233\135\141\230\150\176\232\188\137\229\133\165\227\128\142\233\173\148\231\141\184\228\184\150\231\149\140\227\128\143UI";
		GuiReloaduiHelp	= "\233\187\158\230\147\138\233\128\153\232\163\161\228\190\134\233\135\141\230\150\176\232\188\137\229\133\165UI\228\190\134\229\165\151\231\148\168\230\150\176\231\154\132\232\170\158\232\168\128\232\168\173\231\189\174\227\128\130\230\179\168\230\132\143\239\188\154\233\128\153\229\128\139\230\147\141\228\189\156\229\143\175\232\131\189\233\156\128\232\166\129\232\188\131\233\149\183\230\153\130\233\150\147\227\128\130";
		GuiRememberText	= "\232\168\152\228\189\143\229\131\185\230\160\188";
		GuiStatsEnable	= "\233\161\175\231\164\186\231\139\128\230\133\139";
		GuiStatsHeader	= "\231\137\169\229\147\129\229\131\185\230\160\188\231\181\177\232\168\136";
		GuiStatsHelp	= "\229\156\168\230\143\144\231\164\186\228\184\173\233\161\175\231\164\186\228\184\139\229\136\151\231\181\177\232\168\136\228\191\161\230\129\175";
		GuiSuggest	= "\233\161\175\231\164\186\229\187\186\232\173\176\229\131\185\230\160\188";
		GuiUnderlow	= "\230\139\141\232\179\163\229\160\180\230\156\128\228\189\142\233\153\141\229\131\185\230\175\148\228\190\139";
		GuiUndermkt	= "\229\184\130\229\160\180\229\131\185\230\160\188\233\153\141\229\131\185\230\175\148\228\190\139";
		GuiVerbose	= "\232\169\179\231\180\176\230\168\161\229\188\143";
		GuiWarnColor	= "\229\189\169\232\137\178\230\168\153\229\131\185\230\168\161\229\188\143";


		-- Section: Conversion Messages
		MesgConvert	= "\230\139\141\232\179\163\229\138\169\230\137\139\232\179\135\230\150\153\229\186\171\232\189\137\230\143\155\227\128\130\232\171\139\229\133\136\229\130\153\228\187\189 SavedVariables\Auctioneer.lua.%s%s";
		MesgConvertNo	= "\229\129\156\231\148\168\230\139\141\232\179\163\229\138\169\230\137\139";
		MesgConvertYes	= "\232\189\137\230\143\155";
		MesgNotconverting	= "\230\130\168\231\154\132\232\179\135\230\150\153\229\186\171\229\176\154\230\156\170\231\182\147\233\129\142\232\189\137\230\143\155\230\155\180\230\150\176\239\188\140\230\130\168\229\191\133\233\160\136\232\189\137\230\143\155\232\179\135\230\150\153\229\186\171\230\137\141\232\131\189\228\189\191\231\148\168\230\139\141\232\179\163\229\138\169\230\137\139\227\128\130";


		-- Section: Game Constants
		TimeLong	= "\233\149\183";
		TimeMed	= "\228\184\173";
		TimeShort	= "\231\159\173";
		TimeVlong	= "\233\157\158\229\184\184\233\149\183";


		-- Section: Generic Messages
		DisableMsg	= "\231\166\129\230\173\162\232\135\170\229\139\149\232\188\137\229\133\165\230\139\141\232\179\163\229\138\169\230\137\139";
		FrmtWelcome	= "\230\139\141\232\179\163\229\138\169\230\137\139 v%s \229\183\178\232\188\137\229\133\165";
		MesgNotLoaded	= "\230\139\141\232\179\163\229\138\169\230\137\139\229\176\154\230\156\170\232\188\137\229\133\165\227\128\130 \232\188\184\229\133\165 /auctioneer \229\143\150\229\190\151\232\170\170\230\152\142\227\128\130";
		StatAskPriceOff	= "\232\169\162\229\131\185\229\138\159\232\131\189\233\151\156\233\150\137\227\128\130";
		StatAskPriceOn	= "\232\169\162\229\131\185\229\138\159\232\131\189\229\149\159\229\139\149\227\128\130";
		StatOff	= "\228\184\141\233\161\175\231\164\186\228\187\187\228\189\149\230\139\141\232\179\163\232\179\135\232\168\138";
		StatOn	= "\233\161\175\231\164\186\232\168\173\229\174\154\229\165\189\231\154\132\230\139\141\232\179\163\232\179\135\230\150\153";


		-- Section: Generic Strings
		TextAuction	= "\230\139\141\232\179\163";
		TextCombat	= "\230\136\176\233\172\165";
		TextGeneral	= "\228\184\128\232\136\172";
		TextNone	= "\231\132\161";
		TextScan	= "\230\142\131\230\143\143";
		TextUsage	= "\228\189\191\231\148\168\239\188\154";


		-- Section: Help Text
		HelpAlso	= "\230\143\144\231\164\186\228\184\173\233\161\175\231\164\186\229\133\182\228\187\150\228\188\186\230\156\141\229\153\168\228\184\138\231\154\132\229\131\185\230\160\188\227\128\130\228\190\139\229\166\130: \"/auctioneer also \233\152\191\232\150\169\230\150\175-\233\131\168\232\144\189\" \230\136\150\230\152\175\228\189\191\231\148\168\229\143\131\230\149\184\239\188\154opposite(\229\176\141\231\171\139\233\153\163\231\135\159), off(\233\151\156\233\150\137\229\138\159\232\131\189)";
		HelpAskPrice	= "\229\149\159\231\148\168\230\136\150\231\166\129\231\148\168\232\169\162\229\131\185\229\138\159\232\131\189";
		HelpAskPriceAd	= "\229\149\159\231\148\168\230\136\150\233\151\156\233\150\137\230\150\176\231\154\132\232\169\162\229\131\185\229\138\159\232\131\189\229\187\163\229\145\138\227\128\130";
		HelpAskPriceGuild	= "\229\155\158\230\135\137\229\156\152\233\154\138\233\160\187\233\129\147\231\154\132\232\169\162\229\131\185\227\128\130";
		HelpAskPriceParty	= "\229\155\158\230\135\137\233\154\138\228\188\141\233\160\187\233\129\147\231\154\132\232\169\162\229\131\185\227\128\130";
		HelpAskPriceSmart	= "\229\133\129\232\168\177\230\136\150\233\151\156\233\150\137\230\153\186\230\133\167\232\167\184\231\153\188\229\173\151\229\133\131\229\129\181\230\184\172(SmartWords checking)\227\128\130\n";
		HelpAskPriceTrigger	= "\230\148\185\232\174\138\232\169\162\229\131\185(AskPrice)\231\154\132\232\167\184\231\153\188\229\173\151\229\133\131\227\128\130";
		HelpAskPriceVendor	= "\229\133\129\232\168\177\230\136\150\233\151\156\233\150\137\229\149\134\229\186\151\229\131\185\230\160\188\232\179\135\230\150\153\231\153\188\233\128\129\227\128\130\n";
		HelpAskPriceWhispers	= "\233\154\177\232\151\143\230\136\150\233\161\175\231\164\186\230\137\128\230\156\137\231\153\188\233\128\129\231\154\132\232\128\179\232\170\158\227\128\130";
		HelpAskPriceWord	= "\230\150\176\229\162\158\230\136\150\230\148\185\232\174\138\232\135\170\232\168\130\230\153\186\230\133\167\232\167\184\231\153\188\229\173\151\229\133\131(smartwords)";
		HelpAuctionClick	= "\229\133\129\232\168\177\228\189\160 Alt+\233\187\158\230\147\138\232\131\140\229\140\133\228\184\173\231\154\132\231\137\169\229\147\129 \228\190\134\232\135\170\229\139\149\233\150\139\229\167\139\230\139\141\232\179\163";
		HelpAuctionDuration	= "\232\168\173\231\189\174\229\156\168\233\150\139\229\149\159\230\139\141\232\179\163\229\160\180\232\166\150\231\170\151\230\153\130\239\188\140\228\189\191\231\148\168\233\160\144\232\168\173\230\139\141\232\179\163\230\153\130\233\150\147";
		HelpAutofill	= "\232\168\173\231\189\174\229\156\168\230\139\141\232\179\163\231\137\169\229\147\129\231\154\132\230\153\130\229\128\153\239\188\140\230\152\175\229\144\166\229\156\168\232\135\170\229\139\149\229\161\171\229\175\171\229\131\185\230\160\188";
		HelpAverage	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132\229\185\179\229\157\135\230\139\141\232\179\163\229\131\185\230\160\188";
		HelpBidbroker	= "\233\161\175\231\164\186\231\149\182\229\137\141\230\142\131\230\143\143\228\184\173\231\153\188\231\143\190\231\154\132\229\143\175\231\148\168\230\150\188\230\168\153\228\184\139\228\187\165\231\141\178\229\143\150\229\136\169\230\189\164\231\154\132\228\184\173\231\159\173\230\156\159\230\139\141\232\179\163\231\137\169\229\147\129";
		HelpBidLimit	= "\229\156\168\230\139\141\232\179\163\233\160\129\233\157\162\239\188\140\229\143\175\228\187\165\229\144\140\230\153\130\231\171\182\230\168\153\230\136\150\231\155\180\230\142\165\232\179\188\232\178\183\231\154\132\230\156\128\229\164\167\230\149\184\233\135\143\227\128\130";
		HelpBroker	= "\233\161\175\231\164\186\229\156\168\231\149\182\229\137\141\230\142\131\230\143\143\228\184\173\239\188\140\229\143\175\232\131\189\229\143\175\228\187\165\230\168\153\228\184\139\229\134\141\232\179\163\229\135\186\228\184\166\231\141\178\229\143\150\229\136\169\230\189\164\231\154\132\230\137\128\230\156\137\230\139\141\232\179\163\231\137\169\229\147\129";
		HelpClear	= "\230\184\133\233\153\164\231\137\185\229\174\154\231\154\132\231\137\169\229\147\129\230\149\184\230\147\154(\228\189\160\229\191\133\233\160\136Shift+\233\187\158\233\129\184\228\190\134\230\138\138\231\137\169\229\147\129\229\138\160\229\133\165\229\136\176\229\145\189\228\187\164\232\163\161\233\157\162)\227\128\130\228\189\160\228\185\159\229\143\175\228\187\165\231\148\168\231\137\185\229\174\154\233\151\156\233\141\181\232\169\158\"all\"\230\136\150\"snapshot\"";
		HelpCompete	= "\233\161\175\231\164\186\230\137\128\230\156\137\230\156\128\232\191\145\230\142\131\230\143\143\231\154\132\230\175\148\228\189\160\231\154\132\231\155\180\232\179\188\229\131\185\228\189\142\231\154\132\230\139\141\232\179\163\229\147\129";
		HelpDefault	= "\233\135\141\231\189\174\228\184\128\229\128\139\230\139\141\232\179\163\229\138\169\230\137\139\233\129\184\233\160\133\231\130\186\229\133\182\233\160\144\232\168\173\229\128\188\239\188\140\228\189\160\228\185\159\229\143\175\228\187\165\228\189\191\231\148\168\"all\"\228\190\134\233\135\141\231\189\174\230\137\128\230\156\137\233\129\184\233\160\133\231\130\186\229\133\182\233\160\144\232\168\173\229\128\188";
		HelpDisable	= "\231\166\129\230\173\162\230\139\141\232\179\163\229\138\169\230\137\139\229\156\168\228\184\139\230\172\161\231\153\187\229\133\165\230\153\130\232\135\170\229\139\149\232\188\137\229\133\165";
		HelpEmbed	= "\230\138\138\230\150\135\229\173\151\229\181\140\229\133\165\229\136\176\233\129\138\230\136\178\231\154\132\229\142\159\229\167\139\230\143\144\231\164\186\228\184\173(\230\179\168\230\132\143\239\188\154\230\159\144\228\186\155\229\138\159\232\131\189\229\156\168\232\169\178\230\168\161\229\188\143\228\184\139\231\132\161\230\179\149\228\189\191\231\148\168)";
		HelpEmbedBlank	= "\233\129\184\230\147\135\230\152\175\229\144\166\229\156\168\230\143\144\231\164\186\228\191\161\230\129\175\229\146\140\230\139\141\232\179\163\232\161\140\228\191\161\230\129\175\228\184\173\233\150\147\230\143\146\229\133\165\231\169\186\232\161\140(\233\156\128\232\166\129\229\181\140\229\133\165\230\168\161\229\188\143\232\168\173\231\189\174\231\130\186on)";
		HelpFinish	= "\232\168\173\231\189\174\231\149\182\230\142\131\230\143\143\229\174\140\231\149\162\229\190\140\239\188\140\230\152\175\229\144\166\232\135\170\229\139\149\231\153\187\229\135\186\230\136\150\233\128\128\229\135\186\233\129\138\230\136\178";
		HelpFinishSound	= "\233\129\184\230\147\135\230\152\175\229\144\166\229\156\168\230\142\131\230\143\143\229\174\140\231\149\162\228\185\139\229\190\140\230\146\173\230\148\190\233\159\179\230\149\136";
		HelpLink	= "\233\129\184\230\147\135\230\152\175\229\144\166\229\156\168\230\143\144\231\164\186\228\184\173\233\161\175\231\164\186link id";
		HelpLoad	= "\230\148\185\232\174\138\230\139\141\232\179\163\229\138\169\230\137\139\231\154\132\232\188\137\229\133\165\232\168\173\231\189\174";
		HelpLocale	= "\230\148\185\232\174\138\233\161\175\231\164\186\230\139\141\232\179\163\229\138\169\230\137\139\232\168\138\230\129\175\231\154\132\232\170\158\232\168\128";
		HelpMedian	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132\229\185\179\229\157\135\231\155\180\232\179\188\229\131\185";
		HelpOnoff	= "\233\150\139\229\149\159\239\188\143\233\151\156\233\150\137\230\139\141\232\179\163\232\179\135\230\150\153\233\161\175\231\164\186";
		HelpPctBidmarkdown	= "\232\168\173\231\189\174\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)\228\190\134\228\187\165\231\155\180\232\179\188\229\131\185\232\135\170\229\139\149\232\168\173\231\189\174\232\181\183\230\168\153\229\131\185";
		HelpPctMarkup	= "\231\149\182\230\178\146\230\156\137\229\133\182\228\187\150\229\143\131\232\128\131\229\131\185\230\160\188\231\154\132\230\153\130\229\128\153\239\188\140\232\168\173\231\189\174\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)\228\190\134\228\187\165\229\149\134\229\186\151\229\148\174\229\131\185\232\135\170\229\139\149\232\168\173\229\174\154\232\181\183\230\168\153\229\131\185";
		HelpPctMaxless	= "\232\168\173\231\189\174\230\139\141\232\179\163\229\138\169\230\137\139\232\135\170\229\139\149\230\168\153\229\131\185\230\153\130\239\188\140\228\189\142\230\150\188\229\184\130\229\160\180\229\131\185\230\160\188\231\154\132\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)\231\154\132\228\184\139\233\153\144\239\188\140\232\139\165\228\189\142\230\150\188\228\184\139\233\153\144\229\176\135\232\135\170\229\139\149\230\148\190\230\163\132\232\169\178\233\160\133\230\139\141\232\179\163";
		HelpPctNocomp	= "\232\168\173\231\189\174\229\166\130\230\158\156\231\132\161\228\186\186\231\171\182\230\168\153\230\153\130\239\188\140\230\139\141\232\179\163\229\138\169\230\137\139\228\190\157\230\147\154\229\184\130\229\160\180\229\131\185\229\134\141\230\172\161\233\153\141\229\131\185\231\154\132\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)";
		HelpPctUnderlow	= "\232\168\173\231\189\174\230\139\141\232\179\163\229\138\169\230\137\139\231\155\184\229\176\141\230\150\188\230\139\141\232\179\163\232\161\140\230\156\128\228\189\142\229\131\185\229\134\141\229\137\138\230\184\155\231\154\132\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)";
		HelpPctUndermkt	= "\232\168\173\231\189\174\231\149\182\232\169\178\230\139\141\232\179\163\229\147\129\230\178\146\230\156\137\228\186\186\229\143\131\232\136\135\231\171\182\230\168\153\231\154\132\230\175\148\228\190\139(\231\153\190\229\136\134\230\175\148)\231\130\186\229\164\154\229\176\145\230\153\130\239\188\140\233\150\139\229\167\139\229\137\138\229\131\185\230\139\141\232\179\163(\231\155\180\229\136\176\230\156\128\229\164\167\233\153\141\229\131\185\230\175\148\228\190\139)";
		HelpPercentless	= "\233\161\175\231\164\186\229\156\168\231\149\182\229\137\141\230\142\131\230\143\143\228\184\173\239\188\140\231\155\180\232\179\188\229\131\185\228\189\142\230\150\188\230\156\128\233\171\152\232\179\163\229\135\186\229\131\185\230\160\188\231\137\185\229\174\154\231\153\190\229\136\134\230\175\148\231\154\132\230\137\128\230\156\137\230\139\141\232\179\163\229\147\129";
		HelpPrintin	= "\232\168\173\231\189\174\230\139\141\232\179\163\229\138\169\230\137\139\230\138\138\230\150\135\229\173\151\233\161\175\231\164\186\229\156\168\229\147\170\229\128\139\230\161\134\230\158\182\239\188\140\228\189\160\229\143\175\228\187\165\228\189\191\231\148\168\230\161\134\230\158\182\229\144\141\229\173\151\239\188\140\228\185\159\229\143\175\228\187\165\231\148\168\231\183\168\232\153\159";
		HelpProtectWindow	= "\233\152\178\230\173\162\230\130\168\230\132\143\229\164\150\233\151\156\233\150\137\230\139\141\232\179\163\229\160\180\231\149\140\233\157\162";
		HelpRedo	= "\232\168\173\231\189\174\231\149\182\231\148\177\230\150\188\230\156\141\229\139\153\229\153\168\229\187\182\233\129\178\229\176\142\232\135\180\230\144\156\231\180\162\230\153\130\233\150\147\229\164\170\233\149\183\230\153\130\230\152\175\229\144\166\233\161\175\231\164\186\232\173\166\229\145\138";
		HelpScan	= "\233\128\178\232\161\140\230\139\141\232\179\163\230\142\131\231\158\132(\232\139\165\228\189\160\230\173\163\229\156\168\230\139\141\232\179\163\229\160\180\231\149\140\233\157\162\239\188\140\231\155\184\231\149\182\230\150\188\230\140\137\228\184\139\230\142\131\231\158\132\230\140\137\233\136\149)\230\136\150\230\152\175\229\156\168\228\184\139\230\172\161\228\189\160\232\168\170\229\149\143\230\139\141\232\179\163\232\161\140\231\154\132\230\153\130\229\128\153\233\150\139\229\167\139\233\128\178\232\161\140\230\142\131\231\158\132\227\128\130\233\129\184\230\147\135\228\189\160\230\131\179\232\166\129\230\142\131\230\143\143\231\154\132\231\168\174\233\161\158\231\132\182\229\190\140\230\137\147\229\139\190\227\128\130";
		HelpStats	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132\230\136\144\228\186\164\229\131\185\239\188\143\231\155\180\232\179\188\229\131\185\231\153\190\229\136\134\230\175\148";
		HelpSuggest	= "\233\129\184\230\147\135\230\152\175\229\144\166\233\161\175\231\164\186\231\137\169\229\147\129\231\154\132\229\187\186\232\173\176\229\131\185\230\160\188";
		HelpUpdatePrice	= "\230\150\176\229\162\158\230\139\141\232\179\163\230\153\130\239\188\140\231\149\182\231\155\180\232\179\188\229\131\185\230\148\185\232\174\138\230\153\130\232\135\170\229\139\149\230\155\180\230\150\176\232\181\183\230\168\153\229\131\185";
		HelpVerbose	= "\233\129\184\230\147\135\230\152\175\229\144\166\228\187\165\229\164\154\232\161\140\233\161\175\231\164\186\232\169\179\231\180\176\231\154\132\229\185\179\229\157\135\229\131\185\230\160\188\229\146\140\229\187\186\232\173\176(\233\129\184\230\147\135\233\151\156\233\150\137\229\176\135\228\187\165\229\150\174\232\161\140\233\161\175\231\164\186)";
		HelpWarnColor	= "\233\129\184\230\147\135\230\152\175\229\144\166\231\148\168\228\184\141\229\144\140\233\161\143\232\137\178\228\190\134\230\168\153\231\164\186\231\137\185\230\174\138\230\131\133\230\179\129\231\154\132\229\131\185\230\160\188(\228\190\139\229\166\130\239\188\154\232\179\164\229\131\185\229\135\186\229\148\174)";


		-- Section: Post Messages
		FrmtNoEmptyPackSpace	= "\230\139\141\232\179\163\232\161\140\230\178\146\230\156\137\231\169\186\233\150\147\233\128\178\232\161\140\230\150\176\230\139\141\232\179\163";
		FrmtNotEnoughOfItem	= "\230\139\141\232\179\163\232\161\140\230\178\146\230\156\137 %s \229\128\139\231\169\186\233\150\147\233\128\178\232\161\140\230\150\176\230\139\141\232\179\163";
		FrmtPostedAuction	= "\229\183\178\231\182\147\230\136\144\229\138\159\233\128\178\232\161\140\230\139\141\232\179\163 1 \228\187\182 %s (x%d) ";
		FrmtPostedAuctions	= "\229\183\178\231\182\147\230\136\144\229\138\159\233\128\178\232\161\140\230\139\141\232\179\163 %d \228\187\182 %s (x%d) ";


		-- Section: Report Messages
		FrmtBidbrokerCurbid	= "\231\149\182\229\137\141\230\168\153\229\131\185";
		FrmtBidbrokerDone	= "\228\186\164\230\152\147\229\131\185\228\187\163\231\144\134(Bid broker)\229\174\140\230\136\144";
		FrmtBidbrokerHeader	= "\230\156\128\229\176\143\229\136\169\230\189\164\239\188\154%s,\228\184\138\233\153\144='\230\156\128\233\171\152\229\143\175\229\148\174\229\131\185'";
		FrmtBidbrokerLine	= "%s, \229\135\186\231\143\190\233\129\142 %s \230\172\161, \230\156\128\233\171\152\229\131\185\239\188\154%s, %s\239\188\154%s, \229\136\169\230\189\164\239\188\154%s, \230\172\161\230\149\184\239\188\154%s";
		FrmtBidbrokerMinbid	= "\230\156\128\228\189\142\228\186\164\230\152\147\229\131\185";
		FrmtBrokerDone	= "\228\187\163\231\144\134(Broker)\229\174\140\230\136\144";
		FrmtBrokerHeader	= "\230\156\128\229\176\143\229\136\169\230\189\164\239\188\154%s,\228\184\138\233\153\144='\230\156\128\233\171\152\229\143\175\229\148\174\229\131\185'";
		FrmtBrokerLine	= "%s,\229\135\186\231\143\190%s\230\172\161,\228\184\138\233\153\144\239\188\154%s,\231\155\180\230\142\165\232\179\188\232\178\183\239\188\154%s,\229\136\169\230\189\164\239\188\154%s";
		FrmtCompeteDone	= "\229\174\140\230\136\144\231\171\182\230\168\153";
		FrmtCompeteHeader	= "\231\171\182\230\168\153\230\175\143\233\160\133\231\137\169\229\147\129\232\135\179\229\176\145\229\183\174\229\131\185%s";
		FrmtCompeteLine	= "%s, \230\168\153\229\131\185\239\188\154%s, \231\155\180\232\179\188\229\131\185\239\188\154%s vs %s, \229\183\174\229\131\185 %s";
		FrmtHspLine	= "\230\175\143\229\128\139 %s \231\154\132\230\156\128\233\171\152\229\148\174\229\131\185\231\130\186\239\188\154%s";
		FrmtLowLine	= "%s, \231\155\180\232\179\188\229\131\185\239\188\154%s, \229\135\186\229\148\174\232\128\133\239\188\154%s, \229\150\174\229\131\185\239\188\154%s, \228\189\142\230\150\188\229\185\179\229\157\135\229\131\185\239\188\154%s";
		FrmtMedianLine	= "\229\133\177\230\142\131\231\158\132\229\136\176 %d \230\172\161, \230\175\143\229\128\139 %s \229\185\179\229\157\135\230\136\144\228\186\164\229\131\185\230\160\188\231\130\186\239\188\154%s";
		FrmtNoauct	= "\232\169\178\231\137\169\229\147\129\230\178\146\230\156\137\230\139\141\232\179\163\232\168\152\233\140\132\239\188\154%s";
		FrmtPctlessDone	= "\228\190\157\231\153\190\229\136\134\230\175\148\229\137\138\230\184\155\229\174\140\230\136\144";
		FrmtPctlessHeader	= "\228\189\142\230\150\188\230\156\128\233\171\152\229\143\175\229\148\174\229\131\185\230\160\188\231\153\190\229\136\134\230\175\148\239\188\136HSP\239\188\137\239\188\154%d%%";
		FrmtPctlessLine	= "%s, \229\135\186\231\143\190\233\129\142 %d \230\172\161, \230\156\128\233\171\152\229\131\185\239\188\154%s, \231\155\180\232\179\188\229\131\185\239\188\154%s, \229\136\169\230\189\164\239\188\154%s, \228\189\142\230\150\188 %s";


		-- Section: Scanning Messages
		AuctionDefunctAucts	= "\229\183\178\231\167\187\233\153\164\233\129\142\230\156\159\231\154\132\230\139\141\232\179\163\239\188\154%s";
		AuctionDiscrepancies	= "\230\156\137\230\148\185\232\174\138\231\154\132\233\160\133\231\155\174\239\188\154%s";
		AuctionNewAucts	= "\230\142\131\230\143\143\229\136\176\231\154\132\230\150\176\230\139\141\232\179\163\239\188\154%s";
		AuctionOldAucts	= "\228\184\138\229\155\158\230\142\131\230\143\143\229\136\176\231\154\132\239\188\154%s";
		AuctionPageN	= "\230\139\141\232\179\163\229\138\169\230\137\139: \n\230\173\163\229\156\168\230\142\131\230\143\143 %s \231\172\172%d\233\160\129 \229\133\177%d\233\160\129\n\230\175\143\231\167\146\230\142\131\230\143\143\231\173\134\230\149\184\239\188\154%s \n\233\160\144\232\168\136\229\137\169\228\184\139\230\153\130\233\150\147\239\188\154%s";
		AuctionScanDone	= "\230\139\141\232\179\163\229\138\169\230\137\139\239\188\154\230\139\141\232\179\163\230\142\131\230\143\143\229\174\140\230\136\144";
		AuctionScanNexttime	= "\230\139\141\232\179\163\229\138\169\230\137\139\229\176\135\230\156\131\229\156\168\228\184\139\230\172\161\232\136\135\230\139\141\232\179\163\229\147\161\232\170\170\232\169\177\230\153\130\233\128\178\232\161\140\229\174\140\229\133\168\230\142\131\230\143\143";
		AuctionScanNocat	= "\228\189\160\229\191\133\233\160\136\230\156\128\229\176\145\233\129\184\230\147\135\228\184\128\229\128\139\233\161\158\229\136\165\233\128\178\232\161\140\230\142\131\230\143\143\227\128\130";
		AuctionScanRedo	= "\231\155\174\229\137\141\233\128\153\233\160\129\232\138\177\228\186\134\232\182\133\233\129\142 %d \231\167\146\230\142\131\230\143\143\239\188\140\233\135\141\232\169\166\230\156\172\233\160\129\227\128\130";
		AuctionScanStart	= "\230\139\141\232\179\163\229\138\169\230\137\139\239\188\154\230\173\163\229\156\168\230\142\131\230\143\143 %s \231\172\1721\233\160\129\239\188\142\239\188\142\239\188\142";
		AuctionTotalAucts	= "\230\142\131\230\143\143\229\136\176\231\154\132\230\139\141\232\179\163\230\149\184\233\135\143\239\188\154%s";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "\229\156\168 %s \231\156\139\233\129\142 %d \230\172\161";
		FrmtInfoAverage	= "%s \229\186\149\229\131\185/%s \231\155\180\232\179\188 (%s \229\135\186\229\131\185)";
		FrmtInfoBidMulti	= "\228\184\139\230\168\153(\230\175\143\229\128\139 %s%s)";
		FrmtInfoBidOne	= "\228\184\139\230\168\153 %s";
		FrmtInfoBidrate	= "%d%% \229\183\178\228\184\139\230\168\153, %d%% \230\156\137\231\155\180\232\179\188\229\131\185";
		FrmtInfoBuymedian	= "\229\185\179\229\157\135\231\155\180\232\179\188\229\131\185";
		FrmtInfoBuyMulti	= "\231\155\180\232\179\188(\230\175\143\229\128\139 %s%s)";
		FrmtInfoBuyOne	= "\231\155\180\232\179\188 %s";
		FrmtInfoForone	= "\229\150\174\229\128\139\239\188\154\230\156\128\228\189\142 %s\239\188\143\231\155\180\232\179\188 %s(\229\135\186\229\131\185 %s) [%d \229\128\139]";
		FrmtInfoHeadMulti	= "%d \229\128\139\231\137\169\229\147\129\229\185\179\229\157\135\229\131\185\230\160\188\239\188\154";
		FrmtInfoHeadOne	= "\232\169\178\231\137\169\229\147\129\229\185\179\229\157\135\229\131\185\230\160\188\239\188\154";
		FrmtInfoHistmed	= "\229\133\177\229\135\186\231\143\190 %d \230\172\161\239\188\140\229\185\179\229\157\135\231\155\180\232\179\188\229\131\185(\230\175\143\229\128\139)";
		FrmtInfoMinMulti	= "\232\181\183\230\168\153\229\131\185(\230\175\143\229\128\139 %s)";
		FrmtInfoMinOne	= "\232\181\183\230\168\153\229\131\185";
		FrmtInfoNever	= "\229\190\158\230\156\170\229\135\186\231\143\190\229\156\168 %s \233\129\142";
		FrmtInfoSeen	= "\229\156\168\230\139\141\232\179\163\229\160\180\228\184\173\229\135\186\231\143\190\233\129\142 %d \230\172\161";
		FrmtInfoSgst	= "\229\187\186\232\173\176\229\131\185\230\160\188\239\188\154\232\181\183\230\168\153 %s\239\188\143\231\155\180\232\179\188 %s";
		FrmtInfoSgststx	= "\229\176\141\228\189\160\233\128\153\228\184\128\231\150\138\229\133\177 %d \229\128\139\231\154\132\229\187\186\232\173\176\229\131\185\230\160\188\239\188\154\232\181\183\230\168\153 %s\239\188\143\231\155\180\232\179\188 %s";
		FrmtInfoSnapmed	= "\230\142\131\230\143\143\229\136\176 %d \231\173\134\239\188\140\229\185\179\229\157\135\231\155\180\232\179\188\229\131\185(\230\175\143\229\128\139)";
		FrmtInfoStacksize	= "\229\185\179\229\157\135\229\160\134\231\150\138\230\149\184\233\135\143\239\188\154%d\229\128\139";


		-- Section: User Interface
		FrmtLastSoldOn	= "\230\156\128\229\190\140\229\148\174\229\135\186\229\131\185\230\160\188";
		UiBid	= "\229\135\186\229\131\185";
		UiBidHeader	= "\229\135\186\229\131\185";
		UiBidPerHeader	= "\230\175\143\229\128\139\230\168\153\229\131\185";
		UiBuyout	= "\231\155\180\232\179\188";
		UiBuyoutHeader	= "\231\155\180\232\179\188";
		UiBuyoutPerHeader	= "\230\175\143\229\128\139\231\155\180\232\179\188";
		UiBuyoutPriceLabel	= "\231\155\180\232\179\188\229\131\185\239\188\154";
		UiBuyoutPriceTooLowError	= "(\228\184\141\229\143\175\228\189\142\230\150\188\232\181\183\229\167\139\229\131\185)";
		UiCategoryLabel	= "\233\153\144\229\174\154\233\161\158\229\136\165\239\188\154";
		UiDepositLabel	= "\228\191\157\231\174\161\232\178\187\239\188\154";
		UiDurationLabel	= "\230\139\141\232\179\163\230\153\130\233\153\144\239\188\154";
		UiItemLevelHeader	= "\231\173\137\231\180\154";
		UiMakeFixedPriceLabel	= "\232\168\173\229\174\154\229\155\186\229\174\154\229\131\185\230\160\188";
		UiMaxError	= "(%d \230\156\128\229\164\167)";
		UiMaximumPriceLabel	= "\230\156\128\233\171\152\229\131\185\230\160\188\239\188\154";
		UiMaximumTimeLeftLabel	= "\230\156\128\229\164\167\229\137\169\233\164\152\230\153\130\233\150\147\239\188\154";
		UiMinimumPercentLessLabel	= "\230\156\128\228\189\142\230\184\155\229\176\145\230\175\148\228\190\139\239\188\154";
		UiMinimumProfitLabel	= "\230\156\128\229\176\143\229\136\169\230\189\164\239\188\154";
		UiMinimumQualityLabel	= "\233\129\142\230\191\190\230\156\128\228\189\142\231\180\154\229\136\165\239\188\154";
		UiMinimumUndercutLabel	= "\230\156\128\228\189\142\229\137\138\229\131\185\239\188\154";
		UiNameHeader	= "\229\144\141\229\173\151";
		UiNoPendingBids	= "\229\183\178\229\174\140\230\136\144\230\137\128\230\156\137\229\135\186\229\131\185\232\166\129\230\177\130!";
		UiNotEnoughError	= "(\228\184\141\232\182\179)";
		UiPendingBidInProgress	= "\230\156\1371\229\128\139\229\135\186\229\131\185\232\166\129\230\177\130\230\173\163\229\156\168\232\153\149\231\144\134\228\184\173...";
		UiPendingBidsInProgress	= "%d\229\135\186\229\131\185\232\166\129\230\177\130\230\173\163\229\156\168\232\153\149\231\144\134\228\184\173...";
		UiPercentLessHeader	= "\239\188\133";
		UiPost	= "\229\176\136\230\165\173\230\139\141\232\179\163";
		UiPostAuctions	= "\229\176\136\230\165\173\230\139\141\232\179\163";
		UiPriceBasedOnLabel	= "\229\174\154\229\131\185\229\159\186\230\150\188\239\188\154";
		UiPriceModelAuctioneer	= "\230\139\141\232\179\163\229\131\185\230\160\188";
		UiPriceModelCustom	= "\232\135\170\229\174\154\229\131\185\230\160\188";
		UiPriceModelFixed	= "\229\155\186\229\174\154\229\131\185\230\160\188";
		UiPriceModelLastSold	= "\230\156\128\229\190\140\232\179\163\229\135\186\229\131\185";
		UiProfitHeader	= "\229\136\169\230\189\164";
		UiProfitPerHeader	= "\230\175\143\229\128\139\229\136\169\230\189\164";
		UiQuantityHeader	= "\230\149\184\233\135\143";
		UiQuantityLabel	= "\232\168\173\229\174\154\230\149\184\233\135\143\239\188\154";
		UiRemoveSearchButton	= "\229\136\170\233\153\164";
		UiSavedSearchLabel	= "\229\183\178\229\173\152\230\144\156\229\176\139\232\168\152\233\140\132\239\188\154";
		UiSaveSearchButton	= "\229\173\152\230\170\148";
		UiSaveSearchLabel	= "\229\132\178\229\173\152\233\128\153\230\172\161\230\144\156\229\176\139\231\181\144\230\158\156\239\188\154";
		UiSearch	= "\230\144\156\229\176\139";
		UiSearchAuctions	= "\230\144\156\229\176\139\230\139\141\232\179\163";
		UiSearchDropDownLabel	= "\230\144\156\229\176\139\239\188\154";
		UiSearchForLabel	= "\229\176\139\230\137\190\231\137\169\229\147\129\239\188\154";
		UiSearchTypeBids	= "\229\135\186\229\131\185\230\159\165\232\169\162";
		UiSearchTypeBuyouts	= "\231\155\180\232\179\188\229\131\185\230\159\165\232\169\162";
		UiSearchTypeCompetition	= "\231\171\182\230\168\153";
		UiSearchTypePlain	= "\231\137\169\229\147\129";
		UiStacksLabel	= "\231\150\138";
		UiStackTooBigError	= "(\231\150\138\230\149\184\229\164\170\229\164\154)";
		UiStackTooSmallError	= "(\231\150\138\230\149\184\229\164\170\229\176\145)";
		UiStartingPriceLabel	= "\232\181\183\229\167\139\229\131\185\230\160\188\239\188\154";
		UiStartingPriceRequiredError	= "(\229\191\133\233\156\128\229\161\171\229\175\171)";
		UiTimeLeftHeader	= "\229\137\169\233\164\152\230\153\130\233\150\147";
		UiUnknownError	= "(\230\156\170\231\159\165)";

	};

	elGR = {


		-- Section: Auction Messages
		FrmtActRemove	= "\206\145\207\134\206\177\206\175\207\129\206\181\207\131\206\183 \207\132\206\183\207\130 \207\133\207\128\206\191\206\179\207\129\206\177\207\134\206\183\207\130 %s \206\177\207\128\206\191 \207\132\206\183 \206\180\206\183\206\188\206\191\207\128\207\129\206\177\207\131\206\185\206\177.";
		FrmtAuctinfoHist	= "%d \206\153\207\131\207\132\206\191\207\129\206\185\206\186\206\191";
		FrmtAuctinfoMktprice	= "\206\164\206\185\206\188\206\183 \206\186\206\191\207\131\207\132\206\191\207\133\207\130";
		FrmtAuctinfoNolow	= "\206\145\206\189\207\132\206\185\206\186\206\181\206\185\206\188\206\181\206\189\206\191 \206\180\206\181\206\189 \206\181\207\135\206\181\206\185 \206\181\206\185\206\180\207\1378\206\181\206\185 \207\131\207\132\206\183 \207\132\206\181\206\187\206\181\207\133\207\132\206\177\206\185\206\177 \206\180\206\183\206\188\206\191\207\128\207\129\206\177\207\131\206\185\206\177";
		FrmtAuctinfoOrig	= "\206\145\207\129\207\135\206\185\206\186\206\183 \206\160\207\129\206\191\207\131\207\134\206\191\207\129\206\177";
		FrmtAuctinfoSnap	= "%d \207\132\206\181\206\187\206\181\207\133\207\132\206\177\206\185\206\177 \206\177\206\189\206\177\206\182\206\183\207\132\206\183\207\131\206\183.";
		FrmtAuctinfoSugbid	= "\206\160\207\129\207\137\207\132\206\183 \207\128\207\129\206\191\207\131\207\134\206\191\207\129\206\177";
		FrmtAuctinfoSugbuy	= "\206\160\207\129\206\191\207\132\206\181\206\185\206\189\207\137\206\188\206\181\206\189\206\183 \207\132\206\185\206\188\206\183 \206\177\206\179\206\191\207\129\206\177\207\130";
		FrmtWarnAbovemkt	= "\206\145\206\189\207\132\206\177\206\179\207\137\206\189\206\185\207\131\206\188\206\191\207\130 \207\131\206\181 \206\177\206\189\207\137\207\132\206\181\207\129\206\177 \206\181\207\128\206\185\207\128\206\181\206\180\206\177 \206\177\207\128\206\191 \207\132\206\183\206\189 \207\132\206\185\206\188\206\183 \206\186\206\191\207\131\207\132\206\191\207\133\207\130";
		FrmtWarnMyprice	= "\206\167\207\129\206\183\207\131\206\183 \207\132\206\183\207\130 \207\132\207\137\207\129\206\185\206\189\206\183\207\130 \207\132\206\185\206\188\206\183\207\130";
		FrmtWarnNocomp	= "\206\167\207\137\207\129\206\185\207\130 \206\145\206\189\207\132\206\177\206\179\207\137\206\189\206\185\207\131\206\188\206\191";
		FrmtWarnNodata	= "\206\148\206\181\206\189 \207\133\207\128\206\177\207\129\207\135\206\191\207\133\206\189 \207\128\206\187\206\183\207\129\206\191\207\134\206\191\207\129\206\185\206\181\207\130 \206\179\206\185\206\177 HSP ";
		FrmtWarnToolow	= "\206\148\206\181\206\189 \206\188\207\128\206\191\207\129\206\181\206\185 \206\189\206\177 \207\128\206\185\206\177\207\131\207\132\206\181\206\185 \206\183 \206\186\206\177\207\132\207\137\207\132\206\181\207\129\206\183 \207\132\206\185\206\188\206\183";
		FrmtWarnUndercut	= "\206\156\206\181\206\185\207\137\207\131\206\183 \206\186\206\177\207\132\206\177 %s%% ";
		FrmtWarnUser	= "\206\167\207\129\206\183\207\131\206\183 \207\132\206\185\206\188\206\183\207\130 \207\132\206\191\207\133 \207\135\207\129\206\183\207\131\207\132\206\183";


		-- Section: Game Constants
		TimeLong	= "\206\156\206\177\206\186\207\129\207\133";
		TimeMed	= "\206\156\206\181\207\131\206\177\206\185\206\177";
		TimeShort	= "\206\163\207\133\206\189\207\132\206\191\206\188\206\177";
		TimeVlong	= "\206\149\207\135\206\181\206\185\207\130 \206\186\206\177\206\185\207\129\206\191";

	};

	trTR = {


		-- Section: Auction Messages
		FrmtActRemove	= "%s Bu par\195\131\194\167a Mevcut AH taramas\195\132\194\177ndan kald\195\132\194\177r\195\132\194\177ld\195\132\194\177.";
		FrmtAuctinfoHist	= "%d ge\195\131\194\167mi\195\133\197\184i";
		FrmtAuctinfoLow	= "En d\195\131\194\188\195\133\197\184\195\131\194\188k fiyat";
		FrmtAuctinfoMktprice	= "Pazar fiyat\195\132\194\177";
		FrmtAuctinfoNolow	= "Bu par\195\131\194\167a daha \195\131\194\182nce hi\195\131\194\167 g\195\131\194\182r\195\131\194\188lmedi";
		FrmtAuctinfoOrig	= "Orijinal teklif";
		FrmtAuctinfoSnap	= "%d son tarama";
		FrmtAuctinfoSugbid	= "Ba\195\133\197\184lang\195\132\194\177\195\131\194\167 fiyat\195\132\194\177";
		FrmtAuctinfoSugbuy	= "Tavsiye edilen hemen-al fiyat\195\132\194\177";
		FrmtWarnAbovemkt	= "Fiyat\195\132\194\177n\195\132\194\177z pazar\195\132\194\177n \195\131\194\188zerinde ";
		FrmtWarnMarkup	= "Fiyat\195\132\194\177 t\195\131\194\188ccar al\195\132\194\177\195\133\197\184 fiyat\195\132\194\177n\195\132\194\177n %s%% fazlas\195\132\194\177na e\195\133\197\184itliyor";
		FrmtWarnMyprice	= "Mevcut fiyat kullan\195\132\194\177l\195\132\194\177yor";
		FrmtWarnNocomp	= "Rekabet yok";
		FrmtWarnNodata	= "HSP i\195\131\194\167in veri yok";
		FrmtWarnToolow	= "En d\195\131\194\188\195\133\197\184\195\131\194\188k fiyatla \195\131\194\167ak\195\132\194\177\195\133\197\184m\195\132\194\177yor";
		FrmtWarnUndercut	= "Rekabet: Fiyat eksi %s%% ";
		FrmtWarnUser	= "Kullan\195\132\194\177c\195\132\194\177 fiyatland\195\132\194\177rmas\195\132\194\177 kullan\195\132\194\177l\195\132\194\177yor";


		-- Section: Bid Messages
		FrmtNoAuctionsFound	= "Subasta no encontrada: %s(x%d)";


		-- Section: Command Messages
		FrmtActClearall	= "%s i\195\131\194\167in b\195\131\194\188t\195\131\194\188n a\195\131\194\167\195\132\194\177k art\195\132\194\177rma verileri siliniyor ";
		FrmtActClearFail	= "Par\195\131\194\167a bulunamad\195\132\194\177: %s";
		FrmtActClearOk	= "Par\195\131\194\167a i\195\131\194\167in t\195\131\194\188m bilgiler temizlendi: %s";
		FrmtActClearsnap	= "Son m\195\131\194\188zayede evi (AH) taramas\195\132\194\177 temizlendi";
		FrmtActDefault	= "%s se\195\131\194\167ene\195\132\197\184i varsay\195\132\194\177lan de\195\132\197\184erine getirildi";
		FrmtActDefaultall	= "B\195\131\194\188t\195\131\194\188n se\195\131\194\167enekler varsay\195\132\194\177lan de\195\132\197\184ere indirgendi.";
		FrmtActDisable	= "%s par\195\131\194\167as\195\132\194\177n\195\132\194\177n verisi g\195\131\194\182sterilmiyor";
		FrmtActEnable	= "%s par\195\131\194\167as\195\132\194\177n\195\132\194\177n verisi g\195\131\194\182steriliyor";
		FrmtActSet	= "%s '%s' olarak ayarland\195\132\194\177";
		FrmtActUnknown	= "Bilinmeyen komut: '%s'";
		FrmtAuctionDuration	= "Varsay\195\132\194\177lan a\195\131\194\167\195\132\194\177k art\195\132\194\177rma s\195\131\194\188resi %s olarak ayarland\195\132\194\177";
		FrmtAutostart	= "Otomatik olarak m\195\131\194\188zayedeye ba\195\133\197\184lan\195\132\194\177yor. Minimum: %s / Hemen-al: %s (%dh)\n%s";
		FrmtPrintin	= "Auctioneer mesaj\195\132\194\177 \195\133\197\184imdi %s chat penceresinde yaz\195\132\194\177lacak.";
		FrmtProtectWindow	= "M\195\131\194\188zayede evinin penceresinin korumas\195\132\194\177 %s olarak ayarland\195\132\194\177";
		FrmtUnknownArg	= "'%s' '%s' i\195\131\194\167in ge\195\131\194\167erli bir komut de\195\132\197\184il ";
		FrmtUnknownLocale	= "Belirtti\195\132\197\184iniz yer ('%s') bilinmiyor. Belirlenen yerler:";
		FrmtUnknownRf	= "Ge\195\131\194\167ersiz komut ('%s').  Komut \195\133\197\184u \195\133\197\184ekilde formatlanmal\195\132\194\177: [sunucu]-[taraf]. \195\131\226\128\147rnek: Al'Akir-Horde";


		-- Section: Command Options
		OptAlso	= "(sunucu-taraf|kar\195\133\197\184\195\132\194\177)";
		OptAuctionDuration	= "(son||2s||8s||24s) ";
		OptBidbroker	= "<g\195\131\194\188m\195\131\194\188\195\133\197\184_kazan\195\131\194\167>";
		OptBroker	= "<g\195\131\194\188m\195\131\194\188\195\133\197\184_kazan\195\131\194\167>";
		OptClear	= "([Par\195\131\194\167a]|hepsi|son tarama) ";
		OptCompete	= "<g\195\131\194\188m\195\131\194\188\195\133\197\184_az> ";
		OptDefault	= "(<se\195\131\194\167enek>|hepsi) ";
		OptLocale	= "<yer>";
		OptPctBidmarkdown	= "<y\195\131\194\188zde>";
		OptPctMarkup	= "<y\195\131\194\188zde>";
		OptPctMaxless	= "<y\195\131\194\188zde>";
		OptPctNocomp	= "<y\195\131\194\188zde>";
		OptPctUnderlow	= "<y\195\131\194\188zde>";
		OptPctUndermkt	= "<y\195\131\194\188zde>";
		OptPercentless	= "<y\195\131\194\188zde>";
		OptPrintin	= "(<Ba\195\133\197\184lang\195\132\194\177\195\131\194\167 Penceresi>[Numara]|<Pencere Ad\195\132\194\177>[Yaz\195\132\194\177]) ";
		OptProtectWindow	= "(asla||taramada||her zaman)";
		OptScale	= "<oran_fakt\195\131\194\182r>";
		OptScan	= "<Tarama parametresi> ";


		-- Section: Commands
		CmdAlso	= "ek olarak";
		CmdAlsoOpposite	= "kar\195\133\197\184\195\132\194\177";
		CmdAlt	= "Alt";
		CmdAuctionClick	= "m\195\131\194\188zayede-t\195\132\194\177klama";
		CmdAuctionDuration	= "m\195\131\194\188zayede s\195\131\194\188resi";
		CmdAuctionDuration0	= "son";
		CmdAuctionDuration1	= "2s";
		CmdAuctionDuration2	= "8s";
		CmdAuctionDuration3	= "24s";
		CmdAutofill	= "otomatik doldurma";
		CmdBidbroker	= "bidbroker";
		CmdBidbrokerShort	= "bb";
		CmdBroker	= "broker";
		CmdClear	= "sil";
		CmdClearAll	= "hepsi";
		CmdClearSnapshot	= "Sontarama";
		CmdCompete	= "Rekabet";
		CmdCtrl	= "Ctrl";
		CmdDefault	= "Orijinal";
		CmdDisable	= "iptal";
		CmdEmbed	= "yerlestir";
		CmdLocale	= "yerbelirle";
		CmdOff	= "kapat";
		CmdOn	= "ac";
		CmdPctBidmarkdown	= "fiyat-dus";
		CmdPctMarkup	= "fiyat-art";
		CmdPctMaxless	= "fiyat-max-az";
		CmdPctNocomp	= "fiyat-rekabet-yok";
		CmdPctUnderlow	= "fiyat-en-asagi";
		CmdPctUndermkt	= "fiyat-pazar-alt\195\132\194\177";
		CmdPercentless	= "yuzdeucuz";
		CmdPercentlessShort	= "yu";
		CmdPrintin	= "buraya_aktar";
		CmdProtectWindow	= "pencere-koru";
		CmdProtectWindow0	= "asla";
		CmdProtectWindow1	= "taramada";
		CmdProtectWindow2	= "daima";
		CmdScan	= "tara";
		CmdShift	= "shift";
		CmdToggle	= "degistir";
		ShowAverage	= "ortalamay\195\132\194\177-goster";
		ShowEmbedBlank	= "goster-yerlestir-beyazcizgi";
		ShowLink	= "goster-sekme";
		ShowMedian	= "goster-ortanca";
		ShowRedo	= "goster-uyar\195\132\194\177";
		ShowStats	= "goster-istatistik";
		ShowSuggest	= "goster-oneri";
		ShowVerbose	= "goster-detayli";


		-- Section: Config Text
		GuiAlso	= "Ek veri g\195\131\194\182sterlecek";
		GuiAlsoDisplay	= "%s i\195\131\194\167in veri g\195\131\194\182steriliyor";
		GuiAlsoOff	= "Di\195\132\197\184er sunucu/taraf verisi g\195\131\194\182sterilmiyor";
		GuiAlsoOpposite	= "Di\195\132\197\184er taraf i\195\131\194\167in de bilgi g\195\131\194\182steriliyor.";
		GuiAuctionDuration	= "Varsay\195\132\194\177lan m\195\131\194\188zayede s\195\131\194\188resi";
		GuiAuctionHouseHeader	= "M\195\131\194\188zayede evi (AH) penceresi";
		GuiAuctionHouseHeaderHelp	= "M\195\131\194\188zayede evi (AH) penceresinin ayarlar\195\132\194\177n\195\132\194\177 de\195\132\197\184i\195\133\197\184tir";
		GuiAutofill	= "M\195\131\194\188zayede evinde (AH) fiyatlar\195\132\194\177 otomatik olarak gir.";
		GuiAverages	= "Ortalamalar\195\132\194\177 g\195\131\194\182ster";
		GuiBidmarkdown	= "%x daha d\195\131\194\188\195\133\197\184\195\131\194\188k fiyata koy";
		GuiClearall	= "B\195\131\194\188t\195\131\194\188n Auctioneer verilerini sil";
		GuiClearallButton	= "Hepsini Sil";
		GuiClearallHelp	= "Aktif sunucudaki t\195\131\194\188m Auctioneer verilerini siler";
		GuiClearallNote	= "Aktif sunucu ve taraf\195\132\194\177n t\195\131\194\188m verileri";
		GuiClearHeader	= "Verileri Sil";
		GuiClearHelp	= "Auctioneer verilerini siler. T\195\131\194\188m verileri veya son taramay\195\132\194\177 se\195\131\194\167iniz. UYARI: bu i\195\133\197\184lemin geri d\195\131\194\182n\195\131\194\188\195\133\197\184\195\131\194\188 yok";
		GuiClearsnap	= "Son tarama verilerini sil";
		GuiClearsnapButton	= "Son tarama sil";
		GuiClearsnapHelp	= "Auctioneer in son tarama verilerini silmek i\195\131\194\167in t\195\132\194\177klay\195\132\194\177n.";
		GuiDefaultAll	= "Auctioneer ayarlar\195\132\194\177n\195\132\194\177 s\195\132\194\177f\195\132\194\177rla";
		GuiDefaultAllButton	= "Hepsini S\195\132\194\177f\195\132\194\177rla";
		GuiDefaultAllHelp	= "Auctioneer ayarlar\195\132\194\177n\195\132\194\177n hepsini s\195\132\194\177f\195\132\194\177rlamak i\195\131\194\167in t\195\132\194\177klay\195\132\194\177n\195\132\194\177z. UYARI: Bu i\195\133\197\184lemin geri d\195\131\194\182n\195\131\194\188\195\133\197\184\195\131\194\188 yoktur";
		GuiDefaultOption	= "Bu ayar\195\132\194\177 s\195\132\194\177f\195\132\194\177rla";
		GuiEmbed	= "Bilgileri oyun i\195\131\194\167i imge\195\131\194\167 ucuna yerle\195\133\197\184tir";
		GuiEmbedBlankline	= "Oyun i\195\131\194\167i imge\195\131\194\167 ucunda bo\195\133\197\184 sat\195\132\194\177r g\195\131\194\182ster";
		GuiEmbedHeader	= "Yerle\195\133\197\184tir";
		GuiLink	= "LinkID g\195\131\194\182ster";
		GuiLoad	= "Auctioneer i otomatik y\195\131\194\188kle";
		GuiLoad_Always	= "daima";
		GuiLoad_AuctionHouse	= "M\195\131\194\188zayede Evinde";
		GuiLoad_Never	= "asla";
		GuiLocale	= "Yer ayarla";
		GuiMainEnable	= "Etkinkil Auctioneer";
		GuiMaxless	= "Max pazar fiyatinin alt\195\132\194\177na inme y\195\131\194\188zdesi";
		GuiMedian	= "Ortancalar\195\132\194\177 g\195\131\194\182ster";
		GuiNocomp	= "Rekabet yokken indirim y\195\131\194\188zdesi";
		GuiNoWorldMap	= "Auctioneer: D\195\131\194\188nya haritas\195\132\194\177n\195\132\194\177n g\195\131\194\182sterimi engellendi";
		GuiOtherHeader	= "Di\195\132\197\184er se\195\131\194\167enekler";
		GuiOtherHelp	= "Di\195\132\197\184er Auctioneer se\195\131\194\167enekleri";
		GuiPercentsHeader	= "Auctioneer limit y\195\131\194\188zdeleri";
		GuiPercentsHelp	= "D\195\132\194\176KKAT: Takip eden se\195\131\194\167enekler SADECE uzman oyuncular i\195\131\194\167indir. Auctioneer'in karl\195\132\194\177l\195\132\194\177k belirlemesi yaparken ne kadar h\195\132\194\177rsl\195\132\194\177 olmas\195\132\194\177n\195\132\194\177 istedi\195\132\197\184inizi bu de\195\132\197\184erleri de\195\132\197\184i\195\133\197\184tirerek ayarlay\195\132\194\177n. ";
		GuiPrintin	= "\195\131\226\128\161\195\132\194\177kt\195\132\194\177 penceresi se\195\131\194\167";
		GuiProtectWindow	= "M\195\131\194\188zayede penceresinin istenmeden kapanmas\195\132\194\177n\195\132\194\177 engelle";
		GuiRedo	= "Uzun tarama uyar\195\132\194\177s\195\132\194\177";
		GuiReloadui	= "Kullan\195\132\194\177c\195\132\194\177 arabirimini yeniden y\195\131\194\188kler";
		GuiReloaduiFeedback	= "WoW arabirimi y\195\131\194\188kleniyor";
		GuiReloaduiHelp	= "Ayarlar\195\132\194\177n\195\132\194\177z\195\132\194\177 yapt\195\132\194\177ktan sonra WoW aray\195\131\194\188z\195\131\194\188n\195\131\194\188 tekrar y\195\131\194\188klemek i\195\131\194\167in buraya t\195\132\194\177klay\195\132\194\177n\195\132\194\177z ki ayarlar\195\132\194\177n\195\132\194\177z uyu\195\133\197\184sun.";
		GuiRememberText	= "Fiyat\195\132\194\177 hat\195\132\194\177rla";
		GuiStatsEnable	= "\195\132\194\176statistikleri g\195\131\194\182ster";
		GuiStatsHeader	= "Fiyat \195\132\194\176statistikleri";
		GuiStatsHelp	= "Bu \195\132\194\176statistikleri Tooltip'de g\195\131\194\182ster";
		GuiSuggest	= "Tavsiye edilen fiyat\195\132\194\177 g\195\131\194\182ster";
		GuiUnderlow	= "En d\195\131\194\188\195\133\197\184\195\131\194\188k rakibin alt\195\132\194\177na inme y\195\131\194\188zdesi";
		GuiUndermkt	= "Pazar alt\195\132\194\177na inme y\195\131\194\188zdesi";
		GuiVerbose	= "Detayl\195\132\194\177 Mode";


		-- Section: Conversion Messages
		MesgConvert	= "Auctioneer veritaban\195\132\194\177 dn\195\131\194\188\195\133\197\184t\195\131\194\188r\195\131\194\188m\195\131\194\188. L\195\131\194\188tfen \195\131\194\182nce SavedVariables\Auctioneer.lua dosyan\195\132\194\177z\195\132\194\177 yedekleyin.%s%s";
		MesgConvertNo	= "Auctioneer'i devre d\195\132\194\177\195\133\197\184\195\132\194\177 b\195\132\194\177rak";
		MesgConvertYes	= "D\195\131\194\182n\195\131\194\188\195\133\197\184t\195\131\194\188r";
		MesgNotconverting	= "Auctioneer veritaban\195\132\194\177n\195\132\194\177z\195\132\194\177 d\195\131\194\182n\195\131\194\188\195\133\197\184t\195\131\194\188rm\195\131\194\188yor, fakat bu i\195\133\197\184lemi yapmad\195\132\194\177\195\132\197\184\195\132\194\177n\195\132\194\177z s\195\131\194\188rece de \195\131\194\167al\195\132\194\177\195\133\197\184mayacakt\195\132\194\177r.";


		-- Section: Game Constants
		TimeLong	= "Uzun";
		TimeMed	= "Orta";
		TimeShort	= "K\195\132\194\177sa";
		TimeVlong	= "\195\131\226\128\161ok Uzun";


		-- Section: Generic Messages
		DisableMsg	= "Auctioneer'in otomatik y\195\131\194\188klenmesini devre d\195\132\194\177\195\133\197\184\195\132\194\177 b\195\132\194\177rak.";
		FrmtWelcome	= "Auctioneer v%s y\195\131\194\188klendi";
		MesgNotLoaded	= "Auctioneer y\195\131\194\188klenmedi. Daha fazla bilgi i\195\131\194\167in /auctioneer yaz\195\132\194\177n\195\132\194\177z.";
		StatOff	= "A\195\131\194\167\195\132\194\177k artt\195\132\194\177rma verileri g\195\131\194\182sterilmiyor.";
		StatOn	= "Tan\195\132\194\177mlanm\195\132\194\177\195\133\197\184 a\195\131\194\167\195\132\194\177k artt\195\132\194\177rma verileri g\195\131\194\182r\195\131\194\188nt\195\131\194\188leniyor.";


		-- Section: Generic Strings
		TextAuction	= "a\195\131\194\167\195\132\194\177k artt\195\132\194\177rma";
		TextCombat	= "D\195\131\194\182v\195\131\194\188\195\133\197\184";
		TextGeneral	= "Genel";
		TextNone	= "hi\195\131\194\167bir\195\133\197\184ey";
		TextScan	= "Tarama";
		TextUsage	= "Kullan\195\132\194\177m\195\132\194\177:";


		-- Section: Scanning Messages
		AuctionDiscrepancies	= "Tutars\195\132\194\177zl\195\132\194\177klar: %s";
		AuctionScanDone	= "Auctioneer: Tarama sonu\195\131\194\167land\195\132\194\177";
		AuctionScanNocat	= "En az\195\132\194\177ndan bir kategori tarama i\195\131\194\167in se\195\131\194\167ilmi\195\133\197\184 olmal\195\132\194\177";
		AuctionScanRedo	= "Su anki sayfan\195\132\194\177n tamamlanmas\195\132\194\177 %d saniyeden uzun s\195\131\194\188rd\195\131\194\188, sayfay\195\132\194\177 tekrar deniyor.";
		AuctionScanStart	= "Auctioneer: taran\195\132\194\177yor %s sayfa 1... ";
		AuctionTotalAucts	= "Taranan toplam a\195\131\194\167\195\132\194\177k art\195\132\194\177rma: %s ";


		-- Section: Tooltip Messages
		FrmtInfoAlsoseen	= "%s 'de %d kere g\195\131\194\182r\195\131\194\188ld\195\131\194\188 ";
		FrmtInfoAverage	= "%s min/%s SA (%s teklif alm\195\132\194\177\195\133\197\184) ";
		FrmtInfoBidMulti	= "Teklif edilen (%s%s herbir) ";
		FrmtInfoBidOne	= "Teklif edilen%s";
		FrmtInfoBidrate	= "%d%% sine teklif var, %d%% sinin SA si var";
		FrmtInfoBuymedian	= "Sat\195\132\194\177n al ortancas\195\132\194\177";
		FrmtInfoBuyMulti	= "Sat\195\132\194\177n al (%s%s herbir) ";
		FrmtInfoBuyOne	= "Sat\195\132\194\177n al%s ";
		FrmtInfoForone	= "1 adet i\195\131\194\167in: %s min/%s SA (%s teklif alm\195\132\194\177\195\133\197\184) [in %d's] ";
		FrmtInfoHeadMulti	= "%d adet i\195\131\194\167in ortalama: ";
		FrmtInfoHeadOne	= "Bu cisim i\195\131\194\167in ortalamalar";
		FrmtInfoHistmed	= "Son %d, ortanca SA () ";
		FrmtInfoMinMulti	= "Ba\195\133\197\184lang\195\132\194\177\195\131\194\167 fiyat\195\132\194\177 (%s herbir) ";
		FrmtInfoMinOne	= "Ba\195\133\197\184lang\195\132\194\177\195\131\194\167 fiyat\195\132\194\177";
		FrmtInfoNever	= "%s 'de hi\195\131\194\167 g\195\131\194\182r\195\131\194\188lmedi";
		FrmtInfoSeen	= "%d kere a\195\131\194\167\195\132\194\177k art\195\132\194\177rmada g\195\131\194\182r\195\131\194\188ld\195\131\194\188 toplamda";
		FrmtInfoSgst	= "Tavsiye edilen fiyat: %s min/%s SA";
		FrmtInfoSgststx	= "%d adetlik grubunuz i\195\131\194\167in tavsiye edilen fiyat: %s min/%s SA";
		FrmtInfoSnapmed	= "Taranan %d, ortanca SA (herbir) ";
		FrmtInfoStacksize	= "Ortalama grup b\195\131\194\188y\195\131\194\188kl\195\131\194\188\195\132\197\184\195\131\194\188: %d adet";

	};
}