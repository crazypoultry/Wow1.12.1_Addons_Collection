
klhtm.string.data["deDE"] = 
{
	["binding"] = 
	{
		hideshow = "Fenster zeigen/verstecken",
		stop = "Notaus",
		mastertarget = "Hauptziel setzen/l\195\182schen",
		resetraid = "Raidbedrohung l\195\182schen",
	},
	["spell"] = 
	{
		-- 17.20
		["execute"] = "Hinrichten",
		
		["heroicstrike"] = "Heldenhafter Sto\195\159",
		["maul"] = "Zermalmen",
		["swipe"] = "Prankenhieb",
		["shieldslam"] = "Schildschlag",
		["revenge"] = "Rache",
		["shieldbash"] = "Schildhieb",
		["sunder"] = "R\195\188stung zerrei\195\159en",
		["feint"] = "Finte",
		["cower"] = "Ducken",
		["taunt"] = "Spott",
		["growl"] = "Knurren",
		["vanish"] = "Verschwinden",
		["frostbolt"] = "Frostblitz",
		["fireball"] = "Feuerball",
		["arcanemissiles"] = "Arkane Geschosse",
		["scorch"] = "Versengen",
		["cleave"] = "Spalten",
		
		hemorrhage = "Blutsturz",
		backstab = "Meucheln",
		sinisterstrike = "Finsterer Sto\195\159",
		eviscerate = "Ausweiden",

		-- Items / Buffs:
		["arcaneshroud"] = "Arkaner Schleier",
		["reducethreat"] = "Verringerte Bedrohung",

		-- Leeches: no threat from heal
		["holynova"] = "Heilige Nova", -- no heal or damage threat
		["siphonlife"] = "Lebensentzug", -- no heal threat
		["drainlife"] = "Blutsauger", -- no heal threat
		["deathcoil"] = "Todesmantel",	

		-- Fel Stamina and Fel Energy DO cause threat! GRRRRRRR!!!
		--["felstamina"] = "Teufelsausdauer",
		--["felenergy"] = "Teufelsenergie",

		["bloodsiphon"] = "Bluttrinker", -- poisoned blood vs Hakkar

		["lifetap"] = "Aderlass", -- no mana gain threat
		["holyshield"] = "Heiliger Schild", -- multiplier
		["tranquility"] = "Gelassenheit",
		["distractingshot"] = "Ablenkender Schuss",
		["earthshock"] = "Erdschock",
		["rockbiter"] = "Felsbei\195\159er",
		["fade"] = "Verblassen",
		["thunderfury"] = "Donnerzorn",

		-- Spell Sets
		-- warlock descruction
		["shadowbolt"] = "Schattenblitz",
		["immolate"] = "Feuerbrand",
		["conflagrate"] = "Feuersbrunst",
		["searingpain"] = "Sengender Schmerz", -- 2 threat per damage
		["rainoffire"] = "Feuerregen",
		["soulfire"] = "Seelenfeuer",
		["shadowburn"] = "Schattenbrand",
		["hellfire"] = "H\195\182llenfeuer",
		
		-- mage offensive arcane
		["arcaneexplosion"] = "Arkane Explosion",
		["counterspell"] = "Gegenzauber",
		
		-- priest shadow. No longer used (R17).
		["mindblast"] = "Gedankenschlag",	-- 2 threat per damage
		--[[
		["mindflay"] = "Gedankenschinden",
		["devouringplague"] = "Verschlingende Seuche",
		["shadowwordpain"] = "Schattenwort: Schmerz",
		,
		["manaburn"] = "Manabrand",
		]]
	},
	["power"] = 
	{
		["mana"] = "Mana",
		["rage"] = "Wut",
		["energy"] = "Energie",
	},
	["threatsource"] = -- these values are for user printout only
	{
		["powergain"] = "Power Gain",
		["total"] = "Total",
		["special"] = "Spezial",
		["healing"] = "Heilung",
		["dot"] = "Dots",
		["threatwipe"] = "NPC Zauber",
		["damageshield"] = "Schadensschild",
		["whitedamage"] = "Wei\195\159er Schaden",
	},
	["talent"] = -- these values are for user printout only
	{
		["defiance"] = "Trotz",
		["impale"] = "Durchbohren",
		["silentresolve"] = "Schweigsame Entschlossenheit",
		["frostchanneling"] = "Frost-Kanalisierung",
		["burningsoul"] = "Brennende Seele",
		["healinggrace"] = "Geschick der Heilung",
		["shadowaffinity"] = "Schattenaffinit\195\164t",
		["druidsubtlety"] = "Druide Feingef\195\188hl",
		["feralinstinct"] = "Instinkt der Wildnis",
		["ferocity"] = "Wildheit",
		["savagefury"] = "Ungez\195\164hmte Wut",
		["tranquility"] = "Verbesserte Gelassenheit",
		["masterdemonologist"] = "Meister der D\195\164monologie",
		["arcanesubtlety"] = "Arkanes Feingef\195\188hl",
		["righteousfury"] = "Zorn der Gerechtigkeit",
		["sleightofhand"] = "Kunstgriff",
	},
	["threatmod"] = -- these values are for user printout only
	{
		["tranquilair"] = "Beruhigende Winde",
		["salvation"] = "Segen der Rettung",
		["battlestance"] = "Kampfhaltung",
		["defensivestance"] = "Verteidigungshaltung",
		["berserkerstance"] = "Berserkerhaltung",
		["defiance"] = "Trotz",
		["basevalue"] = "Basiswert",
		["bearform"] = "B\195\164rgestalt",
		["catform"] = "Katzengestalt",
		["glovethreatenchant"] = "erh\195\182te Bedrohung durch Handschuhverzauberung",
		["backthreatenchant"] = "verringerte Bedrohung durch Umhangverzauberung",
	},

	["sets"] = 
	{
		["bloodfang"] = "Blutfang",
		["nemesis"] = "Nemesis",
		["netherwind"] = "Netherwind",
		["might"] = "der Macht",
		["arcanist"] = "des Arkanisten",
	},
	["boss"] = 
	{
		["speech"] = 
		{
			["razorphase2"] = "flieht w\195\164hrend die kontrollierenden Kr\195\164fte der Kugel schwinden",
			["onyxiaphase3"] = "Mir scheint, dass Ihr noch eine Lektion braucht, sterbliche Wesen!",
			["thekalphase2"] = "fill me with your RAGE",
			["rajaxxfinal"] = "Unversch\195\164mter Narr! Ich werde euch h\195\182chstpers\195\182nlich t\195\182\195\182ten! will kill you myself!",
			["azuregosport"] = "Kommt ihr Wichte! Tretet mir gegen\195\188ber!",
			["nefphase2"] = "BRENNT! Ihr Elenden! BRENNT!",
		},
		-- Some of these are unused. Also, if none is defined in your localisation, they won't be used,
		-- so don't worry if you don't implement it.
		["name"] = 
		{	
			["rajaxx"] = "General Rajaxx",
			["onyxia"] = "Onyxia",
			["ebonroc"] = "Ebonroc",
			["razorgore"] = "Razorgore der Ungez\195\164hmte",
			["thekal"] = "Hohepriester Thekal",
			["shazzrah"] = "Shazzrah",
			["twinempcaster"] = "Imperator Vek'lor",
			["twinempmelee"] = "Imperator Vek'nilash",
			["noth"] = "Noth der Seuchenf\195\188rst",
		},
		["spell"] = 
		{
			["shazzrahgate"] = "Portal von Shazzrah", -- "Shazzrah casts Gate of Shazzrah."
			["wrathofragnaros"] = "Zorn des Ragnaros", -- "Ragnaros's Wrath of Ragnaros hits you for 100 Fire damage."
			["timelapse"] = "Zeitraffer", -- "You are afflicted by Time Lapse."
			["knockaway"] = "Wegschlagen",
			["wingbuffet"] = "Fl\195\188gelsto\195\159",
			["burningadrenaline"] = "Brennendes Adrenalin",
			["twinteleport"] = "Zwillingsteleport",
			["nothblink"] = "Blinzeln",
			["sandblast"] = "Sandsto\195\159",
			["fungalbloom"] = "Pilzwucher",
			["hatefulstrike"] = "Hasserf\195\188llter Sto\195\159",
			
			-- 4 horsemen marks
			mark1 = "Mal von Blaumeux",
			mark2 = "Mal von Korth'azz",
			mark3 = "Mal von Mograine",
			mark4 = "Mal von Zeliek",
			
			-- Onyxia fireball (presumably same as mage)
			["fireball"] = "Feuerball",
		}
	},
	["misc"] = 
	{
		["imp"] = "Wichtel", -- UnitCreatureFamily("pet")
		["spellrank"] = "Rang (%d+)", -- second value of GetSpellName(x, "spell")
		["aggrogain"] = "Aggro bekommen",
	},
	
	--[[
	This is reserved for future use.
	
	["mobattack"] = 
	{
		["self"] = {
			["hit"] = "(.+) trifft Euch f\195\188r %d+ Schaden%.", -- COMBATHITOTHERSELF
			["crit"] = "(.+) trifft Euch kritisch%. Schaden: %d+%.", -- COMBATHITCRITOTHERSELF
			["absorb"] = "(.+) greift an%. Ihr absorbiert allen Schaden%.", -- VSABSORBOTHERSELF
			["dodge"] = "(.+) greift an%. Ihr weicht aus%.", -- VSDODGEOTHERSELF
			["parry"] = "(.+) greift an%. Ihr pariert%.", -- VSPARRYOTHERSELF
			["block"] = "(.+) greift an%. Ihr blockt%.", -- VSBLOCKOTHERSELF
			["miss"] = "(.+) verfehlt Euch%.", -- MISSEDOTHERSELF
			["resist"] = "(.+) greift an%. Ihr widersteht dem gesamten Schaden%.", -- VSRESISTOTHERSELF
		},
		["other"] = {	
			["hit"] = "(.+) trifft (.+) f\195\188r %d+ Schaden%.", -- COMBATHITOTHEROTHER 
			["crit"] = "(.+) trifft (.+) kritisch f\195\188r %d+ Schaden%.", -- COMBATHITCRITOTHEROTHER
			["absorb"] = "(.+) greift an%. (.+) absorbiert allen Schaden%.", -- VSABSORBOTHEROTHER
			["dodge"] = "(.+) greift an%. (.+) weicht aus%.", -- VSDODGEOTHEROTHER
			["parry"] = "(.+) greift an%. (.+) pariert%.", -- VSPARRYOTHEROTHER
			["block"] = "(.+) greift an%. (.+) blockt ab%.", -- VSBLOCKOTHEROTHER
			["miss"] = "(.+) verfehlt (.+)%.", -- MISSEDOTHEROTHER
			["resist"] = "(.+) greift an%. (.+) widersteht dem gesamten Schaden%.", -- VSRESISTOTHEROTHER
		},
	},
	
	]]
	
	-- labels and tooltips for the main window
	["gui"] = { 
		["raid"] = {
			["head"] = {
				-- column headers for the raid view
				["name"] = "Name",
				["threat"] = "Bedrohung",
				["pc"] = "%Max",			-- your threat as a percentage of the #1 player's threat
			},
			["stringshort"] = {
				-- tooltip titles for the bottom bar strings
				["tdef"] = "Threat Margin", -- the difference in threat between you and the MT / #1 in the list.
				["targ"] = "Hauptziel",
			},
			["stringlong"] = {
				-- tooltip descriptions for the bottom bar strings
				["tdef"] = "",
				["targ"] = "Nur Bedrohung gegen %s wird derzeit in den Bedrohungswerten des Raids einberechnet."
			},
		},
		["self"] = {
			["head"] = {
				-- column headers for the self view
				["name"] = "Name",
				["hits"] = "Treffer",
				["rage"] = "Wut",
				["dam"] = "Schaden",
				["threat"] = "Bedrohung",
				["pc"] = "%B",			-- Abbreviation of %Threat
			},
			-- text on the self threat reset button
			["reset"] = "L\195\182schen",
		},
		["title"] = {
			["text"] = {
				-- the window titles
				["long"] = "KTM %d.%d",	-- don't need to localise these
				["short"] = "KTM",
				
			},
			["buttonshort"] = {
				-- the tooltip titles for command buttons
				["close"] = "Schlie\195\159en",
				["min"] = "Minimieren",
				["max"] = "Maximieren",
				["self"] = "Eigenansicht",
				["raid"] = "Raidansicht",
				["pin"] = "Befestigen",
				["unpin"] = "Losmachen",
				["opt"] = "Optionen",
				["targ"] = "Hauptziel",
				["clear"] = "L\195\182schen",
			},
			["buttonlong"] = {
				-- the tooltip descriptions for command buttons
				["close"] = "Bedrohungswerte werden auch dann weiter \195\188bermittelt, wenn du in einer Gruppe oder in einem Raid bist.",
				["min"] = "",
				["max"] = "",
				["self"] = "Zeigt die Details der von dir verursachten Bedrohung.",
				["raid"] = "Zeigt die Bedrohungswerte deines Raids",
				["pin"] = "Verhindert, dass das Threatmeterfenster bewegt werden kann.",
				["unpin"] = "Gibt das Threatmeterfenster frei, so dass es bewegt werden kann.",
				["opt"] = "",
				["targ"] = "Legt das Hauptziel auf dein aktuelles Ziel fest. Falls du kein Ziel hast, wird das Hauptziel gel\195\182scht. Du musst dazu Gruppenanf\195\188hrer oder Assistent sein.",
				["clear"] = "Setzt die Bedrohung aller Spieler auf 0. Du musst dazu Gruppenanf\195\188hrer oder Assistent sein.",
			},
			["stringshort"] = {
				-- the tooltip titles for titlebar strings
				["threat"] = "Bedrohung",
				["tdef"] = "Bedrohungsdefizit",
				["rank"] = "Bedrohungsrang",
				["pc"] = "% Bedrohung",
			},
			["stringlong"] = {
				-- the tooltip descriptions for titlebar strings
				["threat"] = "Die Menge an Bedrohung die angesammelt wurde, seitdem dein pers\195\182nlicher Wert zur\195\188ckgesetzt wurde.",
				["tdef"] = "Die Differenz der Bedrohung zwischen deiner Bedrohung und der des Ziels.",
				["rank"] = "Deine Position in der Bedrohungsliste.",
				["pc"] = "Deine Bedrohung in Prozent am Ziel.",
			},
		},
	},
	-- labels and tooltips for the options gui
	["optionsgui"] = {
		["buttons"] = {
			-- the options gui command button labels
			["gen"] = "Allgem.",
			["raid"] = "Raid",
			["self"] = "Selbst",
			["close"] = "Schlie\195\159en",	
		},
		-- the labels for option checkboxes and headers
		["labels"] = {
			-- the title description for each option page
			["titlebar"] = {
				["gen"] = "Allgemeine Einstellungen",
				["raid"] = "Schlachtzug Einstellungen",
				["self"] = "Eigenansicht Einstellungen",
			},
			["buttons"] = {
				-- the names of title bar command buttons
				["pin"] = "Befestigen",
				["opt"] = "Optionen",
				["view"] = "Ansicht\195\164nderung",
				["targ"] = "Hauptziel",
				["clear"] = "L\195\182schen",
			},
			["columns"] = {
				-- names of columns on the self and raid views
				["hits"] = "Treffer",
				["rage"] = "Wut",
				["dam"] = "Schaden",
				["threat"] = "Bedrohung",
				["pc"] = "% Bedrohung",
			},
			["options"] = {
				-- miscelaneous option names
				["hide"] = "Verstecke '0'-Reihen",
				["abbreviate"] = "Gro\195\159e Werte abk\195\188rzen",
				["resize"] = "Gr\195\182\195\159e anpassen",
				["aggro"] = "Aggrogrenze anzeigen",
				["rows"] = "Sichtbare Reihen",
				["scale"] = "Skalierung",
				["bottom"] = "Unt. Leiste verstecken",
			},
			["minvis"] = {
				-- the names of minimised strings
				["threat"] = "minimierte Bedrohung", -- dodge...
				["rank"] = "Bedrohungsrang",
				["pc"] = "% Bedrohung",
				["tdef"] = "Bedrohungsdefizit",
			},
			["headers"] = {
				-- headers in the options gui
				["columns"] = "Sichtbare Spalten",
				["strings"] = "Minimierte Strings",
				["other"] = "Andere Optionen",
				["minvis"] = "Minimierte Ansicht",
				["maxvis"] = "Maximierte Ansicht",
			},
		},
		-- the tooltips for some of the options
		["tooltips"] = {
			-- miscelaneous option descriptions
			["raidhide"] = "Wenn dies aktiviert ist, werden Spieler ohne Bedrohung nicht im Threatmeter anezeigt.",
			["selfhide"] = "Wenn dies ausgeschaltet ist, werden alle Bedrohungsarten gezeigt.",
			["abbreviate"] = "Wenn dies aktivert ist, werden Werte die gr\195\182\195\159er als 10000 sind mit 'k' abgek\195\188rzt. Aus 15400 wird z.B. 15.4k.",
			["resize"] = "Wenn dies aktiviert ist, wird die Anzahl sichtbarer Reihen so veringert, dass sie der Anzahl der Spieler die Bedrohungswerte \195\188bermitteln entspricht.",
			["aggro"] = "Wenn dies aktiviert ist, wird eine Grenze in der Schlachtzugansicht angezeigt, bei der du vorrausichtlich Aggro ziehen wirst. Diese ist am genauesten, wenn ein Hauptziel gesetzt ist.",
			["rows"] = "Die maximale Ansicht  der sichtbaren Spieler im Schlachtzugbedrohungsfenster.",
			["bottom"] = "Wenn dies aktiviert ist, wird die untere Leiste versteckt. Diese zeigt das Bedrohungsdefizit und das Hauptziel an.",
		},
	},
	["print"] = 
	{
		["main"] = 
		{
			["startupmessage"] = "KLHThreatMeter Release |cff33ff33%s|r Revision |cff33ff33%s|r geladen. Tippe |cffffff00/ktm|r um Hilfe zu erhalten.",
		},
		["data"] = 
		{
			["abilityrank"] = "Deine %s F\195\164higkeit ist Rang %s.",
			["globalthreat"] = "Dein globaler Bedrohungsmultiplikator ist %s.",
			["globalthreatmod"] = "%s gibt dir einen Wert von %s.",
			["multiplier"] = "Als %s wird deine Bedrohung durch %s mit %s multipliziert.",
			["damage"] = "Schaden",
			["shadowspell"] = "Schattenzauber",
			["arcanespell"] = "Arkanzauber",
			["holyspell"] = "Heiligzauber",
			["setactive"] = "%s %d Teile aktiv? ... %s.",
			["true"] = "ja",
			["false"] = "nein",
			["healing"] = "Deine Heilung verursacht %s Bedrohung (vor Einrechnung des globalen Bedrohungsmultiplikators).",
			["talentpoint"] = "Du hast %d Talentpunkte in %s.",
			["talent"] = "%d %s Talente gefunden.",
			["rockbiter"] = "Dein Rang %d Felsbei\195\159er f\195\188gt %d Bedrohung zu erfolgreichen Nahkampfangriffen hinzu.",
		},
		
		-- new in R17.7
		["boss"] = 
		{
			["automt"] = "Das Hauptziel wurde automatisch auf %s gesetzt.",
			["spellsetmob"] = "%s legt den %s Parameter von %ss %s F\195\164higkeit von %s auf %s.", -- "Kenco sets the multiplier parameter of Onyxia's Knock Away ability to 0.7"
			["spellsetall"] = "%s legt die %s Parameter von %s F\195\164higkeiten von %s auf %s.",
			["reportmiss"] = "%s berichtet, dass %ss %s ihn verfehlt hat.",
			["reporttick"] = "%s berichtet, dass %ss %s ihn getroffen hat. Er hat bereits %s Stapelungen hinter sich, und wird an  %s mehr Stapelungen leiden.",
			["reportproc"] = "%s berichtet, dass %sss %s seine Bedrohung von %s zu %s ge\195\164ndert hat..",
			["bosstargetchange"] = "%s \195\164nderte das Zeil von %s (mit %s Bedrohung) zu %s (mit %s Bedrohung).",
			["autotargetstart"] = "Du wirst automatisch das Threatmeter l\195\182schen und das Hauptziel neu setzen, wenn du das n\195\164chste Mal einen Weltboss anw\195\164hlst.",
			["autotargetabort"] = "Das Hauptziel wurde bereits auf den Weltboss %s gesetzt.",
		},
		
		["network"] = 
		{
			["newmttargetnil"] = "Es konnte kein neues Hauptziel festgelegt werden, da %s scheinbar nicht existiert.",
			["newmttargetmismatch"] = "|cffffff00%s|r setzte das Hauptziel auf %s, aber sein eigenes Ziel ist %s. Sein eigenes Ziel wird stattdessen benutzt, \195\188berpr\195\188fen!",
			["mtpollwarning"] = "Dein Hauptziel wurde auf %s gesetzt, aber dies konnte nicht \195\188berpr\195\188ft werden. Falls sich dieses falsch anh\195\182rt, bitte %s das Hauptziel erneut bekanntzugeben.",
			["threatreset"] = "Das Threatmeter wurde von %s zur\195\188ckgesetzt.",
			["newmt"] = "Das Hauptziel wurde auf '%s' festgelegt. (von %s)",
			["mtclear"] = "Das Hauptziel wurde von %s gel\195\182scht.",
			["knockbackstart"] = "R\195\188cksto\195\159 Entdeckung wurde von %s aktiviert.",
			["knockbackstop"] = "R\195\188cksto\195\159 Entdeckung wurde von %s gestoppt.",
			["aggrogain"] = "|cffffff00%s|r meldet 'Aggro bekommen' mit %d Bedrohung.",
			["aggroloss"] = "|cffffff00%s|r meldet 'Aggro verloren' mit %d Bedrohung.",
			["knockback"] = "|cffffff00%s|r meldet 'R\195\188cksto\195\159 abbekommen'. Er ist runter auf %d Bedrohung.",
			["knockbackstring"] = "%s meldet diesen R\195\188cksto\195\159text '%s'.",
			["upgraderequest"] = "%s bittet dich um Upgrade auf Release %s von KLHThreatMeter. Du benutzt gerade Release %s.",
			["remoteoldversion"] = "%s benutzt die veraltete Version %s von KLHThreatMeter. Bitte sag Ihm er soll auf Release %s upgraden.",
			["knockbackvaluechange"] = "|cffffff00%s|r hat die Bedrohungreduzierung von %s's |cffffff00%s|r Angriff auf |cffffff00%d%%|r gesetzt.",
			["raidpermission"] = "Du musst Raid Leader oder Assistant sein um das zu tun!",
			["needmastertarget"] = "Du musst zuerst ein Hauptziel setzen!",
			["knockbackinactive"] = "R\195\188cksto\195\159 R\195\188cksto\195\159 ist nicht aktiv im Raid.",
			["versionrequest"] = "Fordere Versionsinformationen des Raids an. Antwort in 3 Sekunden.",
			["versionrecent"] = "Diese Leute haben Release %s: { ",
			["versionold"] = "Diese Leute haben \195\164ltere Versionen: { ",
			["versionnone"] = "Diese Leute haben kein KLHThreatMeter, oder sind nicht im richtigen CTRA channel: { ",
			["channel"] = 
			{
				ctra = "CTRA Channel",
				ora = "oRA Channel",
				manual = "Manual Override",
			},
			needtarget = "W\195\164hle zuerst einen Gegner aus, bevor du das Hauptziel setzt.",
			upgradenote = "Benutzer veralteter Versionen der Mod wurden zum Upgraden aufgefordert.",
			advertisestart = "Du wirst nun Spieler die Aggro ziehen dazu auffordern KLHThreatMeter zu installieren.",
			advertisestop = "Du hast aufgeh\195\182rt automatisch Werbung f\195\188r KLHThreatMeter zu machen.",
			advertisemessage = "Wenn du KLHThreatMeter h\195\164ttest, h\195\164ttest du vielleicht keine Aggro gezogen, %s.",
		},

		-- ok, so autohide isn't really a word, but just improvise
		table = 
		{
			autohideon = "Das Fenster wird nun automatisch versteckt und angezeigt.",
			autohideoff = "Das Fenster ist nicht länger automatisch versteckt.",
		}
	}
}
