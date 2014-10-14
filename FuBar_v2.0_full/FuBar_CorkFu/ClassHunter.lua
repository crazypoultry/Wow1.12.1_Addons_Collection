
local _, c = UnitClass("player")
if c ~= "HUNTER" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")


i = core:NewModule(B"Trueshot Aura", buffs)
i.spell = B"Trueshot Aura"
i.target = "Self"


i = core:NewModule("Aspects", buffs)
i.target = "Self"
i.canstack = true
i.defaultspell = B"Aspect of the Hawk"
i.spells = {
	[B"Aspect of the Hawk"]    = true,
	[B"Aspect of the Beast"]   = true,
	[B"Aspect of the Monkey"]  = true,
	[B"Aspect of the Cheetah"] = true,
	[B"Aspect of the Pack"]    = true,
	[B"Aspect of the Wild"]    = true,
}

