
-- module setup
local me = { name = "gui"}
local mod = thismod
mod[me.name] = me

--[[
Gui.lua

Factory for standard GUI Widgets
]]

me.textinset = 15	-- This is the inset between the edge of the frame and where the text block starts.
me.border = 4		-- This is the experimentally determined width of the borders

--[[
------------------------------------------------------
						Frame
------------------------------------------------------
]]

me.framebackdrop = 
{
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
	tile = false,
	tileSize = 32,
	edgeSize = 16,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

--[[
mod.gui.genericframe(width, height)
	Creates a standard frame with a white border and dark blue background. The frame comes out hidden.
	
<width>	number; the width of the frame, in pixels
<height>	number; the height of the frame, in pixels
<omitbackground>	flag; if non-nil the texture bit won't be added

Return: a Frame object.
]]
me.createframe = function(width, height, omitbackground)
	
	local frame = CreateFrame("Frame", nil, UIParent)
	
	-- size
	frame:SetHeight(height)	
	frame:SetWidth(width)
	
	-- backdrop
	frame:SetBackdrop(me.framebackdrop)
	frame:SetBackdropColor(0.0, 0.0, 0.0, 0.0) 
	frame:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0) 
	
	-- we're gonna be greedy and make him high strata
	frame:SetFrameStrata("HIGH")
	
	if omitbackground == nil then
		-- background
		local texture = frame:CreateTexture(nil, "BORDER")
		texture:SetTexture(0.0, 0.0, 0.2, 0.7)
		texture:SetWidth(frame:GetWidth() - 2 * me.border)
		texture:SetHeight(frame:GetHeight() - 2 * me.border)
		texture:SetPoint("BOTTOMLEFT", frame, me.border, me.border)
		
		-- add texture to frame object
		frame.texture = texture
	end
	
	-- default to hidden
	frame:Hide()
	
	return frame
	
end


me.createscrollframe = function(parent, width, height)
	
	local frame = CreateFrame("ScrollFrame", nil, parent)
	
	-- size
	frame:SetHeight(height)	
	frame:SetWidth(width - 20)
	
	-- backdrop
	frame:SetBackdrop(me.framebackdrop)
	frame:SetBackdropColor(0.0, 0.0, 0.0, 0.0) 
	frame:SetBackdropBorderColor(1.0, 1.0, 1.0, 1.0) 
	
	-- slider (vertical)
	local slider = CreateFrame("Slider", nil, frame)
	frame.slider = slider
	
	-- size
	slider:SetWidth(20)
	slider:SetHeight(height - 40 + 2 * me.border)
	
	-- attach to frame
	slider:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, -20 + me.border)
	slider:SetPoint("BOTTOMLEFT", frame,  "BOTTOMRIGHT", 0, 20 - me.border)
	
	slider:SetBackdrop(me.sliderbackdrop)
	
	-- range
	slider:SetMinMaxValues(0, 100)
	slider:SetValueStep(1)
	
	-- thumb
	slider:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
	slider:GetThumbTexture():SetTexCoord(0, 1, 0.15, 0.85)
	
	-- scroll up button
	local buttonup = CreateFrame("Button", nil, frame)
	frame.buttonup = buttonup
	
	buttonup:SetWidth(20)
	buttonup:SetHeight(20)
	buttonup:SetPoint("BOTTOM", slider, "TOP", 0, -me.border)
	
	buttonup:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Up")
	buttonup:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Down")
	buttonup:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Disabled")
	buttonup:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollUpButton-Highlight")
	
	buttonup:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttonup:GetPushedTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttonup:GetDisabledTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttonup:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	
	-- scroll down button
	local buttondown = CreateFrame("Button", nil, frame)
	frame.buttondown = buttondown
	
	buttondown:SetWidth(20)
	buttondown:SetHeight(20)
	buttondown:SetPoint("TOP", slider, "BOTTOM", 0, me.border)
	
	buttondown:SetNormalTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Up")
	buttondown:SetPushedTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Down")
	buttondown:SetDisabledTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Disabled")
	buttondown:SetHighlightTexture("Interface\\Buttons\\UI-ScrollBar-ScrollDownButton-Highlight")
	
	buttondown:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttondown:GetPushedTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttondown:GetDisabledTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	buttondown:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
	
	-- click methods
	frame.onclick = function(direction)
		mod.print("clicked " .. direction)
	end
	
	buttonup:SetScript("OnClick", function()
		this:GetParent().onclick("up")
	end)
	
	buttondown:SetScript("OnClick", function()
		this:GetParent().onclick("down")
	end)
	
	return frame
	
end


--[[
------------------------------------------------------
						FontString
------------------------------------------------------
]]

-- This is e.g. "Fonts\\FRIZQT__.TFF" for en/us
me.fontfile = GameFontNormal:GetFont()

--[[
mod.gui.createfontstring(parentframe, fontsize)
	Makes a new fontstring object on the given frame.
	
<parentframe>	Frame; the owner of the label
<fontsize>		number; the pitch of the font

Return:			FontString; a reference to the created fontstring
]]
me.createfontstring = function(parentframe, fontsize)
	
	local fontstring = parentframe:CreateFontString()
	fontstring:SetFont(me.fontfile, fontsize)
	
	return fontstring
	
end

--[[
------------------------------------------------------
						Slider
------------------------------------------------------

This is basically a clone of OptionsSliderTemplate from (an old) OptionsFrame.xml, because the CreateFrame isn't working well when inheriting from a virtual template, since it requires a valid part of the global namespace, which we don't want to use.
]]

me.sliderbackdrop = 
{
	bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
	edgeFile="Interface\\Buttons\\UI-SliderBar-Border",
	tile = true,
	tileSize = 8,
	edgeSize = 8,
	insets = { left = 3, right = 3, top = 6, bottom = 6 },
}

--[[
mod.gui.createslider(parent, width, height, fontsize)
	Creates a generic Slider frame.
	
<parent>		Frame; window that owns the slider
<width>		number; width of the slider in screen units (~ pixels)
<height>		number; height of the slider in screen units (~ pixels)
<fontsize>	number; pitch of the labels for the slider

Return:		Slider; reference to the created object
]]
me.createslider = function(parent, width, height, fontsize)
	
	local slider = CreateFrame("Slider", nil, parent)
	
	-- size
	slider:SetWidth(width)
	slider:SetHeight(height)
	
	-- backdrop
	slider:SetBackdrop(me.sliderbackdrop)

	-- the thumb of the slider
	slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Horizontal")
	
	-- orientation
	slider:SetOrientation("HORIZONTAL")
	
	-- labels
	slider.low = me.createfontstring(slider, fontsize)
	slider.low:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 2, 3)
	
	slider.high = me.createfontstring(slider, fontsize)
	slider.high:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -2, 3)
	slider.high:SetWidth(slider:GetWidth())
	slider.high:SetJustifyH("RIGHT")
	
	slider.text = me.createfontstring(slider, fontsize)
	slider.text:SetPoint("BOTTOMLEFT", slider, "TOPLEFT", 2, 0)
	slider.text:SetTextColor(1.0, 1.0, 0)
	
	slider.value = me.createfontstring(slider, fontsize)
	slider.value:SetPoint("BOTTOMRIGHT", slider, "TOPRIGHT", -2, 0)
	slider.value:SetJustifyH("RIGHT")
	slider.value:SetWidth(slider:GetWidth())
	slider.value:SetTextColor(0.0, 1.0, 0)
	
	-- function to get the actual height
	slider.realheight = function()
		return slider.high:GetHeight() * 2 + slider:GetHeight()
	end
	
	return slider
	
end