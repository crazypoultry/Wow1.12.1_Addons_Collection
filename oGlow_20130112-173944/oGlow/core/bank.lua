-- 0 Poor 9d9d9d
-- 1 Common ffffff
-- 2 Uncommon 1eff00
-- 3 Rare 0070dd
-- 4 Epic a335ee
-- 5 Legendary ff8000
-- 6 Artifact e6cc80
-- 7 Heirloom e6cc80

-- Globally used
local G = getfenv(0)
local select = select
local oGlow = oGlow

-- Bank
local GetContainerItemLink = GetContainerItemLink
local GetItemInfo = GetItemInfo

-- Addon
local hook = CreateFrame"Frame"
hook:SetParent"BankFrame"

local self, link, q
local update = function()
	for i=1, 24 do
		self = getglobal("BankFrameItem"..i)
		link = GetContainerItemLink(-1, i)
	
		if(link) then
			--local sName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(link);
			--printable=gsub(link, "\124", "\124\124");
			--|cffffffff|Hitem:4363:0:0:0|h[Медный регулятор]|h|r
			--local _, _, qColor = string.find(link, "|cff(%x*)|")
			--|cff9d9d9d|Hitem:7073:0:0:0:0:0:0:0:80:0|h[Broken Fang]|h|r
			--local _, _, Color, Ltype, Id, Enchant, Gem1, Gem2, Gem3, Gem4, Suffix, Unique, LinkLvl, Name = string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
			--DEFAULT_CHAT_FRAME:AddMessage(getQuality(link));
			-- local _, _, hex = string.find(value, "(.*) (.*)")
			--q = select(3, GetItemInfo(link))
			q = getQuality(link);
			--DEFAULT_CHAT_FRAME:AddMessage
			oGlow(self, q)
		-- elseif(self.bc) then
		-- 	self.bc:Hide()
		end
	end
end

hook:SetScript("OnShow", update)
hook:SetScript("OnEvent", update)
hook:RegisterEvent"PLAYERBANKSLOTS_CHANGED" -- NERF IT!

oGlow.updateBank = update
