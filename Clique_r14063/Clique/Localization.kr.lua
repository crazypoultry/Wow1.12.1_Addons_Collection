--[[---------------------------------------------------------------------------------
    Localisation for Korean
----------------------------------------------------------------------------------]]

local L = AceLibrary("AceLocale-2.0"):new("Clique")

L:RegisterTranslations("koKR", function()
    return {
        RANK			    = "레벨",
        RANK_PATTERN		    = "(%d+) 레벨",
        MANA_PATTERN                = "마나 (%d+)",
        HEALTH_PATTERN              = "(%d+).+(%d+)",

        RANK_FORMAT		    = "%d 레벨",
	SPELL_FORMAT 		    = "%s(%d 레벨)",
        
        ["Lesser Heal"]             = "하급 치유",
        ["Heal"]                    = "치유",
        ["Greater Heal"]            = "상급 치유",
        ["Flash Heal"]              = "순간 치유",
        ["Healing Touch"]           = "치유의 손길",
        ["Regrowth"]                = "재생",
        ["Healing Wave"]            = "치유의 물결",
        ["Lesser Healing Wave"]     = "하급 치유의 물결",
        ["Holy Light"]              = "성스러운 빛",
        ["Flash of Light"]          = "빛의 섬광",

        DUAL_HOLY_SHOCK		    = "신성 충격",
        DUAL_MIND_VISION            = "마음의 눈",
        
        FREE_INNER_FIRE             = "내면의 열정",

        CURE_CURE_DISEASE  	    = "질병 치료",
        CURE_ABOLISH_DISEASE        = "질병 해제",
        CURE_PURIFY		    = "순화",
        CURE_CLEANSE  		    = "정화",
        CURE_DISPEL_MAGIC 	    = "마법 무효화",
        CURE_CURE_POISON	    = "해독",
        CURE_ABOLISH_POISON    	    = "독 해제",
        CURE_REMOVE_LESSER_CURSE    = "하급 저주 해제",
        CURE_REMOVE_CURSE	    = "저주 해제",

        BUFF_PWF		    = "신의 권능: 인내 연마",
        BUFF_PWS		    = "신의 권능: 보호막 연마",
        BUFF_SP			    = "어둠의 보호",
        BUFF_DS			    = "천상의 정신",
        BUFF_RENEW		    = "소생",
        BUFF_MOTW		    = "야생의 징표",
        BUFF_THORNS		    = "가시",
        BUFF_REJUVENATION	    = "회복",
        BUFF_REGROWTH		    = "재생",
        BUFF_AI			    = "신비한 지능",
        BUFF_DM			    = "마법 감쇠",
        BUFF_AM			    = "마법 증폭",
        BUFF_BOM		    = "힘의 축복",
        BUFF_BOP		    = "보호의 축복",
        BUFF_BOW		    = "지혜의 축복",
        BUFF_BOS		    = "성역의 축복",
        BUFF_BOL		    = "빛의 축복",
        BUFF_BOSFC		    = "희생의 축복", 

        DEFAULT_FRIENDLY            = "기본 우호적",
        DEFAULT_HOSTILE             = "기본 적대적",

        BINDING_NOT_DEFINED         = "단축키가 지정되지 않았습니다.",
        COULD_NOT_FIND_MODULE       = "모듈을 찾을 수 없습니다. - \"%s\"",
        COULD_NOT_FIND_FRAME        = "프레임 \"%s\"를 찾을 수 없음 - 모듈 \"%s\"를 활성화 시",
        PLUGIN_NOT_PROPER           = "이 \"%s\" 를 위해 플러그인은 프레임리스트나 가능한 기능을 가지고 있지 않습니다.",
        NO_UNIT_FRAME               = "유닉트는 \"%s\" 만들기 위해 어울림을 결정하지 않을 수 있습니다.",
        CUSTOM_SCRIPT               = "사용자 스크립트",
        ERROR_SCRIPT		    = "|cff00ff33Clique: 다음과 같은 |cff00ff33스크립트|r |cffff3333오류:|r %s",
        ENABLED_MODULE		    = "|cff00ff33Clique: 다음을 위해 모듈을 가능케 함|r %s" ,

        TT_DROPDOWN                 = "당신이 현재 \"set\" 에 대한 편집을 하고 있습니다.",
        TT_LIST_ENTRY               = "더블클릭 : 수정, 클릭 : 선택",
        TT_DEL_BUTTON               = "선택된 요소 제거",
        TT_MAX_BUTTON               = "항상 최고레벨 주문 시전 변경",
        TT_NEW_BUTTON               = "새로운 사용자 스크립트 생성",
        TT_EDIT_BUTTON              = "클릭 시전 요소 수정",
        TT_OK_BUTTON                = "Clique 설정 화면 종료",
        TT_EDIT_BINDING             = "키설정을 바꾸기 위해 이곳을 클릭하십시요.",
        TT_NAME_EDITBOX             = "사용자 스크립트명",
        TT_SAVE_BUTTON              = "변경 내용 저장",
        TT_CANCEL_BUTTON            = "변경 내용 취소",
        TT_TEXT_EDITBOX             = "사용자 LUA 코드 입력",
        TT_PULLOUT_TAB              = "Clique 설정 화면 열고 닫기" ,
    }
end)
