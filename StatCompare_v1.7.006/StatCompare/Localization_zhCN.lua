--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]
function SC_Localization_zhCN()

	STATCOMPARE_CAT_ATT = "属性";
	STATCOMPARE_CAT_RES = "抗性";
	STATCOMPARE_CAT_SKILL = "技能";
	STATCOMPARE_CAT_BON = "近战&远程攻击";
	STATCOMPARE_CAT_SBON = "法术";
	STATCOMPARE_CAT_OBON = "生命&法力";

	STATCOMPARE_ATTACKNAME = "攻击";
		
	-- bonus names --- 显示菜单用
	STATCOMPARE_STR = "力量";
	STATCOMPARE_AGI = "敏捷";
	STATCOMPARE_STA = "耐力";
	STATCOMPARE_INT = "智力";
	STATCOMPARE_SPI = "精神";
	STATCOMPARE_ARMOR = "护甲";
	STATCOMPARE_ENARMOR = "强化护甲";
	STATCOMPARE_DAMAGEREDUCE = "物理免伤";

	STATCOMPARE_ARCANERES = "奥术抗性";	
	STATCOMPARE_FIRERES	= "火焰抗性";
	STATCOMPARE_NATURERES = "自然抗性";
	STATCOMPARE_FROSTRES	= "冰霜抗性";
	STATCOMPARE_SHADOWRES	= "阴影抗性";
	STATCOMPARE_DETARRES	= "降低目标抗性";
	STATCOMPARE_ALLRES	= "所有抗性";

	STATCOMPARE_FISHING	= "钓鱼";
	STATCOMPARE_MINING	= "挖矿";
	STATCOMPARE_HERBALISM	= "草药";
	STATCOMPARE_SKINNING	= "剥皮";
	STATCOMPARE_DEFENSE	= "防御技能";
		
	STATCOMPARE_BLOCK = "格挡";
	STATCOMPARE_TOBLOCK = "格挡率";
	STATCOMPARE_DODGE = "躲闪";
	STATCOMPARE_PARRY = "招架";
	STATCOMPARE_ATTACKPOWER = "攻击强度";
	STATCOMPARE_ATTACKPOWERUNDEAD = "对亡灵攻击强度";
	STATCOMPARE_CRIT = "致命";
	STATCOMPARE_RANGEDATTACKPOWER = "远程攻击强度";
	STATCOMPARE_RANGEDCRIT = "远程攻击致命";
	STATCOMPARE_TOHIT = "命中率";
	STATCOMPARE_DMG = "法术伤害";
	STATCOMPARE_DMGUNDEAD	= "对亡灵法术伤害";
	STATCOMPARE_ARCANEDMG = "奥术伤害";
	STATCOMPARE_FIREDMG = "火焰伤害";
	STATCOMPARE_FROSTDMG = "冰霜伤害";
	STATCOMPARE_HOLYDMG = "神圣伤害";
	STATCOMPARE_NATUREDMG = "自然伤害";
	STATCOMPARE_SHADOWDMG = "暗影伤害";
	STATCOMPARE_SPELLCRIT = "法术致命";
	STATCOMPARE_SPELLTOHIT = "法术命中率";
	STATCOMPARE_HEAL = "治疗";
	STATCOMPARE_HOLYCRIT = "神圣法术致命";
	STATCOMPARE_NATURECRIT = "自然系法术致命";
	STATCOMPARE_HEALTHREG = "生命再生";
	STATCOMPARE_MANAREG = "法力再生";
	STATCOMPARE_MANAREGSPI = "精神回魔";
	STATCOMPARE_HEALTH = "生命值";
	STATCOMPARE_MANA = "法力值";
	STATCOMPARE_DRUID_BEAR = "巨熊形态";
	STATCOMPARE_DRUID_CAT = "猎豹形态";

	STATCOMPARE_FLASHHOLYLIGHT_HEAL = "圣光闪现";
	STATCOMPARE_LESSER_HEALING_WAVE_HEAL = "次级治疗波";
	STATCOMPARE_CHAIN_LIGHTNING_DAM	= "闪电链";
	STATCOMPARE_EARTH_SHOCK_DAM = "地震术";
	STATCOMPARE_FLAME_SHOCK_DAM = "烈焰震击";
	STATCOMPARE_FROST_SHOCK_DAM = "冰霜震击";
	STATCOMPARE_LIGHTNING_BOLT_DAM = "闪电箭";

	-- equip and set bonus patterns:
	STATCOMPARE_EQUIP_PREFIX = "装备：";
	STATCOMPARE_SET_PREFIX = "套装：";

	STATCOMPARE_EQUIP_PATTERNS = {
		{ pattern = "+(%d+) 耐力。",		effect = "STA" },
		{ pattern = "+(%d+) 敏捷。",		effect = "AGI" },
		{ pattern = "+(%d+) 力量。",		effect = "STR" },
		{ pattern = "+(%d+) 智力。",		effect = "INT" },
		{ pattern = "+(%d+) 奥术抗性。",		effect = "ARCANERES" },
		{ pattern = "+(%d+) 火焰抗性。",		effect = "FIRERES" },
		{ pattern = "+(%d+) 暗影抗性。",		effect = "SHADOWRES" },
		{ pattern = "+(%d+) 自然抗性。",		effect = "NATURERES" },
		{ pattern = "+(%d+) 冰霜抗性。",		effect = "FROSTRES" },
		{ pattern = "+(%d+) 攻击强度。",		effect = "ATTACKPOWER"},
		{ pattern = "+(%d+) 护甲。",		effect = "ENARMOR"},
		{ pattern = "+(%d+)点护甲值。",		effect = "ENARMOR"},
		{ pattern = "防御技能提高(%d+)点。",	effect = "DEFENSE" },
		{ pattern = "每5秒回复(%d+)点生命值。",	effect = "HEALTHREG" },
		{ pattern = "剥皮技能提高(%d+)点。",	effect = "SKINNING" },
		{ pattern = "钓鱼技能提高(%d+)点。",	effect = "FISHING"},
		{ pattern = "每5秒恢复(%d+)点生命值。",	effect = "HEALTHREG" },
		{ pattern = "每5秒恢复(%d+)点法力值。",	effect = "MANAREG" },
		{ pattern = "每5秒回复(%d+)点法力值。",	effect = "MANAREG" },
		{ pattern = "+(%d+) 远程攻击强度。",	effect = "RANGEDATTACKPOWER" },
		{ pattern = "+(%d+) 所有魔法抗性。",	effect = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"} },
		{ pattern = "使你的生命值和法力值回复提高(%d+)点。",	effect = {"MANAREG","HEALTHREG"} },
		{ pattern = "使你用盾牌格挡攻击的几率提高(%d+)%%。",	effect = "TOBLOCK" },
		{ pattern = "使你的盾牌的格挡值提高(%d+)点。",		effect = "BLOCK" },
		{ pattern = "使你击中目标的几率提高(%d+)%%。",		effect = "TOHIT" },
		{ pattern = "使你躲闪攻击的几率提高(%d+)%%。",		effect = "DODGE" },
		{ pattern = "使你招架攻击的几率提高(%d+)%%。",		effect = "PARRY" },
		{ pattern = "使你的法术击中敌人的几率提高(%d+)%%。",	effect = "SPELLTOHIT" },
		{ pattern = "使你的法术造成致命一击的几率提高(%d+)%%。",	effect = "SPELLCRIT" },
		{ pattern = "使你造成致命一击的几率提高(%d+)%%。",	effect = "CRIT" },
		{ pattern = "使你打出致命一击的几率提高(%d+)%%。",	effect = "CRIT" },
		{ pattern = "使你的法术目标的魔法抗性降低(%d+)点。",	effect = "DETARRES" },
		{ pattern = "使圣光闪现的治疗效果提高最多(%d+)点。",	effect = "FLASHHOLYLIGHTHEAL"},
		{ pattern = "使次级治疗波的治疗效果提高最多(%d+)点。",	effect = "LESSERHEALWAVE"},
		{ pattern = "使次级治疗波所恢复的生命值提高最多(%d+)点。",	 effect= "LESSERHEALWAVE"},
		{ pattern = "使闪电链和闪电箭所造成的伤害提高最多(%d+)点。",	effect = {"CHAINLIGHTNING","LIGHTNINGBOLT"}}, -- thanks 段誉只爱语嫣@mop
		{ pattern = "使地震术、烈焰震击和冰霜震击所造成的伤害提高最多(%d+)点。",	effect = {"EARTHSHOCK","FLAMESHOCK","FROSTSHOCK"}}, -- thanks 段誉只爱语嫣@mop
		{ pattern = "使你的自然系法术造成致命一击的几率提高(%d+)%%。",	effect = "NATURECRIT" },
		{ pattern = "提高奥术法术和效果所造成的伤害，最多(%d+)点。",	effect = "ARCANEDMG" },
		{ pattern = "提高火焰法术和效果所造成的伤害，最多(%d+)点。",	effect = "FIREDMG" },
		{ pattern = "提高冰霜法术和效果所造成的伤害，最多(%d+)点。",	effect = "FROSTDMG" },
		{ pattern = "提高神圣法术和效果所造成的伤害，最多(%d+)点。",	effect = "HOLYDMG" },
		{ pattern = "提高自然法术和效果所造成的伤害，最多(%d+)点。",	effect = "NATUREDMG" },
		{ pattern = "提高暗影法术和效果所造成的伤害，最多(%d+)点。",	effect = "SHADOWDMG" },
		{ pattern = "使暗影法术所造成的伤害提高最多(%d+)点。",		effect = "SHADOWDMG" },
		{ pattern = "使暗影法术和效果所造成的伤害提高(%d+)点。",		effect = "SHADOWDMG" },
		{ pattern = "使治疗法术和效果所回复的生命值提高(%d+)点。",		effect = "HEAL" },
		{ pattern = "提高法术所造成的治疗效果，最多(%d+)点。",		effect = "HEAL" },
		{ pattern = "提高法术和魔法效果所造成的治疗效果，最多(%d+)点。",	effect = "HEAL"}, -- thanks marshall_c@mop
		{ pattern = "使法术的治疗效果提高最多(%d+)点。",			effect = "HEAL" }, 	-- thanks kkk36@mop
		{ pattern = "[提]*高所有法术和魔法效果所造成的伤害和治疗效果，最多(%d+)点。", effect = {"HEAL", "DMG"} }, -- thanks 旋律8246@mop
		{ pattern = "使你的神圣系法术的致命一击和极效治疗几率提高(%d+)%%。",	effect = "HOLYCRIT" },
		{ pattern = "使你的神圣法术造成致命一击的几率提高(%d+)%%。",		effect = "HOLYCRIT" },
		{ pattern = "与亡灵作战时的攻击强度提高(%d+)点。同时也可获得天灾石。",	effect = "ATTACKPOWERUNDEAD"}, 
		{ pattern = "对亡灵的攻击强度提高(%d+)点。",				effect = "ATTACKPOWERUNDEAD"},
		{ pattern = "提高所有法术和效果对亡灵所造成的伤害，最多(%d+)点。",					effect = "DMGUNDEAD"},
		{ pattern = "法术和魔法效果对亡灵造成的伤害提高最多(%d+)点。",					effect = "DMGUNDEAD"},
		{ pattern = "使魔法和法术效果对亡灵造成的伤害提高最多(%d+)点。同时也可为银色黎明收集天灾石。",	effect = "DMGUNDEAD"},
		{ pattern = "防御值提高3点，暗影抗性提高10点，生命值恢复速度提高。", effect = {"DEFENSE", "SHADOWRES", "HEALTHREG"}, value = {3, 10, 3}}, -- thanks 风の传说@mop
	};

	STATCOMPARE_S1 = {
		{ pattern = "奥术", 	effect = "ARCANE" },	
		{ pattern = "火焰", 	effect = "FIRE" },	
		{ pattern = "冰霜", 	effect = "FROST" },	
		{ pattern = "神圣", 	effect = "HOLY" },	
		{ pattern = "阴影",	effect = "SHADOW" },
		{ pattern = "暗影",	effect = "SHADOW" },
		{ pattern = "自然", 	effect = "NATURE" }
	}; 	

	STATCOMPARE_S2 = {
		{ pattern = "抗性", 	effect = "RES" },	
		{ pattern = "伤害", 	effect = "DMG" },
		{ pattern = "效果", 	effect = "DMG" },
	}; 	
		
	STATCOMPARE_TOKEN_EFFECT = {
		["所有属性"] 		= {"STR", "AGI", "STA", "INT", "SPI"},
		["力量"]			= "STR",
		["敏捷"]			= "AGI",
		["耐力"]			= "STA",
		["智力"]			= "INT",
		["精神"] 		= "SPI",

		["治疗和法术伤害"]	= {"DMG", "HEAL"},
		["伤害和治疗法术"]	= {"DMG", "HEAL"},
		["法术治疗和伤害"]	= {"DMG", "HEAL"},
		["法术伤害和治疗"]	= {"DMG", "HEAL"},
		["法术伤害"] 		= {"DMG", "HEAL"},

		["所有抗性"] 		= {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES", "ALLRES"},

		["钓鱼"]			= "FISHING",
		["鱼饵"]			= "FISHING",
		["采矿"]			= "MINING",
		["草药"]			= "HERBALISM",
		["剥皮"]			= "SKINNING",

		["攻击强度。"] 		= "ATTACKPOWER",
		["攻击强度"] 		= "ATTACKPOWER",
		["格挡值"]		= "BLOCK",
		["闪躲"] 		= "DODGE",
		["躲闪"] 		= "DODGE",
		["躲避"] 		= "DODGE",
		["闪避"] 		= "DODGE",
		["命中"] 		= "TOHIT",
		["法术命中"]		= "SPELLTOHIT",
		["远程攻击强度"]		= "RANGEDATTACKPOWER",
		["每5秒回复生命"]	= "HEALTHREG",
		["治疗法术"] 		= "HEAL",
		["每5秒恢复法力"] 	= "MANAREG",
		["法力回复"]		= "MANAREG",
		["伤害"] 		= "DMG",
		["生命值"]		= "HEALTH",
		["法力值"]		= "MANA",
		["护甲"]			= "ENARMOR",
		["强化护甲"]		= "ENARMOR",
		["防御"]			= "DEFENSE",
		["盾牌格挡"]		= "BLOCK",
		["攻击强度vs亡灵.*$"]	= "ATTACKPOWERUNDEAD",
	};

	STATCOMPARE_OTHER_PATTERNS = {
		{ pattern = "(%d+)格挡",			effect = "BLOCK"},
		{ pattern = "(%d+)点格挡",		effect = "BLOCK"},
		{ pattern = "格挡 +(%d+)%%",		effect = "TOBLOCK"},	-- thanks imole @mop
		{ pattern = "(%d+)点护甲",		effect = "ARMOR"},
		{ pattern = "每5秒恢复(%d+)点生命值[。]",	 effect = "HEALTHREG" },
		{ pattern = "每5秒回复(%d+)点生命值[。]",	 effect = "HEALTHREG" },
		{ pattern = "每5秒恢复(%d+)点法力值[。]",	 effect = "MANAREG" },
		{ pattern = "每5秒回复(%d+)点法力值[。]",	 effect = "MANAREG" },
		{ pattern = "赞达拉魔力徽章",		effect = {"DMG", "HEAL"}, value = 18 },
		{ pattern = "赞达拉宁静徽章",		effect = "HEAL", value = 33 },
		{ pattern = "赞达拉力量徽章",		effect = "ATTACKPOWER", value = 30 },
		{ pattern = "初级巫师之油",		effect = "DMG", value = 8 },
		{ pattern = "次级巫师之油",		effect = "DMG", value = 16 },
		{ pattern = "巫师之油",			effect = "DMG", value = 24 },
		{ pattern = "卓越巫师之油",	effect = {"DMG", "SPELLCRIT"}, value = {36, 1} }, -- thanks 马沙@mop
		{ pattern = "初级法力之油",	effect = "MANAREG", value = 4 },
		{ pattern = "次级法力之油",	effect = "MANAREG", value = 8 },
		{ pattern = "卓越法力之油",	effect = { "MANAREG", "HEAL"}, value = {12, 25} },
		{ pattern = "恒金渔线",		effect = "FISHING", value = 5 },
	};

	-- 法术相关
	STATCOMPARE_HEALSPELL_PREFIX	= "治疗法术";
	STATCOMPARE_ATTACKSPELL_PREFIX	= "伤害法术";
	STATCOMPARE_SPELLSKILL_INFO	= "法术/技能信息";
	STATCOMPARE_DOT_PREFIX		= " DOT效果";
	STATCOMPARE_HOT_PREFIX		= " HOT效果";
	STATCOMPARE_HEALIN_TOUCH	= "治疗之触";
	STATCOMPARE_REGROWTH		= "愈合　　";
	STATCOMPARE_REJUVENATION	= "回春术　";
	STATCOMPARE_TRANQUILITY		= "宁静　　";
	STATCOMPARE_WRATH		= "愤怒　　";
	STATCOMPARE_STARFIRE		= "星火术　";
	STATCOMPARE_MOONFIRE		= "月火术　";
	STATCOMPARE_INSECTSWARM		= "虫群　　";
	STATCOMPARE_LESSER_HEAL		= "次级治疗";
	STATCOMPARE_HEAL		= "治疗术　";
	STATCOMPARE_SPELL_HOLYFIRE	= "神圣之火";
	STATCOMPARE_SPELL_HOLYNOVA	= "神圣新星";
	STATCOMPARE_SPELL_MANABURN	= "法力燃烧";
	STATCOMPARE_SPELL_SMITE		= "惩戒　　";
	STATCOMPARE_SPELL_PAIN		= "暗言痛　";
	STATCOMPARE_SPELL_MINDBLAST	= "心灵震爆";
	STATCOMPARE_SPELL_MINDFLAY	= "精神鞭达";
	STATCOMPARE_FLASH_HEAL		= "快速治疗";
	STATCOMPARE_GREATER_HEAL	= "强效治疗";
	STATCOMPARE_RENEW		= "恢复　　";
	STATCOMPARE_PRAYER_OF_HEALING	= "治疗祷言";
	STATCOMPARE_HEALING_WAVE	= "治疗波　";
	STATCOMPARE_LESSER_HEALING_WAVE	= "次级治疗波";
	STATCOMPARE_CHAIN_HEAL		= "治疗链　";
	STATCOMPARE_CHAIN_LIGHTNING	= "闪电链　";
	STATCOMPARE_EARTH_SHOCK		= "地震术　";
	STATCOMPARE_FLAME_SHOCK		= "烈焰震击";
	STATCOMPARE_FROST_SHOCK		= "冰霜震击";
	STATCOMPARE_LIGHTNING_BOLT	= "闪电箭　";
	STATCOMPARE_HOLY_LIGHT		= "圣光术　";
	STATCOMPARE_HOLY_SHOCK		= "神圣震击";
	STATCOMPARE_HOLY_WRATH		= "神圣愤怒";
	STATCOMPARE_FLASH_OF_LIGHT	= "圣光闪现";
	STATCOMPARE_CONSECRATION	= "奉献　　";
	STATCOMPARE_EXORCISM		= "驱邪术　";
	STATCOMPARE_HAMMER_OF_WRATH	= "愤怒之锤";
	STATCOMPARE_ARCANEEXPLOSION	= "奥爆　　";
	STATCOMPARE_ARCANEMISSILES	= "奥术飞弹";
	STATCOMPARE_BLASTWAVE		= "冲击波　";
	STATCOMPARE_BLIZZARD		= "暴风雪　";
	STATCOMPARE_CONECOLD		= "冰锥术　";
	STATCOMPARE_FIREBALL		= "火球术　";
	STATCOMPARE_FIREBLAST		= "列焰冲击";
	STATCOMPARE_FROSTBOLT		= "寒冰箭　";
	STATCOMPARE_PYROBLAST		= "炎爆　　";
	STATCOMPARE_SCORCH		= "灼烧　　";
	STATCOMPARE_SRCANE_SHOT		= "奥术射击";
	STATCOMPARE_EXPLOSIVE_TRAP	= "爆炸陷阱";
	STATCOMPARE_IMMOLATION_TRAP	= "献祭陷阱";
	STATCOMPARE_SERPENT_STING	= "毒蛇钉刺";
	STATCOMPARE_VOLLEY		= "瞄准射击";
	STATCOMPARE_WYVERN_STING	= "";
	STATCOMPARE_CONFLAGRATE		= "燃烧　　";
	STATCOMPARE_CORRUPTION		= "腐蚀术　";
	STATCOMPARE_CURSE_OF_AGONY	= "痛苦诅咒";
	STATCOMPARE_DRAIN_LIFE		= "生命吸取";
	STATCOMPARE_DRAIN_SOUL		= "灵魂吸取";
	STATCOMPARE_DEATH_COIL		= "死亡缠绕";
	STATCOMPARE_HELLFIRE		= "地狱之火";
	STATCOMPARE_IMMOLATE		= "献祭　　";
	STATCOMPARE_RAIN_OF_FIRE	= "火焰之雨";
	STATCOMPARE_SEARING_PAIN	= "烧灼之痛";
	STATCOMPARE_SIPHON_LIFE		= "生命虹吸";
	STATCOMPARE_SHADOW_BOLT		= "暗影箭　";
	STATCOMPARE_SHADOWBURN		= "暗影灼烧";
	STATCOMPARE_SOUL_FIRE		= "灵魂之火";
end