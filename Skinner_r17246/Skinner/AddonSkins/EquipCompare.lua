
function Skinner:EquipCompare()
	if not self.db.profile.Tooltips.shown then return end

	self:skinTooltip(_G["ComparisonTooltip1"])
	self:skinTooltip(_G["ComparisonTooltip2"])
	
end
