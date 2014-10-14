------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------
 
------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Serenity_Localization_Dialog_De()

	function SerenityLocalization()
		Serenity_Localization_Speech_De();
	end

	SERENITY_COOLDOWN = {
		["Potion"] = "Trank Abklingzeit"
	};

	SerenityTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFSerenity|r",
			["HealingPotion"] = "Heiltr\195\164nke: ",
			["ManaPotion"] = "Manatr\195\164nke: ",
			["Drink"] = "Getr\195\164nke: ",
			["HolyCandle"] = "Heilige Kerzen: ",
			["SacredCandle"] = "Hochheilige Kerzen: ",
			["LightFeather"] = "Leichte Federn: ",
  		},
		["Alt"] = {
			Left = "Rechts-Klick f\195\188r ",
			Right = "",
		},
		["Potion"] = {
			Label = "|c00FFFFFFTrank|r",
			Text = {" ", " in ", " bis "}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFZauber-Ablaufzeiten|r",
			Text = "Abklingzeiten und Zauber auf dem Ziel",
			Right = "Rechts-Klick f\195\188r Ruhestein nach "
		},
		
		["Fortitude"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[38].Name.."|r"
		},
		["DivineSpirit"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[8].Name.."|r"
		},
		["ShadowProtection"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[51].Name.."|r"
		},
		["InnerFire"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[20].Name.."|r"
		},
		["Levitate"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["FearWard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[11].Name.."|r"
		},
		["ElunesGrace"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[9].Name.."|r"
		},
		["Shadowguard"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[54].Name.."|r"
		},
		["TouchOfWeakness"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[59].Name.."|r"
		},
		["Feedback"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[12].Name.."|r"
		},
		["InnerFocus"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[19].Name.."|r"
		},
		["PowerInfusion"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[37].Name.."|r"
		},
		["Shadowform"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[53].Name.."|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[25].Name.."|r"
		},
		["Fade"] = {
			Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[10].Name.."|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFReittier: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFBuff Menu|r\nMittel-Klick um das Menu offen zu halten"
		},
		["Spell"] = {
			Label = "|c00FFFFFFSpells Menu|r\nMittel-Klick um das Menu offen zu halten"
		},
		["Lightwell"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[24].Name.."|r"
		},
		["Resurrection"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[48].Name.."|r"
		},
		["Scream"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[45].Name.."|r"
		},
		["MindControl"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[33].Name.."|r"
		},
		["MindSoothe"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[35].Name.."|r"
		},
		["MindVision"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[36].Name.."|r"
		},
		["ShackleUndead"] = {
		    Label = "|c00FFFFFF"..SERENITY_SPELL_TABLE[49].Name.."|r"
		},
		["Dispel"] = {
			Label = "|c00FFFFFFMagiebannen|r"
		},
		["LastSpell"] = {
			Left = "Rechts-Klick zum wiederholten Zaubern ",      
			Right = "",
		},
		["Drink"] = {
			Label = "|c00FFFFFFTrank|r",
		},
	};


	SERENITY_SOUND = {
		["ShackleWarn"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle01.mp3",
		["ShackleBreak"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle02.mp3",
		["Shackle"] = "Interface\\AddOns\\Serenity\\sounds\\Shackle03.mp3",
	};


--	SERENITY_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "You do not seem to have any Shadow Bolt Spell.",
--		["Message"] = "<white>S<lightPurple1>h<lightPurple2>a<purple>d<darkPurple1>o<darkPurple2>w T<darkPurple1>r<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	SERENITY_MESSAGE = {
		["Error"] = {
			["HolyCandleNotPresent"] = "Fehlende Reagenz: Heilige Kerze",
			["SacredCandle"] = "Fehlende Reagenz: Hochheilige Kerze",
			["LightFeatherNotPresent"] = "Fehlende Reagenz: Leichte Feder",
			["NoRiding"] = "Ihr habt kein Reittier!",
			["FullMana"] = "Ihr k\195\182nnt das nicht benutzen, weil Euer Mana voll ist.",
			["FullHealth"] = "Ihr k\195\182nnt das nicht benutzen, weil Euch kein Leben fehlt.",
			["NoHearthStone"] = "Ihr habt keinen Ruhesteinim Inventar.",
			["NoPotion"] = "Ihr habt diesen Trank nicht im Inventar.",
			["NoDrink"] = "Ihr habt dieses Getr\195\164nk nicht im Inventar.",
			["PotionCooldown"] = "Dieser Trank hat noch Abklingzeit.",
			["NoSpell"] = "Ihr kennt diesen Zauber nicht.",
		},
		["Interface"] = {
			["Welcome"] = "<white>/serenity oder /seren f\195\188r Einstellungen",
			["TooltipOn"] = "Tooltips ausgeschaltet" ,
			["TooltipOff"] = "Tooltips eingeschaltet",
			["MessageOn"] = "Chat-Nachrichten eingeschaltet",
			["MessageOff"] = "Chat-Nachrichten ausgeschaltet",
			["MessagePosition"] = "<- System Nachrichten von Serenity erscheinen hier ->",
			["DefaultConfig"] = "<lightYellow>Standard Einstellungen geladen.",
			["UserConfig"] = "<lightYellow>Konfiguration geladen."
		},
		["Help"] = {
			"/seren recall -- Zentriert Serenity und alle Kn\195\182pfe in der Mitte des Bildschirms",
			"/seren sm -- Ersetzt Nachrichten mit kurzen raidtauglichen Versionen",
			"/seren reset -- Stellt die Standard-Einstellungen wieder her",
			"/serenity toggle -- zeigt/versteckt serenity",
			"Die Funktion der Zauber-Kn\195\182pfe kann man per Schieber im Menu \195\164ndern",						
		},
			["Personality"] = {
			["Greeting"] = "Hallo, "..UnitName("player")..", nett Euch kennenzulernen.",
			["Welcome"] = "Wilkommen, "..UnitName("player"),
			["Signal"] = "Ihr könnt das Signal nicht stoppen",
		},
		["Information"] = {
			["ShackleWarn"] = "Untote Fesseln wird gleich brechen",
			["ShackleBreak"] = "Eure Untote Fesseln wurde gebrochen...",
			["Restocked"] = "Gekauft ",
			["Restock"] = "Kerzen kaufen?",
			["Yes"] = "Ja",
			["No"] = "Nein",
		},	
		["Personality"] = {
			["Greeting"] = "Hallo, "..UnitName("player")..", schön dich zu treffen",
			["Welcome"] = "Willkommen zurück, "..UnitName("player"),
			["Signal"] = "Du kannst das Signal nicht stoppen",
		},
		
	};


	-- Gestion XML - Menu de configuration

	SERENITY_COLOR_TOOLTIP = {
		["Purple"] = "Violett",
		["Blue"] = "Blau",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "T\195\188rkis",
		["X"] = "X"
	};
	
	SERENITY_CONFIGURATION = {
		["Menu1"] = "Allgemeines",
		["Menu2"] = "Nachrichten",
		["Menu3"] = "Kn\195\182pfe",
		["Menu4"] = "Timer",
		["Menu5"] = "Graphik",
		["MainRotation"] = "Rotiere Kn\195\182pfe",
		["InventoryMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["InventoryMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "Packe Trank in die gew\195\164hlte Tasche.",
		["ProvisionDestroy"] = "Zerst\195\182re alle neuen Getr\195\164nke und Mahlzeiten, falls die Tasche voll ist.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "Wei\195\159er Text anstelle von gelben Timer Text.",
		["TimerDirection"] = "Timer Liste w\195\164chst aufw\195\164rts",
		["TranseWarning"] = "Alert me when I enter a Trance State",
		["SpellTime"] = "Zauber-Laufzeit Anzeige einschalten",
		["AntiFearWarning"] = "Warnen wenn Ziel furcht-immun ist.",
		["GraphicalTimer"] = "Balkenanzeige der Timer anstelle von Text",	
		["TranceButtonView"] = "Zeige versteckte Kn\195\182pfe.",
		["ButtonLock"] = "Kn\195\182pfe fixiern.",
		["MainLock"] = "Serenity Sph\195\164re fixieren.",
		["BagSelect"] = "Auswahl der Essen und Tr\195\164nke Tasche",
		["BuffMenu"] = "Buff-Leiste auf der linken Seite",
		["SpellMenu"] = "Zauber-Leiste auf der linken Seite",
		["STimerLeft"] = "Zeige Timer auf der linken Seite des Knopfes",
		["ShowCount"] = "Gegenstandsz\195\164hler in Serenity aktivieren",
		["CountType"] = "In der Sph\195\164re zeigen",
		["Potion"] = "Trank-Grenze",
		["Sound"] = "Aktiviere Sounds",
		["ShowMessage"] = "Zuf\195\164llige Ausspr\195\188che",
		["ShowResMessage"] = "Zuf\195\164llige Ausspr\195\188che aktivieren (Wiederbelebung)",
		["ShowSteedMessage"] = "Zuf\195\164llige Ausspr\195\188che aktivieren (Reittier)",
		["ShowShackleMessage"] = "Zuf\195\164llige Ausspr\195\188che aktivieren (Untot fesseln)",
		["ChatType"] = "Serenity Meldungen als System Nachrichten zeigen",
		["SerenitySize"] = "Gr\195\182\195\159e der inneren Sph\195\164re",
		["StoneScale"] = "Gr\195\182\195\159e der \195\164usseren Kn\195\182pfe",
		["ShackleUndeadSize"] = "Gr\195\182\195\159e des Untot fesseln Knopfes",
		["TranseSize"] = "Gr\195\182\195\159e des Trance und Furchschutz Knopfes",
		["Skin"] = "Trink Grenze",
		["PotionOrder"] = "Benutze diesen Trank zuerst",
		["Show"] = {
			["Text"] = "Zeige Kn\195\182pfe:",
			["Potion"] = "Tr\195\164nke",
			["Drink"] = "Getr\195\164nke",
			["Dispel"] = "Magiebannung",
			["LeftSpell"] = "Linker Zauber",
			["MiddleSpell"] = "Mittlerer Zauber",
			["RightSpell"] = "Rechter Zauber",
			["Steed"] = "Reittier",
			["Buff"] = "Buff-Menu",
			["Spell"] = "Zauber-Menu",
			["Tooltips"] = "Zeige Tooltips",
			["Spelltimer"] = "Zauber-Laufzeit Knopf"
		},
		["Text"] = {
			["Text"] = "Sph\195\165ren-Tooltip:",
			["Potion"] = "Trank-Z\195\164hler",
			["Drink"] = "Getr\195\164nke-Z\195\164hler",
			["Potion"] = "Trank-Abklingzeit",
			["Evocation"] = "Hervorrufungs-Abklingzeit",
			["HolyCandles"] = "Heilige Kerzen",
			["Feather"] = "Leichte Federn",
			["SacredCandles"] = "Hochheilige Kerzen",
		},
		["QuickBuff"] = "\195\150ffne/Schlie\195\159e Buff-Leiste bei Mouse-over",
		["Count"] = {
			["None"] = "Nichts",
			["Candles"] = "Candles",
			["Drink"] = "Anzahl Getr\195\164nke",
			["PotionCount"] = "Anzahl Mana/Heiltr\195\164nke",
			["Health"] = "Momentanes Leben",
			["HealthPercent"] = "Leben in Prozent",
			["Mana"] = "Momentanes Mana",
			["ManaPercent"] = "Mana in Procent",
			["PotionCooldown"] = "Trank-Abklingzeit",
		},
		["Circle"] = {
			["Text"] = "Im Sph\195\164renkranz zeigen",
			["None"] = "Nichts",
			["HP"] = "Momentanes Leben",
			["Mana"] = "Momentanes Mana",
			["Potion"] = "Abklingzeit der Tr\195\164nke",
			["FiveSec"] = "'fuenf Sekunden'-Regel",
		},
		["Button"] = {
			["Text"] = "Hauptknopf-Funktion",
			["Drink"] = "Trinken",
			["ManaPotion"] = "Manatrank benutzen",
			["HealingPotion"] = "Heiltrank benutzen",
		},
		["Restock"] = {
			["Restock"] = "Automatisch Reagenzien kaufen",
			["Confirm"] = "Nachfragen vor dem Kauf",			
		},
		["ShackleUndead"] = {
			["Warn"] = "Vor-Warnung bevor Untote fesseln bricht",
			["Break"] = "Warnung wenn Untote fesseln bricht",
		},
		["ButtonText"] = "Zeige Reagenzien-Vorrat",
		["Anchor"] = {
			["Text"] = "Menu Anker Punkt",
			["Above"] = "Oberhalb",
			["Center"] = "Mitte",
			["Below"] = "Unterhalb"
		},
	};
end     