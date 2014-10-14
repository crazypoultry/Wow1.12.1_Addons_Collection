
function GetHashedSaveValue(variableName, key)
	if(getglobal(variableName) == nil) then
		return nil;
	end
	return getglobal(variableName)[key];
end

function SetHashedSaveValue(variableName, key, value)
	local topLevelReference = getglobal(variableName);
	
	if(topLevelReference == nil) then
		setglobal(variableName, {});
		topLevelReference = getglobal(variableName);
	end
	
	topLevelReference[key] = value;
end

function AddBibControlButton(button)
	if(BibMenu.button_offset == nil) then
		BibMenu.button_offset = 0;
	end
	button:SetWidth(32);
	button:SetHeight(32);
	button:SetPoint("TOPLEFT", "BibMenuBar", "TOPLEFT", BibMenu.button_offset, 0);
	BibMenu.button_offset = BibMenu.button_offset + 32;
	BibMenu:SetWidth(BibMenu.button_offset+16);
	UpdateBibMenuFoldState();
end

function UpdateBibMenuFoldState()
	if(BibMenuFolded) then
		BibMenuBar:Hide();
		BibMenu:SetWidth(16);
		BibMenuToggle:SetNormalTexture("Interface\\AddOns\\BibCore\\UnfoldBibMenu");
	else
		if(BibMenu.button_offset == nil) then
			BibMenu.button_offset = 0;
		end
		BibMenuBar:Show();
		BibMenu:SetWidth(BibMenu.button_offset+16);
		BibMenuToggle:SetNormalTexture("Interface\\AddOns\\BibCore\\FoldBibMenu");
	end
end

function BibShowPopupFrameAtCursor(frame)
	local X, Y = GetCursorPosition();
	
	leftEdge = X - frame:GetWidth();
	if(leftEdge < 0) then
		X = X - leftEdge;
	end
	
	topEdge = Y + frame:GetHeight();
	topOfScreen = GetScreenHeight() * UIParent:GetEffectiveScale();
	if(topEdge > topOfScreen) then
		Y = Y - (topEdge - topOfScreen);
	end
	
	frame:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMLEFT", X, Y);
	frame:Show()
end
