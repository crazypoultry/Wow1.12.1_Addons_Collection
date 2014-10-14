--[[
    MiniPerfsFu!
        "ONOES DISCORD IS ATEING AL MEH SOFTDRIVE ROFLMAOAFK!!!!!"

    Based on PerformanceFu
--]]

MiniPerfsFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "FuBarPlugin-2.0")

local tablet = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local abacus = AceLibrary("Abacus-2.0")
local crayon = AceLibrary("Crayon-2.0")

MiniPerfsFu:RegisterDB("MiniPerfsFuDB")

MiniPerfsFu.hasIcon = true

local L = { -- L for Locals!
    OTHERMEMORYINFO = "Other Memory Info",
    INITIALMEMORY = "Initial Memory:",
    AVERAGEINCREASINGRATE = "Average Increasing Rate:",
    GARBAGECOLLECTTHRESHOLD = "Garbage Collect Threshold:",
    TIMETONEXTGARBAGECOLLECT = "Time to Next Garbage Collect:",
    HINT = "Click to run the garbage collector",
}

function MiniPerfsFu:OnMenuRequest()
    dewdrop:AddLine(
        'text', "Short text",
        'func', function()
            self.db.profile.shortText = not self.db.profile.shortText
            self:Update()
        end,
        'checked', self.db.profile.shortText
    )
end

-- Choo choo! Here comes the local train!
local initialMemory, gcThreshold, currentMemory, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10, timeSinceLastUpdate, gcTime, justEntered

function MiniPerfsFu:OnInitialize()
    initialMemory, gcThreshold = gcinfo()
	currentMemory = initialMemory
	mem1 = currentMemory
	mem2 = currentMemory
	mem3 = currentMemory
	mem4 = currentMemory
	mem5 = currentMemory
	mem6 = currentMemory
	mem7 = currentMemory
	mem8 = currentMemory
	mem9 = currentMemory
	mem10 = currentMemory
	timeSinceLastUpdate = 0
	gcTime = time()
	justEntered = true
end

local timerID
function MiniPerfsFu:OnEnable()
    timerID = self:ScheduleRepeatingEvent(self.OnUpdate, 1, self)
end

function MiniPerfsFu:OnDisable()
    self:CancelScheduledEvent(timerID)
end

function MiniPerfsFu:OnClick()
    collectgarbage()
end

function MiniPerfsFu:OnUpdate(difference)
	if justEntered == true then
		timeSinceLastUpdate = (timeSinceLastUpdate or 0) + arg1 -- arg1 SHOULD be the time since the last OnUpdate. Yay for it being global!
		if timeSinceLastUpdate >= 10 then
			initialMemory, gcThreshold = gcinfo()
			currentMemory = initialMemory
			mem1 = currentMemory
			mem2 = currentMemory
			mem3 = currentMemory
			mem4 = currentMemory
			mem5 = currentMemory
			mem6 = currentMemory
			mem7 = currentMemory
			mem8 = currentMemory
			mem9 = currentMemory
			mem10 = currentMemory
			timeSinceLastUpdate = nil
			gcTime = time()
			justEntered = false
		end
	else
		local t = time()
		timeSinceLastUpdate = 0
		mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9, mem10 = currentMemory, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9
        currentMemory, gcThreshold = gcinfo()
		if mem1 > currentMemory then
			initialMemory = currentMemory
			gcTime = t
			mem10, mem9, mem9, mem8, mem7, mem6, mem5, mem4, mem3, mem2, mem1 = currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory, currentMemory
		end

		self:Update()
	end
end

local _, framerate, latency, currMem, memRate

function MiniPerfsFu:OnDataUpdate()
    local shortText = self.db.profile.shortText

    if not initialMemory then ChatFrame1:AddMessage("EOGJOJSGJSDOSDJOSDOFJO"); self:OnInitialize() end -- FBP2 wants to run OnDataUpdate BEFORE OnInit/Enable >.>

    mem10 = mem10 or currentMemory

	framerate = math.floor(GetFramerate() + 0.5)
    framerate =  string.format(shortText and "|cff%s%d|r" or "|cff%s%d|r fps", crayon:GetThresholdHexColor(framerate / 60), framerate)
    
    _,_,latency = GetNetStats()
	latency = string.format(shortText and "|cff%s%d|r" or "|cff%s%d|r ms", crayon:GetThresholdHexColor(latency, 1000, 500, 250, 100, 0), latency)

	currMem = string.format(shortText and "|cff%s%.1f|r" or "|cff%s%.1f|r MiB", crayon:GetThresholdHexColor(currentMemory, 51200, 40960, 30520, 20480, 10240), currentMemory / 1024)

    memRate = (currentMemory - mem10) / 10
    memRate = string.format(shortText and "|cff%s%.1f|r" or "|cff%s%.1f|r KiB/s", crayon:GetThresholdHexColor(memRate, 30, 10, 3, 1, 0), memRate)
end


function MiniPerfsFu:OnTextUpdate()
    if self.db.profile.shortText then   
        self:SetText(framerate .."/".. latency  .."/"..  currMem  .."/"..  memRate)
    else
        self:SetText(framerate .. " " .. latency .. " " .. currMem .. " " .. memRate)
    end
end

function MiniPerfsFu:OnTooltipUpdate()
    local cat = tablet:AddCategory(
        'text', L.OTHERMEMORYINFO,
		'columns', 2,
		'child_textR', 1,
		'child_textG', 1,
		'child_textB', 0
	)

    local r, g, b = crayon:GetThresholdColor(initialMemory, 51200, 40960, 30520, 20480, 10240)
	cat:AddLine(
		'text', L.INITIALMEMORY,
		'text2', string.format("%.1f MiB", initialMemory / 1024),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)

    local averageRate = (currentMemory - initialMemory) / (time() - gcTime)
    r, g, b = crayon:GetThresholdColor(averageRate, 30, 10, 3, 1, 0)
	cat:AddLine(
		'text', L.AVERAGEINCREASINGRATE,
		'text2', string.format("%.1f KiB/s", averageRate),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)

    r, g, b = crayon:GetThresholdColor(gcThreshold, 51200, 40960, 30520, 20480, 10240)
	cat:AddLine(
		'text', L.GARBAGECOLLECTTHRESHOLD,
		'text2', string.format("%.1f MiB", gcThreshold / 1024),
		'text2R', r,
		'text2G', g,
		'text2B', b
	)

    local totalSecs = (gcThreshold - currentMemory) / averageRate
	local timeToNext = abacus:FormatDurationFull(totalSecs)
	r, g, b = crayon:GetThresholdColor(totalSecs, 0, 900, 1800, 2700, 3600)
	cat:AddLine(
		'text', L.TIMETONEXTGARBAGECOLLECT,
		'text2', timeToNext,
		'text2R', r,
		'text2G', g,
		'text2B', b
	)
    
    tablet:SetHint(L.HINT)
end
