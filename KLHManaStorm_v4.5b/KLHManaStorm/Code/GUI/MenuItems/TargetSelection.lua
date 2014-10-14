
-- module setup
local me = { name = "menutarget"}
local mod = thismod
mod[me.name] = me

--[[
MenuItems\TargetSelection.lua

This is a menu section where you specify how the mod choses the next spell target. The subsections are
-- Classes 
-- Raid Groups 
-- Friends (weightings for individual players)
-- Personal (me, my target, my group)
-- Aggro (player is targeted by a mob)
]]

me.onload = function()
	
	me.createstartpage()
	me.createclasspage()
	me.creategrouppage()
	me.createpersonalpage()
	me.createrandomisationpage()
	
end

me.fontsize = 14
me.width = 450
me.sectiongap = 10
me.itemgap = 25

me.createstartpage = function()

	me.start = { }
	this = me.start
	this.frame = mod.gui.createframe(me.width, 500)
	
	local label = mod.gui.createfontstring(this.frame, 15)
	label:SetPoint("TOPLEFT", mod.gui.textinset, -mod.gui.textinset)
	label:SetJustifyH("LEFT")
	label:SetJustifyV("TOP")
	
	label:SetText(mod.string.get("menu", "targetselection", "start", "text"))
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	
	-- add to frame
	this.frame.label = label
	
	-- Now size the frame to the string
	this.frame:SetHeight(mod.gui.textinset * 2 + label:GetHeight() + 2 * mod.gui.border)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)

	mod.menu.registersection("target-start", nil, mod.string.get("menu", "targetselection", "start", "description"), this.frame)
	
end

me.classes = { "warrior", "rogue", "druid", "mage", "priest", "paladin", "warlock", "hunter", "shaman" }

me.createclasspage = function()
	
	me.class = { }
	this = me.class
	
	this.slider = { }
	this.frame = mod.gui.createframe(me.width, 500)
	
	local position = - mod.gui.textinset 
	local slider, class
	
	this.frame.setup = function()
		for _, class in me.classes do
			slider = me.class.slider[class]
			slider:SetValue(100 * mod.target.save.class[class])
		end
	end

	x = 0
	
	for _, class in me.classes do
		x = x + 1
		
		slider = mod.gui.createslider(this.frame, 200, 15, me.fontsize)
		slider.name = class
		this.slider[class] = slider
		
		slider:SetMinMaxValues(50, 200)
		slider:SetValueStep(5)
		
		slider.text:SetText(mod.string.get("menu", "targetselection", "class", class))
		slider.low:SetText("50")
		slider.high:SetText("200")
		slider.value:SetText(slider:GetValue() .. "%")
		
		local colours = RAID_CLASS_COLORS[string.upper(class)]
		slider.text:SetTextColor(colours.r, colours.g, colours.b)
		
		slider:SetScript("OnValueChanged", 
			function()
				this.value:SetText(this:GetValue() .. "%")
				me.classsliderupdate(this.name)
			end
		)
		
		if x == math.floor(x / 2) * 2 then
			-- x is even, every second one goes on the right
			slider:SetPoint("TOPRIGHT", this.frame, -mod.gui.textinset, position + slider.realheight() + me.sectiongap - slider.text:GetHeight())
			
		else
			slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
			position = position - slider.realheight() - me.sectiongap
		end
	end
	
	-- resize frame
	this.frame:SetHeight(-position + mod.gui.textinset - me.sectiongap)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)
	
	mod.menu.registersection("target-class", "target-start", mod.string.get("menu", "targetselection", "class", "description"), this.frame)
	
end

me.classsliderupdate = function(slidername)
	
	local slider = me.class.slider[slidername]
	
	mod.target.save.class[slidername] = slider:GetValue() / 100
		
end

me.creategrouppage = function()
	
	me.group = { }
	this = me.group
	
	this.slider = { }
	this.frame = mod.gui.createframe(me.width, 500)
	
	local position = - mod.gui.textinset 
	local slider, group
	
	this.frame.setup = function()
		for group = 1, 8 do
			slider = me.group.slider[group]
			slider:SetValue(100 * mod.target.save.raidgroup[group])
		end
	end
	
	for group = 1, 8 do
		
		slider = mod.gui.createslider(this.frame, 200, 15, me.fontsize)
		slider.group = group
		this.slider[group] = slider
		
		slider:SetMinMaxValues(50, 200)
		slider:SetValueStep(5)
		
		slider.text:SetText(mod.string.get("menu", "targetselection", "group", "group") .. group)
		slider.low:SetText("50")
		slider.high:SetText("200")
		slider.value:SetText(slider:GetValue() .. "%")
			
		slider:SetScript("OnValueChanged", 
			function()
				this.value:SetText(this:GetValue() .. "%")
				me.groupsliderupdate(this.group)
			end
		)
		
		if group == math.floor(group / 2) * 2 then
			-- x is even, every second one goes on the right
			slider:SetPoint("TOPRIGHT", this.frame, -mod.gui.textinset, position + slider.realheight() + me.sectiongap - slider.text:GetHeight())
			
		else
			slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
			position = position - slider.realheight() - me.sectiongap
		end
	end
	
	-- resize frame
	this.frame:SetHeight(-position + mod.gui.textinset - me.sectiongap)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)
	
	mod.menu.registersection("target-group", "target-start", mod.string.get("menu", "targetselection", "group", "description"), this.frame)
	
end

me.groupsliderupdate = function(group)
	
	local slider = me.group.slider[group]
	
	mod.target.save.raidgroup[group] = slider:GetValue() / 100
		
end

------------------------------------------------------------------------------------------
--------------------------- Personal Page ------------------------------------------------
------------------------------------------------------------------------------------------

me.createpersonalpage = function()
	
	me.personal = { }
	this = me.personal
		
	-- create frame
	this.frame = mod.gui.createframe(me.width, 500)
	this.frame.setup = function()
		-- set initial values
		for name, slider in me.personal.slider do
			slider:SetValue(mod.target.save.personal[name] * 100)
		end
	end
	
	this.label = { }
	this.slider = { }
	
	-- position keeps track of how far down we've gone. 30 = room for the next guy
	local position = - mod.gui.textinset 
	local label, slider
		
---------------------------------------------------------------------------

	-- one silly text box
	label = mod.gui.createfontstring(this.frame, me.fontsize)
	this.label.main = label

	label:SetText(mod.string.get("menu", "targetselection", "personal", "text"))
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.itemgap

---------------------------------------------------------------------------

	-- slider for <group>
	slider = mod.gui.createslider(this.frame, 200, 20, me.fontsize)
	slider.name = "group"
	this.slider.group = slider
	
	slider:SetMinMaxValues(50, 200)
	slider:SetValueStep(5)
	
	slider.text:SetText(mod.string.get("menu", "targetselection", "personal", "group"))
	slider.low:SetText("50")
	slider.high:SetText("200")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			me.personalsliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
			
---------------------------------------------------------------------------
	
	-- slider for <you>
	slider = mod.gui.createslider(this.frame, 200, 20, me.fontsize)
	slider.name = "you"
	this.slider.you = slider
	
	slider:SetMinMaxValues(50, 200)
	slider:SetValueStep(5)
	
	slider.text:SetText(mod.string.get("menu", "targetselection", "personal", "you"))
	slider.low:SetText("50")
	slider.high:SetText("200")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			me.personalsliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
			
---------------------------------------------------------------------------

	-- slider for <target>
	slider = mod.gui.createslider(this.frame, 200, 20, me.fontsize)
	slider.name = "target"
	this.slider.target = slider
	
	slider:SetMinMaxValues(50, 200)
	slider:SetValueStep(5)
	
	slider.text:SetText(mod.string.get("menu", "targetselection", "personal", "target"))
	slider.low:SetText("50")
	slider.high:SetText("200")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			me.personalsliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
			
---------------------------------------------------------------------------
	
	-- set frame height
	this.frame:SetHeight(-position + mod.gui.textinset - me.sectiongap)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)
	
	-- now register the section
	mod.menu.registersection("target-personal", "target-start", mod.string.get("menu", "targetselection", "personal", "description"), this.frame)
	
end

--[[
me.sliderupdate()
	This method is called whenever the value of one of our sliders is changed. 
	
<slidername>	string; name of the slider, i.e. key in <me.slider>
]]
me.personalsliderupdate = function(slidername)
	
	local slider = me.personal.slider[slidername]
	
	mod.target.save.personal[slidername] = slider:GetValue() / 100
	
end


------------------------------------------------------------------------------------------
---------------------------- Randomisation -----------------------------------------------
------------------------------------------------------------------------------------------

me.setuprandomisation = function()
	
	
end

me.createrandomisationpage = function()
	
	me.randomisation = { }
	this = me.randomisation
		
	-- create frame
	this.frame = mod.gui.createframe(me.width, 500)
	this.frame.setup = me.setuprandomisation
	
	this.label = { }
	this.slider = { }

	-- position keeps track of how far down we've gone. 30 = room for the next guy
	local position = - mod.gui.textinset 
	local label, slider
	
	-- setup
	this.frame.setup = function()
		me.randomisation.slider.maxmultiplier:SetValue(100 * mod.target.save.randomisation.maxmultiplier)
	end

--------------------------------------------------------------------------------

	-- label up the top
	
	label = mod.gui.createfontstring(this.frame, me.fontsize)
	this.label.main = label

	label:SetText(mod.string.get("menu", "targetselection", "randomisation", "text"))
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.itemgap
	
--------------------------------------------------------------------------------

	-- slider for <maxmultiplier>
	slider = mod.gui.createslider(this.frame, 200, 20, me.fontsize)
	slider.name = "maxmultiplier"
	this.slider.maxmultiplier = slider
	
	slider:SetMinMaxValues(100, 200)
	slider:SetValueStep(5)
	
	slider.text:SetText(mod.string.get("menu", "targetselection", "randomisation", "maxmultiplier"))
	slider.low:SetText("100")
	slider.high:SetText("200")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			mod.target.save.randomisation.maxmultiplier = this:GetValue() / 100
		end
	)
	
	slider:SetPoint("TOPLEFT", this.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.sectiongap
	
--------------------------------------------------------------------------------
	
	-- label for <maxmultiplier>
	
	label = mod.gui.createfontstring(this.frame, me.fontsize)
	this.label.main = label

	label:SetText(mod.string.get("menu", "targetselection", "randomisation", "maxmultipliertext"))
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.itemgap

--------------------------------------------------------------------------------

	-- set frame height
	this.frame:SetHeight(-position + mod.gui.textinset - me.itemgap)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)
	
	-- now register the section
	mod.menu.registersection("target-randomisation", "target-start", mod.string.get("menu", "targetselection", "randomisation", "description"), this.frame)
	
end




------------------------------------------------------------------------------------------
---------------------------- Friends List ------------------------------------------------
------------------------------------------------------------------------------------------


