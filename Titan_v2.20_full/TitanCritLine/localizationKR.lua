-- Korean localization by techys (refered to robertto's localization)

if ( GetLocale() == "koKR" ) then

	NORMAL_HIT_TEXT	= "일반 타격";
	NORMAL_TEXT		= "일반";
	CRIT_TEXT		= "치명타";
	RECORDS_TEXT	= "기록";
	HIT_TEXT		= "타격";

	TITAN_CRITLINE_MENU_SETTINGS	= "설정";
	TITAN_CRITLINE_MENU_POSTGUILD	= "길드창에 붙이기";
	TITAN_CRITLINE_MENU_POSTPARTY	= "파티창에 붙이기";
	TITAN_CRITLINE_MENU_POSTRAID	= "공대창에 붙이기";

	TITAN_CRITLINE_OPTION_SPLASH_TEXT			= "화면에 새 최고기록 표시하기";
	TITAN_CRITLINE_OPTION_PLAYSOUNDS_TEXT		= "효과음 연주";
	TITAN_CRITLINE_OPTION_PVPONLY_TEXT			= "PvP 공격일 경우만 카운트하기";
	TITAN_CRITLINE_OPTION_SCREENCAP_TEXT		= " 기록이 갱신되면 스크린 캡춰";
	TITAN_CRITLINE_OPTION_LVLADJ_TEXT			= "레벨 조절 사용";
	TITAN_CRITLINE_OPTION_FILTER_HEALING_TEXT	= "치유 주문 카운트 안하기";
	TITAN_CRITLINE_OPTION_RESET_TEXT			= "기록 초기화";
	TITAN_CRITLINE_OPTION_FILTER_TEXT			= "필터";
	TITAN_CRITLINE_OPTION_UPDATE_TEXT			= "수동 업데이트";
	TITAN_CRITLINE_OPTION_SHOW_CRIT_TEXT		= "치명타 퍼센트 보이기";
	TITAN_CRITLINE_OPTION_ONCLICK_TEXT			= "클릭시 채팅창에 통계표시하기";
	TITAN_CRITLINE_OPTION_SHIFT_ONCLICK_TEXT	= "+ Shift";
	TITAN_CRITLINE_OPTION_SHOWHITS_TEXT			= "모든 타격 툴팁에 표시";
	TITAN_CRITLINE_OPTION_MOBFILTER_TEXT		= "특정 몹 데미지 카운트 제외";

	TITAN_CRITLINE_OPTION_SPLASH_HELPTEXT			= "화면 표시\n새 기록시 화면 중앙에 표시하기.";
	TITAN_CRITLINE_OPTION_PLAYSOUNDS_HELPTEXT		= "효과음\n새 기록시 효과음 연주하기.";
	TITAN_CRITLINE_OPTION_PVPONLY_HELPTEXT			= "PvP\n설정시 다른 플레이어와의 타격만 기록.";
	TITAN_CRITLINE_OPTION_SCREENCAP_HELPTEXT		= "스크린샷\n새 기록시 스크린샷 찍기.";
	TITAN_CRITLINE_OPTION_LVLADJ_HELPTEXT			= "레벨조정\n타겟과의 레벨차이가 설정한 수치보다\n크거나 작은 경우 기록하지 않음.";
	TITAN_CRITLINE_OPTION_FILTER_HEALING_HELPTEXT	= "치유주문 필터\n설정시 모든 치유주문(물약 포함) 기록않음.";
	TITAN_CRITLINE_OPTION_SHOW_CRIT_HELPTEXT		= "치명타\n각 공격의 치명타 퍼센트 보이기.";
	TITAN_CRITLINE_OPTION_ONCLICK_HELPTEXT			= "버튼 기능\n설정시 최고기록을 채팅창에 표시함.\n미설정시는 버튼클릭시 설정창 열음.";
	TITAN_CRITLINE_OPTION_SHIFT_ONCLICK_HELPTEXT	= "쉬프트 키를 눌렀을 경우만 채팅창 표시기능 사용.";
	TITAN_CRITLINE_OPTION_SHOWHITS_HELPTEXT			= "모든 타격\n설정시 해당 공격에 대한 모든 타격이 보임.";
	TITAN_CRITLINE_OPTION_MOBFILTER_HELPTEXT		= "특정 상위 인던에서 몇몇 몹은 특정 마법 주문에\n취약하기 때문에 이 옵션을 설정하면\n그들에 대한 타격은 기록되지 않음.";
	
	TITAN_CRITLINE_TOOLTIP_HEADER				= "요약";

	TITAN_CRITLINE_NEW_RECORD_MSG				= "새 %s 기록!";
	TITAN_CRITLINE_NEW_CRIT_RECORD_MSG			= "새 %s 치명타 기록!";

	TITAN_CRITLINE_MOBFILTER_01					= "크로마구스";
	TITAN_CRITLINE_MOBFILTER_02					= "죽음의발톱 부대장";
	TITAN_CRITLINE_MOBFILTER_03					= "죽음의발톱 고룡수호병";
	TITAN_CRITLINE_MOBFILTER_04					= "타락의 밸라스트라즈";
	TITAN_CRITLINE_MOBFILTER_05					= "무적의 오시리안";

	COMBAT_HIT_MSG = "(.+)|1을;를; 공격하여 (%d+)의 피해를 입혔습니다.";
	COMBAT_CRIT_MSG	= "(.+)|1을;를; 공격하여 (%d+)의 치명상을 입혔습니다.";
	COMBAT_HIT_SCHOOL_MSG	= "(.+)|1을;를; 공격하여 (%d+)의 (.+) 피해를 입혔습니다.";
	COMBAT_CRIT_SCHOOL_MSG	= "(.+)|1을;를; 공격하여 (%d+)의 (.+) 치명상 피해를 입혔습니다.";

	SPELL_HIT_MSG = "(.+)|1으로;로; (.+)에게 (%d+)의 피해를 입혔습니다.";
	SPELL_CRIT_MSG = "(.+)|1으로;로; (.+)에게 (%d+)의 치명상을 입혔습니다.";
	SPELL_HIT_SCHOOL_MSG	= "(.+)|1으로;로; (.+)에게 (%d+)의 (.+) 피해를 입혔습니다.";
	SPELL_CRIT_SCHOOL_MSG	= "(.+)|1으로;로; (.+)에게 (%d+)의 (.+) 치명상 피해를 입혔습니다.";

	HEAL_SPELL_SELF_HIT_MSG		= "(.+)|1으로;로; 생명력이 (%d+)만큼 회복되었습니다.";
	HEAL_SPELL_HIT_MSG = "(.+)|1으로;로; (.+)의 생명력이 (%d+)만큼 회복되었습니다.";
	HEAL_SPELL_SELF_CRIT_MSG	= "(.+)|1이;가; 극대화 효과를 발휘하여 생명력이 (%d+)만큼 회복되었습니다.";
	HEAL_SPELL_CRIT_MSG = "(.+)|1이;가; 극대화 효과를 발휘하여 (.+)의 생명력이 (%d+)만큼 회복되었습니다.";

end