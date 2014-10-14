
--Stripped down version of BonusScanner by CrowleyAJ
--http://ui.worldofwar.net/ui.php?id=1461

if not IsAddOnLoaded("BonusScanner") then

local eventFrame = CreateFrame("Frame");


BONUSSCANNER_PATTERN_SETNAME = "^(.*) %(%d/%d%)$";
BONUSSCANNER_PATTERN_GENERIC_PREFIX = "^%+(%d+)%%?(.*)$";
BONUSSCANNER_PATTERN_GENERIC_SUFFIX = "^(.*)%+(%d+)%%?$";

GroupHeal_BonusScanner = {
	bonuses = {};
	bonuses_details = {};

	temp = { 
		sets = {},
		set = "",
		slot = "",
		bonuses = {},
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

local BonusScanner = GroupHeal_BonusScanner;
local BonusScannerTooltip = GroupHeal_Tooltip;

function BonusScanner:GetBonus(bonus)
	if(BonusScanner.bonuses[bonus]) then
		return BonusScanner.bonuses[bonus];
	end;
	return 0;
end

function BonusScanner:OnEvent( event )
	if (event == "PLAYER_ENTERING_WORLD") then
		this:RegisterEvent("UNIT_INVENTORY_CHANGED");
		BonusScanner:ScanEquipment();
		BonusScanner_Update();
	end
	if ( event == "UNIT_INVENTORY_CHANGED" and arg1 == "player" ) then
		BonusScanner:ScanEquipment();
		BonusScanner_Update();
	end
	if (event == "PLAYER_LEAVING_WORLD") then
		this:UnregisterEvent("UNIT_INVENTORY_CHANGED");
	end	
end

eventFrame:SetScript("OnEvent", function() BonusScanner:OnEvent(event); end);
eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
eventFrame:RegisterEvent("PLAYER_LEAVING_WORLD");


function BonusScanner:ScanEquipment()
	local slotid, slotname, hasItem, i;

	BonusScannerTooltip:SetOwner(GroupHealFrame, "ANCHOR_NONE");

	BonusScanner.temp.bonuses = {};
	BonusScanner.temp.details = {};
	BonusScanner.temp.sets = {};
	BonusScanner.temp.set = "";

	for i, slotname in BonusScanner.slots do
		slotid, _ = GetInventorySlotInfo(slotname.. "Slot");
		hasItem = BonusScannerTooltip:SetInventoryItem("player", slotid);
	
		if ( hasItem ) then
			BonusScanner.temp.slot = slotname;
			BonusScanner:ScanTooltip();
			-- if set item, mark set as already scanned
			if(BonusScanner.temp.set ~= "") then
				BonusScanner.temp.sets[BonusScanner.temp.set] = 1;
			end;
		end
	end
	BonusScanner.bonuses = BonusScanner.temp.bonuses;
	BonusScanner.bonuses_details = BonusScanner.temp.details;
end	

function BonusScanner:ScanTooltip()
	local tmpTxt, line;
	local lines = BonusScannerTooltip:NumLines();

	for i=2, lines, 1 do
		tmpText = getglobal("GroupHeal_TooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			line = tmpText:GetText();
			BonusScanner:ScanLine(line);
		end
	end
end

function BonusScanner:AddValue(effect, value)
	local i,e;
	
	if(type(effect) == "string") then
		if(BonusScanner.temp.bonuses[effect]) then
			BonusScanner.temp.bonuses[effect] = BonusScanner.temp.bonuses[effect] + value;
		else
			BonusScanner.temp.bonuses[effect] = value;
		end
		
		if(BonusScanner.temp.slot) then
			if(BonusScanner.temp.details[effect]) then
				if(BonusScanner.temp.details[effect][BonusScanner.temp.slot]) then
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = BonusScanner.temp.details[effect][BonusScanner.temp.slot] + value;
				else
					BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
				end
			else
				BonusScanner.temp.details[effect] = {};
				BonusScanner.temp.details[effect][BonusScanner.temp.slot] = value;
			end
		end;
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in effect do
				BonusScanner:AddValue(e, value[i]);
			end
		else
			for i,e in effect do
				BonusScanner:AddValue(e, value);
			end
		end
	end
end;

function BonusScanner:ScanLine(line)
	local tmpStr, found;
	-- Check for "Equip: "
	if(string.sub(line,0,string.len(BONUSSCANNER_PREFIX_EQUIP)) == BONUSSCANNER_PREFIX_EQUIP) then

		tmpStr = string.sub(line,string.len(BONUSSCANNER_PREFIX_EQUIP)+1);
		BonusScanner:CheckPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(BONUSSCANNER_PREFIX_SET)) == BONUSSCANNER_PREFIX_SET
			and BonusScanner.temp.set ~= "" 
			and not BonusScanner.temp.sets[BonusScanner.temp.set]) then

		tmpStr = string.sub(line,string.len(BONUSSCANNER_PREFIX_SET)+1);
		BonusScanner.temp.slot = "Set";
		BonusScanner:CheckPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		_, _, tmpStr = string.find(line, BONUSSCANNER_PATTERN_SETNAME);
		if(tmpStr) then
			BonusScanner.temp.set = tmpStr;
		else
			found = BonusScanner:CheckGeneric(line);
			if(not found) then
				BonusScanner:CheckOther(line);
			end;
		end
	end
end;


-- Scans passive bonuses like "Set: " and "Equip: "
function BonusScanner:CheckPassive(line)
	local i, p, value, found;

	found = nil;
	for i,p in BONUSSCANNER_PATTERNS_PASSIVE do
		_, _, value = string.find(line, "^" .. p.pattern);
		if(value) then
			BonusScanner:AddValue(p.effect, value)
			found = 1;
		end
	end
	if(not found) then
		BonusScanner:CheckGeneric(line);
	end
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function BonusScanner:CheckGeneric(line)
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

		_, _, value, token = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_PREFIX);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, BONUSSCANNER_PATTERN_GENERIC_SUFFIX);
		end
		if(token and value) then
			-- trim token
		    token = string.gsub( token, "^%s+", "" );
    	    token = string.gsub( token, "%s+$", "" );
	       	token = string.gsub( token, "%.$", "" );
	
			if(BonusScanner:CheckToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus. 
-- returns true if some bonus is found
function BonusScanner:CheckToken(token, value)
	local i, p, s1, s2;
	
	if(BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token]) then
		BonusScanner:AddValue(BONUSSCANNER_PATTERNS_GENERIC_LOOKUP[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in BONUSSCANNER_PATTERNS_GENERIC_STAGE1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in BONUSSCANNER_PATTERNS_GENERIC_STAGE2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			BonusScanner:AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Last fallback for non generic enchants, like "Mana Regen x per 5 sec."
function BonusScanner:CheckOther(line)
	local i, p, value, start, found;

	for i,p in BONUSSCANNER_PATTERNS_OTHER do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				BonusScanner:AddValue(p.effect, p.value)
			elseif(value) then
				BonusScanner:AddValue(p.effect, value)
			end
			return true;
		end
	end
	return false;
end
	
	
-----------------------------------------------------------------------------------------
-- Localized Information
-----------------------------------------------------------------------------------------

-- bonus names
BONUSSCANNER_NAMES = {	
	HEAL 		= "Healing",
};

-- equip and set bonus prefixes:
BONUSSCANNER_PREFIX_EQUIP = "Equip: ";
BONUSSCANNER_PREFIX_SET = "Set: ";

-- passive bonus patterns. checked against lines which start with above prefixes
BONUSSCANNER_PATTERNS_PASSIVE = {
	{ pattern = "Increases healing done by spells and effects by up to (%d+)%.", effect = "HEAL" },
	{ pattern = "Increases damage and healing done by magical spells and effects by up to (%d+)%.", effect = {"HEAL", "DMG"} },
};

-- generic patterns have the form "+xx bonus" or "bonus +xx" with an optional % sign after the value.

-- first the generic bonus string is looked up in the following table
BONUSSCANNER_PATTERNS_GENERIC_LOOKUP = {

	["Healing Spells"] 		= "HEAL",
	["Increases Healing"] 	= "HEAL",
	["Healing and Spell Damage"] = {"HEAL", "DMG"},
	["Damage and Healing Spells"] = {"HEAL", "DMG"},
	["Spell Damage and Healing"] = {"HEAL", "DMG"},	

};	

-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
BONUSSCANNER_PATTERNS_GENERIC_STAGE1 = {}; 	

BONUSSCANNER_PATTERNS_GENERIC_STAGE2 = {}; 	

-- finally if we got no match, we match against some special enchantment patterns.
BONUSSCANNER_PATTERNS_OTHER = {
	{ pattern = "Zandalar Signet of Mojo", effect = {"DMG", "HEAL"}, value = 18 },
	{ pattern = "Zandalar Signet of Serenity", effect = "HEAL", value = 33 },
	
	{ pattern = "Minor Wizard Oil", effect = {"DMG", "HEAL"}, value = 8 },
	{ pattern = "Lesser Wizard Oil", effect = {"DMG", "HEAL"}, value = 16 },
	{ pattern = "Wizard Oil", effect = {"DMG", "HEAL"}, value = 24 },
	{ pattern = "Brilliant Wizard Oil", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

	{ pattern = "Brilliant Mana Oil", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
};


end




local _G = getfenv(0);

for k, v in GROUPHEAL_STRINGS do
	_G["GROUPHEAL_"..k] = nil;
end