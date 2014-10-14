if (GetLocale() == "koKR") then
-- Thanks Sayclub for these on 8.24.2006

	TT_DISEASE_CLEANSING = "질병 정화";
	TT_EARTHBIND = "속박의";
	TT_FIRE_NOVA = "불꽃 회오리";
	TT_FIRE_RESISTANCE = "화염 저항";
	TT_FROST_RESISTANCE = "냉기 저항";
	TT_FLAMETONGUE = "불꽃의";
	TT_GRACE_OF_AIR = "은총의";
	TT_GROUNDING = "마법정화";
	TT_HEALING_STREAM = "치유의";
	TT_MAGMA = "용암";
	TT_ENAMORED_WATER_SPIRIT = "사로잡힌 물의";
	--TT_ENAMORED_WATER_SPIRIT = "Crescent";
	TT_ANCIENT_MANA_SPRING = "Ancient Mana Spring";
	TT_MANA_SPRING = "마나샘";
	TT_MANA_TIDE = "마나 해일";
	TT_NATURE_RESISTANCE = "자연 저항";
	TT_POISON_CLEANSING = "독 정화";
	TT_SEARING = "불타는";
	TT_SENTRY = "감시의";
	TT_STONECLAW = "돌발톱";
	TT_STONESKIN = "돌가죽";
	TT_STRENGTH_OF_EARTH = "대지력";
	TT_TREMOR = "진동의";
	TT_TRANQUIL_AIR = "평온의";
	TT_WINDFURY = "질풍의";
	TT_WINDWALL = "바람막이";

	TT_EARTH = "대지";
	TT_AIR = "바람";
	TT_WATER = "물";
	TT_FIRE = "불";

	TT_SHAMAN = "주술사";

	TT_VERTICAL = "수직";
	TT_HORIZONTAL = "수평";
	TT_BOX = "박스";
	TT_LEFT = "좌측";
	TT_RIGHT = "우측";
	TT_TOP = "상단";
	TT_BOTTOM = "하단";
	TT_ON = "켬";
	TT_OFF = "끔";
	TT_BUFF = "버프";
	TT_FIXED = "고정";
	TT_ELEMENT = "요소";
	TT_STICKY = "스틱";
	TT_BLIZZARD = "기본";
	TT_CT = "ct";
	TT_SHOW = "표시";
	TT_HIDE = "숨김";
	TT_LOCK = "잠금";
	TT_UNLOCK = "이동";
	TT_ARRANGE = "배열";
	TT_ALIGN = "정렬";
	TT_WARN = "경고";
	TT_NOTIFY = "알림";
	TT_STYLE = "스타일";
	TT_TIME = "시간";
	TT_ORDER = "순서";

	TT_SLASH = {};
	TT_SLASH[1] = "토템 타이머 슬래시 명령어들:";
	TT_SLASH[2] = "/토템 "..TT_SHOW.." - 토템 타이머 표시 (활성화)";
	TT_SLASH[3] = "/토템 "..TT_HIDE.." - 토템 타이머 숨김 (비활성화)";
	TT_SLASH[4] = "/토템 "..TT_LOCK.." - 토템 타이머 위치 잠금";
	TT_SLASH[5] = "/토템 "..TT_UNLOCK.." - 토템 타이머 위치 이동";
	TT_SLASH[TT_ARRANGE] = "/토템 "..TT_ARRANGE.." ["..TT_HORIZONTAL.."|"..TT_VERTICAL.."|"..TT_BOX.."] - 아이콘 배열";
	TT_SLASH[TT_ALIGN]   = "/토템 "..TT_ALIGN.." ["..TT_LEFT.."|"..TT_RIGHT.."|"..TT_TOP.."|"..TT_BOTTOM.."] - 아이콘 정렬";
	TT_SLASH[TT_WARN]    = "/토템 "..TT_WARN.." ["..TT_ON.."|"..TT_OFF.."] - 사라짐 경고 켬/끔";
	TT_SLASH[TT_NOTIFY]  = "/토템 "..TT_NOTIFY.." ["..TT_ON.."|"..TT_OFF.."] - 파괴 알림 켬/끔";
	TT_SLASH[TT_STYLE]   = "/토템 "..TT_STYLE.." ["..TT_BUFF.."|"..TT_FIXED.."|"..TT_ELEMENT.."|"..TT_STICKY.."] - 토템 타이머 스타일 설정";
	TT_SLASH[TT_TIME]    = "/토템 "..TT_TIME.." ["..TT_BLIZZARD.."|"..TT_CT.."] - 시간 형식 설정";
	TT_SLASH[TT_ORDER]   = "/토템 "..TT_ORDER.." [요소1] [요소2] [요소3] [요소4] - 토템 배열 설정";

	TT_ERROR = "토템 타이머 에러!";
	TT_RESET = "토템 타이머가 초기화 되었습니다!";

	TT_USAGE = "명령어:";

	TT_VISIBLE = "[TT] 표시";
	TT_HIDDEN = "[TT] 숨김";

	TT_UNLOCKED = "[TT] 해제";
	TT_LOCKED = "[TT] 잠금";

	TT_PLAYERDEATH = "플레이어 죽음 - 토템 타이머 초기화";

	-- define our possible options for each setting
	TT_OPTION = {};
	TT_OPTION[TT_ARRANGE] = {};
	TT_OPTION[TT_ARRANGE][TT_VERTICAL] = TT_VERTICAL;
	TT_OPTION[TT_ARRANGE]["vert"] = TT_VERTICAL;
	TT_OPTION[TT_ARRANGE]["v"] = TT_VERTICAL;
	TT_OPTION[TT_ARRANGE][TT_HORIZONTAL] = TT_HORIZONTAL;
	TT_OPTION[TT_ARRANGE]["hor"] = TT_HORIZONTAL;
	TT_OPTION[TT_ARRANGE]["h"] = TT_HORIZONTAL;
	TT_OPTION[TT_ARRANGE][TT_BOX] = TT_BOX;
	TT_OPTION[TT_ALIGN] = {};
	TT_OPTION[TT_ALIGN][TT_LEFT] = TT_LEFT;
	TT_OPTION[TT_ALIGN][TT_BOTTOM] = TT_LEFT;
	TT_OPTION[TT_ALIGN][TT_RIGHT] = TT_RIGHT;
	TT_OPTION[TT_ALIGN][TT_TOP] = TT_RIGHT;
	TT_OPTION[TT_WARN] = {};
	TT_OPTION[TT_WARN][TT_ON] = TT_ON;
	TT_OPTION[TT_WARN][TT_OFF] = TT_OFF;
	TT_OPTION[TT_NOTIFY] = {};
	TT_OPTION[TT_NOTIFY][TT_ON] = TT_ON;
	TT_OPTION[TT_NOTIFY][TT_OFF] = TT_OFF;
	TT_OPTION[TT_STYLE] = {};
	TT_OPTION[TT_STYLE][TT_BUFF] = TT_BUFF;
	TT_OPTION[TT_STYLE][TT_FIXED] = TT_FIXED;
	TT_OPTION[TT_STYLE][TT_ELEMENT] = TT_ELEMENT;
	TT_OPTION[TT_STYLE][TT_STICKY] = TT_STICKY;
	TT_OPTION[TT_TIME] = {};
	TT_OPTION[TT_TIME][TT_BLIZZARD] = TT_BLIZZARD;
	TT_OPTION[TT_TIME][TT_CT] = TT_CT;

	TT_SETTING = {};
	TT_SETTING[TT_ARRANGE] = "[TT] 배열: %s";
	TT_SETTING[TT_ALIGN] = "[TT] 정렬: %s";
	TT_SETTING[TT_WARN] = "[TT] 경고: %s";
	TT_SETTING[TT_NOTIFY] = "[TT] 알림: %s";
	TT_SETTING[TT_STYLE] =  "[TT] 아이콘 스타일: %s";
	TT_SETTING[TT_TIME] = "[TT] 시간 형식: %s";
	TT_SETTING[TT_ORDER] = "[TT] 토템 순서: %s";

	TT_DESTROYED = "이 파괴되었습니다.";
	TT_WARNING = "의 지속시간이 얼마 남지 않았습니다.";

	TT_LOADED = "토템 타이머 애드온을 불려옵니다";

	-- Important Stuff
	TT_CAST_REGEX = "(.+) 토템|1을;를; 시전합니다.";
	TT_DEATH_REGEX = "(.+) 토템 ?(%a*)|1이;가; 파괴되었습니다.";
	TT_DAMAGE_REGEX = { 
		"+|1이;가; (.+) 토템 ?(%a*)|1을;를; 공격하여 (.+)의 피해를 입혔습니다.",
		"(.+) 토템 ?(%a*)|1을;를; 공격하여 (.+)의 치명상을 입혔습니다."
	};

	TT_TOTEM_REGEX = "(.+) 토템";
	TT_TRINKET_REGEX = "(.+) 정령";
	TT_RANK_REGEX = "(%d+) 레벨";
	TT_ELEMENT_REGEX = "도구: (.+)의 토템";

	TT_NAME_STRING = "%s 토템";
	TT_NAME_LEVEL_STRING = "%s 토템 (%d레벨)";
end