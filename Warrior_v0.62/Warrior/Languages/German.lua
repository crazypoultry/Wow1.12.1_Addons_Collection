-- load the German language files
if (GetLocale() == "deDE") then


W = {};

-- patterns
W.Patterns = {
	-- extracting spell information from tooltips
	Rage = "(%d+) Wut",
	Stance1 = "Benötigt (%w+haltung)",
	Stance2 = "Benötigt (%w+haltung), (%w+haltung)",
	
	-- detect immunities
	Failed = "^(.+) war ein Fehlschlag[.] (.+) ist immun[.]$",
	Disarm = "^hat keine Waffe angelegt[.]$",
	Gains = "^(.+) bekommt '(.+)'[.]$",
	Fades = "^'(.+)' schwindet von (.+)[.]$",
	Removed = "^(.+) von (.+) wurde entfernt[.]$",
	
	-- detect a spell being cast
	BeginCast1 = "^(.+) fängt das Zaubern an (.+)[.]$",
	BeginCast2 = "^(.+) beginnt (.+) herzustellen[.]$",
	
	-- detect fleeing enemies
	Fleeing = "^versucht zu flüchten!$",
	
	-- detect dodges
	Dodge1 = "^(.+) greift an[.] (.x) weicht aus[.]$",
	Dodge2 = "^(.+) ist (.+) ausgewichen[.]$",
	
	-- detect player dodge/parry/block
	Dodge = "^(.+) greift an[.] Ihr weicht aus[.]$",
	Parry = "^(.+) greift an[.] Ihr pariert[.]$",
	Block = "^(.+) greift an[.] Ihr blockt[.]$"
}

-- spell names
W.Spells = {
	Attack = "Angreifen",
	BattleShout = "Schlachtruf",
	BattleStance = "Kampfhaltung",
	BerserkerRage = "Berserkerwut",
	BerserkerStance = "Berserkerhaltung",
	Bloodrage = "Blutrausch",
	Bloodthirst = "Blutdurst",
	ChallengingShout = "Herausforderungsruf",
	Charge = "Sturmangriff",
	Cleave = "Spalten",
	ConcussionBlow = "Erschütternder Schlag",
	DeathWish = "Todeswunsch",
	DefensiveStance = "Verteidigungshaltung",
	DemoralizingShout = "Demoralisierungsruf",
	Disarm = "Entwaffnen",
	Execute = "Hinrichten",
	Hamstring = "Kniesehne",
	HeroicStrike = "Heldenhafter Stoß",
	Intercept = "Abfangen",
	IntimidatingShout = "Drohruf",
	LastStand = "Letztes Gefecht",
	MockingBlow = "Spöttischer Schlag",
	MortalStrike = "Tödlicher Stoß",
	Overpower = "Überwältigen",
	PiercingHowl = "Durchdringendes Heulen",
	Pummel = "Zuschlagen",
	Recklessness = "Tollkühnheit",
	Rend = "Verwunden",
	Retaliation = "Gegenschlag",
	Revenge = "Rache",
	ShieldBash = "Schildhieb",
	ShieldBlock = "Schildblock",
	ShieldSlam = "Schildschlag",
	Shield_Wall = "Schildwall",
	Slam = "Zerschmettern",
	SunderArmor = "Rüstung zerreißen",
	SweepingStrikes = "Weitreichende Stöße",
	Taunt = "Spott",
	ThunderClap = "Donnerknall",
	Whirlwind = "Wirbelwind",
}

-- immunity effects
W.ImmunityEffects = {
	"Arcane Bubble",
	"Arcane Protection",
	"Avatar of Flame",
	"Verbannen",
	"Blessing of Protection",
	"Deep Slumber",
	"Dispell Bloodtooth",
	"Divine Protection",
	"Divine Shield",
	"Forcefield Collapse",
	"Eisblock",	
	"Improved Blessing of Protection",
	"Immune: Physical",
	"Immunity: Shadow",
	"Invulnerability",
	"Judge's Gavel",
	"Light of Elune",
	"Nullify",
	"Machtwort: Schild",
	"Seal of Protection",
	"Spell Immunity",
	"Stone Slumber",
	"Theka Transform",
	"Unkillable Off",
	"Wirbelwind"
}

-- WarriorAttack interruptable spells
W.WarriorAttack = {
	short = {
		"Hammer des Zorns",
		"Arkane Explosion",
		"Wucherwurzeln",
		"Furcht",
		"Blitzheilung",
		"Lichtblitz",
		"Geringe Welle der Heilung",
		"Gedankenschlag",
		"Verwandlung",
		"Versengen",
		"Sengender Schmerz",
		"Verführung",
		"Kriegsdonner",
		"Verderbnis",
		"Feuerblitz",
		"Schreckgeheul",
		"Feuerbrand",
		"Wiedergeburt",
		"Nachwachsen",
		"Zorn"
	},
		
	long = {
		"Kettenheilung",
		"Kettenblitzschlag",
		"Heiliges Licht",
		"Göttliche Pein",
		"Gezielter Schuss",
		"Flammenstoß",
		"Frostblitz",
		"Welle der Heilung",
		"Blitzschlag",
		"Gedankenschinden",
		"Gebet der Heilung",
		"Schattenblitz",
		"Feuerball",
		"Heilende Berührung",
		"Sternenfeuer",
		"Große Heilung",
		"Heilung",
		"Heiliges Feuer",
		"Arkane Geschosse",
		"Blutsauger",
		"Pyroschlag",
		"Seelenfeuer",
		"Sternensplitter",
		"Salve",
		"Blizzard",
		"Feuerregen",
		"Hurrikan",
		"Gelassenheit",
		"Höllenfeuer"
	}
}

end
