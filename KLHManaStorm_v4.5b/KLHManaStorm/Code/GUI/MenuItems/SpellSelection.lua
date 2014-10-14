
-- module setup
local me = { name = "menuspell"}
local mod = thismod
mod[me.name] = me

--[[
MenuItems\SpellSelection.lua

This is an item in the help menu. Here you set the variables that determine which rank of a spell to cast, given a spell <spellid> and missing hit points <hpvoid>. There are three important variables:

1) Void Multiplier. You aim to heal <hpvoid> * Void Multiplier. Multiplier is usually less than 1, this is basically anticipating heals on the target.
2) Maximum Expected Overheal Percent. Given a target heal size from (1), we pick the largest heal that we expect will overheal less than this amount. Usual range is 10%ish.
3) Minimum Expected Heal. Subject to (2), we pick the minimum amount of healing our spell should do. This sets the size of a heal we will cast when the target is on full life.
]]

me.fontsize = 13
me.width = 600
me.sectiongap = 25
me.itemgap = 5

--[[
me.setup()
	Sets the slider positions to their initial values. This method becomes <me.frame.setup>, which will be run before the frame is :Show()n.
]]
me.setup = function()
	
	-- first two are percentages so have to be normalised
	me.slider.hitpointvoidscale:SetValue(100 * mod.spell.save.hitpointvoidscale)
	me.slider.maximumoverheal:SetValue(100 * mod.spell.save.maximumoverheal)
	me.slider.minimumaverageheal:SetValue(mod.spell.save.minimumaverageheal)
	
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

	-- slider for <hitpointvoidscale>
	slider = mod.gui.createslider(me.frame, 200, 20, me.fontsize)
	slider.name = "hitpointvoidscale"
	me.slider.hitpointvoidscale = slider
	
	slider:SetMinMaxValues(50, 100)
	slider:SetValueStep(1)
	
	slider.text:SetText(mod.string.get("menu", "spellselection", "hitpointvoidscale"))
	slider.low:SetText("50")
	slider.high:SetText("100")
	slider.value:SetText(slider:GetValue() .. "%")
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue() .. "%")
			me.sliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", me.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
	
	-- label for <hitpointvoidscale>
	label = mod.gui.createfontstring(me.frame, me.fontsize)
	me.label.hitpointvoidscale = label

	label:SetText(mod.string.get("menu", "spellselection", "hitpointvoidscaletext"))
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
	slider:SetValueStep(1)
	
	slider.text:SetText(mod.string.get("menu", "spellselection", "maximumoverheal"))
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

	label:SetText(mod.string.get("menu", "spellselection", "maximumoverhealtext"))
	label:SetWidth(me.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.sectiongap
		
---------------------------------------------------------------------------

	-- slider for <minimumaverageheal>
	slider = mod.gui.createslider(me.frame, 200, 20, me.fontsize)
	slider.name = "minimumaverageheal"
	me.slider.minimumaverageheal = slider
	
	slider:SetMinMaxValues(0, 2000)
	slider:SetValueStep(50)
	
	slider.text:SetText(mod.string.get("menu", "spellselection", "minimumaverageheal"))
	slider.low:SetText("0")
	slider.high:SetText("2000")
	slider.value:SetText(slider:GetValue())
	
	slider:SetScript("OnValueChanged", 
		function()
			this.value:SetText(this:GetValue())
			me.sliderupdate(this.name)
		end
	)
	
	slider:SetPoint("TOPLEFT", me.frame, mod.gui.textinset, position - slider.text:GetHeight())
	position = position - slider.realheight() - me.itemgap
	
	-- label for <minimumaverageheal>
	label = mod.gui.createfontstring(me.frame, me.fontsize)
	me.label.minimumaverageheal = label

	label:SetText(mod.string.get("menu", "spellselection", "minimumaveragehealtext"))
	label:SetWidth(me.frame:GetWidth() - 2 * mod.gui.textinset)
	label:SetJustifyH("LEFT")
	
	label:SetPoint("TOPLEFT", mod.gui.textinset, position)
	position = position - label:GetHeight() - me.sectiongap
		
---------------------------------------------------------------------------
	
	-- set frame height
	me.frame:SetHeight(-position + mod.gui.textinset - me.sectiongap)
	me.frame.texture:SetHeight(me.frame:GetHeight() - 2 * mod.gui.border)
	
	-- now register the section
	mod.menu.registersection("spellselection", nil, mod.string.get("menu", "spellselection", "description"), me.frame)
	
end

--[[
me.sliderupdate()
	This method is called whenever the value of one of our sliders is changed. 
	
<slidername>	string; name of the slider, i.e. key in <me.slider>
]]
me.sliderupdate = function(slidername)
	
	local slider = me.slider[slidername]
	
	if slidername == "hitpointvoidscale" then
		mod.spell.save[slidername] = slider:GetValue() / 100
		
	elseif slidername == "maximumoverheal" then
		mod.spell.save[slidername] = slider:GetValue() / 100
		
	elseif slidername == "minimumaverageheal" then
		mod.spell.save[slidername] = slider:GetValue()
	end
	
end