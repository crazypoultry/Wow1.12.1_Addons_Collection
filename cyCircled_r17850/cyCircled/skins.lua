--[[
	Skin elements
		
		icon		Button icon
		overlay	Base texture overlay
		equip		Texture when an equipped item is linked to an action button
		flash		Texture for an currently active button (eg. "Attack")
		cooldown	Cooldown animation
		hotkey	Hotkey string
		count		Count string
		autocast	Autocast animation
		autocastable Autocast arrows
		
		NormalTexture
		HighlightTexture
		PushedTexture
		CheckedTexture
	
	Skin parameters
	
		w		Width
		h		Height
		x		x-offset (Default: 0)
		y		y-offset (Default: 0)
		p		Point (Default: CENTER)
		rp		Relative point (Default: CENTER)
		tex		Texture file (complete path)
		bm		Blend mode (for textures)
		dl		Draw layer (for textures)
		fl		Frame level
		s		Scale (Default: 1.0)
		a		Alpha (Default: 1.0)

]]

cyCircled.skins = {
	["Serenity"] = {
		["icon"] 	= { w=26, h=25, dl="BACKGROUND" },
		["overlay"] = { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\serenity0", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\cyCircled\\textures\\serenity0", },
		["flash"]	= { w=30, h=30, tex="Interface\\AddOns\\cyCircled\\textures\\overlayred", a=.6, },
		["cooldown"]= { w=36, h=36, fl=2, s=.7, },
		["hotkey"]	= { x=3, y=11, dl="OVERLAY", },
		["count"]	= { x=10, y=-6, dl="OVERLAY", },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, fl=2, },
		["autocastable"]= { w=57, h=62, },
		
		["NormalTexture"] 		= { w=1, h=1, x=4, y=-4, r="CENTER", rp="TOPLEFT", }, -- this texture needs to be hidden, but setalpha is not possible as it's overritten
		["HighlightTexture"] 	= { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\serenity0", bm="BLEND", },
		["PushedTexture"] 		= { w=38, h=38, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
		["CheckedTexture"]		= { w=38, h=38, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
	},
	["Sprocket"] = {
		["icon"] 	= { w=26, h=25, dl="BACKGROUND" },
		["overlay"] = { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\Sprocket",  },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\cyCircled\\textures\\Sprocket", },
		["flash"]	= { w=30, h=30, tex="Interface\\AddOns\\cyCircled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, fl=2, s=.7, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, fl=2, },
		["autocastable"]= { w=57, h=62, },
		
		["NormalTexture"] 		= { w=1, h=1, x=4, y=-4, r="CENTER", rp="TOPLEFT", },
		["HighlightTexture"] 	= { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\Sprocket", bm="BLEND", },
		["PushedTexture"] 		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
		["CheckedTexture"]		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["SprocketBlack"] = {
		["icon"] 	= { w=26, h=25, dl="BACKGROUND" },
		["overlay"] = { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketBlack", bm="BLEND", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketBlack", },
		["flash"]	= { w=30, h=30, tex="Interface\\AddOns\\cyCircled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, fl=2, s=.7, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, fl=2, },
		["autocastable"]= { w=57, h=62, },
		
		["NormalTexture"] 		= { w=1, h=1, x=4, y=-4, r="CENTER", rp="TOPLEFT", },
		["HighlightTexture"] 	= { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketBlack", bm="BLEND", },
		["PushedTexture"] 		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
		["CheckedTexture"]		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["SprocketSpark"] = {
		["icon"] 	= { w=26, h=25, dl="BACKGROUND" },
		["overlay"] = { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketSpark", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketSpark", },
		["flash"]	= { w=30, h=30, tex="Interface\\AddOns\\cyCircled\\textures\\overlayred" },
		["cooldown"]= { w=36, h=36, fl=2, s=.7, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, },
		["autocast"]= { w=30, h=30, fl=2, },
		["autocastable"]= { w=57, h=62, },
		
		["NormalTexture"] 		= { w=1, h=1, x=4, y=-4, r="CENTER", rp="TOPLEFT", },
		["HighlightTexture"] 	= { w=43, h=43, tex="Interface\\AddOns\\cyCircled\\textures\\SprocketSpark", bm="BLEND", },
		["PushedTexture"] 		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
		["CheckedTexture"]		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
	["Glossy"] = {
		["icon"] 	= { w=32, h=32, dl="BACKGROUND" },
		["overlay"] = { w=37, h=37, tex="Interface\\AddOns\\cyCircled\\textures\\glossy0", },
		["equip"] 	= { w=46, h=46, tex="Interface\\AddOns\\cyCircled\\textures\\glossy1", },
		["flash"]	= { w=30, h=30, },
		["cooldown"]= { w=42, h=42, fl=2, s=.7, },
		["hotkey"]	= { x=3, y=-2, },
		["count"]	= { x=10, y=-6, },
		["bagicon"]	= { w=26, h=25, x=6, y=-6, },
		["autocast"]= { w=30, h=30, fl=2, },
		["autocastable"]= { w=57, h=62, },
		
		["NormalTexture"] 		= { w=1, h=1, x=4, y=-4, r="CENTER", rp="TOPLEFT", },
		["HighlightTexture"] 	= { w=37, h=37, tex="Interface\\AddOns\\cyCircled\\textures\\glossy1", bm="BLEND", },
		["PushedTexture"] 		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", bm="ADD", },
		["CheckedTexture"]		= { w=38, h=37, tex="Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", },
	},
}