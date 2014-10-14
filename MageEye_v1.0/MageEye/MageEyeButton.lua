function MageEyeIconOnClick()
if MageEyeOptions:IsVisible()==nil then
MageEyeOptions:Show();
else
MageEyeOptions:Hide();
end
end

function MageEyeIcon_OnEnter()
GameTooltip:SetOwner(this, "ANCHOR_LEFT");
GameTooltip:SetText("MageEye Options");
GameTooltip:Show();
end