-------------------------------------------------------------------------------
-- tab management code, credits to no-one anymore - made extremely simple by me
-------------------------------------------------------------------------------

SL_SUBFRAMES = { "SL_ConfigBiddingFrame", "SL_ConfigRaidRollFrame", "SL_ConfigMuleFrame" };

function SL_ShowSubFrame(frameName)
	for index, value in SL_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
			PanelTemplates_SetTab(SL_ConfigFrame, index);
		else
			getglobal(value):Hide();	
		end	
	end 
end

function SL_Tab_OnClick()
	local id = this:GetID();
	local tab = SL_SUBFRAMES[id];
	local subFrame = getglobal(tab);
	SL_ShowSubFrame(tab);
	PlaySound("igCharacterInfoTab");
end

-------------------------------------------------------------------------------
-- GLOBAL CODE
-------------------------------------------------------------------------------

function SL_Config_OnLoad()
	PanelTemplates_SetNumTabs(this, 3);
end

function SL_ToggleOption(option)
	if (SL_OPTIONS[option]==nil or SL_OPTIONS[option]==false) then
		SL_OPTIONS[option] = true;
		PlaySound("igMainMenuOptionCheckBoxOff");
	else
		SL_OPTIONS[option] = false;
		PlaySound("igMainMenuOptionCheckBoxOn");
	end
end

-------------------------------------------------------------------------------
-- BIDDING
-------------------------------------------------------------------------------

function SL_ConfigBidding_OnShow()
	SL_AnnounceBidsCB:SetChecked(SL_OPTIONS.AnnounceBids);
	SL_AllowExceedCB:SetChecked(SL_OPTIONS.AllowExceed);
	SL_AllowRebidCB:SetChecked(SL_OPTIONS.AllowRebid);
	SL_AnnouncePoolChangesCB:SetChecked(SL_OPTIONS.AnnouncePoolChanges);
	SL_DisableHandoutCB:SetChecked(SL_OPTIONS.DisableHandout); -- todo: not really bidding option! affects rr too!
	SL_2ndPlus1CB:SetChecked(SL_OPTIONS["2ndPlus1"]);
	if (not SL_IsDkpIntegrated()) then
		SL_AllowExceedCB:Disable();
		SL_AnnouncePoolChangesCB:Disable();
	end
end

-------------------------------------------------------------------------------
-- RAIDROLL OPTIONS
-------------------------------------------------------------------------------

function SL_ConfigRaidRoll_OnShow()
	SL_WhisperNumbersCB:SetChecked(SL_OPTIONS.WhisperNumbers);
	SL_AnnounceRRStartCB:SetChecked(SL_OPTIONS.AnnounceRRStart);
	SL_AnnounceRREndCB:SetChecked(SL_OPTIONS.AnnounceRREnd);
	SL_AutoHandoutUpToGreenCB:SetChecked(SL_OPTIONS.AutoHandoutUpToGreen);
end


-------------------------------------------------------------------------------
-- MULE OPTIONS
-------------------------------------------------------------------------------

SL_MULE_HEIGHT = 15;
SL_MULE_ITEMS_SHOWN = 13;

function SL_UpdateMule()
	local offset = FauxScrollFrame_GetOffset(SL_MuleScrollFrame);
	local size = table.getn(SL_OPTIONS.MuleItems);
	FauxScrollFrame_Update(SL_MuleScrollFrame, size, SL_MULE_ITEMS_SHOWN, SL_MULE_HEIGHT);
	for i=1, SL_MULE_ITEMS_SHOWN do
		local listFrame = "SL_MuleItem"..i;
		if (i>size) then 
			getglobal(listFrame):Hide();
		else
			local text = SL_OPTIONS.MuleItems[offset+i];
			getglobal(listFrame).index = offset+i;
			getglobal(listFrame.."_Item"):SetText(text);
			getglobal(listFrame):Show();
		end
	end
end

function SL_ConfigMule_OnShow()
	SL_UpdateMule();
end

function SL_MuleItem_OnClick(button)
	if (button=="RightButton") then
		ToggleDropDownMenu(1, nil, SL_ConfigMuleFrame_DropDown, this:GetName(), 0, 0);
	end
end

function SL_MuleDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, SL_MuleDropDown_Init, "MENU");
end

function SL_MuleDropDown_Init()
	item = {};
	item.text = "Remove selected";
	item.notCheckable = 1;
	item.func = SL_MenuRemoveMuleItem;
	item.value = this.index;
	UIDropDownMenu_AddButton(item);
end

function SL_MenuRemoveMuleItem()
	table.remove(SL_OPTIONS.MuleItems, this.value);
	SL_UpdateMule();	
end
