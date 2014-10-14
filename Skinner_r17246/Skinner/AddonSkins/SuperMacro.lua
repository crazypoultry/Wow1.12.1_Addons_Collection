
function Skinner:SuperMacro()

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
