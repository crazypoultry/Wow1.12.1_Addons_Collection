--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.MAGE = {
	"Let's get this over quick, time is mana.",
	"I'm a magic man. I got magic hands.",
	"I do not think you realise the gravity of your situation.",
	"Buckle up... you're going for a ride.",
}
RPWORDLIST.entercombat.MAGE.emote = {"CHARGE",}
RPWORDLIST.entercombat.MAGE.customemote = {}
RPWORDLIST.entercombat.MAGE.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.MAGE = {
 	"Some lessons come hard.",
	"Careful. You don't want to risk learning from this.",
}
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
RPWORDLIST.dodge.MAGE.emote = {
--	"I don't remember casting slow on you...",
}
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
RPWORDLIST.youcritspell.MAGE = {}
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
RPWORDLIST.resurrect.MAGE = {}
RPWORDLIST.resurrect.MAGE.emote = {}
RPWORDLIST.resurrect.MAGE.customemote = {}
RPWORDLIST.resurrect.MAGE.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Mage Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Arcane
--=====================================================================--       
RPWORDLIST.arcane_intellect.MAGE = {}
RPWORDLIST.arcane_intellect.MAGE.emote = {}
RPWORDLIST.arcane_intellect.MAGE.customemote = {}
RPWORDLIST.arcane_intellect.MAGE.random = {}  
        
RPWORDLIST.arcane_missiles.MAGE = {}
RPWORDLIST.arcane_missiles.MAGE.customemote = {}
RPWORDLIST.arcane_missiles.MAGE.random = {}

RPWORDLIST.polymorph.MAGE = {}
RPWORDLIST.polymorph.MAGE.emote = {}
RPWORDLIST.polymorph.MAGE.customemote = {}
RPWORDLIST.polymorph.MAGE.random = {}  

RPWORDLIST.dampen_magic.MAGE = {}
RPWORDLIST.dampen_magic.MAGE.emote = {}
RPWORDLIST.dampen_magic.MAGE.customemote = {}
RPWORDLIST.dampen_magic.MAGE.random = {}    

RPWORDLIST.slow_fall.MAGE = {}
RPWORDLIST.slow_fall.MAGE.emote = {}
RPWORDLIST.slow_fall.MAGE.customemote = {}
RPWORDLIST.slow_fall.MAGE.random = {}

RPWORDLIST.arcane_explosion.MAGE = {}
RPWORDLIST.arcane_explosion.MAGE.emote = {}
RPWORDLIST.arcane_explosion.MAGE.customemote = {}
RPWORDLIST.arcane_explosion.MAGE.random = {}  

RPWORDLIST.detect_magic.MAGE = {}
RPWORDLIST.detect_magic.MAGE.emote = {}
RPWORDLIST.detect_magic.MAGE.customemote = {}
RPWORDLIST.detect_magic.MAGE.random = {}    

RPWORDLIST.amplify_magic.MAGE = {}
RPWORDLIST.amplify_magic.MAGE.emote = {}
RPWORDLIST.amplify_magic.MAGE.customemote = {}
RPWORDLIST.amplify_magic.MAGE.random = {}     

RPWORDLIST.remove_lesser_curse.MAGE = {}
RPWORDLIST.remove_lesser_curse.MAGE.emote = {}
RPWORDLIST.remove_lesser_curse.MAGE.customemote = {}
RPWORDLIST.remove_lesser_curse.MAGE.random = {}     

RPWORDLIST.blink.MAGE = {}
RPWORDLIST.blink.MAGE.emote = {}
RPWORDLIST.blink.MAGE.customemote = {}
RPWORDLIST.blink.MAGE.random = {}        

RPWORDLIST.evocation.MAGE = {}
RPWORDLIST.evocation.MAGE.customemote = {}
RPWORDLIST.evocation.MAGE.random = {}        

RPWORDLIST.mana_shield.MAGE = {}
RPWORDLIST.mana_shield.MAGE.emote = {}
RPWORDLIST.mana_shield.MAGE.customemote = {}
RPWORDLIST.mana_shield.MAGE.random = {}        

RPWORDLIST.counterspell.MAGE = {}
RPWORDLIST.counterspell.MAGE.emote = {}
RPWORDLIST.counterspell.MAGE.customemote = {}
RPWORDLIST.counterspell.MAGE.random = {}      

RPWORDLIST.presence_of_mind.MAGE = {}
RPWORDLIST.presence_of_mind.MAGE.emote = {}
RPWORDLIST.presence_of_mind.MAGE.customemote = {}
RPWORDLIST.presence_of_mind.MAGE.random = {}     

RPWORDLIST.mage_armor.MAGE = {}
RPWORDLIST.mage_armor.MAGE.emote = {}
RPWORDLIST.mage_armor.MAGE.customemote = {}
RPWORDLIST.mage_armor.MAGE.random = {}      

RPWORDLIST.arcane_power.MAGE = {}
RPWORDLIST.arcane_power.MAGE.emote = {}
RPWORDLIST.arcane_power.MAGE.customemote = {}
RPWORDLIST.arcane_power.MAGE.random = {}    

RPWORDLIST.arcane_brilliance.MAGE = {}
RPWORDLIST.arcane_brilliance.MAGE.emote = {}
RPWORDLIST.arcane_brilliance.MAGE.customemote = {}
RPWORDLIST.arcane_brilliance.MAGE.random = {}   
-------------------------------------------------------------------------    
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
                                      
RPWORDLIST.frost_armor.MAGE = {}
RPWORDLIST.frost_armor.MAGE.emote = {}
RPWORDLIST.frost_armor.MAGE.customemote = {}
RPWORDLIST.frost_armor.MAGE.random = {}    
                                      
RPWORDLIST.frost_nova.MAGE = {}
RPWORDLIST.frost_nova.MAGE.emote = {}
RPWORDLIST.frost_nova.MAGE.customemote = {}
RPWORDLIST.frost_nova.MAGE.random = {}   
                                      
RPWORDLIST.blizzard.MAGE = {}
RPWORDLIST.blizzard.MAGE.customemote = {}
RPWORDLIST.blizzard.MAGE.random = {}  
                                      
RPWORDLIST.cold_snap.MAGE = {}
RPWORDLIST.cold_snap.MAGE.emote = {}
RPWORDLIST.cold_snap.MAGE.customemote = {}
RPWORDLIST.cold_snap.MAGE.random = {}    
                                      
RPWORDLIST.frost_ward.MAGE = {}
RPWORDLIST.frost_ward.MAGE.emote = {}
RPWORDLIST.frost_ward.MAGE.customemote = {}
RPWORDLIST.frost_ward.MAGE.random = {}    
                                      
RPWORDLIST.cone_of_cold.MAGE = {}
RPWORDLIST.cone_of_cold.MAGE.emote = {}
RPWORDLIST.cone_of_cold.MAGE.customemote = {}
RPWORDLIST.cone_of_cold.MAGE.random = {}   
                                      
RPWORDLIST.ice_armor.MAGE = {}
RPWORDLIST.ice_armor.MAGE.emote = {}
RPWORDLIST.ice_armor.MAGE.customemote = {}
RPWORDLIST.ice_armor.MAGE.random = {}   
                                      
RPWORDLIST.ice_block.MAGE = {}
RPWORDLIST.ice_block.MAGE.emote = {}
RPWORDLIST.ice_block.MAGE.customemote = {}
RPWORDLIST.ice_block.MAGE.random = {}       
                                      
RPWORDLIST.ice_barrier.MAGE = {}
RPWORDLIST.ice_barrier.MAGE.emote = {}
RPWORDLIST.ice_barrier.MAGE.customemote = {}
RPWORDLIST.ice_barrier.MAGE.random = {} 
--=====================================================================--
-- Fire
--=====================================================================--   
RPWORDLIST.fire_blast.MAGE = {}
RPWORDLIST.fire_blast.MAGE.emote = {}
RPWORDLIST.fire_blast.MAGE.customemote = {}
RPWORDLIST.fire_blast.MAGE.random = {}

RPWORDLIST.fireball.MAGE = {}
RPWORDLIST.fireball.MAGE.emote = {}
RPWORDLIST.fireball.MAGE.customemote = {}
RPWORDLIST.fireball.MAGE.random = {}

RPWORDLIST.flamestrike.MAGE = {}
RPWORDLIST.flamestrike.MAGE.emote = {}
RPWORDLIST.flamestrike.MAGE.customemote = {}
RPWORDLIST.flamestrike.MAGE.random = {} 

RPWORDLIST.fire_ward.MAGE = {}
RPWORDLIST.fire_ward.MAGE.emote = {}
RPWORDLIST.fire_ward.MAGE.customemote = {}
RPWORDLIST.fire_ward.MAGE.random = {}

RPWORDLIST.pyroblast.MAGE = {}
RPWORDLIST.pyroblast.MAGE.emote = {}
RPWORDLIST.pyroblast.MAGE.customemote = {}
RPWORDLIST.pyroblast.MAGE.random = {}

RPWORDLIST.scorch.MAGE = {}
RPWORDLIST.scorch.MAGE.emote = {}
RPWORDLIST.scorch.MAGE.customemote = {}
RPWORDLIST.scorch.MAGE.random = {}  

RPWORDLIST.blast_wave.MAGE = {}
RPWORDLIST.blast_wave.MAGE.emote = {}
RPWORDLIST.blast_wave.MAGE.customemote = {}
RPWORDLIST.blast_wave.MAGE.random = {}

RPWORDLIST.combustion.MAGE = {}
RPWORDLIST.combustion.MAGE.emote = {}
RPWORDLIST.combustion.MAGE.customemote = {}
RPWORDLIST.combustion.MAGE.random = {}