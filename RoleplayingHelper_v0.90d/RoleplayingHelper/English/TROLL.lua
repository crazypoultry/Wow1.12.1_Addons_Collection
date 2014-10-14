--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:  mithyk

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.TROLL = {
	"Strengt aan Honah!",
	"Fi Glory, mon! Fi Honah!",
	"Tremble! A hero a' di Horde be upon ya!",
	"Fi di Horde!",
	"Oh we gween get along jus' fine!",
	"Mi gween make ya suffah like ya was an elf!",
	"Keepin' it real up inna di field.",
	"Mi di baddest soul inna town, mon.",
	"Tas'dingo!",
	"It be time fi a lickle blood.",
	"Now we kill.",
	"Ya made big mistake.",
	"Here come di voodoo!",
	"Di Loa nuh like ya much.",
	"Rock aan roll!",
	"Let's Rock!",
	"Ya gween ta bark all day or ya gween ta bite?",
	"Fine, mi kill you first den eat.",
	"Ya Come Get Some."
	}
RPWORDLIST.entercombat.TROLL.emote = {"Snarl","Guffaw","Growl","Laugh","Crack"} 
RPWORDLIST.entercombat.TROLL.customemote = {}
RPWORDLIST.entercombat.TROLL.random = {
	
	["phrase"] = "You BLANK BLANK BLANK",
	
	[1] = {"gween","'bout ta","haffi" },
	
	[2] = {"give mi yer powah","leave di flesh","die", },
	
	[3] = {"aan ain't naa Loa be savin' ya!","fi mi Loa be strongah dan yours!","fi ya face a membah a' di darkspear tribe!"},

}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.TROLL = {
	"Mi came, Mi saw, Mi found some breakfass.",
}
RPWORDLIST.leavecombat.TROLL.emote = {"grin SELF","wink"}                                       
RPWORDLIST.leavecombat.TROLL.customemote = {}
RPWORDLIST.leavecombat.TROLL.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.TROLL = {
	"So much fi foreplay!",
	"Mi would nuh do such tings if mi was you.",
	"Very well, if dass di way you wanna play it.",
	"Ya be payin fi dat!",
	"Does dis mean we're nuh fren's no more?",
}
RPWORDLIST.hurt.TROLL.emote = {"BLEED","Snarl","growl",}       
RPWORDLIST.hurt.TROLL.customemote = {}
RPWORDLIST.hurt.TROLL.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.TROLL = {}
RPWORDLIST.absorb.TROLL.emote = {"laugh SELF","guffaw SELF","wink",}
RPWORDLIST.absorb.TROLL.customemote = {}
RPWORDLIST.absorb.TROLL.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.TROLL = {}
RPWORDLIST.block.TROLL.emote = {"laugh SELF","guffaw SELF","wink",} 
RPWORDLIST.block.TROLL.customemote = {}
RPWORDLIST.block.TROLL.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.TROLL = {}
RPWORDLIST.dodge.TROLL.emote = {"laugh SELF","guffaw SELF","wink",}
RPWORDLIST.dodge.TROLL.customemote = {}
RPWORDLIST.dodge.TROLL.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.TROLL = {}
RPWORDLIST.miss.TROLL.emote = {"laugh SELF","guffaw SELF","wink",} 
RPWORDLIST.miss.TROLL.customemote = {}
RPWORDLIST.miss.TROLL.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.TROLL = {}
RPWORDLIST.parry.TROLL.emote = {"laugh SELF","guffaw SELF","wink",}
RPWORDLIST.parry.TROLL.customemote = {}
RPWORDLIST.parry.TROLL.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.TROLL = {
	"Be happy. Look at me, me happy.",
	"We be jammin'!",
	"Mi smell fear.",
	"Mi eatchu still warm body.",
}
RPWORDLIST.youcrit.TROLL.emote = {"laugh SELF","guffaw SELF","wink",} 
RPWORDLIST.youcrit.TROLL.customemote = {}
RPWORDLIST.youcrit.TROLL.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.TROLL = {
	"Be happy. Look at me, me happy.",
	"We be jammin'!",
	"Mi smell fear.",
	"Mi eatchu still warm body.",
}
RPWORDLIST.youcritspell.TROLL.emote = {"laugh SELF","guffaw SELF","wink",}
RPWORDLIST.youcritspell.TROLL.customemote = {}
RPWORDLIST.youcritspell.TROLL.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.TROLL = {}
RPWORDLIST.youheal.TROLL.emote = {"pray",}
RPWORDLIST.youheal.TROLL.customemote = {
	"say's a quick prayer of healing.",
	"calls upon the Loa to spread the healing.",
}
RPWORDLIST.youheal.TROLL.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.TROLL = {}
RPWORDLIST.youcritheal.TROLL.emote = {"pray",}
RPWORDLIST.youcritheal.TROLL.customemote = {
	"say's a quick prayer of healing.",
	"calls upon the Loa to spread the healing.",
}
RPWORDLIST.youcritheal.TROLL.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.TROLL = {}
RPWORDLIST.petattackstart.TROLL.emote = {}
RPWORDLIST.petattackstart.TROLL.customemote = {}
RPWORDLIST.petattackstart.TROLL.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.TROLL = {}
RPWORDLIST.petattackstop.TROLL.emote = {} 
RPWORDLIST.petattackstop.TROLL.customemote = {}
RPWORDLIST.petattackstop.TROLL.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.TROLL = {}
RPWORDLIST.petdies.TROLL.emote = {}      
RPWORDLIST.petdies.TROLL.customemote = {}
RPWORDLIST.petdies.TROLL.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================--
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.TROLL = {
	"TARGET, greetins mon.",
	"TARGET, 'ello mon.",
	"TARGET, talk ta me.",
	"Hay der TARGET.",
	"Di Loa be wit you TARGET.",
	"TARGET, how you doin mon?",
	"TARGET, how are ya?",
	"TARGET, don' be shy.",
	"TARGET, ya come get da voodoo.",
}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC 
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.TROLL = {
	"TARGET, you be careful mon.",
	"Be sein ya TARGET.",
	"Be good TARGET.",
	"Bye bye now TARGET.",
	"TARGET, Spirits be with ya mon.",
	"Latteh TARGET.",
	"Seeya latteh TARGET.",
	"Okie dokie TARGET.",
	"Stay away from da voodoo TARGET.",
}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.TROLL = {}
RPWORDLIST.npctalksfriend.TROLL.emote = {}
RPWORDLIST.npctalksfriend.TROLL.customemote = {}
RPWORDLIST.npctalksfriend.TROLL.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.TROLL = {}
RPWORDLIST.npctalksenemy.TROLL.emote = {}
RPWORDLIST.npctalksenemy.TROLL.customemote = {}
RPWORDLIST.npctalksenemy.TROLL.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.TROLL = {
	"Mi be alive!",
	"Huh? Wha? How did me get here?",
	"Tanks Doc, I be owin ya one.",
	"All patched up aan ready fi action!",
	"Hehe, dem missed all mi vital spots!",
	"Tas'dingo, blacked out fi a minute!",
	"Tought mi was done fi sure dat time.",
	"Dat's gonna leave a mark.",
	"Dis scar be gettin' mi lotta attention!",
	"Mi walked among di loa, but now mi be wakin.",
}
RPWORDLIST.resurrect.TROLL.emote = {}
RPWORDLIST.resurrect.TROLL.customemote = {}
RPWORDLIST.resurrect.TROLL.random = {
	
	["phrase"] = "BLANK BLANK",
	
	[1] = {"Tanks to di Loa,","By mi Loa's interference,","Di Loa smile 'pon mi,","Di Loa favah mi,"},
	
	[2] = {"mi survived.","mi be livin'.","me life been spared.","mi still inna di flesh.","mi remain 'pon di world."},

}
