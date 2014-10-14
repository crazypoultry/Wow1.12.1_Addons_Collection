--$Id: OneRing.lua 12749 2006-10-03 02:19:17Z kergoth $
OneRing = OneCore:NewModule("OneRing", "AceEvent-2.0", "AceHook-2.0", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")
local L = AceLibrary("AceLocale-2.1"):GetInstance("OneRing", true)

function OneRing:OnInitialize()
    
    OneRingFrameName:ClearAllPoints()
    OneRingFrameName:SetPoint("TOPLEFT", "OneRingFrame", "TOPLEFT", 10, -15)
	OneRingFrameName:SetText(UnitName("player").. L["'s Keyring"])
    OneRingFrameConfigButton:Hide()
    OneRingFrameBagButton:Hide()
    OneRingFrameMoneyFrame:Hide()
    
	self.fBags = {-2}
    self.rBags = {-2}

    self.frame = OneRingFrame
	self.frame.handler = self
    self.frame.bags = {}
    
    
    
    local defaults = OneCore.defaults
    defaults.cols = 4
    
    self:RegisterDB("OneRingDB")
	self:RegisterDefaults('profile', defaults)
end

function OneRing:OnEnable()
   	self:RegisterEvent("BAG_UPDATE",			  function() self:UpdateBag(arg1) end)
	self:RegisterEvent("BAG_UPDATE_COOLDOWN",	  function() self:UpdateBag(arg1) end)
    
    self:Hook("ToggleKeyRing", function() if self.frame:IsVisible() then self.frame:Hide() else self.frame:Show() end end)
end

function OneRing:OnCustomShow()
    if not OneBag.frame:IsVisible() then 
        this:ClearAllPoints() 
        this:SetPoint("CENTER", UIParent, "CENTER", 0, 0) 
    else 
        this:ClearAllPoints() 
        this:SetPoint("BOTTOMLEFT", OneBagFrame, "TOPLEFT", 0, 8) 
    end
end

function OneRing:OnCustomHide()
end
