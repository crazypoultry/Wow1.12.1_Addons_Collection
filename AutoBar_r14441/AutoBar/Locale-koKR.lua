--
-- AutoBar
-- http://www.curse-gaming.com/en/wow/addons-4430-1-autobar-toadkiller.html
--

local AceLocale = AceLibrary("AceLocale-2.1");

AceLocale:RegisterTranslation("AutoBar", "koKR", function()
    return {
        ["AUTOBAR"] = "오토바",
        ["CONFIG_WINDOW"] = "설정 창 열기",
        ["SLASHCMD_LONG"] = "/autobar",
        ["SLASHCMD_SHORT"] = "/atb",
        ["BUTTON"] = "버튼",
        ["EDITSLOT"] = "버튼 편집",
        ["VIEWSLOT"] = "슬롯 보기",

--  AutoBar_Config.lua
		["EMPTY"] = "빈창";
		["AUTOBAR_CONFIG_SMARTSELFCAST"] = "셀프 캐스팅";
		["AUTOBAR_CONFIG_REMOVECAT"] = "현재 카테고리 삭제";
		["AUTOBAR_CONFIG_ROW"] = "가로";
		["AUTOBAR_CONFIG_COLUMN"] = "세로";
		["AUTOBAR_CONFIG_GAPPING"] = "아이콘 간격";
		["AUTOBAR_CONFIG_ALPHA"] = "아이콘 투명도";
		["AUTOBAR_CONFIG_BUTTONWIDTH"] = "버튼 넓이";
		["AUTOBAR_CONFIG_BUTTONHEIGHT"] = "버튼 높이";
		["AUTOBAR_CONFIG_DOCKSHIFTX"] = "위치 변경(좌측 및 우측)";
		["AUTOBAR_CONFIG_DOCKSHIFTY"] = "위치 변경(상단 및 하단)";
		["AUTOBAR_CONFIG_WIDTHHEIGHTUNLOCKED"] = "버튼 높이 및 넓이\n동시 변경 해제";
		["AUTOBAR_CONFIG_HIDEKEYBINDING"] = "단축키 숨김";
		["AUTOBAR_CONFIG_HIDECOUNT"] = "갯수 숨김";
		["AUTOBAR_CONFIG_SHOWEMPTY"] = "빈 버튼 표시";
		["AUTOBAR_CONFIG_SHOWCATEGORYICON"] = "카테고리 아이콘 표시";
		["AUTOBAR_CONFIG_HIDETOOLTIP"] = "툴팁 숨김";
		["AUTOBAR_CONFIG_POPUPDIRECTION"] = "팝업 버튼 방향";
		["AUTOBAR_CONFIG_POPUPDISABLE"] = "팝업 비활성화";
		["AUTOBAR_CONFIG_POPUPONSHIFT"] = "Shift 키 클릭시 팝업";
		["AUTOBAR_CONFIG_HIDEDRAGHANDLE"] = "이동 단추 숨김";
		["AUTOBAR_CONFIG_PLAINBUTTONS"] = "버튼 평범하게 표시";
		["AUTOBAR_CONFIG_NOPOPUP"] = "팝업 없음";
		["AUTOBAR_CONFIG_ARRANGEONUSE"] = "사용 순서 재배열";
		["AUTOBAR_CONFIG_RIGHTCLICKTARGETSPET"] = "오른쪽 클릭 대상의 소환수";
		["AUTOBAR_CONFIG_DOCKTONONE"] = "없음";
		["AUTOBAR_CONFIG_DOCKTOGBARS"] = "Gbars 두번째 바";
		["AUTOBAR_CONFIG_DOCKTOMAIN"] = "메인 메뉴";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAME"] = "대화창 프레임";
		["AUTOBAR_CONFIG_DOCKTOCHATFRAMEMENU"] = "대화창 프레임 메뉴";
		["AUTOBAR_CONFIG_DOCKTOACTIONBAR"] = "액션바";
		["AUTOBAR_CONFIG_DOCKTOMENUBUTTONS"] = "메뉴 버튼";
		["AUTOBAR_CONFIG_ALIGN"] = "일렬 버튼";
    }
end);


if (GetLocale()=="koKR") then

AUTOBAR_CHAT_MESSAGE1 = "이 캐릭터에 대한 전 버전의 설정값이 있습니다. 삭제하십시오. 설정 업데이트를 시도하지 않고 있습니다.";
AUTOBAR_CHAT_MESSAGE2 = "아이템 이름 대신 아이템의 ID를 이용하기 위해, 복수 아이템 버튼 #%d를 #%d로 변경합니다.";
AUTOBAR_CHAT_MESSAGE3 = "아이템 이름 대신 아이템의 ID를 이용하기 위해, 단일 아이템 버튼 #%d로 변경합니다.";

---------------------------------------
--  AutoBar_Config.xml
---------------------------------------
AUTOBAR_CONFIG_VIEWTEXT = "슬롯을 편집하려면 슬롯 탭의 아래에 슬롯 편집 섹션에서 선택합니다."; 
AUTOBAR_CONFIG_SLOTVIEWTEXT = "결합된 계층 보기 (편집 불가)";
AUTOBAR_CONFIG_RESET = "초기화";
AUTOBAR_CONFIG_REVERT = "되돌리기";
AUTOBAR_CONFIG_DONE = "완료";
AUTOBAR_CONFIG_DETAIL_CATEGORIES = "(Shift 클릭 : 카테고리 조사)";
AUTOBAR_CONFIG_DRAGHANDLE = "위치 변경 : 왼쪽 버튼을 누루며 이동\n위치 잠금 및 고정 : 왼쪽 버튼 클릭\n옵션 열기 : 오른쪽 버튼 클릭";
AUTOBAR_CONFIG_EMPTYSLOT = "빈 슬롯";
AUTOBAR_CONFIG_CLEARSLOT = "슬롯 비움";
AUTOBAR_CONFIG_SETSHARED = "공유 프로파일:";
AUTOBAR_CONFIG_SETSHAREDTIP = "사용할 공유 프로파일을 선택하세요.\n공유된 프로파일에 대한 변화는 그것을 사용하고 있는 모든 캐릭터에게 영향을 줍니다.";

AUTOBAR_CONFIG_TAB_SLOTS = "슬롯";
AUTOBAR_CONFIG_TAB_BAR = "바";
AUTOBAR_CONFIG_TAB_BUTTONS = "버튼들";
AUTOBAR_CONFIG_TAB_POPUP = "팝업";
AUTOBAR_CONFIG_TAB_PROFILE = "프로파일";

AUTOBAR_TOOLTIP1 = " (갯수: ";
AUTOBAR_TOOLTIP2 = " [사용자 아이템]";
AUTOBAR_TOOLTIP3 = " [전투상태시 가능]";
AUTOBAR_TOOLTIP4 = " [전장에서만 가능]";
AUTOBAR_TOOLTIP5 = " [비전투시만 가능]";
AUTOBAR_TOOLTIP6 = " [제한된 사용]";
AUTOBAR_TOOLTIP7 = " [재사용]";
AUTOBAR_TOOLTIP8 = "\n(왼쪽 클릭 주무기 적용\n오른쪽 클릭 보조무기 적용)";


---------------------------------------
--  AutoBar_Config.lua
---------------------------------------

AUTOBAR_CONFIG_NOTFOUND = "(찾을수 없음 : 아이템 ";
AUTOBAR_CONFIG_DOCKTO = "위치 변경:";
AUTOBAR_CONFIG_SLOTEDITTEXT = " 계층 (편집 클릭)";
AUTOBAR_CONFIG_CHARACTER = "캐릭터";
AUTOBAR_CONFIG_SHARED = "공유";
AUTOBAR_CONFIG_CLASS = "직업";
AUTOBAR_CONFIG_BASIC = "기본";
AUTOBAR_CONFIG_USECHARACTER = "캐릭터 계층 사용";
AUTOBAR_CONFIG_USESHARED = "공유 계층 사용";
AUTOBAR_CONFIG_USECLASS = "직업 계층 사용";
AUTOBAR_CONFIG_USEBASIC = "기본 계층 사용";
AUTOBAR_CONFIG_USECHARACTERTIP = "캐릭터 계층 아이템은 이 캐릭터에만 특별히 적용합니다.";
AUTOBAR_CONFIG_USESHAREDTIP = "공유되는 계층 아이템이 똑같은 공유 계층을 사용하는 다른 캐릭터에 의하여 함께 공유됩니다.\n특정한 계층은 프로파일 탭 위에 선택될 수 있습니다.";
AUTOBAR_CONFIG_USECLASSTIP = "직업 계층 아이템이 직업 계층을 사용하는 똑같은 직업의 모든 캐릭터에 의하여 함께 공유됩니다.";
AUTOBAR_CONFIG_USEBASICTIP = "기본 계층 아이템이 모든 캐릭터에 의하여 기본 계층을 사용하면서 함께 공유됩니다.";
AUTOBAR_CONFIG_HIDECONFIGTOOLTIPS = "구성 툴팁 숨김";
AUTOBAR_CONFIG_OSKIN = "oSkin 사용";
AUTOBAR_CONFIG_CHARACTERLAYOUT = "캐릭터 배치";
AUTOBAR_CONFIG_SHAREDLAYOUT = "공유 배치";
AUTOBAR_CONFIG_CHARACTERLAYOUTTIP = "시각적인 배치에 대한 변경은 이 캐릭터에 영향을 줍니다.";
AUTOBAR_CONFIG_SHAREDLAYOUTTIP = "시각적인 배치에 대한 변경은 같이 공유되는 프로파일을 사용하고 있는 모든 캐릭터들에 영향을 줍니다.";
AUTOBAR_CONFIG_SHARED1 = "공유 1";
AUTOBAR_CONFIG_SHARED2 = "공유 2";
AUTOBAR_CONFIG_SHARED3 = "공유 3";
AUTOBAR_CONFIG_SHARED4 = "공유 4";
AUTOBAR_CONFIG_TIPOVERRIDE = "이 계층 위의 슬롯 아이템은 더 낮은 계층 위의 그 슬롯의 아이템 위로 올라갑니다.\n";
AUTOBAR_CONFIG_TIPOVERRIDDEN = "이 계층 위의 슬롯 아이템은 더 높은 계층 위의 아이템에 의하여 아래로 내려갑니다.\n";
AUTOBAR_CONFIG_TIPAFFECTSCHARACTER = "변경은 현재 캐릭터만 영향을 줍니다.";
AUTOBAR_CONFIG_TIPAFFECTSALL = "변경은 모든 캐릭터에 영향을 줍니다.";
AUTOBAR_CONFIG_EDITCHARACTER = "캐릭터 계층 편집";
AUTOBAR_CONFIG_EDITSHARED = "공유 계층 편집";
AUTOBAR_CONFIG_EDITCLASS = "직업 계층 편집";
AUTOBAR_CONFIG_EDITBASIC = "기본 계층 편집";
AUTOBAR_CONFIG_SETUPSINGLE = "싱글 구성";
AUTOBAR_CONFIG_SETUPSHARED = "공유 구성";
AUTOBAR_CONFIG_SETUPSTANDARD = "표준 구성";
AUTOBAR_CONFIG_SETUPBLANKSLATE = "빈 슬레이트";
AUTOBAR_CONFIG_SETUPSINGLETIP = "표준 오토바와 비슷한 하나의 캐릭터 설정들을 위해 클릭하세요.";
AUTOBAR_CONFIG_SETUPSHAREDTIP = "공유되는 설정들을 위해 클릭하세요.\n공유되는 계층들 뿐만 아니라 특정 캐릭터를 가능하게 합니다.";
AUTOBAR_CONFIG_SETUPSTANDARDTIP = "모든 계층들의 편집과 사용을 가능하게 합니다.";
AUTOBAR_CONFIG_SETUPBLANKSLATETIP = "모든 캐릭터를 없애고 슬롯들을 공유합니다.";
AUTOBAR_CONFIG_RESETSINGLETIP = "싱글 캐릭터를 기본값으로 초기화 하려면 클릭하세요.";
AUTOBAR_CONFIG_RESETSHAREDTIP = "공유되는 캐릭터를 기본값으로 초기화 하려면 클릭하세요.\n직업 특정의 슬롯이 캐릭터 계층으로 복사해 집니다.\n기본 슬롯이 공유되는 계층으로 복사해 집니다.";
AUTOBAR_CONFIG_RESETSTANDARDTIP = "표준을 기본값으로 초기화 하려면 클릭하세요.\n직업 특정의 슬롯들은 직업 계층 안에 있습니다.\n기본 슬롯들은 기초적인 계층 안에 있습니다.\n공유 그리고 캐릭터 계층들을 비우게 됩니다.";

AUTOBAR_TOOLTIP9 = "복수 카테고리 버튼\n";
AUTOBAR_TOOLTIP10 = " (사용자 아이템 ID)";
AUTOBAR_TOOLTIP11 = "\n(인정되지 않는 아이템 ID)";
AUTOBAR_TOOLTIP12 = " (사용자 아이템 이름)";
AUTOBAR_TOOLTIP13 = "단일 카테고리 버튼\n\n";
AUTOBAR_TOOLTIP14 = "\n직접 사용 불가";
AUTOBAR_TOOLTIP15 = "\n무기 대상\n(왼쪽 클릭 주무기\n오른쪽 클릭 보조무기)";
AUTOBAR_TOOLTIP16 = "\n대상";
AUTOBAR_TOOLTIP17 = "\n비전투시만";
AUTOBAR_TOOLTIP18 = "\n전투시만";
AUTOBAR_TOOLTIP19 = "\n위치: ";
AUTOBAR_TOOLTIP20 = "\n제한된 사용: "
AUTOBAR_TOOLTIP21 = "체력 회복 요구";
AUTOBAR_TOOLTIP22 = "마나 회복 요구";
AUTOBAR_TOOLTIP23 = "단일 아이템 버튼\n\n";


---------------------------------------
--  AutoBarItemList.lua
---------------------------------------
AUTOBAR_ALTERACVALLEY = "알터랙 계곡";
AUTOBAR_WARSONGGULCH = "전쟁노래 협곡";
AUTOBAR_ARATHIBASIN = "아라시 분지";
AUTOBAR_AHN_QIRAJ = "안퀴라즈";
AUTOBAR_BWL = "검은날개 둥지";

AUTOBAR_CLASS_CUSTOM = "일반";
AUTOBAR_CLASS_CLEAR = "이 슬롯 비움";
AUTOBAR_CLASS_BANDAGES = "붕대";
AUTOBAR_CLASS_ALTERAC_BANDAGE = "알터랙 계곡 붕대";
AUTOBAR_CLASS_WARSONG_BANDAGE = "전쟁노래 협곡 붕대";
AUTOBAR_CLASS_ARATHI_BANDAGE = "아라시 분지 붕대";
AUTOBAR_CLASS_UNGORORESTORE = "운고르 : 회복의 수정";

AUTOBAR_CLASS_ANTIVENOM = "해독제";
AUTOBAR_CLASS_AGILITYPOTIONS = "민첩의 비약";
AUTOBAR_CLASS_STRENGTHPOTIONS = "힘의 비약";
AUTOBAR_CLASS_FORTITUDEPOTIONS = "인내의 비약";
AUTOBAR_CLASS_INTELLECTPOTIONS = "지능의 비약";
AUTOBAR_CLASS_WISDOMPOTIONS = "지혜의 비약";
AUTOBAR_CLASS_DEFENSEPOTIONS = "방어의 비약";
AUTOBAR_CLASS_TROLLBLOODPOTIONS = "재생의 물약";
AUTOBAR_CLASS_SCROLLOFAGILITY = "민첩의 두루마리";
AUTOBAR_CLASS_SCROLLOFINTELLECT = "지능의 두루마리";
AUTOBAR_CLASS_SCROLLOFPROTECTION = "보호의 두루마리";
AUTOBAR_CLASS_SCROLLOFSPIRIT = "정신력의 두루마리";
AUTOBAR_CLASS_SCROLLOFSTAMINA = "체력의 두루마리";
AUTOBAR_CLASS_SCROLLOFSTRENGTH = "힘의 두루마리";
AUTOBAR_CLASS_BUFF_ATTACKPOWER = "전투력 버프";
AUTOBAR_CLASS_BUFF_ATTACKSPEED = "공격 속도 버프";
AUTOBAR_CLASS_BUFF_DODGE = "회피 버프";
AUTOBAR_CLASS_BUFF_FROST = "냉기 저항 버프";
AUTOBAR_CLASS_BUFF_FIRE = "화염 저항 버프";

AUTOBAR_CLASS_HEALPOTIONS = "치유 물약";
AUTOBAR_CLASS_PVP6HEALPOTIONS = "전투 치유 물약";
AUTOBAR_CLASS_HEALTHSTONE = "생명석";
AUTOBAR_CLASS_WHIPPER_ROOT = "채찍뿌리 줄기";
AUTOBAR_CLASS_BATTLEGROUNDHEALPOTIONS = "전장 치유 물약";
AUTOBAR_CLASS_MANAPOTIONS = "마나 물약";
AUTOBAR_CLASS_PVP6MANAPOTIONS = "전투 마나 물약";
AUTOBAR_CLASS_MANASTONE = "마나석";
AUTOBAR_CLASS_BATTLEGROUNDMANAPOTIONS = "전장 마나 물약";
AUTOBAR_CLASS_DREAMLESS_SLEEP = "숙면의 물약";
AUTOBAR_CLASS_NIGHT_DRAGONS_BREATH = "어둠용의 숨결";
AUTOBAR_CLASS_REJUVENATION_POTIONS = "회복 물약";

AUTOBAR_CLASS_BATTLESTANDARD = "전투 깃발";
AUTOBAR_CLASS_BATTLESTANDARDAV = "알터랙 계곡 전투 깃발";
AUTOBAR_CLASS_DEMONIC_DARK_RUNES = "어둠 또는 악마의 룬";
AUTOBAR_CLASS_ARCANE_PROTECTION = "비전 보호 물약";
AUTOBAR_CLASS_FIRE_PROTECTION = "화염 보호 물약";
AUTOBAR_CLASS_FROST_PROTECTION = "냉기 보호 물약";
AUTOBAR_CLASS_NATURE_PROTECTION = "자연 보호 물약";
AUTOBAR_CLASS_SHADOW_PROTECTION = "암흑 보호 물약";
AUTOBAR_CLASS_SPELL_PROTECTION = "주문 보호 물약 [줄구룹]";
AUTOBAR_CLASS_HOLY_PROTECTION = "신성 보호 물약";
AUTOBAR_CLASS_INVULNERABILITY_POTIONS = "제한된 무적 물약";
AUTOBAR_CLASS_FREE_ACTION_POTION = "자유 행동의 물약";

AUTOBAR_CLASS_HEARTHSTONE = "귀환석";
AUTOBAR_CLASS_WATER = "음료";
AUTOBAR_CLASS_WATER_PERCENT = "음료: % 마나 회복";
AUTOBAR_CLASS_WATER_CONJURED = "음료: 마법사 창조";
AUTOBAR_CLASS_WATER_SPIRIT = "음료: 정신력 향상";
AUTOBAR_CLASS_RAGEPOTIONS = "분노의 물약";
AUTOBAR_CLASS_ENERGYPOTIONS = "기력의 물약";
AUTOBAR_CLASS_SWIFTNESSPOTIONS = "신속의 물약";
AUTOBAR_CLASS_SOULSHARDS = "영혼석";
AUTOBAR_CLASS_ARROWS = "화살";
AUTOBAR_CLASS_BULLETS = "탄환";
AUTOBAR_CLASS_THROWNWEAPON = "투척 무기류";
AUTOBAR_CLASS_FOOD = "음식: 일반";
AUTOBAR_CLASS_FOOD_PERCENT = "음식: % 체력 회복";
AUTOBAR_CLASS_FOOD_PET_BREAD = "음식: 소환수 빵";
AUTOBAR_CLASS_FOOD_PET_CHEESE = "음식: 소환수 치즈";
AUTOBAR_CLASS_FOOD_PET_FISH = "음식: 소환수 물고기";
AUTOBAR_CLASS_FOOD_PET_FRUIT = "음식: 소환수 과일";
AUTOBAR_CLASS_FOOD_PET_FUNGUS = "음식: 소환수 버섯";
AUTOBAR_CLASS_FOOD_PET_MEAT = "음식: 소환수 고기";
AUTOBAR_CLASS_FOOD_COMBO= "음식 및 음료 동시";
AUTOBAR_CLASS_FOOD_CONJURED = "음식: 마법사 창조";
AUTOBAR_CLASS_FOOD_STAMINA = "음식: 체력 향상";
AUTOBAR_CLASS_FOOD_AGILITY = "음식: 민첩 향상";
AUTOBAR_CLASS_FOOD_MANAREGEN = "음식: 마나 회복 향상";
AUTOBAR_CLASS_FOOD_HPREGEN = "음식: 체력 회복 향상";
AUTOBAR_CLASS_FOOD_STRENGTH = "음식: 힘 향상";
AUTOBAR_CLASS_FOOD_INTELLIGENCE = "음식: 지능 향상";
AUTOBAR_CLASS_FOOD_ARATHI = "음식: 아라시 분지";
AUTOBAR_CLASS_FOOD_WARSONG = "음식: 전쟁노래 협곡";
AUTOBAR_CLASS_SHARPENINGSTONES = "숫돌";
AUTOBAR_CLASS_WEIGHTSTONE = "무게추";
AUTOBAR_CLASS_POISON_CRIPPLING = "신경 마비 독";
AUTOBAR_CLASS_POISON_DEADLY = "맹독";
AUTOBAR_CLASS_POISON_INSTANT = "순간 효과 독";
AUTOBAR_CLASS_POISON_MINDNUMBING = "정신 마비 독";
AUTOBAR_CLASS_POISON_WOUND = "상처 감염 독";
AUTOBAR_CLASS_EXPLOSIVES = "폭탄";
AUTOBAR_CLASS_MOUNTS_TROLL = "탈것: 트롤 - 랩터";
AUTOBAR_CLASS_MOUNTS_ORC = "탈것: 오크 - 늑대";
AUTOBAR_CLASS_MOUNTS_UNDEAD = "탈것: 언데드 - 해골마";
AUTOBAR_CLASS_MOUNTS_TAUREN = "탈것: 타우렌 - 코드";
AUTOBAR_CLASS_MOUNTS_HUMAN = "탈것: 인간 - 군마";
AUTOBAR_CLASS_MOUNTS_NIGHTELF = "탈것: 나이트 엘프 - 호랑이";
AUTOBAR_CLASS_MOUNTS_DWARF = "탈것: 드워프 - 산양";
AUTOBAR_CLASS_MOUNTS_GNOME = "탈것: 노움 - 기계타조";
AUTOBAR_CLASS_MOUNTS_SPECIAL = "탈것: 희귀";
AUTOBAR_CLASS_MOUNTS_QIRAJI = "탈것: 안퀴라즈";
AUTOBAR_CLASS_MANA_OIL = "마나 오일: 마나 회복";
AUTOBAR_CLASS_WIZARD_OIL = "마술사 오일: 피해 및 치유 향상";
AUTOBAR_CLASS_FISHINGITEMS = "낚시 아이템들";

end