function ESell_Option_Enchanting_PourcentBeneficeEditBox_OnEnterPressed()
	EnchantingSell_PlayerConfig.PourcentageBenefice = ((this:GetNumber()/100)+1);
	ESell_Enchante_UpdateAllPrice();
	this:ClearFocus();
end

function ESell_Option_Enchanting_PourcentBeneficeEditBox_UpDate()
	this:SetNumber(((EnchantingSell_PlayerConfig.PourcentageBenefice-1)*100));
end

function ESell_Option_Enchanting_DropDownEnchantorPlayerSelect_Initialize()
	local enchantorSelected = EnchantingSell_Config.EnchantorPlayerSelected;
	local listPlayer = nil;
	listPlayer = {};
	
	if EnchantingSell_Config.EnchantorTable then
		for i, enchantor in ipairs(EnchantingSell_Config.EnchantorTable) do
			tinsert(listPlayer, {
				enchantor[1]..ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF..enchantor[2],
				enchantor,
			});
		end
	end

	local titletext;
	if (not enchantorSelected) then
		titletext = ENCHANTINGSELL_OPTION_ENCHANTING_NOTHINGPLAYER;
	else
		titletext = (enchantorSelected[1]..ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF..enchantorSelected[2]);
	end
	
	UIDropDownMenu_SetText(titletext, EnchantingSell_DropDownEnchantorPlayerSelect);

	ES_dropDownPlayerInfo = {};

	for i, player in ipairs(listPlayer) do
		ES_dropDownPlayerInfo.text = player[1];
		ES_dropDownPlayerInfo.value = player[2];
		ES_dropDownPlayerInfo.checked = nil;
		ES_dropDownPlayerInfo.func = ESell_Option_Enchanting_DropDownEnchantorPlayerSelect_OnClick;
		if player[2][2] ~= enchantorSelected[2] then
			ES_dropDownPlayerInfo.textR = 255;
			ES_dropDownPlayerInfo.textG = 1;
			ES_dropDownPlayerInfo.textB = 1;
		else if ESell_Player_IsEq(player[2], enchantorSelected) then
				ES_dropDownPlayerInfo.textR = 1;
				ES_dropDownPlayerInfo.textG = 255;
				ES_dropDownPlayerInfo.textB = 1;				
			else
				ES_dropDownPlayerInfo.textR = 1;
				ES_dropDownPlayerInfo.textG = 1;
				ES_dropDownPlayerInfo.textB = 1;
			end
		end
		UIDropDownMenu_AddButton(ES_dropDownPlayerInfo);
	end


end

function ESell_Option_Enchanting_DropDownEnchantorPlayerSelect_OnClick()

	DebugMessage(this.value[1]);
	local functiontmp = function (playerSelect) 
			EnchantingSell_Config.EnchantorPlayerSelected = playerSelect;
			ESell_Enchante_UpDateAllKnowByEnchantorAtFalse();
			ESell_Reagent_UpDateAllUseByEnchantorAtFalse();
			ESell_Enchante_UpdateEtat();
			ESell_Option_Enchanting_DropDownEnchantorPlayerSelect_Initialize();
			if ESell_Player_IsEq(EnchantingSell_Config.EnchantorPlayerSelected, EnchantingSell_CourantPlayer) then
				DebugMessage("Changement player inisialization bd");
				ESell_InizalizeData();
			end
		end
	
	if ESell_Player_IsEq(this.value, EnchantingSell_Config.EnchantorPlayerSelected) then
		return;
	else
		if this.value[2] ~= EnchantingSell_Config.EnchantorPlayerSelected[2] then
			ESell_ConfirmDialogYesOrNo(ENCHANTINGSELL_OPTION_ENCHANTING_MSGYESORNOTCHANGESERVER, function () ESell_Reagent_DeleteAllplayerCount(); functiontmp(this.value); end, nil);
			return;
		end
		functiontmp(this.value);
	end
end


function ESell_Option_Enchanting_Debug_Toggle()
	if (ESell_Debug) then
		ESell_Debug=false;
	else 
		ESell_Debug=true;
	end
end

function ESell_Option_Enchanting_MinimapIcon_Toggle()
	if (EnchantingSell_PlayerConfig.UseMinimapIcon) then
		EnchantingSell_PlayerConfig.UseMinimapIcon=false;
	else 
		EnchantingSell_PlayerConfig.UseMinimapIcon=true;
	end
	ESell_MiniMapIcon_Update();
end

function ESell_Option_UseTooltips_Toggle()
	if (EnchantingSell_PlayerConfig.UseTooltips) then
		EnchantingSell_PlayerConfig.UseTooltips=false;
	else 
		EnchantingSell_PlayerConfig.UseTooltips=true;
	end
	ESell_UseTooltips_Update();
end

function ESell_Option_EnchanteUseAuctioneer_Toggle()
	if (EnchantingSell_PlayerConfig.EnchanteUseAuctioneer) then
		EnchantingSell_PlayerConfig.EnchanteUseAuctioneer=false;
	else 
		EnchantingSell_PlayerConfig.EnchanteUseAuctioneer=true;
	end
	ESell_ResetPricingRelatedInfo();
end
