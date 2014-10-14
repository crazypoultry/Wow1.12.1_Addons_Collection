StatScanner_bonuses = {};
StatScanner_currentset = "";
StatScanner_sets = {};
StatScanner_currentsetcount = "";
StatScanner_setcount = {};
StatScanner_setsproperty = {};
STATCOMPARE_SETPROPERTY_PATTERN = "^%((%d+)%) "..STATCOMPARE_SET_PREFIX;

function StatScanner_Scan(link)
	StatScanner_bonuses = {};
	StatScanner_sets = {};
	StatScanner_setcount = {};
	StatScanner_currentset = "";
	StatScanner_currentsetcount = "";

	SCItemTooltip:SetOwner(DressUpFrame, "ANCHOR_NONE");
	SCItemTooltip:SetPoint("TOPLEFT", DressUpFrame:GetName(), "TOPRIGHT", -30, -12);
	SCItemTooltip.default=1;
	SCItemTooltip:ClearLines();

	SCItemTooltip:SetHyperlink(link);
	SCItemTooltip:Show();

	local itemName = SCItemTooltipTextLeft1:GetText();

	local tmpText, tmpStr, lines;
	lines = SCItemTooltip:NumLines();
	for i=2, lines, 1 do
		tmpText = getglobal("SCItemTooltipTextLeft"..i);
		val = nil;
		if (tmpText:GetText()) then
			tmpStr = tmpText:GetText();
			StatScanner_ScanLine(tmpStr,1);
		end
	end
end

function StatScanner_ScanAllInspect(unit, sets)
	local slotID;
	--[[
	0 = ammo
	1 = head
	2 = neck
	3 = shoulder
	4 = shirt
	5 = chest
	6 = belt
	7 = legs
	8 = feet
	9 = wrist
	10 = gloves
	11 = finger 1
	12 = finger 2
	13 = trinket 1
	14 = trinket 2
	15 = back
	16 = main hand
	17 = off hand
	18 = ranged
	19 = tabard
	]]--
	
	local i, j, slotName,sunit,ifScanSet;
	local id, hasItem;
	local itemName, tmpText, tmpStr, tmpSet, val, lines, set;
	local found = false;

	StatScanner_bonuses = {};
	StatScanner_sets = {};
	StatScanner_setcount = {};
	StatScanner_setsproperty = {};
	if (unit) then
		sunit=unit;
		ifScanSet=1;
	else
		sunit="target";
		ifScanSet=0;
	end

	for i=1, 19 ,1 do
		StatScanner_currentset = "";
		StatScanner_currentsetcount = "";
		local link = nil;
		if(not sets) then
			link = GetInventoryItemLink(sunit, i);
		else
			if(StatCompare_BestItems and StatCompare_BestItems[i] and StatCompare_BestItems[i][sets]) then
				local itemId = StatCompare_BestItems[i][sets]["id"];
				local enchantid;
				if(StatCompare_BestItems[i][sets]["enchantid"]) then
					enchantid = StatCompare_BestItems[i][sets]["enchantid"];
				else
					enchantid = 0;
				end
				link = "|Hitem:"..itemId..":"..enchantid..":0:0" .. "|h[" .. SCS_DB[itemId].name .. "]|h|r";
			end
		end
		if (link~=nil) then
			local item = gsub(link, ".*(item:%d+:%d+:%d+:%d+).*", "%1", 1);
			SCObjectTooltip:Hide()
			SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");

			SCObjectTooltip:SetHyperlink(item);			
			itemName = SCObjectTooltipTextLeft1:GetText();
			lines = SCObjectTooltip:NumLines();

			for j=2, lines, 1 do
				tmpText = getglobal("SCObjectTooltipTextLeft"..j);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					found = StatScanner_ScanLine(tmpStr,ifScanSet);
				end
			end

			-- if set item, mark set as already scanned
			if(StatScanner_currentset ~= "") then
				StatScanner_sets[StatScanner_currentset] = 1;
				if (StatScanner_setcount[StatScanner_currentset]) then
					StatScanner_setcount[StatScanner_currentset].count = StatScanner_setcount[StatScanner_currentset].count+1;
				else
					StatScanner_setcount[StatScanner_currentset] = {};
					StatScanner_setcount[StatScanner_currentset].count=1;
					local _, _, sColor, _, _ = string.find(link, STATCOMPARE_ITEMLINK_PATTERN);
					StatScanner_setcount[StatScanner_currentset].color=sColor;
					StatScanner_setcount[StatScanner_currentset].total=StatScanner_currentsetcount;
				end
			end;
		else
			-- Thanks code from WarBabyWOW @mop
			SCObjectTooltip:Hide()
			SCObjectTooltip:SetOwner(UIParent, "ANCHOR_NONE");
			SCObjectTooltip:SetInventoryItem(sunit, i);

			itemName = SCObjectTooltipTextLeft1:GetText();
			lines = SCObjectTooltip:NumLines();

			for j=2, lines, 1 do
				tmpText = getglobal("SCObjectTooltipTextLeft"..j);
				val = nil;
				if (tmpText:GetText()) then
					tmpStr = tmpText:GetText();
					found = StatScanner_ScanLine(tmpStr,ifScanSet);
				end
			end

			-- if set item, mark set as already scanned
			if(StatScanner_currentset ~= "") then
				StatScanner_sets[StatScanner_currentset] = 1;
				if (StatScanner_setcount[StatScanner_currentset]) then
					StatScanner_setcount[StatScanner_currentset].count = StatScanner_setcount[StatScanner_currentset].count+1;
				else
					StatScanner_setcount[StatScanner_currentset] = {};
					StatScanner_setcount[StatScanner_currentset].count=1;
					--local _, _, sColor, _, _ = string.find(link, STATCOMPARE_ITEMLINK_PATTERN);
					local r,g,b,_ = SCObjectTooltipTextLeft1:GetTextColor();
					local sColor = string.format("%2x", r*255)..string.format("%2x", g*255)..string.format("%2x", b*255);
					StatScanner_setcount[StatScanner_currentset].color=sColor;
					StatScanner_setcount[StatScanner_currentset].total=StatScanner_currentsetcount;
				end
			end;			
		end
	end

	if(ifScanSet == 0) then
		found = StatScanner_ScanSetPropertyAll();
	end

	SCObjectTooltip:Hide()
end

function StatScanner_ScanAll()
	StatScanner_ScanAllInspect("player");
end

function StatScanner_AddValue(effect, value)
	local i,e;
	if(type(effect) == "string") then
		if(StatScanner_bonuses[effect]) then
			StatScanner_bonuses[effect] = StatScanner_bonuses[effect] + value;
		else
			StatScanner_bonuses[effect] = value;
		end
	else 
	-- list of effects
		if(type(value) == "table") then
			for i,e in effect do
				StatScanner_AddValue(e, value[i]);
			end
		else
			for i,e in effect do
				StatScanner_AddValue(e, value);
			end
		end
	end
end;

function StatScanner_ScanLine(line,ifScanSet)
	local tmpStr, found;
	found = false;

	-- Check for "Equip: "
	if(string.sub(line,0,string.len(STATCOMPARE_EQUIP_PREFIX)) == STATCOMPARE_EQUIP_PREFIX) then
		tmpStr = string.sub(line,string.len(STATCOMPARE_EQUIP_PREFIX)+1);
		found = StatScanner_ScanPassive(tmpStr);

	-- Check for "Set: "
	elseif(string.sub(line,0,string.len(STATCOMPARE_SET_PREFIX)) == STATCOMPARE_SET_PREFIX
			and StatScanner_currentset ~= "" 
			and not StatScanner_sets[StatScanner_currentset]
			and ifScanSet==1) then

		tmpStr = string.sub(line,string.len(STATCOMPARE_SET_PREFIX)+1);
		found = StatScanner_ScanPassive(tmpStr);

	-- any other line (standard stats, enchantment, set name, etc.)
	else
		-- Check for set name
		_, _, tmpStr,setcount = string.find(line, STATCOMPARE_SETNAME_PATTERN);
		if(tmpStr) then
			StatScanner_currentset = tmpStr;
			StatScanner_currentsetcount = setcount;
		else
			found = StatScanner_ScanGeneric(line);
			if(not found) then
				found = StatScanner_ScanOther(line);
			end;
		end
		-- Check for set property
		if(ifScanSet == 0 and not found) then
			found = StatScanner_ScanSetProperty(line);
		end
	end
	return found;
end;


-- Scans passive bonuses like "Set: " and "Equip: "
function StatScanner_ScanPassive(line)
	local i, p, value, found, start;

	found = false;
	line = string.gsub( line, "^%s+", "" );
	for i,p in STATCOMPARE_EQUIP_PATTERNS do
		start, _, value = string.find(line, "^" .. p.pattern);
		if(start) then
			if(p.value) then
				StatScanner_AddValue(p.effect, p.value);
			elseif(value) then
				if(value=="s1")then value=10; end -- cwow°þÆ¤µ¶·­Òë´íÎó
				StatScanner_AddValue(p.effect, value);
			end
			found = true;
			break;
		end
	end
	if(not found) then
		found = StatScanner_ScanGeneric(line);
	end
	return found;
end


-- Scans generic bonuses like "+3 Intellect" or "Arcane Resistance +4"
function StatScanner_ScanGeneric(line)
	local value, token, pos, tmpStr, found;
	line = string.gsub( line, "^%s+", "" );
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

		_, _, value, token = string.find(tmpStr, STATCOMPARE_PREFIX_PATTERN);
		if(not value) then
			_, _,  token, value = string.find(tmpStr, STATCOMPARE_SUFFIX_PATTERN);
		end

		if(token and value) then
			-- trim token
			token = string.gsub( token, "^%s+", "" );
    			token = string.gsub( token, "%s+$", "" );
	
			if(StatScanner_ScanToken(token,value)) then
				found = true;
			end
		end
	end
	return found;
end


-- Identifies simple tokens like "Intellect" and composite tokens like "Fire damage" and 
-- add the value to the respective bonus.
function StatScanner_ScanToken(token, value)
	local i, p, s1, s2;
	
	if(STATCOMPARE_TOKEN_EFFECT[token]) then
		StatScanner_AddValue(STATCOMPARE_TOKEN_EFFECT[token], value);
		return true;
	else
		s1 = nil;
		s2 = nil;
		for i,p in STATCOMPARE_S1 do
			if(string.find(token,p.pattern,1,1)) then
				s1 = p.effect;
			end
		end	
		for i,p in STATCOMPARE_S2 do
			if(string.find(token,p.pattern,1,1)) then
				s2 = p.effect;
			end
		end	
		if(s1 and s2) then
			StatScanner_AddValue(s1..s2, value);
			return true;
		end 
	end
	return false;
end

-- Scans last fallback for not generic enchants, like "Mana Regen x per 5 sec."
function StatScanner_ScanOther(line)
	local i, p, value, start, found;
	line = string.gsub( line, "^%s+", "" );
	found = false;
	for i,p in STATCOMPARE_OTHER_PATTERNS do
		start, _, value = string.find(line, "^" .. p.pattern);

		if(start) then
			if(p.value) then
				StatScanner_AddValue(p.effect, p.value)
			elseif(value) then
				StatScanner_AddValue(p.effect, value)
			end
			found = true;
			break;
		end
	end
	return found;
end

function StatScanner_ScanSetPropertyAll()
	local found = false;
	for i,v in StatScanner_setcount do
		for j=1, getn(StatScanner_setsproperty) do
			if(i == StatScanner_setsproperty[j].setsname) then
				if(v.count >= StatScanner_setsproperty[j].count) then
					found = StatScanner_ScanPassive(StatScanner_setsproperty[j].line);
				end
			end
		end
	end
	return found;
end


-- Scans target(not self)'s set property generic bonuses 
-- like "(2) Set: +3 Intellect" or "(5) Set: Arcane Resistance +4"
function StatScanner_ScanSetProperty(line)
	local found = false;
	local tmpStr;

	if(StatScanner_currentset == "") then
		return found;
	end

	if(not line) then
		return found;
	end

	line = string.gsub( line, "^%s+", "" );
	local startpos, endpos, value = string.find(line, STATCOMPARE_SETPROPERTY_PATTERN);
	local count = getn(StatScanner_setsproperty);

	if(not value) then
		return found;
	end

	tmpStr = string.sub(line, endpos + 1);
	tmpStr = string.gsub( tmpStr, "^%s+", "" );
	for i = 1, count do
		if(StatScanner_setsproperty[i]) then
			if(StatScanner_setsproperty[i].setsname == StatScanner_currentset and
			   StatScanner_setsproperty[i].count == tonumber(value) and
			   StatScanner_setsproperty[i].line == tmpStr) then
				return found;
			end
		end
	end
	
	count = count + 1;
	StatScanner_setsproperty[count] = {};
	StatScanner_setsproperty[count].setsname = StatScanner_currentset;
	StatScanner_setsproperty[count].count = tonumber(value);
	StatScanner_setsproperty[count].line = tmpStr;
	found = true;

	return found;
end

function StatCompare_CharStats_GetCritChance()
	local critChance, iCritInfo, critNum;
	local id = 1;
	
	-- This may vary depending on WoW localizations.
	
	local attackSpell = GetSpellName(id,BOOKTYPE_SPELL);
	if (attackSpell ~= STATCOMPARE_ATTACKNAME) then
		name, texture, offset, numSpells = GetSpellTabInfo(1);
		for i=1, numSpells do
			if (GetSpellName(i,BOOKTYPE_SPELL) == STATCOMPARE_ATTACKNAME) then
				id = i;
			end
		end
	end
	GameTooltip:SetOwner(WorldFrame,"ANCHOR_NONE");
	GameTooltip:SetSpell(id, BOOKTYPE_SPELL);
	local spellName = GameTooltipTextLeft2:GetText();
	GameTooltip:Hide();
	iCritInfo = string.gsub(spellName, "(.*)%%.*", "%1");
	if(iCritInfo) then
		critChance = iCritInfo;
	else
		critChance = nil;
	end
	return critChance;
end