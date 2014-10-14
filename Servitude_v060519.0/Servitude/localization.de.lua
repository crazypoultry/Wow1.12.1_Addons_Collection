--German Localization
--Initial German translation by ??
--Additional German translation by Theradros of Zuluhed / EU
--last revision 01/12/2006

if (GetLocale() == "deDE") then	

-- Localization Strings

ServitudeProp = {};
ServitudeProp.Version = 060519.0;
ServitudeProp.Author = "Graguk";
ServitudeProp.AppName = "Servitude";
ServitudeProp.Label = ServitudeProp.AppName .. " (v" .. ServitudeProp.Version .. ")";
ServitudeProp.LongLabel = ServitudeProp.Label .. " von " .. ServitudeProp.Author;
ServitudeProp.CleanLabel = ServitudeProp.AppName .. " von " .. ServitudeProp.Author;
ServitudeProp.Description = "Ein Addon f�r Hexenmeister, das die F\195\164higkeiten ihrer D\195\164monen verwaltet";

ServitudeConfigMenuTitle = ServitudeProp.Label;

VoidwalkerOptions = "Leerwandler Optionen";
ImpOptions = "Wichtel Optionen";
SuccubusOptions = "Sukkubus Optionen";
FelhunterOptions = "Teufelsj\195\164ger Optionen";
GeneralOptions = "Allgemeine Optionen";

InCombatDivider = "=== In/Out Combat Line ===";
SpellLockDivider = "=== Spell Lock ===";
ClassDivider = "=== Class Priority ===";
BuffDatabaseTitle = "Debuff Priority";
SpellDatabaseTitle = "Spell Lock";
ClassDatabaseTitle = "Class Priority";
FireShieldClassDatabaseTitle = "FS Class List";

BINDING_HEADER_SERVITUDE = "Servitude";
BINDING_NAME_DOSERVITUDEOPEN = "Servitude Konfiguration \195\182ffnen";
BINDING_NAME_DOPRIMARY = "1. D\195\164monen-Fertigkeit benutzen";
BINDING_NAME_DOSECONDARY = "2. D\195\164monen-Fertigkeit benutzen";

ConfigObjectText =
{
	VWAutoShadow = "'Schatten verzehren' melden";
	VWAutoShadowRatio = "'Schatten verzehren' %";
	VWAutoTaunt = "Int. 'Qual'";
	VWAutoTauntRatio = "Int. 'Qual' %";
	VWAutoSacrif = "'Opferung' melden";
	VWAutoSacrifCombat = "Nur im Kampf";
	VWAutoTauntBanish = "Kein 'Qual' falls gebannt";
	VWAutoSacrifPetRatio = "'Opferung' % D\195\164mon";
	VWAutoSacrifPlayerRatio = "'Opferung' % Spieler";
	VWSacrificeAlert = "'Opferung' akkustische Warnmeldung";

	ImpSmartFireshield = "Int. FS - Party/Raid";
	ImpSmartFireshieldNeutral = "AUS in Neutr. St\195\164dten";
	ImpSmartFireshieldSolo = "Int. FS - Solo";
	ImpSmartFireshieldAlways = "Int. FS immer";
	ImpSmartFirebolt = "Int. 'Feuerblitz'";
	ImpFireboltDisable = "'Feuerblitz' nach Kampf deaktivieren";
	ImpSmartFireboltRatio = "Min Mana Feuerblitz";
	ImpFireShieldAlert = "'Feuerschild' Warnung";
	
	ScbSmartSooth = "Int. 'Bes\195\164nft. Kuss'";
	ScbSmartSoothRatio = "'Bes\195\164nft. Kuss' %";
	ScbAutoInvisib = "'Unsichtbarkeit' melden";
	ScbAutoInvisibManaRatio = "Min Mana";
	ScbInvisDelay = "'Unsichtb.' Verz. nach Kampf";
--	ScbSeduceFollow = "Folgen bei Abbruch von 'Verf\195\188hrung'";
	ScbSeduceCOS = "'Schattenfluch' bei 'Verf.'";
	ScbSeduceCOE = "'Fl. der Elem.' bei 'Verf.'";
	ScbSmartLOP = "Int. 'Schmerzenspeitsche'";
	ScbSmartLOPRatio = "Min Mana";
--	ScbAlwaysSeduce = "Wieder-'Verf\195\188hrung' bei Abbruch";
	ScbSeduceAlert = "'Verf\195\188hrung' Meldung";
	ScbSeduceAnnounce = "Gruppe 'Verf\195\188hrung' melden";
	ScbSeduceAnnounceRaid = "Raid 'Verf\195\188hrung' melden";

	FHNonCombatDevour = "'Magie verschlingen' au\195\159erh. des Kampfs melden";
	FHHungerDevour = "Hungriger Teufelsj\195\164ger";
	FHHungerDevourRatio = "Hunger %";
	FHPartyDevour = "Party";
	FHDevourSelf = "TJ zuerst";
	FHDevourPets = "Raid/Party Begl.";
	FHDevourIgnoreSelf = "TJ ignorieren";
	FHRaidDevour = "Raid";
	FHDevourMindVision = "'Gedankensicht' verschlingen";
	FHSpellLockPVP = "'Zaubersperre' PVP";
	FHSpellLockPVE = "'Zaubersperre' PVE";
	FHDisableNotification = "Zauber/Debuff Meldung deaktivieren";
	FHClassAsPriority = "Klassen-Prior.";
	FHPriorityUnitOnly = "Nur Prior.-Einheit";
	FHDevourAlert = "'M. verschl.' Meldung";
	FHSpellLockAlert = "'Zaubersperre' Meldung";
	
	OneButton = "1-Tasten Modus";
	HealthWarning = "D\195\164mon-HP-Warnung";
	HealthWarningRatio = "D\195\164mon Gesundheit %";
	HealthWarningVocal = "Akkustische Gesundheits-Warnmeldung";
}

ConfigObjectTooltip =
{
	VWAutoShadow = "Spieler nach Kampf auf 'Schatten verzehren' hinweisen, falls Leerwandler-Gesundheit angegebenen Prozentwert unterschreitet.";
	VWAutoSacrif = "Spieler auf 'Opferung' d. Leerwandlers im Kampf hinweisen, falls Leerwandler- oder Spieler-Gesundheit angegebenen Prozentwert unterschreitet. (Anm.: Keine Meldung bei massivem Schaden in k\195\188rzester Zeit)";
	VWAutoSacrifCombat = "'Opferung' Meldung erscheint nur im Kampf.";
	VWAutoTauntBanish = "Auto-'Qual' deaktivieren, falls Ziel des Leerwandlers gebannt.";
	VWAutoTaunt = "Leerwandler stoppt 'Qual' im Kampf, sobald die Gesundheit seines Ziels den angegebenen Prozentwert unterschreitet.";
	VWSacrificeAlert = "Akkustische Warnmeldung, sobald die Spieler- oder Leerwandler-Gesundheit den angegebenen Prozentwert unterschreitet.";
	
	ImpSmartFireshield = "Wichtel zaubert 'Feuerschild' auf Tanks, falls in Party/Raid.";
	ImpSmartFireshieldNeutral = "Wichtel zaubert 'Feuerschild' nicht in Neutralen St\195\164dten. Er wird au\195\159erdem ein auf dem Spieler bestehendes 'Feuerschild' abbrechen.";
	ImpSmartFireshieldSolo = "Wichtel zaubert 'Feuerschild' auf den Hexenmeister, falls nicht in Party/Raid.";
	ImpSmartFireshieldAlways = "Wichtel zaubert 'Feuerschild' auf alle Party-Mitglieder sofern in Reichweite, gleich welche Klasse.";
	ImpSmartFirebolt = "Wichtel aktiviert Auto-Zaubern f\195\188r 'Feuerblitz', solange sein Mana oberhalb des angegebenen Wertes liegt.";
	ImpFireboltDisable = "Wichtel deaktiviert Auto-Zaubern f\195\188r 'Feuerblitz' nach dem Kampf. 'Intelligenter Feuerblitz' \195\188bergeht diese Option.";
	ImpFireShieldAlert = "Erkennt der Wichtel eine Einheit, die 'Feuerschild' nach den Einstellungen ben\195\182tigt, erklingt eine akkustische Warnmeldung.";
	
	ScbSmartSooth = "Sukkubus benutzt nicht 'Bes\195\164nftigender Kuss', falls ihre Gesundheit oberhalb des angegebenen Prozentwerts liegt.";
	ScbAutoInvisib = "Den Spieler warnen, falls Sukkubus nach dem Kampf 'Geringe Unsichtbarkeit' zaubern kann, soweit sie keinen Debuff hat. Minimum Sukkubus Mana Regler f\195\188r Dunkler Pakt-Anwender.";
	ScbInvisDelay = "Falls angehakt, wartet Sukkubus 10 sec. nach Ende eines Kampfs, bevor sie den Spieler warnt, dass 'Unsichtbarkeit' verf\195\188gbar ist - Zeit f\195\188r Dunkler Pakt.";
--	ScbSeduceFollow = "Sukkubus folgt dem Spieler, nachdem das Ziel von 'Verf\195\188hrung' Schaden erlitten hat, anstatt es anzugreifen.";
	ScbSmartLOP = "Sukkubus aktiviert Auto-Zaubern von 'Schmerzenspeitsche', sofern ihr Mana oberhalb des angegebenen Prozentwerts liegt.";
--	ScbAlwaysSeduce = "Sukkubus wiederholt 'Verf\195\188hrung', auch falls das Ziel Schaden erlitten hat. Diese Option \195\188bergeht die 'Folgen bei Abbruch von Verf\195\188hrung'-Option.";
	ScbSeduceAlert = "Akkustische Warnmeldung, sobald Sukkubus Abbruch von 'Verf\195\188hrung' beim Ziel feststellt.";
	ScbSeduceCOS = "Falls angehakt, zaubert der Spieler bei erstmaliger Benutzung von 'Verf\195\188hrung' durch die Sukkubus automatisch 'Schattenfluch' auf dasselbe Ziel.";
	ScbSeduceCOE = "Falls angehakt, zaubert der Spieler bei erstmaliger Benutzung von 'Verf\195\188hrung' durch die Sukkubus automatisch 'Fluch der Elemente' auf dasselbe Ziel. 'Schattenfluch bei Verf\195\188hrung' hat bei Aktivierung Vorrang.";
	ScbSeduceAnnounce = "Falls angehakt, meldet der Spieler das Ziel der erstmaligen 'Verf\195\188hrung' im Party Chat.";
	ScbSeduceAnnounceRaid = "Falls angehakt, meldet der Spieler das Ziel der erstmaligen 'Verf\195\188hrung' im Raid Chat.";

	FHNonCombatDevour = "Teufelsj\195\164ger sucht und verschlingt Debuffs von sich selbst oder dem Spieler nach dem Kampf.";
	FHHungerDevour = "Teufelsj\195\164ger sucht und verschlingt Debuffs von sich selbst oder dem Spieler w\195\164hrend des Kampfes, sobald seine Gesundheit den angegebenen Prozentwert unterschreitet.";
	FHPartyDevour = "Party Unterst\195\188tzung f\195\188r 'Magie verschlingen'";
	FHDevourSelf = "'Magie verschlingen' zuerst auf Teufelsj\195\164ger selbst.";
	FHDevourIgnoreSelf = "Niemals 'Magie verschlingen' auf Teufelsj\195\164ger selbst. Diese Option \195\188bergeht die Option 'Teufelsj\195\164ger zuerst'.";
	FHRaidDevour = "Raid Unterst\195\188tzung f\195\188r 'Magie verschlingen'";
	FHDevourPets = "Falls angehakt, scannt diese Einstellung Raid und Party Begleiter, sofern die korrespondierende Option 'Party/Raid Unterst\195\188tzung' aktiviert ist.";
	FHDevourMindVision = "'Gedankensicht' wird als Debuff angezeigt. W\195\164hle diese Option, falls es wie andere Debuffs auch von 'Magie verschlingen' erfasst werden soll.";
	FHSpellLockPVP = "'Zaubersperre' auf PVP Ziele, falls Du PVP geflagged bist.";
	FHSpellLockPVE = "'Zaubersperre' auf PVE Ziele. Kann mitunter durcheinander kommen, falls eine Einheit zaubert, die denselben Namen wie Dein Ziel tr\195\164gt.";
	FHDisableNotification = "Dies deaktiviert die Meldung beim Lernen eines neuen Zaubers oder Debuffs.";
	FHClassAsPriority = "Falls angehakt, wird die Klassen-Priorit\195\164ts-Liste benutzt, um 'Magie verschlingen' auf Klassen entsprechend ihrer Wichtigkeit anzuwenden, anstatt nur zu entscheiden, ob eine Klasse ignoriert wird oder nicht. (ben\195\182tigt mehr CPU Leistung)";
	FHPriorityUnitOnly = "Auto-'Magie verschlingen' scannt nur Debuffs der gew\195\164hlten Priorit\195\164ts-Einheit. Diese Einstellung ignoriert alle anderen Raid und Party Mitglieder, inklusive Spieler und Teufelsj\195\164ger.";
	FHDevourAlert = "Akkustische Warnung, wenn der Teufelsj\195\164ger eine Einheit entdeckt, die entsprechend der \195\188brigen Einstellungen 'Magie verschlingen' ben\195\182tigt.";
	FHSpellLockAlert = "Akkustische Warnung, wenn der Teufelsj\195\164ger bemerkt, dass Dein Ziel einen Zauber zu wirken beginnt, welcher nach den Einstellungen mit 'Zaubersperre' zu unterbrechen ist.";
	OneButton = "Falls angehakt, kann die Begleiter-Verwaltung nur mit der prim\195\164ren D\195\164monen-Fertigkeits-Taste gesteuert werden. Die sekund\195\164re D\195\164monen-Fertigkeits-Taste aktiviert 'Verf\195\188hrung' und 'Magie verschlingen' auf Dein Ziel.";
	HealthWarning = "Falls angehakt, warnt Servitude Dich, falls die Gesundheit Deines D\195\164mons den angegebenen Prozentwert unterschreitet.";
	HealthWarningVocal = "Falls die Gesundheit Deines D\195\164mons den angegebenen Prozentwert unterschreitet, ert\195\182nt eine akkustische Warnmeldung.";
}

ServitudeChatMsg = 
{
	SoothingKissToggleError = "'Bes\195\164nftigender Kuss' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird im Kampf \195\188bergangen.";
	LOPToggleError = "'Schmerzenspeitsche' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird im Kampf \195\188bergangen.";
	AutoTauntToggleError = "'Qual' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird im Kampf \195\188bergangen.";
	ImpSmartFireshieldToggleError = "'Feuerschild' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird \195\188bergangen beim n\195\164chsten Spieler-Scan.";
	ImpSmartFireboltToggleError = "'Feuerblitz' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird im Kampf \195\188bergangen.";
	FHSpellLockToggleError = "'Zaubersperre' wird im Augenblick von Servitude verwaltet. Die Auto-Zauber Einstellung des Spiels wird im Kampf \195\188bergangen.";
	LoadDefault = "Standard Einstellungen geladen.";
	ObjectLoadFail = "Fehler! Objekt laden fehlgeschlagen:";
	ObjectSaveFail = "Fehler! Objekt speichern fehlgeschlagen:";
	WelcomeMsg = ServitudeProp.CleanLabel .. " f\195\188r Hexenmeister (Slash Befehle: /servitude help oder /serv help)";
	NewDebuffObserved = "Neuer magischer Debuff wurde beobachtet:";
	NewSpellObserved = "Neuer Zauber wurde beobachtet:";
	DebuffDatabaseCorrupted = "Debuff Datenbank ist korrupt oder leer und wurde gel\195\182scht. Standard Datenbank geladen.";
	SpellDatabaseCorrupted = "'Zaubersperre' Datenbank ist korrupt oder leer und wurde gel\195\182scht.";
	ClassDatabaseCorrupted = "Klassen Datenbank ist korrupt oder leer. Standard Datenbank geladen.";
	FireShieldClassDatabaseCorrupted = "'Feuerschild' Datenbank ist korrupt oder leer. Standard Datenbank geladen.";
	DebuffDatabaseVerified = "Anzahl der Eintr\195\164ge in der Debuff Datenbank:";
	SpellDatabaseVerified = "Anzahl der Eintr\195\164ge in der 'Zaubersperre' Datenbank:";
	SeductionMessage = " is being Seduced! Avoid the Hearts <3 <3";
}

ServitudeNotificationMsg =
{
	InvisNotification = "Geringe Unsichtbarkeit";
	SpellLockPVP = "Zaubersperre!";
	SpellLockPVE = "Zaubersperre!";
	SeductionNotification = "Nochmals Verf\195\188hrung, JETZT!";
	Sacrifice = "Opfern, JETZT!";
	ConsumeShadows = "Schatten verzehren";
	DebuffsDetected = "Magie verschlingen, JETZT!";
	FireShieldRequired = "Feuerschild!";
	ServitudeAlertTest = "Dies ist ein Test. Bewege diesen Frame an die gew\195\188nschte Position.";
	HealthLow = "Dein D\195\164mon STIRBT!";
	Primary = " (Prim\195\164re Taste)";
	Secondary = " (Sekund\195\164re Taste)";
}

	ServitudeLocalization = 
	{
		Class = "Hexenmeister";
		Class2 = "Krieger";
		Class3 = "Schamane";
		Class4 = "Paladin";
		Pet1 = "Wichtel";
		Pet2 = "Leerwandler";
		Pet3 = "Sukkubus";
		Pet4 = "Teufelsjäger";
		Pet5 = "Verdammniswache";
		Magic1 = "Geringe Unsichtbarkeit";
		Magic2 = "Besänftigender Kuss";
		Magic3 = "Schatten verzehren";
		Magic4 = "Opferung";
		Magic5 = "Magie verschlingen";
		Magic6 = "Qual";
		Magic7 = "Feuerschild";
		Magic8 = "Verführung";
		Magic9 = "Zaubersperre";
		Magic10 = "Magiebannung";
		Magic11 = "Schmerzenspeitsche";
		Magic12 = "Verbannen";
		Magic13 = "Feuerblitz";
		Magic14 = "Leiden";
		Magic15 = "Schattenfluch";
		Magic16 = "Fluch der Elemente";
		Buff1 = "SacrificialShield";
		Buff2 = "Nature_Swiftness";
		Buff3 = "Spell_Magic_LesserInvisibilty";
		Buff4 = "Gedankensicht";
		Buff5 = "Traumloser Schlaf";
		Buff6 = "Feuerschild";
		Buff7 = "Dornen";
		Buff8 = "Seelenverbindung";
		Buff9 = "Blutpakt";
		Buff10 = "Aura der Vegeltung";
		Buff11 = "Paranoia";
		Buff12 = "Gedankenkontrolle";
		Bufftype = "Magie"; 
		NoDesc = "No Text Found";
		CastString = "(.+) beginnt (.+) zu wirken";
		SedString = "(.+) beginnt Verführung zu wirken";
		FadeString = "Verführung schwindet von (.+)%.";
		DarkPactString = "You drain %d+ mana from";
	}
end

DE_Magical_Debuff_List = {
	["Feuerbrand"] = "Alle 3 Sekunden 73 Punkte Feuerschaden.",
	["Nachwirkung"] = "Bewegung um 50% verlangsamt.",
	["Blackout"] = "Ohnmächtig.",
	["Verwandlung"] = "Kann weder angreifen noch Zauber wirken. Erhöhte Regeneration.",
	["Schreckliches Kreischen"] = "Flüchtet voller Furcht.",
	["Kälte"] = "Bewegung verlangsamt auf 70% und Angriffstempo verlangsamt um 20%.",
	["Frostschock"] = "Bewegung auf 50% des normalen Tempos verlangsamt.",
	["Heiliges Feuer"] = "Alle 2 Sek. Feuerschaden zugefügt.",
	["Jäger-Mal"] = "Alle Angreifer erhalten 20 Distanzangriffskraft gegenüber diesem Ziel.",
	["Frostfalle-Effekt"] = "Bewegung auf 40% des normalen Tempos verlangsamt.",
	["Verderbnis"] = "Alle 3 Sekunden 74 Punkte Schaden.",
	["Blitzeis"] = "Betäubt.",
	["Frostnova"] = "Festgefroren.",
	["Schallexplosion"] = "Zauber wirken nicht möglich.",
	["Mana entziehen"] = "Entzieht jede Sekunde 140 Punkte Mana für den Zaubernden.",
	["Mondfeuer"] = "Alle 3 Sekunden 53 Punkt(e) Arkanschaden.",
	["Verlangsamen"] = "Angriffstempo um 35% verringert. Bewegungstempo auf 40% des normalen Tempos verlangsamt.",
	["Winterschlaf"] = "Schlafend.",
	["Donnerknall"] = "Angriffstempo um 25% verringert. Bewegungstempo auf 45% des normalen Tempos verlangsamt.",
	["Gebrechlichkeit"] = "Alle Attribute um 30 verringert.",
	["Wahnsinn verursachen"] = "Bezaubert. Angriffstempo um 50% erhöht. Bewegungstempo um 80% erhöht.",
	["Erschrecken"] = "Flüchtet voller Furcht.",
	["Richturteil der Weisheit"] = "Angriffe und Zauber gegen Euch haben eine Chance beim Angreifer 59 Mana wiederherzustellen.",
	["Flammenschock"] = "Fügt alle 3 Sekunden Feuerschaden zu.",
	["Erdbindung"] = "Bewegung auf 50% des normalen Tempos verringert.",
	["Erschütternder Schuss"] = "Bewegung auf 50% des normalen Tempos verlangsamt.",
	["Kältekegel"] = "Bewegung auf 50% verlangsamt.",
	["Verbannen"] = "Unverwundbar, aber kann nicht agieren.",
	["Besudeltes Blut’ - Effekt"] = "Angriffskraft verringert um 200,",
	["Tritt - zum Schweigen gebracht"] = "Zum Schweigen gebracht.",
	["Frostschuss"] = "Bewegungstempo auf 40% des normalen Tempos verlangsamt.",
	["Entkräftende Berührung"] = "Stärke um 20 verringert. Ausdauer um 20 verringert.",
	["Tod durch Ertrinken"] = "Schwimmtempo um 20% verringert. Beweglichkeit um 15% verringert.",
	["Gegenzauber - zum Schweigen gebracht"] = "Zum Schweigen gebracht.",
	["Schattenverwundbarkeit"] = "Schattenschaden um 20% erhöht.",
	["Spitelash"] = "Erlittener körperlicher Schaden um 43 bis 57 Punkt(e) erhöht.",
	["Eiskältefalle-Effekt"] = "Eingefroren.",
	["Welkstoß"] = "Angriffstempo um 33% verringert.",
	["Richturteil des Kreuzfahrers"] = "Erhöht erlittenen Heiligschaden um bis zu 140,",
	["Blutsauger"] = "Entzieht pro Sekunde 71 Punkte Gesundheit und überträgt sie auf den Zaubernden.",
	["Hammer der Gerechtigkeit"] = "Betäubt.",
	["Schattenwort: Schmerz"] = "142 Punkte Schattenschaden alle 3 Sekunden.",
	["Traumloser Schlaf"] = "Traumloser Schlaf.",
	["Richturteil des Lichts"] = "Nahkampfangriffe gegen Euch haben eine Chance, dass der Angreifer um 49 geheilt wird.",
	["Schreckgeheul"] = "Flüchtet vor Schreck.",
	["Feenfeuer"] = "Verringert Rüstung um 285, Kann weder Verstohlenheit anwenden noch unsichtbar werden.",
	["Flammenpuffer"] = "Erlittener Feuerschaden um 246 Punkt(e) erhöht.",
	["Wucherwurzeln"] = "Eingewurzelt. Verursacht alle 3 Sekunden 30 Punkte Schaden.",
	["Sprengfalle’-Effekt"] = "Alle 2 Sekunden 33 Punkt(e) Feuerschaden.",
	["Lebensentzug"] = "Zieht alle 3 Sek. 45 Punkt(e) Gesundheit auf den Zaubernden ab.",
	["Erfrierung"] = "Eingefroren.",
	["Furcht"] = "Furchterfüllt.",
	["Untote fesseln"] = "Gefesselt.",
	["Verhexung"] = "Verhext.",
	["Besudeltes Blut' - Effekt"] = "Angriffskraft verringert um 40.",
	["Frostblitz"] = "Bewegung auf 50% verlangsamt.",
	["Verführung"] = "Verführt.",
	["Dämon zerschmettern"] = "Betäubt.",
	["Stille"] = "Zum Schweigen gebracht.",
	["Verkrüppeln"] = "Bewegungstempo auf 50% des normalen Tempos verlangsamt. Angriffstempo um 50% verringert. Stärke um 50% verringert.",
}

DE_Devour_Order = {
	[1] = "Stille",
	[2] = "Verwandlung",
	[3] = "Schattenwort: Schmerz",
	[4] = "Hammer der Gerechtigkeit",
	[5] = "Mondfeuer",
	[6] = "Feuerbrand",
	[7] = "Verderbnis",
	[8] = "Frostschock",
	[9] = "Erdbindung",
	[10] = "Furcht",
	[11] = "Schattenverwundbarkeit",
	[12] = "Erschütternder Schuss",
	[13] = "Frostblitz",
	[14] = "Verbannen",
	[15] = "Jäger-Mal",
	[16] = "Verführung",
	[17] = "Wucherwurzeln",
	[18] = "Frostnova",
	[19] = "Blackout",
	[20] = "Besudeltes Blut' - Effekt",
	[21] = "Richturteil des Lichts",
	[22] = "Lebensentzug",
	[23] = "Blutsauger",
	[24] = "Mana entziehen",
	[25] = "Feenfeuer",
	[26] = "Flammenschock",
	[27] = "Heiliges Feuer",
	[28] = "Schreckgeheul",
	[29] = "Traumloser Schlaf",
	[30] = "Erfrierung",
	[31] = "Gegenzauber - zum Schweigen gebracht",
	[32] = "Erschrecken",
	[33] = "Spitelash",
	[34] = "Frostschuss",
	[35] = "Kältekegel",
	[36] = "Tritt - zum Schweigen gebracht",
	[37] = "Donnerknall",
	[38] = "Kälte",
	[39] = "Eiskältefalle-Effekt",
	[40] = "Gebrechlichkeit",
	[41] = "Schallexplosion",
	[42] = "Frostfalle-Effekt",
	[43] = "Nachwirkung",
	[44] = "Flammenpuffer",
	[45] = "Untote fesseln",
	[46] = "Wahnsinn verursachen",
	[47] = "Verkrüppeln",
	[48] = "Richturteil des Kreuzfahrers",
	[49] = "Dämon zerschmettern",
	[50] = "Schreckliches Kreischen",
	[51] = "Welkstoß",
	[52] = "Besudeltes Blut’ - Effekt",
	[53] = "Sprengfalle’-Effekt",
	[54] = "Blitzeis",
	[55] = "Verlangsamen",
	[56] = "Entkräftende Berührung",
	[57] = "Verhexung",
	[58] = "Richturteil der Weisheit",
	[59] = "Winterschlaf",
	[60] = "Tod durch Ertrinken",
	[61] = "=== In/Out Combat Line ===",
}

DE_Spell_Lock_List = {
	["Vipernbiss"] = "Observed",
	["Verwandlung"] = "Observed",
	["Schlangenbiss"] = "Observed",
	["Blutfluch"] = "Observed",
	["Manabrand"] = "Observed",
	["Giftwolke"] = "Observed",
	["Erneuerung"] = "Observed",
	["Atal’ai-Skelett beschwören"] = "Observed",
	["Tiefer Schlummer"] = "Observed",
	["Flammenschauer"] = "Observed",
	["Gedankenschlag"] = "Observed",
	["Arkaner Schuss"] = "Observed",
	["Geringe Welle der Heilung"] = "Observed",
	["Nachwachsen"] = "Observed",
	["Schattenblitz-Salve"] = "Observed",
	["Kettenblitzschlag"] = "Observed",
	["Annalen von Darrowshire’ verzaubern"] = "Observed",
	["Furcht"] = "Observed",
	["Dunkle Besserung"] = "Observed",
	["Heilende Berührung"] = "Observed",
	["Heilen"] = "Observed",
	["Feuerblitz"] = "Observed",
	["Flammenpuffer"] = "Observed",
	["Wucherwurzeln"] = "Observed",
	["Angreifen"] = "Observed",
	["Flammenstachel"] = "Observed",
	["Schlachtross beschwören"] = "Observed",
	["Gruftskarabäen"] = "Observed",
	["Heilungs-Zauberschutz"] = "Observed",
	["Sengender Schmerz"] = "Observed",
	["Pyroschlag"] = "Observed",
	["Geisterwolf"] = "Observed",
	["Säurespucke"] = "Observed",
	["Zorn"] = "Observed",
	["Verkrüppeln"] = "Observed",
	["Erschütternder Schuss"] = "Observed",
	["Schattenblitz"] = "Observed",
	["Schneller Flammen-Zauberschutz"] = "Observed",
	["Feuerschild II"] = "Observed",
	["Echsenschlag"] = "Observed",
	["Augen des Wildtiers"] = "Observed",
	["Blitzschlag"] = "Observed",
	["Flammenatem"] = "Observed",
	["Feuerbrand"] = "Observed",
	["Streuschuss"] = "Observed",
	["Atal'ai-Skelett beschwören"] = "Observed",
	["Erdengriff-Totem"] = "Observed",
	["Skorpidstich"] = "Observed",
	["Feuerball"] = "Observed",
	["Banshee-Fluch"] = "Observed",
	["Schattenschuss"] = "Observed",
	["Mana-Citrin herbeizaubern"] = "Observed",
	["Arkanblitz"] = "Observed",
	["Schlaf"] = "Observed",
	["Arkane Explosion"] = "Observed",
	["Frostblitz-Salve"] = "Observed",
	["Große Heilung"] = "Observed",
	["Flammenstoß"] = "Observed",
	["Gezielter Schuss"] = "Observed",
	["Untote fesseln"] = "Observed",
	["Schreckgeheul"] = "Observed",
	["Ruhestein"] = "Observed",
	["Frostblitz"] = "Observed",
	["Welle der Heilung"] = "Observed",
	["Versengen"] = "Observed",
	["Toxin-Speichel"] = "Observed",
	["Blitzheilung"] = "Observed",
}

DE_Spell_Lock_Order = {
	[1] = "Wucherwurzeln",
	[2] = "Zorn",
	[3] = "Gedankenschlag",
	[4] = "Schattenblitz-Salve",
	[5] = "Manabrand",
	[6] = "Schattenblitz",
	[7] = "Arkaner Schuss",
	[8] = "Schlangenbiss",
	[9] = "Dunkle Besserung",
	[10] = "Frostblitz",
	[11] = "Feuerball",
	[12] = "Toxin-Speichel",
	[13] = "Mana-Citrin herbeizaubern",
	[14] = "=== Spell Lock ===",
	[15] = "Angreifen",
	[16] = "Kettenblitzschlag",
	[17] = "Blitzschlag",
	[18] = "Arkane Explosion",
	[19] = "Heilende Berührung",
	[20] = "Blitzheilung",
	[21] = "Geringe Welle der Heilung",
	[22] = "Pyroschlag",
	[23] = "Welle der Heilung",
	[24] = "Flammenstoß",
	[25] = "Geisterwolf",
	[26] = "Feuerbrand",
	[27] = "Erschütternder Schuss",
	[28] = "Vipernbiss",
	[29] = "Skorpidstich",
	[30] = "Blutfluch",
	[31] = "Säurespucke",
	[32] = "Streuschuss",
	[33] = "Flammenpuffer",
	[34] = "Flammenschauer",
	[35] = "Flammenatem",
	[36] = "Untote fesseln",
	[37] = "Schlaf",
	[38] = "Verwandlung",
	[39] = "Atal'ai-Skelett beschwören",
	[40] = "Feuerblitz",
	[41] = "Giftwolke",
	[42] = "Furcht",
	[43] = "Heilen",
	[44] = "Tiefer Schlummer",
	[45] = "Gezielter Schuss",
	[46] = "Versengen",
	[47] = "Schlachtross beschwören",
	[48] = "Sengender Schmerz",
	[49] = "Echsenschlag",
	[50] = "Große Heilung",
	[51] = "Augen des Wildtiers",
	[52] = "Ruhestein",
	[53] = "Atal’ai-Skelett beschwören",
	[54] = "Heilungs-Zauberschutz",
	[55] = "Erneuerung",
	[56] = "Erdengriff-Totem",
	[57] = "Frostblitz-Salve",
	[58] = "Banshee-Fluch",
	[59] = "Arkanblitz",
	[60] = "Nachwachsen",
	[61] = "Schattenschuss",
	[62] = "Gruftskarabäen",
	[63] = "Verkrüppeln",
	[64] = "Schreckgeheul",
	[65] = "Annalen von Darrowshire’ verzaubern",
	[66] = "Flammenstachel",
	[67] = "Feuerschild II",
	[68] = "Schneller Flammen-Zauberschutz",
}

DE_Class_Order = {
				[1] = "Druide",
				[2] = "Jäger",
				[3] = "Magier",
				[4] = "Paladin",
				[5] = "Priester",
				[6] = "Schurke",
				[7] = "Schamane",
				[8] = "Krieger",
				[9] = "Hexenmeister",
				[10] = "=== Class Priority ===",
}

