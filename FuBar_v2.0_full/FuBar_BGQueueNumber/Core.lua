BGQueueNumber = AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceComm-2.0", "FuBarPlugin-2.0", "AceDebug-2.0", "AceEvent-2.0")
local L = AceLibrary("AceLocale-2.2"):new("FuBar_BGQueueNumber")
local BZ = AceLibrary("Babble-Zone-2.2")
local Tablet = AceLibrary("Tablet-2.0")

BGQueueNumber.timer = {}
-- BGQueueNumber.timer["localized BG"] = id-from-Ace-Event
BGQueueNumber.queue_numbers = {}
-- [[
-- BGQueueNumber.queue_numbers["localized BG"].before = int
-- BGQueueNumber.queue_numbers["localized BG"].after = int

BGQueueNumber.mycommPrefix = "BGQueueNumber"
BGQueueNumber.timertimeout = 5*60

BGQueueNumber.hasIcon = false
BGQueueNumber.hasNoColor = true
BGQueueNumber.defaultPosition = "MINIMAP"
BGQueueNumber.defaultMinimapPosition = 300
BGQueueNumber.cannotDetachTooltip = true

function BGQueueNumber:OnInitialize() -- {{{
    --self:SetDebugging(true)
    self:Debug("init")
    -- AceComm {{{
    self:SetCommPrefix(self.mycommPrefix)
    self:SetDefaultCommPriority("BULK")
    self:RegisterComm(self.mycommPrefix, "GLOBAL")
    -- }}}
    -- AceDB {{{
    self:RegisterDB("BGQueueNumberDB")
    -- }}}
    self:Debug("fertig")
end -- }}}

function BGQueueNumber:OnEnable() -- {{{
    -- AceEvent {{{
    self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
    -- }}}
    self:Debug("wurde aktiviert")
end -- }}} 

function BGQueueNumber:OnDisable() -- {{{
    self:Debug("wurde deaktiviert")
end -- }}}

function BGQueueNumber:OnCommReceive(prefix, sender, distribution, cmd, bg, instanceID, min, max, timer) -- {{{
    if not prefix == self.mycommPrefix then
        -- nothing for me
        return
    end
    if "TOKEN" == cmd then -- {{{
        -- have received a token send my status
        -- cycle througth my BG-queues and send them
        for i=1, MAX_BATTLEFIELD_QUEUES do
            local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
            if "none" == status or "error" == status or "active" == status then
                -- not in queue or playing, do nothing
            elseif minlevel ~= min or maxlevel ~= max then
                -- lvl doesn't match, do nothing
            elseif not BZ:HasReverseTranslation(mapName) or
                   BZ:GetReverseTranslation(mapName) ~= bg then
                -- BG-name doesn't match
            elseif instanceID ~= instID and 0 ~= instanceID and 0 ~= instID then
                -- instanceID doesn't match and none is 0
            else
                -- valid, send my BG-status
                if self:SendCommMessage("GLOBAL", "QUEUE", BZ:GetReverseTranslation(mapName), instID, minlevel, maxlevel, GetBattlefieldTimeWaited(i)) then
                    self:Debug("queue sent")
                else
                    self:Debug("queue not sent")
                end
                -- reset timer
                if self.timer[mapName] and self:IsEventScheduled(self.timer[mapName]) then
                    -- stop the old one
                    self:CancelScheduledEvent(self.timer[mapName])
                    self:Debug("timer "..mapName.." cancelled")
                end
                -- new timer
                self.timer[mapName] = self:ScheduleEvent(self.SendToken, self.timertimeout, self, mapName)
                self:Debug("timer "..mapName.." started")
                -- reset local counter
                self.queue_numbers[mapName] = {before = 0, after = 0}
                self:Debug("numers for "..mapName.." resetted")
            end
        end -- }}}
    elseif "QUEUE" == cmd then -- {{{
        -- have received a queue status from someone
        for i=1, MAX_BATTLEFIELD_QUEUES do
            local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
            if "none" == status or "error" == status or "active" == status then
                -- not in queue or playing, do nothing
            elseif minlevel ~= min or maxlevel ~= max then
                -- lvl doesn't match, do nothing
            elseif not BZ:HasReverseTranslation(mapName) or
                   BZ:GetReverseTranslation(mapName) ~= bg then
                -- BG-name doesn't match
            elseif instanceID ~= instID and 0 ~= instanceID and 0 ~= instID then
                -- instanceID doesn't match and none is 0
            else
                -- valid
                if GetBattlefieldTimeWaited(i) > timer then
                    -- i'm behind him
                    self.queue_numbers[mapName].before = self.queue_numbers[mapName].before + 1
                else
                    self.queue_numbers[mapName].after = self.queue_numbers[mapName].after + 1
                end
            end
        end -- }}}
    elseif "LEAVE" == cmd then -- {{{
        -- right now, noone sends this cmd
        for i=1, MAX_BATTLEFIELD_QUEUES do
            local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
            if "none" == status or "error" == status or "active" == status then
                -- not in queue or playing, do nothing
            elseif minlevel ~= min or maxlevel ~= max then
                -- lvl doesn't match, do nothing
            elseif not BZ:HasReverseTranslation(mapName) or
                   BZ:GetReverseTranslation(mapName) ~= bg then
                -- BG-name doesn't match
            elseif instanceID ~= instID and 0 ~= instanceID and 0 ~= instID then
                -- instanceID doesn't match and none is 0
            else
                -- valid
                if 0 == timer then
                    -- he leaved the queue, cannot determine if he was before or after me
                elseif GetBattlefieldTimeWaited(i) > timer then
                    -- i'm behind him
                    self.queue_numbers[mapName].before = self.queue_numbers[mapName].before - 1
                else
                    self.queue_numbers[mapName].after = self.queue_numbers[mapName].after - 1
                end
            end
        end -- }}}
    else
        -- invalid token or token of higher versions
    end
end -- }}}

function BGQueueNumber:UPDATE_BATTLEFIELD_STATUS() -- {{{
    self:Debug("etwas hat sich an den BGs getan")
    for i=1, MAX_BATTLEFIELD_QUEUES do
        local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
        if "none" == status or "error" == status or "active" == status then
            -- not in queue or playing
        else
            -- start a timer if needed
            self:Debug("start timer?")
            if not self.timer[mapName] or not self:IsEventScheduled(self.timer[mapName])then
                self:Debug("yes, start one")
                self.timer[mapName] = self:ScheduleEvent(self.SendToken, self.timertimeout, self, mapName)
            end
            -- add numbers if needed
            self:Debug("add numbers?")
            if not self.queue_numbers[mapName] then
                self:Debug("yes, add them")
                self.queue_numbers[mapName] = {before = 0, after = 0}
            end
        end
    end
end -- }}}

function BGQueueNumber:OnTooltipUpdate() -- {{{
    local cat = Tablet:AddCategory(
        'columns', 3
    )
    cat:AddLine(
        'text', L["Schlachtfeld"],
        'text2', L["Vor"],
        'text3', L["Nach"]
    )
    local in_queue = false
    for i=1, MAX_BATTLEFIELD_QUEUES do
        local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
        if "none" == status or "error" == status or "active" == status then
            -- no queue or playing
        elseif not BGQueueNumber.queue_numbers[mapName] then
            -- no data yet (but why...)
            assert(false, "No data for bg "..mapName)
        else
            cat:AddLine(
                'text', mapName,
                'text2', BGQueueNumber.queue_numbers[mapName].before,
                'text3', BGQueueNumber.queue_numbers[mapName].after
            )
            in_queue = true
        end
    end
    if not in_queue and false then
        cat:AddLine(
            'text', 'NOT_IN_QUEUE_LOCALE'
        )
    end
end
--[[
--Send a broadcast Token so other users should send they queue status
--]]
function BGQueueNumber:SendToken(bg) -- {{{
    self:Debug("start token send for "..tostring(bg))
    for i=1, MAX_BATTLEFIELD_QUEUES do
        local status, mapName, instID, minlevel, maxlevel = GetBattlefieldStatus(i);
        if bg == mapName then
            -- Send Token
            if BZ:HasReverseTranslation(mapName) then
                -- send token
                if self:SendCommMessage("GLOBAL", "TOKEN", BZ:GetReverseTranslation(mapName), instID, minlevel, maxlevel) then
                    self:Debug("Token sent")
                else
                    self:Debug("Token not sent")
                end
                -- send own status
                if self:SendCommMessage("GLOBAL", "QUEUE", BZ:GetReverseTranslation(mapName), instID, minlevel, maxlevel, GetBattlefieldTimeWaited(i)) then
                    self:Debug("status sent")
                else
                    self:Debug("status not sent")
                end
                -- reset timer
                if self.timer[mapName] and self:IsEventScheduled(self.timer[mapName]) then
                    -- stop the old one
                    self:CancelScheduledEvent(self.timer[mapName])
                    self:Debug("timer "..mapName.." cancelled")
                end
                -- new timer
                self.timer[mapName] = self:ScheduleEvent(self.SendToken, self.timertimeout, self, mapName)
                self:Debug("timer "..mapName.." started")
                -- reset local counter
                self.queue_numbers[mapName] = {before = 0, after = 0}
                self:Debug("numers for "..mapName.." resetted")
            else
                self:Debug("keine uebersetzung zu "..mapName.." gefunden")
            end
        end
    end
end -- }}}
