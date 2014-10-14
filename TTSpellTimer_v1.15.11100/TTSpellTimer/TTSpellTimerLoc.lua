-- ============================================================================
-- Localization.lua
--
-- Copyright (c) Matthew Johnson.  All rights reserved.
--
-- This work may be freely adapted and distributed as long as this notice remains intact.
-- This work may NOT be (re)sold or included in any compilations that are (re)sold.
--
-- ============================================================================

-- ============================================================================
-- German
-- ============================================================================
if (GetLocale() == "deDE") then

-- ============================================================================
-- French
-- ============================================================================
elseif (GetLocale() == "frFR") then

-- ============================================================================
-- Localizable class names.
-- ============================================================================

	-- Class names.
	TTST_GENERAL				= "G\195\169n\195\169ral";
	TTST_DRUID					= "Druide";
	TTST_HUNTER					= "Chasseur";
	TTST_HUNTER_PET				= "Familier";
	TTST_MAGE					= "Mage";
	TTST_PALADIN				= "Paladin";
	TTST_PRIEST					= "Pr\195\170tre";
	TTST_ROGUE					= "Voleur";
	TTST_SHAMAN					= "Chaman";
	TTST_WARLOCK				= "D\195\169moniste";
	TTST_WARLOCK_PET			= "Serviteur";
	TTST_WARRIOR				= "Guerrier";

	-- Alphabetical class list.
	TTST_AlphabeticalClassList =
		{
		TTST_GENERAL,
		TTST_SHAMAN,
		TTST_HUNTER,
		TTST_HUNTER_PET,
		TTST_WARLOCK,
		TTST_WARLOCK_PET,
		TTST_DRUID,
		TTST_WARRIOR,
		TTST_MAGE,
		TTST_PALADIN,
		TTST_PRIEST,
		TTST_ROGUE,
		};

-- ============================================================================
-- Localizable strings used in the settings window.
-- ============================================================================

	TTST_SETTINGS_COLORS						= "Couleurs";
	TTST_SETTINGS_HELP							= "Aide";
	TTST_SETTINGS_SETTINGS						= "Param\195\168tres";

	-- Strings appearing in the general settings window.
	TTST_SETTINGS_GENERAL_DISABLEAUTOMESSAGES	= "D\195\169sactive les messages automatiques de discussion";
	TTST_SETTINGS_GENERAL_ENABLED				= "TTSpellTimer activ\195\169";
	TTST_SETTINGS_GENERAL_MOVE					= "Déplacer la fen\195\170tre des timers";
	TTST_SETTINGS_GENERAL_MOVEDONE				= "Fait";
	TTST_SETTINGS_GENERAL_SCALING				= "TTSpellTimer \195\169chelle de l\039interface";

	-- Strings appearing in the settings window.
	TTST_SETTINGS_HEADER						= "TTSpellTimer Param\195\168tres";
	TTST_SETTINGS_SPELLLIST_HEIGHT				= 20;

	TTST_SETTINGS_OPTIONS_ENABLED				= "Timer activ\195\169";
	TTST_SETTINGS_OPTIONS_ENABLED_CHAT_MSG		= "Message auto activ\195\169";

	TTST_SETTINGS_OPTIONS_CHAT_HEADER			= "Message automatique";
	TTST_SETTINGS_OPTIONS_CHAT_PRECAST			= "Message avant incantation";
	TTST_SETTINGS_OPTIONS_CHAT					= "Message apr\195\168s incantation";
	TTST_SETTINGS_OPTIONS_EMOTE					= "Emote";
	TTST_SETTINGS_OPTIONS_PARTY					= "Groupe";
	TTST_SETTINGS_OPTIONS_RAID					= "Raid";
	TTST_SETTINGS_OPTIONS_SAY					= "Dire";
	TTST_SETTINGS_OPTIONS_YELL					= "Crier";
	TTST_SETTINGS_OPTIONS_CHAT_DISABLED			= "(D\195\169sactiv\195\169 dans les param\195\168tres)";

	TTST_SETTINGS_OPTIONS_DISPLAY_HEADER		= "Affichage";
	TTST_SETTINGS_OPTIONS_SPELLNAME				= "Affiche le nom du sort";
	TTST_SETTINGS_OPTIONS_TARGETNAME			= "Affiche le nom de la cible";
	TTST_SETTINGS_OPTIONS_AUTOREMOVE			= "Enl\195\168ve le timer hors combat";

-- ============================================================================
-- Localizable spell ranks.
-- ============================================================================

	TTST_SPELL_RANK_DEFAULT				= "Rang *";
	TTST_SPELL_RANK_1					= "Rang 1";
	TTST_SPELL_RANK_2					= "Rang 2";
	TTST_SPELL_RANK_3					= "Rang 3";
	TTST_SPELL_RANK_4					= "Rang 4";
	TTST_SPELL_RANK_5					= "Rang 5";
	TTST_SPELL_RANK_6					= "Rang 6";
	TTST_SPELL_RANK_7					= "Rang 7";
	TTST_SPELL_RANK_8					= "Rang 8";
	TTST_SPELL_RANK_9					= "Rang 9";
	TTST_SPELL_RANK_10					= "Rang 10";

-- ============================================================================
-- Localizable talent names.
-- ============================================================================

	TTST_SPELL_TALENT_BOOMING_VOICE					= "Voix tonitruante";
	TTST_SPELL_TALENT_IMPROVED_DISARM				= "D\195\169sarmement am\195\169lior\195\169";
	TTST_SPELL_TALENT_IMPROVED_GARROTE				= "Garrot am\195\169lior\195\169";
	TTST_SPELL_TALENT_IMPROVED_GOUGE				= "Suriner am\195\169lior\195\169";
	TTST_SPELL_TALENT_IMPROVED_REINCARNATION		= "R\195\169incarnation am\195\169lior\195\169e";
	TTST_SPELL_TALENT_IMPROVED_SHADOW_WORD_PAIN		= "Mot de l\039ombre : Douleur am\195\169lior\195\169";
	TTST_SPELL_TALENT_PERMAFROST					= "Gel prolong\195\169";

-- ============================================================================
-- Localizable spell names.
-- ============================================================================

	-- Druid
	TTST_SPELL_ABOLISH_POISON			= "Abolir du poison";
	TTST_SPELL_CHALLENGING_ROAR			= "Grondement";
	TTST_SPELL_DEMORALIZING_ROAR		= "Grognement d\039intimidation";
	TTST_SPELL_ENTANGLING_ROOTS			= "Sarments";
	TTST_SPELL_FAERIE_FIRE				= "Lucioles";
	TTST_SPELL_FAERIE_FIRE_FERAL		= "Lucioles (farouche)";
	TTST_SPELL_HIBERNATE				= "Hibernation";
	TTST_SPELL_INNERVATE				= "Innervation";
	TTST_SPELL_INSECT_SWARM				= "Essaim d\039insectes";
	TTST_SPELL_MOONFIRE					= "Eclat lunaire";
	TTST_SPELL_RAKE						= "Griffure";
	TTST_SPELL_REBIRTH					= "Renaissance";
	TTST_SPELL_REGROWTH					= "R\195\169tablissement";
	TTST_SPELL_REJUVENATION				= "R\195\169cup\195\169ration";
	TTST_SPELL_RIP						= "D\195\169chirure";
	TTST_SPELL_SOOTHE_ANIMAL			= "Apaiser les animaux";

	-- Hunter
	TTST_SPELL_CONCUSSIVE_SHOT			= "Trait de choc";
	TTST_SPELL_COUNTERATTACK			= "Contre-attaque";
	TTST_SPELL_HUNTERS_MARK				= "Marque du chasseur";
	TTST_SPELL_SCARE_BEAST				= "Effrayer une b\195\170te";
	TTST_SPELL_SCATTER_SHOT				= "Fl\195\168che de dispersion";
	TTST_SPELL_SCORPID_STING			= "Piq\195\187re de scorpide";
	TTST_SPELL_SERPENT_STING			= "Morsure de serpent";
	TTST_SPELL_VIPER_STING				= "Morsure de vip\195\168re";
	TTST_SPELL_WING_CLIP				= "Coupure d\039ailes";
	TTST_SPELL_WYVERN_STING				= "Piq\195\187re de wyverne";

	-- Hunter Pet
	TTST_SPELL_PET_BESTIAL_WRATH		= "Courroux bestial";
	TTST_SPELL_PET_INTIMIDATION			= "Intimidation";
	TTST_SPELL_PET_SCREECH				= "Hurlement";
	TTST_SPELL_PET_SCORPID_POISON		= "Poison de scorpide";

	-- Mage
	TTST_SPELL_BLAST_WAVE				= "Vague d\039explosions";
	TTST_SPELL_CONE_OF_COLD				= "C\195\180ne de froid";
	TTST_SPELL_COUNTERSPELL				= "Contresort";
	TTST_SPELL_FIREBALL					= "Boule de feu";
	TTST_SPELL_FLAMESTRIKE				= "Choc de flammes";
	TTST_SPELL_FROST_NOVA				= "Nova de givre";
	TTST_SPELL_FROSTBOLT				= "Eclair de givre";
	TTST_SPELL_POLYMORPH				= "M\195\180tamorphose";
	TTST_SPELL_PYROBLAST				= "Explosion pyrotechnique";

	-- Paladin
	TTST_SPELL_CONSECRATION				= "Cons\195\169cration";
	TTST_SPELL_HAMMER_OF_JUSTICE		= "Marteau de la justice";
	TTST_SPELL_JUDGEMENT				= "Jugement";
	TTST_SPELL_REPENTANCE				= "Repentir";
	TTST_SPELL_SEAL_OF_COMMAND			= "Sceau d\039autorit\195\169";
	TTST_SPELL_SEAL_OF_FURY				= "Fureur vertueuse";
	TTST_SPELL_SEAL_OF_JUSTICE			= "Sceau de justice";
	TTST_SPELL_SEAL_OF_LIGHT			= "Sceau de lumi\195\168re";
	TTST_SPELL_SEAL_OF_RIGHTEOUSNESS	= "Seau de pi\195\169t\195\169";
	TTST_SPELL_SEAL_OF_THE_CRUSADER		= "Sceau du Crois\195\169";
	TTST_SPELL_SEAL_OF_WISDOM			= "Sceau de sagesse";
	TTST_SPELL_TURN_UNDEAD				= "Renvoi des morts-vivants";

	-- Priest
	TTST_SPELL_ABOLISH_DISEASE			= "Abolir maladie";
	TTST_SPELL_DEVOURING_PLAGUE			= "Peste d\195\169vorante";
	TTST_SPELL_HEX_OF_WEAKNESS			= "Toucher de faiblesse";
	TTST_SPELL_HOLY_FIRE				= "Flammes sacr\195\169es";
	TTST_SPELL_MIND_CONTROL				= "Contr\195\180le mental";
	TTST_SPELL_MIND_SOOTHE				= "Apaisement";
	TTST_SPELL_POWER_WORD_SHIELD		= "Mot de pouvoir : Bouclier";
	TTST_SPELL_PSYCHIC_SCREAM			= "Cri psychique";
	TTST_SPELL_RENEW				 	= "R\195\169novation";
	TTST_SPELL_SHACKLE_UNDEAD			= "Entraves des morts-vivants";
	TTST_SPELL_SHADOW_WORD_PAIN			= "Mot de l\039ombre : Douleur";		-- Doesn't work for FR.  Strange translation?
	TTST_SPELL_SILENCE					= "Silence";
	TTST_SPELL_VAMPIRIC_EMBRACE			= "Etreinte vampirique";

	-- Rogue
	TTST_SPELL_BLIND					= "C\195\169cit\195\169";
	TTST_SPELL_CHEAP_SHOT				= "Coup bas";
	TTST_SPELL_DISTRACT					= "Distraction";
	TTST_SPELL_EXPOSE_ARMOR				= "Exposer l\039armure";
	TTST_SPELL_GARROTE					= "Garrot";
	TTST_SPELL_GOUGE					= "Suriner";
	TTST_SPELL_HEMORRHAGE				= "H\195\169morragie";
	TTST_SPELL_KICK						= "Coup de pied";
	TTST_SPELL_KIDNEY_SHOT				= "Aiguillon perfide";
	TTST_SPELL_PREMEDITATION			= "Pr\195\169m\195\169ditation";
	TTST_SPELL_RIPOSTE					= "Riposte";
	TTST_SPELL_RUPTURE					= "Rupture";
	TTST_SPELL_SAP						= "Assommer";

	-- Shaman
	TTST_SPELL_DISEASE_CLEANSING_TOTEM	= "Totem de Purification des maladies";
	TTST_SPELL_EARTHBIND_TOTEM			= "Totem de lien terrestre";
	TTST_SPELL_EARTH_SHOCK				= "Horion de terre";
	TTST_SPELL_FIRE_NOVA_TOTEM			= "Totem Nova de feu";
	TTST_SPELL_FIRE_RESISTANCE_TOTEM	= "Totem de r\195\169sistance au Feu";
	TTST_SPELL_FLAME_SHOCK				= "Horion de flammes";
	TTST_SPELL_FLAMETONGUE_TOTEM		= "Totem Langue de feu";
	TTST_SPELL_FROST_RESISTANCE_TOTEM	= "Totem r\195\169sistance au Givre";
	TTST_SPELL_FROST_SHOCK				= "Horion de givre";
	TTST_SPELL_GRACE_OF_AIR_TOTEM		= "Totem de Gr\195\162ce a\195\169rienne";
	TTST_SPELL_GROUNDING_TOTEM			= "Totem de Gl\195\168be";
	TTST_SPELL_HEALING_STREAM_TOTEM		= "Totem gu\195\169risseur";
	TTST_SPELL_MAGMA_TOTEM				= "Totem de Magma";
	TTST_SPELL_MANA_SPRING_TOTEM		= "Totem Fontaine de mana";
	TTST_SPELL_MANA_TIDE_TOTEM			= "Totem de Vague de mana";
	TTST_SPELL_NATURE_RESISTANCE_TOTEM	= "Totem de r\195\169sistance \195\160 la Nature";
	TTST_SPELL_POISON_CLEANSING_TOTEM	= "Totem de Purification du poison";
 	TTST_SPELL_REINCARNATION			= "R\195\169incarnation";
	TTST_SPELL_SEARING_TOTEM			= "Totem incendiaire";
	TTST_SPELL_SENTRY_TOTEM				= "Totem Sentinelle";
	TTST_SPELL_STONECLAW_TOTEM			= "Totem de Griffes de pierre";
	TTST_SPELL_STONESKIN_TOTEM			= "Totem de Peau de pierre";
	TTST_SPELL_STRENGTH_OF_EARTH_TOTEM	= "Totem de Force de la Terre";
	TTST_SPELL_TRANQUIL_AIR_TOTEM		= "Totem de Tranquillit\195\169 de l\039air";
	TTST_SPELL_TREMOR_TOTEM				= "Totem de S\195\169isme";
	TTST_SPELL_WINDFURY_TOTEM			= "Totem Furie-des-vents";
	TTST_SPELL_WINDWALL_TOTEM			= "Totem de Mur des vents";

	-- Warlock
	TTST_SPELL_BANISH					= "Bannir";
	TTST_SPELL_CORRUPTION				= "Corruption";
	TTST_SPELL_CURSE_OF_AGONY			= "Mal\195\169diction d\039agonie";
	TTST_SPELL_CURSE_OF_DOOM			= "Mal\195\169diction funeste";
	TTST_SPELL_CURSE_OF_EXHAUSTION		= "Mal\195\169diction de fatigue";
	TTST_SPELL_CURSE_OF_RECKLESSNESS	= "Mal\195\169diction de t\195\169m\195\169rit\195\169";
	TTST_SPELL_CURSE_OF_SHADOW			= "Mal\195\169diction de l'ombre";
	TTST_SPELL_CURSE_OF_THE_ELEMENTS	= "Mal\195\169diction des \195\169l\195\169ments";
	TTST_SPELL_CURSE_OF_TONGUES			= "Mal\195\169diction des langages";
	TTST_SPELL_CURSE_OF_WEAKNESS		= "Mal\195\169diction de faiblesse";
	TTST_SPELL_DEATH_COIL				= "Voile mortel";
	TTST_SPELL_ENSLAVE_DEMON			= "Asservir d\195\169mon";
	TTST_SPELL_FEAR						= "Peur";
	TTST_SPELL_HELLFIRE					= "Flammes infernales";
	TTST_SPELL_HOWL_OF_TERROR			= "Hurlement de terreur";
	TTST_SPELL_IMMOLATE					= "Immolation";
	TTST_SPELL_INFERNO					= "Inferno";
	TTST_SPELL_RITUAL_OF_DOOM			= "Rituel de mal\195\169diction";
	TTST_SPELL_RITUAL_OF_SUMMONING		= "Rituel d\039invocation";
	TTST_SPELL_SIPHON_LIFE				= "Drain de vie";
	TTST_SPELL_SOULSTONE_RESURRECTION	= "R\195\169surrection de Pierre d\039\195\162me";

	-- Warlock Pet
	TTST_SPELL_PET_SEDUCTION			= "S\195\169duction";
	TTST_SPELL_PET_SPELL_LOCK			= "Verrou magique";

	-- Warrior
	TTST_SPELL_BERSERKER_RAGE			= "Berserker Rage";
	TTST_SPELL_CHALLENGING_SHOUT		= "Cri de d\195\169fi";
	TTST_SPELL_CONCUSSION_BLOW			= "Bourrasque";
	TTST_SPELL_DEMORALIZING_SHOUT		= "Cri d\039affliction";
	TTST_SPELL_DISARM					= "D\195\169sarmement";
	TTST_SPELL_HAMSTRING				= "Brise-genou";
	TTST_SPELL_INTIMIDATING_SHOUT		= "Cri d\039intimidation";
	TTST_SPELL_MOCKING_BLOW				= "Coup railleur";
	TTST_SPELL_MORTAL_STRIKE			= "Frappe mortelle";
	TTST_SPELL_PIERCING_HOWL			= "Hurlement perçant";
	TTST_SPELL_PUMMEL					= "Vol\195\169e de coups";
	TTST_SPELL_REND						= "Pourfendre";
	TTST_SPELL_SHIELD_BASH				= "Coup de bouclier";
	TTST_SPELL_SUNDER_ARMOR				= "Fracasser armure";
	TTST_SPELL_THUNDER_CLAP				= "Coup de tonnerre";

-- ============================================================================
-- Localizable timer descriptions.
-- ============================================================================

	-- Druid
	TTST_DESC_ABOLISH_POISON			= "";
	TTST_DESC_CHALLENGING_ROAR			= "";
	TTST_DESC_DEMORALIZING_ROAR			= "";
	TTST_DESC_ENTANGLING_ROOTS			= "";
	TTST_DESC_FAERIE_FIRE				= "";
	TTST_DESC_FAERIE_FIRE_FERAL			= "";
	TTST_DESC_HIBERNATE					= "";
	TTST_DESC_INNERVATE					= "";
	TTST_DESC_INSECT_SWARM				= "";
	TTST_DESC_MOONFIRE					= "";
	TTST_DESC_RAKE						= "";
	TTST_DESC_REGROWTH					= "";
	TTST_DESC_REJUVENATION				= "";
	TTST_DESC_RIP						= "";
	TTST_DESC_SOOTHE_ANIMAL				= "";

	-- Hunter
	TTST_DESC_HUNTERS_MARK				= "";
	TTST_DESC_SCARE_BEAST				= "";
	TTST_DESC_SCORPID_STING				= "";
	TTST_DESC_SERPENT_STING				= "";
	TTST_DESC_VIPER_STING				= "";
	TTST_DESC_WING_CLIP					= "";
	TTST_DESC_WYVERN_STING				= "";

	-- Hunter Pet
	TTST_DESC_PET_SCREECH				= "";
	TTST_DESC_PET_SCORPID_POISON		= "";

	-- Mage
	TTST_DESC_BLAST_WAVE				= "";
	TTST_DESC_CONE_OF_COLD				= "";
	TTST_DESC_COUNTERSPELL				= "";
	TTST_DESC_FIREBALL					= "";
	TTST_DESC_FLAMESTRIKE				= "";
	TTST_DESC_FROST_NOVA				= "";
	TTST_DESC_FROSTBOLT					= "";
	TTST_DESC_POLYMORPH					= "";
	TTST_DESC_PYROBLAST					= "";

	-- Paladin
	TTST_DESC_CONSECRATION				= "";
	TTST_DESC_HAMMER_OF_JUSTICE			= "";
	TTST_DESC_JUDGEMENT					= "";
	TTST_DESC_REPENTANCE				= "";
	TTST_DESC_SEAL_OF_COMMAND			= "";
	TTST_DESC_SEAL_OF_FURY				= "";
	TTST_DESC_SEAL_OF_JUSTICE			= "";
	TTST_DESC_SEAL_OF_LIGHT				= "";
	TTST_DESC_SEAL_OF_RIGHTEOUSNESS		= "";
	TTST_DESC_SEAL_OF_THE_CRUSDAER		= "";
	TTST_DESC_SEAL_OF_WISDOM			= "";
	TTST_DESC_TURN_UNDEAD				= "";

	-- Priest
	TTST_DESC_ABOLISH_DISEASE			= "";
	TTST_DESC_DEVOURING_PLAGUE			= "";
	TTST_DESC_HEX_OF_WEAKNESS			= "";
	TTST_DESC_HOLY_FIRE					= "";
	TTST_DESC_MIND_CONTROL				= "";
	TTST_DESC_MIND_SOOTHE				= "";
	TTST_DESC_POWER_WORD_SHIELD			= "Countdown timer for when the Weakened Soul debuff wears off, allowing you to shield the target again.  This timer will automatically adjust it's length if you have any ranks in the \"Improved Power Word: Shield\" talent.";
	TTST_DESC_PSYCHIC_SCREAM			= "";
	TTST_DESC_RENEW				 		= "";
	TTST_DESC_SHACKLE_UNDEAD			= "";
	TTST_DESC_SHADOW_WORD_PAIN			= "";
	TTST_DESC_SILENCE					= "";
	TTST_DESC_VAMPIRIC_EMBRACE			= "";

	-- Rogue
	TTST_DESC_BLIND						= "Countdown timer for when Blind is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_CHEAP_SHOT				= "";
	TTST_DESC_DISTRACT					= "";
	TTST_DESC_EXPOSE_ARMOR				= "";
	TTST_DESC_GARROTE					= "";
	TTST_DESC_GOUGE						= "";
	TTST_DESC_HEMORRHAGE				= "";
	TTST_DESC_KICK						= "";
	TTST_DESC_KIDNEY_SHOT				= "";
	TTST_DESC_PREMEDITATION				= "";
	TTST_DESC_RIPOSTE					= "";
	TTST_DESC_RUPTURE					= "";
	TTST_DESC_SAP						= "";

	-- Shaman
	TTST_DESC_DISEASE_CLEANSING_TOTEM	= "";
	TTST_DESC_EARTHBIND_TOTEM			= "";
	TTST_DESC_FIRE_NOVA_TOTEM			= "";
	TTST_DESC_FIRE_RESISTANCE_TOTEM		= "";
	TTST_DESC_FLAME_SHOCK				= "Countdown timer for when the DOT effect of Flame Shock will expire.  This timer can not detect if the effects gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_FLAMETONGUE_TOTEM			= "";
	TTST_DESC_FROST_RESISTANCE_TOTEM	= "";
	TTST_DESC_FROST_SHOCK				= "Countdown timer for when the slowing effect of Frost Shock will expire.  This timer can not detect if the effects gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_GRACE_OF_AIR_TOTEM		= "";
	TTST_DESC_GROUNDING_TOTEM			= "";
	TTST_DESC_HEALING_STREAM_TOTEM		= "";
	TTST_DESC_MAGMA_TOTEM				= "";
	TTST_DESC_MANA_SPRING_TOTEM			= "";
	TTST_DESC_MANA_TIDE_TOTEM			= "";
	TTST_DESC_NATURE_RESISTANCE_TOTEM	= "";
	TTST_DESC_POISON_CLEANSING_TOTEM	= "";
	TTST_DESC_SEARING_TOTEM				= "";
	TTST_DESC_SENTRY_TOTEM				= "";
	TTST_DESC_STONECLAW_TOTEM			= "";
	TTST_DESC_STONESKIN_TOTEM			= "";
	TTST_DESC_STRENGTH_OF_EARTH_TOTEM	= "";
	TTST_DESC_TREMOR_TOTEM				= "";
	TTST_DESC_TRANQUIL_AIR_TOTEM		= "";
	TTST_DESC_WINDFURY_TOTEM			= "";
	TTST_DESC_WINDWALL_TOTEM			= "";

	-- Warlock
	TTST_DESC_BANISH					= "Countdown timer for when Banish is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_CORRUPTION				= "Countdown timer for when Corruption will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_AGONY			= "Countdown timer for when Curse of Agony will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_DOOM				= "Countdown timer for when Curse of Doom will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_EXHAUSTION		= "Countdown timer for when Curse of Exhaustion will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_RECKLESSNESS		= "Countdown timer for when Curse of Recklessness will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_SHADOW			= "Countdown timer for when Curse of Shadow will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_THE_ELEMENTS		= "Countdown timer for when Curse of the Elements will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_TONGUES			= "Countdown timer for when Curse of Tongues will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_WEAKNESS			= "Countdown timer for when Curse of Weakness will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_DEATH_COIL				= "Countdown timer for when the fear effect from Death Coil will expire.";
	TTST_DESC_ENSLAVE_DEMON				= "Countdown timer for when Enslave Demon is guarenteed to expire.  This timer can not predict early breaks.  It should automatically remove itself when the enslaved demon does break free.";
	TTST_DESC_FEAR						= "Countdown timer for when Fear is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_HELLFIRE					= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message about needing healing because you are casting Hellfire.";
	TTST_DESC_HOWL_OF_TERROR			= "Countdown timer for when Howl of Terror is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_IMMOLATE					= "Countdown timer for when the DOT effect of Immolate will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.  The timer will not be removed should you cast Conflagrate.";
	TTST_DESC_INFERNO					= "Countdown timer for when your summoned Infernal will break.  This timer should automatically remove itself when the enslave Infernal does break free.";
	TTST_DESC_RITUAL_OF_DOOM			= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message asking people to click on the altar.";
	TTST_DESC_RITUAL_OF_SUMMONING		= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message asking people to click on the portal.";
	TTST_DESC_SIPHON_LIFE				= "Countdown timer for when Siphon Life will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_SOULSTONE_RESURRECTION	= "Countdown timer for when Soulstone will expire on your target.  This timer can not detect if the target dies and chooses to resurrect with the Soulstone.  It is strictly for your benefit so you know when to reapply a Soulstone.";

	-- Warlock Pet
	TTST_DESC_PET_SEDUCTION				= "Countdown timer for when Seduction will expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_PET_SPELL_LOCK			= "Countdown timer for when silence effect from Spell Lock will expire.";

	-- Warrior
	TTST_DESC_BERSERKER_RAGE			= "Countdown timer for when you can use Berserker Rage again.  This is not a debuff timer, it is a cooldown timer.";
	TTST_DESC_CHALLENGING_SHOUT			= "Countdown timer for when Challenging Shout will expire.";
	TTST_DESC_CONCUSSION_BLOW			= "Countdown timer for when Concussion Blow will expire.";
	TTST_DESC_DEMORALIZING_SHOUT		= "Countdown timer for when Demoralizing Shout will expire.  This can not detect if the effect is resisted by one or more enemies within the ability's area of effect.";
	TTST_DESC_DISARM					= "Countdown timer for when Disarm will expire and the targetted enemy will get their weapon back.";
	TTST_DESC_HAMSTRING					= "Countdown timer for when Hamstring will expire.";
	TTST_DESC_INTIMIDATING_SHOUT		= "Countdown timer for when Intimidating Shout fear effect will expire.  This timer can not detect if the fleeing enemies break early.";
	TTST_DESC_MOCKING_BLOW				= "Countdown timer for when Mocking Blow will expire.";
	TTST_DESC_MORTAL_STRIKE				= "Countdown timer for when Mortal Strike healing debuff will expire from the target.";
	TTST_DESC_PIERCING_HOWL				= "Countdown timer for when Piercing Howl will expire.";
	TTST_DESC_PUMMEL					= "Countdown timer for when Pummel's spellcast hindering effect will expire from the target.";
	TTST_DESC_REND						= "Countdown timer for when Rend will expire.";
	TTST_DESC_SHIELD_BASH				= "Countdown timer for when Shield Bash's spellcast hindering effect will expire from the target.";
	TTST_DESC_SUNDER_ARMOR				= "Countdown timer for when Sunder Armor will expire.  Since this debuff can stack up to five times, you will see up to five timers.";
	TTST_DESC_THUNDER_CLAP				= "Countdown timer for when Thunder Clap will expire.  This can not detect is the effect is resisted by one or more enemies within the ability's area of effect.";

-- ============================================================================
-- English
-- ============================================================================
else

-- ============================================================================
-- Localizable class names.
-- ============================================================================

	-- Class names.
	TTST_GENERAL				= "General";
	TTST_DRUID					= "Druid";
	TTST_HUNTER					= "Hunter";
	TTST_HUNTER_PET				= "Hunter Pet";
	TTST_MAGE					= "Mage";
	TTST_PALADIN				= "Paladin";
	TTST_PRIEST					= "Priest";
	TTST_ROGUE					= "Rogue";
	TTST_SHAMAN					= "Shaman";
	TTST_WARLOCK				= "Warlock";
	TTST_WARLOCK_PET			= "Warlock Pet";
	TTST_WARRIOR				= "Warrior";

	-- Alphabetical class list.
	TTST_AlphabeticalClassList =
		{
		TTST_GENERAL,
		TTST_DRUID,
		TTST_HUNTER,
		TTST_HUNTER_PET,
		TTST_MAGE,
		TTST_PALADIN,
		TTST_PRIEST,
		TTST_ROGUE,
		TTST_SHAMAN,
		TTST_WARLOCK,
		TTST_WARLOCK_PET,
		TTST_WARRIOR,
		};

-- ============================================================================
-- Localizable strings used in the settings window.
-- ============================================================================

	TTST_SETTINGS_COLORS						= "Colors";
	TTST_SETTINGS_HELP							= "Help";
	TTST_SETTINGS_SETTINGS						= "Settings";

	-- Strings appearing in the general settings window.
	TTST_SETTINGS_GENERAL_DISABLEAUTOMESSAGES	= "Disable all auto chat messages";
	TTST_SETTINGS_GENERAL_ENABLED				= "TTSpellTimer Enabled";
	TTST_SETTINGS_GENERAL_HIDEBACKGROUND		= "Hide Timer Window Background";
	TTST_SETTINGS_GENERAL_MOVE					= "Move Timer Window";
	TTST_SETTINGS_GENERAL_MOVEDONE				= "Done";
	TTST_SETTINGS_GENERAL_SCALING				= "TTSpellTimer UI Scaling";

	-- Strings appearing in the settings window.
	TTST_SETTINGS_HEADER						= "TTSpellTimer Settings";
	TTST_SETTINGS_SPELLLIST_HEIGHT				= 20;

	TTST_SETTINGS_OPTIONS_ENABLED				= "Timer Enabled";
	TTST_SETTINGS_OPTIONS_ENABLED_CHAT_MSG		= "Auto Message Enabled";

	TTST_SETTINGS_OPTIONS_CHAT_HEADER			= "Auto Message";
	TTST_SETTINGS_OPTIONS_CHAT_PRECAST			= "Pre-Cast Message";
	TTST_SETTINGS_OPTIONS_CHAT					= "Post-Cast Message";
	TTST_SETTINGS_OPTIONS_EMOTE					= "Emote";
	TTST_SETTINGS_OPTIONS_PARTY					= "Party";
	TTST_SETTINGS_OPTIONS_RAID					= "Raid";
	TTST_SETTINGS_OPTIONS_SAY					= "Say";
	TTST_SETTINGS_OPTIONS_YELL					= "Yell";
	TTST_SETTINGS_OPTIONS_CHAT_DISABLED			= "(Disabled by general settings)";

	TTST_SETTINGS_OPTIONS_DISPLAY_HEADER		= "Display";
	TTST_SETTINGS_OPTIONS_SPELLNAME				= "Show Spell Name";
	TTST_SETTINGS_OPTIONS_TARGETNAME			= "Show Target Name";
	TTST_SETTINGS_OPTIONS_AUTOREMOVE			= "Remove timer when not in combat";

-- ============================================================================
-- Localizable spell ranks.
-- ============================================================================

	TTST_SPELL_RANK_DEFAULT				= "Rank *";
	TTST_SPELL_RANK_1					= "Rank 1";
	TTST_SPELL_RANK_2					= "Rank 2";
	TTST_SPELL_RANK_3					= "Rank 3";
	TTST_SPELL_RANK_4					= "Rank 4";
	TTST_SPELL_RANK_5					= "Rank 5";
	TTST_SPELL_RANK_6					= "Rank 6";
	TTST_SPELL_RANK_7					= "Rank 7";
	TTST_SPELL_RANK_8					= "Rank 8";
	TTST_SPELL_RANK_9					= "Rank 9";
	TTST_SPELL_RANK_10					= "Rank 10";

-- ============================================================================
-- Localizable talent names.
-- ============================================================================

	TTST_SPELL_TALENT_BOOMING_VOICE					= "Booming Voice";
	TTST_SPELL_TALENT_IMPROVED_DISARM				= "Improved Disarm";
	TTST_SPELL_TALENT_IMPROVED_GARROTE				= "Improved Garrote";
	TTST_SPELL_TALENT_IMPROVED_GOUGE				= "Improved Gouge";
	TTST_SPELL_TALENT_IMPROVED_POWER_WORD_SHIELD	= "Improved Power Word: Shield";
	TTST_SPELL_TALENT_IMPROVED_REINCARNATION		= "Improved Reincarnation";
	TTST_SPELL_TALENT_IMPROVED_SHADOW_WORD_PAIN		= "Improved Shadow Word: Pain";
	TTST_SPELL_TALENT_PERMAFROST					= "Permafrost";

-- ============================================================================
-- Localizable spell names.
-- ============================================================================

	-- Druid
	TTST_SPELL_ABOLISH_POISON			= "Abolish Poison";
	TTST_SPELL_CHALLENGING_ROAR			= "Challenging Roar";
	TTST_SPELL_DEMORALIZING_ROAR		= "Demoralizing Roar";
	TTST_SPELL_ENTANGLING_ROOTS			= "Entangling Roots";
	TTST_SPELL_FAERIE_FIRE				= "Faerie Fire";
	TTST_SPELL_FAERIE_FIRE_FERAL		= "Faerie Fire (Feral)";
	TTST_SPELL_HIBERNATE				= "Hibernate";
	TTST_SPELL_INNERVATE				= "Innervate";
	TTST_SPELL_INSECT_SWARM				= "Insect Swarm";
	TTST_SPELL_MOONFIRE					= "Moonfire";
	TTST_SPELL_RAKE						= "Rake";
	TTST_SPELL_REBIRTH					= "Rebirth";
	TTST_SPELL_REGROWTH					= "Regrowth";
	TTST_SPELL_REJUVENATION				= "Rejuvenation";
	TTST_SPELL_RIP						= "Rip";
	TTST_SPELL_SOOTHE_ANIMAL			= "Soothe Animal";

	-- Hunter
	TTST_SPELL_CONCUSSIVE_SHOT			= "Concussive Shot";
	TTST_SPELL_COUNTERATTACK			= "Counterattack";
	TTST_SPELL_HUNTERS_MARK				= "Hunter's Mark";
	TTST_SPELL_SCARE_BEAST				= "Scare Beast";
	TTST_SPELL_SCATTER_SHOT				= "Scatter Shot";
	TTST_SPELL_SCORPID_STING			= "Scorpid Sting";
	TTST_SPELL_SERPENT_STING			= "Serpent Sting";
	TTST_SPELL_VIPER_STING				= "Viper Sting";
	TTST_SPELL_WING_CLIP				= "Wing Clip";
	TTST_SPELL_WYVERN_STING				= "Wyvern Sting";

	-- Hunter Pet
	TTST_SPELL_PET_BESTIAL_WRATH		= "Bestial Wrath";
	TTST_SPELL_PET_INTIMIDATION			= "Intimidation";
	TTST_SPELL_PET_SCREECH				= "Screech";
	TTST_SPELL_PET_SCORPID_POISON		= "Scorpid Poison";

	-- Mage
	TTST_SPELL_BLAST_WAVE				= "Blast Wave";
	TTST_SPELL_CONE_OF_COLD				= "Cone of Cold";
	TTST_SPELL_COUNTERSPELL				= "Counterspell";
	TTST_SPELL_FIREBALL					= "Fireball";
	TTST_SPELL_FLAMESTRIKE				= "Flamestrike";
	TTST_SPELL_FROST_NOVA				= "Frost Nova";
	TTST_SPELL_FROSTBOLT				= "Frostbolt";
	TTST_SPELL_POLYMORPH				= "Polymorph";
	TTST_SPELL_PYROBLAST				= "Pyroblast";

	-- Paladin
	TTST_SPELL_CONSECRATION				= "Consecration";
	TTST_SPELL_HAMMER_OF_JUSTICE		= "Hammer of Justice";
	TTST_SPELL_JUDGEMENT				= "Judgement";
	TTST_SPELL_REPENTANCE				= "Repentance";
	TTST_SPELL_SEAL_OF_COMMAND			= "Seal of Command";
	TTST_SPELL_SEAL_OF_FURY				= "Seal of Fury";
	TTST_SPELL_SEAL_OF_JUSTICE			= "Seal of Justice";
	TTST_SPELL_SEAL_OF_LIGHT			= "Seal of Light";
	TTST_SPELL_SEAL_OF_RIGHTEOUSNESS	= "Seal of Righteousness";
	TTST_SPELL_SEAL_OF_THE_CRUSDAER		= "Seal of the Crusader";
	TTST_SPELL_SEAL_OF_WISDOM			= "Seal of Wisdom";
	TTST_SPELL_TURN_UNDEAD				= "Turn Undead";

	-- Priest
	TTST_SPELL_ABOLISH_DISEASE			= "Abolish Disease";
	TTST_SPELL_DEVOURING_PLAGUE			= "Devouring Plague";
	TTST_SPELL_HEX_OF_WEAKNESS			= "Hex of Weakness";
	TTST_SPELL_HOLY_FIRE				= "Holy Fire";
	TTST_SPELL_MIND_CONTROL				= "Mind Control";
	TTST_SPELL_MIND_SOOTHE				= "Mind Soothe";
	TTST_SPELL_POWER_WORD_SHIELD		= "Power Word: Shield";
	TTST_SPELL_PSYCHIC_SCREAM			= "Psychic Scream";
	TTST_SPELL_RENEW				 	= "Renew";
	TTST_SPELL_SHACKLE_UNDEAD			= "Shackle Undead";
	TTST_SPELL_SHADOW_WORD_PAIN			= "Shadow Word: Pain";
	TTST_SPELL_SILENCE					= "Silence";
	TTST_SPELL_VAMPIRIC_EMBRACE			= "Vampiric Embrace";

	-- Rogue
	TTST_SPELL_BLIND					= "Blind";
	TTST_SPELL_CHEAP_SHOT				= "Cheap Shot";
	TTST_SPELL_DISTRACT					= "Distract";
	TTST_SPELL_EXPOSE_ARMOR				= "Expose Armor";
	TTST_SPELL_GARROTE					= "Garrote";
	TTST_SPELL_GOUGE					= "Gouge";
	TTST_SPELL_HEMORRHAGE				= "Hemorrhage";
	TTST_SPELL_KICK						= "Kick";
	TTST_SPELL_KIDNEY_SHOT				= "Kidney Shot";
	TTST_SPELL_PREMEDITATION			= "Premeditation";
	TTST_SPELL_RIPOSTE					= "Riposte";
	TTST_SPELL_RUPTURE					= "Rupture";
	TTST_SPELL_SAP						= "Sap";

	-- Shaman
	TTST_SPELL_DISEASE_CLEANSING_TOTEM	= "Disease Cleansing Totem";
	TTST_SPELL_EARTHBIND_TOTEM			= "Earthbind Totem";
	TTST_SPELL_EARTH_SHOCK				= "Earth Shock";
	TTST_SPELL_FIRE_NOVA_TOTEM			= "Fire Nova Totem";
	TTST_SPELL_FIRE_RESISTANCE_TOTEM	= "Fire Resistance Totem";
	TTST_SPELL_FLAME_SHOCK				= "Flame Shock";
	TTST_SPELL_FLAMETONGUE_TOTEM		= "Flametongue Totem";
	TTST_SPELL_FROST_RESISTANCE_TOTEM	= "Frost Resistance Totem";
	TTST_SPELL_FROST_SHOCK				= "Frost Shock";
	TTST_SPELL_GRACE_OF_AIR_TOTEM		= "Grace of Air Totem";
	TTST_SPELL_GROUNDING_TOTEM			= "Grounding Totem";
	TTST_SPELL_HEALING_STREAM_TOTEM		= "Healing Stream Totem";
	TTST_SPELL_MAGMA_TOTEM				= "Magma Totem";
	TTST_SPELL_MANA_SPRING_TOTEM		= "Mana Spring Totem";
	TTST_SPELL_MANA_TIDE_TOTEM			= "Mana Tide Totem";
	TTST_SPELL_NATURE_RESISTANCE_TOTEM	= "Nature Resistance Totem";
	TTST_SPELL_POISON_CLEANSING_TOTEM	= "Poison Cleansing Totem";
 	TTST_SPELL_REINCARNATION			= "Reincarnation";
	TTST_SPELL_SEARING_TOTEM			= "Searing Totem";
	TTST_SPELL_SENTRY_TOTEM				= "Sentry Totem";
	TTST_SPELL_STONECLAW_TOTEM			= "Stoneclaw Totem";
	TTST_SPELL_STONESKIN_TOTEM			= "Stoneskin Totem";
	TTST_SPELL_STRENGTH_OF_EARTH_TOTEM	= "Strength of Earth Totem";
	TTST_SPELL_TRANQUIL_AIR_TOTEM		= "Tranquil Air Totem";
	TTST_SPELL_TREMOR_TOTEM				= "Tremor Totem";
	TTST_SPELL_WINDFURY_TOTEM			= "Windfury Totem";
	TTST_SPELL_WINDWALL_TOTEM			= "Windwall Totem";

	-- Warlock
	TTST_SPELL_BANISH					= "Banish";
	TTST_SPELL_CORRUPTION				= "Corruption";
	TTST_SPELL_CURSE_OF_AGONY			= "Curse of Agony";
	TTST_SPELL_CURSE_OF_DOOM			= "Curse of Doom";
	TTST_SPELL_CURSE_OF_EXHAUSTION		= "Curse of Exhaustion";
	TTST_SPELL_CURSE_OF_RECKLESSNESS	= "Curse of Recklessness";
	TTST_SPELL_CURSE_OF_SHADOW			= "Curse of Shadow";
	TTST_SPELL_CURSE_OF_THE_ELEMENTS	= "Curse of the Elements";
	TTST_SPELL_CURSE_OF_TONGUES			= "Curse of Tongues";
	TTST_SPELL_CURSE_OF_WEAKNESS		= "Curse of Weakness";
	TTST_SPELL_DEATH_COIL				= "Death Coil";
	TTST_SPELL_ENSLAVE_DEMON			= "Enslave Demon";
	TTST_SPELL_FEAR						= "Fear";
	TTST_SPELL_HELLFIRE					= "Hellfire";
	TTST_SPELL_HOWL_OF_TERROR			= "Howl of Terror";
	TTST_SPELL_IMMOLATE					= "Immolate";
	TTST_SPELL_INFERNO					= "Inferno";
	TTST_SPELL_RITUAL_OF_DOOM			= "Ritual of Doom";
	TTST_SPELL_RITUAL_OF_SUMMONING		= "Ritual of Summoning";
	TTST_SPELL_SIPHON_LIFE				= "Siphon Life";
	TTST_SPELL_SOULSTONE_RESURRECTION	= "Soulstone Resurrection";

	-- Warlock Pet
	TTST_SPELL_PET_SEDUCTION			= "Seduction";
	TTST_SPELL_PET_SPELL_LOCK			= "Spell Lock";

	-- Warrior
	TTST_SPELL_BERSERKER_RAGE			= "Berserker Rage";
	TTST_SPELL_CHALLENGING_SHOUT		= "Challenging Shout";
	TTST_SPELL_CONCUSSION_BLOW			= "Concussion Blow";
	TTST_SPELL_DEMORALIZING_SHOUT		= "Demoralizing Shout";
	TTST_SPELL_DISARM					= "Disarm";
	TTST_SPELL_HAMSTRING				= "Hamstring";
	TTST_SPELL_INTIMIDATING_SHOUT		= "Intimidating Shout";
	TTST_SPELL_MOCKING_BLOW				= "Mocking Blow";
	TTST_SPELL_MORTAL_STRIKE			= "Mortal Strike";
	TTST_SPELL_PIERCING_HOWL			= "Piercing Howl";
	TTST_SPELL_PUMMEL					= "Pummel";
	TTST_SPELL_REND						= "Rend";
	TTST_SPELL_SHIELD_BASH				= "Shield Bash";
	TTST_SPELL_SUNDER_ARMOR				= "Sunder Armor";
	TTST_SPELL_THUNDER_CLAP				= "Thunder Clap";

-- ============================================================================
-- Localizable timer descriptions.
-- ============================================================================

	-- Druid
	TTST_DESC_ABOLISH_POISON			= "Countdown timer for when the Abolish Poison buff will wear off.";
	TTST_DESC_CHALLENGING_ROAR			= "Countdown timer for when the effect from Challenging Roar will wear off.";
	TTST_DESC_DEMORALIZING_ROAR			= "Countdown timer for when Demoralizing Roar will expire.  This can not detect if the effect is resisted by one or more enemies within the ability's area of effect.";
	TTST_DESC_ENTANGLING_ROOTS			= "Countdown timer for when Entangling Roots is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_FAERIE_FIRE				= "Countdown timer for when Faerie Fire will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_FAERIE_FIRE_FERAL			= "Countdown timer for when Faerie Fire will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_HIBERNATE					= "Countdown timer for when Hibernate is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_INNERVATE					= "Countdown timer for when Innervate will expire.";
	TTST_DESC_INSECT_SWARM				= "";
	TTST_DESC_MOONFIRE					= "Countdown timer for when the DOT effect of Moonfire will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_RAKE						= "";
	TTST_DESC_REBIRTH					= "";
	TTST_DESC_REGROWTH					= "Countdown timer for when Regrowth will expire.";
	TTST_DESC_REJUVENATION				= "Countdown timer for when Rejuvenation will expire.";
	TTST_DESC_RIP						= "";
	TTST_DESC_SOOTHE_ANIMAL				= "";

	-- Hunter
	TTST_DESC_HUNTERS_MARK				= "";
	TTST_DESC_SCARE_BEAST				= "";
	TTST_DESC_SCORPID_STING				= "";
	TTST_DESC_SERPENT_STING				= "";
	TTST_DESC_VIPER_STING				= "";
	TTST_DESC_WING_CLIP					= "";
	TTST_DESC_WYVERN_STING				= "";

	-- Hunter Pet
	TTST_DESC_PET_SCREECH				= "";
	TTST_DESC_PET_SCORPID_POISON		= "";

	-- Mage
	TTST_DESC_BLAST_WAVE				= "";
	TTST_DESC_CONE_OF_COLD				= "";
	TTST_DESC_COUNTERSPELL				= "";
	TTST_DESC_FIREBALL					= "";
	TTST_DESC_FLAMESTRIKE				= "";
	TTST_DESC_FROST_NOVA				= "";
	TTST_DESC_FROSTBOLT					= "";
	TTST_DESC_POLYMORPH					= "Countdown timer for when Polymorph is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_PYROBLAST					= "";

	-- Paladin
	TTST_DESC_CONSECRATION				= "";
	TTST_DESC_HAMMER_OF_JUSTICE			= "";
	TTST_DESC_JUDGEMENT					= "";
	TTST_DESC_REPENTANCE				= "";
	TTST_DESC_SEAL_OF_COMMAND			= "";
	TTST_DESC_SEAL_OF_FURY				= "";
	TTST_DESC_SEAL_OF_JUSTICE			= "";
	TTST_DESC_SEAL_OF_LIGHT				= "";
	TTST_DESC_SEAL_OF_RIGHTEOUSNESS		= "";
	TTST_DESC_SEAL_OF_THE_CRUSDAER		= "";
	TTST_DESC_SEAL_OF_WISDOM			= "";
	TTST_DESC_TURN_UNDEAD				= "";

	-- Priest
	TTST_DESC_ABOLISH_DISEASE			= "";
	TTST_DESC_DEVOURING_PLAGUE			= "";
	TTST_DESC_HEX_OF_WEAKNESS			= "";
	TTST_DESC_HOLY_FIRE					= "";
	TTST_DESC_MIND_CONTROL				= "";
	TTST_DESC_MIND_SOOTHE				= "";
	TTST_DESC_POWER_WORD_SHIELD			= "Countdown timer for when the Weakened Soul debuff wears off, allowing you to shield the target again.  This timer will automatically adjust it's length if you have any ranks in the \"Improved Power Word: Shield\" talent.";
	TTST_DESC_PSYCHIC_SCREAM			= "";
	TTST_DESC_RENEW				 		= "Countdown timer for when Renew will expire.";
	TTST_DESC_SHACKLE_UNDEAD			= "";
	TTST_DESC_SHADOW_WORD_PAIN			= "";
	TTST_DESC_SILENCE					= "";
	TTST_DESC_VAMPIRIC_EMBRACE			= "";

	-- Rogue
	TTST_DESC_BLIND						= "Countdown timer for when Blind is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_CHEAP_SHOT				= "";
	TTST_DESC_DISTRACT					= "";
	TTST_DESC_EXPOSE_ARMOR				= "";
	TTST_DESC_GARROTE					= "";
	TTST_DESC_GOUGE						= "";
	TTST_DESC_HEMORRHAGE				= "";
	TTST_DESC_KICK						= "";
	TTST_DESC_KIDNEY_SHOT				= "";
	TTST_DESC_PREMEDITATION				= "";
	TTST_DESC_RIPOSTE					= "";
	TTST_DESC_RUPTURE					= "";
	TTST_DESC_SAP						= "Countdown timer for when Sap is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";

	-- Shaman
	TTST_DESC_DISEASE_CLEANSING_TOTEM	= "Countdown timer for when the Disease Cleansing Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_EARTHBIND_TOTEM			= "Countdown timer for when the Earthbind Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Earth type totem will remove this timer.";
	TTST_DESC_EARTH_SHOCK				= "";
	TTST_DESC_FIRE_NOVA_TOTEM			= "Countdown timer for when the Fire Nova Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Fire type totem will remove this timer.";
	TTST_DESC_FIRE_RESISTANCE_TOTEM		= "Countdown timer for when the Fire Resistance Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_FLAME_SHOCK				= "Countdown timer for when the DOT effect of Flame Shock will expire.  This timer can not detect if the effects gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_FLAMETONGUE_TOTEM			= "Countdown timer for when the Flametongue Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Fire type totem will remove this timer.";
	TTST_DESC_FROST_RESISTANCE_TOTEM	= "Countdown timer for when the Earthbind Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Fire type totem will remove this timer.";
	TTST_DESC_FROST_SHOCK				= "Countdown timer for when the slowing effect of Frost Shock will expire.  This timer can not detect if the effects gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_GRACE_OF_AIR_TOTEM		= "Countdown timer for when the Grace of Air Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_GROUNDING_TOTEM			= "Countdown timer for when the Grounding Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_HEALING_STREAM_TOTEM		= "Countdown timer for when the Healing Stream Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_MAGMA_TOTEM				= "Countdown timer for when the Magma Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Fire type totem will remove this timer.";
	TTST_DESC_MANA_SPRING_TOTEM			= "Countdown timer for when the Mana Spring Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_MANA_TIDE_TOTEM			= "Countdown timer for when the Mana Tide Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_NATURE_RESISTANCE_TOTEM	= "Countdown timer for when the Nature Resistance Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_POISON_CLEANSING_TOTEM	= "Countdown timer for when the Poison Cleansing Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Water type totem will remove this timer.";
	TTST_DESC_SEARING_TOTEM				= "Countdown timer for when the Searing Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Fire type totem will remove this timer.";
	TTST_DESC_SENTRY_TOTEM				= "Countdown timer for when the Sentry Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_STONECLAW_TOTEM			= "Countdown timer for when the Stoneclaw Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Earth type totem will remove this timer.";
	TTST_DESC_STONESKIN_TOTEM			= "Countdown timer for when the Stoneskin Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Earth type totem will remove this timer.";
	TTST_DESC_STRENGTH_OF_EARTH_TOTEM	= "Countdown timer for when the Strength of Earth Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Earth type totem will remove this timer.";
	TTST_DESC_TRANQUIL_AIR_TOTEM		= "Countdown timer for when the Tranquil Air Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_TREMOR_TOTEM				= "Countdown timer for when the Tremor Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Earth type totem will remove this timer.";
	TTST_DESC_WINDFURY_TOTEM			= "Countdown timer for when the Windfury Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";
	TTST_DESC_WINDWALL_TOTEM			= "Countdown timer for when the Windwall Totem will expire.  This timer can not detect if the totem is destroyed.  Casting another Air type totem will remove this timer.";

	-- Warlock
	TTST_DESC_BANISH					= "Countdown timer for when Banish is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_CORRUPTION				= "Countdown timer for when Corruption will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_AGONY			= "Countdown timer for when Curse of Agony will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_DOOM				= "Countdown timer for when Curse of Doom will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_EXHAUSTION		= "Countdown timer for when Curse of Exhaustion will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_RECKLESSNESS		= "Countdown timer for when Curse of Recklessness will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_SHADOW			= "Countdown timer for when Curse of Shadow will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_THE_ELEMENTS		= "Countdown timer for when Curse of the Elements will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_TONGUES			= "Countdown timer for when Curse of Tongues will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_CURSE_OF_WEAKNESS			= "Countdown timer for when Curse of Weakness will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_DEATH_COIL				= "Countdown timer for when the fear effect from Death Coil will expire.";
	TTST_DESC_ENSLAVE_DEMON				= "Countdown timer for when Enslave Demon is guarenteed to expire.  This timer can not predict early breaks.  It should automatically remove itself when the enslaved demon does break free.";
	TTST_DESC_FEAR						= "Countdown timer for when Fear is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_HELLFIRE					= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message about needing healing because you are casting Hellfire.";
	TTST_DESC_HOWL_OF_TERROR			= "Countdown timer for when Howl of Terror is guarenteed to expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_IMMOLATE					= "Countdown timer for when the DOT effect of Immolate will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.  The timer will not be removed should you cast Conflagrate.";
	TTST_DESC_INFERNO					= "Countdown timer for when your summoned Infernal will break.  This timer should automatically remove itself when the enslave Infernal does break free.";
	TTST_DESC_RITUAL_OF_DOOM			= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message asking people to click on the altar.";
	TTST_DESC_RITUAL_OF_SUMMONING		= "This does not actually create a timer.  Its usage is strictly for the auto message.  This can be handy if you want to automatically post a message asking people to click on the portal.";
	TTST_DESC_SIPHON_LIFE				= "Countdown timer for when Siphon Life will expire.  This timer can not detect if the effect gets bumped off the debuff list or detect the death of the target.";
	TTST_DESC_SOULSTONE_RESURRECTION	= "Countdown timer for when Soulstone will expire on your target.  This timer can not detect if the target dies and chooses to resurrect with the Soulstone.  It is strictly for your benefit so you know when to reapply a Soulstone.";

	-- Warlock Pet
	TTST_DESC_PET_SEDUCTION				= "Countdown timer for when Seduction will expire.  This timer can not predict early breaks nor can it detect a break and remove the timer.";
	TTST_DESC_PET_SPELL_LOCK			= "Countdown timer for when silence effect from Spell Lock will expire.";

	-- Warrior
	TTST_DESC_BERSERKER_RAGE			= "Countdown timer for when you can use Berserker Rage again.  This is not a debuff timer, it is a cooldown timer.";
	TTST_DESC_CHALLENGING_SHOUT			= "Countdown timer for when Challenging Shout will expire.";
	TTST_DESC_CONCUSSION_BLOW			= "Countdown timer for when Concussion Blow will expire.";
	TTST_DESC_DEMORALIZING_SHOUT		= "Countdown timer for when Demoralizing Shout will expire.  This can not detect if the effect is resisted by one or more enemies within the ability's area of effect.";
	TTST_DESC_DISARM					= "Countdown timer for when Disarm will expire and the targetted enemy will get their weapon back.";
	TTST_DESC_HAMSTRING					= "Countdown timer for when Hamstring will expire.";
	TTST_DESC_INTIMIDATING_SHOUT		= "Countdown timer for when Intimidating Shout fear effect will expire.  This timer can not detect if the fleeing enemies break early.";
	TTST_DESC_MOCKING_BLOW				= "Countdown timer for when Mocking Blow will expire.";
	TTST_DESC_MORTAL_STRIKE				= "Countdown timer for when Mortal Strike healing debuff will expire from the target.";
	TTST_DESC_PIERCING_HOWL				= "Countdown timer for when Piercing Howl will expire.";
	TTST_DESC_PUMMEL					= "Countdown timer for when Pummel's spellcast hindering effect will expire from the target.";
	TTST_DESC_REND						= "Countdown timer for when Rend will expire.";
	TTST_DESC_SHIELD_BASH				= "Countdown timer for when Shield Bash's spellcast hindering effect will expire from the target.";
	TTST_DESC_SUNDER_ARMOR				= "Countdown timer for when Sunder Armor will expire.  Since this debuff can stack up to five times, you will see up to five timers.";
	TTST_DESC_THUNDER_CLAP				= "Countdown timer for when Thunder Clap will expire.  This can not detect is the effect is resisted by one or more enemies within the ability's area of effect.";

end

-- ============================================================================
-- Strings appearing in all languages and not needing localization.
-- ============================================================================

	-- Strings appearing in the general help window.
	TTST_SETTINGS_HELP_VERSION					= "TTSpellTimer (v 1.15.11100)";




--[[

-- ============================================================================
-- This is a section strictly for current and functional features.
-- ============================================================================

- Spells supported in each available class.
- Customizable options for each spell available through "/ttst" command.
- Other supported commands:
	- /ttst reset (all | <spellname>)
		- This will reset the named spell (or all of them) to the default settings.
- Timer durations are automatically modified if you have ranks in the appropriate talents.
- Timer window can be moved by dragging the window borders.
- Timer window position is saved between sessions if you move it.
- Customizable chat strings to automatically post.
	- %target% is a placeholder for the target's name.
- "/ttst reset <all|spell name>" to reset the spell timer settings to the default value for that spell.
- Scaling.
- All timers can be disabled.

-- ============================================================================
-- This is a section strictly for feature requests / ideas.
-- ============================================================================

IDEA
Timer grouping based on target.

FEATURE
Ability to right-click a timer to perform some sort of automatic action.  For
example: timers report time remaining, Immolate would automatically target the
mob and cast Conflagrate, begin recasting of the spell targeting the same mob.

FEATURE
Trinket/Item abilites!

-- ============================================================================
-- This is a section strictly for fixed bugs.
-- ============================================================================

BUG
Power Word: Shield and Telo's SelfCast Mod
DESC
When auto-target-self is enabled, SelfCast hooks UseAction and modifies arg3.
If TTSpellTimer is hooked before SelfCast, then the target name works fine.  If
TTSpellTimer is hooked after SelfCast, then there is no way to get the target
name.
FIX
Make sure we don't pass a nil argument to string.format.

BUG
Curse of Exhaustion is working
DESC
Typo in the CoEx debuff string.
FIX
Fixed typo.

BUG
Banish not timing when banishing demons that are pets of other mobs.
FIX
Not repro.

-- ============================================================================
-- This is a section strictly for active bugs.
-- ============================================================================

BUG
Spells with a casting time (eg Soulstone Resurrection, Howl of Terror) and
spells that do not apply a debuff will display a timer even if you cancel the
casting.
DESC
This is because the addon uses SPELLCAST_STOP event to know when a spell has
stopped successfully casting.  Unfortunately, when a spell is interrupted (eg
escape or moving) then a SPELLCAST_STOP event is sent, immediately followed
by a SPELLCAST_INTERRUPTED event.  Because we respond to the stop event, we
show the timer.  If the interrupted event was sent first, we wouldn't have this
problem.

BUG
Hard to move the timer window through drag-n-drop.

]]

