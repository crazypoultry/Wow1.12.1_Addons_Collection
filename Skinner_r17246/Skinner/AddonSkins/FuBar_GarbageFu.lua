
function Skinner:FuBar_GarbageFu()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["GarbageFu_SellItemButton"], nil, nil, "+", 28)

end
