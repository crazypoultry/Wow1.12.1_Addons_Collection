-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--       by Diablohu<白银之手>@轻风之语         --
--          http://www.dreamgen.net             --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then


-- High Priestess Jeklik
	LVBM_JEKLIK_NAME				= "高阶祭司耶克里克";
	LVBM_JEKLIK_INFO				= "警报召唤蝙蝠和强效治疗术";
	LVBM_JEKLIK_BOMBBATS_EXPR		= "我命令你把这些入侵者烧成灰烬！";
	LVBM_JEKLIK_BOMBBATS_ANNOUNCE	= "*** 蝙蝠即将实施轰炸 ***";
	LVBM_JEKLIK_CASTHEAL_EXPR		= "%s开始施放强效治疗术！";
	LVBM_JEKLIK_CASTHEAL_ANNOUNCE	= "*** 强效治疗术 - 打断 ***";
	LVBM_JEKLIK_BATS_EXPR			= "%s发出刺耳尖啸！";
	LVBM_JEKLIK_BATS_ANNOUNCE		= "*** 蝙蝠即将到来 ***";


-- High Priest Venoxis
	LVBM_VENOXIS_NAME				= "高阶祭司温诺希斯";
	LVBM_VENOXIS_INFO				= "警报恢复效果";
	LVBM_VENOXIS_RENEW_EXPR			= "高阶祭司温诺希斯获得了恢复的效果。";
	LVBM_VENOXIS_RENEW_ANNOUNCE		= "*** 恢复 - 牧师驱散 ***";
	LVBM_VENOXIS_TRANSFORM_EXPR		= "让复仇的毒蛇吞噬你们吧！";
	LVBM_VENOXIS_TRANSFORM_ANNOUNCE = "*** 第二阶段 - 小心毒云 ***";


-- High Priestess Mar'li
	LVBM_MARLI_NAME				= "高阶祭司玛尔里";
	LVBM_MARLI_INFO				= "警报蜘蛛刷新";
	LVBM_MARLI_SPIDER_EXPR		= "来为我作战吧，我的孩子们！";
	LVBM_MARLI_SPIDER_ANNOUNCE	= "*** 蜘蛛刷新 ***";


-- Bloodlord Mandokir
	LVBM_MANDOKIR_NAME			= "血领主曼多基尔";
	LVBM_MANDOKIR_INFO			= "警报曼多基尔所注视的对象";
	LVBM_MANDOKIR_WATCH_EXPR		= "([^%s]+)！我正在看着你！";
	LVBM_MANDOKIR_WATCH_ANNOUNCE	= "*** %s被注视了 ***";
	LVBM_MANDOKIR_SETICON_INFO		= "添加标注";
	LVBM_MANDOKIR_WHISPER_INFO		= "密语玩家";
	LVBM_MANDOKIR_WHISPER_TEXT		= "你被注视了！";
	LVBM_MANDOKIR_SELFWARN			= "你被注视了！";


-- Thekal - eg heal ability
	LVBM_THEKAL_NAME	= "高阶祭司塞卡尔";


-- High Priestess Arlokk
	LVBM_ARLOKK_NAME			= "高阶祭司娅尔罗";
	LVBM_ARLOKK_INFO			= "警报标记技能";
	LVBM_ARLOKK_MARK_EXPR		= "吞噬([^%s]+)的躯体吧！";
	LVBM_ARLOKK_MARK_ANNOUNCE	= "*** %s被标记 - 治疗他 ***";
	LVBM_ARLOKK_MARK_WHISPER	= "你被标记了！";
	LVBM_ARLOKK_WHISPER_INFO	= "密语被标记的玩家";


-- Jin'do the Hexxer
	LVBM_JINDO_NAME					= "妖术师金度";
	LVBM_JINDO_INFO					= "警报诅咒和图腾";
	LVBM_JINDO_CURSE_INFO			= "警报诅咒";
	LVBM_JINDO_HEAL_TOTEM_INFO		= "警报治疗图腾";
	LVBM_JINDO_MC_TOTEM_INFO		= "警报洗脑图腾";
	LVBM_JINDO_CURSE_EXPR			= "([^%s]+)受([^%s]+)金度的欺骗效果的影响。";
	LVBM_JINDO_CURSE_SELF_ANNOUNCE	= "你被诅咒了";
	LVBM_JINDO_CURSE_ANNOUNCE		= "*** %s被诅咒 - 不要驱散 ***";
	LVBM_JINDO_HEAL_TOTEM_WARNING	= "*** 治疗图腾 ***";
	LVBM_JINDO_MC_TOTEM_WARNING		= "*** 洗脑图腾 ***";
	LVBM_JINDO_WHISPER_INFO			= "密语玩家";
	LVBM_JINDO_WHISPER_TEXT			= "你被诅咒了！杀掉影子！";
	LVBM_JINDO_HEAL_TOTEM			= "妖术师金度施放了强力治疗结界。";
	LVBM_JINDO_MIND_CONTROL_TOTEM	= "妖术师金度施放了召唤洗脑图腾。";


-- Hakkar
	LVBM_HAKKAR_NAME				= "哈卡";
	LVBM_HAKKAR_INFO				= "警报血液虹吸";
	LVBM_HAKKAR_SUFFERLIFE_EXPR		= "([^%s]+)血液虹吸使哈卡受到了([^%s]+)";
	LVBM_HAKKAR_SUFFERLIFE_ANNOUNCE	= "*** 血液虹吸 - %d秒后施放 ***";
	LVBM_HAKKAR_SUFFERLIFE_NOW		= "*** 血液虹吸 - 90秒后再次施放 ***";
	LVBM_HAKKAR_COMBAT_START_YELL	= "骄傲会将你送上绝路。来吧，凡人！品尝夺灵者的愤怒吧！";
	
	LVBM_SBT["Life Drain"] 			= "血液虹吸";

end
