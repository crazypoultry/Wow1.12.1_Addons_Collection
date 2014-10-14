
---------------------------------------------------------------------
--			French
---------------------------------------------------------------------

if ( GetLocale() == "frFR" ) then
	Nurfed_DKPValues.stats = {
		[0] = { stat = "Stamina", list = "+(%d+) "..SPELL_STAT2_NAME },
		[1] = { stat = "Strength", list = "+(%d+) "..SPELL_STAT0_NAME },
		[2] = { stat = "Agility", list = "+(%d+) "..SPELL_STAT1_NAME },
		[3] = { stat = "Intellect", list = "+(%d+) "..SPELL_STAT3_NAME },
		[4] = { stat = "Spirit", list = "+(%d+) "..SPELL_STAT4_NAME },
		[5] = { stat = "SpellResistance", list = "+(%d+) (.+) "..RESISTANCE_LABEL },
		[6] = { stat = "ManaRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana per 5 sec" },
		[7] = { stat = "HealthRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) health every 5 sec" },
		[8] = { stat = "AllSpells", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[9] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[10] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing done by spells and effects by up to" },
		[11] = { stat = "SingleSpell", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage done by (.+) spells and effects by up to" },
		[12] = { stat = "SpellCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by" },
		[13] = { stat = "SpellCritSingle", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases the critical effect chance of your (.+) spells by" },
		[14] = { stat = "SpellHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit with spells by" },
		[15] = { stat = "AttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) "..ATTACK_POWER_TOOLTIP },
		[16] = { stat = "RangedAttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) ranged Attack Power" },
		[17] = { stat = "MeleeCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike by" },
		[18] = { stat = "MeleeHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit by" },
		[19] = { stat = "Parry", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to parry an attack by" },
		[20] = { stat = "Dodge", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to dodge an attack by" },
		[21] = { stat = "Defense", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increased Defense (+%d+)" },
		[22] = { stat = "SpellPierce", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Decreases the magical resistances of your spell targets by" },
	};

	Nurfed_DKPValues.caster = {
		[0] = "+(%d+) "..SPELL_STAT3_NAME,
		[1] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing",
		[2] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing",
		[3] = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by",
		[4] = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana every 5 sec",
	};

	Nurfed_DKPValues.weapons = {
		[INVTYPE_WEAPON] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		["Bow"] = true,
		["Gun"] = true,
		["Crossbow"] = true,
		[INVTYPE_RANGED] = true,
		["Wand"] = true,
	};

	Nurfed_DKPValues.warweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.16, sub = 86.71},
			["Sword"] = { dps = 0.81, top = 0.18, sub = 87.98},
			["Mace"] = { dps = 0.86, top = 0.17, sub = 86.76},
			["Polearm"] = { dps = 0.85, top = 0.18, sub = 86.01},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0.22, sub = 72.10},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0, sub = 66.68},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0, sub = 66.68},
		},
	};

	Nurfed_DKPValues.rogueweap = {
		[INVTYPE_WEAPON] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0.30, sub = 84.62},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Sword"] = { dps = 1.04, top = 0, sub = 39.84},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0, sub = 39.84},
		},
	};

	Nurfed_DKPValues.hybridweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.22, sub = 101.4},
			["Mace"] = { dps = 0.86, top = 0.23, sub = 101.43},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
			["Fist Weapon"] = { dps = 0.96, top = 0.54, sub = 87.77},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Fist Weapon"] = { dps = 0.97, top = 0.54, sub = 87.09},
		},
	};

	Nurfed_DKPValues.hunterweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, sub = 45.03},
			["Sword"] = { dps = 0.81, sub = 46.44},
			["Polearm"] = { dps = 0.85, sub = 46.15},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.96, sub = 38},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.03},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.97, sub = 37.87},
		},
	};

	Nurfed_DKPValues.rangedweap = {
		["Bow"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Gun"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Crossbow"] = { dps = 1.4, top = 0.2, sub = 52.52 },
	};

	Nurfed_DKPValues.rangedmelee = {
		["Bow"] = { dps = 1.01, sub = 32.20 },
		["Gun"] = { dps = 1.01, sub = 32.20 },
		["Crossbow"] = { dps = 1.01, sub = 32.20 },
	};

	Nurfed_DKPValues.static = {
		["Head of Nefarian"] = 13.247,
		["Head of Onyxia"] = 9.312,
		["Ancient Petrified Leaf"] = 22.047,
		["Mature Black Dragon Sinew"] = 22.047,
		["The Eye of Divinity"] = 20.052,
		["Eye of Sulfuras"] = 101.062,
		["Bindings of the Windseeker"] = 31.815,
		["Talisman of Ephemeral Power"] = 25.200,
		["Aegis of Preservation"] = 3.000,
		["Arcane Infused Gem"] = 1.092,
		["Lifegiving Gem"] = 7.500 ,
		["Mind Quickening Gem"] = 13.393,
		["Natural Alignment Crystal"] = 10.714,
		["Rune of Metamorphosis"] = 2.229,
		["The Black Book"] = 5.000,
		["Venemous Totem"] = 1.500,
		["Essence of the Pure Flame"] = 1.000,
	};

	Nurfed_DKPValues.multi = {
		["Thunderfury, Blessed Blade of the Windseeker"] = 2.4,
		["Spinal Reaper"] = 1.25,
		["Eskhandar's Left Claw"] = 1.25,
		["Empyrean Demolisher"] = 1.2,
		["Eskhandar's Right Claw"] = 1.15,
		["The Untamed Blade"] = 1.15,
		["Perdition's Blade"] = 1.1,
		["Vis'kag the Bloodletter"] = 1.1,
		["Earthshaker"] = 1.1,
		["Shadowstrike"] = 1.1,
		["Drake Talon Cleaver"] = 1.1,
		["Ancient Cornerstone Grimoire"] = 1.05,
		["Sulfuras, Hand of Ragnaros"] = 1.05,
		["Deathbringer"] = 1.05,
		["Gutgore Ripper"] = 1.05,
	};

---------------------------------------------------------------------
--			German
---------------------------------------------------------------------

elseif ( GetLocale() == "deDE" ) then
	Nurfed_DKPValues.stats = {
		[0] = { stat = "Stamina", list = "+(%d+) "..SPELL_STAT2_NAME },
		[1] = { stat = "Strength", list = "+(%d+) "..SPELL_STAT0_NAME },
		[2] = { stat = "Agility", list = "+(%d+) "..SPELL_STAT1_NAME },
		[3] = { stat = "Intellect", list = "+(%d+) "..SPELL_STAT3_NAME },
		[4] = { stat = "Spirit", list = "+(%d+) "..SPELL_STAT4_NAME },
		[5] = { stat = "SpellResistance", list = "+(%d+) (.+) "..RESISTANCE_LABEL },
		[6] = { stat = "ManaRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana per 5 sec" },
		[7] = { stat = "HealthRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) health every 5 sec" },
		[8] = { stat = "AllSpells", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[9] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[10] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing done by spells and effects by up to" },
		[11] = { stat = "SingleSpell", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage done by (.+) spells and effects by up to" },
		[12] = { stat = "SpellCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by" },
		[13] = { stat = "SpellCritSingle", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases the critical effect chance of your (.+) spells by" },
		[14] = { stat = "SpellHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit with spells by" },
		[15] = { stat = "AttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) "..ATTACK_POWER_TOOLTIP },
		[16] = { stat = "RangedAttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) ranged Attack Power" },
		[17] = { stat = "MeleeCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike by" },
		[18] = { stat = "MeleeHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit by" },
		[19] = { stat = "Parry", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to parry an attack by" },
		[20] = { stat = "Dodge", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to dodge an attack by" },
		[21] = { stat = "Defense", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increased Defense (+%d+)" },
		[22] = { stat = "SpellPierce", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Decreases the magical resistances of your spell targets by" },
	};

	Nurfed_DKPValues.caster = {
		[0] = "+(%d+) "..SPELL_STAT3_NAME,
		[1] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing",
		[2] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing",
		[3] = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by",
		[4] = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana every 5 sec",
	};

	Nurfed_DKPValues.weapons = {
		[INVTYPE_WEAPON] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		["Bow"] = true,
		["Gun"] = true,
		["Crossbow"] = true,
		[INVTYPE_RANGED] = true,
		["Wand"] = true,
	};

	Nurfed_DKPValues.warweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.16, sub = 86.71},
			["Sword"] = { dps = 0.81, top = 0.18, sub = 87.98},
			["Mace"] = { dps = 0.86, top = 0.17, sub = 86.76},
			["Polearm"] = { dps = 0.85, top = 0.18, sub = 86.01},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0.22, sub = 72.10},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0, sub = 66.68},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0, sub = 66.68},
		},
	};

	Nurfed_DKPValues.rogueweap = {
		[INVTYPE_WEAPON] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0.30, sub = 84.62},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Sword"] = { dps = 1.04, top = 0, sub = 39.84},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0, sub = 39.84},
		},
	};

	Nurfed_DKPValues.hybridweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.22, sub = 101.4},
			["Mace"] = { dps = 0.86, top = 0.23, sub = 101.43},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
			["Fist Weapon"] = { dps = 0.96, top = 0.54, sub = 87.77},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Fist Weapon"] = { dps = 0.97, top = 0.54, sub = 87.09},
		},
	};

	Nurfed_DKPValues.hunterweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, sub = 45.03},
			["Sword"] = { dps = 0.81, sub = 46.44},
			["Polearm"] = { dps = 0.85, sub = 46.15},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.96, sub = 38},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.03},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.97, sub = 37.87},
		},
	};

	Nurfed_DKPValues.rangedweap = {
		["Bow"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Gun"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Crossbow"] = { dps = 1.4, top = 0.2, sub = 52.52 },
	};

	Nurfed_DKPValues.rangedmelee = {
		["Bow"] = { dps = 1.01, sub = 32.20 },
		["Gun"] = { dps = 1.01, sub = 32.20 },
		["Crossbow"] = { dps = 1.01, sub = 32.20 },
	};

	Nurfed_DKPValues.static = {
		["Head of Nefarian"] = 13.247,
		["Head of Onyxia"] = 9.312,
		["Ancient Petrified Leaf"] = 22.047,
		["Mature Black Dragon Sinew"] = 22.047,
		["The Eye of Divinity"] = 20.052,
		["Eye of Sulfuras"] = 101.062,
		["Bindings of the Windseeker"] = 31.815,
		["Talisman of Ephemeral Power"] = 25.200,
		["Aegis of Preservation"] = 3.000,
		["Arcane Infused Gem"] = 1.092,
		["Lifegiving Gem"] = 7.500 ,
		["Mind Quickening Gem"] = 13.393,
		["Natural Alignment Crystal"] = 10.714,
		["Rune of Metamorphosis"] = 2.229,
		["The Black Book"] = 5.000,
		["Venemous Totem"] = 1.500,
		["Essence of the Pure Flame"] = 1.000,
	};

	Nurfed_DKPValues.multi = {
		["Thunderfury, Blessed Blade of the Windseeker"] = 2.4,
		["Spinal Reaper"] = 1.25,
		["Eskhandar's Left Claw"] = 1.25,
		["Empyrean Demolisher"] = 1.2,
		["Eskhandar's Right Claw"] = 1.15,
		["The Untamed Blade"] = 1.15,
		["Perdition's Blade"] = 1.1,
		["Vis'kag the Bloodletter"] = 1.1,
		["Earthshaker"] = 1.1,
		["Shadowstrike"] = 1.1,
		["Drake Talon Cleaver"] = 1.1,
		["Ancient Cornerstone Grimoire"] = 1.05,
		["Sulfuras, Hand of Ragnaros"] = 1.05,
		["Deathbringer"] = 1.05,
		["Gutgore Ripper"] = 1.05,
	};

---------------------------------------------------------------------
--			English
---------------------------------------------------------------------

else
	Nurfed_DKPValues.stats = {
		[0] = { stat = "Stamina", list = "+(%d+) "..SPELL_STAT2_NAME },
		[1] = { stat = "Strength", list = "+(%d+) "..SPELL_STAT0_NAME },
		[2] = { stat = "Agility", list = "+(%d+) "..SPELL_STAT1_NAME },
		[3] = { stat = "Intellect", list = "+(%d+) "..SPELL_STAT3_NAME },
		[4] = { stat = "Spirit", list = "+(%d+) "..SPELL_STAT4_NAME },
		[5] = { stat = "SpellResistance", list = "+(%d+) (.+) "..RESISTANCE_LABEL },
		[6] = { stat = "ManaRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana per 5 sec" },
		[7] = { stat = "HealthRegen", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) health every 5 sec" },
		[8] = { stat = "AllSpells", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[9] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing done by magical spells and effects by up to" },
		[10] = { stat = "Healing", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing done by spells and effects by up to" },
		[11] = { stat = "SingleSpell", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage done by (.+) spells and effects by up to" },
		[12] = { stat = "SpellCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by" },
		[13] = { stat = "SpellCritSingle", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases the critical effect chance of your (.+) spells by" },
		[14] = { stat = "SpellHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit with spells by" },
		[15] = { stat = "AttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) "..ATTACK_POWER_TOOLTIP },
		[16] = { stat = "RangedAttackPower", list = ITEM_SPELL_TRIGGER_ONEQUIP.." (+%d+) ranged Attack Power" },
		[17] = { stat = "MeleeCrit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike by" },
		[18] = { stat = "MeleeHit", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to hit by" },
		[19] = { stat = "Parry", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to parry an attack by" },
		[20] = { stat = "Dodge", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases your chance to dodge an attack by" },
		[21] = { stat = "Defense", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Increased Defense (+%d+)" },
		[22] = { stat = "SpellPierce", list = ITEM_SPELL_TRIGGER_ONEQUIP.." Decreases the magical resistances of your spell targets by" },
	};

	Nurfed_DKPValues.caster = {
		[0] = "+(%d+) "..SPELL_STAT3_NAME,
		[1] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases damage and healing",
		[2] = ITEM_SPELL_TRIGGER_ONEQUIP.." Increases healing",
		[3] = ITEM_SPELL_TRIGGER_ONEQUIP.." Improves your chance to get a critical strike with spells by",
		[4] = ITEM_SPELL_TRIGGER_ONEQUIP.." Restores (%d+) mana every 5 sec",
	};

	Nurfed_DKPValues.weapons = {
		[INVTYPE_WEAPON] = true,
		[INVTYPE_2HWEAPON] = true,
		[INVTYPE_WEAPONMAINHAND] = true,
		[INVTYPE_WEAPONOFFHAND] = true,
		["Bow"] = true,
		["Gun"] = true,
		["Crossbow"] = true,
		[INVTYPE_RANGED] = true,
		["Wand"] = true,
	};

	Nurfed_DKPValues.warweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.16, sub = 86.71},
			["Sword"] = { dps = 0.81, top = 0.18, sub = 87.98},
			["Mace"] = { dps = 0.86, top = 0.17, sub = 86.76},
			["Polearm"] = { dps = 0.85, top = 0.18, sub = 86.01},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Mace"] = { dps = 0.94, top = 0.22, sub = 72.10},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0.22, sub = 72.10},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, top = 0.22, sub = 71.73},
			["Sword"] = { dps = 0.94, top = 0, sub = 66.68},
			["Mace"] = { dps = 0.95, top = 0.22, sub = 71.56},
			["Dagger"] = { dps = 0.94, top = 0.29, sub = 66.04},
			["Fist Weapon"] = { dps = 0.94, top = 0, sub = 66.68},
		},
	};

	Nurfed_DKPValues.rogueweap = {
		[INVTYPE_WEAPON] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Sword"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0.30, sub = 84.62},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Sword"] = { dps = 1.04, top = 0, sub = 39.84},
			["Mace"] = { dps = 1.04, top = 0.30, sub = 84.62},
			["Dagger"] = { dps = 1.04, top = 0.39, sub = 79.66},
			["Fist Weapon"] = { dps = 1.04, top = 0, sub = 39.84},
		},
	};

	Nurfed_DKPValues.hybridweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, top = 0.22, sub = 101.4},
			["Mace"] = { dps = 0.86, top = 0.23, sub = 101.43},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, top = 0.35, sub = 89.96},
			["Mace"] = { dps = 0.95, top = 0.34, sub = 89.32},
			["Dagger"] = { dps = 0.94, top = 0.55, sub = 89.96},
			["Fist Weapon"] = { dps = 0.96, top = 0.54, sub = 87.77},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Fist Weapon"] = { dps = 0.97, top = 0.54, sub = 87.09},
		},
	};

	Nurfed_DKPValues.hunterweap = {
		[INVTYPE_WEAPON] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
		},
		[INVTYPE_2HWEAPON] = {
			["Axe"] = { dps = 0.84, sub = 45.03},
			["Sword"] = { dps = 0.81, sub = 46.44},
			["Polearm"] = { dps = 0.85, sub = 46.15},
		},
		[INVTYPE_WEAPONMAINHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.06},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.96, sub = 38},
		},
		[INVTYPE_WEAPONOFFHAND] = {
			["Axe"] = { dps = 0.94, sub = 39.05},
			["Sword"] = { dps = 0.94, sub = 39.03},
			["Dagger"] = { dps = 0.94, sub = 39.03},
			["Fist Weapon"] = { dps = 0.97, sub = 37.87},
		},
	};

	Nurfed_DKPValues.rangedweap = {
		["Bow"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Gun"] = { dps = 1.4, top = 0.20, sub = 52.52 },
		["Crossbow"] = { dps = 1.4, top = 0.2, sub = 52.52 },
	};

	Nurfed_DKPValues.rangedmelee = {
		["Bow"] = { dps = 1.01, sub = 32.20 },
		["Gun"] = { dps = 1.01, sub = 32.20 },
		["Crossbow"] = { dps = 1.01, sub = 32.20 },
	};

	Nurfed_DKPValues.static = {
		["Head of Nefarian"] = 13.247,
		["Head of Onyxia"] = 9.312,
		["Ancient Petrified Leaf"] = 22.047,
		["Mature Black Dragon Sinew"] = 22.047,
		["The Eye of Divinity"] = 20.052,
		["Eye of Sulfuras"] = 101.062,
		["Bindings of the Windseeker"] = 31.815,
		["Talisman of Ephemeral Power"] = 25.200,
		["Aegis of Preservation"] = 3.000,
		["Arcane Infused Gem"] = 1.092,
		["Lifegiving Gem"] = 7.500 ,
		["Mind Quickening Gem"] = 13.393,
		["Natural Alignment Crystal"] = 10.714,
		["Rune of Metamorphosis"] = 2.229,
		["The Black Book"] = 5.000,
		["Venemous Totem"] = 1.500,
		["Essence of the Pure Flame"] = 1.000,
	};

	Nurfed_DKPValues.multi = {
		["Thunderfury, Blessed Blade of the Windseeker"] = 2.4,
		["Spinal Reaper"] = 1.25,
		["Eskhandar's Left Claw"] = 1.25,
		["Empyrean Demolisher"] = 1.2,
		["Eskhandar's Right Claw"] = 1.15,
		["The Untamed Blade"] = 1.15,
		["Perdition's Blade"] = 1.1,
		["Vis'kag the Bloodletter"] = 1.1,
		["Earthshaker"] = 1.1,
		["Shadowstrike"] = 1.1,
		["Drake Talon Cleaver"] = 1.1,
		["Ancient Cornerstone Grimoire"] = 1.05,
		["Sulfuras, Hand of Ragnaros"] = 1.05,
		["Deathbringer"] = 1.05,
		["Gutgore Ripper"] = 1.05,
	};
end