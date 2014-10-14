--[[-------------------------------------------------------------------------
-- ClosetGnome_Switcher - Swaps your set to match buff names. Can be easily
--   used to enable special outfits for stances and shapeshift forms.
--
--  by PProvost
--
--  Last Modified: $Date: 2006-10-20 05:07:04 -0400 (Fri, 20 Oct 2006) $
--  Revision: $Revision: 14469 $
--
-- TODO:
--  * N/A
--
--  Known Bugs:
--  * N/A
--]]-------------------------------------------------------------------------


--[[ Local Variables and Constants ]]
local MAJOR_VERSION = "0.2"
local MINOR_VERSION = tonumber((string.gsub("$Revision: 14469 $", "^.-(%d+).-$", "%1")))
local currentSetName = nil

--[[ Utility Libraries ]]
local L = AceLibrary("AceLocale-2.2"):new("ClosetGnomeSwitcher")

--[[ Initialize Addon instance ]]
ClosetGnomeSwitcher = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceModuleCore-2.0")
ClosetGnomeSwitcher.version = MAJOR_VERSION .. "." .. MINOR_VERSION
ClosetGnomeSwitcher.date = string.gsub("$Date: 2006-10-20 05:07:04 -0400 (Fri, 20 Oct 2006) $", "^.-(%d%d%d%d%-%d%d%-%d%d).-$", "%1")
ClosetGnomeSwitcher:RegisterDB("ClosetGnomeSwitcherDB", "ClosetGnomeSwitcherDBPC")
ClosetGnomeSwitcher:RegisterDefaults('char', {
		defaultSet = nil,
})

ClosetGnomeSwitcher.Opts = {
	name = 'Switcher',
	desc = 'Tells your closet gnome when to switch outfits for you.',
	type = 'group',
	order = 106,
	args = {
		defaultSet = {
			type = 'text',
			name = 'Default',
			desc = 'The default set to use when none of the others are applied',
			usage = '<setName>',
			get = function() return ClosetGnomeSwitcher.db.char.defaultSet end,
			set = function(v) ClosetGnomeSwitcher.db.char.defaultSet = v end,
		},
		enabled = {
			type = 'toggle',
			name = 'Enabled',
			desc = 'Enable/disable ClosetGnome_Switcher',
			get = function() return ClosetGnomeSwitcher:IsActive() end,
			set = function(v) ClosetGnomeSwitcher:ToggleActive(v) end,
		},
	}
}

function ClosetGnomeSwitcher:OnInitialize()
	ClosetGnome.OnMenuRequest.args.switcher = ClosetGnomeSwitcher.Opts
end

function ClosetGnomeSwitcher:OnEnable()
	self:ScheduleRepeatingEvent(self.TimerCallback, 1.0, self) 
end

function ClosetGnomeSwitcher:TimerCallback()
 	if UnitIsDeadOrGhost("player") == 1 then return end
	local handled = false
	for name, module in self:IterateModules() do
		handled = module:DoSwitch()
		if handled == true then
			break
		end
	end
	if not handled and self.db.char.defaultSet then
		self:WearSet(self.db.char.defaultSet)
	end
end

function ClosetGnomeSwitcher:WearSet(setName)
	if currentSetName ~= setName and ClosetGnome:HasSet(setName) then 
		currentSetName = setName
		ClosetGnome:WearSet(setName) 
	end
end

function ClosetGnomeSwitcher:GetCurrentShapeshiftForm()
    local numForms = GetNumShapeshiftForms()
    for i = 1, numForms do
        local _, name, active = GetShapeshiftFormInfo(i);
        if active == 1 then return name end
    end
    return nil
end
