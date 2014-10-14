-- binding labels
BINDING_HEADER_SKILLSPLUSHEADER = 'SkillsPlusFu'
BINDING_NAME_SKILLSPLUSNAME     = 'Use the selected skill.'

-- constants
COOLDOWN_TIMER_FREQUENCY =  30     -- metrognome update interval
COOLDOWN_NOTIFYTIME      = 300     -- warning when ready in less than five minutes
 
local AceLocale = AceLibrary("AceLocale-2.1")

AceLocale:RegisterTranslation("SkillsPlusFu", "enUS", function() 
    return {
        -- general labels
        ["NAME"] = 'FuBar - SkillsPlusFu',
        ["DESCRIPTION"] = 'Show and access skills, also shows cooldowns.',
        ["COMMANDS"] = {'/spf', '/skillsplusfu'},
        ["CMD_OPTIONS"] = {},

        ["SP_FACTION"] = 'Faction',
        ["SP_FACTION_ALLIANCE"] = 'Alliance',
        ["SP_FACTION_HORDE"] = 'Horde',
        
        ["TOOLTIP_HINT"] = 'Click to access the named skill.\nRight-click to select a skill.',

        ["FUBAR_LABEL"] = 'Skills',
        
        -- menu labels
        ["MENU_SHOW_BOOLEAN_SKILLS"] = 'Show boolean skills',
        ["MENU_SHOW_OTHER_TOON_SKILLS"] = 'Show other player skills',
        ["MENU_SHOW_SKILL_LABEL"] = 'Show skill label',
        ["MENU_SHOW_CROSS_FACTION_SKILLS"] = 'Show cross faction skills',
        ["MENU_SHOW_TOON_NAMES"] = 'Show player names',
        ["MENU_SHOW_NOTIFICATION"]  = 'Show cooldown notification',
        ["MENU_CLEAR_COOLDOWN_DATA"] = 'Clear current cooldown data',

        -- cooldown labels
        ["COOLDOWN_COLOR_READY"] = '|cff00FF00',
        ["COOLDOWN_COLOR_NOTREADY"] = '|cffFF0000',
        ["COOLDOWN_COLOR_ALMOSTREADY"] = '|cffF0F000',

        ["COOLDOWN_FORMAT"] = ' (%d/%d)',
        ["COOLDOWN_IS_READY"] = '|cff00FF00Cooldown:|r %s for %s: %s is ready.',
        ["COOLDOWN_WILL_BE_READY"] = '|cff00FF00Cooldown:|r %s for %s: %s will be ready in less than five minutes.',

        ["COOLDOWN_CATEGORY"] = 'Cooldown',
        ["COOLDOWN_READY"] = 'Ready!',

        ["COOLDOWN_ELUNES_LANTERN"] = 'Elune\'s Lantern',
        ["COOLDOWN_ELUNE_STONE"] = 'Elune Stone',
        ["COOLDOWN_MOONCLOTH"] = 'Mooncloth',
        ["COOLDOWN_REFINED_SALT"] = 'Refined Deeprock Salt',
        ["COOLDOWN_SALT_SHAKER"] = 'Salt Shaker',
        ["COOLDOWN_SNOWMASTER"] = 'SnowMaster 9000',
        ["COOLDOWN_SNOWBALL"] = 'Snowball',
        ["COOLDOWN_TRANSMUTE_MATCH"] = 'Transmute',
        ["COOLDOWN_TRANSMUTES"] = 'Transmutes',
        ["COOLDOWN_CREATE_ITEM"] = 'You create',
     }

end)


