function _Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Debug: " .. msg);
end

function _Error(msg)
	DEFAULT_CHAT_FRAME:AddMessage("Error: " .. msg);
	UIErrorsFrame:AddMessage(msg, 1.0, 1.0, 0, 1, 3)
end

function GetItemCount(BagNum,SlotNum)
	local _, itemCount = GetContainerItemInfo(BagNum,SlotNum)
	return itemCount
end

function IsQuestItem(BagNum,SlotNum)
	local _, _, _, _, _, itemType = GetItemDataByLoc(BagNum,SlotNum)
	return (string.lower(itemType) == "quest")
end

function GetItemDataByLink(link)
	local _,_,itemId = string.find(link, "(%d+):%d+:%d+:%d+");
	if not itemId then
		return nil
	end
	local itemName, itemLink, itemRarity, itemMinLevel, itemType, itemSubType, itemMaxStack = GetItemInfo(itemId)
	if not itemName then
		return nil
	end
	if not itemMaxStack then
		itemMaxStack = 1
	end
	return itemName, itemLink, itemId, itemRarity, itemMinLevel, itemType, itemSubType, itemMaxStack
end

function GetItemDataByLoc(BagNum,SlotNum)
	local link = GetContainerItemLink(BagNum,SlotNum)	
	local _, itemCount, NotSplittable, itemQuality = GetContainerItemInfo(BagNum,SlotNum)
	if link then
		local itemName, itemLink, itemId, itemRarity, itemMinLevel, itemType, itemSubType, itemMaxStack = GetItemDataByLink(link)
		return itemName, itemLink, itemId, itemRarity, itemMinLevel, itemType, itemSubType, itemMaxStack, itemCount, NotSplittable, itemQuality
	else
		return nil
	end
end

function IsAmmoBag(BagNum) 
	if ( BagNum < 0 ) or ( BagNum > 4 ) then
		return false;
  end
  local name = "MainMenuBarBackpackButton";
  if ( BagNum > 0 ) then
		name = "CharacterBag"..(BagNum-1).."Slot";
	end
	local objCount = getglobal(name.."Count");
	if ( objCount ) and ( objCount:IsVisible() ) then
    local tmp = objCount:GetText();
		if ( ( tmp ) and ( strlen(tmp) > 0) ) then
			return true;
    end
  end
  return false;
end

function isValidBag(BagNum)
	if not BagNum then
		_Error("isValidBag: BagNum is missing!")
		return false
	end
	if not GetBagName(BagNum) then
		return false
	elseif IsAmmoBag(BagNum) then
		return false
	else
		return true
	end
end

function CursorBusy()
	return CursorHasSpell() or CursorHasItem() or CursorHasMoney()
end

function IsInTable(item,tbl)
	for i = 1 , table.getn(tbl) do
		if string.find(tbl[i],item) then
			return true
		end
	end
	return false
end

function SlotIsFree(BagNum,SlotNum)
	return not GetContainerItemInfo(BagNum,SlotNum)
end
function GetFreeSlotInBag(BagNum)
	if not BagNum then
		return nil
	end
	for SlotNum = 1,GetContainerNumSlots(BagNum) do
		if SlotIsFree(BagNum,SlotNum) then
			return SlotNum
		end
	end
	return 0
end
function FreeSlotsInBag(BagNum)
	local freeSlots = 0
	if not isValidBag(BagNum) then
		return nil
	end
	for aktSlotNum = 1,GetContainerNumSlots(BagNum) do
		if SlotIsFree(BagNum,aktSlotNum) then
			freeSlots = freeSlots + 1
		end
	end
	return freeSlots
end
function FreeSlots()
	local freeSlots = 0
	for aktBagNum = 0,4 do
		if isValidBag(aktBagNum) then
			freeSlots = freeSlots + FreeSlotsInBag(aktBagNum)
		end
	end
	return freeSlots
end

function DelFromTable(item,t)
	if t[item] then
		t[item] = nil
		return true
	end
	return false
end

function GetCmd(msg)
 	if (msg) then
 		local von,bis = string.find(msg, "[^%s]+");
 		if (not ( (von == nil) and (bis == nil) ) ) then
 			local cmd = string.lower(string.sub(msg,von,bis)) 
 			return cmd, string.sub(msg, string.find(cmd,"$")+1);
 		else	
 			return "";
 		end;
 	end;
end;

function PutItemInBagByNum(BagNum)
	if BagNum == 0 then
		return PutItemInBackpack();
	else
		return PutItemInBag( getglobal("CharacterBag"..(BagNum-1).."Slot"):GetID() );
	end
end;

function PutItemInPrefBag(prefBag)
	local BagNum;
	if not prefBag then
		prefBag = 0;
	end
	-- do we have something to drop?
	if CursorBusy() then
		if FreeSlotsInBag(prefBag) > 0 then
			PickupContainerItem(prefBag,GetFreeSlotInBag(prefBag));
			return true
		end
		for aktBagNum = 0,4 do
			if (isValidBag(aktBagNum)) then
				if FreeSlotsInBag(aktBagNum) > 0 then
					PickupContainerItem(aktBagNum,GetFreeSlotInBag(aktBagNum));
					return true
				end
			end
		end
		return false
	end
	return true
end

function RegisterEvents(EventList)
	if not EventList then
		_Error("RegisterEvents: EventList is empty!")
		return
	end
	for _,aktEvent in EventList do
		this:RegisterEvent(aktEvent)
	end
end

function UnRegisterEvents(EventList)
	if not EventList then
		_Error("UnRegisterEvents: EventList is empty!")
		return
	end
	for _,aktEvent in EventList do
		this:UnregisterEvent(aktEvent)
	end
end

function BankIsOpen()
	return getglobal("BankFrame"):IsVisible()
end

function XOR(a,b)
	return a and not b or not a and b
end

function GetItemColorbyLoc(BagNum,SlotNum)
	local link = GetContainerItemLink(BagNum,SlotNum)	
	if link then
		local _,_,color = string.find(link, "|c(%x+)|Hitem:%d+:%d+:%d+:%d+|h%[.-%]|h|r")
		return color
	else
		return nil
	end
end

function ItemValue(BagNum,SlotNum)
	local color = GetItemColorbyLoc(BagNum,SlotNum)
	local ItemValueList = {}
	ItemValueList = { ff9d9d9d = "poor" , ffffffff = "common" , ff1eff00 = "uncommon", ff0070dd = "rare", ffa335ee = "epic"}
	return (ItemValueList[color] or "")
end
