local listIdSelectedEnchante;
--local sortTemp = {"OnThis","Bonus","BonusNb","Price","Name"};
--local typeSortAZ = true;

ENCHANTINGSELL_NUM_LINE_ENCHANTES = 10;
ENCHANTINGSELL_NUM_LINE_REAGENTS = 8;

function EnchantingSell_Enchante_Frame_OnShow()
	SortEnchante();
--	UpDate_Enchante_ListeDetail();
--	EnchantingSell_Enchante_Frame_OnUpdate();
end

function EnchantingSell_Enchante_Frame_OnUpdate()
	UpDateListeEnchante();
	UpDate_Enchante_ListeDetail();
	ESell_ChangeEnchantePrice_Reset();
end

function SelectIdEnchante(id)
	listIdSelectedEnchante = id;
	if id then EnchantingSell_Enchante_ScrollFrameScrollBar:SetValue((id-1)*ENCHANTINGSELL_NUM_LINE_ENCHANTES); end
	EnchantingSell_Enchante_Frame_OnUpdate();
end

function SortEnchante(nameArgSort)
	local EnchantNameSelect;

	if EnchanteSortArmor and listIdSelectedEnchante then
		local _, onThis = ESell_Enchante_getInfoBonus(listIdSelectedEnchante);
		if onThis ~= EnchanteSortArmor then
			listIdSelectedEnchante = nil;
		end
	end
	if listIdSelectedEnchante then EnchantNameSelect = ESell_Enchante_getInfoDetail(listIdSelectedEnchante); end

	ESell_EnchanteSort(nameArgSort);

	if EnchantNameSelect then listIdSelectedEnchante = ESell_Enchante_getId(EnchantNameSelect); end
	EnchantingSell_Enchante_Frame_OnUpdate();
--	SelectIdEnchante(listIdSelectedEnchante);
end

function UpDateListeEnchante()
	local enchantorSelected;
	if EnchantingSell_Config then
		enchantorSelected = EnchantingSell_Config.EnchantorPlayerSelected;
	end
	if enchantorSelected then
		EnchantingSell_NameEnchantorSelected_Name:SetText("[ "..enchantorSelected[1]..ENCHANTINGSELL_OPTION_ENCHANTING_FORJOINTPLAYERANDSERVER_OF..enchantorSelected[2].." ]");
	else
		EnchantingSell_NameEnchantorSelected_Name:SetText("");
	end
	if ESell_Player_IsEq(enchantorSelected, EnchantingSell_CourantPlayer) then
		EnchantingSell_NameEnchantorSelected_Name:SetTextColor(0.85, 0.85, 0.85);
	else
		EnchantingSell_NameEnchantorSelected_Name:SetTextColor(0.90, 0.60, 0.60);
	end


	local index=0, completeBonus;

	if (ESell_Enchante_getNb() == 0) then 
		EnchantingSell_Enchante_ScrollFrame_Children:Hide();
		return; 
	end
	EnchantingSell_Enchante_ScrollFrame_Children:Show();

	local nbShow = 0;
	if EnchanteSortArmor then
		for i=1, ESell_Enchante_getNb(), 1 do
			local _, onThis = ESell_Enchante_getInfoBonus(i);
			if (EnchanteSortArmor == onThis) then nbShow = nbShow + 1; end
		end
	else
		nbShow = ESell_Enchante_getNb();
	end
	
	FauxScrollFrame_Update(EnchantingSell_Enchante_ScrollFrame, nbShow, ENCHANTINGSELL_NUM_LINE_ENCHANTES, ENCHANTINGSELL_NUM_LINE_ENCHANTES);
	for i=1, ENCHANTINGSELL_NUM_LINE_ENCHANTES, 1 do
		if FauxScrollFrame_GetOffset(EnchantingSell_Enchante_ScrollFrame) == nil then
			index = i;
		else
			index = i + FauxScrollFrame_GetOffset(EnchantingSell_Enchante_ScrollFrame);
		end

		if index == listIdSelectedEnchante then
			getglobal("EnchantingSell_Enchante_List"..i):LockHighlight();
		else
			getglobal("EnchantingSell_Enchante_List"..i):UnlockHighlight();
		end

		local name, onThis, bonusType, bonusAdd, Link = ESell_Enchante_getInfoBonus(index);
		if (name) and (index <= nbShow) then
			getglobal("EnchantingSell_Enchante_List"..i.."_Name"):SetText(name);
			getglobal("EnchantingSell_Enchante_List"..i.."_OnThis"):SetText(onThis);
			
			getglobal("EnchantingSell_Enchante_List"..i.."_MakeCount"):SetText("("..ESell_Enchante_getCountMaked(index)..")");
			 
			 
			if bonusAdd then
				completeBonus = bonusType.." +"..bonusAdd;
			else
				completeBonus = bonusType;
			end
			
			getglobal("EnchantingSell_Enchante_List"..i.."_Bonus"):SetText(completeBonus);	

			local price, goodPrice = ESell_Enchante_getPrice(index);

			if goodPrice == -1 then price = 0 end
			ESell_Money_SetPrice(price, "EnchantingSell_Enchante_List"..i.."_Price");	
	
			local color = TEXTECOLOR[ESell_Enchante_getEtat(index)];
			if not color then color = {0.80, 0.80, 0.80} end
			getglobal("EnchantingSell_Enchante_List"..i.."_MakeCount"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Enchante_List"..i.."_Name"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Enchante_List"..i.."_OnThis"):SetTextColor(color[1], color[2], color[3]);		
			getglobal("EnchantingSell_Enchante_List"..i.."_Bonus"):SetTextColor(color[1], color[2], color[3]);	
--			getglobal("EnchantingSell_Enchante_List"..i.."_Price"):SetTextColor(color[1], color[2], color[3]);

			local chatText=Link;

			if EnchantingSell_PlayerConfig.EnchanteChatPrice and price and price ~= 0 then
				chatText = ("{ "..chatText..ENCHANTINGSELL_ENCHANTE_TOOLTIP_SEPARATORFORPRICE..ESell_Money_getStringFormatWithGSC(price).." }");
			end
			
			getglobal("EnchantingSell_Enchante_List"..i).ChatTextForAdd = chatText;
			
			getglobal("EnchantingSell_Enchante_List"..i):Show();
		else
			getglobal("EnchantingSell_Enchante_List"..i):Hide();			
		end
	end
end

function UpDate_Enchante_ListeDetail()
	if (not listIdSelectedEnchante) then 
		EnchantingSell_Enchante_DetailFrame:Hide();
		EnchantingSell_Enchante_DetailFrameNew:Hide();
		EnchantingSell_Enchante_DetailFrameScrollFrame:Hide();
		EnchantingSell_CraftCreateButton:Disable();
		return; 
	end

	-- need to deal with header chants when using SortEnchant, their id is going to be 0
	if (listIdSelectedEnchante < 1) then
		return;
	end

	local nbReagents = ESell_Enchante_getNumReagent(listIdSelectedEnchante);

	local enchanteLongName, enchanteIcon, enchanteDescription, enchanteRequired, enchanteLink = ESell_Enchante_getInfoDetail(listIdSelectedEnchante);
	local IDCraftOriginal = ESell_Enchante_getIdOriginal(listIdSelectedEnchante);

	EnchantingSell_Enchante_DetailFrame_Icone:SetNormalTexture(enchanteIcon);

	-- hitemLink used to link in chat window, link appears as of patch 1.9
	-- the link is clicked from the icon
	EnchantingSell_Enchante_DetailFrame_Icone.hitemLink = enchanteLink;

	EnchantingSell_Enchante_DetailFrame_Detail_Name:SetText(enchanteLongName);

	--incase the is no link.
	local nameOrLink;
	if enchanteLink then
		nameOrLink = enchanteLink;
	else
		nameOrLink = enchanteLongName;
	end


	-- ChatTextForAdd used to link in chat window, link appears as of patch 1.9
	-- the link is clicked from the text next to the icon.
	if (enchanteDescription) then
		EnchantingSell_Enchante_DetailFrame_Detail.ChatTextForAdd = ("{ "..nameOrLink..": "..enchanteDescription.." }");
	else
		EnchantingSell_Enchante_DetailFrame_Detail.ChatTextForAdd = ("{ "..nameOrLink.." }");
	end

	local etatRequired;
	if enchanteRequired then 
		EnchantingSell_Enchante_DetailFrame_Detail_OutilNeededHeader:Show();
		etatRequired = ESell_Enchante_getRequiredEtat(listIdSelectedEnchante);
		local color = TEXTECOLOR[etatRequired];
		if not color then color = {0.80, 0.80, 0.80}; end
		EnchantingSell_Enchante_DetailFrame_Detail_OutilNeeded:SetTextColor(color[1], color[2], color[3]);
	else 
		EnchantingSell_Enchante_DetailFrame_Detail_OutilNeededHeader:Hide();
	end
	
	local needed = "";
	if ESell_Enchante_getEtat(listIdSelectedEnchante) == -2 then
		EnchantingSell_Enchante_DetailFrame_Detail_OutilNeededHeader:Show();
		local color = TEXTECOLOR[-2];
		EnchantingSell_Enchante_DetailFrame_Detail_OutilNeeded:SetTextColor(color[1], color[2], color[3]);
		needed = ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNOKNOW.." \n\r";
	end
	if enchanteRequired then
		needed = needed..enchanteRequired;
	end
	if etatRequired == 2 then
		needed = needed.." "..ENCHANTINGSELL_ENCHANTE_DETAIL_TOOLNEEDED_ADDNAMEFORINBANK;
	end
	EnchantingSell_Enchante_DetailFrame_Detail_OutilNeeded:SetText(needed);

	local cMakeBag, cMakeBank, cMakeRR;
	cMakeBag, cMakeBank, cMakeRR = ESell_Enchante_getCountMaked(listIdSelectedEnchante);
	EnchantingSell_Enchante_DetailFrame_Detail_CountMaked:SetText("|cff4cff4c("..cMakeBag..") ".."|cff7fb34c("..cMakeBank..") ".."|cffb37f4c("..cMakeRR..")");

	EnchantingSell_Enchante_DetailFrame_Detail_Description:SetText(enchanteDescription);

	local AllListReagentChatText = "[ ";
	for i=1,ENCHANTINGSELL_NUM_LINE_REAGENTS,1 do
		if i > nbReagents then
			getglobal("EnchantingSell_Enchante_Reagents_List"..i):Hide();
		else
			EnchantingSell_Enchante_Reagents_ListHeader:Show();
			
			local reagentCount, reagentName = ESell_Enchante_getInfoReagent(listIdSelectedEnchante, i);
			local idReagent = ESell_Reagent_getId(reagentName);

			local reagentCountBag, reagentCountBank, reagentCountReroll = ESell_Reagent_getCount(idReagent, EnchantingSell_Config.EnchantorPlayerSelected);
			if not reagentCountBag then reagentCountBag=0; reagentCountBank=0; reagentCountReroll=0; end

			local _, reagentIcone, _, reagentLink = ESell_Reagent_getInfo(idReagent);
--~ 			if not reagentName then reagentName=0; reagentIcone=0; end

			local reagentPriceUnite = ESell_Reagent_getPrice(idReagent);
			if not reagentPriceUnite then reagentPriceUnite = 0 end
			
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Icone"):SetTexture(reagentIcone);
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Name"):SetText(reagentName);
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Nb"):SetText(reagentCountBag.."/"..reagentCount);	
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_NbOther"):SetText(reagentCountBank.."-"..reagentCountReroll);	
			
			local color = TEXTECOLOR[ESell_Enchante_getReagentEtat(listIdSelectedEnchante,i)];
			if not color then color = {0.80, 0.80, 0.80} end
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Nb"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_NbOther"):SetTextColor(color[1], color[2], color[3]);
			if not reagentIcone then
				getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Name"):SetTextColor(color[1], color[2], color[3]);
			else
				getglobal("EnchantingSell_Enchante_Reagents_List"..i.."_Name"):SetTextColor(0.80, 0.80, 0.80);			
			end

			ESell_Money_SetPrice(reagentPriceUnite, "EnchantingSell_Enchante_Reagents_List"..i.."_PriceUnite");	
			ESell_Money_SetPrice(reagentPriceUnite*reagentCount, "EnchantingSell_Enchante_Reagents_List"..i.."_PriceTotal");
			
			local chatTextTemp = "";
			if not reagentLink then
				chatTextTemp = ("{ "..reagentCount.."x "..reagentName.." }");
			else
				chatTextTemp = ("{ "..reagentCount.."x "..reagentLink.." }");
			end
			AllListReagentChatText = AllListReagentChatText..chatTextTemp;
			getglobal("EnchantingSell_Enchante_Reagents_List"..i).ChatTextForAdd = chatTextTemp;
			
			getglobal("EnchantingSell_Enchante_Reagents_List"..i):Show();
		end
	end
	AllListReagentChatText = AllListReagentChatText.." ]";
	EnchantingSell_Enchante_Reagents_ListHeader.ChatTextForAdd = AllListReagentChatText;
	
	EnchantingSell_Enchante_MoneyFrame:Show();
	
	local price, goodPrice, priceNoBenef = ESell_Enchante_getPrice(listIdSelectedEnchante);
	local color;
	if price then
		MoneyFrame_Update("EnchantingSell_Enchante_MoneyFrame", price);
	else
		MoneyFrame_Update("EnchantingSell_Enchante_MoneyFrame", 0);		
	end
	if goodPrice == -1 then
		EnchantingSell_Enchante_TotalPriceNotBenefFrame:Hide();
		color = TEXTECOLOR[4];
	else
		ESell_Money_SetPrice(priceNoBenef, "EnchantingSell_Enchante_TotalPriceNotBenefFrame_Price");	
		EnchantingSell_Enchante_TotalPriceNotBenefFrame:Show();
		if goodPrice == 1 then
			color = TEXTECOLOR[-1];
		else
			color = TEXTECOLOR[1];
		end
	end
	SetMoneyFrameColor("EnchantingSell_Enchante_MoneyFrame", color[1], color[2], color[3]);

	-- Update the scroll frame
	EnchantingSell_Enchante_DetailFrameScrollFrame:UpdateScrollChildRect();
	-- Show or hide scrollbar
	if ((EnchantingSell_Enchante_DetailFrameScrollFrameScrollBarScrollUpButton:IsEnabled() == 0) and (EnchantingSell_Enchante_DetailFrameScrollFrameScrollBarScrollDownButton:IsEnabled() == 0) ) then
		EnchantingSell_Enchante_DetailFrameScrollFrameScrollBar:Hide();
		EnchantingSell_Enchante_DetailFrameScrollFrameTop:Hide();
		EnchantingSell_Enchante_DetailFrameScrollFrameBottom:Hide();
	else
		EnchantingSell_Enchante_DetailFrameScrollFrameScrollBar:Show();
		EnchantingSell_Enchante_DetailFrameScrollFrameTop:Show();
		EnchantingSell_Enchante_DetailFrameScrollFrameBottom:Show();
	end

	EnchantingSell_Enchante_DetailFrameNew:Show();
	EnchantingSell_Enchante_DetailFrame:Show();
	EnchantingSell_Enchante_DetailFrameScrollFrame:Show();

end

function ESell_UpdateEnchantButton()
	if (EnchantingSell_Enchante_Frame:IsShown() and ESell_currentEnchantSelected~=nil) then
		if (EnchantingSell_Config.EnchantePlayerName == EnchantingSell_CourantPlayerName) then
			--Etat will be 1 if you can do the chant with items in bags
			if ESell_Enchante_getEtat(ESell_currentEnchantSelected) == 1 then
				EnchantingSell_CraftCreateButton:Enable();
			else
				EnchantingSell_CraftCreateButton:Disable();
			end
		end
	end
end

function EnchantingSell_Enchante_List_OnClick()
	if FauxScrollFrame_GetOffset(EnchantingSell_Enchante_ScrollFrame) then
		listIdSelectedEnchante = this:GetID() + FauxScrollFrame_GetOffset(EnchantingSell_Enchante_ScrollFrame);
	else
		listIdSelectedEnchante = this:GetID();
	end
	--store the selected value for updating the EnchantButton later on
	ESell_currentEnchantSelected=listIdSelectedEnchante;
	
	EnchantingSell_Enchante_Frame_OnUpdate();

	if (EnchantingSell_Config.EnchantePlayerName == EnchantingSell_CourantPlayerName) then
		if ESell_Enchante_getEtat(listIdSelectedEnchante) == 1 then
			EnchantingSell_CraftCreateButton:Enable();
		else
			EnchantingSell_CraftCreateButton:Disable();
		end
--removed code that does not work with SortEnchant enabled.
--		if (CraftFrame:IsShown()) and (GetCraftName()  == NAME_SPELL_CRAFT_ENCHANTE) then
--				CraftFrame_SetSelection(ESell_Enchante_getIdOriginal(listIdSelectedEnchante));
--				CraftFrame_Update();
--		end
--removed code that does not work with SortEnchant enabled.
	end
end

function EnchantingSell_Enchante_Price_DoubleClic()
	if not listIdSelectedEnchante then return end

	ESell_ChangeEnchantePrice_LaunchFrame(listIdSelectedEnchante)
end

function EnchantingSell_DoCraft()
	local isEnchanteur = ESell_LaunchFunctionInCraftSpellFrame(
		function () 
			if (EnchantingSell_Config.EnchantePlayerName == EnchantingSell_CourantPlayerName) then
				local idEnchantement = ESell_Enchante_getIdOriginal(listIdSelectedEnchante);
				local enchanteLongName = ESell_Enchante_getInfoDetail(listIdSelectedEnchante)
				local name, onThis, bonusType, bonusAdd = ESell_Enchante_getInfoBonus(listIdSelectedEnchante);

--				DEFAULT_CHAT_FRAME:AddMessage("listIdSelectedEnchante is ".. isNullOrValue(listIdSelectedEnchante));
--				DEFAULT_CHAT_FRAME:AddMessage("idEnchantement is ".. isNullOrValue(idEnchantement));
--				DEFAULT_CHAT_FRAME:AddMessage("enchanteLongName is ".. isNullOrValue(enchanteLongName));
--				DEFAULT_CHAT_FRAME:AddMessage("GetCraftInfo(idEnchantement) is ".. isNullOrValue(GetCraftInfo(idEnchantement)));
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
					DEFAULT_CHAT_FRAME:AddMessage(enchanteLongName..completeBonus.." sur ...", 0.45, 1, 0.45);
				else
					DEFAULT_CHAT_FRAME:AddMessage("There was a problem performing this enchant. Please reselect the enchant you would like to perform and try again.");
				end
			else
				DEFAULT_CHAT_FRAME:AddMessage("You cannot perform this action while viewing another characters enchants.");
			end
		end
	);
	if not isEnchanteur then
		DEFAULT_CHAT_FRAME:AddMessage("You cannot perform this action.  This character is not an enchanter.");
	end
end

function ESell_Option_DropDownArmor_Initialize()
	DebugMessage("Entering ESell_Option_DropDownArmor_Initialize");
	
	if not EnchantingSell_ArmorCarac.All then EnchantingSell_ArmorCarac.All ="All" end

	--sets the text that is shown in the drop down.
	if EnchanteSortArmor then
		UIDropDownMenu_SetText(EnchanteSortArmor, EnchantingSell_DropDownArmor);
	else
		UIDropDownMenu_SetText(EnchantingSell_ArmorCarac.All, EnchantingSell_DropDownArmor);
	end

	ES_dropDownInfo = {};

	--set the first button added to All
	ES_dropDownInfo.text = EnchantingSell_ArmorCarac.All;
	ES_dropDownInfo.value = EnchantingSell_ArmorCarac.All;
	ES_dropDownInfo.checked = nil;
	ES_dropDownInfo.func = ESell_Option_DropDownArmor_OnClick;
	ES_dropDownInfo.disabled = nil;
	ES_dropDownInfo.textR = 1;
	ES_dropDownInfo.textG = 1;
	ES_dropDownInfo.textB = 1;
	ES_dropDownInfo.hasColorSwatch = nil;  --added since the color swatches were being displayed randomly. appears info is global variable, so we may need to reset other variables.
	ES_dropDownInfo.notClickable = nil;

	UIDropDownMenu_AddButton(ES_dropDownInfo);
	
	--then create and add all the other buttons for the other armor
	for i, armor in ipairs(EnchantingSell_ArmorCarac) do
		ES_dropDownInfo.text = armor[2];
		ES_dropDownInfo.value = armor[2];
		ES_dropDownInfo.checked = nil;
		ES_dropDownInfo.hasColorSwatch = nil;  --added since the color swatches were being displayed randomly. appears info is global variable, so we may need to reset other variables.
		ES_dropDownInfo.func = ESell_Option_DropDownArmor_OnClick;
		ES_dropDownInfo.disabled = nil;
		ES_dropDownInfo.textR = 1;
		ES_dropDownInfo.textG = 1;
		ES_dropDownInfo.textB = 1;
		ES_dropDownInfo.notClickable = nil;
		
		UIDropDownMenu_AddButton(ES_dropDownInfo);
	end
end
function ESell_Option_DropDownArmor_OnClick()
	if this.value == EnchantingSell_ArmorCarac.All then
		EnchanteSortArmor = nil;
	else
		EnchanteSortArmor = this.value;
	end
	UIDropDownMenu_SetText(this.value, EnchantingSell_DropDownArmor);
	SortEnchante();
	EnchantingSell_Enchante_Frame_OnUpdate();
end

