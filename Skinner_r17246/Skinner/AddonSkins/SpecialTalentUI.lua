
function Skinner:SpecialTalentUI()

	self:keepRegions(SpecialTalentFrame, {14,15,16,17,18,19,20})
	SpecialTalentFrame:SetWidth(SpecialTalentFrame:GetWidth() * FxMult + 70)
	SpecialTalentFrame:SetHeight(SpecialTalentFrame:GetHeight() * FyMult + 40)
	self:moveObject(SpecialTalentFrameCloseButton, "+", 28, "+", 8)
	self:applySkin(SpecialTalentFrame, nil)

end
