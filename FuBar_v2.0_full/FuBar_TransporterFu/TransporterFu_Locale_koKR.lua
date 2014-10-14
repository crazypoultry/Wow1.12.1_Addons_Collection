local L = AceLibrary("AceLocale-2.2"):new("TransporterFu")

L:RegisterTranslations("koKR", function() return {
	["Desc"] = "교통수단을 쉽게 사용합니다.",
	
	["METHOD1"] = "이동수단: ",
	["INN"] = "여관: ",
	
	["SHOW_COOLDOWN"] = "대기시간 표시",
	["SHOW_TAG"] = "설명 표시",
   
   --Transport methods
   ["ASTRAL"] = "영혼의 귀환",
   ["PORT_MG"] = "순간이동: 달의 숲",
   ["TELEPORT_UC"] = "순간이동: 언더시티",
   ["TELEPORT_SW"] = "순간이동: 스톰윈드",
   ["TELEPORT_OG"] = "순간이동: 오그리마",
   ["TELEPORT_IF"] = "순간이동: 아이언포지",
   ["TELEPORT_TB"] = "순간이동: 썬더 블러프",
   ["TELEPORT_DN"] = "순간이동: 다르나서스",
   ["PORTAL_UC"] = "차원의 문: 언더시티",
   ["PORTAL_SW"] = "차원의 문: 스톰윈드",
   ["PORTAL_OG"] = "차원의 문: 오그리마",
   ["PORTAL_IF"] = "차원의 문: 아이언포지",
   ["PORTAL_TB"] = "차원의 문: 썬더 블러프",
   ["PORTAL_DN"] = "차원의 문: 다르나서스",
   ["WARHORSE"] = "군마 소환",
   ["CHARGER"] = "군마 소환",
   ["FELSTEED"] = "지옥마 소환",
   ["DREADSTEED"] = "공포마 소환",
      
   ["MENU_SET"] = "메뉴 이동방법 설정",
   ["MANUAL"] = "수동 갱신",
      
   ["NA"] = "없음",
   ["READY"] = "준비됨",
   
   ["HINT"] = "좌클릭으로 선택한 이동수단을 실행.",
   
   ["PT_FOUND"] = "PeriodicTable found, items will be supported.",
   ["PT_SET_EXISTS"] = "The set %s already exists in PeriodicTable!",
   ["PT_NOT_FOUND"] = "PeriodicTable not found, Item support not enabled.",
   ["SE_FOUND"] = "SpecialEvents found",
   ["SE_NOT_FOUND"] = "SpecialEvents not found, this probably isn't going to work!",
} end)