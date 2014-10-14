--
-- AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

local AceLocale = AceLibrary("AceLocale-2.1");

AceLocale:RegisterTranslation("AutoBar", "enUS", function()
    return {
		["AUTOBAR"] = "AutoBar",
		["CONFIG_WINDOW"] = "Configuration Window",
		["SLASHCMD_LONG"] = "/autobar",
		["SLASHCMD_SHORT"] = "/atb",
		["BUTTON"] = "Button",
		["EDITSLOT"] = "Edit Slot",
		["VIEWSLOT"] = "View Slot",

		--  AutoBarConfig.lua
		["EMPTY"] = "Empty"; --AUTOBAR_CONFIG_EMPTY
		["AUTOBAR_CONFIG_SMARTSELFCAST"] = "Smart Self Cast";
		["AUTOBAR_CONFIG_REMOVECAT"] = "Delete Current Category";
		["AUTOBAR_CONFIG_ROW"] = "Rows";
		["AUTOBAR_CONFIG_COLUMN"] = "Columns";
		["AUTOBAR_CONFIG_GAPPING"] = "Icon Gapping";
		["AUTOBAR_CONFIG_ALPHA"] = "Icon Alpha";
		["AUTOBAR_CONFIG_BUTTONWIDTH"] = "Button Width";
		["AUTOBAR_CONFIG_BUTTONHEIGHT"] = "Button Height";
		["AUTOBAR_CONFIG_DOCKSHIFTX"] = "Shift Dock Left/Right";
		["AUTOBAR_CONFIG_DOCKSHIFTY"] = "Shift Dock Up/Down";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "Button Height\nand Width Unlocked";
		["AUTOBAR_CONFIG_HIDEKEYBINDING"] = "Hide Keybinding Text";
		["AUTOBAR_CONFIG_HIDECOUNT"] = "Hide Count Text";
		["AUTOBAR_CONFIG_SHOWEMPTY"] = "Show Empty Buttons";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "Show Category Icons";
		["AUTOBAR_CONFIG_HIDETOOLTIP"] = "Hide Tooltips";
		["AUTOBAR_CONFIG_POPUPDIRECTION"] = "Popup\nButtons\nDirection";
		["AUTOBAR_CONFIG_POPUPDISABLE"] = "Disable Popup";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Popup on Shift Key";
		["AUTOBAR_CONFIG_HIDEDRAGHANDLE"] = "Hide Drag Handle";
		["AUTOBAR_CONFIG_PLAINBUTTONS"] = "Plain Buttons";
		["AUTOBAR_CONFIG_NOPOPUP"] = "No Popup";
		["AUTOBAR_CONFIG_ARRANGEONUSE"] = "Rearrange Order on Use";
		["AUTOBAR_CONFIG_RIGHTCLICKTARGETSPET"] = "Right Click Targets Pet";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "None";
		["AUTOBAR_CONFIG_DOCKTOGBARS"] = "Gbars Second Bar";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "Main Menu";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "Chat Frame";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "Chat Frame Menu";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "Action Bar";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "Menu Buttons";
		["AUTOBAR_CONFIG_ALIGN"] = "Align Buttons";
    }
end);


if (true) then

AUTOBAR_CHAT_MESSAGE1 = "Config for this character is old version. Clearing. No attempt to upgrade config is being done.";
AUTOBAR_CHAT_MESSAGE2 = "Updating multi item button #%d item #%d to use itemid instead of item name.";
AUTOBAR_CHAT_MESSAGE3 = "Updating single item button #%d to use itemid instead of item name.";

---------------------------------------
--  AutoBar_Config.xml
---------------------------------------
AUTOBAR_CONFIG_VIEWTEXT = "To edit a slot select it from the Slot edit section\nat the bottom of the Slots tab.";
AUTOBAR_CONFIG_SLOTVIEWTEXT = "Combined Layer View (not editable)";
AUTOBAR_CONFIG_RESET = "Reset";
AUTOBAR_CONFIG_REVERT = "Revert";
AUTOBAR_CONFIG_DONE = "Done";
AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Shift Click to explore Category)";
AUTOBAR_CONFIG_DRAGHANDLE = "Left Mouse Drag to move AutoBar\nLeft Click to Lock / Unlock\nRight Click for options";
AUTOBAR_CONFIG_EMPTYSLOT = "Empty Slot";
AUTOBAR_CONFIG_CLEARSLOT = "Clear Slot";
AUTOBAR_CONFIG_SETSHARED = "Shared Profile:";
AUTOBAR_CONFIG_SETSHAREDTIP = "Select the shared profile for this Character to use.\nChanges to a shared profile affect all Characters using it";

AUTOBAR_CONFIG_TAB_SLOTS = "Slots";
AUTOBAR_CONFIG_TAB_BAR = "Bar";
AUTOBAR_CONFIG_TAB_BUTTONS = "Buttons";
AUTOBAR_CONFIG_TAB_POPUP = "Popup";
AUTOBAR_CONFIG_TAB_PROFILE = "Profile";

AUTOBAR_TOOLTIP1 = " (Count: ";
AUTOBAR_TOOLTIP2 = " [Custom Item]";
AUTOBAR_TOOLTIP3 = " [In Combat Only]";
AUTOBAR_TOOLTIP4 = " [Battlegrounds only]";
AUTOBAR_TOOLTIP5 = " [Non Combat Only]";
AUTOBAR_TOOLTIP6 = " [Limited Usage]";
AUTOBAR_TOOLTIP7 = " [Cooldown]";
AUTOBAR_TOOLTIP8 = "\n(Left Click to apply to Main Hand weapon\nRight Click to apply to OffHand weapon)";


---------------------------------------
--  AutoBarConfig.lua
---------------------------------------

AUTOBAR_CONFIG_NOTFOUND = "(Not Found: Item ";
AUTOBAR_CONFIG_DOCKTO = "Docked to:";
AUTOBAR_CONFIG_SLOTEDITTEXT = " Layer (click to edit)";
AUTOBAR_CONFIG_CHARACTER = "Character";
AUTOBAR_CONFIG_SHARED = "Shared";
AUTOBAR_CONFIG_CLASS = "Class";
AUTOBAR_CONFIG_BASIC = "Basic";
AUTOBAR_CONFIG_USECHARACTER = "Use Character Layer";
AUTOBAR_CONFIG_USESHARED = "Use Shared Layer";
AUTOBAR_CONFIG_USECLASS = "Use Class Layer";
AUTOBAR_CONFIG_USEBASIC = "Use Basic Layer";
AUTOBAR_CONFIG_USECHARACTERTIP = "Character Layer items are specific to this Character.";
AUTOBAR_CONFIG_USESHAREDTIP = "Shared Layer items are shared by other Characters that use the same Shared Layer.\nThe specific layer can be chosen on the Profile Tab.";
AUTOBAR_CONFIG_USECLASSTIP = "Class Layer items are shared by all Characters of the same class that use the Class Layer.";
AUTOBAR_CONFIG_USEBASICTIP = "Basic Layer items are shared by all Characters using the Basic Layer.";
AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS = "Hide Config Tooltips";
AUTOBAR_CONFIG_OSKIN = "Use oSkin";
AUTOBAR_CONFIG_CHARACTERLAYOUT = "Character Layout";
AUTOBAR_CONFIG_SHAREDLAYOUT = "Shared Layout";
AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "Changes to visual layout only affect this Character.";
AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "Changes to visual layout affect all Characters using the same shared profile.";
AUTOBAR_CONFIG_SHARED1 = "Shared 1";
AUTOBAR_CONFIG_SHARED2 = "Shared 2";
AUTOBAR_CONFIG_SHARED3 = "Shared 3";
AUTOBAR_CONFIG_SHARED4 = "Shared 4";
AUTOBAR_CONFIG_TIPOVERRIDE = "Items in a slot on this layer override items in that slot on lower layers.\n";
AUTOBAR_CONFIG_TIPOVERRIDDEN = "Items in a slot on this layer are overidden by items on higher layers.\n";
AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "Changes affect only this Character.";
AUTOBAR_CONFIG_TIPAFFECTSALL = "Changes affect all Characters.";
AUTOBAR_CONFIG_EDITCHARACTER = "Edit Character Layer";
AUTOBAR_CONFIG_EDITSHARED = "Edit Shared Layer";
AUTOBAR_CONFIG_EDITCLASS = "Edit Class Layer";
AUTOBAR_CONFIG_EDITBASIC = "Edit Basic Layer";
AUTOBAR_CONFIG_SETUPSINGLE = "Single Setup";
AUTOBAR_CONFIG_SETUPSHARED = "Shared Setup";
AUTOBAR_CONFIG_SETUPSTANDARD = "Standard Setup";
AUTOBAR_CONFIG_SETUPBLANKSLATE = "Blank Slate";
AUTOBAR_CONFIG_SETUPSINGLETIP = "Click for Single Character settings similar to the classic AutoBar.";
AUTOBAR_CONFIG_SETUPSHAREDTIP = "Click for shared settings.\nEnables the character specific as well as shared layers.";
AUTOBAR_CONFIG_SETUPSTANDARDTIP = "Enable editing and use of all layers.";
AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "Clear out all character and shared slots.";
AUTOBAR_CONFIG_RESETSINGLETIP = "Click to reset to the Single Character defaults.";
AUTOBAR_CONFIG_RESETSHAREDTIP = "Click to reset to the Shared Character defaults.\nClass specific slots are copied to the Character layer.\nDefault slots are copied to the Shared layer.";
AUTOBAR_CONFIG_RESETSTANDARDTIP = "Click to reset to the standard defaults.\nClass specific slots are in the Class layer.\nDefault slots are in the Basic layer.\nShared and Character layers are cleared.";

AUTOBAR_TOOLTIP9 = "Multi Category Button\n";
AUTOBAR_TOOLTIP10 = " (Custom Item by ID)";
AUTOBAR_TOOLTIP11 = "\n(Item ID not recognized)";
AUTOBAR_TOOLTIP12 = " (Custom Item by Name)";
AUTOBAR_TOOLTIP13 = "Single Category Button\n\n";
AUTOBAR_TOOLTIP14 = "\nNot directly usable.";
AUTOBAR_TOOLTIP15 = "\nWeapon Target\n(Left click main weapon\nRight click offhand weapon.)";
AUTOBAR_TOOLTIP16 = "\nTargetted.";
AUTOBAR_TOOLTIP17 = "\nNon combat only.";
AUTOBAR_TOOLTIP18 = "\nCombat only.";
AUTOBAR_TOOLTIP19 = "\nLocation: ";
AUTOBAR_TOOLTIP20 = "\nLimited Usage: "
AUTOBAR_TOOLTIP21 = "Require HP restore";
AUTOBAR_TOOLTIP22 = "Require Mana restore";
AUTOBAR_TOOLTIP23 = "Single Item Button\n\n";


---------------------------------------
--  AutoBarItemList.lua
---------------------------------------
AUTOBAR_ALTERACVALLEY = "Alterac Valley";
AUTOBAR_WARSONGGULCH = "Warsong Gulch";
AUTOBAR_ARATHIBASIN = "Arathi Basin";
AUTOBAR_AHN_QIRAJ = "Ahn'Qiraj";
AUTOBAR_BWL = "Blackwing Lair";

AUTOBAR_CLASS_CUSTOM = "Custom";
AUTOBAR_CLASS_CLEAR = "Clear this Slot";
AUTOBAR_CLASS_BANDAGES = "Bandages";
AUTOBAR_CLASS_ALTERAC_BANDAGE = "Alterac Bandages";
AUTOBAR_CLASS_WARSONG_BANDAGE = "Warsong Bandages";
AUTOBAR_CLASS_ARATHI_BANDAGE = "Arathi Bandages";
AUTOBAR_CLASS_UNGORORESTORE = "Un'Goro: Crystal Restore";

AUTOBAR_CLASS_ANTIVENOM = "Anti-Venom";
AUTOBAR_CLASS_AGILITYPOTIONS = "Agility Potions";
AUTOBAR_CLASS_STRENGTHPOTIONS = "Strength Potions";
AUTOBAR_CLASS_FORTITUDEPOTIONS = "Fortitude Potions";
AUTOBAR_CLASS_INTELLECTPOTIONS = "Intellect Potions";
AUTOBAR_CLASS_WISDOMPOTIONS = "Wisdom Potions";
AUTOBAR_CLASS_DEFENSEPOTIONS = "Defense Potions";
AUTOBAR_CLASS_TROLLBLOODPOTIONS = "Troll Blood Potions";
AUTOBAR_CLASS_SCROLLOFAGILITY = "Scroll of Agility";
AUTOBAR_CLASS_SCROLLOFINTELLECT = "Scroll of Intellect";
AUTOBAR_CLASS_SCROLLOFPROTECTION = "Scroll of Protection";
AUTOBAR_CLASS_SCROLLOFSPIRIT = "Scroll of Spirit";
AUTOBAR_CLASS_SCROLLOFSTAMINA = "Scroll of Stamina";
AUTOBAR_CLASS_SCROLLOFSTRENGTH = "Scroll of Strength";
AUTOBAR_CLASS_BUFF_ATTACKPOWER = "Buff Attack Power";
AUTOBAR_CLASS_BUFF_ATTACKSPEED = "Buff Attack Speed";
AUTOBAR_CLASS_BUFF_DODGE = "Buff Dodge";
AUTOBAR_CLASS_BUFF_FROST = "Buff Frost Resistance";
AUTOBAR_CLASS_BUFF_FIRE = "Buff Fire Resistance";

AUTOBAR_CLASS_HEALPOTIONS = "Heal Potions";
AUTOBAR_CLASS_PVP6HEALPOTIONS = "PVP Rank 6 - Heal Potions";
AUTOBAR_CLASS_HEALTHSTONE = "Healthstones";
AUTOBAR_CLASS_WHIPPER_ROOT = "Whipper Root";
AUTOBAR_CLASS_BATTLEGROUNDHEALPOTIONS = "Battleground Heal Potions";
AUTOBAR_CLASS_MANAPOTIONS = "Mana Potions";
AUTOBAR_CLASS_PVP6MANAPOTIONS = "PVP Rank 6 - Mana Potions";
AUTOBAR_CLASS_MANASTONE = "Manastones";
AUTOBAR_CLASS_BATTLEGROUNDMANAPOTIONS = "Battleground Mana Potions";
AUTOBAR_CLASS_DREAMLESS_SLEEP = "Dreamless Sleep";
AUTOBAR_CLASS_NIGHT_DRAGONS_BREATH = "Night Dragon's Breath";
AUTOBAR_CLASS_REJUVENATION_POTIONS = "Rejuvenation Potions";

AUTOBAR_CLASS_BATTLESTANDARD = "Battle Standard";
AUTOBAR_CLASS_BATTLESTANDARDAV = "Battle Standard AV";
AUTOBAR_CLASS_DEMONIC_DARK_RUNES = "Demonic and Dark Runes";
AUTOBAR_CLASS_ARCANE_PROTECTION = "Arcane Protection";
AUTOBAR_CLASS_FIRE_PROTECTION = "Fire Protection";
AUTOBAR_CLASS_FROST_PROTECTION = "Frost Protection";
AUTOBAR_CLASS_NATURE_PROTECTION = "Nature Protection";
AUTOBAR_CLASS_SHADOW_PROTECTION = "Shadow Protection";
AUTOBAR_CLASS_SPELL_PROTECTION = "Spell Protection";
AUTOBAR_CLASS_HOLY_PROTECTION = "Holy Protection";
AUTOBAR_CLASS_INVULNERABILITY_POTIONS = "Invulnerability Potions";
AUTOBAR_CLASS_FREE_ACTION_POTION = "Free Action Potion";

AUTOBAR_CLASS_HEARTHSTONE = "Hearthstone";
AUTOBAR_CLASS_WATER = "Water";
AUTOBAR_CLASS_WATER_PERCENT = "Water: % mana gain";
AUTOBAR_CLASS_WATER_CONJURED = "Water: Mage Conjured";
AUTOBAR_CLASS_WATER_SPIRIT = "Water: Spirit Bonus";
AUTOBAR_CLASS_RAGEPOTIONS = "Rage Potions";
AUTOBAR_CLASS_ENERGYPOTIONS = "Energy Potions";
AUTOBAR_CLASS_SWIFTNESSPOTIONS = "Swiftness Potions";
AUTOBAR_CLASS_SOULSHARDS = "Soul Shards";
AUTOBAR_CLASS_ARROWS = "Arrows";
AUTOBAR_CLASS_BULLETS = "Bullets";
AUTOBAR_CLASS_THROWNWEAPON = "Thrown Weapons";
AUTOBAR_CLASS_FOOD = "Food: No Bonus";
AUTOBAR_CLASS_FOOD_PERCENT = "Food: % health gain";
AUTOBAR_CLASS_FOOD_PET_BREAD = "Food: Pet Bread";
AUTOBAR_CLASS_FOOD_PET_CHEESE = "Food: Pet Cheese";
AUTOBAR_CLASS_FOOD_PET_FISH = "Food: Pet Fish";
AUTOBAR_CLASS_FOOD_PET_FRUIT = "Food: Pet Fruit";
AUTOBAR_CLASS_FOOD_PET_FUNGUS = "Food: Pet Fungus";
AUTOBAR_CLASS_FOOD_PET_MEAT = "Food: Pet Meat";
AUTOBAR_CLASS_FOOD_COMBO= "Food & Water Combo";
AUTOBAR_CLASS_FOOD_CONJURED = "Food: Mage Conjured";
AUTOBAR_CLASS_FOOD_STAMINA = "Food: Stamina Bonus";
AUTOBAR_CLASS_FOOD_AGILITY = "Food: Agility Bonus";
AUTOBAR_CLASS_FOOD_MANAREGEN = "Food: Mana Regen Bonus";
AUTOBAR_CLASS_FOOD_HPREGEN = "Food: HP Regen Bonus";
AUTOBAR_CLASS_FOOD_STRENGTH = "Food: Strength Bonus";
AUTOBAR_CLASS_FOOD_INTELLIGENCE = "Food: Intelligence Bonus";
AUTOBAR_CLASS_FOOD_ARATHI = "Food: Arathi Basin";
AUTOBAR_CLASS_FOOD_WARSONG = "Food: Warsong Gulch";
AUTOBAR_CLASS_SHARPENINGSTONES = "Blacksmith created Sharpening stones";
AUTOBAR_CLASS_WEIGHTSTONE = "Blacksmith created Weight stones";
AUTOBAR_CLASS_POISON_CRIPPLING = "Crippling Poison";
AUTOBAR_CLASS_POISON_DEADLY = "Deadly Poison";
AUTOBAR_CLASS_POISON_INSTANT = "Instant Poison";
AUTOBAR_CLASS_POISON_MINDNUMBING = "Mind-Numbing Poison";
AUTOBAR_CLASS_POISON_WOUND = "Wounding Poison";
AUTOBAR_CLASS_EXPLOSIVES = "Engineering Explosives";
AUTOBAR_CLASS_MOUNTS_TROLL = "Mount: Troll - Raptor";
AUTOBAR_CLASS_MOUNTS_ORC = "Mount: Orc - Wolf";
AUTOBAR_CLASS_MOUNTS_UNDEAD = "Mount: Undead - Skeletal Horse";
AUTOBAR_CLASS_MOUNTS_TAUREN = "Mount: Tauren - Kodo";
AUTOBAR_CLASS_MOUNTS_HUMAN = "Mount: Human - Horse";
AUTOBAR_CLASS_MOUNTS_NIGHTELF = "Mount: Night Elf - Tiger";
AUTOBAR_CLASS_MOUNTS_DWARF = "Mount: Dwarf - Ram";
AUTOBAR_CLASS_MOUNTS_GNOME = "Mount: Gnome - Strider";
AUTOBAR_CLASS_MOUNTS_SPECIAL = "Mount: Special";
AUTOBAR_CLASS_MOUNTS_QIRAJI = "Mount: Qiraji";
AUTOBAR_CLASS_MANA_OIL = "Enchantment Oil: Mana Regen";
AUTOBAR_CLASS_WIZARD_OIL = "Enchantment Oil: Damage/Healing Bonus";
AUTOBAR_CLASS_FISHINGITEMS = "Fishing Items";

end