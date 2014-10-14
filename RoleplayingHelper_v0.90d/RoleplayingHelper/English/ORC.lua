--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:  mithyk

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.ORC = {
	"Strength and Honor!",
	"Tremble! A hero of the horde is upon you!",
	"For the Horde!",
	"Remember Doomhammer!",
	"Remember Durotan!",
	"For Glory! For Honor!",
	 "For the glory of the warchief!",
	"For the glory of the horde!",
	"Victory for the horde!",
	"My life for the Horde!",
	"Time for Killing!",
	"Time to die.",
	"Your destiny is at hand.",
	"Taste the fury of the horde!",
	"You shall not survive!",
	"Your time has come!",
	"Death to all who oppose the horde!",
	"Let us shed blood together!",
	"If we had been meant to fight, we would have been born with tough, baggy, green skin... oh, wait...",  -- butchered by Syrsa
	"Death awaits you on these big, nasty teeth.",
	"To the death!",
	"You will bow to me!",
	"Prepare to die!",
	"Let's play.",
	"You are weak.",
}
RPWORDLIST.entercombat.ORC.emote = {"snarl","guffaw SELF","growl","laugh SELF","crack",}
RPWORDLIST.entercombat.ORC.customemote = {}
RPWORDLIST.entercombat.ORC.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.ORC = {
	"Next time, I want a real opponent.",
	"Hopeless and dead.",
	"Didn't put up much of a fight.",
}
RPWORDLIST.leavecombat.ORC.emote = {}
RPWORDLIST.leavecombat.ORC.customemote = {}
RPWORDLIST.leavecombat.ORC.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.ORC = {
	"Is that it?",
	"Stop poking me!",
	"Poke! Poke! Poke! Is that all you do?",
}
RPWORDLIST.hurt.ORC.emote = {"BLEED","snarl","growl",}
RPWORDLIST.hurt.ORC.customemote = {}
RPWORDLIST.hurt.ORC.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.ORC = {}
RPWORDLIST.absorb.ORC.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.absorb.ORC.customemote = {}
RPWORDLIST.absorb.ORC.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.ORC = {}
RPWORDLIST.block.ORC.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.block.ORC.customemote = {}
RPWORDLIST.block.ORC.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.ORC = {}
RPWORDLIST.dodge.ORC.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.dodge.ORC.customemote = {}
RPWORDLIST.dodge.ORC.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.ORC = {}
RPWORDLIST.miss.ORC.emote = {}
RPWORDLIST.miss.ORC.customemote = {}
RPWORDLIST.miss.ORC.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.ORC = {}
RPWORDLIST.parry.ORC.emote = {}
RPWORDLIST.parry.ORC.customemote = {}
RPWORDLIST.parry.ORC.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.ORC = {
	"This is too easy, I'm switching hands.",
	"This enemy is slow and weak.",
	"This enemy is slow and clumsy.",
	"Give up, weakling.",
	"Next time, try dodging... or parrying... anything...",
	"Maybe I should do this blindfolded.",
	"Tell me you brought friends?",
	"You are outmatched.",
}
RPWORDLIST.youcrit.ORC.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.youcrit.ORC.customemote = {}
RPWORDLIST.youcrit.ORC.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.ORC = {}
RPWORDLIST.youcritspell.ORC.emote = {}
RPWORDLIST.youcritspell.ORC.customemote = {}
RPWORDLIST.youcritspell.ORC.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.ORC = {}
RPWORDLIST.youheal.ORC.emote = {}
RPWORDLIST.youheal.ORC.customemote = {}
RPWORDLIST.youheal.ORC.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.ORC = {}
RPWORDLIST.youcritheal.ORC.emote = {}
RPWORDLIST.youcritheal.ORC.customemote = {}
RPWORDLIST.youcritheal.ORC.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.ORC = {}
RPWORDLIST.petattackstart.ORC.emote = {}
RPWORDLIST.petattackstart.ORC.customemote = {}
RPWORDLIST.petattackstart.ORC.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.ORC = {}
RPWORDLIST.petattackstop.ORC.emote = {}
RPWORDLIST.petattackstop.ORC.customemote = {}
RPWORDLIST.petattackstop.ORC.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.ORC = {}
RPWORDLIST.petdies.ORC.emote = {}
RPWORDLIST.petdies.ORC.customemote = {}
RPWORDLIST.petdies.ORC.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================--
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.ORC = {
	"Throm'ka TARGET!",
	"Mak'gra TARGET!",
	"Lok'tar TARGET!",
	"Lok'tar Ogar TARGET!",
	"TARGET, lok'tar friend.",
	"TARGET, glory to the horde!",
	"TARGET, strength!",
	"TARGET, strength and Honor!",
 	"Thrall hal! I must speak to you TARGET.",
	"Blood and thunder! TARGET, we must speak.",
}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_middle.ORC = {
	"TARGET, strength!",
	"TARGET, until our paths cross again.",
	"TARGET, stay strong.",
	"TARGET, fight well friend.",
	"TARGET, for the horde!",
	"TARGET, may your blade be true.",
	"TARGET, may your blades never dull.",
	"TARGET, go forth to victory.",
	"TARGET, dabu.",
	"TARGET, go forth to victory.",
	"TARGET, go with honor.",
	"TARGET, victory!",
	"TARGET, be safe.",
	"Lok'regar No'gal TARGET.",
	"Lok'tar TARGET.",
	"Lok'tar Ogar TARGET.",
}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.ORC = {}
RPWORDLIST.npctalksfriend.ORC.emote = {}
RPWORDLIST.npctalksfriend.ORC.customemote = {}
RPWORDLIST.npctalksfriend.ORC.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.ORC = {}
RPWORDLIST.npctalksenemy.ORC.emote = {}
RPWORDLIST.npctalksenemy.ORC.customemote = {}
RPWORDLIST.npctalksenemy.ORC.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.ORC = {
	"All patched up and ready for action!",
	"Har!  Missed all my vital spots!",
	"Grrr, blacked out there for a minute!",
	"Thought I was done for sure that time.",
	"That's gonna leave a mark.",
	"Gonna have a great scar to show off!",
	}
RPWORDLIST.resurrect.ORC.emote = {}
RPWORDLIST.resurrect.ORC.customemote = {}
RPWORDLIST.resurrect.ORC.random = {}
