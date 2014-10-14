--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:   mithyk

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.DWARF = {
	"There's nothin' more motivating than fightin' with a bad hangover",
	"Where's meh' drink?",
	"You'll take meh' weapon when you PRY IT FROM MY COLD DEAD HANDS!",
	"For Khaz modan!",
	"Feel the fury of the mountain!",
	"Let me at 'em!",
	"To arms!",
	"I came here to kick tail and drink ale, and I'm all outta ale!",
}
RPWORDLIST.entercombat.DWARF.emote = {"guffaw SELF","laugh SELF","crack",}
RPWORDLIST.entercombat.DWARF.customemote = {}
RPWORDLIST.entercombat.DWARF.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.DWARF = {}
RPWORDLIST.leavecombat.DWARF.emote = {}
RPWORDLIST.leavecombat.DWARF.customemote = {}
RPWORDLIST.leavecombat.DWARF.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.DWARF = {}
RPWORDLIST.hurt.DWARF.emote = {"BLEED",}
RPWORDLIST.hurt.DWARF.customemote = {}
RPWORDLIST.hurt.DWARF.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.DWARF = { "Har! I've met gnomes that are tougher than you!", }
RPWORDLIST.absorb.DWARF.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.absorb.DWARF.customemote = {}
RPWORDLIST.absorb.DWARF.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.DWARF = {}
RPWORDLIST.block.DWARF.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.block.DWARF.customemote = {}
RPWORDLIST.block.DWARF.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.DWARF = {}
RPWORDLIST.dodge.DWARF.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.dodge.DWARF.customemote = {}
RPWORDLIST.dodge.DWARF.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.DWARF = {}
RPWORDLIST.miss.DWARF.emote = {}
RPWORDLIST.miss.DWARF.customemote = {}
RPWORDLIST.miss.DWARF.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.DWARF = {}
RPWORDLIST.parry.DWARF.emote = {}
RPWORDLIST.parry.DWARF.customemote = {}
RPWORDLIST.parry.DWARF.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.DWARF = {}
RPWORDLIST.youcrit.DWARF.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.youcrit.DWARF.customemote = {}
RPWORDLIST.youcrit.DWARF.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.DWARF = {}
RPWORDLIST.youcritspell.DWARF.emote = {"laugh SELF","guffaw SELF",}
RPWORDLIST.youcritspell.DWARF.customemote = {}
RPWORDLIST.youcritspell.DWARF.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.DWARF = {}
RPWORDLIST.youheal.DWARF.emote = {}
RPWORDLIST.youheal.DWARF.customemote = {}
RPWORDLIST.youheal.DWARF.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.DWARF = {}
RPWORDLIST.youcritheal.DWARF.emote = {}
RPWORDLIST.youcritheal.DWARF.customemote = {}
RPWORDLIST.youcritheal.DWARF.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.DWARF = {}
RPWORDLIST.petattackstart.DWARF.emote = {}
RPWORDLIST.petattackstart.DWARF.customemote = {}
RPWORDLIST.petattackstart.DWARF.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.DWARF = {}
RPWORDLIST.petattackstop.DWARF.emote = {}
RPWORDLIST.petattackstop.DWARF.customemote = {}
RPWORDLIST.petattackstop.DWARF.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.DWARF = {}
RPWORDLIST.petdies.DWARF.emote = {}
RPWORDLIST.petdies.DWARF.customemote = {}
RPWORDLIST.petdies.DWARF.random = {}
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.DWARF = {
	"TARGET, well met.",
	"Well met, good TARGET.",
	"TARGET, let us share a pint and talk.",
}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.DWARF = {
	"TARGET, till next we meet.",
	"TARGET, see ya soon.",
	"TARGET, safe travels.",
	"TARGET, be good.",
	"TARGET, I'm off.",
	"TARGET, keep yer feet on the ground.",
}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.DWARF = {}
RPWORDLIST.npctalksfriend.DWARF.emote = {}
RPWORDLIST.npctalksfriend.DWARF.customemote = {}
RPWORDLIST.npctalksfriend.DWARF.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.DWARF = {}
RPWORDLIST.npctalksenemy.DWARF.emote = {}
RPWORDLIST.npctalksenemy.DWARF.customemote = {}
RPWORDLIST.npctalksenemy.DWARF.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.DWARF = {
	"All patched up and ready for action!",
	"Wounds bandaged, ready for action!",
	"Har! Missed all my vital spots!",
	"Hrrmm, blacked out there for a minute!",
	"My vision dimmed for a moment.",
	"Thought I was done for sure that time.",
	"That's going to leave a mark.",
	"I will bear this scar with pride.",
}
RPWORDLIST.resurrect.DWARF.emote = {}
RPWORDLIST.resurrect.DWARF.customemote = {}
RPWORDLIST.resurrect.DWARF.random = {}
