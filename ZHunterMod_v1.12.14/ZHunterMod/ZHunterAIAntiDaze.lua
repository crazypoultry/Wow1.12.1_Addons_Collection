ZHunterMod_Saved["ZHunterAIAntiDaze"] = nil

ZHunterAIAntiDaze_Tooltip = CreateFrame("GameTooltip", "ZHunterAIAntiDaze_Tooltip", nil, "GameTooltipTemplate")

ZHunterAIAntiDaze = CreateFrame("Frame", "ZHunterAIAntiDaze")
ZHunterAIAntiDaze:RegisterEvent("VARIABLES_LOADED")
ZHunterAIAntiDaze:SetScript("OnEvent", function()
	if event == "VARIABLES_LOADED" then
		if ZHunterMod_Saved["ZHunterAIAntiDaze"] then
			ZHunterAIAntiDaze:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
			ZHunterAIAntiDaze:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
		end
	else
		local _, _, player = string.find(arg1 or "", ZHUNTER_AFFLICTED_DAZED)
		if player then
			local group = {}
			group[ZHUNTER_YOU] = 1
			for i=1, GetNumPartyMembers() do
				group[UnitName("party"..i)] = 1
			end
			if group[player] then
				local text
				for i=0, 32 do
					ZHunterAIAntiDaze_Tooltip:SetOwner(this, "ANCHOR_NONE")
					GetPlayerBuff(i, "HELPFUL")
					ZHunterAIAntiDaze_Tooltip:SetPlayerBuff(i, "HELPFUL")
					text = ZHunterAIAntiDaze_TooltipTextLeft1:GetText()
					if (text == ZHUNTER_ASPECT_CHEETAH and player == ZHUNTER_YOU) or text == ZHUNTER_ASPECT_PACK then
						CancelPlayerBuff(i)
						return
					end
				end
			end
		end
	end
end)

SLASH_ZHunterAIAntiDaze1 = "/zantidaze"
SlashCmdList["ZHunterAIAntiDaze"] = function(msg)
	if ZHunterMod_Saved["ZHunterAIAntiDaze"] then
		ZHunterMod_Saved["ZHunterAIAntiDaze"] = nil
		DEFAULT_CHAT_FRAME:AddMessage("Anti Daze Disabled.", 0, 1, 1)
		ZHunterAIAntiDaze:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
		ZHunterAIAntiDaze:UnregisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
	else
		ZHunterMod_Saved["ZHunterAIAntiDaze"] = 1
		DEFAULT_CHAT_FRAME:AddMessage("Anti Daze Enabled.", 0, 1, 1)
		ZHunterAIAntiDaze:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE")
		ZHunterAIAntiDaze:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_PARTY_DAMAGE")
	end
end