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
RPWORDLIST.entercombat.NIGHTELF = {"M\195\182ge man mir beistehen!", "Es wird mir eine Freude sein euch ins Jenseits zu bef\195\182rdern.", "Bei Elune!", "Beim Namen von Elune... ihr werdet sterben.", }
RPWORDLIST.entercombat.NIGHTELF.emote = {}
RPWORDLIST.entercombat.NIGHTELF.customemote = {}
RPWORDLIST.entercombat.NIGHTELF.random = {

	["phrase"] = "Ihr BLANK BLANK BLANK",

	[1] = {"sollt","werdet","m\195\188sst" },

	[2] = {"im Namen von Elune","im Namen der G\195\182tter","f\195\188r die G\195\182tter", },

	[3] = {"sterben.","in Frieden ruhen.","gereinigt werden."},

	}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.NIGHTELF = {"Kluge Leute lernen auch von ihren Feinden! Ich hoffe ihr habt eure Lektion gelernt.", "Erfahrung ist eine n\195\188tzliche Sache... leider machen einige sie zu sp\195\164t.", "Das Leben ist wie der Sturm, der den Weltenbaum ersch\195\188ttert... alle Wesen sind Bl\195\164tter an diesem Baum. Und es gibt schwarze und weiße Bl\195\164tter", }
RPWORDLIST.leavecombat.NIGHTELF.emote = {}
RPWORDLIST.leavecombat.NIGHTELF.customemote = {}
RPWORDLIST.leavecombat.NIGHTELF.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.NIGHTELF = {}
RPWORDLIST.hurt.NIGHTELF.emote = {}
RPWORDLIST.hurt.NIGHTELF.customemote = {}
RPWORDLIST.hurt.NIGHTELF.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.NIGHTELF = {}
RPWORDLIST.absorb.NIGHTELF.emote = {}
RPWORDLIST.absorb.NIGHTELF.customemote = {}
RPWORDLIST.absorb.NIGHTELF.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.NIGHTELF = {}
RPWORDLIST.block.NIGHTELF.emote = {}
RPWORDLIST.block.NIGHTELF.customemote = {}
RPWORDLIST.block.NIGHTELF.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.NIGHTELF = {}
RPWORDLIST.dodge.NIGHTELF.emote = {}
RPWORDLIST.dodge.NIGHTELF.customemote = {}
RPWORDLIST.dodge.NIGHTELF.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.NIGHTELF = {}
RPWORDLIST.miss.NIGHTELF.emote = {}
RPWORDLIST.miss.NIGHTELF.customemote = {}
RPWORDLIST.miss.NIGHTELF.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.NIGHTELF = {}
RPWORDLIST.parry.NIGHTELF.emote = {}
RPWORDLIST.parry.NIGHTELF.customemote = {}
RPWORDLIST.parry.NIGHTELF.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.NIGHTELF = {}
RPWORDLIST.youcrit.NIGHTELF.emote = {}
RPWORDLIST.youcrit.NIGHTELF.customemote = {}
RPWORDLIST.youcrit.NIGHTELF.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.NIGHTELF = {}
RPWORDLIST.youcritspell.NIGHTELF.emote = {}
RPWORDLIST.youcritspell.NIGHTELF.customemote = {}
RPWORDLIST.youcritspell.NIGHTELF.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.NIGHTELF = {}
RPWORDLIST.youheal.NIGHTELF.emote = {}
RPWORDLIST.youheal.NIGHTELF.customemote = {}
RPWORDLIST.youheal.NIGHTELF.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.NIGHTELF = {}
RPWORDLIST.youcritheal.NIGHTELF.emote = {}
RPWORDLIST.youcritheal.NIGHTELF.customemote = {}
RPWORDLIST.youcritheal.NIGHTELF.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.NIGHTELF = {}
RPWORDLIST.petattackstart.NIGHTELF.emote = {}
RPWORDLIST.petattackstart.NIGHTELF.customemote = {}
RPWORDLIST.petattackstart.NIGHTELF.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.NIGHTELF = {}
RPWORDLIST.petattackstop.NIGHTELF.emote = {}
RPWORDLIST.petattackstop.NIGHTELF.customemote = {}
RPWORDLIST.petattackstop.NIGHTELF.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.NIGHTELF = {}
RPWORDLIST.petdies.NIGHTELF.emote = {}
RPWORDLIST.petdies.NIGHTELF.customemote = {}
RPWORDLIST.petdies.NIGHTELF.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.NIGHTELF = {}
RPWORDLIST.npctalksfriend.NIGHTELF.emote = {}
RPWORDLIST.npctalksfriend.NIGHTELF.customemote = {}
RPWORDLIST.npctalksfriend.NIGHTELF.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.NIGHTELF = {}
RPWORDLIST.npctalksenemy.NIGHTELF.emote = {}
RPWORDLIST.npctalksenemy.NIGHTELF.customemote = {}
RPWORDLIST.npctalksenemy.NIGHTELF.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.NIGHTELF = {
	"F\195\188r einen kurzen Moment, sp\195\188hrte ich die presents von Elune.",
	"F\195\188r einen Moment nahm ich die Anwesenheit von Elune wahr.",
	"Preiset die G\195\182tter!"
	}
RPWORDLIST.resurrect.NIGHTELF.emote = {"PRAY"}
RPWORDLIST.resurrect.NIGHTELF.customemote = {}
RPWORDLIST.resurrect.NIGHTELF.random = {

	["phrase"] = "BLANK BLANK",

	[1] = {"Dank Elune,","Durch die G\195\182tter,","Elune l\195\164chelte mich an und nun", "Die G\195\182tter sind mit gn\195\164dig gestimmt"},

	[2] = {"lebe ich wieder.","bin ich wieder am Leben.", "bin ich wieder mit dieser Welt verbunden.", "bin ich wieder hier."},

	}
end