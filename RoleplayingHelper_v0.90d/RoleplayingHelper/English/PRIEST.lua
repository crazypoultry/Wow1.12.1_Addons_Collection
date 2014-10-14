--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.PRIEST = {
	"I see death in your near future.",
	"Forecast for your next few minutes, a few sprinkles of blood and a chance of doom!",
}
RPWORDLIST.entercombat.PRIEST.emote = {}    
RPWORDLIST.entercombat.PRIEST.customemote = {}
RPWORDLIST.entercombat.PRIEST.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.PRIEST = {
	"This trip to the next world brought to you by PLAYER_GUILDNAME.",
	"Are you still here? It's over, move on!",
}
RPWORDLIST.leavecombat.PRIEST.emote = {}
RPWORDLIST.leavecombat.PRIEST.customemote = {}
RPWORDLIST.leavecombat.PRIEST.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.PRIEST = {}
RPWORDLIST.hurt.PRIEST.emote = {}       
RPWORDLIST.hurt.PRIEST.customemote = {}
RPWORDLIST.hurt.PRIEST.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.PRIEST = {}
RPWORDLIST.absorb.PRIEST.emote = {} 
RPWORDLIST.absorb.PRIEST.customemote = {}
RPWORDLIST.absorb.PRIEST.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.PRIEST = {}
RPWORDLIST.block.PRIEST.emote = {} 
RPWORDLIST.block.PRIEST.customemote = {}
RPWORDLIST.block.PRIEST.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.PRIEST = {}
RPWORDLIST.dodge.PRIEST.emote = {}
RPWORDLIST.dodge.PRIEST.customemote = {}
RPWORDLIST.dodge.PRIEST.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.PRIEST = {}
RPWORDLIST.miss.PRIEST.emote = {} 
RPWORDLIST.miss.PRIEST.customemote = {}
RPWORDLIST.miss.PRIEST.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.PRIEST = {}
RPWORDLIST.parry.PRIEST.emote = {}
RPWORDLIST.parry.PRIEST.customemote = {}
RPWORDLIST.parry.PRIEST.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.PRIEST = {}
RPWORDLIST.youcrit.PRIEST.emote = {} 
RPWORDLIST.youcrit.PRIEST.customemote = {}
RPWORDLIST.youcrit.PRIEST.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.PRIEST = {}
RPWORDLIST.youcritspell.PRIEST.emote = {}
RPWORDLIST.youcritspell.PRIEST.customemote = {}
RPWORDLIST.youcritspell.PRIEST.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.PRIEST = {}
RPWORDLIST.youheal.PRIEST.emote = {}
RPWORDLIST.youheal.PRIEST.customemote = {}
RPWORDLIST.youheal.PRIEST.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.PRIEST = {}
RPWORDLIST.youcritheal.PRIEST.emote = {}
RPWORDLIST.youcritheal.PRIEST.customemote = {}
RPWORDLIST.youcritheal.PRIEST.random = {}

-- A PRIEST'S GAINS A PET WHEN THEY MIND CONTROL --

--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's possessive pronoun (his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.PRIEST = {}
RPWORDLIST.petattackstart.PRIEST.emote = {}
RPWORDLIST.petattackstart.PRIEST.customemote = {}
RPWORDLIST.petattackstart.PRIEST.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.PRIEST = {}
RPWORDLIST.petattackstop.PRIEST.emote = {} 
RPWORDLIST.petattackstop.PRIEST.customemote = {}
RPWORDLIST.petattackstop.PRIEST.random = {}
--=====================================================================--
-- When your PET DIES.
	-- PNAME = Pet's Name
--=====================================================================--
RPWORDLIST.petdies.PRIEST = {}
RPWORDLIST.petdies.PRIEST.emote = {}      
RPWORDLIST.petdies.PRIEST.customemote = {}
RPWORDLIST.petdies.PRIEST.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.PRIEST = {}
RPWORDLIST.npctalksfriend.PRIEST.emote = {}
RPWORDLIST.npctalksfriend.PRIEST.customemote = {}
RPWORDLIST.npctalksfriend.PRIEST.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.PRIEST = {}
RPWORDLIST.npctalksenemy.PRIEST.emote = {}
RPWORDLIST.npctalksenemy.PRIEST.customemote = {}
RPWORDLIST.npctalksenemy.PRIEST.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.PRIEST = {}
RPWORDLIST.resurrect.PRIEST.emote = {"PRAY"}
RPWORDLIST.resurrect.PRIEST.customemote = {}
RPWORDLIST.resurrect.PRIEST.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Priest Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Discipline
--=====================================================================--
RPWORDLIST.power_word_fortitude.PRIEST = {}
RPWORDLIST.power_word_fortitude.PRIEST.emote = {}
RPWORDLIST.power_word_fortitude.PRIEST.customemote = {}
RPWORDLIST.power_word_fortitude.PRIEST.random = {}

RPWORDLIST.power_word_shield.PRIEST = {}
RPWORDLIST.power_word_shield.PRIEST.emote = {}
RPWORDLIST.power_word_shield.PRIEST.customemote = {}
RPWORDLIST.power_word_shield.PRIEST.random = {}

RPWORDLIST.inner_fire.PRIEST = {}
RPWORDLIST.inner_fire.PRIEST.emote = {}
RPWORDLIST.inner_fire.PRIEST.customemote = {"glows with an Inner Fire.",}
RPWORDLIST.inner_fire.PRIEST.random = {} 

RPWORDLIST.dispel_magic.PRIEST = {}
RPWORDLIST.dispel_magic.PRIEST.emote = {}
RPWORDLIST.dispel_magic.PRIEST.customemote = {}
RPWORDLIST.dispel_magic.PRIEST.random = {}

RPWORDLIST.inner_focus.PRIEST = {}
RPWORDLIST.inner_focus.PRIEST.emote = {}
RPWORDLIST.inner_focus.PRIEST.customemote = {}
RPWORDLIST.inner_focus.PRIEST.random = {}

RPWORDLIST.shackle_undead.PRIEST = {}
RPWORDLIST.shackle_undead.PRIEST.emote = {}
RPWORDLIST.shackle_undead.PRIEST.customemote = {}
RPWORDLIST.shackle_undead.PRIEST.random = {}

RPWORDLIST.mana_burn.PRIEST = {}
RPWORDLIST.mana_burn.PRIEST.emote = {}
RPWORDLIST.mana_burn.PRIEST.customemote = {}
RPWORDLIST.mana_burn.PRIEST.random = {}

RPWORDLIST.divine_spirit.PRIEST = {}
RPWORDLIST.divine_spirit.PRIEST.emote = {}
RPWORDLIST.divine_spirit.PRIEST.customemote = {}
RPWORDLIST.divine_spirit.PRIEST.random = {}

RPWORDLIST.power_infusion.PRIEST = {}
RPWORDLIST.power_infusion.PRIEST.emote = {}
RPWORDLIST.power_infusion.PRIEST.customemote = {}
RPWORDLIST.power_infusion.PRIEST.random = {}

RPWORDLIST.levitate.PRIEST = {}
RPWORDLIST.levitate.PRIEST.emote = {}
RPWORDLIST.levitate.PRIEST.customemote = {}
RPWORDLIST.levitate.PRIEST.random = {}

RPWORDLIST.prayer_of_fortitude.PRIEST = {}
RPWORDLIST.prayer_of_fortitude.PRIEST.emote = {}
RPWORDLIST.prayer_of_fortitude.PRIEST.customemote = {}
RPWORDLIST.prayer_of_fortitude.PRIEST.random = {}

-- Night Elf Only
RPWORDLIST.starshards.PRIEST = {}
RPWORDLIST.starshards.PRIEST.customemote = {}
RPWORDLIST.starshards.PRIEST.random = {}

RPWORDLIST.elunes_grace.PRIEST = {}
RPWORDLIST.elunes_grace.PRIEST.emote = {}
RPWORDLIST.elunes_grace.PRIEST.customemote = {}
RPWORDLIST.elunes_grace.PRIEST.random = {}

-- Human Only
RPWORDLIST.feedback.PRIEST = {}
RPWORDLIST.feedback.PRIEST.emote = {}
RPWORDLIST.feedback.PRIEST.customemote = {}
RPWORDLIST.feedback.PRIEST.random = {}
--=====================================================================--
-- Holy
--=====================================================================-- 
RPWORDLIST.lesser_heal.PRIEST = {}
RPWORDLIST.lesser_heal.PRIEST.emote = {}
RPWORDLIST.lesser_heal.PRIEST.customemote = {}
RPWORDLIST.lesser_heal.PRIEST.random = {}

RPWORDLIST.renew.PRIEST = {}
RPWORDLIST.renew.PRIEST.emote = {}
RPWORDLIST.renew.PRIEST.customemote = {}
RPWORDLIST.renew.PRIEST.random = {}

RPWORDLIST.heal.PRIEST = {}
RPWORDLIST.heal.PRIEST.emote = {}
RPWORDLIST.heal.PRIEST.customemote = {}
RPWORDLIST.heal.PRIEST.random = {}

RPWORDLIST.flash_heal.PRIEST = {}
RPWORDLIST.flash_heal.PRIEST.emote = {}
RPWORDLIST.flash_heal.PRIEST.customemote = {}
RPWORDLIST.flash_heal.PRIEST.random = {}

RPWORDLIST.prayer_of_healing.PRIEST = {}
RPWORDLIST.prayer_of_healing.PRIEST.emote = {}
RPWORDLIST.prayer_of_healing.PRIEST.customemote = {}
RPWORDLIST.prayer_of_healing.PRIEST.random = {}

RPWORDLIST.greater_heal.PRIEST = {}
RPWORDLIST.greater_heal.PRIEST.emote = {}
RPWORDLIST.greater_heal.PRIEST.customemote = {}
RPWORDLIST.greater_heal.PRIEST.random = {}
-------------------------------------------------------------------------
RPWORDLIST.cure_disease.PRIEST = {}
RPWORDLIST.cure_disease.PRIEST.emote = {}
RPWORDLIST.cure_disease.PRIEST.customemote = {}
RPWORDLIST.cure_disease.PRIEST.random = {}

RPWORDLIST.abolish_disease.PRIEST = {}
RPWORDLIST.abolish_disease.PRIEST.emote = {}
RPWORDLIST.abolish_disease.PRIEST.customemote = {}
RPWORDLIST.abolish_disease.PRIEST.random = {}
-------------------------------------------------------------------------
RPWORDLIST.smite.PRIEST = {}
RPWORDLIST.smite.PRIEST.emote = {}
RPWORDLIST.smite.PRIEST.customemote = {}
RPWORDLIST.smite.PRIEST.random = {}

RPWORDLIST.resurrection.PRIEST = {"TARGET, your service in this world is not yet finished, awaken!",}
RPWORDLIST.resurrection.PRIEST.emote = {}
RPWORDLIST.resurrection.PRIEST.customemote = {}
RPWORDLIST.resurrection.PRIEST.random = {}

RPWORDLIST.holy_nova.PRIEST = {}
RPWORDLIST.holy_nova.PRIEST.emote = {}
RPWORDLIST.holy_nova.PRIEST.customemote = {}
RPWORDLIST.holy_nova.PRIEST.random = {}

RPWORDLIST.holy_fire.PRIEST = {}
RPWORDLIST.holy_fire.PRIEST.emote = {}
RPWORDLIST.holy_fire.PRIEST.customemote = {}
RPWORDLIST.holy_fire.PRIEST.random = {}

RPWORDLIST.spirit_of_redemption.PRIEST = {}
RPWORDLIST.spirit_of_redemption.PRIEST.emote = {}
RPWORDLIST.spirit_of_redemption.PRIEST.customemote = {}
RPWORDLIST.spirit_of_redemption.PRIEST.random = {}

RPWORDLIST.lightwell.PRIEST = {}
RPWORDLIST.lightwell.PRIEST.emote = {}
RPWORDLIST.lightwell.PRIEST.customemote = {}
RPWORDLIST.lightwell.PRIEST.random = {}

-- Human and Dwarf Only
RPWORDLIST.desperate_prayer.PRIEST = {}
RPWORDLIST.desperate_prayer.PRIEST.emote = {"PRAY",}
RPWORDLIST.desperate_prayer.PRIEST.customemote = {}
RPWORDLIST.desperate_prayer.PRIEST.random = {} 

-- Dwarf Only
RPWORDLIST.fear_ward.PRIEST = {}
RPWORDLIST.fear_ward.PRIEST.emote = {}
RPWORDLIST.fear_ward.PRIEST.customemote = {}
RPWORDLIST.fear_ward.PRIEST.random = {}

--=====================================================================--
-- Shadow Magic
--=====================================================================--
RPWORDLIST.shadow_word_pain.PRIEST = {}
RPWORDLIST.shadow_word_pain.PRIEST.emote = {}
RPWORDLIST.shadow_word_pain.PRIEST.customemote = {}
RPWORDLIST.shadow_word_pain.PRIEST.random = {}

RPWORDLIST.fade.PRIEST = {}
RPWORDLIST.fade.PRIEST.emote = {}
RPWORDLIST.fade.PRIEST.customemote = {}
RPWORDLIST.fade.PRIEST.random = {}

RPWORDLIST.mind_blast.PRIEST = {}
RPWORDLIST.mind_blast.PRIEST.emote = {}
RPWORDLIST.mind_blast.PRIEST.customemote = {"hands glow with a dark magic.",}
RPWORDLIST.mind_blast.PRIEST.random = {} 

RPWORDLIST.psychic_scream.PRIEST = {"Get away from me!",}
RPWORDLIST.psychic_scream.PRIEST.emote = {}
RPWORDLIST.psychic_scream.PRIEST.customemote = {} 
RPWORDLIST.psychic_scream.PRIEST.random = {}

RPWORDLIST.mind_flay.PRIEST = {}
RPWORDLIST.mind_flay.PRIEST.emote = {}
RPWORDLIST.mind_flay.PRIEST.customemote = {}
RPWORDLIST.mind_flay.PRIEST.random = {}

RPWORDLIST.mind_soothe.PRIEST = {}
RPWORDLIST.mind_soothe.PRIEST.emote = {}
RPWORDLIST.mind_soothe.PRIEST.customemote = {}
RPWORDLIST.mind_soothe.PRIEST.random = {}

RPWORDLIST.shadowguard.PRIEST = {}
RPWORDLIST.shadowguard.PRIEST.emote = {}
RPWORDLIST.shadowguard.PRIEST.customemote = {}
RPWORDLIST.shadowguard.PRIEST.random = {}

RPWORDLIST.mind_vision.PRIEST = {"Allow me to see though your eyes, TARGET",}
RPWORDLIST.mind_vision.PRIEST.emote = {}
RPWORDLIST.mind_vision.PRIEST.customemote = {}
RPWORDLIST.mind_vision.PRIEST.random = {} 

RPWORDLIST.mind_control.PRIEST = {"Do not resist TARGET, it is Futile!",}
RPWORDLIST.mind_control.PRIEST.emote = {}
RPWORDLIST.mind_control.PRIEST.customemote = {}
RPWORDLIST.mind_control.PRIEST.random = {} 

RPWORDLIST.shadow_protection.PRIEST = {}
RPWORDLIST.shadow_protection.PRIEST.emote = {}
RPWORDLIST.shadow_protection.PRIEST.customemote = {}
RPWORDLIST.shadow_protection.PRIEST.random = {}

RPWORDLIST.silence.PRIEST = {}
RPWORDLIST.silence.PRIEST.emote = {}
RPWORDLIST.silence.PRIEST.customemote = {}
RPWORDLIST.silence.PRIEST.random = {}

RPWORDLIST.vampiric_embrace.PRIEST = {}
RPWORDLIST.vampiric_embrace.PRIEST.emote = {}
RPWORDLIST.vampiric_embrace.PRIEST.customemote = {}
RPWORDLIST.vampiric_embrace.PRIEST.random = {}

RPWORDLIST.shadowform.PRIEST = {}
RPWORDLIST.shadowform.PRIEST.emote = {}
RPWORDLIST.shadowform.PRIEST.customemote = {"entire body becomes engulfed in pure shadow.",}
RPWORDLIST.shadowform.PRIEST.random = {} 

-- Troll Only
RPWORDLIST.hex_of_weakness.PRIEST = {}
RPWORDLIST.hex_of_weakness.PRIEST.emote = {}
RPWORDLIST.hex_of_weakness.PRIEST.customemote = {}
RPWORDLIST.hex_of_weakness.PRIEST.random = {}

RPWORDLIST.shadowguard.PRIEST = {}
RPWORDLIST.shadowguard.PRIEST.emote = {}
RPWORDLIST.shadowguard.PRIEST.customemote = {}
RPWORDLIST.shadowguard.PRIEST.random = {}

-- Undead Only
RPWORDLIST.touch_of_weakness.PRIEST = {}
RPWORDLIST.touch_of_weakness.PRIEST.emote = {}
RPWORDLIST.touch_of_weakness.PRIEST.customemote = {}
RPWORDLIST.touch_of_weakness.PRIEST.random = {}

RPWORDLIST.devouring_plague.PRIEST = {}
RPWORDLIST.devouring_plague.PRIEST.emote = {}
RPWORDLIST.devouring_plague.PRIEST.customemote = {}
RPWORDLIST.devouring_plague.PRIEST.random = {}

