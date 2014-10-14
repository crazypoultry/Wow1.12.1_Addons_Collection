
function Skinner:OneBank()
	if not self.db.profile.BankFrame or self.initialized.OneBank then return end
	self.initialized.OneBank = true

	self:applySkin(_G["OneBankFrame"], nil, nil, _G["OneBank"].db.profile.colors.bground.a, 300) 

end
