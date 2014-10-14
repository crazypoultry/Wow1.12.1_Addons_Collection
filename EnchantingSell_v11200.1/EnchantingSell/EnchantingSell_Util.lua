--presents a dialog box to the user.  
-- msg- is displayed to the user
-- functionArg1- called when user selects Yes
-- functionArg2- called when user selects No

function ESell_ConfirmDialogYesOrNo(msg, functionArg1, functionArg2)
	if EnchantingSell_ConfirmFrame:IsShown() then
		EnchantingSell_Msg:AddMessage(ENCHANTINGSELL_MSG_ERREUR_NEWASKIMPOSSIBLE.." !!!", 1.0, 0.1, 0.1, 1.0, 7);
		return;
	end
	EnchantingSell_ConfirmFrame_Msg:SetText(msg);
	EnchantingSell_ConfirmFrame.FunctionArg1 = functionArg1;
	EnchantingSell_ConfirmFrame.FunctionArg2 = functionArg2;
	EnchantingSell_ConfirmFrame:Show();
end


--converts a string value into a number
function ESell_Money_getMoney(typeMoney, price)
	if not price then return nil; end
	if typeMoney == "Gold" then
		return (floor(price/10000));
	end if typeMoney == "Silver" then
		return (floor(price/100) - (floor(price/10000)*100));		
	end if typeMoney == "Copper" then
		return mod(price, 100);				
	end
end


function ESell_Money_getStringFormatWithGSC(value)
	local goldValue = ESell_Money_getMoney("Gold", value);
	local silverValue = ESell_Money_getMoney("Silver", value);
	local copperValue = ESell_Money_getMoney("Copper", value);
	local _, textSilverValue, textCopperValue = ESell_Money_getStringFormat(value);
	local textPriceReturn = "";

	if not goldValue then retrun "" end
	
	if goldValue > 0 then
		textPriceReturn = (goldValue..ENCHANTINGSELL_PRICE_UNITEGOLD);
	end
	if silverValue > 0 then
		if goldValue > 0 and copperValue > 0 then textPriceReturn = (textPriceReturn.." "..textSilverValue..ENCHANTINGSELL_PRICE_UNITESILVER) end
		if goldValue > 0 and copperValue == 0 then textPriceReturn = (textPriceReturn..textSilverValue) end
		if goldValue == 0 then textPriceReturn = (silverValue..ENCHANTINGSELL_PRICE_UNITESILVER) end
	else
		if goldValue > 0 and copperValue > 0 then textPriceReturn = (textPriceReturn.." "..textSilverValue..ENCHANTINGSELL_PRICE_UNITESILVER) end
	end
	if copperValue > 0 then
		if goldValue > 0 then textPriceReturn = (textPriceReturn.." "..textCopperValue..ENCHANTINGSELL_PRICE_UNITECOPPER) end
		if goldValue == 0 and silverValue > 0  then	textPriceReturn = (textPriceReturn..textCopperValue) end
		if goldValue == 0 and silverValue == 0  then	textPriceReturn = (copperValue..ENCHANTINGSELL_PRICE_UNITECOPPER) end
	end
	return textPriceReturn;
end

function ESell_Money_getStringFormatWithColor(value)
	local ColorMoney = {Gold = "|cffcfb53b", Silver = "|c99e6e8fa", Copper = "|cffb87333"}
	local Gold, Silver, Copper = ESell_Money_getStringFormat(value);
	
	if value then
		return (ColorMoney.Gold..Gold.." "..ColorMoney.Silver..Silver.." "..ColorMoney.Copper..Copper);
	end
	return "";
end

function ESell_Money_getStringFormat(value)
	if not value then return nil; end

	local goldValue = ESell_Money_getMoney("Gold", value);
	local silverValue = ESell_Money_getMoney("Silver", value);
	local copperValue = ESell_Money_getMoney("Copper", value);
	
	local Gold, Silver, Copper;

	if goldValue == 0 then
		Gold = "";
	else
		Gold = (""..goldValue);
	end

	if silverValue == 0 then
		if (goldValue ~= 0) then
			Silver = "00";
		else
			Silver = "";
		end
	else
		if floor(silverValue/10) == 0 then
			Silver = ("0"..silverValue);
		else
			Silver = (""..silverValue);
		end
	end

	if copperValue == 0 then
		Copper="00";
	else
		if floor(copperValue/10) == 0 then
			Copper = ("0"..copperValue);
		else
			Copper = (""..copperValue);
		end
	end
	return Gold, Silver, Copper;
end