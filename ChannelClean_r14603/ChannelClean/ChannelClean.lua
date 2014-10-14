--[[ $Id: ChannelClean.lua 14603 2006-10-21 07:11:36Z hshh $ ]]--
-- ACE2 init
local L = AceLibrary("AceLocale-2.2"):new("ChannelClean")
ChannelClean = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceEvent-2.0", "AceHook-2.1", "AceConsole-2.0")

function ChannelClean:OnInitialize()
	self.lastNotice = {}
	self.trigger_temp = {}
	self.speaker = {}
	self.lastClean = time()

	-- init saved variables
	self:RegisterDB("ChannelCleanDB")
	self:RegisterDefaults("profile", {
		bypassSelf = true,
		notice = false,
		rate = false,
		rateChannelOnly = true,
		rateSameMessageOnly = true,
		rateTime = 5,
		cleanInterval = 1800,
		noticeInterval = 30,
		player = {},
		message = {},
		trigger = {},
		trigger_mode = "session",
		monitor = {
			CHAT_MSG_CHANNEL = true,
			CHAT_MSG_SAY = true,
			CHAT_MSG_WHISPER = true,
			CHAT_MSG_YELL = true,
			CHAT_MSG_GUILD = false,
			CHAT_MSG_PARTY = false,
			CHAT_MSG_RAID = false,
			CHAT_MSG_SYSTEM = false,
			CHAT_MSG_BATTLEGROUND = false,
			CHAT_MSG_BATTLEGROUND_LEADER = false,
			CHAT_MSG_RAID_LEADER = false
		}
	})

	-- register console slash commands
	self:RegisterChatCommand(
		{ "/channelclean", "/chc" },
		{
			type = "group",
			args = {
				add = {
					order = 101,
					type = "group",
					name = "add",
					desc = L["Add a new rule set."],
					args = {
						message = {
							type = "text",
							name = "message",
							desc = L["Add a message block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:AddRule("message", c) end
						},
						player = {
							type = "text",
							name = "player",
							desc = L["Add a player block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:AddRule("player", c) end
						},
						trigger = {
							type = "text",
							name = "trigger",
							desc = L["Add a trigger block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:AddRule("trigger", c) end
						}
					}
				},
				del = {
					order = 110,
					type = "group",
					name = "del",
					desc = L["Delete a exist rule set."],
					args = {
						message = {
							type = "text",
							name = "message",
							desc = L["Delete a message block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:DeleteRule("message", c) end
						},
						player = {
							type = "text",
							name = "player",
							desc = L["Delete a player block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:DeleteRule("player", c) end
						},
						trigger = {
							type = "text",
							name = "trigger",
							desc = L["Delete a trigger block rule."],
							usage = "<block rule>",
							get = false,
							set = function(c) return self:DeleteRule("trigger", c) end
						}
					}
				},
				clear = {
					order = 120,
					type = "group",
					name = "clear",
					desc = L["Clear a group rule sets."],
					args = {
						message = {
							type = "execute",
							name = "message",
							desc = L["Clear message block rules."],
							func = function()
								self.db.profile.message={}
								self:Print(format(L["RuleClearedFormat"], L["RuleGroup_message"]))
							end
						},
						player = {
							type = "execute",
							name = "player",
							desc = L["Clear player block rules."],
							func = function()
								self.db.profile.player={}
								self:Print(format(L["RuleClearedFormat"], L["RuleGroup_player"]))
							end
						},
						trigger = {
							type = "execute",
							name = "trigger",
							desc = L["Clear trigger block rules."],
							func = function()
								self.db.profile.trigger={}
								self:Print(format(L["RuleClearedFormat"], L["RuleGroup_trigger"]))
							end
						},
						trigger_session = {
							type = "execute",
							name = "trigger_session",
							desc = L["Clear trigger blocked players."],
							func = function()
								self.trigger_temp = {}
								self:Print(format(L["RuleClearedFormat"], L["RuleGroup_trigger_session"]))
							end
						}
					}
				},
				list = {
					order = 130,
					type = "group",
					name = "list",
					desc = L["List a group rule sets."],
					args = {
						message = {
							type = "execute",
							name = "message",
							desc = L["List message block rules."],
							func = function()
								self:Print(format(L["ListFormat"], L["RuleGroup_message"]))
								for k,v in ipairs(self.db.profile.message) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
							end
						},
						player = {
							type = "execute",
							name = "player",
							desc = L["List player block rules."],
							func = function()
								self:Print(format(L["ListFormat"], L["RuleGroup_player"]))
								for k,v in ipairs(self.db.profile.player) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
							end
						},
						trigger = {
							type = "execute",
							name = "trigger",
							desc = L["List trigger block rules."],
							func = function()
								self:Print(format(L["ListFormat"], L["RuleGroup_trigger"]))
								for k,v in ipairs(self.db.profile.trigger) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
							end
						},
						trigger_session = {
							type = "execute",
							name = "trigger_session",
							desc = L["List trigger blocked players."],
							func = function()
								self:Print(format(L["ListFormat"], L["RuleGroup_trigger_session"]))
								for k,v in ipairs(self.trigger_temp) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
							end
						},
						all = {
							type = "execute",
							name = "all",
							desc = L["List all block rules."],
							func = function()
								self:Print(format(L["ListFormat"], L["RuleGroup_message"]))
								for k,v in ipairs(self.db.profile.message) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
								self:Print(format(L["ListFormat"], L["RuleGroup_player"]))
								for k,v in ipairs(self.db.profile.player) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
								self:Print(format(L["ListFormat"], L["RuleGroup_trigger"]))
								for k,v in ipairs(self.db.profile.trigger) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
								self:Print(format(L["ListFormat"], L["RuleGroup_trigger_session"]))
								for k,v in ipairs(self.trigger_temp) do
									self:Print(format(L["ListRulesFormat"], k ,v))
								end
							end
						}
					}
				},
				monitor = {
					order = 200,
					type = "group",
					name = "monitor",
					desc = L["Setting channel monitor lists."],
					args = {
						channel = {
							type = "toggle",
							name = "channel",
							desc = L["Toggle block chat channel messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_CHANNEL end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_CHANNEL = c end,
						},
						say = {
							type = "toggle",
							name = "say",
							desc = L["Toggle block say messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_SAY end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_SAY = c end,
						},
						whisper = {
							type = "toggle",
							name = "whisper",
							desc = L["Toggle block whisper messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_WHISPER end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_WHISPER = c end,
						},
						yell = {
							type = "toggle",
							name = "yell",
							desc = L["Toggle block yell messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_YELL end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_YELL = c end,
						},
						guild = {
							type = "toggle",
							name = "guild",
							desc = L["Toggle block guild messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_GUILD end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_GUILD = c end,
						},
						party = {
							type = "toggle",
							name = "party",
							desc = L["Toggle block party messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_PARTY end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_PARTY = c end,
						},
						raid = {
							type = "toggle",
							name = "raid",
							desc = L["Toggle block raid messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_RAID end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_RAID = c end,
						},
						system = {
							type = "toggle",
							name = "system",
							desc = L["Toggle block system messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_SYSTEM end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_SYSTEM = c end,
						},
						raid_leader = {
							type = "toggle",
							name = "raid leader",
							desc = L["Toggle block raid leader messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_RAID_LEADER end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_RAID_LEADER = c end,
						},
						battleground = {
							type = "toggle",
							name = "battleground",
							desc = L["Toggle block battleground messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_BATTLEGROUND end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_BATTLEGROUND = c end,
						},
						battleground_leader = {
							type = "toggle",
							name = "battleground leader",
							desc = L["Toggle block battleground leader messages."],
							get = function() return self.db.profile.monitor.CHAT_MSG_BATTLEGROUND_LEADER end,
							set = function(c) self.db.profile.monitor.CHAT_MSG_BATTLEGROUND_LEADER = c end,
						}
					}
				},
				triggermode = {
					order = 210,
					type = "text",
					name = "triggermode",
					desc = L["Change message block trigger mode."],
					usage = "<session | forever>",
					validate = {"session", "forever"},
					get = function() return self.db.profile.trigger_mode end,
					set = function(c) self.db.profile.trigger_mode = c end
				},
				notice_interval = {
					order = 300,
					type = "range",
					name = "notice interval",
					min = 5,
					max = 120,
					step = 1,
					desc = L["Setup notice interval for same sender."],
					get = function() return self.db.profile.noticeInterval end,
					set = function(c)
						self.db.profile.noticeInterval=c
					end
				},
				clean_interval = {
					order = 310,
					type = "range",
					name = "clean interval",
					min = 60,
					max = 3600,
					step = 60,
					desc = L["Setup temp db clean interval."],
					get = function() return self.db.profile.cleanInterval end,
					set = function(c)
						self.db.profile.cleanInterval=c
						self:ScheduleRepeatingEvent("ChannelClean_CleanDB", self.CleanTempDB, self.db.profile.cleanInterval)
					end
				},
				rate = {
					order = 320,
					type = "group",
					name = "rate",
					desc = L["Setup speak rate control."],
					args = {
						toggle = {
							order = 100,
							type = "toggle",
							name = "toggle",
							desc = L["Toggle speak rate control."],
							get = function() return self.db.profile.rate end,
							set = function(c) self.db.profile.rate=c end
						},
						channel_only = {
							order = 200,
							type = "toggle",
							name = "Channel Only",
							desc = L["Speak rate control only process Channel message."],
							get = function() return self.db.profile.rateChannelOnly end,
							set = function(c) self.db.profile.rateChannelOnly=c end
						},
						same_message_only = {
							order = 300,
							type = "toggle",
							name = "Same Message Only",
							desc = L["Speak rate control for same sender with same message."],
							get = function() return self.db.profile.rateSameMessageOnly end,
							set = function(c) self.db.profile.rateSameMessageOnly=c end
						},
						rate_time = {
							order = 400,
							type = "range",
							name = "Rate Time",
							min = 1,
							max = 60,
							step = 1,
							desc = L["Speak rate control time interval."],
							get = function() return self.db.profile.rateTime end,
							set = function(c) self.db.profile.rateTime=c end
						}
					}
				},
				bypass_self = {
					order = 400,
					type = "toggle",
					name = "bypass self message",
					desc = L["Bypass messages send by self."],
					get = function() return self.db.profile.bypassSelf end,
					set = function(c) self.db.profile.bypassSelf = c end
				},
				notice = {
					order = 410,
					type = "toggle",
					name = "notice",
					desc = L["Toggle blocked notice enabled or disabled."],
					get = function() return self.db.profile.notice end,
					set = function(c)
						self.db.profile.notice = c
						if self.db.profile.notice then
							self:Print(L["Blocked notice is enabled."])
						else
							self:Print(L["Blocked notice is disabled."])
						end
					end,
				},
				reset = {
					order = 500,
					type = "execute",
					name = "reset",
					desc = L["Reset all settings. Clear all block rules."],
					func = function()
						self:ResetDB("profile")
						self.lastNotice = {}
						self.trigger_temp = {}
						self.speaker = {}
						self:Print(L["Reset to default settings, all block rules are cleared."])
					end
				}
			}
		}
	)

	-- remove dupe block rules
	self.db.profile.player = self:RemoveDupe(self.db.profile.player)
	self.db.profile.message = self:RemoveDupe(self.db.profile.message)
	self.db.profile.trigger = self:RemoveDupe(self.db.profile.trigger)

	-- load default rules for first time
	if getn(self.db.profile.message)==0 and getn(L["DEFAULT_RULES_MESSAGE"])>0 then
		self.db.profile.message = L["DEFAULT_RULES_MESSAGE"]
	end
	if getn(self.db.profile.trigger)==0 and getn(L["DEFAULT_RULES_TRIGGER"])>0 then
		self.db.profile.trigger = L["DEFAULT_RULES_TRIGGER"]
	end
end

function ChannelClean:OnEnable()
	self:Hook("ChatFrame_OnEvent")

	--add schedule to clean temp db
	self:ScheduleRepeatingEvent("ChannelClean_CleanDB", self.CleanTempDB, self.db.profile.cleanInterval)
end

function ChannelClean:ChatFrame_OnEvent(event)
	--bypass self message
	if arg2==UnitName("player") and self.db.profile.bypassSelf then return self.hooks.ChatFrame_OnEvent(event) end

	--bypass if event is not in monitor list
	if not self.db.profile.monitor[event] then return self.hooks.ChatFrame_OnEvent(event) end

	local message, player = strlower(arg1), strlower(arg2)
	for k,v in ipairs(self.db.profile.message) do
		if strfind(message, v) then
			return self:Notice("message", arg2, k)
		end
	end
	for k,v in ipairs(self.db.profile.player) do
		if strfind(player, v) then
			return self:Notice("player", arg2, k)
		end
	end
	for _,v in ipairs(self.trigger_temp) do
		if player == v then
			return self:Notice("trigger_temp", arg2)
		end
	end
	for k,v in ipairs(self.db.profile.trigger) do
		if strfind(message, v) then
			-- add to trigger db
			self:AddTrigger(player)
			return self:Notice("trigger", arg2, k)
		end
	end

	--control speak rate, no flush!!
	if self.db.profile.rate then
		if (not self.db.profile.rateChannelOnly or (self.db.profile.rateChannelOnly and event=="CHAT_MSG_CHANNEL")) then
			if self.speaker[player] then
				if self.db.profile.rateSameMessageOnly then
					if self.speaker[player].message==message and self.speaker[player].time+self.db.profile.rateTime > time() then
						self.speaker[player]={time=time(), message=message}
						return self:Notice("rate", arg2)
					end
				else
					if self.speaker[player].time+self.db.profile.rateTime > time() then
						self.speaker[player]={time=time(), message=message}
						return self:Notice("rate", arg2)
					end
				end
			end
		end
		self.speaker[player]={time=time(), message=message}
	end

	--call origin function
	return self.hooks.ChatFrame_OnEvent(event)
end

function ChannelClean:Notice(blocktype, blockplayer, blockrule)
	if not self.db.profile.notice then
		return
	end

	-- don't fire too much notice
	if self.lastNotice[blockplayer] and time() - self.lastNotice[blockplayer] < self.db.profile.noticeInterval then
		return
	end
	self.lastNotice[blockplayer] = time()

	blockmsg = "NOTICE_"..blocktype
	if blocktype == "trigger_temp" then
		self:Print(format(L[blockmsg], blockplayer))
	else
		self:Print(format(L[blockmsg], blockplayer, blockrule))
	end
end

function ChannelClean:AddTrigger(player)
	if self.db.profile.trigger_mode == "forever" then
		tinsert(self.db.profile.player, player)
	else
		tinsert(self.trigger_temp, player)
	end
end

function ChannelClean:RemoveDupe(blockrules)
	if type(blockrules)~="table" then
		return {}
	end
	local newrules = {}
	for _,check in ipairs(blockrules) do
		if not self:CheckExists(newrules, check) then
			tinsert(newrules, check)
		end
	end
	return newrules
end

function ChannelClean:CheckExists(rules, check)
	for _,vv in ipairs(rules) do
		if vv == check then
			return true
		end
	end
	return false
end

function ChannelClean:AddRule(blocktype, rule)
	rule = strlower(rule)
	-- don't add exists rule
	if self:CheckExists(self.db.profile[blocktype], rule) then
		return self:Print(L["Rule is already exist."])
	end

	tinsert(self.db.profile[blocktype], rule)

	local blocktype = "RuleGroup_"..blocktype
	self:Print(format(L["RuleAddedFormat"], L[blocktype], rule))
end

function ChannelClean:DeleteRule(blocktype, rule)
	rule = strlower(rule)
	local msg_blocktype = "RuleGroup_"..blocktype

	for k,v in ipairs(self.db.profile[blocktype]) do
		if v and v==rule then
			tremove(self.db.profile[blocktype], k)
			return self:Print(format(L["RuleDeletedFormat"], L[msg_blocktype], rule))
		end
	end

	-- delete by rule number
	local sub1,sub2 = strfind(rule, "#%d+")
	if (sub1 and sub2) then
		local pos = tonumber(strsub(rule, sub1+1, sub2+1))
		if pos and pos > 0 and pos <= getn(self.db.profile[blocktype]) then
			tremove(self.db.profile[blocktype], pos)
			return self:Print(format(L["RuleDeletedFormat"], L[msg_blocktype], rule))
		end
	end

	self:Print(format(L["RuleDeleteNotFoundFormat"], L[msg_blocktype], rule))
end

function ChannelClean:CleanTempDB()
	ChannelClean.lastNotice = {}
	ChannelClean.speaker = {}
end
