local BS = AceLibrary("Babble-Spell-2.0")
local aura = AceLibrary("SpecialEvents-Aura-2.0")

Redirection = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0")

function Redirection:OnInitialize()
	Redirection:RegisterChatCommand({"/redirection", "/re"})
	Redirection:RegisterDB("RedirectionDB", "RedirectionDBPC")
end

function Redirection:OnEnable()
	self:RegisterEvent("SpecialEvents_PlayerBuffGained", "BuffGained")
end

function Redirection:BuffGained(buffname, buffindex)
	if (buffname == "Misdirection") then
		CancelPlayerBuff(buffindex)
		self:Print("WARNING! "..buffname.." cast on you. Auto-cancelling...")
	end
end
