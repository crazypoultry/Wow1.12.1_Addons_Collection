local info = UnitName("player").." of "..GetCVar("realmName"); 
local InInstance = nil

function Pvptrinket_OnLoad()
	SLASH_PVPTRINKET1 = "/pt";
	SlashCmdList["PVPTRINKET"] = function(msg)
		SlashHandler(msg);
	end
	this:RegisterEvent("VARIABLES_LOADED");
end	
function Pvptrinket_OnEvent()
	if (event ==  "VARIABLES_LOADED") then
		
		InitQueueTrinkets();
		InitUseTrinkets();
		InitEquipTrinkets();
		InitLockTrinkets();
		CheckTables();
		
		if IsInInstance() and InInstance==nil then
			InInstance=true
		end
		
		this:RegisterEvent("ITEM_LOCK_CHANGED")
		this:RegisterEvent("MINIMAP_ZONE_CHANGED")
		this:RegisterEvent("PLAYER_ALIVE")
		this:RegisterEvent("PLAYER_UNGHOST")
		this:RegisterEvent("PLAYER_REGEN_ENABLED")
		this:RegisterEvent("PLAYER_TARGET_CHANGED")
		
		DEFAULT_CHAT_FRAME:AddMessage("PvPTrinket: type /pt cmd for info");
		
	elseif (event =="MINIMAP_ZONE_CHANGED") then
		
		if IsInInstance() and InInstance==nil then
			if PvPTrinket[info]["spam"]==true then
				DEFAULT_CHAT_FRAME:AddMessage("PvPTrinket: PvP mode disabled character is in instance");
			end
			InInstance=true
			CheckTrinketsThenEquip("rotation", 14, nil, "rotation");
			CheckTrinketsThenEquip("rotation", 13, nil, "rotation");
		elseif not IsInInstance() and InInstance==true then
			InInstance=nil
		end	
	elseif (event== "ITEM_LOCK_CHANGED") and not arg1 and not UnitAffectingCombat("player") then
		
		if QueueTrinket[13]~=nil then
			EquipItem(QueueTrinket[13],13,PvPTrinket[info]["cooldown"])
		end
		if QueueTrinket[14]~=nil then
			EquipItem(QueueTrinket[14],14,PvPTrinket[info]["cooldown"])
		end	
	elseif (event =="PLAYER_TARGET_CHANGED") and not IsPlayerReallyDead() then
		if InInstance==true and not UnitIsPlayer("target") then
			InitUseTrinkets();
			InitEquipTrinkets();
			ClassEquip();
		elseif InInstance==nil then
			InitUseTrinkets();
			InitEquipTrinkets();
			ClassEquip();
		end
					
	elseif (event=="PLAYER_REGEN_ENABLED" or event=="PLAYER_UNGHOST" or event=="PLAYER_ALIVE") and not IsPlayerReallyDead() then
		
		InitLockTrinkets();
		InitEquipTrinkets();
		local v1 = FindInventoryRotationTrinket(14, nil, nil)
		local v2 = FindInventoryRotationTrinket(13, nil, nil)
		if (TrinketIsReady(14,nil,nil)==nil or v1~=nil) then
			if TrinketIsReady(14,nil,nil)==nil or FindContainerRotationTrinket(1, nil)~=nil then
				CheckTrinketsThenEquip("rotation", 14, nil, "rotation");
			end	
		end
		if (TrinketIsReady(13,nil,nil)==nil or v2~=nil) then
			if TrinketIsReady(13,nil,nil)==nil or FindContainerRotationTrinket(1, nil)~=nil then
				CheckTrinketsThenEquip("rotation", 13, nil, "rotation");
			end	
		end
	end
	
end
--InitUseTrinkets--
function InitUseTrinkets()
UseTrinket = {};
UseTrinket[13] = "rotation"
UseTrinket[14] = "rotation"
end
--InitEquipTrinkets--
function InitEquipTrinkets()
EquipTrinket = {};
EquipTrinket[13] = nil
EquipTrinket[14] = nil
end
--InitQueueTrinkets--
function InitQueueTrinkets()
QueueTrinket = {};
QueueTrinket[13] = nil
QueueTrinket[14] = nil
end
--InitLockTrinkets--
function InitLockTrinkets()
LockTrinket = {};
LockTrinket[13] = nil
LockTrinket[14] = nil
end
--Commands--
function Commands()
DEFAULT_CHAT_FRAME:AddMessage("/pt add class_name slotID [use] trinket_name - Set up Trinkets for Given Class, [use] - optional: Use Trinkets When Ready",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt add rotation [use] trinket_name - Set up Trinkets for Rotation Mode, Rotation is Enabled When Target is non Player",0.5, 0.5, 1)
DEFAULT_CHAT_FRAME:AddMessage("/pt reset rotation - Reset Saved Trinkets for Rotation",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt reset class_name - Reset Saved Trinkets for Given Class",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt reset all - Reset All Saved Trinkets",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt show - Display Trinkets list ",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt spam - Enable/Disable Spam",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("/pt lock SlotID - Lock/Unlock Slot for Automaticly Swapping",0.5, 0.5, 1);
DEFAULT_CHAT_FRAME:AddMessage("Example: /pt add warrior slot1 Insignia of the Alliance", 1, 1, 0.6);
DEFAULT_CHAT_FRAME:AddMessage("Example: /pt add druid slot2 use Talisman of Ephemeral Power", 1, 1, 0.6);
DEFAULT_CHAT_FRAME:AddMessage("Example: /pt add rotation use Earthstrike", 1, 1, 0.6);
DEFAULT_CHAT_FRAME:AddMessage("Example: /pt lock slot1", 1, 1, 0.6);
end
--CheckTables--
function CheckTables()
	if not PvPTrinket then
		Reset("all");
	elseif not PvPTrinket[info] then
		Reset("all");
	elseif PvPTrinket[info]["check"]==true then
		DEFAULT_CHAT_FRAME:AddMessage("PvPTrinket: Check Data...pass")
	end		
end
--Reset Tables--
function Reset(class)
	if not PvPTrinket then
		PvPTrinket = {};
	end
			
	if 	class=="rotation" then
		DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: "..class.." reset...done");
		PvPTrinket[info]["rotation"]={index=nil;}
	
	elseif class~="all" then
		DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: "..class.." reset...done");
		PvPTrinket[info][class]["slot1"]["Trinket"]=""
		PvPTrinket[info][class]["slot1"]["Use"]=false 
	
		PvPTrinket[info][class]["slot2"]["Trinket"]=""
		PvPTrinket[info][class]["slot2"]["Use"]=false 
	else	
		DEFAULT_CHAT_FRAME:AddMessage("PvPTrinket: Data Reset...done");
		
		PvPTrinket[info]={index=nil;};
		PvPTrinket[info]["check"] = true;
		PvPTrinket[info]["spam"] = true;
		PvPTrinket[info][13] = false;  -- if false: unlock slotID
		PvPTrinket[info][14] = false;  -- if false: unlock slotID
		
		PvPTrinket[info]["rotation"]={index=nil;}
	
		PvPTrinket[info]["warrior"]={index=nil;}
		PvPTrinket[info]["warrior"]["slot1"]={index=nil;}
		PvPTrinket[info]["warrior"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["warrior"]["slot1"]["Use"]=false 
		PvPTrinket[info]["warrior"]["slot2"]={index=nil;}
		PvPTrinket[info]["warrior"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["warrior"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["priest"]={index=nil;}
		PvPTrinket[info]["priest"]["slot1"]={index=nil;}
		PvPTrinket[info]["priest"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["priest"]["slot1"]["Use"]=false 
		PvPTrinket[info]["priest"]["slot2"]={index=nil;}
		PvPTrinket[info]["priest"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["priest"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["hunter"]={index=nil;};
		PvPTrinket[info]["hunter"]["slot1"]={index=nil;}
		PvPTrinket[info]["hunter"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["hunter"]["slot1"]["Use"]=false 
		PvPTrinket[info]["hunter"]["slot2"]={index=nil;};
		PvPTrinket[info]["hunter"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["hunter"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["paladin"]={index=nil;}
		PvPTrinket[info]["paladin"]["slot1"]={index=nil;}
		PvPTrinket[info]["paladin"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["paladin"]["slot1"]["Use"]=false 
		PvPTrinket[info]["paladin"]["slot2"]={index=nil;}
		PvPTrinket[info]["paladin"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["paladin"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["warlock"]={index=nil;}
		PvPTrinket[info]["warlock"]["slot1"]={index=nil;}
		PvPTrinket[info]["warlock"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["warlock"]["slot1"]["Use"]=false 
		PvPTrinket[info]["warlock"]["slot2"]={index=nil;}
		PvPTrinket[info]["warlock"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["warlock"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["rogue"]={index=nil;}
		PvPTrinket[info]["rogue"]["slot1"]={index=nil;}
		PvPTrinket[info]["rogue"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["rogue"]["slot1"]["Use"]=false 
		PvPTrinket[info]["rogue"]["slot2"]={index=nil;}
		PvPTrinket[info]["rogue"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["rogue"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["druid"]={index=nil;}
		PvPTrinket[info]["druid"]["slot1"]={index=nil;}
		PvPTrinket[info]["druid"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["druid"]["slot1"]["Use"]=false 
		PvPTrinket[info]["druid"]["slot2"]={index=nil;}
		PvPTrinket[info]["druid"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["druid"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["mage"]={index=nil;}
		PvPTrinket[info]["mage"]["slot1"]={index=nil;}
		PvPTrinket[info]["mage"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["mage"]["slot1"]["Use"]=false 
		PvPTrinket[info]["mage"]["slot2"]={index=nil;}
		PvPTrinket[info]["mage"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["mage"]["slot2"]["Use"]=false 
	
		PvPTrinket[info]["shaman"]={index=nil;}
		PvPTrinket[info]["shaman"]["slot1"]={index=nil;}
		PvPTrinket[info]["shaman"]["slot1"]["Trinket"]=""
		PvPTrinket[info]["shaman"]["slot1"]["Use"]=false 
		PvPTrinket[info]["shaman"]["slot2"]={index=nil;}
		PvPTrinket[info]["shaman"]["slot2"]["Trinket"]=""
		PvPTrinket[info]["shaman"]["slot2"]["Use"]=false 
end	
end
-- Find Item--
function FindItem(name,Inventory)
	
	if Inventory then
		for i=13,14 do
			if GetInventoryItemLink("player",i)~=nil then
				_,InventoryItemName=InventoryItemNameCheck(i)
				if string.find(InventoryItemName or "",string.lower(name),1,1) then
					return i
				end
			end
		
	end
	for i=0,4 do
		for j=1,GetContainerNumSlots(i) do
			_,ContainerItemName=ContainerItemNameCheck(i,j)
			if string.find(ContainerItemName or "",string.lower(name),1,1) then
				return nil,i,j
			end
		end
	end

end
end
-- Equip Item name->name, slot->slot, cd->equip trinket with cooldown > 30s 
function EquipItem(name,slot,cd)
if name and not (name == "") and not UnitAffectingCombat("player") then
	if not MerchantFrame:IsVisible() and not UnitAffectingCombat("player")then
		local a,b,s = FindItem(name,1)
			if (a~=nil and a~=slot and not IsInventoryItemLocked(13) and not IsInventoryItemLocked(14) and PvPTrinket[info][slot] ~= true) then
				if PvPTrinket[info]["spam"]==true then
					PTAlertMessageFrame:AddMessage("Trinkets Loaded", 1, 1, 1, 1, 3);
				end
				PickupInventoryItem(13)
				PickupInventoryItem(14)
				QueueTrinket[slot] = nil
			elseif ((a~=nil and a~=slot) and (IsInventoryItemLocked(13) or IsInventoryItemLocked(14)) and PvPTrinket[info][slot] ~= true) then
				QueueTrinket[slot] = name
			end
			if b~=nil and s~=nil and PvPTrinket[info][slot] ~= true then
				local c = TrinketIsReady(nil,b,s)
				local _,_,isLocked = GetContainerItemInfo(b,s)
				if (c==true or cd~=nil) and not isLocked and not IsInventoryItemLocked(slot) then
					if PvPTrinket[info]["spam"]==true then
						PTAlertMessageFrame:AddMessage("Trinkets Loaded", 1, 1, 1, 1, 3);
					end
					PickupContainerItem(b,s)
					PickupInventoryItem(slot)
					QueueTrinket[slot] = nil
				elseif (c==true or cd~=nil) and (isLocked or IsInventoryItemLocked(slot)) then
					QueueTrinket[slot] = name
				
				end
			end 
			
		end
	end
end	
--RotationEquip--
function RotationEquip(slot,cd)
	local d,_,f = GetInventoryItemCooldown("player",slot)
	local x = FindContainerRotationTrinket(1,cd)
	local z = FindContainerRotationTrinket(nil,nil)
	local y = FindInventoryRotationTrinket(slot,1,cd)
	local v = FindInventoryRotationTrinket(slot,nil,nil)
	if LockTrinket[slot] ~= true then
	--DEFAULT_CHAT_FRAME:AddMessage("A"..slot);
	if v~=nil and x~=nil then
				EquipTrinket[slot]=x
		if slot==13 then
			if EquipTrinket[14]~=nil and EquipTrinket[14]~="equip" then
				EquipItem(EquipTrinket[14],14,1)
				UseTrinket[14]="rotation"
				
				local x1 = FindContainerRotationTrinket(1)
				if x1~=nil then
					EquipItem(x1,13,1)
					UseTrinket[13]="rotation"
				end	
				
			elseif	EquipTrinket[14]=="equip" or PvPTrinket[info][14] == true then
				EquipItem(x,slot,1)
							
			end	
		elseif	slot==14 then
			if EquipTrinket[13]~=nil and EquipTrinket[13]~="equip" then
				EquipItem(EquipTrinket[13],13,1)
				UseTrinket[13]="rotation"
				
				local x2 = FindContainerRotationTrinket(1)
				if x2~=nil then
					EquipItem(x1,14,1)
					UseTrinket[14]="rotation"
				end	
					
			elseif	EquipTrinket[13]=="equip" or PvPTrinket[info][13] == true then
				EquipItem(x,slot,1)	
			end		
		end
		
	elseif v==nil and y==nil and x~=nil then
	--DEFAULT_CHAT_FRAME:AddMessage("B"..slot);
		EquipItem(x,slot,1)
		UseTrinket[slot]="rotation"
	
	elseif v==nil and y==nil and z~=nil then
	--DEFAULT_CHAT_FRAME:AddMessage("C"..slot);
		EquipItem(z,slot,1)
		UseTrinket[slot]="rotation"
	
	elseif y~=nil then
	--DEFAULT_CHAT_FRAME:AddMessage("D"..slot);
		EquipTrinket[slot]="equip"
		UseTrinket[slot]="rotation"	
		
		if slot==13 then
			if EquipTrinket[14]~=nil and EquipTrinket[14]~="equip" then
				EquipItem(EquipTrinket[14],14,1)
			end	
		elseif	slot==14 then
			if EquipTrinket[13]~=nil and EquipTrinket[13]~="equip" then
				EquipItem(EquipTrinket[13],13,1)	
			end	
		end	
		
	end
	end
end
--FindInventoryRotationTrinket--
function FindInventoryRotationTrinket(slot,active,cd)
if active~=nil then
	for i=1,30 do
		if PvPTrinket[info]["rotation"][i]~=nil then
			local a,_,_ = FindItem(PvPTrinket[info]["rotation"][i]["Trinket"],1)
				if a~=nil and a==slot then
					local c,h,e = GetInventoryItemCooldown("player",a)	
						if (TrinketIsReady(a,nil,nil)==true or cd~=nil) and e==1 then
							return PvPTrinket[info]["rotation"][i]["Trinket"],i
						end	
				end
		end
	end
else 
for i=1,30 do
		if PvPTrinket[info]["rotation"][i]~=nil then
			local a,_,_ = FindItem(PvPTrinket[info]["rotation"][i]["Trinket"],1)
				if a~=nil and a==slot then
					local c,_,e = GetInventoryItemCooldown("player",a)	
						if c==0 and e==0 then
							return PvPTrinket[info]["rotation"][i]["Trinket"],i
						end	
				end
		end
end
end
end
--FindContainerRotationTrinket--
function FindContainerRotationTrinket(active,cd)
if active~=nil then
	for i=1,30 do
		if PvPTrinket[info]["rotation"][i]~=nil then
			local _,b,s = FindItem(PvPTrinket[info]["rotation"][i]["Trinket"],1)
				if b~=nil and s~=nil then
					local c,h,e = GetContainerItemCooldown(b,s)	
					local _,_,isLocked = GetContainerItemInfo(b,s)
						if (TrinketIsReady(nil,b,s)==true or cd~=nil) and e==1 and not isLocked then
							return PvPTrinket[info]["rotation"][i]["Trinket"],i
						end	
				end
		end
	end
else 
	for i=1,30 do
			if PvPTrinket[info]["rotation"][i]~=nil then
				local _,b,s = FindItem(PvPTrinket[info]["rotation"][i]["Trinket"],1)
					if b~=nil and s~=nil then
						local c,_,e = GetContainerItemCooldown(b,s)	
						local _,_,isLocked = GetContainerItemInfo(b,s)
							if c==0 and e==0 and not isLocked then
								return PvPTrinket[info]["rotation"][i]["Trinket"],i
							end	
					end
			end
	end
end
end
--CheckTrinketsThenEquip--
function CheckTrinketsThenEquip(name,slot,cd,class)
if not UnitAffectingCombat("player") then
		if name and not (name == "") and not (name == "rotation") then
			local a,b,s = FindItem(name,1)
			EquipTrinket[slot]=nil
				if a~=nil then
					local d=TrinketIsReady(a,nil,nil)
					if d==true or cd~=nil then
						EquipItem(name,slot,cd)
						UseTrinket[slot]=class
						EquipTrinket[slot]="equip"
					elseif d==nil and cd==nil then
						RotationEquip(slot,nil)
					end	
				elseif b~=nil and s~=nil then
					local d = TrinketIsReady(nil,b,s)
					if d==true or cd~=nil then
						EquipItem(name,slot,cd)
						UseTrinket[slot]=class
						EquipTrinket[slot]="equip"
					elseif d==nil and cd==nil then
						RotationEquip(slot,nil)
					end	
				else
					--if load with cooldown is disabled and trinkets have cooldown then RotationEquip
					--DEFAULT_CHAT_FRAME:AddMessage("E"..slot);
					RotationEquip(slot,cd)
				end
			--if RotationEquip was first, detect if EquipTrinket[slot]~=nil
				if slot==13 then
					if EquipTrinket[14]~=nil and EquipTrinket[14]~="equip" then
						--DEFAULT_CHAT_FRAME:AddMessage("F"..slot);
						EquipItem(EquipTrinket[14],14,1)
						UseTrinket[14]="rotation"
					end	
				elseif  slot==14 then
					if EquipTrinket[13]~=nil and EquipTrinket[13]~="equip" then
						--DEFAULT_CHAT_FRAME:AddMessage("G"..slot);
						EquipItem(EquipTrinket[13],13,1)
						UseTrinket[13]="rotation"
					end
				end
		else
			RotationEquip(slot,cd)
		end
else
	UseTrinket[slot]=class
end
end
--UseTrinketbyClass--
function UseTrinketbyClass()
local v = UseTrinket[13]
local y = UseTrinket[14]
local s, _, k = GetInventoryItemCooldown("Player",13)
local x, _, z = GetInventoryItemCooldown("Player",14)
	
if PT_TargetIsEnemy() then
	if s==0 and k==1 then	
		local _, i = FindInventoryRotationTrinket(13,1)
		if v=="rotation" then
			if i~=nil then
				local use = PvPTrinket[info]["rotation"][i]["Use"]
				if use==true then
					LockTrinket[13] = true
					UseInventoryItem(13);
				end	
			end		
		else
			local a,_,_ = FindItem(PvPTrinket[info][v]["slot1"]["Trinket"],1)	
			if a==13 then
				local use = PvPTrinket[info][v]["slot1"]["Use"]
				if use==true then
					LockTrinket[13] = true
					UseInventoryItem(13);
				end
			elseif i~=nil then
				local use = PvPTrinket[info]["rotation"][i]["Use"]
				if use==true then
					LockTrinket[13] = true
					UseInventoryItem(13);
				end	
			end		
		end
	end	

	
	if x==0 and z==1 then
		local _, i = FindInventoryRotationTrinket(14,1)
		if y=="rotation" then
			if i~=nil then
				local use = PvPTrinket[info]["rotation"][i]["Use"]
				if use==true then
					LockTrinket[14] = true
					UseInventoryItem(14);
				end	
			end		
		else
			local a,_,_ = FindItem(PvPTrinket[info][y]["slot2"]["Trinket"],1)	
			if a==14 then
				local use = PvPTrinket[info][y]["slot2"]["Use"]
				if use==true then
					LockTrinket[14] = true
					UseInventoryItem(14);
				end
			elseif i~=nil then
				local use = PvPTrinket[info]["rotation"][i]["Use"]
				if use==true then
					LockTrinket[14] = true
					UseInventoryItem(14);
				end	
			end		
		end
	end	
end		
end
--ClassEquip if cd == true then load trinkets with cooldown
function ClassEquip(use)	

if UnitHealth("target") > 0 then
	
	if not UnitIsPlayer("target") and not UnitIsFriend("player","target") then
		CheckTrinketsThenEquip("rotation", 14, nil, "rotation");	
		CheckTrinketsThenEquip("rotation", 13, nil, "rotation");
	elseif UnitIsPlayer("target") then
		CheckTrinketsThenEquip(PvPTrinket[info][ClassCheck(UnitClass("target"))]["slot2"]["Trinket"], 14, nil, ClassCheck(UnitClass("target")));
		CheckTrinketsThenEquip(PvPTrinket[info][ClassCheck(UnitClass("target"))]["slot1"]["Trinket"], 13, nil, ClassCheck(UnitClass("target")));
	end
	
	if use~=nil then
		UseTrinketbyClass();
	elseif	UnitAffectingCombat("player") then	
		UseTrinketbyClass();
	end
end	
end
--ClassCheck--
function ClassCheck(cmd)
if string.find(string.lower(cmd), "warrior") then 
	return "warrior"
elseif 	string.find(string.lower(cmd), "paladin") then 
	return "paladin"
elseif 	string.find(string.lower(cmd), "rogue") then 
	return "rogue"
elseif 	string.find(string.lower(cmd), "hunter") then 
	return "hunter"
elseif 	string.find(string.lower(cmd), "priest") then 
	return "priest"
elseif 	string.find(string.lower(cmd), "mage") then 
	return "mage"
elseif 	string.find(string.lower(cmd), "warlock") then 
	return "warlock"
elseif 	string.find(string.lower(cmd), "shaman") then 
	return "shaman"
elseif 	string.find(string.lower(cmd), "druid") then 
	return "druid"
elseif 	string.find(string.lower(cmd), "rotation") then 
	return "rotation"
else return "*/)^]'"	
end
end
--TrinketIsReady--
function TrinketIsReady(a,b,s)
local c,h,e
if a~=nil then
	c,h,e = GetInventoryItemCooldown("player",a)
	if h-(GetTime()-c)<=30 then 
		return true
	end	
elseif b~=nil and s~=nil then
	c,h,e = GetContainerItemCooldown(b,s)
	if h-(GetTime()-c)<=30 then 
		return true
	end	
end
end
--Use Inventory Item by name--
function UseInvItembyName(name)
if name then
local a,b,s = FindItem(name,1);
	if a then
	local h,_,v = GetInventoryItemCooldown("Player",a);
		if (h==0 and v==1) then
			UseInventoryItem(a);
		end	
	end	
end
end
--ContainerItemNameCheck--
function ContainerItemNameCheck(i,j)
local itemID,itemName
_,_,itemID,itemName = string.find(GetContainerItemLink(i,j) or "","item:(%d+).+%[(.+)%]")
	if itemName then
		return string.lower(itemName), string.lower(GetContainerItemLink(i,j))
	end
end
--InventoryItemNameCheck--
function InventoryItemNameCheck(i)
local itemID,itemName
_,_,itemID,itemName = string.find(GetInventoryItemLink("player",i) or "","item:(%d+).+%[(.+)%]")
	if itemName then
		return string.lower(itemName), string.lower(GetInventoryItemLink("player",i))
	end
end
function ReturnItemLink(name)
if name and not (name == "") then	
	local a,b,c = FindItem(name,1)
	if a ~= nil then
		return GetInventoryItemLink("player",a)
	elseif b~=nil and c~=nil then
		return GetContainerItemLink(b,c)	
	elseif a==nil and b==nil and c==nil then
		return "|cffff0000"..name.." - not found"	
	end	
else
	return "empty"
end	
end
--SlotCheck--
function SlotCheck(cmd)
if string.find(string.lower(cmd), "slot1") then 
	return "slot1"
elseif 	string.find(string.lower(cmd), "slot2") then 
	return "slot2"
else return "*/)^]'"	
end
end
--UseCheck--
function UseCheck(cmd)
if string.find(string.lower(cmd), "use") then 
	return "use"
else return "*/)^]'"	
end
end
--RotationCheck--
function RotationCheck()
for i=1,30 do
	if PvPTrinket[info]["rotation"][i]==nil then
		return i
	end
end	
end
--ResetStringRead--
function ResetStringRead(msg)
	local x,y = string.find(string.lower(msg), ClassCheck(msg))
	local z,v = string.find(string.lower(msg), "all")
		
	if x~=nil and y~=nil then
		local class = string.sub(string.lower(msg), x, y)
		Reset(class);
	elseif z~=nil and v~=nil then
		Reset("all");
	end
end
--ShowStringRead--
function ShowStringRead()

	if PvPTrinket[info][14] == true then
		DEFAULT_CHAT_FRAME:AddMessage("Slot2 is Locked type /pt Lock slot2 to Unlock",0.1,0.6,0.1);
	end	
	if PvPTrinket[info][13] == true then
		DEFAULT_CHAT_FRAME:AddMessage("Slot1 is Locked type /pt Lock slot1 to Unlock",0.1,0.6,0.1);
	end
	
	local class
		DEFAULT_CHAT_FRAME:AddMessage("PVE List:",0.1,0.6,0.1)
		for	i=1,30 do
			if PvPTrinket[info]["rotation"][i]~=nil then
				DEFAULT_CHAT_FRAME:AddMessage(ReturnItemLink(PvPTrinket[info]["rotation"][i]["Trinket"])..", Use: "..tostring(PvPTrinket[info]["rotation"][i]["Use"]), 1, 1, 0.6)
			end	
		end
		DEFAULT_CHAT_FRAME:AddMessage("PVP List:",0.1,0.6,0.1)
	
		class = "mage"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
				
		class = "warlock"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
	    class = "priest"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "hunter"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "shaman"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "druid"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "rogue"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "warrior"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage("-----------------------------------------------")
		
		class = "paladin"		
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot1: "..ReturnItemLink(PvPTrinket[info][class]["slot1"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot1"]["Use"]), 1, 1, 0.6)
		DEFAULT_CHAT_FRAME:AddMessage(class.." slot2: "..ReturnItemLink(PvPTrinket[info][class]["slot2"]["Trinket"])..", Use: "..tostring(PvPTrinket[info][class]["slot2"]["Use"]), 1, 1, 0.6)
end
--AddStringRead--
function AddStringRead(msg)
	local trinket= nil
	local x,y = string.find(string.lower(msg), ClassCheck(msg))
		if (x~=nil and y~=nil) then
			local class = string.sub(string.lower(msg), x, y)
			local z,v = string.find(string.lower(msg), SlotCheck(msg))
				if (z~=nil and v~=nil) or class=="rotation" then
					local slot, h, g, use
					h,g = string.find(string.lower(msg), UseCheck(msg))
						if class=="rotation" then
							slot = RotationCheck()
							v=y
						elseif z~=nil and v~=nil then
							slot = string.sub(string.lower(msg), z, v)
						end
						if h~=nil and g~=nil then
							use = string.sub(string.lower(msg), h, g)
							v=g
						end
						local trinket = string.sub(string.lower(msg), v+2)
						if  trinket and not (trinket == "") then
							local a,b,c = FindItem(trinket,1)
									if a then
											DEFAULT_CHAT_FRAME:AddMessage(class..' '..slot..' '..GetInventoryItemLink("player",a).."...saved");
											PvPTrinket[info][class][slot]={index=nil;}
											PvPTrinket[info][class][slot]["Trinket"]=InventoryItemNameCheck(a);
												if use=="use" then
													DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Use Trinket When Ready...enabled")
													PvPTrinket[info][class][slot]["Use"]=true
												else
													PvPTrinket[info][class][slot]["Use"]=false
												end	
									elseif b then
										_,_,itemID,itemName = string.find(GetContainerItemLink(b,c) or "","item:(%d+).+%[(.+)%]")
										_,_,_,_,_,_,_,itemEquipLoc ,itemTexture = GetItemInfo(itemID or "")
										if itemEquipLoc =="INVTYPE_TRINKET" then
											DEFAULT_CHAT_FRAME:AddMessage(class..' '..slot..' '..GetContainerItemLink(b,c).."...saved");
											PvPTrinket[info][class][slot]={index=nil;}
											PvPTrinket[info][class][slot]["Trinket"]=ContainerItemNameCheck(b,c);
												if use=="use" then
													DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Use Trinket When Ready...enabled")	
													PvPTrinket[info][class][slot]["Use"]=true
												else
													PvPTrinket[info][class][slot]["Use"]=false
												end	
										else
											DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Item is not Trinket...save failed");
										end	
									else
										DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: "..class..' '..slot.." Trinket not Found...");	
									end
						else		
							DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: "..class..' '..slot..", Trinket not Found...");	
						end
				else 
					DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: "..class.." Wrong SlotID, Trinket not Found...");
				end	
		else
			DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Invalid Parameters...");
		end	
end
--IsPlayerReallyDead--
function IsPlayerReallyDead()
	local dead = UnitIsDeadOrGhost("player")
	local _,class = UnitClass("player")
	if class~="HUNTER" then
		return dead
	end
	for i=1,24 do
		if UnitBuff("player",i)=="Interface\\Icons\\Ability_Rogue_FeignDeath" then
			dead = nil 
		end
	end
	return dead
end
function IsInInstance()
	SetMapToCurrentZone();
	a,b=GetPlayerMapPosition("player");
	if(a==0 and b==0) then 
		return 1; 
	else 
		return nil; 
	end 
end
function PT_TargetIsEnemy()
	local u = "target"
	if UnitCanAttack("player", u) and not UnitIsCivilian(u) and (UnitHealth(u) > 0 or UnitExists(u.."target") or UnitAffectingCombat(u)) then
		return true
	end
	return false
end

function PT()
	ClassEquip(1);
end 
--SlashHandler--
function SlashHandler(msg)
if msg then
	if	string.find(string.lower(msg), "add") then		
		AddStringRead(msg);
	elseif string.find(string.lower(msg), "launch") then
		PT();
	elseif	string.find(string.lower(msg), "show") then
		ShowStringRead();	
	elseif	string.find(string.lower(msg), "spam") then	
		if PvPTrinket[info]["spam"]~=true then
			DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Spam...enabled");
			PvPTrinket[info]["spam"]=true
		else
			DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Spam...disabled");
			PvPTrinket[info]["spam"]=false
		end
	elseif	string.find(string.lower(msg), "reset") then	
		ResetStringRead(msg);	
	elseif ( msg == "cmd" or msg == "options" or msg == "help" or msg == "config") then
		Commands();	
	elseif	string.find(string.lower(msg), "lock") then		
		if string.find(string.lower(msg), "slot1") then
			if PvPTrinket[info][13] ~= true  then
				DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Slot1 Locked");
				PvPTrinket[info][13] = true
			elseif	PvPTrinket[info][13] == true then
				PvPTrinket[info][13] = false
				DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Slot1 UnLocked");
			end	
		elseif string.find(string.lower(msg), "slot2") then
			if PvPTrinket[info][14] ~= true then
				DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Slot2 Locked");
				PvPTrinket[info][14] = true
			elseif	PvPTrinket[info][14] == true then
				DEFAULT_CHAT_FRAME:AddMessage("PvP Trinket: Slot2 UnLocked");
				PvPTrinket[info][14] = false
			end	
		end
	end	
end
end
