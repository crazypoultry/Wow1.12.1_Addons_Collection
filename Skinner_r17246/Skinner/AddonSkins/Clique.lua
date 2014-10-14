
function Skinner:Clique()
	if not self.db.profile.SpellBookFrame then return end
	
	self:hookDDScript(CliqueDropDownButton)

	self:keepRegions(CliqueTutorial, {10})
	self:applySkin(CliqueTutorial, nil)
	self:keepRegions(CliqueListScroll, {})
	self:skinScrollBar(CliqueListScroll)

	for i = 1, 6 do
		_G["CliqueList"..i.."Binding"]:SetTextColor(self.db.profile.BodyText.r, self.db.profile.BodyText.g, self.db.profile.BodyText.b)
		_G["CliqueList"..i.."Rank"]:SetTextColor(self.db.profile.BodyText.r, self.db.profile.BodyText.g, self.db.profile.BodyText.b)
	end

	self:keepRegions(CliqueDropDown, {4,5})
	self:keepRegions(CliqueIconScrollFrame, {})
	self:skinScrollBar(CliqueIconScrollFrame)
	self:keepRegions(CliqueIconSelectFrame, {1})
	self:applySkin(CliqueIconSelectFrame, nil)

	CliqueNameEditBox:SetWidth(CliqueNameEditBox:GetWidth() - 12)
	self:skinEditBox(CliqueNameEditBox, {6})
	self:skinEditBox(CliqueEditBox, nil, true)

	self:keepRegions(CliqueEditScrollFrame, {})
	CliqueEditScrollFrame:SetWidth(CliqueEditScrollFrame:GetWidth() - 8)
	CliqueEditScrollFrame:SetHeight(CliqueEditScrollFrame:GetHeight() - 15)
	self:skinScrollBar(CliqueEditScrollFrame)

	CliqueTextEditBox:SetWidth(CliqueTextEditBox:GetWidth() - 8)
	CliqueTextEditBox:SetHeight(CliqueTextEditBox:GetHeight() - 15)

	self:keepRegions(CliqueEditFrame, {1})
	CliqueEditFrame:SetHeight(CliqueEditFrame:GetHeight() - 30)
	CliqueEditHint:SetTextColor(self.db.profile.BodyText.r, self.db.profile.BodyText.g, self.db.profile.BodyText.b)
	self:applySkin(CliqueEditFrame, nil)

	self:removeRegions(CliquePulloutTab, {1})
	CliquePulloutTab:SetWidth(CliquePulloutTab:GetWidth() * 1.25)
	CliquePulloutTab:SetHeight(CliquePulloutTab:GetHeight() * 1.25)
	if self.db.profile.TexturedTab then self:applySkin(CliquePulloutTab, nil, 0) else self:applySkin(CliquePulloutTab) end
	
	CliqueBackdropLeft:Hide()
	CliqueBackdropRight:Hide()
	self:keepRegions(CliqueFrame, {})
	self:applySkin(CliqueFrame, nil)
	
end
