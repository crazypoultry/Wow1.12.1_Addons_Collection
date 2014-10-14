function DMP_Sort(unsortedlist, sortByIndex)
	local sortedValues = {};
	for i,v in unsortedlist do
		sortedValues[i] = v[sortByIndex];
	end
	DMP_SortTable(sortedValues);
	local sortedList = {};
	for i,v in sortedValues do
		local index;
		for i2,v2 in unsortedlist do
			if (v2[sortByIndex] == v) then
				index = i2;
				break;
			end
		end
		sortedList[i] = {};
		DMP_Copy_Table(unsortedlist[index], sortedList[i]);
		unsortedlist[index] = nil;
	end
	return sortedList;
end

function DMP_SortTable(origTable)
	local function sortf(a, b)
		if ( strlower(a)<strlower(b) ) then
			return true;
		elseif ( strlower(a)==strlower(b) and a<b ) then
			return true;
		end
	end
	table.sort(origTable, sortf);
end

function DMP_SortKeys(origTable)
	local a = {};
	for n in pairs(origTable) do
		table.insert(a, n);
	end
	DL_Sort(a, sortf);
	return a;
end

function DMP_Copy_Table(src, dest)
	for index, value in src do
		if (type(value) == "table") then
			dest[index] = {};
			DMP_Copy_Table(value, dest[index]);
		else
			dest[index] = value;
		end
	end
end

function DMP_Debug(text)
	DEFAULT_CHAT_FRAME:AddMessage(text, 1, 0, 0);
end

function DMP_Get_ActionName(id)
	if (not HasAction(id)) then return ""; end
	GameTooltip:SetAction(id);
	local name, rank = "", "";
	if (GameTooltipTextLeft1:IsShown()) then
		name = GameTooltipTextLeft1:GetText();
	end
	if (GameTooltipTextRight1:IsShown()) then
		rank = GameTooltipTextRight1:GetText();
	end
	if (rank == "") then
		return name;
	else
		return name.." ("..rank..")";
	end
	GameTooltip:Hide();
end