assert(oRA, "oRA not found!")


------------------------------
--      Are you local?      --
------------------------------

local UPDATE_DELAY = 0.25


local Compost = AceLibrary("Compost-2.0")
local Roster = AceLibrary("RosterLib-2.0")

local L = AceLibrary("AceLocale-2.0"):new("Grimwald_oRAOTimerBars")


local TimerTypes = {}
local CurrentTimer_Events, CurrentTimer_Iterate


----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	["grimwald_timersoptional"] = true,
	["Optional/Timers"] = true,
	["timer"] = true,
	["Timer Bars"] = true,
	["Options for timers."] = true,
	["bars"] = true,
	["Enable"] = true,
	["Enable timer bars."] = true,
	["Select %s to display."] = true,
} end)


----------------------------------
--      Module Declaration      --
----------------------------------

oRAOTimer = oRA:NewModule(L["grimwald_timersoptional"], "CandyBar-2.0")

oRAOTimer.defaults = {
	bars = false
}
oRAOTimer.optional = true
oRAOTimer.name = L["Optional/Timers"]
oRAOTimer.consoleCmd = L["timer"]
oRAOTimer.consoleOptions = {
	type = "group",
	name = L["Timer Bars"],
	desc = L["Options for timers."],
	args = {
		[L["bars"]] = {
			type = "toggle",
			name = L["Enable"],
			desc = L["Enable timer bars."],
			get = function()
				return oRAOTimer.db.profile.bars
			end,
			set = function()
				local v = not oRAOTimer.db.profile.bars
				oRAOTimer.db.profile.bars = v
				oRAOTimer:SetupBars()
			end,
		},
	}
}


------------------------------
--      Initialization      --
------------------------------

function oRAOTimer:OnInitialize()
	local core, name = self.core, L["grimwald_timersoptional"]

	-- register at core
	core:RegisterModule(name, self)
	core:RegisterDefaults(name, "profile", self.defaults)
	self.db = core:AcquireDBNamespace(name)
	self.debugFrame = core.debugFrame

	self:SetDebugging(true)
end

function oRAOTimer:OnEnable()
    self:RegisterEvent("AceEvent_FullyInitialized", "SetupBars")
end


function oRAOTimer:Register(timertype, events, iterate, items, _name, _title)
	TimerTypes[timertype] = {
		["events"] = events,
		["iterate"] = iterate,
		["title"] = _title or ((_name or timertype)..": %s"),
	}

	self.consoleOptions.args[timertype] = {
		type = "text",
		name = _name or timertype,
		desc = string.format(L["Select %s to display."], timertype),
		get = function()
			return (self.db.profile.timertype == timertype) and self.db.profile.display
		end,
		set = function(v)
			self.db.profile.timertype = timertype
			self.db.profile.display = v
			self:SetupBars()
		end,
		disabled = function()
			return not self.db.profile.bars
		end,
		validate = items,
	}
end


------------------------------
--      Event Handlers      --
------------------------------

function oRAOTimer:BarDataUpdated(updates)
	local _display = self.db.profile.display
	for update, _ in updates do
		if _display == update then
			self:UpdateBars()
			return
		end
	end
end


------------------------------------
--      Timer Bars Functions      --
------------------------------------

function oRAOTimer:SavePosition()
	local f = self.frame
	local x, y = f:GetLeft(), f:GetTop()
	local s = f:GetEffectiveScale()
		
	x, y = x * s, y * s

	self.db.profile.posx = x
	self.db.profile.posy = y		
end

function oRAOTimer:RestorePosition()
	local x = self.db.profile.posx
	local y = self.db.profile.posy
		
	if not x or not y then return end
				
	local f = self.frame
	local s = f:GetEffectiveScale()

	x, y = x / s, y / s

	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end

function oRAOTimer:SetupFrame()
	local frame = CreateFrame("Frame", "Grimwald_oRAOTimerFrame", UIParent)
	frame:EnableMouse(true)
	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function() frame:StartMoving() end)
	frame:SetScript("OnDragStop", function() frame:StopMovingOrSizing() self:SavePosition() end)
	frame:SetWidth(210)
	frame:SetHeight(16)
	frame:Hide()
	frame:SetPoint("TOP", RaidWarningFrame, "BOTTOM", 0, 0)

	local title = frame:CreateFontString(nil, "ARTWORK")
	title:SetFontObject(GameFontNormalSmall)
	title:SetText(L["Timer Bars"])
	title:SetJustifyH("CENTER")
	title:SetWidth(210)
	title:SetHeight(12)
	title:Show()
	title:ClearAllPoints()
	title:SetPoint("TOP", frame, "TOP", 0, 0)

	self.frame = frame
	self.title = title
	
	self:RestorePosition()
end


function oRAOTimer:SetupBars()
	local timertype = self.db.profile.bars and self.db.profile.timertype and TimerTypes[self.db.profile.timertype]

	local _events = timertype and timertype["events"]
	if _events ~= CurrentTimer_Events then
		if CurrentTimer_Events then self:UnregisterBucketEvent(CurrentTimer_Events) end
		if _events then self:RegisterBucketEvent(_events, UPDATE_DELAY, "BarDataUpdated") end

		CurrentTimer_Events = _events
	end

	if timertype then
		CurrentTimer_Iterate = timertype["iterate"]

		if not self.frame then self:SetupFrame() end
		self.title:SetText(string.format(timertype["title"], self.db.profile.display))
		self.frame:Show()
		
		if not self:IsCandyBarGroupRegistered("oRAOTimer") then
			-- create the group
			self:RegisterCandyBarGroup("oRAOTimer")
			self:SetCandyBarGroupPoint("oRAOTimer", "TOP", "Grimwald_oRAOTimerFrame", "BOTTOM", 0, 0)
			self:SetCandyBarGroupGrowth("oRAOTimer", false)
		end

		self:UpdateBars()
	elseif self:IsCandyBarGroupRegistered("oRAOTimer") then
		local barid, i = "oRAOTimer_1", 2
		while self:IsCandyBarRegistered(barid) do
			self:UnregisterCandyBar(barid)

			barid = "oRAOTimer_"..i
			i = i + 1
		end

		self:UnregisterCandyBarGroup("oRAOTimer")

		self.frame:Hide()
	end
end

function oRAOTimer:UpdateBars()
	local barid, i = "oRAOTimer_1", 2
	while self:IsCandyBarRegistered(barid) do
		self:UnregisterCandyBar(barid)

		barid = "oRAOTimer_"..i
		i = i + 1
	end

	i = 1
	for text, texture, duration, timeleft in CurrentTimer_Iterate(self.db.profile.display) do
		barid = "oRAOTimer_"..i
		i = i + 1

		self:RegisterCandyBar(barid, duration, text, texture)
		self:RegisterCandyBarWithGroup(barid, "oRAOTimer")
		self:SetCandyBarFade(barid, 1)
		self:StartCandyBar(barid)
		self:SetCandyBarTimeLeft(barid, timeleft)
	end

	self:UpdateCandyBarGroup("oRAOTimer")
end
