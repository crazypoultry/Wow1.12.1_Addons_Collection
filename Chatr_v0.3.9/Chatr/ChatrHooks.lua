Chatr_HookNames={
-- Blizzard
	"ContainerFrameItemButton_OnClick",
	"PaperDollItemSlotButton_OnClick",
	"BankFrameItemButtonGeneric_OnClick",
	"SetItemRef",
	"QuestLogTitleButton_OnClick",
-- External addons
	"EngInventory_ItemButton_OnClick",
	"AllInOneInventoryFrameItemButton_OnClick",
	"EDB_Frame_Enchant_EnchantListEntry_OnClick",
	"BagnonItem_OnClick",
-- Other stuff
	"FriendsFrame_OnEvent",	
};

Chatr_HookedFuncs={};
Chatr_TradeSkillHooked=nil;
Chatr_OldTradeSkillSkillIconOnClick=nil;
Chatr_OldTradeSkillReagentOnClick=nil;
Chatr_CraftHooked=nil;
Chatr_OldCraftIconOnClick=nil;
Chatr_OldCraftReagentOnClick=nil;
Chatr_AuctionHooked=nil;

function Chatr_ContainerFrameItemButton_OnClick(button, igm)
	if Chatr_EditFocus~=nil and (IsShiftKeyDown() and not igm) then
		Chatr_EditFocus:Insert(GetContainerItemLink(this:GetParent():GetID(),this:GetID()));
		return
	end
	Chatr_HookedFuncs["ContainerFrameItemButton_OnClick"](button,igm)
end
function Chatr_PaperDollItemSlotButton_OnClick(button, igm)
	if Chatr_EditFocus~=nil and (IsShiftKeyDown() and not igm) then
		Chatr_EditFocus:Insert(GetInventoryItemLink("player", this:GetID()));
		return
	end
	Chatr_HookedFuncs["PaperDollItemSlotButton_OnClick"](button,igm)
end
function Chatr_BankFrameItemButtonGeneric_OnClick(button)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(GetContainerItemLink(BANK_CONTAINER, this:GetID()));
		return
	end
	Chatr_HookedFuncs["BankFrameItemButtonGeneric_OnClick"](button)
end

function Chatr_SetItemRef(arg1,arg2,arg3)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(arg2);
		return;
	end
	Chatr_HookedFuncs["SetItemRef"](arg1,arg2,arg3)
end

function Chatr_QuestLogTitleButton_OnClick(button)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(gsub(this:GetText(), " *(.*)", "%1"));
		return
	end
	Chatr_HookedFuncs["QuestLogTitleButton_OnClick"](button)
end

function Chatr_FriendsFrame_OnEvent()
	if event == "WHO_LIST_UPDATE" and Chatr_Whoed==1 and not FriendsFrame:IsShown() then return; end
	Chatr_HookedFuncs["FriendsFrame_OnEvent"]()
end

function Chatr_EngInventory_ItemButton_OnClick(button, ignoreShift)
	local bar,position,bagnum,slotnum,itm;
	if Chatr_EditFocus~=nil then
		if EngInventory_buttons[this:GetName()] then
			bar = EngInventory_buttons[this:GetName()]["bar"];
			position = EngInventory_buttons[this:GetName()]["position"];
			bagnum = EngInventory_bar_positions[bar][position]["bagnum"];
			slotnum = EngInventory_bar_positions[bar][position]["slotnum"];
			itm = EngInventory_item_cache[bagnum][slotnum];
			if itm then
				if IsShiftKeyDown() then
					Chatr_EditFocus:Insert(GetContainerItemLink(itm["bagnum"], itm["slotnum"]));
					return;
				end
			end
		end

	end
	Chatr_HookedFuncs["EngInventory_ItemButton_OnClick"](button,ignoreShift);
end

function Chatr_AllInOneInventoryFrameItemButton_OnClick(button, ignoreShift)
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		local bag, slot = AllInOneInventory_GetIdAsBagSlot(this:GetID());
		Chatr_EditFocus:Insert(GetContainerItemLink(bag, slot));
		return;
	end
	Chatr_HookedFuncs["AllInOneInventoryFrameItemButton_OnClick"](button,ignoreShift);
end

function Chatr_EDB_Frame_Enchant_EnchantListEntry_OnClick()
	EDB_Frame_Enchant_EnchantList_SetSelection(this:GetID());
	local link;

	if Chatr_EditFocus~=nil then
		if IsShiftKeyDown() then
			link = EDB_Formula_GetEnchantLink(EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula);
		end
		if IsControlKeyDown() then
			link = "";
			for r in EDB_Frame_Enchant.reagentList do
				link = link..EDB_Frame_Enchant.reagentList[r].qReq.."x"..EDB_Reagent[EDB_Frame_Enchant.reagentList[r].id].." ";
			end
		end
		if IsAltKeyDown() then link = EDB_Formula[EDB_Frame_Enchant.enchantList[EDB_Frame_Enchant.selection].formula].itemLink; end

		if link then
			Chatr_EditFocus:Insert(link);
			return;
		end
	end
	Chatr_HookedFuncs["EDB_Frame_Enchant_EnchantListEntry_OnClick"]()
end


function Chatr_CraftIconOnClick()
	if IsShiftKeyDown() and Chatr_EditFocus then
		Chatr_EditFocus:Insert(GetCraftItemLink(GetCraftSelectionIndex()));
		return;
	end
	Chatr_OldCraftIconOnClick();
end

function Chatr_CraftReagentOnClick()
	if IsShiftKeyDown() and Chatr_EditFocus then
		Chatr_EditFocus:Insert(GetCraftReagentItemLink(GetCraftSelectionIndex(), this:GetID()));
	end	
	Chatr_OldCraftReagentOnClick()
end

function Chatr_TradeSkillSkillIconOnClick()
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(GetTradeSkillItemLink(TradeSkillFrame.selectedSkill));
		return;
	end
	Chatr_OldTradeSkillSkillIconOnClick();
end

function Chatr_TradeSkillReagentOnClick()
	if Chatr_EditFocus~=nil and IsShiftKeyDown() then
		Chatr_EditFocus:Insert(GetTradeSkillReagentItemLink(TradeSkillFrame.selectedSkill, this:GetID()));
		return;
	end
	Chatr_OldTradeSkillReagentOnClick();
end

function Chatr_AuctionItemOnClick()
	if IsControlKeyDown() then
		DressUpItemLink(GetAuctionItemLink("list", this:GetParent():GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)));
	elseif IsShiftKeyDown() then
		if ChatFrameEditBox:IsVisible() then
			ChatFrameEditBox:Insert(GetAuctionItemLink("list", this:GetParent():GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)));
		elseif Chatr_EditFocus~=nil then
			Chatr_EditFocus:Insert(GetAuctionItemLink("list", this:GetParent():GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)));
		end
	else
		if AUCTION_DISPLAY_ON_CHARACTER == "1" then
			DressUpItemLink(GetAuctionItemLink("list", this:GetParent():GetID() + FauxScrollFrame_GetOffset(BrowseScrollFrame)));
		end
		BrowseButton_OnClick(this:GetParent());
	end
end

function Chatr_BagnonItem_OnClick(mouseButton, ignoreModifiers)
	if ( this.isLink ) then
		if(this.hasItem) then
			if ( mouseButton == "LeftButton" ) then
				if ( IsControlKeyDown() ) then
					local itemSlot = this:GetID(); 
					local bagID = this:GetParent():GetID();
					local player = this:GetParent():GetParent().player;
					
					DressUpItemLink( (BagnonDB.GetItemData(player, bagID, itemSlot)) );
				elseif( IsShiftKeyDown() ) then
					local itemSlot = this:GetID(); 
					local bagID = this:GetParent():GetID();
					local player = this:GetParent():GetParent().player;
					if Chatr_EditFocus~=nil then
						Chatr_EditFocus:Insert( BagnonDB.GetItemHyperlink(player, bagID, itemSlot) );
					else
						ChatFrameEditBox:Insert( BagnonDB.GetItemHyperlink(player, bagID, itemSlot) );
					end
				end
			end
		end
	else
		ContainerFrameItemButton_OnClick(mouseButton, ignoreModifiers);
	end
end

function Chatr_HookTradeSkill()
	local i,z;
	if TradeSkillSkillIcon and not Chatr_TradeSkillHooked then
		Chatr_Debug("Hooking tradeskills...");
		Chatr_TradeSkillHooked=true;
		Chatr_OldTradeSkillSkillIconOnClick=TradeSkillSkillIcon:GetScript("OnClick");
		TradeSkillSkillIcon:SetScript("OnClick",Chatr_TradeSkillSkillIconOnClick);
		i=1;
		while 1 do
			Chatr_Debug("Hooking tradeskill reagent button "..i);
			z=getglobal("TradeSkillReagent"..i);
			if z==nil then break; end
			Chatr_OldTradeSkillReagentOnClick=z:GetScript("OnClick");
			z:SetScript("OnClick",Chatr_TradeSkillReagentOnClick);
			i=i+1;
		end
		Chatr_Debug("Done... trade all hooked up!");
	end
	if CraftIcon and not Chatr_CraftHooked then
		Chatr_Debug("Hooking crafts...");
		Chatr_CraftHooked=true;
		Chatr_OldCraftIconOnClick=CraftIcon:GetScript("OnClick");
		CraftIcon:SetScript("OnClick",Chatr_CraftIconOnClick);
		i=1;
		while 1 do
			Chatr_Debug("Hooking craft reagent button "..i);
			z=getglobal("CraftReagent"..i);
			if z==nil then break; end
			Chatr_OldCraftReagentOnClick=z:GetScript("OnClick");
			z:SetScript("OnClick",Chatr_CraftReagentOnClick);
			i=i+1;
		end
		Chatr_Debug("Done... craft all hooked up!");
	end
	
	if AuctionFrame and not Chatr_AuctionHooked then
		Chatr_Debug("Hooking auction...");
		i=1;
		z=getglobal("BrowseButton1Item");
		while z~=nil do
			Chatr_Debug("Hooking auction button "..i);
			z:SetScript("OnClick",Craft_AuctionItemOnClick);
			i=i+1;
			z=getglobal("BrowseButton"..i.."Item");
		end
		Chatr_Debug("Auction hooked");
	end
end


function Chatr_ApplyHooks()
	for _,k in Chatr_HookNames do
		if Chatr_HookedFuncs[k]==nil then
			of=getglobal(k);
			nf=getglobal("Chatr_"..k);

			if of==nil then
				Chatr_Debug("Hooked function "..k.." does not exist");
			elseif nf==nil then
				Chatr_Print("Hook function replacement for "..k.." does not exist");
			else
				Chatr_HookedFuncs[k]=of;
				setglobal(k,nf);
				Chatr_Debug("Hooked "..k);
			end
		else
			Chatr_Debug("Function "..k.." is hooked already by Chatr.");
		end
	end
	Chatr_HookTradeSkill();
end