-- vim: noet
if (not tcgTradeskills) then
	error("tcgTradeskills Core Module is not loaded, please check that Core.lua exists in this folder.")
	return
end

if (not AceLibrary:HasInstance("Abacus-2.0")) then
	error("tcgTradeskills (Cooldowns) requires that the Abacus embeded library be available.")
	return
end

local abacus = AceLibrary("Abacus-2.0")


tcgTradeskillsCooldowns = tcgTradeskills:NewModule("Cooldowns")
tcgTradeskillsCooldowns.name = "tcgTradeskills - Cooldowns"

local parent = tcgTradeskills
local dewdrop
local blspell
local compost

local L = AceLibrary("AceLocale-2.2"):new("FuBar_tcgTradeskillsCooldowns")

local itemlinks = {} -- Item link cache

local time_formats = {
	["abacus"]  = function(eta) return abacus:FormatDurationFull(eta - time(), true, true) end,     -- Abacus
	["mdyhmp"]  = function(eta) return date("%m/%d/%Y %I:%M%p", eta) end,
	["dmyhmp"]  = function(eta) return date("%d/%m/%Y %I:%M%p", eta) end,
	["dByhm"]   = function(eta) return date("%d %B, %Y %H:%M", eta) end,                            -- "D M, Y HH:MM"
	["mdyhm"]   = function(eta) return date("%m/%d/%Y %H:%M", eta) end,                             -- "M/D/Y HH:MM"
	["dmyhm"]   = function(eta) return date("%d/%m/%Y %H:%M", eta) end,                             -- "D/M/Y HH:MM"
	["c"]       = function(eta) return date("%c", eta) end,                                         -- Locale specific
}

local L_MATCHES = {
	[0] = string.gsub(LOOT_ITEM_CREATED_SELF, "%%s", "(.+)"),
	[1] = string.gsub(LOOT_ITEM_PUSHED_SELF, "%%s", "(.+)"),
}

local L_MULTIMATCHES = {
	[0] = string.gsub(LOOT_ITEM_CREATED_SELF_MULTIPLE, "%%s(%w+)%%d", "(.+)%1(%%d+)"),
	[1] = string.gsub(LOOT_ITEM_PUSHED_SELF_MULTIPLE, "%%s(%w+)%%d", "(.+)%1(%%d+)"),
}

local cooldowns = {
	-- [6265]  = {duration = 3600,    skill = "Tailoring"      }, -- Soul Shard for testing

	[7076]  = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Essence of Earth
	[7078]  = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Essence of Fire
	[7082]  = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Essence of Air
	[7080]  = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Essence of Water
	[12803] = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Living Essence
	[12808] = {duration = 86400,   skill = "Alchemy", shared=1  }, -- Essence of Undeath
	[12360] = {duration = 172800,  skill = "Alchemy", shared=1  }, -- Arcanite Bar
	[7068]  = {duration = 600,     skill = "Alchemy", shared=1  }, -- Elemental Fire
	[15409] = {duration = 259200,  skill = "Leatherworking"     }, -- Refined Deeprock Salt
	[14342] = {duration = 345600,  skill = "Tailoring"          }, -- Mooncloth
	[17202] = {duration = 86400,   skill = "Engineering"        }, -- Snowball

	-- [21536] = {duration = 86400                             }, -- Elune Stone
}

function tcgTradeskillsCooldowns:OnEnable()
	self:RegisterEvent("CHAT_MSG_LOOT")

	self:ScheduleEvent("tcgTradeskills_CheckExpirations", self.Check, 30, self)

	dewdrop = parent.libs.dewdrop
	blspell = parent.libs.blspell
	compost = parent.libs.compost

	parent.cached_options = nil
end

function tcgTradeskillsCooldowns:InjectOptionsTable(parent_options)
	parent:Debug("Cooldowns:InjectOptionsTable()")
	local options = parent_options.args.settings.args
	options["alert_delay"] = {
		type = "range",
		name = L["Alert Delay"],
		desc = L["Set Cooldown Alert Delay"],
		min  = 5,
		max  = 60,
		step = 1,
		set  = function(v) parent.db.profile.alert_delay = v * 60 end,
		get  = function() return (parent.db.profile.alert_delay and parent.db.profile.alert_delay / 60) or 5 end,
	}
	options["alert_sound"] = {
		type = "toggle",
		name = L["Play Cooldown Sound"],
		desc = L["Play sound when cooldown expires"],
		set  = function(v) parent.db.profile.alert_sound = v end,
		get  = function() return parent.db.profile.alert_sound end,
	}

	-- Date/Time/ETA format
	if (options["eta_format"] and options["eta_format"].validate) then compost:Reclaim(options["eta_format"].validate) end
	options["eta_format"] = {
		type = "text",
		name = L["Cooldown Time Format"],
		desc = L["Set the display format for cooldown expirations."],
		validate = compost:Acquire(),
		set  = function(v) parent.db.profile.eta_format = v end,
		get  = function() return parent.db.profile.eta_format or "abacus" end,
	}
	for k, v in pairs(time_formats) do
		options["eta_format"].validate[k] = v(time() + 89300)
	end

	options = parent.options.args
	options["rescan"] = {
		type = "execute",
		name = L["Rescan Cooldowns"],
		desc = L["Rescan open tradeskill window for cooldowns"],
		func = function() self:ScanList() end,
	}

	-- This looks untidy, but it's done this way so the option isnt created when no cooldowns are known
	options = parent.options.args
	local opt_realm = options["cooldowns"]
	if (opt_realm) then
		compost:Reclaim(opt_realm, 6)
		opt_realm = nil
	end

	for realm, realm_data in pairs(parent.data) do
		local safe_realm = realm
		local realm_key = string.gsub(safe_realm, " ", "_")
		for char, cdata in pairs(realm_data) do
			local safe_char = char
			local opt_char
			parent:Debug("%s of %s", char, realm)
			for k, v in cdata do
				if (k == "cooldowns") then
					local safe_char  = char
					local safe_name = char
					for code, _ in pairs(v) do
						local code_key = string.format("item_%d", code)
						local safe_code = code
						if (not opt_char) then
							if (not opt_realm) then
								opt_realm = compost:Acquire()
								opt_realm.type = "group"
								opt_realm.name = L["Cooldowns"]
								opt_realm.desc = L["Purge Cooldowns"]
								opt_realm.args = compost:Acquire()
								options["cooldowns"] = opt_realm
								opt_realm = options.cooldowns.args
							end
							if (not opt_realm[realm_key]) then
								opt_realm[realm_key] = compost:Acquire()
								opt_realm[realm_key].type = "group"
								opt_realm[realm_key].name = safe_realm
								opt_realm[realm_key].desc = safe_realm
								opt_realm[realm_key].args = compost:Acquire()
							end
							opt_char = compost:Acquire()
							opt_char.type = "group"
							opt_char.name = char
							opt_char.desc = string.format(L["Purge Cooldowns for %s"], safe_char)
							opt_char.args = compost:Acquire()
							opt_realm[realm_key].args[safe_name] = opt_char
						end
						local opt_item = compost:Acquire()
						opt_item.type = "execute"
						opt_item.name = self:ItemLink(code)
						opt_item.desc = self:ItemLink(code)
						opt_item.func = function() self:Stop(safe_realm, safe_char, safe_code); dewdrop:Close(3) end
						opt_char.args[code_key] = opt_item
					end
				end
				opt_char = nil
			end
		end
	end

	--[[
	options = parent.options.args
	if (options["set_cooldowns"]) then compost:Reclaim(options["set_cooldowns"], 3) end
	options["set_cooldowns"] = compost:Acquire()
	options["set_cooldowns"].args = compost:Acquire()

	options["set_cooldowns"].type = "group"
	options["set_cooldowns"].name = "Set Cooldown"
	for code, data in pairs(cooldowns) do
		local c = code
		local t = compost:Acquire()
		options["set_cooldown"].args["c_" .. code] = t

		t.type = "text"
		t.name = string.format("Set Cooldown for %s", self:ItemLink(code))
		t.desc = t.name
		t.get  = false
		t.set  = function(v) self:ManualCooldown(c, v) end
	end
	]]--
end

function tcgTradeskillsCooldowns:ScanList()
	local Scan = function(a, b, depth)
		if (not depth) then depth = 0 end
		depth = depth + 1
		if (depth > 3) then parent:PrintMsg("MaxDepth exceeded in ScanList()") return end

		parent:PrintMsg(L["Scanning recipes: %d-%d"], a, b)
		for i = a, b do
			local itemName, itemType, itemAvail, isExpanded = GetTradeSkillInfo(i)
			if (itemType == "header") then
				if (not isExpanded) then
					ExpandTradeSkillSubClass(i)
					Scan(i+1, (GetNumTradeSkills() - i), depth)
					CollapseTradeSkillSubClass(i)
				else
					parent:Debug("Found: %s", itemName or "-nil-")
				end
			else
				local link = GetTradeSkillItemLink(i)
				if (link) then
					local _, _, code = string.find(link, "item:(%d+):%d+:%d+:%d+")
					code = tonumber(code)
					parent:Debug("Found: %s (%d)", itemName or "-nil-", code or -1)
					if (code and cooldowns[code]) then
						local cooldown = GetTradeSkillCooldown(i)
						if (cooldown) then
							parent:PrintMsg("Setting Cooldown for %s", link)
							self:Start(code, time() + cooldown)
						end
					end
				end
			end
		end
	end

	if (GetNumTradeSkills() > 0) then
		Scan(1, GetNumTradeSkills())
	else
		parent:PrintMsg(L["No tradeskill window open for scanning."])
	end
end

function tcgTradeskillsCooldowns:OnDisable()
	self:UnregisterEvent("CHAT_MSG_LOOT")
end

function tcgTradeskillsCooldowns:CHAT_MSG_LOOT()
	self:CheckForCooldown(arg1)
end

function tcgTradeskillsCooldowns:CheckForCooldown(msg)
	for k, match in pairs(L_MATCHES) do
		local _, _, item = string.find(msg, match)
		parent:Debug("MATCHING(%s): %s", match, (item or "-nil-"))
		if (item) then
			local _, _, link, qty = string.find(item, L_MULTIMATCHES[k])
			parent:Debug("MATCHING(%s): %s", L_MULTIMATCHES[k], (link or "-nil-"))
			if (link) then
				self:CheckItemLink(link, qty)
			else
				self:CheckItemLink(item, 1)
			end
			return
		end
	end
end

function tcgTradeskillsCooldowns:PrintCode(link)
	if (link) then
		local _, _, code = string.find(link, "item:(%d+):%d+:%d+:%d+")
		parent:PrintMsg("%s [code=%d]", link, (code or -1))
	end
end

function tcgTradeskillsCooldowns:CheckItemLink(link)
	local _, _, code = string.find(link, "item:(%d+):%d+:%d+:%d+")
	parent:Debug("Checking for Cooldown: %s", link)
	if (code) then
		code = tonumber(code)
		if (cooldowns[code]) then
			self:Start(code)
		else
			parent:Debug("%s has no creation cooldown [id=%d]", link, code)
		end
	else
		parent:Debug("%s is not an item link", link)
	end
end

function tcgTradeskillsCooldowns:Save()
	parent:Debug("Cooldowns:Save()")
	self:Check(nil, true)
end

function tcgTradeskillsCooldowns:Check(dueOnly, forceQuiet)
	parent:Debug("Cooldowns:Check()")
	local didHeader
	for realm, rdata in pairs(parent.data) do
		for char, cdata in pairs(rdata) do
			for i, v in pairs(cdata) do
				if (i == "cooldowns") then
					for code, eta in v do
						if (not forceQuiet and (not dueOnly or (dueOnly and eta <= time()))) then
							if (not didHeader) then
								parent:PrintMsg(L["%s of %s:"], char, realm)
								didHeader = true
							end
							local time_str = time_formats[parent.db.profile.eta_format or "abacus"](eta)
							parent:Debug("CD: %s - %s - %d - %s", self:ItemLink(code) or "-nil-", cooldowns[code].skill or "-nil-", code or -999, blspell[cooldowns[code].skill] or "-nil-")
							if (eta - time() > 0) then
								parent:PrintMsg(L["  %s cooldown is %s %s (%s)"], self:ItemLink(code), (parent.db.profile.eta_format and (parent.db.profile.eta_format == "abacus") and L["in"] or L["at"]), time_formats[parent.db.profile.eta_format or "abacus"](eta), (cooldowns[code].skill and blspell[cooldowns[code].skill] or "item"))
							else
								parent:PrintMsg(L["  %s cooldown has expired (%s)"], self:ItemLink(code), (cooldowns[code].skill and blspell[cooldowns[code].skill] or "item"))
							end
						end
						local event = string.format("tcgTSCD_%s_%s_%d", realm, char, code)
						if (not self:IsEventScheduled(event)) then
							parent:Debug("Scheduling %s to fire in %d seconds", event, eta - time())
							self:ScheduleEvent(event, tcgTradeskillsCooldowns.Alert, eta - time(), self, realm, char, code)
						end
					end
				end
				didHeader = nil
			end
		end
	end
end

function tcgTradeskillsCooldowns:ItemLink(code)
	if (code) then
		if (itemlinks[code]) then return itemlinks[code] end

		local name, codestr, quality = GetItemInfo(code)
		if (quality) then
			local _, _, _, color = GetItemQualityColor(quality or 1)
			local link = color .. "|H" .. codestr .. "|h[" .. name .. "]|h|r"

			itemlinks[code] = link

			return link
		end
	end

	return "Unknown Item"
end

function tcgTradeskillsCooldowns:Alert(realm, char, code)
	local msg = string.format(L["%s of %s: Cooldown expired for %s"], char, realm, self:ItemLink(code))
	parent:PrintMsg(msg)

	local event = string.format("tcgTSCD_%s_%s_%d", realm, char, code)
	self:ScheduleEvent(event, tcgTradeskillsCooldowns.Alert, parent.db.profile.alert_delay or 120, self, realm, char, code)

	if (parent.db.profile.alert_sound) then PlaySound("LEVELUPSOUND") end

	if (MikSBT) then MikSBT.DisplayMessage(msg, MikSBT.DISPLAYTYPE_NOTIFICATION, true, 40, 0, 100) end

end

function tcgTradeskillsCooldowns:Start(code, eta)
	local s = parent.myData.cooldowns
	if (not s) then
		parent.myData.cooldowns = compost:Acquire()
		self:Start(code, eta)
	else
		parent:Debug("Starting Cooldown for %s", self:ItemLink(code))
		if (cooldowns[code].shared) then
			for cdc, eta in pairs(s) do
				if (cooldowns[cdc].shared and cooldowns[cdc].shared == cooldowns[code].shared) then
					parent:PrintMsg(L["%s is on the same cooldown timer as %s, removing"], self:ItemLink(cdc), self:ItemLink(code))
					s[cdc] = nil
				end
			end
		end
		s[code] = eta or (time() + cooldowns[code].duration)
		parent.cached_options = nil

		local event = string.format("tcgTSCD_%s_%s_%d", parent.myRealm, parent.myName, code)
		if (self:IsEventScheduled(event)) then self:CancelScheduledEvent(event) end

		self:Check()
	end
end

function tcgTradeskillsCooldowns:Stop(realm, name, code)
	local event = string.format("tcgTSCD_%s_%s_%d", realm, name, code)
	if (self:IsEventScheduled(event)) then
		self:CancelScheduledEvent(event)
	end
	parent.data[realm][name].cooldowns[code] = nil
	parent.cached_options = nil
end

function tcgTradeskillsCooldowns:InjectCooldownTooltip(t, realm, name, skill)
	local s = parent.data[realm][name].cooldowns

	if (s) then
		for code, eta in s do
			if (cooldowns[code]) then
				if ((not skill and not cooldowns[code].skill) or (skill and cooldowns[code].skill == parent:GetReverseTranslation(skill))) then
					local name, _, quality = GetItemInfo(code)
					if (name) then
						local _, _, _, hexcolor = GetItemQualityColor(quality or 3)
						local timecolor = (eta > time() and "ffffff" or "ff0000")
						t:AddLine(
						'indentation', 20,
						'text', string.format("%s%s|r", hexcolor, name),
						'text2', string.format("|cff%s%s|r", timecolor, time_formats[parent.db.profile.eta_format or "abacus"](eta))
						)
					end
				end
			end
		end
	end
end
