--------------------------------------------------
-- This is a cut version on BonusScanner
-- Healbot only cares about heals and although BonusScanner is a great addon, it lags when everts are fired.
--
-- Original BonusScanner here:
-- http://www.curse-gaming.com/mod.php?addid=2384
--------------------------------------------------

HB_BONUSSCANNER_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
HB_BONUSSCANNER_PATTERN_GENERIC_PREFIX = "^%+(%d+)%%?(.*)$";
HB_BONUSSCANNER_PATTERN_GENERIC_SUFFIX = "^(.*)%+(%d+)%%?$";

HealBot_BonusScanner = {
	bonuses = 0;
        IsUpdating = false;
	ShowDebug = false; -- tells when the equipment is scanned
	active = nil;
	temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = 0,
		details = {}
	};

	types = {
		"HEAL",			-- healing 
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

function HealBot_BonusScanner:GetBonus()
	if(HealBot_BonusScanner.bonuses) then
		return HealBot_BonusScanner.bonuses;
	end;
        return 0;
end


function HealBot_BonusScanner_Update()

    if (HealBot_BonusScanner.IsUpdating) then
	return;
    else
      HealBot_BonusScanner.IsUpdating = true;
      HealBot_BonusScanner:ScanEquipment();
    end
    HealBot_BonusScanner.IsUpdating = false;
end

function HealBot_BonusScanner:ScanEquipment()
	local slotid, slotname, hasItem, i;

    HealBot_BonusTooltip:SetOwner(HealBot_BonusTooltip, "ANCHOR_NONE");
	HealBot_BonusScanner.temp.bonuses = 0;
	HealBot_BonusScanner.temp.sets = {};
	HealBot_BonusScanner.temp.set = "";
	for i, slotname in ipairs(HealBot_BonusScanner.slots) do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		hasItem = HealBot_BonusTooltip:SetInventoryItem("player", slotid);
		if ( hasItem ) then
			HealBot_BonusScanner.temp.slot = slotname;
			HealBot_BonusScanner:ScanTooltip();
			if(HealBot_BonusScanner.temp.set ~= "") then
				HealBot_BonusScanner.temp.sets[HealBot_BonusScanner.temp.set] = 1;
			end;
		end
	end
	HealBot_BonusScanner.bonuses = HealBot_BonusScanner.temp.bonuses;
end

function HealBot_BonusScanner:ScanTooltip()
	local tmpTxt, line;
	local lines = HealBot_BonusTooltip:NumLines();
	for i=2, lines, 1 do
		tmpText = getglobal("HealBot_BonusTooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			line = tmpText:GetText();
			HealBot_BonusScanner:ScanLine(line);
		end
	end
end

function HealBot_BonusScanner:AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
      if effect=="HEAL" then
		if(HealBot_BonusScanner.temp.bonuses) then
			HealBot_BonusScanner.temp.bonuses = HealBot_BonusScanner.temp.bonuses + value;
		else
			HealBot_BonusScanner.temp.bonuses = value;
		end
      end
	else 
		if(type(value) == "table") then
			for i,e in ipairs(effect) do
				HealBot_BonusScanner:AddValue(e, value[i]);
			end
		else
			for i,e in ipairs(effect) do
				HealBot_BonusScanner:AddValue(e, value);
			end
		end
	end
end;

function HealBot_BonusScanner:ScanLine(line)
	local tmpStr, found;
	if(string.sub(line,0,string.len(HB_BONUSSCANNER_PREFIX_EQUIP)) == HB_BONUSSCANNER_PREFIX_EQUIP) then
		tmpStr = string.sub(line,string.len(HB_BONUSSCANNER_PREFIX_EQUIP)+1);
		HealBot_BonusScanner:CheckPassive(tmpStr);
	elseif(string.sub(line,0,string.len(HB_BONUSSCANNER_PREFIX_SET)) == HB_BONUSSCANNER_PREFIX_SET
		and HealBot_BonusScanner.temp.set ~= "" 
		and not HealBot_BonusScanner.temp.sets[HealBot_BonusScanner.temp.set]) then
		tmpStr = string.sub(line,string.len(HB_BONUSSCANNER_PREFIX_SET)+1);
		HealBot_BonusScanner.temp.slot = "Set";
		HealBot_BonusScanner:CheckPassive(tmpStr);
	else
		_, _, tmpStr = string.find(line, HB_BONUSSCANNER_PATTERN_SETNAME);
		if(tmpStr) then
			HealBot_BonusScanner.temp.set = tmpStr;
		else
			found = HealBot_BonusScanner:CheckGeneric(line);
			if(not found) then
				HealBot_BonusScanner:CheckOther(line);
			end;
		end
	end
end;

function HealBot_BonusScanner:CheckPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in ipairs(HB_BONUSSCANNER_PATTERNS_PASSIVE) do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			HealBot_BonusScanner:AddValue(p.effect, value)
			found = 1;
		end
	end
	if(not found) then
		HealBot_BonusScanner:CheckGeneric(line);
	end
end

function HealBot_BonusScanner:CheckGeneric(line)
	local value, token, pos, tmpStr, found;
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

	    tmpStr = string.gsub( tmpStr, "^%s+", "" );
   	    tmpStr = string.gsub( tmpStr, "%s+$", "" );
       	tmpStr = string.gsub( tmpStr, "%.$", "" );

		_, _, value, token = string.find(tmpStr, HB_BONUSSCANNER_PATTERN_GENERIC_PREFIX);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, HB_BONUSSCANNER_PATTERN_GENERIC_SUFFIX);
		end
		if(token and value) then
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	       	token = string.gsub( token, "%.$", "" );
			if(HealBot_BonusScanner:CheckToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end

function HealBot_BonusScanner:CheckToken(token, value)
	local i, p, s1, s2;
	
	if(HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token]) then
		HealBot_BonusScanner:AddValue(HB_BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token], value);
		return true;
	end
	return false;
end

function HealBot_BonusScanner:CheckOther(line)
	local i, p, value, start, found;

	for i,p in ipairs(HB_BONUSSCANNER_PATTERNS_OTHER) do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				HealBot_BonusScanner:AddValue(p.effect, p.value)
			elseif(value) then
				HealBot_BonusScanner:AddValue(p.effect, value)
			end
			return true;
		end
	end
	return false;
end
