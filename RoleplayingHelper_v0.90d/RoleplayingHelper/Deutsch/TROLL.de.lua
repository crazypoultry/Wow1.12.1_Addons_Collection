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
RPWORDLIST.entercombat.TROLL = {}
RPWORDLIST.entercombat.TROLL.emote = {"Snarl","Guffaw","Growl","Laugh","Crack"} 
RPWORDLIST.entercombat.TROLL.customemote = {}
RPWORDLIST.entercombat.TROLL.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.TROLL = {}
RPWORDLIST.leavecombat.TROLL.emote = {}                                       
RPWORDLIST.leavecombat.TROLL.customemote = {}
RPWORDLIST.leavecombat.TROLL.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.TROLL = {}
RPWORDLIST.hurt.TROLL.emote = {}       
RPWORDLIST.hurt.TROLL.customemote = {}
RPWORDLIST.hurt.TROLL.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.TROLL = {}
RPWORDLIST.absorb.TROLL.emote = {}
RPWORDLIST.absorb.TROLL.customemote = {}
RPWORDLIST.absorb.TROLL.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.TROLL = {}
RPWORDLIST.block.TROLL.emote = {} 
RPWORDLIST.block.TROLL.customemote = {}
RPWORDLIST.block.TROLL.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.TROLL = {}
RPWORDLIST.dodge.TROLL.emote = {}
RPWORDLIST.dodge.TROLL.customemote = {}
RPWORDLIST.dodge.TROLL.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.TROLL = {}
RPWORDLIST.miss.TROLL.emote = {} 
RPWORDLIST.miss.TROLL.customemote = {}
RPWORDLIST.miss.TROLL.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.TROLL = {}
RPWORDLIST.parry.TROLL.emote = {}
RPWORDLIST.parry.TROLL.customemote = {}
RPWORDLIST.parry.TROLL.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.TROLL = {}
RPWORDLIST.youcrit.TROLL.emote = {} 
RPWORDLIST.youcrit.TROLL.customemote = {}
RPWORDLIST.youcrit.TROLL.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.TROLL = {}
RPWORDLIST.youcritspell.TROLL.emote = {}
RPWORDLIST.youcritspell.TROLL.customemote = {}
RPWORDLIST.youcritspell.TROLL.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.TROLL = {}
RPWORDLIST.youheal.TROLL.emote = {}
RPWORDLIST.youheal.TROLL.customemote = {}
RPWORDLIST.youheal.TROLL.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.TROLL = {}
RPWORDLIST.youcritheal.TROLL.emote = {}
RPWORDLIST.youcritheal.TROLL.customemote = {}
RPWORDLIST.youcritheal.TROLL.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.TROLL = {}
RPWORDLIST.petattackstart.TROLL.emote = {}
RPWORDLIST.petattackstart.TROLL.customemote = {}
RPWORDLIST.petattackstart.TROLL.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.TROLL = {}
RPWORDLIST.petattackstop.TROLL.emote = {} 
RPWORDLIST.petattackstop.TROLL.customemote = {}
RPWORDLIST.petattackstop.TROLL.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.TROLL = {}
RPWORDLIST.petdies.TROLL.emote = {}      
RPWORDLIST.petdies.TROLL.customemote = {}
RPWORDLIST.petdies.TROLL.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.TROLL = {}
RPWORDLIST.npctalksfriend.TROLL.emote = {}
RPWORDLIST.npctalksfriend.TROLL.customemote = {}
RPWORDLIST.npctalksfriend.TROLL.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.TROLL = {}
RPWORDLIST.npctalksenemy.TROLL.emote = {}
RPWORDLIST.npctalksenemy.TROLL.customemote = {}
RPWORDLIST.npctalksenemy.TROLL.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.TROLL = {}
RPWORDLIST.resurrect.TROLL.emote = {}
RPWORDLIST.resurrect.TROLL.customemote = {}
RPWORDLIST.resurrect.TROLL.random = {}

end