
function Skinner:OneBag()
	if not self.db.profile.ContainerFrames or self.initialized.OneBag then return end
	self.initialized.OneBag = true

	self:applySkin(_G["OneBagFrame"], nil, nil, _G["OneBag"].db.profile.colors.bground.a, 200)
	if _G["OneRingFrame"] then self:applySkin(_G["OneRingFrame"], nil, nil, _G["OneRing"].db.profile.colors.bground.a, 100) end
	if _G["OneViewFrame"] then self:applySkin(_G["OneViewFrame"], nil, nil, _G["OneView"].db.profile.colors.bground.a, 200) end

end
