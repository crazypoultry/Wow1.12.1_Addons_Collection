local L = AceLibrary("AceLocale-2.2"):new("vChat")

local _G = getfenv(0)
local defaultstickies = {}
local defaultstrings = {}
local shortstrings = {
	CHAT_GUILD_GET = "[G] %s:\32",
	CHAT_OFFICER_GET = "[O] %s:\32",
	CHAT_PARTY_GET = "[P] %s:\32",
	CHAT_RAID_GET = "[R] %s:\32",
	CHAT_RAID_LEADER_GET = "[RL] %s:\32",
	CHAT_BATTLEGROUND_GET = "[BG] %s:\32",
	CHAT_BATTLEGROUND_LEADER_GET = "[BGL] %s:\32",
	CHAT_RAID_WARNING_GET = "[RW] %s:\32",
}
local altstrings = {
	CHAT_WHISPER_GET = L["From %s:\32"],
	CHAT_WHISPER_INFORM_GET = L["To %s:\32"],
			
	CHAT_FLAG_AFK = "[AFK] ",
	CHAT_FLAG_DND = "[DND] ",
	CHAT_FLAG_GM = "[GM] ",
}

local chatcmd = {
	type = "group",
	args = {
		sticky = {
			type = "group",
			name = L["Sticky Chat"],
			desc = L["Options to control sticky chat."],
			args = {
				whisper = {
					type = "toggle",
					name = L["Sticky Whispers"],
					desc = L["Toggles sticky whispers."],
					get = function() return vChat.db.profile.stickies.WHISPER end,
					set = function(v) vChat.db.profile.stickies.WHISPER = v end,
				},
				officer = {
					type = "toggle",
					name = L["Sticky Officer Chat"],
					desc = L["Toggles sticky officer chat."],
					get = function() return vChat.db.profile.stickies.OFFICER end,
					set = function(v) vChat.db.profile.stickies.OFFICER = v end,
				},
				channel = {
					type = "toggle",
					name = L["Sticky Channels"],
					desc = L["Toggles sticky channels."],
					get = function() return vChat.db.profile.stickies.CHANNEL end,
					set = function(v) vChat.db.profile.stickies.CHANNEL = v end,
				},
			},
		},
		editbox = {
			type = "group",
			name = L["Editbox"],
			desc = L["Editbox options."],
			args = {
				placement = {
					type = "toggle",
					name = L["Placement"],
					desc = L["Places the Editbox ontop of the ChatFrame."],
					get = function() return vChat.db.profile.editboxTop end,
					set = function(v)
									vChat.db.profile.editboxTop = v
									vChat:EditboxTop(v)
								end,
					map = {[false] = L["bottom"], [true] = L["top"]}
				},
			},
		},
		timestamps = {
			type = "group",
			name = L["Timestamps"],
			desc = L["Options for timestamps."],
			args = {
				ChatFrame1 = {
					type = "group",
					name = L["ChatFrame1"],
					desc = L["Timestamp options for ChatFrame1"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame1.stamps end,
							set = function(v) vChat.db.profile.ChatFrame1.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame1.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame1.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame1.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame1.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame1.stampColor.r, vChat.db.profile.ChatFrame1.stampColor.g, vChat.db.profile.ChatFrame1.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame1.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame1.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame1.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame1.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame1.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
				ChatFrame2 = {
					type = "group",
					name = L["ChatFrame2"],
					desc = L["Timestamp options for ChatFrame2"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame2.stamps end,
							set = function(v) vChat.db.profile.ChatFrame2.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame2.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame2.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame2.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame2.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame2.stampColor.r, vChat.db.profile.ChatFrame2.stampColor.g, vChat.db.profile.ChatFrame2.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame2.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame2.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame2.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame2.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame2.stampAlign = v end,
							map = {[false] = L["left"], [true] = L["right"]},
						},
					},
				},
				ChatFrame3 = {
					type = "group",
					name = L["ChatFrame3"],
					desc = L["Timestamp options for ChatFrame3"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame3.stamps end,
							set = function(v) vChat.db.profile.ChatFrame3.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame3.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame3.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame3.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame3.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame3.stampColor.r, vChat.db.profile.ChatFrame3.stampColor.g, vChat.db.profile.ChatFrame3.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame3.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame3.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame3.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame3.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame3.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
				ChatFrame4 = {
					type = "group",
					name = L["ChatFrame4"],
					desc = L["Timestamp options for ChatFrame4"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame4.stamps end,
							set = function(v) vChat.db.profile.ChatFrame4.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame4.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame4.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame4.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame4.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame4.stampColor.r, vChat.db.profile.ChatFrame4.stampColor.g, vChat.db.profile.ChatFrame4.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame4.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame4.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame4.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame4.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame4.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
				ChatFrame5 = {
					type = "group",
					name = L["ChatFrame5"],
					desc = L["Timestamp options for ChatFrame5"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame5.stamps end,
							set = function(v) vChat.db.profile.ChatFrame5.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame5.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame5.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame5.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame5.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame5.stampColor.r, vChat.db.profile.ChatFrame5.stampColor.g, vChat.db.profile.ChatFrame5.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame5.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame5.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame5.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame5.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame5.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
				ChatFrame6 = {
					type = "group",
					name = L["ChatFrame6"],
					desc = L["Timestamp options for ChatFrame6"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame6.stamps end,
							set = function(v) vChat.db.profile.ChatFrame6.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame6.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame6.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame6.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame6.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame6.stampColor.r, vChat.db.profile.ChatFrame6.stampColor.g, vChat.db.profile.ChatFrame6.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame6.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame6.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame6.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame6.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame6.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
				ChatFrame7 = {
					type = "group",
					name = L["ChatFrame7"],
					desc = L["Timestamp options for ChatFrame7"],
					args = {
						toggle = {
							type = "toggle",
							name = L["Toggle"],
							desc = L["Toggles timestamps."],
							get = function() return vChat.db.profile.ChatFrame7.stamps end,
							set = function(v) vChat.db.profile.ChatFrame7.stamps = v end,
						},
						format = {
							type = "text",
							name = L["Timestamp Format"],
							desc = L["Sets the timestamp format (default: [H:m:s])."],
							usage = L["<format>. H=hours(24h), h=hours(12h), m=minutes, s=seconds, p=am/pm"],
							get = function() return vChat:FormatStamp(vChat.db.profile.ChatFrame7.stampFormat, true) end,
							set = function(v) vChat.db.profile.ChatFrame7.stampFormat = vChat:FormatStamp(v) end,
						},
						usecolors = {
							type = "toggle",
							name = L["Colored Timestamps"],
							desc = L["Toggles colored timestamps."],
							get = function() return vChat.db.profile.ChatFrame7.stampUseColors end,
							set = function(v) vChat.db.profile.ChatFrame7.stampUseColors = v end,
						},
						color = {
							type = "color",
							name = L["Timestamp Color"],
							desc = L["Sets the timestamp color."],
							get = function() return vChat.db.profile.ChatFrame7.stampColor.r, vChat.db.profile.ChatFrame7.stampColor.g, vChat.db.profile.ChatFrame7.stampColor.b end,
							set = function(r, g, b)
											vChat.db.profile.ChatFrame7.stampColor = {["r"] = r, ["g"] = g, ["b"] = b}
											vChat.db.profile.ChatFrame7.stampColorStr = vChat:HexColor(vChat.db.profile.ChatFrame7.stampColor, "%s")
										end,
						},
						align = {
							type = "toggle",
							name = L["Alignment"],
							desc = L["Toggles the timestamp alignment (left/right)."],
							get = function() return vChat.db.profile.ChatFrame7.stampAlign end,
							set = function(v) vChat.db.profile.ChatFrame7.stampAlign = v end,
							map = {[false] = "left", [true] = "right"},
						},
					},
				},
			},
		},
		short = {
			type = "toggle",
			name = L["Short Channel Names"],
			desc = L["Shortens the channel names (e.g. [G] instead of [Guild])."],
			get = function() return vChat.db.profile.short end,
			set = function(v) 
			 				vChat.db.profile.short = v
			 				vChat:SetStrings(v and shortstrings or defaultstrings, shortstrings)
			 			end,
		},
		alternative = {
			type = "toggle",
			name = L["Alternative Strings"],
			desc = L["Toggles alternative strings (e.g. [AFK] instead of <AFK> or 'From: <name>' instead of '<name> whispers:')."],
			get = function() return vChat.db.profile.alt end,
			set = function(v)
							vChat.db.profile.alt = v
							vChat:SetStrings(v and altstrings or defaultstrings, altstrings)
						end,
		},
		hidebuttons = {
			type = "toggle",
			name = L["Hide Scroll Buttons"],
			desc = L["Hides the scroll buttons next to each ChatFrame."],
			get = function() return vChat.db.profile.hideButtons end,
			set = function(v)
							vChat.db.profile.hideButtons = v
							for i=1,7 do vChat:HideButtons("ChatFrame"..i, v) end
						end,
		},
		scrollspeed = {
			type = "range",
			name = L["Scroll Speed"],
			desc = L["The amount of lines to scroll with the mousewheel."],
			min = 1,
			max = 5,
			step = 1,
			get = function() return vChat.db.profile.scrollSpeed end,
			set = function(v) vChat.db.profile.scrollSpeed = v end,
		},
	},
}

vChat = AceLibrary("AceAddon-2.0"):new("AceHook-2.0", "AceDB-2.0", "AceConsole-2.0")

vChat:RegisterDB("vChatDB")
vChat:RegisterDefaults("profile", {
	ChatFrame1 = {
		stamps = true,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame2 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame3 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame4 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame5 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame6 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	ChatFrame7 = {
		stamps = false,
		stampFormat = "[%H:%M:%S]",
		stampColor = {
			["r"] = 1,
			["g"] = 1,
			["b"] = 1,
		},
		stampColorStr = "|cffffffff%s|r",
		stampUseColors = false,
		stampAlign = false,
	},
	stickies = {
		WHISPER = false,
		OFFICER = true,
		CHANNEL = true,
	},
	short = true,
	alt = true,
	hideButtons = true,
	scrollSpeed = 1,
	editboxTop = false,
} )

vChat:RegisterChatCommand({ "/vChat" }, chatcmd)

function vChat:OnEnable()
	defaultstrings = self:GetStrings( {shortstrings, altstrings} )
	defaultstickies = self:GetStickies(self.db.profile.stickies)
	if( self.db.profile.short ) then self:SetStrings(shortstrings) end
	if( self.db.profile.alt ) then self:SetStrings(altstrings) end
	self:SetStickies(self.db.profile.stickies)
	
	for i = 1,7 do
		local c = _G["ChatFrame"..i]
		self:Hook(c, "AddMessage")
		c:SetScript("OnMouseWheel", function() self:Scroll() end)
		c:EnableMouseWheel(true)
		self:HideButtons("ChatFrame"..i, self.db.profile.hideButtons)
	end
	
	ChatFrameEditBox:SetAltArrowKeyMode(false)
	if( self.db.profile.editboxTop ) then self:EditboxTop(self.db.profile.editboxTop) end
	
	SlashCmdList["VCHAT_TELLTARGET"] = function(m) self:TellTarget(m) end
	SLASH_VCHAT_TELLTARGET1 = "/tt"
end

function vChat:OnDisable()
	self:SetStrings(defaultstrings)
	self:SetStickies(defaultstickies)
	self:UnhookAll()

	for i = 1,7 do
		local c = _G["ChatFrame"..i]
		c:SetScript("OnMouseWheel", nil)
		c:EnableMouseWheel(false)
		self:HideButtons("ChatFrame"..i, false)
	end

	ChatFrameEditBox:SetAltArrowKeyMode(true)
	if( self.db.profile.editboxTop ) then self:EditboxTop(false) end

	SlashCmdList["VCHAT_TELLTARGET"] = nil
	SLASH_VCHAT_TELLTARGET1 = nil
end

function vChat:HexColor(t, s)
	return string.format("|cff%02x%02x%02x%s|r", t.r*255, t.g*255, t.b*255, s)
end

function vChat:GetStrings(t)
	local defaults = {}
	for j in pairs(t) do
		for k in pairs(t[j]) do
			defaults[k] = _G[k]
		end
	end
	return defaults
end

function vChat:SetStrings(t, c)
	for k in pairs(c or t) do
		_G[k] = t[k]
	end
end

function vChat:GetStickies(t)
	local defaults = {}
	for k in pairs(t) do
		if( ChatTypeInfo[k].sticky == 1 ) then
			defaults[k] = true
		end
	end
	return defaults
end

function vChat:SetStickies(t)
	for k in pairs(self.db.profile.stickies) do
		ChatTypeInfo[k].sticky = t[k] and 1 or 0
	end
end

function vChat:FormatStamp(stamp,r)
	local regx = {
		H = "%%H",
		h = "%%I",
		m = "%%M",
		s = "%%S",
		p = "%%p",
	}
	for k,v in pairs(regx) do
		stamp = string.gsub(stamp, r and v or k, r and k or v)
	end
	return stamp
end

function vChat:AddMessage(frame, text, r, g, b, id)
	local stamp = date(self.db.profile[frame:GetName()].stampFormat)
	if( self.db.profile[frame:GetName()].stampUseColors ) then stamp = string.format(self.db.profile[frame:GetName()].stampColorStr, stamp) end
	text = self.db.profile[frame:GetName()].stamps and string.format("%s %s", self.db.profile[frame:GetName()].stampAlign and text or stamp, self.db.profile[frame:GetName()].stampAlign and stamp or text) or text
	self.hooks[frame].AddMessage.orig(frame, text, r, g, b, id)
end

function vChat:Scroll()
	for i = 1, self.db.profile.scrollSpeed do
		if( arg1 > 0 ) then
			this:ScrollUp()
		elseif( arg1 < 0 ) then
			if( IsShiftKeyDown() ) then
				this:ScrollToBottom()
			else
				this:ScrollDown()
			end
		end
	end
end

function vChat:HideButtons(n, b)
	local tohide = { "UpButton", "DownButton", "BottomButton" }
	local f
	if( n == "ChatFrame1" and b ) then
		ChatFrameMenuButton:Hide()
	elseif( not b ) then
		ChatFrameMenuButton:Show()
	end
	for _,v in ipairs(tohide) do
		f = _G[n..v]
		f:SetScript("OnShow", b and function() this:Hide() end or nil)
		if( b ) then
			f:Hide()
		else
			f:Show()
		end
	end
end

function vChat:EditboxTop(b)
	ChatFrameEditBox:ClearAllPoints()
	if( b ) then
		ChatFrameEditBox:SetPoint("BOTTOMLEFT", ChatFrame1, "TOPLEFT", -6, 2)
		ChatFrameEditBox:SetPoint("BOTTOMRIGHT", ChatFrame1, "TOPRIGHT", 6, 2)
	else
		ChatFrameEditBox:SetPoint("TOPLEFT", ChatFrame1, "BOTTOMLEFT", -6, -2)
		ChatFrameEditBox:SetPoint("TOPRIGHT", ChatFrame1, "BOTTOMRIGHT", 6, -2)
	end
end

function vChat:TellTarget(m)
	if not( UnitExists("target") and UnitIsPlayer("target") and UnitFactionGroup("target") == UnitFactionGroup("player") ) then return end
	local n, r = UnitName("target")
	if r and r ~= GetRealmName() then n = n.."-"..r end
	SendChatMessage(m, "WHISPER", nil, n)
end
