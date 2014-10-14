--[[ $Id: frFR.lua 15751 2006-11-02 13:42:54Z fenlis $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("Antagonist")

L:RegisterTranslations("frFR", function()
    return {
		["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- (internal)
		
		["Antagonist"] = "Antagonist",
		["Casts"] =	"Incantations",
		["Buffs"] =	"Am\195\169liorations",
		["Cooldowns"] = "Temps de recharges",
		
		-- Command line names
		["Group"] = "Groupe",
		["Bar"] = "Bar",
		["Title"] = "Ancrage",
		
		-- Misc names
		["Test"] = "Test",
		["Lock"] = "V\195\169rouiller",
		["Stop"] = "Arr\195\170ter",
		["Config"] = "Configurer",
		["Kill"] = "Tuer",
		["Fade"] = "Fondu",
		["Death"] = "Mort",
		["Self Relevant"] = "Uniquement pour soi",
		["Cooldown Limit"] = "Limite pour les temps de recharge",

		-- Group names
		["Target Only"] = "Cible uniquement",
		["Enabled"] = "Activ\195\169",
		["Show Under"] = "Afficher sous",
		["Pattern"] = "Motif",

		-- Bar names
		["Bar Color"] = "Couleur de la barre",
		["Bar Texture"] = "Texture de la barre",
		["Bar Scale"] = "Echelle de la barre",
		["Bar Height"] = "Largeur de la barre",
		["Bar Width"] = "Longeur de la barre",
		["Text Size"] = "Taille du texte",
		["Reverse"] = "Inverser",
		["Grow Up"] = "D\195\169veloppement vers le haut",
		["Anchor"] = "Ancrage",

		-- Title names
		["Title Text"] = "Titre",
		["Title Size"] = "Title Size",
		["Title Color"] = "Couleur du titre",

		-- Command line descriptions
		["DescGroup"] = "Groupe des trois types de sorts : incantation, am\195\169lioration, recharge.",
		["DescBar"] = "Param\195\169trage de l'apparence des barres.",
		["DescTitle"] = "Title appearance settings.",

		["DescCasts"] = "Temps d'incantation.",
		["DescBuffs"] = "Dur\195\169e des am\195\169liorations.",
		["DescCooldowns"] = "Temps de recharge.",
			
		-- Group descs
		["DescTargetOnly"] = "Analyse les \195\169v\195\168nements de votre cible.",
		["DescEnabled"] = "Soit ce groupe est \195\160 analyser, soit non.",
		["DescShowUnder"] = "Sous quel ancrage le groupe appara\195\174tra.",
		["DescPattern"] = "Motif utilis\195\169 pour le texte de la barre. Utiliser $n, $s et $t pour nom, sort et cible (incantation seulement).",
		
		-- Bar descs
		["DescBarColor"] = "Couleur de la barre",
		["DescBarTexture"] = "Texture de la barre de chronom\195\169trage.",
		["DescBarScale"] = "Echelle de la barre de chronom\195\169trage.",
		["DescBarHeight"] = "La largeur de la barre de chronom\195\169trage.",
		["DescBarWidth"] = "La longeur de la barre de chronom\195\169trage.",
		["DescTextSize"] = "Taille du texte la barre de chronom\195\169trage.",
		["DescReverse"] = "Soit la barre se remplie, soit elle se vide.",
		["DescGrowup"] = "Soit les barres se d\195\169veloppent vers la haut, soit vers le bas.",
		
		-- Title descs
		["DescTitleNum"] = "Control settings for title ", -- do not remove the space
		["DescTitleText"] = "Donner un titre au texte.",
		["DescTitleSize"] = "The font size of the title.",
		["DescTitleColor"] = "Donner une couleur au titre.",

		-- Misc descs
		["DescTest"] = "Lance le test d'affichage des barres.",
		["DescLock"] = "Affiche/cache les ancrages.",
		["DescStop"] = "Arr\195\170te toutes les barres et cache tous les titres.",
		["DescConfig"] = "Ouvre le menu de configuration.",
		["DescGroup"] = "Options du groupe.", 
		["DescKill"] = "Permet la disparition de la barre quand un ennemi est tu\195\169.",
		["DescFade"] = "Permet la disparition de la barre quand le sort dispara\195\174t.",
		["DescDeath"] = "Permet la disparition des barres quand vous mourrez.",
		["DescSelfRelevant"] = "Affiche seulement les barres d'incantations dont vous \195\170tes la cible.",
		["DescCDLimit"] = "N'affiche aucun temps de recharge plus long que ce chiffre.",

		-- Bar color names
		["school"] = "\195\169cole",
		["class"] = "classe",
		["group"] = "groupe",

		["TestBarText"] = "Unit\195\169 : sort",

		-- Spells not supported by BabbleSpell
		-- casts
		["Hearthstone"] = "Pierre de foyer",
		
		-- mob casts
		["Shrink"] = "Rapetisser",			
		["Banshee Curse"] = "Mal\195\169diction de la Banshee",			
		["Shadow Bolt Volley"] = "Salve de Traits de l'ombre",		
		["Cripple"] = "Faiblesse",			
		["Dark Mending"] = "Gu\195\169rison t\195\169n\195\169breuse",			
		["Spirit Decay"] = "D\195\169cr\195\169pitude spirituelle",
		["Gust of Wind"] = "Bourrasque",			
		["Black Sludge"] = "Limace noire",			
		["Toxic Bolt"] = "Eclair toxique",			
		["Poisonous Spit"] = "Crachat empoisonn\195\169",			
		["Wild Regeneration"] =	"R\195\169g\195\169n\195\169ration sauvage",	
		["Curse of the Deadwood"] = "Mal\195\169diction des Mort-bois",		
		["Curse of Blood"] = "Mal\195\169diction du Sang",			
		["Dark Sludge"] = "Limace des t\195\169n\195\168bres",			
		["Plague Cloud"] = "Nu\195\169e de peste",			
		["Wandering Plague"] = "Peste galopante",		
		["Wither Touch"] = "Toucher de fl\195\169trissement",			
		["Fevered Fatigue"] = "Fatigue fi\195\168vreuse",		
		["Encasing Webs"] = "Rets enveloppants",			
		["Crystal Gaze"] = "Regard de cristal",			
		
		-- buffs
		["Brittle Armor"] = "Armure fragile",
		["Unstable Power"] = "Puissance instable",
		["Restless Strength"] = "Force inconstante",
		["Ephemeral Power"] = "Pouvoir \195\169ph\195\169m\195\168re",
		["Massive Destruction"] = "Destruction massive", 
		["Arcane Potency"] = "Toute-puissance des arcanes",	
		["Energized Shield"] = "Bouclier dynamis\195\169",
		["Brilliant Light"] = "Lumi\195\168re \195\169clatante",
		["Mar'li's Brain Boost"] = "Acc\195\169l\195\169ration mentale de Mar'li",
		["Earthstrike"] = "Choc de terre", 
		["Gift of Life"] = "Don de vie", 
		["Nature Aligned"] = "Alignement sur la nature",
		["Quick Shots"] = "Tirs acc\195\169l\195\169r\195\169s",

		["Fire Reflector"] = "R\195\169flectofeu",
		["Shadow Reflector"] = "R\195\169flectombre",
		["Frost Reflector"] = "R\195\169flectogivre",
	}
end)
