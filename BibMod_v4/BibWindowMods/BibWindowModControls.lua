BibResizerList = {};
BibResizerListSize = 0;

function UpdateBibResizers()
	if(ResizersDisabled) then
		for i = 0, BibResizerListSize - 1 do
			BibResizerList[i]:Hide();
		end
	else
		for i = 0, BibResizerListSize - 1 do
			BibResizerList[i]:Show();
		end
	end	
end

function UpdateBibResizersToggle()
	if(ResizersDisabled) then
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\ResizersDisabled");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\ResizersEnabled");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\ResizersEnabled");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\ResizersDisabled");
	end
end

function UpdateBibBuffFrameVisibility()
	if(BibBuffFrameInvisible and BibBuffFrameInvisible) then
		BuffFrameDragBar:Hide();
		BuffFrameBackground:Hide();
		EnchantFrameDragBar:Hide();
		EnchantFrameBackground:Hide();
	else
		BuffFrameDragBar:Show();
		BuffFrameBackground:Show();
		EnchantFrameDragBar:Show();
		EnchantFrameBackground:Show();
	end
end

function UpdateBibBuffFrameToggle()
	if(BibBuffFrameInvisible) then
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\BuffFrameInvisible");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\BuffFrameVisible");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\BuffFrameVisible");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\BuffFrameInvisible");
	end
end

function UpdateBibTooltipAnchorsVisibility()
	if(BibTooltipAnchorsInvisible) then
		BibTooltipAnchorFrame:Hide();
	else
		BibTooltipAnchorFrame:Show();
	end
end

function UpdateBibTooltipAnchorsToggle()
	if(BibTooltipAnchorsInvisible) then
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\TooltipAnchorsInvisible");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\TooltipAnchorsVisible");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibWindowMods\\TooltipAnchorsVisible");
		this:SetPushedTexture("Interface\\AddOns\\BibWindowMods\\TooltipAnchorsInvisible");
	end
end