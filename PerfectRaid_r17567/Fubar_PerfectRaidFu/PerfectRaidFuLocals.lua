local L = AceLibrary("AceLocale-2.0"):new("PerfectRaidFu")

L:RegisterTranslations("enUS", function() return {
	NAME = "FuBar - PerfectRaidFu",
	DESCRIPTION = "Fubar2 plugin for PerfectRaid",
	HIDE_LABEL = "Hide Minimap Button",	

	HINT = "Hint",
	HINT_DESC = "Left click to frame locked",

	LOCKED = "Locked",
	UNLOCKED = "Unlocked"
} end )

L:RegisterTranslations("koKR", function() return {
	NAME = "FuBar - PerfectRaidFu",
	DESCRIPTION = "PerfectRaid용 Fubar2 플러그인",
	HIDE_LABEL = "미니맵 버튼 숨김",
	
	HINT = "힌트",
	HINT_DESC = "좌클릭시 창을 고정합니다.",

	LOCKED = "고정됨",
	UNLOCKED = "이동가능"
} end )
