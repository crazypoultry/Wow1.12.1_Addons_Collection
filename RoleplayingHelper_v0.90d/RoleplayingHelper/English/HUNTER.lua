--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.HUNTER = {
	"The beast with me is nothing compared to the beast within...",
}
RPWORDLIST.entercombat.HUNTER.emote = {"CHARGE","ROAR",}
RPWORDLIST.entercombat.HUNTER.customemote = {}
RPWORDLIST.entercombat.HUNTER.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.HUNTER = {}
RPWORDLIST.leavecombat.HUNTER.emote = {}
RPWORDLIST.leavecombat.HUNTER.customemote = {}
RPWORDLIST.leavecombat.HUNTER.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.HUNTER = {}
RPWORDLIST.hurt.HUNTER.emote = {}
RPWORDLIST.hurt.HUNTER.customemote = {}
RPWORDLIST.hurt.HUNTER.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.HUNTER = {}
RPWORDLIST.absorb.HUNTER.emote = {}
RPWORDLIST.absorb.HUNTER.customemote = {}
RPWORDLIST.absorb.HUNTER.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.HUNTER = {}
RPWORDLIST.block.HUNTER.emote = {}
RPWORDLIST.block.HUNTER.customemote = {}
RPWORDLIST.block.HUNTER.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.HUNTER = {}
RPWORDLIST.dodge.HUNTER.emote = {}
RPWORDLIST.dodge.HUNTER.customemote = {}
RPWORDLIST.dodge.HUNTER.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.HUNTER = {}
RPWORDLIST.miss.HUNTER.emote = {}
RPWORDLIST.miss.HUNTER.customemote = {}
RPWORDLIST.miss.HUNTER.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.HUNTER = {}
RPWORDLIST.parry.HUNTER.emote = {}
RPWORDLIST.parry.HUNTER.customemote = {}
RPWORDLIST.parry.HUNTER.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.HUNTER = {
	"I will feed your corpse to the beasts of the wild.",
}
RPWORDLIST.youcrit.HUNTER.emote = {}
RPWORDLIST.youcrit.HUNTER.customemote = {}
RPWORDLIST.youcrit.HUNTER.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.HUNTER = {}
RPWORDLIST.youcritspell.HUNTER.emote = {}
RPWORDLIST.youcritspell.HUNTER.customemote = {}
RPWORDLIST.youcritspell.HUNTER.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.HUNTER = {}
RPWORDLIST.petattackstart.HUNTER.emote = {}
RPWORDLIST.petattackstart.HUNTER.customemote = {}
RPWORDLIST.petattackstart.HUNTER.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.HUNTER = {
	"What's that smell?  Bad PNAME, bad!",
}
RPWORDLIST.petattackstop.HUNTER.emote = {}
RPWORDLIST.petattackstop.HUNTER.customemote = {}
RPWORDLIST.petattackstop.HUNTER.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.HUNTER = {
	"PNAME! Play Dead!",
	"I'll be right there PNAME! Hold on!",
	"PNAME! Play Dead! Oh... you're not playing are you?",
}
RPWORDLIST.petdies.HUNTER.emote = {}
RPWORDLIST.petdies.HUNTER.customemote = {}
RPWORDLIST.petdies.HUNTER.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.HUNTER = {}
RPWORDLIST.npctalksfriend.HUNTER.emote = {}
RPWORDLIST.npctalksfriend.HUNTER.customemote = {}
RPWORDLIST.npctalksfriend.HUNTER.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.HUNTER = {}
RPWORDLIST.npctalksenemy.HUNTER.emote = {}
RPWORDLIST.npctalksenemy.HUNTER.customemote = {}
RPWORDLIST.npctalksenemy.HUNTER.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.HUNTER = {}
RPWORDLIST.resurrect.HUNTER.emote = {}
RPWORDLIST.resurrect.HUNTER.customemote = {}
RPWORDLIST.resurrect.HUNTER.random = {}


--//////////////////////////////////////////////////////////////////////////--
-- Hunter Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Beast Mastery
--=====================================================================-- 
RPWORDLIST.aspect_of_the_monkey.HUNTER = {}
RPWORDLIST.aspect_of_the_monkey.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_monkey.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_monkey.HUNTER.random = {}
                                                    
RPWORDLIST.aspect_of_the_hawk.HUNTER = {}
RPWORDLIST.aspect_of_the_hawk.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_hawk.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_hawk.HUNTER.random = {}    
                                                    
RPWORDLIST.aspect_of_the_cheetah.HUNTER = {}
RPWORDLIST.aspect_of_the_cheetah.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_cheetah.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_cheetah.HUNTER.random = {}    
                                                    
RPWORDLIST.aspect_of_the_beast.HUNTER = {}
RPWORDLIST.aspect_of_the_beast.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_beast.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_beast.HUNTER.random = {}   
                                                    
RPWORDLIST.aspect_of_the_pack.HUNTER = { "Faster! Run faster!" }
RPWORDLIST.aspect_of_the_pack.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_pack.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_pack.HUNTER.random = {}  
                                                    
RPWORDLIST.aspect_of_the_wild.HUNTER = {}
RPWORDLIST.aspect_of_the_wild.HUNTER.emote = {}
RPWORDLIST.aspect_of_the_wild.HUNTER.customemote = {}
RPWORDLIST.aspect_of_the_wild.HUNTER.random = {}          
                                                    
RPWORDLIST.mend_pet.HUNTER = {}
RPWORDLIST.mend_pet.HUNTER.emote = {}
RPWORDLIST.mend_pet.HUNTER.customemote = {}
RPWORDLIST.mend_pet.HUNTER.random = {}
                                         
RPWORDLIST.eagle_eye.HUNTER = {}
RPWORDLIST.eagle_eye.HUNTER.emote = {}
RPWORDLIST.eagle_eye.HUNTER.customemote = {}
RPWORDLIST.eagle_eye.HUNTER.random = {}
                         
RPWORDLIST.eyes_of_the_beast.HUNTER = {}
RPWORDLIST.eyes_of_the_beast.HUNTER.emote = {}
RPWORDLIST.eyes_of_the_beast.HUNTER.customemote = {}
RPWORDLIST.eyes_of_the_beast.HUNTER.random = {} 
                         
RPWORDLIST.scare_beast.HUNTER = {}
RPWORDLIST.scare_beast.HUNTER.emote = {"CHICKEN"}
RPWORDLIST.scare_beast.HUNTER.customemote = {"starts to make really scary faces at TARGET."}
RPWORDLIST.scare_beast.HUNTER.random = {}         
                         
RPWORDLIST.beast_lore.HUNTER = {}
RPWORDLIST.beast_lore.HUNTER.emote = {}
RPWORDLIST.beast_lore.HUNTER.customemote = {"learns all about TARGET."}
RPWORDLIST.beast_lore.HUNTER.random = {}      
                         
RPWORDLIST.bestial_wrath.HUNTER = {}
RPWORDLIST.bestial_wrath.HUNTER.emote = {}
RPWORDLIST.bestial_wrath.HUNTER.customemote = {}
RPWORDLIST.bestial_wrath.HUNTER.random = {}   
                         
RPWORDLIST.tranquilizing_shot.HUNTER = {}
RPWORDLIST.tranquilizing_shot.HUNTER.emote = {}
RPWORDLIST.tranquilizing_shot.HUNTER.customemote = {}
RPWORDLIST.tranquilizing_shot.HUNTER.random = {}
--=====================================================================--
-- Marksmanship
--=====================================================================--                                     
RPWORDLIST.arcane_shot.HUNTER = {}
RPWORDLIST.arcane_shot.HUNTER.emote = {}
RPWORDLIST.arcane_shot.HUNTER.customemote = {
    "adds some arcane power to this shot for a little more oomph.",
    "sends the gift of an arcane shot, from me to you, TARGET.",
    "blasts TARGET with some arcane power.",
    
}
RPWORDLIST.arcane_shot.HUNTER.random = {}                                           
                                   
RPWORDLIST.concussive_shot.HUNTER = {
    "Not so fast, TARGET!",
    "Enjoy the last few seconds of your life, TARGET.",
    "Whoah, slow down, TARGET!",
    "Going somewhere? I think not.",
}
RPWORDLIST.concussive_shot.HUNTER.emote = {}
RPWORDLIST.concussive_shot.HUNTER.customemote = {"suggests TARGET slows down a bit.",}
RPWORDLIST.concussive_shot.HUNTER.random = {}   

RPWORDLIST.distracting_shot.HUNTER = {"Yoohoo... look at me!"}
RPWORDLIST.distracting_shot.HUNTER.emote = {}
RPWORDLIST.distracting_shot.HUNTER.customemote = {"tries to distract TARGET."}
RPWORDLIST.distracting_shot.HUNTER.random = {}     

RPWORDLIST.multi_shot.HUNTER = {}
RPWORDLIST.multi_shot.HUNTER.emote = {}
RPWORDLIST.multi_shot.HUNTER.customemote = {}
RPWORDLIST.multi_shot.HUNTER.random = {}

RPWORDLIST.aimed_shot.HUNTER = {"Ready, Aim, Fire!",}
RPWORDLIST.aimed_shot.HUNTER.emote = {}
RPWORDLIST.aimed_shot.HUNTER.customemote = {"takes careful aim at TARGET.",}
RPWORDLIST.aimed_shot.HUNTER.random = {}    
          
RPWORDLIST.scatter_shot.HUNTER = {}
RPWORDLIST.scatter_shot.HUNTER.emote = {}
RPWORDLIST.scatter_shot.HUNTER.customemote = {}
RPWORDLIST.scatter_shot.HUNTER.random = {} 

-------------------------------------------------------------------------       
                            
RPWORDLIST.serpent_sting.HUNTER = {}
RPWORDLIST.serpent_sting.HUNTER.emote = {}
RPWORDLIST.serpent_sting.HUNTER.customemote = {}
RPWORDLIST.serpent_sting.HUNTER.random = {}

RPWORDLIST.scorpid_sting.HUNTER = {}
RPWORDLIST.scorpid_sting.HUNTER.emote = {}
RPWORDLIST.scorpid_sting.HUNTER.customemote = {}
RPWORDLIST.scorpid_sting.HUNTER.random = {}    
 
RPWORDLIST.viper_sting.HUNTER = {}
RPWORDLIST.viper_sting.HUNTER.emote = {}
RPWORDLIST.viper_sting.HUNTER.customemote = {}
RPWORDLIST.viper_sting.HUNTER.random = {}   

-------------------------------------------------------------------------       
       
RPWORDLIST.hunters_mark.HUNTER = {}
RPWORDLIST.hunters_mark.HUNTER.emote = {}
RPWORDLIST.hunters_mark.HUNTER.customemote = {}
RPWORDLIST.hunters_mark.HUNTER.random = {}  
                                   
RPWORDLIST.deterrence.HUNTER = {}
RPWORDLIST.deterrence.HUNTER.emote = {}
RPWORDLIST.deterrence.HUNTER.customemote = {}
RPWORDLIST.deterrence.HUNTER.random = {}   

RPWORDLIST.disengage.HUNTER = {}
RPWORDLIST.disengage.HUNTER.emote = {}
RPWORDLIST.disengage.HUNTER.customemote = {}
RPWORDLIST.disengage.HUNTER.random = {} 

RPWORDLIST.rapid_fire.HUNTER = {}
RPWORDLIST.rapid_fire.HUNTER.emote = {}
RPWORDLIST.rapid_fire.HUNTER.customemote = {}
RPWORDLIST.rapid_fire.HUNTER.random = {}  

RPWORDLIST.flare.HUNTER = {}
RPWORDLIST.flare.HUNTER.emote = {}
RPWORDLIST.flare.HUNTER.customemote = {}
RPWORDLIST.flare.HUNTER.random = {}   

RPWORDLIST.trueshot_aura.HUNTER = {}
RPWORDLIST.trueshot_aura.HUNTER.emote = {}
RPWORDLIST.trueshot_aura.HUNTER.customemote = {}
RPWORDLIST.trueshot_aura.HUNTER.random = {}   

RPWORDLIST.volley.HUNTER = {}
RPWORDLIST.volley.HUNTER.emote = {}
RPWORDLIST.volley.HUNTER.customemote = {}
RPWORDLIST.volley.HUNTER.random = {}
--=====================================================================--
-- Survival
--=====================================================================-- 
RPWORDLIST.track_beasts.HUNTER = {}
RPWORDLIST.track_beasts.HUNTER.emote = {}
RPWORDLIST.track_beasts.HUNTER.customemote = {}
RPWORDLIST.track_beasts.HUNTER.random = {}      
                                                                
RPWORDLIST.track_humanoids.HUNTER = {}
RPWORDLIST.track_humanoids.HUNTER.emote = {}
RPWORDLIST.track_humanoids.HUNTER.customemote = {}
RPWORDLIST.track_humanoids.HUNTER.random = {}     
                                                                
RPWORDLIST.track_undead.HUNTER = {}
RPWORDLIST.track_undead.HUNTER.emote = {}
RPWORDLIST.track_undead.HUNTER.customemote = {}
RPWORDLIST.track_undead.HUNTER.random = {}   
                                                                
RPWORDLIST.track_hidden.HUNTER = {}
RPWORDLIST.track_hidden.HUNTER.emote = {}
RPWORDLIST.track_hidden.HUNTER.customemote = {}
RPWORDLIST.track_hidden.HUNTER.random = {}       
                                                                
RPWORDLIST.track_elementals.HUNTER = {}
RPWORDLIST.track_elementals.HUNTER.emote = {}
RPWORDLIST.track_elementals.HUNTER.customemote = {}
RPWORDLIST.track_elementals.HUNTER.random = {}  
                                                                
RPWORDLIST.track_demons.HUNTER = {}
RPWORDLIST.track_demons.HUNTER.emote = {}
RPWORDLIST.track_demons.HUNTER.customemote = {}
RPWORDLIST.track_demons.HUNTER.random = {}      
                                                                
RPWORDLIST.track_giants.HUNTER = {}
RPWORDLIST.track_giants.HUNTER.emote = {}
RPWORDLIST.track_giants.HUNTER.customemote = {}
RPWORDLIST.track_giants.HUNTER.random = {}    
                                                                
RPWORDLIST.track_dragonkin.HUNTER = {}
RPWORDLIST.track_dragonkin.HUNTER.emote = {}
RPWORDLIST.track_dragonkin.HUNTER.customemote = {}
RPWORDLIST.track_dragonkin.HUNTER.random = {}        

-------------------------------------------------------------------------        

RPWORDLIST.immolation_trap.HUNTER = {}
RPWORDLIST.immolation_trap.HUNTER.emote = {}
RPWORDLIST.immolation_trap.HUNTER.customemote = {}
RPWORDLIST.immolation_trap.HUNTER.random = {}     

RPWORDLIST.freezing_trap.HUNTER = {"Time for someone to chill out."}
RPWORDLIST.freezing_trap.HUNTER.emote = {}
RPWORDLIST.freezing_trap.HUNTER.customemote = {}
RPWORDLIST.freezing_trap.HUNTER.random = {}        

RPWORDLIST.frost_trap.HUNTER = {"This should slow things down a bit"}
RPWORDLIST.frost_trap.HUNTER.emote = {}
RPWORDLIST.frost_trap.HUNTER.customemote = {}
RPWORDLIST.frost_trap.HUNTER.random = {}      

RPWORDLIST.explosive_trap.HUNTER = {}
RPWORDLIST.explosive_trap.HUNTER.emote = {}
RPWORDLIST.explosive_trap.HUNTER.customemote = {}
RPWORDLIST.explosive_trap.HUNTER.random = {}     

-------------------------------------------------------------------------        

RPWORDLIST.raptor_strike.HUNTER = {}
RPWORDLIST.raptor_strike.HUNTER.emote = {}
RPWORDLIST.raptor_strike.HUNTER.customemote = {}
RPWORDLIST.raptor_strike.HUNTER.random = {}       

RPWORDLIST.wing_clip.HUNTER = {}
RPWORDLIST.wing_clip.HUNTER.emote = {}
RPWORDLIST.wing_clip.HUNTER.customemote = {}
RPWORDLIST.wing_clip.HUNTER.random = {} 

RPWORDLIST.mongoose_bite.HUNTER = {}
RPWORDLIST.mongoose_bite.HUNTER.emote = {}
RPWORDLIST.mongoose_bite.HUNTER.customemote = {}
RPWORDLIST.mongoose_bite.HUNTER.random = {}

RPWORDLIST.counterattack.HUNTER = {}
RPWORDLIST.counterattack.HUNTER.emote = {}
RPWORDLIST.counterattack.HUNTER.customemote = {}
RPWORDLIST.counterattack.HUNTER.random = {}        

RPWORDLIST.feign_death.HUNTER = {"Shhh! Don't tell them I'm not really dead.",}
RPWORDLIST.feign_death.HUNTER.emote = {}
RPWORDLIST.feign_death.HUNTER.customemote = {"feigns PP death.",}
RPWORDLIST.feign_death.HUNTER.random = {}        

RPWORDLIST.wyvern_sting.HUNTER = {}
RPWORDLIST.wyvern_sting.HUNTER.emote = {}
RPWORDLIST.wyvern_sting.HUNTER.customemote = {}
RPWORDLIST.wyvern_sting.HUNTER.random = {}       

