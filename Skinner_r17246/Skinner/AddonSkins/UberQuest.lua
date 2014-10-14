
function Skinner:UberQuest()
	if not self.db.profile.QuestLog then return end

	-- Hook this to update Quest Text colours (MUST use SecureHook otherwise scroll frame breaks) 
	self:SecureHook(UberQuest_Details_Scroll, "UpdateScrollChildRect", function()
		-- self:Debug("UberQuest_Details_Scroll - UpdateScrollChildRect")
		_G["UberQuest_Details_ScrollChild_QuestTitle"]:SetTextColor(HTr, HTg, HTb)
		_G["UberQuest_Details_ScrollChild_ObjectivesText"]:SetTextColor(BTr, BTg, BTb)
		_G["UberQuest_Details_ScrollChild_TimerText"]:SetTextColor(HTr, HTg, HTb)
		for i = 1, 10 do
    	  local r, g, b, a = _G["UberQuest_Details_ScrollChild_Objective"..i]:GetTextColor()
    	  _G["UberQuest_Details_ScrollChild_Objective"..i]:SetTextColor(BTr - r, BTg - g, BTb)
    	end
    	local r, g, b, a = _G["UberQuest_Details_ScrollChild_RequiredMoneyText"]:GetTextColor()
		_G["UberQuest_Details_ScrollChild_DescriptionTitle"]:SetTextColor(HTr, HTg, HTb)
		_G["UberQuest_Details_ScrollChild_QuestDescription"]:SetTextColor(BTr, BTg, BTb)
    	_G["UberQuest_Details_ScrollChild_RequiredMoneyText"]:SetTextColor(BTr - r, BTg - g, BTb)
    	_G["UberQuest_Details_ScrollChild_RewardTitleText"]:SetTextColor(HTr, HTg, HTb)
    	_G["UberQuest_Details_ScrollChild_ItemChooseText"]:SetTextColor(BTr, BTg, BTb)
    	_G["UberQuest_Details_ScrollChild_ItemReceiveText"]:SetTextColor(BTr, BTg, BTb)
		end)
	
	-- Quest List Frame
	self:keepRegions(_G["UberQuest_List"], {1, 10}) -- N.B. region 1 & 10 are text
	_G["UberQuest_List"]:SetWidth(_G["UberQuest_List"]:GetWidth() * FxMult)
	_G["UberQuest_List"]:SetHeight(_G["UberQuest_List"]:GetHeight() * FyMult)

	self:moveObject(_G["UberQuest_List_Title"], nil, nil, "+", 12)
	self:moveObject(_G["UberQuest_List_QuestCount"], nil, nil, "+", 20)
	self:moveObject(_G["UberQuest_List_CloseButton"], "+", 30, "+", 8)
	self:moveObject(_G["UberQuest_List_AbandonButton"], "-", 12, "-", 70)
	self:moveObject(_G["UberQuest_List_ConfigButton"], "-", 20, "+", 10)
	self:moveObject(_G["UberQuest_List_CloseButton2"], "+", 32, "-", 70)
	self:removeRegions(_G["UberQuest_List_Scroll"])
	self:skinScrollBar(_G["UberQuest_List_Scroll"])
	-- movement values
	local xOfs, yOfs = 8, 6
--	UberQuest__HighlightFrame
	self:moveObject(_G["UberQuest_List_Title1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["UberQuest_List_Scroll"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["UberQuest_List_ExpandButtonFrame"], "-", xOfs, "+", yOfs)
	self:keepRegions(_G["UberQuest_List_ExpandButtonFrame_CollapseAllButton"], {4, 6}) -- N.B. region 4 is button, 6 is text
	self:applySkin(_G["UberQuest_List"])

	-- Details Frame
	self:keepRegions(_G["UberQuest_Details"], {1, 10}) -- N.B. region 1 & 10 are text
	_G["UberQuest_Details"]:SetWidth(_G["UberQuest_Details"]:GetWidth() * FxMult)
	_G["UberQuest_Details"]:SetHeight(_G["UberQuest_Details"]:GetHeight() * FyMult)
	self:moveObject(_G["UberQuest_Details"], "+", 46, "-", 6)
	self:moveObject(_G["UberQuest_Details_Title"], nil, nil, "+", 14)
	self:moveObject(_G["UberQuest_Details_CloseButton"], "+", 26, "+", 14)
	self:moveObject(_G["UberQuest_Details_Exit"], "+", 32, "-", 66)
	self:moveObject(_G["UberQuest_Details_Scroll"], "-", 8, "+", 28)
	self:skinScrollBar(_G["UberQuest_Details_Scroll"])
	_G["UberQuest_Details_ScrollChild_QuestTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["UberQuest_Details_ScrollChild_ObjectivesText"]:SetTextColor(BTr, BTg, BTb)
	_G["UberQuest_Details_ScrollChild_TimerText"]:SetTextColor(HTr, HTg, HTb)
	for i = 1, 10 do
   		local r, g, b, a = _G["UberQuest_Details_ScrollChild_Objective"..i]:GetTextColor()
   		_G["UberQuest_Details_ScrollChild_Objective"..i]:SetTextColor(BTr - r, BTg - g, BTb)
   	end
   	local r, g, b, a = _G["UberQuest_Details_ScrollChild_RequiredMoneyText"]:GetTextColor()
   	_G["UberQuest_Details_ScrollChild_RequiredMoneyText"]:SetTextColor(BTr - r, BTg - g, BTb)
	_G["UberQuest_Details_ScrollChild_DescriptionTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["UberQuest_Details_ScrollChild_QuestDescription"]:SetTextColor(BTr, BTg, BTb)
   	_G["UberQuest_Details_ScrollChild_RewardTitleText"]:SetTextColor(HTr, HTg, HTb)
   	_G["UberQuest_Details_ScrollChild_ItemChooseText"]:SetTextColor(BTr, BTg, BTb)
   	_G["UberQuest_Details_ScrollChild_ItemReceiveText"]:SetTextColor(BTr, BTg, BTb)
	self:applySkin(_G["UberQuest_Details"])
	
	-- Config Frame
	self:moveObject(_G["UberQuest_ConfigFrame"], "+", 36, "-", 6)
	_G["UberQuest_ConfigFrame"]:SetWidth(_G["UberQuest_ConfigFrame"]:GetWidth() + 10)
	_G["UberQuest_ConfigFrameBackdrop"]:Hide()
	self:moveObject(_G["UberQuest_ConfigFrame_ResetMinion"], "-", 5, nil, nil)
	self:moveObject(_G["UberQuest_ConfigFrame_CloseButton"], "+", 5, nil, nil)
	self:applySkin(_G["UberQuest_ConfigFrame"])
	
	-- Minion Frame
	_G["UberQuest_MinionBackdrop"]:Hide()
	self:applySkin(_G["UberQuest_Minion"])
	
end
