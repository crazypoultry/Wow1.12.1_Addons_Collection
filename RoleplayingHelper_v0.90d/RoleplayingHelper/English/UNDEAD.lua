--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:  mithyk, Syrsa

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.UNDEAD = {
	"Rend flesh with me!",
	"The forsaken will slaughter any who stands in our way!",
	"I'm too decrepit for this...",
	"No guts, no gore.",
	"U-N-D-E-A-D, find out what it means to me...",
	"What we do in death echoes in eternity...",
	"My life for Sylvanas!",
	"For Sylvanas!",
	"Death shall reign!",
	"Let life cease!",
	"Share my pain.",
	"Tremble before the Forsaken!",
	"Fall before the Forsaken!",
	"Glory to the Forsaken!",
	"I hunger.",
	"Must feed!",
	"Embrace the end!",
	"Embrace the cold!",
	"Die fool.",
	"Time to die.",
	"None shall survive.",
	"Time to be bad!",	
}
RPWORDLIST.entercombat.UNDEAD.emote = {"cackle","snarl","crack","drool","grin","groan","smirk","snicker",}                  
RPWORDLIST.entercombat.UNDEAD.customemote = {}
RPWORDLIST.entercombat.UNDEAD.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.UNDEAD = { 
	"Death... is not the end.",
	"Everyone lives. Not everyone truly dies.",
	"Death is its own reward.",
	"Death is our business and business is good.",
	"Oooh, messy!",
}
RPWORDLIST.leavecombat.UNDEAD.emote = {"gloat","grin SELF",}
RPWORDLIST.leavecombat.UNDEAD.customemote = {}
RPWORDLIST.leavecombat.UNDEAD.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.UNDEAD = {}
RPWORDLIST.hurt.UNDEAD.emote = {}       
RPWORDLIST.hurt.UNDEAD.customemote = {}
RPWORDLIST.hurt.UNDEAD.random = {

	["phrase"] = "BLANK BLANK.",

	[1] = { "There goes another", "I lost another", "You bastard! You took a", "Damn, there goes another" },
	
	[2] = { "chunk of flesh", "bone", "finger", "toe", "pinky", "rib" },
	
	}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.UNDEAD = {}
RPWORDLIST.absorb.UNDEAD.emote = {"laugh","cackle","snicker","gloat",}
RPWORDLIST.absorb.UNDEAD.customemote = {}
RPWORDLIST.absorb.UNDEAD.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.UNDEAD = {}
RPWORDLIST.block.UNDEAD.emote = {"laugh","cackle","snicker","gloat",} 
RPWORDLIST.block.UNDEAD.customemote = {}
RPWORDLIST.block.UNDEAD.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.UNDEAD = {}
RPWORDLIST.dodge.UNDEAD.emote = {"laugh","cackle","snicker","gloat",}
RPWORDLIST.dodge.UNDEAD.customemote = {}
RPWORDLIST.dodge.UNDEAD.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.UNDEAD = {}
RPWORDLIST.miss.UNDEAD.emote = {"laugh","cackle","snicker","gloat",} 
RPWORDLIST.miss.UNDEAD.customemote = {}
RPWORDLIST.miss.UNDEAD.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.UNDEAD = {}
RPWORDLIST.parry.UNDEAD.emote = {"laugh","cackle","snicker","gloat",}
RPWORDLIST.parry.UNDEAD.customemote = {}
RPWORDLIST.parry.UNDEAD.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.UNDEAD = {
	"Sooner or later you'll be dead.",
	"Death stalks you at every turn. aaah! There it is, death! Oh, where were we? Death!",
	"Is it hard to breathe with so many holes in your lungs?",
	"Don't die now! The fun is just beginning!",
	"Don't cry. Your pain will end soon.",
	"I will feed upon your fresh corpse.",
	"No remorse!",
	"What's it like knowing your life is about to end?",
	"Beg! I like it when they beg!",
}
RPWORDLIST.youcrit.UNDEAD.emote = {"laugh","cackle","snicker","gloat",}
RPWORDLIST.youcrit.UNDEAD.customemote = {}
RPWORDLIST.youcrit.UNDEAD.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.UNDEAD = {}
RPWORDLIST.youcritspell.UNDEAD.emote = {"laugh","cackle","snicker","gloat",}
RPWORDLIST.youcritspell.UNDEAD.customemote = {}
RPWORDLIST.youcritspell.UNDEAD.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.UNDEAD = {
	"The Dark Lady watches over you.",
	"Saved by the shadow.",
	"Your time will come, but not yet.",
	"Do not seek death - it will find you soon enough.",
}
RPWORDLIST.youheal.UNDEAD.emote = {}
RPWORDLIST.youheal.UNDEAD.customemote = {}
RPWORDLIST.youheal.UNDEAD.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.UNDEAD = {
	"The Dark Lady watches over you.",
	"Saved by the shadow.",
	"Your time will come, but not yet.",
	"Do not seek death - it will find you soon enough.",
}
RPWORDLIST.youcritheal.UNDEAD.emote = {}
RPWORDLIST.youcritheal.UNDEAD.customemote = {}
RPWORDLIST.youcritheal.UNDEAD.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.UNDEAD = {}
RPWORDLIST.petattackstart.UNDEAD.emote = {}
RPWORDLIST.petattackstart.UNDEAD.customemote = {}
RPWORDLIST.petattackstart.UNDEAD.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.UNDEAD = {}
RPWORDLIST.petattackstop.UNDEAD.emote = {} 
RPWORDLIST.petattackstop.UNDEAD.customemote = {}
RPWORDLIST.petattackstop.UNDEAD.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.UNDEAD = {"Don't worry, PNAME. Death is an improvement."}
RPWORDLIST.petdies.UNDEAD.emote = {}                                        
RPWORDLIST.petdies.UNDEAD.customemote = {}
RPWORDLIST.petdies.UNDEAD.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================-- 
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.UNDEAD = {
	"TARGET, listen up!",
	"TARGET, pay attention! I haven't got all day.",
	"TARGET, listen very carefully and try to keep up.",
	"TARGET, listen carefully.",
	"TARGET, I require something of you.",
	"TARGET, death speaks, listen.",
}                       
-------------------------------------------------------------------------
-- The END of a conversation with an NPC 
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.UNDEAD = {
	"TARGET, dark lady watch over you.",
	"Victory for Sylvanas!",
	"TARGET, embrace the shadow while time remains.",
	"TARGET, beware, enemies abound.",
	"TARGET, beware the living, trust in the dead.",
	"TARGET, remember - patience, discipline.",
	"TARGET, our time will come.",
	"TARGET, do not seek death",
	"TARGET, trust no one",
	"TARGET, Watch your back",
}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.UNDEAD = {
	"Quiet, NPC.  Let me undie in peace.",
	"You have to speak louder NPC.  My ears are rotted.",
	"Say that again NPC.  I had a maggot in my ear.",
	}
RPWORDLIST.npctalksfriend.UNDEAD.emote = {}
RPWORDLIST.npctalksfriend.UNDEAD.customemote = {}
RPWORDLIST.npctalksfriend.UNDEAD.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.UNDEAD = {
	"Shut up, NPC.",
	"Quiet, NPC.",
	"Let's see how well you talk after I cut that tongue out.",
	"Quiet! RINSULT",
	"Shut up! RINSULT",
	"TEXT Haha!"
	}
RPWORDLIST.npctalksenemy.UNDEAD.emote = {}
RPWORDLIST.npctalksenemy.UNDEAD.customemote = {}
RPWORDLIST.npctalksenemy.UNDEAD.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.UNDEAD = {
	"I'm alive!... kinda...",
	"It's cold! And there are wolves after me...! Huh? Wha? Where am I?",
	"That was close. In my state, you see death everywhere... DEATH!",
	"Hate it when my head gets turned around - waste all that time twisting it back in place.",
	"Okay, all the parts sewn back in, ready for action!",
	"Braainss!",
	"Saw a bright light for a moment - then I realized I best get clear.",
	"I'll need to find a replacement for a part or two.",
	"Hrmm, that hole may be permanent.",
	}
RPWORDLIST.resurrect.UNDEAD.emote = {} 
RPWORDLIST.resurrect.UNDEAD.customemote = {}
RPWORDLIST.resurrect.UNDEAD.random = {}
