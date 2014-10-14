------------------------------------------------------------------------------------------------------
-- Serenity
--
-- Based on Necrosis LdC by Lomig and Nyx (http://necrosis.larmes-cenarius.net)
-- Original Necrosis Idea : Infernal (http://www.revolvus.com/games/interface/necrosis/)
-- Serenity Maintainer : Kaeldra of Aegwynn
--
-- Contact : darklyte@gmail.com
-- Send me in-game mail! Yersinia on Aegwynn, Horde side.
-- Guild:
-- Version Date: 29.08.2006
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- FRENCH VERSION TEXTS --
------------------------------------------------

function Serenity_Localization_Dialog_Fr()
	
	function SerenityLocalization()
		Serenity_Localization_Speech_Fr();
	end
	
	SERENITY_COOLDOWN = {
		["Potion"] = "Temps de recharge de la Potion"
	};
	
	SerenityTooltipData = {
		["Main"] = {
			["Label"]			= "|c00FFFFFFSerenity|r",
			["HealingPotion"]	= "Potions de soins: ",
			["ManaPotion"]		= "Potions de mana: ",
			["Drink"]			= "Boissons: ",
			["HolyCandle"]		= "Bougies sanctifi\195\169e: ",
			["SacredCandle"]	= "Bougies sacr\195\169e: ",
			["LightFeather"]	= "Plumes l\195\169g\195\168re: ",
		},
		["Alt"] = {
			Left	= "Clic Droit pour ",
			Right	= "",
		},
		["Potion"] = {
			Label	= "|c00FFFFFFPotion|r",
			Text	= {"Restaure ", " sur ", " to "}
		},
		["SpellTimer"] = {
			Label	= "|c00FFFFFFDur\195\169e des sorts|r",
			Text	= "Temps de recharge et sorts actifs sur la cible",
			Right	= "Clic droit pour utiliser la pierre de foyer vers "
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
			Label = "|c00FFFFFFMonture: "
		},
		["Buff"] = {
			Label = "|c00FFFFFFMenu des Buff|r\nClic du milieu pour maintenir le menu ouvert"
		},
		["Spell"] = {
			Label = "|c00FFFFFFMenu des sorts|r\nClic du milieu pour maintenir le menu ouvert"
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
			Label = "|c00FFFFFFDissiper la Magie|r"
		},
		["LastSpell"] = {
			Left	= "Clic Droit pour relancer ",
			Right	= "",
		},
		["Drink"] = {
			Label = "|c00FFFFFFBoisson|r",
		},
	};
	
	SERENITY_SOUND = {
		["ShackleWarn"]		= "Interface\\AddOns\\Serenity\\sounds\\Shackle01.wav",
		["ShackleBreak"]	= "Interface\\AddOns\\Serenity\\sounds\\Shackle02.wav",
		["Shackle"]			= "Interface\\AddOns\\Serenity\\sounds\\Shackle03.wav",
	};
	
	-- SERENITY_NIGHTFALL_TEXT = {
	-- ["NoBoltSpell"]	= "Vous semblez avoir aucun sort Shadow Bolt.",
	-- ["Message"]		= "Shadow Trance"
	-- };
	
	SERENITY_MESSAGE = {
		["Error"] = {
			["HolyCandleNotPresent"]	= "Composant absent: Bougie sanctifi\195\169e.",
			["SacredCandle"]			= "Composant absent: Bougie sacr\195\169e.",
			["LightFeatherNotPresent"]	= "Composant absent: Plume l\195\169g\195\168re.",
			["NoRiding"]				= "Vous n'avez aucune monture \195\160 monter!",
			["FullMana"]				= "Vous ne pouvez pas utiliser cela, vos PM sont au maximum.",
			["FullHealth"]				= "Vous ne pouvez pas utiliser cela, vos PV sont au maximum.",
			["NoHearthStone"]			= "Erreur: Vous n'avez pas de pierre de foyer dans v\195\180tre inventaire.",
			["NoPotion"]				= "Erreur: Vous n'avez pas de potion dans v\195\180tre inventaire.",
			["NoDrink"]					= "Erreur: Vous n'avez pas de boisson dans v\195\180tre inventaire.",
			["PotionCooldown"]			= "Erreur: Potion actuellement en temps de recharge!",
			["NoSpell"]					= "Erreur: Vous ne connaissez pas ce sort.",
		},
		["Interface"] = {
			["Welcome"]			= "/serenity ou /seren pour acc\195\169der au menu.",
			["TooltipOn"]		= "Bulles d'aide activ\195\169es" ,
			["TooltipOff"]		= "Bulles d'aide d\195\169sactiv\195\169es",
			["MessageOn"]		= "Messages de chat activ\195\169es",
			["MessageOff"]		= "Messages de chat d\195\169sactiv\195\169es",
			["MessagePosition"]	= "<- Les messages syst\195\168mes de Serenity apparaitront ici ->",
			["DefaultConfig"]	= "Configuration par d\195\169faut charg\195\169.",
			["UserConfig"]		= "Configuration charg\195\169."
		},
		["Personality"] = {
			["Greeting"]	= "Salut, "..UnitName("player")..", heureux de vous rencontrer.",
			["Welcome"]		= "Bien le bonjour, ".. UnitName("player") ..".",
			["Signal"]		= "Vous ne pouvez pas d\195\169sactiver le signal.",
		},
		["Help"] = {
			"/serenity recall -- Centre Serenity et tous les boutons au milieu de l'\195\169cran",
			"/serenity sm -- Remplace les messages par une version courte pour les raid.",
			"/serenity reset -- Restaure et recharge par d\195\169faut la configurations de serenity.",
			"/serenity toggle -- Cache/Montre la sph\195\168re principale de serenity.",
			"Changer le sort des boutons en ajustant les glisseurs dans les options des boutons.",
		},
		["Information"] = {
			["ShackleWarn"]		= "L'entrave est sur le point de casser",
			["ShackleBreak"]	= "V\195\180tre entrave s'est cass\195\169e...",
			["Restocked"]		= "Achat de ",
			["Restock"]			= "Restocker les bougies ?",
			["Yes"]				= "Oui",
			["No"]				= "Non",
		},
	};
	
	
	-- Gestion XML - Menu de configuration
	
	SERENITY_COLOR_TOOLTIP = {
		["Purple"]		= "Violet",
		["Blue"]		= "Bleu",
		["Pink"]		= "Rose",
		["Orange"]		= "Orange",
		["Turquoise"]	= "Turquoise",
		["X"]			= "X"
	};
	
	SERENITY_CONFIGURATION = {
		["Menu1"]		= "Options g\195\169n\195\169rales",
		["Menu2"]		= "Options des messages",
		["Menu3"]		= "Options des boutons",
		["Menu4"]		= "Option du compteur",
		["Menu5"]		= "Options graphiques",
		
		["MainRotation"]	= "Angle de selection de Serenity",
		
		["InventoryMenu"]	= "|CFFB700B7I|CFFFF00FFn|CFFFF50FFv|CFFFF99FFe|CFFFFC4FFn|CFFFF99FFt|CFFFF50FFo|CFFFF00FFr|CFFB700B7a|CFFB700B7i|CFFFF00FFr|CFFFF50FFe :",
		["InventoryMenu2"]	= "|CFFB700B7P|CFFFF00FFr|CFFFF50FFo|CFFFF99FFv|CFFFFC4FFi|CFFFF99FFs|CFFFF50FFi|CFFFF00FFo|CFFB700B7n :",
		
		["ProvisionMove"]		= "Mettre les potions et les boissons dans le sac choisi.",
		["ProvisionDestroy"]	= "D\195\169truire toute nouvelle nourriture et boisson si le sac est plein.",
		
		["SpellMenu1"] = "|CFFB700B7S|CFFFF00FFo|CFFFF50FFr|CFFFF99FFt|CFFFFC4FFls :",
		["SpellMenu2"] = "|CFFB700B7J|CFFFF00FFo|CFFFF50FFu|CFFFF99FFe|CFFFFC4FFu|CFFFF99FFr :",
		
		["TimerMenu"]		= "|CFFB700B7T|CFFFF00FFi|CFFFF50FFm|CFFFF99FFe|CFFFFC4FFr|CFFB700B7s G|CFFFF00FFr|CFFFF50FFa|CFFFF99FFp|CFFFFC4FFh|CFFFF99FFi|CFFFF50FFq|CFFFF00FFu|CFFB700B7e :",
		["TimerColor"]		= "Montrer le texte des timers en blanc",
		["TimerDirection"]	= "Ajout des timers vers le haut",
		["TranseWarning"]	= "M'alerter quand j'entre en \195\169tat de transe",
		["SpellTime"]		= "Activer l'indicateur de dur\195\169es des sorts",
		["AntiFearWarning"] = "M'avertir quand ma cible ne peut pas \195\170tre fear.",
		["GraphicalTimer"]	= "Montrer les timers texte au lieu des graphiques",
		
		["TranceButtonView"]	= "Me laisser voir les boutons cach\195\169s pour les d\195\169placer.",
		["ButtonLock"]			= "Bloquer les boutons autour de la sph\195\168re.",
		["MainLock"]			= "Bloquer la sph\195\168re de Serenity.",
		["BagSelect"]			= "Choix du sac des potions et boissons",
		["BuffMenu"]			= "Mettre le menu des buffs sur la gauche",
		["SpellMenu"]			= "Mettre le menu des sorts sur la gauche",
		["STimerLeft"]			= "Montrer les timers sur la gauche du bouton",
		["ShowCount"]			= "Montrer le nombre d'objet sur Serenity",
		["CountType"]			= "\195\137v\195\169nement montr\195\169 sur la sph\195\168re",
		["Potion"]				= "Seuil de potions",
		["Sound"]				= "Activer les sons",
		
		["ShowMessage"]			= "Activer texte al\195\169atoire",
		["ShowResMessage"]		= "Activer texte al\195\169atoire (R\195\169surrection)",
		["ShowSteedMessage"]	= "Activer texte al\195\169atoire (Monture)",
		["ShowShackleMessage"]	= "Activer texte al\195\169atoire (Entrave)",
		["ChatType"]			= "Declarer les messages Serenity comme\nmessages syst\195\168mes",
		
		["SerenitySize"]		= "Taille du bouton principal de Serenity",
		["StoneScale"]			= "Taille des autres boutons",
		["ShackleUndeadSize"]	= "Taille du bouton de l'entrave",
		["TranseSize"]			= "Taille du bouton de Transe et d'Anti-Fear",
		["Skin"]				= "Seuil de boisson",
		["PotionOrder"]			= "Utiliser cette potion en premier",
		["Show"] = {
			["Text"]		= "Voir les boutons:",
			["Potion"]		= "Bouton des potions",
			["Drink"]		= "Bouton des boissons",
			["Dispel"]		= "Bouton Dissipation",
			["LeftSpell"]	= "Bouton gauche (sorts)",
			["MiddleSpell"]	= "Bouton milieu (sorts)",
			["RightSpell"]	= "Bouton droit (sorts)",
			["Steed"]		= "Monture",
			["Buff"]		= "Menu des buffs",
			["Spell"]		= "Menu des sorts",
			["Tooltips"]	= "Voir les tooltips",
			["Spelltimer"]	= "Bouton de dur\195\169es des sorts"
		},
		["Text"] = {
			["Text"]			= "Sur les boutons:",
			["Potion"]			= "Nombre de potions",
			["Drink"]			= "Nombre de boissons",
			["Potion"]			= "Cooldown des potions",
			["Evocation"]		= "Temps de recharge d'evocation",
			["HolyCandles"]		= "Bougies sanctifi\195\169e",
			["Feather"]			= "Plumes l\195\169g\195\168re",
			["SacredCandles"]	= "Bougies sacr\195\169es",
		},
		["QuickBuff"] = "Ouvrir/Fermer le menu des buff si la souris est au-dessus",
		["Count"] = {
			["None"]			= "Sans",
			["Drink"]			= "Quantit\195\169 de boissons",
			["PotionCount"]		= "Quantit\195\169 de potion de mana/soins",
			["Health"]			= "Points de vie courant",
			["HealthPercent"]	= "Point de vie en pourcentage",
			["Mana"]			= "Mana courante",
			["ManaPercent"]		= "Mana en pourcentage",
			["PotionCooldown"]	= "Temps de recharge des potions",
			["Candles"] 		= "Nombre de Bougies",
		},
		["Circle"] = {
			["Text"]	= "\195\137v\195\169nement montr\195\169 autour de la sph\195\168re",
			["None"]	= "Sans",
			["HP"]		= "Points de vie",
			["Mana"]	= "Mana",
			["Potion"]	= "Temps de recharge de la potion",
			["Candles"] = "Nombre de bougies sacr\195\169e",
		},
		["Button"] = {
			["None"]			= "Sans",
			["Text"]			= "Fonction du bouton principal",
			["Drink"]			= "Utiliser les rafra\195\174chissements liquides",
			["ManaPotion"]		= "Utiliser une potion de mana",
			["HealingPotion"]	= "Utiliser une potion de soins",
		},
		["Restock"] = {
			["Restock"] = "Restocker mes composants automatiquement",
			["Confirm"] = "Confirmation avant un quelconque achat",
		},
		["ShackleUndead"] = {
			["Warn"]	= "Me pr\195\169venir avant que l'entrave ne se casse",
			["Break"]	= "Me pr\195\169venir quand l'entrave se casse",
		},
		["ButtonText"] = "Montrer le nombre de composants sur les boutons",
		["Anchor"] = {
			["Text"]	= "Point d'ancrage du menu",
			["Above"]	= "Au-dessus",
			["Center"]	= "Centr\195\169",
			["Below"]	= "Au-dessous"
		},
	};
end