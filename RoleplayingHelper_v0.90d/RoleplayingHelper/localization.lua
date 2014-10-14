RPEvents = {
	["entercombat"] = { 		["English"] = "Enter Combat",			["Menu Number"] = 1		},
	["leavecombat"] = { 		["English"] = "Leave Combat",			["Menu Number"] = 2		},
	["hurt"] = { 				["English"] = "Hostile Hit",			["Menu Number"] = 3		},
	["miss"] = { 				["English"] = "Hostile Miss",			["Menu Number"] = 4		},
	["absorb"] = { 				["English"] = "You Absorb",				["Menu Number"] = 5		},
	["block"] = { 				["English"] = "You Block",				["Menu Number"] = 6		},
	["dodge"] = { 				["English"] = "You Dodge",				["Menu Number"] = 7		},
	["parry"]	= { 			["English"] = "You Parry",				["Menu Number"] = 8		},
	["youcrit"] = { 			["English"] = "You Crit (Physical)",	["Menu Number"] = 9		},
	["youcritspell"] = {	 	["English"] = "You Crit (Spell)",		["Menu Number"] = 10	},
	["youheal"] = { 			["English"] = "You Heal",				["Menu Number"] = 11	},
	["youcritheal"] = {		 	["English"] = "You Crit Heal",			["Menu Number"] = 12	},
	["petattackstart"] = {	 	["English"] = "Pet Attack Start",		["Menu Number"] = 13	},
	["petattackstop"] = {	 	["English"] = "Pet Attack Stop",		["Menu Number"] = 14	},
	["petdies"] = { 			["English"] = "Pet Dies",				["Menu Number"] = 15	},
	["resurrect"] = { 			["English"] = "You Resurrect",			["Menu Number"] = 16	},
	["talktonpc_firsttime"] = {	["English"] = "Meet New NPC",	        ["Menu Number"] = 17	},
	["talktonpc_beginning"] = {	["English"] = "Talk To NPC (Beginning)",["Menu Number"] = 18	},
	["talktonpc_middle"] = { 	["English"] = "Talk To NPC (Middle)",	["Menu Number"] = 19	},
	["talktonpc_end"] = {		["English"] = "Talk To NPC (End)",		["Menu Number"] = 20	},
	["npctalksfriend"] = {	 	["English"] = "Friendly NPC Talks",		["Menu Number"] = 21	},   
	["npctalksenemy"] = {	 	["English"] = "Enemy NPC Talks",		["Menu Number"] = 22	},    
	["player_level_up"] = {	 	["English"] = "You Level Up",			["Menu Number"] = 23	},
	["player_camping"] = {	 	["English"] = "You Camp/Logout",		["Menu Number"] = 24	},
    ["hearthstone"] = {         ["English"] = "Hearthstone",            ["Menu Number"] = 25    },
	["trade_show"] = {          ["English"] = "Trade Window Opened",    ["Menu Number"] = 26    },
	["trade_closed"] = {        ["English"] = "Trade Window Closed",    ["Menu Number"] = 27    },
	["monster_emote_help"] = {  ["English"] = "Mob Emote: Help",        ["Menu Number"] = 28    },
	["monster_emote_fear"] = {  ["English"] = "Mob Emote: Fear",        ["Menu Number"] = 29    },
	["monster_emote_enrage"] = {["English"] = "Mob Emote: Enraged",     ["Menu Number"] = 30    },
	["mount"] = {               ["English"] = "Mounting",               ["Menu Number"] = 31    },
	["learn"] = {               ["English"] = "You Learn Something",    ["Menu Number"] = 32    },
	["drunk"] = {               ["English"] = "You are Drunk",          ["Menu Number"] = 33    },
	["sober"] = {               ["English"] = "You are Sober",          ["Menu Number"] = 34    },
	["fall"] = {                ["English"] = "You Fall",               ["Menu Number"] = 35    },
	["exhausted"] = {           ["English"] = "You Lose Rest Bonus",    ["Menu Number"] = 36    },
	["new_home"] = {            ["English"] = "You Set a New Home",     ["Menu Number"] = 37    },
	["welcome_home"] = {        ["English"] = "You Return Home",        ["Menu Number"] = 38    },
	["drowning"] = {            ["English"] = "You are Drowning",       ["Menu Number"] = 39    },
	["av_recall"] = {           ["English"] = "AV: Recall",             ["Menu Number"] = 40    },
	["bg_begin"] = {            ["English"] = "BG: Battle Begins",      ["Menu Number"] = 41    },
	["epl_pvp_tower_cap"] = {   ["English"] = "EPL PvP: Capture Tower", ["Menu Number"] = 42    },
	["epl_pvp_tower_lose"] = {  ["English"] = "EPL PvP: Lose Tower",    ["Menu Number"] = 43    },
    ["scourge_cauldron"] = {    ["English"] = "WPL: Scourge Cauldron",  ["Menu Number"] = 44    },
	["brd_emote_slave"] = {     ["English"] = "BRD: Slave",             ["Menu Number"] = 45    },
	
	
}
RPMOUNTS = {
    -- Night Elf Normal
    "Striped Frostsaber",
    "Spotted Frostsaber",
    "Striped Nightsaber",
    -- Night Elf Epic
    "Swift Stormsaber",
    "Swift Frostsaber",
    "Swift Mistsaber",
    -- Dwarf Normal
    "Brown Ram",
    "Gray Ram",
    "White Ram",
    -- Dwarf Epic
    "Swift Brown Ram",
    "Swift Gray Ram",
    "Swift White Ram",
    -- PvP Epic
    "Black War Tiger",
    "Black War Ram",
    "Black Battlestrider",
    "Black War Wolf",
    "Black War Raptor",
    "Black War Kodo",
    "Stormpike Battle Charger",
    "Frostwolf Howler",
    -- Human Normal
    "Brown Horse",
    "Chestnut Mare",
    "Pinto Horse",
    "Black Stallion",
    -- Human Epic
    "Swift Brown Steed",
    "Swift White Steed",
    "Swift Palomino",
    -- Gnome Normal
    "Blue Mechanostrider",
    "Green Mechanostrider",
    "Red Mechanostrider",
    "Unpainted Mechanostrider",
    -- Gnome Epic
    "Swift Green Mechanostrider",
    "Swift White Mechanostrider",
    "Swift Yellow Mechanostrider",
    -- Orc Normal
    "Brown Wolf",
    "Dire Wolf",
    "Timber Wolf",
    -- Orc Epic
    "Swift Brown Wolf",
    "Swift Gray Wolf",
    "Swift Timber Wolf",
    -- Troll Normal
    "Emerald Raptor",
    "Turquoise Raptor",
    "Violet Raptor",
    -- Troll Epic
    "Swift Blue Raptor",
    "Swift Olive Raptor",
    "Swift Orange Raptor",
    -- Tauren Normal
    "Brown Kodo",
    "Gray Kodo",
    "Green Kodo",
    -- Tauren Epic
    "Great Brown Kodo",
    "Great Gray Kodo",
    "Great White Kodo",
    -- Undead Normal
    "Brown Skeletal Horse",
    "Blue Skeletal Horse",
    "Green Skeletal Horse",
    "Red Skeletal Horse",
    -- Undead Epic
    "Green Skeletal Warhorse",
    "Red Skeletal Warhorse",
    "Purple Skeletal Warhorse",
    -- Rare Mounts
    "Deathcharger",
    "Swift Zulian Tiger",
    "Razzashi Raptor",
    "Winterspring Frostsaber", --??
}

SPELLS = {}
SPELLS.casttime = {}
SPELLS.instant = {}
SPELLS.next_melee = {}
SPELLS.channeled = {}

SPELLS.casttime.DRUID = {}
SPELLS.casttime.HUNTER = {}
SPELLS.casttime.MAGE = {}
SPELLS.casttime.PALADIN = {}
SPELLS.casttime.PRIEST = {}
SPELLS.casttime.ROGUE = {}
SPELLS.casttime.SHAMAN = {}
SPELLS.casttime.WARLOCK = {}
SPELLS.casttime.WARRIOR = {}

SPELLS.instant.NIGHTELF = {}
SPELLS.instant.DRUID = {}
SPELLS.instant.HUNTER = {}
SPELLS.instant.MAGE = {}
SPELLS.instant.PALADIN = {}
SPELLS.instant.PRIEST = {}
SPELLS.instant.ROGUE = {}
SPELLS.instant.SHAMAN = {}
SPELLS.instant.WARLOCK = {}
SPELLS.instant.WARRIOR = {}

SPELLS.next_melee.DRUID = {}
SPELLS.next_melee.HUNTER = {}
SPELLS.next_melee.MAGE = {}     -- No next_melee spells for Mage
SPELLS.next_melee.PALADIN = {}  -- No next_melee spells for Paladin
SPELLS.next_melee.PRIEST = {}
SPELLS.next_melee.ROGUE = {}	-- No next_melee spells for Rogue
SPELLS.next_melee.SHAMAN = {}	-- No next_melee spells for Shaman
SPELLS.next_melee.WARLOCK = {}  -- No next_melee spells for Warlock
SPELLS.next_melee.WARRIOR = {}

SPELLS.channeled.DRUID = {}
SPELLS.channeled.HUNTER = {}
SPELLS.channeled.MAGE = {}
SPELLS.channeled.PALADIN = {}   -- No channeled spells for Paladin
SPELLS.channeled.PRIEST = {}
SPELLS.channeled.ROGUE = {}		-- No channeled spells for Rogue
SPELLS.channeled.SHAMAN = {}	-- No channeled spells for Shaman
SPELLS.channeled.WARLOCK = {}
SPELLS.channeled.WARRIOR = {}	-- No channeled spells for Warrior

--/////////////////////////////////////////////////////////////////////--
-- SPELLS
--/////////////////////////////////////////////////////////////////////--

SPELLS.instant.NIGHTELF.shadowmeld =        "Shadowmeld"

--/////////////////////////////////////////////////////////////////////--
-- Druid Spells
--/////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Feral Combat                                                                 
--=====================================================================--
SPELLS.instant.DRUID.demoralizing_roar = 	"Demoralizing Roar"                        
SPELLS.instant.DRUID.enrage = 				"Enrage"                            
SPELLS.instant.DRUID.bash = 				"Bash"                           
SPELLS.instant.DRUID.swipe = 				"Swipe"                             
SPELLS.instant.DRUID.maul = 				"Maul"		                                         
SPELLS.instant.DRUID.cat_form = 			"Cat Form"            
SPELLS.instant.DRUID.claw = 				"Claw"                   
SPELLS.instant.DRUID.feral_charge = 		"Feral Charge"                  
SPELLS.instant.DRUID.prowl = 				"Prowl"                   
SPELLS.instant.DRUID.rip = 					"Rip"                       
SPELLS.instant.DRUID.shred = 				"Shred"                   
SPELLS.instant.DRUID.rake = 				"Rake"                
SPELLS.instant.DRUID.tigers_fury = 			"Tiger's Fury"                  
SPELLS.instant.DRUID.dash = 				"Dash"                  
SPELLS.instant.DRUID.challenging_roar = 	"Challenging Roar"             
SPELLS.instant.DRUID.cower = 				"Cower"             
SPELLS.instant.DRUID.faerie_fire_feral = 	"Faerie Fire (Feral)"             
SPELLS.instant.DRUID.travel_form = 			"Travel Form"               
SPELLS.instant.DRUID.ferocious_bite = 		"Ferocious Bite"                
SPELLS.instant.DRUID.ravage = 				"Ravage"              
SPELLS.instant.DRUID.track_humanoids = 		"Track Humanoids"          
SPELLS.instant.DRUID.frenzied_regeneration = "Frenzied Regeneration"       
SPELLS.instant.DRUID.pounce = 				"Pounce"       
SPELLS.instant.DRUID.dire_bear_form = 		"Dire Bear Form"   
SPELLS.instant.DRUID.leader_of_the_pack = 	"Leader of the Pack"
--=====================================================================--
-- Balance        
--=====================================================================-- 
SPELLS.casttime.DRUID.wrath = 				"Wrath"
SPELLS.instant.DRUID.moon_fire = 			"Moon Fire"
SPELLS.casttime.DRUID.thorns = 				"Thorns"
SPELLS.casttime.DRUID.entangling_roots = 	"Entangling Roots"
SPELLS.instant.DRUID.natures_grasp = 		"Nature's Grasp"
SPELLS.instant.DRUID.faerie_fire = 			"Faerie Fire"
SPELLS.casttime.DRUID.hibernate = 			"Hibernate"
SPELLS.instant.DRUID.omen_of_clarity = 		"Omen of Clarity"
SPELLS.casttime.DRUID.starfire = 			"Starfire"
SPELLS.casttime.DRUID.soothe_animal = 		"Soothe Animal"
SPELLS.instant.DRUID.hurricane = 			"Hurricane"
SPELLS.instant.DRUID.moonkin_form = 		"Moonkin Form"
SPELLS.instant.DRUID.barkskin = 			"Barkskin"
SPELLS.casttime.DRUID.teleport_moonglade =  "Teleport: Moonglade"
--=====================================================================--
-- Restoration           
--=====================================================================--
SPELLS.instant.DRUID.mark_of_the_wild = 	"Mark of the Wild"
SPELLS.instant.DRUID.rejuvenation = 		"Rejuvenation"
SPELLS.casttime.DRUID.healing_touch = 		"Healing Touch"
SPELLS.casttime.DRUID.regrowth = 			"Regrowth"
SPELLS.instant.DRUID.insect_swarm = 		"Insect Swarm"
SPELLS.casttime.DRUID.rebirth = 			"Rebirth"
SPELLS.instant.DRUID.remove_curse = 		"Remove Curse"
SPELLS.instant.DRUID.cure_poison =          "Cure Poison"
SPELLS.instant.DRUID.abolish_poison = 		"Abolish Poison"
SPELLS.instant.DRUID.natures_swiftness = 	"Nature's Swiftness"
SPELLS.instant.DRUID.tranquility = 			"Tranquility"
SPELLS.instant.DRUID.innervate = 			"Innervate"
SPELLS.instant.DRUID.gift_of_the_wild = 	"Gift of the Wild"
SPELLS.instant.DRUID.swiftmend =            "Swiftmend"

--SPELLS.instant.DRUID.shadowmeld =           "Shadowmeld"

--//////////////////////////////////////////////////////////////////////////--
-- Hunter Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Beast Mastery
--=====================================================================-- 
SPELLS.instant.HUNTER.aspect_of_the_monkey = 	"Aspect of the Monkey"     
SPELLS.instant.HUNTER.aspect_of_the_hawk = 		"Aspect of the Hawk"      
SPELLS.instant.HUNTER.aspect_of_the_cheetah = 	"Aspect of the Cheetah"       
SPELLS.instant.HUNTER.aspect_of_the_beast = 	"Aspect of the Beast"        
SPELLS.instant.HUNTER.aspect_of_the_pack = 		"Aspect of the Pack"       
SPELLS.instant.HUNTER.aspect_of_the_wild = 		"Aspect of the Wild"          
SPELLS.channeled.HUNTER.mend_pet = 				"Mend Pet" 
SPELLS.instant.HUNTER.eagle_eye = 				"Eagle Eye"
SPELLS.casttime.HUNTER.eyes_of_the_beast = 		"Eyes of the Beast"
SPELLS.casttime.HUNTER.scare_beast = 			"Scare Beast"
SPELLS.instant.HUNTER.beast_lore = 				"Beast Lore"
SPELLS.instant.HUNTER.bestial_wrath = 			"Bestial Wrath"
SPELLS.instant.HUNTER.tranquilizing_shot = 		"Tranquilizing Shot"
--=====================================================================--
-- Marksmanship
--=====================================================================--                                     
SPELLS.instant.HUNTER.arcane_shot = 		"Arcane Shot"
SPELLS.instant.HUNTER.concussive_shot = 	"Concussive Shot"
SPELLS.instant.HUNTER.distracting_shot = 	"Distracting Shot"
SPELLS.instant.HUNTER.multi_shot = 			"Multi-Shot"
SPELLS.instant.HUNTER.aimed_shot = 		"Aimed Shot" -- casttime
SPELLS.instant.HUNTER.scatter_shot = 		"Scatter Shot"  
SPELLS.instant.HUNTER.serpent_sting = 		"Serpent Sting"
SPELLS.instant.HUNTER.scorpid_sting = 		"Scorpid Sting"
SPELLS.instant.HUNTER.viper_sting = 		"Viper Sting"
SPELLS.instant.HUNTER.hunters_mark = 		"Hunter's Mark"
SPELLS.instant.HUNTER.deterrence = 			"Deterrence"
SPELLS.instant.HUNTER.disengage = 			"Disengage"
SPELLS.instant.HUNTER.rapid_fire = 			"Rapid Fire"
SPELLS.instant.HUNTER.flare = 				"Flare"
SPELLS.instant.HUNTER.trueshot_aura = 		"Trueshot Aura"
SPELLS.channeled.HUNTER.volley = 			"Volley"
--=====================================================================--
-- Survival
--=====================================================================-- 
SPELLS.instant.HUNTER.track_beasts = 		"Track Beasts"                      
SPELLS.instant.HUNTER.track_humanoids = 	"Track Humanoids"                     
SPELLS.instant.HUNTER.track_undead = 		"Track Undead"                       
SPELLS.instant.HUNTER.track_hidden = 		"Track Hidden"                     
SPELLS.instant.HUNTER.track_elementals = 	"Track Elementals"    
SPELLS.instant.HUNTER.track_demons = 		"Track Demons"  
SPELLS.instant.HUNTER.track_giants = 		"Track Giants" 
SPELLS.instant.HUNTER.track_dragonkin = 	"Track Dragonkin"    
SPELLS.instant.HUNTER.immolation_trap = 	"Immolation Trap"
SPELLS.instant.HUNTER.freezing_trap = 		"Freezing Trap"
SPELLS.instant.HUNTER.frost_trap = 			"Frost Trap"
SPELLS.instant.HUNTER.explosive_trap = 		"Explosive Trap"      
SPELLS.next_melee.HUNTER.raptor_strike = 	"Raptor Strike"
SPELLS.instant.HUNTER.wing_clip = 			"Wing Clip"
SPELLS.instant.HUNTER.mongoose_bite = 		"Mongoose Bite"
SPELLS.instant.HUNTER.counterattack = 		"Counterattack"
SPELLS.instant.HUNTER.feign_death = 		"Feign Death"
SPELLS.instant.HUNTER.wyvern_sting = 		"Wyvern Sting"     


--//////////////////////////////////////////////////////////////////////////--
-- Mage Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Arcane
--=====================================================================--       
SPELLS.instant.MAGE.arcane_intellect = 			"Arcane Intellect"
SPELLS.channeled.MAGE.arcane_missiles = 		"Arcane Missiles"
SPELLS.casttime.MAGE.polymorph =   				"Polymorph"
SPELLS.instant.MAGE.dampen_magic = 				"Dampen Magic"
SPELLS.instant.MAGE.slow_fall = 				"Slow Fall"
SPELLS.casttime.MAGE.arcane_explosion =			"Arcane Explosion"
SPELLS.instant.MAGE.detect_magic = 				"Detect Magic"
SPELLS.instant.MAGE.amplify_magic = 			"Amplify Magic"
SPELLS.instant.MAGE.remove_lesser_curse = 		"Remove Lesser Curse"
SPELLS.instant.MAGE.blink = 					"Blink"
SPELLS.channeled.MAGE.evocation = 				"Evocation"
SPELLS.instant.MAGE.mana_shield = 				"Mana Shield"
SPELLS.instant.MAGE.counterspell = 				"Counterspell"
SPELLS.instant.MAGE.presence_of_mind = 			"Presence of Mind"
SPELLS.instant.MAGE.mage_armor = 				"Mage Armor"
SPELLS.instant.MAGE.arcane_power = 				"Arcane Power"
SPELLS.instant.MAGE.arcane_brilliance = 		"Arcane Brilliance"
-------------------------------------------------------------------------    
SPELLS.casttime.MAGE.conjure_water =   			"Conjure Water"
SPELLS.casttime.MAGE.conjure_food =   			"Conjure Food"
SPELLS.casttime.MAGE.conjure_mana_agate =		"Conjure Mana Agate"
SPELLS.casttime.MAGE.conjure_mana_jade =		"Conjure Mana Jade"
SPELLS.casttime.MAGE.conjure_mana_citrine =		"Conjure Mana Citrine"
SPELLS.casttime.MAGE.conjure_mana_ruby =		"Conjure Mana Ruby"
-------------------------------------------------------------------------
SPELLS.casttime.MAGE.teleport_ironforge =		"Teleport: Ironforge"
SPELLS.casttime.MAGE.teleport_stormwind =		"Teleport: Stormwind"
SPELLS.casttime.MAGE.teleport_darnassus =		"Teleport: Darnassus"
SPELLS.casttime.MAGE.teleport_orgrimmar =		"Teleport: Orgrimmar"
SPELLS.casttime.MAGE.teleport_undercity =		"Teleport: Undercity"
SPELLS.casttime.MAGE.teleport_thunder_bluff =	"Teleport: Thunder Bluff"  
-------------------------------------------------------------------------
SPELLS.casttime.MAGE.portal_ironforge =			"Portal: Ironforge"
SPELLS.casttime.MAGE.portal_stormwind =			"Portal: Stormwind"
SPELLS.casttime.MAGE.portal_darnassus =			"Portal: Darnassus"
SPELLS.casttime.MAGE.portal_orgrimmar =			"Portal: Orgrimmar"
SPELLS.casttime.MAGE.portal_undercity =			"Portal: Undercity"
SPELLS.casttime.MAGE.portal_thunder_bluff =		"Portal: Thunder Bluff"
--=====================================================================--
-- Frost
--=====================================================================--
SPELLS.casttime.MAGE.frostbolt =   				"Frostbolt"    
SPELLS.instant.MAGE.frost_armor = 				"Frost Armor"    
SPELLS.instant.MAGE.frost_nova = 				"Frost Nova"     
SPELLS.channeled.MAGE.blizzard = 				"Blizzard"   
SPELLS.instant.MAGE.cold_snap = 				"Cold Snap"    
SPELLS.instant.MAGE.frost_ward = 				"Frost Ward"    
SPELLS.instant.MAGE.cone_of_cold = 				"Cone of Cold"       
SPELLS.instant.MAGE.ice_armor = 				"Ice Armor"     
SPELLS.instant.MAGE.ice_block = 				"Ice Block"  
SPELLS.instant.MAGE.ice_barrier = 				"Ice Barrier"
--=====================================================================--
-- Fire
--=====================================================================--   
SPELLS.instant.MAGE.fire_blast = 				"Fire Blast"
SPELLS.casttime.MAGE.fireball =   				"Fireball"
SPELLS.casttime.MAGE.flamestrike = 				"Flamestrike"
SPELLS.instant.MAGE.fire_ward = 				"Fire Ward"
SPELLS.casttime.MAGE.pyroblast = 				"Pyroblast"
SPELLS.casttime.MAGE.scorch = 					"Scorch"
SPELLS.instant.MAGE.blast_wave = 				"Blast Wave"
SPELLS.instant.MAGE.combustion = 				"Combustion"


--//////////////////////////////////////////////////////////////////////////--
-- Paladin Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Protection
--=====================================================================--
SPELLS.instant.PALADIN.devotion_aura = 					"Devotion Aura"
SPELLS.instant.PALADIN.divine_protection = 				"Divine Protection"
SPELLS.instant.PALADIN.hammer_of_justice = 				"Hammer of Justice"
SPELLS.instant.PALADIN.blessing_of_protection = 		"Blessing of Protection"
SPELLS.instant.PALADIN.righteous_fury = 				"Righteous Fury"
SPELLS.instant.PALADIN.blessing_of_freedom = 			"Blessing of Freedom"
SPELLS.instant.PALADIN.blessing_of_kings = 				"Blessing of Kings"
SPELLS.instant.PALADIN.concentration_aura = 			"Concentration Aura"
SPELLS.instant.PALADIN.seal_of_justice = 				"Seal of Justice"
SPELLS.instant.PALADIN.blessing_of_salvation = 			"Blessing of Salvation"
SPELLS.instant.PALADIN.shadow_resistance_aura = 		"Shadow Resistance Aura"
SPELLS.instant.PALADIN.blessing_of_sanctuary = 			"Blessing of Sanctuary"
SPELLS.instant.PALADIN.divine_intervention = 			"Divine Intervention"
SPELLS.instant.PALADIN.frost_resistance_aura = 			"Frost Resistance Aura"
SPELLS.instant.PALADIN.divine_shield = 					"Divine Shield"
SPELLS.instant.PALADIN.fire_resistance_aura = 			"Fire Resistance Aura"
SPELLS.instant.PALADIN.holy_shield = 					"Holy Shield"
SPELLS.instant.PALADIN.blessing_of_sacrifice = 			"Blessing of Sacrifice"
SPELLS.instant.PALADIN.greater_blessing_of_kings = 		"Greater Blessing of Kings"
SPELLS.instant.PALADIN.greater_blessing_of_salvation = 	"Greater Blessing of Salvation"
SPELLS.instant.PALADIN.greater_blessing_of_sanctuary = 	"Greater Blessing of Sanctuary"
--=====================================================================--
-- Retribution
--=====================================================================--
SPELLS.instant.PALADIN.blessing_of_might = 				"Blessing of Might"
SPELLS.instant.PALADIN.judgement = 						"Judgement"
SPELLS.instant.PALADIN.seal_of_the_crusader = 			"Seal of the Crusader"
SPELLS.instant.PALADIN.retribution_aura = 				"Retribution Aura"
SPELLS.instant.PALADIN.seal_of_command = 				"Seal of Command"
SPELLS.instant.PALADIN.sanctity_aura = 					"Sanctity Aura"
SPELLS.instant.PALADIN.repentance = 					"Repentance"
SPELLS.instant.PALADIN.greater_blessing_of_might = 		"Greater Blessing of Might"
--=====================================================================--
-- Holy
--=====================================================================--
SPELLS.casttime.PALADIN.holy_light =   					"Holy Light"
SPELLS.instant.PALADIN.purify = 						"Purify"
SPELLS.instant.PALADIN.lay_on_hands = 					"Lay on Hands"
SPELLS.instant.PALADIN.seal_of_righteousness = 			"Seal of Righteousness"
SPELLS.instant.PALADIN.redemption = 					"Redemption"
SPELLS.instant.PALADIN.blessing_of_wisdom = 			"Blessing of Wisdom"
SPELLS.instant.PALADIN.consecration = 					"Consecration"
SPELLS.instant.PALADIN.exorcism = 						"Exorcism"
SPELLS.casttime.PALADIN.flash_of_light = 				"Flash of Light"
SPELLS.casttime.PALADIN.turn_undead = 					"Turn Undead"
SPELLS.instant.PALADIN.sense_undead = 					"Sense Undead"
SPELLS.instant.PALADIN.divine_favor = 					"Divine Favor"
SPELLS.instant.PALADIN.seal_of_light = 					"Seal of Light"
SPELLS.instant.PALADIN.seal_of_wisdom = 				"Seal of Wisdom"
SPELLS.instant.PALADIN.blessing_of_light = 				"Blessing of Light"
SPELLS.instant.PALADIN.holy_shock = 					"Holy Shock"
SPELLS.casttime.PALADIN.summon_warhorse = 				"Summon Warhorse"
SPELLS.instant.PALADIN.cleanse = 						"Cleanse"
SPELLS.casttime.PALADIN.hammer_of_wrath = 				"Hammer of Wrath"
SPELLS.casttime.PALADIN.holy_wrath = 					"Holy Wrath"
SPELLS.instant.PALADIN.greater_blessing_of_wisdom = 	"Greater Blessing of Wisdom"
SPELLS.instant.PALADIN.greater_blessing_of_light = 		"Greater Blessing of Light"

--//////////////////////////////////////////////////////////////////////////--
-- Priest Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Discipline
--=====================================================================--
SPELLS.instant.PRIEST.power_word_fortitude = 	"Power Word: Fortitude"
SPELLS.instant.PRIEST.power_word_shield = 		"Power Word: Shield"
SPELLS.instant.PRIEST.inner_fire = 				"Inner Fire"
SPELLS.instant.PRIEST.dispel_magic = 			"Dispel Magic"
SPELLS.instant.PRIEST.inner_focus = 			"Inner Focus"
SPELLS.casttime.PRIEST.shackle_undead = 		"Shackle Undead"
SPELLS.casttime.PRIEST.mana_burn = 				"Mana Burn"
SPELLS.instant.PRIEST.divine_spirit = 			"Divine Spirit"
SPELLS.instant.PRIEST.power_infusion = 			"Power Infusion"
SPELLS.instant.PRIEST.levitate = 				"Levitate"
SPELLS.instant.PRIEST.prayer_of_fortitude = 	"Prayer of Fortitude"
-- Night Elf Only
SPELLS.channeled.PRIEST.starshards = 			"Starshards"
SPELLS.instant.PRIEST.elunes_grace = 			"Elune's Grace"
-- Human Only
SPELLS.instant.PRIEST.feedback = 				"Feedback"
--=====================================================================--
-- Holy
--=====================================================================-- 
SPELLS.casttime.PRIEST.lesser_heal = 			"Lesser Heal"
SPELLS.instant.PRIEST.renew = 					"Renew"
SPELLS.casttime.PRIEST.heal = 					"Heal"                            
SPELLS.casttime.PRIEST.flash_heal = 			"Flash Heal"
SPELLS.casttime.PRIEST.prayer_of_healing = 		"Prayer of Healing"
SPELLS.casttime.PRIEST.greater_heal = 			"Greater Heal"
SPELLS.instant.PRIEST.cure_disease = 			"Cure Disease"
SPELLS.instant.PRIEST.abolish_disease = 		"Abolish Disease"
SPELLS.casttime.PRIEST.smite = 					"Smite"    
SPELLS.casttime.PRIEST.resurrection = 			"Resurrection" 
SPELLS.instant.PRIEST.holy_nova = 				"Holy Nova"
SPELLS.casttime.PRIEST.holy_fire = 				"Holy Fire"
SPELLS.instant.PRIEST.spirit_of_redemption = 	"Spirit of Redemption"
SPELLS.casttime.PRIEST.lightwell = 				"Lightwell"
-- Human and Dwarf Only
SPELLS.instant.PRIEST.desperate_prayer = 		"Desperate Prayer"
-- Dwarf Only
SPELLS.instant.PRIEST.fear_ward = 				"Fear Ward"
--=====================================================================--
-- Shadow Magic
--=====================================================================--
SPELLS.instant.PRIEST.shadow_word_pain =	 	"Shadow Word: Pain"
SPELLS.instant.PRIEST.fade = 					"Fade"
SPELLS.casttime.PRIEST.mind_blast = 			"Mind Blast"
SPELLS.instant.PRIEST.psychic_scream = 			"Psychic Scream"
SPELLS.channeled.PRIEST.mind_flay = 			"Mind Flay"
SPELLS.casttime.PRIEST.mind_soothe = 			"Mind Soothe"
SPELLS.channeled.PRIEST.mind_vision = 			"Mind Vision"
SPELLS.casttime.PRIEST.mind_control = 			"Mind Control"
SPELLS.instant.PRIEST.shadow_protection = 		"Shadow Protection"
SPELLS.instant.PRIEST.silence = 				"Silence"
SPELLS.instant.PRIEST.vampiric_embrace = 		"Vampiric Embrace" 	
SPELLS.instant.PRIEST.shadowform = 				"Shadowform"
-- Troll Only                              	
SPELLS.instant.PRIEST.hex_of_weakness = 		"Hex of Weakness"
SPELLS.casttime.PRIEST.shadowguard = 			"Shadowguard"
-- Undead Only                             	
SPELLS.instant.PRIEST.touch_of_weakness = 		"Touch of Weakness"
SPELLS.instant.PRIEST.devouring_plague = 		"Devouring Plague"


--//////////////////////////////////////////////////////////////////////////--
-- Rogue Spells
--//////////////////////////////////////////////////////////////////////////--
SPELLS.instant.ROGUE.shoot_bow =            "Shoot Bow"
SPELLS.instant.ROGUE.shoot_crossbow =       "Shoot Crossbow"
SPELLS.instant.ROGUE.shoot_gun =            "Shoot Gun"
SPELLS.instant.ROGUE.throw =                "Throw"
--=====================================================================--
-- Assassination
--=====================================================================--
SPELLS.instant.ROGUE.eviscerate = 			"Eviscerate"
SPELLS.instant.ROGUE.slice_and_dice = 		"Slice and Dice"
SPELLS.instant.ROGUE.expose_armor = 		"Expose Armor"
SPELLS.instant.ROGUE.garrote = 				"Garrote"
SPELLS.instant.ROGUE.ambush = 				"Ambush"
SPELLS.instant.ROGUE.relentless_strikes = 	"Relentless Strikes"
SPELLS.instant.ROGUE.rupture = 				"Rupture"
SPELLS.instant.ROGUE.cheap_shot = 			"Cheap Shot"
SPELLS.instant.ROGUE.cold_blood = 			"Cold Blood"
SPELLS.instant.ROGUE.kidney_shot = 			"Kidney Shot"
--=====================================================================--
-- Combat
--=====================================================================--
SPELLS.instant.ROGUE.backstab = 			"Backstab"
SPELLS.instant.ROGUE.gouge = 				"Gouge"
SPELLS.instant.ROGUE.sinister_strike = 		"Sinister Strike"
SPELLS.instant.ROGUE.evasion = 				"Evasion"
SPELLS.instant.ROGUE.sprint = 				"Sprint"
SPELLS.instant.ROGUE.kick = 				"Kick"
SPELLS.instant.ROGUE.feint = 				"Feint"
SPELLS.instant.ROGUE.riposte = 				"Riposte"
SPELLS.instant.ROGUE.blade_fury = 			"Blade Fury"
SPELLS.instant.ROGUE.adrenaline_rush = 		"Adrenaline Rush"
--=====================================================================--
-- Subtlety
--=====================================================================--
SPELLS.instant.ROGUE.stealth = 				"Stealth"
SPELLS.instant.ROGUE.pick_pocket = 			"Pick Pocket"
SPELLS.instant.ROGUE.sap = 					"Sap"
SPELLS.instant.ROGUE.ghostly_strike = 		"Ghostly Strike"
SPELLS.instant.ROGUE.distract = 			"Distract"
SPELLS.instant.ROGUE.vanish = 				"Vanish"
SPELLS.instant.ROGUE.detect_traps = 		"Detect Traps"
SPELLS.casttime.ROGUE.disarm_trap = 		"Disarm Trap"
SPELLS.instant.ROGUE.preparation = 			"Preparation"
SPELLS.instant.ROGUE.blind = 				"Blind"
SPELLS.instant.ROGUE.hemorrhage = 			"Hemorrhage"
SPELLS.casttime.ROGUE.premeditation = 		"Premeditation"
SPELLS.instant.ROGUE.safe_fall = 			"Safe Fall"
--=====================================================================--
-- Lockpicking
--=====================================================================--
SPELLS.casttime.ROGUE.pick_lock = 			"Pick Lock"
--=====================================================================--
-- Poisons
--=====================================================================--
SPELLS.casttime.ROGUE.crippling_poison = 	"Crippling Poison"
SPELLS.casttime.ROGUE.mind_numbing_poison = "Mind Numbing Poison"
SPELLS.casttime.ROGUE.instant_poison = 		"Instant Poison"
SPELLS.casttime.ROGUE.deadly_poison = 		"Deadly Poison"
SPELLS.casttime.ROGUE.wound_poison = 		"Would Poison"
SPELLS.instant.ROGUE.blinding_powder = 		"Blinding Powder"
--[[
Rogue poisons are grouped in RPHelper, so the following are not used
but are here for reference

SPELLS.casttime.ROGUE.cripplingpoison_ii = 		"Crippling Poison II"
SPELLS.casttime.ROGUE.mind_numbingpoison_ii = 	"Mind-numbing Poison II"
SPELLS.casttime.ROGUE.mind_numbingpoison_iii = 	"Mind-numbing Poison III"
SPELLS.casttime.ROGUE.instant_poison_ii = 		"Instant Poison II"
SPELLS.casttime.ROGUE.instant_poison_iii = 		"Instant Poison III"
SPELLS.casttime.ROGUE.instant_poison_iv = 		"Instant Poison IV"
SPELLS.casttime.ROGUE.instant_poison__v = 		"Instant Poison V"
SPELLS.casttime.ROGUE.instant_poison_vi = 		"Instant Poison VI"
SPELLS.casttime.ROGUE.wound_poison_ii = 		"Wound Poison II"
SPELLS.casttime.ROGUE.wound_poison_iii = 		"Wound Poison III"
SPELLS.casttime.ROGUE.wound_poison_iv = 		"Wound Poison IV"
SPELLS.casttime.ROGUE.deadly_poison_ii = 		"Deadly Poison II"
SPELLS.casttime.ROGUE.deadly_poison_iii = 		"Deadly Poison III"
SPELLS.casttime.ROGUE.deadly_poison_iv = 		"Deadly Poison IV"
SPELLS.casttime.ROGUE.deadly_poison_v = 		"Deadly Poison V"
]]


--//////////////////////////////////////////////////////////////////////////--
-- Shaman Spells
--//////////////////////////////////////////////////////////////////////////--
--=====================================================================--
-- Elemental Combat
--=====================================================================-- 
SPELLS.instant.SHAMAN.earth_shock = 			"Earth Shock"
SPELLS.instant.SHAMAN.flame_shock = 			"Flame Shock"
SPELLS.instant.SHAMAN.frost_shock = 			"Frost Shock"
SPELLS.instant.SHAMAN.earthbind_totem = 		"Earthbind Totem"
SPELLS.instant.SHAMAN.stoneclaw_totem = 		"Stoneclaw Totem"
SPELLS.instant.SHAMAN.fire_nova_totem = 		"Fire Nova Totem"
SPELLS.instant.SHAMAN.searing_totem = 			"Searing Totem"
SPELLS.instant.SHAMAN.magma_totem = 			"Magma Totem"
SPELLS.casttime.SHAMAN.lightning_bolt = 		"Lightning Bolt"
SPELLS.instant.SHAMAN.purge = 					"Purge"
SPELLS.instant.SHAMAN.elemental_focus = 		"Elemental Focus"
SPELLS.casttime.SHAMAN.chain_lightning = 		"Chain Lightning"
--=====================================================================--
-- Enhancement
--=====================================================================--
SPELLS.instant.SHAMAN.rockbiter_weapon = 		"Rockbiter Weapon"
SPELLS.instant.SHAMAN.flametongue_weapon = 		"Flametongue Weapon"
SPELLS.instant.SHAMAN.frostbrand_weapon = 		"Frostbrand Weapon"
SPELLS.instant.SHAMAN.windfury_weapon = 		"Windfury Weapon"
SPELLS.instant.SHAMAN.stoneskin_totem = 		"Stoneskin Totem"
SPELLS.instant.SHAMAN.strength_of_earth_totem = "Strength of Earth Totem"
SPELLS.instant.SHAMAN.frost_resistance_totem = 	"Frost Resistance Totem"
SPELLS.instant.SHAMAN.fire_resistance_totem = 	"Fire Resistance Totem"
SPELLS.instant.SHAMAN.flametongue_totem = 		"Flametongue Totem"
SPELLS.instant.SHAMAN.grounding_totem = 		"Grounding Totem"
SPELLS.instant.SHAMAN.nature_resistance_totem = "Nature Resistance Totem"
SPELLS.instant.SHAMAN.windfury_totem = 			"Windfury Totem"
SPELLS.instant.SHAMAN.sentry_totem = 			"Sentry Totem"
SPELLS.instant.SHAMAN.windwall_totem = 			"Windwall Totem"
SPELLS.instant.SHAMAN.grace_of_air_totem = 		"Grace of Air Totem"
SPELLS.instant.SHAMAN.lightning_shield = 		"Lightning Shield"
SPELLS.casttime.SHAMAN.ghost_wolf = 			"Ghost Wolf"
SPELLS.instant.SHAMAN.water_breathing = 		"Water Breathing"
SPELLS.casttime.SHAMAN.far_sight = 				"Far Sight"
SPELLS.instant.SHAMAN.water_walking = 			"Water Walking"
SPELLS.casttime.SHAMAN.astral_recall = 			"Astral Recall"
SPELLS.instant.SHAMAN.elemental_mastery = 		"Elemental Mastery"
SPELLS.instant.SHAMAN.stormstrike = 			"Stormstrike"
--=====================================================================--
-- Restoration
--=====================================================================--
SPELLS.casttime.SHAMAN.healing_wave = 			"Healing Wave"
SPELLS.casttime.SHAMAN.lesser_healing_wave = 	"Lesser Healing Wave"
SPELLS.instant.SHAMAN.cure_poison = 			"Cure Poison"
SPELLS.instant.SHAMAN.cure_disease = 			"Cure Disease"
SPELLS.instant.SHAMAN.tremor_totem = 			"Tremor Totem"
SPELLS.instant.SHAMAN.poison_cleansing_totem = 	"Poison Cleansing Totem"
SPELLS.instant.SHAMAN.healing_stream_totem = 	"Healing Stream Totem"
SPELLS.instant.SHAMAN.mana_spring_totem = 		"Mana Spring Totem"
SPELLS.instant.SHAMAN.disease_cleansing_totem = "Disease Cleansing Totem"
SPELLS.instant.SHAMAN.mana_tide_totem = 		"Mana Tide Totem"
SPELLS.casttime.SHAMAN.ancestral_spirit = 		"Ancestral Spirit"
SPELLS.instant.SHAMAN.natures_swiftness = 		"Nature's Swiftness"
SPELLS.instant.SHAMAN.reincarnation = 			"Reincarnation"
SPELLS.casttime.SHAMAN.chain_heal = 			"Chain Heal"


-------------------------------------------------------------------------
-- Warlock
-------------------------------------------------------------------------
--=====================================================================--
-- Affliction
--=====================================================================--
SPELLS.instant.WARLOCK.curse_of_weakness = 		"Curse of Weakness"
SPELLS.instant.WARLOCK.curse_of_agony = 		"Curse of Agony"   
SPELLS.instant.WARLOCK.curse_of_recklessness = 	"Curse of Recklessness" 
SPELLS.instant.WARLOCK.curse_of_tongues = 		"Curse of Tongues"   
SPELLS.instant.WARLOCK.curse_of_exhaustion = 	"Curse of Exhaustion" 
SPELLS.instant.WARLOCK.curse_of_the_elements = 	"Curse of the Elements"   
SPELLS.instant.WARLOCK.curse_of_shadow = 		"Curse of Shadow"      
SPELLS.instant.WARLOCK.curse_of_doom = 			"Curse of Doom"
SPELLS.instant.WARLOCK.amplify_curse = 			"Amplify Curse"                                    
SPELLS.channeled.WARLOCK.drain_soul = 			"Drain Soul"
SPELLS.channeled.WARLOCK.drain_life = 			"Drain Life"
SPELLS.channeled.WARLOCK.drain_mana = 			"Drain Mana"                     
SPELLS.casttime.WARLOCK.corruption = 			"Corruption"
SPELLS.instant.WARLOCK.corruption = 			"Corruption"	-- Corruption can become instant with a talent
SPELLS.instant.WARLOCK.siphon_life = 			"Siphon Life"
SPELLS.instant.WARLOCK.death_coil = 			"Death Coil"                                                 
SPELLS.instant.WARLOCK.life_tap = 				"Life Tap"
SPELLS.instant.WARLOCK.dark_pact = 				"Dark Pact"      
SPELLS.casttime.WARLOCK.fear = 					"Fear"
SPELLS.casttime.WARLOCK.howl_of_terror =  		"Howl of Terror"
--=====================================================================--
-- Demonology
--=====================================================================--                       
SPELLS.instant.WARLOCK.demon_skin = 					"Demon Skin"	
SPELLS.instant.WARLOCK.demon_armor = 					"Demon Armor"
SPELLS.channeled.WARLOCK.health_funnel = 				"Health Funnel"
SPELLS.instant.WARLOCK.unending_breath = 				"Unending Breath"
SPELLS.instant.WARLOCK.fel_domination = 				"Fel Domination"              
SPELLS.instant.WARLOCK.sense_demons = 					"Sense Demons"                                  
SPELLS.instant.WARLOCK.detect_lesser_invisibility = 	"Detect Lesser Invisibility"                             
SPELLS.instant.WARLOCK.detect_invisibility = 			"Detect Invisibility"                            
SPELLS.instant.WARLOCK.detect_greater_invisibility = 	"Detect Greater Invisibility"
SPELLS.casttime.WARLOCK.banish = 						"Banish"
SPELLS.casttime.WARLOCK.eye_of_kilrogg = 				"Eye of Kilrogg"
SPELLS.instant.WARLOCK.demonic_sacrifice = 				"Demonic Sacrifice"
SPELLS.casttime.WARLOCK.ritual_of_summoning = 			"Ritual of Summoning"
SPELLS.casttime.WARLOCK.enslave_demon = 				"Enslave Demon"
SPELLS.instant.WARLOCK.shadow_ward = 					"Shadow Ward"
SPELLS.instant.WARLOCK.soul_link = 						"Soul Link"
SPELLS.casttime.WARLOCK.create_healthstone = 	"Create Healthstone"
SPELLS.casttime.WARLOCK.create_soulstone = 		"Create Soulstone"
SPELLS.casttime.WARLOCK.create_spellstone = 	"Create Spellstone"
SPELLS.casttime.WARLOCK.create_firestone = 		"Create Firestone"
SPELLS.casttime.WARLOCK.summon_imp =  			"Summon Imp"
SPELLS.casttime.WARLOCK.summon_voidwalker = 	"Summon Voidwalker"
SPELLS.casttime.WARLOCK.summon_succubus =  		"Summon Succubus"
SPELLS.casttime.WARLOCK.summon_felhunter =  	"Summon Felhunter"
SPELLS.casttime.WARLOCK.summon_felsteed = 		"Summon Felsteed"
SPELLS.casttime.WARLOCK.summon_dreadsteed = 	"Summon Dreadsteed"
SPELLS.casttime.WARLOCK.inferno = 				"Inferno"
SPELLS.casttime.WARLOCK.ritual_of_doom = 		"Ritual of Doom"
--=====================================================================--
-- Destruction
--=====================================================================--  
SPELLS.casttime.WARLOCK.immolate = 				"Immolate"
SPELLS.casttime.WARLOCK.searing_pain = 			"Searing Pain"
SPELLS.casttime.WARLOCK.shadow_bolt = 			"Shadow Bolt" 
SPELLS.channeled.WARLOCK.rain_of_fire = 		"Rain of Fire"       
SPELLS.instant.WARLOCK.shadowburn = 			"Shadowburn"              
SPELLS.channeled.WARLOCK.hellfire = 			"Hellfire"  
SPELLS.instant.WARLOCK.conflagrate = 			"Conflagrate"    
SPELLS.casttime.WARLOCK.soul_fire = 			"Soul Fire"



-------------------------------------------------------------------------
-- Warrior
-------------------------------------------------------------------------
--=====================================================================--
-- Arms
--=====================================================================--
SPELLS.instant.WARRIOR.charge = 			"Charge"
SPELLS.instant.WARRIOR.rend = 				"Rend"
SPELLS.instant.WARRIOR.thunder_clap = 		"Thunder Clap"
SPELLS.instant.WARRIOR.hamstring = 			"Hamstring"
SPELLS.next_melee.WARRIOR.heroic_strike = 	"Heroic Strike"
SPELLS.instant.WARRIOR.overpower = 			"Overpower"
SPELLS.instant.WARRIOR.mocking_blow = 		"Mocking Blow"
SPELLS.instant.WARRIOR.anger_management = 	"Anger Management"
SPELLS.instant.WARRIOR.retaliation = 		"Retaliation"                       
SPELLS.instant.WARRIOR.sweeping_strikes = 	"Sweeping Strikes"                         
SPELLS.instant.WARRIOR.mortal_strike = 		"Mortal Strike"
--=====================================================================--
-- Fury
--=====================================================================--
SPELLS.instant.WARRIOR.battle_shout = 		"Battle Shout"
SPELLS.instant.WARRIOR.demoralizing_shout = "Demoralizing Shout"
SPELLS.next_melee.WARRIOR.cleave = 			"Cleave"
SPELLS.instant.WARRIOR.piercing_howl = 		"Piercing Howl"
SPELLS.instant.WARRIOR.intimidating_shout = "Intimidating Shout"
SPELLS.instant.WARRIOR.execute = 			"Execute"
SPELLS.instant.WARRIOR.challenging_shout = 	"Challenging Shout"
SPELLS.instant.WARRIOR.death_wish = 		"Death Wish"
SPELLS.instant.WARRIOR.intercept = 			"Intercept"
SPELLS.casttime.WARRIOR.slam = 				"Slam"
SPELLS.instant.WARRIOR.berserker_rage = 	"Berserker Rage"
SPELLS.instant.WARRIOR.whirlwind = 			"Whirlwind"
SPELLS.instant.WARRIOR.pummel = 			"Pummel"
SPELLS.instant.WARRIOR.bloodthirst = 		"Bloodthirst"
SPELLS.instant.WARRIOR.recklessness = 		"Recklessness"
--=====================================================================--
-- Protection
--=====================================================================--   
SPELLS.instant.WARRIOR.bloodrage = 			"Bloodrage"
SPELLS.instant.WARRIOR.sunder_armor = 		"Sunder Armor"
SPELLS.instant.WARRIOR.shield_bash = 		"Shield Bash"
SPELLS.instant.WARRIOR.revenge = 			"Revenge"
SPELLS.instant.WARRIOR.shield_block = 		"Shield Block"
SPELLS.instant.WARRIOR.last_stand = 		"Last Stand"
SPELLS.instant.WARRIOR.disarm = 			"Disarm"
SPELLS.instant.WARRIOR.shield_wall = 		"Shield Wall"
SPELLS.instant.WARRIOR.concussion_blow = 	"Concussion Blow"
SPELLS.instant.WARRIOR.shield_slam = 		"Shield Slam"

SPELLS.instant.WARRIOR.shoot_gun =          "Shoot Gun"
SPELLS.instant.WARRIOR.shoot_bow =          "Shoot Bow"
SPELLS.instant.WARRIOR.shoot_crossbow =     "Shoot Crossbow"
SPELLS.instant.WARRIOR.throw =              "Throw"

