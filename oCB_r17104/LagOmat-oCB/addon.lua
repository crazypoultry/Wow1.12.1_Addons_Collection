local oldUseAction
local bar
local factor = 0.66

local addon = {}

function addon:PLAYER_ENTERING_WORLD()
    this:RegisterEvent("SPELLCAST_START")
    this:RegisterEvent("SPELLCAST_STOP")
    this:UnregisterEvent("PLAYER_ENTERING_WORLD")

    oldUseAction = UseAction
    UseAction = self.UseAction

    bar = oCB.frames.CastingBar
    bar.Lag = bar:CreateTexture(nil, "OVERLAY")
    bar.Lag:SetTexture(1, 0, 0, 0.4)
end

function addon:SPELLCAST_START(arg1, arg2)
    self.duration = arg2 / 1000

    if (self.start and self.duration) then
        self.lag = GetTime() - self.start

        if (self.lag / self.duration) < 1 then
            bar.Lag:SetWidth(self.lag * factor / self.duration * bar:GetWidth())
            bar.Lag:SetHeight(bar.Bar:GetHeight())
            bar.Lag:ClearAllPoints()
            if oCB.channeling then
                bar.Lag:SetPoint("LEFT", bar.Bar, "LEFT", 0, 0)
            else
                bar.Lag:SetPoint("RIGHT", bar.Bar, "RIGHT", 0, 0)
            end
        end
    end
end

function addon:SPELLCAST_STOP(arg1, arg2)
    self.duration = nil
end

function addon.UseAction(slot, checkCursor, onSelf)
    if addon.duration then	-- we are casting
        if oCB.maxValue - self.lag * factor < GetTime() then -- we are within the red area
            SpellStopCasting()
            addon.duration = nil
        end
    else
        addon.start = GetTime()
    end

    oldUseAction(slot, checkCursor, onSelf)
end

-- Initialization
addon.frame = CreateFrame("Frame", nil, UIParent)
addon.frame:SetScript("OnEvent", function() addon[event](addon, arg1, arg2) end)
addon.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
