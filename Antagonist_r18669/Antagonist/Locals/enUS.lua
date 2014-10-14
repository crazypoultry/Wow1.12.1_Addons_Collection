--[[ $Id: enUS.lua 15750 2006-11-02 12:41:33Z sole $ ]]--

local L = AceLibrary("AceLocale-2.2"):new("Antagonist")

L:RegisterTranslations("enUS", function()
    return {
		["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- (internal)
		
		["Antagonist"] = "Antagonist",
		["Casts"] =	"Casts",
		["Buffs"] =	"Buffs",
		["Cooldowns"] = "Cooldowns",
		
		-- Command line names
		["Group"] = "Group",
		["Bar"] = "Bar",
		["Title"] = "Title",
		
		-- Misc names
		["Test"] = "Test",
		["Lock"] = "Lock",
		["Stop"] = "Stop",
		["Config"] = "Config",
		["Kill"] = "Kill",
		["Fade"] = "Fade",
		["Death"] = "Death",
		["Self Relevant"] = "Self Relevenat",
		["Cooldown Limit"] = "Cooldown Limit",

		-- Group names
		["Target Only"] = "Target Only",
		["Enabled"] = "Enabled",
		["Show Under"] = "Show Under",
		["Pattern"] = "Pattern",

		-- Bar names
		["Bar Color"] = "Bar Color",
		["Bar Texture"] = "Bar Texture",
		["Bar Scale"] = "Bar Scale",
		["Bar Height"] = "Bar Height",
		["Bar Width"] = "Bar Width",
		["Text Size"] = "Text Size",
		["Reverse"] = "Reverse",
		["Grow Up"] = "Grow Up",
		["Anchor"] = "Anchor",

		-- Title names
		["Title Text"] = "Title Text",
		["Title Size"] = "Title Size",
		["Title Color"] = "Title Color",
			
		-- Command line descriptions
		["DescGroup"] = "The three spell type groups: casts, buffs, cooldowns.",
		["DescBar"] = "Bar appeareance settings.",
		["DescTitle"] = "Title appearance settings.",

		["DescCasts"] = "Casting times.",
		["DescBuffs"] = "Buff durations.",
		["DescCooldowns"] = "Cooldown times.",
			
		-- Group descs
		["DescTargetOnly"] = "Parse only your target's events.",
		["DescEnabled"] = "Whether this group is parsed.",
		["DescShowUnder"] = "Which anchor the group will appear under.",
		["DescPattern"] = "The pattern used for the text on the bar. Use $n, $s and $t to represent name, spell and target (casts only).",
		
		-- Bar descs
		["DescBarColor"] = "Set the bar color.",
		["DescBarTexture"] = "The texture of the timer bars.",
		["DescBarScale"] = "The scale of the timer bars.",
		["DescBarHeight"] = "The height of the timer bars.",
		["DescBarWidth"] = "The width of the timer bars.",
		["DescTextSize"] = "The text size on the timer bars.",
		["DescReverse"] = "Whether the bars fill or deplete.",
		["DescGrowup"] = "Whether the bars will grow up or down from the anchor.",
		
		-- Title descs
		["DescTitleNum"] = "Control settings for title ", -- do not remove the space
		["DescTitleText"] = "Set the title text.",
		["DescTitleSize"] = "The font size of the title.",
		["DescTitleColor"] = "Set the color of the title.",

		-- Misc descs
		["DescTest"] = "Runs test bars.",
		["DescLock"] = "Shows/hides the anchors.",
		["DescStop"] = "Stop all bars and hide all titles.",
		["DescConfig"] = "Open the configuration menu.",
		["DescGroup"] = "Group options.", 
		["DescKill"] = "Whether bars disappear when a hostile is killed.",
		["DescFade"] = "Whether bars disappear when a spell fades.",
		["DescDeath"] = "Whether bars dissapear when you die.",
		["DescSelfRelevant"] = "Only show cast bars which you are the target of.",
		["DescCDLimit"] = "Don't show cooldowns longer than this number.",

		-- Bar color names
		["school"] = "school",
		["class"] = "class",
		["group"] = "group",

		["TestBarText"] = "unit : spell",

		-- Spells not supported by BabbleSpell
		-- casts
		["Hearthstone"] = "Hearthstone",
		
		-- mob casts
		["Shrink"] = "Shrink",			
		["Banshee Curse"] = "Banshee Curse",			
		["Shadow Bolt Volley"] = "Shadow Bolt Volley",		
		["Cripple"] = "Cripple",			
		["Dark Mending"] = "Dark Mending",			
		["Spirit Decay"] = "Spirit Decay",
		["Gust of Wind"] = "Gust of Wind",			
		["Black Sludge"] = "Black Sludge",			
		["Toxic Bolt"] = "Toxic Bolt",			
		["Poisonous Spit"] = "Poisonous Spit",			
		["Wild Regeneration"] =	"Wild Regeneration",	
		["Curse of the Deadwood"] = "Curse of the Deadwood",		
		["Curse of Blood"] = "Curse of Blood",			
		["Dark Sludge"] = "Dark Sludge",			
		["Plague Cloud"] = "Plague Cloud",			
		["Wandering Plague"] = "Wandering Plague",		
		["Wither Touch"] = "Whither Touch",			
		["Fevered Fatigue"] = "Fevered Fatigue",		
		["Encasing Webs"] = "Encasing Webs",			
		["Crystal Gaze"] = "Crystal Gaze",			
		
		-- buffs
		["Brittle Armor"] = "Brittle Armor",
		["Unstable Power"] = "Unstable Power",
		["Restless Strength"] = "Restless Strength",
		["Ephemeral Power"] = "Ephemeral Power",
		["Massive Destruction"] = "Massive Destruction", 
		["Arcane Potency"] = "Arcane Potency",	
		["Energized Shield"] = "Energized Shield",
		["Brilliant Light"] = "Brilliant Light",
		["Mar'li's Brain Boost"] = "Mar'li's Brain Boost",
		["Earthstrike"] = "Earthstrike", 
		["Gift of Life"] = "Gift of Life", 
		["Nature Aligned"] = "Nature Aligned",
		["Quick Shots"] = "Quick Shots",

		["Fire Reflector"] = "Fire Reflector",
		["Shadow Reflector"] = "Shadow Reflector",
		["Frost Reflector"] = "Frost Reflector",
	}
end)
