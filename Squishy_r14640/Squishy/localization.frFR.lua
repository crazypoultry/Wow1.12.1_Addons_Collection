-- frFR localization by Firiel from Kirin Tor

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("frFR", function() return {

	-- bindings
	["Target unit with highest priority"] = "Cible avec la plus haute priorit\195\169",
	["Target unit with 2nd highest priority"] = "Cible avec la 2nd plus haute priorit\195\169",
	["Target unit with 3rd highest priority"] = "Cible avec la 3\195\168me plus haute priorit\195\169",

	-- from combatlog
	["(.+) begins to cast (.+)."] = "(.+) commence \195\160 lancer (.+).",
	
	-- options
	["Default"]     = "Default",
	["Smooth"]	= "Smooth",
	["Button"]	= "Button",
	["BantoBar"]	= "BantoBar",
	["Charcoal"]	= "Charcoal",
	["Otravi"]	= "Otravi",
	["Perl"]	= "Perl",
	["Smudge"]	= "Smudge",
	
	["always"] = "toujours",
	["grouped"] = "groupe/raid",
	
	["Frame options"] = "Options de la f\195\170netre",
	["Scale"] = "Echelle",
	["Scales the Emergency Monitor."] = "Echelle de la fen\195\170tre emergency monitor",
	["Number of units"] = "Nombre de cibles",
	["Number of max visible units."] = "Nombres maximun de cibles \195\160 afficher",
	["Frame lock"] = "V\195\169rrouillage",
	["Locks/unlocks the emergency monitor."] = "V\195\169rouiller/D\195\169v\195\169rouiller la fen\195\170tre emergency monitor.",
	["Show Frame"] = "Affichage",
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = "D\195\169fini quand la fen\195\170tre doit être affich\195\169e : Toujours ou lorsqu'en groupe/raid",
	["Pet support"] = "Support des familiers",
	["Toggles the display of pets in the emergency frame."] = "Activer/D\195\169sactiver l'affichage des familiers.",
	
	["Unit options"] = "Options des cibles",
	["Alpha"] = "Transparence",
	["Changes background+border visibility"] = "Change l'affichage du fond et de la bordure",
	["Texture"] = "Texture",
	["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."] = "D\195\169fini la texture des barres. Choisissez 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' ou 'Smudge'",
	["Health deficit"] = "Points de vie",
	["Toggles the display of health deficit in the emergency frame."] = "Activer/D\195\169sactiver l'affichage des pts de vie",
	
	["Class options"] = "Options des classes",
	
	["Various options"] = "Options diverses",
	["Audio alert on aggro"] = "Alerte audio d'aggro",
	["Toggle on/off audio alert on aggro."] = "Activer/D\195\169sactiver l'alerte audio d'aggro",
	["Log range"] = "distance de d\195\169tection",
	["Changes combat log range. Set it to your max healing range"] = "Change la distance de d\195\169tection. Choisissez la distance correspondante \195\160 la port\195\169e maximun de vos sorts",
	["Version Query"] = "Version Query",
	["Checks the group for Squishy users and prints their version data."] = "Checks the group for Squishy users and prints their version data.",
	["Checking group for Squishy users, please wait."] = "Checking group for Squishy users, please wait.",
	["using"] = "using",
	
	-- notifications in frame
	[" is healing you."] = " vous soigne.",
	[" healing your group."] = " soigne votre groupe.",
	[" died."] = " meurt.",
	
	-- frame header
	["Squishy Emergency"] = "Squishy Emergency",
	
	-- debuffs and other spell related locals
	["Mortal Strike"] = "Mortal Strike",
	["Mortal Cleave"] = "Mortal Cleave",
	["Gehennas\' Curse"] = "Gehennas\' Curse",
	["Curse of the Deadwood"] = "Curse of the Deadwood",
	["Blood Fury"] = "Blood Fury",
	["Brood Affliction: Green"] = "Brood Affliction: Green",
	["Necrotic Poison"] = "Necrotic Poison",
	["Conflagration"] = "Conflagration",
	["Petrification"] = "Petrification",
} end)
