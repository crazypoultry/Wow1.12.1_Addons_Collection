ClassDatabase_ITEM_HEIGHT = 16;
ClassDatabase_ITEMS_SHOWN = 23;
CurrentSelection = "";

function ClassDatabase_Update()
	FauxScrollFrame_Update(ClassDatabaseListScrollFrame, table.getn(Class_Order), ClassDatabase_ITEMS_SHOWN, ClassDatabase_ITEM_HEIGHT);
	for iItem = 1, ClassDatabase_ITEMS_SHOWN, 1 do
		local itemIndex = iItem + FauxScrollFrame_GetOffset(ClassDatabaseListScrollFrame);
		local ClassDatabaseItemSlot = getglobal("ClassDatabaseItem"..iItem);
		if( itemIndex <= table.getn(Class_Order)) then
			local name = Class_Order[itemIndex];
			if name == CurrentSelection then
				ClassDatabaseItemSlot:SetTextColor(1,1,0);
			else
				ClassDatabaseItemSlot:SetTextColor(1,1,1);
			end
			ClassDatabaseItemSlot:SetText(name);
			ClassDatabaseItemSlot:Show();
		else
			ClassDatabaseItemSlot:Hide();
		end
	end
end

function ClassDatabase_BuildArray()
	local i = 1;
	Class_Priority = {};
	local DebugMsg = false;
	while Class_Order[i] ~= ClassDivider do
		Class_Priority[Class_Order[i]] = i;
		ServitudeMessage(DebugMsg, "Added "..Class_Order[i].." to Class_Priority array.");
		i = i + 1;
	end
end

function MoveUpClass()
	for i = 2, table.getn(Class_Order), 1 do
		if Class_Order[i] == CurrentSelection then
			local temp = Class_Order[i - 1];
			Class_Order[i - 1] = Class_Order[i];
			Class_Order[i] = temp;
			return;
		end
	end
end

function MakeFirstClass()
	for i = table.getn(Class_Order), 2, -1 do
		if Class_Order[i] == CurrentSelection then
			local temp = Class_Order[i - 1];
			Class_Order[i - 1] = Class_Order[i];
			Class_Order[i] = temp;
		end
	end
end

function MakeLastClass()
	for i = 1,table.getn(Class_Order) -1, 1 do
		if Class_Order[i] == CurrentSelection then
			local temp = Class_Order[i + 1];
			Class_Order[i + 1] = Class_Order[i];
			Class_Order[i] = temp;
		end
	end
end

function MoveDownClass()
	for i = 1, table.getn(Class_Order) - 1, 1 do
		if Class_Order[i] == CurrentSelection then
			local temp = Class_Order[i + 1];
			Class_Order[i + 1] = Class_Order[i];
			Class_Order[i] = temp;
			return;
		end
	end
end

function ClassDatabaseItemButton_OnEnter()
		ClassName = this:GetText();
		GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
		if ClassName == ClassDivider then
			GameTooltip:SetText("The Felhunter will not devour any classes below this line.",1,1,1);
		end
end
