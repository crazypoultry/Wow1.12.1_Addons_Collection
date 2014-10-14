    -- by claretta(notfound@gmail.com)

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("koKR", function() return {

	-- bindings
	["Target unit with highest priority"] = "첫 번째 위급 유닛 선택",
	["Target unit with 2nd highest priority"] = "두 번째 위급 유닛 선택",
	["Target unit with 3rd highest priority"] = "세 번째 위급 유닛 선택",

	-- from combatlog	
	["(.+) begins to cast (.+)."] = "(.+)|1이;가; (.+)|1을;를; 시전합니다.",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+)|1이;가; (.+)의 생명력 전환|1으로;로; (.+)의 마나|1을;를; 얻었습니다.",

	-- options
	["Default"]     = "Default",
	["Smooth"]		= "Smooth",
	["Button"]		= "Button",
	["BantoBar"]	= "BantoBar",
	["Charcoal"]	= "Charcoal",
	["Otravi"]		= "Otravi",
	["Perl"]		= "Perl",
	["Smudge"]		= "Smudge",
	
	["always"] = "항상",
	["grouped"] = "파티/공격대",
	
	["Frame options"] = "창 설정",
	["Show Border"] = "경계선 표시",
	["Shows/hides the frame border."] = "응급 창의 경계선을 보이거나 감춥니다.",
	["Show Header"] = "제목 표시",
	["Shows/hides the frame header."] = "응급 창의 제목 표시줄을 보이거나 감춥니다.",
	["Scale"] = "크기 비율",
	["Scales the Emergency Monitor."] = "응급 창의 크기 비율을 조절합니다.",
	["Number of units"] = "유닛 수",
	["Number of max visible units."] = "응급 창에 표시되는 최대 유닛 수를 설정합니다.",
	["Frame lock"] = "창 위치 잠금",
	["Locks/unlocks the emergency monitor."] = "응급 창의 위치를 잠그거나 잠금을 해제합니다.",
	["Show Frame"] = "창 표시",
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = "응급 창이 언제 보일지 설정합니다. '항상', '파티/공격대' 중에 선택하세요.",
	["Pet support"] = "펫 지원",
	["Toggles the display of pets in the emergency frame."] = "펫의 응급 현황 표시 기능을 켜고 끕니다." ,
	
	["Unit options"] = "보기 설정",
	["Alpha"] = "투명도",
	["Changes background+border visibility"] = "응급 창의 배경과 테투리의 투명도를 설정합니다.",
	["Style"] = "스타일",
	["Color bar either by health, class or use the CTRA style."] = "체력, 클래스별로 바 색상을 나타내거나 CTRA 스타일로 체력 바를 표현합니다.",
	["Health"] = "체력",
	["Class"] = "직업",
	["CTRA"] = "CTRA",
	["Texture"] = "유닛 바 모양",
	["Sets the bar texture. Choose 'Blizzard', 'Default' or 'Smooth'."] = "유닛 바의 모양을 설정합니다.",
	["Health deficit"] = "체력 결손치 표시",
	["Toggles the display of health deficit in the emergency frame."] = "응급 창에 체력 결손치 표시 기능을 켜고 끕니다.",
	["Unit bar height"] = "유닛 바 높이",
	["Unit bar width"] = "유닛 바 넓이",
	["Bar Spacing"] = "유닛 바 간격",
	["Change the spacing between bars"] = "유닛 바 사이의 간격을 조절합니다.",
	["Inside Bar"] = "바 안에 표시",
	["Outside Bar"] = "바 밖에 표시",
	["Name position inside bar"] = "바 안에 이름 표시",
	["Show name position inside bar"] = "유닛 바 안에 이름을 표시합니다.",
	["Class colored name"] = "이름 색상을 직업별로 표시",
	["Color names by class"] = "유닛 이름의 색상을 직업별로 표시합니다.",
	
	["Class options"] = "직업 설정",
	
	["Various options"] = "기타 설정",
	["Audio alert on aggro"] = "어그로 획득시 알림",
	["Toggle on/off audio alert on aggro."] = "자신이 몹에게 어그로를 획득하였을 때 소리로 이를 알리는 기능을 켜거나 끕니다.",
	["Log range"] = "범위",
	["Changes combat log range. Set it to your max healing range"] = "전투 통계를 측정하는 범위를 설정합니다. 자신의 최대 힐 사정거리로 설정하세요.",
	["Version Query"] = "버전 요청",
	["Checks the group for Squishy users and prints their version data."] = "파티/공격대 내의 Squishy 사용자를 확인하고 Squishy의 버전 정보를 출력합니다.",
	["Checking group for Squishy users, please wait."] = "파티/공격대의 Squishy 사용자 확인 중입니다. 잠시만 기다려주세요.",
	["using"] = "사용중",
	
	-- notifications in frame
	[" is healing you."] = "|1이;가; 당신을 치유합니다.",
	[" healing your group."] = "|1이;가; 당신의 파티를 치유합니다.",
	[" died."] = "|1이;가; 죽었습니다.",
	
	-- frame header
	["Squishy Emergency"] = "Squishy 응급현황",
	
	-- debuffs and other spell related locals
	["Mortal Strike"] = "죽음의 일격",
	["Mortal Cleave"] = "죽음의 회전베기",
	["Gehennas\' Curse"] = "게헨나스의 저주",
	["Curse of the Deadwood"] = "고목의 저주",
	["Blood Fury"] = "피의 격노",
	["Brood Affliction: Green"] = "혈족의 고통 : 녹",
	["Necrotic Poison"] = "역병의 독",
	["Conflagration"] = "거대한 불길",
	["Petrification"] = "석화",
} end)
