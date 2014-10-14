local L = AceLibrary("AceLocale-2.2"):new("FuBar_DurabilityFu")

L:RegisterTranslations("koKR", function() return {
	["Total"] = "총계",
	["Percent"] = "비율",
	["Repair cost"] = "수리 비용",
	["Repair"] = "수리",
	["Equipment"] = "장비",
	["Inventory"] = "가방",
	["Show repair popup at vendor"] = "수리 팝업 표시",
	["Toggle whether to show the popup at the merchant window"] = "상인창에 팝업 표시 토글",
	["Show the armored man"] = "수리 NPC 표시",
	["Toggle whether to show Blizzard's armored man"] = "Blizzard의 수리 NPC 표시 토글",
	["Show average value"] = "평균 가격 표시",
	["Toggle whether to show your average or minimum durability"] = "평균 혹은 최소 내구도 표시",
	["Show healthy items"] = "상태가 좋은 아이템 표시",
	["Toggle whether to show items that are healthy (100% repaired)"] = "100% 수리된 아이템 표시 토글",
	["Auto repair"] = "자동 수리",
	
	["AceConsole-Commands"] = {"/durfu", "/durabilityfu"}
} end)
