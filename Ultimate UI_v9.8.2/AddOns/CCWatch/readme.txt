Description :

CCWatch displays up to 5 progress bar for :
[Rogue] - Cheap Shot, Kidney Shot, Gouge, Blind and Sap
[Mage] - Polymorph, Frost Nova, Frost Bite, Ice Block
[Priest] - Shackle Undead, Blackout, Psychic Scream
[Druid] - Hibernate, Entangling Roots, Pounce, Feral Charge, Improved Starfire
[Hunter] - Freezing Trap, Improved Concussive Shot, Scare Beast, Scatter Shot, Intimidation
[Paladin] - Hammer of Justice, Repentance, Turn Undead
[Warlock] - Seduce, Fear, Banish, Death Coil, Howl of Terror
[Warrior] - Intercept, Mace Specialization, Improved Hamstring, Intimidating Shout, Improved Revenge, Concussion Blow
[Tauren] - War Stomp (perhaps I could have avoided this one ^^)
[Misc] - Sleep effect (from Green Whelp Armour)

CCWatch tracks character crowd control effects applied to your current target only (not anything near you)...

--

And yes, it is of course just a mod of the excellent Vector's StunWatch :
http://www.curse-gaming.com/mod.php?addid=886

Based on StunWatch 2.3a (with corrected CHAT_MSG_SPELL_BREAK_AURA event).

--

CCWatch : Usage - /ccw option
options:
on : Enables CCWatch
off : Disables CCWatch
lock : Locks CCWatch and enables
unlock : Allows you to move CCWatch
u : Update improved skill ranks
print : Prints the current configuration
invert : Invert progress bar direction
alpha  : Set bar alpha, use 0 to 1
scale  : Scale CCWatch, use 0.25 to 3.0
grow   : Set bar growth up, down or off
config : Show up the User Interface
timers : Set timers display off, on or rev (reversed)


--------------

Changes :
1800.5 :
- DE : fixed the string "regexpization". Should not trigger anymore "Does not compute" message [thanks to garex for pointing the problem]
- EN : fixed "Frost Bite" to "Frostbite" [thanks to harze2k]
- EN : fixed "Intercept" effect to "Intercept Stun" [thanks to error.ini]
- EN : fixed "Freezing Trap" to "Freezing Trap Effect" [thanks to mooseman]
- FR : fixed "Piège givrant" to "Effet Piège givrant"
- fixed Arcanist' Set checkbox setting should be correctly loaded.
- fixed Warrior's "Concussion Blow" length from 3 to 5 [thanks error.ini]
- changed Warlock's "Howl of Terror" & "Death Coil" bar number [thanks to Xtremal]
- lightened the saved variables : should avoid systematic "/ccwatch clear" between updates

1800.4 :
- correction of a potential problem on spell "recast" (in case of sheep target change for instance)
- EN : fixed "Shackle Undead" typo [thanks to dodgizzla]
- FR : correction de l'effet de la compétence guerrier "Interception" en "Bloquer Etourdissement"
- shared Diminishing Return for Fear & Seduce [thanks to Aalto for pointing this]
- added Warlock "Howl of Terror" & "Death Coil" [suggested by Aalto]
- added Warrior "Intimidating Shout", "Concussion Blow" & "Improved Revenge"
- added Green Whelp Armour effect [spelling ("Sleep") to confirm]
(-added Psychic Scream to the addon description. Has always been there)

1800.3 :
- corrected a minor SW problem regarding effect unqueueing [side effect detected thanks to Freak_Kitchen]
- fixed UI inconsistency with command line options
- tried to correct Diminishing Returns code [thanks to Stanz for pointing the problem]
- added optional timers [suggested by naetharion & Chanir]
- added Mage's frost spec "Ice Block" support (ie: if a targetted mage cast it on himself) [suggested by Puney]
- added specific Mage option for Arcanist' set Polymorph bonus [suggested by Freak_Kitchen]
- added support for spell recast (ie: multi sheep)

1800.2 :
- display 2 missing help lines
- french translation of those missing lines
- added hunter beast spec "Intimidation" skill
- added capability to select which class CC to handle
- added UI to configure CCWatch
- splitted the localization file to ease translation

1800.1 :
- CCWatch creation, based upon StunWatch 2.3a by Vector (http://www.curse-gaming.com/mod.php?addid=886)
- Corrected StunWatch AURABREAK handling error
- removed the specific 'g', 'k' & 's' options to add a general 'u' option
