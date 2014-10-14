--[[ $Id: koKR.lua 15751 2006-11-02 13:42:54Z fenlis $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("Antagonist")

L:RegisterTranslations("koKR", function()
	return {
		["Fonts\\skurri.ttf"] = "Fonts\\2002.ttf", -- (internal)
		
		["Antagonist"] = "라이벌",
		["Casts"] =	"시전",
		["Buffs"] =	"버프",
		["Cooldowns"] = "재사용 대기시간",
		
		-- Command line names
		["Group"] = "그룹",
		["Bar"] = "바",
		["Title"] = "종류명",
		
		-- Misc names
		["Test"] = "테스트",
		["Lock"] = "고정",
		["Stop"] = "정지",
		["Config"] = "환경설정",
		["Kill"] = "죽임",
		["Fade"] = "사라짐",
		["Death"] = "죽음",
		["Self Relevant"] = "셀프 대상",
		["Cooldown Limit"] = "재사용 대기시간 제한",

		-- Group names
		["Target Only"] = "대상만",
		["Enabled"] = "활성화됨",
		["Show Under"] = "아래로 표시",
		["Pattern"] = "패턴",

		-- Bar names
		["Bar Color"] = "바 색상",
		["Bar Texture"] = "바 텍스쳐",
		["Bar Scale"] = "바 크기",
		["Bar Height"] = "바 높이",
		["Bar Width"] = "바 넓이",
		["Text Size"] = "글자 크기",
		["Reverse"] = "반전",
		["Grow Up"] = "생성",
		["Anchor"] = "고정 위치",

		-- Title names
		["Title Text"] = "종류명 글자",
		["Title Size"] = "종류명 크기",
		["Title Color"] = "종류명 색상",

		-- Command line descriptions
		["DescGroup"] = "세가지 주문 유형 그룹: 시전, 버프, 재사용 대기시간.",
		["DescBar"] = "바 외관을 설정합니다.",
		["DescTitle"] = "종류명 외관 설정입니다.",

		["DescCasts"] = "시전 시간입니다.",
		["DescBuffs"] = "버프 남은 시간입니다.",
		["DescCooldowns"] = "재사용 대기 시간입니다.",
			
		-- Group descs
		["DescTargetOnly"] = "대상의 이벤트만 분석합니다.",
		["DescEnabled"] = "해당 그룹을 분석할 지를 설정합니다.",
		["DescShowUnder"] = "해당 그룹이 앵커 아래 나타날 것입니다.",
		["DescPattern"] = "바위에 텍스트를 나타내는 패턴. 이름, 주문, 대상(시전만)의 순서를 변경하려면 $n, $s, $t 를 사용하세요.",
		
		-- Bar descs
		["DescBarColor"] = "바 색상을 설정합니다.",
		["DescBarTexture"] = "타이머 바의 텍스쳐입니다.",
		["DescBarScale"] = "타이머 바의 크기입니다.",
		["DescBarHeight"] = "타이머 바의 높이입니다.",
		["DescBarWidth"] = "타이머 바의 넓이 입니다.",
		["DescTextSize"] = "타이머 바 위의 글자 크기 입니다.",
		["DescReverse"] = "바를 채우거나 비우는 것을 설정합니다.",
		["DescGrowup"] = "바를 위로 생성할지 아래로 생성할지를 설정합니다.",
		
		-- Title descs
		["DescTitleNum"] = "종류명 설정 조절 ", -- do not remove the space
		["DescTitleText"] = "종류명의 글꼴을 설정합니다.",
		["DescTitleSize"] = "종류명의 글꼴 크기입니다.",
		["DescTitleColor"] = "종류명의 색상을 설정합니다.",

		-- Misc descs
		["DescTest"] = "테스트 바를 실행합니다.",
		["DescLock"] = "위치 표시/숨김.",
		["DescStop"] = "모든 바를 정지하고 모든 제목을 숨깁니다.",
		["DescConfig"] = "환경설정 메뉴를 표시합니다.",
		["DescGroup"] = "그룹을 설정합니다.", 
		["DescKill"] = "적이 죽었을 때 바를 사라지게 할지를 전환합니다.",
		["DescFade"] = "주문이 사라졌을 때 바를 사라지게 할지를 전환합니다.",
		["DescDeath"] = "당신이 죽었을 때 바를 사라지게 할지를 전환합니다.",
		["DescSelfRelevant"] = "당신을 대상으로 한 시전 바만 표시합니다.",
		["DescCDLimit"] = "이 수치 이상의 재사용 대기시간은 표시하지 않습니다.",

		-- Bar color names
		["school"] = "속성", -- by gygabyte
		["class"] = "직업",
		["group"] = "그룹",

		["TestBarText"] = "유닛 : 주문",

		-- Spells not supported by BabbleSpell
		-- casts
		["Hearthstone"] = "생명석",
		
		-- mob casts
		["Shrink"] = "축소",
		["Banshee Curse"] = "밴시의 저주", -- by gygabyte
		["Shadow Bolt Volley"] = "연발 어둠의 화살",
		["Cripple"] = "신경 마비",
		["Dark Mending"] = "암흑의 치유",
		["Spirit Decay"] = "정기 쇠약",
		["Gust of Wind"] = "돌풍",
		["Black Sludge"] = "검은 폐수",
		["Toxic Bolt"] = "독액 화살",
		["Poisonous Spit"] = "독침",
		["Wild Regeneration"] =	"야생의 회복력",
		["Curse of the Deadwood"] = "고목의 저주",
		["Curse of Blood"] = "피의 저주",
		["Dark Sludge"] = "어둠의 폐수",
		["Plague Cloud"] = "역병 구름",
		["Wandering Plague"] = "떠도는 역병",		
		["Wither Touch"] = "부패의 손길", -- by gygabyte
		["Fevered Fatigue"] = "고열의 피로",
		["Encasing Webs"] = "거미줄 휘감기",
		["Crystal Gaze"] = "수정의 주시",
		
		-- buffs
		["Brittle Armor"] = "불완전한 갑옷",
		["Unstable Power"] = "불안정한 마력", -- by gygabyte
		["Restless Strength"] = "불안정한 힘",
		["Ephemeral Power"] = "마력의 힘",
		["Massive Destruction"] = "잔혹한 파괴",
		["Arcane Potency"] = "신비한 잠재력",
		["Energized Shield"] = "보호막 강화",
		["Brilliant Light"] = "찬란한 빛",
		["Mar'li's Brain Boost"] = "말리의 눈",
		["Earthstrike"] = "대지의 격동",
		["Gift of Life"] = "생명의 보석",
		["Nature Aligned"] = "자연 동화의 수정",
		["Quick Shots"] = "신속 사격", -- by gygabyte

		["Fire Reflector"] = "극고온 화염 반사기",
		["Shadow Reflector"] = "초광자 암흑 반사기",
		["Frost Reflector"] = "회전냉각식 냉기 반사기",
	}
end)
