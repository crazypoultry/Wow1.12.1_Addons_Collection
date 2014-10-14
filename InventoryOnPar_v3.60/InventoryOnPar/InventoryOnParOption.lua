InventoryOnParOption = {};
IOP_MAX_LEVEL = 60;

function InventoryOnParOption.InitializeOptions()

	StaticPopupDialogs["InventoryOnPar_DELETE_OUT_OF_DATE_RECORDS"] = {
		text = TEXT("Do you want to delete all existing records older than one week"),
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = function()
			IOP_DeleteOutofDateRecords();
		end,
		timeout = 0,
		whileDead = 1,		
	};

	StaticPopupDialogs["InventoryOnPar_DELETE_ALL_RECORDS"] = {
		text = TEXT("Do you want to delete all existing records"),
		button1 = TEXT(YES),
		button2 = TEXT(NO),
		OnAccept = function()
			IOP.Data = {};
		end,
		timeout = 0,
		whileDead = 1,		
	};
	if (IOP.Options == nil) then
		IOP.Options = {};
	end
	if (IOP.Options.scanPlayers == nil) then
		IOP.Options.scanPlayers = 1; -- Default value is always scan other players
	end
	if (IOP.Options.minutesTilUpdate == nil) then
		IOP.Options.minutesTilUpdate = 30; -- Default value is to only update after 30 mins
	end
	if (IOP.Options.dateFormat == nil) then
		IOP.Options.dateFormat = "%d %b %Y %H:%M"; -- Default value is to show date in Day Month Year format eg: 15 May 2005 13:24
	end
	if (UnitLevel("player")>0) then
		if (IOP.Options.minLevel == nil) then
			IOP.Options.minLevel = UnitLevel("player") - 5; -- Default value is to record only 5 levels below
		end
		
		if (IOP.Options.maxLevel == nil) then
			IOP.Options.maxLevel = UnitLevel("player") + 5; -- Default value is to record only 5 levels above
		end
	else
		IOP.Options.minLevel = 1;
		IOP.Options.maxLevel = IOP_MAX_LEVEL;
	end
	if (IOP.Options.minLevel < 1) then
		IOP.Options.minLevel = 1;
	end
	if (IOP.Options.maxLevel > IOP_MAX_LEVEL) then
		IOP.Options.maxLevel = IOP_MAX_LEVEL;
	end
end

function InventoryOnParOption.OnShow()
	PlaySound("igMainMenuOption");
	InventoryOnParOption.mainFrameVisible = InventoryOnParUIFrame:IsVisible();
	HideUIPanel(InventoryOnParUIFrame);
end

function InventoryOnParOption.Close()
	if (InventoryOnParOption.mainFrameVisible) then
		ShowUIPanel(InventoryOnParUIFrame);
	end
	HideUIPanel(InventoryOnParOptionFrame);
end

function InventoryOnParOption.Save()
	if (InventoryOnParOptionCheckButtonScanPlayers:GetChecked()) then
		IOP.Options.ScanPlayers = 1;
	else
		IOP.Options.ScanPlayers = 0;
	end
--	IOP.Options.minutesTilUpdate = tonumber(UIDropDownMenu_GetSelectedValue(InventoryOnParOptionUpdateMinutes));
	IOP.Options.dateFormat = InventoryOnParOptionDateFormat:GetText();
	IOP.Options.minLevel = tonumber(InventoryOnParOptionMinLevel:GetText());
	IOP.Options.maxLevel = tonumber(InventoryOnParOptionMaxLevel:GetText());
	
	if (IOP.Options.minLevel < 1) then
		IOP.Options.minLevel = 1;
	end
	if (IOP.Options.maxLevel > IOP_MAX_LEVEL) then
		IOP.Options.maxLevel = IOP_MAX_LEVEL;
	end

	IOP_UI_SetInitialized(false);
	InventoryOnParOption.Close();
end

------------------------------- Options settings -------------------------------------------

InventoryOnParOption.CheckButtonScanPlayers = {};

function InventoryOnParOption.CheckButtonScanPlayers.OnShow()
	InventoryOnParOptionCheckButtonScanPlayersLabel:SetText("Scan Other Players");
	if(IOP.Options.scanPlayers == 1) then
		InventoryOnParOptionCheckButtonScanPlayers:SetChecked();
	end
end

InventoryOnParOption.DropDownUpdateMinutes = {};

function InventoryOnParOption.DropDownUpdateMinutes.OnShow()
	UIDropDownMenu_SetSelectedValue(this, IOP.Options.minutesTilUpdate);
	UIDropDownMenu_Initialize(this, InventoryOnParOption.DropDownUpdateMinutes.Initialize);
	UIDropDownMenu_SetWidth(90, this);
end

function InventoryOnParOption.DropDownUpdateMinutes.Initialize()
	local minuteOption = {};
	for minuteIndex = 5, 60, 5 do
		minuteOption.text = string.format(GENERIC_MIN_P1, minuteIndex);
		minuteOption.value = minuteIndex;
		minuteOption.func = InventoryOnParOption.DropDownUpdateMinutes.OnClick;
		local checked = nil;
		if ( UIDropDownMenu_GetSelectedValue(InventoryOnParOptionDropDownUpdateMinutes) and tonumber(UIDropDownMenu_GetSelectedValue(InventoryOnParOptionDropDownUpdateMinutes)) == minuteIndex ) then
			checked = 1;
			UIDropDownMenu_SetText(minuteOption.text, InventoryOnParOptionDropDownUpdateMinutes);
		else
			checked = nil;
		end
		minuteOption.checked = checked;

		UIDropDownMenu_AddButton(minuteOption);
	end
	for minuteIndex = 70, 120, 10 do
		minuteOption.text = string.format(GENERIC_MIN_P1, minuteIndex);
		minuteOption.value = minuteIndex;
		minuteOption.func = InventoryOnParOption.DropDownUpdateMinutes.OnClick;
		local checked = nil;
		if ( UIDropDownMenu_GetSelectedValue(InventoryOnParOptionDropDownUpdateMinutes) and tonumber(UIDropDownMenu_GetSelectedValue(InventoryOnParOptionDropDownUpdateMinutes)) == minuteIndex ) then
			checked = 1;
			UIDropDownMenu_SetText(minuteOption.text, InventoryOnParOptionDropDownUpdateMinutes);
		else
			checked = nil;
		end
		minuteOption.checked = checked;

		UIDropDownMenu_AddButton(minuteOption);
	end
end

function InventoryOnParOption.DropDownUpdateMinutes.OnClick()
	UIDropDownMenu_SetSelectedValue(InventoryOnParOptionDropDownUpdateMinutes, this.value);
end

--------------------------------------------------------------------------------------------- 

InventoryOnParOption.DateFormat = {};

function InventoryOnParOption.DateFormat.OnShow()
	InventoryOnParOptionDateFormat:SetText(IOP.Options.dateFormat);
end

function InventoryOnParOption.DateFormat.OnUpdate()
	IOP.Options.dateFormat = InventoryOnParOptionDateFormat:GetText();
end

--------------------------------------------------------------------------------------------- 

InventoryOnParOption.MinLevel = {};

function InventoryOnParOption.MinLevel.OnShow()
	InventoryOnParOptionMinLevel:SetText(IOP.Options.minLevel);
end

function InventoryOnParOption.MinLevel.OnUpdate()
	IOP.Options.minLevel = tonumber(InventoryOnParOptionMinLevel:GetText());
end

--------------------------------------------------------------------------------------------- 

InventoryOnParOption.MaxLevel = {};

function InventoryOnParOption.MaxLevel.OnShow()
	InventoryOnParOptionMaxLevel:SetText(IOP.Options.maxLevel);
end

function InventoryOnParOption.MaxLevel.OnUpdate()
	IOP.Options.maxLevel = tonumber(InventoryOnParOptionMaxLevel:GetText());
end

--------------------------------------------------------------------------------------------- 