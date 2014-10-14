local f=CreateFrame("frame", nil, Minimap);
f:SetHeight(24);
f:SetWidth(24);

local miniMapTexture = f:CreateTexture(nil, "OVERLAY");
miniMapTexture:SetTexture("Interface\\AddOns\\mailMinimap\\mailMinimap.blp");
miniMapTexture:SetPoint("CENTER", f, "CENTER");
miniMapTexture:SetHeight(30);
miniMapTexture:SetWidth(30);
-- miniMapTexture:SetBlendMode("ADD");

f:SetScript("OnLoad",function()
		this:RegisterEvent("UPDATE_PENDING_MAIL");
		this:SetFrameLevel(this:GetFrameLevel()+1)
	end)

f:SetScript("OnEvent",function()
	if ( event == "UPDATE_PENDING_MAIL" ) then
		if ( HasNewMail() ) then
			MiniMapMailFrame:Show();
		else
			MiniMapMailFrame:Hide();
		end
	end	
end)

f:SetScript("OnEnter",function()
	GameTooltip:SetOwner(this, "ANCHOR_BOTTOMLEFT");
	GameTooltip:SetText(HAVE_MAIL);
end)

f:SetScript("OnLeave",function()
	GameTooltip:Hide();
end)