--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]

function SC_Localization_zhTW()
	-- TW Chinese localized variables
	-- general

	STATCOMPARE_CAT_ATT = "屬性";
	STATCOMPARE_CAT_RES = "抗性";
	STATCOMPARE_CAT_SKILL = "技能";
	STATCOMPARE_CAT_BON = "近戰&遠程攻擊";
	STATCOMPARE_CAT_SBON = "法術";
	STATCOMPARE_CAT_OBON = "生命與法力";

	STATCOMPARE_ATTACKNAME = "攻擊";
		
	-- bonus names --- 顯示菜單用
	STATCOMPARE_STR = "力量";
	STATCOMPARE_AGI = "敏捷";
	STATCOMPARE_STA = "耐力";
	STATCOMPARE_INT = "智力";
	STATCOMPARE_SPI = "精神";
	STATCOMPARE_ARMOR = "護甲";
	STATCOMPARE_ENARMOR = "強化護甲";
	STATCOMPARE_DAMAGEREDUCE = "物理免傷";

	STATCOMPARE_ARCANERES	= "祕法抗性";	
	STATCOMPARE_FIRERES	= "火焰抗性";
	STATCOMPARE_NATURERES	= "自然抗性";
	STATCOMPARE_FROSTRES	= "冰霜抗性";
	STATCOMPARE_SHADOWRES	= "陰影抗性";
	STATCOMPARE_DETARRES	= "降低目標抗性";
	STATCOMPARE_ALLRES	= "所有抗性";

	STATCOMPARE_FISHING	= "釣魚";
	STATCOMPARE_MINING	= "挖礦";
	STATCOMPARE_HERBALISM	= "草藥";
	STATCOMPARE_SKINNING	= "剝皮";
	STATCOMPARE_DEFENSE	= "防禦技能";
		
	STATCOMPARE_BLOCK	= "格擋";
	STATCOMPARE_TOBLOCK	= "格擋幾率";
	STATCOMPARE_DODGE	= "躲閃";
	STATCOMPARE_PARRY	= "招架";
	STATCOMPARE_ATTACKPOWER = "攻擊強度";
	STATCOMPARE_ATTACKPOWERUNDEAD = "對亡靈攻擊強度";
	STATCOMPARE_CRIT	= "致命一擊";
	STATCOMPARE_RANGEDATTACKPOWER = "遠程攻擊強度";
	STATCOMPARE_RANGEDCRIT	= "遠程攻擊致命一擊";
	STATCOMPARE_TOHIT	= "命中率";
	STATCOMPARE_DMG		= "法術傷害";
	STATCOMPARE_DMGUNDEAD	= "對亡靈法術傷害";
	STATCOMPARE_ARCANEDMG	= "祕法傷害";
	STATCOMPARE_FIREDMG	= "火焰傷害";
	STATCOMPARE_FROSTDMG	= "冰霜傷害";
	STATCOMPARE_HOLYDMG	= "神聖傷害";
	STATCOMPARE_NATUREDMG	= "自然傷害";
	STATCOMPARE_SHADOWDMG	= "暗影傷害";
	STATCOMPARE_SPELLCRIT	= "法術致命一擊";
	STATCOMPARE_SPELLTOHIT	= "法術命中率";
	STATCOMPARE_HEAL	= "治療";
	STATCOMPARE_HOLYCRIT	= "神聖致命一擊";
	STATCOMPARE_NATURECRIT	= "自然致命一擊";
	STATCOMPARE_HEALTHREG	= "生命再生";
	STATCOMPARE_MANAREG	= "法力再生";
	STATCOMPARE_MANAREGSPI	= "精神回魔";
	STATCOMPARE_HEALTH	= "生命力";
	STATCOMPARE_MANA	= "法力";
	STATCOMPARE_DRUID_BEAR	= "巨熊形態";
	STATCOMPARE_DRUID_CAT	= "獵豹形態";

	STATCOMPARE_FLASHHOLYLIGHT_HEAL	=	"聖光閃現";
	STATCOMPARE_LESSER_HEALING_WAVE_HEAL = "次級治療波";
	STATCOMPARE_CHAIN_LIGHTNING_DAM	= "閃電鍊";
	STATCOMPARE_EARTH_SHOCK_DAM = "地震術";
	STATCOMPARE_FLAME_SHOCK_DAM = "火焰震擊";
	STATCOMPARE_FROST_SHOCK_DAM = "冰霜震擊";
	STATCOMPARE_LIGHTNING_BOLT_DAM = "閃電箭";

	-- equip and set bonus patterns:
	STATCOMPARE_EQUIP_PREFIX = "裝備：";
	STATCOMPARE_SET_PREFIX = "套裝：";

	STATCOMPARE_EQUIP_PATTERNS = {
		{ pattern = "+(%d+)遠程攻擊強度。", effect = "RANGEDATTACKPOWER" },
		{ pattern = "+(%d+) 耐力。", effect = "STA" },
		{ pattern = "+(%d+) 敏捷。", effect = "AGI" },
		{ pattern = "+(%d+) 力量。", effect = "STR" },
		{ pattern = "+(%d+) 智力。", effect = "INT" },
		{ pattern = "+(%d+) 祕法抗性。", effect = "ARCANERES" },
		{ pattern = "+(%d+) 火焰抗性。", effect = "FIRERES" },
		{ pattern = "+(%d+) 暗影抗性。", effect = "SHADOWRES" },
		{ pattern = "+(%d+) 自然抗性。", effect = "NATURERES" },
		{ pattern = "+(%d+) 冰霜抗性。", effect = "FROSTRES" },
		{ pattern = "+(%d+) 護甲。", effect = "ENARMOR"},
		{ pattern = "+(%d+) 攻擊強度。", effect = "ATTACKPOWER"},
		{ pattern = "+(%d+) 所有魔法抗性。", effect = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"} },
		{ pattern = "使你用盾牌格擋攻擊的機率提高(%d+)%%。", effect = "TOBLOCK" },
		{ pattern = "使你的盾牌格擋值提高(%d+)點。", effect = "BLOCK" },
		{ pattern = "使你躲閃攻擊的機率提高(%d+)%%。", effect = "DODGE" },
		{ pattern = "使你招架攻擊的機率提高(%d+)%%。", effect = "PARRY" },
		{ pattern = "使你的法術造成致命一擊的機率提高(%d+)%%。", effect = "SPELLCRIT" },
		{ pattern = "使你造成致命一擊的機率提高(%d+)%%。", effect = "CRIT" },
		{ pattern = "使你打出致命一擊的機率提高(%d+)%%。", effect = "CRIT" },
		{ pattern = "提高祕法法術和效果所造成的傷害，最多(%d+)點。", effect = "ARCANEDMG" },
		{ pattern = "提高火焰法術和效果所造成的傷害，最多(%d+)點。", effect = "FIREDMG" },
		{ pattern = "提高冰霜法術和效果所造成的傷害，最多(%d+)點。", effect = "FROSTDMG" },
		{ pattern = "提高神聖法術和效果所造成的傷害，最多(%d+)點。", effect = "HOLYDMG" },
		{ pattern = "提高自然法術和效果所造成的傷害，最多(%d+)點。", effect = "NATUREDMG" },
		{ pattern = "提高暗影法術和效果所造成的傷害，最多(%d+)點。", effect = "SHADOWDMG" },
		{ pattern = "使暗影法術所造成的傷害提高最多(%d+)點。", effect = "SHADOWDMG" },
		{ pattern = "提高法術和魔法效果所造成的治療效果，最多(%d+)點。", effect = "HEAL" },
		{ pattern = "提高法術和魔法效果所造成的傷害和治療效果，最多(%d+)點。", effect = {"HEAL", "DMG"} },
		{ pattern = "每5秒回復(%d+)點生命力。", effect = "HEALTHREG" },
		{ pattern = "每5秒恢復(%d+)點生命力。", effect = "HEALTHREG" },
		{ pattern = "每5秒恢復(%d+)點法力。", effect = "MANAREG" },
		{ pattern = "每5秒回復(%d+)點法力。", effect = "MANAREG" },
		{ pattern = "使你的生命力和法力回復提高(%d+)點。", effect = {"MANAREG","HEALTHREG"} },
		{ pattern = "使你擊中目標的機率提高(%d+)%%。", effect = "TOHIT" },
		{ pattern = "使你的盾牌的格擋值提高(%d+)點。", effect = "BLOCK"},
		{ pattern = "使你的法術擊中敵人的機率提高(%d+)%%。", effect = "SPELLTOHIT" },
		{ pattern = "防禦技能提高(%d+)點。", effect = "DEFENSE" },
		{ pattern = "使你的神聖系法術的致命一擊和極效治療機率提高(%d+)%%。", effect = "HOLYCRIT" },
		{ pattern = "使你的神聖法術造成致命一擊的機率提高(%d+)%%。", effect = "HOLYCRIT" },
		{ pattern = "使治療法術和效果所回復的生命値提高(%d+)點。", effect = "HEAL" },
		{ pattern = "使治療法術和效果所回復的生命力提高(%d+)點。", effect = "HEAL" },
		{ pattern = "使法術的治療效果提高最多(%d+)點。", effect = "HEAL" }, 	-- thanks kkk36@mop
		{ pattern = "使暗影法術和效果所造成的傷害提高(%d+)點。", effect = "SHADOWDMG" },
		{ pattern = "剝皮技能提高(%d+)點。", effect = "SKINNING" },
		{ pattern = "釣魚技能提高(%d+)點。", effect = "FISHING"},
		{ pattern = "草藥學技能%+(%d+)點。", effect = "HERBALISM"},--*** 
		{ pattern = "使你法術目標的魔法抗性降低(%d+)點。", effect = "DETARRES" },
		{ pattern = "使你的自然系法術造成致命一擊的機率提高(%d+)%%。", effect = "NATURECRIT" },
		{ pattern = "防禦力提高3點，暗影抗性提高10點，生命力恢復速度提高3點。", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"}, value = {3, 10, 3}},
		{ pattern = "提高聖光閃的治療效果最多(%d+)點", effect = "FLASHHOLYLIGHTHEAL"},
		{ pattern = "提高次級治療波的治療效果最多(%d+)點。", effect = "LESSERHEALWAVE"},
		{ pattern = "提高閃電鍊和閃電箭的傷害最多(%d+)點。",	effect = {"CHAINLIGHTNING","LIGHTNINGBOLT"}},
		{ pattern = "提高地震術、烈焰震擊、冰霜震擊所造成的傷害(%d+)點。",	effect = {"EARTHSHOCK","FLAMESHOCK","FROSTSHOCK"}}, 
		{ pattern = "對不死生物的攻擊強度提高(%d+)點。", effect = "ATTACKPOWERUNDEAD"},
		{ pattern = "對不死生物的攻擊強度提高(%d+)點。同時也可獲得天譴石。", effect = "ATTACKPOWERUNDEAD"},
		{ pattern = "提高法術和魔法效果對不死生物所造成的傷害，最多(%d+)點。", effect = "DMGUNDEAD"},
		{ pattern = "提高法術和魔法效果對不死生物所造成的傷害，最多(%d+)點。同時也可為銀色黎明收集天譴石。", effect = "DMGUNDEAD"},
		{ pattern = "使魔法和法術效果對不死生物造成的傷害提高最多(%d+)點。同時也可為銀色黎明收集天譴石", effect = "DMGUNDEAD"},
	};


	STATCOMPARE_S1 = {
		{ pattern = "祕法", 	effect = "ARCANE" },
		{ pattern = "火焰", 	effect = "FIRE" },	
		{ pattern = "冰霜", 	effect = "FROST" },	
		{ pattern = "神聖", 	effect = "HOLY" },	
		{ pattern = "陰影",	effect = "SHADOW" },
		{ pattern = "暗影",	effect = "SHADOW" },
		{ pattern = "自然", 	effect = "NATURE" }
	}; 	

	STATCOMPARE_S2 = {
		{ pattern = "抗性", 	effect = "RES" },	
		{ pattern = "傷害", 	effect = "DMG" },
		{ pattern = "效果", 	effect = "DMG" },
	}; 	
		
	STATCOMPARE_TOKEN_EFFECT = {
		["所有屬性"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
		["力量"]			= "STR",
		["敏捷"]			= "AGI",
		["耐力"]			= "STA",
		["智力"]			= "INT",
		["精神"] 			= "SPI",
		["治療和法術傷害"]		= {"DMG", "HEAL"},
		["傷害和治療法術"]		= {"DMG", "HEAL"},
		["法術治療和傷害"]		= {"DMG", "HEAL"},
		["法術傷害和治療"]		= {"DMG", "HEAL"},
		["法術傷害"] 			= {"DMG", "HEAL"},

		["所有抗性"] 			= {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},

		["釣魚"]			= "FISHING",
		["魚餌"]			= "FISHING",
		["採礦"]			= "MINING",
		["草藥學"]		= "HERBALISM",
		["剝皮"]			= "SKINNING",

		["攻擊強度。"] 			= "ATTACKPOWER",
		["攻擊強度"] 			= "ATTACKPOWER",
		["格擋值"]			= "BLOCK",
		["閃躲"] 			= "DODGE",
		["躲閃"] 			= "DODGE",
		["躲避"] 			= "DODGE",
		["閃避"] 			= "DODGE",
		["命中"] 			= "TOHIT",
		["法術命中"]			= "SPELLTOHIT",
		["遠程攻擊強度"]		= "RANGEDATTACKPOWER",
		["每5秒回復生命"]		= "HEALTHREG",
		["治療法術"] 		= "HEAL",
		["每5秒恢復法力"] 		= "MANAREG",
		["法力恢復"]			= "MANAREG",
		["法力回復"]			= "MANAREG",
		["傷害"] 				= "DMG",
		["致命一擊"]			= "CRIT",
		["生命力"]			= "HEALTH",
		["法力"]			= "MANA",
		["護甲"]			= "ARMOR",
		["強化護甲"]			= "ENARMOR",
		["防禦技能"]			= "DEFENSE",
		["防禦"]			= "DEFENSE",
		["攻擊強度vs不死生物.*$"]	= "ATTACKPOWERUNDEAD",
	};

	STATCOMPARE_OTHER_PATTERNS = {
		{ pattern = "(%d+)格擋", effect = "BLOCK"},
		{ pattern = "(%d+)點格擋", effect = "BLOCK"},
		{ pattern = "(%d+)點護甲", effect = "ARMOR"},
		{ pattern = "格擋 %+(%d+)%%", effect = "TOBLOCK"},
		{ pattern = "每5秒回復(%d+)點生命[。]", effect = "HEALTHREG" },
		{ pattern = "每5秒恢復(%d+)點生命[。]", effect = "HEALTHREG" },
		{ pattern = "每5秒回復(%d+)點法力[。]", effect = "MANAREG" },
		{ pattern = "每5秒恢復(%d+)點法力[。]", effect = "MANAREG" },
		{ pattern = "恆金漁線", effect = "FISHING", value = 5 },
	};

	-- Spells Related
	STATCOMPARE_HEALSPELL_PREFIX	= "治療法術";
	STATCOMPARE_ATTACKSPELL_PREFIX	= "傷害法術";
	STATCOMPARE_SPELLSKILL_INFO	= "法術/技能";
	STATCOMPARE_DOT_PREFIX		= " DOT";
	STATCOMPARE_HOT_PREFIX		= " HOT";
	STATCOMPARE_HEALIN_TOUCH	= "治療之觸";
	STATCOMPARE_REGROWTH		= "癒合　　";
	STATCOMPARE_REJUVENATION	= "回春術　";
	STATCOMPARE_TRANQUILITY		= "寧靜　　";
	STATCOMPARE_WRATH		= "憤怒　　";
	STATCOMPARE_STARFIRE		= "星火術　";
	STATCOMPARE_MOONFIRE		= "月火術　";
	STATCOMPARE_INSECTSWARM		= "虫群　　";
	STATCOMPARE_LESSER_HEAL		= "次級治療";
	STATCOMPARE_HEAL		= "治療　　";
	STATCOMPARE_SPELL_HOLYFIRE	= "神聖之火";
	STATCOMPARE_SPELL_HOLYNOVA	= "神聖新星";
	STATCOMPARE_SPELL_MANABURN	= "法力燃燒";
	STATCOMPARE_SPELL_SMITE		= "懲擊　　";
	STATCOMPARE_SPELL_PAIN		= "痛　　　";
	STATCOMPARE_SPELL_MINDBLAST	= "心靈震爆";
	STATCOMPARE_SPELL_MINDFLAY	= "精神鞭笞";
	STATCOMPARE_FLASH_HEAL		= "快速治療";
	STATCOMPARE_GREATER_HEAL	= "強效治療";
	STATCOMPARE_RENEW		= "恢復　　";
	STATCOMPARE_PRAYER_OF_HEALING	= "治療禱言";
	STATCOMPARE_HEALING_WAVE	= "治療波";
	STATCOMPARE_LESSER_HEALING_WAVE = "次級治療波";
	STATCOMPARE_CHAIN_HEAL		= "治療鍊　";
	STATCOMPARE_CHAIN_LIGHTNING	= "閃電鍊　";
	STATCOMPARE_EARTH_SHOCK		= "地震術　";
	STATCOMPARE_FLAME_SHOCK		= "火焰震擊";
	STATCOMPARE_FROST_SHOCK		= "冰霜震擊";
	STATCOMPARE_LIGHTNING_BOLT	= "閃電箭　";
	STATCOMPARE_HOLY_LIGHT		= "聖光術　";
	STATCOMPARE_HOLY_SHOCK		= "神聖震擊";
	STATCOMPARE_HOLY_WRATH		= "神聖憤怒";
	STATCOMPARE_FLASH_OF_LIGHT	= "聖光閃現";
	STATCOMPARE_CONSECRATION	= "奉獻　　";
	STATCOMPARE_EXORCISM		= "駆邪術　";
	STATCOMPARE_HAMMER_OF_WRATH	= "憤怒之錘";
	STATCOMPARE_ARCANEEXPLOSION	= "奧暴　　";
	STATCOMPARE_ARCANEMISSILES	= "祕法飛彈";
	STATCOMPARE_BLASTWAVE		= "衝擊波　";
	STATCOMPARE_BLIZZARD		= "暴風雪　";
	STATCOMPARE_CONECOLD		= "吹風　　";
	STATCOMPARE_FIREBALL		= "火球術　";
	STATCOMPARE_FIREBLAST		= "火焰衝擊";
	STATCOMPARE_FROSTBOLT		= "寒冰箭　";
	STATCOMPARE_PYROBLAST		= "炎爆術　";
	STATCOMPARE_SCORCH		= "灼燒　　";
	STATCOMPARE_SRCANE_SHOT		= "祕法射擊";
	STATCOMPARE_EXPLOSIVE_TRAP	= "爆炸陷阱";
	STATCOMPARE_IMMOLATION_TRAP	= "獻祭陷阱";
	STATCOMPARE_SERPENT_STING	= "毒蛇釘刺";
	STATCOMPARE_VOLLEY		= "瞄準射擊";
	STATCOMPARE_WYVERN_STING	= "";
	STATCOMPARE_CONFLAGRATE		= "燃燒　　";
	STATCOMPARE_CORRUPTION		= "腐蝕術　";
	STATCOMPARE_CURSE_OF_AGONY	= "痛苦詛咒";
	STATCOMPARE_DRAIN_LIFE		= "吸取生命";
	STATCOMPARE_DRAIN_SOUL		= "吸取靈魂";
	STATCOMPARE_DEATH_COIL		= "死亡纏繞";
	STATCOMPARE_HELLFIRE		= "地獄火　";
	STATCOMPARE_IMMOLATE		= "獻祭　　";
	STATCOMPARE_RAIN_OF_FIRE	= "火焰之雨";
	STATCOMPARE_SEARING_PAIN	= "燒灼之痛";
	STATCOMPARE_SIPHON_LIFE		= "生命虹吸";
	STATCOMPARE_SHADOW_BOLT		= "暗影箭　";
	STATCOMPARE_SHADOWBURN		= "暗影灼燒";
	STATCOMPARE_SOUL_FIRE		= "靈魂之火";
end
