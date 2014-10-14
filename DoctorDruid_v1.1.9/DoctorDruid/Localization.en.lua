--
-- English (Default)
--

DDhelp = {	"Settings:   /dd", -- 1
		"Usage:   /dd <command>", -- 2
		"Commands:   ", -- 3
		"For further information concerning /dd commands, please consult the HTML-manual included to this addon." --4
}

DOCDRUID = {	"Healing Touch", -- Spell -- 1
		"Healing Touch (no increasing rank)", -- 2
		"Regrowth", -- Spell -- 3
		"Regrowth (no increasing rank)", -- 4
		"Rejuvenation", -- Spell -- 5
		"Mark of the Wild", -- Spell -- 6
		"Thorns", -- Spell -- 7
		"Remove Poison", -- 8
		"Innervate", -- Spell -- 9
		"Moonfire", -- Spell -- 10
		"Innervate: Without any notice", -- 11
		"Innervate: Notice by whisper", -- 12
		"Innervate: Notice in group chat", -- 13
		"Innervate: Notice in raid chat", -- 14
		"Form: Caster", -- 15
		"Form: Bear", -- 16
		"Form: Aquatic", -- 17
		"Form: Cat", -- 18
		"Form: Traveller ;)", -- 19
		"Form: Moonkin", -- 20
		"Totem-Moonfire", -- 21
		"Cat: Prowl (won´t stop prowling)", -- 22
		"Cat: Normal attack", -- 23
		"Cat: Attack from behind", -- 24
		"Improved Moonfire", -- Talent -- 25
		"Moonglow", -- Talent -- 26
		"Moonfury", -- Talent -- 27
		"Improved Healing Touch", -- Talent -- 28
		"Gift of Nature", -- Talent -- 29
		"Improved Rejuvenation", -- Talent -- 30
		"Tranquil Spirit", -- Talent -- 31
		"Cure Poison", -- Spell -- 32
		"Abolish Poison", -- Spell -- 33
		"Cure of single poison", -- 34
		"Multiple cure of poison", -- 35
		"Maximum healing over time: 1x", -- 36
		"Maximum healing over time: INACTIVE", -- 37
		"Prowl", -- Spell / Catform -- 38
		"otem", -- Totem-Attribute UnitName() -- 39
		"Totem", -- Totem-Attribute UnitCreatureType() -- 40
		"WARRIOR", -- Totem-Attribute UnitClass() -- 41
		"Rank", -- Part of spell name, used for strings like 'Healing Touch(Rank 9)' / 'Heilende Berührung(Rang 9)' -- 42
		": You don´t have that spell.", -- 43
		": Choose a friendly target first.", -- 44
		"A ", " has no need for Mana.", -- these belong together -- 45, 46
		"Out of range.", -- 47
		"Still has more than 75% Mana.", -- 48
		"Buff", -- 49
		"[Innervate] for you", -- 50
		"[Innervate] for ", -- 51
		"Out of Mana. You can´t cast ", " right now.", -- these belong together -- 52, 53
		"No poison to cure.", -- 54
		" => ", -- 55
		" (Low on Mana. Rank decreased by ", " / maximum rank would have been ", " on this target", ")", -- these belong together -- 56, 57, 58, 59
		", Rank ", " out of ", -- these belong together -- 60, 61
		" (Max. healing)", -- 62
		" (", " damage)", " damage, approximated)", -- these belong together -- 63, 64, 65
		" not required", -- 66
		"Switch: Maximum HOTs", -- 67
		" (Increased by ", ")", -- these belong together -- 68, 69
		" (Free casting: Highest rank)", -- 70
		" (Infight => Maximum Rejuvenation)", -- 71
		"Remove poison: ", -- 72
		"Pounce", -- Spell / Catform -- 73
		"Ravage", -- Spell / Catform -- 74
		"Rip", -- Spell / Catform -- 75
		"Ferocious Bite", -- Spell / Catform -- 76
		"Rake", -- Spell / Catform -- 77
		"Claw", -- Spell / Catform -- 78
		"Shred", -- Spell / Catform -- 79
		"Cower", -- Spell / Catform -- 80
		"Tiger's Fury", -- Spell / Catform -- 81
		"Maximum healing over time: 2x", -- 82
		"Maximum healing over time: PERMANENT", -- 83
		" (Max. HoT: 1x)", -- 84
		" (Max. HoT: 0x)", -- 85
		": Spell not ready.", -- 86
		" (No early finishers)", -- 87
		"Faerie Fire (Feral)", -- 88
		"[Innervate] Cooldown: ", -- 89
		"Seconds", -- 90
		"Minutes", -- 91
		"Form: Aquatic or Traveller", -- 92
		"Form: Caster + Nature's Swiftness", -- 93
		"Nature's Swiftness", -- 94
		"Prowl opener", -- 95
		"Auto", -- 96
		" before opener", -- 97
		"Always cower", -- 98
		"Cower on Aggro", -- 99
		"Cat form", -- 100
		"Bear form", -- 101
		"Remove Curse", -- 102
		"Remove poison/curse: ", -- 103
		"You don´t have any spell to remove poison or curses.", -- 104
		"You don´t have any spell to remove poison.", -- 105
		"You don´t have any spell to remove curses.", -- 106
		"No poison or curse found.", -- 107
		"Remove poison or curse", -- 108
		"Higher priority", -- 109
		"Poison", -- 110
		"Curse", -- 111
		"Defaults", -- 112
		"Close", -- 113
		"Taunt", -- 114
		"Maul", -- 115
		"Swipe", -- 116
		"Demoralizing Roar", -- 117
		"Bash", -- 118
		"Feral Charge", -- 119
		"Enrage", -- 120
		"Challenging Roar", -- 121
		"Key 3: Allow ", "", -- these belong together -- 122, 123
		"Key 1+2+3: Always taunt, if you would do nothing else", -- 124
		"Key 1+2+4: Taunt on lost Aggro", -- 125
		"Bear #1: Attack single target", -- 126
		"Bear #2: Attack multiple targets", -- 127
		"Bear #3: Special(s)", -- 128
		"Frenzied Regeneration", -- 129
		" (At 70+ Rage and <70% Health)", -- 130
		"Not in PvP", -- 131
		" before finishers", -- 132
		"Hours", -- 133
		"Days", -- 134
		" heals...\nTime required: ", -- 135
		"Statistics", -- 136
		"Setup", -- 137
		"Healing details", -- 138
		"+Heal", -- 139
		"Mana", -- 140
		"Mana-Reg / 5s", -- 141
		"Calculate", -- 142
		"Char-Values", -- 143
		"Idol of Ferocity", -- 144
		"Idol of Health", -- 145
		"Idol of Longevity", -- 146
		"Idol of Brutality", -- 147
		"Idol of Rejuvenation", -- 148
		"Idol of the Moon", -- 149
		"General settings", -- 150
		"Activate Feral features and dynamic Entangling Roots", -- 151
		"Top 9 healing spells with these stats:", -- 152
		"Output text to which window? (1-15; 0 = No text output)", -- 153
		"Save", -- 154
		"Settings", -- 155
		"Normal Attacks", -- 156
		"Finisher", -- 157
		"Both", -- 158
		"Track Humanoids", -- 159
		"Pressing key for Cat-Form when shifted = Track Humanoids", -- 160
		"Cat: Prowl (no target: stop prowl)", -- 161
		"Cat&Nightelf: Cancel prowl", -- 162
		"[Rebirth ", -- 163
		"[Rebirth] Cooldown: ", -- 164
		"Rebirth", -- 165
		"Maple Seed", -- 166
		"Stranglethorn Seed", -- 167
		"Ashwood Seed", -- 168
		"Hornbeam Seed", -- 169
		"Ironwood Seed", -- 170
		"Invalid target", -- 171
		"[Rebirth] No reagent found.", -- 172
		"] for ", -- 173
		"] Please choose a target now.", -- 174
		"Rebirth: No notice on cooldown", -- 175
		"At once", -- 176
		"Settings for prowl-key", -- 177
		"Settings for attack-keys", -- 178
		"+Tiger's Fury", -- 179
		"Pressing the key for Cat-Form when shifted = Prowl", -- 180
		"Elemental", -- 181
		"Entangling Roots", -- 182
		" (", " Roots per minute)", -- 183,184 -- these belong together
		"Dynamic Entangling Roots", -- 185
		": Choose a target first.", -- 186
		"General", -- 187
		"Healing", -- 188
		"Cat Form", -- 189
		"Bear Form", -- 190
		"Balance", -- 191
		"Back", -- 192
		"Entangling Roots rank against players (PvP), 0 = dynamic", -- 193
		"Entangling Roots rank against mobs (PvE), 0 = dynamic", -- 194
		"Do you really want to restore default settings?", -- 195
		"Yes", -- 196
		"No", -- 197
		"Default settings restored.", -- 198
		"Faerie Fire", -- 199
		"Rebirth: Cooldown to group chat", -- 200
		"Rebirth: Cooldown to raid chat", -- 201
		"Faerie Fire for all forms", -- 202
		" during combat (PvE)", -- 203
		" during combat (PvP)", -- 204
		"Innervate self: Without any notice", -- 205
		"Innervate self: Notice in group chat", -- 206
		"Innervate self: Notice in raid chat", -- 207
		"Pressing key for Bear-Form when shifted = Enrage", -- 208
		"Pressing key for Bear-Form when shifted = Feral Charge", -- 209
		"Pressing key for Bear-Form when shifted = Bash", -- 210
		"Exchange bear keys 2 and 4", -- 211
		"Bear keys 2 and 4 are EXCHANGED now.", -- 212
		"Bear keys 2 and 4 are NORMAL now.", -- 213
		"Pressing key for Bear-Form when shifted = Bear Key 4", -- 214
		"Bear #4: Max. aggro-generation", -- 215
		"Exchange Bear #2 and #4", -- 216
		"\nAlways try Rake, if not enough Energy for Claw\n(Only if 'Both' is set for 'Normal Attacks')", -- 217
		"Second", -- 218
		"Minute", -- 219
		"Hour", -- 220
		"Day", -- 221
		"Druids as bears/cats won´t be innervated. (Because of your settings)", -- 222
		"Don´t innervate druids when they´re in Cat-Form or Bear-Form", -- 223
		"No taunt if target´s new target is a Warrior", -- 224
		"Not specified", -- 225
		"Automatically help friendly targets (by targeting their targets)", -- 226
		" instant", -- 227
		" over time", -- 228
}

DDcmd = {	"motw", -- 1
		"thorns", -- 2
		"ht", -- 3
		"ht+", -- 4
		"regrowth", -- 5
		"regrowth+", -- 6
		"rejuv", -- 7
		"maxheal", -- 8
		"removepoison", -- 9
		"innervate", -- 10
		"innervate1", -- 11
		"innervate2", -- 12
		"innervate3", -- 13
		"caster", -- 14
		"caster+", -- 15
		"bear", -- 16
		"cat", -- 17
		"moonkin", -- 18
		"travelaquatic", -- 19
		"travel", -- 20
		"aquatic", -- 21
		"totem", -- 22
		"catmulti", -- 23
		"catinfront+", -- 24
		"catbehind+", -- 25
		"catinfront", -- 26
		"catbehind", -- 27
		"cursepoison", -- 28
		"bear1", -- 29
		"bear2", -- 30
		"bear3", -- 31
		"catmulti2", -- 32
		"stopstealth", -- 33
		"rebirth", -- 34
		"roots", -- 35
		"rebirth1", -- 36
		"rebirth2", -- 37
		"faeriefire", -- 38
		"innervateself", -- 39
		"innervateself2", -- 40
		"innervateself3", -- 41
		"bear4", -- 42
		"bearexchange", -- 43
}

instanceZone = {
	{ lvlmin = 15, lvlmax = 18, diff =  1, name = "ragefire chasm" },
	{ lvlmin = 15, lvlmax = 22, diff =  1, name = "deadmines" },
	{ lvlmin = 15, lvlmax = 22, diff =  1, name = "wailing caverns" },
	{ lvlmin = 18, lvlmax = 26, diff =  2, name = "shadowfang" },
	{ lvlmin = 20, lvlmax = 27, diff =  2, name = "blackfathom" },
	{ lvlmin = 23, lvlmax = 30, diff =  2, name = "stockades" },
	{ lvlmin = 25, lvlmax = 31, diff =  3, name = "razorfen downs" },
	{ lvlmin = 30, lvlmax = 37, diff =  3, name = "gnomeregan" },
	{ lvlmin = 35, lvlmax = 40, diff =  3, name = "razorfen kraul" },
	{ lvlmin = 35, lvlmax = 42, diff =  4, name = "scarlet monastery" },
	{ lvlmin = 40, lvlmax = 50, diff =  4, name = "uldaman" },
	{ lvlmin = 43, lvlmax = 47, diff =  4, name = "farrak" },
	{ lvlmin = 45, lvlmax = 52, diff =  5, name = "maraudon" },
	{ lvlmin = 49, lvlmax = 55, diff =  5, name = "sunken temple" },
	{ lvlmin = 55, lvlmax = 60, diff =  6, name = "blackrock depths" },
	{ lvlmin = 55, lvlmax = 60, diff =  6, name = "stratholme" },
	{ lvlmin = 57, lvlmax = 62, diff =  6, name = "scholomance" },
	{ lvlmin = 55, lvlmax = 65, diff =  7, name = "dire maul" },
	{ lvlmin = 55, lvlmax = 65, diff =  7, name = "blackrock spire" },
	{ lvlmin = 60, lvlmax = 70, diff =  8, name = "molten core" },
	{ lvlmin = 60, lvlmax = 70, diff =  9, name = "blackwing lair" },
	{ lvlmin = 60, lvlmax = 70, diff = 10, name = "onyxia's lair" },
	{ lvlmin = 60, lvlmax = 70, diff = 10, name = "gurub" },
	{ lvlmin = 60, lvlmax = 70, diff = 11, name = "qiraj" },
	{ lvlmin = 60, lvlmax = 70, diff = 12, name = "naxxramas" },
	{ lvlmin = 60, lvlmax = 70, diff = 13, name = "hellfire citadel" },		--?
}

classlist = {
	druid="DRUID", mage="MAGE", paladin="PALADIN", priest="PRIEST", rogue="ROGUE", shaman="SHAMAN",
	warrior="WARRIOR", warlock="WARLOCK", hunter="HUNTER",
}
 