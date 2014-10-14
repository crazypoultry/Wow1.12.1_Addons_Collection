

if (GetLocale() == "koKR") then
	HEALBOT_DRUID	= "드루이드";
	HEALBOT_HUNTER	= "사냥꾼";
	HEALBOT_MAGE		= "마법사";
	HEALBOT_PALADIN	= "성기사";
	HEALBOT_PRIEST	= "사제";
	HEALBOT_ROGUE	= "도적";
	HEALBOT_SHAMAN	= "주술사";
	HEALBOT_WARLOCK	= "흑마법사";
	HEALBOT_WARRIOR	= "전사";

	HEALBOT_BANDAGES	= "붕대";

	HEALBOT_LINEN_BANDAGE			= "리넨 붕대";
	HEALBOT_WOOL_BANDAGE			= "양모 붕대";
	HEALBOT_SILK_BANDAGE			= "비단 붕대";
	HEALBOT_MAGEWEAVE_BANDAGE	= "마법 붕대";
	HEALBOT_RUNECLOTH_BANDAGE		= "룬매듭 붕대";

	HEALBOT_HEAVY_LINEN_BANDAGE		= "두꺼운 리넨 붕대";
	HEALBOT_HEAVY_WOOL_BANDAGE		= "두꺼운 양모 붕대";
	HEALBOT_HEAVY_SILK_BANDAGE			= "두꺼운 비단 붕대";
	HEALBOT_HEAVY_MAGEWEAVE_BANDAGE	= "두꺼운 마법 붕대";
	HEALBOT_HEAVY_RUNECLOTH_BANDAGE	= "두꺼운 룬매듭 붕대";

	HEALBOT_HEALING_POTIONS	= "치유 물약";

	HEALBOT_MINOR_HEALING_POTION		= "최하급 치유 물약";
	HEALBOT_LESSER_HEALING_POTION		= "하급 치유 물약";
	HEALBOT_HEALING_POTION			= "치유 물약";
	HEALBOT_GREATER_HEALING_POTION		= "상급 치유 물약";
	HEALBOT_SUPERIOR_HEALING_POTION	= "최상급 치유 물약";
	HEALBOT_MAJOR_HEALING_POTION		= "일급 치유 물약";

	HEALBOT_HEALTHSTONES	= "생명석";

	HEALBOT_MINOR_HEALTHSTONE		= "최하급 생명석";
	HEALBOT_LESSER_HEALTHSTONE	= "하급 생명석";
	HEALBOT_HEALTHSTONE			= "중급 생명석";
	HEALBOT_GREATER_HEALTHSTONE	= "상급 생명석";
	HEALBOT_MAJOR_HEALTHSTONE	= "최상급 생명석";

	HEALBOT_FLASH_HEAL			= "순간 치유";
	HEALBOT_FLASH_OF_LIGHT		= "빛의 섬광";
	HEALBOT_HOLY_SHOCK			= "신성 충격";
	HEALBOT_GREATER_HEAL			= "상급 치유";
	HEALBOT_HEALING_TOUCH			= "치유의 손길";
	HEALBOT_HEAL					= "치유";
	HEALBOT_HEALING_WAVE			= "치유의 물결";
	HEALBOT_HOLY_LIGHT			= "성스러운 빛";
	HEALBOT_LESSER_HEAL			= "하급 치유";
	HEALBOT_LESSER_HEALING_WAVE	= "하급 치유의 물결";
	HEALBOT_MEND_PET				= "동물 치료";
	HEALBOT_POWER_WORD_SHIELD	= "신의 권능: 보호막";
	HEALBOT_REGROWTH			= "재생";
	HEALBOT_RENEW				= "소생";
	HEALBOT_REJUVENATION			= "회복";
HEALBOT_PRAYER_OF_HEALING       = "치유의 기원";
HEALBOT_CHAIN_HEAL              = "연쇄 치유";

HEALBOT_POWER_WORD_FORTITUDE    = "신의 권능: 인내";
HEALBOT_DIVINE_SPIRIT           = "천상의 정신";
HEALBOT_MARK_OF_THE_WILD        = "야생의 징표";
HEALBOT_THORNS                  = "가시";
HEALBOT_BLESSING_OF_SALVATION   = "구원의 축복";

	HEALBOT_RESURRECTION			= "부활";
	HEALBOT_REDEMPTION			= "구원";
	HEALBOT_REBIRTH				= "환생";
	HEALBOT_ANCESTRALSPIRIT		= "고대의 영혼";

	HEALBOT_PURIFY			= "정화";
	HEALBOT_CLEANSE			= "정화";
	HEALBOT_CURE_POISON		= "해독";
	HEALBOT_REMOVE_CURSE		= "저주 해제";
	HEALBOT_ABOLISH_POISON	= "독 해제";
	HEALBOT_CURE_DISEASE		= "질병 치료";
	HEALBOT_ABOLISH_DISEASE	= "질병 해제";
	HEALBOT_DISPEL_MAGIC		= "마법 무효화";
	HEALBOT_DISEASE			= "질병";
	HEALBOT_MAGIC			= "마법";
	HEALBOT_CURSE			= "저주";
	HEALBOT_POISON			= "독";

	HEALBOT_RANK_1              = "(1 레벨)";
	HEALBOT_RANK_2              = "(2 레벨)";
	HEALBOT_RANK_3              = "(3 레벨)";
	HEALBOT_RANK_4              = "(4 레벨)";
	HEALBOT_RANK_5              = "(5 레벨)";
	HEALBOT_RANK_6              = "(6 레벨)";
	HEALBOT_RANK_7              = "(7 레벨)";
	HEALBOT_RANK_8              = "(8 레벨)";
	HEALBOT_RANK_9              = "(9 레벨)";
	HEALBOT_RANK_10            = "(10 레벨)";
	HEALBOT_RANK_11            = "(11 레벨)";

	HEALBOT_LIBRARY_INCHEAL		= "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.";
	HEALBOT_LIBRARY_INCDAMHEAL		= "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다%.";

	HB_BONUSSCANNER_NAMES = {	
		HEAL 		= "치유량",
	};

	HB_BONUSSCANNER_PREFIX_EQUIP	= "착용 효과: ";
	HB_BONUSSCANNER_PREFIX_SET	= "세트 효과: ";

	HB_BONUSSCANNER_PATTERNS_PASSIVE = {
		{ pattern = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
		{ pattern = "주문과 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
		{ pattern = "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다%.", effect = {"HEAL", "DMG"} },
	};

	HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {
		["치유 주문"] 		= "HEAL",
		["치유량 증가"] 	= "HEAL",
		["치유 효과 증가"]	= "HEAL",
		["치유 효과 중가"]	= "HEAL",
		["치유 주문 효과"]	= "HEAL",
		["치유 및 주문 공격력"] = {"HEAL", "DMG"},
		["치유 및 공격 주문 위력"] = {"HEAL", "DMG"},
	};	

	HB_BONUSSCANNER_PATTERNS_OTHER = {
		{ pattern = "잔달라 모조의 인장", effect = {"DMG", "HEAL"}, value = 18 },
		{ pattern = "잔달라 평온의 인장", effect = "HEAL", value = 33 },
		
		{ pattern = "최하급 마술사 오일", effect = {"DMG", "HEAL"}, value = 8 },
		{ pattern = "하급 마술사 오일", effect = {"DMG", "HEAL"}, value = 16 },
		{ pattern = "마술사 오일", effect = {"DMG", "HEAL"}, value = 24 },
		{ pattern = "반짝이는 마술사 오일", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

		{ pattern = "반짝이는 마나 오일", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
	};

	HB_SPELL_PATTERN_LESSER_HEAL	= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_HEAL			= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_GREATER_HEAL	= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_FLASH_HEAL	= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_RENEW		= "(%d+)초에 걸쳐 대상의 생명력을 총 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_RENEW1		= "(%d+)초에 걸쳐 대상의 생명력을 총 (%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_SHIELD		= "(%d+)의 피해를 흡수합니다. (%d+)초 동안 지속됩니다.";
	HB_SPELL_PATTERN_HEALING_TOUCH		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";    
	HB_SPELL_PATTERN_REGROWTH		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시키고 추가로 (%d+)초에 걸쳐 총 (%d+)의 생명력을 회복시킵니다";
	HB_SPELL_PATTERN_REGROWTH1		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시키고 추가로 (%d+)초에 걸쳐 총 (%d+)~(%d+)의 생명력을 회복시킵니다";    
	HB_SPELL_PATTERN_HOLY_LIGHT		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_FLASH_OF_LIGHT	= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_HEALING_WAVE		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_LESSER_HEALING_WAVE		= "대상의 생명력을 (%d+)~(%d+)만큼 회복시킵니다";
	HB_SPELL_PATTERN_REJUVENATION				= "(%d+)에 걸쳐 (%d+)의 생명력을 회복시킵니다";
	HB_SPELL_PATTERN_REJUVENATION1				= "(%d+)에 걸쳐 (%d+)~(%d+)의 생명력을 회복시킵니다";
	HB_SPELL_PATTERN_MEND_PET					= "야수에 정신을 집중하는 동안 매초마다 (%d+)의 생명력을 치료합니다";

	HB_TOOLTIP_MANA			= "^마나 (%d+)$";
	HB_TOOLTIP_RANGE			= "(%d+)미터";
	HB_TOOLTIP_INSTANT_CAST	= "즉시 시전";
	HB_TOOLTIP_CAST_TIME		= "(%d+.?%d*)초";
	HB_TOOLTIP_CHANNELED		= "채널링";
	HB_HASLEFTRAID			= "^([^%s]+)님이 공격대를 떠났습니다$";
	HB_HASLEFTPARTY			= "^([^%s]+)님이 파티를 떠났습니다$";
	HB_YOULEAVETHEGROUP		= "당신은 파티를 떠났습니다"
	HB_YOULEAVETHERAID		= "공격대를 떠났습니다"

	-----------------
	-- Translation --
	-----------------

	HEALBOT_ADDON = "HealBot " .. HEALBOT_VERSION;
	HEALBOT_LOADED = " 로드";

	HEALBOT_CASTINGSPELLONYOU		= "당신에게 %s을 시전합니다.";
	HEALBOT_CASTINGSPELLONUNIT		= "%s을 %s님에게 시전합니다.";
	HEALBOT_ABORTEDSPELLONUNIT	= "%s 주문을 중지합니다 : %s";

	HEALBOT_ACTION_TITLE		= "HealBot";
	HEALBOT_ACTION_OPTIONS	= "옵션";
	HEALBOT_ACTION_ABORT		= "정지";

	HEALBOT_OPTIONS_TITLE				= HEALBOT_ADDON;
	HEALBOT_OPTIONS_DEFAULTS			= "기본값";
	HEALBOT_OPTIONS_CLOSE				= "닫기";
	HEALBOT_OPTIONS_TAB_GENERAL		= "일반";
	HEALBOT_OPTIONS_TAB_SPELLS		= "주문";
	HEALBOT_OPTIONS_TAB_HEALING		= "치유";
	HEALBOT_OPTIONS_TAB_CDC			= "치료";
	HEALBOT_OPTIONS_TAB_SKIN			= "스킨";
HEALBOT_OPTIONS_TAB_TIPS      = "Tips";

	HEALBOT_OPTIONS_PANEL_TEXT		= "치유 패널 옵션:"
	HEALBOT_OPTIONS_BARALPHA			= "바 불투명도";
	HEALBOT_OPTIONS_BARALPHAINHEAL		= "들어오는 치유 불투명도";
	HEALBOT_OPTIONS_ACTIONLOCKED		= "위치 고정";
	HEALBOT_OPTIONS_GROWUPWARDS		= "위치 위로";
	HEALBOT_OPTIONS_AUTOSHOW			= "자동 열기";
	HEALBOT_OPTIONS_PANELSOUNDS		= "소리 재생";
	--HEALBOT_OPTIONS_ALERTSECONDS		= "죽음 카운트다운 타이머";
	HEALBOT_OPTIONS_HIDEOPTIONS		= "옵션 버튼 숨김";
	HEALBOT_OPTIONS_QUALITYRANGE		= "27미터 거리 체크";
	--HEALBOT_OPTIONS_INTEGRATECTRA	= "CTRA 연동";
	HEALBOT_OPTIONS_TOGGLEALTUSE		= "Alt-key 토글";
	HEALBOT_OPTIONS_PROTECTPVP		= "우발적 PvP 상태 피함";
	HEALBOT_OPTIONS_HEAL_CHATOPT		= "대화창 옵션";

	HEALBOT_OPTIONS_SKINTEXT			= "스킨 사용"
	HEALBOT_SKINS_STD					= "표준"
	HEALBOT_OPTIONS_SKINTEXTURE		= "텍스쳐"
	HEALBOT_OPTIONS_SKINHEIGHT			= "높이"
	HEALBOT_OPTIONS_SKINWIDTH			= "넓이"
	HEALBOT_OPTIONS_SKINNUMCOLS		= "번호 컬럼"
	HEALBOT_OPTIONS_SKINBRSPACE		= "줄 간격"
	HEALBOT_OPTIONS_SKINBCSPACE		= "칸 간격"
	HEALBOT_OPTIONS_EXTRASORT		= "바 정렬"
	HEALBOT_SORTBY_NAME				= "이름"
	HEALBOT_SORTBY_CLASS				= "직업"
	HEALBOT_SORTBY_GROUP				= "그룹"
	HEALBOT_SORTBY_MAXHEALTH			= "최대 체력"
	HEALBOT_OPTIONS_DELSKIN			= "삭제"
	HEALBOT_OPTIONS_NEWSKINTEXT		= "새로운 스킨"
	HEALBOT_OPTIONS_SAVESKIN			= "저장"
	HEALBOT_OPTIONS_SKINBARS			= "바 옵션들"
	HEALBOT_OPTIONS_SKINPANEL			= "패널 색"
	HEALBOT_SKIN_ENTEXT				= "활성화"
	HEALBOT_SKIN_DISTEXT				= "비활성화"
	HEALBOT_SKIN_DEBTEXT				= "디버프"
	HEALBOT_SKIN_BACKTEXT				= "배경"
	HEALBOT_SKIN_BORDERTEXT			= "테두리"
	HEALBOT_OPTIONS_HIDEABORT			= "중지 버튼 숨김"
	HEALBOT_OPTIONS_SKINFHEIGHT		= "글꼴 크기"
	HEALBOT_OPTIONS_ABORTSIZE			= "중지 크기"
	HEALBOT_OPTIONS_BARALPHADIS		= "투명도 비활성화"
	HEALBOT_OPTIONS_SHOWHEADERS		= "헤더 표시"

	HEALBOT_OPTIONS_ITEMS				= "아이템들";
	HEALBOT_OPTIONS_SPELLS			= "주문들";

	HEALBOT_OPTIONS_COMBOCLASS		= "직업 선택";
	HEALBOT_OPTIONS_CLICK				= "클릭";
	HEALBOT_OPTIONS_SHIFT				= "Shift+클릭:";
	HEALBOT_OPTIONS_CTRL				= "Ctrl+클릭:";
	HEALBOT_OPTIONS_SHIFTCTRL			= "Shift+Ctrl+클릭:";
	HEALBOT_OPTIONS_ENABLEHEALTHY		= "상처를 입지 않는 대상 치유";

	HEALBOT_OPTIONS_CASTNOTIFY1		= "알림 없음";
	HEALBOT_OPTIONS_CASTNOTIFY2		= "본인 알림";
	HEALBOT_OPTIONS_CASTNOTIFY3		= "대상 알림";
	HEALBOT_OPTIONS_CASTNOTIFY4		= "파티 알림";
	HEALBOT_OPTIONS_CASTNOTIFY5		= "공대 알림";
	HEALBOT_OPTIONS_TARGETWHISPER		= "대상에게 귓속말 알림";

	HEALBOT_OPTIONS_HEAL_BUTTONS		= "치료 버튼:";

	HEALBOT_OPTIONS_CDCBUTTONS		= "치료 버튼";
	HEALBOT_OPTIONS_CDCLEFT			= "Alt+왼쪽";
	HEALBOT_OPTIONS_CDCRIGHT			= "Alt+오른쪽";
	HEALBOT_OPTIONS_CDCBARS			= "체력바 색상";
	HEALBOT_OPTIONS_CDCCLASS			= "모니터 직업";
	HEALBOT_OPTIONS_CDCWARNINGS		= "디버프 경고";
	HEALBOT_OPTIONS_CDC				= "치료/디스펠/정화 등";
	HEALBOT_OPTIONS_SHOWDEBUFFWARNING	= "디버프시 경고 표시";
	HEALBOT_OPTIONS_SOUNDDEBUFFWARNING	= "디버프시 소리 재생";
	HEALBOT_OPTIONS_SOUND1			= "소리 1"
	HEALBOT_OPTIONS_SOUND2			= "소리 2"
	HEALBOT_OPTIONS_SOUND3			= "소리 3"

	HEALBOT_OPTIONS_HEAL_BUTTONS		= "치료 바";
	HEALBOT_OPTIONS_EMERGFILTER		= "치료 버튼 표시";

	HEALBOT_OPTIONS_GROUPHEALS		= "그룹";
	HEALBOT_OPTIONS_TANKHEALS			= "탱커";
	HEALBOT_OPTIONS_TARGETHEALS		= "대상";
	HEALBOT_OPTIONS_EMERGENCYHEALS	= "응급";
	HEALBOT_OPTIONS_HEALLEVEL			= "치료 레벨";
	HEALBOT_OPTIONS_ALERTLEVEL			= "경고 레벨";
	HEALBOT_OPTIONS_OVERHEAL			= "오버 치유 정지 버튼 표시"
	HEALBOT_OPTIONS_SORTHEALTH		= "체력";
	HEALBOT_OPTIONS_SORTPERCENT		= "백분율";
	HEALBOT_OPTIONS_SORTSURVIVAL		= "생존자";
	HEALBOT_OPTIONS_EMERGFCLASS		= "응급 버튼 표시";
	HEALBOT_OPTIONS_COMBOBUTTON		= "버튼";
	HEALBOT_OPTIONS_BUTTONLEFT		= "왼쪽";
	HEALBOT_OPTIONS_BUTTONMIDDLE		= "중간";
	HEALBOT_OPTIONS_BUTTONRIGHT		= "오른쪽";
	HEALBOT_OPTIONS_BUTTON4			= "버튼4";
	HEALBOT_OPTIONS_BUTTON5			= "버튼5";

	BINDING_HEADER_HEALBOT			= "HealBot";
	BINDING_NAME_TOGGLEMAIN			= "패널 열기";
	BINDING_NAME_HEALPLAYER			= "플레이어 치유";
	BINDING_NAME_HEALPET				= "소환수 치유";
	BINDING_NAME_HEALPARTY1			= "파티원 1 치유";
	BINDING_NAME_HEALPARTY2			= "파티원 2 치유";
	BINDING_NAME_HEALPARTY3			= "파티원 3 치유";
	BINDING_NAME_HEALPARTY4			= "파티원 4 치유";
	BINDING_NAME_HEALTARGET			= "선택 대상 치유";

	HEALBOT_OPTIONS_PROFILE			= "프로파일 설정:";
	HEALBOT_OPTIONS_ProfilePvP			= "PvP";
	HEALBOT_OPTIONS_ProfilePvE			= "PvE";

	HEALBOT_CLASSES_ALL				= "모든 직업";
	HEALBOT_CLASSES_MELEE				= "근거리";
	HEALBOT_CLASSES_RANGES			= "원거리";
	HEALBOT_CLASSES_HEALERS			= "힐러들";
	HEALBOT_CLASSES_CUSTOM			= "사용자";

	HEALBOT_OPTIONS_SHOWTOOLTIP		= "툴팁 표시";
	HEALBOT_OPTIONS_SHOWDETTOOLTIP	= "주문 정보 표시";
	HEALBOT_OPTIONS_SHOWUNITTOOLTIP	= "대상 정보 표시";
	HEALBOT_OPTIONS_SHOWRECTOOLTIP	= "즉각적인 주문 표시";
	HEALBOT_TOOLTIP_POSDEFAULT		= "기본 위치";
	HEALBOT_TOOLTIP_POSLEFT			= "Healbot의 좌측";
	HEALBOT_TOOLTIP_POSRIGHT			= "Healbot의 우측";
	HEALBOT_TOOLTIP_POSABOVE			= "Healbot의 상단";
	HEALBOT_TOOLTIP_POSBELOW			= "Healbot의 하단";
	HEALBOT_TOOLTIP_RECOMMENDTEXT	= "즉각적인 주문 추천";
	HEALBOT_TOOLTIP_NONE				= "사용할 수 없음";
	HEALBOT_TOOLTIP_ITEMBONUS			= "아이템 보너스";
	HEALBOT_TOOLTIP_ACTUALBONUS		= "실제 보너스";
	HEALBOT_TOOLTIP_SHIELD				= "보호";
	HEALBOT_WORDS_OVER				= "에서";
	HEALBOT_WORDS_SEC				= "초";
	HEALBOT_WORDS_TO				= "~";
	HEALBOT_WORDS_CAST				= "시전"
	HEALBOT_WORDS_FOR				= "for";

HEALBOT_WORDS_NONE              = "None";
HEALBOT_OPTIONS_ALT             = "Alt+click";
HEALBOT_DISABLED_TARGET         = "Target"
HEALBOT_OPTIONS_ENABLEDBARS     = "Enabled Bars";
HEALBOT_OPTIONS_DISABLEDBARS    = "Disabled Bars when out of combat";
HEALBOT_OPTIONS_SHOWCLASSONBAR  = "Show class on bar";
HEALBOT_OPTIONS_SHOWHEALTHONBAR = "Show health on bar";
HEALBOT_OPTIONS_BARHEALTH1      = "as delta";
HEALBOT_OPTIONS_BARHEALTH2      = "as percentage";
HEALBOT_OPTIONS_TIPTEXT         = "Tooltip information";
HEALBOT_OPTIONS_BARINFOTEXT     = "Bar information";
HEALBOT_OPTIONS_POSTOOLTIP      = "Position tooltip";
HEALBOT_OPTIONS_SHOWCLASSNAME   = "Include name";
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR1 = "Show text in class colour"
HEALBOT_OPTIONS_BARTEXTCLASSCOLOUR2 = "Overrides Enabled and Debuff on the skin tab"

end