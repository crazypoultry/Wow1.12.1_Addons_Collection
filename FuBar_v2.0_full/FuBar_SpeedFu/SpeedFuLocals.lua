local L = AceLibrary("AceLocale-2.0"):new("SpeedFu")

L:RegisterTranslations("enUS", function() return {

	MENU_CALIBRATE = "Set new rate",
	MENU_RESET = "Reset all rates",
	MENU_DIGIT = "Constant text width",

	TOOLTIP_CALIBRATE = "Clicking this option when you're running at normal speed will recalibrate the base rate of current zone.",
	TOOLTIP_RESET = "Resets base rate of all zones to default value.",
	TOOLTIP_DIGIT = "Speed will always shown in three digits.",

	TEXT_HINT = "Speed relative to normal run-speed.",	
	RESET_CONFIRM = "Are you sure you want to reset all base-rates for FuBar - Speed?",
	RESET_BASERATE = "Predefined base-rates set for all zones.",
	
	NEW_BASERATE_FORMAT = "Base-rate for zone %s set to %f",
	
	-- Special zone names	
	BLACKROCK		= "Blackrock Mountain",
	WARSONG			= "Warsong Gulch",
	ALTERAC			= "Alterac Valley",
	ARATHI			= "Arathi Basin",
	
} end )

L:RegisterTranslations("koKR", function() return {

	MENU_CALIBRATE = "새 비율 설정",
	MENU_RESET = "비율 초기화",
	MENU_DIGIT = "3자리로 속도 표시",

	TOOLTIP_CALIBRATE = "정규 속도로 달리는 중에 이 버튼을 누르면 현재 지역의 비율을 다시 측정 합니다.",
	TOOLTIP_RESET = "모든 지역의 비율을 기본값으로 초기화 합니다.",
	TOOLTIP_DIGIT = "3자리 숫자로 속도 표시",

	TEXT_HINT = "기본 달리기 속도에 비교 해본 속도",	
	RESET_CONFIRM = "FuBar - Speed의 기본 속도 비율을 초기화 하시겠습니까?",
	RESET_BASERATE = "미리 정의된 속도로 모든 지역의 비율이 설정 되었습니다.",
	
	NEW_BASERATE_FORMAT = "%s 지역의 기본 비율이 %f 로 설정 되었습니다.",
	
	-- Special zone names	
	BLACKROCK		= "검은 바위 산",
	WARSONG			= "전쟁노래 협곡",
	ALTERAC			= "알터랙 계곡",
	ARATHI			= "아라시 분지",
	
} end )

