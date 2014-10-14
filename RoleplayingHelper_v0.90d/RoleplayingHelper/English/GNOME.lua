--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.GNOME = {
	"For Gnomeregan!",
	"Charge!",
 	"I'll Bite Your Legs Off!",
	"You looking at me? Are you looking at ME? HEY, I'm down here!",        -- mithyk
	"Do you feel lucky, punk? Well, do ya?! Because I've calculated your odds of success and they are embarasingly low.", -- mithyk & butchered by Syrsa
	"I'm warning you, I'm seriously stressed out here!",                    -- mithyk
	}
RPWORDLIST.entercombat.GNOME.emote = {}
RPWORDLIST.entercombat.GNOME.customemote = {}
RPWORDLIST.entercombat.GNOME.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.GNOME = {}
RPWORDLIST.leavecombat.GNOME.emote = {}
RPWORDLIST.leavecombat.GNOME.customemote = {}
RPWORDLIST.leavecombat.GNOME.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.GNOME = {
	"Not in the face! Not in the face!",
	"Don't hurt me I'm small.",
	"I don't find this pain agreeable at all.",
-- the following are from mithyk
	"Ok, now that was uncalled for!",
	"That was totally uncalled for!",
	"You could have taken my eye out with that!!!",
	"You could put somebody's eye out!",
	"You'll miss me when I'm gone!",
	"Stop pummelling me! It's really painful!",
	"That's hitting low.",
	"Hey, what's your problem!?",
	"Stop fighting back, it's not fair...",
	"This is it the final, the very very last straw!",
	"Don't you have anything better to do?",
	"You don't like me much, do you?",
	"That was not the way I planned it!",
	"Alright, that's the last straw, time to design a trash can! I mean, take out, uh...",
	}
RPWORDLIST.hurt.GNOME.emote = {"BLEED",}
RPWORDLIST.hurt.GNOME.customemote = {}
RPWORDLIST.hurt.GNOME.random = {

	["phrase"] = "BLANKBLANK BLANK",
	
	[1] = { "Ow! ","Ouch! ","Oof! ","Ack! ","","", },
	
	[2] = { "Quit it!","That hurts!","Pain.","Not nice.","Not in the face!","That's gonna leave a mark.","Stop the pain!",
			"Stop with the hurting!","I'll get you for that.","You'll regret that.","That hurt.","Stop attacking the little guy!", },

	[3] = { "RINSULT","","","","", },

	}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.GNOME = {}
RPWORDLIST.absorb.GNOME.emote = {}
RPWORDLIST.absorb.GNOME.customemote = {}
RPWORDLIST.absorb.GNOME.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.GNOME = {}
RPWORDLIST.block.GNOME.emote = {}
RPWORDLIST.block.GNOME.customemote = {}
RPWORDLIST.block.GNOME.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.GNOME = {}
RPWORDLIST.dodge.GNOME.emote = {}
RPWORDLIST.dodge.GNOME.customemote = {}
RPWORDLIST.dodge.GNOME.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.GNOME = {}
RPWORDLIST.miss.GNOME.emote = {}
RPWORDLIST.miss.GNOME.customemote = {}
RPWORDLIST.miss.GNOME.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.GNOME = {}
RPWORDLIST.parry.GNOME.emote = {}
RPWORDLIST.parry.GNOME.customemote = {}
RPWORDLIST.parry.GNOME.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.GNOME = {
	"Take that!",
	"Take that, and that, and this one too!",
	"Aww - did you have a booboo?",
	"Everything is proceeding as I have planned - kinda weird, actually.",
	"Wow, all that blood is sticky!",
	"Look out! Too late.",
	"Hey! You scratched my weapon!",
	"Combat is much more fun when I'm winning!",
}
RPWORDLIST.youcrit.GNOME.emote = {}
RPWORDLIST.youcrit.GNOME.customemote = {}
RPWORDLIST.youcrit.GNOME.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.GNOME = {
	"Take that!",
	"Take that, and that, and this one too!",
	"Oww - did you have a booboo?",
	"Everything is proceeding as I have planned - kinda wierd, actually.",
	"Wow, all that blood is sticky!",
	"Look out! Too late.",
	"Combat is much more fun when I'm winning!",
}
RPWORDLIST.youcritspell.GNOME.emote = {}
RPWORDLIST.youcritspell.GNOME.customemote = {}
RPWORDLIST.youcritspell.GNOME.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.GNOME = {}
RPWORDLIST.petattackstart.GNOME.emote = {}
RPWORDLIST.petattackstart.GNOME.customemote = {}
RPWORDLIST.petattackstart.GNOME.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.GNOME = {}
RPWORDLIST.petattackstop.GNOME.emote = {}
RPWORDLIST.petattackstop.GNOME.customemote = {}
RPWORDLIST.petattackstop.GNOME.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.GNOME = {}
RPWORDLIST.petdies.GNOME.emote = {}
RPWORDLIST.petdies.GNOME.customemote = {}
RPWORDLIST.petdies.GNOME.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================--
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.GNOME = {}
RPWORDLIST.talktonpc_beginning.GNOME.emote = {}
RPWORDLIST.talktonpc_beginning.GNOME.customemote = {}
RPWORDLIST.talktonpc_beginning.GNOME.random = {}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC 
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.GNOME = {
	"TARGET, till next we meet.",
	"See you later, TARGET.",
	"Be seeing you, TARGET."
}
RPWORDLIST.talktonpc_end.GNOME.emote = {}
RPWORDLIST.talktonpc_end.GNOME.customemote = {}
RPWORDLIST.talktonpc_end.GNOME.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.GNOME = {}
RPWORDLIST.npctalksfriend.GNOME.emote = {}
RPWORDLIST.npctalksfriend.GNOME.customemote = {}
RPWORDLIST.npctalksfriend.GNOME.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.GNOME = {}
RPWORDLIST.npctalksenemy.GNOME.emote = {}
RPWORDLIST.npctalksenemy.GNOME.customemote = {}
RPWORDLIST.npctalksenemy.GNOME.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.GNOME = {}
RPWORDLIST.resurrect.GNOME.emote = {}
RPWORDLIST.resurrect.GNOME.customemote = {}
RPWORDLIST.resurrect.GNOME.random = {}
