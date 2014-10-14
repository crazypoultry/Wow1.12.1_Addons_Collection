
local CommChannel = CommChannel("1.0")
local IFrameFactory = IFrameFactory("1.0")

local HealSyncDock = { }
local Targets = { }

local iface = IFrameManager:Interface()
function iface:getName(frame)
	return string.gsub(frame:GetName(), "_", " ")
end

local function CreateDock(unitID, label)
	this = CreateFrame("Frame", "HealSync__"..label, UIParent)
	this:SetWidth(256)
	this:SetHeight(20)
	this:SetPoint("CENTER", UIParent)
	this:SetMovable(true)
	this:SetUserPlaced(true)
	
	HealSyncDock[unitID] = this	
	IFrameManager:Register(this, iface)
end

CreateDock("player", "Player")
CreateDock("target", "Target")

local function getUnitID(name)
	local numRaidMembers = GetNumRaidMembers()
	for raidID=1,numRaidMembers do
		local unitName = GetRaidRosterInfo(raidID)
		if (unitName == name) then
			return "raid"..raidID
		end
	end
	
	local numPartyMembers = GetNumPartyMembers()
	for partyID=1,numPartyMembers do
		local unitName = UnitName("party"..partyID)
		if (unitName == name) then
			return "party"..partyID
		end
	end
	
	if (name == UnitName("player")) then
		return "player"
	end
	
	return nil
end

local function UpdateDock(unitID)
	local name = UnitName(unitID)
	
	if (name == nil or Targets[name] == nil) then
		return
	end
		
	local list = Targets[name]
	local parent = HealSyncDock[unitID]
	
	for index, heal in ipairs(list) do
		local frame = IFrameFactory:Create("HealSync", "Button")
		
		frame.heal = heal
		frame.caster:SetText(heal[1])
		frame.spell:SetText(heal[3])
		frame.bar:SetMinMaxValues(0, heal[5])
		if (heal[1] == UnitName("player")) then
			frame.bar:SetStatusBarColor(1.0, 0.0, 0.0, 0.8)
		else
			local uID = getUnitID(heal[1])
			local _, class = UnitClass(uID or "")
			local color = RAID_CLASS_COLORS[class or "PRIEST"]
			frame.bar:SetStatusBarColor(color.r, color.g, color.b, 0.8)
		end
		frame:ClearAllPoints()
		if (parent == HealSyncDock[unitID]) then
			frame:SetPoint("TOP", parent, "TOP", 0, 0)
		else
			frame:SetPoint("TOP", parent, "BOTTOM", 0, 2)
		end
		
		parent = frame
	end
end

function HealSyncUpdate(caster)
	IFrameFactory:Clear("HealSync", "Button")
	
	UpdateDock("player")
	UpdateDock("target")
end

function HealSyncClear(caster)
	for _, list in pairs(Targets) do
		for index, heal in ipairs(list) do
			if (heal[1] == caster) then
				table.remove(list, index)
			end
		end
	end
	
	for target, list in pairs(Targets) do
		if (table.getn(list) == 0) then
			Targets[target] = nil
		end
	end
end

local function sort(left, right)
	return left[4] + left[5] < right[4] + right[5]
end

local iface = { }
local module = CommChannel:Create("RAID", "HSC", iface)

function iface:S(target, spell, duration, lag)
	HealSyncClear(arg4)
	
	local _, _, llag = GetNetStats()
	lag = (lag + llag) / 1000
	
	Targets[target] = Targets[target] or { }
	local list = Targets[target]
	
	local heal = { arg4, target, spell, GetTime() - lag, duration}
	table.insert(list, heal)
	table.sort(list, sort)
	
	HealSyncUpdate()
end

function iface:D(delay)
	for _, list in pairs(Targets) do
		for _, heal in ipairs(list) do
			if (heal[1] == arg4) then
				heal[5] = heal[5] + delay
			end
		end
	end
	
	HealSyncUpdate()
end

function iface:I()
	HealSyncClear(arg4)
	HealSyncUpdate()
end

local isCasting = false
local function onEvent()
	if (event == "PLAYER_ENTERING_WORLD") then
	elseif (event == "PLAYER_TARGET_CHANGED") then
		HealSyncUpdate()
	elseif (event == "SPELLCAST_START") then
		local target = UnitName("target")
		if (target and getUnitID(target)) then
			local _, _, lag = GetNetStats()
			module:Call("S", target, arg1, arg2 / 1000, lag)
			isCasting = true
		else
			isCasting = false
		end
	elseif (event == "SPELLCAST_DELAYED") then
		if (isCasting) then module:Call("D", arg1 / 1000) end
	elseif (event == "SPELLCAST_INTERRUPTED") then
		if (isCasting) then module:Call("I") end
	end
end

this = CreateFrame("Frame")
this:RegisterEvent("PLAYER_ENTERING_WORLD")
this:RegisterEvent("PLAYER_TARGET_CHANGED")
this:RegisterEvent("SPELLCAST_START")
this:RegisterEvent("SPELLCAST_DELAYED")
this:RegisterEvent("SPELLCAST_INTERRUPTED")
this:SetScript("OnEvent", onEvent)
