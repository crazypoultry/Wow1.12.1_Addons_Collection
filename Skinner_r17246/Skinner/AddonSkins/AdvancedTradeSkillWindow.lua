
function Skinner:AdvancedTradeSkillWindow()
	if not self.db.profile.TradeSkill then return end

	self:hookDDScript(_G["ATSWInvSlotDropDownButton"])
	self:hookDDScript(_G["ATSWSubClassDropDownButton"])

	self:keepRegions(_G["ATSWFrame"], {8, 15, 16, 17, 18, 21, 22, 23}) -- N.B. these regions are text
	_G["ATSWFrame"]:SetWidth(_G["ATSWFrame"]:GetWidth() -30)
	self:moveObject(_G["ATSWFrameTitleText"], nil, nil, "+", 8)
	self:moveObject(_G["ATSWFrameCloseButton"], "+", 28, "+", 8)
	self:keepRegions(_G["ATSWRankFrame"], {1, 2}) -- N.B. other regions are text
	self:removeRegions(_G["ATSWRankFrameBorder"])
	self:moveObject(_G["ATSWRankFrame"], "+", 4, "+", 5)
	self:glazeStatusBar(_G["ATSWRankFrame"], 0)
	self:removeRegions(_G["ATSWListScrollFrame"])
	self:skinScrollBar(_G["ATSWListScrollFrame"])
	self:removeRegions(_G["ATSWExpandButtonFrame"])
	self:removeRegions(_G["ATSWInvSlotDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["ATSWSubClassDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["ATSWQueueScrollFrame"])
	self:skinScrollBar(_G["ATSWQueueScrollFrame"])
	self:applySkin(_G["ATSWFrame"])
	
	-- Reagent Frame
	self:removeRegions(_G["ATSWReagentFrame"], {1, 2, 3, 4}) -- N.B. other regions are text
	_G["ATSWReagentFrame"]:SetWidth(_G["ATSWReagentFrame"]:GetWidth() * FxMult + 20)
	_G["ATSWReagentFrame"]:SetHeight(_G["ATSWReagentFrame"]:GetHeight() * FyMult + 10)
	self:moveObject(_G["ATSWReagentFrameCloseButton"], "+", 28, "+", 8)
	self:applySkin(_G["ATSWReagentFrame"])
	
	-- Options Frame
	_G["ATSWOptionsFrame"]:SetWidth(_G["ATSWOptionsFrame"]:GetWidth() * FxMult + 30)
	_G["ATSWOptionsFrame"]:SetHeight(_G["ATSWOptionsFrame"]:GetHeight() * FyMult)
	self:applySkin(_G["ATSWOptionsFrame"])
	
	-- Continue Frame
	self:applySkin(_G["ATSWContinueFrame"])
	
	-- Tooltip 
	self:skinTooltip(_G["ATSWTradeskillTooltip"])

	-- AutoBuyButton Frame
	self:applySkin(_G["ATSWAutoBuyButtonFrame"])
	
	-- Shopping List Frame
	self:removeRegions(_G["ATSWShoppingListFrame"], {1, 2}) -- N.B. other regions is/are text
	_G["ATSWShoppingListFrame"]:SetWidth(_G["ATSWShoppingListFrame"]:GetWidth() * FxMult + 20)
	_G["ATSWShoppingListFrame"]:SetHeight(_G["ATSWShoppingListFrame"]:GetHeight() * FyMult - 20)
	self:removeRegions(_G["ATSWSLScrollFrame"])
	self:skinScrollBar(_G["ATSWSLScrollFrame"])
	self:applySkin(_G["ATSWShoppingListFrame"])
	
	-- Custom Sorting Frame
	self:keepRegions(_G["ATSWCSFrame"], {8, 9, 10}) -- N.B. regions 8-10 are text
	_G["ATSWCSFrame"]:SetWidth(_G["ATSWFrame"]:GetWidth())
	self:moveObject(_G["ATSWCSFrameCloseButton"], "+", 28, "+", 8)
	self:removeRegions(_G["ATSWCSUListScrollFrame"])
	self:skinScrollBar(_G["ATSWCSUListScrollFrame"])
	self:removeRegions(_G["ATSWCSSListScrollFrame"])
	self:skinScrollBar(_G["ATSWCSSListScrollFrame"])
	self:applySkin(_G["ATSWCSFrame"])
	
end
