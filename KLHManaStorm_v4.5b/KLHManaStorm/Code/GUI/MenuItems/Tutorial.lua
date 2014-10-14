
-- module setup
local me = { name = "menututorial"}
local mod = thismod
mod[me.name] = me

--[[
MenuItems\Tutorial.lua

This is a menu section that explains how to use the mod.
]]

me.onload = function()
	
	me.createstartpage()
	me.createmacropage()
	
end

me.fontsize = 13
me.width = 450
me.sectiongap = 10

me.createstartpage = function()

	me.start = { }
	this = me.start
	this.frame = mod.gui.createframe(me.width, 500)
	
	local label = mod.gui.createfontstring(this.frame, 15)
	label:SetPoint("TOPLEFT", mod.gui.textinset, -mod.gui.textinset)
	label:SetJustifyH("LEFT")
	label:SetJustifyV("TOP")
	
	label:SetText(mod.string.get("menu", "tutorial", "start", "text"))
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	
	-- add to frame
	this.frame.label = label
	
	-- Now size the frame to the string
	this.frame:SetHeight(mod.gui.textinset * 2 + label:GetHeight() + 2 * mod.gui.border)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)

	mod.menu.registersection("tutorial-start", nil, mod.string.get("menu", "tutorial", "start", "description"), this.frame)
	
end



me.createmacropage = function()
	
	me.macro = { }
	this = me.macro
	this.frame = mod.gui.createframe(me.width, 500)
	
	local label = mod.gui.createfontstring(this.frame, 15)
	label:SetPoint("TOPLEFT", mod.gui.textinset, -mod.gui.textinset)
	label:SetJustifyH("LEFT")
	label:SetJustifyV("TOP")
	
	-- Figure out which spells our class can use
	local classstring = "|cffffff00"
	for spellid, data in mod.data.spell do
		if data.class == mod.my.class then
			classstring = classstring .. "\"" .. mod.string.get("spellname", spellid) .. "\" "
		end
	end
	
	classstring = classstring .. "|r"
			
	label:SetText(string.format(mod.string.get("menu", "tutorial", "macro", "text"), mod.string.get("spellname", "flashheal"), classstring))
	
	label:SetWidth(this.frame:GetWidth() - 2 * mod.gui.textinset)
	
	-- add to frame
	this.frame.label = label
	
	-- Now size the frame to the string
	this.frame:SetHeight(mod.gui.textinset * 2 + label:GetHeight() + 2 * mod.gui.border)
	this.frame.texture:SetHeight(this.frame:GetHeight() - 2 * mod.gui.border)

	mod.menu.registersection("tutorial-macro", "tutorial-start", mod.string.get("menu", "tutorial", "macro", "description"), this.frame)
	
end


--[[

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

]]