
function Skinner:EQL3()
	if not self.db.profile.QuestLog or self.initialized.QuestLog then return end
	self.initialized.QuestLog = true
	
	self:Hook("QuestLog_UpdateQuestDetails", function(doNotScroll)
--		self:Debug("QuestLog_UpdateQuestDetails")
		self.hooks.QuestLog_UpdateQuestDetails(doNotScroll)
		for i = 1, 10 do
		    local r, g, b, a = _G["EQL3_QuestLogObjective"..i]:GetTextColor()
		    _G["EQL3_QuestLogObjective"..i]:SetTextColor(BTr - r, BTg - g, BTb)
		end
		local r, g, b, a = _G["EQL3_QuestLogRequiredMoneyText"]:GetTextColor()
		_G["EQL3_QuestLogRequiredMoneyText"]:SetTextColor(BTr - r, BTg - g, BTb)
		_G["EQL3_QuestLogRewardTitleText"]:SetTextColor(HTr, HTg, HTb)
		_G["EQL3_QuestLogItemChooseText"]:SetTextColor(BTr, BTg, BTb)
		_G["EQL3_QuestLogItemReceiveText"]:SetTextColor(BTr, BTg, BTb)
		end)
	
	self:removeRegions(_G["EQL3_QuestLogFrame"])
	self:removeRegions(_G["EQL3_QuestLogFrame_Description"])
	self:keepRegions(_G["EQL3_QuestLogFrame_Details"], {1,2,6})
	self:removeRegions(_G["EQL3_QuestFrameOptionsButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestFramePushQuestButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestLogFrameAbandonButton"],{2,4})
	self:removeRegions(_G["EQL3_QuestLogDetailScrollFrame"])
	
	self:moveObject(_G["EQL3_QuestLogFrameCloseButton"], "+", 25, nil, nil)
	self:moveObject(_G["EQL3_QuestLogFrameAbandonButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestFramePushQuestButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestFrameOptionsButtonText"], nil, nil, "+", 2)
	self:moveObject(_G["EQL3_QuestLogDetailScrollFrame"], "+", 40, nil, nil)
	
	_G["EQL3_QuestLogFrame_Description"]:SetWidth(_G["EQL3_QuestLogFrame_Description"]:GetWidth() + 40)
	_G["EQL3_QuestLogFrame"]:SetWidth(_G["EQL3_QuestLogFrame"]:GetWidth() - 20)
	
	_G["EQL3_QuestLogTitleText"]:ClearAllPoints()
	_G["EQL3_QuestLogTitleText"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogFrame"], "TOPLEFT", 15, -10)
	
	_G["EQL3_QuestLogVersionText"]:ClearAllPoints()
	_G["EQL3_QuestLogVersionText"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogTitleText"], "TOPRIGHT", -100, 0)
	
	_G["EQL3_QuestLogQuestCount"]:ClearAllPoints()
	_G["EQL3_QuestLogQuestCount"]:SetPoint("TOPLEFT", _G["EQL3_QuestLogTrackTitle"], "TOPRIGHT", 40, 0)
	
	
	_G["EQL3_QuestLogQuestTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["EQL3_QuestLogObjectivesText"]:SetTextColor(BTr, BTg, BTb)
	_G["EQL3_QuestLogDescriptionTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["EQL3_QuestLogQuestDescription"]:SetTextColor(BTr, BTg, BTb)
	
	self:skinScrollBar(_G["EQL3_QuestLogListScrollFrame"])
	self:skinScrollBar(_G["EQL3_QuestLogDetailScrollFrame"])
	
	self:applySkin(_G["EQL3_QuestLogFrame"])
	self:applySkin(_G["EQL3_QuestFrameOptionsButton"])
	self:applySkin(_G["EQL3_QuestFramePushQuestButton"])
	self:applySkin(_G["EQL3_QuestLogFrameAbandonButton"])
	self:applySkin(_G["EQL3_QuestLogFrame_Description"])
	
    self:removeRegions(_G["EQL3_OptionsFrame"], {1}) --  region 2 is the title
    self:removeRegions(_G["EQL3_OptionsFrame_Button_RestoreColors"],{2,4})
    self:removeRegions(_G["EQL3_OptionsFrame_Button_RestoreTracker"],{2,4})
    self:removeRegions(_G["EQL3_OptionsFrame_Button_QuestLog"],{2,4})
    
    self:applySkin(_G["EQL3_OptionsFrame"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_RestoreColors"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_RestoreTracker"])
    self:applySkin(_G["EQL3_OptionsFrame_Button_QuestLog"])
    
end
