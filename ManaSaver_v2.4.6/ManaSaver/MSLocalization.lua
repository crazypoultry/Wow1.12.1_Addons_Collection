-- Baden's ManaSaver Mod
-- Baden - Dragonmarch - Silvermoon Server
-- Arax - Dragonmarch - Silvermoon Server

-- Colors
MANASAVE_FONT_RED = "|cffff2020";
MANASAVE_FONT_NORMAL = "|cffffd200";
MANASAVE_FONT_WHITE = "|cffffffff";
MANASAVE_FONT_GREEN = "|cff20ff20";
MANASAVE_FONT_BLUE = "|cff2020ff";
MANASAVE_FONT_LTYELLOW = "|cffffff9a";
MANASAVE_FONT_GRAY = "|cff808080"; 

MANASAVE_VERSION = "2.4.6";

-- **************************************************
-- *********** Localization *************************
-- **************************************************

-- English
-- Variable to store the word Rank
MANASAVE_RANK = "Rank";
-- Spells
MANASAVE_SPELL_HEALTOUCH = "Healing Touch";
MANASAVE_SPELL_REGROWTH = "Regrowth";
MANASAVE_SPELL_REJUVENATION = "Rejuvenation";
MANASAVE_SPELL_LESSHEAL = "Lesser Heal";
MANASAVE_SPELL_HEAL = "Heal";
MANASAVE_SPELL_GRTHEAL = "Greater Heal";
MANASAVE_SPELL_ALLHEAL = "All Heal";  -- Note this is the same for all languages
MANASAVE_SPELL_FLASHHEAL = "Flash Heal";
MANASAVE_SPELL_RENEW = "Renew";
MANASAVE_SPELL_HOLYLIGHT = "Holy Light";
MANASAVE_SPELL_FLASHOFLIGHT = "Flash of Light";
MANASAVE_SPELL_LESSHEALWAVE = "Lesser Healing Wave";
MANASAVE_SPELL_HEALWAVE = "Healing Wave";
MANASAVE_SPELL_CHAINHEAL = "Chain Heal";
-- Talents with increase percentage of healing
MANASAVE_TALENT_IMPREJUVE = "Improved Rejuvenation";
MANASAVE_TALENT_GIFTNATURE = "Gift of Nature";
MANASAVE_TALENT_HEALLIGHT = "Healing Light";
MANASAVE_TALENT_IMPRENEW = "Improved Renew";
MANASAVE_TALENT_SPIRITHEAL = "Spiritual Healing";
MANASAVE_TALENT_PURIFICATION = "Purification";
MANASAVE_TALENT_SPIRITGUIDANCE = "Spiritual Guidance";
-- Talents with decreased spell mana costs
MANASAVE_TALENT_TRANQSPIRIT = "Tranquil Spirit";
MANASAVE_TALENT_IMPHEALING = "Improved Healing";
MANASAVE_TALENT_TIDALFOCUS = "Tidal Focus";
-- System responses
MANASAVE_CHAT_VERSION = "ManaSaver Version NUMVER loaded.";
MANASAVE_CHAT_QUIETON = "<ManaSaver>: Quiet Mode ON";
MANASAVE_CHAT_QUIETOFF = "<ManaSaver>: Quiet Mode OFF";
MANASAVE_CHAT_QUIETDEF = "<ManaSaver>: Default Mode ON";
MANASAVE_CHAT_QUIETSELF = "<ManaSaver>: Default Mode SELF";
MANASAVE_CHAT_QUIETMENU1 = "/msaverq on (Turns on ManaSaver quiet mode)";
MANASAVE_CHAT_QUIETMENU2 = "/msaverq off (Turns on ManaSaver smart aleck messages)";
MANASAVE_CHAT_QUIETMENU3 = "/msaverq default (Turns on ManaSaver default messages)";
MANASAVE_CHAT_QUIETMENU4 = "/msaverq self (Turns on ManaSaver default messages to player's chat window)";
MANASAVE_CHAT_QUIETPROPER = "Proper usage is:";
MANASAVE_CHAT_SPELLFAILRANGE = "<ManaSaver>: Spell Failed: Target is out of range.";
MANASAVE_CHAT_SPELLFAILSIGHT = "<ManaSaver>: Spell Failed: Target is not in line of sight.";
MANASAVE_CHAT_SPELLFAILMANA = "<ManaSaver>: Spell Failed: Not enough mana.";
MANASAVE_CHAT_SPELLFAILPOWER = "<ManaSaver>: Spell Failed: A more powerful spell is already active.";
MANASAVE_CHAT_SPELLFAILMOVE = "<ManaSaver>: Spell Failed: You were moving while trying to cast.";
MANASAVE_CHAT_MSAVERNOSPELL = "<ManaSaver>: Error: ManaSaver does not have data on that spell.";
MANASAVE_CHAT_PLAYERNOKNOWSPELL = "<ManaSaver>: Error: Your character does not know that spell or rank.";
-- Chat posts regarding casting of spells
MANASAVE_CHAT_POSTDEFAULT = "Healing XPLAYER with XSPELLNAME (Rank XRANK)";
-- Chat jokes regarding casting of spells
MANASAVE_CHAT_POSTJOKE1 = "XPLAYER is looking pale, gonna heal ya with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE2 = "XPLAYER doesn't look so hot, healing with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE3 = "I know its just a flesh wound XPLAYER, but I'm healing you with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE4 = "Oh great, XPLAYER is bleeding all over, XSPELLNAME (Rank XRANK) should take care of that.";
MANASAVE_CHAT_POSTJOKE5 = "Death is near XPLAYER... or is it? Perhaps a heal with XSPELLNAME (Rank XRANK) will keep you with us.";
MANASAVE_CHAT_POSTJOKE6 = "XPLAYER, lack of HP got you down? XSPELLNAME (Rank XRANK) to the rescue!";
MANASAVE_CHAT_POSTJOKE7 = "We got a bleeder! Administering 100ccs of XSPELLNAME (Rank XRANK) to XPLAYER stat!";
MANASAVE_CHAT_POSTJOKE8 = "hmm...to heal or not to heal...healing XPLAYER with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE9 = "MEDIC! XPLAYER is gonna die! Oh wait that's me...healing with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE10 = "OMG who's supposed to be healing?  XPLAYER is not looking so good!  Oh wait...nevermind...healing XPLAYER with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE11 = "Oh boy...XPLAYER is taking a beating again.  Put some gum on it Whimp!  Just kidding...healing XPLAYER with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE12 = "Remember to buy some healing potions next time cheapskate!  Just kidding...healing XPLAYER with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE13 = "HEY, putzburger, XPLAYER, you look a wreck.  Here is something to help you out, XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE14 = "STOP BLEEDING ALL OVER THE CARPET, I just had it cleaned.  Let's stop XPLAYER's bleeding with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE15 = "(weak-l-ing) n. XPLAYER with as few hitpoints as you have right now.  Recommended solution is healing with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE16 = "XPLAYER has lost so much blood that even a vampire would pass him/her by.  Lets fix that with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE17 = "It looks like XPLAYER is about to die.  CHEER!!!.  Oops, I did not mean to say that out loud.  Lets heal him/her with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE18 = "[*said in a Scottish accent*] I can't hold her together any longer CAPTAIN!!! I think she is gonna BLOW!!! Recommend healing XPLAYER with XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE19 = "XPLAYER is an absolute LOSER!!!  I bet I could fight better than that.  Oh wait, I am a healer and will die without any support.  I had better use XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE20 = "So, an orc with a parrot walked into a bar.  The bartender said . . . Crap, I should stop telling jokes, XPLAYER is about to die!  I should pay attention and cast XSPELLNAME (Rank XRANK).";			
MANASAVE_CHAT_POSTJOKE21 = "I sure hope that XPLAYER is a Grateful Dead fan, because he/she is going to be come the literal translation of the band name.  Quick, I will heal with XSPELLNAME (Rank XRANK)!";
MANASAVE_CHAT_POSTJOKE22 = "XPLAYER looks like a rat that has been run over by a Mack truck!!!  Perhaps XSPELLNAME (Rank XRANK) will increase his/her charisma.";
MANASAVE_CHAT_POSTJOKE23 = "XPLAYER is becoming my MEAT SHIELD and I like my steak extra-rare.  Pass me the A-1 sauce while I cast XSPELLNAME (Rank XRANK).";
MANASAVE_CHAT_POSTJOKE24 = "GET OFF THE GROUND, XPLAYER, YOU SLACKER!!!  What do you think this is, kindergarten!!!  Perhaps XSPELLNAME (Rank XRANK) will be the shot in the arm you need to keep going!";
-- Options Window
MANASAVE_OPTIONS_TITLE = "ManaSaver Options";
MANASAVE_OPTIONS_TABOPTIONS = "Options";
MANASAVE_OPTIONS_TABMACRO = "Macro";
MANASAVE_OPTIONS_CLOSE = "Close";
MANASAVE_OPTIONS_CHAT_TITLE = "Select spell data chat mode:";
MANASAVE_OPTIONS_CHAT_BASICPARTY = "Basic Data to Party/Raid";
MANASAVE_OPTIONS_CHAT_BASICSELF = "Basic Data to Self";
MANASAVE_OPTIONS_CHAT_JOKEPARTY = "Jokes to Party/Raid";
MANASAVE_OPTIONS_CHAT_QUIET = "No Data Posted";
MANASAVE_OPTIONS_INCLUDE_TITLE = "Include the following data in ManaSaver calculations:";
MANASAVE_OPTIONS_INCLUDE_TALENTS = "Talents";
MANASAVE_OPTIONS_INCLUDE_ITEMS = "Healing Items";
MANASAVE_OPTIONS_ADOPTIONS_TITLE = "Additional ManaSaver options:";
MANASAVE_OPTIONS_ADOPTIONS_CUSTOMERROR = "Post Custom Spell Error Text";
MANASAVE_OPTIONS_ADOPTIONS_SHOWMINIMAP = "Show Minimap Button";
MANASAVE_OPTIONS_ADOPTIONS_MINIMAPLOC = "Minimap Button Location";
MANASAVE_OPTIONS_MACRO_TITLE = "Use the buttons below to create ManaSaver macros:";
MANASAVE_OPTIONS_MACRO_HEADER = "----------Spell------------------Rank----Overheal-----";
MANASAVE_OPTIONS_MACRO_RESET = "Reset";
MANASAVE_OPTIONS_MACRO_CREATED = " macro created.";
MANASAVE_OPTIONS_MACRO_UPDATED = " macro updated.";


-- German
-- Translations from Voodoomaker on the Curse-Gaming forums, thank you
if ( GetLocale() == "deDE" ) then
	-- Variable to store the word Rank
	MANASAVE_RANK = "Rang";
	-- Spells
	MANASAVE_SPELL_HEALTOUCH = "Heilende Ber\195\188hrung";
	MANASAVE_SPELL_REGROWTH = "Nachwachsen";
	MANASAVE_SPELL_REJUVENATION = "Verj\195\188ngung";
	MANASAVE_SPELL_LESSHEAL = "Geringes Heilen";
	MANASAVE_SPELL_HEAL = "Heilen";
	MANASAVE_SPELL_GRTHEAL = "Gro\195\159e Heilung";
	MANASAVE_SPELL_FLASHHEAL = "Blitzheilung";
	MANASAVE_SPELL_RENEW = "Erneuerung";
	MANASAVE_SPELL_HOLYLIGHT = "Heiliges Licht";
	MANASAVE_SPELL_FLASHOFLIGHT = "Lichtblitz";
	MANASAVE_SPELL_LESSHEALWAVE = "Geringe Welle der Heilung";
	MANASAVE_SPELL_HEALWAVE = "Welle der Heilung";
	MANASAVE_SPELL_CHAINHEAL = "Kettenheilung";
	-- Talents with increase percentage of healing
	MANASAVE_TALENT_IMPREJUVE = "Verbesserte Verj\195\188ngung";
	MANASAVE_TALENT_GIFTNATURE = "Geschenk der Natur";
	MANASAVE_TALENT_HEALLIGHT = "Heilige Macht";
	MANASAVE_TALENT_IMPRENEW = "Verbesserte Erneuerung";
	MANASAVE_TALENT_SPIRITHEAL = "Spirituelle Heilung";
	MANASAVE_TALENT_PURIFICATION = "L\195\164uterung";
	MANASAVE_TALENT_SPIRITGUIDANCE = "Geistige F\195\188hrung";
	-- Talents with decreased spell mana costs
	MANASAVE_TALENT_TRANQSPIRIT = "Gelassener Geist";
	MANASAVE_TALENT_IMPHEALING = "Verbesserte Heilung";
	MANASAVE_TALENT_TIDALFOCUS = "Gezeiten-Fokus";
-- System responses
	MANASAVE_CHAT_VERSION = "ManaSaver Version NUMVER geladen.";
	MANASAVE_CHAT_QUIETON = "<ManaSaver>: Alle Meldungen AUS";
	MANASAVE_CHAT_QUIETOFF = "<ManaSaver>: Meldungen AN";
	MANASAVE_CHAT_QUIETDEF = "<ManaSaver>: Standard-Nachrichten AN";
	MANASAVE_CHAT_QUIETSELF = "<ManaSaver>: Standard-Nachrichten im Spieler-Chat";
	MANASAVE_CHAT_QUIETMENU1 = "/msaverq on (Schaltet alle ManaSaver-Meldungen aus)";
	MANASAVE_CHAT_QUIETMENU2 = "/msaverq off (Schaltet die ManaSaver-Besserwisser-Meldungen an)";
	MANASAVE_CHAT_QUIETMENU3 = "/msaverq default (Schaltet die ManaSaver Standard-Meldungen an)";
	MANASAVE_CHAT_QUIETMENU4 = "/msaverq self (Schaltet die ManaSaver Standard-Meldungen f\195\188r den Spieler-Chat an)";
	MANASAVE_CHAT_QUIETPROPER = "Bedienungshinweise:";
	MANASAVE_CHAT_SPELLFAILRANGE = "<ManaSaver>: Zauber fehlgeschlagen: Ziel au\195\159er Reichweite.";
	MANASAVE_CHAT_SPELLFAILSIGHT = "<ManaSaver>: Zauber fehlgeschlagen: Ziel nicht im Sichtbereich.";
	MANASAVE_CHAT_SPELLFAILMANA = "<ManaSaver>: Zauber fehlgeschlagen: Nicht genug Mana.";
	MANASAVE_CHAT_SPELLFAILPOWER = "<ManaSaver>: Zauber fehlgeschlagen: Ein m\195\164chtigerer Zauber ist schon aktiv.";
	MANASAVE_CHAT_SPELLFAILMOVE = "<ManaSaver>: Zauber fehlgeschlagen: Kann nicht w\195\164hrend einer Bewegung zaubern.";
	MANASAVE_CHAT_MSAVERNOSPELL = "<ManaSaver>: Fehler: ManaSaver hat keine Informationen zu diesem Zauber.";
	MANASAVE_CHAT_PLAYERNOKNOWSPELL = "<ManaSaver>: Fehler: Dein Charakter kennt diesen Zauber oder Rang nicht.";
	-- Chat posts regarding casting of spells
	MANASAVE_CHAT_POSTDEFAULT = "Heile XPLAYER mit XSPELLNAME (Rang XRANK)";
	-- Chat jokes regarding casting of spells
	MANASAVE_CHAT_POSTJOKE1 = "XPLAYER sieht ziemlich alt aus, da pack ich mal den XSPELLNAME (Rang XRANK) drauf.";
	MANASAVE_CHAT_POSTJOKE2 = "XPLAYER sah schonmal besser aus, heile mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE3 = "Ist doch nur ne Fleischwunde XPLAYER! Aber ich gebe mal XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE4 = "Na sch\195\182n, XPLAYER blutet sich schon wieder das Hemd voll. XSPELLNAME (Rang XRANK) - aber waschen musst du selber.";
	MANASAVE_CHAT_POSTJOKE5 = "XPLAYER ist dem Tode schon recht nah... Heilung mit XSPELLNAME (Rang XRANK) d\195\188rfte ihn bei uns halten.";
	MANASAVE_CHAT_POSTJOKE6 = "Mal wieder keine HP, XPLAYER? XSPELLNAME (Rang XRANK) hilft!";
	MANASAVE_CHAT_POSTJOKE7 = "Wir haben einen Bluter! Gleich mal 500ml XSPELLNAME (Rang XRANK) intraven\195\182s zu XPLAYER!";
	MANASAVE_CHAT_POSTJOKE8 = "Hmm. Heilen oder nicht Heilen - das ist hier die Frage f\195\188r XPLAYER. Heile XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE9 = "EINEN ARZT, SCHNELL! XPLAYER stirbt! Ach, der Arzt bin ja ich! Heile mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE10 = "SCH..., wo ist der d\195\164mliche Heiler, XPLAYER krazt gleich ab! Oh, moment... \195\164hm... heile XPLAYER mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE11 = "XPLAYER pr\195\188gelt sich mal wieder rum. Naja, pack einfach n bisschen Eis drauf... War nur n Scherz XPLAYER Heile mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE12 = "Tja, kauf dir n\195\164chstes mal n paar Heiltr\195\164nke, XPLAYER, du Geizhals! Jaja, war nur n Spass! Heile mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE13 = "Oh XPLAYER, siehst du heute scheisse aus. XSPELLNAME (Rang XRANK) sollte dir etwas helfen.";
	MANASAVE_CHAT_POSTJOKE14 = "NUN BLUTE NICHT AUCH NOCH MEIN HEMD VOLL, XPLAYER. Hier, XSPELLNAME (Rang XRANK) zum Abwischen.";
	MANASAVE_CHAT_POSTJOKE15 = "Schw\195\164ch-ling (Nomen, der) - Spieler, der nur sowenige HP hat wie XPLAYER. Empfohlene L\195\182sung ist XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE16 = "XPLAYER hat soviel Blut verloren, dass sogar ein Vampir ihn links liegen lassen w\195\188rde. Helfen wir mal mit XSPELLNAME (Rang XRANK) aus.";
	MANASAVE_CHAT_POSTJOKE17 = "Sieht aus als ob XPLAYER stirbt. JUHUU! ... oh, hab ich das laut gesagt? ... Heilen wir mal mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE18 = "Sieht aus als ob XPLAYER stirbt. JUHUU! ... oh, hab ich das laut gesagt? ... Heilen wir mal mit XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE19 = "XPLAYER kann ja wirklich GARNICHTS! Ich wette ich mach mehr Schaden als er. Oh, moment. Ich bin ein Heiler, der ohne Unterst\195\188tzung wohl tot ist... Dann doch besser XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE20 = "Also, ein Ork und ein Papagei kommen in die Bar. Sagt der Barkeeper... Oh, ich erz\195\164hle nachher weiter, XPLAYER stirbt wenn ich nicht sofort XSPELLNAME (Rang XRANK) ansetze.";			
	MANASAVE_CHAT_POSTJOKE21 = "Ich hoffe XPLAYER mag die Grateful Dead - er wird bald zur w\195\182rtlichen \195\188bersetzung... Also schnell, XSPELLNAME (Rang XRANK)!";
	MANASAVE_CHAT_POSTJOKE22 = "Hat jemand das Nummerschild vom LKW, der XPLAYER \195\188berfahren hat? Nein? War sowas wie XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE23 = "XPLAYER wird gerade zu Hackfleisch. Gut durch bitte. Und reicht mal die scharfe Sauce, w\195\164hrend ich XSPELLNAME (Rang XRANK) loslasse.";
	MANASAVE_CHAT_POSTJOKE24 = "BEWEG DEINEN ARSCH DA WEG, XPLAYER! Was denkst du wo du da stehst, ich kann doch nicht st\195\164ndig mit XSPELLNAME (Rang XRANK) bereitstehen.";

	-- Options Window
	MANASAVE_OPTIONS_TITLE = "ManaSaver Optionen";
	MANASAVE_OPTIONS_TABOPTIONS = "Optionen";
	MANASAVE_OPTIONS_TABMACRO = "Makro";
	MANASAVE_OPTIONS_CLOSE = "Schlie\195\159en";
	MANASAVE_OPTIONS_CHAT_TITLE = "Zauber- Chat Modus ausw\195\164hlen:";
	MANASAVE_OPTIONS_CHAT_BASICPARTY = "Basis Daten an Party/Raid";
	MANASAVE_OPTIONS_CHAT_BASICSELF = "Basis Daten an sich Selbst";
	MANASAVE_OPTIONS_CHAT_JOKEPARTY = "Jokes an Party/Raid";
	MANASAVE_OPTIONS_CHAT_QUIET = "Keine Daten schreiben";
	MANASAVE_OPTIONS_INCLUDE_TITLE = "Folgende Daten in ManaSaver Berechnung einbeziehen:";
	MANASAVE_OPTIONS_INCLUDE_TALENTS = "Talente";
	MANASAVE_OPTIONS_INCLUDE_ITEMS = "Heil Gegenst\195\164nde";
	MANASAVE_OPTIONS_ADOPTIONS_TITLE = "Zus\195\164tzliche ManaSaver Optionen:";
	MANASAVE_OPTIONS_ADOPTIONS_CUSTOMERROR = "Schreibe eigenen Zauber-Fehlertext";
	MANASAVE_OPTIONS_ADOPTIONS_SHOWMINIMAP = "Zeige Minimap Schalter";
	MANASAVE_OPTIONS_ADOPTIONS_MINIMAPLOC = "Minimap Schalterposition";
	MANASAVE_OPTIONS_MACRO_TITLE = "Folgende Schalter benutzen um Makros zu erstellen:";
	MANASAVE_OPTIONS_MACRO_HEADER = "------------Zauber----------------Rang------\195\188berheilen----";
	MANASAVE_OPTIONS_MACRO_RESET = "zur\195\188cksetzen";
	MANASAVE_OPTIONS_MACRO_CREATED = " Makro erzeugt.";
	MANASAVE_OPTIONS_MACRO_UPDATED = " Makro erneuert.";
	
end


-- French
-- Translations from Zangmaar and Mordâme on the Curse-Gaming forums, thank you
if (GetLocale() == "frFR") then
	-- Variable to store the word Rank
	MANASAVE_RANK = "Rang";
	-- Spells
	MANASAVE_SPELL_HEALTOUCH = "Toucher gu\195\169risseur";
	MANASAVE_SPELL_REGROWTH = "R\195\169tablissement";
	MANASAVE_SPELL_REJUVENATION = "R\195\169cup\195\169ration";
	MANASAVE_SPELL_LESSHEAL = "Soins inf\195\169rieurs";
	MANASAVE_SPELL_HEAL = "Soins";
	MANASAVE_SPELL_GRTHEAL = "Soins sup\195\169rieurs";
	MANASAVE_SPELL_FLASHHEAL = "Soins rapides";
	MANASAVE_SPELL_RENEW = "R\195\169novation";
	MANASAVE_SPELL_HOLYLIGHT = "Feu sacr\195\169e";
	MANASAVE_SPELL_FLASHOFLIGHT = "Eclair lumineux";
	MANASAVE_SPELL_LESSHEALWAVE = "Vague de soins mineurs";
	MANASAVE_SPELL_HEALWAVE = "Vague de soins";
	MANASAVE_SPELL_CHAINHEAL = "Salve de gu\195\169rison";
	-- Talents with increase percentage of healing
	MANASAVE_TALENT_IMPREJUVE = "R\195\169cup\195\169ration am\195\169lior\195\169e";
	MANASAVE_TALENT_GIFTNATURE = "Don de la Nature";
	MANASAVE_TALENT_HEALLIGHT = "Lumi\195\168re gu\195\169risseuse";
	MANASAVE_TALENT_IMPRENEW = "R\195\169novation am\195\169lior\195\169e";
	MANASAVE_TALENT_SPIRITHEAL = "Soins spirituels";
	MANASAVE_TALENT_PURIFICATION = "Purification";
	-- Talents with decreased spell mana costs
	MANASAVE_TALENT_TRANQSPIRIT = "Tranquilit\195\169 de l'esprit";
	MANASAVE_TALENT_IMPHEALING = "Soin am\195\169lior\195\169";
	MANASAVE_TALENT_TIDALFOCUS = "Concentration des Flots";
	-- System responses
	MANASAVE_CHAT_VERSION = "Version NUMVER de ManaSaver charg\195\169e.";
	MANASAVE_CHAT_QUIETON = "<ManaSaver>: Mode silencieux ON";
	MANASAVE_CHAT_QUIETOFF = "<ManaSaver>: Mode silencieux OFF";
	MANASAVE_CHAT_QUIETDEF = "<ManaSaver>: Mode par d\195\169faut ON";
	MANASAVE_CHAT_QUIETSELF = "<ManaSaver>: Mode par d\195\169faut SELF";
	MANASAVE_CHAT_QUIETMENU1 = "/msaverq on (Enclenche le mode silencieux de ManaSaver)";
	MANASAVE_CHAT_QUIETMENU2 = "/msaverq off (Enclenche le mode de messages d'alerte humour ManaSaver)";
	MANASAVE_CHAT_QUIETMENU3 = "/msaverq default (Enclenche les messages d'alerte par d\195\169faut ManaSaver)";
	MANASAVE_CHAT_QUIETMENU4 = "/msaverq self (Enclenche les messages ManaSaver par d\195\169faut dans la fen\195\170tre de discussion du joueur)";
	MANASAVE_CHAT_QUIETPROPER = "La commande appropri\195\169e est:";
	MANASAVE_CHAT_SPELLFAILRANGE = "<ManaSaver>: Echec du sort : La cible est hors de port\195\169e.";
	MANASAVE_CHAT_SPELLFAILSIGHT = "<ManaSaver>: Echec du sort : La cible n'est pas en vue.";
	MANASAVE_CHAT_SPELLFAILMANA = "<ManaSaver>: Echec du sort : Pas assez de Mana.";
	MANASAVE_CHAT_SPELLFAILPOWER = "<ManaSaver>: Echec du sort : Un sort plus puissant est d\195\169j\195\160 actif.";
	MANASAVE_CHAT_SPELLFAILMOVE = "<ManaSaver>: Echec du sort : Vous avez boug\195\169 lors de l'incantation.";
	MANASAVE_CHAT_MSAVERNOSPELL = "<ManaSaver>: Erreur : ManaSaver n'a pas de donn\195\169e sur ce sort.";
	MANASAVE_CHAT_PLAYERNOKNOWSPELL = "<ManaSaver>: Erreur : Votre personnage ne connait pas ce sort ou ce rang de sort.";	
	-- Chat posts regarding casting of spells
	MANASAVE_CHAT_POSTDEFAULT = "Je soigne XPLAYER avec XSPELLNAME (Rang XRANK)";
	-- Chat jokes regarding casting of spells
	MANASAVE_CHAT_POSTJOKE1 = "XPLAYER est tout p\195\162le, je m'en vais le soigner avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE2 = "XPLAYER va tourner de l'oeil, soignons-le avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE3 = "Vite, une torche pour caut\195\169riser les blessures de XPLAYER!  Hum... en fait XSPELLNAME (Rang XRANK) sera certainement mieux.";
	MANASAVE_CHAT_POSTJOKE4 = "XPLAYER est tellement affaibli qu'une application de sangsue le tuerait... essayons plut\195\180t XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE5 = "Je sais que c'est qu'une \195\169gratignure, XPLAYER, mais je te soigne avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE6 = "XPLAYER risque de me tacher \195\160 force de mettre du sang partout, XSPELLNAME devrais r\195\169gler \195\167\195\160 (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE7 = "On a une h\195\169morragie ! J'injecte 100ccs de XSPELLNAME (Rang XRANK) \195\160 XPLAYER !";
	MANASAVE_CHAT_POSTJOKE8 = "La MORT est proche, XPLAYER... n'est-ce pas ? Peut-\195\170tre que un XSPELLNAME (Rang XRANK) aidera \195\160 te garder \195\160 nos c\195\180t\195\169s.";
	MANASAVE_CHAT_POSTJOKE9 = "XPLAYER, un petit coup de fatigue ? XSPELLNAME (Rang XRANK) \195\160 la rescousse !";
	MANASAVE_CHAT_POSTJOKE10 = "Wow... XPLAYER se fait \195\160 nouveau d\195\169molir. Du nerf mauviette ! Je plaisante... je soigne XPLAYER avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE11 = "Mon Dieu, qui est suppos\195\169 soigner ? XPLAYER a vraiment une sale t\195\170te! Oh attendez...d\195\169sol\195\169...je soigne XPLAYER avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE12 = "MEDECIN! XPLAYER va y passer ! Heu attendez, c'est moi... je le soigne avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE13 = "Souviens-toi d'acheter des potions la prochaine fois radin ! Je plaisante ... je soigne XPLAYER avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE14 = "Quelle t\195\170te, XPLAYER, un vrai d\195\169bris. Voici qui devrait t'aider, XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE15 = "(Mauviette) n.m. XPLAYER avec aussi peu de points de vie qu'actuellement. La solution recommand\195\169e est un soin avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE16 = "XPLAYER a perdu tant de sang que m\195\170me un vampire ne s'arr\195\170terait pas. R\195\169glons \195\167\195\160 avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE17 = "On dirait que XPLAYER va mourrir. ENFIN !!!. Oops, je voulais pas le dire tout haut. Soignons le/la avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE18 = "Oull\195\160, XPLAYER \195\167\195\160 ne va pas fort. Je te fais un prix pour XSPELLNAME (Rang XRANK), tu me le paieras plus tard.";
	MANASAVE_CHAT_POSTJOKE19 = "XPLAYER est vraiment un bon \195\160 rien !!! Je suis certain que je me battrais mieux que \195\167\195\160. Heu attendez, je suis un soigneur et je vais mourrir sans aide. Je ferais mieux d'utiliser XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE20 = "Donc, un orc avec un perroquet entre dans le bar. Le barman dit ... Zut, je devrais peut-\195\170tre arr\195\170ter de dire des b\195\170tises sinon XPLAYER va y passer! Je vais faire plus attention et lancer XSPELLNAME (Rang XRANK).";			
	MANASAVE_CHAT_POSTJOKE21 = "hmm...laisser la faucheuse faire son oeuvre ou pas ? Soignons donc XPLAYER avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE22 = "ARRETES DE SAIGNER PARTOUT SUR LE TAPIS, je viens juste de le faire laver. Arr\195\170tons les saignements de XPLAYER avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE23 = "Jolis tatouages que tu as partout XPLAYER ! Ah, ce sont des blessures ouvertes ? Je m'en occupe avec XSPELLNAME (Rang XRANK).";
	MANASAVE_CHAT_POSTJOKE24 = "N'ait pas peur XPLAYER, je m'occupe de toi et il n'y a que la d\195\169capitation que XSPELLNAME (Rang XRANK) ne soigne pas !";
	
	-- Options Window
	MANASAVE_OPTIONS_TITLE = "Options de ManaSaver";
	MANASAVE_OPTIONS_TABOPTIONS = "Options";
	MANASAVE_OPTIONS_TABMACRO = "Macro";
	MANASAVE_OPTIONS_CLOSE = "Fermer";
	MANASAVE_OPTIONS_CHAT_TITLE = "Choix du type de message :";
	MANASAVE_OPTIONS_CHAT_BASICPARTY = "Informations de base pour Groupe/Raid";
	MANASAVE_OPTIONS_CHAT_BASICSELF = "Informations de base pour soi";
	MANASAVE_OPTIONS_CHAT_JOKEPARTY = "Blagues pour Groupe/Raid";
	MANASAVE_OPTIONS_CHAT_QUIET = "Aucune informations diffus\195\169es";
	MANASAVE_OPTIONS_INCLUDE_TITLE = "Inclure les donn\195\169es suivante pour les calculs de ManaSaver:";
	MANASAVE_OPTIONS_INCLUDE_TALENTS = "Talents";
	MANASAVE_OPTIONS_INCLUDE_ITEMS = "Objets +soins";
	MANASAVE_OPTIONS_ADOPTIONS_TITLE = "Options suppl\195\169mentaires :";
	MANASAVE_OPTIONS_ADOPTIONS_CUSTOMERROR = "Afficher un texte d'erreur personnalis\195\169 pour les sorts";
	MANASAVE_OPTIONS_ADOPTIONS_SHOWMINIMAP = "Afficher le bouton de la minicarte";
	MANASAVE_OPTIONS_ADOPTIONS_MINIMAPLOC = "Position du bouton sur la minicarte";
	MANASAVE_OPTIONS_MACRO_TITLE = "Cliquer sur \"Macro\" pour cr\195\169er des macros ManaSaver:";
	MANASAVE_OPTIONS_MACRO_HEADER = "----------Sort------------------Rang----Overheal-----";
	MANASAVE_OPTIONS_MACRO_RESET = "R\195\169initialiser";
	MANASAVE_OPTIONS_MACRO_CREATED = " macro cr\195\169\195\169e.";
	MANASAVE_OPTIONS_MACRO_UPDATED = " macro mise \195\160 jour.";

end	

