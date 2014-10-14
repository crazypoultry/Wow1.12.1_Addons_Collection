---------------------------------------------------
-- La Vendetta BossMods GUI Language File        --
-- GUI by LV|Nitram                              --
--                                               --
-- Translations by:                              --
--   LV|Nitram  -> EN                            --
--   LV|Tandanu -> DE                            --
--   LV|Tandanu -> fixed typos                   --
---------------------------------------------------

------------------------------------
-- Translation by Default -> zhTW --
------------------------------------

if (GetLocale() == "zhTW") then

-- LVBM_GUI.lua for Bossmod List Frame (LVBMBossModListFrame)
LVBMGUI_TAB_1_TITLE_TEXT        = "納克薩瑪斯";
LVBMGUI_TAB_2_TITLE_TEXT        = "安其拉";
LVBMGUI_TAB_3_TITLE_TEXT        = "黑翼之巢";
LVBMGUI_TAB_4_TITLE_TEXT        = "熔火之心";
LVBMGUI_TAB_5_TITLE_TEXT        = "祖爾格拉布與安其拉廢墟";
LVBMGUI_TAB_6_TITLE_TEXT        = "其他";

-- Tooltips
LVBMGUI_FRAMETAB_1_TT           = "納克薩瑪斯首領模組";
LVBMGUI_FRAMETAB_1_TD           = "我們的納克薩瑪斯首領模組合集. 選擇一個戰役以取得額外的選項.";
LVBMGUI_FRAMETAB_2_TT           = "安其拉首領模組";
LVBMGUI_FRAMETAB_2_TD           = "我們的安其拉首領模組合集. 選擇一個戰役以取得額外的選項.";
LVBMGUI_FRAMETAB_3_TT           = "黑翼之巢首領模組";
LVBMGUI_FRAMETAB_3_TD           = "我們的黑翼之巢首領模組合集. 選擇一個戰役以取得額外的選項.";
LVBMGUI_FRAMETAB_4_TT           = "熔火之心首領模組";
LVBMGUI_FRAMETAB_4_TD           = "我們的熔火之心首領模組合集. 選擇一個戰役以取得額外的選項.";
LVBMGUI_FRAMETAB_5_TT           = "祖爾格拉布與安其拉廢墟首領模組";
LVBMGUI_FRAMETAB_5_TD           = "我們的祖爾格拉布與安其拉廢墟首領模組合集. 選擇一個戰役以取得額外的選項.";

LVBMGUI_DISABLE_ADDON           = "關閉插件";
LVBMGUI_ENABLE_ADDON            = "打開插件";
LVBMGUI_STOP_ADDON              = "停止插件";
LVBMGUI_DISABLE_ANNOUNCE        = "關閉廣播";
LVBMGUI_ENABLE_ANNOUNCE         = "打開廣播";
LVBMGUI_SHOW_DROPDOWNMENU       = "額外選項";
LVBMGUI_DROPDOWNMENU_TITLE      = "Bossmod";

-- LVBMBossModFrame
LVBMGUI_HIDE_OPTIONS            = "<<< 選項";
LVBMGUI_SHOW_OPTIONS            = "選項 >>>";

-- Options Frame (LVBMOptionsFrame)
LVBMGUI_OPTIONS                 = "選項 (GUI v"..LVBMGUI_VERSION.." / Boss Mod v"..LVBM.Version..")";
LVBMGUI_SIDEFRAME_TAB1          = "一般";
LVBMGUI_SIDEFRAME_TAB2          = "計時條";
LVBMGUI_SIDEFRAME_TAB3          = "警告";
LVBMGUI_SIDEFRAME_TAB4          = "特殊";

-- LVBMOptionsFramePage1
LVBMGUI_TITLE_SYNCSETTINGS              = "同步設定";
LVBMGUI_TITLE_MINIMAPBUTTON             = "小地圖按鈕設定";
LVBMGUI_TITLE_AGGROALERT                = "目標警告設定";
LVBMGUI_CHECKBOX_SYNC_ENABLE            = "開啟同步";
LVBMGUI_BUTTON_VERSION_CHECK            = "版本檢查";
LVBMGUI_BUTTON_VERSION_CHECK_FAILD      = "無其他 LVBM 使用者";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO       = "狀態條同步信息";
LVBMGUI_BUTTON_STATUSBAR_SYNCINFO_FAILD = "無狀態條";
LVBMGUI_SLIDER_MINIMAP_1                = "位置";
LVBMGUI_SLIDER_MINIMAP_2                = "半徑";
LVBMGUI_CHECKBOX_MINIMAP                = "顯示小地圖按鈕";
LVBMGUI_CHECKBOX_AGGROALERT_ENABLE      = "開啟目標警告";
LVBMGUI_BUTTON_AGGROALERT_TEST          = "測試目標警告";
LVBMGUI_BUTTON_AGGROALERT_RESET         = "重置設定";
LVBMGUI_BUTTON_AGGROALERT_RESET_DONE    = "目標警告已重置";
LVBMGUI_CHECKBOX_AGGROALERT_PLAYSOUND   = "目標轉向你時播放音效";
LVBMGUI_CHECKBOX_AGGROALERT_FLASH       = "目標轉向你時閃光";
LVBMGUI_CHECKBOX_AGGROALERT_SHAKE       = "目標轉向你時震動";
LVBMGUI_CHECKBOX_AGGROALERT_SPECIALTEXT = "顯示特殊警告信息";
LVBMGUI_CHECKBOX_AGGROALERT_LOCALWARNING = "顯示本地警告信息";
LVBMGUI_BUTTON_MOVEABLEBAR              = "改變計時條位置";
LVBMGUI_BUTTON_DEFAULTS                 = "預設值";

-- LVBMOptionsFramePage2
LVBMGUI_TITLE_STATUSBARS                = "狀態條計時設定";
LVBMGUI_TITLE_PIZZATIMER                = "創造 \"Pizza\" 計時器";
LVBMGUI_CHECKBOX_STATUSBAR_ENABLE       = "開啟狀態條";
LVBMGUI_CHECKBOX_STATUSBAR_FILLUP       = "填充狀態條";
LVBMGUI_CHECKBOX_STATUSBAR_FLIPOVER     = "翻轉狀態條";
LVBMGUI_EDITBOX_PIZZATIMER_TEXT         = "名稱";
LVBMGUI_EDITBOX_PIZZATIMER_MIN          = "分";
LVBMGUI_EDITBOX_PIZZATIMER_SEC          = "秒";
LVBMGUI_CHECKBOX_PIZZATIMER_BROADCAST   = "向團隊廣播計時";
LVBMGUI_BUTTON_PIZZATIMER_START         = "開始計時";

-- LVBMOptionsFramePage3
LVBMGUI_TITLE_RAIDWARNING               = "設定團隊警告";
LVBMGUI_TITLE_SELFWARNING               = "本定警告";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_1   = "團隊警告 (預設音效)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_2   = "敲鐘聲 (CT_Raid音效)";
LVBMGUI_DROPDOWN_RAIDWARNING_OPTION_3   = "取消警告音效";
LVBMGUI_DROPDOWN_RAIDWARNING_INFO_DISABLED  = "團隊警告音效已取消";
LVBMGUI_RAIDWARNING_EXAMPLE             = "*** 團隊警告範例 ***";
LVBMGUI_BUTTON_SOUND_TEST               = "測試音效";
LVBMGUI_BUTTON_SHOW_EXAMPLE             = "顯示範例";
LVBMGUI_BUTTON_RAIDWARNING_RESET        = "重置頁面";
LVBMGUI_BUTTON_RAIDWARNING_RESET_DONE   = "選項已重置為預設值";

-- LVBMOptionsFramePage4
LVBMGUI_TITLE_SPECIALWARNING            = "設定特殊警告";
LVBMGUI_TITLE_SHAKESCREEN               = "設定螢幕震動效果";
LVBMGUI_TITLE_FLASHEFFECT               = "設定閃光效果";
LVBMGUI_CHECKBOX_SPECWARNING_ENABLE     = "開啟特殊警告";
LVBMGUI_BUTTON_SPECWARNING_TEST         = "測試警告";
LVBMGUI_BUTTON_SPECWARNING_EXAMPLE      = "測試訊息 ^_^";
LVBMGUI_SLIDER_SPECWARNING_DURATION     = "持續時間";
LVBMGUI_SLIDER_SPECWARNING_FADETIME     = "消失時間";
LVBMGUI_SLIDER_SPECWARNING_TEXTSIZE     = "文字大小";
LVBMGUI_CHECKBOX_SHAKESCREEN_ENABLE     = "開啟螢幕震動效果";
LVBMGUI_BUTTON_SHAKESCREEN_TEST         = "測試震動";
LVBMGUI_SLIDER_SHAKESCREEN_DURATION     = "持續時間";
LVBMGUI_SLIDER_SHAKESCREEN_INTENSITY    = "強度";
LVBMGUI_CHECKBOX_FLASHEFFECT_ENABLE     = "打開閃光效果";
LVBMGUI_BUTTON_FLASHEFFECT_TEST         = "測試閃光";
LVBMGUI_SLIDER_FLASHEFFECT_DURATION     = "持續時間";
LVBMGUI_SLIDER_FLASHEFFECT_FLASHES      = "閃光次數";

-- LVBMOptionsFramePage5
LVBMGUI_ABOUTTITLE      = "關於";
LVBMGUI_ABOUTTEXT_1     = "LV Bossmods API (c) by Destiny Tandanu";
LVBMGUI_ABOUTTEXT_2     = "LV Bossmods GUI (c) by La Vendetta Nitram";
LVBMGUI_ABOUTTEXT_3     = " ";
LVBMGUI_ABOUTTEXT_4     = "感謝您使用這個插件.";
LVBMGUI_ABOUTTEXT_5     = " ";
LVBMGUI_ABOUTTEXT_6     = "                                拜訪";
LVBMGUI_ABOUTTEXT_7     = " ";
LVBMGUI_ABOUTTEXT_8     = "           www.deadlyminds.net";
LVBMGUI_ABOUTTEXT_9     = " ";
LVBMGUI_ABOUTTEXT_10    = "                                  或";
LVBMGUI_ABOUTTEXT_11    = " ";
LVBMGUI_ABOUTTEXT_12    = "           www.destiny-guild.de";
LVBMGUI_ABOUTTEXT_13    = " ";
LVBMGUI_ABOUTTEXT_14    = "                                以及";
LVBMGUI_ABOUTTEXT_15    = " ";
LVBMGUI_ABOUTTEXT_16    = "         www.curse-gaming.com";
LVBMGUI_ABOUTTEXT_17    = " ";
LVBMGUI_ABOUTTEXT_18    = "如果你有建議或是要回報錯誤, 可以到 www.curse-gaming.com 或是我們的論壇 www.deadlyminds.net 發表意見.";
LVBMGUI_ABOUTTEXT_19    = " ";
LVBMGUI_ABOUTTEXT_20    = " ";

-- Translations added v1.05
LVBMGUI_DISTANCE_FRAME_TITLE        = "距離";
LVBMGUI_DISTANCE_FRAME_TEXT         = "過近:";

LVBMGUI_INFOFRAME_TOOLTIP_TITLE     = "資訊框";
LVBMGUI_INFOFRAME_TOOLTIP_TEXT      = "右鍵拖曳移動\nShift + 右鍵隱藏";

LVBMGUI_STATUSBAR_WIDTH_SLIDER      = "條寬";
LVBMGUI_STATUSBAR_SCALE_SLIDER      = "條的縮放比";

LVBMGUI_BUTTON_RANGECHECK           = "距離檢查";
LVBMGUI_TOOLTIP_RANGECHECK_TITLE    = "距離檢查";
LVBMGUI_TOOLTIP_RANGECHECK_TEXT     = "檢查誰離你超過30碼";

LVBMGUI_BUTTON_DISTANCEFRAME        = "距離框";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TITLE = "距離框";
LVBMGUI_TOOLTIP_DISTANCEFRAME_TEXT  = "顯示或關閉距離檢查框。這是檢查誰離你太近(低於10碼)用的。打類似哈霍蘭或是克蘇恩之類的王會很有用。";

-- Translations added v1.10
LVBMGUI_SIDEFRAME_TAB5              = "其他";
LVBMGUI_SIDEFRAME_TAB6              = "關於";

LVBMGUI_SLIDER_STATUSBAR_COUNT          = "狀態條數量";
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_1     = "傳統設計"; --wird berflssig mit dem Verwenden des Namens aus der Tabelle
LVBMGUI_DROPDOWN_STATUSBAR_DESIGN_2     = "摩登款式";
LVBMGUI_DROPDOWN_STATUSBAR_EXAMPLE_BAR  = "範例狀態條";

LVBMGUI_TITLE_AUTORESPOND               = "自動回應設定";
LVBMGUI_CHECKBOX_AUTORESPOND_ENABLE     = "在boss戰中自動回應給密語者";
LVBMGUI_CHECKBOX_AUTORESPOND_SHOW_WHISPERS  = "在戰鬥期間顯示密語者";
LVBMGUI_CHECKBOX_AUTORESPOND_INFORM_USER    = "自動回密語時通知我";
LVBMGUI_CHECKBOX_AUTORESPOND_HIDE_REPLY     = "隱藏自動回密";

LVBMGUI_EDITBOX_AUTORESPOND_TITLE           = "在boss戰中密語傳送設定";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_HEADER  = "以下的字串將\n被自動置換：";
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT1   = {"%P", "你的名字"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT2   = {"%B", "boss名字"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT3   = {"%HP", "boss hp"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT4   = {"%ALIVE", "存活的團隊成員"};
LVBMGUI_EDITBOX_AUTORESPOND_TOOLTIP_TEXT5   = {"%RAID", "團隊成員"};

-- Translations added v1.15
LVBMGUI_CHECKBOX_ALLOW_STATUS_COMMAND       = "允許使用者取得目前戰況 (密 \"status\" 取得)";
LVBMGUI_CHECKBOX_SHOWCOMBATINFO             = "顯示戰鬥資訊, 例如戰鬥長度";
LVBMGUI_TITLE_COMBATSYSTEM                  = "戰鬥偵測系統";
LVBMGUI_BUTTON_STATUSBAR_FLASHONEND         = "當時間結束時閃爍狀態條";
LVBMGUI_BUTTON_STATUSBAR_AUTOCOLORBARS      = "動態改變狀態條顏色";

-- Translations added v1.20
LVBMGUI_TITLE_RAIDOPTIONS                   = "團隊選項";
LVBMGUI_CHECKBOX_HIDEPLAYERNAMESINRAIDS     = "當加入團隊時隱藏玩家的名字";
LVBMGUI_CHECKBOX_ALLOWSYNCFROMOLDCLIENT     = "允許與舊的客戶端同步";

-- Translation added v1.25
LVBMGUI_CHECKBOX_ENABLE_RAIDWARNINGFRAME	= "開啟團隊警告框";
LVBMGUI_CHECKBOX_ENABLE_SELFWARNINGFRAME	= "開啟自我警告框";


end
