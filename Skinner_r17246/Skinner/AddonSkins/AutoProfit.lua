
function Skinner:AutoProfit()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["TreasureModel"], nil, nil, "+", 28)
	self:moveObject(_G["AutosellButton"], nil, nil, "+", 28)

end

