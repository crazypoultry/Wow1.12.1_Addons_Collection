-- BuyEmAll - By Cogwheel.

-- Instantiate BuyEmAll
BuyEmAll = AceLibrary("AceAddon-2.0"):new("AceHook-2.0")

-- Localize
local L = AceLibrary("AceLocale-2.1"):GetInstance("BuyEmAll", true)

-- These are used for the text on the Max and Stack buttons. See BuyEmAll.xml.
BUYEMALL_MAX = L"Max"
BUYEMALL_STACK = L"Stack"


--[[
It's ALIVE!!! Muahahahahhahahaa!!!!!!
]]
function BuyEmAll:OnEnable()
    -- Set up confirmation dialog
    StaticPopupDialogs["BUYEMALL_CONFIRM"] = {
        text = L"Are you sure you want to buy\n %d × %s?",
        button1 = YES,
        button2 = NO,
        OnAccept = function(amount) self:DoPurchase(amount) end,
        timeout = 0,
        hideOnEscape = true,
    }
    
    -- Hook clicking on merchant item buttons
    self:Hook("MerchantItemButton_OnClick")
    self:HookScript(MerchantFrame, "OnHide", "MerchantFrame_OnHide")
    
    DEFAULT_CHAT_FRAME:AddMessage("BuyEmAll - By Cogwheel\nInspired by Shadowglen of Llane")
end




function BuyEmAll:MoneyFrame_OnLoad()
    -- Set up money frame
    MoneyTypeInfo["BUYEMALL"] = {
        UpdateFunc = function() return 0 end, -- Stub to satisfy MoneyFrame_SetType
        showSmallerCoins = "Backpack",
        fixedWidth = 1,
        collapse = 1,
    }
    BuyEmAllMoneyFrame.small = 1
    MoneyFrame_SetType("BUYEMALL")
end




--[[
Makes sure the BuyEmAll frame goes away when you leave a vendor
]]
function BuyEmAll:MerchantFrame_OnHide(...)
    BuyEmAllFrame:Hide()
    return self.hooks[MerchantFrame]["OnHide"].orig(unpack(arg))
end




--[[
Hooks left-clicks on merchant item buttons
]]
function BuyEmAll:MerchantItemButton_OnClick(button, ignoreModifiers)
    if MerchantFrame.selectedTab == 1 
       and IsShiftKeyDown()
       and not IsControlKeyDown()
       and not ignoreModifiers
       and not (ChatFrameEditBox:IsVisible() and button == "LeftButton") then
	   
        -- Set up various data before showing the BuyEmAll frame
        self.itemIndex = this:GetID()

        local name, texture, price, quantity, numAvailable = 
            GetMerchantItemInfo(self.itemIndex)
        self.preset = quantity
        self.price = price
        self.itemName = name
        self.available = numAvailable
        
        local bagMax, specialMax, stack =
            self:FreeBagSpace(GetMerchantItemLink(self.itemIndex))
        self.stack = stack
        self.fit = floor(bagMax / quantity) * quantity + specialMax
        self.afford = floor(GetMoney() / price) * quantity
        self.max = min(self.fit, self.afford)
        if numAvailable > -1 then
            self.max = min(self.max, numAvailable * quantity)
        end
        if self.max == 0 or not name then
            return
        elseif self.max == 1 then
            MerchantItemButton_OnClick("LeftButton", 1)
            return
        end
        
        specialMax = floor(specialMax / quantity) * quantity
        self.defaultStack =
            specialMax > 0 and specialMax <= self.max and specialMax or quantity
		
		self.split = self.defaultStack
		
		self.partialFit = mod(self.fit, stack)
		self:SetStackClick()
		
        self:Show()
		
    else
        self.hooks.MerchantItemButton_OnClick.orig(button, ignoreModifiers)
    end
end




--[[
Prepare the various UI elements of the BuyEmAll frame and show it
]]
function BuyEmAll:Show()
	self.typing = 0
	BuyEmAllLeftButton:Disable()
	BuyEmAllRightButton:Enable()
 
    BuyEmAllStackButton:Enable()
    if self.max < self.stackClick then
        BuyEmAllStackButton:Disable()
    end

	BuyEmAllFrame:ClearAllPoints()
	BuyEmAllFrame:SetPoint("BOTTOMLEFT", this, "TOPLEFT", 0, 0)
    
	BuyEmAllFrame:Show()
    self:UpdateDisplay()
end




--[[
If the amount is more than stack and defaultStack, show a confirmation.
Otherwise, do the purchase
]]
function BuyEmAll:VerifyPurchase(amount)
    amount = amount or self.split
    if (amount > 0) then
        amount = ceil(amount/self.preset) * self.preset
        if amount > self.stack and amount > self.defaultStack then
            self:DoConfirmation(amount)
        else
            self:DoPurchase(amount)
        end
    end
end




--[[
Makes the actual purchase(s)
amount must be a multiple of the preset stack size if preset stack size > 1
]]
function BuyEmAll:DoPurchase(amount)
    BuyEmAllFrame:Hide()
    
    local numLoops, purchAmount, leftover
    
    if self.preset > 1 then
        numLoops = amount/self.preset
        purchAmount = 1
        leftover = 0
    else
        numLoops = floor(amount/self.stack)
        purchAmount = self.stack
        leftover = mod(amount, self.stack)
    end
    
    for i = 1, numLoops do
        BuyMerchantItem(self.itemIndex, purchAmount)
    end
    
    if leftover > 0 then BuyMerchantItem(self.itemIndex, leftover) end
end





--[[
Changes the money display to however much amount of the item will cost. If
amount is not specified, it uses the current split value.
]]
function BuyEmAll:UpdateDisplay(amount)
	
	local purchase = ceil((amount and amount or self.split) / self.preset)
	local cost = purchase * self.price
	MoneyFrame_Update("BuyEmAllMoneyFrame", cost)
	
	--[[ Amount is only used for previewing when hovering over the buttons.
	the folowing code will only execute when the purchase amount is actually
	changed. ]]
	if not amount and not self.isUpdating then
		self.isUpdating = true
		--[[ This wrapper is kind of a hack... Calling :Enable() or :Disable() on
		the	Stack button triggers certain events which call UpdateDisplay causing a
		stack overflow, hence the isUpdating flag]]
		
		BuyEmAllText:SetText(self.split)
		BuyEmAllLeftButton:Enable()
		BuyEmAllRightButton:Enable()
		if self.split == self.max then
			BuyEmAllRightButton:Disable()
		elseif self.split <= self.preset then
			BuyEmAllLeftButton:Disable()
		end
		
		self:SetStackClick()
		BuyEmAllStackButton:Enable()
		if self.max < self.stackClick then
			BuyEmAllStackButton:Disable()
		end
		
		self.isUpdating = nil
	end
end




--[[
Shows the confirmation dialog
]]
function BuyEmAll:DoConfirmation(amount)
    local dialog = StaticPopup_Show("BUYEMALL_CONFIRM", amount, self.itemName)
    dialog.data = amount
end




--[[
Calculates the amount that the Stack button will enter
]]
function BuyEmAll:SetStackClick()
	local increase = self.partialFit - mod(self.split, self.stack)
	self.stackClick = self.split + (increase == 0 and self.stack or increase)
end




--[[
OnClick handler for the four main buttons
]]
function BuyEmAll:OnClick()
    if this == BuyEmAllOkayButton then
        self:VerifyPurchase()
    elseif this == BuyEmAllCancelButton then
        BuyEmAllFrame:Hide()
    elseif this == BuyEmAllStackButton then
        self.split = self.stackClick
        self:UpdateDisplay()
		if this:IsEnabled() == 1 then
			self:OnEnter()
		else
			GameTooltip:Hide()
		end
    elseif this == BuyEmAllMaxButton then
        self.split = self.max
        self:UpdateDisplay()
    end
end




--[[
Allows you to type a number to buy. This is adapted directly from the Default
UI's code.
]]
function BuyEmAll:OnChar()
	if arg1 < "0" or arg1 > "9" then
		return
	end

	if self.typing == 0 then
		self.typing = 1
		self.split = 0
	end

	local split = (self.split * 10) + arg1
	if split == self.split then
		if self.split == 0 then
			self.split = 1
		end
        
        self:UpdateDisplay()
		return
	end

	if split <= self.max then
		self.split = split
	elseif split == 0 then
		self.split = 1
	end
    self:UpdateDisplay()
end




--[[
Key handler for keys other than 0-9
]]
function BuyEmAll:OnKeyDown()
	if arg1 == "BACKSPACE" or arg1 == "DELETE" then
		if self.typing == 0 or self.split == 1 then
			return
		end

		self.split = floor(self.split / 10)
		if self.split <= 1 then
			self.split = 1
			self.typing = 0
        end
        
        self:UpdateDisplay()
	elseif arg1 == "ENTER" then
		self:VerifyPurchase()
	elseif arg1 == "ESCAPE" then
		BuyEmAllFrame:Hide()
	elseif arg1 == "LEFT" or arg1 == "DOWN" then
		BuyEmAll:Left_Click()
	elseif arg1 == "RIGHT" or arg1 == "UP" then
		BuyEmAll:Right_Click()
	end
end




--[[
Decreases the amount by however much is necessary to go down to the next
lowest multiple of the preset stack size.
]]
function BuyEmAll:Left_Click()
	if self.split <= self.preset then
		return
	end
    
    local decrease = mod(self.split, self.preset)
    decrease = decrease == 0 and self.preset or decrease

	self.split = self.split - decrease

    self:UpdateDisplay()
end




--[[
Increases the amount by however much is necessary to go up to the next highest
multiple of the preset stack size.
]]
function BuyEmAll:Right_Click()
    local increase = self.preset - mod(self.split, self.preset)

	if self.split + increase > self.max then
		return
	end
    
	self.split = self.split + increase
    
    self:UpdateDisplay()
end




--[[
This table is used for the two functions that follow
]]
BuyEmAll.lines = {
	stack = {
		label = L"Stack purchase",
		field = "stackClick",
		{ label = L"Stack size", field = "stack" },
		{ label = L"Partial stack", field = "partialFit" },
	},
	max = {
		label = L"Maximum purchase",
		field = "max",
		{ label = L"You can afford", field = "fit" },
		{ label = L"You can fit", field = "afford" },
		{
			label = L"Vendor has", 
			field = "available",
			Hide = function()
				return BuyEmAll.available <= 1
			end
		},
	},
}




--[[
Shows tooltips when you hover over the Stack or Max buttons
]]
function BuyEmAll:OnEnter()
    local lines = self.lines[this == BuyEmAllMaxButton and "max" or "stack"]
	
	lines.amount = self[lines.field]
	for i, line in ipairs(lines) do
		line.amount = self[line.field]
	end
        
	self:CreateTooltip(lines)
	
    self:UpdateDisplay(lines.amount)
end




--[[
Creates the tooltip from the given lines table. See the structure of lines above for
more insight.
]]
function BuyEmAll:CreateTooltip(lines)
    GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
    GameTooltip:SetText(lines.label.."|cFFFFFFFF - |r"..GREEN_FONT_COLOR_CODE..lines.amount.."|r")

	for _, line in ipairs(lines) do
		if not (line.Hide and line.Hide()) then
			local color = 
				line.amount == lines.amount and GREEN_FONT_COLOR or HIGHLIGHT_FONT_COLOR
			GameTooltip:AddDoubleLine(line.label, line.amount, 1,1,1, color.r,color.g,color.b)
		end
	end
	
    GameTooltip:Show()
end




--[[
Hides the tooltip
]]
function BuyEmAll:OnLeave()
    self:UpdateDisplay()
    GameTooltip:Hide()
end




--[[
When the BuyEmAll frame is closed, close any confirmations waiting for a
response.
]]
function BuyEmAll:OnHide()
    StaticPopup_Hide("BUYEMALL_CONFIRM")
end




--[[
Herb & Enchanting item lists from Periodic Table
]]
BuyEmAll.specialBagItems = {
    herb = "3358 8839 13466 4625 13467 3821 785 13465 13468 2450 2452 3818 3355 3357 8838 3369 3820 8153 8836 13463 8845 8846 13464 2447 2449 765 2453 3819 3356 8831",
    enchanting = "11083 16204 11137 11176 10940 11174 10938 11135 11175 16202 11134 16203 10998 11082 10939 11084 14343 11139 10978 11177 14344 11138 11178",
}




--[[
Determine whether an item is an herb or enchanting material
]]
function BuyEmAll:IsSpecialBagItem(bagType, itemID)
    for curID in string.gfind(self.specialBagItems[bagType], "%d+") do
        if itemID == curID then return true end
    end
    return false
end




--[[
Adapted from example on WoWWiki.com
]]
function BuyEmAll:GetItemInfoFromLink(itemLink)
    local itemID
    if type(itemLink) == "string" then
        _,_, itemID = string.find(itemLink, "item:(%d-):")
    end
    if itemID then
        return itemID, GetItemInfo(itemID)
    end
end




--[[
Determines the amount of an item you can fit in your bags.
Parameters:
    itemLink - the item link string for the item
Returns:
    freeSpace - Amount of the item you can fit in your bags (not including your
        quiver or ammo pouch)
    specialSpace - Amount of the item you can fit in your quiver or ammo pouch
    stackSize - Amount of the item in a full stack
]]
function BuyEmAll:FreeBagSpace(itemLink)
    local returns = { freeSpace = 0, specialSpace = 0 }
    local itemID,name,_,_,_,_,itemSubType, stackSize = 
        self:GetItemInfoFromLink(itemLink)
    
    for theBag = 0,4 do
        local which, doBag = "freeSpace", true
        
        if theBag > 0 then -- 0 is always the backpack
            local _,_,_,_,_,_,bagSubType = self:GetItemInfoFromLink(
                GetInventoryItemLink("player", theBag + 19) -- Bag #1 is in inventory slot 20
            )
            if bagSubType == "Ammo Pouch" and itemSubType == "Bullet" or
               bagSubType == "Quiver" and itemSubType == "Arrow" then
                which = "specialSpace"
            elseif bagSubType == "Ammo Pouch" and itemSubType ~= "Bullet" or
                   bagSubType == "Quiver" and itemSubType ~= "Arrow" or
                   bagSubType == "Herb Bag"
                        and not self:IsSpecialBagItem("herb") or
                   bagSubType == "Enchanting Bag"
                        and not self:IsSpecialBagItem("enchanting") then
                doBag = false
            end
        end
            
        if doBag then
            local numSlot = GetContainerNumSlots(theBag)
            for theSlot = 1, numSlot do
                local itemLink = GetContainerItemLink(theBag, theSlot)
                if not itemLink then
                    returns[which] = returns[which] + stackSize
                elseif string.find(itemLink, "%["..name.."%]") then
                    local _,itemCount = GetContainerItemInfo(theBag, theSlot)
                    returns[which] =
                        returns[which] + stackSize - itemCount
                end
            end
        end
    end
    
    return returns.freeSpace, returns.specialSpace, stackSize
end
