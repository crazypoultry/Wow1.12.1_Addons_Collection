
function Skinner:FramesResized_TradeSkillUI()
	if not self.db.profile.TradeSkill then return end

	self:removeRegions(_G["TradeSkillFrame_MidTextures"])
	self:removeRegions(_G["TradeSkillListScrollFrame_MidTextures"])   
	
	self:removeRegions(_G["TradeSkillDetailScrollFrame"])
	self:moveObject(_G["TradeSkillDetailScrollFrame"], "-", 5, nil, nil)
	self:skinScrollBar(_G["TradeSkillDetailScrollFrame"])
	
	self:moveObject(_G["TradeSkillCreateButton"], nil, nil, "+", 20)
	self:moveObject(_G["TradeSkillCancelButton"], nil, nil, "+", 20)
	
end
