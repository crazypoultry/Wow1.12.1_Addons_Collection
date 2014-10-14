local _, c = UnitClass("player")
if c ~= "WARLOCK" then return end

local B = AceLibrary("Babble-Spell-2.0")
local core, i = FuBar_CorkFu
local buffs = core:GetTemplate("Buffs")

i = core:NewModule(B"Demon Armor", buffs)
i.spell = B"Demon Armor"
i.target = "Self"
i.defaultspell = B"Demon Armor"
i.spells = {
	[B"Demon Armor"] = true,
	[B"Demon Skin"] = true,
}

i = core:NewModule(B"Detect Invisibility", buffs)
i.target = "Friendly"
i.spell = B"Detect Greater Invisibility"
i.defaultspell = B"Detect Greater Invisibility"
i.spells = {
    [B"Detect Greater Invisibility"] = true,
    [B"Detect Invisibility"] = true,
    [B"Detect Lesser Invisibility"] = true,
}

i = core:NewModule(B"Unending Breath", buffs)
i.target = "Friendly"
i.spell = "Unending Breath"

