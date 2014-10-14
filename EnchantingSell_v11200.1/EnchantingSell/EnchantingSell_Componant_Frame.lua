local listIdSelectedComponant;
local ColumsSort ={Colums = 1, SortUp = true};
local TableTempListCountByPlayer = {};

ENCHANTINGSELL_NUM_LINE_COMPONANTS = 11;
ENCHANTINGSELL_NUM_LINE_DETAIL_BYPLAYER_COMPONANTS = 4;

function EnchantingSell_Componant_Frame_OnShow()
	SortComponant();
end

function EnchantingSell_Componant_Frame_OnUpdate()
	UpDateListeComponant();
	UpDate_Componant_ListeDetail();
end

function SelectIdComponant(id)
	listIdSelectedComponant = id;
--	FauxScrollFrame_SetOffset(EnchantingSell_Componant_ScrollFrame, id-1);
	if id then EnchantingSell_Componant_ScrollFrameScrollBar:SetValue((id-1)*ENCHANTINGSELL_NUM_LINE_COMPONANTS); end
--	EnchantingSell_Componant_ScrollFrame:SetVerticalScroll((id-1)*ENCHANTINGSELL_NUM_LINE_COMPONANTS);
	EnchantingSell_Componant_Frame_OnUpdate();
end

function UpDateListeComponant()
	if (not EnchantingSell_ListComponant) then
		EnchantingSell_Componant_ScrollFrame_Children:Hide();
		return; 
	end
	EnchantingSell_Componant_ScrollFrame_Children:Show();
	
--~ 	local nbshowtmp;
--~ 	if ESell_Reagent_getNb() <= ENCHANTINGSELL_NUM_LINE_COMPONANTS then
--~ 		nbshowtmp = ENCHANTINGSELL_NUM_LINE_COMPONANTS + 1;
--~ 	else
--~ 		nbshowtmp = ESell_Reagent_getNb();
--~ 	end
	FauxScrollFrame_Update(EnchantingSell_Componant_ScrollFrame, ESell_Reagent_getNb(), ENCHANTINGSELL_NUM_LINE_COMPONANTS, ENCHANTINGSELL_NUM_LINE_COMPONANTS);
	for i=1, ENCHANTINGSELL_NUM_LINE_COMPONANTS, 1 do
		local index;
		if (not FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame)) then
			index = i;
		else
			index = i + FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame);
		end

		if index == listIdSelectedComponant then
			getglobal("EnchantingSell_Componant_List"..i):LockHighlight();
		else
			getglobal("EnchantingSell_Componant_List"..i):UnlockHighlight();
		end

		if (EnchantingSell_ListComponant[index]) then
			local reagentCountBag, reagentCountBank, reagentCountReroll = ESell_Reagent_getCount(index, EnchantingSell_CourantPlayerName);
			local reagentName, reagentIcone = ESell_Reagent_getInfo(index);
			local reagentPriceUnite = ESell_Reagent_getPrice(index);

			getglobal("EnchantingSell_Componant_List"..i.."_Icone"):SetTexture(reagentIcone);
			getglobal("EnchantingSell_Componant_List"..i.."_Name"):SetText(reagentName);
			getglobal("EnchantingSell_Componant_List"..i.."_Nb"):SetText(reagentCountBag);
			getglobal("EnchantingSell_Componant_List"..i.."_NbBank"):SetText(reagentCountBank);
			getglobal("EnchantingSell_Componant_List"..i.."_NbReroll"):SetText(reagentCountReroll);

			ESell_Money_SetPrice(reagentPriceUnite, "EnchantingSell_Componant_List"..i.."_PriceUnite");

			local color;
			if ESell_Reagent_getUsed(index) then
				color = {0.90, 0.90, 0.90};
			else
				color = TEXTECOLOR[-2];				
			end
			getglobal("EnchantingSell_Componant_List"..i.."_Name"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Componant_List"..i.."_Nb"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Componant_List"..i.."_NbBank"):SetTextColor(color[1], color[2], color[3]);
			getglobal("EnchantingSell_Componant_List"..i.."_NbReroll"):SetTextColor(color[1], color[2], color[3]);

			getglobal("EnchantingSell_Componant_List"..i):Show();
		else
			getglobal("EnchantingSell_Componant_List"..i):Hide();			
		end
	end
end

function SortComponant(Colums)
	local nameComponantSelected;

	if (not ESell_Reagent_getNb()) or not EnchantingSell_ListComponant then
		return;
	end

	if listIdSelectedComponant then	nameComponantSelected = ESell_Reagent_getInfo(listIdSelectedComponant) end
	if (Colums) then
		if (ColumsSort.Colums == Colums) then
			ColumsSort.SortUp = not ColumsSort.SortUp;
		else
			ColumsSort.Colums = Colums;
		end
	end
	
	table.sort(EnchantingSell_ListComponant, SortComponant_Sort);
	
	if nameComponantSelected then listIdSelectedComponant = ESell_Reagent_getId(nameComponantSelected) end
--	SelectIdComponant(id);
	EnchantingSell_Componant_Frame_OnUpdate();
end

function SortComponant_Sort(e1,e2)
	local value1, value2;
	local nbInBag1, nbInBank1, nbInReroll1  = ESell_Reagent_getCountWhithTable(e1["ByPlayer"], EnchantingSell_CourantPlayerName);
	local nbInBag2, nbInBank2, nbInReroll2  = ESell_Reagent_getCountWhithTable(e2["ByPlayer"], EnchantingSell_CourantPlayerName);

	if ColumsSort.Colums == 1 then
		value1 = e1.Name;
		value2 = e2.Name;
	end if ColumsSort.Colums == 2 then
		value1 = nbInBag1;
		value2 = nbInBag2;
	end if ColumsSort.Colums == 3 then
		value1 = nbInBank1;
		value2 = nbInBank2;
	end if ColumsSort.Colums == 4 then
		value1 = nbInReroll1;
		value2 = nbInReroll2;
	end if ColumsSort.Colums == 5 then
		value1 = e1.PriceUnite;
		value2 = e2.PriceUnite;
	end 

	if e1["IsUse"] ~= e2["IsUse"] then
		if not e1["IsUse"] then return false end
		if not e2["IsUse"] then return true end
	end
	if (value1 == nil) or (value1=="") or (value1==0) then
		return false;		
	end if (value2 == nil) or (value2=="") or (value2==0) then
		return true;		
	end 
	if ColumsSort.SortUp then
		if (value1 < value2 )then
			return true;		
		else
			return false;
		end
	else
		if (value1 > value2 )then
			return true;		
		else
			return false;
		end	
	end
end

function EnchantingSell_Componant_List_OnClick()
	if FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame) then
		listIdSelectedComponant = this:GetID() + FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame);
	else
		listIdSelectedComponant = this:GetID();
	end
	EnchantingSell_Componant_Frame_OnUpdate();
end

function UpDate_Componant_ListeDetail()
	if not listIdSelectedComponant then 
		EnchantingSell_Componant_DetailFrame:Hide();
		return; 
	end
	EnchantingSell_Componant_DetailFrame:Show();
	
	local player = ESell_Reagent_getPlayerListSave(listIdSelectedComponant);
	FauxScrollFrame_Update(EnchantingSell_Componant_DetailFrame_ScrollFrame,table.getn(player),ENCHANTINGSELL_NUM_LINE_DETAIL_BYPLAYER_COMPONANTS, ENCHANTINGSELL_NUM_LINE_DETAIL_BYPLAYER_COMPONANTS);
	EnchantingSell_Componant_DetailFrame_ScrollFrame:Show();
	--	local indexShow;
	local TableTempListCountByPlayer = {};
	table.foreachi(player,
		function (i, namePlayer)
--			DEFAULT_CHAT_FRAME:AddMessage(i.." "..namePlayer);
			local nbInBag, nbInBank, nbInReroll  = ESell_Reagent_getCountWhithTable(EnchantingSell_ListComponant[listIdSelectedComponant]["ByPlayer"], namePlayer);
			if namePlayer == EnchantingSell_CourantPlayer[1] then
				tinsert(TableTempListCountByPlayer, 1 ,{namePlayer, nbInBag, nbInBank, nbInReroll})
			else
				tinsert(TableTempListCountByPlayer, {namePlayer, nbInBag, nbInBank, nbInReroll})				
			end
		end
	);
	for i=1, ENCHANTINGSELL_NUM_LINE_DETAIL_BYPLAYER_COMPONANTS, 1 do
		local index = 0;
		if (not FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame)) then
			index = i;
		else
			index = i + FauxScrollFrame_GetOffset(EnchantingSell_Componant_ScrollFrame);
		end
		if (TableTempListCountByPlayer[i]) then
			
			getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i.."_Name"):SetText(TableTempListCountByPlayer[i][1]);
			getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i.."_NbBag"):SetText(TableTempListCountByPlayer[i][2]);
			getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i.."_NbBank"):SetText(TableTempListCountByPlayer[i][3]);
			getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i):Show();
		else
			getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i):Hide();
		end
	end
---	for i=indexShow,5,1 do
--		getglobal("EnchantingSell_Componant_Detail_ByPlayer_List"..i):Hide;
--	end
	if ((listIdSelectedComponant) and (listIdSelectedComponant ~= 0)) then
		local reagentName, reagentIcone, reagentDescription = ESell_Reagent_getInfo(listIdSelectedComponant);
		EnchantingSell_Componant_DetailFrame_Info_Name:SetText(reagentName);
		EnchantingSell_Componant_DetailFrame_Info_Icone:SetTexture(reagentIcone);
		EnchantingSell_Componant_DetailFrame_Info_Description:SetText(reagentDescription);
		local reagentPrice = ESell_Reagent_getPrice(listIdSelectedComponant);
		EnchantingSell_Componant_Detail_PriceUnite_EditBoxGold:SetNumber(ESell_Money_getMoney("Gold", reagentPrice));
		EnchantingSell_Componant_Detail_PriceUnite_EditBoxSilver:SetNumber(ESell_Money_getMoney("Silver", reagentPrice));
		EnchantingSell_Componant_Detail_PriceUnite_EditBoxCopper:SetNumber(ESell_Money_getMoney("Copper", reagentPrice));
		EnchantingSell_Componant_DetailFrame:Show();
	end
end

function EnchantingSell_OnEnterPressed_EditBox(typeMoney)
	if typeMoney ~= "Gold" then
		if ( getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..typeMoney):GetNumber() > 99 ) then
			getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..typeMoney):SetNumber(99);
		end
	end
	if ( getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..typeMoney):GetNumber() < 0 ) then
		getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..typeMoney):SetNumber(0);
	end
	ESell_Reagent_setPrice(typeMoney, getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..typeMoney):GetNumber(), listIdSelectedComponant);
	UpDateListeComponant();

	local nextTypeMoney;
	if typeMoney == "Gold" then
		nextTypeMoney = "Silver";
	end if typeMoney == "Silver" then
		nextTypeMoney = "Copper";
	end
	if nextTypeMoney then
		getglobal("EnchantingSell_Componant_Detail_PriceUnite_EditBox"..nextTypeMoney):SetFocus();
	else
		this:ClearFocus();
	end
end


--function EnchantingSell_Tooltip(TableTexte)
--	GameTooltip_SetDefaultAnchor(GameTooltip,this);
--	GameTooltip:SetText(arg1);
--	GameTooltip:AddLine(arg2, .75, .75, .75, 1);
--	GameTooltip:Show();
--end
