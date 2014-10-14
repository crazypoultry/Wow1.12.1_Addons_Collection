-- Default, English localization:
BINDING_NAME_LOOTHOGTOGGLE = "Show/Hide Window"
BINDING_HEADER_LOOTHOG = "LootHog"

--LOOTHOG_ROLL_PATTERN = "(%a+) rolls (%d+) %((%d+)%-(%d+)%)"
LOOTHOG_ROLL_PATTERN = "(.+) rolls (%d+) %((%d+)%-(%d+)%)" --hopefully fixes the Â character problems
LOOTHOG_PASS_PATTERN = "pass"
LOOTHOG_RESETONWATCH_PATTERN = " won with a roll of"
LOOTHOG_RESETONWATCH_PATTERN2 = "tied with"

-- size of the main and options/config window
LOOTHOG_UI_MAIN_WIDTH = "190"
LOOTHOG_UI_CONFIG_WIDTH = "320"
LOOTHOG_UI_CONFIG_HEIGHT = "330"

LOOTHOG_LABEL_ROLLS = "/random Rolls"
LOOTHOG_LABEL_READY = "Ready..."  -- Means that LootHog is ready to receive /random rolls.
LOOTHOG_LABEL_OPTIONS = "LootHog Options"
LOOTHOG_LABEL_HOLDING = "Holding..."  -- Means that the user has clicked "Hold" to prevent the timeout.
LOOTHOG_LABEL_NOTIMEOUT = "Timeout disabled."
LOOTHOG_LABEL_TIMELEFT = "Timeout: %s seconds"  -- (seconds)
LOOTHOG_LABEL_COUNT = "Rolls:%s, Players:%s"  -- (roll count, player count)
LOOTHOG_LABEL_NEW_ROLL_TEXT = "New roll starting now !"
LOOTHOG_LABEL_DELIMITER = "------------------"
LOOTHOG_LABEL_WINNERSDELIMITER = "=================="
LOOTHOG_LABEL_CHATLISTTOP = "Rolls in Ascending Order"

LOOTHOG_BUTTON_CLEAR = "Clear"
LOOTHOG_BUTTON_OPTIONS = "Options"
LOOTHOG_BUTTON_HOLD = "Hold"
LOOTHOG_BUTTON_UNHOLD = "UnHold"
LOOTHOG_BUTTON_ANNOUNCE = "Announce"
LOOTHOG_BUTTON_YETTOROLL = "Not rolled"
--LOOTHOG_BUTTON_INFO = "Info"
LOOTHOG_BUTTON_INFO = "Kick Roll"
LOOTHOG_BUTTON_ROLL = "Roll (1-100)"
LOOTHOG_BUTTON_PASS = "Pass"
LOOTHOG_BUTTON_COUNTDOWN = "Countdown"
LOOTHOG_OPTION_ENABLE = "Enable LootHog"
LOOTHOG_OPTION_FINALIZE = "Finalize rolling after timeout expires"
LOOTHOG_OPTION_GROUPONLY = "Count rolls from group members only"
LOOTHOG_OPTION_AUTOSHOW = "Automatically show window when someone rolls"
LOOTHOG_OPTION_PREVENT = "Prevent /random rolls from appearing in the chatlog"
LOOTHOG_OPTION_CLOSEONANNOUNCE = "Close LootHog window after announcing a winner"
LOOTHOG_OPTION_ACK = "Acknowledge rolls via /whisper to roller"
LOOTHOG_OPTION_REJECT = "Reject rolls with bounds other than (1-100)"
LOOTHOG_OPTION_ANNOUNCEREJECT = "Announce rejected rolls"
LOOTHOG_OPTION_TIMEOUT1 = "Auto-hide window after "
LOOTHOG_OPTION_TIMEOUT2 = " seconds"
LOOTHOG_OPTION_ANNOUNCEONCLEAR = "Announce on Clear: "
LOOTHOG_OPTION_RESETONWATCH = "Deactivate LootHog if someone else announces"
LOOTHOG_OPTION_LISTTOCHAT = "Submit complete list of rolls to chat when announcing"

--LOOTHOG_MSG_FFA = "No rolls on the last item, this one is free for all!"
LOOTHOG_MSG_LOAD = "LootHog v%s loaded.  For options, type /loothog."  -- (version)
LOOTHOG_MSG_INFO = "LootHog-Information: You may pass on a running roll by typing: %s"  -- (pass pattern)
LOOTHOG_MSG_CHEAT = "Ignoring %s's roll of %s (%s-%s)."  -- (player, roll, max_roll, min_roll)
LOOTHOG_MSG_ACK = "Got your roll (%s).  Good luck!"  -- (roll)
LOOTHOG_MSG_ACK_PASS = "You have passed on this roll."  -- (pass)
LOOTHOG_MSG_DUPE = "%s has rolled more than once!"  -- (player)
--LOOTHOG_MSG_WINNER = "%s won with a roll of %s!"  -- (player, roll)
LOOTHOG_MSG_WINNER = "%s%s won with a roll of %s!  (%s-%s)  %s"  -- (player, group, roll, min, max, raidpointmsg)
LOOTHOG_MSG_ROLLS = "%s: %s rolled %s."  -- (roll posistion, player, roll)
-- The following variables are used to build a string of this type, in the case of a tie:
-- "Gnomechomsky, Saucytails, and Pionerka tied with 98's!"
-- I don't know if a literal substitution can provide a proper translation.  Feedback is welcome.  :)
LOOTHOG_MSG_AND = " and "
LOOTHOG_MSG_TIED = " tied with %s's!  Please re-roll using the same points, if any."  -- (roll)
LOOTHOG_MSG_YETTOPASS = "The following people still need to roll or say %s" --(LOOTHOG_PASS_PATTERN)
LOOTHOG_MSG_REMOVEROLL = "<LootHog>: %s's roll of %s removed from consideration."

-- German Localization:
-- Done by Suan(Kaz'goroth)
if (GetLocale()=="deDE") then
	--LOOTHOG_ROLL_PATTERN = "(%a+) w\195\188rfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)"
	LOOTHOG_ROLL_PATTERN = "(.+) w\195\188rfelt. Ergebnis: (%d+) %((%d+)%-(%d+)%)" --hopefully fixes the Â character problems
	LOOTHOG_PASS_PATTERN = "passe"
	LOOTHOG_RESETONWATCH_PATTERN = "hat mit einem Wurf von"
	LOOTHOG_RESETONWATCH_PATTERN2 = "dasselbe Ergebnis gehabt!"
	
	-- size of the main and options/config window
	LOOTHOG_UI_MAIN_WIDTH = "190"
	LOOTHOG_UI_CONFIG_WIDTH = "460"
	LOOTHOG_UI_CONFIG_HEIGHT = "330"	

	LOOTHOG_LABEL_ROLLS = "/random Ergebnisse"
	LOOTHOG_LABEL_READY = "Bereit..."  -- Means that LootHog is ready to receive /random rolls.
	LOOTHOG_LABEL_OPTIONS = "LootHog Optionen"
	LOOTHOG_LABEL_HOLDING = "Warten..."  -- Means that the user has clicked "Hold" to prevent the timeout.
	LOOTHOG_LABEL_NOTIMEOUT = "TimeOut aus."
	LOOTHOG_LABEL_TIMELEFT = "TimeOut: %s Sek."  -- (seconds)
	LOOTHOG_LABEL_COUNT = "W\195\188rfe:%s, Spieler:%s"  -- (roll count, player count)
	LOOTHOG_LABEL_NEW_ROLL_TEXT = "neue W\195\188rfelrunde startet jetzt !"
	LOOTHOG_LABEL_DELIMITER = "------------------"
	LOOTHOG_LABEL_WINNERSDELIMITER = "=================="
	LOOTHOG_LABEL_CHATLISTTOP = "W\195\188rfelergebnisse in aufsteigender Reihenfolge"

	LOOTHOG_BUTTON_CLEAR = "L\195\182schen"
	LOOTHOG_BUTTON_OPTIONS = "Optionen"
	LOOTHOG_BUTTON_HOLD = "Warten"
	LOOTHOG_BUTTON_UNHOLD = "Warten aus"
	LOOTHOG_BUTTON_ANNOUNCE = "Ansagen"
	LOOTHOG_BUTTON_YETTOROLL = "Nicht gew\195\188rfelt"
	--LOOTHOG_BUTTON_INFO = "Info"
	LOOTHOG_BUTTON_INFO = "Entfernen"
	LOOTHOG_BUTTON_ROLL = "W\195\188rfeln (1-100)"
	LOOTHOG_BUTTON_PASS = "Passen"
	LOOTHOG_BUTTON_COUNTDOWN = "Countdown"
	LOOTHOG_OPTION_ENABLE = "LootHog aktivieren"
	LOOTHOG_OPTION_FINALIZE = "Beenden der W\195\188rfelrunde nach Ablauf des TimeOuts"
	LOOTHOG_OPTION_GROUPONLY = "W\195\188rfelergebisse nur von Gruppenmitgliedern anzeigen"
	LOOTHOG_OPTION_AUTOSHOW = "LootHog automatisch zeigen sobald jemand w\195\188rfelt"
	LOOTHOG_OPTION_PREVENT = "Ausgabe der /random Befehle im Chat verhindern"
	LOOTHOG_OPTION_CLOSEONANNOUNCE = "LootHog schlie\195\159en nach Bekanntgabe des Siegers"
	LOOTHOG_OPTION_ACK = "Best\195\164tige W\195\188rfe \195\188ber /whisper an die Spieler"
	LOOTHOG_OPTION_REJECT = "Lehne W\195\188rfe mit Werten ausserhalb von (1-100) ab"
	LOOTHOG_OPTION_ANNOUNCEREJECT = "Abgelehnte W\195\188rfe im Chatfenster ansagen"
	LOOTHOG_OPTION_TIMEOUT1 = "LootHog automatisch ausblenden nach "
	LOOTHOG_OPTION_TIMEOUT2 = " Sekunden"
	LOOTHOG_OPTION_ANNOUNCEONCLEAR = "Beim L\195\182schen ausgeben: "
	LOOTHOG_OPTION_RESETONWATCH = "LootHog deaktivieren wenn jemand anderes den Gewinner ank\195\188ndigt"
	LOOTHOG_OPTION_LISTTOCHAT = "Ausgabe aller W\195\188rfelergebnisse in den Chat bei Ank\195\188ndigung des Gewinners"

	--LOOTHOG_MSG_FFA = "Es hat keiner für den Gegenstand gewürfelt. Er ist damit frei für alle."
	LOOTHOG_MSG_LOAD = "LootHog v%s wurde geladen. Dies ist die von Suan(Kaz'goroth) modifizierte Version. Zum \195\182ffnen der Optionen /loothog tippen."  -- (version)
	LOOTHOG_MSG_INFO = "LootHog-Information: Durch Tippen des Textes \"%s\" kann man bei einer W\195\188rfelrunde verzichten."  -- (pass pattern)
	LOOTHOG_MSG_CHEAT = "%ss Wurf von %s (%s-%s) wird ignoriert."  -- (player, roll, max_roll, min_roll)
	LOOTHOG_MSG_ACK = "Dein Wurf von (%s) wurde gez\195\164hlt.  Viel Gl\195\188ck!"  -- (roll)
	LOOTHOG_MSG_ACK_PASS = "Du hast darauf verzichtet zu w\195\188rfeln!"
	LOOTHOG_MSG_DUPE = "%s hat mehr als einmal gew\195\188rfelt. Der Wurf wird nicht gez\195\164hlt!"  -- (player)
	--LOOTHOG_MSG_WINNER = "%s hat mit einem Wurf von %s gewonnen!"  -- (player, roll)
	LOOTHOG_MSG_WINNER = "%s%s hat mit einem Wurf von %s gewonnen!  (%s-%s)  %s" --(player, group, roll, min, max, message)
	LOOTHOG_MSG_ROLLS = "%s: %s hat eine %s gew\195\188rfelt"  -- (roll posistion, player, roll)
	-- The following variables are used to build a string of this type, in the case of a tie:
	-- "Gnomechomsky, Saucytails, and Pionerka tied with 98's!"
	-- I don't know if a literal substitution can provide a proper translation.  Feedback is welcome.  :)
	LOOTHOG_MSG_AND = " und "
	LOOTHOG_MSG_TIED = " haben jeweils mit %s dasselbe Ergebnis gehabt!"  -- (roll)
	LOOTHOG_MSG_YETTOPASS = "Folgende Spieler haben noch nicht gew\195\188rfelt oder verzichtet (per schreiben von %s in den Chat):" --(LOOTHOG_PASS_PATTERN)
	LOOTHOG_MSG_REMOVEROLL = "<LootHog>: %ss Ergebnis von %s wurde entfernt." -- (player, roll)
end

-- French Localization:
-- Original by m0rgoth
-- Updated by Kaërok, Arindelle, mymycracra - Thanks!
if (GetLocale()=="frFR") then
	LOOTHOG_ROLL_PATTERN = "(.+) obtient un (%d+) %((%d+)%-(%d+)%)"
	LOOTHOG_PASS_PATTERN = "passe"
	LOOTHOG_RESETONWATCH_PATTERN = "gagne avec un:"
	LOOTHOG_RESETONWATCH_PATTERN2 = "\195\169galit\195\169 avec"

	-- size of the main and options/config window
	LOOTHOG_UI_MAIN_WIDTH = "190"
	LOOTHOG_UI_CONFIG_WIDTH = "330"
	LOOTHOG_UI_CONFIG_HEIGHT = "330"

	LOOTHOG_LABEL_ROLLS = "/random Rolls"
	LOOTHOG_LABEL_READY = "pr\195\170t..." -- Means that LootHog is ready to receive /random rolls.
	LOOTHOG_LABEL_OPTIONS = "Options de LootHog"
	LOOTHOG_LABEL_HOLDING = "en attente..." -- Means that the user has clicked "Hold" to prevent the timeout.
	LOOTHOG_LABEL_NOTIMEOUT = "Timeout off"
	LOOTHOG_LABEL_TIMELEFT = "Timeout: %s secondes" -- (seconds)
	LOOTHOG_LABEL_COUNT = "R\195\169sultats:%s, Joueurs:%s" -- (roll count, player count)
	LOOTHOG_LABEL_NEW_ROLL_TEXT = ""
	LOOTHOG_LABEL_DELIMITER = "------------------"
	LOOTHOG_LABEL_WINNERSDELIMITER = "=================="
	LOOTHOG_LABEL_CHATLISTTOP = "R\195\169sultats par ordre croissant"

	LOOTHOG_BUTTON_CLEAR = "RAZ"
	LOOTHOG_BUTTON_OPTIONS = "Options"
	LOOTHOG_BUTTON_HOLD = "Hold"
	LOOTHOG_BUTTON_UNHOLD = "UnHold"
	LOOTHOG_BUTTON_ANNOUNCE = "Annonce"
	LOOTHOG_BUTTON_YETTOROLL = "Non lanc\195\169"
	LOOTHOG_BUTTON_INFO = "Info"
	LOOTHOG_BUTTON_ROLL = "Lancer (1-100)"
	LOOTHOG_BUTTON_PASS = "Passe"
	LOOTHOG_BUTTON_COUNTDOWN = "D\195\169compte"
	LOOTHOG_OPTION_ENABLE = "Utiliser LootHog"
	LOOTHOG_OPTION_FINALIZE = "Finir le lancement apr\195\168s l'expiration du d\195\169lai"
	LOOTHOG_OPTION_AUTOSHOW = "ouvre autaumatiquement la fenetre si qq demande un jet al\195\169atoire"
	LOOTHOG_OPTION_GROUPONLY = "Somme des jets pour les membres du groupe uniquement"
	LOOTHOG_OPTION_PREVENT = "empechez les jets d'appara\195\174tre dans la zone de chat"
	LOOTHOG_OPTION_CLOSEONANNOUNCE = "fermer la fenetre de LootHog apr\195\168s l'annonce du gagnant"
	LOOTHOG_OPTION_ACK = "prevenir le joueur avec un /w de son jet"
	LOOTHOG_OPTION_REJECT = "rejeter les jets autres que (1-100)"
	LOOTHOG_OPTION_ANNOUNCEREJECT = "annoncer les jets rejet\195\169s"
	LOOTHOG_OPTION_TIMEOUT1 = "Auto-timeout apr\195\168s "
	LOOTHOG_OPTION_TIMEOUT2 = " secondes"
	LOOTHOG_OPTION_ANNOUNCEONCLEAR = "Annonce apr\195\168s Clear: "
	LOOTHOG_OPTION_RESETONWATCH = "R\195\169initialisation LootHog si quelqu'un d'autre annonce le gagnant"
	LOOTHOG_OPTION_LISTTOCHAT = "Envoyer la liste compl\195\168te des jets sur le chat lors de l'annonce du gagnant"

	LOOTHOG_MSG_LOAD = "LootHog v%s charger. Pour les options, taper /loothog." -- (version)
	LOOTHOG_MSG_INFO = "LootHog-Information: Vous pouvez passer un jet en tapant: %s" -- (pass pattern)
	LOOTHOG_MSG_CHEAT = "ignore le % jet de %s (%s-%s)." -- (player, roll, max_roll, min_roll)
	LOOTHOG_MSG_ACK = "jet enregistr\195\169 (%s). Bonne chance" -- (roll)
	LOOTHOG_MSG_ACK_PASS = "Vous avez pass\195\169 pour ce jet."
	LOOTHOG_MSG_DUPE = "%s a lanc\195\169 plus d'une fois!" -- (player)
	LOOTHOG_MSG_WINNER = "%s gagne avec un: %s!  (%s-%s)  %s" -- (player, roll)
	LOOTHOG_MSG_ROLLS = "%s: %s a obtenu %s." -- (roll posistion, player, roll)
	-- The following variables are used to build a string of this type, in the case of a tie:
	-- "Gnomechomsky, Saucytails, and Pionerka tied with 98's!"
	-- I don't know if a literal substitution can provide a proper translation. Feedback is welcome. :)
	LOOTHOG_MSG_AND = " et "
	LOOTHOG_MSG_TIED = " \195\169galit\195\169 avec %s's!" -- (roll)
	LOOTHOG_MSG_YETTOPASS = "Les personnes suivantes doivent encore jeter le d\195\169 ou dire %s" --(LOOTHOG_PASS_PATTERN)
end