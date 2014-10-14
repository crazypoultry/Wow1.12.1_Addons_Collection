W = {};

-- patterns
W.Patterns = {
	-- extracting spell information from tooltips
	Rage = "(%d+) Rage",
	Stance1 = "Requires (%w+ Stance)",
	Stance2 = "Requires (%w+ Stance), (%w+ Stance)",
	
	-- detect immunities
	Failed = "^Your (.+) failed[.] (.+) is immune[.]$",
	Disarm = "^You fail to perform Disarm: Target has no weapons equipped.$",
	Gains = "^(.+) gains (.+)[.]$",
	Fades = "^(.+) fades from (.+)[.]$",
	Removed = "^(.+)'s (.+) is removed[.]$",
	
	-- detect a spell being cast
	BeginCast1 = "^(.+) begins to cast (.+).$",
	BeginCast2 = "^(.+) begins to perform (.+).$",

	-- detect fleeing enemies
	Fleeing = "^attempts to run away in fear!$",
	
	-- detect dodges
	Dodge1 = "^(.+) attack[.] (.+) dodges[.]$",
	Dodge2 = "^Your (.+) was dodged by (.+)[.]$",
	
	-- detect player dodge/parry/block
	Dodge = "^(.+) attacks. You dodge.$",
	Parry = "^(.+) attacks. You parry.$",
	Block = "^(.+) attacks. You block.$"
}

-- spell names
W.Spells = {
	Attack = "Attack",
	BattleShout = "Battle Shout",
	BattleStance = "Battle Stance",
	BerserkerRage = "Berserker Rage",
	BerserkerStance = "Berserker Stance",
	Bloodrage = "Bloodrage",
	Bloodthirst = "Bloodthirst",
	ChallengingShout = "Challenging Shout",
	Charge = "Charge",
	Cleave = "Cleave",
	ConcussionBlow = "Concussion Blow",
	DeathWish = "Death Wish",
	DefensiveStance = "Defensive Stance",
	DemoralizingShout = "Demoralizing Shout",
	Disarm = "Disarm",
	Execute = "Execute",
	Hamstring = "Hamstring",
	HeroicStrike = "Heroic Strike",
	Intercept = "Intercept",
	IntimidatingShout = "Intimidating Shout",
	LastStand = "Last Stand",
	MockingBlow = "Mocking Blow",
	MortalStrike = "Mortal Strike",
	Overpower = "Overpower",
	PiercingHowl = "Piercing Howl",
	Pummel = "Pummel",
	Recklessness = "Recklessness",
	Rend = "Rend",
	Retaliation = "Retaliation",
	Revenge = "Revenge",
	ShieldBash = "Shield Bash",
	ShieldBlock = "Shield Block",
	ShieldSlam = "Shield Slam",
	ShieldWall = "Shield Wall",
	Slam = "Slam",
	SunderArmor = "Sunder Armor",
	SweepingStrikes = "Sweeping Strikes",
	Taunt = "Taunt",
	ThunderClap = "Thunder Clap",
	Whirlwind = "Whirlwind",
}

-- immunity effects
W.ImmunityEffects = {
	"Arcane Bubble",
	"Arcane Protection",
	"Avatar of Flame",
	"Banish",
	"Blessing of Protection",
	"Deep Slumber",
	"Dispell Bloodtooth",
	"Divine Protection",
	"Divine Shield",
	"Forcefield Collapse",
	"Ice Block",	
	"Improved Blessing of Protection",
	"Immune: Physical",
	"Immunity: Shadow",
	"Invulnerability",
	"Judge's Gavel",
	"Light of Elune",
	"Nullify",
	"Power Word: Shield",
	"Seal of Protection",
	"Spell Immunity",
	"Stone Slumber",
	"Theka Transform",
	"Unkillable Off",
	"Whirlwind"
}

-- WarriorAttack interruptable spells
W.WarriorAttack = {
	short = {
		"Hammer of Wrath",
		"Arcane Explosion",
		"Entangling Roots",
		"Fear",
		"Flash Heal",
		"Flash of Light",
		"Lesser Healing Wave",
		"Mind Blast",
		"Polymorph",
		"Scorch",
		"Searing Pain",
		"Seduction",
		"War Stomp",
		"Corruption",
		"Firebolt",
		"Howl of Terror",
		"Immolate",
		"Rebirth",
		"Regrowth",
		"Wrath"
	},
	
	long = {
		"Chain Heal",
		"Chain Lightning",
		"Holy Light",
		"Smite",
		"Aimed Shot",
		"Flamestrike",
		"Frostbolt",
		"Healing Wave",
		"Lightning Bolt",
		"Mind Flay",
		"Prayer of Healing",
		"Shadow Bolt",
		"Fireball",
		"Healing Touch",
		"Starfire",
		"Greater Heal",
		"Heal",
		"Holy Fire",
		"Arcane Missiles",
		"Drain Life",
		"Pyroblast",
		"Soul Fire",
		"Starshards",
		"Volley",
		"Blizzard",
		"Rain of Fire",
		"Hurricane",
		"Tranquility",
		"Hellfire"
	}
}
