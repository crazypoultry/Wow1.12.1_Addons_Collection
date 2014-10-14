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
RPWORDLIST.entercombat.ORC = {"Euch ramme ich ungespitzt in den Boden!", "Ihr werdet euch w\195\188nschen niemals geboren worden zu sein!", "F\195\188r die Horde!", "F\195\188r Draenor!", "Ich werde den Wein des Sieges aus den K\195\182pfen deiner Kinder trinken!", "Ich liebe Schmerzen! Besonders wenn ich sie anderen zuf\195\188gen kann!", "Kein Gegner wiedersteht einem Ork!", "Whaaaaaaaaaaaaaaaaag!", "Ich liebe das Ger\195\164usch splitternder Knochen! Es wird Zeit das ich es wieder h\195\182re.", "Orks Orks Orks Orks Orks...!", "Macht euch gefasst eure Knochen brechen zu h\195\182ren!", "Jetzt wird Blut fliesssssssen!", "Zeit ein paar Sch\195\164del zu spalten!" }
RPWORDLIST.entercombat.ORC.emote = {"snarl","guffaw","growl","laugh","crack",}
RPWORDLIST.entercombat.ORC.customemote = {}
RPWORDLIST.entercombat.ORC.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.ORC = {}
RPWORDLIST.leavecombat.ORC.emote = {}
RPWORDLIST.leavecombat.ORC.customemote = {}
RPWORDLIST.leavecombat.ORC.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.ORC = {}
RPWORDLIST.hurt.ORC.emote = {}
RPWORDLIST.hurt.ORC.customemote = {}
RPWORDLIST.hurt.ORC.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.ORC = {}
RPWORDLIST.absorb.ORC.emote = {}
RPWORDLIST.absorb.ORC.customemote = {}
RPWORDLIST.absorb.ORC.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.ORC = {}
RPWORDLIST.block.ORC.emote = {}
RPWORDLIST.block.ORC.customemote = {}
RPWORDLIST.block.ORC.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.ORC = {}
RPWORDLIST.dodge.ORC.emote = {}
RPWORDLIST.dodge.ORC.customemote = {}
RPWORDLIST.dodge.ORC.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.ORC = {}
RPWORDLIST.miss.ORC.emote = {}
RPWORDLIST.miss.ORC.customemote = {}
RPWORDLIST.miss.ORC.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.ORC = {}
RPWORDLIST.parry.ORC.emote = {}
RPWORDLIST.parry.ORC.customemote = {}
RPWORDLIST.parry.ORC.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.ORC = {"Das splitter eurer Knochen ist Musik in meinen Ohren.", "Ich hoffe ihr lebt noch lange damit ich euch noch mehr Schmerzen bereiten kann!", "Na, wollt ihr noch mehr Schmerzen?", }
RPWORDLIST.youcrit.ORC.emote = {}
RPWORDLIST.youcrit.ORC.customemote = {}
RPWORDLIST.youcrit.ORC.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.ORC = {"Unser schamanistisches Erbe kommt uns zu gute.", }
RPWORDLIST.youcritspell.ORC.emote = {}
RPWORDLIST.youcritspell.ORC.customemote = {}
RPWORDLIST.youcritspell.ORC.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.ORC = {}
RPWORDLIST.youheal.ORC.emote = {}
RPWORDLIST.youheal.ORC.customemote = {}
RPWORDLIST.youheal.ORC.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.ORC = {}
RPWORDLIST.youcritheal.ORC.emote = {}
RPWORDLIST.youcritheal.ORC.customemote = {}
RPWORDLIST.youcritheal.ORC.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.ORC = {}
RPWORDLIST.petattackstart.ORC.emote = {}
RPWORDLIST.petattackstart.ORC.customemote = {}
RPWORDLIST.petattackstart.ORC.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.ORC = {}
RPWORDLIST.petattackstop.ORC.emote = {}
RPWORDLIST.petattackstop.ORC.customemote = {}
RPWORDLIST.petattackstop.ORC.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.ORC = {}
RPWORDLIST.petdies.ORC.emote = {}
RPWORDLIST.petdies.ORC.customemote = {}
RPWORDLIST.petdies.ORC.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.ORC = {}
RPWORDLIST.npctalksfriend.ORC.emote = {}
RPWORDLIST.npctalksfriend.ORC.customemote = {}
RPWORDLIST.npctalksfriend.ORC.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.ORC = {}
RPWORDLIST.npctalksenemy.ORC.emote = {}
RPWORDLIST.npctalksenemy.ORC.customemote = {}
RPWORDLIST.npctalksenemy.ORC.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.ORC = {"Ein wahrer Ork l\195\164sst sich vom Tod nicht erschrecken!", "Der glanz des Lebens hat mich wieder angezogen!", "Grrrrr, jetzt bin ich wirklich sauer!", "Der Geist von Draenor l\195\164sst mich nicht vergehen!", "Bei Thral! Ich werde nicht eher ruhen bis ich die Feinde der Horde vernichtet habe!", }
RPWORDLIST.resurrect.ORC.emote = {}
RPWORDLIST.resurrect.ORC.customemote = {}
RPWORDLIST.resurrect.ORC.random = {}

end