
local _, c = UnitClass("player")
if c ~= "PRIEST" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")


i = core:NewModule(B"Power Word: Fortitude", buffs)
i.target = "Friendly"
i.spell = B"Power Word: Fortitude"
i.multispell = B"Prayer of Fortitude"
i.ranklevels = {1,12,24,36,48,60}


i = core:NewModule(B"Touch of Weakness", buffs)
i.target = "Self"
i.spell = B"Touch of Weakness"


i = core:NewModule(B"Feedback", buffs)
i.spell = B"Feedback"
i.target = "Self"


i = core:NewModule(B"Inner Fire", buffs)
i.spell = B"Inner Fire"
i.target = "Self"


i = core:NewModule(B"Fear Ward", buffs)
i.spell = B"Fear Ward"
i.target = "Friendly"


i = core:NewModule(B"Divine Spirit", buffs)
i.target = "Friendly"
i.spell = B"Divine Spirit"
i.multispell = B"Prayer of Spirit"
i.ranklevels = {30,40,50,60}


i = core:NewModule(B"Shadow Protection", buffs)
i.target = "Friendly"
i.spell = B"Shadow Protection"
i.multispell = B"Prayer of Shadow Protection"
i.ranklevels = {30,42,56}
