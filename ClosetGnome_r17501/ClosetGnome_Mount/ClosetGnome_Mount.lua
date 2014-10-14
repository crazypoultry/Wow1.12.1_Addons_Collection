-------------------------------------------------------------------------------
-- Locals                                                                    --
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeMount")
local lastSetBeforeMounting = nil

-------------------------------------------------------------------------------
-- Localization                                                              --
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Mount"] = true,
	["Could not find a set named %s. Please add one."] = true,
} end)

-------------------------------------------------------------------------------
-- Addon declaration                                                         --
-------------------------------------------------------------------------------

ClosetGnomeMount = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
ClosetGnomeMount:RegisterDB("ClosetGnomeMountDB")
ClosetGnomeMount:RegisterDefaults("profile", {
	enabled = true,
})

-------------------------------------------------------------------------------
-- Initialization                                                            --
-------------------------------------------------------------------------------

function ClosetGnomeMount:OnEnable()
	if not ClosetGnome then return end
	self:RegisterEvent("SpecialEvents_Mounted")
	self:RegisterEvent("SpecialEvents_Dismounted")
	self:RegisterEvent("ClosetGnome_WearSet")

	if not ClosetGnome:HasSet(L["Mount"]) and self.db.profile.enabled then
		self:Print(string.format(L["Could not find a set named %s. Please add one."], L["Mount"]))
	end
end

-------------------------------------------------------------------------------
-- Events                                                                    --
-------------------------------------------------------------------------------

function ClosetGnomeMount:ClosetGnome_WearSet(name)
	if name == L["Mount"] then return end
	lastSetBeforeMounting = name
end

function ClosetGnomeMount:SpecialEvents_Mounted(buff, speed)
	if not self.db.profile.enabled then return end
	if not ClosetGnome:HasSet(L["Mount"]) then
		self:Print(string.format(L["Could not find a set named %s. Please add one."], L["Mount"]))
		return
	end
	ClosetGnome:WearSet(L["Mount"])
end

function ClosetGnomeMount:SpecialEvents_Dismounted()
	if not ClosetGnome:HasSet(L["Mount"]) or not lastSetBeforeMounting or not self.db.profile.enabled then return end
	if ClosetGnome:HasSet(lastSetBeforeMounting) then
		ClosetGnome:WearSet(lastSetBeforeMounting)
	end
end

