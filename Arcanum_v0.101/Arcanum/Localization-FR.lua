------------------------------------------------------------------------------------------------------
-- Arcanum

-- Addon pour Mage inspiré du célébre Necrosis
-- Gestion des buffs, des portails et Compteur de Composants

-- Remerciements aux auteurs de Necrosis

-- Auteur Lenny415

-- Serveur:
-- Uliss, Nausicaa, Solcarlus, Thémys on Medivh EU
------------------------------------------------------------------------------------------------------

function Arcanum_Localization_Dialog_Fr()
	function ArcanumLocalization()
		Arcanum_Localization_Speech_Fr();
	end
	-- Raccourcis claviers
	BINDING_HEADER_ARCANUM_BIND = "Arcanum";
	BINDING_NAME_ACTIVATE = "Activer/D\195\169sactiver Arcanum";
	BINDING_NAME_STEED = "Monture";
	BINDING_NAME_FROSTARMOR = "Armure de glace";
	BINDING_NAME_MAGEARMOR = "Armure du mage";
	BINDING_NAME_ARCANEINTELLECT = "Intelligence des arcanes";
	BINDING_NAME_ARCANEBRILLIANCE = "Illumination des arcanes";
	BINDING_NAME_AMPLIFYMAGIC = "Amplification de la magie";
	BINDING_NAME_DAMPENMAGIC = "Att\195\169nuation de la magie";
	BINDING_NAME_CONJUREFOOD = "Invocation de nourriture";
	BINDING_NAME_USEFOODWATER = "Manger & boire";
	BINDING_NAME_USEFOOD = "Manger";
	BINDING_NAME_CONJUREWATER = "Invocation d'eau";
	BINDING_NAME_USEWATER = "Boire";
	BINDING_NAME_CONJUREMANAGEM = "Invocation d'une gemme de mana";
	BINDING_NAME_USEMANAGEM = "Utilisation d'une gemme de mana";
	BINDING_NAME_EVOCATION = "Evocation";
	BINDING_NAME_TELEPORT1 = "T\195\169l\195\169portation 1";
	BINDING_NAME_TELEPORT2 = "T\195\169l\195\169portation 2";
	BINDING_NAME_TELEPORT3 = "T\195\169l\195\169portation 3";
	BINDING_NAME_PORTAL1 = "Portail 1";
	BINDING_NAME_PORTAL2 = "Portail 2";
	BINDING_NAME_PORTAL3 = "Portail 3";
	
	ARCANUM_CONFIGURATION = {
		["Menu1"] = "Messages",
		["MessageMenu1"] = "Joueur :",
		["Tooltip0"] = "Aucun Tooltip",
		["Tooltip1"] = "Tooltips partiels",
		["Tooltip2"] = "Tooltips complets",
		["ChatType"] = "Les messages = des messages syst\195\168mes",
		["PortalMessage"] = "Afficher les messages lors de l'invocation d'un portail",
        ["ArcanumButtonDisplay"] = "Affichage dans la sphère :",
        ["InsideDisplay"] = "Afficher dans la sphère :",
        ["DisplayHearthStone"] = "Pierre de foyer",
        ["DisplayManaGem"] = "Gemme de mana",
        ["DisplayEvocation"] = "Evocation",
        ["DisplayIceBlock"] = "Bloc de glace",
        ["DisplayColdSnap"] = "Morsure de glace",
        ["DisplayIntell"] = "Intell.",
        ["DisplayArmor"] = "Armure",
        ["DisplayBandage"] = "Bandage",
        ["HealthColor"] = "Couleur de la barre de vie",
        ["ManaColor"] = "Couleur de la barre de mana",
        ["ButtonColor"] = "Couleur des boutons sélectionnés",
		
		["Menu2"] = "Divers",
		["LevelBuff"] = "Buffer la cible en fonction de son niveau",
        ["EvocationLimit"] = "Limite à partir de laquelle l'\195\169vocation peut être lanc\195\169",
        ["ConsumeLeftFood"] = "Consommer eau/pain dans les sacs les plus à gauche",
        ["ConsumeRightFood"] = "Consommer eau/pain dans les sacs les plus à droite",
        ["RandMount"] = "Invoquer une monture aléatoire",
		["DeleteFood"] = "Supprimer la nourriture invoqu\195\169e",
		["DeleteWater"] = "Supprimer l'eau invoqu\195\169e",
		["DeleteManaGem"] = "Supprimer les gemmes de mana",
		
		["Menu3"] = "Achat auto des composants",
		["ReagentSort"] = "Rangement des composants dans un même sac",
		["ReagentBag"] = "Sac des composants",
		["ReagentBuy"] = "Achat auto des composants",
		["Reagent"] = "Quantit\195\169 Maximum des composants dans le sac:",
		["Powder"] = "Poudre des arcanes",
		["Teleport"] = "Rune de t\195\169l\195\169portation",
		["Portal"] = "Rune des portails",
		
		["Menu4"] = "Graphique",
		["Toggle"] = "Afficher Arcanum",		
        ["InterfaceVersion"] = "Arcanum avec menus",
		["InterfaceVersion2"] = "Arcanum sans menus",
		["Lock"] = "Verrouiller Arcanum",
		["IconsLock"] = "Verouiller les boutons d'Arcanum sur la sph\195\169re",
		["MenuPosition"] = "Orientation des menus:",
		["BuffMenu"] = "Buffs: haut/bas si coch\195\169, droite/gauche sinon",
		["ArmorMenu"] = "Armures: haut/bas si coch\195\169, droite/gauche sinon",
		["MagicMenu"] = "Magies: haut/bas si coch\195\169, droite/gauche sinon",
		["PortalMenu"] = "Portails: haut/bas si coch\195\169, droite/gauche sinon",
        ["MountMenu"] = "Montures: haut/bas si coch\195\169, droite/gauche sinon",
		["ArcanumRotation"] = "Rotation d'Arcanum",
		["ArcanumSize"] = "Taille d'Arcanum",
		
		["Menu5"] = "Boutons",
        ["Button"] = "Afficher le bouton des :",
        ["Order"] = "Changer l'order des boutons:",
		["BuffButton"] = "buffs",
		["ArmorButton"] = "armures",
		["MagicButton"] = "magies",
		["PortalButton"] = "portails",
		["MountButton"] = "montures",
		["FoodButton"] = "nourritures",
		["WaterButton"] = "boissons",
		["ManaGemButton"] = "gemmes de mana",
        ["MinimapIcon"] = "Afficher l'icone de la minimap",
        ["ArcanumMinimapIconPos"] = "Position de l'icone minimap:",
	};
	
    ARCANUM_CLICK = {
        "Evocation",
        "Boire & Manger",
        "Changer de mode solo/groupe",
        "Panneau de configuration",
        "Gemmes de mana",
        "Bloc de glace",
        "Echanger",
        "Pierre de foyer",
    };
    
    ARCANUM_INSIDE_DISPLAY = {
        "Vie",
        "Mana",
        "Rien",
    };
	-- Traduction
	ARCANUM_TRANSLATION = {
		["Mounting"] = "Invocation d'un";
        ["Hearth"] = "Pierre de foyer";
		["Cooldown"] = "Temps";
		["Rank"] = "Rang";
	};

	ARCANUM_TOOLTIP_DATA = {
	["LastSpell"] = "Clic gauche pour lancer";
        ["SpellTimer"] = {
			Label = "Dur\195\169e des sorts",
			Text = "Sorts actifs sur la cible",
			Right = "<white>Clic Droit pour pierre de foyer vers ",
        };
	};

	-- Message
	ARCANUM_MESSAGE = {
	  	["Interface"] = {
	    	["InitOn"] = "<white>activ\195\169. /arcanum ou /arca pour afficher la fen\195\170tre de configuration",
	    	["InitOff"] = "<white>d\195\169sactiv\195\169.",
	  		["DefaultConfig"] = "<lightYellow>Configuration par defaut charg\195\169e.",
			["UserConfig"] = "<lightYellow>Configuration charg\195\169e"
		},
	  	["Tooltip"] = {
	    	["LeftClick"] = "Clic Gauche: ";
			["MiddleClick"] = "Clic Milieu: ";
	    	["RightClick"] = "Clic Droit: ";
	 		["Cooldown"] = "Pierre de foyer disponible dans ";
            ["Minimap"] = "Panneau de configuration";
	  	},
		["Error"] = {
	  		["NoHearthstone"] = "Vous n'avez pas de pierre de foyer dans votre inventaire",
      		["NoMount"] = "Vous n'avez pas de monture dans votre inventaire",
		},
		["Autobuy"] = "Achat de ",
	};
end

function Arcanum_Localization_Speech_Fr()
	ARCANUM_PORTAL_MESSAGES = {
		[1] = {
			"Par la toute puissance des \195\169l\195\169ments! Reechani! Sentrosi! Vasi! Je vous invoque, ouvrez-moi une faille vers <city>.",
		},
		[2] = {
			"La compagnie <me> Airline vous souhaite un agr\195\169able voyage vers <city>" 
		},
		[3] = {
			"Bon, c'\195\169tait quoi encore la formule pour ce portail... 'Razh masha en Al'doorh belis...' Zut, ça c'est pour <1>!",
			"Alors... ah oui! 'Keal ni Sora el'thiba...' Mais non, c'est pour <2> celle-ci!",
			"Allez, j'incante au hasard, mais je crois bien que ça c'est pour <city>!",
		},
	};
end

if ( GetLocale() == "frFR" ) then
	-- Table des sorts du mage
	ARCANUM_SPELL_TABLE = {
		["ID"] = {},
		["Rank"] = {},
		["Name"] = {
			"Armure de givre",									--1
			"Armure de glace",                      			--2
			"Armure du mage",                   				--3
			"Intelligence des arcanes",			                --4
			"Illumination des arcanes",	                        --5
            "Att\195\169nuation de la magie",                   --6
			"Amplification de la magie",                        --7
			"Invocation de nourriture",                       	--8
			"Invocation d'eau",                        			--9
			"Invocation d'une agate de mana",       			--10
			"Invocation d'une jade de mana",                    --11		
			"Invocation d'une citrine de mana",                 --12
			"Invocation d'un rubis de mana",				    --13
			"T\195\169l\195\169portation : Darnassus",			--14
			"T\195\169l\195\169portation : Ironforge",			--15
			"T\195\169l\195\169portation : Stormwind",          --16
			"T\195\169l\195\169portation : Orgrimmar",			--17
			"T\195\169l\195\169portation : Thunder Bluff",		--18
			"T\195\169l\195\169portation : Undercity",          --19
			"Portail : Darnassus",								--20
			"Portail : Ironforge",					 			--21
			"Portail : Stormwind",								--22
			"Portail : Orgrimmar",								--23
			"Portail : Thunder Bluff",					 		--24
			"Portail : Undercity",            					--25
			"Evocation",                                        --26
            "Gardien de feu",                                   --27
            "Gardien de glace",                                 --28
            "M\195\169tamorphose",                              --29
            "M\195\169tamorphose : cochon",                     --30
            "M\195\169tamorphose : tortue",                     --31
            "Bloc de glace",                                    --32
            "Morsure de glace",                                 --33
            "Premiers soins",                                   --34
			},
		["Mana"] = {},
        ["Texture"] = {},
	}; 
    
	ARCANUM_MANAGEM = {"Agate de mana", "Jade de mana", "Citrine de mana", "Rubis de mana"};
	
	ARCANUM_FOOD = {"Muffin invoqu\195\169", "Pain invoqu\195\169", "Pain de seigle invoqu\195\169", "Pain noir invoqu\195\169",
	"Pain de route invoqu\195\169", "Pain au lait invoqu\195\169", "Roulés à la cannelle invoqu\195\169s"};
	
	ARCANUM_WATER = {"Eau invoqu\195\169e", "Eau fraîche invoqu\195\169e", "Eau purifiée invoqu\195\169e",
	"Eau de source invoqu\195\169e", "Eau minérale invoqu\195\169e", "Eau pétillante invoqu\195\169e", "Eau cristalline invoqu\195\169e"};
    
    ARCANUM_BANDAGE = "Un bandage a été appliqué récemment";
    
	-- Table des items du Mage
	ARCANUM_ITEM = {
		["ArcanePowder"] = "Poudre des arcanes",
		["RuneOfTeleportation"] = "Rune de t\195\169l\195\169portation",
		["RuneOfPortals"] = "Rune des portails",
		["LightFeathers"] = "Plume l\195\169g\195\168re",
		["Hearthstone"] = "Pierre de foyer",
		["QuirajiMount"] = "Cristal de r\195\169sonance qiraji",
	};
    
	-- Monture	
	MOUNT = {{"Cor du loup brun rapide", "Cor du loup de guerre noir", "Corne du loup brun", "Corne du loup des bois", "Corne du loup rouge"},
	{"R\195\170nes de sabre-de-nuit ray\195\169", "R\195\170nes de Tigre de guerre noir"},
	{"Tigre zulien rapide"},
	{"Grand kodo blanc", "Kodo gris", "Grand kodo gris"},
	{"Kodo vert", "Kodo bleu"},
	{"Kodo brun", "Kodo de guerre noir", "Grand kodo brun"},
	{"Trotteur de bataille noir", "M\195\169canotrotteur bleu clair Mod A", "M\195\169canotrotteur blanc Mod A", "M\195\169canotrotteur blanc rapide", "M\195\169canotrotteur bleu", "M\195\169canotrotteur brut", "M\195\169canotrotteur jaune rapide", "M\195\169canotrotteur rouge", "M\195\169canotrotteur vert", "M\195\169canotrotteur vert rapide"},
	{"Destrier de bataille stormpike", "B\195\169lier de givre", "B\195\169lier noir", "B\195\169lier blanc", "B\195\169lier blanc rapide", "B\195\169lier brun", "B\195\169lier brun rapide", "B\195\169lier gris", "B\195\169lier gris rapide", "B\195\169lier de guerre noir"},
	{"Bride de palefroi de guerre noir"},
	{"Rênes de sabre-de-givre de Berceau-de-l'Hiver"},
	{"Raptor bleu rapide", "Raptor orange rapide", "Raptor vert olive rapide", "Sifflet de Raptor ivoire", "Sifflet de Raptor rouge tachet\195\169", "Sifflet de raptor turquoise", "Sifflet de raptor violet", "Sifflet de raptor \195\169meraude", "Sifflet du raptor de guerre noir", "Raptor razzashi rapide"},
	{"Bride d'\195\169talon blanc", "Bride d'\195\169talon noir", "Bride de Palomino", "Bride de pinto", "Bride de jument alezane", "Bride de cheval bai", "Palefroi bai rapide", "Palefroi blanc rapide", "Palomino rapide"},
	{"R\195\170nes de destrier de la mort", "Cheval de guerre squelette rouge", "Cheval de guerre squelette vert", "Cheval de guerre squelette violet", "Cheval squelette bai", "Cheval squelette bleu", "Cheval squelette rouge"},
	{"Cor du loup redoutable", "Cor du loup des bois rapide", "Cor du loup gris rapide", "Corne du loup arctique", "Corne du loup sauvage"},
	{"R\195\170nes de sabre-de-givre ray\195\169", "R\195\170nes de sabre-de-givre mouchet\195\169", "R\195\170nes de sabre-de-givre rapide", "R\195\170nes de sabre-de-brume rapide", "R\195\170nes de sabre-temp\195\170te rapide"},
	{"Cor du hurleur Frostwolf"},
	};
    
    MOUNT_SPEED = "Augmente la vitesse de (%d+)%%.";
		
	MOUNT_PREFIX = {"R\195\170nes de ", "Sifflet du ", "Corne du ", "Cor du ", "Bride de ", "Bride d'"};
    
    QIRAJ_MOUNT = {"Cristal de r\195\169sonance qiraji jaune",
    "Cristal de r\195\169sonance qiraji rouge",
	"Cristal de r\195\169sonance qiraji vert",
	"Cristal de r\195\169sonance qiraji bleu",
	"Cristal de r\195\169sonance qiraji noir",
	};
end