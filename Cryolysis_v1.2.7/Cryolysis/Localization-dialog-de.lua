------------------------------------------------------------------------------------------------------
-- Cryolysis
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Cryolysis Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail!  Yersinia on Aegwynn, Horde side.
-- Guild: <Working as Intended>
-- Version Date: 07.14.2006
------------------------------------------------------------------------------------------------------


------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Cryolysis_Localization_Dialog_De()

	function CryolysisLocalization()
		Cryolysis_Localization_Speech_De();
	end

	CRYOLYSIS_COOLDOWN = {
		["Evocation"] = "Hervorrufung Abklingzeit",
		["Manastone"] = "Manaedelstein Abklingzeit"
	};

	CryolysisTooltipData = {
		["Main"] = {
			Label = "|c00FFFFFFCryolysis|r",
			Stone = {
				[true] = "Ja";
				[false] = "Nein";
			},
			Hellspawn = {
				[true] = "Ein";
				[false] = "Aus";
			},
			["Food"] = "Herbeigezaubertes Essen: ",
			["Drink"] = "Herbeigezaubertes Wasser: ",
			["RuneOfTeleportation"] = "Rune der Teleportation: ",
			["RuneOfPortals"] = "Rune der Portale: ",
			["ArcanePowder"] = "Arkanes Pulver: ",
			["LightFeather"] = "Leichte Federn: ",
			["Manastone"] = "Manaedelstein: ",
		},
		["Alt"] = { 
			Left = "Rechtsklick, um ",
			Right = " zu aktivieren",
		},
		["Soulstone"] = {
			Label = "|c00FF99FFSeelenstein|r",
			Text = {"Erstelle","Verwende","Benutzt","Warten"}
		},
		["Manastone"] = {
			Label = "|c00FFFFFFManaedelstein|r",
			Text = {": Erstellen - ",": Benutzen", ": Wartend", ": Nicht erreichbar"}
		},
		["SpellTimer"] = {
			Label = "|c00FFFFFFSpruchdauer|r",
			Text = "Abklingzeiten und aktive Spr\195\188che auf dem Ziel",
			Right = "Rechtsklick f\195\188r Ruhestein nach "
		},
		["Armor"] = {
			Label = "|c00FFFFFFEisr\195\188stung|r"
		},
		["MageArmor"] = {
			Label = "|c00FFFFFFMagische R\195\188stung|r"
		},
		["ArcaneInt"] = {
			Label = "|c00FFFFFFArkane Intelligenz|r"
		},
		["ArcaneBrilliance"] = {
			Label = "|c00FFFFFFArkane Brillanz|r"
		},
		["DampenMagic"] = {
			Label = "|c00FFFFFFMagie d\195\164mpfen|r"
		},
		["AmplifyMagic"] = {
			Label = "|c00FFFFFMagie verst\195\164rken|r"
		},
		["SlowFall"] = {
			Label = "|c00FFFFFFLangsamer Fall|r"
		},
		["FireWard"] = {
			Label = "|c00FFFFFFFeuerzauberschutz|r"
		},
		["FrostWard"] = {
			Label = "|c00FFFFFFFrostzauberschutz|r"
		},
		["ConjureFood"] = {
			Label = "|c00FFFFFFEssen herbeizaubern|r"
		},
		["ConjureDrink"] = {
			Label = "|c00FFFFFFWasser herbeizaubern|r"
		},
		["Evocation"] = {
			Label = "|c00FFFFFFHervorrufung|r",
			Text = "Benutzen"
		},
		["ColdSnap"] = {
			Label = "|c00FFFFFFK\195\164lteeinbruch|r"
		},
		["IceBarrier"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[23].Name.."|r"
		},
		["ManaShield"] = {
			Label = "|c00FFFFFF"..CRYOLYSIS_SPELL_TABLE[25].Name.."|r"
		},
		["DetectMagic"] = {
			Label = "|c00FFFFFFMagie entdecken|r"
		},
		["RemoveCurse"] = {
			Label = "|c00FFFFFFGeringen Fluch aufheben|r"
		},
		["Mount"] = {
			Label = "|c00FFFFFFReittier: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFSpruchmen\195\188|r\nMittlere Taste, um das Men\195\188 zu \195\182ffnen"
		},
		["Portal"] = {
			Label = "|c00FFFFFFPortalmen\195\188|r\nMittlere Taste, um das Men\195\188 zu \195\182ffnen"
		},
		["T:Org"] = {
		    Label = "|c00FFFFFFTeleport: Orgrimmar|r"
		},
		["T:UC"] = {
		    Label = "|c00FFFFFFTeleport: Undercity|r"
		},
		["T:TB"] = {
		    Label = "|c00FFFFFFTeleport: Thunder Bluff|r"
		},
		["T:IF"] = {
		    Label = "|c00FFFFFFTeleport: Ironforge|r"
		},
		["T:SW"] = {
		    Label = "|c00FFFFFFTeleport: Stormwind|r"
		},
		["T:Darn"] = {
		    Label = "|c00FFFFFFTeleport: Darnassus|r"
		},
		["P:Org"] = {
		    Label = "|c00FFFFFFPortal: Orgrimmar|r"
		},
		["P:UC"] = {
		    Label = "|c00FFFFFFPortal: Undercity|r"
		},
		["P:TB"] = {
		    Label = "|c00FFFFFFPortal: Thunder Bluff|r"
		},
		["P:IF"] = {
		    Label = "|c00FFFFFFPortal: Ironforge|r"
		},
		["P:SW"] = {
		    Label = "|c00FFFFFFPortal: Stormwind|r"
		},
		["P:Darn"] = {
		    Label = "|c00FFFFFFPortal: Darnassus|r"
		},
		["EvocationCooldown"] = "Rechtsklick f\195\188r eine schnelle Beschw\195\182rung",
		["LastSpell"] = {
			Left = "Rechtsklick dr\195\188cken, um ",
			Right = " zu aktivieren"
		},
		["Food"] = {
			Label = "|c00FFFFFFEssen|r",  
			Right = "Rechtsklick, um Essen herbeizuzaubern",
			Middle = "Mittlere Maustaste, um zu handeln",
		},
		["Drink"] = {
			Label = "|c00FFFFFFWasser|r",
			Right = "Rechtsklick, um Wasser herbeizuzaubern",
			Middle = "Mittlere Maustaste, um zu handeln",
		},
	};


	CRYOLYSIS_SOUND = {
		["SheepWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep01.mp3",
		["SheepBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Sheep02.mp3",
		["PigWarn"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig01.mp3",
		["PigBreak"] = "Interface\\AddOns\\Cryolysis\\sounds\\Pig02.mp3",
	};


--	CRYOLYSIS_NIGHTFALL_TEXT = {
--		["NoBoltSpell"] = "Du hast scheinbar keinen Schattenblitz Zauber.",
--		["Message"] = "<white>S<lightPurple1>c<lightPurple2>h<purple>a<darkPurple1>tt<darkPurple2>en<darkPurple1>tr<purple>a<lightPurple2>n<lightPurple1>c<white>e"
--	};


	CRYOLYSIS_MESSAGE = {
		["Error"] = {
			["RuneOfTeleportationNotPresent"] = "Du ben\195\182tigst eine Rune der Teleportation daf\195\188r!",
			["RuneOfPortals"] = "Du ben\195\182tigst eine Rune der Portale daf\195\188r!",
			["LightFeatherNotPresent"] = "Du ben\195\182tigst eine Leichte Feder daf\195\188r.",
			["ArcanePowderNotPresent"] = "Du ben\195\182tigst Arkanes Pulver daf\195\188r.",
			["NoRiding"] = "Du hast kein Reittier zum Reiten!",
			["NoFoodSpell"] = "Du beherrschst keinen Zauber f\195\188 Essen herbeizaubern.",
			["NoDrinkSpell"] = "Du beherrschst keinen Zauber f\195\188 Wasser herbeizaubern.",
			["NoManaStoneSpell"] = "Du beherrschst keinen Zauber f\195\188 Manaedelsteine",
			["NoEvocationSpell"] = "Du beherrschst keinen Zauber f\195\188 Hervorrufung",
			["FullMana"] = "Du kannst keinen Manaedelstein benutzen bei vollem Mana.",
			["BagAlreadySelect"] = "Fehler : Diese Tasche ist bereits ausgew\195\164hlt.",
			["WrongBag"] = "Fehler: Die Zahl muss zwischen 0 und 4 sein.",
			["BagIsNumber"] = "Fehler : Bitte gib eine Zahl an.",
			["NoHearthStone"] = "Fehler : Du hast keinen Ruhestein im Inventar.",
			["NoFood"] = "Fehler: Du hast kein herbeigezaubertes Essen mit dem h\195\182chsten Rang in deinem Inventar.",
			["NoDrink"] = "Fehler: Du hast kein herbeigezaubertes Wasser mit dem h\195\182chsten Rang in deinem Inventar.",
			["ManaStoneCooldown"] = "Fehler: Dein Manaedelstein hat derzeit noch Abklingzeit.",
			["NoSpell"] = "Fehler: You do not know that spell",
		},
		["Bag"] = {
			["FullPrefix"] = "Dein ",
			["FullSuffix"] = " ist voll!",
			["FullDestroySuffix"] = " ist voll; Dein n\195\164chstes Essen/Wasser wird zerst\195\182rt!",
			["SelectedPrefix"] = "Du hast deinen",
			["SelectedSuffix"] = " f\195\188r dein Essen und Wasser gew\195\164hlt."
		},
		["Interface"] = {
			["Welcome"] = "<white>/cryo f\195\188r das Einstellungsmen\195\188!",
			["TooltipOn"] = "Tooltips an" ,
			["TooltipOff"] = "Tooltips aus",
			["MessageOn"] = "Chat Nachrichten an",
			["MessageOff"] = "Chat Nachrichten aus",
			["MessagePosition"] = "<- Hier werden System Nachrichten von Cryolysis erscheinen ->",
			["DefaultConfig"] = "<lightYellow>Die Standard Einstellungen sind geladen.",
			["UserConfig"] = "<lightYellow>Die Einstellungen sind geladen."
		},
		["Help"] = {
			"/cryo recall -- Zentriere Cryolysis und alle Buttons in der Mitte des Bildschirms",
			"/cryo sm -- Ersetze Nachrichten mit einer kurzen und raidtauglichen Version",
			"/cryo decurse -- Benutze Fluch entfernen mit der Decursive-F\195\164higkeit",  
            "/cryo poly -- Benutze zuf\195\164lligen Polymorph-Spruch",  
        	"/cryo coldblock -- Aktiviere Eisblock oder K\195\164lteeinbruch" 
		},
		["EquipMessage"] = "Ausr\195\188ste ",
		["SwitchMessage"] = " an Stelle von ",
		["Information"] = {
			["PolyWarn"] = "Verwandlung wird ablaufen",
			["PolyBreak"] = "Verwandlung ist abgelaufen...",
			["Restock"] = "Gekauft",
		},
	};


	-- Gestion XML - Menu de configuration

	CRYOLYSIS_COLOR_TOOLTIP = {
		["Purple"] = "Lila",
		["Blue"] = "Blau",
		["Pink"] = "Pink",
		["Orange"] = "Orange",
		["Turquoise"] = "T\195\188rkis",
		["X"] = "X"
	};
	
	CRYOLYSIS_CONFIGURATION = {
		["Menu1"] = "Inventar Einstellungen",
		["Menu2"] = "Nachrichten Einstellungen",
		["Menu3"] = "Buttons Einstellungen",
		["Menu4"] = "Timer Einstellungen",
		["Menu5"] = "Graphische Einstellungen",
		["MainRotation"] = "Cryolysis Rotationseinstellungen",
		["ProvisionMenu"] = "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7y :",
		["ProvisionMenu2"] = "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		["ProvisionMove"] = "Platziere Essen und Wasser in die ausgew\195\164hlte Tasche.",
		["ProvisionDestroy"] = "Zerst\195\182re neues Brot + Wasser, wenn die Tasche voll ist.",
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFp|CFFFF50FFe|CFFFF99FFl|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7P|CFFFF00FFl|CFFFF50FFa|CFFFF99FFy|CFFFFC4FFe|CFFFF99FFr :",
		["TimerMenu"] = "|CFFB700B7G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFc|CFFFF00FFa|CFFB700B7l T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFrs :",
		["TimerColor"] = "Zeige wei\195\159en Text in Timern an Stelle von gelbem Text",
		["TimerDirection"] = "Neue Timer oberhalb der bestehenden Timer anzeigen",
		["TranseWarning"] = "Benachrichtige mich, wenn ich einen Trancezustand habe",
		["SpellTime"] = "Spruchdauer anzeigen",
		["AntiFearWarning"] = "Warnung, wenn Ziel immun ist gegen Fear",
		["GraphicalTimer"] = "Verwende graphische Timer an Stelle von Texttimern",	
		["TranceButtonView"] = "Zeige versteckte Buttons, um sie zu verschieben.",
		["ButtonLock"] = "Sperre die Buttons um die Cryolysis Sph\195\164re.",
		["MainLock"] = "Sperre die Cryolysis Sph\195\164re.",
		["BagSelect"] = "W\195\164hle die Tasche f\195\188r herbeigezaubertes Essen und Wasser",
		["BuffMenu"] = "Setze das Buffmen\195\188 nach links",
		["PortalMenu"] = "Setze das Portalmen\195\188 nach links",
		["STimerLeft"] = "Zeige die Timer auf der linken Seite des Buttons",
		["ShowCount"] = "Zeige die Anzahl der Items in Cryolysis",
		["CountType"] = "Anzeige auf Sph\195\164re",
		["Food"] = "Erst Essen ab:",
		["Sound"] = "Aktiviere Sounds",
		["ShowMessage"] = "Zufallsspr\195\188che",
		["ShowPortalMessage"] = "Aktiviere Zufallsspr\195\188che (Portal)",
		["ShowSteedMessage"] = "Aktiviere Zufallsspr\195\188che (Reittier)",
		["ShowPolyMessage"] = "Aktiviere Zufallsspr\195\188che (Verwandlung)",		
		["ChatType"] = "Cryolysis Nachrichten als System-Nachrichten anzeigen",
		["CryolysisSize"] = "Gr\195\182\195\159e der Cryolysis-Button",
		["StoneScale"] = "Size of other buttons",
		["PolymorphSize"] = "Gr\195\182\195\159e der Verwandlungs-Button",
		["TranseSize"] = "Gr\195\182\195\159e des Trance und Anti-Fear Buttons",
		["Skin"] = "Erst Trinken ab:",
		["ManaStoneOrder"] = "Nutze diesen Manaedelstein bevorzugt",
   		["Show"] = {
            ["Text"] = "Zeige Buttons:",
            ["Food"] = "Essen-Button",
            ["Drink"] = "Wasser-Button",
            ["Manastone"] = "Manaedelstein-Button",
            ["LeftSpell"] = "Linker Spruchbutton",
            ["Evocation"] = "Hervorrufung",
            ["RightSpell"] = "Rechter Spruchbutton",
        	["Steed"] = "Reittier",
            ["Buff"] = "Spruch Men\195\188",
            ["Portal"] = "Portal Men\195\188",
            ["Tooltips"] = "Zeige Tooltips",
            ["Spelltimer"] = "Spruchdauer-Button"
        },
        ["Text"] = {
        	["Text"] = "Auf Button:",
            ["Food"] = "Anzahl an Brot",
            ["Drink"] = "Anzahl an Wasser",
            ["Manastone"] = "Abklingzeit der Manaedelsteine",
            ["Evocation"] = "Abklingzeit von Hervorrufung",
            ["Powder"] = "Arkanes Pulver",
            ["Feather"] = "Leichte Federn",
            ["Rune"] = "Portal Runen",
    	},
		["QuickBuff"] = "\195\150ffne/Schlie\195\159e das Buff-Men\195\188 bei Mausber\195\188hrung",
 		["Count"] = {
            ["None"] = "Nichts",
            ["Provision"] = "Brot und Wasser",
            ["Provision2"] = "Wasser und Brot",
            ["Health"] = "Aktuelle HP",
            ["HealthPercent"] = "HP in Prozent",
            ["Mana"] = "Aktuelles Mana",
            ["ManaPercent"] = "Mana in Prozent",
            ["ManastoneCooldown"] = "Abklingzeit der Manaedelsteine",
            ["Evocation"] = "Abklingzeit von Hervorrufung",
        },
		["Circle"] = {
			["Text"] = "Zeige Folgendes als Ring an:",
			["None"] = "Nichts",
			["HP"] = "Gesundheit",
			["Mana"] = "Mana",
			["Manastone"] = "Manaedelstein Cooldown",
			["Evocation"] = "Hervorrufen Cooldown",

		},
		["Button"] = {
			["Text"] = "Hauptschalterfunktion",
			["Consume"] = "Esse und Trinke",
			["Evocation"] = "Benutze Hervorrufung",
			["Polymorph"] = "Zaubere Verwandlung",
			["Manastone"] = "Mana Gem",
		},
		["Restock"] = {
			["Restock"] = "F\195\188lle meine Reagenzien automatisch auf",
			["Confirm"] = "Best\195\164tige vor jedem Einkauf",
		},

		["Polymorph"] = {
			["Warn"] = "Warne mich, bevor die Verwandlung abl\195\164uft",
			["Break"] = "Sag mir, wenn Verwandlung abl\195\164uft",
		},
		["ButtonText"] = "Zeige die Mengenzahl auf den Buttons an",
		["Anchor"] = {
			["Text"] = "Men\195\188verankerungspunkt",
   			["Above"] = "\195\156ber",
   			["Center"] = "Mitte",
   			["Below"] = "Unter",
		},
		["SpellButton"] = {	
			["Armor"] = CRYOLYSIS_SPELL_TABLE[22].Name.."/"..CRYOLYSIS_SPELL_TABLE[24].Name, -- "Ice Armor / Mage Armor"
			["ArcaneInt"] = CRYOLYSIS_SPELL_TABLE[4].Name.."/"..CRYOLYSIS_SPELL_TABLE[2].Name, --"Arcane Int / Arcane Brilliance",
			["DampenMagic"] = CRYOLYSIS_SPELL_TABLE[13].Name.."/"..CRYOLYSIS_SPELL_TABLE[1].Name, -- "Dampen Magic / Amplify Magic",
			["IceBarrier"] = CRYOLYSIS_SPELL_TABLE[23].Name.."/"..CRYOLYSIS_SPELL_TABLE[25].Name, -- "Ice Barrier / Mana Shield",
			["FireWard"] = CRYOLYSIS_SPELL_TABLE[15].Name.."/"..CRYOLYSIS_SPELL_TABLE[20].Name, -- "Fire Ward / Frost Ward",
			["DetectMagic"] = CRYOLYSIS_SPELL_TABLE[50].Name, -- "Detect Magic"
			["RemoveCurse"] = CRYOLYSIS_SPELL_TABLE[33].Name, -- Remove Lesser curse
			["SlowFall"] = CRYOLYSIS_SPELL_TABLE[35].Name, -- Slow Fall
		},	
	};
end

