-- LOCALIZATION FILE

-- Common Strings
RESTPLUS_RESTING_TRUE = "";
RESTPLUS_RESTING_FALSE = "<!>";
RESTPLUS_RESTING_ACTIVE = "*";
RESTPLUS_DAYS = "d ";
RESTPLUS_SOUND = "TitanRest+ Sound ";
RESTPLUS_TIMER = "TitanRest+ Timer ";
RESTPLUS_ON = "ON";
RESTPLUS_OFF = "OFF";

-- Strings that can be localized to other languages
RESTPLUS_LOADED = "TitanRest+ v"..RESTPLUS_VERSION.." has Loaded.";
RESTPLUS_SAVE_CHAR = "TitanRest+ Character Saved";
RESTPLUS_RESET = "TitanRest+ Data Reset";
RESTPLUS_MSG_LEVEL = " has earned enough rest to reach their next level.";
RESTPLUS_MSG_CAPPED = " is fully rested and eager for adventure.";
RESTPLUS_HELP1 = "TitanRest+ command information:";
RESTPLUS_HELP2 = "/restplus                         = print rest info in chat";
RESTPLUS_HELP3 = "/restplus help                    = show command info";
RESTPLUS_HELP4 = "/restplus save                    = save current character";
RESTPLUS_HELP5 = "/restplus reset                   = delete all saved data";
RESTPLUS_HELP6 = "/restplus remove charName realm   = delete one character";
RESTPLUS_HELP7 = "/restplus sound                   = toggle sound on/off";
RESTPLUS_HELP8 = "/restplus timer                   = toggle timer on/off";
RESTPLUS_HELP9 = "/restplus delay n                 = set alert timer to n seconds";
RESTPLUS_HELP10 = "/restplus recycle                = reset options to default";
RESTPLUS_HELP11 = "/log                             = save current character and log out";

RESTPLUS_INVALID_TIME = "Please specify a positive integer.";
RESTPLUS_NOCHAR = "Character does not exist.";
RESTPLUS_DELAY_MSG = "The timer delay is set to ";
RESTPLUS_INSUFFICIENT_ARGS = "Insufficient arguments.";
RESTPLUS_CHAR_REMOVED = "Character removed: ";
RESTPLUS_LEVEL60 = "Maxed Experience";
RESTPLUS_UNKNOWN_REALM = "Unknown Realm";

TITAN_RESTPLUS_MENU_TEXT = "Rest+";
TITAN_RESTPLUS_BUTTON_LABEL =  "RestXP: ";
TITAN_RESTPLUS_TOOLTIP = "Rest+ Character RestXP Information";
TITAN_RESTPLUS_TOGGLE_REALM = "Show Realm";
TITAN_RESTPLUS_TOGGLE_CLASS = "Show Class";
TITAN_RESTPLUS_TOGGLE_STATE = "Show Resting State";
TITAN_RESTPLUS_TOGGLE_RESTXP = "Rest as a Percentage";
TITAN_RESTPLUS_TOGGLE_XP = "XP as a Percentage";
TITAN_RESTPLUS_TOGGLE_ACTIVE = "Button as a Percentage";
TITAN_RESTPLUS_ACTIVE = "Active Character: ";

-- Korean localization by techys
if ( GetLocale() == "koKR" ) then

RESTPLUS_LOADED = "TitanRest+ v"..RESTPLUS_VERSION.." 로드 완료.";
RESTPLUS_SAVE_CHAR = "TitanRest+ 캐릭터 저장";
RESTPLUS_RESET = "TitanRest+ 모든 자료 삭제";
RESTPLUS_MSG_LEVEL = " 다음레벨에 도달하기에 충분한 휴식경험치가 생겼습니다.";
RESTPLUS_MSG_CAPPED = " 충분히 휴식해서 모험에 나서고 싶어합니다.";
RESTPLUS_HELP1 = "TitanRest+ 커맨드 명령어:";
RESTPLUS_HELP2 = "/restplus                         = 휴식경험치 정보를 채팅창에 보입니다.";
RESTPLUS_HELP3 = "/restplus help                    = 커맨드 명령어를 알려줍니다.";
RESTPLUS_HELP4 = "/restplus save                    = 현재 캐릭터를 저장합니다.";
RESTPLUS_HELP5 = "/restplus reset                   = 저장된 모든 자료를 삭제합니다.";
RESTPLUS_HELP6 = "/restplus remove charName realm   = 지정된 캐릭터 하나를 삭제합니다.";
RESTPLUS_HELP7 = "/restplus sound                   = 소리를 켜고/끕니다.";
RESTPLUS_HELP8 = "/restplus timer                   = 타이머를 켜고/끕니다.";
RESTPLUS_HELP9 = "/restplus delay n                 = 경고 타이머를 n 초로 지정합니다.";
RESTPLUS_HELP10 = "/restplus recycle                = 모든 옵션을 기본값으로 돌립니다.";
RESTPLUS_HELP11 = "/log                             = 현재 캐릭터를 저장하고 로그아웃합니다.";

RESTPLUS_INVALID_TIME = "양수(양의 값을 가진 정수)로 입력하세요.";
RESTPLUS_NOCHAR = "캐릭터가 존재하지 않습니다.";
RESTPLUS_DELAY_MSG = "타이머가 지정되었습니다.";
RESTPLUS_INSUFFICIENT_ARGS = "변수가 적절하지 않습니다.";
RESTPLUS_CHAR_REMOVED = "캐릭터가 삭제되었습니다: ";
RESTPLUS_LEVEL60 = "만렙입니다.";
RESTPLUS_UNKNOWN_REALM = "서버가 없습니다.";

TITAN_RESTPLUS_MENU_TEXT = "Rest+";
TITAN_RESTPLUS_BUTTON_LABEL =  "휴식경험치: ";
TITAN_RESTPLUS_TOOLTIP = "Rest+ 캐릭터의 휴식경험치 정보";
TITAN_RESTPLUS_TOGGLE_REALM = "서버명 보이기";
TITAN_RESTPLUS_TOGGLE_CLASS = "직업 보이기";
TITAN_RESTPLUS_TOGGLE_STATE = "휴식 상태 보이기";
TITAN_RESTPLUS_TOGGLE_RESTXP = "휴식 경험치를 퍼센트로 지정";
TITAN_RESTPLUS_TOGGLE_XP = "경험치를 퍼센트로 지정";
TITAN_RESTPLUS_TOGGLE_ACTIVE = "버튼을 퍼센트로 지정";
TITAN_RESTPLUS_ACTIVE = "현재 캐릭터: ";

end