--
-- $Id$
--
-- FuBar_AssistFu -- a FuBar button to set/target your assist
--

local Tablet = AceLibrary("Tablet-2.0")
local Dewdrop = AceLibrary("Dewdrop-2.0")

AssistFu = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")
AssistFu:RegisterDB("AssistFuDB")

local ASSISTFU_PET_MA = "__pet__"

local options = {
	type = "group",
	desc = "Assist functions",
	args = {
		set = {
			type = "text",
			name = "Set assist",
			desc = "Set the player to assist. If the argument 'pet' is given, will assist your pet if you have one. Use 'target' for your current target. Otherwise it's assumed to be the name of the player you want to assist.",
			usage = "pet|target|<name>",
			get = false,
			set = "SetAssist"
		},
		assist = {
			type = "execute",
			name = "Assist",
			desc = "Assist the unit you saved, or your current target if you have not yet saved a unit.",
			func = "Assist"
		},
		clear = {
			type = "execute",
			name = "Clear assist",
			desc = "Reset the saved unit to assist.",
			func = "ClearAssist"
		},
		pull = {
			type = "toggle",
			name = "Pull messages",
			desc = "Toggles whether your pull message is shown if you are assisting yourself.",
			get = "GetPull",
			set = "SetPull"
		},
		msg = {
			type = "text",
			name = "Pull message",
			desc = "Set your pull message.",
			usage = "<message>",
			get = "GetMsg",
			set = "SetMsg"
		},
		channel = {
			type = "text",
			name = "Pull channel",
			desc = "Set the channel to which we should announce our pulls.",
			usage = "auto|say|party|raid|<channel>",
			get = "GetChannel",
			set = "SetChannel"
		}
	}
}

function AssistFu:OnInitialize()
	self:RegisterDefaults("profile", {
		showmsg = nil,
		msg = "Pulling: %s",
		channel = "party",
		ma = nil
	})
	self:RegisterChatCommand({"/assistfu", "/afu"}, options)
	self.hasIcon = true
end

function AssistFu:OnEnable()
	self:UpdateText()
	self:SetIcon(true)
end

function AssistFu:OnTextUpdate()
	local text
	if self.db.profile.ma == UnitName("player") then
		text = "Pull"
		if self.db.profile.showmsg then
			text = text .. " (" .. self.db.profile.channel .. ")"
		else
			text = text .. " (no msg)"
		end
	elseif self.db.profile.ma == ASSISTFU_PET_MA then
		text = "Your Pet"
	else
		text = self.db.profile.ma
	end
	self:SetText(text or "No assist")
	self:SetIcon(true)
end

function AssistFu:OnClick()
	self:Assist()
end

function AssistFu:OnTooltipUpdate()
	Tablet:SetHint("Click to assist your saved assist.")
	local cat = Tablet:AddCategory(
		"columns", 2,
		"child_textR", 1,
		"child_textG", 1,
		"child_textB", 1
	)
	cat:AddLine(
		"text", "Current pull channel:",
		"text2", self.db.profile.channel or "party"
	)
	cat:AddLine(
		"text", "Current pull message:",
		"text2", self.db.profile.msg or "Pulling: %s"
	)
end

function AssistFu:OnMenuRequest(level, value, x, valueN_1, valueN_2, valueN_3, valueN_4)
	Dewdrop:FeedAceOptionsTable(options)
end

function AssistFu:SetAssist(name)
	if not self:IsActive() then
		return
	end

	if not name then
		name = "target"
	end

	if name ~= "target" and string.len(name) > 0 then
		if name == "pet" then
			self:SetAssistPet();
		else
			self:SetAssistPlayer(name)
		end
	elseif UnitName("target") == nil then
		self:ClearAssist()
	elseif UnitIsUnit("pet", "target") then
		self:SetAssistPet()
	elseif UnitIsPlayer("target") and UnitIsUnit("target", "player") then
		self:SetPulling()
	elseif UnitIsPlayer("target") and UnitIsFriend("target", "player") then
		self:SetAssistPlayer(UnitName("target"))
	else
		self:Print("Cannot set assist to enemies or NPCs.")
	end
	self:UpdateText()
end

function AssistFu:Assist()
	if not self:IsActive() then
		-- Make sure the regular keybinding continues to work
		AssistUnit("target")
		return
	end

	local ma = self.db.profile.ma
	if not ma then
		AssistUnit("target")
	elseif ma == ASSISTFU_PET_MA then
		self:AssistPet()
	elseif ma == UnitName("player") then
		self:ShowPull(UnitName("target"))
	else
		AssistByName(ma)
	end
end

function AssistFu:ClearAssist()
	self.db.profile.ma = nil
	self:UpdateText()
end

function AssistFu:AssistPet()
	if UnitName("pet") then
		AssistUnit("pet")
	else
		AssistUnit("target")
	end
end

function AssistFu:SetAssistPet()
	self.db.profile.ma = ASSISTFU_PET_MA
end

function AssistFu:SetAssistPlayer(name)
	self.db.profile.ma = name
end

function AssistFu:SetPulling()
	self.db.profile.ma = UnitName("player")
	self:UpdateText()
end

function AssistFu:MsgChannel()
	local chan = self.db.profile.channel

	if not chan or chan == "auto" then
		if UnitInRaid("player") then
			return "RAID"
		elseif UnitInParty("player") then
			return "PARTY"
		else
			return "SAY"
		end
	end

	if chan == "party" or chan == "raid" or chan == "say" then
		return string.upper(chan)
	end

	local i = GetChannelName(chan)
	if i then
		chan = "CHANNEL"
	else
		if not UnitInParty("player") then
			chan = "SAY"
		else
			chan = "PARTY"
		end
	end

	return chan, i
end

function AssistFu:ShowPull(name)
	if not name or not self.db.profile.showmsg then return end

	local msg = format(self.db.profile.msg or "Now pulling: %s", name)
	if not msg or msg == "" then return end

	local chan, i = self:MsgChannel()
	if not chan then return end

	SendChatMessage(msg, chan, nil, i)
end

function AssistFu:GetPull()
	return self.db.profile.showmsg
end

function AssistFu:SetPull()
	self.db.profile.showmsg = not self.db.profile.showmsg or nil
	self:UpdateText()
end

function AssistFu:GetMsg()
	return self.db.profile.msg
end

function AssistFu:SetMsg(msg)
	self.db.profile.msg = msg
end

function AssistFu:GetChannel()
	return self.db.profile.channel
end

function AssistFu:SetChannel(chan)
	self.db.profile.channel = chan
	self:UpdateText()
end

BINDING_HEADER_ASSISTFU = "AssistFu"
BINDING_NAME_AFUSETASSIST = "Set Assist"
BINDING_NAME_AFUASSIST = "Assist saved"
BINDING_NAME_AFUASSISTPET = "Assist your pet"

-- vim:set ts=4:
