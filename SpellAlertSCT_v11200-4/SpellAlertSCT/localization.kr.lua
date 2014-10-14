if (GetLocale()=="koKR") then
	-- Korean by gygabyte
	-- Default Spells/Emotes that will be ignored
	SA_SPELLS_IGNORE = 
	{
		["독 해제"] = 1;
		["조준 사격"] = 1;
		["신비한 지능"] = 1;
		["신비한 사격"] = 1;
		["은빛여명회 위임봉"] = 1;
		["치타의 상"] = 1;
		["매의 상"] = 1;
		["원숭이의 상"] = 1;
		["공격"] = 1;
		["전투의 외침"] = 1;
		["피의 분노"] = 1;
		["피의 광기"] = 1;
		["피의 서약"] = 1;
		["전투 태세"] = 1;
		["광폭 태세"] = 1;
		["폭풍의 칼날"] = 1;
		["점멸"] = 1;
		["정신 집중"] = 1;
		["냉혈"] = 1;
		["충격포"] = 1;
		["질주"] = 1;
		["방어 태세"] = 1;
		["기원의 오라"] = 1;
		["격노"] = 1;
		["회피"] = 1;
		["폭발 사격"] = 1;
		["소실"] = 1;
		["화염 저항의 오라"] = 1;
		["질풍"] = 1;
		["집중력"] = 1;
		["신속"] = 1;
		["신성한 힘"] = 1;
		["신의 계시"] = 1;
		["줄리의 축복"] = 1;
		["냉정"] = 1;
		["냉혹함"] = 1;
		["독사 쐐기"] = 1;
		["산탄 사격"] = 1;
		["방패 막기"] = 1;
		["구원의 영혼"] = 1;
		["정신력 누출"] = 1;
		["전력 질주"] = 1;
		["은신"] = 1;
		["재빠른 변신"] = 1;
		["치타 변신"] = 1;
		["정조준 오라"] = 1;
		["살무사 쐐기"] = 1;
	};

	SA_MOBS_ACCEPT = 
	{
	};

	SA_PTN_SPELL_BEGIN_CAST = "(.+)|1이;가; (.+)|1을;를; 시전합니다.";
	SA_PTN_SPELL_GAINS_X = "(.+)|1이;가; (%d+)의 (.+)|1을;를; 얻었습니다.";
	SA_PTN_SPELL_GAINS = "(.+)|1이;가; (.+) 효과를 얻었습니다.";
	SA_PTN_SPELL_TOTEM = "(.+)|1이;가; (.+) 토템을 시전합니다.";
	SA_PTN_SPELL_FADE = "(.+)의 몸에서 (.+) 효과가 사라졌습니다.";
	SA_PTN_SPELL_BEGIN_PERFORM = "(.+)|1이;가; (.+)|1을;를; 사용합니다.";

	SA_WOTF = "언데드의 의지";
	SA_BERSERKER_RAGE = "광전사의 격노";
	SA_AFFLICT_LIVINGBOMB = "살아있는 폭탄에 걸렸습니다.";
	SA_EMOTE_DEEPBREATH = "깊은 숨을 들이쉽니다...";

	SASCT_HUNTER = "사냥꾼";
	SASCT_FEIGNDEATH = "죽은척하기";
	SASCT_ERRNOSTYLE = "현재 설정에 오류가 있습니다, 움직임 형태를 찾지 못했습니다.";
	SASCT_ADDONTEST = "님이 애드온을 테스트 합니다.";
	SASCT_ONY = "오닉시아";
	SASCT_EMOTESPACE = "|1이;가; ";
	SASCT_LOADPRINT = "  by BarryJ (Eugorym of Perenolde). 도움말을 보실려면 '/sasct' 또는 '/ss' 를 입력하세요.";
	SASCT_PROFILELOADED = "님 프로필을 불러왔습니다.";

	SASCT_BEGIN_CAST = "|1을;를; 시전합니다.";
	SASCT_GAINS = "효과를 얻었습니다.";

	SASCT_USAGE_HEADER_1 = " 사용법/도움말";
	SASCT_USAGE_HEADER_2 = "-- BarryJ (Eugorym of Perenolde)에 의한 만들어진 SpellAlertSCT ";
	SASCT_USAGE_CRIT = "치명타 메시지로 표시할지의 여부를 결정합니다.; 만약에 움직임 형태를 설정하지 않는다면 표시되지 않습니다.  [기본값 : 꺼짐]";
	SASCT_USAGE_STATUS = "현재 설정 상태를 표시합니다";
	SASCT_USAGE_STYLE = "사용할 움직임 형태.  [기본값 : vertical]";
	SASCT_USAGE_TARGETONLY = "선택한 대상의 주문만 경고할지의 여부를 결정합니다.  [기본값 : 꺼짐]";
	SASCT_USAGE_TEST = "화면에 어떻게 보이는 지 보기 위해서 테스트 메시지를 보냅니다.  (또한 설정 변경 후 자동적으로 적용됩니다)";
	SASCT_USAGE_TARGETINDICATOR = "대상이 시전하는 메시지 경고 앞뒤에 문자열을 삽입합니다.  [기본값 : ' *** ']";
	SASCT_USAGE_RETARGET = "사냥꾼이 죽은척하기를 했을 때 대상을 재타겟팅 합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_BOSSWARNINGS = "오닉시아 깊은 숨과 남작 게돈의 살아있는 불길을 경고합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_TOGGLE = "주문 시전 알림을 경고합니다.  [기본값 : 켜짐]";
	SASCT_USAGE_COLOR = "메시지의 색상을 설정합니다."; -- 11000-9
	SASCT_USAGE_EMOTES = "주문과 같이 나오는 감정 표현을 경고합니다.  [기본값 : 켜짐]"; -- 11000-9
	SASCT_USAGE_COMPACT = "압축된 메시지로 표시할지의 여부를 결정합니다.  [기본값 : 꺼짐]"; -- 11000-10
	SASCT_USAGE_REPEAT = "같은 메시지를 반복하는 것을 삼가하는 얼마동안의 초시간 [기본값 : 2]"; -- 11100-1
	SASCT_USAGE_IGNORE = "무시 목록을 사용할 수 있는 토글.  [기본값 : 켜짐]"; -- 11100-2
	SASCT_USAGE_IADD = "무시 목록에 주문을 추가합니다"; -- 11100-2
	SASCT_USAGE_IREM = "무시 목록에 주문을 삭제합니다"; -- 11100-2
	SASCT_USAGE_COLORIZE = "메시지의 색상을 표시할지의 여부를 결정합니다. (색상 선택에 우선함)  [기본값 : 켜짐]"; -- 11100-2
	SASCT_USAGE_FRAME = "SpellAlertSCT를 출력할 창을 설정합니다. (메시지 움직임을 사용하지 않는 경우만)  [기본값 :  1]"; -- 11100-3
	
	SASCT_RETARGET_1 = "적의 ";
	SASCT_RETARGET_2 = "|1으로;로; 인한 혼란 후 타겟 재설정 : ";

	SASCT_STATUS_CRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시합니다."
	SASCT_STATUS_CRIT_2 = "";
	SASCT_STATUS_NONCRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시하지 않습니다."
	SASCT_STATUS_TARGETONLY_ON = "선택한 대상의 주문만 경고합니다.";
	SASCT_STATUS_TARGETONLY_OFF = "모든 대상의 주문을 경고합니다.";
	SASCT_STATUS_EMOTES_ON = "감정 표현 경고 : 켜기";
	SASCT_STATUS_EMOTES_OFF = "감정 표현 경고 : 끄기";
	SASCT_STATUS_COLOR = "r/g/b 색상 사용 : ";
	SASCT_STATUS_COLOR_DEFAULT = " <- 기본 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_TARGET = " <- 대상 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_WARN = " <- 보스 경고 색상."; -- 11000-9
	SASCT_STATUS_TARGETINDICATOR = "대상 문자열 표시 : ";
	SASCT_STATUS_TOGGLE_ON = "주문 시전 알림 활성화."; -- 11000-9
	SASCT_STATUS_TOGGLE_OFF = "주문 시전 알림 비활성화."; -- 11000-9
	SASCT_STATUS_COMPACT_ON = "압축된 메시지 활성화."; -- 11000-10
	SASCT_STATUS_COMPACT_OFF = "압축된 메시지 비활성화."; -- 11000-10
	SASCT_STATUS_BOSSWARN_ON = "보스 경고 알림 : 켜짐"; -- 11000-11
	SASCT_STATUS_BOSSWARN_OFF = "보스 경고 알림 : 꺼짐"; -- 11000-11
	SASCT_STATUS_REPEAT = "메시지 반복 지연 : " -- 11100-1
	SASCT_STATUS_IGNORE_ON = "무시 목록 필터링 : 켜짐"; -- 11100-2
	SASCT_STATUS_IGNORE_OFF = "무시 목록 필터링 : 꺼짐"; -- 11100-2
	SASCT_STATUS_COLORIZE_ON = "색상화 : 켜짐"; -- 11100-2
	SASCT_STATUS_COLORIZE_OFF = "색상화 : 꺼짐"; -- 11100-2
	SASCT_STATUS_FRAME = " SCT 창으로 출력"; -- 11100-3
	
	SASCT_OPT_CRIT_OFF = "치명타 메시지로 표시 - 끄기.";
	SASCT_OPT_CRIT_ON = "치명타 메시지로 표시 - 켜기.";
	SASCT_OPT_STYLE_NOSTYLE = "사용할 움직임 형태를 정해야 합니다.";
	SASCT_OPT_STYLE_MESSAGE = "SCT 메시지로 표시.";
	SASCT_OPT_STYLE_VERTICAL = "세로 움직임 형태 표시(기본값).";
	SASCT_OPT_STYLE_RAINBOW = "무지개 움직임 형태 표시.";
	SASCT_OPT_STYLE_HORIZONTAL = "가로 움직임 형태 표시.";
	SASCT_OPT_STYLE_ANGLEDDOWN = "아래로 모난 움직임 형태 표시.";
	SASCT_OPT_STYLE_ANGLEDUP = "위로 모난 움직임 형태 표시.";
	SASCT_OPT_STYLE_SPRINKLER = "물뿌리개 움직임 형태 표시.";
	SASCT_OPT_STYLE_CHOICES = "움직임 형태는 [message/vertical/rainbow/horizontal/angled down/angled up/sprinkler] 중에서 정해야 합니다.";
	SASCT_OPT_TARGETONLY_OFF = "모든 대상의 주문을 경고합니다.";
	SASCT_OPT_TARGETONLY_ON = "선택한 대상의 주문만 경고합니다.";
	SASCT_OPT_EMOTES_OFF = "감정 표현 경고를 사용하지 않습니다.";
	SASCT_OPT_EMOTES_ON = "감정 표현 경고를 사용합니다.";
	SASCT_OPT_COLOR_COICES = "0.0과 1.0 사이의 숫자를 선택해야 합니다.";
	SASCT_OPT_TARGETINDICATOR_BLANK = "대상 문자열 표시 설정 : (blank)";
	SASCT_OPT_TARGETINDICATOR_SET = "대상 문자열 표시 설정 : ";
	SASCT_OPT_RESET = "설정을 초기화 합니다.";
	SASCT_OPT_RETARGET_ON = "죽은척하기 재타겟 : 켜기";
	SASCT_OPT_RETARGET_OFF = "죽은척하기 재타겟 : 끄기";
	SASCT_OPT_BOSSWARNINGS_ON = "보스 경고 : 켜기";
	SASCT_OPT_BOSSWARNINGS_OFF = "보스 경고 : 끄기";
	SASCT_OPT_COMPACT_ON = "압축 메시지 : 켜기";
	SASCT_OPT_COMPACT_OFF = "압축 메시지 : 끄기";
	SASCT_OPT_REPEAT_SET = "메시지 반복 시간 : "; -- 11100-1
	SASCT_OPT_REPEAT_ERROR = "숫자를 입력해야만 합니다."; --11100-1
	SASCT_OPT_IGNORE_ON = "무시 목록 필터링 : 켜기"; -- 11100-2
	SASCT_OPT_IGNORE_OFF = "무시 목록 필터링 : 끄기"; -- 11100-2
	SASCT_OPT_NEEDSPELL = "주문을 명확히 입력해야 합니다"; -- 11100-2
	SASCT_OPT_IADD = "Now ignoring "; -- 11100-2
	SASCT_OPT_IREM = "No longer ignoring "; -- 11100-2
	SASCT_OPT_COLORIZE_ON = "색상화 : 켜기"; -- 11100-2
	SASCT_OPT_COLORIZE_OFF = "색상화 : 끄기"; -- 11100-2
	SASCT_OPT_FRAME_SET = "Now outputting to frame "; -- 11100-3
	SASCT_OPT_FRAME_ERROR = "You must enter a frame to output to (1 or 2)"; --11100-3
	SASCT_OPT_LOAD_ERROR = "Loading Options Addon Error: "

	SASCT_OPT_TOGGLE_OFF = "비활성화.";
	SASCT_OPT_TOGGLE_ON = "활성화.";
	SASCT_OPT_COLOR_COLORS = "[red/green/blue] 중에서 색상을 선택해야 합니다.." -- 11000-9
	SASCT_OPT_COLOR_TYPES = "[default/target/warn/emote] 중에서 색상을 바꾸길 원하는 종류를 선택해야 합니다" -- 11000-9

	SASCT_STATUS_CRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시합니다."
	SASCT_STATUS_CRIT_2 = "";
	SASCT_STATUS_NONCRIT = " 움직임 형태를 사용하여 치명타 메시지로 표시하지 않습니다.";
	SASCT_STATUS_TARGETONLY_ON = "선택한 대상의 주문만 경고합니다.";
	SASCT_STATUS_TARGETONLY_OFF = "모든 대상의 주문을 경고합니다.";
	SASCT_STATUS_EMOTES_ON = "감정 표현 경고 : 켜기";
	SASCT_STATUS_EMOTES_OFF = "감정 표현 경고 : 끄기";
	SASCT_STATUS_COLOR = "r/g/b 색상 사용 : ";
	SASCT_STATUS_COLOR_DEFAULT = " <- 기본 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_TARGET = " <- 대상 경고 색상."; -- 11000-9
	SASCT_STATUS_COLOR_WARN = " <- 보스 경고 색상."; -- 11000-9
	SASCT_STATUS_TARGETINDICATOR = "대상 문자열 표시 : ";
	SASCT_STATUS_TOGGLE_ON = "주문 시전 알림 활성화."; -- 11000-9
	SASCT_STATUS_TOGGLE_OFF = "주문 시전 알림 비활성화."; -- 11000-9

--[[	SA_SPELLS_HEALS = 
	{
		-- 사제
		["순간 치유"] = 1,
		["상급 치유"] = 1,
		["치유"] = 1,
		["치유의 기원"] = 1,
		["하급 치유"] = 1,
		-- 드루이드
		["치유의 손길"] = 1,
		["재생"] = 1,
		["평온"] = 1,
		-- 주술사
		["치유의 물결"] = 1,
		["하급 치유의 물결"] = 1,
		-- 성기사
		["성스러운 빛"] = 1,
		["빛의 섬광"] = 1,
	};

	SA_SPELLS_CC = 
	{
		-- 사제
		["정신 지배"] = 1,
		-- 드루이드
		["휘감는 뿌리"] = 1,
		-- 마법사
		["변이"] = 1,
		-- 흑마법사
		["공포"] = 1,
		["공포의 울부짖음"] = 1,
		["현혹"] = 1,
		["악마 지배"] = 1,
		["추방"] = 1,
		-- 성기사
		["언데드 퇴치"] = 1,
		-- 사냥꾼
		-- ["야수 겁주기"] =1,
	};

	SA_SPELLS_DISPELABLE = 
	{
		-- 사제
		["신의 권능: 보호막"] = 1,
		["소생"] = 1,
		["내면의 열정"] = 1,
		["신의 권능: 인내"] = 1,
		["어둠의 보호"] = 1,
		["천상의 정신"] = 1,
		-- 드루이드
		["회복"] = 1,
		["가시"] = 1,
		["야생의 징표"] = 1,
		["재생"] = 1,
		["정신 자극"] = 1,
		-- 마법사
		["신비한 지능"] = 1,
		["냉기 갑옷"] = 1,
		["화염계 수호"] = 1,
		["냉기계 수호"] = 1,
		["얼음 갑옷"] = 1,
		["마법사 갑옷"] = 1,
		["신비의 마법 강화"] = 1,
		["얼음 보호막"] = 1,
		["마나 보호막"] = 1,
		-- 주술사
		["번개 보호막"] = 1,
		["질풍의 무기"] = 1,
		["자연의 신속함"] = 1,
		["수면 걷기"] = 1,
		["늑대 정령"] = 1,
		-- 흑마법사
		["악마의 피부"] = 1,
		["악마의 갑옷"] = 1,
		["암흑계 수호"] = 1,
		-- Unknown
		["선인의 인내력"] = 1,
		["마력의 힘"] = 1,
	};

	SA_SPELLS_DAMAGE = 
	{
		-- 사제
		["정신 분열"] = 1,
		["마나 연소"] = 1,
		["별조각"] = 1,
		["성스러운 일격"] = 1,
		["정신의 채찍"] = 1,
		["신성한 불꽃"] = 1,
		-- 드루이드
		["천벌"] = 1,
		["별빛 화살"] = 1,
		["허리케인"] = 1,
		-- 사냥꾼
		["연발 사격"] = 1,
		-- 마법사
		["얼음 화살"] = 1,
		["화염구"] = 1,
		["신비한 화살"] = 1,
		["신비한 폭발"] = 1,
		["눈보라"] = 1,
		["불덩이 작열"] = 1,
		["순간이동: 아이언포지"] = 1,
		["순간이동: 오그리마"] = 1,
		["순간이동: 스톰윈드"] = 1,
		["순간이동: 언더시티"] = 1,
		["순간이동: 다르나서스"] = 1,
		["순간이동: 썬더 블러프"] = 1,
		["차원의 문: 아이언포지"] = 1,
		["차원의 문: 오그리마"] = 1,
		["차원의 문: 스톰윈드"] = 1,
		["차원의 문: 언더시티"] = 1,
		["차원의 문: 다르나서스"] = 1,
		["차원의 문: 썬더 블러프"] = 1,
		["불태우기"] = 1,
		["불덩이 작열"] = 1,
		["불기둥"] = 1,
		-- 주술사
		["번개 화살"] = 1,
		["연쇄 번개"] = 1,
		-- 흑마법사
		["제물"] = 1,
		["부패"] = 1,
		["어둠의 화살"] = 1,
		["영혼 흡수"] = 1,
		["생명력 집중"] = 1,
		["생명력 흡수"] = 1,
		["불타는 고통"] = 1,
		["소환 의식"] = 1,
		["마나 흡수"] = 1,
		["지옥의 불길"] = 1,
		["점화"] = 1,
		["영혼의 불꽃"] = 1,
		-- 성기사
		["천벌의 망치"] = 1,
	};]]
end
