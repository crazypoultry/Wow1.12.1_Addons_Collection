--[[
	Ludwig_SellValue -
		Originally based on SellValueLite, this addon allows viewing of sellvalues
--]]

local lastMoney = 0;

--[[ Local Functions ]]--

local function LinkToID(link)
	if(link) then
		local _, _, id = string.find(link, "(%d+):") ;
		return id;
	end
end

local function SaveCost(id, totalCost, count)
	if count and count > 0 and totalCost and totalCost > 0 then
		if (not Ludwig_SellValues) then
			Ludwig_SellValues = {};
		end
		Ludwig_SellValues[id] = totalCost / count;
	end
end

local function AddMoneyToTooltip(frame, id, count)
    if Ludwig_SellValues and not MerchantFrame:IsVisible() and count then
		local price = Ludwig_SellValues[id];

		if price and price ~= 0then
			frame:AddLine(SELLVALUE_COST, 1.0, 1.0,	0);
			SetTooltipMoney(frame, price * count);
			frame:Show();
		end
    end
end

--[[  Function Hooks ]]--

local Blizz_ContainerFrameItemButton_OnEnter = ContainerFrameItemButton_OnEnter;
ContainerFrameItemButton_OnEnter = function()
	Blizz_ContainerFrameItemButton_OnEnter();

	local bag = this:GetParent():GetID();
	local slot = this:GetID();
	local id = LinkToID( GetContainerItemLink(bag, slot ) );
	
	if (id) then
		local _, count = GetContainerItemInfo(bag, slot);
		AddMoneyToTooltip(GameTooltip, id, count);
		GameTooltip:Show();
	end
end;

local Bliz_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
GameTooltip.SetLootItem = function(self, slot)
	Bliz_GameTooltip_SetLootItem(self, slot);
	
	local id = LinkToID(GetLootSlotLink(slot));

	if (id) then
		local _, _, count = GetLootSlotInfo(slot);
		AddMoneyToTooltip(self, name, count);
		self:Show();
	end
end;

local Bliz_SetHyperlink = GameTooltip.SetHyperlink;
GameTooltip.SetHyperlink = function(self, link, count)
	if(link) then
		Bliz_SetHyperlink(self, link);
		
		if(not count) then 
			count = 1; 
		end
		
		local id = LinkToID( link );
		if( id ) then
			AddMoneyToTooltip(self, id, count);
		else
			AddMoneyToTooltip(self, link, count);
		end
		self:Show();
	end
end;

local Bliz_GameTooltip_SetLootRollItem = GameTooltip.SetLootRollItem;
GameTooltip.SetLootRollItem = function(self, rollID) 
	Bliz_GameTooltip_SetLootRollItem(self, rollID);
	
	local id = LinkToID( GetLootRollItemLink(rollID) );
	local _, _, count = GetLootRollItemInfo(rollID);
	
	AddMoneyToTooltip(self, id, count);
	self:Show();
end;

local Bliz_SetItemRef = SetItemRef;
SetItemRef = function(link, text, button)
	Bliz_SetItemRef(link, text, button);
	AddMoneyToTooltip(ItemRefTooltip, LinkToID( link ));
	ItemRefTooltip:Show();
end;

local Bliz_GameTooltip_SetAuctionItem = GameTooltip.SetAuctionItem;
GameTooltip.SetAuctionItem = function(self, type, index)
	Bliz_GameTooltip_SetAuctionItem(self, type, index);
	local id = LinkToID( GetAuctionItemLink(type, index) );
	local _, _, count = GetAuctionItemInfo(type, index);
	AddMoneyToTooltip(self, id, count);
	self:Show();
end;

--[[ Event Handler ]]--

CreateFrame("GameTooltip", "LudwigSellValue", nil, "GameTooltipTemplate");

LudwigSellValue:SetScript("OnEvent", function()
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
		
			local id = LinkToID( GetContainerItemLink(bag, slot) );
			local _, count = GetContainerItemInfo(bag, slot);
			
			if (id and id ~= "") then
				lastMoney = 0;
				LudwigSellValue:SetBagItem(bag, slot);
				SaveCost(id, lastMoney, count );
			end
		end
	end
end)
LudwigSellValue:RegisterEvent("MERCHANT_SHOW");

LudwigSellValue:SetScript("OnTooltipAddMoney", function()
	if not InRepairMode() then
		lastMoney = arg1;
	end
end)