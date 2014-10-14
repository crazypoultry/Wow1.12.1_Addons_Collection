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
RPWORDLIST.entercombat.GNOME = {"F\195\188r Gnomeregan!", "Angriff!", "Ich bin zwar klein aber auch schrecklich gemein!", "Wenn ihr euch ergebt, denke ich vielleicht dar\195\188ber nach euch zu verschonen!", }
RPWORDLIST.entercombat.GNOME.emote = {}
RPWORDLIST.entercombat.GNOME.customemote = {}
RPWORDLIST.entercombat.GNOME.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.GNOME = {}
RPWORDLIST.leavecombat.GNOME.emote = {}
RPWORDLIST.leavecombat.GNOME.customemote = {}
RPWORDLIST.leavecombat.GNOME.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.GNOME = {
	"Nicht auf den Kopf! Nicht auf den Kopf!",
	"Tut mir nichts! Ich bin klein und niedlich.",
	"Also irgendwie finde ich Schmerzen doof.",
	}
RPWORDLIST.hurt.GNOME.emote = {}
RPWORDLIST.hurt.GNOME.customemote = {}
RPWORDLIST.hurt.GNOME.random = {

	["phrase"] = "BLANKBLANK BLANK",
	
	[1] = { "Ow! ", "Ouch! ", "Oof! ", "Ack! ", "Aua! ", "Autsch! ", },
	
	[2] = { "Aufh\195\182ren!", "Das tut weh!", "Schmerz.", "Das ist nicht nett.", "Ich bin doch lieb und knuddelig!", "Bitte nicht mehr weh tun!", "Nicht ins Gesicht!", "Das wird eine Narbe hinterlassen.", "Aua... lass das!",
			"Bitte... nicht weitermachen!", "Das wirst du bereuen.", "Das werde ich nicht vergessen.", "Das tut weh.", "H\195\182r auf auf die kleinen loszugehen!", "Such dir jemanden in deiner Gr\195\182sse!", },

	[3] = { "RINSULT","","","","", },

	}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.GNOME = {}
RPWORDLIST.absorb.GNOME.emote = {}
RPWORDLIST.absorb.GNOME.customemote = {}
RPWORDLIST.absorb.GNOME.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.GNOME = {}
RPWORDLIST.block.GNOME.emote = {}
RPWORDLIST.block.GNOME.customemote = {}
RPWORDLIST.block.GNOME.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.GNOME = {}
RPWORDLIST.dodge.GNOME.emote = {}
RPWORDLIST.dodge.GNOME.customemote = {}
RPWORDLIST.dodge.GNOME.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.GNOME = {}
RPWORDLIST.miss.GNOME.emote = {}
RPWORDLIST.miss.GNOME.customemote = {}
RPWORDLIST.miss.GNOME.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.GNOME = {}
RPWORDLIST.parry.GNOME.emote = {}
RPWORDLIST.parry.GNOME.customemote = {}
RPWORDLIST.parry.GNOME.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.GNOME = {"Nimm dies!","Nimm dies, und das, und dieses auch noch!"}
RPWORDLIST.youcrit.GNOME.emote = {}
RPWORDLIST.youcrit.GNOME.customemote = {}
RPWORDLIST.youcrit.GNOME.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.GNOME = {}
RPWORDLIST.youcritspell.GNOME.emote = {}
RPWORDLIST.youcritspell.GNOME.customemote = {}
RPWORDLIST.youcritspell.GNOME.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's personal pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.GNOME = {}
RPWORDLIST.petattackstart.GNOME.emote = {}
RPWORDLIST.petattackstart.GNOME.customemote = {}
RPWORDLIST.petattackstart.GNOME.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.GNOME = {}
RPWORDLIST.petdies.GNOME.emote = {}
RPWORDLIST.petdies.GNOME.customemote = {}
RPWORDLIST.petdies.GNOME.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.GNOME = {}
RPWORDLIST.npctalksfriend.GNOME.emote = {}
RPWORDLIST.npctalksfriend.GNOME.customemote = {}
RPWORDLIST.npctalksfriend.GNOME.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.GNOME = {}
RPWORDLIST.npctalksenemy.GNOME.emote = {}
RPWORDLIST.npctalksenemy.GNOME.customemote = {}
RPWORDLIST.npctalksenemy.GNOME.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.GNOME = {"Was ist Passiert?", "Erfahrung ist eine n\195\188tzliche Sache... leider macht man sie immer erst kurz nachdem man sie braucht.", "Kein Gnom l\195\164sst sich sowas gefallen! Na warte!", "Das war vielleicht ein fieser Traum!", }
RPWORDLIST.resurrect.GNOME.emote = {}
RPWORDLIST.resurrect.GNOME.customemote = {}
RPWORDLIST.resurrect.GNOME.random = {}

end
