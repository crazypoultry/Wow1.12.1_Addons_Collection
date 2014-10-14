ZHunterMod_Saved["ZHunterAIStrip"] = {}
ZHunterMod_Saved["ZHunterAIStrip"]["display"] = nil

ZHunterAIStrip_Order = {16, 17, 18, 5, 7, 1, 3, 10, 8, 6, 9}
ZHunterAIStrip_On = nil

ZHunterAIStrip = CreateFrame("frame", "ZHunterAIStrip")
ZHunterAIStrip:RegisterEvent("PLAYER_REGEN_ENABLED")
ZHunterAIStrip:RegisterEvent("PLAYER_ENTERING_WORLD")
ZHunterAIStrip:RegisterEvent("VARIABLES_LOADED")
ZHunterAIStrip:SetScript("OnEvent", function()
	if ZHunterAIStrip_On then
		ZHunterAIStrip_UnequipAll()
	end
	if event == "VARIABLES_LOADED" then
		if ZHunterMod_Saved["ZHunterAIStrip"]["display"] then
			ZHunterAIStripDisplay:Show()
		end
		return
	end
end)

function ZHunterAIStrip_UnequipAll(weapons)
	ZHunterAIStrip_On = nil
	ZHunterAIStripDisplayAutoCast:Hide()
	local start = 1
	local finish
	if weapons then
		finish = 3
	else
		finish = table.getn(ZHunterAIStrip_Order)
	end
	for bag=0, 4 do
		for slot=1, GetContainerNumSlots(bag) do
			if not GetContainerItemLink(bag, slot) then
				for i=start, finish do
					if GetInventoryItemLink("player", ZHunterAIStrip_Order[i]) then
						PickupInventoryItem(ZHunterAIStrip_Order[i])
						PickupContainerItem(bag, slot)
						start = i + 1
						break
					end
				end
			end
		end
	end
end

SLASH_ZHunterAIStrip1 = "/zstrip"
SlashCmdList["ZHunterAIStrip"] = function(msg)
	if msg == "display" then
		if ZHunterAIStripDisplay:IsVisible() then
			ZHunterAIStripDisplay:Hide()
			ZHunterMod_Saved["ZHunterAIStrip"]["display"] = nil
		else
			ZHunterAIStripDisplay:Show()
			ZHunterMod_Saved["ZHunterAIStrip"]["display"] = 1
		end
	elseif msg == "toggle" then
		if ZHunterAIStrip_On then
			DEFAULT_CHAT_FRAME:AddMessage("You will no longer strip when you leave combat.",0,1,1)
			ZHunterAIStrip_On = nil
			if ZHunterAIStripDisplay:IsVisible() then ZHunterAIStripDisplayAutoCast:Hide() end
		else
			DEFAULT_CHAT_FRAME:AddMessage("You will strip when you leave combat.",0,1,1)
			ZHunterAIStrip_On = 1
			if ZHunterAIStripDisplay:IsVisible() then ZHunterAIStripDisplayAutoCast:Show() end
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Possible Commands: \"display\", \"toggle\"",0,1,1)
	end
end