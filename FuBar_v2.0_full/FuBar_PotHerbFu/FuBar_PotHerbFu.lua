local dewdrop = AceLibrary("Dewdrop-2.0")
local tablet = AceLibrary("Tablet-2.0")
local crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("PotHerbFu")

PotHerbFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceHook-2.0")

local currentRealm = GetRealmName(); 

local optionsTable = {
	type = 'group',
	args = {
		hideLabel = {
			order = 1,
			type = 'toggle',
			name = L["HIDE_LABEL"],
			desc = L["HIDE_LABEL"],
			get = function()
				return PotHerbFu.db.profile.hideLabel
			end,
			set = function(value)
				PotHerbFu.db.profile.hideLabel = value;
				PotHerbFu:UpdateText();
			end,
		},
		showMakeableInfo = {
			order = 2,
			type = 'toggle',
			name = "Show Makeable",
			desc = "Shows the full detailed info on pots you can make",
			get = function()
				return PotHerbFu.db.profile.showMakeableInfo
			end,
			set = function(value)
				PotHerbFu.db.profile.showMakeableInfo = value;
			end,
		},
		showUsableInfo = {
			order = 3,
			type = 'toggle',
			name = "Show Useable",
			desc = "Shows the full detailed info on which pots you can make from herbs / misc stuff",
			get = function()
				return PotHerbFu.db.profile.showUsableInfo
			end,
			set = function(value)
				PotHerbFu.db.profile.showUsableInfo = value;
			end,
		},		
		hideOverview = {
			order = 4,
			type = 'toggle',
			name = "Hide Overview",
			desc = "Hides the total overview display when you are in detailed mode",
			get = function()
				return PotHerbFu.db.profile.hideOverview
			end,
			set = function(value)
				PotHerbFu.db.profile.hideOverview = value;
			end,
		},				
		showHideDetails = {
			order = 5,
			type = 'toggle',
			name = "Hide Details button",
			desc = "shows a 'Hide details' button below the details to hide them if hide overview is not used (if not shown, CTRL click any entry to hide em)",
			get = function()
				return PotHerbFu.db.profile.showHideDetails
			end,
			set = function(value)
				PotHerbFu.db.profile.showHideDetails = value;
			end,
			disabled = function()
				if PotHerbFu.db.profile.hideOverview then
					return true;
				else
					return false;
				end
			end,									
		},						
		limits = {
			order = 9,
			type = 'group', 
			name = "Set limits",
			desc = "Set all limits for the pots and herbs to show green, orange, red color",
			args = {
				limitpots = {
					order = 1,
					type = 'group', 
					name = "Pot limits",
					desc = "Set pot limits to show green, orange, red color",
					args = {
					}
				},				
				limitherbs = {
					order = 2,
					type = 'group', 
					name = "Herb limits",
					desc = "Set herb limits to show green, orange, red color",
					args = {
					}
				},				
				limitmisc = {
					order = 3,
					type = 'group', 
					name = "Misc limits",
					desc = "Set misc limits to show green, orange, red color",
					args = {
					}
				}								
			}
		},
		manualCD = {
			order = 10,
			type = 'group', 
			name = L["MENU_SHOW_TEXT1"],
			desc = L["MENU_SHOW_TEXT1"],
			args = {
				manualDRS = {
					order = 1,
					type = "execute",
					name = L["MENU_SHOW_TEXT_GETDATA"],
					desc = "Refresh the data gathered from OneView (also performed by a regular click on text)",
					func = "OnClick";
				},
				manualSB = {
					order = 2,
					type = "execute",
					name = L["MENU_SHOW_TEXT_MAKEPOTS"],
					desc = "Calculate the makeable amount of pots from the present data (also performed by a SHIFT click on text)",
					func = "CalcMakeablePots";
				},			
				scanAlchy = {
					order = 3,
					type = "execute",
					name = "Scan Recipes",
					desc = "Will open you alchemy window and scan all recipes you got (also performed by a CTRL click on text)",
					func = "OpenAndImportCrafts",
				},
				clearLabel = {
					order = 4,
					type = "execute",
					name = L["CLEAR_LABEL"],
					desc = "Clear all settings including limits set (also performed by an ALT click on text)",
					func = "ClearConfirm",
				},					
			}
		},		
	}
}

--PotHerbFu.OnMenuRequest = optionsTable
PotHerbFu:RegisterChatCommand( { "/PotHerbfu" }, optionsTable )
PotHerbFu.clickableTooltip = true
PotHerbFu.hasIcon = true
PotHerbFu.charDisplaystring = "c";
PotHerbFu.clearSelectionString = "x";

PotHerbFu:RegisterDB("PotHerbFuDB")
PotHerbFu:RegisterDefaults('profile', {
	hideLabel = 1,
	filterVials = 1,
	filterPots = 1,
	limitSelectionChanged = 1, -- 1 for startup, will always be set to 1 when pots/herbs/misc selections have been changed for menu to update
	displayCat = nil,
	displayItem = nil,
	showMakeableInfo = 1, -- show the info for makeable pots in tt detail view
	showUsableInfo = 1, -- show the info for makeable pots in tt detail view
	hideOverview = 1, -- hide the overview, when in detailed view
	showHideDetails = nil, -- if this is on there is an extra line .. hide details below details
	tipOrder = { 
		[1]= "pots",
		[2]= "herbs",
		[3]= "misc",
	},
	herbList = {"Grave Moss","Mountain Silversage","Sungrass","Firebloom","Goldthorn","Fadeleaf","Dreamfoil","Khadgar's Whisker","Swiftthistle",
		"Liferoot","Icecap","Plaguebloom","Gromsblood","Stranglekelp","Golden Sansam","Arthas' Tears","Blindweed","Purple Lotus","Mageroyal",
		"Ghost Mushroom","Kingsblood","Bruiseweed","Earthroot","Briarthorn","Silverleaf","Peacebloom"},
	addMisc = {"Nightfin Soup","Whipper Root Tuber","Night Dragon's Breath","Fused Wiring","Runecloth Bandage","Cooked Glossy Mightfish",
		"Grilled Squid","Elemental Fire","Elemental Water"},			
	specialPots = {"Shadow Oil","Stonescale Oil","Blackmouth Oil","Minor Healing Potion","Fire Oil"},
	mailbox = {}, -- stuff thats in mailbox
	valueMin = 5, --- min value for orange and green
	valueMax = 100, --- max value for orange and green
	valueStep = 5, --- step value for orange and green
})

function PotHerbFu:MAIL_INBOX_UPDATE()	
	DEFAULT_CHAT_FRAME:AddMessage("Mail Box Update"); 
	self:InboxFrame_Update();
  self:Update();
end

function PotHerbFu:CHAT_MSG_LOOT()	
  self:Update();
end

function PotHerbFu:OnInitialize()
	self:SetIcon("Interface\\Icons\\Trade_Alchemy.blp");
end

function PotHerbFu:OnEnable()
  -- Events
  --self:RegisterEvent("PLAYER_ENTERING_WORLD");  
  
  --self:ScheduleRepeatingEvent(self.OnUpdate, 5, self);
  
  -- Variables   
  self:Hook("InboxFrame_Update")
  	
	self:CreateData();
	self:CreateSortedTables();
	self.db.profile.displayCat = nil;
	self.db.profile.displayItem = nil;	
	--self:ClearData()
  --DEFAULT_CHAT_FRAME:AddMessage(PotHerbFuLocals.NAME..": Running");	
end

function PotHerbFu:OnDisable()
end

function PotHerbFu:InboxFrame_Update()
	self.hooks["InboxFrame_Update"].orig()
	--DEFAULT_CHAT_FRAME:AddMessage("Frame Update"); 	
	local index = GetInboxNumItems();	
	if index > 0 then	
		if (self.db.profile.mailbox) then
			local nm = UnitName("player");
			self.db.profile.mailbox[nm] = nil;
			self.db.profile.mailbox[nm] = {};
	
			for i=1,index do
				local _, _, _, subject, _, _, _, hasItem, _, _, _, _ = GetInboxHeaderInfo(i);
				--DEFAULT_CHAT_FRAME:AddMessage("ID "..i.." -"..subject);	
				if (hasItem) then
					_,_,mbitem, amount = string.find(subject, "%[(.+) x(%d+)")	
					if mbitem and amount then
						--DEFAULT_CHAT_FRAME:AddMessage("ID "..i.." -"..mbitem.."-"..amount);	
						if (self.db.profile.mailbox[nm][mbitem]) then
							self.db.profile.mailbox[nm][mbitem] = self.db.profile.mailbox[nm][mbitem] + amount;
						else
							self.db.profile.mailbox[nm][mbitem] = amount;
						end
					end
				end
			end
		end
	else
		if (self.db.profile.mailbox) then
			local nm = UnitName("player");
			self.db.profile.mailbox[nm] = nil;
		end		
	end
end

function PotHerbFu:OnItemShiftClick(i,j)
	if (not self.db.profile.data[i][j]) then
		return;
	end
	if (IsControlKeyDown()) then
		self.db.profile.data[i][j] = nil;
		return;
	end		
	if (self.db.profile.data[i][j].checked) then
		self.db.profile.data[i][j].checked = nil;
	else
		self.db.profile.data[i][j].checked = 1;
	end
end

function PotHerbFu:OnItemClick(i,j)
	if (IsControlKeyDown()) or (i == self.clearSelectionString) then
		self.db.profile.displayCat = nil;
		self.db.profile.displayItem = nil;
		--DEFAULT_CHAT_FRAME:AddMessage("Reset"); 
		return;
	end			
	if (i ~= self.charDisplaystring) and (not self.db.profile.data[i][j]) then
		return;
	end
	self.db.profile.displayCat = i;
	self.db.profile.displayItem = j;
	--DEFAULT_CHAT_FRAME:AddMessage("Item "..i.."-"..j); 
end

function PotHerbFu:OnTextUpdate()		
	local retval;    		
	for i in self.db.profile.tipOrder do
		local ct = self.db.profile.tipOrder[i];
		if (self.db.profile.data[ct]) then
			local i = 0;						
			for j in self.db.profile.data[ct] do			
				if (self.db.profile.data[ct][j].checked) then
					i = i + 1;
				end
			end
			if (not retval) then
				if (self.db.profile.hideLabel) then
					retval = i;
				else
					retval = "PHM: "..i;
				end
			else
				retval = retval.."/"..i;
			end			
		end
	end		
	if (not retval) then
		if (self.db.profile.hideLabel) then		
  		self:SetText("");
  	else
  		self:SetText("PHM");
  	end
  else
  	self:SetText(retval);
  end  	
end

function PotHerbFu:ItemColor(i,j,val)
	local ora = self.db.profile.data[i][j].orange;
	local gre = self.db.profile.data[i][j].green;
	
	if (not ora) or (not gre) or (not val) then
		return 1,1,1;
	end
	
	if (ora >= gre) then -- ora may not be greater green
		ora = gre - self.db.profile.valueStep;		
		if (ora < self.db.profile.valueMin) then
			ora = self.db.profile.valueMin;
		end
		self.db.profile.data[i][j].orange = ora;
	end	
	
	local q = (gre - ora) / 4;
	
	local r,g,b = crayon:GetThresholdColor(val,ora,ora+q,ora+2*q,ora+3*q,gre);

--[[	local r,g,b;
	r = 1;
	g = 1;
	b = 0;	
	if (val < self.db.profile.data[i][j].orange) then
		r = 1;
		g = 0;
		b = 0;			
	elseif (val > self.db.profile.data[i][j].green) then
		r = 0;
		g = 1;
		b = 0;					
	end			]]--
	return r,g,b;
end

function PotHerbFu:OnTooltipUpdate()
	local useShift = nil;
	local useCtrl = nil;
	local useAlt = nil;

	if (IsShiftKeyDown()) then
		useShift = 1;
		self.db.profile.limitSelectionChanged = 1;
	end
	if (IsControlKeyDown()) then
		useCtrl = 1;
	end
	if (IsAltKeyDown()) then
		useAlt = 1;
	end	
	local cat = tablet:AddCategory(
		'columns', 4
	)
	
	cat:AddLine(
		'text', ""
	)
	
	if (useCtrl) then
		self:GatherTotalStats();
		local line = {};						
		line['text'] = "Last Item Scan";
		line['text4'] = self.db.profile.lastItemScan
		line['hasCheck'] = false								
		cat:AddLine(line);		
		
		line['text'] = "Last Pot Calculation";
		line['text4'] = self.db.profile.lastPotCalculation
		line['hasCheck'] = false								
		cat:AddLine(line);						

		if (self.db.profile.totalStats) then
			
			line['text'] = " ";
			line['text4'] = " "
			line['hasCheck'] = false								
			cat:AddLine(line);														
			
			if (self.db.profile.totalStats.players) then
				line['text'] = "Total players scanned";
				line['text4'] = self.db.profile.totalStats.players
				line['hasCheck'] = false								
				cat:AddLine(line);										
			end
			
			if (self.db.profile.totalStats.bags) then
				line['text'] = "Total bags scanned ";
				line['text4'] = self.db.profile.totalStats.bags
				line['hasCheck'] = false								
				cat:AddLine(line);														
			end
			
			line['text'] = "Total items listed";
			line['text4'] = self.db.profile.totalStats.items
			line['hasCheck'] = false								
			cat:AddLine(line);														

			line['text'] = "Total items selected";
			line['text4'] = self.db.profile.totalStats.selectedItems
			line['hasCheck'] = false								
			cat:AddLine(line);																

			line['text'] = "Total found items";
			line['text4'] = self.db.profile.totalStats.itemCount
			line['hasCheck'] = false								
			cat:AddLine(line);														

			line['text'] = "Total makeable items";
			line['text4'] = self.db.profile.totalStats.makeAble
			line['hasCheck'] = false								
			cat:AddLine(line);																
		end
		
		return;
	end	
	
	if (useShift) then
		for i in self.db.profile.tipOrder do
			local ct = self.db.profile.tipOrder[i];
			--DEFAULT_CHAT_FRAME:AddMessage(ct); 
			if (self.db.profile.data[ct]) then
				--DEFAULT_CHAT_FRAME:AddMessage(i); 
				local line = {};						
				line['text'] = ct
				line['hasCheck'] = false								
				cat:AddLine(line);
						
				for j in self.tempData[ct] do			
					if (self.db.profile.data[ct][self.tempData[ct][j]]) then
						local line = {};				
						line['text'] = self.tempData[ct][j]
						line['textR'] = 1
						line['textG'] = 1
						line['textB'] = 1																				
						line['text2'] = self.db.profile.data[ct][self.tempData[ct][j]].orange;
						line['text3'] = self.db.profile.data[ct][self.tempData[ct][j]].green;
						line['func'] = 'OnItemShiftClick'
						line['arg1'] = self			
						line['arg2'] = ct
						line['arg3'] = self.tempData[ct][j]
						line['hasCheck'] = true
						line['checked'] = self.db.profile.data[ct][self.tempData[ct][j]].checked;
						cat:AddLine(line);				
					end
				end
			end			
		end		
		self:UpdateText();
		return;
	end
	
	if self.db.profile.displayCat and self.db.profile.displayItem then -- display some detailed item info
		
		if (self.db.profile.displayCat == self.charDisplaystring) then
			local line = {};						
			line['text'] = self.db.profile.displayItem.." (total)"
			line['text2'] = "bags";	
			line['text3'] = "box";	
			line['text4'] = "bank";	
			line['func'] = 'OnItemClick'
			line['arg1'] = self			
			line['arg2'] = self.charDisplaystring;
			line['arg3'] = self.db.profile.displayItem;								
			
			--line['text2'] = item.total;	
			--line['text3'] = item.make.count;				
			--line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count);				
			--	line['text4'] = item.make.count+item.total;				
				--line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count+item.total);							
			cat:AddLine(line);			
			
			for i in self.db.profile.tipOrder do
				local ct = self.db.profile.tipOrder[i];
				--DEFAULT_CHAT_FRAME:AddMessage(ct); 
				if (self.db.profile.data[ct]) then
					local hasItems = nil;
						
					for j in self.tempData[ct] do			
						local item = self.db.profile.data[ct][self.tempData[ct][j]];
						if (item) and ((item.checked) or (useAlt)) then							
							for k in item.charData do
								if (k == self.db.profile.displayItem) then -- items on that char
									hasItems = 1;
									local line = {};						
									line['text'] = "   "..self.tempData[ct][j].." ("..item.total..")"
									line['textR'],line['textG'],line['textB'] = self:ItemColor(ct,self.tempData[ct][j],item.total);				
									line['text2'] = item.charData[k].bags;	
									line['text2R'],line['text2G'],line['text2B'] = self:ItemColor(ct,self.tempData[ct][j],item.charData[k].bags*3);				
									line['text3'] = item.charData[k].box;	
									line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(ct,self.tempData[ct][j],item.charData[k].box*3);				
									line['text4'] = item.charData[k].bank;	
									line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(ct,self.tempData[ct][j],item.charData[k].bank*3);				
									line['func'] = 'OnItemClick'
									line['arg1'] = self			
									line['arg2'] = ct;
									line['arg3'] = self.tempData[ct][j];								
									cat:AddLine(line);					
								end
							end							
						end
					end
					
					if (hasItems) and (i ~= table.getn(self.db.profile.tipOrder)) then -- dont show on last item
						local line = {};						
						line['text'] = " "
						line['hasCheck'] = false								
						cat:AddLine(line);
					end
				end
			end
			
		else
		
		local item = self.db.profile.data[self.db.profile.displayCat][self.db.profile.displayItem];
		if (item) then
			--DEFAULT_CHAT_FRAME:AddMessage("Showing :"..self.db.profile.displayCat.."-"..self.db.profile.displayItem); 
			local line = {};						
			line['text'] = self.db.profile.displayItem
			line['textR'],line['textG'],line['textB'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.total);
			line['text2R'] = line['textR']
			line['text2G'] = line['textG']
			line['text2B'] = line['textB']													
			line['text2'] = item.total;	
			if (self.db.profile.displayCat == "pots") then									
				line['text3'] = item.make.count;				
				line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count);				
				line['text4'] = item.make.count+item.total;				
				line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count+item.total);				
			end			
			cat:AddLine(line);
			
			if (item.charData) then
				local display = nil;
				for i in item.charData do
					display = 1;
					break;
				end
				if (display) then
					local line = {};						
					line['text'] = "   Name"
					line['text2'] = "bags";	
					line['text3'] = "box";	
					line['text4'] = "bank";	
					cat:AddLine(line);					
					
					for i in item.charData do
						local line = {};						
						line['text'] = "   "..i
						line['text2'] = item.charData[i].bags;	
						line['text2R'],line['text2G'],line['text2B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.charData[i].bags*3);				
						line['text3'] = item.charData[i].box;	
						line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.charData[i].box*3);				
						line['text4'] = item.charData[i].bank;	
						line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.charData[i].bank*3);				
						line['func'] = 'OnItemClick'
						line['arg1'] = self			
						line['arg2'] = self.charDisplaystring;
						line['arg3'] = i;								
						cat:AddLine(line);					
					end
				end
			end
			end
			
			cat:AddLine(
				'text', " "
			)			
			
			if (self.db.profile.showMakeableInfo) and (item.make) and (item.make.count) then
				local line = {};						
				line['text'] = "   MakeInfo"
				line['textR'] = 0
				line['textG'] = 0.8
				line['textB'] = 1																								
				line['text2'] = item.make.count;	
				line['text2R'],line['text2G'],line['text2B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count);				
				line['text3'] = item.make.limit;	
				line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(item.make.limitCat,item.make.limit,item.make.limitCount);				
				line['text4'] = item.make.limitCount;	
				line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(item.make.limitCat,item.make.limit,item.make.limitCount);				
				cat:AddLine(line);					
				
				for i in item.req do
					--DEFAULT_CHAT_FRAME:AddMessage("Req :"..i); 
					local line = {};						
					line['text'] = "     "..i
					line['text2'] = item.req[i].count;	
					line['text2R'] = 1
					line['text2G'] = 1
					line['text2B'] = 0																													
					--line['text2R'],line['text2G'],line['text2B'] = self:ItemColor(self.db.profile.displayCat,self.db.profile.displayItem,item.make.count);				
					line['text3'] = " ";	
					--line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(item.make.limitCat,item.make.limit,item.make.limitCount);				
					--DEFAULT_CHAT_FRAME:AddMessage("Req :"..item.req[i].cat.."-"..i); 
					line['text4'] = self.db.profile.data[item.req[i].cat][i].total;	
					line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(item.req[i].cat,i,self.db.profile.data[item.req[i].cat][i].total);				
					line['textR'] = line['text4R']
					line['textG'] = line['text4G']
					line['textB'] = line['text4B']																					
					line['func'] = 'OnItemClick'
					line['arg1'] = self			
					line['arg2'] = item.req[i].cat
					line['arg3'] = i												
					cat:AddLine(line);										
				end

				cat:AddLine(
					'text', " "
				)							
			end			
			
			if (self.db.profile.showUsableInfo) and ( (self.db.profile.displayCat ~= "pots") or (self:IsSpecialPot(self.db.profile.displayItem)) ) then									

				local line = {};						
				line['text'] = "   Used in"
				line['text2'] = "amount";	
				line['text3'] = "avail";	
				line['text4'] = "make";	
				cat:AddLine(line);					
				
				for i in self.db.profile.data.pots do
					for j in self.db.profile.data.pots[i].req do
						if (j == self.db.profile.displayItem) then
							--DEFAULT_CHAT_FRAME:AddMessage("Found in :"..i); 
							local line = {};						
							line['text'] = "   "..i
							line['text2'] = self.db.profile.data.pots[i].req[j].count;	
							line['text2R'] = 1
							line['text2G'] = 1
							line['text2B'] = 0																															
							line['text3'] = self.db.profile.data.pots[i].total;	
							line['text3R'],line['text3G'],line['text3B'] = self:ItemColor("pots",i,self.db.profile.data.pots[i].total);											
							line['textR'] = line['text3R']
							line['textG'] = line['text3G']
							line['textB'] = line['text3B']											
							line['func'] = 'OnItemClick'
							line['arg1'] = self			
							line['arg2'] = "pots"
							line['arg3'] = i							
							if (self.db.profile.data.pots[i].make) and (self.db.profile.data.pots[i].make.count) then
								line['text4'] = self.db.profile.data.pots[i].make.count;										
								line['text4R'],line['text4G'],line['text4B'] = self:ItemColor("pots",i,self.db.profile.data.pots[i].make.count);																			
							end							
							cat:AddLine(line);												
						end
					end 
				end

				cat:AddLine(
					'text', " "
				)											
			end			
		end
		
		if (self.db.profile.showHideDetails) and (not self.db.profile.hideOverview) then
			local line = {};						
		
			line['text'] = ""
			cat:AddLine(line);
		
			line['text'] = "   clear details <-"
			line['textR'] = 1;
			line['textG'] = 0;
			line['textB'] = 0;
			line['func'] = 'OnItemClick'
			line['arg1'] = self			
			line['arg2'] = self.clearSelectionString
			line['arg3'] = "";
			cat:AddLine(line);			
		end
	end
	
	if self.db.profile.hideOverview and self.db.profile.displayCat and self.db.profile.displayItem then
		local line = {};						
		
		line['text'] = ""
		cat:AddLine(line);
		
		line['text'] = "   back <-"
		line['textR'] = 1;
		line['textG'] = 0;
		line['textB'] = 0;
		line['func'] = 'OnItemClick'
		line['arg1'] = self			
		line['arg2'] = self.clearSelectionString
		line['arg3'] = "";
		cat:AddLine(line);
	else		
		for i in self.db.profile.tipOrder do
			local ct = self.db.profile.tipOrder[i];
			--DEFAULT_CHAT_FRAME:AddMessage(ct); 
			if (self.db.profile.data[ct]) then
				--DEFAULT_CHAT_FRAME:AddMessage(i); 
				local line = {};						
				line['text'] = ct
				if (ct == "pots") then					
					line['text2'] = "avail";	
					line['text3'] = "make";				
					line['text4'] = "total";				
				end			
				line['hasCheck'] = false								
				cat:AddLine(line);
						
				for j in self.tempData[ct] do			
					if (self.db.profile.data[ct][self.tempData[ct][j]]) and ((self.db.profile.data[ct][self.tempData[ct][j]].checked) or (useAlt)) then
						local line = {};	
				
						line['text'] = "   "..self.tempData[ct][j]
						line['textR'],line['textG'],line['textB'] = self:ItemColor(ct,self.tempData[ct][j],self.db.profile.data[ct][self.tempData[ct][j]].total);
						line['text2R'] = line['textR']
						line['text2G'] = line['textG']
						line['text2B'] = line['textB']					
						line['text2'] = self.db.profile.data[ct][self.tempData[ct][j]].total;					
						if (ct == "pots") and (self.db.profile.data[ct][self.tempData[ct][j]].make) then
							line['text3'] = self.db.profile.data[ct][self.tempData[ct][j]].make.count;
							line['text3R'],line['text3G'],line['text3B'] = self:ItemColor(ct,self.tempData[ct][j],self.db.profile.data[ct][self.tempData[ct][j]].make.count);
												
							local all =	self.db.profile.data[ct][self.tempData[ct][j]].total + self.db.profile.data[ct][self.tempData[ct][j]].make.count;						
							line['text4'] = all;						
							line['text4R'],line['text4G'],line['text4B'] = self:ItemColor(ct,self.tempData[ct][j],all);						
						end
						line['func'] = 'OnItemClick'
						line['arg1'] = self			
						line['arg2'] = ct
						line['arg3'] = self.tempData[ct][j]
					
						cat:AddLine(line);				
					end
				end
			end			
		end				
	end
end


function PotHerbFu:GatherTotalStats()
	if (not self.db.profile.totalStats) then
		self.db.profile.totalStats = {};
	end	
	self.db.profile.totalStats.selectedItems = 0;
	self.db.profile.totalStats.items = 0;
	self.db.profile.totalStats.itemCount = 0;
	self.db.profile.totalStats.makeAble = 0;
	
	for l in self.db.profile.data do --herbs/pots/misc
		for k in self.db.profile.data[l] do --names of above
			self.db.profile.totalStats.items = self.db.profile.totalStats.items + 1;
			self.db.profile.totalStats.itemCount= self.db.profile.totalStats.itemCount + self.db.profile.data[l][k].total;
			if (self.db.profile.data[l][k].make) and (self.db.profile.data[l][k].make.count) then
				self.db.profile.totalStats.makeAble = self.db.profile.totalStats.makeAble + self.db.profile.data[l][k].make.count;
			end
			if (self.db.profile.data[l][k].checked) then
				self.db.profile.totalStats.selectedItems = self.db.profile.totalStats.selectedItems + 1;
			end
		end
	end	
end

function PotHerbFu:OnClick()
	
	if (IsShiftKeyDown()) then
		self:CalcMakeablePots();
		return;
	end
	if (IsControlKeyDown()) then
		self:OpenAndImportCrafts();
	end
		
	if (IsAltKeyDown()) then
		self:ClearConfirm();
	end		
	
	if (not self.db.profile.totalStats) then
		self.db.profile.totalStats = {};
	end	
	
	self.db.profile.totalStats.players = 0;
	self.db.profile.totalStats.bags = 0;	
	
	
	for l in self.db.profile.data do --herbs/pots/misc
		for k in self.db.profile.data[l] do --names of above
			if (not self.db.profile.data[l][k].charData) then
				self.db.profile.data[l][k].charData = {};
			end
			for m in self.db.profile.data[l][k].charData do -- user names
				--DEFAULT_CHAT_FRAME:AddMessage(l.."-"..k.."-"..m); 
				self.db.profile.data[l][k].charData[m].bank = 0;
				self.db.profile.data[l][k].charData[m].bags = 0;
				self.db.profile.data[l][k].charData[m].box = 0;
			end
			self.db.profile.data[l][k].total = 0;
		end
	end
	
	--DEFAULT_CHAT_FRAME:AddMessage("Stuff Cleared"); 
	
	--[[if not (OneView) and BagnonDB and (BagnonDB.GetBagData) and (BagnonDB.GetItemData) then	
		for k in BagnonForeverData[currentRealm] do 
			--DEFAULT_CHAT_FRAME:AddMessage(k); 
			for j=-2,10,1 do
				local size,baglink,bagcount = BagnonDB.GetBagData(k,j);
				if (size) then
					--DEFAULT_CHAT_FRAME:AddMessage("Bag ID : "..j.." Size : "..size.." Count : "..bagcount); 
					for i=1,size,1 do
						local itemlink,itemcount,_,_ = BagnonDB.GetItemData(k,j,i);
						if (itemlink) and (itemcount) then
							local itemname, _, _, _, _, _, _, _, _ = GetItemInfo(itemlink);
							--DEFAULT_CHAT_FRAME:AddMessage("Slot ID : "..i.." Name : "..itemname.." Count : "..itemcount); 							 
							for l in self.db.profile.data do 
								if (self.db.profile.data[l][itemname]) then
									if ( not self.db.profile.data[l][itemname].charData[k]) then
									  self.db.profile.data[l][itemname].charData[k]= {};
									  self.db.profile.data[l][itemname].charData[k].bank = 0;
									  self.db.profile.data[l][itemname].charData[k].bags = 0;
									end
									self.db.profile.data[l][itemname].total = self.db.profile.data[l][itemname].total + itemcount;
									if (j <=4) and (j >= 0) then
										self.db.profile.data[l][itemname].charData[k].bags = self.db.profile.data[l][itemname].charData[k].bags + itemcount;
									else
										self.db.profile.data[l][itemname].charData[k].bank = self.db.profile.data[l][itemname].charData[k].bank + itemcount;
									end
								end
							end
						end
					end
				end
			end			
		end
	end	]]--
	
	if (OneView) and (OneView.storage) then
		--DEFAULT_CHAT_FRAME:AddMessage("starting Char list"); 
		local list = OneView.storage:GetCharListByServerId()
	
		for serverId, v in list do
			local _, _, server, faction = string.find(serverId, "(.+) . (.+)")
			while string.find(server, "(.+) (.+)")  do
 	      local _, _, p1, p2 = string.find(server, "(.+) (.+)")
   	    server = p1..p2         
      end  	      
      --DEFAULT_CHAT_FRAME:AddMessage("server "..server.." fact "..faction); 
			for k, v2 in v do
				self.db.profile.totalStats.players = self.db.profile.totalStats.players +1;
				local fact = faction
				local _, _, charName, charId = string.find(v2, "(.+) . (.+)")
				--DEFAULT_CHAT_FRAME:AddMessage("name "..charName.." id "..charId); 
				if (OneView.BuildFrame) then
					--DEFAULT_CHAT_FRAME:AddMessage("loading char "..fact.." id "..charId); 
					--OneView:LoadCharacter(fact, charId);					
					OneView.faction = fact
					OneView.charId = charId	
					OneView:BuildFrame();
					OneView:OrganizeFrame()
					OneView:FillBags()					
					
					for bag = -1, 10 do
						self.db.profile.totalStats.bags = self.db.profile.totalStats.bags + 1;
						local curBag = OneView.frame.bags[bag]
						--DEFAULT_CHAT_FRAME:AddMessage("bag id "..bag); 
						if curBag and curBag.size and curBag.size > 0 then
							--DEFAULT_CHAT_FRAME:AddMessage("size "..curBag.size); 
							for slot = 1, curBag.size do
								local itemId, qty = OneView.storage:SlotInfo(OneView.faction, OneView.charId, bag, slot)
								if itemId then
									local itemName, _, _, _, _, _, _, _, _ = GetItemInfo(itemId)									
	--								if (charName == "Sandrielle") then
		--								DEFAULT_CHAT_FRAME:AddMessage("Slot ID : "..slot.." Name : "..itemName.." : "..qty); 							 
			--						end
									--implement structures here							
									if (itemName) then
										for l in self.db.profile.data do 
											if (self.db.profile.data[l][itemName]) then
												if ( not self.db.profile.data[l][itemName].charData[charName]) then
												  self.db.profile.data[l][itemName].charData[charName]= {};
												  self.db.profile.data[l][itemName].charData[charName].bank = 0;
												  self.db.profile.data[l][itemName].charData[charName].bags = 0;
												  self.db.profile.data[l][itemName].charData[charName].box = 0;
												end
												self.db.profile.data[l][itemName].total = self.db.profile.data[l][itemName].total + qty;
												if (bag <=4) and (bag >= 0) then
													self.db.profile.data[l][itemName].charData[charName].bags = self.db.profile.data[l][itemName].charData[charName].bags + qty;
												else
													self.db.profile.data[l][itemName].charData[charName].bank = self.db.profile.data[l][itemName].charData[charName].bank + qty;
												end
											end
										end
									end									
								end
							end
						end
					end						
				end
			end
		end
	end
	
	if (self.db.profile.mailbox) then
		for cname in self.db.profile.mailbox do			
			for mbitem in self.db.profile.mailbox[cname] do
				for l in self.db.profile.data do 
					if (self.db.profile.data[l][mbitem]) then
						--DEFAULT_CHAT_FRAME:AddMessage("item : "..mbitem.." bag "..l.." Name : "..cname); 							 
						if (not self.db.profile.data[l][mbitem].charData[cname]) then
						  self.db.profile.data[l][mbitem].charData[cname]= {};
						  self.db.profile.data[l][mbitem].charData[cname].bank = 0;
						  self.db.profile.data[l][mbitem].charData[cname].bags = 0;
						  self.db.profile.data[l][mbitem].charData[cname].box = 0;
						end
						self.db.profile.data[l][mbitem].total = self.db.profile.data[l][mbitem].total + self.db.profile.mailbox[cname][mbitem];
						self.db.profile.data[l][mbitem].charData[cname].box = self.db.profile.data[l][mbitem].charData[cname].box + self.db.profile.mailbox[cname][mbitem];
					end
				end													
			end
		end
	end		
	
	self.db.profile.lastItemScan = date("%A, %B %d, %Y - %H:%M");
	HideDropDownMenu(1);
end

function PotHerbFu:CalcMakeablePots()
	for k in self.db.profile.data.pots do
		--DEFAULT_CHAT_FRAME:AddMessage("-"..k); 
		local presentPot = self.db.profile.data.pots[k];
		
		local makeAmount = 99999999;
		local makeLimit = "";
		local makeLimitCat = "";
		local limitAmount = 0;
		
		if (presentPot["req"]) then
			for j in presentPot["req"] do
				local ing = presentPot["req"][j];
				--DEFAULT_CHAT_FRAME:AddMessage("->"..j.." - "..ing.count.." - "..ing.cat); 			
				if (self.db.profile.data[ing.cat]) and (self.db.profile.data[ing.cat][j]) and (self.db.profile.data[ing.cat][j].total) then				  --  and (self.db.profile.data[ing.cat][j].total > 0) 
				  local amt = math.floor(self.db.profile.data[ing.cat][j].total / ing.count);				  
				  --DEFAULT_CHAT_FRAME:AddMessage("--->"..j.." - "..self.db.profile.data[ing.cat][j].total.." - "..amt);
				  if (amt < makeAmount) then
				  	makeAmount = amt;
				  	makeLimit = j;
				  	makeLimitCat = ing.cat;
				  	limitAmount = self.db.profile.data[ing.cat][j].total;				  	
				  end
				end					
			end
		end
		
		if (not presentPot.make) then
			presentPot.make = {};			
		end
		presentPot.make.count = makeAmount;
		presentPot.make.limit = makeLimit;
		presentPot.make.limitCount = limitAmount;
		presentPot.make.limitCat = makeLimitCat;
	end	
	HideDropDownMenu(1);
	self.db.profile.lastPotCalculation = date("%A, %B %d, %Y - %H:%M");
end

function PotHerbFu:ClearConfirm()
	HideDropDownMenu(1);
	StaticPopupDialogs["FUBARPotHerb_CLEAR"] = {
		text = "Confirm you want to reset ALL settings ?",
		button1 = TEXT(OKAY),
		button2 = TEXT(CANCEL),
		OnAccept = function()
			self.db.profile.limitSelectionChanged = 1;
			self:ClearData();
		end,
		timeout = 0,
		exclusive = 1
	};
	StaticPopup_Show("FUBARPotHerb_CLEAR");
	PotHerbFu:UpdateText();
end

function PotHerbFu:GetValue()
	local _,_,ct,_ = string.find(self.db.profile.lastMenuVal,"(.+)_(.+)");
	if (not ct) then
		return
	end
	if (self.db.profile.lastMenuVal) and (self.db.profile.tableValues[self.db.profile.lastMenuVal]) then
		--DEFAULT_CHAT_FRAME:AddMessage("Get of "..self.db.profile.tableValues[self.db.profile.lastMenuVal].."-"..self.db.profile.rangeType); 
		if (self.db.profile.rangeType) then
			--DEFAULT_CHAT_FRAME:AddMessage("Value "..self.db.profile.data["herbs"][self.db.profile.tableValues[self.db.profile.lastMenuVal]][self.db.profile.rangeType]); 			
			return self.db.profile.data[ct][self.db.profile.tableValues[self.db.profile.lastMenuVal]][self.db.profile.rangeType];
		end
	end		
	--DEFAULT_CHAT_FRAME:AddMessage("None "); 			
end

function PotHerbFu:SetValue(value)
	local _,_,ct,_ = string.find(self.db.profile.lastMenuVal,"(.+)_(.+)");
	if (not ct) then
		return
	end	
	if (self.db.profile.lastMenuVal) and (self.db.profile.tableValues[self.db.profile.lastMenuVal]) then
		--DEFAULT_CHAT_FRAME:AddMessage("Set of "..self.db.profile.tableValues[self.db.profile.lastMenuVal].."-"..self.db.profile.rangeType); 
		if (value) then
			--DEFAULT_CHAT_FRAME:AddMessage("Value "..value); 
			self.db.profile.data[ct][self.db.profile.tableValues[self.db.profile.lastMenuVal]][self.db.profile.rangeType] = value;
		end
	end		
end

function PotHerbFu:OnMenuRequest(level, value, x, valueN_1, valueN_2, valueN_3, valueN_4)	
	self.db.profile.displayCat = nil;
	self.db.profile.displayItem = nil;
	
	if (self.db.profile.limitSelectionChanged) then
		self:CreateOptionsTable();	
		self.db.profile.limitSelectionChanged = nil;
	end
	if (value) then
		self.db.profile.lastMenuVal = value;
		--DEFAULT_CHAT_FRAME:AddMessage("Set of "..value); 
	end	
	dewdrop:FeedAceOptionsTable(optionsTable)
end

function PotHerbFu:CreateOptionsTable()
	--DEFAULT_CHAT_FRAME:AddMessage("new options table "); 
	optionsTable.args.limits.args.limitherbs.args = {};
	optionsTable.args.limits.args.limitpots.args = {};
	optionsTable.args.limits.args.limitmisc.args = {};
	if (optionsTable.args.limits.args.limitherbs.args) then
		self.db.profile.tableValues = {};
		for k in self.db.profile.data do
			local j = 1;
			for i in self.db.profile.data[k] do
				if (not self.db.profile.data[k][i].green) then
					self.db.profile.data[k][i].green = 20;
					self.db.profile.data[k][i].orange = 10;
				end
				if (self.db.profile.data[k][i].checked) then
					--DEFAULT_CHAT_FRAME:AddMessage("setting options table "..i); 
					local rangeLine = {
						type = 'group',
						name = i,
						desc = i,
						args = {
							[""..k.."Green"..j] = {				
								type = 'range',
								name = "Green",
								desc = "If you have more items than this value the entry will show green",
								get = function()
									PotHerbFu.db.profile.rangeType = "green";
									return PotHerbFu:GetValue();
								end,
								set = function(v)
									PotHerbFu.db.profile.rangeType = "green";
									PotHerbFu:SetValue(v);
								end,
								min = PotHerbFu.db.profile.valueMin,
								max = PotHerbFu.db.profile.valueMax,
								step = PotHerbFu.db.profile.valueStep,
								order = j				
							},
							[""..k.."Orange"..j] = {				
								type = 'range',
								name = "Orange",
								desc = "If you have more items than this value the entry will show orange (must be smaller than green value or will be set to green)",
								get = function()
									PotHerbFu.db.profile.rangeType = "orange";
									return PotHerbFu:GetValue();
								end,
								set = function(v)
									PotHerbFu.db.profile.rangeType = "orange";
									PotHerbFu:SetValue(v);
								end,
								min = PotHerbFu.db.profile.valueMin,
								max = PotHerbFu.db.profile.valueMax,
								step = PotHerbFu.db.profile.valueStep,
								order = j				
							}					
						}					
					}
					optionsTable.args.limits.args["limit"..k].args[""..k.."_Line"..j] = rangeLine;
					self.db.profile.tableValues[""..k.."_Line"..j] = i;
					j= j + 1;			
				end
			end				
		end
	else
		DEFAULT_CHAT_FRAME:AddMessage("Error in options table"); 
	end		
end

function PotHerbFu:IsSpecialPot(pot) -- if this pot is used to make other pots
	local ret;
	for i in self.db.profile.specialPots do
		if self.db.profile.specialPots[i] == pot then
			ret = 1;
			break;
		end
	end
	return ret;
end

function PotHerbFu:OpenAndImportCrafts()	
	self:CreateData();
	local i=1;
	while true do
		local spellName, spellRank = GetSpellName(i, "spell" ) 
		if (not spellName) then
			break;
		end
		if (spellName == "Alchemy") then
			if (GetNumTradeSkills() > 0) then
				--DEFAULT_CHAT_FRAME:AddMessage("Something Open : "); 
				CloseTradeSkill();
			end
			CastSpell(i, "spell");
			self:ImportCrafts()
			-- getcrafts here				
			break;
		end
		i = i + 1;
	end
	CloseTradeSkill();
	self:CreateSortedTables();
	self:CreateOptionsTable();	
	self.db.profile.limitSelectionChanged = nil;	
	PotHerbFu:UpdateText();
end

function PotHerbFu:ImportCrafts()
	if (not self.db.profile.data["pots"]) then
		self.db.profile.data["pots"] = {};
	end				
	if (not self.db.profile.data["misc"]) then
		self.db.profile.data["misc"] = {};
	end					
	--DEFAULT_CHAT_FRAME:AddMessage("Importing : "..GetNumTradeSkills()); 
	for i=1, GetNumTradeSkills(), 1 do		
		local name, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i);		
		local num = GetTradeSkillNumReagents(i);
		--DEFAULT_CHAT_FRAME:AddMessage("Craft : "..i.." : "..name.." SN : "..skillType.." TY : "..num); 				
		if (num > 0) then -- dont get headers
			local getReagents = 2;
			if (string.find(name,"Transmute:(.+)")) then
				--DEFAULT_CHAT_FRAME:AddMessage("Transmute"); 				
				getReagents = 1;
			elseif (string.find(name,"Philosopher(.+)")) then
				--DEFAULT_CHAT_FRAME:AddMessage("Phil stone"); 				
				getReagents = 0;
			end 
			if (getReagents > 0) then
				if (getReagents == 2) then -- add it to pot list
					--DEFAULT_CHAT_FRAME:AddMessage("Adding "..name); 				
					if (not self.db.profile.data["pots"][name]) then
						self.db.profile.data["pots"][name] = {};
						self.db.profile.data["pots"][name].req = {};
					end
				end
				for j=1, num, 1 do
					local reagentName, _, reagentCount = GetTradeSkillReagentInfo(i, j);
					if (getReagents == 2) then -- add it to req list
						if (self.db.profile.filterVials) and (string.find(reagentName,"(%a+) Vial")) then -- dont add it
						else					
							self.db.profile.data["pots"][name].req[reagentName] = {};
							self.db.profile.data["pots"][name].req[reagentName].count = reagentCount;
							if (self.db.profile.data["herbs"][reagentName]) then
								self.db.profile.data["pots"][name].req[reagentName].cat = "herbs";
							else
								self.db.profile.data["pots"][name].req[reagentName].cat = "misc";
								if (not self.db.profile.data["misc"][reagentName]) then -- also create the entry if it doesnt exist
									local addIt = 1;
									if (self.db.profile.filterVials) then
										if (string.find(reagentName,"(%a+) Vial")) then
											addIt = nil;
										end
									end
									if (self.db.profile.filterPots) then
										if (self:IsSpecialPot(reagentName)) then -- potion that is also a reagent
											self.db.profile.data["pots"][name].req[reagentName].cat = "pots";
											addIt = nil;
										end
									end
									if (addIt) then
										self.db.profile.data["misc"][reagentName] = {};
									end
								end
							end						
						end
					else -- only add entries if they dont exist
						if (not self.db.profile.data["herbs"][reagentName]) then
							if (not self.db.profile.data["misc"][reagentName]) then -- create the entry if it doesnt exist
								self.db.profile.data["misc"][reagentName] = {};
							end
						end												
					end
					--DEFAULT_CHAT_FRAME:AddMessage("        : "..i.." : "..reagentName.." x : "..reagentCount); 
				end
			end
		end
	end
end

function PotHerbFu:CreateData()
	if (not self.db.profile.data) then
		self.db.profile.data = {};
	end
	if (not self.db.profile.data["herbs"]) then
		self.db.profile.data["herbs"] = {};
	end		
	if (not self.db.profile.data["pots"]) then
		self.db.profile.data["pots"] = {};
	end			
	if (not self.db.profile.data["misc"]) then
		self.db.profile.data["misc"] = {};
	end						
	for i in self.db.profile.herbList do
		if (not self.db.profile.data["herbs"][self.db.profile.herbList[i]]) then
			self.db.profile.data["herbs"][self.db.profile.herbList[i]] =  {};
		end
	end
	for i in self.db.profile.addMisc do
		if (not self.db.profile.data["misc"][self.db.profile.addMisc[i]]) then
			self.db.profile.data["misc"][self.db.profile.addMisc[i]] = {};
		end
	end			
end

function PotHerbFu:CreateSortedTables()
	if (not self.tempData) then
		self.tempData = {};
	end
	for i in self.db.profile.data do
		self.tempData[i] = {};
		for j in self.db.profile.data[i] do
			table.insert(self.tempData[i],j);
		end
		table.sort(self.tempData[i]);
	end
end

function PotHerbFu:ClearData()	
	self.db.profile.data = {};
	self.db.profile.data["herbs"] = {};
	self.db.profile.data["pots"] = {};
	self.db.profile.data["misc"] = {};
	HideDropDownMenu(1);
end

function PotHerbFu:GetTimeString(timestamp)		
	local retval = {};
  retval.d = 0;
  retval.h = 0;
  retval.m = 0;
  retval.s = 0;
  -- 1 day: 86,400 seconds
  if ( timestamp >= 86400 ) then
  	retval.d = floor(timestamp / 86400);
    timestamp = (timestamp - (retval.d * 86400));
	end        
  -- 1 hour: 3,600 seconds
  if ( timestamp >= 3600 ) then
  	retval.h = floor(timestamp / 3600);
    timestamp = (timestamp - (retval.h * 3600));
  end
  -- 1 minute: 60 seconds
  if ( timestamp >= 60 ) then
  retval.m = floor(timestamp / 60);
  timestamp = (timestamp - (retval.m * 60));
  end
  retval.s = timestamp;

  return string.format("%dd %dh %dm %ds", retval.d, retval.h, retval.m, retval.s);
end