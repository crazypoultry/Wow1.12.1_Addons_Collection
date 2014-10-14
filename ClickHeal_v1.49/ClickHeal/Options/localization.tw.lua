if ( GetLocale() == "zhTW" ) then

-- ---------- GLOBALS ----------------------------------------------------------------
CHHT_LABEL_CLOSE       = "關閉";
CHHT_LABEL_DEFAULT     = "預設";
CHHT_LABEL_DEFAULTS    = "預設";
CHHT_LABEL_CONFIGURE   = "設置";

CHHT_LABEL_NONE        = '無';

CHHT_LABEL_MOUSE_1_3   = "游標 1/3";
CHHT_LABEL_MOUSE_2_3   = "游標 2/3";
CHHT_LABEL_MOUSE_3_3   = "游標 3/3";

CHHT_LABEL_PLAYER      = '玩家';
CHHT_LABEL_PET         = '寵物';
CHHT_LABEL_PARTY       = '隊友';
CHHT_LABEL_PARTYPET    = '隊友寵物';
CHHT_LABEL_RAID        = '團隊';
CHHT_LABEL_RAIDPET     = '團隊寵物';
CHHT_LABEL_TARGET      = '目標';
CHHT_LABEL_PARTY1      = '隊友 1';
CHHT_LABEL_PARTY2      = '隊友 2';
CHHT_LABEL_PARTY3      = '隊友 3';
CHHT_LABEL_PARTY4      = '隊友 4';
CHHT_LABEL_PARTYPET1   = '隊友寵物 1';
CHHT_LABEL_PARTYPET2   = '隊友寵物 2';
CHHT_LABEL_PARTYPET3   = '隊友寵物 3';
CHHT_LABEL_PARTYPET4   = '隊友寵物 4';

CHHT_LABEL_PLAYER_LC   = '玩家';
CHHT_LABEL_PET_LC      = '寵物';
CHHT_LABEL_PARTY_LC    = '隊友';
CHHT_LABEL_PARTYPET_LC = '隊友寵物';
CHHT_LABEL_RAID_LC     = '團隊';
CHHT_LABEL_RAIDPET_LC  = '團隊寵物';
CHHT_LABEL_TARGET_LC   = '目標';
CHHT_LABEL_PARTY1_LC   = '隊友 1';
CHHT_LABEL_PARTY2_LC   = '隊友 2';
CHHT_LABEL_PARTY3_LC   = '隊友 3';
CHHT_LABEL_PARTY4_LC   = '隊友 4';
CHHT_LABEL_PARTYPET1_LC= '隊友寵物 1';
CHHT_LABEL_PARTYPET2_LC= '隊友寵物 2';
CHHT_LABEL_PARTYPET3_LC= '隊友寵物 3';
CHHT_LABEL_PARTYPET4_LC= '隊友寵物 4';

CHHT_LABEL_RAID_GROUP_FORMAT = 'Raid Group %d';

CHHT_LABEL_MAX         = "最大";
CHHT_LABEL_MIN         = "最小";
CHHT_LABEL_ALWAYS      = "總是";
CHHT_LABEL_NEVER       = "從不";
CHHT_LABEL_CONTINOUSLY = "連續";

CHHT_LABEL_UP          = "上";
CHHT_LABEL_DOWN        = "下";
CHHT_LABEL_DN          = "Dn";

CHHT_LABEL_LEFT        = '左';
CHHT_LABEL_RIGHT       = '右';
CHHT_LABEL_TOP         = '頂部';
CHHT_LABEL_BOTTOM      = '底部';
CHHT_LABEL_TOPLEFT     = '頂部左側';
CHHT_LABEL_TOPRIGHT    = '頂部右測';
CHHT_LABEL_BOTTOMLEFT  = '底部左側';
CHHT_LABEL_BOTTOMRIGHT = '底部右側';

CHHT_LABEL_HIGHEST     = '最高';
CHHT_LABEL_MEMBERS     = '成員';

CHHT_NUMBER_ONE        = '一';
CHHT_NUMBER_TWO        = '二';
CHHT_NUMBER_THREE      = '三';
CHHT_NUMBER_FOUR       = '四';
CHHT_NUMBER_FIVE       = '五';

CHHT_LABEL_UPDATE      = 'Update';

-- ---------- TABs -------------------------------------------------------------------
CHHT_TAB_HELP      = "幫助";
CHHT_TAB_CONFIG    = "設置";
CHHT_TAB_GUI       = "界面";
CHHT_TAB_EXTENDED  = "NL設置";
CHHT_TAB_FRIEND    = "友方";
CHHT_TAB_ENEMY     = "敵對";
CHHT_TAB_PANIC     = "Panic";
CHHT_TAB_EXTRA     = "擴展";
CHHT_TAB_CHAINS    = "鏈";
CHHT_TAB_BUFFS     = "增益魔法";
CHHT_TAB_TOTEMS    = "圖騰";

-- ---------- HELP / FAQ -------------------------------------------------------------
CHHT_HELP_TRACKING_BUFF = "(缺少追蹤buff,查找草藥,查找礦物,追蹤野獸, ..)";
CHHT_HELP_TITLE         = '幫助 / FAQ';
CHHT_HELP_MSG           = "ClickHeal 幫助";
CHHT_HELP_PAGE1         = "幫助";
CHHT_HELP_PAGE2         = "縮寫";
CHHT_HELP_PAGE3         = "FAQs";
CHHT_HELP_PAGE4         = "Credits";

CHHT_HELP_HELP =
  '|c00FFFF00前言|r\n'
..'ClickHeal enables you to cast a spell on a unit/player with only one mouse click, without previously targeting the unit and then casting the spell. '
..'By history, ClickHeal was geared towards healers. Although this is still the strongest point of ClickHeal, it is also extremely useful for other '
..'casters.\n\n'
..'|c00FFFF00法術分配|r\n'
..'The power of ClickHeal is the ease of assigning spells to your mouse buttons. You can map all your buttons (left,middle,right) and for five button '
..'mice also the button4 and button5. In addition you can map modification keys, like SHIFT-left mouse button.\n'
..'Spells and mouse buttons will be assigned to groups, like enemies, friends and the so called Extra buttons. Dependant on what unit/frame you then click, '
..'the mapped spell will be cast. This is, that for example you left click a friendly unit, you will cast a heal spell but when left clicking an enemy '
..'unit, a damage spell will be cast.\n'
..'Spells can be assigned with this config screen. Just select on the bottom one of the tabs you would like to assign spells for. In the new section you '
..'can then define global options for this section and map the spells to mouse buttons.\n\n'
..'|c00FFFF00這有更多有關|r\n'
..'ClickHeal not only allows you to map spells, you can also map certain actions, like attack, have your pet attack, drink potions, and more. '
..'ClickHeal also finetunes your spells, checks overhealing and many more.\n\n'
..'|c00FFFF00The ClickHeal 視窗|r\n'
..'By default the ClickHeal frames are located on the left side, but can be moved around with the the thin dark bar on the top. '
..'The four buttons on the top are the so called Extra buttons, where you can map gobal spells and actions to.\n'
..'Right below them, the big blue button, is the panic button. Here your mana is displayed, together with alerts of missing buffs or active debuffs. '
..'When clicking this special PANIC action will become active. At this point, ClickHeal will decide what is needed most at that moment and either heals, '
..'cures or buffs your party and raid members.\n'
..'Following below the PANIC button is a button for your Avatar, followed by the button of your party members. At the very bottom follow the frames '
..'for your pet and the pets of your party members. Next to these buttons the respective targets are displayed. Same colors of the name of the targets '
..'indicate that these party members target the same target.\n\n'
..'|c00FFFF00Detailed help|r\n'
..'A detailed help describing ClickHeal in general and giving help to all the configurations can be found at '
..'|c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r '
..'Please check out this page for detailed information.';

CHHT_HELP_TEXT_DEBUFFS = 
  '|c00FFFF00Debuffs (red):\n'
..'|c00FF0000M|c00FFFFFF (魔法)\n'
..'|c00FF0000C|c00FFFFFF (詛咒)\n'
..'|c00FF0000D|c00FFFFFF (疾病)\n'
..'|c00FF0000P|c00FFFFFF (中毒)\n'
..'|c00FF8800B|c00FFFFFF (新近包紮)\n'
..'|c00FF8800P|c00FFFFFF (相位變換 小鬼)\n\n';

CHHT_HELP_TEXT_HOT = 
  '|c00FFFF00Heal over Time (HOT) (green)\n'
..'|c0000FF00J|c00FFFFFF (回春術)\n'
..'|c0000FF00G|c00FFFFFF (癒合)\n'
..'|c0000FF00N|c00FFFFFF (恢復)\n\n';

CHHT_HELP_TEXT_SHIELD = 
  '|c00FFFF00盾\n'
..'|c0000FF00S|c00FFFFFF (真言術: 盾)\n'
..'|c00FF8800S|c00FFFFFF (虛弱靈魂)\n\n';

CHHT_HELP_TEXT_BUFFS =
  '|c00FFFF00Missing Buffs (yellow):\n'
..'|c00FFFF00B|r (任何buff, 只有在PANIC視窗)\n';

CHHT_HELP_TEXT_FINETUNE =
  '|c00FFFF00Spell Finetuning:|c00FFFFFF\n'
..'|c0000CCFF真言術：盾|c00FFFFFF -> 恢復 -> 快速治療 \n'
..'|c0000CCFF恢復|c00FFFFFF ->快速治療 \n'
..'|c0000CCFF回春術|c00FFFFFF -> 癒合 -> 治療之觸 \n'
..'|c0000CCFF癒合|c00FFFFFF -> 回春術 -> 癒合 (是的, 又回到癒合)\n\n'
;

CHHT_HELP_TEXT_UPPER_LOWER =
  '|c00FFFF00HOT and Buff effects which are in lower case are about to expire.|r\n';

CHHT_HELP_FAQ =
  '|c00FFFF00Where can I find detailed help?|r\n'
..'Please consult |c0000CCFFhttp://www.xs4all.nl/~rmetzger/ClickHeal|r for full documentation.\n\n'
..'|c00FFFF00I read the help but still have questions. Where can I ask them?|r\n'
..'I am frequently consulting the pages of |c0000CCFFui.worldofwar.net|r and |c0000CCFFwww.curse-gaming.com|r. Search there for ClickHeal and check the '
..'message board for the AddOn. Alot of questions are already answered there. But if you are still not satified, please feel free to place your questions '
..'there.\n\n'
..'|c00FFFF00I have found a bug, want to request a feature or want to give feedback. Where can I do this?|r\n'
..'Please post it at |c0000CCFFui.worldofwar.net|r and |c0000CCFFwww.curse-gaming.com|r, in the ClickHeal section. I am extremely interested '
..'in your feedback and bugreports.';

CHHT_HELP_CREDITS =
  '|c00FFFF00關於|r\n'
..'ClickHeal is developed by rmet0815. It is licenced under the GPL (Gnu Public Licence), which generally implies that everyone may use it '
..'without restriction. GPL is sticky however, meaning that if you make modifications to the AddOn or use parts of it in your own '
..'applications, these have to be licenced under GPL again.\n\n'
..'|c00FFFF00協力成員|r\n'
..'French localization by: Genre, Mainsacr\195\169\n'
..'Korean localization by: Damjau\n'
..'German localization by: Rastibor\n'
..'Simp Chinese localization by: Space Dragon\n'
..'|c0000CCFFTrad Chinese localization by: 尖石 Bell|r\n\n'
..'感謝各位使用 ClickHeal, 沒有你們的意見以及bug回報, '
..'ClickHeal 將沒有今天的成就!';

-- ---------- COMMON / CH_HELP -------------------------------------------------------
CHHT_PET_ATTACK_NONE         = '無';
CHHT_PET_ATTACK_HUNTERS_MARK = CH_SPELL_HUNTERS_MARK;

CHHT_UNITBUFF_AUTOMATIC      = '自動';
CHHT_UNITBUFF_POPUP          = '彈出';

CHHT_GROUPBUFF_REFRESH_TIME  = '更新時間';
CHHT_GROUPBUFF_WARN_TIME     = '提醒時間';

-- ---------- MISC -------------------------------------------------------------------
CHHT_MISC_OPTIONS                       = '其他選項';
CHHT_MISC_ADDONS                        = '插件';
CHHT_MISC_CTRA                          = "CT Raid Assist (CTRA)";
CHHT_MISC_DUF                           = "Discord Unit Frames (DUF)";
CHHT_MISC_BONUSSCANNER                  = "BonusScanner";
CHHT_MISC_PCUF                          = "Perl Classic Unit Frames (PCUF)";
CHHT_MISC_ORA                           = "oRA";
CHHT_MISC_WOWGUI                        = "預設 WoW 界面";
CHHT_MISC_DECURSIVE                     = "Decursive";
CHHT_MISC_NEEDYLIST                     = "Ralek's Needy List";
CHHT_MISC_ADDON_INFO                    = "Note that not all addons which make use of ClickHeal are listed here. "..
                                          "Check out the ClickHeal webpage for a list of supported and supporting addons.";
CHHT_CAST_SPELL_BY_NAME_ON_SELF         = "使用wow預設的自我施法機制";
CHHT_MISC_DEBUG_LEVEL                   = "Debug Messages";
CHHT_MISC_RESETALL_Q                    = "選擇這個然後按右邊的按鍵將重設所有click heal 的設置";
CHHT_MISC_RESETALL                      = "全部重置";
CHHT_MISC_PLUGINS                       = '插件';
CHHT_CONFIG_PLUGIN_INFO_MSG             = '插件可以在登入時的角色選單中的左下插件選項中取消';
CHHT_MISC_COMBAT                        = "戰鬥";
CHHT_MISC_COMBAT_SAFE_TAUNT             = "安全嘲諷";
CHHT_MISC_COMBAT_SD                     = '自衛';
CHHT_MISC_COMBAT_SD_ATTACK              = "如果被攻擊，自動攻擊目標";
CHHT_MISC_COMBAT_SD_PET                 = "如果被攻擊，自動使用寵物攻擊目標";
CHHT_MISC_COMBAT_SD_HIT                 = "只考慮你自己被攻擊的情況";
CHHT_MISC_COMBAT_SD_MES                 = "不攻擊被控制的（變羊，束縛亡靈...）目標";
CHHT_MISC_COMBAT_SD_SWITCH              = '在隊伍/團隊中不啟用';
CHHT_MISC_CDW                           = '冷卻監視';
CHHT_MISC_CDW_EXTRA1                    = '擴展按鈕1';
CHHT_MISC_CDW_EXTRA2                    = '擴展按鈕2';
CHHT_MISC_CDW_EXTRA3                    = '擴展按鈕3';
CHHT_MISC_CDW_EXTRA4                    = '擴展按鈕4';
CHHT_MISC_CDW_SPELLS                    = '法術';
CHHT_MISC_CDW_BAG                       = "顯示背包中物品的冷卻時間";
CHHT_MISC_OVERHEAL                      = '治療';
CHHT_MISC_OVERHEAL_COMBAT               = "在戰鬥中，施法法術當玩家生命低於";
CHHT_MISC_OVERHEAL_NOCOMBAT             = "在非戰鬥狀態下使用最有效的法術";
CHHT_MISC_OVERHEAL_DOWNSCALE            = "戰鬥中降低施法等級以防止過補";
CHHT_MISC_OVERHEAL_LOM_DOWNSCALE        = "戰鬥中如果法力過低，降低施法到可使用的上限等級";
CHHT_MISC_OVERHEAL_BASE                 = "根據須治療的百分比施法";
CHHT_MISC_OVERHEAL_HOT                  = "考慮HOT治療的百分比";
CHHT_MISC_OVERHEAL_QUICK                = '快';
CHHT_MISC_OVERHEAL_SLOW                 = '慢';
CHHT_MISC_OVERHEAL_DPSCHECK             = '考慮多長時間內玩家被攻擊的dps';
CHHT_MISC_OVERHEAL_CLICK_ABORT_PERC     = '當施法進行中的目標生命值百分比到達 x，再點一次目標即中斷施法';
CHHT_MISC_OVERHEAL_MODIFY_TOTAL_PERC    = 'Percentage to modify total healing result with';
CHHT_MISC_OVERHEAL_OVERHEAL_ALLOWANCE   = '可被允許的每一等級溢補量';
CHHT_MISC_OVERHEAL_LOM_NONE             = '從不';
CHHT_MISC_OVERHEAL_LOM_MAX              = '最大';
CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT     = '%d spell ranks';
CHHT_MISC_OVERHEAL_GEAR                 = '考慮玩家的裝備治療量';
CHHT_MISC_OVERHEAL_FORMULA_QUICK        = "治療準則 快:";
CHHT_MISC_OVERHEAL_FORMULA_SLOW         = "治療準則 慢:";
CHHT_MISC_NOTIFY_HIT                    = '我被攻擊了';
CHHT_MISC_NOTIFY_HIT_SOUND              = "播放聲音";
CHHT_MISC_NOTIFY_HIT_SOUND_REPEAT       = "在...秒內不要重複播放";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PARTY     = "隊伍宣告";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PLAY_EMOTE= "表情宣告";
CHHT_MISC_NOTIFY_HIT_HITPOINTS          = "只有當生命少於...才提醒";
CHHT_MISC_NOTIFY_HIT_HITPOINT_SLIDER_TITLE = "生命 (%d%%)";
CHHT_MISC_NOTIFY_HIT_HITPOINTS_FADE     = "當「漸隱」被啟動(或冷卻中), 僅當生命低於...時提醒 (僅限牧師)";
CHHT_MISC_NOTIFY_HIT_REPEAT             = "多少秒內不要重複提醒";
CHHT_MISC_NOTIFY_HIT_MSG                = "顯示的消息";
CHHT_MISC_NOTIFY_OOM                    = '法力不足';
CHHT_MISC_NOTIFY_OOM_PARTY              = "在隊伍中提醒";
CHHT_MISC_NOTIFY_OOM_RAID               = "在團隊中提醒";
CHHT_MISC_NOTIFY_OOM_CUSTOM_CHANNEL     = "在自訂頻道中提醒";
CHHT_MISC_NOTIFY_OOM_PLAY_EMOTE         = "用表情符號提醒";
CHHT_MISC_NOTIFY_OOM_MANA               = "提醒如果法力低於 at";
CHHT_MISC_NOTIFY_OOM_SLIDER_TITLE       = '法力 (%d%%)';
CHHT_MISC_NOTIFY_OOM_REPEAT             = "多少秒內不要重複提醒";
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL         = "自訂頻道"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_NAME    = "頻道名稱"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_PASSWORD= "頻道密碼"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_CHAT_BOX= "Chat Box";
CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL="預設視窗";
CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT="聊天視窗 %d";
CHHT_MISC_NOTIFY_SPELLCAST              = '法術施放宣告';
CHHT_MISC_NOTIFY_SPELLCAST_SAY          = "說";
CHHT_MISC_NOTIFY_SPELLCAST_TELL         = "告訴某人";
CHHT_MISC_NOTIFY_SPELLCAST_PARTY        = "在隊伍中提醒";
CHHT_MISC_NOTIFY_SPELLCAST_RAID         = "在團隊聊天中提醒";
CHHT_MISC_NOTIFY_SPELLCAST_CUSTOM_CHANNEL="自訂頻道";
CHHT_MISC_PAGE1                         = "其他";
CHHT_MISC_PAGE2                         = "插件";
CHHT_MISC_PAGE3                         = "戰鬥";
CHHT_MISC_PAGE4                         = "冷卻";
CHHT_MISC_PAGE5                         = "治療";
CHHT_MISC_PAGE6                         = "提醒";
CHHT_MISC_PAGE7                         = "提醒 2";
CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT   = "生命百分比 (%s%%)";
CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT   = "治療潛力 (%s%%)";
CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT   = "HOT百分比 (%s%%)";
CHHT_MISC_HIT_AGO_TITLE_FORMAT          = "擊中 %s 秒以前";
CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT = "生命百分比 (%s%%)";
CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT="可允許溢補範圍百分比 (%s%%)";
CHHT_MISC_SECONDS_TITLE_FORMAT          = "秒 (%s)";
CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT      = "modify total by (%s%%)";

-- ---------- GUI --------------------------------------------------------------------
CHHT_GUI_PARTY_SORT                   = '隊伍排序';
CHHT_GUI_MISC                         = '其他';
CHHT_GUI_PARTY_MEMBER_LABEL           = "團隊成員標籤";
CHHT_GUI_SHOW_FRIEND_DEBUFFS          = "顯示友好目標的減益法術";
CHHT_GUI_TARGET_BACKGROUND_COLOR      = "生命目標背景色彩";
CHHT_GUI_SHOW_TARGET_DEBUFFS          = "顯示目標減益法術";
CHHT_GUI_FRAME_GROUP_MODE             = "框體分組模式";
CHHT_GUI_SHOW_CLICKHEAL_FRAMES        = "顯示 ClickHeal 框體";
CHHT_GUI_SHOW_PARTY_FRAMES            = "顯示隊伍框體";
CHHT_GUI_SHOW_PARTY_PETS_FRAMES       = "顯示隊友寵物";
CHHT_GUI_SHOW_WOW_PARTY_FRAMES        = "顯示 WoW 隊伍框體";
CHHT_GUI_SHOW_PLAYER_MANA             = "顯示玩家法力(在玩家框體中)";
CHHT_GUI_SHOW_PET_FOCUS               = "顯示寵物集中";
CHHT_GUI_SHOW_PARTYPET_TARGET         = "顯示隊友寵物目標";
CHHT_GUI_SHOW_MES                     = "顯示控制技能計時(變羊,...)";
CHHT_GUI_SHOW_FIVE_SEC_RULE           = '顯示 "5秒規則" 和法力恢復';
CHHT_GUI_SHOW_HINTS                   = "顯示 設置中的提示";
CHHT_GUI_UPDATE_SLIDER_TITLE          = '更新間隔 (%3.1f 秒)';
CHHT_GUI_RESET_FRAME_POS              = "重設框體位置";
CHHT_GUI_MAIN_FRAMES                  = '主框體';
CHHT_GUI_FRAME_ALIGNMENT              = "框體對齊";
CHHT_GUI_FRAME_EXTRA_WIDTH            = '擴展窗體寬度 (%d)';
CHHT_GUI_FRAME_PANIC_WIDTH            = 'PANIC窗體寬度 (%d)';
CHHT_GUI_FRAME_PLAYER_WIDTH           = '玩家窗體寬度 (%d)';
CHHT_GUI_FRAME_PARTY_WIDTH            = '隊友窗體寬度 (%d)';
CHHT_GUI_FRAME_PET_WIDTH              = '寵物窗體寬度 (%d)';
CHHT_GUI_FRAME_PARTYPET_WIDTH         = '隊友 Pet窗體寬度 (%d)';
CHHT_GUI_FRAME_EXTRA_HEIGHT           = '擴展窗體高度 (%d)';
CHHT_GUI_FRAME_PANIC_HEIGHT           = 'PANIC窗體高度 (%d)';
CHHT_GUI_FRAME_PLAYER_HEIGHT          = '玩家窗體高度 (%d)';
CHHT_GUI_FRAME_PARTY_HEIGHT           = '隊友窗體高度 (%d)';
CHHT_GUI_FRAME_PET_HEIGHT             = '寵物窗體高度 (%d)';
CHHT_GUI_FRAME_PARTYPET_HEIGHT        = '隊友 Pet窗體高度(%d)';
CHHT_GUI_FRAME_EXTRA_SCALE            = '擴展框體縮放 (%d%%)';
CHHT_GUI_FRAME_PANIC_SCALE            = 'Panic 框體縮放 (%d%%)';
CHHT_GUI_FRAME_PLAYER_SCALE           = '玩家 框體縮放 (%d%%)';
CHHT_GUI_FRAME_PARTY_SCALE            = '隊友 框體縮放 (%d%%)';
CHHT_GUI_FRAME_PET_SCALE              = '寵物 框體縮放 (%d%%)';
CHHT_GUI_FRAME_PARTYPET_SCALE         = '隊友 Pet 框體縮放 (%d%%)';
CHHT_GUI_TARGET_FRAMES                = '目標框體';
CHHT_GUI_SHOW_TARGETS                 = "顯示目標";
CHHT_GUI_FRAME_PLAYER_TARGET_WIDTH    = '玩家目標窗體寬度 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_WIDTH     = '隊友目標窗體寬度 (%d)';
CHHT_GUI_FRAME_PET_TARGET_WIDTH       = '寵物目標窗體寬度 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_WIDTH  = '隊友 Pet目標窗體寬度 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_HEIGHT   = '玩家目標窗體高度 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_HEIGHT    = '隊友目標窗體高度 (%d)';
CHHT_GUI_FRAME_PET_TARGET_HEIGHT      = '寵物目標窗體高度 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_HEIGHT = '隊友 Pet目標窗體高度 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_SCALE    = '玩家目標框體縮放 (%d%%)';
CHHT_GUI_FRAME_PARTY_TARGET_SCALE     = '隊友目標框體縮放 (%d%%)';
CHHT_GUI_FRAME_PET_TARGET_SCALE       = '寵物目標框體縮放 (%d%%)';
CHHT_GUI_FRAME_PARTYPET_TARGET_SCALE  = '隊友 Pet目標框體縮放 (%d%%)';
CHHT_GUI_TOOLTIPS                     = '提示信息';
CHHT_GUI_SHOW_GAME_TOOLTIPS           = "顯示遊戲提示信息";
CHHT_GUI_SHOW_GAME_TOOLTIPS_LOCATION  = "Location of game tooltips";
CHHT_GUI_SHOW_ACTION_TOOLTIPS         = "顯示法術/行為指定提示信息";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK       = "在提示信息中顯示法書級別";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK_MAX   = "顯示使用最高級別法書的提示";
CHHT_GUI_PAGE1                        = "其他";
CHHT_GUI_PAGE2                        = "主體框體";
CHHT_GUI_PAGE3                        = "目標框體";
CHHT_GUI_PAGE4                        = "提示訊息";
CHHT_GUI_PAGE5                        = "定位點";
CHHT_GUI_FRAME_GROUP_MODE_ALL         = '分組所有';
CHHT_GUI_FRAME_GROUP_MODE_GROUP       = '組隊';
CHHT_GUI_TARGET_COLOR_NEVER           = '從不';
CHHT_GUI_TARGET_COLOR_PLAYER          = '玩家';
CHHT_GUI_TARGET_COLOR_ALWAYS          = '總是';
CHHT_GUI_TARGET_DEBUFF_NONE           = '無';
CHHT_GUI_TARGET_DEBUFF_CASTABLE       = '可施法的';
CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE = '可施法敵人';
CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL      = '敵人所有';
CHHT_GUI_TARGET_DEBUFF_ALL            = '所有';
CHHT_GUI_FRAME_ALIGN_LEFT             = '左';
CHHT_GUI_FRAME_ALIGN_CENTER           = '中';
CHHT_GUI_FRAME_ALIGN_RIGHT            = '右';
CHHT_GUI_DOCK_TARGET_NONE             = '無';
CHHT_GUI_DOCK_TARGET_RIGHT            = '右';
CHHT_GUI_DOCK_TARGET_LEFT             = '左';
CHHT_GUI_UNIT_TOOLTIP_ALWAYS          = '總是';
CHHT_GUI_UNIT_TOOLTIP_NEVER           = '從不';
CHHT_GUI_UNIT_TOOLTIP_SHIFT           = 'Shift';
CHHT_GUI_UNIT_TOOLTIP_CTRL            = 'Control';
CHHT_GUI_UNIT_TOOLTIP_ALT             = 'Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL       = 'Shift-Ctrl';
CHHT_GUI_UNIT_TOOLTIP_SHIFTALT        = 'Shift-Alt';
CHHT_GUI_UNIT_TOOLTIP_CTRLALT         = 'Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT    = 'Shift-Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN   = 'ClickHeal Frames';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW    = 'Standard WoW';
CHHT_GUI_ACTION_TOOLTIP_ALWAYS        = '總是';
CHHT_GUI_ACTION_TOOLTIP_NEVER         = '從不';
CHHT_GUI_TOOLTIP_UNIT_TOOLTIP_SCALE   = '單位訊息的 (%d%%) 縮放比';
CHHT_GUI_TOOLTIP_ACTIONS_TOOLTIP_SCALE= '動作訊息的 (%d%%) 縮放比';
CHHT_GUI_TOOLTIP_HINT_TOOLTIP_SCALE   = '提示訊息的 (%d%%) 縮放比';
CHHT_GUI_ANCHORS                      = '定位點';
CHHT_GUI_ANCHORS_ANCHOR_NAME          = '定位';
CHHT_GUI_ANCHORS_RELATIVE_TO          = '定位到';
CHHT_GUI_ANCHORS_RELATIVE_POINT       = '方向';
CHHT_GUI_ANCHORS_OFFSET_X             = 'X-座標';
CHHT_GUI_ANCHORS_OFFSET_Y             = 'Y-座標';
CHHT_GUI_ANCHORS_GROW                 = "Grow";
CHHT_GUI_ANCHORS_SHOW_MENU            = "目錄";
CHHT_GUI_ANCHORS_VISIBILITY           = '明顯性';
CHHT_GUI_ANCHORS_VISIBILITY_SHOW      = '顯示';
CHHT_GUI_ANCHORS_VISIBILITY_AUTOHIDE  = '自動隱藏';
CHHT_GUI_ANCHORS_VISIBILITY_COLLAPSE  = '摺疊';
CHHT_GUI_ANCHORS_GROW_UP              = '上';
CHHT_GUI_ANCHORS_GROW_DOWN            = '下';
CHHT_GUI_ANCHOR_SHOW_DOCK_ANCHORS     = '顯示所有定位點';
CHHT_GUI_ANCHOR_SHOW_ANCHORS          = "定位點可移動";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_TITLE  = "磁性範圍 (%d 像素)";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_LOW    = "無";
CHHT_GUI_ANCHOR_MAGNETIC_RANGE_HIGH   = "20 px";
CHHT_GUI_ANCHOR_MAGNETIC_TITLE_LOW    = "無磁力";

-- ---------- EXTENDED ---------------------------------------------------------------
CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE           = '不顯示';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT           = '左';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP            = '頂部';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT          = '右';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM         = '底部';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN           = '主框體';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW            = 'Standard WoW';
CHHT_EXTENDED_RAID_GROUPS                        = '團隊';
CHHT_EXTENDED_RAID_GROUP1                        = "團隊 1";
CHHT_EXTENDED_RAID_GROUP2                        = "團隊 2";
CHHT_EXTENDED_RAID_GROUP3                        = "團隊 3";
CHHT_EXTENDED_RAID_GROUP4                        = "團隊 4";
CHHT_EXTENDED_RAID_GROUP5                        = "團隊 5";
CHHT_EXTENDED_RAID_GROUP6                        = "團隊 6";
CHHT_EXTENDED_RAID_GROUP7                        = "團隊 7";
CHHT_EXTENDED_RAID_GROUP8                        = "團隊 8";
CHHT_EXTENDED_RAID_CLASSES                       = '團隊職業';
CHHT_EXTENDED_RAID_PETS                          = "團隊寵物";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL            = "每 %d 秒掃瞄團隊寵物 ";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL_MAX        = "秒 (%s)";
CHHT_EXTENDED_RAID_GROUP_FRAME_WIDTH             = '團隊框體寬度 (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_HEIGHT            = '團隊框體高度 (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_WIDTH             = '團隊職業框體寬度 (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_HEIGHT            = '團隊職業框體高度 (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_SCALE             = '團隊框體縮放 (%d%%)';
CHHT_EXTENDED_RAID_CLASS_FRAME_SCALE             = '團隊職業框體縮放 (%d%%)';
CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE               = '隱藏隊伍';
CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW               = '顯示隊伍';
CHHT_EXTENDED_RAID_HIDE_PARTY_WOW                = '使用 WoW 的設定';
CHHT_EXTENDED_RAID_HIDE_PARTY_IN_RAID            = '團隊時隱藏';
CHHT_EXTENDED_RAID_TOOLTIP_ORIENTATION           = "團隊成員提示信息方向";
CHHT_EXTENDED_RAID                               = '團隊';
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
CHHT_EXTENDED_MT_FRAME_WIDTH                     = '主坦克視窗寬 (%d)';
CHHT_EXTENDED_MT_FRAME_HEIGHT                    = '主坦克視窗高 (%d)';
CHHT_EXTENDED_MT_FRAME_SCALE                     = '主坦克視窗縮放 (%d%%)';
CHHT_EXTENDED_NEEDY_LIST_ENABLED                 = "Needy List 啟用";
CHHT_EXTENDED_NEEDY_LIST_HIDE_IN_BATTLEFIELD     = "戰場時隱藏";
CHHT_EXTENDED_NEEDY_LIST_GROW_DIRECTION          = "表單伸出的方向";
CHHT_EXTENDED_NEEDY_LIST_TOOLTIP_ORIENTATION     = "提示訊息的方向";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL           = "每 %3.1f 秒掃描新的needers";
CHHT_EXTENDED_NEEDY_LIST_SCAN_INTERVAL_CONT      = "對新needers持續不斷的掃描";
CHHT_EXTENDED_NEEDY_LIST_MAX_UNITS               = "最大顯示單位數 (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_WIDTH             = "框架寬 (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_HEIGHT            = "框架高 (%d)";
CHHT_EXTENDED_NEEDY_LIST_FRAME_SCALE             = "框架縮放比 (%d%%)";
CHHT_EXTENDED_NEEDY_LIST_UNITS_LABEL             = "單位";
CHHT_EXTENDED_NEEDY_LIST_CLASSES_LABEL           = "職業";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_ALWAYS          = "總是";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTY           = "隊伍";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_RAID            = "團隊";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_PARTYRAID       = "隊伍 & 團隊";
CHHT_EXTENDED_NEEDY_LIST_ENABLED_NEVER           = "絕不";
CHHT_EXTENDED_NEEDY_LIST_SORT                    = '分類';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR                = '隱藏OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_NONE           = '不要隱藏';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_POSSIBLE       = '可能OOR';
CHHT_EXTENDED_NEEDY_LIST_HIDE_OOR_VERIFIED       = '已確認';
CHHT_EXTENDED_NEEDY_LIST_HEAL                    = "Needy List 治療"
CHHT_EXTENDED_NEEDY_LIST_HEAL_HEALTH_PERCENTAGE  = "單位的生命值百分比到達 (%d%%) 時顯示";
CHHT_EXTENDED_NEEDY_LIST_HEAL_LOCK_TANKS         = "鎖定並且顯示坦克";
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_UNSORTED      = '不分類';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_LOCKED        = '鎖定單位';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGENCY     = 'emergency';
CHHT_EXTENDED_NEEDY_LIST_HEAL_SORT_EMERGLOCKED   = 'emergency, locked';
CHHT_EXTENDED_NEEDY_LIST_CURE                    = "Needy List 解咒"
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_CURSE         = "顯示 解咒";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_DISEASE       = "顯示 疾病";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_POISON        = "顯示 中毒";
CHHT_EXTENDED_NEEDY_LIST_CURE_SHOW_MAGIC         = "顯示 魔法";
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_UNSORTED      = '不分類';
CHHT_EXTENDED_NEEDY_LIST_CURE_SORT_LOCKED        = '鎖定單位';
CHHT_EXTENDED_NEEDY_LIST_BUFF                    = "Needy List Buff"
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_UNSORTED      = '不分類';
CHHT_EXTENDED_NEEDY_LIST_BUFF_SORT_LOCKED        = '鎖定單位';
CHHT_EXTENDED_NEEDY_LIST_DEAD                    = "Needy List 死亡"
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_UNSORTED      = '不分類';
CHHT_EXTENDED_NEEDY_LIST_DEAD_SORT_LOCKED        = '鎖定單位';
CHHT_EXTENDED_PAGE1                              = "團隊";
CHHT_EXTENDED_PAGE2                              = "Tank/Assist";
CHHT_EXTENDED_PAGE3                              = "NL 治療";
CHHT_EXTENDED_PAGE4                              = "NL 解咒";
CHHT_EXTENDED_PAGE5                              = "NL Buff";
CHHT_EXTENDED_PAGE6                              = "NL 死亡";

-- ---------- FRIEND -----------------------------------------------------------------
CHHT_FRIEND_OPTIONS                = '友好設置';
CHHT_FRIEND_HITPOINT_LABEL         = "隊友/團隊成員標記為";
CHHT_FRIEND_FRAME_BACKGROUND       = "自己/隊友 框體背景";
CHHT_FRIEND_FRAME_BACKGROUND_ALPHA = 'Opacity (%3.2f)';
CHHT_FRIEND_PICK_COLOR             = 'Pick Color';
CHHT_FRIEND_RESURRECT              = "復活死亡隊友";
CHHT_FRIEND_ADJUST_SPELLRANK       = "根據目標等級調整施法等級";
CHHT_FRIEND_SHOW_MANA              = "顯示法力";
CHHT_FRIEND_SHOW_RAGE              = "顯示怒氣";
CHHT_FRIEND_SHOW_ENERGY            = "顯示能量";
CHHT_FRIEND_SHOW_FOCUS             = "顯示集中(Pets)";
CHHT_FRIEND_SHADOWFORM             = "開關暗影形態/幽魂狼/潛行";
CHHT_FRIEND_CAST_ON_CHARMED        = "對被媚惑的友方施放攻擊性法術";
CHHT_FRIEND_MOUSE_TITLE            = '友軍行為';
CHHT_FRIEND_PAGE1                  = "選項";
CHHT_FRIEND_PAGE2                  = "游標 1/3";
CHHT_FRIEND_PAGE3                  = "游標 2/3";
CHHT_FRIEND_PAGE4                  = "游標 3/3";
CHHT_FRIEND_HP_LABEL_PERCENT       = '百分比';
CHHT_FRIEND_HP_LABEL_PERCENT_SIGN  = '帶標記的百分比';
CHHT_FRIEND_HP_LABEL_CURRENT       = '當前生命值';
CHHT_FRIEND_HP_LABEL_MISSING       = '損失生命值';
CHHT_FRIEND_HP_LABEL_NONE          = '不要標記';
CHHT_FRIEND_FRAME_BACKGROUND_HEALTH= '彩色生命值';
CHHT_FRIEND_FRAME_BACKGROUND_CLASS = '職業色彩';
CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM= 'Custom';
CHHT_FRIEND_PARTY_LABEL_CLASS      = '職業';
CHHT_FRIEND_PARTY_LABEL_NAME       = '名字';
CHHT_FRIEND_PARTY_LABEL_BOTH       = '職業-名字';
CHHT_FRIEND_PARTY_LABEL_COLOR      = '彩色名字';
CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR  = 'Class-Name Color';
CHHT_FRIEND_FRIEND_DEBUFF_NONE     = '無';
CHHT_FRIEND_FRIEND_DEBUFF_CURABLE  = '可治癒的';
CHHT_FRIEND_FRIEND_DEBUFF_ALL      = '所有';
CHHT_FRIEND_RESURRECT_AFTER_COMBAT = '在戰鬥之後';
CHHT_FRIEND_RESURRECT_ALWAYS       = '總是';
CHHT_FRIEND_RESURRECT_NEVER        = '從不';
CHHT_FRIEND_POWER_WORD_SHIELD      = '不要施放 真言：盾 當已經存在時';
CHHT_FRIEND_RENEW                  = '不要施放 恢復 當已經存在時';
CHHT_FRIEND_REGROWTH               = '不要施放 癒合 當已經存在時';
CHHT_FRIEND_REJUVENATION           = '不要施放 回春術 當已經存在時';
CHHT_FRIEND_SWIFTMEND              = '不要施放 swiftmend 當已經存在時';

CHHT_FRIEND_CHECK_HEAL_RANGE                              = '檢查治療範圍';
CHHT_FRIEND_CHECK_HEAL_RANGE_MODE                         = '模式';
CHHT_FRIEND_CHECK_HEAL_RANGE_NEVER                        = '不要檢查';
CHHT_FRIEND_CHECK_HEAL_RANGE_FOLLOW                       = '使用跟隨範圍 (快)';
CHHT_FRIEND_CHECK_HEAL_RANGE_ONHWEVENT                    = '根據每一硬體事件掃描';
CHHT_FRIEND_CHECK_HEAL_RANGE_BOUNDARY_FORMAT              = '%3.1f 秒';
CHHT_FRIEND_CHECK_HEAL_RANGE_KEEP_DURATION                = '持續週期 (%3.1f 秒)';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_OOR            = 'Show OOR at hp';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_HP             = 'Color hitpoints';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_BACKGROUND     = 'Custom background';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_NONE           = 'Do not show';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE       = 'Possible OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED       = 'Verified OOR';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_POSSIBLE_COLOR = 'Color Possible';
CHHT_FRIEND_CHECK_HEAL_RANGE_VISUALIZATION_VERIFIED_COLOR = 'Color Verified';

-- ---------- TARGET/ENEMY -----------------------------------------------------------
CHHT_TARGET_TARGETING          = "目標獲得方式";
CHHT_TARGET_PLAYER_TARGET      = "玩家目標";
CHHT_TARGET_PARTY1_TARGET      = "隊友 1目標";
CHHT_TARGET_PARTY2_TARGET      = "隊友 2目標";
CHHT_TARGET_PARTY3_TARGET      = "隊友 3目標";
CHHT_TARGET_PARTY4_TARGET      = "隊友 4目標";
CHHT_TARGET_PET_TARGET         = "寵物目標";
CHHT_TARGET_PARTYPET1_TARGET   = "隊友 寵物 1目標";
CHHT_TARGET_PARTYPET2_TARGET   = "隊友 寵物 2目標";
CHHT_TARGET_PARTYPET3_TARGET   = "隊友 寵物 3目標";
CHHT_TARGET_PARTYPET4_TARGET   = "隊友 寵物 4目標";
CHHT_TARGET_OPTIONS            = '敵人設置';
CHHT_TARGET_SHOW_LEVEL_DIFF    = "顯示 級別差異";
CHHT_TARGET_SHOW_MANA          = "顯示 法力";
CHHT_TARGET_SHOW_RAGE          = "顯示 怒氣";
CHHT_TARGET_SHOW_ENERGY        = "顯示 能量";
CHHT_TARGET_SHOW_FOCUS         = "顯示 集中 (寵物)";
CHHT_TARGET_CAST_ON_CHARMED    = "對被媚惑的敵方施放有益法術";
CHHT_TARGET_MOUSE_TITLE        = '敵人行為';
CHHT_TARGET_COLORS             = '彩色';
CHHT_TARGET_PAGE1              = "選項";
CHHT_TARGET_PAGE2              = "游標 1/3";
CHHT_TARGET_PAGE3              = "游標 2/3";
CHHT_TARGET_PAGE4              = "游標 3/3";
CHHT_TARGET_GROUP_LABEL_FORMAT = "分組 %d";
CHHT_TARGET_TARGETING_KEEP     = '保持當前目標';
CHHT_TARGET_TARGETING_TARGET   = '選擇法術目標作為目標';
CHHT_TARGET_TARGETING_INT      = '職能選擇';
CHHT_COLOR_GROUP_LABEL_FORMAT  = '彩色分組 %s';

-- ---------- PANIC ------------------------------------------------------------------
CHHT_PANIC_OPTIONS                     = 'Panic 選項';
CHHT_PANIC_NO_BATTLEFIELD              = '野外戰場';
CHHT_PANIC_IN_BATTLEFIELD              = '副本戰場';
CHHT_PANIC_CURE_UNITS                  = "使用 'PANIC' 治療";
CHHT_PANIC_UNMAPPED                    = "當按鍵未設定時使用 'PANIC' ";
CHHT_PANIC_CHECK_RANGE                 = "範圍檢查";
CHHT_PANIC_SPELL_DOWNGRADE             = "起用溢補最小化";
CHHT_PANIC_COMBAT_HEALING_IN_BATTLEFIELD="總是使用戰鬥治療";
CHHT_PANIC_MOUSE_TITLE                 = 'Panic 動作';
CHHT_PANIC_BEHAVIOR                    = 'Panic 行為';
CHHT_PANIC_BEHAVIOR_LABEL              = "Panic 行為模板";
CHHT_PANIC_BEHAVIOR_SPELL_TITLE_FORMAT = "法術 %d";
CHHT_PANIC_BEHAVIOR_FORCE_CAST         = "強制施法";
CHHT_PANIC_BEHAVIOR_CLASSES            = '職業';
CHHT_PANIC_BEHAVIOR_EMERGENCY_LEVELS   = '危險等級';
CHHT_PANIC_BEHAVIOR_SPELL_EDIT         = '法術調整';
CHHT_PANIC_PAGE1                       = "選項";
CHHT_PANIC_PAGE2                       = "行為";
CHHT_PANIC_PAGE3                       = "游標 1/3";
CHHT_PANIC_PAGE4                       = "游標 2/3";
CHHT_PANIC_PAGE5                       = "游標 3/3";
CHHT_PANIC_TITLE_HEAL                  = 'PANIC: 治療';
CHHT_PANIC_TITLE_BUFF                  = 'PANIC: 增益魔法';
CHHT_PANIC_TITLE_FULL                  = '完整施法範圍';
CHHT_PANIC_TITLE_TRASH                 = '垃圾治療';
CHHT_PANIC_TITLE_BATTLEFIELD           = '戰場';
CHHT_PANIC_TITLE_CUSTOM1               = '格式 1';
CHHT_PANIC_TITLE_CUSTOM2               = '格式 2';
CHHT_PANIC_TITLE_CUSTOM3               = '格式 3';

-- ---------- EXTRA ------------------------------------------------------------------
CHHT_EXTRA_LABEL         = "標籤";
CHHT_EXTRA_SHOW_COOLDOWN = "顯示冷卻時間";
CHHT_EXTRA_OPTIONS       = 'Extra 選項';
CHHT_EXTRA_HIDE_BUTTON   = "隱藏按鈕";
CHHT_EXTRA_PAGE1         = "選項";
CHHT_EXTRA_PAGE2         = "游標 1/3";
CHHT_EXTRA_PAGE3         = "游標 2/3";
CHHT_EXTRA_PAGE4         = "游標 3/3";
CHHT_EXTRA_LABEL_FORMAT  = '擴展 %d';
CHHT_EXTRA_TITLE_FORMAT  = '擴展 %d 按鈕';

-- ---------- CHAINS -----------------------------------------------------------------
CHHT_CHAINS_BUTTON_ASSIGNMENT = '按鈕分配';
CHHT_CHAINS_CHAIN1            = "鏈 1";
CHHT_CHAINS_CHAIN2            = "鏈 2";
CHHT_CHAINS_CHAIN3            = "鏈 3";
CHHT_CHAINS_CHAIN4            = "鏈 4";
CHHT_CHAINS_NAME_FORMAT       = "鏈 %d";
CHHT_CHAINS_TITLE_FORMAT      = '鏈 %d 設置';

-- ---------- BUFFS ------------------------------------------------------------------
CHHT_BUFF_TITLE              = '增益選項';
CHHT_BUFF_EXPIRE_PLAY_SOUND  = "播放聲音當增益過期後";
CHHT_BUFF_EXPIRE_SHOW_MSG    = "顯示信息當增益過期後";
CHHT_BUFF_WARN_PLAY_SOUND    = "播放聲音 當將要增益過期時";
CHHT_BUFF_WARN_SHOW_MSG      = "顯示信息當將要增益過期時";
CHHT_BUFF_SHOW_TRACKING_BUFF = "顯示追蹤buff的缺少(尋找草藥,人形追蹤等 ...)";
CHHT_BUFF_SHOW_RAID_EFFECTS  = "顯示團隊成員buff效果 (缺少buffs,激活debuffs)";
CHHT_BUFF_COMBINE_IN_PANIC   = "組合缺少buff信息在PANIC框體中";
CHHT_BUFF_AVAILABLE_BUFFS    = '可用的增益';
CHHT_BUFF_ALLOWED_CLASSES    = '允許的職業';
CHHT_BUFF_ALLOWED_UNITS      = '允許的對象';
CHHT_BUFF_BUFF_DATA          = '增益數據';
CHHT_BUFF_UPGRADE_Q          = "釋放 #PARTYSPELLNAME# 當至少有 (n) #PARTYSPELLSPEC# 隊友需要";
CHHT_BUFF_UPGRADE_MSG        = "更新單位法術";
CHHT_BUFF_IN_BATTLEFIELD     = "戰場施放buff";
CHHT_BUFF_PAGE1              = "選項";
CHHT_BUFF_PAGE2              = "增益列表";
CHHT_BUFFS_NEVER_WARN        = "從不提醒";
CHHT_BUFFS_ALWAYS_WARN       = "總是提醒";
CHHT_BUFFS_WARN_EXPIRE_TITLE = "在過期之前提醒 %s ";
CHHT_BUFFS_NEVER_REFRESH     = "從不更新";
CHHT_BUFFS_ALWAYS_REFRESH    = "總是更新";
CHHT_BUFFS_REFRESH_TITLE     = "在過期之前更新 %s";

-- ---------- TOTEMSET ---------------------------------------------------------------
CHHT_TOTEMSET_LABEL_FORMAT            = "圖騰設置 %d";
CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT = "重置時間 (%s)";
CHHT_TOTEMSET_SLIDER_TITLE_FORMAT     = "%d秒";

end
