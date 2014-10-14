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
RPWORDLIST.entercombat.DRUID = {"Es ist Zeit den Feinden unserer Kultur gegen\195\188berzutreten!", "Manchmal muss der Friede mit Gewalt bewahrt werden. Auf in den Kampf!", "M\195\182gen mir meine Vorfahren beistehen!", "Helft mir meine Ahnen!", "Ich sch\195\164tze hier ist rohe Gewalt angebracht!", }
RPWORDLIST.entercombat.DRUID.emote = {}
RPWORDLIST.entercombat.DRUID.customemote = {}
RPWORDLIST.entercombat.DRUID.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.DRUID = {}
RPWORDLIST.leavecombat.DRUID.emote = {}
RPWORDLIST.leavecombat.DRUID.customemote = {}
RPWORDLIST.leavecombat.DRUID.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.DRUID = {}
RPWORDLIST.hurt.DRUID.emote = {}
RPWORDLIST.hurt.DRUID.customemote = {}
RPWORDLIST.hurt.DRUID.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.DRUID = {}
RPWORDLIST.absorb.DRUID.emote = {}
RPWORDLIST.absorb.DRUID.customemote = {}
RPWORDLIST.absorb.DRUID.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.DRUID = {}
RPWORDLIST.block.DRUID.emote = {}
RPWORDLIST.block.DRUID.customemote = {}
RPWORDLIST.block.DRUID.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.DRUID = {}
RPWORDLIST.dodge.DRUID.emote = {}
RPWORDLIST.dodge.DRUID.customemote = {}
RPWORDLIST.dodge.DRUID.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.DRUID = {}
RPWORDLIST.miss.DRUID.emote = {}
RPWORDLIST.miss.DRUID.customemote = {}
RPWORDLIST.miss.DRUID.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.DRUID = {}
RPWORDLIST.parry.DRUID.emote = {}
RPWORDLIST.parry.DRUID.customemote = {}
RPWORDLIST.parry.DRUID.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.DRUID = {}
RPWORDLIST.youcrit.DRUID.emote = {}
RPWORDLIST.youcrit.DRUID.customemote = {}
RPWORDLIST.youcrit.DRUID.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.DRUID = {}
RPWORDLIST.youcritspell.DRUID.emote = {}
RPWORDLIST.youcritspell.DRUID.customemote = {}
RPWORDLIST.youcritspell.DRUID.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.DRUID = {}
RPWORDLIST.youheal.DRUID.emote = {}
RPWORDLIST.youheal.DRUID.customemote = {}
RPWORDLIST.youheal.DRUID.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.DRUID = {}
RPWORDLIST.youcritheal.DRUID.emote = {}
RPWORDLIST.youcritheal.DRUID.customemote = {}
RPWORDLIST.youcritheal.DRUID.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.DRUID = {}
RPWORDLIST.npctalksfriend.DRUID.emote = {}
RPWORDLIST.npctalksfriend.DRUID.customemote = {}
RPWORDLIST.npctalksfriend.DRUID.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.DRUID = {}
RPWORDLIST.npctalksenemy.DRUID.emote = {}
RPWORDLIST.npctalksenemy.DRUID.customemote = {}
RPWORDLIST.npctalksenemy.DRUID.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.DRUID = {"Das Wissen meiner Vorfahren hat mich wiedereinmal vor dem Tode bewahrt.", "Die Geister wiesen mir einen Weg zur\195\188ck!", "Lebe ein gutes Leben und du bekommst vielleicht eine zweite chance. Nun, da bin ich wieder!", " Die Heilkunst hilft einen sogar den Tod zu \195\188berwinden!", "Das Wissen eines Druiden ist m\195\164chtiger als die Waffen der Feinde!", "Ich sp\195\188re den Geist des Lebens wieder in mir!", }
RPWORDLIST.resurrect.DRUID.emote = {}
RPWORDLIST.resurrect.DRUID.customemote = {}
RPWORDLIST.resurrect.DRUID.random = {}

--/////////////////////////////////////////////////////////////////////--
-- SPELLS with Cast Times  (Not instant or channeled)
--/////////////////////////////////////////////////////////////////////--
-- Feral Combat

-- Balance
RPWORDLIST.wrath.DRUID = {}
RPWORDLIST.wrath.DRUID.emote = {}
RPWORDLIST.wrath.DRUID.customemote = {}
RPWORDLIST.wrath.DRUID.random = {}

RPWORDLIST.entangling_roots.DRUID = {}
RPWORDLIST.entangling_roots.DRUID.emote = {}
RPWORDLIST.entangling_roots.DRUID.customemote = {}
RPWORDLIST.entangling_roots.DRUID.random = {}

RPWORDLIST.thorns.DRUID = {}
RPWORDLIST.thorns.DRUID.emote = {}
RPWORDLIST.thorns.DRUID.customemote = {}
RPWORDLIST.thorns.DRUID.random = {}

RPWORDLIST.hibernate.DRUID = {}
RPWORDLIST.hibernate.DRUID.emote = {}
RPWORDLIST.hibernate.DRUID.customemote = {}
RPWORDLIST.hibernate.DRUID.random = {}

RPWORDLIST.starfire.DRUID = {}
RPWORDLIST.starfire.DRUID.emote = {}
RPWORDLIST.starfire.DRUID.customemote = {}
RPWORDLIST.starfire.DRUID.random = {}

RPWORDLIST.soothe_animal.DRUID = {}
RPWORDLIST.soothe_animal.DRUID.emote = {}
RPWORDLIST.soothe_animal.DRUID.customemote = {}
RPWORDLIST.soothe_animal.DRUID.random = {}


-- Restoration                            
RPWORDLIST.healing_touch.DRUID = {}
RPWORDLIST.healing_touch.DRUID.emote = {}
RPWORDLIST.healing_touch.DRUID.customemote = {}
RPWORDLIST.healing_touch.DRUID.random = {}

RPWORDLIST.regrowth.DRUID = {}
RPWORDLIST.regrowth.DRUID.emote = {}
RPWORDLIST.regrowth.DRUID.customemote = {}
RPWORDLIST.regrowth.DRUID.random = {}

RPWORDLIST.rebirth.DRUID = {}
RPWORDLIST.rebirth.DRUID.emote = {}
RPWORDLIST.rebirth.DRUID.customemote = {}
RPWORDLIST.rebirth.DRUID.random = {}


end
