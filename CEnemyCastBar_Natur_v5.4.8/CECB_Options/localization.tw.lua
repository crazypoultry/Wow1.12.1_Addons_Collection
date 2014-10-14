--
-- CECB Options Chinese Traditional localization file
-- Maintained by: Kuraki, Suzuna
-- Last updated: 
-- Revision History:
--    09/01/2006  * Init
--    09/07/2006  * 5.1.7 zhTW support
--    09/26/2006  * 5.2.7 zhTW support
--    09/29/2006  * 5.3.0 zhTW support
--

if ( GetLocale() == "zhTW" ) then

-- Options Menue
CECB_status_txt = "啟用 EnemyCastBar";
CECB_pvp_txt = "啟用 |cffffffaaPvP/普通|r 施法條";
 CECB_globalpvp_txt = "即使沒有目標也顯示施法條";
 CECB_gains_txt = "顯示增益類法術";
  CECB_gainsonly_txt = "僅顯示增益類法術";
 CECB_cdown_txt = "啟用技能冷卻時間條";
  CECB_cdownshort_txt = "僅顯示冷卻時間較短的技能";
  CECB_usecddb_txt = "使用冷卻時間資料庫";
CECB_spellbreak_txt = "Raid 中停用法術中斷偵測";
CECB_pve_txt = "啟用|cffffffaaPvE/團隊|r 施法條";
 CECB_pvew_txt = "閃爍時發出聲音";
CECB_afflict_txt = "顯示 |cffffffaaDebuff";
 CECB_globalfrag_txt = "沒有目標也顯示怪物受到的影響";
 CECB_magecold_txt = "顯示冰凍及易傷效果";
 CECB_solod_txt = "顯示 '單挑Debuff' (暈眩技)";
  CECB_drtimer_txt = "考慮到 '遞減效應'";
  CECB_classdr_txt = "考慮到職業相關的遞減效應";
 CECB_sdots_txt = "觀看自己的持續傷害(DoT)";
 CECB_affuni_txt = "僅顯示副本首領的Debuff";
CECB_parsec_txt = "解析插件/團隊/隊伍頻道";
 CECB_broadcast_txt = "透過插件頻道廣播施法條";
CECB_targetm_txt = "左鍵點施法條時選取該目標";
CECB_timer_txt = "施法條旁顯示計時器";
CECB_tsize_txt = "施法條使用小字體";
CECB_flipb_txt = "反向排列施法條";
CECB_flashit_txt = "當施法計時將結束時閃爍";
CECB_showicon_txt = "施法條旁顯示圖示";
CECB_scale_txt = "縮放: ";
CECB_alpha_txt = "透明度: ";
CECB_numbars_txt = "最大施法條數: ";
CECB_space_txt = "圖示大小及施法條間距: ";
CECB_blength_txt = "施法條寬度 ";
CECB_minimap_txt = "小地圖圖示位置: ";
CECB_throttle_txt = "插件每秒更新次數: ";

CECB_status_tooltip = "啟用/關閉該插件, 並取消所有事件的監視以減低CPU的負載.";
CECB_pvp_tooltip = "啟用所有支援的普通法術施法條.";
 CECB_globalpvp_tooltip = "顯示所有在你戰鬥紀錄範圍內的PvP施法條, 而不僅是顯示你的實際目標.\n\n|cffff0000警告:|r 開啟這個選項可能會同時間出現非常多敵方及友方的的施法條!";
 CECB_gains_tooltip = "監視法術類型為'增益'的技能.\n例如 '寒冰護體', '嗜血'以及持續性治療法術(HoT).";
  CECB_gainsonly_tooltip = "僅顯示增益法術. 忽略其他的法術.";
 CECB_cdown_tooltip = "啟用冷卻時間計時器監視部分有施展時間或是增益類型的法術.";
  CECB_cdownshort_tooltip = "僅監視冷卻時間小於或等於60秒的技能.";
  CECB_usecddb_tooltip = "儲存所有在戰鬥紀錄範圍內的已知技能冷卻時間到資料庫中, 並動態觸發選定目標的適當技能冷卻時間, 包括剛剛偵測到的特殊冷卻時間.";
 CECB_spellbreak_tooltip = "Raid 中停用偵測 PvP(!) 法術中斷.\n這個選項可以增加效能及預防在 Raid 中偵測到不正確的法術中斷.";
CECB_pve_tooltip = "在PvE/Raid戰鬥中顯示施法條";
 CECB_pvew_tooltip = "當Raid施法條開始閃爍的時候以聲音提示.";
CECB_afflict_tooltip = "顯示Debuff, 比如 '(變形術)' 或 '斷筋'. 同時啟用多數Boss施放在玩家身上的Debuff, 比如. '燃燒刺激'.";
 CECB_globalfrag_tooltip = "顯示怪物受到影響的技能條,即使不是你的目標.\n\n'例如 '束縛亡靈', '放逐術', '變形術' 等.";
 CECB_magecold_tooltip = "顯示下列的寒冰效應:\n'冰霜新星', '霜寒刺骨', '冰凍', '冰錐術' 以及 '寒冰箭'.\n並顯示易傷效果 (寒冰, 火焰, 暗影).";
 CECB_solod_tooltip = "顯示多種眩暈效果. 也顯示沉默, 恐懼, 繳械和仇恨效果!";
  CECB_drtimer_tooltip = "顯示各種擊暈技能的'遞減效應'.\n包括3個戰士, 3個德魯伊, 1個聖騎士和1個盜賊擊暈技能.\n\n你會看到一個倒數20秒的計時條, 它將提示你什麼時候能夠再次獲得完全的擊暈時間.";
  CECB_classdr_tooltip = "考慮到職業特定的遞減效應, 像是'悶棍'和'變形術'.\n\n|cffff0000通常這些技能只能作用在玩家身上,|r同時野只會顯示於相符的職業.";
 CECB_sdots_tooltip = "顯示在你身上DoT的持續時間 (例: |cffffffff'腐蝕術' |r-|cffffffff '毒蛇釘刺'|r).\n假如DoT重新被施放, 在作用結束以前, 施法條將不會更新持續時間! |cffff0000\nAt best, renew the DoT at the very end of its duration or the timer becomes crazy!|r\n\nDoTs which additionally afflict instant damage will renew the CastBar and do not have this problem (e.g |cffffffff'Immolate'|r)!";
 CECB_affuni_tooltip = "關閉不是Raid中的所有Boss施放的Debuff.";
CECB_timer_tooltip = "在施法條右邊顯示倒計時的時間.";
CECB_targetm_tooltip = "滑鼠左鍵點擊施法條時選中該施法目標.";
CECB_parsec_tooltip = "如果下面任何一個命令在夾帶著時間參數出現在團隊/隊伍/插件頻道, 所有啟用這個選項的使用者畫面上將顯示一個施法條: '|cffffffff.countmin|r', '|cffffffff.countsec|r', '|cffffffff.repeat|r' 或 '|cffffffff.stopcount|r' (s. Help).\n\n例如:\n|cffffffff.countsec 45 Until Spawn|r\n\nInstead of:\n|cffffffff/cecb countsec 45 Until Spawn";
CECB_broadcast_tooltip = "團隊法術以及Debuff將會透過插件頻道廣播.\n只有當發送者與接收者使用同一種語言時才有效!\n\n|cffff0000注意:|r 只個選項應該只會在某些特定玩家組成的團隊中使用!\nPvP 法術將不會被傳送.";
CECB_tsize_tooltip = "縮小字體, 以便在施法條顯示更多訊息.";
CECB_flipb_tooltip = "改變施法條顯示方向.\n正常: 由下往上排列. 啟用: 由上往下排列.";
CECB_flashit_tooltip = "時間超過20秒的師法條會在時間剩下20%的時候開始閃爍.\n但是所有技能在最後十秒都將閃爍.";
CECB_showicon_tooltip = "在施法條旁顯示正確的圖示.\n\n大小會自動調整到合乎「圖示大小與施法條間距離」的設定.";
CECB_scale_tooltip = "設置施法條的顯示大小(30%-130%).";
CECB_alpha_tooltip = "設置施法條的透明度.";
CECB_numbars_tooltip = "設置顯示施法條的最大數目.";
CECB_space_tooltip = "設定施法條之間的距離.\n(預設為 20)";
CECB_blength_tooltip = "設定額外的施法條寬度.\n(標準為 0)";
CECB_minimap_tooltip = "在迷你地圖周圍移動NECB圖示. 移動到最左邊代表隱藏小圖示!";
CECB_throttle_tooltip = "設定施法條, 選單以及FPS顯示的更新速度.\n加快更新速度將會增加 CPU 的負擔!";
CECB_fps_tooltip = "開啟單獨的FPS監視條, 可自由移動.\n\n|cffff0000這個設置將不會被保存.";


CECB_menue_txt = "選項";
CECB_menuesub1_txt = "顯示的施法條類型?";
CECB_menuesub2_txt = "施法條外觀/其它";
CECB_menue_reset = "預設";
CECB_menue_help = "幫助";
CECB_menue_colors = "顏色";
CECB_menue_mbar = "移動施法條";
--CECB_menue_close = "關閉";
CECB_menue_rwarning = "|cffff0000警告!|r\n\n所有設置和定位都將被重置為預設值!!\n請確認是否真的要繼續?";
CECB_menue_ryes = "是";
CECB_menue_rno = "否!";
CECB_minimapoff_txt = "關閉";


end
