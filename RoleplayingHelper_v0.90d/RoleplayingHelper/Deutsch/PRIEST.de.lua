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
RPWORDLIST.entercombat.PRIEST = {}
RPWORDLIST.entercombat.PRIEST.emote = {}
RPWORDLIST.entercombat.PRIEST.customemote = {}
RPWORDLIST.entercombat.PRIEST.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.PRIEST = {}
RPWORDLIST.leavecombat.PRIEST.emote = {}
RPWORDLIST.leavecombat.PRIEST.customemote = {}
RPWORDLIST.leavecombat.PRIEST.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.PRIEST = {}
RPWORDLIST.hurt.PRIEST.emote = {}
RPWORDLIST.hurt.PRIEST.customemote = {}
RPWORDLIST.hurt.PRIEST.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.PRIEST = {}
RPWORDLIST.absorb.PRIEST.emote = {}
RPWORDLIST.absorb.PRIEST.customemote = {}
RPWORDLIST.absorb.PRIEST.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.PRIEST = {}
RPWORDLIST.block.PRIEST.emote = {}
RPWORDLIST.block.PRIEST.customemote = {}
RPWORDLIST.block.PRIEST.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.PRIEST = {}
RPWORDLIST.dodge.PRIEST.emote = {}
RPWORDLIST.dodge.PRIEST.customemote = {}
RPWORDLIST.dodge.PRIEST.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.PRIEST = {}
RPWORDLIST.miss.PRIEST.emote = {}
RPWORDLIST.miss.PRIEST.customemote = {}
RPWORDLIST.miss.PRIEST.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.PRIEST = {}
RPWORDLIST.parry.PRIEST.emote = {}
RPWORDLIST.parry.PRIEST.customemote = {}
RPWORDLIST.parry.PRIEST.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.PRIEST = {}
RPWORDLIST.youcrit.PRIEST.emote = {}
RPWORDLIST.youcrit.PRIEST.customemote = {}
RPWORDLIST.youcrit.PRIEST.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.PRIEST = {"Sp\195\188rt ihr die Macht eines Priesters!", "H\195\182ret das heilige Wort!", "Der segen von Priestern kann heilend als auch vernichtend wirken! Ihr bekommt das was ihr verdient!", }
RPWORDLIST.youcritspell.PRIEST.emote = {}
RPWORDLIST.youcritspell.PRIEST.customemote = {}
RPWORDLIST.youcritspell.PRIEST.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.PRIEST = {}
RPWORDLIST.youheal.PRIEST.emote = {}
RPWORDLIST.youheal.PRIEST.customemote = {}
RPWORDLIST.youheal.PRIEST.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.PRIEST = {}
RPWORDLIST.youcritheal.PRIEST.emote = {}
RPWORDLIST.youcritheal.PRIEST.customemote = {}
RPWORDLIST.youcritheal.PRIEST.random = {}

-- A PRIEST'S GAINS A PET WHEN THEY MIND CONTROL --

--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.PRIEST = {}
RPWORDLIST.petattackstart.PRIEST.emote = {}
RPWORDLIST.petattackstart.PRIEST.customemote = {}
RPWORDLIST.petattackstart.PRIEST.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.PRIEST = {}
RPWORDLIST.petattackstop.PRIEST.emote = {} 
RPWORDLIST.petattackstop.PRIEST.customemote = {}
RPWORDLIST.petattackstop.PRIEST.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.PRIEST = {}
RPWORDLIST.petdies.PRIEST.emote = {}      
RPWORDLIST.petdies.PRIEST.customemote = {}
RPWORDLIST.petdies.PRIEST.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.PRIEST = {}
RPWORDLIST.npctalksfriend.PRIEST.emote = {}
RPWORDLIST.npctalksfriend.PRIEST.customemote = {}
RPWORDLIST.npctalksfriend.PRIEST.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.PRIEST = {}
RPWORDLIST.npctalksenemy.PRIEST.emote = {}
RPWORDLIST.npctalksenemy.PRIEST.customemote = {}
RPWORDLIST.npctalksenemy.PRIEST.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.PRIEST = {}
RPWORDLIST.resurrect.PRIEST.emote = {}
RPWORDLIST.resurrect.PRIEST.customemote = {}
RPWORDLIST.resurrect.PRIEST.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Priest Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Holy
--=====================================================================-- 
RPWORDLIST.lesser_heal.PRIEST = {}
RPWORDLIST.lesser_heal.PRIEST.emote = {}
RPWORDLIST.lesser_heal.PRIEST.customemote = {}
RPWORDLIST.lesser_heal.PRIEST.random = {}

RPWORDLIST.heal.PRIEST = {}
RPWORDLIST.heal.PRIEST.emote = {}
RPWORDLIST.heal.PRIEST.customemote = {}
RPWORDLIST.heal.PRIEST.random = {}

RPWORDLIST.flash_heal.PRIEST = {}
RPWORDLIST.flash_heal.PRIEST.emote = {}
RPWORDLIST.flash_heal.PRIEST.customemote = {}
RPWORDLIST.flash_heal.PRIEST.random = {}

RPWORDLIST.prayer_of_healing.PRIEST = {}
RPWORDLIST.prayer_of_healing.PRIEST.emote = {}
RPWORDLIST.prayer_of_healing.PRIEST.customemote = {}
RPWORDLIST.prayer_of_healing.PRIEST.random = {}

RPWORDLIST.greater_heal.PRIEST = {}
RPWORDLIST.greater_heal.PRIEST.emote = {}
RPWORDLIST.greater_heal.PRIEST.customemote = {}
RPWORDLIST.greater_heal.PRIEST.random = {}

-------------------------------------------------------------------------

RPWORDLIST.smite.PRIEST = {}
RPWORDLIST.smite.PRIEST.emote = {}
RPWORDLIST.smite.PRIEST.customemote = {}
RPWORDLIST.smite.PRIEST.random = {}

RPWORDLIST.resurrection.PRIEST = {}
RPWORDLIST.resurrection.PRIEST.emote = {}
RPWORDLIST.resurrection.PRIEST.customemote = {}
RPWORDLIST.resurrection.PRIEST.random = {}

RPWORDLIST.holy_fire.PRIEST = {}
RPWORDLIST.holy_fire.PRIEST.emote = {}
RPWORDLIST.holy_fire.PRIEST.customemote = {}
RPWORDLIST.holy_fire.PRIEST.random = {}

--=====================================================================--
-- Shadow Magic
--=====================================================================--
RPWORDLIST.mind_blast.PRIEST = {}
RPWORDLIST.mind_blast.PRIEST.emote = {}
RPWORDLIST.mind_blast.PRIEST.customemote = {}
RPWORDLIST.mind_blast.PRIEST.random = {} 

RPWORDLIST.mind_control.PRIEST = {}
RPWORDLIST.mind_control.PRIEST.emote = {}
RPWORDLIST.mind_control.PRIEST.customemote = {}
RPWORDLIST.mind_control.PRIEST.random = {}

RPWORDLIST.mind_soothe.PRIEST = {}
RPWORDLIST.mind_soothe.PRIEST.emote = {}
RPWORDLIST.mind_soothe.PRIEST.customemote = {}
RPWORDLIST.mind_soothe.PRIEST.random = {}

RPWORDLIST.shadowguard.PRIEST = {}
RPWORDLIST.shadowguard.PRIEST.emote = {}
RPWORDLIST.shadowguard.PRIEST.customemote = {}
RPWORDLIST.shadowguard.PRIEST.random = {}

--=====================================================================--
-- Discipline
--=====================================================================--
RPWORDLIST.shackle_undead.PRIEST = {}
RPWORDLIST.shackle_undead.PRIEST.emote = {}
RPWORDLIST.shackle_undead.PRIEST.customemote = {}
RPWORDLIST.shackle_undead.PRIEST.random = {}

RPWORDLIST.mana_burn.PRIEST = {}
RPWORDLIST.mana_burn.PRIEST.emote = {}
RPWORDLIST.mana_burn.PRIEST.customemote = {}
RPWORDLIST.mana_burn.PRIEST.random = {}


end