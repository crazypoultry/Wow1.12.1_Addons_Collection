UIPanelWindows["SellEnchant_Frame"] = { area = "left", pushable = 0 };

local SELLENCHANT_TAB_SUBFRAMES = { "SellEnchant_Enchante_Frame", "SellEnchant_Componant_Frame", "SellEnchant_Option_Frame" };

function SellEnchant_Frame_OnLoad()
	SellEnchant_Flow_DebugMessage("SellEnchant_Frame_OnLoad - ENTER");
	-----------------------
	-- Tab Handling code --
	-----------------------
	PanelTemplates_SetNumTabs(this, 3);
	PanelTemplates_SetTab(this, 1);

	SellEnchant_Frame:SetFrameLevel(1);
	SellEnchantMinimapButton:SetFrameLevel(1);
	SellEnchant_Flow_DebugMessage("SellEnchant_Frame_OnLoad - EXIT");
end

function SellEnchant_Frame_OnShow()
	PlaySound("igCharacterInfoOpen");
end

function SellEnchant_Frame_OnHide()
	PlaySound("igCharacterInfoClose");
end

----------------------------------------------------------------
-- Function for the principal management of the joining frame --
----------------------------------------------------------------

function SellEnchant_Tab_OnClick()
	if ( this:GetName() == "SellEnchant_FrameTab1" ) then
		Toggle_SellEnchant("SellEnchant_Enchante_Frame"); 
	elseif ( this:GetName() == "SellEnchant_FrameTab2" ) then
		Toggle_SellEnchant("SellEnchant_Componant_Frame");
	elseif ( this:GetName() == "SellEnchant_FrameTab3" ) then
		Toggle_SellEnchant("SellEnchant_Option_Frame");
	end
	PlaySound("igCharacterInfoTab");
end

function SellEnchant_Frame_ShowSubFrame(frameName)
	for index, value in SELLENCHANT_TAB_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end

function Toggle_SellEnchant(tab)
	if ( not tab ) then
		if ( SellEnchant_Frame:IsVisible() ) then
			HideUIPanel(SellEnchant_Frame);
		else
			ShowUIPanel(SellEnchant_Frame);
			local selectedFrame = getglobal(SELLENCHANT_TAB_SUBFRAMES[SellEnchant_Frame.selectedTab]);
			if ( not selectedFrame:IsVisible() ) then
				selectedFrame:Show()
			end
		end
	else
		local subFrame = getglobal(tab);
		if ( subFrame ) then
			PanelTemplates_SetTab(SellEnchant_Frame, subFrame:GetID());
			if ( SellEnchant_Frame:IsVisible() ) then
				if ( subFrame:IsVisible() ) then
					HideUIPanel(SellEnchant_Frame);
				else
					PlaySound("igCharacterInfoTab");
					SellEnchant_Frame_ShowSubFrame(tab);
				end
			else
				ShowUIPanel(SellEnchant_Frame);
				SellEnchant_Frame_ShowSubFrame(tab);
			end
		end
	end
	ESell_ChangeEnchantePrice_Reset();
end
