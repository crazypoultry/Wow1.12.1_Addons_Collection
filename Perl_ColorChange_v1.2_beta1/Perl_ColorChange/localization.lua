--if (GetLocale() == "enUS") then	-- Bypassing this allows us to at least give other languages English since they aren't fully translated
	PERL_CC_NAME											= "Perl_colorChange : " ;
	PERL_CC_SEPARATOR									= "--------------------------" ;
	PERL_CC_CHANGE_TARGET							= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "target change to : " ; 
	PERL_CC_CHANGE_TARGETCOLOR				= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "target color change to : "; 
	PERL_CC_CHANGE_DEBUFF							= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "debuff change to : " ;
	PERL_CC_CHANGE_DEBUFFCOLOR				= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "debuff color change to : " ;
	PERL_CC_IS_TARGET									= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "target is : " ; 
	PERL_CC_IS_TARGETCOLOR						= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "targetcolor is : "; 
	PERL_CC_IS_DEBUFF									= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "debuff is : " ;
	PERL_CC_IS_DEBUFFCOLOR						= PERL_CC_NAME .. Perl_ColorChange.COLORS.CYAN .. "debuffcolor is : " ;
	PERL_CC_COMMAND										= "Perl ColorChange : command error" ; 
	PERL_CC_COMMAND_TARGET						= "/perl_cc target [on|off]"; 
	PERL_CC_COMMAND_TARGET_DESC				= " > enable / disable colorChange on Target";
	PERL_CC_COMMAND_TARGETCOLOR				= "/perl_cc targetcolor [all|border|mix]";
	PERL_CC_COMMAND_TARGETCOLOR_DESC	= " > Change method of color of the target";
	PERL_CC_COMMAND_DEBUFF						= "/perl_cc debuff [on|off]";
	PERL_CC_COMMAND_DEBUFF_DESC				= " > enable / disable debuff on Player / Party / Pets";
	PERL_CC_COMMAND_DEBUFFCOLOR				= "/perl_cc debuffcolor [all|border|mix]";
	PERL_CC_COMMAND_DEBUFFCOLOR_DESC	= " > Change method of color of debuff on Player / Party / Pets";
	PERL_CC_COMMAND_STATUS						= "/perl_cc status";
	PERL_CC_COMMAND_STATUS_DESC				= " > Give the status of all options";
	
	PERL_LOCALIZED_CONFIG_COLORCHANGE = "ColorChange"
	PERL_LOCALIZED_CONFIG_COLOR_CHANGE_TARGET_ENABLE = "Target Colorisation"
	PERL_LOCALIZED_CONFIG_COLOR_CHANGE_MOD_ALL = "All (Border & Background)"
	PERL_LOCALIZED_CONFIG_COLOR_CHANGE_MOD_MIX = "Mix (Border & Portrait'Background)"
	PERL_LOCALIZED_CONFIG_COLOR_CHANGE_MOD_BORDER = "Border (Only Borders)"
		PERL_LOCALIZED_CONFIG_COLOR_CHANGE_DEBUFF_ENABLE = "Debuff Colorisation"
--end