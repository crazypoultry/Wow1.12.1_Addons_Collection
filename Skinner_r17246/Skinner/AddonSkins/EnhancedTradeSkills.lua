
function Skinner:EnhancedTradeSkills() 
	if not self.db.profile.TradeSkill then return end

	self:moveObject(_G["ETS_FILTERSONOFF"], "-", 20, nil, nil)
	
end

function Skinner:EnhancedTradeCrafts() 
	if not self.db.profile.CraftFrame then return end
	
	self:moveObject(_G["ETS_CFILTERSONOFF"], "-", 10, "-", 72)
	
end
