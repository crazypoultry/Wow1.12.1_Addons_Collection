SmartExplosives v0.3
Created by ScepraX.

"The purpose of this mod is to help engineers to easily create explosions."
This mod works through commands, macros and keybindings. It has no nice interface or extensions for other mods.

----------------------------------------------------------------
WHAT IS THIS MOD USED FOR?
----------------------------------------------------------------
This mod is meant for engineers to easily use their created explosives.
This mod has several functions for that. Main function include:
	- A smart explosive function that will pick the best explosive out of user defined categories.
	- A couple of functions to pick a explosive out of a specific category.
	- Commands to select the explosive to use in the smart function.
	
Categories:
	- Dynamite: Includes all engineer and non-engineer dynamites. Basically includes all raw explosives.
	- Bombs and Grenades: Includes all engineer made bombs and grenades, except the Arcane Bomb. This category includes only stunning explosives.
	- Charges: Includes all engineer made charges.
	- Other: This catergory includes:
- Explosive Sheep: Summons an Explosive Sheep which will charge at a nearby enemy and explode for 135 to 165 damage. Lasts for 3 min or until it explodes.
- Flash Bomb: Causes all Beasts in a 5 yard radius to run away for 10 sec.
- Goblin Land Mine: Places the Goblin Land Mine on the ground. It will explode for 394 to 506 fire damage the next time a hostile creature passes near it. The mine has a duration of 1 min.
- Goblin Sapper Charge: Explodes when triggered dealing 450 to 750 Fire damage to all enemies nearby and 375 to 625 damage to you.
- Arcane Bomb: Drains 675 to 1125 mana from those in the blast radius and does 50% of the mana drained in damage to the target. Also Silences targets in the blast for 5 sec.

By default the smart function only uses explosives from the first 2 categories.
Reason for this is that charges are only used for locks and explosives from the other categorie are too specific in their use. (No use throwing an Arcane Bomb to a warrior.)

Withing the other category any of the items can be disabled using commands. This has effect both on the smart function and abnormal function.

----------------------------------------------------------------
USING THE MOD!
----------------------------------------------------------------
There are three ways:
1. Go to your key bindings, scroll all the way down to the header Smart Explosives... should be near the 'S'. Choose a key and of you go.
2. Type "/se boom" or "/se se".
3. Type "/macro", make a new macro, put in the text at number 2, place it in one of your hotbars. And voila.

----------------------------------------------------------------
BRIEF OVERVIEW CLASHCOMMANDS
----------------------------------------------------------------	
A brief view on the commands (mainly meant to be used in macros):
/se or /smartexplosives - Displays this list with commands.
/se smartexplosives or /se smart or /se boom - Will select the best explosive out of a selection (settable with commands beneath).
/se dyna or /se dynamite - Will select the best dynamite.
/se bomb or /se grenade - Will select the best bomb or grenade (Not arcane bombs).
/se charge - Will select the best charge.
/se abnormal or /se other or /se sheep or /se landmine - Will select the best abnormal explosive and will in some cases instantly use it. For more information about this category see the readme.

/se usedynamite - When enabled allows the smart function to select dynamite. When disabled the smart function will never select dynamite. (Default is on.)
/se usebombs or /se usegrenades - Same as above but now for bombs and grenades. (Default is on.)
/se usecharges - Once again the same as above, but now for charges. (Default is off.)
/se useabnormal or /se useother - Same as above but now for the remaining explosives. (Default is off.)

/se usesheeps - Self-explanatory (Default is on.)
/se useflashbombs - Self-explanatory (Default is off.)
/se uselandmines - Self-explanatory (Default is on.)
/se usesappercharges - Self-explanatory (Default is on.)
/se usearcanebombs - Self-explanatory (Default is on.)

/se text - Display or don't display the messages in the chatframe. (Default is on.)
/se debug - (De)Activates debug mode. (Default is off.)
/se status - Prints all saved variables.
/se default or /se reset - Resets all saved variables to their default values.
----------------------------------------------------------------	
ENJOY!
----------------------------------------------------------------
Don't forget to open your engineering window before using this mod!
