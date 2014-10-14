-- Binding Configuration
BINDING_HEADER_ARMORCRAFT    = "ArmorCraft"
BINDING_NAME_ARMORCRAFTFRAME = "Toggle ArmorCraft window"

-- Armor types
AC_CLOTH   = 'Cloth'
AC_LEATHER = 'Leather'
AC_MAIL    = 'Mail'
AC_PLATE   = 'Plate'
AC_SHIELD  = 'Shield'
AC_SHIELDS = 'Shields'

-- Player classes
AC_DRUID   = 'Druid'
AC_HUNTER  = 'Hunter'
AC_MAGE    = 'Mage'
AC_PALADIN = 'Paladin'
AC_PRIEST  = 'Priest'
AC_ROGUE   = 'Rogue'
AC_SHAMAN  = 'Shaman'
AC_WARLOCK = 'Warlock'
AC_WARRIOR = 'Warrior'

-- Mappings
ArmorCraft_Types = {AC_CLOTH,AC_LEATHER,AC_SHIELD,AC_MAIL,AC_PLATE}
ArmorCraft_TS = {Blacksmithing=AC_MAIL, Leatherworking=AC_LEATHER, Tailoring=AC_CLOTH, Engineering=AC_CLOTH}
ArmorCraft_Class = {[AC_MAGE]=AC_CLOTH; [AC_PRIEST]=AC_CLOTH; [AC_WARLOCK]=AC_CLOTH;
                    [AC_DRUID]=AC_LEATHER; [AC_ROGUE]=AC_LEATHER; [AC_HUNTER]=AC_LEATHER;
                    [AC_SHAMAN]=AC_LEATHER; [AC_PALADIN]=AC_MAIL; [AC_WARRIOR]=AC_MAIL}
ArmorCraft_Class2 = {[AC_HUNTER]=AC_MAIL; [AC_SHAMAN]=AC_MAIL; [AC_PALADIN]=AC_PLATE; [AC_WARRIOR]=AC_PLATE}
ArmorCraft_Dual = {[AC_HUNTER]=20; [AC_ROGUE]=10; [AC_WARRIOR]=20}

-- Armor location names and IDs
AC_MAIN   = 'Main Hand'
AC_ONE    = 'One-Hand'
AC_TWO    = 'Two-Hand'
AC_OFF    = 'Off Hand'
AC_HELD   = 'Held In Off-hand'
AC_RANGED = 'Ranged'
AC_BACK   = 'Back'
AC_NECK   = 'Neck'
AC_FINGER = 'Finger'
AC_TRINKET= 'Trinket'
AC_MHSLOT = 'MainHandSlot'
AC_SHSLOT = 'SecondaryHandSlot'
ArmorCraft_Loc= {Head={slot='HeadSlot',ID=1}; Shoulder={slot='ShoulderSlot',ID=2}; [AC_BACK]={slot='BackSlot',ID=3};
                Chest={slot='ChestSlot',ID=4}; Wrist={slot='WristSlot',ID=5}; Hands={slot='HandsSlot',ID=6};
                Waist={slot='WaistSlot',ID=7}; Legs={slot='LegsSlot',ID=8}; Feet={slot='FeetSlot',ID=9};
                [AC_MAIN]={slot=AC_MHSLOT,slot1=AC_SHSLOT,ID=10}; [AC_OFF]={slot=AC_SHSLOT}; [AC_HELD]={slot=AC_SHSLOT};
                [AC_RANGED]={slot='RangedSlot',ID=11}; [AC_TRINKET]={slot='Trinket0Slot',slot1='Trinket1Slot'};
                [AC_NECK]={slot='NeckSlot'}; [AC_FINGER]={slot='Finger0Slot',slot1='Finger1Slot'}; };

-- Armor attribute values
AC_OTHER = 'Other'
ArmorCraft_Attr = {[AC_MAGE]={ Agility=3, Intellect=3, Spirit=3, Stamina=3, Strength=1, [AC_OTHER]=1 };
                 [AC_PRIEST]={ Agility=3, Intellect=3, Spirit=3, Stamina=3, Strength=1, [AC_OTHER]=1 };
                [AC_WARLOCK]={ Agility=3, Intellect=3, Spirit=2, Stamina=2, Strength=1, [AC_OTHER]=1 };
                  [AC_DRUID]={ Agility=4, Intellect=2, Spirit=3, Stamina=3, Strength=2, [AC_OTHER]=1 };
                  [AC_ROGUE]={ Agility=7, Intellect=1, Spirit=2, Stamina=3, Strength=3, [AC_OTHER]=1 };
                 [AC_HUNTER]={ Agility=6, Intellect=2, Spirit=2, Stamina=2, Strength=2, [AC_OTHER]=1 };
                 [AC_SHAMAN]={ Agility=4, Intellect=2, Spirit=3, Stamina=3, Strength=3, [AC_OTHER]=1 };
                [AC_PALADIN]={ Agility=5, Intellect=2, Spirit=2, Stamina=3, Strength=4, [AC_OTHER]=1 };
                [AC_WARRIOR]={ Agility=5, Intellect=1, Spirit=1, Stamina=3, Strength=4, [AC_OTHER]=1 }}

-- Item use text
AC_ENG    = 'Engineering'
AC_ARMOR  = 'Armor'
AC_WEAPON = 'Weapon'
AC_MELEE  = 'Melee'
AC_GUN    = 'Gun'
AC_GUNS   = 'Guns'
AC_DEVICE = 'Devices'
AC_MISC   = 'Miscellaneous'
AC_FISH   = 'Fishing Poles'
AC_1H     = {f='One%-Handed',r='1-H'}
AC_2H     = {f='Two%-Handed',r='2-H'}
AC_SHOOT  = {[AC_HUNTER]=1; [AC_ROGUE]=1; [AC_WARRIOR]=1}
AC_MAGIC  = {[AC_MAGE]=1; [AC_PRIEST]=1; [AC_WARLOCK]=1}
ArmorCraft_Ranged = {Bows=AC_SHOOT; Crossbows=AC_SHOOT; [AC_GUNS]=AC_SHOOT; Wands=AC_MAGIC}
ArmorCraft_Melee = {["One-Handed Axes"]={[AC_HUNTER]=1; [AC_PALADIN]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Two-Handed Axes"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["One-Handed Maces"]={[AC_DRUID]=1; [AC_PALADIN]=1; [AC_PRIEST]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Two-Handed Maces"]={[AC_DRUID]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Polearms"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["One-Handed Swords"]={[AC_HUNTER]=1; [AC_MAGE]=1; [AC_PALADIN]=1; [AC_ROGUE]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1};
    ["Two-Handed Swords"]={[AC_HUNTER]=2; [AC_PALADIN]=2; [AC_WARRIOR]=2};
    ["Staves"]={[AC_DRUID]=2; [AC_HUNTER]=2; [AC_MAGE]=2; [AC_PRIEST]=2; [AC_SHAMAN]=2; [AC_WARLOCK]=2; [AC_WARRIOR]=2};
    ["Fist Weapons"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARRIOR]=1};
    ["Daggers"]={[AC_DRUID]=1; [AC_HUNTER]=1; [AC_MAGE]=1; [AC_PRIEST]=1;
                 [AC_ROGUE]=1; [AC_SHAMAN]=1; [AC_WARLOCK]=1; [AC_WARRIOR]=1}}

-- Messages
ARMORCRAFT_NOWINDOW = "No trade skill window open."
ARMORCRAFT_NOTARMOR = " does not craft armor."
ARMORCRAFT_BADLEVEL = "Level must be between 1 and 60."
ARMORCRAFT_NOSELECT = "No selection for "
ARMORCRAFT_NOCLASS  = "No character class selected."
ARMORCRAFT_NOITEM   = "No craft item selected."
ARMORCRAFT_CLASS    = "Attribute values for %s class."
ARMORCRAFT_RESET    = " value reset."
ARMORCRAFT_SKIP     = "Skipping craft selection "
ARMORCRAFT_EMPTY    = "Empty item value list."
ARMORCRAFT_BADFORMAT= "Bad value format: "
ARMORCRAFT_UNDEFINED= "Undefined name: "
ARMORCRAFT_WRONG    = "Wrong item type to compare."
ARMORCRAFT_ACTIP    = "Click to toggle ArmorCraft windows."
ARMORCRAFT_USETIP   = "Click to compare the selected item."
ARMORCRAFT_PARTYTIP = "Click to toggle Party members."
AC_PARTY  = "Party"
AC_LEVEL  = "Level"
AC_CLASS  = "Class"
AC_SELECT = "Select"

-- Tooltip text
ARMORCRAFT_BOE      = "Binds when equipped"
ARMORCRAFT_BOP      = "Binds when picked up"
ARMORCRAFT_SOULBOUND= "Soulbound"
ARMORCRAFT_UNIQUE   = "Unique"
ARMORCRAFT_ARMOR    = "^(%d+) Armor"
ARMORCRAFT_REQUIRES = "^Requires Level (%d+)"
ARMORCRAFT_DPS      = "^%((%d+%.%d) damage per second%)"

-- Help text
AC_Help = { ['?'] = 'Armorcraft';
	ac = { ['?'] = "The main chat command",
		[''] = "Toggle the ArmorCraft window",
		['<name>'] = "Change the AC target to <name>", };
	acv = { ['?'] = "Manage custom values",
		[''] = "Display the attribute values for the current class",
		default = "Reset the values to the defaults",
		list = "List the custom armor values",
		['0'] = "Delete the custom armor value for the current craft item",
		['<value>'] = "Set the custom armor value for the current craft item",
		['<attr>=<value>'] = "Sets <attr> weighting to <value>", };
	}