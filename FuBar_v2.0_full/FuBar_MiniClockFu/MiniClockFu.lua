--[[
    MiniClockFu!
        "I just need a clock mate, not an all-in-one uber-configurable clockmaster =P"

    Based on ClockFu
--]]

MiniClockFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

MiniClockFu:RegisterDB("MiniClockFuDB")
MiniClockFu:RegisterDefaults('profile', { LocalTimeInPanel = true })

local L = { -- L for Locals!
    CONFIG_LOCALTIMEINPANEL = "Show Local Time in Panel",
    LOCALTIME = "Local Time",
    GAMETIME = "Game Time",
}

MiniClockFu.hasIcon = false
MiniClockFu.defaultPosition = 'RIGHT'

local db
function MiniClockFu:OnProfileEnable()
    db = self.db.profile -- update shortcut to db now that it's changed
end

function MiniClockFu:OnInitialize()
    db = self.db.profile
end

local timerID
function MiniClockFu:OnEnable()
    GameTimeFrame:Hide() -- Get rid of the time minimap button
    timerID = self:ScheduleRepeatingEvent(self.Update, 1, self)
end

function MiniClockFu:OnDisable()
    GameTimeFrame:Show()
    self:CancelScheduledEvent(timerID)
end

function MiniClockFu:OnMenuRequest()
		dewdrop:AddLine(
			'text', L.CONFIG_LOCALTIMEINPANEL,
			'func', function()
				db.LocalTimeInPanel = not db.LocalTimeInPanel
                MiniClockFu:Update()
			end,
			'checked', db.LocalTimeInPanel
		)
end

local lastMinute, secondsDifference
function MiniClockFu:GetServerTime()
    local _
	local hour, minute = GetGameTime()
	if lastMinute ~= minute then
		_, lastMinute = GetGameTime()
		secondsDifference = mod(time(), 60)
	end
	local second = mod(time() - secondsDifference, 60)
	return string.format("%.2d:%.2d:%.2d", hour, minute, second)
end

local localTime, gameTime
function MiniClockFu:OnDataUpdate()
    localTime = date("%X")
    gameTime = self:GetServerTime()
end

function MiniClockFu:OnTextUpdate()
    self:SetText(string.format("|cffffffff%s|r", db.LocalTimeInPanel and localTime or gameTime))
end

function MiniClockFu:OnTooltipUpdate()
    local cat = tablet:AddCategory(
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0,
		'child_text2R', 1,
		'child_text2G', 1,
		'child_text2B', 1
	)
	cat:AddLine(
		'text', L.LOCALTIME,
		'text2', localTime
	)
	cat:AddLine(
		'text', L.GAMETIME,
		'text2', gameTime
	)
end