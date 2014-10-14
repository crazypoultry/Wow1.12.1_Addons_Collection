-- zhCN localization by hk2717

local L = AceLibrary("AceLocale-2.2"):new("Squishy")

L:RegisterTranslations("zhCN", function() return {

	-- bindings
	["Target unit with highest priority"] = "定位第一优先单位。",
	["Target unit with 2nd highest priority"] = "定位第二优先单位。",
	["Target unit with 3rd highest priority"] = "定位第三优先单位。",

	-- from combatlog
	["(.+) begins to cast (.+)."] = "(.+)开始施放(.+)。",

	-- options	
	["Default"] = "默认",
	["Blizzard"] = "暴雪",
	["Smooth"] = "平滑",
	
	["always"] = "一直",
	["grouped"] = "组队时",
	
	["Frame options"] = "框体设置",
	["Scale"] = "缩放",
	["Scales the Emergency Monitor."] = "缩放紧急状况监视器。",
	["Number of units"] = "单位数量",
	["Number of max visible units."] = "最大显示单位数量",
	["Frame lock"] = "锁定框体",
	["Locks/unlocks the emergency monitor."] = "锁定/解锁紧急状况监视器。",
	["Show Frame"] = "框体显示",
	["Sets when the Squishy frame is visible: Choose 'always' or 'grouped'."] = "设置Squishy框体的显示方式。选择'一直'，'组队时'或'。",
	["Pet support"] = "宠物支持",
	["Toggles the display of pets in the emergency frame."] = "切换是否在紧急状况监视器中显示宠物。",
	
	["Unit options"] = "外观设置",
	["Alpha"] = "透明度",
	["Changes background+border visibility"] = "设定背景与边框的透明度。",
	["Texture"] = "材质",
	["Sets the bar texture. Choose 'Default', 'BantoBar', 'Button', 'Charcoal', 'Otravi', 'Perl', 'Smooth' or 'Smudge'."] = "设置状态条的材质。选择'暴雪'，'默认'或'平滑'。",
	["Health deficit"] = "生命减少量",
	["Toggles the display of health deficit in the emergency frame."] = "切换是否在紧急状况监视器中显示生命减少量。",
	
	["Class options"] = "Class options",
	
	["Various options"] = "杂项设置",
	["Audio alert on aggro"] = "获得仇恨时发出声音警报",
	["Toggle on/off audio alert on aggro."] = "切换是否在获得仇恨时发出声音警报。",
	["Log range"] = "记录范围",
	["Changes combat log range. Set it to your max healing range"] = "设定战斗记录范围。设置为你治疗法术的最大施法距离。",
	["Version Query"] = "Version Query",
	["Checks the group for Squishy users and prints their version data."] = "Checks the group for Squishy users and prints their version data.",
	["Checking group for Squishy users, please wait."] = "Checking group for Squishy users, please wait.",
	["using"] = "using",

	-- notifications in frame
	[" is healing you."] = "正在治疗你。",
	[" healing your group."] = "正在治疗你的小组。",
	[" died."] = " died.",
	
	-- frame header
	["Squishy Emergency"] = "Squishy紧急状况监视器",
	
	-- debuffs and other spell related locals
	["Mortal Strike"] = "Mortal Strike",
	["Mortal Cleave"] = "Mortal Cleave",
	["Gehennas\' Curse"] = "Gehennas\' Curse",
	["Curse of the Deadwood"] = "Curse of the Deadwood",
	["Blood Fury"] = "Blood Fury",
	["Brood Affliction: Green"] = "Brood Affliction: Green",
	["Necrotic Poison"] = "Necrotic Poison",
	["Conflagration"] = "Conflagration",
	["Petrification"] = "Petrification",
} end)
