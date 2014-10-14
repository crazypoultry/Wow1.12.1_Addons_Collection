
function Skinner:GFW_AutoCraft()
	if not self.db.profile.TradeSkill then return end

	_G["TradeSkillFrame"]:SetHeight(_G["TradeSkillFrame"]:GetHeight() + 40)
	self:removeRegions(_G["AutoCraftBackground"])

end
