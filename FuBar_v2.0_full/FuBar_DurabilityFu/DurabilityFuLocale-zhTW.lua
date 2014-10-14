local L = AceLibrary("AceLocale-2.2"):new("FuBar_DurabilityFu")

L:RegisterTranslations("zhTW", function() return {
	["Total"] = "總計",
	["Percent"] = "百分比",
	["Repair cost"] = "修理費用",
	["Repair"] = "修理",
	["Equipment"] = "裝備",
	["Inventory"] = "背包",
	["Show repair popup at vendor"] = "當與商人對話時顯示修理對話框",
	["Toggle whether to show the popup at the merchant window"] = "設定是否當與商人對話時顯示修理對話框",
	["Show the armored man"] = "顯示裝備損壞狀態人偶",
	["Toggle whether to show Blizzard's armored man"] = "設定是否顯示Blizzard的裝備損壞狀態人偶",
	["Show average value"] = "顯示平均值",
	["Toggle whether to show your average or minimum durability"] = "設定顯示損壞度的平均值還是最小值",
	["Show healthy items"] = "顯示完好物品",
	["Toggle whether to show items that are healthy (100% repaired)"] = "設定是否顯示不需要修理的完好物品",
	["Auto repair"] = "自動修理",
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)

