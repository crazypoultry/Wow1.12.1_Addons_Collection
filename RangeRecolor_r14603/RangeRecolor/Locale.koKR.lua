--[[ $Id: Locale.koKR.lua 14438 2006-10-19 22:51:26Z hshh $ ]]--
local L = AceLibrary("AceLocale-2.2"):new("RangeRecolor")
L:RegisterTranslations("koKR", function()
	return {
		["toggleEnable_desc"] = "RangeRecolor 활성화/비활성화 전환",
		["style_desc"] = "버튼 색상 스타일을 변경합니다.",
		["custom_desc"] = "사용자 색상 스타일",
		["custom_usage"] = "<r=num,g=num,b=num>",
		["reset_desc"] = "모든 설정을 기본값으로 초기화합니다.",
		["MSG_RR_ON"] = "RangeRecolor가 활성화 되었습니다.",
		["MSG_RR_OFF"] = "RangeRecolor가 비활성화 되었습니다.",
		["MSG_RESETED"] = "모든 설정이 기본값으로 초기화 되었습니다.",
	}
end)
