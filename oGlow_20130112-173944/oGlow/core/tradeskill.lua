-- Globally used
local G = getfenv(0)
local select = select
local oGlow = oGlow

-- Tradeskill
local GetTradeSkillNumReagents = GetTradeSkillNumReagents
local GetTradeSkillReagentItemLink = GetTradeSkillReagentItemLink

local GetItemInfo = GetItemInfo

local icon, link, q, frame, point
local update = function(id)
	icon = G["TradeSkillSkillIcon"]
	link = GetTradeSkillItemLink(id)

	if(link and not oGlow.preventTradeskill) then
		q = select(3, GetItemInfo(link))
		oGlow(icon, q)
	elseif(icon.bc) then
		icon.bc:Hide()
	end

	for i=1, GetTradeSkillNumReagents(id) do
		frame = G["TradeSkillReagent"..i]
		link = GetTradeSkillReagentItemLink(id, i)

		if(link) then
			q = select(3, GetItemInfo(link))
			point = G["TradeSkillReagent"..i.."IconTexture"]

			oGlow(frame, q, point)
		elseif(frame.bc) then
			frame.bc:Hide()
		end
	end
end

if(IsAddOnLoaded("Blizzard_TradeSkillUI")) then
	hooksecurefunc("TradeSkillFrame_SetSelection", update)
else
	local hook = CreateFrame"Frame"

	hook:SetScript("OnEvent", function(self, event, addon)
		if(addon == "Blizzard_TradeSkillUI") then
			hooksecurefunc("TradeSkillFrame_SetSelection", update)
			hook:UnregisterEvent"ADDON_LOADED"
			hook:SetScript("OnEvent", nil)
		end
	end)
	hook:RegisterEvent"ADDON_LOADED"
end

oGlow.updateTradeskill = update
