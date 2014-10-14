local _G = getfenv(0)
local oGlow = oGlow

-- Craft
local addon = CreateFrame"Frame";
addon:Show();
local craftOpen = false;

-- addon:Hide();
-- addon:RegisterEvent("CRAFT_SHOW");
-- addon:RegisterEvent("CRAFT_CLOSE");
-- addon:SetScript("OnEvent", function()
-- 	Print(event)
-- 	if event == "CRAFT_SHOW" then

-- 		craftOpen = true;
-- 	elseif event == "CRAFT_CLOSE" then
-- 		craftOpen = false;
-- 	end
-- end)
addon:SetScript("OnUpdate", function()
	local numCrafts = GetNumCrafts();
	-- Print(GetTradeSkillSelectionIndex())
	-- Print(ATSW_GetNumTradeSkills())

	-- Print(GetCraftSelectionIndex())
	if _G["CraftName"] ~= nil then
		-- Print("Craft Open")
		if _G["CraftName"]:IsShown() then
		-- link = GetCraftItemLink(GetCraftSelectionIndex())
		-- Print(link)
		-- local numItems = GetInboxNumItems();
	 --    local index = ((InboxFrame.pageNum - 1) * 7) + 1;

	 --    local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead;
	 --    local icon, button, expireTime, senderText, subjectText, buttonIcon;

		-- for i=1, 7 do
		-- 	local name, itemTexture, count, quality, canUse = GetInboxItem(index + i - 1);
		-- 	if quality then
		-- 		oGlow(_G["MailItem"..i.."Button"], quality)
		-- 		if ( InboxFrame.openMailID ) then
		-- 			local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID);
		-- 			oGlow(_G["OpenMailPackageButton"], quality)
		-- 		end
		-- 	end
		-- end
		end
	end
end)




function oGlow_GetTradeSkillSelectionIndex()
	if(atsw_oldmode) then
		return GetCraftSelectionIndex();
	else
		return GetTradeSkillSelectionIndex();
	end
end

function oGlow_GetNumTradeSkills()
	if(atsw_oldmode) then
		return GetNumCrafts();
	else
		return GetNumTradeSkills();
	end
end
































-- local frame, link, q, icon
-- local update = function(id)
-- 	--DEFAULT_CHAT_FRAME:AddMessage("1");
-- 	icon = getglobal("CraftIcon")
-- 	link = GetCraftItemLink(id)

-- 	if(link) then
-- 		q = getQuality(link)
-- 		oGlow(icon, q)
-- 	elseif(icon.bc) then
-- 		icon.bc:Hide()
-- 	end

-- 	for i=1, GetCraftNumReagents(id) do
-- 		frame = G["CraftReagent"..i]
-- 		link = GetCraftReagentItemLink(id, i)

-- 		if(link) then
-- 			q = getQuality(link)
-- 			--q = select(3, GetItemInfo(link))
-- 			point = G["CraftReagent"..i.."IconTexture"]

-- 			oGlow(frame, q, point)
-- 		elseif(frame.bc) then
-- 			frame.bc:Hide()
-- 		end
-- 	end
-- end

-- if(IsAddOnLoaded("Blizzard_CraftUI")) then
-- 	hooksecurefunc(CraftFrame_SetSelection, update)
-- 	--self:SecureHook("CraftFrame_SetSelection", "update");
-- 	--hooksecurefunc(CraftFrame, "SetSelection", function() DEFAULT_CHAT_FRAME:AddMessage("1") end)
-- else
-- 	local hook = CreateFrame"Frame"

-- 	hook:SetScript("OnEvent", function(self, event)
-- 		DEFAULT_CHAT_FRAME:AddMessage(event)
-- 		if(addon == "Blizzard_CraftUI") then
-- 			hooksecurefunc("CraftFrame_SetSelection", update)
-- 			hook:UnregisterEvent"ADDON_LOADED"
-- 			hook:SetScript("OnEvent", nil)
-- 		end
-- 	end)
-- 	hook:RegisterEvent"ADDON_LOADED"
-- end

-- oGlow.updateCraft = update
