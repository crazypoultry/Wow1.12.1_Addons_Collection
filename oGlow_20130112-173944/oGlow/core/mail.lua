local _G = getfenv(0)
local oGlow = oGlow

local addon = CreateFrame"Frame";
local mailOpen = false;

-- addon:Hide();
addon:RegisterEvent("MAIL_SHOW");
addon:RegisterEvent("MAIL_CLOSED");
addon:SetScript("OnEvent", function()
	if event == "MAIL_SHOW" then
		mailOpen = true;
	elseif event == "MAIL_CLOSED" then
		mailOpen = false;
	end
end)
addon:SetScript("OnUpdate", function()
	if mailOpen then
		local numItems = GetInboxNumItems();
	    local index = ((InboxFrame.pageNum - 1) * 7) + 1;

	    local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, wasRead;
	    local icon, button, expireTime, senderText, subjectText, buttonIcon;

		for i=1, 7 do
			local name, itemTexture, count, quality, canUse = GetInboxItem(index + i - 1);
			if quality then
				oGlow(_G["MailItem"..i.."Button"], quality)
				if ( InboxFrame.openMailID ) then
					local name, itemTexture, count, quality, canUse = GetInboxItem(InboxFrame.openMailID);
					oGlow(_G["OpenMailPackageButton"], quality)
				end
			end
		end
	end
end)
