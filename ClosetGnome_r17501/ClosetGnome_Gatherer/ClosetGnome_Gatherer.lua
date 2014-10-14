assert(ClosetGnome, "ClosetGnome not found!")

-------------------------------------------------------------------------------
-- Locals
-------------------------------------------------------------------------------
local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeGatherer")


-------------------------------------------------------------------------------
-- Localization
-------------------------------------------------------------------------------
L:RegisterTranslations("enUS", function() return {
	["Could not find a set named %s. Please add one."] = true,
	
	["Skinning"] = true,
	["Herbalism"] = true,
	["Mining"] = true,
	["Herb Gathering"] = true,

	["Requires (.+) %d"] = true,
	["You fail to perform (.+): Invalid target."] = true,
} end)


-------------------------------------------------------------------------------
-- Addon declaration
-------------------------------------------------------------------------------
ClosetGnomeGatherer = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0")


-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
function ClosetGnomeGatherer:OnEnable()
	self:RegisterEvent("ClosetGnome_WearSet", "WearSet")
	self:RegisterEvent("ClosetGnome_PartlyWearSet", "WearSet")
	self:RegisterEvent("UI_ERROR_MESSAGE")
end


-------------------------------------------------------------------------------
-- Events
-------------------------------------------------------------------------------
function ClosetGnomeGatherer:UI_ERROR_MESSAGE(msg)
	local _, _, skill = string.find(msg, L["Requires (.+) %d"])
	
	if self:IsGatheringSkill(skill) then
		self:Equip(skill)
	end
end

function ClosetGnomeGatherer:CHAT_MSG_SPELL_FAILED_LOCALPLAYER(msg)
	local _, _ skill = string.find(msg, L["You fail to perform (.+): Invalid target."])
	
	if self:IsGatheringSkill(skill) then
		self:UnEquip()
	end
end

function ClosetGnomeGatherer:SPELLCAST_START(spell)
	if self:IsGatheringSkill(spell) then
		self:ScheduleEvent("ClosetGnomeGatherer", self.UnEquip, 10, self)
	end
end

function ClosetGnomeGatherer:LOOT_OPENED()
	self:UnEquip()
end

function ClosetGnomeGatherer:WearSet(set)
	if self:IsGatheringSet(set) then
		self.gatheringSet = set
	else
		self.gatheringSet = false
		self.lastSet = set
	end
end


-------------------------------------------------------------------------------
-- Utility functions
-------------------------------------------------------------------------------
function ClosetGnomeGatherer:CheckForSet(set)
	if ClosetGnome:HasSet(set) then return true end
	
	self:Print(string.format(L["Could not find a set named %s. Please add one."], set))
	return false
end

function ClosetGnomeGatherer:Equip(set)
	if self:CheckForSet(set) then
		ClosetGnome:WearSet(set)

		if set ~= L["Mining"] then
			self:RegisterEvent("LOOT_OPENED")
		end
		self:RegisterEvent("SPELLCAST_START")
		self:RegisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
		
		-- Failsafe so we don't run around in the wrong equipment by mistake, also used to UnEquip mining equipment when the vein is gone
		self:ScheduleEvent("ClosetGnomeGatherer", self.UnEquip, 10, self)
	end
end

function ClosetGnomeGatherer:UnEquip()
	if self.gatheringSet then
		ClosetGnome:WearSet(self.lastSet)
		
		if self:IsEventRegistered("LOOT_OPENED") then
			self:UnregisterEvent("LOOT_OPENED")
		end
		self:UnregisterEvent("SPELLCAST_START")
		self:UnregisterEvent("CHAT_MSG_SPELL_FAILED_LOCALPLAYER")
	end
	
	self:CancelScheduledEvent("ClosetGnomeGatherer")
end

function ClosetGnomeGatherer:IsGatheringSkill(skill)
	if skill == L["Skinning"] or skill == L["Herb Gathering"] or skill == L["Herbalism"] or skill == L["Mining"] then
		return true
	end
end

function ClosetGnomeGatherer:IsGatheringSet(set)
	if set == L["Herb Gathering"] then
		return false
	end
	
	return self:IsGatheringSkill(set)
end



