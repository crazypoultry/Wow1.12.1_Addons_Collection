local L = AceLibrary("AceLocale-2.2"):new("Chronometer")

L:RegisterTranslations("enUS", function() return {
	["Chronometer"] = true,
	["Chronometer - an Ace2 Timer Mod"] = true,

	["Anchor"] = true,
	["Shows the dragable anchor."] = true,

	["Bar Scale"] = true,
	["Set the bar scale."] = true,
	
	["Bar Texture"] = true,
	["Changes the texture of the timer bars."] = true,

	["Bar Growth"] = true,
	["Toggles bar growing up or downwards."] = true,

	["Fade"] = true,
	["Toggles whether bars disappear when spells fade."] = true,

	["Kill"] = true,
	["Toggles whether bars disappear when killing things."] = true,
	
	["Ghost"] = true,
	["Change the amount of time that ghost bars stay up."] = true,
	
	["Self"] = true,
	["Toggles bars for spell durations on the player."] = true,
	
	["Reverse"] = true,
	["Toggles if bars are reversed (fill up instead of emptying)."] = true,

	["Test"] = true,
	["Runs test bars."] = true,
	
	["Config"] = true,
	["Show GUI Configuration Menu"] = true,
	
	["Bar Text"] = true,
	["Sets the text to be displayed on the bar."] = true,
	["Use $s for spell name and $t for the target's name."] = true,
	
	["Bar Width"] = true,
	["Set the bar width."] = true,
	
	["Bar Height"] = true,
	["Set the bar height."] = true,
	
	["Text Size"] = true,
	["Set the bar text size."] = true,
	
	["Text Color"] = true,
	["Set the bar text color."] = true,
	
	["Bar Color"] = true,
	["Set the default bar color."] = true,
	
	["Background Alpha"] = true,
	["Alpha value of the bar background."] = true,
	
	["Background Color"] = true,
	["Set the bar background color."] = true,
	
	["Bar"] = true,
	["CandyBar options"] = true,
	
	["Hide"] = true,
	
	-- These all need to be added to Babble-Spell!!!
	["Forbearance"] = true,
	["Counterspell - Silenced"] = true,
	["Faerie Fire (Feral)"] = true,
	["Starfire Stun"] = true,
	["Shadow Vulnerability"] = true,
	["Kick - Silenced"] = true,
	["Remorseless"] = true,
	["Enamored Water Spirit"] = true,
	["Ancestral Fortitude"] = true,
	["Soul Siphon"] = true,
	["Charge Stun"] = true,
	["Intercept Stun"] = true,
	["Shield Bash - Silenced"] = true,
	["Weakened Soul"] = true,
	["Frost Trap Aura"] = true,
	["Quick Shots"] = true,
	["Swiftmend"] = true,
	["Healing Way"] = true,
	["Winter's Chill"] = true,
	["Improved Fire Totems"] = true,
} end)

L:RegisterTranslations("deDE", function() return {
	--["Chronometer"] = true,
	--["Chronometer - an Ace2 Timer Mod"] = true,

	--["Anchor"] = true,
	--["Shows the dragable anchor."] = true,

	--["Bar Scale"] = true,
	--["Set the bar scale."] = "Set the bar scale",
	
	--["Bar Texture"] = true,
	--["Changes the texture of the timer bars."] = true,

	--["Bar Growth"] = true,
	--["Toggles bar growing up or downwards."] = true,

	--["Fade"] = true,
	--["Toggles whether bars disappear when spells fade."] = true,

	--["Kill"] = true,
	--["Toggles whether bars disappear when killing things."] = true,
	
	--["Ghost"] = true,
	--["Change the amount of time that ghost bars stay up."] = true,
	
	--["Self"] = true,
	--["Toggles bars for spell durations on the player."] = true,
	
	--["Reverse"] = true,
	--["Toggles if bars are reversed (fill up instead of emptying)."] = true,

	--["Test"] = true,
	--["Runs test bars."] = true,
	
	--["Config"] = true,
	--["Show GUI Configuration Menu"] = true,
	
	--["Bar Text"] = true,
	--["Sets the text to be displayed on the bar."] = true,
	--["Use $s for spell name and $t for the target's name."] = true,
	
	--["Bar Width"] = true,
	--["Set the bar width."] = true,
	
	--["Bar Height"] = true,
	--["Set the bar height."] = true,
	
	--["Text Size"] = true,
	--["Set the bar text size."] = true,
	
	--["Text Color"] = true,
	--["Set the bar text color."] = true,
	
	--["Bar Color"] = true,
	--["Set the default bar color."] = true,
	
	--["Background Alpha"] = true,
	--["Alpha value of the bar background."] = true,
	
	--["Background Color"] = true,
	--["Set the bar background color."] = true,
	
	--["Bar"] = true,
	--["CandyBar options"] = true,
	
	--["Hide"] = true,
	
	-- These all need to be added to Babble-Spell!!!
	["Forbearance"] = "Vorahnung",
	["Counterspell - Silenced"] = "Gegenzauber - zum Schweigen gebracht",
	["Faerie Fire (Feral)"] = "Feenfeuer (Tiergestalt)",
	["Starfire Stun"] = "Sternenfeuer-Betubung",
	["Shadow Vulnerability"] = "Schattenverwundbarkeit",
	["Kick - Silenced"] = "Tritt - zum Schweigen gebracht",
	["Remorseless"] = "Gnadenlos",
	["Enamored Water Spirit"] = "Entzckter Wassergeist",
	["Ancestral Fortitude"] = "Seelenstrke der Ahnen",
	["Soul Siphon"] = "Seelen-Siphon",
	["Charge Stun"] = "Sturmangriffsbetubung",
	["Intercept Stun"] = "Betubung abfangen",
	["Shield Bash - Silenced"] = "Schildhieb - zum Schweigen gebracht",
	["Weakened Soul"] = "Geschwächte Seele",
	["Frost Trap Aura"] = "Frostfalle-Aura",
	["Quick Shots"] = "Schnelle Schüsse",
	--["Swiftmend"] = true,
	--["Healing Way"] = true,
	--["Winter's Chill"] = true,
	--["Improved Fire Totems"] = true,
} end)

L:RegisterTranslations("frFR", function() return {
	--["Chronometer"] = true,
	--["Chronometer - an Ace2 Timer Mod"] = true,

	--["Anchor"] = true,
	--["Shows the dragable anchor."] = true,

	--["Bar Scale"] = true,
	--["Set the bar scale."] = true,
	
	--["Bar Texture"] = true,
	--["Changes the texture of the timer bars."] = true,

	--["Bar Growth"] = true,
	--["Toggles bar growing up or downwards."] = true,

	--["Fade"] = true,
	--["Toggles whether bars disappear when spells fade."] = true,

	--["Kill"] = true,
	--["Toggles whether bars disappear when killing things."] = true,
	
	--["Ghost"] = true,
	--["Change the amount of time that ghost bars stay up."] = true,
	
	--["Self"] = true,
	--["Toggles bars for spell durations on the player."] = true,
	
	--["Reverse"] = true,
	--["Toggles if bars are reversed (fill up instead of emptying)."] = true,

	--["Test"] = true,
	--["Runs test bars."] = true,
	
	--["Config"] = true,
	--["Show GUI Configuration Menu"] = true,
	
	--["Bar Text"] = true,
	--["Sets the text to be displayed on the bar."] = true,
	--["Use $s for spell name and $t for the target's name."] = true,
	
	--["Bar Width"] = true,
	--["Set the bar width."] = true,
	
	--["Bar Height"] = true,
	--["Set the bar height."] = true,
	
	--["Text Size"] = true,
	--["Set the bar text size."] = true,
	
	--["Text Color"] = true,
	--["Set the bar text color."] = true,
	
	--["Bar Color"] = true,
	--["Set the default bar color."] = true,
	
	--["Background Alpha"] = true,
	--["Alpha value of the bar background."] = true,
	
	--["Background Color"] = true,
	--["Set the bar background color."] = true,
	
	--["Bar"] = true,
	--["CandyBar options"] = true,
	
	--["Hide"] = true,
	
	-- These all need to be added to Babble-Spell!!!
	["Forbearance"] = "Longanimit\195\169",
	["Counterspell - Silenced"] = "Contresort - Silencieux",
	["Faerie Fire (Feral)"] = "Lucioles (farouche)",
	["Starfire Stun"] = "Feu stellaire \195\169tourdissant",
	["Shadow Vulnerability"] = "Vuln\195\169rabilit\195\169 \195\160 l'ombre",
	["Kick - Silenced"] = "Coup de pied - Silencieux",
	["Remorseless"] = "Impitoyable",
	["Enamored Water Spirit"] = "Esprit de l'eau amoureux",
	["Ancestral Fortitude"] = "Robustesse des anciens",
	["Soul Siphon"] = "Siphon d'\195\162me",
	["Charge Stun"] = "Charge \195\169tourdissante",
	["Intercept Stun"] = "Interception \195\169tourdissante",
	["Shield Bash - Silenced"] = "Coup de bouclier - silencieux",  -- seems to be the only "- Silenced" not having a Cap letter, will try to test!
	["Weakened Soul"] = "Ame affaiblie",
	["Frost Trap Aura"] = "Effet Pi\195\168ge de givre",
	["Quick Shots"] = "Tir rapide",
	["Swiftmend"] = "Prompte Gu\195\169rison",
	["Healing Way"] = "Flots de soins",
	["Winter's Chill"] = "Froid Hivernal",
	--["Improved Fire Totems"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	--["Chronometer"] = true,
	--["Chronometer - an Ace2 Timer Mod"] = true,

	["Anchor"] = "고정위치",
	["Shows the dragable anchor."] = "이동가능한 고정위치를 표시합니다.",

	["Bar Scale"] = "바 크기",
	["Set the bar scale."] = "바 크기를 설정합니다.",
	
	["Bar Texture"] = "바 텍스쳐",
	["Changes the texture of the timer bars."] = "타이머 바의 텍스쳐를 변경 합니다.",

	["Bar Growth"] = "바 생성",
	["Toggles bar growing up or downwards."] = "바 생성 방향을 위 혹은 아래로 전환합니다.",

	["Fade"] = "사라짐",
	["Toggles whether bars disappear when spells fade."] = "주문이 사라질 때 바를 사라지게 할 지를 결정합니다.",

	["Kill"] = "죽임",
	["Toggles whether bars disappear when killing things."] = "죽였을 때 바를 사라지게 할 지를 결정합니다.",
	
	["Ghost"] = "유령",
	["Change the amount of time that ghost bars stay up."] = "유령 바가 유지 되는 시간을 변경합니다.",
	
	["Self"] = "자신",
	["Toggles bars for spell durations on the player."] = "플레이어의 주문 지속시간에 대한 바를 전환합니다.",
	
	["Reverse"] = "반전",
	["Toggles if bars are reversed (fill up instead of emptying)."] = "바를 반전하여 표현합니다. (채우기 대신 비우기).",

	["Test"] = "테스트",
	["Runs test bars."] = "바를 테스트합니다.",
	
	["Config"] = "환경설정",
	["Show GUI Configuration Menu"] = "환경 설정 메뉴 열기",

	["Bar Text"] = "바 글자",
	["Sets the text to be displayed on the bar."] = "바 위에 표시되는 글자를 설정합니다.",
	["Use $s for spell name and $t for the target's name."] = "주문 이름을 나타내는 $s 와 대상의 이름을 나타내는 $t 를 사용하세요.",

	["Bar Width"] = "바 넓이",
	["Set the bar width."] = "바 넓이를 설정합니다.",
	
	["Bar Height"] = "바 높이",
	["Set the bar height."] = "바 높이를 설정합니다.",
	
	["Text Size"] = "글자 크기",
	["Set the bar text size."] = "바 글자 크기를 설정합니다.",
	
	["Text Color"] = "글자 색상",
	["Set the bar text color."] = "바 글자 색상을 설정합니다.",
	
	["Bar Color"] = "바 색상",
	["Set the default bar color."] = "기본 바 색상을 설정합니다.",
	
	["Background Alpha"] = "배경 투명도",
	["Alpha value of the bar background."] = "바 배경의 투명도를 설정합니다.",
	
	["Background Color"] = "배경 색상",
	["Set the bar background color."] = "바 배경 색상을 설정합니다.",
	
	["Bar"] = "바",
	["CandyBar options"] = "CandyBar 설정",
	
	["Hide"] = "숨기기",
	
	-- These all need to be added to Babble-Spell!!!
	["Forbearance"] = "참을성",
	["Counterspell - Silenced"] = "마법 차단 - 침묵",
	["Faerie Fire (Feral)"] = "요정의 불꽃 (야성)",
	["Starfire Stun"] = "별빛 화살 기절",
	["Shadow Vulnerability"] = "암흑 저항력 약화",
	["Kick - Silenced"] = "발차기 - 침묵",
	["Remorseless"] = "냉혹함",
	["Enamored Water Spirit"] = "사로잡힌 물의 정령",
	["Ancestral Fortitude"] = "선인의 인내",
	["Soul Siphon"] = "영혼 착취",
	["Charge Stun"] = "돌진 기절",
	["Intercept Stun"] = "봉쇄 기절",
	["Shield Bash - Silenced"] = "방패 가격 - 침묵",
	["Weakened Soul"] = "약화된 영혼",
	["Frost Trap Aura"] = "냉기의 덫",
	["Quick Shots"] = "신속 사격",
	["Swiftmend"] = "신속한 치유",
	["Healing Way"] = "치유의 길",
	["Winter's Chill"] = "혹한의 추위",
	--["Improved Fire Totems"] = true,
} end)

L:RegisterTranslations("zhCN", function() return {
	--["Chronometer"] = true,
	["Chronometer - an Ace2 Timer Mod"] = "Chronometer - ACE2计时条插件",

	["Anchor"] = "锚点",
	["Shows the dragable anchor."] = "显示可拖动的锚点。",

	["Bar Scale"] = "计时条缩放",
	["Set the bar scale."] = "设定计时条缩放大小。",
	
	["Bar Texture"] = "计时条材质",
	["Changes the texture of the timer bars."] = "变更计时条材质。",

	["Bar Growth"] = "计时条方向",
	["Toggles bar growing up or downwards."] = "切换计时条是向下还是向上延展。",

	["Fade"] = "消失",
	["Toggles whether bars disappear when spells fade."] = "切换当法术消失时计时条是否消失。",

	["Kill"] = "杀死",
	["Toggles whether bars disappear when killing things."] = "切换当杀死敌人时计时条是否消失。",
	
	["Ghost"] = "失效",
	["Change the amount of time that ghost bars stay up."] = "变更失效计时条保持显示的时间。",
	
	["Self"] = "自身",
	["Toggles bars for spell durations on the player."] = "切换是否显示为玩家身上的法术效果显示计时条。",
	
	["Reverse"] = "反转",
	["Toggles if bars are reversed (fill up instead of emptying)."] = "切换是否反转计时条。（递减而非递增）",

	["Test"] = "测试",
	["Runs test bars."] = "运行测试计时条。",
	
	["Config"] = "设置",
	["Show GUI Configuration Menu"] = "显示图形设置菜单。",

	["Bar Text"] = "计时条文本",
	["Sets the text to be displayed on the bar."] = "设定计时条上显示的文本内容。",
	["Use $s for spell name and $t for the target's name."] = "使用$s代指法术名字，$t代指目标名字。",

	["Bar Width"] = "计时条宽度",
	["Set the bar width."] = "设定计时条宽度。",
	
	["Bar Height"] = "计时条高度",
	["Set the bar height."] = "设定计时条高度。",
	
	["Text Size"] = "文字尺寸",
	["Set the bar text size."] = "设定计时条文字尺寸。",
	
	["Text Color"] = "文字颜色",
	["Set the bar text color."] = "设定计时条文字颜色。",
	
	["Bar Color"] = "计时条颜色",
	["Set the default bar color."] = "设定默认计时条颜色。",
	
	["Background Alpha"] = "背景透明度",
	["Alpha value of the bar background."] = "设定计时条背景透明度。",
	
	["Background Color"] = "背景颜色",
	["Set the bar background color."] = "设定计时条背景颜色。",
	
	["Bar"] = "计时条",
	["CandyBar options"] = "CandyBar 设置",
	
	["Hide"] = "隐藏",
	
	-- These all need to be added to Babble-Spell!!!
	["Forbearance"] = "自律",
	["Counterspell - Silenced"] = "法术反制 - 沉默",
	["Faerie Fire (Feral)"] = "精灵之火（野性）",
	["Starfire Stun"] = "星火昏迷",
	["Shadow Vulnerability"] = "暗影易伤",
	["Kick - Silenced"] = "脚踢 - 沉默",
	["Remorseless"] = "冷酷",
	["Enamored Water Spirit"] = "被迷惑的水之魂",
	["Ancestral Fortitude"] = "先祖坚韧",
	["Soul Siphon"] = "灵魂虹吸",
	["Charge Stun"] = "冲锋击昏",
	["Intercept Stun"] = "拦截昏迷",
	["Shield Bash - Silenced"] = "盾击 - 沉默",
	["Weakened Soul"] = "虚弱灵魂",
	["Frost Trap Aura"] = "冰霜陷阱光环",
	["Quick Shots"] = "快速射击",
	["Swiftmend"] = "迅捷治愈",
	["Healing Way"] = "治疗之道",
	["Winter's Chill"] = "深冬之寒",
	--["Improved Fire Totems"] = true,
} end)