
function Skinner:BuyPoisons()
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
