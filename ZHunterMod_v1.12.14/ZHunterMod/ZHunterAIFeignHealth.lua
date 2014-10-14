ZHunterMod_Saved["ZHunterAIFeignHealth"] = nil

ZHunterAIFeignHealth = CreateFrame("GameTooltip", "ZHunterAIFeignHealth", nil, "GameTooltipTemplate")

ZHunterAIFeignHealth_UnitHealth = UnitHealth
function UnitHealth(unit, a, b, c, d, e)
	if ZHunterMod_Saved["ZHunterAIFeignHealth"] then
		local _, class = UnitClass(unit)
		if class == "HUNTER" then
			ZHunterAIFeignHealth:SetOwner(UIParent, "ANCHOR_NONE")
			ZHunterAIFeignHealth:SetUnit(unit)
			local value = ZHunterAIFeignHealthStatusBar:GetValue()
			if value and value > 0 then
				return value
			end
		end
	end
	return ZHunterAIFeignHealth_UnitHealth(unit, a, b, c, d, e)
end

SLASH_ZHunterAIFeignHealth1 = "/ZFeignHealth"
SlashCmdList["ZHunterAIFeignHealth"] = function(msg)
	if ZHunterMod_Saved["ZHunterAIFeignHealth"] then
		ZHunterMod_Saved["ZHunterAIFeignHealth"] = nil
		DEFAULT_CHAT_FRAME:AddMessage("Feign Health Disabled.", 0, 1, 1)
	else
		ZHunterMod_Saved["ZHunterAIFeignHealth"] = 1
		DEFAULT_CHAT_FRAME:AddMessage("Now showing your health while feigned.", 0, 1, 1)
	end
end