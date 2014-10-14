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
RPWORDLIST.entercombat.TAUREN = {"F\195\188r die Erdenmutter!", }
RPWORDLIST.entercombat.TAUREN.emote = {"bleed","moo","guffaw","laugh","crack",}
RPWORDLIST.entercombat.TAUREN.customemote = {}
RPWORDLIST.entercombat.TAUREN.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.TAUREN = {"Man legt sich halt nicht mit einem Tauren an!", "Tja, Tauren sind halt die besseren K\195\164mpfer!", "Geht mit der Erdenmutter.", }
RPWORDLIST.leavecombat.TAUREN.emote = {}
RPWORDLIST.leavecombat.TAUREN.customemote = {}
RPWORDLIST.leavecombat.TAUREN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.TAUREN = {}
RPWORDLIST.hurt.TAUREN.emote = {}
RPWORDLIST.hurt.TAUREN.customemote = {}
RPWORDLIST.hurt.TAUREN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.TAUREN = {}
RPWORDLIST.absorb.TAUREN.emote = {}
RPWORDLIST.absorb.TAUREN.customemote = {}
RPWORDLIST.absorb.TAUREN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.TAUREN = {}
RPWORDLIST.block.TAUREN.emote = {}
RPWORDLIST.block.TAUREN.customemote = {}
RPWORDLIST.block.TAUREN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.TAUREN = {}
RPWORDLIST.dodge.TAUREN.emote = {}
RPWORDLIST.dodge.TAUREN.customemote = {}
RPWORDLIST.dodge.TAUREN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.TAUREN = {}
RPWORDLIST.miss.TAUREN.emote = {}
RPWORDLIST.miss.TAUREN.customemote = {}
RPWORDLIST.miss.TAUREN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.TAUREN = {}
RPWORDLIST.parry.TAUREN.emote = {}
RPWORDLIST.parry.TAUREN.customemote = {}
RPWORDLIST.parry.TAUREN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.TAUREN = {}
RPWORDLIST.youcrit.TAUREN.emote = {}
RPWORDLIST.youcrit.TAUREN.customemote = {}
RPWORDLIST.youcrit.TAUREN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.TAUREN = {}
RPWORDLIST.youcritspell.TAUREN.emote = {}
RPWORDLIST.youcritspell.TAUREN.customemote = {}
RPWORDLIST.youcritspell.TAUREN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.TAUREN = {}
RPWORDLIST.youheal.TAUREN.emote = {}
RPWORDLIST.youheal.TAUREN.customemote = {}
RPWORDLIST.youheal.TAUREN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.TAUREN = {}
RPWORDLIST.youcritheal.TAUREN.emote = {}
RPWORDLIST.youcritheal.TAUREN.customemote = {}
RPWORDLIST.youcritheal.TAUREN.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.TAUREN = {}
RPWORDLIST.petattackstart.TAUREN.emote = {}
RPWORDLIST.petattackstart.TAUREN.customemote = {}
RPWORDLIST.petattackstart.TAUREN.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.TAUREN = {}
RPWORDLIST.petattackstop.TAUREN.emote = {} 
RPWORDLIST.petattackstop.TAUREN.customemote = {}
RPWORDLIST.petattackstop.TAUREN.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.TAUREN = {}
RPWORDLIST.petdies.TAUREN.emote = {}      
RPWORDLIST.petdies.TAUREN.customemote = {}
RPWORDLIST.petdies.TAUREN.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.TAUREN = {}
RPWORDLIST.npctalksfriend.TAUREN.emote = {}
RPWORDLIST.npctalksfriend.TAUREN.customemote = {}
RPWORDLIST.npctalksfriend.TAUREN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.TAUREN = {}
RPWORDLIST.npctalksenemy.TAUREN.emote = {}
RPWORDLIST.npctalksenemy.TAUREN.customemote = {}
RPWORDLIST.npctalksenemy.TAUREN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.TAUREN = {"Die Erdenmutter war mir gn\195\164dig!", "Gr\195\188ne Wiesen... saftige Weiden... oh nein es war nur ein Traum!", "Ich habe mir wohl noch nicht das Recht f\195\188r die ewigen Jagdgr\195\188nde verdient...", "Nun bin ich wirklich w\195\188tend!", "Moooouuuhhhhhhh!", "Ein wiederbelebter Taure ist ein w\195\188tender Taure!", "Ok, nun bin ich wirklich Sauer!", }
RPWORDLIST.resurrect.TAUREN.emote = {}
RPWORDLIST.resurrect.TAUREN.customemote = {}
RPWORDLIST.resurrect.TAUREN.random = {}

end