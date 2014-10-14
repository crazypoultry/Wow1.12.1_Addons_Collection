-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--       by Diablohu<白银之手>@轻风之语         --
--          http://www.dreamgen.net             --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then

-- 1. Skeram
	LVBM_SKERAM_NAME					= "预言者斯克拉姆";
	LVBM_SKERAM_DESCRIPTION				= "警报魔爆和精神控制";
	
	LVBM_SKERAM_AE						= "*** 魔爆术 ***";
	LVBM_SKERAM_MC						= "*** %s被精神控制 ***";
	
	LVBM_SKERAM_CAST_SPELL_AE			= "预言者斯克拉姆开始施放魔爆术。";
	LVBM_SKERAM_MIND_CONTROL_TEXTURE	= "Spell_Shadow_Charm";
	LVBM_SKERAM_MIND_CONTROL_DEBUFF		= "充实";


-- 2. Three Bugs (Vem & Co)
	LVBM_THREEBUGS_NAME					= "三虫 - 维姆、亚尔基和克里";
	LVBM_THREEBUGS_VEM					= "维姆";
	LVBM_THREEBUGS_YAUJ					= "亚尔基公主";
	LVBM_THREEBUGS_KRI					= "克里勋爵";
	LVBM_THREEBUGS_VEM					= "维姆";
	LVBM_THREEBUGS_REAL_NAME			= "三虫";
	LVBM_THREEBUGS_FEAR_EXPR			= "([^%s]+)受([^%s]+)恐惧效果的影响。";
	LVBM_THREEBUGS_FEAR_ANNOUNCE		= "*** 亚尔基公主的恐惧 - %d秒后施放 ***";
	LVBM_THREEBUGS_CASTHEAL_EXPR		= "亚尔基公主开始施放强效治疗术。";
	LVBM_THREEBUGS_CASTHEAL_ANNOUNCE	= "*** 亚尔基公主开始施放强效治疗术 - 打断 ***";
	
	LVBM_SBT["Great Heal Cast"] 		= "强效治疗术施放";
	LVBM_SBT["Yauj Fear"] 				= "亚尔基公主恐惧";


-- 3. Battleguard Sartura
	LVBM_SARTURA_NAME				= "沙尔图拉"
	LVBM_SARTURA_DESCRIPTION		= "警报旋风旋"
	
	LVBM_SARTURA_ANNOUNCE_WHIRLWIND	= "*** 旋风斩 ***"
	LVBM_SARTURA_WHIRLWIND_FADED	= "*** 旋风斩消失 - 眩晕 ***"
	
	LVBM_SARTURA_GAIN_WHIRLWIND		= "沙尔图拉获得了旋风斩的效果。";
	LVBM_SARTURA_WHIRLWIND_FADES	= "旋风斩效果从沙尔图拉身上消失。";
	LVBM_SARTURA_ENRAGE				= "%s变得愤怒了！";
	LVBM_SARTURA_SARTURA			= "沙尔图拉";
	
	LVBM_SBT["Whirlwind"] 			= "旋风斩";
	LVBM_SBT["Enrage"]				= "激怒";


-- 4. Fankriss
	LVBM_FANKRISS_NAME			= "顽强的范克瑞斯"
	LVBM_FANKRISS_DESCRIPTION	= "警报召唤虫"
	
	LVBM_FANKRISS_SPAWN_WARNING	= "*** 召唤虫 ***"
	
	LVBM_FANKRISS_WORM_SPAWNED	= "顽强的范克瑞斯施放了召唤虫子。";


-- 5. Huhuran
	LVBM_HUHURAN_NAME					= "哈霍兰公主";
	LVBM_HUHURAN_DESCRIPTION			= "警报翼龙钉刺和狂暴";
	LVBM_HUHURAN_ANNOUNCE_FRENZY		= "警报狂暴";
	
	LVBM_HUHURAN_WYVERN_WARNING			= "*** 翼龙钉刺 - 5秒后施放 ***";
	
	LVBM_HUHURAN_WYVERN_REGEXP			= "([^%s]+)受到了翼龙钉刺效果的影响。";
	LVBM_HUHURAN_FRENZY					= "%s变得狂怒无比！";
	LVBM_HUHURAN_FRENZY_ANNOUNCE		= "*** 狂暴 ***";
	LVBM_HUHURAN_HUHURAN				= "哈霍兰公主";
	
	LVBM_SBT["Wyvern Sting Cooldown"] 	= "翼龙钉刺冷却";


-- Anubisat Defenders
	LVBM_DEFENDER_NAME				= "阿努比萨斯防御者";
	LVBM_DEFENDER_DESCRIPTION		= "警报爆炸和瘟疫";
	LVBM_DEFENDER_WHISPER			= "密语玩家";
	LVBM_DEFENDER_PLAGUE			= "警报瘟疫";
	
	LVBM_DEFENDER_ANNOUNCE_EXPLODE	= "*** 爆炸 ***";
	LVBM_DEFENDER_ANNOUNCE_PLAGUE	= "*** %s中了瘟疫 ***";
	LVBM_DEFENDER_WHISPER_PLAGUE	= "你中了瘟疫！";
	LVBM_DEFENDER_PLAGUE_WARNING	= "瘟疫";
	
	LVBM_DEFENDER_GAIN_EXPLODE		= "阿努比萨斯防御者获得了爆炸的效果。";
	LVBM_DEFENDER_PLAGUE_REGEXP		= "([^%s]+)受([^%s]+)瘟疫效果的影响。";
	
	LVBM_SBT["Explode"]				= "爆炸";


-- 6. Twin Emperors
	LVBM_TWINEMPS_NAME				= "双子皇帝";
	LVBM_TWINEMPS_DESCRIPTION		= "作战计时器";
	LVBM_TWINEMPS_REAL_NAME			= "双子皇帝";
	
	LVBM_TWINEMPS_TELEPORT_WARNING	= "*** %s秒后双子传送 ***";
	LVBM_TWINEMPS_ENRAGE_WARNING	= "*** %s%s后激怒 ***";

	LVBM_TWINEMPS_TELEPORT_ANNOUNCE	= "*** 双子传送 ***";
	
	LVBM_TWINEMPS_CAST_SPELL_1		= "维克洛尔大帝施放了双子传送。";
	LVBM_TWINEMPS_CAST_SPELL_2		= "维克尼拉斯大帝施放了双子传送。";
	LVBM_TWINEMPS_VEKNILASH			= "维克尼拉斯大帝";
	LVBM_TWINEMPS_VEKLOR			= "维克洛尔大帝";
	
	LVBM_TWINEMPS_EXPLODE_EXPR 		= "获得了爆炸虫";
	LVBM_TWINEMPS_EXPLODE_ANNOUNCE 	= "爆炸虫 - 迅速离开";
	
	LVBM_SBT["Enrage"]				= "激怒";
	LVBM_SBT["Teleport"]			= "传送";


-- 7. Ouro
	LVBM_OURO_NAME						= "奥罗";
	LVBM_OURO_DESCRIPTION				= "警报下潜";
	
	LVBM_OURO_SWEEP_SOON_WARNING		= "*** 横扫 - 5秒后施放 ***";
	LVBM_OURO_BLAST_SOON_WARNING		= "*** 沙尘爆裂 - 5秒后施放 ***";
	LVBM_OURO_SWEEP_WARNING				= "*** 横扫来临 - 1.5秒 ***";
	LVBM_OURO_BLAST_WARNING				= "*** 沙尘爆裂来临 - 2秒 ***";
	LVBM_OURO_SUBMERGED_WARNING			= "*** 奥罗潜入地下30秒 ***";
	LVBM_OURO_EMERGE_SOON_WARNING		= "*** 5秒后奥罗钻出地面 ***";
	LVBM_OURO_EMERGED_WARNING			= "*** 奥罗钻出地面 - 3分钟后再次下潜 ***";
	LVBM_OURO_POSSIBLE_SUBMERGE_WARNING	= "*** 10秒后奥罗可能潜入地下 ***";
	LVBM_OURO_SUBMERGE_WARNING			= "*** %s秒后奥罗潜入地下 ***";
	
	LVBM_OURO_CAST_SWEEP				= "奥罗开始施放横扫。";
	LVBM_OURO_CAST_SAND_BLAST			= "奥罗开始施展沙尘爆裂。";
	LVBM_OURO_DIRT_MOUND_QUAKE			= "土堆的地震";
	LVBM_OURO_ENRAGE					= "%s变得狂暴了！";
	LVBM_OURO_ENRAGE_ANNOUNCE			= "*** 激怒 ***";
	LVBM_OURO_OURO						= "奥罗";
	
	LVBM_SBT["Submerge"]				= "下潜";
	LVBM_SBT["Emerge"]					= "重新出现";
	LVBM_SBT["Sand Blast"]				= "沙尘爆裂";
	LVBM_SBT["Sand Blast Cast"]			= "沙尘爆裂施放";
	LVBM_SBT["Sweep"]					= "横扫"
	LVBM_SBT["Sweep Cast"]				= "横扫施放";


-- 8. CThun
	LVBM_CTHUN_NAME						= "克苏恩"
	LVBM_CTHUN_DESCRIPTION				= "除第一名进入房间的队员，请关闭通告";
	LVBM_CTHUN_SLASHHELP1				=  "/cthun start - 手动开始计时";
	LVBM_CTHUN_SEND_WHISPER				= "密语玩家";
	LVBM_CTHUN_SET_ICON					= "添加标注";
	LVBM_CTHUN_RANGE_CHECK				= "距离检测";
	LVBM_CTHUN_RANGE_CHECK_PHASE2		= "在第二阶段显示距离检测窗口";
	
	LVBM_CTHUN_SMALL_EYE_WARNING		= "*** 眼球触须%s秒后出现 ***";
	LVBM_CTHUN_DARK_GLARE_WARNING		= "*** 黑暗闪耀%s秒后出现 ***";
	LVBM_CTHUN_DARK_GLARE_ON_GROUP		= "*** 黑暗闪耀正对小队 - ";
	LVBM_CTHUN_DARK_GLARE_ON_YOU		= "黑暗闪耀正对着你！";
	LVBM_CTHUN_DARK_GLARE_TIMER_FAILED	= "黑暗闪耀计时器调整失败";
	LVBM_CTHUN_DARK_GLARE_END_WARNING	= "*** 黑暗闪耀5秒后结束 ***";
	LVBM_CTHUN_GIANT_CLAW_WARNING		= "*** 巨钩触须10秒后出现 ***";
	LVBM_CTHUN_GIANT_AND_EYES_WARNING	= "*** 巨%s触须和眼球触须10秒后出现 ***";
	LVBM_CTHUN_WEAKENED_WARNING			= "*** 克苏恩的力量被削弱了！ - 45秒 ***";
	LVBM_CTHUN_WEAKENED_ENDS_WARNING	= "*** 虚弱时间剩余%s秒 ***";
	LVBM_CTHUN_DARK_GLARE				= "黑暗闪耀";
	LVBM_CTHUN_EYE_BEAM					= "眼棱";
	
	LVBM_CTHUN_EYE_OF_CTHUN				= "克苏恩之眼";
	LVBM_CTHUN_CLAW						= "钩";
	LVBM_CTHUN_EYE						= "眼";
	LVBM_CTHUN_DIES						= "克苏恩之眼死亡了。";
	LVBM_CTHUN_WEAKENED					= "%s的力量被削弱了！";
	
	LVBM_SBT["Dark Glare"]				= "黑暗闪耀";
	LVBM_SBT["Dark Glare End"]			= "黑暗闪耀结束";
	LVBM_SBT["Eye Tentacles"]			= "眼球触须";
	LVBM_SBT["Giant Eye Tentacle"]		= "巨眼触须";
	LVBM_SBT["Giant Claw Tentacle"]		= "巨钩触须";
	LVBM_SBT["Weakened"]				= "克苏恩虚弱";

--------------------------------------------------------------------------------------

-- not translated for lack of data
--Viscidus
	LVBM_VISCIDUS_NAME					= "维希度斯";
	LVBM_VISCIDUS_DESCRIPTION			= "Counts frost and melee hits on Viscidus.";
	LVBM_VISCIDUS_SEND_WHISPER			= "Send whisper";
	LVBM_VISCIDUS_SLASHHELP1			= "/Viscidus mt name - sets a main tank to prevent toxin warning spam";
	LVBM_VISCIDUS_MT_SET				= "Main tank set to: ";
	LVBM_VISCIDUS_MT_NOT_SET1 			= "Main tank not set! Toxin warning will whisper your main tank every 15 seconds!";
	LVBM_VISCIDUS_MT_NOT_SET2			= "Type '/vis mt name' to set your main tank.";
	
	LVBM_VISCIDUS_TOXIN_ON				= "*** Toxin on ";
	LVBM_VISCIDUS_TOXIN_ON_YOU			= "Toxin on you!";
	LVBM_VISCIDUS_FREEZE_WARNING		= "*** Freeze %s/3 ***";
	LVBM_VISCIDUS_FROZEN_WARNING		= "*** Freeze 3/3 - frozen for 15 sec ***";
	LVBM_VISCIDUS_SHATTER_WARNING		= "*** Shatter %s/3 ***";
	LVBM_VISCIDUS_FROZEN_LEFT_WARNING	= "*** %s seconds left ***";
	LVBM_VISCIDUS_FROST_HITS			= "Frost hits: ";
	LVBM_VISCIDUS_FROST_HITS_WARNING	= "*** %s frost hits ***";
	LVBM_VISCIDUS_MELEE_HITS			= "Melee hits: ";
	LVBM_VISCIDUS_MELEE_HITS_WARNING	= "*** %s melee hits ***";
	
	LVBM_VISCIDUS_SLOW_1				= "%s begins to slow!";
	LVBM_VISCIDUS_SLOW_2				= "%s is freezing up!";
	LVBM_VISCIDUS_SLOW_3				= "%s is frozen solid!";
	LVBM_VISCIDUS_SHATTER_1				= "%s begins to crack!";
	LVBM_VISCIDUS_SHATTER_2				= "%s looks ready to shatter!";
	LVBM_VISCIDUS_VISCIDUS				= "Viscidus";
	
	LVBM_SBT["Frozen"]					= "Frozen";

end
