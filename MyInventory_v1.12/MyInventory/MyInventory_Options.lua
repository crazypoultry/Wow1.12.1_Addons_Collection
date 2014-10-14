-- -----------------------------------------------------------------
-- File: MyInventory_Options.lua
--
-- Purpose: Functions for MyInventory WoW Window.
-- 
-- Author: Ramble - May, 2005
--         Svarten - MyInventory origional author.
-- 
-- Credits: 
--   Sarf, for the original concept.
--   Telo, for LootLink which I love.
--   Kaitlin, for showing me how a good code should look.
--   Pan and Nirre, for testing Svarten's corrupt code during development.
-- -----------------------------------------------------------------
function MyInventoryOptionsFrame_OnLoad()
	tinsert(UISpecialFrames, "MyInventoryOptionsFrame"); -- Esc Closes Inventory 
	UIPanelWindows["MyInventoryOptionsFrame"] = {area = "center", pushable = 0};

	MI_OptionsFrame_Slider_Cols:SetMinMaxValues(MYINVENTORY_COLUMNS_MIN, MYINVENTORY_COLUMNS_MAX);
	MI_OptionsFrame_Slider_Cols:SetValueStep(1);
	MI_OptionsFrame_Slider_ColsText:SetText("Columns");
	MI_OptionsFrame_Slider_ColsLow:SetText(MYINVENTORY_COLUMNS_MIN);
	MI_OptionsFrame_Slider_ColsHigh:SetText(MYINVENTORY_COLUMNS_MAX);
	
	MI_OptionsFrame_Slider_Scale:SetMinMaxValues(0.5, 1.5);
	MI_OptionsFrame_Slider_Scale:SetValueStep(0.01);
	MI_OptionsFrame_Slider_ScaleText:SetText("Scale");
	MI_OptionsFrame_Slider_ScaleLow:SetText("0.5");
	MI_OptionsFrame_Slider_ScaleHigh:SetText("1.5");
	
end 
function MyInventoryOptionsFrame_OnShow()
	-- Load Checks
	MI_OptionsFrame_CheckButton_ReplaceBags:SetChecked(MyInventoryReplaceBags);
	MI_OptionsFrame_CheckButton_Graphics:SetChecked(MyInventoryGraphics);
	MI_OptionsFrame_CheckButton_Background:SetChecked(MyInventoryBackground);
	MI_OptionsFrame_CheckButton_HighlightBags:SetChecked(MyInventoryHighlightBags);
	MI_OptionsFrame_CheckButton_HighlightItems:SetChecked(MyInventoryHighlightItems);
	MI_OptionsFrame_CheckButton_ShowTitle:SetChecked(MyInventoryShowTitle);
	MI_OptionsFrame_CheckButton_Cash:SetChecked(MyInventoryCash);
	MI_OptionsFrame_CheckButton_Buttons:SetChecked(MyInventoryButtons);
	MI_OptionsFrame_CheckButton_Freeze:SetChecked(MyInventoryFreeze);
	if MyInventoryCount == 1 then
		MI_OptionsFrame_CheckButton_CountUsed:SetChecked(1);
		MI_OptionsFrame_CheckButton_CountFree:SetChecked(0);
		MI_OptionsFrame_CheckButton_CountOff:SetChecked(0);
	elseif MyInventoryCount == 0 then
		MI_OptionsFrame_CheckButton_CountUsed:SetChecked(0);
		MI_OptionsFrame_CheckButton_CountFree:SetChecked(1);
		MI_OptionsFrame_CheckButton_CountOff:SetChecked(0);
	else
		MI_OptionsFrame_CheckButton_CountUsed:SetChecked(0);
		MI_OptionsFrame_CheckButton_CountFree:SetChecked(0);
		MI_OptionsFrame_CheckButton_CountOff:SetChecked(1);
	end
	MI_OptionsFrame_Slider_Cols:SetValue(MyInventoryColumns);
	MI_OptionsFrame_Slider_Scale:SetValue(MyInventoryScale);
end
function MyInventory_OptionCheck_OnLoad()
	local option = strsub(this:GetName(), 29);
	-- Set Check button text.
	local label = getglobal(this:GetName().."Text");
	local optiontext = "MYINVENTORY_CHECKTEXT_"..string.upper(option);
	if getglobal(optiontext) then
		label:SetText(getglobal(optiontext));
	else
		label:SetText(option);
	end
	-- Set tooltip text : 
	local optiontip = getglobal("MYINVENTORY_CHECKTIP_"..string.upper(option));
	if optiontip then
		this.tooltipText = optiontip;
	end
end

function MyInventory_OptionCheck_OnClick()
	local value;
	if ( this:GetChecked() ) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		value = 1;
	else
		PlaySound("igMainMenuOptionCheckBoxOn");
		value = 0;
	end
	--Set Option
	local option = strsub(this:GetName(), 29);
	MyInventory_Toggle_Option(option, value, 1);
	MyInventoryFrame_UpdateLook(MyInventory_GetBagsTotalSlots());
end

function MyInventory_CountCheck_OnClick()
	local value;
	this:SetChecked(1);
	if MI_OptionsFrame_CheckButton_CountUsed ~= this then
		MI_OptionsFrame_CheckButton_CountUsed:SetChecked(0);
	else
		value = 1
	end
	if MI_OptionsFrame_CheckButton_CountFree ~= this then
		MI_OptionsFrame_CheckButton_CountFree:SetChecked(0);
	else
		value = 0
	end
	if MI_OptionsFrame_CheckButton_CountOff ~= this then
		MI_OptionsFrame_CheckButton_CountOff:SetChecked(0);
	else
		value = -1
	end
	MyInventory_Toggle_Option("Count", value, 1);
	MyInventoryFrame_UpdateLook(MyInventory_GetBagsTotalSlots());
end

function MI_OptionsFrame_Slider_Cols_OnValueChanged()
	if this:GetValue() ~= MyInventoryColumns then
		MyInventoryFrame_SetColumns(this:GetValue());
	end
end

function MI_OptionsFrame_Slider_Scale_OnValueChanged()
	if this:GetValue() ~= MyInventoryScale then
		MyInventory_SetScale(this:GetValue());
	end
end


function MI_Check_OnEnter()
	if ( this.tooltipText ) then
		MI_OptionsFrame_Help_Text:SetText(this.tooltipText);
		MI_OptionsFrame_Help_Text:SetWidth(350);
	end
end
function MI_Check_OnLeave()
	MI_OptionsFrame_Help_Text:SetText("");
end
