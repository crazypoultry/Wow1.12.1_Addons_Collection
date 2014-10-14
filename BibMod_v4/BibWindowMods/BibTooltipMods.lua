function UpdateBibTooltipAnchors()
	if(lastSelectedAnchor) then
		lastSelectedAnchor:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\TooltipAnchor");
	end	
	local selectedAnchor = getglobal("BibTooltipAnchor"..SelectedBibTooltipAnchor);
	selectedAnchor:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\ActiveTooltipAnchor");
	lastSelectedAnchor = selectedAnchor;
end


function GameTooltip_SetDefaultAnchor(tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_NONE");
	tooltip:SetPoint(SelectedBibTooltipAnchor, "BibTooltipAnchor"..SelectedBibTooltipAnchor);
	tooltip.default = 1;
end