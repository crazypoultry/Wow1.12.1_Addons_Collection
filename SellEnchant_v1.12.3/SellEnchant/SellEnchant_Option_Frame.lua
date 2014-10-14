function SellEnchant_Option_MarkupPercent_OnTextChanged()
		SellEnchant_Flow_DebugMessage("SellEnchant_Option_MarkupPercent_OnTextChanged - ENTER");
	SellEnchant_Config.PourcentageBenefice = ((this:GetNumber()/100)+1);
	ESell_Enchante_UpdateAllPrice();
end

function ESell_Option_Enchanting_PourcentBeneficeEditBox_OnEnterPressed()
	SellEnchant_Config.PourcentageBenefice = ((this:GetNumber()/100)+1);
	ESell_Enchante_UpdateAllPrice();
	this:ClearFocus();
end

function ESell_Option_Enchanting_PourcentBeneficeEditBox_UpDate()
	this:SetNumber(((SellEnchant_Config.PourcentageBenefice-1)*100));
end

-------------------------------------
-- Character select drop down menu --
-------------------------------------
function SellEnchant_Option_DropDown_PlayerSelect_Initialize()
	SellEnchant_Flow_DebugMessage("SellEnchant_Option_DropDown_PlayerSelect_Initialize - ENTER");
	local enchantorSelected = SellEnchant_Config.EnchantorPlayerSelected;
	local listPlayer = nil;
	listPlayer = {};

	if SellEnchant_Config.EnchantorTable then
		for i, enchantor in ipairs(SellEnchant_Config.EnchantorTable) do
			tinsert(listPlayer, {
				enchantor[1]..SELLENCHANT_SELLENCHANT_OPTION_JOINPLAYERANDSERVER..enchantor[2],
				enchantor,
			});
		end
	end

	local titletext;
	if (not enchantorSelected) then
		titletext = SELLENCHANT_NOT_ENCHANTER;
	else
		titletext = (enchantorSelected[1]..SELLENCHANT_SELLENCHANT_OPTION_JOINPLAYERANDSERVER..enchantorSelected[2]);
	end

	UIDropDownMenu_SetText(titletext, SellEnchant_DropDownEnchantorPlayerSelect);

	info = {};
	for i, player in ipairs(listPlayer) do
		info.text = player[1];
		info.value = player[2];
		info.checked = nil;
		info.func = SellEnchant_Option_DropDown_PlayerSelect_OnClick;
		if player[2][2] ~= enchantorSelected[2] then
			info.textR = 255;
			info.textG = 1;
			info.textB = 1;
		else if ESell_Player_IsEq(player[2], enchantorSelected) then
				info.textR = 1;
				info.textG = 255;
				info.textB = 1;				
			else
				info.textR = 1;
				info.textG = 1;
				info.textB = 1;
			end
		end
		UIDropDownMenu_AddButton(info);
	end
	SellEnchant_Flow_DebugMessage("SellEnchant_Option_DropDown_PlayerSelect_Initialize - EXIT");
end



function SellEnchant_Option_DropDown_PlayerSelect_OnClick()
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownEnchantorPlayerSelect_OnClick - ENTER");
	local SE_New_Character_Selected;
	SE_New_Character_Selected = (this.value);
	if (not (ESell_Player_IsEq(SE_New_Character_Selected, SellEnchant_Config.EnchantorPlayerSelected))) then
		if SE_New_Character_Selected[2] ~= SellEnchant_Config.EnchantorPlayerSelected[2] then
			SellEnchant_DebugMessage("Character selected on a different server");
 			ESell_ConfirmDialogYesOrNo(SELLENCHANT_OPTION_MESSAGE_CONFIRMCHANGESERVER, function () ESell_Reagent_DeleteAllplayerCount(); SellEnchant_Option_PlayerSelect(SE_New_Character_Selected); end, nil);
		end
		SellEnchant_Option_PlayerSelect(SE_New_Character_Selected);
	else
		SellEnchant_DebugMessage("Selected player not changed");
	end
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownEnchantorPlayerSelect_OnClick - EXIT");
end


function SellEnchant_Option_PlayerSelect(playerSelect)
	SellEnchant_Flow_DebugMessage("SellEnchant_Option_PlayerSelect - ENTER");
	SellEnchant_Config.EnchantorPlayerSelected = playerSelect;
	ESell_Enchante_UpDateAllKnowByEnchantorAtFalse();
	ESell_Reagent_UpDateAllUseByEnchantorAtFalse();
	ESell_Enchante_UpdateEtat();
	SellEnchant_Option_DropDown_PlayerSelect_Initialize();
	if ESell_Player_IsEq(SellEnchant_Config.EnchantorPlayerSelected, SellEnchant_CourantPlayer) then
		SellEnchant_DebugMessage("Changed to current character; Initializing database");
		ESell_InizalizeData();
	end
	SellEnchant_Flow_DebugMessage("SellEnchant_Option_PlayerSelect - EXIT");
end


-------------------------------------------------------------
-- Check to see if valid auction scan program is installed --
-------------------------------------------------------------
function SellEnchant_ValidAuctionScanAvailable(ValidScanner)
	SellEnchant_DebugMessage("Enter SE_ValidAuctionScanAvailable");
	SellEnchant_AuctioneerLoaded = IsAddOnLoaded("Auctioneer");
	SellEnchant_MatrixLoaded = IsAddOnLoaded("AuctionMatrix");
	SellEnchant_KCItemsLoaded  = IsAddOnLoaded("KC_Items");
	SellEnchant_wowEconLoaded = IsAddOnLoaded("WOWEcon_PriceMod");
	if (SellEnchant_AuctioneerLoaded) then
					if SellEnchant_Config.SellEnchantUseAuctioneer then
						SellEnchant_Msg:AddMessage("Auctioneer prices loaded.", 0.1, 1.0, 0.1, 1.0, 7);
					else
						SellEnchant_Msg:AddMessage("Auctioneer prices unloaded.", 1.0, 0.1, 0.1, 1.0, 7);
					end
		ValidScanner = true;
	else
		if (SellEnchant_MatrixLoaded) then
					if SellEnchant_Config.SellEnchantUseAuctioneer then
						SellEnchant_Msg:AddMessage("AuctionMatrix prices loaded.", 0.1, 1.0, 0.1, 1.0, 7);
					else
						SellEnchant_Msg:AddMessage("AuctionMatrix prices unloaded.", 1.0, 0.1, 0.1, 1.0, 7);
					end
			ValidScanner = true;
		else
			if (SellEnchant_KCItemsLoaded) then
					if SellEnchant_Config.SellEnchantUseAuctioneer then
						SellEnchant_Msg:AddMessage("KC_Items prices loaded.", 0.1, 1.0, 0.1, 1.0, 7);
					else
						SellEnchant_Msg:AddMessage("KC_Items prices unloaded.", 1.0, 0.1, 0.1, 1.0, 7);
					end
				ValidScanner = true;
			else
				if (SellEnchant_wowEconLoaded) then
					if SellEnchant_Config.SellEnchantUseAuctioneer then
						SellEnchant_Msg:AddMessage("WOWEcon prices loaded.", 0.1, 1.0, 0.1, 1.0, 7);
					else
						SellEnchant_Msg:AddMessage("WOWEcon prices unloaded.", 1.0, 0.1, 0.1, 1.0, 7);
					end
					ValidScanner = true;
				else
					SellEnchant_Msg:AddMessage("No supported auction house price scanner found.", 1.0, 0.1, 0.1, 1.0, 7);
					ValidScanner=false;
				end
			end
		end
	end
--	return;
--	SellEnchant_DebugMessage(ValidScanner);
	SellEnchant_DebugMessage("Exit SE_ValidAuctionScanAvailable");
end
