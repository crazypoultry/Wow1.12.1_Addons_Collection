
--[[---------------------------------------------------------------------------

	Please do not modify this file directly if you wish to customize
	the theme. Instead, make a copy of the file and add it into	layouts.xml
	
	This way your customized theme will not get overwritten everytime you
	update the addon.
	
	See Elegant.lua for more information !

---------------------------------------------------------------------------]]--


SA_IMAGE_PATH = "Interface\\AddOns\\SmartAssist\\images\\";

SA_THEME.Legacy = {
	
	backdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	},

	-- statusbars
	
	mobBar = {
		height = 12,
		relativeWidth = -20,
		x = 10,
		y = -8
	},
	targetBar = {
		height = 12,
		relativeWidth = -20,
		x = 10,
		y = -22
	},
	
	-- fontstrings
	
	targetOf = {
		point = "BOTTOMLEFT",
		relativePoint = "BOTTOMLEFT",
		justifyH="LEFT",
		justifyV="TOP",
		height = 12,
		relativeWidth = -20,
		x = 10,
		y = 6,
		color = {r=1, g=0.82, b=0}
	},
	
	colors = {
		-- default state, must include all elements (in other words, do not remove them) !
		normal = {
			background = {r=0, g=0, b=0, alpha=0.4},
			border = {r=0, g=0, b=0, alpha=0.7},
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
			background = {r=0, g=0.75, b=0, alpha=0.85},
			border = {r=0, g=1, b=0, alpha=1}
		},
		myTargetOOC = {
			background = {r=0, g=0.65, b=0, alpha=0.65},
			border = {r=0, g=1, b=0, alpha=0.75}
		},
		ooc = {
			background = {r=0, g=0, b=0, alpha=0.2},
			border = {r=0, g=0, b=0, alpha=0.5},
			mobBar = {r=0.38, g=0.38, b=0.38},
			targetBar = {r=0.38, g=0.38, b=0.38}
		},
		pullerTarget = {
			background = {r=1, g=1, b=0, alpha=0.3},
			border = {r=0, g=0, b=0, alpha=0.4}
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

SA_THEME.Legacy.title = {
	gap = 0,
	backdrop = SA_THEME.Legacy.backdrop,
	colors = {
		empty = {
			alpha = 0.5,
			background = SA_THEME.Legacy.colors.normal.background,
			border = SA_THEME.Legacy.colors.normal.border,
		},
		normal = {
			alpha = 1,
			background = SA_THEME.Legacy.colors.normal.background,
			border = {r=0.9, g=0.9, b=0.9, alpha=1}
		},
		filtered = {
			alpha = 1,
			background = {r=0, g=0.6, b=0.8, alpha=1},
			border =  {r=0, g=0.6, b=0.8, alpha=1}
		},
		paused = {
			alpha = 1,
			background = {r=0.4, g=0.4, b=0.4, alpha=1},
			border =  {r=0.3, g=0.3, b=0.3, alpha=1}
		},
		overloaded = {
			alpha = 1,
			background = {r=1, g=0, b=0, alpha=1},
			border =  {r=1, g=0, b=0, alpha=1}
		}
	}
}

-- place statusbar texts directly into the statusbar

SA_THEME.Legacy.mobText = {
	alpha = 0.85,
	justifyH = "CENTER",
	justifyV = "MIDDLE",
	height = SA_THEME.Legacy.mobBar.height,
	relativeWidth = -20,
	x = SA_THEME.Legacy.mobBar.x,
	y = SA_THEME.Legacy.mobBar.y
}

SA_THEME.Legacy.targetText = {
	alpha = 0.85,
	justifyH = "CENTER",
	justifyV = "MIDDLE",
	height = SA_THEME.Legacy.targetBar.height,
	relativeWidth = -20,
	x = SA_THEME.Legacy.targetBar.x,
	y = SA_THEME.Legacy.targetBar.y
}

SA_THEME.Legacy.icons = {
	positions = {
		{ name="Disabled",		point="TOPLEFT", 		relativePoint="", x=-26, 	y=-28, 	width=25, height=25 },
		{ name="Left bottom",	point="TOPLEFT", 		relativePoint="", x=-26, 	y=-28, 	width=25, height=25, gap=30 },
		{ name="Left top",		point="TOPLEFT", 		relativePoint="", x=-26, 	y=-3, 	width=25, height=25, gap=30},
		{ name="Inside box",	point="BOTTOMRIGHT", 	relativePoint="", x=0, 		y=0, 	width=25, height=25},
		{ name="Right bottom",	point="TOPRIGHT", 		relativePoint="", x=26, 	y=-28, 	width=25, height=25, gap=30 },
		{ name="Right top",		point="TOPRIGHT", 		relativePoint="", x=26, 	y=-3, 	width=25, height=25, gap=30},
		{ name="Left big",		point="TOPLEFT", 		relativePoint="", x=-51, 	y=-3, 	width=50, height=50, gap=55},
		{ name="Right big",		point="TOPRIGHT", 		relativePoint="", x=51, 	y=-3, 	width=50, height=50, gap=55}
	},
	
	-- if no default specified position 1 will be used which is considered as disabled!
	-- positions are applied when theme is changed
	defaults = {
		raidTarget = 3,
		huntersMark = 1,
		mobClass = 1
	}
}