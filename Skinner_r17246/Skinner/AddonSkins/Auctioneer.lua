
function Skinner:Auctioneer()
    if not self.db.profile.AuctionFrame or self.initialized.Auctioneer then return end
	-- self:Debug("Auctioneer Loaded: [%s]", _G["AuctionFrame"].numTabs)

    if _G["AuctionFrame"].numTabs ~= 5 then
		self:ScheduleEvent(self.Auctioneer, 0.1, self)
		return
	end
	
	self.initialized.Auctioneer= true
	    
    for k, tabName in pairs({ _G["AuctionFrameTabSearch"], _G["AuctionFrameTabPost"] }) do
		self:keepRegions(tabName, {7, 8}) -- N.B. region 7 is the Text, 8 is the highlight
		if self.db.profile.TexturedTab then 
            self:applySkin(tabName, nil, 0)
            self:setInactiveTab(tabName:GetName())
        else 
            self:applySkin(tabName)
        end
		-- self:moveObject(tabName, "+", 3, nil, nil)
    end
    
-->>-- Search Frame
    for k, v in pairs({ "SavedSearch", "Search", "BidTimeLeft", "BidCategory", "BidMinQuality", "BuyoutCategory", "BuyoutMinQuality", "PlainCategory", "PlainMinQuality", "ListColumn1", "ListColumn2", "ListColumn3", "ListColumn4", "ListColumn5", "ListColumn6" }) do
        self:hookDDScript(_G["AuctionFrameSearch"..v.."DropDownButton"])
        self:keepRegions(_G["AuctionFrameSearch"..v.."DropDown"], {4}) -- N.B. region 4 is text
    end
    
    for i = 1, 6 do
        self:keepRegions(_G["AuctionFrameSearchListColumn"..i.."Sort"], {4, 5, 6}) -- N.B. region 4 is text, 5 is the arrow, 6 is the highlight
        self:applySkin(_G["AuctionFrameSearchListColumn"..i.."Sort"])
    end
    
    self:removeRegions(_G["AuctionFrameSearchListScrollFrame"])
    self:skinScrollBar(_G["AuctionFrameSearchListScrollFrame"]) 

	self:skinMoneyFrame(_G["AuctionFrameSearchBidMinProfit"], true)
	self:skinMoneyFrame(_G["AuctionFrameSearchBuyoutMinProfit"], true)
	self:skinMoneyFrame(_G["AuctionFrameSearchCompeteUndercut"], true)
	self:skinMoneyFrame(_G["AuctionFrameSearchPlainMaxPrice"], true)
	
	self:skinEditBox(_G["AuctionFrameSearchSaveSearchEdit"])
	self:moveObject(_G["AuctionFrameSearchBidMinPercentLessEdit"], nil, nil, "+", 4)
	self:skinEditBox(_G["AuctionFrameSearchBidMinPercentLessEdit"])
	self:moveObject(_G["AuctionFrameSearchBidSearchEdit"], "-", 5, "+", 4)
	self:skinEditBox(_G["AuctionFrameSearchBidSearchEdit"])
	self:moveObject(_G["AuctionFrameSearchBuyoutMinPercentLessEdit"], nil, nil, "+", 4)
	self:skinEditBox(_G["AuctionFrameSearchBuyoutMinPercentLessEdit"])
	self:moveObject(_G["AuctionFrameSearchBuyoutSearchEdit"], "-", 5, "+", 4)
	self:skinEditBox(_G["AuctionFrameSearchBuyoutSearchEdit"])
	self:moveObject(_G["AuctionFrameSearchPlainSearchEdit"], "-", 5, "+", 4)
	self:skinEditBox(_G["AuctionFrameSearchPlainSearchEdit"])
        
-->>-- Post Frame
    self:removeRegions(_G["AuctionFramePostAuctionItem"], {1}) -- N.B. all other regions are text or icon texture
    self:applySkin(_G["AuctionFramePostAuctionItem"])
        
    for k, v in pairs({ "PriceModel", "ListColumn1", "ListColumn2", "ListColumn3", "ListColumn4", "ListColumn5", "ListColumn6" }) do
        self:hookDDScript(_G["AuctionFramePost"..v.."DropDownButton"])
        self:keepRegions(_G["AuctionFramePost"..v.."DropDown"], {4}) -- N.B. region 4 is text
    end
        
    for i = 1, 6 do
        self:keepRegions(_G["AuctionFramePostListColumn"..i.."Sort"], {4, 5, 6}) -- N.B. region 4 is text, 5 is the arrow, 6 is the highlight
        self:applySkin(_G["AuctionFramePostListColumn"..i.."Sort"])
    end
    
    self:removeRegions(_G["AuctionFramePostListScrollFrame"])
    self:skinScrollBar(_G["AuctionFramePostListScrollFrame"]) 

	self:moveObject(_G["AuctionFramePostStartPrice"], "-", 5, "+", 5)
	self:skinMoneyFrame(_G["AuctionFramePostStartPrice"], true)
	self:moveObject(_G["AuctionFramePostBuyoutPrice"], "-", 5, "+", 5)
	self:skinMoneyFrame(_G["AuctionFramePostBuyoutPrice"], true)

	self:moveObject(_G["AuctionFramePostStackSize"], "-", 5, "+", 5)
	self:skinEditBox(_G["AuctionFramePostStackSize"])
	self:skinEditBox(_G["AuctionFramePostStackCount"])

end
