--[[

	File containing localized strings
	for Simplified Chinese and English versions, defaults to English

]]
function SC_BuffLocalization_zhCN()

	STATCOMPARE_BUFF_PATTERNS = {
		-- 德鲁伊的野性印记
		{ pattern = "护甲提高285点，所有属性提高12点，所有抗性提高20点。",
			effect = {"ARMOR", "STR", "AGI", "STA", "INT", "SPI", "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},
			value = {285, 12, 12, 12, 12, 12, 20, 20, 20, 20, 20}},
		-- 猎人
		{ pattern = "远程攻击强度提高(%d+)点。", effect = "RANGEDATTACKPOWER"},
		{ pattern = "攻击强度提高(%d+)点。", effect = "ATTACKPOWER"},
		{ pattern = "躲闪几率提高(%d+)%%。", effect = "DODGE"},
		{ pattern = "自然抗性提高(%d+)点。", effect = "NATURERES"},
		-- 法师
		{ pattern = "智力提高(%d+)点。", effect = "INT"},
		{ pattern = "使护甲提高(%d+)点，冰霜抗性提高(%d+)点，并可令攻击者减速。", effect = {"ARMOR", "FROSTRES"}},
		{ pattern = "对所有魔法的抗性提高(%d+)点，在任意情况下都保持%d+%%的法力值回复速度。", 
			effect = {"ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"}},
		-- 术士
		{ pattern = "护甲值提高(%d+)点，暗影抗性提高(%d+)点，每5秒回复(%d+)点生命值。", effect = {"ARMOR", "SHADOWRES", "HEALTHREG"}},
		-- 牧师
		{ pattern = "精神提高(%d+)点。", effect = "SPI"},
		{ pattern = "耐力提高(%d+)点。", effect = "STA"},
		{ pattern = "力量提高(%d+)点。", effect = "STR"},
		{ pattern = "每5秒恢复(%d+)点法力值。", effect = "MANAREG"},
		{ pattern = "每5秒回复(%d+)点法力值。", effect = "MANAREG"},
		{ pattern = "防御值提高(%d+)点。", effect = "ARMOR"},
		-- 圣骑士
		{ pattern = "护甲值提高(%d+)点。", effect = "ARMOR"},
		{ pattern = "所有属性提高10%%。", king = 1},
		{ pattern = "近战攻击强度提高(%d+)点。", effect = "ATTACKPOWER"},
		-- 猫釉
		{pattern = "使敏捷提高(%d+)点，致命一击几率提高(%d+)%%。", effect = {"AGI", "CRIT"}},
		-- 赞达拉之魂
		--{ pattern = "移动速度提高10%%，所有属性提高(%d+)%%，持续2小时。"},
		-- 东泉火酒
		{ pattern = "近战攻击强度提高(%d+)点，体型增大。", effect = "ATTACKPOWER"},
		{ pattern = "火焰抗性提高(%d+)点。", effect = "FIRERES"},
		{ pattern = "生命值上限提高(%d+)点。", effect = "HEALTH"},
		{ pattern = "暗影抗性提高(%d+)点，可能令攻击者感染疾病。", effect = "SHADOWRES"},
		{ pattern = "敏捷提高(%d+)点。", effect = "AGI"},
	};

end