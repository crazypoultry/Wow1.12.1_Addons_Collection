-- Binding Configuration
BINDING_HEADER_AA      = "AutoAttack"
BINDING_NAME_AAACTION  = "Perform combat action."
BINDING_NAME_AAINSTANT = "Instant combat action."
BINDING_NAME_AATPT     = "Target Previous Target."
BINDING_NAME_AAMOUNT   = "Switch mount."
BINDING_NAME_AAFORM    = "Switch form."

-- Action tables by class
AutoAttack_Class_Actions = {
        DRUID = { DS='Bash'; HoT={'Rejuv','Rejuv'};
        			 Prep={Act='Prowl',Buf='Ambush'};
            Buf = {'Mark','Regeneration',true; 'Thorns','Thorns',true};
            Icons = {Starfire='Starfire', Moonfire='Moonfire', Rip='Rip',
            		 ['Entangling Roots']='Roots', Bash='Bash',
                     Barkskin='Barkskin', Maul='Maul', Enrage='Enrage',
                     ["Nature's Grasp"]='Grasp', Thorns='Thorns',
                     ['Demoralizing Roar']='Roar', Shred='Shred',
                     ['Aquatic Form']='Breath', Prowl='Prowl', Rake='Rake',
                     ['Ferocious Bite']='Bite', Wrath='Wrath', Claw='Claw',
                     Regrowth='Regrowth', ['Healing Touch']='Heal',
                     ['Faerie Fire']='Faerie', Ravage='Ravage',
                     ['Abolish Poison']='Poison', ['Remove Curse']='Curse',
                     ['Frenzied Regeneration']='Regen', Rejuvenation='Rejuv',
                     ["Tiger's Fury"]='Fury', ['Mark of the Wild']='Mark'}; },
        HUNTER = {
            Icons = {["Aspect of the Hawk"]='Hawk', ["Hunter's Mark"]='Mark',
            		 ["Serpent Sting"]='Serpent', ["Arcane Shot"]='Arcane',
            		 ["Aimed Shot"]='Aimed', ["Viper Sting"]='Viper',
            		 ["Raptor Strike"]='Raptor', ["Wing Clip"]='Clip',
            		 ["Auto Shot"]='Auto', ["Concussive Shot"]='Concussive',
            		 ["Call Pet"]='Call', ["Feed Pet"]='Feed', ["Mend Pet"]='Mend',
            		 ["Revive Pet"]='Revive', ["Feign Death"]='Feign',
            		 ["Aspect of the Monkey"]='Monkey', Intimidation='Intim'}; },
        MAGE = { DS='Counter';
            Buf = {'Armor','FrostArmor',false; 'Intellect','MagicalSentry',true};
            Icons = {["Frost Armor"]='Armor', ["Ice Armor"]='Armor', Shoot='Shoot',
            		 ["Remove Lesser Curse"]='Curse', Counterspell='Counter',
            		 ["Mana Shield"]='Shield', Frostbolt='Frostbolt',
            		 Fireball='Fireball', Pyroblast='Pyroblast',
            		 ["Conjure Mana Agate"]='CMG', ["Conjure Mana Jade"]='CMG',
            		 ["Conjure Mana Citrine"]='CMG', ["Mana Agate"]='Gem',
            		 ["Mana Jade"]='Gem', ["Mana Citrine"]='Gem',
            		 ["Cone of Cold"]='Cone', ["Arcane Intellect"]='Intellect',
            		 ["Fire Blast"]='Blast', ["Arcane Missiles"]='Missiles',
            		 ["Conjure Water"]='Water', ["Conjure Food"]='Bread'}; },
        PALADIN = { DS='Hammer';
            Buf = {'Might','FistOfJustice',true};
            Icons = {['Blessing of Might']='Might', Judgement='Judge',
                     ['Flash of Light']='Flash', Exorcism='Exorcism',
                     ['Blessing of Protection']='Prot', Cleanse='Magic',
                     ['Hammer of Justice']='Hammer', Consecration='Cons',
                     ['Seal of Justice']='Justice', ['Lay on Hands']='Hands',
                     ['Holy Shock']='Shock', ['Seal of Righteousness']='Right',
                     ['Divine Shield']='Divine', ['Divine Protection']='Divine',
                     ['Holy Light']='Heal', ['Seal of Light']='Light'}; },
        PRIEST = { DS='Silence'; HoT={'Renew','Renew'};
            Buf = {'Fort','Fortitude',true; 'Spirit','DivineSpirit',true;
            		'Shadow','AntiShadow',true; 'IFire','InnerFire',false};
            Icons = {['Power Word: Fortitude']='Fort', Smite='Smite',
            		 ['Inner Fire']='IFire', ['Abolish Disease']='Disease',
                     ['Shadow Word: Pain']='Pain', Silence='Silence',
                     ['Shadow Protection']='Shadow', Feedback='Feedback',
                     ['Power Word: Shield']='Shield', Renew='Renew',
                     ['Vampiric Embrace']='Vampiric', Shoot='Shoot',
                     ['Mana Burn']='Burn', ['Holy Fire']='HFire',
                     ['Devouring Plague']='Plague', Heal='Heal',
                     ['Desperate Prayer']='Prayer', Fear='Fear',
                     ['Mind Blast']='Blast', ['Lesser Heal']='Heal',
                     ['Inner Focus']='Focus', ['Divine Spirit']='Spirit',
                     ['Psychic Scream']='Scream', ['Mind Flay']='Flay',
                     ['Touch of Weakness']='Weakness' }; },
        ROGUE = { Prep={Act='Stealth',Buf='Ambush'}; DS='Kick';
            Icons = {Eviscerate='Evis', Riposte='Rip', Garrote='Garrote',
            		 Backstab='Stab', Stealth='Stealth', Gouge='Gouge',
            		 ['Shoot Crossbow']='Shoot', Evasion='Evasion',
            		 ['Shoot Bow']='Shoot', ['Shoot Gun']='Shoot', Throw='Shoot',
                     ['Sinister Strike']='Strike', ['Ghostly Strike']='Ghost',
                     Ambush='Ambush', ['Cheap Shot']='Stun', Kick='Kick'}; },
        SHAMAN = { DS='Shock';
            Buf = {'Shield','gShield',false; 'Weapon','Main',false};
            Icons = {['Lightning Bolt']='Bolt', ['Rockbiter Weapon']='Weapon',
                     ['Cure Poison']='Poison', ['Lightning Shield']='Shield',
                     ['Frost Shock']='Frost', ['Flame Shock']='Flame', Purge='Purge',
                     ['Searing Totem']='Searing', ['Healing Wave']='Heal',
                     ['Unending Breath']='Breath', ['Cure Disease']='Disease',
                     ['Stoneskin Totem']='Stone', ['Earth Shock']='Earth'}; },
        WARLOCK = {
            Buf = {'Armor','RagingScream',false};
            Icons = {["Demon Skin"]='Armor', ["Demon Armor"]='Armor',
            		 ["Siphon Life"]='Siphon', Immolate='Immolate',
            		 ['Unending Breath']='Breath', ["Life Tap"]='Tap',
            		 ["Shadow Bolt"]='Bolt', ["Curse of Weakness"]='Weakness',
            		 ["Escape Artist"]='Escape', Corruption='Corruption',
            		 ["Death Coil"]='Coil', ["Howl of Terror"]='Howl', Fear='Fear',
            		 ["Dark Pact"]='Pact', ["Curse of Agony"]='Agony', Shoot='Shoot',
            		 ["Drain Life"]='DrainLife', ["Drain Mana"]='DrainMana'}; },
        WARRIOR = { DS='Bash';
            Buf = {'BShout', 'BattleShout',false};
            Icons = {['Heroic Strike']='Strike', ['Shield Bash']='Bash',
                     Charge='Charge', Hamstring='Slow', Rend='Rend',
                     ['Sunder Armor']='Sunder', Bloodrage='Rage',
                     Execute='Exec', ['Battle Shout']='BShout',
                     Disarm='Disarm', Revenge='Revenge', Slam='Slam',
                     ['Intimidating Shout']='IShout', Throw='Shoot',
                     ['Shoot Crossbow']='Shoot', Overpower='Overpower',
            		 ['Shoot Bow']='Shoot', ['Shoot Gun']='Shoot'}; },
	}

-- Action tables by race
AutoAttack_Race_Actions = {
        Dwarf = {Stoneform='Stoneform' },
        Gnome = {['Escape Artist']='Escape' },
        Human = {Perception='Perception' },
        NightElf = {Shadowmeld='Shadowmeld' },
        Orc = {['Blood Fury']='Fury' },
        Tauren = {['War Stomp']='Stomp' },
        Troll = {Berserking='Berserking' },
        Undead = {Cannibalize='Cannibalize' },
	}
-- UnitRace("player")

AA_Help = { ['?'] = 'AutoAttack';
	aa = { ['?'] = "The main chat command",
		  debug = "Toggle debug action trace",
		  scan = "Rescan the action bars",
		  slot = "Display action to slot mapping",
		  immune = "Display recorded immunities" };
	aause = { ['?'] = "Manage which actions are used",
		  [''] = "List the known actions",
		  ['<name>'] = "Disable/Enable action <name>" };
	aafeed = { ['?'] = "Manage hunter pet feeding",
		  [''] = "Select food for your pet",
		  off = "Stop feeding you pet" };
	}
