-- Inventory On Par --


--------------------------------------------------------------------------------------------------
-- Localized global variables
--------------------------------------------------------------------------------------------------

INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" , 			desc = "Head",			weight = 1.00, minLevel = 30 },
    { name = "NeckSlot" , 			desc = "Neck",			weight = 0.54, minLevel = 30 },
    { name = "ShoulderSlot" , 		desc = "Shoulders",		weight = 0.74, minLevel = 20 },
    { name = "BackSlot" , 			desc = "Back",			weight = 0.54, minLevel = 1 },
    { name = "ChestSlot" , 			desc = "Chest",			weight = 1.00, minLevel = 1 },
--    { name = "ChestSlot" , 		desc = "Shirt" },
--    { name = "TabardSlot" , 		desc = "Tabard" },
    { name = "WristSlot" , 			desc = "Wrist",			weight = 0.54, minLevel = 1 },
    { name = "HandsSlot" , 			desc = "Hands",			weight = 0.74, minLevel = 1 },
    { name = "WaistSlot" , 			desc = "Waist",			weight = 0.74, minLevel = 1 },
    { name = "LegsSlot" , 			desc = "Legs",			weight = 1.00, minLevel = 1 },
    { name = "FeetSlot" , 			desc = "Feet",			weight = 0.74, minLevel = 1 },
    { name = "Finger0Slot" , 		desc = "1st Finger",	weight = 0.54, minLevel = 20 },
    { name = "Finger1Slot" , 		desc = "2nd Finger",	weight = 0.54, minLevel = 20 },
    { name = "Trinket0Slot" , 		desc = "1st Trinket",	weight = 0.67, minLevel = 40 },
    { name = "Trinket1Slot" , 		desc = "2nd Trinket",	weight = 0.67, minLevel = 40 },
    { name = "MainHandSlot" , 		desc = "Main Hand",		weight = 0.50, minLevel = 1 },
    { name = "SecondaryHandSlot" , 	desc = "Off Hand",		weight = 0.50, minLevel = 1 },
    { name = "RangedSlot" , 		desc = "Range Weapon",	weight = 0.50, minLevel = 1 },
};
IOP_BUTTONTEXT = "On Par";
IOP_TH_AXE = "Two-Handed Axes";
IOP_TH_MACE = "Two-Handed Maces";
IOP_TH_SWORD = "Two-Handed Swords";
IOP_STAVES = "Staves";
IOP_POLEARMS = "Polearms";

IOP_POOR = "Poor";
IOP_COMMON = "Common";
IOP_UNCOMMON = "Uncommon";
IOP_RARE = "Rare";
IOP_EPIC = "Epic";
IOP_LEGENDARY = "Legendary";
IOP_ARTIFACT = "Artifact";
IOP_UNKNOWN = "Unknown";

-- Get the client language
local clientLanguage = GetLocale();

-- Check the client language
if (clientLanguage == "deDE") then
	INVENTORY_SLOT_LIST = {
	{ name = "HeadSlot" , 			desc = "Kopf", 			weight = 1.00, minLevel = 30 },
	{ name = "NeckSlot" , 			desc = "Hals", 			weight = 0.54, minLevel = 30 },
	{ name = "ShoulderSlot" , 		desc = "Schultern", 	weight = 0.74, minLevel = 20 },
	{ name = "BackSlot" , 			desc = "R\195\188cken", weight = 0.54, minLevel = 1 },
	{ name = "ChestSlot" , 			desc = "Brust", 		weight = 1.00, minLevel = 1 },
	-- { name = "ChestSlot" , 		desc = "Hemd" },
	-- { name = "TabardSlot" , 		desc = "Wappenrock" },
	{ name = "WristSlot" , 			desc = "Handgelenke", 	weight = 0.54, minLevel = 1 },
	{ name = "HandsSlot" , 			desc = "H\195\164nde", 	weight = 0.74, minLevel = 1 },
	{ name = "WaistSlot" , 			desc = "Taille", 		weight = 0.74, minLevel = 1 },
	{ name = "LegsSlot" , 			desc = "Beine", 		weight = 1.00, minLevel = 1 },
	{ name = "FeetSlot" , 			desc = "F\195\188\195\159e", weight = 0.74, minLevel = 1 },
	{ name = "Finger0Slot" , 		desc = "1. Finger", 	weight = 0.54, minLevel = 20 },
	{ name = "Finger1Slot" , 		desc = "2. Finger", 	weight = 0.54, minLevel = 20 },
	{ name = "Trinket0Slot" , 		desc = "1. Schmuck", 	weight = 0.67, minLevel = 40 },
	{ name = "Trinket1Slot" , 		desc = "2. Schmuck", 	weight = 0.67, minLevel = 40 },
	{ name = "MainHandSlot" , 		desc = "Waffenhand", 	weight = 0.50, minLevel = 1 },
	{ name = "SecondaryHandSlot" , 	desc = "Schildhand", 	weight = 0.50, minLevel = 1 },
	{ name = "RangedSlot" , 		desc = "Distanz", weight = 0.50, minLevel = 1 },
	};
	IOP_TH_AXE = "Zweihand\195\164xte";
	IOP_TH_MACE = "Zweihandstreitkolben";
	IOP_TH_SWORD = "Zweihandschwerter";
	IOP_STAVES = "St\195\164be";
	IOP_POLEARMS = "Stangenwaffen";

	IOP_POOR = "Poor";
	IOP_COMMON = "Common";
	IOP_UNCOMMON = "Uncommon";
	IOP_RARE = "Rare";
	IOP_EPIC = "Epic";
	IOP_LEGENDARY = "Legendary";
	IOP_ARTIFACT = "Artifact";
	IOP_UNKNOWN = "Unknown";
elseif (clientLanguage == "frFR") then
	INVENTORY_SLOT_LIST = {
	    { name = "HeadSlot" , 			desc = "Head",			weight = 1.00, minLevel = 30 },
	    { name = "NeckSlot" , 			desc = "Neck",			weight = 0.54, minLevel = 30 },
	    { name = "ShoulderSlot" , 		desc = "Shoulders",		weight = 0.74, minLevel = 20 },
	    { name = "BackSlot" , 			desc = "Back",			weight = 0.54, minLevel = 1 },
	    { name = "ChestSlot" , 			desc = "Chest",			weight = 1.00, minLevel = 1 },
	--    { name = "ChestSlot" , 		desc = "Shirt" },
	--    { name = "TabardSlot" , 		desc = "Tabard" },
	    { name = "WristSlot" , 			desc = "Wrist",			weight = 0.54, minLevel = 1 },
	    { name = "HandsSlot" , 			desc = "Hands",			weight = 0.74, minLevel = 1 },
	    { name = "WaistSlot" , 			desc = "Waist",			weight = 0.74, minLevel = 1 },
	    { name = "LegsSlot" , 			desc = "Legs",			weight = 1.00, minLevel = 1 },
	    { name = "FeetSlot" , 			desc = "Feet",			weight = 0.74, minLevel = 1 },
	    { name = "Finger0Slot" , 		desc = "1st Finger",	weight = 0.54, minLevel = 20 },
	    { name = "Finger1Slot" , 		desc = "2nd Finger",	weight = 0.54, minLevel = 20 },
	    { name = "Trinket0Slot" , 		desc = "1st Trinket",	weight = 0.67, minLevel = 40 },
	    { name = "Trinket1Slot" , 		desc = "2nd Trinket",	weight = 0.67, minLevel = 40 },
	    { name = "MainHandSlot" , 		desc = "Main Hand",		weight = 0.50, minLevel = 1 },
	    { name = "SecondaryHandSlot" , 	desc = "Off Hand",		weight = 0.50, minLevel = 1 },
	    { name = "RangedSlot" , 		desc = "Range Weapon",	weight = 0.50, minLevel = 1 },
	};
	IOP_TH_AXE = "Two-Handed Axes";
	IOP_TH_MACE = "Two-Handed Maces";
	IOP_TH_SWORD = "Two-Handed Swords";
	IOP_STAVES = "Staves";
	IOP_POLEARMS = "Polearms";

	IOP_POOR = "Poor";
	IOP_COMMON = "Common";
	IOP_UNCOMMON = "Uncommon";
	IOP_RARE = "Rare";
	IOP_EPIC = "Epic";
	IOP_LEGENDARY = "Legendary";
	IOP_ARTIFACT = "Artifact";
	IOP_UNKNOWN = "Unknown";
end
