UIPanelWindows["EnchantingSell_Frame"] = { area = "left", pushable = 0 };

local ENCHANTINGSELL_TAB_SUBFRAMES = { "EnchantingSell_Enchante_Frame", "EnchantingSell_Componant_Frame", "EnchantingSell_Option_Frame" };

function EnchantingSell_Frame_OnLoad()
	-- Tab Handling code
	PanelTemplates_SetNumTabs(this, 3);
	PanelTemplates_SetTab(this, 1);

	EnchantingSell_Frame:SetFrameLevel(1);
	EnchantingSellMinimapButton:SetFrameLevel(1);

	ShowUIPanel(EnchantingSellMinimapButton);
end

function EnchantingSell_Frame_OnShow()
	PlaySound("igCharacterInfoOpen");
end

function EnchantingSell_Frame_OnHide()
	PlaySound("igCharacterInfoClose");
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fonction pour la gestion des onglets frame principale --------------------------------------------------------------------------------------------------------------------------

function EnchantingSell_Tab_OnClick()
	if ( this:GetName() == "EnchantingSell_FrameTab1" ) then
		Toggle_EnchantingSell("EnchantingSell_Enchante_Frame"); 
	elseif ( this:GetName() == "EnchantingSell_FrameTab2" ) then
		Toggle_EnchantingSell("EnchantingSell_Componant_Frame");
	elseif ( this:GetName() == "EnchantingSell_FrameTab3" ) then
		Toggle_EnchantingSell("EnchantingSell_Option_Frame");
	end
	PlaySound("igCharacterInfoTab");
end

function EnchantingSell_Frame_ShowSubFrame(frameName)
	for index, value in ENCHANTINGSELL_TAB_SUBFRAMES do
		if ( value == frameName ) then
			getglobal(value):Show();
		else
			getglobal(value):Hide();
		end
	end
end

function Toggle_EnchantingSell(tab)
	if ( not tab ) then
		if ( EnchantingSell_Frame:IsVisible() ) then
			HideUIPanel(EnchantingSell_Frame);
		else
			ShowUIPanel(EnchantingSell_Frame);
			local selectedFrame = getglobal(ENCHANTINGSELL_TAB_SUBFRAMES[EnchantingSell_Frame.selectedTab]);
			if ( not selectedFrame:IsVisible() ) then
				selectedFrame:Show()
			end
		end
	else
		local subFrame = getglobal(tab);
		if ( subFrame ) then
			PanelTemplates_SetTab(EnchantingSell_Frame, subFrame:GetID());
			if ( EnchantingSell_Frame:IsVisible() ) then
				if ( subFrame:IsVisible() ) then
					HideUIPanel(EnchantingSell_Frame);
				else
					PlaySound("igCharacterInfoTab");
					EnchantingSell_Frame_ShowSubFrame(tab);
				end
			else
				ShowUIPanel(EnchantingSell_Frame);
				EnchantingSell_Frame_ShowSubFrame(tab);
			end
		end
	end
	ESell_ChangeEnchantePrice_Reset();
end
