
--[[---------------------------------------------------------------------------

	Please do not modify this file directly if you wish to customize
	the theme. Instead, make a copy of the file and add it into	layouts.xml
	
	This way your customized theme will not get overwritten everytime you
	update the addon.
	
	See Elegant.lua for more information !

---------------------------------------------------------------------------]]--

SA_IMAGE_PATH = "Interface\\AddOns\\SmartAssist\\images\\"
SA_PR_EDGE = 2

SA_THEME.PerfectRaid = {
	
	-- defines background and borders	
	backdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tileSize = SA_PR_EDGE,
		edgeSize = SA_PR_EDGE,
		insets = {
			left = SA_PR_EDGE,
			right = SA_PR_EDGE,
			top = SA_PR_EDGE,
			bottom = SA_PR_EDGE
		}
	},
	
	frame = {
		height = 12+2*SA_PR_EDGE
	},

	-- statusbars
	mobBar = {
		height = 12,
		texture = SA_IMAGE_PATH.."BantoBar.tga",
		relativeWidth = -120-SA_PR_EDGE,
		x = 120,
		y = -SA_PR_EDGE,
		background = {
			coverage = 1,
			texture = SA_IMAGE_PATH.."Smooth.tga",
			color = {r=0.2, g=0.2, b=0.2, alpha=1},
		},
		spark = {
			alpha = 0.8
		}
	},
	targetBar = {
		hide = true
	},
	
	-- fontstrings
	
	targetOf = {
		hide = true,
	},
	
	colors = {
		-- default state, must include all elements (in other words, do not remove them) !
		normal = {
			background = {r=0, g=0, b=0, alpha=0.8},
			border = {r=0, g=0, b=0, alpha=0.8},
			mobBar = {r=0, g=1, b=0},
			targetBar = {r=0, g=1, b=0}
		},
		-- states that modify colors from default, each can override any choosen number of colors
		marked = {
			border = {r=1, g=0, b=0, alpha=1}
		},
		markedOOC = {
			border = {r=1, g=0, b=0, alpha=0.5}
		},
		myTarget = {
			background = {r=0, g=0.75, b=0, alpha=0.8},
			border = {r=0, g=0.75, b=0.75, alpha=0.8}
		},
		myTargetOOC = {
			background = {r=0, g=0.5, b=0, alpha=0.8},
			border = {r=0, g=0.5, b=0, alpha=0.8}
		},
		ooc = {
			mobBar = {r=0.38, g=0.38, b=0.38},
			targetBar = {r=0.38, g=0.38, b=0.38}
		},
		pullerTarget = {
			background = {r=1, g=1, b=0, alpha=0.8},
			border = {r=1, g=1, b=0, alpha=0.8}
		},
		pullerTargetOOC = {
			background = {r=1, g=1, b=0, alpha=0.3},
			border = {r=0, g=0, b=0, alpha=0.4}
		},
		attackingMe = {
		},
		cced = {
			background = {r=0, g=0, b=0, alpha=0.5},
			border = {r=0, g=0, b=0, alpha=1}
		},
		nonTapped = {
			mobBar = {r=0.8, g=0.8, b=0.8},
		},
		pvp = {
			mobBar = {r=1, g=0, b=0},
		}
		
	}
}

-- the reason why these are not included directly in the table above is that make references into it eliminating duplicate information

SA_THEME.PerfectRaid.title = {
	gap = 0,
	backdrop = SA_THEME.PerfectRaid.backdrop,
	colors = {
		empty = {
			alpha = 0.5,
			background = SA_THEME.PerfectRaid.colors.normal.background,
			border = SA_THEME.PerfectRaid.colors.normal.border,
		},
		normal = {
			alpha = 1,
			background = SA_THEME.PerfectRaid.colors.normal.background,
			border = SA_THEME.PerfectRaid.colors.normal.border,
		},
		filtered = {
			alpha = 1,
			background = {r=0, g=0.6, b=0.8, alpha=1},
			border =  {r=0, g=0.6, b=0.8, alpha=1}
		},
		paused = {
			alpha = 1,
			background = {r=0, g=0, b=0, alpha=1},
			border =  {r=0, g=0, b=0, alpha=1}
		},
		overloaded = {
			alpha = 1,
			background = {r=1, g=0, b=0, alpha=1},
			border =  {r=1, g=0, b=0, alpha=1}
		}
	}
}

SA_THEME.PerfectRaid.mobText = {
	alpha = 1,
	justifyH = "LEFT",
	justifyV = "MIDDLE",
	height = SA_THEME.PerfectRaid.mobBar.height,
	width = 95,
	x = 18,
	y = SA_THEME.PerfectRaid.mobBar.y,
	extFont = {
		file = SA_FONT_PATH.."Univers_Bold.ttf",
		size = 11
	}
}

SA_THEME.PerfectRaid.targetText = {
	hide = true
}

SA_THEME.PerfectRaid.icons = {
	positions = {
		{ name="Disabled",		point="TOPLEFT", 	relativePoint="", x=0, 				y=0, 			width=0, height=0},
		{ name="Left",			point="TOPLEFT", 	relativePoint="", x=SA_PR_EDGE, 	y=-SA_PR_EDGE, 	width=12, height=12},
		{ name="Bar right",		point="TOPRIGHT", 	relativePoint="", x=-SA_PR_EDGE, 	y=-SA_PR_EDGE, 	width=12, height=12}
	}
}

SA_THEME.PerfectRaid.defaults = {
	spacing = 0,
	widthSlider = {
		min = 200, 
		max = 500,
		value = 250
	},
	scaling = 1,
	-- if no default specified position 1 will be used which is considered as disabled!
	-- positions are applied when theme is changed
	icons = {
		raidTarget = 3,
		huntersMark = 2,
		mobClass = 1
	}
}