--[[

	LootLink 3.5: An in-game item database
		copyright 2004 by Telo
	
	- Watches all chat links you see to cache link color and link data
	- Automatically extracts data from items already in or added to your inventory
	- Automatically caches link data from items already in or added to your bank
	- Automatically inspects your target and extracts data for each of their equipped items
	- Automatically gets link data from your auction queries
	- Can perform a fully automatic scan of the entire auction house inventory
	- Stores sell prices for items that you've had in inventory when you've talked to a merchant
	  and displays them in the tooltips for stacks of items that you are looting, stacks of items
	  in your inventory and entries in the LootLink browse window
	- Converts green loot messages into correctly colored item messages if the item is cached
	- Provides a browsable, searchable window that allows you to find any item in the cache
	- Allows you to shift-click items in the browse window to insert links in the chat edit box
	
]]

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------

BINDING_HEADER_LOOTLINK = "LootLink Buttons";
BINDING_NAME_TOGGLELOOTLINK = "Toggle LootLink";
LOOTLINK_TITLE = "LootLink";
LOOTLINK_SEARCH_TITLE = "LootLink Search";
LOOTLINK_TITLE_FORMAT_SINGULAR = "LootLink - 1 item total";
LOOTLINK_TITLE_FORMAT_PLURAL = "LootLink - %d items total";
LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR = "LootLink - 1 item found";
LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL = "LootLink - %d items found";
LOOTLINK_SEARCH_LABEL = "Search...";
LOOTLINK_REFRESH_LABEL = "Refresh";
LOOTLINK_RESET_LABEL = "Reset";
LOOTLINK_AUCTION_SCAN_START = "LootLink: scanning page 1...";
LOOTLINK_AUCTION_PAGE_N = "LootLink: scanning page %d of %d...";
LOOTLINK_AUCTION_SCAN_DONE = "LootLink: auction scanning finished";
LOOTLINK_SELL_PRICE = "Sell price:";
LOOTLINK_SELL_PRICE_N = "Sell price for %d:";
LOOTLINK_SELL_PRICE_EACH = "Sell price, each:";
LOOTLINK_SCHEDULED_AUCTION_SCAN = "LootLink: will perform a full auction scan the next time you talk to an auctioneer.";

LOOTLINK_HELP = "help";			-- must be lowercase; command to display help
LOOTLINK_STATUS = "status";		-- must be lowercase; command to display status
LOOTLINK_AUCTION = "auction";	-- must be lowercase; command to scan auctions
LOOTLINK_SCAN = "scan";			-- must be lowercase; alias for command to scan auctions
LOOTLINK_SHOWINFO = "showinfo";	-- must be lowercase; command to show extra info on tooltips
LOOTLINK_HIDEINFO = "hideinfo";	-- must be lowercase; command to hide extra info on tooltips
LOOTLINK_MAKEHOME = "makehome";	-- must be lowercase; command to make the current server your home
LOOTLINK_RESET = "reset";		-- must be lowercase; command to reset the database
LOOTLINK_LIGHTMODE = "light";	-- must be lowercase; command to disable full-text search, using less memory
LOOTLINK_FULLMODE = "full";		-- must be lowercase; command to enable full-text search, using more memory
LOOTLINK_CONFIRM = "confirm";	-- must be lowercase; confirmation of MAKEHOME, RESET, or LIGHT

LOOTLINK_RESET_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will irreversibly erase all LootLink data.  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_RESET.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_RESET_ABORTED = "|cff00ff00LootLink: Data erase was NOT confirmed and will not be done.|r";
LOOTLINK_RESET_DONE = "|cffffff00LootLink: All data erased.|r";
LOOTLINK_MAKEHOME_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will irreversibly mark all LootLink data that predates multiple server support as having been seen on "..GetCVar("realmName")..".  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_MAKEHOME.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_MAKEHOME_ABORTED = "|cff00ff00LootLink: Home server was NOT confirmed and no changes will be made.|r";
LOOTLINK_MAKEHOME_DONE = "|cffffff00LootLink: Existing data that predated multiple server support was marked as seen on "..GetCVar("realmName")..". Multiple server support is fully enabled.|r";
LOOTLINK_LIGHTMODE_NEEDS_CONFIRM = "|cffff0000LootLink: Warning!  This will disable full-text search, losing known text for all items, but using less memory.  If you really want to do this, use /lootlink or /ll with the following command: "..LOOTLINK_LIGHTMODE.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_LIGHTMODE_ABORTED = "|cff00ff00LootLink: Light mode was NOT confirmed and no changes will be made.|r";
LOOTLINK_LIGHTMODE_DONE = "|cffffff00LootLink: Light mode enabled.  Full-text search is disabled and memory is no longer used for item descriptions.|r";

LOOTLINK_STATUS_HEADER = "|cffffff00LootLink (version %.2f) status:|r";
LOOTLINK_DATA_VERSION = "LootLink: %d items known [%d on %s], data version %.2f";
LOOTLINK_INFO_HIDDEN = "LootLink: extra tooltip information hidden";
LOOTLINK_INFO_SHOWN = "LootLink: extra tooltip information shown";
LOOTLINK_FULL_MODE = "LootLink: full mode; full-text search is enabled";
LOOTLINK_LIGHT_MODE = "LootLink: light mode; full-text search is disabled";

LOOTLINK_HELP_TEXT0 = " ";
LOOTLINK_HELP_TEXT1 = "|cffffff00LootLink command help:|r";
LOOTLINK_HELP_TEXT2 = "|cff00ff00Use |r|cffffffff/lootlink|r|cff00ff00 or |r|cffffffff/ll|r|cff00ff00 without any arguments to toggle the browse window open or closed.|r";
LOOTLINK_HELP_TEXT3 = "|cff00ff00Use |r|cffffffff/lootlink <command>|r|cff00ff00 or |r|cffffffff/ll <command>|r|cff00ff00 to perform the following commands:|r";
LOOTLINK_HELP_TEXT4 = "|cffffffff"..LOOTLINK_HELP.."|r|cff00ff00: displays this message.|r";
LOOTLINK_HELP_TEXT5 = "|cffffffff"..LOOTLINK_STATUS.."|r|cff00ff00: displays status information for data and current options.|r";
LOOTLINK_HELP_TEXT6 = "|cffffffff"..LOOTLINK_AUCTION.."|r|cff00ff00 or |r|cffffffff"..LOOTLINK_SCAN.."|r|cff00ff00: starts or schedules an automatic scan of all items in the auction house.|r";
LOOTLINK_HELP_TEXT7 = "|cffffffff"..LOOTLINK_SHOWINFO.."|r|cff00ff00: shows extra information, including known sell prices, on all tooltips.|r";
LOOTLINK_HELP_TEXT8 = "|cffffffff"..LOOTLINK_HIDEINFO.."|r|cff00ff00: stops showing extra information on tooltips.|r";
LOOTLINK_HELP_TEXT9 = "|cffffffff"..LOOTLINK_FULLMODE.."|r|cff00ff00: enables full-text search. This is the default mode..|r";
LOOTLINK_HELP_TEXT10 = "|cffffffff"..LOOTLINK_LIGHTMODE.."|r|cff00ff00: disables full-text search, using less memory.|r";
LOOTLINK_HELP_TEXT11 = " ";
LOOTLINK_HELP_TEXT12 = "|cff00ff00For example: |r|cffffffff/lootlink scan|r|cff00ff00 will start an auction house scan if the auction window is open.|r";

LOOTLINK_DATA_UPGRADE_HELP_TEXT0 = "|cffffff00LootLink needs action from you to upgrade its data for full multiple server support.  Use one of the following commands to do so:|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT1 = "|cffffffff"..LOOTLINK_MAKEHOME.."|r|cff00ff00: makes the current server your home.  This will mark all existing items that predate multiple server support as having been seen on the current server.|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT2 = "|cffffffff"..LOOTLINK_RESET.."|r|cff00ff00: resets and wipes the existing database.  This is the safest thing to do if you've ever played on more than one server, but you will lose your existing data.|r";

LOOTLINK_DATA_UPGRADE_HELP = {
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT0, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT1, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT2, },
};

LLS_TEXT = "All text:";
LLS_NAME = "Name:";
LLS_RARITY = "Rarity:";
LLS_BINDS = "Binds:";
LLS_UNIQUE = "Is Unique?";
LLS_USABLE = "Usable?";
LLS_LOCATION = "Equip location:";
LLS_MINIMUM_LEVEL = "Minimum level:";
LLS_MAXIMUM_LEVEL = "Maximum level:";
LLS_TYPE = "Type:";
LLS_SUBTYPE_ARMOR = "Armor subtype:";
LLS_SUBTYPE_WEAPON = "Weapon subtype:";
LLS_SUBTYPE_SHIELD = "Shield subtype:";
LLS_SUBTYPE_RECIPE = "Recipe subtype:";
LLS_MINIMUM_DAMAGE = "Min. low damage:";
LLS_MAXIMUM_DAMAGE = "Min. high damage:";
LLS_MAXIMUM_SPEED = "Maximum speed:";
LLS_MINIMUM_DPS = "Minimum DPS:";
LLS_MINIMUM_ARMOR = "Minimum armor:";
LLS_MINIMUM_BLOCK = "Minimum block:";
LLS_MINIMUM_SLOTS = "Minimum slots:";
LLS_MINIMUM_SKILL = "Minimum skill:";
LLS_MAXIMUM_SKILL = "Maximum skill:";
LLS_TEXT_DISABLED = "(full-text search is disabled)";

ANY = "Any";
POOR = "Poor";
COMMON = "Common";
UNCOMMON = "Uncommon";
RARE = "Rare";
EPIC = "Epic";
LEGENDARY = "Legendary";
DOES_NOT = "Does Not";
ON_EQUIP = "On Equip";
ON_PICKUP = "On Pickup";
ON_USE = "On Use";
--ARMOR = "Armor"; -- already in globalstrings
WEAPON = "Weapon";
SHIELD = "Shield";
CONTAINER = "Container";
OTHER = "Other";
RECIPE = "Recipe";
CLOTH = "Cloth";
LEATHER = "Leather";
MAIL = "Mail";
PLATE = "Plate";
AXE = "Axe";
BOW = "Bow";
DAGGER = "Dagger";
MACE = "Mace";
STAFF = "Staff";
SWORD = "Sword";
GUN = "Gun";
WAND = "Wand";
POLEARM = "Polearm";
FIST_WEAPON = "Fist Weapon";
CROSSBOW = "Crossbow";
THROWN = "Thrown";
BUCKLER = "Buckler";
ALCHEMY = "Alchemy";
BLACKSMITHING = "Blacksmithing";
COOKING = "Cooking";
ENCHANTING = "Enchanting";
ENGINEERING = "Engineering";
LEATHERWORKING = "Leatherworking";
TAILORING = "Tailoring";

-- For sorting
SORT_NAME = "Name";
SORT_RARITY = "Rarity";
SORT_BINDS = "Binds";
SORT_UNIQUE = "Unique";
SORT_LOCATION = "Location";
SORT_TYPE = "Type";
SORT_SUBTYPE = "Subtype";
SORT_MINDAMAGE = "Min Damage";
SORT_MAXDAMAGE = "Max Damage";
SORT_SPEED = "Speed";
SORT_DPS = "DPS";
SORT_ARMOR = "Armor";
SORT_BLOCK = "Block";
SORT_SLOTS = "Slots";
SORT_LEVEL = "Level";
SORT_SKILL = "Skill Level";

--------------------------------------------------------------------------------------------------
-- Local LootLink variables
--------------------------------------------------------------------------------------------------

-- Function hooks
local lOriginal_CanSendAuctionQuery;
local lOriginal_AuctionFrameBrowse_OnEvent;
local lOriginal_ContainerFrameItemButton_OnEnter;
local lOriginal_ContainerFrame_Update;
local lOriginal_GameTooltip_SetLootItem;
local lOriginal_GameTooltip_SetOwner;
local lOriginal_GameTooltip_OnHide;
local lOriginal_GameTooltip_ClearMoney;
local lOriginal_GameTooltip_ClearMoney_Temp;
local lOriginal_ShoppingTooltip1_SetMerchantCompareItem;
local lOriginal_ShoppingTooltip2_SetMerchantCompareItem;
local lOriginal_ShoppingTooltip1_SetAuctionCompareItem;
local lOriginal_ShoppingTooltip2_SetAuctionCompareItem;
local lOriginal_SetItemRef;
local lOriginal_OnTooltipAddMoney;

-- If non-nil, kick off a full auction scan next time auctioneer is used
local lScanAuction;

-- Used for scanning inventory items for their sell prices at a merchant
local lBagID;
local lSlotID;

-- If non-nil, don't add extra information to the tooltip on GameTooltip_ClearMoney
local lSuppressInfoAdd;

-- If non-nil, check for appearance of GameTooltip for adding information
local lCheckTooltip;

-- Timer for frequency of tooltip checks
local lCheckTimer = 0;

-- The current owner of the GameTooltip
local lGameToolTipOwner;

-- Cache of auction item information
local lAuctionItemInfo;

-- Used to remember that confirmation is needed of irreversible commands
local lResetNeedsConfirm;
local lMakeHomeNeedsConfirm;
local lLightModeNeedsConfirm;

-- If non-nil, the data version upgrade reminder is not displayed on every /lootlink or /ll command
local lDisableVersionReminder;

-- The current server name and index
local lServer;
local lServerIndex;

-- The number of items in the database, total and for this server
local lItemLinksSizeTotal;
local lItemLinksSizeServer;

local STATE_NAME = 0;
local STATE_BOUND = 1;
local STATE_UNIQUE = 2;
local STATE_LOCATION = 3;
local STATE_TYPE = 4;
local STATE_DAMAGE = 5;
local STATE_DPS = 6;
local STATE_ARMOR = 7;
local STATE_BLOCK = 8;
local STATE_CONTAINER = 9;
local STATE_REQUIRES = 10;
local STATE_FINISH = 11;

local BINDS_DOES_NOT_BIND = 0;
local BINDS_EQUIP = 1;
local BINDS_PICKUP = 2;
local BINDS_USED = 3;

local TYPE_ARMOR = 0;
local TYPE_WEAPON = 1;
local TYPE_SHIELD = 2;
local TYPE_RECIPE = 3;
local TYPE_CONTAINER = 4;
local TYPE_MISC = 5;

local SUBTYPE_ARMOR_CLOTH = 0;
local SUBTYPE_ARMOR_LEATHER = 1;
local SUBTYPE_ARMOR_MAIL = 2;
local SUBTYPE_ARMOR_PLATE = 3;

local lColorSortTable = { };
lColorSortTable["ffff8000"] = 1;	-- legendary, orange
lColorSortTable["ffa335ee"] = 2;	-- epic, purple
lColorSortTable["ff0070dd"] = 3;	-- rare, blue
lColorSortTable["ff1eff00"] = 4;	-- uncommon, green
lColorSortTable["ffffffff"] = 5;	-- common, white
lColorSortTable["ff9d9d9d"] = 6;	-- poor, gray
lColorSortTable["ff40ffc0"] = 100;	-- unknown, teal

local ArmorSubtypes = { };
ArmorSubtypes["Cloth"] = SUBTYPE_ARMOR_CLOTH;
ArmorSubtypes["Leather"] = SUBTYPE_ARMOR_LEATHER;
ArmorSubtypes["Mail"] = SUBTYPE_ARMOR_MAIL;
ArmorSubtypes["Plate"] = SUBTYPE_ARMOR_PLATE;

local SUBTYPE_WEAPON_AXE = 0;
local SUBTYPE_WEAPON_BOW = 1;
local SUBTYPE_WEAPON_DAGGER = 2;
local SUBTYPE_WEAPON_MACE = 3;
-- 4 is available
local SUBTYPE_WEAPON_STAFF = 5;
local SUBTYPE_WEAPON_SWORD = 6;
local SUBTYPE_WEAPON_GUN = 7;
local SUBTYPE_WEAPON_WAND = 8;
local SUBTYPE_WEAPON_THROWN = 9;
local SUBTYPE_WEAPON_POLEARM = 10;
local SUBTYPE_WEAPON_FIST_WEAPON = 11;
local SUBTYPE_WEAPON_CROSSBOW = 12;

local WeaponSubtypes = { };
WeaponSubtypes["Axe"] = SUBTYPE_WEAPON_AXE;
WeaponSubtypes["Bow"] = SUBTYPE_WEAPON_BOW;
WeaponSubtypes["Dagger"] = SUBTYPE_WEAPON_DAGGER;
WeaponSubtypes["Mace"] = SUBTYPE_WEAPON_MACE;
WeaponSubtypes["Staff"] = SUBTYPE_WEAPON_STAFF;
WeaponSubtypes["Sword"] = SUBTYPE_WEAPON_SWORD;
WeaponSubtypes["Gun"] = SUBTYPE_WEAPON_GUN;
WeaponSubtypes["Wand"] = SUBTYPE_WEAPON_WAND;
WeaponSubtypes["Thrown"] = SUBTYPE_WEAPON_THROWN;
WeaponSubtypes["Polearm"] = SUBTYPE_WEAPON_POLEARM;
WeaponSubtypes["Fist Weapon"] = SUBTYPE_WEAPON_FIST_WEAPON;
WeaponSubtypes["Crossbow"] = SUBTYPE_WEAPON_CROSSBOW;

local SUBTYPE_SHIELD_BUCKLER = 0;
local SUBTYPE_SHIELD_SHIELD = 1;

local ShieldSubtypes = { };
ShieldSubtypes["Buckler"] = SUBTYPE_SHIELD_BUCKLER;
ShieldSubtypes["Shield"] = SUBTYPE_SHIELD_SHIELD;

local SUBTYPE_RECIPE_ALCHEMY = 0;
local SUBTYPE_RECIPE_BLACKSMITHING = 1;
local SUBTYPE_RECIPE_COOKING = 2;
local SUBTYPE_RECIPE_ENCHANTING = 3;
local SUBTYPE_RECIPE_ENGINEERING = 4;
local SUBTYPE_RECIPE_LEATHERWORKING = 5;
local SUBTYPE_RECIPE_TAILORING = 6;
local SUBTYPE_RECIPE_FIRST_AID = 7;
local SUBTYPE_RECIPE_FISHING = 8;

local RecipeSubtypes = { };
RecipeSubtypes["Alchemy"] = SUBTYPE_RECIPE_ALCHEMY;
RecipeSubtypes["Blacksmithing"] = SUBTYPE_RECIPE_BLACKSMITHING;
RecipeSubtypes["Cooking"] = SUBTYPE_RECIPE_COOKING;
RecipeSubtypes["Enchanting"] = SUBTYPE_RECIPE_ENCHANTING;
RecipeSubtypes["Engineering"] = SUBTYPE_RECIPE_ENGINEERING;
RecipeSubtypes["Leatherworking"] = SUBTYPE_RECIPE_LEATHERWORKING;
RecipeSubtypes["Tailoring"] = SUBTYPE_RECIPE_TAILORING;
RecipeSubtypes["First Aid"] = SUBTYPE_RECIPE_FIRST_AID;
RecipeSubtypes["Fishing"] = SUBTYPE_RECIPE_FISHING;

local lTypeAndSubtypeToSkill = { };
lTypeAndSubtypeToSkill[TYPE_ARMOR] = { };
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_CLOTH] = "Cloth";
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_LEATHER] = "Leather";
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_MAIL] = "Mail";
lTypeAndSubtypeToSkill[TYPE_ARMOR][SUBTYPE_ARMOR_PLATE] = "Plate Mail";
lTypeAndSubtypeToSkill[TYPE_WEAPON] = { };
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE] = { }
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE][0] = "Axes";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_AXE][1] = "Two-Handed Axes";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_BOW] = "Bows";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_DAGGER] = "Daggers";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE] = { }
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE][0] = "Maces";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_MACE][1] = "Two-Handed Maces";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_STAFF] = "Staves";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD] = { };
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD][0] = "Swords";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_SWORD][1] = "Two-Handed Swords";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_GUN] = "Guns";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_WAND] = "Wands";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_THROWN] = "Thrown";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_POLEARM] = "Polearms";		--@todo Telo: unconfirmed
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_FIST_WEAPON] = "Unarmed";
lTypeAndSubtypeToSkill[TYPE_WEAPON][SUBTYPE_WEAPON_CROSSBOW] = "Crossbows";
lTypeAndSubtypeToSkill[TYPE_SHIELD] = { };
lTypeAndSubtypeToSkill[TYPE_SHIELD][SUBTYPE_SHIELD_BUCKLER] = "Shield";			--@todo Telo: deprecated subtype, should remove
lTypeAndSubtypeToSkill[TYPE_SHIELD][SUBTYPE_SHIELD_SHIELD] = "Shield";
lTypeAndSubtypeToSkill[TYPE_RECIPE] = { };
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ALCHEMY] = "Alchemy";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_BLACKSMITHING] = "Blacksmithing";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_COOKING] = "Cooking";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ENCHANTING] = "Enchanting";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_ENGINEERING] = "Engineering";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_LEATHERWORKING] = "Leatherworking";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_TAILORING] = "Tailoring";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_FIRST_AID] = "First Aid";
lTypeAndSubtypeToSkill[TYPE_RECIPE][SUBTYPE_RECIPE_FISHING] = "Fishing";

local LocationTypes = { };
LocationTypes["Held In Off-hand"]		= { i = 0, type = TYPE_MISC };
LocationTypes["Back"]					= { i = 1, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["One-Hand"]				= { i = 2, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes["Two-Hand"]				= { i = 3, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes["Off Hand"]				= { i = 4, type = TYPE_SHIELD, subtypes = ShieldSubtypes };
LocationTypes["Wrist"]					= { i = 5, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Chest"]					= { i = 6, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Legs"]					= { i = 7, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Feet"]					= { i = 8, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Shirt"]					= { i = 9, type = TYPE_MISC };
LocationTypes["Ranged"]					= { i = 10, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes["Main Hand"]				= { i = 11, type = TYPE_WEAPON, subtypes = WeaponSubtypes };
LocationTypes["Waist"]					= { i = 12, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Head"]					= { i = 13, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Gun"]					= { i = 14, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_GUN };
LocationTypes["Finger"]					= { i = 15, type = TYPE_MISC };
LocationTypes["Hands"]					= { i = 16, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Shoulder"]				= { i = 17, type = TYPE_ARMOR, subtypes = ArmorSubtypes };
LocationTypes["Wand"]					= { i = 18, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_WAND };
LocationTypes["Trinket"]				= { i = 19, type = TYPE_MISC };
LocationTypes["Tabard"]					= { i = 20, type = TYPE_MISC };
LocationTypes["Neck"]					= { i = 21, type = TYPE_MISC };
LocationTypes["Thrown"]					= { i = 22, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_THROWN };
LocationTypes["Crossbow"]				= { i = 23, type = TYPE_WEAPON, subtype = SUBTYPE_WEAPON_CROSSBOW };

local INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" },
	{ name = "NeckSlot" },
	{ name = "ShoulderSlot" },
	{ name = "BackSlot" },
	{ name = "ChestSlot" },
	{ name = "ShirtSlot" },
	{ name = "TabardSlot" },
	{ name = "WristSlot" },
	{ name = "HandsSlot" },
	{ name = "WaistSlot" },
	{ name = "LegsSlot" },
	{ name = "FeetSlot" },
	{ name = "Finger0Slot" },
	{ name = "Finger1Slot" },
	{ name = "Trinket0Slot" },
	{ name = "Trinket1Slot" },
	{ name = "MainHandSlot" },
	{ name = "SecondaryHandSlot" },
	{ name = "RangedSlot" },
};

local ChatMessageTypes = {
	"CHAT_MSG_SYSTEM",
	"CHAT_MSG_SAY",
	"CHAT_MSG_TEXT_EMOTE",
	"CHAT_MSG_YELL",
	"CHAT_MSG_WHISPER",
	"CHAT_MSG_PARTY",
	"CHAT_MSG_GUILD",
	"CHAT_MSG_OFFICER",
	"CHAT_MSG_CHANNEL",
	"CHAT_MSG_RAID",
	"CHAT_MSG_LOOT",
};

local LOOTLINK_DROPDOWN_LIST = {
	{ name = SORT_NAME, sortType = "name" },
	{ name = SORT_RARITY, sortType = "rarity" },
	{ name = SORT_LOCATION, sortType = "location" },
	{ name = SORT_TYPE, sortType = "type" },
	{ name = SORT_SUBTYPE, sortType = "subtype" },
	{ name = SORT_LEVEL, sortType = "level" },
	{ name = SORT_BINDS, sortType = "binds" },
	{ name = SORT_UNIQUE, sortType = "unique" },
	{ name = SORT_ARMOR, sortType = "armor" },
	{ name = SORT_BLOCK, sortType = "block" },
	{ name = SORT_MINDAMAGE, sortType = "minDamage" },
	{ name = SORT_MAXDAMAGE, sortType = "maxDamage" },
	{ name = SORT_DPS, sortType = "DPS" },
	{ name = SORT_SPEED, sortType = "speed" },
	{ name = SORT_SLOTS, sortType = "slots" },
	{ name = SORT_SKILL, sortType = "skill" }
};

local LLS_RARITY_LIST = {
	{ name = ANY, value = nil },
	{ name = POOR, value = "ff9d9d9d", r = 157 / 255, g = 157 / 255, b = 157 / 255 },
	{ name = COMMON, value = "ffffffff", r = 1, g = 1, b = 1 },
	{ name = UNCOMMON, value = "ff1eff00", r = 30 / 255, g = 1, b = 0 },
	{ name = RARE, value = "ff0070dd", r = 0, g = 70 / 255, b = 221 / 255 },
	{ name = EPIC, value = "ffa335ee", r = 163 / 255, g = 53 / 255, b = 238 / 255 },
	{ name = LEGENDARY, value = "ffff8000", r = 1, g = 128 / 255, b = 0 },
};

local LLS_BINDS_LIST = {
	{ name = ANY, value = nil },
	{ name = DOES_NOT, value = BINDS_DOES_NOT_BIND },
	{ name = ON_EQUIP, value = BINDS_EQUIP },
	{ name = ON_PICKUP, value = BINDS_PICKUP },
	{ name = ON_USE, value = BINDS_USE },
};

local LLS_TYPE_LIST = {
	{ name = ANY, value = nil },
	{ name = ARMOR, value = TYPE_ARMOR },
	{ name = CONTAINER, value = TYPE_CONTAINER },
	{ name = OTHER, value = TYPE_MISC },
	{ name = RECIPE, value = TYPE_RECIPE },
	{ name = SHIELD, value = TYPE_SHIELD },
	{ name = WEAPON, value = TYPE_WEAPON },
};

local LLS_SUBTYPE_ARMOR_LIST = {
	{ name = ANY, value = nil },
	{ name = CLOTH, value = SUBTYPE_ARMOR_CLOTH },
	{ name = LEATHER, value = SUBTYPE_ARMOR_LEATHER },
	{ name = MAIL, value = SUBTYPE_ARMOR_MAIL },
	{ name = PLATE, value = SUBTYPE_ARMOR_PLATE },
};

local LLS_SUBTYPE_WEAPON_LIST = {
	{ name = ANY, value = nil },
	{ name = AXE, value = SUBTYPE_WEAPON_AXE },
	{ name = BOW, value = SUBTYPE_WEAPON_BOW },
	{ name = CROSSBOW, value = SUBTYPE_WEAPON_CROSSBOW },
	{ name = DAGGER, value = SUBTYPE_WEAPON_DAGGER },
	{ name = FIST_WEAPON, value = SUBTYPE_WEAPON_FIST_WEAPON },
	{ name = GUN, value = SUBTYPE_WEAPON_GUN },
	{ name = MACE, value = SUBTYPE_WEAPON_MACE },
	{ name = POLEARM, value = SUBTYPE_WEAPON_POLEARM },
	{ name = STAFF, value = SUBTYPE_WEAPON_STAFF },
	{ name = SWORD, value = SUBTYPE_WEAPON_SWORD },
	{ name = THROWN, value = SUBTYPE_WEAPON_THROWN },
	{ name = WAND, value = SUBTYPE_WEAPON_WAND },
};

local LLS_SUBTYPE_SHIELD_LIST = {
	{ name = ANY, value = nil },
	{ name = BUCKLER, value = SUBTYPE_SHIELD_BUCKLER },
	{ name = SHIELD, value = SUBTYPE_SHIELD_SHIELD },
};

local LLS_SUBTYPE_RECIPE_LIST = {
	{ name = ANY, value = nil },
	{ name = ALCHEMY, value = SUBTYPE_RECIPE_ALCHEMY },
	{ name = BLACKSMITHING, value = SUBTYPE_RECIPE_BLACKSMITHING },
	{ name = COOKING, value = SUBTYPE_RECIPE_COOKING },
	{ name = ENCHANTING, value = SUBTYPE_RECIPE_ENCHANTING },
	{ name = ENGINEERING, value = SUBTYPE_RECIPE_ENGINEERING },
	{ name = LEATHERWORKING, value = SUBTYPE_RECIPE_LEATHERWORKING },
	{ name = TAILORING, value = SUBTYPE_RECIPE_TAILORING },
};

local LLS_LOCATION_LIST = {
	{ name = "Any", },
	{ name = "None", },
	{ name = "Back", },
	{ name = "Chest", },
	{ name = "Crossbow", },
	{ name = "Feet", },
	{ name = "Finger", },
	{ name = "Hands", },
	{ name = "Head", },
	{ name = "Held In Off-hand", },
	{ name = "Gun", },
	{ name = "Legs", },
	{ name = "Main Hand", },
	{ name = "Neck", },
	{ name = "Off Hand", },
	{ name = "One-Hand", },
	{ name = "Ranged", },
	{ name = "Shirt", },
	{ name = "Shoulder", },
	{ name = "Tabard", },
	{ name = "Thrown", },
	{ name = "Trinket", },
	{ name = "Two-Hand", },
	{ name = "Waist", },
	{ name = "Wand", },
	{ name = "Wrist", },
};

local lMagicCharacters = { };
lMagicCharacters["^"] = 1;
lMagicCharacters["$"] = 1;
lMagicCharacters["("] = 1;
lMagicCharacters[")"] = 1;
lMagicCharacters["%"] = 1;
lMagicCharacters["."] = 1;
lMagicCharacters["["] = 1;
lMagicCharacters["]"] = 1;
lMagicCharacters["*"] = 1;
lMagicCharacters["+"] = 1;
lMagicCharacters["-"] = 1;
lMagicCharacters["?"] = 1;

local lBankBagIDs = { BANK_CONTAINER, 5, 6, 7, 8, 9, 10, };


--------------------------------------------------------------------------------------------------
-- Global LootLink variables
--------------------------------------------------------------------------------------------------

LOOTLINK_VERSION = 350;	-- version 3.50

LOOTLINK_ITEM_HEIGHT = 16;
LOOTLINK_ITEMS_SHOWN = 23;

UIPanelWindows["LootLinkFrame"] =		{ area = "left",	pushable = 11,	whileDead = 1 };
UIPanelWindows["LootLinkSearchFrame"] =	{ area = "center",	pushable = 0,	whileDead = 1 };

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

--
-- Functions with no other functional dependencies
--

local function LootLink_MakeIntFromHexString(str)
	local remain = str;
	local amount = 0;
	while( remain ~= "" ) do
		amount = amount * 16;
		local byteVal = string.byte(strupper(strsub(remain, 1, 1)));
		if( byteVal >= string.byte("0") and byteVal <= string.byte("9") ) then
			amount = amount + (byteVal - string.byte("0"));
		elseif( byteVal >= string.byte("A") and byteVal <= string.byte("F") ) then
			amount = amount + 10 + (byteVal - string.byte("A"));
		end
		remain = strsub(remain, 2);
	end
	return amount;
end

local function LootLink_GetRGBFromHexColor(hexColor)
	local red = LootLink_MakeIntFromHexString(strsub(hexColor, 3, 4)) / 255;
	local green = LootLink_MakeIntFromHexString(strsub(hexColor, 5, 6)) / 255;
	local blue = LootLink_MakeIntFromHexString(strsub(hexColor, 7, 8)) / 255;
	return red, green, blue;
end

local function LootLink_MouseIsOver(frame)
	local x, y = GetCursorPosition();
	
	if( not frame ) then
		return nil;
	end
	
	x = x / frame:GetEffectiveScale();
	y = y / frame:GetEffectiveScale();

	local left = frame:GetLeft();
	local right = frame:GetRight();
	local top = frame:GetTop();
	local bottom = frame:GetBottom();
	
	if( not left or not right or not top or not bottom ) then
		return nil;
	end
	
	if( (x > left and x < right) and (y > bottom and y < top) ) then
		return 1;
	else
		return nil;
	end
end

local function LootLink_GetDataVersion()
	if( not LootLinkState or not LootLinkState.DataVersion ) then
		return 0;
	end
	return LootLinkState.DataVersion;
end

local function LootLink_SetDataVersion(version)
	if( not LootLinkState ) then
		LootLinkState = { };
	end
	if( not LootLinkState.DataVersion or LootLinkState.DataVersion < version ) then
		LootLinkState.DataVersion = version;
	end
end

local function LootLink_AddServer(name)
	if( not LootLinkState ) then
		LootLinkState = { };
	end
	
	if( not LootLinkState.Servers ) then
		LootLinkState.Servers = 0;
		LootLinkState.ServerNamesToIndices = { };
	end
	
	if( not LootLinkState.ServerNamesToIndices[name] ) then
		LootLinkState.ServerNamesToIndices[name] = LootLinkState.Servers;
		LootLinkState.Servers = LootLinkState.Servers + 1;
	end
	
	return LootLinkState.ServerNamesToIndices[name];
end

local function LootLink_ConvertServerFormat(item)
	if( item.servers ) then
		local i, v;
		local list;
		for i, v in item.servers do
			if( not list ) then
				list = TEXT(i);
			else
				list = list.." "..i;
			end
		end
		item.s = list;
		item.servers = nil;
	end
end

local function LootLink_CheckItemServerRaw(item, serverIndex)
	if( not item.s ) then
		return nil;
	end
	
	local server;
	for server in string.gfind(item.s, "(%d+)") do
		if( tonumber(server) == serverIndex ) then
			return 1;
		end
	end

	return nil;
end

local function LootLink_AddItemServer(item, serverIndex)
	if( not item.s ) then
		item.s = TEXT(serverIndex);
	elseif( not LootLink_CheckItemServerRaw(item, serverIndex) ) then
		item.s = item.s.." "..serverIndex;
	end
end

local function LootLink_EscapeString(string)
	return string.gsub(string, "\"", "\\\"");
end

local function LootLink_UnescapeString(string)
	return string.gsub(string, "\\\"", "\"");
end

local function LootLink_EscapePattern(string)
	local result = "";
	local remain = string;
	local char;
	
	while( remain ~= "" ) do
		char = strsub(remain, 1, 1);
		if( lMagicCharacters[char] ) then
			result = result.."%"..char;
		else
			result = result..char;
		end
		remain = strsub(remain, 2);
	end
	
	return result;
end

local function LootLink_CheckNumeric(string)
	local remain = string;
	local hasNumber;
	local hasPeriod;
	local char;
	
	while( remain ~= "" ) do
		char = strsub(remain, 1, 1);
		if( char >= "0" and char <= "9" ) then
			hasNumber = 1;
		elseif( char == "." and not hasPeriod ) then
			hasPeriod = 1;
		else
			return nil;
		end
		remain = strsub(remain, 2);
	end
	
	return hasNumber;
end

local function LootLink_NameFromLink(link)
	local name;
	if( not link ) then
		return nil;
	end
	for name in string.gfind(link, "|c%x+|Hitem:%d+:%d+:%d+:%d+|h%[(.-)%]|h|r") do
		return name;
	end
	return nil;
end

local function LootLink_MoneyToggle()
	if( lOriginal_GameTooltip_ClearMoney_Temp ) then
		GameTooltip_ClearMoney = lOriginal_GameTooltip_ClearMoney_Temp;
		lOriginal_GameTooltip_ClearMoney_Temp = nil;
	else
		lOriginal_GameTooltip_ClearMoney_Temp = GameTooltip_ClearMoney;
		GameTooltip_ClearMoney = LootLink_GameTooltip_ClearMoney_Temp;
	end
end

local function LootLink_MatchType(left, right)
	local lt = LocationTypes[left];
	local _type;
	local subtype;
	
	if( lt ) then
		local subtypes;
		
		-- Check for weapon override of base type
		if( WeaponSubtypes[right] ) then
			_type = TYPE_WEAPON;
			subtypes = WeaponSubtypes;
		else
			_type = lt.type;
			subtypes = lt.subtypes;
		end
		
		if( subtypes ) then
			subtype = subtypes[right];
		else
			subtype = lt.subtype;
		end
		return nil, lt.i, _type, subtype;
	end
	
	return 1, nil, TYPE_MISC, nil;
end

local function LootLink_HideTooltipMoney()
	LootLinkTooltipMoneyFrame:SetPoint("LEFT", "LootLinkTooltipTextLeft1", "LEFT", 0, 0);
	LootLinkTooltipMoneyFrame:Hide();
end

local function LootLink_SetTooltipMoney(frame, count, money, stack)
	if( count and count > 1 ) then
		money = money * count;
		frame:AddLine(format(LOOTLINK_SELL_PRICE_N, count), 1.0, 1.0, 1.0);
	elseif( stack ) then
		frame:AddLine(LOOTLINK_SELL_PRICE_EACH, 1.0, 1.0, 1.0);
	else
		frame:AddLine(LOOTLINK_SELL_PRICE, 1.0, 1.0, 1.0);
	end
	
	local numLines = frame:NumLines();
	local moneyFrame = getglobal(frame:GetName().."MoneyFrame");
	local newLine = frame:GetName().."TextLeft"..numLines;
	
	moneyFrame:SetPoint("LEFT", newLine, "RIGHT", 4, 0);
	moneyFrame:Show();
	MoneyFrame_Update(moneyFrame:GetName(), money);
	frame:SetMinimumWidth(moneyFrame:GetWidth() + getglobal(newLine):GetWidth() - 10);
end

local function LL_SearchData(item, tag)
	if( item.d ) then
		local s, e;
		local value;

		s, e, value = string.find(item.d, tag.."(.-)·")
		if( value ) then
			return tonumber(value);
		end
	end
	return nil;
end

--
-- Functions that are dependent on preceding local functions, ordered appropriately
--

local function LootLink_InitSizes(serverIndex)
	local index;
	local value;

	lItemLinksSizeTotal = 0;
	lItemLinksSizeServer = 0;
	
	for index, value in ItemLinks do
		lItemLinksSizeTotal = lItemLinksSizeTotal + 1;
		if( LootLink_CheckItemServer(value, serverIndex) ) then
			lItemLinksSizeServer = lItemLinksSizeServer + 1;
		end
	end
end

local function LootLink_GetSize(serverIndex)
	if( not serverIndex ) then
		return lItemLinksSizeTotal;
	end
	return lItemLinksSizeServer;
end

local function LootLink_Status()
	DEFAULT_CHAT_FRAME:AddMessage(format(LOOTLINK_STATUS_HEADER, LOOTLINK_VERSION / 100));
	if( LootLinkState ) then
		DEFAULT_CHAT_FRAME:AddMessage(format(LOOTLINK_DATA_VERSION, LootLink_GetSize(), LootLink_GetSize(lServerIndex), lServer, LootLink_GetDataVersion() / 100));
		if( LootLinkState.HideInfo ) then
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_HIDDEN);
		else
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_SHOWN);
		end
		if( LootLinkState.LightMode ) then
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHT_MODE);
		else
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_FULL_MODE);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_INFO_SHOWN);
	end
	if( lScanAuction ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_SCHEDULED_AUCTION_SCAN);
	end
end

local function LootLink_GetHyperlink(name)
	local itemLink = ItemLinks[name];
	if( itemLink and itemLink.i and LootLink_CheckItemServer(itemLink, lServerIndex) ) then
		-- Remove instance-specific data that we captured from the link we return
		local item = string.gsub(itemLink.i, "(%d+):(%d+):(%d+):(%d+)", "%1:0:%3:%4");
		return "item:"..item;
	end
	return nil;
end

local function LootLink_GetLink(name)
	local itemLink = ItemLinks[name];
	if( itemLink and itemLink.c and itemLink.i and LootLink_CheckItemServer(itemLink, lServerIndex) ) then
		local link = "|c"..itemLink.c.."|H"..LootLink_GetHyperlink(name).."|h["..name.."]|h|r";
		return link;
	end
	return nil;
end

local function LootLink_BuildSearchData(name, value)
	local itemLink;
	local state = STATE_NAME;
	local loop;
	local index;
	local field;
	local left;
	local right;
	local iStart;
	local iEnd;
	local val1;
	local val2;
	local val3;
	local foundRequires;
	local _type;
	local subtype;
	
	value.d = "";
	if( not LootLinkState.LightMode ) then
		value.t = "";
	end
	
	itemLink = LootLink_GetHyperlink(name);
	if( not itemLink ) then
		return nil;
	end
	
	-- This is the only place the tooltip hyperlink is set directly, therefore
	-- this should only be called when we know that the tooltip will be valid

	-- Protect money frame while we set hidden tooltip
	LootLink_MoneyToggle();
	LLHiddenTooltip:SetHyperlink(itemLink);
	LootLink_MoneyToggle();
	
	for index = 1, 30, 1 do
		field = getglobal("LLHiddenTooltipTextLeft"..index);
		if( field and field:IsShown() ) then
			left = field:GetText();
		else
			left = nil;
		end
		
		field = getglobal("LLHiddenTooltipTextRight"..index);
		if( field and field:IsShown() ) then
			right = field:GetText();
		else
			right = nil;
		end
		
		if( left ) then
			if( not LootLinkState.LightMode ) then
				value.t = value.t..left.."·";
			end
		else
			left = "";
		end
		if( right ) then
			if( not LootLinkState.LightMode ) then
				value.t = value.t..right.."·";
			end
		else
			right = "";
		end
		
		loop = 1;
		while( loop ) do
			if( state == STATE_NAME ) then
				state = STATE_BOUND;
				loop = nil;
			elseif( state == STATE_BOUND ) then
				iStart, iEnd, val1 = string.find(left, "Binds when (.+)");
				if( val1 ) then
					if( val1 == "equipped" ) then
						value.d = value.d.."bi"..BINDS_EQUIP.."·";
					elseif( val1 == "picked up" ) then
						value.d = value.d.."bi"..BINDS_PICKUP.."·";
					elseif( val1 == "used" ) then
						value.d = value.d.."bi"..BINDS_USED.."·";
					end
					loop = nil;
				else
					value.d = value.d.."bi"..BINDS_DOES_NOT_BIND.."·";
				end
				state = STATE_UNIQUE;
			elseif( state == STATE_UNIQUE ) then
				if( string.find(left, "Unique") ) then
					value.d = value.d.."un1·";
					loop = nil;
				end
				state = STATE_LOCATION;
			elseif( state == STATE_LOCATION ) then
				local location;
				loop, location, _type, subtype = LootLink_MatchType(left, right);
				if( location ) then
					value.d = value.d.."lo"..location.."·";
				end
				if( _type == TYPE_WEAPON ) then
					state = STATE_DAMAGE;
				elseif( _type == TYPE_ARMOR or _type == TYPE_SHIELD ) then
					state = STATE_ARMOR;
				else
					state = STATE_CONTAINER;
				end
			elseif( state == STATE_DAMAGE ) then
				iStart, iEnd, val1, val2 = string.find(left, "(%d+) %- (%d+) Damage");
				if( val1 and val2 ) then
					value.d = value.d.."mi"..val1.."·ma"..val2.."·";
				end
				iStart, iEnd, val1 = string.find(right, "Speed (.+)");
				if( val1 ) then
					value.d = value.d.."sp"..val1.."·";
				end
				state = STATE_DPS;
				loop = nil;
			elseif( state == STATE_DPS ) then
				iStart, iEnd, val1 = string.find(left, "%((.+) damage per second%)");
				if( val1 ) then
					value.d = value.d.."dp"..val1.."·";
				end
				state = STATE_REQUIRES;
				loop = nil;
			elseif( state == STATE_ARMOR ) then
				iStart, iEnd, val1 = string.find(left, "(%d+) Armor");
				if( val1 ) then
					value.d = value.d.."ar"..val1.."·";
				end
				if( _type == TYPE_SHIELD ) then
					state = STATE_BLOCK;
				else
					state = STATE_REQUIRES;
				end
				loop = nil;
			elseif( state == STATE_BLOCK ) then
				iStart, iEnd, val1 = string.find(left, "(%d+) Block");
				if( val1 ) then
					value.d = value.d.."bl"..val1.."·";
				end
				state = STATE_REQUIRES;
				loop = nil;
			elseif( state == STATE_CONTAINER ) then
				iStart, iEnd, val1 = string.find(left, "(%d+) Slot Container");
				if( val1 ) then
					_type = TYPE_CONTAINER;
					value.d = value.d.."sl"..val1.."·";
					loop = nil;
				end
				state = STATE_REQUIRES;
			elseif( state == STATE_REQUIRES ) then
				iStart, iEnd, val1 = string.find(left, "Requires (.+)");
				if( val1 ) then
					foundRequires = 1;
					loop = nil;
					iStart, iEnd, val2 = string.find(val1, "Level (%d+)");
					if( val2 ) then
						value.d = value.d.."le"..val2.."·";
					else
						iStart, iEnd, val2, val3 = string.find(val1, "(.+) %((%d+)%)");
						if( val2 and val3 ) then
							val1 = RecipeSubtypes[val2];
							if( val1 and _type == TYPE_MISC ) then
								_type = TYPE_RECIPE;
								subtype = val1;
								value.d = value.d.."sk"..val3.."·";
							end
						end
					end
				else
					if( foundRequires ) then
						state = STATE_FINISH;
					else
						loop = nil;
					end
				end
			elseif( state == STATE_FINISH ) then
				loop = nil;
			end
		end
	end

	if( _type ) then
		value.d = value.d.."ty".._type.."·";
	end
	if( subtype ) then
		value.d = value.d.."su"..subtype.."·";
	end
	
	return 1;
end

local function BuildUsabilityData(data)
	local nSkills;
	local iSkill;
	local HeaderData = { };
	local name, header, isExpanded, rank;
	local Collapse = { };
	local nToCollapse = 0;
	local iCollapse;

	data.class = UnitClass("player");
	data.race = UnitRace("player");
	data.level = UnitLevel("player");
	data.skills = { };
	
	-- We need to expand all of the skills, but first want to save off their state
	nSkills = GetNumSkillLines();
	for iSkill = 1, nSkills do
		local name, header, isExpanded, rank = GetSkillLineInfo(iSkill);
		if( header and not isExpanded ) then
			-- Since we don't know the final index for this item yet, we'll store it by name
			HeaderData[name] = 0;
		end
	end
	
	-- Now expand everything and save off our known skills
	ExpandSkillHeader(0);
	nSkills = GetNumSkillLines()
	for iSkill = 1, nSkills do
		local name, header, isExpanded, rank = GetSkillLineInfo(iSkill);
		if( not header ) then
			data.skills[name] = rank;
		elseif( HeaderData[name] ) then
			-- We now know the final index for this header item
			HeaderData[name] = iSkill;
		end
	end
	
	-- Finally, return the skills page to its original state
	for name, iSkill in HeaderData do
		Collapse[nToCollapse + 1] = iSkill;
		nToCollapse = nToCollapse + 1;
	end
	if( nToCollapse > 0 ) then
		table.sort(Collapse);
		for iCollapse = nToCollapse, 1, -1 do
			CollapseSkillHeader(Collapse[iCollapse]);
		end
	end
end

local function LootLink_GetSkillRank(ud, _type, subtype, location)
	local entry = lTypeAndSubtypeToSkill[_type][subtype];
	
	if( type(entry) == "table" ) then
		-- Two-handed vs. One-handed weapon
		if( location ) then
			if( location == 3 ) then
				return ud.skills[entry[1]];
			else
				return ud.skills[entry[0]];
			end
		else
			return nil;
		end
	else
		-- Everything else
		return ud.skills[entry];
	end
end

local function LootLink_SetHyperlink(tooltip, name, link)
	-- If the link isn't in the local cache, it may not be valid
	if( not GetItemInfo(link) ) then
		-- To avoid disconnects, we'll create our own lame tooltip for these
		local value = ItemLinks[name];
		if( value ) then
			local extraSkip = 0;
			local lines = 1;
			local usabilityData;
			
			-- Name, in rarity color
			tooltip:SetText("|c"..value.c..name.."|r");
			
			-- Binds on equip, binds on pickup
			local binds = LL_SearchData(value, "bi");
			if( binds == BINDS_EQUIP ) then
				tooltip:AddLine("Binds when equipped", 1, 1, 1);
				lines = lines + 1;
			elseif( binds == BINDS_PICKUP ) then
				tooltip:AddLine("Binds when picked up", 1, 1, 1);
				lines = lines + 1;
			elseif( binds == BINDS_USED ) then
				tooltip:AddLine("Binds when used", 1, 1, 1);
				lines = lines + 1;
			end
			
			-- Unique?
			local unique = LL_SearchData(value, "un");
			if( unique ) then
				tooltip:AddLine("Unique", 1, 1, 1);
				lines = lines + 1;
			end
			
			local _type = LL_SearchData(value, "ty");
			local subtype = LL_SearchData(value, "su");

			-- Equip location and type/subtype
			local location = LL_SearchData(value, "lo");
			if( location ) then
				local subtypes;
				local name;
				for i, v in LocationTypes do
					if( v.i == location ) then
						name = i;
						subtypes = v.subtypes;
						break;
					end
				end
				if( name ) then
					tooltip:AddLine(name, 1, 1, 1);
					lines = lines + 1;
					if( subtype ) then
						if( _type == TYPE_WEAPON ) then
							subtypes = WeaponSubtypes;
						end
						if( subtypes ) then
							for i, v in subtypes do
								if( v == subtype ) then
									if( i == name ) then
										local line = getglobal(tooltip:GetName().."TextLeft"..lines);
										
										if( not usabilityData ) then
											usabilityData = { };
											BuildUsabilityData(usabilityData);
										end
										if( not LootLink_GetSkillRank(usabilityData, _type, subtype, location) ) then
											line:SetTextColor(1, 0, 0);
										end
									else
										local line = getglobal(tooltip:GetName().."TextRight"..lines);
										line:SetText(i);

										if( not usabilityData ) then
											usabilityData = { };
											BuildUsabilityData(usabilityData);
										end
										if( LootLink_GetSkillRank(usabilityData, _type, subtype, location) ) then
											line:SetTextColor(1, 1, 1);
										else
											line:SetTextColor(1, 0, 0);
										end
										
										line:Show();
										extraSkip = extraSkip + 1;
										break;
									end
								end
							end
						end
					end
				end
			end
			
			-- Now do type specific data
			if( _type == TYPE_ARMOR ) then
				local armor = LL_SearchData(value, "ar");
				if( armor ) then
					tooltip:AddLine(armor.." Armor", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_WEAPON ) then
				local min = LL_SearchData(value, "mi");
				local max = LL_SearchData(value, "ma");
				local speed = LL_SearchData(value, "sp");
				local dps = LL_SearchData(value, "dp");
				
				if( min and max ) then
					tooltip:AddLine(min.." - "..max.." Damage", 1, 1, 1);
					lines = lines + 1;
					if( speed ) then
						local line = getglobal(tooltip:GetName().."TextRight"..lines);
						line:SetText(format("Speed %.2f", tonumber(speed)));
						line:SetTextColor(1, 1, 1);
						line:Show();
						extraSkip = extraSkip + 1;
					end
				end
				if( dps ) then
					tooltip:AddLine("("..dps.." damage per second)", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_SHIELD ) then
				local armor = LL_SearchData(value, "ar");
				local block = LL_SearchData(value, "bl");
				if( armor ) then
					tooltip:AddLine(armor.." Armor", 1, 1, 1);
					lines = lines + 1;
				end
				if( block ) then
					tooltip:AddLine(block.." Block", 1, 1, 1);
					lines = lines + 1;
				end
			elseif( _type == TYPE_RECIPE ) then
				local skill = LL_SearchData(value, "sk");
				if( skill and subtype ) then
					for i, v in RecipeSubtypes do
						if( v == subtype ) then
							if( not usabilityData ) then
								usabilityData = { };
								BuildUsabilityData(usabilityData);
							end
							local rank = LootLink_GetSkillRank(usabilityData, _type, subtype, location);
							if( not rank or rank < skill ) then
								tooltip:AddLine("Requires "..i.." ("..skill..")", 1, 0, 0);
							else
								tooltip:AddLine("Requires "..i.." ("..skill..")", 1, 1, 1);
							end
							lines = lines + 1;
							break;
						end
					end
				end
			elseif( _type == TYPE_CONTAINER ) then
				local slots = LL_SearchData(value, "sl");
				if( slots ) then
					tooltip:AddLine(slots.." Slot Container", 1, 1, 1);
					lines = lines + 1;
				end
			end
			
			local level = LL_SearchData(value, "le");

			-- Now add any extra text data that we have
			if( value.t ) then
				local skip = lines + extraSkip;
				local piece;
				for piece in string.gfind(value.t, "(.-)·") do
					if( lines < 29 ) then
						if( skip == 0 ) then
							if( string.find(piece, "Requires Level .*") ) then
								if( level and tonumber(level) > UnitLevel("player") ) then
									tooltip:AddLine(piece, 1, 0, 0, 1, 1);
								else
									tooltip:AddLine(piece, 1, 1, 1, 1, 1);
								end
							elseif( string.find(piece, ":") ) then
								if( string.find(piece, "^Class") ) then
									if( string.find(piece, "^Class.*"..UnitClass("player")) ) then
										tooltip:AddLine(piece, 1, 1, 1, 1, 1);
									else
										tooltip:AddLine(piece, 1, 0, 0, 1, 1);
									end
								else
									tooltip:AddLine(piece, 0, 1, 0, 1, 1);
								end
							elseif( string.find(piece, "\"") or string.find(piece, "%(%d+/%d+%)") ) then
								tooltip:AddLine(piece, 1, 0.8235, 0, 1, 1);
							elseif( string.find(piece, "^  ") ) then
								tooltip:AddLine(piece, 0.5, 0.5, 0.5, 1, 1);
							else
								tooltip:AddLine(piece, 1, 1, 1, 1, 1);
							end
							lines = lines + 1;
						else
							skip = skip - 1;
						end
					end
				end
			end
			
			-- And, after all that, let the user know that we faked this tooltip
			if( lines < 30 ) then
				tooltip:AddLine("|cff40ffc0<Generated by LootLink from cached data>|r");
			end
			
			-- Finally, show the tooltip, which adjusts its size
			tooltip:Show();
		end
	else
		-- Get the actual tooltip from the cache
		tooltip:SetHyperlink(link);
		
		-- After setting the tooltip, parse its data
		LootLink_BuildSearchData(name, ItemLinks[name]);
	end
end

local function LootLink_SetTitle()
	local lootLinkTitle = getglobal("LootLinkTitleText");
	local total = LootLink_GetSize(lServerIndex);
	local size;
	
	if( not DisplayIndices ) then
		size = total;
	else
		size = DisplayIndices.onePastEnd - 1;
	end
	if( size < total ) then
		if( size == 1 ) then
			lootLinkTitle:SetText(TEXT(LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR));
		else
			lootLinkTitle:SetText(format(TEXT(LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL), size));
		end
	else
		if( size == 1 ) then
			lootLinkTitle:SetText(TEXT(LOOTLINK_TITLE_FORMAT_SINGULAR));
		else
			lootLinkTitle:SetText(format(TEXT(LOOTLINK_TITLE_FORMAT_PLURAL), size));
		end
	end
end

local function LootLink_MatchesSearch(name, value, ud)
	if( not value or not LootLink_CheckItemServer(value, lServerIndex) ) then
		return nil;
	end
	if( not LootLinkFrame.SearchParams or not name ) then
		return 1;
	end
	
	if( value.d ) then
		local sp = LootLinkFrame.SearchParams; 
		
		if( sp.text ) then
			if( not value.t ) then
				return nil;
			end
			if( not string.find(string.lower(value.t), string.lower(sp.text), 1, sp.plain) ) then
				return nil;
			end
		end
		
		if( sp.name ) then
			if( not string.find(string.lower(name), string.lower(sp.name), 1, sp.plain) ) then
				return nil;
			end
		end
		
		if( sp.rarity ) then
			if( LLS_RARITY_LIST[sp.rarity].value ~= value.c ) then
				return nil;
			end
		end
		
		if( sp.binds ) then
			if( LLS_BINDS_LIST[sp.binds].value ~= LL_SearchData(value, "bi") ) then
				return nil;
			end
		end
		
		if( sp.unique ) then
			if( sp.unique ~= LL_SearchData(value, "un") ) then
				return nil;
			end
		end
		
		if( sp.usable ) then
			local _type = LL_SearchData(value, "ty");
			local subtype = LL_SearchData(value, "su");
			local level = LL_SearchData(value, "le");
			local skill = LL_SearchData(value, "sk");
			
			-- Check for the required skill
			if( _type ) then
				if( subtype ) then
					local rank = LootLink_GetSkillRank(ud, _type, subtype, LL_SearchData(value, "lo"));
					if( not rank or (skill and skill > rank) ) then
						return nil;
					end
				end
			end
			
			-- Check for the required class
			if( value.t and string.find(value.t, "·Class") and not string.find(value.t, "·Class.*"..UnitClass("player")) ) then
				return nil;
			end
			
			-- Check level requirement
			if( level and level > ud.level ) then
				return nil;
			end
		end
		
		if( sp.location ) then
			local location = LL_SearchData(value, "lo");
		
			if( sp.location == 2 ) then
				if( location ) then
					return nil;
				end
			elseif( sp.location ~= 1 ) then
				if( LocationTypes[LLS_LOCATION_LIST[sp.location].name].i ~= location ) then
					return nil;
				end
			end
		end
		
		if( sp.minLevel ) then
			local level = LL_SearchData(value, "le");
			if( not level or level < sp.minLevel ) then
				return nil;
			end
		end
		
		if( sp.maxLevel ) then
			local level = LL_SearchData(value, "le");
			if( level and level > sp.maxLevel ) then
				return nil;
			end
		end
		
		if( sp.type ) then
			local _type = LLS_TYPE_LIST[sp.type].value;
			if( _type ~= LL_SearchData(value, "ty") ) then
				return nil;
			end
			if( sp.subtype ) then
				local subtype;
				if( _type == TYPE_ARMOR ) then
					subtype = LLS_SUBTYPE_ARMOR_LIST[sp.subtype].value;
				elseif( _type == TYPE_SHIELD ) then
					subtype = LLS_SUBTYPE_SHIELD_LIST[sp.subtype].value;
				elseif( _type == TYPE_WEAPON ) then
					subtype = LLS_SUBTYPE_WEAPON_LIST[sp.subtype].value;
				elseif( _type == TYPE_RECIPE ) then
					subtype = LLS_SUBTYPE_RECIPE_LIST[sp.subtype].value;
				end
				if( subtype and subtype ~= LL_SearchData(value, "su") ) then
					return nil;
				end
			end
			
			if( _type == TYPE_WEAPON ) then
				if( sp.minMinDamage ) then
					local damage = LL_SearchData(value, "mi");
					if( not damage or damage < sp.minMinDamage ) then
						return nil;
					end
				end

				if( sp.minMaxDamage ) then
					local damage = LL_SearchData(value, "ma");
					if( not damage or damage < sp.minMaxDamage ) then
						return nil;
					end
				end

				if( sp.maxSpeed ) then
					local speed = LL_SearchData(value, "sp");
					if( not speed or speed > sp.maxSpeed ) then
						return nil;
					end
				end

				if( sp.minDPS ) then
					local DPS = LL_SearchData(value, "dp");
					if( not DPS or DPS < sp.minDPS ) then
						return nil;
					end
				end
			elseif( _type == TYPE_ARMOR or _type == TYPE_SHIELD ) then
				if( sp.minArmor ) then
					local armor = LL_SearchData(value, "ar");
					if( not armor or armor < sp.minArmor ) then
						return nil;
					end
				end
				
				if( _type == TYPE_SHIELD ) then
					if( sp.minBlock ) then
						local block = LL_SearchData(value, "bl");
						if( not block or block < sp.minBlock ) then
							return nil;
						end
					end
				end
			elseif( _type == TYPE_CONTAINER ) then
				if( sp.minSlots ) then
					local slots = LL_SearchData(value, "sl");
					if( not slots or slots < sp.minSlots ) then
						return nil;
					end
				end
			elseif( _type == TYPE_RECIPE ) then
				if( sp.minSkill ) then
					local skill = LL_SearchData(value, "sk");
					if( not skill or skill < sp.minSkill ) then
						return nil;
					end
				end
				
				if( sp.maxSkill ) then
					local skill = LL_SearchData(value, "sk");
					if( not skill or skill > sp.maxSkill ) then
						return nil;
					end
				end
			end
		end
	else
		return nil;
	end

	return 1;
end

local function LootLink_ColorComparison(elem1, elem2)
	local color1;
	local color2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].c ) then
		color1 = ItemLinks[elem1].c;
	else
		color1 = "ffffffff";
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].c ) then
		color2 = ItemLinks[elem2].c;
	else
		color2 = "ffffffff";
	end
	
	if( color1 == color2 ) then
		return elem1 < elem2;
	end
	
	if( not lColorSortTable[color1] and not lColorSortTable[color2] ) then
		return color1 < color2;
	end
	
	if( lColorSortTable[color1] ) then
		if( lColorSortTable[color2] ) then
			return lColorSortTable[color1] < lColorSortTable[color2];
		end
		return nil;
	end
	return 1;
end

local function LootLink_GenericComparison(elem1, elem2, v1, v2)
	if( v1 == v2 ) then
		return elem1 < elem2;
	end
	if( not v1 ) then
		return 1;
	end
	if( not v2 ) then
		return nil;
	end
	if( tonumber(v1) and tonumber(v2) ) then
		return tonumber(v1) < tonumber(v2);
	end
	return v1 < v2;
end

local function LootLink_BindsComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "bi");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "bi");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_UniqueComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "un");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "un");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_LocationComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "lo");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "lo");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_TypeComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "ty");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "ty");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SubtypeComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "su");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "su");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_MinDamageComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "mi");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "mi");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_MaxDamageComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "ma");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "ma");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SpeedComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "sp");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "sp");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_DPSComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "dp");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "dp");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_ArmorComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "ar");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "ar");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_BlockComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "bl");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "bl");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SlotsComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "sl");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "sl");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_SkillComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "sk");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "sk");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_LevelComparison(elem1, elem2)
	local v1, v2;
	
	if( ItemLinks[elem1] and ItemLinks[elem1].d ) then
		v1 = LL_SearchData(ItemLinks[elem1], "le");
	end
	if( ItemLinks[elem2] and ItemLinks[elem2].d ) then
		v2 = LL_SearchData(ItemLinks[elem2], "le");
	end
	
	return LootLink_GenericComparison(elem1, elem2, v1, v2);
end

local function LootLink_Sort()
	if( LOOTLINK_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown)].sortType ) then
		local sortType = LOOTLINK_DROPDOWN_LIST[UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown)].sortType;
		if( sortType == "name" ) then
			table.sort(DisplayIndices);
		elseif( sortType == "rarity" ) then
			table.sort(DisplayIndices, LootLink_ColorComparison);
		elseif( sortType == "binds" ) then
			table.sort(DisplayIndices, LootLink_BindsComparison);
		elseif( sortType == "unique" ) then
			table.sort(DisplayIndices, LootLink_UniqueComparison);
		elseif( sortType == "location" ) then
			table.sort(DisplayIndices, LootLink_LocationComparison);
		elseif( sortType == "type" ) then
			table.sort(DisplayIndices, LootLink_TypeComparison);
		elseif( sortType == "subtype" ) then
			table.sort(DisplayIndices, LootLink_SubtypeComparison);
		elseif( sortType == "minDamage" ) then
			table.sort(DisplayIndices, LootLink_MinDamageComparison);
		elseif( sortType == "maxDamage" ) then
			table.sort(DisplayIndices, LootLink_MaxDamageComparison);
		elseif( sortType == "speed" ) then
			table.sort(DisplayIndices, LootLink_SpeedComparison);
		elseif( sortType == "DPS" ) then
			table.sort(DisplayIndices, LootLink_DPSComparison);
		elseif( sortType == "armor" ) then
			table.sort(DisplayIndices, LootLink_ArmorComparison);
		elseif( sortType == "block" ) then
			table.sort(DisplayIndices, LootLink_BlockComparison);
		elseif( sortType == "slots" ) then
			table.sort(DisplayIndices, LootLink_SlotsComparison);
		elseif( sortType == "skill" ) then
			table.sort(DisplayIndices, LootLink_SkillComparison);
		elseif( sortType == "level" ) then
			table.sort(DisplayIndices, LootLink_LevelComparison);
		end
	end
end

local function LootLink_BuildDisplayIndices()
	local iNew = 1;
	local index;
	local value;
	local UsabilityData;
	
	if( LootLinkFrame.SearchParams and LootLinkFrame.SearchParams.usable ) then
		UsabilityData = { };
		BuildUsabilityData(UsabilityData);
	end
	
	DisplayIndices = { };
	for index, value in ItemLinks do
		if( LootLink_MatchesSearch(index, value, UsabilityData) ) then
			DisplayIndices[iNew] = index;
			iNew = iNew + 1;
		end
	end
	DisplayIndices.onePastEnd = iNew;
	LootLink_SetDataVersion(100); -- version 1.00
	LootLink_Sort();
	LootLink_SetTitle();
end

local function LootLink_Reset()
	ItemLinks = { };

	LootLink_SetDataVersion(110);	-- version 1.10

	LootLink_InitSizes(lServerIndex);
	
	if( DisplayIndices ) then
		LootLink_BuildDisplayIndices();
		LootLink_Update();
	end
end

local function LootLink_MakeHome()
	local index;
	local value;

	LootLink_SetDataVersion(110);	-- version 1.10
	
	for index, value in ItemLinks do
		if( not value._ ) then
			-- If this item predates multiple server support, mark is as seen on this server
			LootLink_AddItemServer(value, lServerIndex);
		else
			-- Otherwise just wipe the flag since it only applies to pre-1.10 data
			value._ = nil;
		end
	end

	LootLink_InitSizes(lServerIndex);
end

local function LootLink_LightMode()
	local index;
	local value;

	for index, value in ItemLinks do
		value.t = nil;
	end
	LootLinkState.LightMode = 1;
end

--
-- Uncategorized functions; will sort later
--

local function LootLinkFrameDropDown_Initialize()
	local info;
	for i = 1, getn(LOOTLINK_DROPDOWN_LIST), 1 do
		info = { };
		info.text = LOOTLINK_DROPDOWN_LIST[i].name;
		info.func = LootLinkFrameDropDownButton_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_RarityDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_RARITY_LIST), 1 do
		info = { };
		info.text = LLS_RARITY_LIST[i].name;
		info.func = LLS_RarityDropDown_OnClick;
		if( LLS_RARITY_LIST[i].value ) then
			info.textR = LLS_RARITY_LIST[i].r;
			info.textG = LLS_RARITY_LIST[i].g;
			info.textB = LLS_RARITY_LIST[i].b;
		end
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_BindsDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_BINDS_LIST), 1 do
		info = { };
		info.text = LLS_BINDS_LIST[i].name;
		info.func = LLS_BindsDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_LocationDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_LOCATION_LIST), 1 do
		info = { };
		info.text = LLS_LOCATION_LIST[i].name;
		info.func = LLS_LocationDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_TypeDropDown_Initialize()
	local info;
	for i = 1, getn(LLS_TYPE_LIST), 1 do
		info = { };
		info.text = LLS_TYPE_LIST[i].name;
		info.func = LLS_TypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownArmor_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_ARMOR_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_ARMOR_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownShield_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_SHIELD_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_SHIELD_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownWeapon_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_WEAPON_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_WEAPON_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LLS_SubtypeDropDownRecipe_Initialize()
	local info;
	for i = 1, getn(LLS_SUBTYPE_RECIPE_LIST), 1 do
		info = { };
		info.text = LLS_SUBTYPE_RECIPE_LIST[i].name;
		info.func = LLS_SubtypeDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

local function LootLink_UIDropDownMenu_SetSelectedID(frame, id, names)
	UIDropDownMenu_SetSelectedID(frame, id);
	if( not frame ) then
		frame = this;
	end
	UIDropDownMenu_SetText(names[id].name, frame);
end

local function LootLink_SetupTypeUI(iType, iSubtype)
	local _type = LLS_TYPE_LIST[iType].value;
	
	if( not iSubtype ) then
		iSubtype = 1;
	end

	-- Hide all of the variable labels and fields to start
	getglobal("LLS_SubtypeLabel"):Hide();
	getglobal("LLS_SubtypeDropDown"):Hide();
	getglobal("LLS_MinimumArmorLabel"):Hide();
	getglobal("LLS_MinimumBlockLabel"):Hide();
	getglobal("LLS_MinimumDamageLabel"):Hide();
	getglobal("LLS_MaximumDamageLabel"):Hide();
	getglobal("LLS_MaximumSpeedLabel"):Hide();
	getglobal("LLS_MinimumDPSLabel"):Hide();
	getglobal("LLS_MinimumSlotsLabel"):Hide();
	getglobal("LLS_MinimumSkillLabel"):Hide();
	getglobal("LLS_MaximumSkillLabel"):Hide();
	getglobal("LLS_MinimumArmorEditBox"):Hide();
	getglobal("LLS_MinimumBlockEditBox"):Hide();
	getglobal("LLS_MinimumDamageEditBox"):Hide();
	getglobal("LLS_MaximumDamageEditBox"):Hide();
	getglobal("LLS_MaximumSpeedEditBox"):Hide();
	getglobal("LLS_MinimumDPSEditBox"):Hide();
	getglobal("LLS_MinimumSlotsEditBox"):Hide();
	getglobal("LLS_MinimumSkillEditBox"):Hide();
	getglobal("LLS_MaximumSkillEditBox"):Hide();
	
	if( _type == TYPE_ARMOR or _type == TYPE_SHIELD or _type == TYPE_WEAPON or _type == TYPE_RECIPE ) then
		local label = getglobal("LLS_SubtypeLabel");
		local dropdown = getglobal("LLS_SubtypeDropDown");
		local initfunc;
		
		-- Show the dropdown and its label
		label:Show();
		dropdown:Show();
		
		if( _type == TYPE_ARMOR ) then
			label:SetText(LLS_SUBTYPE_ARMOR);
			initfunc = LLS_SubtypeDropDownArmor_Initialize;
			
			getglobal("LLS_MinimumArmorLabel"):Show();
			getglobal("LLS_MinimumArmorEditBox"):Show();
		elseif( _type == TYPE_SHIELD ) then
			label:SetText(LLS_SUBTYPE_SHIELD);
			initfunc = LLS_SubtypeDropDownShield_Initialize;

			getglobal("LLS_MinimumArmorLabel"):Show();
			getglobal("LLS_MinimumBlockLabel"):Show();
			getglobal("LLS_MinimumArmorEditBox"):Show();
			getglobal("LLS_MinimumBlockEditBox"):Show();
		elseif( _type == TYPE_WEAPON ) then
			label:SetText(LLS_SUBTYPE_WEAPON);
			initfunc = LLS_SubtypeDropDownWeapon_Initialize;
			
			getglobal("LLS_MinimumDamageLabel"):Show();
			getglobal("LLS_MaximumDamageLabel"):Show();
			getglobal("LLS_MaximumSpeedLabel"):Show();
			getglobal("LLS_MinimumDPSLabel"):Show();
			getglobal("LLS_MinimumDamageEditBox"):Show();
			getglobal("LLS_MaximumDamageEditBox"):Show();
			getglobal("LLS_MaximumSpeedEditBox"):Show();
			getglobal("LLS_MinimumDPSEditBox"):Show();
		else
			label:SetText(LLS_SUBTYPE_RECIPE);
			initfunc = LLS_SubtypeDropDownRecipe_Initialize;

			getglobal("LLS_MinimumSkillLabel"):Show();
			getglobal("LLS_MaximumSkillLabel"):Show();
			getglobal("LLS_MinimumSkillEditBox"):Show();
			getglobal("LLS_MaximumSkillEditBox"):Show();
		end
		
		UIDropDownMenu_Initialize(dropdown, initfunc);
		UIDropDownMenu_SetSelectedID(LLS_SubtypeDropDown, iSubtype);
	elseif( _type == TYPE_CONTAINER ) then
		getglobal("LLS_MinimumSlotsLabel"):Show();
		getglobal("LLS_MinimumSlotsEditBox"):Show();
	end
end

local function LootLink_InspectSlot(unit, id)
	local link = GetInventoryItemLink(unit, id);
	if( link ) then
		local name = LootLink_ProcessLinks(link, 1);
		if( name and ItemLinks[name] ) then
			local count = GetInventoryItemCount(unit, id);
			if( count > 1 ) then
				ItemLinks[name].x = 1;
			end
			LootLink_Event_InspectSlot(name, count, ItemLinks[name], unit, id);
		end
	end
end

local function LootLink_Inspect(who)
	local index;
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		LootLink_InspectSlot(who, INVENTORY_SLOT_LIST[index].id)
	end
end

local function LootLink_ScanInventory()
	local bagid;
	local size;
	local slotid;
	local link;
	
	for bagid = 0, 4, 1 do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					local name = LootLink_ProcessLinks(link, 1);
					if( name and ItemLinks[name] ) then
						local texture, count, locked, quality, readable = GetContainerItemInfo(bagid, slotid);
						if( count > 1 ) then
							ItemLinks[name].x = 1;
						end
						LootLink_Event_ScanInventory(name, count, ItemLinks[name], bagid, slotid);
					end
				end
			end
		end
	end
end

local function LootLink_ScanSellPrices()
	local bagid;
	local size;
	local slotid;
	local link;
	
	LootLink_MoneyToggle();
	for bagid = 0, 4, 1 do
		lBagID = bagid;
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				lSlotID = slotid;
				LLHiddenTooltip:SetBagItem(bagid, slotid);
			end
		end
	end
	
	lBagID = nil;
	lSlotID = nil;
	
	LootLink_MoneyToggle();
end

local function LootLink_StartAuctionScan()
	-- Start with the first page
	lCurrentAuctionPage = nil;

	-- Hook the functions that we need for the scan
	if( not lOriginal_CanSendAuctionQuery ) then
		lOriginal_CanSendAuctionQuery = CanSendAuctionQuery;
		CanSendAuctionQuery = LootLink_CanSendAuctionQuery;
	end
	if( not lOriginal_AuctionFrameBrowse_OnEvent ) then
		lOriginal_AuctionFrameBrowse_OnEvent = AuctionFrameBrowse_OnEvent;
		AuctionFrameBrowse_OnEvent = LootLink_AuctionFrameBrowse_OnEvent;
	end
	
	LootLink_Event_StartAuctionScan();
end

local function LootLink_StopAuctionScan()
	LootLink_Event_StopAuctionScan();
	
	-- Unhook the scanning functions
	if( lOriginal_CanSendAuctionQuery ) then
		CanSendAuctionQuery = lOriginal_CanSendAuctionQuery;
		lOriginal_CanSendAuctionQuery = nil;
	end
	if( lOriginal_AuctionFrameBrowse_OnEvent ) then
		AuctionFrameBrowse_OnEvent = lOriginal_AuctionFrameBrowse_OnEvent;
		lOriginal_AuctionFrameBrowse_OnEvent = nil;
	end
end

local function LootLink_AuctionNextQuery()
	if( lCurrentAuctionPage ) then
		local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
		local maxPages = floor(totalAuctions / NUM_AUCTION_ITEMS_PER_PAGE);
		
		if( lCurrentAuctionPage < maxPages ) then
			lCurrentAuctionPage = lCurrentAuctionPage + 1;
			BrowseNoResultsText:SetText(format(LOOTLINK_AUCTION_PAGE_N, lCurrentAuctionPage + 1, maxPages + 1));
		else
			lScanAuction = nil;
			LootLink_StopAuctionScan();
			if( totalAuctions > 0 ) then
				BrowseNoResultsText:SetText(LOOTLINK_AUCTION_SCAN_DONE);
				LootLink_Event_FinishedAuctionScan();
			end
			return;
		end
	else
		lCurrentAuctionPage = 0;
		BrowseNoResultsText:SetText(LOOTLINK_AUCTION_SCAN_START);
	end
	QueryAuctionItems("", "", "", nil, nil, nil, lCurrentAuctionPage, nil, nil);
	LootLink_Event_AuctionQuery(lCurrentAuctionPage);
end

local function LootLink_ScanAuction()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list");
	local auctionid;
	local link;

	if( numBatchAuctions > 0 ) then
		for auctionid = 1, numBatchAuctions do
			link = GetAuctionItemLink("list", auctionid);
			if( link ) then
				local name = LootLink_ProcessLinks(link, 1);
				if( name and ItemLinks[name] ) then
					local name_, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, owner = GetAuctionItemInfo("list", auctionid);
					if( count > 1 ) then
						ItemLinks[name].x = 1;
					end
					LootLink_Event_ScanAuction(name, count, ItemLinks[name], lCurrentAuctionPage, auctionid);
				end
			end
		end
	end
end

local function LootLink_ScanBank()
	local index;
	local bagid;
	local size;
	local slotid;
	local link;
	
	for index, bagid in lBankBagIDs do
		size = GetContainerNumSlots(bagid);
		if( size ) then
			for slotid = size, 1, -1 do
				link = GetContainerItemLink(bagid, slotid);
				if( link ) then
					local name = LootLink_ProcessLinks(link, 1);
					if( name and ItemLinks[name] ) then
						local texture, count, locked, quality, readable = GetContainerItemInfo(bagid, slotid);
						if( count > 1 ) then
							ItemLinks[name].x = 1;
						end
						LootLink_Event_ScanBank(name, count, ItemLinks[name], bagid, slotid);
					end
				end
			end
		end
	end
end

local function LootLink_ScanSellPrice(price)
	local link = GetContainerItemLink(lBagID, lSlotID);
	local texture, itemCount, locked, quality, readable = GetContainerItemInfo(lBagID, lSlotID);
	local name;
	
	if( itemCount and itemCount > 1 ) then
		price = price / itemCount;
	end
	
	name = LootLink_NameFromLink(link);
	if( name and ItemLinks[name] ) then
		ItemLinks[name].p = price;
		if( itemCount and itemCount > 1 ) then
			ItemLinks[name].x = 1;
		end
	end
end

local function LootLink_CheckTooltipInfo()
	if( GameTooltip:IsVisible() ) then
		-- If we've already added our information or money is already showing, no need to do it again
		if( GameTooltip.llDone or GameTooltipMoneyFrame:IsVisible() ) then
			return nil;
		end
	
		-- Don't add information to tooltips generated while the mouse is over the minimap
		if( LootLink_MouseIsOver(MinimapCluster) ) then
			return nil;
		end
	
		local field = getglobal("GameTooltipTextLeft1");
		if( field and field:IsVisible() ) then
			local name = field:GetText();
			if( name ) then
				if( ItemLinks[name] ) then
					LootLink_AddTooltipInfo(name, GameTooltip);
				end
				-- Whether or not we had information for this item, there's no need to check it again
				return nil;
			end
		end
	end
	
	return 1;
end

local function LootLink_CheckVersionReminder()
	local index;
	local value;
	local version;
	
	version = LootLink_GetDataVersion();
	for index, value in LOOTLINK_DATA_UPGRADE_HELP do
		if( version < value.version ) then
			DEFAULT_CHAT_FRAME:AddMessage(value.text);
		end
	end
end

local function LootLink_UpgradeData()
	local index;
	local item;
	
	for index, item in ItemLinks do
		LootLink_ConvertServerFormat(item);
		if( item.item ) then
			item.i = item.item;
			item.item = nil;
		end
		if( item.color ) then
			item.c = item.color;
			item.color = nil;
		end
		if( item.price ) then
			item.p = item.price;
			item.price = nil;
		end
		if( item.stack ) then
			item.x = item.stack;
			item.stack = nil;
		end
		
		if( item.SearchData ) then
			local data = "";

			if( item.SearchData.type ) then
				data = data.."ty"..item.SearchData.type.."·";
			end
			if( item.SearchData.location ) then
				data = data.."lo"..LocationTypes[item.SearchData.location].i.."·";
			end
			if( item.SearchData.subtype ) then
				data = data.."su"..item.SearchData.subtype.."·";
			end
			if( item.SearchData.binds ) then
				data = data.."bi"..item.SearchData.binds.."·";
			end
			if( item.SearchData.level ) then
				data = data.."le"..item.SearchData.level.."·";
			end
			if( item.SearchData.armor ) then
				data = data.."ar"..item.SearchData.armor.."·";
			end
			if( item.SearchData.minDamage ) then
				data = data.."mi"..item.SearchData.minDamage.."·";
			end
			if( item.SearchData.maxDamage ) then
				data = data.."ma"..item.SearchData.maxDamage.."·";
			end
			if( item.SearchData.speed ) then
				data = data.."sp"..item.SearchData.speed.."·";
			end
			if( item.SearchData.DPS ) then
				data = data.."dp"..item.SearchData.DPS.."·";
			end
			if( item.SearchData.unique ) then
				data = data.."un"..item.SearchData.unique.."·";
			end
			if( item.SearchData.block ) then
				data = data.."bl"..item.SearchData.block.."·";
			end
			if( item.SearchData.slots ) then
				data = data.."sl"..item.SearchData.slots.."·";
			end
			if( item.SearchData.skill ) then
				data = data.."sk"..item.SearchData.skill.."·";
			end
			
			if( item.SearchData.text ) then
				item.t = item.SearchData.text;
			end
			
			item.d = data;
			item.SearchData = nil;
		end
	end
end

local function LootLink_VariablesLoaded()
	local index;
	local value;

	if( not LootLinkState ) then
		LootLinkState = { };
	end
	
	if( not ItemLinks ) then
		LootLink_Reset();
	end
	
	lServer = GetCVar("realmName");
	lServerIndex = LootLink_AddServer(lServer);
	
	LootLink_UpgradeData();
	
	LootLink_InitSizes(lServerIndex);
end

--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------
function LootLink_OnLoad()
	local index;
	local value;

	for index, value in ChatMessageTypes do
		this:RegisterEvent(value);
	end
	
	for index = 1, getn(INVENTORY_SLOT_LIST), 1 do
		INVENTORY_SLOT_LIST[index].id = GetInventorySlotInfo(INVENTORY_SLOT_LIST[index].name);
	end
	
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	this:RegisterEvent("BANKFRAME_OPENED");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("AUCTION_HOUSE_SHOW");
	this:RegisterEvent("AUCTION_HOUSE_CLOSE");
	this:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
	this:RegisterEvent("MERCHANT_SHOW");

	-- Register our slash command
	SLASH_LOOTLINK1 = "/lootlink";
	SLASH_LOOTLINK2 = "/ll";
	SlashCmdList["LOOTLINK"] = function(msg)
		LootLink_SlashCommandHandler(msg);
	end
	
	-- Hook the GameTooltip:SetOwner function
	lOriginal_GameTooltip_SetOwner = GameTooltip.SetOwner;
	GameTooltip.SetOwner = LootLink_GameTooltip_SetOwner;
	
	-- Hook the ContainerFrameItemButton_OnEnter, ContainerFrame_Update and GameTooltip:SetLootItem functions
	lOriginal_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
	ContainerFrameItemButton_OnEnter = LootLink_ContainerFrameItemButton_OnEnter;
	lOriginal_ContainerFrame_Update = ContainerFrame_Update;
	ContainerFrame_Update = LootLink_ContainerFrame_Update;
	lOriginal_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
	GameTooltip.SetLootItem = LootLink_GameTooltip_SetLootItem;
	
	-- Hook GameTooltip_OnHide and GameTooltip_ClearMoney
	lOriginal_GameTooltip_OnHide = GameTooltip_OnHide;
	GameTooltip_OnHide = LootLink_GameTooltip_OnHide;
	lOriginal_GameTooltip_ClearMoney = GameTooltip_ClearMoney;
	GameTooltip_ClearMoney = LootLink_GameTooltip_ClearMoney;
	
	-- Hook the shopping tooltip functions
	lOriginal_ShoppingTooltip1_SetMerchantCompareItem = ShoppingTooltip1.SetMerchantCompareItem;
	ShoppingTooltip1.SetMerchantCompareItem = LootLink_ShoppingTooltip1_SetMerchantCompareItem;
	lOriginal_ShoppingTooltip2_SetMerchantCompareItem = ShoppingTooltip2.SetMerchantCompareItem;
	ShoppingTooltip2.SetMerchantCompareItem = LootLink_ShoppingTooltip2_SetMerchantCompareItem;

	lOriginal_ShoppingTooltip1_SetAuctionCompareItem = ShoppingTooltip1.SetAuctionCompareItem;
	ShoppingTooltip1.SetAuctionCompareItem = LootLink_ShoppingTooltip1_SetAuctionCompareItem;
	lOriginal_ShoppingTooltip2_SetAuctionCompareItem = ShoppingTooltip2.SetAuctionCompareItem;
	ShoppingTooltip2.SetAuctionCompareItem = LootLink_ShoppingTooltip2_SetAuctionCompareItem;
	
	-- Hook SetItemRef
	lOriginal_SetItemRef = SetItemRef;
	SetItemRef = LootLink_SetItemRef;
	
	-- Hook our hidden tooltip's OnTooltipAddMoney
	lOriginal_OnTooltipAddMoney = LLHiddenTooltip:GetScript("OnTooltipAddMoney");
	LLHiddenTooltip:SetScript("OnTooltipAddMoney", LootLink_OnTooltipAddMoney);

	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("Telo's LootLink AddOn loaded");
	end
	UIErrorsFrame:AddMessage("Telo's LootLink AddOn loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function LootLink_CanSendAuctionQuery()
	local value = lOriginal_CanSendAuctionQuery();
	if( value ) then
		LootLink_AuctionNextQuery();
		return nil;
	end
	return value;
end

function LootLink_AuctionFrameBrowse_OnEvent()
	-- Intentionally empty; don't allow the auction UI to update while we're scanning
end

function LootLink_GameTooltip_SetOwner(this, owner, anchor)
	lOriginal_GameTooltip_SetOwner(this, owner, anchor);
	lGameToolTipOwner = owner;
end

function LootLink_GameTooltip_ClearMoney()
	lOriginal_GameTooltip_ClearMoney();
	if( not lSuppressInfoAdd ) then
		lCheckTooltip = LootLink_CheckTooltipInfo();
	end
end

function LootLink_GameTooltip_ClearMoney_Temp()
	-- Intentionally empty; don't clear money while we use our hidden tooltip
end

function LootLink_ContainerFrameItemButton_OnEnter()
	LootLink_AutoInfoOff();
	lOriginal_ContainerFrameItemButton_OnEnter();
	if( not InRepairMode() and not MerchantFrame:IsVisible() ) then
		local frameID = this:GetParent():GetID();
		local buttonID = this:GetID();
		local link = GetContainerItemLink(frameID, buttonID);
		local name = LootLink_NameFromLink(link);
		
		if( name and ItemLinks[name] ) then
			local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
			LootLink_AddTooltipInfo(name, GameTooltip, itemCount);
			GameTooltip:Show();
		end
	end
	LootLink_AutoInfoOn();
end

function LootLink_ContainerFrame_Update(frame)
	LootLink_AutoInfoOff();
	lOriginal_ContainerFrame_Update(frame);
	if( not InRepairMode() and not MerchantFrame:IsVisible() and GameTooltip:IsVisible() ) then
		local frameID = frame:GetID();
		local frameName = frame:GetName();
		local iButton;
		for iButton = 1, frame.size do
			local button = getglobal(frameName.."Item"..iButton);
			if( GameTooltip:IsOwned(button) ) then
				local buttonID = button:GetID();
				local link = GetContainerItemLink(frameID, buttonID);
				local name = LootLink_NameFromLink(link);
				
				if( name and ItemLinks[name] ) then
					local texture, itemCount, locked, quality, readable = GetContainerItemInfo(frameID, buttonID);
					LootLink_AddTooltipInfo(name, GameTooltip, itemCount);
					GameTooltip:Show();
				end
			end
		end
	end
	LootLink_AutoInfoOn();
end

function LootLink_GameTooltip_OnHide()
	lOriginal_GameTooltip_OnHide();
	GameTooltip.llDone = nil;
	lCheckTooltip = nil;
end

function LootLink_GameTooltip_SetLootItem(this, slot)
	LootLink_AutoInfoOff();
	lOriginal_GameTooltip_SetLootItem(this, slot);
	
	local link = GetLootSlotLink(slot);
	local name = LootLink_NameFromLink(link);
	if( name and ItemLinks[name] and ItemLinks[name].p ) then
		local texture, item, quantity, quality = GetLootSlotInfo(slot);
		LootLink_AddTooltipInfo(name, GameTooltip, quantity);
	end
	LootLink_AutoInfoOn();
end

function LootLink_ShoppingTooltip1_SetMerchantCompareItem(this, id, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip1_SetMerchantCompareItem(this, id, num);
	LootLink_MoneyToggle();
	return retval;
end

function LootLink_ShoppingTooltip2_SetMerchantCompareItem(this, id, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip2_SetMerchantCompareItem(this, id, num);
	LootLink_MoneyToggle();
	return retval;
end

function LootLink_ShoppingTooltip1_SetAuctionCompareItem(this, _type, index, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip1_SetAuctionCompareItem(this, _type, index, num);
	LootLink_MoneyToggle();
	return retval;
end

function LootLink_ShoppingTooltip2_SetAuctionCompareItem(this, _type, index, num)
	LootLink_MoneyToggle();
	local retval = lOriginal_ShoppingTooltip2_SetAuctionCompareItem(this, _type, index, num);
	LootLink_MoneyToggle();
	return retval;
end

function LootLink_SetItemRef(link, text, button)
	lOriginal_SetItemRef(link, text, button);

	-- If this is a tooltip-creating link, add our information to it
	if( strsub(link, 1, 6) ~= "Player" ) then
		ItemRefTooltipMoneyFrame:SetPoint("LEFT", "ItemRefTooltipTextLeft1", "LEFT", 0, 0);
		ItemRefTooltipMoneyFrame:Hide();

		if( ItemRefTooltip:IsVisible() ) then
			local field = getglobal("ItemRefTooltipTextLeft1");
			if( field and field:IsVisible() ) then
				local name = field:GetText();
				if( name and ItemLinks[name] ) then
					LootLink_AddTooltipInfo(name, ItemRefTooltip);
				end
			end
		end
	end
end

function LootLink_OnTooltipAddMoney()
	lOriginal_OnTooltipAddMoney();
	if( lBagID and lSlotID ) then
		LootLink_ScanSellPrice(arg1);
	end
end

function LootLink_OnEvent()
	if( event == "PLAYER_TARGET_CHANGED" ) then
		if( UnitIsUnit("target", "player") ) then
			return;
		elseif( UnitIsPlayer("target") ) then
			LootLink_Inspect("target");
		end
	elseif( event == "PLAYER_ENTERING_WORLD" ) then
		LootLink_CheckVersionReminder();
	elseif( event == "UNIT_INVENTORY_CHANGED" ) then
		if( arg1 == "player" ) then
			LootLink_ScanInventory();
			LootLink_Inspect("player");
		end
	elseif( event == "BANKFRAME_OPENED" ) then
		LootLink_ScanBank();
	elseif( event == "VARIABLES_LOADED" ) then
		LootLink_VariablesLoaded();
	elseif( event == "AUCTION_HOUSE_SHOW" ) then
		if( lScanAuction ) then
			LootLink_StartAuctionScan();
		end
	elseif( event == "AUCTION_HOUSE_CLOSED" ) then
		LootLink_StopAuctionScan();
	elseif( event == "AUCTION_ITEM_LIST_UPDATE" ) then
		LootLink_ScanAuction();
	elseif( event == "MERCHANT_SHOW" ) then
		LootLink_ScanSellPrices();
	else
		local name = LootLink_ProcessLinks(arg1, event == "CHAT_MSG_LOOT");
		if( name and ItemLinks[name] ) then
			LootLink_Event_ScanChat(name, ItemLinks[name], arg1);
		end
	end
end

function LootLinkItemButton_OnClick(button)
	if( button == "LeftButton" ) then
		if( IsShiftKeyDown() and ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:Insert(LootLink_GetLink(this:GetText()));
		end
		if( IsControlKeyDown() ) then
			DressUpItemLink(LootLink_GetLink(this:GetText()));
		end
	elseif( button == "RightButton" ) then
		if( IsShiftKeyDown() and IsControlKeyDown() ) then
			--@todo Telo: add a confirmation dialog to this
			ItemLinks[this:GetText()] = nil;
			LootLink_Refresh();
		end
	end
	--@todo Telo: add a method to correct the color of items
end

function LootLink_OnShow()
	PlaySound("igMainMenuOpen");
	LootLink_Update();
end

function LootLink_OnHide()
	PlaySound("igMainMenuClose");
end

function LootLink_OnUpdate(elapsed)
	if( lCheckTooltip ) then
		lCheckTooltip = LootLink_CheckTooltipInfo();
	end
end

function LootLinkItemButton_OnEnter()
	local link = LootLink_GetHyperlink(this:GetText());
	if( link ) then
		LootLinkFrame.TooltipButton = this:GetID();
		LootLinkTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT");
		LootLink_SetHyperlink(LootLinkTooltip, this:GetText(), link);
		LootLink_AddTooltipInfo(this:GetText());
	end
end

function LootLinkItemButton_OnLeave()
	if( LootLinkFrame.TooltipButton ) then
		LootLinkFrame.TooltipButton = nil;
		HideUIPanel(LootLinkTooltip);
	end
end

function LootLinkFrameDropDown_OnLoad()
	UIDropDownMenu_Initialize(LootLinkFrameDropDown, LootLinkFrameDropDown_Initialize);
	LootLink_UIDropDownMenu_SetSelectedID(LootLinkFrameDropDown, 1, LOOTLINK_DROPDOWN_LIST);
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LootLinkFrameDropDown)
end

function LootLinkFrameDropDownButton_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(LootLinkFrameDropDown);
	UIDropDownMenu_SetSelectedID(LootLinkFrameDropDown, this:GetID());
	if( oldID ~= this:GetID() ) then
		LootLink_Refresh();
	end
end

function LLS_RarityDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_RarityDropDown);
end

function LLS_RarityDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, this:GetID());
end

function LLS_BindsDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_BindsDropDown);
end

function LLS_BindsDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, this:GetID());
end

function LLS_LocationDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_LocationDropDown);
end

function LLS_LocationDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, this:GetID());
end

function LLS_TypeDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_TypeDropDown);
end

function LLS_TypeDropDown_OnClick()
	local oldID = UIDropDownMenu_GetSelectedID(LLS_TypeDropDown);
	UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, this:GetID());
	if( oldID ~= this:GetID() ) then
		LootLink_SetupTypeUI(this:GetID(), 1);
	end
end

function LLS_SubtypeDropDown_OnLoad()
	UIDropDownMenu_SetWidth(90);
	UIDropDownMenu_SetButtonWidth(24);
	UIDropDownMenu_JustifyText("LEFT", LLS_SubtypeDropDown);
end

function LLS_SubtypeDropDown_OnClick()
	UIDropDownMenu_SetSelectedID(LLS_SubtypeDropDown, this:GetID());
end

--------------------------------------------------------------------------------------------------
-- Callback functions
--------------------------------------------------------------------------------------------------
function ToggleLootLink()
	if( LootLinkFrame:IsVisible() ) then
		HideUIPanel(LootLinkFrame);
	else
		ShowUIPanel(LootLinkFrame);
	end
end

function LootLink_SlashCommandHandler(msg)
	local reset;
	local makehome;
	local light;
	local aborted;

	if( not lDisableVersionReminder ) then
		LootLink_CheckVersionReminder();
	end
	if( not msg or msg == "" ) then
		ToggleLootLink();
	else
		local command = string.lower(msg);
		if( command == LOOTLINK_HELP ) then
			local index = 0;
			local value = getglobal("LOOTLINK_HELP_TEXT"..index);
			while( value ) do
				DEFAULT_CHAT_FRAME:AddMessage(value);
				index = index + 1;
				value = getglobal("LOOTLINK_HELP_TEXT"..index);
			end
		elseif( command == LOOTLINK_STATUS ) then
			LootLink_Status();
		elseif( command == LOOTLINK_AUCTION or command == LOOTLINK_SCAN ) then
			if( AuctionFrame:IsVisible() ) then
				local iButton;
				local button;

				-- Hide the UI from any current results, show the no results text so we can use it
				BrowseNoResultsText:Show();
				for iButton = 1, NUM_BROWSE_TO_DISPLAY do
					button = getglobal("BrowseButton"..iButton);
					button:Hide();
				end
				BrowsePrevPageButton:Hide();
				BrowseNextPageButton:Hide();
				BrowseSearchCountText:Hide();

				LootLink_StartAuctionScan();
			else
				lScanAuction = 1;
				LootLink_Status();
			end
		elseif( command == LOOTLINK_SHOWINFO ) then
			LootLinkState.HideInfo = nil;
			LootLink_Status();
		elseif( command == LOOTLINK_HIDEINFO ) then
			LootLinkState.HideInfo = 1;
			LootLink_Status();
		elseif( command == LOOTLINK_FULLMODE ) then
			LootLinkState.LightMode = nil;
			LootLink_Status();
		else
			local iStart;
			local iEnd;
			local args;
			
			iStart, iEnd, command, args = string.find(command, "^(%w+)%s*(.*)$");
	
			if( command == LOOTLINK_RESET ) then
				if( lResetNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_Reset();
						lResetNeedsConfirm = nil;
						lDisableVersionReminder = nil
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_DONE);
					end
				else
					reset = 1;
					lResetNeedsConfirm = 1;
					lDisableVersionReminder = 1;
				end
			elseif( LootLink_GetDataVersion() < 110 and command == LOOTLINK_MAKEHOME ) then
				if( lMakeHomeNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_MakeHome();
						lMakeHomeNeedsConfirm = nil;
						lDisableVersionReminder = nil;
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_DONE);
					end
				else
					makehome = 1;
					lMakeHomeNeedsConfirm = 1;
					lDisableVersionReminder = 1;
				end
			elseif( command == LOOTLINK_LIGHTMODE ) then
				if( lLightModeNeedsConfirm ) then
					if( args == LOOTLINK_CONFIRM ) then
						LootLink_LightMode();
						lLightModeNeedsConfirm = nil;
						DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_DONE);
					end
				else
					light = 1;
					lLightModeNeedsConfirm = 1;
				end
			end
		end
	end
	
	if( not reset ) then
		if( lResetNeedsConfirm ) then
			aborted = 1;
			lResetNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_ABORTED);
		end
	end
	
	if( not makehome ) then
		if( lMakeHomeNeedsConfirm ) then
			aborted = 1;
			lMakeHomeNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_ABORTED);
		end
	end
	
	if( not light ) then
		if( lLightModeNeedsConfirm ) then
			lLightModeNeedsConfirm = nil;
			DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_ABORTED);
		end
	end
	
	if( reset ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_RESET_NEEDS_CONFIRM);
	end
	
	if( makehome ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_MAKEHOME_NEEDS_CONFIRM);
	end
	
	if( light ) then
		DEFAULT_CHAT_FRAME:AddMessage(LOOTLINK_LIGHTMODE_NEEDS_CONFIRM);
	end
	
	if( aborted and not reset and not makehome ) then
		lDisableVersionReminder = nil
	end
end

function LootLink_Update()
	local iItem;
	
	if( not DisplayIndices ) then
		LootLink_BuildDisplayIndices();
	end
	FauxScrollFrame_Update(LootLinkListScrollFrame, DisplayIndices.onePastEnd - 1, LOOTLINK_ITEMS_SHOWN, LOOTLINK_ITEM_HEIGHT);
	for iItem = 1, LOOTLINK_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(LootLinkListScrollFrame);
		local lootLinkItem = getglobal("LootLinkItem"..iItem);
		
		if( itemIndex < DisplayIndices.onePastEnd ) then
			local color = { };
			local name = DisplayIndices[itemIndex];
			lootLinkItem:SetText(name);
			if( ItemLinks[name].c ) then
				color.r, color.g, color.b = LootLink_GetRGBFromHexColor(ItemLinks[name].c);
				lootLinkItem:SetTextColor(color.r, color.g, color.b);
				lootLinkItem.r = color.r;
				lootLinkItem.g = color.g;
				lootLinkItem.b = color.b;
			else
				lootLinkItem.r = 0;
				lootLinkItem.g = 0;
				lootLinkItem.b = 0;
			end
			lootLinkItem:Show();
			
			if( LootLinkFrame.TooltipButton and LootLinkFrame.TooltipButton == iItem ) then
				if( ItemLinks[name].i ) then
					LootLink_SetHyperlink(LootLinkTooltip, name, LootLink_GetHyperlink(name));
					LootLink_AddTooltipInfo(name);
				else
					LootLinkItemButton_OnLeave();
				end
			end
		else
			lootLinkItem:Hide();
		end
	end
end

function LootLink_Search()
	LootLinkSearchFrame:Show();
end

function LootLink_Refresh()
	FauxScrollFrame_SetOffset(LootLinkListScrollFrame, 0);
	getglobal("LootLinkListScrollFrameScrollBar"):SetValue(0);
	LootLink_BuildDisplayIndices();
	LootLink_Update();
end

function LootLink_DoSearch()
	LootLink_Refresh();
end

function LootLinkSearch_LoadValues()
	local sp = LootLinkFrame.SearchParams;
	local field;
	
	if( LootLinkState.LightMode ) then
		getglobal("LLS_TextDisabled"):Show();
		getglobal("LLS_TextEditBox"):Hide();
		getglobal("LLS_NameEditBox"):SetFocus();
	else
		getglobal("LLS_TextDisabled"):Hide();
		field = getglobal("LLS_TextEditBox");
		field:Show();
		field:SetFocus();
		if( sp and sp.text ) then
			field:SetText(sp.text);
		else
			field:SetText("");
		end
	end
	
	field = getglobal("LLS_NameEditBox");
	if( sp and sp.name ) then
		field:SetText(sp.name);
	else
		field:SetText("");
	end
	
	UIDropDownMenu_Initialize(LLS_RarityDropDown, LLS_RarityDropDown_Initialize);
	if( sp and sp.rarity ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, sp.rarity, LLS_RARITY_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_RarityDropDown, 1, LLS_RARITY_LIST);
	end
	
	UIDropDownMenu_Initialize(LLS_BindsDropDown, LLS_BindsDropDown_Initialize);
	if( sp and sp.binds ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, sp.binds, LLS_BINDS_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_BindsDropDown, 1, LLS_BINDS_LIST);
	end
	
	if( sp and sp.unique ) then
		getglobal("LLS_UniqueCheckButton"):SetChecked(1);
	else
		getglobal("LLS_UniqueCheckButton"):SetChecked(0);
	end
	
	UIDropDownMenu_Initialize(LLS_LocationDropDown, LLS_LocationDropDown_Initialize);
	if( sp and sp.location ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, sp.location, LLS_LOCATION_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_LocationDropDown, 1, LLS_LOCATION_LIST);
	end
	
	if( sp and sp.usable ) then
		getglobal("LLS_UsableCheckButton"):SetChecked(1);
	else
		getglobal("LLS_UsableCheckButton"):SetChecked(0);
	end
	
	field = getglobal("LLS_MinimumLevelEditBox");
	if( sp and sp.minLevel ) then
		field:SetText(sp.minLevel);
	else
		field:SetText("");
	end

	field = getglobal("LLS_MaximumLevelEditBox");
	if( sp and sp.maxLevel ) then
		field:SetText(sp.maxLevel);
	else
		field:SetText("");
	end
	
	UIDropDownMenu_Initialize(LLS_TypeDropDown, LLS_TypeDropDown_Initialize);
	if( sp and sp.type ) then
		LootLink_UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, sp.type, LLS_TYPE_LIST);
	else
		LootLink_UIDropDownMenu_SetSelectedID(LLS_TypeDropDown, 1, LLS_TYPE_LIST);
	end
	
	if( sp and sp.type ) then
		LootLink_SetupTypeUI(sp.type, sp.subtype);
	else
		LootLink_SetupTypeUI(1, 1);
	end

	field = getglobal("LLS_MinimumDamageEditBox");
	if( sp and sp.minMinDamage ) then
		field:SetText(sp.minMinDamage);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumDamageEditBox");
	if( sp and sp.minMaxDamage ) then
		field:SetText(sp.minMaxDamage);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumSpeedEditBox");
	if( sp and sp.maxSpeed ) then
		field:SetText(sp.maxSpeed);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumDPSEditBox");
	if( sp and sp.minDPS ) then
		field:SetText(sp.minDPS);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumArmorEditBox");
	if( sp and sp.minArmor ) then
		field:SetText(sp.minArmor);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumBlockEditBox");
	if( sp and sp.minBlock ) then
		field:SetText(sp.minBlock);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumSlotsEditBox");
	if( sp and sp.minSlots ) then
		field:SetText(sp.minSlots);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MinimumSkillEditBox");
	if( sp and sp.minSkill ) then
		field:SetText(sp.minSkill);
	else
		field:SetText("");
	end
	
	field = getglobal("LLS_MaximumSkillEditBox");
	if( sp and sp.maxSkill ) then
		field:SetText(sp.maxSkill);
	else
		field:SetText("");
	end
end

function LootLinkSearch_SaveValues()
	local sp;
	local interesting;
	local field;
	local value;
	
	LootLinkFrame.SearchParams = { };
	sp = LootLinkFrame.SearchParams;
	
	field = getglobal("LLS_TextEditBox");
	value = field:GetText();
	if( value and value ~= "" ) then
		sp.text = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_NameEditBox");
	value = field:GetText();
	if( value and value ~= "" ) then
		sp.name = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_RarityDropDown);
	if( value and value ~= 1 ) then
		sp.rarity = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_BindsDropDown);
	if( value and value ~= 1 ) then
		sp.binds = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_UniqueCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.unique = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_LocationDropDown);
	if( value and value ~= 1 ) then
		sp.location = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_UsableCheckButton");
	value = field:GetChecked();
	if( value ) then
		sp.usable = value;
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumLevelEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minLevel = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumLevelEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxLevel = tonumber(value);
		interesting = 1;
	end

	value = UIDropDownMenu_GetSelectedID(LLS_TypeDropDown);
	if( value and value ~= 1 ) then
		sp.type = value;
		interesting = 1;
	end
	
	value = UIDropDownMenu_GetSelectedID(LLS_SubtypeDropDown);
	if( value and value ~= 1 ) then
		sp.subtype = value;
		if( sp.type and sp.type ~= 1 ) then
			interesting = 1;
		end
	end

	field = getglobal("LLS_MinimumDamageEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minMinDamage = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumDamageEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minMaxDamage = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MaximumSpeedEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxSpeed = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumDPSEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minDPS = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumArmorEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minArmor = tonumber(value);
		interesting = 1;
	end
	
	field = getglobal("LLS_MinimumBlockEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minBlock = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MinimumSlotsEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minSlots = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MinimumSkillEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.minSkill = tonumber(value);
		interesting = 1;
	end

	field = getglobal("LLS_MaximumSkillEditBox");
	value = field:GetText();
	if( value and LootLink_CheckNumeric(value) ) then
		sp.maxSkill = tonumber(value);
		interesting = 1;
	end

	-- Only save search params if we had interesting data on the page	
	if( not interesting ) then
		LootLinkFrame.SearchParams = nil;
	else
		if( IsControlKeyDown() ) then
			sp.plain = nil;
		else
			sp.plain = 1;
		end
	end
end

function LootLinkSearchFrame_SaveSearchParams()
	LootLinkSearchFrame.OldSearchParams = LootLinkFrame.SearchParams;
end

function LootLinkSearchFrame_RestoreSearchParams()
	LootLinkFrame.SearchParams = LootLinkSearchFrame.OldSearchParams;
end

function LootLinkSearchFrame_Cancel()
	PlaySound("gsTitleOptionExit");
	LootLinkSearchFrame:Hide();
	LootLinkSearchFrame_RestoreSearchParams();
end

function LootLinkSearchFrame_Okay()
	PlaySound("gsTitleOptionOK");
	LootLinkSearchFrame:Hide();
	LootLinkSearch_SaveValues();
	LootLink_DoSearch();
end

--------------------------------------------------------------------------------------------------
-- External functions
--------------------------------------------------------------------------------------------------

-- Looks for and deconstructs links contained in a text string; if trusted, existing information will be verified
-- Trusted sources are everything except chat links; since these can be spoofed, we want to allow them to be replaced
function LootLink_ProcessLinks(text, trusted)
	local color;
	local item;
	local name;
	local lastName;
	
	if( text ) then
		for color, item, name in string.gfind(text, "|c(%x+)|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h|r") do
			if( color and item and name and name ~= "" ) then
				if( not ItemLinks[name] ) then
					ItemLinks[name] = { };
					ItemLinks[name].c = color;
					ItemLinks[name].i = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:%4");
					lItemLinksSizeTotal = lItemLinksSizeTotal + 1;

					if( LootLink_GetDataVersion() < 110 ) then
						-- Set a flag to indicate that this item is new and should be skipped on a makehome
						ItemLinks[name]._ = 1;
					end
				elseif( trusted ) then
					-- Verify existing information against the trusted source
					local link = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:%4");
					if( ItemLinks[name].c ~= color or ItemLinks[name].i ~= link ) then
						-- Existing information was incorrect -- replace and require data rebuild
						ItemLinks[name].c = color;
						ItemLinks[name].i = link;
						ItemLinks[name].d = nil;
						ItemLinks[name].t = nil;
					end
				end
				
				if( ItemLinks[name] ) then
					LootLink_BuildSearchData(name, ItemLinks[name]);
					if( not LootLink_CheckItemServerRaw(ItemLinks[name], lServerIndex) ) then
						LootLink_AddItemServer(ItemLinks[name], lServerIndex);
						lItemLinksSizeServer = lItemLinksSizeServer + 1;
					end
				end
				
				lastName = name;
			end
		end
		
		-- Now do a secondary pass for items without color; only store if we have no information for them
		for item, name in string.gfind(text, "|Hitem:(%d+:%d+:%d+:%d+)|h%[(.-)%]|h") do
			if( item and name and name ~= "" ) then
				if( not ItemLinks[name] ) then
					ItemLinks[name] = { };
					ItemLinks[name].c = "ff40ffc0";
					ItemLinks[name].i = string.gsub(item, "^(%d+):(%d+):(%d+):(%d+)$", "%1:0:%3:%4");
					lItemLinksSizeTotal = lItemLinksSizeTotal + 1;

					if( LootLink_GetDataVersion() < 110 ) then
						-- Set a flag to indicate that this item is new and should be skipped on a makehome
						ItemLinks[name]._ = 1;
					end
					
					if( not LootLink_CheckItemServerRaw(ItemLinks[name], lServerIndex) ) then
						LootLink_AddItemServer(ItemLinks[name], lServerIndex);
						lItemLinksSizeServer = lItemLinksSizeServer + 1;
					end

					LootLink_BuildSearchData(name, ItemLinks[name]);
				end
			end
		end
	end
	
	return lastName;
end

-- Adds extra tooltip information for the item with the given name
function LootLink_AddTooltipInfo(name, tooltip, quantity)
	if( not tooltip ) then
		tooltip = LootLinkTooltip;
	end
	if( not quantity ) then
		quantity = 1;
	end
	if( tooltip == LootLinkTooltip ) then
		LootLink_HideTooltipMoney();
	end
	if( not LootLinkState.HideInfo and ItemLinks[name] ) then
		if( tooltip == GameTooltip ) then
			GameTooltip.llDone = 1;
		end
		if( ItemLinks[name].p ) then
			LootLink_SetTooltipMoney(tooltip, quantity, ItemLinks[name].p, ItemLinks[name].x);
		end
		LootLink_AddExtraTooltipInfo(tooltip, name, quantity, ItemLinks[name]);
		tooltip:Show();
	end
end

-- This will set up a tooltip with item information for the given name if it's known
function LootLink_SetTooltip(tooltip, name, quantity)
	local link;
	
	if( tooltip and name ) then
		link = LootLink_GetHyperlink(name);
		if( link ) then
			LootLink_SetHyperlink(tooltip, name, link);
			if( quantity ) then
				quantity = tonumber(quantity);
			else
				quantity = 1;
			end
			if( quantity > 0 ) then
				LootLink_AddTooltipInfo(name, tooltip, quantity);
			end
		end
	end
end

-- Calling this will allow LootLink to automatically add information to tooltips when needed
function LootLink_AutoInfoOn()
	lSuppressInfoAdd = nil;
end

-- Calling this will prevent LootLink from automatically adding information to tooltips
function LootLink_AutoInfoOff()
	lSuppressInfoAdd = 1;
end

-- Use this function to get the current server name from LootLink's perspective
function LootLink_GetCurrentServerName()
	return lServer;
end

-- Use this function to get the current server index
function LootLink_GetCurrentServerIndex()
	return lServerIndex;
end

-- Use this function to map a server name to the server index for the ItemLinks[name].servers array
function LootLink_GetServerIndex(name)
	if( not LootLinkState or not LootLinkState.ServerNamesToIndices ) then
		return nil;
	end
	return LootLinkState.ServerNamesToIndices[name];
end

-- Use this function to check whether an ItemLinks[name] entry is valid for a given server index
function LootLink_CheckItemServer(item, serverIndex)
	-- If we haven't converted and this item predates multiple server support, count it as valid
	if( LootLink_GetDataVersion() < 110 and not item._ ) then
		return 1;
	end
	return LootLink_CheckItemServerRaw(item, serverIndex);
end

-- Used for debugging changes in item data and tooltip format
function LootLink_Validate()
	for index, value in ItemLinks do
		if( not value.d ) then
			DEFAULT_CHAT_FRAME:AddMessage(index.." has no search data");
--		else
--			if( not LL_SearchData(value, "su") ) then
--				DEFAULT_CHAT_FRAME:AddMessage(index.." has no subtype");
--			end
		end
	end
end

--------------------------------------------------------------------------------------------------
-- Hookable callback functions
--------------------------------------------------------------------------------------------------

-- Hook this function to add any extra information you like to the tooltip
function LootLink_AddExtraTooltipInfo(tooltip, name, quantity, item)
	-- tooltip: the current tooltip frame
	-- name: the name of the item
	-- quantity: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
end

-- Hook this function to be called whenever an equipment slot is successfully inspected
function LootLink_Event_InspectSlot(name, count, item, unit, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- unit: "target", "player", etc.
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever an inventory slot is successfully inspected
function LootLink_Event_ScanInventory(name, count, item, bagid, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- bagid: the id of the bag containing the item
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever a bank slot is successfully inspected
function LootLink_Event_ScanBank(name, count, item, bagid, slotid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- bagid: the id of the bag containing the item
	-- slotid: the id of the slot inspected
end

-- Hook this function to be called whenever an auction entry is successfully inspected
function LootLink_Event_ScanAuction(name, count, item, auctionpage, auctionid)
	-- name: the name of the item
	-- count: the number of items, if known, else 1
	-- item: ItemLinks[name]; LootLink's data for this item
	-- auctionpage: the page number this item was found on
	-- auctionid: the id of the inspected item
end

-- Hook this function to be called whenever a chat message is successfully inspected
function LootLink_Event_ScanChat(name, item, text)
	-- name: the name of the last item in the chat message
	-- item: ItemLinks[name]; LootLink's data for this item
	-- text: the inspected chat message
end

-- Hook this function to be called whenever LootLink starts an auction scan
function LootLink_Event_StartAuctionScan()
end

-- Hook this function to be called whenever LootLink stops an auction scan
function LootLink_Event_StopAuctionScan()
end

-- Hook this function to be called whenever LootLink completes a full auction scan
function LootLink_Event_FinishedAuctionScan()
end

-- Hook this function to be called whenever LootLink sends a new auction query
function LootLink_Event_AuctionQuery(auctionpage)
	-- auctionpage: the page number for the query that was just sent
end
