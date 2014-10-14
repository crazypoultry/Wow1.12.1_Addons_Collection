function AtlasLootMinimapButton_OnClick(arg1)
	if arg1=="LeftButton" then
        AtlasLootDefaultFrame:Show();
    elseif arg1=="RightButton" then
        AtlasLootOptions_Toggle();
    end
end

function AtlasLootMinimapButton_Init()
    if AtlasLootMinimapButtonFrame then
	    if(AtlasLootOptions["MinimapButton"]==true) then
		    AtlasLootMinimapButtonFrame:Show();
	    else
		    AtlasLootMinimapButtonFrame:Hide();
	    end
        AtlasLootMinimapButtonFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",54 - (78 * cos(AtlasLootOptions["MinimapButtonAngle"])),(78 * sin(AtlasLootOptions["MinimapButtonAngle"])) - 55);
    end
end

function AtlasLootMinimapButton_OnEnter()
    GameTooltip:SetOwner(this, "ANCHOR_LEFT");
    GameTooltip:SetText(string.sub(ATLASLOOT_VERSION, 11, 28));
    GameTooltip:AddLine(ATLASLOOT_MINIMAPBUTTON_LINE1);
    GameTooltip:AddLine(ATLASLOOT_MINIMAPBUTTON_LINE2);
    GameTooltip:Show();
end