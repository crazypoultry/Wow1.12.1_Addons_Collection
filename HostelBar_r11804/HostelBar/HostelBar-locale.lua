local L = AceLibrary("AceLocale-2.0"):new("HostelBar")

L:RegisterTranslations("enUS", function()
    return {
    	["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- names of the groups 
	["Hostel"] =	"Hostel", -- this is the default group (its only displayed when grouping is off, only used for title)
	["Default"] =	"Default", -- the real string for the default group (used in command and gui)
	["Casts"] =	"Casts",
	["Cooldowns"] = "Cooldowns",
	["Buffs"] =	"Buffs",
	["Durations"] = "Durations",
	["All"] =	"All", -- used to set all groups at once

	-- descriptions of the groups
	["DescDefault"] =	"The default anchor.",
	["DescCasts"] =		"Casting times.",
	["DescCooldowns"] =	"Cooldown times.",
	["DescBuffs"] =		"Buff durations.",
	["DescDurations"] =	"Duration of debuffs/buffs on hostile/friendly players/mobs.",
	["DescAll"] =		"All the groups.",

	-- Names (command and gui)
	["Target Only"] =		"Target Only",
	["Grouped"] =			"Grouped",
	["Stop On Death"] =		"Stop On Death",
	["Stop On Hostile Death"] =	"Stop On Hostile Death",
	["Interrupt Time"] =		"Interrupt Time",
	["Diminishing Returns"] =	"Diminishing Returns",
	["Self Durations"] =		"Self Durations",
	["No Name"] =			"No Name",
	["Long CD"] =			"Long CD",
	["Background Alpha"] =		"Background Alpha",
	["Event"] =			"Event",
	["Enabled"] =			"Enabled",
	["Bar Growth"] =		"Bar Growth",
	["Titles"] =			"Titles",
	["Reversed"] =			"Reversed",
	["Bar Color"] =			"Bar Color",
	["Background Color"] =		"Background Color",
	["Text Color"] =		"Text Color",
	["Bar Scale"] =			"Bar Scale",
	["Texture"] =			"Texture",
	["Show Anchors"] =		"Show Anchors",
	["Test"] =			"Test",

	-- descriptions (command and gui)
	["DescTargetOnly"] =		"Parse only your target's spells.",
	["DescGrouped"] =		"Whether the bars are displayed in groups or under the default anchor",
	["DescStopOnDeath"] =		"Stop all bars when you die.",
	["DescStopOnHostileDeath"] =	"Stop all bars from a player when he dies.",
	["DescInterruptTime"]	=	"The duration that your enemy is unable to cast spells from the school which you interrupted.",
	["DescDiminishingReturns"] =	"Display diminishing returns timers.",
	["DescSelfDurations"] =		"Only display durations (debuffs) caused by you.",
	["DescNoName"] =		"Only show spell name in bar text",
	["DescLongCD"] =		"Display spell cooldowns longer than 2 mins.",
	["DescBGAlpha"] =		"The transparency of a bar's background.",
	["DescEvent"] =			"Toggle registered events - if you don't want a certain event parsed then simply turn it off here.",
	["DescEnabled"]	=		"Whether the bars from a certain group will be shown.",
	["DescBarGrowth"] =		"The direction the bars will grow in.",
	["DescTitles"] =		"Show titles above the bars.",
	["DescReversed"] =		"Whether the bar will fill or deplete.",
	["DescBarColor"] =		"The color of the timer bars.",
	["DescBgColor"] =		"The background color of the bars.",
	["DescTextColor"] =		"The color of the text.",
	["DescBarScale"] =		"The scale of the bars.",
	["DescTexture"] =		"The texture of the bars.",
	["DescShowAnchors"] =		"Toggle the anchors.",
	["DescTest"] =			"Run a test bar under each anchor.",

	-- Event names
	["Hostile Player Events"] =	"Hostile Player Events",
	["Player Events"] =		"Player Events",
	["Friendly Player Events"] =	"Friendly Player Events",
	["Creature Events"] =		"Creature Events", 
	-- Event Descriptions
	["DescEventsPlayer"] =	"Events fired by the player.",
	["DescEventsHPlayer"] = "Events fired by hostile players.",
	["DescEventsFPlayer"] = "Events fired by friendly players.",
	["DescEventsMobs"] =	"Events fired by mobs.",
	
	-- Map strings 
		-- Event cmd line message
		["EventMsg"] = "The event %s is now [%s]",
		-- Event map strings
		["MapEventFalse"] = "|cffff5050Unregistered|r",
		["MapEventTrue"] =  "|cff00ff00Registered|r",
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- color opts strings (for chat commands)
	["class"] =  "class",
	["type"] =   "type",
	["school"] = "school",
	["white"] =  "white",
	["default"] = "default",

	-- GUI strings
	-- Anchor frames
	["GUIAnchorsString"] =  " bars will appear here.", 
	["Timer"] =	"Timer",
	["Cast"] =	"Cast",
	["Cooldown"] =  "Cooldown",
	["Buff"] =	"Buff",
	["Duration"] =  "Duration",
	
	["GUITestBarTextCaster"] = "Caster", -- test bars text 
	["GUITestBarTextSpell"] =  "Spell", -- test bars text 

	-- Spells (not supported by BabbleSpell)
	["Kick - Silenced"] =		"Kick - Silenced",
	["Counterspell - Silenced"] =	"Counterspell - Silenced",
	["Shield Bash - Silenced"] =	"Shield Bash - Silenced",
    }
end)

L:RegisterTranslations("deDE", function()
    return {
    	["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- names of the groups 
	["Hostel"] =	"Hostel", -- this is the default group (its only displayed when grouping is off, only used for title)
	["Default"] =	"Default", -- the real string for the default group (used in command and gui)
	["Casts"] =	"Casts",
	["Cooldowns"] = "Cooldowns",
	["Buffs"] =	"Buffs",
	["Durations"] = "Durations",
	["All"] =	"All", -- used to set all groups at once

	-- descriptions of the groups
	["DescDefault"] =	"The default anchor.",
	["DescCasts"] =		"Casting times.",
	["DescCooldowns"] =	"Cooldown times.",
	["DescBuffs"] =		"Buff durations.",
	["DescDurations"] =	"Duration of debuffs/buffs on hostile/friendly players/mobs.",
	["DescAll"] =		"All the groups.",

	-- Names (command and gui)
	["Target Only"] =		"Target Only",
	["Grouped"] =			"Grouped",
	["Stop On Death"] =		"Stop On Death",
	["Stop On Hostile Death"] =	"Stop On Hostile Death",
	["Interrupt Time"] =		"Interrupt Time",
	["Diminishing Returns"] =	"Diminishing Returns",
	["Self Durations"] =		"Self Durations",
	["No Name"] =			"No Name",
	["Long CD"] =			"Long CD",
	["Background Alpha"] =		"Background Alpha",
	["Event"] =			"Event",
	["Enabled"] =			"Enabled",
	["Bar Growth"] =		"Bar Growth",
	["Titles"] =			"Titles",
	["Reversed"] =			"Reversed",
	["Bar Color"] =			"Bar Color",
	["Background Color"] =		"Background Color",
	["Text Color"] =		"Text Color",
	["Bar Scale"] =			"Bar Scale",
	["Texture"] =			"Texture",
	["Show Anchors"] =		"Show Anchors",
	["Test"] =			"Test",

	-- descriptions (command and gui)
	["DescTargetOnly"] =		"Parse only your target's spells.",
	["DescGrouped"] =		"Whether the bars are displayed in groups or under the default anchor",
	["DescStopOnDeath"] =		"Stop all bars when you die.",
	["DescStopOnHostileDeath"] =	"Stop all bars from a player when he dies.",
	["DescInterruptTime"]	=	"The duration that your enemy is unable to cast spells from the school which you interrupted.",
	["DescDiminishingReturns"] =	"Display diminishing returns timers.",
	["DescSelfDurations"] =		"Only display durations (debuffs) caused by you.",
	["DescNoName"] =		"Only show spell name in bar text",
	["DescLongCD"] =		"Display spell cooldowns longer than 2 mins.",
	["DescBGAlpha"] =		"The transparency of a bar's background.",
	["DescEvent"] =			"Toggle registered events - if you don't want a certain event parsed then simply turn it off here.",
	["DescEnabled"]	=		"Whether the bars from a certain group will be shown.",
	["DescBarGrowth"] =		"The direction the bars will grow in.",
	["DescTitles"] =		"Show titles above the bars.",
	["DescReversed"] =		"Whether the bar will fill or deplete.",
	["DescBarColor"] =		"The color of the timer bars.",
	["DescBgColor"] =		"The background color of the bars.",
	["DescTextColor"] =		"The color of the text.",
	["DescBarScale"] =		"The scale of the bars.",
	["DescTexture"] =		"The texture of the bars.",
	["DescShowAnchors"] =		"Toggle the anchors.",
	["DescTest"] =			"Run a test bar under each anchor.",

	-- Event names
	["Hostile Player Events"] =	"Hostile Player Events",
	["Player Events"] =		"Player Events",
	["Friendly Player Events"] =	"Friendly Player Events",
	["Creature Events"] =		"Creature Events", 
	-- Event Descriptions
	["DescEventsPlayer"] =	"Events fired by the player.",
	["DescEventsHPlayer"] = "Events fired by hostile players.",
	["DescEventsFPlayer"] = "Events fired by friendly players.",
	["DescEventsMobs"] =	"Events fired by mobs.",
	
	-- Map strings 
		-- Event cmd line message
		["EventMsg"] = "The event %s is now [%s]",
		-- Event map strings
		["MapEventFalse"] = "|cffff5050Unregistered|r",
		["MapEventTrue"] =  "|cff00ff00Registered|r",
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- color opts strings (for chat commands)
	["class"] =  "class",
	["type"] =   "type",
	["school"] = "school",
	["white"] =  "white",
	["default"] = "default",

	-- GUI strings
	-- Anchor frames
	["GUIAnchorsString"] =  " bars will appear here.", 
	["Timer"] =	"Timer",
	["Cast"] =	"Cast",
	["Cooldown"] =  "Cooldown",
	["Buff"] =	"Buff",
	["Duration"] =  "Duration",
	
	["GUITestBarTextCaster"] = "Caster", -- test bars text 
	["GUITestBarTextSpell"] =  "Spell", -- test bars text 

	-- Spells (not supported by BabbleSpell)
	["Kick - Silenced"] =		"Kick - Silenced",
	["Counterspell - Silenced"] =	"Counterspell - Silenced",
    }
end)

L:RegisterTranslations("frFR", function()
    return {
    	["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- names of the groups 
	["Hostel"] =	"Hostel", -- this is the default group (its only displayed when grouping is off, only used for title)
	["Default"] =	"Default", -- the real string for the default group (used in command and gui)
	["Casts"] =	"Casts",
	["Cooldowns"] = "Cooldowns",
	["Buffs"] =	"Buffs",
	["Durations"] = "Durations",
	["All"] =	"All", -- used to set all groups at once

	-- descriptions of the groups
	["DescDefault"] =	"The default anchor.",
	["DescCasts"] =		"Casting times.",
	["DescCooldowns"] =	"Cooldown times.",
	["DescBuffs"] =		"Buff durations.",
	["DescDurations"] =	"Duration of debuffs/buffs on hostile/friendly players/mobs.",
	["DescAll"] =		"All the groups.",

	-- Names (command and gui)
	["Target Only"] =		"Target Only",
	["Grouped"] =			"Grouped",
	["Stop On Death"] =		"Stop On Death",
	["Stop On Hostile Death"] =	"Stop On Hostile Death",
	["Interrupt Time"] =		"Interrupt Time",
	["Diminishing Returns"] =	"Diminishing Returns",
	["Self Durations"] =		"Self Durations",
	["No Name"] =			"No Name",
	["Long CD"] =			"Long CD",
	["Background Alpha"] =		"Background Alpha",
	["Event"] =			"Event",
	["Enabled"] =			"Enabled",
	["Bar Growth"] =		"Bar Growth",
	["Titles"] =			"Titles",
	["Reversed"] =			"Reversed",
	["Bar Color"] =			"Bar Color",
	["Background Color"] =		"Background Color",
	["Text Color"] =		"Text Color",
	["Bar Scale"] =			"Bar Scale",
	["Texture"] =			"Texture",
	["Show Anchors"] =		"Show Anchors",
	["Test"] =			"Test",

	-- descriptions (command and gui)
	["DescTargetOnly"] =		"Parse only your target's spells.",
	["DescGrouped"] =		"Whether the bars are displayed in groups or under the default anchor",
	["DescStopOnDeath"] =		"Stop all bars when you die.",
	["DescStopOnHostileDeath"] =	"Stop all bars from a player when he dies.",
	["DescInterruptTime"]	=	"The duration that your enemy is unable to cast spells from the school which you interrupted.",
	["DescDiminishingReturns"] =	"Display diminishing returns timers.",
	["DescSelfDurations"] =		"Only display durations (debuffs) caused by you.",
	["DescNoName"] =		"Only show spell name in bar text",
	["DescLongCD"] =		"Display spell cooldowns longer than 2 mins.",
	["DescBGAlpha"] =		"The transparency of a bar's background.",
	["DescEvent"] =			"Toggle registered events - if you don't want a certain event parsed then simply turn it off here.",
	["DescEnabled"]	=		"Whether the bars from a certain group will be shown.",
	["DescBarGrowth"] =		"The direction the bars will grow in.",
	["DescTitles"] =		"Show titles above the bars.",
	["DescReversed"] =		"Whether the bar will fill or deplete.",
	["DescBarColor"] =		"The color of the timer bars.",
	["DescBgColor"] =		"The background color of the bars.",
	["DescTextColor"] =		"The color of the text.",
	["DescBarScale"] =		"The scale of the bars.",
	["DescTexture"] =		"The texture of the bars.",
	["DescShowAnchors"] =		"Toggle the anchors.",
	["DescTest"] =			"Run a test bar under each anchor.",

	-- Event names
	["Hostile Player Events"] =	"Hostile Player Events",
	["Player Events"] =		"Player Events",
	["Friendly Player Events"] =	"Friendly Player Events",
	["Creature Events"] =		"Creature Events", 
	-- Event Descriptions
	["DescEventsPlayer"] =	"Events fired by the player.",
	["DescEventsHPlayer"] = "Events fired by hostile players.",
	["DescEventsFPlayer"] = "Events fired by friendly players.",
	["DescEventsMobs"] =	"Events fired by mobs.",
	
	-- Map strings 
		-- Event cmd line message
		["EventMsg"] = "The event %s is now [%s]",
		-- Event map strings
		["MapEventFalse"] = "|cffff5050Unregistered|r",
		["MapEventTrue"] =  "|cff00ff00Registered|r",
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- color opts strings (for chat commands)
	["class"] =  "class",
	["type"] =   "type",
	["school"] = "school",
	["white"] =  "white",
	["default"] = "default",

	-- GUI strings
	-- Anchor frames
	["GUIAnchorsString"] =  " bars will appear here.", 
	["Timer"] =	"Timer",
	["Cast"] =	"Cast",
	["Cooldown"] =  "Cooldown",
	["Buff"] =	"Buff",
	["Duration"] =  "Duration",
	
	["GUITestBarTextCaster"] = "Caster", -- test bars text 
	["GUITestBarTextSpell"] =  "Spell", -- test bars text 

	-- Spells (not supported by BabbleSpell)
	["Kick - Silenced"] =		"Contresort - Silencieux",
	["Counterspell - Silenced"] =	"Coup de pied - Silencieux",
    }
end)

L:RegisterTranslations("zhCN", function()
    return {
    	["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- names of the groups 
	["Hostel"] =	"Hostel", -- this is the default group (its only displayed when grouping is off, only used for title)
	["Default"] =	"Default", -- the real string for the default group (used in command and gui)
	["Casts"] =	"Casts",
	["Cooldowns"] = "Cooldowns",
	["Buffs"] =	"Buffs",
	["Durations"] = "Durations",
	["All"] =	"All", -- used to set all groups at once

	-- descriptions of the groups
	["DescDefault"] =	"The default anchor.",
	["DescCasts"] =		"Casting times.",
	["DescCooldowns"] =	"Cooldown times.",
	["DescBuffs"] =		"Buff durations.",
	["DescDurations"] =	"Duration of debuffs/buffs on hostile/friendly players/mobs.",
	["DescAll"] =		"All the groups.",

	-- Names (command and gui)
	["Target Only"] =		"Target Only",
	["Grouped"] =			"Grouped",
	["Stop On Death"] =		"Stop On Death",
	["Stop On Hostile Death"] =	"Stop On Hostile Death",
	["Interrupt Time"] =		"Interrupt Time",
	["Diminishing Returns"] =	"Diminishing Returns",
	["Self Durations"] =		"Self Durations",
	["No Name"] =			"No Name",
	["Long CD"] =			"Long CD",
	["Background Alpha"] =		"Background Alpha",
	["Event"] =			"Event",
	["Enabled"] =			"Enabled",
	["Bar Growth"] =		"Bar Growth",
	["Titles"] =			"Titles",
	["Reversed"] =			"Reversed",
	["Bar Color"] =			"Bar Color",
	["Background Color"] =		"Background Color",
	["Text Color"] =		"Text Color",
	["Bar Scale"] =			"Bar Scale",
	["Texture"] =			"Texture",
	["Show Anchors"] =		"Show Anchors",
	["Test"] =			"Test",

	-- descriptions (command and gui)
	["DescTargetOnly"] =		"Parse only your target's spells.",
	["DescGrouped"] =		"Whether the bars are displayed in groups or under the default anchor",
	["DescStopOnDeath"] =		"Stop all bars when you die.",
	["DescStopOnHostileDeath"] =	"Stop all bars from a player when he dies.",
	["DescInterruptTime"]	=	"The duration that your enemy is unable to cast spells from the school which you interrupted.",
	["DescDiminishingReturns"] =	"Display diminishing returns timers.",
	["DescSelfDurations"] =		"Only display durations (debuffs) caused by you.",
	["DescNoName"] =		"Only show spell name in bar text",
	["DescLongCD"] =		"Display spell cooldowns longer than 2 mins.",
	["DescBGAlpha"] =		"The transparency of a bar's background.",
	["DescEvent"] =			"Toggle registered events - if you don't want a certain event parsed then simply turn it off here.",
	["DescEnabled"]	=		"Whether the bars from a certain group will be shown.",
	["DescBarGrowth"] =		"The direction the bars will grow in.",
	["DescTitles"] =		"Show titles above the bars.",
	["DescReversed"] =		"Whether the bar will fill or deplete.",
	["DescBarColor"] =		"The color of the timer bars.",
	["DescBgColor"] =		"The background color of the bars.",
	["DescTextColor"] =		"The color of the text.",
	["DescBarScale"] =		"The scale of the bars.",
	["DescTexture"] =		"The texture of the bars.",
	["DescShowAnchors"] =		"Toggle the anchors.",
	["DescTest"] =			"Run a test bar under each anchor.",

	-- Event names
	["Hostile Player Events"] =	"Hostile Player Events",
	["Player Events"] =		"Player Events",
	["Friendly Player Events"] =	"Friendly Player Events",
	["Creature Events"] =		"Creature Events", 
	-- Event Descriptions
	["DescEventsPlayer"] =	"Events fired by the player.",
	["DescEventsHPlayer"] = "Events fired by hostile players.",
	["DescEventsFPlayer"] = "Events fired by friendly players.",
	["DescEventsMobs"] =	"Events fired by mobs.",
	
	-- Map strings 
		-- Event cmd line message
		["EventMsg"] = "The event %s is now [%s]",
		-- Event map strings
		["MapEventFalse"] = "|cffff5050Unregistered|r",
		["MapEventTrue"] =  "|cff00ff00Registered|r",
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- color opts strings (for chat commands)
	["class"] =  "class",
	["type"] =   "type",
	["school"] = "school",
	["white"] =  "white",
	["default"] = "default",

	-- GUI strings
	-- Anchor frames
	["GUIAnchorsString"] =  " bars will appear here.", 
	["Timer"] =	"Timer",
	["Cast"] =	"Cast",
	["Cooldown"] =  "Cooldown",
	["Buff"] =	"Buff",
	["Duration"] =  "Duration",
	
	["GUITestBarTextCaster"] = "Caster", -- test bars text 
	["GUITestBarTextSpell"] =  "Spell", -- test bars text 

	-- Spells (not supported by BabbleSpell)
	["Kick - Silenced"] =		"Kick - Silenced",
	["Counterspell - Silenced"] =	"Counterspell - Silenced",
    }
end)

L:RegisterTranslations("koKR", function()
    return {
    	["Fonts\\skurri.ttf"] = "Fonts\\2002.ttf", -- for locales which dont support this font (internal)
	
	-- names of the groups 
	["Hostel"] =	"적", -- this is the default group (its only displayed when grouping is off, only used for title)
	["Default"] =	"기본", -- the real string for the default group (used in command and gui)
	["Casts"] =	"시전",
	["Cooldowns"] = "재사용 대기",
	["Buffs"] =	"버프",
	["Durations"] = "지속 시간",
	["All"] =	"모두", -- used to set all groups at once

	-- descriptions of the groups
	["DescDefault"] =	"기본 위치.",
	["DescCasts"] =		"시전 시간.",
	["DescCooldowns"] =	"재사용 대기 시간.",
	["DescBuffs"] =		"버프 지속 시간.",
	["DescDurations"] =	"적대적/우호적 플레이어/몹의 디버프/버프 지속 시간.",
	["DescAll"] =		"모든 그룹",

	-- Names (command and gui)
	["Target Only"] =		"대상에 한해",
	["Grouped"] =			"그룹화",
	["Stop On Death"] =		"죽었을 때 중지",
	["Stop On Hostile Death"] =	"적이 죽었을 때 중지",
	["Interrupt Time"] =		"취소된 시간",
	["Diminishing Returns"] =	"감소",
	["Self Durations"] =		"자신의 지속 시간",
	["No Name"] =			"시전자 이름 표시 안함",
	["Long CD"] =			"긴 재사용 대기시간",
	["Background Alpha"] =		"배경 투명도",
	["Event"] =			"이벤트",
	["Enabled"] =			"활성화됨",
	["Bar Growth"] =		"바 생성",
	["Titles"] =			"제목",
	["Reversed"] =			"반전",
	["Bar Color"] =			"바 색상",
	["Background Color"] =		"배경 색상",
	["Text Color"] =		"글자 색상",
	["Bar Scale"] =			"바 크기",
	["Texture"] =			"텍스쳐",
	["Show Anchors"] =		"위치표시",
	["Test"] =			"테스트",

	-- descriptions (command and gui)
	["DescTargetOnly"] =		"대상의 주문에 한해 바를 표시합니다.",
	["DescGrouped"] =		"바를 그룹화 하여 표시할 것인지 기본 위치에 표시할 것인지 선택합니다.",
	["DescStopOnDeath"] =		"당신이 죽었을 때 모든 바를 중지합니다.",
	["DescStopOnHostileDeath"] =	"특정 대상이 죽었을 때 모든 바를 중지합니다.",
	["DescInterruptTime"]	=	"피해(마법/신성/자연 등)에 의해 취소되어 주문 시전이 불가능해진 지속 시간입니다.",
	["DescDiminishingReturns"] =	"감소되어가는 타이머를 표시합니다.",
	["DescSelfDurations"] =		"당신에 의해 시전된 디버프의 지속 시간만을 표시합니다.",
	["DescNoName"] =		"바에 주문의 이름만 표시합니다",
	["DescLongCD"] =		"재사용 대기 시간이 2분 이상인 주문을 표시합니다.",
	["DescBGAlpha"] =		"바 배경의 투명도를 조절합니다.",
	["DescEvent"] =			"등록된 이벤트를 전환합니다 - 어떤 이벤트를 표시하고 싶지 않다면 해당 이벤트를 비활성화 시키십시요.",
	["DescEnabled"]	=		"어떤 그룹의 바부터 표시할지를 선택합니다.",
	["DescBarGrowth"] =		"바 생성 방향을 설정합니다.",
	["DescTitles"] =		"바 위에 제목을 표시합니다.",
	["DescReversed"] =		"바를 채워 나갈 것인지 혹은 비워 나갈 것인지를 선택합니다.",
	["DescBarColor"] =		"타이머 바의 색상을 선택합니다.",
	["DescBgColor"] =		"바의 배경 색상을 선택합니다.",
	["DescTextColor"] =		"글자의 색상을 선택합니다.",
	["DescBarScale"] =		"바의 크기를 조절합니다.",
	["DescTexture"] =		"바의 텍스쳐를 선택합니다.",
	["DescShowAnchors"] =		"위치를 전환할 수 있습니다.",
	["DescTest"] =			"각 위치에 테스트바를 표시합니다.",

	-- Event names
	["Hostile Player Events"] =	"적대적 플레이어 이벤트",
	["Player Events"] =		"플레이어 이벤트",
	["Friendly Player Events"] =	"우호적 플레이어 이벤트",
	["Creature Events"] =		"NPC 이벤트", 
	-- Event Descriptions
	["DescEventsPlayer"] =	"플레이어에 의해 발생된 이벤트입니다.",
	["DescEventsHPlayer"] = "적대적 플레이어에 의해 발생된 이벤트입니다.",
	["DescEventsFPlayer"] = "우호적 플레이어에 의해 발생된 이벤트입니다.",
	["DescEventsMobs"] =	"몹에 의해 발생된 이벤트입니다.",
	
	-- Map strings 
		-- Event cmd line message
		["EventMsg"] = "이벤트 %s|1은;는; 현재 [%s] 이다.",
		-- Event map strings
		["MapEventFalse"] = "|cffff5050해제됨|r",
		["MapEventTrue"] =  "|cff00ff00등록됨|r",
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050아래|r",
		["MapBarGrowthTrue"] =  "|cff00ff00위|r",
	
	-- color opts strings (for chat commands)
	["class"] =  "class",
	["type"] =   "type",
	["school"] = "school",
	["white"] =  "white",
	["default"] = "default",

	-- GUI strings
	-- Anchor frames
	["GUIAnchorsString"] =  " 바를 이곳에 표시합니다.", 
	["Timer"] =	"타이머",
	["Cast"] =	"시전",
	["Cooldown"] =  "재사용대기",
	["Buff"] =	"버프",
	["Duration"] =  "지속시간",
	
	["GUITestBarTextCaster"] = "시전자", -- test bars text 
	["GUITestBarTextSpell"] =  "주문", -- test bars text 

	-- Spells (not supported by BabbleSpell)
	["Kick - Silenced"] =		"발차기 침묵",
	["Counterspell - Silenced"] =	"마법 차단 - 침묵",
	["Shield Bash - Silenced"] =    "방패 가격 - 침묵",
    }
end)