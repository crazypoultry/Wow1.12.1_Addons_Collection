TITAN_OUTFITTER_ID = "Outfitter";
TITAN_OUTFITTER_TOOLTIP_HINTS = "Hint: Left-click to open Outfitter or Right-click to choose a new outfit";

function TitanPanelOutfitterButton_OnLoad()
	this.registry = {
		id = TITAN_OUTFITTER_ID,
		version = Outfitter_cVersion,
		menuText = Outfitter_cTitle,
		category = "Interface",
		buttonTextFunction = "TitanPanelOutfitterButton_GetButtonText", 
		tooltipTitle = Outfitter_cTitle, 
		tooltipTextFunction = "TitanPanelOutfitterButton_GetTooltipText", 
		icon = "Interface\\Addons\\Outfitter\\Textures\\Icon",
		iconWidth = 16,
		savedVariables =
		{
			ShowIcon = 1,
			ShowLabelText = 1,
		},
	};
	
    Outfitter_RegisterOutfitEvent("WEAR_OUTFIT", TitanPanelOutfitterButton_OutfitEvent);
    Outfitter_RegisterOutfitEvent("UNWEAR_OUTFIT", TitanPanelOutfitterButton_OutfitEvent);
end

function TitanPanelOutfitterButton_OutfitEvent(pEvent, pOutfitName, pOutfit)
	TitanPanelButton_UpdateButton(TITAN_OUTFITTER_ID);

	if UIDROPDOWNMENU_OPEN_MENU == "TitanPanelOutfitterButtonRightClickMenu" then
		UIDropDownMenu_Initialize(TitanPanelOutfitterButtonRightClickMenu, TitanPanelRightClickMenu_PrepareOutfitterMenu, "MENU");
	end
end

function TitanPanelOutfitterButton_GetButtonText()
	local	vCurrentOutfitName = Outfitter_GetCurrentOutfitInfo();
	
	if (TitanGetVar(TITAN_OUTFITTER_ID, "ShowLabelText")) then	
		return Outfitter_cTitle..": ", HIGHLIGHT_FONT_COLOR_CODE..vCurrentOutfitName..FONT_COLOR_CODE_CLOSE;
	else
		return nil, HIGHLIGHT_FONT_COLOR_CODE..vCurrentOutfitName..FONT_COLOR_CODE_CLOSE;
	end
end

function TitanPanelOutfitterButton_GetTooltipText()
	return TitanUtils_GetGreenText(TITAN_OUTFITTER_TOOLTIP_HINTS);
end

function TitanPanelOutfitterButton_OnEvent()
end

function TitalPanelOutfitterButton_OnClick(pButton)
	if pButton == "LeftButton" then
		OutfitterMinimapButton_ItemSelected(nil, 0);
	end
end

function TitanPanelRightClickMenu_PrepareOutfitterMenu()
	local	vFrame = getglobal(UIDROPDOWNMENU_INIT_MENU);
	
	vFrame.ChangedValueFunc = OutfitterMinimapButton_ItemSelected;
	OutfitterMinimapDropDown_InitializeOutfitList();

	Outfitter_AddCategoryMenuItem(TITAN_PANEL);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_OUTFITTER_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(TITAN_OUTFITTER_ID);
	-- TitanPanelRightClickMenu_AddToggleColoredText(TITAN_OUTFITTER_ID);
	TitanPanelRightClickMenu_AddSpacer();	
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_OUTFITTER_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end
