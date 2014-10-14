
function Skinner:CT_RaidAssist()
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
	for k, v in pairs({ "NameEB", "DebuffTitleEB", "DebuffTypeEB", "DebuffDescriptEB" }) do
		local ebName = _G["CT_RAMenuFrameDebuffSettings"..v]
	  	self:moveObject(ebName, "+", 5, nil, nil)  
		ebName:SetWidth(ebName:GetWidth() + 10)
		self:skinEditBox(ebName)
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
	local ebName = _G["CT_RAMenu_NewSetFrameNameEB"]
	self:moveObject(ebName, "+", 5, "-", 10)  
	ebName:SetWidth(ebName:GetWidth() + 10)
    self:skinEditBox(ebName)
	
end
