--[[
--------------------------------------------------
	File: localization.en.lua
	Addon: Archaeologist
	Language: English
	Translation by: AnduinLothar
	Last Update: 4/5/2006
--------------------------------------------------
]]--

Localization.RegisterAddonStrings("enUS", "Archaeologist", {
	
	PLAYER_GHOST 						= "Ghost";
	PLAYER_WISP 						= "Wisp";
	PLAYER_DEAD							= "Dead";
	FEIGN_DEATH							= "Feign Death";
	XP 									= "XP";
	HEALTH								= "Health";
	UNKNOWN								= "Unknown";
	
	ARCHAEOLOGIST_CONFIG_SEP				= "Archaeologist";
	ARCHAEOLOGIST_CONFIG_SEP_INFO			= "Archaeologist Settings";
	
	ARCHAEOLOGIST_FEEDBACK_STRING	= "%s changed to %s.";
	ARCHAEOLOGIST_NOT_A_VALID_FONT	= "%s is not a valid font.";
	
	Default				= "Default";
	GameFontNormal		= "GameFontNormal";
	NumberFontNormal	= "NumberFontNormal";
	ItemTextFontNormal	= "ItemTextFontNormal";
	
	ARCHAEOLOGIST_ON = "On";
	ARCHAEOLOGIST_OFF = "Off";
	ARCHAEOLOGIST_MOUSEOVER = "Mouseover";
	
	ARCHAEOLOGIST_FEEDBACK_STRING = "%s is currently set to %s.";
	
	-- <= == == == == == == == == == == == == =>
	-- => Presets
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_PRESETS = "Presets";
	ARCHAEOLOGIST_CONFIG_SET = "Set";
	
	ARCHAEOLOGIST_CONFIG_VALUES_ON_BARS				= "Values on the Bars";
	ARCHAEOLOGIST_CONFIG_VALUES_NEXTTO_BARS			= "Values next to the Bars";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_BARS			= "Percentage on the Bars";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_NEXTTO_BARS		= "Percentage next to the Bars";
	ARCHAEOLOGIST_CONFIG_PERCENTAGE_ON_VALUES_NEXTTO_BARS		= "Percentage on, Values next to the Bars";
	ARCHAEOLOGIST_CONFIG_VALUES_ON_PERCENTAGE_NEXTTO_BARS		= "Values on, Percentage next to the Bars";
	
	ARCHAEOLOGIST_CONFIG_PREFIXES_OFF				= "All Prefixes Off";
	ARCHAEOLOGIST_CONFIG_PREFIXES_ON				= "All Prefixes On";
	ARCHAEOLOGIST_CONFIG_PREFIXES_DEFAULT			= "All Prefixes Default";
	
	-- <= == == == == == == == == == == == == =>
	-- => Main/Player/Party/Pet/Target Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_MAIN_SEP				= "Experience & Reputation Bars";
	ARCHAEOLOGIST_CONFIG_PLAYER_SEP				= "Player Status Bars";
	ARCHAEOLOGIST_CONFIG_PARTY_SEP				= "Party Status Bars";
	ARCHAEOLOGIST_CONFIG_PET_SEP				= "Pet Status Bars";
	ARCHAEOLOGIST_CONFIG_TARGET_SEP				= "Target Status Bars";
	ARCHAEOLOGIST_CONFIG_UNIT_SEP_INFO		= "Most values, by default, can be seen on mouseover.";
	
			
	ARCHAEOLOGIST_CONFIG_HP		= "Primary Health Display";
	ARCHAEOLOGIST_CONFIG_HP_INFO = "Shows health text over the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_HP2		= "Secondary Health Display";
	ARCHAEOLOGIST_CONFIG_HP2_INFO = "Shows player health text next to the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_MP		= "Primary Mana Display";
	ARCHAEOLOGIST_CONFIG_MP_INFO = "Shows mana text over the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_MP2		= "Secondary Mana Display";
	ARCHAEOLOGIST_CONFIG_MP2_INFO = "Shows mana text next to the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_HPNOMAX		= "Hide Max HP Value";
	ARCHAEOLOGIST_CONFIG_HPNOMAX_INFO = "Hides max health on the value display.";
	ARCHAEOLOGIST_CONFIG_MPNOMAX		= "Hide Max MP Value";
	ARCHAEOLOGIST_CONFIG_MPNOMAX_INFO = "Hides max mana on the value display.";
	ARCHAEOLOGIST_CONFIG_HPVINVERT			= "Show Health Value Missing";
	ARCHAEOLOGIST_CONFIG_HPVINVERT_INFO	= "Invert the health value display.";
	ARCHAEOLOGIST_CONFIG_HPPINVERT			= "Show Health Percent Missing";
	ARCHAEOLOGIST_CONFIG_HPPINVERT_INFO	= "Invert the health percent display.";
	ARCHAEOLOGIST_CONFIG_MPVINVERT			= "Show Mana Value Missing";
	ARCHAEOLOGIST_CONFIG_MPVINVERT_INFO	= "Invert the mana value display.";
	ARCHAEOLOGIST_CONFIG_MPPINVERT			= "Show Mana Percent Missing";
	ARCHAEOLOGIST_CONFIG_MPPINVERT_INFO	= "Invert the mana percent display.";
	ARCHAEOLOGIST_CONFIG_HPNOPREFIX		= "Hide Health Prefix";
	ARCHAEOLOGIST_CONFIG_HPNOPREFIX_INFO	= "Hides the 'Health' prefix on the health bar.";
	ARCHAEOLOGIST_CONFIG_MPNOPREFIX		= "Hide Mana Prefix";
	ARCHAEOLOGIST_CONFIG_MPNOPREFIX_INFO	= "Hides the 'Mana/Rage/Power' prefix on the mana bar.";
	ARCHAEOLOGIST_CONFIG_CLASSICON		= "Show Class Icon";
	ARCHAEOLOGIST_CONFIG_CLASSICON_INFO	= "Shows the class icon on the unit frame.";
	ARCHAEOLOGIST_CONFIG_HPSWAP			= "Swap Health Percent and Value";
	ARCHAEOLOGIST_CONFIG_HPSWAP_INFO		= "Swaps Primary and Secondary Health Displays";
	ARCHAEOLOGIST_CONFIG_MPSWAP			= "Swap Mana Percent and Value";
	ARCHAEOLOGIST_CONFIG_MPSWAP_INFO		= "Swaps Primary and Secondary Mana Displays";
	
	ARCHAEOLOGIST_CONFIG_XP		= "Experience Display";
	ARCHAEOLOGIST_CONFIG_XP_INFO = "Shows experience text on the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_REP		= "Reputation Display";
	ARCHAEOLOGIST_CONFIG_REP_INFO = "Shows reputation text on the bar. (Options: On, Off, Mouseover)";
	ARCHAEOLOGIST_CONFIG_XPNOMAX		= "Hide Max XP Value";
	ARCHAEOLOGIST_CONFIG_XPNOMAX_INFO = "Hides max experience on the value display.";
	ARCHAEOLOGIST_CONFIG_REPNOMAX		= "Hide Max Rep Value";
	ARCHAEOLOGIST_CONFIG_REPNOMAX_INFO = "Hides max reputation on the value display.";
	ARCHAEOLOGIST_CONFIG_XPP			= "Show Percentage on the XP bar";
	ARCHAEOLOGIST_CONFIG_XPP_INFO	= "Show Percentage on the XP bar";
	ARCHAEOLOGIST_CONFIG_REPP			= "Show Percentage on the Rep bar";
	ARCHAEOLOGIST_CONFIG_REPP_INFO	= "Show Percentage on the Rep bar";
	ARCHAEOLOGIST_CONFIG_XPV			= "Show Exact Value on the XP bar";
	ARCHAEOLOGIST_CONFIG_XPV_INFO	= "Show Exact Value on the XP bar";
	ARCHAEOLOGIST_CONFIG_REPV			= "Show Exact Value on the Rep bar";
	ARCHAEOLOGIST_CONFIG_REPV_INFO	= "Show Exact Value on the Rep bar";
	ARCHAEOLOGIST_CONFIG_XPPINVERT			= "Show XP Percent Left to Level";
	ARCHAEOLOGIST_CONFIG_XPPINVERT_INFO	= "Invert the XP percent display";
	ARCHAEOLOGIST_CONFIG_REPPINVERT			= "Show Rep Percent Left to Level";
	ARCHAEOLOGIST_CONFIG_REPPINVERT_INFO	= "Invert the Rep percent display";
	ARCHAEOLOGIST_CONFIG_XPVINVERT			= "Show XP Value Left to Level";
	ARCHAEOLOGIST_CONFIG_XPVINVERT_INFO	= "Invert the XP value display";
	ARCHAEOLOGIST_CONFIG_REPVINVERT			= "Show Rep Value Left to Level";
	ARCHAEOLOGIST_CONFIG_REPVINVERT_INFO	= "Invert the Rep value display";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX		= "Hide XP Prefix";
	ARCHAEOLOGIST_CONFIG_XPNOPREFIX_INFO	= "Hides the 'XP' prefix on the xp bar.";
	ARCHAEOLOGIST_CONFIG_REPNOPREFIX		= "Hide Rep Faction Prefix";
	ARCHAEOLOGIST_CONFIG_REPNOPREFIX_INFO	= "Hides the faction prefix on the rep bar.";
	
	-- <= == == == == == == == == == == == == =>
	-- => Alternate Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP			= "Alternate Options";
	ARCHAEOLOGIST_CONFIG_ALTOPTS_SEP_INFO		= "Alternate Options";
	
	ARCHAEOLOGIST_CONFIG_HPCOLOR			= "Turn On Health Bar Color Change";
	ARCHAEOLOGIST_CONFIG_HPCOLOR_INFO		= "Healthbar changes color as it decreases.";
	
	ARCHAEOLOGIST_CONFIG_DEBUFFALT			= "Alternate Pet/Party Debuff Location";
	ARCHAEOLOGIST_CONFIG_DEBUFFALT_INFO		= "Moves Pet and Party Debuffs to below the Buffs.\nDefault: show to the right of the unit frame.";
	
	ARCHAEOLOGIST_CONFIG_TBUFFALT			= "Do not wrap target buffs/debuffs";
	ARCHAEOLOGIST_CONFIG_TBUFFALT_INFO		= "Show two rows under the target: 16 buffs and 16 debuffs.";
	
	ARCHAEOLOGIST_CONFIG_THPALT				= "Hide Target HP Value Display When Unavailible";
	ARCHAEOLOGIST_CONFIG_THPALT_INFO		= "Hides the target value display when real values are unavailible, default converts to percent.";
	
	ARCHAEOLOGIST_CONFIG_MOBHEALTH			= "Use MobHealth2 for Target HP";
	ARCHAEOLOGIST_CONFIG_MOBHEALTH_INFO		= "Hides the regular MobHealth2 text and uses it in place of the HP text on the Target Frame.";
	
	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT		= "Class Portrait";
	ARCHAEOLOGIST_CONFIG_CLASSPORTRAIT_INFO = "Replace unit portraits with class icons when applicable.";
	
	-- <= == == == == == == == == == == == == =>
	-- => Font Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP			= "Font Options";
	ARCHAEOLOGIST_CONFIG_FONTOPTS_SEP_INFO		= "Font Options";
	
	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE		= "Set Player/Target Text Size.";
	ARCHAEOLOGIST_CONFIG_HPMPLARGESIZE_SLIDER_TEXT   = "Font Size";
	
	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT		= "Set Player/Target Text Font.";
	ARCHAEOLOGIST_CONFIG_HPMPLARGEFONT_INFO = "Set Player/Target Text Font.";
	
	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE		= "Set Pet/Party Text Size";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLSIZE_SLIDER_TEXT   = "Font Size";
	
	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT		= "Set Pet/Party Text Font";
	ARCHAEOLOGIST_CONFIG_HPMPSMALLFONT_INFO = "Set Pet/Party Text Font";
	
	ARCHAEOLOGIST_COLOR_CHANGED				= "|c%s%s color changed.|r";
	ARCHAEOLOGIST_COLOR_RESET				= "|c%s%s color reset.|r";
	
	ARCHAEOLOGIST_CONFIG_COLORPHP			= "Primary Health Color (Default is white):";
	ARCHAEOLOGIST_CONFIG_COLORPHP_INFO		= "Changes the color of the primary health text.";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET			= "Reset the Primary Health Color";
	ARCHAEOLOGIST_CONFIG_COLORPHP_RESET_INFO	= "Resets the color of the primary health text to white.";
	
	ARCHAEOLOGIST_CONFIG_COLORPMP			= "Primary Mana Color (Default is white):";
	ARCHAEOLOGIST_CONFIG_COLORPMP_INFO		= "Changes the color of the primary mana text.";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET			= "Reset the Primary Mana Color";
	ARCHAEOLOGIST_CONFIG_COLORPMP_RESET_INFO	= "Resets the color of the primary mana text to white.";
	
	ARCHAEOLOGIST_CONFIG_COLORSHP			= "Secondary Health Color (Default is white):";
	ARCHAEOLOGIST_CONFIG_COLORSHP_INFO		= "Changes the color of the secondary health text.";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET			= "Reset the Secondary Health Color";
	ARCHAEOLOGIST_CONFIG_COLORSHP_RESET_INFO	= "Resets the color of the secondary health text to white.";
	
	ARCHAEOLOGIST_CONFIG_COLORSMP			= "Secondary Mana Color (Default is white):";
	ARCHAEOLOGIST_CONFIG_COLORSMP_INFO		= "Changes the color of the secondary mana text.";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET			= "Reset the Secondary Mana Color";
	ARCHAEOLOGIST_CONFIG_COLORSMP_RESET_INFO	= "Resets the color of the secondary mana text to white.";
	
	
	-- <= == == == == == == == == == == == == =>
	-- => Party Buff Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP			= "Party Buff Settings";
	ARCHAEOLOGIST_CONFIG_PARTYBUFFS_SEP_INFO	= "By default 16 buffs and 16 debuffs are visible.";
	
	ARCHAEOLOGIST_CONFIG_PBUFFS					= "Hide the party buffs ";
	ARCHAEOLOGIST_CONFIG_PBUFFS_INFO			= "Removes the party's spell buffs from view unless you mouse-over their portrait.";
	
	ARCHAEOLOGIST_CONFIG_PBUFFNUM				= "Number of party buffs ";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_INFO			= "Set the number of party buffs to show.";
	ARCHAEOLOGIST_CONFIG_PBUFFNUM_SLIDER_TEXT  = "Buffs Visible";
	
	ARCHAEOLOGIST_CONFIG_PDEBUFFS				= "Hide the party debuffs ";
	ARCHAEOLOGIST_CONFIG_PDEBUFFS_INFO			= "Removes the party's spell debuffs from view.";
	
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM				= "Number of party debuffs ";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_INFO		= "Set the number of party debuffs to show.";
	ARCHAEOLOGIST_CONFIG_PDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";
	
	-- <= == == == == == == == == == == == == =>
	-- => Party Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP			= "Party Pet Buff Settings";
	ARCHAEOLOGIST_CONFIG_PARTYPETBUFFS_SEP_INFO		= "By default 16 buffs and 16 debuffs are visible.";
	
	ARCHAEOLOGIST_CONFIG_PPTBUFFS					= "Hide the party pet buffs ";
	ARCHAEOLOGIST_CONFIG_PPTBUFFS_INFO				= "Removes the party pet's spell buffs from view unless you mouse-over their portrait.";
	
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM					= "Number of party pet buffs ";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_INFO			= "Set the number of party pet buffs to show.";
	ARCHAEOLOGIST_CONFIG_PPTBUFFNUM_SLIDER_TEXT 	= "Buffs Visible";
	
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS					= "Hide the party pet debuffs ";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFS_INFO			= "Removes the party pet's spell debuffs from view.";
	
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM				= "Number of party pet debuffs ";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_INFO			= "Set the number of party pet debuffs to show.";
	ARCHAEOLOGIST_CONFIG_PPTDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";
	
	-- <= == == == == == == == == == == == == =>
	-- => Pet Buff Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP				= "Pet Buff Settings";
	ARCHAEOLOGIST_CONFIG_PETBUFFS_SEP_INFO			= "By default 16 buffs and 4 debuffs are visible.";
	
	ARCHAEOLOGIST_CONFIG_PTBUFFS					= "Hide the pet buffs ";
	ARCHAEOLOGIST_CONFIG_PTBUFFS_INFO				= "Removes the pet's spell buffs from view unless you mouse-over their portrait.";
	
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM					= "Number of pet buffs ";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_INFO				= "Set the number of pet buffs to show.";
	ARCHAEOLOGIST_CONFIG_PTBUFFNUM_SLIDER_TEXT  	= "Buffs Visible";
	
	ARCHAEOLOGIST_CONFIG_PTDEBUFFS					= "Hide the pet debuffs ";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFS_INFO				= "Removes the pet's spell debuffs from view.";
	
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM				= "Number of pet debuffs ";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_INFO			= "Set the number of pet debuffs to show.";
	ARCHAEOLOGIST_CONFIG_PTDEBUFFNUM_SLIDER_TEXT	= "Debuffs Visible";
	
	-- <= == == == == == == == == == == == == =>
	-- => Target Buff Options
	-- <= == == == == == == == == == == == == =>
	
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP		= "Target Buff Settings";
	ARCHAEOLOGIST_CONFIG_TARGETBUFFS_SEP_INFO   = "By default 8 buffs and 16 debuffs are visible.";
	
	ARCHAEOLOGIST_CONFIG_TBUFFS					= "Hide the target buffs ";
	ARCHAEOLOGIST_CONFIG_TBUFFS_INFO			= "Removes the target's spell buffs from view.";
	
	ARCHAEOLOGIST_CONFIG_TBUFFNUM				= "Number of target buffs ";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_INFO			= "Set the number of target buffs to show.";
	ARCHAEOLOGIST_CONFIG_TBUFFNUM_SLIDER_TEXT   = "Buffs Visible";
	
	ARCHAEOLOGIST_CONFIG_TDEBUFFS				= "Hide the target debuffs ";
	ARCHAEOLOGIST_CONFIG_TDEBUFFS_INFO			= "Removes the target's spell debuffs from view.";
	
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM				= "Number of target debuffs ";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_INFO		= "Set the number of target debuffs to show.";
	ARCHAEOLOGIST_CONFIG_TDEBUFFNUM_SLIDER_TEXT = "Debuffs Visible";

})
