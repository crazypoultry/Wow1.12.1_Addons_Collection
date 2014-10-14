BuffDatabase_ITEM_HEIGHT = 16;
BuffDatabase_ITEMS_SHOWN = 23;
CurrentSelection = "";

function BuffDatabase_Update()
	SortDebuffTable();
	FauxScrollFrame_Update(BuffDatabaseListScrollFrame, table.getn(Devour_Order), BuffDatabase_ITEMS_SHOWN, BuffDatabase_ITEM_HEIGHT);
	for iItem = 1, BuffDatabase_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(BuffDatabaseListScrollFrame);
		local BuffDatabaseItemSlot = getglobal("BuffDatabaseItem"..iItem);
		if( itemIndex <= table.getn(Devour_Order)) then
			local name = Devour_Order[itemIndex];
			if name == CurrentSelection then
				BuffDatabaseItemSlot:SetTextColor(1,1,0);
			else
				BuffDatabaseItemSlot:SetTextColor(1,1,1);
			end
			BuffDatabaseItemSlot:SetText(name);
			BuffDatabaseItemSlot:Show();
		else
			BuffDatabaseItemSlot:Hide();
		end
	end
end

function BuffDatabase_BuildArray()	
	local i = 1;
	Devour_Priority = {};
	local DebugMsg = false;
	while Devour_Order[i] ~= InCombatDivider do
		Devour_Priority[Devour_Order[i]] = true;
		ServitudeMessage(DebugMsg, "Added "..Devour_Order[i].." to Devour_Priority array.");
		i = i + 1;
	end
end
--[[
function MoveUpBuff()
	for i = 2, table.getn(Devour_Order), 1 do
		if Devour_Order[i] == CurrentSelection then
			local temp = Devour_Order[i - 1];
			Devour_Order[i - 1] = Devour_Order[i];
			Devour_Order[i] = temp;
			return;
		end
	end
end
]]--
function MakeFirstBuff()
	for i = table.getn(Devour_Order), 2, -1 do
		if Devour_Order[i] == CurrentSelection then
			local temp = Devour_Order[i - 1];
			Devour_Order[i - 1] = Devour_Order[i];
			Devour_Order[i] = temp;
		end
	end
end

function MakeLastBuff()
	for i = 1,table.getn(Devour_Order) -1, 1 do
		if Devour_Order[i] == CurrentSelection then
			local temp = Devour_Order[i + 1];
			Devour_Order[i + 1] = Devour_Order[i];
			Devour_Order[i] = temp;
		end
	end
end
--[[
function MoveDownBuff()
	for i = 1, table.getn(Devour_Order) - 1, 1 do
		if Devour_Order[i] == CurrentSelection then
			local temp = Devour_Order[i + 1];
			Devour_Order[i + 1] = Devour_Order[i];
			Devour_Order[i] = temp;
			return;
		end
	end
end
]]--
function BuffDatabaseItemButton_OnEnter()
		DebuffName = this:GetText();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if DebuffName == InCombatDivider then
			GameTooltip:SetText("Debuff below this line will not be devoured during combat.",1,1,1);
		else
			GameTooltip:SetText(Magical_Debuff_List[this:GetText()],1,1,1);
		end
end

function SortDebuffTable()	
	local SortedAbove = {};
	local SortedBelow = {};
	local Divideri = 0;
	local DebuffTableSize = table.getn(Devour_Order);	
	foreach(Devour_Order,function(k,v)
		if Divideri == 0 then
			table.insert(SortedAbove,v);			
			if v ~= InCombatDivider then
				table.sort(SortedAbove);
			else
				Divideri = 1;
			end
		else
			table.insert(SortedBelow,v);
		end
	end);	
	table.sort(SortedBelow);	
	if table.getn(SortedAbove) + table.getn(SortedBelow) == DebuffTableSize then
		Devour_Order = {};
		foreach(SortedAbove,function(k,v) table.insert(Devour_Order,v) end);
		foreach(SortedBelow,function(k,v) table.insert(Devour_Order,v) end);
	end
end
