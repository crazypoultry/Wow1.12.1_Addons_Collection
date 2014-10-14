
--[[---------------------------------------------------------------------------

	Please do not modify this file directly if you wish to customize
	the theme. Instead, make a copy of the file and add it into	themes.xml
	
	This way your customized theme will not get overwritten accidentally when
	update the addon.
	
	If you make nice looking hack I would be more than happy to include it
	in the official package (credited ofcourse). You can submit the theme
	as a ticket into SmartAssist trac at url:
	
	http://addiktit.net/~paranoidi/trac/smartassist/
	
	You can also open request tickets if you need more customization which
	the current system does not provide.
	
	Some attributes that are available for most elements but do not appear 
	in this theme:
	
		hide = true
		
	Some attributes and values for text elements, optional elements in []:
	
	    justifyH		- Sets horizontal text justification ("LEFT","RIGHT", or "CENTER") 
		justifyV		- Sets vertical text justification ("TOP","BOTTOM", or "MIDDLE")
		[color]			- r,g,b,alpha .. if not present default font color will be used
		[gameFont]		- TextStatusBarText, GameFontHighlightSmall, GameFontNormalSmall etc ..
						  DEFAULT: TextStatusBarText
		[extFont]		- Use font from external file. 
						  Must be table ie. {file="", size=2, flags="")
						  Possible flag values: "OUTLINE", "THICKOUTLINE" and/or "MONOCHROME"
						  Flags are optional !
		[point]			- From which point the element is anchored
						  Possible values (LEFT, RIGHT, TOP, BOTTOM, TOPLEFT, 
						  TOPRIGHT, BOTTOMLEFT, BOTTOMRIGHT)
						  DEFAULT: TOPLEFT
		[shadow]		- dropdown shadow for font
						  Example:	shadow = { color = {r=0, g=0, b=0, alpha=1}, offset = {x=2, y=-2} }
						  DEFAULT: No shadow
		[relativePoint]	- Where to in frame the element is anchored
						  Same possible values ofcourse.
						  DEFAULT: TOPLEFT
						  
	Possible values for blendMode

	    * "DISABLE" - opaque texture (DEFAULT)
	    * "BLEND" - normal painting on top of the background, obeying alpha channels if set (?)
	    * "ALPHAKEY" - 1-bit alpha
	    * "ADD" - additive blend
	    * "MOD" - modulating blend 							  
						 
	Relative width for text and bar elements.
	
	Since the frame width is configurable some elements need to adjust accordingly.
	Relative width is relative to target frame so that value 0 is exactly same. 
	A value of -20 would be 20 units shorter then the target bar. 
	So if the element (mob bar example) is 10 unit idented from borders, 
	correct value would be -20. Note that 0 overlaps edges, so if you wish to get
	exact inside width use value calculated from: 0 - (backdrops edgeSize * 2).

---------------------------------------------------------------------------]]--

-- some variables to make things easier

SA_IMAGE_PATH = "Interface\\AddOns\\SmartAssist\\images\\";
SA_FONT_PATH = "Interface\\AddOns\\SmartAssist\\fonts\\";
SA_ELEGANT_EDGE = 2;

-- theme data

SA_THEME.Elegant = {

	-- texture hilight is optional, you can also hilight using colors! Just remove whole myTargetTexture.
	myTargetTexture = "Interface\\Addons\\SmartAssist\\images\\TargetHilight.tga",
	
	-- defines background and borders	
	backdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = true,
		tileSize = SA_ELEGANT_EDGE,
		edgeSize = SA_ELEGANT_EDGE,
		insets = {
			left = SA_ELEGANT_EDGE,
			right = SA_ELEGANT_EDGE,
			top = SA_ELEGANT_EDGE,
			bottom = SA_ELEGANT_EDGE
		}
	},

	-- statusbars
	mobBar = {
		texture = SA_IMAGE_PATH.."BantoBar.tga",
		height = 18,
		relativeWidth = -(2*SA_ELEGANT_EDGE),
		x = SA_ELEGANT_EDGE,
		y = -SA_ELEGANT_EDGE,
		background = {
			coverage = 1,
			texture = SA_IMAGE_PATH.."Smooth.tga",
			--color = {r=0, g=0, b=0, alpha=0.8},
			--blendMode = "ADD",
			gradient = {
				min = {r=0, g=0, b=0, alpha=1},
				max = {r=0, g=0, b=0, alpha=0}
			}
		},
		spark = {
			alpha = 0.8
		}
	},
	targetBar = {
		texture = SA_IMAGE_PATH.."BantoBar.tga",
		height = 18,
		relativeWidth = -(2*SA_ELEGANT_EDGE),
		x = SA_ELEGANT_EDGE,
		y = -18-SA_ELEGANT_EDGE,
		background = {
			coverage = 0.3,
			texture = SA_IMAGE_PATH.."Smooth.tga",
			--color = {r=0, g=0, b=0, alpha=0.8},
			--blendMode = "ADD",
			gradient = {
				min = {r=1, g=0, b=0, alpha=1},
				max = {r=0.5, g=0, b=0, alpha=0.3}
			}
		},
		spark = {
			alpha = 0.8
		}
	},
	
	-- fontstring
	targetOf = {
		extFont = {
			file = SA_FONT_PATH.."Univers_Bold.ttf",
			size = 11
		},
		color = {r=0.9, g=0.9, b=0.9, alpha=1},
		point = "BOTTOMLEFT",
		relativePoint = "BOTTOMLEFT",
		justifyH = "LEFT",
		justifyV = "TOP",
		height = 12,
		relativeWidth = -20,
		x = 5,
		y = 4
	},
	
	-- you can test different modes by opening the target list configuration screen and typing /sa theme <mode>
	-- example: "/sa theme marked" will show what it looks like
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
			border = {r=0, g=1, b=0, alpha=1}
		},
		myTargetOOC = {
			background = {r=0, g=0.5, b=0, alpha=0.3},
			border = {r=0, g=1, b=0, alpha=0.7}
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
			mobBar = {r=0.3, g=0.3, b=0.3},
			background = {r=0, g=0, b=0, alpha=1},
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

SA_THEME.Elegant.title = {
	-- adjust space between title button and target frames
	gap = 2,
	backdrop = SA_THEME.Elegant.backdrop,
	colors = {
		empty = {
			alpha = 0.5,
			background = SA_THEME.Elegant.colors.normal.background,
			border = SA_THEME.Elegant.colors.normal.border,
		},
		normal = {
			alpha = 1,
			background = SA_THEME.Elegant.colors.normal.background,
			border = {r=0, g=0, b=0, alpha=1}
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

-- place statusbar texts directly into the statusbar

SA_THEME.Elegant.mobText = {
	alpha = 1,
	justifyH = "CENTER",
	justifyV = "MIDDLE",
	extFont = {
		file = SA_FONT_PATH.."Univers_Bold.ttf",
		size = 11
	},
	color = {r=1, g=1, b=1, alpha=1},
	shadow = {
		color = {r=0, g=0, b=0, alpha=1},
		offset = {x=1, y=-1}
	},
	height = SA_THEME.Elegant.mobBar.height,
	relativeWidth = SA_THEME.Elegant.mobBar.relativeWidth,
	x = SA_THEME.Elegant.mobBar.x,
	y = SA_THEME.Elegant.mobBar.y
}

SA_THEME.Elegant.targetText = {
	alpha = 1,
	justifyH = "CENTER",
	justifyV = "MIDDLE",
	extFont = {
		file = SA_FONT_PATH.."Univers_Bold.ttf",
		size = 11
	},
	color = {r=1, g=1, b=1, alpha=1},
	shadow = {
		color = {r=0, g=0, b=0, alpha=1},
		offset = {x=1, y=-1}
	},
	height = SA_THEME.Elegant.targetBar.height,
	relativeWidth = SA_THEME.Elegant.targetBar.relativeWidth,
	x = SA_THEME.Elegant.targetBar.x,
	y = SA_THEME.Elegant.targetBar.y
}

-- iconplaces this theme has

SA_THEME.Elegant.icons = {
	positions = {
		{ name="Disabled",		point="TOPLEFT", 		relativePoint="", x=0, 		y=0, 	width=0,	height=0},
		{ name="Left bottom",	point="TOPLEFT", 		relativePoint="", x=-26, 	y=-28, 	width=25, 	height=25, gap=30},
		{ name="Left top",		point="TOPLEFT", 		relativePoint="", x=-26, 	y=-3, 	width=25, 	height=25, gap=30},
		{ name="Inside box",	point="BOTTOMRIGHT", 	relativePoint="", x=0, 		y=0, 	width=25, 	height=25},
		{ name="Mob bar",		point="TOPLEFT", 		relativePoint="", x=SA_ELEGANT_EDGE, y=-SA_ELEGANT_EDGE, width=18, height=18},
		{ name="Right bottom",	point="TOPRIGHT", 		relativePoint="", x=26, 	y=-28, 	width=25, 	height=25, gap=30},
		{ name="Right top",		point="TOPRIGHT", 		relativePoint="", x=26, 	y=-3, 	width=25, 	height=25, gap=30},
		{ name="Left big",		point="TOPLEFT", 		relativePoint="", x=-51, 	y=-3, 	width=50, 	height=50, gap=55},
		{ name="Right big",		point="TOPRIGHT", 		relativePoint="", x=51, 	y=-3, 	width=50, 	height=50, gap=55}
	}
}

SA_THEME.Elegant.defaults = {
	spacing = -2,
	widthSlider = {
		min = 100, 
		max = 270,
		value = 200
	},
	scaling = 0.8,
	-- if no default specified position 1 will be used which is considered as disabled!
	-- positions are applied when theme is changed
	icons = {
		raidTarget = 3,
		huntersMark = 1,
		mobClass = 1
	}
}