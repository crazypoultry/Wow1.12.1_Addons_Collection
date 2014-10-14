-- Random utility functions and other handy things

BFC_Util = {};

function BFC_Util.Init()
	BFC_Util.ReverseClassLookup = BFC_Util.FlipKeysAndValues(BFC_Strings.Classes);
end


function BFC_Util.FlipKeysAndValues(table)
	local newTable = {};
	
	for key,val in pairs(table) do
		newTable[val] = key;
	end
	
	return newTable;
end


function BFC_Util.GetRealClassName(class)
	return BFC_Util.ReverseClassLookup[class];
end


-- From lua-users wiki
function BFC_Util.SplitString(delimiter, text)
	local list = {};
	local pos = 1;
	if strfind("", delimiter, 1) then -- this would result in endless loops
		BFC.Log(BFC.LOG_DEBUG, "delimiter matches empty string!");
	end
	while 1 do
		local first, last = strfind(text, delimiter, pos);
		if first then -- found?
			tinsert(list, strsub(text, pos, first-1));
			pos = last+1;
		else
			tinsert(list, strsub(text, pos));
			break;
		end
	end
	return list
end


-- From wowwiki: count table members even if they're not indexed by numbers
function BFC_Util.TableCount(tab)
	local n=0;
	for _ in pairs(tab) do
		n=n+1;
	end
	return n;
end


-- Get a table item by index even if not indexed by numbers
function BFC_Util.GetTableItem(tab, index)
	local n = 1;
	for _,v in pairs(tab) do
		if(n == index) then
			return v;
		end
		n = n+1;
	end
	BFC.Log(BFC.LOG_ERROR, "Table index out of bounds: " .. index);
	return nil;
end


-- Get color escape strings for class colors
function BFC_Util.GetClassColorString(class)
	local c = RAID_CLASS_COLORS[class];
	return BFC_Util.GetColorString(c.r*255, c.g*255, c.b*255);
end


function BFC_Util.GetColorString(r, g, b)
	local s = string.format("|cff%02x%02x%02x", r, g, b);
	--BFC.Log(BFC.LOG_DEBUG, string.format("Turning %s %s %s into ff%02x%02x%02x", r, g, b, r, g, b));
	return s;
end


-- Takes a number from 0-10, 10 being best and 0 being worst. 
-- Returns a color (green for best, red for worst)
function BFC_Util.GetGoodnessColor(goodness)
	goodness = goodness / 2;
	--if(goodness == 0) then
	--	goodness = 1;
	--end
	if goodness <= 1 then
		return 1, 0, 0
	elseif goodness <= 2 then
		return 1, 0.5 * (goodness - 1), 0
	elseif goodness <= 3 then
		return 1, 0.5 + 0.5 * (goodness - 2), 0
	elseif goodness <= 4 then
		return 1 - 0.5 * (goodness - 3), 1, 0
	elseif goodness <= 5 then
		return 0.5 - 0.5 * (goodness - 4), 1, 0
	else
		return 0, 1, 0
	end
end


function BFC_Util.GetGoodnessColorString(goodness)
	local r, g, b = BFC_Util.GetGoodnessColor(goodness);
	return string.format("|cff%02x%02x%02x", r*255, g*255, b*255);
end


function BFC_Util.GetUnitHealthPercent(unit)
	local h = UnitHealth(unit);
	local hmax = UnitHealthMax(unit);
	return ceil(h / hmax * 100);
end


function BFC_Util.SecondsToMinutesSeconds(seconds)
	local minutes = floor(seconds / 60);
	seconds = seconds - (minutes * 60);
	return string.format("%d:%02d", minutes, seconds);
end