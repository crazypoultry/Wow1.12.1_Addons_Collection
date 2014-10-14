local L = AceLibrary("AceLocale-2.2"):new("DakSmak")

L:RegisterTranslations("deDE", function() return {
		["Slash-Commands"] = { "/daksmak", "/ds" },		-- No slash commands in this addon yet.
		
		-- Headings
		["Attack Table"]	= true,
		["AttTblAbb"]		= "Att",			-- Abbreviation for "Attack Table"
		["Defend Table"]	= true,
		["DefTblAbb"]		= "Def",			-- Abbreviation for "Defend Table"
		
		-- Spell Names
		["Attack"]			= true,
		
		-- Outcome labels for tables
		["Miss"]			= true,
		["M"]				= true,
		["Dodge"]			= true,
		["D"]				= true,
		["Parry"]			= true,
		["P"]				= true,
		["Block"]			= true,
		["B"]				= true,
		["Glance"]			= true,
		["G"]				= true,
		["Crush"]			= true,
		["Csh"]				= true,
		["Crit"]			= true,
		["Crt"]				= true,
		["Hit"]				= true,
		["H"]				= true,
		["Weapon Skill"]	= true,
		["WepSkilAbb"]		= "Att",			-- Abbreviation for "Weapon Skill"
		["Defensive Skill"]	= true,
		["DefSkilAbb"]		= "Def",			-- Abbreviation for "Defensive Skill"
		["Glance/Crush"]	= true,				-- Used with horizontal orientation
		["G/C"]				= true,				-- Abbreviation for "Glance/Crush"
		
		-- UnitID for player and target
		["player"]			= true,
		["target"]			= true,
		
		-- Identifiers for equippable slots.  (Don't know if these need localization)
		["SecondaryHandSlot"]	= true,		
		["Shields"]				= true,
		} 
end)
	