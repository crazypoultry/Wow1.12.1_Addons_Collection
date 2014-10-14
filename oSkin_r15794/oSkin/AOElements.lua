
function oSkin:Skin_OneBag()
	if not self.db.profile.ContainerFrames or self.initialized.OneBag then return end
	self.initialized.OneBag = true

	self:applySkin(_G["OneBagFrame"], nil, nil, _G["OneBag"].db.profile.colors.bground.a, 200)
	if _G["OneRingFrame"] then self:applySkin(_G["OneRingFrame"], nil, nil, _G["OneRing"].db.profile.colors.bground.a, 100) end
	if _G["OneViewFrame"] then self:applySkin(_G["OneViewFrame"], nil, nil, _G["OneView"].db.profile.colors.bground.a, 200) end

end

function oSkin:Skin_OneBank()
	if not self.db.profile.BankFrame or self.initialized.OneBank then return end
	self.initialized.OneBank = true

	self:applySkin(_G["OneBankFrame"], nil, nil, _G["OneBank"].db.profile.colors.bground.a, 300) 

end

function oSkin:EnhancedStackSplit()
	if not self.db.profile.StackSplit then return end

	_G["StackSplitFrame"]:SetHeight(_G["StackSplitFrame"]:GetHeight() + 40)

	self:moveObject(_G["StackSplitText"], nil, nil, "+", 20)	
	self:moveObject(_G["StackSplitLeftButton"], "+", 5, "+", 20)	
	self:moveObject(_G["StackSplitRightButton"], "-", 5, "+", 20)	
	self:moveObject(_G["StackSplitOkayButton"], nil, nil, "+", 36)	
	self:moveObject(_G["StackSplitCancelButton"], nil, nil, "+", 36)	

	self:removeRegions(_G["EnhancedStackSplitFrame"], {1})

	for i = 1, 6 do
		self:moveObject(_G["EnhancedStackSplitButton"..i], "-", 6, "+", 24)	
	end

	self:moveObject(_G["EnhancedStackSplitMaxTextFrame"], nil, nil, "+", 20)
	self:moveObject(_G["EnhancedStackSplitModeTXTButton"], "-", 5, "+", 22)
	
end

function oSkin:GMail()
	if not self.db.profile.MailFrame then return end
	
	if self.db.profile.TexturedTab then
    	self:Hook(GMail, "MailFrameTab_OnClick", function(gmail, tab)
--   		self:Debug("GMail - MailFrameTab_OnClick: [%s]", tab)
   	    	self.hooks[GMail].MailFrameTab_OnClick(gmail, tab)
--		    self:Debug("GMail - MailFrameTab_OnClick#2: [%s]", PanelTemplates_GetSelectedTab(_G["MailFrame"]))
            for i = 1, _G["MailFrame"].numTabs do
                local tabName = _G["MailFrameTab"..i]
                if i == _G["MailFrame"].selectedTab then
                    self:setActiveTab(tabName:GetName())
                else
                    self:setInactiveTab(tabName:GetName())
                end
            end
   		   end)
	end
		
	self:keepRegions(_G["MailFrameTab3"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
--	self:moveObject(_G["MailFrameTab3"], "+", 4, nil, nil)
	if self.db.profile.TexturedTab then self:applySkin(_G["MailFrameTab3"], nil, 0)
	else self:applySkin(_G["MailFrameTab3"]) end
	
	self:moveObject(_G["GMailInboxOpenSelected"], "-", 20, "+", 5)
	self:moveObject(_G["GMailInboxOpenAllButton"], "-", 20, "+", 5)

	--	reset MailItem1 position
	self:moveObject(_G["MailItem1"], "-", 5, "-", 5)
	
	-- skin the frame
	self:removeRegions(_G["GMailFrame"], {4, 5}) -- N.B. regions 1, 2 & 3 are text
	_G["GMailFrame"]:SetWidth(_G["GMailFrame"]:GetWidth() * FxMult)
	_G["GMailFrame"]:SetHeight(_G["GMailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["GMailTitleText"], "+", 5, "-", 35)
	self:moveObject(_G["GMailNameEditBox"], "-", 5, "+", 10)
	self:moveObject(_G["GMailCostMoneyFrame"], "+", 40, "+", 10)
	self:moveObject(_G["GMailMoneyFrame"], "-", 5, "-", 72)
	self:moveObject(_G["GMailCancelButton"], "+", 34, "-", 72)
	self:applySkin(_G["GMailFrame"])

	-- skin the accept send frame
	self:keepRegions(_G["GMailAcceptSendFrame"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["GMailAcceptSendFrame"], 1)

	self:moveObject(_G["GMailStatusText"], nil, nil, "-", 65)
	self:moveObject(_G["GMailAbortButton"], nil, nil, "-", 70)
	
	self:moveObject(_G["GMailButton1"], "-", 10, "+", 20)
	
	-- skin the OpenAll frame
	self:keepRegions(_G["GMailInboxOpenAll"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["GMailInboxOpenAll"], 1)
	
end

function oSkin:SuperInspectFrame()
	if not self.db.profile.Inspect or self.initialized.SuperInspect then return end
	self.initialized.SuperInspect = true
	
	self:removeRegions(_G["SuperInspectFrameHeader"], {1, 2, 3, 4})
	self:removeRegions(_G["SuperInspect_ItemBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_COHBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_USEBonusesFrame"], {1})
	self:removeRegions(_G["SuperInspect_SnTBonusesFrame"], {1})
	
	self:removeRegions(_G["SuperInspect_HonorFrame"], {1})
	self:glazeStatusBar(_G["SuperInspect_HonorFrameProgressBar"], -2)
	
	self:removeRegions(_G["SuperInspect_ItemBonusesFrameCompare"], {1})
	
	self:removeRegions(_G["SuperInspect_Button_ShowHonor"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowBonuses"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowMobInfo"], {2, 4})
	self:removeRegions(_G["SuperInspect_Button_ShowItems"], {2, 4})
	
	-- Hide frames we don't need
	_G["SuperInspect_BackgroundTopLeft"]:Hide()
	_G["SuperInspect_BackgroundTopRight"]:Hide()
	_G["SuperInspect_BackgroundBotLeft"]:Hide()
	_G["SuperInspect_BackgroundBotRight"]:Hide()
	
	-- Resize
	_G["SuperInspectFrameHeader"]:SetWidth(SuperInspectFrameHeader:GetWidth()-20)
	_G["SuperInspectFrameHeader"]:SetHeight(SuperInspectFrameHeader:GetHeight()-62)
	
	-- Reposition
	_G["SuperInspectFrameHeader_CloseButton"]:ClearAllPoints()
	
	_G["SuperInspectFrameHeader_CloseButton"]:SetPoint("CENTER", _G["SuperInspectFrame"], "TOPRIGHT", -20, -20)
	
	-- Skin
	self:applySkin(_G["SuperInspectFrame"])
	self:applySkin(_G["SuperInspect_ItemBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_COHBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_USEBonusesFrame"], nil, 0.6, 0.6)
	self:applySkin(_G["SuperInspect_SnTBonusesFrame"], nil, 0.6, 0.6)
	
	self:applySkin(_G["SuperInspect_HonorFrame"])
	
	self:applySkin(_G["SuperInspect_ItemBonusesFrameCompare"])
	
	self:applySkin(_G["SuperInspect_BonusFrameParentTab1"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab2"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab3"])
	self:applySkin(_G["SuperInspect_BonusFrameParentTab4"])
	
	self:applySkin(_G["SuperInspect_Button_ShowHonor"])
	self:applySkin(_G["SuperInspect_Button_ShowBonuses"])
	self:applySkin(_G["SuperInspect_Button_ShowMobInfo"])
	self:applySkin(_G["SuperInspect_Button_ShowItems"])
	
	_G["SuperInspectFramePortrait"]:SetAlpha(0)
	
end

function oSkin:CTRA()
	if not self.db.profile.FriendsFrame then return end

	self:hookDDScript(CT_RAMenuFrameGeneralDisplayHealthDropDownButton)	
	self:hookDDScript(CT_RAMenuFrameGeneralMiscDropDownButton)	
	self:hookDDScript(CT_RAMenuFrameBuffsBuffsDropDownButton)	

	self:moveObject(_G["CT_RAOptionsButton"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RACheckAllGroups"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RAOptionsFrameCheckAllGroupsText"], "-", 40, "+", 10)
	self:moveObject(_G["CT_RAOptionsGroup1"], "-", 7, "+", 8)

	self:removeRegions(_G["CT_RAMenuFrame"], {1, 2, 3, 4, 5, 6, 7}) -- N.B. region 8 is text
	self:moveObject(_G["CT_RAMenuFrameHeader"], nil, nil, "-", 8)
	self:moveObject(_G["CT_RAMenuFrameCloseButton"], "+", 40, "+", 2)
	self:applySkin(_G["CT_RAMenuFrame"])
	
	self:removeRegions(_G["CT_RAMenuFrameGeneralDisplayHealthDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CT_RAMenuFrameGeneralMiscDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CT_RAMenuFrameBuffsBuffsDropDown"], {1, 2, 3}) -- N.B. region 4 is text

-->>--	Debuff Frame
	for _, n in {"NameEB", "DebuffTitleEB", "DebuffTypeEB", "DebuffDescriptEB" } do
		self:removeRegions(_G["CT_RAMenuFrameDebuffSettings"..n], {6, 7, 8}) -- N.B. regions 1-5 are text/scripts
	  	self:moveObject(_G["CT_RAMenuFrameDebuffSettings"..n], "+", 5, nil, nil)  
		local left, right, top, bottom = _G["CT_RAMenuFrameDebuffSettings"..n]:GetTextInsets()
		_G["CT_RAMenuFrameDebuffSettings"..n]:SetTextInsets(left + 5, right + 5, top, bottom)
		_G["CT_RAMenuFrameDebuffSettings"..n]:SetWidth(_G["CT_RAMenuFrameDebuffSettings"..n]:GetWidth() + 10)
		self:applySkin(_G["CT_RAMenuFrameDebuffSettings"..n])
	end
	
	self:skinScrollBar(_G["CT_RAMenuFrameDebuffUseScrollFrame"])
	
-->>--	Priority Frame	
	self:removeRegions(_G["CT_RA_PriorityFrame"], {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}) -- N.B. regions 12 & 13 are text
	self:moveObject(_G["CT_RA_PriorityFrameTitle"], nil, nil, "-", 8)
	self:applySkin(_G["CT_RA_PriorityFrame"])
	
	self:removeRegions(_G["CT_RAMenu_NewSetFrame"], {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}) -- N.B. regions 11-13 are text
	self:moveObject(_G["CT_RAMenu_NewSetFrameTitle"], nil, nil, "-", 8)
	self:applySkin(_G["CT_RAMenu_NewSetFrame"])

-->>--	Option Sets Frame	
	self:removeRegions(_G["CT_RAMenu_NewSetFrameNameEB"], {6, 7, 8}) -- N.B. regions 1-5 are text/scripts
  	self:moveObject(_G["CT_RAMenu_NewSetFrameNameEB"], "+", 5, "-", 10)  
    local left, right, top, bottom = _G["CT_RAMenu_NewSetFrameNameEB"]:GetTextInsets()
    _G["CT_RAMenu_NewSetFrameNameEB"]:SetTextInsets(left + 5, right + 5, top, bottom)
    _G["CT_RAMenu_NewSetFrameNameEB"]:SetWidth(_G["CT_RAMenu_NewSetFrameNameEB"]:GetWidth() + 10)
    self:applySkin(_G["CT_RAMenu_NewSetFrameNameEB"])
	
end

function oSkin:FramesResized_TradeSkillUI()
	if not self.db.profile.TradeSkill then return end

	self:removeRegions(_G["TradeSkillFrame_MidTextures"])
	self:removeRegions(_G["TradeSkillListScrollFrame_MidTextures"])   
	
	self:removeRegions(_G["TradeSkillDetailScrollFrame"])
	self:moveObject(_G["TradeSkillDetailScrollFrame"], "-", 5, nil, nil)
	self:skinScrollBar(_G["TradeSkillDetailScrollFrame"])
	
	self:moveObject(_G["TradeSkillCreateButton"], nil, nil, "+", 20)
	self:moveObject(_G["TradeSkillCancelButton"], nil, nil, "+", 20)
	
end

function oSkin:FramesResized_CraftUI()
	if not self.db.profile.CraftFrame then return end
	
	self:removeRegions(_G["CraftFrame_MidTextures"])
	self:removeRegions(_G["CraftListScrollFrame_MidTextures"])   
	
	self:moveObject(_G["CraftCreateButton"], nil, nil, "+", 20)
	self:moveObject(_G["CraftCancelButton"], nil, nil, "+", 20)
	
end

function oSkin:FramesResized_QuestLog()
	if not self.db.profile.QuestLog then return end
	
	self:SecureHook("QuestLog_OnShow", function()
		_G["QuestLogFrame"]:SetHeight(_G["QuestLogFrame"]:GetHeight() - 64)
		end)
		
	self:removeRegions(_G["QuestLogFrame_MidTextures"])

end

function oSkin:FramesResized_TrainerUI()
    if not self.db.profile.ClassTrainer then return end

    self:removeRegions(_G["ClassTrainerFrame_MidTextures"])
    self:removeRegions(_G["ClassTrainerListScrollFrame_MidTextures"])  

    self:moveObject(_G["ClassTrainerTrainButton"], nil, nil, "+", 20)
    self:moveObject(_G["ClassTrainerCancelButton"], nil, nil, "+", 20)

end

function oSkin:FramesResized_LootFrame()
	if not self.db.profile.LootFrame then return end
	
	for i = 5, NUM_GROUP_LOOT_FRAMES do
		_G["LootButton"..i]:ClearAllPoints()
		_G["LootButton"..i]:SetPoint("TOP", _G["LootButton"..i - 1], "BOTTOM", 0, -4)
   	end

end

function oSkin:Skin_EnhancedTradeSkills() 
	if not self.db.profile.TradeSkill then return end

	self:moveObject(_G["ETS_FILTERSONOFF"], "-", 20, nil, nil)
	
end

function oSkin:Skin_EnhancedTradeCrafts() 
	if not self.db.profile.CraftFrame then return end
	
	self:moveObject(_G["ETS_CFILTERSONOFF"], "-", 10, "-", 72)
	
end

function oSkin:AutoProfit()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["TreasureModel"], nil, nil, "+", 28)
	self:moveObject(_G["AutosellButton"], nil, nil, "+", 28)

end

function oSkin:FuBar_GarbageFu()
	if not self.db.profile.MerchantFrames then return end
	
	self:moveObject(_G["GarbageFu_SellItemButton"], nil, nil, "+", 28)

end

function oSkin:GFW_AutoCraft()
	if not self.db.profile.TradeSkill then return end

	_G["TradeSkillFrame"]:SetHeight(_G["TradeSkillFrame"]:GetHeight() + 40)
	self:removeRegions(_G["AutoCraftBackground"])

end

function oSkin:MetaMap()
	if not self.db.profile.WorldMap then return end

	self:hookDDScript(MetaMapFrameDropDownButton)	

	self:Hook("MetaMapMenu_OnShow", function(mode)
		self.hooks.MetaMapMenu_OnShow(mode)
		self:keepRegions(_G["MetaMapMenu"], {1}) -- N.B. region 1 is text
		self:applySkin(_G["MetaMapMenu"])
		end)
		
	self:keepRegions(_G["MetaMapFrameDropDown"], {4}) -- N.B. region 4 is text
	self:moveObject(_G["WorldMapFrameCloseButton"], "-", 10, "-", 5)
	self:applySkin(_G["MetaMapTopFrame"])

	self:moveObject(_G["MetaMapSliderMenu"], nil, nil, "-", 10)
	self:applySkin(_G["MetaMapSliderMenu"])
		
	for i = 1, 6 do
		local tabName = _G["MetaMap_DialogFrameTab"..i]
		-- hook the OnShow script to allow tab widths to be changed
		self:HookScript(tabName, "OnShow", function()
--			self:Debug(tabName:GetName().."OnShow")
			self.hooks[tabName].OnShow()
			tabName:SetWidth(tabName:GetWidth() * 0.85)
			end)
		self:keepRegions(tabName, {7}) -- N.B. region 7 is text
		tabName:SetHeight(tabName:GetHeight() * (FTyMult + FTyMult))
		if i == 1 then 
			self:moveObject(tabName, nil, nil, "_", 8) 
		else
			self:moveObject(tabName, "+", 15, nil, nil) 
		end
		self:applySkin(tabName)
	end

	self:moveObject(_G["MetaMap_CloseButton"], nil, nil, "_", 2)

	self:applySkin(_G["MetaMap_DialogFrame"], 1)
	
end

function oSkin:LootLink() 

	self:hookDDScript(LootLinkFrameDropDownButton)
	self:hookDDScript(LLS_RarityDropDownButton)
	self:hookDDScript(LLS_BindsDropDownButton)
	self:hookDDScript(LLS_LocationDropDownButton)
	self:hookDDScript(LLS_TypeDropDownButton)
	self:hookDDScript(LLS_SubtypeDropDownButton)
	
	self:removeRegions(_G["LootLinkFrame"], {2, 3, 4, 5})

	_G["LootLinkFrame"]:SetWidth(_G["LootLinkFrame"]:GetWidth() - 30)
	_G["LootLinkFrame"]:SetHeight(_G["LootLinkFrame"]:GetHeight() - 70)

	self:moveObject(_G["LootLinkFrameCloseButton"], "+", 15, nil, nil)
	self:moveObject(_G["LootLinkTitleText"], "+", 15, nil, nil)

	self:removeRegions(_G["LootLinkListScrollFrame"])
	self:skinScrollBar(_G["LootLinkListScrollFrame"])

	self:skinTooltip(LootLinkTooltip)
	self:skinTooltip(LLHiddenTooltip)

	self:applySkin(_G["LootLinkFrame"], {2, 3, 4, 5})
	self:applySkin(_G["LootLinkSearchFrame"])

end

function oSkin:Possessions() 

	self:hookDDScript(Possessions_CharDropDownButton)
	self:hookDDScript(Possessions_LocDropDownButton)
	self:hookDDScript(Possessions_SlotDropDownButton)
	
	self:removeRegions(_G["Possessions_IC_ScrollFrame"])
	self:skinScrollBar(_G["Possessions_IC_ScrollFrame"])
	
	self:applySkin(_G["Possessions_Frame"])

end

function oSkin:EQL3Frame()
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

function oSkin:BattleChat() 

	self:applySkin(_G["BattleChat"].frame)
	BattleChat.frame:SetBackdropColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01)
	BattleChat.frame:SetBackdropBorderColor(0, 0, 0, BattleChat.db.profile.alpha * 0.01 * 4/3)

end

function oSkin:KombatStats() 

	oSkin:applySkin(KombatStatsFrame)
	if KombatStats.dpsButton then 
		oSkin:applySkin(KombatStats.dpsButton)
	end

end

function oSkin:FruityLoots_LF_SetPoint(obj, flx, fly)
	
	local screenWidth = GetScreenWidth()
	if (UIParent:GetWidth() > screenWidth) then screenWidth = UIParent:GetWidth() end
	local screenHeight = GetScreenHeight()
-- LootFrame is set to 256 wide in the xml file, but is actually only 191 wide
-- This is based on calculation envolving the offset on the close button:
-- The height is always 256, which is the correct number.
	local windowWidth = 191
	local windowHeight = 256
	if (flx + windowWidth) > screenWidth then flx = screenWidth - windowWidth end
	if fly > screenHeight then fly = screenHeight end
	if flx < 0 then flx = 0 end
	if (fly - windowHeight) < 0 then fly = windowHeight end

	_G["LootFrame"]:ClearAllPoints()
	_G["LootFrame"]:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", flx + 10, fly - 44)

end

function oSkin:Skin_MCP()
	if self.initialized.MCP then return end
	self.initialized.MCP = true

	if not self:isVersion("MCP", { "2006.07.22", "2006.08.28", "2006.09.06" }, MCP_VERSION) then return end
	
	if _G["MCPAddonSetDropDown"] then 
		-- Rophy's version on the SVN
		self:hookDDScript(MCPAddonSetDropDownButton)
		self:keepRegions(_G["MCPAddonSetDropDown"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCPAddonSetDropDown"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonListDisableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListEnableAll"], nil, nil, nil, nil)
		self:moveObject(_G["MCP_AddonListSaveSet"], nil, nil, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], nil, nil, "-", 10)
	else
		-- standard version from Curse
		self:hookDDScript(MCP_AddonList_ProfileSelectionButton)	
		self:keepRegions(_G["MCP_AddonList_ProfileSelection"], {4}) -- N.B. region 4 is text
		self:moveObject(_G["MCP_AddonList_ProfileSelection"], nil, nil, "-", 13)
		self:moveObject(_G["MCP_AddonList_EnableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_DisableAll"], "+", 30, "+", 5)
		self:moveObject(_G["MCP_AddonList_SaveProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_DeleteProfile"], "+", 40, "-", 10)
		self:moveObject(_G["MCP_AddonList_ReloadUI"], "+", 30, "+", 5)
	end
	
	-- change the scale to match other frames
	_G["MCP_AddonList"]:SetScale(_G["GameMenuFrame"]:GetEffectiveScale())
	
	self:keepRegions(_G["MCP_AddonList"], {8}) -- N.B. region 8 is the title
	_G["MCP_AddonList"]:SetWidth(_G["MCP_AddonList"]:GetWidth() * FxMult)
	_G["MCP_AddonList"]:SetHeight(_G["MCP_AddonList"]:GetHeight() * FyMult)

	-- resize the frame's children to match the frame size
	for i, v in ipairs({ _G["MCP_AddonList"]:GetChildren() }) do
		v:SetWidth(v:GetWidth() * FxMult)
		v:SetHeight(v:GetHeight() * FyMult)
	end
	
	self:moveObject(_G["MCP_AddonListCloseButton"], "+", 40, nil, nil)
	self:moveObject(_G["MCP_AddonListEntry1"], nil, nil, "+", 10)
	self:removeRegions(_G["MCP_AddonList_ScrollFrame"])
	self:moveObject(_G["MCP_AddonList_ScrollFrame"], "+", 26, "+", 7)
	_G["MCP_AddonList_ScrollFrame"]:SetHeight(_G["MCP_AddonList_ScrollFrame"]:GetHeight() + 10)
	self:skinScrollBar(_G["MCP_AddonList_ScrollFrame"])
	
	self:applySkin(_G["MCP_AddonList"], true)
		
end

function oSkin:CT_MailMod()
	if not self.db.profile.MailFrame then return end
	
	self:keepRegions(_G["MailFrameTab3"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
	self:moveObject(_G["MailFrameTab3"], "+", 4, nil, nil)
	self:applySkin(_G["MailFrameTab3"])

	self:moveObject(_G["CT_MMInboxOpenSelected"], "-", 20, "+", 5)
	self:moveObject(_G["CT_MMInboxOpenAll"], "-", 20, "+", 5)

	--	reset MailItem1 position
	self:moveObject(_G["MailItem1"], "-", 5, "-", 5)
	
	-- skin the frame
	self:removeRegions(_G["CT_MailFrame"], {4, 5}) -- N.B. regions 1, 2 & 3 are text
	_G["CT_MailFrame"]:SetWidth(_G["CT_MailFrame"]:GetWidth() * FxMult)
	_G["CT_MailFrame"]:SetHeight(_G["CT_MailFrame"]:GetHeight() * FyMult)
	
	self:moveObject(_G["CT_MailTitleText"], "+", 5, "-", 35)
	self:moveObject(_G["CT_MailNameEditBox"], "-", 5, "+", 10)
	self:moveObject(_G["CT_MailCostMoneyFrame"], "+", 40, "+", 10)
	self:moveObject(_G["CT_MailMoneyFrame"], "-", 5, "-", 72)
	self:moveObject(_G["CT_MailCancelButton"], "+", 34, "-", 72)
	self:applySkin(_G["CT_MailFrame"])

	-- skin the accept send frame
	self:keepRegions(_G["CT_Mail_AcceptSendFrame"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["CT_Mail_AcceptSendFrame"], 1)

	self:moveObject(_G["CT_MailStatusText"], nil, nil, "-", 65)
	self:moveObject(_G["CT_MailAbortButton"], nil, nil, "-", 70)
	
	self:moveObject(_G["CT_MailButton1"], "-", 10, "+", 20)
	
	-- skin the OpenAll frame
	self:keepRegions(_G["CT_MMInbox_OpenAll"], {11, 12, 13, 14})-- N.B. regions 11 - 14 are text
	self:applySkin(_G["CT_MMInbox_OpenAll"], 1)

end

function oSkin:ItemSync() 

	self:hookDDScript(ISync_MainFrame_DropDownButton)
	self:hookDDScript(ISync_Location_DropDownButton)
	self:hookDDScript(ISync_Rarity_DropDownButton)
	self:hookDDScript(ISync_Weapons_DropDownButton)
	self:hookDDScript(ISync_Level_DropDownButton)
	self:hookDDScript(ISync_Tradeskills_DropDownButton)
	self:hookDDScript(ISync_Armor_DropDownButton)
	self:hookDDScript(ISync_Shield_DropDownButton)
	self:hookDDScript(ISync_FavFrame_DropDownButton)
	self:hookDDScript(ISync_FilterPurgeRare_DropDownButton)
	
	for i = 1, 4 do
	  self:removeRegions(_G["ISync_OptionsFrameTab"..i], {1, 2, 3, 4})
	  self:moveObject(_G["ISync_OptionsFrameTab"..i], "+", 15, nil, nil)
	  self:applySkin(_G["ISync_OptionsFrameTab"..i])
	end
	
	self:applySkin(_G["ISync_MainFrame"])
	self:applySkin(_G["ISync_SearchFrame"])
	self:applySkin(_G["ISync_BV_Frame"])
	self:applySkin(_G["ISync_FavFrame"])
	self:applySkin(_G["ISync_FiltersFrame"])
	self:applySkin(_G["ISync_OptionsFrame"])

end

function oSkin:Skin_aftte()

	bd = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16,
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
		insets = {left = 4, right = 4, top = 4, bottom = 4},
	}

	self:applySkin(_G["aftt_descriptFrame"], nil, nil, nil, nil, bd)
	self:applySkin(_G["aftt_targettargetframe"], nil, nil, nil, nil, bd)
	self:applySkin(_G["aftt_tooltipFrame"], nil, nil, nil, nil, bd)
end

function oSkin:EasyUnlock()

	self:Hook("EasyUnlock_DoFrameCheck", function()
        local been_here_before = EasyUnlock:IsShown()
		self.hooks.EasyUnlock_DoFrameCheck()
		if not been_here_before and _G["TradeFrameTradeButton"]:GetWidth() == 56 then
			self:moveObject(_G["TradeFrameTradeButton"], "+", 20, "-", 40) 
		end
		end)
		
end

function oSkin:ImprovedErrorFrame()

    self:applySkin(_G["ImprovedErrorFrameCloseButton"]) 
    self:applySkin(_G["ImprovedErrorFrameFrame"]) 

    self:removeRegions(_G["ScriptErrorsScrollFrameOne"])
    self:skinScrollBar(_G["ScriptErrorsScrollFrameOne"])

end

function oSkin:Skin_SuperMacro()

	if not self:isVersion("SuperMacro", "3.14", SUPERMACRO_VERSION) then return end

	self:SecureHook("SuperMacroFrame_Update" , function()
		if self.db.profile.TexturedTab then    
			if SM_VARS.tabShown == "regular" then
				self:setActiveTab("SuperMacroFrameTab1")
				self:setInactiveTab("SuperMacroFrameTab2")
			else
				self:setActiveTab("SuperMacroFrameTab2")
				self:setInactiveTab("SuperMacroFrameTab1")
			end
		end
		end)
	
    self:keepRegions(_G["SuperMacroFrame"], {8, 12, 13, 14}) -- N.B. regions 8, 12-14 are text
    _G["SuperMacroFrame"]:SetWidth(_G["SuperMacroFrame"]:GetWidth() - 30)
    _G["SuperMacroFrame"]:SetHeight(_G["SuperMacroFrame"]:GetHeight() - 70)
    self:moveObject(_G["SuperMacroFrameTitle"], nil, nil, "+", 12) 
    self:moveObject(_G["SuperMacroDeleteButton"], "-", 5, "-", 70)
    self:moveObject(_G["SuperMacroSaveButton"], "-", 5, "-", 70)
    self:moveObject(_G["SuperMacroSaveExtendButton"], "+", 25, nil, nil)
    self:moveObject(_G["SuperMacroDeleteExtendButton"], "+", 25, nil, nil)
    self:moveObject(_G["SuperMacroFrameCharLimitText"], "-", 5, "-", 70)
    self:moveObject(_G["SuperMacroFrameSuperCharLimitText"], "-", 5, "-", 70)
    self:removeRegions(_G["SuperMacroFrameScrollFrame"])
    self:skinScrollBar(_G["SuperMacroFrameScrollFrame"])
    self:removeRegions(_G["SuperMacroFrameExtendScrollFrame"])
    self:skinScrollBar(_G["SuperMacroFrameExtendScrollFrame"]) 
    self:removeRegions(_G["SuperMacroFrameSuperScrollFrame"])
    self:skinScrollBar(_G["SuperMacroFrameSuperScrollFrame"])
    self:removeRegions(_G["SuperMacroFrameSuperEditScrollFrame"])
    self:skinScrollBar(_G["SuperMacroFrameSuperEditScrollFrame"])
    self:removeRegions(_G["SuperMacroPopupScrollFrame"])
    self:skinScrollBar(_G["SuperMacroPopupScrollFrame"])
    self:moveObject(_G["SuperMacroOptionsButton"], "-", 5, "-", 70)
    self:moveObject(_G["SuperMacroExitButton"], "+", 25, nil, nil)
    self:moveObject(_G["SuperMacroFrameCloseButton"], "+", 28, "+", 8)
    self:keepRegions(_G["SuperMacroFrameTab1"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
    self:keepRegions(_G["SuperMacroFrameTab2"], {7, 8}) -- N.B. region 7 is text, 8 is highlight
    self:moveObject(_G["SuperMacroFrameTab1"], nil, nil, "-", 70)
    self:moveObject(_G["SuperMacroFrameTab2"], "+", 10, nil, nil)
	if self.db.profile.TexturedTab then    
	    self:applySkin(_G["SuperMacroFrameTab1"], nil, 0)
		self:setActiveTab("SuperMacroFrameTab1")
    	self:applySkin(_G["SuperMacroFrameTab2"], nil, 0)
		self:setInactiveTab("SuperMacroFrameTab2")
    else
    	self:applySkin(_G["SuperMacroFrameTab1"])
    	self:applySkin(_G["SuperMacroFrameTab2"])
    end
    self:keepRegions(_G["SuperMacroPopupFrame"], {7, 8}) -- N.B. region 7 is text, 8 is icon
    self:applySkin(_G["SuperMacroPopupFrame"])
    self:moveObject(_G["SuperMacroPopupCancelButton"], nil, nil, "+", 8)
    self:applySkin(_G["SuperMacroFrame"])

	-- Options Frame
	self:keepRegions(_G["SuperMacroOptionsFrame"], {6}) -- N.B. region 6 is text
    _G["SuperMacroOptionsFrame"]:SetWidth(_G["SuperMacroOptionsFrame"]:GetWidth() - 30)
    _G["SuperMacroOptionsFrame"]:SetHeight(_G["SuperMacroOptionsFrame"]:GetHeight() - 70)
    self:moveObject(_G["SuperMacroOptionsTitleText"], nil, nil, "-", 20)
	self:moveObject(_G["SuperMacroOptionsCloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["SuperMacroOptionsExitButton"], "+", 20, nil, nil)
	for i = 1, 6 do
		_G["SuperMacroOptionsFrameCheckButton"..i.."Text"]:SetTextColor(BTr, BTg, BTb)
	end
	_G["SuperMacroOptionsFrameColorSwatch1Text"]:SetTextColor(BTr, BTg, BTb)
    self:applySkin(_G["SuperMacroOptionsFrame"])

end

function oSkin:Skin_MailTo()

    self:removeRegions(_G["MailTo_InFrame"], {2, 3, 4, 5})
    self:applySkin(_G["MailTo_InFrame"])

end

function oSkin:Skin_HoloFriends()

    self:hookDDScript(HoloFriendsDropDownButton)
    self:hookDDScript(HoloIgnoreDropDownButton)
    
    self:removeRegions(_G["HoloFriendsFrameToggleTab1"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloFriendsFrameToggleTab2"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloFriendsFrameToggleTab3"], {1,2,3,4,5,6})
    
    self:removeRegions(_G["HoloIgnoreFrameToggleTab1"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloIgnoreFrameToggleTab2"], {1,2,3,4,5,6})
    self:removeRegions(_G["HoloIgnoreFrameToggleTab3"], {1,2,3,4,5,6})
    
    self:moveObject(_G["HoloFriendsFrameToggleTab1"], "-", 5, nil, nil)
    self:moveObject(_G["HoloFriendsFrameToggleTab2"], "-", 5, nil, nil)
    self:moveObject(_G["HoloFriendsFrameToggleTab3"], "-", 5, nil, nil)
    
    self:moveObject(_G["HoloIgnoreFrameToggleTab1"], "-", 5, nil, nil)
    self:moveObject(_G["HoloIgnoreFrameToggleTab2"], "-", 5, nil, nil)
    self:moveObject(_G["HoloIgnoreFrameToggleTab3"], "-", 5, nil, nil)
    
    self:applySkin(_G["HoloFriendsFrameToggleTab1"])
    self:applySkin(_G["HoloFriendsFrameToggleTab2"])
    self:applySkin(_G["HoloFriendsFrameToggleTab3"])
    
    self:applySkin(_G["HoloIgnoreFrameToggleTab1"])
    self:applySkin(_G["HoloIgnoreFrameToggleTab2"])
    self:applySkin(_G["HoloIgnoreFrameToggleTab3"])
    
    self:removeRegions(_G["HoloFriendsScrollFrame"])
    self:moveObject(_G["HoloFriendsScrollFrame"], "+", 35, "+", 10)
    self:skinScrollBar(_G["HoloFriendsScrollFrame"])
    
    self:removeRegions(_G["HoloIgnoreScrollFrame"])
    self:moveObject(_G["HoloIgnoreScrollFrame"], "+", 35, "+", 10)
    self:skinScrollBar(_G["HoloIgnoreScrollFrame"])
    
    self:moveObject(_G["HoloFriendsAddFriendButton"], nil, nil, "-", 70)
    self:moveObject(_G["HoloFriendsSendMessageButton"], "-", 20, nil, nil)
    
    self:moveObject(_G["HoloIgnoreAddIgnoreButton"], nil, nil, "-", 70)
    self:moveObject(_G["HoloIgnoreAddGroupButton"], "-", 20, nil, nil)
    
    self:moveObject(_G["HoloFriendsOnline"], "+", 147, "+", 230)
    
    self:removeRegions(_G["HoloFriendsFrame"], {3,4,5,6})
    self:applySkin(_G["HoloFriendsFrame"], {3,4,5,6})
    
    self:removeRegions(_G["HoloIgnoreFrame"], {3,4,5,6})
    self:applySkin(_G["HoloIgnoreFrame"], {3,4,5,6})

end

function oSkin:Skin_BuyPoisons()
 	if not self.db.profile.MerchantFrames then return end

    self:keepRegions(_G["BuyPoisonsFrame"], {6, 7, 8}) -- N.B. regions 6-8 are text
    
    _G["BuyPoisonsFrame"]:SetWidth(_G["BuyPoisonsFrame"]:GetWidth() * FxMult)
    _G["BuyPoisonsFrame"]:SetHeight(_G["BuyPoisonsFrame"]:GetHeight() * FyMult)
    
    self:moveObject(_G["BuyPoisonsVersionText"], nil, nil, "+", 6)
    self:moveObject(_G["BuyPoisonsFrameCloseButton"], "+", 28, "+", 8)
    self:moveObject(_G["BuyPoisonsItem1"], "-", 6, "+", 30)
    self:moveObject(_G["BuyPoisonsPageText"], "+", 12, "-", 59)
    self:moveObject(_G["BuyPoisonsPrevPageButton"], "-", 5, "-", 60)
    self:moveObject(_G["BuyPoisonsNextPageButton"], "-", 5, "-", 60)    
    self:moveObject(_G["BuyPoisonsMoneyFrame"], "+", 30, "-", 58)

    self:applySkin(_G["BuyPoisonsFrame"])

end

function oSkin:Auctioneer()
    if not self.db.profile.AuctionFrame then return end
    
    self:Hook("PanelTemplates_SetNumTabs", "Auctioneer_PT_SNT")
    
end

function oSkin:Auctioneer_PT_SNT(frame, numTabs)
--  self:Debug("Auctioneer_PT_SNT: [%s, %s]", frame:GetName(), numTabs)
    
    self.hooks.PanelTemplates_SetNumTabs(frame, numTabs)
    
    if frame:GetName() ~= "AuctionFrame" then return end 
    if numTabs ~= 5 then return end 
    
--  self:Debug("AH Num Tabs: [%s]", _G["AuctionFrame"].numTabs)
    
    for _, tabName in { _G["AuctionFrameTabSearch"], _G["AuctionFrameTabPost"] } do
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if self.db.profile.TexturedTab then 
            self:applySkin(tabName, nil, 0)
            self:setInactiveTab(tabName:GetName())
        else 
            self:applySkin(tabName)
        end
		self:moveObject(tabName, "+", 3, nil, nil)
    end
    
    -- Search Frame
    for _, ddName in { "SavedSearch", "Search", "BidTimeLeft", "BidCategory", "BidMinQuality", "BuyoutCategory", "BuyoutMinQuality", "PlainCategory", "PlainMinQuality", "ListColumn1", "ListColumn2", "ListColumn3", "ListColumn4", "ListColumn5", "ListColumn6"} do
        self:hookDDScript(_G["AuctionFrameSearch"..ddName.."DropDownButton"])
        self:keepRegions(_G["AuctionFrameSearch"..ddName.."DropDown"], {4}) -- N.B. region 4 is text
    end
    
    for i = 1, 6 do
        self:keepRegions(_G["AuctionFrameSearchListColumn"..i.."Sort"], {4, 5, 6}) -- N.B. region 4 is text, 5 is the arrow, 6 is the highlight
        self:applySkin(_G["AuctionFrameSearchListColumn"..i.."Sort"])
    end
    
    self:removeRegions(_G["AuctionFrameSearchListScrollFrame"])
    self:skinScrollBar(_G["AuctionFrameSearchListScrollFrame"]) 
        
    -- Post Frame
    self:removeRegions(_G["AuctionFramePostAuctionItem"], {1}) -- N.B. all other regions are text or icon texture
    self:applySkin(_G["AuctionFramePostAuctionItem"])
        
    for _, ddName in { "PriceModel", "ListColumn1", "ListColumn2", "ListColumn3", "ListColumn4", "ListColumn5", "ListColumn6"} do
        self:hookDDScript(_G["AuctionFramePost"..ddName.."DropDownButton"])
        self:keepRegions(_G["AuctionFramePost"..ddName.."DropDown"], {4}) -- N.B. region 4 is text
    end
        
    for i = 1, 6 do
        self:keepRegions(_G["AuctionFramePostListColumn"..i.."Sort"], {4, 5, 6}) -- N.B. region 4 is text, 5 is the arrow, 6 is the highlight
        self:applySkin(_G["AuctionFramePostListColumn"..i.."Sort"])
    end
    
    self:removeRegions(_G["AuctionFramePostListScrollFrame"])
    self:skinScrollBar(_G["AuctionFramePostListScrollFrame"]) 

end

function oSkin:KLHThreatMeter()

	self:removeRegions(_G["KLHTM_TitleFrame"])
	self:applySkin(_G["KLHTM_Frame"])
	
	local frame = CreateFrame("frame", nil, KLHTM_TitleFrame)
	frame:SetFrameLevel(2)
	frame:ClearAllPoints()
	frame:SetPoint("BOTTOMLEFT", KLHTM_TitleFrame, "BOTTOMLEFT", -5, -5)
	frame:SetPoint("BOTTOMRIGHT", KLHTM_TitleFrame, "BOTTOMRIGHT", 5, -5)
	frame:SetPoint("TOPLEFT", KLHTM_TitleFrame, "TOPLEFT", -5, 5)
	frame:SetPoint("TOPRIGHT", KLHTM_TitleFrame, "TOPRIGHT", 5, 5)
	self:applySkin(frame, nil, 0)

end

function oSkin:IgorsMassAuction()
	if not self.db.profile.AuctionFrame then return end

    self:Hook("IMA_AuctionFrameTab_OnClick", function(index)
        -- self:Debug("IMA_AuctionFrameTab_OnClick: [%s]", index)  
        if IMA_AuctionFrameTab_OnClickOrig ~= nil then IMA_AuctionFrameTab_OnClickOrig(index) end
        if not index then index = this:GetID() end
		if (AuctionFrameAuctions.page == nil) then
			AuctionFrameAuctions.page = 0
		end
        if index == 4 then	
            IMA_AuctionFrameMassAuction:Show()
        else
            IMA_AuctionFrameMassAuction:Hide()
        end
        end)

    _G["IMA_AuctionFrameMassAuction"]:SetWidth(_G["IMA_AuctionFrameMassAuction"]:GetWidth() + 74)
    _G["IMA_AuctionFrameMassAuction"]:SetHeight(_G["IMA_AuctionFrameMassAuction"]:GetHeight() - 6)
    
    self:moveObject(_G["IMA_AuctionsCloseButton"], "-", 74, "-", 6)
    self:moveObject(_G["IMA_SetAllPricesButton"], "-", 50, nil, nil)
    
    self:applySkin(_G["IMA_AuctionFrameMassAuction"])
    self:hookDDScript(_G["IMA_PriceSchemeDropDownButton"])
    self:keepRegions(_G["IMA_PriceSchemeDropDown"], {4}) -- N.B. region 4 is text
    self:moveObject(_G["IMA_MultiplierFramePriceCheckButton"], nil, nil, "+", 1)
    self:moveObject(_G["IMA_MultiplierFrameBuyoutCheckButton"], nil, nil, "-", 1)
    

    local tabName = _G["AuctionFrameTab4"]
	if self.db.profile.TexturedTab then 
        self:applySkin(tabName, nil, 0)
        self:setInactiveTab(tabName:GetName())
    else 
        self:applySkin(tabName)
    end

    self:removeRegions(_G["IMA_AcceptSendFrame"])
    self:applySkin(_G["IMA_AcceptSendFrame"], true)
    
end

function oSkin:myBindings()
	if not self.db.profile.MenuFrames then return end
	
	self:keepRegions(_G["myBindingsOptionsFrame"], {7, 8, 9, 10, 11, 12, 14}) -- N.B. regions 7 - 12, 14 are text
	
    _G["myBindingsOptionsFrame"]:SetHeight(_G["myBindingsOptionsFrame"]:GetHeight() - 15)

	self:removeRegions(_G["myBindingsOptionsHeadingsScrollFrame"])
	self:skinScrollBar(_G["myBindingsOptionsHeadingsScrollFrame"])
	self:removeRegions(_G["myBindingsOptionsBindingsScrollFrame"])
	self:skinScrollBar(_G["myBindingsOptionsBindingsScrollFrame"])
	
	for i = 1, 18 do
		self:removeRegions(_G["myBindingsOptionsBindCategory"..i], {1})
		self:applySkin(_G["myBindingsOptionsBindCategory"..i])
	end
	for i = 1, 18 do
		self:removeRegions(_G["myBindingsOptionsBindHeader"..i], {1})
		self:applySkin(_G["myBindingsOptionsBindHeader"..i])
	end
	
	self:moveObject(_G["myBindingsOptionsFrameOutputText"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameGameDefaultsButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameConfirmBindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameCancelBindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameUnbindButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameOkayButton"], nil, nil, "-", 15)
	self:moveObject(_G["myBindingsOptionsFrameCancelButton"], nil, nil, "-", 15)
	
	self:applySkin(_G["myBindingsOptionsFrame"], true)
	
end

function oSkin:Outfitter()
	if not self.db.profile.CharacterFrames then return end

	self:Hook("Outfitter_ShowPanel", function(tabId)
		-- self:Debug("Outfitter_ShowPanel: [%s]", tabId)
		self.hooks.Outfitter_ShowPanel(tabId)
		for i = 1, OutfitterFrame.numTabs do
			if i == tabId then
				self:setActiveTab("OutfitterFrameTab"..i)
			else
				self:setInactiveTab("OutfitterFrameTab"..i)
			end
		end
		end)

	self:Hook("OutfitterItemDropDown_Initialize", function()
		-- self:Debug("OutfitterItemDropDown_Initialize")
		self.hooks.OutfitterItemDropDown_Initialize()
		self:skinDropDownLists()
		end)
	
	self:HookScript(OutfitterMinimapButton, "OnMouseUp", function()
		-- self:Debug("OutfitterMinimapButton_OnMouseUp")
		self.hooks[OutfitterMinimapButton].OnMouseUp()
		self:skinDropDownLists()
		end)

	self:Hook("OutfitterStatDropdown_Initialize", function()
		-- self:Debug("OutfitterStatDropdown_Initialize")
		self.hooks.OutfitterStatDropdown_Initialize()
		self:skinDropDownLists()
		end)
	
	self:moveObject(_G["OutfitterButton"], nil, nil, "+", 30)
	
	self:keepRegions(_G["OutfitterFrame"], {3}) -- N.B. region 3 is text
	self:moveObject(_G["OutfitterFrame"], "+", 28, nil, nil)
	self:moveObject(_G["OutfitterCloseButton"], "-", 4, "-", 4)
	self:applySkin(_G["OutfitterFrame"])
	
	self:keepRegions(_G["OutfitterMainFrame"], {2, 3}) -- N.B. region 2 is text, 3 is icon
	self:removeRegions(_G["OutfitterMainFrameScrollbarTrench"])
	self:removeRegions(_G["OutfitterMainFrameScrollFrame"])
	self:skinScrollBar(_G["OutfitterMainFrameScrollFrame"])
	
	--	Outfitter Tabs
	for i = 1, OutfitterFrame.numTabs do

    	local tabName = _G["OutfitterFrameTab"..i]
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		-- nil out the OnShow script to stop the tabs being resized
		tabName:SetScript("OnShow", nil)
		tabName:SetWidth(tabName:GetTextWidth() + 30)
		_G[tabName:GetName().."HighlightTexture"]:SetWidth(tabName:GetTextWidth() + 30)


        if self.db.profile.TexturedTab then self:applySkin(tabName, nil, 0, 1)
		else self:applySkin(tabName) end
	
		if i == 1 then
			self:moveObject(tabName, "-", 0, "+", 4)
			self:setActiveTab(tabName:GetName())
		else
			self:moveObject(tabName, "-", 10, nil, nil)
			self:setInactiveTab(tabName:GetName())
		end
		
	end
	
	-- New Outfit
	self:keepRegions(_G["OutfitterNameOutfitDialog"], {11}) -- N.B. regions 2 & 3 are text
	self:moveObject(_G["OutfitterNameOutfitDialogTitle"], nil, nil, "_", 6)
	self:removeRegions(_G["OutfitterNameOutfitDialogCreateUsing"], {1, 2, 3}) -- N.B. region 4 is text
	self:applySkin(_G["OutfitterNameOutfitDialog"])
		
end

function oSkin:UberQuest()
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

function oSkin:CharactersViewer()
	if not self.db.profile.CharacterFrames then return end

	if not self:isVersion("CharactersViewer", 103, CharactersViewer.version.number) then return end
	
	self:hookDDScript(_G["CharactersViewerDropDownButton"])
	self:hookDDScript(_G["CharactersViewerDropDown2Button"])

	self:removeRegions(_G["CharactersViewerDropDown"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CharactersViewerDropDown2"], {1, 2, 3}) -- N.B. region 4 is text
	self:moveObject(_G["CharactersViewerDropDown2"], "-", 10, "-", 14)
	self:removeRegions(_G["CharactersViewer_Frame"], {1, 2, 3, 4, 5}) -- N.B. other regions are text
	_G["CharactersViewer_Frame"]:SetWidth(_G["CharactersViewer_Frame"]:GetWidth() * FxMult)
	_G["CharactersViewer_Frame"]:SetHeight(_G["CharactersViewer_Frame"]:GetHeight() * FyMult)
	self:moveObject(_G["CharactersViewer_FrameTitleText"], nil, nil, "-", 30)
	self:moveObject(_G["CharactersViewer_RestedFrame"], "-", 20, "+", 30)
	self:moveObject(_G["CharactersViewer_FrameDetailTitle0"], "-", 10, nil, nil)
	self:moveObject(_G["CharactersViewer_FrameDetailText0"], "-", 30, nil, nil)
	self:moveObject(_G["CharactersViewer_FrameStatsTitle1"], "-", 10, "+", 20)
	self:moveObject(_G["CharactersViewer_CloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["CharactersViewer_FrameItem1"], "-", 8, "+", 20)
	self:moveObject(_G["CharactersViewer_FrameItem10"], "+", 30, "+", 20)
	self:moveObject(_G["CharactersViewer_FrameItem16"], "-", 10, nil, nil)
	self:moveObject(_G["CharactersViewerResistanceFrame"], "-", 10, "+", 20)
	self:moveObject(_G["CharactersViewerDropDown"], "-", 10, "-", 14)
	self:moveObject(_G["CharactersViewer_MoneyFrame"], "+", 30, "-", 80)
	self:applySkin(_G["CharactersViewer_Frame"])

	for i = 0, 4 do
		bagName = _G["CharactersViewer_ContainerFrame"..i]
		self:keepRegions(bagName, {6}) -- N.B. region 6 is text
		self:moveObject(_G[bagName:GetName().."Name"], "-", 10, nil, nil)
		_G[bagName:GetName().."Name"]:SetTextColor(1, 1, 1)
		self:applySkin(bagName)
		self:HookScript(bagName, "OnShow", function()
			-- self:Debug(this:GetName().." - OnShow")
			self.hooks[this].OnShow()
			self:shrinkBag(this)
			end)
	end

	keyringName = _G["CharactersViewer_KeyringContainerFrame"]
	self:keepRegions(keyringName, {6}) -- N.B. region 6 is text
	self:moveObject(_G[keyringName:GetName().."Name"], "-", 10, nil, nil)
	_G[keyringName:GetName().."Name"]:SetTextColor(1, .7, 0)
	self:applySkin(keyringName)
	self:HookScript(keyringName, "OnShow", function()
		-- self:Debug(this:GetName().." - OnShow")
		self.hooks[this].OnShow()
		self:shrinkBag(this)
    	end)
	
	-- Bank Frame
	self:hookDDScript(_G["CharactersViewerDropDown3Button"])
	self:removeRegions(_G["CharactersViewerDropDown3"], {1, 2, 3}) -- N.B. region 4 is text
	self:removeRegions(_G["CharactersViewerBankFrame"], {1, 2}) -- N.B. other regions are text
	_G["CharactersViewerBankFrame"]:SetWidth(_G["CharactersViewerBankFrame"]:GetWidth() * FxMult)
	_G["CharactersViewerBankFrame"]:SetHeight(_G["CharactersViewerBankFrame"]:GetHeight() * FyMult - 40)
	self:moveObject(_G["CharactersViewerBankItems_TitleText"], nil, nil, "-", 50)
	for i, v in pairs({ _G["CharactersViewerBankFrame"]:GetRegions() }) do
		-- regions 4 and 5 hold the slot text
		if i == 4  or i == 5 then
			self:moveObject(v, "+", 10, "-", 30)
		end
	end
	self:moveObject(_G["CharactersViewerBankMoney1"], "-", 120, "-", 80)
	self:moveObject(_G["CharactersViewerBankItems_MoneyFrameTotal1"], "-", 120, "-", 80)
	self:moveObject(_G["CharactersViewerBankItems_CloseButton"], "+", 28, "+", 8)
	self:moveObject(_G["CharactersViewerBankItem_Item1"], "-", 10, "+", 25)
	self:moveObject(_G["CharactersViewerDropDown3"], "+", 180, "-", 50)
	self:applySkin(_G["CharactersViewerBankFrame"])
	
	for i = 5, 10 do
		bankBagName = _G["CharactersViewer_BankItemsContainerFrame"..i]
		self:keepRegions(bankBagName, {6}) -- N.B. region 6 is text
		self:moveObject(_G[bankBagName:GetName().."Name"], "-", 10, nil, nil)
		_G[bankBagName:GetName().."Name"]:SetTextColor(.3, .3, 1)
		self:applySkin(bankBagName)
		self:HookScript(bankBagName, "OnShow", function()
			-- self:Debug(this:GetName().." - OnShow")
			self.hooks[this].OnShow()
			self:shrinkBag(this)
			end)
	end
	
end

function oSkin:ATSW()
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

function oSkin:AutoBag()

	-- Auto Generated by Baddiel, except comment lines :)
	-- self:keepRegions(AB_Profile_ListBoxHighlight {1})                                                              
	-- self:applySkin(AB_Profile_ListBoxHighlight nil)                                                              
	self:keepRegions(AB_Profile_ListBoxScrollFrame, {})                                                              
	self:skinScrollBar(AB_Profile_ListBoxScrollFrame)                                                             
	self:keepRegions(AB_Profile_ListBox, {9})                                                              
	self:applySkin(AB_Profile_ListBox, nil)                                                              
	self:keepRegions(AB_Profile_AddTextInput, {1, 5})                                                               
	self:applySkin(AB_Profile_AddTextInput, nil)                                                              
	self:keepRegions(AB_Slot_Dropdown, {4, 5})                                                               
	self:hookDDScript(AB_Slot_DropdownButton)                                                             
	self:keepRegions(AB_Divider_Profiles, {2})                                                              
	-- self:applySkin(AB_Divider_Profiles true)                                                                                                                                                                     
	self:keepRegions(AB_Arrange_ListBoxHighlight, {1})                                                              
	self:applySkin(AB_Arrange_ListBoxHighlight, nil)                                                              
	self:keepRegions(AB_Arrange_ListBoxScrollFrame, {})                                                              
	self:skinScrollBar(AB_Arrange_ListBoxScrollFrame)                                                             
	self:keepRegions(AB_Arrange_ListBox, {9})                                                              
	self:applySkin(AB_Arrange_ListBox, nil)                                                              
	self:keepRegions(AB_Arrange_AddTextInput, {1, 5})                                                               
	self:applySkin(AB_Arrange_AddTextInput, nil)                                                              
	self:keepRegions(AB_Divider_AutoBag, {2})                                                              
	-- self:applySkin(AB_Divider_AutoBag true)                                                                                                                                                                    
	self:keepRegions(AB_Bag_Dropdown, {4, 5})                                                               
	self:hookDDScript(AB_Bag_DropdownButton)                                                             
	local l, r, t, b = AB_Arrange_AddTextInput:GetTextInsets()                                                                
	AB_Arrange_AddTextInput:SetTextInsets(l + 5, r + 5, t, b)                                                                
	AB_Arrange_AddTextInput:SetHeight(26)                                                             
	local l, r, t, b = AB_Profile_AddTextInput:GetTextInsets()                                                                
	AB_Profile_AddTextInput:SetTextInsets(l + 5, r + 5, t, b)                                                                
	AB_Profile_AddTextInput:SetHeight(26)                                                             
	self:keepRegions(AB_Options, {11, 12})                                                               
	self:applySkin(AB_Options, true)                                                              

end