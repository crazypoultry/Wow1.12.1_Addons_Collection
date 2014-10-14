local listIdSelectedEnchante;

SELLENCHANT_NUM_LINE_ENCHANTES = 9;
SELLENCHANT_NUM_LINE_REAGENTS = 6;

function SellEnchant_Enchante_Frame_OnShow()
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Frame_OnShow - ENTER");
	SortEnchante();
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Frame_OnShow - EXIT");
end

function SellEnchant_Enchante_Frame_OnUpdate()
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Frame_OnUpdate - ENTER");
	UpDateListeEnchante();
	UpDate_Enchante_ListeDetail();
	ESell_ChangeEnchantePrice_Reset();
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Frame_OnUpdate - EXIT");
end

function SelectIdEnchante(id)
	SellEnchant_Flow_DebugMessage("SelectIdEnchante - ENTER");
	listIdSelectedEnchante = id;
	if id then SellEnchant_Enchante_ScrollFrameScrollBar:SetValue((id-1)*SELLENCHANT_NUM_LINE_ENCHANTES); end
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Flow_DebugMessage("SelectIdEnchante - EXIT");	
end

function SortEnchante(nameArgSort)
	SellEnchant_Flow_DebugMessage("SortEnchante - ENTER");
	local EnchantNameSelect;
    -- Test to sort by armor and an item is selected
	if (SellEnchant_Config.EnchanteSortArmor or SellEnchant_Config.EnchanteSortBonus) and listIdSelectedEnchante then
--		local _, onThis, _, _, _, bonusLongName = ESell_Enchante_getInfoBonus(listIdSelectedEnchante);
		local _, onThis, bonus = ESell_Enchante_getInfoBonus(listIdSelectedEnchante);
--		if onThis ~= SellEnchant_Config.EnchanteSortArmor then
--		if onThis ~= SellEnchant_Config.EnchanteSortArmor and bonusLongName ~= SellEnchant_Config.EnchanteSortBonus then
		if onThis ~= SellEnchant_Config.EnchanteSortArmor and bonus ~= SellEnchant_Config.EnchanteSortBonus then
			listIdSelectedEnchante = nil;
		end
	end
--	Test to see if item is selected
	if listIdSelectedEnchante then
		EnchantNameSelect = ESell_Enchante_getInfoDetail(listIdSelectedEnchante);
	end
	ESell_EnchanteSort(nameArgSort);
if EnchantNameSelect then
SellEnchant_DebugMessage(EnchantNameSelect);	
else
SellEnchant_DebugMessage("--EnchantNameSelect is nil--");
end

	if EnchantNameSelect then 
		listIdSelectedEnchante = ESell_Enchante_getId(EnchantNameSelect);
	end
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Flow_DebugMessage("SortEnchante - EXIT");
end

function UpDateListeEnchante()
	SellEnchant_Flow_DebugMessage("UpDateListeEnchante - ENTER");
	local enchantorSelected;
	if SellEnchant_Config then
		enchantorSelected = SellEnchant_Config.EnchantorPlayerSelected;
	end
	if enchantorSelected then
		SellEnchant_NameEnchantorSelected_Name:SetText("[ "..enchantorSelected[1]..SELLENCHANT_SELLENCHANT_OPTION_JOINPLAYERANDSERVER..enchantorSelected[2].." ]");
	else
		SellEnchant_NameEnchantorSelected_Name:SetText("");
	end
	if ESell_Player_IsEq(enchantorSelected, SellEnchant_CourantPlayer) then
		SellEnchant_NameEnchantorSelected_Name:SetTextColor(0.85, 0.85, 0.85);
	else
		SellEnchant_NameEnchantorSelected_Name:SetTextColor(0.90, 0.60, 0.60);
	end


	local index=0, completeBonus;

	if (ESell_Enchante_getNb() == 0) then 
		SellEnchant_Enchante_ScrollFrame_Children:Hide();
		return; 
	end
	SellEnchant_Enchante_ScrollFrame_Children:Show();

	local nbShow = 0;

	-- Counts the number of valid enchants meeting sort criteria
	if SellEnchant_Config.EnchanteSortArmor or SellEnchant_Config.EnchanteSortBonus then
		-- Count only armor
		if SellEnchant_Config.EnchanteSortArmor and (not (SellEnchant_Config.EnchanteSortBonus)) then
			for i=1, ESell_Enchante_getNb(), 1 do
				local _, onThis = ESell_Enchante_getInfoBonus(i);
				if (SellEnchant_Config.EnchanteSortArmor == onThis) then
					nbShow = nbShow + 1;
				end
			end
		end
		-- Count only bonus
		--------------------------------------------------------
		--------------------------------------------------------
		-- have to make it so I count the bonusnamelong types --
		-- Name, onThis, Bonus, BonusNb, Link, BonusLongName  --
		--------------------------------------------------------
		--------------------------------------------------------
		if (not (SellEnchant_Config.EnchanteSortArmor)) and SellEnchant_Config.EnchanteSortBonus then
			for i=1, ESell_Enchante_getNb(), 1 do
				local _, _, _, _, _, bonusLongName = ESell_Enchante_getInfoBonus(i);
				if (SellEnchant_Config.EnchanteSortBonus == bonusLongName) then
					nbShow = nbShow + 1;
				end
			end
		end
		-- Count on both
		if SellEnchant_Config.EnchanteSortArmor and SellEnchant_Config.EnchanteSortBonus then
			for i=1, ESell_Enchante_getNb(), 1 do
				local _, onThis, _, _, _, bonusLongName = ESell_Enchante_getInfoBonus(i);
				if (SellEnchant_Config.EnchanteSortArmor == onThis) and (SellEnchant_Config.EnchanteSortBonus == bonusLongName) then
					nbShow = nbShow + 1;
				end
			end
		end
	else
		nbShow = ESell_Enchante_getNb();
	end


	FauxScrollFrame_Update(SellEnchant_Enchante_ScrollFrame, nbShow, SELLENCHANT_NUM_LINE_ENCHANTES, SELLENCHANT_NUM_LINE_ENCHANTES,nil,nil,nil);

	for i=1, SELLENCHANT_NUM_LINE_ENCHANTES, 1 do
		if FauxScrollFrame_GetOffset(SellEnchant_Enchante_ScrollFrame) == nil then
			index = i;
		else
			index = i + FauxScrollFrame_GetOffset(SellEnchant_Enchante_ScrollFrame);
		end

		if index == listIdSelectedEnchante then
			getglobal("SellEnchant_Enchante_List"..i):LockHighlight();
		else
			getglobal("SellEnchant_Enchante_List"..i):UnlockHighlight();
		end

		local name, onThis, bonusType, bonusAdd, Link = ESell_Enchante_getInfoBonus(index);
		if (name) and (index <= nbShow) then
			getglobal("SellEnchant_Enchante_List"..i.."_Name"):SetText(name);
			getglobal("SellEnchant_Enchante_List"..i.."_OnThis"):SetText(onThis);
			
--			if (ESell_Enchante_getCountMaked(index) == nil) or (ESell_Enchante_getCountMaked(index) == "") then
--				ESell_Enchante_getCountMaked(index) = 0;
--			end
			getglobal("SellEnchant_Enchante_List"..i.."_MakeCount"):SetText("("..ESell_Enchante_getCountMaked(index)..")");
			 
			 
			if bonusAdd then
				completeBonus = bonusType.." +"..bonusAdd;
			else
				completeBonus = bonusType;
			end
			
			getglobal("SellEnchant_Enchante_List"..i.."_Bonus"):SetText(completeBonus);	

			local price, goodPrice = ESell_Enchante_getPrice(index);

			if goodPrice == -1 then price = 0 end
			ESell_Money_SetPrice(price, "SellEnchant_Enchante_List"..i.."_Price");	
	
			local color = TEXTECOLOR[ESell_Enchante_getEtat(index)];
			if not color then color = {0.80, 0.80, 0.80} end
			getglobal("SellEnchant_Enchante_List"..i.."_MakeCount"):SetTextColor(color[1], color[2], color[3]);
			getglobal("SellEnchant_Enchante_List"..i.."_Name"):SetTextColor(color[1], color[2], color[3]);
			getglobal("SellEnchant_Enchante_List"..i.."_OnThis"):SetTextColor(color[1], color[2], color[3]);		
			getglobal("SellEnchant_Enchante_List"..i.."_Bonus"):SetTextColor(color[1], color[2], color[3]);	

			local chatText=Link;
--			if completeBonus and onThis then
--				chatText = ("[ "..onThis..": "..completeBonus);
--			else
--				chatText = ("[ "..name);
--			end
			
--			if SellEnchant_Config.EnchanteChatPrice and price and price ~= 0 then
			if SellEnchant_Config.EnchanteChatPrice and price and price ~= 0 then
				chatText = ("{ "..chatText..SELLENCHANT_ADVERT_PREPOSITION..ESell_Money_getStringFormatWithGSC(price).." }");
				SellEnchant_DebugMessage("UpDateListeEnchante after chatText =");
			end
--			else
--				chatText = (chatText.." ]");				
--			end
			getglobal("SellEnchant_Enchante_List"..i).ChatTextForAdd = chatText;
			
			getglobal("SellEnchant_Enchante_List"..i):Show();
		else
			getglobal("SellEnchant_Enchante_List"..i):Hide();			
		end
	end
	SellEnchant_Flow_DebugMessage("UpDateListeEnchante - EXIT");
end

function UpDate_Enchante_ListeDetail()
	SellEnchant_Flow_DebugMessage("UpDate_Enchante_ListeDetail - ENTER");
	if not listIdSelectedEnchante then 
		SellEnchant_Enchante_DetailFrame:Hide()
		SellEnchant_CraftCreateButton:Disable();
		SellEnchant_DebugMessage("Nothing highlighted.");
--		return; 
	else
		local nbReagents = ESell_Enchante_getNumReagent(listIdSelectedEnchante);
	
		local enchanteLongName, enchanteIcon, enchanteDescription, enchanteRequired, enchanteLink = ESell_Enchante_getInfoDetail(listIdSelectedEnchante);
		local IDCraftOriginal = ESell_Enchante_getIdOriginal(listIdSelectedEnchante);
	
		SellEnchant_Enchante_DetailFrame_Icone:SetNormalTexture(enchanteIcon);
	
		SellEnchant_Enchante_DetailFrame_Icone.hitemLink = enchanteLink;
	
		SellEnchant_Enchante_DetailFrame_Detail_Name:SetText(enchanteLongName);
		
		local nameOrLink;
		if enchanteLink then
			nameOrLink = enchanteLink;
		else
			nameOrLink = enchanteLongName;
		end
		
		if (enchanteDescription) then
			SellEnchant_Enchante_DetailFrame_Detail.ChatTextForAdd = ("{ "..nameOrLink..": "..enchanteDescription.." }");
		else
			SellEnchant_Enchante_DetailFrame_Detail.ChatTextForAdd = ("{ "..nameOrLink.." }");
		end
	
		local etatRequired;
		if enchanteRequired then 
			SellEnchant_Enchante_DetailFrame_Detail_OutilNeededHeader:Show();
			etatRequired = ESell_Enchante_getRequiredEtat(listIdSelectedEnchante);
			local color = TEXTECOLOR[etatRequired];
			if not color then color = {0.80, 0.80, 0.80}; end
			SellEnchant_Enchante_DetailFrame_Detail_OutilNeeded:SetTextColor(color[1], color[2], color[3]);
		else 
			SellEnchant_Enchante_DetailFrame_Detail_OutilNeededHeader:Hide();
		end
		
		local needed = "";
		if ESell_Enchante_getEtat(listIdSelectedEnchante) == -2 then
			SellEnchant_Enchante_DetailFrame_Detail_OutilNeededHeader:Show();
			local color = TEXTECOLOR[-2];
			SellEnchant_Enchante_DetailFrame_Detail_OutilNeeded:SetTextColor(color[1], color[2], color[3]);
			needed = SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDDOESNOTKNOW.." \n\r";
		end
		if enchanteRequired then
			needed = needed..enchanteRequired;
		end
		if etatRequired == 2 then
			needed = needed.." "..SELLENCHANT_ENCHANT_DETAIL_TOOLNEED_ADDNAMEFORINBANK;
		end
		SellEnchant_Enchante_DetailFrame_Detail_OutilNeeded:SetText(needed);
	
		local cMakeBag, cMakeBank, cMakeRR;
		cMakeBag, cMakeBank, cMakeRR = ESell_Enchante_getCountMaked(listIdSelectedEnchante);
		SellEnchant_Enchante_DetailFrame_Detail_CountMaked:SetText("|cff4cff4c("..cMakeBag..") ".."|cff7fb34c("..cMakeBank..") ".."|cffb37f4c("..cMakeRR..")");
	
		SellEnchant_Enchante_DetailFrame_Detail_Description:SetText(enchanteDescription);
	
		local AllListReagentChatText = "[ ";
		for i=1,SELLENCHANT_NUM_LINE_REAGENTS,1 do
			if i > nbReagents then
				getglobal("SellEnchant_Enchante_Reagents_List"..i):Hide();
			else
				SellEnchant_Enchante_Reagents_ListHeader:Show();
				
				local reagentCount, reagentName = ESell_Enchante_getInfoReagent(listIdSelectedEnchante, i);
				local idReagent = ESell_Reagent_getId(reagentName);
	
				local reagentCountBag, reagentCountBank, reagentCountReroll = ESell_Reagent_getCount(idReagent, SellEnchant_Config.EnchantorPlayerSelected);
				if not reagentCountBag then reagentCountBag=0; reagentCountBank=0; reagentCountReroll=0; end
	
				local _, reagentIcone, _, reagentLink = ESell_Reagent_getInfo(idReagent);
	
				local reagentPriceUnite = ESell_Reagent_getPrice(idReagent);
				if not reagentPriceUnite then reagentPriceUnite = 0 end
				
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Icone"):SetTexture(reagentIcone);
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Name"):SetText(reagentName);
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Nb"):SetText(reagentCountBag.."/"..reagentCount);	
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_NbOther"):SetText(reagentCountBank.."-"..reagentCountReroll);	
				
				local color = TEXTECOLOR[ESell_Enchante_getReagentEtat(listIdSelectedEnchante,i)];
				if not color then color = {0.80, 0.80, 0.80} end
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Nb"):SetTextColor(color[1], color[2], color[3]);
				getglobal("SellEnchant_Enchante_Reagents_List"..i.."_NbOther"):SetTextColor(color[1], color[2], color[3]);
				if not reagentIcone then
					getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Name"):SetTextColor(color[1], color[2], color[3]);
				else
					getglobal("SellEnchant_Enchante_Reagents_List"..i.."_Name"):SetTextColor(0.80, 0.80, 0.80);			
				end
	
				ESell_Money_SetPrice(reagentPriceUnite, "SellEnchant_Enchante_Reagents_List"..i.."_PriceUnite");	
				ESell_Money_SetPrice(reagentPriceUnite*reagentCount, "SellEnchant_Enchante_Reagents_List"..i.."_PriceTotal");
				
				local chatTextTemp = "";
				if not reagentLink then
					chatTextTemp = ("{ "..reagentCount.."x "..reagentName.." }");
				else
					chatTextTemp = ("{ "..reagentCount.."x "..reagentLink.." }");
				end
				AllListReagentChatText = AllListReagentChatText..chatTextTemp;
				getglobal("SellEnchant_Enchante_Reagents_List"..i).ChatTextForAdd = chatTextTemp;
				
				getglobal("SellEnchant_Enchante_Reagents_List"..i):Show();
			end
		end
		AllListReagentChatText = AllListReagentChatText.." ]";
		SellEnchant_Enchante_Reagents_ListHeader.ChatTextForAdd = AllListReagentChatText;
		
		SellEnchant_Enchante_MoneyFrame:Show();
		
		local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(listIdSelectedEnchante);
		local color;
		if price then
			MoneyFrame_Update("SellEnchant_Enchante_MoneyFrame", price);
		else
			MoneyFrame_Update("SellEnchant_Enchante_MoneyFrame", 0);		
		end
		if goodPrice == -1 then
			SellEnchant_Enchante_TotalPriceNotBenefFrame:Hide();
			color = TEXTECOLOR[4];
		else
			ESell_Money_SetPrice(priceNoBenef, "SellEnchant_Enchante_TotalPriceNotBenefFrame_Price");	
			SellEnchant_Enchante_TotalPriceNotBenefFrame:Show();
			if goodPrice == 1 then
				color = TEXTECOLOR[-1];
			else
				color = TEXTECOLOR[1];
			end
		end
		SetMoneyFrameColor("SellEnchant_Enchante_MoneyFrame", color[1], color[2], color[3]);
		SellEnchant_Enchante_DetailFrame:Show();
	end
	SellEnchant_Flow_DebugMessage("UpDate_Enchante_ListeDetail - EXIT");
end



function SellEnchant_Update_Enchant_Button()
	if (SellEnchant_Config.EnchantePlayerName == SellEnchant_CourantPlayerName) then
		if ESell_Enchante_getEtat(listIdSelectedEnchante) == 1 then
			SellEnchant_CraftCreateButton:Enable();
		else
			SellEnchant_CraftCreateButton:Disable();
		end
		if (CraftFrame:IsShown()) and (GetCraftName() == SELLENCHANT_NAME_OF_ENCHANT_CRAFT) then
			--	SellEnchant_DebugMessage("Automatic selection in the fenetre carft of the id :"..ESell_Enchante_getIdOriginal(listIdSelectedEnchante));
				CraftFrame_SetSelection(ESell_Enchante_getIdOriginal(listIdSelectedEnchante));
				CraftFrame_Update();
		end
	end
end


function SellEnchant_Enchante_List_OnClick()
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_List_OnClick - ENTER");
	if FauxScrollFrame_GetOffset(SellEnchant_Enchante_ScrollFrame) then
		listIdSelectedEnchante = this:GetID() + FauxScrollFrame_GetOffset(SellEnchant_Enchante_ScrollFrame);
	else
		listIdSelectedEnchante = this:GetID();
	end
	
	SellEnchant_Enchante_Frame_OnUpdate();
--	SellEnchant_Update_Enchant_Button();
	if (SellEnchant_Config.EnchantePlayerName == SellEnchant_CourantPlayerName) then
		if ESell_Enchante_getEtat(listIdSelectedEnchante) == 1 then
			SellEnchant_CraftCreateButton:Enable();
		else
			SellEnchant_CraftCreateButton:Disable();
		end
		if (CraftFrame:IsShown()) and (GetCraftName() == SELLENCHANT_NAME_OF_ENCHANT_CRAFT) then
			--	SellEnchant_DebugMessage("Automatic selection in the fenetre carft of the id :"..ESell_Enchante_getIdOriginal(listIdSelectedEnchante));
				CraftFrame_SetSelection(ESell_Enchante_getIdOriginal(listIdSelectedEnchante));
				CraftFrame_Update();
		end
	end
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_List_OnClick - EXIT");	
end


	

function SellEnchant_Enchante_Price_DoubleClic()
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Price_DoubleClic - ENTER");
	if not listIdSelectedEnchante then return end
	ESell_ChangeEnchantePrice_LaunchFrame(listIdSelectedEnchante)
	SellEnchant_Flow_DebugMessage("SellEnchant_Enchante_Price_DoubleClic - EXIT");
end

function SellEnchant_DoCraft()
	SellEnchant_Flow_DebugMessage("SellEnchant_DoCraft - ENTER");
	local isEnchanteur = ESell_LaunchFunctionInCraftSpellFrame(
		function () 
			if (SellEnchant_Config.EnchantePlayerName == SellEnchant_CourantPlayerName) then
				local idEnchantement = ESell_Enchante_getIdOriginal(listIdSelectedEnchante);
				local enchanteLongName = ESell_Enchante_getInfoDetail(listIdSelectedEnchante)
				local name, onThis, bonusType, bonusAdd = ESell_Enchante_getInfoBonus(listIdSelectedEnchante);
				if idEnchantement and (enchanteLongName == GetCraftInfo(idEnchantement)) then
					DoCraft(idEnchantement);
					local completeBonus;
					if bonusAdd then
						completeBonus = bonusType.." +"..bonusAdd;
					else
						if bonusType then
							completeBonus = bonusType;
						end
					end
					if completeBonus then completeBonus = " ("..completeBonus..")" else completeBonus = "" end
					DEFAULT_CHAT_FRAME:AddMessage(enchanteLongName..completeBonus.." on ...", 0.45, 1, 0.45);
				else
					SellEnchant_DebugMessage("The name in the database does not match the enchants name with the same id");
				end
			end
		end
	);
	if not isEnchanteur then
		SellEnchant_ErrorMessage("This character can not an enchant.");
	end
	SellEnchant_Flow_DebugMessage("SellEnchant_DoCraft - EXIT");
end


function ESell_Option_DropDownBonusType_Initialize()
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownBonusType_Initialize - ENTER");
	if not SellEnchant_BonusType.All then SellEnchant_BonusType.All ="All" end

	---------------------------------------------------
	-- Sets the text that is shown in the drop down. --
	---------------------------------------------------
	if SellEnchant_Config.EnchanteSortBonus then
		UIDropDownMenu_SetText(SellEnchant_Config.EnchanteSortBonus, SellEnchant_DropDownBonusType);
	else
		UIDropDownMenu_SetText(SellEnchant_BonusType.All, SellEnchant_DropDownBonusType);
	end

	----------------------------------------
	-- Set the first button added to All. --
	----------------------------------------
	info = {};
	info.text = SellEnchant_BonusType.All;
	info.value = SellEnchant_BonusType.All;
	info.checked = nil;
	info.func = ESell_Option_DropDownBonusType_OnClick;
	info.disabled = nil;
	info.textR = 1;
	info.textG = 1;
	info.textB = 1;

	----------------------------------------------------------------
	-- Added since the color swatches were being displayed randomly.
	-- Appears info is global variable, so we may need to reset
	-- other variables.
	info.hasColorSwatch = nil;
	info.notClickable = nil;
	UIDropDownMenu_AddButton(info);
	
	----------------------------------------------------------------
	-- Then create and add all the other buttons for the other armor
	for i, TypeBonus in ipairs(SellEnchant_BonusType) do
		info.text = TypeBonus[2];
		info.value = TypeBonus[2];
		info.checked = nil;
		----------------------------------------------------------------
		-- Added since the color swatches were being displayed randomly.
		-- Appears info is global variable, so we may need to reset
		-- other variables.
		info.hasColorSwatch = nil;
		info.func = ESell_Option_DropDownBonusType_OnClick;
		info.disabled = nil;
		info.textR = 1;
		info.textG = 1;
		info.textB = 1;
		info.notClickable = nil;
		
		UIDropDownMenu_AddButton(info);
	end
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownBonusType_Initialize - EXIT");
end


function ESell_Option_DropDownBonusType_OnClick()
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownBonusType_OnClick - ENTER");
	if this.value == SellEnchant_BonusType.All then
		SellEnchant_Config.EnchanteSortBonus = nil;
	else
		SellEnchant_Config.EnchanteSortBonus = this.value;
	end
	UIDropDownMenu_SetText(this.value, SellEnchant_DropDownBonusType);
	SortEnchante();
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownBonusType_OnClick - EXIT");
end

function ESell_Option_DropDownArmor_Initialize()
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownArmor_Initialize - ENTER");
	if not SellEnchant_ArmorCarac.All then SellEnchant_ArmorCarac.All ="All" end

	---------------------------------------------------
	-- Sets the text that is shown in the drop down. --
	---------------------------------------------------
	if SellEnchant_Config.EnchanteSortArmor then
		UIDropDownMenu_SetText(SellEnchant_Config.EnchanteSortArmor, SellEnchant_DropDownArmor);
	else
		UIDropDownMenu_SetText(SellEnchant_ArmorCarac.All, SellEnchant_DropDownArmor);
	end

	----------------------------------------
	-- Set the first button added to All. --
	----------------------------------------
	info = {};
	info.text = SellEnchant_ArmorCarac.All;
	info.value = SellEnchant_ArmorCarac.All;
	info.checked = nil;
	info.func = ESell_Option_DropDownArmor_OnClick;
	info.disabled = nil;
	info.textR = 1;
	info.textG = 1;
	info.textB = 1;

	----------------------------------------------------------------
	-- Added since the color swatches were being displayed randomly.
	-- Appears info is global variable, so we may need to reset
	-- other variables.
	info.hasColorSwatch = nil;
	info.notClickable = nil;
	UIDropDownMenu_AddButton(info);
	
	----------------------------------------------------------------
	-- Then create and add all the other buttons for the other armor
	for i, armor in ipairs(SellEnchant_ArmorCarac) do
		info.text = armor[2];
		info.value = armor[2];
		info.checked = nil;
		----------------------------------------------------------------
		-- Added since the color swatches were being displayed randomly.
		-- Appears info is global variable, so we may need to reset
		-- other variables.
		info.hasColorSwatch = nil;
		info.func = ESell_Option_DropDownArmor_OnClick;
		info.disabled = nil;
		info.textR = 1;
		info.textG = 1;
		info.textB = 1;
		info.notClickable = nil;
		
		UIDropDownMenu_AddButton(info);
	end
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownArmor_Initialize - EXIT");
end


function ESell_Option_DropDownArmor_OnClick()
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownArmor_OnClick - ENTER");
	if this.value == SellEnchant_ArmorCarac.All then
		SellEnchant_Config.EnchanteSortArmor = nil;
	else
		SellEnchant_Config.EnchanteSortArmor = this.value;
	end
	UIDropDownMenu_SetText(this.value, SellEnchant_DropDownArmor);
	SortEnchante();
	SellEnchant_Enchante_Frame_OnUpdate();
	SellEnchant_Flow_DebugMessage("ESell_Option_DropDownArmor_OnClick - EXIT");
end

