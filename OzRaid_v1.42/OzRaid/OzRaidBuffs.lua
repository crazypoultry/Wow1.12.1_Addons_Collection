-- BUFF DATA
--
-- Data is as:
--  (priority) (text name) (game texture name) (0=Buff, 1=Debuff)
--
-- <class>
--		<Buff> Buffs that this class can do on other players
--		<Pet> Buff icons thepets can have (not used)
--		<Debuff> Debuffs this player can put on mobs
--		<Player> Default important icons for players
--					- Includes major buffs from this class
--		<Mob> Default important debuffs on mobs
--					- Includes this class's debuffs (highest priority)
--					- Important support buffs
--					- Crowd control debuffs
--		<Cure> What debuffs this class can cure


OZ_BUFF_TABLE = {

HUNTER = {
	Buff = {
				{0,"Aspect of the Hawk","Spell_Nature_RavenForm", 0},
				{0,"Aspect of the Monkey", "Ability_Hunter_AspectOfTheMonkey", 0},
				{0,"Aspect of the Cheetah", "Ability_Mount_JungleTiger", 0},
				{0,"Aspect of the Pack", "Ability_Mount_WhiteTiger", 0},
				{0,"Aspect of the Beast", "Ability_Mount_PinkTiger", 0},
				{0,"Aspect of the Wild", "Spell_Nature_ProtectionformNature", 0},
				{0,"Rapid Fire", "Ability_Hunter_RunningShot", 0},
				{0,"Eyes of the Beast", "Ability_EyesOfTheOwl", 0},
				{0,"Deterrence", "Ability_Whirlwind", 0},
				{0,"Trueshot Aura", "Ability_TrueShot", 0},
			},
	Pet = {
				{0,"Feed Pet", "Hunter_BeastTraining", 0},
				{0,"Mend Pet", "Ability_Hunter_MendPet", 0},
				{0,"Dash", "Ability_Druid_Dash", 0},
				{0,"Prowl", "Ability_Druid_SupriseAttack", 0},
			},
	Debuff = {
				{0,"Concussive Shot", "Spell_Frost_Stun", 1},
				{2,"Hunter's Mark", "Ability_Hunter_SniperShot", 1},
				{0,"Wing Clip", "Ability_Rogue_Trip", 1},
				{0,"Serpent Sting", "Ability_Hunter_Quickshot", 1},
				{0,"Scorpid Sting", "Ability_Hunter_CriticalShot", 1},
				{0,"Viper Sting", "Ability_Hunter_AimedShot", 1},
				{0,"Scatter Shot", "Ability_GolemStormBolt", 1},
				{0,"Flare", "Ability_GolemStormBolt", 1},
				{1,"Freezing Trap", "Spell_Frost_ChainsOfIce", 1},
				{1,"Frost Trap", "Spell_Frost_FreezingBreath", 1},
				{0,"Immolate Trap(?)", "Spell_Fire_FlameShock", 1},
				{0,"Explosive Trap", "Spell_Fire_SelfDestruct", 1},
			},
	},


WARLOCK = {
	Buff = {
				{0,"Demon Skin/Demon Armor","Spell_Shadow_RagingScream", 0},
				{0,"Fire Shield","Spell_Fire_FireArmor", 0},
				{0,"Sacrifice","Spell_Shadow_SacrificialShield", 0},
				{1,"Unending Breath","Spell_Shadow_DemonBreath", 0},
				{0,"Eye of Kilrogg","Spell_Shadow_EvilEye", 0},
				{0,"Nightfall", "Spell_Shadow_Twilight", 0},
				{1,"Detect Lesser Invisibility", "Spell_Shadow_DetectLesserInvisibility", 0},
				{0,"Demonic Sacrifice", "Spell_Shadow_PsychicScream", 0},
				{0,"Shadow Ward", "Spell_Shadow_AntiShadow", 0},
				{0,"Master Demonologist", "Spell_Shadow_ShadowPact", 0},
				{1,"Detect Invisibility", "Spell_Shadow_DetectInvisibility", 0},
				{0,"Soul Link", "Spell_Shadow_GatherShadows", 0},
				{2,"Soulstone", "Spell_Shadow_SoulGem", 0},
				{0,"Summon Felsteed", "Spell_Nature_Swiftness", 0},
				{0,"Blood Pact", "Spell_Shadow_BloodBoil", 0},
				{0,"Paranoia", "Spell_Shadow_AuraOfDarkness", 0},
				{0,"Health Channel", "Spell_Shadow_LifeDrain", 0},
			},
	Pet = {
				{0,"Phase Shift", "Spell_Shadow_ImpPhaseShift", 0},
				{0,"Health Funnel", "Spell_Shadow_LifeDrain", 0},
				{0,"Consume Shadows", "Spell_Shadow_AntiShadow", 0},
				{0,"Lesser Invisibility", "Spell_Magic_LesserInvisibility", 0},
				{0,"Soul Link", "Spell_Shadow_GatherShadows", 0},
			},
	Debuff = {
				{1,"Corruption", "Spell_Shadow_AbominationExplosion", 1},
				{1,"Immolate", "Spell_Fire_Immolation", 1},
				{0,"Siphon Life", "Spell_Shadow_Requiem", 1},
				{0,"Drain Life", "Spell_Shadow_LifeDrain02", 1},
				{0,"Drain Soul", "Spell_Shadow_Haunting", 1},
				{0,"Drain Mana", "Spell_Shadow_SiphonMana", 1},
				{1,"Curse of Agony", "Spell_Shadow_CurseOfSargeras", 1},
				{1,"Curse of Idiocy", "Spell_Shadow_MindRot", 1},
				{1,"Curse of Weakness", "Spell_Shadow_CurseOfMannoroth", 1},
				{2,"Curse of Shadow", "Spell_Shadow_CurseOfAchimonde", 1},
				{2,"Curse of the Elements", "Spell_Shadow_ChillTouch", 1},
				{1,"Curse of Doom", "Spell_Shadow_AuraOfDarkness", 1},
				{1,"Curse of Tongues", "Spell_Shadow_CurseOfTounges", 1},
				{1,"Curse of Recklessness", "Spell_Shadow_UnholyStrength", 1},
				{1,"Curse of Exhaustion", "Spell_Shadow_GrimWard", 1},
				{0,"Improved Shadow Bolt effect", "Spell_Shadow_ShadowBolt", 1},
				{1,"Fear", "Spell_Shadow_Possession", 1},
				{2,"Banish", "Shadow_Cripple", 1},
				{0,"Enslave Demon", "Spell_Shadow_EnslaveDemon", 1},
				{0,"Succubus Seduction", "Spell_Shadow_MindSteal", 1},
				{0,"Tainted Blood", "Spell_Shadow_LifeDrain", 1},
				{0,"Spell Lock", "Spell_Shadow_MindRot", 1},
				{0,"Howl of Terror", "Spell_Shadow_DeathScream", 1},
				{0,"Death Coil", "Spell_Shadow_DeathCoil", 1},
			},
	},

PRIEST = {
	Buff = {
				{0,"Shadowform", "Spell_Shadow_Shadowform", 0},
				{2,"Shadow Protection", "Spell_Shadow_AntiShadow", 0},
				{2,"Prayer of Shadow Protection", "Spell_Holy_PrayerofShadowProtection", 0},
				{2,"Power Word: Fortitude", "Spell_Holy_WordFortitude", 0},
				{2,"Prayer of Fortitude", "Spell_Holy_PrayerOfFortitude", 0},
				{2,"Divine Spirit", "Spell_Holy_DivineSpirit", 0},
				{2,"Prayer of Spirit", "Spell_Holy_PrayerofSpirit", 0},
				{2,"Power Word: Shield", "Spell_Holy_PowerWordShield", 0},
				{2,"Renew", "Spell_Holy_Renew", 0},
				{1,"Mind Control", "Spell_Shadow_ShadowWordDominate", 0},
				{0,"Inner Fire", "Spell_Holy_InnerFire", 0},
				{0,"Inner Focus", "Spell_Frost_WindWalkOn", 0},
				{0,"Spirit Tap", "Spell_Shadow_Requiem", 0},
				{1,"Vampiric Embrace", "Spell_Shadow_UnsummonBuilding", 0},
				{0,"Fade", "Spell_Magic_LesserInvisibilty", 0},
				{2,"Power", "Infusion Spell_Holy_PowerInfusion", 0},
				{2,"Fear Ward", "Spell_Holy_Excorcism", 0},
				{0,"Touch of Weakness", "Spell_Shadow_DeadofNight", 0},
				{0,"Shadowguard", "Spell_Nature_LightningShield", 0},
				{0,"Elune's grace", "Spell_Holy_ElunesGrace", 0},
				{0,"Feedback", "Spell_Shadow_RitualOfSacrifice", 0},
				{0,"Abolish Disease", "Spell_Nature_NullifyDisease", 0},
				{0,"Levitate", "Spell_Holy_LayOnHands", 0},
				{0,"Lightwell Renew", "Spell_Holy_SummonLightwell", 0},
				{2,"Power Infusion", "Spell_Holy_PowerInfusion", 0},
			},
	Debuff = {
				{0,"Weakened Soul", "Spell_Holy_AshesToAshes", 1},
				{0,"Psychic Scream", "Spell_Shadow_PsychicScream", 1},
				{2,"Shackle Undead", "Spell_Nature_Slow", 1},
				{0,"Starfall", "Nature_Starfall", 1},
				{0,"Holy Fire", "Spell_Holy_SearingLight", 1},
				{0,"Shadow Word Pain", "Spell_Shadow_ShadowWordPain", 1},
				{0,"Hex of Weakness", "Spell_Shadow_FingerOfDeath", 1},
				{0,"Mind Soothe", "Spell_Holy_MindSooth", 1},
				{0,"Mind Flay", "Spell_Shadow_SiphonMana", 1},
				{0,"Devouring Plague", "Spell_Shadow_BlackPlague", 1},
				{1,"Mind Vision", "Spell_Holy_MindVision", 1},
				{1,"Mind Control", "Spell_Shadow_ShadowWordDominate", 1},
			},
	},

PALADIN = {
	Buff = {
				{0,"Divine Protection", "Spell_Holy_Restoration", 0},
				{0,"Divine Shield", "Spell_Holy_DivineIntervention", 0},
				{0,"Seal of Light", "Spell_Holy_HealingAura", 0},
				{0,"Seal of Wisdom", "Spell_Holy_RighteousnessAura", 0},
				{0,"Seal of the Crusader", "Spell_Holy_HolySmite", 0},
				{0,"Seal of Righteousness", "Ability_ThunderBolt", 0},
				{0,"Seal of Justice", "Spell_Holy_SealOfWrath", 0},
				{2,"Blessing of Kings", "Spell_Magic_MageArmor", 0},
				{2,"Blessing of Might", "Spell_Holy_FistOfJustice", 0},
				{2,"Blessing of Wisdom", "Spell_Holy_SealOfWisdom", 0},
				{2,"Blessing of Salvation", "Spell_Holy_SealOfSalvation", 0},
				{2,"Blessing of Light", "Spell_Holy_PrayerOfHealing02", 0},
				{2,"Blessing of Freedom", "Spell_Holy_SealOfValor", 0},
				{2,"Blessing of Protection", "Spell_Holy_SealOfProtection", 0},
				{2,"Blessing of Sacrifice", "Spell_Holy_SealOfSacrifice", 0},
				{2,"Greater Blessing of Might", "Spell_Holy_GreaterBlessingofKings", 0},
				{2,"Greater Blessing of Wisdom", "Spell_Holy_GreaterBlessingofWisdom", 0},
				{2,"Greater Blessing of Salvation", "Spell_Holy_GreaterBlessingofSalvation", 0},
				{2,"Greater Blessing of Light", "Spell_Holy_GreaterBlessingofLight", 0},
				{2,"Greater Blessing of Sanctuary", "Spell_Holy_GreaterBlessingofSanctuary", 0},
				{2,"Greater Blessing of Kings", "Spell_Magic_GreaterBlessingofKings", 0},
				{0,"Devotion Aura", "Spell_Holy_DevotionAura", 0},
				{0,"Retribution Aura", "Spell_Holy_AuraOfLight", 0},
				{0,"Concentration Aura", "Spell_Holy_MindSooth", 0},
				{0,"Shadow Resistance Aura", "Spell_Shadow_SealOfKings", 0},
				{0,"Sanctity Aura", "Spell_Holy_MindVision", 0},
				{0,"Frost Resistance Aura", "Spell_Frost_WizardMark", 0},
				{0,"Fire Resistance Aura", "Spell_Fire_SealOfFire", 0},
				{0,"Eye for an Eye", "Spell_Holy_EyeforanEye", 0},
				{0,"Righteous Fury", "Spell_Holy_SealOfFury", 0},
				{0,"Consecration", "Spell_Holy_InnerFire", 0},
				{2,"Divine Intervention", "Spell_Nature_TimeStop", 0},

			},
	Debuff = {
				{0,"Hammer of Justice", "Spell_Holy_SealOfMight", 1},
				{2,"Judgement of Justice", "Spell_Holy_SealOfWrath", 1},
				{2,"Judgement of the Crusader", "Spell_Holy_HolySmite", 1},
				{2,"Judgement of Light", "Spell_Holy_HealingAura", 1},
				{2,"Judgement of Wisdom", "Spell_Holy_RighteousnessAura", 1},
				{0,"Repentance", "Spell_Holy_PrayerOfHealing", 1},
				{0,"Consecration", "Spell_Holy_InnerFire", 1},
				{0,"Turn Undead", "Spell_Holy_TurnUndead", 1},
			},
	},

MAGE = {
	Buff = {
				{2,"Arcane Brilliance", "Spell_Holy_ArcaneIntellect", 0},
				{2,"Arcane Intellect", "Spell_Holy_MagicalSentry", 0},
				{0,"Ice Armor", "Spell_Frost_FrostArmor02", 0},
				{0,"Mana Shield", "Spell_Shadow_DetectLesserInvisibility", 0},
				{0,"Fire Ward", "Spell_Fire_FireArmor", 0},
				{1,"Ice Block", "Spell_Frost_Frost", 0},
				{1,"Ice Barrier", "Spell_Ice_Lament", 0},
				{0,"Frost Ward", "Spell_Frost_FrostWard", 0},
				{0,"Mage Armor", "Spell_MageArmor", 0},
				{0,"Clearcasting", "Spell_Shadow_ManaBurn", 0},
				{0,"Presence of Mind", "Spell_Nature_EnchantArmor", 0},
				{0,"Combustion", "Spell_Fire_SealOfFire", 0},
				{2,"Dampen Magic", "Spell_Nature_AbolishMagic", 0},
				{2,"Amplify Magic", "Spell_Holy_FlashHeal", 0},
				{0,"Netherwind Focus", "Spell_Shadow_Teleport", 0},
				{0,"Ice Barrier", "Spell_Ice_Lament", 0},
				{0,"Combustion", "Spell_Fire_SealOfFire", 0},
			},
	Debuff = {
				{0,"Detect Magic", "Spell_Holy_Dizzy", 1},
				{2,"Polymorph", "Spell_Nature_Polymorph", 1},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle", 1},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig", 1},
				{0,"Frostbolt", "Spell_Frost_FrostBolt02", 1},
				{2,"Frost Nova", "Spell_Frost_FrostNova", 1},
				{1,"Frostbite", "Spell_Frost_FrostArmor", 1},
				{0,"Scorch", "Spell_Fire_SoulBurn", 1},
				{2,"Winters Chill", "Spell_Frost_FrostBlast", 1},
				{0,"Chill Effect", "Spell_Frost_IceStorm", 1},
				{0,"Fireball", "Spell_Fire_FlameBolt", 1},
				{0,"Impact","Spell_Fire_MeteorStorm", 1},
				{0,"Flamestrike","Spell_Fire_SelfDestruct", 1},
				{0,"Pyroblast","Spell_Fire_Fireball02", 1},
				{1,"Counterspell","Spell_Frost_IceShock", 1},
				{0,"Cone of Cold", "Spell_Frost_Glacier", 1},
				{0,"Blast Wave", "Spell_Holy_Excorcism_02", 1},
			},
	},
DRUID = {
	Buff = {
				{2,"Mark of the Wild", "Spell_Nature_Regeneration", 0},
				{2,"Rejuvenation", "Spell_Nature_Rejuvenation", 0},
				{0,"Nature's Grace", "Spell_Nature_NaturesBlessing", 0},
				{0,"Nature's Grasp", "Spell_Nature_NaturesWrath", 0},
				{1,"Thorns","Spell_Nature_Thorns", 0},
				{2,"Regrowth", "Spell_Nature_ResistNature", 0},
				{0,"Aquatic Form", "Ability_Druid_AquaticForm", 0},
				{0,"Bear Form", "Ability_Racial_BearForm", 0},
				{0,"Cat Form", "Ability_Druid_CatForm", 0},
				{0,"Travel Form", "Ability_Druid_TravelForm", 0},
				{0,"Moonkin Form", "Spell_Nature_ForceOfNature", 0},
				{0,"Enrage", "Ability_Druid_Enrage", 0},
				{0,"Prowl", "Ability_Ambush", 0},
				{0,"Tiger's Fury", "Ability_Mount_JungleTiger", 0},
				{0,"Dash", "Ability_Druid_Dash", 0},
				{2,"Abolish Poison", "Spell_Nature_NullifyPoison_02", 0},
				{0,"Frenzied Regeneration", "Ability_BullRush", 0},
				{0,"Moonkin Aura", "Spell_Nature_MoonGlow", 0},
				{0,"Barkskin Effect", "Spell_Nature_StoneClawTotem", 0},
				{0,"Leader of the Pack", "Spell_Nature_UnyeildingStamina", 0},
			},
	Debuff = {
				{0,"Demoralizing Roar", "Ability_Druid_DemoralizingRoar", 1},
				{0,"Bash", "Ability_Druid_Bash", 1},
				{0,"Rake", "Ability_Druid_Disembowel", 1},
				{0,"Moonfire", "Spell_Nature_StarFall", 1},
				{1,"Faerie Fire", "Spell_Nature_FaerieFire", 1},
				{0,"Insect Swarm", "Spell_Nature_InsectSwarm", 1},
				{2,"Entangling Roots", "Spell_Nature_StrangleVines", 1},
				{2,"Hibernate", "Spell_Nature_Sleep", 1}, 
				{0,"Soothe Animal", "Ability_Hunter_BeastSoothe", 1},
				{0,"Challenging Roar", "Ability_Druid_ChallangingRoar", 1},
				{0,"Pounce","Ability_Druid_SupriseAttack", 1},
			},
	},

ROGUE = {
	Buff = {
				{0,"Sprint", "Ability_Rogue_Sprint", 0},
				{0,"Stealth", "Ability_Ambush", 0},
				{0,"Vanish", "Ability_Vanish", 0},
				{0,"Evasion", "Spell_Shadow_ShadowWard", 0},
				{0,"Slice n Dice", "Ability_Rogue_SliceDice", 0},
			},
	Debuff = {
				{0,"Gouge", "Ability_Gouge", 1},
				{0,"Garrote", "Ability_Rogue_Garrote", 1},
				{0,"Blind", "Spell_Shadow_MindSteal", 1},
				{0,"Rupture", "Ability_Rogue_Rupture", 1},
				{0,"Cheap Shot", "Ability_CheapShot", 1},
				{2,"Sap", "Ability_Sap", 1},
				{1,"Expose Armor", "Ability_Warrior_Riposte", 1},
				{1,"Kick", "Ability_Kick", 1},
				{1,"Distract", "Ability_Rogue_Distract", 1},
				{1,"Mind Numbing Poison", "Spell_Nature_NullifyDisease", 1},
				{1,"Hemorrhage", "Spell_Shadow_LifeDrain", 1},
				{1,"Kidney Shot", "Ability_Rogue_KidneyShot", 1},
				{1,"Deadly Poison", "Ability_Rogue_DualWeild", 1},
				{1,"Crippling Poison", "Ability_PoisonSting", 1},
			},
	},

WARRIOR = {
	Buff = {
				{1,"Battle Shout", "Ability_Warrior_BattleShout", 0},
				{0,"Bloodrage", "Ability_Racial_BloodRage", 0},
				{1,"Defensive Stance", "Ability_Warrior_DefensiveStance", 0},
				{1,"Offensive Stance", "Ability_Warrior_OffensiveStance", 0},
				{1,"Beserker Stance", "Ability_Racial_Avatar", 0},
				{2,"Shield Wall", "Ability_Warrior_ShieldWall", 0},
				{2,"BeserkerRage", "Spell_Nature_AncestralGuardian", 0},
				{1,"Recklessness", "Ability_CriticalStrike", 0},

			},
	Debuff = {
				{0,"Rend", "Ability_Gouge", 1},
				{2,"ThunderClap", "Spell_Nature_ThunderClap", 1},
				{1,"Charge", "Ability_Warrior_Charge", 1},
				{2,"Piercing Howl", "Spell_Shadow_DeathScream", 1},
				{0,"Hamstring", "Ability_ShockWave", 1},
				{1,"Demoralizing Shout", "Ability_Warrior_WarCry", 1},
				{2,"Sunder Armor", "Ability_Warrior_Sunder", 1},
				{1,"Shield Bash", "Ability_Warrior_ShieldBash", 1},
				{1,"Mocking Blow", "Ability_Warrior_PunishingBlow", 1},
				{2,"Taunt", "Spell_Nature_Reincarnation", 1},
				{2,"Disarm", "Ability_Warrior_Disarm", 1},
				{2,"Intimidating Shout", "Ability_GolemThunderClap", 1},
				{2,"Challenging Shout", "Ability_BullRush", 1},
				{1,"Intercept", "Ability_Rogue_Sprint", 1},
				{1,"Pummel","INV_Gauntlets_04", 1},
				{2,"Mortal Strike", "Ability_Warrior_SavageBlow", 1},
			},
	},

SHAMAN = {
	Buff = {
				{0,"Lightning Shield", "Spell_Nature_LightningShield", 0},
				{0,"Ghost Wolf", "Spell_Nature_SpiritWolf", 0},
				{1,"Water Breathing", "Spell_Shadow_DemonBreath", 0},
			},
	Debuff = {
				{0,"Earth Shock", "Spell_Nature_EarthShock", 1},
				{0,"Frost Shock", "Spell_Frost_FrostShock", 1},
				{0,"Earthbind Totem", "Spell_Nature_StrengthOfEarthTotem02", 1},
			},
	},

ALL = {
	Buff = {
				{0,"Argent Dawn Commission", "Spell_INV_Jewelry_Talisman_07", 0},
				{0,"Winterfall Firewater", "Spell_INV_Potion_92", 0},
				{0,"Zandalarian Hero Charm", "Spell_Lightning_LightningBolt01", 0},
				{0,"Fire Protection Potion", "Spell_Fire_FireArmor", 0},
--Self Buff  Satt Spell_MiscFood", 0},
			},
	Debuff = {
				{0,"Recently Bandanged", "Misc_Bandage_08", 1},
			},
	},

-- Crowd control spells
CC = {
	Debuff = {
				{2,"Polymorph", "Spell_Nature_Polymorph", 1},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle", 1},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig", 1},
				{2,"Banish", "Shadow_Cripple", 1},
				{2,"Shackle Undead", "Spell_Nature_Slow", 1},
				{2,"Hibernate", "Spell_Nature_Sleep", 1}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal", 1},
				{2,"Sap", "Ability_Sap", 1},
		},
	},
};

OZ_BUFF_DEFAULT = {

HUNTER = {
	-- Default 'interested in' buffs
	Player = {
				{0,"Aspect of the Hawk","Spell_Nature_RavenForm"},
				{0,"Aspect of the Monkey", "Ability_Hunter_AspectOfTheMonkey"},
				{0,"Aspect of the Cheetah", "Ability_Mount_JungleTiger"},
				{0,"Aspect of the Pack", "Ability_Mount_WhiteTiger"},
				{0,"Aspect of the Beast", "Ability_Mount_PinkTiger"},
				{0,"Aspect of the Wild", "Spell_Nature_ProtectionformNature"},
				{0,"Trueshot Aura", "Ability_TrueShot"},
			},
	Mob = {
				{3,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
				{2,"Sap", "Ability_Sap"},
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
			},
	},


WARLOCK = {
	-- Default 'interested in' buffs
	Player = {
				{1,"Unending Breath","Breathing Spell_Shadow_DemonBreath"},
				{1,"Detect Lesser Invisibility", "Spell_Shadow_DetectLesserInvisibility"},
				{1,"Detect Invisibility", "Spell_Shadow_DetectInvisibility"},
				{2,"Soulstone", "Spell_Shadow_SoulGem"},
				{0,"Demon Skin/Demon Armor","Spell_Shadow_RagingScream"},
			},
	Mob = {
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
				{2,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{3,"Curse of Shadow", "Spell_Shadow_CurseOfAchimonde"},
				{3,"Curse of the Elements", "Spell_Shadow_ChillTouch"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{3,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Sap", "Ability_Sap"},
				{3,"Succubus Seduction", "Spell_Shadow_MindSteal"},
				{1,"Curse of Doom", "Spell_Shadow_AuraOfDarkness"},
				{1,"Curse of Agony", "Spell_Shadow_CurseOfSargeras"},
				{1,"Curse of Weakness", "Spell_Shadow_CurseOfMannoroth"},
			},
	},

PRIEST = {
	-- Default 'interested in' buffs
	Player = {
				{3,"Shadow Protection", "Spell_Shadow_AntiShadow"},
				{3,"Prayer of Shadow Protection", "Spell_Holy_PrayerofShadowProtection"},
				{3,"Power Word: Fortitude", "Spell_Holy_WordFortitude"},
				{3,"Prayer Of Fortitude", "Spell_Holy_PrayerOfFortitude"},
				{3,"Divine Spirit", "Spell_Holy_DivineSpirit"},
				{3,"Prayer of Spirit", "Spell_Holy_PrayerofSpirit"},
				{3,"Power Word: Shield", "Spell_Holy_PowerWordShield"},
				{3,"Renew", "Spell_Holy_Renew"},
				{3,"Power Infusion", "Spell_Holy_PowerInfusion"},
				{4,"Weakened Soul", "Spell_Holy_AshesToAshes"},
				{1,"Rejuvenation", "Spell_Nature_Rejuvenation"},
				{1,"Regrowth", "Spell_Nature_ResistNature"},
			},
	Mob = {
				{1,"Sunder Armor", "Ability_Warrior_Sunder"},
				{3,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Sap", "Ability_Sap"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
				{2,"Mind Control", "Spell_Shadow_ShadowWordDominate"},
			},
	},

PALADIN = {
	-- Default 'interested in' buffs
	Player = {
				{2,"Blessing of Kings", "Spell_Magic_MageArmor"},
				{2,"Blessing of Might", "Spell_Holy_FistOfJustice"},
				{2,"Blessing of Wisdom", "Spell_Holy_SealOfWisdom"},
				{2,"Blessing of Salvation", "Spell_Holy_SealOfSalvation"},
				{2,"Blessing of Light", "Spell_Holy_PrayerOfHealing02"},
				{2,"Blessing of Freedom", "Spell_Holy_SealOfValor"},
				{2,"Blessing of Protection", "Spell_Holy_SealOfProtection"},
				{2,"Blessing of Sacrifice", "Spell_Holy_SealOfSacrifice"},
				{2,"Greater Blessing of Might", "Spell_Holy_GreaterBlessingofKings"},
				{2,"Greater Blessing of Wisdom", "Spell_Holy_GreaterBlessingofWisdom"},
				{2,"Greater Blessing of Salvation", "Spell_Holy_GreaterBlessingofSalvation"},
				{2,"Greater Blessing of Light", "Spell_Holy_GreaterBlessingofLight"},
				{2,"Greater Blessing of Sanctuary", "Spell_Holy_GreaterBlessingofSanctuary"},
				{2,"Greater Blessing of Kings", "Spell_Magic_GreaterBlessingofKings"},
				{2,"Divine Intervention", "Spell_Nature_TimeStop"},
				{1,"Power Word: Shield", "Spell_Holy_PowerWordShield"},
				{1,"Renew", "Spell_Holy_Renew"},
				{1,"Rejuvenation", "Spell_Nature_Rejuvenation"},
				{1,"Regrowth", "Spell_Nature_ResistNature"},
			},
	Mob = {
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
				{3,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Judgement of Justice", "Spell_Holy_SealOfWrath"},
				{2,"Judgement of the Crusader", "Spell_Holy_HolySmite"},
				{3,"Judgement of Light", "Spell_Holy_HealingAura"},
				{3,"Judgement of Wisdom", "Spell_Holy_RighteousnessAura"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Sap", "Ability_Sap"},
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
			},
	},

MAGE = {
	-- Default 'interested in' buffs
	Player = {
				{2,"Arcane Brilliance", "Spell_Holy_ArcaneIntellect"},
				{2,"Arcane Intellect", "Spell_Holy_MagicalSentry"},
				{2,"Dampen Magic", "Spell_Nature_AbolishMagic"},
				{2,"Amplify Magic", "Spell_Holy_FlashHeal"},
				{0,"Fire Ward", "Spell_Fire_FireArmor"},
				{0,"Frost Ward", "Spell_Frost_FrostWard"},
			},
	Mob = {
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
				{3,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{3,"Curse of the Elements", "Spell_Shadow_ChillTouch"},
				{3,"Winters Chill", "Spell_Frost_FrostBlast"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Sap", "Ability_Sap"},
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
			},
	},
DRUID = {
	-- Default 'interested in' buffs
	Player = {
				{2,"Mark of the Wild/Gift of the Wild", "Spell_Nature_Regeneration"},
				{2,"Rejuvenation", "Spell_Nature_Rejuvenation"},
				{2,"Regrowth", "Spell_Nature_ResistNature"},
				{1,"Power Word: Shield", "Spell_Holy_PowerWordShield"},
				{1,"Renew", "Spell_Holy_Renew"},
				{2,"Abolish Poison", "Spell_Nature_NullifyPoison_02"},
				{1,"Thorns","Spell_Nature_Thorns"},
			},
	Mob = {
				{2,"Sunder Armor", "Ability_Warrior_Sunder"},
				{2,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Sap", "Ability_Sap"},
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
			},
	},

ROGUE = {
	-- Default 'interested in' buffs
	Player = {
			},
	Mob = {
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
				{3,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
			},
	},

WARRIOR = {
	-- Default 'interested in' buffs
	Player = {
			},
	Mob = {
				{3,"Taunt", "Spell_Nature_Reincarnation"},
				{3,"Sunder Armor", "Ability_Warrior_Sunder"},
				{3,"ThunderClap", "Spell_Nature_ThunderClap"},
				{3,"Piercing Howl", "Spell_Shadow_DeathScream"},
				{2,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
				{2,"Sap", "Ability_Sap"},
			},
	},

SHAMAN = {
	-- Default 'interested in' buffs
	Player = {
				{1,"Power Word: Shield", "Spell_Holy_PowerWordShield"},
				{1,"Renew", "Spell_Holy_Renew"},
				{1,"Rejuvenation", "Spell_Nature_Rejuvenation"},
				{1,"Regrowth", "Spell_Nature_ResistNature"},
			},
	Mob = {
				{2,"Hunter's Mark", "Ability_Hunter_SniperShot"},
				{2,"Polymorph", "Spell_Nature_Polymorph"},
				{2,"Polymorph: Turtle", "Ability_Hunter_Pet_Turtle"},
				{2,"Polymorph: Pig", "Spell_Magic_PolymorphPig"},
				{2,"Banish", "Shadow_Cripple"},
				{2,"Shackle Undead", "Spell_Nature_Slow"},
				{2,"Hibernate", "Spell_Nature_Sleep"}, 
				{2,"Succubus Seduction", "Spell_Shadow_MindSteal"},
			},
	},
};



-----------------------------------------------------------
-- Random crud from the wiki
-----------------------------------------------------------
--Target Debuff   Shadow_DeathScream 
--Target Debuff   Shadow_ShadowWordPain 
--Target Debuff   Shadow_BlackPlague 
--Target Debuff   Shadow_AbonimationExplosion 
--Target Debuff   Shadow_CurseOfSargeras 
--Target Debuff   Fire_FlameBolt 
--Target Debuff   Fire_Fireball02 
--Target Debuff   Frost_Stun 
--Target Debuff   Frost_ChainsOfIce 


--Self Buff   Spell_Magic_MageArmor"},

--Self Buff Troll (Racial) Shadowguard Spell_Nature_LightningShield"},
--Self Buff Troll (Racial) Berserking Racial_Troll_Berserk"},
--Self Buff   Ability_Mount_BlackDireWolf"},
--Self Buff   Ability_Mount_WhiteDireWolf"},
--Self Buff   Ability_Mount_Kodo_01"},
--Self Buff   Ability_Mount_Kodo_03"},
--Self Buff   Ability_Mount_Raptor"},
--Self Buff   Ability_Mount_Undeadhorse"},
--Self Buff	Ability_Mount_Dreadsteed"},



--------------------------------------------------------------------------------
--- Functions for the scrolly window
--------------------------------------------------------------------------------
local function gg(text)
	local ret = getglobal(text)
	if(not ret) then
		DEFAULT_CHAT_FRAME:AddMessage("|c00FF8800".."OzRaid: Failed to find: "..text);
	end
	return ret
end

-- List format: {'text', depth, 'maxKey', 'texture name', 'priority', 'debuff', 'index'}
--					1		2		3			 4				5		  6			7
-- Headings have 'nil' for a texturename
OZ_BuffSelectList = {}

OZ_BuffSelectMaximised = {}


function OZ_BuildSelectList()
	local i = 1
	local key, key2, key3, key4, value, value2, value3, value4

	OZ_BuffSelectList = {}
	local maxKey
--DEFAULT_CHAT_FRAME:AddMessage( "Building list" )
	for key,value in pairs(OZ_BUFF_TABLE) do
		if( OZ_BuffSelectMaximised[key] )then
--DEFAULT_CHAT_FRAME:AddMessage( "- "..key )
			-- This category is expanded
			OZ_BuffSelectList[i] = {key, 0, key}
			i = i+1
			for key2,value2 in pairs(value) do
				if( OZ_BuffSelectMaximised[key..key2] )then
--DEFAULT_CHAT_FRAME:AddMessage( "  - "..key2 )
					OZ_BuffSelectList[i] = {key2, 1, key..key2}
					i = i+1
					for key3,value3 in pairs(value2) do
--DEFAULT_CHAT_FRAME:AddMessage( "      "..key3 )
						local priority = -1
						local index = nil
						if( value3[4] == 1)then
							for key4, value4 in ipairs(OZ_Config[OZ_OptionsCurrentWindow].buffsMob) do
								-- Mob spell, so scan player watched debuffs
								if( value4[2] == value3[2] )then
									priority = value4[1]
									index = key4
									break
								end
							end
						else
							for key4, value4 in ipairs(OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer) do
								-- Player buff, so scan player watched spells
								if( value4[2] == value3[2] )then
									priority = value4[1]
									index = key4
									break
								end
							end
						end
						OZ_BuffSelectList[i] = {value3[2], 2, key..key2..i, value3[3], priority, value3[4], index}
						i = i+1
					end
				else
--DEFAULT_CHAT_FRAME:AddMessage( "  + "..key2 )
					OZ_BuffSelectList[i] = {key2, 1, key..key2}
					i = i+1
				end
			end
		else
--DEFAULT_CHAT_FRAME:AddMessage( "+ "..key )
			OZ_BuffSelectList[i] = {key, 0, key}
			i = i+1
		end
	end
end


OZ_BUFF_PRIORITYTEXT = {
		[-1]	= { col={0.4, 0.4, 0.4}, text="none" },
		[0]		= { col={1.0, 0.2, 0.2}, text="lowest" },
		[1]		= { col={0.8, 0.4, 0.1}, text="low" },
		[2]		= { col={0.6, 0.6, 0.0}, text="medium" },
		[3]		= { col={0.4, 0.8, 0.1}, text="high" },
		[4]		= { col={0.2, 1.0, 0.2}, text="highest" },
	};

function OZ_BuffSetPriority(i, p)
	
end

function OZ_BuffPanelClick()
	local index
	local name = this:GetName()
	-- Name will be 'OzRaidBuffsScrollEntry<n>Maximise'
	index = string.byte(name,23) - 48
--DEFAULT_CHAT_FRAME:AddMessage( "index = "..index )
	lineplusoffset = index + FauxScrollFrame_GetOffset(OzRaidBuffsScrollBar);
	local entry = OZ_BuffSelectList[lineplusoffset]

	if( entry[4] )then
		-- Clicked on a leaf node - inc priority
--DEFAULT_CHAT_FRAME:AddMessage( "Clicked on "..entry[1] )
		if(entry[7])then
			-- Already watched
			if(entry[6] == 1)then
--DEFAULT_CHAT_FRAME:AddMessage( "WATCHED DEBUFF" )
				if( OZ_Config[OZ_OptionsCurrentWindow].buffsMob[entry[7]][1] >= 4 )then
					OZ_Config[OZ_OptionsCurrentWindow].buffsMob[entry[7]] = nil
				else
					OZ_Config[OZ_OptionsCurrentWindow].buffsMob[entry[7]][1] = OZ_Config[OZ_OptionsCurrentWindow].buffsMob[entry[7]][1] + 1
				end
			else
--DEFAULT_CHAT_FRAME:AddMessage( "WATCHED BUFF = "..OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]][1] )
				if( OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]][1] >= 4 )then
					OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]] = nil
				else
					OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]][1] = (OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]][1]) + 1
--DEFAULT_CHAT_FRAME:AddMessage( "   RESULT = "..OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[entry[7]][1] )
				end
			end
		else
			-- Add it to the watched buffs
			if(entry[6] == 1)then
--DEFAULT_CHAT_FRAME:AddMessage( "NEW DEBUFF" )
				local n = table.getn(OZ_Config[OZ_OptionsCurrentWindow].buffsMob) + 1
				OZ_Config[OZ_OptionsCurrentWindow].buffsMob[n] = { 0, entry[1], "Interface\\Icons\\"..entry[4] }
			else
--DEFAULT_CHAT_FRAME:AddMessage( "NEW BUFF" )
				local n = table.getn(OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer) + 1
				OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[n] = { 0, entry[1], "Interface\\Icons\\"..entry[4] }
			end
		end

	elseif(OZ_BuffSelectMaximised[ entry[3] ])then
		OZ_BuffSelectMaximised[ entry[3] ] = nil
	else
		OZ_BuffSelectMaximised[ entry[3] ] = 1
	end

	OZ_BuildSelectList()
	OZ_BuffPanelUpdate()
end


function OZ_BuffPanelUpdate()
	local line;
	local lineplusoffset; -- an index into our data calculated from the scroll offset
	local barCount = 8

	--OZ_BuildSelectList()

	local inputs = table.getn(OZ_BuffSelectList)
	if(inputs < barCount) then
		barCount = inputs
	end
--DEFAULT_CHAT_FRAME:AddMessage( "Filling scrollbar: lines="..barCount )

	FauxScrollFrame_Update(OzRaidBuffsScrollBar,inputs,barCount,16);
	for line=1,8 do
		lineplusoffset = line + FauxScrollFrame_GetOffset(OzRaidBuffsScrollBar);
		if (lineplusoffset <= inputs) then
			-- Setup this line
			local text
			local entry = gg("OzRaidBuffsScrollEntry"..line)
			local entryText = gg("OzRaidBuffsScrollEntry"..line.."Text")
			local entryMax = gg("OzRaidBuffsScrollEntry"..line.."Maximise")
			local entryPri = gg("OzRaidBuffsScrollEntry"..line.."Priority")

			-- Check for 'expanded' status
			local indent = OZ_BuffSelectList[lineplusoffset][2]*16
			if(OZ_BuffSelectMaximised[ OZ_BuffSelectList[lineplusoffset][3] ])then

				-- We are expanded!
				entryMax:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP")
				entryMax:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-DOWN")
				entryMax:SetPoint("LEFT",entry,"LEFT", indent, 0)
				entryMax:Show()

				entryText:SetPoint("LEFT",entry,"LEFT", 16+indent, 0)
				entryText:SetTextColor(1.0, 0.82, 0)

				entryPri:Hide()

--DEFAULT_CHAT_FRAME:AddMessage( OZ_BuffSelectList[lineplusoffset][2].." - "..OZ_BuffSelectList[lineplusoffset][1] )
			elseif(OZ_BuffSelectList[lineplusoffset][2] < 2)then
				entryMax:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP")
				entryMax:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-DOWN")
				entryMax:SetPoint("LEFT",entry,"LEFT", indent, 0)
				entryMax:Show()

				entryText:SetPoint("LEFT",entry,"LEFT", 16+indent, 0)
				entryText:SetTextColor(1.0, 0.82, 0)

				entryPri:Hide()
--DEFAULT_CHAT_FRAME:AddMessage( OZ_BuffSelectList[lineplusoffset][2].." + "..OZ_BuffSelectList[lineplusoffset][1] )
			else
				-- We are a 'leaf' entry
				entryMax:Hide()

				entryText:SetPoint("LEFT",entry,"LEFT", indent, 0)
				entryText:SetTextColor(1, 1, 1)
--DEFAULT_CHAT_FRAME:AddMessage( OZ_BuffSelectList[lineplusoffset][2].."   = "..OZ_BuffSelectList[lineplusoffset][1] )

				entryPri:Show()
				entryPri:SetText( OZ_BUFF_PRIORITYTEXT[ OZ_BuffSelectList[lineplusoffset][5] ].text )
				entryPri:SetTextColor(	OZ_BUFF_PRIORITYTEXT[ OZ_BuffSelectList[lineplusoffset][5] ].col[1],
										OZ_BUFF_PRIORITYTEXT[ OZ_BuffSelectList[lineplusoffset][5] ].col[2],
										OZ_BUFF_PRIORITYTEXT[ OZ_BuffSelectList[lineplusoffset][5] ].col[3] )
			end

			entryText:SetText( OZ_BuffSelectList[lineplusoffset][1] )


		else
			gg("OzRaidBuffsScrollEntry"..line):Hide();
		end
	end
end

function OZ_BuffsReset()
	OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer = {}
	OZ_Config[OZ_OptionsCurrentWindow].buffsMob = {}
	OZ_BuildSelectList()
	OZ_BuffPanelUpdate()
end
function OZ_BuffsDefault()
	OZ_BuffsReset()
	-- Init buff arays with the class defaults
	local class,fileName = UnitClass("player")
	local i = 1
	for key,value in ipairs(OZ_BUFF_DEFAULT[fileName].Player) do
		local bName = "Interface\\Icons\\"..value[3]
		OZ_Config[OZ_OptionsCurrentWindow].buffsPlayer[key] = { value[1], value[2], bName }
	end

	for key,value in ipairs(OZ_BUFF_DEFAULT[fileName].Mob) do
		local bName = "Interface\\Icons\\"..value[3]
		OZ_Config[OZ_OptionsCurrentWindow].buffsMob[key] = { value[1], value[2], bName }
	end
	OZ_BuildSelectList()
	OZ_BuffPanelUpdate()
end