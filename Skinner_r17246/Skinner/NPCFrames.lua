
function Skinner:merchantFrames()
	if not self.db.profile.MerchantFrames or self.initialized.MerchantFrames then return end
	self.initialized.MerchantFrames = true

    if self.db.profile.TexturedTab then
        -- hook this to update tabs
    	self:Hook("MerchantFrame_Update", function()
--  		self:Debug("MerchantFrame_Update: [%s]", PanelTemplates_GetSelectedTab(_G["MerchantFrame"]))
    		self.hooks.MerchantFrame_Update()
    		for i = 1, _G["MerchantFrame"].numTabs do
    			local tabName = _G["MerchantFrameTab"..i]
    			if i == _G["MerchantFrame"].selectedTab then 
       				self:setActiveTab(tabName:GetName()) 
    			else
       				self:setInactiveTab(tabName:GetName()) 
    			end
    		end
    		end)
    end
    
	self:keepRegions(_G["MerchantFrame"], {6, 7, 8}) -- N.B. regions 6-8 are text

	_G["MerchantFrame"]:SetWidth(_G["MerchantFrame"]:GetWidth() * FxMult)
	_G["MerchantFrame"]:SetHeight(_G["MerchantFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["MerchantNameText"], nil, nil, "+", 6)
	self:moveObject(_G["MerchantFrameCloseButton"], "+", 28, "+", 8)

	self:moveObject(_G["MerchantItem1"], "-", 6, "+", 30)

	self:moveObject(_G["MerchantPageText"], "+", 12, "-", 59)
	self:moveObject(_G["MerchantPrevPageButton"], "-", 5, "-", 60)
	self:moveObject(_G["MerchantNextPageButton"], "-", 5, "-", 60)

	self:moveObject(_G["MerchantRepairText"], nil, nil, "-", 58)
	self:moveObject(_G["MerchantRepairAllButton"], nil, nil, "-", 58)
	self:moveObject(_G["MerchantBuyBackItem"], nil, nil, "-", 5)
	self:moveObject(_G["MerchantMoneyFrame"], "+", 30, "-", 58)


	for i = 1, _G["MerchantFrame"].numTabs do
		local tabName = _G["MerchantFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is text, 8 is highlight
        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0)
        else self:applySkin( _G["MerchantFrameTab"..i]) end 		
        if i == 1 then
			self:moveObject(tabName, nil, nil, "-", 55)
			if self.db.profile.TexturedTab then self:setActiveTab(tabName:GetName()) end 
		else
			self:moveObject(tabName, "+", 12, nil, nil)
			if self.db.profile.TexturedTab then self:setInactiveTab(tabName:GetName()) end
		end
	end

	self:applySkin( _G["MerchantFrame"])

end

function Skinner:GossipFrame()
	if not self.db.profile.GossipFrame or self.initialized.GossipFrame then return end
	self.initialized.GossipFrame = true
	
	self:removeRegions(_G["GossipFrame"])
	
	_G["GossipFrame"]:SetWidth(_G["GossipFrame"]:GetWidth() * FxMult)
	_G["GossipFrame"]:SetHeight(_G["GossipFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["GossipFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["GossipFrameCloseButton"], "+", 24, "+", 12)
	self:removeRegions(_G["GossipFrameGreetingPanel"])
	self:moveObject(_G["GossipFrameGreetingGoodbyeButton"], "+", 28, "-", 64)

	_G["GossipGreetingText"]:SetTextColor(HTr, HTg, HTb)

	for i = 1, NUMGOSSIPBUTTONS do
		_G["GossipTitleButton"..i]:SetTextColor(BTr, BTg, BTb)
	end 

	self:moveObject(_G["GossipGreetingScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["GossipGreetingScrollFrame"])
	
	self:applySkin(_G["GossipFrame"])

end

function Skinner:ClassTrainer()
	if not self.db.profile.ClassTrainer or self.initialized.ClassTrainer then return end
	self.initialized.ClassTrainer = true

	self:hookDDScript(ClassTrainerFrameFilterDropDownButton)	
	
	self:keepRegions(_G["ClassTrainerFrame"], {6, 7}) -- N.B. 6 & 7 are text regions
	
	_G["ClassTrainerFrame"]:SetWidth(_G["ClassTrainerFrame"]:GetWidth()* FxMult)
	_G["ClassTrainerFrame"]:SetHeight(_G["ClassTrainerFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["ClassTrainerNameText"], nil, nil, "+", 6)
	self:moveObject(_G["ClassTrainerGreetingText"], "-", 35, nil, nil)
	self:moveObject(_G["ClassTrainerFrameCloseButton"], "+", 28, "+", 8)

	self:removeRegions(_G["ClassTrainerExpandButtonFrame"])
	self:moveObject(_G["ClassTrainerExpandButtonFrame"], nil, nil, "+", 10)

	self:keepRegions(_G["ClassTrainerFrameFilterDropDown"], {4}) -- N.B. 4 is the text region
	self:moveObject(_G["ClassTrainerFrameFilterDropDown"], nil, nil, "+", 10)
	self:moveObject(_G["ClassTrainerSkill1"], nil, nil, "+", 10)
	
	self:removeRegions(_G["ClassTrainerListScrollFrame"])
	self:moveObject(_G["ClassTrainerListScrollFrame"], "+", 35, "+", 10)
	self:skinScrollBar(_G["ClassTrainerListScrollFrame"])

	self:removeRegions(_G["ClassTrainerDetailScrollFrame"])
	self:skinScrollBar(_G["ClassTrainerDetailScrollFrame"])

	self:moveObject(_G["ClassTrainerMoneyFrame"], nil, nil, "-", 74)
	self:moveObject(_G["ClassTrainerTrainButton"], "-", 10, "+", 10)
	self:moveObject(_G["ClassTrainerCancelButton"], "-", 10, "+", 10)
	
	self:applySkin(_G["ClassTrainerFrame"])

end

function Skinner:TaxiFrame()
	if not self.db.profile.TaxiFrame or self.initialized.TaxiFrame then return end
	self.initialized.TaxiFrame = true
	
	self:keepRegions(_G["TaxiFrame"], {6, 7}) -- N.B. region 6 is TaxiMerchant, 7 is the TaxiMap overlay

	_G["TaxiFrame"]:SetWidth(_G["TaxiFrame"]:GetWidth() * FxMult)
	_G["TaxiFrame"]:SetHeight(_G["TaxiFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TaxiMerchant"], nil, nil, "+", 6)
	self:moveObject(_G["TaxiCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TaxiMap"], "+", 12, "+", 25)
	self:moveObject(_G["TaxiRouteMap"], "+", 12, "+", 25)
	
	self:applySkin(_G["TaxiFrame"])

end

function Skinner:QuestFrame()
	if not self.db.profile.QuestFrame or self.initialized.QuestFrame then return end
	self.initialized.QuestFrame = true

	-- hook OnShow methods to change text colour
	self:Hook("QuestFrameRewardPanel_OnShow")
	self:Hook("QuestFrameProgressPanel_OnShow")
	self:Hook("QuestFrameGreetingPanel_OnShow")
	self:Hook("QuestFrameDetailPanel_OnShow")

	self:removeRegions(_G["QuestFrame"])
	
	_G["QuestFrame"]:SetWidth(_G["QuestFrame"]:GetWidth() * FxMult)
	_G["QuestFrame"]:SetHeight(_G["QuestFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["QuestFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["QuestFrameCloseButton"], "+", 24, "+", 12)

	-- QF Reward Panel
	self:removeRegions(_G["QuestFrameRewardPanel"])
	self:moveObject(_G["QuestFrameCancelButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameCompleteQuestButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestRewardScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestRewardScrollFrame"])
	
	-- QF Progress
	self:removeRegions(_G["QuestFrameProgressPanel"])
	self:moveObject(_G["QuestFrameGoodbyeButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameCompleteButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestProgressScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestProgressScrollFrame"])
	
	-- QF Detail Panel
	self:removeRegions(_G["QuestFrameDetailPanel"])
	self:moveObject(_G["QuestFrameDeclineButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestFrameAcceptButton"], "-", 10, "-", 64)
	self:moveObject(_G["QuestDetailScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestDetailScrollFrame"])

-- QF Greeting Panel	
	self:removeRegions(_G["QuestFrameGreetingPanel"])
	self:moveObject(_G["QuestFrameGreetingGoodbyeButton"], "+", 28, "-", 64)
	self:moveObject(_G["QuestGreetingScrollFrame"], "-", 12, "+", 30)
	self:skinScrollBar(_G["QuestGreetingScrollFrame"])

	self:applySkin( _G["QuestFrame"])

end

function Skinner:QuestFrameRewardPanel_OnShow()

	self.hooks.QuestFrameRewardPanel_OnShow()

	_G["QuestRewardTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestRewardText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestRewardRewardTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestRewardItemChooseText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestRewardItemReceiveText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestRewardSpellLearnText"]:SetTextColor(HTr, HTg, HTb)

	for i = 1, MAX_NUM_ITEMS do
		_G["QuestRewardItem"..i]:SetTextColor(BTr, BTg, BTb)
	end 

end

function Skinner:QuestFrameProgressPanel_OnShow()

	self.hooks.QuestFrameProgressPanel_OnShow()

	_G["QuestProgressTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestProgressText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestProgressRequiredItemsText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestProgressRequiredMoneyText"]:SetTextColor(HTr, HTg, HTb)

	for i = 1, MAX_REQUIRED_ITEMS do
		_G["QuestProgressItem"..i]:SetTextColor(BTr, BTg, BTb)
	end 

end

function Skinner:QuestFrameGreetingPanel_OnShow()

	self.hooks.QuestFrameGreetingPanel_OnShow()

	_G["GreetingText"]:SetTextColor(HTr, HTg, HTb)
	_G["CurrentQuestsText"]:SetTextColor(HTr, HTg, HTb)
	_G["AvailableQuestsText"]:SetTextColor(HTr, HTg, HTb)

	for i = 1, MAX_NUM_QUESTS do
		_G["QuestTitleButton"..i]:SetTextColor(BTr, BTg, BTb)
	end	

end

function Skinner:QuestFrameDetailPanel_OnShow()

	self.hooks.QuestFrameDetailPanel_OnShow()

	_G["QuestTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestDescription"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestDetailObjectiveTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestObjectiveText"]:SetTextColor(HTr, HTg, HTb)

	_G["QuestDetailRewardTitleText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestDetailItemChooseText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestDetailItemReceiveText"]:SetTextColor(HTr, HTg, HTb)
	_G["QuestDetailSpellLearnText"]:SetTextColor(HTr, HTg, HTb)

	for i = 1, MAX_NUM_ITEMS do
		_G["QuestDetailItem"..i]:SetTextColor(BTr, BTg, BTb)
	end 

end

function Skinner:Battlefields()
	if not self.db.profile.Battlefields or self.initialized.Battlefields then return end
	self.initialized.Battlefields = true

	self:keepRegions(_G["BattlefieldFrame"], {6, 7, 8}) -- N.B. regions 6, 7 & 8 are text
	
	_G["BattlefieldFrame"]:SetWidth(_G["BattlefieldFrame"]:GetWidth() * FxMult)
	_G["BattlefieldFrame"]:SetHeight(_G["BattlefieldFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["BattlefieldFrameFrameLabel"], nil, nil, "+", 6)
	self:moveObject(_G["BattlefieldFrameCloseButton"], "+", 26, "+", 6)
	self:moveObject(_G["BattlefieldFrameCancelButton"], "-", 10, "+", 10)

	local xOfs, yOfs = 12, 20
	self:moveObject(_G["BattlefieldFrameNameHeader"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["BattlefieldZone1"], "-", xOfs, "+", yOfs)
	self:moveObject(_G["BattlefieldFrameZoneDescription"], "-", xOfs, "+", yOfs)
	self:removeRegions(_G["BattlefieldListScrollFrame"])
	self:moveObject(_G["BattlefieldListScrollFrame"], "+", 32, "+", yOfs)
	self:skinScrollBar(_G["BattlefieldListScrollFrame"])

	_G["BattlefieldFrameZoneDescription"]:SetTextColor(BTr, BTg, BTb)

	self:applySkin(_G["BattlefieldFrame"])

end

function Skinner:GuildRegistrar()
	if not self.db.profile.GuildRegistrar or self.initialized.GuildRegistrar then return end
	self.initialized.GuildRegistrar = true

	self:removeRegions(_G["GuildRegistrarFrame"], {1, 2, 3, 4, 5}) -- N.B. other regions are required

	_G["GuildRegistrarFrame"]:SetWidth(_G["GuildRegistrarFrame"]:GetWidth() * FxMult)
	_G["GuildRegistrarFrame"]:SetHeight(_G["GuildRegistrarFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["GuildRegistrarFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["GuildRegistrarFrameCloseButton"], "+", 24, "+", 12)
	self:removeRegions(_G["GuildRegistrarGreetingFrame"], {2}) -- N.B. region 1 is text

	_G["AvailableServicesText"]:SetTextColor(HTr, HTg, HTb)

	self:moveObject(_G["GuildRegistrarFrameGoodbyeButton"], "+", 28, "-", 64)

	_G["GuildRegistrarButton1"]:SetTextColor(BTr, BTg, BTb)	
	_G["GuildRegistrarButton2"]:SetTextColor(BTr, BTg, BTb)	
	_G["GuildRegistrarPurchaseText"]:SetTextColor(BTr, BTg, BTb)

	self:moveObject(_G["GuildRegistrarFrameCancelButton"], "+", 30, "-", 64)
	self:moveObject(_G["GuildRegistrarFramePurchaseButton"], "-", 10, "-", 64)

	self:skinEditBox(_G["GuildRegistrarFrameEditBox"])

	self:applySkin(_G["GuildRegistrarFrame"])

end

function Skinner:Petition()
	if not self.db.profile.Petition or self.initialized.Petition then return end
	self.initialized.Petition = true
	
	self:removeRegions(_G["PetitionFrame"], {1, 2, 3, 4, 5}) -- N.B. other regions are required

	_G["PetitionFrame"]:SetWidth(_G["PetitionFrame"]:GetWidth() * FxMult)
	_G["PetitionFrame"]:SetHeight(_G["PetitionFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["PetitionFrameNpcNameText"], nil, nil, "+", 15)
	self:moveObject(_G["PetitionFrameCloseButton"], "+", 24, "+", 12)
	self:moveObject(_G["PetitionFrameCancelButton"], "+", 28, "-", 64)
	self:moveObject(_G["PetitionFrameSignButton"], "-", 15, "-", 64)
	self:moveObject(_G["PetitionFrameRequestButton"], "-", 15, "-", 64)

	_G["PetitionFrameCharterTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["PetitionFrameCharterName"]:SetTextColor(BTr, BTg, BTb)
	_G["PetitionFrameMasterTitle"]:SetTextColor(HTr, HTg, HTb)
	_G["PetitionFrameMasterName"]:SetTextColor(BTr, BTg, BTb)
	_G["PetitionFrameMemberTitle"]:SetTextColor(HTr, HTg, HTb)
	for i = 1, 9 do
		_G["PetitionFrameMemberName"..i]:SetTextColor(BTr, BTg, BTb)
	end
	_G["PetitionFrameInstructions"]:SetTextColor(BTr, BTg, BTb)
	
	self:applySkin(_G["PetitionFrame"])

end

function Skinner:Tabard()
	if not self.db.profile.Tabard or self.initialized.Tabard then return end
	self.initialized.Tabard = true

	self:keepRegions(_G["TabardFrame"], {6, 17, 18, 19, 20, 21, 22}) -- N.B. region 6 is the background, 17 - 20 are the emblem, 21, 22 are the text

	_G["TabardFrame"]:SetWidth(_G["TabardFrame"]:GetWidth() * FxMult)
	_G["TabardFrame"]:SetHeight(_G["TabardFrame"]:GetHeight() * FyMult)

	self:moveObject(_G["TabardFrameCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["TabardFrameEmblemTopRight"], "-", 20, nil, nil)
	self:moveObject(_G["TabardFrameNameText"], nil, nil, "-", 28)
	self:moveObject(_G["TabardFrameBackground"], "-", 8, "+", 10)
	self:moveObject(_G["TabardModel"], nil, nil, "-", 60)

	_G["TabardCharacterModelRotateLeftButton"]:Hide()
	_G["TabardCharacterModelRotateRightButton"]:Hide()
	self:makeMFRotatable(_G["TabardModel"])
	
	self:moveObject(_G["TabardFrameCostFrame"], "-", 5, "+", 10)
	self:removeRegions(_G["TabardFrameCustomizationFrame"])
	self:moveObject(_G["TabardFrameCustomization1"], "+", 35, "-", 73)
	for i = 1, 5 do
		self:keepRegions(_G["TabardFrameCustomization"..i], {4}) -- N.B. region 4 is text
	end
	self:moveObject(_G["TabardFrameMoneyFrame"], "-", 30, "-", 75)
	self:moveObject(_G["TabardFrameAcceptButton"], "-", 10, "+", 10)
	self:moveObject(_G["TabardFrameCancelButton"], "-", 10, "+", 10)
	
	self:applySkin(_G["TabardFrame"])

end
