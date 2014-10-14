lazyScript.metadata:updateRevisionFromKeyword("$Revision: 745 $")

lsLocale = {}

lsLocale.enUS = {}

-- Popup dialog text
lsLocale.enUS.INCOMPATIBLE_ADDON = "%s is incompatible with %s. Please update to the latest versions."
lsLocale.enUS.DELETE_FORM = "Are you sure you want to delete the '%s' form?"

-- Initiate spell casting
lsLocale.enUS.SPELLCASTOTHERSTART      = "(.+) begins to cast (.+)."
lsLocale.enUS.SPELLPERFORMOTHERSTART   = "(.+) begins to perform (.+)."

--Spell type catches
lsLocale.enUS.SPELLTEXT = {
   ".+'s (.+) crits .+ for %d+ (.+) damage.",
   ".+'s (.+) hits .+ for %d+ (.+) damage.",
   "You suffer %d+ (.+) damage from .+'s (.+).", -- You suffer 3 frost damage from Rabbit's Ice Nova.
}

-- The class of spell damage
lsLocale.enUS.SPELLTYPE = {
   fire     = "Fire",
   frost    = "Frost",
   nature   = "Nature",
   shadow   = "Shadow",
   arcane   = "Arcane",
   holy     = "Holy",
}

lsLocale.enUS.MOUNTED_BUFF_TT    = "Increases speed"

-- Dodge, parry, block, resist
lsLocale.enUS.PLAYER_DODGE          = ".+ attacks%. You dodge%."
lsLocale.enUS.PLAYER_DODGE_SPELL    = ".+'s? .+ was dodged%."           -- GUESS
lsLocale.enUS.PLAYER_PARRY          = ".+ attacks%. You parry%."
lsLocale.enUS.PLAYER_PARRY_SPELL    = ".+'s? .+ was parried%."          -- GUESS
lsLocale.enUS.PLAYER_BLOCK          = ".+ attacks%. You block%."
lsLocale.enUS.PLAYER_BLOCK_SPELL    = ".+'s? .+ was blocked%."          -- GUESS
lsLocale.enUS.PLAYER_RESIST_SPELL   = ".+'s? .+ was resisted%."
lsLocale.enUS.TARGET_DODGE          = "You attack%. .+ dodges%."
lsLocale.enUS.TARGET_DODGE_SPELL    = "Your .+ was dodged by .+%."      -- GUESS
lsLocale.enUS.TARGET_PARRY          = "You attack%. .+ parries%."
lsLocale.enUS.TARGET_PARRY_SPELL    = "Your .+ was parried by .+%."     -- GUESS
lsLocale.enUS.TARGET_BLOCK          = "You attack%. .+ blocks%."
lsLocale.enUS.TARGET_BLOCK_SPELL    = "Your .+ was blocked by .+%."     -- GUESS
lsLocale.enUS.TARGET_RESIST_SPELL   = "Your .+ was resisted by .+%."

-- Warsong gulch announcements
lsLocale.enUS.BG_WSG_ZONE = "Warsong Gulch"
lsLocale.enUS.BG_WSG_FLAG_PICKED_UP = "The %s [fF]lag was picked up by (.+)!"
lsLocale.enUS.BG_WSG_FLAG_CAPTURED = "captured the %s flag!"
lsLocale.enUS.BG_WSG_FLAG_DROPPED = "The %s flag was dropped by"
lsLocale.enUS.BG_WSG_FLAG_RETURNED = "The %s flag was returned to its base by"

lsLocale.enUS.DUEL_COUNTDOWN        = "Duel starting: (%d+)"
lsLocale.enUS.DUEL_WINNER_KNOCKOUT  = "(.+) has defeated (.+) in a duel"
lsLocale.enUS.DUEL_WINNER_RETREAT   = "(.+) has fled from (.+) in a duel"

lsLocale.enUS.REMAINING = "(%d+) minutes remaining."

lsLocale.enUS.GANKED = "Ganked By: %s Count: %d"
-- COMBATHITCRITOTHERSELF = "%s crits you for %d.";
-- COMBATHITOTHERSELF = "%s hits you for %d.";
lsLocale.enUS.GANKED_CHATS = {
   "(.+)'s .+ crits you for",
   "(.+)'s .+ hits you for",
   "(.+) crits you for",
   "(.+) hits you for",
}

-- NPC is fleeing
lsLocale.enUS.NPC_FLEE_MSG = "%%s attempts to run away in fear!"

-- When something is immune to your spell, such as poison etc.
lsLocale.enUS.IMMUNE = "Your (.+) failed. (.+) is immune."

-- These are creatures that cast divine protection on themselves
-- "Phasing" creature? Any ideas what this is from?
lsLocale.enUS.IMMUNITYPROBLEMCREATURES = {
   "Scarlet",
   "Crimson",
   "Phasing",
   "Doan",
   "Gurubashi",
   "Springvale",
   "Arugal",
}

-- Localized instance names
lsLocale.enUS.INSTANCES = {
   "Ragefire Chasm",
   "Deadmines",
   "Wailing Caverns",
   "Shadowfang Keep",
   "The Stockades",
   "Blackfathom Depths",
   "Gnomeregan",
   "Razorfen Kraul",
   "The Scarlet Monastery",
   "Razorfen Downs",
   "Uldaman",
   "Maraudon",
   "Zul'Farrak",
   "The Sunken Temple",
   "Blackrock Depths",
   "Blackrock Spire",
   "Stratholme",
   "Dire Maul",
   "Scholomance",
   "Onyxia's Lair",
   "Ruins of Ahn'Qiraj",
   "Zul'Gurub",
   "Molten Core",
   "Blackwing Lair",
   "Temple of Ahn'Qiraj",
   "Naxxramas Necropolis",
}

-- Needed for many of the -ifTargetIs=Slowed etc.
lsLocale.enUS.SLOWED_TTS = {
   "Movement slowed",
   "Movement speed slowed",         -- Hunter Frost Trap
   "Movement speed reduced",
}
-- Cheapshot or kidneyshot
lsLocale.enUS.STUNNED_TTS = {
   "Stunned",
}
-- Damage over time text like shadow word pain
lsLocale.enUS.DOT_TTS = {
   "(.+) damage over (%d+) sec",
   "(.+) damage every (%d+) sec",
   "(.+) damage inflicted every (%d+) sec",
}
-- Fear spells like psychic scream
lsLocale.enUS.FEAR_TTS = {
   "Intimidated",
   "Fleeing in [fF]ear",
   "Running in [fF]ear",
   "Feared",

}
lsLocale.enUS.IMMOBILE_TTS = {
   "Immobilized",
   "Frozen in place",
   "Unable to move",       --- Where is this from?
   "Rooted",
}
lsLocale.enUS.ASLEEP_TTS = {
   "Asleep",
}
lsLocale.enUS.DISORIENTED_TTS = {
   "Disoriented",
}
lsLocale.enUS.INCAPACITATED_TTS = {
   "Incapacitated",
}

lsLocale.enUS.BUFF_TTS = {
   berserking           = "Berserking",
   bloodFury            = "Blood Fury",
   cannibalize          = "Cannibalize",
   brainFood            = "Brain Food",
   dazed                = "Dazed",
   drink                = "Drink",
   firstAid             = "First Aid",
   fishFood             = "Food",
   food                 = "Food",
   recentlyBandaged     = "Recently Bandaged",
   shadowmeld           = "Shadowmeld",
   silverwingFlag       = "Silverwing Flag",
   warsongFlag          = "Warsong Flag",
   wellFed              = "Well Fed",

   --Rogue Buffs
   adrenaline           = "Adrenaline Rush",
   bladeFlurry          = "Blade Flurry",
   blind                = "Blind",
   cs                   = "Cheap Shot",
   coldBlood            = "Cold Blood",
   evasion              = "Evasion",
   expose               = "Expose Armor",
   garrote              = "Garrote",
   ghostly              = "Ghostly Strike",
   gouge                = "Gouge",
   hemo                 = "Hemorrhage",
   ks                   = "Kidney Shot",
   remorseless          = "Remorseless",
   rupture              = "Rupture",
   sap                  = "Sap",
   snd                  = "Slice and Dice",
   stealth              = "Stealth",
   vanish               = "Vanish",

   --Priest Buffs
   abolishDisease       = "Abolish Disease",
   devouringPlague      = "Devouring Plague",
   divineSpirit         = "Divine Spirit",
   elunesGrace          = "Elune's Grace",
   fade                 = "Fade",
   fearWard             = "Fear Ward",
   feedback             = "Feedback",
   hexWeakness          = "Hex of Weakness",
   holyFire             = "Holy Fire",
   innerFire            = "Inner Fire",
   innerFocus           = "Inner Focus",
   levitate             = "Levitate",
   lightwell            = "Lightwell",
   lightwellRenew       = "Lightwell Renew",
   mindControl          = "Mind Control",
   mindFlay             = "Mind Flay",
   mindSoothe           = "Mind Soothe",
   mindVision           = "Mind Vision",
   powerInfusion        = "Power Infusion",
   pwf                  = "Power Word: Fortitude",
   pws                  = "Power Word: Shield",
   prf                  = "Prayer of Fortitude",
   prsp                 = "Prayer of Shadow Protection",
   prs                  = "Prayer of Spirit",
   psychicScream        = "Psychic Scream",
   renew                = "Renew",
   shackleUndead        = "Shackle Undead",
   shadowProtection     = "Shadow Protection",
   swp                  = "Shadow Word: Pain",
   shadowform           = "Shadowform",
   shadowguard          = "Shadowguard",
   shadowVulnerability  = "Shadow Vulnerability",
   spiritTap            = "Spirit Tap",
   starshards           = "Starshards",
   touchWeakness        = "Touch of Weakness",
   vampiricEmbrace      = "Vampiric Embrace",
   weakenedSoul         = "Weakened Soul",

   -- Warrior Buffs
   battleShout          = "Battle Shout",
   berserkerRage        = "Berserker Rage",
   bloodrage            = "Bloodrage",
   challengingShout     = "Challenging Shout",
   concussionBlow       = "Concussion Blow",
   deathWish            = "Death Wish",
   demoShout            = "Demoralizing Shout",
   disarm               = "Disarm",
   hamstring            = "Hamstring",
   intimidatingShout    = "Intimidating Shout",
   lastStand            = "Last Stand",
   mockingBlow          = "Mocking Blow",
   mortalStrike         = "Mortal Strike",
   piercingHowl         = "Piercing Howl",
   recklessness         = "Recklessness",
   rend                 = "Rend",
   retaliation          = "Retaliation",
   shieldBlock          = "Shield Block",
   shieldWall           = "Shield Wall",
   sunder               = "Sunder Armor",
   sweepingStrikes      = "Sweeping Strikes",
   thunderClap          = "Thunder Clap",
   whirlwind            = "Whirlwind",

   -- Druid Buffs
   bear                 = "Bear Form",
   aquatic              = "Aquatic Form",
   cat                  = "Cat Form",
   travel               = "Travel Form",
   direBear             = "Dire Bear Form",
   moonkin              = "Moonkin Form",

   prowl                = "Prowl",
   rake                 = "Rake",
   rip                  = "Rip",
   dash                 = "Dash",
   pounce               = "Pounce Bleed",
   tigersFury           = "Tiger's Fury",

   bash                 = "Bash",
   charge               = "Feral Charge Effect",
   demoralize           = "Demoralizing Roar",
   enrage               = "Enrage",
   frenziedRegen        = "Frenzied Regeneration",

   abolishPoison        = "Abolish Poison",
   barkskin             = "Barkskin",
   faerieFire           = "Faerie Fire",
   gotw                 = "Gift of the Wild",
   grasp                = "Nature's Grasp",
   hibernate            = "Hibernate",
   innervate            = "Innervate",
   moonfire             = "Moonfire",
   motw                 = "Mark of the Wild",
   ns                   = "Nature's Swiftness",
   ooc                  = "Omen of Clarity",
   regrowth             = "Regrowth",
   rejuv                = "Rejuvenation",
   roots                = "Entangling Roots",
   soothe               = "Soothe Animal",
   swarm                = "Insect Swarm",
   thorns               = "Thorns",
   tranquility          = "Tranquility",

   -- Hunter Buffs
   aspectBeast          = "Aspect of the Beast",
   aspectCheetah        = "Aspect of the Cheetah",
   aspectHawk           = "Aspect of the Hawk",
   aspectPack           = "Aspect of the Pack",
   aspectMonkey         = "Aspect of the Monkey",
   aspectWild           = "Aspect of the Wild",
   bestialWrath         = "Bestial Wrath",
   concussive           = "Concussive Shot",
   eagleEye             = "Eagle Eye",
   eotb                 = "Eyes of the Beast",
   explosiveTrap        = "Explosive Trap Effect",
   feedPet              = "Feed Pet Effect",
   feign                = "Feign Death",
   frostTrap            = "Frost Trap Aura",
   freezingTrap         = "Freezing Trap",
   furiousHowl          = "Furious Howl",
   huntersMark          = "Hunter's Mark",
   immolationTrap       = "Immolation Trap Effect",
   intimidate           = "Intimidation",
   quickShots           = "Quick Shots",
   rapidFire            = "Rapid Fire",
   scare                = "Scare Beast",
   scatter              = "Scatter Shot",
   scorpid              = "Scorpid Sting",
   serpent              = "Serpent Sting",
   trueshot             = "Trueshot Aura",
   viper                = "Viper Sting",
   wingClip             = "Wing Clip",
   wyvern               = "Wyvern Sting",
   wyvernCC             = "Wyvern Sting",
   wyvernDot            = "Wyvern Sting",

   -- Mage Buffs
   amplifyMagic         = "Amplify Magic",
   brilliance           = "Arcane Brilliance",
   combustion           = "Combustion",
   dampenMagic          = "Dampen Magic",
   evocation            = "Evocation",
   fireVulnerability    = "Fire Vulnerability",
   fireWard             = "Fire Ward",
   frostWard            = "Frost Ward",
   frostArmor           = "Frost Armor",
   frostbolt            = "Frostbolt",
   iceArmor             = "Ice Armor",
   iceBarrier           = "Ice Barrier",
   iceBlock             = "Ice Block",
   ignite               = "Ignite",
   intellect            = "Arcane Intellect",
   mageArmor            = "Mage Armor",
   manaShield           = "Mana Shield",
   polymorph            = "Polymorph",
   polymorphPig         = "Polymorph: Pig",
   polymorphTurtle      = "Polymorph: Turtle",

   -- Paladin Buffs
   concAura             = "Concentration Aura",
   devAura              = "Devotion Aura",
   fireAura             = "Fire Resistance Aura",
   retAura              = "Retribution Aura",
   sanctAura            = "Sanctity Aura",
   shadowAura           = "Shadow Resistance Aura",
   blessFree            = "Blessing of Freedom",
   blessKings           = "Blessing of Kings",
   blessLight           = "Blessing of Light",
   blessMight           = "Blessing of Might",
   blessProt            = "Blessing of Protection",
   blessSac             = "Blessing of Sacrifice",
   blessSlv             = "Blessing of Salvation",
   blessSnct            = "Blessing of Sanctuary",
   blessWisdom          = "Blessing of Wisdom",
   divFavor             = "Divine Favor",
   divProt              = "Divine Protection",
   divShield            = "Divine Shield",
   forbearance          = "Forbearance",
   gBlessKings          = "Greater Blessing of Kings",
   gBlessLight          = "Greater Blessing of Light",
   gBlessMight          = "Greater Blessing of Might",
   gBlessSlv            = "Greater Blessing of Salvation",
   gBlessSnct           = "Greater Blessing of Sanctuary",
   gBlessWisdom         = "Greater Blessing of Wisdom",
   holyShield           = "Holy Shield",
   redoubt              = "Redoubt",
   repentance           = "Repentance",
   rightFury            = "Righteous Fury",
   sealCommand          = "Seal of Command",
   sealCrusader         = "Seal of the Crusader",
   sealJustice          = "Seal of Justice",
   sealLight            = "Seal of Light",
   sealRight            = "Seal of Righteousness",
   sealWisdom           = "Seal of Wisdom",

   judgeCrusader        = "Judgement of the Crusader",
   judgeJustice         = "Judgement of Justice",
   judgeLight           = "Judgement of Light",
   judgeWisdom          = "Judgement of Wisdom",

   -- Shaman buffs
   lightShield          = "Lightning Shield",
   ghostwolf            = "Ghost Wolf",

   fireResistTotem      = "Fire Resistance",
   flameTotem           = "FlameTongue",
   flameShock           = "Flame Shock",
   frostResistTotem     = "Frost Resistance",
   graceTotem           = "Grace of Air",
   hsTotem              = "Healing Stream",
   msTotem              = "Mana Spring",
   mtTotem              = "Mana Tide",
   natureResistTotem    = "Nature Resistance",
   skinTotem            = "Stoneskin",
   strengthTotem        = "Strength of Earth",
   tranquilTotem        = "Tranquil Air",
   wfTotem              = "Windfury",
   windwallTotem        = "Windwall",

   -- Warlock buffs
   amplifyCurse         = "Amplify Curse",
   corruption           = "Corruption",
   curseAgony           = "Curse of Agony",
   curseElements        = "Curse of Elements",
   curseExhaustion      = "Curse of Exhaustion",
   curseReckless        = "Curse of Recklessness",
   curseShadow          = "Curse of Shadow",
   curseTongues         = "Curse of Tongues",
   curseWeakness        = "Curse of Weakness",
   banish               = "Banish",
   deathCoil            = "Death Coil",
   demonArmor           = "Demon Armor",
   demonSkin            = "Demon Skin",
   detectGreaterInvis   = "Detect Greater Invisibility",
   detectInvis          = "Detect Invisibility",
   detectLesserInvis    = "Detect Lesser Invisibility",
   drainLife            = "Drain Life",
   drainMana            = "Drain Mana",
   drainSoul            = "Drain Soul",
   fear                 = "Fear",
   funnel               = "Health Funnel",
   hellfire             = "Hellfire",
   howl                 = "Howl of Terror",
   immolate             = "Immolate",
   sacrifice            = "Sacrifice",
   seduction            = "Seduction",
   senseDemons          = "Sense Demons",
   shadowburn           = "Shadowburn",
   shadowTrance         = "Shadow Trance",
   shadowWard           = "Shadow Ward",
   siphon               = "Siphon Life",
   soulLink             = "Soul Link",

   -- Pet related
   petProwl             = "Prowl",

   -- Other

   clearcasting         = "Clearcasting",

}

lsLocale.enUS.BUFF_BODY_TTS = {
   wyvernCC             = "Asleep",
   wyvernDot            = "(.+) damage every (%d+) sec(.+)."
}


-- Action names
-- Since this table is appended to by the class specific addons, we have to
-- write out each line
lsLocale.enUS.ACTION_TTS = {}
lsLocale.enUS.ACTION_TTS.berserking       = "Berserking"
lsLocale.enUS.ACTION_TTS.bloodFury        = "Blood Fury"
lsLocale.enUS.ACTION_TTS.cannibalize      = "Cannibalize"
lsLocale.enUS.ACTION_TTS.escapeArtist     = "Escape Artist"
lsLocale.enUS.ACTION_TTS.findTreasure     = "Find Treasure"
lsLocale.enUS.ACTION_TTS.perception       = "Perception"
lsLocale.enUS.ACTION_TTS.stoneForm        = "Stoneform"
lsLocale.enUS.ACTION_TTS.shadowmeld       = "Shadowmeld"
lsLocale.enUS.ACTION_TTS.warStomp         = "War Stomp"
lsLocale.enUS.ACTION_TTS.forsaken         = "Will of the Forsaken"
lsLocale.enUS.ACTION_TTS.bow              = "Shoot Bow"
lsLocale.enUS.ACTION_TTS.crossbow         = "Shoot Crossbow"
lsLocale.enUS.ACTION_TTS.gun              = "Shoot Gun"
lsLocale.enUS.ACTION_TTS.throw            = "Throw"
lsLocale.enUS.ACTION_TTS.petFollow        = "Follow"
lsLocale.enUS.ACTION_TTS.petStay          = "Stay"
lsLocale.enUS.ACTION_TTS.petAggressive    = "Aggressive"
lsLocale.enUS.ACTION_TTS.petDefensive     = "Defensive"
lsLocale.enUS.ACTION_TTS.petPassive       = "Passive"
lsLocale.enUS.ACTION_TTS.findHerbs        = "Find Herbs"
lsLocale.enUS.ACTION_TTS.findMinerals     = "Find Minerals"



function lazyScript.LoadLocalization(locale)
   if (locale == "deDE") then


      lsLocale.deDE = {}

      -- Popup dialog text
      lsLocale.deDE.INCOMPATIBLE_ADDON = "%s ist nicht kompatibel mit %s. Bitte updaten Sie auf die neueste(n) Version(en)."
      lsLocale.deDE.DELETE_FORM = "Sind Sie sicher, dass Sie die Form '%s' l\195\182schen m\195\182chten?"

      -- Initiate spell casting
      lsLocale.deDE.SPELLCASTOTHERSTART      = "(.+) beginnt (.+) zu wirken."
      lsLocale.deDE.SPELLPERFORMOTHERSTART   = "(.+) beginnt (.+) auszuf\195\188hren."

      --Spell type catches
      lsLocale.deDE.SPELLTEXT = {
         ".+'s (.+) trifft [Ee]uch kritisch f\195\188r %d+ (.+)schaden.",   --- "Highend's Feuerball trifft Euch kritisch für XXX Feuer'schaden."
         ".+ trifft [Ee]uch (.+) f\195\188r %d+ (.+)schaden.",              --- "Highend trifft Euch mit 'Feuerball' für XXX Feuer'schaden."
         "Ihr erleidet %d+ (.+)schaden (.+).",                      --- "Ihr erleidet XXX Frostschaden von Highend (durch Blizzard)."
      }

      -- The class of spell damage
      lsLocale.deDE.SPELLTYPE = {
         fire     = "Feuer",
         frost    = "Frost",
         nature   = "Natur",
         shadow   = "Schatten",
         arcane   = "Arkan",
         holy     = "Heilig",
      }

      lsLocale.deDE.MOUNTED_BUFF_TT          = "Erh\195\182ht Tempo um (%d+)%%."

      -- Warsong gulch announcements
      lsLocale.deDE.BG_WSG_ZONE =            "Warsongschlucht"     -- zone name
      lsLocale.deDE.BG_WSG_FLAG_PICKED_UP =  "(.+) hat die [Ff]lagge der %s aufgenommen!"
      lsLocale.deDE.BG_WSG_FLAG_CAPTURED =   "hat die [Ff]lagge der %s errungen!"
      lsLocale.deDE.BG_WSG_FLAG_DROPPED =    "hat die [Ff]lagge der %s fallen lassen!"
      lsLocale.deDE.BG_WSG_FLAG_RETURNED =   "die [Ff]lagge der %s wurde von (.+) zu ihrem St\195\188tzpunkt zur\195\188ckgebracht!"

      lsLocale.deDE.DUEL_COUNTDOWN        = "Duell beginnt: (%d)"
      lsLocale.deDE.DUEL_WINNER_KNOCKOUT  = "(.+) hat (.+) in einem Duell besiegt."
      lsLocale.deDE.DUEL_WINNER_RETREAT   = "(.+) ist vor (.+) aus einem Duell gefl\195\188chtet."

      lsLocale.deDE.REMAINING = "Schlachtfeld schlie\195\159t in %d+"

      lsLocale.deDE.GANKED = "Get\195\182tet von: %s Anzahl: %d"    --- "Ganked" is a bit difficult to translate^^
      -- COMBATHITCRITOTHERSELF = "%s crits you for %d.";
      -- COMBATHITOTHERSELF = "%s hits you for %d.";
      lsLocale.deDE.GANKED_CHATS = {
         "(.+)'s .+ trifft [Ee]uch kritisch f\195\188r",          --- "Highend's Feuerball trifft Euch kritisch für"
         "(.+) trifft [Ee]uch (.+) f\195\188r",                   --- "Highend trifft Euch mit 'Feuerball' für"
         "(.+) trifft [Ee]uch kritisch:",                         --- "Highend trifft Euch kritisch:"
         "(.+) trifft [Ee]uch f\195\188r",                        --- "Highend trifft Euch für"
      }

      -- NPC is fleeing
      lsLocale.deDE.NPC_FLEE_MSG = "%%s versucht zu fl\195\188chten!"

      -- When something is immune to your spell, such as poison etc.
      lsLocale.deDE.IMMUNE = "(.+) war ein Fehlschlag. (.+) ist immun."

      -- These are creatures that cast divine protection on themselves
      --- Anmerkung: Wird "Phasing" von irgendeinem Monster als Name verwendet?
      lsLocale.deDE.IMMUNITYPROBLEMCREATURES = {
         "Scharlachroter",
         "Purpurroter",

         "Doan",
         "Gurubashi",
         "Springvale",
         "Arugal",
      }

      -- Localized instance names
      lsLocale.deDE.INSTANCES = {
         "Ragefireabgrund",
         "Die Todesminen",
         "Die H\195\182hlen des Wehklagens",
         "Burg Shadowfang",
         "Das Verlies",
         "Blackfathom-Tiefen",
         "Gnomeregan",
         "Der Kral von Razorfen",
         "Das scharlachrote Kloster",
         "Die H\195\188gel von Razorfen",
         "Uldaman",
         "Maraudon",
         "Zul'Farrak",
         "Der versunkene Tempel",
         "Blackrocktiefen",
         "Blackrockspitze",
         "Stratholme",
         "D\195\188sterbruch",
         "Scholomance",
         "Onyxias Hort",
         "Ruinen von Ahn'Qiraj",
         "Zul'Gurub",
         "Geschmolzener Kern",
         "Pechschwingenhort",
         "Tempel von Ahn'Qiraj",
         "Naxxramas",
      }

      -- Needed for many of the -ifTargetIs=Slowed etc.
      lsLocale.deDE.SLOWED_TTS = {
         "Bewegung um (.+) verlangsamt",           --- "Bewegung um 50% verlangsamt."  <- Kniesehne (Krieger)
         "Bewegungstempo um (.+) verlangsamt",     --- "Bewegungstempo um 60% verlangsamt."  <- Eiskältefalle / Zurechtstutzen (Jäger)

      }
      -- Cheapshot or kidneyshot
      lsLocale.deDE.STUNNED_TTS = {
         "Bet\195\164ubt",                         --- "Betäubt."  <- Fiester Trick / Nierenhieb (Schurke)
      }
      -- Damage over time text like shadow word pain
      lsLocale.deDE.DOT_TTS = {
         "F\195\188gt alle (%d+) Sek. (%d+) (.+)schaden zu",      --- "Fügt alle X Sek. XXX Feuerschaden zu."  <- Feuerbrand (Hexenmeister)
         "%d+ Sek. lang (%d+) Punkt(e) Schaden",                  --- "XX Sek. lang XXX Punkt(e) Schaden."  <- Fluch der Pein (Hexenmeister)
         "%d+ (.+)schaden alle (%d+) Sekunden",                   --- "XXX Schattenschaden alle 3 Sekunden."   <- Schattenwort: Schmerz (Priester)
      }
      -- Fear spells like psychic scream
      lsLocale.deDE.FEAR_TTS = {
         "Starr vor Furcht",                             --- "Starr vor Furcht."  <- Drohruf (Krieger)
         "Furchterf\195\188llt",                         --- "Furchterfüllt."  <- Furcht (Hexenmeister)
         "Fl\195\188chtet voller Schrecken",             --- "Flüchtet voller Schrecken."  <- Schreckensgeheul (Hexenmeister)
         "Von Entsetzen erf\195\188llt",                 --- "Von Entsetzen erfüllt."  <- Todesmantel (Hexenmeister)
         "L\195\164uft vor Furcht weg",                  --- "Läuft vor Furcht weg."  <- Psychischer (Schrei)
      }
      lsLocale.deDE.IMMOBILE_TTS = {
         "Unbeweglich",                                  --- "Unbeweglich."  <- Gegenangriff (Jäger) / Wurzeln (Druide)
         "Bewegungsunf\195\164hig",                      --- "Bewegungsunfähig."  <- Verbessertes Zurechtstutzen (Jäger)
         "Eingefroren",                                  --- "Eingefroren."  <- Frost Nova (Magier)

      }
      lsLocale.enUS.ASLEEP_TTS = nil


      lsLocale.enUS.DISORIENTED_TTS = nil


      lsLocale.enUS.INCAPACITATED_TTS = nil

      lsLocale.deDE.BUFF_TTS = {
         berserking           = "Berserker",
         bloodFury            = "Kochendes Blut",
         cannibalize          = "Kannibalismus",
         brainFood            = "Gehirnnahrung",      -- name of buff that you get when eating sagefish (mana)
         dazed                = "Benommen",
         drink                = "Trinken",            -- name of buff that you get when drinking (water pouch)
         firstAid             = "Erste Hilfe",
         fishFood             = "Essen",              -- name of buff that you get when eating sagefish (hp)
         food                 = "Essen",              -- name of buff that you get when eating (knife and fork)
         recentlyBandaged     = "Gnadenlose Angriffe",
         shadowmeld           = "Schattenhaftigkeit",
         silverwingFlag       = "Silverwing-Flagge",
         warsongFlag          = "Warsongflagge",
         wellFed              = "Satt",               -- name of well fed buff (cheese icon)

         --Rogue Buffs
         adrenaline           = "Adrenalinrausch",
         bladeFlurry          = "Klingenwirbel",
         blind                = "Blenden",
         cs                   = "Fieser Trick",
         coldBlood            = "Kaltbl\195\188tigkeit",
         evasion              = "Entrinnen",
         expose               = "R\195\188stung schw\195\164chen",
         garrote              = "Erdrosseln",
         ghostly              = "Geisterhafter Sto\195\159",
         gouge                = "Solarplexus",
         hemo                 = "Blutsturz",
         ks                   = "Nierenhieb",
         remorseless          = "",
         rupture              = "Blutung",
         sap                  = "Kopfnuss",
         snd                  = "Zerh\195\164ckseln",
         stealth              = "Verstohlenheit",
         vanish               = "Verschwinden",

         --Priest Buffs
         abolishDisease       = "Krankheit aufheben",
         devouringPlague      = "Verschlingende Seuche",
         divineSpirit         = "G\195\182ttlicher Willen",
         elunesGrace          = "Elunes Anmut",
         fade                 = "Verblassen",
         fearWard             = "Furchtzauberschutz",
         feedback             = "R\195\188ckkopplung",
         hexWeakness          = "Verhexung der Schw\195\164che",
         holyFire             = "Heiliges Feuer",
         innerFire            = "Inneres Feuer",
         innerFocus           = "Innerer Fokus",
         levitate             = "Levitieren",
         lightwell            = "Brunnen des Lichts",
         lightwellRenew       = "Erneuerung des Lichtbrunnens",
         mindControl          = "Gedankenkontrolle",
         mindFlay             = "Gedankenschinden",
         mindSoothe           = "Gedankenbes\195\164nftigung",
         mindVision           = "Gedankensicht",
         powerInfusion        = "Seele der Macht",
         pwf                  = "Machtwort: Seelenst\195\164rke",
         pws                  = "Machtwort: Schild",
         prf                  = "Gebet der Seelenst\195\164rke",
         prsp                 = "Gebet des Schattenschutzes",
         prs                  = "Gebet der Willenskraft",
         psychicScream        = "Psychischer Schrei",
         renew                = "Erneuerung",
         shackleUndead        = "Untote fesseln",
         shadowProtection     = "Schattenschutz",
         swp                  = "Schattenwort: Schmerz",
         shadowform           = "Schattengestalt",
         shadowguard          = "Schattenschild",
         shadowVulnerability  = "Schattenverwundbarkeit",
         spiritTap            = "Willensentzug",
         starshards           = "Sternensplitter",
         touchWeakness        = "Ber\195\188hrung der Schw\195\164che",
         vampiricEmbrace      = "Vampirumarmung",
         weakenedSoul         = "Geschw\195\164chte Seele",

         -- Warrior Buffs
         battleShout          = "Schlachtruf",
         berserkerRage        = "Berserkerwut",
         bloodrage            = "Blutrausch",
         challengingShout     = "Herausforderungsruf",
         concussionBlow       = "Ersch\195\188tternder Schlag",
         deathWish            = "Todeswunsch",
         demoShout            = "Demoralisierungsruf",
         disarm               = "Entwaffnen",
         hamstring            = "Kniesehne",
         intimidatingShout    = "Drohruf",
         lastStand            = "Letztes Gefecht",
         mockingBlow          = "Sp\195\182ttischer Schlag",
         mortalStrike         = "T\195\182dlicher Sto\195\159",
         piercingHowl         = "Durchdringendes Heulen",
         recklessness         = "Tollk\195\188hnheit",
         rend                 = "Verwunden",
         retaliation          = "Gegenschlag",
         shieldBlock          = "Schildblock",
         shieldWall           = "Schildwall",
         sunder               = "R\195\188stung zerrei\195\159en",
         sweepingStrikes      = "Weitreichende St\195\182\195\159e",
         thunderClap          = "Donnerknall",
         whirlwind            = "Wirbelwind",

         -- Druid Buffs
         bear                 = "B\195\164rengestalt",
         aquatic              = "Wassergestalt",
         cat                  = "Katzengestalt",
         travel               = "Reisegestalt",
         direBear             = "Terrorb\195\164rengestalt",
         moonkin              = "Moonkingestalt",

         prowl                = "Schleichen",
         rake                 = "Krallenhieb",
         rip                  = "Zerfetzen",
         dash                 = "Spurt",
         pounce               = "Anspringen",
         tigersFury           = "Tigerfuror",

         bash                 = "Hieb",
         charge               = "Wilde Attacke - Effekt",
         demoralize           = "Demoralisierendes Gebr\195\188ll",
         enrage               = "Wutanfall",
         frenziedRegen        = "Rasende Regeneration",

         abolishPoison        = "Vergiftung aufheben - Effekt",
         barkskin             = "Baumrinde",
         faerieFire           = "Feenfeuer",
         gotw                 = "Gabe der Wildnis",
         grasp                = "Griff der Natur",
         hibernate            = "Winterschlaf",
         innervate            = "Anregen",
         moonfire             = "Mondfeuer",
         motw                 = "Mal der Wildnis",
         ns                   = "Schnelligkeit der Natur",
         ooc                  = "Omen der Klarsicht",
         regrowth             = "Nachwachsen",
         rejuv                = "Verj\195\188ngung",
         roots                = "Wucherwurzeln",
         soothe               = "Tier bes\195\164nftigen",
         swarm                = "Insektenschwarm",
         thorns               = "Dornen",
         tranquility          = "Gelassenheit",

         -- Hunter Buffs
         aspectBeast          = "Aspekt des Wildtiers",
         aspectCheetah        = "Aspekt des Geparden",
         aspectHawk           = "Aspekt des Falken",
         aspectPack           = "Aspekt des Rudels",
         aspectMonkey         = "Aspekt des Affen",
         aspectWild           = "Aspekt der Wildnis",
         bestialWrath         = "Zorn des Wildtiers",
         concussive           = "Ersch\195\188tternder Schuss",
         eagleEye             = "Adlerauge",
         eotb                 = "Augen des Wildtiers",
         explosiveTrap        = "Sprengfalle'-Effekt",
         feedPet              = "Tier f\195\188ttern - Effekt",
         feign                = "Totstellen",
         frostTrap            = "Frostfalle-Aura",
         freezingTrap         = "Eisk\195\164ltefalle",
         furiousHowl          = "Wutgeheul",
         huntersMark          = "Mal des J\195\164gers",
         immolationTrap       = "Feuerbrandfalle",
         intimidate           = "Einsch\195\188chterung",
         quickShots           = "Schnelle Sch\195\188sse",
         rapidFire            = "Schnellfeuer",
         scare                = "Wildtier \195\164ngstigen",
         scatter              = "Streuschuss",
         scorpid              = "Skorpidstich",
         serpent              = "Schlangenbiss",
         trueshot             = "Aura des Volltreffers",
         viper                = "Vipernbiss",
         wingClip             = "Zurechtstutzen",
         wyvern               = "Stich des Fl\195\188geldrachen",
         wyvernCC             = "Stich des Fl\195\188geldrachen",
         wyvernDot            = "Stich des Fl\195\188geldrachen",

         -- Mage Buffs
         amplifyMagic         = "Magie verst\195\164rken",
         brilliance           = "Arkane Brillanz",
         combustion           = "Verbrennung",
         dampenMagic          = "Magie d/195/164mpfen",
         evocation            = "Hervorrufung",
         fireVulnerability    = "Feuerverwundbarkeit",
         fireWard             = "Feuerzauberschutz",
         frostArmor           = "Frostr\195\188stung",
         frostbolt            = "Frostblitz",
         frostWard            = "Frostzauberschutz",
         iceArmor             = "Eisr\195\188stung",
         iceBarrier           = "Eis-Barriere",
         iceBlock             = "Eisblock",
         ignite               = "Entz\195\188nden",
         intellect            = "Arkane Intelligenz",
         mageArmor            = "Magische R\195\188stung",
         manaShield           = "Manaschild",
         polymorph            = "Verwandlung",
         polymorphPig         = "Verwandlung: Schwein",
         polymorphTurtle      = "Verwandlung: Schildkr\195\182te",

         -- Paladin Buffs
         concAura             = "Aura der Konzentration",
         devAura              = "Aura der Hingabe",
         fireAura             = "Aura des Feuerwiderstands",
         retAura              = "Aura der Vergeltung",
         sanctAura            = "Aura der Heiligkeit",
         shadowAura           = "Aura des Schattenwiderstands",
         blessFree            = "Segen der Freiheit",
         blessKings           = "Segen der K\195\182nige",
         blessLight           = "Segen des Lichts",
         blessMight           = "Segen der Macht",
         blessProt            = "Segen des Schutzes",
         blessSac             = "Segen der Opferung ",
         blessSlv             = "Segen der Rettung",
         blessSnct            = "Segen des Refugiums",
         blessWisdom          = "Segen der Weisheit",
         divFavor             = "G\195\182ttliche Gunst",
         divProt              = "G\195\182ttlicher Schutz",
         divShield            = "Gottesschild",
         forbearance          = "Vorahnung",
         gBlessKings          = "Gro\195\159er Segen der K\195\182nige",
         gBlessLight          = "Gro\195\159er Segen des Lichts",
         gBlessMight          = "Gro\195\159er Segen der Macht",
         gBlessSlv            = "Gro\195\159er Segen der Rettung",
         gBlessSnct           = "Gro\195\159er Segen des Refugiums",
         gBlessWisdom         = "Gro\195\159er Segen der Weisheit",
         holyShield           = "Heiliger Schild ",
         redoubt              = "Verschanzen",
         repentance           = "Bu\195\159e",
         rightFury            = "Zorn der Gerechtigkeit",
         sealCommand          = "Siegel des Befehls ",
         sealCrusader         = "Seal of the Crusader",
         sealJustice          = "Siegel der Gerechtigkeit",
         sealLight            = "Siegel des Lichts",
         sealRight            = "Siegel der Rechtschaffenheit",
         sealWisdom           = "Siegel der Weisheit",

         judgeCrusader        = "Richturteil des Kreuzfahrers",
         judgeJustice         = "Richturteil der Gerechtigkeit",
         judgeLight           = "Richturteil des Lichts",
         judgeWisdom          = "Richturteil der Weisheit",

         -- Shaman buffs
         lightShield          = "Blitzschlagschild",
         ghostwolf            = "Geisterwolf",

         fireResistTotem      = "Feuerwiderstand",
         flameTotem           = "Flammenzunge",
         flameShock           = "Flammenschock",
         frostResistTotem     = "Frostwiderstand",
         graceTotem           = "Anmut der Luft",
         hsTotem              = "Heilstrom",
         msTotem              = "Manaquelle",
         mtTotem              = "Manaflut",
         natureResistTotem    = "Naturwiderstand",
         skinTotem            = "Steinhaut",
         strengthTotem             = "St\195\164rke der Erde",
         tranquilTotem        = "Beruhigenden Winde",
         wfTotem              = "Windzorns",
         windwallTotem        = "Windmauer",

         -- Warlock buffs
         amplifyCurse         = "Fluch verst\195\164rken",
         corruption           = "Verderbnis",
         curseAgony           = "Fluch der Pein",
         curseElements        = "Fluch der Elemente",
         curseExhaustion      = "Fluch der Ersch\195\182pfung",
         curseReckless        = "Fluch der Tollk\195\188hnheit",
         curseShadow          = "Schattenfluch",
         curseTongues         = "Fluch der Sprachen",
         curseWeakness        = "Fluch der Schw\195\164che",
         banish               = "Verbannen",
         deathCoil            = "Todesmantel",
         demonArmor           = "D\195\164monenr\195\188stung",
         demonSkin            = "D\195\164monenhaut",
         detectGreaterInvis   = "Gro\195\159e Unsichtbarkeit entdecken",
         detectInvis          = "Unsichtbarkeit entdecken",
         detectLesserInvis    = "Geringe Unsichtbarkeit entdecken",
         drainLife            = "Blutsauger",
         drainMana            = "Mana entziehen",
         drainSoul            = "Seelendieb",
         fear                 = "Furcht",
         funnel               = "Lebenslinie",
         hellfire             = "H\195\182llenfeuer",
         howl                 = "Schreckgeheul",
         immolate             = "Feuerbrand",
         sacrifice            = "Opferung",
         shadowburn           = "Schattenbrand",
         shadowTrance         = "Schattentrance",
         seduction            = "Verf\195\188hrung",
         senseDemons          = "D\195\164monen sp\195\188ren",
         shadowWard           = "Schattenzauberschutz",
         siphon               = "Lebensentzug",
         soulLink             = "Seelenverbindung",

         -- Pet related
         petProwl             = "Schleichen",

         -- Other

         clearcasting         = "Freizaubern",

      }

      lsLocale.deDE.BUFF_BODY_TTS = {
         wyvernCC             = "Schlafend",
         wyvernDot            = nil
      }


      -- Action names
      -- Since this table is appended to by the class specific addons, we have to
      -- write out each line
      lsLocale.deDE.ACTION_TTS = {}
      lsLocale.deDE.ACTION_TTS.berserking       = "Berserker"
      lsLocale.deDE.ACTION_TTS.bloodFury        = "Kochendes Blut"
      lsLocale.deDE.ACTION_TTS.cannibalize      = "Kannibalismus"
      lsLocale.deDE.ACTION_TTS.escapeArtist     = "Entfesselungsk\195\188nstler"
      lsLocale.deDE.ACTION_TTS.findTreasure     = "Schatzsucher"
      lsLocale.deDE.ACTION_TTS.perception       = "Wachsamkeit"
      lsLocale.deDE.ACTION_TTS.stoneForm        = "Steingestalt"
      lsLocale.deDE.ACTION_TTS.shadowmeld       = "Schattenhaftigkeit"
      lsLocale.deDE.ACTION_TTS.warStomp         = "Kriegsdonner"
      lsLocale.deDE.ACTION_TTS.forsaken         = "Wille der Verlassenen"
      lsLocale.deDE.ACTION_TTS.bow              = "Bogenschuss"
      lsLocale.deDE.ACTION_TTS.crossbow         = "Armbrust abschie\195\159en"
      lsLocale.deDE.ACTION_TTS.gun              = "Schusswaffe abfeuern"
      lsLocale.deDE.ACTION_TTS.throw            = nil
      lsLocale.deDE.ACTION_TTS.petFollow        = nil
      lsLocale.deDE.ACTION_TTS.petStay          = nil
      lsLocale.deDE.ACTION_TTS.petAggressive    = nil
      lsLocale.deDE.ACTION_TTS.petDefensive     = nil
      lsLocale.deDE.ACTION_TTS.petPassive       = nil
      lsLocale.deDE.ACTION_TTS.findHerbs        = "Kr\195\164utersuche"
      lsLocale.deDE.ACTION_TTS.findMinerals     = "Mineraliensuche"



   elseif (locale == "frFR") then
      lsLocale.frFR = {}
      -- French
      lsLocale.frFR.SPELLCASTOTHERSTART      = "(.+) commence \195\160 lancer (.+)."
      lsLocale.frFR.SPELLPERFORMOTHERSTART   = "(.+) commence \195\160 ex\195\169cuter (.+)."
      lsLocale.frFR.MOUNTED_BUFF_TT          = "Augmente la vitesse de (%d+)%%."
      --lsLocale.MOUNTED_BUFF_TT = "Augmente la vitesse de mouvement";



      lsLocale.frFR.DUEL_COUNTDOWN        = "D\195\169but du duel : (%d)"
      lsLocale.frFR.DUEL_WINNER_KNOCKOUT  = "(.+) a triomph\195\169 de (.+) lors d'un duel"
      lsLocale.frFR.DUEL_WINNER_RETREAT   = "(.+) s'enfuit de son duel contre (.+)"

      -- TBD: BEGIN NEED LOCALIZATION!
      lsLocale.frFR.SPELLTEXT = nil
      lsLocale.frFR.SPELLTYPE = nil

      -- TBD: BEGIN NEED LOCALIZATION!

      lsLocale.frFR.IMMUNE                   = nil
      lsLocale.frFR.IMMUNITYPROBLEMCREATURES = nil
      lsLocale.frFR.SLOWED_TTS               = nil
      lsLocale.frFR.STUNNED_TTS              = nil
      lsLocale.frFR.DOT_TTS                  = nil
      lsLocale.frFR.FEAR_TTS                 = nil
      lsLocale.frFR.IMMOBILE_TTS             = nil
      lsLocale.frFR.INSTANCES                = nil
      lsLocale.frFR.BGWGTEXT0                = nil
      lsLocale.frFR.GANKED                   = nil

      -- TBD: END NEED LOCALIZATION!

      lsLocale.frFR.BUFF_TTS = {
         --asleep               = nil,
         berserking           = "Berserker",
         bloodFury            = "Fureur sanguinaire",
         cannibalize          = "Cannibalisme",
         dazed                = "H\195\169b\195\169tement",
         firstAid             = "Premiers soins",
         recentlyBandaged     = "Un bandage a \195\169t\195\169 appliqu\195\169 r\195\169cemment",
         shadowmeld           = "Camouflage dans l'ombre",
         silverwingFlag       = "Drapeau d'Aile-argent",
         warsongFlag          = "Drapeau Warsong",

         --Rogue Buffs
         adrenaline           = "Pouss\195\169e d'adr\195\169naline",
         bladeFlurry          = "D\195\169luge de lames",
         blind                = "C\195\169cit\195\169",
         cs                   = "Coup bas",
         coldBlood            = "Sang froid",
         evasion              = "Evasion",
         expose               = "Exposer l'armure",
         garrote              = "Garrot",
         ghostly              = "Frappe fantomatique",
         gouge                = "Suriner",
         hemo                 = "H\195\169morragie",
         ks                   = "Aiguillon perfide",
         remorseless          = "Attaques impitoyables",
         rupture              = "Rupture",
         sap                  = "Assommer",
         snd                  = "D\195\169biter",
         stealth              = "Camouflage",
         vanish               = "Disparition",

         --Priest Buffs
         abolishDisease       = "Abolir maladie",
         devouringPlague      = "Peste d\195\169vorante",
         divineSpirit         = "Esprit divin",
         elunesGrace          = "Gr\195\162ce d'Elune",
         fade                 = "Oubli",
         fearWard             = "Gardien de peur",
         feedback             = "R\195\169action",
         hexWeakness          = "Mal\195\169fice de faiblesse",
         holyFire             = "Flammes sacr\195\169es",
         innerFire            = "Feu int\195\169rieur",
         innerFocus           = "Focalisation am\195\169lior\195\169e",
         levitate             = "L\195\169vitation",
         lightwell            = "Puits de lumi\195\168re",
         lightwellRenew       = "R\195\169novation du Puits de lumi\195\168re",
         mindControl          = "Contr\195\180le mental",
         mindFlay             = "Fouet mental",
         mindSoothe           = "Apaisement",
         mindVision           = "Vision t\195\169l\195\169pathique",
         powerInfusion        = "Infusion de puissance",
         pwf                  = "Mot de pouvoir : Robustesse",
         pws                  = "Mot de pouvoir : Bouclier",
         prf                  = "Pri\195\168re de robustesse",
         prsp                 = "Pri\195\168re de protection contre l'Ombre",
         prs                  = "Pri\195\168re d'Esprit",
         psychicScream        = "Cri psychique",
         renew                = "R\195\169novation",
         shackleUndead        = "Entraves des morts-vivants",
         shadowProtection     = "Protection contre l'Ombre",
         swp                  = "Mot de l'ombre : Douleur",
         shadowform           = "Forme d'Ombre",
         shadowguard          = "Garde de l'ombre",
         shadowVulnerability  = "Vuln\195\169rabilit\195\169 \195\160 l'Ombre",
         spiritTap            = "Connexion spirituelle",
         starshards           = "Eclats stellaires",
         touchWeakness        = "Toucher de faiblesse",
         vampiricEmbrace      = "Etreinte vampirique",
         weakenedSoul         = "Ame affaiblie",

         -- Warrior Buffs
         battleShout          = "Cri de guerre",
         berserkerRage        = "Rage berserker",
         bloodrage            = "Rage sanguinaire",
         challengingShout     = "Cri de d\195\169fi",
         concussionBlow       = "Bourrasque",
         deathWish            = "Souhait mortel",
         demoShout            = "Cri d\195\169moralisant",
         disarm               = "D\195\169sarmement",
         hamstring            = "Brise-genou",
         intimidatingShout    = "Cri d'intimidation",
         lastStand            = "Dernier rempart",
         mockingBlow          = "Coup railleur",
         mortalStrike         = "Frappe mortelle",
         piercingHowl         = "Hurlement per\195\167ant",
         recklessness         = "T\195\169m\195\169rit\195\169",
         rend                 = "Pourfendre",
         retaliation          = "Repr\195\169sailles",
         shieldBlock          = "Ma\195\174trise du blocage",
         shieldWall           = "Mur protecteur",
         sunder               = "Fracasser armure",
         sweepingStrikes      = "Attaques circulaires",
         thunderClap          = "Coup de tonnerre",
         whirlwind            = "Tourbillon",

         -- Druid Buffs
         bear                 = "Forme d'ours",
         aquatic              = "Forme aquatique",
         cat                  = "Forme de f\195\169lin",
         travel               = "Forme de voyage",
         direBear             = "Forme d'ours redoutable",
         moonkin              = "Forme de s\195\169l\195\169nien",

         prowl                = "R\195\180der",
         rake                 = "Griffure",
         rip                  = "D\195\169chirure",
         dash                 = "C\195\169l\195\169rit\195\169",
         pounce               = "Traquenard",
         tigersFury           = "Fureur du tigre",

         bash                 = "Sonner",
         charge               = "Effet de Charge farouche",
         demoralize           = "Rugissement d\195\169moralisant",
         enrage               = "Enrager",
         frenziedRegen        = "R\195\169g\195\169n\195\169ration fr\195\169n\195\169tique",

         abolishPoison        = "Effet Abolir le poison",
         barkskin             = "Ecorce",
         faerieFire           = "Lucioles",
         gotw                 = "Don du fauve",
         grasp                = "Emprise de la nature",
         hibernate            = "Hibernation",
         innervate            = "Innervation",
         moonfire             = "Eclat lunaire",
         motw                 = "Marque du fauve",
         ns                   = "Rapidit\195\169 de la nature",
         ooc                  = "Augure de clart\195\169",
         regrowth             = "R\195\169tablissement",
         rejuv                = "R\195\169cup\195\169ration",
         roots                = "Sarments",
         soothe               = "Apaiser les animaux",
         swarm                = "Essaim d'insectes",
         thorns               = "Epines",
         tranquility          = "Tranquillit\195\169",

         -- Hunter Buffs
         aspectBeast          = "Aspect de la b\195\170te",
         aspectCheetah        = "Aspect du gu\195\169pard",
         aspectHawk           = "Aspect du faucon",
         aspectPack           = "Aspect de la meute",
         aspectMonkey         = "Aspect du singe am\195\169lior\195\169",
         aspectWild           = "Aspect de la nature",
         bestialWrath         = "Courroux bestial",
         concussive           = "Trait de choc",
         eagleEye             = "Oeil d'aigle",
         eotb                 = "Oeil de la b\195\170te",
         explosiveTrap        = "Effet Pi\195\168ge explosif",
         feedPet              = "Effet Nourrir le familier",
         feign                = "Feindre la mort",
         frostTrap            = "Aura Pi\195\168ge de givre",
         freezingTrap         = "Pi\195\168ge givrant",
         furiousHowl          = "Hurlement furieux",
         huntersMark          = "Marque du chasseur",
         immolationTrap       = "Effet Pi\195\168ge immolation",
         intimidate           = "Intimidation",
         quickShots           = "Tirs acc\195\169l\195\169r\195\169s",
         rapidFire            = "Tir rapide",
         scare                = "Effrayer une b\195\170te",
         scatter              = "Fl\195\168che de dispersion",
         scorpid              = "Piq\195\187re de scorpide",
         serpent              = "Morsure de serpent",
         trueshot             = "Aura de pr\195\169cision",
         viper                = "Morsure de vip\195\168re",
         wingClip             = "Coupure d'ailes",
         wyvern               = "Piq\195\187re de wyverne",
         wyvernCC             = "Piq\195\187re de wyverne",
         wyvernDot            = "Piq\195\187re de wyverne",


         -- Mage Buffs
         amplifyMagic         = "Amplification de la magie",
         brilliance           = "Illumination des arcanes",
         combustion           = "Combustion",
         dampenMagic          = "Att\195\169nuation de la magie",
         evocation            = "Evocation",
         fireVulnerability    = "Vuln\195\169rabilit\195\169 au Feu",
         fireWard             = "Gardien de feu",
         frostArmor           = "Armure de givre",
         frostbolt            = "Eclair de givre",
         frostWard            = "Gardien de givre",
         iceArmor             = "Armure de glace",
         iceBarrier           = "Barri\195\168re de glace",
         iceBlock             = "Parade de glace",
         ignite               = "Enflammer",
         intellect            = "Intelligence des arcanes ",
         mageArmor            = "Armure du mage",
         manaShield           = "Bouclier de mana",
         polymorph            = "M\195\169tamorphose",
         polymorphPig         = nil,
         polymorphTurtle      = nil,

         -- Paladin Buffs
         concAura             = "Aura de concentration",
         devAura              = "Aura de d\195\169votion",
         fireAura             = "Aura des Feuerwiderstands",
         retAura              = "Aura de vindicte ",
         sanctAura            = "Aura de saintet\195\169",
         shadowAura           = "Aura de r\195\169sistance \195\160 l'Ombre",
         blessFree            = "B\195\169n\195\169diction de libert\195\169",
         blessKings           = "B\195\169n\195\169diction des rois",
         blessLight           = "B\195\169n\195\169diction de lumi\195\168re",
         blessMight           = "B\195\169n\195\169diction de puissance",
         blessProt            = "B\195\169n\195\169diction de protection ",
         blessSac             = "B\195\169n\195\169diction de sacrifice",
         blessSlv             = "B\195\169n\195\169diction de salut ",
         blessSnct            = "B\195\169n\195\169diction du sanctuaire",
         blessWisdom          = "B\195\169n\195\169diction de sagesse",
         divFavor             = "Faveur divine",
         divProt              = "Protection divine",
         divShield            = "Bouclier divin",
         forbearance          = "Longanimit\195\169",
         gBlessKings          = "B\195\169n\195\169diction des rois sup\195\169rieure",
         gBlessLight          = "B\195\169n\195\169diction de lumi\195\168re sup\195\169rieure",
         gBlessMight          = "B\195\169n\195\169diction de puissance sup\195\169rieure",
         gBlessSlv            = "B\195\169n\195\169diction de salut sup\195\169rieure",
         gBlessSnct           = "B\195\169n\195\169diction du sanctuaire sup\195\169rieure",
         gBlessWisdom         = "B\195\169n\195\169diction de sagesse sup\195\169rieure",
         holyShield           = "Bouclier sacr\195\169",
         redoubt              = "Redoute",
         repentance           = "Repentir",
         rightFury            = "Fureur vertueuse",
         sealCommand          = "Sceau d'autorit\195\169 ",
         sealCrusader         = "Seal of the Crusader",
         sealJustice          = "Sceau de justice",
         sealLight            = "Sceau de lumi\195\168re",
         sealRight            = "Sceau de pi\195\169t\195\169",
         sealWisdom           = "Sceau de sagesse",

         judgeCrusader        = "Jugement du Crois\195\169",
         judgeJustice         = "Jugement de justice",
         judgeLight           = "Jugement de lumi\195\168re",
         judgeWisdom          = "Jugement de sagesse",

         -- Shaman buffs
         lightShield          = "Bouclier de foudre",
         ghostwolf            = "Loup fant\195\180me",

         fireResistTotem      = "R\195\169sistance au Feu",
         flameShock           = "Horion de flammes",
         flameTotem           = "Langue de feu",
         frostResistTotem     = "R\195\169sistance au Givre",
         graceTotem           = "Gr\195\162ce a\195\169rienne",
         hsTotem              = "Gu\195\169risseur",
         msTotem              = "Fontaine de mana",
         mtTotem              = "Vague de mana",
         natureResistTotem    = "R\195\169sistance \195\160 la Nature",
         skinTotem            = "Peau de Pierre",
         strengthTotem        = "Force de la Terre",
         tranquilTotem        = "Tranquillit\195\169 de l'air",
         wfTotem              = "Furie-des-vents",
         windwallTotem        = "Mur des vents",

         -- Warlock buffs
         amplifyCurse         = "Mal\195\169diction amplifi\195\169e",
         corruption           = "Corruption",
         curseAgony           = "Mal\195\169diction d'agonie",
         curseElements        = "Mal\195\169diction des \195\169l\195\169ments",
         curseExhaustion      = "Mal\195\169diction de fatigue",
         curseReckless        = "Mal\195\169diction de t\195\169m\195\169rit\195\169",
         curseShadow          = "Mal\195\169diction de l'ombre",
         curseTongues         = "Mal\195\169diction des langages",
         curseWeakness        = "Mal\195\169diction de faiblesse",
         banish               = "Bannir",
         deathCoil            = "Voile mortel",
         demonArmor           = "Armure d\195\169moniaque",
         demonSkin            = "Peau de d\195\169mon",
         detectGreaterInvis   = "D\195\169tection de l'invisibilit\195\169 sup\195\169rieure",
         detectInvis          = "D\195\169tection de l'invisibilit\195\169",
         detectLesserInvis    = "D\195\169tection de l'invisibilit\195\169 inf\195\169rieure",
         drainLife            = "Drain de vie",
         drainMana            = "Drain de mana",
         drainSoul            = "Siphon d'\195\162me",
         fear                 = "Peur",
         funnel               = "Captation de vie",
         hellfire             = "Flammes infernales",
         howl                 = "Hurlement de terreur",
         immolate             = "Immolation",
         sacrifice            = "Sacrifice",
         seduction            = "S\195\169duction",
         senseDemons          = "D\195\169tection des d\195\169mons",
         shadowburn           = "Br\195\187lure de l'ombre",
         shadowTrance         = "Transe de l'ombre",
         shadowWard           = "Gardien de l'ombre",
         siphon               = "Siphon de vie",
         soulLink             = "Lien spirituel",

         -- Pet related
         petProwl             = "R\195\180der",

         -- Other

         clearcasting         = "Id\195\169es claires",

      }

      lsLocale.frFR.BUFF_BODY_TTS = {
         wyvernCC             = nil,
         wyvernDot            = nil,
      }


      -- Action names
      -- Since this table is appended to by the class specific addons, we have to
      -- write out each line
      lsLocale.frFR.ACTION_TTS = {}
      lsLocale.frFR.ACTION_TTS.berserking       = "Berserker"
      lsLocale.frFR.ACTION_TTS.bloodFury        = "Fureur sanguinaire"
      lsLocale.frFR.ACTION_TTS.cannibalize      = "Cannibalisme"
      lsLocale.frFR.ACTION_TTS.escapeArtist     = "Ma\195\174tre de l'\195\169vasion"
      lsLocale.frFR.ACTION_TTS.findTreasure     = "D\195\169couverte de tr\195\169sors"
      lsLocale.frFR.ACTION_TTS.perception       = "Perception"
      lsLocale.frFR.ACTION_TTS.stoneForm        = "Forme de pierre"
      lsLocale.frFR.ACTION_TTS.shadowmeld       = "Camouflage dans l'ombre"
      lsLocale.frFR.ACTION_TTS.warStomp         = "Choc martial"
      lsLocale.frFR.ACTION_TTS.forsaken         = "Volont\195\169 des R\195\169prouv\195\169s"
      lsLocale.frFR.ACTION_TTS.bow              = "Tir \195\160 l'arc"
      lsLocale.frFR.ACTION_TTS.crossbow         = "Tir \195\160 l'arbal\195\168te"
      lsLocale.frFR.ACTION_TTS.gun              = "Tir avec une arme \195\160 feu"
      lsLocale.frFR.ACTION_TTS.throw            = nil
      lsLocale.frFR.ACTION_TTS.findHerbs        = "D\195\169couverte d'herbes"
      lsLocale.frFR.ACTION_TTS.findMinerals     = "D\195\169couverte de gisements"



   end
end

function lazyScript.getLocaleString(token, enOk, sayNothing)
   local locale = GetLocale()
   if locale == "enGB" then
      enOk = true
   end

   local value = lazyScript.doLocaleLookup(locale, token)

   if value then
      return value
   elseif (not value and enOk) then
      value = lazyScript.doLocaleLookup("enUS", token)
      if value then
         return value
      else
         if (not sayNothing) then
            lazyScript.p("Unrecognized localization token: "..token)
         end
         return nil
      end
   else
      if (not sayNothing) then
         lazyScript.p("This token is not supported for your locale: "..token)
      end
      return nil
   end
end

function lazyScript.doLocaleLookup(locale, token)
   if not lsLocale[locale] then
      return nil
   end
   local value = nil
   for tokenBit in string.gfind(token, "[^\.]+") do
      if value then
         value = value[tokenBit]
      else
         value = lsLocale[locale][tokenBit]
      end
   end
   return value
end
