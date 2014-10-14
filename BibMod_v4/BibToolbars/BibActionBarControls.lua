function UpdateBibGreenButtons()
	if(GreenButtonsDisabled) then
		for i = 1, BIB_ACTION_BAR_COUNT do
			getglobal("BibActionBar"..i.."DragButton"):Hide();
		end
		BibShapeshiftActionBarDragButton:Hide();
		BibPetActionBarDragButton:Hide();
		BibMicroBarDragButton:Hide();
		BibMenuDragButton:Hide();
		BibBagButtonsBarDragButton:Hide();
	else
		for i = 1, BIB_ACTION_BAR_COUNT do
			getglobal("BibActionBar"..i.."DragButton"):Show();
		end
		BibShapeshiftActionBarDragButton:Show();
		BibPetActionBarDragButton:Show();
		BibMicroBarDragButton:Show();
		BibMenuDragButton:Show();
		BibBagButtonsBarDragButton:Show();
	end
end

function UpdateBibGreenButtonsToggle()
	if(GreenButtonsDisabled) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibGreenButtonsDisabled");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibGreenButtonsEnabled");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibGreenButtonsEnabled");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibGreenButtonsDisabled");
	end
end

function UpdateBibButtonsLockToggle()
	if(BibActionBarButtonsLocked) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibLocked");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibUnlocked");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibUnlocked");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibLocked");
	end
end

function UpdateBibButtonsGridModeToggle()
	if(BibButtonsGridMode == BIB_BUTTON_GRID_SHOW) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibShowGrid");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibHideGrid");
	elseif(BibButtonsGridMode == BIB_BUTTON_GRID_HIDE_AND_CASCADE) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibHideGrid");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibHideGridNoCascade");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibHideGridNoCascade");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibShowGrid");
	end
end

function UpdateBibXPBarVisibility()
	if(BibXPBarInvisible) then
		BibmodXPFrame:Hide();
	else
		BibmodXPFrame:Show();
	end
end

function UpdateBibXPBarToggle()
	if(BibXPBarInvisible) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibHideXPBar");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibShowXPBar");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibShowXPBar");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibHideXPBar");
	end
end

function UpdateBibBagBarVisibility()
	if(BibBagBarInvisible) then
		BibBagButtonsBar:Hide();
	else
		BibBagButtonsBar:Show();
	end
end

function UpdateBibBagBarToggle()
	if(BibBagBarInvisible) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibBagBarInvisible");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibBagBarVisible");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibBagBarVisible");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibBagBarInvisible");
	end
end

function UpdateBibMicroBarVisibility()
	if(BibMicroBarInvisible) then
		MainMenuBarArtFrame:Hide();
	else
		MainMenuBarArtFrame:Show();
	end
end

function UpdateBibMicroBarToggle()
	if(BibMicroBarInvisible) then
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibMicroBarInvisible");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibMicroBarVisible");
	else
		this:SetNormalTexture("Interface\\AddOns\\BibToolbars\\BibMicroBarVisible");
		this:SetPushedTexture("Interface\\AddOns\\BibToolbars\\BibMicroBarInvisible");
	end
end
