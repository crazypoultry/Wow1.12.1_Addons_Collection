
function Skinner:FilterTradeSkill()
	if not self.db.profile.TradeSkill then return end

	self:Hook(FilterTradeSkill, "Resize", function(newsize)
		self.hooks[FilterTradeSkill].Resize(newsize)
		TradeSkillFrame:SetHeight(TradeSkillFrame:GetHeight() - 70)
		end)
		
	self:hookDDScript(FilterTradeSkillDropDownButton)
	
	self:keepRegions(FilterTradeSkillDropDown, {4})
	self:moveObject(FilterTradeSkillDropDown, "-", 8, "-", 3)
	self:keepRegions(FilterTradeSkill, {})
	self:moveObject(FilterTradeSkillEditBox, "+", 18, "+", 5)
	self:skinEditBox(FilterTradeSkillEditBox, {})
	self:keepRegions(FilterTradeSkillConfigFrame, {11})
	self:applySkin(FilterTradeSkillConfigFrame, true)
	
	TradeSkillFrame:EnableDrawLayer("BORDER")
	TradeSkillFrame:SetWidth(TradeSkillFrame:GetWidth() + 18)
	TradeSkillFrame:SetHeight(TradeSkillFrame:GetHeight() + 10)
	FilterTradeSkill:Resize(8)

end
