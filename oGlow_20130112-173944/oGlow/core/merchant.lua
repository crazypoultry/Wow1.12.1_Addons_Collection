-- Globally used
local G = getfenv(0)
local oGlow = oGlow

-- Merchant
local GetMerchantNumItems = GetMerchantNumItems
local GetMerchantItemLink = GetMerchantItemLink

local numPage = MERCHANT_ITEMS_PER_PAGE

-- Addon
local MerchantFrame = MerchantFrame

local update = function()
	if(MerchantFrame.selectedTab == 1) then
		local numItems = GetMerchantNumItems()
		for i=1, numPage do
			local index = (((MerchantFrame.page - 1) * numPage) + i)
			local link = GetMerchantItemLink(index)
			local button = G["MerchantItem"..i.."ItemButton"]

			if(link and not oGlow.preventMerchant) then
				local q = select(3, GetItemInfo(link))
				oGlow(button, q)
			elseif(button.bc) then
				button.bc:Hide()
			end
		end
	else
		local numItems = GetNumBuybackItems()
		for i=1, numPage do
			local index = (((MerchantFrame.page - 1) * numPage) + i)
			local link = GetBuybackItemLink(index)
			local button = G["MerchantItem"..i.."ItemButton"]

			if(link and not oGlow.preventBuyback) then
				local q = select(3, GetItemInfo(link))
				oGlow(button, q)
			elseif(button.bc) then
				button.bc:Hide()
			end
		end
	end
end

hooksecurefunc("MerchantFrame_Update", update)
oGlow.updateMerchant = update
