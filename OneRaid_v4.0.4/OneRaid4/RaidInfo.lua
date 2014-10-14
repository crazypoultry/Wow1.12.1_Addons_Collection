OneRaid.RaidInfo 				= {
	durability 					= {},
	durabilitySort 				= { "durability", 1 },
	resists						= {},
	resistsSort					= { "name", -1 },
	item						= {},
	itemSort					= { "count", 1 },
};
	
function OneRaid.RaidInfo:OnLoad()

	if (this == OneRaid_RaidInfo_Durability_Frame) then
		getglobal(this:GetName() .. "_Header_Text"):SetText(ONERAID_RAID_INFO .. " - " .. ONERAID_DURABILITY);
	elseif (this == OneRaid_RaidInfo_Resists_Frame) then
		getglobal(this:GetName() .. "_Header_Text"):SetText(ONERAID_RAID_INFO .. " - " .. ONERAID_RESISTS);
	elseif (this == OneRaid_RaidInfo_Item_Frame) then
		getglobal(this:GetName() .. "_Header_Text"):SetText(ONERAID_RAID_INFO .. " - " .. ONERAID_ITEM_COUNT);
	end
	
	getglobal(this:GetName() .. "_Header_Background"):SetVertexColor(.4, 0, 0);
	this:SetBackdropColor(0, 0, 0, .75);
	this:SetBackdropBorderColor(0, 0, 0, 0);

end

function OneRaid.RaidInfo:OnMouseDown()

	this:StartMoving();
	
end

function OneRaid.RaidInfo:OnMouseUp()

	this:StopMovingOrSizing();
	
end

function OneRaid.RaidInfo:OnShow()

	if (this == OneRaid_RaidInfo_Durability_Frame) then
		self:Durability_OnUpdate();
	end
	if (this == OneRaid_RaidInfo_Resists_Frame) then
		self:Resists_OnUpdate();
	end
	if (this == OneRaid_RaidInfo_Item_Frame) then
		self:Item_OnUpdate();
	end
	
end

function OneRaid.RaidInfo:SortDurability(column)

	self.durabilitySort[1] = column or self.durabilitySort[1];
	
	if (column) then
		self.durabilitySort[2] = self.durabilitySort[2] * -1;
	end
	
	self:Durability_OnUpdate();

end

function OneRaid.RaidInfo:Durability_OnUpdate()

	table.sort(self.durability,
	    function (a, b)
			if (self.durabilitySort[2] == 1) then
				if (self.durabilitySort[1] == "name") then
					return a[self.durabilitySort[1]] < b[self.durabilitySort[1]];
				else
					return tonumber(a[self.durabilitySort[1]]) < tonumber(b[self.durabilitySort[1]]);
				end
			else
				if (self.durabilitySort[1] == "name") then
					return a[self.durabilitySort[1]] > b[self.durabilitySort[1]];
				else
					return tonumber(a[self.durabilitySort[1]]) > tonumber(b[self.durabilitySort[1]]);
				end
			end
		end
	);

	local offset = FauxScrollFrame_GetOffset(OneRaid_RaidInfo_Durability_Frame_List);
	
	FauxScrollFrame_Update(OneRaid_RaidInfo_Durability_Frame_List, getn(self.durability), 18, 20)

	for i = 1, 18 do
		local index = offset + i;

		local item = getglobal("OneRaid_RaidInfo_Durability_Frame_Item" .. i);
		local name = getglobal(item:GetName() .. "_Name");
		local text = getglobal(item:GetName() .. "_Text");

		if (index <= getn(self.durability)) then
		
			local val = self.durability[index];
			
			name:SetText(val.name);
			
			local color = "|cFFFFFFFF";
            if (val.durability >= 75) then
				color = "|cFF00FF00";
			elseif (val.durability < 75 and val.durability >= 50) then
                color = "|cFFFFFF00";
			elseif (val.durability < 50 and val.durability >= 25) then
                color = "|cFFFF8000";
			elseif (val.durability < 25 and val.durability >= 0) then
            	color = "|cFFFF0000";
			end
            text:SetText(color .. val.durability .. "%|r (|cFFFF0000" .. val.broken .. "|r " .. ONERAID_BROKEN_ITEMS .. ")");
            item:Show();
		else
			item:Hide();
		end
	end

	OneRaid_RaidInfo_Durability_Frame_List:Show();

end

function OneRaid.RaidInfo:SortResists(column)

	self.resistsSort[1] = column or self.resistsSort[1];
	
	if (column) then
		self.resistsSort[2] = self.resistsSort[2] * -1;
	end
	
	self:Resists_OnUpdate();

end

function OneRaid.RaidInfo:Resists_OnUpdate()

	table.sort(self.resists,
	    function (a, b)
			if (self.resistsSort[2] == 1) then
				if (self.resistsSort[1] == "name") then
					return a[self.resistsSort[1]] < b[self.resistsSort[1]];
				else
					return tonumber(a[self.resistsSort[1]]) < tonumber(b[self.resistsSort[1]]);
				end
			else
				if (self.resistsSort[1] == "name") then
					return a[self.resistsSort[1]] > b[self.resistsSort[1]];
				else
					return tonumber(a[self.resistsSort[1]]) > tonumber(b[self.resistsSort[1]]);
				end
			end
		end
	);

	local offset = FauxScrollFrame_GetOffset(OneRaid_RaidInfo_Resists_Frame_List);
	
	FauxScrollFrame_Update(OneRaid_RaidInfo_Resists_Frame_List, getn(self.resists), 18, 20)

	for i = 1, 18 do
		local index = offset + i;

		local item = getglobal("OneRaid_RaidInfo_Resists_Frame_Item" .. i);
		local name = getglobal(item:GetName() .. "_Name");
		local arcane = getglobal(item:GetName() .. "_Arcane");
		local fire = getglobal(item:GetName() .. "_Fire");
		local nature = getglobal(item:GetName() .. "_Nature");
		local frost = getglobal(item:GetName() .. "_Frost");
		local shadow = getglobal(item:GetName() .. "_Shadow");

		if (index <= getn(self.resists)) then
		
			local val = self.resists[index];
			
			name:SetText(val.name);
			arcane:SetText("|cFFFFFFFF" .. val.arcane);
			fire:SetText("|cFFF0000F" .. val.fire);
			nature:SetText("|cFF00FF00" .. val.nature);
			frost:SetText("|cFF467DFF" .. val.frost);
			shadow:SetText("|cFFA566FF" .. val.shadow);
			
            item:Show();
		else
			item:Hide();
		end
	end

	OneRaid_RaidInfo_Resists_Frame_List:Show();

end

function OneRaid.RaidInfo:SortItem(column)

	self.itemSort[1] = column or self.itemSort[1];
	
	if (column) then
		self.itemSort[2] = self.itemSort[2] * -1;
	end
	
	self:Item_OnUpdate();

end

function OneRaid.RaidInfo:Item_OnUpdate()

	table.sort(self.item,
	    function (a, b)
			if (self.itemSort[2] == 1) then
				if (self.itemSort[1] == "name") then
					return a[self.itemSort[1]] < b[self.itemSort[1]];
				else
					return tonumber(a[self.itemSort[1]]) < tonumber(b[self.itemSort[1]]);
				end
			else
				if (self.itemSort[1] == "name") then
					return a[self.itemSort[1]] > b[self.itemSort[1]];
				else
					return tonumber(a[self.itemSort[1]]) > tonumber(b[self.itemSort[1]]);
				end
			end
		end
	);

	local offset = FauxScrollFrame_GetOffset(OneRaid_RaidInfo_Item_Frame_List);
	
	FauxScrollFrame_Update(OneRaid_RaidInfo_Item_Frame_List, getn(self.item), 18, 20)

	for i = 1, 18 do
		local index = offset + i;

		local item = getglobal("OneRaid_RaidInfo_Item_Frame_Item" .. i);
		local name = getglobal(item:GetName() .. "_Name");
		local text = getglobal(item:GetName() .. "_Text");

		if (index <= getn(self.item)) then
		
			local val = self.item[index];
			
			name:SetText(val.name);
            text:SetText(val.count .. " " .. self.itemName);
            item:Show();
		else
			item:Hide();
		end
	end

	OneRaid_RaidInfo_Item_Frame_List:Show();

end