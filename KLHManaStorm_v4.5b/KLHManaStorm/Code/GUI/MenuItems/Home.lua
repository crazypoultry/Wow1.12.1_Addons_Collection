
-- module setup
local me = { name = "menuhome"}
local mod = thismod
mod[me.name] = me

--[[
Menu\Home.lua

This is the section you see when the menu is first shown. It gives a brief explanation of what's going on. It is also the root node of the menu tree, so has special properties. The name must be "top", which can't be used by other sections.
]]

me.onload = function()

	-- create the top frame
	me.frame = mod.gui.createframe(400, 300)
	
	local label = mod.gui.createfontstring(me.frame, 15)
	label:SetPoint("TOPLEFT", mod.gui.textinset, -mod.gui.textinset)
	
	label:SetNonSpaceWrap(true)
	label:SetJustifyH("LEFT")
	label:SetJustifyV("TOP")
	
	label:SetText(string.format(mod.string.get("menu", "top", "text"), mod.global.name, mod.release, mod.revision))
	
	label:SetWidth(me.frame:GetWidth() - 2 * mod.gui.textinset)
	
	-- add to frame
	me.frame.label = label
	
	-- Now size the frame to the string
	me.frame:SetHeight(mod.gui.textinset * 2 + label:GetHeight() + 2 * mod.gui.border)
	me.frame.texture:SetHeight(me.frame:GetHeight() - 2 * mod.gui.border)
	
	-- add a close button
	local button = CreateFrame("Button", nil, me.frame)
	
	-- size
	button:SetHeight(20)
	button:SetWidth(20)
	
	button:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	button:GetNormalTexture():SetTexCoord(0.175, 0.825, 0.175, 0.825)
	
	button:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	button:GetPushedTexture():SetTexCoord(0.175, 0.825, 0.175, 0.825)
	
	button:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	button:GetHighlightTexture():SetBlendMode("ADD")
	
	-- location (bottom right)
	button:SetPoint("TOPRIGHT", me.frame, -mod.gui.textinset, -mod.gui.textinset)
	
	-- click handlers:
	button:SetScript("OnMouseDown", mod.menu.hide)
	
	-- add to frame
	me.frame.button = button
	
	-- add frame to the sections list
	mod.menu.registersection("top", nil, mod.string.get("menu", "top", "description"), me.frame)
	
end