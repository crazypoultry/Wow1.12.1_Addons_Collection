-- -------------------------------------------- --
-- La Vendetta Boss Mods - Chinese localization --
--       by Diablohu<白银之手>@轻风之语         --
--          http://www.dreamgen.net             --
--                11/14/2006                    --
-- -------------------------------------------- --

if (GetLocale() == "zhCN") then

--Razorgore
	LVBM_RG_NAME			= "狂野的拉佐格尔";
	LVBM_RG_DESCRIPTION		= "黑石军团援军警报";
	
	LVBM_RG_CONTROLLER		= "黑翼控制者";
	LVBM_SBT["Add Spawn"]	= "黑石援军到达";


--Vaelastrasz
	LVBM_VAEL_NAME				= "堕落的瓦拉斯塔兹";
	LVBM_VAEL_DESCRIPTION		= "警报燃烧刺激";
	LVBM_VAEL_SEND_WHISPER		= "密语玩家";
	LVBM_VAEL_SET_ICON			= "添加标注";
	
	LVBM_VAEL_BA_WARNING		= "*** %s正在燃烧 ***";
	LVBM_VAEL_BA_WHISPER		= "你正在燃烧！";
	LVBM_VAEL_BA				= "燃烧刺激";
	
	LVBM_VAEL_BA_REGEXP			= "([^%s]+)受([^%s]+)燃烧刺激效果的影响。";
	LVBM_VAEL_BA_FADES_REGEXP	= "燃烧刺激效果从([^%s]+)身上消失。";


--Lashlayer
	LVBM_LASHLAYER_NAME	= "勒什雷尔";
	LVBM_LASHLAYER_YELL	= "你怎么进来的？你们这种生物不能进来！我要毁灭你们！";


--Firemaw/Ebonroc/Flamegor
	LVBM_FIREMAW_NAME				= "费尔默";
	LVBM_FIREMAW_DESCRIPTION		= "警报龙翼打击";
	LVBM_EBONROC_NAME				= "埃博诺克";
	LVBM_EBONROC_DESCRIPTION		= "警报龙翼打击和埃博诺克之影";
	LVBM_EBONROC_SET_ICON			= "添加标注"
	LVBM_FLAMEGOR_NAME				= "弗莱格尔";
	LVBM_FLAMEGOR_DESCRIPTION		= "警报龙翼打击和狂暴";
	LVBM_FLAMEGOR_ANNOUNCE_FRENZY	= "警报狂暴";
	
	LVBM_FIREMAW_FIREMAW			= "费尔默";
	LVBM_EBONROC_EBONROC			= "埃博诺克";
	LVBM_FLAMEGOR_FLAMEGOR			= "弗莱格尔";
	
	LVBM_FIREMAW_WING_BUFFET		= "费尔默开始施放龙翼打击。";
	LVBM_EBONROC_WING_BUFFET		= "埃博诺克开始施放龙翼打击。";
	LVBM_FLAMEGOR_WING_BUFFET		= "弗莱格尔开始施放龙翼打击。";
	
	LVBM_FIREMAW_SHADOW_FLAME		= "费尔默开始施放暗影烈焰。";
	LVBM_EBONROC_SHADOW_FLAME		= "埃博诺克开始施放暗影烈焰。";
	LVBM_FLAMEGOR_SHADOW_FLAME		= "弗莱格尔开始施放暗影烈焰。";
	
	LVBM_SHADOW_FLAME_WARNING		= "*** 暗影烈焰来临 ***";
	LVBM_WING_BUFFET_WARNING		= "*** 龙翼打击 - %s秒后施放 ***";
	LVBM_EBONROC_SHADOW_WARNING		= "*** %s受到了埃博诺克之影 ***";
	LVBM_FLAMEGOR_FRENZY			= "变得狂暴起来！";
	
	LVBM_EBONROC_SHADOW_REGEXP		= "([^%s]+)受([^%s]+)埃博诺克之影效果的影响。";
	LVBM_EBONROC_SHADOW_REGEXP2		= "埃博诺克之影效果从([^%s]+)身上消失。";
	
	LVBM_SBT["Wing Buffet"]			= "龙翼打击";
	LVBM_SBT["Wing Buffet Cast"]	= "龙翼打击施放";
	LVBM_SBT["Shadow Flame Cast"]	= "暗影烈焰施放";


--Chromaggus
	LVBM_CHROMAGGUS_NAME					= "克洛玛古斯";
	LVBM_CHROMAGGUS_DESCRIPTION				= "警报元素吐息和抗性弱点";
	LVBM_CHROMAGGUS_ANNOUNCE_FRENZY			= "警报狂暴";
	LVBM_CHROMAGGUS_ANNOUNCE_VULNERABILITY	= "警报抗性弱点"
	LVBM_CHROMAGGUS_BREATH_1				= "吐息 1 ";
	LVBM_CHROMAGGUS_BREATH_2				= "吐息 2 ";
	
	LVBM_CHROMAGGUS_BREATH_CAST_WARNING		= "*** 克洛玛古斯开始施放%s ***"
	LVBM_CHROMAGGUS_BREATH_WARNING			= "*** %s - 10秒后施放 ***"
	
	LVBM_CHROMAGGUS_BREATH_REGEXP			= "克洛玛古斯开始施放([^%s]+)。";
	LVBM_CHROMAGGUS_VULNERABILITY_REGEXP	= "([^%s]+)的([^%s]+)([^%s]+)克洛玛古斯造成(%d+)点([^%s]+)伤害。";
	LVBM_CHROMAGGUS_CHROMAGGUS				= "克洛玛古斯";
	
	LVBM_CHROMAGGUS_FRENZY_EXPR				= "%s变得极为狂暴！";
	LVBM_CHROMAGGUS_FRENZY_ANNOUNCE			= "*** 狂暴 ***";
	
	LVBM_CHROMAGGUS_VULNERABILITY_EXPR		= "%s的皮肤闪着微光，它畏缩了。";
	LVBM_CHROMAGGUS_VULNERABILITY_ANNOUNCE	= "*** 抗性改变 ***";
	
	LVBM_SBT["Breath 1"]					= "吐息 1 ";
	LVBM_SBT["Breath 2"]					= "吐息 2 ";


--Nefarian
	LVBM_NEFARIAN_NAME					= "奈法利安";
	LVBM_NEFARIAN_DESCRIPTION			= "警报职业点名";
	LVBM_NEFARIAN_BLOCK_HEALS			= "喊叫牧师时牧师停止治疗";
	LVBM_NEFARIAN_UNEQUIP_BOW			= "在职业喊叫前卸下远程武器";

	LVBM_NEFARIAN_SYNCKILLS_INFO			= "第一阶段同步龙兽击杀计数";

	LVBM_NEFARIAN_FEAR_WARNING			= "*** 低沉咆哮 - 1.5秒后施放 ***";
	LVBM_NEFARIAN_PHASE2_WARNING		= "*** 奈法利安 - 15秒后着陆 ***";
	LVBM_NEFARIAN_CLASS_CALL_WARNING	= "*** 即将点名 ***";
	LVBM_NEFARIAN_SHAMAN_WARNING		= "*** 萨满祭司 - 图腾 ***";
	LVBM_NEFARIAN_PALA_WARNING			= "*** 圣骑士 - 保护祝福 ***";
	LVBM_NEFARIAN_DRUID_WARNING			= "*** 德鲁伊 - 猎豹形态 ***";
	LVBM_NEFARIAN_PRIEST_WARNING		= "*** 牧师 - 停止治疗 ***";
	LVBM_NEFARIAN_WARRIOR_WARNING		= "*** 战士 - 狂暴姿态 ***";
	LVBM_NEFARIAN_ROGUE_WARNING			= "*** 盗贼 - 被传送并定身 ***";
	LVBM_NEFARIAN_WARLOCK_WARNING		= "*** 术士 - 地狱火 ***";
	LVBM_NEFARIAN_HUNTER_WARNING		= "*** 猎人 - 远程武器损坏 ***";
	LVBM_NEFARIAN_MAGE_WARNING			= "*** 法师 - 变形术 ***";
	LVBM_NEFARIAN_PRIEST_CALL			= "叫喊牧师";
	LVBM_NEFARIAN_HEAL_BLOCKED			= "叫喊牧师时你不允许施放%s！";
	LVBM_NEFARIAN_UNEQUIP_ERROR			= "卸下远程武器发生错误"
	LVBM_NEFARIAN_EQUIP_ERROR			= "装备远程武器发生错误"

	LVBM_NEFARIAN_DRAKONID_DOWN = {};
	LVBM_NEFARIAN_DRAKONID_DOWN[1] = "黑色龙兽死亡了。";
	LVBM_NEFARIAN_DRAKONID_DOWN[2] = "蓝色龙兽死亡了。";
	LVBM_NEFARIAN_DRAKONID_DOWN[3] = "绿色龙兽死亡了。";
	LVBM_NEFARIAN_DRAKONID_DOWN[4] = "青铜龙兽死亡了。";
	LVBM_NEFARIAN_DRAKONID_DOWN[5] = "红色龙兽死亡了。";
	LVBM_NEFARIAN_DRAKONID_DOWN[6] = "多彩龙兽死亡了。";

	LVBM_NEFARIAN_KILLCOUNT	= "已击杀龙兽: %d";
	
	LVBM_NEFARIAN_BLOCKED_SPELLS = {
		["快速治疗"]	= 1.5,
		["强效治疗术"]	= 2.5,
		["治疗祷言"]	= 3,
		["治疗"]		= 2.5,
		["次级治疗术"]	= 1.5,
	--	["神圣新星"]	= 0,
	}
	
	LVBM_NEFARIAN_CAST_SHADOW_FLAME		= "奈法利安开始施放暗影烈焰。";
	LVBM_NEFARIAN_CAST_FEAR				= "奈法利安开始施放低沉咆哮。";
	LVBM_NEFARIAN_YELL_PHASE1			= "比赛开始！";
	LVBM_NEFARIAN_YELL_PHASE2			= "干得好，我的手下。凡人的勇气开始消退了！现在，让我们看看他们如何应对黑石塔的真正主人的力量！！！";
	LVBM_NEFARIAN_YELL_PHASE3			= "不可能！出现吧，我的仆人！再次为你们的主人效力！";
	LVBM_NEFARIAN_YELL_SHAMANS			= "萨满祭司，让我看看";
	LVBM_NEFARIAN_YELL_PALAS			= "圣骑士……听说你们有无数条命。让我看看到底是怎么样的吧。";
	LVBM_NEFARIAN_YELL_DRUIDS			= "德鲁伊和你们愚蠢变形法术。让我们看看有什么事情会发生吧！";
	LVBM_NEFARIAN_YELL_PRIESTS			= "牧师们！如果你们要继续这么治疗的话，那我们就来玩点有趣的东西吧！";
	LVBM_NEFARIAN_YELL_WARRIORS			= "战士们，我知道你们应该更凶猛一些！让我们来见识一下吧！";
	LVBM_NEFARIAN_YELL_ROGUES			= "盗贼？不要躲躲藏藏了，勇敢地面对我吧！";
	LVBM_NEFARIAN_YELL_WARLOCKS			= "术士们，不要随便去尝试那些你们根本不理解的法术。看到后果了吧？";
	LVBM_NEFARIAN_YELL_HUNTERS			= "猎人们，还有你们那些讨厌的玩具枪！";
	LVBM_NEFARIAN_YELL_MAGES			= "你们也是法师？小心别玩火自焚……";
	LVBM_NEFARIAN_YELL_DEAD				= "这不可能！我是这里的主人！你们这些凡人对于我来说一无是处！听到了没有？一无是处！";
	
	LVBM_SBT["Class call CD"] 			= "职业点名冷却";
	LVBM_SBT["Druid call"] 				= "德鲁伊";
	LVBM_SBT["Priest call"] 			= "牧师";
	LVBM_SBT["Warrior call"] 			= "战士";
	LVBM_SBT["Rogue call"] 				= "盗贼";
	LVBM_SBT["Mage call"] 				= "法师";

end
