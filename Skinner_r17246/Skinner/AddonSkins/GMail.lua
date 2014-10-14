
function Skinner:GMail()
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
	self:skinEditBox(_G["GMailNameEditBox"], {6})
	self:skinEditBox(_G["GMailSubjectEditBox"], {6})
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
