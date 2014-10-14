--[[
	Bongos_ActionBar\main.lua
		Handles variable loading\updating
--]]

--[[ Settings Loading ]]--

local function LoadDefaults()
	BActionSets = {
		g = {
			version = GetAddOnMetadata("Bongos_ActionBar", "Version"),
			buttonsLocked = 1,
			tooltips = 1,
			altCast = 1,
			quickMove = 2,
			colorOutOfRange = 1,
			rangeColor = {r = 1, g = 0.5, b = 0.5},
			numActionBars = 10,
			rightClickSelfCast = 1,
		},
	}
end

local function UpdateSettings(currentVersion)
	BActionSets.g.buttonsLocked = 1
	BActionSets.version = currentVersion
end

local function LoadVariables()
	local currentVersion = GetAddOnMetadata("Bongos_ActionBar", "Version")

	if not(BActionSets and BActionSets.g and BActionSets.g.version) then
		LoadDefaults()
	elseif TLib.VToN(BActionSets.g.version) < TLib.VToN(currentVersion) then
		UpdateSettings(currentVersion)
	end
end

--[[ Startup ]]--

BProfile.RegisterForSave("BActionSets.g")
BProfile.AddStartup(LoadVariables)