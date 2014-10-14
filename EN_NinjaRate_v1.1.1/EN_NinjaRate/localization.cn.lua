if (GetLocale() == "zhCN") then
	ENR_CLASS_MAGE    = "法师";
	ENR_CLASS_ROGUE   = "盗贼";
	ENR_CLASS_HUNTER  = "猎人";
	ENR_CLASS_PRIEST  = "牧师";
	ENR_CLASS_WARRIOR = "战士";
	ENR_CLASS_WARLOCK = "术士";
	ENR_CLASS_PALADIN = "圣骑士";
	ENR_CLASS_DRUID   = "德鲁伊";
	ENR_CLASS_SHAMAN  = "萨满祭司";
	
	ENR_PROPERTY_INDEX = {
		[1] = "+%s*(%d+)%s*敏捷",
		[2] = "+%s*(%d+)%s*智力",
		[3] = "+%s*(%d+)%s*耐力",
		[4] = "+%s*(%d+)%s*精神",
		[5] = "+%s*(%d+)%s*力量",
		[6] = "恢复(%d+)点法力值",
		[7] = "弓箭技能提高(%d+)点",
	}
	
	ENR_EXTRAPROPERTY_INDEX = {
		[1] = "所有法术",
		[2] = "暗影法术",
		[3] = "治疗法术",
		[4] = "火焰法术",
		[5] = "冰霜法术",
		[6] = "奥术",
		[7] = "自然法术",
		[8] = "宠物",
		[9] = "[^程]攻击强度",
		[10]= "远程攻击强度",
		[11]= "治疗效果",
	}
	
	ENR_ITEM_INDEX = {
		[1]  = "布甲",
		[2]  = "皮甲",
		[3]  = "锁甲",
		[4]  = "板甲",
		[5]  = "主手" .. ENR_ITEMDESC_DELIMITER .. "斧",
		[6]  = "单手" .. ENR_ITEMDESC_DELIMITER .. "斧",
		[7]  = "双手" .. ENR_ITEMDESC_DELIMITER .. "斧",
		[8]  = "弓",
		[9]  = "匕首",
		[10] = "主手" .. ENR_ITEMDESC_DELIMITER .. "锤",
		[11] = "单手" .. ENR_ITEMDESC_DELIMITER .. "锤",
		[12] = "双手" .. ENR_ITEMDESC_DELIMITER .. "锤",
		[13] = "法杖",
		[14] = "主手" .. ENR_ITEMDESC_DELIMITER .. "剑",
		[15] = "单手" .. ENR_ITEMDESC_DELIMITER .. "剑",
		[16] = "双手" .. ENR_ITEMDESC_DELIMITER .. "剑",
		[17] = "枪械",
		[18] = "魔杖",
		[19] = "投掷武器",
		[20] = "长柄武器",
		[21] = "拳套",
		[22] = "弩",
		[23] = "盾牌",
	}
	
	ENR_SPECIALITEM_INDEX = {
		[1]  = "古拉巴什硬币",
		[2]  = "哈卡莱硬币",
		[3]  = "拉扎什硬币",
		[4]  = "沙怒硬币",
		[5]  = "碎颅硬币",
		[6]  = "祖立安硬币",
		[7]  = "邪枝硬币",
		[8]  = "枯木硬币",
		[9]  = "血顶硬币",
		[10] = "红色哈卡莱宝石",
		[11] = "橙色哈卡莱宝石",
		[12] = "黄色哈卡莱宝石",
		[13] = "绿色哈卡莱宝石",
		[14] = "青铜哈卡莱宝石",
		[15] = "蓝色哈卡莱宝石",
		[16] = "紫色哈卡莱宝石",
		[17] = "金色哈卡莱宝石",
		[18] = "银色哈卡莱宝石",
		[19] = "原始哈卡莱盾",
		[20] = "原始哈卡莱护腕",
		[21] = "原始哈卡莱披肩",
		[22] = "原始哈卡莱直柱",
		[23] = "原始哈卡莱束带",
		[24] = "原始哈卡莱套索",
		[25] = "原始哈卡莱徽章",
		[26] = "原始哈卡莱腰带",
		[27] = "原始哈卡莱护臂",
	}
	
	ENR_PUBLIC_ITEMS = { "图样", "结构图", "配方", "设计图", "手册", "公式", "教材"}
	
	ENR_CLASS_SUITES = {
		["博学者"]   = ENR_CLASS_MAGE,
		["奥术师"]   = ENR_CLASS_MAGE,
		["灵风"]     = ENR_CLASS_MAGE,
		["虔诚"]     = ENR_CLASS_PRIEST,
		["预言"]     = ENR_CLASS_PRIEST,
		["卓越"]     = ENR_CLASS_PRIEST,
		["鬼雾"]     = ENR_CLASS_WARLOCK,
		["元素"]     = ENR_CLASS_SHAMAN,
		["驭兽者"]   = ENR_CLASS_HUNTER,
		["迅影"]     = ENR_CLASS_ROGUE,
		["夜幕杀手"] = ENR_CLASS_ROGUE,
		["野性之心"] = ENR_CLASS_DRUID,
		["勇气"]     = ENR_CLASS_WARRIOR,
		["光铸"]     = ENR_CLASS_PALADIN,
		[ENR_CLASS_MAGE]    = ENR_CLASS_MAGE,
		[ENR_CLASS_ROGUE]   = ENR_CLASS_ROGUE,
		[ENR_CLASS_HUNTER]  = ENR_CLASS_HUNTER,
		[ENR_CLASS_PRIEST]  = ENR_CLASS_PRIEST,
		[ENR_CLASS_WARRIOR] = ENR_CLASS_WARRIOR,
		[ENR_CLASS_WARLOCK] = ENR_CLASS_WARLOCK,
		[ENR_CLASS_PALADIN] = ENR_CLASS_PALADIN,
		[ENR_CLASS_DRUID]   = ENR_CLASS_DRUID,
		[ENR_CLASS_SHAMAN]  = ENR_CLASS_SHAMAN,
	}
	
	ENR_TOOLTIP_PUBLIC = "普通物品";
	ENR_TOOLTIP_SUITES = "该装备是 |cffffcc00%s|r 职业套装之一.";
	ENR_TOOLTIP_WARNING = "本 Ninja Rate 数值仅供参考.";
	
	ENR_SUGGEST_SAFE   = "建议您掷骰子";
	ENR_SUGGEST_NORMAL = "掷骰子前请仔细考虑";
	ENR_SUGGEST_DANGER = "极有可能NINJA, 请慎重考虑";
	
	ENR_GROUPTYPE_RAID  = "团队";
	ENR_GROUPTYPE_GROUP = "组队";
	ENR_GROUPTYPE_SOLO  = "单人";
end
