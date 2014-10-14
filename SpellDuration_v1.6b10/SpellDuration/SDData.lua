----------------------------------------------------------------------------------------------------
-- Name		: Spell Duration [Data File]
-- Author	: Hunteryal & Mavet
-- EMail	: hunteryal@walla.com
----------------------------------------------------------------------------------------------------

-- Spells table
SDSpellsTable = {
	--[[
	name		(The name of the spell [Initialized by the localization table])
	duration	(How much time the spell last ?)
	targets		(The maximum number of bars that can be created for this spell per this targets [Max Value: SDGlobal.MaxBars])
	diminish	(Is this spell suffer from diminishing return)
	[If the value is false don't add it at all]
	aoe ? true			(Is this spell AoE based ?)
	casting ? true		(Is this spell delivered by casting ?)
	environment ? true	(Is this spell proc by the environment ?)
	]]--
	[SD_HUNTER] = {
		{
			-- Freezing Trap
			name = "", 
			duration = 0,
			targets = 1,
			diminish = true,
			environment = true,
		},
		{
			-- Scatter Shot
			name = "",
			duration = 4,
			targets = 1,
			diminish = false,
		},
		{
			-- Concussive Shot
			name = "",
			duration = 4,
			targets = 1,
			diminish = false,
		},
		{
			-- Improved Concussive Shot
			name = "",
			duration = 3,
			targets = 1,
			diminish = false,
			environment = true,
		},
		{
			-- Wing Clip
			name = "",
			duration = 10,
			targets = 2,
			diminish = false,
			
		},
		{
			-- Improved Wing Clip
			name = "",
			duration = 5,
			targets = 2,
			diminish = true,
			environment = true,
		},
		{
			-- Counterattack
			name = "",
			duration = 5,
			targets = 1,
			diminish = true,
		},
		-- Intimidation - texture: Ability_Devour
	},
	[SD_ROGUE] = {
		{
			-- Cheap Shot
			name = "",
			duration = 4,
			targets = 1,
			diminish = true,
		},
		{
			-- Gouge
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
		},
		{
			-- Kidney Shot
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
		},
		{
			-- Distract
			name = "",
			duration = 10,
			targets = 1,
			diminish = false,
			aoe = true,
		},
		{
			-- Sap
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
		},
		{
			-- Blind
			name = "",
			duration = 10,
			targets = 1,
			diminish = true,
		},
	},
	[SD_MAGE] = {
		{
			-- Polymorph
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
			casting = true,
		},
		{
			-- Frost Nova
			name = "",
			duration = 8,
			targets = 1,
			diminish = true,
			aoe = true,
		},
	},
	[SD_DRUID] = {
		{
			-- Entangling Roots
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
		},
		{
			-- Hibernate
			name = "",
			duration = 0,
			targets = 1,
			diminish = true,
		},
		{
			-- Faerie Fire
			name = "",
			duration = 40,
			targets = 2,
			diminish = false,
		},
		{
			-- Moonfire
			name = "",
			duration = 12,
			targets = 2,
			diminish = false,
		},
	},
	[SD_PRIEST] = {
		{
			-- Shackle Undead
			name = "",
			duration = 12,
			targets = 1,
			diminish = false,
			casting = true,
		},
	},
	[SD_SHAMAN] = {
	},
	[SD_PALADIN] = {
	},
	[SD_WARRIOR] = {
	},
	[SD_WARLOCK] = {
	},
 };
 
-- Talent table
SDTalentTable = {
	--[[
	[Index of the spell name from our localization file].name = {
		{
			rank (The rank of this spell in your spellbook)
			duration (The duration for this rank in your spellbook)
		}
	},
	[Index of the spell talent name from our localization file].talent = {
		{
			rank (The rank of this spell in your talent)
			duration (The duration for this rank in your talent)
			fraction {Is this spell duration in talent appears as a fraction ? true [If not don't add it at all]}
		}
	},
	]]--
	-- Freezing Trap
	[SDLocalizedSpellsTable[SD_HUNTER][1].name] = {
		{
			rank = 1,
			duration = 10,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 20,
		},
	},
	[SDLocalizedSpellsTable[SD_HUNTER][1].talent] = {
		{
			rank = 1,
			duration = 15,
			fraction = true,
		},
		{
			rank = 2,
			duration = 30,
			fraction = true,
		},
	},
	-- Gouge
	[SDLocalizedSpellsTable[SD_ROGUE][2].name] = { 
		{
			rank = 0,
			duration = 4,
		},
	},
	[SDLocalizedSpellsTable[SD_ROGUE][2].talent] = {
		{
			rank = 1,
			duration = 0.5,
		},
		{
			rank = 2,
			duration = 1,
		},
		{
			rank = 3,
			duration = 1.5,
		},
	},
	-- Sap
	[SDLocalizedSpellsTable[SD_ROGUE][5].name] = {
		{
			rank = 1,
			duration = 25,
		},
		{
			rank = 2,
			duration = 35,
		},
		{
			rank = 3,
			duration = 45,
		},
	},
	-- Kidney Shot
	[SDLocalizedSpellsTable[SD_ROGUE][3].name] = {
		{
			rank = 0,
			duration = 0,
		},
	},
	-- Polymorph
	[SDLocalizedSpellsTable[SD_MAGE][1].name] = {
		{
			rank = 1,
			duration = 20,
		},
		{
			rank = 2,
			duration = 30,
		},
		{
			rank = 3,
			duration = 40,
		},
		{
			rank = 4,
			duration = 50,
		},
	},
	-- Entangling Roots
	[SDLocalizedSpellsTable[SD_DRUID][1].name] = {
		{
			rank = 1,
			duration = 12,
		},
		{
			rank = 2,
			duration = 15,
		},
		{
			rank = 3,
			duration = 18,
		},
		{
			rank = 4,
			duration = 21,
		},
		{
			rank = 5,
			duration = 24,
		},
		{
			rank = 6,
			duration = 27,
		},
	},
	-- Hibernate
	[SDLocalizedSpellsTable[SD_DRUID][2].name] = {
		{
			rank = 1,
			duration = 20,
		},
		{
			rank = 2,
			duration = 30,
		},
		{
			rank = 3,
			duration = 40,
		},
	},
	-- Shackle Undead
	[SDLocalizedSpellsTable[SD_PRIEST][1].name] = {
		{
			rank = 1,
			duration = 30,
		},
		{
			rank = 2,
			duration = 40,
		},
		{
			rank = 3,
			duration = 50,
		},
	},
 };
 
-- Racial table
SDRacialTable = {
	-- War Stomp
	{
		name = "",
		duration = 2,
		clicked = false,	
	},
	-- Berserking
	{
		name = "",
		duration = 10,
		clicked = false,
		berserker = true,
	},
};
 
 -- Invetory table (Items, Sets that increase/decrease spells duration)
 SDInvetoryTable = {
	[SD_MAGE] = {
		-- Arcanist Regalia
		{
			item = "Arcanist Belt;Arcanist Bindings;Arcanist Crown;Arcanist Boots;Arcanist Gloves;Arcanist Leggings;Arcanist Mantle;Arcanist Robes",
			bonus = 5,
			-- Polymorph
			effect = SDLocalizedSpellsTable[SD_MAGE][1].name,
			duration = "15",
		},
	},
};