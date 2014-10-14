--[[
English version
]]--

QUANJURE_DESCRIPTION = "Collection of mage utilities.";
QUANJURE_MAGE = "Mage"; 
QUANJURE_MAGE_WARNING = "Current Character not a Mage (or level too low) - aborting.";
QUANJURE_TOOLTIP = "Left-click to Quanjure.\nRight-click for menu.\nShift+Right-click to drag."
QUANJURE_MINIMAP = "Hide minimap button"
QUANJURE_MINIMAP_SETUP = "Show minimap button";
QUANJURE_MINIMAP_TOOLTIP = "Check to show button on the minimap.";
QUANJURE_OPTIONS = "Options";
QUANJURE_SETUP = "Quanjure Setup";
QUANJURE_ALLIANCE = "Alliance";
QUANJURE_HORDE = "Horde";
QUANJURE_READY = "Ready";
QUANJURE_BAG = "Backpack";
QUANJURE_HEARTHSTONE = "Hearthstone";
QUANJURE_DRINKING_BUFF = "Drink" -- Not localized
QUANJURE_EATING_BUFF = "Fork" -- Not localized

-- Water and Food Names - starting with the name of the Rank 1 products
QUANJURE_WATERTYPES = {
	"Conjured Water",
	"Conjured Fresh Water",
	"Conjured Purified Water",
	"Conjured Spring Water",
	"Conjured Mineral Water",
	"Conjured Sparkling Water",
	"Conjured Crystal Water" 
};
QUANJURE_FOODTYPES = {
	"Conjured Muffin",
	"Conjured Bread",
	"Conjured Rye",
	"Conjured Pumpernickel",
	"Conjured Sourdough",
	"Conjured Sweet Roll",
	"Conjured Cinnamon Roll"
};

QUANJURE_CONJURE = "Conjure";
QUANJURE_CONJURE_WATER = "Conjure Water";
QUANJURE_CONJURE_FOOD = "Conjure Food";
QUANJURE_CONJURE_RANK = "Rank";
QUANJURE_CONJURE_RUBY = "Conjure Mana Ruby";
QUANJURE_CONJURE_CITRINE = "Conjure Mana Citrine";
QUANJURE_CONJURE_JADE = "Conjure Mana Jade";
QUANJURE_CONJURE_AGATE = "Conjure Mana Agate";
QUANJURE_RUBY = "Mana Ruby";
QUANJURE_CITRINE = "Mana Citrine";
QUANJURE_JADE = "Mana Jade";
QUANJURE_AGATE = "Mana Agate";
QUANJURE_GEM_OPTIONS = "Number of mana gems to conjure";
QUANJURE_GEM_OPTIONS_SHORT = "Gems:";

QUANJURE_TARGETCONJURE_SETUP = "Target dependant conjuring";
QUANJURE_TARGETCONJURE_TOOLTIP = "Enables conjuring for your current target's level and class.";
QUANJURE_TRADECONJURE_SETUP = "Trade dependant conjuring";
QUANJURE_TRADECONJURE_TOOLTIP = "Enables trading and conjuring for your current trade target's level and class.";

QUANJURE_REAGENTS = "AutoReagents";
QUANJURE_REAGENTS_ENABLED = "AutoReagents enabled.";
QUANJURE_REAGENTS_DISABLED = "AutoReagents disabled - Current character not a mage.";
QUANJURE_REAGENTS_POWDER = "Arcane Powder";
QUANJURE_REAGENTS_TELEPORT = "Rune of Teleportation";
QUANJURE_REAGENTS_PORTAL = "Rune of Portals";
QUANJURE_REAGENTS_ARCANEBRILLIANCE = "Arcane Brilliance";
QUANJURE_REAGENTS_CURRENCY = {"g","s","c"};
QUANJURE_POWDER_OPTIONS = "Stacks of Arcane Powder to purchase";
QUANJURE_TELEPORT_OPTIONS = "Stacks of Rune of Teleportation to purchase";
QUANJURE_PORTAL_OPTIONS = "Stacks of Rune of Portals to purchase";
QUANJURE_POWDER_OPTIONS_SHORT = "Powders:";
QUANJURE_TELEPORT_OPTIONS_SHORT = "Teleports:";
QUANJURE_PORTAL_OPTIONS_SHORT = "Portals:";

QUANJURE_EVOCATION = "Evocation"; -- Name of the Evocation Spell
QUANJURE_EVOCATION_WARNING = "Evocation not found - aborting.";
QUANJURE_EVOCATION_CHECKBOX = "One-click Evocation";
QUANJURE_EVOCATION_SETUP = "Evocation Setup";
QUANJURE_EVOCATION_MAINHAND = "Main Hand";
QUANJURE_EVOCATION_OFFHAND = "Off Hand";
QUANJURE_EVOCATION_WAND = "Wand";
QUANJURE_EVOCATION_HELP = "Drag spirit weapons to use during evocation into their appropriate slots.";
QUANJURE_EVOCATION_MACRO_HELP = "Copy/Paste the following into a macro, or bind a key under Key Bindings, to use Quanjure's Evocation.";
QUANJURE_EVOCATION_TOOLTIP = "|cFFFFFFFFThree-click version:|r\n- First click equips spirit weapons.\n- Second click (after global cooldown) casts evocation.\n- Third click re-equips the non-spirit weapons.\n\n|cFFFFFFFFOne-click version:|r\nEquips spirit weapons immediately after casting Evocation\nand re-equips normal weapons once there's less than 1.6\nseconds left of the channeling.\nMay cause evocation to tick without spirit weapons.";
QUANJURE_INNERVATE = "Innervate";
QUANJURE_INNERVATE_CHECKBOX = "Use for Innervate";
QUANJURE_INNERVATE_TOOLTIP = "Automatically equips spirit weapons while being innervated.";
QUANJURE_DRINKING_CHECKBOX = "Use while drinking and eating";
QUANJURE_DRINKING_TOOLTIP = "Automatically equips spirit weapons while drinking and eating.";
QUANJURE_DRINKING_EXCLUDE_HELP = "Enter any zones where you wish to |cFFFFFFFFoverride|r the current setting. Seperate by comma. \n\n|cFFFFFFFFExample:|r Arathi Basin, Alterac Valley\n|cFFFFFFFFCurrent Zone:|r "
QUANJURE_DARKMOON = "Aura of the Blue Dragon";
QUANJURE_DARKMOON_CHECKBOX = "Use for Darkmoon Card: Blue Dragon";
QUANJURE_DARKMOON_TOOLTIP = "Automatically equips spirit weapons while\n|cFFFFFFFFDarkmoon Card: Blue Dragon|r is procced.";


QUANJURE_PORTALS_TELEPORT = "Teleport"
QUANJURE_PORTALS_PORTAL = "Portal"
QUANJURE_PORTALS_SINGULAR = "rune"; -- 1 rune
QUANJURE_PORTALS_PLURAL = "runes"; -- 2 runes
QUANJURE_PORTALS_ALLIANCE = {"Ironforge", "Stormwind", "Darnassus"};
QUANJURE_PORTALS_HORDE = {"Orgrimmar", "Undercity", "Thunder Bluff"};
QUANJURE_PORTALS_TELEPORT_WARNING = "Casting Teleport While In Party!";
QUANJURE_PORTALS_PORTAL_WARNING = "Casting Portal Out Of Party!";

QUANJURE_DISMOUNTING = "Dismounting...";

QUANJURE_MISC_TITLE = "Misc. Transports";
QUANJURE_MISC_ENGINEER = {"Ultrasafe Transporter: Gadgetzan", "Dimensional Ripper - Everlook"};
QUANJURE_MISC_SPELLS = {"Astral Recall", "Teleport: Moonglade"}
QUANJURE_MISC_BG_HORDE = {
	"Frostwolf Insignia Rank 6",
	"Frostwolf Insignia Rank 5",
	"Frostwolf Insignia Rank 4",
	"Frostwolf Insignia Rank 3",
	"Frostwolf Insignia Rank 2",
	"Frostwolf Insignia Rank 1"
};
QUANJURE_MISC_BG_ALLIANCE = {
	"Stormpike Insignia Rank 6",
	"Stormpike Insignia Rank 5",
	"Stormpike Insignia Rank 4",
	"Stormpike Insignia Rank 3",
	"Stormpike Insignia Rank 2",
	"Stormpike Insignia Rank 1"
};

QUANJURE_WARRIOR = "Warrior";
QUANJURE_ROGUE = "Rogue";
QUANJURE_HUNTER = "Hunter";
QUANJURE_MAGE = "Mage";
QUANJURE_WARLOCK = "Warlock";
QUANJURE_DRUID = "Druid";
QUANJURE_PRIEST = "Priest";
QUANJURE_SHAMAN = "Shaman";
QUANJURE_PALADIN = "Paladin";

QUANJURE_NOTFOUND = "not found."