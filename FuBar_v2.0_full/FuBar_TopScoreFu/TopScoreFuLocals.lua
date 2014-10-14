local L = AceLibrary("AceLocale-2.0"):new("TopScoreFu")

L:RegisterTranslations("enUS", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Keeps track of your top hits, heals, criticals, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "showSplash",
		["ARGUMENT_PLAYNOISE"] = "playNoise",
		["ARGUMENT_SCREENSHOT"] = "screenshot",
		["ARGUMENT_HEALING"] = "healing",
		["ARGUMENT_DAMAGE"] = "damage",
		["ARGUMENT_ONLYPVP"] = "onlyPvP",
		["ARGUMENT_RESET"] = "reset",
		["ARGUMENT_POSITION"] = "position",
		["ARGUMENT_SHOWTRIVIAL"] = "trivial",

		["MENU_SHOW_SPLASH"] = "Show splash",
		["MENU_PLAY_NOISE"] = "Play noise",
		["MENU_TAKE_SCREENSHOTS"] = "Take screenshots",
		["MENU_INCLUDE_HEALING"] = "Include healing",
		["MENU_INCLUDE_DAMAGE"] = "Include damage",
		["MENU_VS_MONSTERS"] = "vs. Monsters",
		["MENU_RESET_SCORES"] = "Reset scores",
		["MENU_SHOW_TRIVIAL"] = "Trivial scores",
		["MENU_FILTER"] = "Filter",
		["MENU_PURGE"] = "Purge",
	
		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Critical",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "Critical %s",
		["TEXT_SCORES_RESET"] = "Scores reset",
		["TEXT_SET_POSITION_ERROR"] = "You must give the position in the form of `x y`, where x and y are numbers.",

		["HINT"] = "Shift-Click to insert your highest scores in chat edit box.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "New critical %s record!\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "New %s record!\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position now %d, %d",
	}
end)

L:RegisterTranslations("deDE", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Protokolliert Eure h\195\182chsten Treffer, h\195\182chste Heilung, h\195\182chsten kritischen Treffer, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "showSplash",
		["ARGUMENT_PLAYNOISE"] = "playNoise",
		["ARGUMENT_SCREENSHOT"] = "screenshot",
		["ARGUMENT_HEALING"] = "healing",
		["ARGUMENT_DAMAGE"] = "damage",
		["ARGUMENT_ONLYPVP"] = "onlyPvP",
		["ARGUMENT_RESET"] = "reset",
		["ARGUMENT_POSITION"] = "position",
		["ARGUMENT_SHOWTRIVIAL"] = "trivial",

		["MENU_SHOW_SPLASH"] = "Zeige Einblendung",
		["MENU_PLAY_NOISE"] = "Sound abspielen",
		["MENU_TAKE_SCREENSHOTS"] = "Screenshot anfertigen",
		["MENU_INCLUDE_HEALING"] = "Heilung einbeziehen",
		["MENU_INCLUDE_DAMAGE"] = "Schaden einbeziehen",
		["MENU_VS_MONSTERS"] = "Treffer gegen Monster",
		["MENU_RESET_SCORES"] = "Werte zur\195\188cksetzen",
		["MENU_SHOW_TRIVIAL"] = "Ergebnisse bei grauen Zielen",
		["MENU_FILTER"] = "Filter", -- CHECK
		["MENU_PURGE"] = "Purge", -- CHECK

		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Kritisch",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "kritische/r %s",
		["TEXT_SCORES_RESET"] = "Werte zur\195\188ckgesetzt",
		["TEXT_SET_POSITION_ERROR"] = "Die Position muss in der Form `x y` angegeben werden, wobei x und y Zahlen sind.",

		["HINT"] = "Shift-Linksklick f\195\188gt Eure Rekorde in die Chat-Eingabezeile ein.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "Neuer Crit-Rekord mit %s !\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "Neuer Rekord mit %s !\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position auf %d, %d eingestellt",
	}
end)

L:RegisterTranslations("frFR", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "Garde une trace de vos records de vos soins, coups, etc.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "Montrer Splash",
		["ARGUMENT_PLAYNOISE"] = "Jouer Son",
		["ARGUMENT_SCREENSHOT"] = "Screenshot",
		["ARGUMENT_HEALING"] = "Soins",
		["ARGUMENT_DAMAGE"] = "Dommage",
		["ARGUMENT_ONLYPVP"] = "SeulementPvP",
		["ARGUMENT_RESET"] = "Reset",
		["ARGUMENT_POSITION"] = "Position",
		["ARGUMENT_SHOWTRIVIAL"] = "Trivial",

		["MENU_SHOW_SPLASH"] = "Splash Ecran",
		["MENU_PLAY_NOISE"] = "Jouer son",
		["MENU_TAKE_SCREENSHOTS"] = "Faire screenshots",
		["MENU_INCLUDE_HEALING"] = "Inclus Soins",
		["MENU_INCLUDE_DAMAGE"] = "Inclus dommage",
		["MENU_VS_MONSTERS"] = "vs. Monstres",
		["MENU_RESET_SCORES"] = "Remise \195\160 zero",
		["MENU_SHOW_TRIVIAL"] = "Trivial scores",
		["MENU_FILTER"] = "Filtre", -- CHECK
		["MENU_PURGE"] = "Purge", -- CHECK

		["TEXT_NORMAL"] = "Normal",
		["TEXT_CRITICAL"] = "Critique",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "Critique %s",
		["TEXT_SCORES_RESET"] = "Remise \195\160 zero",
		["TEXT_SET_POSITION_ERROR"] = "You must give the position in the form of `x y`, where x and y are numbers.",

		["HINT"] = "Shift-Click pour mettre votre meilleur score dans la boite de chat.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "Nouveau record critique pour %s!\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "Nouveau record pour %s!\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "Position actuelle %d, %d",
	}
end)

L:RegisterTranslations("koKR", function()
	return {
		["NAME"] = "FuBar - Top ScoreFu",
		["DESCRIPTION"] = "타격, 치유, 치명타 등의 최고기록을 기록해줍니다.",
		["COMMANDS"] = {"/topfu", "/tsfu", "/topscorefu"},

		["ARGUMENT_SHOWSPLASH"] = "showSplash",
		["ARGUMENT_PLAYNOISE"] = "playNoise",
		["ARGUMENT_SCREENSHOT"] = "screenshot",
		["ARGUMENT_HEALING"] = "healing",
		["ARGUMENT_DAMAGE"] = "damage",
		["ARGUMENT_ONLYPVP"] = "onlyPvP",
		["ARGUMENT_RESET"] = "reset",
		["ARGUMENT_POSITION"] = "position",
		["ARGUMENT_SHOWTRIVIAL"] = "trivial",

		["MENU_SHOW_SPLASH"] = "화면에 표시",
		["MENU_PLAY_NOISE"] = "효과음 듣기",
		["MENU_TAKE_SCREENSHOTS"] = "스크린샷 찍기",
		["MENU_INCLUDE_HEALING"] = "치유 포함",
		["MENU_INCLUDE_DAMAGE"] = "타격 포함",
		["MENU_VS_MONSTERS"] = "몹에 대한 타격 포함",
		["MENU_RESET_SCORES"] = "기록 초기화",
		["MENU_SHOW_TRIVIAL"] = "사소한 타격 표시",
		["MENU_FILTER"] = "필터",
		["MENU_PURGE"] = "기록 삭제",
	
		["TEXT_NORMAL"] = "평타",
		["TEXT_CRITICAL"] = "치명타",
		["PATTERN_NORMAL_SPELL"] = "%s",
		["PATTERN_CRITICAL_SPELL"] = "%s 치명타",
		["TEXT_SCORES_RESET"] = "모든 기록 초기화",
		["TEXT_SET_POSITION_ERROR"] = "x, y 좌표를 입력해야합니다.",

		["HINT"] = "쉬프트-클릭시에 최고 기록을 채팅창에 표시합니다.",

		["PATTERN_NEW_CRITICAL_RECORD"] = "새 %s 치명타 기록!\n|cffffffff%d|r",
		["PATTERN_NEW_NORMAL_RECORD"] = "새 %s 기록!\n|cffffffff%d|r",
		["PATTERN_SET_POSITION"] = "현재 위치 %d, %d",
	}
end)
