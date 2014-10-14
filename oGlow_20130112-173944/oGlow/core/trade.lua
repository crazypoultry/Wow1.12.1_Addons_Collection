-- Globally used
local G = getfenv(0)
local oGlow = oGlow

-- Trade
local GetItemInfo = GetItemInfo
local GetTradePlayerItemLink = GetTradePlayerItemLink

-- Addon
local hook = CreateFrame"Frame"

local q
local setQuality = function(self, link)
	if(link and not oGlow.preventTrade) then
		q = select(3, GetItemInfo(link))
		oGlow(self, q)
	elseif(self.bc) then
		self.bc:Hide()
	end
end

local update = function()
	for i=1,7 do
		hook["TRADE_PLAYER_ITEM_CHANGED"](i)
		hook["TRADE_TARGET_ITEM_CHANGED"](i)
	end
end

hook["TRADE_SHOW"] = update
hook["TRADE_UPDATE"] = update

local self, link
hook["TRADE_PLAYER_ITEM_CHANGED"] = function(index)
	self = G["TradePlayerItem"..index.."ItemButton"]
	link = GetTradePlayerItemLink(index)

	setQuality(self, link)
end

hook["TRADE_TARGET_ITEM_CHANGED"] = function(index)
	self = G["TradeRecipientItem"..index.."ItemButton"]
	link = GetTradeTargetItemLink(index)

	setQuality(self, link)
end

hook:SetScript("OnEvent", function(self, event, id)
	self[event](id)
end)

hook:RegisterEvent"TRADE_SHOW" -- isn't used?
hook:RegisterEvent"TRADE_UPDATE" -- isn't used?
hook:RegisterEvent"TRADE_PLAYER_ITEM_CHANGED"
hook:RegisterEvent"TRADE_TARGET_ITEM_CHANGED"

oGlow.updateTrade = update
