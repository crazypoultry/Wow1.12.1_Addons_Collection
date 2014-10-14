--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.WARLOCK = {
	"I shall fight fire... with fire",
	"Chaos boils in my mind",
	"Your screams will fill the air.",
	"I'll make sure you suffer.",
	"Your pain shall be legendary.",
	"You shall know my wrath.",
	"You offer yourself to me freely; the pact is sealed.",
	"You will be mine.",
}
RPWORDLIST.entercombat.WARLOCK.emote = {"FROWN","GRIN","GLARE","GROWL","WRATH",}
RPWORDLIST.entercombat.WARLOCK.customemote = {}
RPWORDLIST.entercombat.WARLOCK.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.WARLOCK = {}
RPWORDLIST.leavecombat.WARLOCK.emote = {}
RPWORDLIST.leavecombat.WARLOCK.customemote = {}
RPWORDLIST.leavecombat.WARLOCK.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.WARLOCK = {}
RPWORDLIST.hurt.WARLOCK.emote = {}
RPWORDLIST.hurt.WARLOCK.customemote = {}
RPWORDLIST.hurt.WARLOCK.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.WARLOCK = {}
RPWORDLIST.absorb.WARLOCK.emote = {}
RPWORDLIST.absorb.WARLOCK.customemote = {}
RPWORDLIST.absorb.WARLOCK.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.WARLOCK = {}
RPWORDLIST.block.WARLOCK.emote = {}
RPWORDLIST.block.WARLOCK.customemote = {}
RPWORDLIST.block.WARLOCK.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.WARLOCK = {}
RPWORDLIST.dodge.WARLOCK.emote = {}
RPWORDLIST.dodge.WARLOCK.customemote = {}
RPWORDLIST.dodge.WARLOCK.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.WARLOCK = {}
RPWORDLIST.miss.WARLOCK.emote = {}
RPWORDLIST.miss.WARLOCK.customemote = {}
RPWORDLIST.miss.WARLOCK.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.WARLOCK = {}
RPWORDLIST.parry.WARLOCK.emote = {}
RPWORDLIST.parry.WARLOCK.customemote = {}
RPWORDLIST.parry.WARLOCK.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.WARLOCK = {}
RPWORDLIST.youcrit.WARLOCK.emote = {}
RPWORDLIST.youcrit.WARLOCK.customemote = {}
RPWORDLIST.youcrit.WARLOCK.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.WARLOCK = {}
RPWORDLIST.youcritspell.WARLOCK.emote = {}
RPWORDLIST.youcritspell.WARLOCK.customemote = {}
RPWORDLIST.youcritspell.WARLOCK.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.WARLOCK = {
	"Show PTOP the meaning of pain, PNAME.",
	"Destroy PTOP, PNAME.",
	"Destroy PTOP for me, PNAME.",
	"PNAME!  I want that soul!",
	"PNAME!  Keep up!",
	"PNAME!  Shred the flesh!",
	"PNAME!  Destroy the husk!",
}
RPWORDLIST.petattackstart.WARLOCK.emote = {}
RPWORDLIST.petattackstart.WARLOCK.customemote = {}
RPWORDLIST.petattackstart.WARLOCK.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.WARLOCK = {
	"Try harder PNAME.",
	"Put more effort into it next time PNAME.",
	"Do you ever put real effort into anything PNAME?",
	"Do not attempt to stray from me PNAME.",
	"Well enough, you won't be punished this time PNAME.",
	"Keep it up and you'll feast on a soul this night PNAME.",
}
RPWORDLIST.petattackstop.WARLOCK.emote = {}
RPWORDLIST.petattackstop.WARLOCK.customemote = {}
RPWORDLIST.petattackstop.WARLOCK.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.WARLOCK = {
	"Noooo!",
	"Rotten Spawn of the Abyss!",
	"PNAME, you won't escape me so easily as that!",
	"PNAME! Get up you useless excuse for demonspawn!",
}
RPWORDLIST.petdies.WARLOCK.emote = {}
RPWORDLIST.petdies.WARLOCK.customemote = {}
RPWORDLIST.petdies.WARLOCK.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.WARLOCK = { "You spew LANG like urine, NPC." }
RPWORDLIST.npctalksfriend.WARLOCK.emote = {}
RPWORDLIST.npctalksfriend.WARLOCK.customemote = {}
RPWORDLIST.npctalksfriend.WARLOCK.random = {

	["phrase"] = "BLANK BLANK BLANK",

	[1] = {
		"Quiet NPC.",
		"Shut up NPC.",
		"Quit your babbling NPC.",
		"Don't break my peace NPC.",
		"Don't break my concentration NPC.",
		},

	[2] = {
		"Unless you hope to",
		"Unless you want to",
		"Unless it's your wish to",
		"Unless it's your desire to",
		"Or I'll let know how it feels to",
		"Or else you'll know how it feels to",
		},

	[3] = {
		"be sent into the Twisting Nether.",
		"have your soul drained from you.",
		"suddenly catch on fire.",
		"have a shadow bolt in your groin.",
		"have your face melt off.",
		"have your tongue burnt out.",
		},
		
	}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.WARLOCK = { "You spew LANG like urine, NPC." }
RPWORDLIST.npctalksenemy.WARLOCK.emote = {}
RPWORDLIST.npctalksenemy.WARLOCK.customemote = {}
RPWORDLIST.npctalksenemy.WARLOCK.random = {

	["phrase"] = "BLANK BLANK BLANK",

	[1] = {
		"Quiet NPC.",
		"Shut up NPC.",
		"Quit your babbling NPC.",
		"Don't break my peace NPC.",
		"Don't break my concentration NPC.",
		},

	[2] = {
		"Unless you hope to",
		"Unless you want to",
		"Unless it's your wish to",
		"Unless it's your desire to",
		"Or I'll let know how it feels to",
		"Or else you'll know how it feels to",
		},

	[3] = {
		"be sent into the Twisting Nether.",
		"have your soul drained from you.",
		"suddenly catch on fire.",
		"have a shadow bolt in your groin.",
		"have your face melt off.",
		"have your tongue burnt out.",
		},
		
	}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.WARLOCK = {}
RPWORDLIST.resurrect.WARLOCK.emote = {}
RPWORDLIST.resurrect.WARLOCK.customemote = {}
RPWORDLIST.resurrect.WARLOCK.random = {}




--//////////////////////////////////////////////////////////////////////////--
-- Warlock Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Affliction
--=====================================================================--
RPWORDLIST.curse_of_weakness.WARLOCK = {}
RPWORDLIST.curse_of_weakness.WARLOCK.emote = {}
RPWORDLIST.curse_of_weakness.WARLOCK.customemote = {}
RPWORDLIST.curse_of_weakness.WARLOCK.random = {}
                                                   
RPWORDLIST.curse_of_agony.WARLOCK = {"I shall inflict pain and agony upon you, TARGET!"}
RPWORDLIST.curse_of_agony.WARLOCK.emote = {}
RPWORDLIST.curse_of_agony.WARLOCK.customemote = {}
RPWORDLIST.curse_of_agony.WARLOCK.random = {} 
                                                   
RPWORDLIST.curse_of_recklessness.WARLOCK = {}
RPWORDLIST.curse_of_recklessness.WARLOCK.emote = {}
RPWORDLIST.curse_of_recklessness.WARLOCK.customemote = {}
RPWORDLIST.curse_of_recklessness.WARLOCK.random = {}                                                   
                                                   
RPWORDLIST.curse_of_tongues.WARLOCK = {}
RPWORDLIST.curse_of_tongues.WARLOCK.emote = {}
RPWORDLIST.curse_of_tongues.WARLOCK.customemote = {"makes TARGET speak in demonic.",}
RPWORDLIST.curse_of_tongues.WARLOCK.random = {}                                                                                                   
                                                   
RPWORDLIST.curse_of_exhaustion.WARLOCK = {}
RPWORDLIST.curse_of_exhaustion.WARLOCK.emote = {}
RPWORDLIST.curse_of_exhaustion.WARLOCK.customemote = {}
RPWORDLIST.curse_of_exhaustion.WARLOCK.random = {}                                                                                                 
                                                   
RPWORDLIST.curse_of_the_elements.WARLOCK = {}
RPWORDLIST.curse_of_the_elements.WARLOCK.emote = {}
RPWORDLIST.curse_of_the_elements.WARLOCK.customemote = {}
RPWORDLIST.curse_of_the_elements.WARLOCK.random = {}                                                                                             
                                                   
RPWORDLIST.curse_of_shadow.WARLOCK = {}
RPWORDLIST.curse_of_shadow.WARLOCK.emote = {}
RPWORDLIST.curse_of_shadow.WARLOCK.customemote = {}
RPWORDLIST.curse_of_shadow.WARLOCK.random = {}                                                                                          
                                                   
RPWORDLIST.curse_of_doom.WARLOCK = {}
RPWORDLIST.curse_of_doom.WARLOCK.emote = {}
RPWORDLIST.curse_of_doom.WARLOCK.customemote = {}
RPWORDLIST.curse_of_doom.WARLOCK.random = {} 

RPWORDLIST.amplify_curse.WARLOCK = {}
RPWORDLIST.amplify_curse.WARLOCK.emote = {}
RPWORDLIST.amplify_curse.WARLOCK.customemote = {}
RPWORDLIST.amplify_curse.WARLOCK.random = {}

------------------------------------------------------------------------- 
                                                                                
RPWORDLIST.drain_soul.WARLOCK = {
	"I'll swallow your soul.",
	"Your soul shall burn!",
	"You will know endless torment.",
	"Your soul is mine!",
	"Your soul will sustain my demons.",
	"My demons must feast.",
	"You are mine.",
}
RPWORDLIST.drain_soul.WARLOCK.customemote = {}
RPWORDLIST.drain_soul.WARLOCK.random = {}       
                                                  
RPWORDLIST.drain_life.WARLOCK = {}
RPWORDLIST.drain_life.WARLOCK.customemote = {}
RPWORDLIST.drain_life.WARLOCK.random = {}    
                                                  
RPWORDLIST.drain_mana.WARLOCK = {}
RPWORDLIST.drain_mana.WARLOCK.customemote = {}
RPWORDLIST.drain_mana.WARLOCK.random = {}  

------------------------------------------------------------------------- 
                                                                          
RPWORDLIST.corruption.WARLOCK = {}
RPWORDLIST.corruption.WARLOCK.emote = {}
RPWORDLIST.corruption.WARLOCK.customemote = {}
RPWORDLIST.corruption.WARLOCK.random = {} 
                                                  
RPWORDLIST.siphon_life.WARLOCK = {}
RPWORDLIST.siphon_life.WARLOCK.emote = {}
RPWORDLIST.siphon_life.WARLOCK.customemote = {}
RPWORDLIST.siphon_life.WARLOCK.random = {} 
                                                  
RPWORDLIST.death_coil.WARLOCK = {}
RPWORDLIST.death_coil.WARLOCK.emote = {}
RPWORDLIST.death_coil.WARLOCK.customemote = {}
RPWORDLIST.death_coil.WARLOCK.random = {}

------------------------------------------------------------------------- 
                                                                                                                            
RPWORDLIST.life_tap.WARLOCK = {}
RPWORDLIST.life_tap.WARLOCK.emote = {}
RPWORDLIST.life_tap.WARLOCK.customemote = {}
RPWORDLIST.life_tap.WARLOCK.random = {}   
                                                  
RPWORDLIST.dark_pact.WARLOCK = {}
RPWORDLIST.dark_pact.WARLOCK.emote = {}
RPWORDLIST.dark_pact.WARLOCK.customemote = {}
RPWORDLIST.dark_pact.WARLOCK.random = {}     

------------------------------------------------------------------------- 
                                                                                                                   
RPWORDLIST.fear.WARLOCK = {
    "Prepare to know the true meaning of fear.",
    "Don't go away mad, just go away.",
}
RPWORDLIST.fear.WARLOCK.emote = {}
RPWORDLIST.fear.WARLOCK.customemote = {}
RPWORDLIST.fear.WARLOCK.random = {}          

RPWORDLIST.howl_of_terror.WARLOCK = {}
RPWORDLIST.howl_of_terror.WARLOCK.emote = {}
RPWORDLIST.howl_of_terror.WARLOCK.customemote = {}
RPWORDLIST.howl_of_terror.WARLOCK.random = {}

--=====================================================================--
-- Demonology
--=====================================================================--                       
RPWORDLIST.demon_skin.WARLOCK = {}
RPWORDLIST.demon_skin.WARLOCK.emote = {}
RPWORDLIST.demon_skin.WARLOCK.customemote = {}
RPWORDLIST.demon_skin.WARLOCK.random = {} 
                         
RPWORDLIST.demon_armor.WARLOCK = {}
RPWORDLIST.demon_armor.WARLOCK.emote = {}
RPWORDLIST.demon_armor.WARLOCK.customemote = {}
RPWORDLIST.demon_armor.WARLOCK.random = {}             
                         
RPWORDLIST.health_funnel.WARLOCK = {}
RPWORDLIST.health_funnel.WARLOCK.customemote = {}
RPWORDLIST.health_funnel.WARLOCK.random = {}           
                         
RPWORDLIST.unending_breath.WARLOCK = {}
RPWORDLIST.unending_breath.WARLOCK.emote = {}
RPWORDLIST.unending_breath.WARLOCK.customemote = {}
RPWORDLIST.unending_breath.WARLOCK.random = {}
                                               
RPWORDLIST.fel_domination.WARLOCK = {}
RPWORDLIST.fel_domination.WARLOCK.emote = {}
RPWORDLIST.fel_domination.WARLOCK.customemote = {}
RPWORDLIST.fel_domination.WARLOCK.random = {}
                                                             
RPWORDLIST.sense_demons.WARLOCK = {}
RPWORDLIST.sense_demons.WARLOCK.emote = {}
RPWORDLIST.sense_demons.WARLOCK.customemote = {}
RPWORDLIST.sense_demons.WARLOCK.random = {}
                                                                                
RPWORDLIST.detect_lesser_invisibility.WARLOCK = {}
RPWORDLIST.detect_lesser_invisibility.WARLOCK.emote = {}
RPWORDLIST.detect_lesser_invisibility.WARLOCK.customemote = {}
RPWORDLIST.detect_lesser_invisibility.WARLOCK.random = {}   
                                                                                
RPWORDLIST.detect_invisibility.WARLOCK = {}
RPWORDLIST.detect_invisibility.WARLOCK.emote = {}
RPWORDLIST.detect_invisibility.WARLOCK.customemote = {}
RPWORDLIST.detect_invisibility.WARLOCK.random = {}   
                                                                                
RPWORDLIST.detect_greater_invisibility.WARLOCK = {}
RPWORDLIST.detect_greater_invisibility.WARLOCK.emote = {}
RPWORDLIST.detect_greater_invisibility.WARLOCK.customemote = {}
RPWORDLIST.detect_greater_invisibility.WARLOCK.random = {}  

RPWORDLIST.banish.WARLOCK = {}
RPWORDLIST.banish.WARLOCK.emote = {}
RPWORDLIST.banish.WARLOCK.customemote = {}
RPWORDLIST.banish.WARLOCK.random = {}

RPWORDLIST.eye_of_kilrogg.WARLOCK = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.emote = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.customemote = {}
RPWORDLIST.eye_of_kilrogg.WARLOCK.random = {}                          

RPWORDLIST.demonic_sacrifice.WARLOCK = {}
RPWORDLIST.demonic_sacrifice.WARLOCK.emote = {}
RPWORDLIST.demonic_sacrifice.WARLOCK.customemote = {}
RPWORDLIST.demonic_sacrifice.WARLOCK.random = {}                       

RPWORDLIST.ritual_of_summoning.WARLOCK = {"Summoning TARGET.",}
RPWORDLIST.ritual_of_summoning.WARLOCK.emote = {}
RPWORDLIST.ritual_of_summoning.WARLOCK.customemote = {"starts chanting in Demonic.  You hear TARGET's name.",}
RPWORDLIST.ritual_of_summoning.WARLOCK.random = {}

RPWORDLIST.enslave_demon.WARLOCK = {}
RPWORDLIST.enslave_demon.WARLOCK.emote = {"GRIN",}
RPWORDLIST.enslave_demon.WARLOCK.customemote = {}
RPWORDLIST.enslave_demon.WARLOCK.random = {}         

RPWORDLIST.shadow_ward.WARLOCK = {}
RPWORDLIST.shadow_ward.WARLOCK.emote = {}
RPWORDLIST.shadow_ward.WARLOCK.customemote = {}
RPWORDLIST.shadow_ward.WARLOCK.random = {}

RPWORDLIST.soul_link.WARLOCK = {}
RPWORDLIST.soul_link.WARLOCK.emote = {}
RPWORDLIST.soul_link.WARLOCK.customemote = {}
RPWORDLIST.soul_link.WARLOCK.random = {}

-------------------------------------------------------------------------

RPWORDLIST.create_healthstone.WARLOCK = {}
RPWORDLIST.create_healthstone.WARLOCK.emote = {}
RPWORDLIST.create_healthstone.WARLOCK.customemote = {}
RPWORDLIST.create_healthstone.WARLOCK.random = {}

RPWORDLIST.create_soulstone.WARLOCK = {}
RPWORDLIST.create_soulstone.WARLOCK.emote = {}
RPWORDLIST.create_soulstone.WARLOCK.customemote = {}
RPWORDLIST.create_soulstone.WARLOCK.random = {}

RPWORDLIST.create_spellstone.WARLOCK = {}
RPWORDLIST.create_spellstone.WARLOCK.emote = {}
RPWORDLIST.create_spellstone.WARLOCK.customemote = {}
RPWORDLIST.create_spellstone.WARLOCK.random = {}

RPWORDLIST.create_firestone.WARLOCK = {}
RPWORDLIST.create_firestone.WARLOCK.emote = {}
RPWORDLIST.create_firestone.WARLOCK.customemote = {}
RPWORDLIST.create_firestone.WARLOCK.random = {}

-------------------------------------------------------------------------

RPWORDLIST.summon_imp.WARLOCK = {
	"Did you think I would let you rest imp?",
	"Time to get back to work, imp.",
	"Your labor is not even close to finished, imp.",
	"You cannot escape me that easily imp.",
	"Weakness will not be tolerated imp.",
	"You will never know rest imp, your labor will never be done.",
}
RPWORDLIST.summon_imp.WARLOCK.emote = {}
RPWORDLIST.summon_imp.WARLOCK.customemote = {}
RPWORDLIST.summon_imp.WARLOCK.random = {}

RPWORDLIST.summon_voidwalker.WARLOCK = {
	"Did you think I would let you rest, demon?",
	"Demon! Get back to work!",
	"Your labor is not even close to finished demon!",
	"You cannot escape me that easily demon!",
	"Weakness will not be tolerated demon!",
	"You will never know rest demon, your labor will never be done!",
}
RPWORDLIST.summon_voidwalker.WARLOCK.emote = {}
RPWORDLIST.summon_voidwalker.WARLOCK.customemote = {}
RPWORDLIST.summon_voidwalker.WARLOCK.random = {}

RPWORDLIST.summon_succubus.WARLOCK = {
	"Did you think I would let you rest minx?",
	"Succubus! Get back to work!",
	"Your labor is not even close to finished temptress!",
	"You cannot escape me that easily temptress!",
	"Weakness will not be tolerated Succubus!",
	"You will never know rest temptress, your labor will never be done!",
}
RPWORDLIST.summon_succubus.WARLOCK.emote = {}
RPWORDLIST.summon_succubus.WARLOCK.customemote = {}
RPWORDLIST.summon_succubus.WARLOCK.random = {}

RPWORDLIST.summon_felhunter.WARLOCK = {}
RPWORDLIST.summon_felhunter.WARLOCK.emote = {}
RPWORDLIST.summon_felhunter.WARLOCK.customemote = {}
RPWORDLIST.summon_felhunter.WARLOCK.random = {}

RPWORDLIST.summon_felsteed.WARLOCK = {}
RPWORDLIST.summon_felsteed.WARLOCK.emote = {}
RPWORDLIST.summon_felsteed.WARLOCK.customemote = {}
RPWORDLIST.summon_felsteed.WARLOCK.random = {}   

RPWORDLIST.summon_dreadsteed.WARLOCK = {}
RPWORDLIST.summon_dreadsteed.WARLOCK.emote = {}
RPWORDLIST.summon_dreadsteed.WARLOCK.customemote = {}
RPWORDLIST.summon_dreadsteed.WARLOCK.random = {}    

RPWORDLIST.inferno.WARLOCK = {}
RPWORDLIST.inferno.WARLOCK.emote = {}
RPWORDLIST.inferno.WARLOCK.customemote = {}
RPWORDLIST.inferno.WARLOCK.random = {}     

RPWORDLIST.ritual_of_doom.WARLOCK = {}
RPWORDLIST.ritual_of_doom.WARLOCK.emote = {}
RPWORDLIST.ritual_of_doom.WARLOCK.customemote = {}
RPWORDLIST.ritual_of_doom.WARLOCK.random = {}

--=====================================================================--
-- Destruction
--=====================================================================--
RPWORDLIST.immolate.WARLOCK = {"Mind if I turn up the heat a bit, TARGET?", "Time to get a little hot under the collar, TARGET."}
RPWORDLIST.immolate.WARLOCK.emote = {}
RPWORDLIST.immolate.WARLOCK.customemote = {}
RPWORDLIST.immolate.WARLOCK.random = {}

RPWORDLIST.searing_pain.WARLOCK = {}
RPWORDLIST.searing_pain.WARLOCK.emote = {}
RPWORDLIST.searing_pain.WARLOCK.customemote = {}
RPWORDLIST.searing_pain.WARLOCK.random = {}

RPWORDLIST.shadow_bolt.WARLOCK = {}
RPWORDLIST.shadow_bolt.WARLOCK.emote = {}
RPWORDLIST.shadow_bolt.WARLOCK.customemote = {}
RPWORDLIST.shadow_bolt.WARLOCK.random = {}
                                          
RPWORDLIST.rain_of_fire.WARLOCK = {"Rain fire!", "Fire from the sky!", "Come on baby, light my fire!", }
RPWORDLIST.rain_of_fire.WARLOCK.customemote = {}
RPWORDLIST.rain_of_fire.WARLOCK.random = {}
                                          
RPWORDLIST.shadowburn.WARLOCK = {}
RPWORDLIST.shadowburn.WARLOCK.emote = {}
RPWORDLIST.shadowburn.WARLOCK.customemote = {}
RPWORDLIST.shadowburn.WARLOCK.random = {}
                                                     
RPWORDLIST.hellfire.WARLOCK = {"Some like it hot, so let's turn up the heat til we fry."}
RPWORDLIST.hellfire.WARLOCK.customemote = {}
RPWORDLIST.hellfire.WARLOCK.random = {}     
                                          
RPWORDLIST.conflagrate.WARLOCK = {}
RPWORDLIST.conflagrate.WARLOCK.emote = {}
RPWORDLIST.conflagrate.WARLOCK.customemote = {}
RPWORDLIST.conflagrate.WARLOCK.random = {}

RPWORDLIST.soul_fire.WARLOCK = {}
RPWORDLIST.soul_fire.WARLOCK.emote = {}
RPWORDLIST.soul_fire.WARLOCK.customemote = {}
RPWORDLIST.soul_fire.WARLOCK.random = {}
