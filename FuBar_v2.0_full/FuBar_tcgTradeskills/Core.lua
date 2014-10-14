-- vim: noet

local function CheckLibrary(name)
	if (not AceLibrary) then
		error("tcgTradeskills requires AceLibrary be available. Please check that the archive was extracted correctly.")
		return
	elseif (not AceLibrary:HasInstance(name)) then
		error(string.format("tcgTradeskills (Core) requires the %s embeded library be available. Please check that the archive was extracted correctly.", name))
		return
	end
end

CheckLibrary("AceAddon-2.0")
CheckLibrary("AceLocale-2.2")
CheckLibrary("AceDB-2.0")
CheckLibrary("AceDebug-2.0")
CheckLibrary("AceEvent-2.0")
CheckLibrary("AceModuleCore-2.0")
CheckLibrary("Babble-Class-2.2")
CheckLibrary("Babble-Spell-2.2")
CheckLibrary("Compost-2.0")
CheckLibrary("Crayon-2.0")
CheckLibrary("Dewdrop-2.0")
CheckLibrary("FuBarPlugin-2.0")
CheckLibrary("Tablet-2.0")

local compost = AceLibrary("Compost-2.0")
local blspell = AceLibrary("Babble-Spell-2.2")
local blclass = AceLibrary("Babble-Class-2.2")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local crayon = AceLibrary("Crayon-2.0")

local tradeskills = {
	["Alchemy"] = blspell:GetSpellIcon("Alchemy"),
	["Blacksmithing"] = blspell:GetSpellIcon("Blacksmithing"),
	["Cooking"] = blspell:GetSpellIcon("Cooking"),
	["Disenchant"] = blspell:GetSpellIcon("Disenchant"),
	["Enchanting"] = blspell:GetSpellIcon("Enchanting"),
	["Engineering"] = blspell:GetSpellIcon("Engineering"),
	["First Aid"] = blspell:GetSpellIcon("First Aid"),
	["Fishing"] = blspell:GetSpellIcon("Fishing"),
	["Herbalism"] = 0,
	["Leatherworking"] = blspell:GetSpellIcon("Leatherworking"),
	["Lockpicking"] = 0,
	["Mining"] = 0,
	["Pick Lock"] = blspell:GetSpellIcon("Pick Lock"),
	["Poisons"] = blspell:GetSpellIcon("Poisons"),
	["Skinning"] = 0,
	["Smelting"] = blspell:GetSpellIcon("Smelting"),
	["Tailoring"] = blspell:GetSpellIcon("Tailoring")
}

local linked_skills = {
	[ blspell["Smelting"] ] = blspell["Mining"],
	[ blspell["Disenchant"] ] = blspell["Enchanting"],
	[ blspell["Pick Lock"] ] = blspell["Lockpicking"],
}

local silly_map = {
	["Secourisme"] = "First Aid",
	["Ing\195\169nierie"] = "Engineering",
}

local L = AceLibrary("AceLocale-2.2"):new("FuBar_tcgTradeskills")

tcgTradeskills = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceModuleCore-2.0", "AceDebug-2.0")
tcgTradeskills:SetModuleMixins("AceEvent-2.0")
tcgTradeskills:RegisterDB("tcgTradeskillsDB")
tcgTradeskills:RegisterDefaults("profile", { icon_size = 3; button_spacing = 1;})
tcgTradeskills.frame = tcgTradeskills:CreateBasicPluginFrame("tcgTradeskillsFrame")
tcgTradeskills.clickableTooltip = true
tcgTradeskills.cannotAttachToMinimap = true
tcgTradeskills.options = {
	handler = tcgTradeskills;
	type = 'group';
	args = {
		filters = {
			type = "group";
			name = L["Filter"];
			desc = L["Filter Characters on Tooltip"];
		};
		purge = {
			type = "group";
			name = L["Purge"];
			desc = L["Purge Characters"];
		};
		settings = {
			type = "group";
			name = L["Profile Settings"];
			desc = L["Profile specific settings"];
			args = {
				icon_size = {
					type = "range";
					name = L["Icon Size"];
					desc = L["Set Icon Size"];
					min  = 7.5;
					max  = 25;
					step = 0.5;
					set  = function(size) tcgTradeskills:SetIconSize(size) end;
					get  = function() return tcgTradeskills:GetIconSize() end;
				};
				button_spacing = {
					type = "range";
					name = L["Button Spacing"];
					desc = L["Set Button Spacing"];
					min  = 0;
					max  = 10;
					step = 0.5;
					set  = function(size) tcgTradeskills:SetButtonSpacing(size) end;
					get  = function() return tcgTradeskills:GetButtonSpacing() end;
				};
				single_realm = {
					type = "toggle",
					name = L["Single Realm View"],
					desc = L["Show only the current realm in tooltip"],
					set  = function(v) tcgTradeskills:ToggleRealmView() end,
					get  = function() return tcgTradeskills:IsRealmView() end,
				};
			};
		};
		button_visibility = {
			type = "group";
			name = L["Button Visibility"];
			desc = L["Toggle Button Visibility (per character)"];
		};
	};
}

function tcgTradeskills:OnInitialize()
	self:Debug("tcgTradeskills:OnInitialize()")

	self.hasNoText            = true
	self.hideWithoutStandby   = true
	self.hasIcon              = false
	self.defaultPosition      = 'RIGHT'
	self.name                 = "tcgTradeskills"

	self.libs = {
		dewdrop = dewdrop,
		compost = compost,
		blspell = blspell,
		blclass = blclass,
		tablet  = tablet
	}

	if (WOWB_VER) then self:SetDebugging(true) end
end

function tcgTradeskills:OnEnable()
	self:Debug("tcgTradeskills:OnEnable()")
	self:RegisterEvent("AceEvent_FullyInitialized")

	self.fontSize = FuBar:GetFontSize()
end

function tcgTradeskills:AceEvent_FullyInitialized()
	self.buttons_changed = true
	self.data_refreshed = true

	self:Save()
end

function tcgTradeskills:OnDisable()
	self:Debug("tcgTradeskills:OnDisable()")
	self:UnregisterEvent("SKILL_LINES_CHANGED")
end

function tcgTradeskills:OnMenuRequest()
	if (not self.data) then return end
	if (self.cached_options) then
		self:Debug("OnMenuRequest(): Using Cached Options Table")
		dewdrop:FeedAceOptionsTable(self.cached_options)
		return
	end

	-- Button Visibility Settings
	local tbl = self.options.args.button_visibility.args
	if (tbl) then compost:Reclaim(tbl, 5) end
	tbl = compost:Acquire()
	self.options.args.button_visibility.args = tbl

	for name, icon in pairs(tradeskills) do
		local skill_name = self:GetTranslation(name) or name
		local key_name, _ = string.gsub(skill_name, " ", "_")
		if (tcgTradeskills:SkillExists(skill_name) and icon ~= 0) then
			local subtbl = compost:Acquire()
			tbl[key_name] = subtbl
			subtbl.type = "toggle"
			subtbl.name = skill_name
			subtbl.desc = L["Toggle visibility of"] .. " " .. skill_name
			subtbl.get  = function() return not tcgTradeskills:IsHidden(skill_name) end
			subtbl.set  = function() tcgTradeskills:ToggleHidden(skill_name) end
		end
	end

	-- Purge/Filter settings
	local tbl1 = self.options.args.filters.args
	local tbl2 = self.options.args.purge.args
	if (tbl1) then
		compost:Reclaim(tbl1, 5)
		compost:Reclaim(tbl2, 5)
	end
	tbl1 = compost:Acquire()
	tbl2 = compost:Acquire()
	self.options.args.filters.args = tbl1
	self.options.args.purge.args = tbl2

	for realm, realm_data in pairs(self.data) do
		local cur_realm = realm
		local realm_key = string.gsub(cur_realm, " ", "_")
		if (not tbl1[realm_key]) then
			tbl1[realm_key] = compost:Acquire()
			tbl2[realm_key] = compost:Acquire()

			tbl1[realm_key].type = "group"
			tbl1[realm_key].name = cur_realm
			tbl1[realm_key].desc = cur_realm
			tbl1[realm_key].args = compost:Acquire()

			tbl2[realm_key].type = "group"
			tbl2[realm_key].name = cur_realm
			tbl2[realm_key].desc = cur_realm
			tbl2[realm_key].args = compost:Acquire()
		end
		for char, _ in pairs(realm_data) do
			local cur_char  = char
			local key_name = char
			local subtbl1 = compost:Acquire()
			local subtbl2 = compost:Acquire()
			subtbl1.type = "toggle"
			subtbl1.name = char
			subtbl1.desc = L["Filter"] .. " " .. subtbl1.name
			subtbl1.set  = function() tcgTradeskills:ToggleFiltered(cur_realm, cur_char) end
			subtbl1.get  = function() return not tcgTradeskills:IsFiltered(cur_realm, cur_char) end
			tbl1[realm_key].args[key_name] = subtbl1

			subtbl2.type = "execute"
			subtbl2.name = char
			subtbl2.desc = L["Purge"] .. " " .. subtbl1.name
			subtbl2.func = function() tcgTradeskills:Purge(cur_realm, cur_char) end
			tbl2[realm_key].args[key_name] = subtbl2
		end
	end

	for name, ptr in self:IterateModules() do
		if (ptr.InjectOptionsTable) then ptr:InjectOptionsTable(self.options) end
	end

	self:Debug("OnMenuRequest(): Regenerated Options Table")
	self.cached_options = self.options
	dewdrop:FeedAceOptionsTable(self.cached_options)
end

function tcgTradeskills:FilterRealm(realm)
	if (not self.db.profile.server_filters) then self.db.profile.server_filters = compost:Acquire() end
	self.db.profile.server_filters[realm] = not self.db.profile.server_filters[realm]
end

function tcgTradeskills:IsRealmFiltered(realm)
	if (realm == self.myRealm) then return end
	if (self.db.profile.server_filters) then return self.db.profile.server_filters[realm] end
end

function tcgTradeskills:OnTooltipUpdate()
	if (not self.data) then return end
	if (not self.realmList) then return end

	local oneRealm = table.getn(self.realmList) == 1
	self:Debug("Refreshing Tooltip")

	if (self:IsDebugging() and self:IterateModules()) then
		local mods = tablet:AddCategory(
		"text", "Modules:",
		"child_justify", "CENTER"
		)
		for name, ptr in self:IterateModules() do
			mods:AddLine(
			"indent", 15,
			"text", name
			)
		end
	end

	for _, realm in ipairs(self.realmList) do
		self:Debug("* Realm: %s", realm)
		if (not self:IsRealmView() or self.myRealm == realm) then
			local cat = tablet:AddCategory(
			'columns', 2,
			'text', not oneRealm and realm,
			'child_text1R', 1, 'child_text1G', 1, 'child_text1B', 1,
			'child_text2R', 1, 'child_text2G', 1, 'child_text2B', 1,
			'showWithoutChildren', true,
			'checked', true,
			'hasCheck', true,
			'func', "FilterRealm", 'arg1', self, 'arg2', realm,
			'checkIcon', self:IsRealmFiltered(realm) and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up"
			)

			if (not self:IsRealmFiltered(realm)) then
				for _, char in ipairs(self.charList[realm]) do
					self:Debug("  * Character: %s", char)
					if (not self:IsFiltered(realm, char)) then
						if (self.data_refreshed or not self.sorted_data or not self.sorted_data[realm] or not self.sorted_data[realm][char]) then
							self:Debug("Refreshing Data for %s of %s", char, realm)

							if (not self.sorted_data) then self.sorted_data = compost:Acquire() end
							if (not self.sorted_data[realm]) then self.sorted_data[realm] = compost:Acquire() end
							if (self.sorted_data[realm][char]) then compost:Reclaim(self.sorted_data[realm][char], 5) end

							self.sorted_data[realm][char] = compost:Acquire()

							local data = self.sorted_data[realm][char]
							for skill, skill_data in pairs(self.data[realm][char]) do
								if (type(skill_data) == "table" and skill_data.rank) then
									local r, g, b = crayon:GetThresholdColor(skill_data.rank / skill_data.maxrank, 0, 0.25, 0.50, 0.75, 1.0)
									local tbl = compost:Acquire()
									tbl.name = skill
									tbl.r = r
									tbl.g = g
									tbl.b = b
									tbl.rank_string = format("%d/%d", skill_data.rank, skill_data.maxrank)
									table.insert(data, tbl)
								end
							end
							table.sort(data, function(a, b) return a.name <= b.name end)
							data.classColor = blclass:GetHexColor(self.data[realm][char].class)
						end
						local data = self.sorted_data[realm][char]

						if (not data) then
							self:PrintMsg("Problem displaying %s of %s data", (char or "nil"), (realm or "nil"))
						else
							local skills = cat:AddCategory(
							'text', format("|cff%s%s|r [|cffffffff%d|r]", data.classColor, char, self.data[realm][char].level or 0),
							'indentation', 5)
							for k, v in data do
								if (type(v) == "table") then
									self:LevelDebug(6, "(%s) %s - %s [%d/%d]", realm, char, k, v.rank, v.maxrank)
									skills:AddLine(
									'indentation', 10,
									'text', v.name,
									'text2', v.rank_string,
									'text2R', v.r,
									'text2G', v.g,
									'text2B', v.b
									)
									if (self:HasModule("Cooldowns")) then self:GetModule("Cooldowns"):InjectCooldownTooltip(skills, realm, char, v.name) end
								end
							end
						end
						-- compost:Reclaim(data)
						if (self:HasModule("Cooldowns")) then self:GetModule("Cooldowns"):InjectCooldownTooltip(skills, realm, char) end
					end
				end
			end
		end
	end
	self.data_refreshed = nil
end

function tcgTradeskills:PrintMsg(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff7f" .. self.name .. "|r: " .. string.format(unpack(arg)))
end

function tcgTradeskills:GetTranslation(skill)
	if (blspell[skill]) then return blspell[skill] end

	for blooper, english_name in pairs(silly_map) do
		if (english_name == skill) then return blooper end
	end
end

function tcgTradeskills:GetReverseTranslation(skill)
	if (blspell:HasReverseTranslation(skill)) then return blspell:GetReverseTranslation(skill) end

	if (silly_map[skill]) then return silly_map[skill] end
end

function tcgTradeskills:SkillExists(name)
	self:LevelDebug(5, "tcgTradeskills:SkillExists(%s)", name)
	if (self.myData) then
		if (self.myData[name]) then
			return true
		end
		if (linked_skills[name] and self.myData[linked_skills[name]]) then
			return true
		end
	end
end

function tcgTradeskills:GetParentSkill(name)
	self:LevelDebug(5, "tcgTradeskills:GetParentSkill(%s)", name)
	if (not linked_skills[name]) then
		return name
	else
		return linked_skills[name]
	end
end

function tcgTradeskills:BuildButtons()
	self:Debug("BuildButtons() - buttons_changed(%s)", (self.buttons_changed and "true" or "false"))

	if (not self.buttons_changed or not self.myData or not self.frame) then return end

	local HideButton = function(name)
		local button = getglobal("tcgTradeskillsFrame" .. name)
		if (button) then
			button:Hide()
			self:Debug("Hiding Button: %s", tostring(name))
		end
	end

	local last
	local frameWidth = 0
	for name, default_icon in tradeskills do
		local button_name = "tcgTradeskillsFrame" .. name
		local skillName = self:GetTranslation(name) or name
		if (self:SkillExists(skillName) and default_icon ~= 0) then
			if (not self:IsHidden(skillName)) then
				self:Debug("BuildButtons() - %s (%s)", tostring(name), tostring(button_name))
				local button = getglobal(button_name) or self:CreatePluginChildFrame("Button", button_name, self.frame)
				button:Show()
				button:EnableMouse(true)
				if (last) then
					button:SetPoint("LEFT", last, "RIGHT", self:GetButtonSpacing(), 0)
				else
					button:SetPoint("LEFT", self.frame, "LEFT", self:GetButtonSpacing(), 0)
				end

				local texture = getglobal(button_name .. "Texture") or button:CreateTexture(button_name .. "Texture")
				self:Debug("%s = %s", name, default_icon)
				texture:SetTexture(default_icon)
				texture:SetTexCoord(0.05, 0.95, 0.05, 0.95)

				texture:SetAllPoints(button)

				button:SetScript("OnClick", function() self:Debug("Casting: %s <%s>", tostring(skillName), tostring(button_name)); CastSpellByName(skillName) end)

				button:SetWidth(self:GetIconSize())
				button:SetHeight(self:GetIconSize())
				frameWidth = frameWidth + button:GetWidth() + self:GetButtonSpacing()

				last = button
			else
				HideButton(name)
			end
		else
			HideButton(name)
		end
	end

	if (frameWidth > 0) then
		self:SetFontSize(self.fontSize)
		local texture = getglobal("tcgTradeskillsFrameEmptyTexture")
		if (texture) then texture:Hide() end
	else
		local texture = getglobal("tcgTradeskillsFrameEmptyTexture") or self.frame:CreateTexture("tcgTradeskillsFrameEmptyTexture")
		texture:SetTexture(blspell:GetSpellIcon("Tailoring"))
		texture:SetTexCoord(0.05, 0.95, 0.05, 0.95)
		texture:SetAllPoints(self.frame)
		texture:Show()
		self.frame:SetWidth(self.fontSize + 3)
		self.frame:SetHeight(self.fontSize + 3)
	end
	self.buttons_changed = nil
end

function tcgTradeskills:CheckWidth(force)
	self:Debug("tcgTradeskills:CheckWidth()")
	if (force) then
		self:SetFontSize(self.fontSize)
		if (self.panel and self.panel:GetPluginSide(self) == "CENTER") then
			self.panel:UpdateCenteredPosition()
		end
	end
end

function tcgTradeskills:SetFontSize(fsize)
	if (self.myData and fsize) then
		self:LevelDebug(2, "SetFontSize()")
		local frameWidth = 0
		local last
		local newIconSize = (self:GetIconSize() - self.fontSize) + fsize
		for name, default_icon in tradeskills do
			local skillName = self:GetTranslation(name) or name
			local button = getglobal("tcgTradeskillsFrame" .. name)
			if (button) then
				if (not self:IsHidden(skillName)) then
					button:SetWidth(newIconSize)
					button:SetHeight(newIconSize)

					if (last) then
						button:SetPoint("LEFT", last, "RIGHT", self:GetButtonSpacing(), 0)
					else
						button:SetPoint("LEFT", self.frame, "LEFT", self:GetButtonSpacing(), 0)
					end

					frameWidth = frameWidth + button:GetWidth() + self:GetButtonSpacing()
					last = button
				else
					button:Hide()
					self:Debug("SetFontSize(): Hiding Button: %s", tostring(name))
				end
			end
		end
		self.fontSize = fsize
		if (frameWidth > 0) then
			self.frame:SetWidth(frameWidth)
		else
			self.frame:SetWidth(newIconSize)
		end
	end
end

function tcgTradeskills:ToggleRealmView()
	if (self.db.profile.single_realm) then
		self.db.profile.single_realm = nil
	else
		self.db.profile.single_realm = true
	end
end

function tcgTradeskills:IsRealmView()
	return self.db.profile.single_realm
end

function tcgTradeskills:IsFiltered(realm, person)
	self:LevelDebug(5, "IsFiltered(%s of %s)", (person or "-nil-"), (realm or "-nil-"))
	return self.data[realm][person].hidden
end

function tcgTradeskills:ToggleFiltered(realm, person)
	if (self.data[realm][person].hidden) then
		self.data[realm][person].hidden = nil
	else
		self.data[realm][person].hidden = true
	end
end

function tcgTradeskills:IsHidden(name)
	self:LevelDebug(5, "IsHidden(%s)", (name or "-nil-"))
	if (self.db.char) then return self.db.char[name] end
end

function tcgTradeskills:ToggleHidden(name)
	if (self.myData) then
		self:Debug("ToggleHidden(%s)", (name or "-nil-"))
		if (self.db.char[name]) then
			self.db.char[name] = nil
		else
			self.db.char[name] = true
		end
		self.buttons_changed = true
		self:BuildButtons()
	end
end

function tcgTradeskills:Purge(realm, person)
	self:PrintMsg(L["Purging %s of %s"], person, realm)
	self.data[realm][person] = nil
	if (self.cached_options) then self.cached_options = nil end
	self.data_refreshed = true
	self:ReIndex()
end

local reIndexDepth = 0
function tcgTradeskills:ReIndex()
	if (reIndexDepth > 3) then
		self:DumpLibraries()
		self:PrintMsg("ReIndex has runaway recursion, report to author")
		return
	end
	reIndexDepth = reIndexDepth + 1
	self:Debug("tcgTradeskills:ReIndex()")

	if (not self.db.account or not self.db.raw.account) then
		if (not self:IsEventRegistered("tcgTradeskills_ReIndex")) then
			self:Debug("self.db.account == nil, delaying initialization 3 seconds")
			self:ScheduleEvent("tcgTradeskills_ReIndex", self.ReIndex, 3, self)
		end
		return
	end

	self.data = self.db.account

	if (self.db.raw.full and self.db.raw.full.realms) then
		for realm, realm_data in self.db.raw.full.realms do
			for char, char_data in realm_data do
				if (not self.db.account[realm]) then self.db.account[realm] = {} end
				if (not self.db.account[realm][char]) then
					self.db.account[realm][char] = char_data
					self:PrintMsg("Converted: %s of %s", char, realm)
				end
			end
		end
		self.db.raw.full = nil
		self:PrintMsg("Converted DB to AceDB-2.0")
	end

	self.myRealm = GetRealmName()
	self.myName = UnitName("player")

	if (not self.data[self.myRealm]) then self.data[self.myRealm] = {} end
	if (not self.data[self.myRealm][self.myName]) then self.data[self.myRealm][self.myName] = {} end

	self.myData = self.data[self.myRealm][self.myName]
	self.buttons_changed = true
	self:Save()

	if (not self.realmList or not self.charList) then
		self.realmList = compost:Acquire()
		self.charList = compost:Acquire()
	else
		self.realmList = compost:Recycle(self.realmList)
		self.charList = compost:Recycle(self.charList)
	end

	for realm, realm_data in pairs(self.data) do
		table.insert(self.realmList, realm)
		self.charList[realm] = compost:Acquire()
		for char, data in realm_data do
			table.insert(self.charList[realm], char)
		end
		table.sort(self.charList[realm])
	end
	table.sort(self.realmList)

	reIndexDepth = reIndexDepth - 1
end

function tcgTradeskills:GetIconSize()
	return self.db.profile.icon_size + self.fontSize
end

function tcgTradeskills:SetIconSize(size)
	if (size) then
		size = size - self.fontSize
		self:Debug("Setting Icon Size to " .. size)
		self.db.profile.icon_size = size
		self:SetFontSize(self.fontSize)
	end
end

function tcgTradeskills:GetButtonSpacing()
	return self.db.profile.button_spacing
end

function tcgTradeskills:SetButtonSpacing(spacing)
	if (spacing) then
		self:Debug("Setting Button Spacing to " .. spacing)
		self.db.profile.button_spacing = spacing
		self:SetFontSize(self.fontSize)
	end
end

function tcgTradeskills:SKILL_LINES_CHANGED()
	self:Save()
end

function tcgTradeskills:Save()
	if (self:IsEventRegistered("SKILL_LINES_CHANGED")) then self:UnregisterEvent("SKILL_LINES_CHANGED") end

	self:Debug("tcgTradeskills:Save()")
	if (not self.myData) then
		self:ReIndex()
	elseif (UnitLevel("player") > 0) then
		local nSkills = GetNumSkillLines()
		local t = self.myData

		if (nSkills > 0) then
			self:Debug("Found %d SkillLines", nSkills)
			for k, v in pairs(t) do
				if (type(v) == "table" and v.rank) then v.dirty = 1 end
			end

			local function CheckLines(a, b, depth)
				if (not depth) then depth = 0 end
				if (depth > 2) then
					self:DumpLibraries()
					self:PrintMsg("(DEBUG) Runaway CheckLines(%d, %d) (depth=%d), report to Author", a, b, depth)
					return
				end

				self:Debug("Processing Skill Lines %d - %d (%d -> %d)", a, b, nSkills, GetNumSkillLines())
				for n = a, b do
					local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(n)
					if (isHeader) then
						if (not isExpanded) then
							self:Debug("Expanding Collapsed Skill Header: %s", skillName)
							ExpandSkillHeader(n)
							CheckLines(n+1, n + (GetNumSkillLines() - b), depth + 1)
							CollapseSkillHeader(n)
						end
					else
						if (silly_map[skillName]) then skillName = self:GetTranslation(silly_map[skillName]) end
						local english_name = self:GetReverseTranslation(skillName)
						if (english_name) then
							if (tradeskills[english_name]) then
								if (not t[skillName]) then
									self:Debug("New TradeSkill: %s - %d/%d [%s]", skillName, skillRank, skillMaxRank, english_name)
									t[skillName] = compost:Acquire()
									self.buttons_changed = true
								else
									self:Debug("TradeSkill: %s - %d/%d [%s]", skillName, skillRank, skillMaxRank, english_name)
								end
								t[skillName].rank = skillRank
								t[skillName].maxrank = skillMaxRank
								t[skillName].dirty = nil
							end
						end
						self:Debug("Skill: %s (%d/%d) [%s]", skillName, skillRank, skillMaxRank, self:GetReverseTranslation(skillName) or "-no translation-")
					end
				end
			end

			CheckLines(1, nSkills)

			for k, v in pairs(t) do
				if (type(v) == "table" and v.dirty) then
					self:Debug("Removing Unlearned Skill: %s", k)
					t[k] = nil
					self.buttons_changed = true
				end
			end

			t.level = UnitLevel("player")
			t.class = UnitClass("player")
			t.time = time()
			if (self.buttons_changed) then self:BuildButtons() end
			self.data_refreshed = true
		end

		for name, ptr in self:IterateModules() do
			if (ptr.Save) then ptr:Save() end
		end
	end
	if (not self:IsEventRegistered("SKILL_LINES_CHANGED")) then self:RegisterEvent("SKILL_LINES_CHANGED") end
	self:ValidateDB()
end

function tcgTradeskills:DumpLibraries()
	local Libs = {
		"AceEvent-2.0",
		"AceDB-2.0",
		"AceAddon-2.0",
		"AceOO-2.0",
		"AceLibrary",
		"FuBarPlugin-2.0",
	}

	for _, lib in pairs(Libs) do
		if (AceLibrary) then
			if (AceLibrary:HasInstance(lib)) then
				self:PrintMsg("Found Library: %s rev%s", AceLibrary(lib):GetLibraryVersion(lib))
			else
				self:PrintMsg("CRITICAL: Missing required library %s", lib)
			end
		else
			self:PrintMsg("CRITICAL: Missing AceLibrary")
		end
	end
end

local function nilCheck(condition, message)
	if (not condition) then
		tcgTradeskills:PrintMsg("Invalid Data Found! (%s)", message)
		return true
	end
end

function tcgTradeskills:ValidateDB()
	for realm, rdata in pairs(self.data) do
		for char, cdata in pairs(rdata) do
			for k, v in pairs(cdata) do
				if (type(v) == "table") then
					for sk, sv in pairs(v) do
						if (sk == "rank") then remove = nilCheck(v["maxrank"], string.format("Max Rank missing for %s/%s/%s", realm, char, k)) end
						if (sk == "maxrank") then remove = nilCheck(v["rank"], string.format("Rank missing for %s/%s/%s", realm, char, k)) end
						self:Debug("%10s %10s %10s %10s=%s", realm, char, k, sk, sv)
					end
				else
					self:Debug("%10s %10s %10s=%s", realm, char, k, (v == true and "true" or v))
				end
			end
			if (remove) then
				self:PrintMsg("Found invalid data for %s of %s, removing...", char, realm)
				rdata[char] = nil
				self:ReIndex()
			end
		end
	end
end
