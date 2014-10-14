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
RPWORDLIST.entercombat.SHAMAN = {"Sturm, Erde und Feuer h\195\182rt meinen Ruf!", "Elemente steht mir bei!", "M\195\182gen mir die Elemente beistehen!", }
RPWORDLIST.entercombat.SHAMAN.emote = {}
RPWORDLIST.entercombat.SHAMAN.customemote = {}
RPWORDLIST.entercombat.SHAMAN.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.SHAMAN = {"Ich gehe Ihr k\195\182nnt Euch solange mit meinen Totmems besch\195\164ftigen", }
RPWORDLIST.leavecombat.SHAMAN.emote = {}
RPWORDLIST.leavecombat.SHAMAN.customemote = {}
RPWORDLIST.leavecombat.SHAMAN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.SHAMAN = {"Elemente steht mir bei!", }
RPWORDLIST.hurt.SHAMAN.emote = {}
RPWORDLIST.hurt.SHAMAN.customemote = {}
RPWORDLIST.hurt.SHAMAN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.SHAMAN = {"Meine Totems sind m\195\164chtiger als Ihr!", }
RPWORDLIST.absorb.SHAMAN.emote = {}
RPWORDLIST.absorb.SHAMAN.customemote = {}
RPWORDLIST.absorb.SHAMAN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.SHAMAN = {"Die Elemente sch\195\188tzen mich!", }
RPWORDLIST.block.SHAMAN.emote = {}
RPWORDLIST.block.SHAMAN.customemote = {}
RPWORDLIST.block.SHAMAN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.SHAMAN = {}
RPWORDLIST.dodge.SHAMAN.emote = {}
RPWORDLIST.dodge.SHAMAN.customemote = {}
RPWORDLIST.dodge.SHAMAN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.SHAMAN = {}
RPWORDLIST.miss.SHAMAN.emote = {}
RPWORDLIST.miss.SHAMAN.customemote = {}
RPWORDLIST.miss.SHAMAN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.SHAMAN = {}
RPWORDLIST.parry.SHAMAN.emote = {}
RPWORDLIST.parry.SHAMAN.customemote = {}
RPWORDLIST.parry.SHAMAN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.SHAMAN = {}
RPWORDLIST.youcrit.SHAMAN.emote = {}
RPWORDLIST.youcrit.SHAMAN.customemote = {}
RPWORDLIST.youcrit.SHAMAN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.SHAMAN = {"Die Kraft der Elemente wird euch vernichten!", "Die Elemente werden Euch vernichten!", }
RPWORDLIST.youcritspell.SHAMAN.emote = {}
RPWORDLIST.youcritspell.SHAMAN.customemote = {}
RPWORDLIST.youcritspell.SHAMAN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.SHAMAN = {}
RPWORDLIST.youheal.SHAMAN.emote = {}
RPWORDLIST.youheal.SHAMAN.customemote = {}
RPWORDLIST.youheal.SHAMAN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.SHAMAN = {}
RPWORDLIST.youcritheal.SHAMAN.emote = {}
RPWORDLIST.youcritheal.SHAMAN.customemote = {}
RPWORDLIST.youcritheal.SHAMAN.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.SHAMAN = {}
RPWORDLIST.npctalksfriend.SHAMAN.emote = {}
RPWORDLIST.npctalksfriend.SHAMAN.customemote = {}
RPWORDLIST.npctalksfriend.SHAMAN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.SHAMAN = {}
RPWORDLIST.npctalksenemy.SHAMAN.emote = {}
RPWORDLIST.npctalksenemy.SHAMAN.customemote = {}
RPWORDLIST.npctalksenemy.SHAMAN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.SHAMAN = {"Die Elemente sind mit mir!", "Die Kraft der Elemente str\195\182mt wieder in mir!",  "Duch die Kraft der Elemente kehre ich zur\195\188ck!", }
RPWORDLIST.resurrect.SHAMAN.emote = {}
RPWORDLIST.resurrect.SHAMAN.customemote = {}
RPWORDLIST.resurrect.SHAMAN.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Shaman Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Elemental
--=====================================================================--
RPWORDLIST.lightning_bolt.SHAMAN = {}
RPWORDLIST.lightning_bolt.SHAMAN.emote = {}
RPWORDLIST.lightning_bolt.SHAMAN.customemote = {}
RPWORDLIST.lightning_bolt.SHAMAN.random = {}

RPWORDLIST.chain_lightning.SHAMAN = {}
RPWORDLIST.chain_lightning.SHAMAN.emote = {}
RPWORDLIST.chain_lightning.SHAMAN.customemote = {}
RPWORDLIST.chain_lightning.SHAMAN.random = {}

--=====================================================================--
-- Enhancement
--=====================================================================--
RPWORDLIST.ghost_wolf.SHAMAN = {}
RPWORDLIST.ghost_wolf.SHAMAN.emote = {}
RPWORDLIST.ghost_wolf.SHAMAN.customemote = {}
RPWORDLIST.ghost_wolf.SHAMAN.random = {}

RPWORDLIST.far_sight.SHAMAN = {}
RPWORDLIST.far_sight.SHAMAN.emote = {}
RPWORDLIST.far_sight.SHAMAN.customemote = {}
RPWORDLIST.far_sight.SHAMAN.random = {}

RPWORDLIST.astral_recall.SHAMAN = {}
RPWORDLIST.astral_recall.SHAMAN.emote = {}
RPWORDLIST.astral_recall.SHAMAN.customemote = {}
RPWORDLIST.astral_recall.SHAMAN.random = {}

--=====================================================================--
-- Restoration
--=====================================================================--
RPWORDLIST.healing_wave.SHAMAN = {}
RPWORDLIST.healing_wave.SHAMAN.emote = {}
RPWORDLIST.healing_wave.SHAMAN.customemote = {}
RPWORDLIST.healing_wave.SHAMAN.random = {}

RPWORDLIST.lesser_healing_wave.SHAMAN = {}
RPWORDLIST.lesser_healing_wave.SHAMAN.emote = {}
RPWORDLIST.lesser_healing_wave.SHAMAN.customemote = {}
RPWORDLIST.lesser_healing_wave.SHAMAN.random = {}

RPWORDLIST.ancestral_spirit.SHAMAN = {}
RPWORDLIST.ancestral_spirit.SHAMAN.emote = {}
RPWORDLIST.ancestral_spirit.SHAMAN.customemote = {}
RPWORDLIST.ancestral_spirit.SHAMAN.random = {}

RPWORDLIST.chain_heal.SHAMAN = {}
RPWORDLIST.chain_heal.SHAMAN.emote = {}
RPWORDLIST.chain_heal.SHAMAN.customemote = {}
RPWORDLIST.chain_heal.SHAMAN.random = {}

end