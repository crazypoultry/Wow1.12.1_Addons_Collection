local L = AceLibrary("AceLocale-2.2"):new("FuXP")

L:RegisterTranslations("enUS", function() return {
	["AceConsole-commands"] = { "/FuXPFu" },

	["Colours"] = true,
	["Set the Bar Colours"] = true,

	["Properties"] = true,
	["Set the Bar Properties"] = true,

	["Current XP"] = true,
	["Sets the color of the XP Bar"] = true,

	["Rested XP"] = true,
	["Sets the color of the Rested Bar"] = true,

	["No XP"] = true,
	["Sets the empty color of the XP Bar"] = true,
	
	["Reputation"] = true,
	["Sets the color of the Rep Bar"] = true,
	
	["No Rep"] = true,
	["Sets the empty color of the Reputation Bar"] = true,

	["Show XP Bar"] = true,
	["Show the XP Bar"]  = true,
	
	["Show Rep Bar"] = true,
	["Show the Reputation Bar"] = true,

	["Spark intensity"] = true,
	["Brightness level of Spark"] = true,

	["Thickness"] = true,
	["Sets thickness of XP Bar"] = true,

	["Shadow"] = true,
	["Toggles Shadow under XP Bar"] = true,

	["Remaining"] = true,
	["Show Remaining in Bar"] = true,

	["Select Faction"] = true,
	["Faction"] = true,
	
	["Watched Faction"] = true,

	["Hook-ins"] = true,
	["Options to hook in other addons"] = true,

	["FuBar Faction Link"]= true,
	["Link to FubBar Factions"] = true,
	
	["Tek AutoRep"] = true,
	["Hook into TekAutoRep's automatic rep changes"] = true,
	
	['Location'] = true,
	["Undocked Position"] = true,
	["Selects which side of an undocked panel you want the bars on."] = true,

	["XP|Rep|None"] = true,
	["Show Text"] = true,
	["Show the XP or Rep"] = true,

	["%s: %3.0f%% (%s/%s) %s left"] = true,
	["%s to go (%3.0f%%)"] = true,

	["Current XP"] = true,
	["To Level"] = true,
	["Rested XP"] = true,
	["Click to send your current xp to an open editbox."] = true,
	["Shift Click to send your current rep to an open editbox."] = true,
	["Faction"] = true,
	["Rep to next standing"] = true,
	["Current rep"] = true,

	["%s/%s (%3.0f%%) %d to go"] = true,
	["%s:%s/%s (%3.2f%%) Currently %s with %d to go"] = true,

	["Top"] = true, 
	["Bottom"] = true,
	["XP"] = true,
	["Rep"] = true,
	["None"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["AceConsole-commands"] = { "/FuXPFu" },

	["Colours"] = "색상",
	["Set the Bar Colours"] = "바의 색상을 설정합니다",

	["Properties"] = "외양",
	["Set the Bar Properties"] = "바의 표시 내용을 설정합니다",

	["Current XP"] = "현재 경험치",
	["Sets the color of the XP Bar"] = "현재 경험치 바의 색상을 설정합니다",

	["Rested XP"] = "휴식 경험치",
	["Sets the color of the Rested Bar"] = "휴식 경험치 바의 색상을 설정합니다",

	["No XP"] = "남은 경험치",
	["Sets the empty color of the XP Bar"] = "남은 경험치 바의 색상을 설정합니다",
	
	["Reputation"] = "평판",
	["Sets the color of the Rep Bar"] = "평판바의 색상을 설정합니다",
	
	["No Rep"] = "남은 평판",
	["Sets the empty color of the Reputation Bar"] = "남은 평판바의 색상을 설정합니다",

	["Show XP Bar"] = "경험치바 표시",
	["Show the XP Bar"]  = "경험치 바를 표시합니다",
	
	["Show Rep Bar"] = "평판바 표시",
	["Show the Reputation Bar"] = "평판바를 표시합니다",

	["Spark intensity"] = "구분선",
	["Brightness level of Spark"] = "구분선의 밝기 정도를 설정합니다",

	["Thickness"] = "굵기",
	["Sets thickness of XP Bar"] = "경험치바의 굵기를 설정합니다",

	["Shadow"] = "음영",
	["Toggles Shadow under XP Bar"] = "경험치 바 하단의 그림자를 토글합니다",

	["Remaining"] = "Remaining",
	["Show Remaining in Bar"] = "Show Remaining in Bar",

	["Select Faction"] = "진영 선택",
	["Faction"] = "진영",
	
	["Watched Faction"] = "표시중인 평판",

	["Hook-ins"] = "참조",
	["Options to hook in other addons"] = "다른 애드온의 기능을 참조합니다",

	["FuBar Faction Link"]= "FuBar Faction 연결",
	["Link to FubBar Factions"] = "FuBar Faction과 연결합니다",
	
--	["Tek AutoRep"] = true,
	["Hook into TekAutoRep's automatic rep changes"] = "TekAutoRep의 자동 평편 변경 기능을 적용합니다",
	
	['Location'] = "위치",
	["Undocked Position"] = "패널분리시 위치",
	["Selects which side of an undocked panel you want the bars on."] = "패널을 분리 하였을 경우 패널의 어느쪽에 바를 표시할지를 선택합니다.",

	["XP|Rep|None"] = "경험치|평판|없음",
	["Show Text"] = "텍스트 표시",
	["Show the XP or Rep"] = "경험치 또는 평판 표시",

	["%s: %3.0f%% (%s/%s) %s left"] = "%s진영: %3.0f%% (%s/%s) %s 남았습니다.",
	["%s to go (%3.0f%%)"] = "%s 남았습니다 (%3.0f%%)",

	["Current XP"] = "현재 경험치",
	["To Level"] = "남은 경험치",
	["Rested XP"] = "휴식 경험치",
	["Click to send your current xp to an open editbox."] = "클릭시 입력창이 열려 있을 경우 현재 경험치를 출력합니다.",
	["Shift Click to send your current rep to an open editbox."] = "Shift 클릭시 입력창이 열려 있을 경우 현재 평판을 출력합니다.",
	["Faction"] = "진영",
	["Rep to next standing"] = "다음 단계까지 남은 평판",
	["Current rep"] = "현재 평판",

	["%s/%s (%3.0f%%) %d to go"] = "현재 경험치는 %s/%s (%3.0f%%)|1으로;로; %d 남았습니다",
	["%s:%s/%s (%3.2f%%) Currently %s with %d to go"] = "%s진영: %s/%s (%3.2f%%) 현재 %s 평판에 %d를 더 올리면 다음 등급이 됩니다",

	["Top"] = "위", 
	["Bottom"] = "아래",
	["XP"] = "경험치"	,
	["Rep"] = "평판",
	["None"] = "없음",
} end)

L:RegisterTranslations("zhTW", function() return {
	["AceConsole-commands"] = { "/FuXPFu" },

	["Colours"] = "顏色",
	["Set the Bar Colours"] = "設定經驗條顏色",

	["Properties"] = "屬性",
	["Set the Bar Properties"] = "設定經驗條屬性",

	["Current XP"] = "當前經驗",
	["Sets the color of the XP Bar"] = "設定當前經驗顏色",

	["Rested XP"] = "獎勵經驗",
	["Sets the color of the Rested Bar"] = "設定獎勵經驗顏色",

	["No XP"] = "剩餘經驗",
	["Sets the empty color of the XP Bar"] = "設定剩餘經驗顏色",
	
	["Reputation"] = "當前聲望",
	["Sets the color of the Rep Bar"] = "設定聲望顏色",
	
	["No Rep"] = "剩餘聲望",
	["Sets the empty color of the Reputation Bar"] = "設定剩餘聲望顏色",

	["Show XP Bar"] = "顯示經驗條",
	["Show the XP Bar"]  = "顯示經驗條",
	
	["Show Rep Bar"] = "顯示聲望條",
	["Show the Reputation Bar"] = "顯示聲望條",

	["Spark intensity"] = "分界亮度",
	["Brightness level of Spark"] = "設定當前值與剩餘值分界標誌的亮度",

	["Thickness"] = "粗細",
	["Sets thickness of XP Bar"] = "設定經驗條的粗細",

	["Shadow"] = "陰影效果",
	["Toggles Shadow under XP Bar"] = "開啟經驗條陰影效果",

	["Remaining"] = "Remaining",
	["Show Remaining in Bar"] = "Show Remaining in Bar",

	["Select Faction"] = "選擇聲望勢力",
	["Faction"] = "勢力",
	
	["Watched Faction"] = "預設",

	["Hook-ins"] = "關聯",
	["Options to hook in other addons"] = "設定與其他插件的關聯",

	["FuBar Faction Link"]= "FuBar_Fractions",
	["Link to FubBar Factions"] = "關聯到FuBar聲望插件(Fractions)",
	
	["Tek AutoRep"] = "Tek AutoRep",
	["Hook into TekAutoRep's automatic rep changes"] = "關聯到Tek AutoRep插件",
	
	['Location'] = "位置",
	["Undocked Position"] = "附著位置",
	["Selects which side of an undocked panel you want the bars on."] = "設定經驗條附著在面板的哪一側。",

	["XP|Rep|None"] = "經驗|聲望|無",
	["Show Text"] = "顯示文字",
	["Show the XP or Rep"] = "顯示經驗或者聲望",

	["%s: %3.0f%% (%s/%s) %s left"] = "%s: %.0f%%(%s/%s) 升級需要聲望: %s",
	["%s to go (%3.0f%%)"] = "升級需要經驗: %s(%.0f%%)",

	["Current XP"] = "當前經驗",
	["To Level"] = "升級需要經驗",
	["Rested XP"] = "獎勵經驗",
	["Click to send your current xp to an open editbox."] = "點擊向聊天輸入框發送經驗值",
	["Shift Click to send your current rep to an open editbox."] = "Shift+點擊向聊天輸入框發送聲望值",
	["Faction"] = "勢力",
	["Rep to next standing"] = "升級需要聲望",
	["Current rep"] = "當前聲望",

	["%s/%s (%3.0f%%) %d to go"] = "經驗值: %s/%s(%.0f%%) 升級需要: %d",
	["%s:%s/%s (%3.2f%%) Currently %s with %d to go"] = "%s: %s/%s(%.2f%%) 目前關係: %s 升級需要: %d",

	["Top"] = "頂部", 
	["Bottom"] = "底部",
	["XP"] = "XP",
	["Rep"] = "Rep",
	["None"] = "無",
} end)
