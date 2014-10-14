-- do nothing if Titan Panel isn't present
if not IsAddOnLoaded("Titan") then return end

local TEXT = Wardrobe.GetString;

WARDROBE_TITAN_ID = "Wardrobe";

function Wardrobe.TitanPanelButton_OnLoad()
	-- register the plugin
	this.registry = {
		id = WARDROBE_TITAN_ID,
		menuText = WARDROBE_TITAN_ID,
		buttonTextFunction = "Wardrobe_TitanPanelButton_GetButtonText",
		tooltipTitle = TEXT("TITAN_BUTTON_TEXT"),
		tooltipTextFunction = "Wardrobe_TitanPanelButton_GetTooltipText",
		icon = "Interface\\AddOns\\Wardrobe\\Images\\Wardrobe",
		iconWidth = 16,
		savedVariables = {
			ShowMinimapIcon = 1,
			ShowIcon = 1,
			ShowLabelText = TITAN_NIL,
		}
	};
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	if (Chronos) then
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	else
		this.registry.frequency = 1;
	end
	
	TitanPanelButton_OnLoad();
end

function Wardrobe.TitanPanelButton_OnEvent()
	if (event == "UNIT_INVENTORY_CHANGED") then
		Chronos.scheduleByName("WardrobeTitanUpdate", .2, function() TitanPanelButton_UpdateButton(WARDROBE_TITAN_ID) end);
	elseif (event == "PLAYER_ENTERING_WORLD") then
		Wardrobe.enteredWorld = true;
		Wardrobe.CheckForOurWardrobeID();
		Wardrobe.TitanUpdateMinimapStatus();
	end
end

function Wardrobe.TitanPanelButton_GetButtonText(id)

	local labelText = nil;

	-- display the label if the user has selected
	if (TitanGetVar(WARDROBE_TITAN_ID, "ShowLabelText")) then
		labelText = TEXT("TITAN_BUTTON_TEXT");
	end
	
	-- get any active outfits
	local outfitText = Wardrobe.GetActiveOutfitsTextList();
	
	-- show / hide the minimap icon
	if (Wardrobe.enteredWorld) then
		Wardrobe.TitanUpdateMinimapStatus();
	end
	
	return labelText, outfitText;
end

Wardrobe_TitanPanelButton_GetButtonText = Wardrobe.TitanPanelButton_GetButtonText;

function Wardrobe.TitanUpdateMinimapStatus(elseShow)
	if (TitanGetVar) then
		if (TitanGetVar(WARDROBE_TITAN_ID, "ShowMinimapIcon")) then
			Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
			Wardrobe_IconFrame:Show();
		else
			Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 0;
			Wardrobe_IconFrame:Hide();
		end
	else
		if (elseShow) then
			Wardrobe_IconFrame:Show();
		else
			Wardrobe_IconFrame:Hide();
		end
	end
end

function Wardrobe_TitanPanelButton_GetTooltipText()
	return TEXT("TITAN_TOOLTIP_TEXT");
end

function TitanPanelRightClickMenu_PrepareWardrobeMenu()

	TitanPanelRightClickMenu_AddTitle(TitanPlugins[WARDROBE_TITAN_ID].menuText);
	
	-- show the "hide minimap icon"
	TitanPanelRightClickMenu_AddToggleVar(TEXT("TITAN_MENU_SHOW_MINIMAP_ICON"), WARDROBE_TITAN_ID, "ShowMinimapIcon");
	
	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddToggleIcon(WARDROBE_TITAN_ID);
	TitanPanelRightClickMenu_AddToggleLabelText(WARDROBE_TITAN_ID);

	TitanPanelRightClickMenu_AddSpacer();

	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, WARDROBE_TITAN_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function Wardrobe.TitanPanelButton_OnClick()
	-- show the wardrobe menu on left clicks, options on right clicks
	if ( arg1 == "LeftButton" ) then
		local position = TitanUtils_GetRealPosition(WARDROBE_TITAN_ID);
		--local horizOffset = -( DropDownList1:GetWidth()-TitanPanelWardrobeButton:GetWidth() )/2;
		if (position == TITAN_PANEL_PLACE_TOP) then
			ToggleDropDownMenu(1, nil, WardrobeEquipDropDown, "TitanPanelWardrobeButton", -15, 0, "TOPLEFT");
		else
			ToggleDropDownMenu(1, nil, WardrobeEquipDropDown, "TitanPanelWardrobeButton", -15, 0, "BOTTOMLEFT");
		end
	else
		TitanPanelButton_OnClick(arg1, 1);
	end
end

function Wardrobe.TitanPanelButton_OnEnter()
	if (Wardrobe_Config.MustClickUIButton) then
		TitanPanelButton_OnEnter();
	else
		if (not DropDownList1:IsVisible()) then
			Wardrobe.TitanPanelButton_OnClick("LeftButton");
		end
	end
end

-----------------------------------------------------------------------------------
-- Replacement Functions
-----------------------------------------------------------------------------------

function Wardrobe.Toggle(toggle, fromKhaos)
	if (toggle == 1) then
		if (not fromKhaos) then
			Wardrobe.Print(TEXT("TXT_ENABLED"));
		end
		Wardrobe_Config.Enabled = true;
		Wardrobe.TitanUpdateMinimapStatus(true);
	else
		if (not fromKhaos) then
			Wardrobe.Print(TEXT("TXT_DISABLED"));
		end
		Wardrobe_Config.Enabled = false;
		Wardrobe.TitanUpdateMinimapStatus(false);
	end
end

function Wardrobe.ButtonUpdateVisibility()
	if (TitanGetVar) then
		if (TitanGetVar(WARDROBE_TITAN_ID, "ShowMinimapIcon")) then
    		Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
        	Wardrobe_IconFrame:Show();
        else
        	Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 0;
			Wardrobe_IconFrame:Hide();
		end
    elseif (not Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible) or (Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible == 1) then
    	Wardrobe_Config[WD_realmID][WD_charID].MinimapButtonVisible = 1;
    	Wardrobe_IconFrame:Show();
    else
        Wardrobe_IconFrame:Hide();
    end
end


-- Event Driver
local parentframe = CreateFrame("Frame", "TitanPanelWardrobeButtonParent", UIParent);
local button = CreateFrame("Button", "TitanPanelWardrobeButton", parentframe, "TitanPanelComboTemplate");
button:SetFrameStrata("FULLSCREEN");
button:SetToplevel(1);
button:Hide();

--Frame Scripts
local tempThis = this;
this = button;
Wardrobe.TitanPanelButton_OnLoad();
this = tempThis;

button:SetScript("OnEnter", Wardrobe.TitanPanelButton_OnEnter);
button:SetScript("OnClick", Wardrobe.TitanPanelButton_OnClick);
button:SetScript("OnEvent", Wardrobe.TitanPanelButton_OnEvent);

