--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.PALADIN = {
	"I will bring honor to my family and my kingdom!",
	"Light, guide my blade!",
	"Light, give me strength!",
	"My strength is the holy light!",
	"My church is the field of battle - time to worship...",
	"It's hammer time!",
	"I hold you in contempt...",
	"Shall I be your executioner?",
	"Face the hammer of justice!",
	"Come then, shadow spawn!",
	"Prove your worth in the test of arms under the light!",
	"Might I have the pleasure of your name before I crush your skull?",
	"All must fall before the might and right of my cause, you shall be next!",
	"I'm afraid I'm gonna have to kill you now.",
	"Prepare to die!",
	"I must swat you like the insignificant insect you are!",
}
RPWORDLIST.entercombat.PALADIN.emote = {"CHARGE SELF",} 
RPWORDLIST.entercombat.PALADIN.customemote = {}
RPWORDLIST.entercombat.PALADIN.random = {}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.PALADIN = {
	"My thanks for the lively scrap.",
}
RPWORDLIST.leavecombat.PALADIN.emote = {}  
RPWORDLIST.leavecombat.PALADIN.customemote = {}
RPWORDLIST.leavecombat.PALADIN.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.PALADIN = {}
RPWORDLIST.hurt.PALADIN.emote = {}        
RPWORDLIST.hurt.PALADIN.customemote = {}
RPWORDLIST.hurt.PALADIN.random = {}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.PALADIN = {}
RPWORDLIST.absorb.PALADIN.emote = {}   
RPWORDLIST.absorb.PALADIN.customemote = {}
RPWORDLIST.absorb.PALADIN.random = {}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.PALADIN = {}
RPWORDLIST.block.PALADIN.emote = {}  
RPWORDLIST.block.PALADIN.customemote = {}
RPWORDLIST.block.PALADIN.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.PALADIN = {}
RPWORDLIST.dodge.PALADIN.emote = {}   
RPWORDLIST.dodge.PALADIN.customemote = {}
RPWORDLIST.dodge.PALADIN.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.PALADIN = {}
RPWORDLIST.miss.PALADIN.emote = {}
RPWORDLIST.miss.PALADIN.customemote = {}
RPWORDLIST.miss.PALADIN.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.PALADIN = {}
RPWORDLIST.parry.PALADIN.emote = {} 
RPWORDLIST.parry.PALADIN.customemote = {}
RPWORDLIST.parry.PALADIN.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.PALADIN = {
	"The vultures begin circling over you.",
	"You will pay in blood for your foolishness.",
	"You are beaten, it is useless to resist.",
}
RPWORDLIST.youcrit.PALADIN.emote = {}  
RPWORDLIST.youcrit.PALADIN.customemote = {}
RPWORDLIST.youcrit.PALADIN.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.PALADIN = {}
RPWORDLIST.youcritspell.PALADIN.emote = {}
RPWORDLIST.youcritspell.PALADIN.customemote = {}
RPWORDLIST.youcritspell.PALADIN.random = {}
--=====================================================================--
-- HEAL: You heal someone else
--=====================================================================--
RPWORDLIST.youheal.PALADIN = {}
RPWORDLIST.youheal.PALADIN.emote = {}
RPWORDLIST.youheal.PALADIN.customemote = {}
RPWORDLIST.youheal.PALADIN.random = {}
--=====================================================================--
-- CRIT HEAL: You critically heal someone else
--=====================================================================--
RPWORDLIST.youcritheal.PALADIN = {}
RPWORDLIST.youcritheal.PALADIN.emote = {}
RPWORDLIST.youcritheal.PALADIN.customemote = {}
RPWORDLIST.youcritheal.PALADIN.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.PALADIN = {}
RPWORDLIST.npctalksfriend.PALADIN.emote = {}
RPWORDLIST.npctalksfriend.PALADIN.customemote = {}
RPWORDLIST.npctalksfriend.PALADIN.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.PALADIN = {}
RPWORDLIST.npctalksenemy.PALADIN.emote = {}
RPWORDLIST.npctalksenemy.PALADIN.customemote = {}
RPWORDLIST.npctalksenemy.PALADIN.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.PALADIN = {
	"By the light!  I'm alive!",
	"The light has brought me back.",
	"The light has seen fit for me to live again.",
	}
RPWORDLIST.resurrect.PALADIN.emote = {"PRAY",} 
RPWORDLIST.resurrect.PALADIN.customemote = {}
RPWORDLIST.resurrect.PALADIN.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Paladin Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Protection
--=====================================================================--
RPWORDLIST.devotion_aura.PALADIN = {}
RPWORDLIST.devotion_aura.PALADIN.emote = {}
RPWORDLIST.devotion_aura.PALADIN.customemote = {}
RPWORDLIST.devotion_aura.PALADIN.random = {}

RPWORDLIST.divine_protection.PALADIN = {}
RPWORDLIST.divine_protection.PALADIN.emote = {}
RPWORDLIST.divine_protection.PALADIN.customemote = {}
RPWORDLIST.divine_protection.PALADIN.random = {}

RPWORDLIST.hammer_of_justice.PALADIN = {}
RPWORDLIST.hammer_of_justice.PALADIN.emote = {}
RPWORDLIST.hammer_of_justice.PALADIN.customemote = {}
RPWORDLIST.hammer_of_justice.PALADIN.random = {}

RPWORDLIST.blessing_of_protection.PALADIN = {}
RPWORDLIST.blessing_of_protection.PALADIN.emote = {}
RPWORDLIST.blessing_of_protection.PALADIN.customemote = {}
RPWORDLIST.blessing_of_protection.PALADIN.random = {}

RPWORDLIST.righteous_fury.PALADIN = {}
RPWORDLIST.righteous_fury.PALADIN.emote = {}
RPWORDLIST.righteous_fury.PALADIN.customemote = {}
RPWORDLIST.righteous_fury.PALADIN.random = {}

RPWORDLIST.blessing_of_freedom.PALADIN = {}
RPWORDLIST.blessing_of_freedom.PALADIN.emote = {}
RPWORDLIST.blessing_of_freedom.PALADIN.customemote = {}
RPWORDLIST.blessing_of_freedom.PALADIN.random = {}

RPWORDLIST.blessing_of_kings.PALADIN = {}
RPWORDLIST.blessing_of_kings.PALADIN.emote = {}
RPWORDLIST.blessing_of_kings.PALADIN.customemote = {}
RPWORDLIST.blessing_of_kings.PALADIN.random = {}

RPWORDLIST.concentration_aura.PALADIN = {}
RPWORDLIST.concentration_aura.PALADIN.emote = {}
RPWORDLIST.concentration_aura.PALADIN.customemote = {}
RPWORDLIST.concentration_aura.PALADIN.random = {}

RPWORDLIST.seal_of_justice.PALADIN = {}
RPWORDLIST.seal_of_justice.PALADIN.emote = {}
RPWORDLIST.seal_of_justice.PALADIN.customemote = {}
RPWORDLIST.seal_of_justice.PALADIN.random = {}

RPWORDLIST.blessing_of_salvation.PALADIN = {}
RPWORDLIST.blessing_of_salvation.PALADIN.emote = {}
RPWORDLIST.blessing_of_salvation.PALADIN.customemote = {}
RPWORDLIST.blessing_of_salvation.PALADIN.random = {}

RPWORDLIST.shadow_resistance_aura.PALADIN = {}
RPWORDLIST.shadow_resistance_aura.PALADIN.emote = {}
RPWORDLIST.shadow_resistance_aura.PALADIN.customemote = {}
RPWORDLIST.shadow_resistance_aura.PALADIN.random = {}

RPWORDLIST.blessing_of_sanctuary.PALADIN = {}
RPWORDLIST.blessing_of_sanctuary.PALADIN.emote = {}
RPWORDLIST.blessing_of_sanctuary.PALADIN.customemote = {}
RPWORDLIST.blessing_of_sanctuary.PALADIN.random = {}

RPWORDLIST.divine_intervention.PALADIN = {}
RPWORDLIST.divine_intervention.PALADIN.emote = {}
RPWORDLIST.divine_intervention.PALADIN.customemote = {}
RPWORDLIST.divine_intervention.PALADIN.random = {}

RPWORDLIST.frost_resistance_aura.PALADIN = {}
RPWORDLIST.frost_resistance_aura.PALADIN.emote = {}
RPWORDLIST.frost_resistance_aura.PALADIN.customemote = {}
RPWORDLIST.frost_resistance_aura.PALADIN.random = {}

RPWORDLIST.divine_shield.PALADIN = {}
RPWORDLIST.divine_shield.PALADIN.emote = {}
RPWORDLIST.divine_shield.PALADIN.customemote = {}
RPWORDLIST.divine_shield.PALADIN.random = {}

RPWORDLIST.fire_resistance_aura.PALADIN = {}
RPWORDLIST.fire_resistance_aura.PALADIN.emote = {}
RPWORDLIST.fire_resistance_aura.PALADIN.customemote = {}
RPWORDLIST.fire_resistance_aura.PALADIN.random = {}

RPWORDLIST.holy_shield.PALADIN = {}
RPWORDLIST.holy_shield.PALADIN.emote = {}
RPWORDLIST.holy_shield.PALADIN.customemote = {}
RPWORDLIST.holy_shield.PALADIN.random = {}

RPWORDLIST.blessing_of_sacrifice.PALADIN = {}
RPWORDLIST.blessing_of_sacrifice.PALADIN.emote = {}
RPWORDLIST.blessing_of_sacrifice.PALADIN.customemote = {}
RPWORDLIST.blessing_of_sacrifice.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_kings.PALADIN = {}
RPWORDLIST.greater_blessing_of_kings.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_kings.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_kings.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_salvation.PALADIN = {}
RPWORDLIST.greater_blessing_of_salvation.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_salvation.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_salvation.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_sanctuary.PALADIN = {}
RPWORDLIST.greater_blessing_of_sanctuary.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_sanctuary.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_sanctuary.PALADIN.random = {}
--=====================================================================--
-- Retribution
--=====================================================================--
RPWORDLIST.blessing_of_might.PALADIN = {}
RPWORDLIST.blessing_of_might.PALADIN.emote = {}
RPWORDLIST.blessing_of_might.PALADIN.customemote = {}
RPWORDLIST.blessing_of_might.PALADIN.random = {}

RPWORDLIST.judgement.PALADIN = {}
RPWORDLIST.judgement.PALADIN.emote = {}
RPWORDLIST.judgement.PALADIN.customemote = {}
RPWORDLIST.judgement.PALADIN.random = {}

RPWORDLIST.seal_of_the_crusader.PALADIN = {}
RPWORDLIST.seal_of_the_crusader.PALADIN.emote = {}
RPWORDLIST.seal_of_the_crusader.PALADIN.customemote = {}
RPWORDLIST.seal_of_the_crusader.PALADIN.random = {}

RPWORDLIST.retribution_aura.PALADIN = {}
RPWORDLIST.retribution_aura.PALADIN.emote = {}
RPWORDLIST.retribution_aura.PALADIN.customemote = {}
RPWORDLIST.retribution_aura.PALADIN.random = {}

RPWORDLIST.seal_of_command.PALADIN = {}
RPWORDLIST.seal_of_command.PALADIN.emote = {}
RPWORDLIST.seal_of_command.PALADIN.customemote = {}
RPWORDLIST.seal_of_command.PALADIN.random = {}

RPWORDLIST.sanctity_aura.PALADIN = {}
RPWORDLIST.sanctity_aura.PALADIN.emote = {}
RPWORDLIST.sanctity_aura.PALADIN.customemote = {}
RPWORDLIST.sanctity_aura.PALADIN.random = {}

RPWORDLIST.repentance.PALADIN = {}
RPWORDLIST.repentance.PALADIN.emote = {}
RPWORDLIST.repentance.PALADIN.customemote = {}
RPWORDLIST.repentance.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_might.PALADIN = {}
RPWORDLIST.greater_blessing_of_might.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_might.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_might.PALADIN.random = {}
--=====================================================================--
-- Holy                                                                  
--=====================================================================--
RPWORDLIST.holy_light.PALADIN = {}
RPWORDLIST.holy_light.PALADIN.emote = {}
RPWORDLIST.holy_light.PALADIN.customemote = {}
RPWORDLIST.holy_light.PALADIN.random = {}

RPWORDLIST.purify.PALADIN = {}
RPWORDLIST.purify.PALADIN.emote = {}
RPWORDLIST.purify.PALADIN.customemote = {}
RPWORDLIST.purify.PALADIN.random = {}

RPWORDLIST.lay_on_hands.PALADIN = {}
RPWORDLIST.lay_on_hands.PALADIN.emote = {}
RPWORDLIST.lay_on_hands.PALADIN.customemote = {}
RPWORDLIST.lay_on_hands.PALADIN.random = {}

RPWORDLIST.seal_of_righteousness.PALADIN = {}
RPWORDLIST.seal_of_righteousness.PALADIN.emote = {}
RPWORDLIST.seal_of_righteousness.PALADIN.customemote = {}
RPWORDLIST.seal_of_righteousness.PALADIN.random = {}

RPWORDLIST.redemption.PALADIN = {}
RPWORDLIST.redemption.PALADIN.emote = {}
RPWORDLIST.redemption.PALADIN.customemote = {}
RPWORDLIST.redemption.PALADIN.random = {}

RPWORDLIST.blessing_of_wisdom.PALADIN = {}
RPWORDLIST.blessing_of_wisdom.PALADIN.emote = {}
RPWORDLIST.blessing_of_wisdom.PALADIN.customemote = {}
RPWORDLIST.blessing_of_wisdom.PALADIN.random = {}

RPWORDLIST.consecration.PALADIN = {}
RPWORDLIST.consecration.PALADIN.emote = {}
RPWORDLIST.consecration.PALADIN.customemote = {}
RPWORDLIST.consecration.PALADIN.random = {}

RPWORDLIST.exorcism.PALADIN = {}
RPWORDLIST.exorcism.PALADIN.emote = {}
RPWORDLIST.exorcism.PALADIN.customemote = {}
RPWORDLIST.exorcism.PALADIN.random = {}

RPWORDLIST.flash_of_light.PALADIN = {}
RPWORDLIST.flash_of_light.PALADIN.emote = {}
RPWORDLIST.flash_of_light.PALADIN.customemote = {}
RPWORDLIST.flash_of_light.PALADIN.random = {}

RPWORDLIST.turn_undead.PALADIN = {}
RPWORDLIST.turn_undead.PALADIN.emote = {}
RPWORDLIST.turn_undead.PALADIN.customemote = {}
RPWORDLIST.turn_undead.PALADIN.random = {}

RPWORDLIST.sense_undead.PALADIN = {}
RPWORDLIST.sense_undead.PALADIN.emote = {}
RPWORDLIST.sense_undead.PALADIN.customemote = {}
RPWORDLIST.sense_undead.PALADIN.random = {}

RPWORDLIST.divine_favor.PALADIN = {}
RPWORDLIST.divine_favor.PALADIN.emote = {}
RPWORDLIST.divine_favor.PALADIN.customemote = {}
RPWORDLIST.divine_favor.PALADIN.random = {}

RPWORDLIST.seal_of_light.PALADIN = {}
RPWORDLIST.seal_of_light.PALADIN.emote = {}
RPWORDLIST.seal_of_light.PALADIN.customemote = {}
RPWORDLIST.seal_of_light.PALADIN.random = {}

RPWORDLIST.seal_of_wisdom.PALADIN = {}
RPWORDLIST.seal_of_wisdom.PALADIN.emote = {}
RPWORDLIST.seal_of_wisdom.PALADIN.customemote = {}
RPWORDLIST.seal_of_wisdom.PALADIN.random = {}

RPWORDLIST.blessing_of_light.PALADIN = {}
RPWORDLIST.blessing_of_light.PALADIN.emote = {}
RPWORDLIST.blessing_of_light.PALADIN.customemote = {}
RPWORDLIST.blessing_of_light.PALADIN.random = {}

RPWORDLIST.holy_shock.PALADIN = {}
RPWORDLIST.holy_shock.PALADIN.emote = {}
RPWORDLIST.holy_shock.PALADIN.customemote = {}
RPWORDLIST.holy_shock.PALADIN.random = {}

RPWORDLIST.summon_warhorse.PALADIN = {}
RPWORDLIST.summon_warhorse.PALADIN.emote = {}
RPWORDLIST.summon_warhorse.PALADIN.customemote = {}
RPWORDLIST.summon_warhorse.PALADIN.random = {}

RPWORDLIST.cleanse.PALADIN = {}
RPWORDLIST.cleanse.PALADIN.emote = {}
RPWORDLIST.cleanse.PALADIN.customemote = {}
RPWORDLIST.cleanse.PALADIN.random = {}

RPWORDLIST.hammer_of_wrath.PALADIN = {}
RPWORDLIST.hammer_of_wrath.PALADIN.emote = {}
RPWORDLIST.hammer_of_wrath.PALADIN.customemote = {}
RPWORDLIST.hammer_of_wrath.PALADIN.random = {}

RPWORDLIST.holy_wrath.PALADIN = {}
RPWORDLIST.holy_wrath.PALADIN.emote = {}
RPWORDLIST.holy_wrath.PALADIN.customemote = {}
RPWORDLIST.holy_wrath.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_wisdom.PALADIN = {}
RPWORDLIST.greater_blessing_of_wisdom.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_wisdom.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_wisdom.PALADIN.random = {}

RPWORDLIST.greater_blessing_of_light.PALADIN = {}
RPWORDLIST.greater_blessing_of_light.PALADIN.emote = {}
RPWORDLIST.greater_blessing_of_light.PALADIN.customemote = {}
RPWORDLIST.greater_blessing_of_light.PALADIN.random = {}

RPWORDLIST.hearthstone.PALADIN = {}
RPWORDLIST.hearthstone.PALADIN.emote = {}
RPWORDLIST.hearthstone.PALADIN.customemote = {"grasps PP hearthstone and calls upon the Light to transport OP to HOME."}
RPWORDLIST.hearthstone.PALADIN.random = {}
