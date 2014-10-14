
function Skinner:IgorsMassAuction()
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
