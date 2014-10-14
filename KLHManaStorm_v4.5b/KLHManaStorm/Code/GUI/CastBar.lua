
-- module setup
local me = { name = "castbar"}
local mod = thismod
mod[me.name] = me

--[[
CastBar.lua

This is a GUI class, which draws a bar giving information about the spell being cast. The left of the bar represents the end of the cast time, and the right of the bar is the start of the cast time. The bar is divided into 4 regions:
	Far Right: Red zone. In this region, the spell has effectively already been cast due to lag. i.e. if you cancel the cast, it is guaranteed to be too late. Therefore you should cancel it and cast a new spell, to speed up your overall dps.
	Middle Right: Red-Yellow zone. This is an uncertainty zone due to lag. A cancel at this time may or may not succeed.
	Middle Left: Yellow zone. In this area a cancel is guaranteed to last. This is the zone where you cancel a spell that is about to overheal and cast a new one.
	Left: Green zone. Spell still has a long way to go, so do nothing.

Above the bar on the right the name of the spell being cast is displayed.

When a spell is created, call <me.setspellname> with the name of the spell. Then while it is visible, call <me.setbarvalues> on update.
]]

me.myevents = { "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE", "CHAT_MSG_SPELL_CREATURE_VS_CREATURE_DAMAGE"}

me.onevent = function()
	
	if me.disable == true then
		return
	end
	
	start, finish, target = string.find(arg1, ".+'s Dark Glare [crh]+its (.+) for")
	
	if start == nil then
		return
	end
	
	me.count = me.count + 1
	
	if me.count > 2 then
		return
	end
	
	--SendChatMessage(string.format("Lol! %s just got owned by Dark Glare!", target), "GUILD")
end

me.count = 0
me.disable = false

me.updatetimer = function()

	me.count = 0

end

me.myonupdates =
{
	updatetimer = 2.0,
}	

me.save = 
{
	width = 200,
	height = 35,
}

me.metatable = 
{
	__index = function(this, key, value)
		
	end
}

me.createinstance = function(width, height)
	
	local this = { }
	setmetatable(this, me.metatable)
	
	this:constructor(width, height)
	return this
	
end

-- This method is called at startup by Core.lua
me.onload = function()

	me.constructor(me.save.width, me.save.height)
	
	me.frame:SetPoint("CENTER", 0, -25)
	
end

me.xinset = 4
me.yinset = 4

-- This creates the GUI components.
me.constructor = function(width, height)

	me.frame = mod.gui.createframe(width, height, true)
	
	-- textures
	me.texture = { }
	
	-- shadow (border)
	me.texture.shadow = me.frame:CreateTexture(nil, "BORDER")
	me.texture.shadow:SetTexture(1.0, 1.0, 1.0, 1.0)
	me.texture.shadow:SetGradientAlpha("VERTICAL", 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 0.25)
	
	-- red
	me.texture.red = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.red:SetTexture(1.0, 0.0, 0.0, 1.0)

	-- redyellow
	me.texture.redyellow = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.redyellow:SetTexture(1.0, 1.0, 1.0, 1.0)
	me.texture.redyellow:SetGradient("HORIZONTAL", 1.0, 0.0, 0.0, 1.0, 1.0, 0.0)
	
	-- yellow
	me.texture.yellow = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.yellow:SetTexture(1.0, 1.0, 0.0, 1.0)
	
	-- green
	me.texture.green = me.frame:CreateTexture(nil, "BACKGROUND")
	me.texture.green:SetTexture(0.0, 1.0, 0.0, 1.0)
	
	-- empty (artwork)
	me.texture.empty = me.frame:CreateTexture(nil, "ARTWORK")
	me.texture.empty:SetTexture(0.0, 0.0, 0.0, 0.9)
	
	-- strings
	me.string = { }
		
	-- spellname
	me.string.spellname = mod.gui.createfontstring(me.frame, 13)
	me.string.spellname:SetPoint("BOTTOMRIGHT", me.frame, "TOPRIGHT")
	
	-- additional setup
	me.resize(width, height)
	me.setbarvalues(1500, 400, 400, 300) -- just a default setup to stop him looking spastic
	me.frame:Hide()
	
end

--[[
mod.castbar.resize(width, height)
Sets the dimensions of the bar.

<width>	number; desired width in pixels (except for scaling?)
<height>	number; desired height in pixels (except for scaling?)
]]
me.resize = function(width, height)
			
	me.frame:SetWidth(width)
	me.frame:SetHeight(height)
	
	-- 6 and 8 represents the insets from the border
	me.clientwidth = width - 2 * me.xinset
	me.clientheight = height - 2 * me.yinset
	
	-- set heights of all the textures
	local x
	for _, x in me.texture do
		x:SetHeight(me.clientheight)
	end
	
	-- set the shadow overlay texture
	me.texture.shadow:SetWidth(me.clientwidth)
	me.texture.shadow:ClearAllPoints()
	me.texture.shadow:SetPoint("CENTER", 0, 0)
	
end

--[[
mod.castbar.setspellname(spellname)

Changes the label above the bar showing the spell name.
]]
me.setspellname = function(spellname)
	
	me.string.spellname:SetText(spellname)
	
end

--[[
mod.castbar.setbarvalues(duration, lag, cancel, elapsed)
Redraws the bar to match the new timing data. All values are in milliseconds.

<duration>	number; quoted duration of the spell.
<lag>			number; your ping.
<cancel>		number; how long the overheal cancel area is (yellow zone)
<elapsed>	number; time since the spell was cast (on our end)
]]
me.setbarvalues = function(duration, lag, cancel, elapsed)

 	-- maximum coloured region
	local visible = math.max(0, duration + lag - elapsed)
	
	local laguncertainty = lag / 5
	
	local red = lag - laguncertainty
	local redyellow = 2 * laguncertainty
	local yellow = cancel
	local green = duration - cancel - laguncertainty
	
	-- now apply visibility
	local empty = math.min(elapsed, duration + lag)

	me.setcolours(red / (duration + lag), redyellow / (duration + lag), yellow / (duration + lag), green / (duration + lag), empty / (duration + lag))
	
end

--[[
me.setcolours(red, redyellow, yellow, green, empty)
Internal drawing method. The arguments are such that red + redyellow + yellow + green = 1, and 0 <= empty <= 1.
]]
me.setcolours = function(red, redyellow, yellow, green, empty)
	
	local left = me.xinset
	
	-- red
	me.texture.red:SetWidth(red * me.clientwidth)
	me.texture.red:ClearAllPoints()
	me.texture.red:SetPoint("LEFT", left, 0)
	left = left + red * me.clientwidth
	
	-- redyellow
	me.texture.redyellow:SetWidth(redyellow * me.clientwidth)
	me.texture.redyellow:ClearAllPoints()
	me.texture.redyellow:SetPoint("LEFT", left, 0)
	left = left + redyellow * me.clientwidth
	
	-- yellow
	me.texture.yellow:SetWidth(yellow * me.clientwidth)
	me.texture.yellow:ClearAllPoints()
	me.texture.yellow:SetPoint("LEFT", left, 0)
	left = left + yellow * me.clientwidth
	
	-- green
	me.texture.green:SetWidth(green * me.clientwidth)
	me.texture.green:ClearAllPoints()
	me.texture.green:SetPoint("LEFT", left, 0)
	left = left + green * me.clientwidth	
	
	-- empty
	me.texture.empty:SetWidth(empty * me.clientwidth)
	me.texture.empty:ClearAllPoints()
	me.texture.empty:SetPoint("RIGHT", - me.xinset, 0)
	
end