local L = AceLibrary("AceLocale-2.2"):new("PetInFu")

L:RegisterTranslations("enUS", function() return {
	["DefaultIcon"] = "Interface\\Icons\\Ability_Hunter_BeastCall",
	["ChatCommands"] = {"/petinfu", "/pif"},
	
	["Settings"] = true,
	["Configuration options"] = true,
	["Toggle on click"] = true,
	["Toggle your pet by clicking on the panel"] = true,
	
	["Toggle pet"] = true,
	["Summon/unsummon your pet"] = true,
	
	["Basics"] = true,
	["Hunter"] = true,
	["Combat"] = true,
	["Stats"] = true,
	
	["Name"] = true,
	["Level"] = true,
	["Type"] = true,
	
	["Eats"] = true,
	["Loyalty"] = true,
	["Happiness"] = true,
	["Damage Percentage"] = true,
	["Loyalty Rate"] = true,
	["Current XP"] = true,
	["Total XP"] = true,
	["Needed XP"] = true,
	["Training Points"] = true,
	
	["Armor"] = true,
	["Attack Rating"] = true,
	["Attack Speed"] = true,
	["Listed DPS"] = true,
	["Actual DPS"] = true,
	
	["Unhappy"] = true,
	["Content"] = true,
	["Happy"] = true,
	
	["Gaining Loyalty"] = true,
	["Losing Loyalty"] = true,
	
	["No pet"] = true,
	["Unknown"] = true,

	["Dismiss Pet"] = true,
	["Call Pet"] = true,

} end)

--[[
if (not ace:LoadTranslation("FuBar_PetInfo")) then

	FuBar_PetInfoLocals = {
		NAME = "FuBar - PetInfo",
		DESCRIPTION = "Display pet info.",
		COMMANDS = {"/fbpetinfo", "/fubar_petinfo"},
		CMD_OPTIONS = {},
		TOOLTIP_TITLE = "|cffffffffPetInfo",
		TOOLTIP_HINT_TEXT = "Click to PetInfo.",
		
		PETINFO_FORMAT = "%d",
		PETINFO_PERCENT_FORMAT = "%d (%.1f%%)",
		PETINFO_AS_FORMAT = "%.2f",
		PETINFO_DPS_FORMAT = "%.1f",
		PETINFO_BUTTON_LABEL_PETINFO = "Pet:",
		PETINFO_BUTTON_LABEL_PETNAME = "Name:",
		PETINFO_BUTTON_LABEL_PETLEVEL = "Level:",
		PETINFO_BUTTON_LABEL_TYPE = "Type:",
		PETINFO_BUTTON_LABEL_NOPET = "No pet",
		PETINFO_BUTTON_LABEL_FOOD = "Eats:",
		PETINFO_BUTTON_LABEL_LOYALTY = "Loyalty:",
		PETINFO_BUTTON_LABEL_HAPPINESS = "Happiness:",
		PETINFO_BUTTON_LABEL_DAMAGEPERCT = "Damage Percentage:",
		PETINFO_BUTTON_LABEL_LOYALTYRATE = "Loyalty Rate:",
		PETINFO_BUTTON_LABEL_TRAINING_POINTS = "Training Points:",
		PETINFO_BUTTON_LABEL_ARMOR_CLASS = "Armor:",
		PETINFO_BUTTON_LABEL_ATTACK_SPEED = "Attack Speed:",
		PETINFO_BUTTON_LABEL_ATTACK_RATE = "Attack Rating:",
		PETINFO_BUTTON_LABEL_DPS_ACTUAL = "Actual DPS:",
		PETINFO_BUTTON_LABEL_DPS_LISTED = "Listed DPS:",
		PETINFO_BUTTON_LABEL_CURRENT_XP = "Current XP:",
		PETINFO_BUTTON_LABEL_NEEDED_XP = "Needed XP:",
		PETINFO_BUTTON_LABEL_TOTAL_XP = "Required XP:",
		PETINFO_BUTTON_LABEL_LEVEL_TIME_LEFT = "Time to Level:",
		PETINFO_BUTTON_LABEL_XP_PER_MIN = "XP Per Minute:",
		PETINFO_TOOLTIP = "Pet Info",
		PETINFO_MENU_TEXT = "Pet Info",
		PETINFO_NOLEVEL1 = "Not gaining XP due",
		PETINFO_NOLEVEL2 = "to level restriction",
		PETINFO_MENU_SHOW_PET_NAME = "Show pet's name.",
		PETINFO_MENU_SHOW_PET_LEVEL = "Show pet's level.",
		PETINFO_MENU_SHOW_BAR_TEXT = "Show pet's XP info in XP bar.",
		PETINFO_MENU_SHOW_PET_ATTRIB = "Show pet's attributes.",
		PETINFO_MENU_RESET_SESSION = "Reset session",
		PETINFO_MENU_GENDER = "Gender",
		PETINFO_MENU_MALE = "Male",
		PETINFO_MENU_FEMALE = "Female",
		PETINFO_MENU_CALLDISMISSPET = "Call / Dismiss Pet",
		PETINFO_UNHAPPY_TEXT = "Unhappy",
		PETINFO_CONTENT_TEXT = "Content",
		PETINFO_HAPPY_TEXT = "Happy",
		PETINFO_GAININGLOYALTY_TEXT = "Gaining Loyalty",
		PETINFO_LOSINGLOYALTY_TEXT = "Losing Loyalty"
	}
	
end
--]]