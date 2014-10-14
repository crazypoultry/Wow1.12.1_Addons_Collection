if ( GetLocale() == "deDE" ) then

--/////////////////////////////////////////////////////////////////////--
-- SPELLS with Cast Times  (Not instant or channeled)
--/////////////////////////////////////////////////////////////////////--
-------------------------------------------------------------------------
-- Druid
-------------------------------------------------------------------------
-- Feral Combat

-- Balance
SPELLS.casttime.DRUID.wrath = 				"Zorn"
SPELLS.casttime.DRUID.entangling_roots = 	"Wurzeln"
SPELLS.casttime.DRUID.thorns = 				"Dornen"
SPELLS.casttime.DRUID.hibernate = 			"Winterschlaf"
SPELLS.casttime.DRUID.starfire = 			"Sternenfeuer"
SPELLS.casttime.DRUID.soothe_animal = 		"Tier bes\195\164nftigen"

-- Restoration
SPELLS.casttime.DRUID.healing_touch = 		"Heilung"
SPELLS.casttime.DRUID.regrowth = 			"Nachwachsen"
SPELLS.casttime.DRUID.rebirth = 			"Wiedergeburt"



-------------------------------------------------------------------------
-- Hunter
-------------------------------------------------------------------------
-- Beast Mastery
SPELLS.casttime.HUNTER.eyes_of_the_beast = 	"Augen des Wildtiers"
SPELLS.casttime.HUNTER.scare_beast = 		"Wildtier \195\164ngstigen"

-- Marksmanship
SPELLS.casttime.HUNTER.aimed_shot = 		"Gezielter Schuss"

-- Survival


-------------------------------------------------------------------------
-- Mage
-------------------------------------------------------------------------
-- Arcane
SPELLS.casttime.MAGE.conjure_water =   		"Wasser herbeizaubern"
SPELLS.casttime.MAGE.conjure_food =   		"Essen herbeizaubern"
SPELLS.casttime.MAGE.conjure_mana_agate =	"Mana Achat herbeizaubern"
SPELLS.casttime.MAGE.conjure_mana_jade =	"Mana Jadestein herbeizaubern"
SPELLS.casttime.MAGE.conjure_mana_citrine =	"Mana Citrin herbeizaubern"
SPELLS.casttime.MAGE.conjure_mana_ruby =	"Mana Rubin herbeizaubern"

SPELLS.casttime.MAGE.polymorph =   			"Verwandlung"
SPELLS.casttime.MAGE.arcane_explosion =		"Arkane Explosion"

SPELLS.casttime.MAGE.teleport_ironforge =		"Teleportieren: Ironforge"
SPELLS.casttime.MAGE.teleport_stormwind =		"Teleportieren: Stormwind"
SPELLS.casttime.MAGE.teleport_darnassus =		"Teleportieren: Darnassus"

SPELLS.casttime.MAGE.teleport_orgrimmar =		"Teleportieren: Orgrimmar"
SPELLS.casttime.MAGE.teleport_undercity =		"Teleportieren: Undercity"
SPELLS.casttime.MAGE.teleport_thunder_bluff =	"Teleportieren: Thunder Bluff"

SPELLS.casttime.MAGE.portal_ironforge =			"Portal: Ironforge"
SPELLS.casttime.MAGE.portal_stormwind =			"Portal: Stormwind"
SPELLS.casttime.MAGE.portal_darnassus =			"Portal: Darnassus"

SPELLS.casttime.MAGE.portal_orgrimmar =			"Portal: Orgrimmar"
SPELLS.casttime.MAGE.portal_undercity =			"Portal: Undercity"
SPELLS.casttime.MAGE.portal_thunder_bluff =		"Portal: Thunder Bluff"

-- Frost
SPELLS.casttime.MAGE.frostbolt =   			"Frostblitz"

-- Fire
SPELLS.casttime.MAGE.fireball =   			"Feuerball"
SPELLS.casttime.MAGE.flamestrike = 			"Feuerschlag"
SPELLS.casttime.MAGE.pyroblast = 			"Pyroschlag"
SPELLS.casttime.MAGE.scorch = 				"Versengen"



-------------------------------------------------------------------------
-- Paladin
-------------------------------------------------------------------------
-- Protection

-- Retribution

-- Holy
SPELLS.casttime.PALADIN.holy_light =   		"Heiliges Licht"
SPELLS.casttime.PALADIN.flash_of_light = 	"Lichtblitz"
SPELLS.casttime.PALADIN.turn_undead = 		"Untote vertreiben"
SPELLS.casttime.PALADIN.summon_warhorse = 	"Kriegspferd beschw\195\182ren"
SPELLS.casttime.PALADIN.hammer_of_wrath = 	"Hammer der Gerechtigkeit"
SPELLS.casttime.PALADIN.holy_wrath = 		"Heiliger Zorn"



-------------------------------------------------------------------------
-- Priest
-------------------------------------------------------------------------
-- Holy
SPELLS.casttime.PRIEST.lesser_heal = 		"Geringes Heilen"
SPELLS.casttime.PRIEST.heal = 				"Heilen"                            
SPELLS.casttime.PRIEST.flash_heal = 		"Blitzheilung"
SPELLS.casttime.PRIEST.prayer_of_healing = 	"Gebet der Heilung"
SPELLS.casttime.PRIEST.greater_heal = 		"Gro\195\159es Heilen"
    
SPELLS.casttime.PRIEST.smite = 				"G\195\182ttliche Pein"    
SPELLS.casttime.PRIEST.resurrection = 		"Wiederbeleben" 
SPELLS.casttime.PRIEST.holy_fire = 			"Heiliges Feuer"

-- Shadow Magic
SPELLS.casttime.PRIEST.mind_blast = 		"Gedankenschlag"
SPELLS.casttime.PRIEST.mind_control = 		"Gedankenkontrolle"
SPELLS.casttime.PRIEST.mind_soothe = 		"Gedankenbes\195\164nftigung"
SPELLS.casttime.PRIEST.shadowguard = 		"Schattenschutz"

-- Discipline
SPELLS.casttime.PRIEST.shackle_undead = 	"Untote fesseln"
SPELLS.casttime.PRIEST.mana_burn = 			"Manabrand"



-------------------------------------------------------------------------
-- Rogue
-------------------------------------------------------------------------
-- Lockpicking
SPELLS.casttime.ROGUE.pick_lock = 			"Schloss knacken"

-- Poisons
SPELLS.casttime.ROGUE.crippling_poison = 	"Verkr\195\188ppelndes Gift"
SPELLS.casttime.ROGUE.mind_numbing_poison = "Gedankenbenebelndes Gift"
SPELLS.casttime.ROGUE.instant_poison = 		"Sofort wirkendes Gift"
SPELLS.casttime.ROGUE.deadly_poison = 		"T\195\182dliches Gift"
SPELLS.casttime.ROGUE.wound_poison = 		"Wundgift"

-- Subtlety
SPELLS.casttime.ROGUE.disarm_trap = 		"Falle entsch\195\164rfen"
SPELLS.casttime.ROGUE.premeditation = 		"Fallen entdecken"

--[[
Rogue poisons are grouped in RPHelper, so the following are not used
but are here for reference

SPELLS.casttime.ROGUE.cripplingpoison_ii = 		"Verkr\195\188ppelndes Gift II"
SPELLS.casttime.ROGUE.mind_numbingpoison_ii = 	"Gedankenbenebelndes Gift II"
SPELLS.casttime.ROGUE.mind_numbingpoison_iii = 	"Gedankenbenebelndes Gift III"
SPELLS.casttime.ROGUE.instant_poison_ii = 		"Sofort wirkendes Gift II"
SPELLS.casttime.ROGUE.instant_poison_iii = 		"Sofort wirkendes Gift III"
SPELLS.casttime.ROGUE.instant_poison_iv = 		"Sofort wirkendes Gift IV"
SPELLS.casttime.ROGUE.instant_poison__v = 		"Sofort wirkendes Gift V"
SPELLS.casttime.ROGUE.instant_poison_vi = 		"Sofort wirkendes Gift VI"
SPELLS.casttime.ROGUE.wound_poison_ii = 		"Wundgift II"
SPELLS.casttime.ROGUE.wound_poison_iii = 		"Wundgift III"
SPELLS.casttime.ROGUE.wound_poison_iv = 		"Wundgift IV"
SPELLS.casttime.ROGUE.deadly_poison_ii = 		"T\195\182dliches Gift II"
SPELLS.casttime.ROGUE.deadly_poison_iii = 		"T\195\182dliches Gift III"
SPELLS.casttime.ROGUE.deadly_poison_iv = 		"T\195\182dliches Gift IV"
SPELLS.casttime.ROGUE.deadly_poison_v = 		"T\195\182dliches Gift V"
]]


-------------------------------------------------------------------------
-- Shaman
-------------------------------------------------------------------------
-- Elemental
SPELLS.casttime.SHAMAN.lightning_bolt = 		"Blitzschlag"
SPELLS.casttime.SHAMAN.chain_lightning = 		"Kettenblitz"

-- Enhancement
SPELLS.casttime.SHAMAN.ghost_wolf = 			"Geisterwolf"
SPELLS.casttime.SHAMAN.far_sight = 				"Fernsicht"
SPELLS.casttime.SHAMAN.astral_recall = 			"Astraler R\195\188ckruf"

-- Restoration
SPELLS.casttime.SHAMAN.healing_wave = 			"Heilwelle"
SPELLS.casttime.SHAMAN.lesser_healing_wave =	"Geringe Heilwelle"
SPELLS.casttime.SHAMAN.ancestral_spirit = 		"Geist der Ahnen"
SPELLS.casttime.SHAMAN.chain_heal = 			"Kettenheilen"



-------------------------------------------------------------------------
-- Warlock
-------------------------------------------------------------------------
-- Affliction
SPELLS.casttime.WARLOCK.corruption = 		"Verderbnis"
SPELLS.casttime.WARLOCK.fear = 				"Furcht"
SPELLS.casttime.WARLOCK.howl_of_terror =  	"Schreckgeheul"

-- Demonology 	
SPELLS.casttime.WARLOCK.banish = 				"Verbannen"
SPELLS.casttime.WARLOCK.eye_of_kilrogg = 		"Auge von Kilrogg"
SPELLS.casttime.WARLOCK.ritual_of_summoning = 	"Dunkler Pakt"
SPELLS.casttime.WARLOCK.enslave_demon = 		"D\195\164monensklave"

SPELLS.casttime.WARLOCK.create_healthstone = 	"Gesundheitsstein herstellen"
SPELLS.casttime.WARLOCK.create_soulstone = 		"Seelenstein herstellen"
SPELLS.casttime.WARLOCK.create_spellstone = 	"Zauberstein herstellen"
SPELLS.casttime.WARLOCK.create_firestone = 		"Feuerstein herstellen"

SPELLS.casttime.WARLOCK.summon_imp =  		"Imp besch\195\182ren"
SPELLS.casttime.WARLOCK.summon_voidwalker = "Voidwalker besch\195\182ren"
SPELLS.casttime.WARLOCK.summon_succubus =  	"Succubus besch\195\182ren"
SPELLS.casttime.WARLOCK.summon_felhunter =  "Teufelsj\195\164ger besch\195\182ren"
SPELLS.casttime.WARLOCK.summon_felsteed = 	"Teufelsross besch\195\182ren"

-- Destruction      
SPELLS.casttime.WARLOCK.immolate = 			"Feuerbrand"
SPELLS.casttime.WARLOCK.searing_pain = 		"Fluch der Pein"
SPELLS.casttime.WARLOCK.shadow_bolt = 		"Schattenblitz"
SPELLS.casttime.WARLOCK.soul_fire = 		"Seelendieb"



-------------------------------------------------------------------------
-- Warrior
-------------------------------------------------------------------------
SPELLS.casttime.WARRIOR.slam = 				"Donnerknall"

end