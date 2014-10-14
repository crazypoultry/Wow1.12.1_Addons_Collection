-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--       by Diablohu<白银之手>@轻风之语         --
--             www.dreamgen.net                 --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then

--Patchwerk
	LVBM_PW_NAME				= "帕奇维克";
	LVBM_PW_DESCRIPTION			= "警报狂暴";
	LVBM_PW_OPTION1				= "警报仇恨打击";
	LVBM_PW_OPTION2				= "显示数据";
	LVBM_PW_OPTION3				= "显示仇恨打击数据";
	
	LVBM_PW_ENRAGE_WARNING		= "*** %s%s后激怒 ***";
	LVBM_PW_HS_ANNOUNCE			= "仇恨打击 --> %s [%s]";
	
	LVBM_PW_YELL_1 				= "帕奇维克要跟你玩！";
	LVBM_PW_YELL_2				= "帕奇维克是克尔苏加德的战神！";
	
	LVBM_PW_HS_YOU_HIT			= "帕奇维克的仇恨打击击中你造成(%d+)点伤害。(.*)";
	LVBM_PW_HS_YOU_MISS			= "帕奇维克的仇恨打击没有击中你。";
	LVBM_PW_HS_YOU_DODGE		= "你闪躲了帕奇维克的仇恨打击。";
	LVBM_PW_HS_YOU_PARRY		= "你招架了帕奇维克的仇恨打击。";
	LVBM_PW_HS_PARTY_HIT		= "帕奇维克的仇恨打击击中([^%s]+)造成(%d+)点伤害。(.*)";
	LVBM_PW_HS_PARTY_MISS		= "帕奇维克的仇恨打击没有击中([^%s]+)。"; 
	LVBM_PW_HS_PARTY_DODGE		= "帕奇维克的仇恨打击被([^%s]+)闪躲过去。";
	LVBM_PW_HS_PARTY_PARRY		= "帕奇维克的仇恨打击被([^%s]+)招架了";
	
	LVBM_PWSTATS_STATS			= "*** 帕奇维克战斗数据 ***";
	LVBM_PWSTATS_STRIKES		= "仇恨打击: %s (%.0f%%)";
	LVBM_PWSTATS_HITS			= "命中: %s (%.0f%%)";
	LVBM_PWSTATS_DODGES			= "闪躲: %s (%.0f%%)";
	LVBM_PWSTATS_PARRIES		= "招架: %s (%.0f%%)";
	LVBM_PWSTATS_MISSES			= "未击中: %s (%.0f%%)";
	LVBM_PWSTATS_AVG_DMG		= "平均每击伤害: %.0f";
	LVBM_PWSTATS_MAX_HIT		= "最大伤害: %s 击中 %s";
	LVBM_PWSTATS_PER_PLAYER		= "%s仇恨打击攻击 %s (%s 命中)";
	LVBM_PWSTATS_NOT_AVAILABLE	= "数据不可用";
	
	LVBM_SBT["Enrage"]			= "激怒";


--Grobbulus
	LVBM_GROBB_NAME						= "格罗布鲁斯";
	LVBM_GROBB_DESCRIPTION				= "对受到变异注射的队员加上骷髅标注";
	LVBM_GROBB_SEND_WHISPER				= "密语玩家";
	LVBM_GROBB_SET_ICON					= "添加标注";
	
	LVBM_GROBB_YOU_ARE_INJECTED			= "你被注射了！";
	LVBM_GROBB_INJECTED_WARNING			= "*** %s被注射 ***"
	LVBM_GROBB_INJECTED					= "变异注射";
	
	LVBM_GROBB_INJECTION_REGEXP			= "([^%s]+)受([^%s]+)变异注射效果的影响。";
	LVBM_GROBB_INJECTION_FADES_REGEXP	= "变异注射效果从([^%s]+)身上消失。.";
	LVBM_GROBB_CLOUD_POISON				= "格罗布鲁斯施放了毒性云雾。";

	LVBM_SBT["Enrage"]					= "激怒";
	LVBM_SBT["Cloud Poison"]			= "毒性云雾";


--Gluth
	LVBM_GLUTH_NAME						= "格拉斯";
	LVBM_GLUTH_DESCRIPTION				= "警报格拉斯恐惧,狂暴和吞噬.";
	LVBM_GLUTH_ANNOUNCE_FRENZY			= "警报狂暴";
	
	LVBM_GLUTH_DECIMATE_WARN1			= "*** 残杀 - 2分钟后施放 ***";
	LVBM_GLUTH_DECIMATE_WARN2			= "*** 残杀 - 2分钟后再次施放 ***";
	LVBM_GLUTH_DECIMATE_1MIN_WARNING	= "*** 残杀 - 1分钟后施放 ***";
	LVBM_GLUTH_DECIMATE_SOON_WARNING	= "*** 残杀 - 即将施放 ***";
	LVBM_GLUTH_DECIMATE_WARNING			= "*** 残杀 - %s秒后施放 ***"
	LVBM_GLUTH_FEAR_WARNING				= "*** 恐惧怒吼 - 20秒后再次施放 ***";
	LVBM_GLUTH_FEAR_5SEC_WARNING		= "*** 恐惧怒吼 - 5秒后施放 ***";
	
	LVBM_GLUTH_DECIMATE_REGEXP			= "格拉斯的残杀击中([^%s]+)造成(%d+)点伤害。";
	LVBM_GLUTH_FEAR_REGEXP				= "([^%s]+)受到了恐惧怒吼的影响。";
	LVBM_GLUTH_FRENZY					= "%s变得狂怒无比！"
	LVBM_GLUTH_GLUTH					= "格拉斯";
	LVBM_GLUTH_FRENZY_ANNOUNCE			= "*** 狂暴 ***";
	
	LVBM_SBT["Fear"]					= "恐惧";
	LVBM_SBT["Decimate"]				= "残杀";
	LVBM_SBT["Frenzy"]					= "狂暴";


--Thaddius
	LVBM_THADDIUS_NAME					= "塔迪乌斯";
	LVBM_THADDIUS_DESCRIPTION			= "警报激怒和极性转换.";
	LVBM_THADDIUS_WARN_NOT_CHANGED		= "警报极性未改变";
	LVBM_THADDIUS_ALT_STRATEGY			= "2点跑位战术警报(显示左/右提示)";
	LVBM_THADDIUS_WARN_POWERSURGE		= "警报斯塔拉格的能量涌动(200%攻击速度)";
	
	LVBM_THADDIUS_ENRAGE_WARNING		= "*** %s%s后激怒 ***";
	LVBM_THADDIUS_POL_SHIFT				= "*** 极性转化 - 检查极性 ***";
	LVBM_THADDIUS_SURGE_WARNING			= "*** 能量涌动 - 持续10秒 ***";
	LVBM_THADDIUS_POL_WARNING			= "*** 极性转化 - %s秒后施放 ***";
	LVBM_THADDIUS_PHASE_2_SOON			= "*** 第二阶段 ***";
	LVBM_THADDIUS_CHARGE_CHANGED		= "极性变为%s！";
	LVBM_THADDIUS_CHARGE_NOT_CHANGED	= "极性未改变";
	LVBM_THADDIUS_RIGHT					= "右！";
	LVBM_THADDIUS_LEFT					= "左！";
	
	LVBM_THADDIUS_GAINS_SURGE			= "斯塔拉格获得了能量涌动的效果。";
	LVBM_THADDIUS_CAST_POL				= "塔迪乌斯开始施放极性转化。";
	LVBM_THADDIUS_POL_REGEXP			= "你受到了([^%s]+)能量补充效果的影响。";
	LVBM_THADDIUS_YELL_START1			= "杀……";
	LVBM_THADDIUS_YELL_START2			= "咬碎……你的……骨头……";
	LVBM_THADDIUS_YELL_START3			= "打……烂……你！";
	LVBM_THADDIUS_YELL_POL				= "你感受到痛苦的滋味了吧……";
	LVBM_THADDIUS_ENRAGE				= "%s变得极度狂暴而愤怒！";
	LVBM_THADDIUS_TESLA_EMOTE			= "%s超载了！";
	LVBM_THADDIUS_TESLA_COIL			= "电磁圈";
	LVBM_THADDIUS_THADDIUS				= "塔迪乌斯";
	LVBM_THADDIUS_POSITIVE				= "正";
	LVBM_THADDIUS_NEGATIVE				= "负";
	
	-- Phase1
	LVBM_THADDIUS_PHASE1_YELL1 			= "斯塔拉格要碾碎你！";
	LVBM_THADDIUS_PHASE1_YELL2 			= "主人要吃了你！";
	LVBM_THADDIUS_PHASE1_ANNOUNCE		= "*** 第一阶段 ***";
	LVBM_THADDIUS_SURGE_EXPR			= "斯塔拉格获得了能量涌动的效果。";
	LVBM_THADDIUS_SURGE_ANNOUNCE		= "*** 能量涌动 - 持续10秒 ***";
	LVBM_THADDIUS_THROW_ANNOUNCE		= "*** 空中飞人 ***";
	LVBM_THADDIUS_THROW_ANNOUNCE_SOON	= "*** %s秒后空中飞人 ***";
	LVBM_THADDIUS_PLATFORM_EXPR			= "%s的连接中断了！";
	LVBM_THADDIUS_PLATFORM_ANNOUNCE		= "*** 警告 - 憎恶离开平台 ***";
	
	LVBM_SBT["MT throw"]				= "空中飞人";
	LVBM_SBT["Power Surge"]				= "能量涌动";
	LVBM_SBT["Phase 2"]					= "第二阶段";
	LVBM_SBT["Polarity Shift"]			= "极性转化";
	LVBM_SBT["Polarity Shift cast"]		= "极性转化施放";
	LVBM_SBT["Enrage"]					= "激怒";
	
--------------------------------------------------------------------------------------

--Razuvious
	LVBM_IR_NAME					= "教官拉苏维奥斯";
	LVBM_IR_DESCRIPTION				= "警报瓦解怒吼";
	LVBM_IR_SHOW_10SEC_WARNING		= "10秒警报";
	
	LVBM_IR_TIMER_UPDATED			= "计时器更新";
	LVBM_IR_SHOUT_WARNING			= "*** 瓦解怒吼 - %s秒后施放 ***"
	
	LVBM_IR_SPELL_1					= "瓦解怒吼";
	LVBM_IR_YELL_1					= "练习时间到此为止！都拿出真本事来！";
	LVBM_IR_YELL_2					= "绊腿……有什么问题么？";
	LVBM_IR_YELL_3					= "按我教导的去做！";
	LVBM_IR_YELL_4					= "仁慈无用！";
	
	LVBM_SBT["Disrupting Shout"]	= "瓦解怒吼";


--Gothik the Harvester
	LVBM_GOTH_NAME					= "收割者戈提克";
	LVBM_GOTH_DESCRIPTION			= "警报军团刷新与死亡";
	
	LVBM_GOTH_PHASE2_WARNING		= "*** 戈提克出场 ***";
	LVBM_GOTH_PHASE2_INC_WARNING	= "*** %s%s后戈提克出场 ***";
	LVBM_GOTH_DEAD_WARNING			= "*** %s死亡 ***";
	LVBM_GOTH_INC_WARNING			= "*** %s，%s秒 ***";
	LVBM_GOTH_WAVE_INC_WARNING1		= "*** 3秒后第%s/18批 - %s %s  ***";
	LVBM_GOTH_WAVE_INC_WARNING2		= "*** 3秒后第%s/18批 - %s %s 与 %s %s ***";
	LVBM_GOTH_WAVE_INC_WARNING3		= "*** 3秒后第%s/18批 - %s %s, %s %s 与 %s %s ***";
	
	LVBM_GOTH_YELL_START1			= "你们这些蠢货已经主动步入了陷阱。"
	LVBM_GOTH_PHASE2_YELL			= "我已经等待很久了。现在你们将面对灵魂的收割者。";
	
	LVBM_GOTH_RIDER					= "冷酷的骑兵";
	LVBM_GOTH_RIDER_SHORT			= "冷酷的骑兵";
	LVBM_GOTH_KNIGHT				= "冷酷的死亡骑士";
	LVBM_GOTH_KNIGHT_SHORT			= "冷酷的死亡骑士";
	LVBM_GOTH_KNIGHTS_SHORT			= "冷酷的死亡骑士";
	LVBM_GOTH_TRAINEE				= "冷酷的学徒";
	LVBM_GOTH_TRAINEE_SHORT			= "冷酷的学徒";
	
	LVBM_SBT["Phase 2"]				= "第二阶段";
	LVBM_SBT["Rider"]				= "冷酷的骑兵";
	LVBM_SBT["Deathknight"]			= "冷酷的死亡骑士";
	LVBM_SBT["Trainees"]			= "冷酷的学徒";


-- FourHorsemen
	LVBM_FOURHORSEMEN_NAME						= "天启四骑士";
	LVBM_FOURHORSEMEN_INFO						= "相关技能计时";
	LVBM_FOURHORSEMEN_SHOW_5SEC_MARK_WARNING	= "印记技能5秒警报";
	LVBM_FOURHORSEMEN_THANE						= "库尔塔兹领主";
	LVBM_FOURHORSEMEN_LADY						= "女公爵布劳缪克丝";
	LVBM_FOURHORSEMEN_MOGRAINE					= "大领主莫格莱尼";
	LVBM_FOURHORSEMEN_ZELIEK					= "瑟里耶克爵士";
	LVBM_FOURHORSEMEN_REAL_NAME					= "天启四骑士";
	
	LVBM_FOURHORSEMEN_MARK_EXPR					= "受到了([^%s]+)印记效果的影响。";
	LVBM_FOURHORSEMEN_MARK_INFOMESSAGE			= "本地错误，已与其他玩家同步印记 #";
	LVBM_FOURHORSEMEN_MARK_ANNOUNCE				= "*** 印记#%d ***";
	LVBM_FOURHORSEMEN_MARK_WARNING				= "*** 印记#%d - 5秒后施放 ***";

	LVBM_FOURHORSEMEN_METEOR_EXPR				= "库尔塔兹领主的流星击中([^%s]+)造成(%d+)点火焰伤害。";
	LVBM_FOURHORSEMEN_METEOR_ANNOUNCE			= "*** 流星 ***";

	LVBM_FOURHORSEMEN_VOID_EXPR					= "女公爵布劳缪克丝施放了虚空领域。";
	LVBM_FOURHORSEMEN_VOID_ANNOUNCE				= "虚空领域";
	LVBM_FOURHORSEMEN_VOID_WHISPER				= "虚空领域于你！";

	LVBM_FOURHORSEMEN_SHIELDWALL_EXPR			= "([^%s]+)获得了盾墙的效果。";
	LVBM_FOURHORSEMEN_SHIELDWALL_ANNOUNCE		= "*** %s - 盾墙开启20秒 ***";
	LVBM_FOURHORSEMEN_SHIELDWALL_FADE			= "*** %s - 盾墙效果消失 ***";

	LVBM_FOURHORSEMEN_WHISPER_INFO				= "密语虚空领域内的玩家";

	LVBM_FOURHORSEMEN_TAUNTRESIST_INFO			= "通知嘲讽失败";
	LVBM_FOURHORSEMEN_TAUNTRESIST_TAUNT			= "嘲讽";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MOKING		= "惩戒痛击";
	LVBM_FOURHORSEMEN_TAUNTRESIST_CSHOUT		= "挑战怒吼";
	LVBM_FOURHORSEMEN_TAUNTRESIST_RESIST		= "抵抗";
	LVBM_FOURHORSEMEN_TAUNTRESIST_PARRY			= "招架";
	LVBM_FOURHORSEMEN_TAUNTRESIST_DODGE			= "闪躲";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MISS			= "未击中";
	LVBM_FOURHORSEMEN_TAUNTRESIST_BLOCK			= "格挡";
	LVBM_FOURHORSEMEN_TAUNTRESIST_SELFWARN		= "嘲讽失败";
	LVBM_FOURHORSEMEN_TAUNTRESIST_MESSAGE		= "--> 嘲讽失败! <--";
	
	LVBM_SBT["Enrage"]							= "激怒";
	LVBM_SBT["First Mark"]						= "第一个印记";
	LVBM_SBT["Mark"]							= "印记";
	LVBM_SBT["Void Zone"]						= "虚空领域";
	LVBM_SBT["Meteor"]							= "流星";

--------------------------------------------------------------------------------------

--Noth the Plaguebringer
	LVBM_NTP_NAME					= "瘟疫使者诺斯";
	LVBM_NTP_DESCRIPTION			= "警报传送和闪现术";
	LVBM_NTP_OPTION_WARN_SPAWN 		= "警报瘟疫战士刷新";
	LVBM_NTP_OPTION_WARN_CURSE 		= "警报诅咒";
	
	LVBM_NTP_BACK_WARNING			= "*** 诺斯回归(%s秒) - 攻击 ***";
	LVBM_NTP_TELEPORT_WARNING		= "*** %s秒后诺斯传送 ***";
	LVBM_NTP_NOTH_GAINS_BLINK		= "*** 诺斯闪现 ***";
	LVBM_NTP_BLINK_5SEC_WARNING		= "*** 闪现术 - 5秒后施放 ***";
	LVBM_NTP_BLINK_0SEC_WARNING		= "*** 闪现术冷却 - 远程攻击停止 ***";
	LVBM_NTP_TELEPORT_10SEC_WARNING	= "*** 10秒后诺斯传送 ***"
	LVBM_NTP_BACK_10SEC_WARNING		= "*** 10秒后诺斯回归 ***";
	LVBM_NTP_ADD_WARNING			= "*** 瘟疫战士 - 5秒后刷新 ***";
	LVBM_NTP_CURSE_WARNING			= "*** 瘟疫使者的诅咒 ***";
	LVBM_NTP_NEXT_WAVE_SOON			= "*** 瘟疫卫士 - 10秒后刷新 ***";
	
	LVBM_NTP_SPELL_1 				= "瘟疫使者诺斯获得了闪现术的效果。";
	LVBM_NTP_CURSE_AFFLICT 			= "瘟疫使者的诅咒"; -- AOE curse
	LVBM_NTP_ADDS_SPAWN 			= "起来吧，我的战士们！起来，再为主人尽忠一次！"; -- Adds spawn
	LVBM_NTP_YELL_START1 			= "死吧，入侵者！";
	LVBM_NTP_YELL_START2 			= "荣耀归于我主！";
	LVBM_NTP_YELL_START3 			= "我要没收你的生命！";
	
	LVBM_SBT["Teleport to Balcony"]	= "传送";
	LVBM_SBT["Teleport back"]		= "回归";
	LVBM_SBT["Blink"]				= "闪现术";
	LVBM_SBT["Blink Cooldown"]		= "闪现术冷却";
	LVBM_SBT["Possible AE Curse"]	= "瘟疫使者的诅咒";
	LVBM_SBT["Curse Timeout"]		= "诅咒超时";
	LVBM_SBT["Wave 1"]				= "第一波";
	LVBM_SBT["Wave 2"]				= "第二波";


--Heigan the Unclean
	LVBM_HTU_NAME					= "肮脏的希尔盖";
	LVBM_HTU_DESCRIPTION			= "警报传送";
	
	LVBM_HTU_TELEPORT_WARNING		= "*** %s秒后传送 ***";
	LVBM_HTU_TELEPORT_BACK_WARNING	= "*** %s秒后回归 ***";
	
	LVBM_HTU_YELL_START1			= "你……就是下一个。";
	LVBM_HTU_YELL_START2 			= "我看到你了……";
	LVBM_HTU_YELL_START3 			= "你是我的了。";
	
	LVBM_SBT["Teleport"]			= "传送";
	LVBM_SBT["Teleport back"]		= "回归";
	

--Loatheb
	LVBM_LOATHEB_NAME					= "洛欧塞布";
	LVBM_LOATHEB_DESCRIPTION			= "警报必然的厄运和治疗冷却";
	LVBM_LOATHEB_ANNOUNCE_SPORES		= "警报孢子刷新"
	
	--LVBM_LOATHEB_ANNOUNCE_SPORES_BACKWARDS		= "Announce spores to Groups Backwards";
	
	LVBM_LOATHEB_HEAL_RAID				= "在团队频道中警报治疗";
	LVBM_LOATHEB_HEAL_RAID_WARN			= "在团队警报中警报治疗";
	LVBM_LOATHEB_HEAL_WHISPER			= "密语下一位治疗者";
	LVBM_LOATHEB_ANNOUNCE_POT_OPTION	= "警报消耗品(可能和贵会的策略不同)";
	LVBM_LOATHEB_SPECIALWARN_POT_OPTION	= "当你需要使用药品的时候显示特殊警报(可能和贵会的策略不同)";
	LVBM_LOATHEB_HEAL_SHOW_AUTO			= "当洛欧塞布触发时显示治疗者框体"
	LVBM_LOATHEB_HEAL_SHOW_NOW			= "显示治疗框体"
	LVBM_LOATHEB_HEAL_SETUP				= "设置治疗顺序"
	LVBM_LOATHEB_NO_BC_INFO				= "你不是团队领袖或助理。你所做的改动将不会被同步。";
	LVBM_LOATHEB_NO_CD					= "已冷却";
	LVBM_LOATHEB_SET_HEAL_ROTATION		= "存储并同步";
	LVBM_LOATHEB_SET_HEAL_ROTATION_NO_BC= "存储";
	LVBM_LOATHEB_SHADOW_PROT_POT		= "强效暗影防护药水"
	LVBM_LOATHEB_BANDAGE				= "绷带";
	LVBM_LOATHEB_HEALTHSTONE			= "治疗石";
	
	LVBM_LOATHEB_DOOM_WARNING			= "*** 必然的厄运#%s - %s秒后施放 ***";
	LVBM_LOATHEB_DOOM_NOW				= "*** 必然的厄运#%s到来 - %s秒后再次施放 ***";
	LVBM_LOATHEB_DECURSE_NOW			= "*** 驱散诅咒 - 30秒后再次施放 ***";
	LVBM_LOATHEB_DECURSE_WARNING		= "*** 驱散诅咒 - %s秒后施放 ***";
	LVBM_LOATHEB_SPORE_SPAWNED			= "*** 孢子%d刷新 ***";
	LVBM_LOATHEB_POT_ANNOUNCE			= "*** 立刻使用%s！ ***";
	LVBM_LOATHEB_POT_WARNING			= "立刻使用%s！";
	LVBM_LOATHEB_HEAL_WARNING			= "治疗 #%s 完成 - 下一位: %s";
	LVBM_LOATHEB_YOU_ARE_NEXT			= "你就是下一个！";
	LVBM_LOATHEB_YOU_ARE_SOON			= "准备治疗！";
	
	LVBM_LOATHEB_DOOM_REGEXP			= "([^%s]+)受([^%s]+)必然的厄运效果的影响。";
	LVBM_LOATHEB_REMOVE_CURSE			= "洛欧塞布对洛欧塞布施放了移处诅咒。";
	LVBM_LOATHEB_HEAL_REGEXP			= "([^%s]+)受([^%s]+)堕落心灵效果的影响。";
	LVBM_LOATHEB_SUMMON_SPORE			= "洛欧塞布施放了召唤孢子。";
	LVBM_LOATHEB_LOATHEB				= "洛欧塞布";
	
	LVBM_SBT["Inevitable Doom"]			= "必然的厄运";
	LVBM_SBT["Decurse"]					= "驱散诅咒";
	LVBM_SBT["Spore"]					= "孢子";

--------------------------------------------------------------------------------------

--Anub'Rekhan
	LVBM_AR_NAME					= "阿努布雷坎";
	LVBM_AR_DESCRIPTION				= "警报虫群风暴";
	
	LVBM_AR_LOCUST_WARNING			= "*** 虫群风暴 - %s秒后施放 ***";
	LVBM_AR_LOCUST_SOON_WARNING		= "*** 虫群风暴即将施放 ***";
	LVBM_AR_LOCUST_INC_WARNING		= "*** 虫群风暴正在施放 - 3秒施法时间 ***";
	LVBM_AR_GAIN_LOCUST_WARNING		= "*** 虫群风暴已施放 - 持续20秒 ***";
	LVBM_AR_LOCUST_END_WARNING		= "*** 虫群风暴 - %s秒后结束 ***";
	
	LVBM_AR_YELL_1 					= "你们逃不掉的。";
	LVBM_AR_YELL_2 					= "一些小点心……";	
	LVBM_AR_YELL_3 					= "对，跑吧！那样伤口出血就更多了！";
	LVBM_AR_CAST_LOCUST_SWARM 		= "阿努布雷坎开始施放虫群风暴。";
	LVBM_AR_GAIN_LOCUST_SWARM 		= "阿努布雷坎获得了虫群风暴的效果。";
	
	LVBM_SBT["Locust Swarm"]		= "虫群风暴";
	LVBM_SBT["Locust Swarm Cast"]	= "虫群风暴施放";


--Grand Widow Faerlina
	LVBM_GWF_NAME				= "黑女巫法琳娜";
	LVBM_GWF_DESCRIPTION		= "警报激怒";
	
	LVBM_GWF_ENRAGE_WARNING1	= "*** 法琳娜激怒 - 60秒后再次发作 ***";
	LVBM_GWF_ENRAGE_WARNING2	= "*** %s秒后激怒 ***";
	LVBM_GWF_ENRAGE_CD_READY	= "*** 激怒冷却 ***"
	LVBM_GWF_EMBRACE_WARNING	= "*** 黑女巫的拥抱 - %s秒后结束 ***"
	LVBM_GWF_NEXT_ENRAGE_IN		= "*** %s秒后激怒 ***";
	
	LVBM_GWF_YELL_1				= "休想从我面前逃掉！";
	LVBM_GWF_YELL_2				= "以主人之名，杀了他们！";
	LVBM_GWF_YELL_3				= "逃啊！有本事就逃啊！";
	LVBM_GWF_YELL_4				= "跪下求饶吧，懦夫！";
	LVBM_GWF_DEBUFF				= "黑女巫法琳娜受到了黑女巫的拥抱效果的影响。";
	LVBM_GWF_GAIN_ENRAGE		= "黑女巫法琳娜获得了激怒的效果。";
	
	LVBM_SBT["Widow's Embrace"]	= "黑女巫的拥抱";
	LVBM_SBT["Enrage"]			= "激怒";


--Maexxna
	LVBM_MAEXXNA_NAME				= "迈克斯纳";
	LVBM_MAEXXNA_DESCRIPTION		= "警报蛛网喷射和蜘蛛刷新";
	LVBM_MAEXXNA_YELL_ON_WRAP		= "被蛛网裹体后大喊";
	
	LVBM_MAEXXNA_WEB_WRAP_YELL		= "%s被网住了！在%s组！";
	LVBM_MAEXXNA_WRAP_WARNING		= "*** %s被网住了 ***";
	LVBM_MAEXXNA_SPRAY_WARNING		= "*** 蛛网喷射 - %s秒后施放 ***";
	LVBM_MAEXXNA_SPIDER_WARNING		= "*** 小蜘蛛 - %s秒后出现 ***";
	LVBM_MAEXXNA_SPIDERS_SPAWNED	= "*** 小蜘蛛出现 ***";
	
	LVBM_MAEXXNA_WEB_SPRAY			= "蛛网喷射";
	LVBM_MAEXXNA_MAEXXNA			= "迈克斯纳";
	LVBM_MAEXXNA_WEB_WRAP_REGEXP	= "([^%s]+)受([^%s]+)蛛网裹体效果的影响。";
	
	LVBM_SBT["Web Spray"]			= "蛛网喷射";
	LVBM_SBT["Spider Spawn"]		= "蜘蛛刷新";

--------------------------------------------------------------------------------------

-- Sapphiron
	LVBM_SAPPHIRON_NAME 				= "萨菲隆";
	LVBM_SAPPHIRON_INFO					= "警报寒冰炸弹、生命吸取和激怒";
	
	LVBM_SAPPHIRON_YELL_INFO			= "受到寒冰屏障效果后大喊";
	LVBM_SAPPHIRON_YELL_ANNOUNCE		= "我是寒冰屏障！快躲到我后面！";
	
	LVBM_SAPPHIRON_LIFEDRAIN_EXPR1		= "受到了生命吸取效果的影响。";
	LVBM_SAPPHIRON_LIFEDRAIN_EXPR2		= "生命吸取被([^%s]+)抵抗了。";
	LVBM_SAPPHIRON_LIFEDRAIN_ANNOUNCE	= "*** 生命吸取 - 24秒后再次施放 ***";
	LVBM_SAPPHIRON_LIFEDRAIN_WARN		= "*** 生命吸取 - %d秒后施放 ***";
	
	LVBM_SAPPHIRON_DEEPBREATH_EXPR		= "深深地吸了一口气……";
	LVBM_SAPPHIRON_DEEPBREATH_ANNOUNCE	= "*** 寒冰炸弹即将到来 ***";
	
	LVBM_SAPPHIRON_FROSTBOLT_GAIN_EXPR	= "你受到了寒冰箭效果的影响。";
	LVBM_SAPPHIRON_FROSTBOLT_FADE_EXPR	= "寒冰箭效果从你身上消失了。";
	
	LVBM_SAPPHIRON_ENRAGE_ANNOUNCE		= "*** %d秒后激怒 ***";
	
	LVBM_SBT["Enrage"]					= "激怒";
	LVBM_SBT["Frost Breath"]			= "冰霜吐息";
	LVBM_SBT["Life Drain"]				= "生命吸取";
	LVBM_SBT["Deep Breath"]				= "深呼吸";


-- Kel'Thuzad
	LVBM_KELTHUZAD_NAME					= "克尔苏加德";
	LVBM_KELTHUZAD_INFO					= "Announces phases and abilities of the Kel'Thuzad boss fight.";
	
	LVBM_KELTHUZAD_RANGECHECK			= "第二和第三阶段时显示距离框体";
	
	LVBM_KELTHUZAD_PHASE1_EXPR			= "Minions, servants, soldiers of the cold dark! Obey the call of Kel'Thuzad!";
	LVBM_KELTHUZAD_PHASE1_ANNOUNCE		= "*** 第一阶段 ***";
	LVBM_KELTHUZAD_PHASE2_EXPR			= "Pray for mercy!";
	LVBM_KELTHUZAD_PHASE2_ANNOUNCE		= "*** 第二阶段 - 克尔苏加德触发 ***";
	LVBM_KELTHUZAD_PHASE3_EXPR			= "Master, I require aid!";
	LVBM_KELTHUZAD_PHASE3_ANNOUNCE		= "*** 第三阶段 - 寒冰皇冠卫士15秒后出现 ***";
	
	LVBM_KELTHUZAD_MC_EXPR1				= "Your soul is bound to me, now!";
	LVBM_KELTHUZAD_MC_EXPR2				= "There will be no escape!";
	LVBM_KELTHUZAD_MC_ANNOUNCE			= "*** 精神控制 ***";
	LVBM_KELTHUZAD_GUARDIAN_EXPR		= "Very well. Warriors of the frozen wastes, rise up! I command you to fight, kill and die for your master! Let none survive!";
	LVBM_KELTHUZAD_GUARDIAN_ANNOUNCE	= "*** 寒冰皇冠卫士 - 10秒后出现 ***";
	LVBM_KELTHUZAD_FISSURE_EXPR			= "克尔苏加德施放了暗影裂隙。";
	LVBM_KELTHUZAD_FISSURE_ANNOUNCE		= "*** 暗影裂隙 ***";
	LVBM_KELTHUZAD_FROSTBLAST_EXPR		= "([^%s]+)受([^%s]+)冰霜冲击效果的影响。";
	LVBM_KELTHUZAD_FROSTBLAST_ANNOUNCE	= "*** 冰霜冲击 ***";
	LVBM_KELTHUZAD_DETONATE_EXPR		= "([^%s]+)受([^%s]+)自爆法力效果的影响。";
	LVBM_KELTHUZAD_DETONATE_ANNOUNCE	= "*** 自爆法力 - %s ***";
	LVBM_KELTHUZAD_DETONATE_SELFWARN	= "你是炸弹！";
	LVBM_KELTHUZAD_DETONATE_WHISPER		= "你是炸弹！离开人群！";
	
	LVBM_SBT["Phase 2"]					= "第二阶段";
	LVBM_SBT["Kel'Thuzad incoming"]		= "克尔苏加德即将触发";
	LVBM_SBT["Guardians incoming"]		= "寒冰皇冠卫士即将出现";
	LVBM_SBT["Mindcontrol"]				= "精神控制";
	LVBM_SBT["Frost Blast"]				= "冰霜冲击";
	LVBM_SBT["Detonate Mana"]			= "自爆法力";
	LVBM_SBT["Possible next Detonate"]	= "可能的下一次自爆法力";

end
