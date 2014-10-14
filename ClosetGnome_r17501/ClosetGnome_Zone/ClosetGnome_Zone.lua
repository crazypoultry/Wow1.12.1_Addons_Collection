 --[[ 
 
 Name: ClosetGnomesZones
 
 Description: ClosetGnomeBigWigs changed to support Zones.  Basically a straight rip of Rabbit's code 
 so he gets 100% of the credit.

Know Problems:

Which set you set to Default isn't being displayed correctly from /cgz. 
 
 ]]


-------------------------------------------------------------------------------
-- Locals                                                                    --
-------------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeZone")
local queuedSet = nil

-------------------------------------------------------------------------------
-- Localization                                                              --
-------------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Entered %s, equipping set %s."] = true,
	["ClosetGnome - Zone"] = true,
	["Makes your ClosetGnome aware of the zones in this dangerous world."] = true,

	["You have entered %s. Do you want to equip %s?\n\nYou can disable this confirmation dialog to autoequip with /cgz confirm."] = true,
	["Equip"] = true,
	["Cancel"] = true,

	["Assign"] = true,
	["Assign a set to the current zone."] = true,
	["<set>"] = true,
	["List"] = true,
	["List assignments"] = true,
	["List the current assignments."] = true,
	["Confirm"] = true,
	["Confirm Autoequip"] = true,
	["Open a confirmation dialog before autoequipping a zone set."] = true,
	["Default"] = true,
	["Set your outfit for unassigned zones."] = true,

	["%s assigned to %s."] = true,
	["%s: %s."] = true,
	["%d assignments registered."] = true,
} end)

-------------------------------------------------------------------------------
-- Addon declaration                                                         --
-------------------------------------------------------------------------------

ClosetGnomeZone = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceEvent-2.0")
ClosetGnomeZone:RegisterDB("ClosetGnomeZoneDB", "ClosetGnomeZonePCDB")
ClosetGnomeZone:RegisterDefaults("profile", {
	enabled = true,
	confirmEquip = true,
})
ClosetGnomeZone:RegisterDefaults("char", {
	assignments = {},
})

ClosetGnomeZone:RegisterChatCommand({"/cgz"}, {
	type = "group",
	name = L["ClosetGnome - Zone"],
	desc = L["Makes your ClosetGnome aware of the zones in this dangerous world."],
	args = {
		[L["Assign"]] = {
			type = 'text',
			name = L["Assign"],
			desc = L["Assign a set to the current zone."],
			get = false,
			set = function(v) ClosetGnomeZone:AddAssignment(v) end,
			usage = L["<set>"],
		},
		[L["List"]] = {
			type = "execute",
			name = L["List assignments"],
			desc = L["List the current assignments."],
			func = function() ClosetGnomeZone:ListAssignments() end,
		},
		[L["Confirm"]] = {
			type = "toggle",
			name = L["Confirm Autoequip"],
			desc = L["Open a confirmation dialog before autoequipping a zone set."],
			get = function() return ClosetGnomeZone.db.profile.confirmEquip end,
			set = function(v) ClosetGnomeZone.db.profile.confirmEquip = v end,
		},
		[L["Default"]] = {
			type = "text",
			name = L["Default"],
			desc = L["Set your outfit for unassigned zones."],
			get = function() return ClosetGnomeZone.db.char.assignments[L["Default"]] end,
			set = function(v) ClosetGnomeZone:SetDefault(v) end,
			usage = L["<set>"],
		},
	},
})
-------------------------------------------------------------------------------
-- Initialization                                                            --
-------------------------------------------------------------------------------

function ClosetGnomeZone:OnEnable()
	if not ClosetGnome then return end
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	StaticPopupDialogs["ClosetGnomeZoneConfirm"] = {
		text = L["You have entered %s. Do you want to equip %s?\n\nYou can disable this confirmation dialog to autoequip with /cgz confirm."],
		button1 = L["Equip"],
		button2 = L["Cancel"],
		sound = "levelup2",
		whileDead = 0,
		hideOnEscape = 1,
		timeout = 0,
		OnAccept = function()
			ClosetGnome:WearSet(queuedSet)
			ClosetGnome:Update()
		end,
	}
end

-------------------------------------------------------------------------------
-- Command handlers                                                          --
-------------------------------------------------------------------------------

function ClosetGnomeZone:ListAssignments()
	local frame = DEFAULT_CHAT_FRAME
	local counter = 0
	for k, v in pairs(self.db.char.assignments) do
		frame:AddMessage(string.format(L["%s: %s."], k, v))
		counter = counter + 1
	end
	frame:AddMessage(string.format(L["%d assignments registered."], counter))
end

function ClosetGnomeZone:AddAssignment(set)
	zone = GetRealZoneText()
	if zone and set then
		self.db.char.assignments[zone] = set
	end
	ClosetGnome:Print(string.format(L["%s assigned to %s."], zone, set))
end

function ClosetGnomeZone:SetDefault(set)
	zone = L["Default"]
	if zone and set then
		self.db.char.assignments[zone] = set
	end
	ClosetGnome:Print(string.format(L["%s assigned to %s."], zone, set))
end

-------------------------------------------------------------------------------
-- Events                                                                    --
-------------------------------------------------------------------------------

function ClosetGnomeZone:ZONE_CHANGED_NEW_AREA()
	if not self.db.profile.enabled or UnitOnTaxi("player") then return end
	
	zone = GetRealZoneText()
	setName = self.db.char.assignments[zone] or self.db.char.assignments[L["Default"]]
	
	if not setName or ClosetGnome:IsSetFullyEquipped(setName) then return end

	if ClosetGnome:HasSet(setName) then
		if self.db.profile.confirmEquip then
			queuedSet = setName
			StaticPopup_Show("ClosetGnomeZoneConfirm", "|cffd9d919"..zone.."|r", "|cffd9d919"..setName.."|r")
		else
			self:Print(string.format(L["Entered %s, equipping set %s."], zone, setName))
			ClosetGnome:WearSet(setName)
			ClosetGnome:Update()
		end
	end
end

