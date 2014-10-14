--GrinderCore 1.1
--Written By Tiok - US Thrall

GrinderCore_BankIsOpen = false;

GrinderCore_AltBags = {};

function GrinderCore_OnLoad()
    GrinderCore_RegisterEvents();
end

function GrinderCore_RegisterEvents()
    this:RegisterEvent("VARIABLES_LOADED");
    this:RegisterEvent("BANKFRAME_OPENED");
    this:RegisterEvent("BANKFRAME_CLOSED");
    this:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
    this:RegisterEvent("BAG_UPDATE");
end

function GrinderCore_OnEvent()
    if ( event == "VARIABLES_LOADED" ) then
        GrinderCore_Init();
    elseif( event == "BANKFRAME_OPENED" ) then
	GrinderCore_BankIsOpen = true;
	if(not(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"]))then
	    GrinderCore_CountItemsInBag(-1);
	    GrinderCore_CountItemsInBag(5);
	    GrinderCore_CountItemsInBag(6);
	    GrinderCore_CountItemsInBag(7);
	    GrinderCore_CountItemsInBag(8);
	    GrinderCore_CountItemsInBag(9);
	    GrinderCore_CountItemsInBag(10);
	    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"] = true;
	end
    elseif( event == "BANKFRAME_CLOSED" ) then
	GrinderCore_BankIsOpen = false;
    elseif( event == "BAG_UPDATE" ) then
	GrinderCore_CountItemsInBag(arg1);
    elseif( event == "PLAYERBANKSLOTS_CHANGED" ) then
	GrinderCore_CountItemsInBag(-1);	    
    end
end

function GrinderCore_Init()
    --Make sure the Settings variables exist.
    if(GrinderCore_Settings == nil)then
	GrinderCore_Settings = 
	{
	    ["Item IDs"] = {}; --Key: Item Name, Value: Item ID
	    ["Item Tracked By"] = {}; --Key: Item Name, Value: set of SubGrinder Names (e.g. ADGrinder)
	    ["Item Update For"] = {}; --Key: SubGrinder Name, Value: T/F (set to true when any item for the given SubGrinder has changed count on this character)
	};
    end

    --Make sure the Inventories variables exist.
    if(GrinderCore_Inventories == nil)then
	GrinderCore_Inventories = 
	{
	};
    end

    --Make sure there is an Inventories entry for the current character.
    if(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")] == nil)then
	GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")] = 
	{
	    ["Bank Scanned"] = false;
	    ["Bags"] = 
	    {
		[-1] = {}; --Main bank frame
		[0]  = {}; --Backpack
		[1]  = {}; --Bag 1
		[2]  = {}; --Bag 2
		[3]  = {}; --Bag 3
		[4]  = {}; --Bag 4
		[5]  = {}; --Bank bag 1
		[6]  = {}; --Bank bag 2
		[7]  = {}; --Bank bag 3
		[8]  = {}; --Bank bag 4
		[9]  = {}; --Bank bag 5
		[10] = {}; --Bank bag 6
		[11] = {}; --Summary of Bags
		[12] = {}; --Summary of Bags and Bank Bags
	    }
	};
    end

    --Make sure each bag for the current character has a slot for every registered item.
    local IDemandARecount = false;
    for key,val in pairs(GrinderCore_Settings["Item IDs"]) do
	GrinderCore_AltBags[key] = 0;
	for idx=-1,12,1 do
	   if(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][idx][key] == nil)then
		GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][idx][key] = 0;
		IDemandARecount = true;
	    end
	end
    end

    --If any items had not been counted previously, count them!
    if(IDemandARecount)then
	--We'll want to re-count the bank items when we get to a bank.
	GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"] = false;
	--For now, just count the items in the carried inventory.
	GrinderCore_CountItemsInBag(0);
	GrinderCore_CountItemsInBag(1);
	GrinderCore_CountItemsInBag(2);
	GrinderCore_CountItemsInBag(3);
	GrinderCore_CountItemsInBag(4);
    end

    --Calculate alt item totals here once so we never have to do it again.
    for RealmPlusName,_ in pairs(GrinderCore_Inventories) do
	local index = strfind(RealmPlusName, "_");
	local realm = strsub(RealmPlusName,1,index-1);
	local toonName = strsub(RealmPlusName,index+1,string.len(RealmPlusName));

	if((realm == GetRealmName()) and (toonName ~= UnitName("player")))then
	    for itemName,_ in pairs(GrinderCore_Settings["Item IDs"])do
		if(GrinderCore_Inventories[RealmPlusName]["Bags"][12][itemName] == nil) then GrinderCore_Inventories[RealmPlusName]["Bags"][12][itemName] = 0; end
		GrinderCore_AltBags[itemName] = GrinderCore_AltBags[itemName] + GrinderCore_Inventories[RealmPlusName]["Bags"][12][itemName];
	    end
	end
    end
    
    --Make sure the Factions variables exist
    if(GrinderCore_Factions == nil)then
	GrinderCore_Factions = 
	{
	    ["Rep Ground"] = {}; --Key: faction name, Value: # of rep earned while grinding
	    ["Grinding Time"] = {}; --Key: faction name, Value: # of seconds spent grinding
	};
    end
end

function GrinderCore_CountItemsInBag(bag)
  if(((bag>=0)and(bag<=4))or(GrinderCore_BankIsOpen))then
    --First, we create a list of all the items to be counted.
    local items={};
    for key,val in pairs(GrinderCore_Settings["Item IDs"])do
	items[key] = 0;
    end

    --Second, we count the actual number of each item in the chosen bag.
    for slot=1,GetContainerNumSlots(bag) do
        if (GetContainerItemLink(bag,slot)) then
	    local itemid = GrinderCore_IDFromItemLink(GetContainerItemLink(bag,slot));

	    for item,id in pairs(GrinderCore_Settings["Item IDs"])do
		if(itemid==id)then
		    items[item] = items[item] + GrinderCore_ItemsIn(bag,slot);
		end
	    end
	end
    end

    --Third, we see if the new count differs from the old for any of these items.  If it does, we'll report the change to the appropriate add-ons.
    local AnItemCountChanged = false;
    for item,count in pairs(items) do
	if(count ~=  GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag][item])then
	    for _,addon in pairs(GrinderCore_Settings["Item Tracked By"][item]) do
		GrinderCore_Settings["Item Update For"][addon] = true;
		AnItemCountChanged = true;
	    end
	end
    end
    
    --Only recalculate bag totals if the affected bag's tracked items have changed quantity.
    if(AnItemCountChanged)then
        --Fourth, we "un-count" the previous values for this bag.
	for item,count in pairs(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag]) do
	    if((bag>=0)and(bag<=4))then
		GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][item] = GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][item] - count;
	   end
	    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][item] = GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][item] - count;
	end

	--Fifth, we set the bag's new values to be what we calculated.
	GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag] = items;

	--Sixth, we add the new values back into the summary bags.
	for item,count in pairs(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag]) do
	    if((bag>=0)and(bag<=4))then
		GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][item] = GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][item] + count;
	    end
	    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][item] = GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][item] + count;
	end
    end
  end
end

function GrinderCore_IDFromItemLink(link)
    local index = strfind(link, ":");
    if ( index ) then
	link = strsub(link, index+1, index+8);
	index = strfind(link,":");
	if(index) then
	    link = strsub(link,1,index-1);
	else
	    link = "";
	end
    else
	link = "";
    end	
    return link;
end

function GrinderCore_ItemsIn(bag,slot)
    local _, itemCount, _, _, _ = GetContainerItemInfo(bag,slot);
    return itemCount;
end

function GrinderCore_TableContainsValue(table,value)
    local result = false;
    for _,val in pairs(table) do
	if(value == val)then
	    result = true;
	    break;
	end
    end
    return result;
end

function GrinderCore_RegisterItem(addon,itemName,itemID)
    if(GrinderCore_Settings["Item IDs"][itemName] == nil)then
	--This item has not previously been tracked, so set it up everywhere!
	GrinderCore_Settings["Item IDs"][itemName] = itemID;
	GrinderCore_Settings["Item Tracked By"][itemName] = {addon};
	GrinderCore_Settings["Item Update For"][addon] = false;
	GrinderCore_AltBags[itemName] = 0;
	GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"] = false;
	for bag=-1,12 do
	    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag][itemName] = 0;
	end
	GrinderCore_CountItemsInBag(0);
	GrinderCore_CountItemsInBag(1);
	GrinderCore_CountItemsInBag(2);
	GrinderCore_CountItemsInBag(3);
	GrinderCore_CountItemsInBag(4);	
    elseif (not(GrinderCore_TableContainsValue(GrinderCore_Settings["Item Tracked By"][itemName],addon))) then
	--This item has been previously tracked, so make sure this addon is in the tracking list.
	table.insert(GrinderCore_Settings["Item Tracked By"][itemName],addon);
    end
end

function GrinderCore_PlayerInventoryCount(itemName)
    if(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][itemName] == nil)then
	return 0;
    else
	return GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][11][itemName];
    end
end

function GrinderCore_PlayerTotalCount(itemName)
    if(GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][itemName] == nil)then
	return 0;
    else
	return GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][12][itemName];
    end
end

function GrinderCore_AltTotalCount(itemName)
    if(GrinderCore_AltBags[itemName] == nil)then
	return 0;
    else
	return GrinderCore_AltBags[itemName];
    end
end

function GrinderCore_GetGrindingTime(factionName)
    if(GrinderCore_Factions["Grinding Time"][factionName] == nil)then
	return 0;
    else
        return GrinderCore_Factions["Grinding Time"][factionName];
    end
end

function GrinderCore_SetGrindingTime(factionName,seconds)
    GrinderCore_Factions["Grinding Time"][factionName] = seconds;
end

function GrinderCore_GetRepGround(factionName)
    if(GrinderCore_Factions["Rep Ground"][factionName] == nil)then
	return 0;
    else
	return GrinderCore_Factions["Rep Ground"][factionName];
    end
end

function GrinderCore_SetRepGround(factionName,rep)
    GrinderCore_Factions["Rep Ground"][factionName] = rep;
end

function GrinderCore_FactionItemsChanged(addon)
    return GrinderCore_Settings["Item Update For"][addon];
end

function GrinderCore_AcknowledgeItemChange(addon)
    GrinderCore_Settings["Item Update For"][addon] = false;
end

function GrinderCore_ResetPlayerItemCounts()
    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"] = false;
    for itemName,_ in pairs(GrinderCore_Settings["Item IDs"]) do
        for bag=-1,12 do
	    GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bags"][bag][itemName] = 0;
	end
    end
    GrinderCore_CountItemsInBag(0);
    GrinderCore_CountItemsInBag(1);
    GrinderCore_CountItemsInBag(2);
    GrinderCore_CountItemsInBag(3);
    GrinderCore_CountItemsInBag(4);

    if(GrinderCore_BankIsOpen)then
	GrinderCore_CountItemsInBag(-1);
	GrinderCore_CountItemsInBag(5);
	GrinderCore_CountItemsInBag(6);
	GrinderCore_CountItemsInBag(7);
	GrinderCore_CountItemsInBag(8);
	GrinderCore_CountItemsInBag(9);
	GrinderCore_CountItemsInBag(10);
	GrinderCore_Inventories[GetRealmName().."_"..UnitName("player")]["Bank Scanned"] = true;
    end
end
