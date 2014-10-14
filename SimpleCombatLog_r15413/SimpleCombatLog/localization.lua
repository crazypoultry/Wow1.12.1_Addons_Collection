

local loc = {}

loc.core = {

	-- Strings which may appear in the combat log.
	["Melee"] = "Melee",
	["Damage Shields"] = "Damage Shields",
	["All Items"] = "All Items",
	["You"] = "You",
	

	-- Strings for slash commands.
	["Welcome"] = {
		"/scl for slash commands.",
		"To customize a specific ChatFrame, Alt-RightClick on a ChatFrameTab to show the drop down menu of that chat frame.",
	},	
	["CmdHelpDesc"] = "Show help message",
	["CmdResetDesc"] = "Reset all saved variables and load default theme for ChatFrame2.",
	["CmdShowDesc"] = "Show drop down menu of a chat frame.",
	
	["MsgInitial"] = "Loading common settings for ChatFrame2.",

	-- missType
	missType = {
		resist = "resist",
		immune = "immune",
		block = "block",
		deflect = "deflect",
		dodge = "dodge",
		evade = "evade",
		absorb = "absorb",
		miss = "miss",
		parry = "parry",
		reflect = "reflect",
	},
	
	-- damageType
	damageType = {
		drown = "drown",
		fall = "fall",
		exhaust = "exhaust",
		fire = "fire",
		lava = "lava",
		slime = "slime",
	},	

}

loc.gui = {
	menuTitle = "SCL: ChatFrame%d Settings",
	colorSkill = "Color skills by element",
	colorEvent = "Color messages by event",
	greaterResize = "Greater resize",
	suppress = "Suppress combat log",
	clearSettings = "Clear all settings",
	
	tooltip_colorSkill = "The name of skills will be colored with element color settings.",
	tooltip_colorEvent = "The messages will be colored based on the events, which you can change with the Blizzard drop down chat options.\nThis is useful if you want to get extra information by the event names.\nFor example: different colors for 'Friendly Deaths' and 'Hostile Deaths'",
	tooltip_greaterResize = "Enables greater resize of this chat frame, so you can make a very large / small chatframe for displaying long / short messages.",
	tooltip_suppress = "Suppresses default Blizzard combat log.",
	tooltip_clearSettings = "Clear all settings of this chat frame EXCEPT 'Colors' and 'Formats', for these two, use the 'Restore to Default' option in their sub menu.",
	
}

loc.filter = {
	["Type Filters"] = "Type Filters",
	["Name Menu Title"] = "Name Filters for |cffeda55f%s|r",
	["Filters"] = "Filters",	
	
	["AllFilter"] = "*",	
	hit = "Hit",
	heal = "Heal",
	miss = "Miss",	
	cast = "Cast",
	gain = "Gain",
	drain = "Drain",
	leech = "Leech",
	dispel = "Dispel",
	buff = "Buff",
	debuff = "Debuff",
	fade = "Fade",
	interrupt = "Interrupt",
	death = "Death",
	environment = "Environment",
	extraattack = "Extra Attack",
	enchant = "Enchant",

	player = "Player",
	skill = "Skill",
	party = "Party",
	raid = "Raid",	
	pet = "Pet",
	target = "Target",
	targettarget = "Target of Target",
	other = 'Others',
	
	source = "Source",
	victim = "Victim",
	
	typeTooltip = {
		AllFilter = "Checking / unchecking these will apply to all the type filters.",
		hit = "Includs hits, crits and DoTs.",
		heal = "Includes heals, crit heals, and HoTs.",		
		miss = "Includes miss, dodge, block, deflect, immune, evade, parry, resist, reflect, absorb.",
		cast = "Includes 'begins to cast', 'casts' and 'performs'",
		gain = "Example: Cat gains 100 happiness from Rophy's Feed Pet Effect; Rophy gains 50 Mana from Rophy's Blessing of Wisdom.",
		drain = "Example: Rophy's Viper Sting drains 50 Mana from you.",
		leech = "Example: Your Dark Pact drains 100 Mana from Imp. You gain 100 Mana.",
		dispel = "Includes success and failed dispels",	
		buff = "Example: You gain Blessing of Wisdoms from Rophy.",
		debuff = "Example: You are afflicted by Corruption.",
		fade = "Buff or debuff fades.",
		interrupt = "Example: Rophy interrupts your Greater Heal.",
		death = "Note that destroying totems is also a death message.",
		environment = "Environment damage, including drown, fall, exhaust, fire, lava, slime.",
		extraattack = "Example: You gain 2 extra attacks through Wind Fury.",
		enchant = "Example: Rophy casts Rockbiter 7 on Rophy's Dagger.",
	},		
	
}

loc.event = {
	["Events"] = "Events",
	
	tooltip_Events = "Select what events for SCL to listen to. These are independent to the Blizzard chat frame event settings.",
}

loc.color = {

	physical = "Physical",		
	holy = "Holy",	
	fire = "Fire",		
	nature = "Nature",	
	frost = "Frost",	
	shadow = "Shadow",
	arcane = "Arcane",

	player = "Player",
	skill = "Skill",
	party = "Party",
	raid = "Raid",	
	pet = "Pet",
	target = "Target",
	targettarget = "Target of Target",
	other = 'Others',

	["Colors"] = "Colors",

	hit = "Hit",
	heal = "Heal",
	miss = "Miss",	
	buff = "Buff",
	debuff = "Debuff",
	
	["Restore default colors"] = "Restore default colors",	
}

loc.format = {
	["Formats"] = "Formats",
	["Restore default formats"] = "Restore default formats",
	
	-- The format group names.
	Combat = "Combat",
	Spell = "Spell",
	Misc = "Misc",
	Trailer = "Trailer",
	
}

loc.watch = {
	["Watches"] = "Watches",
	
	tooltip_Watches = "You can add custom keywords to the watch list, messages containing these keywords will be shown regardless of what the filter settings are.", 
	
	title = {
		source = "Source",
		victim = "Victim",
		skill = "Skill",
	},
	
	tooltip = {
		source = "Input a character name (case sensitive) to watch for. Messages with the name as 'source' will be shown.",
		victim = "Input a character name (case sensitive) to watch for. Messages with the name as 'victim' will be shown.",
		skill = "Input a skill name (case sensitive) to watch for. Messages with the skill will be shown.",
	},
	
	add = {
		source = "Add new source",
		victim = "Add new victim",
		skill = "Add new skilll",
	}
}

loc.theme = {
	["Load Theme"] = "Load Theme",	
	["Save Theme"] = "Save Theme",
	["Delete Theme"] = "Delete Theme",
	["Save As"] = "Save as...",
	["Delete Theme Failed"] = "You cannot delete theme [%s]: ChatFrame %s is using this theme.",
	
	tooltip_LoadTheme = "Load a theme to this chat frame. Themes are global to all characters.",
	tooltip_SaveTheme = "Save the settings of this chat frame to a theme. Themes are global to all characters.",
	tooltip_DeleteTheme = "Delete a theme. You can only delete a theme when no chat frame is using that theme. If you delete a predefined theme, they'll appear again in the next log in.",

}

-- The default formats for combat log.
-- Do NOT localize the field names, only change the format, 
--    if you want to change the sequence of tokens, use the %n$s, for example:
-- "%s hits %s for %d." --->   "%2$s lost %3$d health from the attack of %1$s."
loc.defaultFormats = {

	-- 1st group
	hit = { "[%s] %s [%s] %s%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	hitCrit = { "[%s] %s Crit [%s] *%s*%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	hitDOT = { "[%s] %s Dot [%s] ~%s~%s", { 'source', 'skill', 'victim', 'amount', 'trailers' } },
	heal = { "[%s] %s heal [%s] %s", { 'source', 'skill', 'victim', 'amount' } },
	healCrit = { "[%s] %s crit heal [%s] *%s*", { 'source', 'skill', 'victim', 'amount' } },
	healDOT = { "[%s] %s regen [%s] ~%s~", { 'source', 'skill', 'victim', 'amount' } },
	miss = { "[%s] %s %s [%s]", { 'source', 'skill', 'missType', 'victim' } },	
	gain = { "[%s] %s : [%s] + %s %s", { 'source', 'skill', 'victim', 'amount', 'attribute' } },
	drain = { "[%s] %s : [%s] -%s %s", { 'source', 'skill', 'victim', 'amount', 'attribute' } },
	leech = { "[%s] %s : [%s] -%s %s, [%s] +%s %s", { 'source', 'skill', 'victim', 'amount', 'attribute', 'sourceGained', 'amountGained', 'attributeGained' } },

	-- 2nd group
	buff = { '[%s] |cff00ff00++|r %s', { 'victim', 'skill' } },
	debuff = { '[%s] |cffff0000++|r %s', { 'victim', 'skill' } },	
	fade = { '[%s] -- %s', { 'victim', 'skill' } },		
	dispel = { '[%s] -- %s', { 'victim', 'skill' } },
	dispelFailed = { "[%s] dispel [%s] %s failed", { 'source', 'victim', 'skill' } },			
	extraattack = { "[%s] + %s attacks (%s)", { 'victim', 'amount', 'skill' } },	
	cast = { "[%s] %s", { 'source', 'skill' } },
	castBegin = { "[%s] begins %s", { 'source', 'skill' } },
	castTargeted = { "[%s] %s [%s]", { 'source', 'skill', 'victim' } },
	interrupt = { "[%s] interrupt [%s] %s", { 'source', 'victim', 'skill' } },	
	
	-- 3rd group
	environment = { "[%s] %s %s%s", { 'victim', 'damageType', 'amount', 'trailers' } },	
	create = { "[%s] create %s", { 'source', 'item' } },
	death = { "Death: [%s]", { 'victim' } },
	deathSkill = { "Death: [%s] by %s", { 'victim', 'skill' } },
	deathSource = { "[%s] killed [%s]", { 'source', 'victim' } },
	honor = { "Honor: %s", { 'amount' } },
	honorKill = { "Killed %s %s : %s honor", { 'sourceRank', 'source', 'amount' } },
	dishonor = { "|cffff0000Dishonor: %s", { 'source' } },
	experience = { "Exp: %s%s", { 'amount', 'trailers' } },
	reputation = { "Rep: %s +%s", { 'faction',  'amount' } },
	reputationRank = { "Rep: %s with %s", { 'rank', 'faction' } },
	reputationMinus = { "Rep: %s |cffff0000-%s", { 'faction', 'amount' } },
	enchant = { "Enchant: [%s] %s to [%s] %s", { 'source', 'skill', 'victim', 'item' } },
	feedpet = { "Pet of [%s] eats %s", { 'owner', 'food' } },
	fail = { "%s fail: %s", { 'skill', 'reason' } },
	durability = { "%s %s : %s's %s damaged", { 'source', 'skill', 'victim', 'item' } },
	
	-- Trailers don't need the field names, they are inputed manually.
	crushing =  { "(C)", {} },
	glancing =  { "(G)", {} },
	absorb =  { "(A%s)", { 'amountAbsorb' } },
	resist =  { "(R%s)", { 'amountResist' } },
	block =  { "(B%s)", { 'amountBlock' } },
	vulnerable =  { "(V%s)", { 'amountVulnerable' } },	
	expSource = { "(%s)", { 'source' } }, 
	expBonus = { "(%s%s)", { 'bonusType', 'bonusAmount' } },
	expGroup = { "(G+%s)", { 'amountGroupBonus' } },
	expRaid = { "(R-%s)", { 'amountRaidPenalty' } },
	
}

-- This enables partial localization: default english locale will be displayed if there is a missing locale for your language.
SimpleCombatLog:UpdateLocales(loc) 

-- nil out to save memory.
loc = nil 
