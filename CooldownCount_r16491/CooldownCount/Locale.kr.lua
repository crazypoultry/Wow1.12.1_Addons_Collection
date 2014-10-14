--[[ $Id: Locale.kr.lua 14691 2006-10-21 20:09:52Z damjau $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("CooldownCount")

L:RegisterTranslations("koKR", function()
	return {
		["reset"] = "초기화",
		["Reset all settings."] = "모든 설정을 초기화 합니다.",
		["Reset to default settings."] = "기본값으로 설정을 초기화 합니다.",
		["shine"] = "반짝임",
		["Toggle icon shine display after finish cooldown."] = "재사용 대기시간 종료 후 아이콘 반짝임 표시를 전환합니다.",
		["shinescale"] = "반짝임 크기",
		["Adjust icon shine scale."] = "아이콘 반짝임 크기를 조절합니다.",
		["font"] = "폰트",
		["Set cooldown value display font."] = "재사용 대기시간의 폰트을 설정합니다.",

		["font size"] = "폰트 크기",
		["Setup cooldown value display font size."] = "재사용 대기시간의 폰트 크기를 설정합니다.",
		["small size"] = "작은 폰트 크기",
		["Small font size for cooldown is longer than 10 minutes."] = "10분 이상인 재사용 대기시간에 대한 작은 폰트 크기",
		["medium size"] = "중간 폰트 크기",
		["Medium font size for cooldown is longer than 1 minute and less than 10 minutes."] = "1분 이상 10분 미만인 재사용 대기시간에 대한 중간 폰트 크기",
		["large size"] = "큰 폰트 크기",
		["Large font size for cooldown is longer than 10 seconds and less than 1 minutes."] = "10초 이상 1분 미만인 재사용 대기시간에 대한 큰 폰트 크기",
		["warning size"] = "경고 폰트 크기",
		["Warning font size for cooldown is less than 10 seconds."] = "10초 이하인 재사용 대기시간에 대한 경고 폰트 크기",

		["common color"] = "기본 색상",
		["Setup the common color for value display."] = "시간 표시를 위한 기본 색상을 설정합니다.",
		["warning color"] = "경고 색상",
		["Setup the warning color for value display."] = "시간 표시를 위한 경고 색상을 설정합니다.",

		["d"] = "일",
		["h"] = "시",
		["m"] = "분",

		["Fonts\\FRIZQT__.TTF"] = "Fonts\\2002.TTF",

		["minimum duration"] = "최소 시간",
		["Minimum duration for display cooldown count."] = "재사용 대기 시간을 표시할 최소 시간을 설정합니다.",
		["hide animation"] = "애니메이션 숨김",
		["Hide Bliz origin cooldown animation."] = "WoW 기본 재사용 대기 시간 애니매이션 효과를 숨깁니다."
	}
end)
