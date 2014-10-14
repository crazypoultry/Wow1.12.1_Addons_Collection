Napoleon = {};
Napoleon.data = {};

Napoleon.data["version"] = 1.121;
Napoleon.data["loaded"] = false;
Napoleon.data["lastupdate"] = GetTime();

-- raid members
Napoleon.data["raidarray"] = {};
Napoleon.data["raidassoc"] = {};

-- tank members
Napoleon.data["tankarray"] = {};
Napoleon.data["tankassoc"] = {};

-- tracking chat commands
Napoleon.data["chatjob"] = {};

Napoleon.data["trade"] = { ["Alchemy"] = 1, ["Blacksmithing"] = 2, ["Enchanting"] = 3, ["Engineering"] = 4, ["Herbalism"] = 5, ["Leatherworking"] = 6, ["Mining"] = 7, ["Skinning"] = 8, ["Tailoring"] = 9, ["Jewelcrafting"] = 10, ["Cooking"] = 11, ["First Aid"] = 12, ["Fishing"] = 13, };
Napoleon.data["tradeicons"] = { "Trade_Alchemy", "Trade_Blacksmithing", "Trade_Engraving", "Trade_Engineering", "Trade_Herbalism", "Trade_Leatherworking", "Trade_Mining", "INV_Misc_Pelt_Wolf_01", "Trade_Tailoring", "INV_Jewelry_Talisman_08", "INV_Misc_Food_15", "Spell_Holy_SealOfSacrifice", "Trade_Fishing" };

Napoleon.data["duty"] = { "Heal", "Tank", "Off-Tank", "DPS", "Kite", "CC", "AOE", "Interrupt", "Mana Burn", "Buff", "Dispel", "Nature Swiftness", "Rem-Magic", "Rem-Curse", "Rem-Disease", "Rem-Poison" };
Napoleon.data["dutytype"] = { ["Heal"] = "defense", ["Tank"] = "combat", ["Off-Tank"] = "combat", ["DPS"] = "combat", ["Kite"] = "combat", ["CC"] = "combat", ["AOE"] = "combat", ["Interrupt"] = "combat", ["Mana Burn"] = "combat", ["Buff"] = "defense", ["Dispel"] = "combat", ["Nature Swiftness"] = "defense", ["Rem-Magic"] = "defense", ["Rem-Curse"] = "defense", ["Rem-Disease"] = "defense", ["Rem-Poison"] = "defense" };
Napoleon.data["dutyicons"] = { ["Heal"] = "Spell_Holy_SealOfSacrifice", ["Tank"] = "Ability_Defend", ["Off-Tank"] = "Ability_Warrior_Revenge", ["DPS"] = "Ability_Rogue_Ambush", ["Kite"] = "Ability_Racial_Ultravision", ["CC"] = "Spell_Nature_Polymorph", ["AOE"] = "Spell_Arcane_StarFire", ["Interrupt"] = "Ability_Kick", ["Mana Burn"] = "Spell_Shadow_ManaBurn", ["Buff"] = "Spell_Nature_Strength", ["Dispel"] = "Spell_Nature_Purge", ["Nature Swiftness"] = "Spell_Nature_Swiftness", ["Rem-Magic"] = "Spell_Holy_DispelMagic", ["Rem-Curse"] = "Spell_Holy_RemoveCurse", ["Rem-Disease"] = "Spell_Nature_NullifyDisease", ["Rem-Poison"] = "Spell_Nature_NullifyPoison" };
Napoleon.data["dutytarget"] = { "All", "Boss", "Adds", "Phase 1", "Phase 2", "Phase 3" };

Napoleon.data["ddraid"] = { "RAID", "HEALERS", "DPS", "MELEE DPS", "RANGED DPS", "PETS", "AOE", "Dispel", "Druid", "Hunter", "Mage", "Paladin", "Priest", "Rogue", "Shaman", "Warlock", "Warrior", "Rem-Magic", "Rem-Curse", "Rem-Disease", "Rem-Poison" }
Napoleon.data["ddgroup"] = { "Groups EVEN", "Groups ODD", "Groups 1-4", "Groups 5-8", "Groups 1-2", "Groups 3-4", "Groups 5-6", "Groups 7-8", "Group 1", "Group 2", "Group 3", "Group 4", "Group 5", "Group 6", "Group 7", "Group 8" }
Napoleon.data["ddother"] = { "RA", "RA MT1-2", "RA MT1-3", "RA MT1-4", "RA MT1-5", "RA MT1", "RA MT2", "RA MT3", "RA MT4", "RA MT5", "RA MT6", "RA MT7", "RA MT8", "RA MT9", "RA MT10", "Assigned", "Unassigned", "Online" }

Napoleon.data["emotes"] = { "AGREE", "AMAZE", "ANGRY", "APOLOGIZE", "APPLAUD", "ATTACKMYTARGET", "BARK", "BASHFUL", "BECKON", "BEG", "BITE", "BLEED", "BLINK", "BLUSH", "BOGGLE", "BONK", "BORED", "BOUNCE", "BOW", "BRB", "BURP", "BYE", "CACKLE", "CALM", "CHARGE", "CHEER", "CHICKEN", "CHUCKLE", "CLAP", "COLD", "COMFORT", "COMMEND", "CONFUSED", "CONGRATULATE", "COUGH", "COWER", "CRACK", "CRINGE", "CRY", "CUDDLE", "CURIOUS", "CURTSEY", "DANCE", "DRINK", "DROOL", "DUCK", "EAT", "EYE", "FART", "FIDGET", "FLEE", "FLEX", "FLIRT", "FLOP", "FOLLOW", "FROWN", "GASP", "GAZE", "GIGGLE", "GLARE", "GLOAT", "GOLFCLAP", "GREET", "GRIN", "GROAN", "GROVEL", "GROWL", "GUFFAW", "HAIL", "HAPPY", "HEALME", "HELLO", "HELPME", "HUG", "HUNGRY", "INCOMING", "INSULT", "INTRODUCE", "JK", "JOKE", "KISS", "KNEEL", "LAUGH", "LAYDOWN", "LICK", "LISTEN", "LOST", "LOVE", "MASSAGE", "MOAN", "MOCK", "MOO", "MOON", "MOURN", "NO", "NOD", "NOSEPICK", "OOM", "OPENFIRE", "PANIC", "PAT", "PEER", "PITY", "PLEAD", "POINT", "POKE", "PONDER", "POUNCE", "PRAISE", "PRAY", "PURR", "PUZZLE", "RAISE", "RASP", "READY", "ROAR", "ROFL", "RUDE", "SALUTE", "SCARED", "SCRATCH", "SEXY", "SHAKE", "SHIMMY", "SHIVER", "SHOO", "SHRUG", "SHY", "SIGH", "SLAP", "SLEEP", "SMILE", "SMIRK", "SNARL", "SNICKER", "SNIFF", "SNUB", "SOOTHE", "SPIT", "STAND", "STARE", "STINK", "SURPRISED", "SURRENDER", "TALK", "TALKEX", "TALKQ", "TAP", "TAUNT", "TEASE", "THANK", "THIRSTY", "THREATEN", "TICKLE", "TIRED", "TRAIN", "VETO", "VICTORY", "VIOLIN", "WAIT", "WAVE", "WELCOME", "WHINE", "WHISTLE", "WINK", "WORK", "YAWN" }

Napoleon.data["class"] = {
	DRUID = {
		classname = "Druid",
		classcoords = { 0.7421875, 0.98828125, 0, 0.25 },
		color = { r = 1.0; g = 0.49; b = 0.04; },
		reagents = {
			[1] = {
				name = "Wild Thornroot",
				icon = "Interface\\Icons\\Spell_Nature_Thorns",
			},
			[2] = {
				name = "Ironwood Seed",
				icon = "Interface\\Icons\\INV_Misc_Food_02",
			},
			[3] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
		},
		talenttab = {
			[1] = {
				name = "Balance", 
				background = "Balance", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Wrath", icon = "Interface\\Icons\\Spell_Nature_AbolishMagic" },
							[2] = { maxrank = 1, name = "Nature's Grasp", icon = "Interface\\Icons\\Spell_Nature_NaturesWrath" },
							[3] = { maxrank = 4, name = "Improved Nature's Grasp", icon = "Interface\\Icons\\Spell_Nature_NaturesWrath" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Entangling Roots", icon = "Interface\\Icons\\Spell_Nature_StrangleVines" },
							[2] = { maxrank = 5, name = "Improved Moonfire", icon = "Interface\\Icons\\Spell_Nature_StarFall" },
							[3] = { maxrank = 5, name = "Natural Weapons", icon = "Interface\\Icons\\INV_Staff_01" },
							[4] = { maxrank = 3, name = "Natural Shapeshifter", icon = "Interface\\Icons\\Spell_Nature_WispSplode" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Thorns", icon = "Interface\\Icons\\Spell_Nature_Thorns" },
							[3] = { maxrank = 1, name = "Omen of Clarity", icon = "Interface\\Icons\\Spell_Nature_CrystalBall" },
							[4] = { maxrank = 2, name = "Nature's Reach", icon = "Interface\\Icons\\Spell_Nature_NatureTouchGrow" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Vengeance", icon = "Interface\\Icons\\Spell_Nature_Purge" },
							[3] = { maxrank = 5, name = "Improved Starfire", icon = "Interface\\Icons\\Spell_Arcane_StarFire" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Nature's Grace", icon = "Interface\\Icons\\Spell_Nature_NaturesBlessing" },
							[3] = { maxrank = 3, name = "Moonglow", icon = "Interface\\Icons\\Spell_Nature_Sentinal" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Moonfury", icon = "Interface\\Icons\\Spell_Nature_MoonGlow" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Moonkin Form", icon = "Interface\\Icons\\Spell_Nature_ForceOfNature" },
						}
					},
				},
			},
			[2] = {
				name = "Feral",
				background = "FeralCombat", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Ferocity", icon = "Interface\\Icons\\Ability_Hunter_Pet_Hyena" },
							[3] = { maxrank = 5, name = "Feral Aggression", icon = "Interface\\Icons\\Ability_Druid_DemoralizingRoar" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Feral Instinct", icon = "Interface\\Icons\\Ability_Ambush" },
							[2] = { maxrank = 2, name = "Brutal Impact", icon = "Interface\\Icons\\Ability_Druid_Bash" },
							[3] = { maxrank = 5, name = "Thick Hide", icon = "Interface\\Icons\\INV_Misc_Pelt_Bear_03" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Feline Swiftness", icon = "Interface\\Icons\\Spell_Nature_SpiritWolf" },
							[2] = { maxrank = 1, name = "Feral Charge", icon = "Interface\\Icons\\Ability_Hunter_Pet_Bear" },
							[3] = { maxrank = 3, name = "Sharpened Claws", icon = "Interface\\Icons\\INV_Misc_MonsterClaw_04" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Shred", icon = "Interface\\Icons\\Spell_Shadow_VampiricAura" },
							[2] = { maxrank = 3, name = "Predatory Strikes", icon = "Interface\\Icons\\Ability_Hunter_Pet_Cat" },
							[3] = { maxrank = 2, name = "Blood Frenzy", icon = "Interface\\Icons\\Ability_GhoulFrenzy" },
							[4] = { maxrank = 2, name = "Primal Fury", icon = "Interface\\Icons\\Ability_Racial_Cannibalize" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Savage Fury", icon = "Interface\\Icons\\Ability_Druid_Ravage" },
							[3] = { maxrank = 1, name = "Faerie Fire (Feral)", icon = "Interface\\Icons\\Spell_Nature_FaerieFire" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Heart of the Wild", icon = "Interface\\Icons\\Spell_Holy_BlessingOfAgility" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Leader of the Pack", icon = "Interface\\Icons\\Spell_Nature_UnyeildingStamina" },
						}
					},
				},
			},
			[3] = {
				name = "Restoration",
				background = "Restoration", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Mark of the Wild", icon = "Interface\\Icons\\Spell_Nature_Regeneration" },
							[3] = { maxrank = 5, name = "Furor", icon = "Interface\\Icons\\Spell_Holy_BlessingOfStamina" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Healing Touch", icon = "Interface\\Icons\\Spell_Nature_HealingTouch" },
							[2] = { maxrank = 5, name = "Nature's Focus", icon = "Interface\\Icons\\Spell_Nature_HealingWaveGreater" },
							[3] = { maxrank = 2, name = "Improved Enrage", icon = "Interface\\Icons\\Ability_Druid_Enrage" },
						}
					},
					[3] = {
						col = {
							[2] = { maxrank = 3, name = "Reflection", icon = "Interface\\Icons\\Spell_Frost_WindWalkOn" },
							[3] = { maxrank = 1, name = "Insect Swarm", icon = "Interface\\Icons\\Spell_Nature_InsectSwarm" },
							[4] = { maxrank = 5, name = "Subtlety", icon = "Interface\\Icons\\Ability_EyeOfTheOwl" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Tranquil Spirit", icon = "Interface\\Icons\\Spell_Holy_ElunesGrace" },
							[4] = { maxrank = 3, name = "Improved Rejuvenation", icon = "Interface\\Icons\\Spell_Nature_Rejuvenation" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 1, name = "Nature's Swiftness", icon = "Interface\\Icons\\Spell_Nature_RavenForm" },
							[3] = { maxrank = 5, name = "Gift of Nature", icon = "Interface\\Icons\\Spell_Nature_ProtectionformNature" },
							[4] = { maxrank = 2, name = "Improved Tranquility", icon = "Interface\\Icons\\Spell_Nature_Tranquility" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Improved Regrowth", icon = "Interface\\Icons\\Spell_Nature_ResistNature" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Innervate", icon = "Interface\\Icons\\Spell_Nature_Lightning" },
						}
					},
				},
			},
		},
	},
	HUNTER = {
		classname = "Hunter",
		classcoords = { 0, 0.25, 0.25, 0.5 },
		color = { r = 0.67; g = 0.83; b = 0.45; },
		reagents = {
			[1] = {
				name = "Heavy Runecloth Bandage",
				icon = "Interface\\Icons\\INV_Misc_Bandage_12",
			},
			[2] = {
				name = "Major Healing Potion",
				icon = "Interface\\Icons\\INV_Potion_54",
			},
			[3] = {
				name = "Mongoose Potion",
				icon = "Interface\\Icons\\INV_Potion_32",
			},
			[4] = {
				name = "Ground Scorpok Assay",
				icon = "Interface\\Icons\\INV_Misc_Dust_02",
			},
		},
		talenttab = {
			[1] = {
				name = "Beast Mastery", 
				background = "BeastMastery", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Aspect of the Hawk", icon = "Interface\\Icons\\Spell_Nature_RavenForm" },
							[3] = { maxrank = 5, name = "Endurance Training", icon = "Interface\\Icons\\Spell_Nature_Reincarnation" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Eyes of the Beast", icon = "Interface\\Icons\\Ability_EyeOfTheOwl" },
							[2] = { maxrank = 5, name = "Improved Aspect of the Monkey", icon = "Interface\\Icons\\Ability_Hunter_AspectOfTheMonkey" },
							[3] = { maxrank = 3, name = "Thick Hide", icon = "Interface\\Icons\\INV_Misc_Pelt_Bear_03" },
							[4] = { maxrank = 2, name = "Improved Revive Pet", icon = "Interface\\Icons\\Ability_Hunter_BeastSoothe" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Pathfinding", icon = "Interface\\Icons\\Ability_Mount_JungleTiger" },
							[2] = { maxrank = 1, name = "Bestial Swiftness", icon = "Interface\\Icons\\Ability_Druid_Dash" },
							[3] = { maxrank = 5, name = "Unleashed Fury", icon = "Interface\\Icons\\Ability_BullRush" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 2, name = "Improved Mend Pet", icon = "Interface\\Icons\\Ability_Hunter_MendPet" },
							[3] = { maxrank = 5, name = "Ferocity", icon = "Interface\\Icons\\INV_Misc_MonsterClaw_04" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Spirit Bond", icon = "Interface\\Icons\\Ability_Druid_DemoralizingRoar" },
							[2] = { maxrank = 1, name = "Intimidation", icon = "Interface\\Icons\\Ability_Devour" },
							[4] = { maxrank = 2, name = "Bestial Discipline", icon = "Interface\\Icons\\Spell_Nature_AbolishMagic" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Frenzy", icon = "Interface\\Icons\\INV_Misc_MonsterClaw_03" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Bestial Wrath", icon = "Interface\\Icons\\Ability_Druid_FerociousBite" },
						}
					},
				},
			},
			[2] = {
				name = "Marksmanship", 
				background = "Marksmanship", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Concussive Shot", icon = "Interface\\Icons\\Spell_Frost_Stun" },
							[3] = { maxrank = 5, name = "Efficiency", icon = "Interface\\Icons\\Spell_Frost_WizardMark" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Hunter's Mark", icon = "Interface\\Icons\\Ability_Hunter_SniperShot" },
							[3] = { maxrank = 5, name = "Lethal Shots", icon = "Interface\\Icons\\Ability_SearingArrow" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Aimed Shot", icon = "Interface\\Icons\\INV_Spear_07" },
							[2] = { maxrank = 5, name = "Improved Arcane Shot", icon = "Interface\\Icons\\Ability_ImpalingBolt" },
							[4] = { maxrank = 3, name = "Hawk Eye", icon = "Interface\\Icons\\Ability_TownWatch" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Serpent Sting", icon = "Interface\\Icons\\Ability_Hunter_Quickshot" },
							[3] = { maxrank = 5, name = "Mortal Shots", icon = "Interface\\Icons\\Ability_PierceDamage" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 1, name = "Scatter Shot", icon = "Interface\\Icons\\Ability_GolemStormBolt" },
							[2] = { maxrank = 3, name = "Barrage", icon = "Interface\\Icons\\Ability_UpgradeMoonGlaive" },
							[3] = { maxrank = 3, name = "Improved Scorpid Sting", icon = "Interface\\Icons\\Ability_Hunter_CriticalShot" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Ranged Weapon Specialization", icon = "Interface\\Icons\\INV_Weapon_Rifle_06" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Trueshot Aura", icon = "Interface\\Icons\\Ability_TrueShot" },
						}
					},
				},
			},
 			[3] = {
				name = "Survival", 
				background = "Survival", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 3, name = "Monster Slaying", icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black" },
							[2] = { maxrank = 3, name = "Humanoid Slaying", icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing" },
							[3] = { maxrank = 5, name = "Deflection", icon = "Interface\\Icons\\Ability_Parry" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Entrapment", icon = "Interface\\Icons\\Spell_Nature_StrangleVines" },
							[2] = { maxrank = 2, name = "Savage Strikes", icon = "Interface\\Icons\\Ability_Racial_BloodRage" },
							[3] = { maxrank = 5, name = "Improved Wing Clip", icon = "Interface\\Icons\\Ability_Rogue_Trip" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Clever Traps", icon = "Interface\\Icons\\Spell_Nature_TimeStop" },
							[2] = { maxrank = 5, name = "Survivalist", icon = "Interface\\Icons\\Spell_Shadow_Twilight" },
							[3] = { maxrank = 1, name = "Deterrence", icon = "Interface\\Icons\\Ability_Whirlwind" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Trap Mastery", icon = "Interface\\Icons\\Ability_Ensnare" },
							[2] = { maxrank = 3, name = "Surefooted", icon = "Interface\\Icons\\Ability_Kick" },
							[4] = { maxrank = 2, name = "Improved Feign Death", icon = "Interface\\Icons\\Ability_Rogue_FeignDeath" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 3, name = "Killer Instinct", icon = "Interface\\Icons\\Spell_Holy_BlessingOfStamina" },
							[3] = { maxrank = 1, name = "Counterattack", icon = "Interface\\Icons\\Ability_Warrior_Challange" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Lightning Reflexes", icon = "Interface\\Icons\\Spell_Nature_Invisibilty" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Wyvern Sting", icon = "Interface\\Icons\\INV_Spear_02" },
						}
					},
				},
			},
		},
	},
	HUNTERPET = {
		color = { r = 0.65; g = 0.82; b = 0.45; },
	},
	MAGE = {
		classname = "Mage",
		classcoords = { 0.25, 0.49609375, 0, 0.25 },
		color = { r = 0.41; g = 0.8; b = 0.94; },
		reagents = {
			[1] = {
				name = "Arcane Powder",
				icon = "Interface\\Icons\\INV_Misc_Dust_01",
			},
			[2] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
		},
		talenttab = {
 			[1] = {
				name = "Arcane", 
				background = "Arcane", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 3, name = "Arcane Subtlety", icon = "Interface\\Icons\\Spell_Holy_DispelMagic" },
							[2] = { maxrank = 5, name = "Arcane Focus", icon = "Interface\\Icons\\Spell_Holy_Devotion" },
							[3] = { maxrank = 5, name = "Improved Arcane Missiles", icon = "Interface\\Icons\\Spell_Nature_StarFall" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Wand Specialization", icon = "Interface\\Icons\\INV_Wand_01" },
							[3] = { maxrank = 5, name = "Arcane Concentration", icon = "Interface\\Icons\\Spell_Shadow_ManaBurn" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Dampen Magic", icon = "Interface\\Icons\\Spell_Nature_AbolishMagic" },
							[2] = { maxrank = 5, name = "Improved Arcane Explosion", icon = "Interface\\Icons\\Spell_Nature_WispSplode" },
							[3] = { maxrank = 1, name = "Evocation", icon = "Interface\\Icons\\Spell_Nature_Purge" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Mana Shield", icon = "Interface\\Icons\\Spell_Shadow_DetectLesserInvisibility" },
							[2] = { maxrank = 2, name = "Improved Counterspell", icon = "Interface\\Icons\\Spell_Frost_IceShock" },
							[4] = { maxrank = 5, name = "Arcane Meditation", icon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Presence of Mind", icon = "Interface\\Icons\\Spell_Nature_EnchantArmor" },
							[3] = { maxrank = 4, name = "Arcane Mind", icon = "Interface\\Icons\\Spell_Shadow_Charm" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 3, name = "Arcane Instability", icon = "Interface\\Icons\\Spell_Shadow_Teleport" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Arcane Power", icon = "Interface\\Icons\\Spell_Nature_Lightning" },
						}
					},
				},
			},
 			[2] = {
				name = "Fire", 
				background = "Fire", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Fireball", icon = "Interface\\Icons\\Spell_Fire_FlameBolt" },
							[3] = { maxrank = 5, name = "Impact", icon = "Interface\\Icons\\Spell_Fire_MeteorStorm" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Ignite", icon = "Interface\\Icons\\Spell_Fire_Incinerate" },
							[3] = { maxrank = 5, name = "Improved Fire Blast", icon = "Interface\\Icons\\Spell_Fire_Fireball" },
							[4] = { maxrank = 2, name = "Flame Throwing", icon = "Interface\\Icons\\Spell_Fire_Flare" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Incinerate", icon = "Interface\\Icons\\Spell_Fire_FlameShock" },
							[2] = { maxrank = 1, name = "Pyroblast", icon = "Interface\\Icons\\Spell_Fire_Fireball02" },
							[3] = { maxrank = 3, name = "Improved Flamestrike", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct" },
							[4] = { maxrank = 3, name = "Burning Soul", icon = "Interface\\Icons\\Spell_Fire_Fire" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Scorch", icon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
							[2] = { maxrank = 2, name = "Improved Fire Ward", icon = "Interface\\Icons\\Spell_Fire_FireArmor" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 3, name = "Critical Mass", icon = "Interface\\Icons\\Spell_Nature_WispHeal" },
							[3] = { maxrank = 1, name = "Blast Wave", icon = "Interface\\Icons\\Spell_Holy_Excorcism_02" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Fire Power", icon = "Interface\\Icons\\Spell_Fire_Immolation" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Combustion", icon = "Interface\\Icons\\Spell_Fire_SealOfFire" },
						}
					},
				},
			},
 			[3] = {
				name = "Frost", 
				background = "Frost", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Frostbolt", icon = "Interface\\Icons\\Spell_Frost_FrostBolt02" },
							[3] = { maxrank = 5, name = "Permafrost", icon = "Interface\\Icons\\Spell_Frost_Wisp" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Ice Shards", icon = "Interface\\Icons\\Spell_Frost_IceShard" },
							[2] = { maxrank = 3, name = "Winter's Chill", icon = "Interface\\Icons\\Spell_Frost_ChillingBlast" },
							[3] = { maxrank = 2, name = "Improved Frost Nova", icon = "Interface\\Icons\\Spell_Frost_FreezingBreath" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Piercing Ice", icon = "Interface\\Icons\\Spell_Frost_Frostbolt" },
							[2] = { maxrank = 1, name = "Cold Snap", icon = "Interface\\Icons\\Spell_Frost_WizardMark" },
							[4] = { maxrank = 3, name = "Improved Blizzard", icon = "Interface\\Icons\\Spell_Frost_IceStorm" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Arctic Reach", icon = "Interface\\Icons\\Spell_Shadow_DarkRitual" },
							[2] = { maxrank = 3, name = "Frost Channeling", icon = "Interface\\Icons\\Spell_Frost_Stun" },
							[3] = { maxrank = 5, name = "Shatter", icon = "Interface\\Icons\\Spell_Frost_FrostShock" },
							[4] = { maxrank = 1, name = "Improved Frost Ward", icon = "Interface\\Icons\\Spell_Frost_FrostWard" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Ice Block", icon = "Interface\\Icons\\Spell_Frost_Frost" },
							[3] = { maxrank = 3, name = "Improved Cone of Cold", icon = "Interface\\Icons\\Spell_Frost_Glacier" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Frostbite", icon = "Interface\\Icons\\Spell_Frost_FrostArmor" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Ice Barrier", icon = "Interface\\Icons\\Spell_Ice_Lament" },
						}
					},
				},
			},
		},
	},
	PALADIN = {
		classname = "Paladin",
		classcoords = { 0, 0.25, 0.5, 0.75 },
		color = { r = 0.96; g = 0.55; b = 0.73; },
		reagents = {
			[1] = {
				name = "Symbol of Divinity",
				icon = "Interface\\Icons\\INV_Stone_WeightStone_05",
			},
			[2] = {
				name = "Symbol of Kings",
				icon = "Interface\\Icons\\INV_Misc_SymbolofKings_01",
			},
			[3] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
		},
		talenttab = {
			[1] = {
				name = "Holy", 
				background = "Holy", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Divine Strength", icon = "Interface\\Icons\\Ability_GolemThunderClap" },
							[3] = { maxrank = 5, name = "Divine Intellect", icon = "Interface\\Icons\\Spell_Nature_Sleep" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Spiritual Focus", icon = "Interface\\Icons\\Spell_Arcane_Blink" },
							[3] = { maxrank = 5, name = "Improved Seal of Righteousness", icon = "Interface\\Icons\\Ability_ThunderBolt" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Healing Light", icon = "Interface\\Icons\\Spell_Holy_HolyBolt" },
							[2] = { maxrank = 1, name = "Consecration", icon = "Interface\\Icons\\Spell_Holy_InnerFire" },
							[3] = { maxrank = 2, name = "Improved Lay on Hands", icon = "Interface\\Icons\\Spell_Holy_LayOnHands" },
							[4] = { maxrank = 2, name = "Unyielding Faith", icon = "Interface\\Icons\\Spell_Holy_UnyieldingFaith" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Illumination", icon = "Interface\\Icons\\Spell_Holy_GreaterHeal" },
							[3] = { maxrank = 2, name = "Improved Blessing of Wisdom", icon = "Interface\\Icons\\Spell_Holy_SealOfWisdom" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Divine Favor", icon = "Interface\\Icons\\Spell_Holy_Heal" },
							[3] = { maxrank = 3, name = "Lasting Judgement", icon = "Interface\\Icons\\Spell_Holy_HealingAura" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Holy Power", icon = "Interface\\Icons\\Spell_Holy_Power" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Holy Shock", icon = "Interface\\Icons\\Spell_Holy_SearingLight" },
						}
					},
				},
			},
			[2] = {
				name = "Protection", 
				background = "Protection", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Devotion Aura", icon = "Interface\\Icons\\Spell_Holy_DevotionAura" },
							[3] = { maxrank = 5, name = "Redoubt", icon = "Interface\\Icons\\Ability_Defend" },
						}
					},
					[2] = {
							[1] = { maxrank = 3, name = "Precision", icon = "Interface\\Icons\\Ability_Rogue_Ambush" },
							[2] = { maxrank = 2, name = "Guardian's Favor", icon = "Interface\\Icons\\Spell_Holy_SealOfProtection" },
							[4] = { maxrank = 5, name = "Toughness", icon = "Interface\\Icons\\Spell_Holy_Devotion" },
						col = {
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Blessing of Kings", icon = "Interface\\Icons\\Spell_Magic_MageArmor" },
							[2] = { maxrank = 3, name = "Improved Righteous Fury", icon = "Interface\\Icons\\Spell_Holy_SealOfFury" },
							[3] = { maxrank = 3, name = "Shield Specialization", icon = "Interface\\Icons\\INV_Shield_06" },
							[4] = { maxrank = 5, name = "Anticipation", icon = "Interface\\Icons\\Spell_Magic_LesserInvisibilty" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 3, name = "Improved Hammer of Justice", icon = "Interface\\Icons\\Spell_Holy_SealOfMight" },
							[3] = { maxrank = 3, name = "Improved Concentration Aura", icon = "Interface\\Icons\\Spell_Holy_MindSooth" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Blessing of Sanctuary", icon = "Interface\\Icons\\Spell_Nature_LightningShield" },
							[3] = { maxrank = 5, name = "Reckoning", icon = "Interface\\Icons\\Spell_Holy_BlessingOfStrength" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "One-Handed Weapon Specialization", icon = "Interface\\Icons\\INV_Sword_20" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Holy Shield", icon = "Interface\\Icons\\Spell_Holy_BlessingOfProtection" },
						}
					},
				},
			},
			[3] = {
				name = "Retribution",
				background = "Combat", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Blessing of Might", icon = "Interface\\Icons\\Spell_Holy_FistOfJustice" },
							[3] = { maxrank = 5, name = "Benediction", icon = "Interface\\Icons\\Spell_Frost_WindWalkOn" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Judgement", icon = "Interface\\Icons\\Spell_Holy_RighteousFury" },
							[2] = { maxrank = 3, name = "Improved Seal of the Crusader", icon = "Interface\\Icons\\Spell_Holy_HolySmite" },
							[3] = { maxrank = 5, name = "Deflection", icon = "Interface\\Icons\\Ability_Parry" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Vindication", icon = "Interface\\Icons\\Spell_Holy_Vindication" },
							[2] = { maxrank = 5, name = "Conviction", icon = "Interface\\Icons\\Spell_Holy_RetributionAura" },
							[3] = { maxrank = 1, name = "Seal of Command", icon = "Interface\\Icons\\Ability_Warrior_InnerRage" },
							[4] = { maxrank = 2, name = "Pursuit of Justice", icon = "Interface\\Icons\\Spell_Holy_PersuitofJustice" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Eye for an Eye", icon = "Interface\\Icons\\Spell_Holy_EyeforanEye" },
							[3] = { maxrank = 2, name = "Improved Retribution Aura", icon = "Interface\\Icons\\Spell_Holy_AuraOfLight" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 3, name = "Two-Handed Weapon Specialization", icon = "Interface\\Icons\\INV_Hammer_04" },
							[3] = { maxrank = 1, name = "Sanctity Aura", icon = "Interface\\Icons\\Spell_Holy_MindVision" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Vengeance", icon = "Interface\\Icons\\Ability_Racial_Avatar" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Repentance", icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing" },
						}
					},
				},
			},
		},
	},
	PRIEST = {
		classname = "Priest",
		classcoords = { 0.49609375, 0.7421875, 0.25, 0.5 },
		color = { r = 1.0; g = 1.0; b = 1.0; },
		reagents = {
			[1] = {
				name = "Sacred Candle",
				icon = "Interface\\Icons\\INV_Misc_Candle_02",
			},
			[2] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
		},
		talenttab = {
			[1] = {
				name = "Discipline", 
				background = "Discipline", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Unbreakable Will", icon = "Interface\\Icons\\Spell_Magic_MageArmor" },
							[3] = { maxrank = 5, name = "Wand Specialization", icon = "Interface\\Icons\\INV_Wand_01" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Silent Resolve", icon = "Interface\\Icons\\Spell_Nature_ManaRegenTotem" },
							[2] = { maxrank = 2, name = "Improved Power Word: Fortitude", icon = "Interface\\Icons\\Spell_Holy_WordFortitude" },
							[3] = { maxrank = 3, name = "Improved Power Word: Shield", icon = "Interface\\Icons\\Spell_Holy_PowerWordShield" },
							[4] = { maxrank = 2, name = "Martyrdom", icon = "Interface\\Icons\\Spell_Nature_Tranquility" },
						}
					},
					[3] = {
						col = {
							[2] = { maxrank = 1, name = "Inner Focus", icon = "Interface\\Icons\\Spell_Frost_WindWalkOn" },
							[3] = { maxrank = 3, name = "Meditation", icon = "Interface\\Icons\\Spell_Nature_Sleep" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Inner Fire", icon = "Interface\\Icons\\Spell_Holy_InnerFire" },
							[2] = { maxrank = 5, name = "Mental Agility", icon = "Interface\\Icons\\Ability_Hibernation" },
							[4] = { maxrank = 2, name = "Improved Mana Burn", icon = "Interface\\Icons\\Spell_Shadow_ManaBurn" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 5, name = "Mental Strength", icon = "Interface\\Icons\\Spell_Nature_EnchantArmor" },
							[3] = { maxrank = 1, name = "Divine Spirit", icon = "Interface\\Icons\\Spell_Holy_DivineSpirit" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Force of Will", icon = "Interface\\Icons\\Spell_Nature_SlowingTotem" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Power Infusion", icon = "Interface\\Icons\\Spell_Holy_PowerInfusion" },
						}
					},
				},
			},
			[2] = {
				name = "Holy",
				background = "Holy", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 2, name = "Healing Focus", icon = "Interface\\Icons\\Spell_Holy_HealingFocus" },
							[2] = { maxrank = 3, name = "Improved Renew", icon = "Interface\\Icons\\Spell_Holy_Renew" },
							[3] = { maxrank = 5, name = "Holy Specialization", icon = "Interface\\Icons\\Spell_Holy_SealOfSalvation" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Spell Warding", icon = "Interface\\Icons\\Spell_Holy_SpellWarding" },
							[3] = { maxrank = 5, name = "Divine Fury", icon = "Interface\\Icons\\Spell_Holy_SealOfWrath" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Holy Nova", icon = "Interface\\Icons\\Spell_Holy_HolyNova" },
							[2] = { maxrank = 3, name = "Blessed Recovery", icon = "Interface\\Icons\\Spell_Holy_BlessedRecovery" },
							[4] = { maxrank = 3, name = "Inspiration", icon = "Interface\\Icons\\Spell_Holy_LayOnHands" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Holy Reach", icon = "Interface\\Icons\\Spell_Holy_Purify" },
							[2] = { maxrank = 3, name = "Improved Healing", icon = "Interface\\Icons\\Spell_Holy_Heal02" },
							[3] = { maxrank = 2, name = "Searing Light", icon = "Interface\\Icons\\Spell_Holy_SearingLightPriest" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Prayer of Healing", icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02" },
							[2] = { maxrank = 1, name = "Spirit of Redemption", icon = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge" },
							[3] = { maxrank = 5, name = "Spiritual Guidance", icon = "Interface\\Icons\\Spell_Holy_SpiritualGuidence" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Spiritual Healing", icon = "Interface\\Icons\\Spell_Nature_MoonGlow" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Lightwell", icon = "Interface\\Icons\\Spell_Holy_SummonLightwell" },
						}
					},
				},
			},
			[3] = {
				name = "Shadow",
				background = "Shadow", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Spirit Tap", icon = "Interface\\Icons\\Spell_Shadow_Requiem" },
							[3] = { maxrank = 5, name = "Blackout", icon = "Interface\\Icons\\Spell_Shadow_GatherShadows" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Shadow Affinity", icon = "Interface\\Icons\\Spell_Shadow_ShadowWard" },
							[2] = { maxrank = 2, name = "Improved Shadow Word: Pain", icon = "Interface\\Icons\\Spell_Shadow_ShadowWordPain" },
							[3] = { maxrank = 5, name = "Shadow Focus", icon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Psychic Scream", icon = "Interface\\Icons\\Spell_Shadow_PsychicScream" },
							[2] = { maxrank = 5, name = "Improved Mind Blast", icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy" },
							[3] = { maxrank = 1, name = "Mind Flay", icon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 2, name = "Improved Fade", icon = "Interface\\Icons\\Spell_Magic_LesserInvisibilty" },
							[3] = { maxrank = 3, name = "Shadow Reach", icon = "Interface\\Icons\\Spell_Shadow_ChillTouch" },
							[4] = { maxrank = 5, name = "Shadow Weaving", icon = "Interface\\Icons\\Spell_Shadow_BlackPlague" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 1, name = "Silence", icon = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift" },
							[2] = { maxrank = 1, name = "Vampiric Embrace", icon = "Interface\\Icons\\Spell_Shadow_UnsummonBuilding" },
							[3] = { maxrank = 2, name = "Improved Vampiric Embrace", icon = "Interface\\Icons\\Spell_Shadow_ImprovedVampiricEmbrace" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Darkness", icon = "Interface\\Icons\\Spell_Shadow_Twilight" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Shadowform", icon = "Interface\\Icons\\Spell_Shadow_Shadowform" },
						}
					},
				},
			},
		},
	},
	ROGUE = {
		classname = "Rogue",
		classcoords = { 0.49609375, 0.7421875, 0, 0.25 },
		color = { r = 1.0; g = 0.96; b = 0.41; },
		reagents = {
			[1] = {
				name = "Instant Poison",
				icon = "Interface\\Icons\\Ability_PoisonArrow",
			},
			[2] = {
				name = "Heavy Runecloth Bandage",
				icon = "Interface\\Icons\\INV_Misc_Bandage_12",
			},
			[3] = {
				name = "Major Healing Potion",
				icon = "Interface\\Icons\\INV_Potion_54",
			},
			[4] = {
				name = "Mongoose Potion",
				icon = "Interface\\Icons\\INV_Potion_32",
			},
			[5] = {
				name = "Ground Scorpok Assay",
				icon = "Interface\\Icons\\INV_Misc_Dust_02",
			},
		},
		talenttab = {
			[1] = {
				name = "Assassination", 
				background = "Assassination", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Eviscerate", icon = "Interface\\Icons\\Ability_Rogue_Eviscerate" },
							[2] = { maxrank = 5, name = "Remorseless Attacks", icon = "Interface\\Icons\\Ability_FiegnDead" },
							[3] = { maxrank = 5, name = "Malice", icon = "Interface\\Icons\\Ability_Racial_BloodRage" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Ruthlessness", icon = "Interface\\Icons\\Ability_Druid_Disembowel" },
							[2] = { maxrank = 2, name = "Murder", icon = "Interface\\Icons\\Spell_Shadow_DeathScream" },
							[4] = { maxrank = 3, name = "Improved Slice and Dice", icon = "Interface\\Icons\\Ability_Rogue_SliceDice" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Relentless Strikes", icon = "Interface\\Icons\\Ability_Warrior_DecisiveStrike" },
							[2] = { maxrank = 3, name = "Improved Expose Armor", icon = "Interface\\Icons\\Ability_Warrior_Riposte" },
							[3] = { maxrank = 5, name = "Lethality", icon = "Interface\\Icons\\Ability_CriticalStrike" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Vile Poisons", icon = "Interface\\Icons\\Ability_Rogue_FeignDeath" },
							[3] = { maxrank = 5, name = "Improved Instant Poison", icon = "Interface\\Icons\\Ability_Poisons" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Kidney Shot", icon = "Interface\\Icons\\Ability_Rogue_KidneyShot" },
							[2] = { maxrank = 1, name = "Cold Blood", icon = "Interface\\Icons\\Spell_Ice_Lament" },
							[3] = { maxrank = 5, name = "Improved Deadly Poison", icon = "Interface\\Icons\\Ability_Rogue_DualWeild" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Seal Fate", icon = "Interface\\Icons\\Spell_Shadow_ChillTouch" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Vigor", icon = "Interface\\Icons\\Spell_Nature_EarthBindTotem" },
						}
					},
				},
			},
			[2] = {
				name = "Combat", 
				background = "Combat", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Gouge", icon = "Interface\\Icons\\Ability_Gouge" },
							[2] = { maxrank = 2, name = "Improved Sinister Strike", icon = "Interface\\Icons\\Spell_Shadow_RitualOfSacrifice" },
							[3] = { maxrank = 5, name = "Lightning Reflexes", icon = "Interface\\Icons\\Spell_Nature_Invisibilty" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Backstab", icon = "Interface\\Icons\\Ability_BackStab" },
							[2] = { maxrank = 5, name = "Deflection", icon = "Interface\\Icons\\Ability_Parry" },
							[3] = { maxrank = 5, name = "Precision", icon = "Interface\\Icons\\Ability_Marksmanship" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Evasion", icon = "Interface\\Icons\\Spell_Shadow_ShadowWard" },
							[2] = { maxrank = 1, name = "Riposte", icon = "Interface\\Icons\\Ability_Warrior_Challange" },
							[4] = { maxrank = 3, name = "Improved Sprint", icon = "Interface\\Icons\\Ability_Rogue_Sprint" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Kick", icon = "Interface\\Icons\\Ability_Kick" },
							[2] = { maxrank = 5, name = "Dagger Specialization", icon = "Interface\\Icons\\INV_Weapon_ShortBlade_05" },
							[3] = { maxrank = 5, name = "Dual Wield Specialization", icon = "Interface\\Icons\\Ability_DualWield" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 5, name = "Mace Specialization", icon = "Interface\\Icons\\INV_Mace_01" },
							[2] = { maxrank = 1, name = "Blade Flurry", icon = "Interface\\Icons\\Ability_Warrior_PunishingBlow" },
							[3] = { maxrank = 5, name = "Sword Specialization", icon = "Interface\\Icons\\INV_Sword_27" },
							[4] = { maxrank = 5, name = "Fist Weapon Specialization", icon = "Interface\\Icons\\INV_Gauntlets_04" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 2, name = "Throwing Weapon Specialization", icon = "Interface\\Icons\\INV_ThrowingKnife_01" },
							[3] = { maxrank = 3, name = "Aggression", icon = "Interface\\Icons\\Ability_Racial_Avatar" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Adrenaline Rush", icon = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate" },
						}
					},
				},
			},
			[3] = {
				name = "Subtlety", 
				background = "Subtlety", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 5, name = "Rapid Concealment", icon = "Interface\\Icons\\Ability_Ambush" },
							[2] = { maxrank = 5, name = "Master of Deception", icon = "Interface\\Icons\\Spell_Shadow_Charm" },
							[3] = { maxrank = 5, name = "Camouflage", icon = "Interface\\Icons\\Ability_Stealth" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Elusiveness", icon = "Interface\\Icons\\Spell_Magic_LesserInvisibilty" },
							[3] = { maxrank = 5, name = "Opportunity", icon = "Interface\\Icons\\Ability_Warrior_WarCry" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 5, name = "Initiative", icon = "Interface\\Icons\\Spell_Shadow_Fumble" },
							[2] = { maxrank = 1, name = "Ghostly Strike", icon = "Interface\\Icons\\Spell_Shadow_Curse" },
							[3] = { maxrank = 2, name = "Improved Garrote", icon = "Interface\\Icons\\Ability_Rogue_Garrote" },
							[4] = { maxrank = 3, name = "Improved Ambush", icon = "Interface\\Icons\\Ability_Rogue_Ambush" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Vanish", icon = "Interface\\Icons\\Ability_Vanish" },
							[3] = { maxrank = 3, name = "Improved Rupture", icon = "Interface\\Icons\\Ability_Rogue_Rupture" },
							[4] = { maxrank = 3, name = "Improved Sap", icon = "Interface\\Icons\\Ability_Sap" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 1, name = "Preparation", icon = "Interface\\Icons\\Spell_Shadow_AntiShadow" },
							[3] = { maxrank = 2, name = "Improved Cheap Shot", icon = "Interface\\Icons\\Ability_CheapShot" },
							[4] = { maxrank = 2, name = "Improved Distract", icon = "Interface\\Icons\\Ability_Rogue_Distract" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 3, name = "Setup", icon = "Interface\\Icons\\Spell_Nature_MirrorImage" },
							[3] = { maxrank = 1, name = "Hemorrhage", icon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Premeditation", icon = "Interface\\Icons\\Spell_Shadow_Possession" },
						}
					},
				},
			},
		},
	},
	SHAMAN = {
		classname = "Shaman",
		classcoords = { 0.25, 0.49609375, 0.25, 0.5 },
		color = { r = 0.96; g = 0.55; b = 0.73; },
		reagents = {
			[1] = {
				name = "Ankh",
				icon = "Interface\\Icons\\INV_Jewelry_Talisman_06",
			},
			[2] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
		},
		talenttab = {
 			[1] = {
				name = "Elemental", 
				background = "Elemental", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Lightning Bolt", icon = "Interface\\Icons\\Spell_Nature_Lightning" },
							[3] = { maxrank = 5, name = "Concussion", icon = "Interface\\Icons\\Spell_Fire_Fireball" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Stoneclaw Totem", icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem" },
							[2] = { maxrank = 5, name = "Call of Flame", icon = "Interface\\Icons\\Spell_Fire_Immolation" },
							[3] = { maxrank = 5, name = "Convection", icon = "Interface\\Icons\\Spell_Nature_WispSplode" },
							[4] = { maxrank = 2, name = "Improved Searing Totem", icon = "Interface\\Icons\\Spell_Fire_SearingTotem" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Elemental Focus", icon = "Interface\\Icons\\Spell_Shadow_ManaBurn" },
							[2] = { maxrank = 5, name = "Call of Thunder", icon = "Interface\\Icons\\Spell_Nature_CallStorm" },
							[3] = { maxrank = 5, name = "Reverberation", icon = "Interface\\Icons\\Spell_Frost_FrostWard" },
						}
					},
					[4] = {
						col = {
							[3] = { maxrank = 2, name = "Improved Fire Nova Totem", icon = "Interface\\Icons\\Spell_Fire_SealOfFire" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Elemental Fury", icon = "Interface\\Icons\\Spell_Fire_Volcano" },
							[3] = { maxrank = 2, name = "Improved Magma Totem", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct" },
						}
					},
					[6] = {
						col = {
							[1] = { maxrank = 5, name = "Lightning Mastery", icon = "Interface\\Icons\\Spell_Lightning_LightningBolt01" },
							[3] = { maxrank = 2, name = "Improved Chain Lightning", icon = "Interface\\Icons\\Spell_Nature_ChainLightning" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Elemental Mastery", icon = "Interface\\Icons\\Spell_Nature_WispHeal" },
						}
					},
				},
			},
 			[2] = {
				name = "Enhancement", 
				background = "Enhancement", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Ancestral Knowledge", icon = "Interface\\Icons\\Spell_Shadow_GrimWard" },
							[3] = { maxrank = 5, name = "Shield Specialization", icon = "Interface\\Icons\\INV_Shield_06" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Stoneskin Totem", icon = "Interface\\Icons\\Spell_Nature_StoneSkinTotem" },
							[2] = { maxrank = 5, name = "Thundering Strikes", icon = "Interface\\Icons\\Ability_ThunderBolt" },
							[3] = { maxrank = 2, name = "Improved Ghost Wolf", icon = "Interface\\Icons\\Spell_Nature_SpiritWolf" },
							[4] = { maxrank = 3, name = "Improved Lightning Shield", icon = "Interface\\Icons\\Spell_Nature_LightningShield" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Strength of Earth Totem", icon = "Interface\\Icons\\Spell_Nature_EarthBindTotem" },
							[3] = { maxrank = 1, name = "Two-Handed Axes and Maces", icon = "Interface\\Icons\\INV_Axe_10" },
							[4] = { maxrank = 5, name = "Anticipation", icon = "Interface\\Icons\\Spell_Nature_MirrorImage" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Flurry", icon = "Interface\\Icons\\Ability_GhoulFrenzy" },
							[3] = { maxrank = 2, name = "Improved Rockbiter Weapon", icon = "Interface\\Icons\\Spell_Nature_RockBiter" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Flametongue Weapon", icon = "Interface\\Icons\\Spell_Fire_FlameTounge" },
							[2] = { maxrank = 1, name = "Parry", icon = "Interface\\Icons\\Ability_Parry" },
							[3] = { maxrank = 2, name = "Improved Frostbrand Weapon", icon = "Interface\\Icons\\Spell_Frost_FrostBrand" },
							[4] = { maxrank = 2, name = "Improved Windfury Weapon", icon = "Interface\\Icons\\Spell_Nature_Cyclone" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Toughness", icon = "Interface\\Icons\\Spell_Holy_Devotion" },
							[3] = { maxrank = 2, name = "Improved Grounding Totem", icon = "Interface\\Icons\\Spell_Nature_GroundingTotem" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Stormstrike", icon = "Interface\\Icons\\Spell_Holy_SealOfMight" },
							[3] = { maxrank = 3, name = "Improved Grace of Air Totem", icon = "Interface\\Icons\\Spell_Nature_InvisibilityTotem" },
						}
					},
				},
			},
 			[3] = {
				name = "Restoration",
				background = "Restoration", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Healing Wave", icon = "Interface\\Icons\\Spell_Nature_MagicImmunity" },
							[3] = { maxrank = 5, name = "Tidal Focus", icon = "Interface\\Icons\\Spell_Frost_ManaRecharge" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Reincarnation", icon = "Interface\\Icons\\Spell_Nature_Reincarnation" },
							[2] = { maxrank = 5, name = "Ancestral Healing", icon = "Interface\\Icons\\Spell_Nature_UndyingStrength" },
							[3] = { maxrank = 5, name = "Totemic Focus", icon = "Interface\\Icons\\Spell_Nature_MoonGlow" },
						}
					},
					[3] = {
						col = {
							[2] = { maxrank = 5, name = "Eventide", icon = "Interface\\Icons\\Spell_Frost_Stun" },
							[3] = { maxrank = 1, name = "Combat Endurance", icon = "Interface\\Icons\\Spell_Nature_AncestralGuardian" },
							[4] = { maxrank = 5, name = "Improved Lesser Healing Wave", icon = "Interface\\Icons\\Spell_Nature_HealingWaveLesser" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Healing Stream Totem", icon = "Interface\\Icons\\INV_Spear_04" },
							[3] = { maxrank = 5, name = "Tidal Mastery", icon = "Interface\\Icons\\Spell_Nature_Tranquility" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Mana Spring Totem", icon = "Interface\\Icons\\Spell_Nature_ManaRegenTotem" },
							[3] = { maxrank = 1, name = "Nature's Swiftness", icon = "Interface\\Icons\\Spell_Nature_RavenForm" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Purification", icon = "Interface\\Icons\\Spell_Frost_WizardMark" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Mana Tide Totem", icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental" },
						}
					},
				},
			},
		},
	},
	WARLOCK = {
		classname = "Warlock",
		classcoords = { 0.7421875, 0.98828125, 0.25, 0.5 },
		color = { r = 0.58; g = 0.51; b = 0.79; },
		reagents = {
			[1] = {
				name = "Soul Shard",
				icon = "Interface\\Icons\\INV_Misc_Gem_Amethyst_02c",
			},
			[2] = {
				name = "Major Mana Potion",
				icon = "Interface\\Icons\\INV_Potion_76",
			},
			[3] = {
				name = "Heavy Runecloth Bandage",
				icon = "Interface\\Icons\\INV_Misc_Bandage_12",
			},
		},
		talenttab = {
			[1] = {
				name = "Affliction", 
				background = "Curses", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Suppression", icon = "Interface\\Icons\\Spell_Shadow_UnsummonBuilding" },
							[3] = { maxrank = 5, name = "Improved Corruption", icon = "Interface\\Icons\\Spell_Shadow_AbominationExplosion" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Curse of Weakness", icon = "Interface\\Icons\\Spell_Shadow_CurseOfMannoroth" },
							[2] = { maxrank = 2, name = "Improved Drain Soul", icon = "Interface\\Icons\\Spell_Shadow_Haunting" },
							[3] = { maxrank = 2, name = "Improved Life Tap", icon = "Interface\\Icons\\Spell_Shadow_BurningSpirit" },
							[4] = { maxrank = 5, name = "Improved Drain Life", icon = "Interface\\Icons\\Spell_Shadow_LifeDrain02" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Curse of Agony", icon = "Interface\\Icons\\Spell_Shadow_CurseOfSargeras" },
							[2] = { maxrank = 5, name = "Fel Concentration", icon = "Interface\\Icons\\Spell_Shadow_FingerOfDeath" },
							[3] = { maxrank = 1, name = "Amplify Curse", icon = "Interface\\Icons\\Spell_Shadow_Contagion" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Grim Reach", icon = "Interface\\Icons\\Spell_Shadow_CallofBone" },
							[2] = { maxrank = 2, name = "Nightfall", icon = "Interface\\Icons\\Spell_Shadow_Twilight" },
							[4] = { maxrank = 2, name = "Improved Drain Mana", icon = "Interface\\Icons\\Spell_Shadow_SiphonMana" },
						}
					},
					[5] = {
						col = {
							[2] = { maxrank = 1, name = "Siphon Life", icon = "Interface\\Icons\\Spell_Shadow_Requiem" },
							[3] = { maxrank = 1, name = "Curse of Exhaustion", icon = "Interface\\Icons\\Spell_Shadow_GrimWard" },
							[4] = { maxrank = 4, name = "Improved Curse of Exhaustion", icon = "Interface\\Icons\\Spell_Shadow_GrimWard" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "Shadow Mastery", icon = "Interface\\Icons\\Spell_Shadow_ShadeTrueSight" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Dark Pact", icon = "Interface\\Icons\\Spell_Shadow_DarkRitual" },
						}
					},
				},
			},
			[2] = {
				name = "Demonology", 
				background = "Summoning", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Healthstone", icon = "Interface\\Icons\\INV_Stone_04" },
							[2] = { maxrank = 3, name = "Improved Imp", icon = "Interface\\Icons\\Spell_Shadow_SummonImp" },
							[3] = { maxrank = 5, name = "Demonic Embrace", icon = "Interface\\Icons\\Spell_Shadow_Metamorphosis" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Health Funnel", icon = "Interface\\Icons\\Spell_Shadow_LifeDrain" },
							[2] = { maxrank = 3, name = "Improved Voidwalker", icon = "Interface\\Icons\\Spell_Shadow_SummonVoidWalker" },
							[3] = { maxrank = 5, name = "Fel Intellect", icon = "Interface\\Icons\\Spell_Holy_MagicalSentry" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Succubus", icon = "Interface\\Icons\\Spell_Shadow_SummonSuccubus" },
							[2] = { maxrank = 1, name = "Fel Domination", icon = "Interface\\Icons\\Spell_Nature_RemoveCurse" },
							[3] = { maxrank = 5, name = "Fel Stamina", icon = "Interface\\Icons\\Spell_Shadow_AntiShadow" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 2, name = "Master Summoner", icon = "Interface\\Icons\\Spell_Shadow_ImpPhaseShift" },
							[3] = { maxrank = 5, name = "Unholy Power", icon = "Interface\\Icons\\Spell_Shadow_ShadowWordDominate" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Enslave Demon", icon = "Interface\\Icons\\Spell_Shadow_EnslaveDemon" },
							[2] = { maxrank = 1, name = "Demonic Sacrifice", icon = "Interface\\Icons\\Spell_Shadow_PsychicScream" },
							[4] = { maxrank = 2, name = "Improved Firestone", icon = "Interface\\Icons\\INV_Ammo_FireTar" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Master Demonologist", icon = "Interface\\Icons\\Spell_Shadow_ShadowPact" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Soul Link", icon = "Interface\\Icons\\Spell_Shadow_GatherShadows" },
							[3] = { maxrank = 2, name = "Improved Spellstone", icon = "Interface\\Icons\\INV_Misc_Gem_Sapphire_01" },
						}
					},
				},
			},
			[3] = {
				name = "Destruction",
				background = "Destruction", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Shadow Bolt", icon = "Interface\\Icons\\Spell_Shadow_ShadowBolt" },
							[3] = { maxrank = 5, name = "Cataclysm", icon = "Interface\\Icons\\Spell_Fire_WindsofWoe" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Bane", icon = "Interface\\Icons\\Spell_Shadow_DeathPact" },
							[3] = { maxrank = 5, name = "Aftermath", icon = "Interface\\Icons\\Spell_Fire_Fire" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Firebolt", icon = "Interface\\Icons\\Spell_Fire_FireBolt" },
							[2] = { maxrank = 2, name = "Improved Lash of Pain", icon = "Interface\\Icons\\Spell_Shadow_Curse" },
							[3] = { maxrank = 5, name = "Devastation", icon = "Interface\\Icons\\Spell_Fire_FlameShock" },
							[4] = { maxrank = 1, name = "Shadowburn", icon = "Interface\\Icons\\Spell_Shadow_ScourgeBuild" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 2, name = "Intensity", icon = "Interface\\Icons\\Spell_Fire_LavaSpawn" },
							[2] = { maxrank = 2, name = "Destructive Reach", icon = "Interface\\Icons\\Spell_Shadow_CorpseExplode" },
							[4] = { maxrank = 5, name = "Improved Searing Pain", icon = "Interface\\Icons\\Spell_Fire_SoulBurn" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Pyroclasm", icon = "Interface\\Icons\\Spell_Fire_Volcano" },
							[2] = { maxrank = 5, name = "Improved Immolate", icon = "Interface\\Icons\\Spell_Fire_Immolation" },
							[3] = { maxrank = 1, name = "Ruin", icon = "Interface\\Icons\\Spell_Shadow_ShadowWordPain" },
						}
					},
					[6] = {
						col = {
							[3] = { maxrank = 5, name = "Emberstorm", icon = "Interface\\Icons\\Spell_Fire_SelfDestruct" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Conflagrate", icon = "Interface\\Icons\\Spell_Fire_Fireball" },
						}
					},
				},
			},
		},
	},
	WARLOCKPET = {
		color = { r = 0.55; g = 0.50; b = 0.80; },
	},
	WARRIOR = {
		classname = "Warrior",
		classcoords = { 0, 0.25, 0, 0.25 },
		color = { r = 0.78; g = 0.61; b = 0.43; },
		reagents = {
			[1] = {
				name = "Heavy Runecloth Bandage",
				icon = "Interface\\Icons\\INV_Misc_Bandage_12",
			},
			[2] = {
				name = "Major Healing Potion",
				icon = "Interface\\Icons\\INV_Potion_54",
			},
			[3] = {
				name = "Elixir of Giants",
				icon = "Interface\\Icons\\INV_Potion_61",
			},
			[4] = {
				name = "Lung Juice Cocktail",
				icon = "Interface\\Icons\\INV_Drink_12",
			},
		},
		talenttab = {
 			[1] = {
				name = "Arms", 
				background = "Arms", 
				row = {
					[1] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Heroic Strike", icon = "Interface\\Icons\\Ability_Rogue_Ambush" },
							[2] = { maxrank = 5, name = "Deflection", icon = "Interface\\Icons\\Ability_Parry" },
							[3] = { maxrank = 3, name = "Improved Rend", icon = "Interface\\Icons\\Ability_Gouge" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Charge", icon = "Interface\\Icons\\Ability_Warrior_Charge" },
							[2] = { maxrank = 5, name = "Tactical Mastery", icon = "Interface\\Icons\\Spell_Nature_EnchantArmor" },
							[4] = { maxrank = 3, name = "Improved Thunder Clap", icon = "Interface\\Icons\\Ability_ThunderClap" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Overpower", icon = "Interface\\Icons\\INV_Sword_05" },
							[2] = { maxrank = 1, name = "Anger Management", icon = "Interface\\Icons\\Spell_Holy_BlessingOfStamina" },
							[3] = { maxrank = 3, name = "Deep Wounds", icon = "Interface\\Icons\\Ability_BackStab" },
						}
					},
					[4] = {
						col = {
							[2] = { maxrank = 5, name = "Two-Handed Weapon Specialization", icon = "Interface\\Icons\\INV_Axe_09" },
							[3] = { maxrank = 2, name = "Impale", icon = "Interface\\Icons\\Ability_SearingArrow" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 5, name = "Axe Specialization", icon = "Interface\\Icons\\INV_Axe_06" },
							[2] = { maxrank = 1, name = "Sweeping Strikes", icon = "Interface\\Icons\\Ability_Rogue_SliceDice" },
							[3] = { maxrank = 5, name = "Mace Specialization", icon = "Interface\\Icons\\INV_Mace_01" },
							[4] = { maxrank = 5, name = "Sword Specialization", icon = "Interface\\Icons\\INV_Sword_27" },
						}
					},
					[6] = {
						col = {
							[1] = { maxrank = 5, name = "Polearm Specialization", icon = "Interface\\Icons\\INV_Weapon_Halbard_01" },
							[3] = { maxrank = 3, name = "Improved Hamstring", icon = "Interface\\Icons\\Ability_ShockWave" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Mortal Strike", icon = "Interface\\Icons\\Ability_Warrior_SavageBlow" },
						}
					},
				},
			},
 			[2] = {
				name = "Fury", 
				background = "Fury", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Booming Voice", icon = "Interface\\Icons\\Spell_Nature_Purge" },
							[3] = { maxrank = 5, name = "Cruelty", icon = "Interface\\Icons\\Ability_Rogue_Eviscerate" },
						}
					},
					[2] = {
						col = {
							[2] = { maxrank = 5, name = "Improved Demoralizing Shout", icon = "Interface\\Icons\\Ability_Warrior_WarCry" },
							[3] = { maxrank = 5, name = "Unbridled Wrath", icon = "Interface\\Icons\\Spell_Nature_StoneClawTotem" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Cleave", icon = "Interface\\Icons\\Ability_Warrior_Cleave" },
							[2] = { maxrank = 1, name = "Piercing Howl", icon = "Interface\\Icons\\Spell_Shadow_DeathScream" },
							[3] = { maxrank = 3, name = "Blood Craze", icon = "Interface\\Icons\\Spell_Shadow_SummonImp" },
							[4] = { maxrank = 5, name = "Improved Battle Shout", icon = "Interface\\Icons\\Ability_Warrior_BattleShout" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 5, name = "Dual Wield Specialization", icon = "Interface\\Icons\\Ability_DualWield" },
							[2] = { maxrank = 2, name = "Improved Execute", icon = "Interface\\Icons\\INV_Sword_48" },
							[3] = { maxrank = 5, name = "Enrage", icon = "Interface\\Icons\\Spell_Shadow_UnholyFrenzy" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 5, name = "Improved Slam", icon = "Interface\\Icons\\Ability_Warrior_DecisiveStrike" },
							[2] = { maxrank = 1, name = "Death Wish", icon = "Interface\\Icons\\Spell_Shadow_DeathPact" },
							[4] = { maxrank = 2, name = "Improved Intercept", icon = "Interface\\Icons\\Ability_Rogue_Sprint" },
						}
					},
					[6] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Berserker Rage", icon = "Interface\\Icons\\Spell_Nature_AncestralGuardian" },
							[3] = { maxrank = 5, name = "Flurry", icon = "Interface\\Icons\\Ability_GhoulFrenzy" },
						}
					},
					[7] = {
						col = {
							[2] = { maxrank = 1, name = "Bloodthirst", icon = "Interface\\Icons\\Spell_Nature_BloodLust" },
						}
					},
				},
			},
 			[3] = {
				name = "Protection", 
				background = "Protection", 
				row = {
					[1] = {
						col = {
							[2] = { maxrank = 5, name = "Shield Specialization", icon = "Interface\\Icons\\INV_Shield_06" },
							[3] = { maxrank = 5, name = "Anticipation", icon = "Interface\\Icons\\Spell_Nature_MirrorImage" },
						}
					},
					[2] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Bloodrage", icon = "Interface\\Icons\\Ability_Racial_BloodRage" },
							[3] = { maxrank = 5, name = "Toughness", icon = "Interface\\Icons\\Spell_Holy_Devotion" },
							[4] = { maxrank = 5, name = "Iron Will", icon = "Interface\\Icons\\Spell_Magic_MageArmor" },
						}
					},
					[3] = {
						col = {
							[1] = { maxrank = 1, name = "Last Stand", icon = "Interface\\Icons\\Spell_Holy_AshesToAshes" },
							[2] = { maxrank = 3, name = "Improved Shield Block", icon = "Interface\\Icons\\Ability_Defend" },
							[3] = { maxrank = 3, name = "Improved Revenge", icon = "Interface\\Icons\\Ability_Warrior_Revenge" },
							[4] = { maxrank = 5, name = "Defiance", icon = "Interface\\Icons\\Ability_Warrior_InnerRage" },
						}
					},
					[4] = {
						col = {
							[1] = { maxrank = 3, name = "Improved Sunder Armor", icon = "Interface\\Icons\\Ability_Warrior_Sunder" },
							[2] = { maxrank = 3, name = "Improved Disarm", icon = "Interface\\Icons\\Ability_Warrior_Disarm" },
							[3] = { maxrank = 2, name = "Improved Taunt", icon = "Interface\\Icons\\Spell_Nature_Reincarnation" },
						}
					},
					[5] = {
						col = {
							[1] = { maxrank = 2, name = "Improved Shield Wall", icon = "Interface\\Icons\\Ability_Warrior_ShieldWall" },
							[2] = { maxrank = 2, name = "Improved Shield Bash", icon = "Interface\\Icons\\Ability_Warrior_ShieldBash" },
							[3] = { maxrank = 1, name = "Concussion Blow", icon = "Interface\\Icons\\Ability_ThunderBolt" },
						}
					},
					[6] = {
						col = {
							[2] = { maxrank = 5, name = "One-Handed Weapon Specialization", icon = "Interface\\Icons\\INV_Sword_20" },
						}
					},
					[7] = {
						col = {
							[3] = { maxrank = 1, name = "Shield Slam", icon = "Interface\\Icons\\INV_Shield_05" },
						}
					},
				},
			},
		},
	},
	NPC = {
		color = { r = 0.5; g = 0.5; b = 0.5; },
	},
	BAND = {
		color = { r = 0.0; g = 1.0; b = 0.0; },
	},
	DUTY = {
		color = { r = 0.0; g = 1.0; b = 0.0; },
	},
};
