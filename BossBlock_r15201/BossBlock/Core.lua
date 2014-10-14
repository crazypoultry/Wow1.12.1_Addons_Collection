

BossBlock = AceLibrary("AceAddon-2.0"):new("AceHook-2.0", "AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")
BossBlock:RegisterDB("BossBlockDB")
--~~ BossBlock.cmdtable = {type = "group", args = {}}
--~~ BossBlock:RegisterChatCommand({"/bossblock"}, BigWigs.cmdtable)

--	showtells = true,
--	showraid = true,
--	showraidsay = true,
--	showraidwarn = true,

local raidchans = {
	CHAT_MSG_RAID = true,
	CHAT_MSG_RAID_WARNING = true,
	CHAT_MSG_RAID_LEADER = true,
}
local blockstrings = {
	["YOU HAVE THE PLAGUE!"] = true,
	["YOU ARE THE BOMB!"] = true,
	["YOU ARE BEING WATCHED!"] = true,
	["YOU ARE CURSED!"] = true,
	["YOU ARE BURNING!"] = true,
	["YOU ARE AFFLICTED BY VOLATILE INFECTION!"] = true,
	["YOU ARE MARKED!"] = true,
}
local blockregexs = {
	"%*+ .+ %*+$",
}


function BossBlock:OnEnable()
	self:Hook("ChatFrame_OnEvent")
	self:Hook("RaidWarningFrame_OnEvent")
	if CT_RAMessageFrame then self:Hook(CT_RAMessageFrame, "AddMessage", "CTRA_AddMessage") end
end


function BossBlock:ChatFrame_OnEvent(event)
	if event == "CHAT_MSG_WHISPER" and not self.showtells and self:IsSpam(arg1) then return end
	if raidchans[event] and not self.showraid and self:IsSpam(arg1) then return end

	self.hooks.ChatFrame_OnEvent.orig(event)
end


function BossBlock:RaidWarningFrame_OnEvent(event, message)
	if not self.showraidwarn and self:IsSpam(message) then return end

	self.hooks.RaidWarningFrame_OnEvent.orig(event, message)
end


function BossBlock:CTRA_AddMessage(obj, text, red, green, blue, alpha, holdTime)
	if not self.showraidsay and self:IsSpam(text) then return end
	self.hooks[CT_RAMessageFrame].AddMessage.orig(obj, text, red, green, blue, alpha, holdTime)
end


function BossBlock:IsSpam(text)
	if not text then return end
	if blockstrings[text] then return true end
	for _,regex in pairs(blockregexs) do if string.find(text, regex) then return true end end
end


