
function Skinner:AxuItemMenus()
	if not self.db.profile.Tooltips.shown then return end

	self:skinTooltip(_G["ItemMenuTooltip"])
	
end
