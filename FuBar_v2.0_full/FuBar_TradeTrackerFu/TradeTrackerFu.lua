local Tablet = AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")
local Crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_TradeTrackerFu")

TradeTrackerFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

TradeTrackerFu:RegisterDB("TradeTrackerFuDB")
TradeTrackerFu:RegisterDefaults('char', {
	compactText = true,  
    useDash = false,	
	splitGather =  false,
	items = {},	
	hidden = {},
	skilldisplay = {},
})


local _INV_ = {};
local _CATTOGGLE_ = false;

local _SKILLS_ = {"tradeskillalchemy", "tradeskillblacksmithing", "tradeskillcooking", "tradeskillenchanting", "tradeskillengineering", "tradeskillfirstaid", "tradeskillleatherworking", "tradeskilltailoring", "tradeskillpoison", "tradeskillsmelting"};
local _SKILLSNAMES_ = {"Alchemy", "Blacksmithing", "Cooking", "Enchanting", "Engineering", "First Aid", "Leatherworking", "Tailoring", "Poison", "Smelting"};

local _GATHER_  = {"gatherskillfishing", "gatherskilldisenchant", "gatherskillherbalism", "gatherskillmining", "gatherskillskinning"};

TradeTrackerFu.version = "1.0.1";
TradeTrackerFu.hasIcon = "Interface\\Icons\\Trade_Herbalism";
TradeTrackerFu.hasNoColor = true;
TradeTrackerFu.clickableTooltip = true;

function TradeTrackerFu:OnInitialize()
	self.PT = PeriodicTableEmbed:GetInstance("1")
	self.PTTrade = PTTradeskillsEmbed:GetInstance("1")	
end

function TradeTrackerFu:OnEnable()
    self:RegisterEvents();
end

function TradeTrackerFu:OnDisable()
    self:UnRegisterEvents();
end

function TradeTrackerFu:OnMenuRequest(level, value)
	if level == 1 then
		Dewdrop:AddLine(
			'text', L["Display"],
			'hasArrow', true,
			'value', "display"
		)
		
		Dewdrop:AddLine(
			'text', L["Compact text"],
			'func', function()
						self.db.char.compactText = not self.db.char.compactText;
						self:UpdateText();
					end,
			'checked', self.db.char.compactText
		)
		
		Dewdrop:AddLine(
			'text', L["Split gatherable items"],
			'func', function()
						self.db.char.splitGather = not self.db.char.splitGather;
						self:UpdateText();
					end,
			'checked', self.db.char.splitGather
		)
		
		Dewdrop:AddLine(
			'text', L["Use --, not 0"],
			'func', function()
						self.db.char.useDash = not self.db.char.useDash;
						self:UpdateText();
					end,
			'checked', self.db.char.useDash
		)
		
		
		
		Dewdrop:AddLine('text', " ")
		
	elseif level == 2 then
		if value == "display" then
		    for i, skill in pairs(_SKILLSNAMES_) do
		        Dewdrop:AddLine(
		            'text', Crayon:Yellow(skill),
		            'func', function(i) self:SetDisplaySkill(i) end,
		            'arg1', i,
					'checked', self:IsDisplaySkill(i)
		        )
		    end
		end
	end

end

function TradeTrackerFu:OnTextUpdate()
	local text = "";
	
	if self.db.char.compactText then
		text = "TT";
	else
		text = "TradeTrackerFu";
	end	
		
	self:SetText(text);
end

function TradeTrackerFu:ToggleCategory(id, button)
    -- hidden is character specific data
	_CATTOGGLE_ = true;
    self.db.char.hidden[id] = not self.db.char.hidden[id]
	-- refresh in place
	self:UpdateTooltip()
end

function TradeTrackerFu:hasSkill(skill)
	if (_INV_[skill] ~= nil) then
		return(true);
	end;
	if (self.db.char.items[skill] ~= nil) then
		return(true);
	end;
	return(false);
end;

function TradeTrackerFu:getNameList(skill,list)
	
	local index = {};
	
	if (_INV_[skill] ~= nil) then
		local t = _INV_[skill]["NAMELIST"];
		for i,n in pairs(t) do
			if (index[n] == nil) then
				index[n] = n;
				table.insert(list,n);
			end;
		end;
	end;
	
	if (self.db.char.items[skill]) then
		local t = self.db.char.items[skill]["NAMELIST"];
		for i,n in pairs(t) do
			if (index[n] == nil) then
				index[n] = n;
				table.insert(list,n);
			end;
		end;	
	end;
	return(list);
end;

function TradeTrackerFu:getInvQuantity(skill,itemname)
	if (_INV_[skill] == nil) then
		return(0);
	end;
	if (_INV_[skill]["NAMEINDEX"][itemname] == nil) then
		return(0);
	end;
	return(_INV_[skill]["NAMEINDEX"][itemname]["QUANTITY"]);
end;

function TradeTrackerFu:getBankQuantity(skill,itemname)
	if (self.db.char.items[skill] == nil) then
		return(0);
	end;
	if (self.db.char.items[skill]["NAMEINDEX"][itemname] == nil) then
		return(0);
	end;
	return(self.db.char.items[skill]["NAMEINDEX"][itemname]["QUANTITY"]);
end;

function TradeTrackerFu:displaySkill(skill)
	if (self.db.char.skilldisplay[skill] == nil) then
		return(true);
	end;
	return(self.db.char.skilldisplay[skill].disp);
end;


function TradeTrackerFu:getItemID(skill,itemname)
	local itemid = nil;
	if (_INV_[skill] ~= nil) then
		if (_INV_[skill]["NAMEINDEX"][itemname] ~= nil) then
			itemid = _INV_[skill]["NAMEINDEX"][itemname]["ITEMID"];
		end;
	end;
	if (itemid == nil) then
		if (self.db.char.items[skill] ~= nil) then
			if (self.db.char.items[skill]["NAMEINDEX"][itemname] ~= nil) then
				itemid = self.db.char.items[skill]["NAMEINDEX"][itemname]["ITEMID"];
			end;
		end;
	end;
	return(itemid);
end;

function TradeTrackerFu:isGatherable(itemid)
	for i,gath in pairs(_GATHER_) do
		if (self.PT:ItemInSet(itemid,gath) ~= nil) then
			return(true);
		end;
	end;
	return(false);
end;

function TradeTrackerFu:colorizeName(skill,itemname)

	local itemid = self:getItemID(skill,itemname);

	local gathercolor = "68ccef";
	
	if (itemid == nil) then
		return(Crayon:Colorize(gathercolor,itemname));
	end;
	
	if (self:isGatherable(itemid)) then	
			return(Crayon:Yellow(itemname));
		end;
	
	return(Crayon:Colorize(gathercolor,itemname));
end;

function TradeTrackerFu:GetNumberText(x)
	if (x > 0) or not self.db.char.useDash then
		return("" .. x);
	end;
	return("--");

end;

function TradeTrackerFu:splitGatherables(skill,list)
	if (list == nil) then
		return(nil);
	end;
	local l = {};
	l["GATHERABLE"] = {};
	l["NON"] = {};
	for i,itemname in pairs(list) do
		local itemid = self:getItemID(skill,itemname);
		if (itemid == nil) then
			table.insert(l["GATHERABLE"],itemname);
		else
			if (self:isGatherable(itemid)) then
				table.insert(l["GATHERABLE"],itemname);
			else
				table.insert(l["NON"],itemname);
			end;
		end;	
	end;
	return(l);

end;

function TradeTrackerFu:OnTooltipUpdate()
	

	if (not _CATTOGGLE_) then
		self:SaveInv();
	end;
	_CATTOGGLE_ = false;
	
	for i,skill in pairs(_SKILLS_) do
		
		if (self:displaySkill(skill)) then
			if (self:hasSkill(skill))  then
				local cat = Tablet:AddCategory(	'id', skill, 
												'columns', 4,
												'text', _SKILLSNAMES_[i],
												'func', 'ToggleCategory', 
												'arg1', self, 
												'arg2', skill,
												'child_textR', 1, 
												'child_textG', 1, 
												'child_textB', 0,
												'showWithoutChildren', true,
												'checked', true, 
												'hasCheck', true, 
												'checkIcon',
												self.db.char.hidden[skill] and 'Interface\\Buttons\\UI-PlusButton-Up' or 'Interface\\Buttons\\UI-MinusButton-Up')
			
				if not self.db.char.hidden[skill] then
					local t = {};
					t = self:getNameList(skill,t);		
					table.sort(t);
					
					if (not self.db.char.splitGather) then
					for j,itemname in pairs(t) do
						local q = self:getInvQuantity(skill,itemname);
						local b = self:getBankQuantity(skill,itemname);
						cat:AddLine(
						'text',self:colorizeName(skill,itemname),
						'text2',Crayon:White(self:GetNumberText(q)),
						'text3',Crayon:Yellow(self:GetNumberText(b)),
						'text4',Crayon:Green(q + b),
						'justify', "LEFT",
						'justify2', "RIGHT",
						'justify3', "RIGHT",
						'justify4', "RIGHT"
					)	
					end;			
					else
						local lists = self:splitGatherables(skill,t);
						if (lists ~= nil) then
							local gatherables = lists["GATHERABLE"];
							local nons = lists["NON"];
							if (table.getn(gatherables) > 0) then
								cat:AddLine(
									'text', Crayon:White("Gatherable"),
									'size', Tablet:GetNormalFontSize()-2, 
									'justify',"LEFT",
									'indentation', 2
								)
								for j,itemname in pairs(gatherables) do
									local q = self:getInvQuantity(skill,itemname);						
									local b = self:getBankQuantity(skill,itemname);						
									cat:AddLine(
										'text',Crayon:Yellow(itemname),
										'text2',Crayon:White(self:GetNumberText(q)),
										'text3',Crayon:Yellow(self:GetNumberText(b)),
										'text4',Crayon:Green(q + b),
										'justify', "LEFT",
										'justify2', "RIGHT",
										'justify3', "RIGHT",
										'justify4', "RIGHT",
										'indentation', 4
									)	
								end;							
							end;
							if (table.getn(nons) > 0) then
								cat:AddLine(
									'text', Crayon:White("Items"),
									'size', Tablet:GetNormalFontSize()-2, 
									'justify',"LEFT",
									'indentation', 2
								)
								for j,itemname in pairs(nons) do
									local q = self:getInvQuantity(skill,itemname);						
									local b = self:getBankQuantity(skill,itemname);						
									cat:AddLine(
										'text',Crayon:Colorize("68ccef",itemname),
										'text2',Crayon:White(self:GetNumberText(q)),
										'text3',Crayon:Yellow(self:GetNumberText(b)),
										'text4',Crayon:Green(q + b),
										'justify', "LEFT",
										'justify2', "RIGHT",
										'justify3', "RIGHT",
										'justify4', "RIGHT",
										'indentation', 4
									)	
								end;								
							end;											
						end;
					end;
				end;	
			end;
		end;
	end;
end


function TradeTrackerFu:SetDisplaySkill(i)
	local s = _SKILLS_[i];
	if (self.db.char.skilldisplay[s] == nil) then
		self.db.char.skilldisplay[s] = {};
		self.db.char.skilldisplay[s].disp = true;
	end;
	self.db.char.skilldisplay[s].disp = not self.db.char.skilldisplay[s].disp;
	
	
	
	self:UpdateText();
end

function TradeTrackerFu:IsDisplaySkill(x)
	local s = _SKILLS_[x];
	if (self.db.char.skilldisplay[s] == nil) then
		self.db.char.skilldisplay[s] = {};
		self.db.char.skilldisplay[s].disp = true;
	end;
	return self.db.char.skilldisplay[s].disp;
end

function TradeTrackerFu:RegisterEvents()
	self:RegisterEvent("BANKFRAME_OPENED", "OnBankUpdate");
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED", "OnBankUpdate");
end

function TradeTrackerFu:UnRegisterEvents()

end

function TradeTrackerFu:OnBankUpdate()	
	self:Update();	
	self:SaveBank();	
end



function TradeTrackerFu:NameFromLink(link)
	local name
	if (link) then
		for name in string.gmatch(link, "%[(.-)%]") do		
			return(name);
		end
	end
end



function TradeTrackerFu:skillList(itemID,skilllist)		
	for i,skill in pairs(_SKILLS_) do
		if (self.PT:ItemInSet(itemID,skill) ~= nil) then
			--DEFAULT_CHAT_FRAME:AddMessage("ADD TRADE:" .. skill);
			table.insert(skilllist,skill);
		end
	end;
	return(skilllist);
end;

function TradeTrackerFu:addInventoryItem(skilllist,itemid,itemname,quantity)
	if (skilllist == nil) then
		return;
	end;
	if (table.getn(skilllist) == 0) then
		return;
	end;
	
	for i,skill in pairs(skilllist) do
		if (_INV_[skill] == nil) then
			_INV_[skill] = {};
		end;
		if (_INV_[skill]["NAMEINDEX"] == nil) then
			_INV_[skill]["NAMEINDEX"] = {};
		end;
		if (_INV_[skill]["NAMELIST"] == nil) then
			_INV_[skill]["NAMELIST"] = {};
		end;
		if (_INV_[skill]["NAMEINDEX"][itemname] == nil) then
			_INV_[skill]["NAMEINDEX"][itemname] = {};			
			_INV_[skill]["NAMEINDEX"][itemname]["QUANTITY"]	= quantity;
			_INV_[skill]["NAMEINDEX"][itemname]["ITEMID"]	= itemid;
			table.insert(_INV_[skill]["NAMELIST"],itemname);
		else
			local q = _INV_[skill]["NAMEINDEX"][itemname]["QUANTITY"];
			_INV_[skill]["NAMEINDEX"][itemname]["QUANTITY"]	= q + quantity;
		end;		
	end;


end;

function TradeTrackerFu:GetInvList()
	local iItemCount = 0;
	_INV_ = {};
	
	for bag = 4, 0, -1 do
		 	
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local itemIcon, itemQuantity = GetContainerItemInfo(bag, slot);

				if (itemQuantity) then
					local itemID = nil;
					local link = GetContainerItemLink(bag, slot);
					
					if (link) then
						_,_, itemID = string.find(link, "item:(%d+):");					
						local itemName = TradeTrackerFu:NameFromLink(link);					
						
						if ((itemName) and (itemName ~= "")) then
							local xItem = tonumber(itemID);													
							local skilllist = {};
							skilllist = self:skillList(xItem,skilllist);
							self:addInventoryItem(skilllist,xItem,itemName,itemQuantity);												
						end
					end;
				end
			end
		end
	end	
end


function TradeTrackerFu:addBankItem(skilllist,itemid,itemname,quantity)
	if (skilllist == nil) then
		return;
	end;
	if (table.getn(skilllist) == 0) then
		return;
	end;
	
	for i,skill in pairs(skilllist) do
		if (self.db.char.items[skill] == nil) then
			self.db.char.items[skill] = {};
		end;
		if (self.db.char.items[skill]["NAMEINDEX"] == nil) then
			self.db.char.items[skill]["NAMEINDEX"] = {};
		end;
		if (self.db.char.items[skill]["NAMELIST"] == nil) then
			self.db.char.items[skill]["NAMELIST"] = {};
		end;
		if (self.db.char.items[skill]["NAMEINDEX"][itemname] == nil) then
			self.db.char.items[skill]["NAMEINDEX"][itemname] = {};			
			self.db.char.items[skill]["NAMEINDEX"][itemname]["QUANTITY"] = quantity;
			self.db.char.items[skill]["NAMEINDEX"][itemname]["ITEMID"] = itemid;
			table.insert(self.db.char.items[skill]["NAMELIST"],itemname);
		else
			local q = self.db.char.items[skill]["NAMEINDEX"][itemname]["QUANTITY"];
			if (q == nil) then
				q = 0;
			end;
			self.db.char.items[skill]["NAMEINDEX"][itemname]["QUANTITY"]	= q + quantity;
		end;		
	end;


end;


function TradeTrackerFu:GetBankList()
	local maxContainerItems;
	local containerItemNum;
	local bagNum;
	local link;
	local quantity;
	local icon;
	local itemName;

	local iItemCount = 0;
	self.db.char.items = {};

	maxContainerItems = GetContainerNumSlots(BANK_CONTAINER);
	if ( maxContainerItems ) then
		for containerItemNum = 1, maxContainerItems do
			link = GetContainerItemLink(BANK_CONTAINER, containerItemNum);
			icon, quantity = GetContainerItemInfo(BANK_CONTAINER, containerItemNum);
			if( link ) then
				local itemID = nil;
				_,_, itemID = string.find(link, "item:(%d+):");		
				itemName = TradeTrackerFu:NameFromLink(link);
				if (itemName ~= nil) then
					local xItem = tonumber(itemID);
					local skilllist = {};
					skilllist = self:skillList(xItem,skilllist);
					self:addBankItem(skilllist,xItem,itemName,quantity);										
				end;
			end
		end

		for bagNum = 5, 10 do
			maxContainerItems = GetContainerNumSlots(bagNum);
			if( maxContainerItems ) then
				local id = BankButtonIDToInvSlotID(bagNum, 1);
				link = GetInventoryItemLink("player", id);
				icon = GetInventoryItemTexture("player", id);
				for containerItemNum = 1, maxContainerItems do
					link = GetContainerItemLink(bagNum, containerItemNum);
					icon, quantity = GetContainerItemInfo(bagNum, containerItemNum);
					if( link ) then
						local itemID = nil;
						_,_, itemID = string.find(link, "item:(%d+):");		
						itemName = TradeTrackerFu:NameFromLink(link);
						if (itemName ~= nil) then
							local xItem = tonumber(itemID);
							local skilllist = {};
							skilllist = self:skillList(xItem,skilllist);
							self:addBankItem(skilllist,xItem,itemName,quantity);										
						end;
					end
				end
			end
		end
	end
end


function TradeTrackerFu:SaveInv()	
	
	TradeTrackerFu:GetInvList(invlist);	
end

function TradeTrackerFu:SaveBank()
	TradeTrackerFu:GetBankList(banklist);	
end


