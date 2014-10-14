--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:  mithyk

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.TAUREN = { 
	"For Honor!",
	"Strength and Honor!",								
	"For Glory! For Honor!",
	"Honor guide me!",
	"For my ancestors!",
	"May my ancestors watch over me!",                            
	"Tremble! A hero of the horde is upon you!",        
	"For the Horde!",
	"For the tribes!",
	"For the warchief and the tribes!",
	"Death to the enemies of the horde!",
	"Steer clear fool.",
	"My hoof and your fundament have an appointment.",
	"I will impale you on my horns!",
	"Start running...",
	"Let battle be joined!",
	"For Kalimdore!",
	"Death to the enemy!",
	"Bring it on!",
	"Ish Ne Alo Por Ah!",
	"Ishnu Por Ah!",
	"The Hunt is upon you!",
	"It's not wise to upset a Tauren",
	"LET'S GET READY TO RUMBBBBLLLLLEEEE!",									
}
RPWORDLIST.entercombat.TAUREN.emote = {"moo SELF","guffaw SELF","laugh SELF","crack",}  
RPWORDLIST.entercombat.TAUREN.customemote = {}
RPWORDLIST.entercombat.TAUREN.random = {
	
	["phrase"] = "You BLANK BLANK, BLANK",
	
	[1] = {"shall","will","must" },
	
	[2] = {"breathe your last","depart this life","die", },
	
	[3] = {"for the Earthmother has seen and found you wanting.","for the Earthmother has sent the hunt.","for the hunt is now upon you."},

}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.TAUREN = {}
RPWORDLIST.leavecombat.TAUREN.emote = {}
RPWORDLIST.leavecombat.TAUREN.customemote = {}
RPWORDLIST.leavecombat.TAUREN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.TAUREN = {
	"You have made me very angry... very angry indeed.",
	"Ancestors, give me strength.",
}
RPWORDLIST.hurt.TAUREN.emote = {"BLEED","MOO",}       
RPWORDLIST.hurt.TAUREN.customemote = {}
RPWORDLIST.hurt.TAUREN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.TAUREN = {}
RPWORDLIST.absorb.TAUREN.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.absorb.TAUREN.customemote = {}
RPWORDLIST.absorb.TAUREN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.TAUREN = {}
RPWORDLIST.block.TAUREN.emote = {"laugh SELF","guffaw SELF",} 
RPWORDLIST.block.TAUREN.customemote = {}
RPWORDLIST.block.TAUREN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.TAUREN = {}
RPWORDLIST.dodge.TAUREN.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.dodge.TAUREN.customemote = {}
RPWORDLIST.dodge.TAUREN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.TAUREN = {}
RPWORDLIST.miss.TAUREN.emote = {"laugh SELF","guffaw SELF",} 
RPWORDLIST.miss.TAUREN.customemote = {}
RPWORDLIST.miss.TAUREN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.TAUREN = {}
RPWORDLIST.parry.TAUREN.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.parry.TAUREN.customemote = {}
RPWORDLIST.parry.TAUREN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.TAUREN = {
 	"How could this possibly be so simple?",
	"See now? Size *does* matter!",
}
RPWORDLIST.youcrit.TAUREN.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.youcrit.TAUREN.customemote = {}
RPWORDLIST.youcrit.TAUREN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.TAUREN = {
 	"How could this possibly be so simple?",
	"See now? Size *does* matter!",
}
RPWORDLIST.youcritspell.TAUREN.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.youcritspell.TAUREN.customemote = {}
RPWORDLIST.youcritspell.TAUREN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.TAUREN = {}
RPWORDLIST.youheal.TAUREN.emote = {
	"The Earthmother smiles upon you",
	"Take heart, the Eartmother is near",
}
RPWORDLIST.youheal.TAUREN.customemote = {}
RPWORDLIST.youheal.TAUREN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.TAUREN = {
	"The Earthmother smiles upon you",
	"Take heart, the Eartmother is near",
}
RPWORDLIST.youcritheal.TAUREN.emote = {}
RPWORDLIST.youcritheal.TAUREN.customemote = {}
RPWORDLIST.youcritheal.TAUREN.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.TAUREN = {}
RPWORDLIST.petattackstart.TAUREN.emote = {}
RPWORDLIST.petattackstart.TAUREN.customemote = {}
RPWORDLIST.petattackstart.TAUREN.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.TAUREN = {}
RPWORDLIST.petattackstop.TAUREN.emote = {} 
RPWORDLIST.petattackstop.TAUREN.customemote = {}
RPWORDLIST.petattackstop.TAUREN.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.TAUREN = {}
RPWORDLIST.petdies.TAUREN.emote = {}      
RPWORDLIST.petdies.TAUREN.customemote = {}
RPWORDLIST.petdies.TAUREN.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================--
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.TAUREN = {
	"TARGET! Hail!",
	"TARGET! How.",
	"TARGET! Well met!",
	"Peace, friend.",
	"The winds guide you TARGET",
	"TARGET ish ne elo por ah.",
	"TARGET, take heart, the eartmother is near.",
	"TARGET, may the earthmother smile upon you.",
}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC 
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.TAUREN = {
	"TARGET, good Journey.",
	"TARGET, go in peace.",
	"TARGET, may our paths cross again.",
	"TARGET, may the wind be at your back.",
	"TARGET, may your ancestors forever guard your path.",
	"TARGET, walk with the Earthmother.",
	"TARGET, winds be at your back.",
	"TARGET, ancestors watch over you.",
	"TARGET, may the eternal sun shine upon thee.",
}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.TAUREN = {}
RPWORDLIST.npctalksfriend.TAUREN.emote = {}
RPWORDLIST.npctalksfriend.TAUREN.customemote = {}
RPWORDLIST.npctalksfriend.TAUREN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.TAUREN = {}
RPWORDLIST.npctalksenemy.TAUREN.emote = {}
RPWORDLIST.npctalksenemy.TAUREN.customemote = {}
RPWORDLIST.npctalksenemy.TAUREN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.TAUREN = {
	"The Earth mother smiles upon me.",
	"That was painful. Where's my peace pipe...",
	"I live!",
	"Wounds bandaged, ready for action!",
	"I have walked among the spirits.",
	"My dreamquest is complete, I awake.",
	"My vision dimmed for a moment.",
	"I was sure that wound had finished me.",
	"I will bear this scar with pride.",
	}
RPWORDLIST.resurrect.TAUREN.emote = {}   
RPWORDLIST.resurrect.TAUREN.customemote = {}
RPWORDLIST.resurrect.TAUREN.random = {
	
	["phrase"] = "BLANK BLANK",
	
	[1] = {"Thanks to the Earth mother,","By the earth mother's mercy,","The Earth mother smiles upon me,","By the Earth mother's will,"},
	
	[2] = {"I have survived.","I live.","my life has been spared.","I remain mortal.","I once again walk the land."},

}
