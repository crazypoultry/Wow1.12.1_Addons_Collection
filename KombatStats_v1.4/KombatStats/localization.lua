-- ================================
-- KombatStats  Localization Strings
-- ================================

if GetLocale() == "zhTW" then
-- 戰鬥中的 shadow 傷害翻譯為「暗影」，可是這個變數卻翻譯成「陰影」，莫名其妙。
-- KombatStats 是用這個變數來判定法術傷害是否為 shadow 的，所以我在此把它強制改為正確的翻譯，希望沒有影響到其他的UI。
	SPELL_SCHOOL5_CAP = "暗影";	
	SPELL_SCHOOL5_NAME = "暗影";
end


KombatStats.loc = {

	NAME = "KombatStats",
	
	PAUSED = "Paused",
	
	MENU_HIDE_LABEL = "Hide Label",
	TOOLTIP_HIDE_LABEL = "Hides the label on DPS frame.",
	
	MENU_SCALE = "Frame Scale",
	TOOLTIP_SCALE = "Adjust the scaling of DPS frame and stats frame.",
	
	MENU_CONSTANT_WIDTH = "Constant frame width",
	TOOLTIP_CONSTANT_WIDTH = "Set a constant width for DPS frame",
	
	MENU_MERGE_DPS = "Add pet to player",
	TOOLTIP_MERGE_DPS = "Will show combined values of pet and player on the player's values",
	
	MENU_PAUSE = "Pause parsing",
	TOOLTIP_PAUSE = "Stop listening to combat events.",
	
	MENU_RESET = "Reset DPS Session",
	TOOLTIP_RESET = "Reset the 'session' set of DPS data",
	
	MENU_LOCK = "Lock frames",
	TOOLTIP_LOCK = "Lock both DPS frame and stats frame.",
	
	MENU_AUTO_HIDE_PET = "Auto hide pet",
	TOOLTIP_AUTO_HIDE_PET = "Do not show pet on the DPS frame when you don't have a pet.",
	
	MENU_TEXT_SHOW = "Text shows: ",
	TOOLTIP_TEXT_SHOW = "Select what values to be shown on the DPS frame",
	
	MENU_TOOLTIP_SHOW = "Tooltip shows:",
	TOOLTIP_TOOLTIP_SHOW = "Select which character's DPS data to be shown on the tooltip.",
	
	MENU_CLEAR_DPS = "Clear DPS data of: ",
	TOOLTIP_CLEAR_DPS = "Purge a character's DPS data",
	
	MENU_STATS_SKIP_ABSORB = "Ignore partial absorbs",
	TOOLTIP_STATS_SKIP_ABSORB = "Will not record damages which has partial absorbs.",
	
	MENU_STATS_SKIP_RESIST = "Ignore partial resists",
	TOOLTIP_STATS_SKIP_RESIST = "Will not record damages which has partial resists.",
	
	MENU_STATS_SKIP_BLOCK = "Ignore partial blocks",
	TOOLTIP_STATS_SKIP_BLOCK = "Will not record damages which has partial blocks.",

	MENU_STATS_SKIP_VULNERABLE = "Ignore vulnerables",
	TOOLTIP_STATS_SKIP_VULNERABLE = "Will not record damages which has vulnerable damage bonus.",
	
	SKILL_MELEE = "Melee",
	SKILL_TOTAL = "Total",	-- The "Total" in all lists.
	SKILL_DAMAGE_SHIELD = "Damage Shields",
	
	STATS = "Stats",
	DPS = "DPS",
	HPS = "HPS",
	DTPS = "DTPS",
	
	PLAYER_DPS = "Player DPS",
	PLAYER_DTPS = "Player DTPS",
	PLAYER_HPS = "Player HPS",
	PET_DPS = "Pet DPS",
	PET_DTPS = "Pet DTPS",
	PET_HPS = "Pet HPS",
	
	
	TOTAL = "Total",
	LABEL_DPS = "DPS:",
	LABEL_PET = "Pet:",	
	
	TOOLTIP_HINT = "Click to toggle stats frame, select another character to shown here by the right click drop down menu",

	COUNT = "Count",
	PERCENT = "%",
	MINIMUM = "Min",
	MAXIMUM = "Max",
	AVERAGE = "Avg",
	TOTAL = "Total",
	HIT = "Hit",
	CRIT = "Crit",

	DOT = "DOT",
	GB = "GB", -- Glancing Blow.
	CB = "CB", -- Crushing Blow.


	MISS = "Miss",
	DODGE = "Dodge",
	PARRY = "Parry",
	BLOCK = "Block",
	DEFLECT = "Deflect",
	RESIST = "Resist",

	session = "Session",
	last = "Last",
	all = "All",

	SUMMARY = "Count: |cffffffff%d|r, To Hit |cffffffff%d%%|r. Damage: |cffffffff%d|r, |cffffffff%d%%|r of all.",

	SLASH_HELPS = {
		"/ks show : shows the DPS frame.",
		"/ks hide : hides the DPS frame.",
		"/ks stop : pauses stats tracking.",
		"/ks start : continues stats tracking.",
	},

	KombatStatsFrameDatasetButton_Tooltip = "Dataset: click to toggle between all, session and last fight.",
	KombatStatsFrameCharButton_Tooltip = "Character: left click to change, shift-click to delete.",
	KombatStatsFrameCategoryButton_Tooltip = "Category: click to toggle between attack, defend and heal.";
	KombatStatsFrameSkillButton_Tooltip = "Skill: left click to change, shift-click to delete.",
}



