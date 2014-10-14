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
RPWORDLIST.entercombat.ROGUE = {"Euer Blut wird meine Klinge zieren!", "Wer flieht, wird gejagt!", "Habt Ihr mich nicht kommen sehen? Ich war Euer Schatten und gleich seit Ihr einer!", }
RPWORDLIST.entercombat.ROGUE.emote = {}
RPWORDLIST.entercombat.ROGUE.customemote = {}
RPWORDLIST.entercombat.ROGUE.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.ROGUE = {}
RPWORDLIST.leavecombat.ROGUE.emote = {}
RPWORDLIST.leavecombat.ROGUE.customemote = {}
RPWORDLIST.leavecombat.ROGUE.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.ROGUE = {}
RPWORDLIST.hurt.ROGUE.emote = {}
RPWORDLIST.hurt.ROGUE.customemote = {}
RPWORDLIST.hurt.ROGUE.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.ROGUE = {}
RPWORDLIST.absorb.ROGUE.emote = {}
RPWORDLIST.absorb.ROGUE.customemote = {}
RPWORDLIST.absorb.ROGUE.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.ROGUE = {}
RPWORDLIST.block.ROGUE.emote = {}
RPWORDLIST.block.ROGUE.customemote = {}
RPWORDLIST.block.ROGUE.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.ROGUE = {}
RPWORDLIST.dodge.ROGUE.emote = {}
RPWORDLIST.dodge.ROGUE.customemote = {}
RPWORDLIST.dodge.ROGUE.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.ROGUE = {}
RPWORDLIST.miss.ROGUE.emote = {}
RPWORDLIST.miss.ROGUE.customemote = {}
RPWORDLIST.miss.ROGUE.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.ROGUE = {}
RPWORDLIST.parry.ROGUE.emote = {}
RPWORDLIST.parry.ROGUE.customemote = {}
RPWORDLIST.parry.ROGUE.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.ROGUE = {"Schmeckt euch meine Klinge?.", "Meinen Klingen sind sehr scharf oder?.", }
RPWORDLIST.youcrit.ROGUE.emote = {}
RPWORDLIST.youcrit.ROGUE.customemote = {}
RPWORDLIST.youcrit.ROGUE.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.ROGUE = {}
RPWORDLIST.youcritspell.ROGUE.emote = {}
RPWORDLIST.youcritspell.ROGUE.customemote = {}
RPWORDLIST.youcritspell.ROGUE.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's personal pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.ROGUE = {}
RPWORDLIST.petattackstart.ROGUE.emote = {}
RPWORDLIST.entercombat.ROGUE.customemote = {}
RPWORDLIST.petattackstart.ROGUE.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.ROGUE = {}
RPWORDLIST.petattackstop.ROGUE.emote = {}
RPWORDLIST.entercombat.ROGUE.customemote = {}
RPWORDLIST.petattackstop.ROGUE.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.ROGUE = {}
RPWORDLIST.npctalksfriend.ROGUE.emote = {}
RPWORDLIST.npctalksfriend.ROGUE.customemote = {}
RPWORDLIST.npctalksfriend.ROGUE.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.ROGUE = {}
RPWORDLIST.npctalksenemy.ROGUE.emote = {}
RPWORDLIST.npctalksenemy.ROGUE.customemote = {}
RPWORDLIST.npctalksenemy.ROGUE.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.ROGUE = {}
RPWORDLIST.resurrect.ROGUE.emote = {}
RPWORDLIST.resurrect.ROGUE.customemote = {}
RPWORDLIST.resurrect.ROGUE.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Rogue Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Lockpicking
--=====================================================================--
RPWORDLIST.pick_lock.ROGUE = {}
RPWORDLIST.pick_lock.ROGUE.emote = {}
RPWORDLIST.pick_lock.ROGUE.customemote = {}
RPWORDLIST.pick_lock.ROGUE.random = {}

--=====================================================================--
-- Poisons
--=====================================================================--
RPWORDLIST.crippling_poison.ROGUE = {}
RPWORDLIST.crippling_poison.ROGUE.emote = {}
RPWORDLIST.crippling_poison.ROGUE.customemote = {}
RPWORDLIST.crippling_poison.ROGUE.random = {}

RPWORDLIST.mind_numbing_poison.ROGUE = {}
RPWORDLIST.mind_numbing_poison.ROGUE.emote = {}
RPWORDLIST.mind_numbing_poison.ROGUE.customemote = {}
RPWORDLIST.mind_numbing_poison.ROGUE.random = {}

RPWORDLIST.instant_poison.ROGUE = {}
RPWORDLIST.instant_poison.ROGUE.emote = {}
RPWORDLIST.instant_poison.ROGUE.customemote = {}
RPWORDLIST.instant_poison.ROGUE.random = {}

RPWORDLIST.deadly_poison.ROGUE = {}
RPWORDLIST.deadly_poison.ROGUE.emote = {}
RPWORDLIST.deadly_poison.ROGUE.customemote = {}
RPWORDLIST.deadly_poison.ROGUE.random = {}

RPWORDLIST.wound_poison.ROGUE = {}
RPWORDLIST.wound_poison.ROGUE.emote = {}
RPWORDLIST.wound_poison.ROGUE.customemote = {}
RPWORDLIST.wound_poison.ROGUE.random = {}

--=====================================================================--
-- Subtlety
--=====================================================================--
RPWORDLIST.disarm_trap.ROGUE = {}
RPWORDLIST.disarm_trap.ROGUE.emote = {}
RPWORDLIST.disarm_trap.ROGUE.customemote = {}
RPWORDLIST.disarm_trap.ROGUE.random = {}

RPWORDLIST.premeditation.ROGUE = {}
RPWORDLIST.premeditation.ROGUE.emote = {}
RPWORDLIST.premeditation.ROGUE.customemote = {}
RPWORDLIST.premeditation.ROGUE.random = {}

end