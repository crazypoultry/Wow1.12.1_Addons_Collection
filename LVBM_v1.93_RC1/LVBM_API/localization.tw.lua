-- -------------------------------------------- --
-- La Vendetta Boss Mods - english localization --
--          by Destiny|Tandanu                  --
-- -------------------------------------------- --

if (GetLocale() == "zhTW") then

--classes
LVBM_MAGE           = "法師";
LVBM_PRIEST         = "牧師";
LVBM_PALADIN        = "聖騎士";
LVBM_DRUID          = "德魯伊";
LVBM_WARLOCK        = "術士";
LVBM_ROGUE          = "盜賊";
LVBM_HUNTER         = "獵人";
LVBM_WARRIOR        = "戰士";
LVBM_SHAMAN         = "薩滿";

--zones
LVBM_NAXX           = "納克薩瑪斯";
LVBM_AQ40           = "安其拉";
LVBM_BWL            = "黑翼之巢";
LVBM_MC             = "熔火之心";
LVBM_AQ20           = "安其拉廢墟";
LVBM_ZG             = "祖爾格拉布";
LVBM_ONYXIAS_LAIR   = "奧妮克希亞的巢穴";
LVBM_DUSKWOOD       = "暮色森林";
LVBM_ASHENVALE      = "梣谷";
LVBM_FERALAS        = "菲拉斯";
LVBM_HINTERLANDS    = "辛特蘭";
LVBM_BLASTED_LANDS  = "詛咒之地";
LVBM_AZSHARA        = "艾薩拉";
LVBM_OTHER          = "其他";

--spells/buffs
LVBM_CHARGE         = "衝鋒";
LVBM_FERALCHARGE    = "野性衝鋒";
LVBM_BLOODRAGE      = "血性狂暴";
LVBM_REDEMPTION     = "救贖之魂";
LVBM_FEIGNDEATH     = "假死";
LVBM_MINDCONTROL    = "精神控制";

--create status bar timer localization table
LVBM_SBT = {};

--key bindings
BINDING_HEADER_LVBM     = "La Vendetta Boss Mods";
BINDING_NAME_TOGGLE     = "打開圖形界面";

--OnLoad messages
LVBM_LOADED             = "La Vendetta Boss Mods v%s 版 La Vendetta。";
LVBM_MODS_LOADED        = "%s %s Bossmod 已載入"

--Slash command messages
LVBM_MOD_ENABLED        = "Bossmod打開";
LVBM_MOD_DISABLED       = "Bossmod關閉";
LVBM_ANNOUNCE_ENABLED   = "廣播打開";
LVBM_ANNOUNCE_DISABLED  = "廣播關閉";
LVBM_MOD_STOPPED        = "計時停止";
LVBM_MOD_INFO           = "Bossmod v%s 版 %s";
LVBM_SLASH_HELP1        = " on/off";
LVBM_SLASH_HELP2        = " 廣播 on/off";
LVBM_SLASH_HELP3        = " 停止";
LVBM_SLASH_HELP4        = "你可以使用 %s 替代 /%s";
LVBM_RANGE_CHECK        = "超過30碼外： ";
LVBM_FOUND_CLIENTS      = "發現 %s 個玩家使用 Vendetta Boss Mods";

--Sync options
LVBM_SOMEONE_SET_SYNC_CHANNEL   = "%s 設置同步頻道為: %s";
LVBM_SET_SYNC_CHANNEL           = "同步頻道設為: %s";
LVBM_CHANNEL_NOT_SET            = "未設置頻道，無法廣播。";
LVBM_NEED_LEADER                = "你必須為助理或團長才能廣播頻道！";
LVBM_NEED_LEADER_STOP_ALL       = "你必須為助理或團長才能使用此功能！";
LVBM_ALL_STOPPED                = "所有計時停止。";
LVBM_REC_STOP_ALL               = "停止接收來自 %s 的所有命令。";

--Update dialog
LVBM_UPDATE_DIALOG              = "你的 La Vendetta Bossmod 已經過期!\n%s 和 %s 有版本 %s.\n請參觀 www.curse-gaming.com 以取得最新版本.";
LVBM_YOUR_VERSION_SUCKS         = "你的 La Vendetta Bossmod 已經過期! 請參觀 www.curse-gaming.com 以取得最新版本.";
LVBM_REQ_PATCHNOTES             = "向 %s 請求更新記錄...請稍待.";
LVBM_SHOW_PATCHNOTES            = "顯示更新記錄";
LVBM_PATCHNOTES                 = "更新記錄";
LVBM_COPY_PASTE_URL             = "複製與貼上網址";
LVBM_COPY_PASTE_NOW             = "按下 ctrl-c 複製網址到剪貼簿"

--Status Bar Timers
LVBM_SBT_TIMELEFT               = "剩餘時間:"
LVBM_SBT_TIMEELAPSED            = "已用時間:"
LVBM_SBT_TOTALTIME              = "總時間:"
LVBM_SBT_REPETITIONS            = "循環:";
LVBM_SBT_INFINITE               = "無限";
LVBM_SBT_BOSSMOD                = "Boss mod:"
LVBM_SBT_STARTEDBY              = "開始於:"
LVBM_SBT_RIGHTCLICK             = "在控制條上右鍵點擊以隱藏它.";
LVBM_SBT_LEFTCLICK              = "Shift + 左鍵點擊控制條以廣播它";
LVBM_TIMER_IS_ABOUT_TO_EXPIRE   = "計時器 \"%s\" 快要過期了!";
LVBM_BAR_STYLE_DEFAULT          = "預設";
LVBM_BAR_STYLE_MODERN           = "現代";
LVBM_BAR_STYLE_CLOUDS           = "朦朧";
LVBM_BAR_STYLE_PERL             = "Perl";


--Combat messages
LVBM_BOSS_ENGAGED               = "%s 開戰. 祝好運與盡興! :)";
LVBM_BOSS_SYNCED_BY             = "(從 %s 接收同步訊息)";
LVBM_BOSS_DOWN                  = "%s 倒地, 經過 %s!";
LVBM_COMBAT_ENDED               = "戰鬥經過 %s 結束.";
LVBM_DEFAULT_BUSY_MSG           = "%P 正在忙碌. (Fighting against %B - %HP - %ALIVE/%RAID people alive) You will be informed after the fight.";
LVBM_RAID_STATUS_WHISPER        = "%B - %HP - %ALIVE/%RAID people alive.";
LVBM_SEND_STATUS_INFO           = "Whisper \"status\" to query the raid's status.";
LVBM_AUTO_RESPOND_SHORT         = "已自動回應.";
LVBM_AUTO_RESPOND_LONG          = "已自動回應 %s 的密語.";
LVBM_MISSED_WHISPERS            = "在戰鬥中沒有看到的密語:";
LVBM_SHOW_MISSED_WHISPER        = "|Hplayer:%1\$s|h[%1\$s]|h: %2\$s";
LVBM_BALCONY_PHASE              = "Balcony phase #%s";

--Misc stuff
LVBM_YOU                        = "你";
LVBM_ARE                        = "了";
LVBM_IS                         = "受到";
LVBM_OR                         = "或";
LVBM_AND                        = "和";
LVBM_UNKNOWN                    = "未知";
LVBM_LOCAL                      = "本地";
LVBM_DEFAULT_DESCRIPTION        = "無描述.";
LVBM_SEC                        = "秒";
LVBM_MIN                        = "分";
LVBM_SECOND                     = "秒";
LVBM_SECONDS                    = "秒";
LVBM_MINUTES                    = "分鐘";
LVBM_MINUTE                     = "分鐘";
LVBM_HIT                        = "命中";
LVBM_HITS                       = "擊中";
LVBM_CRIT                       = "致命一擊";
LVBM_CRITS                      = "致命";
LVBM_MISS                       = "未命中";
LVBM_DODGE                      = "閃躲";
LVBM_PARRY                      = "招架";
LVBM_FROST                      = "冰霜";
LVBM_ARCANE                     = "祕法";
LVBM_FIRE                       = "火焰";
LVBM_HOLY                       = "神聖";
LVBM_NATURE                     = "自然";
LVBM_SHADOW                     = "暗影";
LVBM_CLOSE                      = "關閉";
LVBM_AGGRO_FROM                 = "盯上你了！";
LVBM_SET_ICON                   = "設定圖示";
LVBM_SEND_WHISPER               = "發送密語";
LVBM_DEAD                       = "死亡";
LVBM_OFFLINE                    = "離線";
LVBM_PHASE                      = "階段 %s";
LVBM_WAVE                       = "第 %s 波";

end