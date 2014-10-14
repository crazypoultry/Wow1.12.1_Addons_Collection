if ( GetLocale() == "zhCN" ) then

-- ---------- GLOBALS ----------------------------------------------------------------
CHHT_LABEL_CLOSE       = "关闭";
CHHT_LABEL_DEFAULT     = "缺省";
CHHT_LABEL_DEFAULTS    = "缺省";
CHHT_LABEL_CONFIGURE   = "设置";

CHHT_LABEL_NONE        = '无';

CHHT_LABEL_MOUSE_1_3   = "鼠标 1/3";
CHHT_LABEL_MOUSE_2_3   = "鼠标 2/3";
CHHT_LABEL_MOUSE_3_3   = "鼠标 3/3";

CHHT_LABEL_PLAYER      = '玩家';
CHHT_LABEL_PET         = '宠物';
CHHT_LABEL_PARTY       = '队友';
CHHT_LABEL_PARTYPET    = '队友宠物';
CHHT_LABEL_RAID        = '团队';
CHHT_LABEL_RAIDPET     = '团队宠物';
CHHT_LABEL_TARGET      = '目标';
CHHT_LABEL_PARTY1      = '队友 1';
CHHT_LABEL_PARTY2      = '队友 2';
CHHT_LABEL_PARTY3      = '队友 3';
CHHT_LABEL_PARTY4      = '队友 4';
CHHT_LABEL_PARTYPET1   = '队友宠物 1';
CHHT_LABEL_PARTYPET2   = '队友宠物 2';
CHHT_LABEL_PARTYPET3   = '队友宠物 3';
CHHT_LABEL_PARTYPET4   = '队友宠物 4';

CHHT_LABEL_PLAYER_LC   = '玩家';
CHHT_LABEL_PET_LC      = '宠物';
CHHT_LABEL_PARTY_LC    = '队友';
CHHT_LABEL_PARTYPET_LC = '队友宠物';
CHHT_LABEL_RAID_LC     = '团队';
CHHT_LABEL_RAIDPET_LC  = '团队宠物';
CHHT_LABEL_TARGET_LC   = '目标';
CHHT_LABEL_PARTY1_LC   = '队友 1';
CHHT_LABEL_PARTY2_LC   = '队友 2';
CHHT_LABEL_PARTY3_LC   = '队友 3';
CHHT_LABEL_PARTY4_LC   = '队友 4';
CHHT_LABEL_PARTYPET1_LC= '队友宠物 1';
CHHT_LABEL_PARTYPET2_LC= '队友宠物 2';
CHHT_LABEL_PARTYPET3_LC= '队友宠物 3';
CHHT_LABEL_PARTYPET4_LC= '队友宠物 4';

CHHT_LABEL_RAID_GROUP_FORMAT = 'Raid Group %d';

CHHT_LABEL_MAX         = "最大";
CHHT_LABEL_MIN         = "最小";
CHHT_LABEL_ALWAYS      = "总是";
CHHT_LABEL_NEVER       = "从不";
CHHT_LABEL_CONTINOUSLY = "连续";

CHHT_LABEL_UP          = "上";
CHHT_LABEL_DOWN        = "下";
CHHT_LABEL_DN          = "Dn";

CHHT_LABEL_LEFT        = '左';
CHHT_LABEL_RIGHT       = '右';
CHHT_LABEL_TOP         = '顶部';
CHHT_LABEL_BOTTOM      = '底部';
CHHT_LABEL_TOPLEFT     = 'TopLeft';
CHHT_LABEL_TOPRIGHT    = 'TopRIght';
CHHT_LABEL_BOTTOMLEFT  = 'BottomLeft';
CHHT_LABEL_BOTTOMRIGHT = 'BottomRight';

CHHT_LABEL_HIGHEST     = '最高';
CHHT_LABEL_MEMBERS     = '成员';

CHHT_NUMBER_ONE        = '一';
CHHT_NUMBER_TWO        = '二';
CHHT_NUMBER_THREE      = '三';
CHHT_NUMBER_FOUR       = '四';
CHHT_NUMBER_FIVE       = '五';

CHHT_LABEL_UPDATE      = 'Update';

-- ---------- TABs -------------------------------------------------------------------
CHHT_TAB_HELP      = "帮助";
CHHT_TAB_CONFIG    = "设置";
CHHT_TAB_GUI       = "界面";
CHHT_TAB_EXTENDED  = "Extended";
CHHT_TAB_FRIEND    = "友方";
CHHT_TAB_ENEMY     = "敌对";
CHHT_TAB_PANIC     = "Panic";
CHHT_TAB_EXTRA     = "扩展";
CHHT_TAB_CHAINS    = "链";
CHHT_TAB_BUFFS     = "增益魔法";
CHHT_TAB_TOTEMS    = "图腾";

-- ---------- HELP / FAQ -------------------------------------------------------------
CHHT_HELP_TRACKING_BUFF = "(缺少追踪buff,查找草药,查找矿物,追踪野兽, ..)";
CHHT_HELP_TITLE         = '帮助 / FAQ';
CHHT_HELP_MSG           = "ClickHeal 帮助";
CHHT_HELP_PAGE1         = "帮助";
CHHT_HELP_PAGE2         = "缩写";
CHHT_HELP_PAGE3         = "FAQs";
CHHT_HELP_PAGE4         = "Credits";

CHHT_HELP_HELP =
  '|c00FFFF00Introduction|r\n'
..'ClickHeal enables you to cast a spell on a unit/player with only one mouse click, without previously targeting the unit and then casting the spell. '
..'By history, ClickHeal was geared towards healers. Although this is still the strongest point of ClickHeal, it is also extremely useful for other '
..'casters.\n\n'
..'|c00FFFF00Spells assignment|r\n'
..'The power of ClickHeal is the ease of assigning spells to your mouse buttons. You can map all your buttons (left,middle,right) and for five button '
..'mice also the button4 and button5. In addition you can map modification keys, like SHIFT-left mouse button.\n'
..'Spells and mouse buttons will be assigned to groups, like enemies, friends and the so called Extra buttons. Dependant on what unit/frame you then click, '
..'the mapped spell will be cast. This is, that for example you left click a friendly unit, you will cast a heal spell but when left clicking an enemy '
..'unit, a damage spell will be cast.\n'
..'Spells can be assigned with this config screen. Just select on the bottom one of the tabs you would like to assign spells for. In the new section you '
..'can then define global options for this section and map the spells to mouse buttons.\n\n'
..'|c00FFFF00There is more to ClickHeal|r\n'
..'ClickHeal not only allows you to map spells, you can also map certain actions, like attack, have your pet attack, drink potions, and more. '
..'ClickHeal also finetunes your spells, checks overhealing and many more.\n\n'
..'|c00FFFF00The ClickHeal Frames|r\n'
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
..'|c00FF0000M|c00FFFFFF (magic)\n'
..'|c00FF0000C|c00FFFFFF (curse)\n'
..'|c00FF0000D|c00FFFFFF (disease)\n'
..'|c00FF0000P|c00FFFFFF (poison)\n'
..'|c00FF8800B|c00FFFFFF (recently bandaged)\n'
..'|c00FF8800P|c00FFFFFF (phase shifted imp)\n\n';

CHHT_HELP_TEXT_HOT = 
  '|c00FFFF00Heal over Time (HOT) (green)\n'
..'|c0000FF00J|c00FFFFFF (Rejuvenation)\n'
..'|c0000FF00G|c00FFFFFF (Regrowth)\n'
..'|c0000FF00N|c00FFFFFF (Renew)\n\n';

CHHT_HELP_TEXT_SHIELD = 
  '|c00FFFF00Shield\n'
..'|c0000FF00S|c00FFFFFF (Power Word: Shield)\n'
..'|c00FF8800S|c00FFFFFF (Weakend Soul)\n\n';

CHHT_HELP_TEXT_BUFFS =
  '|c00FFFF00Missing Buffs (yellow):\n'
..'|c00FFFF00B|r (Any buff, PANIC frame only)\n';

CHHT_HELP_TEXT_FINETUNE =
  '|c00FFFF00Spell Finetuning:|c00FFFFFF\n'
..'|c0000CCFFPower Word: Shield|c00FFFFFF -> Renew -> Flash Heal\n'
..'|c0000CCFFRenew|c00FFFFFF -> Flash Heal\n'
..'|c0000CCFFRejuvenation|c00FFFFFF -> Regrowth -> Healing Touch\n'
..'|c0000CCFFRegrowth|c00FFFFFF -> Rejuvenation -> Regrowth (yes, back to Regrowth)\n\n'
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
  '|c00FFFF00About|r\n'
..'ClickHeal is developed by rmet0815. It is licenced under the GPL (Gnu Public Licence), which generally implies that everyone may use it '
..'without restriction. GPL is sticky however, meaning that if you make modifications to the AddOn or use parts of it in your own '
..'applications, these have to be licenced under GPL again.\n\n'
..'|c00FFFF00Credits|r\n'
..'French localization by: Genre, Mainsacr\195\169\n'
..'Korean localization by: Damjau\n'
..'German localization by: Rastibor, Teodred@Rat von Dalaran, Farook\n'
..'Simple Chinese localization by: Space Dragon\n'
..'Traditional Chinese localization by: Bell\n\n'
..'And thanx to all you guys out there using ClickHeal, commenting on it and delivering feedback and bugreports. Without you, '
..'ClickHeal would not be what it is today!';

-- ---------- COMMON / CH_HELP -------------------------------------------------------
CHHT_PET_ATTACK_NONE         = '无';
CHHT_PET_ATTACK_HUNTERS_MARK = CH_SPELL_HUNTERS_MARK;

CHHT_UNITBUFF_AUTOMATIC      = '自动';
CHHT_UNITBUFF_POPUP          = '弹出';

CHHT_GROUPBUFF_REFRESH_TIME  = '刷新时间';
CHHT_GROUPBUFF_WARN_TIME     = '提醒时间';

-- ---------- MISC -------------------------------------------------------------------
CHHT_MISC_OPTIONS                       = '其他选项';
CHHT_MISC_ADDONS                        = '插件';
CHHT_MISC_CTRA                          = "CT Raid Assist (CTRA)";
CHHT_MISC_DUF                           = "Discord Unit Frames (DUF)";
CHHT_MISC_BONUSSCANNER                  = "BonusScanner";
CHHT_MISC_PCUF                          = "Perl Classic Unit Frames (PCUF)";
CHHT_MISC_ORA                           = "oRA";
CHHT_MISC_WOWGUI                        = "缺省 WoW 界面";
CHHT_MISC_DECURSIVE                     = "Decursive";
CHHT_MISC_NEEDYLIST                     = "Ralek's Needy List";
CHHT_CAST_SPELL_BY_NAME_ON_SELF         = "使用wow自带的自我施法机制";
CHHT_MISC_DEBUG_LEVEL                   = "Debug Messages";
CHHT_MISC_RESETALL_Q                    = "选择这个然后按右边的按键将重设所有click heal 的设置";
CHHT_MISC_RESETALL                      = "全部重置";
CHHT_MISC_PLUGINS                       = 'Plugins';
CHHT_CONFIG_PLUGIN_INFO_MSG             = 'Plugins can be disabled in the character login screen, "Plugin" button on the lower right';
CHHT_MISC_COMBAT                        = "战斗";
CHHT_MISC_COMBAT_SAFE_TAUNT             = "安全嘲讽";
CHHT_MISC_COMBAT_SD                     = '自卫';
CHHT_MISC_COMBAT_SD_ATTACK              = "如果被攻击，自动攻击目标";
CHHT_MISC_COMBAT_SD_PET                 = "如果被攻击，自动使用宠物攻击目标";
CHHT_MISC_COMBAT_SD_HIT                 = "只考虑你自己被攻击的情况";
CHHT_MISC_COMBAT_SD_MES                 = "不攻击被控制的（变羊，束缚亡灵...）目标";
CHHT_MISC_COMBAT_SD_SWITCH              = '在队伍/团队中不启用';
CHHT_MISC_CDW                           = '冷却监视';
CHHT_MISC_CDW_EXTRA1                    = '扩展按钮1';
CHHT_MISC_CDW_EXTRA2                    = '扩展按钮2';
CHHT_MISC_CDW_EXTRA3                    = '扩展按钮3';
CHHT_MISC_CDW_EXTRA4                    = '扩展按钮4';
CHHT_MISC_CDW_SPELLS                    = '法术';
CHHT_MISC_CDW_BAG                       = "显示背包中物品的冷却时间";
CHHT_MISC_OVERHEAL                      = '治疗';
CHHT_MISC_OVERHEAL_COMBAT               = "在战斗中，施法法术当玩家生命低于";
CHHT_MISC_OVERHEAL_NOCOMBAT             = "在非战斗状态下使用最有效的法术";
CHHT_MISC_OVERHEAL_DOWNSCALE            = "Downscale spell rank in combat to minimize overhealing";
CHHT_MISC_OVERHEAL_LOM_DOWNSCALE        = "How mana ranks to maximally downscale spell rank in combat if too low on mana";
CHHT_MISC_OVERHEAL_BASE                 = "Percentage of variable heal amount to consider in calculations";
CHHT_MISC_OVERHEAL_HOT                  = "考虑HOT治疗的百分比";
CHHT_MISC_OVERHEAL_QUICK                = '快';
CHHT_MISC_OVERHEAL_SLOW                 = '慢';
CHHT_MISC_OVERHEAL_DPSCHECK             = '考虑多长时间内玩家被攻击的dps';
CHHT_MISC_OVERHEAL_CLICK_ABORT_PERC     = 'Health percentage of target to abort spell when heal underway and clicking again';
CHHT_MISC_OVERHEAL_MODIFY_TOTAL_PERC    = 'Percentage to modify total healing result with';
CHHT_MISC_OVERHEAL_OVERHEAL_ALLOWANCE   = 'How much overhealing per spell rank is allowed';
CHHT_MISC_OVERHEAL_LOM_NONE             = 'None';
CHHT_MISC_OVERHEAL_LOM_MAX              = 'Maximum';
CHHT_MISC_OVERHEAL_LOM_TITLE_FORMAT     = '%d spell ranks';
CHHT_MISC_OVERHEAL_GEAR                 = '考虑玩家的装备治疗量';
CHHT_MISC_OVERHEAL_FORMULA_QUICK        = "Formula for QUICK:";
CHHT_MISC_OVERHEAL_FORMULA_SLOW         = "Formula for SLOW:";
CHHT_MISC_NOTIFY_HIT                    = '我被攻击了';
CHHT_MISC_NOTIFY_HIT_SOUND              = "播放声音";
CHHT_MISC_NOTIFY_HIT_SOUND_REPEAT       = "在...秒内不要重复播放";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PARTY     = "提醒队友";
CHHT_MISC_NOTIFY_HIT_ANNOUNCE_PLAY_EMOTE= "Play emote";
CHHT_MISC_NOTIFY_HIT_HITPOINTS          = "只有当生命少于...才提醒";
CHHT_MISC_NOTIFY_HIT_HITPOINT_SLIDER_TITLE = "生命 (%d%%)";
CHHT_MISC_NOTIFY_HIT_HITPOINTS_FADE     = "当“消失”被激活(或冷却中), 仅当生命低于...时提醒 (仅限牧师)";
CHHT_MISC_NOTIFY_HIT_REPEAT             = "多少秒内不要重复提醒";
CHHT_MISC_NOTIFY_HIT_MSG                = "显示的消息";
CHHT_MISC_NOTIFY_OOM                    = '法力不足';
CHHT_MISC_NOTIFY_OOM_PARTY              = "在队伍中提醒";
CHHT_MISC_NOTIFY_OOM_RAID               = "Announce to raid";
CHHT_MISC_NOTIFY_OOM_CUSTOM_CHANNEL     = "Announce to custom channel";
CHHT_MISC_NOTIFY_OOM_PLAY_EMOTE         = "Play Emote";
CHHT_MISC_NOTIFY_OOM_MANA               = "提醒如果法力低于 at";
CHHT_MISC_NOTIFY_OOM_SLIDER_TITLE       = '法力 (%d%%)';
CHHT_MISC_NOTIFY_OOM_REPEAT             = "多少秒内不要重复提醒";
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL         = "Custom Channel"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_NAME    = "Name"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_PASSWORD= "Password"
CHHT_MISC_NOTIFY_CUSTOM_CHANNEL_CHAT_BOX= "Chat Box";
CHHT_MISC_NOTIFY_DEFAULT_CHAT_WINDOW_LABEL="Default Window";
CHHT_MISC_NOTIFY_CHAT_WINDOW_LABEL_FORMAT="Chat Window %d";
CHHT_MISC_NOTIFY_SPELLCAST              = 'Announce Spellcast';
CHHT_MISC_NOTIFY_SPELLCAST_SAY          = "说";
CHHT_MISC_NOTIFY_SPELLCAST_TELL         = "告诉某人";
CHHT_MISC_NOTIFY_SPELLCAST_PARTY        = "在队伍中提醒";
CHHT_MISC_NOTIFY_SPELLCAST_RAID         = "在团队聊天中提醒";
CHHT_MISC_NOTIFY_SPELLCAST_CUSTOM_CHANNEL="Custom Channel";
CHHT_MISC_PAGE1                         = "其他";
CHHT_MISC_PAGE2                         = "Plugins";
CHHT_MISC_PAGE3                         = "战斗";
CHHT_MISC_PAGE4                         = "冷却";
CHHT_MISC_PAGE5                         = "治疗";
CHHT_MISC_PAGE6                         = "提醒";
CHHT_MISC_PAGE7                         = "提醒 2";
CHHT_MISC_HEALTH_PERCENT_TITLE_FORMAT   = "生命百分比 (%s%%)";
CHHT_MISC_HEAL_POTENTIAL_TITLE_FORMAT   = "治疗潜力 (%s%%)";
CHHT_MISC_HOT_PERCENTAGE_TITLE_FORMAT   = "HOT百分比 (%s%%)";
CHHT_MISC_HIT_AGO_TITLE_FORMAT          = "击中 %s 秒以前";
CHHT_MISC_CLICK_ABORT_PERC_TITLE_FORMAT = "生命百分比 (%s%%)";
CHHT_MISC_OVERHEAL_ALLOWANCE_TITLE_FORMAT="Overheal allowance (%s%%)";
CHHT_MISC_SECONDS_TITLE_FORMAT          = "秒 (%s)";
CHHT_MISC_MODIFY_TOTAL_PERC_FORMAT      = "modify total by (%s%%)";

-- ---------- GUI --------------------------------------------------------------------
CHHT_GUI_PARTY_SORT                   = '队伍排序';
CHHT_GUI_MISC                         = '其他';
CHHT_GUI_PARTY_MEMBER_LABEL           = "团队成员标签";
CHHT_GUI_SHOW_FRIEND_DEBUFFS          = "显示友好目标的减益法术";
CHHT_GUI_TARGET_BACKGROUND_COLOR      = "生命目标背景色彩";
CHHT_GUI_SHOW_TARGET_DEBUFFS          = "显示目标减益法术";
CHHT_GUI_FRAME_GROUP_MODE             = "框体分组模式";
CHHT_GUI_SHOW_CLICKHEAL_FRAMES        = "显示 ClickHeal 框体";
CHHT_GUI_SHOW_PARTY_FRAMES            = "显示队伍框体";
CHHT_GUI_SHOW_PARTY_PETS_FRAMES       = "显示队友宠物";
CHHT_GUI_SHOW_WOW_PARTY_FRAMES        = "显示 WoW 队伍框体";
CHHT_GUI_SHOW_PLAYER_MANA             = "显示玩家法力(在玩家框体中)";
CHHT_GUI_SHOW_PET_FOCUS               = "显示宠物集中";
CHHT_GUI_SHOW_PARTYPET_TARGET         = "显示队友宠物目标";
CHHT_GUI_SHOW_MES                     = "显示控制技能计时(变羊,...)";
CHHT_GUI_SHOW_FIVE_SEC_RULE           = '显示 "5秒规则" 和法力恢复';
CHHT_GUI_SHOW_HINTS                   = "显示 设置中的提示";
CHHT_GUI_UPDATE_SLIDER_TITLE          = '更新间隔 (%3.1f seconds)';
CHHT_GUI_RESET_FRAME_POS              = "重设框体位置";
CHHT_GUI_MAIN_FRAMES                  = '主框体';
CHHT_GUI_FRAME_ALIGNMENT              = "框体对齐";
CHHT_GUI_FRAME_EXTRA_WIDTH            = '扩展窗体宽度 (%d)';
CHHT_GUI_FRAME_PANIC_WIDTH            = 'PANIC窗体宽度 (%d)';
CHHT_GUI_FRAME_PLAYER_WIDTH           = '玩家窗体宽度 (%d)';
CHHT_GUI_FRAME_PARTY_WIDTH            = '队友窗体宽度 (%d)';
CHHT_GUI_FRAME_PET_WIDTH              = '宠物窗体宽度 (%d)';
CHHT_GUI_FRAME_PARTYPET_WIDTH         = '队友 Pet窗体宽度 (%d)';
CHHT_GUI_FRAME_EXTRA_HEIGHT           = '扩展窗体高度 (%d)';
CHHT_GUI_FRAME_PANIC_HEIGHT           = 'PANIC窗体高度 (%d)';
CHHT_GUI_FRAME_PLAYER_HEIGHT          = '玩家窗体高度 (%d)';
CHHT_GUI_FRAME_PARTY_HEIGHT           = '队友窗体高度 (%d)';
CHHT_GUI_FRAME_PET_HEIGHT             = '宠物窗体高度 (%d)';
CHHT_GUI_FRAME_PARTYPET_HEIGHT        = '队友 Pet窗体高度(%d)';
CHHT_GUI_FRAME_EXTRA_SCALE            = '扩展框体缩放 (%d%%)';
CHHT_GUI_FRAME_PANIC_SCALE            = 'Panic 框体缩放 (%d%%)';
CHHT_GUI_FRAME_PLAYER_SCALE           = '玩家 框体缩放 (%d%%)';
CHHT_GUI_FRAME_PARTY_SCALE            = '队友 框体缩放 (%d%%)';
CHHT_GUI_FRAME_PET_SCALE              = '宠物 框体缩放 (%d%%)';
CHHT_GUI_FRAME_PARTYPET_SCALE         = '队友 Pet 框体缩放 (%d%%)';
CHHT_GUI_TARGET_FRAMES                = '目标框体';
CHHT_GUI_SHOW_TARGETS                 = "显示目标";
CHHT_GUI_FRAME_PLAYER_TARGET_WIDTH    = '玩家目标窗体宽度 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_WIDTH     = '队友目标窗体宽度 (%d)';
CHHT_GUI_FRAME_PET_TARGET_WIDTH       = '宠物目标窗体宽度 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_WIDTH  = '队友 Pet目标窗体宽度 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_HEIGHT   = '玩家目标窗体高度 (%d)';
CHHT_GUI_FRAME_PARTY_TARGET_HEIGHT    = '队友目标窗体高度 (%d)';
CHHT_GUI_FRAME_PET_TARGET_HEIGHT      = '宠物目标窗体高度 (%d)';
CHHT_GUI_FRAME_PARTYPET_TARGET_HEIGHT = '队友 Pet目标窗体高度 (%d)';
CHHT_GUI_FRAME_PLAYER_TARGET_SCALE    = '玩家目标框体缩放 (%d%%)';
CHHT_GUI_FRAME_PARTY_TARGET_SCALE     = '队友目标框体缩放 (%d%%)';
CHHT_GUI_FRAME_PET_TARGET_SCALE       = '宠物目标框体缩放 (%d%%)';
CHHT_GUI_FRAME_PARTYPET_TARGET_SCALE  = '队友 Pet目标框体缩放 (%d%%)';
CHHT_GUI_TOOLTIPS                     = '提示信息';
CHHT_GUI_SHOW_GAME_TOOLTIPS           = "显示游戏提示信息";
CHHT_GUI_SHOW_GAME_TOOLTIPS_LOCATION  = "Location of game tooltips";
CHHT_GUI_SHOW_ACTION_TOOLTIPS         = "显示法术/行为指定提示信息";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK       = "在提示信息中显示法书级别";
CHHT_GUI_TOOLTIP_SHOW_SPELLRANK_MAX   = "显示使用最高级别法书的提示";
CHHT_GUI_PAGE1                        = "其他";
CHHT_GUI_PAGE2                        = "主体框体";
CHHT_GUI_PAGE3                        = "目标框体";
CHHT_GUI_PAGE4                        = "提示信息";
CHHT_GUI_PAGE5                        = "Anchors";
CHHT_GUI_FRAME_GROUP_MODE_ALL         = '分组所有';
CHHT_GUI_FRAME_GROUP_MODE_GROUP       = '组队';
CHHT_GUI_TARGET_COLOR_NEVER           = '从不';
CHHT_GUI_TARGET_COLOR_PLAYER          = '玩家';
CHHT_GUI_TARGET_COLOR_ALWAYS          = '总是';
CHHT_GUI_TARGET_DEBUFF_NONE           = '无';
CHHT_GUI_TARGET_DEBUFF_CASTABLE       = '可施法的';
CHHT_GUI_TARGET_DEBUFF_ENEMY_CASTABLE = '可施法敌人';
CHHT_GUI_TARGET_DEBUFF_ENEMY_ALL      = '敌人所有';
CHHT_GUI_TARGET_DEBUFF_ALL            = '所有';
CHHT_GUI_FRAME_ALIGN_LEFT             = '左';
CHHT_GUI_FRAME_ALIGN_CENTER           = '中';
CHHT_GUI_FRAME_ALIGN_RIGHT            = '右';
CHHT_GUI_DOCK_TARGET_NONE             = '无';
CHHT_GUI_DOCK_TARGET_RIGHT            = '右';
CHHT_GUI_DOCK_TARGET_LEFT             = '左';
CHHT_GUI_UNIT_TOOLTIP_ALWAYS          = '总是';
CHHT_GUI_UNIT_TOOLTIP_NEVER           = '从不';
CHHT_GUI_UNIT_TOOLTIP_SHIFT           = 'Shift';
CHHT_GUI_UNIT_TOOLTIP_CTRL            = 'Control';
CHHT_GUI_UNIT_TOOLTIP_ALT             = 'Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRL       = 'Shift-Ctrl';
CHHT_GUI_UNIT_TOOLTIP_SHIFTALT        = 'Shift-Alt';
CHHT_GUI_UNIT_TOOLTIP_CTRLALT         = 'Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_SHIFTCTRLALT    = 'Shift-Ctrl-Alt';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_MAIN   = 'ClickHeal Frames';
CHHT_GUI_UNIT_TOOLTIP_LOCATION_WOW    = 'Standard WoW';
CHHT_GUI_ACTION_TOOLTIP_ALWAYS        = '总是';
CHHT_GUI_ACTION_TOOLTIP_NEVER         = '冲';
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
CHHT_EXTENDED_TOOLTIP_ORIENTATION_HIDE           = '不显示';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_LEFT           = '左';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_TOP            = '顶部';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_RIGHT          = '右';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_BOTTOM         = '底部';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_MAIN           = '主框体';
CHHT_EXTENDED_TOOLTIP_ORIENTATION_WOW            = 'Standard WoW';
CHHT_EXTENDED_RAID_GROUPS                        = '团队';
CHHT_EXTENDED_RAID_GROUP1                        = "团队 1";
CHHT_EXTENDED_RAID_GROUP2                        = "团队 2";
CHHT_EXTENDED_RAID_GROUP3                        = "团队 3";
CHHT_EXTENDED_RAID_GROUP4                        = "团队 4";
CHHT_EXTENDED_RAID_GROUP5                        = "团队 5";
CHHT_EXTENDED_RAID_GROUP6                        = "团队 6";
CHHT_EXTENDED_RAID_GROUP7                        = "团队 7";
CHHT_EXTENDED_RAID_GROUP8                        = "团队 8";
CHHT_EXTENDED_RAID_CLASSES                       = '团队职业';
CHHT_EXTENDED_RAID_PETS                          = "团队宠物";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL            = "每 %d 秒扫描团队宠物 ";
CHHT_EXTENDED_RAID_PETS_SCAN_INTERVAL_MAX        = "秒 (%s)";
CHHT_EXTENDED_RAID_GROUP_FRAME_WIDTH             = '团队框体宽度 (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_HEIGHT            = '团队框体高度 (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_WIDTH             = '团队职业框体宽度 (%d)';
CHHT_EXTENDED_RAID_CLASS_FRAME_HEIGHT            = '团队职业框体高度 (%d)';
CHHT_EXTENDED_RAID_GROUP_FRAME_SCALE             = '团队框体缩放 (%d%%)';
CHHT_EXTENDED_RAID_CLASS_FRAME_SCALE             = '团队职业框体缩放 (%d%%)';
CHHT_EXTENDED_RAID_HIDE_PARTY_HIDE               = 'Hide Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_SHOW               = 'Show Party';
CHHT_EXTENDED_RAID_HIDE_PARTY_WOW                = 'Use WoW setting';
CHHT_EXTENDED_RAID_HIDE_PARTY_IN_RAID            = 'Hide party in raid';
CHHT_EXTENDED_RAID_TOOLTIP_ORIENTATION           = "团队成员提示信息方向";
CHHT_EXTENDED_RAID                               = '团队';
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
CHHT_FRIEND_OPTIONS                = '友好设置';
CHHT_FRIEND_HITPOINT_LABEL         = "队友/团队成员标记为";
CHHT_FRIEND_FRAME_BACKGROUND       = "自己/队友 框体背景";
CHHT_FRIEND_FRAME_BACKGROUND_ALPHA = 'Opacity (%3.2f)';
CHHT_FRIEND_PICK_COLOR             = 'Pick Color';
CHHT_FRIEND_RESURRECT              = "复活死亡队友";
CHHT_FRIEND_ADJUST_SPELLRANK       = "根据目标等级调整施法等级";
CHHT_FRIEND_SHOW_MANA              = "显示法力";
CHHT_FRIEND_SHOW_RAGE              = "显示怒气";
CHHT_FRIEND_SHOW_ENERGY            = "显示能量";
CHHT_FRIEND_SHOW_FOCUS             = "显示集中(Pets)";
CHHT_FRIEND_SHADOWFORM             = "开关暗影形态/幽魂狼/Stealth";
CHHT_FRIEND_CAST_ON_CHARMED        = "Cast offensive spells on charmed friend";
CHHT_FRIEND_MOUSE_TITLE            = '友军行为';
CHHT_FRIEND_PAGE1                  = "选项";
CHHT_FRIEND_PAGE2                  = "鼠标 1/3";
CHHT_FRIEND_PAGE3                  = "鼠标 2/3";
CHHT_FRIEND_PAGE4                  = "鼠标 3/3";
CHHT_FRIEND_HP_LABEL_PERCENT       = '百分比';
CHHT_FRIEND_HP_LABEL_PERCENT_SIGN  = '带标记的百分比';
CHHT_FRIEND_HP_LABEL_CURRENT       = '当前生命值';
CHHT_FRIEND_HP_LABEL_MISSING       = '损失生命值';
CHHT_FRIEND_HP_LABEL_NONE          = 'do not label';
CHHT_FRIEND_FRAME_BACKGROUND_HEALTH= '彩色生命值';
CHHT_FRIEND_FRAME_BACKGROUND_CLASS = '职业色彩';
CHHT_FRIEND_FRAME_BACKGROUND_CUSTOM= 'Custom';
CHHT_FRIEND_PARTY_LABEL_CLASS      = '职业';
CHHT_FRIEND_PARTY_LABEL_NAME       = '名字';
CHHT_FRIEND_PARTY_LABEL_BOTH       = '职业-名字';
CHHT_FRIEND_PARTY_LABEL_COLOR      = '彩色名字';
CHHT_FRIEND_PARTY_LABEL_BOTHCOLOR  = 'Class-Name Color';
CHHT_FRIEND_FRIEND_DEBUFF_NONE     = '无';
CHHT_FRIEND_FRIEND_DEBUFF_CURABLE  = '可治愈的';
CHHT_FRIEND_FRIEND_DEBUFF_ALL      = '所有';
CHHT_FRIEND_RESURRECT_AFTER_COMBAT = '在战斗之后';
CHHT_FRIEND_RESURRECT_ALWAYS       = '总是';
CHHT_FRIEND_RESURRECT_NEVER        = '从不';
CHHT_FRIEND_POWER_WORD_SHIELD      = '不要施放 真言：盾 当已经存在时';
CHHT_FRIEND_RENEW                  = '不要施放 恢复 当已经存在时';
CHHT_FRIEND_REGROWTH               = '不要施放 愈合 当已经存在时';
CHHT_FRIEND_REJUVENATION           = '不要施放 回春术 当已经存在时';
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
CHHT_TARGET_TARGETING          = "目标获得方式";
CHHT_TARGET_PLAYER_TARGET      = "玩家目标";
CHHT_TARGET_PARTY1_TARGET      = "队友 1目标";
CHHT_TARGET_PARTY2_TARGET      = "队友 2目标";
CHHT_TARGET_PARTY3_TARGET      = "队友 3目标";
CHHT_TARGET_PARTY4_TARGET      = "队友 4目标";
CHHT_TARGET_PET_TARGET         = "宠物目标";
CHHT_TARGET_PARTYPET1_TARGET   = "队友 宠物 1目标";
CHHT_TARGET_PARTYPET2_TARGET   = "队友 宠物 2目标";
CHHT_TARGET_PARTYPET3_TARGET   = "队友 宠物 3目标";
CHHT_TARGET_PARTYPET4_TARGET   = "队友 宠物 4目标";
CHHT_TARGET_OPTIONS            = '敌人设置';
CHHT_TARGET_SHOW_LEVEL_DIFF    = "显示 级别差异";
CHHT_TARGET_SHOW_MANA          = "显示 法力";
CHHT_TARGET_SHOW_RAGE          = "显示 怒气";
CHHT_TARGET_SHOW_ENERGY        = "显示 能量";
CHHT_TARGET_SHOW_FOCUS         = "显示 集中 (宠物)";
CHHT_TARGET_CAST_ON_CHARMED    = "Cast beneficial spells on charmed enemy";
CHHT_TARGET_MOUSE_TITLE        = '敌人行为';
CHHT_TARGET_COLORS             = '彩色';
CHHT_TARGET_PAGE1              = "选项";
CHHT_TARGET_PAGE2              = "鼠标 1/3";
CHHT_TARGET_PAGE3              = "鼠标 2/3";
CHHT_TARGET_PAGE4              = "鼠标 3/3";
CHHT_TARGET_GROUP_LABEL_FORMAT = "分组 %d";
CHHT_TARGET_TARGETING_KEEP     = '保持当前目标';
CHHT_TARGET_TARGETING_TARGET   = '选择法术目标作为目标';
CHHT_TARGET_TARGETING_INT      = '职能选择';
CHHT_COLOR_GROUP_LABEL_FORMAT  = '彩色分组 %s';

-- ---------- PANIC ------------------------------------------------------------------
CHHT_PANIC_OPTIONS                     = 'Panic 选项';
CHHT_PANIC_NO_BATTLEFIELD              = 'Outside Battlefield';
CHHT_PANIC_IN_BATTLEFIELD              = 'In Battlefield';
CHHT_PANIC_CURE_UNITS                  = "使用 'PANIC' 治料";
CHHT_PANIC_UNMAPPED                    = "当按键未设置时使用 'PANIC' ";
CHHT_PANIC_CHECK_RANGE                 = "Do range checks";
CHHT_PANIC_SPELL_DOWNGRADE             = "Enable overheal minimization";
CHHT_PANIC_COMBAT_HEALING_IN_BATTLEFIELD="Always use combat healing";
CHHT_PANIC_MOUSE_TITLE                 = 'Panic 动作';
CHHT_PANIC_BEHAVIOR                    = 'Panic Behavior';
CHHT_PANIC_BEHAVIOR_LABEL              = "Panic behavior template";
CHHT_PANIC_BEHAVIOR_SPELL_TITLE_FORMAT = "Spell %d";
CHHT_PANIC_BEHAVIOR_FORCE_CAST         = "force cast";
CHHT_PANIC_BEHAVIOR_CLASSES            = 'Classes';
CHHT_PANIC_BEHAVIOR_EMERGENCY_LEVELS   = 'Emergency Levels';
CHHT_PANIC_BEHAVIOR_SPELL_EDIT         = 'Spell Configuration';
CHHT_PANIC_PAGE1                       = "选项";
CHHT_PANIC_PAGE2                       = "Behavior";
CHHT_PANIC_PAGE3                       = "鼠标 1/3";
CHHT_PANIC_PAGE4                       = "鼠标 2/3";
CHHT_PANIC_PAGE5                       = "鼠标 3/3";
CHHT_PANIC_TITLE_HEAL                  = 'PANIC: 治疗';
CHHT_PANIC_TITLE_BUFF                  = 'PANIC: 增益魔法';
CHHT_PANIC_TITLE_FULL                  = 'Full spell range';
CHHT_PANIC_TITLE_TRASH                 = 'Trash healing';
CHHT_PANIC_TITLE_BATTLEFIELD           = 'Battlefield';
CHHT_PANIC_TITLE_CUSTOM1               = 'Custom 1';
CHHT_PANIC_TITLE_CUSTOM2               = 'Custom 2';
CHHT_PANIC_TITLE_CUSTOM3               = 'Custom 3';

-- ---------- EXTRA ------------------------------------------------------------------
CHHT_EXTRA_LABEL         = "标签";
CHHT_EXTRA_SHOW_COOLDOWN = "显示冷却时间";
CHHT_EXTRA_OPTIONS       = 'Extra 选项';
CHHT_EXTRA_HIDE_BUTTON   = "隐藏按钮";
CHHT_EXTRA_PAGE1         = "选项";
CHHT_EXTRA_PAGE2         = "鼠标 1/3";
CHHT_EXTRA_PAGE3         = "鼠标 2/3";
CHHT_EXTRA_PAGE4         = "鼠标 3/3";
CHHT_EXTRA_LABEL_FORMAT  = '扩展 %d';
CHHT_EXTRA_TITLE_FORMAT  = '扩展 %d 按钮';

-- ---------- CHAINS -----------------------------------------------------------------
CHHT_CHAINS_BUTTON_ASSIGNMENT = '按钮分配';
CHHT_CHAINS_CHAIN1            = "链 1";
CHHT_CHAINS_CHAIN2            = "链 2";
CHHT_CHAINS_CHAIN3            = "链 3";
CHHT_CHAINS_CHAIN4            = "链 4";
CHHT_CHAINS_NAME_FORMAT       = "链 %d";
CHHT_CHAINS_TITLE_FORMAT      = '链 %d 设置';

-- ---------- BUFFS ------------------------------------------------------------------
CHHT_BUFF_TITLE              = '增益选项';
CHHT_BUFF_EXPIRE_PLAY_SOUND  = "播放声音当增益过期后";
CHHT_BUFF_EXPIRE_SHOW_MSG    = "显示信息当增益过期后";
CHHT_BUFF_WARN_PLAY_SOUND    = "播放声音 当将要增益过期时";
CHHT_BUFF_WARN_SHOW_MSG      = "显示信息当将要增益过期时";
CHHT_BUFF_SHOW_TRACKING_BUFF = "显示追踪buff的缺少(寻找草药,人形追踪等 ...)";
CHHT_BUFF_SHOW_RAID_EFFECTS  = "显示团队成员buff效果 (缺少buffs,激活debuffs)";
CHHT_BUFF_COMBINE_IN_PANIC   = "组合缺少buff信息在PANIC框体中";
CHHT_BUFF_AVAILABLE_BUFFS    = '可用的增益';
CHHT_BUFF_ALLOWED_CLASSES    = '允许的职业';
CHHT_BUFF_ALLOWED_UNITS      = '允许的对象';
CHHT_BUFF_BUFF_DATA          = '增益数据';
CHHT_BUFF_UPGRADE_Q          = "释放 #PARTYSPELLNAME# 当至少有 (n) #PARTYSPELLSPEC# 队友需要";
CHHT_BUFF_UPGRADE_MSG        = "Upgrade unit spell";
CHHT_BUFF_IN_BATTLEFIELD     = "Cast in Battlefield";
CHHT_BUFF_PAGE1              = "选项";
CHHT_BUFF_PAGE2              = "增益列表";
CHHT_BUFFS_NEVER_WARN        = "从不提醒";
CHHT_BUFFS_ALWAYS_WARN       = "总是提醒";
CHHT_BUFFS_WARN_EXPIRE_TITLE = "在过期之前提醒 %s ";
CHHT_BUFFS_NEVER_REFRESH     = "从不刷新";
CHHT_BUFFS_ALWAYS_REFRESH    = "总是刷新";
CHHT_BUFFS_REFRESH_TITLE     = "在过期之前刷新 %s";

-- ---------- TOTEMSET ---------------------------------------------------------------
CHHT_TOTEMSET_LABEL_FORMAT            = "图腾设置 %d";
CHHT_TOTEMSET_RESET_TIME_TITLE_FORMAT = "重置时间 (%s)";
CHHT_TOTEMSET_SLIDER_TITLE_FORMAT     = "%d秒";

end
