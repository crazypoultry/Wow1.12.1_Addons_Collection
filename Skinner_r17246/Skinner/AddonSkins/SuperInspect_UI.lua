
function Skinner:SuperInspect_UI()
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
