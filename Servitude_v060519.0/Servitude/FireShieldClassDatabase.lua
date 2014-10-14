FireShieldClassDatabase_ITEM_HEIGHT = 16;
FireShieldClassDatabase_ITEMS_SHOWN = 23;
CurrentSelection = "";

function FireShieldClassDatabase_Update()
	FauxScrollFrame_Update(FireShieldClassDatabaseListScrollFrame, table.getn(FireShieldClass_Order), FireShieldClassDatabase_ITEMS_SHOWN, FireShieldClassDatabase_ITEM_HEIGHT);
	for iItem = 1, FireShieldClassDatabase_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(FireShieldClassDatabaseListScrollFrame);
		local FireShieldClassDatabaseItemSlot = getglobal("FireShieldClassDatabaseItem"..iItem);
		if( itemIndex <= table.getn(FireShieldClass_Order)) then
			local name = FireShieldClass_Order[itemIndex];
			if name == CurrentSelection then
				FireShieldClassDatabaseItemSlot:SetTextColor(1,1,0);
			else
				FireShieldClassDatabaseItemSlot:SetTextColor(1,1,1);
			end
			FireShieldClassDatabaseItemSlot:SetText(name);
			FireShieldClassDatabaseItemSlot:Show();
		else
			FireShieldClassDatabaseItemSlot:Hide();
		end
	end
end

function FireShieldClassDatabase_BuildArray()
	local i = 1;
	FireShieldClass_Priority = {};
	local DebugMsg = false;
	while FireShieldClass_Order[i] ~= ClassDivider do
		FireShieldClass_Priority[FireShieldClass_Order[i]] = true;
		ServitudeMessage(DebugMsg, "Added "..FireShieldClass_Order[i].." to FireShieldClass_Priority array.");
		i = i + 1;
	end
end

function MoveUpFSClass()
	for i = 2, table.getn(FireShieldClass_Order), 1 do
		if FireShieldClass_Order[i] == CurrentSelection then
			local temp = FireShieldClass_Order[i - 1];
			FireShieldClass_Order[i - 1] = FireShieldClass_Order[i];
			FireShieldClass_Order[i] = temp;
			return;
		end
	end
end

function MakeFirstFSClass()
	for i = table.getn(FireShieldClass_Order), 2, -1 do
		if FireShieldClass_Order[i] == CurrentSelection then
			local temp = FireShieldClass_Order[i - 1];
			FireShieldClass_Order[i - 1] = FireShieldClass_Order[i];
			FireShieldClass_Order[i] = temp;
		end
	end
end

function MakeLastFSClass()
	for i = 1,table.getn(FireShieldClass_Order) -1, 1 do
		if FireShieldClass_Order[i] == CurrentSelection then
			local temp = FireShieldClass_Order[i + 1];
			FireShieldClass_Order[i + 1] = FireShieldClass_Order[i];
			FireShieldClass_Order[i] = temp;
		end
	end
end

function MoveDownFSClass()
	for i = 1, table.getn(FireShieldClass_Order) - 1, 1 do
		if FireShieldClass_Order[i] == CurrentSelection then
			local temp = FireShieldClass_Order[i + 1];
			FireShieldClass_Order[i + 1] = FireShieldClass_Order[i];
			FireShieldClass_Order[i] = temp;
			return;
		end
	end
end

function FireShieldClassDatabaseItemButton_OnEnter()
		ClassName = this:GetText();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if ClassName == ClassDivider then
			GameTooltip:SetText("The Imp will not Fire Shield any classes below this line.",1,1,1);
		end
end
