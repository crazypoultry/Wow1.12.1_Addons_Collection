-- Constants
QUANJURE_VERSION = "2.5";
QUANJURE_DATE = "June 22nd, 2006";
BINDING_HEADER_QUANJUREHEADER = "Quanjure";
Q_NIL = -100;

-- Globals
Quanjure_Config = nil;
QPlayer = "";

Quanjure_SavedBagFunc = nil;
Quanjure_SavedInvFunc = nil;

-- Locals
local WaterCosts = {60,105,180,285,420,585,780};
local FoodCosts = {60,105,180,285,420,585,705};
local WaterTypes = QUANJURE_WATERTYPES;
local FoodTypes = QUANJURE_FOODTYPES;
local FoodLevels = {6,12,22,32,42,52,56};
local TargetLevels = {1,5,15,25,35,45,55};

local Quanjure_Darkmoon = false;
local Quanjure_DarkmoonStart = 0;
local Quanjure_Drinking = false;
local Quanjure_InnervateStart = 0;
local Quanjure_Innervating = false;
local Quanjure_EvocationStart = 0;
local Quanjure_Evocating = false;
local Quanjure_SwappedMain = nil;
local Quanjure_SwappedOff = nil;
local Quanjure_SwappedWand = nil;

local Quanjure_ReagentTime = 0;

local Quanjure_Trading = false;
local Quanjure_TradeList = {};

local Quanjure_TotalsInit = false;
local Quanjure_WaterNum = 0;
local Quanjure_FoodNum = 0;

local Quanjure_CurrentID = Q_NIL;
local Quanjure_CurrentBag = Q_NIL;
local Quanjure_CurrentSlot = Q_NIL;
local Quanjure_CurrentName = "";
local Quanjure_CurrentTexture = "";

-- Spams the default chat frame
function Quanjure_Spam(message, alert)
	if not message and not message == 0 then message = "nil" end;
		
	if( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage("|cFFFFFF00Quanjure:|r " .. message);
	end
	if( UIErrorsFrame and alert == 1 ) then
		UIErrorsFrame:AddMessage("|cFFFFFFFFQuanjure:|r " .. message, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
	end
end

-- Startup commands
function Quanjure_OnLoad()
	Quanjure_Reset();
	this:RegisterEvent("SPELLCAST_START");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("BAG_UPDATE");
	this:RegisterEvent("TRADE_SHOW");
	this:RegisterEvent("TRADE_CLOSED");
	this:RegisterEvent("UNIT_AURA");
	this:RegisterEvent("CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS");
	this:RegisterEvent("SPELLCAST_CHANNEL_UPDATE");
	this:RegisterEvent("SPELLCAST_CHANNEL_STOP");
	this:RegisterEvent("DELETE_ITEM_CONFIRM")
	this:RegisterEvent("VARIABLES_LOADED")
	if not Fetch_Frame then
		this:RegisterEvent("UNIT_NAME_UPDATE")
	end
	
	if (UnitClass("Player") == QUANJURE_MAGE) then
		this:RegisterEvent("MERCHANT_SHOW");
		Quanjure_Spam(QUANJURE_REAGENTS_ENABLED);
	else
		Quanjure_Spam(QUANJURE_REAGENTS_DISABLED);
	end
	
	local temp = PickupContainerItem;
	if ( Quanjure_HookFunction("PickupContainerItem", "Quanjure_PickupContainerItem") ) then
		Quanjure_SavedBagFunc = temp;
	end
	
	local temp = PickupInventoryItem;
	if ( Quanjure_HookFunction("PickupInventoryItem", "Quanjure_PickupInventoryItem") ) then
		Quanjure_SavedInvFunc = temp;
	end
	
	SLASH_QUANSETUP1 = "/QUANSETUP";
	SlashCmdList["QUANSETUP"] = function()
		Quanjure_Toggle();
	end
	
	SLASH_QUANDROPDOWNFIX1 = "/QUANDROPDOWNFIX";
	SlashCmdList["QUANDROPDOWNFIX"] = function()
		Quanjure_DropdownFix();
	end
	
	SLASH_QUANJURE1 = "/QUANJURE";
	SlashCmdList["QUANJURE"] = function()
		quanjure();
	end
	
	SLASH_QUANSUME1 = "/QUANSUME";
	SlashCmdList["QUANSUME"] = function()
		quansume();
	end
	
	SLASH_QUANEVOC1 = "/QUANEVOC";
	SlashCmdList["QUANEVOC"] = function()
		QuanEvoc();
	end
	
	SLASH_QUANTOTALS1 = "/QUANTOTALS";
	SlashCmdList["QUANTOTALS"] = function (msg)
		if string.lower(msg) == "reset" then 
			Quanjure_Config[QPlayer]["AllTimeWater"] = 0;
			Quanjure_Config[QPlayer]["AllTimeFood"] = 0;
			Quanjure_Config[QPlayer]["AllTimeStart"] = date();
			Quanjure_Spam("Quanjured totals reset!") 
		elseif string.lower(msg) == "spam" then 
			local qparty = GetNumPartyMembers();
			local qraid = GetNumRaidMembers();
			local ChatTarget = "SAY";
			if qparty > 0 then ChatTarget = "PARTY" end;
			if qraid > 0 then ChatTarget = "RAID" end;
			SendChatMessage("Approximate Quanjure "..QUANJURE_VERSION.." totals since " .. Quanjure_Config[QPlayer]["AllTimeStart"] .. ": " .. Quanjure_Config[QPlayer]["AllTimeWater"] .. " water and " .. Quanjure_Config[QPlayer]["AllTimeFood"] .. " bread.", ChatTarget);
		else
			Quanjure_Spam("Approximate Quanjured totals since " .. Quanjure_Config[QPlayer]["AllTimeStart"]) 
			Quanjure_Spam(Quanjure_Config[QPlayer]["AllTimeWater"] .. " water.")
			Quanjure_Spam(Quanjure_Config[QPlayer]["AllTimeFood"] .. " bread.")
		end
	end
end

-- Rehook functions
function Quanjure_HookFunction(func, newfunc)
	local oldValue = getglobal(func);
	if ( oldValue ~= getglobal(newfunc) ) then
		setglobal(func, getglobal(newfunc));
		return true;
	end
	return false;
end


function Quanjure_PickupContainerItem(bag, slot)
	local empty = true;
	local name = '';
	if ( Quanjure_SavedBagFunc ) then
		Quanjure_SavedBagFunc(bag, slot);
	end
	local texture, itemCount, locked = GetContainerItemInfo(bag, slot);
	if ( texture ) then
		name = Quanjure_GetItemName(bag, slot)
	end
	if CursorHasItem() then
		Quanjure_PickupItem(bag, slot, name, texture)
		empty = false
	end
	if empty then
		Quanjure_ResetItem();
	end
end

function Quanjure_PickupInventoryItem(slot)
	local empty = true;
	local name = '';
	if ( Quanjure_SavedInvFunc ) then
		Quanjure_SavedInvFunc(slot);
	end
	local texture = GetInventoryItemTexture("player", slot);
	if ( texture ) then
		name = Quanjure_GetItemName(Q_NIL, slot)
	end
	if CursorHasItem() and name ~= '' then
		Quanjure_PickupItem(Q_NIL, slot, name, texture)
		empty = false
	end
	if empty then
		Quanjure_ResetItem();
	end
end


function Quanjure_PickupItem(bag, slot, name, texture) 
	Quanjure_CurrentID = 1;
	Quanjure_CurrentBag = bag;
	Quanjure_CurrentSlot = slot;
	Quanjure_CurrentName = name;
	Quanjure_CurrentTexture = texture;
end

function Quanjure_ResetItem()
	Quanjure_CurrentID = Q_NIL;
	Quanjure_CurrentBag = Q_NIL;
	Quanjure_CurrentSlot = Q_NIL;
	Quanjure_CurrentName = "";
	Quanjure_CurrentTexture = "";
end

function Quanjure_DropItem()
	if CursorHasItem() then
		if Quanjure_CurrentBag >= 0 then
			PickupContainerItem(Quanjure_CurrentBag,Quanjure_CurrentSlot);
		elseif Quanjure_CurrentSlot >= 0 then
			PickupInventoryItem(Quanjure_CurrentSlot);
		end
	end
	Quanjure_ResetItem();
end

function Quanjure_FindItem(bag, slot, name, pickup, equip)
	if name == nil then
		return Q_NIL, Q_NIL;
	end
	local x, y = Quanjure_FindBagItem(name, pickup, equip);
	if equip then
		return x, y;
	end
	if x < 0 then
		x, y = Quanjure_FindInvItem(name, pickup);
	end
	return x, y;
end

function Quanjure_FindBagItem(name, pickup, equip)
	if name == nil then
		return Q_NIL, Q_NIL;
	end
	for i = 0, 4, 1 do
		local numSlot = GetContainerNumSlots(i);
		for y = 1, numSlot, 1 do
			if (strupper(Quanjure_GetItemName(i, y)) == strupper(name)) then
				if pickup or equip then
					PickupContainerItem(i,y);
					if equip then
						AutoEquipCursorItem();
					end
				end
				return i,y;
			end
		end
	end
	return Q_NIL, Q_NIL;
end

function Quanjure_FindInvItem(name, pickup)
	if name == nil then
		return Q_NIL, Q_NIL;
	end
	for i = 1, 19, 1 do
		if (strupper(Quanjure_GetItemName(Q_NIL, i)) == strupper(name)) then
			if pickup then
				PickupInventoryItem(i);
			end
			return Q_NIL, i;
		end
	end 
	return Q_NIL, Q_NIL;
end

-- Resets Settings
function Quanjure_Reset()
	if Quanjure_CheckPlayer() == false then
		return;
	end
	if Quanjure_Config == nil then
		Quanjure_Config = {};
	end
	Quanjure_Config[QPlayer]={index=nil;};
	Quanjure_Config[QPlayer][1]={index=nil;};
	for j=1,3,1 do
		Quanjure_Config[QPlayer][1][j]= {id=Q_NIL;bag=Q_NIL;slot=Q_NIL;texture="";name="";};
	end
end

-- Initializes a setting
function Quanjure_InitSetting(name, test, set)
	if Quanjure_Config[QPlayer][name] == test then Quanjure_Config[QPlayer][name] = set end;
end

-- Current Player settings
function Quanjure_CheckPlayer()
	if QPlayer == "" then
		local playername;
		if Fetch_Frame then
			if not Fetch_Done then
				return false;
			else
				playername = Fetch_PlayerName
			end
		else
			playername = UnitName("player");
			if playername == nil or playername == UKNOWNBEING or playername == UNKNOWNOBJECT then
				return false;
			end
		end
		QPlayer = GetCVar("realmName") .. "." .. playername;

		if Quanjure_Config == nil or Quanjure_Config[QPlayer] == nil then
			Quanjure_Reset();
		end
		
		Quanjure_InitSetting("EvocType", nil, 2);
		Quanjure_InitSetting("Innervate", nil, 0);
		Quanjure_InitSetting("Gems", nil, 1);
		Quanjure_InitSetting("Powders", nil, 1);
		Quanjure_InitSetting("Portals", nil, 1);
		Quanjure_InitSetting("Teleports", nil, 1);
		Quanjure_InitSetting("QuanjureButtonPosition", nil, 0);
		Quanjure_InitSetting("QuanjureButtonShown", nil, true);
		Quanjure_InitSetting("DrinkingExclude", nil, "");
		Quanjure_InitSetting("TargetConjure", nil, true);
		Quanjure_InitSetting("TradeConjure", nil, true);
		Quanjure_InitSetting("AllTimeStart", nil, date());
		Quanjure_InitSetting("AllTimeWater", nil, 0);
		Quanjure_InitSetting("AllTimeFood", nil, 0);
		
		for i=1,3,1 do
			Quanjure_ButtonUpdate(getglobal("QuanjureButtonSet1"..i));
		end
	end
	if QPlayer == "" or QPlayer == "NONE" then
		return false;
	else
		return true;
	end
end


-- Detects whether a buff is present 
function Quanjure_Buff(buffstring) 
	i = 1;
	while(UnitBuff("player", i)) do 
		if (string.find(UnitBuff("player", i), buffstring)) then 
 			return true; 
		end 
		i = i + 1; 
	end
	return false;
end 

-- Retrieve the name of an item in an inventory slot
function Quanjure_GetItemName(bag,slot)
	linktext = GetContainerItemLink(bag, slot);
	if linktext then
		local _,_,name = string.find(linktext,"^.*%[(.*)%].*$");
		return name;
	else 
		return "";
	end
end

-- Dismounts the player - doesn't work for paly mounts, but who cares - we're mages!
function Quanjure_Dismount()
	local currentbuff = "";
	local dismounted = false;
	for j=0,15,1 do -- Dismount loop
		currentbuff = GetPlayerBuffTexture(j);
		if (currentbuff and (string.find(string.lower(currentbuff), "_mount_"))) then 
			CancelPlayerBuff(j);
			dismounted = true;
		end
	end
	return dismounted;
end

-- Makes the player stand up!
function Quanjure_Stand()
	QuanjureCmdBox:SetText("/stand");
	ChatEdit_SendText(QuanjureCmdBox);
end

-- Counts the number of a given item 
function Quanjure_ItemCount(itemName)
	itemCount = 0;
	for i=NUM_BAG_FRAMES,0,-1 do
		for j=GetContainerNumSlots(i),1,-1 do
			if (Quanjure_GetItemName(i,j) == itemName) then 
				texture,count = GetContainerItemInfo(i,j);
				itemCount = itemCount + count;
			end
		end
	end
	return itemCount;
end

-- All time conjured stuff
function Quanjure_UpdateTotals()
	local currentCount = 0;
	for i=1, getn(QUANJURE_WATERTYPES) do
		currentCount = currentCount + Quanjure_ItemCount(QUANJURE_WATERTYPES[i]);
	end
	if Quanjure_TotalsInit and (currentCount > Quanjure_WaterNum) and ((currentCount - Quanjure_WaterNum) < 21) then
		Quanjure_Config[QPlayer]["AllTimeWater"] = Quanjure_Config[QPlayer]["AllTimeWater"] + currentCount - Quanjure_WaterNum;
	end
	Quanjure_WaterNum = currentCount;
	
	currentCount = 0;	
	for i=1, getn(QUANJURE_FOODTYPES) do
		currentCount = currentCount + Quanjure_ItemCount(QUANJURE_FOODTYPES[i]);
	end
	if Quanjure_TotalsInit and (currentCount > Quanjure_FoodNum) and ((currentCount - Quanjure_FoodNum) < 21) then
		Quanjure_Config[QPlayer]["AllTimeFood"] = Quanjure_Config[QPlayer]["AllTimeFood"] + currentCount - Quanjure_FoodNum;
	end
	Quanjure_FoodNum = currentCount;
	
	-- Haxx
	Quanjure_Config[QPlayer]["AllTimeWater"] = Quanjure_Config[QPlayer]["AllTimeWater"] + mod(Quanjure_Config[QPlayer]["AllTimeWater"],2)
	Quanjure_Config[QPlayer]["AllTimeFood"] = Quanjure_Config[QPlayer]["AllTimeFood"] + mod(Quanjure_Config[QPlayer]["AllTimeFood"],2)
end

-- Exclusive or function
function Quanjure_Xor(a,b)
	return ((a or b) and not (a and b));
end

-- Standard Explode function
function Quanjure_Explode(d,p)
	local t={}
	local ll=0
	while true do
		l=string.find(p,d,ll+1,true)
		if l~=nil then
			table.insert(t, string.sub(p,ll,l-1))
			ll=l+1
		else
			table.insert(t, string.sub(p,ll))
			break
		end
	end
	return t
end

-- Check if a zone is in the exclusion list
function Quanjure_ExcludedZone(list)
	if list == "" then return false end
	
	local zones = Quanjure_Explode(",",list);
	for i=1, getn(zones) do
		if GetRealZoneText() ==	string.gsub(zones[i], "^%s*(.-)%s*$", "%1") then -- Trim spaces at both ends
			return true;
		end
	end

	return false;
end

-- Finds item and consumes it
function Quanjure_Consume(itemname)
	for m=4,0,-1 do
		for n=GetContainerNumSlots(m),1,-1 do
			if (Quanjure_GetItemName(m,n) == itemname) then 
				UseContainerItem(m,n);
				return;
			end
		end
	end
end

-- Finds and consumes highest level of conjured mage stuff. Useful for non-mages.
function Quanjure_CrudeQuansume()
	local itemnum = 0;
	local itemuse;
	if Quanjure_Buff(QUANJURE_DRINKING_BUFF) == false and UnitMana("player") < UnitManaMax("player") then
		for i=1,7 do
			itemnum = Quanjure_ItemCount(WaterTypes[i]);
			if itemnum > 1 then itemuse = WaterTypes[i] end;
		end
		if itemuse ~= nil then Quanjure_Consume(itemuse) end;
	end
	
	itemnum = 0;
	itemuse = nil;
	if Quanjure_Buff(QUANJURE_EATING_BUFF) == false and UnitHealth("player") < UnitHealthMax("player") then
		for i=1,6 do
			itemnum = Quanjure_ItemCount(FoodTypes[i]);
			if itemnum > 1 then itemuse = FoodTypes[i] end;
		end
		if itemuse ~= nil then Quanjure_Consume(itemuse) end;
	end
end

-- Finds spell position in spellbook
function Quanjure_GetSpellPosition(spell)
	local spellposition = nil;
	local i = 1
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if spellName == spell then
			spellposition = i
			do break end
		end
		i = i + 1
	end
	return spellposition
end

-- Finds highest rank of a spell
function Quanjure_GetSpellRank(spell)
	local rank = 1;
	local i = 1;
	while true do
		local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
		if not spellName then
			do break end
		end
		if spellName == spell then
			if (tonumber(string.sub(spellRank,strlen(QUANJURE_CONJURE_RANK)+2)) > rank) then rank = tonumber(string.sub(spellRank,strlen(QUANJURE_CONJURE_RANK)+2)) end
		end
		i = i + 1;
	end
	return rank;
end

-- Finds a full stack of water, or an incomplete one if no full ones are available
function Quanjure_GetStack(Types, Rank)
	local alreadyTraded;
	local count;
	local prevCount = 0;
	local bag, slot = nil, nil;
	local ItemName = Types[Rank];
	for i = 0, 4, 1 do
		local numSlot = GetContainerNumSlots(i);
		for y = 1, numSlot, 1 do
			if (strupper(Quanjure_GetItemName(i, y)) == strupper(ItemName)) then
				_,count = GetContainerItemInfo(i,y);
				if count > prevCount then
					alreadyTraded = false;
					for j = 1, getn(Quanjure_TradeList) do
						if Quanjure_TradeList[j][1] == i and Quanjure_TradeList[j][2] == y then alreadyTraded = true end
					end
					if not alreadyTraded then prevCount, bag, slot = count, i, y end;
				end
			end
		end
	end
	return bag, slot;
end

-- Fill stacks of reagents when at the reagent vendor
function Quanjure_Reagents() 
	if GetTime() < (Quanjure_ReagentTime + 1) then return end;
	local numItems = GetMerchantNumItems();
	local numPowder = (20 * Quanjure_Config[QPlayer]["Powders"]) - Quanjure_ItemCount(QUANJURE_REAGENTS_POWDER);
	local numTele = (10 *  Quanjure_Config[QPlayer]["Teleports"]) - Quanjure_ItemCount(QUANJURE_REAGENTS_TELEPORT);
	local numPortal = (10 * Quanjure_Config[QPlayer]["Portals"]) - Quanjure_ItemCount(QUANJURE_REAGENTS_PORTAL);
	local reaCost = 0;
	
	for i=numItems,1,-1 do
		item,_,itemPrice = GetMerchantItemInfo(i);
		if (item == QUANJURE_REAGENTS_POWDER and numPowder > 0 and Quanjure_GetSpellPosition(QUANJURE_REAGENTS_ARCANEBRILLIANCE)) then
			if(GetMoney() > (itemPrice * numPowder)) then
				while numPowder > 20 do
					BuyMerchantItem(i,20);
					reaCost = reaCost + (itemPrice * 20);
					numPowder = numPowder - 20;
				end
				BuyMerchantItem(i,numPowder);
				reaCost = reaCost + (itemPrice * numPowder);
			end
		elseif (item == QUANJURE_REAGENTS_TELEPORT and numTele > 0 and UnitLevel("Player") > 19) then
			if(GetMoney() > (itemPrice * numTele)) then
				while numTele > 10 do
					BuyMerchantItem(i,10);
					reaCost = reaCost + (itemPrice * 10);
					numTele = numTele - 10;
				end
				BuyMerchantItem(i,numTele);
				reaCost = reaCost + (itemPrice * numTele);
			end
		elseif (item == QUANJURE_REAGENTS_PORTAL and numPortal > 0 and UnitLevel("Player") > 39) then
			if(GetMoney() > (itemPrice * numPortal)) then
				while numPortal > 10 do
					BuyMerchantItem(i,10);
					reaCost = reaCost + (itemPrice * 10);
					numPortal = numPortal - 10;
				end
				BuyMerchantItem(i,numPortal);
				reaCost = reaCost + (itemPrice * numPortal);
			end
		end
	end
	
	if reaCost > 0 then
		local gold = floor(reaCost / (COPPER_PER_SILVER * SILVER_PER_GOLD));
		local silver = floor((reaCost - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
		Quanjure_Spam("|cffffffff" .. QUANJURE_REAGENTS .. ":|r |c00ffff66"..gold.. QUANJURE_REAGENTS_CURRENCY[1] .. "|r |c00c0c0c0"..silver.. QUANJURE_REAGENTS_CURRENCY[2] .. "|r");
		Quanjure_ReagentTime = GetTime();
	end
end

-- Toggles the option dialogue
function Quanjure_Toggle()
	if (QuanjureFrame) then 
		if ( QuanjureFrame:IsVisible() ) then 
			HideUIPanel(QuanjureFrame);
		else
			ShowUIPanel(QuanjureFrame);
		end
	end
end


-- Toggles overriding dropdown box on and off
function Quanjure_DropdownFix()
	if (Quanjure_Config[QPlayer]["DropDownFix"] ~= nil) then
		Quanjure_Spam("Drop down fix disabled.");
		Quanjure_Config[QPlayer]["DropDownFix"] = nil;
	else
		Quanjure_Spam("Drop down fix enabled.");
		Quanjure_Config[QPlayer]["DropDownFix"] = 1;
	end
end

-- Toggles target dependant conjuring
function Quanjure_TargetConjure_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["TargetConjure"] = true;
	else
		Quanjure_Config[QPlayer]["TargetConjure"] = false;
	end 
end

-- Toggles trade dependant conjuring
function Quanjure_TradeConjure_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["TradeConjure"] = true;
	else
		Quanjure_Config[QPlayer]["TradeConjure"] = false;
	end 
end

-- Toggles innervate
function Quanjure_Innervate_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["Innervate"] = 1;
	else
		Quanjure_Config[QPlayer]["Innervate"] = 0;
	end 
end

-- Toggles Darkmoon Card: Blue Dragon
function Quanjure_Darkmoon_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["Darkmoon"] = 1;
	else
		Quanjure_Config[QPlayer]["Darkmoon"] = 0;
	end 
end

-- Toggles innervate
function Quanjure_Drinking_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["Drinking"] = 1;
	else
		Quanjure_Config[QPlayer]["Drinking"] = 0;
	end 
end

-- Toggles between evocation types
function Quanjure_Evocation_Toggle(enabled)
	if enabled then
		Quanjure_Config[QPlayer]["EvocType"] = 2;
	else
		Quanjure_Config[QPlayer]["EvocType"] = 1;
	end 
end

-- Equips spirit weapons and saves old ones for swapping in later
function Quanjure_SpiritGear()
	if(Quanjure_Config[QPlayer][1][1]["name"] ~= Quanjure_GetItemName(Q_NIL, 16)) then
		Quanjure_SwappedMain = Quanjure_GetItemName(Q_NIL, 16);
		Quanjure_SwappedOff = Quanjure_GetItemName(Q_NIL, 17);
		Quanjure_SwappedWand = Quanjure_GetItemName(Q_NIL, 18);
	end
	Quanjure_FindItem(0,0,Quanjure_Config[QPlayer][1][1]["name"], false, true);
	Quanjure_FindItem(0,0,Quanjure_Config[QPlayer][1][2]["name"], false, true);
	Quanjure_FindItem(0,0,Quanjure_Config[QPlayer][1][3]["name"], false, true);
end

function Quanjure_NonSpiritGear()
	Quanjure_FindItem(0,0,Quanjure_SwappedMain, false, true);
	Quanjure_FindItem(0,0,Quanjure_SwappedOff, false, true);
	Quanjure_FindItem(0,0,Quanjure_SwappedWand, false, true);
end

-- Event handlers
function Quanjure_OnEvent(event)
	if (event == "UNIT_AURA" and arg1 == "player") then
		if (Quanjure_Drinking == true and not (Quanjure_Buff(QUANJURE_DRINKING_BUFF) or Quanjure_Buff(QUANJURE_EATING_BUFF))) then
			Quanjure_Drinking = false;
			if ( not Quanjure_Innervating and not Quanjure_Evocating and not Quanjure_Darkmoon) then
				Quanjure_NonSpiritGear();
			end			
		elseif ((Quanjure_Buff(QUANJURE_DRINKING_BUFF) or Quanjure_Buff(QUANJURE_EATING_BUFF)) and Quanjure_Xor((Quanjure_Config[QPlayer]["Drinking"] == 1), Quanjure_ExcludedZone(Quanjure_Config[QPlayer]["DrinkingExclude"]))) then 
    		Quanjure_Drinking = true;
    		Quanjure_SpiritGear();
    	end

	elseif(event == "TRADE_SHOW") then
		Quanjure_Trading = true;
		Quanjure_TradeList = {};
	
	elseif(event == "TRADE_CLOSED") then
		Quanjure_Trading = false;
 
	elseif(event == "CHAT_MSG_SPELL_PERIODIC_SELF_BUFFS") then
    	if (string.find(arg1, QUANJURE_INNERVATE) and Quanjure_Config[QPlayer]["Innervate"] == 1) then 
    		Quanjure_Innervating = true;
    		Quanjure_InnervateStart = GetTime();
    		Quanjure_SpiritGear();
    	
		elseif (string.find(arg1, QUANJURE_DARKMOON) and Quanjure_Config[QPlayer]["Darkmoon"] == 1) then 
    		Quanjure_Darkmoon = true;
    		Quanjure_DarkmoonStart = GetTime();
    		Quanjure_SpiritGear();
    	end
    	

    elseif(event == "SPELLCAST_CHANNEL_UPDATE" and Quanjure_Evocating) then
		if (arg1 == 0) then
			Quanjure_Evocating = false;
			Quanjure_NonSpiritGear();
		else
			local elapsed = (8000 - arg1) / 1000;
			local actual = GetTime() - Quanjure_EvocationStart;
			Quanjure_EvocationStart = Quanjure_EvocationStart - (elapsed - actual);
		end	
	
	elseif(event == "SPELLCAST_CHANNEL_STOP" and Quanjure_Evocating) then
		Quanjure_Evocating = false;
		Quanjure_NonSpiritGear();
		
	elseif(event == "MERCHANT_SHOW") then
		Quanjure_Reagents();
		return;
	
		
	elseif event == "VARIABLES_LOADED" then
		QPlayer = "";
		Quanjure_CheckPlayer();
		if (Quanjure_Config[QPlayer]["EvocType"] == 2) then checked = 1; else checked = 0; end
		QuanjureCheck1:SetChecked(checked);
		QuanjureCheck1Text:SetText(QUANJURE_EVOCATION_CHECKBOX);
		QuanjureCheck1.myToolTip = QUANJURE_EVOCATION_TOOLTIP;
		QuanjureCheck1.ExecuteCommand = Quanjure_Evocation_Toggle;
		
		QuanjureCheck2:SetChecked(Quanjure_Config[QPlayer]["Innervate"]);
		QuanjureCheck2Text:SetText(QUANJURE_INNERVATE_CHECKBOX);
		QuanjureCheck2.myToolTip = QUANJURE_INNERVATE_TOOLTIP;
		QuanjureCheck2.ExecuteCommand = Quanjure_Innervate_Toggle;
		
		QuanjureDrinkingBox:SetText(Quanjure_Config[QPlayer]["DrinkingExclude"]);
		
		QuanjureCheck4:SetChecked(Quanjure_Config[QPlayer]["Drinking"]);
		QuanjureCheck4Text:SetText(QUANJURE_DRINKING_CHECKBOX);
		QuanjureCheck4.myToolTip = QUANJURE_DRINKING_TOOLTIP;
		QuanjureCheck4.ExecuteCommand = Quanjure_Drinking_Toggle;
		
		QuanjureCheck5:SetChecked(Quanjure_Config[QPlayer]["Darkmoon"]);
		QuanjureCheck5Text:SetText(QUANJURE_DARKMOON_CHECKBOX);
		QuanjureCheck5.myToolTip = QUANJURE_DARKMOON_TOOLTIP;
		QuanjureCheck5.ExecuteCommand = Quanjure_Darkmoon_Toggle;
		
		QuanjureCheck3:SetChecked(Quanjure_Config[QPlayer]["QuanjureButtonShown"]);
		QuanjureCheck3Text:SetText(QUANJURE_MINIMAP_SETUP);
		QuanjureCheck3.myToolTip = QUANJURE_MINIMAP_TOOLTIP;
		QuanjureCheck3.ExecuteCommand = QuanjureButton_Toggle;
		
		QuanjureTargetCheck:SetChecked(Quanjure_Config[QPlayer]["TargetConjure"]);
		QuanjureTargetCheckText:SetText(QUANJURE_TARGETCONJURE_SETUP);
		QuanjureTargetCheck.myToolTip = QUANJURE_TARGETCONJURE_TOOLTIP;
		QuanjureTargetCheck.ExecuteCommand = Quanjure_TargetConjure_Toggle
		
		QuanjureTradeCheck:SetChecked(Quanjure_Config[QPlayer]["TradeConjure"]);
		QuanjureTradeCheckText:SetText(QUANJURE_TRADECONJURE_SETUP);
		QuanjureTradeCheck.myToolTip = QUANJURE_TRADECONJURE_TOOLTIP;
		QuanjureTradeCheck.ExecuteCommand = Quanjure_TradeConjure_Toggle
		
		QuanjureButtonSet1Equip1Text:SetText(QUANJURE_EVOCATION_MAINHAND);
		QuanjureButtonSet1Equip2Text:SetText(QUANJURE_EVOCATION_OFFHAND);
		QuanjureButtonSet1Equip3Text:SetText(QUANJURE_EVOCATION_WAND);
		
		
	elseif event == "UNIT_NAME_UPDATE" and arg1 == "player" then
		QPlayer = "";
		Quanjure_CheckPlayer();
			
	elseif event == "DELETE_ITEM_CONFIRM" then
		if ( QuanjureFrame and QuanjureFrame:IsVisible() ) then 
			Quanjure_DropItem();
		end
		return;
	
	elseif event == "BAG_UPDATE" then
		Quanjure_UpdateTotals();
	
	elseif event == "SPELLCAST_START" then
		Quanjure_TotalsInit = true;
	
	elseif event == "PLAYER_ENTERING_WORLD" then
		this:RegisterEvent("BAG_UPDATE");
	
	elseif event == "PLAYER_LEAVING_WORLD" then
		Quanjure_TotalsInit = false;
		this:UnregisterEvent("BAG_UPDATE");
	end
end

function Quanjure_OnUpdate()
	if(not Quanjure_Evocating and not Quanjure_Innervating and not Quanjure_Darkmoon) then return end;
	
	if(Quanjure_Evocating) then
		if( (GetTime() - Quanjure_EvocationStart) > 6.4 ) then
			Quanjure_Evocating = false
			if ( not Quanjure_Innervating and not Quanjure_Darkmoon and not Quanjure_Drinking) then
				Quanjure_NonSpiritGear();
			end
		end
	end
	
	if(Quanjure_Innervating) then
		if( (GetTime() - Quanjure_InnervateStart) > 19 ) then
			Quanjure_Innervating = false
			if ( not Quanjure_Evocating and not Quanjure_Darkmoon and not Quanjure_Drinking) then
				Quanjure_NonSpiritGear();
			end
		end
	end
	
	if(Quanjure_Darkmoon) then
		if( (GetTime() - Quanjure_DarkmoonStart) > 14 ) then
			Quanjure_Darkmoon = false
			if ( not Quanjure_Evocating and not Quanjure_Innervating and not Quanjure_Drinking) then
				Quanjure_NonSpiritGear();
			end
		end
	end
end


-- Button Handlers
-- ===============
function Quanjure_ButtonUpdate(button)
	if ( button == nil ) then return; end
	button:SetChecked("false");
	local col, row = button:GetID(), button:GetParent():GetID();
	if ( col == nil or row == nil ) then return; end
	button:Enable();
	if Quanjure_CheckPlayer() == false then
		return;
	end
	local name = button:GetName();	
	local icon = getglobal(name.."Icon");
	if (Quanjure_Config[QPlayer][row] == nil ) then return end
	local id = Quanjure_Config[QPlayer][row][col].id;
	if ( id > 0 ) then 
		local texture = Quanjure_Config[QPlayer][row][col].texture;
		if ( texture ) then
			icon:SetTexture(texture);
			icon:Show();
		else
			icon:Hide();
		end
	else
		icon:Hide();
	end
end
function Quanjure_ButtonDragStart()
	local col, row = Quanjure_GetCurrentLocation(this);		
	Quanjure_SwapButton(row,col);
end
function Quanjure_ButtonDragEnd()
	if Quanjure_CheckPlayer() == false then
		return;
	end
	if( Quanjure_CurrentID > 0 ) then
		local col, row = Quanjure_GetCurrentLocation(this);
		Quanjure_SwapButton(row,col);
	end
end
function Quanjure_ButtonClick(button)
	if Quanjure_CheckPlayer() == false then
		return;
	end
	local col, row = Quanjure_GetCurrentLocation(this);		
	if IsShiftKeyDown() then
		Quanjure_Config[QPlayer][row][col] = {id=QM_NIL;bag=QM_NIL;slot=QM_NIL;texture="";name="";};
		Quanjure_ButtonUpdate(this);
	else
		Quanjure_SwapButton(row,col);
	end
end
function Quanjure_ButtonEnter()
	if Quanjure_CheckPlayer() == false then
		return;
	end
	local col, row = Quanjure_GetCurrentLocation(this);		
	local id = Quanjure_Config[QPlayer][row][col].id;
	local tooltip = Quanjure_Config[QPlayer][row][col].name;
	if ( id > 0 ) then 
		local x,_ = this:GetCenter();
		local parentX, _ = UIParent:GetCenter();
		if( x > parentX ) then
			GameTooltip:SetOwner(this, "ANCHOR_LEFT");
		else
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		end
		if ( GameTooltip:SetText(tooltip) ) then
			this.updateTooltip = TOOLTIP_UPDATE_TIME;
		else
			this.updateTooltip = nil;
		end	
	end
end
function QuanjureCheckButton_OnClick()
	if (this:GetChecked()) then
		this.ExecuteCommand(true);
	else
		this.ExecuteCommand(false);
	end
end
function QuanjureCheckButton_OnEnter()
	local x,_ = this:GetCenter();
	local parentX, _ = UIParent:GetCenter();
	if( x > parentX ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end

	if ( GameTooltip:SetText(this.myToolTip) ) then
		this.updateTooltip = TOOLTIP_UPDATE_TIME;
	else
		this.updateTooltip = nil;
	end	
end
function Quanjure_SwapButton(row,col)
	if Quanjure_CheckPlayer() == false then
		return;
	end
	local temp = nil;
	if ( Quanjure_Config[QPlayer][row][col].id > 0 ) then 
		temp = Quanjure_Config[QPlayer][row][col];
	end
	Quanjure_SetButton(row, col);
	if ( temp ) then 
		if ( temp.id > 0 ) then
			local bag, slot = Quanjure_FindItem(temp.bag, temp.slot, temp.name, true);
			Quanjure_PickupItem(bag, slot, temp.name, temp.texture);
		end
	end
end
function Quanjure_SetButton(row, col) 
	if Quanjure_CheckPlayer() == false then
		return;
	end
	Quanjure_Config[QPlayer][row][col] = {id=Quanjure_CurrentID,bag=Quanjure_CurrentBag,slot=Quanjure_CurrentSlot,name=Quanjure_CurrentName,texture=Quanjure_CurrentTexture};
	Quanjure_DropItem();
	Quanjure_ButtonUpdate(this);	
end
function Quanjure_GetCurrentLocation(object)
	return object:GetID(), object:GetParent():GetID();
end

-- Slider Handlers
-- ===============

function QuanjureSlider_OnShow()
	local SliderData = {};
	if( this:GetName() == "QuanjureGemSlider" ) then SliderData = {"Gems",0,4, QUANJURE_GEM_OPTIONS_SHORT}
	elseif (this:GetName() == "QuanjurePowderSlider") then SliderData = {"Powders",0,5, QUANJURE_POWDER_OPTIONS_SHORT} 
	elseif (this:GetName() == "QuanjurePortalSlider") then SliderData = {"Portals",0,5, QUANJURE_PORTAL_OPTIONS_SHORT}
	elseif (this:GetName() == "QuanjureTeleportSlider") then SliderData = {"Teleports",0,5, QUANJURE_TELEPORT_OPTIONS_SHORT} end;
	
	getglobal(this:GetName().."Text"):SetText(Quanjure_Config[QPlayer][SliderData[1]]);
	getglobal(this:GetName().."Low"):SetText(SliderData[2]);
	getglobal(this:GetName().."High"):SetText(SliderData[3]);
	getglobal(this:GetName().."Description"):SetText(SliderData[4]);
	this:SetMinMaxValues(SliderData[2], SliderData[3]);
	this:SetValueStep(1);
	this:SetValue(Quanjure_Config[QPlayer][SliderData[1]]);
end

function QuanjureSlider_OnValueChanged()
	local SliderName = "";
	local SliderTooltip = "";
	if( this:GetName() == "QuanjureGemSlider" ) then SliderName, SliderTooltip = "Gems", QUANJURE_GEM_OPTIONS;
	elseif (this:GetName() == "QuanjurePowderSlider") then SliderName, SliderTooltip = "Powders", QUANJURE_POWDER_OPTIONS;
	elseif (this:GetName() == "QuanjurePortalSlider") then SliderName, SliderTooltip = "Portals", QUANJURE_PORTAL_OPTIONS;
	elseif (this:GetName() == "QuanjureTeleportSlider") then SliderName, SliderTooltip = "Teleports", QUANJURE_TELEPORT_OPTIONS end;
	getglobal(this:GetName().."Text"):SetText(this:GetValue());
	Quanjure_Config[QPlayer][SliderName] = this:GetValue();
	if this.tooltipText then
		this.tooltipText = "|cFFFFFFFF" .. SliderTooltip .. ":|r |cFF00FF00" .. this:GetValue() .. "|r";
		GameTooltip:SetText(this.tooltipText);
	end
end

function QuanjureSlider_OnEnter()
	local SliderTooltip = "";
	if( this:GetName() == "QuanjureGemSlider" ) then SliderTooltip = QUANJURE_GEM_OPTIONS;
	elseif (this:GetName() == "QuanjurePowderSlider") then SliderTooltip = QUANJURE_POWDER_OPTIONS;
	elseif (this:GetName() == "QuanjurePortalSlider") then SliderTooltip = QUANJURE_PORTAL_OPTIONS;
	elseif (this:GetName() == "QuanjureTeleportSlider") then SliderTooltip = QUANJURE_TELEPORT_OPTIONS end;
	
	this.tooltipText = "|cFFFFFFFF" .. SliderTooltip .. ":|r |cFF00FF00" .. this:GetValue() .. "|r";
	
	local x,_ = this:GetCenter();
	local parentX, _ = UIParent:GetCenter();
	if( x > parentX ) then
		GameTooltip:SetOwner(this, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
	end
	GameTooltip:SetText(this.tooltipText);
end

function QuanjureSlider_OnLeave()
	this.tooltipText = nil;
	GameTooltip:Hide();
end

-- Note Button Handlers
-- ====================
function Quanjure_StartFrameTimer(frame)
	if ( frame.parent ) then
		Quanjure_StartFrameTimer(frame.parent);
	else
		frame.showTimer = 0.2;
		frame.isCounting = 1;
	end
end
function Quanjure_StopFrameTimer(frame)
	if ( frame.parent ) then
		Quanjure_StopFrameTimer(frame.parent);
	else
		frame.isCounting = nil;
	end
end





---------------------------
-- Global User Functions --
---------------------------


function quanjure()
	if (UnitClass("Player") ~= QUANJURE_MAGE or UnitLevel("Player") < 6) then
		Quanjure_Spam(QUANJURE_MAGE_WARNING);
		return;
	end
	local FoodRank = Quanjure_GetSpellRank(QUANJURE_CONJURE_FOOD);
	local FoodCount = 2 + 2*(UnitLevel("Player") - FoodLevels[FoodRank]);
	if FoodCount > 20 then FoodCount = 20 end;
		
	local WaterRank = Quanjure_GetSpellRank(QUANJURE_CONJURE_WATER); 
	local gemTable = {};

	if ( Quanjure_GetSpellPosition(QUANJURE_CONJURE_RUBY) ~= nil ) then table.insert( gemTable, {QUANJURE_CONJURE_RUBY, 1470, QUANJURE_RUBY} ) end
	if ( Quanjure_GetSpellPosition(QUANJURE_CONJURE_CITRINE) ~= nil ) then table.insert( gemTable, {QUANJURE_CONJURE_CITRINE, 1130, QUANJURE_CITRINE} ) end;
	if ( Quanjure_GetSpellPosition(QUANJURE_CONJURE_JADE) ~= nil ) then table.insert( gemTable, {QUANJURE_CONJURE_JADE, 800, QUANJURE_JADE} ) end;
	if ( Quanjure_GetSpellPosition(QUANJURE_CONJURE_AGATE) ~= nil ) then table.insert( gemTable, {QUANJURE_CONJURE_AGATE, 530, QUANJURE_AGATE} ) end;
	
	local gemCount = Quanjure_Config[QPlayer]["Gems"];
	if gemCount > getn(gemTable) then gemCount = getn(gemTable); end;
		
	if Quanjure_Buff(QUANJURE_DRINKING_BUFF) and UnitMana("player") ~= UnitManaMax("player") then return end; -- If Quan is drinking, don't disturb
	
	-- Always conjure a bit of water first or if we're running low
	if Quanjure_ItemCount(WaterTypes[WaterRank]) < 2 then
		if UnitMana("player") > WaterCosts[WaterRank] then
			Quanjure_Stand();
			CastSpellByName(QUANJURE_CONJURE_WATER .. "(" .. QUANJURE_CONJURE_RANK .. " " .. WaterRank .. ")"); 
			return;
		else 
			Quanjure_Consume(WaterTypes[WaterRank]);
			return;
		end
	end

-- Target dependant conjuring start
	local TargetLevel = false;
	local TargetClass;
	if Quanjure_Trading and Quanjure_Config[QPlayer]["TradeConjure"] then
		TargetLevel = UnitLevel("NPC");
		TargetClass = UnitClass("NPC");
	elseif (UnitIsFriend("target", "player") and UnitIsPlayer("target") and Quanjure_Config[QPlayer]["TargetConjure"]) then
		TargetLevel = UnitLevel("target")
		TargetClass = UnitClass("target");
	end
	
	if TargetLevel then 
		local TargetFoodRank = 0;
		local TargetWaterRank = 0;
		if TargetLevel < UnitLevel("Player") then
			for i=1,7 do
				if TargetLevel >= TargetLevels[i] then
					TargetWaterRank = i;
					TargetFoodRank = i;
				end
			end
			if TargetFoodRank == 7 then TargetFoodRank = 6 end;
		else
			TargetWaterRank = WaterRank;
			TargetFoodRank = FoodRank;
		end
		
		local ConjureCombo = "Water";
		if (TargetClass == QUANJURE_WARRIOR or TargetClass == QUANJURE_ROGUE) then ConjureCombo = "Bread";
		elseif (TargetClass == QUANJURE_WARLOCK or TargetClass == QUANJURE_MAGE or TargetClass == QUANJURE_HUNTER) then ConjureCombo = "WaterBread"; end;
		
		if ConjureCombo == "Water" then
			if UnitMana("player") > WaterCosts[TargetWaterRank] then
				Quanjure_Stand();
				CastSpellByName(QUANJURE_CONJURE_WATER .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetWaterRank .. ")"); 
			else 
				Quanjure_Consume(WaterTypes[WaterRank]);
			end
			return;
		
		
		elseif ConjureCombo == "Bread" then
			if UnitMana("player") > FoodCosts[TargetFoodRank] then
				Quanjure_Stand();
				CastSpellByName(QUANJURE_CONJURE_FOOD .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetFoodRank .. ")");
				return;
			else
				Quanjure_Consume(WaterTypes[WaterRank]);
			end
			return;
	
		
		elseif ConjureCombo == "WaterBread" then
			-- Alternate between conjuring water and food. Slight emphasis on water. Very crude, but it works.
			if (Quanjure_ItemCount(WaterTypes[TargetWaterRank]) < (Quanjure_ItemCount(FoodTypes[TargetFoodRank]) + 10)) then
				if UnitMana("player") > WaterCosts[TargetWaterRank] then
					Quanjure_Stand();
					CastSpellByName(QUANJURE_CONJURE_WATER .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetWaterRank .. ")"); 
				else 
					Quanjure_Consume(WaterTypes[WaterRank]);
				end
				return;
			else
				if UnitMana("player") > FoodCosts[TargetFoodRank] then
					Quanjure_Stand();
					CastSpellByName(QUANJURE_CONJURE_FOOD .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetFoodRank .. ")");
					return;
				else
					Quanjure_Consume(WaterTypes[WaterRank]);
				end
				return;
			end
		end
	end
-- Target dependant conjuring end
	
	
	if gemCount > 0 then
		for i=1,gemCount do
			if Quanjure_ItemCount(gemTable[i][3]) < 1 then 
				if UnitMana("player") > gemTable[i][2] then
					Quanjure_Stand();
					CastSpellByName(gemTable[i][1]);
					return;
				else
					Quanjure_Consume(WaterTypes[WaterRank]);
					return;
				end
			end
		end
	end
	
	if Quanjure_ItemCount(FoodTypes[FoodRank]) < (21 - FoodCount) then 
		if UnitMana("player") > FoodCosts[FoodRank] then
			Quanjure_Stand();
			CastSpellByName(QUANJURE_CONJURE_FOOD .. "(" .. QUANJURE_CONJURE_RANK .. " " .. FoodRank .. ")");
			return;
		else
			Quanjure_Consume(WaterTypes[WaterRank]);
			return;
		end
		
	
	elseif UnitMana("player") > WaterCosts[WaterRank] then
		Quanjure_Stand();
		CastSpellByName(QUANJURE_CONJURE_WATER .. "(" .. QUANJURE_CONJURE_RANK .. " " .. WaterRank .. ")"); 
	else 
		Quanjure_Consume(WaterTypes[WaterRank]);
	end
end


function quansume()
	if (UnitLevel("Player") < 6) then
		Quanjure_Spam(QUANJURE_MAGE_WARNING);
		return;
	elseif UnitClass("Player") ~= QUANJURE_MAGE then
		Quanjure_CrudeQuansume()
		return;
	end
	
	local FoodRank = Quanjure_GetSpellRank(QUANJURE_CONJURE_FOOD);
	local WaterRank = Quanjure_GetSpellRank(QUANJURE_CONJURE_WATER); 

-- Target dependant trading start
	local TargetLevel
	if (UnitIsFriend("target", "player") and UnitIsPlayer("target") and not UnitIsUnit("target", "player")) then
		TargetLevel = UnitLevel("target")
	else
		TargetLevel = false
	end
	if TargetLevel then 
		if ( Quanjure_Config[QPlayer]["TradeConjure"] and not CursorHasItem() and ( not TradeFrame or not TradeFrame:IsVisible() ) and ( not AuctionFrame or not AuctionFrame:IsVisible() ) and UnitExists("target") and CheckInteractDistance("target", 2) and UnitIsFriend("player", "target") and UnitIsPlayer("target") ) then
			InitiateTrade("target");
			return;
		end
	end

	if Quanjure_Trading then
		local TargetClass = UnitClass("NPC");
		TargetLevel = UnitLevel("NPC");
		local TargetFoodRank = 0;
		local TargetWaterRank = 0;
		if TargetLevel < UnitLevel("Player") then
			for i=1,7 do
				if TargetLevel >= TargetLevels[i] then
					TargetWaterRank = i;
					TargetFoodRank = i;
				end
			end
			if TargetFoodRank == 7 then TargetFoodRank = 6 end;
		else
			TargetWaterRank = WaterRank;
			TargetFoodRank = FoodRank;
		end
		
		local TradeCombo = "Water";
		if (TargetClass == QUANJURE_WARRIOR or TargetClass == QUANJURE_ROGUE) then TradeCombo = "Bread";
		elseif (TargetClass == QUANJURE_WARLOCK or TargetClass == QUANJURE_MAGE or TargetClass == QUANJURE_HUNTER) then TradeCombo = "WaterBread"; end;
		
		if TradeCombo == "Water" then
			local bag,slot = Quanjure_GetStack(WaterTypes, TargetWaterRank);
			local trade = TradeFrame_GetAvailableSlot();
			if (trade and bag and slot) then
				PickupContainerItem(bag, slot);
				ClickTradeButton(trade);
				table.insert(Quanjure_TradeList, {bag, slot});
				if (CursorHasItem()) then
					PickupContainerItem(bag, slot); -- Remove the item from the cursor if it didn't trade.
				end
			elseif ((not bag or not slot) and trade) then
				Quanjure_Spam(WaterTypes[TargetWaterRank] .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetWaterRank .. ") " .. QUANJURE_NOTFOUND);
			end
			
		elseif TradeCombo == "Bread" then
			local bag,slot = Quanjure_GetStack(FoodTypes, TargetFoodRank);
			local trade = TradeFrame_GetAvailableSlot();
			if (trade and bag and slot) then
				PickupContainerItem(bag, slot);
				ClickTradeButton(trade);
				table.insert(Quanjure_TradeList, {bag, slot});
				if (CursorHasItem()) then
					PickupContainerItem(bag, slot); -- Remove the item from the cursor if it didn't trade.
				end
			elseif ((not bag or not slot) and trade) then
				Quanjure_Spam(FoodTypes[TargetFoodRank] .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetFoodRank .. ") " .. QUANJURE_NOTFOUND);
			end
		
		elseif TradeCombo == "WaterBread" then
			local bag,slot = Quanjure_GetStack(WaterTypes, TargetWaterRank);
			local trade = TradeFrame_GetAvailableSlot();
			if (trade and bag and slot) then
				PickupContainerItem(bag, slot);
				ClickTradeButton(trade);
				table.insert(Quanjure_TradeList, {bag, slot});
				if (CursorHasItem()) then
					PickupContainerItem(bag, slot); -- Remove the item from the cursor if it didn't trade.
				end
			elseif ((not bag or not slot) and trade) then
				Quanjure_Spam(WaterTypes[TargetWaterRank] .. "(" .. QUANJURE_CONJURE_RANK .. " " .. TargetWaterRank .. ") " .. QUANJURE_NOTFOUND);
			end
			bag,slot = Quanjure_GetStack(FoodTypes, TargetFoodRank);
			trade = TradeFrame_GetAvailableSlot();
			if (trade and bag and slot) then
				PickupContainerItem(bag, slot);
				ClickTradeButton(trade);
				table.insert(Quanjure_TradeList, {bag, slot});
				if (CursorHasItem()) then
					PickupContainerItem(bag, slot); -- Remove the item from the cursor if it didn't trade.
				end
			elseif ((not bag or not slot) and trade) then
				Quanjure_Spam(FoodTypes[TargetFoodRank] .. " (" .. QUANJURE_CONJURE_RANK .. " " .. TargetFoodRank .. ") " .. QUANJURE_NOTFOUND);
			end
		end
-- Target dependant trading end

	
	elseif UnitAffectingCombat("player") and UnitMana("player") < UnitManaMax("player") then
			
	--	Removed for now... causes more grief than good.
	--	Quanjure_Consume(QUANJURE_RUBY);
	--	Quanjure_Consume(QUANJURE_CITRINE);
	--	Quanjure_Consume(QUANJURE_JADE);
	--	Quanjure_Consume(QUANJURE_AGATE);
	
	else
	
		if Quanjure_Buff(QUANJURE_DRINKING_BUFF) == false and UnitMana("player") < UnitManaMax("player") then
			Quanjure_Consume(WaterTypes[WaterRank]);
		end
		
		if Quanjure_Buff(QUANJURE_EATING_BUFF) == false and UnitHealth("player") < UnitHealthMax("player") then
			Quanjure_Consume(FoodTypes[FoodRank]);
		end
	end
end

function QuanEvoc()
	if (UnitClass("Player") ~= QUANJURE_MAGE) then
		Quanjure_Spam(QUANJURE_MAGE_WARNING);
		return;
	end

	local EvocPosition = Quanjure_GetSpellPosition(QUANJURE_EVOCATION);
	if ( EvocPosition == nil ) then
		Quanjure_Spam(QUANJURE_EVOCATION_WARNING);
		return
	end

	if(Quanjure_Config[QPlayer]["EvocType"] == 1) then
		if GetSpellCooldown(EvocPosition, SpellBookFrame.bookType) == 0 then
			Quanjure_SpiritGear();
			CastSpellByName(QUANJURE_EVOCATION);
		else
			Quanjure_NonSpiritGear();
		end
	else
		if GetSpellCooldown(EvocPosition, SpellBookFrame.bookType) == 0 then
			CastSpellByName(QUANJURE_EVOCATION);
			Quanjure_Evocating = true;
			Quanjure_EvocationStart = GetTime();
			Quanjure_SpiritGear();
		else
			Quanjure_NonSpiritGear();
		end
	end
end