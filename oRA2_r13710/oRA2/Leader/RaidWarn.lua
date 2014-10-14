
assert( oRA, "oRA not found!")

------------------------------
--      Are you local?      --
------------------------------

local L = AceLibrary("AceLocale-2.0"):new("oRALRaidWarn")

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["rw"] = true,
	["raidwarningleader"] = true,
	["Raidwarning"] = true,
	["Options for raid warning."] = true,
	["Leader/RaidWarn"] = true,
	["Send"] = true,
	["Send an RS Message."] = true,
	["<message>"] = true,
	["ToRaid"] = true,
	["OldStyle"] = true,
	["To Raid"] = true,
	["Old Style"] = true,
	["Send RS Messages to Raid as well."] = true,
	["Use CTRA RS Messages instead of RaidWarning."] = true,
} end )

L:RegisterTranslations("zhCN", function() return {
	["rw"] = "rw",
	["raidwarningleader"] = "raidwarningleader",
	["Raidwarning"] = "团队报警",
	["Options for raid warning."] = "团队警报选项.",
	["Leader/RaidWarn"] = "Leader/RaidWarn",
	["Send"] = "发送",
	["Send an RS Message."] = "发送一条RS消息",
	["<message>"] = "<message>",
	["ToRaid"] = "发送到RAID",
	["OldStyle"] = "老样式",
	["To Raid"] = "进行RAID",
	["Old Style"] = "老样式",
	["Send RS Messages to Raid as well."] = "RS同时发送一条消息到团队聊天频道",
	["Use CTRA RS Messages instead of RaidWarning."] = "使用CTRA消息取代团队警报",
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

oRALRaidWarn = oRA:NewModule(L["raidwarningleader"])
oRALRaidWarn.defaults = {
	oldstyle = false,
	toraid = false,
}
oRALRaidWarn.leader = true
oRALRaidWarn.name = L["Leader/RaidWarn"]
oRALRaidWarn.consoleCmd = L["rw"]
oRALRaidWarn.consoleOptions = {
	type = "group",
	desc = L["Options for raid warning."],
	name = L["Raidwarning"],
	args = {
		[L["Send"]] = {
			name = L["Send"], type = "text",
			desc = L["Send an RS Message."],
			usage = L["<message>"],
			get = false,
			set = function(v)
				oRALRaidWarn:SendRS(v)
			end,
			validate = function(v)
				return string.find(v, "^(.+)$")
			end,
			disabled = function() return not oRALRaidWarn:IsValidRequest() end,
		},
		[L["ToRaid"]] = {
			name = L["To Raid"], type = "toggle",
			desc = L["Send RS Messages to Raid as well."],
			get = function() return oRALRaidWarn.db.profile.toraid end,
			set = function(v)
				oRALRaidWarn.db.profile.toraid = v
			end,	
		},
		[L["OldStyle"]] = {
			name = L["Old Style"], type = "toggle",
			desc = L["Use CTRA RS Messages instead of RaidWarning."],
			get = function() return oRALRaidWarn.db.profile.oldstyle end,
			set = function(v)
				oRALRaidWarn.db.profile.oldstyle = v
			end,	
		},
	}
}

------------------------------
--      Initialization      --
------------------------------

function oRALRaidWarn:OnInitialize()
	self.debugFrame = ChatFrame5
end

function oRALRaidWarn:OnEnable()
	self:RegisterShorthand("rs", function(msg) self:SendRS(msg) end )
end

function oRALRaidWarn:OnDisable()
	self:UnregisterShorthand("rs")
end

------------------------------
--     Command Handlers     --
------------------------------

function oRALRaidWarn:SendRS(msg)
	if not msg or not oRALRaidWarn:IsValidRequest() then return end
	if self.db.profile.oldstyle then
		self:SendMessage("MS "..msg )
	else
		SendChatMessage(msg, "RAID_WARNING")
	end
	if self.db.profile.toraid then SendChatMessage(msg, "RAID") end
end
