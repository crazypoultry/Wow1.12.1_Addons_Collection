------------------------------------------------------------------------------------------------------
-- Arcanum

-- Addon pour Mage inspiré du célébre Necrosis
-- Gestion des buffs, des portails et Compteur de Composants

-- Remerciements aux auteurs de Necrosis

-- Auteur Lenny415

-- Serveur:
-- Uliss, Nausicaa, Solcarlus, Thémys on Medivh EU
------------------------------------------------------------------------------------------------------

function Arcanum_Localization_Dialog_De()
	function ArcanumLocalization()
		Arcanum_Localization_Speech_De();
	end
	-- Raccourcis claviers
	BINDING_HEADER_ARCANUM_BIND = "Arcanum";   
	BINDING_NAME_STEED = "Reittier";
	BINDING_NAME_FROSTARMOR = "Eisr\195\188stung";
	BINDING_NAME_MAGEARMOR = "Magische R\195\188stung";
	BINDING_NAME_ARCANEINTELLECT = "Arkane Intelligenz";
	BINDING_NAME_ARCANEBRILLIANCE = "Arkane Brillanz";
	BINDING_NAME_AMPLIFYMAGIC = "Magie verst\195\164rken";
	BINDING_NAME_DAMPENMAGIC = "Magie d\195\164\mpfen";
	BINDING_NAME_CONJUREFOOD = "Essen herbeizaubern";
	BINDING_NAME_USEFOODWATER = "Essen & Trinken";
	BINDING_NAME_USEFOOD = "Essen";
	BINDING_NAME_CONJUREWATER = "Wasser herbeizaubern";
	BINDING_NAME_USEWATER = "Trinken";
	BINDING_NAME_CONJUREMANAGEM = "Mana Edelstein herbeizaubern";
	BINDING_NAME_USEMANAGEM = "Mana Edelstein benutzen";
	BINDING_NAME_EVOCATION = "Hervorufung";
	BINDING_NAME_TELEPORT1 = "Teleportieren 1";
	BINDING_NAME_TELEPORT2 = "Teleportieren 2";
	BINDING_NAME_TELEPORT3 = "Teleportieren 3";
	BINDING_NAME_PORTAL1 = "Portal 1";
	BINDING_NAME_PORTAL2 = "Portal 2";
	BINDING_NAME_PORTAL3 = "Portal 3";
	
	ARCANUM_CONFIGURATION = {
		["Menu1"] = "Nachrichten Einstellungen",
		["MessageMenu1"] = "Player :",
		["Tooltip0"] = "Kein Tooltip",
		["Tooltip1"] = "Unvollst\195\164ndige Tooltips",
		["Tooltip2"] = "Vollst\195\164ndige Tooltips",
		["ChatType"] = "Nachrichten = System Nachrichten",
		["PortalMessage"] = "Nachrichten anzeigen, wenn du ein Portal zauberst",
        ["ArcanumButtonDisplay"] = "Display inside the sphere :",
        ["InsideDisplay"] = "Display inside the sphere:",
        ["DisplayHearthStone"] = "HearthStone",
        ["DisplayManaGem"] = "ManaGem",
        ["DisplayEvocation"] = "Evocation",
        ["DisplayIceBlock"] = "IceBlock",
        ["DisplayColdSnap"] = "ColdSnap",
        ["DisplayIntell"] = "Intell.",
        ["DisplayArmor"] = "Armor",
        ["DisplayBandage"] = "Bandage",
        ["HealthColor"] = "Health bar color",
        ["ManaColor"] = "Mana bar color",
        ["ButtonColor"] = "Mouseover buttons color",
		
		["Menu2"] = "Einstellungen f\195\188r ",
		["LevelBuff"] = "Ziel abh\195\164ngig von seinem Level Buffen",
		["EvocationLimit"] = "Mana percentage Evocation can be casted",
        ["ConsumeLeftFood"] = "Consume Water/Food starting by the left bag",
        ["ConsumeRightFood"] = "Consume Water/Food starting by the right bag",
        ["RandMount"] = "Summon a mount randomly",
        ["DeleteFood"] = "Herbeigezaubertes Essen entfernen",
		["DeleteWater"] = "Herbeigezaubertes Wasser entfernen",
		["DeleteManaGem"] = "Manasteine löschen",
		
		["Menu3"] = "Einstellungen f\195\188r den automatischen Einkauf von Reagenzen",
		["ReagentSort"] = "Reagenzen in eine Tasche einsortieren",
		["ReagentBag"] = "Reagenzen-Tasche",
		["ReagentBuy"] = "Automatischer Einkauf",
		["Reagent"] = "Maximale Reagenzenanzahl in den Taschen:",
		["Powder"] = "Arkanes Pulver",
		["Teleport"] = "Rune der Teleportation",
		["Portal"] = "Rune der Portale",
		
		["Menu4"] = "Graphische Einstellungen",
		["Toggle"] = "Arcanum aktivieren",
        ["InterfaceVersion"] = "Arcanum mit Men\195\188s",
		["InterfaceVersion2"] = "Arcanum ohne Men\195\188s",
		["Lock"] = "Arcanum fixieren",
		["IconsLock"] = "Arcanum Symbole fixieren",
		["MenuPosition"] = "Orientung der Men\195\188s:",
		["BuffMenu"] = "Buffs: horizontal wenn aktiviert, sonst vertikal",
		["ArmorMenu"] = "R\195\188stungen: horizontal wenn aktiviert, sonst vertikal",
		["MagicMenu"] = "Magie: horizontal wenn aktiviert, sonst vertikal",
		["PortalMenu"] = "Portale: horizontal wenn aktiviert, sonst vertikal",
        ["MountMenu"] = "Mounts: horizontal wenn aktiviert, sonst vertikal",
		["ArcanumRotation"] = "Arcanum drehen",
		["ArcanumSize"] = "Gr\195\182\195\159e von Arcanum",
		
		["Menu5"] = "Knopfeinstellungen",
        ["Button"] = "Zeige den:",
        ["Order"] = "Change buttons order:",
		["BuffButton"] = "Buffknopf",
		["ArmorButton"] = "R\195\188stungsknopf",
		["MagicButton"] = "Magieknopf",
		["PortalButton"] = "Portalknopf",
		["MountButton"] = "Reittierknopf",
		["FoodButton"] = "Nahrungsknopf",
		["WaterButton"] = "Wasserknopf",
		["ManaGemButton"] = "Manasteinknopf",
        ["MinimapIcon"] = "Show minimap icon",
        ["ArcanumMinimapIconPos"] = "Position des Minikartensymbols:",
	};
	
    ARCANUM_CLICK = {
        [1] = "Hervorufung";
        [2] = "Essen & Trinken";
        [3] = "Wechsel zwischen Gruppen/Solomodus";
        [4] = "Konfigurationsfenster";
        [5] = "Manasteine";
        [6] = "Ice block";
        [7] = "Trade";
        [8] = "Ruhestein";
    };
    
    ARCANUM_INSIDE_DISPLAY = {
        "Health",
        "Mana",
        "Nothing",
    };
    
	-- Traduction
	ARCANUM_TRANSLATION = {
		["Mounting"] = "Beschw\195\182re",
        ["Hearth"] = "Ruhestein";
		["Cooldown"] = "Abklingzeit",
		["Rank"] = "Rang",
	};
	
	ARCANUM_TOOLTIP_DATA = {
		["LastSpell"] = "Links Maustaste:",
        ["SpellTimer"] = {
        	Label = "Spruchdauer",
			Text = "Aktive Spr\195\188che auf dem Ziel\n",
			Right = "<white>Rechtsklick f\195\188r Ruhestein nach "
        };
	};
	
	-- Message
	ARCANUM_MESSAGE = {
	  	["Interface"] = {
	    	["InitOn"] = "<white>aktiviert. /arcanum oder /arca um das Konfigurationsfenster zu \195\182ffnen",
	    	["InitOff"] = "<white>deactiviert. /arca",
			["DefaultConfig"] = "<lightYellow>Standard-Einstellungen geladen.",
			["UserConfig"] = "<lightYellow>Einstellungen geladen.",
		},
	  	["Tooltip"] = {
	    	["LeftClick"] = "Linksklick: ",
			["MiddleClick"] = "Mittleklick: ",
	    	["RightClick"] = "Rechtsklick: ",
	 		["Cooldown"] = "Abklingzeit Ruhestein: ",
            ["Minimap"] = "Konfigurationsfenster",
	  	},
		["Error"] = {
	  		["NoHearthstone"] = "Es befindet sich kein Ruhestein im Inventar.",
      		["NoMount"] = "Es befindet sich kein Reittier im Inventar.",
		},
		["Autobuy"] = "Kaufe ",
	};
end

function Arcanum_Localization_Speech_De()
	ARCANUM_PORTAL_MESSAGES = {
		[1] = {
			"Die <me> Fluglinie w\195\188nscht Ihnen eine angenehme Reise nach <city>" 
		},
	};
end

if ( GetLocale() == "deDE" ) then
	-- Table des sorts du mage
	ARCANUM_SPELL_TABLE = {
		["ID"] = {},
		["Rank"] = {},
		["Name"] = {
			"Frostr195188stung",							--1
			"Eisr\195\188stung",                      		--2
			"Magische R\195\188stung",                   	--3
			"Arkane Intelligenz",			                --4
			"Arkane Brillanz",	                        	--5
            "Magie d\195\164\mpfen",                   		--6
			"Magie verst\195\164rken",                      --7
			"Essen herbeizaubern",                       	--8
			"Wasser herbeizaubern",                        	--9
			"Manaachat herbeizaubern",       				--10
			"Manajadestein herbeizaubern",                 	--11		
			"Manacitrin herbeizaubern",                 	--12
			"Manarubin herbeizaubern",				    	--13
			"Teleportieren: Darnassus",						--14
			"Teleportieren: Ironforge",						--15
			"Teleportieren: Stormwind",         			--16
			"Teleportieren: Orgrimmar",						--17
			"Teleportieren: Thunder Bluff",					--18
			"Teleportieren: Undercity",         			--19
			"Portal: Darnassus",							--20
			"Portal: Ironforge",					 		--21
			"Portal: Stormwind",							--22
			"Portal: Orgrimmar",							--23
			"Portal: Thunder Bluff",						--24
			"Portal: Undercity", 							--25
			"Hervorrufung",            						--26
            "Fire Ward",                                        --27
            "Frost Ward",                                       --28
            "Polymorph",                                        --29
            "Polymorph : Pig",                                  --30
            "Polymorph : Turtle",                               --31
            "Ice Block",                                        --32
            "Cold Snap",                                        --33
            "Premiers soins",                                   --34
			},
		["Mana"] = {},
        ["Texture"] = {},
	};
    
	ARCANUM_MANAGEM = {"Manaachat", "Manajadestein", "Manacitrin", "Manarubin"}; 
	
	ARCANUM_FOOD = {"Herbeigezauberter Muffin", "Herbeigezaubertes Brot", "Herbeigezaubertes Roggenbrot", "Herbeigezauberter Pumpernickel", "Herbeigezauberter Sauerteig", "Herbeigezaubertes Milchbr\195\182tchen", "Herbeigezauberte Zimtschnecke"};

	ARCANUM_WATER = {"Herbeigezaubertes Wasser", "Herbeigezaubertes frisches Wasser", "Herbeigezaubertes gel\195\164utertes Wasser", "Herbeigezaubertes Quellwasser", "Herbeigezaubertes Mineralwasser", "Herbeigezaubertes Sprudelwasser", "Herbeigezaubertes Kristallwasser"};

    ARCANUM_BANDAGE = "Un bandage a été appliqué récemment";
    
	-- Table des items du Mage
	ARCANUM_ITEM = {
		["ArcanePowder"] = "Arkanes Pulver",
		["RuneOfTeleportation"] = "Rune der Teleportation",
		["RuneOfPortals"] = "Rune der Portale",
		["LightFeathers"] = "Leichte Feder",
		["Hearthstone"] = "Ruhestein",
		["QuirajiMount"] = "Qirajiresonanzkristall",
	};

	-- Monture	
	MOUNT = {
		{"Horn des roten Wolfs", "Horn des Waldwolfs", "Horn des braunen Wolfss", "Horn des schnellen braunen Wolfs", "Horn des schwarzen Kriegswolfs"},
		{"Z\195\188gel des gestreiften Nachts\195\164blers", "Z\195\188gel des schwarzen Kriegstigers"},
		{"Schneller zulianischer Tiger"},
		{"Großer weißer Kodo", "Grauer Kodo", "Großer grauer Kodo"},
		{"Grüner Kodo", "Graublauer Kodo"},
		{"Brauner Kodo", "Schwarzer Kriegskodo", "Großer brauner Kodo"},
		{"Schwarzer Schlachtenschreiter", "Eisblauer Roboschreiter Mod. A", "Weißer Roboschreiter Mod. A", "Schneller weißer Roboschreiter", "Blauer Roboschreiter", "Unlackierter Roboschreiter", "Schneller gelber Roboschreiter", "Roter Roboschreiter", "Grüner Roboschreiter", "Schneller grüner Roboschreiter"},
		{"Streitwidder der Stormpike", "Frostwidder", "Schwarzer Widder", "Weißer Widder", "Schneller weißer Widder", "Brauner Widder", "Schneller brauner Widder", "Grauer Widder", "Schneller grauer Widder", "Schwarzer Kriegswidder"},
		{"Schwarzes Schlachtrosszaumzeug"},
		{"Z\195\188gel des Winterspringfrostsäblers"},
		{"Pfeife des schwarzen Kriegsraptors", "Pfeife des smaragdfarbenen Raptors", "Pfeife des elfenbeinfarbenen Raptors", "Pfeife des scheckigen roten Raptors", "Pfeife des türkisfarbenen Raptors", "Pfeife des violetten Raptors", "Schneller olivfarbener Raptor", "Schneller orangener Raptor", "Schneller blauer Raptor", "Schneller Razzashiraptor"},
		{"Rappenzaumzeug", "Braunes Pferd", "Kastanienbraune Stute", "Palominozaumzeug", "Schecke", "Schimmelzaumzeug", "Schnelles Palomino", "Schneller Brauner", "Schnelles weißes Ross"},
		{"Z\195\188gel des Todesstreitrosses", "Grünes Skelettschlachtross", "Purpurnes Skelettschlachtross", "Rotes Skelettschlachtross", "Braunes Skelettpferd", "Blaues Skelettpferd", "Rotes Skelettpferd"},
		{"Horn des Terrorwolfs", "Horn des schnellen Waldwolfs", "Horn des schnellen Grauwolfs", "Horn des arktischen Wolfs"},
		{"Z\195\188gel des Frosts\195\164blers", "Z\195\188gel des Nachts\195\164blers", "Z\195\188gel des gefleckten Frosts\195\164blers", "Z\195\188gel des gestreiften Frosts\195\164blers", "Z\195\188gel des schnellen Frosts\195\164bler", "Z\195\188gel des schnellen Schattens\195\164blers", "Z\195\188gel des schnellen Sturms\195\164blers"},
		{"Horn des Frostwolfheulers"},
	};
    
    MOUNT_SPEED = "Erh\195\182ht Tempo um (%d+)%%.";
    
	MOUNT_PREFIX = {"Z\195\188gel des ", "Pfeife des ", "Horn des "};
		
	QIRAJ_MOUNT = {
		"Gelber Qirajiresonanzkristall",
	  	"Roter Qirajiresonanzkristall",
	  	"Grüner Qirajiresonanzkristall",
	  	"Blauer Qirajiresonanzkristall",
		"Schwarzer Qirajiresonanzkristall",
	};

end