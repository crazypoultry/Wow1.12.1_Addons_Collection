
function Skinner:CT_MailMod()
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
	self:skinEditBox(_G["CT_MailNameEditBox"], {6})
	self:skinEditBox(_G["CT_MailSubjectEditBox"], {6})
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
