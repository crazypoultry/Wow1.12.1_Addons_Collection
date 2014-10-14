if (GetLocale() == "koKR") then

-- ---------- GLOBALS ----------------------------------------------------------------
CHHT_LABEL_CLOSE       = "닫기";
CHHT_LABEL_DEFAULT     = "기본값";
CHHT_LABEL_DEFAULTS    = "기본값";
CHHT_LABEL_CONFIGURE   = '설정';

CHHT_LABEL_NONE        = '없음';

CHHT_LABEL_MOUSE_1_3   = "마우스 1/3";
CHHT_LABEL_MOUSE_2_3   = "마우스 2/3";
CHHT_LABEL_MOUSE_3_3   = "마우스 3/3";

CHHT_LABEL_PLAYER      = '플레이어';
CHHT_LABEL_PET         = '소환수';
CHHT_LABEL_PARTY       = '파티원';
CHHT_LABEL_PARTYPET    = '파티원 소환수';
CHHT_LABEL_RAID        = '공격대원';
CHHT_LABEL_RAIDPET     = '공격대원 소환수';
CHHT_LABEL_TARGET      = '대상';
CHHT_LABEL_PARTY1      = 'Party 1';
CHHT_LABEL_PARTY2      = 'Party 2';
CHHT_LABEL_PARTY3      = 'Party 3';
CHHT_LABEL_PARTY4      = 'Party 4';
CHHT_LABEL_PARTYPET1   = 'Party Pet 1';
CHHT_LABEL_PARTYPET2   = 'Party Pet 2';
CHHT_LABEL_PARTYPET3   = 'Party Pet 3';
CHHT_LABEL_PARTYPET4   = 'Party Pet 4';

CHHT_LABEL_PLAYER_LC   = '플레이어';
CHHT_LABEL_PET_LC      = '소환수';
CHHT_LABEL_PARTY_LC    = '파티';
CHHT_LABEL_PARTYPET_LC = '파티원 소환수';
CHHT_LABEL_RAID_LC     = '공격대';
CHHT_LABEL_RAIDPET_LC  = '공격대원 소환수';
CHHT_LABEL_TARGET_LC   = '대상';
CHHT_LABEL_PARTY1_LC   = 'party 1';
CHHT_LABEL_PARTY2_LC   = 'party 2';
CHHT_LABEL_PARTY3_LC   = 'party 3';
CHHT_LABEL_PARTY4_LC   = 'party 4';
CHHT_LABEL_PARTYPET1_LC= 'party pet 1';
CHHT_LABEL_PARTYPET2_LC= 'party pet 2';
CHHT_LABEL_PARTYPET3_LC= 'party pet 3';
CHHT_LABEL_PARTYPET4_LC= 'party pet 4';

CHHT_LABEL_RAID_GROUP_FORMAT = 'Raid Group %d';

CHHT_LABEL_MAX         = "최대";
CHHT_LABEL_MIN         = "최소";
CHHT_LABEL_ALWAYS      = "항상사용";
CHHT_LABEL_NEVER       = "사용안함";
CHHT_LABEL_CONTINOUSLY = "지속적으로";

CHHT_LABEL_UP          = "위";
CHHT_LABEL_DOWN        = "아래";
CHHT_LABEL_DN          = "아래";

CHHT_LABEL_LEFT        = '좌';
CHHT_LABEL_RIGHT       = '우';
CHHT_LABEL_TOP         = '상';
CHHT_LABEL_BOTTOM      = '하';
CHHT_LABEL_TOPLEFT     = 'TopLeft';
CHHT_LABEL_TOPRIGHT    = 'TopRIght';
CHHT_LABEL_BOTTOMLEFT  = 'BottomLeft';
CHHT_LABEL_BOTTOMRIGHT = 'BottomRight';

CHHT_LABEL_HIGHEST     = '최고 레벨';
CHHT_LABEL_MEMBERS     = '명';

CHHT_NUMBER_ONE        = '1';
CHHT_NUMBER_TWO        = '2';
CHHT_NUMBER_THREE      = '3';
CHHT_NUMBER_FOUR       = '4';
CHHT_NUMBER_FIVE       = '5';

CHHT_LABEL_UPDATE      = 'Update';

-- ---------- TABs -------------------------------------------------------------------
CHHT_TAB_HELP      = "도움말";
CHHT_TAB_CONFIG    = "설정";
CHHT_TAB_GUI       = "GUI";
CHHT_TAB_EXTENDED  = "Extended";
CHHT_TAB_FRIEND    = "아군";
CHHT_TAB_ENEMY     = "대상";
CHHT_TAB_PANIC     = "응급";
CHHT_TAB_EXTRA     = "확장";
CHHT_TAB_CHAINS    = "연쇄";
CHHT_TAB_BUFFS     = "버프";
CHHT_TAB_TOTEMS    = "토템";

-- ---------- HELP / FAQ -------------------------------------------------------------
CHHT_HELP_TRACKING_BUFF = "(약초 찾기, 광물 찾기, 야수 추적과 같은 추적 기술 효과 상실시..)";
CHHT_HELP_TITLE         = '도움말 / FAQ';
CHHT_HELP_MSG           = "ClickHeal 도움말";
CHHT_HELP_PAGE1         = "도움말";
CHHT_HELP_PAGE2         = "약자";
CHHT_HELP_PAGE3         = "FAQ";
CHHT_HELP_PAGE4         = "제작자";

CHHT_HELP_HELP =
  '|c00FFFF00정보|r\n'
..'ClickHeal은 먼저 대상을 지정할 필요 없이 한 번의 마우스 클릭만으로 주문을 시전할 수 있게 해줍니다. '
..'처음에는, ClickHeal은 힐러들을 위해서 만들어졌습니다. 이 점은 여전히 ClickHeal의 강점이지만, 다른 캐스터들에게도 매우 쓸모 있는 애드온입니다.\n\n'
..'|c00FFFF00주문 정의|r\n'
..'ClickHeal의 강점은 마우스 버튼에 대한 간편한 주문 정의입니다. 마우스의 모든 버튼을 활용하여 정의할 수 있습니다. 추가로 Shift와 같은 적용키를 활용해서 정의'
..'할 수도 있습니다.\n'
..'주문과 마우스 버튼은 대상과 아군 그리고 확장 버튼이라고 불리는 그룹으로 지정됩니다. 모든 것은 유닛과 창을 클릭함으로서 지정된 주문을 시전할 것입니다. '
..'예를 들자면 우호적 대상을 우클릭 한다면 치유 주문을 시전할 것이지만 적대적 대상을 우클릭 한다면 피해 주문을 시전할 것입니다.\n'
..'주문은 설정화면에서 정의할 수 있습니다. 해당하는 주문을 지정하기 위해서는 하단의 탭들 중 하나를 선택하면 됩니다. 선택된 범위에서 마우스 버튼 사용에 따른 주'
..'문을 정의할 수 있고 그외의 선택한 범위에 대한 일반적인 설정을 정의할 수 있습니다.\n\n'
..'|c00FFFF00ClickHeal에 대한 추가 사항|r\n'
..'ClickHeal은 주문을 지정하는 것 뿐만이 아니라 공격, 소환수 공격, 물약 사용 등의 특정 행동도 지정할 수 있습니다. '
..'또한 ClickHeal은 오버힐 등의 사항을 고려해서 주문 사용을 최적화 해줍니다.\n\n'
..'|c00FFFF00ClickHeal 창|r\n'
..'ClickHeal 창은 기본적으로 좌측편에 자리합니다. 다만 이를 상단의 얇은 검은색 바를 드래그 해서 이동할 수 있습니다. '
..'확장 버튼이라고 부르는 상단의 4개의 버튼은 일반 주문과 행동을 지정할 수 있습니다.\n'
..'확장 버튼 바로 아래에는 위급 상황 버튼이라는 큰 푸른색의 버튼이 있습니다. 여기에 플레이어의 마나가 표시되며 활성화된 디버프와 사라진 버프등이 표시됩니다. '
..'이 곳을 클릭하면 특별한 위급 상황에 따른 행동이 활성화 됩니다. 즉, ClickHeal이 현재 가장 필요한 동작들 - 타인을 치유한다거나 디버프를 해제, 파티원과 공격대'
..'원에게 버프를 주는 행위-을 자동으로 찾아서 실행합니다.\n'
..'위급 버튼의 아래에 있는 버튼은 플레이어를 표시하고 그 아래의 버튼은 파티원들을 표시합니다. 가장 하단의 창들은 플레이어의 소환수와 파티원들의 소환수를 표시'
..'합니다. 이 버튼들의 옆에 있는 버튼은 선택한 대상들을 표시합니다. 대상의 이름이 동일한 색상으로 표시되는 것은 파티원들이 동일한 대상을 선택하고 있다는 것을 '
..'의미 합니다.\n\n'
..'|c00FFFF00상세 설명|r\n'
..'ClickHeal에 대한 상세 설명과 설정에 대한 모든 도움말은 싸이트(|c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r)에서 확인하실 수 있습니다';

CHHT_HELP_TEXT_DEBUFFS = 
  '|c00FFFF00디버프 (적):\n'
..'|c00FF0000마|c00FFFFFF (마법)\n'
..'|c00FF0000저|c00FFFFFF (저주)\n'
..'|c00FF0000질|c00FFFFFF (질병)\n'
..'|c00FF0000독|c00FFFFFF (독)\n'
..'|c00FF8800붕|c00FFFFFF (붕대 치료)\n'
..'|c00FF8800P|c00FFFFFF (phase shifted imp)\n\n';

CHHT_HELP_TEXT_HOT = 
  '|c00FFFF00시간차 치유 (HOT) (녹)\n'
..'|c0000FF00회|c00FFFFFF (회복)\n'
..'|c0000FF00재|c00FFFFFF (재생)\n'
..'|c0000FF00소|c00FFFFFF (소생)\n\n';

CHHT_HELP_TEXT_SHIELD = 
  '|c00FFFF00보호막\n'
..'|c0000FF00보|c00FFFFFF (신의 권능: 보호막)\n'
..'|c00FF8800약|c00FFFFFF (약화된 영혼)\n\n';

CHHT_HELP_TEXT_BUFFS =
  '|c00FFFF00버프 상실 (황):\n'
..'|c00FFFF00B|r (Any buff, PANIC frame only)\n';

CHHT_HELP_TEXT_FINETUNE =
  '|c00FFFF00주문 조정:|c00FFFFFF\n'
..'|c0000CCFF신의 권능: 인내|c00FFFFFF -> 소생 -> 순간 치유\n'
..'|c0000CCFF소생|c00FFFFFF -> 순간 치유\n'
..'|c0000CCFF회복|c00FFFFFF -> 재생 -> 치유의 손길\n'
..'|c0000CCFF재생|c00FFFFFF -> 회복 -> 재생 (재생으로 복귀)'
;

CHHT_HELP_TEXT_UPPER_LOWER =
  '|c00FFFF00시간차 치유와 버프 효과가 사라질 경우에 알려줍니다.|r\n';

CHHT_HELP_FAQ =
  '|c00FFFF00어디에 가면 좀 더 자세한 도움말을 볼 수 있나요?|r\n'
..'|c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r로 가시면 ClickHeal에 관한 모든 정보를 보실 수 있습니다.\n\n'
..'|c00FFFF00설명서를 모두 읽었지만 아직도 궁금한 점이 남았어요. 어디로 문의하면 되나요?|r\n'
..'|c0000CCFFui.worldofwar.net|r 와 |c0000CCFFwww.curse-gaming.com|r에 페이지를 열고 있습니다. 그곳에서 ClickHeal을 검색한 후에 애드온의 메세지 게시판을 확인 '
..'해보세요. 만은 질문이 이미 그곳에 답변되어 있습니다. 그래도 불충분 하시다면 그곳에 질문을 해주세요.\n\n'
..'|c00FFFF00버그를 찾았어요, 또는 기능에 대한 제안이 있어요. 정보 교류를 하고 싶어요. 어떻게 해야 하나요?|r\n'
..'|c0000CCFFui.worldofwar.net|r와 |c0000CCFFwww.curse-gaming.com|r의 ClickHeal 페이지에 글을 작성해주세요. 정보 교류와 버그 보고에 대해서 매우 관심 깊게 보고 있습니다.';

CHHT_HELP_CREDITS =
  '|c00FFFF00애드온에 대하여|r\n'
..'ClickHeal은 rmet0815에 의해서 개발되었습니다. 이 애드온은 GPL (Gnu Public Licence)에 의해 보호받습니다. 따라서 일반적으로 동의 없이 사용하는 것은 문제가 되지 않습니다. '
..'그러나 GPL에 따라서 이 애드온의 변형이나 일부분만을 이용하는 것은 GPL하의 등록을 거쳐야 합니다.\n\n'
..'|c00FFFF00제작자|r\n'
..'프랑스어 번역: Genre, Mainsacr\195\169\n'
..'우리말 번역: Damjau\n'
..'German localization by: Rastibor, Teodred@Rat von Dalaran, Farook\n'
..'Simple Chinese localization by: Space Dragon\n'
..'Traditional Chinese localization by: Bell\n\n'
..'그리고 ClickHeal을 사용하고, 추천과 정보와 오류제보를 해주시는 모든 분들게 감사드립니다. 여러분들을 빼고는 오늘의 ClickHeal은 없었을 겁니다!';

-- ---------- COMMON / CH_HELP -------------------------------------------------------
CHHT_PET_ATTACK_NONE         = '없음';
CHHT_PET_ATTACK_HUNTERS_MARK = CH_SPELL_HUNTERS_MARK;

CHHT_UNITBUFF_AUTOMATIC      = '자동';
CHHT_UNITBUFF_POPUP          = '팝업창';

CHHT_GROUPBUFF_REFRESH_TIME  = '갱신 시간';
CHHT_GROUPBUFF_WARN_TIME     = '경고 시간';

-- ---------- MISC -------------------------------------------------------------------
CHHT_MISC_OPTIONS                       = '기타 설정';
CHHT_MISC_ADDONS			= '애드온';
CHHT_MISC_CTRA                          = "CT 공격대 도우미 병합";
CHHT_MISC_DUF                           = "Discord Unit Frames (DUF)";
CHHT_MISC_BONUSSCANNER                  = "BonusScanner";
CHHT_MISC_PCUF                          = "Perl Classic Unit Frames (PCUF)";
CHHT_MISC_ORA                           = "oRA";
CHHT_MISC_WOWGUI                        = "기본 WoW GUI";
CHHT_MISC_DECURSIVE                     = "Decursive 병합";
CHHT_MISC_NEEDYLIST                     = "Ralek's Needy List 병함";
CHHT_CAST_SPELL_BY_NAME_ON_SELF         = "Use new self-cast mechanism of World of Warcraft";
CHHT_MISC_DEBUG_LEVEL                   = "Debug Messages";
CHHT_MISC_RESETALL_Q                    = "ClickHeal 설정을 완전히 초기화 하기 위해서는 이 항목을 선택하고 버튼을 누르세요";
CHHT_MISC_RESETALL                      = "모두 초기화";
CHHT_MISC_PLUGINS                       = 'Plugins';
CHHT_CONFIG_PLUGIN_INFO_MSG             = 'Plugins can be disabled in the character login screen, "Plugin" button on the lower right';
CHHT_MISC_COMBAT                        = "Combat";
CHHT_MISC_COMBAT_SAFE_TAUNT             = "Safe taunt";
CHHT_MISC_COMBAT_SD                     = '자기 방어';
CHHT_MISC_COMBAT_SD_ATTACK              = "공격 받고 있지만 공격이 활성화 되지 않은 경우에 대상을 공격";
CHHT_MISC_COMBAT_SD_PET                 = "공격 받고 있지만 소환수가 전투중이 아닐 경우에 대상에게 공격";
CHHT_MISC_COMBAT_SD_HIT                 = "현재 자신이 직접 공격 받고 있는지 고려 해서 공격을 활성화";
CHHT_MISC_COMBAT_SD_MES                 = "메즈된 대상에 대해서 자동 공격 사용 안함(언데드 속박, 변이, ...)";
CHHT_MISC_COMBAT_SD_SWITCH              = "파티/공격대시에 자기방어 사용 안함";
CHHT_MISC_CDW                           = '재사용 대기시간 표시';
CHHT_MISC_CDW_EXTRA1                    = '1번 확장 버튼';
CHHT_MISC_CDW_EXTRA2                    = '2번 확장 버튼';
CHHT_MISC_CDW_EXTRA3                    = '3번 확장 버튼';
CHHT_MISC_CDW_EXTRA4                    = '4번 확장 버튼';
CHHT_MISC_CDW_SPELLS                    = '주문';
CHHT_MISC_CDW_BAG                       = "가방 안의 아이템의 재사용 대기시간 표시";
CHHT_MISC_OVERHEAL                      = 'Healing';
CHHT_MISC_OVERHEAL_COMBAT               = "전투중에 플레이어의 생명력이 설정된 수치 이하 일 때만 치유 주문 시전 시작";
CHHT_MISC_OVERHEAL_NOCOMBAT             = "비전투중일때 가장 효과적인 주문을 시전";
CHHT_MISC_OVERHEAL_DOWNSCALE            = "Downscale spell rank in combat to minimize overhealing";
CHHT_MISC_OVERHEAL_LOM_DOWNSCALE        = "How mana ranks to maximally downscale spell rank in combat if too low on mana";
CHHT_MISC_OVERHEAL_BASE                 = "기준점";
CHHT_MISC_OVERHEAL_HOT                  = "시간차 치유를 시전할 때 고려할 기준점";
CHHT_MISC_OVERHEAL_QUICK                = '빠른 치유';
CHHT_MISC_OVERHEAL_SLOW                 = '느린 치유';
CHHT_MISC_OVERHEAL_DPSCHECK             = "해당 시간이 지난뒤에 플레이어가 받을 데미지를 DPS를 통해서 계산해서 적용";
CHHT_MISC_OVERHEAL_CLICK_ABORT_PERC     = 'Health percentage of target to abort spell when heal underway and clicking again';
CHHT_MISC_OVERHEAL_MODIFY_TOTAL_PERC    = 'Percentage to modify total healing result with';
CHHT_MISC_OVERHEAL_OVERHEAL_ALLOWANCE   = 'How much overhealing per spell rank is allowed';
CHHT_MISC_OVERHEAL_LOM_NONE             = 'None';
CHHT_MISC_OVERHEAL_LOM_MAX              = 'Maximum';
CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT     = '%d spell ranks';
CHHT_MISC_OVERHEAL_GEAR                 = 'Include item heal bonuses in calculations (currently %s +heal)';
CHHT_MISC_OVERHEAL_FORMULA_QUICK        = "Formula for QUICK:";
CHHT_MISC_OVERHEAL_FORMULA_SLOW         = "Formula for SLOW:";
CHHT_MISC_NOTIFY_HIT                    = '공격 받고 있을 때';
CHHT_MISC_NOTIFY_HIT_SOUND              = "소리 재생";
CHHT_MISC_NOTIFY_HIT_SOUND_REPEAT       = "설정된 시간 경과 하기 전까지 재생 반복 안함";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PARTY     = "파티에 알림";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PLAY_EMOTE= "Play emote";
CHHT_MISC_NOTIFY_HIT_HITPOINTS          = "생명력이 설정된 수치 이하로 떨어졌을 때만 알림";
CHHT_MISC_NOTIFY_HIT_HITPOINT_SLIDER_TITLE = "생명력 (%d%%)";
CHHT_MISC_NOTIFY_HIT_HITPOINTS_FADE     = "소실이 활성화 되어 있거나 재사용 대기 시간 중일 때, 설정된 기준 이하로 생명력이 하락하면 알림(사제만 사용)";
CHHT_MISC_NOTIFY_HIT_REPEAT             = "설정된 시간 경과 하기 전까지 재생 반복 안함";
CHHT_MISC_NOTIFY_HIT_MSG                = "표시할 메세지";
CHHT_MISC_NOTIFY_OOM                    = '마나 고갈';
CHHT_MISC_NOTIFY_OOM_PARTY              = "파티에 알림";
CHHT_MISC_NOTIFY_OOM_RAID               = "Announce to raid";
CHHT_MISC_NOTIFY_OOM_CUSTOM_CHANNEL     = "Announce to custom channel";
CHHT_MISC_NOTIFY_OOM_PLAY_EMOTE         = "Play Emote";
CHHT_MISC_NOTIFY_OOM_MANA               = "마나가 설정된 수치 이하로 떨어질 때 알림";
CHHT_MISC_NOTIFY_OOM_SLIDER_TITLE       = '마나 (%d%%)';
CHHT_MISC_NOTIFY_OOM_REPEAT             = "설정된 시간 경과 하기 전까지 알림 반복 안함";
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL         = "Custom Channel"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_NAME    = "Name"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_PASSWORD= "Password"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_CHAT_BOX= "Chat Box";
CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL="Default Window";
CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT="Chat Window %d";
CHHT_MISC_NOTIFY_SPELLCAST              = 'Announce Spellcast';
CHHT_MISC_NOTIFY_SPELLCAST_SAY          = "일반대화로 알림";
CHHT_MISC_NOTIFY_SPELLCAST_TELL         = "대상에게 귓속말";
CHHT_MISC_NOTIFY_SPELLCAST_PARTY        = "파티 대화로 알림";
CHHT_MISC_NOTIFY_SPELLCAST_RAID         = "공격대 대화로 알림";
CHHT_MISC_NOTIFY_SPELLCAST_CUSTOM_CHANNEL="Custom Channel";
CHHT_MISC_PAGE1                         = "기타";
CHHT_MISC_PAGE2                         = "Plugins";
CHHT_MISC_PAGE3                         = "Combat";
CHHT_MISC_PAGE4                         = "재사용";
CHHT_MISC_PAGE5                         = "Healing";
CHHT_MISC_PAGE6                         = "알림";
CHHT_MISC_PAGE7                         = "알림 2";
CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT   = "생명력 백분률 (%s%%)";
CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT   = "치유 주문 수위 (%s%%)";
CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT   = "시간차 치유 주문 수위 (%s%%)";
CHHT_MISC_HIT_AGO_TITLE_FORMAT          = "%d 초 후에 누를경우";
CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT = "생명력 백분률 (%s%%)";
CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT="Overheal allowance (%s%%)";
CHHT_MISC_SECONDS_TITLE_FORMAT          = "초 (%s)";
CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT      = "modify total by (%s%%)";

-- ---------- GUI --------------------------------------------------------------------
CHHT_GUI_PARTY_SORT                   = '파티 정렬';
CHHT_GUI_MISC                         = '기타';
CHHT_GUI_PARTY_MEMBER_LABEL           = "파티원 이름 표시 방법 (or raid)";
CHHT_GUI_SHOW_FRIEND_DEBUFFS          = "아군 디버프 표시";
CHHT_GUI_TARGET_BACKGROUND_COLOR      = "대상창 배경 색상 생명력 색상 사용";
CHHT_GUI_SHOW_TARGET_DEBUFFS          = "대상 디버프 표시";
CHHT_GUI_FRAME_GROUP_MODE             = "창 그룸 모드";
CHHT_GUI_SHOW_CLICKHEAL_FRAMES        = "ClickHeal 창 표시";
CHHT_GUI_SHOW_PARTY_FRAMES            = "파티원창 표시";
CHHT_GUI_SHOW_PARTY_PETS_FRAMES       = "Show Party Pets";
CHHT_GUI_SHOW_WOW_PARTY_FRAMES        = "WoW 파티창 표시";
CHHT_GUI_SHOW_PLAYER_MANA             = "플레이어 마나 표시(플레이어 창에)";
CHHT_GUI_SHOW_PET_FOCUS               = "소환수 집중 표시";
CHHT_GUI_SHOW_PARTYPET_TARGET         = "파티원 소환수 대상 표시";
CHHT_GUI_SHOW_MES                     = "메즈 지속시간 표시(언데드 속박, 변이, ...)";
CHHT_GUI_SHOW_FIVE_SEC_RULE           = 'Show bar with "Five Seconds Rule" and mana regain';
CHHT_GUI_SHOW_HINTS                   = "설정창에 팁 표시";
CHHT_GUI_UPDATE_SLIDER_TITLE          = '효과 업데이트 간격 (%3.1f 초)';
CHHT_GUI_RESET_FRAME_POS              = "창 위치 초기화";
CHHT_GUI_MAIN_FRAMES                  = '메인창';
CHHT_GUI_FRAME_ALIGNMENT              = "창 정의";
CHHT_GUI_FRAME_EXTRA_WIDTH            = 'Extra Frame Width (%d)';
CHHT_GUI_FRAME_PANIC_WIDTH            = '응급창 너비 (%d)';
CHHT_GUI_FRAME_PLAYER_WIDTH           = '플레이어창 너비 (%d)';
CHHT_GUI_FRAME_PARTY_WIDTH            = '파티원창 너비 (%d)';
CHHT_GUI_FRAME_PET_WIDTH              = '소환수창 너비 (%d)';
CHHT_GUI_FRAME_PARTYPET_WIDTH         = '파티원 소환수창 너비 (%d)';
CHHT_GUI_FRAME_EXTRA_HEIGHT           = 'Extra Frame Height (%d)';
CHHT_GUI_FRAME_PANIC_HEIGHT           = '응급창 높이 (%d)';
CHHT_GUI_FRAME_PLAYER_HEIGHT          = '플레이어창 높이 (%d)';
CHHT_GUI_FRAME_PARTY_HEIGHT           = '파티원창 높이 (%d)';
CHHT_GUI_FRAME_PET_HEIGHT             = '소환수창 높이 (%d)';
CHHT_GUI_FRAME_PARTYPET_HEIGHT        = '파티원 소환수창 높이 (%d)';
CHHT_GUI_FRAME_EXTRA_SCALE            = 'Extra Frame Scale (%d%%)';
CHHT_GUI_FRAME_PANIC_SCALE            = 'Panic Frame Scale (%d%%)';
CHHT_GUI_FRAME_PLAYER_SCALE           = 'Player Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTY_SCALE            = 'Party Frame Scale (%d%%)';
CHHT_GUI_FRAME_PET_SCALE              = 'Pet Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTYPET_SCALE         = 'Party Pet Frame Scale (%d%%)';
CHHT_GUI_TARGET_FRAMES                = '대상창';
CHHT_GUI_SHOW_TARGETS                 = "대상 표시";
CHHT_GUI_FRAME_PLAYER_TARGET_WIDTH    = '플레이어 대상창 너비 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_WIDTH     = '파티원 대상창 너비 (%d)';
CHHT_GUI_FRAME_PET_TARGET_WIDTH       = '소환수 대상창 너비 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_WIDTH  = '파티원 소환수 대상창 너비 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_HEIGHT   = '플레이어 대상창 높이 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_HEIGHT    = '파티원 대상창 높이 (%d)';
CHHT_GUI_FRAME_PET_TARGET_HEIGHT      = '소환수 대상창 높이 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_HEIGHT = '파티원 소환수 대상창 높이 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_SCALE    = 'Player Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTY_TARGET_SCALE     = 'Party Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PET_TARGET_SCALE       = 'Pet Target Frame Scale (%d%%)';
CHHT_GUI_FRAME_PARTYPET_TARGET_SCALE  = 'Party Pet Target Frame Scale (%d%%)';
CHHT_GUI_TOOLTIPS                     = '툴팁';
CHHT_GUI_SHOW_GAME_TOOLTIPS           = "툴팁 표시 방법";
CHHT_GUI_SHOW_GAME_TOOLTIPS_LOCATION  = "Location of game tooltips";
CHHT_GUI_SHOW_ACTION_TOOLTIPS         = "주문/행동 정의 툴팁 표시 방법";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK       = "툴팁에 주문 레벨 표시";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK_MAX   = "최고위 레벨 기술 사용시 구분자 표시";
CHHT_GUI_PAGE1                        = "기타";
CHHT_GUI_PAGE2                        = "메인창";
CHHT_GUI_PAGE3                        = "대상창";
CHHT_GUI_PAGE4                        = "툴팁";
CHHT_GUI_PAGE5                        = "Anchors";
CHHT_GUI_FRAME_GROUP_MODE_ALL         = '모든 그룹';
CHHT_GUI_FRAME_GROUP_MODE_GROUP       = '그룹 생성';
CHHT_GUI_TARGET_COLOR_NEVER           = '사용 안함';
CHHT_GUI_TARGET_COLOR_PLAYER          = '플레이어';
CHHT_GUI_TARGET_COLOR_ALWAYS          = '항상';
CHHT_GUI_TARGET_DEBUFF_NONE           = '없음';
CHHT_GUI_TARGET_DEBUFF_CASTABLE       = '시전가능한 디버프';
CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE = '시전 가능한 적의 디버프만';
CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL      = '적의 모든 디버프';ALL='모든 디버프';
CHHT_GUI_TARGET_DEBUFF_ALL            = '모두';
CHHT_GUI_FRAME_ALIGN_LEFT             = '좌';
CHHT_GUI_FRAME_ALIGN_CENTER           = '중앙';
CHHT_GUI_FRAME_ALIGN_RIGHT            = '우';
CHHT_GUI_DOCK_TARGET_NONE             = '없음';
CHHT_GUI_DOCK_TARGET_RIGHT            = '우';
CHHT_GUI_DOCK_TARGET_LEFT             = '좌';
CHHT_GUI_UNIT_TOOLTIP_ALWAYS          = '항상';
CHHT_GUI_UNIT_TOOLTIP_NEVER           = '사용안함';
CHHT_GUI_UNIT_TOOLTIP_SHIFT           = 'Shift';
CHHT_GUI_UNIT_TOOLTIP_CTRL            = 'Control';
CHHT_GUI_UNIT_TOOLTIP_ALT             = 'Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL       = 'Shift-Ctrl';
CHHT_GUI_UNIT_TOOLTIP_SHIFTALT        = 'Shift-Alt';
CHHT_GUI_UNIT_TOOLTIP_CTRLALT         = 'Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT    = 'Shift-Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN   = 'ClickHeal Frames';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW    = 'Standard WoW';
CHHT_GUI_ACTION_TOOLTIP_ALWAYS        = '항상';
CHHT_GUI_ACTION_TOOLTIP_NEVER         = '사용 안함';
CHHT_GUI_TOOLTIP_UNIT_TOOLTIP_SCALE   = 'Scale of the unit tooltip (%d%%)';
CHHT_GUI_TOOLTIP_ACTIONS_TOOLTIP_SCALE= 'Scale of the actions tooltip (%d%%)';
CHHT_GUI_TOOLTIP_HINT_TOOLTIP_SCALE   = 'Scale of the hints tooltip (%d%%)';
CHHT_GUI_ANCHORS                      = 'Anchors';
CHHT_GUI_ANCHORS_ANCHOR_NAME          = 'Anchor';
CHHT_GUI_ANCHORS_RELATIVE_TO          = 'Anchor To';
CHHT_GUI_ANCHORS_RELATIVE_POINT       = 'Direction';
CHHT_GUI_ANCHORS_OFFSET_X             = 'X-Offset';
CHHT_GUI_ANCHORS_OFFSET_Y             = 'Y-Offset';
CHHT_GUI_ANCHORS_GROW                 = "Grow";
CHHT_GUI_ANCHORS_SHOW_MENU            = "Menu";
CHHT_GUI_ANCHORS_VISIBILITY           = 'Visibility';
CHHT_GUI_ANCHORS_VISIBILITY_SHOW      = 'Show';
CHHT_GUI_ANCHORS_VISIBILITY_AUTOHIDE  = 'Autohide';
CHHT_GUI_ANCHORS_VISIBILITY_COLLAPSE  = 'Collapse';
CHHT_GUI_ANCHORS_GROW_UP              = 'Up';
CHHT_GUI_ANCHORS_GROW_DOWN            = 'Down';
CHHT_GUI_ANCHOR_SHOW_DOCK_ANCHORS     = 'Show all anchors';
CHHT_GUI_ANCHOR_SHOW_ANCHORS          = "Movable anchors";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_TITLE  = "Magnetic Range (%d pixels)";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_LOW    = "none";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_HIGH   = "20 px";
CHHT_GUI_ANCHOR_MAGNETIC_TITLE_LOW    = "No Magnetism";

-- ---------- EXTENDED ---------------------------------------------------------------
CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE           = '표시안함';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT           = '좌';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP            = '상';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT          = '우';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM         = '하';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN           = '메인 창';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW            = 'Standard WoW';
CHHT_EXTENDED_RAID_GROUPS                        = '공격대 파티';
CHHT_EXTENDED_RAID_GROUP1                        = "공격대 1 파티";
CHHT_EXTENDED_RAID_GROUP2                        = "공격대 2 파티";
CHHT_EXTENDED_RAID_GROUP3                        = "공격대 3 파티";
CHHT_EXTENDED_RAID_GROUP4                        = "공격대 4 파티";
CHHT_EXTENDED_RAID_GROUP5                        = "공격대 5 파티";
CHHT_EXTENDED_RAID_GROUP6                        = "공격대 6 파티";
CHHT_EXTENDED_RAID_GROUP7                        = "공격대 7 파티";
CHHT_EXTENDED_RAID_GROUP8                        = "공격대 8 파티";
CHHT_EXTENDED_RAID_CLASSES                       = 'Raid Classes';
CHHT_EXTENDED_RAID_PETS                          = "공격대원 소환수";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL            = "매 %d 초마다 새로운 공격대원 소환수 확인";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL_MAX        = "초 (%s)";
CHHT_EXTENDED_RAID_GROUP_FRAME_WIDTH             = 'Raid Group Frame Width (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_HEIGHT            = 'Raid Group Frame Heigth (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_WIDTH             = 'Raid Class Frame Width (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_HEIGHT            = 'Raid Class Frame Heigth (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_SCALE             = 'Raid Group Frame Scale (%d%%)';
CHHT_EXTENDED_RAID_CLASS_FRAME_SCALE             = 'Raid Class Frame Scale (%d%%)';
CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE               = 'Hide Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW               = 'Show Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_WOW                = 'Use WoW setting';
CHHT_EXTENDED_RAID_HIDE_PARTY_IN_RAID            = 'Hide party in raid';
CHHT_EXTENDED_RAID_TOOLTIP_ORIENTATION           = "공격대원 툴팁 기본";
CHHT_EXTENDED_RAID                               = '공격대';
CHHT_EXTENDED_MAINTANK                           = 'Tank/Assist';
CHHT_EXTENDED_MT1_LABEL                          = 'Tank #1';
CHHT_EXTENDED_MT2_LABEL                          = 'Tank #2';
CHHT_EXTENDED_MT3_LABEL                          = 'Tank #3';
CHHT_EXTENDED_MT4_LABEL                          = 'Tank #4';
CHHT_EXTENDED_MT5_LABEL                          = 'Tank #5';
CHHT_EXTENDED_MT6_LABEL                          = 'Tank #6';
CHHT_EXTENDED_MT7_LABEL                          = 'Tank #7';
CHHT_EXTENDED_MT8_LABEL                          = 'Tank #8';
CHHT_EXTENDED_MT9_LABEL                          = 'Tank #9';
CHHT_EXTENDED_MT10_LABEL                         = 'Tank #10';
CHHT_EXTENDED_MT_CTRA_MT                         = 'CTRA MT';
CHHT_EXTENDED_MT_CTRA_MT_FORMAT                  = 'CTRA MT #%d';
CHHT_EXTENDED_MT_CTRA_PT                         = 'CTRA PT';
CHHT_EXTENDED_MT_CTRA_PT_FORMAT                  = 'CTRA PT #%d';
CHHT_EXTENDED_MT_TOOLTIP_ORIENTATION             = 'Tooltip orientation';
CHHT_EXTENDED_MT_FRAME_WIDTH                     = 'MainTank Frame Width (%d)';
CHHT_EXTENDED_MT_FRAME_HEIGHT                    = 'MainTank Frame Height (%d)';
CHHT_EXTENDED_MT_FRAME_SCALE                     = 'MainTank Frame Scale (%d%%)';
CHHT_EXTENDED_NEEDY_LIST_ENABLED                 = "Needy List Enabled";
CHHT_EXTENDED_NEEDY_LIST_HIDE_IN_BATTLEFIELD     = "Hide in BG";
CHHT_EXTENDED_NEEDY_LIST_TOOLTIP_ORIENTATION     = "Tooltip orientation";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL           = "Scan for new needers every %3.1f seconds";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL_CONT      = "Continously scan for new needers";
CHHT_EXTENDED_NEEDY_LIST_MAX_UNITS               = "Maximum number of units to display (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_WIDTH             = "Frame Width (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_HEIGHT            = "Frame Height (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_SCALE             = "Frame Scale (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_UNITS_LABEL             = "Units";
CHHT_EXTENDED_NEEDY_LIST_CLASSES_LABEL           = "Classes";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_ALWAYS          = "Always";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTY           = "Party";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_RAID            = "Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTYRAID       = "Party & Raid";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_NEVER           = "Never";
CHHT_EXTENDED_NEEDY_LIST_SORT                    = 'Sorting';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR                = 'Hide OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_NONE           = 'Do not hide';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_POSSIBLE       = 'Possibly OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_VERIFIED       = 'Only Verified';
CHHT_EXTENDED_NEEDY_LIST_HEAL                    = "Needy List Heal"
CHHT_EXTENDED_NEEDY_LIST_HEAL_HEALTH_PERCENTAGE  = "Health percentage for unit to show up (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_HEAL_LOCK_TANKS         = "Lock and show tanks";
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGENCY     = 'Emergency';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGLOCKED   = 'Emergency, locked';
CHHT_EXTENDED_NEEDY_LIST_CURE                    = "Needy List Cure"
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_CURSE         = "Show Curse";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_DISEASE       = "Show Disease";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_POISON        = "Show Poison";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_MAGIC         = "Show Magic";
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_BUFF                    = "Needy List Buff"
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_NEEDY_LIST_DEAD                    = "Needy List Dead"
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_UNSORTED      = 'Not sorted';
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_LOCKED        = 'Locked units';
CHHT_EXTENDED_PAGE1                              = "Raid";
CHHT_EXTENDED_PAGE2                              = "Tank/Assist";
CHHT_EXTENDED_PAGE3                              = "NL Heal";
CHHT_EXTENDED_PAGE4                              = "NL Cure";
CHHT_EXTENDED_PAGE5                              = "NL Buff";
CHHT_EXTENDED_PAGE6                              = "NL Dead";

-- ---------- FRIEND -----------------------------------------------------------------
CHHT_FRIEND_OPTIONS                = '아군 설정';
CHHT_FRIEND_HITPOINT_LABEL         = "파티/공격대원의 생명력 표시 방법";
CHHT_FRIEND_FRAME_BACKGROUND       = "Background of Avatar and party/raid member frames";
CHHT_FRIEND_FRAME_BACKGROUND_ALPHA = 'Opacity (%3.2f)';
CHHT_FRIEND_PICK_COLOR             = 'Pick Color';
CHHT_FRIEND_RESURRECT              = "사망자 부활 방법";
CHHT_FRIEND_ADJUST_SPELLRANK       = "대상의 레벨에 맞는 주문 사용";
CHHT_FRIEND_SHOW_MANA              = "마나 표시";
CHHT_FRIEND_SHOW_RAGE              = "분노 표시";
CHHT_FRIEND_SHOW_ENERGY            = "기력 표시";
CHHT_FRIEND_SHOW_FOCUS             = "집중 표시(소환수)";
CHHT_FRIEND_SHADOWFORM             = "어둠의 형상/늑대 정령 토글/Stealth";
CHHT_FRIEND_CAST_ON_CHARMED        = "Cast offensive spells on charmed friend";
CHHT_FRIEND_MOUSE_TITLE            = '아군 행동';
CHHT_FRIEND_PAGE1                  = "설정";
CHHT_FRIEND_PAGE2                  = "마우스 1/3";
CHHT_FRIEND_PAGE3                  = "마우스 2/3";
CHHT_FRIEND_PAGE4                  = "마우스 3/3";
CHHT_FRIEND_HP_LABEL_PERCENT       ='백분률';
CHHT_FRIEND_HP_LABEL_PERCENT_SIGN  ='백분률(%표시)';
CHHT_FRIEND_HP_LABEL_CURRENT       ='현재 생명력';
CHHT_FRIEND_HP_LABEL_MISSING       ='결손치';
CHHT_FRIEND_HP_LABEL_NONE          = 'do not label';
CHHT_FRIEND_FRAME_BACKGROUND_HEALTH= '생명력 색상';
CHHT_FRIEND_FRAME_BACKGROUND_CLASS = 'Class color';
CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM= 'Custom';
CHHT_FRIEND_PARTY_LABEL_CLASS      = '직업';
CHHT_FRIEND_PARTY_LABEL_NAME       = '이름';
CHHT_FRIEND_PARTY_LABEL_BOTH       = '직업-이름';
CHHT_FRIEND_PARTY_LABEL_COLOR      = '직업 색상 이름';
CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR  = 'Class-Name Color';
CHHT_FRIEND_FRIEND_DEBUFF_NONE     = '없음';
CHHT_FRIEND_FRIEND_DEBUFF_CURABLE  = '치료가능한것';
CHHT_FRIEND_FRIEND_DEBUFF_ALL      = '모두';
CHHT_FRIEND_RESURRECT_AFTER_COMBAT ='전투 종료후';
CHHT_FRIEND_RESURRECT_ALWAYS       ='항상';
CHHT_FRIEND_RESURRECT_NEVER        ='사용 안함';
CHHT_FRIEND_POWER_WORD_SHIELD      = '신의 권능: 보호막이 활성화되어 있을 경우 사용 안함';
CHHT_FRIEND_RENEW                  = '소생이 활성화 되어 있을 경우 사용 안함';
CHHT_FRIEND_REGROWTH               = '재생이 활성화 되어 있을 경우 사용 안함';
CHHT_FRIEND_REJUVENATION           = '회복이 활성화 되어 있을 경우 사용 안함';
CHHT_FRIEND_SWIFTMEND              = 'Do not cast Swiftmend when already active';

CHHT_FRIEND_CHECK_HEAL_RANGE                              = 'Check heal range';
CHHT_FRIEND_CHECK_HEAL_RANGE_MODE                         = 'Mode';
CHHT_FRIEND_CHECK_HEAL_RANGE_NEVER                        = 'Do not check';
CHHT_FRIEND_CHECK_HEAL_RANGE_FOLLOW                       = 'Approximation ~28 yards';
CHHT_FRIEND_CHECK_HEAL_RANGE_ONHWEVENT                    = 'Scan on every hardware event';
CHHT_FRIEND_CHECK_HEAL_RANGE_BOUNDARY_FORMAT              = '%3.1f sec';
CHHT_FRIEND_CHECK_HEAL_RANGE_KEEP_DURATION                = 'Keep duration (%3.1f sec)';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_OOR            = 'Show OOR at hp';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_HP             = 'Color hitpoints';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_BACKGROUND     = 'Custom background';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_NONE           = 'Do not show';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE       = 'Possible OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED       = 'Verified OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE_COLOR = 'Color Possible';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED_COLOR = 'Color Verified';

-- ---------- TARGET/ENEMY -----------------------------------------------------------
CHHT_TARGET_TARGETING          = "Target acquisition mode";
CHHT_TARGET_PLAYER_TARGET      = "플레이어 대상";
CHHT_TARGET_PARTY1_TARGET      = "1번 파티원 대상";
CHHT_TARGET_PARTY2_TARGET      = "2번 파티원 대상";
CHHT_TARGET_PARTY3_TARGET      = "3번 파티원 대상";
CHHT_TARGET_PARTY4_TARGET      = "4번 파티원 대상";
CHHT_TARGET_PET_TARGET         = "소환수 대상";
CHHT_TARGET_PARTYPET1_TARGET   = "1번 파티원 소환수 대상";
CHHT_TARGET_PARTYPET2_TARGET   = "2번 파티원 소환수 대상";
CHHT_TARGET_PARTYPET3_TARGET   = "3번 파티원 소환수 대상";
CHHT_TARGET_PARTYPET4_TARGET   = "4번 파티원 소환수 대상";
CHHT_TARGET_OPTIONS            = '대상 설정';
CHHT_TARGET_SHOW_LEVEL_DIFF    = "레벨 난이도 표시";
CHHT_TARGET_SHOW_MANA          = "마나 표시";
CHHT_TARGET_SHOW_RAGE          = "분노 표시";
CHHT_TARGET_SHOW_ENERGY        = "기력 표시";
CHHT_TARGET_SHOW_FOCUS         = "집중 표시(소환수)";
CHHT_TARGET_CAST_ON_CHARMED    = "Cast beneficial spells on charmed enemy";
CHHT_TARGET_MOUSE_TITLE        = '대상 행동';
CHHT_TARGET_COLORS             = '색상';
CHHT_TARGET_PAGE1              = "설정";
CHHT_TARGET_PAGE2              = "마우스 1/3";
CHHT_TARGET_PAGE3              = "마우스 2/3";
CHHT_TARGET_PAGE4              = "마우스 3/3";
CHHT_TARGET_GROUP_LABEL_FORMAT = "%d번 그룹";
CHHT_TARGET_TARGETING_KEEP     = 'Keep current target';
CHHT_TARGET_TARGETING_TARGET   = 'Target spell target';
CHHT_TARGET_TARGETING_INT      = 'Intelligent targeting';
CHHT_COLOR_GROUP_LABEL_FORMAT  = 'Color Group %s';

-- ---------- PANIC ------------------------------------------------------------------
CHHT_PANIC_OPTIONS                     = '응급상황 설정';
CHHT_PANIC_NO_BATTLEFIELD              = 'Outside Battlefield';
CHHT_PANIC_IN_BATTLEFIELD              = 'In Battlefield';
CHHT_PANIC_CURE_UNITS                  = "응급 상황에서 디버프 치료'";
CHHT_PANIC_UNMAPPED                    = "정의되지 않은 버튼 클릭시 응급 상황으로 대처";
CHHT_PANIC_CHECK_RANGE                 = "Do range checks";
CHHT_PANIC_SPELL_DOWNGRADE             = "Enable overheal minimization";
CHHT_PANIC_COMBAT_HEALING_IN_BATTLEFIELD="Always use combat healing";
CHHT_PANIC_MOUSE_TITLE                 = '응급 행동';
CHHT_PANIC_BEHAVIOR                    = 'Panic Behavior';
CHHT_PANIC_BEHAVIOR_LABEL              = "Panic behavior template";
CHHT_PANIC_BEHAVIOR_SPELL_TITLE_FORMAT = "Spell %d";
CHHT_PANIC_BEHAVIOR_FORCE_CAST         = "force cast";
CHHT_PANIC_BEHAVIOR_CLASSES            = 'Classes';
CHHT_PANIC_BEHAVIOR_EMERGENCY_LEVELS   = 'Emergency Levels';
CHHT_PANIC_BEHAVIOR_SPELL_EDIT         = 'Spell Configuration';
CHHT_PANIC_PAGE1                       = "설정";
CHHT_PANIC_PAGE2                       = "Behavior";
CHHT_PANIC_PAGE3                       = "마우스 1/3";
CHHT_PANIC_PAGE4                       = "마우스 2/3";
CHHT_PANIC_PAGE5                       = "마우스 3/3";
CHHT_PANIC_TITLE_HEAL                  = '응급치료: Heal';
CHHT_PANIC_TITLE_BUFF                  = '응급치료: Buff';
CHHT_PANIC_TITLE_FULL                  = 'Full spell range';
CHHT_PANIC_TITLE_TRASH                 = 'Trash healing';
CHHT_PANIC_TITLE_BATTLEFIELD           = 'Battlefield';
CHHT_PANIC_TITLE_CUSTOM1               = 'Custom 1';
CHHT_PANIC_TITLE_CUSTOM2               = 'Custom 2';
CHHT_PANIC_TITLE_CUSTOM3               = 'Custom 3';

-- ---------- EXTRA ------------------------------------------------------------------
CHHT_EXTRA_LABEL         = "제목";
CHHT_EXTRA_SHOW_COOLDOWN = "재사용 대기시간 표시";
CHHT_EXTRA_OPTIONS       = '확장 버튼 설정';
CHHT_EXTRA_HIDE_BUTTON   = "버튼 숨기기";
CHHT_EXTRA_PAGE1         = "설정";
CHHT_EXTRA_PAGE2         = "마우스 1/3";
CHHT_EXTRA_PAGE3         = "마우스 2/3";
CHHT_EXTRA_PAGE4         = "마우스 3/3";
CHHT_EXTRA_LABEL_FORMAT  = '%d번 확장 버튼';
CHHT_EXTRA_TITLE_FORMAT  = '%d번 확장 버튼';

-- ---------- CHAINS -----------------------------------------------------------------
CHHT_CHAINS_BUTTON_ASSIGNMENT = '버튼 정의';
CHHT_CHAINS_CHAIN1            = "1번 연쇄 행동";
CHHT_CHAINS_CHAIN2            = "2번 연쇄 행동";
CHHT_CHAINS_CHAIN3            = "3번 연쇄 행동";
CHHT_CHAINS_CHAIN4            = "4번 연쇄 행동";
CHHT_CHAINS_NAME_FORMAT       = "%d번 연쇄 행동";
CHHT_CHAINS_TITLE_FORMAT      = '%d번 연쇄 행동 설정';

-- ---------- BUFFS ------------------------------------------------------------------
CHHT_BUFF_TITLE              = '버프 설정';
CHHT_BUFF_EXPIRE_PLAY_SOUND  = "버프 상실시 소리 재생";
CHHT_BUFF_EXPIRE_SHOW_MSG    = "버프 상실시 메세지 표시";
CHHT_BUFF_WARN_PLAY_SOUND    = "버프 상실시 소리 재생";
CHHT_BUFF_WARN_SHOW_MSG      = "버프 상실시 경고 표시";
CHHT_BUFF_SHOW_TRACKING_BUFF = "추적 기술 상실시 표시 (약초 찾기, 광물 찾기, 인간형 추적 등 ...)";
CHHT_BUFF_SHOW_RAID_EFFECTS  = "공격대원 효과 표시 (버프 상실, 디버프 활성화)";
CHHT_BUFF_COMBINE_IN_PANIC   = "Combine missing buffs in PANIC frame";
CHHT_BUFF_AVAILABLE_BUFFS    = '사용가능한 버프';
CHHT_BUFF_ALLOWED_CLASSES    = '시전할 직업';
CHHT_BUFF_ALLOWED_UNITS      = '시전할 대상';
CHHT_BUFF_BUFF_DATA          = '버프 경고/갱신';
CHHT_BUFF_UPGRADE_Q          = "최소 (n)명의 #PARTYSPELLSPEC#원이 버프가 필요할 때 #PARTYSPELLNAME# 시전";
CHHT_BUFF_UPGRADE_MSG        = "Upgrade unit spell";
CHHT_BUFF_IN_BATTLEFIELD     = "Cast in Battlefield";
CHHT_BUFF_PAGE1              = "설정";
CHHT_BUFF_PAGE2              = "버프 목록";
CHHT_BUFFS_NEVER_WARN        = "경고안함";
CHHT_BUFFS_ALWAYS_WARN       = "항상경고";
CHHT_BUFFS_WARN_EXPIRE_TITLE = "사라지기 %s 전에 경고";
CHHT_BUFFS_NEVER_REFRESH     = "갱신안함";
CHHT_BUFFS_ALWAYS_REFRESH    = "항상갱신";
CHHT_BUFFS_REFRESH_TITLE     = "사라지기 %s 전에 갱신";

-- ---------- TOTEMSET ---------------------------------------------------------------
CHHT_TOTEMSET_LABEL_FORMAT            = "%d번 토템 세트";
CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT = "지속 시간 (%s)";
CHHT_TOTEMSET_SLIDER_TITLE_FORMAT     = '%d 초';

-- krKR
end
