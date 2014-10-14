--[[
    Serious Buff Timers!
        "How serious?" "Very serious!" "No, I meant 'Why serious?'" "Because Blizzy's %d m crap is... sarcastic?"
    
    Based on DoppelGanger_BuffTimers, by Kayde, which is in turn based on Edswor's TimerBuff
--]]

-- Hook Blizzy's function. What? You want to hook it too? TOUGH TITTIES!

local math_mod = math.mod or math.fmod

function SecondsToTimeAbbrev(time)
    local m, s
    if( time <= 0 ) then
        return "";
    elseif time < 60 then
        return string.format("%d", time);
    elseif( time < 3600 ) then
        m = math.floor(time / 60)
        s = math_mod(time, 60)
        return string.format("%d:%02d", m, s);
    else
        local hr = math.floor(time / 3600)
        m = math.floor( math.mod(time, 3600) / 60 )
        return string.format("%d.%02dhr", hr, m);
    end
end
