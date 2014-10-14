
function ESell_ChangeEnchantePrice_SetStatuEditBox(isEnable)
	local frameMoneyChangeDisable =	function (moneyStr)
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableKeyboard(false);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableMouse(false);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):SetTextColor(0.6,0.6,0.6);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):ClearFocus();
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_up"):Disable();
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_down"):Disable();
		end
	local frameMoneyChangeEnable =	function (moneyStr)
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableKeyboard(true);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):EnableMouse(true);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox"):SetTextColor(1,1,1);
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_up"):Enable();
			getglobal("EnchantingSell_ChangeEnchantePriceFrame_"..moneyStr.."EditBox_down"):Enable();
		end

	if isEnable then
		local price = EnchantingSell_ChangeEnchantePriceFrame.CalcuPrice;
		local goldValue = ESell_Money_getMoney("Gold", price);
		local silverValue = ESell_Money_getMoney("Silver", price);
		local copperValue = ESell_Money_getMoney("Copper", price);
		EnchantingSell_ChangeEnchantePriceFrame_GoldEditBox:SetNumber(goldValue);
		EnchantingSell_ChangeEnchantePriceFrame_SilverEditBox:SetNumber(silverValue);
		EnchantingSell_ChangeEnchantePriceFrame_CopperEditBox:SetNumber(copperValue);

		frameMoneyChangeDisable("Gold");		
		frameMoneyChangeDisable("Silver");		
		frameMoneyChangeDisable("Copper");		
	else
		frameMoneyChangeEnable("Gold");		
		frameMoneyChangeEnable("Silver");		
		frameMoneyChangeEnable("Copper");		
	end
	
end

function ESell_ChangeEnchantePrice_SetNewPrice()
	local idEnchante = EnchantingSell_ChangeEnchantePriceFrame.IdEnchante;
	local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(idEnchante);

	if goodPrice < 2 and EnchantingSell_ChangeEnchantePriceFrame_CheckButton:GetChecked() then
		ESell_ChangeEnchantePrice_Reset(true);
		return;
	end

	if EnchantingSell_ChangeEnchantePriceFrame_CheckButton:GetChecked() then
		EnchantingSell_ListEnchante[idEnchante]["TypePrice"] = 1;
		ESell_Enchante_UpdatePrice(idEnchante);
	else
		local newPrice = 0;
		newPrice = ESell_Money_PriceModifier("Gold", EnchantingSell_ChangeEnchantePriceFrame_GoldEditBox:GetNumber(), newPrice)
		newPrice = ESell_Money_PriceModifier("Silver", EnchantingSell_ChangeEnchantePriceFrame_SilverEditBox:GetNumber(), newPrice)
		newPrice = ESell_Money_PriceModifier("Copper", EnchantingSell_ChangeEnchantePriceFrame_CopperEditBox:GetNumber(), newPrice)
		EnchantingSell_ListEnchante[idEnchante]["Price"] = newPrice;
		EnchantingSell_ListEnchante[idEnchante]["TypePrice"] = 2;
	end
	ESell_ChangeEnchantePrice_Reset(true);
	EnchantingSell_Enchante_Frame_OnUpdate();	
end


function ESell_ChangeEnchantePrice_Reset(isNoMsg)
	if EnchantingSell_ChangeEnchantePriceFrame:IsShown() then
		EnchantingSell_ChangeEnchantePriceFrame.CalcuPrice = nil;
		EnchantingSell_ChangeEnchantePriceFrame.IdEnchante = nil;
		EnchantingSell_ChangeEnchantePriceFrame:Hide();
		if not isNoMsg then
			EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_ERREUR_PRICEMODIFCANCEL.." !!!", 1.0, 0.1, 0.1, 1.0, 5);
		end
	end
end

function ESell_Money_PriceModifier(typeMoney, money, oldPrice)
	local multi;
	if typeMoney == "Gold" then
		multi = 10000;
	end if typeMoney == "Silver" then
		multi = 100;
	end if typeMoney == "Copper" then
		multi = 1;
	end
		return (oldPrice - (ESell_Money_getMoney(typeMoney, oldPrice)*multi) + (money*multi));
end

function ESell_Money_SetPrice(priveValue, nameButton)
	if not nameButton then nameButton = this:getName() end
	local goldValue, silverValue, copperValue = ESell_Money_getStringFormat(priveValue);
	
	getglobal(nameButton.."Gold"):SetText(goldValue);
	getglobal(nameButton.."Silver"):SetText(silverValue);
	getglobal(nameButton.."Copper"):SetText(copperValue);
end
