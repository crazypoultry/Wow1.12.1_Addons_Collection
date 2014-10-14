--------------------------------------------------
-- BonusScanner v1.1
-- by Crowley <crowley@headshot.de>
-- performance improvements by Archarodim
--
-- get the latest version here:
-- http://ui.worldofwar.net/ui.php?id=1461
-- http://www.curse-gaming.com/mod.php?addid=2384
--
-- Modified for HealPoints by Eridan
--------------------------------------------------

HEALPOINTSBS_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
HEALPOINTSBS_PATTERN_GENERIC_PREFIX = "^%+(%d+)%%?(.*)$";
HEALPOINTSBS_PATTERN_GENERIC_SUFFIX = "^(.*)%+(%d+)%%?$";

HealPointsBS = {
	bonuses = {};
	bonuses_details = {};

    IsUpdating		    = false; -- not sure if this check is needed but who knows with multithreading...
    MinCheckInterval	    = 1;	 -- Minimum time to wait between each scan
    CheckIntervalCounter    = 0;	 -- counter, do not change
    CheckForBonusPlease	    = 0;	 -- The flag that when set makes BonusScanner scan the equipment and call the update function
    ShowDebug		    = false; -- tells when the equipment is scanned

	active = nil;
	temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = {},
		details = {}
	};

	types = {
		"INT", 			-- intellect
		"SPI", 			-- spirit

		"SPELLCRIT",	-- chance to crit with spells
		"HEAL",			-- healing 
		"HOLYCRIT", 	-- chance to crit with holy spells

		"MANAREG",		-- mana regeneration per 5 sec.
		"MANA",			-- mana points

		-- Added
		"CASTINGREG", 		-- % mana regeneration while casting 			
		"NATURECRIT", 		-- chance to crit with nature spells      
		"CASTINGREGROWTH", 	-- reduced casting time Regrowth     
		"CASTINGHOLYLIGHT", -- reduced casting time Holy Light
		"CASTINGHEALINGTOUCH", -- reduced casting time Healing Touch
		"CASTINGFLASHHEAL", -- reduced casting time Flash Heal
		"CASTINGCHAINHEAL", -- reduced casting time Chain Heal
		"DURATIONREJUV",  	-- increased duration Rejuvenation  
		"DURATIONRENEW",    -- increased duration Renew
		"MANAREGNORMAL",	-- normal mana regeneration per 5 sec.
		"IMPCHAINHEAL",     -- increased effect from chain heal jumps
		"IMPREJUVENATION",  -- increased effect from Rejuvenation
		"IMPLESSERHEALINGWAVE", -- increased effect from Lesser Healing Wave
		"IMPFLASHOFLIGHT",  -- increased effect from Flash of Light
		"REFUNDHEALINGWAVE",-- chance for mana refund on (Lesser) Healing Wave cast
		"JUMPHEALINGWAVE",	-- Healing Wave jumps to nearby targets
		"REFUNDHTCRIT",    	-- Refund of % mana on HT crits
		"CHEAPERDRUID",		-- Cheaper druids spells by %
		"CHEAPERRENEW",		-- Cheaper Renew by %
		"GHEALRENEW"		-- Greater Heal also gives Renew effect
  };

	slots = {
		"Head",
		"Neck",
		"Shoulder",
		"Shirt",
		"Chest",
		"Waist",
		"Legs",
		"Feet",
		"Wrist",
		"Hands",
		"Finger0",
		"Finger1",
		"Trinket0",
		"Trinket1",
		"Back",
		"MainHand",
		"SecondaryHand",
		"Ranged",
		"Tabard",
	};
}

local slotConvert = {	
            INVTYPE_HEAD = "Head", 			INVTYPE_NECK = "Neck", 					INVTYPE_SHOULDER = "Shoulder", 				INVTYPE_BODY = "Shirt",
            INVTYPE_CHEST = "Chest", 		INVTYPE_ROBE = "Chest", 				INVTYPE_WAIST = "Waist", 					INVTYPE_LEGS = "Legs",
            INVTYPE_FEET = "Feet", 			INVTYPE_WRIST = "Wrist", 				INVTYPE_HAND = "Hands", 					INVTYPE_FINGER = "Finger0",
            INVTYPE_TRINKET = "Trinket0", 	INVTYPE_CLOAK = "Back", 				INVTYPE_WEAPON = "MainHand", 				INVTYPE_SHIELD = "SecondaryHand",
            INVTYPE_2HWEAPON = "MainHand", 	INVTYPE_WEAPONMAINHAND = "MainHand",	INVTYPE_WEAPONOFFHAND = "SecondaryHand",	INVTYPE_HOLDABLE = "SecondaryHand",	
            INVTYPE_RANGED = "Ranged",		INVTYPE_THROWN = "Ranged", 				INVTYPE_RANGEDRIGHT = "Ranged", 			INVTYPE_TABARD = "Tabard" ,
            INVTYPE_RELIC = "Ranged"}; 
              
function HealPointsBS:Debug( Message ) 
	-- A little debug function
    if (HealPointsBS.ShowDebug) then
		DEFAULT_CHAT_FRAME:AddMessage("HealPoints-Bonnus-Scanner: " .. Message, 0.5, 0.8, 1);
	end	
end

function HealPointsBS:ScanEquipment() 
	local slotid, slotname, hasItem, i;

	HealPointsBSTooltip:SetOwner(UIParent, "ANCHOR_NONE");

  HealPointsBS:Debug("Scanning Equipment has requested");

	HealPointsBS.temp.bonuses = {};
	HealPointsBS.temp.details = {};
	HealPointsBS.temp.sets = {};
	HealPointsBS.temp.set = "";

	for i, slotname in pairs(HealPointsBS.slots) do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		hasItem = HealPointsBSTooltip:SetInventoryItem("player", slotid);
	
		if ( hasItem ) then
			HealPointsBS.temp.slot = slotname;
			HealPointsBS:ScanTooltip(HealPointsBSTooltip, true, true);
			-- if set item, mark set as already scanned
			if(HealPointsBS.temp.set ~= "") then
				HealPointsBS.temp.sets[HealPointsBS.temp.set] = 1;
			end;
		end
	end
	HealPointsBS.bonuses = HealPointsBS.temp.bonuses;
	HealPointsBS.bonuses_details = HealPointsBS.temp.details;
end

function HealPointsBS:ScanTooltip(frame, includeSet, includeEnchant) 
	local tmpTxt, line, r, g, b;
	local lines = frame:NumLines();

	for i=2, lines, 1 do
		tmpText = getglobal(frame:GetName().."TextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			line = tmpText:GetText();      
      r, g, b = tmpText:GetTextColor();
      if (not includeEnchant and r == 0 and g > 0.99 and b == 0) then
        HealPointsBS:ScanLine(line, includeSet, false);
      else
        HealPointsBS:ScanLine(line, includeSet, true);
      end
		end
	end
end

function HealPointsBS:AddValue(effect, value) 
	local i,e;
	
	if(type(effect) == "string") then
		if(HealPointsBS.temp.bonuses[effect]) then
			HealPointsBS.temp.bonuses[effect] = HealPointsBS.temp.bonuses[effect] + value;
		else
			HealPointsBS.temp.bonuses[effect] = value;
		end
		
		if(HealPointsBS.temp.slot) then
			if(HealPointsBS.temp.details[effect]) then
				if(HealPointsBS.temp.details[effect][HealPointsBS.temp.slot]) then
					HealPointsBS.temp.details[effect][HealPointsBS.temp.slot] = HealPointsBS.temp.details[effect][HealPointsBS.temp.slot] + value;
				else
					HealPointsBS.temp.details[effect][HealPointsBS.temp.slot] = value;
				end
			else
				HealPointsBS.temp.details[effect] = {};
				HealPointsBS.temp.details[effect][HealPointsBS.temp.slot] = value;
			end
		end;
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in pairs(effect) do
				HealPointsBS:AddValue(e, value[i]);
			end
		else
			for i,e in pairs(effect) do
				HealPointsBS:AddValue(e, value);
			end
		end
	end
end;

function HealPointsBS:ScanLine(line, includeSet, includeEnchant) 
	local tmpStr, found;
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(HEALPOINTSBS_PREFIX_EQUIP)) == HEALPOINTSBS_PREFIX_EQUIP) then

		tmpStr = string.sub(line,string.len(HEALPOINTSBS_PREFIX_EQUIP)+1);
		HealPointsBS:CheckPassive(tmpStr);

	-- Check for "Set: "
	elseif(includeSet ~= false and string.sub(line,0,string.len(HEALPOINTSBS_PREFIX_SET)) == HEALPOINTSBS_PREFIX_SET
			and HealPointsBS.temp.set ~= "" 
			and not HealPointsBS.temp.sets[HealPointsBS.temp.set]) then

		tmpStr = string.sub(line,string.len(HEALPOINTSBS_PREFIX_SET)+1);
		HealPointsBS.temp.slot = "Set";
		HealPointsBS:CheckPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	elseif (includeEnchant == true) then
		-- Check for set name
		_, _, tmpStr = string.find(line, HEALPOINTSBS_PATTERN_SETNAME);
		if(tmpStr) then
			HealPointsBS.temp.set = tmpStr;
		else
			found = HealPointsBS:CheckGeneric(line);
			if(not found) then
				HealPointsBS:CheckOther(line);
			end;
		end
--  else
--		DEFAULT_CHAT_FRAME:AddMessage("Ignoring " .. line, 0.5, 0.8, 1);
  end
end;


function HealPointsBS:CheckPassive(line) 
	-- Scans passive bonuses like "Set: " and "Equip: "
	local i, p, value, found;

	found = nil;
	for i,p in pairs(HEALPOINTSBS_PATTERNS_PASSIVE) do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			HealPointsBS:AddValue(p.effect, value)
			found = 1;
			break; -- prevent duplicated patterns to cause bonuses to be counted several times
		end
	end
	if(not found) then
		HealPointsBS:Debug("\"" .. line .. "\"");
		HealPointsBS:CheckGeneric(line);
	end
end


function HealPointsBS:CheckGeneric(line) 
	-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
	local value, token, pos, tmpStr, found;

	-- split line at "/" for enchants with multiple effects
	found = false;
	while(string.len(line) > 0) do
		pos = string.find(line, "/", 1, true);
		if(pos) then
			tmpStr = string.sub(line,1,pos-1);
			line = string.sub(line,pos+1);
		else
			tmpStr = line;
			line = "";
		end

		-- trim line
	    tmpStr = string.gsub( tmpStr, "^%s+", "" );
   	    tmpStr = string.gsub( tmpStr, "%s+$", "" );
       	tmpStr = string.gsub( tmpStr, "%.$", "" );

		_, _, value, token = string.find(tmpStr, HEALPOINTSBS_PATTERN_GENERIC_PREFIX);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, HEALPOINTSBS_PATTERN_GENERIC_SUFFIX);
		end
		if(token and value) then
			-- trim token
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	       	token = string.gsub( token, "%.$", "" );
	
			if(HealPointsBS:CheckToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


function HealPointsBS:CheckToken(token, value) 
	-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
	-- add the value to the respective bonus. 
	-- returns true if some bonus is found
	local i, p, s1, s2;
	
	if(HEALPOINTSBS_PATTERNS_GENERIC_LOOKUP[token]) then
		HealPointsBS:AddValue(HEALPOINTSBS_PATTERNS_GENERIC_LOOKUP[token], value);
		return true;
	end
	return false;
end

function HealPointsBS:CheckOther(line) 
	-- Last fallback for non generic enchants, like "Mana Regen x per 5 sec."
	local i, p, value, start, found;

	for i,p in pairs(HEALPOINTSBS_PATTERNS_OTHER) do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				HealPointsBS:AddValue(p.effect, p.value)
			elseif(value) then
				HealPointsBS:AddValue(p.effect, value)
			end
			return true;
		end
	end
	return false;
end

-- Global functions
function HealPointsBS:update()
	-- Update function to hook into. 
	-- Gets called, when Equipment changes (after UNIT_INVENTORY_CHANGED)
end

function HealPointsBS:GetBonus(bonus)
	if(HealPointsBS.bonuses[bonus]) then
		if (type(HealPointsBS.bonuses[bonus]) == "string") then
			return tonumber(HealPointsBS.bonuses[bonus]);
		else
			return HealPointsBS.bonuses[bonus];
		end
	end;
	return 0;
end

function HealPointsBS:GetSlotBonuses(slotname)
	local i, bonus, details;
	local bonuses = {};
	for bonus, details in pairs(HealPointsBS.bonuses_details) do
		if(details[slotname]) then
			bonuses[bonus] = details[slotname];
		end
	end
	return bonuses;
end

function HealPointsBS:ScanItem(frame, includeSet, includeEnchant)
	HealPointsBS.temp.bonuses = {};
	HealPointsBS.temp.sets = {};
	HealPointsBS.temp.set = "";
	HealPointsBS.temp.slot = "";
	HealPointsBS:ScanTooltip(frame, includeSet, includeEnchant);
	return HealPointsBS.temp.bonuses;
end

-- Event functions
function HealPointsBS:OnLoad()
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("PLAYER_LEAVING_WORLD");
end

function HealPointsBS:OnEvent()

    HealPointsBS:Debug(event);

    if ((event == "UNIT_INVENTORY_CHANGED") and HealPointsBS.active) then
		HealPointsBS.CheckForBonusPlease = 1;
	return;
    end
	if (event == "PLAYER_ENTERING_WORLD") then
		HealPointsBS.active = 1;
		HealPointsBS.CheckForBonusPlease = 1;
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
	return;
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		return;
    end	
end

function HealPointsBS:OnUpdate (elapsed)
	-- The use of the <OnUpdate></OnUpdate> *feature* avoid freezes and lags caused by the useless repeated call of BonusScanner:ScanEquipment()...

    -- BonusScanner:Debug(elapsed);
    if (HealPointsBS.IsUpdating) then
		return;
    end

    HealPointsBS.IsUpdating = true;

    -- if the equipment has changed then check if we are allowed to test for bonuses
    if (HealPointsBS.CheckForBonusPlease == 1) then

	HealPointsBS.CheckIntervalCounter = HealPointsBS.CheckIntervalCounter + elapsed;

	-- if we have wait long enough then proceed...
	if (HealPointsBS.CheckIntervalCounter > HealPointsBS.MinCheckInterval) then
	    HealPointsBS.CheckForBonusPlease = 2; -- means we are currently checking
	    HealPointsBS:ScanEquipment(); -- scan the equiped items
	    HealPointsBS:update();	  -- call the update function (for the mods using this library)
	    if (HealPointsBS.CheckForBonusPlease ~= 1) then -- if no other update has been requested
			HealPointsBS.CheckForBonusPlease = 0;
	    end
	    HealPointsBS.CheckIntervalCounter = 0;
	end
    end

    HealPointsBS.IsUpdating = false;
end

function HealPointsBS:isEnchanted(frame)
  for i=1,frame:NumLines() do
    local mytext = getglobal(frame:GetName().."TextLeft"..i);
    local text = mytext:GetText();
    local r, g, b, a = mytext:GetTextColor();
    if (r == 0 and g > 0.99 and b == 0) then
      if (string.sub(text, 0, string.len(HEALPOINTSBS_PREFIX_EQUIP)) ~= HEALPOINTSBS_PREFIX_EQUIP and
          string.sub(text, 0, string.len(HEALPOINTSBS_PREFIX_SET)) ~= HEALPOINTSBS_PREFIX_SET and 
          string.sub(text, 0, string.len(HEALPOINTSBS_PREFIX_USE)) ~= HEALPOINTSBS_PREFIX_USE) then
        return true;
      end
    end
  end
  return false;
end

function HealPointsBS:getItemSlotBonuses(frame, itemLink)
  if (type(itemLink) == "string" ) then
    _,_, itemLink = string.find(itemLink, "item:(%d+):");
  end

  local _, _, _, _, _, _, _, itemEquipLoc = GetItemInfo(itemLink);	
  local slotName = slotConvert[itemEquipLoc];	
  if (slotName == nil) then
    return nil;
  end

  local isEnchanted = self:isEnchanted(frame);
  
  local itemBonuses = HealPointsBS:ScanItem(frame, false, true);
  local slotBonuses; 
  if (not isEnchanted) then
		local slotid, _ = GetInventorySlotInfo(slotName.. "Slot");
		local hasItem = HealPointsBSTooltip:SetInventoryItem("player", slotid);
    slotBonuses = HealPointsBS:ScanItem(HealPointsBSTooltip, false, false);
  else
    slotBonuses = HealPointsBS:GetSlotBonuses(slotName);
  end

  if (itemEquipLoc == "INVTYPE_2HWEAPON") then -- 2hander replaces 1hander + shield/offhand
    local slotBonuses2 = HealPointsBS:GetSlotBonuses("SecondaryHand");
    table.foreach(slotBonuses2, function(index, value)
      if (slotBonuses[index] == nil) then
        slotBonuses[index] = value;
      else
        slotBonuses[index] = slotBonuses[index] + value;
      end
    end);
  end
  if (slotName == "SecondaryHand") then -- shield/offhand replaces 2hander
    local mainHandLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
    if (mainHandLink ~= nil) then
      local _, _, itemCode = strfind(mainHandLink, "(%d+):")
      local _, _, _, _, _, _, _, loc = GetItemInfo(itemCode);
      if (loc == "INVTYPE_2HWEAPON") then
        slotBonuses = HealPointsBS:GetSlotBonuses("MainHand");			
      end
    end
  end
  if (slotName == "Finger0") then
    return itemBonuses, slotBonuses, HealPointsBS:GetSlotBonuses("Finger1");
  elseif (slotName == "Trinket0") then
    return itemBonuses, slotBonuses, HealPointsBS:GetSlotBonuses("Trinket1");
  else
    return itemBonuses, slotBonuses;
  end
end
  
