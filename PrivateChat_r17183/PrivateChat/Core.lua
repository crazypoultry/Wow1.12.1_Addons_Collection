
-------------------------------------------------------------------------------
-- Locals
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("PrivateChat")
local tea = AceLibrary("TEA-1.0")
local md5 = AceLibrary("MD5-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

local _G = getfenv(0)

local PROTOCOL_VERSION = 1
local DATABASE_VERSION = 1

-------------------------------------------------------------------------------
-- Localization
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["<name>"] = true,
	["<no target>"] = true,
	["Channels"] = true,
	["Configure"] = true,
	["Create Channel"] = true,
	["Creates virtual encrypted chat channel."] = true,
	["Opens configuration menu."] = true,
	["Virtual encrypted chat channel settings."] = true,
	["Remove"] = true,
	["Removes virtual encrypted chat channel."] = true,
	["Set Key"] = true,
	["Sets new channel encryption key."] = true,
	["<key>"] = true,
	["Slash Commands"] = true,
	["Slash command list for accessing virtual channel."] = true,
	["Add"] = true,
	["Adds new slash command handler."] = true,
	["<slash>"] = true,
	["Removes slash command %s handler."] = true,
	["Sticky"] = true,
	["Toggles virtual channel stickiness."] = true,
	["Color"] = true,
	["Sets chat channel color."] = true,
} end)

-------------------------------------------------------------------------------
-- Main
-------------------------------------------------------------------------------

PrivateChat = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "AceComm-2.0")

PrivateChat.defaults = {
	channels = {},
}

PrivateChat.options = {
	type = 'group',
	args = {
		config = {
			type = "execute",
			name = L["Configure"],
			desc = L["Opens configuration menu."],
			func = function() dewdrop:Open(UIParent, 'children', function() dewdrop:FeedAceOptionsTable(PrivateChat.options) end, 'cursorX', true, 'cursorY', true) end
		},
		channels = {
			type = "group",
			name = L["Channels"],
			desc = L["Virtual encrypted chat channel settings."],
			args = {
				create = {
					type = "text",
					name = L["Create Channel"],
					desc = L["Creates virtual encrypted chat channel."],
					usage = L["<name>"],
					get = false,
					set = function(v) PrivateChat:CreateChannel(v) PrivateChat:RebuildMenu() dewdrop:Refresh(2) end,
					validate = function(v) return PrivateChat:ValidateChannelName(v) end,
					order = 1,
					persistant = 1,
				},
				spacer = {
					type ="header",
					hidden = function() return not PrivateChat:HasChannels() end,
					order = 2,
					persistant = 1,
				},
				channelsHeader = {
					type ="header",
					name = L["Channels"],
					hidden = function() return not PrivateChat:HasChannels() end,
					order = 3,
					persistant = 1,
				},
			},
		},
	},
}

PrivateChat.revision = tonumber(string.sub("$Revision: 17183 $", 12, -3))
PrivateChat:RegisterDB("PrivateChatDB", "PrivateChatDBPC")
PrivateChat:RegisterDefaults("profile", PrivateChat.defaults)
PrivateChat:SetCommPrefix("PrivateChat" .. PROTOCOL_VERSION)
PrivateChat:RegisterChatCommand( { "/pc", "/PrivateChat" }, PrivateChat.options)

function PrivateChat:OnInitialize()
	self.version = self.version .. " |cffff8888r".. self.revision .."|r" 

	if not self.db.profile.version or self.db.profile.version < DATABASE_VERSION then
		self.db.profile.channels = {}
		self.db.profile.version = DATABASE_VERSION
	end

	self.registered = {}
	self:RebuildMenu()
end

function PrivateChat:OnEnable()
	self:Hook("SendChatMessage")
	self:SecureHook("FCF_SetChatTypeColor")
	self:SecureHook("FCF_CancelFontColorSettings")
	self:SecureHook("FCFMessageTypeDropDown_OnClick")

	self:RegisterComm("PrivateChat" .. PROTOCOL_VERSION, "GUILD")

	for id in pairs(self.db.profile.channels) do
		self:RegisterChannel(id)
	end
end

function PrivateChat:OnDisable()
	for id in pairs(self.db.profile.channels) do
		self:UnregisterChannel(id)
	end
end

-------------------------------------------------------------------------------
-- Communication
-------------------------------------------------------------------------------

function PrivateChat:OnCommReceive(prefix, sender, distribution, messageType, id, cypher)
	if messageType == "MSG" then
		if self.registered[id] and self.db.profile.channels[id] then
			self:RiseChatEvent(id, tea:Decrypt(cypher, self.db.profile.channels[id].key), sender, self.db.profile.channels[id].name)
		end
	end
end

-------------------------------------------------------------------------------
-- Hooks
-------------------------------------------------------------------------------

function PrivateChat:SendChatMessage(text, id, language, destination)
	if self.registered[id] then
		text = string.gsub(text, "%%t", UnitName("target") or L["<no target>"])

		self:RiseChatEvent(id, text, UnitName("player"), self.db.profile.channels[id].name)

		self:SendCommMessage("GUILD", "MSG", id, tea:Encrypt(text, self.db.profile.channels[id].key))

		return
	end

	self.hooks.SendChatMessage(text, id, language, destination)
end

function PrivateChat:FCF_SetChatTypeColor()
	if self.registered[UIDROPDOWNMENU_MENU_VALUE] and self.db.profile.channels[UIDROPDOWNMENU_MENU_VALUE] then
		local r, g, b = ColorPickerFrame:GetColorRGB()

		self.db.profile.channels[UIDROPDOWNMENU_MENU_VALUE].color = { r = r, g = g, b = b }

		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].r = r
		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].g = g
		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].b = b
	end
end

function PrivateChat:FCF_CancelFontColorSettings(prev)
	if prev.r and self.registered[UIDROPDOWNMENU_MENU_VALUE] and self.db.profile.channels[UIDROPDOWNMENU_MENU_VALUE] then
		self.db.profile.channels[UIDROPDOWNMENU_MENU_VALUE].color = { r = prev.r, g = prev.g, b = prev.b }

		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].r = prev.r
		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].g = prev.g
		ChatTypeInfo[UIDROPDOWNMENU_MENU_VALUE].b = prev.b
	end
end

function PrivateChat:FCFMessageTypeDropDown_OnClick()
	if self.registered[this.value] and self.db.profile.channels[this.value] then
		local f = FCF_GetCurrentChatFrame():GetName()

		if UIDropDownMenuButton_GetChecked() then
			for k, v in self.db.profile.channels[this.value].frames do
				if v == f then
					self.db.profile.channels[this.value].frames[k] = nil
					break
				end
			end
		else
			table.insert(self.db.profile.channels[this.value].frames, f)
		end
	end
end

-------------------------------------------------------------------------------
-- Chat Internals
-------------------------------------------------------------------------------

function PrivateChat:RegisterChannel(id)
	if not self.registered[id] then
		local channel = self.db.profile.channels[id]

		_G["CHAT_MSG_" .. id] = channel.name
		_G["CHAT_" .. id .. "_SEND"] = channel.name .. ": "
		_G["CHAT_" .. id .. "_GET"] = "%s: "

		local i = 1
		for _, slash in pairs(channel.slashes) do
			_G["SLASH_" .. id .. i] = slash
			i = i + 1
		end

		ChatTypeInfo[id] = { sticky = channel.sticky, r = channel.color.r, g = channel.color.g, b = channel.color.b }
		ChatTypeGroup[id] = { "CHAT_MSG_" .. id }

		table.insert(ChannelMenuChatTypeGroups, id)

		for _, f in ipairs(self.db.profile.channels[id].frames) do
			table.insert(_G[f].messageTypeList, id)
		end

		self.registered[id] = 1
	end
end

function PrivateChat:UnregisterChannel(id)
	if self.registered[id] then
		local channel = self.db.profile.channels[id]

		_G["CHAT_MSG_" .. id] = nil
		_G["CHAT_" .. id .. "_SEND"] = nil
		_G["CHAT_" .. id .. "_GET"] = nil

		local i = 1
		while _G["SLASH_" .. id .. i] do
			_G["SLASH_" .. id .. i] = nil
			i = i + 1
		end

		ChatTypeInfo[id] = nil
		ChatTypeGroup[id] = nil

		for k, v in pairs(ChannelMenuChatTypeGroups) do
			if v == id then
				ChannelMenuChatTypeGroups[k] = nil
				break
			end
		end

		for i = 1, NUM_CHAT_WINDOWS, 1 do
			for k, v in pairs(_G["ChatFrame" .. i].messageTypeList) do
				if (v == id) then
					_G["ChatFrame" .. i].messageTypeList[k] = nil
					break
				end
			end
		end

		if ChatFrameEditBox.chatType == id then
			ChatFrameEditBox.chatType = "SAY"
			ChatFrameEditBox.stickyType = "SAY"
		end

		self.registered[id] = nil
	end
end

function PrivateChat:RefreshColor(id)
	if self.registered[id] then
		local channel = self.db.profile.channels[id]

		ChatTypeInfo[id].r = channel.color.r
		ChatTypeInfo[id].g = channel.color.g
		ChatTypeInfo[id].b = channel.color.b
	end
end

function PrivateChat:RefreshStickiness(id)
	if self.registered[id] then
		local channel = self.db.profile.channels[id]

		ChatTypeInfo[id].sticky = channel.sticky

		if channel.sticky ~= 1 and ChatFrameEditBox.chatType == id then
			ChatFrameEditBox.chatType = "SAY"
			ChatFrameEditBox.stickyType = "SAY"
		end
	end
end

function PrivateChat:RefreshSlashes(id)
	if self.registered[id] then
		local channel = self.db.profile.channels[id]

		local i = 1
		while _G["SLASH_" .. id .. i] do
			_G["SLASH_" .. id .. i] = nil
			i = i + 1
		end

		local i = 1
		for _, slash in pairs(channel.slashes) do
			_G["SLASH_" .. id .. i] = slash
			i = i + 1
		end
	end
end

function PrivateChat:RiseChatEvent(id, message, sender, channel)
	local t_event, t_this, t_arg1, t_arg2, t_arg3, t_arg4, t_arg5, t_arg6 = event, this, arg1, arg2, arg3, arg4, arg5, arg6

	event = "CHAT_MSG_" .. id
	arg1, arg2, arg3, arg4, arg5, arg6 = message, sender, "", channel, "", ""

	for i = 1, NUM_CHAT_WINDOWS, 1 do
		for _, v in pairs(_G["ChatFrame" .. i].messageTypeList) do
			if (v == id) then
				this = _G["ChatFrame" .. i]
				ChatFrame_OnEvent(event)
			end
		end
	end

	event, this, arg1, arg2, arg3, arg4, arg5, arg6 = t_event, t_this, t_arg1, t_arg2, t_arg3, t_arg4, t_arg5, t_arg6
end

-------------------------------------------------------------------------------
-- Channels
-------------------------------------------------------------------------------

function PrivateChat:ValidateChannelName(name)
	if not string.find(name, "^[^%s+].*$") then
		return false
	end

	for _, channel in pairs(self.db.profile.channels) do
		if string.lower(channel.name) == string.lower(name) then
			return false
		end
	end

	return true
end

function PrivateChat:ValidateSlashCommand(slash)
	if not string.find(slash, "^/%w+$") then
		return false
	end

	for k, v in pairs(_G) do
		if string.sub(k, 1, 6) == "SLASH_" and v == slash then
			return false
		end
	end

	return true
end

function PrivateChat:HasChannels()
	for _ in pairs(self.db.profile.channels) do
		return true
	end

	return false
end

function PrivateChat:GenerateChannelID(name)
	 local t = md5:MD5AsTable(string.lower(name))

	 return string.format("%08x", bit.bxor(t[1], t[2], t[3], t[4]))
end

function PrivateChat:CreateChannel(name)
	local id = self:GenerateChannelID(name)

	self.db.profile.channels[id] = {
		id = id,
		name = name,
		slashes = {
		},
		key = tea:GenerateKey(""),
		color = {
			r = 0.45,
			g = 0.90,
			b = 1.00,
		},
		sticky = 1,
		frames = {
			"ChatFrame1"
		},
	}

	self:RegisterChannel(id)
end

function PrivateChat:RemoveChannel(id)
	self:UnregisterChannel(id)

	self.db.profile.channels[id] = nil
end

function PrivateChat:AddSlashCommand(id, slash)
	table.insert(self.db.profile.channels[id].slashes, slash)

	self:RefreshSlashes(id)
end

function PrivateChat:DeleteSlashCommand(id, slash)
	for i, s in ipairs(self.db.profile.channels[id].slashes) do
		if slash == s then
			table.remove(self.db.profile.channels[id].slashes, i)
			break
		end
	end

	self:RefreshSlashes(id)
end

function PrivateChat:SetKey(id, key)
	self.db.profile.channels[id].key = tea:GenerateKey(key)
end

function PrivateChat:RebuildMenu()
	local args = self.options.args.channels.args

	for k, v in pairs(args) do
		if not v.persistant then
			args[k] = nil
		end
	end

	for id, channel in pairs(self.db.profile.channels) do
		local id, channel = id, channel
		local n = string.gsub(channel.name, "[^%w]", "")

		args[n] = {
			type = "group",
			name = channel.name,
			desc = L["Virtual encrypted chat channel settings."],
			args = {
				nameHeader = {
					type = "header",
					name = channel.name,
					order = 1,
				},
				sticky = {
					type = "toggle",
					name = L["Sticky"],
					desc = L["Toggles virtual channel stickiness."],
					get = function() return channel.sticky == 1 end,
					set = function(v) channel.sticky = (v and 1 or nil) self:RefreshStickiness(id) end,
					order = 3,
				},
				color = {
					type = "color",
					name = L["Color"],
					desc = L["Sets chat channel color."],
					get = function() return channel.color.r, channel.color.g, channel.color.b end,
					set = function(r, g, b) channel.color = { r = r, g = g, b = b } self:RefreshColor(id) end,
					order = 4,
				},
				key = {
					type = "text",
					name = L["Set Key"],
					desc = L["Sets new channel encryption key."],
					usage = L["<key>"],
					get = false,
					set = function(v) self:SetKey(id, v) end,
					validate = function(v) return string.len(v) > 0 end,
					order = 4,
				},
				slash = {
					type = "group",
					name = L["Slash Commands"],
					desc = L["Slash command list for accessing virtual channel."],
					order = 5,
					args = {
						add = {
							type = "text",
							name = L["Add"],
							desc = L["Adds new slash command handler."],
							usage = L["<slash>"],
							get = false,
							set = function(v) self:AddSlashCommand(id, v) self:RebuildMenu() dewdrop:Refresh(3) end,
							validate = function(v) return self:ValidateSlashCommand(v) end,
							order = 1,
						},
						spacer = {
							type = "header",
							hidden = function() return table.getn(channel.slashes) == 0 end,
							order = 2,
						},
						removeHeader = {
							type = "header",
							name = L["Remove"],
							hidden = function() return table.getn(channel.slashes) == 0 end,
							order = 3,
						},
					},
				},
				remove = {
					type = "execute",
					name = L["Remove"],
					desc = L["Removes virtual encrypted chat channel."],
					func = function() self:RemoveChannel(id) dewdrop:Close(3) self:RebuildMenu() dewdrop:Refresh(2) end,
					order = 10,
				},
			},
		}

		for _, slash in ipairs(channel.slashes) do
			local slash = slash
			local s = string.gsub(slash, "[^%w]", "")

			args[n].args.slash.args[s] = {
				type = "execute",
				name = slash,
				desc = string.format(L["Removes slash command %s handler."], slash),
				func = function() self:DeleteSlashCommand(id, slash) self:RebuildMenu() dewdrop:Refresh(2) end,
			}
		end
	end
end
