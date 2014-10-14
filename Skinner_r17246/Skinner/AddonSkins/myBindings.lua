
function Skinner:myBindings()
	if not self.db.profile.MenuFrames then return end
	
	self:keepRegions(_G["myBindingsOptionsFrame"], {7, 8, 9, 10, 11, 12, 14}) -- N.B. regions 7 - 12, 14 are text
	
    _G["myBindingsOptionsFrame"]:SetHeight(_G["myBindingsOptionsFrame"]:GetHeight() - 15)

	self:removeRegions(_G["myBindingsOptionsHeadingsScrollFrame"])
	self:skinScrollBar(_G["myBindingsOptionsHeadingsScrollFrame"])
	self:removeRegions(_G["myBindingsOptionsBindingsScrollFrame"])
	self:skinScrollBar(_G["myBindingsOptionsBindingsScrollFrame"])
	
	for i = 1, 18 do
		self:removeRegions(_G["myBindingsOptionsBindCategory"..i], {1})
		self:applySkin(_G["myBindingsOptionsBindCategory"..i])
	end
	for i = 1, 18 do
		self:removeRegions(_G["myBindingsOptionsBindHeader"..i], {1})
		self:applySkin(_G["myBindingsOptionsBindHeader"..i])
	end
	
	self:moveObject(_G["myBindingsOptionsFrameOutputText"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameGameDefaultsButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameConfirmBindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameCancelBindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameUnbindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameOkayButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameCancelButton"], nil, nil, "-", 15)
	
	self:applySkin(_G["myBindingsOptionsFrame"], true)
	
end
