if (not ace:LoadTranslation("FuBar_Aspect")) then

	FuBar_AspectLocals = {
		NAME = "FuBar - Aspect",
		DESCRIPTION = "Toggle Hunter Aspects with FuBar.",
		COMMANDS = {"/fbaspect", "/fubar_aspect"},
		CMD_OPTIONS = {},
		TOOLTIP_TITLE = "|cffffffffAspect",
		
		ASPECT_TOOLTIP_HINT_TEXT = "Right-click to change Aspects.",
			
		ASPECT_TEXT_HAWK   = "Aspect of the Hawk",
		ASPECT_TEXT_CHEETAH = "Aspect of the Cheetah",
		ASPECT_TEXT_MONKEY = "Aspect of the Monkey",
		ASPECT_TEXT_PACK   = "Aspect of the Pack",
		ASPECT_TEXT_BEAST  = "Aspect of the Beast",
		ASPECT_TEXT_WILD   = "Aspect of the Wild",
			
		ASPECT_SET_ASPECT_TEXT = "Set Aspect",
		ASPECT_NO_ASPECTS_FOUND = "No Aspects Found",
	}
	
end