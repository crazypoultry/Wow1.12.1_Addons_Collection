local L = AceLibrary("AceLocale-2.2"):new("FuBar_GarbageFu")
local Tablet = AceLibrary("Tablet-2.0");
local dewdrop = AceLibrary("Dewdrop-2.0");
local compost = AceLibrary("Compost-2.0");
local abacus = AceLibrary("Abacus-2.0");
local crayon = AceLibrary("Crayon-2.0")
local PeriodicTable = PeriodicTableEmbed:GetInstance("1");

GarbageFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0", "AceDB-2.0", "AceDebug-2.0");
GarbageFu.version = "2.0." .. string.sub("$Revision: 16894 $", 12, -3);
GarbageFu.date = string.sub("$Date: 2006-11-13 15:29:21 -0500 (Mon, 13 Nov 2006) $", 8, 17);
GarbageFu.hasIcon = true;
GarbageFu.clickableTooltip = true;
GarbageFu.overrideMenu = true;
GarbageFu.printFrame = DEFAULT_CHAT_FRAME;
GarbageFu.debugFrame = DEFAULT_CHAT_FRAME;

GarbageFu:RegisterDB("GarbageFuDB");
GarbageFu:RegisterDefaults("profile", {
	moneyformat = 1,
	namelength = 32,
	ignoreammobag = true,
	ignoreherbbag = false,
	ignoresoulbag = false,
	ignoreenchbag = false,
	sellallbutton = true,
	sellonlygrey = true,
	pricetype = false,
	garbageprices = false,
	itemicon = false,
	showbagslots = true,
	showtotalslots = true,
	showfreeslots = true,
	version = "",
	textcolor = { r=0.2, g=0.8, b=1 };
	threshold = 0,
	dropsets = {},
	dropitem = {},
	keepsets = {},
	keepitem = {},
	droptypes = {},
	keeptypes = {},
	auctionsets = {},
	auctionitem = {},
	auctioncache = {},
	auctionThreshold = 3;
	auctionaddonsorder = {},
	vendoraddonsorder = {},
});

GarbageFu:RegisterDefaults("account", {
	overrideprices = {},
});

GarbageFu:RegisterDefaults("realm", {
	auctioncache = {},
});

------------------------------------------------------------------------------------------------------
-- Simple Property functions
------------------------------------------------------------------------------------------------------

function GarbageFu:GetDropThreshold()
	return self.db.profile.threshold;
end

function GarbageFu:IsDropThreshold(value)
	return self.db.profile.threshold == tonumber(value);
end

function GarbageFu:SetDropThreshold(value)
	self.db.profile.threshold = tonumber(value);
	self:UpdateDisplay();
end

function GarbageFu:GetMoneyFormat(value)
	return self.db.profile.moneyformat;
end

function GarbageFu:SetMoneyFormat(value)
	self.db.profile.moneyformat = tonumber(value);
	self:UpdateDisplay();
end

function GarbageFu:GetNameLength(value)
	return self.db.profile.namelength;
end

function GarbageFu.SetNameLength(self,value)
	self.db.profile.namelength = value;
	self:UpdateText();
end

function GarbageFu:IsIgnoringAmmoBag()
	return self.db.profile.ignoreammobag;
end

function GarbageFu:ToggleIgnoreAmmoBag()
	self.db.profile.ignoreammobag = not self.db.profile.ignoreammobag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringHerbBag()
	return self.db.profile.ignoreherbbag;
end

function GarbageFu:ToggleIgnoreHerbBag()
	self.db.profile.ignoreherbbag = not self.db.profile.ignoreherbbag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringSoulBag()
	return self.db.profile.ignoresoulbag;
end

function GarbageFu:ToggleIgnoreSoulBag()
	self.db.profile.ignoresoulbag = not self.db.profile.ignoresoulbag;
	self:InitBagScan();
end

function GarbageFu:IsIgnoringEnchBag()
	return self.db.profile.ignoreenchbag;
end

function GarbageFu:ToggleIgnoreEnchBag()
	self.db.profile.ignoreenchbag = not self.db.profile.ignoreenchbag;
	self:InitBagScan();
end

function GarbageFu:IsSafeToDelete()
	return self.vars.safedelete;
end

function GarbageFu:SetSafeToDelete(value)
	self.vars.safedelete = value;
end

function GarbageFu:IsItemIcon()
	return self.db.profile.itemicon;
end

function GarbageFu:ToggleItemIcon()
	self.db.profile.itemicon = not self.db.profile.itemicon;
	if not self.db.profile.itemicon then
		self:SetIcon(true)
	else
		self:UpdateText();
	end
end

function GarbageFu:IsPriceType()
	return self.db.profile.pricetype;
end

function GarbageFu:TogglePriceType()
	self.db.profile.pricetype = not self.db.profile.pricetype;
	self:UpdateTooltip();
end

function GarbageFu:IsShowingBagSlots()
	return self.db.profile.showbagslots;
end

function GarbageFu:ToggleShowBagSlots()
	self.db.profile.showbagslots = not self.db.profile.showbagslots;
	self:UpdateText();
end

function GarbageFu:IsShowingFreeSlots()
	return self.db.profile.showfreeslots;
end

function GarbageFu:ToggleShowFreeSlots()
	self.db.profile.showfreeslots = not self.db.profile.showfreeslots;
	self:UpdateText();
end

function GarbageFu:IsShowingTotalSlots()
	return self.db.profile.showtotalslots;
end

function GarbageFu:ToggleShowTotalSlots()
	self.db.profile.showtotalslots = not self.db.profile.showtotalslots;
	self:UpdateText();
end

------------------------------------------------------------------------------------------------------
-- A little more complicate property functions
------------------------------------------------------------------------------------------------------

function GarbageFu:IsDropItem(itemid)
	if (self.db.profile.dropitem[itemid]) then return true end
end

function GarbageFu:ToggleDropItem(itemid)
	if (self.db.profile.dropitem[itemid]) then
		self.db.profile.dropitem[itemid] = nil;
	else
		self.db.profile.dropitem[itemid] = true;
		self.db.profile.keepitem[itemid] = nil;
	end
	self:UpdateDisplay();
end

function GarbageFu:IsKeepItem(itemid)
	if (self.db.profile.keepitem[itemid]) then return true end
end

function GarbageFu:ToggleKeepItem(itemid)
	if (self.db.profile.keepitem[itemid]) then
		self.db.profile.keepitem[itemid] = nil;
	else
		self.db.profile.keepitem[itemid] = true;
		self.db.profile.dropitem[itemid] = nil;
	end
	self:UpdateDisplay();
end

------------------------------------------------------------------------------------------------------
-- Constant data
------------------------------------------------------------------------------------------------------

GarbageFu.vars = {};
GarbageFu.vars.moneyformats = {
	{ name=L["Condensed"], ex=abacus:FormatMoneyCondensed(123456,true,true) },
	{ name=L["Short"], ex=abacus:FormatMoneyShort(123456,true,true) },
	{ name=L["Full"], ex=abacus:FormatMoneyFull(123456,true,true) },
	{ name=L["Extended"], ex=abacus:FormatMoneyExtended(123456,true,true) },
}
GarbageFu.vars.sets = {
	{id="foodall", name=L["Food"], sub = {
		{id="food", name=L["Normal Food"], },
		{id="foodbonus", name=L["Bonus Food"], },
		{id="foodstat", name=L["Stat Food"], },
		{id="foodbreadconjured", name=L["Conjured Bread"], },
		{id="foodraw", name=L["Raw Food"], },
		{id="foodclassbread", name=L["Bread"], },
		{id="foodclassfish", name=L["Fish"], },
		{id="foodclassmeat", name=L["Meat"], },
		{id="foodclasscheese", name=L["Cheese"], },
		{id="foodclassfruit", name=L["Fruit"], },
		{id="foodclassfungus", name=L["Fungus"], },
	}, },
	{id="waterall", name=L["Water"], sub = {
		{id="water", name=L["Normal Water"], },
		{id="waterperc", name=L["Percent Water"], },
		{id="waterconjured", name=L["Conjured Water"], },
	}, },
	{id="booze", name=L["Booze"], },
	{id="tradeskill", name=L["Tradeskill"], sub = {
		{id="tradeskillalchemy", name=L["Alchemy"], },
		{id="tradeskillblacksmithing", name=L["Blacksmithing"], },
		{id="tradeskillcooking", name=L["Cooking"], },
		{id="tradeskillenchanting", name=L["Enchanting"], },
		{id="tradeskillengineering", name=L["Engineering"], },
		{id="tradeskillfirstaid", name=L["First Aid"], },
		{id="tradeskillleatherworking", name=L["Leatherworking"], },
		{id="tradeskilltailoring", name=L["Tailoring"], },
		{id="tradeskillpoison", name=L["Poison"], },
		{id="tradeskillsmelting", name=L["Smelting"], },
	}, },
	{id="tradeskilltools", name=L["Tradeskill Tools"], },
	{id="gatherskill", name=L["Gathered"], sub = {
		{id="gatherskillfishing", name=L["Fishing"], },
		{id="gatherskilldisenchant", name=L["Disenchant"], },
		{id="gatherskillherbalism", name=L["Herbalism"], },
		{id="gatherskillmining", name=L["Mining"], },
		{id="gatherskillskinning", name=L["Skinning"], },
	}, },
	{id="recipe", name=L["Recipe"], auctionOnly=true, sub = {
		{id="recipealchemy", name=L["Alchemy"], auctionOnly=true},
		{id="recipeblacksmith", name=L["Blacksmithing"], auctionOnly=true},
		{id="recipecooking", name=L["Cooking"], auctionOnly=true},
		{id="recipeenchanting", name=L["Enchanting"], auctionOnly=true},
		{id="recipeengineering", name=L["Engineering"], auctionOnly=true},
		{id="recipefishing", name=L["Fishing"], auctionOnly=true},
		{id="recipefirstaid", name=L["First Aid"], auctionOnly=true},
		{id="recipeleatherworking", name=L["Leatherworking"], auctionOnly=true},
		{id="recipetailoring", name=L["Tailoring"], auctionOnly=true},
	}, },
	{id="ammo", name=L["Ammunition"], auctionOnly=true },
	{id="bandages", name=L["Bandages"], },
	{id="explosives", name=L["Explosives"], },
	{id="faire", name=L["Darkmoon Fair"], },
	{id="fireworks", name=L["Fireworks"], },
	{id="poisons", name=L["Poisons"], },
	{id="potionall", name=L["Potions"], sub = {
		{id="potionhealall", name=L["Heal Potions"], },
		{id="potionmanaall", name=L["Mana Potions"], },
		{id="potionrage", name=L["Rage Potions"], },
		{id="potioncure", name=L["Cure Potions"], },
		{id="potionbuff", name=L["Buff Potions"], },
	}, },
	{id="scrolls", name=L["Scrolls"], },
	{id="reagent", name=L["Reagents"], sub = {
		{id="reagentpaladin", name=L["Paladin"], },
		{id="reagentdruid", name=L["Druid"], },
		{id="reagentmage", name=L["Mage"], },
		{id="reagentpriest", name=L["Priest"], },
		{id="reagentrogue", name=L["Rogue"], },
		{id="reagentshaman", name=L["Shaman"], },
		{id="reagentwarlock", name=L["Warlock"], },
	}, },
	{id="weapontempenchants", name=L["Weapon Enchants"], },
	{id="mounts", name=L["Mounts"], },
	{id="minipetall", name=L["Mini Pets"], },
}

------------------------------------------------------------------------------------------------------
-- FuBar required functions
------------------------------------------------------------------------------------------------------

function GarbageFu:OnInitialize()
	-- Put stuff that only neeeds to be done once here
	-- We want the profile to be the same as in FuBar. I will be if it is changed in FuBar, but on first load it is not. Bug?
	if ( FuBar and self:GetProfile() ~= FuBar:GetProfile() ) then
		local short = FuBar:GetProfile();
		self:SetProfile(short);
	end
	self:RegisterEvent("AceEvent_FullyInitialized","OnFullyInitialized",true);
	self.vars.bags = self:GetTable();
	self.vars.items = self:GetTable();
	self.vars.pricecache = self:GetTable();
	self.vars.auctioncache = self:GetTable();
	-- Get Item quality colors
	self.vars.colors = self:GetTable();
	for i=0,6 do
		self.vars.colors[i] = self:GetTable();
		self.vars.colors[i].r, self.vars.colors[i].g, self.vars.colors[i].b, self.vars.colors[i].hex = GetItemQualityColor(i);
		self.vars.colors[i].desc = getglobal("ITEM_QUALITY".. i.. "_DESC");
	end
	-- Create Static dialog for Reset Settings
	StaticPopupDialogs["GARBAGEFU_RESET"] = {
  	text = L["Are you sure you want to reset all your settings for GarbageFU?"],
  	button1 = TEXT(ACCEPT),
  	button2 = TEXT(CANCEL),
  	OnAccept = function() GarbageFu.SettingsReset(self)	end,
	  timeout = 0,
	  whileDead = 1,
 		hideOnEscape = 1
	};
	-- Check for any needed upgrades of settings
	self:CheckSettings();
	-- Store AddOn version. In case we need to check it in the future for upgrades.
	self.db.profile.version = self.version;
end

function GarbageFu:OnEnable()
	-- Stuff that needs to be done every time the mod is enabled
	self:SetSafeToDelete(false);
	if self.vars.initialized then
		self:InitVendor();
		self:InitAuction();
	end
	self:MainInit();
	self:OnEnteringWorld();
	self:SetSafeToDelete(true);
end

function GarbageFu:OnDisable()
	self:SetSafeToDelete(false);
	self:HideSellAllButton();
end

function GarbageFu:OnProfileEnable()
	self:CheckSettings();
	if self.vars.initialized then self:MainInit() end -- Reload all the settings if the profile was changed after we entered the world.
end

function GarbageFu:OnFullyInitialized()
	self.vars.initialized = true;
	if not self:IsDisabled() then
		self:InitVendor();
		self:InitAuction();
		self:UpdateAllItemValues()
		self:Update();
	end
end

function GarbageFu:OnEnteringWorld()
	if not self:IsEventRegistered("BAG_UPDATE") then self:RegisterEvent("BAG_UPDATE","OnBagUpdate") end
	if not self:IsEventRegistered("MERCHANT_SHOW") then self:RegisterEvent("MERCHANT_SHOW","OnMerchantOpen") end
	if not self:IsEventRegistered("MERCHANT_CLOSED") then self:RegisterEvent("MERCHANT_CLOSED","OnMerchantClose") end
	if not self:IsEventRegistered("ADDON_LOADED") then self:RegisterEvent("ADDON_LOADED","OnAddOnLoaded") end
	if not self:IsEventRegistered("PLAYER_LEAVING_WORLD") then self:RegisterEvent("PLAYER_LEAVING_WORLD","OnLeavingWorld") end
	if self:IsEventRegistered("PLAYER_ENTERING_WORLD") then self:UnregisterEvent("PLAYER_ENTERING_WORLD") end
end

function GarbageFu:OnLeavingWorld()
	if not self:IsEventRegistered("PLAYER_ENTERING_WORLD") then self:RegisterEvent("PLAYER_ENTERING_WORLD","OnEnteringWorld") end
	if self:IsEventRegistered("BAG_UPDATE") then self:UnregisterEvent("BAG_UPDATE") end
	if self:IsEventRegistered("MERCHANT_SHOW") then self:UnregisterEvent("MERCHANT_SHOW") end
	if self:IsEventRegistered("MERCHANT_CLOSED") then self:UnregisterEvent("MERCHANT_CLOSED") end
	if self:IsEventRegistered("ADDON_LOADED") then self:UnregisterEvent("ADDON_LOADED") end
	if self:IsEventRegistered("PLAYER_LEAVING_WORLD") then self:UnregisterEvent("PLAYER_LEAVING_WORLD") end
end

function GarbageFu:OnDataUpdate()
end

function GarbageFu:OnTextUpdate()
	if not self.vars.initialized then return end
	local text = "";
	if self:IsShowingBagSlots() then text = self:GetBagSlots() end
	local item = self:GetFirstDroppableItem();
	if item then
		if ( string.len(item.name) > self:GetNameLength() ) then
			text = text..self.vars.colors[item.qual].hex..string.sub(item.name, 1, self:GetNameLength()-2).."..".."|r";
		else
			text = text..self.vars.colors[item.qual].hex..item.name.."|r";
		end
		if ( item.maxstack > 1 ) then
			text = text.." |cffffff00x"..tostring(item.stack).."|r";
		end
		text = text.." "..self:GetMoneyString(item.totvalue);
		if self:IsItemIcon() then self:SetIcon(item.tex) end
	else
		if self:IsItemIcon() then self:SetIcon(true) end
		text = text.."|cff777777"..L["No items to drop"].."|r";
	end
	self:SetText(text);
	self:HighlightSellAllButton();
end

function GarbageFu:OnTooltipUpdate()
	if not self.vars.initialized then return end
	local cat;
	if self:IsPriceType() then
		cat = Tablet:AddCategory('columns', 3, 'child_justify2', 'right')
	else
		cat = Tablet:AddCategory('columns', 2)
	end
	local total = 0;
	local items = 0;
	for i,item in ipairs(self.vars.items) do
		if self:IsItemDroppable(item) then
			local stacktext = "|r";
			if ( item.maxstack > 1 ) then
				stacktext = stacktext .. "|r |cffffff00("..tostring(item.stack).."/"..tostring(item.maxstack)..")|r";
			end
			total = total + item.totvalue;
			items = items + 1;
			cat:AddLine(
				'text', self.vars.colors[item.qual].hex..item.name..stacktext,
				'text2', self:GetMoneyString(item.totvalue),
				'text3', item.pricetype,
				'hasCheck', true, 'checked', true, 'checkIcon', item.tex,
				'func', 'OnClickItem', 'arg1', self, 'arg2', item
			)
		end
	end
	if items > 1 then
		cat:AddLine('text', L["Total"], 'justify', 'right', 'text2', self:GetMoneyString(total));
	end
	if MerchantFrame:IsVisible() then
		Tablet:SetHint(L["Hint1"]);
	else
		Tablet:SetHint(L["Hint2"]);
	end
end

function GarbageFu:OnMenuRequest(level, value, inTooltip, value2)
	if not self.vars.initialized then return end
	if value then
		if value2 then
			self:DebugPrint("OnMenuRequest level="..level.." value="..value.." value2="..value2);
		else
			self:DebugPrint("OnMenuRequest level="..level.." value="..value);
		end
	else
		self:DebugPrint("OnMenuRequest level="..level);
	end
	if ( level == 1 ) then
		local item = self:GetFirstDroppableItem();
		if item then
			local text = self.vars.colors[item.qual].hex..item.name.."|r";
			if ( item.maxstack > 1 ) then
				text = text.." |cffffff00x"..tostring(item.stack).."|r";
			end
			dewdrop:AddLine('text', text..' '..self:GetMoneyString(item.totvalue),
				'notClickable', true,	'checked', true, 'checkIcon', item.tex );
			local text = MerchantFrame:IsVisible() and L["Sell this item"] or L["Drop this item"];
			dewdrop:AddLine('text', text, 'arg1', self, 'func', 'DropFirstItem', 'tooltipTitle', text,
				'tooltipText', L["Drops this item, or sells it if the vendor window is open"] );
			if ( item.qual > 0 ) then
				dewdrop:AddLine('text', L["Keep this item"], 'arg1', self, 'func', 'KeepFirstItem',
					'tooltipTitle', L["Keep this item"], 'tooltipText', L["Adds this item to the keep items list"]);
			end
			self:BuildSellMenu(level, value, inTooltip, value2);
			if ( item.qual > 0 or item.totvalue == 0 or self.db.account.overrideprices[item.id]) then
				dewdrop:AddLine('text', L["Edit value for this item"], 'hasArrow', true,
					'hasEditBox', true, 'editBoxText', tostring(item.value),
					'editBoxArg1', self, 'editBoxFunc', GarbageFu.SetFirstItemValue,
					'editBoxChangeArg1', self, 'editBoxChangeFunc', GarbageFu.ValidateValue,
					'tooltipTitle', L["Edit value for this item"], 'tooltipText', L["Value TooltipText"] );
			end
			dewdrop:AddLine();
		end
		dewdrop:AddLine('text', L["Drop"], 'hasArrow', true, 'value', 'drop' );
		dewdrop:AddLine('text', L["Keep"], 'hasArrow', true, 'value', 'keep' );
		self:BuildAuctionMenu(level, value, inTooltip, value2)
		dewdrop:AddLine('text', L["Edit item values"], 'hasArrow', true, 'value', 'itemvalue' );
		dewdrop:AddLine();
		dewdrop:AddLine('text', L["Options"], 'hasArrow', true, 'value', 'options' );
	elseif ( level == 2 ) then
		if ( value == 'drop' ) then
			dewdrop:AddLine('text', L["Drop"], "isTitle", true );
			dewdrop:AddLine('text', L["Drop Sets"], 'hasArrow', true, 'value', 'dropsets' );
			self:BuildDropTypeMenu(level-1, value, inTooltip, value2);
			dewdrop:AddLine('text', L["Drop Items"], 'hasArrow', true, 'value', 'dropitem' );
		elseif ( value == 'keep' ) then
			dewdrop:AddLine('text', L["Keep"], "isTitle", true );
			dewdrop:AddLine('text', L["Keep Sets"], 'hasArrow', true, 'value', 'keepsets' );
			self:BuildKeepTypeMenu(level-1, value, inTooltip, value2);
			dewdrop:AddLine('text', L["Keep Items"], 'hasArrow', true, 'value', 'keepitem' );
		elseif ( value == 'itemvalue' ) then
			-- Edit item values
			dewdrop:AddLine('text', L["Edit item values"], "isTitle", true );
			local tbl = self:GetCustomItemValueTable();
			for _,i in ipairs(tbl) do
				dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name,
					'checked', self.db.account.overrideprices[i.id] ~= nil, 'hasArrow', true, 'hasEditBox', true,
					'editBoxText', tostring(i.value),
					'editBoxArg1', self, 'editBoxArg2', i.id, 'editBoxFunc', GarbageFu.SetItemValue,
					'editBoxChangeArg1', self, 'editBoxChangeFunc', GarbageFu.ValidateValue,
					'tooltipTitle', L["Edit value for this item"], 'tooltipText', L["Value TooltipText"]);
			end
			--compost:Reclaim(tbl,2);
			--tbl = nil;
		elseif ( value == 'options' ) then
			dewdrop:AddLine('text', L["Drop Threshold"], 'hasArrow', true, 'value', 'threshold' );
			dewdrop:AddLine('text', L["Money Format"], 'hasArrow', true, 'value', 'moneyformat' );
			dewdrop:AddLine('text', L["Max Item Name Length"], 'hasArrow', true,
				'hasSlider', true, 'sliderMin', 5, 'sliderMax', 32, 'sliderStep', 1,
				'sliderValue', self:GetNameLength(),
				'sliderFunc', GarbageFu.SetNameLength, 'sliderArg1', self );
			dewdrop:AddLine('text', L["Use Items Icon on Toolbar"], 'checked', self:IsItemIcon(),
				'arg1', self, 'func', 'ToggleItemIcon');
			dewdrop:AddLine('text', L["Show Bag slots on Toolbar"], 'hasArrow', true, 'value', 'bagslots',
				'checked', self:IsShowingBagSlots(), 'arg1', self, 'func', 'ToggleShowBagSlots');
			dewdrop:AddLine('text', L["Show Price Type in Tooltip"], 'checked', self:IsPriceType(),
				'arg1', self, 'func', 'TogglePriceType');
			self:BuildSellOptionsMenu(level-1, value, inTooltip, value2);
			self:BuildVendorOptionMenu(level-1, value, inTooltip, value2);
			self:BuildAuctionOptionMenu(level-1, value, inTooltip, value2);
			dewdrop:AddLine('text', L["Rescan Prices"],
				'arg1', self, 'func', 'UpdateAllItemValues',
				'tooltipTitle', L["Rescan Prices"], 'tooltipText', L["RescanPricesDesc"]);
			dewdrop:AddLine('text', L["Special Bags"], 'hasArrow', true, 'value', 'specialbag' );
			dewdrop:AddLine('text', L["Reset"], 'arg1', "GARBAGEFU_RESET", 'func', StaticPopup_Show, 'closeWhenClicked', true,
				'tooltipTitle', L["Reset"], 'tooltipText', L["ResetDesc"]);
			dewdrop:AddLine();
			self:AddImpliedMenuOptions(2);
		else
			self:BuildAuctionMenu(level, value, inTooltip, value2)
		end
	elseif ( level == 3 ) then
		if (value2 == 'drop') then
			if ( value == 'dropsets' ) then
				-- Drop - Sets
				dewdrop:AddLine('text', L["Drop Sets"], "isTitle", true );
				for n,i in ipairs(self.vars.sets) do
					if not i.auctionOnly then
						local checked = self:IsDropSetSelected(n);
						local checkIcon = "Interface\\Buttons\\UI-CheckBox-Check"
						if self:IsChildDropSetSelected(n) then
							checked = true;
							checkIcon = "Interface\\Buttons\\UI-CheckBox-Check-Disabled"
						end
						dewdrop:AddLine('text', i.name,
							'checked', checked, 'checkIcon', checkIcon,
							'disabled', self:IsKeepSetSelected(n),
							'hasArrow', i.sub ~= nil, 'value', n,
							'arg1', self, 'arg2', n, 'func', 'ToggleDropSet' );
					end
				end
			elseif ( value == 'dropitem' ) then
				-- Drop - Items
				dewdrop:AddLine('text', L["Drop Items"], "isTitle", true );
				local tbl = self:GetDropItemTable();
				for _,i in ipairs(tbl) do
					dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name,
						'checked', self:IsDropItem(i.id),
						'arg1', self, 'arg2', i.id, 'func', 'ToggleDropItem');
				end
				--compost:Reclaim(tbl,2);
				--tbl = nil;
			else
				self:BuildDropTypeMenu(level-1, value, inTooltip, value2);
			end
		elseif (value2 == 'keep') then
			if ( value == 'keepsets' ) then
				-- Keep - Sets
				dewdrop:AddLine('text', L["Keep Sets"], "isTitle", true );
				for n,i in ipairs(self.vars.sets) do
					if not i.auctionOnly then
						local checked = self:IsKeepSetSelected(n);
						local checkIcon = "Interface\\Buttons\\UI-CheckBox-Check"
						if self:IsChildKeepSetSelected(n) then
							checked = true;
							checkIcon = "Interface\\Buttons\\UI-CheckBox-Check-Disabled"
						end
						dewdrop:AddLine('text', i.name,
							'checked', checked, 'checkIcon', checkIcon,
							'disabled', self:IsDropSetSelected(n),
							'hasArrow', i.sub ~= nil, 'value', n,
							'arg1', self, 'arg2', n, 'func', 'ToggleKeepSet' );
					end
				end
			elseif ( value == 'keepitem' ) then
				-- Keep - Items
				dewdrop:AddLine('text', L["Keep Items"], "isTitle", true );
				local tbl = self:GetKeepItemTable();
				for _,i in ipairs(tbl) do
					dewdrop:AddLine('text', self.vars.colors[i.qual].hex .. i.name,
						'checked', self:IsKeepItem(i.id),
						'arg1', self, 'arg2', i.id, 'func', 'ToggleKeepItem');
				end
				--compost:Reclaim(tbl,2);
				--tbl = nil;
			else
				self:BuildKeepTypeMenu(level-1, value, inTooltip, value2);
			end
		elseif ( value2 == 'options' ) then
			if ( value == 'threshold' ) then
				dewdrop:AddLine('text', L["Drop Threshold"], "isTitle", true );
				for a=0,6 do
					dewdrop:AddLine('text', self.vars.colors[a].hex..self.vars.colors[a].desc.."|r",
						'checked', a == self:GetDropThreshold(),
						'arg1', self, 'arg2', a, 'isRadio', true,
						'func', 'SetDropThreshold' );
				end
			elseif ( value == 'moneyformat' ) then
				dewdrop:AddLine('text', L["Money Format"], "isTitle", true );
				for a,f in ipairs(self.vars.moneyformats) do
					dewdrop:AddLine('text', f.name.."\t"..f.ex,
						'checked', a == self:GetMoneyFormat(),
						'arg1', self, 'arg2', a, 'isRadio', true,
						'func', 'SetMoneyFormat' );
				end
			elseif ( value == 'bagslots' ) then
				dewdrop:AddLine('text', L["Show Total slots"], 'checked', self:IsShowingTotalSlots(),
					'arg1', self, 'func', 'ToggleShowTotalSlots');
				dewdrop:AddLine('text', L["Show Free slots"], 'checked', self:IsShowingFreeSlots(),
					'arg1', self, 'func', 'ToggleShowFreeSlots');
				dewdrop:AddLine('text', L["Show Used slots"], 'checked', not self:IsShowingFreeSlots(),
					'arg1', self, 'func', 'ToggleShowFreeSlots');
			elseif ( value == 'specialbag' ) then
				dewdrop:AddLine('text', L["Special Bags"], "isTitle", true );
				dewdrop:AddLine('text', L["Ignore Ammo Bags"], 'checked', self:IsIgnoringAmmoBag(),
					'arg1', self, 'func', 'ToggleIgnoreAmmoBag');
				dewdrop:AddLine('text', L["Ignore Herb Bags"], 'checked', self:IsIgnoringHerbBag(),
					'arg1', self, 'func', 'ToggleIgnoreHerbBag');
				dewdrop:AddLine('text', L["Ignore Soulshard Bags"], 'checked', self:IsIgnoringSoulBag(),
					'arg1', self, 'func', 'ToggleIgnoreSoulBag');
				dewdrop:AddLine('text', L["Ignore Enchanting Bags"], 'checked', self:IsIgnoringEnchBag(),
					'arg1', self, 'func', 'ToggleIgnoreEnchBag');
			else
				self:BuildVendorOptionMenu(level-1, value, inTooltip, value2);
				self:BuildAuctionOptionMenu(level-1, value, inTooltip, value2);
				self:AddImpliedMenuOptions(2);
			end
		else
			self:BuildAuctionMenu(level, value, inTooltip, value2)
		end
	elseif ( level == 4 ) then
		if ( value2 == 'dropsets' ) then
			dewdrop:AddLine('text', L["Drop Set"].." "..self.vars.sets[value].name, "isTitle", true );
			for n,i in ipairs(self.vars.sets[value].sub) do
				if not i.auctionOnly then
					dewdrop:AddLine('text', i.name,
						'checked', self:IsDropSetSelected(value,n),
						'disabled',self:IsKeepSetSelected(value,n),
						'arg1', self, 'arg2', value, 'arg3', n, 'func', 'ToggleDropSet' );
				end
			end
		elseif ( value2 == 'keepsets' ) then
			dewdrop:AddLine('text', L["Keep Set"].." "..self.vars.sets[value].name, "isTitle", true );
			for n,i in ipairs(self.vars.sets[value].sub) do
				if not i.auctionOnly then
					dewdrop:AddLine('text', i.name,
						'checked', self:IsKeepSetSelected(value,n),
						'disabled', self:IsDropSetSelected(value,n),
						'arg1', self, 'arg2', value, 'arg3', n, 'func', 'ToggleKeepSet' );
				end
			end
		else
			self:BuildDropTypeMenu(level-1, value, inTooltip, value2);
			self:BuildKeepTypeMenu(level-1, value, inTooltip, value2);
			self:BuildAuctionMenu(level, value, inTooltip, value2)
		end
	end
end

function GarbageFu:OnClick(button)
	if not self.vars.initialized then return end
	if IsShiftKeyDown() then
		self:DropFirstItem();
	end
	if IsControlKeyDown() then
		self:KeepFirstItem();
	end
end

function GarbageFu:OnDoubleClick(button)
	if not self.vars.initialized then return end
	if not ContainerFrame1:IsShown() then
		ToggleBackpack()
		for i = 1, 4 do
			if not self.vars.bags[i].ignore and self.vars.bags[i].numSlots > 0 then
				if not getglobal("ContainerFrame" .. (i + 1)):IsShown() then
					ToggleBag(i)
				end
			end
		end
	else
		for i = 0, 4 do
			if getglobal("ContainerFrame" .. (i + 1)):IsShown() then
				getglobal("ContainerFrame" .. (i + 1)):Hide()
			end
		end
	end
end

------------------------------------------------------------------------------------------------------
-- Event functions
------------------------------------------------------------------------------------------------------

function GarbageFu:OnClickItem(item)
	if IsShiftKeyDown() then
		self:DropItem(item);
	end
	if IsControlKeyDown() then
		self:KeepItem(item);
	end
end

function GarbageFu:OnMerchantOpen()
	self:HighlightSellAllButton()
end

function GarbageFu:OnMerchantClose()
	self:StopSelling()
end

function GarbageFu:OnAddOnLoaded(addon)
	self:CheckAuctionAddonLoaded(addon);
	self:CheckVendorAddonLoaded(addon);
end

function GarbageFu:OnBagUpdate(bag)
--	local bag = arg1;
	self:DebugPrint("OnBagUpdate bag="..tostring(bag));
	if ( not bag or bag < 0 or bag > 4 ) then return end
	if ( self.vars.bags[bag].bagName ~= GetBagName(bag) ) then -- Houston, we got a problem
		self:DebugPrint("New or changed bag detected. Doing a full scan");
		self:InitBagScan(); -- New or changed bag detected. Do a full scan
		return
	end
	if self.vars.bags[bag].ignore then return end
	self:SetSafeToDelete(false);
	for slot=1,self.vars.bags[bag].numSlots do
		if not self.vars.bags[bag][slot] then self.vars.bags[bag][slot] = self:GetTable() end
		local link = GetContainerItemLink(bag, slot);
		local _, stack = GetContainerItemInfo(bag, slot);
		if ( link ~= self.vars.bags[bag][slot].link or stack ~= self.vars.bags[bag][slot].stack ) then
			self.vars.bags[bag][slot].link = link;
			self.vars.bags[bag][slot].stack = stack;
			self:UpdateItem(bag,slot);
			self:SortItems();
		end
	end
	self:SetSafeToDelete(true);
end

------------------------------------------------------------------------------------------------------
-- Core functions
------------------------------------------------------------------------------------------------------

--
function GarbageFu:MainInit()
--	self:InitVendor();
--	self:InitAuction();
	self:MakeSetsTables();
	self:InitBagScan();
	self:InitSell();
end

function GarbageFu:InitBagScan()
	self:SetSafeToDelete(false);
	self.vars.items = self:GetTable(self.vars.items,2);
	for bag=0,4 do
		self.vars.bags[bag] = self:GetTable(self.vars.bags[bag],3);
		self.vars.bags[bag].numSlots = GetContainerNumSlots(bag);
		self.vars.bags[bag].bagName = GetBagName(bag);
		self.vars.bags[bag].ignore = self:IgnoreBag(bag);
		if not self.vars.bags[bag].ignore then
			for slot=1,self.vars.bags[bag].numSlots do
				self.vars.bags[bag][slot] = self:GetTable(self.vars.bags[bag][slot],2);
				self.vars.bags[bag][slot].link = GetContainerItemLink(bag, slot)
				_, self.vars.bags[bag][slot].stack = GetContainerItemInfo(bag, slot)
				self:UpdateItem(bag,slot);
			end
		end
	end
	self:SortItems();
	self:SetSafeToDelete(true);
end

function GarbageFu:UpdateItem(bag, slot)
	local itemidx = nil;
	local item = nil;
	for a,i in ipairs(self.vars.items) do
		if( i.bag == bag and i.slot == slot ) then
			itemidx = a;
			item = i;
			break;
		end
	end
	if ( self.vars.bags[bag][slot].link ) then
		if ( not item ) then
			item = self:GetTable();
		end
		if ( item.link ~= self.vars.bags[bag][slot].link ) then  -- New or changed item
			compost:Erase(item); -- Clear all old values
			item.bag = bag;
			item.slot = slot;
			item.link = self.vars.bags[bag][slot].link;
			item.stack = self.vars.bags[bag][slot].stack;
			local color;
			item.id, item.code, item.name, color = self:GetItemId(item.link);
			if ( item.id ) then
				self:GetItemType(item);
				if not item.qual then --- Item not in local cache
					item.qual = self:GetItemQualFromColor(color);
					item.tex = "Interface\\Icons\\INV_Misc_QuestionMark.blp";
					item.maxstack = 0;
					item.notseen = true;
				else
					item.notseen = nil;
				end
				self:GetItemValue(item);
			else
				item.notseen = true;
			end
		else -- Just new stack size, recalc totvalue
			item.stack = self.vars.bags[bag][slot].stack;
			if ( item.value ) then
				item.totvalue = item.value * item.stack;
			end
		end
		if ( not itemidx ) then
			table.insert(self.vars.items, item);  -- New item added
		end
	elseif ( itemidx ) then
		compost:Reclaim(table.remove(self.vars.items, itemidx),2); -- Item removed
	end
end

local function ItemSortFunc(item1, item2)
	if item1.notseen then return false end
	if item2.notseen then return true end
	if ( item1.totvalue < item2.totvalue ) then return true end
	if ( item1.totvalue == item2.totvalue ) then
		if ( item1.id < item2.id ) then return true end
	end
	return false
end

function GarbageFu:SortItems()
	table.sort(self.vars.items, ItemSortFunc);
	self:UpdateDisplay();
end

function GarbageFu:GetItemId(link)
  if link then
--		local _, _, color, code, id, name = string.find(link, "|cff(%x%x%x%x%x%x)|Hitem:((%d+):%d+:%d+:%d+)|h%[(.+)%]|h|r")
		local _, _, color, code, id, name = string.find(link, "|cff(%x%x%x%x%x%x)|Hitem:((%d+):%d+:%d+:%d+).+%[(.+)%]")
		return tonumber(id), code, name, color
  end
end

function GarbageFu:GetItemQualFromColor(color)
	for i,c in ipairs(self.vars.colors) do
		if ( color == string.sub(c.hex,5) ) then return i end
	end
end


-- Check if an item is elegiable for drop
function GarbageFu:IsItemDroppable(item)
	if item.notseen then self:UpdateItem(item.bag,item.slot) end -- Not seen item. Try again.
	if item.notseen then return false end -- Still not seen.
	if (item.totvalue == 0 and item.qual > 0) then return false end -- All items above poor quality without price is not dropped for saftey reasons
	if self:IsItemKeepItem(item.id) then return false end
	if self:IsItemDropItem(item.id) then return true end
	if self:IsItemKeepType(item) then return false end
	if self:IsItemInKeepSets(item.id) then return false end
	if self:IsItemDropType(item) then return true end
	if self:IsItemInDropSets(item.id) then return true end
	if (item.qual <= self:GetDropThreshold()) then return true end
	return false
end

function GarbageFu:GetFirstDroppableItem()
	for i,item in ipairs(self.vars.items) do
		if self:IsItemDroppable(item) then
			return item
		end
	end
end

function GarbageFu:GetBagSlots()
	local total = 0;
	local used = 0;
	for bag=0,4 do
		if self.vars.bags and self.vars.bags[bag] and not self.vars.bags[bag].ignore then
			total = total + self.vars.bags[bag].numSlots;
			for slot=1,self.vars.bags[bag].numSlots do
				if self.vars.bags[bag][slot] and self.vars.bags[bag][slot].link then used = used + 1 end
			end
		end
	end
	local color = crayon:GetThresholdHexColor((total - used) / total);
	if self:IsShowingTotalSlots() then
		if self:IsShowingFreeSlots() then
			used = total - used;
		end
		return format("|cff%s%d/%d|r ", color, used, total);
	else
		if self:IsShowingFreeSlots() then
			used = total - used;
		end
		return format("|cff%s%d|r ", color, used);
	end
end

-- Upgrades user settings
function GarbageFu:CheckSettings()
	-- Make a list of all valid sets id's
	local hash = self:GetTable();
	for _,set in ipairs(self.vars.sets) do
		if set.auctionOnly then
			hash[set.id]=2;
		else
			hash[set.id]=1;
		end
		if set.sub then
			for _,subset in ipairs(set.sub) do
				if subset.auctionOnly then
					hash[subset.id]=2;
				else
					hash[subset.id]=1;
				end
			end
		end
	end
	-- Check dropsets
	for setid,_ in pairs(self.db.profile.dropsets) do
		if not hash[setid] or hash[setid]~=1 then
			self.db.profile.dropsets[setid]=nil;		-- Deleteing invalid setid
		end
	end
	-- Check keepsets
	for setid,_ in pairs(self.db.profile.keepsets) do
		if not hash[setid] or hash[setid]~=1 then
			self.db.profile.keepsets[setid]=nil;		-- Deleteing invalid setid
		end
	end
	-- check auctionsets
	for setid,_ in pairs(self.db.profile.auctionsets) do
		if not hash[setid] then
			self.db.profile.auctionsets[setid]=nil;		-- Deleteing invalid setid
		end
	end
	compost:Reclaim(hash);
	hash = nil;
	-- check vendor addons
	for _,addon in pairs(self.db.profile.vendoraddonsorder) do
		if not self.vars.vendoraddons[addon] then
			self.db.profile.vendoraddonsorder[addon] = nil;
		end
	end
	-- check auction addons
	for _,addon in pairs(self.db.profile.auctionaddonsorder) do
		if not self.vars.auctionaddons[addon] then
			self.db.profile.auctionaddonsorder[addon] = nil;
		end
	end
end

------------------------------------------------------------------------------------------------------
-- Drop down menu functions
------------------------------------------------------------------------------------------------------

function GarbageFu:GetDropItemTable()
	self.vars.temptbl = self:GetTable(self.vars.temptbl, 2);
--	local tbl = {};
	local tbl2 = self:GetTable();
	-- Start with itemid's listed as drop
	for i,_ in pairs(self.db.profile.dropitem) do
		local item = self:GetTable();
		item.id = i;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory with a qual over drop threshold or in keep sets/type and not in drop set/type
	for _,i in ipairs(self.vars.items) do
		if ( not i.notseen and not tbl2[i.id] and i.totvalue > 0 and
				 (i.qual>self:GetDropThreshold() or self:IsItemInKeepSets(i.id) or self:IsItemKeepType(i)) and
				 not self:IsItemInDropSets(i.id) and not self:IsItemDropType(i)) then
			local item = self:GetTable();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

function GarbageFu:GetKeepItemTable()
	self.vars.temptbl = self:GetTable(self.vars.temptbl, 2);
	local tbl2 = self:GetTable();
	-- Start with itemid's listed as keep
	for i,_ in pairs(self.db.profile.keepitem) do
		local item = self:GetTable();
		item.id = i;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory with a qual eq or below drop threshold or in drop sets/type. Not poor quality items
	for _,i in ipairs(self.vars.items) do
--		if ( not i.notseen and i.totvalue > 0 and i.qual > 0 and not tbl2[i.id] and
		if ( not i.notseen and not tbl2[i.id] and
				 (i.qual<=self:GetDropThreshold() or self:IsItemInDropSets(i.id) or self:IsItemDropType(i)) and
				 not self:IsItemInKeepSets(i.id) and not self:IsItemKeepType(i)) then
			local item = self:GetTable();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

function GarbageFu:KeepFirstItem()
	local item = self:GetFirstDroppableItem();
	if item then
		self:KeepItem(item);
	end
end

function GarbageFu:KeepItem(item)
	if item then
		self:ToggleKeepItem(item.id);
		self:MyPrint(L["Adding %s to keep item list"], item.link );
	end
end

function GarbageFu:DropFirstItem()
	local item = self:GetFirstDroppableItem();
	if item then
		self:DropItem(item);
	end
end

function GarbageFu:DropItem(item)
	if not item or not item.bag or not item.slot then return end
	if not self:IsSafeToDelete() then return end
	if self:IsItemDroppable(item) then
		if (MerchantFrame:IsVisible()) then
			self:MyPrint(L["Selling x%s %s worth %s"], item.stack, item.name, self:GetMoneyString(item.totvalue) );
			UseContainerItem(item.bag, item.slot)
			self:SetSafeToDelete(false);
		else
			self:MyPrint(L["Dropping x%s %s worth %s"], item.stack, item.name, self:GetMoneyString(item.totvalue) );
			PickupContainerItem(item.bag, item.slot)
			DeleteCursorItem();
			self:SetSafeToDelete(false);
		end
	end
end

function GarbageFu:SettingsReset()
	self:ResetDB('profile');
	self:ResetDB('account');
	self.vars.dropsets = self:GetTable(self.vars.dropsets,1);
	self.vars.keepsets = self:GetTable(self.vars.keepsets,1);
	self.vars.auctionsets = self:GetTable(self.vars.auctionsets,1);
	self:UpdateDisplay();
end

function GarbageFu:GetMoneyString(value)
	if ( value == 0 or value == nil) then
		return "|cffffcc00??|r"; -- No price
	elseif ( self.db.profile.moneyformat == 1 ) then
		return abacus:FormatMoneyCondensed(value,true,true)
	elseif ( self.db.profile.moneyformat == 2 ) then
		return abacus:FormatMoneyShort(value,true,true)
	elseif ( self.db.profile.moneyformat == 3 ) then
		return abacus:FormatMoneyFull(value,true,true)
	else
		return abacus:FormatMoneyExtended(value,true,true)
	end
end

------------------------------------------------------------------------------------------------------
-- Sets functions
------------------------------------------------------------------------------------------------------

-- Converts self.db.profile.dropsets into self.vars.dropsets
-- Needed because self.db.profile.dropsets is index by name and self.vars.dropsets needs to be indexed by number with names as string.
function GarbageFu:MakeSetsTables()
	self.vars.dropsets = self:GetTable(self.vars.dropsets,1);
	for n,_ in pairs(self.db.profile.dropsets) do
		table.insert(self.vars.dropsets,n);
	end
	self.vars.keepsets = self:GetTable(self.vars.keepsets,1);
	for n,_ in pairs(self.db.profile.keepsets) do
		table.insert(self.vars.keepsets,n);
	end
end

function GarbageFu:IsItemInSet(itemId,set)
	local val,set = PeriodicTable:ItemInSet(itemId,set);
	if set then return true end
end

function GarbageFu:IsSetSelected(set, subset, setstbl)
	local setid = self.vars.sets[set].id;
	if subset then
		local subsetid = self.vars.sets[set].sub[subset].id;
		return setstbl[setid] or setstbl[subsetid];
	end
	return setstbl[setid];
end

	function GarbageFu:IsChildSetSelected(set,setstbl)
		if self.vars.sets[set].sub then
			for _,s in ipairs(self.vars.sets[set].sub) do
				if setstbl[s.id] then
					return true;
				end
			end
		end
	end

function GarbageFu:ToggleSets(set,subset,vartbl,setstbl1,setstbl2)
	self:DebugPrint("ToggleSets(set) set="..tostring(set).." subset="..tostring(subset));
	local setid = vartbl[set].id;
	if subset then																	-- Clicked a child
		local subsetid = vartbl[set].sub[subset].id;
		if setstbl1[setid] then  												-- Check if parent is set
			setstbl1[setid] = nil; 													-- Clear parent
			for _,s in ipairs(vartbl[set].sub) do
				setstbl1[s.id] = true; 												-- Set all children
			end
		end
		if setstbl1[subsetid] then											-- Reverse child
			setstbl1[subsetid] = nil;
		else
			setstbl1[subsetid] = true;
		end
		local allset = true;
		for _,s in ipairs(vartbl[set].sub) do
			if not setstbl1[s.id] then 										-- Check if all children are set
				allset = false;
				break;
			end
		end
		if allset then																		-- All children are set
			setstbl1[setid] = true; 												-- set parent
			for i,s in ipairs(vartbl[set].sub) do
				setstbl1[s.id] = nil;	  											-- And clear all children
			end
		end
	else																						-- Clicked a parent or a single
		if setstbl1[setid] then													-- Reverse it
			setstbl1[setid] = nil;
		else
			setstbl1[setid] = true;
			if vartbl[set].sub then								-- If it is a parent
				for _,s in ipairs(vartbl[set].sub) do					-- Clear all children for both setstbl1 and setstbl2
					setstbl1[s.id] = nil;
					if setstbl2 then setstbl2[s.id] = nil end
				end
			end
		end
	end
end

-- Check if item is in one of the sets selected for drop.
function GarbageFu:IsItemInDropSets(itemid)
	return self:IsItemInSet(itemid,self.vars.dropsets);
end

-- Check if item is in one of the sets selected for keep.
function GarbageFu:IsItemInKeepSets(itemid)
	return self:IsItemInSet(itemid,self.vars.keepsets);
end

function GarbageFu:IsItemDropItem(itemid)
	return self.db.profile.dropitem[itemid] ~= nil;
end

function GarbageFu:IsItemKeepItem(itemid)
	return self.db.profile.keepitem[itemid] ~= nil;
end

function GarbageFu:IsDropSetSelected(set,subset)
	return self:IsSetSelected(set, subset, self.db.profile.dropsets);
end

function GarbageFu:IsKeepSetSelected(set,subset)
	return self:IsSetSelected(set, subset, self.db.profile.keepsets);
end

function GarbageFu:IsChildDropSetSelected(set)
	return self:IsChildSetSelected(set, self.db.profile.dropsets);
end

function GarbageFu:IsChildKeepSetSelected(set)
	return self:IsChildSetSelected(set, self.db.profile.keepsets);
end

function GarbageFu:ToggleDropSet(set,subset)
	self:ToggleSets(set, subset, self.vars.sets, self.db.profile.dropsets, self.db.profile.keepsets);
	self:MakeSetsTables();
	self:UpdateDisplay();
end

function GarbageFu:ToggleKeepSet(set,subset)
	self:ToggleSets(set, subset, self.vars.sets, self.db.profile.keepsets, self.db.profile.dropsets);
	self:MakeSetsTables();
	self:UpdateDisplay();
end

------------------------------------------------------------------------------------------------------
-- Special bag functions
------------------------------------------------------------------------------------------------------

function GarbageFu:GetBagId(bag)
	local slotId = ContainerIDToInventoryID(bag);
	local bagLink = GetInventoryItemLink("player",slotId);
	local bagId = self:GetItemId(bagLink);
	return bagId;
end

function GarbageFu:IgnoreBag(bag)
	if ( bag < 1 or bag > 4 ) then return end
	local bagId = self:GetBagId(bag);
	if not bagId then return end
	local _, _, _, _, _, bagtype, bagsubtype = GetItemInfo(bagId);

	if ( self:IsIgnoringAmmoBag() and bagtype == "Quiver" ) then return true end
	if ( self:IsIgnoringHerbBag() and bagsubtype == "Herb Bag" ) then return true end
	if ( self:IsIgnoringSoulBag() and bagsubtype == "Soul Bag" ) then return true end
	if ( self:IsIgnoringEnchBag() and bagsubtype == "Enchanting Bag" ) then return true end
end

------------------------------------------------------------------------------------------------------
-- Item Price functions
------------------------------------------------------------------------------------------------------

-- Update all items in the inventory with new prices.
function GarbageFu:UpdateAllItemValues()
	for _, item in ipairs(self.vars.items) do
		self:GetItemValue(item);
	end
	self:SortItems();
end

-- Updates all occurances of itemid in the inventory with a new price.
function GarbageFu:UpdateItemValue(itemid)
	for _, item in ipairs(self.vars.items) do
		if ( item.id == itemid ) then
			self:GetItemValue(item);
		end
	end
	self:SortItems();
end

-- Get item value. Doh!
function GarbageFu:GetItemValue(item)
	if not self:GetAuctionValue(item) then
		self:GetVendorValue(item);
	end
end


------------------------------------------------------------------------------------------------------
-- Custom price override functions
------------------------------------------------------------------------------------------------------

-- Check that we got a numeric value from the editbox.
function GarbageFu.ValidateValue(self, value)
	self:DebugPrint( "ValidateValue value="..tostring(value));
	local res = ""
	for s in string.gfind(value, "(%d*).-(%d*)") do
	    res=res..s
	end
	return res
end

-- Stores a new User Override price for the top item.
function GarbageFu.SetFirstItemValue(self, value)
	local item = self:GetFirstDroppableItem();
	if item then
		GarbageFu.SetItemValue(self, item.id, value);
	end
end

-- Stores a new User Override price for an item, or removing it.
function GarbageFu.SetItemValue(self, itemid, value)
	value = tonumber(value);
	if itemid then
		self:DebugPrint( "SetItemValue value="..tostring(value).."itemid="..tostring(itemid));
		if ( not value or value == 0 ) then
			if self.db.account.overrideprices[itemid] then
				self.db.account.overrideprices[itemid] = nil;
				local name = GetItemInfo(itemid);
				self:MyPrint(L["Removing custom price for %s."], name);
			end
		else
			self.db.account.overrideprices[itemid] = value;
				local name = GetItemInfo(itemid);
			self:MyPrint(L["Setting price for %s to %s."], name, self:GetMoneyString(value));
		end
		self:UpdateItemValue(itemid)
	end
end

function GarbageFu:GetCustomItemValueTable()
	self.vars.temptbl = self:GetTable(self.vars.temptbl, 2);
	local tbl2 = self:GetTable();
	-- Start with itemid's with a custom price
	for i,v in pairs(self.db.account.overrideprices) do
		local item = self:GetTable();
		item.id = i;
		item.value = v;
		item.name,_,item.qual = GetItemInfo(i);
		if item.name then
			table.insert(self.vars.temptbl,item);
			tbl2[i] = true;
		else
			compost:Reclaim(item,1);
			item = nil;
		end
	end
	-- Add items in inventory. Not poor quality items that already have a price
	for _,i in ipairs(self.vars.items) do
		if ( not i.notseen and not tbl2[i.id] and (i.qual > 0 or i.totvalue == 0) and
			not self:IsItemInKeepSets(i.id) and not self:IsItemKeepType(i) and
			not self:IsItemKeepItem(i.id)) then
			local item = self:GetTable();
			item.id = i.id;
			item.name = i.name;
			item.qual = i.qual;
			item.value = i.value;
			if not item.value then item.value = 0 end
			table.insert(self.vars.temptbl,item);
			tbl2[i.id] = true;
		end
	end
	compost:Reclaim(tbl2,2);
	tbl2 = nil;
	table.sort(self.vars.temptbl,function(a,b) return a.name<b.name end);
	return self.vars.temptbl
end

------------------------------------------------------------------------------------------------------
-- Compost interface
------------------------------------------------------------------------------------------------------

-- Method that will get a table from compost. If a table is passed in it will be erased and return.
-- If a depth is specified then any subtables will be reclaimed by compost before erasing the table and returning it.
function GarbageFu:GetTable(t,depth)
	if t then
		if type(t) ~= "table" then
			error("GarbageFu:GetTable called with a none table as input");
			return
		end
		if depth and depth > 0 then
			for i in pairs(t) do
				if type(t[i]) == "table" then
					compost:Reclaim(t[i], depth - 1 );
				end
			end
		end
		return compost:Erase(t);
	else
		return compost:GetTable();
	end
end

------------------------------------------------------------------------------------------------------
-- Chat output functions
------------------------------------------------------------------------------------------------------

function GarbageFu:DebugPrint(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	if self.CustomDebug then
		self:CustomDebug(1, 0.5, 0, nil, nil, nil, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
	end
end

function GarbageFu:MyPrint(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10)
	self:CustomPrint(self.db.profile.textcolor.r, self.db.profile.textcolor.g, self.db.profile.textcolor.b, nil, nil, nil, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10);
end
