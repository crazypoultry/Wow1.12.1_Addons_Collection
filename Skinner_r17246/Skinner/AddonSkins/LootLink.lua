
function Skinner:LootLink() 

	self:hookDDScript(LootLinkFrameDropDownButton)
	self:hookDDScript(LLS_RarityDropDownButton)
	self:hookDDScript(LLS_BindsDropDownButton)
	self:hookDDScript(LLS_LocationDropDownButton)
	self:hookDDScript(LLS_TypeDropDownButton)
	self:hookDDScript(LLS_SubtypeDropDownButton)
	
	self:removeRegions(_G["LootLinkFrame"], {2, 3, 4, 5})

	_G["LootLinkFrame"]:SetWidth(_G["LootLinkFrame"]:GetWidth() - 30)
	_G["LootLinkFrame"]:SetHeight(_G["LootLinkFrame"]:GetHeight() - 70)

	self:moveObject(_G["LootLinkFrameCloseButton"], "+", 15, nil, nil)
	self:moveObject(_G["LootLinkTitleText"], "+", 15, nil, nil)

	self:removeRegions(_G["LootLinkListScrollFrame"])
	self:skinScrollBar(_G["LootLinkListScrollFrame"])

	self:skinTooltip(LootLinkTooltip)
	self:skinTooltip(LLHiddenTooltip)

	self:applySkin(_G["LootLinkFrame"], {2, 3, 4, 5})
	self:applySkin(_G["LootLinkSearchFrame"])

end
