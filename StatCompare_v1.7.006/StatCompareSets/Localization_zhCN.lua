--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]
function SCS_Localization_zhCN()
	SCS_ALL		= "所有";
	SCS_CLOTH	= "布甲";
	SCS_LEATHER	= "皮甲";
	SCS_MAIL	= "锁甲";
	SCS_PLATE	= "板甲";
	SCS_SHIELD	= "盾牌";
	SCS_MISC	= "其他";
	SCS_IDOLS	= "神像";
	SCS_LIBRAMS	= "圣契";
	SCS_TOTEMS	= "图腾";

	SCS_BOWS	= "弓";
	SCS_CROSSBOWS	= "驽";
	SCS_DAGGERS	= "匕首";
	SCS_GUNS	= "枪";
	SCS_FISHINGPOLE	= "鱼竿";
	SCS_FISTWEAPONS	= "拳套";
	SCS_OHAXES	= "单手斧";
	SCS_OHMACES	= "单手锤";
	SCS_OHSWORDS	= "单手剑";
	SCS_POLEARMS	= "长柄武器";
	SCS_STAVES	= "法杖";
	SCS_THROWN	= "投掷武器";
	SCS_THAXES	= "双手斧";
	SCS_THMACES	= "双手锤";
	SCS_THSWORDS	= "双手剑";
	SCS_WANDS	= "魔杖";

	SCS_UNIQUE	= "唯一";
	SCS_CLASSES_PATTERN	= "^职业：(.*)";

	SCS_STA		= "耐力装"; 
	SCS_AGI		= "敏捷装";
	SCS_INT		= "智力装";
	SCS_HEAL	= "治疗装";
	SCS_DMG		= "法伤装";
	SCS_ARCANERES	= "奥抗装";
	SCS_FIRERES	= "火抗装";
	SCS_NATURERES	= "自然抗装";
	SCS_FROSTRES	= "冰抗装";
	SCS_SHADOWRES	= "暗抗装";
	SCS_DETARRES	= "降抗装";
	SCS_ARMOR	= "护甲装";
	SCS_DEFENSE	= "防御装";
	SCS_CRIT	= "爆击装";
	SCS_DODGE	= "躲闪装";
	SCS_TOHIT	= "命中装";
	SCS_SPELLCRIT	= "法爆装";
	SCS_SPELLTOHIT	= "法术命中装";
	SCS_MANAREG	= "回蓝装";

	SCS_TEST	= "命运之戒"

	StatCompare_clssItem = {
		-- T3 classes
		["梦游者头饰"] = { class="DRUID" },
		["梦游者肩饰"] = { class="DRUID" },
		["梦游者外套"] = { class="DRUID" },
		["梦游者腕甲"] = { class="DRUID" },
		["梦游者护手"] = { class="DRUID" },
		["梦游者束带"] = { class="DRUID" },
		["梦游者护腿"] = { class="DRUID" },
		["梦游者长靴"] = { class="DRUID" },
		["梦游者之戒"] = { class="DRUID" },

		["无畏头盔"] = { class="WARRIOR" },
		["无畏肩铠"] = { class="WARRIOR" },
		["无畏胸甲"] = { class="WARRIOR" },
		["无畏护腕"] = { class="WARRIOR" },
		["无畏手套"] = { class="WARRIOR" },
		["无畏腰带"] = { class="WARRIOR" },
		["无畏腿铠"] = { class="WARRIOR" },
		["无畏马靴"] = { class="WARRIOR" },
		["无畏之戒"] = { class="WARRIOR" },
		
		["骨镰头盔"] = { class="ROGUE" },
		["骨镰肩铠"] = { class="ROGUE" },
		["骨镰胸甲"] = { class="ROGUE" },
		["骨镰护腕"] = { class="ROGUE" },
		["骨镰护手"] = { class="ROGUE" },
		["骨镰护腰"] = { class="ROGUE" },
		["骨镰腿甲"] = { class="ROGUE" },
		["骨镰马靴"] = { class="ROGUE" },
		["骨镰之戒"] = { class="ROGUE" },

		["信仰头环"] = { class="PRIEST" },
		["信仰肩垫"] = { class="PRIEST" },
		["信仰长袍"] = { class="PRIEST" },
		["信仰腕轮"] = { class="PRIEST" },
		["信仰手套"] = { class="PRIEST" },
		["信仰腰带"] = { class="PRIEST" },
		["信仰护腿"] = { class="PRIEST" },
		["信仰便鞋"] = { class="PRIEST" },
		["信仰之戒"] = { class="PRIEST" },

		["霜火头饰"] = { class="MAGE" },
		["霜火肩垫"] = { class="MAGE" },
		["霜火长袍"] = { class="MAGE" },
		["霜火腕轮"] = { class="MAGE" },
		["霜火手套"] = { class="MAGE" },
		["霜火腰带"] = { class="MAGE" },
		["霜火护腿"] = { class="MAGE" },
		["霜火便鞋"] = { class="MAGE" },
		["霜火之戒"] = { class="MAGE" },

		["救赎头饰"] = { class="PALADIN" },
		["救赎肩铠"] = { class="PALADIN" },
		["救赎外套"] = { class="PALADIN" },
		["救赎护腕"] = { class="PALADIN" },
		["救赎护手"] = { class="PALADIN" },
		["救赎束带"] = { class="PALADIN" },
		["救赎腿甲"] = { class="PALADIN" },
		["救赎长靴"] = { class="PALADIN" },
		["救赎之戒"] = { class="PALADIN" },

		["瘟疫之心头饰"] = { class="WARLOCK" },
		["瘟疫之心肩垫"] = { class="WARLOCK" },
		["瘟疫之心长袍"] = { class="WARLOCK" },
		["瘟疫之心腕轮"] = { class="WARLOCK" },
		["瘟疫之心手套"] = { class="WARLOCK" },
		["瘟疫之心腰带"] = { class="WARLOCK" },
		["瘟疫之心护腿"] = { class="WARLOCK" },
		["瘟疫之心便鞋"] = { class="WARLOCK" },
		["瘟疫之心指环"] = { class="WARLOCK" },

		["地穴追猎者头饰"] = { class="HUNTER" },
		["地穴追猎者肩甲"] = { class="HUNTER" },
		["地穴追猎者外套"] = { class="HUNTER" },
		["地穴追猎者护腕"] = { class="HUNTER" },
		["地穴追猎者护手"] = { class="HUNTER" },
		["地穴追猎者束带"] = { class="HUNTER" },
		["地穴追猎者护腿"] = { class="HUNTER" },
		["地穴追猎者长靴"] = { class="HUNTER" },
		["地穴追猎者指环"] = { class="HUNTER" },

		["碎地者头饰"] = { class="SHAMAN" },
		["碎地者肩饰"] = { class="SHAMAN" },
		["碎地者外套"] = { class="SHAMAN" },
		["碎地者护腕"] = { class="SHAMAN" },
		["碎地者护手"] = { class="SHAMAN" },
		["碎地者束带"] = { class="SHAMAN" },
		["碎地者腿甲"] = { class="SHAMAN" },
		["碎地者长靴"] = { class="SHAMAN" },
		["碎地者之戒"] = { class="SHAMAN" },

		-- T0.5
		["野性之心腰带"] = { class="DRUID" },
		["野性之心长靴"] = { class="DRUID" },
		["野性之心护腕"] = { class="DRUID" },
		["野性之心兜帽"] = { class="DRUID" },
		["野性之心外衣"] = { class="DRUID" },
		["野性之心肩甲"] = { class="DRUID" },
		["野性之心褶裙"] = { class="DRUID" },
		["野性之心手套"] = { class="DRUID" },

		["英勇腰带"] = { class="WARRIOR" },
		["英勇长靴"] = { class="WARRIOR" },
		["英勇护腕"] = { class="WARRIOR" },
		["英勇胸甲"] = { class="WARRIOR" },
		["英勇护手"] = { class="WARRIOR" },
		["英勇头盔"] = { class="WARRIOR" },
		["英勇腿铠"] = { class="WARRIOR" },
		["英勇肩铠"] = { class="WARRIOR" },
		
		["暗幕腰带"] = { class="ROGUE" },
		["暗幕长靴"] = { class="ROGUE" },
		["暗幕护腕"] = { class="ROGUE" },
		["暗幕外套"] = { class="ROGUE" },
		["暗幕肩甲"] = { class="ROGUE" },
		["暗幕短裤"] = { class="ROGUE" },
		["暗幕手套"] = { class="ROGUE" },
		["暗幕罩帽"] = { class="ROGUE" },

		["坚贞腰带"] = { class="PRIEST" },
		["坚贞便鞋"] = { class="PRIEST" },
		["坚贞护腕"] = { class="PRIEST" },
		["坚贞头冠"] = { class="PRIEST" },
		["坚贞手套"] = { class="PRIEST" },
		["坚贞衬肩"] = { class="PRIEST" },
		["坚贞长裙"] = { class="PRIEST" },
		["坚贞长袍"] = { class="PRIEST" },

		["巫师腰带"] = { class="MAGE" },
		["巫师护腕"] = { class="MAGE" },
		["巫师头冠"] = { class="MAGE" },
		["巫师手套"] = { class="MAGE" },
		["巫师护腿"] = { class="MAGE" },
		["巫师衬肩"] = { class="MAGE" },
		["巫师长袍"] = { class="MAGE" },
		["巫师软靴"] = { class="MAGE" },

		["魂铸腰带"] = { class="PALADIN" },
		["魂铸战靴"] = { class="PALADIN" },
		["魂铸护腕"] = { class="PALADIN" },
		["魂铸胸甲"] = { class="PALADIN" },
		["魂铸护手"] = { class="PALADIN" },
		["魂铸腿甲"] = { class="PALADIN" },
		["魂铸肩铠"] = { class="PALADIN" },
		["魂铸头盔"] = { class="PALADIN" },

		["死雾腰带"] = { class="WARLOCK" },
		["死雾护腕"] = { class="WARLOCK" },
		["死雾护腿"] = { class="WARLOCK" },
		["死雾衬肩"] = { class="WARLOCK" },
		["死雾长袍"] = { class="WARLOCK" },
		["死雾便鞋"] = { class="WARLOCK" },
		["死雾面具"] = { class="WARLOCK" },
		["死雾裹手"] = { class="WARLOCK" },

		["兽王腰带"] = { class="HUNTER" },
		["兽王长靴"] = { class="HUNTER" },
		["兽王护腕"] = { class="HUNTER" },
		["兽王罩帽"] = { class="HUNTER" },
		["兽王外套"] = { class="HUNTER" },
		["兽王短裤"] = { class="HUNTER" },
		["兽王护肩"] = { class="HUNTER" },
		["兽王手套"] = { class="HUNTER" },

		["五雷束腰"] = { class="SHAMAN" },
		["五雷长靴"] = { class="SHAMAN" },
		["五雷腕轮"] = { class="SHAMAN" },
		["五雷罩帽"] = { class="SHAMAN" },
		["五雷护手"] = { class="SHAMAN" },
		["五雷护腿"] = { class="SHAMAN" },
		["五雷护肩"] = { class="SHAMAN" },
		["五雷外衣"] = { class="SHAMAN" },

		["潮汐指环"] = { unique=1},
		["奥妮克希亚龙血护符"] = {unique=1},
		["海洋之风"] = { unique=1},
		["比斯巨兽之眼"] = { unique = 1},
		["黑手饰物"] = { unique = 1},
		["屠龙者的徽记"] = { unique = 1},
		["暴君印记"] = { unique = 1},
		
	};
end