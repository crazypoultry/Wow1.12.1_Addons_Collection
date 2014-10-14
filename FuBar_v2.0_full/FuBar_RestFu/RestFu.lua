local compost = AceLibrary("Compost-2.0")
local babbleClass = AceLibrary("Babble-Class-2.2")
local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("Abacus-2.0")
local crayon = AceLibrary("Crayon-2.0")
local L = AceLibrary("AceLocale-2.2"):new("RestFu")

RestFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0", "AceConsole-2.0")
RestFu.hasIcon = "Interface\\AddOns\\FuBar_RestFu\\icon.tga"
RestFu.defaultPosition = "RIGHT"
RestFu.hasNoText = true
RestFu.hideWithoutStandby = true
RestFu:RegisterDB("RestFuDB")

-- Change this to 70 for TBC beta.
local maxLevel = 60

local options = {
	handler = RestFu,
	type = 'group',
	args = {
		filters = {
			type = "group",
			name = L["Filter"],
			desc = L["Filter Tooltip Characters"],
		},
		purge = {
			type = "group",
			name = L["Purge"],
			desc = L["Purge Characters"],
		},
	},
}

function RestFu:OnEnable()
	self:RegisterEvent("PLAYER_UPDATE_RESTING", "Save")
	self:RegisterEvent("PLAYER_XP_UPDATE", "Save")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "Save")
	self:RegisterEvent("TIME_PLAYED_MSG")

	self:ScheduleRepeatingEvent("RestFu_TimePlayed", self.OnUpdate_TimePlayed, 1, self)

	self:Save()
end

function RestFu:OnDisable()
	self:UnregisterEvent("PLAYER_UPDATE_RESTING")
	self:UnregisterEvent("PLAYER_XP_UPDATE")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("TIME_PLAYED_MSG")

	self:CancelScheduledEvent("RestFu_OnUpdate")
	self:CancelScheduledEvent("RestFu_UpdateTooltip")

	if (self:IsEventScheduled("RestFu_TimePlayed")) then 
		self:CancelScheduledEvent("RestFu_TimePlayed") 
	end
end

function RestFu:OnMenuRequest()
	if (not self.cached_options) then 
		-- Purge/Filter settings
		local tbl1 = options.args.filters.args
		local tbl2 = options.args.purge.args
		if (tbl1) then
		compost:Reclaim(tbl1, 5)
		compost:Reclaim(tbl2, 5)
		end
		tbl1 = compost:Acquire()
		tbl2 = compost:Acquire()
		options.args.filters.args = tbl1
		options.args.purge.args = tbl2

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
				local fullchar = string.format("%s %s %s", char, L["of"], realm)
				local key_name, _ = string.gsub(fullchar, " ", "_")
				local subtbl1 = compost:Acquire()
				local subtbl2 = compost:Acquire()
				subtbl1.type = "toggle"
				subtbl1.name = fullchar
				subtbl1.desc = L["Filter"] .. " " .. subtbl1.name
				subtbl1.set  = function() RestFu:ToggleFiltered(cur_realm, cur_char) end
				subtbl1.get  = function() return not RestFu:IsFiltered(cur_realm, cur_char) end
				tbl1[realm_key].args[key_name] = subtbl1

				subtbl2.type = "execute"
				subtbl2.name = fullchar
				subtbl2.desc = L["Purge"] .. " " .. subtbl1.name
				subtbl2.func = function() RestFu:Purge(cur_realm, cur_char) end
				tbl2[realm_key].args[key_name] = subtbl2
			end
		end
		self.cached_options = options
	end
	dewdrop:FeedAceOptionsTable(self.cached_options)
end


function RestFu:IsFiltered(realm, person)
	return self.data[realm][person].hidden
end

function RestFu:ToggleFiltered(realm, person)
	self.data[realm][person].hidden = not self.data[realm][person].hidden
end

function RestFu:Purge(realm, person)
	self.data[realm][person] = nil
	self:ReIndex()
	self.cached_options = nil
end

function RestFu:ReIndex()
	if (not self:IsEventScheduled("RestFu_OnUpdate")) then 
		self:ScheduleRepeatingEvent("RestFu_OnUpdate", self.OnUpdate, 3, self) 
		self:ScheduleRepeatingEvent("RestFu_UpdateTooltip", self.UpdateTooltip, 60, self) 
	end

	if (self.db.raw.full and self.db.raw.full.realms) then
		for realm, realm_data in self.db.raw.full.realms do
			for char, char_data in realm_data do
				if (not self.db.account[realm]) then self.db.account[realm] = {} end
				if (not self.db.account[realm][char]) then 
					self.db.account[realm][char] = char_data
					self:Print(L["RestFu: Converted: %s of %s"], char, realm)
				end
			end
		end
		self.db.raw.full = nil
		self:Print(L["RestFu: Converted DB to AceDB-2.0"])
	end

	if (not self.db.account[self.REALM or GetRealmName()]) then self.db.account[self.REALM or GetRealmName()] = {} end
	if (not self.db.account[self.REALM or GetRealmName()][self.NAME or UnitName("player")]) then self.db.account[self.REALM or GetRealmName()][self.NAME or UnitName("player")] = {} end

	if (not self.realmList or not self.charList) then
		self.realmList = compost:Acquire()
		self.charList = compost:Acquire()
	else
		self.realmList = compost:Recycle(self.realmList)
		self.charList = compost:Reclaim(self.charList, 1)
		self.charList = compost:Acquire()
	end

	self.data = self.db.account
	for realm, realm_data in pairs(self.db.account) do
		table.insert(self.realmList, realm)
		for char, char_data in pairs(realm_data) do
			if (not self.charList[realm]) then self.charList[realm] = compost:Acquire() end
			table.insert(self.charList[realm], char)
		end
	end

	self.myData = self.db.account[self.REALM or GetRealmName()][self.NAME or UnitName("player")]

	self:Save()
	self:OnUpdate()
end

local percentPerSecond = 0.05 / 28800

function RestFu:OnTooltipUpdate()
	self:Save()
	self:OnUpdate()

	local oneRealm = table.getn(self.realmList) == 1

	local supercat = tablet:AddCategory(
	'columns', 6
	)
	for _,realm in ipairs(self.realmList) do
		local cat = supercat:AddCategory(
		'columns', 6,
		'text', oneRealm and L["Name"] or realm,
		'text2', L["Time played"],
		'text3', L["Time to rest"],
		'text4', L["Current XP"],
		'text5', L["Rest XP"],
		'text6', L["Zone"],
		'child_text1R', 1,
		'child_text1G', 1,
		'child_text1B', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 0,
		'child_text3R', 1,
		'child_text3G', 1,
		'child_text3B', 0,
		'child_text4R', 1,
		'child_text4G', 1,
		'child_text4B', 1
		)

		for _,char in ipairs(self.charList[realm]) do
			if not self:IsFiltered(realm, char) then
				local data = self.data[realm][char]
				local classColor = babbleClass:GetHexColor(data.class)
				if data.level ~= maxLevel then
					local r, g, b = crayon:GetThresholdColor(data.restXP / data.nextXP, 0, 0.5, 1, 1.25, 1.5)
					local timePassed = data.restXP / data.nextXP / percentPerSecond
					local timeToMax = 864000 - timePassed
					if not data.isResting then
						timeToMax = timeToMax * 4
					end
					local playedTime
					if realm == self.REALM and char == self.NAME and self.timePlayed then
						playedTime = self.timePlayed + time() - self.timePlayedMsgTime
					else
						playedTime = data.timePlayed or 0
					end
					cat:AddLine(
					'text', string.format("|cff%s%s|r [|cffffffff%d|r]", classColor, char, data.level or 0),
					'text2', abacus:FormatDurationCondensed(playedTime, true, true),
					'text3', timeToMax > 0 and abacus:FormatDurationCondensed(timeToMax, true, true) or format("|cff00ff00%s|r", L["Fully rested"]),
					'text4', string.format("%.0f%%", data.currXP / data.nextXP * 100),
					'text5', string.format("(%+.0f%%)", data.restXP / data.nextXP * 100),
					'text6', string.format("|cffffffff%s|r", data.zone or L["Unknown"]),
					'text5R', r,
					'text5G', g,
					'text5B', b
					)
				else
					local playedTime
					if realm == self.REALM and char == self.NAME and self.timePlayed then
						playedTime = self.timePlayed + time() - self.timePlayedMsgTime
					else
						playedTime = data.timePlayed or 0
					end
					cat:AddLine(
					'text', string.format("|cff%s%s|r [|cffffffff%d|r]", classColor, char, data.level),
					'text2', abacus:FormatDurationCondensed(playedTime, true, true),
					'text6', string.format("|cffffffff%s|r", data.zone or L["Unknown"])
					)
				end
			end
		end
	end
	local cat = tablet:AddCategory(
	'columns', 2
	)
	local total = 0
	for _,realm in ipairs(self.realmList) do
		for _,char in ipairs(self.charList[realm]) do
			if realm == self.REALM and char == self.NAME and self.timePlayed then
				total = total + self.timePlayed + time() - self.timePlayedMsgTime
			else
				total = total + (self.data[realm][char].timePlayed or 0)
			end
		end
	end
	cat:AddLine(
	'text', L["Total time played"],
	'text2', abacus:FormatDurationExtended(total, true, true),
	'textR', 1,
	'textG', 1,
	'textB', 1
	)
end

function RestFu:Save()
	if UnitLevel("player") ~= 0 then
		if (not self.myData) then self:ReIndex() end

		local t = self.myData
		t.level = UnitLevel("player")
		t.class = UnitClass("player")
		t.currXP = UnitXP("player")
		t.nextXP = UnitXPMax("player")
		t.restXP = GetXPExhaustion() or 0
		t.isResting = IsResting() and true or false
		t.zone = GetRealZoneText()
		if self.timePlayed then
			t.timePlayed = self.timePlayed + time() - self.timePlayedMsgTime
		elseif not t.timePlayed then
			t.timePlayed = 0
		end
		t.time = time()
	end
end

function RestFu:OnUpdate()
	if (not self.data) then return end

	local now = time()
	
	for realm, data in pairs(self.data) do
		for char, data in pairs(data) do
			if data.level ~= maxLevel and data.restXP < data.nextXP * 1.5 then
				local seconds = now - data.time
				local gained = data.nextXP * percentPerSecond * seconds
				if not data.isResting then
					gained = gained / 4
				end
				data.time = now
				data.restXP = data.restXP + gained
				if data.restXP > data.nextXP * 1.5 then
					data.restXP = data.nextXP * 1.5
				end
			end
		end
	end
	
	for realm, data in pairs(self.data) do
		table.sort(self.charList[realm], function(alpha, bravo)
			alpha = self.data[realm][alpha]
			bravo = self.data[realm][bravo]
			if alpha.level == maxLevel and bravo.level == maxLevel then
				return false
			elseif alpha.level == maxLevel then
				return false
			elseif bravo.level == maxLevel then
				return true
			end
			local timePassed = alpha.restXP / alpha.nextXP / percentPerSecond
			local timeToMaxAlpha = 864000 - timePassed
			if not alpha.isResting then
				timeToMaxAlpha = timeToMaxAlpha * 4
			end
			local timePassed = bravo.restXP / bravo.nextXP / percentPerSecond
			local timeToMaxBravo = 864000 - timePassed
			if not bravo.isResting then
				timeToMaxBravo = timeToMaxBravo * 4
			end
			if timeToMaxAlpha ~= timeToMaxBravo then
				return timeToMaxAlpha < timeToMaxBravo
			else
				return alpha.currXP / alpha.nextXP > bravo.currXP / bravo.nextXP
			end
		end)
	end
	table.sort(self.realmList, function(alpha, bravo)
		local alphaChar = self.charList[alpha][1]
		local bravoChar = self.charList[bravo][1]
		alpha = self.data[alpha][alphaChar]
		bravo = self.data[bravo][bravoChar]
		if not bravo then
			return true
		elseif not alpha then
			return false
		end
		local timePassed = alpha.restXP / alpha.nextXP / percentPerSecond
		local timeToMaxAlpha = 864000 - timePassed
		if not alpha.isResting then
			timeToMaxAlpha = timeToMaxAlpha * 4
		end
		local timePassed = bravo.restXP / bravo.nextXP / percentPerSecond
		local timeToMaxBravo = 864000 - timePassed
		if not bravo.isResting then
			timeToMaxBravo = timeToMaxBravo * 4
		end
		if timeToMaxAlpha ~= timeToMaxBravo then
			return timeToMaxAlpha < timeToMaxBravo
		else
			return alpha.currXP / alpha.nextXP > bravo.currXP / bravo.nextXP
		end
	end)
end

function RestFu:OnUpdate_TimePlayed()
	if (self:IsEventScheduled("RestFu_TimePlayed")) then self:CancelScheduledEvent("RestFu_TimePlayed") end
	RequestTimePlayed()
end

function RestFu:TIME_PLAYED_MSG()
	if (self:IsEventScheduled("RestFu_TimePlayed")) then self:CancelScheduledEvent("RestFu_TimePlayed") end
	self.timePlayed = arg1
	self.timePlayedMsgTime = time()
	self:Save()
end
