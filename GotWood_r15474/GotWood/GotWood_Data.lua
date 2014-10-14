local BS = AceLibrary("Babble-Spell-2.0")
local L = AceLibrary("AceLocale-2.0"):new("GotWood")

L:RegisterTranslations("enUS", function() return {
    Mana_Trinket = "Enamored Water Spirit"
} end)

L:RegisterTranslations("deDE", function() return {
    Mana_Trinket = "Entz\195\188ckter Wassergeist"
} end)

GotWoodData = {}

GotWoodData[BS"Disease Cleansing Totem"] = {}
GotWoodData[BS"Disease Cleansing Totem"].duration = 120
GotWoodData[BS"Disease Cleansing Totem"].life = 5
GotWoodData[BS"Disease Cleansing Totem"].ele = "water"

GotWoodData[BS"Earthbind Totem"] = {}
GotWoodData[BS"Earthbind Totem"].duration = 45
GotWoodData[BS"Earthbind Totem"].life = 5
GotWoodData[BS"Earthbind Totem"].ele = "earth"

GotWoodData[BS"Fire Nova Totem"] = {}
GotWoodData[BS"Fire Nova Totem"].duration = 5
GotWoodData[BS"Fire Nova Totem"].life = 5
GotWoodData[BS"Fire Nova Totem"].ele = "fire"

GotWoodData[BS"Fire Resistance Totem"] = {}
GotWoodData[BS"Fire Resistance Totem"].duration = 120
GotWoodData[BS"Fire Resistance Totem"].life = 5
GotWoodData[BS"Fire Resistance Totem"].ele = "water"

GotWoodData[BS"Flametongue Totem"] = {}
GotWoodData[BS"Flametongue Totem"].duration = 120
GotWoodData[BS"Flametongue Totem"].life = 5
GotWoodData[BS"Flametongue Totem"].ele = "fire"

GotWoodData[BS"Frost Resistance Totem"] = {}
GotWoodData[BS"Frost Resistance Totem"].duration = 120
GotWoodData[BS"Frost Resistance Totem"].life = 5
GotWoodData[BS"Frost Resistance Totem"].ele = "fire"

GotWoodData[BS"Grace of Air Totem"] = {}
GotWoodData[BS"Grace of Air Totem"].duration = 120
GotWoodData[BS"Grace of Air Totem"].life = 5
GotWoodData[BS"Grace of Air Totem"].ele = "air"

GotWoodData[BS"Grounding Totem"] = {}
GotWoodData[BS"Grounding Totem"].duration = 45
GotWoodData[BS"Grounding Totem"].life = 5
GotWoodData[BS"Grounding Totem"].ele = "air"

GotWoodData[BS"Healing Stream Totem"] = {}
GotWoodData[BS"Healing Stream Totem"].duration = 60
GotWoodData[BS"Healing Stream Totem"].life = 5
GotWoodData[BS"Healing Stream Totem"].ele = "water"

GotWoodData[BS"Magma Totem"] = {}
GotWoodData[BS"Magma Totem"].duration = 20
GotWoodData[BS"Magma Totem"].life = 5
GotWoodData[BS"Magma Totem"].ele = "fire"

GotWoodData[BS"Mana Spring Totem"] = {}
GotWoodData[BS"Mana Spring Totem"].duration = 60
GotWoodData[BS"Mana Spring Totem"].life = 5
GotWoodData[BS"Mana Spring Totem"].ele = "water"

GotWoodData[BS"Mana Tide Totem"] = {}
GotWoodData[BS"Mana Tide Totem"].duration = 12
GotWoodData[BS"Mana Tide Totem"].life = 5
GotWoodData[BS"Mana Tide Totem"].ele = "water"

GotWoodData[BS"Nature Resistance Totem"] = {}
GotWoodData[BS"Nature Resistance Totem"].duration = 120
GotWoodData[BS"Nature Resistance Totem"].life = 5
GotWoodData[BS"Nature Resistance Totem"].ele = "air"

GotWoodData[BS"Poison Cleansing Totem"] = {}
GotWoodData[BS"Poison Cleansing Totem"].duration = 120
GotWoodData[BS"Poison Cleansing Totem"].life = 5
GotWoodData[BS"Poison Cleansing Totem"].ele = "water"

GotWoodData[BS"Searing Totem"] = {}
GotWoodData[BS"Searing Totem"].life = 5
GotWoodData[BS"Searing Totem"].ele = "fire"
GotWoodData[BS"Searing Totem"][1] = {}
GotWoodData[BS"Searing Totem"][1].duration = 30
GotWoodData[BS"Searing Totem"][2] = {}
GotWoodData[BS"Searing Totem"][2].duration = 35
GotWoodData[BS"Searing Totem"][3] = {}
GotWoodData[BS"Searing Totem"][3].duration = 40
GotWoodData[BS"Searing Totem"][4] = {}
GotWoodData[BS"Searing Totem"][4].duration = 45
GotWoodData[BS"Searing Totem"][5] = {}
GotWoodData[BS"Searing Totem"][5].duration = 50
GotWoodData[BS"Searing Totem"][6] = {}
GotWoodData[BS"Searing Totem"][6].duration = 55

GotWoodData[BS"Sentry Totem"] = {}
GotWoodData[BS"Sentry Totem"].duration = 300
GotWoodData[BS"Sentry Totem"].life = 5
GotWoodData[BS"Sentry Totem"].ele = "air"

GotWoodData[BS"Stoneclaw Totem"] = {}
GotWoodData[BS"Stoneclaw Totem"].duration = 15
GotWoodData[BS"Stoneclaw Totem"].life = 486
GotWoodData[BS"Stoneclaw Totem"].ele = "earth"

GotWoodData[BS"Strength of Earth Totem"] = {}
GotWoodData[BS"Strength of Earth Totem"].duration = 120
GotWoodData[BS"Strength of Earth Totem"].life = 5
GotWoodData[BS"Strength of Earth Totem"].ele = "earth"

GotWoodData[BS"Stoneskin Totem"] = {}
GotWoodData[BS"Stoneskin Totem"].duration = 120
GotWoodData[BS"Stoneskin Totem"].life = 5
GotWoodData[BS"Stoneskin Totem"].ele = "earth"

GotWoodData[BS"Tranquil Air Totem"] = {}
GotWoodData[BS"Tranquil Air Totem"].duration = 120
GotWoodData[BS"Tranquil Air Totem"].life = 5
GotWoodData[BS"Tranquil Air Totem"].ele = "air"

GotWoodData[BS"Tremor Totem"] = {}
GotWoodData[BS"Tremor Totem"].duration = 120
GotWoodData[BS"Tremor Totem"].life = 5
GotWoodData[BS"Tremor Totem"].ele = "earth"

GotWoodData[BS"Windfury Totem"] = {}
GotWoodData[BS"Windfury Totem"].duration = 120
GotWoodData[BS"Windfury Totem"].life = 5
GotWoodData[BS"Windfury Totem"].ele = "air"

GotWoodData[BS"Windwall Totem"] = {}
GotWoodData[BS"Windwall Totem"].duration = 120
GotWoodData[BS"Windwall Totem"].life = 5
GotWoodData[BS"Windwall Totem"].ele = "air"

GotWoodData[L"Mana_Trinket"] = {}
GotWoodData[L"Mana_Trinket"].duration = 24
GotWoodData[L"Mana_Trinket"].life = 5
GotWoodData[L"Mana_Trinket"].ele = "water"
GotWoodData[L"Mana_Trinket"].icon = "Interface\\Icons\\INV_Wand_01"