local L = AceLibrary("AceLocale-2.0"):new("CooldownTimers")

L:RegisterTranslations("enUS", function()
    return {
    ["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"]				= "Ignore",
	["Background Alpha"] 	= "Background Alpha",
	["Bar Growth"] 			= "Bar Growth",
	["Bar Color"] 			= "Bar Color",
	["Background Color"] 	= "Background Color",
	["Text Color"] 			= "Text Color",
	["Bar Scale"] 			= "Bar Scale",
	["Show Anchor"] 		= "Show Anchor",
	["Test"] 				= "Test",
	["Bar Height"]			= "Bar Height",
	["Bar Width"]			= "Bar Width",
	["Min Time"]			= "Min Time",
	["Max Time"]			= "Max Time",
	["Alert Delay"]			= "Alert Delay",
	["Alert"]				= "Alert",
	["Alert Toggle"]		= "Alert Toggle",
	["Bar"]					= "Bar Settings",
	["Font Size"]			= "Font Size",
	["Alert Frame"]			= "Alert Frame",
	["Bar Texture"]			= "Bar Texture",
	
	["DescBarTexture"]		= "Which texture to use on the bars.",
	["DescAlertFrame"]		= "Where the alert messages are shown.",
	["DescFontSize"]		= "Change Font Size.",
	["DescBar"]				= "Settings for the cooldown bars.",
	["DescAlertToggle"]		= "Enable/Disable alerts",
	["DescAlert"]			= "Settings for alert frame.",
	["DescAlertDelay"]		= "How long an alert stays visible.",
	["DescIgnore"]			= "Add a spell to the ignore list.",
	["DescBGAlpha"] 		= "The transparency of a bar's background.",
	["DescBarGrowth"] 		= "The direction the bars will grow in.",
	["DescBarColor"] 		= "The color of the timer bars.",
	["DescBgColor"] 		= "The background color of the bars.",
	["DescTextColor"] 		= "The color of the text.",
	["DescBarScale"] 		= "The scale of the bars.",
	["DescShowAnchor"] 		= "Toggle the Anchor.",
	["DescTest"] 			= "Run a test bar under each anchor.",
	["DescBarHeight"]		= "The height of the bars.",
	["DescBarWidth"]		= "The width of the bars.",	
	["DescMinTime"]			= "Min time in seconds a cooldown has to be to show a bar.",
	["DescMaxTime"]			= "Max time in seconds a cooldown can be to show a bar.",	
	
	-- Map strings 
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frame
	["GUIAnchorString"] =  "Cooldown bars will appear here.", 
		
	["GUITestBarText"] = "Caster : Spell", -- test bars text 

    }
end)

L:RegisterTranslations("enGB", function()
    return {
    ["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"]				= "Ignore",
	["Background Alpha"] 	= "Background Alpha",
	["Bar Growth"] 			= "Bar Growth",
	["Bar Color"] 			= "Bar Color",
	["Background Color"] 	= "Background Color",
	["Text Color"] 			= "Text Color",
	["Bar Scale"] 			= "Bar Scale",
	["Show Anchor"] 		= "Show Anchor",
	["Test"] 				= "Test",
	["Bar Height"]			= "Bar Height",
	["Bar Width"]			= "Bar Width",
	["Min Time"]			= "Min Time",
	["Max Time"]			= "Max Time",
	["Alert Delay"]			= "Alert Delay",
	["Alert"]				= "Alert",
	["Alert Toggle"]		= "Alert Toggle",
	["Bar"]					= "Bar Settings",
	["Font Size"]			= "Font Size",
	["Alert Frame"]			= "Alert Frame",
	["Bar Texture"]			= "Bar Texture",
	
	["DescBarTexture"]		= "Which texture to use on the bars.",	
	["DescAlertFrame"]		= "Where the alert messages are shown.",
	["DescFontSize"]		= "Change Font Size.",
	["DescBar"]				= "Settings for the cooldown bars.",
	["DescAlertToggle"]		= "Enable/Disable alerts",
	["DescAlert"]			= "Settings for alert frame.",
	["DescAlertDelay"]		= "How long an alert stays visible.",
	["DescIgnore"]			= "Add a spell to the ignore list.",
	["DescBGAlpha"] 		= "The transparency of a bar's background.",
	["DescBarGrowth"] 		= "The direction the bars will grow in.",
	["DescBarColor"] 		= "The color of the timer bars.",
	["DescBgColor"] 		= "The background color of the bars.",
	["DescTextColor"] 		= "The color of the text.",
	["DescBarScale"] 		= "The scale of the bars.",
	["DescShowAnchor"] 		= "Toggle the Anchor.",
	["DescTest"] 			= "Run a test bar under each anchor.",
	["DescBarHeight"]		= "The height of the bars.",
	["DescBarWidth"]		= "The width of the bars.",	
	["DescMinTime"]			= "Min time in seconds a cooldown has to be to show a bar.",
	["DescMaxTime"]			= "Max time in seconds a cooldown can be to show a bar.",	

	-- Map strings 
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frames
	["GUIAnchorString"] =  "Cooldown bars will appear here.", 
		
	["GUITestBarText"] = "Caster : Spell", -- test bars text 

    }
end)

L:RegisterTranslations("deDE", function()
    return {
    ["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"]				= "Ignore",
	["Background Alpha"] 	= "Background Alpha",
	["Bar Growth"] 			= "Bar Growth",
	["Bar Color"] 			= "Bar Color",
	["Background Color"] 	= "Background Color",
	["Text Color"] 			= "Text Color",
	["Bar Scale"] 			= "Bar Scale",
	["Show Anchor"] 		= "Show Anchor",
	["Test"] 				= "Test",
	["Bar Height"]			= "Bar Height",
	["Bar Width"]			= "Bar Width",
	["Min Time"]			= "Min Time",
	["Max Time"]			= "Max Time",
	["Alert Delay"]			= "Alert Delay",
	["Alert"]				= "Alert",
	["Alert Toggle"]		= "Alert Toggle",
	["Bar"]					= "Bar Settings",
	["Font Size"]			= "Font Size",
	["Alert Frame"]			= "Alert Frame",
	["Bar Texture"]			= "Bar Texture",
	
	["DescBarTexture"]		= "Which texture to use on the bars.",
	["DescAlertFrame"]		= "Where the alert messages are shown.",
	["DescFontSize"]		= "Change Font Size.",
	["DescBar"]				= "Settings for the cooldown bars.",
	["DescAlertToggle"]		= "Enable/Disable alerts",
	["DescAlert"]			= "Settings for alert frame.",
	["DescAlertDelay"]		= "How long an alert stays visible.",
	["DescIgnore"]			= "Add a spell to the ignore list.",
	["DescBGAlpha"] 		= "The transparency of a bar's background.",
	["DescBarGrowth"] 		= "The direction the bars will grow in.",
	["DescBarColor"] 		= "The color of the timer bars.",
	["DescBgColor"] 		= "The background color of the bars.",
	["DescTextColor"] 		= "The color of the text.",
	["DescBarScale"] 		= "The scale of the bars.",
	["DescShowAnchor"] 		= "Toggle the Anchor.",
	["DescTest"] 			= "Run a test bar under each anchor.",
	["DescBarHeight"]		= "The height of the bars.",
	["DescBarWidth"]		= "The width of the bars.",	
	["DescMinTime"]			= "Min time in seconds a cooldown has to be to show a bar.",
	["DescMaxTime"]			= "Max time in seconds a cooldown can be to show a bar.",	

	-- Map strings 
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frames
	["GUIAnchorString"] =  "Cooldown bars will appear here.", 
		
	["GUITestBarText"] = "Caster : Spell", -- test bars text 
    }
end)

L:RegisterTranslations("frFR", function()
    return {
    ["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"]				= "Ignore",
	["Background Alpha"] 	= "Background Alpha",
	["Bar Growth"] 			= "Bar Growth",
	["Bar Color"] 			= "Bar Color",
	["Background Color"] 	= "Background Color",
	["Text Color"] 			= "Text Color",
	["Bar Scale"] 			= "Bar Scale",
	["Show Anchor"] 		= "Show Anchor",
	["Test"] 				= "Test",
	["Bar Height"]			= "Bar Height",
	["Bar Width"]			= "Bar Width",
	["Min Time"]			= "Min Time",
	["Max Time"]			= "Max Time",
	["Alert Delay"]			= "Alert Delay",
	["Alert"]				= "Alert",
	["Alert Toggle"]		= "Alert Toggle",
	["Bar"]					= "Bar Settings",
	["Font Size"]			= "Font Size",
	["Alert Frame"]			= "Alert Frame",
	["Bar Texture"]			= "Bar Texture",
	
	["DescBarTexture"]		= "Which texture to use on the bars.",
	["DescAlertFrame"]		= "Where the alert messages are shown.",
	["DescFontSize"]		= "Change Font Size.",
	["DescBar"]				= "Settings for the cooldown bars.",
	["DescAlertToggle"]		= "Enable/Disable alerts",
	["DescAlert"]			= "Settings for alert frame.",
	["DescAlertDelay"]		= "How long an alert stays visible.",
	["DescIgnore"]			= "Add a spell to the ignore list.",
	["DescBGAlpha"] 		= "The transparency of a bar's background.",
	["DescBarGrowth"] 		= "The direction the bars will grow in.",
	["DescBarColor"] 		= "The color of the timer bars.",
	["DescBgColor"] 		= "The background color of the bars.",
	["DescTextColor"] 		= "The color of the text.",
	["DescBarScale"] 		= "The scale of the bars.",
	["DescShowAnchor"] 		= "Toggle the Anchor.",
	["DescTest"] 			= "Run a test bar under each anchor.",
	["DescBarHeight"]		= "The height of the bars.",
	["DescBarWidth"]		= "The width of the bars.",	
	["DescMinTime"]			= "Min time in seconds a cooldown has to be to show a bar.",
	["DescMaxTime"]			= "Max time in seconds a cooldown can be to show a bar.",	

	-- Map strings 
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frames
	["GUIAnchorString"] =  "Cooldown bars will appear here.", 
		
	["GUITestBarText"] = "Caster : Spell", -- test bars text 
    }
end)

L:RegisterTranslations("zhCN", function()
    return {
    ["Fonts\\skurri.ttf"] 	= "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"] 				= "\229\191\189\231\149\165",
	["Background Alpha"] 	= "\232\131\140\230\153\175\233\128\143\230\152\142",
	["Bar Growth"]			= "\229\134\183\229\141\180\230\157\161\233\149\191\229\186\166",
	["Bar Color"] 			= "\229\134\183\229\141\180\230\157\161\233\162\156\232\137\178",
	["Background Color"] 	= "\232\131\140\230\153\175\233\162\156\232\137\178",
	["Text Color"] 			= "\230\150\135\229\173\151\233\162\156\232\137\178",
	["Bar Scale"]			= "\229\134\183\229\141\180\230\157\161\231\188\169\230\148\190",
	["Show Anchor"] 		= "\233\148\154\231\130\185\230\152\190\231\164\186",
	["Test"] 				= "Test",
	["Bar Height"] 			= "\229\134\183\229\141\180\230\157\161\233\171\152\229\186\166",
	["Bar Width"] 			= "\229\134\183\229\141\180\230\157\161\229\174\189\229\186\166",
	["Min Time"] 			= "\230\156\128\229\176\145\230\151\182\233\151\180",
	["Max Time"] 			= "\230\156\128\233\149\191\230\151\182\233\151\180",
	["Alert Delay"] 		= "\232\173\166\230\138\165\229\187\182\232\191\159",
	["Alert"] 				= "\232\173\166\230\138\165",	
	["Alert Toggle"]		= "\232\173\166\230\138\165\229\188\128\229\133\179",
	["Bar"]					= "\232\174\190\231\189\174\229\134\183\229\141\180\230\157\161",
	["Font Size"]			= "\229\173\151\228\189\147\229\176\186\229\175\184",
	["Alert Frame"]			= "\232\173\166\230\138\165\230\161\134\230\158\182",
	["Bar Texture"]			= "\229\134\183\229\141\180\230\157\161\230\157\144\232\180\168",
	
	["DescBarTexture"]		= "\229\134\183\229\141\180\230\157\161\228\189\191\231\148\168\229\147\170\231\167\141\230\157\144\232\180\168.",
	["DescAlertFrame"]		= "\229\156\168\233\130\163\230\152\190\231\164\186\232\173\166\230\138\165\228\191\161\230\129\175.",
	["DescFontSize"]		= "\230\155\180\230\148\185\229\173\151\228\189\147\229\176\186\229\175\184.",
	["DescBar"]				= "\229\134\183\229\141\180\230\157\161\232\174\190\231\189\174.",
	["DescAlertToggle"]		= "\229\188\128\229\144\175/\229\133\179\233\151\173\232\173\166\230\138\165",
	["DescAlert"]			= "\232\174\190\231\189\174\232\173\166\230\138\165\230\161\134\230\158\182.",
	["DescAlertDelay"] 		= "\229\164\154\233\149\191\230\151\182\233\151\180\229\129\156\230\173\162\230\152\190\231\164\186\232\173\166\230\138\165.",
	["DescIgnore"] 			= "\230\183\187\229\138\160\230\138\128\232\131\189\229\136\176\229\191\189\231\149\165\229\136\151\232\161\168",
	["DescBGAlpha"] 		= "\229\134\183\229\141\180\230\157\161\232\131\140\230\153\175\233\128\143\230\152\142.",
	["DescBarGrowth"] 		= "\229\134\183\229\141\180\230\157\161\229\162\158\233\149\191\230\150\185\229\144\145.",
	["DescBarColor"] 		= "\232\174\161\230\151\182\229\153\168\233\162\156\232\137\178.",
	["DescBgColor"] 		= "\229\134\183\229\141\180\230\157\161\232\131\140\230\153\175\233\162\156\232\137\178.",
	["DescTextColor"] 		= "\230\150\135\229\173\151\233\162\156\232\137\178.",
	["DescBarScale"] 		= "\229\134\183\229\141\180\230\157\161\231\188\169\230\148\190.",
	["DescShowAnchor"] 		= "\229\136\135\230\141\162\233\148\154\231\130\185\230\152\190\231\164\186.",
	["DescTest"] 			= "\229\156\168\229\144\132\232\135\170\233\148\154\231\130\185\228\184\138\232\191\144\232\161\140\230\181\139\232\175\149\229\134\183\229\141\180\230\157\161.",
	["DescBarHeight"] 		= "\229\134\183\229\141\180\230\157\161\233\171\152\229\186\166.",
	["DescBarWidth"] 		= "\229\134\183\229\141\180\230\157\161\229\174\189\229\186\166.", 
	["DescMinTime"] 		= "\230\156\128\231\159\173\230\143\144\231\164\186\230\151\182\233\151\180.",
	["DescMaxTime"] 		= "\230\156\128\233\149\191\230\143\144\231\164\186\230\151\182\233\151\180.", 
	
	-- Map strings 
	-- Bar growth map strings
	["MapBarGrowthFalse"] 	= "|cffff5050Down|r",
	["MapBarGrowthTrue"] 	= "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frames
	["GUIAnchorString"] 	= "\229\134\183\229\141\180\230\157\161\229\176\134\230\152\190\231\164\186\232\191\153\233\135\140.", 
	
	["GUITestBarText"] 		= "Caster : Spell", -- test bars text
    }
end)

L:RegisterTranslations("koKR", function()
    return {
    ["Fonts\\skurri.ttf"] = "Fonts\\skurri.ttf", -- for locales which dont support this font (internal)
	
	-- Names (command and gui)
	["Ignore"]				= "Ignore",
	["Background Alpha"] 	= "Background Alpha",
	["Bar Growth"] 			= "Bar Growth",
	["Bar Color"] 			= "Bar Color",
	["Background Color"] 	= "Background Color",
	["Text Color"] 			= "Text Color",
	["Bar Scale"] 			= "Bar Scale",
	["Show Anchor"] 		= "Show Anchor",
	["Test"] 				= "Test",
	["Bar Height"]			= "Bar Height",
	["Bar Width"]			= "Bar Width",
	["Min Time"]			= "Min Time",
	["Max Time"]			= "Max Time",
	["Alert Delay"]			= "Alert Delay",
	["Alert"]				= "Alert",
	["Alert Toggle"]		= "Alert Toggle",
	["Bar"]					= "Bar Settings",
	["Font Size"]			= "Font Size",
	["Alert Frame"]			= "Alert Frame",
	["Bar Texture"]			= "Bar Texture",
	
	["DescBarTexture"]		= "Which texture to use on the bars.",
	["DescAlertFrame"]		= "Where the alert messages are shown.",
	["DescFontSize"]		= "Change Font Size.",
	["DescBar"]				= "Settings for the cooldown bars.",
	["DescAlertToggle"]		= "Enable/Disable alerts",
	["DescAlert"]			= "Settings for alert frame.",
	["DescAlertDelay"]		= "How long an alert stays visible.",
	["DescIgnore"]			= "Add a spell to the ignore list.",
	["DescBGAlpha"] 		= "The transparency of a bar's background.",
	["DescBarGrowth"] 		= "The direction the bars will grow in.",
	["DescBarColor"] 		= "The color of the timer bars.",
	["DescBgColor"] 		= "The background color of the bars.",
	["DescTextColor"] 		= "The color of the text.",
	["DescBarScale"] 		= "The scale of the bars.",
	["DescShowAnchor"] 		= "Toggle the Anchor.",
	["DescTest"] 			= "Run a test bar under each anchor.",
	["DescBarHeight"]		= "The height of the bars.",
	["DescBarWidth"]		= "The width of the bars.",	
	["DescMinTime"]			= "Min time in seconds a cooldown has to be to show a bar.",
	["DescMaxTime"]			= "Max time in seconds a cooldown can be to show a bar.",	

	-- Map strings 
		-- Bar growth map strings
		["MapBarGrowthFalse"] = "|cffff5050Down|r",
		["MapBarGrowthTrue"] =  "|cff00ff00Up|r",
	
	-- GUI strings
	-- Anchor frames
	["GUIAnchorString"] =  "Cooldown bars will appear here.", 
		
	["GUITestBarText"] = "Caster : Spell", -- test bars text 
    }
end)