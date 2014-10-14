--[[
    NavigatorFu!
        "Arr! Me map no tell me my coordinates! I don't want some landlubber's enormous contraption to get them!"

    Based on LocationFu and MapCoords
--]]

NavigatorFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")

NavigatorFu:RegisterDB("NavigatorFuDB")

NavigatorFu.hasIcon = true

local L = { -- L for locals!
    COORDFMTSTRING = "Cursor: %.1f, %.1f     --     Player: ", -- playerCoords is concated on to this
    HINT = "Click to open the world map",
}

function NavigatorFu:OnInitialize()
    -- Create frame and fontstrings for world map display

    local mapFrame = CreateFrame("Frame", "NavigatorFuMapFrame", WorldMapFrame)
	mapFrame:SetScript("OnUpdate", function() NavigatorFu:MapFrame_OnUpdate() end)

	local coordText = mapFrame:CreateFontString("NavigatorFuMapFrameCoordText", "ARTWORK")
	coordText:SetFont(GameFontNormal:GetFont())
	coordText:SetTextColor(GameFontNormal:GetTextColor())
	coordText:SetShadowColor(GameFontNormal:GetShadowColor())
	coordText:SetShadowOffset(GameFontNormal:GetShadowOffset())
	coordText:SetPoint("BOTTOM", WorldMapFrame, "BOTTOM", 0, 10)

end

local timerID
function NavigatorFu:OnEnable()
    NavigatorFuMapFrame:Show()
    timerID = self:ScheduleRepeatingEvent(self.Update, 1, self)
end

function NavigatorFu:OnDisable()
    self:CancelScheduledEvent(timerID)
    NavigatorFuMapFrame:Hide()
end

function NavigatorFu:OnClick()
    ToggleWorldMap()
end

local playerCoords
function NavigatorFu:OnDataUpdate()
    local x,y = GetPlayerMapPosition("player")
    playerCoords = string.format("%.1f, %.1f", x*100, y*100)
end

function NavigatorFu:OnTextUpdate()
    self:SetText(playerCoords)
end

local OFFSET_X = 0.0022
local OFFSET_Y = -0.0262
function NavigatorFu:MapFrame_OnUpdate()
    local x, y = GetCursorPosition()

	-- Tweak coords so they are accurate
	local scale = WorldMapFrame:GetScale()
	x = x / scale
	y = y / scale
	local width = WorldMapButton:GetWidth()
	local height = WorldMapButton:GetHeight()
	local centerX, centerY = WorldMapFrame:GetCenter()
	local adjustedX = (x - (centerX - (width/2))) / width
	local adjustedY = (centerY + (height/2) - y) / height
	x = (adjustedX + OFFSET_X) * 100
	y = (adjustedY + OFFSET_Y) * 100

    NavigatorFuMapFrameCoordText:SetText(string.format(L.COORDFMTSTRING, x, y) .. playerCoords)
end

function NavigatorFu:OnTooltipUpdate()
    tablet:SetHint(L.HINT)
end
