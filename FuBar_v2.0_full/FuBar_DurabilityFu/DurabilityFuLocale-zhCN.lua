local L = AceLibrary("AceLocale-2.2"):new("FuBar_DurabilityFu")

L:RegisterTranslations("zhCN", function() return {
	["Total"] = "总计",
	["Percent"] = "百分比",
	["Repair cost"] = "修理费用",
	["Repair"] = "修理",
	["Equipment"] = "装备",
	["Inventory"] = "背包",
	["Show repair popup at vendor"] = "当与商人对话时显示修理对话框",
	["Toggle whether to show the popup at the merchant window"] = "设置是否当与商人对话时显示修理对话框",
	["Show the armored man"] = "显示装备损坏状态人偶",
	["Toggle whether to show Blizzard's armored man"] = "设置是否显示暴雪的装备损坏状态人偶",
	["Show average value"] = "显示平均值",
	["Toggle whether to show your average or minimum durability"] = "设置显示损坏度的平均值还是最小值",
	["Show healthy items"] = "显示完好物品",
	["Toggle whether to show items that are healthy (100% repaired)"] = "设置是否显示不需要修理的完好物品",
	["Auto repair"] = "自动修理",
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)