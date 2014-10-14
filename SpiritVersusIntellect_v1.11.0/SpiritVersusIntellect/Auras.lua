-- Every Aura that affects a player's mana regeneration state changes at least one of
-- the following five fields:
--
--   Spirit:	The multiplier to the player's total spirit
--   Int:	The multiplier to the player's total int
--   Mana:	The multiplier to the player's maximum mana pool size
--   Regen:	How many times the normal regen rate the player regens when not casting
--   CastRegen:	What percent of regeneration applies while casting
--
-- NOTE: World of Warcraft does NOT cap CastRegen at 1.0.  It is possible to for this
-- value to excede 1.0, meaning the player regenerates mana faster while casting than
-- not casting.  Yes, this has been tested, and as of server patch 1.9.X, this bug/feature
-- still exists.


-- The Continue/Stop Casting sound effects
SVI_SOUND_CONTINUE_CASTING = "Sound\\Doodad\\BellTollAlliance.wav";
SVI_SOUND_STOP_CASTING = "Sound\\Doodad\\BellTollHorde.wav";


-- Racial abilities that change mana regeneration
SVI_ManaRegenRacials = {
	["Human"] = {
		-- +10% spirit
		[SVI_RACIAL_THE_HUMAN_SPIRIT] = {
			["Spirit"]	= 0.05,
		},
	},
	["Gnome"] = {
		-- +5% int
		[SVI_RACIAL_EXPANSIVE_MIND] = {
			["Int"]	= 0.05,
		},
	},
};

-- Talents that change mana regeneration
SVI_ManaRegenTalents = {
	["DRUID"] = {
		-- +4% int per point
		[SVI_TALENT_HEART_OF_THE_WILD] = {
			["Tree"] = 2,
			["Talent"] = 15,
			["Aura"] = {
				["Int"] = 0.04,
			},
		},
		-- +5% cast regen per point
		[SVI_TALENT_REFLECTION] = {
			["Tree"] = 3,
			["Talent"] = 6,
			["Aura"] = {
				["CastRegen"] = 0.05,
			},
		},
	},
	["MAGE"] = {
		-- +3% cast regen per point
		[SVI_TALENT_ARCANE_MEDITATION] = {
			["Tree"] = 1,
			["Talent"] = 12,
			["Aura"] = {
				["CastRegen"] = 0.03,
			},
		},
		-- +2% max mana per point
		[SVI_TALENT_ARCANE_MIND] = {
			["Tree"] = 1,
			["Talent"] = 14,
			["Aura"] = {
				["Mana"] = 0.02,
			},
		},
	},
	["PALADIN"] = {
		-- +2% int per point
		[SVI_TALENT_DIVINE_INTELLECT] = {
			["Tree"] = 1,
			["Talent"] = 2,
			["Aura"] = {
				["Int"] = 0.02,
			},
		},
	},
	["PRIEST"] = {
		-- +5% cast regen per point
		[SVI_TALENT_MEDITATION] = {
			["Tree"] = 1,
			["Talent"] = 8,
			["Aura"] = {
				["CastRegen"] = 0.05,
			},
		},
		-- +2% max mana per point
		[SVI_TALENT_MENTAL_STRENGTH] = {
			["Tree"] = 1,
			["Talent"] = 12,
			["Aura"] = {
				["Mana"] = 0.02,
			},
		},
	},
	["SHAMAN"] = {
		-- +1% max mana per point
		[SVI_TALENT_ANCESTRAL_KNOWLEDGE] = {
			["Tree"] = 2,
			["Talent"] = 1,
			["Aura"] = {
				["Mana"] = 0.01,
			},
		},
	},
	["WARLOCK"] = {
		-- -1% spirit per point
		[SVI_TALENT_DEMONIC_EMBRACE] = {
			["Tree"] = 2,
			["Talent"] = 3,
			["Aura"] = {
				["Spirit"] = -0.01,
			},
		},
	},
};

-- Equipment effects that change mana regeneration
SVI_ManaRegenEquip = {
	-- Increased regeneration while casting
	[SVI_SEARCH_CAST_REGEN] = {
		["CastRegen"] = 0.01,
	},
};

-- Buffs and debuffs that change mana regeneration
SVI_ManaRegenBuffs = {
	-- +100% cast regen
	[SVI_BUFF_AURA_OF_THE_BLUE_DRAGON] = {
		["Aura"] = {
			["CastRegen"] = 1.0,
		},
		["Sound"] = SVI_SOUND_CONTINUE_CASTING,
	},
	-- +10% spirit and int
	[SVI_BUFF_BLESSING_OF_KINGS] = {
		["Aura"] = {
			["Spirit"] = 0.1,
			["Int"] = 0.1,
		},
		["ConflictingBuffs"] = {
			[SVI_BUFF_GREATER_BLESSING_OF_KINGS] = true,
		},
	},
	-- +100% cast regen, +1500% mana regen
	[SVI_BUFF_EVOCATION] = {
		["Aura"] = {
			["Regen"] = 15.0,
			["CastRegen"] = 1.0,
		},
	},
	-- Removes Mage Armor
	[SVI_BUFF_FROST_ARMOR] = {
		["Aura"] = {
		},
		["ConflictingBuffs"] = {
			[SVI_BUFF_ICE_ARMOR] = true,
			[SVI_BUFF_MAGE_ARMOR] = true,
		},
	},
	-- +10% spirit and int
	[SVI_BUFF_GREATER_BLESSING_OF_KINGS] = {
		["Aura"] = {
			["Spirit"] = 0.1,
			["Int"] = 0.1,
		},
		["ConflictingBuffs"] = {
			[SVI_BUFF_BLESSING_OF_KINGS] = true,
		},
	},
	-- Removes Mage Armor
	[SVI_BUFF_ICE_ARMOR] = {
		["Aura"] = {
		},
		["ConflictingBuffs"] = {
			[SVI_BUFF_FROST_ARMOR] = true,
			[SVI_BUFF_MAGE_ARMOR] = true,
		},
	},
	-- +100% cast regen, +400% regen
	[SVI_BUFF_INNERVATE] = {
		["Aura"] = {
			["Regen"] = 4.0,
			["CastRegen"] = 1.0,
		},
		["Sound"] = SVI_SOUND_CONTINUE_CASTING,
	},
	-- +25% regen
	[SVI_BUFF_INVOCATION_OF_THE_WICKERMAN] = {
		["Aura"] = {
			["Regen"] = 0.25,
		},
	},
	-- +30% cast regen, Removes Ice Armor
	[SVI_BUFF_MAGE_ARMOR] = {
		["Aura"] = {
			["CastRegen"] = 0.3,
		},
		["ConflictingBuffs"] = {
			[SVI_BUFF_FROST_ARMOR] = true,
			[SVI_BUFF_ICE_ARMOR] = true,
		},
	},
	-- +50% cast regen, +100% regen
	[SVI_BUFF_SOUL_SIPHON] = {
		["Aura"] = {
			["Regen"] = 1.0,
			["CastRegen"] = 0.5,
		},
	},
	-- +50% cast regen, +100% regen
	[SVI_BUFF_SPIRIT_TAP] = {
		["Aura"] = {
			["Spirit"] = 1.0,
			["CastRegen"] = 0.5,
		},
	},

	-- -50% spirit and int
	[SVI_DEBUFF_ANCIENT_HYSTERIA] = {
		["Aura"] = {
			["Spirit"] = -0.5,
			["Int"] = -0.5,
		},
	},
	-- -25% spirit
	[SVI_DEBUFF_CURSE_OF_VENGEANCE] = {
		["Aura"] = {
			["Spirit"] = -0.25,
		},
	},
	-- -25% spirit and int
	[SVI_DEBUFF_DREDGE_SICKNESS] = {
		["Aura"] = {
			["Spirit"] = -0.25,
			["Int"] = -0.25,
		},
	},
	-- -50% spirit
	[SVI_DEBUFF_PUTRID_BREATH] = {
		["Aura"] = {
			["Spirit"] = -0.5,
		},
	},
	-- -20% int
	[SVI_DEBUFF_TAINTED_MIND] = {
		["Aura"] = {
			["Int"] = -0.2,
		},
	},
	-- -1% spirit and int
	[SVI_DEBUFF_WAILING_DEAD] = {
		["Aura"] = {
			["Spirit"] = -0.01,
			["Int"] = -0.01,
		},
	},
};
