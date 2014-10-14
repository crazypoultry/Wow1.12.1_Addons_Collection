--[[ $Id: koKR.lua 15757 2006-11-02 15:26:11Z fenlis $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("myBindings2")

L:RegisterTranslations("koKR", function()
	return {
		["An enhanced key bindings interface."] = "강화된 단축키 인터페이스.",
		["Opens the myBindings2 interface"] = "myBindings2 인터페이스 열기",
		
		["Standard Interface"] = "기본 인터페이스",
 		["Action Bars"] = "행동 단축바",
		["Auction"] = "경매",
		["Audio"] = "음향",
		["Battlegrounds/PvP"] = "전장/PvP",
		["Buffs"] = "버프",
		["Chat/Communication"] = "대화/의사소통",
	        ["Class"] = "직업",
		["Healer"] = "힐러",
		["Tank"] = "탱커",
		["Caster"] = "캐스터",
		["Combat"] = "전투",
		["Compilations"] = "복합",
		["Data Export"] = "자료 출력",
		["Development Tools"] = "개발 도구",
		["Guild"] = "길드",
		["Frame Modification"] = "구조 변경",
		["Interface Enhancements"] = "인터페이스 강화",
		["Inventory"] = "인벤토리",
		["Library"] = "라이브러리",
		["Map"] = "지도",
		["Mail"] = "우편",
		["Miscellaneous"] = "기타",
		["Quest"] = "퀘스트",
		["Raid"] = "공격대",
		["Tradeskill"] = "전문기술",
		["UnitFrame"] = "유닛 프레임",
		
		["MultiActionBar Bottom Left"] = "행동 단축키 - 좌측 하단",
		["MultiActionBar Bottom Right"] = "행동 단축키 - 우측 하단",
		["MultiActionBar Right Side 1"] = "행동 단축키 - 우측 첫번째",
		["MultiActionBar Right Side 2"] = "행동 단축키 - 우측 두번째",
		
		["Game Defaults"] = "게임 기본 설정",
	        ["Confirm"] = "확인",
	        ["Cancel"] = "취소",
	        ["Unbind"] = "해제",
	        ["Save"] = "저장",

		["Profile: |cffffffff%s|r"] = "Profile: |cffffffff%s|r",
		["|cffff0000%s is already bound to %s. Confirm replacement.|r"] = "|cffff0000단축키 %s의 현재 기능은 %s입니다. 바꾸시겠습니까?|r",
		["Can't bind mousewheel to actions with up and down states"] = "위 아래 상태를 가진 동작에는 마우스휠을 지정할 수 없습니다.",
		["Slash-Commands"] = { "/mybindings2", "/myb2" },
	}
end)
