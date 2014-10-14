TransporterFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0", "AceDebug-2.0", "FuBarPlugin-2.0")

local loc = AceLibrary("AceLocale-2.2"):new("TransporterFu")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local compost = AceLibrary("Compost-2.0")
local PT = PeriodicTableEmbed:GetInstance("1")
local crayon = AceLibrary("Crayon-2.0")
local abacus = AceLibrary("Abacus-2.0")

TransporterFu.version = "2.0." .. string.sub("$Revision: 18122 $", 12, -3)
TransporterFu.date = string.sub("$Date$", 8, 17)
TransporterFu.hasIcon = true
TransporterFu.canHideText = true
TransporterFu.hasNoColor = true

TransporterFu:RegisterDB("TransporterFuDB", "TransporterFuCharDB")
TransporterFu:RegisterDefaults('profile', {
	showTag = true,
	showCooldown = true,
})
TransporterFu:RegisterDefaults('char', {
	SET = "item6948",
})

function TransporterFu:OnInitialize()
	_, self.Class = UnitClass("player")
	if PT then
		self:Debug(loc.PT_FOUND)
		self.ItemsToCheck = {"mounts", "mountsaq", "transporteritems", "transporterequips"}
	else
		self:Print(loc.PT_NOT_FOUND)
	end
end

function TransporterFu:OnEnable()
	self.METHODS = compost:Acquire()
	self.SET1 = compost:Acquire()
	self.ItemDesc = compost:Acquire()
	self.NeedsUpdate = compost:Acquire()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateInfo")
	self:RegisterEvent("PLAYER_LEAVING_WORLD", "UpdateInfo")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateInfo")
	self:RegisterEvent("BAG_UPDATE", "UpdateItems")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED", "UpdateEquipped")
	self:UpdateSpells()
	self:UpdateBind()
	self:RegisterEvent("CHAT_MSG_SYSTEM")
	self:RegisterEvent("SPELLS_CHANGED")
	self:UpdateInfo()
	self:ScheduleRepeatingEvent(self.RunTasks, 1, self)
end

function TransporterFu:OnDisable()
	compost:ReclaimMulti(self.METHODS, self.SET1, self.NeedsUpdate, self.ItemDesc)
	self.METHODS, self.SET1, self.NeedsUpdate, self.ItemDesc = nil, nil, nil, nil
end

function TransporterFu:UpdateInfo()
	self:Debug("Player Changing Zones")
	if PT then
		self:UpdateItems()
		self:UpdateEquipped()
	end
	self:UpdateCooldowns()
	self.NeedsUpdate.SetDisplay = self.SetDisplay
end

function TransporterFu:CHAT_MSG_SYSTEM()
	self:Debug("Scheduling bind update")
	self.NeedsUpdate.UpdateBind = self.UpdateBind
end

function TransporterFu:SPELLS_CHANGED()
	self:Debug("Scheduling spell update")
	self.NeedsUpdate.UpdateSpells = self.UpdateSpells
end

function TransporterFu:OnMenuRequest(level,value)
	if level == 1 then
		for k,v in self:pairsByKeys(self.METHODS) do
			local my_k = k
			local my_text
			if string.find(my_k, "item", 1, true) then
				my_text = self.ItemDesc[my_k]
			else
				my_text = loc[my_k]
			end
			dewdrop:AddLine(
				'text', my_text,
				'arg1', self,
				'func', function() self:DoMethod(my_k) end,
				'closeWhenClicked', true
			)
		end
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', loc.MENU_SET,
			'arg1', self,
			'hasArrow', true,
			'value', "SET1"
		)
		dewdrop:AddLine(
			'text', loc.SHOW_TAG,
			'arg1', self,
			'func', function() self:ToggleOption("showTag", true) end,
			'checked', self.db.profile.showTag
		)
		dewdrop:AddLine(
			'text', loc.SHOW_COOLDOWN,
			'arg1', self,
			'func', function() self:ToggleOption("showCooldown", true) end,
			'checked', self.db.profile.showCooldown
		)
		dewdrop:AddLine()
		dewdrop:AddLine(
			'text', loc.MANUAL,
			'arg1', self,
			'func', function()
				self.METHODS = compost:Erase(self.METHODS)
				if PT then
					self:UpdateItems()
					self:UpdateEquipped()
				end
				self:UpdateSpells()
				self:UpdateBind()
				self:SetDisplay()
				self:UpdateCooldowns()
				self:Update()
			end,
			'closeWhenClicked', true
		)
	elseif level == 2 then
		if value == "SET1" then
			for k,v in self:pairsByKeys(self.METHODS) do
				local my_k = k
				local my_text
				if string.find(my_k, "item", 1, true) then
					my_text = self.ItemDesc[my_k]
				else
					my_text = loc[my_k]
				end
				dewdrop:AddLine(
					'text', my_text,
					'arg1', self,
					'func', function() self:SetDisplay(my_k) end,
					'checked', self.SET1[my_k],
					'closeWhenClicked', true
				)
			end
		end
	end
end

function TransporterFu:UpdateText()
	self:Debug("Updating Text")
	local method = self.db.char.SET
	if method and self.METHODS[method] then
		local t = compost:Acquire()
		
		if self.db.profile.showTag then
			if method == "item6948" or method == "ASTRAL" then
				table.insert(t,self.BLOC)
			else
				local my_text
				if string.find(method, "item", 1, true) then
					my_text = self.ItemDesc[method]
				else
					my_text = loc[method]
				end
				table.insert(t,my_text)
			end
		end
		
		if self.db.profile.showCooldown then
			if not self.METHODS[method].cooldown then
				local cd = self:GetCooldown(method)
				table.insert(t,cd)
			end
		end
		
		self:SetText(table.concat(t, " "))
		compost:Reclaim(t)
	else
		self:SetText(loc.NA)
	end
end

function TransporterFu:OnTooltipUpdate()
	self:Debug("Updating Tooltip")
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	if self.db.char.SET then
		local my_text
		if string.find(self.db.char.SET, "item", 1, true) then
			my_text = self.ItemDesc[self.db.char.SET]
		elseif loc[self.db.char.SET] then
			my_text = loc[self.db.char.SET]
		end
		cat:AddLine('text', loc.METHOD1, 'text2', my_text)
	end
	local bloc = self.BLOC
	if bloc then
		cat:AddLine('text', loc.INN, 'text2', bloc)
	end
	local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 0,
		'child_text2G', 1,
		'child_text2B', 0
	)
	for k,v in self:pairsByKeys(self.METHODS) do
		local my_text
		if string.find(k, "item", 1, true) then
			my_text = self.ItemDesc[k]
		else
			my_text = loc[k]
		end
		if v.cooldown then
			cat:AddLine('text', my_text, 'text2', loc.READY)
		else
			cat:AddLine('text', my_text, 'text2', self:GetCooldown(k))
		end
	end
	tablet:SetHint(loc.HINT)
end

function TransporterFu:RunTasks()
	for k,v in pairs(self.NeedsUpdate) do
		self:Debug(string.format("Executing scheduled function: %s", k))
		v(self)
		self.NeedsUpdate[k] = nil
	end
	if self.db.char.SET and self.METHODS[self.db.char.SET] then
		if not self.METHODS[self.db.char.SET].cooldown and self.db.profile.showCooldown then
			self:UpdateDisplay()
		end
	end
end

function TransporterFu:OnClick()
	if self.db.char.SET and self.METHODS[self.db.char.SET] then
		self:DoMethod(self.db.char.SET)
	end
end

function TransporterFu:FindSpell(spellname)
	for i = 1,180 do
		local s = GetSpellName(i, BOOKTYPE_SPELL)
		if s == spellname then
			return i
		end
	end
end

function TransporterFu:GetLinkInfo(link, PTSets)
	if type(link) == "string" then
		local _, _, itemid, desc = string.find(link, "item:(%d+):%d+:%d+:%d+|h%[(.+)%]")
		if itemid and desc then
			if PTSets then
				local _, itemset = PT:ItemInSet(tonumber(itemid), PTSets)
				return itemid, desc, itemset
			else
				return itemid, desc
			end
		end
	end
end

function TransporterFu:ParseItem(b, s, link)
	if PT and link and b and s then
		local itemid, desc, itemset = self:GetLinkInfo(link, self.ItemsToCheck)
		if itemid and desc and itemset then
			local ITEM = "item"..itemid
			if (itemset == "mounts") or (itemset == "mountsaq") then
				self.METHODS[ITEM] = {bag = b, slot = s, mount = true}
			else
				self.METHODS[ITEM] = {bag = b, slot = s}
			end
			self.ItemDesc[ITEM] = desc
			_, self.METHODS[ITEM].cooldown = self:GetCooldown(ITEM)
		end
	end
end

function TransporterFu:UpdateItems()
	self:Debug("Updating Items")
	if PT then
		for b = 0, NUM_BAG_FRAMES do
			local SLOTS = GetContainerNumSlots(b)
			if SLOTS > 0 then
				for s = 1, SLOTS do
					self:ParseItem(b, s, GetContainerItemLink(b, s))
				end
			end
		end
	else
		self:Debug("No PT!")
	end
end

function TransporterFu:ParseEquipped(s, link)
	if PT and s and link then
		local itemid, desc, itemset = self:GetLinkInfo(link, "transporterequips")
		if itemid and desc and itemset then
			local ITEM = "item"..itemid
			self.METHODS[ITEM] = {slot = s}
			self.ItemDesc[ITEM] = desc
			_, self.METHODS[ITEM].cooldown = self:GetCooldown(ITEM)	
		end
	end
end

function TransporterFu:UpdateEquipped()
	self:Debug("Updating Equipped")
	if PT then
		for s = 0, 19 do
			self:ParseEquipped(s, GetInventoryItemLink("player", s))
		end
	else
		self:Debug("No PT!")
	end
end

function TransporterFu:UpdateSpells()
	self:Debug("Updating Spells")
	local Class = self.Class
	local methods
		
	if (Class == "SHAMAN") then
		methods = {"ASTRAL"}
	elseif (Class == "DRUID") then
		methods = {"PORT_MG"}
	elseif (Class == "MAGE") then
		local City
		methods = compost:Acquire()
		if UnitFactionGroup("player") == "Alliance" then
			City = {"DN","IF","SW"}
		else
			City = {"OG","TB","UC"}
		end
		for i,j in ipairs({"TELEPORT_","PORTAL_"}) do
			for k,v in ipairs(City) do
				table.insert(methods,j..v)
			end
		end
	elseif (Class == "PALADIN") then
		methods = {"WARHORSE","CHARGER"}
	elseif (Class == "WARLOCK") then
		methods = {"FELSTEED","DREADSTEED"}
	end
	
	if methods then
		for i,method in ipairs(methods) do
			local sid = self:FindSpell(loc[method])
			if sid then
				self.METHODS[method] = {id = sid}
				_, self.METHODS[method].cooldown = self:GetCooldown(method)
			end
		end
	end
	compost:Reclaim(methods)
end

function TransporterFu:SetDisplay(method)
	self:Debug("Setting Display")
	self.SET1 = compost:Erase(self.SET1)
	if method then
		self.db.char.SET = method
	else
		method = self.db.char.SET
		if not method then
			self:SetIcon(true)
			self:UpdateDisplay()
			return
		end
	end
	self.SET1[method] = true
	if self.METHODS[method] then
		if string.find(method, "item", 1, true) then
			local _, _, _, _, _, _, _, _, T = GetItemInfo(tonumber(string.sub(method, 5)))
			if T then
				self:SetIcon(T)
			else
				self:SetIcon(true)
			end
		else
			self:SetIcon(GetSpellTexture(self.METHODS[method].id, BOOKTYPE_SPELL))
		end
	else
		self:SetIcon(true)
	end
	self:UpdateDisplay()
end

function TransporterFu:DoMethod(method)
	if string.find(method, "item", 1, true) then
		local I = self.METHODS[method]
		if I and (I.slot and not I.bag) then
			UseInventoryItem(I.slot)
		elseif (I.bag and I.slot) then
			UseContainerItem(I.bag, I.slot)
		end
	else
		CastSpellByName(loc[method])
	end
end

function TransporterFu:GetCooldown(method)
	local t, d, cat

	if string.find(method, "item", 1, true) then
		local I = self.METHODS[method]
		if (I.bag and I.slot) then
			cat = "UpdateItems"
			t, d = GetContainerItemCooldown(I.bag, I.slot)
		elseif (I.slot and not I.bag) then
			cat = "UpdateEquipped"
			t, d = GetInventoryItemCooldown("player", I.slot)
		end
	else
		cat = "UpdateSpells"
		local sid = self.METHODS[method].id
		if sid then
			t, d = GetSpellCooldown(sid, BOOKTYPE_SPELL)
		end
	end

	if t and d then
		local cd = d - (GetTime() - t - 60)
		if cd < 1 then
			return crayon:Green(loc.READY), true
		elseif (cd < 60) then
			return abacus:FormatDurationFull(cd, TRUE, FALSE), false
		else
			return abacus:FormatDurationFull(cd, TRUE, TRUE), false
		end
	else
		self.NeedsUpdate[cat] = self[cat]
		return crayon:Red(loc.NA), FALSE
	end
end

function TransporterFu:UpdateBind()
	self:Debug("Updating bind location")
	local bloc = GetBindLocation()
	if bloc then
		self.BLOC = bloc
	else
		self.NeedsUpdate.UpdateBind = self.UpdateBind
	end
end

function TransporterFu:UpdateCooldowns()
	self:Debug("Updating cooldowns")
	for k,v in pairs(self.METHODS) do
		_, v.cooldown = self:GetCooldown(k)
	end
end

function TransporterFu:ToggleOption(var, doUpdate)
	self.db.profile[var] = not self.db.profile[var]
	if doUpdate then
		self:Update()
	end
	return self.db.profile[var]
end

function TransporterFu:pairsByKeys (t, f)
--taken from an example in the Programming in Lua book
	local a = compost:Acquire()
	for n in pairs(t) do
		table.insert(a, n)
	end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then
			compost:Reclaim(a)
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end