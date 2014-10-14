
local _, c = UnitClass("player")
if c ~= "MAGE" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")


i = core:NewModule(B"Arcane Intellect", buffs)
i.target = "Friendly"
i.spell = B"Arcane Intellect"
i.multispell = B"Arcane Brilliance"
i.ranklevels = {1,14,28,42,56}


i = core:NewModule(B"Mana Shield", buffs)
i.spell = B"Mana Shield"
i.target = "Self"


i = core:NewModule("Armor", buffs)
i.target = "Self"
i.defaultspell = B"Frost Armor"
i.spells = {
	[B"Ice Armor"]   = true,
	[B"Frost Armor"] = true,
	[B"Mage Armor"]  = true,
}


i = core:NewModule("Amplify/Dampen Magic", buffs)
i.target = "Raid"
i.defaultspell = B"Dampen Magic"
i.spells = {
	[B"Amplify Magic"] = {18,30,42,54},
	[B"Dampen Magic"] = {12,24,36,48,60},
}
