--== AUF DEUTSCH! ==--
if ( GetLocale() == "deDE" ) then

--== Pentarion: mit Absicht nicht uebersetzt diese Dinge werden in der localization.lua gesetzt und gelten "Sprachuebergreifend"
--RECIPEBOOK_VERSION_NUMBER = "1.12.0 alpha";
--RECIPEBOOK_VERSION_TEXT = "RecipeBook v. "
--RECIPEBOOK_VERSION = RECIPEBOOK_VERSION_TEXT..RECIPEBOOK_VERSION_NUMBER;
--RECIPEBOOK_SEND_TIMEOUT = 30; --Seconds until the Recipebook window times out.
--RECIPEBOOK_AUTOSEND_TIMEOUT = 3; --Seconds between sending RecipeBook information.
--RECIPEBOOK_SEND_PAUSE = 3; --Seconds to pause between batches of information.
--RECIPEBOOK_INITIAL_PAUSE = 3; --Seconds to pause before assuming an incompatible version.
--RECIPEBOOK_BATCHLENGTH = 1; --How many recipes to send at a time.

--RECIPEBOOK_RED = "|cffff0000";
--RECIPEBOOK_ORANGE = "|cffff9900";
--RECIPEBOOK_YELLOW = "|cffffff00";
--RECIPEBOOK_GREEN = "|cff00ff00";
--RECIPEBOOK_CYAN = "|cff33ccff";
--RECIPEBOOK_GREY = "|ccccccc00";
--RECIPEBOOK_END = "|r";

--RECIPEBOOK_COLOR = {
--	[""] 		= { r = 1.00, g = 1.00, b = 1.00 };
--	["optimal"]	= { r = 1.00, g = 0.50, b = 0.25 };
--	["medium"]	= { r = 1.00, g = 1.00, b = 0.00 };
--	["easy"]	= { r = 0.25, g = 0.75, b = 0.25 };
--	["trivial"]	= { r = 0.50, g = 0.50, b = 0.50 };
--	["shared"] 	= { r = 1.00, g = 1.00, b = 1.00 };
--};


RECIPEBOOK_LOADED = string.format(RECIPEBOOK_VERSION.." geladen! Um die Optionen an zu zeigen bitte "..RECIPEBOOK_YELLOW.."/recipebook help"..RECIPEBOOK_END.." oder "..RECIPEBOOK_YELLOW.."/rb help"..RECIPEBOOK_END.." eingeben; f\195\188r das Konfigurationsfenster "..RECIPEBOOK_YELLOW.."/rb config"..RECIPEBOOK_END.." eingeben.");

RECIPEBOOK_USAGE = {
	RECIPEBOOK_GREEN.."Steuerung:"..RECIPEBOOK_END.." "..RECIPEBOOK_YELLOW.."/recipebook"..RECIPEBOOK_END.." oder "..RECIPEBOOK_YELLOW.."/rb"..RECIPEBOOK_END.." mit den folgenden Optionen eingeben:",
	"   (keine Angaben) : Alle RecipeBook Optionen anzeigen.",
	"   "..RECIPEBOOK_YELLOW.."help"..RECIPEBOOK_END.." : Hilfe anzeigen.",
	"   "..RECIPEBOOK_YELLOW.."on|off"..RECIPEBOOK_END.." : Anzeige von RecipeBook Daten ein- oder ausschalten.",
	"   "..RECIPEBOOK_YELLOW.."config"..RECIPEBOOK_END.." : Damit \195\182ffnet man das Konfigurationsfenster.",
	"   "..RECIPEBOOK_YELLOW.."tooltip on|off"..RECIPEBOOK_END.." : Tooltip Anzeige display ein- oder ausschalten.",
	"   "..RECIPEBOOK_YELLOW.."chatframe on|off"..RECIPEBOOK_END.." : Anzeige im Chatfenster ein- oder ausschalten.",
	"   "..RECIPEBOOK_YELLOW.."friend on|off"..RECIPEBOOK_END.." : Anzeige der Daten von Freunden ein- oder ausschalten.",
	"   ",
	"   "..RECIPEBOOK_YELLOW.."specials"..RECIPEBOOK_END.." : Nach bekannten Spezialisierungen scannen.",
	"   "..RECIPEBOOK_YELLOW.."skill <character|all> <tradeskill|all>"..RECIPEBOOK_END.." : Zeigt die momentan bekannten Rezepte und Berufe des angegebenen Charakters an.  BETA: 'all' eingeben um alle bekannten Berufe eines bestimmten Charakters oder aller Charakter mit einem bestimmten Beruf an zu zeigen.  Die Ausgabe erfolgt nur in den RecipeBook chat.",
	"   ",
	RECIPEBOOK_GREEN.."Bank Optionen:"..RECIPEBOOK_END.." Bitte "..RECIPEBOOK_YELLOW.."/rb <option>"..RECIPEBOOK_END.." f\195\188r die Daten der weiteren Charakter verwenden; Bitte "..RECIPEBOOK_YELLOW.."/rb friend <option>"..RECIPEBOOK_END.." f\195\188r die Daten der Freunde verwenden (z.B. /rb known off schaltet die Anzeige der bekannten Rezepte weiterer Charakter aus; /rb friend known off schaltet die Anzeige der Rezepte von Freunden aus)",
	"   "..RECIPEBOOK_YELLOW.."bank <recipe link | [recipe name]>"..RECIPEBOOK_END.." : Kategorisiert ein Rezept als 'auf der Bank'. Um das zu vereinfachen bitte '/rb bank' eingeben und dann shift+click auf das zu kategorisierende Rezept. Wer es lieber tippt muss den Namen in eckige Klammern setzen: [Rezept Name].",
	"   "..RECIPEBOOK_YELLOW.."unbank <recipe link | [recipe name]>"..RECIPEBOOK_END.." : L\195\182scht ein bestimmtes Rezept von der 'auf der Bank' Liste. Wird genauso benutzt wie /rb bank.",	"   "..RECIPEBOOK_YELLOW.."banklist"..RECIPEBOOK_END.." : (BETA) Zeigt die Rezepte an, die im Moment 'auf der Bank' sind. (Im RecipeeBook chat Fenster).",
	"   "..RECIPEBOOK_YELLOW.."autobank on|off"..RECIPEBOOK_END.." : Umschalten ob Rezepte in der Bank automatisch als 'auf der Bank' markiert werden sollen (Standard ist Aus).",
	"   "..RECIPEBOOK_YELLOW.."autobag on|off"..RECIPEBOOK_END.." : Umschalten ob die Rezepte in Taschen automatisch als 'auf der Bank' gekennzechnet werden sollen beim ausloggen und beim Benutzen der Bank (Standard ist Aus).",
	"   "..RECIPEBOOK_YELLOW.."banklist"..RECIPEBOOK_END.." : Gibt im RecipeBook Chat Fenster die Rezepte aus die im Moment auf der Bank sind.",
        "   ",
	"   "..RECIPEBOOK_YELLOW.."reset <tradeskill|all>"..RECIPEBOOK_END.." : Setzt einen angegebenen Beruf des aktuellen Charakters zur\195\188ck (l\195\182scht die Eintr\195\162ge in der Datenbank). Optional: setzt alle Berufe des aktuellen Charakters zur\195\188ck.",
	"   "..RECIPEBOOK_YELLOW.."clear <character>"..RECIPEBOOK_END.." : Alle Daten des angegebenen Charakters l\195\182schen. Kann nicht f\195\188r den aktuellen Charakter verwendet werden. (siehe /rb reset)",
	"   "..RECIPEBOOK_YELLOW.."send <player> <tradeskill>"..RECIPEBOOK_END.." : Sendet deine RecipeBook Daten f\195\188r den angegebenen Beruf an einen anderen Spieler. 'all' als Beruf eingeben um alle Berufe des aktuellen Charakters zu senden.",
	"   "..RECIPEBOOK_YELLOW.."receive <friend|guild|others> <accept|decline|prompt>"..RECIPEBOOK_END.." : Legt f\195\188r jede Gruppe (Freunde, Gildenmitglieder, die nicht auf der Freundesliste sind, und alle anderen) fest, wie mit gesendete RecipeBook Daten umgegangen werden soll: automatisch annehmen, ablehnen, oder r\195\188ckfragen.",
	"   ",
	RECIPEBOOK_GREEN.."Display Options:"..RECIPEBOOK_END.." F\195\188r die Daten der eigenen Charakter "..RECIPEBOOK_YELLOW.."/rb <option>"..RECIPEBOOK_END.." verwenden; f\195\188r Freunde "..RECIPEBOOK_YELLOW.."/rb friend <option>"..RECIPEBOOK_END.." (z.B. /rb known off schaltet die Anzeige aller Rezepte der eigenen Charakter ab; /rb friend known off schaltet die Anzeige aller Rezepte von Freunden ab.)",
	"   "..RECIPEBOOK_YELLOW.."known on|off"..RECIPEBOOK_END.." : Anzeigen/nicht anzeigen der Charakter die das Rezept beherrschen.",
	"   "..RECIPEBOOK_YELLOW.."learn on|off"..RECIPEBOOK_END.." : Anzeigen/nicht anzeigen der Charakter die das Rezept lernen k\195\182nnen",
	"   "..RECIPEBOOK_YELLOW.."future on|off"..RECIPEBOOK_END.." : Anzeigen/nicht anzeigen der Charakter die noch nicht den n\195\188tigen Fertigkeitslevel erreicht haben (wenn das Rezept eine Spezialisierung erfordert, muss der Charakter die entsprechende Spezialisierung haben).",
	"   "..RECIPEBOOK_YELLOW.."banked on|off"..RECIPEBOOK_END.." : Anzeigen/nicht anzeigen ob das Rezept als 'auf der Bank' markiert ist. (Standard ist OFF).",
	"   "..RECIPEBOOK_YELLOW.."faction same|opposite|both"..RECIPEBOOK_END.." : Daten f\195\188r Charakter eine bestimmten Fraktion anzeigen oder f\195\188r beide Fraktionen anzeigen.",
        "   "..RECIPEBOOK_YELLOW.."auction <altslearn|altsfuture|youfuture|noalts|allknown> <r,g,b>"..RECIPEBOOK_END.." verwenden um die Farben f\195\188r das Auktionshaus zu setzen.  Die Werte f\195\188r r,g und b m\195\188ssen zwischen 0 und 1 sein.",
	};

--== Built-in data strings ==--
RECIPEBOOK_RECIPEPREFIXES = "Formel Muster Pl\195\164ne Rezept Bauplan Anleitung";
RECIPEBOOK_RECIPEWORD = "Rezept";

RECIPEBOOK_ALCHEMY = "Alchimie";
RECIPEBOOK_BLACKSMITHING = "Schmiedekunst";
RECIPEBOOK_WEAPONSMITH = "Waffenschmied";
RECIPEBOOK_MASTER = "meister";
RECIPEBOOK_BLACKSMITHING_SPECIALS = "|R\195\188stungsschmied |Waffenschmied |Schwertschmiedemeister |Axtschmiedemeister |Hammerschmiedemeister |";
RECIPEBOOK_ENCHANTING = "Verzauberkunst";
RECIPEBOOK_ENGINEERING = "Ingenieurskunst";
RECIPEBOOK_ENGINEERING_SPECIALS = "|Goblin-Ingenieur |Gnomen-Ingenieur |";
RECIPEBOOK_LEATHERWORKING = "Lederverarbeitung";
RECIPEBOOK_LEATHERWORKING_SPECIALS = "|Stammeslederverarbeitung |Elementarlederverarbeitung |Drachenschuppenlederverarbeitung |";
RECIPEBOOK_TAILORING = "Schneiderei";
RECIPEBOOK_COOKING = "Kochkunst";
RECIPEBOOK_FIRSTAID = "Erste Hilfe";

RECIPEBOOK_RECIPENAMES = table.concat({RECIPEBOOK_ALCHEMY,RECIPEBOOK_BLACKSMITHING,RECIPEBOOK_ENCHANTING,RECIPEBOOK_ENGINEERING,RECIPEBOOK_LEATHERWORKING,RECIPEBOOK_TAILORING,RECIPEBOOK_COOKING,RECIPEBOOK_FIRSTAID}, " ");

--== Necessary for the parser ==--
RECIPEBOOK_CHAT_SKILLUP = gsub(gsub(ERR_SKILL_UP_SI, "%%1%$s", "(%%w)*"), "%%2%$d", "(%%d+)%%");
RECIPEBOOK_CHAT_LEARN_RECIPE = string.sub(ERR_LEARN_RECIPE_S, 1, -4);
RECIPEBOOK_CHAT_LEARN_SPELL = string.sub(ERR_LEARN_SPELL_S, 1, -4);
--== Regular Expressions for Pattern matching==--
RECIPEBOOK_REGEX_REQUIRES = string.gsub(string.gsub(ITEM_MIN_SKILL, "%%1$s", "%(%[%%w%%s%]+%)" ), "%(%%2$d%)", "%%%(%(%%d+%)%%%)");
RECIPEBOOK_REGEX_SPECIALTY = string.gsub(ITEM_REQ_SKILL, "%%1$s", "%(%%w+%)%(%.%*%)" );
RECIPEBOOK_REGEX_LEVEL = string.gsub(ITEM_MIN_LEVEL, "%(%%2$d%)", "%%%(%(%%d+%)%%%)");
RECIPEBOOK_REGEX_NOTONLINE = string.gsub(ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "%(%%w+%)");
RECIPEBOOK_REGEX_UNLEARNSKILL = string.gsub(ERR_SPELL_UNLEARNED_S, "%%s", "(%%w+)");

--== Chatframe Output ==--
RECIPEBOOK_CHATFRAME_KNOWNBY = " wird bereits beherrscht von: ";
RECIPEBOOK_CHATFRAME_NONEKNOWN = " ist noch nicht bekannt.";
RECIPEBOOK_CHATFRAME_CANLEARN = " kann gelernt werden von: ";
RECIPEBOOK_CHATFRAME_NONELEARN = " kann von niemandem gelernt werden.";
RECIPEBOOK_CHATFRAME_WILLLEARN = " kann sp\195\164ter gelernt werden von (momentanes Fertigkeitslevel): ";
RECIPEBOOK_CHATFRAME_NONEWILLLEARN = " kann von niemandem mit einem h\195\182heren Fertigkeitslevel gelernt werden";
RECIPEBOOK_CHATFRAME_BANKED = " ist 'auf der Bank'.";
RECIPEBOOK_CHATFRAME_NOTBANKED = " ist nicht 'auf der Bank'.";
RECIPEBOOK_CHATFRAME_BANKLISTPERSONALHEADER = "Rezepte 'Auf der Bank'  (nur die von Charakter %s):";
RECIPEBOOK_CHATFRAME_BANKLISTBLANK = "  F\195\188r %s wurden keine Rezepte gefunden";
RECIPEBOOK_CHATFRAME_BANKLISTHEADER = "Rezepte 'auf der Bank'  (nur  f\195\188r diese Fraktion):";

--== Tooltip Output ==--
RECIPEBOOK_KNOWNBY = "Bereits beherrscht von: ";
RECIPEBOOK_CANLEARN = "Kann gelernt werden von: ";
RECIPEBOOK_WILLLEARN = "Kann sp\195\164ter gelernt werden von: ";
RECIPEBOOK_ISBANKED = "Rezept ist 'auf der Bank' von: ";

--== /rb Command output ==--
RECIPEBOOK_FRIEND_PREFIX = "  F\195\188r Freunde: "

RECIPEBOOK_ON = RECIPEBOOK_GREEN.."An"..RECIPEBOOK_END;
RECIPEBOOK_OFF = RECIPEBOOK_RED.."Aus"..RECIPEBOOK_END;

RECIPEBOOK_SHOW = RECIPEBOOK_GREEN.."Zeige"..RECIPEBOOK_END;
RECIPEBOOK_HIDE = RECIPEBOOK_RED.."Verstecke"..RECIPEBOOK_END;

RECIPEBOOK_TXT_SUPPLIES = "Zutaten ben\195\182tigt f\195\188r ";

--Toggle On|Off options
RECIPEBOOK_STATUS_ONOFF = "RecipeBook Datenausgabe: %s (Daten werden immer gesammelt)";
RECIPEBOOK_FRIENDSHOW_ONOFF = "Anzeuge der Daten von Freunden: %s";
RECIPEBOOK_AUTOBANK_ONOFF = "Automatisches scannen der Bank beim \195\182ffnen ist %s";
RECIPEBOOK_AUTOBAGS_ONOFF = "Automatisches scannen der Taschen beim ausloggen ist %s";

--Toggle Show|Hide options
RECIPEBOOK_SHOWSELF_SHOWHIDE = "%s Daten f\195\188r den aktuellen Charakter.";
RECIPEBOOK_KNOWN_SHOWHIDE = "%s Daten f\195\188r Charakter die Rezepte bereits erlernt haben.";
RECIPEBOOK_CANLEARN_SHOWHIDE = "%s Daten f\195\188r Charakter die Rezepte erlernen k\195\182nnen.";
RECIPEBOOK_WILLLEARN_SHOWHIDE = "%s Daten f\195\188r Charakter die dieses Rezept sp\195\164ter lernen k\195\182nnen.";
RECIPEBOOK_BANKED_SHOWHIDE = "%s Anzeigen ob bestimmte Rezepte 'auf der Bank' sind."

--Toggle Specific Options
RECIPEBOOK_OUTPUT_TOOLTIP = "RecipeBook Info wird nun im ToolTip ausgegeben.";
RECIPEBOOK_OUTPUT_CHATFRAME = "RecipeBook Info wird nun im RecipeBook Chatfenster ausgegeben.";
--
RECIPEBOOK_DISPLAY_FACTION = "Treffer werden nur f\195\188r Deine %s Character angezeigt.";
RECIPEBOOK_DISPLAY_BOTHFACTIONS = "Treffer werden f\195\188r Allianz und Horde Character angezeigt.";
RECIPEBOOK_DISPLAY_NOFACTIONS = "Es ist keine Fraktion ausgew\195\164hlt. Daher werden keine Treffer angezeigt.";
--
RECIPEBOOK_ACCEPT_ALL = "Alle \195\188bertragenen RecipeBook Daten werden automatisch angenommen.";
RECIPEBOOK_DECLINE_ALL= "Alle \195\188bertragenen RecipeBook Daten werden automatisch abgewiesen.";
RECIPEBOOK_PROMPT_ALL = "F\195\188r \195\188bertragenen RecipeBook Daten ist die R\195\188ckfrage ob angenommen werden soll aktiviert.";
RECIPEBOOK_RFRIENDS = "Freunde: ";
RECIPEBOOK_RGUILD = "; Gildenmitglieder: ";
RECIPEBOOK_ROTHERS = "; Andere: ";
RECIPEBOOK_AUTOACCEPT = RECIPEBOOK_GREEN.."Automatisch annehmen"..RECIPEBOOK_END.." shares";
RECIPEBOOK_AUTODECLINE = RECIPEBOOK_RED.."Automatisch ablehnen"..RECIPEBOOK_END.." shares";
RECIPEBOOK_PROMPT = "Vor Empfang fragen";
--
RECIPEBOOK_ADDED_SPECIALS = "Die folgende(n) Spezialisierung(en) wurde(n) gefunden und hinzugef\195\188gt: ";

--Error Messages
RECIPEBOOK_INVALID_OUTPUT = "Ung\195\188ltige Angabe f\195\188r die Ausgabe.  G\195\188ltige Angaben sind: /rb output [tooltip|chatframe|both] [on|off]";
RECIPEBOOK_INVALID_DISPLAY = "Ung\195\188ltige Angabe f\195\188r die Anzeige.  G\195\188ltige Angaben sind: same, opposite, both";
RECIPEBOOK_INVALID_ONOFF = "Falsche Angabe. Erlaubte Angaben sind: on, off";

RECIPEBOOK_NOALTGIVEN = "Ich wei\195\159 nicht f\195\188r wen ich Rezepte auslisten soll.  Bitte "..RECIPEBOOK_YELLOW.."/recipebook skill <alt> <tradeskill>"..RECIPEBOOK_END.." eingeben, um Berufe f\195\188r einen Charakter aufzulisten.";
RECIPEBOOK_NOALTMATCH = "Keine Treffer gefunden f\195\188r Charakter ";
RECIPEBOOK_NOTRADESKILLGIVEN = "Ich wei\195\159 nicht f\195\188r welchen Beruf ich Rezepte auflisten soll.  Bitte "..RECIPEBOOK_YELLOW.."/recipebook skill <alt> <tradeskill>"..RECIPEBOOK_END.." eingeben, um Berufe f\195\188r einen Charakter aufzulisten.";
RECIPEBOOK_NOTRADESKILLMATCH = "Keine Berufe gefunden f\195\188r ";

RECIPEBOOK_RECEIVE_USAGE = "Optionen: "..RECIPEBOOK_YELLOW.."/rb receive <friend|guild|others> <accept|decline|prompt>"..RECIPEBOOK_END..". accept nimmt \195\188bertragungen immer an, decline lehnt immer ab, und prompt \195\182ffnet die R\195\188ckfrage."
RECIPEBOOK_NOTINGUILD = "Nicht in einer Gilde!";

RECIPEBOOK_INVALID_RESET = "Welche Daten sollten zur\195\188ck gesetztwerden? Bitte "..RECIPEBOOK_YELLOW.."/rb reset <tradeskill>"..RECIPEBOOK_END.." verwenden um einen Beruf des aktuellen Charakters zur\195\188ck zu setzen. /rb reset all setzt alle Berufe des aktuellen Charakters zur\195\188ck.";
RECIPEBOOK_RESET_SUCCEED = "Daten sind erfolgreich zur\195\188ck gesetzt f\195\188r den Beruf ";
RECIPEBOOK_RESET_FAIL = "Daten k\195\182nnen nicht zur\195\188ck gesetzt werden f\195\188r den Beruf ";
RECIPEBOOK_RESET_ALL = "Alle Daten sind gel\195\188scht worden f\195\188r ";
RECIPEBOOK_RESET_MASTERLIST = "Die Masterliste wurde erfolgreich zur\195\188ck gesetzt.";
RECIPEBOOK_ERROR_RESETSELF = "/rb clear kann nicht f\195\188r den aktuellen Charakter verwendet werden.  /rb reset all verwenden um alle Berufe des aktuellen Charakters zu l\195\182schen.";

RECIPEBOOK_BANK_SUCCEED =  "%s! erfolgreich 'auf die Bank' gelegt";
RECIPEBOOK_BANK_FAIL =  "Bitte eine Rezept ausw\195\164hlen oder den Titel des Rezeptes (im [Rezept Name] Format) eingeben um ein Rezept 'auf die Bank' zu legen.";
RECIPEBOOK_BANK_ALREADYBANKED = "Das Rezept ist f\195\188r diesen Charakter bereits als 'auf der Bank' markiert.  Wenn es wirklich manuell (nochmal) 'auf die Bank gelegt' werden soll, Bitte zuerst '/rb unbank [Link]' benutzen.";
RECIPEBOOK_UNBANK_SUCCEED=  "%s wurde 'von der Bank' entfernt!";
RECIPEBOOK_UNBANK_ALLSUCCEED = "Das Rezept %s ist nun f\195\188r keinen Charakter mehr als 'auf der Bank' markiert.";
RECIPEBOOK_UNBANK_FAIL=  "Kein Treffer in den Rezepten die als 'auf der Bank' markiert sind. Bitte ein Rezept ausw\195\164len oder den Titel des Rezeptes (im [Rezept Name] Format) eingeben um es 'von der Bank' zu entfernen.";

RECIPEBOOK_AUTOBANK = "Diese Rezepte wurden 'in die Bank' getan: ";
RECIPEBOOK_AUTOUNBANK = "Diese Rezepte wurden 'aus der Bank' entfernt: ";
RECIPEBOOK_AUTOBAG = "Diese Rezepte wurden in %s Taschen genommen: ";

RECIPEBOOK_ERROR_INVALIDCOLOR = "Die Farbe konnte nicht festgelegt werden.  Bitte "..RECIPEBOOK_YELLOW.."/rb auction <altslearn|altsfuture|youfuture|noalts|allknown> <r,g,b>"..RECIPEBOOK_END.." verwenden um die Farben f\195\188r das Auktionshaus zu setzen.  Die Werte f\195\188r r,g und b m\195\188ssen zwischen 0 und 1 sein.";
RECIPEBOOK_AUCCOLOR_ALTSCANLEARN = "Rezeptfarbe, die von Anderen gelernt werden k\195\182nnen (ohne den aktuellen Charakter).";
RECIPEBOOK_AUCCOLOR_ALTSWILLLEARN = "Rezeptfarbe, die von Anderen sp\195\164ter gelernt werden k\195\182nnen (ink. des akt. Charakters).";
RECIPEBOOK_AUCCOLOR_YOUWILLLEARN = "Farbe f\195\188r die Rezepte, die von diesem Charaktern sp\195\164ter gelernt werden k\195\182nnen.";
RECIPEBOOK_AUCCOLOR_NOALTSCANLEARN = "Farbe f\195\188r die Rezepte, die von niemandem gelernt werden k\195\182nnen.";
RECIPEBOOK_AUCCOLOR_ALLALTSKNOW = "Farbe f\195\188r die Rezepte, die alle eigenen Charakter bereits beherrschen.";

--== RecipeBook_Print() ==--
RECIPEBOOK_ERROR_PREFIX = "|cffffff00<|cffff0000RecipeBook Fehler|cffffff00>|r ";
RECIPEBOOK_PREFIX = "|cffffff00<RecipeBook>|r ";

--== Config ==--
RECIPEBOOK_CONFIG_TITLEBAR = "RecipeBook Konfiguration";

RECIPEBOOK_CBX_DISPLAYTOGGLE_TEXT = "Recipe Book Anzeige";
RECIPEBOOK_CBX_FRIENDSDISPLAYTOGGLE_TEXT = "Freundes Daten";
RECIPEBOOK_CBX_SELFDISPLAYTOGGLE_TEXT = "Eigenen Daten";
RECIPEBOOK_CBX_BANKDISPLAYTOGGLE_TEXT = "Bank Daten";
RECIPEBOOK_CBX_AUCTIONDISPLAYTOGGLE_TEXT = "Auktionen farbig markieren";
RECIPEBOOK_CBX_AUCTIONBLACKBANKEDTOGGLE_TEXT = "Rezepte auf der Bank schwarz anzeigen";
RECIPEBOOK_CBX_TRACKSELF_TEXT = "Rezept Daten f\195\188r diesen Charakter sammeln";
RECIPEBOOK_CBX_KNOW_TEXT = "Bereits bekannt sind";
RECIPEBOOK_CBX_LEARN_TEXT = "Erlernt werden kk\195\182nen";
RECIPEBOOK_CBX_WILLLEARN_TEXT = "Sp\195\164ter gelernt werden k\195\182nnen";
RECIPEBOOK_CBX_OUTPUTTOOLTIP_TEXT = "Tooltip";
RECIPEBOOK_CBX_OUTPUTCHATFRAME_TEXT = "RecipeBook Chat";
RECIPEBOOK_CBX_SAMEFACTION_TEXT = "Gleiche Fraktion";
RECIPEBOOK_CBX_OPPOSITEFACTION_TEXT = "Gegnerische Fraktion";
RECIPEBOOK_CBX_AUTOBANK_TEXT = "Bankf\195\164cher";
RECIPEBOOK_CBX_AUTOBAGS_TEXT = "Taschen";

RECIPEBOOK_DD_FRIENDSHARE = "Freunde";
RECIPEBOOK_DD_GUILDSHARE = "Gildenmitglieder";
RECIPEBOOK_DD_OTHERSHARE = "Alle Anderen";

RECIPEBOOK_CONFIG_HEADER_GENERAL = "RecipeBook: Allgemeine Optionen";
RECIPEBOOK_CONFIG_HEADER_COLLECTION = "RecipeBook: Datenerfassung";
RECIPEBOOK_CONFIG_HEADER_SHARE = "RecipeBook: Informationsaustausch";
RECIPEBOOK_CONFIG_HEADER_AUCTION = "RecipeBook: Auktionshaus";

RECIPEBOOK_CONFIG_TAB_GENERAL = "Allgemein";
RECIPEBOOK_CONFIG_TAB_SHARING = "Austausch";
RECIPEBOOK_CONFIG_TAB_AUCTION = "Auktionen";
RECIPEBOOK_CONFIG_TAB_BANKING = "Erfassung";

RECIPEBOOK_CONFIG_TEXT_SHOWCATEGORIES = "Zeige Rezepte die:";
RECIPEBOOK_CONFIG_TEXT_OUTPUT = "Gib Rezept Informationen aus im:";
RECIPEBOOK_CONFIG_TEXT_FACTION = "Zeige Rezept Daten f\195\188r :";
RECIPEBOOK_CONFIG_TEXT_SHARE = "M\195\182glichkeiten wenn eine Anfrage zum Teilen von RecipeBook kommt:";
RECIPEBOOK_CONFIG_DD_SHARE = {
	{name = "A", text = "Akzeptieren"},
	{name = "D", text = "Ablehnen"},
	{name = "P", text = "R\195\188ckfrage"}
	};
 RECIPEBOOK_CONFIG_TEXT_AUTOTRACK = "Rezepte \195\188berwachen die als 'auf der Bank' gekennzeichnet sind f\195\188r:";

 --== Search Panels ==--
RECIPEBOOK_SEARCH_TITLEBAR = "RecipeBook Suche";
RECIPEBOOK_CBX_SEARCHMATS_TEXT = "Materialien Suche";
RECIPEBOOK_CBX_SEARCHITEMS_TEXT = "In den bekannten Rezepten suchen";
RECIPEBOOK_ERR_NOSEARCHRESULT = "Keine Treffer";
RECIPEBOOK_SEARCHTEXT_MATSPREFIX = "  Ben\195\182tigt: ";
RECIPEBOOK_SEARCHTEXT_ITEMSTEMPLATE = " Beherrscht von: %d Charaktern (%d haben auch noch %s)";

--== Send Data ==--
RECIPEBOOK_SEND_USAGE = "Befehl: "..RECIPEBOOK_YELLOW.."/rb send <person> <tradeskill>"..RECIPEBOOK_END;
RECIPEBOOK_MATCHEDSELF = "Es gibt keinen Grund sich selber Daten zu schicken. Und abgesehen davon funktioniert es gar nicht ;-).";
RECIPEBOOK_MESSAGE_TRIGGER_WORD = "Recipe\195\159ook";
RECIPEBOOK_MESSAGE_TRIGGER = "["..RECIPEBOOK_MESSAGE_TRIGGER_WORD.."]";

--== Pentarion: mit Absicht nicht \195\188bersetzt um die Kommunikation zwischen den Sprachen nicht zu st\195\182ren:
--RECIPEBOOK_MESSAGE_INITIATE = " Hello, this is RecipeBook.  I'd like to initiate a share for ";
--RECIPEBOOK_MESSAGE_TERMINATE = " Completed RecipeBook share for ";
--RECIPEBOOK_MESSAGE_CANCEL = " Cancel RecipeBook share for ";
--RECIPEBOOK_MESSAGE_ACCEPT = " Accept RecipeBook share for ";
--RECIPEBOOK_MESSAGE_BUSY = " Receiver busy, try again later";
--RECIPEBOOK_MESSAGE_ACKNOWLEDGE = " Acknowledging receipt of RecipeBook share data [spam protection].";

RECIPEBOOK_ERROR_AUTODECLINE = " mag im Moment keine Daten empfangen f\195\188r ";
RECIPEBOOK_ERROR_DECLINEDSESSION = "Die \195\188bertragung der RecipeBook Daten von %s wurde automatisch abgelehnt.";
RECIPEBOOK_ERROR_ACCEPTEDSESSION = "Die RecipeBook Informationen wurden automatisch angenommen von %s f\195\188r %s.";

RECIPEBOOK_ERROR_BUSY = "%s ist im Moment besch\195\164ftigt. Bitte in ein paar Minuten nochmal probieren.";
RECIPEBOOK_ERROR_CANCEL = "RecipeBook Sitzung wurde abgebrochen..";
RECIPEBOOK_ERROR_INITIATE = "RecipeBook versucht %s Daten an %s zu \195\188bertragen...";
RECIPEBOOK_ERROR_TERMINATE = "RecipeBook Daten erfolgreich gesendet!";
RECIPEBOOK_ERROR_RECEIVED = "RecipeBook Daten erfolgreich empfangen!";

RECIPEBOOK_POPUP_SEND = "RecipeBook versucht %s Daten an %s zu \195\188bertragen.  Die \195\188bertragung wird in %d %s abgebrochen.";
RECIPEBOOK_POPUP_RECEIVE = "%s m\195\182chte %s Daten \195\188bertragen.  Die \195\188bertragung wird in %d %s abgebrochen.";
RECIPEBOOK_POPUP_PAUSE = "RecipeBook h\195\164lt die \195\188bertragung zur\195\188ck damit der SpamSchutz dich nicht auslogged. Die \195\188bertragung wird in %d %s fortgesetzt.";

--== Correct Enchantments ==--
RECIPEBOOK_ENCHANTING_FILLER = "verzaubern ";

--== Key Bindings ==--
BINDING_HEADER_RECIPEBOOK = "RecipeBook Tasten";
--BINDING_NAME_RECIPEBOOK_SKILL = "(coming soon) Skill Panel";
BINDING_NAME_RECIPEBOOK_CONFIG = "Konfigurationsfenster";
BINDING_NAME_RECIPEBOOK_SEARCH = "Suchfenster";

--== Exceptions ==--  ["Item as it appears in tradeskill frame"] = "Item as it appears in recipe"
-- im Deutschen stimmen:       "Mechanisches Eichh\195\182rnchen",  "Schwere Skorpidstulpen", 
RECIPEBOOK_EXCEPTIONS = {
["Alarm-O-Bot"] = "Gnomischer Alarm-O-Bot",
["Rotes Festtagskleid"] = "Festtagskleid",
["Festlicher roter Hosenanzug"] = "Festtagsanzug",
}

end