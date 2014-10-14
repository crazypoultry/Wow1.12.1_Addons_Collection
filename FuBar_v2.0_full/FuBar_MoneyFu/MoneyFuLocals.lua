local L = AceLibrary("AceLocale-2.0"):new("MoneyFu")

L:RegisterTranslations("enUS", function()
	return {
		["NAME"] = "FuBar - MoneyFu",
		["DESCRIPTION"] = "Keeps track of current money and all your characters on one realm.",
		["COMMANDS"] = {"/monfu", "/moneyfu"},
		["TEXT_TOTAL"] = "Total",
		["TEXT_SESSION_RESET"] = "Session reset",
		["TEXT_THIS_SESSION"] = "This session",
		["TEXT_GAINED"] = "Gained",
		["TEXT_SPENT"] = "Spent",
		["TEXT_AMOUNT"] = "Amount",
		["TEXT_PER_HOUR"] = "Per hour",

		["ARGUMENT_RESETSESSION"] = "resetSession",

		["MENU_RESET_SESSION"] = "Reset Session",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Show character-specific cashflow",
		["MENU_PURGE"] = "Purge",
		["MENU_SHOW_GRAPHICAL"] = "Show with coins",
		["MENU_SHOW_FULL"] = "Show full style",
		["MENU_SHOW_SHORT"] = "Show short style",
		["MENU_SHOW_CONDENSED"] = "Show condensed style",
		["SIMPLIFIED_TOOLTIP"] = "Simplified Tooltip",
		["SHOW_PER_HOUR_CASHFLOW"] = "Show per hour cashflow",

		["TEXT_SESSION_RESET"] = "Session reset.",
		["TEXT_CHARACTERS"] = "Characters",
		["TEXT_PROFIT"] = "Profit",
		["TEXT_LOSS"] = "Loss",
	
		["HINT"] = "Click to pick up money"
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["NAME"] = "FuBar - MoneyFu",
		["DESCRIPTION"] = "F\195\188hrt Buch \195\188ber Eure Reicht\195\188mer und die Eurer Charaktere auf diesem Realm.",
		["COMMANDS"] = {"/monfu", "/moneyfu"},
		["TEXT_TOTAL"] = "Gesamt",
		["TEXT_SESSION_RESET"] = "Sitzung zur\195\188cksetzen",
		["TEXT_THIS_SESSION"] = "Diese Sitzung",
		["TEXT_GAINED"] = "Eingenommen",
		["TEXT_SPENT"] = "Ausgegeben",
		["TEXT_AMOUNT"] = "Geldmenge",
		["TEXT_PER_HOUR"] = "Pro Stunde",
	
		["ARGUMENT_RESETSESSION"] = "resetSession",
	
		["MENU_RESET_SESSION"] = "Sitzung zur\195\188cksetzen",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "Charakterspezifischen Geldfluss anzeigen",
		["MENU_PURGE"] = "L\195\182schen",
		["MENU_SHOW_GRAPHICAL"] = "Anzeige mit M\195\188nzsymbolen",
		["MENU_SHOW_FULL"] = "Ausf\195\188hrlicher Stil",
		["MENU_SHOW_SHORT"] = "Kurzstil",
		["MENU_SHOW_CONDENSED"] = "Komprimierter Stil",
		["SIMPLIFIED_TOOLTIP"] = "Vereinfachtes Tooltip",
		["SHOW_PER_HOUR_CASHFLOW"] = "Show per hour cashflow",
	
		["TEXT_SESSION_RESET"] = "Sitzung zur\195\188ckgesetzt.",
		["TEXT_CHARACTERS"] = "Charaktere",
		["TEXT_PROFIT"] = "Gewinn",
		["TEXT_LOSS"] = "Verlust",
	
		["HINT"] = "Anklicken, um Geld aufzunehmen.",
	}
end)

L:RegisterTranslations("zhCN", function()
	return {
		["TEXT_TOTAL"] = "总计",
		["TEXT_SESSION_RESET"] = "重置本次连接统计",
		["TEXT_THIS_SESSION"] = "本次连接",
		["TEXT_GAINED"] = "盈利",
		["TEXT_SPENT"] = "消费",
		["TEXT_AMOUNT"] = "总计",
		["TEXT_PER_HOUR"] = "每小时",

		["MENU_RESET_SESSION"] = "重置本次连接统计",
		["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "只显示本角色金钱状况",
		["MENU_PURGE"] = "清空",
		["MENU_SHOW_GRAPHICAL"] = "硬币图标显示",
		["MENU_SHOW_FULL"] = "完全样式显示",
		["MENU_SHOW_SHORT"] = "简洁样式显示",
		["MENU_SHOW_CONDENSED"] = "紧缩样式显示",
		["SIMPLIFIED_TOOLTIP"] = "简单提示",
		["SHOW_PER_HOUR_CASHFLOW"] = "显示每小时金钱状况",

		["TEXT_SESSION_RESET"] = "重置本次连接统计.",
		["TEXT_CHARACTERS"] = "角色",
		["TEXT_PROFIT"] = "盈利",
		["TEXT_LOSS"] = "消费",
	
		["HINT"] = "点击提取金钱"
	}
end)
