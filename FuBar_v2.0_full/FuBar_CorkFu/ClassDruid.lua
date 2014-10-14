
local _, c = UnitClass("player")
if c ~= "DRUID" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")


i = core:NewModule(B"Mark of the Wild", buffs)
i.target = "Friendly"
i.spell = B"Mark of the Wild"
i.multispell = B"Gift of the Wild"
i.ranklevels = {1,10,20,30,40,50,60}


i = core:NewModule(B"Thorns", buffs)
i.target = "Friendly"
i.spell = B"Thorns"
i.ranklevels = {6,14,24,34,44,54}


i = core:NewModule(B"Omen of Clarity", buffs)
i.spell = B"Omen of Clarity"
i.target = "Self"

