--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--
-- Read "How to Customize.txt" to learn how to use this file.
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

--=====================================================================--
-- When you ENTER COMBAT (when the crossed swords cover your level #)
--=====================================================================--
RPWORDLIST.entercombat.WARRIOR = {}
RPWORDLIST.entercombat.WARRIOR.emote = {"CHARGE","ROAR", "MOCK"}
RPWORDLIST.entercombat.WARRIOR.customemote = {}
RPWORDLIST.entercombat.WARRIOR.random = {

	["phrase"] = "I'll BLANK your BLANK!",

	[1] = {"rip", "tear", "slice", "cut", "carve", "hack", "cleave", "thrash"},

	[2] = {"arms off", "legs off", "eyeballs out", "eyes out", "face off", "teeth out", "kneecaps off", "intestines out",
			"stomach out", "heart out", "bowels out", "feet off", "ribs out", "spine out"},

	}
--=====================================================================--
-- When you LEAVE COMBAT (when the crossed swords leave your level #)
--=====================================================================--
RPWORDLIST.leavecombat.WARRIOR = {}
RPWORDLIST.leavecombat.WARRIOR.emote = {}
RPWORDLIST.leavecombat.WARRIOR.customemote = {}
RPWORDLIST.leavecombat.WARRIOR.random = {}
--=====================================================================--
--  HURT: when you get HIT & you have LESS HEALTH than the last time you got hit
--=====================================================================--
RPWORDLIST.hurt.WARRIOR = {}
RPWORDLIST.hurt.WARRIOR.emote = {"SNARL"}       
RPWORDLIST.hurt.WARRIOR.customemote = {}
RPWORDLIST.hurt.WARRIOR.random = {

	["phrase"] = "I'll BLANK your BLANK!",

	[1] = {"rip", "tear", "slice", "cut", "carve", "hack", "cleave", "thrash"},

	[2] = {"arms off", "legs off", "eyeballs out", "eyes out", "face off", "teeth out", "kneecaps off", "intestines out",
			"stomach out", "heart out", "bowels out", "feet off", "ribs out", "spine out"},

	}
--=====================================================================--
-- ABSORB: Creature or hostile player attacks but you absorb the damage.
-- For example: when a priest shields you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.absorb.WARRIOR = {"Hit me again!  Let me absorb more!",}
RPWORDLIST.absorb.WARRIOR.emote = {}
RPWORDLIST.absorb.WARRIOR.customemote = {}
RPWORDLIST.absorb.WARRIOR.random = {

	["phrase"] = "BLANKI absorb your BLANK BLANK like BLANK.",

	[1] = {"You insect.  ", "Haha!  ", ""},

	[2] = {"puny", "pathetic", "insignificant", "laughable", "pitiful", "useless",},

	[3] = {"hits", "blows", "attacks", "attacks", },

	[4] = {"they're nothing.", "they're nothing.", "they're vapor.", "a sponge.", 
	"a stealth aircraft absorbing most of the microwave radiation that hits it and reflecting whatever it doesn't absorb away from the microwave source...  or something."},

	}
--=====================================================================--
-- BLOCK: Creature or hostile player attacks. You block.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.block.WARRIOR = {}
RPWORDLIST.block.WARRIOR.emote = {} 
RPWORDLIST.block.WARRIOR.customemote = {}
RPWORDLIST.block.WARRIOR.random = {}
--=====================================================================--
-- DODGE: Creature or hostile player attacks. You dodge.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.dodge.WARRIOR = {"C'mon, TARGET_RACE, spend some more TARGET_POWER on me."}
RPWORDLIST.dodge.WARRIOR.emote = {}
RPWORDLIST.dodge.WARRIOR.customemote = {}
RPWORDLIST.dodge.WARRIOR.random = {}
--=====================================================================--
-- MISS: Creature or hostile player attacks but misses you.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.miss.WARRIOR = {}
RPWORDLIST.miss.WARRIOR.emote = {} 
RPWORDLIST.miss.WARRIOR.customemote = {}
RPWORDLIST.miss.WARRIOR.random = {}
--=====================================================================--
-- PARRY: Creature or hostile player attacks. You parry.
-- by default your health must be above 70%
--=====================================================================--
RPWORDLIST.parry.WARRIOR = {"C'mon, TARGET_RACE, spend some more TARGET_POWER on me."}
RPWORDLIST.parry.WARRIOR.emote = {}  
RPWORDLIST.parry.WARRIOR.customemote = {}
RPWORDLIST.parry.WARRIOR.random = {}
--=====================================================================--
-- CRIT: You crit damage with a physical attack
--=====================================================================--
RPWORDLIST.youcrit.WARRIOR = {}
RPWORDLIST.youcrit.WARRIOR.emote = {"LAUGH", "MOCK"}
RPWORDLIST.youcrit.WARRIOR.customemote = {"cackles with delight at PP critical strike."}
RPWORDLIST.youcrit.WARRIOR.random = {}
--=====================================================================--
-- CRIT (SPELL): You crit damage with a spell attack
--=====================================================================--
RPWORDLIST.youcritspell.WARRIOR = {}
RPWORDLIST.youcritspell.WARRIOR.emote = {}
RPWORDLIST.youcritspell.WARRIOR.customemote = {}
RPWORDLIST.youcritspell.WARRIOR.random = {}
--=====================================================================--
-- When your PET STARTS ATTACKING.
	-- PNAME = Pet's Name	
	-- PTNAME = Pet's target's name                           
	-- PTSP = Pet's target's subject pronoun 	(He/She/It)
	-- PTOP = Pet's target's object pronoun 	(him/her/it)
	-- PTPP = Pet's target's personal pronoun 	(his/her/its)
--=====================================================================--
RPWORDLIST.petattackstart.WARRIOR = {}
RPWORDLIST.petattackstart.WARRIOR.emote = {}
RPWORDLIST.petattackstart.WARRIOR.customemote = {}
RPWORDLIST.petattackstart.WARRIOR.random = {}
--=====================================================================--
-- When your PET STOPS ATTACKING.
	-- PNAME = Pet's Name
		-- Your pet no longer has a target.
--=====================================================================--
RPWORDLIST.petattackstop.WARRIOR = {}
RPWORDLIST.petattackstop.WARRIOR.emote = {} 
RPWORDLIST.petattackstop.WARRIOR.customemote = {}
RPWORDLIST.petattackstop.WARRIOR.random = {}
--=====================================================================--
--  Friendly NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksfriend.WARRIOR = {}
RPWORDLIST.npctalksfriend.WARRIOR.emote = {}
RPWORDLIST.npctalksfriend.WARRIOR.customemote = {}
RPWORDLIST.npctalksfriend.WARRIOR.random = {}
--=====================================================================--
--  Enemy NPC talks
	-- Usage                                    Example
	-- -----                                    -------
	-- TEXT = The text message sent by the NPC.	TEXT = Now to find an unsuspecting Harpy!
	-- NPC 	= The NPC saying it.        		NPC  = Mogg
	-- LANG = The Language              		LANG = Orcish
--=====================================================================--
RPWORDLIST.npctalksenemy.WARRIOR = {}
RPWORDLIST.npctalksenemy.WARRIOR.emote = {}
RPWORDLIST.npctalksenemy.WARRIOR.customemote = {}
RPWORDLIST.npctalksenemy.WARRIOR.random = {}
--=====================================================================--
--  RESURRECT:  When you resurrect
	-- If you are dead when the UI (User Interface) loads, you will not RP.
--=====================================================================--
RPWORDLIST.resurrect.WARRIOR = {}
RPWORDLIST.resurrect.WARRIOR.emote = {} 
RPWORDLIST.resurrect.WARRIOR.customemote = {}
RPWORDLIST.resurrect.WARRIOR.random = {}



--//////////////////////////////////////////////////////////////////////////--
-- Warrior Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Arms
--=====================================================================--
RPWORDLIST.charge.WARRIOR = {}
RPWORDLIST.charge.WARRIOR.emote = {"CHARGE"}
RPWORDLIST.charge.WARRIOR.customemote = {
    "yells PP head off as SP runs into battle.",
    "charges at TARGET.",
    "screams a battle cry and charges into combat.",
    }
RPWORDLIST.charge.WARRIOR.random = {}

RPWORDLIST.rend.WARRIOR = {"Bleed for me, TARGET."}
RPWORDLIST.rend.WARRIOR.emote = {}
RPWORDLIST.rend.WARRIOR.customemote = {}
RPWORDLIST.rend.WARRIOR.random = {}

RPWORDLIST.thunder_clap.WARRIOR = {}
RPWORDLIST.thunder_clap.WARRIOR.emote = {}
RPWORDLIST.thunder_clap.WARRIOR.customemote = {}
RPWORDLIST.thunder_clap.WARRIOR.random = {}

RPWORDLIST.hamstring.WARRIOR = {}
RPWORDLIST.hamstring.WARRIOR.emote = {}
RPWORDLIST.hamstring.WARRIOR.customemote = {"hacks at TARGET's hamstring.",}
RPWORDLIST.hamstring.WARRIOR.random = {}

RPWORDLIST.heroic_strike.WARRIOR = {}
RPWORDLIST.heroic_strike.WARRIOR.emote = {}
RPWORDLIST.heroic_strike.WARRIOR.customemote = {}
RPWORDLIST.heroic_strike.WARRIOR.random = {}

RPWORDLIST.overpower.WARRIOR = {}
RPWORDLIST.overpower.WARRIOR.emote = {}
RPWORDLIST.overpower.WARRIOR.customemote = {}
RPWORDLIST.overpower.WARRIOR.random = {}

RPWORDLIST.mocking_blow.WARRIOR = {"Over here! RINSULT",}
RPWORDLIST.mocking_blow.WARRIOR.emote = {}
RPWORDLIST.mocking_blow.WARRIOR.customemote = {}
RPWORDLIST.mocking_blow.WARRIOR.random = {}
                        
RPWORDLIST.anger_management.WARRIOR = {}
RPWORDLIST.anger_management.WARRIOR.emote = {}
RPWORDLIST.anger_management.WARRIOR.customemote = {}
RPWORDLIST.anger_management.WARRIOR.random = {}
                        
RPWORDLIST.retaliation.WARRIOR = {}
RPWORDLIST.retaliation.WARRIOR.emote = {}
RPWORDLIST.retaliation.WARRIOR.customemote = {}
RPWORDLIST.retaliation.WARRIOR.random = {}
                                                                   
RPWORDLIST.sweeping_strikes.WARRIOR = {}
RPWORDLIST.sweeping_strikes.WARRIOR.emote = {}
RPWORDLIST.sweeping_strikes.WARRIOR.customemote = {}
RPWORDLIST.sweeping_strikes.WARRIOR.random = {}   
                                                                   
RPWORDLIST.mortal_strike.WARRIOR = {}
RPWORDLIST.mortal_strike.WARRIOR.emote = {}
RPWORDLIST.mortal_strike.WARRIOR.customemote = {}
RPWORDLIST.mortal_strike.WARRIOR.random = {}
--=====================================================================--
-- Fury
--=====================================================================--
RPWORDLIST.battle_shout.WARRIOR = {}
RPWORDLIST.battle_shout.WARRIOR.emote = {"ROAR",}
RPWORDLIST.battle_shout.WARRIOR.customemote = {}
RPWORDLIST.battle_shout.WARRIOR.random = {}

RPWORDLIST.demoralizing_shout.WARRIOR = {}
RPWORDLIST.demoralizing_shout.WARRIOR.emote = {"ROAR",}
RPWORDLIST.demoralizing_shout.WARRIOR.customemote = {}
RPWORDLIST.demoralizing_shout.WARRIOR.random = {}

RPWORDLIST.cleave.WARRIOR = {}
RPWORDLIST.cleave.WARRIOR.emote = {}
RPWORDLIST.cleave.WARRIOR.customemote = {}
RPWORDLIST.cleave.WARRIOR.random = {}
        
RPWORDLIST.piercing_howl.WARRIOR = {}
RPWORDLIST.piercing_howl.WARRIOR.emote = {}
RPWORDLIST.piercing_howl.WARRIOR.customemote = {}
RPWORDLIST.piercing_howl.WARRIOR.random = {}

RPWORDLIST.intimidating_shout.WARRIOR = {"Go away!", "Fear me!", "Run you bastards!",}
RPWORDLIST.intimidating_shout.WARRIOR.emote = {}
RPWORDLIST.intimidating_shout.WARRIOR.customemote = {}
RPWORDLIST.intimidating_shout.WARRIOR.random = {}
  
RPWORDLIST.execute.WARRIOR = {}
RPWORDLIST.execute.WARRIOR.emote = {}
RPWORDLIST.execute.WARRIOR.customemote = {}
RPWORDLIST.execute.WARRIOR.random = {}

RPWORDLIST.challenging_shout.WARRIOR = {"Attack me you bastards!",}
RPWORDLIST.challenging_shout.WARRIOR.emote = {}
RPWORDLIST.challenging_shout.WARRIOR.customemote = {}
RPWORDLIST.challenging_shout.WARRIOR.random = {}
            
RPWORDLIST.death_wish.WARRIOR = {}
RPWORDLIST.death_wish.WARRIOR.emote = {}
RPWORDLIST.death_wish.WARRIOR.customemote = {}
RPWORDLIST.death_wish.WARRIOR.random = {}
             
RPWORDLIST.intercept.WARRIOR = {}
RPWORDLIST.intercept.WARRIOR.emote = {}
RPWORDLIST.intercept.WARRIOR.customemote = {}
RPWORDLIST.intercept.WARRIOR.random = {}

RPWORDLIST.slam.WARRIOR = {}
RPWORDLIST.slam.WARRIOR.emote = {"HI",}
RPWORDLIST.slam.WARRIOR.customemote = {}
RPWORDLIST.slam.WARRIOR.random = {}

RPWORDLIST.berserker_rage.WARRIOR = {}
RPWORDLIST.berserker_rage.WARRIOR.emote = {}
RPWORDLIST.berserker_rage.WARRIOR.customemote = {}
RPWORDLIST.berserker_rage.WARRIOR.random = {}

RPWORDLIST.whirlwind.WARRIOR = {}
RPWORDLIST.whirlwind.WARRIOR.emote = {}
RPWORDLIST.whirlwind.WARRIOR.customemote = {}
RPWORDLIST.whirlwind.WARRIOR.random = {}

RPWORDLIST.pummel.WARRIOR = {}
RPWORDLIST.pummel.WARRIOR.emote = {}
RPWORDLIST.pummel.WARRIOR.customemote = {}
RPWORDLIST.pummel.WARRIOR.random = {}

RPWORDLIST.bloodthirst.WARRIOR = {}
RPWORDLIST.bloodthirst.WARRIOR.emote = {}
RPWORDLIST.bloodthirst.WARRIOR.customemote = {}
RPWORDLIST.bloodthirst.WARRIOR.random = {}

RPWORDLIST.recklessness.WARRIOR = {}
RPWORDLIST.recklessness.WARRIOR.emote = {}
RPWORDLIST.recklessness.WARRIOR.customemote = {}
RPWORDLIST.recklessness.WARRIOR.random = {}
--=====================================================================--
-- Protection
--=====================================================================--   
RPWORDLIST.bloodrage.WARRIOR = {}
RPWORDLIST.bloodrage.WARRIOR.emote = {"ROAR", "SNARL"}
RPWORDLIST.bloodrage.WARRIOR.customemote = {
    "looks like SP's getting angry.", "is going into a rage.",
    "goes into a furious rage."
    }
RPWORDLIST.bloodrage.WARRIOR.random = {}

RPWORDLIST.sunder_armor.WARRIOR = {}
RPWORDLIST.sunder_armor.WARRIOR.emote = {}
RPWORDLIST.sunder_armor.WARRIOR.customemote = {}
RPWORDLIST.sunder_armor.WARRIOR.random = {}

RPWORDLIST.shield_bash.WARRIOR = {}
RPWORDLIST.shield_bash.WARRIOR.emote = {}
RPWORDLIST.shield_bash.WARRIOR.customemote = {"bashes PP shield into TARGET's face.",}
RPWORDLIST.shield_bash.WARRIOR.random = {}

RPWORDLIST.revenge.WARRIOR = {}
RPWORDLIST.revenge.WARRIOR.emote = {}
RPWORDLIST.revenge.WARRIOR.customemote = {}
RPWORDLIST.revenge.WARRIOR.random = {}

RPWORDLIST.shield_block.WARRIOR = {}
RPWORDLIST.shield_block.WARRIOR.emote = {}
RPWORDLIST.shield_block.WARRIOR.customemote = {}
RPWORDLIST.shield_block.WARRIOR.random = {}

RPWORDLIST.last_stand.WARRIOR = {}
RPWORDLIST.last_stand.WARRIOR.emote = {}
RPWORDLIST.last_stand.WARRIOR.customemote = {}
RPWORDLIST.last_stand.WARRIOR.random = {}

RPWORDLIST.shield_wall.WARRIOR = {}
RPWORDLIST.shield_wall.WARRIOR.emote = {}
RPWORDLIST.shield_wall.WARRIOR.customemote = {}
RPWORDLIST.shield_wall.WARRIOR.random = {}

RPWORDLIST.concussion_blow.WARRIOR = {}
RPWORDLIST.concussion_blow.WARRIOR.emote = {}
RPWORDLIST.concussion_blow.WARRIOR.customemote = {}
RPWORDLIST.concussion_blow.WARRIOR.random = {}

RPWORDLIST.shield_slam.WARRIOR = {}
RPWORDLIST.shield_slam.WARRIOR.emote = {}
RPWORDLIST.shield_slam.WARRIOR.customemote = {"slams PP shield into TARGET's face.",}
RPWORDLIST.shield_slam.WARRIOR.random = {}

RPWORDLIST.hearthstone.WARRIOR = {}
RPWORDLIST.hearthstone.WARRIOR.emote = {}
RPWORDLIST.hearthstone.WARRIOR.customemote = {}
RPWORDLIST.hearthstone.WARRIOR.random = {}

RPWORDLIST.shoot_bow.WARRIOR = {}
RPWORDLIST.shoot_bow.WARRIOR.emote = {}
RPWORDLIST.shoot_bow.WARRIOR.customemote = {}
RPWORDLIST.shoot_bow.WARRIOR.random = {}

RPWORDLIST.shoot_crossbow.WARRIOR = {}
RPWORDLIST.shoot_crossbow.WARRIOR.emote = {}
RPWORDLIST.shoot_crossbow.WARRIOR.customemote = {}
RPWORDLIST.shoot_crossbow.WARRIOR.random = {}

RPWORDLIST.shoot_gun.WARRIOR = {}
RPWORDLIST.shoot_gun.WARRIOR.emote = {}
RPWORDLIST.shoot_gun.WARRIOR.customemote = {}
RPWORDLIST.shoot_gun.WARRIOR.random = {}

RPWORDLIST.throw.WARRIOR = {}
RPWORDLIST.throw.WARRIOR.emote = {}
RPWORDLIST.throw.WARRIOR.customemote = {}
RPWORDLIST.throw.WARRIOR.random = {}

-- night elf racial
RPWORDLIST.shadowmeld.WARRIOR = {}
RPWORDLIST.shadowmeld.WARRIOR.emote = {}
RPWORDLIST.shadowmeld.WARRIOR.customemote = {"fades into the shadows.", "disappears for a bit.", "thinks SP'll hide now."}
RPWORDLIST.shadowmeld.WARRIOR.random = {}
