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
RPWORDLIST.entercombat.HUMAN = {"Keine Gnade f\195\188r den Feind!", "Kein Feind wird uns unterdr\195\188cken!", }
RPWORDLIST.entercombat.HUMAN.emote = {}
RPWORDLIST.entercombat.HUMAN.customemote = {}
RPWORDLIST.entercombat.HUMAN.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.HUMAN = {}
RPWORDLIST.leavecombat.HUMAN.emote = {}
RPWORDLIST.leavecombat.HUMAN.customemote = {}
RPWORDLIST.leavecombat.HUMAN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.HUMAN = {}
RPWORDLIST.hurt.HUMAN.emote = {}
RPWORDLIST.hurt.HUMAN.customemote = {}
RPWORDLIST.hurt.HUMAN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.HUMAN = {}
RPWORDLIST.absorb.HUMAN.emote = {}
RPWORDLIST.absorb.HUMAN.customemote = {}
RPWORDLIST.absorb.HUMAN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.HUMAN = {}
RPWORDLIST.block.HUMAN.emote = {}
RPWORDLIST.block.HUMAN.customemote = {}
RPWORDLIST.block.HUMAN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.HUMAN = {}
RPWORDLIST.dodge.HUMAN.emote = {}
RPWORDLIST.dodge.HUMAN.customemote = {}
RPWORDLIST.dodge.HUMAN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.HUMAN = {}
RPWORDLIST.miss.HUMAN.emote = {}
RPWORDLIST.miss.HUMAN.customemote = {}
RPWORDLIST.miss.HUMAN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.HUMAN = {}
RPWORDLIST.parry.HUMAN.emote = {}
RPWORDLIST.parry.HUMAN.customemote = {}
RPWORDLIST.parry.HUMAN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.HUMAN = {}
RPWORDLIST.youcrit.HUMAN.emote = {}
RPWORDLIST.youcrit.HUMAN.customemote = {}
RPWORDLIST.youcrit.HUMAN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.HUMAN = {}
RPWORDLIST.youcritspell.HUMAN.emote = {}
RPWORDLIST.youcritspell.HUMAN.customemote = {}
RPWORDLIST.youcritspell.HUMAN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.HUMAN = {}
RPWORDLIST.youheal.HUMAN.emote = {}
RPWORDLIST.youheal.HUMAN.customemote = {}
RPWORDLIST.youheal.HUMAN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.HUMAN = {}
RPWORDLIST.youcritheal.HUMAN.emote = {}
RPWORDLIST.youcritheal.HUMAN.customemote = {}
RPWORDLIST.youcritheal.HUMAN.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name
	-- PTNAME = Pet's target's name
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.HUMAN = {}
RPWORDLIST.petattackstart.HUMAN.emote = {}
RPWORDLIST.petattackstart.HUMAN.customemote = {}
RPWORDLIST.petattackstart.HUMAN.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.HUMAN = {}
RPWORDLIST.petattackstop.HUMAN.emote = {}
RPWORDLIST.petattackstop.HUMAN.customemote = {}
RPWORDLIST.petattackstop.HUMAN.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.HUMAN = {}
RPWORDLIST.petdies.HUMAN.emote = {}
RPWORDLIST.petdies.HUMAN.customemote = {}
RPWORDLIST.petdies.HUMAN.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.HUMAN = {}
RPWORDLIST.npctalksfriend.HUMAN.emote = {}
RPWORDLIST.npctalksfriend.HUMAN.customemote = {}
RPWORDLIST.npctalksfriend.HUMAN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.HUMAN = {}
RPWORDLIST.npctalksenemy.HUMAN.emote = {}
RPWORDLIST.npctalksenemy.HUMAN.customemote = {}
RPWORDLIST.npctalksenemy.HUMAN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.HUMAN = {"Was ist passiert?", "Puuuh... Ich dachte schon das ist das Ende.", "Bin ich im Himmel? Hmmm nein, diesen h\195\164sslichen Ort kenne ich doch.", }
RPWORDLIST.resurrect.HUMAN.emote = {}
RPWORDLIST.resurrect.HUMAN.customemote = {}
RPWORDLIST.resurrect.HUMAN.random = {}

end