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
RPWORDLIST.entercombat.DWARF = {"F\195\188r Ironforge!", "Euch ramme ich ungespitzt in den Boden!", "Eine sch\195\182ne klopperei und wieder mal ein Zwerg dabei!", "Bier gibt einen Kraft und St\195\164rke. Ich bin sehr stark also ergebt euch besser!", "Har Har! Jemand der es wagt sich einen Zwerg in den Weg zu stellen, hat nicht viel zu lachen!", }
RPWORDLIST.entercombat.DWARF.emote = {}
RPWORDLIST.entercombat.DWARF.customemote = {}
RPWORDLIST.entercombat.DWARF.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.DWARF = {"Man legt sich halt nicht mit einem Zwerg an!", "Tja, Zwerge sind halt die besseren K\195\164mpfer!", }
RPWORDLIST.leavecombat.DWARF.emote = {}
RPWORDLIST.leavecombat.DWARF.customemote = {}
RPWORDLIST.leavecombat.DWARF.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.DWARF = {"Du meinst, das sei eine Wunde?! Ein Zwerg steht mit so einem Kratzer noch in der ersten Reihe!", "Argh, naja k\195\182nnte vieeel schlimmer sein...!", }
RPWORDLIST.hurt.DWARF.emote = {}
RPWORDLIST.hurt.DWARF.customemote = {}
RPWORDLIST.hurt.DWARF.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.DWARF = {}
RPWORDLIST.absorb.DWARF.emote = {}
RPWORDLIST.absorb.DWARF.customemote = {}
RPWORDLIST.absorb.DWARF.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.DWARF = {}
RPWORDLIST.block.DWARF.emote = {}
RPWORDLIST.block.DWARF.customemote = {}
RPWORDLIST.block.DWARF.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.DWARF = {}
RPWORDLIST.dodge.DWARF.emote = {}
RPWORDLIST.dodge.DWARF.customemote = {}
RPWORDLIST.dodge.DWARF.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.DWARF = {}
RPWORDLIST.miss.DWARF.emote = {}
RPWORDLIST.miss.DWARF.customemote = {}
RPWORDLIST.miss.DWARF.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.DWARF = {}
RPWORDLIST.parry.DWARF.emote = {}
RPWORDLIST.parry.DWARF.customemote = {}
RPWORDLIST.parry.DWARF.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.DWARF = {}
RPWORDLIST.youcrit.DWARF.emote = {}
RPWORDLIST.youcrit.DWARF.customemote = {}
RPWORDLIST.youcrit.DWARF.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.DWARF = {}
RPWORDLIST.youcritspell.DWARF.emote = {}
RPWORDLIST.youcritspell.DWARF.customemote = {}
RPWORDLIST.youcritspell.DWARF.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.DWARF = {}
RPWORDLIST.youheal.DWARF.emote = {}
RPWORDLIST.youheal.DWARF.customemote = {}
RPWORDLIST.youheal.DWARF.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.DWARF = {}
RPWORDLIST.youcritheal.DWARF.emote = {}
RPWORDLIST.youcritheal.DWARF.customemote = {}
RPWORDLIST.youcritheal.DWARF.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.DWARF = {}
RPWORDLIST.petattackstart.DWARF.emote = {}
RPWORDLIST.petattackstart.DWARF.customemote = {}
RPWORDLIST.petattackstart.DWARF.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.DWARF = {}
RPWORDLIST.petattackstop.DWARF.emote = {}
RPWORDLIST.petattackstop.DWARF.customemote = {}
RPWORDLIST.petattackstop.DWARF.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.DWARF = {}
RPWORDLIST.petdies.DWARF.emote = {}
RPWORDLIST.petdies.DWARF.customemote = {}
RPWORDLIST.petdies.DWARF.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.DWARF = {}
RPWORDLIST.npctalksfriend.DWARF.emote = {}
RPWORDLIST.npctalksfriend.DWARF.customemote = {}
RPWORDLIST.npctalksfriend.DWARF.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.DWARF = {}
RPWORDLIST.npctalksenemy.DWARF.emote = {}
RPWORDLIST.npctalksenemy.DWARF.customemote = {}
RPWORDLIST.npctalksenemy.DWARF.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.DWARF = {"Zwerge sterben nicht....sie sind h\195\182chstens eine Zeitlang ausser Gefecht!", "Baaah... Das war ein schrecklicher Alptraum! \195\132h? Wie bin ich hierhergelangt?", "Wo bin ich und weshalb habe ich so viele L\195\182cher in meiner R\195\188stung?", "Jetzt brauche ich erstmal ein Bier!", }
RPWORDLIST.resurrect.DWARF.emote = {}
RPWORDLIST.resurrect.DWARF.customemote = {}
RPWORDLIST.resurrect.DWARF.random = {}

end