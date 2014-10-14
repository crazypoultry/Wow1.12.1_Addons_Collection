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
RPWORDLIST.entercombat.WARRIOR = {}
RPWORDLIST.entercombat.WARRIOR.emote = {}
RPWORDLIST.entercombat.WARRIOR.customemote = {}
RPWORDLIST.entercombat.WARRIOR.random = {

	["phrase"] = "Ich BLANK deine BLANK!",

	[1] = { "zerschneide", "zerquetsche", "zerfetze", "vernichte", "zertr\195\188mmere",},

	[2] = {"Arme", "Beine", "Augen", "Z\195\164hne",
			"Ged\195\164rme", "Rippen", "H\195\164nde", "Knochen", "Beine", "F\195\188sse", "Kniescheiben",},
	}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.WARRIOR = {}
RPWORDLIST.leavecombat.WARRIOR.emote = {}
RPWORDLIST.leavecombat.WARRIOR.customemote = {}
RPWORDLIST.leavecombat.WARRIOR.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.WARRIOR = {}
RPWORDLIST.hurt.WARRIOR.emote = {}
RPWORDLIST.hurt.WARRIOR.customemote = {}
RPWORDLIST.hurt.WARRIOR.random = {

	["phrase"] = "Ich BLANK dein BLANK!",

	[1] = {"reisse", "schneide", "beisse", "hacke", "schnitze", "schlitze", },

	[2] = {"Herz heraus", "Auge aus", "Niere heraus",
			"Ged\195\164rm raus", "Gehirn weg",},
	}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.WARRIOR = {}
RPWORDLIST.absorb.WARRIOR.emote = {}
RPWORDLIST.absorb.WARRIOR.customemote = {}
RPWORDLIST.absorb.WARRIOR.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.WARRIOR = {}
RPWORDLIST.block.WARRIOR.emote = {}
RPWORDLIST.block.WARRIOR.customemote = {}
RPWORDLIST.block.WARRIOR.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.WARRIOR = {}
RPWORDLIST.dodge.WARRIOR.emote = {}
RPWORDLIST.dodge.WARRIOR.customemote = {}
RPWORDLIST.dodge.WARRIOR.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.WARRIOR = {}
RPWORDLIST.miss.WARRIOR.emote = {}
RPWORDLIST.miss.WARRIOR.customemote = {}
RPWORDLIST.miss.WARRIOR.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.WARRIOR = {}
RPWORDLIST.parry.WARRIOR.emote = {}
RPWORDLIST.parry.WARRIOR.customemote = {}
RPWORDLIST.parry.WARRIOR.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.WARRIOR = {"Meine Hiebe haben richtig viel Kraft dahinter oder?.", "Har Har, ich werde euch noch zu Brei schlagen!.", }
RPWORDLIST.youcrit.WARRIOR.emote = {}
RPWORDLIST.youcrit.WARRIOR.customemote = {}
RPWORDLIST.youcrit.WARRIOR.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.WARRIOR = {}
RPWORDLIST.youcrit.WARRIOR.emote = {}
RPWORDLIST.youcrit.WARRIOR.customemote = {}
RPWORDLIST.youcritspell.WARRIOR.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's personal pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.WARRIOR = {}
RPWORDLIST.petattackstart.WARRIOR.emote = {}
RPWORDLIST.petattackstart.WARRIOR.customemote = {}
RPWORDLIST.petattackstart.WARRIOR.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.WARRIOR = {}
RPWORDLIST.petattackstop.WARRIOR.emote = {}
RPWORDLIST.petattackstop.WARRIOR.customemote = {}
RPWORDLIST.petattackstop.WARRIOR.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.WARRIOR = {}
RPWORDLIST.npctalksfriend.WARRIOR.emote = {}
RPWORDLIST.npctalksfriend.WARRIOR.customemote = {}
RPWORDLIST.npctalksfriend.WARRIOR.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.WARRIOR = {}
RPWORDLIST.npctalksenemy.WARRIOR.emote = {}
RPWORDLIST.npctalksenemy.WARRIOR.customemote = {}
RPWORDLIST.npctalksenemy.WARRIOR.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.WARRIOR = {}
RPWORDLIST.resurrect.WARRIOR.emote = {}
RPWORDLIST.resurrect.WARRIOR.customemote = {}
RPWORDLIST.resurrect.WARRIOR.random = {}

--//////////////////////////////////////////////////////////////////////////--
-- Warrior Spells
--//////////////////////////////////////////////////////////////////////////--
RPWORDLIST.slam.WARRIOR = {}
RPWORDLIST.slam.WARRIOR.emote = {}
RPWORDLIST.slam.WARRIOR.customemote = {}
RPWORDLIST.slam.WARRIOR.random = {}


end