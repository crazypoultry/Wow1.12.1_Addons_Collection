
function Skinner:FramesResized_CraftUI()
	if not self.db.profile.CraftFrame then return end
	
	self:removeRegions(_G["CraftFrame_MidTextures"])
	self:removeRegions(_G["CraftListScrollFrame_MidTextures"])   
	
	self:moveObject(_G["CraftCreateButton"], nil, nil, "+", 20)
	self:moveObject(_G["CraftCancelButton"], nil, nil, "+", 20)
	
end
