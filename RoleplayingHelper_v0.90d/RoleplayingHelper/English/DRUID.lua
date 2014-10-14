--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.DRUID = {
	"I will destroy those who disrupt nature.",
	"I sense darkness in the dream.",
	"For nature's survival!",
	"The grass beneath your feet screams, I answer!",
	--"Let my armies be the rocks and the trees and the birds in the sky!",
}
RPWORDLIST.entercombat.DRUID.emote = {"CHARGE","ROAR",}
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
RPWORDLIST.youcritheal.DRUID.customemote = {"thanks Elune for a critical heal.","smiles at PP critical heal."}
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
RPWORDLIST.resurrect.DRUID = {}
RPWORDLIST.resurrect.DRUID.emote = {}
RPWORDLIST.resurrect.DRUID.customemote = {
    "kisses the earth, spins through the fresh air, and gives thanks to Elune.",
    "is overjoyed at feeling all of living nature around OP once more.",
}
RPWORDLIST.resurrect.DRUID.random = {}


--/////////////////////////////////////////////////////////////////////--
-- Druid Spells
--/////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Feral Combat
-- I'm doubtful that shapeshifting will do an RP.
-- Please test "Cat Form", "Travel Form", etc. at 100% and let me know (^_^)/                                                                 
--=====================================================================--
RPWORDLIST.demoralizing_roar.DRUID = {}
RPWORDLIST.demoralizing_roar.DRUID.emote = {"ROAR"}
RPWORDLIST.demoralizing_roar.DRUID.customemote = {}
RPWORDLIST.demoralizing_roar.DRUID.random = {} 
                                                         
RPWORDLIST.enrage.DRUID = {}
RPWORDLIST.enrage.DRUID.emote = {"ROAR"}
RPWORDLIST.enrage.DRUID.customemote = {}
RPWORDLIST.enrage.DRUID.random = {}           
                                                         
RPWORDLIST.bash.DRUID = {}
RPWORDLIST.bash.DRUID.emote = {}
RPWORDLIST.bash.DRUID.customemote = {}
RPWORDLIST.bash.DRUID.random = {}        
                                                         
RPWORDLIST.swipe.DRUID = {}
RPWORDLIST.swipe.DRUID.emote = {}
RPWORDLIST.swipe.DRUID.customemote = {}
RPWORDLIST.swipe.DRUID.random = {}        
                                                         
RPWORDLIST.maul.DRUID = {}
RPWORDLIST.maul.DRUID.emote = {}
RPWORDLIST.maul.DRUID.customemote = {}
RPWORDLIST.maul.DRUID.random = {}       
                   				                                         
RPWORDLIST.cat_form.DRUID = {}
RPWORDLIST.cat_form.DRUID.emote = {}
RPWORDLIST.cat_form.DRUID.customemote = {}
RPWORDLIST.cat_form.DRUID.random = {} 
    	                                         
RPWORDLIST.claw.DRUID = {}
RPWORDLIST.claw.DRUID.emote = {}
RPWORDLIST.claw.DRUID.customemote = {}
RPWORDLIST.claw.DRUID.random = {}       
    	                                         
RPWORDLIST.feral_charge.DRUID = {}
RPWORDLIST.feral_charge.DRUID.emote = {}
RPWORDLIST.feral_charge.DRUID.customemote = {}
RPWORDLIST.feral_charge.DRUID.random = {}      
    	                                         
RPWORDLIST.prowl.DRUID = {}
RPWORDLIST.prowl.DRUID.emote = {}
RPWORDLIST.prowl.DRUID.customemote = {}
RPWORDLIST.prowl.DRUID.random = {}            
    	                                         
RPWORDLIST.rip.DRUID = {}
RPWORDLIST.rip.DRUID.emote = {}
RPWORDLIST.rip.DRUID.customemote = {}
RPWORDLIST.rip.DRUID.random = {}               
    	                                         
RPWORDLIST.shred.DRUID = {}
RPWORDLIST.shred.DRUID.emote = {}
RPWORDLIST.shred.DRUID.customemote = {}
RPWORDLIST.shred.DRUID.random = {}           
    	                                         
RPWORDLIST.rake.DRUID = {}
RPWORDLIST.rake.DRUID.emote = {}
RPWORDLIST.rake.DRUID.customemote = {}
RPWORDLIST.rake.DRUID.random = {}           
    	                                         
RPWORDLIST.tigers_fury.DRUID = {"feel the tiger's fury!"}
RPWORDLIST.tigers_fury.DRUID.emote = {"ROAR"}
RPWORDLIST.tigers_fury.DRUID.customemote = {"roars furiously."}
RPWORDLIST.tigers_fury.DRUID.random = {}     
    	                                         
RPWORDLIST.dash.DRUID = {}
RPWORDLIST.dash.DRUID.emote = {}
RPWORDLIST.dash.DRUID.customemote = {}
RPWORDLIST.dash.DRUID.random = {}          
    	                                         
RPWORDLIST.challenging_roar.DRUID = {}
RPWORDLIST.challenging_roar.DRUID.emote = {"ROAR"}
RPWORDLIST.challenging_roar.DRUID.customemote = {}
RPWORDLIST.challenging_roar.DRUID.random = {}  
    	                                         
RPWORDLIST.cower.DRUID = {}
RPWORDLIST.cower.DRUID.emote = {}
RPWORDLIST.cower.DRUID.customemote = {}
RPWORDLIST.cower.DRUID.random = {}    
    	                                         
RPWORDLIST.faerie_fire_feral.DRUID = {}
RPWORDLIST.faerie_fire_feral.DRUID.emote = {}
RPWORDLIST.faerie_fire_feral.DRUID.customemote = {}
RPWORDLIST.faerie_fire_feral.DRUID.random = {}     
    	                                         
RPWORDLIST.travel_form.DRUID = {}
RPWORDLIST.travel_form.DRUID.emote = {}
RPWORDLIST.travel_form.DRUID.customemote = {}
RPWORDLIST.travel_form.DRUID.random = {}       
    	                                         
RPWORDLIST.ferocious_bite.DRUID = {}
RPWORDLIST.ferocious_bite.DRUID.emote = {}
RPWORDLIST.ferocious_bite.DRUID.customemote = {}
RPWORDLIST.ferocious_bite.DRUID.random = {}     
    	                                         
RPWORDLIST.ravage.DRUID = {}
RPWORDLIST.ravage.DRUID.emote = {}
RPWORDLIST.ravage.DRUID.customemote = {}
RPWORDLIST.ravage.DRUID.random = {}        
    	                                         
RPWORDLIST.track_humanoids.DRUID = {}
RPWORDLIST.track_humanoids.DRUID.emote = {}
RPWORDLIST.track_humanoids.DRUID.customemote = {}
RPWORDLIST.track_humanoids.DRUID.random = {}   
    	                                         
RPWORDLIST.frenzied_regeneration.DRUID = {}
RPWORDLIST.frenzied_regeneration.DRUID.emote = {}
RPWORDLIST.frenzied_regeneration.DRUID.customemote = {}
RPWORDLIST.frenzied_regeneration.DRUID.random = {}    
    	                                         
RPWORDLIST.pounce.DRUID = {}
RPWORDLIST.pounce.DRUID.emote = {}
RPWORDLIST.pounce.DRUID.customemote = {}
RPWORDLIST.pounce.DRUID.random = {}        
    	                                         
RPWORDLIST.dire_bear_form.DRUID = {}
RPWORDLIST.dire_bear_form.DRUID.emote = {"ROAR"}
RPWORDLIST.dire_bear_form.DRUID.customemote = {}
RPWORDLIST.dire_bear_form.DRUID.random = {}    
    	                                         
RPWORDLIST.leader_of_the_pack.DRUID = {}
RPWORDLIST.leader_of_the_pack.DRUID.emote = {}
RPWORDLIST.leader_of_the_pack.DRUID.customemote = {}
RPWORDLIST.leader_of_the_pack.DRUID.random = {} 
--=====================================================================--
-- Balance        
--=====================================================================-- 
RPWORDLIST.wrath.DRUID = {}
RPWORDLIST.wrath.DRUID.emote = {}
RPWORDLIST.wrath.DRUID.customemote = {}
RPWORDLIST.wrath.DRUID.random = {}
 
RPWORDLIST.moon_fire.DRUID = {}
RPWORDLIST.moon_fire.DRUID.emote = {}
RPWORDLIST.moon_fire.DRUID.customemote = {}
RPWORDLIST.moon_fire.DRUID.random = {} 

RPWORDLIST.thorns.DRUID = {}
RPWORDLIST.thorns.DRUID.emote = {}
RPWORDLIST.thorns.DRUID.customemote = {}
RPWORDLIST.thorns.DRUID.random = {}

RPWORDLIST.entangling_roots.DRUID = {
    "How 'bout ya stick around for awhile, TARGET.'",
    "Oh, were you going somewhere?",
    "I think you're better off being firmly rooted in place, TARGET.",
}
RPWORDLIST.entangling_roots.DRUID.emote = {}
RPWORDLIST.entangling_roots.DRUID.customemote = {}
RPWORDLIST.entangling_roots.DRUID.random = {}

RPWORDLIST.natures_grasp.DRUID = {}
RPWORDLIST.natures_grasp.DRUID.emote = {}
RPWORDLIST.natures_grasp.DRUID.customemote = {}
RPWORDLIST.natures_grasp.DRUID.random = {}   

RPWORDLIST.faerie_fire.DRUID = {}
RPWORDLIST.faerie_fire.DRUID.emote = {}
RPWORDLIST.faerie_fire.DRUID.customemote = {}
RPWORDLIST.faerie_fire.DRUID.random = {}

RPWORDLIST.hibernate.DRUID = {
    "Yoohoo... TARGET... Nap Time!",
    "Sleep... sleep...",
    "Take a nap TARGET, we'll get to you in a bit.",
    "Nighty night TARGET.",
}
RPWORDLIST.hibernate.DRUID.emote = {}
RPWORDLIST.hibernate.DRUID.customemote = {"suggests TARGET take a quick nap.","dangles a watch in front of TARGET. You are feeling very sleepy...",}
RPWORDLIST.hibernate.DRUID.random = {} 

RPWORDLIST.omen_of_clarity.DRUID = {}
RPWORDLIST.omen_of_clarity.DRUID.emote = {}
RPWORDLIST.omen_of_clarity.DRUID.customemote = {}
RPWORDLIST.omen_of_clarity.DRUID.random = {}

RPWORDLIST.starfire.DRUID = {}
RPWORDLIST.starfire.DRUID.emote = {}
RPWORDLIST.starfire.DRUID.customemote = {}
RPWORDLIST.starfire.DRUID.random = {}

RPWORDLIST.soothe_animal.DRUID = {}
RPWORDLIST.soothe_animal.DRUID.emote = {}
RPWORDLIST.soothe_animal.DRUID.customemote = {}
RPWORDLIST.soothe_animal.DRUID.random = {}     

RPWORDLIST.hurricane.DRUID = {"How 'bout a little thunder and lightnin'?"}
RPWORDLIST.hurricane.DRUID.emote = {}
RPWORDLIST.hurricane.DRUID.customemote = {"summons the violent forces of nature."}
RPWORDLIST.hurricane.DRUID.random = {}     

RPWORDLIST.moonkin_form.DRUID = {}
RPWORDLIST.moonkin_form.DRUID.emote = {}
RPWORDLIST.moonkin_form.DRUID.customemote = {}
RPWORDLIST.moonkin_form.DRUID.random = {}  

RPWORDLIST.barkskin.DRUID = {}
RPWORDLIST.barkskin.DRUID.emote = {}
RPWORDLIST.barkskin.DRUID.customemote = {}
RPWORDLIST.barkskin.DRUID.random = {}

RPWORDLIST.teleport_moonglade.DRUID = {}
RPWORDLIST.teleport_moonglade.DRUID.emote = {}
RPWORDLIST.teleport_moonglade.DRUID.customemote = {
    "channels arcane forces within OPself and concentrates on Moonglade.",
    "asks Elune to take OP to Moonglade.",
    "feels Moonglade's call as SP summons arcane powers.",
    "evokes Elune's arcane powers and visualizes Nighthaven."
}
RPWORDLIST.teleport_moonglade.DRUID.random = {}
--=====================================================================--
-- Restoration           
--=====================================================================--
RPWORDLIST.mark_of_the_wild.DRUID = {}
RPWORDLIST.mark_of_the_wild.DRUID.emote = {}
RPWORDLIST.mark_of_the_wild.DRUID.customemote = {}
RPWORDLIST.mark_of_the_wild.DRUID.random = {}

RPWORDLIST.rejuvenation.DRUID = {}
RPWORDLIST.rejuvenation.DRUID.emote = {}
RPWORDLIST.rejuvenation.DRUID.customemote = {}
RPWORDLIST.rejuvenation.DRUID.random = {}
                       
RPWORDLIST.healing_touch.DRUID = {}
RPWORDLIST.healing_touch.DRUID.emote = {}
RPWORDLIST.healing_touch.DRUID.customemote = {}
RPWORDLIST.healing_touch.DRUID.random = {}

RPWORDLIST.regrowth.DRUID = {}
RPWORDLIST.regrowth.DRUID.emote = {}
RPWORDLIST.regrowth.DRUID.customemote = {}
RPWORDLIST.regrowth.DRUID.random = {}  

RPWORDLIST.insect_swarm.DRUID = {}
RPWORDLIST.insect_swarm.DRUID.emote = {}
RPWORDLIST.insect_swarm.DRUID.customemote = {}
RPWORDLIST.insect_swarm.DRUID.random = {}

RPWORDLIST.rebirth.DRUID = {
    "TARGET you've failed at life! However, I believe in second chances...",
    "You're not getting off the hook that easily, TARGET!",
    "Elune! Hear my call and restore life to TARGET!",
    
}
RPWORDLIST.rebirth.DRUID.emote = {}
RPWORDLIST.rebirth.DRUID.customemote = {}
RPWORDLIST.rebirth.DRUID.random = {}     

RPWORDLIST.remove_curse.DRUID = {}
RPWORDLIST.remove_curse.DRUID.emote = {}
RPWORDLIST.remove_curse.DRUID.customemote = {}
RPWORDLIST.remove_curse.DRUID.random = {} 

RPWORDLIST.cure_poison.DRUID = {}
RPWORDLIST.cure_poison.DRUID.emote = {}
RPWORDLIST.cure_poison.DRUID.customemote = {}
RPWORDLIST.cure_poison.DRUID.random = {}    

RPWORDLIST.abolish_poison.DRUID = {}
RPWORDLIST.abolish_poison.DRUID.emote = {}
RPWORDLIST.abolish_poison.DRUID.customemote = {}
RPWORDLIST.abolish_poison.DRUID.random = {}    

RPWORDLIST.natures_swiftness.DRUID = {}
RPWORDLIST.natures_swiftness.DRUID.emote = {}
RPWORDLIST.natures_swiftness.DRUID.customemote = {}
RPWORDLIST.natures_swiftness.DRUID.random = {}  

RPWORDLIST.tranquility.DRUID = {
    "Elune, hear my plea and help me aid my friends!",
    "Healing spirits, arise!",
}
RPWORDLIST.tranquility.DRUID.emote = {}
RPWORDLIST.tranquility.DRUID.customemote = {"calls upon the healing forces of nature."}
RPWORDLIST.tranquility.DRUID.random = {}   

RPWORDLIST.innervate.DRUID = {
    "Innervating TARGET",
    "Gee TARGET, mana got you down? This should raise your spirit!",
    
}
RPWORDLIST.innervate.DRUID.emote = {}
RPWORDLIST.innervate.DRUID.customemote = {"glances at TARGET's mana, sighs, and casts Innervate on OP."}
RPWORDLIST.innervate.DRUID.random = {}  

RPWORDLIST.gift_of_the_wild.DRUID = {}
RPWORDLIST.gift_of_the_wild.DRUID.emote = {}
RPWORDLIST.gift_of_the_wild.DRUID.customemote = {"gives PP friends the Gift of the Wild."}
RPWORDLIST.gift_of_the_wild.DRUID.random = {}

RPWORDLIST.swiftmend.DRUID = {}
RPWORDLIST.swiftmend.DRUID.emote = {}
RPWORDLIST.swiftmend.DRUID.customemote = {}
RPWORDLIST.swiftmend.DRUID.random = {}

RPWORDLIST.hearthstone.DRUID = {}
RPWORDLIST.hearthstone.DRUID.emote = {}
RPWORDLIST.hearthstone.DRUID.customemote = {}
RPWORDLIST.hearthstone.DRUID.random = {}

-- night elf racial
--RPWORDLIST.shadowmeld.DRUID = {}
--RPWORDLIST.shadowmeld.DRUID.emote = {}
--RPWORDLIST.shadowmeld.DRUID.customemote = {"fades into the shadows.", "disappears for a bit.", "thinks SP'll hide now."}
--RPWORDLIST.shadowmeld.DRUID.random = {}
