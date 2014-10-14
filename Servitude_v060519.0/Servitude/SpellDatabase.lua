SpellDatabase_ITEM_HEIGHT = 16;
SpellDatabase_ITEMS_SHOWN = 23;
CurrentSelection = "";

function SpellDatabase_Update()
	SortSpellTable();
	FauxScrollFrame_Update(SpellDatabaseListScrollFrame, table.getn(Spell_Lock_Order), SpellDatabase_ITEMS_SHOWN, SpellDatabase_ITEM_HEIGHT);
	for iItem = 1, SpellDatabase_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(SpellDatabaseListScrollFrame);
		local SpellDatabaseItemSlot = getglobal("SpellDatabaseItem"..iItem);
		if( itemIndex <= table.getn(Spell_Lock_Order)) then
			local name = Spell_Lock_Order[itemIndex];
			if name == CurrentSelection then
				SpellDatabaseItemSlot:SetTextColor(1,1,0);
			else
				SpellDatabaseItemSlot:SetTextColor(1,1,1);
			end
			SpellDatabaseItemSlot:SetText(name);
			SpellDatabaseItemSlot:Show();
		else
			SpellDatabaseItemSlot:Hide();
		end
	end
end

function SpellDatabase_BuildArray()	
	local i = 1;
	Spell_Priority = {};
	local DebugMsg = false;
	while Spell_Lock_Order[i] ~= SpellLockDivider do
		Spell_Priority[Spell_Lock_Order[i]] = true;
		ServitudeMessage(DebugMsg, "Added "..Spell_Lock_Order[i].." to Spell_Priority array.");
		i = i + 1;
	end
end
--[[
function MoveUpSpell()
	for i = 2, table.getn(Spell_Lock_Order), 1 do
		if Spell_Lock_Order[i] == CurrentSelection then
			local temp = Spell_Lock_Order[i - 1];
			Spell_Lock_Order[i - 1] = Spell_Lock_Order[i];
			Spell_Lock_Order[i] = temp;
			return;
		end
	end
end
]]--

function MakeFirstSpell()
	for i = table.getn(Spell_Lock_Order), 2, -1 do
		if Spell_Lock_Order[i] == CurrentSelection then
			local temp = Spell_Lock_Order[i - 1];
			Spell_Lock_Order[i - 1] = Spell_Lock_Order[i];
			Spell_Lock_Order[i] = temp;
		end
	end
end

function MakeLastSpell()
	for i = 1,table.getn(Spell_Lock_Order) -1, 1 do
		if Spell_Lock_Order[i] == CurrentSelection then
			local temp = Spell_Lock_Order[i + 1];
			Spell_Lock_Order[i + 1] = Spell_Lock_Order[i];
			Spell_Lock_Order[i] = temp;
		end
	end
end
--[[
function MoveDownSpell()
	for i = 1, table.getn(Spell_Lock_Order) - 1, 1 do
		if Spell_Lock_Order[i] == CurrentSelection then
			local temp = Spell_Lock_Order[i + 1];
			Spell_Lock_Order[i + 1] = Spell_Lock_Order[i];
			Spell_Lock_Order[i] = temp;
			return;
		end
	end
end
]]--
function SpellDatabaseItemButton_OnEnter()
		SpellName = this:GetText();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if SpellName == SpellLockDivider then
			GameTooltip:SetText("Spells below this line will not be Spell Locked.",1,1,1);
		end
end

function SortSpellTable()
	local SortedAbove = {};
	local SortedBelow = {};
	local Divideri = 0;
	local SpellTableSize = table.getn(Spell_Lock_Order);
	foreach(Spell_Lock_Order,function(k,v)
		if Divideri == 0 then
			table.insert(SortedAbove,v);			
			if v ~= SpellLockDivider then
				table.sort(SortedAbove);
			else
				Divideri = 1;
			end
		else
			table.insert(SortedBelow,v);
		end
	end);	
	table.sort(SortedBelow);	
	if table.getn(SortedAbove) + table.getn(SortedBelow) == SpellTableSize then		
		Spell_Lock_Order = {};		
		foreach(SortedAbove,function(k,v) table.insert(Spell_Lock_Order,v) end);		
		foreach(SortedBelow,function(k,v) table.insert(Spell_Lock_Order,v) end);
	end
end

