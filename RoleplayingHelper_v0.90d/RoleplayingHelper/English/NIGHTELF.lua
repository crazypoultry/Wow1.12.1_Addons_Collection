--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Contributors to this file:  mithyk, Syrsa

--=====================================================================--
-- Night Elf racial ability: Shadowmeld
--=====================================================================--
RPWORDLIST.shadowmeld.NIGHTELF = {}
RPWORDLIST.shadowmeld.NIGHTELF.emote = {}
RPWORDLIST.shadowmeld.NIGHTELF.customemote = {"fades into the shadows.", "disappears for a bit.", "thinks SP'll hide now."}
RPWORDLIST.shadowmeld.NIGHTELF.random = {}

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.NIGHTELF = {
    "For Cenarius!",
	"In the name of Goddess!",
	"By Elune!",
	"We can overcome these foul creatures!",
	"Elune, give me strength!",
	"For nature's survival!",
	"You will perish!",
	"Elune, grant me swift victory!",
}
RPWORDLIST.entercombat.NIGHTELF.emote = {}
RPWORDLIST.entercombat.NIGHTELF.customemote = {}
RPWORDLIST.entercombat.NIGHTELF.random = {

	["phrase"] = "You BLANK BLANK BLANK",

	[1] = {"shall","will","must" },

	[2] = {"be cleansed","be purified","die", },

	[3] = {"in the name of Elune.","in the name of the Goddess.","for the Goddess."},

	}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.NIGHTELF = {}
RPWORDLIST.leavecombat.NIGHTELF.emote = {}
RPWORDLIST.leavecombat.NIGHTELF.customemote = {}
RPWORDLIST.leavecombat.NIGHTELF.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.NIGHTELF = {}
RPWORDLIST.hurt.NIGHTELF.emote = {"BLEED",}
RPWORDLIST.hurt.NIGHTELF.customemote = {}
RPWORDLIST.hurt.NIGHTELF.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.NIGHTELF = {}
RPWORDLIST.absorb.NIGHTELF.emote = {}
RPWORDLIST.absorb.NIGHTELF.customemote = {}
RPWORDLIST.absorb.NIGHTELF.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.NIGHTELF = {}
RPWORDLIST.block.NIGHTELF.emote = {}
RPWORDLIST.block.NIGHTELF.customemote = {}
RPWORDLIST.block.NIGHTELF.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.NIGHTELF = {}
RPWORDLIST.dodge.NIGHTELF.emote = {}
RPWORDLIST.dodge.NIGHTELF.customemote = {}
RPWORDLIST.dodge.NIGHTELF.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.NIGHTELF = {}
RPWORDLIST.miss.NIGHTELF.emote = {}
RPWORDLIST.miss.NIGHTELF.customemote = {}
RPWORDLIST.miss.NIGHTELF.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.NIGHTELF = {}
RPWORDLIST.parry.NIGHTELF.emote = {}
RPWORDLIST.parry.NIGHTELF.customemote = {}
RPWORDLIST.parry.NIGHTELF.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.NIGHTELF = {}
RPWORDLIST.youcrit.NIGHTELF.emote = {}
RPWORDLIST.youcrit.NIGHTELF.customemote = {}
RPWORDLIST.youcrit.NIGHTELF.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.NIGHTELF = {}
RPWORDLIST.youcritspell.NIGHTELF.emote = {}
RPWORDLIST.youcritspell.NIGHTELF.customemote = {}
RPWORDLIST.youcritspell.NIGHTELF.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.NIGHTELF = {}
RPWORDLIST.youheal.NIGHTELF.emote = {}
RPWORDLIST.youheal.NIGHTELF.customemote = {}
RPWORDLIST.youheal.NIGHTELF.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.NIGHTELF = {}
RPWORDLIST.youcritheal.NIGHTELF.emote = {}
RPWORDLIST.youcritheal.NIGHTELF.customemote = {}
RPWORDLIST.youcritheal.NIGHTELF.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.NIGHTELF = {}
RPWORDLIST.petattackstart.NIGHTELF.emote = {}
RPWORDLIST.petattackstart.NIGHTELF.customemote = {}
RPWORDLIST.petattackstart.NIGHTELF.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.NIGHTELF = {}
RPWORDLIST.petattackstop.NIGHTELF.emote = {}
RPWORDLIST.petattackstop.NIGHTELF.customemote = {}
RPWORDLIST.petattackstop.NIGHTELF.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.NIGHTELF = {}
RPWORDLIST.petdies.NIGHTELF.emote = {}
RPWORDLIST.petdies.NIGHTELF.customemote = {}
RPWORDLIST.petdies.NIGHTELF.random = {}
--=====================================================================--
-- When you talk to an NPC  (A dialogue/merchant/quest/etc. box opens)
--=====================================================================--
-------------------------------------------------------------------------
-- The BEGINNING of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
	-- "KNEEL" is automatically added if the NPC is 5 levels higher than you
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_beginning.NIGHTELF = {
 	"TARGET, well met.",
	"Elune be with you, TARGET.",
	"TARGET, Goddess bless you.",
	"Ish'nu Al'ah TARGET.",
	"TARGET, I am honored.",
	"Peace be with you, TARGET.",
	"Elune Adore TARGET.",
}
RPWORDLIST.talktonpc_beginning.NIGHTELF.emote = {}
RPWORDLIST.talktonpc_beginning.NIGHTELF.customemote = {}
RPWORDLIST.talktonpc_beginning.NIGHTELF.random = {}
-------------------------------------------------------------------------
-- The MIDDLE of a conversation with an NPC
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_middle.NIGHTELF = {}
RPWORDLIST.talktonpc_middle.NIGHTELF.emote = {}
RPWORDLIST.talktonpc_middle.NIGHTELF.customemote = {}
RPWORDLIST.talktonpc_middle.NIGHTELF.random = {}
-------------------------------------------------------------------------
-- The END of a conversation with an NPC
	-- "CURTSEY" is automatically added for female characters
-------------------------------------------------------------------------
RPWORDLIST.talktonpc_end.NIGHTELF = {
	"TARGET, till next we meet.",
	"TARGET, safe travels.",
	"Farewell, TARGET.",
	"TARGET, go in peace.",
	"TARGET, Elune light your path.",
	"Elune light your path, TARGET.",
	"TARGET, Goddess watch over you.",
	"TARGET, may the stars guide you.",
	"En'shu fallah'na TARGET.",
	"Del nodres TARGET.",
}
RPWORDLIST.talktonpc_end.NIGHTELF.emote = {}
RPWORDLIST.talktonpc_end.NIGHTELF.customemote = {}
RPWORDLIST.talktonpc_end.NIGHTELF.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.NIGHTELF = {}
RPWORDLIST.npctalksfriend.NIGHTELF.emote = {}
RPWORDLIST.npctalksfriend.NIGHTELF.customemote = {}
RPWORDLIST.npctalksfriend.NIGHTELF.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.NIGHTELF = {}
RPWORDLIST.npctalksenemy.NIGHTELF.emote = {}
RPWORDLIST.npctalksenemy.NIGHTELF.customemote = {}
RPWORDLIST.npctalksenemy.NIGHTELF.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.NIGHTELF = {
	"For but a brief moment, I felt the presence of Elune.",
	"For a moment, I felt the presence of Elune.",
	"Praise the Goddess!"
	}
RPWORDLIST.resurrect.NIGHTELF.emote = {"PRAY"}
RPWORDLIST.resurrect.NIGHTELF.customemote = {}
RPWORDLIST.resurrect.NIGHTELF.random = {

	["phrase"] = "BLANK BLANK",

	[1] = {"Thanks to Elune,","By the Goddess' mercy,","Elune has smiled upon me and now","By the Goddess' will,"},

	[2] = {"I'm alive.","I live again.","my life has been spared.","I am mortal once again.","I am once again connected to this earth."},

	}

--=====================================================================--
--  Trade Window Opens
--=====================================================================--
RPWORDLIST.trade_show.NIGHTELF = {
    "Well met, TARGET.",
    "Elune be with you, TARGET.",
	"TARGET, Goddess bless you.",
	"Ish'nu Al'ah TARGET.",
	"TARGET, I am honored.",
	"Peace be with you, TARGET.",
	"Elune Adore TARGET.",
    }
RPWORDLIST.trade_show.NIGHTELF.emote = {"GREET"}
RPWORDLIST.trade_show.NIGHTELF.customemote = {}
RPWORDLIST.trade_show.NIGHTELF.random = {}

--=====================================================================--
--  Trade Window Closes
--=====================================================================--
RPWORDLIST.trade_closed.NIGHTELF = {
    "TARGET, till next we meet.",
	"TARGET, safe travels.",
	"Farewell, TARGET.",
	"TARGET, go in peace.",
	"TARGET, Elune light your path.",
	"Elune light your path, TARGET.",
	"TARGET, Goddess watch over you.",
	"TARGET, may the stars guide you.",
	"En'shu fallah'na TARGET.",
	"Del nodres TARGET.",
    }
RPWORDLIST.trade_closed.NIGHTELF.emote = {"THANK"}
RPWORDLIST.trade_closed.NIGHTELF.customemote = {}
RPWORDLIST.trade_closed.NIGHTELF.random = {}
