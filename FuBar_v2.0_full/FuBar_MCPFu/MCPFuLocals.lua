local L = AceLibrary("AceLocale-2.0"):new("MCPFu")

L:RegisterTranslations("enUS", function() return {
	NAME = "FuBar - MCPFu",
	DESCRIPTION = "Enable/Disable addons for your character in game.",

	LOADED = "Loaded",
	WILL_NOT_LOAD = "Will not load",
	DISABLED_IN_MCP = "Disabled in MCP",

	OPT_SHOW_ENABLED = "Show Enabled/Disabled",
	OPT_SHOW_ENABLED_DESC = "Show in the addon text how many are enabled / disabled",
	OPT_SHOW_SECURITY = "Show Security",
	OPT_SHOW_SECURITY_DESC = "Show blizzards security info",
	OPT_SHOW_NOTES = "Show Notes",
	OPT_SHOW_NOTES_DESC = "Show addon notes in tooltip",
	OPT_NOTE_LEN = "Max length of notes",
	OPT_NOTE_LEN_DESC = "If notes are longer than this amount of chars, they will be shortened",

	SECURE = "Secure",
	INSECURE = "Insecure",
	BANNED = "Banned",

	ONDEMAND = "Shift+Click to load",

	HINT = "Alt+Click to reload",


} end )

L:RegisterTranslations("koKR", function() return {
	NAME = "FuBar - MCPFu",
	DESCRIPTION = "게임 상에서 캐릭터별로 애드온의 사용 여부를 선택합니다.",

	LOADED = "불러옴",
	WILL_NOT_LOAD = "불러오기 실패",
	DISABLED_IN_MCP = "MCP에사 사용 불가",

	OPT_SHOW_ENABLED = "사용/사용안함 표시",
	OPT_SHOW_ENABLED_DESC = "사용/사용안함 애드온의 갯수를 표시합니다",
	OPT_SHOW_SECURITY = "안전성 표시",
	OPT_SHOW_SECURITY_DESC = "Blizzard 안전성 정보를 표시합니다",
	OPT_SHOW_NOTES = "설명 표시",
	OPT_SHOW_NOTES_DESC = "툴팁에 애드온의 설명을 표시합니다",
	OPT_NOTE_LEN = "설명 길이 제한",
	OPT_NOTE_LEN_DESC = "툴팁에 표시되는 애드온의 설명의 최대 길이를 조절합니다. 그 이상의 경우에는 생략됩니다",

	SECURE = "안전함",
	INSECURE = "검증안됨",
	BANNED = "차단됨",

	ONDEMAND = "Shift 클릭시 불러옴",

	HINT = "Alt 클릭시 리로딩합니다",


} end )
