local L = AceLibrary("AceLocale-2.2"):new("AuldLangSyne")
AuldLangSyne = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceHook-2.1", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")

local deformat = AceLibrary("Deformat-2.0")
local BC = AceLibrary("Babble-Class-2.2")

function AuldLangSyne:OnInitialize()
	--self:SetDebugging(true)

	self:RegisterDB("AuldLangSyneDB")
	self:RegisterDefaults("realm", {
		chars = {
		},
		ignore = {},
		guild = {},
	})
	self:RegisterDefaults("char", {
		friends = {
			["*"] = {},
		},
	})
	self:RegisterDefaults("profile", {
		show = {
			pvp = true,
			pvpnum = false,
			guild = true,
			color = {
				name = true,
				class = true,
			},
			compact = false,
			clevels = true,
			intooltip = true,
			onlogon = true,
			onwho = true,
		},
	})

	self:RegisterChatCommand({"/AuldLangSyne", "/auld"}, {
		type = "group",
		name = L["AuldLangSyne"],
		desc = L["Options for AuldLangSyne."],
		args = {
			data = {
				type = "group", name = L["data"], desc = L["Random data-management functions"],
				args = {
					clear = {
						name = L["clear"], type = "execute",
						desc = L["Clear stored data"],
						func = "ClearData",
					},
					dump = {
						name = L["dump"], type = "execute",
						desc = L["Print stored data"],
						func = "DumpData",
					},
					ctimport = {
						name = L["ctimport"], type = "execute",
						desc = L["Import notes for this realm from CT_PlayerNotes"],
						func = "CTImport",
					},
				},
			},
			backup = {
				name = L["backup"], type = "group",
				desc = L["Options for backing up and restoring your friends list"],
				args = {
					save = {
						name = L["save"], type = "text", get = false,
						desc = L["Take a snapshot of your current friends list"],
						set = "SaveFriends", validate = {"1","2","3","4","5"},
					},
					load = {
						name = L["load"], type = "text", get = false,
						desc = L["Restore a snapshot of your friends list, wiping out your current friends list"],
						set = "LoadFriends", validate = {"1","2","3","4","5","undo"},
					},
				},
			},
			show = {
				type = "group",
				name = L["show"], desc = L["Choose what information to display"],
				args = {
					pvp = {
						name = "PVP", type = "toggle",
						desc = L["Turns display of PVP ranks on and off."],
						get = function() return self.db.profile.show.pvp end,
						set = function(t)
							self.db.profile.show.pvp = t
						end,
					},
					pvpnum = {
						name = L["PVP rank numbers"], type = "toggle",
						desc = L["Turns display of PVP rank numbers on and off."],
						get = function() return self.db.profile.show.pvpnum end,
						set = function(t)
							self.db.profile.show.pvpnum = t
						end,
					},
					guild = {
						name = L["Guild"], type = "toggle",
						desc = L["Turns display of guild membership on and off."],
						get = function() return self.db.profile.show.guild end,
						set = function(t)
							self.db.profile.show.guild = t
						end,
					},
					color = {
						type = "group", name = L["Colors"], desc = L["Choose which elements to color"],
						args = {
							name = {
								name = L["Name"], type = "toggle",
								desc = L["Turns coloring names by gender on and off."],
								get = function() return self.db.profile.show.color.name end,
								set = function(t)
									self.db.profile.show.color.name = t
								end,
							},
							class = {
								name = L["Class"], type = "toggle",
								desc = L["Turns coloring class names on and off."],
								get = function() return self.db.profile.show.color.class end,
								set = function(t)
									self.db.profile.show.color.class = t
								end,
							}
						},
					},
					compact = {
						name = L["Compact mode"], type = "toggle",
						desc = L["Turns compact friends list on and off."],
						get = function() return self.db.profile.show.compact end,
						set = function(t)
							self.db.profile.show.compact = t
						end,
					},
					clevels = {
						name = L["Compact mode levels"], type = "toggle",
						desc = L["Turns display of levels in compact mode on and off."],
						get = function() return self.db.profile.show.clevels end,
						set = function(t)
							self.db.profile.show.clevels = t
						end,
					},
					intooltip = {
						name = L["Note in player tooltip"], type = "toggle",
						desc = L["Turns display of player notes in tooltips on and off."],
						get = function() return self.db.profile.show.intooltip end,
						set = function(t)
							self.db.profile.show.intooltip = t
						end,
					},
					onlogon = {
						name = L["Note on logon"], type = "toggle",
						desc = L["Turns display of player notes on logon on and off."],
						get = function() return self.db.profile.show.onlogon end,
						set = function(t)
							self.db.profile.show.onlogon = t
						end,
					},
					onwho = {
						name = L["Note on /who"], type = "toggle",
						desc = L["Turns display of player notes when you /who them on and off."],
						get = function() return self.db.profile.show.onwho end,
						set = function(t)
							self.db.profile.show.onwho = t
						end,
					},
				},
			},
		},
	})

	-- We will need many buttons.
	self.friendbuttons, self.ignorebuttons, self.guildbuttons = {}, {}, {}
	for i=1, FRIENDS_TO_DISPLAY, 1 do
		table.insert(self.friendbuttons, self:CreateButton("AuldLangSyne_FriendNote"..i, getglobal("FriendsFrameFriendButton"..i), "RIGHT", "RIGHT", -5, 0))
		self.friendbuttons[i].type = "friend"
	end
	for i=1, IGNORES_TO_DISPLAY, 1 do
		table.insert(self.ignorebuttons, self:CreateButton("AuldLangSyne_IgnoreNote"..i, getglobal("FriendsFrameIgnoreButton"..i), "RIGHT", "RIGHT", -5, 0))
		self.ignorebuttons[i].type = "ignore"
	end
	for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
		table.insert(self.guildbuttons, self:CreateButton("AuldLangSyne_GuildNote"..i, getglobal("GuildFrameButton"..i), "RIGHT", "RIGHT", 0, 0))
		self.guildbuttons[i].type = "guild"
	end

	self.colors_sex = {
		[MALE] = "90b0f0",
		[FEMALE] = "f090c4",
	}

	self.editFrame = self:CreateEditFrame()

	if (not self.db.realm.version) or self.db.realm.version ~= self.version then
		--DB upgrade!
		self:Print(L["Detected an older database version.  Upgrading!"])
		local v
		if self.db.realm.version then
			-- We rely on the version being of the form x.x.svn_rev
			_,_,v = string.find(self.db.realm.version, "%d+\.%d+\.(%d+)")
			v = tonumber(v)
		end

		if (not v) or v <= 4556 then
			--Strip out the location information from the DB.
			for name,info in pairs(self.db.realm.chars) do
				-- We stopped recording the area.
				info.area = nil
			end
		end

		if (not v) or v <= 4807 then
			for name,info in pairs(self.db.realm.chars) do
				-- We're now storing the output of UnitPVPRank in .rank instead of UnitPVPName in .pvp.  Clear out the old field.
				info.pvp = nil
			end
		end
	end

	self.db.realm.version = self.version

	--Stolen from AceDB.
	local _,race = UnitRace("player")
	if race == "Orc" or race == "Scourge" or race == "Troll" or race == "Tauren" or race == "BloodElf" then
		self.faction = "0"
	else
		self.faction = "1"
	end

	self.undo = {}
end

function AuldLangSyne:OnEnable()
	self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateFriends")
	self:SecureHook("FriendsList_Update", "ShowFriends")
	self:SecureHook("IgnoreList_Update", "ShowIgnore")
	self:SecureHook("GuildStatus_Update", "ShowGuild")
	self:SecureHook(GameTooltip, "SetUnit", "ScanTooltip")
	self:Hook("GetWhoInfo", "ScanWho", true)
	self:SecureHook("SendWho", function(filter) self:ListenFor("Who") end)
	--self:Hook("SetWhoToUI", function(state) self:Print("SetWhoToUI", state); self.hooks["SetWhoToUI"](state) end)
end

function AuldLangSyne:CHAT_MSG_SYSTEM(message)
	self:Debug("CHAT_MSG_SYSTEM", message)
	if self.listeningForLogin then
		local name = deformat(message, ERR_FRIEND_ONLINE_SS)
		if name and self.db.realm.chars[name] and self.db.realm.chars[name].note then
			--We schedule an event, so we can print the note _after_ the "[name] has come online" message.
			self:ScheduleEvent(self.name.."PrintNote", function()
					self:Print(name .. ": " .. self.db.realm.chars[name].note)
				end, 0.1)
		end
	end
	if self.listeningForWho then
		--local name = deformat(message, WHO_LIST_GUILD_FORMAT) or deformat(message, WHO_LIST_FORMAT)
		local _, name, level, race, class, guild, location = deformat(message, WHO_LIST_GUILD_FORMAT)
		if not name then _, name, level, race, class, location = deformat(message, WHO_LIST_GUILD_FORMAT) end
		if name and self.db.realm.chars[name] ~= nil then
			self:Debug("We know", name)
			if guild then self.db.realm.chars[name].guild = guild end
			self.db.realm.chars[name].level = level
			self.db.realm.chars[name].race = race
			self.db.realm.chars[name].class = class
			self.db.realm.chars[name].updated = time()
			if self.db.profile.show.onwho and self.db.realm.chars[name].note then
				self:ScheduleEvent(self.name.."PrintNote", function()
						self:Print(name .. ": " .. self.db.realm.chars[name].note)
					end, 0.1)
			end
		end
	end
end

function AuldLangSyne:ListenFor(which, stop)
	if stop then
		self["listeningFor"..which] = false
		if self:IsEventRegistered("CHAT_MSG_SYSTEM") then
			self:UnregisterEvent("CHAT_MSG_SYSTEM")
		end
	else
		self["listeningFor"..which] = true
		self:RegisterEvent("CHAT_MSG_SYSTEM")
		self:ScheduleEvent(self.ListenFor, 1, self, which, true)
	end
end

function AuldLangSyne:ShowFriends()
	self:Debug("ShowFriends")
	if self.db.profile.show.onlogon then
		--This might be a friend-has-signed-on update.  So:
		--(Note that this is why we're not just using a bucket event or throttled event.)
		self:ListenFor("Login")
	end
	if FriendsFrame:IsVisible() then
		local friendOffset = FauxScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame);
		local numFriends = GetNumFriends();
		local n = FRIENDS_TO_DISPLAY

		if numFriends < FRIENDS_TO_DISPLAY then n = numFriends end

		for i=1, n, 1 do
			local name, level, class, area, connected, status = GetFriendInfo(i + friendOffset);

			-- They need a note button.
			self.friendbuttons[i].name = name
			if self.db.realm.chars[name] == nil or self.db.realm.chars[name].note == "" or self.db.realm.chars[name].note == nil then
				self.friendbuttons[i]:GetNormalTexture():SetVertexColor(0.5,0.5,0.5)
			else
				self.friendbuttons[i]:GetNormalTexture():SetVertexColor(1,1,1)
			end

			-- Do we know anything about them?
			if self.db.realm.chars[name] and self.db.realm.chars[name].level then
				self:Debug("Munging "..name)
				local nameLocationText = getglobal("FriendsFrameFriendButton"..(i).."ButtonTextNameLocation");
				local infoText = getglobal("FriendsFrameFriendButton"..(i).."ButtonTextInfo");

				local race = self.db.realm.chars[name].race and (self.db.realm.chars[name].race.." ") or ""
				local rank = (self.db.realm.chars[name].rank and self.db.realm.chars[name].rank ~= 0) and ((self.db.profile.show.pvpnum and ("[R".. tonumber(self.db.realm.chars[name].rank)-4 .."]") or self:GetRankName(self.db.realm.chars[name].rank, self.db.realm.chars[name].sex)).." ") or ""
				local lastseen = ""
				if not connected then
					level = self.db.realm.chars[name].level
					class = self.db.realm.chars[name].class
					lastseen = connected and nil or (self.db.realm.chars[name].updated and math.ceil((time() - self.db.realm.chars[name].updated)/86400))
					if connected and nil or self.db.realm.chars[name].updated then
						local currentTime = time()
						local minutes = math.ceil((currentTime - self.db.realm.chars[name].updated) / 60)
						if minutes > 59 then
							local hours = math.ceil((currentTime - self.db.realm.chars[name].updated) / 3600)
							if hours > 23 then
								local days = math.ceil((currentTime - self.db.realm.chars[name].updated) / 86400)
								lastseen = days..L[" day"]..((days > 1) and L["s"] or "")
							else
								lastseen = hours..L[" hour"]..((hours > 1) and L["s"] or "")
							end
						else
							lastseen = minutes..L[" minute"]..((minutes > 1) and L["s"] or "")
						end
					end
				end

				if self.db.profile.show.compact then
					-- Right now offline friends that have never been seen by the addon look out of place, for they are not getting munged.  Fix?
					local pvprank = self.db.realm.chars[name].rank
					if not pvprank then
						pvprank = "?"
					else
						pvprank = tonumber(pvprank)-4
					end
					local nlt = (connected and "" or "|cff999999")..(self.db.profile.show.color.class and ("|cff"..BC:GetHexColor(class)) or "")..name..(self.db.profile.show.color.class and "|r" or "")..((self.db.profile.show.color.name and self.db.realm.chars[name].sex) and "|r" or "")..(connected and "" or "|cff999999")..(self.db.profile.show.pvp and (" / R"..pvprank) or "")..(self.db.profile.show.clevels and (" / L"..self.db.realm.chars[name].level) or "")..((self.db.profile.show.guild and self.db.realm.chars[name].guild) and (" / "..self.db.realm.chars[name].guild) or "")..(connected and (" / "..area..((status ~= "") and " ("..status..")" or "")) or (lastseen and (" / "..lastseen)))
					local it = "|cff999999"..((self.db.realm.chars[name].note and (self.db.realm.chars[name].note ~= "")) and self.db.realm.chars[name].note or "")

					nameLocationText:SetText(nlt)
					infoText:SetText(it)
				else
					local nlt = ((self.db.profile.show.color.name and self.db.realm.chars[name].sex) and ("|cff"..self.colors_sex[self.db.realm.chars[name].sex]) or "")..(self.db.profile.show.pvp and rank or "")..name..((self.db.profile.show.color.name and self.db.realm.chars[name].sex) and "|r" or "")..(connected and "" or ("|cff999999 - "..lastseen..L[" ago"]))
					local it = race..(self.db.profile.show.color.class and ("|cff"..BC:GetHexColor(class)) or "")..class..(self.db.profile.show.color.class and "|r" or "")..(connected and "" or "|cff999999")..((self.db.profile.show.guild and self.db.realm.chars[name].guild) and (" <"..self.db.realm.chars[name].guild..">") or "")

					if connected then
						nameLocationText:SetText(format(FRIENDS_LIST_TEMPLATE, nlt, area, status))
					else
						nameLocationText:SetText(format(FRIENDS_LIST_OFFLINE_TEMPLATE, nlt))
					end
					infoText:SetText(format(FRIENDS_LEVEL_TEMPLATE, level, it))
				end
				-- Make sure we're not overflowing
				if nameLocationText:GetWidth() > 275 then
					nameLocationText:SetJustifyH("LEFT")
					nameLocationText:SetWidth(275)
					nameLocationText:SetHeight(14) -- If we don't set the height, the line wraps.
				end
				if infoText:GetWidth() > 275 then
					infoText:SetJustifyH("LEFT")
					infoText:SetWidth(275)
					infoText:SetHeight(14) -- If we don't set the height, the line wraps.
				end
			end
		end
	end
end

function AuldLangSyne:UpdateFriends()
	local numFriends = GetNumFriends()

	for i=1, numFriends do
		local name, level, class, area, connected, status = GetFriendInfo(i)
		self:Debug(name, level, class, area, connected, status)

		if connected then
			if self.db.realm.chars[name] == nil then self.db.realm.chars[name] = {} end
			self.db.realm.chars[name].level = level
			self.db.realm.chars[name].class = class
			self.db.realm.chars[name].updated = time()
		end
	end

	self:Debug("Friends: scanned")
end

function AuldLangSyne:ShowIgnore()
	if FriendsFrame:IsVisible() then
		local ignoreOffset = FauxScrollFrame_GetOffset(FriendsFrameIgnoreScrollFrame);
		for i=1, IGNORES_TO_DISPLAY, 1 do
			local ignoreIndex = i + ignoreOffset;
			local name = GetIgnoreName(ignoreIndex);
			self.ignorebuttons[i].name = name
			if self.db.realm.ignore[name] == nil or self.db.realm.ignore[name] == "" then
				self.ignorebuttons[i]:GetNormalTexture():SetVertexColor(0.5,0.5,0.5)
			else
				self.ignorebuttons[i]:GetNormalTexture():SetVertexColor(1,1,1)
			end
		end
	end
end

function AuldLangSyne:ShowGuild()
	if FriendsFrame:IsVisible() then
		local guildOffset = FauxScrollFrame_GetOffset(GuildListScrollFrame);
		for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
			local guildIndex = i + guildOffset;
			local name = GetGuildRosterInfo(guildIndex);
			self.guildbuttons[i].name = name
			if self.db.realm.guild[name] == nil or self.db.realm.guild[name] == "" then
				self.guildbuttons[i]:GetNormalTexture():SetVertexColor(0.5,0.5,0.5)
			else
				self.guildbuttons[i]:GetNormalTexture():SetVertexColor(1,1,1)
			end
		end
	end
end

function AuldLangSyne:ScanTooltip(object, unitid)
	self:Debug(unitid)

	if UnitIsPlayer(unitid) then
		local name = UnitName(unitid)
		if self.db.realm.chars[name] ~= nil then
			self:Debug("We know",name)
			self.db.realm.chars[name].rank = UnitPVPRank(unitid)
			self.db.realm.chars[name].race = UnitRace(unitid)

			local sex = UnitSex(unitid)
			-- 1: neuter/unknown, 2: male, 3: female
			-- We're not storing the output of UnitSex directly, for Blizzard has been known to change it.
			if sex == 2 then
				self.db.realm.chars[name].sex = MALE
			elseif sex == 3 then
				self.db.realm.chars[name].sex = FEMALE
			end

			local guildName, guildRankName, guildRankIndex = GetGuildInfo(unitid)
			self.db.realm.chars[name].guild = guildName
			self.db.realm.chars[name].guildRank = guildRankName

			self.db.realm.chars[name].updated = time()

			if FriendsFrame:IsVisible() and FriendsFrame.selectedTab == 1 then
				FriendsList_Update()
			end
		end
		if self.db.profile.show.intooltip and self:CanMessWithGameTooltip() then
			if self.db.realm.chars[name] and self.db.realm.chars[name].note then
				self:AddToGameTooltipAndFixHeight(L["Friend: "] .. self.db.realm.chars[name].note, 0.5, 0.5, 0.5)
			end
			if self.db.realm.guild[name] then
				self:AddToGameTooltipAndFixHeight(L["Guild: "] .. self.db.realm.guild[name], 0.5, 0.5, 0.5)
			end
			if self.db.realm.ignore[name] then
				self:AddToGameTooltipAndFixHeight(L["Ignore: "] .. self.db.realm.ignore[name], 0.5, 0.5, 0.5)
			end
		end
	end
end

function AuldLangSyne:ScanWho(i)
	self:Debug("ScanWho", i)
	local name, guild, level, race, class, zone, group = self.hooks["GetWhoInfo"](i)
	self:Debug(name, guild, level, race, class, zone, group)
	if self.db.realm.chars[name] ~= nil then
		self:Debug("We know", name)
		if guild ~= "" then self.db.realm.chars[name].guild = guild end
		self.db.realm.chars[name].level = level
		self.db.realm.chars[name].race = race
		self.db.realm.chars[name].class = class
		self.db.realm.chars[name].updated = time()

		if FriendsFrame:IsVisible() and FriendsFrame.selectedTab == 1 then
			FriendsList_Update()
		end
	end

	return name, guild, level, race, class, zone, group
end

function AuldLangSyne:CanMessWithGameTooltip()
	if GameTooltip and getglobal("GameTooltipTextLeft1"):IsVisible() and getglobal("GameTooltipTextLeft1"):GetText() ~= nil then
		return true
	else
		return false
	end
end

function AuldLangSyne:AddToGameTooltipAndFixHeight(text, r, g, b)
	GameTooltip:AddLine(text, r, g, b)

	-- Fix up the width of the tooltip
	length = getglobal(GameTooltip:GetName() .. "TextLeft" .. GameTooltip:NumLines()):GetStringWidth()
	-- Space for right-border:
	length = length + 22

	GameTooltip:SetHeight(GameTooltip:GetHeight() + 14)
	if length > GameTooltip:GetWidth() then
		GameTooltip:SetWidth(length)
	end
end

function AuldLangSyne:DumpData()
	self:Debug("Printing friends")
	for name, info in pairs(self.db.realm.chars) do
		self:Print((name or info.pvp) .. " [" .. (info.level or "?") .. "]" .. (info.guild and (" <"..info.guild..">") or "") .. ", a " .. (info.race and (info.race.." ") or "") .. (info.class or UNKNOWN) .. " last seen on " .. date(nil, info.updated))
	end
end

function AuldLangSyne:ClearData()
	self.db.realm.chars = {}
end

function AuldLangSyne:CTImport()
	--CTPlayerNotes is popular.  Ergo, we must steal its data.
	--NOTE: This will overwrite any existing notes.  This might be bad.

	if CT_PlayerNotes then
		--We can't scan over the CT_PlayerNotes, as that seems to include listings for all realms.  Durnit.
		for i=1, GetNumFriends() do
			local name, level, class, area, connected, status = GetFriendInfo(i)
			if CT_PlayerNotes[name] then
				if not self.db.realm.chars[name] then self.db.realm.chars[name] = {} end
				self.db.realm.chars[name].note = CT_PlayerNotes[name]
			end
		end
	end
	if CT_GuildNotes then
		for i=1, GetNumGuildMembers(true) do
			local name = GetGuildRosterInfo(i)
			if CT_GuildNotes[name] then
				self.db.realm.guild[name] = CT_GuildNotes[name]
			end
		end
	end
	if CT_IgnoreNotes then
		for i=1, GetNumIgnores() do
			local name = GetIgnoreName(i)
			if CT_IgnoreNotes[name] then
				self.db.realm.ignore[name] = CT_IgnoreNotes[name]
			end
		end
	end
end

function AuldLangSyne:CreateButton(name, parent, point, relativePoint, x, y)
	local button = CreateFrame("Button", name, parent)
	button:SetWidth(16); button:SetHeight(16)

	--Left edge aligned to right edge of parent.
	button:SetPoint(point, parent, relativePoint, x, y)

	button:SetNormalTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
	button:SetDisabledTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")

	button:SetScript("OnClick", function() self:ButtonClick(this) end)
	button:SetScript("OnEnter", function() self:ButtonEnter(this) end)
	button:SetScript("OnLeave", function() self:ButtonLeave(this) end)

	self:Debug("Created "..name.." (parent: "..parent:GetName()..")")
	return button
end

function AuldLangSyne:ButtonClick(button)
	self:Debug(button:GetName(), button.name)
	if self.editFrame:IsVisible() and self.editFrame.name == button.name then
		self.editFrame.name = ""
		self.editFrame.type = ""
		self.editFrame:Hide()
	else
		self.editFrame.name = button.name
		self.editFrame.type = button.type

		local note
		if button.type == "friend" then
			note = self.db.realm.chars[button.name] and self.db.realm.chars[button.name].note or ""
		elseif button.type == "ignore" then
			note = self.db.realm.ignore[button.name] or ""
		elseif button.type == "guild" then
			note = self.db.realm.guild[button.name] or ""
		end
		self.editFrame.editbox:SetText(note)
		self.editFrame.edit_text:SetText(format(L["Editing note for %s"],button.name))
		self.editFrame:Show()
	end
end

function AuldLangSyne:ButtonEnter(button)
	self:Debug(button.name, button.type)
	local note
	if button.type == "friend" then
		note = self.db.realm.chars[button.name] and self.db.realm.chars[button.name].note or ""
	elseif button.type == "ignore" then
		note = self.db.realm.ignore[button.name] or ""
	elseif button.type == "guild" then
		note = self.db.realm.guild[button.name] or ""
	end
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L["Click to edit"], 1, 0.7, 0)
	GameTooltip:AddLine(note, 0.6, 0.6, 0.6)
	GameTooltip:Show()
end

function AuldLangSyne:ButtonLeave(button)
	GameTooltip:Hide()
end

function AuldLangSyne:CreateEditFrame()
	local f = CreateFrame("Frame", "AuldLangSyne_Edit", UIParent)
	f:SetFrameStrata("DIALOG")
	f:SetToplevel(true)
	f:SetWidth(300)
	f:SetHeight(100)
	f:SetPoint("CENTER", UIParent) --Center it on the screen.
	f:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
		tile=true, tileSize=32, edgeSize=32, insets={left=11, right=12, top=12, bottom=11}})

	local h = f:CreateTexture()
	h:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	h:SetWidth(256)
	h:SetHeight(64)
	h:SetPoint("TOP", f, "TOP", 0, 12)

	local h_text = f:CreateFontString("AuldLangSyne_EditHeaderText", nil, "GameFontNormal")
	h_text:SetPoint("TOP", h, "TOP", 0, -14)
	h_text:SetText(L["Edit note"])

	local edit_text = f:CreateFontString("AuldLangSyne_EditDescText", nil, "GameFontNormal")
	edit_text:SetPoint("CENTER", f, "CENTER", 0, 20)
	--edit_text:SetText(

	--Somewhere to type.
	local edit = CreateFrame("EditBox", nil, f)
	edit:SetFontObject(ChatFontNormal)
	edit:SetHistoryLines(1); edit:SetMaxLetters(250); edit:SetTextInsets(10,10,0,0)
	edit:SetWidth(250); edit:SetHeight(32)
	edit:SetPoint("CENTER", f)
	edit:SetScript("OnShow", function() this:SetFocus() end)
	edit:SetScript("OnEnterPressed", function() self:SaveNote(self.editFrame.name, this:GetText(), self.editFrame.type) end)
	edit:SetScript("OnEscapePressed", function() this:SetText(""); this:GetParent():Hide(); end)

	--Textures for the editbox border.  ("BACKGROUND"?)
	local edit_l, edit_r, edit_b = edit:CreateTexture(), edit:CreateTexture(), edit:CreateTexture()
	edit_l:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left"); edit_l:SetWidth(65); edit_l:SetHeight(32); edit_l:SetPoint("LEFT", edit, nil, -10); edit_l:SetTexCoord(0,0.2539,0,1);
	edit_r:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right"); edit_r:SetWidth(25); edit_r:SetHeight(32); edit_r:SetPoint("RIGHT", edit, nil, 10); edit_r:SetTexCoord(0.9,1,0,1);
	edit_b:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left"); edit_b:SetWidth(5); edit_b:SetHeight(32); edit_b:SetPoint("LEFT", edit_l, "RIGHT"); edit_b:SetPoint("RIGHT", edit_r, "LEFT"); edit_b:SetTexCoord(0.29296875,1,0,1);

	local b_accept = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
	b_accept:SetWidth(70); b_accept:SetHeight(21)
	b_accept:SetPoint("BOTTOM", f, "BOTTOM", -42, 12)
	b_accept:SetScript("OnClick", function() self:SaveNote(self.editFrame.name, this:GetParent().editbox:GetText(), self.editFrame.type) end)
	b_accept:SetText(L["Confirm"])

	local b_cancel = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
	b_cancel:SetWidth(70); b_cancel:SetHeight(21)
	b_cancel:SetPoint("BOTTOM", f, "BOTTOM", 42, 12)
	b_cancel:SetScript("OnClick", function() this:GetParent().editbox:SetText(""); this:GetParent():Hide(); end)
	b_cancel:SetText(L["Cancel"])

	f.editbox = edit
	f.edit_text = edit_text
	f:Hide()
	return f
end

function AuldLangSyne:SaveNote(name, note, ntype)
	--This puts a note into the db, and closes the edit frame if it"s open.
	if note == "" then note = nil end
	if ntype == "friend" then
		if not self.db.realm.chars[name] then self.db.realm.chars[name] = {} end
		self.db.realm.chars[name].note = note
		FriendsList_Update()
	elseif ntype == "ignore" then
		self.db.realm.ignore[name] = note
		IgnoreList_Update()
	elseif ntype == "guild" then
		self.db.realm.guild[name] = note
		GuildStatus_Update()
	end

	if self.editFrame:IsVisible() then
		self.editFrame.editbox:SetText("")
		self.editFrame:Hide()
	end
end

function AuldLangSyne:SaveFriends(slotnum)
	local slot
	if slotnum == "undo" then
		self.undo = {}
		slot = self.undo
	else
		self.db.char.friends[slotnum] = {}
		slot = self.db.char.friends[slotnum]
	end
	for i=1, GetNumFriends() do
		local name, level, class, area, connected, status = GetFriendInfo(i)
		table.insert(slot, name)
	end
	self:Print(format(L["Backed up %d friends to slot %d"], GetNumFriends(),slotnum))
end

function AuldLangSyne:LoadFriends(slotnum)
	local slot
	if slotnum == "undo" then
		slot = self.undo
	else
		slot = self.db.char.friends[slotnum]
	end
	if table.getn(slot) > 0 then
		for i=1, GetNumFriends() do
			RemoveFriend(i)
		end
		for _,name in pairs(slot) do
			AddFriend(name)
		end
	else
		self:Print(L["This slot is currently empty."])
	end
end

function AuldLangSyne:GetRankName(rank, sex)
	--"rank" should be the number of the PVP rank (starts at 5, goes to 19).
	--"sex" should be either MALE or FEMALE.
	return getglobal("PVP_RANK_"..rank.."_"..self.faction..((sex == FEMALE) and "_FEMALE" or ""))
end
