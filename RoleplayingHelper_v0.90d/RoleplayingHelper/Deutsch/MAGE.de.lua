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
RPWORDLIST.entercombat.MAGE = {"Sp\195\188rt die Macht der Worte!", "Keiner kann es mit den arkanen M\195\164chten aufnehmen!", }
RPWORDLIST.entercombat.MAGE.emote = {}
RPWORDLIST.entercombat.MAGE.customemote = {}
RPWORDLIST.entercombat.MAGE.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.MAGE = {}
RPWORDLIST.leavecombat.MAGE.emote = {}
RPWORDLIST.leavecombat.MAGE.customemote = {}
RPWORDLIST.leavecombat.MAGE.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.MAGE = {}
RPWORDLIST.hurt.MAGE.emote = {}
RPWORDLIST.hurt.MAGE.customemote = {}
RPWORDLIST.hurt.MAGE.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.MAGE = {}
RPWORDLIST.absorb.MAGE.emote = {}
RPWORDLIST.absorb.MAGE.customemote = {}
RPWORDLIST.absorb.MAGE.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.MAGE = {}
RPWORDLIST.block.MAGE.emote = {}
RPWORDLIST.block.MAGE.customemote = {}
RPWORDLIST.block.MAGE.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.MAGE = {}
RPWORDLIST.dodge.MAGE.emote = {}
RPWORDLIST.dodge.MAGE.customemote = {}
RPWORDLIST.dodge.MAGE.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.MAGE = {}
RPWORDLIST.miss.MAGE.emote = {}
RPWORDLIST.miss.MAGE.customemote = {}
RPWORDLIST.miss.MAGE.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.MAGE = {}
RPWORDLIST.parry.MAGE.emote = {}
RPWORDLIST.parry.MAGE.customemote = {}
RPWORDLIST.parry.MAGE.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.MAGE = {}
RPWORDLIST.youcrit.MAGE.emote = {}
RPWORDLIST.youcrit.MAGE.customemote = {}
RPWORDLIST.youcrit.MAGE.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.MAGE = {"Magier kennen besonders schmerzhafte Zauber!.", "Das muss schmerzhaft gewesen sein!.", "Das Wort ist t\195\182dlicher als das Schwert!.", "Keiner wiedersteht dauerhaft derartigen Schaden!", "Na, tat das weh?", }
RPWORDLIST.youcritspell.MAGE.emote = {}
RPWORDLIST.youcritspell.MAGE.customemote = {}
RPWORDLIST.youcritspell.MAGE.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.MAGE = {}
RPWORDLIST.petattackstart.MAGE.emote = {}
RPWORDLIST.petattackstart.MAGE.customemote = {}
RPWORDLIST.petattackstart.MAGE.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.MAGE = {}
RPWORDLIST.petattackstop.MAGE.emote = {}
RPWORDLIST.petattackstop.MAGE.customemote = {}
RPWORDLIST.petattackstop.MAGE.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.MAGE = {}
RPWORDLIST.npctalksfriend.MAGE.emote = {}
RPWORDLIST.npctalksfriend.MAGE.customemote = {}
RPWORDLIST.npctalksfriend.MAGE.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.MAGE = {}
RPWORDLIST.npctalksenemy.MAGE.emote = {}
RPWORDLIST.npctalksenemy.MAGE.customemote = {}
RPWORDLIST.npctalksenemy.MAGE.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.MAGE = {"Die arkanen M\195\164chte haben mich vor dem Tod bewahrt!", }
RPWORDLIST.resurrect.MAGE.emote = {}
RPWORDLIST.resurrect.MAGE.customemote = {}
RPWORDLIST.resurrect.MAGE.random = {}


--//////////////////////////////////////////////////////////////////////////--
-- Mage Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Arcane
--=====================================================================--
RPWORDLIST.conjure_water.MAGE = {}
RPWORDLIST.conjure_water.MAGE.emote = {}
RPWORDLIST.conjure_water.MAGE.customemote = {}
RPWORDLIST.conjure_water.MAGE.random = {}

RPWORDLIST.conjure_food.MAGE = {}
RPWORDLIST.conjure_food.MAGE.emote = {}
RPWORDLIST.conjure_food.MAGE.customemote = {}
RPWORDLIST.conjure_food.MAGE.random = {}

RPWORDLIST.conjure_mana_agate.MAGE = {}
RPWORDLIST.conjure_mana_agate.MAGE.emote = {}
RPWORDLIST.conjure_mana_agate.MAGE.customemote = {}
RPWORDLIST.conjure_mana_agate.MAGE.random = {}

RPWORDLIST.conjure_mana_jade.MAGE = {}
RPWORDLIST.conjure_mana_jade.MAGE.emote = {}
RPWORDLIST.conjure_mana_jade.MAGE.customemote = {}
RPWORDLIST.conjure_mana_jade.MAGE.random = {}

RPWORDLIST.conjure_mana_citrine.MAGE = {}
RPWORDLIST.conjure_mana_citrine.MAGE.emote = {}
RPWORDLIST.conjure_mana_citrine.MAGE.customemote = {}
RPWORDLIST.conjure_mana_citrine.MAGE.random = {}

RPWORDLIST.conjure_mana_ruby.MAGE = {}
RPWORDLIST.conjure_mana_ruby.MAGE.emote = {}
RPWORDLIST.conjure_mana_ruby.MAGE.customemote = {}
RPWORDLIST.conjure_mana_ruby.MAGE.random = {}

-------------------------------------------------------------------------

RPWORDLIST.polymorph.MAGE = {}
RPWORDLIST.polymorph.MAGE.emote = {}
RPWORDLIST.polymorph.MAGE.customemote = {}
RPWORDLIST.polymorph.MAGE.random = {}

RPWORDLIST.arcane_explosion.MAGE = {}
RPWORDLIST.arcane_explosion.MAGE.emote = {}
RPWORDLIST.arcane_explosion.MAGE.customemote = {}
RPWORDLIST.arcane_explosion.MAGE.random = {}
      
-------------------------------------------------------------------------

RPWORDLIST.teleport_ironforge.MAGE = {}
RPWORDLIST.teleport_ironforge.MAGE.emote = {}
RPWORDLIST.teleport_ironforge.MAGE.customemote = {}
RPWORDLIST.teleport_ironforge.MAGE.random = {}

RPWORDLIST.teleport_stormwind.MAGE = {}
RPWORDLIST.teleport_stormwind.MAGE.emote = {}
RPWORDLIST.teleport_stormwind.MAGE.customemote = {}
RPWORDLIST.teleport_stormwind.MAGE.random = {}

RPWORDLIST.teleport_darnassus.MAGE = {}
RPWORDLIST.teleport_darnassus.MAGE.emote = {}
RPWORDLIST.teleport_darnassus.MAGE.customemote = {}
RPWORDLIST.teleport_darnassus.MAGE.random = {}

RPWORDLIST.teleport_orgrimmar.MAGE = {}
RPWORDLIST.teleport_orgrimmar.MAGE.emote = {}
RPWORDLIST.teleport_orgrimmar.MAGE.customemote = {}
RPWORDLIST.teleport_orgrimmar.MAGE.random = {}

RPWORDLIST.teleport_undercity.MAGE = {}
RPWORDLIST.teleport_undercity.MAGE.emote = {}
RPWORDLIST.teleport_undercity.MAGE.customemote = {}
RPWORDLIST.teleport_undercity.MAGE.random = {}

RPWORDLIST.teleport_thunder_bluff.MAGE = {}
RPWORDLIST.teleport_thunder_bluff.MAGE.emote = {}
RPWORDLIST.teleport_thunder_bluff.MAGE.customemote = {}
RPWORDLIST.teleport_thunder_bluff.MAGE.random = {}
      
-------------------------------------------------------------------------

RPWORDLIST.portal_ironforge.MAGE = {}
RPWORDLIST.portal_ironforge.MAGE.emote = {}
RPWORDLIST.portal_ironforge.MAGE.customemote = {}
RPWORDLIST.portal_ironforge.MAGE.random = {}

RPWORDLIST.portal_stormwind.MAGE = {}
RPWORDLIST.portal_stormwind.MAGE.emote = {}
RPWORDLIST.portal_stormwind.MAGE.customemote = {}
RPWORDLIST.portal_stormwind.MAGE.random = {}

RPWORDLIST.portal_darnassus.MAGE = {}
RPWORDLIST.portal_darnassus.MAGE.emote = {}
RPWORDLIST.portal_darnassus.MAGE.customemote = {}
RPWORDLIST.portal_darnassus.MAGE.random = {}

RPWORDLIST.portal_orgrimmar.MAGE = {}
RPWORDLIST.portal_orgrimmar.MAGE.emote = {}
RPWORDLIST.portal_orgrimmar.MAGE.customemote = {}
RPWORDLIST.portal_orgrimmar.MAGE.random = {}

RPWORDLIST.portal_undercity.MAGE = {}
RPWORDLIST.portal_undercity.MAGE.emote = {}
RPWORDLIST.portal_undercity.MAGE.customemote = {}
RPWORDLIST.portal_undercity.MAGE.random = {}

RPWORDLIST.portal_thunder_bluff.MAGE = {}
RPWORDLIST.portal_thunder_bluff.MAGE.emote = {}
RPWORDLIST.portal_thunder_bluff.MAGE.customemote = {}
RPWORDLIST.portal_thunder_bluff.MAGE.random = {}
      
      
--=====================================================================--
-- Frost
--=====================================================================--
RPWORDLIST.frostbolt.MAGE = {}
RPWORDLIST.frostbolt.MAGE.emote = {}
RPWORDLIST.frostbolt.MAGE.customemote = {}
RPWORDLIST.frostbolt.MAGE.random = {}


      
--=====================================================================--
-- Fire
--=====================================================================--
RPWORDLIST.fireball.MAGE = {}
RPWORDLIST.fireball.MAGE.emote = {}
RPWORDLIST.fireball.MAGE.customemote = {}
RPWORDLIST.fireball.MAGE.random = {}

RPWORDLIST.flamestrike.MAGE = {}
RPWORDLIST.flamestrike.MAGE.emote = {}
RPWORDLIST.flamestrike.MAGE.customemote = {}
RPWORDLIST.flamestrike.MAGE.random = {}

RPWORDLIST.pyroblast.MAGE = {}
RPWORDLIST.pyroblast.MAGE.emote = {}
RPWORDLIST.pyroblast.MAGE.customemote = {}
RPWORDLIST.pyroblast.MAGE.random = {}

RPWORDLIST.scorch.MAGE = {}
RPWORDLIST.scorch.MAGE.emote = {}
RPWORDLIST.scorch.MAGE.customemote = {}
RPWORDLIST.scorch.MAGE.random = {}

end