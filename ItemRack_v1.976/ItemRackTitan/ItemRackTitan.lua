ITEMRACK_TITAN_VERSION = "1.1";

function ItemRackTitan.OnLoad()
	if ( IsAddOnLoaded("Titan") ) then
	    -- register the plugin
	    this.registry = {
	        id = ITEMRACK_TITAN_ID,
	        menuText = ITEMRACK_TITAN_ID,
	        buttonTextFunction = "ItemRackTitan_GetButtonText",
	        tooltipTitle = ITEMRACK_TITAN_TOOLTIP_TITLE,
	        tooltipTextFunction = "ItemRackTitan_GetTooltipText",
	        icon = "Interface\\AddOns\\ItemRackTitan\\Icon",
	        iconWidth = 16,
	        frequency = 0.5,
	        category = "Interface",
	        version = ITEMRACK_TITAN_VERSION,
	        savedVariables = {
	            ShowIcon = 1,
	            ShowLabelText = TITAN_NIL,
	            ShowColoredText = 1,
	            ShowHiddenItems = 0,
	            ColorHiddenItems = 0,
	            OpenOnMouseover = 1
	        }
	    };
	    
	    TitanPanelButton_OnLoad();
    end
end

function ItemRackTitan.GetButtonText(id)

    local labelText = nil;
    local outfitText = nil;
    local curOutfit = nil;

    -- display the label if the user has selected
    if (TitanGetVar(ITEMRACK_TITAN_ID, "ShowLabelText")) then
        labelText = ITEMRACK_TITAN_BUTTON_TEXT;
    end
    
    -- get any active outfits
    ItemRack_IsSetEquipped(setname)
    
	 local idx,i,j,count=1
    local usersets = ItemRack_GetUserSets();
    
    local hiddenSetIsEquipped = false;
    
	 for i in usersets do
		if not string.find(i,"^ItemRack-") and not string.find(i,"^Rack-") then -- skip special sets (ItemRack-Queue and ItemRack-Normal)
			if ItemRack_IsSetEquipped(i) then
			   if usersets[i]["hide"] then
			      hiddenSetIsEquipped = true;
			   end
			   if (not usersets[i]["hide"]) or TitanGetVar(ITEMRACK_TITAN_ID, "ShowHiddenItems") then
               if (outfitText == nil) then
                  outfitText = i;
               else
                  outfitText = outfitText..", "..i;
               end
            end
			end
		end
	end
   
   if hiddenSetIsEquipped and TitanGetVar(ITEMRACK_TITAN_ID, "ColorHiddenItems") then
      outfitText = TitanUtils_GetGreenText(outfitText);
   end
   
   
   if (outfitText == nil) then
   
       -- we aren't wearing an outfit
       outfitText = ITEMRACK_TITAN_NO_OUTFIT;
   end
        
   return labelText, outfitText;
end
ItemRackTitan_GetButtonText = ItemRackTitan.GetButtonText;

function ItemRackTitan.GetTooltipText()
    return ITEMRACK_TITAN_TOOLTIP_TEXT;
end
ItemRackTitan_GetTooltipText = ItemRackTitan.GetTooltipText;

function TitanPanelRightClickMenu_PrepareItemRackMenu()
   
    TitanPanelRightClickMenu_AddTitle(TitanPlugins[ITEMRACK_TITAN_ID].menuText);
    
    -- show the "Open selection on mouseover" option
    TitanPanelRightClickMenu_AddToggleVar(ITEMRACK_TITAN_MENU_OPEN_ON_MOUSEOVER, ITEMRACK_TITAN_ID, "OpenOnMouseover");

    TitanPanelRightClickMenu_AddSpacer();
    
    -- show the "list hidden items" option
    TitanPanelRightClickMenu_AddToggleVar(ITEMRACK_TITAN_MENU_SHOW_HIDDEN_ITEMS, ITEMRACK_TITAN_ID, "ShowHiddenItems");

    -- show the "color when hidden set is equiped" option
    TitanPanelRightClickMenu_AddToggleVar(ITEMRACK_TITAN_MENU_COLOR_HIDDEN_ITEMS, ITEMRACK_TITAN_ID, "ColorHiddenItems");
        
    -- show "options"
    TitanPanelRightClickMenu_AddCommand(ITEMRACK_TITAN_MENU_OPTIONS, ITEMRACK_TITAN_ID, "ItemRack_Sets_Toggle");
    
    
    -- standard titan menu stuff
    TitanPanelRightClickMenu_AddSpacer();

    TitanPanelRightClickMenu_AddToggleIcon(ITEMRACK_TITAN_ID);
    TitanPanelRightClickMenu_AddToggleLabelText(ITEMRACK_TITAN_ID);
    -- TitanPanelRightClickMenu_AddToggleColoredText(ITEMRACK_TITAN_ID);

    TitanPanelRightClickMenu_AddSpacer();

    TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, ITEMRACK_TITAN_ID, TITAN_PANEL_MENU_FUNC_HIDE);

end

function ItemRackTitan.OnClick(button)
    -- show the ItemRack menu on left clicks
	 if ( button == "LeftButton") then
	   if TitanGetVar(ITEMRACK_TITAN_ID, "OpenOnMouseover") then
   	   ItemRack_Sets_Toggle();
   	else
   		-- toggle menu
   		if ItemRack_MenuFrame:IsVisible() then
   			ItemRack_MenuFrame:Hide();
   		else
   			ItemRack_BuildMenu(20,"TITAN");
   		end
   	end
    end
    TitanPanelButton_OnClick(button, 1);
end

function ItemRackTitan.OnEnter()
   if (TitanGetVar(ITEMRACK_TITAN_ID, "OpenOnMouseover")) then
   	ItemRack_BuildMenu(20,"TITAN")
   else
   	TitanPanelButton_OnEnter()
   end
end
