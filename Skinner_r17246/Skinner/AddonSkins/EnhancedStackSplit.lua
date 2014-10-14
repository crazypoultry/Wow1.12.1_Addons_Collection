
function Skinner:EnhancedStackSplit()
	if not self.db.profile.StackSplit then return end

	_G["StackSplitFrame"]:SetHeight(_G["StackSplitFrame"]:GetHeight() + 40)

	self:moveObject(_G["StackSplitText"], nil, nil, "+", 20)	
	self:moveObject(_G["StackSplitLeftButton"], "+", 5, "+", 20)	
	self:moveObject(_G["StackSplitRightButton"], "-", 5, "+", 20)	
	self:moveObject(_G["StackSplitOkayButton"], nil, nil, "+", 36)	
	self:moveObject(_G["StackSplitCancelButton"], nil, nil, "+", 36)	

	self:removeRegions(_G["EnhancedStackSplitFrame"], {1})

	for i = 1, 6 do
		self:moveObject(_G["EnhancedStackSplitButton"..i], "-", 6, "+", 24)	
	end

	self:moveObject(_G["EnhancedStackSplitMaxTextFrame"], nil, nil, "+", 20)
	self:moveObject(_G["EnhancedStackSplitModeTXTButton"], "-", 5, "+", 22)
	
end
