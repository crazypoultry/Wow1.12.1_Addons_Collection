
function Skinner:Outfitter()
	if not self.db.profile.CharacterFrames then return end

	self:Hook("Outfitter_ShowPanel", function(tabId)
		-- self:Debug("Outfitter_ShowPanel: [%s]", tabId)
		self.hooks.Outfitter_ShowPanel(tabId)
		for i = 1, OutfitterFrame.numTabs do
			if i == tabId then
				self:setActiveTab("OutfitterFrameTab"..i)
			else
				self:setInactiveTab("OutfitterFrameTab"..i)
			end
		end
		end)

	self:Hook("OutfitterItemDropDown_Initialize", function()
		-- self:Debug("OutfitterItemDropDown_Initialize")
		self.hooks.OutfitterItemDropDown_Initialize()
		self:skinDropDownLists()
		end)
	
	self:HookScript(OutfitterMinimapButton, "OnMouseUp", function()
		-- self:Debug("OutfitterMinimapButton_OnMouseUp")
		self.hooks[OutfitterMinimapButton].OnMouseUp()
		self:skinDropDownLists()
		end)

	self:Hook("OutfitterStatDropdown_Initialize", function()
		-- self:Debug("OutfitterStatDropdown_Initialize")
		self.hooks.OutfitterStatDropdown_Initialize()
		self:skinDropDownLists()
		end)
	
	self:moveObject(_G["OutfitterButton"], nil, nil, "+", 30)
	
	self:keepRegions(_G["OutfitterFrame"], {3}) -- N.B. region 3 is text
	self:moveObject(_G["OutfitterFrame"], "+", 28, nil, nil)
	self:moveObject(_G["OutfitterCloseButton"], "-", 4, "-", 4)
	self:applySkin(_G["OutfitterFrame"])
	
	self:keepRegions(_G["OutfitterMainFrame"], {2, 3}) -- N.B. region 2 is text, 3 is icon
	self:removeRegions(_G["OutfitterMainFrameScrollbarTrench"])
	self:removeRegions(_G["OutfitterMainFrameScrollFrame"])
	self:skinScrollBar(_G["OutfitterMainFrameScrollFrame"])
	
	--	Outfitter Tabs
	for i = 1, OutfitterFrame.numTabs do

    	local tabName = _G["OutfitterFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		-- nil out the OnShow script to stop the tabs being resized
		tabName:SetScript("OnShow", nil)
		tabName:SetWidth(tabName:GetTextWidth() + 30)
		_G[tabName:GetName().."HighlightTexture"]:SetWidth(tabName:GetTextWidth() + 30)


        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0, 1)
		else self:applySkin(tabName) end
	
		if i == 1 then
			self:moveObject(tabName, "-", 0, "+", 4)
			self:setActiveTab(tabName:GetName())
		else
			self:moveObject(tabName, "-", 10, nil, nil)
			self:setInactiveTab(tabName:GetName())
		end
		
	end
	
	-- New Outfit
	self:keepRegions(_G["OutfitterNameOutfitDialog"], {11}) -- N.B. regions 2 & 3 are text
	self:moveObject(_G["OutfitterNameOutfitDialogTitle"], nil, nil, "_", 6)
	self:removeRegions(_G["OutfitterNameOutfitDialogCreateUsing"], {1, 2, 3}) -- N.B. region 4 is text
	self:applySkin(_G["OutfitterNameOutfitDialog"])
		
end
