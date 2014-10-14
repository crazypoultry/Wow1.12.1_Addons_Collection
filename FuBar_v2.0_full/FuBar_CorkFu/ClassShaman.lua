
local _, c = UnitClass("player")
if c ~= "SHAMAN" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")


i = core:NewModule(B"Lightning Shield", buffs)
i.spell = B"Lightning Shield"
i.target = "Self"
