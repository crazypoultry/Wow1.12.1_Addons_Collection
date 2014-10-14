--[[--------------------------------------------------------------------------------------------

MozzSoundVolumeFix.lua
MozzPack version 1.07 released 20051012

This AddOn is a standalone fix for the bug where sound volume is too loud after alt-tabbing.

- By default, this will "fix" the sound volume every frame.  If you experience lag which you
- think is caused by this AddOn, you can change the "= 1" to "= 0" on the line below, and
- reload your UI, and bind a key to the "Fix Sound Volume" in the Miscellaneous section instead.

--]]--------------------------------------------------------------------------------------------

-- change this to 0 if you prefer to use the key binding and only fix volume when its pressed.
local autoFixSoundVolume = 1

------------------------------------------------------------------------------------------------

BINDING_HEADER_SOUNDVOLUMEFIX = "Fix Sound Volume"
BINDING_NAME_SOUNDVOLUMEFIX = "Fix Sound Volume"

function FixSoundVolume()
    local svol = GetCVar("MasterVolume")+0
    if (svol > 0.5) then
        SetCVar("MasterVolume", svol-0.05)
    else
        SetCVar("MasterVolume", svol+0.05)
    end
    SetCVar("MasterVolume", svol)
end

local old_WorldFrame_OnUpdate = WorldFrame_OnUpdate;
function WorldFrame_OnUpdate(elapsed)
    old_WorldFrame_OnUpdate(elapsed)
    if autoFixSoundVolume==1 then FixSoundVolume() end
end

------------------------------------------------------------------------------------------------

-- end of file
