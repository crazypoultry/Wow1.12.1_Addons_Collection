local G = getfenv(0)
local select = select
local oGlow = oGlow

local update = function()
	local tab = GetCurrentGuildBankTab()
	local index, column, q
	for i=1, MAX_GUILDBANK_SLOTS_PER_TAB do
		index = math.fmod(i, NUM_SLOTS_PER_GUILDBANK_GROUP)
		if(index == 0) then
			index = NUM_SLOTS_PER_GUILDBANK_GROUP
		end
		column = ceil((i-0.5)/NUM_SLOTS_PER_GUILDBANK_GROUP)

		local link = GetGuildBankItemLink(tab, i)
		local slot = _G["GuildBankColumn"..column.."Button"..index]
		if(link and not oGlow.preventGBank) then
			q = select(3, GetItemInfo(link))
			oGlow(slot, q)
		elseif(slot.bc) then
			slot.bc:Hide()
		end
	end
end

local event = CreateFrame"Frame"
event:SetScript("OnEvent", function(self, event, ...)
	if(event == "GUILDBANKFRAME_OPENED") then
		self:RegisterEvent"GUILDBANKBAGSLOTS_CHANGED"
		self:Show()
	elseif(event == "GUILDBANKBAGSLOTS_CHANGED") then
		self:Show()
	elseif(event == "GUILDBANKFRAME_CLOSED") then
		self:UnregisterEvent"GUILDBANKBAGSLOTS_CHANGED"
		self:Hide()
	end
end)

local delay = 0
event:SetScript("OnUpdate", function(self, elapsed)
	delay = delay + elapsed
	if(delay > .05) then
		update()
	
		delay = 0
		self:Hide()
	end
end)

event:RegisterEvent"GUILDBANKFRAME_OPENED"
event:RegisterEvent"GUILDBANKFRAME_CLOSED"
event:Hide()

oGlow.updateGBank = update
