if (GetLocale() == "zhTW") then

-- 1. Kurinaxx
LVBM_KURINAXX_NAME              = "庫林納克斯";

-- 2. General Rajaxx
LVBM_RAJAXX_NAME                = "拉賈克斯將軍";
LVBM_RAJAXX_INFO                = "對每波襲擊及拉賈克斯將軍來襲發出警報";
LVBM_RAJAXX_WAVE1_EXPR          = "它們來了。儘量別被它們幹掉，新兵。";
LVBM_RAJAXX_WAVE3_EXPR          = "我們懲罰的時刻就在眼前！讓黑暗支配敵人的內心吧！";
LVBM_RAJAXX_WAVE4_EXPR          = "我們不需在被禁堵的門與石牆後等待了！我們的復仇將不再被否認！巨龍將在我們的憤怒之前顫抖！";
LVBM_RAJAXX_WAVE5_EXPR          = "恐懼是給敵人的！恐懼與死亡！";
LVBM_RAJAXX_WAVE6_EXPR          = "鹿盔將為了活命而啜泣、乞求，就像他的兒子一樣！一千年的不公將在今日結束！";
LVBM_RAJAXX_WAVE7_EXPR          = "范達爾！你的時候到了！躲進翡翠夢境祈禱我們永遠不會找到你吧！";
LVBM_RAJAXX_WAVE8_EXPR          = "厚顏無恥的笨蛋！我要親手殺了你！";
LVBM_RAJAXX_WAVE_ANNOUNCE       = "*** 第 %d/8 波敵人出現 ***";
LVBM_RAJAXX_WAVE_RAJAXX         = "*** 拉賈克斯將軍 登場 ***";
LVBM_RAJAXX_KILL_EXPR           = "殺吧，(.+)！$";
LVBM_RAJAXX_KILL_ANNOUNCE       = "*** %s 需要治療 ***";

-- 3. Moam
LVBM_MOAM_NAME                  = "莫阿姆";
LVBM_MOAM_INFO                  = "提供一個計時器計算莫阿姆石化時間";
LVBM_MOAM_COMBAT_START          = "因神態失常而坐立不安。";
LVBM_MOAM_STONE_ANNOUNCE_TIME   = "** %s 秒後莫阿姆進入石頭狀態，暫時無法攻擊 **";
LVBM_MOAM_STONE_GAIN            = "吸取你的法力後變成了石頭。";
LVBM_MOAM_STONE_ANNOUNCE_FADE   = "** %s 秒後莫阿姆結束石化狀態 **";
LVBM_MOAM_STONE_FADE_EXPR       = "^充能效果從莫阿姆身上消失。$";
LVBM_MOAM_STONE_FADE_ANNOUNCE   = "*** 莫阿姆進入石頭狀態 90 秒，術士放逐法力惡魔 ***";
LVBM_SBT["Stone form"] 	        = "石化狀態";

-- 4. Buru the Gorger
LVBM_BURU_NAME                  = "吞咽者布魯";
LVBM_BURU_INFO                  = "當某人被盯上時發出警告.";
LVBM_BURU_WHISPER_INFO          = "通知目標";
LVBM_BURU_WHISPER_TEXT          = "*** 你被盯上了! 快跑快跑! ***";
LVBM_BURU_SETICON_INFO          = "設置圖標";
LVBM_BURU_EYE_EXPR              = "凝視著(.+)！";
LVBM_BURU_EYE_ANNOUNCE          = "*** %s 被布魯盯上了！ 注意幫他治療！ ***";
LVBM_BURU_EYE_SELFWARNING       = "*** 你被盯上了! ***";

-- 5. Ayamiss the Hunter
LVBM_AYAMISS_NAME               = "狩獵者阿亞米斯";
LVBM_AYAMISS_INFO               = "當某人成為祭品時發出警告.";
LVBM_AYAMISS_SACRIFICE_EXPR     = "^(.+)受到(.*)麻痹";
LVBM_AYAMISS_SACRIFICE_ANNOUNCE = "*** %s 變成祭品了，快殺 札拉幼蟲！ ***";

-- 6. Ossirian the Unscarred
LVBM_OSSIRIAN_NAME              = "無疤者奧斯里安";
LVBM_OSSIRIAN_INFO              = "當奧斯里安虛弱及無敵時發出警告";
LVBM_OSSIRIAN_CURSE_INFO        = "語言詛咒警報";
LVBM_OSSIRIAN_CURSE_EXPR        = "^(.+)受到語言詛咒的傷害";
LVBM_OSSIRIAN_CURSE_ANNOUNCE    = "** 語言詛咒 - 25 秒後再次發動 **";
LVBM_OSSIRIAN_CURSE_PREANNOUNCE = "** 5 秒後發動語言詛咒！ **";
LVBM_OSSIRIAN_WEAK_ANNOUNCE     = "** 抗性虛弱 45 秒 : %s  - DPS全開**";
LVBM_OSSIRIAN_WEAK_EXPR         = "^無疤者奧斯里安受到(.+)虛弱的傷害";
LVBM_OSSIRIAN_WEAK_RUNOUT       = "*** %d 秒後奧斯里安進入無敵模式 ***";
LVBM_OSSIRIAN_SUPREME_EXPR      = "無疤者奧斯里安獲得了奧斯里安之力的效果。";
LVBM_OSSIRIAN_SUPREME_ANNOUNCE  = "*** 無疤者奧斯裡安進入了無敵模式 ***";
LVBM_OSSIRIAN_DEATH_EXPR        = "我...已...失敗。";
LVBM_SBT["Ossirians Curse"]     = "語言詛咒";
LVBM_SBT["祕法 vulnerability"]  = "祕法虛弱";
LVBM_SBT["火焰 vulnerability"]  = "火焰虛弱";
LVBM_SBT["冰霜 vulnerability"]  = "冰霜虛弱";
LVBM_SBT["自然 vulnerability"]  = "自然虛弱";
LVBM_SBT["暗影 vulnerability"]  = "暗影虛弱";

-- Anubisath Guardians  (Ossirian)
LVBM_GUARDIAN_NAME                  = "阿努比薩斯守衛者";
LVBM_GUARDIAN_INFO                  = "阿努比薩斯守衛者能力警告";
LVBM_GUARDIAN_SUMMON_INFO           = "召喚警告 (戰士/蟲群衛士)";
LVBM_GUARDIAN_THUNDERCLAP_EXPR      = "^阿努比薩斯守衛者的雷霆一擊擊中(.+)造成";
LVBM_GUARDIAN_THUNDERCLAP_ANNOUNCE  = "*** 雷霆一擊 ***";
LVBM_GUARDIAN_EXPLODE_EXPR          = "^阿努比薩斯守衛者獲得了爆炸的效果。";
LVBM_GUARDIAN_EXPLODE_ANNOUNCE      = "*** 即將爆炸！近戰躲開！ ***";
LVBM_GUARDIAN_ENRAGE_EXPR           = "^阿努比薩斯守衛者獲得了狂怒的效果。";
LVBM_GUARDIAN_ENRAGE_ANNOUNCE       = "*** 狂怒 ***";

LVBM_GUARDIAN_PLAGUE_EXPR           = "^(.+)受到(.*)瘟疫";
LVBM_GUARDIAN_PLAGUE_ANNOUNCE       = "***  %s 中了瘟疫，離開人群！ ***";
LVBM_GUARDIAN_PLAGUE_WHISPER        = "你中了瘟疫, 快點離開!";

LVBM_GUARDIAN_SUMMONGUARD_EXPR          = "^阿努比薩斯守衛者施放了召喚阿努比薩斯蟲群衛士。";
LVBM_GUARDIAN_SUMMONEDGUARD_ANNOUNCE    = "*** 召喚蟲群衛士 ***";
LVBM_GUARDIAN_SUMMONWARRIOR_EXPR        = "^阿努比薩斯守衛者施放了召喚阿努比薩斯戰士。";
LVBM_GUARDIAN_SUMMONEDWARRIOR_ANNOUNCE  = "*** 召喚戰士 ***";

end
