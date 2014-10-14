
-- module setup
local me = { name = "menucancel"}
local mod = thismod
mod[me.name] = me

--[[
MenuItems\SpellCancelling.lua

This is an item in the help menu. Here you set the variables that determine when to cancel a spell.

1) Overheal Zone Duration. The width of the yellow bar, in milliseconds.
2) Maximum Expected Overheal Percent. 
]]

me.fontsize = 14
me.width = 500
me.sectiongap = 30
me.itemgap = 5

--[[
me.setup()
	Sets the slider positions to their initial values. This method becomes <me.frame.setup>, which will be run before the frame is :Show()n.
]]
me.setup = function()
	
	-- normalise percentages
	me.slider.cancelzoneduration:SetValue(mod.main.save.cancelzoneduration)
	me.slider.maximumoverheal:SetValue(100 * mod.main.save.maximumoverheal)
		
end

-- Special OnLoad() method called by Core.lua
me.onload = function()

	-- create frame
	me.frame = mod.gui.createframe(me.width, 500)
	me.frame.setup = me.setup
	me.label = { }
	me.slider = { }
	
	-- position keeps track of how far down we've gone. 30 = room for the next guy
	local position = - mod.gui.textinset 
	local label, slider
		
---------------------------------------------------------------------------

	-- slider for <cancelzoneduration>
	slider = mod.gui.createslider(me.frame, 200, 20, me.fontsize)
	slider.name = "cancelzoneduration"
	me.slider.cancelzoneduration = slider
	
	slider:SetMinMaxValues(100, 700)
	slider:SetValueStep(20)
	
	slider.text:SetText(mod.string.get("menu", "spellcancelling", "cancelzoneduration"))
	slider.low:SetText("100")
	slider.high:SetText("700")
	slider.value:SetText(slider:GetValue())
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue())
			me.sliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", me.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
	
	-- label for <cancelzoneduration>
	label = mod.gui.createfontstring(me.frame, me.fontsize)
	me.label.cancelzoneduration = label

	label:SetText(mod.string.get("menu", "spellcancelling", "cancelzonedurationtext"))
	label:SetWidth(me.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.sectiongap
		
---------------------------------------------------------------------------
	
	-- slider for <maximumoverheal>
	slider = mod.gui.createslider(me.frame, 200, 20, me.fontsize)
	slider.name = "maximumoverheal"
	me.slider.maximumoverheal = slider
	
	slider:SetMinMaxValues(0, 50)
	slider:SetValueStep(2)
	
	slider.text:SetText(mod.string.get("menu", "spellcancelling", "maximumoverheal"))
	slider.low:SetText("0")
	slider.high:SetText("50")
	slider.value:SetText(slider:GetValue() .. "%")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			me.sliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", me.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
	
	-- label for <maximumoverheal>
	label = mod.gui.createfontstring(me.frame, me.fontsize)
	me.label.hitpointvoidscale = label

	label:SetText(mod.string.get("menu", "spellcancelling", "maximumoverhealtext"))
	label:SetWidth(me.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.sectiongap
		
---------------------------------------------------------------------------
	
	-- set frame height
	me.frame:SetHeight(-position + mod.gui.textinset - me.sectiongap)
	me.frame.texture:SetHeight(me.frame:GetHeight() - 2 * mod.gui.border)
	
	-- now register the section
	mod.menu.registersection("spellcancelling", nil, mod.string.get("menu", "spellcancelling", "description"), me.frame)
	
end

--[[
me.sliderupdate()
	This method is called whenever the value of one of our sliders is changed. 
	
<slidername>	string; name of the slider, i.e. key in <me.slider>
]]
me.sliderupdate = function(slidername)
	
	local slider = me.slider[slidername]
	
	if slidername == "cancelzoneduration" then
		mod.main.save[slidername] = slider:GetValue()
		
	elseif slidername == "maximumoverheal" then
		mod.main.save[slidername] = slider:GetValue() / 100
		
	end
	
end