----------------------------------------------------------------------------------------------------
-- FuBar 2 Plugin for Wardrobe-AL
-- Author: Nemes of Uldum
-- Date: 1/10/2006
--
-- 23/10/2006: Update to use AceLocale-2.2, from 2.0
----------------------------------------------------------------------------------------------------


-- do nothing if FuBar2 isn't present
if not FuBar2DB then return end


----------------------------------------------------------------------------------------------------


-- Initialise the localisations
local L = AceLibrary("AceLocale-2.2"):new("FuBar_WardrobeFu")


-- Initialise this plugin
WardrobeFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")


-- Load the tooltip display library
local T = AceLibrary("Tablet-2.0")


----------------------------------------------------------------------------------------------------


-- setup data storage
WardrobeFu:RegisterDB("Wardrobe_Config_FuBar")
WardrobeFu:RegisterDefaults('profile', {
	showMinimapIcon = false,
	showTextPrefix = true,
})


-- set plugin options
WardrobeFu.hasIcon = true
WardrobeFu.cannotDetachTooltip = true
WardrobeFu.cannotAttachToMinimap = true
WardrobeFu.defaultPosition = "RIGHT"


----------------------------------------------------------------------------------------------------


-- FuBar plugin init method
function WardrobeFu:OnInitialize()

	-- set the icon file and path
	self:SetIcon("Interface\\AddOns\\Wardrobe\\Images\\Wardrobe")

	-- register for GUI events
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
end


-- UNIT_INVENTORY_CHANGED event
function WardrobeFu:UNIT_INVENTORY_CHANGED()

	-- update the text on the panel
	Chronos.scheduleByName("WardrobeFuUpdate", .2, function() WardrobeFu:OnTextUpdate() end)
	
end


-- PLAYER_ENTERING_WORLD event
function WardrobeFu:PLAYER_ENTERING_WORLD()

	-- show or hide the minimap icon
	Wardrobe.enteredWorld = true
	Wardrobe.CheckForOurWardrobeID()
	WardrobeFu:UpdateMinimapIcon()
	
end


-- Update the text value to appear on the FuBar
function WardrobeFu:OnTextUpdate()

	-- get the list of outfits
	local outfitText = Wardrobe.GetActiveOutfitsTextList()
	
	-- prepend the label
	if (self.db.profile.showTextPrefix) then
		outfitText = L["Wardrobe: "]..outfitText
	end
	
	-- set the text
	self:SetText(outfitText)

end


-- Click on the plugin area
function WardrobeFu:OnClick(button)

	if ( button == "LeftButton" ) then
		-- show the wardrobe popup at the cursor
		WardrobeFu:ShowMenu()
	end
	
end


-- Show the wardrobe popup menu at the cursor
function WardrobeFu:ShowMenu()

	ToggleDropDownMenu(1, nil, WardrobeEquipDropDown, "cursor")

end


-- Tooltip update method
function WardrobeFu:OnTooltipUpdate()

	-- white text
	local cat = T:AddCategory('child_textR', 1,
							  'child_textG', 1,
							  'child_textB', 1)
	cat:AddLine('text', L["Select your outfit or configure Wardrobe"])

end


-- Show or hide the minimap icon
function WardrobeFu:UpdateMinimapIcon()

	if (self.db.profile.showMinimapIcon) then
		-- show the button
		Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
		Wardrobe_IconFrame:Show();
	else
		-- hide the button
		Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 0;
		Wardrobe_IconFrame:Hide();
	end
	
end


-- showMinimapIcon get
function WardrobeFu:GetShowMinimapIcon()
	return self.db.profile.showMinimapIcon
end


-- showMinimapIcon toggle
function WardrobeFu:ToggleShowMinimapIcon()

	-- toggle the value
	self.db.profile.showMinimapIcon = not self.db.profile.showMinimapIcon
	
	-- show or hide the icon
	WardrobeFu:UpdateMinimapIcon()

	-- return the value
	return self.db.profile.showMinimapIcon
end


-- showTextPrefix get
function WardrobeFu:GetShowTextPrefix()
	return self.db.profile.showTextPrefix
end


-- showTextPrefix toggle
function WardrobeFu:TogglesShowTextPrefix()

	-- toggle the value
	self.db.profile.showTextPrefix = not self.db.profile.showTextPrefix
	
	-- update the display
	self:Update()
	
	-- return the value
	return self.db.profile.showTextPrefix
end


----------------------------------------------------------------------------------------------------


-- Menu table
local optionsTable = {
	handler = WardrobeFu,
	type = 'group',
	args = {
		toggleShowMinimapIcon = {
			type = 'toggle',
			name = L["Show Minimap Icon"],
			desc = L["Show or Hide the standard Wardrobe minimap icon"],
			get = "GetShowMinimapIcon",
			set = "ToggleShowMinimapIcon",
		},
		toggleShowTextPrefix = {
			type = 'toggle',
			name = L["Show Text Prefix"],
			desc = L["Show or Hide the Wardrobe: prefix"],
			get = "GetShowTextPrefix",
			set = "TogglesShowTextPrefix",
		},
	}
}
WardrobeFu.OnMenuRequest = optionsTable