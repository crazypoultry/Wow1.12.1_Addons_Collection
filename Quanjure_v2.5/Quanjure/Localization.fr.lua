--[[
French version 
Text translated by Asthar

Should you find any errors in the naming of spells or items, please send me a correction.

Thank you. 
Quantuvis   quantuvis@represent.dk
]]--

if ( GetLocale() == "frFR" ) then
	QUANJURE_MAGE = "Mage"; 
	QUANJURE_MAGE_WARNING = "Joueur selectionn\195\169 non-mage ou trop bas niveau - annulation.";
	QUANJURE_TOOLTIP = "Left-click to Quanjure.\nRight-click for menu.\nShift+Right-click to drag."
	QUANJURE_MINIMAP = "Hide minimap button"
	QUANJURE_MINIMAP_SETUP = "Show minimap button";
	QUANJURE_MINIMAP_TOOLTIP = "Check to show button on the minimap.";
	QUANJURE_OPTIONS = "Options";
	QUANJURE_SETUP = "Configuration de Quanjure";
	QUANJURE_ALLIANCE = "Alliance";
	QUANJURE_HORDE = "Horde";
	QUANJURE_READY = "Pr\195\170t";
	QUANJURE_BAG = "Sac \195\160 dos";
	QUANJURE_HEARTHSTONE = "Pierre de foyer";

	QUANJURE_WATERTYPES = {
		"Eau invoqu\195\169e",
		"Eau fra\195\174che invoqu\195\169e",
		"Eau purifi\195\169e invoqu\195\169e",
		"Eau de source invoqu\195\169e",
		"Eau min\195\169rale invoqu\195\169e",
		"Eau p\195\169tillante invoqu\195\169e",
		"Eau cristalline invoqu\195\169e" 
	};
	QUANJURE_FOODTYPES = {
		"Muffin invoqu\195\169",
		"Pain invoqu\195\169",
		"Pain de voyage invoqu\195\169",
		"Pain noir invoqu\195\169",
		"Pain de route invoqu\195\169",
		"Pain au lait invoqu\195\169",
		"Roul\195\169s \195\160 la cannelle invoqu\195\169s"
	};
	
	QUANJURE_CONJURE = "Invocation";
	QUANJURE_CONJURE_WATER = "Invocation d'eau";
	QUANJURE_CONJURE_FOOD = "Invocation de nourriture";
	QUANJURE_CONJURE_RANK = "Rang";
	QUANJURE_CONJURE_RUBY = "Invocation d'un rubis de mana";
	QUANJURE_CONJURE_CITRINE = "Invocation d'une citrine de mana";
	QUANJURE_CONJURE_JADE = "Invocation d'une jade de mana";
	QUANJURE_CONJURE_AGATE = "Invocation d'une agate de mana";
	QUANJURE_RUBY = "Rubis de mana";
	QUANJURE_CITRINE = "Citrine de mana";
	QUANJURE_JADE = "Jade de mana";
	QUANJURE_AGATE = "Agate de mana";
	QUANJURE_GEM_OPTIONS = "Nombre de gemmes \195\160 invoquer";
	QUANJURE_GEM_OPTIONS_SHORT = "Gemmes:";
	
	QUANJURE_TARGETCONJURE_SETUP = "Target dependant conjuring";
	QUANJURE_TARGETCONJURE_TOOLTIP = "Enables conjuring for your current target's level and class.";
	QUANJURE_TRADECONJURE_SETUP = "Trade dependant conjuring";
	QUANJURE_TRADECONJURE_TOOLTIP = "Enables trading and conjuring for your current trade target's level and class."
	
	QUANJURE_REAGENTS = "Ingredients-auto";
	QUANJURE_REAGENTS_ENABLED = "Ingredients-auto actif.";
	QUANJURE_REAGENTS_DISABLED = "Ingredients-auto inactif - joueur non mage selectionn\195\169."
	QUANJURE_REAGENTS_POWDER = "Poudre des arcanes";
	QUANJURE_REAGENTS_TELEPORT = "Rune de t\195\169l\195\169portation";
	QUANJURE_REAGENTS_PORTAL = "Rune des portails";
	QUANJURE_REAGENTS_ARCANEBRILLIANCE = "Illumination des arcanes";
	QUANJURE_REAGENTS_CURRENCY = {"o","a","c"};
	QUANJURE_POWDER_OPTIONS = "Pile de poudre d'arcane \195\160 acheter";
	QUANJURE_TELEPORT_OPTIONS = "Pile de rune de t\195\169l\195\169portation \195\160 acheter";
	QUANJURE_PORTAL_OPTIONS = "Pile de rune de portails \195\160 acheter";
	QUANJURE_POWDER_OPTIONS_SHORT = "Poudres:";
	QUANJURE_TELEPORT_OPTIONS_SHORT = "Teleports:";
	QUANJURE_PORTAL_OPTIONS_SHORT = "Portails:";
		
	QUANJURE_EVOCATION = "Evocation"; -- Name of the Evocation Spell
	QUANJURE_EVOCATION_WARNING = "Evocation non trouv\195\169 - annulation.";
	QUANJURE_EVOCATION_CHECKBOX = "Evocation en un clic";
	QUANJURE_EVOCATION_SETUP = "Configuration d'Evocation";
	QUANJURE_EVOCATION_MAINHAND = "Main droite";
	QUANJURE_EVOCATION_OFFHAND = "Main gauche";
	QUANJURE_EVOCATION_WAND = "Baguette";
	QUANJURE_EVOCATION_HELP = "Equipe les armes +esprit pour le sort Evocation dans les emplacements appropri\195\169s.";
	QUANJURE_EVOCATION_MACRO_HELP = "Copier/Coller ce qui suit sur une macro, ou associer une touche via Raccourcis, pour utiliser Evocation via Quanjure.";
	QUANJURE_EVOCATION_TOOLTIP = "|cFFFFFFFFVersion en 3 clics:|r\n- premier clic \195\169quipe les armes.\n- second clic (après le cooldown) lance Evocation .\n- Troisième clic r\195\169equipe les armes non-esprit.\n\n|cFFFFFFFFOne-click version:|r\nEquips spirit weapons immediately after casting Evocation\nand re-equips normal weapons once there's less than 1.6\nseconds left of the channeling.\nPeut provoquer le lancement d'Evocation sans les armes Esprit.";
	QUANJURE_INNERVATE = "Innervation";
	QUANJURE_INNERVATE_CHECKBOX = "Utiliser pour Innervation";
	QUANJURE_INNERVATE_TOOLTIP = "Auto \195\169quipe les armes esprit lorsqu'on est Innerv\195\169.";
	QUANJURE_DRINKING_CHECKBOX = "Use while drinking and eating";
	QUANJURE_DRINKING_TOOLTIP = "Automatically equips spirit weapons while drinking and eating.";
	QUANJURE_DRINKING_EXCLUDE_HELP = "Enter any zones where you wish to |cFFFFFFFFoverride|r the current setting. Seperate by comma. \n\n|cFFFFFFFFExample:|r Arathi Basin, Alterac Valley\n|cFFFFFFFFCurrent Zone:|r "
	QUANJURE_DARKMOON = "Aura du dragon bleu";
	QUANJURE_DARKMOON_CHECKBOX = "Utiliser pour Carte de Sombrelune : Dragon bleu";
	QUANJURE_DARKMOON_TOOLTIP = "Automatically equips spirit weapons while \n|cFFFFFFFFCarte de Sombrelune : Dragon bleu|r is procced.";
		
	QUANJURE_PORTALS_TELEPORT = "T/195/169l/195/169portation "
	QUANJURE_PORTALS_PORTAL = "Portail "
	QUANJURE_PORTALS_PORTAL_FR = "Portail\194\160"
	QUANJURE_PORTALS_SINGULAR = "rune"; -- 1 rune
	QUANJURE_PORTALS_PLURAL = "runes"; -- 2 runes
	QUANJURE_PORTALS_ALLIANCE = {"Ironforge", "Stormwind", "Darnassus"};
	QUANJURE_PORTALS_HORDE = {"Orgrimmar", "Undercity", "Thunder Bluff"};
	QUANJURE_PORTALS_TELEPORT_WARNING = "Lance T\195\169l\195\169portation en groupe!";
	QUANJURE_PORTALS_PORTAL_WARNING = "Lance Portail hors groupe!";
	
	QUANJURE_DISMOUNTING = "Quitte la monture...";		
	
	QUANJURE_MISC_TITLE = "Transports Divers";
	QUANJURE_MISC_ENGINEER = {"Transporteur ultra-s\195\169curis\195\169 : Gadgetzan", "D\195\169chiquetteur dimensionnel - Long-guet"};
	QUANJURE_MISC_SPELLS = {"Rappel astral", "Teleport: Moonglade", "Teleport : Moonglade"}
	QUANJURE_MISC_BG_HORDE = {
		"Insigne Frostwolf grade 6",
		"Insigne Frostwolf grade 5",
		"Insigne Frostwolf grade 4",
		"Insigne Frostwolf grade 3",
		"Insigne Frostwolf grade 2",
		"Insigne Frostwolf grade 1"
	};
	QUANJURE_MISC_BG_ALLIANCE = {
		"Insigne Stormpike grade 6",
		"Insigne Stormpike grade 5",
		"Insigne Stormpike grade 4",
		"Insigne Stormpike grade 3",
		"Insigne Stormpike grade 2",
		"Insigne Stormpike grade 1"
	};
	
	QUANJURE_WARRIOR = "Guerrier";
	QUANJURE_ROGUE = "Voleur";
	QUANJURE_HUNTER = "Chasseur";
	QUANJURE_MAGE = "Mage";
	QUANJURE_WARLOCK = "D\195\169moniste";
	QUANJURE_SHAMAN = "Chaman";
	QUANJURE_PALADIN = "Paladin";
	QUANJURE_DRUID = "Druide";
	QUANJURE_PRIEST = "Pr\195\170tre";
	
	QUANJURE_NOTFOUND = "non trouv\195\169."
end