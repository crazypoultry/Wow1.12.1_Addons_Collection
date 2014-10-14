-------------------------------------------------------------------------------
-- Locals                                                                    --
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeOhNoes")
local gratuity = AceLibrary("Gratuity-2.0")
local compost = AceLibrary("Compost-2.0")

local lastItems = nil
local gotNakie = nil

-------------------------------------------------------------------------------
-- Localization                                                              --
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Percent"] = true,
	["Set the percentage at which Oh Noes! triggers."] = true,
	["OH NOES! unequipping weapons..."] = true,
	["All better! putting weapons back on."] = true,
} end)

-------------------------------------------------------------------------------
-- Addon declaration                                                         --
-------------------------------------------------------------------------------

ClosetGnomeOhNoes = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
ClosetGnomeOhNoes:RegisterDB("ClosetGnomeOhNoesDB")
ClosetGnomeOhNoes:RegisterDefaults("profile", {
	enabled = true,
	health = .04,
})
ClosetGnomeOhNoes:RegisterChatCommand({"/ohnoes", "/oh"}, {
	type = "group",
	handler = ClosetGnomeOhNoes,
	args = {
		[L["Percent"]] = {
			name = L["Percent"],
			type = "range",
			desc = L["Set the percentage at which Oh Noes! triggers."],
			get = function() return ClosetGnomeOhNoes.db.profile.health end,
			set = function(v) ClosetGnomeOhNoes.db.profile.health = v end,
			min = 0.01,
			max = 1,
			step = 0.01,
			isPercent = true,
		},
	},
})


-------------------------------------------------------------------------------
-- Initialization                                                            --
-------------------------------------------------------------------------------

function ClosetGnomeOhNoes:OnEnable()
	if not ClosetGnome then return end
	self:RegisterBucketEvent("UNIT_HEALTH", 0.2)
end

-------------------------------------------------------------------------------
-- Events                                                                    --
-------------------------------------------------------------------------------

function ClosetGnomeOhNoes:UNIT_HEALTH(unit)
	if not unit.player or not self.db.profile.enabled then return end
	if UnitExists("target") and UnitIsPlayer("target") and UnitIsEnemy("player", "target") then return end
	local health = UnitHealth("player") / UnitHealthMax("player")
	local treshold = self.db.profile.health
	if health <= treshold and not gotNakie then
		self:GetNakie()
	elseif health >= treshold and gotNakie and GetTime() - gotNakie >= 1 then
		gotNakie = nil
		self:NoLongerDying()
	end
end

function ClosetGnomeOhNoes:GetNakie()
	self:Print(L["OH NOES! unequipping weapons..."])
	gotNakie = GetTime()
	if not lastItems then lastItems = compost:Acquire() end
	if not lastItems[16] then
		gratuity:SetInventoryItem("player", 16)
		lastItems[16] = gratuity:GetLine(1)
	end
	if not lastItems[17] then
		gratuity:SetInventoryItem("player", 17)
		lastItems[17] = gratuity:GetLine(1)
	end
	if not lastItems[18] then
		gratuity:SetInventoryItem("player", 18)
		lastItems[18] = gratuity:GetLine(1)
	end
	ClosetGnome:EquipItem(16, false)
	ClosetGnome:EquipItem(17, false)
	ClosetGnome:EquipItem(18, false)
	ClosetGnome:ProcessDeequipQueue()
end

function ClosetGnomeOhNoes:NoLongerDying()
	self:Print(L["All better! putting weapons back on."])
	if not lastItems or not self.db.profile.enabled then return end
	ClosetGnome:EquipItem(16, lastItems[16])
	ClosetGnome:EquipItem(17, lastItems[17])
	ClosetGnome:EquipItem(18, lastItems[18])
	compost:Reclaim(lastItems)
	lastItems = nil
end

