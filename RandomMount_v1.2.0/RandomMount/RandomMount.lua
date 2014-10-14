RANDOM_MOUNT_VERSION = "1.2.0";

--initialized saved variables
rmData = { };
	rmData.display_mounting = true;
	

BINDING_HEADER_RANDOMMOUNT = "Random Mount";
BINDING_NAME_RMMOUNT = "Mount/Dismount";

RANDOM_MOUNT_MountDef = {
	--Mount Titles
	"Pinto",
	"Brown Horse",
	"Black Stallion",
	"Chestnut Mare",
	"Swift Palomino",
	"Swift White Steed",
	"Swift Brown Steed",
	"Unpainted Mechanostrider",
	"Red Mechanostrider",
	"Blue Mechanostrider",
	"Green Mechanostrider",
	"Swift Green",
	"Mechanostrider",
	"Swift Yellow Mechanostrider",
	"Swift White Mechanostrider",
	"Riding Spotted Frostsaber",
	"Riding Striped Frostsaber",
	"Riding Striped Nightsaber",
	"Swift Mistsaber",
	"Swift Stormsaber",
	"Swift Frostsaber",
	"White Riding Ram",
	"Brown Ram",
	"Gray Ram",
	"Swift Gray Ram",
	"Swift Brown Ram",
	"Swift White Ram",
	"Brown Riding Kodo",
	"Gray Riding Kodo",
	"Great Gray Kodo",
	"Great White Kodo",
	"Great Brown Kodo",
	"Violet Raptor",
	"Emerald Raptor",
	"Turquoise Raptor",
	"Swift Blue Raptor",
	"Swift Olive Raptor",
	"Swift Orange Raptor",
	"Red Skeletal Horse",
	"Blue Skeletal Horse",
	"Brown Skeletal Horse",
	"Purple Skeletal Horse",
	"Green Skeletal Horse",
	"Dire Riding Wolf",
	"Timber Riding Wolf",
	"Brown Riding Wolf",
	"Horn of the Swift Brown Wolf",
	"Horn of the Swift Timber Wolf",
	"Horn of the Swift Gray Wolf",
	"Warhorse",
	"Charger",
	"Summon Warhorse",
	"Summon Charger",
	"Felsteed",
	"Dreadsteed",
	"Summon Felsteed",
	"Summon Dreadsteed",
	"Stormpike Riding Ram",
	"Frostwolf Riding Wolf",
	"Black War Steed",
	"Red Skeletal Warhorse",
	"Black War Tiger",
	"Black War Wolf",
	"Horn of the Black War Wolf",
	"Black War Ram",
	"Horn of the Black War Ram",
	"Black War Kodo",
	"Black Battlestrider",
	"Black War Raptor",
	"Swift Zulian Tiger",
	"Reins of the Black War Tiger",
	"Reins of the Frostsaber",
	"Reins of the Swift Frostsaber",
	"Reins of the Swift Mistsaber",
	"Reins of the Swift Stormsaber",
	"Reins of the Winterspring Frostsaber",
	"Reins of the Spotted Frostsaber",
	"Reins of the Striped Frostsaber",
	"Reins of the Striped Nightsaber",
	"Black War Steed Bridle",
	--Buff Titles
	"Swift Brown Wolf",
	"Swift Timber Wolf",
	"Swift Gray Wolf"
};

RANDOM_MOUNT_MountDefAQ = {
	-- Mount Titles
	"Blue Qiraji Resonating Crystal",
	"Green Qiraji Resonating Crystal",
	"Red Qiraji Resonating Crystal",
	"Yellow Qiraji Resonating Crystal",
	-- Buff Titles
	"Summon Blue Qiraji Battle Tank",
	"Summon Green Qiraji Battle Tank",
	"Summon Red Qiraji Battle Tank",
	"Summon Yellow Qiraji Battle Tank"
};


RANDOM_MOUNT_mountList = {};
RANDOM_MOUNT_mountListAQ = {};

function RANDOM_MOUNT_initialize()
	function CastTime_OnLoad()
	this:RegisterEvent("VARIABLES_LOADED");
end
	SlashCmdList["RANDOMMOUNT"] = RANDOM_MOUNT_go;
	SLASH_RANDOMMOUNT1 = "/randommount";
	SLASH_RANDOMMOUNT2 = "/mount";
	
	UIErrorsFrame:AddMessage("RandomMount v"..RANDOM_MOUNT_VERSION.." Addon Loaded", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
end

function RANDOM_MOUNT_OnEvent()
	if(event == "VARIABLES_LOADED") then
		-- variables loaded
	end
end


function RANDOM_MOUNT_go(msg)

	if(msg == "" or msg == nil) then
		local mountBuff, useAQ;
		useAQ = false;
		mountBuff = RANDOM_MOUNT_getMountBuff();
		if(mountBuff < 0) then
			-- if not mounted
			RANDOM_MOUNT_BuildMountList();
			mCount = table.getn(RANDOM_MOUNT_mountListAQ);
			--check if in aq before deciding if we have any AQ40 mounts
			if(GetRealZoneText() == "Ahn'Qiraj") then
				useAQ = true;
			end
			if(mCount > 0 and useAQ == true) then
				--if has aq40 mount, don't do anything else
			else
				--if not in aq40 and don't have aq40 mount, get normal mount table count
				mCount = table.getn(RANDOM_MOUNT_mountList);
			end
			if(mCount > 0) then
				mSelect = random(1,mCount);
				if(useAQ) then
					--mount using AQ40 Mount
					if(rmData.display_mounting) then
						UIErrorsFrame:AddMessage("Mounting "..RANDOM_MOUNT_mountListAQ[mSelect][1].."...", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
					end
					UseContainerItem(RANDOM_MOUNT_mountListAQ[mSelect][2],RANDOM_MOUNT_mountListAQ[mSelect][3]);
				else
					--mount using Normal Mount
					if(RANDOM_MOUNT_mountList[mSelect][4] == "item") then
						if(rmData.display_mounting) then
							UIErrorsFrame:AddMessage("Mounting "..RANDOM_MOUNT_mountList[mSelect][1].."...", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
						end
						UseContainerItem(RANDOM_MOUNT_mountList[mSelect][2],RANDOM_MOUNT_mountList[mSelect][3]);
					elseif(RANDOM_MOUNT_mountList[mSelect][4] == "spell") then
						if(rmData.display_mounting) then
							UIErrorsFrame:AddMessage("Casting "..RANDOM_MOUNT_mountList[mSelect][1].."...", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
						end
						CastSpell(RANDOM_MOUNT_mountList[mSelect][2],"spell");
					end
				end
			else
				UIErrorsFrame:AddMessage("Unable to find a mount! Do you have one?", 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME);
			end
		else
			-- if already mounted
			CancelPlayerBuff(mountBuff);
		end
	else
		--handle slash commands
		RANDOM_MOUNT_cmdHandler(msg)
	end
end

function RANDOM_MOUNT_BuildMountList()
  RANDOM_MOUNT_mountList = {};
  RANDOM_MOUNT_mountListAQ = {};
  for bag=0,4 do
   for slot=1,GetContainerNumSlots(bag) do
     if (GetContainerItemLink(bag,slot)) then
       local itemName, itemLink, itemQuality, itemLevel,
          itemType, itemSubType, itemCount, 
	      itemTexture = RANDOM_MOUNT_GetItemInfoFromItemLink(GetContainerItemLink(bag,slot));
		if(RANDOM_MOUNT_isMount(itemName)) then
			--insert into normal mount table
			table.insert(RANDOM_MOUNT_mountList, {itemName, bag, slot,"item"});
		elseif(RANDOM_MOUNT_isMountAQ(itemName)) then
			--insert into AQ mount table
			table.insert(RANDOM_MOUNT_mountListAQ, {itemName, bag, slot,"item"});
		end
     end
   end
  end
  --check class and if, warlock or pally, check spellbook for summonable mounts and for player lvl
  if(RANDOM_MOUNT_getClass() == "WARLOCK" or RANDOM_MOUNT_getClass() == "PALADIN") then
		local spellID, spellName = RANDOM_MOUNT_getMountSpellID();
		if(spellID > 0) then
			table.insert(RANDOM_MOUNT_mountList, {spellName, spellID, 0,"spell"});
		end
  end
end


function RANDOM_MOUNT_GetItemInfoFromItemLink(link)
 local itemId = nil;
 if ( type(link) == "string" ) then
   _,_, itemId = string.find(link, "item:(%d+):");
   if(itemId) then
     return GetItemInfo(itemId);
   end
 end
end

function RANDOM_MOUNT_isMount(itemName)
	local rmIndex = nil;
  if ( type(itemName) == "string" ) then
     for rmIndex=1,table.getn(RANDOM_MOUNT_MountDef) do
        if( itemName == RANDOM_MOUNT_MountDef[rmIndex]) then
			return true;
		end
     end
	 return false;
  end
  return false;
end

function RANDOM_MOUNT_isMountAQ(itemName)
	local rmIndex = nil;
  if ( type(itemName) == "string" ) then
     for rmIndex=1,table.getn(RANDOM_MOUNT_MountDefAQ) do
        if( itemName == RANDOM_MOUNT_MountDefAQ[rmIndex]) then
			return true;
		end
     end
	 return false;
  end
  return false;
end


function RANDOM_MOUNT_getMountBuff()
	local text, buffIndex, UnitCancelled;
	
	for i = 0,23 do
		buffIndex, untilCancelled = GetPlayerBuff(i, "HELPFUL|PASSIVE");
		if(buffIndex < 0) then
			return -1;
		elseif(untilCancelled) then
			rmbToolTip:SetOwner(UIParent, "ANCHOR_NONE");
			rmbToolTip:SetPlayerBuff(buffIndex);
			if (rmbToolTipTextLeft1:IsShown()) then
				text = rmbToolTipTextLeft1:GetText();
				rmbToolTip:Hide();
				if(RANDOM_MOUNT_isMount(text) or RANDOM_MOUNT_isMountAQ(text)) then
					return buffIndex;
				end
			end
		end
	end
	rmbToolTip:Hide();
	return -1;
end

function RANDOM_MOUNT_getClass()
	local _,theClass = UnitClass("player");
	return theClass;
end

function RANDOM_MOUNT_getMountSpellID()
	local i,j;
	local SUMMONABLES = {
		--order of priority, first check epic, then normal mount
		"Charger",
		"Warhorse",
		"Dreadsteed",
		"Felsteed",
		"Summon Charger",
		"Summon Warhorse",
		"Summon Dreadsteed",
		"Summon Felsteed"
	};
	for i=1,500 do
		local name, rank = GetSpellName(i, "spell");
		if(not name) then
			break;
		else
			for j=1,table.getn(SUMMONABLES) do
				if(name == SUMMONABLES[j]) then
					return i,name;
				end
			end
		end
	end
	return 0;
end


function RANDOM_MOUNT_cmdHandler(msg)
	if(msg == "help") then
		DEFAULT_CHAT_FRAME:AddMessage("--------------------------------------------", 1.0,1.0,1.0,1.0);
		DEFAULT_CHAT_FRAME:AddMessage("RandomMount v"..RANDOM_MOUNT_VERSION, 1.0,1.0,1.0,1.0);
		DEFAULT_CHAT_FRAME:AddMessage("--------------------------------------------", 1.0,1.0,1.0,1.0);
		DEFAULT_CHAT_FRAME:AddMessage("/mount            (mount/dismount)", 1.0,1.0,1.0,1.0);
		DEFAULT_CHAT_FRAME:AddMessage("/mount display  (toggles 'displaying mounting')", 1.0,1.0,1.0,1.0);
		DEFAULT_CHAT_FRAME:AddMessage("/mount help     (this message)", 1.0,1.0,1.0,1.0);
	elseif(msg == "display") then
		rmData.display_mounting = not rmData.display_mounting
		if(rmData.display_mounting) then
			DEFAULT_CHAT_FRAME:AddMessage("[RandomMount] Display Mounting Message: ON", 1.0,1.0,1.0,1.0);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[RandomMount] Display Mounting Message: OFF", 1.0,1.0,1.0,1.0);
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Type '/mount help' for a list of commands.", 1.0,1.0,1.0,1.0);
	end
end
