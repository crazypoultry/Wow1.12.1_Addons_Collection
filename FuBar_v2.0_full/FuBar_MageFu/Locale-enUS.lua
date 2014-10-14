local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("MageFu", "enUS", function()
 return {

  ["SLASHCMD_LONG"] = "/magefu",
  ["SLASHCMD_SHORT"] = "/mf",
  
  ["BINDING_HEADER_MAGEFU"] = "MageFu",
  ["BINDING_NAME_CONJURE"] = "Conjure stuff!",
  ["BINDING_NAME_TRADE"] = "Trade stuff!",
  ["BINDING_NAME_CONSUME"] = "Consume stuff!",
  ["BINDING_NAME_HEARTHSTONE"] = "Use hearthstone",

  ["OPT_TEXTOPTIONS_NAME"] = "Text",
  ["OPT_TEXTOPTIONS_DESC"] = "Set text options.",
  
  ["OPT_TEXT_TEXT_NAME"] = "FuBar Text",
  ["OPT_TEXT_TEXT_DESC"] = "Set FuBar text.",

  ["OPT_TRANSPORT_NAME"] = "Transport",
  ["OPT_TRANSPORT_DESC"] = "Set transport options.",

  ["OPT_TRANSPORT_TELEPORT_NAME"] = "Teleport",
  ["OPT_TRANSPORT_TELEPORT_DESC"] = "Make teleport.",
  ["OPT_TRANSPORT_TELEPORT_SPECIFIC_DESC"] = "Make teleport to %s.",
  ["OPT_TRANSPORT_TELEPORT_MESSAGE_NAME"] = "Message",
  ["OPT_TRANSPORT_TELEPORT_MESSAGE_DESC"] = "Set message options.",  
  ["OPT_TRANSPORT_TELEPORT_MESSAGE_ADD_NAME"] = "Add", 
  ["OPT_TRANSPORT_TELEPORT_MESSAGE_ADD_DESC"] = "Add new message.", 
  ["OPT_TRANSPORT_PORTAL_NAME"] = "Portal",
  ["OPT_TRANSPORT_PORTAL_DESC"] = "Make portal.",
  ["OPT_TRANSPORT_PORTAL_SPECIFIC_DESC"] = "Make portal to %s.",
  ["OPT_TRANSPORT_PORTAL_MESSAGE_NAME"] = "Message",
  ["OPT_TRANSPORT_PORTAL_MESSAGE_DESC"] = "Set message options.",  
  ["OPT_TRANSPORT_PORTAL_MESSAGE_ADD_NAME"] = "Add",   
  ["OPT_TRANSPORT_PORTAL_MESSAGE_ADD_DESC"] = "Add new message.",  
  ["OPT_TRANSPORT_HEARTHSTONE_DESC"] = "Use hearthstone.",  
  
  ["OPT_REAGENT_NAME"] = "Reagent",
  ["OPT_REAGENT_DESC"] = "Set reagent options.",
  
  ["OPT_REAGENT_SPECIFIC_DESC"] = "Number of stacks of %s to buy.",
  ["OPT_REAGENT_AUTOBUY_NAME"] = "Auto Buy",
  ["OPT_REAGENT_AUTOBUY_DESC"] = "If set, automatically buys reagents from vendors.",   

  ["OPT_CONJURE_OPTIONS_NAME"] = "Conjure",
  ["OPT_CONJURE_OPTIONS_DESC"] = "Set conjure options.",  
  
  ["OPT_CONJURE_GEM_NAME"] = "Mana Gems",
  ["OPT_CONJURE_GEM_DESC"] = "Number of mana gems to conjure.",
  ["OPT_CONJURE_MAXRANKGEM_NAME"] = "Max Rank: Mana Gem",
  ["OPT_CONJURE_MAXRANKGEM_DESC"] = "Max rank of mana gem to attempt to conjure.",
  ["OPT_CONJURE_MAXRANKFOOD_NAME"] = "Max Rank: Food",
  ["OPT_CONJURE_MAXRANKFOOD_DESC"] = "Max rank of food to attempt to conjure.",
  ["OPT_CONJURE_MAXRANKWATER_NAME"] = "Max Rank: Water",
  ["OPT_CONJURE_MAXRANKWATER_DESC"] = "Max rank of water to attempt to conjure.",
  ["OPT_CONJURE_CLASS_SPECIFIC_DESC"] = "Set %s options.",
  ["OPT_CONJURE_CLASS_FOOD_NAME"] = "Food",
  ["OPT_CONJURE_CLASS_FOOD_DESC"] = "If set, will conjure food for this class.",
  ["OPT_CONJURE_CLASS_WATER_NAME"] = "Water",
  ["OPT_CONJURE_CLASS_WATER_DESC"] = "If set, will conjure water for this class.", 
  ["OPT_CONJURE_BYCLASS_NAME"] = "Conjure by class",
  ["OPT_CONJURE_BYCLASS_DESC"] = "If set, will conjure food/water depending on current target class.",
  ["OPT_CONJURE_CLASS_NAME"] = "Class",
  ["OPT_CONJURE_CLASS_DESC"] = "Set class options.",
  ["OPT_CONJURE_AMOUNT_NAME"] = "Amount",
  ["OPT_CONJURE_AMOUNT_DESC"] = "Amount options.",
  ["OPT_CONJURE_AMOUNT_LIMIT_NAME"] = "Limit",
  ["OPT_CONJURE_AMOUNT_LIMIT_DESC"] = "Set limit type for conjuring food/water.",
  ["OPT_CONJURE_AMOUNT_LIMIT_NONE"] = "None",
  ["OPT_CONJURE_AMOUNT_LIMIT_MINIMUM"] = "Minimum",
  ["OPT_CONJURE_AMOUNT_LIMIT_MAXIMUM"] = "Maximum",
  ["OPT_CONJURE_AMOUNT_MAXFOOD_NAME"] = "Max Amount: Food",
  ["OPT_CONJURE_AMOUNT_MAXFOOD_DESC"] = "Max amount of food to attempt to conjure.",
  ["OPT_CONJURE_AMOUNT_MAXWATER_NAME"] = "Max Amount: Water",
  ["OPT_CONJURE_AMOUNT_MAXWATER_DESC"] = "Max amount of water to attempt to conjure.",
  
  
  ["OPT_TRADE_OPTIONS_NAME"] = "Trade",
  ["OPT_TRADE_OPTIONS_DESC"] = "Set trade options.",  
  
  ["OPT_TRADE_AUTOTRADE_NAME"] = "Auto Trade",
  ["OPT_TRADE_AUTOTRADE_DESC"] = "If set, automatically trades when trade window opens.",  
  
  ["OPT_CONSUME_OPTIONS_NAME"] = "Consume",
  ["OPT_CONSUME_OPTIONS_DESC"] = "Set consume options.",  

  ["OPT_CONSUME_HEALTHTHRESHOLD_NAME"] = "Health Threshold",
  ["OPT_CONSUME_HEALTHTHRESHOLD_DESC"] = "Set threshold at which to eat food.",
  ["OPT_CONSUME_MANATHRESHOLD_NAME"] = "Mana Threshold",
  ["OPT_CONSUME_MANATHRESHOLD_DESC"] = "Set threshold at which to drink water.",
  
  ["OPT_RAID_NAME"] = "Raid",
  ["OPT_RAID_DESC"] = "Set raid options.",

  ["OPT_RAID_INRAID_NAME"] = "In Raid",
  ["OPT_RAID_INRAID_DESC"] = "If set, you are in a raid.",
  ["OPT_RAID_DISPLAYGROUPS_NAME"] = "Display Groups",
  ["OPT_RAID_DISPLAYGROUPS_DESC"] = "If set, displays groups on tooltip.",
  ["OPT_RAID_DISPLAYBUFFS_NAME"] = "Display Buffs",
  ["OPT_RAID_DISPLAYBUFFS_DESC"] = "If set, displays buffs on tooltip.",
  ["OPT_RAID_GROUP_NAME"] = "Group",
  ["OPT_RAID_GROUP_DESC"] = "Set group options.",
  ["OPT_RAID_GROUP_SPECIFIC_NAME"] = "Group %d",
  ["OPT_RAID_GROUP_SPECIFIC_DESC"] = "If set, group %d is assigned to you.",
  
   
  ["OPT_CONJURE_NAME"] = "Conjure",
  ["OPT_CONJURE_DESC"] = "Conjure stuff!",
  ["OPT_TRADE_NAME"] = "Trade",
  ["OPT_TRADE_DESC"] = "Trade stuff!", 
  ["OPT_CONSUME_NAME"] = "Consume",
  ["OPT_CONSUME_DESC"] = "Consume stuff!",
  
  ["TOOLTIP_HINT"] = "Click to conjure stuff!",

  ["ALLIANCE"] = "Alliance",
  ["HORDE"] = "Horde",

  ["IRONFORGE"] = "Ironforge",
  ["STORMWIND"] = "Stormwind",
  ["DARNASSUS"] = "Darnassus",
  ["ORGRIMMAR"] = "Orgrimmar",
  ["THUNDERBLUFF"] = "Thunder Bluff",
  ["UNDERCITY"] = "Undercity",
  
  ["HEARTHSTONE"] = "Hearthstone",

  ["MAGE"] = "Mage",
  ["PRIEST"] = "Priest",
  ["WARLOCK"] = "Warlock",
  ["ROGUE"] = "Rogue",
  ["DRUID"] = "Druid",
  ["HUNTER"] = "Hunter",
  ["SHAMAN"] = "Shaman",
  ["PALADIN"] = "Paladin",
  ["WARRIOR"] = "Warrior",
  
  ["ARCANEPOWDER"] = "Arcane Powder",
  ["RUNEOFTELEPORTATION"] = "Rune of Teleportation",
  ["RUNEOFPORTALS"] = "Rune of Portals",
  
  ["GEMRANK4"] = "Mana Ruby",
  ["GEMRANK3"] = "Mana Citrine",
  ["GEMRANK2"] = "Mana Jade",
  ["GEMRANK1"] = "Mana Agate",
  
  ["FOODRANK7"] = "Conjured Cinnamon Roll",
  ["FOODRANK6"] = "Conjured Sweet Roll",
  ["FOODRANK5"] = "Conjured Sourdough",
  ["FOODRANK4"] = "Conjured Pumpernickel",
  ["FOODRANK3"] = "Conjured Rye",
  ["FOODRANK2"] = "Conjured Bread",
  ["FOODRANK1"] = "Conjured Muffin",

  ["WATERRANK7"] = "Conjured Crystal Water",
  ["WATERRANK6"] = "Conjured Sparkling Water",
  ["WATERRANK5"] = "Conjured Mineral Water",
  ["WATERRANK4"] = "Conjured Spring Water",
  ["WATERRANK3"] = "Conjured Purified Water",
  ["WATERRANK2"] = "Conjured Fresh Water",
  ["WATERRANK1"] = "Conjured Water",

  ["SPELL_TELEPORT"] = "Teleport: %s",
  ["SPELL_PORTAL"] = "Portal: %s",
  ["SPELL_CONJUREFOOD"] = "Conjure Food(Rank %d)",
  ["SPELL_CONJUREWATER"] = "Conjure Water(Rank %d)",
  ["SPELL_CONJUREGEM"] = "Conjure %s",
 }
end)