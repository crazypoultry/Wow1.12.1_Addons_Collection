if ( GetLocale() == "deDE" ) then

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- ä = \195\164 (z.B. Jäger = J\195\164ger)
-- Ä = \195\132 (z.B. Ärger = \195\132rger)
-- ö = \195\182 (z.B. schön = sch\195\182n)
-- Ö = \195\150 (z.B. Ödipus = \195\150dipus)
-- ü = \195\188 (z.B. Rüstung = R\195\188stung)
-- Ü = \195\156 (z.B. Übung = \195\156bung)
-- ß = \195\159 (z.B. Straße = Stra\195\159e)
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.WARLOCK = {}
RPWORDLIST.entercombat.WARLOCK.emote = {"FROWN","GRIN","GLARE","GROWL","WRATH",}
RPWORDLIST.entercombat.WARLOCK.customemote = {}
RPWORDLIST.entercombat.WARLOCK.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.WARLOCK = {}
RPWORDLIST.leavecombat.WARLOCK.emote = {}
RPWORDLIST.leavecombat.WARLOCK.customemote = {}
RPWORDLIST.leavecombat.WARLOCK.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.WARLOCK = {}
RPWORDLIST.hurt.WARLOCK.emote = {}
RPWORDLIST.hurt.WARLOCK.customemote = {}
RPWORDLIST.hurt.WARLOCK.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.WARLOCK = {}
RPWORDLIST.absorb.WARLOCK.emote = {}
RPWORDLIST.absorb.WARLOCK.customemote = {}
RPWORDLIST.absorb.WARLOCK.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.WARLOCK = {}
RPWORDLIST.block.WARLOCK.emote = {}
RPWORDLIST.block.WARLOCK.customemote = {}
RPWORDLIST.block.WARLOCK.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.WARLOCK = {}
RPWORDLIST.dodge.WARLOCK.emote = {}
RPWORDLIST.dodge.WARLOCK.customemote = {}
RPWORDLIST.dodge.WARLOCK.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.WARLOCK = {}
RPWORDLIST.miss.WARLOCK.emote = {}
RPWORDLIST.miss.WARLOCK.customemote = {}
RPWORDLIST.miss.WARLOCK.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.WARLOCK = {}
RPWORDLIST.parry.WARLOCK.emote = {}
RPWORDLIST.parry.WARLOCK.customemote = {}
RPWORDLIST.parry.WARLOCK.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.WARLOCK = {}
RPWORDLIST.youcrit.WARLOCK.emote = {}
RPWORDLIST.youcrit.WARLOCK.customemote = {}
RPWORDLIST.youcrit.WARLOCK.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.WARLOCK = {}
RPWORDLIST.youcritspell.WARLOCK.emote = {}
RPWORDLIST.youcritspell.WARLOCK.customemote = {}
RPWORDLIST.youcritspell.WARLOCK.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.WARLOCK = {}
RPWORDLIST.petattackstart.WARLOCK.emote = {}
RPWORDLIST.petattackstart.WARLOCK.customemote = {}
RPWORDLIST.petattackstart.WARLOCK.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.WARLOCK = {}
RPWORDLIST.petattackstop.WARLOCK.emote = {}
RPWORDLIST.petattackstop.WARLOCK.customemote = {}
RPWORDLIST.petattackstop.WARLOCK.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.WARLOCK = {}
RPWORDLIST.petdies.WARLOCK.emote = {}
RPWORDLIST.petdies.WARLOCK.customemote = {}
RPWORDLIST.petdies.WARLOCK.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.WARLOCK = {}
RPWORDLIST.npctalksfriend.WARLOCK.emote = {}
RPWORDLIST.npctalksfriend.WARLOCK.customemote = {}
RPWORDLIST.npctalksfriend.WARLOCK.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.WARLOCK = { "Dir h\195\182rt eh keiner zu, NPC." }
RPWORDLIST.npctalksenemy.WARLOCK.emote = {}
RPWORDLIST.npctalksenemy.WARLOCK.customemote = {}
RPWORDLIST.npctalksenemy.WARLOCK.random = {

	["phrase"] = "BLANK BLANK BLANK",

	[1] = {
		"Halt die Klappe NPC,",
		"Halts Maul NPC,",
		},

	[2] = {
		"es sei denn du willst",
		"oder willst du",
		"oder w\195\188nscht du dir",
		},

	[3] = {
		"dass ich deine Zunge mithilfe eines Feuerzaubers verkohle?",
		"dass dich ein heftiger Fluch trifft?",
		"dass du in Rauch aufgehst?",
		"meinen Schattenblitz sp\195\188ren?",
		},
		
	}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.WARLOCK = {"Die Schatten lassen nicht zu das ich sterbe!", "Die Hexenkunst wird mich bewahren!", }
RPWORDLIST.resurrect.WARLOCK.emote = {}
RPWORDLIST.resurrect.WARLOCK.customemote = {}
RPWORDLIST.resurrect.WARLOCK.random = {}




--//////////////////////////////////////////////////////////////////////////--
-- Warlock Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Affliction
--=====================================================================--
RPWORDLIST.corruption.WARLOCK = {}
RPWORDLIST.corruption.WARLOCK.emote = {}
RPWORDLIST.corruption.WARLOCK.customemote = {}
RPWORDLIST.corruption.WARLOCK.random = {}

RPWORDLIST.fear.WARLOCK = {}
RPWORDLIST.fear.WARLOCK.emote = {}
RPWORDLIST.fear.WARLOCK.customemote = {}
RPWORDLIST.fear.WARLOCK.random = {}

RPWORDLIST.howl_of_terror.WARLOCK = {}
RPWORDLIST.howl_of_terror.WARLOCK.emote = {}
RPWORDLIST.howl_of_terror.WARLOCK.customemote = {}
RPWORDLIST.howl_of_terror.WARLOCK.random = {}

--=====================================================================--
-- Demonology
--=====================================================================--
RPWORDLIST.banish.WARLOCK = {}
RPWORDLIST.banish.WARLOCK.emote = {}
RPWORDLIST.banish.WARLOCK.customemote = {}
RPWORDLIST.banish.WARLOCK.random = {}

RPWORDLIST.eye_of_kilrogg.WARLOCK = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.emote = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.customemote = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.random = {}

RPWORDLIST.ritual_of_summoning.WARLOCK = {}
RPWORDLIST.ritual_of_summoning.WARLOCK.emote = {}
RPWORDLIST.ritual_of_summoning.WARLOCK.customemote = {}
RPWORDLIST.ritual_of_summoning.WARLOCK.random = {}

RPWORDLIST.enslave_demon.WARLOCK = {}
RPWORDLIST.enslave_demon.WARLOCK.emote = {}
RPWORDLIST.enslave_demon.WARLOCK.customemote = {}
RPWORDLIST.enslave_demon.WARLOCK.random = {}

-------------------------------------------------------------------------

RPWORDLIST.create_healthstone.WARLOCK = {}
RPWORDLIST.create_healthstone.WARLOCK.emote = {}
RPWORDLIST.create_healthstone.WARLOCK.customemote = {}
RPWORDLIST.create_healthstone.WARLOCK.random = {}

RPWORDLIST.create_soulstone.WARLOCK = {}
RPWORDLIST.create_soulstone.WARLOCK.emote = {}
RPWORDLIST.create_soulstone.WARLOCK.customemote = {}
RPWORDLIST.create_soulstone.WARLOCK.random = {}

RPWORDLIST.create_spellstone.WARLOCK = {}
RPWORDLIST.create_spellstone.WARLOCK.emote = {}
RPWORDLIST.create_spellstone.WARLOCK.customemote = {}
RPWORDLIST.create_spellstone.WARLOCK.random = {}

RPWORDLIST.create_firestone.WARLOCK = {}
RPWORDLIST.create_firestone.WARLOCK.emote = {}
RPWORDLIST.create_firestone.WARLOCK.customemote = {}
RPWORDLIST.create_firestone.WARLOCK.random = {}

-------------------------------------------------------------------------

RPWORDLIST.summon_imp.WARLOCK = {}
RPWORDLIST.summon_imp.WARLOCK.emote = {}
RPWORDLIST.summon_imp.WARLOCK.customemote = {}
RPWORDLIST.summon_imp.WARLOCK.random = {}

RPWORDLIST.summon_voidwalker.WARLOCK = {}
RPWORDLIST.summon_voidwalker.WARLOCK.emote = {}
RPWORDLIST.summon_voidwalker.WARLOCK.customemote = {}
RPWORDLIST.summon_voidwalker.WARLOCK.random = {}

RPWORDLIST.summon_succubus.WARLOCK = {}
RPWORDLIST.summon_succubus.WARLOCK.emote = {}
RPWORDLIST.summon_succubus.WARLOCK.customemote = {}
RPWORDLIST.summon_succubus.WARLOCK.random = {}

RPWORDLIST.summon_felhunter.WARLOCK = {}
RPWORDLIST.summon_felhunter.WARLOCK.emote = {}
RPWORDLIST.summon_felhunter.WARLOCK.customemote = {}
RPWORDLIST.summon_felhunter.WARLOCK.random = {}

RPWORDLIST.summon_felsteed.WARLOCK = {}
RPWORDLIST.summon_felsteed.WARLOCK.emote = {}
RPWORDLIST.summon_felsteed.WARLOCK.customemote = {}
RPWORDLIST.summon_felsteed.WARLOCK.random = {}

--=====================================================================--
-- Destruction
--=====================================================================--
RPWORDLIST.immolate.WARLOCK = {}
RPWORDLIST.immolate.WARLOCK.emote = {}
RPWORDLIST.immolate.WARLOCK.customemote = {}
RPWORDLIST.immolate.WARLOCK.random = {}

RPWORDLIST.searing_pain.WARLOCK = {}
RPWORDLIST.searing_pain.WARLOCK.emote = {}
RPWORDLIST.searing_pain.WARLOCK.customemote = {}
RPWORDLIST.searing_pain.WARLOCK.random = {}

RPWORDLIST.shadow_bolt.WARLOCK = {}
RPWORDLIST.shadow_bolt.WARLOCK.emote = {}
RPWORDLIST.shadow_bolt.WARLOCK.customemote = {}
RPWORDLIST.shadow_bolt.WARLOCK.random = {}

RPWORDLIST.soul_fire.WARLOCK = {}
RPWORDLIST.soul_fire.WARLOCK.emote = {}
RPWORDLIST.soul_fire.WARLOCK.customemote = {}
RPWORDLIST.soul_fire.WARLOCK.random = {}

end